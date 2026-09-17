local cls = class("cellPetDuelLineNode", G_UIModuleBase)

function cls.bind()
  return {
    v2_offsetMin = C_Vector2.zero,
    v2_offsetMax = C_Vector2.zero,
    v2_pivot = C_Vector2.zero,
    v2_sizeDelta = C_Vector2.zero,
    v3_pos = C_Vector3.zero
  }
end

function cls.methods()
  return {}
end

function cls:refresh()
  if self.bind.posType == L_PetConst.PetDuelLinePosEnums.PreCondition then
    self.bind.v2_offsetMin = C_Vector2(0, 0.5)
    self.bind.v2_offsetMax = C_Vector2(0, 0.5)
    self.bind.v2_pivot = C_Vector2(1, 0.5)
    self.bind.v2_sizeDelta = C_Vector2(self.bind.sizeDelta, 4)
    self.bind.v3_pos = C_Vector3.zero
    return
  end
  if self.bind.posType == L_PetConst.PetDuelLinePosEnums.AfterCondition then
    self.bind.v2_offsetMin = C_Vector2(1, 0.5)
    self.bind.v2_offsetMax = C_Vector2(1, 0.5)
    self.bind.v2_pivot = C_Vector2(0, 0.5)
    self.bind.v2_sizeDelta = C_Vector2(self.bind.sizeDelta, 4)
    self.bind.v3_pos = C_Vector3.zero
    return
  end
  if self.bind.posType == L_PetConst.PetDuelLinePosEnums.Vertical then
    self.bind.v2_offsetMin = C_Vector2(0, 0.5)
    self.bind.v2_offsetMax = C_Vector2(0, 0.5)
    self.bind.v2_pivot = C_Vector2(0.5, 0.5)
    self.bind.v2_sizeDelta = C_Vector2(4, self.bind.sizeDelta)
    self.bind.v3_pos = C_Vector3(self.bind.posX, self.bind.posY, 0)
    return
  end
end

return cls
