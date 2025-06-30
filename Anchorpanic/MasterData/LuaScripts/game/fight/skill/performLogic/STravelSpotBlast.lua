--[[****************************************************************************
Brief  :STravelSpotBlast 点爆类技能轨迹
Author :James Ou
Date   :2020-03-09
****************************************************************************
]]
module("STravelSpotBlast", Class.impl(STravelBase))
-- 根据不同的轨迹 子类可重写
SPERF_CLS = SPerfSpotBlast
-------------------------------
function start(self)
    super.start(self)

    -- local curV3, root = self:getStartPointPos()
    local curV3, root, angle = self:getSimplePoint()
    self:setCurPos(curV3)
    STravelHandle:perfHandle(self, STravelDef.PERF_START, root, curV3, angle)
    -- STravelHandle:perfHandle(self, STravelDef.PERF_POS, curV3)
    local targetLiveVo = self:getTargetVo()
    if targetLiveVo then
        self:onHitTargetIds(self.m_targetID)
    else
        self:onArrive()
    end
    if not self:startInjuryInterval() then
        self:onIntervalInjury(1)
    end
    local timeLimit = self:getTimeLimit()
    if not timeLimit or timeLimit == 0 then
        self:onEnd()
    end
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]