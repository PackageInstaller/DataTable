-- @FileName:   DankeMonsterShootSkill_Dash1.lua
-- @Description:  怪物冲刺技能类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.monsterSkill.DankeMonsterShootSkill_Dash1', Class.impl(danke.DankeMonsterBaseSkill))

function resetData(self)
    super.resetData(self)

    self.m_speed = self.m_skillVo.param[1] --冲刺速度
    self.m_shakingTime = self.m_skillVo.param[2] * 0.001 --前摇时间

    self:onExecuteFinish()
end

function onUpdateSkillTips(self, dir, distance, size, scale)
    if not self.m_skillTipsGo or gs.GoUtil.IsGoNull(self.m_skillTipsGo) then
        self.m_skillTipsGo = gs.GOPoolMgr:Get("arts/sceneModule/danke/prefabs/danke_dashskill_tips.prefab")
        self.m_skillTipsTrans = self.m_skillTipsGo.transform

        self.m_skillTipsTweenTrans = self.m_skillTipsTrans:Find("boss_dash_tip_02")
    end

    local execute_pos = self.m_executeThing:getPosition()
    gs.TransQuick:LPos(self.m_skillTipsTrans, execute_pos.x, execute_pos.y, 0)

    local targetRotation = gs.Quaternion.LookRotation(gs.Vector3(dir.x * -1, 0, dir.y))
    gs.TransQuick:SetRotation(self.m_skillTipsTrans, 0, 0, targetRotation.eulerAngles.y)

    self.m_skillTipsTrans.localScale = gs.Vector3(size * scale, distance, 1)

    self.m_skillTipsGo:SetActive(true)

    self:KillTween()
    self.m_scaleTween = doTweenScaleX(self.m_skillTipsTweenTrans, 0, 1 / 0.64, self.m_shakingTime, nil, function ()
        self.m_isCanExecute = true
        self.m_executeThing:playAction("atk01")
    end)
end

function doTweenScaleX(rect, startVal, endVal, duration, easeType, finishCall)
    gs.TransQuick:ScaleY(rect, startVal)

    local scale_Tweener = rect:DOScaleY(endVal, duration)
    if easeType then
        scale_Tweener:SetEase(easeType)
    end

    if finishCall then
        scale_Tweener:OnComplete(finishCall)
    end
    return scale_Tweener
end

function KillTween(self)
    if self.m_scaleTween then
        self.m_scaleTween:Kill()
        self.m_scaleTween = nil
    end
end

function onExecute(self)
    local playerThing = danke.DanKeSceneController:getPlayerThing()
    local playPos = playerThing:getPosition()
    local shootPos = self.m_executeThing:getPosition()
    local targetPos = playPos - shootPos
    self.m_dashForward = targetPos.normalized
    self.m_dashDistance = targetPos.magnitude

    local executeThingConfig = self.m_executeThing:getData().config
    local size = executeThingConfig.agent_radius
    local scale = executeThingConfig:getScale()
    local data =
    {
        config = self.m_skillVo,
        size = size,
        scale = scale,
    }

    danke.DanKeSceneController:createMonterBullet(self.m_executeThing, self.m_skillVo.type, data)

    self:onUpdateSkillTips(self.m_dashForward, self.m_dashDistance, size, scale)

    self.m_executeThing:setCanAttack(false)
    self.m_executeThing:playAction("atk03")
end

function onExecuteFinish(self)
    super.onExecuteFinish(self)

    self.m_curDashDistance = 0
    self.m_executeThing:setCanAttack(true)

    if self.m_skillTipsGo and not gs.GoUtil.IsGoNull(self.m_skillTipsGo) then
        self.m_skillTipsGo:SetActive(false)
    end

    self:KillTween()

    self.m_executeThing:playAction("move")
end

function onFrame(self)
    super.onFrame(self)

    if self.m_isCanExecute then
        self.m_executeThing:setTranForward(self.m_speed * gs.Time.deltaTime, self.m_dashForward)

        local distance = self.m_speed * self.m_dashForward * gs.Time.deltaTime
        self.m_curDashDistance = self.m_curDashDistance + distance.magnitude
        if self.m_curDashDistance > self.m_dashDistance then
            self:onExecuteFinish()
        end
    end
end

function onRecover(self)
    super.onRecover(self)

    self.m_speed = nil
    self.m_dashForward = nil
    self.m_dashDistance = nil
    self.m_curDashDistance = nil
end

return _M
