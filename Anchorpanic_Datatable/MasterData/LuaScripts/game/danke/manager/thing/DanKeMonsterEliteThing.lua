-- @FileName:   DanKeMonsterEliteThing.lua
-- @Description:  沙盒实体基类
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.danke.thing.DanKeMonsterEliteThing', Class.impl(danke.DanKeMonsterThing))

function resetData(self)
    super.resetData(self)

    self.m_selfColliderTag = DanKeConst.ColliderTag.Elite_Monster
end

function onModelLoadFinish(self)
    super.onModelLoadFinish(self)
    self:playAction("move")
end

-- function onAttack(self, thing, collider_args)
--     super.onAttack(self, thing, collider_args)

--     self:playAction("atk01")
-- end

--死亡
function onDie(self)
    if self.m_Die then return end
    self.m_Die = true

    self:clearFrame()

    local aniName = "die"
    self:playAction(aniName)

    local stageConfigVo = danke.DanKeManager:getCurStageVo()
    if stageConfigVo then
        if stageConfigVo.key_monster == self.m_data.config.id then
            self.m_lastTimeScale = gs.Time.timeScale
            fight.FightManager:setupTimeScale(0)

            local tweener = gs.DT.DOTween.To(function(value)
                fight.FightManager:setupTimeScale(value)
            end, 0, self.m_lastTimeScale, 1)

            local aniLenth = self:getAniLenght(aniName)
            self.m_dieTimeOutSn = LoopManager:setTimeout(aniLenth + 0.5, nil, function ()
                super.onDie(self)
            end)

            return
        end
    end

    super.onDie(self)
end

function addCharacterController(self)

end

function initCharacterControllerSize(self)
    
end

--前进
function setTranForward(self, speed, forward)
    local trans = self:getTrans()

    forward = forward or trans.forward
    trans:Translate(speed * forward, gs.Space.World)
end

function clearData(self)
    super.clearData(self)

    if self.m_dieTimeOutSn then
        LoopManager:clearTimeout(self.m_dieTimeOutSn)
        self.m_dieTimeOutSn = nil
    end

    self.m_Die = nil
end

return _M
