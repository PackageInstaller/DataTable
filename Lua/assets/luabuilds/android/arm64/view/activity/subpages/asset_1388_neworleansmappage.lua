local NewOrleansMapPage = class("NewOrleansMapPage", import("...base.BaseActivityPage"))

function NewOrleansMapPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.item = self.bg:Find("item")
	self.itemMask = self.item:Find("icon_mask")
	self.gotaskBtn = self.bg:Find("gotask")
	self.gobattleBtn = self.bg:Find("gobattle")

	return
end

function NewOrleansMapPage:OnDataSetting()
	self.taskIDList = _.flatten((self.activity:getConfig("config_data")))
	self.taskProxy = getProxy(TaskProxy)

	return
end

function NewOrleansMapPage:OnFirstFlush()
	onButton(self, self.gobattleBtn, function()
		local var_4_0 = getProxy(ActivityProxy):getActivityById(pg.activity_const.NEW_ORLEANS_Map_BATTLE.act_id)

		if not var_4_0 or var_4_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

			return
		end

		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.gotaskBtn, function()
		local var_5_0 = getProxy(ActivityProxy):getActivityById(pg.activity_const.NEW_ORLEANS_Map_BATTLE.act_id)

		if not var_5_0 or var_5_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

			return
		end

		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity"
		})

		return
	end)

	return
end

function NewOrleansMapPage:OnUpdateFlush()
	local var_6_0 = self.taskProxy:getTaskVO(self.taskIDList[self:findCurTaskIndex()])

	self.curTaskVO = var_6_0

	local var_6_1 = var_6_0:getConfig("award_display")[1]
	local var_6_2 = {
		type = var_6_1[1],
		id = var_6_1[2],
		count = var_6_1[3]
	}

	updateDrop(self.item, var_6_2)
	onButton(self, self.item, function()
		self:emit(BaseUI.ON_DROP, var_6_2)

		return
	end, SFX_PANEL)
	setActive(self.itemMask, var_6_0:getTaskStatus() == 2)

	return
end

function NewOrleansMapPage:OnDestroy()
	return
end

function NewOrleansMapPage:findCurTaskIndex()
	local var_9_0

	for iter_9_0, iter_9_1 in ipairs(self.taskIDList) do
		if self.taskProxy:getTaskVO(iter_9_1):getTaskStatus() <= 1 then
			var_9_0 = iter_9_0

			break
		elseif iter_9_0 == #self.taskIDList then
			var_9_0 = iter_9_0
		end
	end

	return var_9_0
end

return NewOrleansMapPage
