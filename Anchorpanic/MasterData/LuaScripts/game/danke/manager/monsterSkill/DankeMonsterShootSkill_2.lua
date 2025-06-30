-- @FileName:   DankeMonsterShootSkill_2.lua
-- @Description:  怪物直射技能类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.monsterSkill.DankeMonsterShootSkill_2', Class.impl(danke.DankeMonsterBaseSkill))

function resetData(self)
    super.resetData(self)

    self.m_shootNum = self.m_skillVo.param[1] --总共发射的数量
    self.m_shootInterval = self.m_skillVo.param[2] * 0.001--发射的间隔

    self.m_playerThing = danke.DanKeSceneController:getPlayerThing()
    self:onExecuteFinish()
end

function onExecuteFinish(self)
    super.onExecuteFinish(self)

    self.m_shootCount = 0 --已经发射的数量
    self.m_shootTime = 0 --上一次发射的时间
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
    local playPos = self.m_playerThing:getPosition()

    local shootPos = self.m_executeThing:getPosition()

    local targetPos = playPos - shootPos
    local shoot_dir = targetPos.normalized

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

    self.m_playerThing = nil
    self.m_shootNum = nil
    self.m_shootInterval = nil

    self.m_shootCount = nil
    self.m_shootTime = nil
end

return _M
