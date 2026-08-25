local ClientDataMainKey = CommonDefine.ClientDataMainKey
local ClientSubKey = CommonDefine.ClientSubKey
local PvpMatchModel = NewClass("PvpMatchModel", BaseModel)

function PvpMatchModel:OnInit()
  self._isMatchMachine = 1
  self._isSpeedFirst = 1
  self._isOpenPreBuilt = 1
  self._isOpenDraft = 0
end

function PvpMatchModel:OnReset()
  self:OnInit()
end

function PvpMatchModel:UpdateByClientData()
  self._isMatchMachine = ClientDataUtils.GetData(ClientDataMainKey.PvpMatchParam, ClientSubKey.PvpMatchIsMatchMachine, 1)
  self._isSpeedFirst = ClientDataUtils.GetData(ClientDataMainKey.PvpMatchParam, ClientSubKey.PvpMatchIsSpeedFirst, 1)
  self._isOpenPreBuilt = ClientDataUtils.GetData(ClientDataMainKey.PvpMatchParam, ClientSubKey.PvpMatchIsOpenPreBuilt, 1)
  self._isOpenDraft = ClientDataUtils.GetData(ClientDataMainKey.PvpMatchParam, ClientSubKey.PvpMatchIsOpenDraft, 0)
end

function PvpMatchModel:SetIsMatchMachine(boolVal)
  self._isMatchMachine = boolVal and 1 or 0
  ClientDataUtils.SetData(ClientDataMainKey.PvpMatchParam, ClientSubKey.PvpMatchIsMatchMachine, self._isMatchMachine)
end

function PvpMatchModel:SetIsSpeedFirst(boolVal)
  self._isSpeedFirst = boolVal and 1 or 0
  ClientDataUtils.SetData(ClientDataMainKey.PvpMatchParam, ClientSubKey.PvpMatchIsSpeedFirst, self._isSpeedFirst)
end

function PvpMatchModel:SetIsOpenPreBuilt(boolVal)
  self._isOpenPreBuilt = boolVal and 1 or 0
  ClientDataUtils.SetData(ClientDataMainKey.PvpMatchParam, ClientSubKey.PvpMatchIsOpenPreBuilt, self._isOpenPreBuilt)
end

function PvpMatchModel:SetIsOpenDraft(boolVal)
  self._isOpenDraft = boolVal and 1 or 0
  ClientDataUtils.SetData(ClientDataMainKey.PvpMatchParam, ClientSubKey.PvpMatchIsOpenDraft, self._isOpenDraft)
end

function PvpMatchModel:GetIsOpenPreBuilt()
  return 1 == self._isOpenPreBuilt
end

function PvpMatchModel:GetIsOpenDraft()
  return 1 == self._isOpenDraft
end

function PvpMatchModel:GetIsMatchMachine()
  return 1 == self._isMatchMachine
end

function PvpMatchModel:GetIsSpeedFirst()
  return 1 == self._isSpeedFirst
end

function PvpMatchModel:GetPvpType()
  if self:GetIsOpenPreBuilt() and self:GetIsOpenDraft() then
    return PvpDefine.PvpType.DraftAndPreBuilt
  elseif self:GetIsOpenPreBuilt() then
    return PvpDefine.PvpType.PreBuilt
  elseif self:GetIsOpenDraft() then
    return PvpDefine.PvpType.Draft
  end
end

return PvpMatchModel
