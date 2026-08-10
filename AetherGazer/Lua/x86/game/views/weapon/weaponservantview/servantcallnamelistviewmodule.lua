local var_0_0 = class("ServantCallNameListViewModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
	arg_2_0:InitTab()
	arg_2_0:BuildContext()
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.staticVar = {
		scrollHelper = LuaList.New(handler(arg_3_0, arg_3_0.OnRenderHoldItem), arg_3_0.selectviewGo_, WeaponServantHeadItem),
		tabRaceMap = {
			1,
			2,
			3,
			4,
			5,
			9
		}
	}

	arg_3_0:InitContext()
end

function var_0_0.InitTab(arg_4_0)
	arg_4_0.tabModule = {}

	local var_4_0 = "tab%dObj_"

	for iter_4_0 = 1, 6 do
		local var_4_1 = string.format(var_4_0, iter_4_0)
		local var_4_2 = ServantCallNameTabModule.New(arg_4_0[var_4_1])

		var_4_2:RegisterClickCallback(function()
			if arg_4_0.context and arg_4_0.context.curRaceTab == iter_4_0 then
				return
			end

			arg_4_0:OnTabClick(iter_4_0)
		end)
		var_4_2:SetNumber(0)

		arg_4_0.tabModule[iter_4_0] = var_4_2
	end
end

function var_0_0.AddUIListener(arg_6_0)
	return
end

function var_0_0.OnEnter(arg_7_0)
	return
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()
	arg_9_0.staticVar.scrollHelper:Dispose()

	for iter_9_0 = 1, 6 do
		arg_9_0.tabModule[iter_9_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.InitContext(arg_10_0)
	arg_10_0.context = {
		curRaceTab = 1,
		itemCount = 0,
		curSelectIndex = 0,
		itemList = {},
		itemEntity = {}
	}
end

function var_0_0.EnterPage(arg_11_0, arg_11_1)
	arg_11_0:InitContext()

	arg_11_0.context.heroId = arg_11_1.heroId
	arg_11_0.context.curRaceTab = arg_11_0:GetRaceTab(arg_11_1.race or 1)

	local var_11_0 = arg_11_1.servantID

	arg_11_0:OnTabClick(arg_11_0.context.curRaceTab, var_11_0)
end

function var_0_0.RefreshList(arg_12_0, arg_12_1)
	arg_12_0.context.curRaceTab = arg_12_0:GetRaceTab(arg_12_1.race or 1)
	arg_12_0.context.heroId = arg_12_1.heroId

	local var_12_0 = arg_12_1.servantID
	local var_12_1 = ServantTools:GetAwakeServantList(arg_12_0.staticVar.tabRaceMap[arg_12_0.context.curRaceTab])
	local var_12_2 = #var_12_1
	local var_12_3 = 1
	local var_12_4 = false
	local var_12_5

	if var_12_0 then
		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
			if iter_12_1.id == var_12_0 then
				var_12_3 = iter_12_0
				var_12_4 = true
			end

			if ServantTools.ServantIsHeroRecom(iter_12_1.id, arg_12_0.context.heroId) then
				var_12_5 = iter_12_0
			end
		end
	end

	if not var_12_4 and var_12_5 then
		var_12_3 = var_12_5
	end

	arg_12_0.context.itemList = var_12_1
	arg_12_0.context.itemCount = var_12_2

	arg_12_0.staticVar.scrollHelper:StartScroll(var_12_2, var_12_3)

	arg_12_0.callNameTxt_.text = arg_12_0:GeSleeptName()

	arg_12_0:SelectIndexItem(var_12_3)
	arg_12_0:SelectServant(var_12_1[var_12_3])
	arg_12_0:RefreshRaceTabNum()
end

function var_0_0.RefreshRaceTabNum(arg_13_0)
	local var_13_0 = WeaponServantData:GetWeaponServantList()
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		local var_13_2 = WeaponServantCfg[iter_13_1.id].race

		if WeaponServantCfg[iter_13_1.id].type == 3 then
			var_13_1[var_13_2] = (var_13_1[var_13_2] or 0) + 1
		end
	end

	for iter_13_2 = 1, 6 do
		local var_13_3 = arg_13_0.staticVar.tabRaceMap[iter_13_2]

		arg_13_0.tabModule[iter_13_2]:SetNumber(var_13_1[var_13_3] or 0)
	end
end

function var_0_0.OnRenderHoldItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.context.itemList[arg_14_1]

	arg_14_0.context.itemEntity[arg_14_1] = arg_14_2

	arg_14_2:OnRender({
		isAdd = false,
		isEquip = true,
		uid = var_14_0.uid,
		id = var_14_0.id,
		number = var_14_0.stage,
		index = arg_14_1
	})
	arg_14_2:ShowSelect(arg_14_1 == arg_14_0.context.curSelectIndex)
	arg_14_2:ShowLock(var_14_0.locked == 1)
	arg_14_2:ShowMask(false)
	arg_14_2:RegistCallBack(function(arg_15_0)
		arg_14_0:OnItemClick(arg_15_0)
	end)
	arg_14_2:ShowLockObj(false)

	local var_14_1 = false

	if arg_14_0.context.heroId and arg_14_0.context.heroId > 0 then
		local var_14_2 = WeaponServantCfg[var_14_0.id].effect[1]
		local var_14_3 = 0

		if var_14_2 > 0 then
			var_14_3 = WeaponEffectCfg[var_14_2].spec_char[1]
		end

		if var_14_3 and var_14_3 > 0 and var_14_3 == arg_14_0.context.heroId then
			arg_14_2:ShowRecommendTag(true)

			var_14_1 = true
		end
	end

	if not var_14_1 then
		arg_14_2:ShowRecommendTag(false)
	end

	arg_14_2:RenderEquipStatus(false)
end

function var_0_0.OnItemClick(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1:GetIndex()
	local var_16_1 = arg_16_0.context.itemList[var_16_0]

	arg_16_0:SelectServant(var_16_1)
	arg_16_0:SelectIndexItem(var_16_0)
end

function var_0_0.SelectIndexItem(arg_17_0, arg_17_1)
	arg_17_0:HideIndexItem(arg_17_0.context.curSelectIndex)
	arg_17_0:ShowIndexItem(arg_17_1)

	arg_17_0.context.curSelectIndex = arg_17_1
end

function var_0_0.HideIndexItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.context.itemEntity[arg_18_1]

	if var_18_0 and var_18_0:GetIndex() == arg_18_1 then
		var_18_0:ShowSelect(false)
	end
end

function var_0_0.ShowIndexItem(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.context.itemEntity[arg_19_1]

	if var_19_0 and var_19_0:GetIndex() == arg_19_1 then
		var_19_0:ShowSelect(true)
	end
end

function var_0_0.RestoreListPostion(arg_20_0)
	arg_20_0.staticVar.scrollHelper:ScrollToIndex(arg_20_0.context.curSelectIndex)
end

function var_0_0.RegisterClickCallback(arg_21_0, arg_21_1)
	arg_21_0.staticVar.clickCallback = arg_21_1
end

function var_0_0.SelectServant(arg_22_0, arg_22_1)
	if arg_22_0.staticVar.clickCallback then
		arg_22_0.staticVar.clickCallback(arg_22_1)
	end
end

function var_0_0.OnTabClick(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:RefreshList({
		heroId = arg_23_0.context.heroId,
		race = arg_23_0.staticVar.tabRaceMap[arg_23_1],
		servantID = arg_23_2
	})

	for iter_23_0, iter_23_1 in pairs(arg_23_0.tabModule) do
		if iter_23_0 == arg_23_1 then
			iter_23_1:SetSelect(true)
		else
			iter_23_1:SetSelect(false)
		end
	end
end

function var_0_0.GeSleeptName(arg_24_0)
	local var_24_0 = arg_24_0:GetSelectRace()
	local var_24_1 = ""

	for iter_24_0, iter_24_1 in pairs(WeaponServantCfg) do
		if iter_24_1.race == var_24_0 and iter_24_1.type == 3 then
			var_24_1 = iter_24_1.id

			break
		end
	end

	return ItemTools.getItemName(var_24_1)
end

function var_0_0.GetSelectRace(arg_25_0)
	return arg_25_0.staticVar.tabRaceMap[arg_25_0.context.curRaceTab]
end

function var_0_0.GetRaceTab(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.staticVar.tabRaceMap) do
		if iter_26_1 == arg_26_1 then
			return iter_26_0
		end
	end

	return 1
end

return var_0_0
