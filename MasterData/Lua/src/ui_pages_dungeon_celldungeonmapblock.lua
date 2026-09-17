local this = class("cellDungeonMapBlock", G_UIModuleBase)

function this.bind()
  return {
    img_road = "",
    localPos_road = L_Vector3.zero,
    localRot_road = L_Vector3.zero
  }
end

function this.methods()
  return {}
end

return this
