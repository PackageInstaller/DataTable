local this = class("ui_preview_state_transition_shell", G_BaseConfig)
local core = G_Tables.TDUiPreviewStateTransitionTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {}
this.keyToMethodsMap = {}
return this
