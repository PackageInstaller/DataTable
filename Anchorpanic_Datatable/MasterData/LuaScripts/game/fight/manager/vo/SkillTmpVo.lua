module("fight.SkillTmpVo", Class.impl())

function ctor(self)
    self.mHeroID = 0
    self.mRoundLimit = 0
    self.mCdRound = 0
    self.mExtraCost = 0
    self.mSkillRo = nil
    self.mSkillPosInfo = nil

    self.mIsUse = false
    --动态更新的技能消耗
    self.mNewCost = nil
    -- 是否锁定
    self.mIsLock = false

    -- 被buff改变的cd轮次
    self.mCdRoundFromBuff = nil
end

-- 设置锁住
function setLock(self, beLock)
    self.mIsLock = beLock
end

-- 获取是否锁住
function getLock(self)
    return self.mIsLock
end

-- 设置是否使用
function setIsUse(self, beUse)
    self.mIsUse = beUse
end
function getBeUse(self)
    return self.mIsUse
end

-- 设置技能数据 skillPosInfo技能位置信息
function setSkillData(self, heroID, skillPosInfo)
    self.mHeroID = heroID
    self.mSkillPosInfo = skillPosInfo
    self.mSkillRo = fight.SkillManager:getSkillRo(self.mSkillPosInfo.id)
    -- 开局限制
    self.mRoundLimit = self.mSkillRo:getRoundLimit()
end

-- 设置技能数据 skillId技能id
function setSkillData02(self, heroID, skillId)
    self.mHeroID = heroID
    self.mSkillPosInfo = nil
    self.mSkillRo = fight.SkillManager:getSkillRo(skillId)
    -- 开局限制
    self.mRoundLimit = self.mSkillRo:getRoundLimit()
end

-- 获取技能位置
function getSkillPos(self)
    if self.mSkillPosInfo then
        return self.mSkillPosInfo.pos
    end
    return nil
end

-- 获取战员id
function getHeroID(self)
    return self.mHeroID
end

-- 判断当前技能是否可用
function canUse(self, extraCost)
    if self.mIsLock == true then return false end
    if self:cdCanUse() == 0 then
        local liveVo = fight.SceneManager:getThing(self.mHeroID)
        if liveVo then
            if self:skillType() == 3 then
                -- 奥义是怒气，分开判断
                if self.mNewCost and self.mNewCost > 0 then
                    if liveVo:getAtt(AttConst.MP) >= self.mNewCost then return true end
                end
                if liveVo:getAtt(AttConst.MP) < fight.FightManager:getMaxRage(self.mHeroID) then
                    return false
                end
            else
                -- 普通技能是能量
                local cost = self:skillCost()
                -- extraCost = extraCost or 0
                -- cost = cost + extraCost
                if cost > liveVo:getAtt(AttConst.SKILL_SOUL) then
                    return false
                end
            end
            return true
        end
    end
    return false
end

-- 判断是否cd中
function cdCanUse(self)
    if self.mIsLock == true then return 0 end

    if self.mRoundLimit > 0 then
        return self.mRoundLimit
    end
    if self.mCdRound > 0 then
        return self.mCdRound
    end
    return 0
end

-- 设置新的cd轮次（buff改变技能的固有cd）
function setNewCdRound(self, round)
    self.mCdRoundFromBuff = round
end

-- 技能使用了
function useSkill(self)
    if self.mCdRoundFromBuff and self.mCdRoundFromBuff > 0 then
        -- 以buff改变的技能cd轮次优先
        self.mCdRound = self.mCdRoundFromBuff
    else
        self.mCdRound = self.mSkillRo:getRoundCd()
    end
end

-- 计算一个回合
function roleTurn(self)
    if self.mIsLock == true then return 0 end

    if self.mRoundLimit > 0 then
        self.mRoundLimit = self.mRoundLimit - 1
    end
    if self.mCdRound > 0 then
        self.mCdRound = self.mCdRound - 1
    end
end

-- 设置cd
function setCD(self, cd)
    self.mCdRound = cd or 0
end

-- 获取cd轮次
function cd(self)
    return self.mCdRound
end

-- 技能基础数据
function skillRo(self)
    return self.mSkillRo
end

-- 技能类型
function skillType(self)
    return self.mSkillRo:getType()
end

-- 技能消耗
function skillCost(self)
    -- if self.mIsLock==true then return 0 end
    if self.mNewCost and self.mNewCost > 0 then
        return self.mNewCost
    end
    return self.mSkillRo:getCost() + self.mExtraCost
end

-- 设置新的技能消耗
function setNewSkillCost(self, newCost)
    self.mNewCost = newCost
end

-- 额外消耗值（可正负）
function setExtraCost(self, extraCost)
    self.mExtraCost = extraCost or 0
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]