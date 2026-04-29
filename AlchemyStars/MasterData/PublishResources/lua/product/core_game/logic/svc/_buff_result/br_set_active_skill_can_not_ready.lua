_class("BuffResultSetActiveSkillCanNotReady", BuffResultBase)
BuffResultSetActiveSkillCanNotReady = BuffResultSetActiveSkillCanNotReady

function BuffResultSetActiveSkillCanNotReady:Constructor(buffSeq, isSetCanNotReady, isReady, extraSkillID)
  self._buffseq = buffSeq
  self._isSetCanNotReady = isSetCanNotReady
  self._isReady = isReady
  self._extraSkillID = extraSkillID
end

function BuffResultSetActiveSkillCanNotReady:IsCanNotReady()
  return self._isSetCanNotReady
end

function BuffResultSetActiveSkillCanNotReady:GetBuffSeq()
  return self._buffseq
end

function BuffResultSetActiveSkillCanNotReady:IsReady()
  return self._isReady
end

function BuffResultSetActiveSkillCanNotReady:GetExtraSkillID()
  return self._extraSkillID
end
