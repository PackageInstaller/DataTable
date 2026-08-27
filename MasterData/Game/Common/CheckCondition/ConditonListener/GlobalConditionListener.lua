local GlobalConditionListener = class("GlobalConditionListener")
local ConditionListener = require("Game.Common.CheckCondition.ConditonListener.ConditionListener")

function GlobalConditionListener:ctor()
  self.__ConditionListener = ConditionListener.New()
end

function GlobalConditionListener:GetConditionListener()
  return self.__ConditionListener
end

function GlobalConditionListener:AddConditionChangeListener(listenerId, callback, ...)
  self.__ConditionListener:AddConditionChangeListener(listenerId, callback, ...)
end

function GlobalConditionListener:RemoveConditionChangeListener(listenerId)
  self.__ConditionListener:RemoveConditionChangeListener(listenerId)
end

function GlobalConditionListener:Delete()
  self.__ConditionListener:Delete()
end

return GlobalConditionListener
