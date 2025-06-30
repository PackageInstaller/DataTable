module('fight.SnMgr', Class.impl())

function ctor(self)
    self.m_snGenerator = 0;
end

function getSn(self)
    self.m_snGenerator = self.m_snGenerator + 1
    return self.m_snGenerator
end

function disposeSn(self, cusSn)
end

function curSn(self)
    return self.m_snGenerator;
end

return _M