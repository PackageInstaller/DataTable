local IslandShipIndexLayer = class("IslandShipIndexLayer", import("view.common.CustomIndexLayer"))

function IslandShipIndexLayer:SortFunc()
	return {
		function(arg_2_0)
			if not arg_2_0.isInvite then
				local var_2_0 = arg_2_0["Get" .. self](arg_2_0)

				return arg_2_0["Get" .. self](arg_2_0)
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

IslandShipIndexLayer.SortNames = {
	"island_chara_list_level",
	"island_chara_list_attribute",
	"island_index_name"
}
IslandShipIndexLayer.sort = {
	{
		sortFuncs = IslandShipIndexLayer.SortFunc("Level"),
		name = IslandShipIndexLayer.SortNames[1]
	},
	{
		sortFuncs = IslandShipIndexLayer.SortFunc("Power"),
		name = IslandShipIndexLayer.SortNames[2]
	},
	{
		sortFuncs = IslandShipIndexLayer.SortFunc("CurrentEnergy"),
		name = IslandShipIndexLayer.SortNames[3]
	},
	{
		name = "island_chara_list_workspeed",
		sortFuncs = IslandShipIndexLayer.SortFunc("WorkSpeed")
	}
}

function IslandShipIndexLayer:getSortFuncAndName(arg_4_1)
	for iter_4_0 = 1, #IslandShipIndexLayer.sort do
		if bit.band(bit.lshift(1, iter_4_0 - 1), self) > 0 then
			return underscore.map(IslandShipIndexLayer.sort[iter_4_0].sortFuncs, function(arg_5_0)
				return function(arg_6_0)
					local var_6_0 = arg_5_0(arg_6_0)

					return (arg_4_1 and -1 or 1) * arg_5_0(arg_6_0)
				end
			end), IslandShipIndexLayer.sort[iter_4_0].name
		end
	end

	return
end

IslandShipIndexLayer.SortLevel = bit.lshift(1, 0)
IslandShipIndexLayer.SortPower = bit.lshift(1, 1)
IslandShipIndexLayer.SortEnergy = bit.lshift(1, 2)
IslandShipIndexLayer.SortWorkSpeed = bit.lshift(1, 3)
IslandShipIndexLayer.SortIndexs = {
	IslandShipIndexLayer.SortLevel,
	IslandShipIndexLayer.SortPower,
	IslandShipIndexLayer.SortEnergy
}
IslandShipIndexLayer.ExtraPotency = bit.lshift(1, 0)
IslandShipIndexLayer.ExtraCanUpgSkill = bit.lshift(1, 1)
IslandShipIndexLayer.ExtraSpeStatus = bit.lshift(1, 2)
IslandShipIndexLayer.ExtraIndexs = {
	IslandShipIndexLayer.ExtraPotency,
	IslandShipIndexLayer.ExtraCanUpgSkill,
	IslandShipIndexLayer.ExtraSpeStatus
}
IslandShipIndexLayer.ExtraALL = IndexConst.BitAll(IslandShipIndexLayer.ExtraIndexs)

table.insert(IslandShipIndexLayer.ExtraIndexs, 1, IslandShipIndexLayer.ExtraALL)

IslandShipIndexLayer.ExtraNames = {
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

function IslandShipIndexLayer:filterByExtra(arg_11_1)
	if not arg_11_1 or arg_11_1 == IslandShipIndexLayer.ExtraALL then
		return true
	end

	for iter_11_0 = 2, #var_0_1 do
		if bit.band(bit.lshift(1, iter_11_0 - 2), arg_11_1) > 0 and var_0_1[iter_11_0](self) then
			return true
		end
	end

	return false
end

function IslandShipIndexLayer:getUIName()
	return "IslandCustomIndexUI"
end

function IslandShipIndexLayer:init()
	IslandShipIndexLayer.super.init(self)

	self.titleTxt = self._tf:Find("index_panel/layout/tip"):GetComponent(typeof(Text))
	self.closeBtn = self._tf:Find("index_panel/layout/clsoe")
	self.tplContainer = self._tf:Find("index_panel/layout/container")
	self.OnFilter = self.contextData.OnFilter
	self.indexDatas = self.contextData.defaultIndex or {}
	self.needWorkSpeed = self.contextData.needWorkSpeed or false

	return
end

function IslandShipIndexLayer:BlurPanel()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function IslandShipIndexLayer:DoEnterAnimation()
	return
end

function IslandShipIndexLayer:didEnter()
	self.contextData = self:InitData()

	IslandShipIndexLayer.super.didEnter(self)

	self.titleTxt.text = i18n("child_filter_title")

	onButton(self, self.closeBtn, function()
		self:emit(IslandShipIndexLayer.ON_CLOSE)

		return
	end, SFX_PANEL)

	return
end

function IslandShipIndexLayer:InitGroup()
	IslandShipIndexLayer.super.InitGroup(self)

	local function var_18_0(arg_19_0)
		setActive(arg_19_0:Find("line"), false)

		return
	end

	for iter_18_0 = 1, self.tplContainer.childCount do
		local var_18_1 = self.tplContainer:GetChild(iter_18_0 - 1):Find("bg")

		if var_18_1.childCount > 7 then
			var_18_0(var_18_1:GetChild(6))
		end

		if var_18_1.childCount > 0 then
			var_18_0(var_18_1:GetChild(var_18_1.childCount - 1))
		end
	end

	return
end

function IslandShipIndexLayer:InitData()
	local var_20_0 = Clone(IslandShipIndexLayer.SortNames)
	local var_20_1 = Clone(IslandShipIndexLayer.SortIndexs)

	if self.needWorkSpeed then
		table.insert(var_20_0, "island_chara_list_workspeed")
		table.insert(var_20_1, IslandShipIndexLayer.SortWorkSpeed)
	end

	return {
		indexDatas = Clone(self.indexDatas),
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
				options = IslandShipIndexLayer.ExtraIndexs,
				names = IslandShipIndexLayer.ExtraNames
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
			self.OnFilter(arg_21_0)

			return
		end
	}
end

function IslandShipIndexLayer:UpdateBtnStyle(arg_22_1, arg_22_2)
	local var_22_0 = arg_22_2 ~= self.greySprite

	arg_22_1:GetComponent(typeof(Image)).color = arg_22_2 ~= self.greySprite and Color.New(0, 0, 0, 1) or Color.New(1, 1, 1, 1)
	arg_22_1:Find("Image"):GetComponent(typeof(Text)).color = var_22_0 and Color.New(1, 1, 1, 1) or Color.New(0.2235294, 0.227451, 0.2352941, 1)

	setActive(arg_22_1:Find("selected"), var_22_0)

	return
end

return IslandShipIndexLayer
