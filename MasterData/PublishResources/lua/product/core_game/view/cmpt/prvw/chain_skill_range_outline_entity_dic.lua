_class("ChainSkillRangeOutlineEntityDic", Object)
ChainSkillRangeOutlineEntityDic = ChainSkillRangeOutlineEntityDic

function ChainSkillRangeOutlineEntityDic:Constructor()
  self._petOutlineEntityDic = {}
end

function ChainSkillRangeOutlineEntityDic:ClearChainSkillOutlineEntityDic()
  self._petOutlineEntityDic = {}
end

function ChainSkillRangeOutlineEntityDic:GetChainSkillOutlineEntityDic()
  return self._petOutlineEntityDic
end

function ChainSkillRangeOutlineEntityDic:GetChainSkillOutlineEntityCount()
  return table.count(self._petOutlineEntityDic)
end

function ChainSkillRangeOutlineEntityDic:AddPetChainSkillOutlineRange(previewIndex)
  self._petOutlineEntityDic[previewIndex] = {}
end

function ChainSkillRangeOutlineEntityDic:AddChainSkillRangeOutlineEntityID(previewIndex, outlineEntityID)
  local entityIDList = self._petOutlineEntityDic[previewIndex]
  entityIDList[#entityIDList + 1] = outlineEntityID
end

function ChainSkillRangeOutlineEntityDic:HasPreviewIndex(previewIndex)
  if not self._petOutlineEntityDic[previewIndex] then
    return false
  else
    return next(self._petOutlineEntityDic[previewIndex])
  end
end
