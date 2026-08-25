local PvpCollectionModel = NewClass("PvpCollectionModel", BaseModel)

function PvpCollectionModel:OnInit()
  self:ClearData()
end

function PvpCollectionModel:OnReset()
  self:OnInit()
end

function PvpCollectionModel:ClearData()
  self._selectCollectionTid = nil
  self._selectAwakerSkillTid = nil
end

function PvpCollectionModel:SetSelectCollectionTid(targetCollectTid)
  self._selectCollectionTid = targetCollectTid
  EventMgr.Instance.PvpCollectionSelect:Dispatch(targetCollectTid)
  self:Notify(NotifyId.OnPvpCollectionSelectChange, targetCollectTid)
end

function PvpCollectionModel:SetSelectAwakerSkillTid(targetSkillTid)
  self._selectAwakerSkillTid = targetSkillTid
  EventMgr.Instance.PvpCollectionAwakerSkillSelect:Dispatch(targetSkillTid)
  self:Notify(NotifyId.OnPvpCollectionSelectSkillChange, targetSkillTid)
end

function PvpCollectionModel:GetSelectCollectionTid()
  return self._selectCollectionTid
end

function PvpCollectionModel:GetSelectAwakerSkillTid()
  return self._selectAwakerSkillTid
end

return PvpCollectionModel
