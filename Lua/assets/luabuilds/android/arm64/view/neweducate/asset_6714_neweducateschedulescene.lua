local NewEducateScheduleScene = class("NewEducateScheduleScene", import("view.newEducate.base.NewEducateBaseUI"))

NewEducateScheduleScene.PLAN_CNT = 5
NewEducateScheduleScene.TALENT_CNT = 4

function NewEducateScheduleScene:getUIName()
	return "NewEducateScheduleUI"
end

function NewEducateScheduleScene:init()
	self.rootTF = self._tf:Find("root")
	self.bgTF = self.rootTF:Find("bg")
	self.mainTF = self.rootTF:Find("main")
	self.leftTF = self.rootTF:Find("main/left")

	local var_2_0 = self.leftTF:Find("title")

	self.titleRoundTF = var_2_0:Find("round_container/title_round")

	setText(var_2_0:Find("title_front"), i18n("child2_plan_title_front"))
	setText(var_2_0:Find("title_back"), i18n("child2_plan_title_back"))

	self.targetTF = self.leftTF:Find("target")

	self:InitPlanView()

	self.planCountTF = self.leftTF:Find("cell_title/Text")

	local var_2_1 = self.leftTF:Find("cells")
	local var_2_2 = self.leftTF:Find("cell_tpl")

	setActive(var_2_2, false)

	self.cells = {}

	for iter_2_0 = 1, NewEducateScheduleScene.PLAN_CNT do
		self.cells[iter_2_0] = {
			tf = cloneTplTo(var_2_2, var_2_1, iter_2_0)
		}
	end

	self.rightTF = self.rootTF:Find("main/right")
	self.effectTF = self.rightTF:Find("effect")
	self.moneyTF = self.rightTF:Find("money")
	self.moodTF = self.rightTF:Find("mood")

	setText(self.rightTF:Find("attrs/attr_title/Text"), i18n("child2_attr_title"))

	self.attrsTF = self.rightTF:Find("attrs/attrs")

	setText(self.rightTF:Find("talent/talent_title/Text"), i18n("child2_talent_title"))

	self.talentsTF = self.rightTF:Find("talent/talents")
	self.statusTF = self.rightTF:Find("status")

	setText(self.statusTF:Find("status_title/Text"), i18n("child2_status_title"))

	self.tarotTF = self.rightTF:Find("tarot")

	setText(self.tarotTF:Find("title/Text"), i18n("child2_tarot_title"))

	self.tarotIconTF = self.tarotTF:Find("bg/icon")
	self.tarotNameTF = self.tarotTF:Find("bg/name")
	self.tarotEntryTF = self.tarotTF:Find("bg/entry")

	self:InitRightPanel()

	self.skipToggle = self.rightTF:Find("skip/skip_toggle")

	setText(self.rightTF:Find("skip/Text"), i18n("child_plan_skip"))

	self.skipToggleCom = self.skipToggle:GetComponent(typeof(Toggle))
	self.nextBtn = self.rightTF:Find("next")
	self.nextTempBtn = self.rightTF:Find("next_temp")

	return
end

function NewEducateScheduleScene:GetSkipLocalKey()
	return NewEducateConst.NEW_EDUCATE_SKIP_PLANS_ANIM .. "_" .. self.playerID .. "_" .. self.contextData.char.id
end

function NewEducateScheduleScene:SetData()
	self.playerID = getProxy(PlayerProxy):getRawData().id
	self.planList = self.contextData.char:GetPlanList()
	self.attrIds = self.contextData.char:GetAttrIds()
	self.talents = self.contextData.char:GetTalentList()
	self.status = self.contextData.char:GetStatusList()
	self.unlockPlanNum = self.contextData.char:GetRoundData():getConfig("plan_num")
	self.moneyResId = self.contextData.char:GetResIdByType(NewEducateChar.RES_TYPE.MONEY)
	self.moodResId = self.contextData.char:GetResIdByType(NewEducateChar.RES_TYPE.MOOD)
	self.selectedCellIdx = 1
	self.discountInfos = self.contextData.char:GetPlanDiscountInfos()

	return
end

function NewEducateScheduleScene:didEnter()
	self:OverlayPanel(self.mainTF, {
		pbList = {
			self.mainTF:Find("bg")
		}
	})
	onButton(self, self.mainTF:Find("top/return_btn"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(self, self.tarotTF:Find("bg"), function()
		self:emit(NewEducateScheduleScene.GO_SUBLAYER, Context.New({
			mediator = NewEducateTarotEntryMediator,
			viewComponent = NewEducateTarotEntryLayer
		}))

		return
	end, SFX_PANEL)
	onToggle(self, self.skipToggle, function(arg_8_0)
		PlayerPrefs.SetInt(self:GetSkipLocalKey(), arg_8_0 and 1 or 0)

		return
	end, SFX_PANEL)
	onButton(self, self.nextBtn, function()
		self:OnClickNextBtn()

		return
	end, SFX_PANEL)
	onButton(self, self.nextTempBtn, function()
		self:OnClickNextBtn()

		return
	end, SFX_PANEL)
	onScroll(self, self.statusTF:Find("status"), function(arg_11_0)
		eachChild(self.statusUIList.container, function(arg_12_0)
			triggerToggle(arg_12_0, false)

			return
		end)

		return
	end)
	self:SetData()
	setActive(self.nextTempBtn, self.contextData.char:GetRoundData():NextIsTemp())
	triggerToggle(self.skipToggle, PlayerPrefs.GetInt(self:GetSkipLocalKey()) == 1)
	self:UpdateTitle()
	self:FlushPlanView()
	self:UpdateCells()

	self.isTarotChar = self.contextData.char:GetPermanentData():IsTarotType()

	setActive(self.tarotTF, self.isTarotChar)
	setActive(self.statusTF, not self.isTarotChar)
	self:FlushTarot()

	self.talentRoundIds = self.contextData.char:GetRoundData():GetTalentRoundIds()

	self.talentUIList:align(#self.talentRoundIds)
	self.statusUIList:align(#self.status)
	self:UpdateReuslt()
	self:CheckUpgradePlans()

	return
end

function NewEducateScheduleScene:CheckUpgradePlans()
	local var_13_0 = underscore.select(self.planList, function(arg_14_0)
		return arg_14_0:GetNextId() and self.contextData.char:IsMatchComplex(arg_14_0:getConfig("level_condition"))
	end)

	if #var_13_0 > 0 then
		local var_13_1 = {}

		underscore.select(var_13_0, function(arg_15_0)
			table.insert(var_13_1, arg_15_0.id)

			return
		end)
		self:emit(NewEducateScheduleMediator.ON_UPGRADE_PLANS, var_13_1)
	else
		NewEducateGuideSequence.CheckGuide(self.__cname)
	end

	return
end

function NewEducateScheduleScene:OnUpgradePlans()
	self.planList = getProxy(NewEducateProxy):GetCurChar():GetPlanList()

	self:FlushPlanView()
	NewEducateGuideSequence.CheckGuide(self.__cname)

	return
end

function NewEducateScheduleScene:InitPlanView()
	local var_17_0 = self.leftTF:Find("plan_view/content")
	local var_17_1 = var_17_0:Find("tpl")

	setText(var_17_1:Find("condition/Text"), i18n("child2_plan_upgrade_condition"))

	self.planUIList = UIItemList.New(var_17_0, var_17_1)

	self.planUIList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			self:UpdatePlan(arg_18_1, arg_18_2)
		end

		return
	end)

	return
end

function NewEducateScheduleScene:InitRightPanel()
	self.attrUIList = UIItemList.New(self.attrsTF, self.attrsTF:Find("tpl"))

	self.attrUIList:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventInit then
			LoadImageSpriteAsync("neweducateicon/" .. pg.child2_attr[self.attrIds[arg_20_1 + 1]].icon, arg_20_2:Find("icon_bg/icon"))
			setScrollText(arg_20_2:Find("name_mask/name"), pg.child2_attr[self.attrIds[arg_20_1 + 1]].name)
			setToggleEnabled(arg_20_2, self.isTarotChar)

			if self.isTarotChar then
				setText(arg_20_2:Find("info/content/name"), pg.child2_attr[self.attrIds[arg_20_1 + 1]].name)

				local var_20_0, var_20_1 = NewEducateInfoPanel.GetArrtInfo(pg.child2_attr[self.attrIds[arg_20_1 + 1]].rank, (self.contextData.char:GetAttr(self.attrIds[arg_20_1 + 1])))

				setText(arg_20_2:Find("info/content/value"), var_20_1)

				local var_20_2, var_20_3 = self.contextData.char:GetBenefitData():GetDisplayPctByDrop({
					type = NewEducateConst.DROP_TYPE.ATTR,
					id = self.attrIds[arg_20_1 + 1]
				})

				setText(arg_20_2:Find("info/content/desc"), i18n("child2_benefit_summary") .. var_20_2 .. "%" .. "\n" .. i18n("child2_benefit_summary2") .. var_20_3 .. "%")
			end
		elseif arg_20_0 == UIItemList.EventUpdate then
			self:UpdateAttr(arg_20_1, arg_20_2)
		end

		return
	end)

	self.talentUIList = UIItemList.New(self.talentsTF, self.talentsTF:Find("tpl"))

	self.talentUIList:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventInit then
			self:UpdateTalent(arg_21_1, arg_21_2)
		end

		return
	end)

	local var_19_0 = self.statusTF:Find("status/content/content")

	self.statusUIList = UIItemList.New(var_19_0, var_19_0:Find("tpl"))

	self.statusUIList:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventInit then
			self:UpdateStatus(arg_22_1, arg_22_2)
		end

		return
	end)

	return
end

function NewEducateScheduleScene:UpdateTitle()
	if self.contextData.char:GetRoundData():IsEndless() then
		self:UpdateEndlessTitle()
	else
		self:UpdateNormalTitle()
	end

	setImageSprite(self.bgTF, LoadSprite("bg/" .. self.contextData.char:GetRoundData():getConfig("main_background")), false)

	return
end

function NewEducateScheduleScene:UpdateNormalTitle()
	local var_24_0, var_24_1, var_24_2 = self.contextData.char:GetRoundData():GetProgressInfo()

	setText(self.titleRoundTF, var_24_0)
	setText(self.targetTF:Find("round"), i18n("child2_assess_round", var_24_1))

	local var_24_3 = self.contextData.char:GetAttrSum()

	setText(self.targetTF:Find("target"), i18n("child2_schedule_target", var_24_3, var_24_2))
	setText(self.targetTF:Find("value"), (var_24_3 < var_24_2 and setColorStr(var_24_3, "#ff6767") or var_24_3) .. "/" .. var_24_2)

	return
end

function NewEducateScheduleScene:UpdateEndlessTitle()
	local var_25_0, var_25_1, var_25_2 = self.contextData.char:GetRoundData():GetEndlessProgressInfos()

	setText(self.titleRoundTF, var_25_0)
	setText(self.targetTF:Find("round"), i18n("child2_assess_round", 0))

	local var_25_3 = self.contextData.char:GetAttrSum()

	setText(self.targetTF:Find("target"), i18n("child2_schedule_target", var_25_3, var_25_2))
	setText(self.targetTF:Find("value"), (var_25_3 < var_25_2 and setColorStr(var_25_3, "#ff6767") or var_25_3) .. "/" .. var_25_2)

	return
end

function NewEducateScheduleScene:UpdateCells()
	for iter_26_0, iter_26_1 in ipairs(self.cells) do
		self:UpdateCell(iter_26_0)
	end

	return
end

function NewEducateScheduleScene:UpdateCellReduce()
	for iter_27_0, iter_27_1 in ipairs(self.cells) do
		setActive(self.cells[iter_27_0].tf:Find("unlock/reduce"), (self.cells[iter_27_0].plan or nil) and iter_27_0 + 1 == self.selectedCellIdx)
	end

	return
end

function NewEducateScheduleScene:UpdateCell(arg_28_1)
	local var_28_0 = self.cells[arg_28_1].tf
	local var_28_1 = self.cells[arg_28_1].plan

	var_28_0.name = arg_28_1

	local var_28_2 = arg_28_1 <= self.unlockPlanNum

	setActive(var_28_0:Find("unlock"), arg_28_1 <= self.unlockPlanNum)
	setActive(var_28_0:Find("lock"), not var_28_2)

	if var_28_2 then
		setActive(var_28_0:Find("unlock/arrows"), false)
		setActive(var_28_0:Find("unlock/icon"), var_28_1)
		setActive(var_28_0:Find("unlock/reduce"), var_28_1 and arg_28_1 + 1 == self.selectedCellIdx)

		if var_28_1 then
			LoadImageSpriteAsync("neweducateicon/" .. var_28_1:getConfig("icon_square"), var_28_0:Find("unlock/icon"))
		end
	end

	onButton(self, var_28_0, function()
		if var_28_1 and arg_28_1 + 1 == self.selectedCellIdx then
			self.cells[arg_28_1].plan = nil
			self.selectedCellIdx = math.max(self.selectedCellIdx - 1, 1)

			self:UpdateCell(arg_28_1)
			self:UpdateCellReduce()
			self:UpdateReuslt()
		end

		return
	end, SFX_PANEL)

	return
end

function NewEducateScheduleScene:UpdatePlan(arg_30_1, arg_30_2)
	local var_30_0 = self.showList[arg_30_1 + 1]
	local var_30_1 = self.showList[arg_30_1 + 1]:GetNextId()

	setText(arg_30_2:Find("name"), self.showList[arg_30_1 + 1]:getConfig("name"))
	onButton(self, arg_30_2, function()
		self:OnClickPlan(var_30_0)

		return
	end, SFX_PANEL)
	LoadImageSpriteAsync("neweducateicon/" .. self.showList[arg_30_1 + 1]:getConfig("icon_rectangle"), arg_30_2:Find("icon"))

	local var_30_2 = self.showList[arg_30_1 + 1]:GetCostShowInfos()
	local var_30_3 = self.showList[arg_30_1 + 1]:GetCostWithBenefit(self.discountInfos)
	local var_30_4 = UIItemList.New(arg_30_2:Find("normal/cost"), arg_30_2:Find("normal/cost/tpl"))

	var_30_4:make(function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_0 == UIItemList.EventUpdate then
			NewEducateHelper.UpdateVectorItem(arg_32_2, var_30_2[arg_32_1 + 1], "-")

			if var_30_3[arg_32_1 + 1].number ~= var_30_2[arg_32_1 + 1].number then
				setText(arg_32_2:Find("value"), "-" .. var_30_2[arg_32_1 + 1].number .. "(" .. var_30_3[arg_32_1 + 1].number .. ")")
			end
		end

		return
	end)
	var_30_4:align(#var_30_2)
	LoadImageSpriteAtlasAsync("ui/neweducatescheduleui_atlas", self.showList[arg_30_1 + 1]:GetAwardBg(), arg_30_2:Find("normal/award"))

	local var_30_5 = self.showList[arg_30_1 + 1]:GetAwardShowInfos()
	local var_30_6 = UIItemList.New(arg_30_2:Find("normal/award"), arg_30_2:Find("normal/award/tpl"))

	var_30_6:make(function(arg_33_0, arg_33_1, arg_33_2)
		if arg_33_0 == UIItemList.EventUpdate then
			NewEducateHelper.UpdateVectorItem(arg_33_2, var_30_5[arg_33_1 + 1], var_30_5[arg_33_1 + 1].number > 0 and "+" or "")
		end

		return
	end)
	var_30_6:align(#var_30_5)
	setActive(arg_30_2:Find("toggle"), var_30_1)

	if var_30_1 then
		local var_30_7 = self.showList[arg_30_1 + 1]:getConfig("condition_desc")
		local var_30_8 = UIItemList.New(arg_30_2:Find("condition/conditions"), arg_30_2:Find("condition/conditions/tpl"))

		var_30_8:make(function(arg_34_0, arg_34_1, arg_34_2)
			if arg_34_0 == UIItemList.EventUpdate then
				local var_34_0 = var_30_7[arg_34_1 + 1][2]

				if not self.contextData.char:LogicalOperator({
					operator = "||",
					conditions = var_30_7[arg_34_1 + 1][1]
				}) then
					var_34_0 = string.gsub(var_34_0, "f7f7f7", "ff6767")
				end

				setText(arg_34_2:Find("name"), var_34_0)
				setActive(arg_34_2:Find("icon"), false)
				setActive(arg_34_2:Find("value"), false)
			end

			return
		end)
		var_30_8:align(#var_30_7)
	end

	return
end

function NewEducateScheduleScene:OnClickPlan(arg_35_1)
	if self.selectedCellIdx > self.unlockPlanNum then
		return
	end

	seriesAsync({
		function(arg_36_0)
			local var_36_0, var_36_1, var_36_2 = self:CalcPlanResult(arg_35_1)

			if self.contextData.char:GetRes(self.moneyResId) + self.moneyResult + var_36_0 < 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("child_plan_check_tip4"))

				return
			end

			arg_36_0()

			return
		end
	}, function()
		self.cells[self.selectedCellIdx].plan = arg_35_1

		self:UpdateCell(self.selectedCellIdx)

		self.selectedCellIdx = self.selectedCellIdx + 1

		self:UpdateCellReduce()
		self:UpdateReuslt()

		return
	end)

	return
end

function NewEducateScheduleScene:FlushPlanView()
	self.showList = underscore.select(self.planList, function(arg_39_0)
		return arg_39_0:IsShow()
	end)

	self.planUIList:align(#self.showList)

	return
end

function NewEducateScheduleScene:FlushTarot()
	self.tarotId = self.contextData.char:GetTarotId()

	setActive(self.tarotIconTF, self.tarotId)

	if self.tarotId then
		LoadImageSpriteAsync("neweducateicon/" .. pg.child2_benefit_list[self.tarotId].item_icon_little, self.tarotIconTF)
	end

	setText(self.tarotNameTF, (self.tarotId or nil) and (pg.child2_benefit_list[self.tarotId].name or "EMPTY"))

	self.entries = self.contextData.char:GetBenefitData():GetListByType(NewEducateBuff.TYPE.ENTRY)

	setText(self.tarotEntryTF, i18n("child2_entry_summary") .. #self.entries)

	return
end

function NewEducateScheduleScene:UpdateEffect(arg_41_1)
	setText(self.effectTF, string.gsub("$1", "$1", i18n("child2_mood_desc" .. self.contextData.char:GetMoodStage(arg_41_1))))

	return
end

function NewEducateScheduleScene:UpdateTalent(arg_42_1, arg_42_2)
	local var_42_0 = self.talents[arg_42_1 + 1]

	setActive(arg_42_2:Find("unlock"), self.talents[arg_42_1 + 1])
	setActive(arg_42_2:Find("lock"), not var_42_0)
	setImageAlpha(arg_42_2, var_42_0 and 1 or 0.4)

	if var_42_0 then
		LoadImageSpriteAsync("neweducateicon/" .. var_42_0:getConfig("item_icon_little"), arg_42_2:Find("unlock/icon"))
		setText(arg_42_2:Find("unlock/name"), shortenString(var_42_0:getConfig("name"), 5))
		setText(arg_42_2:Find("unlock/info/content/name"), var_42_0:getConfig("name"))
		setText(arg_42_2:Find("unlock/info/content/desc"), var_42_0:getConfig("desc"))
	end

	return
end

function NewEducateScheduleScene:UpdateStatus(arg_43_1, arg_43_2)
	local var_43_0 = self.status[arg_43_1 + 1]

	LoadImageSpriteAsync("neweducateicon/" .. self.status[arg_43_1 + 1]:getConfig("item_icon"), arg_43_2:Find("icon"))
	setText(arg_43_2:Find("time/Text"), var_43_0:getConfig("during_time") == -1 and i18n("child2_status_time2") or i18n("child2_status_time1", var_43_0:GetEndRound() - self.contextData.char:GetRoundData().round))
	setText(arg_43_2:Find("info/content/name"), var_43_0:getConfig("name"))
	setText(arg_43_2:Find("info/content/desc"), var_43_0:getConfig("desc"))

	return
end

function NewEducateScheduleScene:CalcPlanResult(arg_44_1)
	local var_44_0 = 0
	local var_44_1 = 0

	underscore.each(arg_44_1:GetCostWithBenefit(self.discountInfos), function(arg_45_0)
		switch(arg_45_0.type, {
			[NewEducateConst.DROP_TYPE.RES] = function()
				if arg_45_0.id == self.moneyResId then
					var_44_0 = var_44_0 + arg_45_0.number
				elseif arg_45_0.id == self.moodResId then
					var_44_1 = var_44_1 + arg_45_0.number
				end

				return
			end
		})

		return
	end)

	local var_44_2 = 0
	local var_44_3 = 0
	local var_44_4 = {}

	underscore.each(arg_44_1:GetAwardShowInfos(), function(arg_47_0)
		switch(arg_47_0.type, {
			[NewEducateConst.DROP_TYPE.RES] = function()
				if arg_47_0.id == self.moneyResId then
					var_44_2 = var_44_2 + arg_47_0.number
				elseif arg_47_0.id == self.moodResId then
					var_44_3 = var_44_3 + arg_47_0.number
				end

				return
			end,
			[NewEducateConst.DROP_TYPE.ATTR] = function()
				var_44_4[arg_47_0.id] = var_44_4[arg_47_0.id] or 0
				var_44_4[arg_47_0.id] = var_44_4[arg_47_0.id] + arg_47_0.number

				return
			end
		})

		return
	end)

	return 0 - 0, 0 - 0, var_44_4
end

function NewEducateScheduleScene:CalcCurResult()
	self.attrResult = {}
	self.moneyResult = 0
	self.moodResult = 0

	underscore.each(self.cells, function(arg_51_0)
		if arg_51_0.plan then
			local var_51_0, var_51_1, var_51_2 = self:CalcPlanResult(arg_51_0.plan)

			self.moneyResult = self.moneyResult + var_51_0
			self.moodResult = self.moodResult + var_51_1

			for iter_51_0, iter_51_1 in pairs(var_51_2) do
				self.attrResult[iter_51_0] = self.attrResult[iter_51_0] or 0
				self.attrResult[iter_51_0] = self.attrResult[iter_51_0] + iter_51_1
			end
		end

		return
	end)

	return
end

function NewEducateScheduleScene:GetColor(arg_52_1)
	if arg_52_1 == 0 then
		return "ffffff"
	else
		return arg_52_1 > 0 and "2df7bc" or "ff6767"
	end

	return
end

function NewEducateScheduleScene:UpdateAttr(arg_53_1, arg_53_2)
	local var_53_0 = self.contextData.char:GetAttr(self.attrIds[arg_53_1 + 1])
	local var_53_1, var_53_2 = NewEducateInfoPanel.GetArrtInfo(pg.child2_attr[self.attrIds[arg_53_1 + 1]].rank, var_53_0)

	setText(arg_53_2:Find("rank/Text"), var_53_1)
	setImageColor(arg_53_2:Find("rank"), Color.NewHex(EducateConst.GRADE_2_COLOR[var_53_1][2]))
	setText(arg_53_2:Find("before_value"), var_53_0)

	local var_53_3 = self.attrResult[self.attrIds[arg_53_1 + 1]] or 0

	setText(arg_53_2:Find("after_value"), var_53_0 + var_53_3)

	local var_53_4 = self:GetColor(var_53_3)

	setImageColor(arg_53_2:Find("arrow"), Color.NewHex(var_53_4))
	setTextColor(arg_53_2:Find("after_value"), Color.NewHex(var_53_4))

	return
end

function NewEducateScheduleScene:UpdateReuslt()
	self.selectedCnt = underscore.reduce(self.cells, 0, function(arg_55_0, arg_55_1)
		return arg_55_0 + (arg_55_1.plan and 1 or 0)
	end)

	setText(self.planCountTF, self.selectedCnt .. "/" .. self.unlockPlanNum)
	self:CalcCurResult()

	local var_54_0 = self.contextData.char:GetRes(self.moneyResId)

	setText(self.moneyTF:Find("before_value"), var_54_0)
	setText(self.moneyTF:Find("after_value"), var_54_0 + self.moneyResult)

	local var_54_1 = self:GetColor(self.moneyResult)

	setImageColor(self.moneyTF:Find("arrow"), Color.NewHex(var_54_1))
	setTextColor(self.moneyTF:Find("after_value"), Color.NewHex(var_54_1))

	local var_54_2 = self.contextData.char:GetRes(self.moodResId)

	setText(self.moodTF:Find("before_value"), var_54_2)

	local var_54_3 = math.min(pg.child2_resource[self.moodResId].max_value, (math.max(pg.child2_resource[self.moodResId].min_value, var_54_2 + self.moodResult)))

	setText(self.moodTF:Find("after_value"), var_54_3)

	local var_54_4 = self:GetColor(self.moodResult)

	setImageColor(self.moodTF:Find("arrow"), Color.NewHex(var_54_4))
	setTextColor(self.moodTF:Find("after_value"), Color.NewHex(var_54_4))
	self:UpdateEffect(var_54_3)
	self.attrUIList:align(#self.attrIds)

	return
end

function NewEducateScheduleScene:SetScheduleData(arg_56_1)
	self.contextData.scheduleDataTable.OnScheduleDone = arg_56_1

	return
end

function NewEducateScheduleScene:OnClickNextBtn()
	local var_57_0 = {}
	local var_57_1 = ""
	local var_57_2 = false

	if self.selectedCnt < self.unlockPlanNum then
		var_57_1 = i18n("child2_schedule_sure_tip")
		var_57_2 = true
	end

	if self.contextData.char:GetPoint() > 0 then
		var_57_1 = var_57_2 and i18n("child2_schedule_sure_tip3") or i18n("child2_schedule_sure_tip2")
	end

	table.insert(var_57_0, function(arg_58_0)
		if var_57_1 ~= "" then
			self:emit(NewEducateScheduleScene.ON_BOX, {
				content = var_57_1,
				onYes = arg_58_0
			})
		else
			arg_58_0()
		end

		return
	end)
	seriesAsync(var_57_0, function()
		self:emit(NewEducateScheduleMediator.ON_SELECTED_PLANS, self.skipToggleCom.isOn, self.cells)

		return
	end)

	return
end

function NewEducateScheduleScene:willExit()
	self:UnOverlayPanel(self.mainTF, self.rootTF)

	return
end

return NewEducateScheduleScene
