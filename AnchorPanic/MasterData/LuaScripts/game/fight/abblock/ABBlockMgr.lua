
module("ABBlock.ABBlockMgr", Class.impl())
-------------------------------

-- 构造函数
function ctor(self)
    -- 可以审视挡格
    self.mCanJudgeBlock = false
    -- 顿帧前的帧率
    self.mLastTimeScale = 1
    -- 挡格对象
    self.mBlockLiveVo = nil
    -- 挡格成功的顿帧间隔
    self.mFrameInterval = sysParam.SysParamManager:getValue(SysParamType.BLOCK_CAMERA_TIME)/1000.0 --0.3
    -- 特写的速度
    self.mTmpTimeScale = sysParam.SysParamManager:getValue(SysParamType.BLOCK_SCALE_TIME)/10000.0 --* 0.1
    -- 挡格标志下标
    self.mFlagIdx = nil
    -- 是否第一次
    self.mIsFirstBlock = true
    -- 格挡类型1 普通格挡 2 完美格挡
    self.mBlockType = nil
    -- 测试自动格挡
    self.tmpAutoTest = false
    -- 测试停止顿帧
    self.mTmpStopFrame = true
    
    
    -- 完成完美格挡不播放受击动作
    self.noTargetHit = nil
    -- 完美挡格时间间隔
    self.perfectInterval = sysParam.SysParamManager:getValue(SysParamType.BLOCK_JUDGE_TIME)/1000.0 or 0.1
    -- 中等格挡时间间隔
    self.mediumInterval = sysParam.SysParamManager:getValue(SysParamType.BLOCK_MEDIUM_JUDGE_TIME)/1000.0 or 0.1
    -- 普通格挡时间间隔
    self.nomalInterval = sysParam.SysParamManager:getValue(SysParamType.BLOCK_NOMAL_JUDGE_TIME)/1000.0 or 0.1
end

-- 重置挡格数据
function resetBlock(self)
    self.mFlagIdx = nil
    self.mIsFirstBlock = true
    RateLooper:clearTimeout(self.mJudgeSn)
    self.mJudgeSn = nil
    fight.FightManager:setQteType(fight.FightDef.BATTLE_QTE_NONE)
    
    if self.mBlockTravel then
        STravelHandle:endTravel(self.mBlockTravel.mc_sn)
    end
end

-- 技能首次格挡（只能在伤害第一段触发格挡）
function isFirst(self)
    return self.mIsFirstBlock
end

-- 尝试触发挡格
function setCanBlock(self)
    if self.mCanJudgeBlock==false then return false end
    if self:isEnoughBlockVal()~=true then return false end
    if self.mFlagIdx==1 then
        self.mFlagIdx = 2
        if self.mBlockType == fight.FightDef.BATTLE_QTE_PERFECT then
            fight.FightManager:setQteType(fight.FightDef.BATTLE_QTE_PERFECT)
        elseif self.mBlockType == fight.FightDef.BATTLE_QTE_MEDIUM then
            fight.FightManager:setQteType(fight.FightDef.BATTLE_QTE_MEDIUM)
        elseif self.mBlockType == fight.FightDef.BATTLE_QTE_NOMAL then
            fight.FightManager:setQteType(fight.FightDef.BATTLE_QTE_NOMAL)
        end
        -- if fight.FightManager:getQteType()==fight.FightDef.BATTLE_QTE_PERFECT then
            self:judgeBlockFinish()
            return true
        -- end
    end
    return false
end

-- 开始检查挡格
function startJudgeBlock(self, liveVo, idxFlag, blockType)
    if liveVo and not liveVo:isDead() then
        self.mFlagIdx = idxFlag
        self.mBlockLiveVo = liveVo
        self.mBlockType = blockType
        self.mCanJudgeBlock = true
        RateLooper:clearTimeout(self.mJudgeSn)
        if blockType == fight.FightDef.BATTLE_QTE_PERFECT then
            self.mJudgeSn = RateLooper:setTimeout(self.perfectInterval, self, self.judgeBlockFinish)
        elseif blockType == fight.FightDef.BATTLE_QTE_MEDIUM then
            self.mJudgeSn = RateLooper:setTimeout(self.mediumInterval, self, self.judgeBlockFinish)
        elseif blockType == fight.FightDef.BATTLE_QTE_NOMAL then
            self.mJudgeSn = RateLooper:setTimeout(self.nomalInterval, self, self.judgeBlockFinish)
        end
    end
end

-- 触发真正的挡格判断
function judgeBlockFinish(self)
    if self.mIsFirstBlock then
        fight.FightManager:reqBattleVideoEnd()
        if fight.FightManager:getQteType()==fight.FightDef.BATTLE_QTE_PERFECT then
            print("judgeBlockFinish ===================BATTLE_QTE_PERFECT")
            self:startBlock()
        elseif fight.FightManager:getQteType()==fight.FightDef.BATTLE_QTE_MEDIUM then
            print("judgeBlockFinish ===================BATTLE_QTE_MEDIUM")
            self:startBlock()
        elseif fight.FightManager:getQteType()==fight.FightDef.BATTLE_QTE_NOMAL then
            print("judgeBlockFinish ===================BATTLE_QTE_NOMAL")
            self:startBlock()
        end
    end
    self:stopJudgeBlock()
end

-- 停止格挡
function stopJudgeBlock(self)
    RateLooper:clearTimeout(self.mJudgeSn)
    self.mJudgeSn = nil
    self.mCanJudgeBlock = false
    -- if self.mIsFirstBlock then
    --     -- fight.FightManager:reqBattleVideoEnd()
    -- end
    self.mIsFirstBlock = false
end

-- 可以审视挡格
function isCanJudgeBlock(self)
    return self.mCanJudgeBlock
end

-- 是否需要格挡
function isNeedBlock(self)
    local skillAI = fight.FightAction:getCurSkillAI()
    if not skillAI or skillAI:skillID() == nil then 
        return false 
    end
    local skillRo = fight.SkillManager:getSkillRo(skillAI:skillID())
    if not skillRo then 
        return false 
    end
    return true
end

-- 格挡能量是否足够
function isEnoughBlockVal(self)
    local val = fight.FightManager:getBlockVal(1)
    if not val or val<=0 then
        return false 
    end
    local skillAI = fight.FightAction:getCurSkillAI()
    if not skillAI then 
        return false 
    end
    local skillRo = fight.SkillManager:getSkillRo(skillAI:skillID())
    if not skillRo then 
        return false 
    end
    local skillType = skillRo:getType()
    if skillType==0 and val<sysParam.SysParamManager:getValue(SysParamType.BLOCK_NOR_EXPEND, 1) then
        return false
    elseif skillType==1 and val<sysParam.SysParamManager:getValue(SysParamType.BLOCK_NOR_SKILL_EXPEND, 1) then
        return false
    elseif skillType==2 and val<sysParam.SysParamManager:getValue(SysParamType.BLOCK_MIX_SKILL_EXPEND, 1) then
        return false
    elseif skillType==3 and val<sysParam.SysParamManager:getValue(SysParamType.BLOCK_MAX_SKILL_EXPEND, 1) then
        return false
    end
    return true
end

function blockEffect(self)
    local buffPath = ""
    if fight.FightManager:getQteType()==fight.FightDef.BATTLE_QTE_PERFECT then
         buffPath = "buff_gedang_wanmei.prefab"
    elseif fight.FightManager:getQteType()==fight.FightDef.BATTLE_QTE_MEDIUM then
        buffPath = "buff_gedang_zhongdeng.prefab"
    elseif fight.FightManager:getQteType()==fight.FightDef.BATTLE_QTE_NOMAL then
        buffPath = "buff_gedang_putong.prefab"
    end
    if self.mBlockLiveVo then
        self.mBlockTravel = STravelFactory:travel02(nil, 3, self.mBlockLiveVo.id, self.mBlockLiveVo.id)
        if self.mBlockTravel then
            self.mBlockTravel:setPerfData(UrlManager:get3DBuffPath(buffPath), nil, 6)
            self.mBlockTravel:setSimplePoint(0)
            self.mBlockTravel:start()
        end
    end
end
-- 挡格触发后的逻辑
function startBlock(self)
    -- print("startBlock =======================")
    if self.mBlockLiveVo then
        local objLive = fight.SceneItemManager:getLivething(self.mBlockLiveVo:getLiveID())
        if objLive then
            local pos = objLive:getPointPos(fight.FightDef.POINT_SPINE)
            -- print("startBlock ===============",pos)
            if fight.FightManager:getQteType()==fight.FightDef.BATTLE_QTE_PERFECT then
                fightUI.FightFlyUtil:fly3DImg(UrlManager:getFightArtfontPath("fightArtImg999.png"), pos, true)
            elseif fight.FightManager:getQteType()==fight.FightDef.BATTLE_QTE_MEDIUM then
                fightUI.FightFlyUtil:fly3DImg(UrlManager:getFightArtfontPath("fightArtImg998.png"), pos, true)
            elseif fight.FightManager:getQteType()==fight.FightDef.BATTLE_QTE_NOMAL then
                fightUI.FightFlyUtil:fly3DImg(UrlManager:getFightArtfontPath("fightArtImg997.png"), pos, true)
            end
        end        
        self:blockEffect()
    end
    if self.mTmpStopFrame and self.mIsFirstBlock and fight.FightManager:getQteType()==fight.FightDef.BATTLE_QTE_PERFECT then
        if self.mTmpTimeScale<=0 then
            LoopManager:setStop(true)
        end
        fight.FightManager:setupTimeScale(fight.FightManager:getTimeScale() * self.mTmpTimeScale)
        RateLooperUnScale:setTimeout(self.mFrameInterval/fight.FightManager:getTimeScale(), self, self._blockFinsih)
        -- fight.FightManager:setupTimeScale(self.mTmpTimeScale)
        -- RateLooperUnScale:setTimeout(self.mFrameInterval, self, self._blockFinsih)
        
    end
end
-- 挡格完成 正常化游戏速度
function _blockFinsih(self)
    fight.FightManager:updateTimeScale(fight.FightManager:getTimeScaleType())
end

-- 能源立场受击效果
function blockTargetHit(self, targetVo)
    local buffPath = nil
    if fight.FightManager:getQteType() == fight.FightDef.BATTLE_QTE_PERFECT then
        buffPath = "buff_gedang_wanmei_hit.prefab"
    elseif fight.FightManager:getQteType() == fight.FightDef.BATTLE_QTE_MEDIUM then
        buffPath = "buff_gedang_zhongdeng_hit.prefab"
    elseif fight.FightManager:getQteType() == fight.FightDef.BATTLE_QTE_NOMAL then
        buffPath = "buff_gedang_putong_hit.prefab"
    end
    if buffPath then
        local travel = STravelFactory:travel02(nil, 3, targetVo:getLiveID(), targetVo:getLiveID())
        travel:setPerfData(UrlManager:get3DBuffPath(buffPath), nil, 6)
        travel:setSimplePoint(0)
        travel:start()
    end
end

-- 显示攻击提示（可格挡）
function showCanBlockEff(self, attackVo)
    self.mDangerTravel = STravelFactory:travel02(nil, 3, attackVo.id, attackVo.id)
    self.mDangerTravel:setPerfData(UrlManager:get3DBuffPath("buff_weixiantishi_01.prefab"), nil, 6)
    self.mDangerTravel:setSimplePoint(0)
    self.mDangerTravel:start()

    local lifeTime = self.nomalInterval + self.perfectInterval
    self.mDangerEffSn = RateLooper:setTimeout(lifeTime, self, self.blockDangerFinish)
end

function blockDangerFinish(self)
    if self.mDangerTravel then
        STravelHandle:endTravel(self.mDangerTravel.mc_sn)
    end
end

-- 播放能源立场展开音效
function playABBlockShowAudio(self)
    local audioPath = nil
    if fight.FightManager:getQteType() == fight.FightDef.BATTLE_QTE_PERFECT then
        audioPath = "ui_shield_perfect.prefab"
    elseif fight.FightManager:getQteType() == fight.FightDef.BATTLE_QTE_MEDIUM then
        audioPath = "ui_shield_medium.prefab"
    elseif fight.FightManager:getQteType() == fight.FightDef.BATTLE_QTE_NOMAL then
        audioPath = "ui_shield_common.prefab"
    end
    AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath(audioPath))
end
-- 播放能源立场能源不足的警告音
function palyABBlockWarnAduio(self)
    AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_shield_warn.prefab"))
end
-- 播放能源立场miss的提示音
function palyABBlockMissAduio(self)
    AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_shield_miss.prefab"))
end

return _M


 
--[[ 替换语言包自动生成，请勿修改！
]]
