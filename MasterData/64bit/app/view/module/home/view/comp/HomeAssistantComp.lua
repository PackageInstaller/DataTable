local HomeAssistantComp = class("HomeAssistantComp", require("app.fairyGUI.home.UI_HomeAssistantComp"))
local HomeConst = require("app.view.module.home.const.HomeConst")
local DrawKnight = require("app.view.common.DrawKnight")
local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local var_0_4 = g.core.const.ConstMgr.SpineConst
local AssistantCommon = require("app.view.module.assistant.common.AssistantCommon")
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local var_0_7 = g.core.model.User
local KsMath = require("app.core.utils.KsMath")
local var_0_9 = g.core.model.User.userFestivalData
local var_0_10 = g.core.common.ServerTime

function HomeAssistantComp:ctor()
	self._assistantId = nil
	self._assistantBaseInfo = nil
	self._assistantVoiceInfo = nil
	self._linesType = nil
	self._linesIndex = nil
	self._talkLines = nil
	self._showKnight = nil
	self._isPlaySound = false
	self._isInSpecialTouchSound = false
	self._isInSpecialTouchAction = false
	self._isInSpecialShowAction = false
	self._specialTouchIndex = 0
	self._localTouchPos = nil
	self._moveDistance = 0
	self._curAdvIndex = 1

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ASSISTANT_ADV) then
		self._curAdvIndex = g.core.model.User:getLastAdvIndex()
	end

	self._MAX_TALK_LINES_NUM = 3
	self._MAX_FAVORABILITY_LINES_NUM = 5
	self._LINES_TYPE = {
		LOGIN = 0,
		SPECIAL_TOUCH = 4,
		TOUCH = 3,
		TALK = 2,
		ASSISTANT = 1
	}
	self._movieComp = nil

	self:_initComp()
end

function HomeAssistantComp:onLoad()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ASSISTANT_ADV) then
		self:_initData()
		self:_resetScene()
	end

	self._isChangeAssistant = true

	self:_addAssistant()
	self:_updateTrans()
	g.core.event.EventManager:addEventListener(g.core.event.enum.HOME_AUTO_POP_END, handler(self, self._showSpecialShowLines), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CLICK_START, self._onRefreshTouchTime, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)

	self._handler = self:newSchedule(handler(self, self._onUpdate), 1)
	self._nowModuleTime = 0

	self:_fetchTodayBirthDayAdvId()
end

function HomeAssistantComp:_fetchTodayBirthDayAdvId()
	if not g.core.common.ModuleUnlock:isFunctionUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HOLIDAY_VOICE, nil, true) then
		return
	end

	local var_3_0 = var_0_10:getDateObject((var_0_10:getTime()))
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in g.core.config.knight_favorability_info.ipairs() do
		if iter_3_1.brithday_month == tonumber(var_3_0.month) and iter_3_1.brithday_day == tonumber(var_3_0.day) then
			table.insert(var_3_1, iter_3_1.id)
		end
	end

	g.core.network.GameNetProxy:send_C2S_Festival_Get_Infos({
		advance_ids = var_3_1
	})
end

function HomeAssistantComp:_onUpdate(arg_4_1, arg_4_2)
	self._nowModuleTime = self._nowModuleTime + arg_4_2

	if self._nowModuleTime > self._assistantAutoTalkCd and not self._isPlaySound then
		self._nowModuleTime = 0
		self._linesType = self._LINES_TYPE.TALK

		self:_showLines()
	end
end

function HomeAssistantComp:_initComp()
	self:_initData()
	self:_initUI()
end

function HomeAssistantComp:_updateTrans()
	self.m_rightTransition:changeParams({
		pt01 = {
			self._assistantPos.x,
			self._assistantPos.y
		},
		pt02 = {
			self._assistantPos.x,
			self._assistantPos.y
		}
	})
	self.m_leftTransition:changeParams({
		pt01 = {
			self._assistantPos.x,
			self._assistantPos.y
		},
		pt02 = {
			self._assistantPos.x,
			self._assistantPos.y
		}
	})
	self.m_enterTransition:changeParams({
		scale01 = {
			self._assistantScale * 2,
			self._assistantScale * 2
		},
		scale02 = {
			self._assistantScale,
			self._assistantScale
		},
		scaleBg01 = {
			self._bgScale * 2,
			self._bgScale * 2
		},
		scaleBg02 = {
			self._bgScale,
			self._bgScale
		}
	})
end

function HomeAssistantComp:_initData()
	local var_7_0 = AssistantCommon.getAssistantData()

	self._assistantScale = var_7_0.assistantScale
	self._assistantPos = var_7_0.assistantPos

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ASSISTANT_ADV) then
		local var_7_1 = g.core.model.User:getNominateInfoByIndex(self._curAdvIndex)

		self._assistantScale = var_7_1.scale
		self._assistantPos = {
			x = var_7_1.x,
			y = var_7_1.y
		}
	end

	self._assistantMoveStarPos = nil
	self._assistantAutoTalkCd = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.ASSISTANT_AUTO_TALK_CD).parameter
end

function HomeAssistantComp:_initUI()
	self.m_bgLoader:setURL((g.core.common.Path:getHomeBackground(g.core.config.bg_book_info.get((var_0_7.userActiveSceneData:getSceneId())).pic)))

	self._bgScale = math.max(display.width / self.m_bgLoader:getWidth(), display.height / self.m_bgLoader:getHeight())

	self.m_bgLoader:setScale(self._bgScale)
	self.m_touchBg:setAlpha(HomeConst.ASSISTANT_TOUCH_BG_ALPHA)
	self.m_touchBg:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onKnightTouchBegin), 1002)
	self.m_touchBg:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onKnightTouchMove), 1002)
	self.m_touchBg:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onKnightTouchEnd), 1002)
	self.m_touchBg:addClickListener(handler(self, self._onClickKnight))
end

function HomeAssistantComp:processCompEvent(arg_9_1, arg_9_2)
	if arg_9_1 == "AssistantChangePosition_MoveBegin" then
		self:_moveAssistantBegin()
	elseif arg_9_1 == "AssistantChangePosition_Move" and arg_9_2.changPos then
		self:_moveAssistant(arg_9_2.changPos)
	elseif arg_9_1 == "AssistantChangePosition_ChangeScale" and arg_9_2.scale then
		self:_setAssistantScale(arg_9_2.scale)
	elseif arg_9_1 == "AssistantChangePosition_Reset" then
		if self._showKnight then
			self._showKnight:removeSpecialShowAction()

			self._isInSpecialShowAction = false
		end

		self:_resetAssistant()
	elseif arg_9_1 == "AssistantChangePosition_Confirm" then
		self:_confirmAssistant()
	elseif arg_9_1 == "AssistantChangeScene_SelectedScene" and arg_9_2.scenePic then
		self:_changeScene(arg_9_2.scenePic)
	elseif arg_9_1 == "AssistantChangeScene_Quit" then
		if self._isInAssistantTemp then
			self:resetAssistantToReal()
		else
			self:_resetScene()
		end
	elseif arg_9_1 == "AssistantChangePosition_Quit" then
		if self._isInAssistantTemp then
			self:resetAssistantToReal()
		end
	elseif arg_9_1 == "AssistantChange_Adv_Next" then
		self:changeNextAssistant()
	end
end

function HomeAssistantComp:_addAssistant()
	self._isInSpecialShowAction = false

	local var_10_0 = var_0_7:getAssistantId()
	local var_10_1 = var_0_7:getAssistantDressId()
	local var_10_2 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ASSISTANT_ADV)

	if var_10_2 then
		local var_10_3 = g.core.model.User:getNominateInfoByIndex(self._curAdvIndex)

		var_10_0 = var_10_3.advanceId
		var_10_1 = var_10_3.skinId
	end

	self._linesType = self._assistantId == nil and self._LINES_TYPE.LOGIN or (self._assistantId ~= var_10_0 or self._assistantSkinId ~= var_10_1) and self._LINES_TYPE.ASSISTANT or self._LINES_TYPE.TALK
	self._assistantId = var_10_0
	self._assistantSkinId = var_10_1

	if self._linesType ~= self._LINES_TYPE.TALK then
		self.m_knightComp:removeChildren()

		self._showKnight = nil
		self._assistantBaseInfo = var_0_7:getAssistantResInfo()
		self._assistantVoiceInfo = var_0_7:getAssistantVoiceInfo()

		if var_10_2 then
			self._assistantBaseInfo = var_0_7:getAssistantTempResInfo(self._assistantId, self._assistantSkinId)
			self._assistantVoiceInfo = var_0_7:getAssistantTempVoiceInfo(self._assistantId, self._assistantSkinId)
		end

		local var_10_4 = {
			resId = self._assistantBaseInfo.painted_id,
			resBgId = self._assistantBaseInfo.painted_bg_id
		}

		var_10_4.isShowBg = true
		var_10_4.baseInfo = self._assistantBaseInfo
		self._showKnight = DrawKnight.new(var_10_4)

		self.m_knightComp:addChild(self._showKnight)
		self:_getTalkLines()
		self:_showLines()
		self.m_knightComp:setScale(self._assistantScale)
		self.m_knightComp:setPosition(self._assistantPos)

		if not var_10_2 then
			g.core.resource.ResourceManager:refreshAssistaneCache()
		end
	else
		if self._showKnight then
			self._showKnight:setSpineEventEnable(true)
		end

		self:_getTalkLines()

		if self._isChangeAssistant then
			self:_showSpecialShowLines()
		end
	end

	self._isInSpecialTouchSound = false
	self._isInSpecialTouchAction = false
end

function HomeAssistantComp:changeAssistantTempAdv(arg_11_1, arg_11_2)
	if self._showKnight then
		self._showKnight:removeSpecialShowAction()

		self._isInSpecialShowAction = false
	end

	local var_11_0 = arg_11_1.advanceId
	local var_11_1 = arg_11_2 or arg_11_1.skinId

	self._isInAssistantTemp = true
	self._nominateInfo = arg_11_1
	self._linesType = self._LINES_TYPE.ASSISTANT

	self.m_knightComp:setScale(arg_11_1.scale)
	self.m_knightComp:setPosition({
		x = arg_11_1.x,
		y = arg_11_1.y
	})
	self.m_bgLoader:setURL((g.core.common.Path:getHomeBackground(g.core.config.bg_book_info.get(arg_11_1.bg).pic)))

	if var_11_0 == self._assistantId and var_11_1 == self._assistantSkinId then
		return
	end

	self._assistantId = var_11_0
	self._assistantSkinId = var_11_1

	self.m_knightComp:removeChildren()

	self._showKnight = nil
	self._assistantBaseInfo = var_0_7:getAssistantTempResInfo(var_11_0, var_11_1)
	self._assistantVoiceInfo = var_0_7:getAssistantTempVoiceInfo(var_11_0, var_11_1)

	local var_11_2 = {
		resId = self._assistantBaseInfo.painted_id
	}

	var_11_2.isShowBg = true
	self._showKnight = DrawKnight.new(var_11_2)

	self.m_knightComp:addChild(self._showKnight)
end

function HomeAssistantComp:resetAssistantToReal()
	self._isInAssistantTemp = false

	if self._showKnight then
		self._showKnight:removeSpecialShowAction()

		self._isInSpecialShowAction = false
	end

	self:_addAssistant()
	self:_resetAssistant()
	self:_resetScene()
end

function HomeAssistantComp:changeNextAssistant()
	local var_13_0 = g.core.model.User:getNominateList()

	if #var_13_0 == 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(100546))

		return
	end

	self._isChangeAssistant = true
	self._curAdvIndex = self._curAdvIndex + 1

	if self._curAdvIndex > #var_13_0 then
		self._curAdvIndex = 1
	end

	local var_13_1 = AssistantCommon.getAssistantData()

	var_13_1.advIndex = self._curAdvIndex

	AssistantCommon.setAssistantData(var_13_1)
	self:_initData()
	self:resetAssistantToReal()
end

function HomeAssistantComp:_onRefreshTouchTime()
	self._nowModuleTime = 0
end

function HomeAssistantComp:_onKnightTouchBegin(arg_15_1)
	if self._isInSpecialTouchSound or self._isInSpecialTouchAction or self._isInSpecialShowAction then
		return
	end

	self._localTouchPos = arg_15_1:getInput():getPosition()

	arg_15_1:captureTouch()
end

function HomeAssistantComp:_onKnightTouchMove(arg_16_1)
	if self._localTouchPos then
		local var_16_0 = arg_16_1:getInput():getPosition()

		self._moveDistance = self._moveDistance + KsMath.calculateDistance(self._localTouchPos, var_16_0)
		self._localTouchPos = var_16_0

		if self._moveDistance > 100 then
			self._localTouchPos = nil
			self._moveDistance = 0
			self._linesType = self._LINES_TYPE.TOUCH

			self:_showLines()
		end
	end
end

function HomeAssistantComp:_onKnightTouchEnd()
	self._localTouchPos = nil
	self._moveDistance = 0
end

function HomeAssistantComp:_onClickKnight(arg_18_1)
	if self._isInSpecialTouchSound or self._isInSpecialTouchAction or self._isInSpecialShowAction then
		return
	end

	local var_18_0 = false
	local var_18_1 = 0
	local var_18_2 = arg_18_1:getInput():getPosition()
	local var_18_3 = math.clamp(self._assistantScale, 0.5, 1.5)

	while true do
		if not self._assistantVoiceInfo["radius_" .. 1] or self._assistantVoiceInfo["radius_" .. 1] == 0 then
			break
		end

		if self._assistantVoiceInfo["x_pos_" .. 1] and self._assistantVoiceInfo["y_pos_" .. 1] and cc.pGetDistance(cc.pAdd(cc.p(self._assistantVoiceInfo["x_pos_" .. 1] * self._assistantScale, self._assistantVoiceInfo["y_pos_" .. 1] * self._assistantScale), self._assistantPos), var_18_2) < self._assistantVoiceInfo["radius_" .. 1] * var_18_3 then
			var_18_0 = true
			var_18_1 = 1

			break
		end
	end

	if var_18_0 then
		self._linesType = self._LINES_TYPE.SPECIAL_TOUCH
		self._specialTouchIndex = var_18_1

		self:_showLines()

		if DebugCommon.getDebugGlobalValueByKey("wedding_action_hide_ui") then
			self:newScheduleOnce(function()
				self:dispatchCompEvent("EVENT_HOME_HIDE_UI")
			end)
		end
	else
		self._linesType = self._LINES_TYPE.TALK

		self:_showLines()
	end

	g.core.network.GameNetProxy:send_C2S_Action_Finish({
		id = 1117
	})
end

function HomeAssistantComp:_getTalkLines()
	self._talkLines = {}

	for iter_20_0 = 1, self._MAX_TALK_LINES_NUM do
		local var_20_0 = KnightVoiceCommon.getVoiceLinesStr(self._assistantVoiceInfo, "talk" .. iter_20_0 .. "_lines")

		if var_20_0 ~= "" and self._assistantVoiceInfo["talk" .. iter_20_0 .. "_sound"] ~= "" then
			table.insert(self._talkLines, {
				text = var_20_0,
				voice = self._assistantVoiceInfo["talk" .. iter_20_0 .. "_sound"],
				action = self._assistantVoiceInfo["talk" .. iter_20_0 .. "_action"]
			})
		end
	end

	local var_20_1 = var_0_7.knightsData:getKnight({
		base_id = self._assistantId
	})

	if not var_20_1:isMain() then
		local var_20_2 = var_20_1:getFavoLevel()
		local var_20_3 = g.core.config.knight_favorability_info.get(var_20_1:getAdvanceId())

		for iter_20_1 = 1, self._MAX_FAVORABILITY_LINES_NUM do
			if var_20_2 >= var_20_3["lines_unlock_" .. iter_20_1] then
				local var_20_4 = KnightVoiceCommon.getVoiceLinesStr(self._assistantVoiceInfo, "favorite" .. iter_20_1 .. "_lines")

				if var_20_4 ~= "" and self._assistantVoiceInfo["favorite" .. iter_20_1 .. "_sound"] ~= "" then
					table.insert(self._talkLines, {
						text = var_20_4,
						voice = self._assistantVoiceInfo["favorite" .. iter_20_1 .. "_sound"],
						action = self._assistantVoiceInfo["favorite" .. iter_20_1 .. "_action"]
					})
				end
			else
				break
			end
		end
	end

	for iter_20_2, iter_20_3 in g.core.config.knight_show_day_info.ipairs() do
		if self:_isHoliday(iter_20_3.type, iter_20_3.data) then
			local var_20_5, var_20_6, var_20_7 = self:_getHolidaySoundData(iter_20_3.id)

			if var_20_5 ~= "" and var_20_6 ~= "" then
				table.insert(self._talkLines, {
					text = var_20_5,
					voice = var_20_6,
					action = var_20_7
				})
			end
		end
	end

	if var_0_7.weddingData:isWeddingVowByKnightId(var_20_1:getAdvanceId()) then
		table.insert(self._talkLines, {
			text = KnightVoiceCommon.getVoiceLinesStr(self._assistantVoiceInfo, "vow_lines"),
			voice = self._assistantVoiceInfo.vow_sound,
			action = self._assistantVoiceInfo.vow_action
		})
	end

	self._linesIndex = math.random(#self._talkLines)
end

function HomeAssistantComp:_isHoliday(arg_21_1, arg_21_2)
	local var_21_0 = false

	if arg_21_1 == 1 then
		var_21_0 = var_0_10:checkTodayIsHolidayYMD(arg_21_2)
	elseif arg_21_1 == 2 then
		var_21_0 = var_0_10:checkTodayIsHolidayMD(arg_21_2)
	elseif arg_21_1 == 3 then
		local var_21_1 = var_0_7.knightsData:getKnight({
			base_id = self._assistantId
		})

		if not var_21_1:isMain() then
			local var_21_2 = g.core.config.knight_favorability_info.get(var_21_1:getAdvanceId())

			var_21_0 = var_0_10:checkTodayIsHolidayMD(var_0_9:formatTo02d(var_21_2.brithday_month) .. var_0_9:formatTo02d(var_21_2.brithday_day))
		end
	elseif arg_21_1 == 4 then
		local var_21_3, var_21_4 = var_0_9:getFormatBirthMonthDay()

		var_21_0 = var_0_10:checkTodayIsHolidayMD(var_21_3 .. var_21_4)
	end

	return var_21_0
end

function HomeAssistantComp:_moveAssistantBegin()
	self._assistantMoveStarPos = self.m_knightComp:getPosition()
end

function HomeAssistantComp:_moveAssistant(arg_23_1)
	local var_23_0 = cc.p(0, 0)

	var_23_0.x = arg_23_1.x + self._assistantMoveStarPos.x
	var_23_0.y = arg_23_1.y + self._assistantMoveStarPos.y

	self.m_knightComp:setPosition(var_23_0)
end

function HomeAssistantComp:_setAssistantScale(arg_24_1)
	self.m_knightComp:setScale(arg_24_1)
end

function HomeAssistantComp:_resetAssistant()
	if self._isInAssistantTemp then
		self.m_knightComp:setScale(self._nominateInfo.scale)
		self.m_knightComp:setPosition({
			x = self._nominateInfo.x,
			y = self._nominateInfo.y
		})

		return
	end

	self._assistantScale = AssistantCommon.defaultData.assistantScale
	self._assistantPos = AssistantCommon.defaultData.assistantPos

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ASSISTANT_ADV) then
		local var_25_0 = g.core.model.User:getNominateInfoByIndex(self._curAdvIndex)

		self._assistantScale = var_25_0.scale
		self._assistantPos = {
			x = var_25_0.x,
			y = var_25_0.y
		}
	end

	self.m_knightComp:setScale(self._assistantScale)
	self.m_knightComp:setPosition(self._assistantPos)
	self:_updateTrans()
end

function HomeAssistantComp:_confirmAssistant()
	if self._isInAssistantTemp then
		local var_26_0 = self.m_knightComp:getPosition()

		g.core.model.User:updateNominateInfo(self._nominateInfo.advanceId, {
			scale = self.m_knightComp:getScaleX(),
			x = var_26_0.x,
			y = var_26_0.y
		})
		self:resetAssistantToReal()
		g.core.network.GameNetProxy:send_C2S_ShowKnight_Set({
			show_knights = g.core.model.User:packNominateServerList()
		})

		return
	end

	self._assistantScale = self.m_knightComp:getScaleX()
	self._assistantPos = self.m_knightComp:getPosition()

	local var_26_1 = AssistantCommon.getAssistantData()

	var_26_1.assistantScale = self._assistantScale
	var_26_1.assistantPos = self._assistantPos

	AssistantCommon.setAssistantData(var_26_1)
	self:_updateTrans()
end

function HomeAssistantComp:_changeScene(arg_27_1)
	self.m_bgLoader:setURL("bg/home/" .. arg_27_1 .. ".jpg")
end

function HomeAssistantComp:_resetScene()
	local var_28_0 = var_0_7.userActiveSceneData:getSceneId()

	self.m_bgLoader:setURL("bg/home/" .. g.core.config.bg_book_info.get((g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ASSISTANT_ADV) or nil) and g.core.model.User:getNominateInfoByIndex(self._curAdvIndex).bg).pic .. ".jpg")
end

function HomeAssistantComp:_showLines()
	if self._isInSpecialTouchSound or self._isInSpecialTouchAction or self._isInSpecialShowAction then
		return
	end

	if self:_showSpecialShowLines() then
		return
	end

	if self._linesType == self._LINES_TYPE.LOGIN then
		self:_showLoginLines()
	elseif self._linesType == self._LINES_TYPE.ASSISTANT then
		self:_showAssistantLines()
	elseif self._linesType == self._LINES_TYPE.TOUCH then
		self:_showTouchLines()
	elseif self._linesType == self._LINES_TYPE.SPECIAL_TOUCH then
		self:_showSpecialTouchLines()
	else
		self:_showTalkLines()
	end
end

function HomeAssistantComp:_setSound(arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	self._isPlaySound = true

	self.m_touchBg:setTouchable(false)

	if arg_30_2 == "" then
		self._isInSpecialTouchSound = false
	else
		KnightVoiceCommon.playVoice({
			voiceName = arg_30_2,
			func = handler(self, self._soundEnd)
		})
	end

	if arg_30_1 == "" then
		self._talkGroup:setVisible(false)
	else
		self._talkGroup:setVisible(true)
		self.m_linesText:setText(arg_30_1)
	end

	if arg_30_3 and self._showKnight then
		self._changeAction = true

		if arg_30_3 == var_0_4.ACTION.SHOW then
			self._showKnight:playSpecialShowAction(self.m_movieComp, nil, arg_30_4, handler(self, self._showTransEffect))
		else
			self._showKnight:playAction(arg_30_3, arg_30_4)
		end
	else
		self._changeAction = false
	end

	if self._linesType == self._LINES_TYPE.TALK then
		self._linesIndex = self._linesIndex + 1 > #self._talkLines and 1 or self._linesIndex + 1
	end

	if self._canTouchSchedule then
		self:cancelSchedule(self._canTouchSchedule)

		self._canTouchSchedule = nil
	end

	self._canTouchSchedule = self:newScheduleOnce(handler(self, self._onCanTouch), 0.5)
end

function HomeAssistantComp:_showTransEffect()
	self.m_effectComp:addEffectSpine({
		name = "eff_ui_home_trans",
		remove = true,
		isLoop = false
	})
end

function HomeAssistantComp:_onCanTouch()
	self.m_touchBg:setTouchable(true)
end

function HomeAssistantComp:_soundEnd()
	self._isInSpecialTouchSound = false

	if self._isPlaySound then
		self._isPlaySound = false
		self._nowModuleTime = 0

		self.m_touchBg:setTouchable(true)
		self._talkGroup:setVisible(false)
	end
end

function HomeAssistantComp:getSoundData(arg_34_1)
	return KnightVoiceCommon.getVoiceLinesStr(self._assistantVoiceInfo, arg_34_1 .. "_lines"), self._assistantVoiceInfo[arg_34_1 .. "_sound"], self._assistantVoiceInfo[arg_34_1 .. "_action"]
end

function HomeAssistantComp:_showLoginLines()
	local var_35_1, var_35_2, var_35_3 = self:getSoundData(g.core.common.ServerTime:checkTimeAreaByTypeT(50, 1200) and "time1" or g.core.common.ServerTime:checkTimeAreaByTypeT(1200, 1900) and "time2" or "time3")

	for iter_35_0, iter_35_1 in g.core.config.knight_show_day_info.ipairs() do
		local var_35_4

		if self:_isHoliday(iter_35_1.type, iter_35_1.data) then
			if HomeConst.VOICE_PREFERENCE[HomeConst.TYPE_TO_VOICE_PREFERENCE[iter_35_1.type]] > HomeConst.VOICE_PREFERENCE.NONE then
				var_35_4 = HomeConst.TYPE_TO_VOICE_PREFERENCE[iter_35_1.type]
				var_35_1, var_35_2, var_35_3 = self:_getHolidaySoundData(iter_35_1.id)

				if iter_35_1.type == 4 then
					break
				end
			end
		end
	end

	self:_setSound(var_35_1, var_35_2, var_35_3)
end

function HomeAssistantComp:_showSpecialShowLines()
	if self._assistantBaseInfo and self._assistantBaseInfo.knight_show == 1 and require("app.view.module.home.common.HomeModuleAutoPopup").isShowAllPopToday() and self._isChangeAssistant then
		self._isChangeAssistant = false

		var_0_7:setSpecialShowPlayed(self._assistantBaseInfo.id)

		self._isInSpecialShowAction = true

		self:_setSound("", "", var_0_4.ACTION.SHOW, handler(self, self._onSpecialShowActionEnd))

		return true
	end
end

function HomeAssistantComp:_onSpecialShowActionEnd()
	self._isInSpecialShowAction = false

	self.m_enterTransition:changeParams({
		scale01 = {
			self._assistantScale * 2,
			self._assistantScale * 2
		},
		scale02 = {
			self._assistantScale,
			self._assistantScale
		},
		scaleBg01 = {
			self._bgScale * 2,
			self._bgScale * 2
		},
		scaleBg02 = {
			self._bgScale,
			self._bgScale
		}
	})
	self.m_enterTransition:play()
end

function HomeAssistantComp:_getHolidaySoundData(arg_38_1)
	local var_38_1 = self._assistantVoiceInfo["day" .. arg_38_1 .. "_action"]

	if not self._assistantVoiceInfo["day" .. arg_38_1 .. "_action"] or var_38_1 == "" then
		var_38_1 = self._assistantVoiceInfo.set_action
	end

	return KnightVoiceCommon.getVoiceLinesStr(self._assistantVoiceInfo, "day" .. self:_fetchSpringFestivalId(arg_38_1) .. "_lines"), self._assistantVoiceInfo["day" .. arg_38_1 .. "_sound"], var_38_1
end

function HomeAssistantComp:_fetchSpringFestivalId(arg_39_1)
	if arg_39_1 == 13 or arg_39_1 == 14 or arg_39_1 == 15 then
		arg_39_1 = 12
	end

	return arg_39_1
end

function HomeAssistantComp:_showSpecialTouchLines()
	self._isInSpecialTouchSound = true
	self._isInSpecialTouchAction = true

	local var_40_0 = self._specialTouchIndex

	self:_setSound(KnightVoiceCommon.getVoiceLinesStr(self._assistantVoiceInfo, "special_lines_" .. self._specialTouchIndex), self._assistantVoiceInfo["special_sound_" .. self._specialTouchIndex], self._assistantVoiceInfo["special_action_" .. self._specialTouchIndex], handler(self, self._specialTouchActionEnd))

	if tostring(self._assistantVoiceInfo["bg_special_" .. var_40_0]) == "1" and self._showKnight then
		self._showKnight:playBgSpecialAction("special")
	end
end

function HomeAssistantComp:_specialTouchActionEnd()
	self._isInSpecialTouchAction = false

	if DebugCommon.getDebugGlobalValueByKey("wedding_action_hide_ui") then
		self:dispatchCompEvent("EVENT_HOME_SHOW_UI")
	end
end

function HomeAssistantComp:_showTouchLines()
	local var_42_0, var_42_1, var_42_2 = self:getSoundData("touch")

	self:_setSound(var_42_0, var_42_1, var_42_2)
end

function HomeAssistantComp:_showAssistantLines()
	local var_43_0, var_43_1, var_43_2 = self:getSoundData("set")

	self:_setSound(var_43_0, var_43_1, var_43_2)
end

function HomeAssistantComp:_showTalkLines()
	if self._linesIndex and self._talkLines then
		if self._talkLines[self._linesIndex] then
			self:_setSound(self._talkLines[self._linesIndex].text, self._talkLines[self._linesIndex].voice, self._talkLines[self._linesIndex].action)
		end
	end
end

function HomeAssistantComp:_onCrossDayUpdate()
	if not tolua.isnull(self) and self._getTalkLines then
		self:_getTalkLines()
		self:_fetchTodayBirthDayAdvId()
	end
end

function HomeAssistantComp:onUnload()
	self:_soundEnd()

	self._isInSpecialTouchAction = false

	if self._isInSpecialShowAction then
		self._isInSpecialShowAction = false

		self:_showLines()
		self._showKnight:playBgAction()
	end

	KnightVoiceCommon.stopVoice()
	self:cancelSchedule(self._handler)

	self._handler = nil
end

function HomeAssistantComp:setTalkLine(arg_47_1, arg_47_2)
	self._talkGroup = arg_47_1
	self.m_linesText = arg_47_2
end

return HomeAssistantComp
