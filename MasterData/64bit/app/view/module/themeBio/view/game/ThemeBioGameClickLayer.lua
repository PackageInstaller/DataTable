local var_0_0 = g.core.model.User.themeData
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_2 = BattleConst.SPINE_ACTION_TYPE
local var_0_3 = g.core.event
local var_0_4 = g.core.config.theme_biography_event_info
local ThemeBioGameClickLayer = class("ThemeBioGameClickLayer", require("app.fairyGUI.themeBio.UI_ThemeBioGameClickLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/themeBio/themeBio",
		resName = "ThemeBioGameClickLayer",
		pkgName = "themeBio"
	}, ...)
end)

function ThemeBioGameClickLayer:ctor(arg_2_1, arg_2_2)
	self._missionId = arg_2_1
	self._activeThemeValue = arg_2_2 or 1
	self._themeBioData = var_0_0:getThemeData(self._activeThemeValue):getThemeBioData()
	self._spine = nil
	self._isDone = false
	self._isHasSendNet = false
	self._isProgressFull = false

	self:_initView()
	self:_initBtn()
end

function ThemeBioGameClickLayer:onLoad()
	var_0_3.EventManager:dispatchEvent(var_0_3.enum.EVENT_BIO_SET_HUDUI_SHOW, false, false)
end

function ThemeBioGameClickLayer:onUnload()
	var_0_3.EventManager:dispatchEvent(var_0_3.enum.EVENT_BIO_SET_HUDUI_SHOW, false, true)
end

function ThemeBioGameClickLayer:_initView()
	local var_5_0 = var_0_4.get(self._themeBioData:getMission(self._missionId).sub_id)

	self.m_infoComp:updateEventInfo(var_5_0)

	self._spine = self.m_iconHolderComp:addEffectSpine({
		isLoop = false,
		name = var_5_0.pic,
		anim = var_0_2.IDLE,
		eventHandler = handler(self, self._onSpineEvent)
	})
end

function ThemeBioGameClickLayer:_initBtn()
	self.m_clickBtn:addClickListener(handler(self, self._onGameClick))
end

function ThemeBioGameClickLayer:_onGameClick()
	if self._isProgressFull then
		return
	end

	self.m_iconHolderComp:stopAllFGActions()
	self.m_iconHolderComp:setScale(1)
	self.m_infoComp:onClickOnce()
	self:_showHitAnimation()
end

function ThemeBioGameClickLayer:_onSpineEvent(arg_8_1)
	if arg_8_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		if arg_8_1.animation == var_0_2.IDLE or arg_8_1.animation == var_0_2.HIT then
			self._spine:setAnimation(0, var_0_2.IDLE, true)
		elseif arg_8_1.animation == var_0_2.OUT then
			self:_onFinishClickTask()
		end
	elseif arg_8_1.type == "end" and self._isProgressFull then
		self:_onFinishClickTask()
	end
end

function ThemeBioGameClickLayer:_onFinishClickTask()
	if not self._isHasSendNet then
		self._isHasSendNet = true

		g.core.network.GameNetProxy:send_C2S_ThemeBiography_ExecuteMission({
			act_id = self._activeThemeValue,
			id = self._missionId
		})
		g.core.module.ModuleManager:popComponent()
	end
end

function ThemeBioGameClickLayer:receiveCompEvent(arg_10_1)
	if arg_10_1 == "progressChanging" then
		self:_showHitAnimation()
	elseif arg_10_1 == "progress_bar_is_over" then
		self._isProgressFull = true

		local var_10_0 = false

		for iter_10_0, iter_10_1 in ipairs(self._spine:getAnimationNames() or {}) do
			if iter_10_1 and iter_10_1 == var_0_2.OUT then
				var_10_0 = true

				self._spine:setAnimation(0, var_0_2.OUT, false)
			end
		end

		if not var_10_0 then
			self:_onFinishClickTask()
		end
	end
end

function ThemeBioGameClickLayer:_showHitAnimation()
	self._preTime = self._curTime or 0

	local var_11_0 = self.m_infoComp:getCurPercent() * ((self._spine:getAnimationDuration(var_0_2.HIT) or 0) / self.m_infoComp:getMaxPercent())

	self._curTime = var_11_0

	self._spine:setAnimation(0, var_0_2.HIT, false)

	if var_11_0 > self._preTime then
		self._spine:play(self._preTime, self._curTime)
	else
		self._spine:play(var_11_0, self._preTime)
	end
end

return ThemeBioGameClickLayer
