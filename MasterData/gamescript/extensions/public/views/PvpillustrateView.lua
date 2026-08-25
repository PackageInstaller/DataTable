local PvpillustrateView, Super = NewClass("PvpillustrateView", CommonillustrateView)

function PvpillustrateView:ctor()
  local title = LT.Text("RuleTipsTitle")
  local content = LT.Textf("PVPInstructions", PlayerDataUtils.GetRoleData().dayExp or 0, PlayerDataUtils.GetRoleDayExpLimit())
  Super.ctor(self, title, content)
end

function PvpillustrateView:_EstimateIsLarge()
  return true
end

function PvpillustrateView:OnEnterView()
  Super.OnEnterView(self)
  local gameObject = GameObject.Instantiate(self.ui.Group_Item, self.ui.Content:GetComponent(typeof(CS.UnityEngine.Transform)))
  gameObject:SetActive(true)
  local comp = self:AddViewComponent(gameObject, CompCommonillustrateItem, {
    title = LT.Text("PvpRuleTipsCreationTitle"),
    creationTidList = DT.GetOriginalConstant("RotationModeRelicConfig")
  })
  self._contentItems[#self._contentItems + 1] = comp
end

return PvpillustrateView
