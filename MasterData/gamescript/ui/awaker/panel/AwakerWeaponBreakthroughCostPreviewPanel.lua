local typeof = _ENV.typeof
local Animator = CS.UnityEngine.Animator
local AwakerWeaponBreakthroughCostPreviewPanel, Super = System.NewClass("AwakerWeaponBreakthroughCostPreviewPanel", UIBasePanel)
AwakerWeaponBreakthroughCostPreviewPanel.uiResCls = UI_Awaker_Popup_Tip_PreviewResource

function AwakerWeaponBreakthroughCostPreviewPanel:ctor(model)
  Super.ctor(self)
  self.model = model
end

function AwakerWeaponBreakthroughCostPreviewPanel:OnBind(binder)
  local preview = self.model:GetPreview()
  local mtrlRootTrans = self.ui.MaterialRoot.transform
  for idx = 0, mtrlRootTrans.childCount - 1 do
    local mtrlGO = mtrlRootTrans:GetChild(idx).gameObject
    local mtrlCost = preview.mtrl[idx + 1]
    if mtrlCost and mtrlCost.id then
      mtrlGO:SetActive(true)
      local item = ItemDataUtils.GetItemByTid(mtrlCost.id)
      local itemInfo = {
        id = mtrlCost.id,
        currCount = item and item.num or 0,
        requiredCount = mtrlCost.count
      }
      binder:BindComponent(AwakerBreakthroughMaterial(mtrlGO, itemInfo, false))
    else
      mtrlGO:SetActive(false)
    end
  end
  binder:SetText(self.ui.Text_Coin_Count, preview.gold)
  binder:SetText(self.ui.Text_Prompt, LT.Textf("WeaponBreakthroughTip", preview.weaponLevel))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.OnCancelClick))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.OnCancelClick))
  local animator = self.ui.uiNode:GetComponent(typeof(Animator))
  AnimatorUtils.SetStateEndInBehavior(animator, "Close", System.fn(self, self.OnCancelClick))
end

function AwakerWeaponBreakthroughCostPreviewPanel:OnCancelClick()
  self:Close()
end

return AwakerWeaponBreakthroughCostPreviewPanel
