local VampireSurvivorPauseCtrl = class("VampireSurvivorPauseCtrl", BaseCtrl)
local GameCameraStackManager = CS.GameCameraStackManager.Instance
local AdventureModuleHelper = CS.AdventureModuleHelper
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
VampireSurvivorPauseCtrl._mapNodeConfig = {
  goBlur = {
    sNodeName = "t_fullscreen_blur_01"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_01",
    sComponentName = "Animator"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  imgBlocker = {},
  btnBgClose = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  aniWindow = {
    sNodeName = "PauseWindow",
    sComponentName = "Animator"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Pause"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnGiveUp = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_GiveUp",
    sAction = "Giveup",
    sActionIconType = "Dark"
  },
  btnBack = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close",
    sAction = "Back",
    sActionIconType = "Dark"
  },
  btnSettings = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Settings"
  },
  btnPopSkill = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Skill"
  },
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  txtGiveUp = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Pause_Btn_EndBattle"
  },
  txtBack = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Pause_Btn_ContinueBattle"
  },
  txtBtnSkill = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTowerMap_Btn_Skill"
  },
  txtBtnSettings = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTowerMap_Btn_Settings"
  },
  btnChar = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Char"
  },
  goChar = {
    nCount = 3,
    sNodeName = "btnChar",
    sCtrlName = "Game.UI.TemplateEx.TemplateCharCtrl"
  },
  txtSubTitle1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Time"
  },
  txtSubTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "VampirePause_ScoreTitle"
  },
  txtTime = {sComponentName = "TMP_Text"},
  txtLeader = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtScore = {sComponentName = "TMP_Text", nCount = 2},
  rtQuest = {},
  TMPQuest = {sComponentName = "TMP_Text", nCount = 3},
  btnQuestStar = {sComponentName = "Button", nCount = 3},
  imgBgScore = {nCount = 2},
  txtSub = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  },
  t_common_02_ = {nCount = 2},
  imgBgTime = {},
  handObj = {},
  texHandTimeTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Time"
  },
  texHandTime = {sComponentName = "TMP_Text"}
}
VampireSurvivorPauseCtrl._mapEventConfig = {
  OpenVampirePause = "Pause",
  GamepadUIReopen = "OnEvent_Reopen"
}

function VampireSurvivorPauseCtrl:Refresh(nTime, nScore)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.txtTime, string.format("%02d:%02d", nMin, nSec))
  NovaAPI.SetTMPText(self._mapNode.txtScore[1], nScore)
  NovaAPI.SetTMPText(self._mapNode.txtScore[2], nScore)
  for i = 1, 3 do
    self._mapNode.goChar[i]:SetChar(self.tbChar[i])
  end
end

function VampireSurvivorPauseCtrl:PlayInAni()
  self._mapNode.goBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot:SetActive(true)
    self._mapNode.aniWindow:Play("t_window_04_t_in")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  end
  
  cs_coroutine.start(wait)
end

function VampireSurvivorPauseCtrl:PlayCloseAni(bGiveUp)
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:AddTimer(1, 0.3, "OnPanelClose", true, true, true, bGiveUp)
end

function VampireSurvivorPauseCtrl:OnPanelClose(_, bGiveUp)
  PanelManager.InputEnable()
  GamepadUIManager.DisableGamepadUI("VampireSurvivorPauseCtrl")
  EventManager.Hit(EventId.BattleDashboardVisible, true)
  self._mapNode.safeAreaRoot:SetActive(false)
  self._mapNode.goBlur:SetActive(false)
  self._mapNode.imgBlocker:SetActive(false)
  if bGiveUp then
    EventManager.Hit("AbandonVampireSurvivor")
  end
end

function VampireSurvivorPauseCtrl:Awake()
  self._mapNode.safeAreaRoot:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
  NovaAPI.SetTMPText(self._mapNode.txtTime, string.format("%02d:%02d", 0, 0))
  local tbConfig = {
    {
      sAction = "Skill",
      sLang = "StarTowerMap_Btn_Skill"
    },
    {
      sAction = "Settings",
      sLang = "StarTowerMap_Btn_Settings"
    }
  }
  self._mapNode.ActionBar:InitActionBar(tbConfig)
end

function VampireSurvivorPauseCtrl:OnEnable()
end

function VampireSurvivorPauseCtrl:OnDisable()
end

function VampireSurvivorPauseCtrl:OnDestroy()
end

function VampireSurvivorPauseCtrl:Pause(nLevelId, tbCharId, nTime, nScore)
  self.tbChar = tbCharId
  self.nLevelId = nLevelId
  EventManager.Hit(EventId.BattleDashboardVisible, false)
  PanelManager.InputDisable()
  self:PlayInAni()
  self:Refresh(nTime, nScore)
  local mapLevelCfgData = ConfigTable.GetData("VampireSurvivor", self.nLevelId)
  if mapLevelCfgData == nil or mapLevelCfgData.Type == GameEnum.vampireSurvivorType.Turn then
    self._mapNode.rtQuest:SetActive(false)
    self._mapNode.imgBgScore[2]:SetActive(false)
    self._mapNode.imgBgScore[1]:SetActive(true)
  else
    self._mapNode.rtQuest:SetActive(true)
    self._mapNode.imgBgScore[2]:SetActive(true)
    self._mapNode.imgBgScore[1]:SetActive(false)
    local tbQuestId = CacheTable.GetData("_VampireQuestGroup", mapLevelCfgData.FirstQuestGroupId)
    if tbQuestId == nil then
      tbQuestId = {}
    end
    for i = 1, 3 do
      self._mapNode.TMPQuest[i].gameObject:SetActive(tbQuestId[i] ~= nil)
      self._mapNode.btnQuestStar[i].interactable = PlayerData.Quest:GetVampireQuestStatusById(tbQuestId[i]) > 0
      if tbQuestId[i] ~= nil then
        local mapQuestCfgData = ConfigTable.GetData("VampireSurvivorQuest", tbQuestId[i])
        if mapQuestCfgData == nil then
          self._mapNode.TMPQuest[i].gameObject:SetActive(false)
        else
          NovaAPI.SetTMPText(self._mapNode.TMPQuest[i], mapQuestCfgData.Title)
        end
      end
    end
  end
  GamepadUIManager.EnableGamepadUI("VampireSurvivorPauseCtrl", self.tbGamepadUINode)
end

function VampireSurvivorPauseCtrl:OnEvent_Time(nTime)
end

function VampireSurvivorPauseCtrl:OnBtnClick_GiveUp(btn)
  local sTip = ""
  local mapLevelData = ConfigTable.GetData("VampireSurvivor", self.nLevelId)
  local sName = ""
  if mapLevelData then
    sName = mapLevelData.Name
  end
  local sAlert = orderedFormat(ConfigTable.GetUIText("VampirePause_Abandon_Tips") or "", sName)
  sTip = sAlert
  
  local function confirmCallback()
    self:PlayCloseAni(true)
    self._mapNode.imgBlocker:SetActive(true)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sTip,
    callbackConfirm = confirmCallback,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function VampireSurvivorPauseCtrl:OnBtnClick_Close(btn)
  self:PlayCloseAni(false)
end

function VampireSurvivorPauseCtrl:OnBtnClick_Char(btn, nIndex)
end

function VampireSurvivorPauseCtrl:OnBtnClick_Skill(btn)
  local mapCharData = self._panel._bTrialBuild and self._panel.mapCharData or nil
  EventManager.Hit(EventId.OpenPanel, PanelId.PopupSkillPanel, self.tbChar, false, nil, mapCharData)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function VampireSurvivorPauseCtrl:OnBtnClick_Settings(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleSettings)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function VampireSurvivorPauseCtrl:OnEvent_Reopen(sName)
  if sName ~= "VampireSurvivorPauseCtrl" then
    return
  end
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType == AllEnum.GamepadUIType.Other then
    return
  end
  self._mapNode.ActionBar.gameObject:SetActive(true)
end

return VampireSurvivorPauseCtrl
