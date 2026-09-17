local this = class("ui_guide_group_shell", G_BaseConfig)
local core = G_Tables.TDUiGuideGroupTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, taskId = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTaskid(offset)
  return core:GetInt(offset, this.indexMap.taskId)
end

this.keyToMethodsMap = {
  id = this._getId,
  taskId = this._getTaskid
}
return this
