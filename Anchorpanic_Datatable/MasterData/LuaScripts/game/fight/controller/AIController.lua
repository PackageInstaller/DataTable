module("fight.AIController", Class.impl(Controller))
--构造函数
function ctor(self)
	super.ctor(self);
end

--析构函数

function dtor(self)

end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
	fight.SceneManager:addEventListener(fight.SceneManager.EVENT_BUILD_COMPLETE,self.obc,self);
	-- GameDispatcher:addEventListener(EventName.FIGHT_START,self.onBuildCompleteHandler,self);
	fight.SceneManager:addEventListener(fight.SceneManager.EVENT_REMOVE_THING,self.onDeadHandler,self);
end

--注册server发来的数据
function registerMsgHandler(self)
	
end

--测试用，后面直接调onBuildCompleteHandler就好了
function obc( self )
	RateLooper:setTimeout(3,self,self.onBuildCompleteHandler);
end

function onBuildCompleteHandler(self)
	-- local _dic = fight.SceneManager:getAllThing()
	-- for _,vo in pairs(_dic) do
	-- 	fight.AIUtil.createFightAI(vo);
	-- end
end

function onDeadHandler(self,cusId)
	fight.AIUtil.recoverFightAI(cusId);
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
