--[[****************************************************************************
Brief  :STravelFactory 用于创建技能特效轨迹类
Author :James Ou
Date   :2020-03-12
****************************************************************************
]]
module("STravelFactory", Class.impl())
-------------------------------
function ctor(self)
    self.m_travelSwitch = {}
    self.m_travelSwitch[1] = STravelBullet
    self.m_travelSwitch[2] = STravelArrow
    self.m_travelSwitch[3] = STravelSpotBlast
    self.m_travelSwitch[4] = STravelFormation
    self.m_travelSwitch[5] = STravelFull
    self.m_travelSwitch[6] = STravelLaster
    self.m_travelSwitch[7] = STravelChainLightning
    self.m_travelSwitch[8] = STravelMissile

    -- self.m_perfSwitch = {}
    -- self.m_perfSwitch[1] = SPerfBase -- SPerfBullet
    -- self.m_perfSwitch[2] = SPerfBase --SPerfArrow
    -- self.m_perfSwitch[3] = SPerfSpotBlast
    -- self.m_perfSwitch[4] = SPerfFormation
    -- self.m_perfSwitch[5] = SPerfFull
end

function createSkilPerformRo(self, refID)
    local ref = RefMgr:getRefData("skill_perform_data", refID)
    if ref then
        local ro = SkillPerformDataRo.new()
        ro:parseData(refID, ref)
        return ro
    end
end
-- 创建逻辑轨迹
function travel(self, skillID, casterID, targetID, targetVec3)
    local perfRo = self:createSkilPerformRo(skillID)
    return self:travel01(skillID, perfRo, casterID, targetID, targetVec3)
end

function travel02(self, skillID, perfID, casterID, targetID, targetVec3, side)
    if fight.FightManager.m_gmOpenEft == true then
        return
    end
    local cls = self.m_travelSwitch[perfID]
    if not cls then
        local function _tryRequire()
            cls = require("game/fight/skill/performLogic/STravel_" .. perfID)
            if cls then
                self.m_travelSwitch[perfID] = cls
            end
        end
        pcall(_tryRequire)
    end
    if cls then
        local travel = cls.new()
        travel:setSkillID(skillID)
        travel:setCasterID(casterID)
        travel:setTargetID(targetID)
        travel:setTargetVec3(targetVec3)
        travel:setSide(side)
        return travel
    end
    Debug:log_warn("STravelFactory", "skillID [%d] perfID[%d] no travel to create !!!", skillID, perfID)
end

function travel01(self, skillID, perfRo, casterID, targetID, targetVec3)
    if not perfRo then
        Debug:log_warn("STravelFactory", "skillID [%d] no skill data !!!", skillID)
        return
    end
    local perfID = perfRo:getPerfId()
    if not perfID then
        Debug:log_warn("STravelFactory", "skillID [%d] no skill data !!!", skillID)
        return
    end
    local travel = self:travel02(perfID, casterID, targetID, targetVec3)
    if travel then
        travel:setPerfData(perfRo:getRootEftName(), perfRo:getExplodeEftName(), perfRo:getLifeTime())
    end
    return travel
end
-- 创建表现轨迹
function perf(self, perfID)
    local cls = self.m_perfSwitch[perfID]
    if not cls then
        local function _tryRequire()
            cls = require("game/fight/skill/perform/SPerf_" .. perfID)
            if cls then
                self.m_perfSwitch[perfID] = cls
            end
        end
        pcall(_tryRequire)
    end
    if cls then
        return cls.new()
    end
    Debug:log_warn("STravelFactory", "perfID [%d] no perf to create !!!", perfID)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]