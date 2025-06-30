--[[****************************************************************************
Brief  :SPerfMissile 导弹
Author :James Ou
Date   :2020-10-14
****************************************************************************
]]
module("SPerfMissile", Class.impl(SPerfBase))
-------------------------------

function onStart(self, travel, ...)
    if super.onStart(self, travel, ...) then
        local liveTarget = travel:getTarget()
        if not liveTarget then return end
        local targetPoint = liveTarget:getPointTrans(fight.FightDef.POINT_SPINE)
        local targetPoint2 = liveTarget:getPointTrans(fight.FightDef.POINT_ROOT)
        if gs.GoUtil.IsTransNull(targetPoint) then return end

        local missile = self.m_rootTrans:GetComponent(ty.EffectRandomMananger)
        if missile then
            missile:InitSet(targetPoint, targetPoint2)
        end
        -- local missiles = self.m_rootTrans:GetComponentsInChildren(ty.EffectRandomSet)
        -- local len = missiles.Length-1
        -- for i=0,len do
        -- 	missiles[i]:InitSet(targetPoint)
        -- end
        -- missiles = self.m_rootTrans:GetComponentsInChildren(ty.EffectRandomController)
        -- len = missiles.Length-1
        -- for i=0,len do
        -- 	missiles[i].TargetTran = targetPoint
        -- end
    end
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]