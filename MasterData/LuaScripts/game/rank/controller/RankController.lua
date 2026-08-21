--[[ 
-----------------------------------------------------
@filename       : RankController
@Description    : 排行榜控制器
@date           : 2021-08-16 14:36:08
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.rank.controller.RankController', Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_RANK_MAIN_PANEL, self.onOpenPanel, self)
    GameDispatcher:addEventListener(EventName.REQ_RANK_DATA, self.onReqClsRankInfo, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_RANK_PANEL = self.onRecRankInfoMsg,
    }
end

--- *c2s* 跨服排行榜 19210
function onReqClsRankInfo(self, args)
    SOCKET_SEND(Protocol.CS_RANK_PANEL, { rank_id = args.type })
end

--- *s2c* 跨服排行榜返回 19211
function onRecRankInfoMsg(self, msg)
    self.mMgr:onRecRankInfoMsg(msg)
end


function onOpenPanel(self, args)
    if self.mRankPanel == nil then
        self.mRankPanel = UI.new(rank.RankMainPanel)
        self.mRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPanelHandler, self)
    end
    self.mRankPanel:open(args)
end

-- ui销毁
function onDestroyPanelHandler(self)
    self.mRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPanelHandler, self)
    self.mRankPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
