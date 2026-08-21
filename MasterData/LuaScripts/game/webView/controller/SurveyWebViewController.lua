--[[ 
-----------------------------------------------------
@filename       : SurveyWebViewController
@Description    : 调查问卷外部网页
@date           : 2021-03-31 14:02:22
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.webView.controller.SurveyWebViewController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameManager:addEventListener(GameManager.NET_AUTO_ALERT, self.onNetAutoAlertHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_WEBVIEW, self.onOpenWebView, self)
    GameDispatcher:addEventListener(EventName.OPEN_SURVEY_WEBVIEW, self.onOpenSurveyWebView, self)
    GameDispatcher:addEventListener(EventName.SEND_SURVER_COMPLETE, self.onSendComplete, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_SUBMIT_QUESTIONNAIRE = self.onResSubmitQuestionnaireMsgHandler,
    }
end

function onResSubmitQuestionnaireMsgHandler(self, msg)
    -- if(msg.result == 1)then
    --     if self.mSurveyWebView then
    --         self.mSurveyWebView:removeTimerSendComplete()
    --     end
    -- end
end

--- *c2s* 提交调查文件 24050
function onSendComplete(sefl, cusId)
    SOCKET_SEND(Protocol.CS_SUBMIT_QUESTIONNAIRE, { announce_id = cusId })
end

-- 网络造成自动弹窗时，需要关闭相关sdk的界面（因为sdk界面至于最顶层会影响下层的点击流程）
function onNetAutoAlertHandler(self)
    if self.mWebView then
        self.mWebView:close()
    end
    if self.mSurveyWebView then
        self.mSurveyWebView:close()
    end
end

function onOpenWebView(self, args)
    if self.mWebView == nil then
        self.mWebView = UI.new(webView.WebView)
        self.mWebView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWebViewHandler, self)
    end
    self.mWebView:open(args)
end
-- ui销毁
function onDestroyWebViewHandler(self)
    self.mWebView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyWebViewHandler, self)
    self.mWebView = nil
end

function onOpenSurveyWebView(self, args)
    if self.mSurveyWebView == nil then
        self.mSurveyWebView = UI.new(webView.SurveyWebView)
        self.mSurveyWebView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySurveyWebViewHandler, self)
    end
    self.mSurveyWebView:open(args)
end
-- ui销毁
function onDestroySurveyWebViewHandler(self)
    self.mSurveyWebView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroySurveyWebViewHandler, self)
    self.mSurveyWebView = nil
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
