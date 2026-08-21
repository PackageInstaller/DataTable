-- 使用BaseRo类创建StoryTalkDataRo类
module("StoryRoleRo", Class.impl("rodata/BaseRo"))


function ctor(self)
    super.ctor(self)
end

function parseData(self, refName, refData)
    self.m_refName = refName -- 策划自定义在表格中的名字
    refData = refData or {}

    self.m_alpha = refData.alpha or 1
    self.m_scale = refData.scale or 1
    self.m_offset = refData.offset or {0, 0}
    self.m_facePosition = refData.face_position
end

return _M
