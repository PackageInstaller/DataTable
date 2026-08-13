class = var_0_10000

local var_0_0 = "MallStoryLineLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.Placeindex = 0
var_0_1.roleindex = 0
var_0_1.num = {
	Role = 3,
	Story = 1,
	Skin = 2,
	Place = 4
}

function var_0_1.getUIName(arg_1_0)
	return "MallStoryLineUI"
end

function var_0_1.init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "tip")

	i18n = var_2_0

	var_1_10001(var_2_1, var_2_0("word_click_to_close"))

	local var_2_2 = arg_2_0._tf

	arg_2_0.adapt = var_1.Find(var_2_2, "adapt")

	local var_2_3 = arg_2_0.adapt

	arg_2_0.tabs = var_1.Find(var_2_3, "tabs")
	arg_2_0.tabsListCount = arg_2_0.tabs.transform.childCount

	local var_2_4 = arg_2_0.adapt

	arg_2_0.decorate1ListCount = var_1.Find(var_2_4, "decorate1").transform.childCount

	local var_2_5 = arg_2_0.adapt

	arg_2_0.page_listCount = var_1.Find(var_2_5, "page_list").transform.childCount
	arg_2_0.StoryList = {}
	arg_2_0.SkinList = {}
	arg_2_0.RoleList = {}
	arg_2_0.PlaceList = {}
	_ = var_1

	local var_2_6 = var_1.map

	pg = var_2_5

	local var_2_7 = var_2_6(var_2_5.activity_mall_story.all, function(arg_3_0)
		pg = var_2_10001

		return var_2_10001.activity_mall_story[arg_3_0]
	end)

	getProxy = var_2
	ActivityProxy = var_3

	local var_2_8 = var_2(var_3)
	local var_2_9 = var_2.getActivityByType

	ActivityConst = var_4

	local var_2_10 = var_2_9(var_2_8, var_4.ACTIVITY_TYPE_MALL)

	arg_2_0.TriggeredPointIds = var_2.GetTriggeredPointIds(var_2_10)
	getProxy = var_2
	ActivityProxy = var_2_10

	local var_2_11 = var_2(var_2_10)
	local var_2_12 = var_2.getActivityByType

	ActivityConst = var_4

	local var_2_13 = var_2_12(var_2_11, var_4.ACTIVITY_TYPE_MALL)
	local var_2_14 = var_2.GetOrderData(var_2_13)

	arg_2_0.OrderDataList = var_2.GetFinishedList(var_2_14)
	pairs = var_2

	for iter_2_0, iter_2_1 in var_2(var_2_7) do
		if iter_2_1.type == arg_2_0.num.Skin then
			table = var_1_10007

			var_1_10007.insert(arg_2_0.StoryList, iter_2_1)
		elseif iter_2_1.type == arg_2_0.num.Place then
			table = var_1_10007

			var_1_10007.insert(arg_2_0.SkinList, iter_2_1)
		elseif iter_2_1.type == arg_2_0.num.Role then
			table = var_1_10007

			var_1_10007.insert(arg_2_0.RoleList, iter_2_1)
		elseif iter_2_1.type == arg_2_0.num.Story then
			table = var_1_10007

			var_1_10007.insert(arg_2_0.PlaceList, iter_2_1)
		end
	end

	arg_2_0.type2List = {
		[arg_2_0.num.Story] = arg_2_0.StoryList,
		[arg_2_0.num.Skin] = arg_2_0.SkinList,
		[arg_2_0.num.Role] = arg_2_0.RoleList,
		[arg_2_0.num.Place] = arg_2_0.PlaceList
	}

	local var_2_15 = -1

	for iter_2_2 = 0, arg_2_0.tabsListCount - 1 do
		onToggle = var_1_10007

		local var_2_16 = arg_2_0
		local var_2_17 = arg_2_0.tabs
		local var_2_18 = var_9.GetChild(var_2_17, iter_2_2)

		local function var_2_19(arg_4_0)
			if arg_4_0 then
				if var_2_15 ~= iter_2_2 then
					local var_4_0 = arg_2_0

					var_1.OnUpdata(var_4_0, iter_2_2 + 1)
				end

				var_2_15 = iter_2_2
			end

			return
		end

		SFX_PANEL = var_11

		var_1_10007(var_2_16, var_2_18, var_2_19, var_11)
	end

	arg_2_0:OnUpdata(1)

	return
end

function var_0_1.UpdataToggle(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.type2List[arg_5_1]

	if arg_5_1 ~= var_0_1.num.Skin then
		var_1_10004 = arg_5_0

		local var_5_1

		if not arg_5_0.OnTask(var_1_10004, var_5_0) then
			var_1_10004 = arg_5_0
			var_5_1 = arg_5_0.GetSkinFinishNum(var_1_10004, var_5_0)
		end

		setText = var_1_10004

		local var_5_2 = arg_5_0.adapt

		var_1_10004(var_5.Find(var_5_2, "tabs/" .. arg_5_1 .. "/name"), var_5_1 .. "/" .. #var_5_0)

		setText = var_1_10004

		local var_5_3 = arg_5_0.adapt

		var_1_10004(var_5.Find(var_5_3, "tabs/" .. arg_5_1 .. "/on/name"), var_5_1 .. "/" .. #var_5_0)

		return
	end
end

function var_0_1.OnUpdata(arg_6_0, arg_6_1)
	for iter_6_0 = 0, arg_6_0.decorate1ListCount - 1 do
		SetActive = var_1_10006

		local var_6_0 = arg_6_0.adapt

		var_1_10006(var_7.Find(var_6_0, "decorate1/" .. iter_6_0 + 1), iter_6_0 + 1 == arg_6_1)
	end

	for iter_6_1 = 0, arg_6_0.page_listCount - 1 do
		SetActive = var_1_10006

		local var_6_1 = arg_6_0.adapt

		var_1_10006(var_7.Find(var_6_1, "page_list/" .. iter_6_1 + 1), iter_6_1 + 1 == arg_6_1)
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

function var_0_1.OnTask(arg_7_0, arg_7_1)
	local var_7_0 = 0

	pairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(arg_7_1) do
		table = var_1_10008

		if var_1_10008.contains(arg_7_0.TriggeredPointIds, iter_7_1.id) then
			var_7_0 = var_7_0 + 1
		end
	end

	return var_7_0
end

function var_0_1.GetSkinFinishNum(arg_8_0, arg_8_1)
	local var_8_0 = 0

	pairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(arg_8_1) do
		table = var_1_10008
		var_1_10008 = var_1_10008.contains

		local var_8_1 = arg_8_0.OrderDataList

		tonumber = var_1_10010

		if var_1_10008(var_8_1, var_1_10010(iter_8_1.desc)) then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

function var_0_1.OnStoryPage(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.adapt
	local var_9_1 = var_2.Find(var_9_0, "page_list/" .. arg_9_1)

	for iter_9_0 = 1, #arg_9_0.StoryList do
		arg_9_0:OnStoryUPdata(var_9_1:Find("bg/" .. iter_9_0), arg_9_0.StoryList[iter_9_0])
	end

	return
end

function var_0_1.OnStoryUPdata(arg_10_0, arg_10_1, arg_10_2)
	table = var_1_10003

	local var_10_0 = var_1_10003.contains(arg_10_0.TriggeredPointIds, arg_10_2.id)
	local var_10_1 = arg_10_2.name
	local var_10_2 = arg_10_2.desc
	local var_10_3 = arg_10_2.lua

	setActive = var_1_10007

	var_1_10007(arg_10_1:Find("on"), var_10_0)

	setActive = var_1_10007

	var_1_10007(arg_10_1:Find("off"), not var_10_0)

	setText = var_1_10007

	var_1_10007(arg_10_1:Find("on/bg/name"), var_10_1)

	setText = var_1_10007

	var_1_10007(arg_10_1:Find("off/bg/lockname"), var_10_2)

	onButton = var_1_10007

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_1

	local function var_10_6()
		if not var_10_0 then
			return
		end

		pg = var_0

		local var_11_0 = var_0.NewStoryMgr.GetInstance()

		var_0.Play(var_11_0, var_10_3, function()
			return
		end, true)

		return
	end

	SFX_PANEL = var_1_10011

	var_1_10007(var_10_4, var_10_5, var_10_6, var_1_10011)

	return
end

function var_0_1.OnSkinPage(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.adapt
	local var_13_1 = var_2.Find(var_13_0, "page_list/" .. arg_13_1)
	local var_13_2 = var_2.Find(var_13_1, "skin/" .. arg_13_0.roleindex).transform.childCount

	arg_13_0:OnSkin(var_13_2, var_2)

	onButton = var_4

	local var_13_3 = arg_13_0
	local var_13_4 = var_2:Find("left")

	local function var_13_5()
		arg_13_0.roleindex = arg_13_0.roleindex - 1

		local var_14_0 = var_0
		local var_14_1 = var_0.Find(var_14_0, "skin/" .. arg_13_0.roleindex).transform.childCount
		local var_14_2 = arg_13_0

		var_1.OnSkin(var_14_2, var_14_1, var_0)

		return
	end

	SFX_PANEL = var_8

	var_4(var_13_3, var_13_4, var_13_5, var_8)

	onButton = var_4

	local var_13_6 = arg_13_0
	local var_13_7 = var_2:Find("right")

	local function var_13_8()
		arg_13_0.roleindex = arg_13_0.roleindex + 1

		local var_15_0 = var_0
		local var_15_1 = var_0.Find(var_15_0, "skin/" .. arg_13_0.roleindex).transform.childCount
		local var_15_2 = arg_13_0

		var_1.OnSkin(var_15_2, var_15_1, var_0)

		return
	end

	SFX_PANEL = var_8

	var_4(var_13_6, var_13_7, var_13_8, var_8)

	return
end

function var_0_1.OnSkin(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2
	local var_16_1 = arg_16_2.Find(var_16_0, "skin").transform.childCount

	setActive = var_16_0

	var_16_0(arg_16_2:Find("left"), arg_16_0.roleindex == 1)

	setActive = var_16_0

	var_16_0(arg_16_2:Find("right"), arg_16_0.roleindex == 0)

	setText = var_16_0

	var_16_0(arg_16_2:Find("Text"), arg_16_0.roleindex + 1 .. "/" .. #arg_16_0.SkinList / 5)

	for iter_16_0 = 0, var_16_1 - 1 do
		SetActive = var_8

		var_8(arg_16_2:Find("skin/" .. iter_16_0), iter_16_0 == arg_16_0.roleindex)
	end

	for iter_16_1 = 0, arg_16_1 - 1 do
		arg_16_0:OnSkinUpdata(arg_16_2:Find("skin/" .. arg_16_0.roleindex .. "/" .. iter_16_1 + 1), arg_16_0.SkinList[arg_16_0.roleindex * 5 + (iter_16_1 + 1)])
	end

	return
end

function var_0_1.OnSkinUpdata(arg_17_0, arg_17_1, arg_17_2)
	table = var_1_10003

	local var_17_0 = var_1_10003.contains
	local var_17_1 = arg_17_0.OrderDataList

	tonumber = var_1_10005

	local var_17_2 = var_17_0(var_17_1, var_1_10005(arg_17_2.desc))
	local var_17_3 = arg_17_2.name

	i18n = var_5

	local var_17_4 = var_5("mall_char_lock")
	local var_17_5 = arg_17_2.lua
	local var_17_6 = arg_17_2.icon

	SetActive = var_1_10008

	var_1_10008(arg_17_1:Find("on"), var_17_2)

	SetActive = var_1_10008

	var_1_10008(arg_17_1:Find("off"), not var_17_2)

	setText = var_1_10008

	var_1_10008(arg_17_1:Find("on/name"), var_17_3)

	setText = var_1_10008

	var_1_10008(arg_17_1:Find("off/lockname"), var_17_4)

	setImageSprite = var_1_10008

	local var_17_7 = arg_17_1
	local var_17_8 = arg_17_1.Find(var_17_7, "on/bg")

	LoadSprite = var_17_7

	var_1_10008(var_17_8, var_17_7("ui/mallstorylineui_atlas", var_17_6))

	onButton = var_1_10008

	local var_17_9 = arg_17_0
	local var_17_10 = arg_17_1

	local function var_17_11()
		if not var_17_2 then
			return
		end

		pg = var_0

		local var_18_0 = var_0.NewStoryMgr.GetInstance()

		var_0.Play(var_18_0, var_17_5, function()
			return
		end, true)

		return
	end

	SFX_PANEL = var_12

	var_1_10008(var_17_9, var_17_10, var_17_11, var_12)

	onButton = var_1_10008

	local var_17_12 = arg_17_0
	local var_17_13 = arg_17_1:Find("on/bg")

	local function var_17_14()
		if not var_17_2 then
			return
		end

		pg = var_0

		local var_20_0 = var_0.NewStoryMgr.GetInstance()

		var_0.Play(var_20_0, var_17_5, function()
			return
		end, true)

		return
	end

	SFX_PANEL = var_12

	var_1_10008(var_17_12, var_17_13, var_17_14, var_12)

	return
end

function var_0_1.OnRolePage(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.adapt
	local var_22_1 = var_2.Find(var_22_0, "page_list/" .. arg_22_1)

	for iter_22_0 = 1, #arg_22_0.RoleList do
		arg_22_0:OnRoleUPdata(var_22_1:Find("" .. iter_22_0), arg_22_0.RoleList[iter_22_0])
	end

	return
end

function var_0_1.OnRoleUPdata(arg_23_0, arg_23_1, arg_23_2)
	table = var_1_10003

	local var_23_0 = var_1_10003.contains(arg_23_0.TriggeredPointIds, arg_23_2.id)
	local var_23_1 = arg_23_2.name

	i18n = var_5

	local var_23_2 = var_5("mall_title_lock")
	local var_23_3 = arg_23_2.lua
	local var_23_4 = arg_23_2.icon

	setActive = var_1_10008

	var_1_10008(arg_23_1:Find("on"), var_23_0)

	setActive = var_1_10008

	var_1_10008(arg_23_1:Find("off"), not var_23_0)

	setText = var_1_10008

	var_1_10008(arg_23_1:Find("on/name_s/name"), var_23_1)

	setScrollText = var_1_10008

	var_1_10008(arg_23_1:Find("on/name_l/mask/name"), var_23_1)

	GetPerceptualSize = var_1_10008

	local var_23_5 = var_1_10008(var_23_1)
	local var_23_6 = 7 < var_23_5

	setActive = var_9

	var_9(arg_23_1:Find("on/name_s"), not var_23_6)

	setActive = var_9

	var_9(arg_23_1:Find("on/name_l"), var_23_6)

	setText = var_9

	var_9(arg_23_1:Find("off/lock/lockname"), var_23_2)

	setImageSprite = var_9

	local var_23_7 = arg_23_1
	local var_23_8 = arg_23_1.Find(var_23_7, "on/icon")

	LoadSprite = var_23_7

	var_9(var_23_8, var_23_7("ui/mallstorylineui_atlas", var_23_4))

	onButton = var_9

	local var_23_9 = arg_23_0
	local var_23_10 = arg_23_1:Find("on")

	local function var_23_11()
		if not var_23_0 then
			return
		end

		pg = var_0

		local var_24_0 = var_0.NewStoryMgr.GetInstance()

		var_0.Play(var_24_0, var_23_3, function()
			return
		end, true)

		return
	end

	SFX_PANEL = var_13

	var_9(var_23_9, var_23_10, var_23_11, var_13)

	onButton = var_9

	local var_23_12 = arg_23_0
	local var_23_13 = arg_23_1:Find("off")

	local function var_23_14()
		return
	end

	SFX_PANEL = var_13

	var_9(var_23_12, var_23_13, var_23_14, var_13)

	return
end

function var_0_1.OnPlacePage(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.adapt

	arg_27_0.Place = var_2.Find(var_27_0, "page_list/" .. arg_27_1)

	local var_27_1 = arg_27_0.Place
	local var_27_2 = var_2.Find(var_27_1, "table").transform.childCount

	for iter_27_0 = 0, var_27_2 - 1 do
		SetActive = var_1_10007

		local var_27_3 = arg_27_0.Place

		var_1_10007(var_8.Find(var_27_3, "table/" .. iter_27_0 + 1), arg_27_0.Placeindex == iter_27_0 + 1)
	end

	local var_27_4 = #arg_27_0.PlaceList - (arg_27_0.Placeindex + 1) * 6 > 0 and 6 or (arg_27_0.Placeindex + 1) * 6 - #arg_27_0.PlaceList
	local var_27_5 = arg_27_0

	arg_27_0.OnPlaceList(var_27_5, var_27_4, arg_27_0.Place)

	addSlip = var_4
	SLIP_TYPE_HRZ = var_27_5

	local var_27_6 = arg_27_0.adapt

	var_4(var_27_5, var_6.Find(var_27_6, "page_list/" .. arg_27_1 .. "/table"), function()
		if arg_27_0.Placeindex > 0 then
			arg_27_0.Placeindex = arg_27_0.Placeindex - 1

			local var_28_0 = arg_27_0.adapt
			local var_28_1 = var_0.Find(var_28_0, "page_list/" .. arg_27_1)
			local var_28_2 = #arg_27_0.PlaceList - (arg_27_0.Placeindex + 1) * 6 > 0 and 6 or (arg_27_0.Placeindex + 1) * 6 - #arg_27_0.PlaceList
			local var_28_3 = arg_27_0

			var_2.OnPlaceList(var_28_3, var_28_2, var_28_1)
		end

		return
	end, function()
		if arg_27_0.Placeindex < 2 then
			arg_27_0.Placeindex = arg_27_0.Placeindex + 1

			local var_29_0 = arg_27_0.adapt
			local var_29_1 = var_0.Find(var_29_0, "page_list/" .. arg_27_1)
			local var_29_2 = #arg_27_0.PlaceList - (arg_27_0.Placeindex + 1) * 6 > 0 and 6 or (arg_27_0.Placeindex + 1) * 6 - #arg_27_0.PlaceList
			local var_29_3 = arg_27_0

			var_2.OnPlaceList(var_29_3, var_29_2, var_29_1)
		end

		return
	end)

	onButton = var_4

	local var_27_7 = arg_27_0
	local var_27_8 = arg_27_0.Place
	local var_27_9 = var_6.Find(var_27_8, "left")

	local function var_27_10()
		arg_27_0.Placeindex = arg_27_0.Placeindex - 1

		local var_30_0 = arg_27_0.adapt
		local var_30_1 = var_0.Find(var_30_0, "page_list/" .. arg_27_1)
		local var_30_2 = #arg_27_0.PlaceList - (arg_27_0.Placeindex + 1) * 6 > 0 and 6 or (arg_27_0.Placeindex + 1) * 6 - #arg_27_0.PlaceList
		local var_30_3 = arg_27_0

		var_2.OnPlaceList(var_30_3, var_30_2, var_30_1)

		return
	end

	SFX_PANEL = var_8

	var_4(var_27_7, var_27_9, var_27_10, var_8)

	onButton = var_4

	local var_27_11 = arg_27_0
	local var_27_12 = arg_27_0.Place
	local var_27_13 = var_6.Find(var_27_12, "right")

	local function var_27_14()
		arg_27_0.Placeindex = arg_27_0.Placeindex + 1

		local var_31_0 = arg_27_0.adapt
		local var_31_1 = var_0.Find(var_31_0, "page_list/" .. arg_27_1)
		local var_31_2 = #arg_27_0.PlaceList - (arg_27_0.Placeindex + 1) * 6 > 0 and 6 or (arg_27_0.Placeindex + 1) * 6 - #arg_27_0.PlaceList
		local var_31_3 = arg_27_0

		var_2.OnPlaceList(var_31_3, var_31_2, var_31_1)

		return
	end

	SFX_PANEL = var_8

	var_4(var_27_11, var_27_13, var_27_14, var_8)

	return
end

function var_0_1.OnPlaceList(arg_32_0, arg_32_1, arg_32_2)
	setActive = var_1_10003

	local var_32_0 = arg_32_0.Place

	var_1_10003(var_4.Find(var_32_0, "left"), arg_32_0.Placeindex ~= 0)

	setActive = var_1_10003

	local var_32_1 = arg_32_0.Place

	var_1_10003(var_4.Find(var_32_1, "right"), arg_32_0.Placeindex < 2)

	setActive = var_1_10003

	local var_32_2 = arg_32_0.Place

	var_1_10003(var_4.Find(var_32_2, "table/0"), arg_32_0.Placeindex == 0)

	setActive = var_1_10003

	local var_32_3 = arg_32_0.Place

	var_1_10003(var_4.Find(var_32_3, "table/1"), arg_32_0.Placeindex == 1)

	setActive = var_1_10003

	local var_32_4 = arg_32_0.Place

	var_1_10003(var_4.Find(var_32_4, "table/2"), arg_32_0.Placeindex == 2)

	setText = var_1_10003

	var_1_10003(arg_32_2:Find("Text"), arg_32_0.Placeindex + 1 .. "/" .. #arg_32_0.PlaceList / 5)

	for iter_32_0 = 1, arg_32_1 do
		arg_32_0:OnPlaceUPdata(arg_32_2:Find("table/" .. arg_32_0.Placeindex .. "/" .. iter_32_0), arg_32_0.PlaceList[arg_32_0.Placeindex * 6 + iter_32_0], arg_32_0.Placeindex * 6 + iter_32_0)
	end

	return
end

function var_0_1.OnPlaceUPdata(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	table = var_1_10004

	local var_33_0 = var_1_10004.contains(arg_33_0.TriggeredPointIds, arg_33_2.id)

	i18n = var_5

	local var_33_1 = var_5("mall_continue_to_unlock")
	local var_33_2 = arg_33_2.icon
	local var_33_3 = arg_33_2.name
	local var_33_4 = arg_33_2.desc
	local var_33_5 = arg_33_2.lua

	SetActive = var_1_10010

	var_1_10010(arg_33_1:Find("lock"), not var_33_0)

	if var_33_0 then
		setText = var_1_10010

		var_1_10010(arg_33_1:Find("name_bg/name"), var_33_3)

		setText = var_1_10010

		var_1_10010(arg_33_1:Find("desc/Text"), var_33_4)

		setImageSprite = var_1_10010

		local var_33_6 = arg_33_1
		local var_33_7 = arg_33_1.Find(var_33_6, "icon")

		LoadSprite = var_33_6

		var_1_10010(var_33_7, var_33_6("ui/mallstorylineui_atlas", var_33_2))
	end

	setText = var_1_10010

	var_1_10010(arg_33_1:Find("lock/lockname"), var_33_1)

	return
end

function var_0_1.didEnter(arg_34_0)
	onButton = var_1_10001

	local var_34_0 = arg_34_0
	local var_34_1 = arg_34_0._tf
	local var_34_2 = var_3.Find(var_34_1, "bg")

	local function var_34_3()
		local var_35_0 = arg_34_0

		var_0.closeView(var_35_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_34_0, var_34_2, var_34_3, var_5)

	pairs = var_1_10001

	for iter_34_0, iter_34_1 in var_1_10001(arg_34_0.type2List) do
		arg_34_0:UpdataToggle(iter_34_0)
	end

	pg = var_1

	local var_34_4 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_34_4, arg_34_0._tf)

	return
end

function var_0_1.willExit(arg_36_0)
	pg = var_1_10001

	local var_36_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_36_0, arg_36_0._tf)

	return
end

return var_0_1
