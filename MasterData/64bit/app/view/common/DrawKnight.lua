local var_0_0 = g.core.config.knight_info
local var_0_1 = g.core.config.knight_base_info
local var_0_2 = g.core.config.skin_info
local var_0_3 = g.core.const.ConstMgr.SpineConst
local var_0_4 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_5 = g.core.common.Path
local DrawKnight = class("DrawKnight", function()
	return fgui.GComponent:create()
end)

function DrawKnight:ctor(arg_2_1)
	if type(arg_2_1) ~= "table" then
		arg_2_1 = {}
	end

	if arg_2_1.baseId then
		arg_2_1.resId = var_0_0.get(arg_2_1.baseId).res_id
	end

	self._params = arg_2_1

	self:_updateRes(arg_2_1)

	local var_2_0 = 0

	if self._baseInfo then
		var_2_0 = self._baseInfo.id
	elseif self._params.resId then
		var_2_0 = self._params.resId
	end

	self._isCensor = g.core.model.User.homeData:isCensorRigid(var_2_0)

	self:drawKnightAction(arg_2_1)
end

function DrawKnight:onPackageDownloadFinish(arg_3_1, arg_3_2, arg_3_3)
	if self._params.isShowBg and not self._knightSpineBg then
		if self._baseInfo then
			if (self._baseInfo.quality or var_0_0.get(self._params.resId).quality) >= var_0_4.GREEN then
				local var_3_1 = var_0_5:getSpineKnightBgPath(self:_getResBgId())

				if cc.FileUtils:getInstance():isFileExist(var_3_1 .. ".skel") then
					local var_3_2 = clone(self._params)

					var_3_2.resId = var_3_2.resId
					var_3_2.path = var_3_1
					var_3_2.anim = "bg"
					var_3_2.isLoop = not var_3_2.isLoop or var_3_2.isLoop ~= false
					var_3_2.ignoreSpine = self._params.ignoreSpine
					self._knightSpineBg = require("app.view.common.SpineBase").new(var_3_2)

					self._nodeRoot:addChild(self._knightSpineBg, -1)

					if self._baseInfo and not self._params.ignorePosByCfg then
						self._knightSpineBg:setPosition(self._baseInfo.bg_pos_x, self._baseInfo.bg_pos_y)
					end
				end
			end
		end
	end
end

function DrawKnight:_getResBgId()
	return (self._params.resBgId and self._params.resBgId > 0 or nil) and self._params.resBgId
end

function DrawKnight:drawKnightAction(arg_5_1)
	self._spineEventEnable = true

	local var_5_0 = cc.size(500, 500)

	self:setSize(var_5_0.width, var_5_0.height)
	self:setPivot(0.5, 1, true)
	self:setOpaque(true)
	self:setName("DrawKnight")

	self._nodeRoot = cc.Node:create()

	self._nodeRoot:setPosition(var_5_0.width / 2, 0)
	self._nodeRoot:setCascadeOpacityEnabled(true)
	self._nodeRoot:setCascadeColorEnabled(true)
	self:addNode(self._nodeRoot)

	self._criRef = nil

	if arg_5_1.isShowBg then
		if self._baseInfo then
			if (self._baseInfo.quality or var_0_0.get(arg_5_1.resId).quality) >= var_0_4.GREEN then
				local var_5_2 = var_0_5:getSpineKnightBgPath(self:_getResBgId())

				if cc.FileUtils:getInstance():isFileExist(var_5_2 .. ".skel") then
					local var_5_3 = clone(arg_5_1)

					var_5_3.resId = var_5_3.resId
					var_5_3.path = var_5_2
					var_5_3.anim = "bg"
					var_5_3.isLoop = not var_5_3.isLoop or var_5_3.isLoop ~= false
					var_5_3.ignoreSpine = self._params.ignoreSpine
					self._knightSpineBg = require("app.view.common.SpineBase").new(var_5_3)

					self._nodeRoot:addChild(self._knightSpineBg)

					if self._baseInfo and not arg_5_1.ignorePosByCfg then
						self._knightSpineBg:setPosition(self._baseInfo.bg_pos_x, self._baseInfo.bg_pos_y)
					end
				end
			end
		end
	end

	arg_5_1.path = var_0_5:getSpineKnightPath(arg_5_1.resId)
	arg_5_1.anim = arg_5_1.anim or var_0_3.LOOP_ACTION.IDLE
	arg_5_1.isLoop = not arg_5_1.isLoop or arg_5_1.isLoop ~= false
	arg_5_1.listener = handler(self, self._onSpineEvent)
	arg_5_1.ignoreSpine = self._params.ignoreSpine
	self._knightSpine = require("app.view.common.SpineBase").new(arg_5_1)

	self._nodeRoot:addChild(self._knightSpine)
	self:setScale(self._scale)

	if self._baseInfo and not arg_5_1.ignorePosByCfg then
		if self._knightSpineBg then
			self._knightSpine:setPosition(self._baseInfo.bg_pos_x, self._baseInfo.bg_pos_y)
		else
			self._knightSpine:setPosition(self._baseInfo.pos_x, self._baseInfo.pos_y)
		end
	end

	self:_onCheckDevicePerform()
end

function DrawKnight:_updateRes(arg_6_1)
	self._scale = arg_6_1.scale or 1

	local var_6_0 = arg_6_1.wingId or 0
	local var_6_1 = 0
	local var_6_2 = 0
	local var_6_3

	if arg_6_1.knight then
		local var_6_4 = arg_6_1.knight:getInfo()

		var_6_3 = var_6_4 and var_6_4.skin and var_6_4.skin > 0 and (var_6_4.skin_ts and (var_6_4.skin_ts == 0 or var_6_4.skin_ts > g.core.common.ServerTime:getTime()) and var_0_1.get(var_0_2.get(var_6_4.skin).res) or arg_6_1.knight:getResInfo()) or arg_6_1.knight:getResInfo()

		if checknumber(var_6_0) == 0 then
			var_6_0 = arg_6_1.knight:getWingId()
		end
	elseif arg_6_1.snapshot then
		local var_6_5, var_6_6 = g.core.common.GlobalFunc.checkAndGetRobotData(arg_6_1.snapshot)

		if var_6_5 then
			var_6_3 = var_6_6.resId == nil and var_0_1.get(var_0_0.get(var_6_6.showId).res_id) or var_0_1.get(var_6_6.resId)
		else
			local var_6_7 = arg_6_1.snapshot.show_knight_dress

			if arg_6_1.snapshot.show_knight_dress and var_6_7 > 0 then
				var_6_3 = var_0_1.get(g.core.config.skin_info.get(var_6_7).res)
			else
				local var_6_8 = arg_6_1.snapshot.show_knight_id

				if not arg_6_1.snapshot.show_knight_id or var_6_8 == 0 then
					var_6_8 = arg_6_1.snapshot.base_id
				end

				var_6_3 = var_0_1.get(var_0_0.get(var_6_8).res_id)
			end
		end

		if arg_6_1.snapshot and arg_6_1.snapshot.wing_id and checknumber(var_6_0) == 0 then
			var_6_0 = arg_6_1.snapshot.wing_id
		end

		if arg_6_1.snapshot.id == g.core.model.User:getId() and checknumber(var_6_0) == 0 then
			var_6_0 = g.core.model.User.wingData:getShowWingId()
		end
	elseif arg_6_1.baseInfo then
		var_6_3 = arg_6_1.baseInfo
	elseif arg_6_1.resId then
		var_6_3 = var_0_1.get(arg_6_1.resId)
	elseif arg_6_1.skinId then
		var_6_3 = var_0_1.get(g.core.config.skin_info.get(arg_6_1.skinId).res)
	end

	self._spBgParam = nil

	if var_6_3 then
		var_6_1 = var_6_3.painted_id
		var_6_2 = var_6_3.painted_bg_id

		if var_6_3.knight_show == 1 then
			self._spBgParam = {
				isLoop = false,
				fullScreenState = 1,
				zOrder = 5,
				moduleName = "knight",
				movieName = var_6_3.knight_show2
			}
		end
	elseif arg_6_1.dir_res then
		var_6_1 = arg_6_1.dir_res
	end

	self:updateWingRes(var_6_0)

	arg_6_1.resId = var_6_1
	arg_6_1.resBgId = var_6_2
	self._baseInfo = var_6_3

	if arg_6_1.callback then
		self:addEventListener(fgui.UIEventType.TouchBegin, function(arg_7_0)
			arg_7_0:captureTouch()
		end, 1001)
		self:addEventListener(fgui.UIEventType.TouchEnd, function()
			return
		end, 1001)
		self:addClickListener(function(arg_9_0)
			arg_6_1.callback(arg_9_0)
		end, 1001)
		self:setTouchable(true)
	else
		self:removeEventListener(fgui.UIEventType.TouchBegin, 1001)
		self:removeEventListener(fgui.UIEventType.TouchEnd, 1001)
		self:removeClickListener(1001)
		self:setTouchable(false)
	end
end

function DrawKnight:_onCheckDevicePerform()
	if g.core.utils.Rule.isForceStopDrawKnight() then
		self._knightSpine:stop()

		if self._knightSpineBg then
			self._knightSpineBg:stop()
		end
	else
		self._knightSpine:restart()

		if self._knightSpineBg then
			self._knightSpineBg:restart()
		end
	end
end

function DrawKnight:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_PACKAGE_LIST_DOWNLOAD_FINISH, handler(self, self.onPackageDownloadFinish), self)
	self:_onCheckDevicePerform()
	self:setSpineEventEnable(true)
end

function DrawKnight:onUnload()
	self:setSpineEventEnable(false)
	self:removeSpecialShowAction()
end

function DrawKnight:setScale(arg_13_1)
	if self._knightSpine then
		self._knightSpine:setScale(arg_13_1)
	end

	self:setBgScale(arg_13_1)
end

function DrawKnight:setBgScale(arg_14_1)
	if self._knightSpineBg then
		self._knightSpineBg:setScale(arg_14_1)
	end
end

function DrawKnight:updateWingRes(arg_15_1)
	if self._wingId ~= arg_15_1 then
		-- block empty
	end

	self._wingId = arg_15_1
end

function DrawKnight:playAction(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	self._isLoop = false

	for iter_16_0, iter_16_1 in pairs(var_0_3.LOOP_DRAW_ACTION) do
		if arg_16_1 == iter_16_1 then
			self._isLoop = true

			break
		end
	end

	self._callBack = arg_16_2

	if arg_16_4 ~= nil then
		self._isLoop = arg_16_4
	end

	arg_16_3 = arg_16_3 and arg_16_3 or 0

	self._knightSpine:setAnimation(arg_16_3, arg_16_1, self._isLoop)
	self:_onCheckDevicePerform()
end

function DrawKnight:playBgSpecialAction(arg_17_1, arg_17_2, arg_17_3)
	arg_17_3 = arg_17_3 or 0
	arg_17_2 = arg_17_2 or false

	if not self._knightSpineBg then
		return
	end

	self._knightSpineBg:addSpineEventListener(handler(self, self._onSpineBgEvent))
	self._knightSpineBg:setAnimation(arg_17_3, arg_17_1, arg_17_2)
end

function DrawKnight:playSpecialShowAction(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	if not self._spBgParam then
		return
	end

	if self._isCensor then
		if arg_18_3 then
			arg_18_3()
		end

		return
	end

	if not arg_18_5 and g.core.model.User.UserTitleData:isSpecialShowActionHide(self._spBgParam.movieName) then
		if arg_18_3 then
			arg_18_3()
		end

		return
	end

	arg_18_1 = arg_18_1 or self
	arg_18_2 = arg_18_2 or cc.p(0, 0)
	self._spBgParam.x = arg_18_2.x
	self._spBgParam.y = arg_18_2.y
	self._spBgParam.listener = handler(self, function(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
		if arg_19_1 == "complete" then
			arg_19_0._criRef = nil

			if arg_18_3 then
				arg_18_3()
			end
		end
	end)

	if g.core.common.PackageRes:checkResIsNeedUpgrade(tonumber(string.match(self._spBgParam.movieName, "%d+")), g.core.common.PackageRes.resType.KNIGHT) then
		if arg_18_4 then
			self._spTransTimer = nil

			arg_18_4()
		end

		return
	end

	self._criRef = arg_18_1:addCriSprite(self._spBgParam)

	if arg_18_4 then
		local var_18_0 = string.split(self._spBgParam.movieName, "_")

		self._spTransTimer = self:newScheduleOnce(handler(self, function(arg_20_0)
			arg_20_0._spTransTimer = nil

			arg_18_4()
		end), (tonumber(var_18_0[#var_18_0]) - 500) / 1000)
	end
end

function DrawKnight:removeSpecialShowAction()
	if self._criRef and self._criRef.dispose then
		self._criRef:dispose()
	end

	if self._spTransTimer then
		self:cancelSchedule(self._spTransTimer)
	end
end

function DrawKnight:playBgAction()
	if self._knightSpineBg then
		self._knightSpineBg:addSpineEventListener()
		self._knightSpineBg:setAnimation(0, "bg", true)
	end
end

function DrawKnight:_onSpineBgEvent(arg_23_1)
	if not self._spineEventEnable or not self._knightSpineBg then
		return
	end

	if arg_23_1.type == var_0_3.SPINE_EVENT.COMPLETE then
		self:playBgAction()
	end
end

function DrawKnight:playIdle()
	self._isLoop = true

	self:playAction(var_0_3.LOOP_DRAW_ACTION.IDLE, nil, 0)
end

function DrawKnight:setFlip(arg_25_1)
	if not self._knightSpine then
		return
	end

	local var_25_0

	if arg_25_1 == nil then
		arg_25_1 = true

		if arg_25_1 then
			var_25_0 = self._scale or -self._scale
		end
	end

	self._knightSpine:setScaleX(var_25_0)

	local var_25_1

	if not self._knightSpineBg then
		do return end

		if arg_25_1 then
			var_25_1 = self._scale or -self._scale
		end
	end

	self._knightSpineBg:setScaleX(var_25_1)
end

function DrawKnight:setSpineFlip(arg_26_1)
	arg_26_1 = arg_26_1 or false

	self._knightSpine:getBaseSpine():setScaleX(arg_26_1 and -1 or 1)
end

function DrawKnight:_onSpineEvent(arg_27_1)
	if not self._spineEventEnable and self._knightSpine then
		return
	end

	if arg_27_1.type == var_0_3.SPINE_EVENT.COMPLETE then
		if tolua.isnull(self) or self.playIdle == nil then
			error("error check: DrawKnight:_onSpineEvent() - self.playIdle == nil", 0)

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

function DrawKnight:playKouXing(arg_28_1)
	if self._knightSpine:getBaseSpine() and self._knightSpine:isSpine() then
		self._waveConfig = arg_28_1
		self._waveFrameIndex = 0
		self._waveFrameMax = string.len(arg_28_1)
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

			local var_29_0 = tonumber((string.sub(arg_28_1, self._waveFrameIndex, self._waveFrameIndex))) + 1

			if self._lastAttachNum == var_29_0 then
				self._waveSumCount = self._waveSumCount + 1

				if self._waveSumCount >= 4 then
					if var_29_0 > 1 then
						var_29_0 = var_29_0 - 1
					end

					self._waveSumCount = 0
				end
			else
				self._waveSumCount = 0
			end

			if self._waveFrameIndex % 2 == 0 then
				self._lastAttachNum = var_29_0
			else
				var_29_0 = self._lastAttachNum
			end

			self._knightSpine:setAnimation(1, (var_29_0 < 1 or var_29_0 > 5 or nil) and "koxing1", false)
		end, 0)
	end
end

function DrawKnight:closeTalkSch()
	if self._talkSchedule then
		self:cancelSchedule(self._talkSchedule)

		self._talkSchedule = nil
	end
end

function DrawKnight:getKnightSpine()
	return self._knightSpine
end

function DrawKnight:getBaseSpine()
	return self._knightSpine:getBaseSpine()
end

function DrawKnight:setAlpha(arg_33_1)
	self._knightSpine:setAlpha(arg_33_1)
end

function DrawKnight:setGray(arg_34_1)
	self._knightSpine:setGray(arg_34_1)
end

function DrawKnight:addColor(arg_35_1, arg_35_2)
	self._knightSpine:addColor(arg_35_1, arg_35_2)
end

function DrawKnight:mulColor(arg_36_1, arg_36_2)
	self._knightSpine:mulColor(arg_36_1, arg_36_2)
end

function DrawKnight:setAlphaRect(arg_37_1, arg_37_2, arg_37_3)
	self._knightSpine:setAlphaRect(arg_37_1, arg_37_2, arg_37_3)

	if self._knightSpineBg then
		self._knightSpineBg:setAlphaRect(arg_37_1, arg_37_2, arg_37_3)
	end
end

function DrawKnight:pauseSpine()
	if self._knightSpine then
		self._knightSpine:pause()
	end

	if self._knightSpineBg then
		self._knightSpineBg:pause()
	end
end

function DrawKnight:setSpineEventEnable(arg_39_1)
	self._spineEventEnable = arg_39_1
end

function DrawKnight:dispose()
	if self._knightSpine then
		self._knightSpine:dispose()
	end

	if self._knightSpineBg then
		self._knightSpineBg:dispose()
	end
end

function DrawKnight:popCocosNodeAndRemoveKnightSpine()
	self._knightSpine:addSpineEventListener()

	return (self:popDisplayObject())
end

return DrawKnight
