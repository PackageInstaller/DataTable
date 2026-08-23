local var_0_0 = g.core.model.User
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local FormationSPComp = class("FormationSPComp", require("app.fairyGUI.formation.UI_FormationSPComp"))

function FormationSPComp:ctor()
	self._hideGuide = false

	self.m_changeBtn:addClickListener(handler(self, self._onChange))

	if var_0_0.knightsData:getLineupKnightCount() == var_0_1.LINEUP_MAX then
		self._isLineUpFull = true
	else
		self._isLineUpFull = false

		self.m_styleController:setSelectedIndex(2)
	end

	self.m_changeBtn:getController("unLock"):setSelectedIndex(self._isLineUpFull and 1 or 0)
end

function FormationSPComp:onLoad()
	self:_checkTickWeakGuide()
end

function FormationSPComp:setHideGuide(arg_3_1)
	self._hideGuide = arg_3_1
end

function FormationSPComp:updateFormatInfo()
	self:refreshSkillComp()
	self:refreshPartnerComp()
end

function FormationSPComp:showAllIcon()
	self.m_skillComp1:showAllFormatIcon()
	self.m_skillComp2:showAllFormatIcon()
	self.m_partnerComp1:showAllFormation()
	self.m_partnerComp2:showAllFormation()
end

function FormationSPComp:updateFormatInfoByData(arg_6_1)
	self.m_changeBtn:getController("unLock"):setSelectedIndex(1)
	self.m_styleController:setSelectedIndex(0)

	self._isLineUpFull = true

	self:refreshSkillComp(arg_6_1.unitTokenData)
	self:refreshPartnerComp(arg_6_1.knights)
end

function FormationSPComp:refreshSkillComp(arg_7_1)
	if arg_7_1 then
		self.m_skillComp1:updateFormatInfoByLineupTokens(arg_7_1)
		self.m_skillComp2:updateFormatInfoByLineupTokens(arg_7_1)
	else
		self.m_skillComp1:updateFormatInfo()
		self.m_skillComp2:updateFormatInfo()
	end
end

function FormationSPComp:refreshPartnerComp(arg_8_1)
	if arg_8_1 then
		self.m_partnerComp1:updateFormatInfoByKnights(arg_8_1)
		self.m_partnerComp2:updateFormatInfoByKnights(arg_8_1)
	else
		self.m_partnerComp1:updateFormatInfo()
		self.m_partnerComp2:updateFormatInfo()
	end
end

function FormationSPComp:_onChange()
	self:cancelAllSchedule()

	if self._isLineUpFull then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)

		if self.m_styleController:getSelectedIndex() == 0 then
			self.m_styleController:setSelectedIndex(1)
			g.core.common.Scheduler:newScheduleOnce(function()
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
			end, 0.5)
		else
			self.m_styleController:setSelectedIndex(0)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CLEAR_GUIDE_COMP)
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(200009))
	end

	self:_checkTickWeakGuide()
end

function FormationSPComp:_checkTickWeakGuide()
	if self._hideGuide then
		return
	end

	if #g.core.model.User.knightsData:getOwnerAllList() >= 7 and g.core.common.ModuleUnlock:isModuleUnlock(200) and g.core.model.User.knightsData:getLineupKnightCount() == g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX then
		local var_11_0 = self.m_styleController:getSelectedIndex()

		if var_11_0 == 0 then
			local var_11_1 = var_0_0.knightsData:getFormationKnights()
			local var_11_2 = false

			for iter_11_0 = 1, var_0_1.SHOW_PARTNER_NUM do
				if var_11_1[var_0_1.LINEUP_MAX + iter_11_0] ~= 0 then
					var_11_2 = true

					break
				end
			end

			if not var_11_2 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
					key = "FATE_STEP_1",
					targetBtn = self.m_mainComp
				})
			end
		elseif var_11_0 == 1 then
			local var_11_3 = self.m_partnerComp2:getEmptyCanUpTouchComp()

			if var_11_3 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
					key = "FATE_STEP_2",
					targetBtn = var_11_3
				})
			end
		end
	end
end

function FormationSPComp:onUnload()
	self:cancelAllSchedule()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return FormationSPComp
