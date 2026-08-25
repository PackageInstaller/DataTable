local MonsterWarnItem, Super = System.NewComponent("MonsterWarnItem")
local typeof = _ENV.typeof

function MonsterWarnItem:ctor(uiNode, position, tipsId)
  Super.ctor(self)
  self.uiNode = uiNode
  self.ui = UI_Battle_Item_Monster_WarnResource(self.uiNode)
  self.uiNode.transform.position = position
  local MAX_RELIC_NUM = DT.GetConstant("RelicMaximumNumber")
  local maxLit = CopyAwakerDataUtils.GetAwakerAttrs(0, "relic_num_limit")
  if MAX_RELIC_NUM < maxLit then
    local objRectTransform = self.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform))
    objRectTransform.anchoredPosition = CS.UnityEngine.Vector2(0, 782)
  end
  self.tipsId = tipsId
end

function MonsterWarnItem:OnBind(binder)
  self.binder = binder
  self.binder:LoadAllLangFont(self.ui.Text_Count)
  self.binder:SetText(self.ui.Text_Count, LT.Text(self.tipsId))
end

function MonsterWarnItem:SetActive(active)
  self.uiNode:SetActive(active)
end

function MonsterWarnItem:SetText(tipsId)
  self.tipsId = tipsId
  self.binder:SetText(self.ui.Text_Count, LT.Text(tipsId))
end

return MonsterWarnItem
