module('battleMap.FragmentMapStageVo', Class.impl())
--[[ 
    主线关卡城池数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self, cusId, cusData)
    self.stageId = cusId
    self.m_name = cusData.name
    -- 所属章节
    self.chapter = cusData.chapter
    -- 关卡顺序
    self.sort = cusData.sort
    -- 前置关卡id列表
    self.preIdList = cusData.pre_id
    -- 下一关id
    self.nextId = cusData.next_id
    -- 关卡类型
    self.type = cusData.type
    -- 敌物tid列表
    self.enemyList = cusData.mon
    -- 怪物阵型ID
    self.formationId = cusData.formation_id
    -- 支援技能列表
    self.supportSkill = cusData.support_skill
    -- 支援我方的怪物id列表(对应怪物配置表的索引id)
    self.supportMonterList = cusData.support_mon
    -- 战斗场景
    self.battleScene = cusData.battle_scene
    -- 关卡图片
    self.pic = cusData.pic
    -- 剧情
    self.story = cusData.story
    -- 通关英雄经验
    self.heroExp = cusData.hero_exp
    -- 通关指挥官经验
    self.roleExp = cusData.role_exp
    -- 消耗体力
    self.costStamina = cusData.cost
    -- 推荐战力
    self.recommendForce = cusData.recommend_force
    -- 首通奖励包
    self.firstAwardId = cusData.first_award
    -- 通关展示奖励包id
    self.awardPackId = cusData.show_drop

    self.des = cusData.describe
    -- 关卡序号名：x-x
    self.indexName = cusData.number
    -- 是否为隐藏剧情，即风格类型：容易/困难
    -- self.styleType = cusData.style_type

    self.m_musicId = cusData.music_id
    self.m_sceneId = cusData.scene_id
    self.pointLineData = cusData.point_line
    --阶段性奖励
    self.stageAwardList = cusData.stage_award
    -- 额外上阵的战员列表
    self.extraHeros = cusData.extra_hero

    --bossId
    self.bossId = cusData.boss_id
    --boss特性
    self.bossCha = cusData.boss_cha
    -- 推荐等级
    self.suggestLevel = cusData.suggest_level
    -- 推荐属性
    self.suggestEle = cusData.suggest_ele

    --是否锁着阵型
    self.mIsLock = cusData.lock_formation

    --战场环境id
    self.posEffectId = cusData.pos_effect_id
end

function getBossId(self)
    return self.bossId
end

function getBossCha(self)
    return self.bossCha
end


function getName(self)
    return _TT(self.m_name)
end

--是否直接锁定（无关等级）
function isLock(self)
    return self.mIsLock ~= 0
end

--获取当前副本对应的阵型ID
function getFormationId(self)
    return self.mIsLock
end

-- 获取是否已经解锁，即判断所有前置关卡是否都已通关
function isActive(self)
    if battleMap.MainMapManager:isStagePass(self.stageId) or battleMap.MainMapManager:isStageCanFight(self.stageId) then
        return true, -1
    else
        for i = 1, #self.preIdList do
            local preId = self.preIdList[i]
            local isPass = battleMap.MainMapManager:isStagePass(preId)
            if (not isPass) then
                return false, preId
            end
        end
        return true, -1
    end
end

function getMusicId(self)
    return self.m_musicId
end

function getSceneId(self)
    return self.m_sceneId
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]