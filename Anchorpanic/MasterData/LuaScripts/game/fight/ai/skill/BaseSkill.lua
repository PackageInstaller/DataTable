module('fight.BaseSkill', Class.impl('game/fight/utils/TimeoutExecuter'))

local PER_FRAME_SEC = 1 / 30
local SCENE_SKILL_TYPE = 10

function ctor(self)
    super.ctor(self)
    self.m_sn = SnMgr:getSn()
    -- 施法者ID
    self.m_liveID = nil
    self.m_skillID = nil

    -- 标志技能是否在运行中
    self.m_isRunning = false

    -- 记录使用过技能轨迹监听事件的信息
    self.m_useTravelSns = {}
    -- 记录使用过buff监听结束事件的信息
    self.m_useBuffInfos = {}

    self.m_liveObj = nil
    self.m_skillRo = nil
    self.m_skillEditDataRo = nil
    self.m_isJumpCamera = nil

    -- 是否由技能配置控制胜利镜头展示
    self.isEditorControlWin = nil

    self.m_travelDict = {}
    self.m_actionPlayer = require("game/fight/manager/FightActionPlayer").new()
end

function dtor(self)
    SnMgr:disposeSn(self.m_sn)
    self.m_sn = nil
    super.dtor(self)
end

function setData(self, cusAttackerVo, cusMainTargetVo, skillID, tmpID)
    if cusAttackerVo then
        self.m_attacker_vo = cusAttackerVo
        self.m_liveID = self.m_attacker_vo.id
        self.m_liveObj = fight.SceneItemManager:getLivething(self.m_liveID)
    end
    self.m_main_target_vo = cusMainTargetVo
    self.m_skillID = skillID
    self.m_skillEditDataRo = nil
    self.m_isJumpCamera = StorageUtil:getBool1(gstor.FIGHT_JUMP_CAMERA)

    if skillID then
        self.m_skillRo = fight.SkillManager:getSkillRo(skillID)
        if self.m_skillRo then
            -- 盟约技能
            if self.m_skillRo:getType() == SCENE_SKILL_TYPE then
                self.m_skillEditDataRo = fight.SkillManager:getSkillEditDataRo01(90001, self.m_skillRo:getAnimation())
            else
                -- 临时↓
                local modelId = self.m_attacker_vo:getModelID()
                -- local arr = string.split(modelId, "_")
                -- local baseModelId = modelId
                -- if arr[3] == "h" then
                --     -- 高模使用默认配置
                --     local baseModelId = arr[1]
                -- end
                -- 临时↑
                self.m_skillEditDataRo = fight.SkillManager:getSkillEditDataRo01(modelId, self.m_skillRo:getAnimation())
            end
        end
    end
end

--设置每回合的行为数据
function setActionData(self, actionData)
    self.m_actionData = actionData
    self.m_actionPlayer:setActionData(self.m_actionData, self.m_liveID, self.m_attacker_vo)
end

-- 获取当前action
function getActionData(self)
    return self.m_actionData
end

-- 获取攻击者
function getAttackVo(self)
    return self.m_attacker_vo
end

-- 获取主要受击目标
function getMainTargetVo(self)
    return self.m_main_target_vo
end

function sn(self)
    return self.m_sn
end
function liveID(self)
    return self.m_liveID
end
function skillID(self)
    return self.m_skillID
end
function isRunning(self)
    return self.m_isRunning
end

-- 技能类型
function getSkillType(self)
    return self.m_skillRo:getType()
end

-- 整个技能结束 (包括结算情况)
function reset(self)
    if not self.m_isRunning then
        return
    end

    PostHandler:resetChromatic()
    fight.FightManager:updateTimeScale(fight.FightManager:getTimeScaleType())
    RateLooperUnScale:clearTimeout(self.m_frameLagSn)
    RateLooperUnScale:clearTimeout(self.m_winBlackSn)
    self.m_frameLagSn = nil
    self.m_winBlackSn = nil

    local thingDic = fight.SceneManager:getAllThing()
    for _, thing in pairs(thingDic) do
        thing:setVisible(true)
    end

    -- 不是跳过大招
    if self.m_isJumpCamera and self.m_skillRo and (self.m_skillRo:getCameraFocus() == 1) then
    else
        self:resetTargtNode()
        self.m_actionPlayer:playRemain()
    end

    -- 自动跳过技能中
    if self.skipSkil and self.m_attacker_vo then
        self.m_attacker_vo:updateAni(fight.FightDef.ACT_STAND)
        GameDispatcher:dispatchEvent(EventName.LAST_HIT_ACTION)
    end

    self.m_travelDict = {}

    -- 挡格重置
    ABBlock.ABBlockMgr:resetBlock()

    -- 恢复事件帧隐藏的场景
    if self.m_liveObj then
        self.m_liveObj:resetEnvironment()
    end

    -- local targetLive = fight.SceneItemManager:getLivething(self.m_liveID)
    -- if targetLive then
    --     -- 恢复奥义隐藏的挂点
    --     local pos = targetLive:getPointTrans(fight.FightDef.POINT_SPINE)
    --     pos.gameObject:SetActive(true)
    -- end
    -- 恢复奥义隐藏的特效
    BuffEftHandler:showAllEft(self.m_liveID)

    -- 恢复转向
    if self.m_attacker_vo then
        local angle = self.m_attacker_vo:isAttacker() == 1 and 90 or 270
        self.m_attacker_vo:setDirAngle(angle, true)
    end

    local skillId = self.m_skillID

    self.m_actionData = nil
    -- 施法者ID
    self.m_liveID = nil
    self.m_skillID = nil
    -- 标志技能是否在运行中
    self.m_isRunning = false
    self.m_liveObj = nil
    self.m_skillRo = nil
    self.m_skillEditDataRo = nil
    self.m_isJumpCamera = nil
    ABBlock.ABBlockMgr.noTargetHit = nil
    -- 自动跳过
    self.skipSkil = false

    LoopManager:dispatchEventDelayFrame(self, 1, fight.AIEvent.SKILL_AI_END, { sn = self.m_sn, skillId = skillId })

    super.reset(self)
    if self.m_actionEndCall then
        self.m_actionEndCall()
        self.m_actionEndCall = nil
    end
end

-- 跳过奥义
function jumpSkill(self)
    GameDispatcher:dispatchEvent(EventName.SHOW_SKIP_AOYI_EFFECT)

    -- 跳过镜头中
    if self.m_isJumpCamera and self.m_skillRo and self.m_skillRo:getIsScene() == 1 and self.m_attacker_vo then
        -- 移除特效
        for key, _ in pairs(self.m_travelDict) do
            STravelHandle:endTravel(key)
        end
        -- 移除音效
        AudioManager:stopAllFightSoundEffect()
        PostHandler:resetChromatic()


    end

    self.m_travelDict = {}

    -- 停止计时器
    super.reset(self)

    self:setTimeout(0.3, self, function()
        self.m_attacker_vo:updateAni(fight.FightDef.ACT_STAND)

        -- 恢复事件帧隐藏的场景
        if self.m_liveObj then
            self.m_liveObj:resetEnvironment()
        end

        --先移到战场中心 
        local targetPos = self:getAttckerPos(self.m_main_target_vo)
        if targetPos then
            local function _endCall()
                local targetPos = fight.SceneManager:getCenterPos()
                local cameraPos = self:getCameraPos(targetPos, self.m_main_target_vo)
                local skillCameraType = fight.SkillManager:getSkillCameraType(self.m_skillRo:getRefID())
                if self.m_attacker_vo:isAttacker() == self.m_main_target_vo:isAttacker() then
                    fight.FightCamera:moveScFilpTrans(true, cameraPos, skillCameraType, targetPos.z, self.m_main_target_vo.position.z, 0)
                else
                    fight.FightCamera:moveScFilpTrans(false, cameraPos, skillCameraType, targetPos.z, self.m_main_target_vo.position.z, 0)
                end
            end
            -- 先退回镜头，再移动
            fight.FightCamera:checkReturnCamera(0)
            self:movePos(targetPos, nil, _endCall)
        end
    end)

    self:setTimeout(1, self, function()
        self:resetTargtNode()
        GameDispatcher:dispatchEvent(EventName.REMOVE_SKIP_AOYI_EFFECT)
        GameDispatcher:dispatchEvent(EventName.LAST_HIT_ACTION)

        self:setTimeout(0.3, self, function()
            self.m_actionPlayer:playRemain()
        end)

        local targetList = fight.FightManager:actionHeroList(self.m_actionData)
        for i, hero in ipairs(targetList) do
            local thingVo = fight.SceneManager:getThing(hero.hero_id)
            if thingVo and not thingVo:isDead() and thingVo:isAttacker() ~= self.m_attacker_vo:isAttacker() then
                local function _act01FinishCall()
                end
                thingVo:updateAni(fight.FightDef.ACT_HIT_2, nil, _act01FinishCall)

            end
        end

    end)
    self:setTimeout(2.5, self, function()
        self:reset()
    end)

end

-- 还原角色挂点
function resetTargtNode(self)
    local targetList = nil
    if self.m_actionData then
        targetList = fight.FightManager:actionHeroList(self.m_actionData)
    elseif SkillHandleIns then
        -- 编辑器下
        targetList = SkillHandleIns:getActHeroList(self:skillID())
    end
    targetList = targetList or {}
    for _, targetVo in pairs(targetList) do
        if targetVo.hero_id ~= self.m_attacker_vo.id then
            local thingVo = fight.SceneManager:getThing(targetVo.hero_id or targetVo.id)
            if thingVo then
                local live = fight.SceneItemManager:getLivething(thingVo.id)
                if live then
                    live:setToParent(fight.SceneGrid:getRootTrans())
                    gs.TransQuick:Scale0(live:getTrans(), 1)
                end
                -- 位置
                thingVo:updatePosition(fight.SceneManager:getGridPos01(thingVo))
                thingVo:setDirAngle(thingVo:getDirAngle(), true)
            end

        end
    end
end

-- 技能执行
function execute(self, actionStartCall, actionEndCall, actionHitCall)
    self.m_actionStartCall = actionStartCall
    self.m_actionEndCall = actionEndCall
    self.m_actionHitCall = actionHitCall

    self:_showRelationHeadInfo()
    self.m_isRunning = true

    local function sectionBeforeCall()
        if not self.m_main_target_vo then
            Debug:log_warn("BaseSkill", "没有攻击目标: " .. tostring(self.m_skillID))
            local function _playAllFinishCall()
                self:reset()
            end
            self.m_actionPlayer:playAll(_playAllFinishCall)
            return
        end
        if self.m_skillRo then
            -- 盟约技能
            if self.m_skillRo:getType() == SCENE_SKILL_TYPE then
                self:onUseSceneSkill()
                return
            end
            --没有表现数据 
            if not self.m_skillEditDataRo then
                Debug:log_warn("BaseSkill", "没有配置技能数据: " .. tostring(self.m_skillID))

                self.m_actionPlayer:playAll()
            end

            local skillCameraType = fight.SkillManager:getSkillCameraType(self.m_skillRo:getRefID())

            -- 直接使用技能 无视位移（额外技能）
            -- if self.m_actionData and self.m_actionData.is_extra_skill == 1 then
            --     if self.m_main_target_vo:isAttacker() == self.m_attacker_vo:isAttacker() then
            --         self:onStartUseSkill()
            --         return
            --     end
            -- end
            if self.m_skillRo:getType() ~= 0 and self.m_skillEditDataRo then
                -- 特殊,要移动到中心的
                local special = self.m_skillEditDataRo:getSpecial()
                if special and special["setCenter"] == 1 then
                    local centerPos = fight.SceneManager:getCenterPos()
                    if centerPos and math.v3Distance(centerPos, self.m_attacker_vo:getCurPos()) > 0.2 then
                        local function _endCall()
                            self:onStartUseSkill()
                        end
                        self:movePos(centerPos, nil, _endCall)
                        return
                    end
                end
            end

            -- 单体增益buff转向自己家
            -- if self.m_main_target_vo:isAttacker() == self.m_attacker_vo:isAttacker() and skillCameraType == 1 and self.m_skillRo:getType() ~= 0 and self.m_liveID ~= self.m_main_target_vo.id then
            --     local angle = self.m_attacker_vo:isAttacker() == 1 and 270 or 90
            --     self.m_attacker_vo:setDirAngle(angle, true)
            -- end
            -- 一般的技能走这里
            local dis = self:getAttackerDist()

            fight.FightCamera:setBeFlip(not (self.m_attacker_vo:isAttacker() == 1))

            if dis == 0 then
                --先移到战场中心 再出招
                self:checkMoveCenter(self.m_main_target_vo)
            else
                -- 先移到目标前 再出招
                self:checkDisAndMove(self.m_main_target_vo, dis)
            end
        else
            self:setTimeout(1, self, self.reset)
        end
    end

    self.m_actionPlayer:playEftSectionBefore(sectionBeforeCall)
end

-- 使用场景技能
function onUseSceneSkill(self)
    if self.m_actionStartCall then self.m_actionStartCall() end
    self.m_actionStartCall = nil
    local cvID = self.m_skillRo:getVoice()
    if cvID and cvID > 0 then
        AudioManager:playHeroCVOnReplace(cvID)
    end
    -- 跳过特写镜头 直接到下一个出手
    if self.m_isJumpCamera and self.m_skillRo:getIsScene() == 1 then
        self:setTimeout(2, self, self.reset)
        return
    end

    local function _startCall()
        local totalTime = 1
        if self.m_skillEditDataRo then
            local tmpSkip = false
            if fight.FightManager.m_gmOpenEft == true then
                tmpSkip = true
            end
            if tmpSkip == false then
                local special = self.m_skillEditDataRo:getSpecial()
                if special and special["totalTime"] and special["totalTime"] > 0 then
                    totalTime = special["totalTime"]
                else
                    Debug:log_warn("BaseSkill", string.format("盟约技能[%d]没有设置播放总时间", self.m_skillID))
                end
                self:_playAudioList(self.m_skillEditDataRo:getAudio())
                self:_playEftList(self.m_skillEditDataRo:getEft(), totalTime)
                self:_playFrameList(self.m_skillEditDataRo:getFrame())
            end
            self:_playTargetList(self.m_skillEditDataRo:getTarget())
            self:_playAutoSkip(self.m_skillEditDataRo:getSkip())
        end
        self:setTimeout(totalTime, self, self.reset)
    end

    _startCall()
end

-- 检查是否在技能范围 不在时进行移动(符合范围返回true)
function checkDisAndMove(self, targetVo, dist)
    local targetPos = self:getAttckerPos(targetVo)
    local cameraPos = self:getCameraPos(targetPos, targetVo)
    if self.m_liveObj and dist and dist > 0 then
        if self.m_skillRo:getCameraFocus() == 1 then
            if self.m_actionData and self.m_actionData.is_extra_skill == 1 then
                -- 轮到出手，立刻恢复为站立动作
                self.m_attacker_vo:updateAni(fight.FightDef.ACT_STAND)
            end
            if dist ~= 999 then
                -- 大招不显示移动过程
                self.m_attacker_vo:moveTo(targetPos, 0)
            end
            self:onStartUseSkill(cameraPos)
            return
        end
        if self.m_liveID == targetVo.id then
            -- 目标是自己
            self:onStartUseSkill(cameraPos)
            return
        end
        if dist == 999 then
            -- 原地释放技能
            self:onStartUseSkill(cameraPos)
            return
        end
        if targetVo and targetVo.position then
            self.m_target = targetVo
            local curPos = self.m_attacker_vo:getCurPos()
            if math.v3Distance(targetPos, curPos) > 0.2 then
                -- if fight.SceneManager:isInRestorePos(self.m_attacker_vo) then
                --     -- 在起点出发
                --     self:onStartUseSkill(true)
                -- else
                -- print("目标改变了 checkDisAndMove")
                -- 目标改变了
                local function _endCall()
                    self:onStartUseSkill()
                    -- GameDispatcher:dispatchEvent(EventName.ATTACKER_MOVE_END, { pos = targetPos, attacker = self.m_attacker_vo, target = self.m_target })
                end
                self:movePos(targetPos, cameraPos, _endCall)
                -- end
                return
            end
        end
    end
    self:onStartUseSkill(cameraPos)
end

-- 开始使用技能
function onStartUseSkill(self, cameraPos)
    local targetPos = self:getAttckerPos(self.m_main_target_vo)
    -- local cameraPos = self:getCameraPos(targetPos, self.m_main_target_vo)
    local arr = string.split(self.m_skillRo:getAnimation(), "_")
    local animation = arr[1] --切掉元素后缀
    local hash = fight.FightDef.TABLE_ATK2HASH[animation]
    if hash ~= nil then
        local function _startCall()
            self:addToHitNode()
            fight.FightCamera:setTranparency()
            -- if not self.m_skillRo then
            --     return
            -- end
            if self.m_actionStartCall then self.m_actionStartCall() end
            self.m_actionStartCall = nil

            -- 进行特写镜头
            if self.m_skillRo:getCameraFocus() == 1 then
                fight.FightCamera:focusOnLive(self.m_liveID)
                self:_displayOtherHero()
                -- 奥义隐藏胸部特效挂点
                -- local targetLive = fight.SceneItemManager:getLivething(self.m_liveID)
                -- if self.m_liveObj then
                --     local pos = self.m_liveObj:getPointTrans(fight.FightDef.POINT_SPINE)
                --     pos.gameObject:SetActive(false)
                -- end
                -- 奥义隐藏所有buff特效
                BuffEftHandler:hideAllEft(self.m_liveID)

            else
                -- 普通技能镜头
                if self.m_attacker_vo:getModelID() and self.m_skillRo:getAnimation() then
                    local curLiveVo = self.m_attacker_vo:getCurDisplayLiveVo()
                    local animPath = UrlManager:getFightCameraAniPath(curLiveVo:getModelID() .. "_" .. animation .. ".anim")

                    if self.m_attacker_vo:isAttacker() == 1 then
                        fight.FightCamera:playCameraAni(false, animPath)
                    else
                        -- 镜头翻转
                        fight.FightCamera:playCameraAni(true, animPath)
                    end
                end
            end

            local aniLenght = 2
            if self.m_liveObj then
                self.m_liveObj:getAniLenght(animation, function(length)
                    aniLenght = length

                    local function _delayStartCall()
                        local cvID = self.m_skillRo:getVoice()
                        if cvID and cvID > 0 then
                            AudioManager:playHeroCVOnReplace(cvID)
                        end

                        -- 触发UI的技能倒计时
                        if self.m_skillRo:getType() ~= 2 and self.m_skillRo:getType() ~= 3 then
                            GameDispatcher:dispatchEvent(EventName.START_RUN_SKILL_ACTION, { self.m_skillID, aniLenght * 0.85, self.m_skillRo:getType(), self.m_liveObj:getLiveVo():getTID() })
                        end

                        if self.m_skillRo:getType() ~= 0 and not StorageUtil:getBool1(gstor.FIGHT_HIDE_INFO) then
                            GameDispatcher:dispatchEvent(EventName.START_PLAYSKILL_ACITON, { skillName = self.m_skillRo:getName(), liveVo = self.m_liveObj:getLiveVo() })
                        end
                    end
                    self:setTimeout(PER_FRAME_SEC, self, _delayStartCall)

                    if self.m_skillEditDataRo and aniLenght > 0 then
                        local tmpSkip = false
                        if fight.FightManager.m_gmOpenEft == true then
                            tmpSkip = true
                        end
                        -- 技能播放核心方法
                        if tmpSkip == false then
                            self:_playAudioList(self.m_skillEditDataRo:getAudio())
                            self:_playEftList(self.m_skillEditDataRo:getEft(), aniLenght)
                            self:_playFrameList(self.m_skillEditDataRo:getFrame())
                        end

                        self:_playTargetList(self.m_skillEditDataRo:getTarget(), self.m_skillRo:getRefID())
                        self:_playAutoSkip(self.m_skillEditDataRo:getSkip())
                    end

                    if aniLenght > 0 then
                        -- if needMove then
                        --     -- 从站位出发的位移处理
                        --     local ro = fight.RoleShowManager:getShowData(self.m_attacker_vo:getModelID())
                        --     if ro then
                        --         local st = ro:getGoBefore() * PER_FRAME_SEC -- 起步等待时间
                        --         local et = ro:getArriveAfter() * PER_FRAME_SEC --到达等待时间
                        --         self.m_attacker_vo:moveTo2(targetPos, aniLenght, st, et)
                        --     else
                        --         self.m_attacker_vo:moveTo(targetPos, aniLenght)
                        --     end
                        -- end
                        if cameraPos and self.m_skillRo:getCameraFocus() ~= 1 then
                            -- 技术镜头展示
                            local skillCameraType = fight.SkillManager:getSkillCameraType(self.m_skillRo:getRefID())
                            if self.m_attacker_vo:isAttacker() == self.m_main_target_vo:isAttacker() then
                                fight.FightCamera:moveScFilpTrans(true, cameraPos, skillCameraType, targetPos.z, self.m_main_target_vo.position.z)
                            else
                                fight.FightCamera:moveScFilpTrans(false, cameraPos, skillCameraType, targetPos.z, self.m_main_target_vo.position.z)
                            end
                        end

                        -- 跳过特写镜头 直接到下一个出手
                        if self.m_isJumpCamera and self.m_skillRo:getIsScene() == 1 then
                            self:setTimeout(2, self, self.jumpSkill)
                            return
                        end
                        -- self.resetTimeout = self:setTimeout(aniLenght + 0.1, self, self.reset)
                        return
                    end
                    self:setTimeout(1, self, self.reset)
                end)
            end
        end

        -- 中了混乱buff，攻击类型技能打自己转身
        if self.m_attacker_vo:isAttacker() == 1 and self.m_skillRo:getEffectType() == 1 and self.m_attacker_vo:getCurPos().x > self.m_main_target_vo:getCurPos().x then
            self.m_attacker_vo:setDirAngle(270, true)
        end
        if self.m_attacker_vo:isAttacker() == 2 and self.m_skillRo:getEffectType() == 1 and self.m_attacker_vo:getCurPos().x < self.m_main_target_vo:getCurPos().x then
            self.m_attacker_vo:setDirAngle(90, true)
        end


        if fight.FightManager.m_gmOpenAudio == true then
            _startCall()
        else

            local _endCall = function()
                -- if self.resetTimeout then
                --     self:clearTimeout(self.resetTimeout)
                -- end
                if self.m_isJumpCamera and self.m_skillRo:getIsScene() == 1 then
                    -- 跳过技能不回调
                else
                    self:reset()
                end
            end
            if self.m_skillRo:getCameraFocus() == 1 and not self.m_isJumpCamera then
                local switchFinishCall = function()
                    -- 奥义动作完成结束技能比较准
                    self.m_attacker_vo:transAni(hash, _startCall, _endCall, true)
                end
                switchFinishCall()
                -- 奥义切换高模
                -- self.m_liveObj:switchHighModel(switchFinishCall)
            else
                if self.m_skillRo:getCameraFocus() == 1 then
                    local switchFinishCall = function()
                        self.m_attacker_vo:transAni(hash, _startCall, _endCall, true)
                    end
                    switchFinishCall()
                    -- 奥义切换高模
                    -- self.m_liveObj:switchHighModel(switchFinishCall)
                else
                    self.m_attacker_vo:transAni(hash, _startCall, _endCall, true)
                end
            end
        end
    else
        -- print("没有配技能动作 技能即将结束")
        self:setTimeout(1, self, self.reset)
    end
end

-- 目标改变了,移动位置
function movePos(self, targetPos, cameraPos, finishCall)
    local moveTime = 0.7
    local speed = 1
    local aniLenght = 1
    if self.m_liveObj then
        self.m_liveObj:getAniLenght("ready", function(length)
            aniLenght = length / speed

        end)
    end
    -- RateLooper:setTimeout(0.3, self, function()
    local function _startCall()
        self.m_attacker_vo:moveTo(targetPos, moveTime)
        self.m_attacker_vo:updateAniSpeed(speed)
        -- 同步镜头跟随战员移动
        -- fight.FightCamera:deepRound(targetPos, aniLenght)
        if cameraPos then
            local skillCameraType = fight.SkillManager:getSkillCameraType(self.m_skillRo:getRefID())
            if self.m_attacker_vo:isAttacker() == self.m_main_target_vo:isAttacker() then
                fight.FightCamera:moveScFilpTrans(true, cameraPos, skillCameraType, targetPos.z, self.m_main_target_vo.position.z)
            else
                fight.FightCamera:moveScFilpTrans(false, cameraPos, skillCameraType, targetPos.z, self.m_main_target_vo.position.z)
            end
        end
    end

    local function _endCall()
        self.m_attacker_vo:updateAniSpeed(1)
        if finishCall then finishCall() end
    end
    self.m_attacker_vo:updateAni(fight.FightDef.ACT_STAND) -- 轮到出手，立刻恢复为站立动作
    self.m_attacker_vo:transAni(fight.FightDef.TRANS_READY, _startCall, _endCall)
    -- AudioManager:playFightSoundEffect(UrlManager:getMainExploreSoundPath("ui_battle_move.prefab")) -- 效果不好，暂时不要
    -- end)
end

-- 获取战员攻击距离
function getAttackerDist(self)
    local attackerRo = fight.RoleShowManager:getShowData(self.m_attacker_vo:getModelID())
    local targeterRo = fight.RoleShowManager:getShowData(self.m_main_target_vo:getModelID())
    local dis = 0
    local extraDis = 0
    if attackerRo then
        dis = attackerRo:getDist()
    end
    if targeterRo and dis > 0 then
        extraDis = targeterRo:getExtraDist()
    end

    return dis + extraDis
end

-- 攻击者目标位置（可以释放技能的位置）
function getAttckerPos(self, targetVo)
    local targetPos = fight.SceneManager:getCenterPos()
    local skillCameraType = fight.SkillManager:getSkillCameraType(self.m_skillRo:getRefID())
    local dis = self:getAttackerDist()

    if self.m_skillRo:getCameraFocus() == 1 and (skillCameraType == 2 or skillCameraType == 8) then
        -- 奥义全体技能默认站战场中间
        targetPos = fight.SceneManager:getCenterPos()

    elseif dis == 0 then
        targetPos = fight.SceneManager:getCenterPos()
        targetPos.z = targetVo.position.z
    elseif dis == 999 then
        -- 原地释放
        targetPos = self.m_attacker_vo.position

    elseif self.m_main_target_vo == self.m_attacker_vo then
        -- 目标是自己
        targetPos = self.m_attacker_vo.position
    else
        targetPos = fight.SceneManager:getPosFront01(targetVo, dis)
    end

    return targetPos
end

-- 获取摄像机需要移动到的位置
function getCameraPos(self, targetPos, targetVo)
    local skillCameraType = fight.SkillManager:getSkillCameraType(self.m_skillRo:getRefID())
    local gridId = targetVo:getGridID()
    local cameraPos = nil

    -- if self.m_main_target_vo:isAttacker() == self.m_attacker_vo:isAttacker() then
    --     cameraPos = self:getGridCenter(true)
    --     return cameraPos
    -- end

    if skillCameraType == 2 then
        -- 全体
        cameraPos = self:getGridCenter()
        cameraPos = math.Vector3(cameraPos.x, cameraPos.y, cameraPos.z + targetPos.z)

        -- elseif skillCameraType == 3 then
        --     -- 直线
        --     local num = string.sub(gridId, 3, 3)
        --     cameraPos = fight.SceneManager:getGridPos00(targetVo.isAtt, (200 + tonumber(num)))
        -- elseif skillCameraType == 4 then
        -- 整排
        -- local num = string.sub(gridId, 1, 1)
        -- local pos = fight.SceneManager:getGridPos00(targetVo.isAtt, (tonumber(num) * 100 + 2))
        -- cameraPos = (targetPos + pos) * 0.5
        -- elseif skillCameraType == 5 then
        --     -- 十字
        --     cameraPos = fight.SceneManager:getGridPos00(targetVo.isAtt, gridId)
        -- elseif skillCameraType == 6 then
        --     -- 九宫格
        --     cameraPos = fight.SceneManager:getGridPos00(targetVo.isAtt, gridId)
        -- elseif skillCameraType == 7 then
        --     cameraPos = self:getGridCenter()
        --     cameraPos = math.Vector3(cameraPos.x, cameraPos.y, cameraPos.z + targetPos.z)
    elseif skillCameraType == 8 then
        cameraPos = self:getGridCenter()
        cameraPos = math.Vector3(cameraPos.x, cameraPos.y, cameraPos.z + targetPos.z)
    else
        if targetPos then
            cameraPos = (targetPos + targetVo.position) * 0.5
        end
    end
    return cameraPos
end

-- 战场受击方中心点
function getGridCenter(self, isSelf)
    local cameraPos
    if isSelf or self.m_main_target_vo:isAttacker() == 1 then
        cameraPos, _ = fight.SceneGrid:getACenter()
    else
        cameraPos, _ = fight.SceneGrid:getDCenter()
    end
    return cameraPos
end

-- 检查是否在战场中心 不是的话进行移动
function checkMoveCenter(self, targetVo)
    if self.m_liveID == targetVo.id then
        self:onStartUseSkill()
        return
    end

    local targetPos = self:getAttckerPos(targetVo)
    local cameraPos = self:getCameraPos(targetPos, targetVo)

    if self.m_skillRo:getCameraFocus() == 1 then
        if self.m_actionData and self.m_actionData.is_extra_skill == 1 then
            -- 轮到出手，立刻恢复为站立动作
            self.m_attacker_vo:updateAni(fight.FightDef.ACT_STAND)
        end

        -- 大招不显示移动过程
        self.m_attacker_vo:moveTo(targetPos, 0)
        self:onStartUseSkill(cameraPos)
        return
    end
    local centerPos = fight.SceneManager:getCenterPos()
    if self.m_liveObj and targetVo and targetVo.position then
        centerPos.z = targetVo.position.z
        -- 在起点出发
        -- if fight.SceneManager:isInRestorePos(self.m_attacker_vo) then
        --     self:onStartUseSkill(true)
        -- else
        if math.v3Distance(centerPos, self.m_attacker_vo:getCurPos()) > 0.2 then
            -- 目标改变了
            local function _endCall()
                self:onStartUseSkill()
            end
            self:movePos(centerPos, cameraPos, _endCall)
        else
            self:onStartUseSkill(cameraPos)
        end
        return
    end
    self:onStartUseSkill(cameraPos)
end

function setSkillLiveTimeout(self, cusDelay, cusThisObject, cusCallBack, cusCallBackParams)
    self:setLiveTimeout(self.m_liveID, cusDelay, cusThisObject, cusCallBack, cusCallBackParams)
end

-- 为技能轨迹添加事件
function setTravelEventCall(self, travel, hitCall, endCall)
    travel:setEventCall(hitCall, endCall)
    table.insert(self.m_useTravelSns, travel:sn())
end
-- 为buff添加事件
function setBuffEventCall(self, liveOwerID, buffVo, endCall)
    table.insert(self.m_useBuffInfos, { liveOwerID, buffVo:getRefID() })
end

-- 清除轨迹的事件处理
function _removeTravelEvent(self)
    for _, v in ipairs(self.m_useTravelSns) do
        STravelHandle:removeTravelEvent(v)
    end
    self.m_useTravelSns = {}
end

-- 清除Buff的事件处理
function _removeBuffEvent(self)
    for i, v in ipairs(self.m_useBuffInfos) do
        BuffHandler:removeBuffEvent(v[1], v[2])
    end
    self.m_useBuffInfos = {}
end

-- 显示有关系的角色的头顶信息
function _showRelationHeadInfo(self)
    -- if fight.FightManager:getIsFighting() ~= true then return end

    if fight.FightManager:getFightHpBarShow() then
        local dict = fight.SceneItemManager:getAllLiveThing()
        for _, live in pairs(dict) do
            local liveVo = live:getLiveVo()
            if liveVo then
                if not liveVo:isDead() then
                    live:showHeadBar()
                end
            end
        end
    else
        if self.m_liveObj then
            self.m_liveObj:showHeadBar()
        end
        if self.m_actionData then
            local hero_list = fight.FightManager:actionHeroList(self.m_actionData)
            if hero_list then
                for _, hero in ipairs(hero_list) do
                    local live = fight.SceneItemManager:getLivething(hero.hero_id)
                    if live then
                        live:showHeadBar()
                    end
                end
            end
        end
    end

    if self.m_skillRo:getCameraFocus() == 1 then
        -- 正在释放奥义的角色不显示血条
        if self.m_liveObj then
            self.m_liveObj:closeHeadBar()
        end
    end
end

-- 隐藏其他战员处理
function _displayOtherHero(self)
    -- if self.m_actionData == nil then
    --     local dict = fight.SceneItemManager:getAllLiveThing()
    --     for id, live in pairs(dict) do
    --         if id ~= self.m_liveID and id ~= self.m_main_target_vo:getLiveID() then
    --             -- live:setTranparency(0)
    --             live:setVisible(false)
    --         end
    --     end
    --     return
    -- end

    -- local targetList = self.m_actionPlayer:getPriorityTargets()
    local targetList = nil-- fight.FightManager:actionHeroList(self.m_actionData)
    if self.m_actionData then
        targetList = fight.FightManager:actionHeroList(self.m_actionData)
    elseif SkillHandleIns then
        -- 编辑器下
        targetList = SkillHandleIns:getActHeroList(self:skillID())
    end

    local dict = fight.SceneItemManager:getAllLiveThing()
    if targetList then
        local beFind = false
        for liveID, v in pairs(dict) do
            if liveID ~= self.m_liveID then
                beFind = false
                for _, hero in ipairs(targetList) do
                    local heroId = hero.hero_id or hero.id
                    if heroId == liveID then
                        beFind = true
                        break
                    end
                end
                if beFind == false then
                    -- v:setTranparency(0)
                    v:setVisible(false)
                end
            end
        end
    else
        for liveID, v in pairs(dict) do
            if liveID ~= self.m_liveID and self.m_liveID ~= self.m_main_target_vo:getLiveID() then
                -- v:setTranparency(0)
                v:setVisible(false)
            end
        end
    end
end

-- 把目标添加到击飞挂点
function addToHitNode(self)
    local targetList = nil
    if self.m_actionData then
        targetList = fight.FightManager:actionHeroList(self.m_actionData)
    elseif SkillHandleIns then
        -- 编辑器下
        targetList = SkillHandleIns:getActHeroList(self:skillID())
    end

    for _, targetVo in pairs(targetList) do
        if targetVo.hero_id ~= self.m_attacker_vo.id then
            local live = fight.SceneItemManager:getLivething(targetVo.hero_id or targetVo.id)

            -- boss、冰冻 不进入击飞挂点
            if live and live:getLiveVo():getRaceVo().monType ~= monster.MonsterType.SUPER_BOSS and not live:getLiveVo().isFroze then
                local point = self.m_liveObj:getPointTrans(fight.FightDef.POINT_HIT)
                if point then
                    live:setToParent(point, true)

                    local skillCameraType = fight.SkillManager:getSkillCameraType(self.m_skillRo:getRefID())
                    if (self.m_skillRo:getCameraFocus() == 1) and skillCameraType == 1 then
                        live:setPosition(point.position)
                    end
                end
            end
        end
    end
end

-- 播放技能音效
function _playAudioList(self, audios)
    if table.empty(audios) then return end

    local function _audioCall(xx, audioName)
        if self.m_liveObj then
            AudioManager:playFightSoundEffect(UrlManager:getFightSoundPath(audioName), false, nil, self.m_liveObj:getTrans())
        else
            AudioManager:playFightSoundEffect(UrlManager:getFightSoundPath(audioName), false, self.m_attacker_vo:getCurPos())
        end
    end
    for _, v in ipairs(audios) do
        if v.sound then
            local orgData = self.m_main_target_vo:getOrgData()
            if v.staggerType == 0 or (orgData and orgData.stagger_voice == v.staggerType) then
                self:setTimeout(v.time * PER_FRAME_SEC + PER_FRAME_SEC, nil, _audioCall, v.sound)
            end
        end
    end
end

-- 技能特效
function _playEftList(self, efts, aniLenght)
    if table.empty(efts) then return end
    local function _eftCall(xx, eftData)
        if self.m_attacker_vo and self.m_attacker_vo:isDead() then
            -- 释放过程中攻击者死了
            self:reset()
            return
        end

        local onStarTravel = function(travel)
            if travel then
                local eftName = UrlManager:getEfxRolePath(eftData.eftName)
                travel:setPerfData(eftName, nil, eftData.endTime, eftData)
                travel:setSimplePoint(eftData.eftPointB)
                local function _travelEnd(curTravel)
                    self.m_travelDict[curTravel.mc_sn] = nil
                end
                travel:setEventCall(nil, _travelEnd)
                self.m_travelDict[travel.mc_sn] = true
                travel:start()

                if self.m_skillRo:getType() ~= SCENE_SKILL_TYPE then
                    if eftData.eftPointB == 0 then
                        -- 挂施法者身上
                        self.m_attacker_vo:addTravelSns(travel.mc_sn)

                    elseif eftData.eftPointB == 1 then
                        -- 挂被攻击者身上
                        local thingVo = fight.SceneManager:getThing(travel:getTragetID())
                        if thingVo then
                            thingVo:addTravelSns(travel.mc_sn)
                        end
                    end
                end
            end
        end

        local attackerId = self.m_attacker_vo and self.m_attacker_vo.id or 0
        local targeterId = self.m_main_target_vo and self.m_main_target_vo.id or 0
        local side = self.m_actionData and self.m_actionData.side or 0

        local travel = nil
        if eftData.eftType == 0 then --点放
            travel = STravelFactory:travel02(self:skillID(), 3, attackerId, targeterId, nil, side)
            onStarTravel(travel)
        elseif eftData.eftType == 1 then --电链
            travel = STravelFactory:travel02(self:skillID(), 7, attackerId, targeterId, nil, side)
            onStarTravel(travel)
        elseif eftData.eftType == 2 then --导弹集
            travel = STravelFactory:travel02(self:skillID(), 8, attackerId, targeterId, nil, side)
            onStarTravel(travel)
            -- elseif eftData.eftType==1 then --直线子弹
            --     travel = STravelFactory:travel02(self:skillID(), 1, self.m_attacker_vo.id, self.m_main_target_vo.id)
            --     travel:setMoveTime(eftData.eftSpeed)
            --     travel:setEndPointType(eftData.eftEndPoint)
            -- elseif eftData.eftType==2 then --抛物线炮弹
            --     travel = STravelFactory:travel02(self:skillID(), 2, self.m_attacker_vo.id, self.m_main_target_vo.id)
            --     travel:setMoveTime(eftData.eftSpeed, eftData.eftHeight)
            --     travel:setEndPointType(eftData.eftEndPoint)
        elseif eftData.eftType == 3 then
            -- 多目标挂受击特效
            local hero_list = nil

            if self.m_actionData then
                hero_list = fight.FightManager:actionHeroList(self.m_actionData)
            elseif SkillHandleIns then
                -- 编辑器下
                hero_list = SkillHandleIns:getActHeroList(self:skillID())
            end


            if hero_list then
                for i, targetVo in ipairs(hero_list) do
                    if not self.m_skillRo or (self.m_skillRo:getSkillTarget() == 0 and targetVo.hero_id == self.m_attacker_vo.id) then
                        -- 对敌方的技能受击效果不包括自己
                    else
                        travel = STravelFactory:travel02(self:skillID(), 3, self.m_attacker_vo.id, (targetVo.hero_id or targetVo.id))
                        onStarTravel(travel)
                    end
                end
            end
        end
    end
    -- 特效质量 → 特效资源
    -- local quality = systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.effect)
    -- local eftCount = 0
    for _, v in ipairs(efts) do
        if v.eftName then
            -- if not v.playLv or v.playLv == quality then
            if not v.endTime or v.endTime == 0 then
                v.endTime = aniLenght - v.time * PER_FRAME_SEC + 1
            end
            -- eftCount = eftCount + 1
            self:setTimeout(v.time * PER_FRAME_SEC, nil, _eftCall, v)
            -- end
        end
    end
    -- if eftCount > 1 then
    --     logWarn("==该技能特效同级耗能配置超过1个，请美术检查技能特效配置，非相关同学请无视本报错==skillId:" .. self:skillID())
    -- end
end

-- 编辑器模型下打中目标的处理
function _hitTargetEditor(self, targetVo, hitData)
    -- 受击飘字
    if not SkillEditorDef or SkillEditorDef.IS_SHOW_FLY_FONT == true then
        local targetLive = fight.SceneItemManager:getLivething(targetVo:getLiveID())
        if targetLive then
            local pos = targetLive:getPointPos(fight.FightDef.POINT_SPINE)
            fightUI.FightFlyUtil:fly3D03(targetVo:getLiveID(), fight.FightDef.BATTLE_TYPE_BURN, 999, pos, targetVo:isAttacker())
        end
    end

    -- 受击动作
    if hitData.hitActHash == fight.FightDef.ACT_DIE then
        local function _actFinishCall()
        end
        targetVo:updateAni(hitData.hitActHash, nil, _actFinishCall)
        -- targetVo:setAnimationBoolVal(fight.FightDef.ANI_BOOL_TO_GETUP, true)
    else
        targetVo:updateAni(hitData.hitActHash)
    end
    if self.m_actionHitCall then
        self.m_actionHitCall(hitData.hitActHash)
    end

    if hitData.hitActHash == fight.FightDef.ACT_HIT_1 then
        PostHandler:chromaticTween(0.045, 1, 0, 0.1)
    elseif hitData.hitActHash == fight.FightDef.ACT_HIT_2 then
        PostHandler:chromaticTween(0.045, 1, 0, 0.1)
    elseif hitData.hitActHash == fight.FightDef.ACT_HIT_3 then
        PostHandler:chromaticTween(0.03, 1, 0, 0.1)
    elseif hitData.hitActHash == fight.FightDef.ACT_HIT_4 then
        PostHandler:chromaticTween(0.03, 1, 0, 0.1)
    elseif hitData.hitActHash == fight.FightDef.ACT_HIT_5 then
        PostHandler:chromaticTween(0.06, 1, 0, 0.2)
    elseif hitData.hitActHash == fight.FightDef.ACT_HIT_6 then
        PostHandler:chromaticTween(0.1, 1, 0, 0.2)
    end

    -- 普通攻击才追加受击音效 --更改做法了，受击和攻击做一起了，材质直接区分
    -- if self.m_skillRo:getType() == 0 then
    --     -- 受击音效
    --     local voiceType = 1
    --     local hitType = fight.FightDef.HITTYPE_REVERSE[hitData.hitActHash] or 1
    --     local orgData = targetVo:getOrgData()
    --     if orgData then
    --         voiceType = orgData.stagger_voice
    --     end
    --     local curLiveVo = self.m_attacker_vo:getCurDisplayLiveVo()

    --     local modelID = curLiveVo:getModelID()
    --     local soundRo = fight.FightLoader:getSoundRo(modelID)
    --     if soundRo then
    --         local audioUrl = nil
    --         local lst = nil
    --         if voiceType == 1 then
    --             lst = soundRo:getFlesh()
    --             audioUrl = lst[hitType]
    --         elseif voiceType == 2 then
    --             lst = soundRo:getMetal()
    --             audioUrl = lst[hitType]
    --         else
    --             lst = soundRo:getFmType()
    --             audioUrl = lst[hitType]
    --         end

    --         if audioUrl then
    --             AudioManager:playFightSoundEffect(UrlManager:getFightSoundPath(modelID .. "/" .. audioUrl), nil, nil, targetVo:getCurPos())
    --         end
    --     end
    -- end
    -- 受击特效
    if hitData.hitEft and #hitData.hitEft > 0 then
        local travel = STravelFactory:travel02(self:skillID(), 3, self.m_attacker_vo.id, targetVo:getLiveID())
        travel:setPerfData(UrlManager:getEfxRolePath(hitData.hitEft), nil, 1)
        travel:setSimplePoint(1)
        local function _travelEnd(curTravel)
            self.m_travelDict[curTravel.mc_sn] = nil
        end
        travel:setEventCall(nil, _travelEnd)
        self.m_travelDict[travel.mc_sn] = true
        travel:start()
    end
end

-- 胜利镜头顿帧表现
function _showWinCamera(self, showType)
    if self.isEditorControlWin and showType ~= 2 then
        -- 配置控制优先级最高
        return
    end

    -- 完成 正常化游戏速度
    local function _winFinsih(self)
        self:reset()
    end

    local resultData = fight.FightManager:actionResultData(self.m_actionData)

    -- resultData.is_final_hit 0不是战斗最后一击，1敌方全灭，2我方全灭
    if (not self.m_actionData and SkillEditorDef and SkillEditorDef.IS_SKILL_SHOW_WIN) or (resultData and resultData.is_final_hit == 1) then
        RateLooperUnScale:clearTimeout(self.m_frameLagSn)
        self.m_frameLagSn = nil
        gs.Time.timeScale = fight.FightManager:getTimeScale() * 0.1
        self.m_winBlackSn = RateLooperUnScale:setTimeout(2 / fight.FightManager:getTimeScale(), self, _winFinsih)

        PostHandler:chromaticTween(0.05, 1, 0, 0.5)
        PostHandler:bloomIntensityTween(0.1, 0.25, 3, 0.1, function()
            PostHandler:bloomIntensityTween(0.1, 3, 0.25, 0.5)
        end)
    end
end

-- 受击列表处理
function _playTargetList(self, targetDatas, refId)
    if table.empty(targetDatas) then
        return
    end

    local function _hitCall(xx, params)
        local hitData = params.hitData
        local idx = params.idx
        if fight.FightManager:getQteType() == fight.FightDef.BATTLE_QTE_PERFECT then
            ABBlock.ABBlockMgr.noTargetHit = true
        end

        if idx >= #targetDatas then
            -- 最后一段受击处理胜利镜头
            self:_showWinCamera(1)
        end

        if self.m_actionData == nil then
            self:_hitTargetEditor(self.m_main_target_vo, hitData)
            return
        end

        ABBlock.ABBlockMgr:stopJudgeBlock()

        self.m_actionPlayer:playEftSection(hitData, self.m_skillRo)
    end

    -- blockType 格挡类型
    local function _startBlockHandle(xx, params)
        ABBlock.ABBlockMgr:startJudgeBlock(self.m_main_target_vo, params.idx, params.blockType)

        if guide.GuideCondition:condition24(refId) then
            GameDispatcher:dispatchEvent(EventName.GUIDE_BLOCK_EVENT)
            return
        end

        if guide.GuideCondition:condition06() then
            GameDispatcher:dispatchEvent(EventName.GUIDE_BLOCK_EVENT)
            return
        end

        if self.m_actionData and fight.FightManager:isOnlyQteAction(self.m_actionData.actionID) then
            ABBlock.ABBlockMgr:setCanBlock(true)
        end
        if ABBlock.ABBlockMgr.tmpAutoTest then
            ABBlock.ABBlockMgr:setCanBlock(true)
        end
    end

    for i, v in ipairs(targetDatas) do
        if i == 1 then --只做第一下
            if self.m_skillRo:getQteArg() == 1 and (self.m_main_target_vo:isAttacker() == 1) then

                -- 完美格挡
                local perfectInterval = v.time * PER_FRAME_SEC - ABBlock.ABBlockMgr.perfectInterval -- - 0.2
                if perfectInterval <= 0 then
                    _startBlockHandle(nil, { idx = i, blockType = fight.FightDef.BATTLE_QTE_PERFECT })
                else
                    -- 中等格挡
                    local mediumInterval = v.time * PER_FRAME_SEC - ABBlock.ABBlockMgr.mediumInterval - ABBlock.ABBlockMgr.perfectInterval
                    if mediumInterval <= 0 then
                        _startBlockHandle(nil, { idx = i, blockType = fight.FightDef.BATTLE_QTE_MEDIUM })
                    else
                        -- 普通格挡
                        local noamlInterval = v.time * PER_FRAME_SEC - ABBlock.ABBlockMgr.nomalInterval - ABBlock.ABBlockMgr.mediumInterval - ABBlock.ABBlockMgr.perfectInterval
                        if noamlInterval <= 0 then
                            _startBlockHandle(nil, { idx = i, blockType = fight.FightDef.BATTLE_QTE_NOMAL })
                        else
                            self:setTimeout(perfectInterval, nil, _startBlockHandle, { idx = i, blockType = fight.FightDef.BATTLE_QTE_PERFECT })
                            self:setTimeout(mediumInterval, nil, _startBlockHandle, { idx = i, blockType = fight.FightDef.BATTLE_QTE_MEDIUM })
                            self:setTimeout(noamlInterval, nil, _startBlockHandle, { idx = i, blockType = fight.FightDef.BATTLE_QTE_NOMAL })
                        end
                    end
                end
            end
        end
        self:setTimeout(v.time * PER_FRAME_SEC, nil, _hitCall, { idx = i, hitData = v })
    end
end

-- 技能镜头顿帧列表
function _playFrameList(self, frameDatas)
    if table.empty(frameDatas) then return end
    local function _frameRestore()
        self.m_frameLagSn = nil
        fight.FightManager:updateTimeScale(fight.FightManager:getTimeScaleType())
    end
    local function _frameCall(xx, fd)
        local allSide2 = fight.SceneManager:getSideNoDead(2)
        if self.m_actionData and table.empty(allSide2) then
            -- 需要播放胜利镜头，所以技能顿帧不需要继续显示
            return
        end
        if fd.frameInterval and fd.frameInterval > 0 then
            gs.Time.timeScale = fight.FightManager:getTimeScale() * (fd.frameSpeed or 0)
            RateLooperUnScale:clearTimeout(self.m_frameLagSn)
            self.m_frameLagSn = RateLooperUnScale:setTimeout(fd.frameInterval / fight.FightManager:getTimeScale(), self, _frameRestore)
        end
    end
    for _, v in ipairs(frameDatas) do
        self:setTimeout(v.time * PER_FRAME_SEC, nil, _frameCall, v)
    end
end

-- 自动战斗过程提前结束技能
function _playAutoSkip(self, skipDatas)
    if table.empty(skipDatas) then return end
    local function _skillCall(xx)
        -- 自动跳过后摇
        if StorageUtil:getBool1(gstor.FIGHT_SKIP_SKILL) or (SkillEditorDef and SkillEditorDef.IS_AUTO_SKIP_SKILL) then
            self.skipSkil = true
            self:reset()
        end
    end
    for _, v in ipairs(skipDatas) do
        if v.skipType and v.skipType == 1 then
            -- 胜利镜头展示
            self.isEditorControlWin = true
            self:setTimeout(v.time * PER_FRAME_SEC, self, self._showWinCamera, 2)
        else
            -- 自动战斗跳过技能硬直
            self:setTimeout(v.time * PER_FRAME_SEC, nil, _skillCall)
        end
    end
end

-- 方便子类调用的方法 END===================================

return _M

--[[ 替换语言包自动生成，请勿修改！
]]