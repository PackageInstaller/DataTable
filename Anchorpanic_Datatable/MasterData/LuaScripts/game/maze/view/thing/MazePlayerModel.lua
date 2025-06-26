--[[
-----------------------------------------------------
@filename       : MazePlayerModel
@Description    : 迷宫玩家模型对象
@date           : 2022-2-11
@Author         : Zzz
@copyright      : (LY) 2018 雷焰网络
-----------------------------------------------------
]]
module("maze.MazePlayerModel", Class.impl(model.modelLive))

--构造函数
function ctor(self)
    super.ctor(self)
    self:initData()
end

function onRecover(self)
    super.onRecover(self)
end

function initData(self)
    self.m_tid = nil
    self.m_modelId = nil
    self.m_curAniHash = nil
    self.m_uiPrefabPath = nil
    self.m_uiShowWeaponSn = nil
end

-- 注册动作回调事件，未监听的动作回调需要添加注册监听
function _setupAniCallSys(self)
    super._setupAniCallSys(self)
end

function setTid(self, heroTid, finishCall)
    self.m_tid = heroTid
    local heroCuteConfigVo = hero.HeroCuteManager:getHeroCuteConfigVo(heroTid)
    local prefabPath = heroCuteConfigVo:getModelPrefab()
    if self.m_uiPrefabPath ~= prefabPath then
        self:removeWeapon()
        self:setPrefab(prefabPath, false, finishCall)
        self.m_uiPrefabPath = prefabPath
        self.m_uiShowWeaponSn = -1
    else
        if finishCall then
            finishCall()
        end
    end
end

function setModelID(self, modelID, finishCall)
    self.m_modelId = modelID
    local prefabPath = UrlManager:getQRolePath(modelID)
    if self.m_uiPrefabPath ~= prefabPath then
        self:removeWeapon()
        self:setPrefab(prefabPath, false, finishCall)
        self.m_uiPrefabPath = prefabPath
        self.m_uiShowWeaponSn = -1
    else
        if finishCall then
            finishCall()
        end
    end
end

function setPrefab(self, prefabPath, beAlwayEft, finishCall)
    local loadFinish = function()
        if(finishCall)then
            finishCall()
        end
    end
    self:setupPrefab(prefabPath, beAlwayEft, loadFinish)
end

function getActionHashByTriggerHash(self, triggerHash)
    if(triggerHash == DormitoryCost.CONDITION_TO_STAND)then
        return DormitoryCost.ACT_SHOW_STAND
    elseif(triggerHash == DormitoryCost.CONDITION_TO_WALK)then
        return DormitoryCost.ACT_SHOW_WALK
    end
    return super.getActionHashByTriggerHash(self, triggerHash)
end

function playAction(self, aniHash, startCall, endCall)
    if (self.m_curAniHash ~= aniHash) then
        super.playAction(self, aniHash, startCall, endCall)
    else
        if(startCall)then
            startCall()
        end
        if(endCall)then
            endCall()
        end
    end
end

function playFade(self, aniHash, startCall, endCall)
    if (self.m_curAniHash ~= aniHash) then
        super.playFade(self, aniHash, startCall, endCall)
    else
        if(startCall)then
            startCall()
        end
        if(endCall)then
            endCall()
        end
    end
end

function addUpdateFramSn(self)
    self:removeUpdateFrameSn()
    self.mUpdateFrameSn = LoopManager:addFrame(1, 0, self, self.onUpdateFrameHandler)
end

function removeUpdateFrameSn(self)
    if (self.mUpdateFrameSn) then
        LoopManager:removeFrameByIndex(self.mUpdateFrameSn)
        self.mUpdateFrameSn = nil
    end
end

function onUpdateFrameHandler(self)
end

function destroy(self)
    super.destroy(self)
    self:removeUpdateFrameSn()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
