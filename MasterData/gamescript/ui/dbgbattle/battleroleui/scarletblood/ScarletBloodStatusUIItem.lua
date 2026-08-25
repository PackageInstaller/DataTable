local ScarletBloodStatusUIItem, Super = System.NewComponent("ScarletBloodStatusUIItem")
local GameObject = CS.UnityEngine.GameObject

function ScarletBloodStatusUIItem:ctor(uiNode, role)
  Super.ctor(self)
  self.ui = {uiNode = uiNode}
  self.role = role
  self.items = {}
  self.slots = {}
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function ScarletBloodStatusUIItem:OnBind(binder)
  self.binder = binder
  local slotPrefab = binder:LoadAsset("UI/UI_Battle/UI_Battle_Prefab/UI_Battle_ScarletBlood_Item_Bg.prefab")
  binder:BindToRaw(function(_, nowVal, oldVal)
    local max = math.max(nowVal, #self.slots)
    for i = 1, max do
      if i <= nowVal then
        if self.slots[i] == nil then
          local slot = self.binder:Instantiate(slotPrefab, self.ui.uiNode.transform)
          self.slots[i] = slot
        end
      elseif self.slots[i] ~= nil then
        GameObject.Destroy(self.slots[i])
        self.slots[i] = nil
        if nil ~= self.items[i] then
          self.items[i] = nil
        end
      end
    end
  end, function()
    do return self.role.GetProperty, self.role end
    return self.role.GetProperty, self.role, bc.BattleProperty.max_scarlet_blood_count
  end)
  self.activePrefab = binder:LoadAsset("UI/UI_Battle/UI_Battle_Prefab/UI_Battle_ScarletBlood_Item_Active.prefab")
  binder:BindToRaw(function(_, nowVal, _)
    self:CreateItem(nowVal)
  end, function()
    do return self.role.GetProperty, self.role end
    return self.role.GetProperty, self.role, bc.BattleProperty.scarlet_blood_count
  end)
end

function ScarletBloodStatusUIItem:CreateItem(nowVal)
  local max = math.max(nowVal, #self.items)
  for i = 1, max do
    if i <= nowVal then
      if self.items[i] == nil and i <= #self.slots then
        local scarlet = self.binder:Instantiate(self.activePrefab, self.slots[i].transform)
        local item = UI_Battle_ScarletBlood_Item_ActiveResource(scarlet)
        self.items[i] = item
      end
    elseif self.items[i] ~= nil then
      local index = i
      local item = self.items[index]
      GameObject.Destroy(item.uiNode)
      self.items[index] = nil
    end
  end
end

function ScarletBloodStatusUIItem:OnUnbind()
  local maxScarletBlood = self.role:GetProperty(bc.BattleProperty.max_scarlet_blood_count)
  for i = 1, maxScarletBlood do
    if self.slots[i] ~= nil then
      GameObject.Destroy(self.slots[i])
    end
  end
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

return ScarletBloodStatusUIItem
