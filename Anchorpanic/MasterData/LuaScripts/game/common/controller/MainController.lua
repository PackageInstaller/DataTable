module("MainController", Class.impl())
--构造函数
function ctor(self)
	self:init()
end

--析构函数
function dtor(self)
end

function init(self)
    GameView = LuaUtil:reRequire("game/common/view/GameView").new()
    if GameManager.RUN_TEST == true then
        TestCtrl = require("test/TestCtrl").new()
    else
        LuaUtil:reRequire("game/common/controller/StartController").new()
        self:__removeEvents()
        self:__addEvents()
        self:__initPubMat()
        gs.socket.SetSocketDebug(GameManager.SOCKET_DEBUG)
	end
    self:__removeGlobalFrameSn()
    self:__addGlobalFrameSn()
    sdk.SdkManager:headphoneState(gs.SdkManager:GetHeadphoneState())
end

function __addEvents(self)
    GameManager:addEventListener(GameManager.LOAD_PRE_RES_COMPLETE, self.onLoadPreResCompleteHandler, self)
    GameManager:addEventListener(GameManager.GET_PLAYER_DATA, self.onGetPlayerDataCompHandler, self)
    GameDispatcher:addEventListener(EventName.READY_EXIT_GAME, self.onReadyExitHandler, self)
end

function __removeEvents(self)
    GameManager:removeEventListener(GameManager.LOAD_PRE_RES_COMPLETE, self.onLoadPreResCompleteHandler, self)
    GameManager:removeEventListener(GameManager.GET_PLAYER_DATA, self.onGetPlayerDataCompHandler, self)
    GameDispatcher:removeEventListener(EventName.READY_EXIT_GAME, self.onReadyExitHandler, self)
end

function _onGlobalUpdate(self, deltaTime)
    LuaPoolMgr:tick(deltaTime)
end

function __initPubMat()
    gs.MatUtil.SetUIGrayMat(AssetLoader.GetAsset(UrlManager:getUIMaterial("ImageGray.mat")))
end

-- 预加载资源完成
function onLoadPreResCompleteHandler(self)
    self:__checkGameStart()
end

-- 获取玩家数据完成
function onGetPlayerDataCompHandler(self)
    self:__checkGameStart()
end

-- 准备退出游戏
function onReadyExitHandler(self)
    self:__removeGlobalFrameSn()
	self:__removeEvents()
end

-- 启动游戏
function __checkGameStart(self)
    if GameManager:getIsLoadPreResComplete() and GameManager:getIsGetPlayerData() then
        web.WebController:reqReportStep(web.REPORT_STEP.GAME_START)
        GameDispatcher:dispatchEvent(EventName.GAME_START)
    end
end

function __addGlobalFrameSn(self)
    self.m_globalFrameSn = LoopManager:addFrame(1, -1, self, self._onGlobalUpdate)  
end

function __removeGlobalFrameSn(self)
	if(self.m_globalFrameSn)then
		LoopManager:removeFrameByIndex(self.m_globalFrameSn)
		self.m_globalFrameSn = nil
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
