local this = class("mail_auto_shell", G_BaseConfig)
local core = G_Tables.TDMailAutoTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, mailId = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getMailid(offset)
  return core:GetInt(offset, this.indexMap.mailId)
end

this.keyToMethodsMap = {
  id = this._getId,
  mailId = this._getMailid
}
return this
