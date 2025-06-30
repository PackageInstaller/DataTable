module("formationLV.FormationLVVo", Class.impl())

function ctor(self)
end

-- 解析消息
function parseData(self, id, cusData)
    self.mId = id
    -- 解锁等级
    self.mLevel = cusData.level
    -- 解锁关卡
    self.mStage = cusData.open_stage
    -- 名字
    self.mName = cusData.name
    -- 背景故事
    self.mStory = cusData.story
    -- 效果说明
    self.mEffect = cusData.effect
    -- 宠物头像
    self.mPetHead = cusData.pet_head
    -- 宠物画像
    self.mPetPic = cusData.pet_pic
    -- 模型id
    self.petModel = cusData.pet_model
end

function getLevel(self)
    return self.mLevel
end

function getName(self)
    return _TT(self.mName)
end

function getStory(self)
    return _TT(self.mStory)
end

function getEffect(self, id)
    local skillRo = fight.SkillManager:getSkillRo(self.mEffect[id])
    return skillRo:getDesc()
end

return _M