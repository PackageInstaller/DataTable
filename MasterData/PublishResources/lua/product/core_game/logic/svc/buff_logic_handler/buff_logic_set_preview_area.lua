_class("BuffLogicSetPreviewArea", BuffLogicBase)
BuffLogicSetPreviewArea = BuffLogicSetPreviewArea

function BuffLogicSetPreviewArea:Constructor(buffInstance, logicParam)
  self._previewArea = logicParam.previewArea
end

function BuffLogicSetPreviewArea:DoLogic()
  local e = self._buffInstance:Entity()
  local bodyArea = e:BodyArea()
  if not bodyArea then
    return
  end
  local previewArea = {}
  for i, v in ipairs(self._previewArea) do
    local pos = Vector2(v[1], v[2])
    table.insert(previewArea, pos)
  end
  bodyArea:SetPreviewArea(previewArea)
end
