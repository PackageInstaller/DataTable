local AutoBattleCtrl = class("AutoBattleCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
local AdventureModuleHelper = CS.AdventureModuleHelper
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
AutoBattleCtrl._mapNodeConfig = {
  btnAutoBattleOpen = {
    sComponentName = "NaviButton",
    callback = "OnClick_AutoBattleOpen",
    sAction = "AutoBattle"
  },
  btnAutoBattleClose = {
    sComponentName = "NaviButton",
    callback = "OnClick_AutoBattleClose",
    sAction = "AutoBattle"
  },
  txtBtnAutoBattleOpen = {
    nCount = 4,
    sComponentName = "TMP_Text",
    sLanguageId = "AutoBattle_Open"
  },
  txtBtnAutoBattleClose = {
    nCount = 4,
    sComponentName = "TMP_Text",
    sLanguageId = "AutoBattle_Close"
  },
  TMPSemiBattleHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoBattle_Hint"
  },
  rtAutoBattleHint = {}
}
AutoBattleCtrl._mapEventConfig = {
  LoadLevelRefresh = "Reset",
  InputEnable = "OnEvent_InputEnable",
  UpdateAutoCastUltimateSkill = "UpdateAutoCastUltimateSkill",
  ShowOrHideBattleDash = "OnEvent_ShowOrHideAutoBattle",
  CloseOrOpenAutoBattle = "OnEvent_CloseOrOpenAutoBattle"
}

function AutoBattleCtrl:Awake()
  self.nType = GameEnum.worldLevelType.Mainline
  self.bAuto = false
  self.animator = self.gameObject:GetComponent("Animator")
  self._mapNode.btnAutoBattleOpen.gameObject:SetActive(true)
  self._mapNode.btnAutoBattleClose.gameObject:SetActive(false)
  self._mapNode.rtAutoBattleHint.gameObject:SetActive(false)
  self.animator:Play("AutoBattle_Close")
end

function AutoBattleCtrl:Reset()
  local sKey = "PlayerAutoBattleState" .. self.nType
  local sData = LocalData.GetPlayerLocalData(sKey)
  local nState = tonumber(sData == nil and "0" or sData)
  self.bAuto = nState == 1
  if self.nType == GameEnum.worldLevelType.Dynamic and self.nSubType == GameEnum.dynamicLevelType.Tutorial then
    self.bAuto = false
  end
  local nDisableFloor = ConfigTable.GetConfigNumber("DisableAutoBattleFloor")
  if nDisableFloor ~= nil and self.nFloorId ~= nil and tonumber(self.nFloorId) == nDisableFloor then
    self.bAuto = false
  end
  self._mapNode.btnAutoBattleOpen.gameObject:SetActive(not self.bAuto)
  self._mapNode.btnAutoBattleClose.gameObject:SetActive(self.bAuto)
  self._mapNode.rtAutoBattleHint.gameObject:SetActive(self.bAuto and self.nType ~= GameEnum.worldLevelType.Mainline)
  if self.bAuto then
    self.animator:Play("AutoBattle_Open")
  else
    self.animator:Play("AutoBattle_Close")
  end
  CS.AdventureModuleHelper.SetSemiAutoBattleMode(self.bAuto)
  self:UpdateAutoCastUltimateSkill()
  if self.nType == GameEnum.worldLevelType.StarTower then
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_AutoBattleOpen")
  end
end

function AutoBattleCtrl:OnEnable()
  GamepadUIManager.AddGamepadUINode("BattleMenu", self:GetGamepadUINode())
end

function AutoBattleCtrl:SetBattleType(nType, nSubType, nFloorId)
  self.nType = nType
  self.nSubType = nSubType
  self.nFloorId = nFloorId
  if self.nType == GameEnum.worldLevelType.PrologueBattleLevel then
    self.gameObject.transform.localScale = Vector3.zero
  elseif self.nType == GameEnum.worldLevelType.Dynamic and self.nSubType == GameEnum.dynamicLevelType.Tutorial then
    self.gameObject.transform.localScale = Vector3.zero
  end
end

function AutoBattleCtrl:UpdateAutoCastUltimateSkill()
  local bAutoUlt = CS.UIGameSystemSetup.Instance.EnableAutoUlt
  CS.AdventureModuleHelper.SetAutoCastUltimateSkill(bAutoUlt)
end

function AutoBattleCtrl:OpenUI()
end

function AutoBattleCtrl:CloseUI()
end

function AutoBattleCtrl:OnDisable()
end

function AutoBattleCtrl:OnDestroy()
end

function AutoBattleCtrl:OnClick_AutoBattleOpen()
  self.bAuto = true
  self._mapNode.btnAutoBattleOpen.gameObject:SetActive(false)
  self._mapNode.btnAutoBattleClose.gameObject:SetActive(true)
  self._mapNode.rtAutoBattleHint.gameObject:SetActive(self.nType ~= GameEnum.worldLevelType.Mainline)
  CS.AdventureModuleHelper.SetSemiAutoBattleMode(true)
  local sKey = "PlayerAutoBattleState" .. self.nType
  LocalData.SetPlayerLocalData(sKey, 1)
  if self.nType == GameEnum.worldLevelType.InfinityTower then
    EventManager.Hit("ChangeAutoBattleState", true)
  end
  self.animator:Play("AutoBattle_Open")
end

function AutoBattleCtrl:OnClick_AutoBattleClose()
  self.bAuto = false
  self._mapNode.btnAutoBattleClose.gameObject:SetActive(false)
  self._mapNode.btnAutoBattleOpen.gameObject:SetActive(true)
  self._mapNode.rtAutoBattleHint.gameObject:SetActive(false)
  CS.AdventureModuleHelper.SetSemiAutoBattleMode(false)
  local sKey = "PlayerAutoBattleState" .. self.nType
  LocalData.SetPlayerLocalData(sKey, 0)
  if self.nType == GameEnum.worldLevelType.InfinityTower then
    EventManager.Hit("ChangeAutoBattleState", false)
  end
  self.animator:Play("AutoBattle_Close")
end

function AutoBattleCtrl:OnEvent_InputEnable(bEnable, bEnableByTrans)
  if self.isDisableAutoBattle then
    return
  end
  if bEnableByTrans == true then
    if bEnable == true and self.ENABLE == false then
      return
    end
  else
    self.ENABLE = bEnable
  end
  if self.nType == GameEnum.worldLevelType.PrologueBattleLevel then
    self.gameObject.transform.localScale = Vector3.zero
    self._mapNode.btnAutoBattleOpen.interactable = false
    self._mapNode.btnAutoBattleClose.interactable = false
    return
  elseif self.nType == GameEnum.worldLevelType.Dynamic and self.nSubType == GameEnum.dynamicLevelType.Tutorial then
    self.gameObject.transform.localScale = Vector3.zero
    self._mapNode.btnAutoBattleOpen.interactable = false
    self._mapNode.btnAutoBattleClose.interactable = false
    return
  end
  self.gameObject.transform.localScale = bEnable and Vector3.one or Vector3.zero
  self._mapNode.btnAutoBattleOpen.interactable = bEnable and true or false
  self._mapNode.btnAutoBattleClose.interactable = bEnable and true or false
end

function AutoBattleCtrl:OnEvent_ShowOrHideAutoBattle(isShow)
  self.gameObject.transform.localScale = isShow and Vector3.one or Vector3.zero
  self._mapNode.btnAutoBattleOpen.interactable = isShow and true or false
  self._mapNode.btnAutoBattleClose.interactable = isShow and true or false
end

function AutoBattleCtrl:OnEvent_CloseOrOpenAutoBattle(isShow)
  if isShow then
    CS.AdventureModuleHelper.SetSemiAutoBattleMode(false)
  end
  self.isDisableAutoBattle = not isShow
  self.gameObject.transform.localScale = isShow and Vector3.one or Vector3.zero
  self._mapNode.btnAutoBattleOpen.interactable = isShow and true or false
  self._mapNode.btnAutoBattleClose.interactable = isShow and true or false
end

return AutoBattleCtrl
