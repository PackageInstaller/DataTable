local ActivityReturnSelectRolePop = class("ActivityReturnSelectRolePop", require("app.fairyGUI.activityReturn.UI_ActivityReturnSelectRolePop"), function()
	return fgui.GComponent:create({
		resName = "ActivityReturnSelectRolePop",
		pkgPath = "ui/activityReturn/activityReturn",
		pkgName = "activityReturn"
	}, ...)
end)

function ActivityReturnSelectRolePop:ctor(arg_2_1)
	self._info = arg_2_1

	local var_2_0 = -1

	self._selectAwards = arg_2_1.previewMap[1]

	if self._info.curAward then
		for iter_2_0, iter_2_1 in ipairs(self._selectAwards) do
			if iter_2_1.type == self._info.curAward.type and iter_2_1.value == self._info.curAward.value then
				var_2_0 = iter_2_0

				break
			end
		end
	end

	if var_2_0 > 0 then
		self.m_selIndexController:setSelectedIndex(var_2_0 - 1)
	else
		self.m_selIndexController:setSelectedIndex(3)
	end

	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmBtnClicked))
	self:showAtCenter()
end

function ActivityReturnSelectRolePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RERUN_CHOOSEAWARD, handler(self, self._onChooseFinish), self)
	self:_checkTipsGuide()
	self:_updateView()
end

function ActivityReturnSelectRolePop:_checkTipsGuide()
	local var_4_0 = self.m_wishBtn

	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.RERUN_CHOOSE_AWARD_POP_WEEK_GUIDE) then
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.RERUN_CHOOSE_AWARD_POP_WEEK_GUIDE)
		self:newScheduleOnce(function()
			g.core.service.ServiceManager:getServiceByName("TipGuideService"):reset()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
				key = "RERUN_CHOOSE_AWARD_POP_WEEK_GUIDE",
				objects = {
					var_4_0
				}
			})
		end, 0)
	end
end

function ActivityReturnSelectRolePop:_updateView()
	self.m_selComp1:updateComp(self._selectAwards[1], 1)
	self.m_selComp2:updateComp(self._selectAwards[2], 2)
	self.m_selComp3:updateComp(self._selectAwards[3], 3)
end

function ActivityReturnSelectRolePop:_onConfirmBtnClicked()
	local var_7_0 = self.m_selIndexController:getSelectedIndex()
	local var_7_1

	if var_7_0 < 0 or var_7_0 > 2 then
		print(var_7_0)
		g.core.module.ModuleManager:tip(g.core.lang:get(425003))

		do return end

		var_7_1 = {
			type = self._selectAwards[var_7_0 + 1].type
		}
	end

	var_7_1.value = self._selectAwards[var_7_0 + 1].value

	g.core.network.GameNetProxy:send_C2S_Rerun_ChooseAward(var_7_1)
end

function ActivityReturnSelectRolePop:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "selectIndex" then
		self.m_selIndexController:setSelectedIndex(arg_8_2.index - 1)

		return true
	end
end

function ActivityReturnSelectRolePop:_onChooseFinish()
	g.core.module.ModuleManager:tip(g.core.lang:get(425002))
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return ActivityReturnSelectRolePop
