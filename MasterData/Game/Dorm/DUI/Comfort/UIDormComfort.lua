local UIDormComfort = class("UIDormComfort", UIBaseWindow)
local base = UIBaseWindow
local UINDormComfortItem = require("Game.Dorm.DUI.Comfort.UINDormComfortItem")
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local DormComfortTextFunc = {
  [eLogicType.DungeonRewardExtraNum] = function(para1s, para2s, para3s)
    local des = ""
    for k, para1 in ipairs(para1s) do
      local logicText = string.format(ConfigData:GetTipContent(2046), para1)
      if string.IsNullOrEmpty(des) then
        des = logicText
      else
        des = des .. "\n" .. logicText
      end
    end
    return des
  end,
  [eLogicType.FriendshipBonus] = function(para1s, para2s, para3s)
    local des = ""
    for k, para1 in ipairs(para1s) do
      local logicText = string.format(ConfigData:GetTipContent(2045), para1)
      if string.IsNullOrEmpty(des) then
        des = logicText
      else
        des = des .. "\n" .. logicText
      end
    end
    return des
  end,
  [eLogicType.DailyFixedOutput] = function(para1s, para2s, para3s)
    local des = ""
    local timeDic = {}
    for k, para1 in ipairs(para1s) do
      local para2 = para2s and para2s[k] or nil
      local para3 = para3s and para3s[k] or nil
      if timeDic[para1] == nil then
        timeDic[para1] = {}
      end
      table.insert(timeDic[para1], {para2, para3})
    end
    for time, paras in pairs(timeDic) do
      local hour = time // 100
      local minute = time % 100
      local logicText = string.format(ConfigData:GetTipContent(2043), tostring(hour), tostring(minute))
      for _, para23 in ipairs(paras) do
        local para2 = para23[1]
        local para3 = para23[2]
        local itemName
        local itemCfg = ConfigData.item[para2]
        if itemCfg ~= nil then
          itemName = LanguageUtil.GetLocaleText(itemCfg.name)
        end
        logicText = logicText .. "\n" .. string.format(ConfigData:GetTipContent(2044), itemName, tostring(para3))
      end
      if string.IsNullOrEmpty(des) then
        des = logicText
      else
        des = des .. "\n" .. logicText
      end
    end
    return des
  end
}

function UIDormComfort:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnCloseClicked)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnCloseClicked)
  self.ui.comfortLvItem:SetActive(false)
  self.comfortItemPool = UIItemPool.New(UINDormComfortItem, self.ui.comfortLvItem)
  self.__ReqComfortRewardPick = BindCallback(self, self.ReqComfortRewardPick)
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
end

function UIDormComfort:InitDormComfortUI(dormRoomData)
  local dormBriefData = PlayerDataCenter.dormBriefData
  if dormBriefData == nil then
    return
  end
  self:RefreshComfortBaseInfo(dormBriefData, dormRoomData)
  self:InitDormComfortList(dormBriefData)
  self:RefreshComfortTotalLogic(dormBriefData)
end

function UIDormComfort:RefreshComfortBaseInfo(dormBriefData, dormRoomData)
  local curLevel, maxLevel = dormBriefData:GetDormComfortLevel()
  if curLevel <= 10 then
    self.ui.tex_Level:SetIndex(0, tostring(curLevel))
  else
    self.ui.tex_Level:SetIndex(1, tostring(curLevel))
  end
  if dormRoomData == nil then
    self.ui.currRoomComfort:SetActive(false)
  else
    self.ui.currRoomComfort:SetActive(true)
    self.ui.tex_CurrRoomComfort.text = tostring(dormRoomData:GetComfort())
  end
  local hisComfort = dormBriefData:HistoryMaxComfort()
  local nextComfort = 0
  if maxLevel <= curLevel then
    local maxLevelCfg = ConfigData.dorm_comfort[maxLevel]
    nextComfort = maxLevelCfg.comfort
    hisComfort = nextComfort
  else
    local nextLevelCfg = ConfigData.dorm_comfort[curLevel + 1]
    nextComfort = nextLevelCfg.comfort
  end
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  local curComfort = dormCtrl.allDormData:GetTotalComfort()
  self.ui.img_ComfortBar.value = curComfort / nextComfort
  self.ui.tex_TotalComfort:SetIndex(0, tostring(curComfort), tostring(nextComfort))
end

function UIDormComfort:InitDormComfortList(dormBriefData)
  self.comfortItemPool:HideAll()
  for _, level in pairs(ConfigData.dorm_comfort.level_sort) do
    local comfortLevelCfg = ConfigData.dorm_comfort[level]
    local isPicked = dormBriefData:IsDormComfortPicked(comfortLevelCfg.level)
    if #comfortLevelCfg.rewardIds > 0 and not isPicked then
      local comfortItem = self.comfortItemPool:GetOne()
      comfortItem:InitDormComfortItem(comfortLevelCfg, dormBriefData, self.__ReqComfortRewardPick)
    end
  end
  for _, level in pairs(ConfigData.dorm_comfort.level_sort) do
    local comfortLevelCfg = ConfigData.dorm_comfort[level]
    local isPicked = dormBriefData:IsDormComfortPicked(comfortLevelCfg.level)
    if #comfortLevelCfg.rewardIds > 0 and isPicked then
      local comfortItem = self.comfortItemPool:GetOne()
      comfortItem:InitDormComfortItem(comfortLevelCfg, dormBriefData, self.__ReqComfortRewardPick)
    end
  end
end

function UIDormComfort:RefreshComfortTotalLogic(dormBriefData)
  local curLevel, maxLevel = dormBriefData:GetDormComfortLevel()
  local cfg = ConfigData.dorm_comfort[curLevel]
  local logicDic = {}
  local logicIds = {}
  local logicIdDic = {}
  for index, logic in ipairs(cfg.logic) do
    local para1, para2, para3 = cfg.para1[index], cfg.para2[index], cfg.para3[index]
    CommonLogicUtil.MergeLogic(logicDic, logic, {
      para1,
      para2,
      para3
    })
    if not logicIdDic[logic] then
      logicIdDic[logic] = true
      table.insert(logicIds, logic)
    end
  end
  table.sort(logicIds, function(a, b)
    return b < a
  end)
  local des = ""
  for _, logic in ipairs(logicIds) do
    local paraTab = logicDic[logic]
    local para1Array = paraTab[1]
    local para2Array = paraTab[2]
    local para3Array = paraTab[3]
    if DormComfortTextFunc[logic] ~= nil then
      local logicText = DormComfortTextFunc[logic](para1Array, para2Array, para3Array)
      if string.IsNullOrEmpty(des) then
        des = logicText
      else
        des = des .. "\n" .. logicText
      end
    end
  end
  self.ui.tex_TotalAddition.text = des
end

function UIDormComfort:ReqComfortRewardPick(comfortLevelCfg, comfortItem)
  local dormNetwork = NetworkManager:GetNetwork(NetworkTypeID.Dorm)
  dormNetwork:CS_DORM_PickConfortRewards(comfortLevelCfg.level, function()
    comfortItem:RefreshDormComfortItem(PlayerDataCenter.dormBriefData)
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseList(comfortLevelCfg.rewardIds, comfortLevelCfg.rewardNums)
      window:AddAndTryShowReward(CRData)
    end)
  end)
end

function UIDormComfort:BackAction()
  self:Delete()
end

function UIDormComfort:OnCloseClicked()
  UIUtil.OnClickBackByUiTab(self)
end

function UIDormComfort:OnDelete()
  base.OnDelete(self)
end

return UIDormComfort
