local var_0_0 = class("EquipRecGroupItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.titleStrings_ = {
		GetTips("EQUIP_RECOMMEND_1"),
		GetTips("EQUIP_RECOMMEND_2"),
		(GetTips("EQUIP_RECOMMEND_3"))
	}
	arg_1_0.descItems_ = {}

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.indexController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "index")
	arg_3_0.items_ = {}
	arg_3_0.itemGos_ = {
		arg_3_0.item1,
		arg_3_0.item2,
		arg_3_0.item3,
		arg_3_0.item4,
		arg_3_0.item5,
		arg_3_0.item6
	}

	for iter_3_0 = 1, 6 do
		local var_3_0 = EquipRecItem.New(arg_3_0.itemGos_[iter_3_0])

		table.insert(arg_3_0.items_, var_3_0)
	end
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.index_ = arg_4_1
	arg_4_0.equipList_ = arg_4_2
	arg_4_0.heroId_ = arg_4_3

	arg_4_0.indexController_:SetSelectedState(tostring(arg_4_1))
	arg_4_0:UpdateView()
end

function var_0_0.UpdateView(arg_5_0)
	arg_5_0.nameText_.text = GetI18NText(arg_5_0.titleStrings_[arg_5_0.index_])

	for iter_5_0 = 1, #arg_5_0.items_ do
		local var_5_0 = arg_5_0.equipList_[iter_5_0]

		arg_5_0.items_[iter_5_0]:SetEquipId(iter_5_0, arg_5_0.heroId_, var_5_0, arg_5_0:HaveEquipWithRace(var_5_0))
	end

	local var_5_1 = {}

	for iter_5_1, iter_5_2 in ipairs(arg_5_0.equipList_) do
		local var_5_2 = EquipCfg[iter_5_2].suit

		if not table.indexof(var_5_1, var_5_2) then
			table.insert(var_5_1, var_5_2)
		end
	end

	for iter_5_3, iter_5_4 in ipairs(var_5_1) do
		local var_5_3 = EquipSuitCfg[iter_5_4]
		local var_5_4 = var_5_3.suit_effect[1]
		local var_5_5 = EquipEffectCfg[var_5_4]
		local var_5_6 = GetCfgDescription(var_5_5.desc[1], 1)
		local var_5_7 = var_5_3.name

		if not arg_5_0.descItems_[iter_5_3] then
			local var_5_8 = Object.Instantiate(arg_5_0.descItemPrefab_, arg_5_0.container_)

			arg_5_0.descItems_[iter_5_3] = EquipRecDescItem.New(var_5_8)
		end

		arg_5_0.descItems_[iter_5_3]:SetData(var_5_7, var_5_6)
	end

	while #arg_5_0.descItems_ > #var_5_1 do
		arg_5_0.descItems_[#arg_5_0.descItems_]:Dispose()
		table.remove(arg_5_0.descItems_, #arg_5_0.descItems_)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.container_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.transform_)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.gotoChangeBtn_, nil, function()
		local var_7_0 = EquipRecommendCfg[arg_6_0.heroId_] and EquipRecommendCfg[arg_6_0.heroId_].suit_list or {}
		local var_7_1 = {}

		if var_7_0[1] then
			local var_7_2 = var_7_0[1]

			table.insert(var_7_1, var_7_2)
		end

		if var_7_0[2] then
			local var_7_3 = var_7_0[2]

			table.insert(var_7_1, var_7_3)
		end

		arg_6_0:Go("/heroEquipBag", {
			isOpenInfo = false,
			suitPos = 0,
			isClearPos = true,
			suit = "recommend",
			heroId = arg_6_0.heroId_,
			ids = var_7_1
		})
	end)
end

function var_0_0.OnEnter(arg_8_0)
	return
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.HaveEquipWithRace(arg_10_0, arg_10_1)
	local var_10_0 = {
		arg_10_1
	}
	local var_10_1 = EquipCfg[arg_10_1]

	if var_10_1.race == 0 then
		local var_10_2 = EquipCfg.get_id_list_by_suit[var_10_1.suit]

		for iter_10_0, iter_10_1 in ipairs(var_10_2) do
			local var_10_3 = EquipCfg[iter_10_1]

			if var_10_3.starlevel == var_10_1.starlevel and var_10_3.pos == var_10_1.pos then
				table.insert(var_10_0, iter_10_1)
			end
		end
	end

	local var_10_4 = EquipData:GetEquipList()

	for iter_10_2, iter_10_3 in pairs(var_10_4) do
		if table.indexof(var_10_0, iter_10_3.prefab_id) then
			return true
		end
	end

	return false
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()

	if arg_11_0.items_ then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0.items_) do
			iter_11_1:Dispose()
		end

		arg_11_0.items_ = nil
	end

	if arg_11_0.descItems_ then
		for iter_11_2, iter_11_3 in ipairs(arg_11_0.descItems_) do
			iter_11_3:Dispose()
		end

		arg_11_0.descItems_ = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
