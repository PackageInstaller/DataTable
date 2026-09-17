local this = class("world_range_filter_shell", G_BaseConfig)
local core = G_Tables.TDWorldRangeFilterTable.GetInstance()

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
  name = 1,
  note = 2,
  centerPoints = 3,
  ranges = 4,
  filters = 5,
  filterData = 6,
  pos = 7,
  templateName = 8,
  filterDesc = 9,
  posDesc = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  return core:GetVString(offset, this.indexMap.name).value
end

function this:_getNote(offset)
  return core:GetVString(offset, this.indexMap.note).value
end

function this:_getCenterpoints(offset)
  return core:GetVString(offset, this.indexMap.centerPoints).value
end

function this:_getRanges(offset)
  return core:GetVString(offset, this.indexMap.ranges).value
end

function this:_getFilters(offset)
  return core:GetVString(offset, this.indexMap.filters).value
end

function this:_getFilterdata(offset)
  return core:GetVString(offset, this.indexMap.filterData).value
end

function this:_getPos(offset)
  return core:GetVString(offset, this.indexMap.pos).value
end

function this:_getTemplatename(offset)
  return core:GetVString(offset, this.indexMap.templateName).value
end

function this:_getFilterdesc(offset)
  return core:GetVString(offset, this.indexMap.filterDesc).value
end

function this:_getPosdesc(offset)
  return core:GetVString(offset, this.indexMap.posDesc).value
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  note = this._getNote,
  centerPoints = this._getCenterpoints,
  ranges = this._getRanges,
  filters = this._getFilters,
  filterData = this._getFilterdata,
  pos = this._getPos,
  templateName = this._getTemplatename,
  filterDesc = this._getFilterdesc,
  posDesc = this._getPosdesc
}
return this
