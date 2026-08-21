local var_0_0 = class("MallStoryLineLayer", import("view.base.BaseUI"))

var_0_0.Placeindex = 0
var_0_0.roleindex = 0
var_0_0.num = {
	Role = 3,
	Story = 1,
	Skin = 2,
	Place = 4
}

function var_0_0.getUIName(arg_1_0)
	return "MallStoryLineUI"
end

function var_0_0.init(arg_2_0)
	setText(arg_2_0._tf:Find("tip"), i18n("word_click_to_close"))

	arg_2_0.adapt = arg_2_0._tf:Find("adapt")
	arg_2_0.tabs = arg_2_0.adapt:Find("tabs")
	arg_2_0.tabsListCount = arg_2_0.tabs.transform.childCount
	arg_2_0.decorate1ListCount = arg_2_0.adapt:Find("decorate1").transform.childCount
	arg_2_0.page_listCount = arg_2_0.adapt:Find("page_list").transform.childCount
	arg_2_0.StoryList = {}
	arg_2_0.SkinList = {}
	arg_2_0.RoleList = {}
	arg_2_0.PlaceList = {}
	arg_2_0.TriggeredPointIds = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL):GetTriggeredPointIds()
	arg_2_0.OrderDataList = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL):GetOrderData():GetFinishedList()

	for iter_2_0, iter_2_1 in pairs((_.map(pg.activity_mall_story.all, function(arg_3_0)
		return pg.activity_mall_story[arg_3_0]
	end))) do
		if iter_2_1.type == arg_2_0.num.Skin then
			table.insert(arg_2_0.StoryList, iter_2_1)
		elseif iter_2_1.type == arg_2_0.num.Place then
			table.insert(arg_2_0.SkinList, iter_2_1)
		elseif iter_2_1.type == arg_2_0.num.Role then
			table.insert(arg_2_0.RoleList, iter_2_1)
		elseif iter_2_1.type == arg_2_0.num.Story then
			table.insert(arg_2_0.PlaceList, iter_2_1)
		end
	end

	arg_2_0.type2List = {
		[arg_2_0.num.Story] = arg_2_0.StoryList,
		[arg_2_0.num.Skin] = arg_2_0.SkinList,
		[arg_2_0.num.Role] = arg_2_0.RoleList,
		[arg_2_0.num.Place] = arg_2_0.PlaceList
	}

	local var_2_0 = -1

	for iter_2_2 = 0, arg_2_0.tabsListCount - 1 do
		onToggle(arg_2_0, arg_2_0.tabs:GetChild(iter_2_2), function(arg_4_0)
			if arg_4_0 then
				if var_2_0 ~= iter_2_2 then
					arg_2_0:OnUpdata(iter_2_2 + 1)
				end

				var_2_0 = iter_2_2
			end

			return
		end, SFX_PANEL)
	end

	arg_2_0:OnUpdata(1)

	return
end

function var_0_0.UpdataToggle(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.type2List[arg_5_1]
	local var_5_1 = arg_5_1 ~= var_0_0.num.Skin and arg_5_0:OnTask(var_5_0) or arg_5_0:GetSkinFinishNum(var_5_0)

	setText(arg_5_0.adapt:Find("tabs/" .. arg_5_1 .. "/name"), var_5_1 .. "/" .. #arg_5_0.type2List[arg_5_1])
	setText(arg_5_0.adapt:Find("tabs/" .. arg_5_1 .. "/on/name"), var_5_1 .. "/" .. #var_5_0)

	return
end

function var_0_0.OnUpdata(arg_6_0, arg_6_1)
	for iter_6_0 = 0, arg_6_0.decorate1ListCount - 1 do
		SetActive(arg_6_0.adapt:Find("decorate1/" .. iter_6_0 + 1), iter_6_0 + 1 == arg_6_1)
	end

	for iter_6_1 = 0, arg_6_0.page_listCount - 1 do
		SetActive(arg_6_0.adapt:Find("page_list/" .. iter_6_1 + 1), iter_6_1 + 1 == arg_6_1)
	end

	arg_6_0:UpdataToggle(arg_6_1)

	if arg_6_1 == arg_6_0.num.Story then
		arg_6_0:OnStoryPage(arg_6_1)
	elseif arg_6_1 == arg_6_0.num.Skin then
		arg_6_0:OnSkinPage(arg_6_1)
	elseif arg_6_1 == arg_6_0.num.Role then
		arg_6_0:OnRolePage(arg_6_1)
	elseif arg_6_1 == arg_6_0.num.Place then
		arg_6_0:OnPlacePage(arg_6_1)
	end

	return
end

function var_0_0.OnTask(arg_7_0, arg_7_1)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		if table.contains(arg_7_0.TriggeredPointIds, iter_7_1.id) then
			var_7_0 = var_7_0 + 1
		end
	end

	return var_7_0
end

function var_0_0.GetSkinFinishNum(arg_8_0, arg_8_1)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		if table.contains(arg_8_0.OrderDataList, tonumber(iter_8_1.desc)) then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

function var_0_0.OnStoryPage(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.adapt:Find("page_list/" .. arg_9_1)

	for iter_9_0 = 1, #arg_9_0.StoryList do
		arg_9_0:OnStoryUPdata(var_9_0:Find("bg/" .. iter_9_0), arg_9_0.StoryList[iter_9_0])
	end

	return
end

function var_0_0.OnStoryUPdata(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = table.contains(arg_10_0.TriggeredPointIds, arg_10_2.id)
	local var_10_1 = arg_10_2.lua

	setActive(arg_10_1:Find("on"), var_10_0)
	setActive(arg_10_1:Find("off"), not var_10_0)
	setText(arg_10_1:Find("on/bg/name"), arg_10_2.name)
	setText(arg_10_1:Find("off/bg/lockname"), arg_10_2.desc)
	onButton(arg_10_0, arg_10_1, function()
		if not var_10_0 then
			return
		end

		pg.NewStoryMgr.GetInstance():Play(var_10_1, function()
			return
		end, true)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnSkinPage(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.adapt:Find("page_list/" .. arg_13_1)

	arg_13_0:OnSkin(var_13_0:Find("skin/" .. arg_13_0.roleindex).transform.childCount, var_13_0)
	onButton(arg_13_0, var_13_0:Find("left"), function()
		arg_13_0.roleindex = arg_13_0.roleindex - 1

		arg_13_0:OnSkin(var_13_0:Find("skin/" .. arg_13_0.roleindex).transform.childCount, var_13_0)

		return
	end, SFX_PANEL)
	onButton(arg_13_0, var_13_0:Find("right"), function()
		arg_13_0.roleindex = arg_13_0.roleindex + 1

		arg_13_0:OnSkin(var_13_0:Find("skin/" .. arg_13_0.roleindex).transform.childCount, var_13_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnSkin(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2:Find("skin").transform.childCount

	setActive(arg_16_2:Find("left"), arg_16_0.roleindex == 1)
	setActive(arg_16_2:Find("right"), arg_16_0.roleindex == 0)
	setText(arg_16_2:Find("Text"), arg_16_0.roleindex + 1 .. "/" .. #arg_16_0.SkinList / 5)

	for iter_16_0 = 0, var_16_0 - 1 do
		SetActive(arg_16_2:Find("skin/" .. iter_16_0), iter_16_0 == arg_16_0.roleindex)
	end

	for iter_16_1 = 0, arg_16_1 - 1 do
		arg_16_0:OnSkinUpdata(arg_16_2:Find("skin/" .. arg_16_0.roleindex .. "/" .. iter_16_1 + 1), arg_16_0.SkinList[arg_16_0.roleindex * 5 + (iter_16_1 + 1)])
	end

	return
end

function var_0_0.OnSkinUpdata(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = table.contains(arg_17_0.OrderDataList, tonumber(arg_17_2.desc))
	local var_17_1 = arg_17_2.lua

	SetActive(arg_17_1:Find("on"), var_17_0)
	SetActive(arg_17_1:Find("off"), not var_17_0)
	setText(arg_17_1:Find("on/name"), arg_17_2.name)
	setText(arg_17_1:Find("off/lockname"), (i18n("mall_char_lock")))
	setImageSprite(arg_17_1:Find("on/bg"), LoadSprite("ui/mallstorylineui_atlas", arg_17_2.icon))
	onButton(arg_17_0, arg_17_1, function()
		if not var_17_0 then
			return
		end

		pg.NewStoryMgr.GetInstance():Play(var_17_1, function()
			return
		end, true)

		return
	end, SFX_PANEL)
	onButton(arg_17_0, arg_17_1:Find("on/bg"), function()
		if not var_17_0 then
			return
		end

		pg.NewStoryMgr.GetInstance():Play(var_17_1, function()
			return
		end, true)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnRolePage(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.adapt:Find("page_list/" .. arg_22_1)

	for iter_22_0 = 1, #arg_22_0.RoleList do
		arg_22_0:OnRoleUPdata(var_22_0:Find("" .. iter_22_0), arg_22_0.RoleList[iter_22_0])
	end

	return
end

function var_0_0.OnRoleUPdata(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = table.contains(arg_23_0.TriggeredPointIds, arg_23_2.id)
	local var_23_1 = i18n("mall_title_lock")
	local var_23_2 = arg_23_2.lua

	setActive(arg_23_1:Find("on"), var_23_0)
	setActive(arg_23_1:Find("off"), not var_23_0)
	setText(arg_23_1:Find("on/name_s/name"), arg_23_2.name)
	setScrollText(arg_23_1:Find("on/name_l/mask/name"), arg_23_2.name)

	local var_23_4 = GetPerceptualSize(arg_23_2.name) > 7

	setActive(arg_23_1:Find("on/name_s"), not var_23_4)
	setActive(arg_23_1:Find("on/name_l"), var_23_4)
	setText(arg_23_1:Find("off/lock/lockname"), var_23_1)
	setImageSprite(arg_23_1:Find("on/icon"), LoadSprite("ui/mallstorylineui_atlas", var_23_3))
	onButton(arg_23_0, arg_23_1:Find("on"), function()
		if not var_23_0 then
			return
		end

		pg.NewStoryMgr.GetInstance():Play(var_23_2, function()
			return
		end, true)

		return
	end, SFX_PANEL)
	onButton(arg_23_0, arg_23_1:Find("off"), function()
		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnPlacePage(arg_27_0, arg_27_1)
	arg_27_0.Place = arg_27_0.adapt:Find("page_list/" .. arg_27_1)

	for iter_27_0 = 0, arg_27_0.Place:Find("table").transform.childCount - 1 do
		SetActive(arg_27_0.Place:Find("table/" .. iter_27_0 + 1), arg_27_0.Placeindex == iter_27_0 + 1)
	end

	arg_27_0:OnPlaceList(#arg_27_0.PlaceList - (arg_27_0.Placeindex + 1) * 6 > 0 and 6 or (arg_27_0.Placeindex + 1) * 6 - #arg_27_0.PlaceList, arg_27_0.Place)
	addSlip(SLIP_TYPE_HRZ, arg_27_0.adapt:Find("page_list/" .. arg_27_1 .. "/table"), function()
		if arg_27_0.Placeindex > 0 then
			arg_27_0.Placeindex = arg_27_0.Placeindex - 1

			arg_27_0:OnPlaceList(#arg_27_0.PlaceList - (arg_27_0.Placeindex + 1) * 6 > 0 and 6 or (arg_27_0.Placeindex + 1) * 6 - #arg_27_0.PlaceList, (arg_27_0.adapt:Find("page_list/" .. arg_27_1)))
		end

		return
	end, function()
		if arg_27_0.Placeindex < 2 then
			arg_27_0.Placeindex = arg_27_0.Placeindex + 1

			arg_27_0:OnPlaceList(#arg_27_0.PlaceList - (arg_27_0.Placeindex + 1) * 6 > 0 and 6 or (arg_27_0.Placeindex + 1) * 6 - #arg_27_0.PlaceList, (arg_27_0.adapt:Find("page_list/" .. arg_27_1)))
		end

		return
	end)
	onButton(arg_27_0, arg_27_0.Place:Find("left"), function()
		arg_27_0.Placeindex = arg_27_0.Placeindex - 1

		arg_27_0:OnPlaceList(#arg_27_0.PlaceList - (arg_27_0.Placeindex + 1) * 6 > 0 and 6 or (arg_27_0.Placeindex + 1) * 6 - #arg_27_0.PlaceList, (arg_27_0.adapt:Find("page_list/" .. arg_27_1)))

		return
	end, SFX_PANEL)
	onButton(arg_27_0, arg_27_0.Place:Find("right"), function()
		arg_27_0.Placeindex = arg_27_0.Placeindex + 1

		arg_27_0:OnPlaceList(#arg_27_0.PlaceList - (arg_27_0.Placeindex + 1) * 6 > 0 and 6 or (arg_27_0.Placeindex + 1) * 6 - #arg_27_0.PlaceList, (arg_27_0.adapt:Find("page_list/" .. arg_27_1)))

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnPlaceList(arg_32_0, arg_32_1, arg_32_2)
	setActive(arg_32_0.Place:Find("left"), arg_32_0.Placeindex ~= 0)
	setActive(arg_32_0.Place:Find("right"), arg_32_0.Placeindex < 2)
	setActive(arg_32_0.Place:Find("table/0"), arg_32_0.Placeindex == 0)
	setActive(arg_32_0.Place:Find("table/1"), arg_32_0.Placeindex == 1)
	setActive(arg_32_0.Place:Find("table/2"), arg_32_0.Placeindex == 2)
	setText(arg_32_2:Find("Text"), arg_32_0.Placeindex + 1 .. "/" .. #arg_32_0.PlaceList / 5)

	for iter_32_0 = 1, arg_32_1 do
		arg_32_0:OnPlaceUPdata(arg_32_2:Find("table/" .. arg_32_0.Placeindex .. "/" .. iter_32_0), arg_32_0.PlaceList[arg_32_0.Placeindex * 6 + iter_32_0], arg_32_0.Placeindex * 6 + iter_32_0)
	end

	return
end

function var_0_0.OnPlaceUPdata(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = table.contains(arg_33_0.TriggeredPointIds, arg_33_2.id)

	SetActive(arg_33_1:Find("lock"), not var_33_0)

	if var_33_0 then
		setText(arg_33_1:Find("name_bg/name"), arg_33_2.name)
		setText(arg_33_1:Find("desc/Text"), arg_33_2.desc)
		setImageSprite(arg_33_1:Find("icon"), LoadSprite("ui/mallstorylineui_atlas", arg_33_2.icon))
	end

	setText(arg_33_1:Find("lock/lockname"), (i18n("mall_continue_to_unlock")))

	return
end

function var_0_0.didEnter(arg_34_0)
	onButton(arg_34_0, arg_34_0._tf:Find("bg"), function()
		arg_34_0:closeView()

		return
	end, SFX_PANEL)

	for iter_34_0, iter_34_1 in pairs(arg_34_0.type2List) do
		arg_34_0:UpdataToggle(iter_34_0)
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_34_0._tf)

	return
end

function var_0_0.willExit(arg_36_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_36_0._tf)

	return
end

return var_0_0
