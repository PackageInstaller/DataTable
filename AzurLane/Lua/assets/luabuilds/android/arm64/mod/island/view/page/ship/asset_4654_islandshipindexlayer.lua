class = var_0_10000

local var_0_0 = "IslandShipIndexLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.common.CustomIndexLayer"))

function var_0_1.SortFunc(arg_1_0)
	return {
		function(arg_2_0)
			if not arg_2_0.isInvite then
				local var_2_0 = arg_2_0["Get" .. arg_1_0](arg_2_0)

				return arg_2_0["Get" .. arg_1_0](arg_2_0)
			elseif arg_2_0.isInvite then
				return 0
			end

			return
		end,
		function(arg_3_0)
			return arg_3_0.configId
		end
	}
end

var_0_1.SortNames = {
	"island_chara_list_level",
	"island_chara_list_attribute",
	"island_index_name"
}
var_0_1.sort = {
	{
		sortFuncs = var_0_1.SortFunc("Level"),
		name = var_0_1.SortNames[1]
	},
	{
		sortFuncs = var_0_1.SortFunc("Power"),
		name = var_0_1.SortNames[2]
	},
	{
		sortFuncs = var_0_1.SortFunc("CurrentEnergy"),
		name = var_0_1.SortNames[3]
	},
	{
		name = "island_chara_list_workspeed",
		sortFuncs = var_0_1.SortFunc("WorkSpeed")
	}
}

function var_0_1.getSortFuncAndName(arg_4_0, arg_4_1)
	for iter_4_0 = 1, #var_0_1.sort do
		bit = var_1_10006
		var_1_10006 = var_1_10006.lshift(1, iter_4_0 - 1)
		bit = var_1_10007

		if var_1_10007.band(var_1_10006, arg_4_0) > 0 then
			underscore = var_1_10007

			return var_1_10007.map(var_0_1.sort[iter_4_0].sortFuncs, function(arg_5_0)
				return function(arg_6_0)
					local var_6_0 = arg_5_0(arg_6_0)

					return (arg_4_1 and -1 or 1) * arg_5_0(arg_6_0)
				end
			end), var_0_1.sort[iter_4_0].name
		end
	end

	return
end

bit = var_1
var_0_1.SortLevel = var_1.lshift(1, 0)
bit = var_1
var_0_1.SortPower = var_1.lshift(1, 1)
bit = var_1
var_0_1.SortEnergy = var_1.lshift(1, 2)
bit = var_1
var_0_1.SortWorkSpeed = var_1.lshift(1, 3)
var_0_1.SortIndexs = {
	var_0_1.SortLevel,
	var_0_1.SortPower,
	var_0_1.SortEnergy
}
bit = var_1
var_0_1.ExtraPotency = var_1.lshift(1, 0)
bit = var_1
var_0_1.ExtraCanUpgSkill = var_1.lshift(1, 1)
bit = var_1
var_0_1.ExtraSpeStatus = var_1.lshift(1, 2)
var_0_1.ExtraIndexs = {
	var_0_1.ExtraPotency,
	var_0_1.ExtraCanUpgSkill,
	var_0_1.ExtraSpeStatus
}
IndexConst = var_1
var_0_1.ExtraALL = var_1.BitAll(var_0_1.ExtraIndexs)
table = var_1

var_1.insert(var_0_1.ExtraIndexs, 1, var_0_1.ExtraALL)

var_0_1.ExtraNames = {
	"island_index_extra_all",
	"island_index_potency",
	"island_index_skill",
	"island_index_status"
}

local var_0_2 = {
	function()
		return true
	end,
	function(arg_8_0)
		if not arg_8_0 then
			return false
		end

		return arg_8_0:ExistPotency()
	end,
	function(arg_9_0)
		if not arg_9_0 then
			return false
		end

		return arg_9_0:AnySkillCanUpgrade()
	end,
	function(arg_10_0)
		if not arg_10_0 then
			return false
		end

		return arg_10_0:HasStatus()
	end
}

function var_0_1.filterByExtra(arg_11_0, arg_11_1)
	if not arg_11_1 or arg_11_1 == var_0_1.ExtraALL then
		return true
	end

	for iter_11_0 = 2, #var_0_2 do
		bit = var_1_10006
		var_1_10006 = var_1_10006.lshift(1, iter_11_0 - 2)
		bit = var_1_10007

		if var_1_10007.band(var_1_10006, arg_11_1) > 0 and var_0_2[iter_11_0](arg_11_0) then
			return true
		end
	end

	return false
end

function var_0_1.getUIName(arg_12_0)
	return "IslandCustomIndexUI"
end

function var_0_1.init(arg_13_0)
	var_0_1.super.init(arg_13_0)

	local var_13_0 = arg_13_0._tf
	local var_13_1 = var_1.Find(var_13_0, "index_panel/layout/tip")
	local var_13_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_13_0.titleTxt = var_13_2(var_13_1, var_4(var_1_10006))

	local var_13_3 = arg_13_0._tf

	arg_13_0.closeBtn = var_1.Find(var_13_3, "index_panel/layout/clsoe")

	local var_13_4 = arg_13_0._tf

	arg_13_0.tplContainer = var_1.Find(var_13_4, "index_panel/layout/container")
	arg_13_0.OnFilter = arg_13_0.contextData.OnFilter

	local var_13_5

	if not var_1.defaultIndex then
		var_13_5 = {}
	end

	arg_13_0.indexDatas = var_13_5

	local var_13_6

	if not var_1.needWorkSpeed then
		var_13_6 = false
	end

	arg_13_0.needWorkSpeed = var_13_6

	return
end

function var_0_1.BlurPanel(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_14_0, arg_14_0._tf)

	return
end

function var_0_1.DoEnterAnimation(arg_15_0)
	return
end

function var_0_1.didEnter(arg_16_0)
	arg_16_0.contextData = arg_16_0:InitData()

	var_0_1.super.didEnter(arg_16_0)

	local var_16_0 = arg_16_0.titleTxt

	i18n = var_1_10002
	var_16_0.text = var_1_10002("child_filter_title")
	onButton = var_16_0

	local var_16_1 = arg_16_0
	local var_16_2 = arg_16_0.closeBtn

	local function var_16_3()
		local var_17_0 = arg_16_0

		var_0.emit(var_17_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_PANEL = var_1_10006

	var_16_0(var_16_1, var_16_2, var_16_3, var_1_10006)

	return
end

function var_0_1.InitGroup(arg_18_0)
	var_0_1.super.InitGroup(arg_18_0)

	local function var_18_0(arg_19_0)
		setActive = var_2_10001

		var_2_10001(arg_19_0:Find("line"), false)

		return
	end

	for iter_18_0 = 1, arg_18_0.tplContainer.childCount do
		local var_18_1 = arg_18_0.tplContainer
		local var_18_2 = var_6.GetChild(var_18_1, iter_18_0 - 1)

		if var_6.Find(var_18_2, "bg").childCount > 7 then
			var_18_0(var_7:GetChild(6))
		end

		if var_7.childCount > 0 then
			var_18_0(var_7:GetChild(var_7.childCount - 1))
		end
	end

	return
end

function var_0_1.InitData(arg_20_0)
	Clone = var_1_10001

	local var_20_0 = var_1_10001(var_0_1.SortNames)

	Clone = var_1_10002

	local var_20_1 = var_1_10002(var_0_1.SortIndexs)

	if arg_20_0.needWorkSpeed then
		table = var_3

		var_3.insert(var_20_0, "island_chara_list_workspeed")

		table = var_3

		var_3.insert(var_20_1, var_0_1.SortWorkSpeed)
	end

	local var_20_2 = {}

	Clone = var_4
	var_20_2.indexDatas = var_4(arg_20_0.indexDatas)

	local var_20_3 = {}
	local var_20_4 = {
		isSort = true
	}

	CustomIndexLayer = var_6
	var_20_4.mode = var_6.Mode.OR
	var_20_4.options = var_20_1
	var_20_4.names = var_20_0
	var_20_3.sortIndex = var_20_4

	local var_20_5 = {
		blueSeleted = true
	}

	CustomIndexLayer = var_6
	var_20_5.mode = var_6.Mode.AND
	var_20_5.options = var_0_1.ExtraIndexs
	var_20_5.names = var_0_1.ExtraNames
	var_20_3.extraIndex = var_20_5
	var_20_2.customPanels = var_20_3
	var_20_2.groupList = {
		{
			dropdown = false,
			titleENTxt = "indexsort_sorteng",
			titleTxt = "indexsort_sort",
			tags = {
				"sortIndex"
			}
		},
		{
			dropdown = false,
			titleENTxt = "indexsort_indexeng",
			titleTxt = "indexsort_extraindex",
			tags = {
				"extraIndex"
			}
		}
	}

	function var_20_2.callback(arg_21_0)
		arg_20_0.OnFilter(arg_21_0)

		return
	end

	return var_20_2
end

function var_0_1.UpdateBtnStyle(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_2 ~= arg_22_0.greySprite
	local var_22_1 = arg_22_1
	local var_22_2 = arg_22_1.GetComponent

	typeof = var_1_10007
	Image = var_1_10009

	local var_22_3 = var_22_2(var_22_1, var_1_10007(var_1_10009))

	if var_22_0 then
		Color = var_1_10005

		if not var_1_10005.New(0, 0, 0, 1) then
			Color = var_1_10005
			var_1_10005 = var_1_10005.New(1, 1, 1, 1)
		end

		var_22_3.color = var_1_10005

		local var_22_4 = arg_22_1:Find("Image")
		local var_22_5 = var_5.GetComponent

		typeof = var_8
		Text = var_1_10010

		local var_22_6 = var_22_5(var_22_4, var_8(var_1_10010))

		if var_22_0 then
			Color = var_22_1

			if not var_22_1.New(1, 1, 1, 1) then
				Color = var_22_1
				var_22_1 = var_22_1.New(0.2235294, 0.227451, 0.2352941, 1)
			end

			var_22_6.color = var_22_1
			setActive = var_22_1

			var_22_1(arg_22_1:Find("selected"), var_22_0)

			return
		end
	end
end

return var_0_1
