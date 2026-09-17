local this = class("cellKiboDuelPoint", G_UIModuleBase)

function this.bind()
  return {toggle_condition = false}
end

function this:open(options)
end

function this:refresh()
  if self.bind.toggle_condition == false then
    self.bindComponents.pointAnim:Play("anim_petduel_skill_point_use")
  end
end

return this
