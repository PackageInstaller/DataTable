_class("UIN16SubjectData", Object)
UIN16SubjectData = UIN16SubjectData

function UIN16SubjectData:Constructor(cfg)
  self._id = cfg.ID
  self._grade = cfg.Grade
  self._des = StringTable.Get(cfg.Des)
  self._options = {}
  for i = 1, #cfg.Option do
    self._options[#self._options + 1] = StringTable.Get(cfg.Option[i])
  end
  self._answer = cfg.Answer
end

function UIN16SubjectData:GetId()
  return self._id
end

function UIN16SubjectData:GetGrade()
  return self._grade
end

function UIN16SubjectData:GetDes()
  return self._des
end

function UIN16SubjectData:GetOptions()
  return self._options
end

function UIN16SubjectData:GetAnswerIndex()
  return self._answer
end

function UIN16SubjectData:CheckIsRight(index)
  return index == self._answer
end
