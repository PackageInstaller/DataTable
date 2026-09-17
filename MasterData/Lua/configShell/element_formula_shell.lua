local this = class("element_formula_shell", G_BaseConfig)
local core = G_Tables.TDElementFormulaTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, functionOutput = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFunctionoutput(offset)
  return core:GetVString(offset, this.indexMap.functionOutput).value
end

this.keyToMethodsMap = {
  id = this._getId,
  functionOutput = this._getFunctionoutput
}
return this
