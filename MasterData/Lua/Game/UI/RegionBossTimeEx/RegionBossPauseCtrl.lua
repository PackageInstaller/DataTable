local RegionBossPauseCtrl = class("RegionBossPauseCtrl", BaseCtrl)
local GameCameraStackManager = CS.GameCameraStackManager.Instance
local AdventureModuleHelper = CS.AdventureModuleHelper
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
RegionBossPauseCtrl._mapNodeConfig = {
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
    sLanguageId = "MainBattle_Task"
  },
  txtAim = {nCount = 3, sComponentName = "TMP_Text"},
  goAim = {nCount = 3},
  imgOff = {nCount = 3},
  imgOn = {nCount = 3},
  txtTime = {sComponentName = "TMP_Text"},
  txtLeader = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
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
RegionBossPauseCtrl._mapEventConfig = {
  RegionBoss_Time_CountUp = "OnEvent_Time",
  OpenRegionBossPause = "Pause",
  GamepadUIReopen = "OnEvent_Reopen"
}

function RegionBossPauseCtrl:Refresh()
  local mapRogueBossLevel = {}
  local mapLevelInfo = {}
  local isWeekBoss = PlayerData.RogueBoss:GetIsWeeklyCopies()
  local showTimeCountMode = false
  if isWeekBoss then
    showTimeCountMode = true
  else
    mapRogueBossLevel = ConfigTable.GetData("RegionBossLevel", self.nLevelId)
    mapLevelInfo = PlayerData.RogueBoss:GetCacheBossLevelMsg(self.nLevelId)
    showTimeCountMode = mapRogueBossLevel.RegionType ~= GameEnum.RegionType.NormalRegion
  end
  if showTimeCountMode then
    for i = 1, 3 do
      self._mapNode.goAim[i]:SetActive(false)
    end
    for i = 1, 2 do
      self._mapNode.t_common_02_[i]:SetActive(false)
    end
    self._mapNode.imgBgTime:SetActive(false)
    self._mapNode.txtTime.gameObject:SetActive(false)
    self._mapNode.handObj:SetActive(true)
  else
    local curStar = 0
    if mapLevelInfo ~= nil then
      curStar = mapLevelInfo.Star
    end
    local tbCond = {}
    table.insert(tbCond, decodeJson(mapRogueBossLevel.OneStarCondition))
    table.insert(tbCond, decodeJson(mapRogueBossLevel.TwoStarCondition))
    table.insert(tbCond, decodeJson(mapRogueBossLevel.ThreeStarCondition))
    for i = 1, 3 do
      self._mapNode.imgOn[i]:SetActive(curStar >= i)
      self._mapNode.imgOff[i]:SetActive(curStar < i)
      local cond = tbCond[i]
      if cond == nil then
        self._mapNode.goAim[i]:SetActive(false)
        break
      else
        self._mapNode.goAim[i]:SetActive(true)
        if i == 1 then
          NovaAPI.SetTMPText(self._mapNode.txtAim[i], ConfigTable.GetUIText("RegionBoss_PassConfition_1"))
        elseif i == 2 then
          NovaAPI.SetTMPText(self._mapNode.txtAim[i], ConfigTable.GetUIText("RegionBoss_PassConfition_2"))
        else
          NovaAPI.SetTMPText(self._mapNode.txtAim[i], orderedFormat(ConfigTable.GetUIText("RegionBoss_PassConfition_3"), tbCond[2][2] - cond[2]))
        end
      end
    end
  end
  for i = 1, 3 do
    self._mapNode.goChar[i]:SetChar(self.tbChar[i])
  end
end

function RegionBossPauseCtrl:PlayInAni()
  self._mapNode.goBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.safeAreaRoot:SetActive(true)
    self._mapNode.aniWindow:Play("t_window_04_t_in")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  end
  
  cs_coroutine.start(wait)
end

function RegionBossPauseCtrl:PlayCloseAni(bGiveUp)
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, "OnPanelClose", true, true, true, bGiveUp)
end

function RegionBossPauseCtrl:OnPanelClose(_, bGiveUp)
  PanelManager.InputEnable()
  GamepadUIManager.DisableGamepadUI("RegionBossPauseCtrl")
  EventManager.Hit(EventId.BattleDashboardVisible, true)
  self._mapNode.safeAreaRoot:SetActive(false)
  self._mapNode.goBlur:SetActive(false)
  self._mapNode.imgBlocker:SetActive(false)
  if bGiveUp then
    EventManager.Hit(EventId.AbandonBattle)
  end
end

function RegionBossPauseCtrl:Awake()
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

function RegionBossPauseCtrl:OnEnable()
end

function RegionBossPauseCtrl:OnDisable()
end

function RegionBossPauseCtrl:OnDestroy()
end

function RegionBossPauseCtrl:Pause(nLevelId, tbCharId)
  self.tbChar = tbCharId
  self.nLevelId = nLevelId
  EventManager.Hit(EventId.BattleDashboardVisible, false)
  PanelManager.InputDisable()
  self:PlayInAni()
  self:Refresh()
  GamepadUIManager.EnableGamepadUI("RegionBossPauseCtrl", self.tbGamepadUINode)
end

function RegionBossPauseCtrl:OnEvent_Time(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.txtTime, string.format("%02d:%02d", nMin, nSec))
  NovaAPI.SetTMPText(self._mapNode.texHandTime, string.format("%02d:%02d", nMin, nSec))
end

function RegionBossPauseCtrl:OnBtnClick_GiveUp(btn)
  local sTip = ""
  local sName, sDifficulty = "", ""
  local isWeekBoss = PlayerData.RogueBoss:GetIsWeeklyCopies()
  if isWeekBoss then
    local weekBossLevel = ConfigTable.GetData("WeekBossLevel", self.nLevelId)
    if weekBossLevel then
      sName = weekBossLevel.Name
      sDifficulty = weekBossLevel.Difficulty
    end
  else
    local lvCacheBossLevelData = ConfigTable.GetData("RegionBossLevel", self.nLevelId)
    if lvCacheBossLevelData then
      sName = lvCacheBossLevelData.Name
      sDifficulty = lvCacheBossLevelData.Difficulty
    end
  end
  local sAlert = orderedFormat(ConfigTable.GetUIText("RogueBoss_Pause_GiveUpTips") or "", sName, sDifficulty)
  sTip = sAlert
  
  local function confirmCallback()
    print("点击确定")
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

function RegionBossPauseCtrl:OnBtnClick_Close(btn)
  self:PlayCloseAni(false)
end

function RegionBossPauseCtrl:OnBtnClick_Char(btn, nIndex)
end

function RegionBossPauseCtrl:OnBtnClick_Skill(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.PopupSkillPanel, self.tbChar)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function RegionBossPauseCtrl:OnBtnClick_Settings(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleSettings)
  self._mapNode.ActionBar.gameObject:SetActive(false)
end

function RegionBossPauseCtrl:OnEvent_Reopen(sName)
  if sName ~= "RegionBossPauseCtrl" then
    return
  end
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType == AllEnum.GamepadUIType.Other then
    return
  end
  self._mapNode.ActionBar.gameObject:SetActive(true)
end

return RegionBossPauseCtrl
