-- @FileName:   DanKeCamera.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-29 17:33:37
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.utils.DanKeCamera', Class.impl())

--可以调参数

function ctor(self)

end

function initCamera(self)
    self.sceneCameraTrans = gs.CameraMgr:GetSceneCameraTrans()

    local playThing = danke.DanKeSceneController:getPlayerThing()
    self.m_followTans = playThing:getTrans()

    self:addEventListener()

    self:onFollow(playThing:getPosition())
end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.DANKE_PLAYERTHING_REFRESHPOS, self.onFollow, self)
end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.DANKE_PLAYERTHING_REFRESHPOS, self.onFollow, self)
end

function onFollow(self, pos)
    if self.m_followPos == pos then
        return
    end

    self.m_followPos = pos
    gs.TransQuick:Pos(self.sceneCameraTrans, self.m_followPos.x, self.m_followPos.y, -100)
end

function destroy(self)
    self:removeEventListener()
end

return _M
