local AwakerChatActionSetOption = System.NewClass("AwakerChatActionSetOption", AwakerChatActionBase)

function AwakerChatActionSetOption:DoAction(_, _, finishCb)
  finishCb()
end

return AwakerChatActionSetOption
