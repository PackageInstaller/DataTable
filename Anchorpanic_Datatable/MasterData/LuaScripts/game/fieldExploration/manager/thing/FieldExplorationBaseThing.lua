-- @FileName:   FieldExplorationBaseThing.lua
-- @Description:   场景事件基类
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.fieldExploration.thing.FieldExplorationBaseThing', Class.impl())

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
    self.mSoundList = {}
end

function createModel(self)

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
            self.mLoadFinishCall()
        end
    end)
end

function onModelLoadFinish(self)
    self:setPosition(self.mData.createPos)
    self:setEulerAngles({x = 0, y = self.mData.angle, z = 0})
    if self.mData.scale then
        self:setScale(self.mData.scale)
    end
end

function addEffect(self, effctName)
    if string.NullOrEmpty(effctName) then return end

    local effct = fieldExploration.FieldExploration_effect:create(FieldExplorationConst.getFieldExplorationFxPath(effctName), self:getTrans())
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

function addSoundEffct(self, soundName)
    if string.NullOrEmpty(soundName) then return end

    local sound = AudioManager:playFightSoundEffect(FieldExplorationConst.getFieldExplorationSoundPath(soundName))
    if not sound then
        return
    end
    self.mSoundList[sound.m_snId] = sound
    return sound.m_snId
end

function removeSoundEffct(self, sn)
    if not sn then return end

    local sound = self.mSoundList[sn]
    if sound then
        AudioManager:stopAudioSound(sound)
        self.mSoundList[sn] = nil
    end
end

function clearSound(self)
    for _, effct in pairs(self.mSoundList) do
        AudioManager:stopAudioSound(sound)
    end
    self.mSoundList = {}
end

function setParent(self, parent)
    self:getTrans():SetParent(parent, true)
end

--旋转
function setEulerAngles(self, anglesV3)
    if not self.mModel then
        return
    end

    self.mModel:setEulerAngles(anglesV3)
end

--旋转
function setAngle(self, angle, isNow, callback)
    if not self.mModel then
        return
    end

    self.mModel:setAngle(angle, isNow, callback)
end

function getAngle(self)
    if not self.mModel then
        return 0
    end
    return self.mModel:getAngle()
end

function setPosition(self, lpos)
    if not self.mModel then
        return
    end

    self.mModel:setPosition(lpos)
end

function setPositionTween(self, lpos, tweenTime, callback)
    if not self.mModel then
        return
    end

    self.mModel:setPositionTween(lpos, tweenTime, callback)
end

function getCurPos(self)
    if not self.mModel then
        return 0
    end
    return self.mModel:getCurPos()
end

function setScale(self, scale)
    if not self.mModel then
        return
    end

    self.mModel:setScale(scale)
end

function FindNameInChilds(self, node_name)
    if not self.mModel then
        return
    end

    return gs.GoUtil.FindNameInChilds(self.mModel:getTrans(), node_name)
end

function getTrans(self)
    return self.mModel.m_trans
end

function getModel(self)
    return fieldExploration.FieldExplorationThingBaseModel.new()
end

function getPrefabPath(self)
    return ""
end

function getPosition(self)
    if self.mModel then
        return self.mModel.m_trans.position
    end
end

function getData(self)
    return self.mData
end

function setVisible(self, val)
    if self.mModel then
        self.mModel:setVisible(val)
    end
end

function recover(self)
    self:clearEffect()
    self:clearSound()

    self.mData = nil
    self.mLoadFinishCall = nil

    if self.mModel then
        self.mModel:onRecover()
        self.mModel = nil
    end

    LuaPoolMgr:poolRecover(self)
end

return _M
