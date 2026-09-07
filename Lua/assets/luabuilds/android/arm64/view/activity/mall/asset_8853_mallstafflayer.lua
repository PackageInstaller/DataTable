local MallStaffLayer = class("MallStaffLayer", import("view.base.BaseUI"))

MallStaffLayer.ATTR_INFOS = {
	{
		"ring_yellow",
		"#ffe59b"
	},
	{
		"ring_green",
		"#9ecf76"
	},
	{
		"ring_blue",
		"#769acf"
	}
}

function MallStaffLayer:getUIName()
	return "MallStaffUI"
end

function MallStaffLayer:init()
	onButton(self, self.uiBackBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.uiHomeBtn, function()
		self:quickExitFunc()

		return
	end, SOUND_BACK)
	onButton(self, self.uiHelpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.mall_help.tip
		})

		return
	end, SFX_PANEL)

	self.floorsUIList = UIItemList.New(self.uiFloorsTF, self.uiFloorsTF:Find("tpl"))

	self.floorsUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventInit then
			self:InitFloorTpl(arg_6_1, arg_6_2)
		elseif arg_6_0 == UIItemList.EventUpdate then
			self:UpdateFloorTpl(arg_6_1, arg_6_2)
		end

		return
	end)

	self.targetUIList = UIItemList.New(self.uiTargetTF, self.uiTargetTF:Find("tpl"))

	self.targetUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:UpdateTargetTpl(arg_7_1, arg_7_2)
		end

		return
	end)

	self.scrollCom = self.uiScrollTF:GetComponent("LScrollRect")

	function self.scrollCom.onInitItem(arg_8_0)
		self:OnInitStaffItem(arg_8_0)

		return
	end

	function self.scrollCom.onUpdateItem(arg_9_0, arg_9_1)
		self:OnUpdateStaffItem(arg_9_0, arg_9_1)

		return
	end

	setText(self.uiTitleText, i18n("mall_title"))
	setText(self.uiTitleEnText, i18n("mall_title_en"))
	setText(self.uiFloorsTF:Find("tpl/lock/Text"), i18n("mall_floor_lock"))
	eachChild(self.uiRankTF:Find("open"), function(arg_10_0)
		setText(arg_10_0, MallUtil.RANK2NAME[tonumber(arg_10_0.name)])

		return
	end)

	return
end

function MallStaffLayer:didEnter()
	self.curFloorId = self.contextData.floorId

	self:UpdateData()
	self:UpdateView()

	return
end

function MallStaffLayer:UpdateData()
	self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)
	self.level = self.activity:GetLevelData().level
	self.floorList = self.activity:GetFloorList()
	self.staffList = self.activity:GetStaffList()
	self.cards = {}

	return
end

function MallStaffLayer:UpdateView()
	self.floorsUIList:align(#self.floorList)
	triggerButton(self.floorsUIList.container:Find(tostring(self.curFloorId)))

	return
end

function MallStaffLayer:InitFloorTpl(arg_14_1, arg_14_2)
	arg_14_2.name = self.floorList[arg_14_1 + 1].id

	GetImageSpriteFromAtlasAsync("ui/mallstaffui_atlas", self.floorList[arg_14_1 + 1].id .. "f", arg_14_2:Find("unsel/f"), true)
	GetImageSpriteFromAtlasAsync("ui/mallstaffui_atlas", self.floorList[arg_14_1 + 1].id .. "f_sel", arg_14_2:Find("sel/f"), true)

	return
end

function MallStaffLayer:UpdateFloorTpl(arg_15_1, arg_15_2)
	local var_15_0 = self.floorList[arg_15_1 + 1]

	setActive(arg_15_2:Find("lock"), not self.floorList[arg_15_1 + 1]:IsUnlock())

	local var_15_1 = var_15_0.id == self.curFloorId

	setActive(arg_15_2:Find("sel"), var_15_0.id == self.curFloorId)
	setActive(arg_15_2:Find("unsel"), not var_15_1)

	if not var_15_0:IsUnlock() then
		setActive(arg_15_2:Find("staffs"), false)

		return
	end

	setActive(arg_15_2:Find("staffs"), true)

	local var_15_2 = var_15_0:GetStaffList()

	UIItemList.StaticAlign(arg_15_2:Find("staffs"), arg_15_2:Find("staffs/tpl"), #var_15_2, function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			local var_16_0 = self.activity:GetStaff(var_15_2[arg_16_1 + 1])

			setActive(arg_16_2:Find("icon"), var_16_0)

			if var_16_0 then
				MallStaffCard.StaticUpdateIcon(arg_16_2:Find("icon"), var_16_0.tid)
			end

			onButton(self, arg_16_2, function()
				if self.curFloorId ~= var_15_0.id then
					triggerButton(arg_15_2)

					return
				end

				if not var_16_0 then
					return
				end

				self.activity:SetFloorStaff(var_15_0.id, arg_16_1 + 1, 0)
				self:UpdateView()

				return
			end)
		end

		return
	end)
	onButton(self, arg_15_2, function()
		if not var_15_0:IsUnlock() then
			return
		end

		self.curFloorId = var_15_0.id

		self.floorsUIList:eachActive(function(arg_19_0, arg_19_1)
			local var_19_0 = self.floorList[arg_19_0 + 1].id == self.curFloorId

			setActive(arg_19_1:Find("sel"), self.floorList[arg_19_0 + 1].id == self.curFloorId)
			setActive(arg_19_1:Find("unsel"), not var_19_0)
			eachChild(arg_19_1:Find("staffs"), function(arg_20_0)
				setActive(arg_20_0:Find("c_sel"), var_19_0)
				setActive(arg_20_0:Find("c"), not var_19_0)

				return
			end)

			return
		end)
		MallStaffLayer.CheckUpdateFloorStaffs(self.activity)
		self:UpdataRight()

		return
	end)

	return
end

function MallStaffLayer:UpdataRight()
	self.selIds = underscore.select(self.activity:GetFloor(self.curFloorId):GetStaffList(), function(arg_22_0)
		return arg_22_0 ~= 0
	end)

	GetImageSpriteFromAtlasAsync("ui/mallstaffui_atlas", "title_" .. self.curFloorId .. "f", self.uiRightTitleTF, true)

	self.allAttrDatas = {}

	local var_21_0 = self.activity:GetFloor(self.curFloorId)

	for iter_21_0, iter_21_1 in ipairs(var_21_0:GetTargetInfos(self.level)) do
		table.insert(self.allAttrDatas, {
			cur = 0,
			id = iter_21_0,
			base = iter_21_1[1],
			max = iter_21_1[2]
		})
	end

	for iter_21_2, iter_21_3 in ipairs(var_21_0:GetStaffList()) do
		if iter_21_3 ~= 0 then
			for iter_21_4, iter_21_5 in ipairs(self.activity:GetStaff(iter_21_3):GetAttrList()) do
				self.allAttrDatas[iter_21_4].cur = self.allAttrDatas[iter_21_4].cur + iter_21_5
			end
		end
	end

	self.showAttrDatas = underscore.select(self.allAttrDatas, function(arg_23_0)
		return arg_23_0.base ~= 0 and arg_23_0.max ~= 0
	end)

	table.sort(self.showAttrDatas, CompareFuncs({
		function(arg_24_0)
			return arg_24_0.id
		end
	}))

	local var_21_1 = MallUtil.GetFloorRank(underscore.reduce(self.showAttrDatas, 0, function(arg_25_0, arg_25_1)
		return arg_25_0 + arg_25_1.cur
	end), (underscore.reduce(self.showAttrDatas, 0, function(arg_26_0, arg_26_1)
		return arg_26_0 + arg_26_1.base
	end)))
	local var_21_2 = var_21_1 ~= MallUtil.FLOOR_RANK.CLOSE

	setActive(self.uiRankTF:Find("open"), var_21_1 ~= MallUtil.FLOOR_RANK.CLOSE)
	setActive(self.uiRankTF:Find("close"), not var_21_2)

	if var_21_2 then
		eachChild(self.uiRankTF:Find("open"), function(arg_27_0)
			setActive(arg_27_0, tonumber(arg_27_0.name) == var_21_1)

			return
		end)
	end

	self.targetUIList:align(#self.showAttrDatas)
	self:SortList()
	self.scrollCom:SetTotalCount(#self.staffList)

	return
end

function MallStaffLayer:SortList()
	table.sort(self.staffList, CompareFuncs({
		function(arg_29_0)
			local var_29_0, var_29_1 = arg_29_0:GetStatusInfos()

			return var_29_0 == MallStaff.STATUS.ORDER and 1 or 0
		end,
		function(arg_30_0)
			local var_30_0, var_30_1 = arg_30_0:GetStatusInfos()

			return var_30_0 == MallStaff.STATUS.FLOOR and var_30_1.floorId ~= self.curFloorId and 1 or 0
		end,
		function(arg_31_0)
			return -arg_31_0.id
		end
	}))

	return
end

function MallStaffLayer:UpdateTargetTpl(arg_32_1, arg_32_2)
	GetImageSpriteFromAtlasAsync("ui/mallstaffui_atlas", "attr" .. self.showAttrDatas[arg_32_1 + 1].id, arg_32_2:Find("icon"), true)

	local var_32_0 = self:GetAttrInfos(self.showAttrDatas[arg_32_1 + 1])

	GetImageSpriteFromAtlasAsync("ui/mallstaffui_atlas", var_32_0[1], arg_32_2:Find("ring/v"), true)
	setFillAmount(arg_32_2:Find("ring/r"), self.showAttrDatas[arg_32_1 + 1].base / self.showAttrDatas[arg_32_1 + 1].max)
	setFillAmount(arg_32_2:Find("ring/v"), self.showAttrDatas[arg_32_1 + 1].cur / self.showAttrDatas[arg_32_1 + 1].max)
	setText(arg_32_2:Find("bg/Text"), (setColorStr(self.showAttrDatas[arg_32_1 + 1].cur, var_32_0[2]) or self.showAttrDatas[arg_32_1 + 1].cur) .. "/" .. self.showAttrDatas[arg_32_1 + 1].max)

	return
end

function MallStaffLayer:GetAttrInfos(arg_33_1)
	if arg_33_1.cur >= arg_33_1.max then
		return MallStaffLayer.ATTR_INFOS[3]
	end

	if arg_33_1.cur >= arg_33_1.base then
		return MallStaffLayer.ATTR_INFOS[2]
	end

	return MallStaffLayer.ATTR_INFOS[1]
end

function MallStaffLayer:OnInitStaffItem(arg_34_1)
	local var_34_0 = MallStaffCard.New(arg_34_1)

	onButton(self, var_34_0._go, function()
		local var_35_0 = self.activity:GetFloor(self.curFloorId):GetEmptyIdx()

		if not var_35_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("mall_staff_position_full_tip"))

			return
		end

		local var_35_1, var_35_2 = var_34_0.staff:GetStatusInfos()

		if var_35_1 == MallStaff.STATUS.ORDER then
			return
		end

		if var_35_1 == MallStaff.STATUS.FLOOR and var_35_2.floorId == self.curFloorId then
			return
		end

		seriesAsync({
			function(arg_36_0)
				if var_35_1 == MallStaff.STATUS.FLOOR then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("mall_change_floor_sure"),
						onYes = function()
							self.activity:SetFloorStaff(var_35_2.floorId, var_35_2.floorIdx, 0)
							arg_36_0()

							return
						end
					})
				else
					arg_36_0()
				end

				return
			end
		}, function()
			self.activity:SetFloorStaff(self.curFloorId, var_35_0, var_34_0.id)
			self:UpdateView()

			return
		end)

		return
	end, SFX_PANEL)

	self.cards[arg_34_1] = var_34_0

	return
end

function MallStaffLayer:OnUpdateStaffItem(arg_39_1, arg_39_2)
	if not self.cards[arg_39_2] then
		self:OnInitStaffItem(arg_39_2)
	end

	self.cards[arg_39_2]:Update(self.staffList[arg_39_1 + 1], self.selIds, true, (underscore.map(self.showAttrDatas, function(arg_40_0)
		return arg_40_0.id
	end)))

	return
end

function MallStaffLayer:willExit()
	MallStaffLayer.CheckUpdateFloorStaffs(self.activity)
	ClearLScrollrect(self.scrollCom)

	for iter_41_0, iter_41_1 in pairs(self.cards) do
		iter_41_1:Dispose()
	end

	self.cards = {}

	return
end

function MallStaffLayer:CheckUpdateFloorStaffs(arg_42_1)
	if self:NeedUpdateFloorStaff() then
		pg.m02:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = self.id,
			cmd = ActivityMallOPCommand.CMD.SET_FLOOR_STAFF,
			arg_list = self:GetFloorStaffList(),
			callback = arg_42_1
		})
	end

	return
end

return MallStaffLayer
