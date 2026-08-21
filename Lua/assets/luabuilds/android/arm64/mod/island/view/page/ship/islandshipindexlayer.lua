local var_0_0 = class("IslandShipIndexLayer", import("view.common.CustomIndexLayer"))

function var_0_0.SortFunc(arg_1_0)
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

var_0_0.SortNames = {
	"island_chara_list_level",
	"island_chara_list_attribute",
	"island_index_name"
}
var_0_0.sort = {
	{
		sortFuncs = var_0_0.SortFunc("Level"),
		name = var_0_0.SortNames[1]
	},
	{
		sortFuncs = var_0_0.SortFunc("Power"),
		name = var_0_0.SortNames[2]
	},
	{
		sortFuncs = var_0_0.SortFunc("CurrentEnergy"),
		name = var_0_0.SortNames[3]
	},
	{
		name = "island_chara_list_workspeed",
		sortFuncs = var_0_0.SortFunc("WorkSpeed")
	}
}

function var_0_0.getSortFuncAndName(arg_4_0, arg_4_1)
	for iter_4_0 = 1, #var_0_0.sort do
		if bit.band(bit.lshift(1, iter_4_0 - 1), arg_4_0) > 0 then
			return underscore.map(var_0_0.sort[iter_4_0].sortFuncs, function(arg_5_0)
				return function(arg_6_0)
					local var_6_0 = arg_5_0(arg_6_0)

					return (arg_4_1 and -1 or 1) * arg_5_0(arg_6_0)
				end
			end), var_0_0.sort[iter_4_0].name
		end
	end

	return
end

var_0_0.SortLevel = bit.lshift(1, 0)
var_0_0.SortPower = bit.lshift(1, 1)
var_0_0.SortEnergy = bit.lshift(1, 2)
var_0_0.SortWorkSpeed = bit.lshift(1, 3)
var_0_0.SortIndexs = {
	var_0_0.SortLevel,
	var_0_0.SortPower,
	var_0_0.SortEnergy
}
var_0_0.ExtraPotency = bit.lshift(1, 0)
var_0_0.ExtraCanUpgSkill = bit.lshift(1, 1)
var_0_0.ExtraSpeStatus = bit.lshift(1, 2)
var_0_0.ExtraIndexs = {
	var_0_0.ExtraPotency,
	var_0_0.ExtraCanUpgSkill,
	var_0_0.ExtraSpeStatus
}
var_0_0.ExtraALL = IndexConst.BitAll(var_0_0.ExtraIndexs)

table.insert(var_0_0.ExtraIndexs, 1, var_0_0.ExtraALL)

var_0_0.ExtraNames = {
	"island_index_extra_all",
	"island_index_potency",
	"island_index_skill",
	"island_index_status"
}

local var_0_1 = {
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

function var_0_0.filterByExtra(arg_11_0, arg_11_1)
	if not arg_11_1 or arg_11_1 == var_0_0.ExtraALL then
		return true
	end

	for iter_11_0 = 2, #var_0_1 do
		if bit.band(bit.lshift(1, iter_11_0 - 2), arg_11_1) > 0 and var_0_1[iter_11_0](arg_11_0) then
			return true
		end
	end

	return false
end

function var_0_0.getUIName(arg_12_0)
	return "IslandCustomIndexUI"
end

function var_0_0.init(arg_13_0)
	var_0_0.super.init(arg_13_0)

	arg_13_0.titleTxt = arg_13_0._tf:Find("index_panel/layout/tip"):GetComponent(typeof(Text))
	arg_13_0.closeBtn = arg_13_0._tf:Find("index_panel/layout/clsoe")
	arg_13_0.tplContainer = arg_13_0._tf:Find("index_panel/layout/container")
	arg_13_0.OnFilter = arg_13_0.contextData.OnFilter
	arg_13_0.indexDatas = arg_13_0.contextData.defaultIndex or {}
	arg_13_0.needWorkSpeed = arg_13_0.contextData.needWorkSpeed or false

	return
end

function var_0_0.BlurPanel(arg_14_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_14_0._tf)

	return
end

function var_0_0.DoEnterAnimation(arg_15_0)
	return
end

function var_0_0.didEnter(arg_16_0)
	arg_16_0.contextData = arg_16_0:InitData()

	var_0_0.super.didEnter(arg_16_0)

	arg_16_0.titleTxt.text = i18n("child_filter_title")

	onButton(arg_16_0, arg_16_0.closeBtn, function()
		arg_16_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.InitGroup(arg_18_0)
	var_0_0.super.InitGroup(arg_18_0)

	for iter_18_0 = 1, arg_18_0.tplContainer.childCount do
		local var_18_0 = arg_18_0.tplContainer:GetChild(iter_18_0 - 1):Find("bg")

		if var_18_0.childCount > 7 then
			(function(arg_19_0)
				setActive(arg_19_0:Find("line"), false)

				return
			end)(var_18_0:GetChild(6))
		end

		if var_18_0.childCount > 0 then
			(function(arg_19_0)
				setActive(arg_19_0:Find("line"), false)

				return
			end)(var_18_0:GetChild(var_18_0.childCount - 1))
		end
	end

	return
end

function var_0_0.InitData(arg_20_0)
	local var_20_0 = Clone(var_0_0.SortNames)
	local var_20_1 = Clone(var_0_0.SortIndexs)

	if arg_20_0.needWorkSpeed then
		table.insert(var_20_0, "island_chara_list_workspeed")
		table.insert(var_20_1, var_0_0.SortWorkSpeed)
	end

	return {
		indexDatas = Clone(arg_20_0.indexDatas),
		customPanels = {
			sortIndex = {
				isSort = true,
				mode = CustomIndexLayer.Mode.OR,
				options = var_20_1,
				names = var_20_0
			},
			extraIndex = {
				blueSeleted = true,
				mode = CustomIndexLayer.Mode.AND,
				options = var_0_0.ExtraIndexs,
				names = var_0_0.ExtraNames
			}
		},
		groupList = {
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
		},
		callback = function(arg_21_0)
			arg_20_0.OnFilter(arg_21_0)

			return
		end
	}
end

function var_0_0.UpdateBtnStyle(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_2 ~= arg_22_0.greySprite
	local var_22_1 = arg_22_1:GetComponent(typeof(Image))

	var_22_1.color = arg_22_2 ~= arg_22_0.greySprite and Color.New(0, 0, 0, 1) or Color.New(1, 1, 1, 1)

	local var_22_2 = arg_22_1:Find("Image"):GetComponent(typeof(Text))

	var_22_2.color = var_22_0 and Color.New(1, 1, 1, 1) or Color.New(0.2235294, 0.227451, 0.2352941, 1)

	setActive(arg_22_1:Find("selected"), var_22_0)

	return
end

return var_0_0
