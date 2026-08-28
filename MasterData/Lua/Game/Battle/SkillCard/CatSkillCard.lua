--
-- Author:pikaqiu
-- Date: 2013-7-25
--

local CatSkillCard = {}
CatSkillCard = Class('CatSkillCard')

CatSkillCard.roleId = nil
CatSkillCard.skillIndex = 0
CatSkillCard.star = nil         -- 技能星级
CatSkillCard.CD = nil           -- 技能CD
CatSkillCard.remainCD = nil     -- 剩余CD
CatSkillCard.canUseNum = nil    -- 可使用次数
CatSkillCard.remainNum = nil    -- 剩余次数

function  CatSkillCard:__init(roleId, star, initCD, CD, canUseNum, id, aiSlotIndex)
    self.roleId = roleId
    self.skillIndex = 0
    self.star = star                            -- 技能星级
    self.CD = CD                                -- 技能CD
    self.remainCD = initCD                      -- 剩余CD
    self.canUseNum = canUseNum                  -- 可使用次数
    self.remainNum = canUseNum                  -- 剩余次数
    self.id = id or Core:GetNextSkillCardID()
    self.aiSlotIndex = aiSlotIndex or 1         -- 自动出牌的位置
end

function CatSkillCard:ToData(  )
    return table.concat({self.roleId, self.star, self.remainCD, self.CD, self.remainNum, self.canUseNum}, "_")
end

--- 减少CD
---@param num any
function CatSkillCard:ReduceCD(num)
    self.remainCD = math.max(self.remainCD - num, 0)
end

--- 设置CD
---@param num any
function CatSkillCard:SetCD(num)
    self.remainCD = math.max(num, 0)
end

--- 重置冷却
function CatSkillCard:ResetCD()
    self.remainCD = self.CD
end

--- 重置冷却，但是+1（在使用卡牌的时候重置冷却，但是下回合开始会立即-1，这样就少了1回合，所以这个接口会多+1）
function CatSkillCard:ResetCD1()
    self.remainCD = self.CD + 1
end

--- 减少使用次数
---@param num any
function CatSkillCard:ReduceUseNum(num)
    self.remainNum = math.min(math.max(self.remainNum - num, 0), self.canUseNum)
end

--- 设置使用次数
---@param num any
function CatSkillCard:SetUseNum(num)
    self.remainNum = math.min(math.max(num, 0), self.canUseNum)
end

--- 是否还有剩余次数
function CatSkillCard:HasRemainNum()
    if self.remainNum == -1 then
        return true
    else
        return self.remainNum > 0
    end
end

function CatSkillCard:CanUse()
    return self:HasRemainNum() and self.remainCD == 0
end

return  CatSkillCard