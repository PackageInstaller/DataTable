local var_0_0 = g.core.config.gold_saving_game_info
local GoldSavingTickPop = class("GoldSavingTickPop", require("app.fairyGUI.infoPop.UI_GoldSavingTickPop"), function()
	return fgui.GComponent:create({
		resName = "GoldSavingTickPop",
		pkgName = "infoPop",
		pkgPath = "ui/infoPop/infoPop"
	})
end)

function GoldSavingTickPop:ctor(arg_2_1)
	self:showAtCenter()

	self._curTickId = arg_2_1.id

	self.m_goBtn:addClickListener(handler(self, self._onGoBtn))
	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancel))
	self.m_checkBtn:addClickListener(handler(self, self._onCheckClick))

	self._isInGame = false

	self:updateGoldSavingView()
end

function GoldSavingTickPop:onLoad()
	self:checkTickGuide()
end

function GoldSavingTickPop:checkTickGuide()
	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GOLD_SAVING_TICK) then
		local var_4_0 = fgui.UIPackage:createObject("guide", "GuideTouchComp")

		var_4_0:setTouchable(false)
		var_4_0:updateView()
		self.m_goBtn:addChild(var_4_0)

		local var_4_1 = self.m_goBtn:getSize()

		var_4_0:setPosition(var_4_1.width / 2, var_4_1.height / 2)
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GOLD_SAVING_TICK)
	end
end

function GoldSavingTickPop:updateGoldSavingView()
	local var_5_0 = var_0_0.get(self._curTickId)

	self.m_typeController:setSelectedIndex(var_5_0.type - 1)
	self.m_titleTxt:setText(g.core.lang:get(407918, {
		name = var_5_0.event_name
	}))
end

function GoldSavingTickPop:_onGoBtn()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	g.core.module.ModuleManager:pushModule(g.view.entrance.GOLD_SAVING)
end

function GoldSavingTickPop:_onClickCancel()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function GoldSavingTickPop:_onCheckClick()
	g.core.model.User.goldSavingData:setIgnoreTodayTip((self.m_checkBtn:isSelected()))
end

function GoldSavingTickPop:_onGameStart(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	local var_9_0 = g.core.config.gold_saving_game_info.get(arg_9_4.game_id)

	g.core.common.Scheduler:newScheduleOnce(function()
		require("app.view.module.goldSaving.const.GoldSavingGameHelper").openGame(var_9_0, arg_9_4)
	end, 0)
end

function GoldSavingTickPop:onUnload()
	return
end

return GoldSavingTickPop
