local var_0_0 = class("CultureGravureEquiptItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.equiptList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexEquiptItem), arg_2_0.equiptListGo_, CultureGravureRecommendEquipItem)
	arg_2_0.infoNumController_ = arg_2_0.equipCon_:GetController("infonum")
	arg_2_0.equipController_ = arg_2_0.equipCon_:GetController("state")
	arg_2_0.infoItemList_ = {}

	for iter_2_0 = 1, 3 do
		local var_2_0 = CultureGravureEquiptInfoItem.New(arg_2_0["infoGo" .. iter_2_0 .. "_"])

		table.insert(arg_2_0.infoItemList_, var_2_0)
	end
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.data_ = arg_3_2
	arg_3_0.rate_ = arg_3_2.rate
	arg_3_0.heroID_ = arg_3_3
	arg_3_0.recommendIdList_ = arg_3_2.list

	table.sort(arg_3_0.recommendIdList_, function(arg_4_0, arg_4_1)
		local var_4_0 = EquipCfg[arg_4_0]
		local var_4_1 = EquipCfg[arg_4_1]

		return var_4_0.pos < var_4_1.pos
	end)

	arg_3_0.stateList_ = {}
	arg_3_0.hasAllEquipt = true
	arg_3_0.canAllEquipt = true

	arg_3_0:RefreshUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.equipBtn_, nil, function()
		if arg_5_0.hasAllEquipt or not arg_5_0.canAllEquipt then
			return
		end

		local var_6_0 = {
			index = 0,
			heroId = arg_5_0.heroID_,
			recommendIdList = arg_5_0.recommendIdList_,
			stateList = arg_5_0.stateList_
		}

		JumpTools.OpenPageByJump("cultureGravureEquipPopView", var_6_0)
	end)
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()
end

function var_0_0.SetCallBack(arg_8_0, arg_8_1)
	arg_8_0.callback = arg_8_1
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.rateText_.text = math.floor(arg_9_0.rate_ / 100)

	arg_9_0.equiptList_:StartScroll(#arg_9_0.recommendIdList_)

	local var_9_0 = {}
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.recommendIdList_) do
		local var_9_2 = EquipCfg[iter_9_1]

		if not var_9_0[var_9_2.suit] then
			var_9_0[var_9_2.suit] = {}
			var_9_1 = var_9_1 + 1
		end

		table.insert(var_9_0[var_9_2.suit], iter_9_1)
	end

	arg_9_0.infoNumController_:SetSelectedState(var_9_1)

	local var_9_3 = {}

	for iter_9_2, iter_9_3 in pairs(var_9_0) do
		table.insert(var_9_3, iter_9_3)
	end

	if #var_9_3 > 1 then
		table.sort(var_9_3, function(arg_10_0, arg_10_1)
			local var_10_0 = EquipCfg[arg_10_0[1]]
			local var_10_1 = EquipCfg[arg_10_1[1]]

			return var_10_0.pos < var_10_1.pos
		end)
	end

	for iter_9_4 = 1, #var_9_3 do
		arg_9_0.infoItemList_[iter_9_4]:SetData(iter_9_4, var_9_3[iter_9_4])
	end
end

function var_0_0.IndexEquiptItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.recommendIdList_[arg_11_1]
	local var_11_1 = CultureGravureData:GetHasEquipt(var_11_0)
	local var_11_2 = CultureGravureData:GetEquiptIsEquipped(arg_11_0.heroID_, var_11_0)

	if not var_11_2 then
		arg_11_0.hasAllEquipt = false
	end

	if not var_11_2 and not var_11_1 then
		arg_11_0.canAllEquipt = false
	end

	local var_11_3 = ""
	local var_11_4 = var_11_2 and "had" or var_11_1 and "equip" or "get"

	arg_11_0.stateList_[arg_11_1] = var_11_4

	arg_11_2:SetData(arg_11_1, var_11_0, arg_11_0.heroID_, var_11_4)

	if arg_11_1 == #arg_11_0.recommendIdList_ then
		SetActive(arg_11_0.btnGroup_, arg_11_0.canAllEquipt)
		arg_11_0.equipController_:SetSelectedState(tostring(arg_11_0.hasAllEquipt))
	end
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.equiptList_ then
		arg_12_0.equiptList_:Dispose()

		arg_12_0.equiptList_ = nil
	end

	if arg_12_0.infoItemList_ then
		for iter_12_0 = 1, #arg_12_0.infoItemList_ do
			arg_12_0.infoItemList_[iter_12_0]:Dispose()
		end

		arg_12_0.infoItemList_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
