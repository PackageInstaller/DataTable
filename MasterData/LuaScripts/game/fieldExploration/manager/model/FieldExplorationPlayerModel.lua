-- @FileName:   FieldExplorationPlayerModel.lua
-- @Description:   玩家模型
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.model.FieldExplorationPlayerModel', Class.impl(model.modelLive))

function loadFinish(self, go, finishCall, sorceId)
    super.loadFinish(self, go, nil, sorceId)

    if self.m_ani then
        self:setPreLoadAnisByHashList(FieldExplorationConst.HERO_ACT_LIST, finishCall)
    else
        if finishCall then
            finishCall(false, self)
        end
    end
end

function playAction(self, aniHash, startCall, endCall, isForceEndCall)
    if not self.m_ani then return end

    if not self.m_ani:IsPlayingShortNameHash(aniHash) then
        super.playAction(self, aniHash, startCall, endCall, isForceEndCall)
    end
end

function AddFrameCallEvent(self, AcitonName, callback)
    if not self.m_ani then
        logError("annimaCtrl is null")
        return
    end
    self.m_ani:AddFrameCallEvent(AcitonName, playWalkAudio)
end

function setScale(self, scale)
    self.m_trans.localScale = scale
end

function setVisible(self, beVisible)
    if self.m_rootGo.activeSelf ~= beVisible then
        self.m_rootGo:SetActive(beVisible)
    end
end

return _M
