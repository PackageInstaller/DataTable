local var_0_0 = g.core.config.guild_alliance_trial_reward_info
local var_0_1 = g.core.model.User.allianceTrialData
local AllianceTrialBoxPop = class("AllianceTrialBoxPop", require("app.fairyGUI.allianceTrial.UI_AllianceTrialBoxPop"), function()
	return fgui.GComponent:create({
		resName = "AllianceTrialBoxPop",
		pkgPath = "ui/allianceTrial/allianceTrial",
		pkgName = "allianceTrial"
	}, ...)
end)

function AllianceTrialBoxPop:ctor()
	self:showAtCenter()

	self.ignoreCtrlRemove = true
	self._levelList = var_0_1:getMonsterDataByStage()
	self._selectedLevel = 1
	self._boxNumList = {}

	self:initView()
end

function AllianceTrialBoxPop:initView()
	self.m_levelList:setIniter()
	self.m_levelList:setItemRenderer(handler(self, self._onRenderLevelList))
	self.m_levelList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClickItem))
	self.m_boxList:setVirtual()
	self.m_boxList:setItemRenderer(handler(self, self._onRenderBoxList))
	self.m_openBtn:addClickListener(handler(self, self._onClickOpenBtn))
	self.m_previewBtn:addClickListener(handler(self, self._onClickPreviewBtn))
	self.m_popPanel:setTitle(g.core.lang:get(430412, {
		stage = var_0_1:getStage()
	}))
end

function AllianceTrialBoxPop:_onClickOpenBtn()
	if not var_0_1:isLevelFinish(self._selectedLevel) then
		g.core.module.ModuleManager:tip(g.core.lang:get(430404))

		return
	end

	if var_0_1:isBoxAwarded(self._selectedLevel) then
		g.core.module.ModuleManager:tip(g.core.lang:get(430408))

		return
	end

	if var_0_1:getLastWeeklyOpenCount() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(430413))

		return
	end

	local var_4_0 = var_0_1:getRandomBoxIndex(self._selectedLevel)

	g.core.network.GameNetProxy:send_C2S_AllianceTrial_BoxAward({
		level = self._selectedLevel,
		index = var_4_0
	})
	self.m_boxList:scrollToView(var_4_0 - 1)
end

function AllianceTrialBoxPop:_onClickPreviewBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.allianceTrial.view.AllianceTrialPreviewPop").new({
		level = self._selectedLevel
	}), {
		touchDisappear = true,
		hideContinue = true
	})
end

function AllianceTrialBoxPop:_onTabListClickItem()
	local var_6_0 = self.m_levelList:getSelectedIndex() + 1

	if var_6_0 == self._selectedLevel then
		return
	end

	self._selectedLevel = var_6_0

	self:updateView()
end

function AllianceTrialBoxPop:_onRenderLevelList(arg_7_1, arg_7_2)
	arg_7_2:updateLevelCell(arg_7_1 + 1)
end

function AllianceTrialBoxPop:_onRenderBoxList(arg_8_1, arg_8_2)
	arg_8_2:updateBoxCell(self._selectedLevel, arg_8_1 + 1)
end

function AllianceTrialBoxPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_BOXINFO, handler(self, self.onGetInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_BOXAWARD, handler(self, self.onGetAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ALLIANCE_TRIAL_BOXAWARD_ERROR, handler(self, self.onGetAwardError), self)
	g.core.network.GameNetProxy:send_C2S_AllianceTrial_BoxInfo({
		level = 0
	})
end

function AllianceTrialBoxPop:updateView()
	self._boxNumList[self._selectedLevel] = var_0_1:getBoxShowNum(self._selectedLevel)

	self.m_boxList:setNumItems(self._boxNumList[self._selectedLevel])
	self.m_levelList:setNumItems(#self._levelList)
	self.m_lastCount:setText(var_0_1:getLastWeeklyOpenCount())

	if var_0_1:isLevelFinish(self._selectedLevel) then
		self.m_boxStateController:setSelectedIndex(var_0_1:isBoxAwarded(self._selectedLevel) and 2 or 1)
	else
		self.m_boxStateController:setSelectedIndex(0)
	end
end

function AllianceTrialBoxPop:onGetAwardError(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	g.core.network.GameNetProxy:send_C2S_AllianceTrial_BoxInfo({
		level = self._selectedLevel
	})
end

function AllianceTrialBoxPop:onGetAward(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self:updateView()

	local var_12_0 = false
	local var_12_1 = var_0_0.get(arg_12_4.box.reward_id)

	for iter_12_0 = 1, self.m_boxList:numChildren() do
		var_12_0 = self.m_boxList:getChildAt(iter_12_0 - 1):showEffect(arg_12_4.box.index, function()
			self:showAwardPop(var_12_1)
		end)

		if var_12_0 then
			break
		end
	end

	if not var_12_0 then
		self:showAwardPop(var_12_1)
	end
end

function AllianceTrialBoxPop:showAwardPop(arg_14_1)
	g.core.module.ModuleManager:awardSummary({
		{
			type = arg_14_1.type,
			value = arg_14_1.value,
			size = arg_14_1.size
		}
	})
end

function AllianceTrialBoxPop:onGetInfo()
	self._selectedLevel = var_0_1:getMinCanGetBoxLevel()

	self:updateView()
	self.m_levelList:setSelectedIndex(self._selectedLevel - 1)
end

return AllianceTrialBoxPop
