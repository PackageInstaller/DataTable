-- @FileName:   DanKeBaseThing.lua
-- @Description:  沙盒实体基类
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.danke.thing.DanKeBaseThing', Class.impl())

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function recover(self)
    LuaPoolMgr:poolRecover(self)
end

function create(self, data, loadFinish)
    local item = self:poolGet()

    item.m_snId = SnMgr:getSn()
    item.m_data = data
    item.m_loadFinishCall = loadFinish

    item:resetData()
    item:setupModel()

    return item
end

function resetData(self)
    self.m_attr =
    {
        hp = 0,
    }
end

--重构函数
function setupModel(self)
    if self.m_spriteModel then
        return
    end

    local prefabPath = self:getPrefabPath()
    if string.NullOrEmpty(prefabPath) then
        return
    end

    local spriteModel = self:getSpriteModel()
    spriteModel:setupPrefab(prefabPath, self.m_data.parent, function (model)
        self.m_spriteModel = model
        local scale = self:getScale()
        self.m_spriteModel.m_trans.localScale = gs.Vector3(scale, scale, 1)

        self:onModelLoadFinish()

        if self.m_loadFinishCall then
            self.m_loadFinishCall()
        end
    end)

    self:addEventListener()
end

function addEventListener(self)
    
end

function removeEventListener(self)

end

function onModelLoadFinish(self)
    self:setSortIndex()
    self:setHitAnim(false)

    --添加刚体/角色控制器
    self:addCharacterController()
    self:initCharacterControllerSize()
end

function addCharacterController(self)
    self.m_CharacterController = self.m_spriteModel.m_go:GetComponent(ty.CharacterController)
    if not self.m_CharacterController or gs.GoUtil.IsCompNull(self.m_CharacterController) then
        self.m_CharacterController = self.m_spriteModel.m_go:AddComponent(ty.CharacterController)
    end
end

function initCharacterControllerSize(self)

end

--前进
function setTranForward(self, speed, forward)
    local trans = self:getTrans()

    forward = forward or trans.forward
    gs.UnityEngineUtil.CharacterControllerMove(self.m_CharacterController, forward * speed)

    local localPosition = trans.localPosition
    trans.localPosition = gs.Vector3(localPosition.x, localPosition.y, 0)
end

function setSortIndex(self, sortIndex)
    if sortIndex then
        self.m_sortIndex = sortIndex
    end

    if self.m_spriteModel then
        self.m_spriteModel:setSortIndex(self.m_sortIndex)
    end
end

function playAction(self, actName)
    if self.m_spriteModel then
        self.m_spriteModel:playAction(actName)
    end
end

function getData(self)
    return self.m_data
end

function getAniLenght(self, actName)
    if self.m_spriteModel then
        return self.m_spriteModel:getAniLenght(actName)
    end
end

--受击
function onHit(self, damage)
    self.m_attr.hp = self.m_attr.hp - damage

    if damage > 0 then
        self:setHitAnim(true)
        self:clearHitTimeOutSn()
        self.m_hitTimeOutSn = LoopManager:setTimeout(0.2, nil, function ()
            self:setHitAnim(false)
        end)
    end

    if self.m_attr.hp <= 0 then
        self:onDie()
    end
end

function setHitAnim(self, val)
    if self.m_spriteModel then
        self.m_spriteModel:setHitAnim(val)
    end
end

--死亡
function onDie(self)

end

function setParent(self, parent)
    self:getTrans():SetParent(parent, true)
end

function setAngle(self, angle)
    gs.TransQuick:SetRotation(self:getTrans(), 0, angle, 0)
end

function getAngle(self)
    return self:getTrans().localEulerAngles.y
end

function getTrans(self)
    if self.m_spriteModel then
        return self.m_spriteModel:getTrans()
    end
end

function getSpriteModel(self)
    return danke.DanKeBaseSpriteModel
end

function getPrefabPath(self)
    return ""
end

function getPosition(self)
    if self.m_spriteModel then
        return self.m_spriteModel.m_trans.position
    end
end

function getAttr(self)
    return self.m_attr
end

function setPosition(self, lpos)
    if not lpos then return end

    if self:getTrans() and lpos then
        gs.TransQuick:LPos(self:getTrans(), lpos.x, lpos.y, lpos.z)
    end
end

function getScale(self)
    return 1
end

function clearHitTimeOutSn(self)
    if self.m_hitTimeOutSn then
        LoopManager:clearTimeout(self.m_hitTimeOutSn)
        self.m_hitTimeOutSn = nil
    end
end

function clearData(self)
    self.m_loadFinishCall = nil

    if self.m_spriteModel then
        self.m_spriteModel:recover()
        self.m_spriteModel = nil
    end

    self:clearHitTimeOutSn()
end

function onRecover(self)
    self:removeEventListener()
    self:clearData()
end

return _M
