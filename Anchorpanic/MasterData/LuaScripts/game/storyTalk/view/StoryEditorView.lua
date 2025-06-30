module("storyTalk.StoryEditorView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("storyTalk/StoryEditorView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnStart = self:getChildGO("mBtnStart")

    self.mBtnChange = self:getChildGO("mBtnChange")

    self.mSceneInputField = self:getChildGO("mSceneInputField"):GetComponent(ty.InputField)
    self.mStoryInputField = self:getChildGO("mStoryInputField"):GetComponent(ty.InputField)
    self.mTalkInputField = self:getChildGO("mTalkInputField"):GetComponent(ty.InputField)

    self.mStoryEditorListenerManager = self:getChildGO("mStoryEditorListenerManager"):GetComponent(
        ty.StoryEditorListenerManager)

    self.mStoryEditorListenerManager:SetLuaCallAction(function(stroyId, talkId)
        self:onStartClick(stroyId, talkId)
    end)
end

-- 激活
function active(self, args)
    super.active(self, args)
    storyTalk.StoryTalkManager:setIsEditor(true)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

function close(self)
    super.close(self)
    storyTalk.StoryTalkManager:setIsEditor(false)
    GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, {
        isCleanGameRes = false,
        isCleanServerInfo = false,
        isNeedLoginSdk = true,
        isNeedRunUpdate = false
    })
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
    self:addUIEvent(self.mBtnStart, self.onStartClick)
    self:addUIEvent(self.mBtnChange, self.onChangeClick)
end

function onStartClick(self, storyID, talkID)
    if storyID == nil or talkID == nil then
        storyID = tonumber(self.mStoryInputField.text)
        talkID = tonumber(self.mTalkInputField.text)
    end

    local ro = storyTalk.StoryTalkManager:getStoryRoByNew(storyID)
    if table.empty(ro:getTalkGroup()) then
        gs.Message.Show2("剧情没有内容")
        return
    end
    if table.empty(ro:getTalkGroup()[talkID]) then
        gs.Message.Show2("剧情没有对应 talkID")
        return
    end
    storyTalk.StoryTalkManager:setCurStoryID(storyID)
    GameDispatcher:dispatchEvent(EventName.OPEN_STORY_TALK_PANEL, talkID)
end

function onChangeClick(self)
    local sceneName = self.mSceneInputField.text
    local scenePath = "arts/scene/" .. sceneName .. ".unity"

    local function _sceneLoad()
        local tmpObj = gs.GameObject.Find("[TEMP_GO]")
        if tmpObj then
            gs.GameObject.Destroy(tmpObj)
        end
        tmpObj = gs.GameObject.Find("[SCamera]")
        if tmpObj then
            gs.CameraMgr:SetSceneCamera(tmpObj:GetComponent(ty.Camera))
        else
            gs.CameraMgr:SetSceneCamera(nil)
        end
    end
    gs.ResMgr:LoadSceneAsync(sceneName, scenePath, _sceneLoad)
end

return _M
