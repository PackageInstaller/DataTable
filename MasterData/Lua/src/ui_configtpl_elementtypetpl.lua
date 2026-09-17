local this = class("elementTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getPetPuzzleIcon(tpl, index)
  if not index then
    return L_Config:getPathByHash(tpl.petPuzzleIcon)[1]
  end
  return L_Config:getPathByHash(tpl.petPuzzleIcon)[index]
end

function this:getPetElem(tpl)
  return tpl.petElem
end

function this:getKiBoCardIcon(tpl)
  return tpl.kiboCardIcon
end

function this:getKiboBoxCardEleIcon(tpl)
  return tpl.kiboBoxCardEleIcon
end

function this:getKiBoCardElementBg(tpl, index)
  if not index then
    return L_Config:getPathByHash(tpl.kiboCardEleBg)[1]
  end
  return L_Config:getPathByHash(tpl.kiboCardEleBg)[index]
end

function this:getKiboDuelCardElementImg(tpl, index)
  if not index then
    return tpl.kiboDuelCard[1]
  end
  return tpl.kiboDuelCard[index]
end

function this:getKiboDuelNameOutlineColor(tpl)
  return tpl.kiboDuelNameColor
end

function this:getProfessionColor(tpl, index)
  local hash = tpl.professionColor[index]
  if math.isEmpty(hash) or string.isEmpty(hash) then
    return ""
  end
  return L_Config:getPathByHash(hash)
end

function this:getElementIcon(tpl, index)
  local hash = tpl.elementIcon[index]
  if math.isEmpty(hash) or string.isEmpty(hash) then
    return ""
  end
  return L_Config:getPathByHash(hash)
end

function this:getRoleElementIcon(tpl, index)
  local hash = tpl.teamElementIcon[index]
  if math.isEmpty(hash) or string.isEmpty(hash) then
    return ""
  end
  return L_Config:getPathByHash(hash)
end

function this:getSkillElem(tpl)
  local icon = L_Config:getPathByHash(tpl.skillElem)
  return icon
end

function this:getAbbrName(tpl)
  return L_Config:provider(tpl.abbrName)
end

function this:getElementColor(tpl)
  return tpl.elementColor
end

function this:getDungeonElementIcon(tpl)
  return tpl.dungeonElementIcon
end

function this:getDungeonElementColor(tpl)
  return tpl.dungeonElementColor
end

function this:getProfessionRectangleColor(tpl)
  return tpl.professionRectangleColor
end

function this:getAdmissioneffects(tpl)
  return tpl.admissioneffects
end

function this:getElementiconography(tpl, index)
  return tpl.elementiconography[index]
end

function this:getElementPetBox(tpl)
  return tpl.elementPetBox
end

function this:getElementRestraint(tpl)
  return tpl.restraint
end

return this
