local var_0_0 = 1.3
local var_0_1 = 0.5
local var_0_2 = 0.8
local BaseConst = require("app.view.base.const.BaseConst")
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_6 = 15
local TouchGameLayer = class("TouchGameLayer", require("app.fairyGUI.touchGame.UI_TouchGameLayer"), function()
	return fgui.GComponent:create({
		pkgName = "touchGame",
		isFullScreen = true,
		pkgPath = "ui/touchGame/touchGame",
		resName = "TouchGameLayer"
	})
end)

function TouchGameLayer:ctor(arg_2_1)
	self._params = arg_2_1
	self._missionId = arg_2_1.missionId
	self._isRepeatModel = arg_2_1.isRepeatModel
	self._isShare = arg_2_1.isShare
	self._activeThemeValue = arg_2_1.themeValue
	self._data = {}
	self._centerPos = cc.p(display.width / 2, display.height / 2)
	self._knightSpine = nil
	self._curGroup = 1
	self._groupNum = 1
	self._showCompNum = 0
	self._clickComps = {}
	self._curEventInfo = nil
	self._showIndexMap = {}
	self._lastTouchTime = 0

	self.m_closeBtn:addClickListener(handler(self, self._onClose))
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
	self.m_shareComp:setVisibleEx(not self._isShare)
end

function TouchGameLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_END, handler(self, self._onAvgEnd), self)
	self:_initData()
	self:_initUI()
	self:_checkAndTickGuide()
end

function TouchGameLayer:_checkAndTickGuide()
	if (self._params.gameId == 1 or self._params.gameId == 2) and not self._isShare then
		if self._clickComps and self._clickComps[1] then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "BIO_TOUCH_GAME_STAGE_1",
				targetBtn = self._clickComps[1]
			})
		end
	else
		self._lastTouchTime = os.time()
		self._guideSchedulerId = self:newSchedule(handler(self, self._onCheckGuideScheduler), 1)
	end
end

function TouchGameLayer:onUnload()
	KnightVoiceCommon.stopVoice()

	if self._schedule then
		self:cancelSchedule(self._schedule)

		self._schedule = nil
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function TouchGameLayer:_initData()
	local var_6_0 = g.core.config.game_touch_event_info.get(self._params.gameId)

	self._data.info = var_6_0
	self._data.events = {}

	for iter_6_0 = 1, var_0_6 do
		if var_6_0["evnet_id" .. iter_6_0] and var_6_0["evnet_id" .. iter_6_0] > 0 then
			local var_6_1 = g.core.config.game_touch_info.get(var_6_0["evnet_id" .. iter_6_0])

			self._data.events[var_6_1.event_team] = self._data.events[var_6_1.event_team] or {
				touch = {}
			}

			local var_6_2 = self._data.events[var_6_1.event_team]

			if var_6_1.type == 1 then
				var_6_2.touch[var_6_1.id] = var_6_1
			else
				var_6_2.finish = var_6_1
			end
		else
			break
		end
	end

	self._groupNum = #self._data.events
end

function TouchGameLayer:_initUI()
	self:addBg("bg/" .. self._data.info.bg .. ".jpg")
	self.m_knightHolder:setPosition(self._centerPos)
	self.m_touchHolder:setPosition(self._centerPos)
	self.m_progComp:setName(self._data.info.des)
	self.m_progComp:setProg({
		value = 0,
		max = self._groupNum
	})
	self:_createKnight()
	self:_createClickComp()
	self.m_pickupComp:setMax(1)
	self.m_lineTitle:setPosition(cc.p(self._centerPos.x, self._centerPos.y + 200))
	self.m_pickupComp:setPosition(cc.p(self._centerPos.x, self._centerPos.y + 195))
end

function TouchGameLayer:_createKnight()
	self._knightSpine = DrawKnight.new({
		isShowBg = false,
		resId = self._data.info.spine
	})

	self._knightSpine:setPosition(cc.p(tonumber(self._data.info.X), tonumber(self._data.info.Y)))
	self._knightSpine:setScale(tonumber(self._data.info.scale))
	self.m_knightHolder:addChild(self._knightSpine)
end

function TouchGameLayer:_createClickComp()
	if self._data.events[self._curGroup] then
		self._showIndexMap = {}

		local var_9_0 = 0

		for iter_9_0, iter_9_1 in pairs(self._data.events[self._curGroup].touch) do
			local var_9_1

			var_9_0 = var_9_0 + 1

			table.insert(self._showIndexMap, var_9_0)

			if self._clickComps[var_9_0] then
				var_9_1 = self._clickComps[var_9_0]
			else
				var_9_1 = fgui.UIPackage:createObject("touchGame", "TouchGameClickComp")
				self._clickComps[var_9_0] = var_9_1

				self.m_touchHolder:addChild(var_9_1)
				self:addListen(var_9_1)
			end

			var_9_1:updateInfo({
				info = iter_9_1,
				index = var_9_0
			})
		end

		self._showCompNum = var_9_0
	else
		self:newScheduleOnce(handler(self, self._gameEnd), 0.5)
	end
end

function TouchGameLayer:_gameEnd()
	if self._missionId and not self._isRepeatModel and not self._isShare then
		if self._activeThemeValue then
			g.core.network.GameNetProxy:send_C2S_ThemeBiography_ExecuteMission({
				act_id = self._activeThemeValue,
				id = self._missionId
			})
		else
			g.core.network.GameNetProxy:send_C2S_Biography_ExecuteMission({
				id = self._missionId
			})
		end
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function TouchGameLayer:receiveCompEvent(arg_11_1, arg_11_2)
	if arg_11_1 == "TouchGameClickComp_OnClick" then
		self._showCompNum = self._showCompNum - 1

		local var_11_0 = arg_11_2.info

		for iter_11_0, iter_11_1 in ipairs(self._showIndexMap) do
			if iter_11_1 == arg_11_2.index then
				table.remove(self._showIndexMap, iter_11_0)

				break
			end
		end

		if self._showCompNum == 0 then
			if self._data.events[self._curGroup].finish then
				var_11_0 = self._data.events[self._curGroup].finish
			end
		end

		self:_onProcessingTouch(var_11_0, arg_11_2.clickWorldPos)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH, false, {
			finish = true
		})

		if self._guideSchedulerId then
			self:cancelSchedule(self._guideSchedulerId)

			self._guideSchedulerId = nil
		end
	end
end

function TouchGameLayer:doAutoAction()
	for iter_12_0, iter_12_1 in ipairs(self._clickComps) do
		if iter_12_1:isVisible() then
			iter_12_1:doAutoAction()

			break
		end
	end
end

function TouchGameLayer:_onProcessingTouch(arg_13_1, arg_13_2)
	self._curEventInfo = arg_13_1

	self.m_touchHolder:setVisible(false)

	if arg_13_1 then
		self.m_pickupComp:getChild("descTxt"):setText(arg_13_1.action_lines or "")
	end

	self:_showSpineScale(arg_13_2)
end

function TouchGameLayer:_showAction()
	self:_playDialogAndVoice()
	self:_playSpineAnimation()
end

function TouchGameLayer:_playDialogAndVoice()
	if self._curEventInfo.sound ~= "" then
		KnightVoiceCommon.playVoice({
			knightId = self._data.info.spine,
			voiceType = self._curEventInfo.sound
		})
		self.m_stateController:setSelectedIndex(1)
		self.m_lineTitle:setTitle(self._curEventInfo.lines)
	elseif self._curEventInfo.lines ~= "" then
		self.m_stateController:setSelectedIndex(1)
		self.m_lineTitle:setTitle(self._curEventInfo.lines)
	end
end

function TouchGameLayer:_playSpineAnimation()
	self._schedule = self:newScheduleOnce(handler(self, self._showAvg), tonumber((self._curEventInfo.action and self._curEventInfo.action ~= "" or nil) and var_0_1 + self._knightSpine:getKnightSpine():getAnimationDuration(self._curEventInfo.action) + var_0_2))

	if self._curEventInfo.action ~= "" then
		self._knightSpine:playAction(self._curEventInfo.action)
	end
end

function TouchGameLayer:_showAvg()
	self.m_stateController:setSelectedIndex(0)

	if self._schedule then
		self:cancelSchedule(self._schedule)

		self._schedule = nil
	end

	local var_17_0 = self._curEventInfo.avg_id

	if self._curEventInfo.avg_id > 0 and not self._isRepeatModel then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
			id = var_17_0
		})
	else
		self:_onAvgEnd()
	end
end

function TouchGameLayer:_onAvgEnd()
	self.m_touchHolder:setVisible(true)

	if self._showCompNum == 0 then
		self.m_progComp:updateProg(self._curGroup)

		self._curGroup = self._curGroup + 1

		self:_createClickComp()
	else
		self._lastTouchTime = os.time()
		self._guideSchedulerId = self:newSchedule(handler(self, self._onCheckGuideScheduler), 1)
	end
end

function TouchGameLayer:_onCheckGuideScheduler()
	if os.time() - self._lastTouchTime >= 4 then
		if self._guideSchedulerId then
			self:cancelSchedule(self._guideSchedulerId)

			self._guideSchedulerId = nil
		end

		if self._showIndexMap and self._showIndexMap[1] and self._clickComps and self._clickComps[self._showIndexMap[1]] then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "BIO_TOUCH_GAME_STAGE_2",
				targetBtn = self._clickComps[self._showIndexMap[1]]
			})
		end
	end
end

function TouchGameLayer:_onClose()
	if self._guideSchedulerId then
		self:cancelSchedule(self._guideSchedulerId)

		self._guideSchedulerId = nil
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function TouchGameLayer:_showSpineScale(arg_21_1)
	local var_21_0 = self._knightSpine:getKnightSpine()

	if var_21_0 then
		local var_21_1 = self.m_knightHolder:displayObject():convertToNodeSpace(arg_21_1)
		local var_21_2 = cc.p(var_0_0 * var_21_1.x, var_0_0 * var_21_1.y)
		local var_21_3 = cc.p(var_21_2.x - var_21_1.x, var_21_2.y - var_21_1.y)
		local var_21_5 = self._curEventInfo or {}
		local var_21_6 = var_21_5.action

		self._knightSpine:runFGAction(fgui.FSequence:create(fgui.FSpawn:create(fgui.FScaleTo:create(var_0_1, var_0_0), (fgui.FMoveBy:create(var_0_1, cc.p(-1 * var_21_3.x, -1 * var_21_3.y)))), fgui.FCallFunc:create(handler(self, function()
			self:_playSpineAnimation()
		end)), fgui.FCallFunc:create(handler(self, function()
			self:_showProgressItem()
		end)), fgui.FDelayTime:create((var_21_5.action and var_21_6 ~= "" or nil) and var_21_0:getAnimationDuration(var_21_6)), fgui.FSpawn:create(fgui.FScaleTo:create(var_0_2, 1), fgui.FMoveBy:create(var_0_2, cc.p(var_21_3.x, var_21_3.y)), (fgui.FCallFunc:create(handler(self, function()
			self:_playDialogAndVoice()
		end))))))
	end
end

function TouchGameLayer:_showProgressItem()
	self.m_stateController:setSelectedIndex(2)
	self.m_pickupComp:getChild("iconImg"):setURL((self._curEventInfo.item ~= "" or nil) and "icon/bio/" .. self._curEventInfo.item .. ".png")
	self.m_pickupComp:getController("show"):setSelectedIndex(0)
	self.m_pickupComp:setValue(0)
	self.m_pickupComp:tweenValue(1, 1)
	self.m_pickupComp:runFGAction((fgui.FSequence:create({
		fgui.FDelayTime:create(1),
		fgui.FCallFunc:create(function()
			self.m_pickupComp:getController("show"):setSelectedIndex(1)
			self.m_pickupComp:getTransition("out"):play()
		end)
	})))
end

function TouchGameLayer:_onShareClick()
	self.m_shareComp:setVisible(false)
	self.m_progComp:setShareState(1)
	self.m_closeBtn:setVisible(false)

	local var_27_0 = cc.utils:captureNode(self)

	var_27_0:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_27_0:release()
	self.m_shareComp:setVisible(true)
	self.m_progComp:setShareState(0)
	self.m_closeBtn:setVisible(true)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_11,
		missionId = self._missionId,
		gameId = self._params.gameId
	})
end

return TouchGameLayer
