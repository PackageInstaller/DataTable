local UIEventNoviceSignII = class("UIEventNoviceSignII", UIBaseWindow)
local base = UIBaseWindow
local UINEventNoviceSignItemII = require("Game.EventNoviceSign.UI.UINEventNoviceSignItemII")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function UIEventNoviceSignII:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_close, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_backGround, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_AwardDetail, self, self.OnClickPreLook)
  UIUtil.AddButtonListener(self.ui.btn_Sign, self, self.OnClickSign)
  self._dayItemPool = UIItemPool.New(UINEventNoviceSignItemII, self.ui.obj_dayItem)
  self.ui.obj_dayItem:SetActive(false)
  self._awardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount:SetActive(false)
  self._defaultSignClolor = self.ui.img_Sign.color
end

function UIEventNoviceSignII:InitNoviceSign(id, isShowCloseBtn)
  self.ui.btn_close.gameObject:SetActive(isShowCloseBtn or false)
  self.ui.btn_backGround.gameObject:SetActive(isShowCloseBtn or false)
  self.data = PlayerDataCenter.eventNoviceSignData.dataDic[id]
  self.data:SetPoped()
  local list = {}
  for k, v in pairs(self.data.awardCfg) do
    table.insert(list, v)
  end
  table.sort(list, function(a, b)
    return a.day < b.day
  end)
  local totalDays = #list
  local mainRewardDic = {}
  self._dayItemPool:HideAll()
  for i = 1, totalDays - 1 do
    local item = self._dayItemPool:GetOne()
    local awardCfg = list[i]
    local itemId, itemCount = self:__GetOneAndRecordAllItem(awardCfg, awardCfg.extra_sign_award, mainRewardDic, true)
    item:InitNoviceSignItemII(i, itemId, itemCount)
  end
  local finalAwardCfg = list[totalDays]
  self:__GetOneAndRecordAllItem(finalAwardCfg, nil, mainRewardDic, nil)
  self._awardItemPool:HideAll()
  for i, itemId in ipairs(finalAwardCfg.awardIds) do
    if itemId ~= finalAwardCfg.extra_sign_award then
      local item = self._awardItemPool:GetOne()
      local itemCfg = ConfigData.item[itemId]
      local itemCount = finalAwardCfg.awardCounts[i]
      item:InitItemWithCount(itemCfg, itemCount)
    end
  end
  self.ui.itemList:SetActive(false)
  self.ui.img_AwardDetail:SetIndex(0)
  local mainRewardIdList = {}
  for itemId, itemCount in pairs(mainRewardDic) do
    table.insert(mainRewardIdList, itemId)
  end
  table.sort(mainRewardIdList, function(a, b)
    local aItemCfg = ConfigData.item[a]
    local bItemCfg = ConfigData.item[b]
    local aIsHero = aItemCfg.type == eItemType.HeroCard
    local bIsHero = bItemCfg.type == eItemType.HeroCard
    if aIsHero ~= bIsHero then
      return aIsHero
    end
    return a < b
  end)
  local mainRewardStr = ""
  local mainRewardIdListCount = #mainRewardIdList
  for i, itemId in ipairs(mainRewardIdList) do
    local itemCount = mainRewardDic[itemId]
    if 1 < itemCount then
      mainRewardStr = mainRewardStr .. ConfigData:GetItemName(itemId) .. "x" .. tostring(itemCount)
    else
      mainRewardStr = mainRewardStr .. ConfigData:GetItemName(itemId)
    end
    if i < mainRewardIdListCount then
      mainRewardStr = mainRewardStr .. "、"
    end
  end
  self.ui.texNoviceSign:SetIndex(0, mainRewardStr)
  self:RefreshNoviceSign()
end

function UIEventNoviceSignII:RefreshNoviceSign()
  local hasSignTimes = self.data:GetEventSignTimes()
  local allowSign = self.data:IsAllowReceive()
  local curSignDay = allowSign and hasSignTimes + 1 or hasSignTimes
  for day, dayItem in ipairs(self._dayItemPool.listItem) do
    dayItem:SetNoviceSignItemIIReviced(day <= hasSignTimes)
  end
  local awardCfg = self.data.awardCfg[curSignDay]
  local extraItemId, extraItemCount = self:__GetOneAndRecordAllItem(awardCfg, awardCfg.extra_sign_award, nil, false)
  self.ui.itemIcon.sprite = CRH:GetSpriteByItemId(extraItemId)
  self.ui.tex_ItemWithCount:SetIndex(0, ConfigData:GetItemName(extraItemId), tostring(extraItemCount))
  self.ui.img_Sign.color = allowSign and self._defaultSignClolor or self.ui.color_signed
  self.ui.obj_Received:SetActive(not allowSign)
  self.ui.tex_sign:SetIndex(allowSign and 0 or 1)
  self.ui.effect_sign:SetActive(allowSign)
end

function UIEventNoviceSignII:SetCloseCallback(callback)
  self.closeCallback = callback
end

function UIEventNoviceSignII:__GetOneAndRecordAllItem(awardCfg, itemId, recordDic, invertSelection)
  local selectId, selectCount
  for i, awardItemId in ipairs(awardCfg.awardIds) do
    if selectId == nil and (invertSelection and awardItemId ~= itemId or not invertSelection and awardItemId == itemId) then
      selectId = awardItemId
      selectCount = awardCfg.awardCounts[i]
      if recordDic == nil then
        break
      end
    end
    if recordDic ~= nil and awardCfg.main_sign_award[awardItemId] ~= nil then
      local count = recordDic[awardItemId] or 0
      count = count + awardCfg.awardCounts[i]
      recordDic[awardItemId] = count
    end
  end
  return selectId, selectCount
end

function UIEventNoviceSignII:OnClickPreLook()
  local showPre = not self.ui.itemList.activeSelf
  self.ui.itemList:SetActive(showPre)
  self.ui.img_AwardDetail:SetIndex(showPre and 1 or 0)
end

function UIEventNoviceSignII:OnClickSign()
  if not self.data:IsAllowReceive() then
    return
  end
  NetworkManager:GetNetwork(NetworkTypeID.EventNoviceSign):CS_SIGNACTIVITY_Pick(self.data.id, function(objList)
    self:RefreshNoviceSign()
    if objList.Count == 0 then
      error("objList.Count == 0")
      return
    end
    local rewardDic = objList[0]
    local rewardIdList = {}
    local rewardNumList = {}
    for k, v in pairs(rewardDic) do
      table.insert(rewardIdList, k)
      table.insert(rewardNumList, v)
    end
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window ~= nil then
        local CRData = CommonRewardData.CreateCRDataUseList(rewardIdList, rewardNumList):SetCRHeroSnapshoot(self._heroIdSnapShoot)
        window:AddAndTryShowReward(CRData)
      end
    end)
  end)
end

function UIEventNoviceSignII:OnClickClose()
  self:Delete()
end

function UIEventNoviceSignII:OnDelete()
  if self.data ~= nil then
    self.data:SetPoped()
  end
  self._awardItemPool:DeleteAll()
  self._dayItemPool:DeleteAll()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  base.OnDelete(self)
end

return UIEventNoviceSignII
