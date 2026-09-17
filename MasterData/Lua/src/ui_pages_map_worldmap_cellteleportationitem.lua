local this = class("cellTeleportationItem", G_UIModuleBase)

function this.bind()
  return {
    go_active = false,
    go_normal = false,
    localPosition_position = Unity.Vector3.zero
  }
end

return this
