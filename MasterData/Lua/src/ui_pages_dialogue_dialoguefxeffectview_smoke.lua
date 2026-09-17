local smoke = class("smoke", G_UIModuleBase)

function smoke.bind()
  return {playAnimation = ""}
end

function smoke.methods()
  return {}
end

function smoke:open()
end

function smoke:setEffect(params)
  self.bind.playAnimation = "anim_story_smoke_in"
end

function smoke:stopEffect()
  self.bind.playAnimation = "anim_story_smoke_fade"
end

function smoke:dispose()
end

return smoke
