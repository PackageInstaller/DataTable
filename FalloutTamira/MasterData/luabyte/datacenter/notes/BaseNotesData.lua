local M = BaseClass("BaseNotesData")

function M:__init()
    self.m_data = nil
    self.m_type = EnumConst.NotesWorkType.NONE
    self:Init()
end

function M:UpdateData(data)
    self.m_data = data
end

function M:GetType()
    return self.m_type
end

function M:Dispose()
    self.m_data = nil
    self.m_type = nil
end

function M:ClearData()
    self.m_data = nil
end

function M:Init()
    -- body
end

return M
