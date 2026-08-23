local var_0_0 = g.core.const.ConstMgr.SpineConst
local var_0_1 = g.core.common.Path
local DrawSuccuba = class("DrawSuccuba", function()
	return fgui.GComponent:create()
end)

function DrawSuccuba:ctor(arg_2_1)
	if type(arg_2_1) ~= "table" then
		arg_2_1 = {}
	end

	self:_updateRes(arg_2_1)

	self._spineEventEnable = true

	local var_2_0 = cc.size(500, 500)

	self:setSize(var_2_0.width, var_2_0.height)
	self:setPivot(0.5, 1, true)
	self:setOpaque(true)
	self:setName("DrawSuccuba")

	self._nodeRoot = cc.Node:create()

	self._nodeRoot:setPosition(var_2_0.width / 2, 0)
	self._nodeRoot:setCascadeOpacityEnabled(true)
	self._nodeRoot:setCascadeColorEnabled(true)
	self:addNode(self._nodeRoot)

	self._criRef = nil
	self._idleName = nil
	arg_2_1.path = var_0_1:getSpineKnightPath(arg_2_1.resId)
	arg_2_1.anim = arg_2_1.anim or self:_getIdleName()
	arg_2_1.isLoop = not arg_2_1.isLoop or arg_2_1.isLoop ~= false
	arg_2_1.listener = handler(self, self._onSpineEvent)
	arg_2_1.isAlphaNode = arg_2_1.isAlphaNode
	self._animName = arg_2_1.anim
	self._spine = require("app.view.common.SpineBase").new(arg_2_1)

	self._nodeRoot:addChild(self._spine)
	self:setScale(self._scale)

	self._showInfo = g.core.config.succuba_show_info.get(arg_2_1.resId)

	if self._showInfo then
		if arg_2_1.useBattle then
			self._spine:setPosition(self._showInfo.battle_pos_x, self._showInfo.battle_pos_y)
		else
			self._spine:setPosition(self._showInfo.pos_x, self._showInfo.pos_y)
		end

		self:setScale(tonumber(self._showInfo.scale))

		if arg_2_1.bgUrl then
			local var_2_1 = display.newSprite(arg_2_1.bgUrl)

			self._spine:getNodeForSlot("BG"):addChild(var_2_1)

			local var_2_2 = var_2_1:getContentSize()
			local var_2_3 = math.max(display.width / var_2_2.width, display.height / var_2_2.height)

			if var_2_3 > 0.8 then
				var_2_3 = var_2_3 * 1.5
			end

			var_2_1:setScale(var_2_3)
		end
	end

	self:_onCheckDevicePerform()
end

function DrawSuccuba:getShowInfo()
	return self._showInfo
end

function DrawSuccuba:_updateRes(arg_4_1)
	self._params = arg_4_1
	self._scale = arg_4_1.scale or 1

	local var_4_0 = 0

	if arg_4_1.advanceId then
		self._showInfo = g.core.config.succuba_show_info.get(arg_4_1.advanceId)
		var_4_0 = self._showInfo.res
	elseif arg_4_1.resId then
		var_4_0 = arg_4_1.resId
	elseif arg_4_1.showCfg then
		self._showInfo = arg_4_1.showCfg
		var_4_0 = self._showInfo.res
	end

	arg_4_1.resId = var_4_0

	if arg_4_1.callback then
		self:addEventListener(fgui.UIEventType.TouchBegin, function(arg_5_0)
			arg_5_0:captureTouch()
		end, 1002)
		self:addEventListener(fgui.UIEventType.TouchEnd, function()
			return
		end, 1002)
		self:addClickListener(function(arg_7_0)
			arg_4_1.callback(arg_7_0)
		end, 1002)
		self:setTouchable(true)
	else
		self:removeEventListener(fgui.UIEventType.TouchBegin, 1002)
		self:removeEventListener(fgui.UIEventType.TouchEnd, 1002)
		self:removeClickListener(1002)
		self:setTouchable(false)
	end
end

function DrawSuccuba:_onCheckDevicePerform()
	if g.core.utils.Rule.isForceStopDrawKnight() then
		self._spine:stop()

		if self._spineBg then
			self._spineBg:stop()
		end
	else
		self._spine:restart()

		if self._spineBg then
			self._spineBg:restart()
		end
	end
end

function DrawSuccuba:onLoad()
	self:_onCheckDevicePerform()
	self:setSpineEventEnable(true)
end

function DrawSuccuba:onUnload()
	self:setSpineEventEnable(false)
end

function DrawSuccuba:setScale(arg_11_1)
	if self._spine then
		self._spine:setScale(arg_11_1)
	end
end

function DrawSuccuba:setBgScale(arg_12_1)
	if self._spineBg then
		self._spineBg:setScale(arg_12_1)
	end
end

function DrawSuccuba:playAction(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self._isLoop = false

	for iter_13_0, iter_13_1 in pairs(var_0_0.LOOP_DRAW_ACTION) do
		if arg_13_1 == iter_13_1 then
			self._isLoop = true

			break
		end
	end

	self._callBack = arg_13_2

	if arg_13_4 ~= nil then
		self._isLoop = arg_13_4
	end

	arg_13_3 = arg_13_3 and arg_13_3 or 0
	self._animName = arg_13_1

	self._spine:setAnimation(arg_13_3, arg_13_1, self._isLoop)
	self:playBgAction()
	self:_onCheckDevicePerform()
end

function DrawSuccuba:_getIdleName()
	return "idle_A"
end

function DrawSuccuba:playIdle()
	self._isLoop = true

	self:playAction(self:_getIdleName(), nil, 0)
end

function DrawSuccuba:setFlip(arg_16_1)
	if not self._spine then
		return
	end

	local var_16_0

	if arg_16_1 == nil then
		arg_16_1 = true

		if arg_16_1 then
			var_16_0 = self._scale or -self._scale
		end
	end

	self._spine:setScaleX(var_16_0)

	local var_16_1

	if not self._spineBg then
		do return end

		if arg_16_1 then
			var_16_1 = self._scale or -self._scale
		end
	end

	self._spineBg:setScaleX(var_16_1)
end

function DrawSuccuba:setSpineFlip(arg_17_1)
	arg_17_1 = arg_17_1 or false

	self._spine:getBaseSpine():setScaleX(arg_17_1 and -1 or 1)
end

function DrawSuccuba:_onSpineEvent(arg_18_1)
	if not self._spineEventEnable and self._spine then
		return
	end

	if arg_18_1.type == var_0_0.SPINE_EVENT.COMPLETE then
		if tolua.isnull(self) or self.playIdle == nil then
			error("error check: DrawSuccuba:_onSpineEvent() - self.playIdle == nil", 0)

			return
		end

		if not self._isLoop then
			self:playIdle()

			if self._callBack then
				self._callBack()
			end
		end
	end
end

function DrawSuccuba:playKouXing(arg_19_1)
	if self._spine:getBaseSpine() and self._spine:isSpine() then
		self._waveConfig = arg_19_1
		self._waveFrameIndex = 0
		self._waveFrameMax = string.len(arg_19_1)
		self._lastAttachNum = -1
		self._waveSumCount = 0

		if self._talkSchedule then
			self:cancelSchedule(self._talkSchedule)

			self._talkSchedule = nil
		end

		self._talkSchedule = self:newSchedule(function()
			self._waveFrameIndex = self._waveFrameIndex + 1

			if self._waveFrameIndex > self._waveFrameMax then
				self:cancelSchedule(self._talkSchedule)

				self._talkSchedule = nil

				return
			end

			local var_20_0 = tonumber((string.sub(arg_19_1, self._waveFrameIndex, self._waveFrameIndex))) + 1

			if self._lastAttachNum == var_20_0 then
				self._waveSumCount = self._waveSumCount + 1

				if self._waveSumCount >= 4 then
					if var_20_0 > 1 then
						var_20_0 = var_20_0 - 1
					end

					self._waveSumCount = 0
				end
			else
				self._waveSumCount = 0
			end

			if self._waveFrameIndex % 2 == 0 then
				self._lastAttachNum = var_20_0
			else
				var_20_0 = self._lastAttachNum
			end

			self._spine:setAnimation(1, (var_20_0 < 1 or var_20_0 > 5 or nil) and "koxing1", false)
		end, 0)
	end
end

function DrawSuccuba:closeTalkSch()
	if self._talkSchedule then
		self:cancelSchedule(self._talkSchedule)

		self._talkSchedule = nil
	end
end

function DrawSuccuba:getSuccubaSpine()
	return self._spine
end

function DrawSuccuba:getBaseSpine()
	return self._spine:getBaseSpine()
end

function DrawSuccuba:setGray(arg_24_1)
	self._spine:setGray(arg_24_1)
end

function DrawSuccuba:addColor(arg_25_1, arg_25_2)
	self._spine:addColor(arg_25_1, arg_25_2)
end

function DrawSuccuba:mulColor(arg_26_1, arg_26_2)
	self._spine:mulColor(arg_26_1, arg_26_2)
end

function DrawSuccuba:setAlphaRect(arg_27_1, arg_27_2, arg_27_3)
	self._spine:setAlphaRect(arg_27_1, arg_27_2, arg_27_3)

	if self._spineBg then
		self._spineBg:setAlphaRect(arg_27_1, arg_27_2, arg_27_3)
	end
end

function DrawSuccuba:pauseSpine()
	if self._spine then
		self._spine:pause()
	end

	if self._spineBg then
		self._spineBg:pause()
	end
end

function DrawSuccuba:setSpineEventEnable(arg_29_1)
	self._spineEventEnable = arg_29_1
end

function DrawSuccuba:dispose()
	if self._spine then
		self._spine:dispose()
	end

	if self._spineBg then
		self._spineBg:dispose()
	end
end

function DrawSuccuba:playBgAction()
	if self._spineBg then
		self._spineBg:addSpineEventListener()
		self._spineBg:setAnimation(0, self._animName, true)
	end
end

function DrawSuccuba:_onSpineBgEvent(arg_32_1)
	if not self._spineEventEnable or not self._spineBg then
		return
	end

	if arg_32_1.type == var_0_0.SPINE_EVENT.COMPLETE then
		self:playBgAction()
	end
end

function DrawSuccuba:popCocosNodeAndRemoveKnightSpine()
	self._spine:addSpineEventListener()

	return (self:popDisplayObject())
end

return DrawSuccuba
