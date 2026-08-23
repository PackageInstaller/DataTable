local QualityService = class("QualityService")
local var_0_1 = g.core.const.QualityConst
local NativeCallUtils = require("app.core.platform.NativeCallUtils")

function QualityService:ctor()
	self._nowMode = nil
	self._enterTime = 0
	self._nowModuleTime = 0
	self._highLock = false

	self:setQualityMode(var_0_1.MODE.HIGH)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_ENTER_ROOT, self._onModuleEnter, self)
	g.core.layer.LayerManager:getRoot():addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClick))
end

function QualityService:_onModuleEnter(arg_2_1, arg_2_2, arg_2_3)
	if g.view.entrance.MODULE_NAME[arg_2_2] then
		self._highLock = g.view.entrance.MODULE_NAME[arg_2_2] == "BATTLE"
	end

	self._nowModuleTime = 0
end

function QualityService:_onUpdate(arg_3_1, arg_3_2)
	if self._highLock then
		return
	end

	self._nowModuleTime = self._nowModuleTime + arg_3_2

	if self._nowModuleTime > var_0_1.ENTER_SAVE_TIME then
		self:setQualityMode(var_0_1.MODE.POWERSAVE)
		g.core.layer.LayerManager:getRoot():cancelSchedule(self._handler)

		self._handler = nil
	end
end

function QualityService:_onClick()
	self._nowModuleTime = 0

	if self._nowMode == var_0_1.MODE.POWERSAVE then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SWITCH_HIGH_QUALITY, false)
		self:setQualityMode(var_0_1.MODE.HIGH)
	end
end

function QualityService:setQualityMode(arg_5_1)
	if arg_5_1 == self._nowMode then
		return
	end

	if arg_5_1 == var_0_1.MODE.HIGH then
		self._nowModuleTime = 0
		self._handler = g.core.layer.LayerManager:getRoot():newSchedule(handler(self, self._onUpdate), 1)

		self:changeToHighMode()
	elseif arg_5_1 == var_0_1.MODE.LOW then
		self:changeToLowMode()
	elseif arg_5_1 == var_0_1.MODE.POWERSAVE then
		self:changeToPowerSaveMode()
	end

	self._nowMode = arg_5_1
end

function QualityService:changeToHighMode()
	if self._powerSaveLayer then
		cc.Director:getInstance():setAnimationInterval(0.03333333333333333)
		self._powerSaveLayer:hide()
		g.core.layer.LayerManager:getModuleLayer():setVisible(true)
		g.core.module.ModuleManager:getPopupLayer():setVisible(true)
		g.core.layer.LayerManager:getSysTipLayer():setVisible(true)

		self._powerSaveLayer = nil

		NativeCallUtils.call("setActivityBrightness", {
			{
				mode = 1
			}
		})
	end
end

function QualityService:changeToLowMode()
	return
end

function QualityService:afterCapture(arg_8_1, arg_8_2)
	if arg_8_1 then
		local var_8_0 = cc.Sprite:createWithTexture(arg_8_2)
		local var_8_1 = cc.Director:getInstance():getOpenGLView()

		var_8_0:setScaleX(1 / var_8_1:getScaleX())
		var_8_0:setScaleY(1 / var_8_1:getScaleY())

		local var_8_2 = g.view.entrance.POWER_SAVE.create()

		var_8_2:setBg(var_8_0)
		g.core.layer.LayerManager:getModuleLayer():setVisible(false)
		g.core.module.ModuleManager:getPopupLayer():setVisible(false)
		g.core.layer.LayerManager:getSysTipLayer():setVisible(false)
		g.core.module.ModuleManager:getTopLayer():addChild(var_8_2)

		self._powerSaveLayer = var_8_2
	end
end

function QualityService:changeToPowerSaveMode()
	cc.RenderTexture:captureScreenToTexture(handler(self, self.afterCapture))
	cc.Director:getInstance():setAnimationInterval(0.1)
	NativeCallUtils.call("setActivityBrightness", {
		{
			mode = 0
		}
	})
end

return QualityService
