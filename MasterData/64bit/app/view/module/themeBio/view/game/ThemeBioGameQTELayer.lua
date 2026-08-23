local var_0_0 = g.core.model.User.themeData
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_2 = g.core.const.ConstMgr.ThemeBioMapConst
local var_0_3 = g.core.config.theme_biography_event_info
local var_0_4 = g.core.event
local var_0_5 = BattleConst.SPINE_ACTION_TYPE
local ThemeBioGameQTELayer = class("ThemeBioGameQTELayer", require("app.fairyGUI.themeBio.UI_ThemeBioGameQTELayer"), function()
	return fgui.GComponent:create({
		resName = "ThemeBioGameQTELayer",
		pkgName = "themeBio",
		isFullScreen = true,
		pkgPath = "ui/themeBio/themeBio"
	}, ...)
end)

function ThemeBioGameQTELayer:ctor(arg_2_1, arg_2_2)
	self._missionId = arg_2_1
	self._activeThemeValue = arg_2_2 or 1
	self._themeBioData = var_0_0:getThemeData(self._activeThemeValue):getThemeBioData()
	self._spine = nil
	self._isDone = false
	self._circleList = {}
	self._appearTime = 0
	self._schedule = nil

	self:_initView()
end

function ThemeBioGameQTELayer:onLoad()
	var_0_4.EventManager:dispatchEvent(var_0_4.enum.EVENT_BIO_SET_HUDUI_SHOW, false, false)
end

function ThemeBioGameQTELayer:onUnload()
	self:_clearSchedule()
	var_0_4.EventManager:dispatchEvent(var_0_4.enum.EVENT_BIO_SET_HUDUI_SHOW, false, true)
end

function ThemeBioGameQTELayer:_initView()
	local var_5_0 = var_0_3.get(self._themeBioData:getMission(self._missionId).sub_id)

	self.m_infoComp:updateEventInfo(var_5_0)

	self._spine = self.m_iconHolderComp:addEffectSpine({
		isLoop = false,
		name = var_5_0.pic,
		anim = var_0_5.IN,
		eventHandler = handler(self, self._onSpineEvent)
	})
	self._appearTime = var_5_0.event_value_5 / 1000
	self._schedule = self:newSchedule(handler(self, self._onCreateSchedule), var_5_0.event_value_4 / 1000)
end

function ThemeBioGameQTELayer:_onCreateSchedule()
	local var_6_0 = fgui.UIPackage:createObject("base", "BasePlaceHolderComp2", self)

	var_6_0:setSize(100, 100)
	var_6_0:addClickListener(handler(self, self._onValueChangeClick))
	self:addChild(var_6_0)

	local var_6_1, var_6_2 = self:getIconPos()

	var_6_0:setPosition(var_6_1, var_6_2)
	table.insert(self._circleList, var_6_0)
	var_6_0:addEffectSpine({
		name = "eff_ui_bio_click",
		isLoop = true,
		x = 48,
		y = 45
	})
	var_6_0:runFGAction((fgui.FSequence:create({
		fgui.FDelayTime:create(self._appearTime),
		fgui.FCallFunc:create(function()
			self:removeIcon(var_6_0)
		end)
	})))
end

function ThemeBioGameQTELayer:_clearSchedule()
	if self._schedule then
		self:cancelSchedule(self._schedule)

		self._schedule = nil

		for iter_8_0, iter_8_1 in ipairs(self._circleList) do
			iter_8_1:removeFromParent()
		end

		self._circleList = {}
	end
end

function ThemeBioGameQTELayer:removeIcon(arg_9_1)
	if arg_9_1 then
		arg_9_1:removeFromParent()

		for iter_9_0, iter_9_1 in ipairs(self._circleList) do
			if arg_9_1 == iter_9_1 then
				table.remove(self._circleList, iter_9_0)

				return
			end
		end
	end
end

function ThemeBioGameQTELayer:getIconPos()
	local var_10_0 = math.random(var_0_2.GAME_QTE_POS_END.x - var_0_2.GAME_QTE_POS_START.x) + var_0_2.GAME_QTE_POS_START.x
	local var_10_1 = math.random(var_0_2.GAME_QTE_POS_END.y - var_0_2.GAME_QTE_POS_START.y) + var_0_2.GAME_QTE_POS_START.y
	local var_10_2 = true

	for iter_10_0, iter_10_1 in ipairs(self._circleList) do
		local var_10_3 = iter_10_1:getPosition()

		if math.abs(var_10_3.x - var_10_0) < var_0_2.GAME_QTE_GAP and math.abs(var_10_3.y - var_10_1) < var_0_2.GAME_QTE_GAP then
			var_10_2 = false

			break
		end
	end

	if var_10_2 then
		return var_10_0, var_10_1
	else
		return self:getIconPos()
	end
end

function ThemeBioGameQTELayer:_onValueChangeClick(arg_11_1)
	if self._isDone then
		return
	end

	self:removeIcon((arg_11_1:getSender()))

	self._isDone = self.m_infoComp:onClickOnce()

	if self._isDone then
		local var_11_0 = self._spine:getAnimationNames() or {}
		local var_11_1 = false

		self:_clearSchedule()

		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			if iter_11_1 and iter_11_1 == var_0_5.OUT then
				var_11_1 = true

				self._spine:setAnimation(0, var_0_5.OUT, false)
			end
		end

		if not var_11_1 then
			self:_onFinishClickTask()
		end
	else
		self._spine:setAnimation(0, var_0_5.HIT, false)
	end
end

function ThemeBioGameQTELayer:_onSpineEvent(arg_12_1)
	if arg_12_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		if arg_12_1.animation == var_0_5.IN or arg_12_1.animation == var_0_5.HIT then
			self._spine:setAnimation(0, var_0_5.IDLE, true)
		elseif arg_12_1.animation == var_0_5.OUT then
			self:_onFinishClickTask()
		end
	end
end

function ThemeBioGameQTELayer:_onFinishClickTask()
	g.core.network.GameNetProxy:send_C2S_ThemeBiography_ExecuteMission({
		act_id = self._activeThemeValue,
		id = self._missionId
	})
	g.core.module.ModuleManager:popComponent()
end

return ThemeBioGameQTELayer
