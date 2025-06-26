-- @FileName:   DankeBulletShield.lua
-- @Description:   蛋壳子弹盾牌
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerBullet.DankeBulletShield', Class.impl(danke.DankeBullet))

function resetData(self)
    super.resetData(self)

    self.m_angle = self.m_data.angle
end

function onFrame(self)
    super.onFrame(self)
    
    self.m_angle = self.m_angle + gs.Time.deltaTime * self.m_data.speed
    local playThing_pos = self.m_playerThing:getPosition()
    self:GetCenterRadiusPos(self.m_trans, 0, 0, self.m_angle, self.m_data.radius, playThing_pos.x, playThing_pos.y, self.m_trans.position.z)

    if self.m_repelThing then
        self:onRepel()
    end
end

--攻击
function onAttack(self, thing, collider_args, isforce)
    if collider_args.hit_tag == DanKeConst.ColliderTag.Enemy_Bullet then
        thing:poolRecover()
    else
        super.onAttack(self, thing, collider_args)

        if thing.m_data.config.type ~= DanKeConst.MonsterType.Elite then
            local attr = thing:getAttr()
            if attr.hp > 0 then
                self:repel(thing)
            end
        end
    end
end

--击退
function repel(self, thing)
    self.m_repelThing = thing

    self.m_curRepelDistance = 0

    self.m_maxRepelDistance = 1
    self.m_maxRepelSpeed = 0.1

    self.m_curRepelSpeed = self.m_maxRepelSpeed
end

function onRepel(self)
    local attr = self.m_repelThing:getAttr()
    if attr.hp <= 0 then
        self:overRepel()
        return
    end

    self.m_curRepelSpeed = gs.Mathf.Lerp(self.m_curRepelSpeed, 0, gs.Time.deltaTime)
    
    self.m_curRepelDistance = self.m_curRepelDistance + self.m_curRepelSpeed
    if self.m_curRepelDistance > self.m_maxRepelDistance then
        self.m_curRepelSpeed = self.m_maxRepelDistance - self.m_curRepelDistance
        self:overRepel()
        return
    end

    local forward = self.m_trans.position - self.m_repelThing:getPosition()
    self.m_repelThing:setTranForward(self.m_curRepelSpeed * -1, gs.Vector3(forward.normalized.x, forward.normalized.y, 0))
end

function overRepel(self)
    self.m_repelThing = nil

    self.m_curRepelDistance = nil
    self.m_maxRepelDistance = nil
    self.m_maxRepelSpeed = nil
    self.m_curRepelSpeed = nil
end

function initCollider(self)
    self.m_ColliderCall:InitCapsuleCollider(0.35, 0.2)
end

function getColliderTags(self)
    return {DanKeConst.ColliderTag.Normal_Monster, DanKeConst.ColliderTag.Elite_Monster, DanKeConst.ColliderTag.Enemy_Bullet}
end

function GetCenterRadiusPos(self, trans, angle_x, angle_y, angle_z, distance, centerPos_x, centerPos_y, centerPos_z)
    local quaternion = gs.Quaternion.Euler(0, 0, angle_z)
    local disVect3 = gs.Vector3(-distance, 0, 0)
    local pos = quaternion * disVect3 + gs.Vector3(centerPos_x, centerPos_y, 0)
    trans.position = pos
end

function clearData(self)
    super.clearData(self)

    self.m_angle = nil
    self.m_playerThing = nil
end

return _M
