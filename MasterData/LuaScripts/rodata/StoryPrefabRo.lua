-- 使用BaseRo类创建StoryTalkDataRo类
module("StoryPrefabRo", Class.impl("rodata/BaseRo"))


function ctor(self)
    super.ctor(self)
end

function parseData(self, refName, refData)
    self.m_refName = refName -- 策划自定义在表格中的名字

    self.m_path = refData.path
    self.m_layer = refData.layer
    self.m_loop = refData.loop
end

return _M
