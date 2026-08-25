local typeof = _ENV.typeof
local Animator = CS.UnityEngine.Animator
local AwakerWeaponBreakthroughSuccessPanel, Super = System.NewClass("AwakerWeaponBreakthroughSuccessPanel", UIBasePanel)
AwakerWeaponBreakthroughSuccessPanel.uiResCls = UI_Awaker_Popup_Tip_ToppedResource

function AwakerWeaponBreakthroughSuccessPanel:ctor(model, closeCallback)
  Super.ctor(self)
  self.model = model
  self.closeCallback = closeCallback
end

function AwakerWeaponBreakthroughSuccessPanel:OnBind(binder)
  binder:BindComponent(WeaponForEnhanceResult(self.ui.UI_Common_Item_WuPin_Type1, self.model))
  binder:BindToRaw(function(_, preview)
    if not preview then
      return
    end
    binder:SetText(self.ui.Text_Grade, string.format("Lv.%s/%s", preview.level, preview.nextLevelLimit))
    local rootStarsTrans = self.ui.RootStars.transform
    for idx = 0, rootStarsTrans.childCount - 1 do
      local starGO = rootStarsTrans:GetChild(idx).gameObject
      starGO:SetActive(idx + 1 <= preview.nextBreakthroughStar)
    end
  end, function()
    do return self.model.GetEnhanceLevelBreakthroughPreview end
    return self.model.GetEnhanceLevelBreakthroughPreview, self.model
  end)
  binder:BindComponent(WeaponAttrComp(self.ui.UI_Awaker_Item_Weapon_Attribute, self.model, false))
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:OnCancelClick()
    self.closeCallback()
  end)
  local animator = self.ui.uiNode:GetComponent(typeof(Animator))
  AnimatorUtils.SetStateEndInBehavior(animator, "Close", System.fn(self, self.OnCancelClick))
end

function AwakerWeaponBreakthroughSuccessPanel:OnCancelClick()
  self:Close()
end

return AwakerWeaponBreakthroughSuccessPanel
