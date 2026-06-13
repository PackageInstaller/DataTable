local M = BaseClass("LimitSkillData")

function M:__init(protoData)
   self.m_ids = protoData.Ids --拥有的破限技id (mapCondition)
   self.m_canSelect = protoData.CanSelect -- 可选择个数
   self.m_selecteds = protoData.Selected --  选择的破限技ids
end

function M:GetIds()
    return self.m_ids
end

function M:CanSelectMore()
    return #self.m_selecteds < self.m_canSelect
end

function M:GetCanSelect()
    return self.m_canSelect
end

function M:GetSelectIds()
    return self.m_selecteds
end

function M:SetSelectIds(ids)
    self.m_selecteds = ids
end

return M