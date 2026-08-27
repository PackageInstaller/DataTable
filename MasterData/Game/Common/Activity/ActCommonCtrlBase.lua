local ActCommonCtrlBase = class("ActCommonCtrlBase", ControllerBase)

function ActCommonCtrlBase:OnInit()
  self._dataDic = {}
  self:LoadAllCfg()
  self:LoadAllListener()
end

function ActCommonCtrlBase:LoadAllCfg()
end

function ActCommonCtrlBase:LoadAllListener()
end

function ActCommonCtrlBase:UnLoadAllCfg()
end

function ActCommonCtrlBase:UnLoadAllListener()
end

function ActCommonCtrlBase:NewActData()
  return nil
end

function ActCommonCtrlBase:AddActData(msg)
  if self._dataDic[msg.actId] ~= nil then
    return
  end
  local data = self:NewActData()
  if data == nil then
    return
  end
  self._dataDic[msg.actId] = data
  data:InitActData(msg)
end

function ActCommonCtrlBase:UpdateActData(msg)
  if self._dataDic[msg.actId] == nil then
    return
  end
  self._dataDic[msg.actId]:UpdateActData(msg)
end

function ActCommonCtrlBase:RemoveActData(actId)
  local data = self._dataDic[actId]
  if data ~= nil and data.OnDataRemoved then
    data:OnDataRemoved()
  end
  self._dataDic[actId] = nil
end

function ActCommonCtrlBase:IsHaveActData()
  return table.count(self._dataDic) > 0
end

function ActCommonCtrlBase:GetActFirstData()
  for k, v in pairs(self._dataDic) do
    return v
  end
end

function ActCommonCtrlBase:GetActDataByActId(actId)
  return self._dataDic[actId]
end

function ActCommonCtrlBase:GetActDataByFrameId(actFrameId)
  for k, data in pairs(self._dataDic) do
    if data:GetActFrameId() == actFrameId then
      return data
    end
  end
  return nil
end

function ActCommonCtrlBase:OnDelete()
  self:UnLoadAllCfg()
  self:UnLoadAllListener()
end

return ActCommonCtrlBase
