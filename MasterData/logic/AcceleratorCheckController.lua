-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/acceleratorcheck/controller/AcceleratorCheckController.lua

module("logic.extensions.acceleratorcheck.controller.AcceleratorCheckController", package.seeall)

local AcceleratorCheckController = class("AcceleratorCheckController", BaseController)

require("tolua.reflection")

local Time = UnityEngine.Time

AcceleratorCheckController._isEnableCheck = true
AcceleratorCheckController._threshold = 2

function AcceleratorCheckController:ctor()
	self:onReset()
end

function AcceleratorCheckController:onInit()
	self:onReset()
	ViewMgr.instance:setPermanent(ViewName.AcceleratorWarning, true)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
end

function AcceleratorCheckController:onReset()
	self._isMarked = false
	self._markedTime = 0
	self._isUsingAccelerator = false
	self._showWarningTips = false
	self._warning = 0
	self._isInGame = false
	self._isReady = false
	self._serverTime = 0
	self._clientTimeOnSync = 0
	self._lastRealtimeSinceStartup = 0

	if self._isUsingAcceleratorUIShow then
		self._isUsingAcceleratorUIShow = false

		ViewMgr.instance:close(ViewName.AcceleratorWarning)
	end
end

function AcceleratorCheckController:mark()
	if self._isInGame and not self._isMarked and self._isEnableCheck then
		self._isMarked = true
		self._markedTime = Time.realtimeSinceStartup
	end
end

function AcceleratorCheckController:syncTime(serverTimeStamp)
	if self._isInGame and self._isEnableCheck then
		if self._isReady then
			self:checkAccelerator(serverTimeStamp)
		end

		self._lasySyncTime = serverTimeStamp
		self._clientTimeOnSync = Time.realtimeSinceStartup
		self._isReady = true
	end
end

local Type = System.Type
local typeTime = Type.GetType("UnityEngine.Time,UnityEngine.CoreModule")
local scaleP = tolua.getproperty(typeTime, "timeScale", 511)

function AcceleratorCheckController:update()
	if SceneMgr.instance.isGogingToEnterBattleScene or not self._isReady or not self._isInGame or not self._isEnableCheck then
		return
	end

	local ts1 = TimeHelper.GetTimeScale()
	local ts2 = scaleP:Get(nil, nil)

	if type(ts1) == "number" and type(ts2) == "number" and math.abs(ts1 - ts2) > 0.01 then
		self._isUsingAccelerator = true
		self._showWarningTips = true
	end

	if self._isUsingAccelerator then
		if not self._isUsingAcceleratorUIShow and self._showWarningTips then
			self._showWarningTips = false
			self._warning = self._warning + 1

			if self._warning <= 5 then
				FloatWordMgr.instance:show("您本地时间与服务器时间存在异常")
			else
				self:_onUsingAccelerator()
			end
		end
	elseif self._isUsingAcceleratorUIShow then
		self._isUsingAcceleratorUIShow = false

		ViewMgr.instance:close(ViewName.AcceleratorWarning)
	end
end

function AcceleratorCheckController:now()
	if self._isReady then
		local elapsed = Time.realtimeSinceStartup - self._clientTimeOnSync

		return self._lasySyncTime + elapsed
	end

	return ServerTime.now()
end

function AcceleratorCheckController:checkAccelerator(serverTimeStamp)
	if self._isMarked then
		local serverTime = self:now()
		local markTime = Time.realtimeSinceStartup - self._markedTime

		serverTime = math.floor(math.max(0, serverTime - markTime - self._threshold))
		serverTimeStamp = math.ceil(serverTimeStamp)

		if serverTimeStamp < serverTime then
			self._isUsingAccelerator = true
			self._showWarningTips = true
		else
			self._isUsingAccelerator = false
			self._warning = 0
			self._showWarningTips = false
		end

		self._isMarked = false
	end
end

function AcceleratorCheckController:_onUsingAccelerator()
	TipsFacade.disableOpenPopupWindow = true

	NetConnMgr.instance:disbale()

	self._isUsingAcceleratorUIShow = true

	local windCfg = {}

	windCfg.numBtn = 1
	windCfg.title = lang("tip")
	windCfg.text = "系统检测到您的时间设置异常，可能使用了第三方非法软件，请重启游戏"
	windCfg.showX = false
	windCfg.showTog = false
	windCfg.params = {
		{
			function()
				UnityEngine.Application.Quit()
			end,
			"确定"
		}
	}

	ViewMgr.instance:open(ViewName.AcceleratorWarning, windCfg)
end

function AcceleratorCheckController:_onStartEnterGame()
	self._isInGame = true
end

AcceleratorCheckController.instance = AcceleratorCheckController.New()

return AcceleratorCheckController
