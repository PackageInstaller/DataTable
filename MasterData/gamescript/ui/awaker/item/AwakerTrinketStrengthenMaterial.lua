local Button = CS.UnityEngine.UI.Button
local AwakerTrinketStrengthenMaterial, Super = System.NewComponent("AwakerTrinketStrengthenMaterial", CommonIconItem)

function AwakerTrinketStrengthenMaterial:ctor(res, data)
  Super.ctor(self, res, data)
  local cfg = DT.Item[data.tid]
  self.isTrinket = cfg.Type == CommonDefine.ItemType.Trinket
  self.isWeapon = cfg.Type == CommonDefine.ItemType.Weapon
  self.strengthenModel = data.strengthenModel
end

function AwakerTrinketStrengthenMaterial:BindPress(binder)
  self.binder = binder
  if self.isTrinket or self.isWeapon then
    self:_BindPressDown(binder)
  else
    binder:BindLongPressButton(self.ui.Btn_Click, System.fn(self, self.OnLongPress), System.fn(self, self.OnLongPress), tonumber(DT.GetConstant("Role_Press_Time")), true)
  end
end

function AwakerTrinketStrengthenMaterial:IsCanLongPress()
  self.strengthenModel:GetTrinketMaxLevel(self.strengthenModel.strengthenTid)
  local model = self.strengthenModel
  local currLevel = model.currTrinketLevel
  local maxLevel = model:GetTrinketMaxLevel(model.strengthenTid)
  local afterLevelData = model.afterLevelData
  if afterLevelData.isMaxLevel then
    return false
  end
  if currLevel >= maxLevel then
    return false
  end
  local chosenData = model.chosenUidMap[self.uid.value]
  local chosenCount = chosenData and chosenData.num or 0
  local item = ItemDataUtils.GetItemByUid(self.uid.value)
  local totalCount = item and item.num or 0
  if chosenCount == totalCount then
    return false
  end
  return true
end

function AwakerTrinketStrengthenMaterial:OnLongPress(triggeredTimes)
  if self:IsCanLongPress() then
    for i = 1, math.min(5, triggeredTimes or 1) do
      self:OnClick()
    end
  else
    self:OnClick()
  end
  if not self:IsCanLongPress() then
    self.binder:CancelRepeatButtonPress(self.ui.Btn_Click)
  end
end

function AwakerTrinketStrengthenMaterial:_BindPressDown(binder)
  local btnObj = self.ui.Btn_Click:GetComponent(typeof(Button))
  if not btnObj then
    self.ui.Btn_Click:AddComponent(typeof(Button))
  end
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
end

return AwakerTrinketStrengthenMaterial
