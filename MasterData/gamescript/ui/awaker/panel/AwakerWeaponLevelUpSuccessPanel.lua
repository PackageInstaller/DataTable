local typeof = _ENV.typeof
local Animator = CS.UnityEngine.Animator
local AwakerWeaponLevelUpSuccessPanel, Super = System.NewClass("AwakerWeaponLevelUpSuccessPanel", UIBasePanel)
AwakerWeaponLevelUpSuccessPanel.uiResCls = UI_Awaker_Weapon_Enhance_SuccessResource

function AwakerWeaponLevelUpSuccessPanel:ctor(model, closeCallback)
  Super.ctor(self)
  self.model = model
  self.closeCallback = closeCallback
end

function AwakerWeaponLevelUpSuccessPanel:OnBind(binder)
  binder:BindComponent(WeaponForEnhanceResult(self.ui.UI_Common_Item_WuPin_Type1, self.model))
  binder:BindToRaw(function(_, levelChange)
    binder:SetText(self.ui.Text_Level_Before, "Lv." .. levelChange.before)
    binder:SetText(self.ui.Text_Level_After, "Lv." .. levelChange.after)
    self.ui.Image_Level_V_Arrow:SetActive(levelChange.after > levelChange.before)
  end, function()
    do return self.model.GetEnhanceLevelPreview end
    return self.model.GetEnhanceLevelPreview, self.model
  end)
  binder:BindComponent(WeaponAttrComp(self.ui.UI_Awaker_Item_Weapon_Attribute, self.model, true))
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:OnCancelClick()
    self.closeCallback()
  end)
  local animator = self.ui.uiNode:GetComponent(typeof(Animator))
  AnimatorUtils.SetStateEndInBehavior(animator, "Close", System.fn(self, self.OnCancelClick))
end

function AwakerWeaponLevelUpSuccessPanel:OnCancelClick()
  self:Close()
end

return AwakerWeaponLevelUpSuccessPanel
