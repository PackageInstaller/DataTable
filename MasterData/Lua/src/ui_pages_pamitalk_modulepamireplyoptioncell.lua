local module = class("modulePamiReplyOptionCell", G_UIModuleBase)

function module.bind()
  return {optionText = ""}
end

function module.methods()
  return {
    onClick_option = function(self)
      L_PamiTalkStore:req_chooseReply(self.bind.letterTextId, self.bind.id)
    end
  }
end

function module:refresh()
  local pamiLetterReplyTpl = L_GameTpl:getPamiLetterReplyTpl()
  self.bind.optionText = L_Config:provider(pamiLetterReplyTpl:getChoiceTitle(self.bind.replyTpl))
end

return module
