_class("UIFightSkillActiveVar", UICustomWidget)
UIFightSkillActiveVar = UIFightSkillActiveVar
local UIFightSkillActiveVarFromType = {
  Detail = 0,
  Shop = 1,
  Battle = 2
}
_enum("UIFightSkillActiveVarFromType", UIFightSkillActiveVarFromType)

function UIFightSkillActiveVar:Constructor()
  self._spaceTab = {
    [UIFightSkillActiveVarFromType.Detail] = {
      [1] = Vector2(25, 0),
      [2] = Vector2(25, 0),
      [3] = Vector2(25, 0),
      [4] = Vector2(6, 0)
    },
    [UIFightSkillActiveVarFromType.Shop] = {
      [1] = Vector2(25, 0),
      [2] = Vector2(25, 0),
      [3] = Vector2(15, 0),
      [4] = Vector2(3, 0)
    },
    [UIFightSkillActiveVarFromType.Battle] = {
      [1] = Vector2(18, 0),
      [2] = Vector2(18, 0),
      [3] = Vector2(18, 0),
      [4] = Vector2(4, 0)
    }
  }
end

function UIFightSkillActiveVar:OnShow(uiParams)
  self._pool = self:GetUIComponent("UISelectObjectPath", "varPointPool")
  self._group = self:GetUIComponent("GridLayoutGroup", "varPointPool")
end

function UIFightSkillActiveVar:SetData(count, idx, callback, UIFightSkillActiveVarFromType)
  self._count = count
  self._group.spacing = self._spaceTab[UIFightSkillActiveVarFromType][count]
  self._idx = idx
  self._callback = callback
  self._pool:SpawnObjects("UIFightSkillActiveVarPoint", self._count)
  self._items = self._pool:GetAllSpawnList()
  self:FlushIdx()
end

function UIFightSkillActiveVar:FlushIdx()
  if self._items then
    for i = 1, self._count do
      local item = self._items[i]
      item:SetData(i, self._idx)
    end
  end
end

function UIFightSkillActiveVar:BtnOnClick()
  if self._callback then
    self._idx = self._idx + 1
    if self._idx > self._count then
      self._idx = self._idx - self._count
    end
    self._callback(self._idx)
    self:FlushIdx()
  end
end
