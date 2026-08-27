local UIHeroInformation = class("UIHeroInformation", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local UINHeroInfoAchriveNode = require("Game.Hero.NewUI.HeroInfo.UINHeroInfoAchriveNode")
local UINHeroInfoStrotyNode = require("Game.Hero.NewUI.HeroInfo.UINHeroInfoStrotyNode")
local UINHeroInfoVoiceNode = require("Game.Hero.NewUI.HeroInfo.UINHeroInfoVoiceNode")
local UINHeroInfoFrageState = require("Game.Hero.NewUI.HeroInfo.UINHeroInfoFrageState")
local HeroInfoTextUtil = require("Game.Hero.NewUI.HeroInfo.HeroInfoTextUtil")
local JumpManager = require("Game.Jump.JumpManager")
local SkinEnum = require("Game.Skin.SkinEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local HandBookActReviewOpenFunc = require("Game.HandBook.UI.Activity.HandBookActReviewOpenFunc")
local HandBookActReviewFunc = require("Game.HandBook.UI.Activity.HandBookActReviewFunc")
local eActivityType = require("Game.ActivityFrame.ActivityFrameEnum").eActivityType
UIHeroInformation.eNodeType = {
  achrive = 1,
  story = 2,
  voice = 3
}
local eNodeType = UIHeroInformation.eNodeType
local eNodeTypeClass = {
  [eNodeType.achrive] = UINHeroInfoAchriveNode,
  [eNodeType.story] = UINHeroInfoStrotyNode,
  [eNodeType.voice] = UINHeroInfoVoiceNode
}
local waitRecorverNUM = 0

function UIHeroInformation:OnInit()
  self.nodeDic = {}
  self.togUI = {}
  self.resloader = cs_ResLoader.Create()
  for _, typeId in pairs(eNodeType) do
    UIUtil.AddValueChangedListener(self.ui.tog_list[typeId], self, self.__OnClickTog, typeId)
    self.togUI[typeId] = {}
    UIUtil.LuaUIBindingTable(self.ui.tog_list[typeId].transform, self.togUI[typeId])
    self.nodeDic[typeId] = eNodeTypeClass[typeId].New()
    self.nodeDic[typeId]:Init(self.ui.nodeGo[typeId])
  end
  self.ui.boj_heroChipInfo:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_LeftArrow, self, self._OnLeftBtnClick)
  UIUtil.AddButtonListener(self.ui.btn_RightArrow, self, self._OnRightBtnClick)
  UIUtil.AddButtonListener(self.ui.btn_AVGNoun, self, self.OnClickAvgNoun)
  UIUtil.AddButtonListener(self.ui.Btn_friendShip, self, self._OnfriendShipClick)
  UIUtil.AddButtonListener(self.ui.btn_HeroBackOff, self, self.__OnClickHeroBackOff)
  UIUtil.AddButtonListener(self.ui.btn_voiceLock, self, self.OnClickLockedVoiceBtn)
  UIUtil.AddButtonListener(self.ui.btn_AVGCharDun, self, self.OnClickCharDun)
  self.__shiftHeroData = BindCallback(self, self.__ShiftHeroData)
end

function UIHeroInformation:InitHeroInformation(heroData, closeCallback, switchHeroFunc, notAdd2BackStack, isReturn)
  if not notAdd2BackStack then
    UIUtil.SetTopStatus(self, self.OnClickReturn)
  end
  self.closeCallback = closeCallback
  if self.winTween ~= nil then
    self.winTween:Complete()
  end
  self:StopHomeLive2dVoice()
  self:RefreshHeroInformation(heroData, switchHeroFunc, isReturn)
end

function UIHeroInformation:RefreshHeroInformation(heroData, switchHeroFunc, isReturn)
  self.heroData = heroData
  self.switchHeroFunc = switchHeroFunc
  local active = switchHeroFunc ~= nil
  self.ui.btn_LeftArrow.gameObject:SetActive(active)
  self.ui.btn_RightArrow.gameObject:SetActive(active)
  self.ui.tween_info:DORestart()
  self:SwitchHero(heroData, nil, isReturn)
end

function UIHeroInformation:StopHomeLive2dVoice()
  local homeController = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeController ~= nil then
    homeController:ResetShowHeroVoiceImme()
  end
end

function UIHeroInformation:SwitchHero(heroData, reUseBigImgResLoader, isReturn)
  self.heroData = heroData
  self.isLocked = heroData.isLockedHero or PlayerDataCenter.heroDic[heroData.dataId] == nil
  self:RefreshFrageStateNode()
  local cvController = ControllerManager:GetController(ControllerTypeId.Cv, true)
  cvController:RemoveAllCvText()
  cvController:RemoveCvAllCueSheet(true)
  for type, node in pairs(self.nodeDic) do
    node:InitUsefulData(heroData, HeroInfoTextUtil, self.resloader)
    node:InitHeroInfoNode()
    if node.playerRateTimer ~= nil then
      node.playerRateTimer:Stop()
      node.playerRateTimer = nil
      node.playerRateCallback(1)
    end
  end
  if not isReturn then
    for _, tog in ipairs(self.ui.tog_list) do
      tog.group:SetAllTogglesOff()
      tog.isOn = true
      break
    end
  end
  local hasVoice = ControllerManager:GetController(ControllerTypeId.Cv, true):HasCv(heroData.dataId)
  self.ui.Btn_friendShip.gameObject:SetActive(not self.isLocked)
  if self.isLocked then
    self.ui.tog_list[eNodeType.voice].interactable = false
    self.ui.obj_img_voiceLock:SetActive(true)
  else
    self.ui.tog_list[eNodeType.voice].interactable = true
    self.ui.obj_img_voiceLock:SetActive(false)
  end
  self:__RefreshLeftUI()
  self:__ShowHeroSkin(reUseBigImgResLoader)
  self.nodeDic[eNodeType.story]:StopPlayVoice()
  self.nodeDic[eNodeType.voice]:StopPlayVoice()
  self:RefreshHeroBackOff()
  local showDunEnter, sectorId = self:__GetDunSectorId()
  if showDunEnter == false then
    showDunEnter = self:__GetHeroLiteMainId()
  end
  self.ui.btn_AVGCharDun.gameObject:SetActive(showDunEnter)
end

function UIHeroInformation:__PlayAllDOTweenBackwards()
  self.ui.tween_heroHolder:DOPlayBackwards()
  self.ui.tween_info:DOPlayBackwards()
end

function UIHeroInformation:__RefreshLeftUI()
  self.ui.tex_Name.text = self.heroData:GetName()
  local birthday, model, cv, archives_career = self.heroData:GetHeroArchiveInfo()
  self.ui.tex_CV_Name.text = cv
  local friendShipLevel = PlayerDataCenter.allFriendshipData:GetLevel(self.heroData.dataId)
  local curLevelExp = PlayerDataCenter.allFriendshipData:GetExp(self.heroData.dataId)
  local curLevelTotalExp = ConfigData.friendship_level[friendShipLevel].friendship
  self.ui.tex_FrienshipLevel:SetIndex(0, tostring(friendShipLevel))
  self.ui.img_FriendshipBar.fillAmount = curLevelExp / curLevelTotalExp
end

function UIHeroInformation:__ShowHeroSkin(reUseBigImgResLoader)
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if reUseBigImgResLoader ~= nil then
    if not IsNull(self.bigImgGameObject) then
      self.bigImgGameObject:SetActive(false)
    end
    reUseBigImgResLoader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(self.heroData:GetResPicName(), SkinEnum.fromWhere.heroInfoAndHandbook), function(prefab)
      DestroyUnityObject(self.bigImgGameObject)
      if IsNull(prefab) then
        return
      end
      self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder)
      local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("HeroSkin")
      if self.isLocked or self.heroData:GetHeroIsNotHaveLegalSkin() then
        local rawImage = self.bigImgGameObject:FindComponent(eUnityComponentID.RawImage)
        rawImage.material = CS.UnityEngine.Object.Instantiate(self.ui.mat_heroPicPaperCut)
      end
      self.ui.tween_heroHolder:DORestart()
    end)
  else
    self.bigImgResloader = cs_ResLoader.Create()
    if not IsNull(self.bigImgGameObject) then
      self.bigImgGameObject:SetActive(false)
    end
    self.bigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(self.heroData:GetResPicName(), SkinEnum.fromWhere.heroInfoAndHandbook), function(prefab)
      DestroyUnityObject(self.bigImgGameObject)
      if IsNull(prefab) then
        return
      end
      self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder)
      local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("HeroSkin")
      if self.isLocked then
        local rawImage = self.bigImgGameObject:FindComponent(eUnityComponentID.RawImage)
        rawImage.material = CS.UnityEngine.Object.Instantiate(self.ui.mat_heroPicPaperCut)
      end
      self.ui.tween_heroHolder:DORestart()
    end)
  end
end

function UIHeroInformation:RefreshHeroBackOff()
  if self.isLocked then
    self.ui.btn_HeroBackOff.gameObject:SetActive(false)
    return
  end
  local ok = PlayerDataCenter:IsHeroBackOffEnable(self.heroData.dataId)
  self.ui.btn_HeroBackOff.gameObject:SetActive(ok)
end

function UIHeroInformation:__OnClickHeroBackOff()
  local ok = PlayerDataCenter:IsHeroBackOffEnable(self.heroData.dataId)
  if not ok then
    UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
      if win == nil then
        return
      end
      win:ShowTextBoxWithConfirm(ConfigData:GetTipContent(556), nil)
    end)
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroBackOff, function(win)
    if win == nil then
      return
    end
    win:InitHeroBackOffUI(self.heroData)
  end)
end

function UIHeroInformation:__OnClickTog(type, bool)
  if not bool then
    if self.nodeDic[type] ~= nil then
      self.nodeDic[type]:Hide()
      self.nodeDic[type].ui.fade:DOKill()
    end
    self.togUI[type].img_UnSel:SetActive(true)
    self.togUI[type].tex_pageName.color = self.ui.colot_unselected
    return
  end
  self.togUI[type].img_UnSel:SetActive(false)
  self.togUI[type].tex_pageName.color = self.ui.color_selected
  self.nodeDic[type]:Show()
  self.nodeDic[type]:InitHeroInfoNode()
  self.nodeDic[type].ui.fade.alpha = 1
  self.nodeDic[type].ui.fade:DOFade(0, 0.25):From()
end

function UIHeroInformation:SwitchTog(activeTypeId)
  for _, typeId in pairs(eNodeType) do
    local isOn = activeTypeId == typeId
    self.ui.tog_list[typeId].isOn = isOn
    self:__OnClickTog(typeId, isOn)
  end
  local switchToToggle = self.ui.tog_list[activeTypeId]
  if not IsNull(switchToToggle) then
    switchToToggle.group:NotifyToggleOn(switchToToggle)
  end
end

function UIHeroInformation:RefreshFrageStateNode()
  if self.isLocked and not self.heroData:IsHeroNotMergeable() then
    if self.frageStateNode == nil then
      self.frageStateNode = UINHeroInfoFrageState.New()
      self.frageStateNode:Init(self.ui.boj_heroChipInfo)
    end
    self.frageStateNode:Show()
  else
    if self.frageStateNode ~= nil then
      self.frageStateNode:Hide()
    end
    return
  end
  self.frageStateNode:RefreshFrageState(self.heroData, self.resloader)
end

function UIHeroInformation:__UnloadHeroVoiceAndStory()
  local cvController = ControllerManager:GetController(ControllerTypeId.Cv, true)
  cvController:RemoveAllCvText()
  cvController:RemoveCvAllCueSheet(true)
  HeroInfoTextUtil.RemoveAllArchiveText()
end

function UIHeroInformation:OnTcpLogout_HeroInfo()
  for _, typeId in pairs(eNodeType) do
    self.nodeDic[typeId]:OnTcpLogOut_HeroInfoNode()
  end
end

function UIHeroInformation:OnClickReturn()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self:__PlayAllDOTweenBackwards()
  if 0 < waitRecorverNUM then
    self:Hide()
  else
    self:Delete()
  end
end

function UIHeroInformation:__ShiftHeroData(heroData)
  if heroData == nil or heroData:GetIsNotShowInfo() then
    return true
  end
end

function UIHeroInformation:_OnLeftBtnClick()
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = self.switchHeroFunc(-1, self.__shiftHeroData)
    if newHeroData ~= nil then
      self:SwitchHero(newHeroData, reUseBigImgResloader)
    end
  end
end

function UIHeroInformation:_OnRightBtnClick()
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = self.switchHeroFunc(1, self.__shiftHeroData)
    if newHeroData ~= nil then
      self:SwitchHero(newHeroData, reUseBigImgResloader)
    end
  end
end

function UIHeroInformation:_OnfriendShipClick()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship) then
    local des = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship)
    cs_MessageCommon.ShowMessageTips(des)
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FriendShip, function(win)
    if win == nil then
      return
    end
    local heroInfoWin = UIManager:GetWindow(UIWindowTypeID.HeroInfomation)
    if heroInfoWin == nil then
      win:Delete()
      return
    end
    heroInfoWin:Hide()
    win:InitFriendshipSkillUpgrade(heroInfoWin.heroData, nil, function(heroData, switchFunc)
      if not heroData:GetIsNotShowInfo() then
        UIManager:ShowWindow(UIWindowTypeID.HeroInfomation):RefreshHeroInformation(heroData, switchFunc)
      else
        UIUtil.OnClickBackByUiTab(self)
      end
    end, heroInfoWin.switchHeroFunc)
  end)
end

function UIHeroInformation:OnClickAvgNoun()
  UIManager:ShowWindowAsync(UIWindowTypeID.AvgNounDes, function(window)
    if window == nil then
      return
    end
    window:InitAvgNounDes()
  end)
end

function UIHeroInformation:OnClickLockedVoiceBtn()
  cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(618))
end

function UIHeroInformation:OnClickCharDun()
  local showDunEnter, sectorId = self:__GetDunSectorId()
  if showDunEnter then
    if not SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
      return
    end
    JumpManager:Jump(JumpManager.eJumpTarget.DynSectorLevel, nil, nil, {sectorId})
  else
    local heroLiteCfgId = 0
    showDunEnter, heroLiteCfgId = self:__GetHeroLiteMainId()
    if heroLiteCfgId == nil then
      return
    end
    local cprData = HandBookActReviewFunc[eActivityType.HeroGrowV3](heroLiteCfgId)
    HandBookActReviewOpenFunc:OpenHandbookActReview(cprData, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.HandBookActBookFes)
    end, true)
  end
end

function UIHeroInformation:__GetDunSectorId()
  local activityHeroCfgId = ConfigData.activity_hero.heroMappping[self.heroData.dataId]
  if activityHeroCfgId == nil then
    return false, nil
  end
  local activityHeroCfg = ConfigData.activity_hero[activityHeroCfgId]
  if activityHeroCfg == nil then
    return false, nil
  end
  return PlayerDataCenter.sectorEntranceHandler:CheckSectorValid(activityHeroCfg.main_stage), activityHeroCfg.main_stage
end

function UIHeroInformation:__GetHeroLiteMainId()
  local cfgId = ConfigData.activity_herolite_main.heroMappping[self.heroData.dataId]
  if cfgId == nil then
    return false, nil
  end
  return true, cfgId
end

function UIHeroInformation:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  for index, tween in ipairs(self.ui.tweenList) do
    tween:DOKill()
  end
  self:__UnloadHeroVoiceAndStory()
  for _, typeId in pairs(eNodeType) do
    self.nodeDic[typeId].ui.fade:DOKill()
    self.nodeDic[typeId]:Delete()
  end
  HeroInfoTextUtil.Delete()
  if self.frageStateNode ~= nil then
    self.frageStateNode:Delete()
  end
  base.OnDelete(self)
end

function UIHeroInformation:OnCloseTween()
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  base.OnCloseTween(self)
end

function UIHeroInformation:GenCoverJumpReturnCallback()
  local dataTable = {}
  dataTable.heroData = self.heroData
  dataTable.closeCallback = self.closeCallback
  dataTable.switchHeroFunc = self.switchHeroFunc
  waitRecorverNUM = waitRecorverNUM + 1
  return function()
    self:InitHeroInformation(dataTable.heroData, dataTable.closeCallback, dataTable.switchHeroFunc, true, true)
    self:Show()
    waitRecorverNUM = waitRecorverNUM - 1
  end
end

return UIHeroInformation
