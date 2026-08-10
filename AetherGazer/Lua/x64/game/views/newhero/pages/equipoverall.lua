local var_0_0 = class("EquipOverall", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.suitItems_ = {}
	arg_3_0.attrItem_ = {}

	for iter_3_0 = 1, 3 do
		local var_3_0 = arg_3_0["attrItem_" .. iter_3_0]

		arg_3_0.attrItem_[iter_3_0] = AttributeItem.New(arg_3_0, var_3_0)
	end

	arg_3_0.tabController_ = arg_3_0.transCon_:GetController("tab")
	arg_3_0.stateController_ = arg_3_0.transCon_:GetController("btnActive")
	arg_3_0.btnController_ = arg_3_0.btnCon_:GetController("btnState")
	arg_3_0.suitController_ = arg_3_0.suitCon_:GetController("suit")
	arg_3_0.skillScroller_ = LuaList.New(handler(arg_3_0, arg_3_0.indexSkillItem), arg_3_0.skillListGo_, EquipNewSkillItem)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btnSuit_, nil, function()
		arg_4_0.tabController_:SetSelectedState("suit")
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnSkill_, nil, function()
		arg_4_0.tabController_:SetSelectedState("skill")
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnSave_, nil, function()
		arg_4_0.saveFunc_()
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnDelete_, nil, function()
		arg_4_0.deleteFunc_()
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnEquip_, nil, function()
		arg_4_0.equipFunc_()
	end)
end

function var_0_0.OnEnter(arg_10_0, arg_10_1)
	arg_10_0.heroViewProxy_ = arg_10_1
end

function var_0_0.RefreshSuitItem(arg_11_0)
	if #arg_11_0.suitList_ ~= 0 then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0.suitList_) do
			local var_11_0 = arg_11_0.suitItems_[iter_11_0]

			if var_11_0 == nil then
				local var_11_1 = Object.Instantiate(arg_11_0.suitGo_, arg_11_0.suitContent_, false)

				var_11_0 = EquipNewSuitItem.New(var_11_1)
				arg_11_0.suitItems_[iter_11_0] = var_11_0
			end

			SetActive(var_11_0.gameObject_, true)
			var_11_0:RefreshData(arg_11_0.heroViewProxy_:GetHeroData(arg_11_0.heroID_), arg_11_0.suitList_[iter_11_0])
		end
	end

	for iter_11_2 = #arg_11_0.suitList_ + 1, #arg_11_0.suitItems_ do
		SetActive(arg_11_0.suitItems_[iter_11_2].gameObject_, false)
	end

	arg_11_0.suitController_:SetSelectedState(#arg_11_0.suitList_ ~= 0 and "suit" or "empty")
end

function var_0_0.indexSkillItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.skillList_[arg_12_1]

	arg_12_2:RefreshData(var_12_0, true)
	arg_12_2:RegistCallBack(function(arg_13_0)
		arg_12_0:SkillClick(arg_12_2, arg_13_0)
	end)
end

function var_0_0.RefreshHeroInfo(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_1.id

	arg_14_0.heroID_ = arg_14_1.id

	arg_14_0:RefreshAttr(arg_14_2, var_14_0)
	arg_14_0:RefreshSkill(arg_14_2, arg_14_1, var_14_0)
	arg_14_0:RefreshSuit(arg_14_2, var_14_0)
	arg_14_0:RefreshBtn(arg_14_3)
end

function var_0_0.RefreshAttr(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.heroViewProxy_:CalHeroEquipAttribute(arg_15_2, arg_15_1)

	for iter_15_0 = 1, 3 do
		arg_15_0.attrItem_[iter_15_0]:RefreshData(arg_15_0, {
			index = iter_15_0,
			attrS = var_15_0
		})
	end
end

function var_0_0.RefreshSkill(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0.heroViewProxy_:GetEquipDataList(arg_16_3, arg_16_1)
	local var_16_1, var_16_2, var_16_3 = EquipTools.CountHeroTotalSkill(var_16_0, arg_16_2, true)

	arg_16_0.equipList_ = var_16_0
	arg_16_0.isAdd_ = var_16_2
	arg_16_0.skillList_ = {}

	for iter_16_0, iter_16_1 in pairs(var_16_1) do
		table.insert(arg_16_0.skillList_, {
			unlockLevel = 0,
			id = iter_16_0,
			num = iter_16_1,
			isAdd = var_16_2,
			location = var_16_3[iter_16_0]
		})
	end

	local var_16_4 = HeroCfg[arg_16_3].equip_skill

	table.sort(arg_16_0.skillList_, function(arg_17_0, arg_17_1)
		local var_17_0 = table.indexof(var_16_4, arg_17_0.id)
		local var_17_1 = table.indexof(var_16_4, arg_17_1.id)

		if var_17_0 and var_17_1 then
			return var_17_0 < var_17_1
		end

		return arg_17_0.id < arg_17_1.id
	end)
	arg_16_0.skillScroller_:StartScroll(#arg_16_0.skillList_)
end

function var_0_0.RefreshSuit(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.heroViewProxy_:GetEquipDataList(arg_18_2, arg_18_1)

	arg_18_0.suitList_ = EquipTools.CountActiveSuit(var_18_0)

	for iter_18_0 = #arg_18_0.suitList_, 1, -1 do
		arg_18_0.suitList_[iter_18_0].heroId = arg_18_2
	end

	arg_18_0:RefreshSuitItem()
end

function var_0_0.RefreshBtn(arg_19_0, arg_19_1)
	if arg_19_1 and arg_19_0.heroViewProxy_.isSelf then
		arg_19_0.stateController_:SetSelectedState("on")
		arg_19_0.btnController_:SetSelectedState(arg_19_1)
	else
		arg_19_0.stateController_:SetSelectedState("off")
	end
end

function var_0_0.RegistSkillClick(arg_20_0, arg_20_1)
	arg_20_0.skillClickFunc_ = arg_20_1
end

function var_0_0.SkillClick(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0.lastSkillSelect_ then
		arg_21_0.lastSkillSelect_:ShowSelect(false)
	end

	arg_21_0.lastSkillSelect_ = arg_21_1

	arg_21_1:ShowSelect(true)
	arg_21_0.skillClickFunc_(arg_21_1, arg_21_2)
end

function var_0_0.RegistOptionButton(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_0.saveFunc_ = arg_22_1
	arg_22_0.equipFunc_ = arg_22_2
	arg_22_0.deleteFunc_ = arg_22_3
end

function var_0_0.DeSelect(arg_23_0)
	if arg_23_0.lastSkillSelect_ then
		arg_23_0.lastSkillSelect_:ShowSelect(false)
	end
end

function var_0_0.Dispose(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.suitItems_) do
		iter_24_1:Dispose()
	end

	arg_24_0.suitItems_ = nil

	if arg_24_0.skillScroller_ then
		arg_24_0.skillScroller_:Dispose()

		arg_24_0.skillScroller_ = nil
	end

	if arg_24_0.attrItem_ then
		for iter_24_2, iter_24_3 in pairs(arg_24_0.attrItem_) do
			iter_24_3:Dispose()
		end

		arg_24_0.attrItem_ = nil
	end

	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
