local UINAchievementLevelNode = class("UINAchievementLevelNode", UIBaseNode)
local base = UIBaseNode
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local UINAchievementLevelItem = require("Game.Achievement.UI.AchieveLevelUI.UINAchievementLevelItem")
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_DoTween = CS.DG.Tweening.DOTween
local eLevelState = {
  UnCompleted = 1,
  Completed = 2,
  Picked = 3
}

function UINAchievementLevelNode:OnInit()
  self.achivLevelNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.AchivLevel)
  self.levelItemDic = {}
  self.levelDataList = {}
  self.isOpenDetail = false
  self.needRefresh = {
    need = false,
    isOpen = false,
    playTween = false
  }
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Detail, self, self.OnClickDetail)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.OnClickDetail)
  self.ui.loopList_playerLevelList.onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  self.ui.loopList_playerLevelList.onChangeItem = BindCallback(self, self.m_OnChangeItem)
  self.ui.tween_tileSliderNode.onRewind:AddListener(BindCallback(self, self.OnSwitchTweenRewind))
  self.__CanRefreshPlayerLevel = BindCallback(self, self.CanRefreshPlayerLevel)
  MsgCenter:AddListener(eMsgEventId.UpdatePlayerLevel, self.__CanRefreshPlayerLevel)
  MsgCenter:AddListener(eMsgEventId.UpdatePickedRewardLevel, self.__CanRefreshPlayerLevel)
  self.__NeedRefreshPlayerLevel = BindCallback(self, self.NeedRefreshPlayerLevel)
  self.__onGetLevelRewardComplete = BindCallback(self, self.GetLevelRewardComplete)
  MsgCenter:AddListener(eMsgEventId.GetAchivLevelRewardComplete, self.__onGetLevelRewardComplete)
  self._GetReward = BindCallback(self, self.GetReward)
  self.levelRewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.obj_rewardItem)
  self.ui.obj_rewardItem.gameObject:SetActive(false)
  self.ui.col_ExpBar = self.ui.Img_ExpBar.color
  self:RegistAndUpdateRedDot()
  self.listoffsetMin = self.ui.loopList_playerLevelList.gameObject.transform.offsetMin
  self.baroffsetMin = self.ui.scrollbar.transform.offsetMin
  UIUtil.AddButtonListener(self.ui.btn_ReceiveAll, self, self.OnClickReceiveAll)
end

function UINAchievementLevelNode:RegistAndUpdateRedDot()
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelReward)
  self.ui.obj_RedDot:SetActive(ok and node:GetRedDotCount() > 0)
  
  function self.redDotFunc(node)
    self.ui.obj_RedDot:SetActive(node:GetRedDotCount() > 0)
  end
  
  RedDotController:AddListener(node.nodePath, self.redDotFunc)
end

function UINAchievementLevelNode:OnClickDetail()
  self.ui.btn_Return.gameObject:SetActive(not self.isOpenDetail)
  self.ui.btn_Detail.gameObject:SetActive(self.isOpenDetail)
  self.ui.img_isSlideOn:SetActive(not self.isOpenDetail)
  if self.isOpenDetail then
    self.ui.tween_tileSliderNode:DOComplete()
    self.ui.tween_tileSliderNode:DOPlayBackwards()
    self.isOpenDetail = false
  else
    self.ui.obj_levelAddition:SetActive(true)
    self.ui.obj_levelList:SetActive(true)
    self.ui.tween_tileSliderNode:DORestart()
    self.isOpenDetail = true
    self:RefreshPlayerLevel(true)
  end
end

function UINAchievementLevelNode:OnSwitchTweenRewind()
  self.ui.obj_levelAddition:SetActive(false)
  self.ui.obj_levelList:SetActive(false)
end

function UINAchievementLevelNode:CanRefreshPlayerLevel(isOpen, playTween)
  self.needRefresh.need = true
  self.needRefresh.isOpen = isOpen
  self.needRefresh.playTween = playTween
end

function UINAchievementLevelNode:NeedRefreshPlayerLevel()
  if self.needRefresh.need then
    self:RefreshPlayerLevel(self.needRefresh.isOpen, self.needRefresh.playTween)
    self.needRefresh.need = false
  end
end

function UINAchievementLevelNode:RefreshPlayerLevel(isOpen, playTween)
  local maxLevel = ConfigData.game_config.playerMaxLevel
  local curLevel = PlayerDataCenter.playerLevel.level
  if curLevel < 10 then
    self.ui.tex_CurPlayerLevel:SetIndex(0, "0", tostring(curLevel))
  else
    self.ui.tex_CurPlayerLevel:SetIndex(0, "", tostring(curLevel))
  end
  if maxLevel <= curLevel then
    if self.processSeq ~= nil then
      self.processSeq:Kill()
      self.processSeq = nil
    end
    self.ui.tex_Progress:SetIndex(1)
    self.ui.Img_ExpBar.color = self.ui.col_ExpBar
    self.ui.Img_ExpBar.fillAmount = 1
  else
    local exp = PlayerDataCenter.playerLevel.exp
    local expCeiling = PlayerDataCenter.playerLevel:GetNextLevelExp()
    self.ui.tex_Progress:SetIndex(0, tostring(exp), tostring(expCeiling))
    if not isOpen and playTween then
      self:SetProcessTween(exp / expCeiling, 0.8)
    else
      self.ui.Img_ExpBar.color = self.ui.col_ExpBar
      self.ui.Img_ExpBar.fillAmount = exp / expCeiling
    end
  end
  self:m_RefreshNextLevelInfo(curLevel, maxLevel <= curLevel)
  if self.isOpenDetail then
    self:RefreshLevelList(maxLevel, curLevel, isOpen)
    self:RefreshTotalLogic()
  end
end

function UINAchievementLevelNode:m_RefreshNextLevelInfo(curLevel, isMax)
  if isMax then
    self.ui.obj_levelReward:SetActive(false)
    self.ui.obj_itemList:SetActive(false)
    return
  else
    self.ui.obj_levelReward:SetActive(true)
    self.ui.obj_itemList:SetActive(true)
  end
  self.levelRewardItemPool:HideAll()
  local nextLevel = curLevel + 1
  local nextLevelCfg = ConfigData.achievement_level[nextLevel]
  if nextLevelCfg ~= nil then
    for k, id in ipairs(nextLevelCfg.rewardIds) do
      local num = nextLevelCfg.rewardNums[k]
      local itemCfg = ConfigData.item[id]
      local rewardItem = self.levelRewardItemPool:GetOne()
      rewardItem:InitItemWithCount(itemCfg, num)
    end
    local logic, para1, para2, para3 = PlayerDataCenter.achivLevelData:GetLevelLogics(nextLevel)
    local des = ""
    for index, logic in pairs(logic) do
      local para1 = para1[index]
      local para2 = para2[index]
      local para3 = para3[index]
      if string.IsNullOrEmpty(des) then
        des = CommonLogicUtil.GetDesString(logic, para1, para2, para3)
      else
        des = des .. "\n" .. CommonLogicUtil.GetDesString(logic, para1, para2, para3)
      end
    end
    self.ui.tex_LevelBuff.text = des
    self.ui.tex_Level:SetIndex(0, tostring(nextLevel))
  end
end

function UINAchievementLevelNode:RefreshAchFinishedNum(cur, total)
  self.ui.tex_CompleteNum:SetIndex(0, tostring(cur or 0), tostring(total or 0))
end

function UINAchievementLevelNode:RefreshLevelList(maxLevel, curLevel, isOpen)
  self.levelDataList = {}
  for i = 2, maxLevel do
    local levelData = {
      level = i,
      levelCfg = ConfigData.achievement_level[i],
      state = nil
    }
    if i > PlayerDataCenter.playerLevel.level then
      levelData.state = eLevelState.UnCompleted
    elseif PlayerDataCenter.achivLevelData.pickedRewardLevels[i] == nil then
      levelData.state = eLevelState.Completed
    else
      levelData.state = eLevelState.Picked
    end
    table.insert(self.levelDataList, levelData)
  end
  if self.ui.loopList_playerLevelList.totalCount ~= #self.levelDataList then
    self.ui.loopList_playerLevelList.totalCount = #self.levelDataList
    self.ui.loopList_playerLevelList:RefillCells()
  else
    self.ui.loopList_playerLevelList:RefreshCells()
  end
  self:ChangeBtnReceiveAll()
  if isOpen then
    local rollIndex = 1
    for index, levelData in ipairs(self.levelDataList) do
      if levelData.state == eLevelState.Completed then
        rollIndex = index
        break
      end
      if levelData.level == curLevel then
        rollIndex = index
        break
      end
    end
    self.ui.loopList_playerLevelList:SrollToCell(rollIndex - 1, 5000)
  end
end

function UINAchievementLevelNode:ChangeBtnReceiveAll()
  self.levels = {}
  for k, v in pairs(self.levelDataList) do
    if v.state == eLevelState.Completed then
      self.levels[v.level] = true
    end
  end
  if table.count(self.levels) > 0 then
    self.ui.btn_ReceiveAll.gameObject:SetActive(true)
    local size = self.ui.btn_ReceiveAll.gameObject.transform.sizeDelta
    self.ui.loopList_playerLevelList.gameObject.transform.offsetMin = Vector2.New(self.listoffsetMin.x, self.listoffsetMin.y + size.y)
    self.ui.scrollbar.transform.offsetMin = Vector2.New(self.baroffsetMin.x, self.baroffsetMin.y + size.y)
  else
    self.ui.btn_ReceiveAll.gameObject:SetActive(false)
    self.ui.loopList_playerLevelList.gameObject.transform.offsetMin = Vector2.New(self.listoffsetMin.x, self.listoffsetMin.y)
    self.ui.scrollbar.transform.offsetMin = Vector2.New(self.baroffsetMin.x, self.baroffsetMin.y)
  end
end

function UINAchievementLevelNode:OnClickReceiveAll()
  self:CanRefreshPlayerLevel()
  self.achivLevelNetworkCtrl:SendACHIEVEMENT_OneKeyPick(self.levels, self.__NeedRefreshPlayerLevel)
end

function UINAchievementLevelNode:RefreshTotalLogic()
  local des = ""
  local cfg = ConfigData.achievement_level[PlayerDataCenter.playerLevel.level]
  for index, logic in ipairs(cfg.logic) do
    if string.IsNullOrEmpty(des) then
      des = CommonLogicUtil.GetDesString(logic, cfg.para1[index], cfg.para2[index], cfg.para3[index])
    else
      des = des .. "\n" .. CommonLogicUtil.GetDesString(logic, cfg.para1[index], cfg.para2[index], cfg.para3[index])
    end
  end
  for level, id in pairs(ConfigData.system_open.playerLevelUnlock) do
    if level <= PlayerDataCenter.playerLevel.level then
      if not string.IsNullOrEmpty(des) then
        des = des .. "\n"
      end
      des = des .. LanguageUtil.GetLocaleText(ConfigData.system_open[id].name)
    end
  end
  self.ui.tex_Addition.text = des
end

function UINAchievementLevelNode:m_OnNewItem(go)
  local levelItem = UINAchievementLevelItem.New()
  levelItem:Init(go)
  levelItem:InitLevelItem(eLevelState, self._GetReward)
  self.levelItemDic[go] = levelItem
end

function UINAchievementLevelNode:m_OnChangeItem(go, index)
  local levelItem = self.levelItemDic[go]
  if levelItem == nil then
    error("Can't find levelItem by gameObject")
    return
  end
  local levelData = self.levelDataList[index + 1]
  if levelData == nil then
    error("Can't find levelData by index, index = " .. tonumber(index))
  end
  levelItem:RefreshLevelItem(levelData)
end

function UINAchievementLevelNode:GetReward(level)
  self._heroIdSnapShoot = PlayerDataCenter:GetHeroIdSnapShoot()
  self.achivLevelNetworkCtrl:Send_ACHIEVEMENT_LevelReward(level)
end

function UINAchievementLevelNode:GetLevelRewardComplete(rewards)
  local rewardIds = {}
  local rewardNums = {}
  for k, v in pairs(rewards) do
    table.insert(rewardIds, k)
    table.insert(rewardNums, v)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot):SetCRNotHandledGreat(true):SetCRShowOverFunc(self.__NeedRefreshPlayerLevel)
    window:AddAndTryShowReward(CRData)
  end)
end

function UINAchievementLevelNode:SetProcessTween(setValue, duration)
  if setValue < 0 then
    return
  end
  if self.processSeq ~= nil then
    self.processSeq:Kill()
  end
  self.ui.Img_ExpBar.color = Color.white
  self.processSeq = cs_DoTween.Sequence()
  self.processSeq:Append(self.ui.Img_ExpBar:DOFillAmount(setValue, duration))
  self.processSeq:Join(self.ui.Img_ExpBar:DOColor(self.ui.col_ExpBar, 0.2):SetLoops(5))
  self.processSeq:SetAutoKill(false)
end

function UINAchievementLevelNode:OnDelete()
  if self.processSeq ~= nil then
    self.processSeq:Kill()
    self.processSeq = nil
  end
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelReward)
  if ok then
    RedDotController:RemoveListener(node.nodePath, self.redDotFunc)
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self.__CanRefreshPlayerLevel)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePickedRewardLevel, self.__CanRefreshPlayerLevel)
  MsgCenter:RemoveListener(eMsgEventId.GetAchivLevelRewardComplete, self.__onGetLevelRewardComplete)
  base.OnDelete(self)
end

return UINAchievementLevelNode
