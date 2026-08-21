local var_0_0 = class("ProposalCheck", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_equip/EquipmentUsePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.equipS_ = {}
	arg_3_0.itemS_ = {}

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.InitItem(arg_5_0, arg_5_1)
	local var_5_0 = {}

	ComponentBinder.GetInstance():BindCfgUI(var_5_0, arg_5_1)

	var_5_0.gameObject_ = arg_5_1
	var_5_0.equip = EquipItem.New(var_5_0.equipItemGo_)

	function var_5_0.RefreshUI(arg_6_0, arg_6_1)
		arg_6_0.equip:RefreshData(arg_6_1, true)

		arg_6_0.heroIcon_.sprite = HeroTools.GetSmallHeadSprite(arg_6_1.equiping)
	end

	return var_5_0
end

function var_0_0.RefreshItems(arg_7_0)
	for iter_7_0 = 1, #arg_7_0.list_ do
		if not arg_7_0.itemS_[iter_7_0] then
			local var_7_0 = Object.Instantiate(arg_7_0.itemGo_, arg_7_0.equipTrs_)

			arg_7_0.itemS_[iter_7_0] = arg_7_0:InitItem(var_7_0)

			SetActive(var_7_0, true)
			arg_7_0.itemS_[iter_7_0]:RefreshUI(arg_7_0.list_[iter_7_0])
		else
			SetActive(arg_7_0.itemS_[iter_7_0].gameObject_, true)
			arg_7_0.itemS_[iter_7_0]:RefreshUI(arg_7_0.list_[iter_7_0])
		end
	end

	for iter_7_1 = #arg_7_0.list_ + 1, #arg_7_0.itemS_ do
		SetActive(arg_7_0.itemS_[iter_7_1].gameObject_, false)
	end
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.btn_okBtn_, nil, function()
		local var_9_0 = {}

		for iter_9_0 = 1, #arg_8_0.equipS_ do
			var_9_0[iter_9_0] = {
				pos = arg_8_0.equipS_[iter_9_0].pos,
				equip_id = arg_8_0.equipS_[iter_9_0].equip_id
			}
		end

		EquipAction.EquipQuickDressOn(arg_8_0.heroID_, var_9_0)
	end)
	arg_8_0:AddBtnListener(arg_8_0.btn_cancelBtn_, nil, function()
		arg_8_0:Back()
	end)
end

function var_0_0.OnEquipQuickDressOn(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0 = 1, 6 do
		HeroAction.HeroChangeEquip(arg_11_2.hero_id, arg_11_2.use_equip_list[iter_11_0].equip_id, arg_11_2.use_equip_list[iter_11_0].pos)
	end

	arg_11_0:Back()
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.equipS_ = arg_12_0.params_.equipS
	arg_12_0.heroID_ = arg_12_0.params_.heroID

	arg_12_0:UpdateData()
	arg_12_0:RefreshItems()
end

function var_0_0.OnExit(arg_13_0)
	return
end

function var_0_0.UpdateData(arg_14_0)
	arg_14_0.list_ = {}

	for iter_14_0, iter_14_1 in pairs(arg_14_0.equipS_) do
		local var_14_0 = iter_14_1.equip_id

		if var_14_0 ~= 0 and iter_14_1.equiping then
			local var_14_1 = deepClone(EquipData:GetEquipData(var_14_0))

			var_14_1.equiping = iter_14_1.equiping

			table.insert(arg_14_0.list_, var_14_1)
		end
	end
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveAllListeners()

	for iter_15_0, iter_15_1 in pairs(arg_15_0.itemS_) do
		iter_15_1.equip:Dispose()
	end

	arg_15_0.itemS_ = nil

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
