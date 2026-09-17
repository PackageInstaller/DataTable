local this = class("ui_view_shell", G_BaseConfig)
local core = G_Tables.TDUiViewTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {
  id = 0,
  viewName = 1,
  panelType = 2,
  queue = 3,
  position = 4,
  flyMsgType = 5,
  priority = 6,
  replay = 7,
  checkshowfun = 8,
  queueType = 9,
  guide = 10,
  blockIgnore = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getViewname(offset)
  return core:GetVString(offset, this.indexMap.viewName).value
end

function this:_getPaneltype(offset)
  return core:GetInt(offset, this.indexMap.panelType)
end

function this:_getQueue(offset)
  return core:GetInt(offset, this.indexMap.queue)
end

function this:_getPosition(offset)
  return core:GetInt(offset, this.indexMap.position)
end

function this:_getFlymsgtype(offset)
  return core:GetInt(offset, this.indexMap.flyMsgType)
end

function this:_getPriority(offset)
  return core:GetInt(offset, this.indexMap.priority)
end

function this:_getReplay(offset)
  return core:GetInt(offset, this.indexMap.replay)
end

function this:_getCheckshowfun(offset)
  return core:GetVString(offset, this.indexMap.checkshowfun).value
end

function this:_getQueuetype(offset)
  return core:GetInt(offset, this.indexMap.queueType)
end

function this:_getGuide(offset)
  return core:GetInt(offset, this.indexMap.guide)
end

function this:_getBlockignore(offset)
  local str = core:GetVString(offset, this.indexMap.blockIgnore).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  viewName = this._getViewname,
  panelType = this._getPaneltype,
  queue = this._getQueue,
  position = this._getPosition,
  flyMsgType = this._getFlymsgtype,
  priority = this._getPriority,
  replay = this._getReplay,
  checkshowfun = this._getCheckshowfun,
  queueType = this._getQueuetype,
  guide = this._getGuide,
  blockIgnore = this._getBlockignore
}
return this
