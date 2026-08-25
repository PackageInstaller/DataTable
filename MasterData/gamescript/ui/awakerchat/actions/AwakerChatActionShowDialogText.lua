local AwakerChatActionShowDialogText, Super = System.NewClass("AwakerChatActionShowDialogText", AwakerChatActionBase)

function AwakerChatActionShowDialogText:ctor(...)
  Super.ctor(self, ...)
end

function AwakerChatActionShowDialogText:DoAction(_, showText, finishCb)
end

return AwakerChatActionShowDialogText
