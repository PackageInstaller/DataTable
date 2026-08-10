local var_0_0 = class("ServantHoldListViewModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:BuildContext()
	arg_2_0:AddUIListener()
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.eventHandler = {
		replaceHandler = handler(arg_3_0, arg_3_0.OnServantReplaced),
		lockHandler = handler(arg_3_0, arg_3_0.OnServantLock)
	}
	arg_3_0.staticVar = {
		scrollHelper = LuaList.New(handler(arg_3_0, arg_3_0.OnRenderHoldItem), arg_3_0.selectviewGo_, WeaponServantHeadItem)
	}

	arg_3_0:InitContext()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.openFullListBtn_, nil, function()
		arg_4_0:OnFullListBtnClick()
	end)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:RegistEventListener(SERVANT_REPLACE, arg_6_0.eventHandler.replaceHandler)
	arg_6_0:RegistEventListener(SERVANT_LOCK, arg_6_0.eventHandler.lockHandler)
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveAllListeners()
	arg_8_0:RemoveAllEventListener()
	arg_8_0.staticVar.scrollHelper:Dispose()
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.InitContext(arg_9_0)
	arg_9_0.context = {
		curSelectIndex = 0,
		itemCount = 0,
		heroId = 0,
		itemList = {},
		itemEntity = {},
		itemMap = {},
		servantMap = ServantTools.GetServantMap()
	}
end

function var_0_0.RefreshList(arg_10_0, arg_10_1)
	local var_10_0 = {}

	if arg_10_1.custom.isCustom then
		for iter_10_0, iter_10_1 in ipairs(arg_10_1.custom.data or {}) do
			table.insert(var_10_0, {
				stage = 1,
				locked = 0,
				isCustom = true,
				id = iter_10_1
			})
		end
	elseif arg_10_1.heroId then
		var_10_0 = ServantTools:GetServantList(arg_10_1.heroId, nil, true)
	else
		local var_10_1 = ServantTools.GetWeaponShowData()

		var_10_0 = ServantTools:GetServantList(nil, var_10_1)
	end

	local var_10_2 = {}

	for iter_10_2, iter_10_3 in ipairs(var_10_0) do
		if iter_10_3.uid and iter_10_3.uid ~= 0 then
			var_10_2[iter_10_3.uid] = iter_10_2
		end
	end

	arg_10_0:InitContext()

	arg_10_0.context.heroId = arg_10_1.heroId

	local var_10_3 = #var_10_0
	local var_10_4 = var_10_2[arg_10_1.jumpUid or -1] or 1

	arg_10_0.context.itemList = var_10_0
	arg_10_0.context.itemCount = var_10_3
	arg_10_0.context.itemMap = var_10_2

	arg_10_0.staticVar.scrollHelper:StartScroll(var_10_3, var_10_4)
	arg_10_0:SelectIndexItem(var_10_4)
	arg_10_0:SelectServant(var_10_0[var_10_4])

	local var_10_5 = arg_10_1.emptyCallback

	if var_10_5 then
		var_10_5(var_10_3 == 0)
	end

	if arg_10_1.custom.isCustom then
		SetActive(arg_10_0.openFullListBtn_.gameObject, false)
	else
		SetActive(arg_10_0.openFullListBtn_.gameObject, var_10_3 ~= 0)
	end

	SetActive(arg_10_0.selectviewGo_, var_10_3 ~= 0)
end

function var_0_0.OnRenderHoldItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.context.itemList[arg_11_1]

	arg_11_0.context.itemEntity[arg_11_1] = arg_11_2

	arg_11_2:OnRender({
		isAdd = false,
		isEquip = true,
		uid = var_11_0.uid,
		id = var_11_0.id,
		number = var_11_0.stage,
		index = arg_11_1
	})
	arg_11_2:ShowSelect(arg_11_1 == arg_11_0.context.curSelectIndex)
	arg_11_2:ShowLock(var_11_0.locked == 1)
	arg_11_2:RegistCallBack(function(arg_12_0)
		arg_11_0:OnItemClick(arg_12_0)
	end)
	arg_11_2:ShowMask(var_11_0.isRecommend or false)

	local var_11_1 = false

	if arg_11_0.context.heroId and arg_11_0.context.heroId > 0 then
		local var_11_2 = WeaponServantCfg[var_11_0.id].effect[1]
		local var_11_3 = 0

		if var_11_2 > 0 then
			var_11_3 = WeaponEffectCfg[var_11_2].spec_char[1]
		end

		if var_11_3 and var_11_3 > 0 and var_11_3 == arg_11_0.context.heroId then
			arg_11_2:ShowRecommendTag(true)

			var_11_1 = true
		end
	end

	if not var_11_1 then
		arg_11_2:ShowRecommendTag(false)
	end

	if var_11_0.uid and var_11_0.uid ~= 0 then
		local var_11_4 = arg_11_0.context.servantMap[var_11_0.uid]

		if var_11_4 then
			arg_11_2:RenderEquipStatus(true, var_11_4)
		else
			arg_11_2:RenderEquipStatus(false)
		end
	else
		arg_11_2:RenderEquipStatus(false)
	end
end

function var_0_0.OnItemClick(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:GetIndex()
	local var_13_1 = arg_13_0.context.itemList[var_13_0]

	arg_13_0:SelectServant(var_13_1)
	arg_13_0:SelectIndexItem(var_13_0)
end

function var_0_0.SelectIndexItem(arg_14_0, arg_14_1)
	arg_14_0:HideIndexItem(arg_14_0.context.curSelectIndex)
	arg_14_0:ShowIndexItem(arg_14_1)

	arg_14_0.context.curSelectIndex = arg_14_1
end

function var_0_0.HideIndexItem(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.context.itemEntity[arg_15_1]

	if var_15_0 and var_15_0:GetIndex() == arg_15_1 then
		var_15_0:ShowSelect(false)
	end
end

function var_0_0.ShowIndexItem(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.context.itemEntity[arg_16_1]

	if var_16_0 and var_16_0:GetIndex() == arg_16_1 then
		var_16_0:ShowSelect(true)
	end
end

function var_0_0.RestoreListPostion(arg_17_0)
	arg_17_0.staticVar.scrollHelper:ScrollToIndex(arg_17_0.context.curSelectIndex)
end

function var_0_0.HideFilter(arg_18_0, arg_18_1)
	SetActive(arg_18_0.openFullListBtn_.gameObject, not arg_18_1)
end

function var_0_0.RegisterClickCallback(arg_19_0, arg_19_1)
	arg_19_0.staticVar.clickCallback = arg_19_1
end

function var_0_0.SelectServant(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.staticVar.clickCallback

	if var_20_0 then
		var_20_0(arg_20_1)
	end
end

function var_0_0.RegisterFullScreenCallback(arg_21_0, arg_21_1)
	arg_21_0.staticVar.fullScreenClickCallback = arg_21_1
end

function var_0_0.OnFullListBtnClick(arg_22_0)
	local var_22_0 = arg_22_0.staticVar.fullScreenClickCallback

	if var_22_0 then
		var_22_0()
	end
end

function var_0_0.OnServantReplaced(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0.context.servantMap = ServantTools.GetServantMap()

	arg_23_0:OnServantChanged(arg_23_3)
	arg_23_0:OnServantChanged(arg_23_2.servant_id)
end

function var_0_0.OnServantLock(arg_24_0, arg_24_1)
	arg_24_0:OnServantChanged(arg_24_1)
end

function var_0_0.OnServantChanged(arg_25_0, arg_25_1)
	if not arg_25_1 or arg_25_1 == 0 then
		return
	end

	local var_25_0 = deepClone(WeaponServantData:GetServantDataByUID(arg_25_1))
	local var_25_1 = arg_25_0.context.itemMap[arg_25_1]

	if not var_25_1 then
		return
	end

	local var_25_2 = arg_25_0.context.itemList[var_25_1]

	if not var_25_2 or var_25_2.uid ~= var_25_0.uid then
		return
	end

	arg_25_0.context.itemList[var_25_1] = var_25_0

	if arg_25_0.context.curSelectIndex == var_25_1 then
		arg_25_0:SelectServant(var_25_0)
	end

	local var_25_3 = arg_25_0.context.itemEntity[var_25_1]

	if not var_25_3 or var_25_3:GetIndex() ~= var_25_1 then
		return
	end

	var_25_3:OnRender({
		isAdd = false,
		isEquip = true,
		uid = var_25_0.uid,
		id = var_25_0.id,
		number = var_25_0.stage,
		index = var_25_1
	})
	var_25_3:ShowLock(var_25_0.locked == 1)

	local var_25_4 = arg_25_0.context.servantMap[arg_25_1]

	if var_25_4 then
		var_25_3:RenderEquipStatus(true, var_25_4)
	else
		var_25_3:RenderEquipStatus(false)
	end
end

return var_0_0
