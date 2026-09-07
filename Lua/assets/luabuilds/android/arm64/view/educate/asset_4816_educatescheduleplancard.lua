local EducateSchedulePlanCard = class("EducateSchedulePlanCard")
local var_0_1 = {
	top = 0,
	spacing = 8,
	size = {
		x = 216,
		y = 142
	}
}
local var_0_2 = {
	top = 4,
	spacing = 14,
	size = {
		x = 216,
		y = 328
	}
}
local var_0_3 = {
	x = 0,
	y = 87
}
local var_0_4 = {
	x = 0,
	y = 110
}

function EducateSchedulePlanCard:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self._go = arg_1_1
	self._tf = tf(self._go)
	self.viewComponent = arg_1_2
	self.selectedTF = self._tf:Find("selected")
	self.iconBgTF = self._tf:Find("icon_bg")
	self.iconTF = self.iconBgTF:Find("icon")
	self.progressTF = self._tf:Find("progress")
	self.sliderTF = self._tf:Find("slider")
	self.nameTF = self._tf:Find("name_mask")
	self.nameTextTF = self.nameTF:Find("name")
	self.enNameTF = self._tf:Find("name_en")
	self.limitTF = self._tf:Find("limit")
	self.limitUIList = UIItemList.New(self.limitTF, self.limitTF:Find("tpl"))

	self.limitUIList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			self:updateLimitItem(arg_2_1, arg_2_2)
		end

		return
	end)

	self.costTF = self._tf:Find("cost")
	self.costEmptyTF = self._tf:Find("cost_empty")

	setText(self.costEmptyTF:Find("Text"), i18n("child_plan_no_cost"))

	self.costUIList = UIItemList.New(self.costTF, self.costTF:Find("tpl"))

	self.costUIList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			self:updateCostItem(arg_3_1, arg_3_2)
		end

		return
	end)

	self.awardTF = self._tf:Find("award")
	self.awardUIList = UIItemList.New(self.awardTF:Find("content"), self.awardTF:Find("content/tpl"))

	self.awardUIList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			self:updateAwardItem(arg_4_1, arg_4_2)
		end

		return
	end)

	self.foldBtn = self.awardTF:Find("fold_btn")
	self.unfoldBtn = self.awardTF:Find("unfold_btn")
	self.awardLayouCom = self.awardTF:Find("content"):GetComponent(typeof(VerticalLayoutGroup))
	self.char = getProxy(EducateProxy):GetCharData()

	return
end

function EducateSchedulePlanCard:updateLimitItem(arg_5_1, arg_5_2)
	local var_5_0 = self.limitCfg[arg_5_1 + 1]

	LoadImageSpriteAtlasAsync("ui/educatecommonui_atlas", "attr_" .. self.limitCfg[arg_5_1 + 1][2], findTF(arg_5_2, "icon_bg/icon"), true)
	setText(findTF(arg_5_2, "value"), var_5_0[3])
	setText(findTF(arg_5_2, "name"), pg.child_attr[self.limitCfg[arg_5_1 + 1][2]].name)

	local var_5_1 = var_5_0[4] and "606064" or "ed7373"

	setTextColor(findTF(arg_5_2, "value"), Color.NewHex(var_5_0[4] and "606064" or "ed7373"))
	setTextColor(findTF(arg_5_2, "name"), Color.NewHex(var_5_1))

	return
end

function EducateSchedulePlanCard:updateCostItem(arg_6_1, arg_6_2)
	LoadImageSpriteAtlasAsync("ui/educatecommonui_atlas", "res_" .. self.costCfg[arg_6_1 + 1].id, findTF(arg_6_2, "icon"), true)
	setText(findTF(arg_6_2, "value"), "-" .. self.costCfg[arg_6_1 + 1].num)
	setText(findTF(arg_6_2, "name"), pg.child_resource[self.costCfg[arg_6_1 + 1].id].name)

	return
end

function EducateSchedulePlanCard:updateAwardItem(arg_7_1, arg_7_2)
	EducateHelper.UpdateDropShowForAttr(arg_7_2, {
		type = self.awardCfg[arg_7_1 + 1][1],
		id = self.awardCfg[arg_7_1 + 1][2],
		number = self.awardCfg[arg_7_1 + 1][3]
	})

	return
end

function EducateSchedulePlanCard:update(arg_8_1, arg_8_2)
	setActive(self.selectedTF, arg_8_1.id == arg_8_2)
	GetImageSpriteFromAtlasAsync("ui/educatescheduleui_atlas", arg_8_1:GetIconBgName(), self.iconBgTF, true)
	LoadImageSpriteAsync("educateprops/" .. arg_8_1:getConfig("icon"), self.iconTF, true)

	local var_8_0 = arg_8_1:getConfig("pre_next")

	setActive(self.progressTF, var_8_0 ~= 0)
	setActive(self.sliderTF, var_8_0 ~= 0)
	setActive(self.enNameTF, var_8_0 == 0)

	if var_8_0 ~= 0 then
		assert(pg.child_plan[var_8_0], "no exist next plan id" .. var_8_0)

		local var_8_1 = pg.child_plan[var_8_0].pre[2]
		local var_8_2 = getProxy(EducateProxy):GetPlanProxy():GetHistoryCntById(arg_8_1.id)
		local var_8_3 = var_8_2 / pg.child_plan[var_8_0].pre[2]

		setSlider(self.sliderTF, 0, 1, var_8_2 / pg.child_plan[var_8_0].pre[2])
		setText(self.progressTF, var_8_3 >= 1 and "MAX" or var_8_2 .. "/" .. var_8_1)
	end

	setScrollText(self.nameTextTF, arg_8_1:getConfig("name"))
	setLocalPosition(self.nameTF, (var_8_0 == 0 or nil) and (var_0_4 or var_0_3))

	local var_8_4 = not arg_8_1:IsMatchAttr(self.char)

	setActive(self.limitTF, var_8_4)

	local var_8_5 = arg_8_1:getConfig("ability")

	self.limitCfg = {}

	for iter_8_0 = 1, #var_8_5 do
		local var_8_6 = Clone(var_8_5[iter_8_0])

		table.insert(var_8_6, self.char:GetAttrById(var_8_6[2]) >= var_8_6[3])
		table.insert(self.limitCfg, var_8_6)
	end

	table.sort(self.limitCfg, CompareFuncs({
		function(arg_9_0)
			return arg_9_0[4] and 1 or 0
		end
	}))
	self.limitUIList:align(#self.limitCfg)

	self.costCfg = {}

	local var_8_7, var_8_8 = arg_8_1:GetCost()

	if var_8_7 > 0 then
		table.insert(self.costCfg, {
			id = EducateChar.RES_MONEY_ID,
			num = var_8_7
		})
	end

	if var_8_8 > 0 then
		table.insert(self.costCfg, {
			id = EducateChar.RES_MOOD_ID,
			num = var_8_8
		})
	end

	setActive(self.costTF, not var_8_4)
	setActive(self.costEmptyTF, not var_8_4 and #self.costCfg == 0)
	self.costUIList:align(#self.costCfg)

	self.awardCfg = arg_8_1:GetResult()

	self:setAwardParam(var_0_1)
	self.awardUIList:align(#self.awardCfg > 2 and 2 or #self.awardCfg)
	setActive(self.unfoldBtn, #self.awardCfg > 2)
	setActive(self.foldBtn, false)
	onButton(self, self.unfoldBtn, function()
		self:setAwardParam(var_0_2)
		setActive(self.foldBtn, true)
		setActive(self.unfoldBtn, false)
		setActive(self.limitTF, false)
		setActive(self.costTF, false)
		setActive(self.costEmptyTF, false)
		self.awardUIList:align(#self.awardCfg)

		return
	end, SFX_PANEL)
	onButton(self, self.foldBtn, function()
		self:setAwardParam(var_0_1)
		setActive(self.foldBtn, false)
		setActive(self.unfoldBtn, true)
		setActive(self.limitTF, var_8_4)
		setActive(self.costTF, not var_8_4)
		setActive(self.costEmptyTF, not var_8_4 and #self.costCfg == 0)
		self.awardUIList:align(#self.awardCfg > 2 and 2 or #self.awardCfg)

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self.viewComponent:OnPlanCardClick(arg_8_1)

		return
	end, SFX_PANEL)

	return
end

function EducateSchedulePlanCard:setAwardParam(arg_13_1)
	setSizeDelta(self.awardTF, arg_13_1.size)

	self.awardLayouCom.spacing = arg_13_1.spacing
	self.awardLayouCom.padding.top = arg_13_1.top

	return
end

function EducateSchedulePlanCard:dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return EducateSchedulePlanCard
