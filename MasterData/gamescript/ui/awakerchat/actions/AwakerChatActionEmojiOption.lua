local AwakerChatActionEmojiOption = System.NewClass("AwakerChatActionSetOption", AwakerChatActionBase)

function AwakerChatActionEmojiOption:DoAction(_, _, finishCb)
  finishCb()
end

return AwakerChatActionEmojiOption
