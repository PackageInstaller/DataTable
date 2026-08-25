local AwakerChatActionBase, Super = System.NewClass("AwakerChatActionBase")

function AwakerChatActionBase:ctor(binder, avgPanel, avgModel)
  Super.ctor(self)
  self.binder = binder
  self.avgPanel = avgPanel
  self.ui = avgPanel.ui
  self.avgModel = avgModel
  self.actionId = string.replace(self.__name, "AvgAction", "")
end

function AwakerChatActionBase:DoAction(childBinder, actionIdData, finishCb)
  assert(false, "DoAction must be override")
  assert(childBinder and actionIdData and finishCb, "childBinder or actionIdData is nil")
end

function AwakerChatActionBase:FinishAction()
  assert(self.actionId, "actionId is nil")
  self.avgModel:FinishAction(self.actionId)
end

return AwakerChatActionBase
