-- @FileName:   SandPlayBaseThing.lua
-- @Description:  沙盒实体基类
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.sandPlay.thing.SandPlayBaseThing', Class.impl())

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function create(self, data, loadFinish)
    local item = self:poolGet()

    item.mData = data
    item.mLoadFinishCall = loadFinish

    item:resetData()
    item:createModel()

    return item
end

function resetData(self)
    self.mEffectList = {}
    -- self.mSoundList = {}
end

function createModel(self)
    self:setupModel()
end

--重构函数
function setupModel(self)
    if self.mModel then
        return
    end

    local prefabPath = self:getPrefabPath()
    if string.NullOrEmpty(prefabPath) then
        return
    end

    self.mModel = self:getModel()
    self.mModel:setupPrefab(prefabPath, false, function ()
        self:onModelLoadFinish()
        if self.mLoadFinishCall then
            self.mLoadFinishCall(self)
            self.mLoadFinishCall = nil
        end
    end)
end

function onModelLoadFinish(self)
    self:setPosition(self.mData.bornPos)
    self:setAngle(self.mData.bornAngle, true)
end

function addEffect(self, effctName, lifeTime, parent)
    if string.NullOrEmpty(effctName) then return end

    parent = parent or self:getTrans()
    local effct = sandPlay.SandPlay_effect:create(self, effctName, parent, lifeTime)
    self.mEffectList[effct.m_snId] = effct
    return effct.m_snId
end

function addEffectToScene(self, effctName, lifeTime)
    if string.NullOrEmpty(effctName) then return end

    local effct = sandPlay.SandPlay_effect:create(self, effctName, nil, lifeTime, self:getPosition())
    self.mEffectList[effct.m_snId] = effct
    return effct.m_snId
end

function removeEffect(self, sn)
    if not sn then return end

    local effct = self.mEffectList[sn]
    if effct then
        effct:recover()
    end
    self.mEffectList[sn] = nil
end

function clearEffect(self)
    for _, effct in pairs(self.mEffectList) do
        effct:recover()
    end
    self.mEffectList = {}
end

-- function addSoundEffct(self, soundName)
--     if string.NullOrEmpty(soundName) then return end

--     local sound = AudioManager:playFightSoundEffect(FieldExplorationConst.getFieldExplorationSoundPath(soundName))
--     if not sound then
--         return
--     end
--     self.mSoundList[sound.m_snId] = sound
--     return sound.m_snId
-- end

-- function removeSoundEffct(self, sn)
--     if not sn then return end

--     local sound = self.mSoundList[sn]
--     if sound then
--         AudioManager:stopAudioSound(sound)
--         self.mSoundList[sn] = nil
--     end
-- end

-- function clearSound(self)
--     for _, effct in pairs(self.mSoundList) do
--         AudioManager:stopAudioSound(sound)
--     end
--     self.mSoundList = {}
-- end

function setParent(self, parent)
    self:getTrans():SetParent(parent, true)
end

-- 转向某个位置
function turnDirByVector(self, pos, rotate_speed)
    if pos == gs.VEC3_ZERO then
        return
    end

    rotate_speed = rotate_speed or 0
    local targetRotation = gs.Quaternion.LookRotation(pos)
    if gs.Quaternion.Angle(self:getTrans().rotation, targetRotation) > 1 then
        if rotate_speed == 0 then
            gs.TransQuick:SetRotation(self:getTrans(), 0, targetRotation.eulerAngles.y, 0)
        else
            gs.TransQuick:MoveTowardsLrotation01(self:getTrans(), gs.Vector3(0, targetRotation.eulerAngles.y, 0), gs.Time.deltaTime * rotate_speed)
        end
    end
end

function setAngle(self, angle)
    gs.TransQuick:SetRotation(self:getTrans(), 0, angle, 0)
end

function setPosition(self, lpos)
    self.mModel:setPosition(lpos)
end

function FindNameInChilds(self, node_name)
    if not self.mModel then
        return
    end

    return gs.GoUtil.FindNameInChilds(self:getTrans(), node_name)
end

-- 获取动作时长
function getAniLenght(self, aniName, callback)
    if self.mModel then
        self.mModel:getAniLenght(aniName, callback)
    end
end

function getAngle(self)
    return self:getTrans().localEulerAngles.y
end

function getTrans(self)
    if not self.mModel then
        return nil
    end
    return self.mModel.m_trans
end

function getModel(self)
    return nil
end

function getPrefabPath(self)
    return ""
end

function getPosition(self)
    if self.mModel then
        return self.mModel.m_trans.position
    else
        return self.mData.bornPos
    end
end

function getData(self)
    return self.mData
end

function recover(self)
    self:clearEffect()
    -- self:clearSound()

    self.mData = nil
    self.mLoadFinishCall = nil

    if self.mModel then
        self.mModel:onRecover()
        self.mModel = nil
    end

    LuaPoolMgr:poolRecover(self)
end

return _M
