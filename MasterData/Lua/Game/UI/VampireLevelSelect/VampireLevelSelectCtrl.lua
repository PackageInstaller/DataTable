local VampireLevelSelectCtrl = class("VampireLevelSelectCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local PlayerBoardData = PlayerData.Board
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local Path = require("path")
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local typeof = _ENV.typeof
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
VampireLevelSelectCtrl._mapNodeConfig = {
  imgBgTalent = {},
  imgBgLevelInfo = {},
  TMPScoreTitleQuest = {
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_Season_Score"
  },
  TMPScore = {sComponentName = "TMP_Text"},
  TMPRemainTimeQuest = {sComponentName = "TMP_Text"},
  rtLevelSelect = {
    sCtrlName = "Game.UI.VampireLevelSelect.VampireLevelSelect_levelSelectCtrl"
  },
  rtLevelInfo = {
    sCtrlName = "Game.UI.VampireLevelSelect.VampireLevelSelect_levelInfo"
  },
  rtTalent = {
    sCtrlName = "Game.UI.VampireLevelSelect.VampireLevelSelect_talentCtrl"
  },
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  btnTalent = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Talent"
  },
  btnQuest = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quest"
  },
  btnShop = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Shop"
  },
  btnNote = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Note"
  },
  btnNpc = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Npc"
  },
  btnPassQuest = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_PassQuest"
  },
  VampireQuestPanel = {
    sCtrlName = "Game.UI.VampireLevelSelect.VampireLevelSelect_questCtrl"
  },
  goEnemyInfo = {
    sCtrlName = "Game.UI.MainlineEx.MainlineMonsterInfoCtrl"
  },
  imgDisasterEffect = {},
  goBubbleRoot = {
    sNodeName = "----fixed_bubble----"
  },
  TMPBtnNote = {
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_Talent"
  },
  TMPBtnShop = {
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_Shop"
  },
  TMPBtnCodex = {
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_Book"
  },
  TMPBtnQuest = {sComponentName = "TMP_Text"},
  goImgBgLevelSelect = {
    sNodeName = "imgBgLevelSelect"
  },
  imgBgLevelSelect = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  goRedDotQuest = {},
  goRedDotTalent = {}
}
VampireLevelSelectCtrl._mapEventConfig = {
  VampireLevelSelect_ClickLevelGrid = "OnEvent_ClickLevelGrid",
  VampireSurvivorChangeBuild = "OnEvent_VampireSurvivorChangeBuild",
  EnterVampireSurvivor = "OnEvent_EnterVampireSurvivor",
  VampireQuestTitle = "SetQuestTitle",
  VampireToggleChange = "OnEvent_VampireToggleChange",
  VampireSeasonRefresh = "OnEvent_VampireSeasonRefresh",
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.ShowBubbleVoiceText] = "OnEvent_ShowBubbleVoiceText"
}
VampireLevelSelectCtrl._mapRedDotConfig = {
  [RedDotDefine.VampireQuest] = {
    sNodeName = "goRedDotQuest"
  },
  [RedDotDefine.VampireTalent] = {
    sNodeName = "goRedDotTalent"
  }
}

function VampireLevelSelectCtrl:OnEnable()
  EventManager.Hit(EventId.SetTransition)
  self.animator = self.gameObject:GetComponent("Animator")
  local bUseL2D = LocalSettingData.mapData.UseLive2D
  self._mapNode.imgBgLevelSelect.transform.localScale = bUseL2D == true and Vector3.one or Vector3.zero
  self._mapNode.trActor2D_PNG.localScale = bUseL2D == true and Vector3.zero or Vector3.one
  if bUseL2D == true then
    Actor2DManager.SetBoardNPC2D(self:GetPanelId(), self._mapNode.imgBgLevelSelect, 910202)
  else
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.trActor2D_PNG, self:GetPanelId(), 910202)
  end
  local nScore = PlayerData.VampireSurvivor:GetCurScore()
  NovaAPI.SetTMPText(self._mapNode.TMPScore, nScore)
  NovaAPI.SetTMPText(self._mapNode.TMPRemainTimeQuest, ConfigTable.GetUIText("Vampire_Season_ScoreTime") .. PlayerData.VampireSurvivor:GetRefreshTiem())
  self.bRefreshLevelSelect = false
  if self._panel.nLevelId ~= nil and self._panel.nLevelId > 0 then
    local mapData = ConfigTable.GetData("VampireSurvivor", self._panel.nLevelId)
    self._mapNode.rtTalent.gameObject:SetActive(false)
    if mapData ~= nil then
      self:OnEvent_ClickLevelGrid(mapData, true)
    end
  elseif self._panel.bTalent then
    self:OnBtnClick_Talent()
    self._mapNode.rtLevelInfo.gameObject:SetActive(false)
  else
    self._mapNode.imgBgTalent:SetActive(false)
    self._mapNode.rtLevelInfo.gameObject:SetActive(false)
    self._mapNode.rtTalent.gameObject:SetActive(false)
    self._mapNode.rtLevelSelect.gameObject:SetActive(true)
    self._mapNode.goBubbleRoot:SetActive(true)
    self._mapNode.rtLevelSelect:Refresh()
    self.bRefreshLevelSelect = true
    self.animator:Play("VampireLevelSelectPanel_in")
    self:NpcVoice()
  end
  self._mapNode.rtTalent:Refresh()
  local nQuestCur, nQuestTotal = PlayerData.VampireSurvivor:GetSeasonQuestCount()
  NovaAPI.SetTMPText(self._mapNode.TMPBtnQuest, orderedFormat(ConfigTable.GetUIText("Vampire_Quest_Btn_Title") or "", nQuestCur, nQuestTotal))
  local imgBg1 = self.gameObject.transform:Find("imgBgLevelInfo"):GetComponent("Image")
  local imgBg2 = self.gameObject.transform:Find("imgBgLevelInfo1"):GetComponent("Image")
  local imgBg3 = self.gameObject.transform:Find("imgDisasterEffect/imgBgLevelInfo"):GetComponent("Image")
  local imgBg4 = self.gameObject.transform:Find("imgDisasterEffect/imgBgLevelInfo1"):GetComponent("Image")
  local imgBg5 = self.gameObject.transform:Find("imgBgTalent"):GetComponent("Image")
  self:SetPngSprite(imgBg1, "Image/UIBG/bg_survivor_entrance")
  self:SetPngSprite(imgBg2, "Image/UIBG/bg_survivor_entrance_01")
  self:SetPngSprite(imgBg3, "Image/UIBG/bg_survivor_entrance_02")
  self:SetPngSprite(imgBg4, "Image/UIBG/bg_survivor_entrance_03")
  self:SetPngSprite(imgBg5, "Image/UIBG/bg_survivor_talentbg")
end

function VampireLevelSelectCtrl:OnDisable()
  Actor2DManager.UnsetBoardNPC2D()
  PlayerData.Voice:StopCharVoice()
  PlayerData.Voice:ClearTimer()
  BubbleVoiceManager.StopBubbleAnim()
end

function VampireLevelSelectCtrl:SetQuestTitle(nHard)
  local nQuestCur, nQuestTotal = PlayerData.VampireSurvivor:GetSeasonQuestCount(nHard)
  NovaAPI.SetTMPText(self._mapNode.TMPBtnQuest, orderedFormat(ConfigTable.GetUIText("Vampire_Quest_Btn_Title") or "", nQuestCur, nQuestTotal))
end

function VampireLevelSelectCtrl:OnEvent_ClickLevelGrid(mapData, bNoAnim)
  local nId = mapData.Id
  local cachedBuild = PlayerData.VampireSurvivor:GetCachedBuildId(nId)
  local mapBuild1, mapBuild2
  
  local function GetBuildCallback(tbBuild, mapBuild)
    local bDeleteBuild = false
    if cachedBuild[1] ~= nil and cachedBuild[1] ~= 0 then
      mapBuild1 = mapBuild[cachedBuild[1]]
      bDeleteBuild = mapBuild1 == nil
      if mapBuild1 == nil then
        cachedBuild[1] = 0
      end
    end
    if cachedBuild[2] ~= nil and cachedBuild[2] ~= 0 then
      mapBuild2 = mapBuild[cachedBuild[2]]
      bDeleteBuild = bDeleteBuild or mapBuild2 == nil
      if mapBuild2 == nil then
        cachedBuild[2] = 0
      end
    end
    if bDeleteBuild then
      local sTip = ConfigTable.GetUIText("RegionBoss_Team_Delete")
      EventManager.Hit(EventId.OpenMessageBox, sTip)
    end
    self._mapNode.rtLevelInfo.gameObject:SetActive(true)
    self._mapNode.rtLevelSelect.gameObject:SetActive(false)
    self._mapNode.goBubbleRoot:SetActive(false)
    BubbleVoiceManager.StopBubbleAnim()
    self._panel.nLevelId = nId
    self._mapNode.rtLevelInfo:Refresh(nId, mapBuild1, mapBuild2)
    if bNoAnim then
      self.animator:Play("VampireLevelSelectPanel_loop1")
    else
      self.animator:Play("VampireLevelSelectPanel_in1")
    end
  end
  
  if cachedBuild == nil then
    self._mapNode.rtLevelInfo.gameObject:SetActive(true)
    self._mapNode.rtLevelSelect.gameObject:SetActive(false)
    self._mapNode.goBubbleRoot:SetActive(false)
    BubbleVoiceManager.StopBubbleAnim()
    self._panel.nLevelId = nId
    self._mapNode.rtLevelInfo:Refresh(nId, nil, nil)
    if bNoAnim then
      self.animator:Play("VampireLevelSelectPanel_loop1")
    else
      self.animator:Play("VampireLevelSelectPanel_in1")
    end
  else
    PlayerData.Build:GetSelectableBuildBriefData(GetBuildCallback, AllEnum.RegionBossFormationType.Vampire)
  end
  NovaAPI.SetTMPText(self._mapNode.TMPRemainTimeQuest, ConfigTable.GetUIText("Vampire_Season_ScoreTime") .. PlayerData.VampireSurvivor:GetRefreshTiem())
end

function VampireLevelSelectCtrl:OnEvent_EnterVampireSurvivor()
  self._mapNode.goImgBgLevelSelect:SetActive(false)
  self._mapNode.goBubbleRoot:SetActive(false)
  BubbleVoiceManager.StopBubbleAnim()
end

function VampireLevelSelectCtrl:OnEvent_Back(nPanelId)
  if self._panel.nLevelId ~= nil and self._panel.nLevelId > 0 or self._panel.bTalent then
    local nCurLevel = self._panel.nLevelId
    self._mapNode.imgBgTalent:SetActive(false)
    self._mapNode.rtLevelInfo.gameObject:SetActive(false)
    self._mapNode.rtTalent.gameObject:SetActive(false)
    self._mapNode.rtLevelSelect.gameObject:SetActive(true)
    self._mapNode.goBubbleRoot:SetActive(true)
    self._panel.nLevelId = 0
    self._panel.bTalent = false
    self.animator:Play("VampireLevelSelectPanel_in")
    self._mapNode.goImgBgLevelSelect:SetActive(true)
    local sKey = table.keyof(PanelId, self._panel._nPanelId)
    local mapTopBar = ConfigTable.GetData("TopBar", sKey, true)
    local sTitle = mapTopBar == nil and "" or mapTopBar.Title
    if type(sTitle) == "string" and sTitle ~= "" then
      self._mapNode.TopBar:SetTitleTxt(sTitle)
    end
    if not self.bRefreshLevelSelect then
      self._mapNode.rtLevelSelect:RefreshWithPosSet(nCurLevel)
      self.bRefreshLevelSelect = true
    end
    EventManager.Hit(EventId.SetCoinVisible, true)
    NovaAPI.SetTMPText(self._mapNode.TMPRemainTimeQuest, ConfigTable.GetUIText("Vampire_Season_ScoreTime") .. PlayerData.VampireSurvivor:GetRefreshTiem())
    if PlayerData.VampireSurvivor:CheckBattleSuccess() == true then
      self:PlayNpcVoice("clear")
      PlayerData.Voice:StartBoardFreeTimer(9102)
    end
  else
    EventManager.Hit(EventId.CloesCurPanel)
  end
end

function VampireLevelSelectCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

function VampireLevelSelectCtrl:OnEvent_VampireSurvivorChangeBuild()
  local nId = self._panel.nLevelId
  local cachedBuild = PlayerData.VampireSurvivor:GetCachedBuildId(nId)
  local mapBuild1, mapBuild2
  
  local function GetBuildCallback(tbBuild, mapBuild)
    if cachedBuild[1] ~= 0 then
      mapBuild1 = mapBuild[cachedBuild[1]]
    end
    if cachedBuild[2] ~= 0 then
      mapBuild2 = mapBuild[cachedBuild[2]]
    end
    self._mapNode.rtLevelInfo.gameObject:SetActive(true)
    self._mapNode.rtLevelSelect.gameObject:SetActive(false)
    self._mapNode.goBubbleRoot:SetActive(false)
    BubbleVoiceManager.StopBubbleAnim()
    self._panel.nLevelId = nId
    self._mapNode.rtLevelInfo:Refresh(nId, mapBuild1, mapBuild2)
  end
  
  if cachedBuild == nil then
    self._mapNode.rtLevelInfo.gameObject:SetActive(true)
    self._mapNode.rtLevelSelect.gameObject:SetActive(false)
    self._mapNode.goBubbleRoot:SetActive(false)
    BubbleVoiceManager.StopBubbleAnim()
    self._panel.nLevelId = nId
    self._mapNode.rtLevelInfo:Refresh(nId, nil, nil)
  else
    PlayerData.Build:GetSelectableBuildBriefData(GetBuildCallback, AllEnum.RegionBossFormationType.Vampire)
  end
end

function VampireLevelSelectCtrl:OnBtnClick_Talent()
  self._panel.bTalent = true
  self._mapNode.imgBgTalent:SetActive(true)
  self._mapNode.rtLevelSelect.gameObject:SetActive(false)
  self._mapNode.goBubbleRoot:SetActive(false)
  BubbleVoiceManager.StopBubbleAnim()
  self._mapNode.rtTalent.gameObject:SetActive(true)
  self.animator:Play("VampireLevelSelectPanel_rtTalent")
  local animTime = NovaAPI.GetAnimClipLength(self.animator, {
    "VampireLevelSelectPanel_rtTalent"
  })
  self:AddTimer(1, animTime, function()
    local bHint, nCard, nExp = PlayerData.VampireSurvivor:CheckOpenHint()
    if bHint then
      self._mapNode.rtTalent:OpenHint(nCard, nExp)
    end
  end, true, true, true)
  NovaAPI.SetTMPText(self._mapNode.TMPRemainTimeQuest, ConfigTable.GetUIText("Vampire_Season_ScoreTime") .. PlayerData.VampireSurvivor:GetRefreshTiem())
  self._mapNode.TopBar:SetTitleTxt(ConfigTable.GetUIText("Vampire_TalentPanel_Title"))
  EventManager.Hit(EventId.SetCoinVisible, false)
end

function VampireLevelSelectCtrl:OnBtnClick_Quest()
  NovaAPI.SetTMPText(self._mapNode.TMPRemainTimeQuest, ConfigTable.GetUIText("Vampire_Season_ScoreTime") .. PlayerData.VampireSurvivor:GetRefreshTiem())
  self._mapNode.rtLevelInfo:SetRefreshTime()
  self._mapNode.VampireQuestPanel:OpenPanel(self._mapNode.rtLevelSelect.curToggle)
end

function VampireLevelSelectCtrl:OnBtnClick_PassQuest()
  NovaAPI.SetTMPText(self._mapNode.TMPRemainTimeQuest, ConfigTable.GetUIText("Vampire_Season_ScoreTime") .. PlayerData.VampireSurvivor:GetRefreshTiem())
  self._mapNode.rtLevelInfo:SetRefreshTime()
  self._mapNode.VampireQuestPanel:OpenPanel(2, self._panel.nLevelId)
end

function VampireLevelSelectCtrl:OnBtnClick_Note()
  local function callback()
    EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerBook, AllEnum.StarTowerBookPanelType.FateCard)
  end
  
  PlayerData.StarTowerBook:TryGetFateCardBook(callback)
end

function VampireLevelSelectCtrl:OnBtnClick_Shop()
  EventManager.Hit(EventId.OpenPanel, PanelId.ShopPanel, 2)
end

function VampireLevelSelectCtrl:OnBtnClick_Npc()
  if self.bBlockNpc == true then
    return
  end
  PlayerData.Voice:PlayBoardNPCClickVoice(9102)
end

function VampireLevelSelectCtrl:OnEvent_VampireToggleChange(nIdx)
  self._mapNode.imgDisasterEffect:SetActive(nIdx == 3)
end

function VampireLevelSelectCtrl:PlayNpcVoice(sType)
  local sVoiceRes = PlayerData.Voice:PlayCharVoice(sType, 9102, nil, true)
end

function VampireLevelSelectCtrl:OnEvent_ShowBubbleVoiceText(nCharId, nId)
  if self._panel.nLevelId ~= nil and self._panel.nLevelId > 0 or self._panel.bTalent then
    return
  end
  local mapVoDirectoryData = ConfigTable.GetData("VoDirectory", nId)
  if mapVoDirectoryData == nil then
    printError("VoDirectory未找到数据id:" .. nId)
    return
  end
  if nil ~= mapVoDirectoryData then
    BubbleVoiceManager.PlayFixedBubbleAnim(self._mapNode.goBubbleRoot, mapVoDirectoryData.voResource)
  end
end

function VampireLevelSelectCtrl:OnEvent_VampireSeasonRefresh()
  local nScore = PlayerData.VampireSurvivor:GetCurScore()
  local nQuestCur, nQuestTotal = PlayerData.VampireSurvivor:GetSeasonQuestCount()
  self._mapNode.rtLevelSelect:NewSeason()
  if self._panel.nLevelId ~= nil and self._panel.nLevelId > 0 then
    self._mapNode.imgBgTalent:SetActive(false)
    self._mapNode.rtLevelInfo.gameObject:SetActive(false)
    self._mapNode.rtTalent.gameObject:SetActive(false)
    self._mapNode.rtLevelSelect.gameObject:SetActive(true)
    self._mapNode.goBubbleRoot:SetActive(true)
    self._panel.nLevelId = 0
    self._panel.bTalent = false
    self.animator:Play("VampireLevelSelectPanel_in")
    self._mapNode.goImgBgLevelSelect:SetActive(true)
    self._mapNode.goBubbleRoot:SetActive(true)
    local sKey = table.keyof(PanelId, self._panel._nPanelId)
    local mapTopBar = ConfigTable.GetData("TopBar", sKey, true)
    local sTitle = mapTopBar == nil and "" or mapTopBar.Title
    if type(sTitle) == "string" and sTitle ~= "" then
      self._mapNode.TopBar:SetTitleTxt(sTitle)
    end
    EventManager.Hit(EventId.SetCoinVisible, true)
  end
end

function VampireLevelSelectCtrl:BlockNpc(nTime)
  self.bBlockNpc = true
  
  local function unBlockJump()
    self.bBlockNpc = false
  end
  
  self:AddTimer(1, nTime, unBlockJump, true, true, nil, nil)
end

function VampireLevelSelectCtrl:NpcVoice()
  local sTimeVoice = PlayerData.Voice:GetNPCGreetTimeVoiceKey()
  PlayerData.VampireSurvivor:CheckBattleSuccess()
  PlayerData.Voice:StartBoardFreeTimer(9102)
  local bFirstIn = PlayerData.VampireSurvivor:GetFirstIn()
  if bFirstIn then
    self:PlayNpcVoice(sTimeVoice)
  else
    local nIndex = math.random(1, 2)
    local sVoice = nIndex == 1 and sTimeVoice or "greet_npc"
    self:PlayNpcVoice(sVoice)
  end
end

return VampireLevelSelectCtrl
