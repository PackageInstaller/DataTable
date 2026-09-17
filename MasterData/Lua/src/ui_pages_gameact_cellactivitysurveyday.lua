local this = class("cellActivitySurveyDay", G_UIModuleBase)

function this.bind()
  return {
    name = "",
    isSelect = false,
    isLock = false,
    isFinish = false
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      if self.bind.isLock then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("GAME_EVENT_KIBO_SURVEY_CLOSED"))
        return
      end
      self:emit("onClick_select", self.bind.id)
    end
  }
end

function this:open()
  self:registerReddot(self.bindComponents.reddotNew, string.format(L_ReddotManager.DotDef.GameAct_Events_Survey_New, self.bind.id))
  self:registerReddot(self.bindComponents.reddotNormal, string.format(L_ReddotManager.DotDef.GameAct_Events_Survey_Award, self.bind.id))
end

function this:show()
end

function this:refreshSelect(selectedId)
  self.bind.isSelect = self.bind.id ~= selectedId
end

return this
