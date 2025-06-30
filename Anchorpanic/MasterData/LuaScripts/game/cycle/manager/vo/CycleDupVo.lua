module("cycle.CycleDupVo", Class.impl())

function parseDupVo(self, id, data)
    self.id = id

    -- 进入副本消耗道具
    self.needTid = data.need_tid
    -- 进入副本消耗道具数量
    self.needNum = data.need_num
    -- 敌人配置
    self.enemyList = data.mon

    -- 怪物阵型ID
    self.formationId = data.formation_id

    self.m_sceneId = data.scene_id

    self.name = data.name

    self.des = data.des

    -- 战场环境id
    self.posEffectId = data.pos_effect_id
    self.suggestLevel = data.suggest_level
    self.suggestEle = data.suggest_ele
    self.unusualDes = data.unusual_des

    -- 是否锁着阵型
    self.mIsLock = data.lock_formation
    self.mExtraHero = data.extra_hero
end

-- 是否直接锁定（无关等级）
function isLock(self)
    return self.mIsLock ~= 0
end

-- 获取当前副本对应的阵型ID
function getFormationId(self)
    return self.mIsLock
end

function getSceneId(self)
    return self.m_sceneId
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
