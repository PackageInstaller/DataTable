-- @FileName:   DanKePlayerSkillVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.manager.vo.DanKePlayerSkillVo', Class.impl(danke.DanKePlayerSkillConfigVo))

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    LuaPoolMgr:poolRecover(self)
end

function setData(self, configVo)
    self:parseCogfigData(configVo.tid, configVo)
    self.level = 1
    self.max_level = table.nums(self.skill_level)
end

function getLevel(self)
    return self.level
end

function addLevel(self)
    if not self:isMaxLevel() then
        self.level = self.level + 1
    end
end

function isMaxLevel(self)
    return self.level >= self.max_level
end

function getSelfLevelConfig(self)
    return self:getLevelConfig(self.level)
end

function getSelfLevelParam(self)
    local levelConfig = self:getSelfLevelConfig()
    if levelConfig then
        return levelConfig.param
    end
end

function getRes(self)
    local levelConfig = self:getSelfLevelConfig()
    if levelConfig then
        return "arts/fx/3d/sceneModule/danke/" .. levelConfig.res
    end
end

function getNeedSkill(self)
    local levelConfig = self:getSelfLevelConfig()
    if levelConfig then
        return levelConfig.need_skill
    end
end

return _M
