local ConsumeGemSignInPage = class("ConsumeGemSignInPage", import("view.base.BaseActivityPage"))

function ConsumeGemSignInPage:OnInit()
	self.rtLogin = self._tf:Find("AD/login")
	self.shopBtn = self._tf:Find("shop")
	self.getAllBtn = self._tf:Find("get_all")
	self.getAllBtnEnb = self._tf:Find("get_all/Text")
	self.helpBtn = self._tf:Find("help")
	self.uiTargetList = UIItemList.New(self._tf:Find("AD/targets"), self._tf:Find("AD/targets/task"))
	self.sliderTr = self._tf:Find("AD/slider/Image")
	self.ptTxt = self._tf:Find("AD/Text")

	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ConsumeGem_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.shopBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.NEW_SHOP)

		return
	end, SFX_PANEL)
	onButton(self, self.getAllBtn, function()
		local var_4_0 = self:CollectCanGetAwards()

		if #var_4_0 <= 0 then
			return
		end

		local var_4_1 = {}

		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			table.insert(var_4_1, function(arg_5_0)
				self:emit(ActivityMediator.EVENT_PT_OPERATION, {
					cmd = 1,
					activity_id = self.consumeGemAct.id,
					arg1 = iter_4_1,
					callback = arg_5_0
				})

				return
			end)
		end

		seriesAsync(var_4_1)

		return
	end, SFX_PANEL)

	self.itemWid = 118

	return
end

function ConsumeGemSignInPage:CollectCanGetAwards()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(self.targets) do
		if iter_6_1 <= self.consumeGemAct.data1 and not table.contains(self.consumeGemAct.data1_list, iter_6_1) then
			table.insert(var_6_0, iter_6_1)
		end
	end

	return var_6_0
end

function ConsumeGemSignInPage:OnDataSetting()
	self.nday = self.activity.data3
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = self.activity:getConfig("config_data")
	self.consumeGemAct = getProxy(ActivityProxy):getActivityById(self.activity:getConfig("config_client").link_act)
	self.targets = self.consumeGemAct:getDataConfig("target")
	self.drops = self.consumeGemAct:getDataConfig("drop_client")

	return updateActivityTaskStatus(self.activity)
end

function ConsumeGemSignInPage:OnFirstFlush()
	self:FlushSignInAct()
	self:FlushTargetPtAct()
	self:Hx4Channel()

	return
end

function ConsumeGemSignInPage:FlushTargetPtAct()
	self.pt = self.consumeGemAct.data1
	self.gotList = self.consumeGemAct.data1_list

	setText(self.ptTxt, self.pt)
	setActive(self.getAllBtnEnb, #self:CollectCanGetAwards() > 0)

	local var_9_0 = 0

	self.uiTargetList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = self.targets[arg_10_1 + 1]
			local var_10_1 = Drop.Create(self.drops[arg_10_1 + 1])

			setText(arg_10_2:Find("day/Text"), self.targets[arg_10_1 + 1])

			local var_10_2 = table.contains(self.gotList, var_10_0)

			setActive(arg_10_2:Find("task_1/got"), var_10_2)

			local var_10_3 = not var_10_2 and var_10_0 <= self.pt

			setActive(arg_10_2:Find("get"), not var_10_2 and var_10_0 <= self.pt)
			setActive(arg_10_2:Find("task_1/lock"), var_10_0 > self.pt)
			setActive(arg_10_2:Find("dot1/Image_1"), var_10_3)

			if var_10_2 then
				var_9_0 = arg_10_1 + 1
			end

			onButton(self, arg_10_2:Find("get"), function()
				self:emit(ActivityMediator.EVENT_PT_OPERATION, {
					cmd = 1,
					activity_id = self.consumeGemAct.id,
					arg1 = var_10_0
				})

				return
			end, SFX_CONFIRM)
			updateDrop(arg_10_2:Find("task_1/IconTpl"), var_10_1)
			onButton(self, arg_10_2, function()
				self:emit(BaseUI.ON_DROP, var_10_1)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.uiTargetList:align(#self.targets)

	self.sliderTr.sizeDelta = Vector2(self.itemWid * 0.5 + (0 - 1) * self.itemWid, self.sliderTr.sizeDelta.y)

	return
end

function ConsumeGemSignInPage:FlushSignInAct()
	local var_13_0 = {
		"task",
		"task_1",
		"task_2"
	}

	for iter_13_0, iter_13_1 in ipairs(self.taskGroup) do
		local var_13_1 = self.taskProxy:getTaskVO(iter_13_1[1]) or Task.New({
			id = iter_13_1[1]
		})
		local var_13_2 = self.rtLogin:Find(var_13_0[iter_13_0])

		setText(var_13_2:Find("day/Text"), "DAY" .. iter_13_0)

		local var_13_3 = Drop.Create(var_13_1:getConfig("award_display")[1])

		updateDrop(var_13_2:Find("IconTpl"), var_13_3)
		onButton(self, var_13_2:Find("get"), function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_13_1)

			return
		end, SFX_CONFIRM)
		onButton(self, var_13_2, function()
			self:emit(BaseUI.ON_DROP, var_13_3)

			return
		end, SFX_PANEL)
	end

	return
end

function ConsumeGemSignInPage:OnUpdateFlush()
	self:UpdateSignInAct()
	self:UpdateTargetPtAct()

	return
end

function ConsumeGemSignInPage:UpdateSignInAct()
	local var_17_0 = {
		"task",
		"task_1",
		"task_2"
	}

	for iter_17_0, iter_17_1 in ipairs(self.taskGroup) do
		local var_17_1 = self.taskProxy:getTaskVO(iter_17_1[1]) or Task.New({
			id = iter_17_1[1]
		})
		local var_17_2 = self.rtLogin:Find(var_17_0[iter_17_0])
		local var_17_3 = var_17_1:isReceive()

		setActive(var_17_2:Find("got"), var_17_3 or iter_17_0 < self.nday)
		setActive(var_17_2:Find("get"), not false and not var_17_3 and iter_17_0 == self.nday)
	end

	return
end

function ConsumeGemSignInPage:UpdateTargetPtAct()
	self:FlushTargetPtAct()

	return
end

local function var_0_1(arg_19_0)
	return (arg_19_0._tf:Find("AD/rw_mask/rw_1/hx_ch" .. pg.SdkMgr.GetInstance():GetChannelUIDIncludeHarmony()))
end

function ConsumeGemSignInPage:Hx4Channel()
	local var_20_0 = var_0_1(self)

	if not IsNil(var_20_0) then
		setActive(var_20_0, HXSet.isHx())
	end

	return
end

return ConsumeGemSignInPage
