_class("SkillPreviewParamParser", Object)
SkillPreviewParamParser = SkillPreviewParamParser

function SkillPreviewParamParser:Constructor()
  self._previewParamClassDict = {}
  self._previewParamClassDict[SkillPreviewType.Instruction] = SkillPreviewParamInstruction
end

function SkillPreviewParamParser:ParseSkillPreviewList(previewList)
  local _previewList = {}
  for i, v in ipairs(previewList) do
    local previewType = v.PreviewType
    local param = v.Param
    local classType = self._previewParamClassDict[previewType]
    if classType == nil then
      Log.fatal("ParsePreviewList Failed PreviewType:", previewType)
    end
    local paramObj = classType:New(v)
    table.insert(_previewList, paramObj)
  end
  return _previewList
end
