local HandbookDataBase = class("HandbookDataBase")

function HandbookDataBase:ctor(id, unlock)
  self.nId = id
  self.tbCfgData = ConfigTable.GetData("Handbook", self.nId)
  self.nUnlock = unlock
  if nil == self.tbCfgData then
    printError("Get handbook data fail!!! id = " .. id)
    return
  end
  self.nIndex = self.tbCfgData.Index
  self:Init()
end

function HandbookDataBase:UpdateUnlockState(unlock)
  self.nUnlock = unlock
end

function HandbookDataBase:GetType()
  return self.tbCfgData.Type
end

function HandbookDataBase:GetId()
  return self.nId
end

function HandbookDataBase:CheckUnlock()
  return self.nUnlock == 1
end

return HandbookDataBase
