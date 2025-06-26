module('storyTalk.StoryTalkController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--游戏开始的回调
function gameStartCallBack(self)
end

function reLogin(self)
    super.reLogin(self)
    storyTalk.StoryTalkManager:switchFinishCall(false)
    self:__onClosePanelByReload()
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_STORY_TALK_EDITOR_PANEL, self.__onOpenStoryEditorPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_STORY_TALK_PANEL, self.__onOpenPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_STORY_SAND_TALK_PANEL, self.__onOpenPanelCustSand, self)

    GameDispatcher:addEventListener(EventName.CLOSE_STORY_TALK_PANEL, self.__onClosePanel, self)
    GameDispatcher:addEventListener(EventName.REQ_DUP_STORY_FINISH, self.__onReqDupStoryFinishHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_REGISTER_VIEW, self.onOpenRegisterView, self)
    GameDispatcher:addEventListener(EventName.CLOSE_REGISTER_VIEW, self.onCloseRegisterView, self)
    GameDispatcher:addEventListener(EventName.OPEN_QUALITY_CHOOSE_VIEW, self.onOpenQualityChooseView, self)
    GameDispatcher:addEventListener(EventName.CLOSE_QUALITY_CHOOSE_VIEW, self.onCloseQualityChooseView, self)
    GameDispatcher:addEventListener(EventName.FIGHT_RESULT_PANEL_OVER, self.onFightResultPanelClose, self)
    GameDispatcher:addEventListener(EventName.ONLY_CLOSE_TALK_PANEL, self.onlyCloseTalkPanel, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_PLAYER_STORY_INFO = self.onRecvSC_PLAYER_STORY_INFO,
        --- *s2c* 纯剧情副本 返回 18013
        SC_DUP_ONLY_STORY_PASS = self.onRecvSC_DUP_ONLY_STORY_PASS,
    }
end

function onRecvSC_PLAYER_STORY_INFO(self, msg)
    storyTalk.StoryTalkManager:setPassStoryIds(msg.story_list)
end

-- 通知服务器副本剧情播放完毕
function __onReqDupStoryFinishHandler(self, args)
    --- *c2s* 纯剧情副本 18012
    SOCKET_SEND(Protocol.CS_DUP_ONLY_STORY_PASS, { battle_type = args.battleType, field_id = args.fieldId })
end

-- 纯剧情播完响应
function onRecvSC_DUP_ONLY_STORY_PASS(self, msg)
    if (msg.result == 1) then
        -- msg.battle_type
        -- msg.field_id
        -- 统一奖励显示
        if not table.empty(msg.award) then
            local list = {}
            for _, v in ipairs(msg.award) do
                local propsVo = LuaPoolMgr:poolGet(props.PropsVo)
                propsVo:setPropsAwardMsgData(v)
                table.insert(list, propsVo)
            end
            ShowAwardPanel:showPropsList(list)
        end
    else
        -- gs.Message.Show("剧情播放异常")
    end
end

-- 结算界面关闭
function onFightResultPanelClose(self, args)
    if args.isWin then
        storyTalk.StoryTalkCondition:condition06()
    end
end

function __onOpenStoryEditorPanel(self, args)
    if self.mEditorPanel == nil then
        self.mEditorPanel = storyTalk.StoryEditorView.new()
        self.mEditorPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEditorHandler, self)
    end
    self.mEditorPanel:open()
end

function onDestroyEditorHandler(self)
    self.mEditorPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEditorHandler, self)
    self.mEditorPanel = nil
end

function __onOpenPanel(self, talkId)
    if self.m_talkPanel == nil then
        self.m_talkPanel = UI.new(storyTalk.StoryTalkPanel)
        self.m_talkPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end

    if not storyTalk.StoryTalkManager:getCurStoryRo() then
        return
    end
    -- -- 临时结束
    self.m_talkPanel:open(talkId)
end

function __onOpenPanelCustSand(self, talkId)
    if self.m_talkPanel == nil then
        self.m_talkPanel = UI.new(storyTalk.StoryTalkPanel)
        self.m_talkPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end
    self.m_talkPanel:setSandCus()

    if not storyTalk.StoryTalkManager:getCurStoryRo() then
        return
    end
    -- -- 临时结束
    self.m_talkPanel:open(talkId)
end

-- ui销毁
function __onClosePanel(self)
    --UIFactory:openScreenSaverOld(0.4)
    --storyTalk.StoryPlayMaker:endStory()

    storyTalk.StoryTalkManager:switchFinishCall(true)
    storyTalk.StoryTalkManager:showSceneModel()
    GameView:SceneStoryShowUI()

    storyTalk.StoryTalkCondition:callAlwayCallback()

    if storyTalk.StoryTalkCondition:cunNeedWait() then
        GameDispatcher:dispatchEvent(EventName.STORY_SHOW_MASK)
    else
        self:onlyCloseTalkPanel()
    end

    GameDispatcher:dispatchEvent(EventName.SANDPLAY_OVER_MAPEVENT_TRIGGER, {})
end

function __onClosePanelByReload(self)
    storyTalk.StoryTalkCondition:resetCanNeedWait()
    storyTalk.StoryTalkManager:switchFinishCall(false)
    storyTalk.StoryTalkManager:showSceneModel()
    GameView:SceneStoryShowUI()
    storyTalk.StoryTalkCondition:callAlwayCallback()
    self:onlyCloseTalkPanel()
end

function onlyCloseTalkPanel(self)
    if self.m_talkPanel then
        self.m_talkPanel:close()
    end
end

function onDestroyViewHandler(self)
    self.m_talkPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.m_talkPanel = nil
end

----------------------------指纹验证--------------------------------
---
function onOpenRegisterView(self, args)
    if not self.mRegisterView then
        self.mRegisterView = storyTalk.RegisterView.new()
        self.mRegisterView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRegisterViewHandler, self)
    end
    -- 剧情派发参数
    if (args) then
        self.storyArgs = args.data
    end
    self.mRegisterView:open(args)
end

function onCloseRegisterView(self)
    if self.mRegisterView and self.mRegisterView.isPop then
        -- 剧情派发参数
        if (self.storyArgs) then
            GameDispatcher:dispatchEvent(EventName.STORY_BACK_TO_STORY, self.storyArgs)
            self.storyArgs = nil
        end
        self.mRegisterView:close()
    end
end

function onDestroyRegisterViewHandler(self)
    self.mRegisterView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRegisterViewHandler, self)
    self.mRegisterView = nil
end

----------------------------画质选择--------------------------------

function onOpenQualityChooseView(self, args)
    if not self.mQualityChooseView then
        self.mQualityChooseView = storyTalk.QualityChooseView.new()
        self.mQualityChooseView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyQualityChooseView, self)
    end
    self.mQualityChooseView:open(args)

    -- 剧情派发参数
    if (args) then
        self.storyArgs2 = args.data
    end
end

function onCloseQualityChooseView(self)
    -- 剧情派发参数
    if (self.storyArgs2) then
        GameDispatcher:dispatchEvent(EventName.STORY_BACK_TO_STORY, self.storyArgs2)
        self.storyArgs2 = nil
    end

    if self.mQualityChooseView and self.mQualityChooseView.isPop then
        self.mQualityChooseView:close()
    end
end

function onDestroyQualityChooseView(self)
    self.mQualityChooseView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyQualityChooseView, self)
    self.mQualityChooseView = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
