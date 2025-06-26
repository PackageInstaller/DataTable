--[[    
    日常副本基础数据配置
    @author Jacob
]]
module("dup.DupDailyDataVo", Class.impl())

function parseData(self, cusId, cusData)
    self.dupId = cusId
    self.sort = cusData.sort
    self.heroExp = cusData.hero_exp
    self.openDate = cusData.open_date
    self.name = cusData.name --关卡序号
    self.stageName = cusData.stage_name --关卡中文名
    self.explain = cusData.explain --关卡详情
    self.battleScene = cusData.battle_scene
    self.enemyList = cusData.dup_guard
    self.drop = cusData.drop
    self.needNum = cusData.need_num
    self.mainExp = cusData.main_exp
    self.type = cusData.type
    self.nextId = cusData.next_id
    self.enterLv = cusData.enter_lv
    self.needTid = cusData.need_tid
    self.power = cusData.recommend_force
    self.enterDup = cusData.enter_dup
    self.chipDrop = cusData.chip_drop
    self.m_musicId = cusData.music_id
    self.m_sceneId = cusData.scene_id
    self.unlockTxtId = cusData.unlock_text
    self.suggestLevel = cusData.suggest_level
    self.suggestEle = cusData.suggest_ele
    self.formationId = cusData.formation_id
    self.showDrop = AwardPackManager:getAwardListById(cusData.show_drop[1])
    self.showDropEquip = cusData.show_drop
    self.showDropChip = {}
    for i, dropId in ipairs(self.showDropEquip) do
        self.showDropChip[dup.DupEquipMainManager:getDupEquipSuitList()[i]] = dropId
    end
    self.showExtraDrop = AwardPackManager:getAwardListById(cusData.extra_drop[1])
    self.showExtraDropEquip = cusData.extra_drop

    self.posEffectId = cusData.pos_effect_id

end

-- 非中文，仅保持统一格式
function getName(self)
    return _TT(122, self.name)
end

function getStageName(self)
    return _TT(self.stageName)
end
--获取解锁文本
function getUnlockTxt(self)
    if not self.unlockTxtId then
        self.unlockTxtId = 0
    end
    return _TT(self.unlockTxtId)
end

function getExplain(self)
    return _TT(self.explain)
end

function getMusicId(self)
    return self.m_musicId
end

function getSceneId(self)
    return self.m_sceneId
end

function getSuggestLvDes(self)
    local text = (self.suggestLevel[1] > 0) and _TT(3071, self.suggestLevel[1]) or ""
    return text .. _TT(3072, self.suggestLevel[2])
end

function getSuggestEleList(self)
    return self.suggestEle
end

function getCurrentShowDrop(self, suitId)
    return AwardPackManager:getAwardListById(self.showDropEquip[suitId])
end

function getCurSuitIdShowDrop(self, suitId)
    return AwardPackManager:getAwardListById(self.showDropChip[suitId])
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]