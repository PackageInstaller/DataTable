module('storyTalk.StoryPlayMaker', Class.impl())

function ctor(self)
    local launchGO = gs.GameObject.Find("[LAUNCH]");
    if launchGO then
        self.m_storyRoot = launchGO.transform
    end
    gs.StoryPlayMaker:SetLuaTable(self)
end

function _recoverSCamera(self)
    if self.m_scOrgPosition then
        local scCameraTrans = gs.CameraMgr:GetSceneCameraTrans()
        if scCameraTrans then
            scCameraTrans.position = self.m_scOrgPosition
            scCameraTrans.rotation = self.m_scOrgrRotation
        end
        self.m_scOrgPosition = nil
        self.m_scOrgrRotation = nil
    end
end

function playStoryMaker(self, storyResPath)
    if self.m_curStoryGO and not gs.GoUtil.IsGoNull(self.m_curStoryGO) then
        gs.GameObject.Destroy(self.m_curStoryGO)
        self:_recoverSCamera()
    end
    self.m_curStoryGO = gs.ResMgr:LoadGO(storyResPath)
    if self.m_curStoryGO then
        local pFsm = self.m_curStoryGO:GetComponent(ty.PlayMakerFSM)
        if pFsm then
            local cameraFsmGo = pFsm.FsmVariables:GetFsmGameObject("camera")
            local scCameraTrans = gs.CameraMgr:GetSceneCameraTrans()
            if cameraFsmGo and scCameraTrans then
                self.m_scOrgPosition = scCameraTrans.position
                self.m_scOrgrRotation = scCameraTrans.rotation
                cameraFsmGo.Value = scCameraTrans.gameObject
            end
        end
        
        gs.TransQuick:SetParentOrg01(self.m_curStoryGO, self.m_storyRoot)
        storyTalk.StoryTalkManager:setVisibleOtherUI(false)
        -- gs.CameraMgr:SetSceneCameraVisible(false)
        
    else
        storyTalk.StoryTalkManager:setVisibleOtherUI(true)
    end
end

-- 进入对话逻辑
function playmaker2StoryTalk(self, passType)
    -- if passType=="0" then
    -- elseif passType=="1" then
    -- elseif passType=="2" then
    -- elseif passType=="3" then
    -- end
    GameDispatcher:dispatchEvent(EventName.STORY_MOVIE_TO_TALK, passType)
end

-- 结束剧情
function endStory(self, beKeepClosingUI)
    self:_recoverSCamera()
    if self.m_curStoryGO and not gs.GoUtil.IsGoNull(self.m_curStoryGO) then
        gs.GameObject.Destroy(self.m_curStoryGO)
        self.m_curStoryGO = nil
    end

    if beKeepClosingUI==nil then
        storyTalk.StoryTalkManager:setVisibleOtherUI(true)
    end
    -- gs.CameraMgr:SetSceneCameraVisible(true)
end
-- 淡入淡出
function storyFade(self, fadeData)
    GameDispatcher:dispatchEvent(EventName.STORY_FADE, fadeData)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
