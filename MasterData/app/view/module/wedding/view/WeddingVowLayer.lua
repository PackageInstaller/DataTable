local TypeWriter = require("app.view.common.TypeWriter")
local var_0_1 = g.core.config.skin_info
local var_0_2 = g.core.config.knight_base_info
local var_0_3 = g.core.const.ConstMgr.WeddingConst
local var_0_4 = g.core.config.wedding_vow_info
local var_0_5 = g.core.const.ConstMgr.SpineConst
local var_0_6 = g.core.model.User.knightsData
local DrawKnight = require("app.view.common.DrawKnight")
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local WeddingVowLayer = class("WeddingVowLayer", require("app.fairyGUI.wedding.UI_WeddingVowLayer"), function()
	return fgui.GComponent:create({
		resName = "WeddingVowLayer",
		pkgPath = "ui/wedding/wedding",
		isFullScreen = true,
		pkgName = "wedding"
	}, ...)
end)

function WeddingVowLayer:ctor(arg_2_1, arg_2_2)
	if arg_2_1.knightStruct then
		self._knightStruct = arg_2_1.knightStruct
	elseif arg_2_1 then
		self._knightStruct = var_0_6:getKnight(arg_2_1)
	end

	self._isFirst = arg_2_2
	self._advId = self._knightStruct:getAdvanceId()
	self._vowInfo = var_0_4.get(self._advId)
	self._showKnightComp = nil
	self._spriteNode = nil
	self._handState = var_0_3.HAND_STATE.IN
	self._handSpine = nil
	self._eggIsFinish = false
	self._avgAllIsFinish = false
	self._avgWriterIsFinish = false
	self._avgActionIsFinish = false
	self._avgSoundIsFinish = false
	self._isInAvg = false
	self._isClose = false
	self._isWeddingFinish = false
	self._labelComp = self.m_dialogComp:getChild("dialogTxt")
	self._actionSequence = {}

	self:addListen(self.m_asmrComp)
	self:initView()
	self:addOpenDoorMovie()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_Wedding)
end

function WeddingVowLayer:initView()
	self.m_dialogComp:setVisible(false)
	self.m_touchComp:setVisible(false)
	self.m_touchComp:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_touchComp:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function WeddingVowLayer:_onTouchBegin(arg_4_1)
	arg_4_1:captureTouch()

	self._startPos = arg_4_1:getInput():getTouch():getLocation()

	self.m_guidePlace:setVisible(false)
end

function WeddingVowLayer:_onTouchEnd(arg_5_1)
	if self._startPos then
		self._startPos = nil

		if arg_5_1:getInput():getTouch():getLocation().y - self._startPos.y >= var_0_3.TOUCH_OFF_Y then
			g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Wedding_RingClick)
			self:_playHandOn()
		else
			self.m_guidePlace:setVisible(true)
		end
	end
end

function WeddingVowLayer:addOpenDoorMovie()
	self.m_movieComp:addCriSprite({
		autoRemove = true,
		movieName = "wedding_1920x1080_967",
		isLoop = false,
		y = 0,
		moduleName = "wedding",
		x = 0,
		fullScreenState = 1,
		listener = handler(self, self._onOpenDoorEvent)
	})
	self.m_enterTransition:setHook("showKnight", handler(self, self._openDoorEnd))
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_WeddingDoor_Open)
end

function WeddingVowLayer:_onOpenDoorEvent(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_1 == "complete" then
		self:_openDoorEnd()
	end
end

function WeddingVowLayer:_openDoorEnd()
	self.m_bgLoader:setURL("bg/wedding/" .. self._vowInfo.scene .. ".jpg")

	if self._vowInfo.skin > 0 then
		local var_8_2 = var_0_2.get(var_0_1.get(self._vowInfo.skin).res)

		self._showKnightComp = DrawKnight.new({
			isShowBg = false,
			scale = 1,
			skinId = self._vowInfo.skin,
			resBgId = var_8_2.painted_bg_id
		})
	else
		local var_8_4 = self._knightStruct:getResInfo()

		self._showKnightComp = DrawKnight.new({
			scale = 1,
			isShowBg = false,
			resId = var_8_4.painted_id,
			resBgId = var_8_4.painted_bg_id
		})
	end

	self.m_knightComp:addChild(self._showKnightComp)
	self._showKnightComp:playAction(var_0_5.DRAW_ACTION.SHY, handler(self, self._spineShyEnd))
end

function WeddingVowLayer:_spineShyEnd()
	self:newScheduleOnce(handler(self, self._addHandSpine), 1)
end

function WeddingVowLayer:_addWeakGuideComp()
	fgui.UIPackage:addPackage("ui/guide/guide")

	local var_10_0 = fgui.UIPackage:createObject("guide", "GuideTouchComp")

	var_10_0:setTouchable(false)
	var_10_0:updateView(nil, {
		centerPos = cc.p(0, 100),
		centerPos1 = cc.p(0, 0)
	}, true, false, true)
	var_10_0:setY(-100)
	self.m_guidePlace:addChild(var_10_0)
end

function WeddingVowLayer:_addHandSpine()
	self._showKnightComp:setVisible(false)

	self._handState = var_0_3.HAND_STATE.IN
	self._handSpine = self.m_handEffect:addEffectSpine({
		name = "wedding_ring",
		isLoop = false,
		anim = self._handState .. self._vowInfo.hand,
		eventHandler = handler(self, self._onHandSpineEvent)
	})

	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Wedding_HandShow)
end

function WeddingVowLayer:_onHandSpineEvent(arg_12_1)
	if arg_12_1.type == "complete" then
		if self._handState == var_0_3.HAND_STATE.IN then
			self:_playHandIdle()
		elseif self._handState == var_0_3.HAND_STATE.ON then
			self:_handOnEnd()
		end
	end
end

function WeddingVowLayer:_handOnEnd()
	self.m_handEffect:runFGAction((fgui.FSequence:create(fgui.FFadeOut:create(0.2), (fgui.FCallFunc:create(handler(self, self._onHandSpineFadeOutEnd))))))
	self:_getActionSequence()
	self:checkPlayAvgOrSpecialAction()
end

function WeddingVowLayer:_onHandSpineFadeOutEnd()
	if self._handSpine then
		self._handSpine:dispose()

		self._handSpine = nil
	end
end

function WeddingVowLayer:_playHandIdle()
	self._handState = var_0_3.HAND_STATE.IDLE

	self._handSpine:setAnimation(0, self._handState .. self._vowInfo.hand, true)
	self.m_touchComp:setVisible(true)
	self:newScheduleOnce(handler(self, self._addWeakGuideComp), var_0_3.TOUCH_GUIDE_TIME)
end

function WeddingVowLayer:_playHandOn()
	self:cancelAllSchedule()
	self.m_touchComp:setVisible(false)
	self.m_guidePlace:setVisible(false)

	self._handState = var_0_3.HAND_STATE.ON

	self._handSpine:setAnimation(0, self._handState .. self._vowInfo.hand, false)
	self:newScheduleOnce(function()
		g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Wedding_RingSuccess)
	end, 1.6666666666666667)
end

function WeddingVowLayer:_getActionSequence()
	self._actionSequence = {}

	table.insert(self._actionSequence, {
		action = handler(self, self._playAvg),
		order = self._vowInfo.action_order
	})

	if self._vowInfo.egg_action ~= "" then
		table.insert(self._actionSequence, {
			action = handler(self, self._playEggAction),
			order = self._vowInfo.egg_action_order
		})
	end

	if self._vowInfo.asmr ~= "" then
		table.insert(self._actionSequence, {
			action = handler(self, self._playAsmr),
			order = self._vowInfo.asmr_order
		})
	end

	table.sort(self._actionSequence, function(arg_19_0, arg_19_1)
		return arg_19_0.order < arg_19_1.order
	end)
end

function WeddingVowLayer:checkPlayAvgOrSpecialAction()
	local var_20_0 = table.remove(self._actionSequence, 1)

	if var_20_0 then
		var_20_0.action()
	else
		self:weddingVowEnd()
	end
end

function WeddingVowLayer:_playAvg()
	self._isInAvg = true

	self._showKnightComp:setVisible(true)
	self.m_dialogComp:setVisible(true)
	self.m_dialogComp:getTransition("enter"):play(handler(self, self._startWriterAndSoundAndAction))
end

function WeddingVowLayer:_startWriterAndSoundAndAction()
	local var_22_0 = g.core.config.knight_show_info.fetch(self._knightStruct:getBaseInfo().res_id)

	if var_22_0.vow_sound ~= "" and g.core.sound.SoundManager.VOICE == true then
		if g.core.model.User.splitDownloadData:isShowDownloadListPop() then
			self:newScheduleOnce(handler(self, self._avgSoundEnd), 5)
		else
			KnightVoiceCommon.playVoice({
				voiceName = var_22_0.vow_sound,
				func = handler(self, self._avgSoundEnd)
			})
		end
	else
		self:_avgSoundEnd()
	end

	local var_22_1

	if var_22_0.vow_action ~= "" then
		self._showKnightComp:playAction(var_22_0.vow_action, handler(self, self._avgActionEnd))
	else
		self:_avgActionEnd()

		var_22_1 = {
			label = self._labelComp
		}
	end

	var_22_1.str = KnightVoiceCommon.getVoiceLinesStr(var_22_0, "vow_lines")
	var_22_1.callback = handler(self, self._avgWriterEnd)
	self._typeWriter = TypeWriter.new(var_22_1)

	self._typeWriter:start()
end

function WeddingVowLayer:_avgWriterEnd()
	self._labelComp:cancelAllSchedule()

	self._typeWriter = nil
	self._avgWriterIsFinish = true

	self:_checkAvgIsEnd()
end

function WeddingVowLayer:_avgActionEnd()
	self._avgActionIsFinish = true

	self:_checkAvgIsEnd()
end

function WeddingVowLayer:_avgSoundEnd()
	self._avgSoundIsFinish = true

	self:_checkAvgIsEnd()
end

function WeddingVowLayer:_checkAvgIsEnd()
	if self._avgSoundIsFinish and self._avgActionIsFinish and self._avgWriterIsFinish then
		self:newScheduleOnce(handler(self, self._actionEnd), 1)
	end
end

function WeddingVowLayer:_actionEnd()
	self._isInAvg = false
	self._avgAllIsFinish = true

	self.m_dialogComp:getTransition("hide"):play(handler(self, self._hideWriter))
	self:checkPlayAvgOrSpecialAction()
end

function WeddingVowLayer:_hideWriter()
	self.m_dialogComp:setVisible(false)
end

function WeddingVowLayer:_playEggAction()
	if self._showKnightComp:getKnightSpine():isHaveNodeForSlot("BG_wedding") then
		local var_29_0 = self._showKnightComp:getKnightSpine():getNodeForSlot("BG_wedding")

		if var_29_0 then
			self._spriteNode = display.newSprite("bg/wedding/" .. self._vowInfo.scene .. ".jpg")

			var_29_0:addChild(self._spriteNode, -1)
		end
	end

	self._showKnightComp:playAction(self._vowInfo.egg_action, handler(self, self._eggActionEnd))
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_WeddingKiss)
end

function WeddingVowLayer:_eggActionEnd()
	if self._spriteNode then
		self._spriteNode:setVisible(false)
		self._spriteNode:removeFromParent()

		self._spriteNode = nil
	end

	self._eggIsFinish = true

	self:checkPlayAvgOrSpecialAction()
end

function WeddingVowLayer:weddingVowEnd()
	self._isWeddingFinish = true

	self:newScheduleOnce(handler(self, self._onClickClose), 1)
end

function WeddingVowLayer:openPop()
	if self._isFirst then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.wedding.view.WeddingSuccessPop").new({
			knightStruct = self._knightStruct
		})))
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.WEDDING_MAIN_POP, {
			knightStruct = self._knightStruct
		}, true, false)
	end
end

function WeddingVowLayer:_onClickClose()
	if self._isClose or not self._isWeddingFinish then
		return
	end

	self._isClose = true

	self:openPop()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function WeddingVowLayer:_playAsmr()
	self.m_asmrComp:initAsmr(self._knightStruct)
	self.m_asmrComp:setVisible(true)
end

function WeddingVowLayer:receiveCompEvent(arg_35_1)
	if arg_35_1 == "ASMR_PLAY_END" then
		dump("ASMR_PLAY_END-----------------------")
		self:checkPlayAvgOrSpecialAction()
	end
end

return WeddingVowLayer
