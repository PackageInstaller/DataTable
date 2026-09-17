local this = class("cellActivitySurveyKibo", G_UIModuleBase)

function this.bind()
  return {
    image = "",
    text = "",
    isFinish = false,
    score = ""
  }
end

function this.methods()
  return {
    onClick = function(self)
      if not self.bind.id then
        return
      end
      C_MapManager:trackBoki(self.bind.id)
    end
  }
end

function this:open()
end

function this:show()
end

return this
