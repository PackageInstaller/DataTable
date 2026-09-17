local this = class("task_end_wait_ui_shell", G_BaseConfig)
local core = G_Tables.TDTaskEndWaitUiTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, uiName = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getUiname(offset)
  return core:GetVString(offset, this.indexMap.uiName).value
end

this.keyToMethodsMap = {
  id = this._getId,
  uiName = this._getUiname
}
return this
