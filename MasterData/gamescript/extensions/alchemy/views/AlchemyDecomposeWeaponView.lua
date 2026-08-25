local AlchemyDecomposeWeaponView, Super = NewClass("AlchemyDecomposeWeaponView", AlchemyDecomposeBaseView)

function AlchemyDecomposeWeaponView:ctor()
  Super.ctor(self)
  AlchemyDecomposeWeaponView.uiResCls = UI_Alchemy_Popup_ResolveWeapon_OptimizeResource
  self.model = AlchemyDecomposeWeaponExtModel.Instance
  self.model:OnInit(CommonDefine.ItemType.Weapon)
end

function AlchemyDecomposeWeaponView:RefreshOnRendered()
  self.model:SetCurSelectItemUidGroup({})
  self.model:SetIsSelectAll(false)
  self.model:Set_curSelectUid(0, true)
  self.model:Update_curDecompositeList()
  self:RefreshView()
end

function AlchemyDecomposeWeaponView:RegisterEvents()
  Super.RegisterEvents(self)
  self:AddButtonClickListener(self.ui.Btn_Role, System.fn(self, self._OnClickRule))
end

function AlchemyDecomposeWeaponView:_OnClickRule()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RuleTipsTitle"), LT.Text("AlchemyDecomposeWeaponRuleContent"))
end

function AlchemyDecomposeWeaponView:GetBagCapacity()
  local limitList = DT.GetOriginalConstant("BagCapacity")
  return limitList and limitList[1] or 0
end

function AlchemyDecomposeWeaponView:CheckCanAddDecompose(uid)
  do return AwakerWeaponExtModel.Instance.IsWeaponUsing, AwakerWeaponExtModel.Instance end
  return AwakerWeaponExtModel.Instance.IsWeaponUsing, AwakerWeaponExtModel.Instance, uid
end

return AlchemyDecomposeWeaponView
