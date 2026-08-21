local var_0_0 = class("MallStaffLayer", import("view.base.BaseUI"))

var_0_0.ATTR_INFOS = {
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

function var_0_0.getUIName(arg_1_0)
	return "MallStaffUI"
end

function var_0_0.init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiBackBtn, function()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiHomeBtn, function()
		arg_2_0:quickExitFunc()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiHelpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.mall_help.tip
		})

		return
	end, SFX_PANEL)

	arg_2_0.floorsUIList = UIItemList.New(arg_2_0.uiFloorsTF, arg_2_0.uiFloorsTF:Find("tpl"))

	arg_2_0.floorsUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventInit then
			arg_2_0:InitFloorTpl(arg_6_1, arg_6_2)
		elseif arg_6_0 == UIItemList.EventUpdate then
			arg_2_0:UpdateFloorTpl(arg_6_1, arg_6_2)
		end

		return
	end)

	arg_2_0.targetUIList = UIItemList.New(arg_2_0.uiTargetTF, arg_2_0.uiTargetTF:Find("tpl"))

	arg_2_0.targetUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_2_0:UpdateTargetTpl(arg_7_1, arg_7_2)
		end

		return
	end)

	arg_2_0.scrollCom = arg_2_0.uiScrollTF:GetComponent("LScrollRect")

	function arg_2_0.scrollCom.onInitItem(arg_8_0)
		arg_2_0:OnInitStaffItem(arg_8_0)

		return
	end

	function arg_2_0.scrollCom.onUpdateItem(arg_9_0, arg_9_1)
		arg_2_0:OnUpdateStaffItem(arg_9_0, arg_9_1)

		return
	end

	setText(arg_2_0.uiTitleText, i18n("mall_title"))
	setText(arg_2_0.uiTitleEnText, i18n("mall_title_en"))
	setText(arg_2_0.uiFloorsTF:Find("tpl/lock/Text"), i18n("mall_floor_lock"))
	eachChild(arg_2_0.uiRankTF:Find("open"), function(arg_10_0)
		setText(arg_10_0, MallUtil.RANK2NAME[tonumber(arg_10_0.name)])

		return
	end)

	return
end

function var_0_0.didEnter(arg_11_0)
	arg_11_0.curFloorId = arg_11_0.contextData.floorId

	arg_11_0:UpdateData()
	arg_11_0:UpdateView()

	return
end

function var_0_0.UpdateData(arg_12_0)
	arg_12_0.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)
	arg_12_0.level = arg_12_0.activity:GetLevelData().level
	arg_12_0.floorList = arg_12_0.activity:GetFloorList()
	arg_12_0.staffList = arg_12_0.activity:GetStaffList()
	arg_12_0.cards = {}

	return
end

function var_0_0.UpdateView(arg_13_0)
	arg_13_0.floorsUIList:align(#arg_13_0.floorList)
	triggerButton(arg_13_0.floorsUIList.container:Find(tostring(arg_13_0.curFloorId)))

	return
end

function var_0_0.InitFloorTpl(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2.name = arg_14_0.floorList[arg_14_1 + 1].id

	GetImageSpriteFromAtlasAsync("ui/mallstaffui_atlas", arg_14_0.floorList[arg_14_1 + 1].id .. "f", arg_14_2:Find("unsel/f"), true)
	GetImageSpriteFromAtlasAsync("ui/mallstaffui_atlas", arg_14_0.floorList[arg_14_1 + 1].id .. "f_sel", arg_14_2:Find("sel/f"), true)

	return
end

function var_0_0.UpdateFloorTpl(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.floorList[arg_15_1 + 1]

	setActive(arg_15_2:Find("lock"), not arg_15_0.floorList[arg_15_1 + 1]:IsUnlock())

	local var_15_1 = var_15_0.id == arg_15_0.curFloorId

	setActive(arg_15_2:Find("sel"), var_15_0.id == arg_15_0.curFloorId)
	setActive(arg_15_2:Find("unsel"), not var_15_1)

	if not var_15_0:IsUnlock() then
		setActive(arg_15_2:Find("staffs"), false)

		return
	end

	setActive(arg_15_2:Find("staffs"), true)
	UIItemList.StaticAlign(arg_15_2:Find("staffs"), arg_15_2:Find("staffs/tpl"), #var_15_0:GetStaffList(), function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			local var_16_0 = arg_15_0.activity:GetStaff(var_0[arg_16_1 + 1])

			setActive(arg_16_2:Find("icon"), var_16_0)

			if var_16_0 then
				MallStaffCard.StaticUpdateIcon(arg_16_2:Find("icon"), var_16_0.tid)
			end

			onButton(arg_15_0, arg_16_2, function()
				if arg_15_0.curFloorId ~= var_15_0.id then
					triggerButton(arg_15_2)

					return
				end

				if not var_16_0 then
					return
				end

				arg_15_0.activity:SetFloorStaff(var_15_0.id, arg_16_1 + 1, 0)
				arg_15_0:UpdateView()

				return
			end)
		end

		return
	end)
	onButton(arg_15_0, arg_15_2, function()
		if not var_15_0:IsUnlock() then
			return
		end

		arg_15_0.curFloorId = var_15_0.id

		arg_15_0.floorsUIList:eachActive(function(arg_19_0, arg_19_1)
			local var_19_0 = arg_15_0.floorList[arg_19_0 + 1].id == arg_15_0.curFloorId

			setActive(arg_19_1:Find("sel"), arg_15_0.floorList[arg_19_0 + 1].id == arg_15_0.curFloorId)
			setActive(arg_19_1:Find("unsel"), not var_19_0)
			eachChild(arg_19_1:Find("staffs"), function(arg_20_0)
				setActive(arg_20_0:Find("c_sel"), var_19_0)
				setActive(arg_20_0:Find("c"), not var_19_0)

				return
			end)

			return
		end)
		var_0_0.CheckUpdateFloorStaffs(arg_15_0.activity)
		arg_15_0:UpdataRight()

		return
	end)

	return
end

function var_0_0.UpdataRight(arg_21_0)
	arg_21_0.selIds = underscore.select(arg_21_0.activity:GetFloor(arg_21_0.curFloorId):GetStaffList(), function(arg_22_0)
		return arg_22_0 ~= 0
	end)

	GetImageSpriteFromAtlasAsync("ui/mallstaffui_atlas", "title_" .. arg_21_0.curFloorId .. "f", arg_21_0.uiRightTitleTF, true)

	arg_21_0.allAttrDatas = {}

	local var_21_0 = arg_21_0.activity:GetFloor(arg_21_0.curFloorId)

	for iter_21_0, iter_21_1 in ipairs(var_21_0:GetTargetInfos(arg_21_0.level)) do
		table.insert(arg_21_0.allAttrDatas, {
			cur = 0,
			id = iter_21_0,
			base = iter_21_1[1],
			max = iter_21_1[2]
		})
	end

	for iter_21_2, iter_21_3 in ipairs(var_21_0:GetStaffList()) do
		if iter_21_3 ~= 0 then
			local var_21_1 = arg_21_0.activity:GetStaff(iter_21_3)

			for iter_21_4, iter_21_5 in ipairs(var_21_1:GetAttrList()) do
				arg_21_0.allAttrDatas[iter_21_4].cur = arg_21_0.allAttrDatas[iter_21_4].cur + iter_21_5
			end
		end
	end

	arg_21_0.showAttrDatas = underscore.select(arg_21_0.allAttrDatas, function(arg_23_0)
		return arg_23_0.base ~= 0 and arg_23_0.max ~= 0
	end)

	table.sort(arg_21_0.showAttrDatas, CompareFuncs({
		function(arg_24_0)
			return arg_24_0.id
		end
	}))

	local var_21_2 = MallUtil.GetFloorRank(underscore.reduce(arg_21_0.showAttrDatas, 0, function(arg_25_0, arg_25_1)
		return arg_25_0 + arg_25_1.cur
	end), (underscore.reduce(arg_21_0.showAttrDatas, 0, function(arg_26_0, arg_26_1)
		return arg_26_0 + arg_26_1.base
	end))) ~= MallUtil.FLOOR_RANK.CLOSE

	setActive(arg_21_0.uiRankTF:Find("open"), var_21_2)
	setActive(arg_21_0.uiRankTF:Find("close"), not var_21_2)

	if var_21_2 then
		eachChild(arg_21_0.uiRankTF:Find("open"), function(arg_27_0)
			setActive(arg_27_0, tonumber(arg_27_0.name) == var_0)

			return
		end)
	end

	arg_21_0.targetUIList:align(#arg_21_0.showAttrDatas)
	arg_21_0:SortList()
	arg_21_0.scrollCom:SetTotalCount(#arg_21_0.staffList)

	return
end

function var_0_0.SortList(arg_28_0)
	table.sort(arg_28_0.staffList, CompareFuncs({
		function(arg_29_0)
			local var_29_0, var_29_1 = arg_29_0:GetStatusInfos()

			return var_29_0 == MallStaff.STATUS.ORDER and 1 or 0
		end,
		function(arg_30_0)
			local var_30_0, var_30_1 = arg_30_0:GetStatusInfos()

			return var_30_0 == MallStaff.STATUS.FLOOR and var_30_1.floorId ~= arg_28_0.curFloorId and 1 or 0
		end,
		function(arg_31_0)
			return -arg_31_0.id
		end
	}))

	return
end

function var_0_0.UpdateTargetTpl(arg_32_0, arg_32_1, arg_32_2)
	GetImageSpriteFromAtlasAsync("ui/mallstaffui_atlas", "attr" .. arg_32_0.showAttrDatas[arg_32_1 + 1].id, arg_32_2:Find("icon"), true)

	local var_32_0 = arg_32_0:GetAttrInfos(arg_32_0.showAttrDatas[arg_32_1 + 1])

	GetImageSpriteFromAtlasAsync("ui/mallstaffui_atlas", var_32_0[1], arg_32_2:Find("ring/v"), true)
	setFillAmount(arg_32_2:Find("ring/r"), arg_32_0.showAttrDatas[arg_32_1 + 1].base / arg_32_0.showAttrDatas[arg_32_1 + 1].max)
	setFillAmount(arg_32_2:Find("ring/v"), arg_32_0.showAttrDatas[arg_32_1 + 1].cur / arg_32_0.showAttrDatas[arg_32_1 + 1].max)

	local var_32_1 = setColorStr(arg_32_0.showAttrDatas[arg_32_1 + 1].cur, var_32_0[2]) or arg_32_0.showAttrDatas[arg_32_1 + 1].cur

	setText(arg_32_2:Find("bg/Text"), var_32_1 .. "/" .. arg_32_0.showAttrDatas[arg_32_1 + 1].max)

	return
end

function var_0_0.GetAttrInfos(arg_33_0, arg_33_1)
	if arg_33_1.cur >= arg_33_1.max then
		return var_0_0.ATTR_INFOS[3]
	end

	if arg_33_1.cur >= arg_33_1.base then
		return var_0_0.ATTR_INFOS[2]
	end

	return var_0_0.ATTR_INFOS[1]
end

function var_0_0.OnInitStaffItem(arg_34_0, arg_34_1)
	local var_34_0 = MallStaffCard.New(arg_34_1)

	onButton(arg_34_0, var_34_0._go, function()
		if not arg_34_0.activity:GetFloor(arg_34_0.curFloorId):GetEmptyIdx() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("mall_staff_position_full_tip"))

			return
		end

		local var_35_0, var_35_1 = var_34_0.staff:GetStatusInfos()

		if var_35_0 == MallStaff.STATUS.ORDER then
			return
		end

		if var_35_0 == MallStaff.STATUS.FLOOR and var_35_1.floorId == arg_34_0.curFloorId then
			return
		end

		seriesAsync({
			function(arg_36_0)
				if var_35_0 == MallStaff.STATUS.FLOOR then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("mall_change_floor_sure"),
						onYes = function()
							arg_34_0.activity:SetFloorStaff(var_35_1.floorId, var_35_1.floorIdx, 0)
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
			arg_34_0.activity:SetFloorStaff(arg_34_0.curFloorId, var_0, var_34_0.id)
			arg_34_0:UpdateView()

			return
		end)

		return
	end, SFX_PANEL)

	arg_34_0.cards[arg_34_1] = var_34_0

	return
end

function var_0_0.OnUpdateStaffItem(arg_39_0, arg_39_1, arg_39_2)
	if not arg_39_0.cards[arg_39_2] then
		arg_39_0:OnInitStaffItem(arg_39_2)
	end

	arg_39_0.cards[arg_39_2]:Update(arg_39_0.staffList[arg_39_1 + 1], arg_39_0.selIds, true, (underscore.map(arg_39_0.showAttrDatas, function(arg_40_0)
		return arg_40_0.id
	end)))

	return
end

function var_0_0.willExit(arg_41_0)
	var_0_0.CheckUpdateFloorStaffs(arg_41_0.activity)
	ClearLScrollrect(arg_41_0.scrollCom)

	for iter_41_0, iter_41_1 in pairs(arg_41_0.cards) do
		iter_41_1:Dispose()
	end

	arg_41_0.cards = {}

	return
end

function var_0_0.CheckUpdateFloorStaffs(arg_42_0, arg_42_1)
	if arg_42_0:NeedUpdateFloorStaff() then
		pg.m02:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = arg_42_0.id,
			cmd = ActivityMallOPCommand.CMD.SET_FLOOR_STAFF,
			arg_list = arg_42_0:GetFloorStaffList(),
			callback = arg_42_1
		})
	end

	return
end

return var_0_0
