--[[
-----------------------------------------------------
@filename       : MazeEventModel
@Description    : 迷宫事件模型对象
@date           : 2022-2-11
@Author         : Zzz
@copyright      : (LY) 2018 雷焰网络
-----------------------------------------------------
]]
module("maze.MazeEventModel", Class.impl(model.modelBase))

--构造函数
function ctor(self)
    super.ctor(self)
    self:initData()
end

function onRecover(self)
    super.onRecover(self)
end

function initData(self)
    self.m_curAniHash = nil
end

-- 注册动作回调事件，未监听的动作回调需要添加注册监听
function _setupAniCallSys(self)
    self.m_ani:AddNeedCallHash(maze.ACT_TRIGGER_BEFORE)
    self.m_ani:AddNeedCallHash(maze.ACT_TRIGGER_AFTER)
    self.m_ani:AddNeedCallHash(maze.ACT_TRIGGER_1)
    self.m_ani:AddNeedCallHash(maze.ACT_TRIGGER_2)
    self.m_ani:AddNeedCallHash(maze.ACT_TRIGGER_3)
    self.m_ani:AddNeedCallHash(maze.ACT_TRIGGER_4)
    super._setupAniCallSys(self)
end

function setPrefab(self, prefabPath, beAlwayEft, finishCall)
    local loadFinish = function()
        if(finishCall)then
            finishCall()
        end
    end
    self:setupPrefab(prefabPath, beAlwayEft, loadFinish)
end

--加载完成(模型加载完成而已)
function loadFinish(self, go, finishCall, sorceId)
    self.m_loadSn = 0
    if go then
        if not self.m_rootGo or gs.GoUtil.IsGoNull(self.m_rootGo) then
            logError("本对象已被销毁了22 " .. self.m_prefabName .. " id：" .. (sorceId or 0))
            gs.GameObject.Destroy(go)
            return
        end

        self.m_model = go
        self.m_modelTrans = self.m_model.transform

        self.m_modelTrans:SetParent(self.m_trans, false)

        self.m_defLayer = gs.LayerMask.LayerToName(self.m_model.layer)
        if self.m_isVisible == false then
            gs.GoUtil.ChangeLayer(self.m_rootGo, self.m_hideLayer)
        else
            if self.m_displayLayer and self.m_displayLayer ~= self.m_defLayer then
                self:setDisplayLayer(self.m_displayLayer)
            end
        end

        self.m_ani = self.m_model:GetComponent(ty.AnimatCtrl)
    else
        logError("Role Model " .. self.m_prefabName .. "not exist")
    end

    if finishCall then
        finishCall(false, self)
    end
end

function getActionHashByTriggerHash(self, triggerHash)
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
