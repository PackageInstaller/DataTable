local LoopVo = Class.class("LoopVo")

function LoopVo:setData(cusDelay, cusRepeat, cusThisObject, cusCallBack, cusOverBack, cusOverBackParams)
    self.m_sn = SnMgr:getSn()
    self.m_delay = cusDelay
    self.m_counter = cusDelay
    self.m_repeatTime = cusRepeat
    self.m_thisObject = cusThisObject
    self.m_callBack = cusCallBack
    self.m_overBack = cusOverBack
    self.m_overBackParams = cusOverBackParams
    self.m_beRemove = false
end

function LoopVo:onRecover()
    SnMgr:disposeSn(self.m_sn)
    self.m_sn = 0
end

function LoopVo:onDelete()
    if self.m_sn then
        SnMgr:disposeSn(self.m_sn)
        self.m_sn = 0
    end
end

return LoopVo
