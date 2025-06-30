--[[ 
-----------------------------------------------------
@filename       : TeachingManager
@Description    : 上阵教学数据管理器
@date           : 2021-08-30 17:53:22
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.teaching.manager.TeachingManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

--初始化
function init(self)
    self.mSelectList = {}
end

-- 初始化怪物基础配置表
function parseConfigData(self)
    self.mConfigDic = {}
    local baseData = RefMgr:getData("tactics_teaching_data")
    for key, data in pairs(baseData) do
        local vo = teaching.TeachingBaseVo.new()
        vo:parseData(key, data)
        self.mConfigDic[vo.dupId] = vo
    end
end

function getBaseData(self, dupId)
    if not self.mConfigDic then
        self:parseConfigData()
    end
    return self.mConfigDic[dupId]
end

function setSelectHeroList(self, monsterId, pos)
    local allFormationHeroList = self:getSelectHeroList()
    for i, vo in ipairs(allFormationHeroList) do
        if vo.heroId == monsterId then
            if not pos or vo.heroPos == pos then
                LuaPoolMgr:poolRecover(vo)
                table.remove(allFormationHeroList, i)
            else
                vo.heroPos = pos
            end
            return

        elseif pos and vo.heroPos == pos then
            vo.heroId = monsterId
            return
        end
    end

    -- 添加英雄
    local addFormationHeroVo = LuaPoolMgr:poolGet(formation.FormationHeroVo)
    addFormationHeroVo.heroId = monsterId
    addFormationHeroVo.heroPos = pos
    addFormationHeroVo.sourceType = formation.HERO_SOURCE_TYPE.TEACHING
    table.insert(allFormationHeroList, addFormationHeroVo)
    local heroVo = hero.HeroManager:getHeroVo(addFormationHeroVo.heroId)
    if heroVo then
        return AudioManager:playHeroCVByFieldName(heroVo.tid, "join_voice")
    end
end

function getHeroIdByFormationPos(self, pos)
    for k,v in pairs(self:getSelectHeroList()) do
        if (v.heroPos == pos) then 
            return v.heroId
        end
    end
    return nil
end

function getPosByHeroId(self, heroId)
    for k,v in pairs(self:getSelectHeroList()) do
        if (v.heroId == heroId) then 
            return v.heroPos
        end
    end
    return nil
end

function getSelectHeroList(self)
    return self.mSelectList
end

function clearSelectHeroList(self)
    self.mSelectList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
