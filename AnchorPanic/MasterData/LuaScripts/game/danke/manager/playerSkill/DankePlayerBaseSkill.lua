-- @FileName:   DankePlayerBaseSkill.lua
-- @Description:   玩家技能基类类
-- @Author: ZDH
-- @Date:   2023-08-10 15:45:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.playerSkill.DankePlayerBaseSkill', Class.impl())

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function recover(self)
    LuaPoolMgr:poolRecover(self)
end

function create(self, skillVo)
    local item = self:poolGet()

    item.m_skillVo = skillVo

    item:resetData()

    return item
end

function resetData(self)
    self.m_playerThing = danke.DanKeSceneController:getPlayerThing()

    self:refreshParam()
end

--升级
function addLevel(self)
    if self.m_skillVo then
        self.m_skillVo:addLevel()
        self:refreshParam()
        self:onExecute()
    end
end

function refreshParam(self)
    self.m_skillLevel = self.m_skillVo:getSelfLevelConfig()
    self.m_skillParam = self.m_skillVo:getSelfLevelParam()
end

function getDataVo(self)
    return self.m_skillVo
end

function onRecover(self)
    self.m_playerThing = nil

    self.m_skillVo = nil

    self.m_skillLevel = nil
    self.m_skillParam = nil
end

function onExecute(self)

end

return _M
