local this = class("cellBossHpPoint", G_UIModuleBase)

function this.bind()
  return {active_point = false, active_curPoint = false}
end

return this
