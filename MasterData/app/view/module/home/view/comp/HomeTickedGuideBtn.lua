local var_0_0 = g.core.const.ConstMgr.SpineConst
local HomeTickedGuideBtn = class("HomeTickedGuideBtn", require("app.fairyGUI.home.UI_HomeTickedGuideBtn"))

function HomeTickedGuideBtn:ctor()
	self._showState = false
	self._waitCount = 0

	self:setVisible(false)
	self:addClickListener(handler(self, self._onTouchClick))

	self.m_conflictBtn = nil
end

function HomeTickedGuideBtn:setConflictBtn(arg_2_1)
	self.m_conflictBtn = arg_2_1
end

function HomeTickedGuideBtn:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_TICK_GUIDE_FLUSH, self._onFlushShowState, self)
	self:_onFlushShowState()
end

function HomeTickedGuideBtn:_onFlushShowState()
	if g.core.guide.GuideProxy:isGuideRunning() and g.core.model.User:getLevel() <= 7 then
		self.m_conflictBtn:updateBtn()
		self:setVisible(false)

		return
	end

	if GUIDE_EDIT then
		self.m_conflictBtn:setVisible(false)
		self:setVisible(true)

		local var_4_0 = g.core.config.function_guide_info.indexOf(1)

		self:setTitle(var_4_0.name)
		self.m_descTxt:setTitle(var_4_0.txt)
		self.m_knightIcon:setURL((g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get(var_4_0.knight_id).icon_id)))
		self:setAlphaRect(var_0_0.MASK_TYPE.HORIZON)

		return
	end

	local var_4_1 = g.core.model.User.guideData:getTopGuide()

	self._showState = self:isVisible()

	if var_4_1 then
		self:setTitle(var_4_1.cfg.name)
		self.m_descTxt:setTitle(var_4_1.cfg.txt)
		self.m_knightIcon:setURL((g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get(var_4_1.cfg.knight_id).icon_id)))
		self:setAlphaRect(var_0_0.MASK_TYPE.HORIZON)

		if self._showState ~= true then
			if self._showState then
				self.m_backTransition:play(handler(self, self.onBackEnd))
			else
				self._waitCount = self._waitCount or 0
				self._waitCount = self._waitCount + 1

				self:newScheduleOnce(handler(self, function()
					self.m_conflictBtn:setVisible(false)
					self:setVisible(true)
					self.m_conflictBtn:setVisible(false)
					self.m_enterTransition:play(handler(self, self.onEnterAnimEnd))
				end), 1)
			end
		end
	else
		self.m_conflictBtn:updateBtn()
		self:setVisible(false)
	end
end

function HomeTickedGuideBtn:_playLoopEff()
	self.m_effComp:removeAllEffect()
	self.m_effComp:addEffectSpine({
		name = "eff_ui_home_tickedguide",
		scale = 1,
		isLoop = true
	})
end

function HomeTickedGuideBtn:onEnterAnimEnd()
	self:clearWaitState()
	self:_playLoopEff()
end

function HomeTickedGuideBtn:onBackEnd()
	self:setVisible(false)
	self:clearWaitState()
end

function HomeTickedGuideBtn:setAlphaRect(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = self.m_knightIcon:getContentSprite()

	if var_9_0 == nil then
		return
	end

	local var_9_1 = 15
	local var_9_2 = cc.size(90, 90)
	local var_9_3 = cc.rect(-var_9_2.width / 2, -var_9_2.height / 2, var_9_2.width, var_9_2.height - 15)

	if var_9_3 == nil then
		var_9_3 = {
			x = var_0_0.MASK_RECT.x,
			y = var_0_0.MASK_RECT.y,
			width = var_0_0.MASK_RECT.width,
			height = var_0_0.MASK_RECT.height
		}
	end

	var_9_0:showChangingRect(var_9_3, var_9_1)
end

function HomeTickedGuideBtn:_onTouchClick()
	if GUIDE_EDIT then
		return
	end

	local var_10_0 = g.core.model.User.guideData:getTopGuide()

	if var_10_0 then
		g.core.service.ServiceManager:getServiceByName("GuideService"):enterTickedGuide(var_10_0.cfg.id)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	end

	self:_onFlushShowState()
end

function HomeTickedGuideBtn:clearWaitState()
	return
end

function HomeTickedGuideBtn:onUnload()
	self:clearWaitState()
end

return HomeTickedGuideBtn
