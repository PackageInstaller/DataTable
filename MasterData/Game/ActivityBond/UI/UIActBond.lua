local base = UIBaseWindow
local UIActBond = class("UIActBond", base)
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local ActivityBondEnum = require("Game.ActivityBond.Data.ActivityBondEnum")
local UINActBondBondItem = require("Game.ActivityBond.UI.UINActBondBondItem")
local UINActBondLevelItem = require("Game.ActivityBond.UI.UINActBondLevelItem")

function UIActBond:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__OnClickClose):SetTopStatusInfoFunc(self.__OnClickRule):SetTopStatusVisible(true):PushTopStatusDataToBackStack(true)
  UIUtil.AddButtonListener(self.ui.Btn_BondDetails, self, self.__OnClickBondDetail)
  UIUtil.AddButtonListener(self.ui.Btn_Start, self, self.__OnClickStart)
  UIUtil.AddButtonListener(self.ui.Btn_Reward, self, self.__OnClickReward)
  self.compBondItemPool = UIItemPool.New(UINActBondBondItem, self.ui.obj_CompanyItem, false)
  self.careerBondItemPool = UIItemPool.New(UINActBondBondItem, self.ui.obj_CareerItem, false)
  self.levelItemPool = UIItemPool.New(UINActBondLevelItem, self.ui.obj_levelItem, false)
  self.__onClickDunGroupItem = BindCallback(self, self.__OnClickDunGroupItem)
  self._resloader = cs_ResLoader.Create()
end

function UIActBond:InitActBond(bondData, backCallback)
  self.__isInit = true
  self.bondData = bondData
  self.backCallback = backCallback
  self.__selectedGroupLevelItem = nil
  self:__RefreshStaticInfo()
  self:__RefreshLevels()
  self:__RefreshScore()
  self:__RefreshTime()
  self:__InitRewardRedDot()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self._timerId = TimerManager:StartTimer(1, self.__timeUpdate, self, false, false, true)
  self.__isInit = false
end

function UIActBond:BondAct_ReopenDun(bondDunData)
  if bondDunData == nil then
    return
  end
  local groupId = bondDunData:GetDunGroupData():ActBond_GetIndex()
  local dunGroupItem
  for key, levelItem in pairs(self.levelItemPool.listItem) do
    if levelItem:ActBond_GetDunGropData():ActBond_GetIndex() == groupId then
      dunGroupItem = levelItem
      break
    end
  end
  UIUtil.ScrollRectLocation(self.ui.scrollRect, dunGroupItem, true, false, self.ui.layoutGroup)
  if self.__selectedGroupLevelItem ~= dunGroupItem then
    dunGroupItem:__Onclick()
  end
  self:__OnClickStart()
end

function UIActBond:__RefreshStaticInfo()
  self.ui.CNTitle.text = LanguageUtil.GetLocaleText(self.bondData:GetActivityName())
  self.ui.Tex_Rule.text = self.bondData:GetActBondSeasonRule()
  local buffId = self.bondData:GetActBondSeasonBuffId()
  local dunBuffCfg = ConfigData.dungeon_buff[buffId]
  self.ui.Img_ProtocolIcon.sprite = CRH:GetSprite(dunBuffCfg.icon, CommonAtlasType.ExplorationIcon)
  self.ui.Tex_ProtocolDes.text = LanguageUtil.GetLocaleText(dunBuffCfg.describe)
  self.compBondItemPool:HideAll()
  self.careerBondItemPool:HideAll()
  local compyCfgList = self.bondData:GetActBond_Bonds(ActivityBondEnum.eBondType.company)
  local careerCfgList = self.bondData:GetActBond_Bonds(ActivityBondEnum.eBondType.career)
  for _, cfg in ipairs(compyCfgList) do
    local bondItem = self.compBondItemPool:GetOne(true)
    bondItem:InitBondActBondItem(cfg, self._resloader)
  end
  for _, cfg in ipairs(careerCfgList) do
    local bondItem = self.careerBondItemPool:GetOne(true)
    bondItem:InitBondActBondItem(cfg, self._resloader)
  end
end

function UIActBond:__RefreshScore()
  self.ui.Tex_Score.text = self.bondData:GetActBondTotalScore()
end

function UIActBond:__RefreshLevels()
  self.levelItemPool:HideAll()
  self.__selectedGroupLevelItem = nil
  local firstUnclearLevel
  local dunGroupDataList = self.bondData:GetActBondDunGroupList()
  for i, dunGroupData in ipairs(dunGroupDataList) do
    local levelItem = self.levelItemPool:GetOne(true)
    levelItem:InitActBondLevelItem(self.bondData, dunGroupData, self.__onClickDunGroupItem, self._resloader)
    if self.__isInit and (not dunGroupData:ActBond_GetIsAllCleared() or i == #dunGroupDataList) and firstUnclearLevel == nil then
      firstUnclearLevel = levelItem
    end
  end
  if firstUnclearLevel ~= nil then
    UIUtil.ScrollRectLocation(self.ui.scrollRect, firstUnclearLevel, true, false, self.ui.layoutGroup)
    firstUnclearLevel:__Onclick()
  end
end

function UIActBond:__RefreshTime()
  local playEndTime = self.bondData:GetActivityEndTime()
  local leftTime = math.floor(playEndTime - PlayerDataCenter.timestamp)
  local d, h, m, s = TimeUtil:TimestampToTimeInter(leftTime, false, true)
  self.ui.Tex_Timer.text = TimeUtil:TimestampToDateString(playEndTime, false, true, "%Y/%m/%d %H:%M")
  self.ui.Tex_Day.text = string.format(ConfigData:GetTipContent(6043), tostring(d))
end

function UIActBond:__timeUpdate()
  self:__RefreshTime()
  for _, levelItem in pairs(self.levelItemPool.listItem) do
    levelItem:ActBond_TimeUpdate()
  end
end

function UIActBond:__InitRewardRedDot()
  local redDotNode = self.bondData:GetActChildRedDot(ActivityBondEnum.reddotType.Reward)
  if redDotNode == nil then
    return
  end
  self._RewardRedDotNode = redDotNode
  
  function self.__refreshReward(node)
    if node == nil then
      return
    end
    self.ui.obj_RewardRedDot:SetActive(node:GetRedDotCount() > 0)
  end
  
  self.__refreshReward(redDotNode)
  RedDotController:AddListener(redDotNode.nodePath, self.__refreshReward)
end

function UIActBond:__OnClickDunGroupItem(levelItem)
  if self.__selectedGroupLevelItem ~= nil then
    self.__selectedGroupLevelItem:SetIsSelected(false)
  end
  if self.__selectedGroupLevelItem == levelItem then
    self.__selectedGroupLevelItem = nil
    return
  end
  self.__selectedGroupLevelItem = levelItem
  self.__selectedGroupLevelItem:SetIsSelected(true)
end

function UIActBond:__OnClickBondDetail()
  UIManager:ShowWindowAsync(UIWindowTypeID.ActBondDetails, function(win)
    if win == nil then
      return
    end
    win:InitBondDetail(self.bondData)
  end)
end

function UIActBond:__OnClickReward()
  local actId = self.bondData:GetActId()
  local rewardCfgList = ConfigData.activity_bond_reward[actId]
  local pickedScore = self.bondData:GetActBondPickedScore()
  local currentScore = self.bondData:GetActBondTotalScore()
  UIManager:ShowWindowAsync(UIWindowTypeID.StageRewardPreview, function(win)
    if win == nil then
    end
    win:InitUIStageRewardPreviewV2(rewardCfgList, pickedScore, currentScore, BindCallback(self, self.__OnClickReceiveAll))
  end)
end

function UIActBond:__OnClickReceiveAll()
  local actId = self.bondData:GetActId()
  local networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  networkCtrl:CS_Activity_Bond_Reward(actId, function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local msg = args[0]
    UIUtil.ShowCommonReward(msg.rewards)
    UIManager:DeleteWindow(UIWindowTypeID.StageRewardPreview)
  end)
end

function UIActBond:__OnClickStart()
  if self.__selectedGroupLevelItem == nil then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(9609))
    return
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local actId = self.bondData:GetActId()
  local dunGroupId = self.__selectedGroupLevelItem:ActBond_GetDunGropData():ActBond_GetIndex()
  saveUserData:SetBondDunGroupLooked(actId, dunGroupId)
  self.__selectedGroupLevelItem:__RefreshBlueDot()
  UIManager:ShowWindowAsync(UIWindowTypeID.ActBondDunSelect, function(win)
    if win == nil then
      return
    end
    local dunGroupData = self.__selectedGroupLevelItem:ActBond_GetDunGropData()
    win:InitActBondDunSelect(self.bondData, dunGroupData)
  end)
end

function UIActBond:__OnClickRule()
  local rule_title, rule_des = self.bondData:GetActBondTipId()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(rule_des), ConfigData:GetTipContent(rule_title))
  end)
end

function UIActBond:__OnClickClose()
  if self.backCallback ~= nil then
    self.backCallback(false)
  end
  self:Delete()
end

function UIActBond:OnDelete()
  if self._RewardRedDotNode then
    RedDotController:RemoveListener(self._RewardRedDotNode.nodePath, self.__refreshReward)
  end
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self.compBondItemPool:DeleteAll()
  self.careerBondItemPool:DeleteAll()
  self.levelItemPool:DeleteAll()
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  base.Delete(self)
end

return UIActBond
