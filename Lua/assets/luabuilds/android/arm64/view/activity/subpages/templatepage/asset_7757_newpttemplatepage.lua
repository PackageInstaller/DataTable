local NewPtTemplatePage = class("NewPtTemplatePage", import("view.base.BaseActivityPage"))

NewPtTemplatePage.OFFSET = 0.00042
NewPtTemplatePage.SHOW_COUNT = 8
NewPtTemplatePage.AWARD_OFFSET = 1e-05

function NewPtTemplatePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.getBtn = self.bg:Find("get_btn")
	self.shopBtn = self.bg:Find("exchange_btn")
	self.content = self.bg:Find("award_list/content")
	self.awardTpl = self.bg:Find("award")
	self.sptf = self.bg:Find("sp_award")
	self.spAward = self.bg:Find("sp_award/award")
	self.ptCount = self.bg:Find("ptCount")
	self.getBtnGray = self.bg:Find("gray")
	self.get = self.bg:Find("Obtained")
	self.scrollCom = GetComponent(self.content, "LScrollRect")

	function self.scrollCom.onUpdateItem(arg_2_0, arg_2_1)
		self:UpdateAward(arg_2_0, tf(arg_2_1))

		return
	end

	setActive(self.awardTpl, false)

	return
end

function NewPtTemplatePage:OnDataSetting()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.highValueItemSort = self.activity:getConfig("config_client").highValueItemSort
		self.ptData = ActivityPtData.New(self.activity)
		self.awardList = {}

		for iter_3_0, iter_3_1 in pairs(self.ptData.dropList) do
			table.insert(self.awardList, {
				drop = Drop.New({
					type = iter_3_1[1],
					id = iter_3_1[2],
					count = iter_3_1[3]
				}),
				isImportant = table.contains(self.highValueItemSort, iter_3_0),
				target = self.ptData.targets[iter_3_0]
			})
		end
	end

	return
end

function NewPtTemplatePage:OnFirstFlush()
	onButton(self, self.getBtn, function()
		if self.ptData:GetMaxAvailableTargetIndex() == self.ptData:GetLevel() then
			return
		end

		local var_5_0 = {}
		local var_5_1 = getProxy(PlayerProxy):getRawData()
		local var_5_3, var_5_4 = Task.StaticJudgeOverflow(var_5_1.gold, var_5_1.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, (self.ptData:GetAllAvailableAwards()))

		if var_5_3 then
			table.insert(var_5_0, function(arg_6_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_5_4,
					onYes = arg_6_0
				})

				return
			end)
		end

		seriesAsync(var_5_0, function()
			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 4,
				activity_id = self.ptData:GetId(),
				arg1 = self.ptData:GetCurrTarget()
			})

			return
		end)

		return
	end, SFX_PANEL)

	local var_4_0 = getProxy(ActivityProxy):getActivityById(self.activity:getConfig("config_client").shopLinkActID)

	onButton(self, self.shopBtn, function()
		if not var_4_0 or var_4_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		local var_8_0 = {
			warp = NewShopsScene.TYPE_ACTIVITY
		}

		var_8_0.actId = var_4_0 and var_4_0.id

		self:emit(ActivityMediator.GO_SHOPS_LAYER, var_8_0)

		return
	end)
	self.scrollCom:SetTotalCount(#self.awardList)
	self:BuildPhaseAwardScrollPos()
	self.scrollCom.onValueChanged:AddListener(function(arg_9_0)
		self:UpdateNextAward(arg_9_0.x)

		return
	end)
	self:UpdateNextAward(self.scrollCom.value)

	return
end

function NewPtTemplatePage:BuildPhaseAwardScrollPos()
	self.impTotalPos = self.scrollCom:HeadIndexToValue(#self.awardList - NewPtTemplatePage.SHOW_COUNT) - self.scrollCom:HeadIndexToValue(0)
	self.importantPos = {}

	for iter_10_0, iter_10_1 in pairs(self.awardList) do
		if iter_10_1.isImportant then
			table.insert(self.importantPos, {
				index = iter_10_0,
				pos = self.scrollCom:HeadIndexToValue(iter_10_0 - NewPtTemplatePage.SHOW_COUNT) / self.impTotalPos
			})
		end
	end

	return
end

function NewPtTemplatePage:UpdateNextAward(arg_11_1)
	arg_11_1 = math.min(arg_11_1, 1)

	for iter_11_0, iter_11_1 in pairs(self.importantPos) do
		if arg_11_1 + NewPtTemplatePage.AWARD_OFFSET < iter_11_1.pos then
			setActive(self.sptf, true)
			self:UpdateAward(iter_11_1.index - 1, self.spAward)

			break
		elseif iter_11_0 == #self.importantPos then
			setActive(self.sptf, false)
		end
	end

	return
end

function NewPtTemplatePage:UpdateAward(arg_12_1, arg_12_2)
	local var_12_0 = self.awardList[arg_12_1 + 1].drop

	updateDrop(arg_12_2:Find("icon"), self.awardList[arg_12_1 + 1].drop)
	setText(arg_12_2:Find("pt"), self.awardList[arg_12_1 + 1].target)

	local var_12_1 = arg_12_1 + 1 <= self.ptData:GetLevel()
	local var_12_2 = not var_12_1 and arg_12_1 + 1 <= self.ptData:GetMaxAvailableTargetIndex()
	local var_12_3 = not var_12_1 and not var_12_2

	setActive(arg_12_2:Find("got"), var_12_1)
	setActive(arg_12_2:Find("get"), var_12_2)
	setActive(arg_12_2:Find("lock"), var_12_3)
	onButton(self, arg_12_2, function()
		self:emit(BaseUI.ON_DROP, var_12_0)

		return
	end, SFX_PANEL)

	return
end

function NewPtTemplatePage:OnUpdateFlush()
	if isActive(self._tf) then
		self.scrollCom:ScrollTo(math.clamp(self.scrollCom:HeadIndexToValue(self.ptData:GetLevel()) / self.impTotalPos + NewPtTemplatePage.OFFSET * self.ptData:GetLevel(), 0, 1), true)
	end

	setText(self.get, i18n("word_got_pt"))
	setText(self.ptCount, self.ptData.count)
	setActive(self.getBtnGray, self.ptData:GetMaxAvailableTargetIndex() == self.ptData:GetLevel())
	setActive(self.getBtn, self.ptData:GetMaxAvailableTargetIndex() ~= self.ptData:GetLevel())

	return
end

function NewPtTemplatePage:GetWorldPtData(arg_15_1)
	if arg_15_1 <= pg.TimeMgr.GetInstance():GetServerTime() - (ActivityMainScene.Data2Time or 0) then
		ActivityMainScene.Data2Time = pg.TimeMgr.GetInstance():GetServerTime()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 2,
			activity_id = self.ptData:GetId()
		})
	end

	return
end

return NewPtTemplatePage
