local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local DebugGameSetComp = class("DebugGameSetComp", require("app.fairyGUI.debug.UI_DebugGameSetComp"))

function DebugGameSetComp:ctor()
	self:_init()
end

function DebugGameSetComp:_init()
	self.m_lowQualityBtn:addClickListener(handler(self, self._onQualityBtnClicked))
	self.m_midQualityBtn:addClickListener(handler(self, self._onQualityBtnClicked))
	self.m_highQualityBtn:addClickListener(handler(self, self._onQualityBtnClicked))
	self.m_changeTextureBtn:addClickListener(handler(self, self._onChangeTextureBtnClicked))
	self.m_btn_speed:addClickListener(handler(self, self._onSpeedBtnClick))
	self.m_enterGuide:addClickListener(handler(self, self._onEnterGuideClick))
	self.m_guideStepSetBtn:addClickListener(handler(self, self._onShowSetStepPop))
	self.m_guideLogBtn:addClickListener(handler(self, self._onGuideLogCompClick))
	self.m_removeSnapShotBtn:addClickListener(handler(self, self._clearSnapShot))
	self.m_touchGameBtn:addClickListener(handler(self, self._onTouchGameBtnClick))
	self.m_puzzleGameBtn:addClickListener(handler(self, self._onPuzzleBtnClick))
	self.m_playSoundBtn:addClickListener(handler(self, self._onPlaySoundBtnClick))
	self.m_serverInsertBtn:addClickListener(handler(self, self._onServerInsertBtnClick))
	self.m_loadBattleBnkBtn:addClickListener(handler(self, self._onLoadBattleBnkBtnClicked))

	local var_2_0 = DebugCommon.getDebugGlobalValueByKey("game_time_scale")

	if var_2_0 then
		if cc.Director:getInstance():getScheduler().setTimeScaleJ then
			cc.Director:getInstance():getScheduler():setTimeScaleJ(var_2_0)
		else
			cc.Director:getInstance():getScheduler():setTimeScale(var_2_0)
		end
	end

	self.m_txt_speed:setText(var_2_0)
	self.m_channelGameBtn:addClickListener(handler(self, self._onChannelBtnClick))
	self.m_searchComp:updatePaths("channels")

	local var_2_1 = g.core.platform.PlatformProxy:getCurChannel()

	self.m_searchComp:setShowText((var_2_1.debugName or var_2_1.name) .. "_" .. config.SPECIFIC_OP_ID)
	self:addListen(self.m_searchComp)
end

function DebugGameSetComp:_onSpeedBtnClick()
	local var_3_0 = tonumber(self:getChild("txt_speed"):getText())

	if not var_3_0 then
		return
	end

	if cc.Director:getInstance():getScheduler().setTimeScaleJ then
		cc.Director:getInstance():getScheduler():setTimeScaleJ(var_3_0)
	else
		cc.Director:getInstance():getScheduler():setTimeScale(var_3_0)
	end

	DebugCommon.setDebugGlobalValueByKey("game_time_scale", var_3_0)
end

function DebugGameSetComp:_onShowSetStepPop()
	g.core.module.ModuleManager:pushPopup((require("debug.guide.DebugGuideSetStepPop").new()))
end

function DebugGameSetComp:_onGuideLogCompClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.debug.pop.ComGuideLogPop").new()))
end

function DebugGameSetComp:_onEnterGuideClick()
	g.core.module.ModuleManager:pushPopup((require("debug.guide.DebugGuideSetStepPop").new()))
end

function DebugGameSetComp:onLoad()
	local var_7_0 = g.core.common.Setting:getQualityConfig()

	self._qualityIdx = var_7_0

	if var_7_0 == 0 then
		self:_onQualityBtnSelected(self.m_lowQualityBtn)
	elseif var_7_0 == 1 then
		self:_onQualityBtnSelected(self.m_midQualityBtn)
	elseif var_7_0 == 2 then
		self:_onQualityBtnSelected(self.m_highQualityBtn)
	end

	self.m_changeTextureBtn:setSelected(g.core.const.ConstMgr.BASE_CONST.OPEN_TEXTURE_CHANGE)
end

function DebugGameSetComp:onShow()
	self:setVisible(true)
end

function DebugGameSetComp:onHide()
	self:setVisible(false)
end

function DebugGameSetComp:_onQualityBtnClicked(arg_10_1)
	self:_onQualityBtnSelected((arg_10_1:getSender()))
end

function DebugGameSetComp:_onChangeTextureBtnClicked(arg_11_1)
	g.core.const.ConstMgr.BASE_CONST.OPEN_TEXTURE_CHANGE = not g.core.const.ConstMgr.BASE_CONST.OPEN_TEXTURE_CHANGE
end

function DebugGameSetComp:_onQualityBtnSelected(arg_12_1)
	local var_12_0 = arg_12_1:getName()

	if self._lastQualityBtn then
		self._lastQualityBtn:setSelected(false)
	end

	local var_12_1 = 0

	if var_12_0 == "lowQualityBtn" then
		var_12_1 = 0
	elseif var_12_0 == "midQualityBtn" then
		var_12_1 = 1
	elseif var_12_0 == "highQualityBtn" then
		var_12_1 = 2
	end

	arg_12_1:setSelected(true)

	self._lastQualityBtn = arg_12_1

	if self._qualityIdx ~= var_12_1 then
		g.core.common.Setting:setQualityLevel(var_12_1)
		g.core.module.ModuleManager:tip(g.core.lang:get(1192))
		g.core.utils.Sdk.changeDevicePerformance()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHANGE_DEVICE_PERFORMANCE, false, var_12_1)

		self._qualityIdx = var_12_1
	end
end

function DebugGameSetComp:_onTouchGameBtnClick()
	local var_13_0 = self.m_touchGameIdInput:getText()

	var_13_0 = var_13_0 and var_13_0 ~= "" and tonumber(var_13_0) or g.core.config.game_touch_event_info.indexOf(1).id

	dump(var_13_0)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.touchGame.view.TouchGameLayer").new({
		gameId = var_13_0
	}))
end

function DebugGameSetComp:_onPlaySoundBtnClick()
	local var_14_0 = self.m_inputSoundTxt:getText()

	dump(var_14_0)
	g.core.sound.SoundManager:playSound(var_14_0)
end

function DebugGameSetComp:_onPuzzleBtnClick()
	local var_15_1 = self.m_puzzleGameIdInput:getText()

	g.core.module.ModuleManager:pushModule(g.view.entrance.PUZZLE_GAME, {
		level = (var_15_1 and tonumber(var_15_1) ~= nil or nil) and tonumber(var_15_1)
	})
end

function DebugGameSetComp:_onChannelBtnClick()
	local var_16_0 = 2
	local var_16_1 = self.m_channelGameIdInput:getText()

	if var_16_1 and tonumber(var_16_1) ~= nil then
		var_16_0 = tonumber(var_16_1)
	end

	self:_save("channelDebug.json", {
		channel = var_16_0
	}, false)

	if not config.SUPERSDK_ENABLED then
		config.SPECIFIC_GAME_ID = ({
			2013001,
			2013005,
			2013003,
			2013000,
			2013002,
			2013004
		})[var_16_0]

		self:_save("gameIdDebug.json", {
			gameId = config.SPECIFIC_GAME_ID
		}, false)
	end
end

function DebugGameSetComp:_onLoadBattleBnkBtnClicked(arg_17_1)
	assert(false, "需要改成多一个输入框单位编号或选择框 来确定是哪个单位的声音")
end

function DebugGameSetComp:_save(arg_18_1)
	g.core.common.Storage:save(arg_18_1, ...)
end

function DebugGameSetComp:_load(arg_19_1)
	return g.core.common.Storage:load(arg_19_1, ...) or {}
end

function DebugGameSetComp:_onServerInsertBtnClick()
	local var_20_0 = self.m_serverInsertInput:getText()
	local var_20_1 = {}

	if var_20_0 and #var_20_0 > 1 then
		local var_20_2 = json.decode(var_20_0)

		if g.core.platform.ServerListProxy:checkAndFixServerInfo(var_20_2) then
			table.insert(var_20_1, var_20_2)
		end
	else
		var_20_1 = json.decodeFileIfExists("server_list.json") or {}
	end

	g.core.platform.ServerListProxy:addDebugList(var_20_1)
end

function DebugGameSetComp:receiveCompEvent(arg_21_1, arg_21_2)
	if arg_21_1 == "EVENT_DEBUG_INPUT_CHANGE" then
		local var_21_0
		local var_21_1

		if arg_21_2 == "channels" then
			var_21_0, var_21_1 = self.m_searchComp:getShowText()
		end

		if var_21_0 then
			self:_changeChannel(var_21_1)
		end
	end
end

function DebugGameSetComp:_changeChannel(arg_22_1)
	local var_22_0

	for iter_22_0, iter_22_1 in pairs(require("app.core.platform.const.ChannelConst").ValueConst[2013001][arg_22_1]) do
		var_22_0 = iter_22_0

		break
	end

	config.SPECIFIC_OP_GAME_ID = var_22_0
	config.SPECIFIC_OP_ID = arg_22_1
end

function DebugGameSetComp:_clearSnapShot()
	g.core.model.User.snapShotCacheData:clearData()
end

return DebugGameSetComp
