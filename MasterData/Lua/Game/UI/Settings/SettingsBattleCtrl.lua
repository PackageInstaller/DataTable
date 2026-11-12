local SettingsBattleCtrl = class("SettingsBattleCtrl", BaseCtrl)
local ModuleManager = require("GameCore.Module.ModuleManager")
local UIGameSystemSetup = CS.UIGameSystemSetup
local BattleAnimTypeEnum = {
  UIGameSystemSetup.TimeLinePlayType.dayOnce,
  UIGameSystemSetup.TimeLinePlayType.everyTime,
  UIGameSystemSetup.TimeLinePlayType.none
}
SettingsBattleCtrl._mapNodeConfig = {
  txtPageTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Game"
  },
  txtAnim1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Animation"
  },
  txtAnim2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_AnimationSub"
  },
  txtBattleHUD = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_BattleHUD_Title"
  },
  txtAnim4 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_DamageHUD_Title"
  },
  Anim1 = {
    sCtrlName = "Game.UI.Settings.OptionChooseCtrl"
  },
  Anim2 = {
    sCtrlName = "Game.UI.Settings.OptionChooseCtrl"
  },
  Anim3 = {
    sCtrlName = "Game.UI.Settings.OptionChooseCtrl"
  },
  Anim4 = {
    sCtrlName = "Game.UI.Settings.OptionChooseCtrl"
  },
  JoyStick = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  Gizmos = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  Mouse = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  AutoUlt = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  BattleHudList = {}
}
SettingsBattleCtrl._mapEventConfig = {
  SettingsChangeL2d = "OnEvent_ChangeL2d"
}

function SettingsBattleCtrl:RefreshText()
  self._mapNode.Anim1:SetText(ConfigTable.GetUIText("Settings_Animation_One"), ConfigTable.GetUIText("Settings_Animation_Open"), ConfigTable.GetUIText("Settings_Animation_Close"))
  self._mapNode.Anim2:SetText(ConfigTable.GetUIText("Settings_Animation_One"), ConfigTable.GetUIText("Settings_Animation_Open"), ConfigTable.GetUIText("Settings_Animation_Close"))
  self._mapNode.Anim3:SetText(ConfigTable.GetUIText("Settings_BattleHUD_Type1"), ConfigTable.GetUIText("Settings_BattleHUD_Type2"), "")
  self._mapNode.Anim4:SetText(ConfigTable.GetUIText("Settings_DamageHUD_Default"), ConfigTable.GetUIText("Settings_DamageHUD_Merge"), ConfigTable.GetUIText("Settings_DamageHUD_Close"))
  self._mapNode.JoyStick:SetText(ConfigTable.GetUIText("Settings_JoyStick"))
  self._mapNode.Gizmos:SetText(ConfigTable.GetUIText("Settings_Gizmos"))
  self._mapNode.Mouse:SetText(ConfigTable.GetUIText("Settings_Mouse"))
  self._mapNode.AutoUlt:SetText(ConfigTable.GetUIText("Settings_AutoBattle_Ultra"))
end

function SettingsBattleCtrl:Init()
  if self.bInit then
    return
  end
  self.bInit = true
  self:LoadSetting()
end

function SettingsBattleCtrl:Quit()
  if not self.bInit then
    return
  end
end

function SettingsBattleCtrl:LoadSetting()
  self.battleAnim = self._panel:LoadLocalData("Animation")
  self._mapNode.Anim1:Init(function(index)
    UIGameSystemSetup.Instance.PlayType = BattleAnimTypeEnum[index]
    self.battleAnim = index
  end, self.battleAnim)
  self.battleAnim2 = self._panel:LoadLocalData("AnimationSub")
  local bUseLive2D = self._panel:LoadLocalData("UseLive2D")
  if bUseLive2D == false then
    self._mapNode.Anim2:SetGray({
      [1] = true,
      [2] = true
    }, ConfigTable.GetUIText("Settings_SubSkillDisable"))
    self.battleAnim2 = 3
  else
    self._mapNode.Anim2:SetGray()
  end
  self._mapNode.Anim2:Init(function(index)
    self.battleAnim2 = index
  end, self.battleAnim2)
  self.battleHud = self._panel:LoadLocalData("BattleHUD")
  self._mapNode.Anim3:Init(function(index)
    self.battleHud = index
  end, self.battleHud, 2)
  self._mapNode.Mouse.gameObject:SetActive(false)
  self.floatingJoyStick = self._panel:LoadLocalData("JoyStick")
  self._mapNode.JoyStick:Init(function()
    self.floatingJoyStick = not self.floatingJoyStick
    UIGameSystemSetup.Instance.EnableFloatingJoyStick = self.floatingJoyStick
    EventManager.Hit("SetVariableJoystickMode")
  end, self.floatingJoyStick)
  self.gizmos = self._panel:LoadLocalData("Gizmos")
  self._mapNode.Gizmos:Init(function()
    self.gizmos = not self.gizmos
    UIGameSystemSetup.Instance.EnableAttackGizmos = self.gizmos
    if ModuleManager.GetIsAdventure() then
      CS.AdventureModuleHelper.Lua2CSharp_ChangeVisionAttackRange(self.gizmos)
    end
  end, self.gizmos)
  self.autoUlt = self._panel:LoadLocalData("AutoUlt")
  self._mapNode.AutoUlt:Init(function()
    self.autoUlt = not self.autoUlt
    UIGameSystemSetup.Instance.EnableAutoUlt = self.autoUlt
  end, self.autoUlt)
  self.hudDamage = self._panel:LoadLocalData("HudDamageShow")
  self._mapNode.Anim4:Init(function(index)
    self.hudDamage = index
  end, self.hudDamage)
end

function SettingsBattleCtrl:SaveSetting()
  self._panel:SaveLocalData("Animation", self.battleAnim)
  self._panel:SaveLocalData("AnimationSub", self.battleAnim2)
  if not NovaAPI.IsMobilePlatform() then
    self._panel:SaveLocalData("Mouse", self.openMouse)
  end
  self._panel:SaveLocalData("JoyStick", self.floatingJoyStick)
  self._panel:SaveLocalData("Gizmos", self.gizmos)
  self._panel:SaveLocalData("AutoUlt", self.autoUlt)
  self._panel:SaveLocalData("BattleHUD", self.battleHud)
  self._panel:SaveLocalData("HudDamageShow", self.hudDamage)
end

function SettingsBattleCtrl:Awake()
  self.bInit = false
  local bMobile = NovaAPI.IsMobilePlatform()
  self._mapNode.JoyStick.gameObject:SetActive(bMobile)
  self:RefreshText()
end

function SettingsBattleCtrl:OnEnable()
end

function SettingsBattleCtrl:OnDisable()
  if not self.bInit then
    return
  end
  self:SaveSetting()
  EventManager.Hit(EventId.SettingsBattleClose)
end

function SettingsBattleCtrl:OnDestroy()
end

function SettingsBattleCtrl:OnEvent_ChangeL2d(bUseLive2D)
  self:Init()
  if bUseLive2D == false then
    self._mapNode.Anim2:SetGray({
      [1] = true,
      [2] = true
    }, ConfigTable.GetUIText("Settings_SubSkillDisable"))
    self.battleAnim2 = 3
  else
    self._mapNode.Anim2:SetGray()
  end
  self._mapNode.Anim2:Init(function(index)
    self.battleAnim2 = index
  end, self.battleAnim2)
end

return SettingsBattleCtrl
