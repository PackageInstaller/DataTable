local MonsterHpNumItem, Super = System.NewComponent("MonsterHpNumItem")

function MonsterHpNumItem:ctor(uiNode, role, index)
  Super.ctor(self)
  self.ui = UI_Battle_HpNumResource(uiNode)
  self.role = role
  self.index = index
end

function MonsterHpNumItem:OnBind(binder)
  self.binder = binder
  self.hpNum = self.role:GetHpNum()
  self.ui.UI_Vx_Group_Boss_HpNum_Disappear:SetActive(false)
  self.ui.UI_Vx_Group_Boss_HpNum_Aappear:SetActive(false)
  self.ui.Hp_Light:SetActive(false)
  self.ui.uiNode.transform.anchoredPosition = CS.UnityEngine.Vector2(17 * (self.index - 1), 0)
  self.timer = self.binder:BindTimer(1 * self.index - 1, 0, nil, function()
    self:InitItem()
  end)
end

function MonsterHpNumItem:InitItem()
  local hpNum = self.role:GetHpNum()
  self.ui.UI_Vx_Group_Boss_HpNum_Aappear:SetActive(self.index <= self.hpNum)
  self.ui.Hp_Light:SetActive(self.index <= self.hpNum)
  if self.timer then
    self.binder:StopTimer(self.timer)
  end
end

function MonsterHpNumItem:DisappearItem(hpNum)
  if hpNum >= self.hpNum then
    return
  end
  self.ui.UI_Vx_Group_Boss_HpNum_Aappear:SetActive(false)
  self.ui.UI_Vx_Group_Boss_HpNum_Disappear:SetActive(true)
  self.ui.Hp_Light:SetActive(false)
end

function MonsterHpNumItem:ShowItem(hpNum)
  self.ui.UI_Vx_Group_Boss_HpNum_Aappear:SetActive(true)
  self.ui.UI_Vx_Group_Boss_HpNum_Disappear:SetActive(false)
  self.ui.Hp_Light:SetActive(true)
end

function MonsterHpNumItem:OnUnbind()
  self.ui.UI_Vx_Group_Boss_HpNum_Disappear:SetActive(false)
  self.ui.UI_Vx_Group_Boss_HpNum_Aappear:SetActive(false)
  if self.timer then
    self.binder:StopTimer(self.timer)
  end
end

return MonsterHpNumItem
