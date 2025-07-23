-- @FileName:   DankeMonsterShootSkill_4.lua
-- @Description:   怪物同时发散子弹技能类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.monsterSkill.DankeMonsterShootSkill_4', Class.impl(danke.DankeMonsterBaseSkill))

function resetData(self)
    super.resetData(self)

    self.m_shootInitAngle = self.m_skillVo.param[1] --每轮发射的初始角度
    self.m_shootAngle = self.m_skillVo.param[2] --每次发射间隔的角度
    self.m_shootNum = self.m_skillVo.param[3] --每轮发射的数量
    self.m_shootInterval = self.m_skillVo.param[4] * 0.001 --每轮发射的间隔

    self:onExecuteFinish()
end

function onExecuteFinish(self)
    super.onExecuteFinish(self)
    
    self.m_shootCount = 0--已经发射的数量
    self.m_shootTime = 0 --上一轮发射的时间
end

function onFrame(self)
    super.onFrame(self)

    if self.m_isCanExecute then
        if self.m_shootTime == 0 or self.m_deltaTime - self.m_shootTime >= self.m_shootInterval then
            self:onShoot()
        end
    end
end

function onShoot(self)
    local angle = self.m_shootInitAngle + (self.m_shootAngle * self.m_shootCount + 1)

    local quaternion = gs.Quaternion.Euler(0, 0, angle)
    local disVect3 = gs.Vector3.right
    local dir_pos = quaternion * disVect3
    local shoot_dir = dir_pos.normalized

    local data =
    {
        config = self.m_skillVo,
        shoot_dir = shoot_dir,
    }

    danke.DanKeSceneController:createMonterBullet(self.m_executeThing, self.m_skillVo.type, data)

    self.m_shootTime = self.m_deltaTime

    self.m_shootCount = self.m_shootCount + 1
    if self.m_shootCount >= self.m_shootNum then
        self:onExecuteFinish()
    end
end

function onRecover(self)
    super.onRecover(self)

    self.m_shootInitAngle = nil
    self.m_shootAngle = nil
    self.m_shootNum = nil
    self.m_shootInterval = nil

    self.m_shootCount = nil
    self.m_shootTime = nil
end

return _M
