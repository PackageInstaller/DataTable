local var_0_0 = class("AutoChessCardMixItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.cardID_ = 0

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.mixBtnController_ = arg_3_0.controller_:GetController("MixBtn")
	arg_3_0.dropdownController_ = arg_3_0.controller_:GetController("dropdown")
	arg_3_0.btnController_ = arg_3_0.controller_:GetController("btn")
	arg_3_0.currentIconController_ = arg_3_0.controller_:GetController("currentIcon")
	arg_3_0.cardUiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiList_, AutoChessCardMixSelectItem)

	arg_3_0.dropdownController_:SetSelectedState("collapse")

	arg_3_0.selectIndexList_ = {}
	arg_3_0.URFactoryItem_ = AutoChessURFactoryItem.New(arg_3_0.URItemGo_)
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = false

	if arg_4_0.selectIndexList_[arg_4_1] then
		var_4_0 = true
	end

	arg_4_2:SetData(arg_4_0.sortCardIdList_[arg_4_1], var_4_0, arg_4_1, arg_4_0.URFactoryItem_:GetItem(arg_4_0.sortCardIdList_[arg_4_1]))
	arg_4_2:SetSelectHandler(handler(arg_4_0, arg_4_0.OnSelectCard))
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rBtn_, nil, function()
		arg_5_0.cardType_ = AutoChessCardConst.CARD_TYPE.R

		arg_5_0.currentIconController_:SetSelectedIndex(arg_5_0.cardType_ - 1)
		arg_5_0.dropdownController_:SetSelectedState("collapse")
		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(arg_5_0.srBtn_, nil, function()
		arg_5_0.cardType_ = AutoChessCardConst.CARD_TYPE.SR

		arg_5_0.currentIconController_:SetSelectedIndex(arg_5_0.cardType_ - 1)
		arg_5_0.dropdownController_:SetSelectedState("collapse")
		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(arg_5_0.urBtn_, nil, function()
		arg_5_0.cardType_ = AutoChessCardConst.CARD_TYPE.UR

		arg_5_0.currentIconController_:SetSelectedIndex(arg_5_0.cardType_ - 1)
		arg_5_0.dropdownController_:SetSelectedState("collapse")
		arg_5_0:RefreshUI()
	end)
	arg_5_0:AddBtnListener(arg_5_0.autoBtn_, nil, function()
		arg_5_0.dropdownController_:SetSelectedState("collapse")

		local var_9_0 = AutoChessCardTools.GetMixExpByCardType(arg_5_0.cardID_)
		local var_9_1, var_9_2, var_9_3 = AutoChessCardTools.GetMixCombinations(arg_5_0.exp_1, arg_5_0.exp_2, arg_5_0.exp_5, var_9_0)

		for iter_9_0, iter_9_1 in ipairs(arg_5_0.sortCardIdList_) do
			local var_9_4 = AutoChessCardCfg[iter_9_1]

			if var_9_4.type == AutoChessCardConst.CARD_TYPE.R and var_9_1 > 0 then
				arg_5_0.selectIndexList_[iter_9_0] = iter_9_1
				var_9_1 = var_9_1 - 1
			elseif var_9_4.type == AutoChessCardConst.CARD_TYPE.SR and var_9_2 > 0 then
				arg_5_0.selectIndexList_[iter_9_0] = iter_9_1
				var_9_2 = var_9_2 - 1
			elseif var_9_4.type == AutoChessCardConst.CARD_TYPE.UR and var_9_3 > 0 then
				arg_5_0.selectIndexList_[iter_9_0] = iter_9_1
				var_9_3 = var_9_3 - 1
			end

			if var_9_1 == 0 and var_9_2 == 0 and var_9_3 == 0 then
				break
			end
		end

		arg_5_0.cardUiList_:Refresh()
		arg_5_0:RefreshExp()

		if #arg_5_0.selectIndexList_ > 0 then
			arg_5_0.btnController_:SetSelectedState("cleanSelect")
		else
			arg_5_0.btnController_:SetSelectedState("autoInsert")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.cleanBtn_, nil, function()
		arg_5_0.dropdownController_:SetSelectedState("collapse")

		arg_5_0.selectIndexList_ = {}

		arg_5_0:RefreshUI()
		arg_5_0.btnController_:SetSelectedState("autoInsert")
	end)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		arg_5_0.dropdownController_:SetSelectedState("collapse")

		local var_11_0 = AutoChessCardTools.GetMixExpByCardType(arg_5_0.cardID_)
		local var_11_1 = {}

		for iter_11_0, iter_11_1 in pairs(arg_5_0.selectIndexList_) do
			if iter_11_1 == nil then
				-- block empty
			elseif var_11_1[iter_11_1] == nil then
				var_11_1[iter_11_1] = 1
			else
				var_11_1[iter_11_1] = var_11_1[iter_11_1] + 1
			end
		end

		local var_11_2 = {}

		for iter_11_2, iter_11_3 in pairs(var_11_1) do
			table.insert(var_11_2, {
				id = iter_11_2,
				num = iter_11_3
			})
		end

		AutoChessCardAction.MixCard(arg_5_0.cardID_, var_11_2)
	end)
	arg_5_0:AddBtnListener(arg_5_0.selectBtn_, nil, function()
		if arg_5_0.dropdownController_:GetSelectedState() == "expand" then
			arg_5_0.dropdownController_:SetSelectedState("collapse")
		else
			arg_5_0.dropdownController_:SetSelectedState("expand")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.disabledBtn_, nil, function()
		arg_5_0.dropdownController_:SetSelectedState("collapse")
	end)
end

function var_0_0.SetData(arg_14_0, arg_14_1)
	arg_14_0.cardID_ = arg_14_1
	arg_14_0.cardType_ = AutoChessCardConst.CARD_TYPE.SR

	arg_14_0.currentIconController_:SetSelectedIndex(arg_14_0.cardType_ - 1)
	arg_14_0.dropdownController_:SetSelectedState("collapse")
	arg_14_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_15_0)
	arg_15_0.selectIndexList_ = {}

	arg_15_0.btnController_:SetSelectedState("autoInsert")

	local var_15_0 = AutoChessCardData:GetCardList()

	arg_15_0.sortCardIdList_ = {}
	arg_15_0.exp_1 = 0
	arg_15_0.exp_2 = 0
	arg_15_0.exp_5 = 0

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		local var_15_1 = AutoChessCardCfg[iter_15_0]

		if var_15_1.type <= arg_15_0.cardType_ and iter_15_1 > 1 then
			if var_15_1.type == AutoChessCardConst.CARD_TYPE.UR then
				arg_15_0.exp_5 = arg_15_0.exp_5 + (iter_15_1 - 1)
			elseif var_15_1.type == AutoChessCardConst.CARD_TYPE.SR then
				arg_15_0.exp_2 = arg_15_0.exp_2 + (iter_15_1 - 1)
			elseif var_15_1.type == AutoChessCardConst.CARD_TYPE.R then
				arg_15_0.exp_1 = arg_15_0.exp_1 + (iter_15_1 - 1)
			end

			for iter_15_2 = 1, iter_15_1 - 1 do
				table.insert(arg_15_0.sortCardIdList_, iter_15_0)
			end
		end
	end

	table.sort(arg_15_0.sortCardIdList_, function(arg_16_0, arg_16_1)
		local var_16_0 = AutoChessCardCfg[arg_16_0]
		local var_16_1 = AutoChessCardCfg[arg_16_1]

		if var_16_0.type == var_16_1.type then
			return arg_16_0 < arg_16_1
		else
			return var_16_0.type < var_16_1.type
		end
	end)
	arg_15_0.cardUiList_:StartScroll(#arg_15_0.sortCardIdList_)
	arg_15_0:RefreshExp()
end

function var_0_0.RefreshExp(arg_17_0)
	local var_17_0 = AutoChessCardTools.GetMixExpByCardType(arg_17_0.cardID_)
	local var_17_1 = arg_17_0:GetTotalExp()

	arg_17_0.txtExp_.text = string.format("<color=\"#FFA500\"><size=44>%s</size></color>/%s", var_17_1, var_17_0)

	if var_17_0 <= var_17_1 then
		arg_17_0.mixBtnController_:SetSelectedState("On")
	else
		arg_17_0.mixBtnController_:SetSelectedState("Off")
	end
end

function var_0_0.OnSelectCard(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0.dropdownController_:SetSelectedState("collapse")

	if arg_18_1 then
		arg_18_0.selectIndexList_[arg_18_3] = arg_18_2

		if AutoChessCardTools.GetMixExpByCardType(arg_18_0.cardID_) < arg_18_0:GetTotalExp() then
			arg_18_0:AutoFixExp(arg_18_3)
		end
	else
		arg_18_0.selectIndexList_[arg_18_3] = nil
	end

	arg_18_0:RefreshExp()
	arg_18_0.btnController_:SetSelectedState("cleanSelect")
end

function var_0_0.GetTotalExp(arg_19_0)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in pairs(arg_19_0.selectIndexList_) do
		if iter_19_1 then
			var_19_0 = var_19_0 + AutoChessCardTools.GetExpByCardType(iter_19_1)
		end
	end

	return var_19_0
end

function var_0_0.AutoFixExp(arg_20_0, arg_20_1)
	local var_20_0 = AutoChessCardTools.GetMixExpByCardType(arg_20_0.cardID_)
	local var_20_1 = arg_20_0.selectIndexList_[arg_20_1]
	local var_20_2 = AutoChessCardTools.GetExpByCardType(var_20_1)
	local var_20_3 = AutoChessCardCfg[var_20_1]

	if var_20_3.type == AutoChessCardConst.CARD_TYPE.UR then
		arg_20_0.exp_5 = arg_20_0.exp_5 - 1
	elseif var_20_3.type == AutoChessCardConst.CARD_TYPE.SR then
		arg_20_0.exp_2 = arg_20_0.exp_2 - 1
	elseif var_20_3.type == AutoChessCardConst.CARD_TYPE.R then
		arg_20_0.exp_1 = arg_20_0.exp_1 - 1
	end

	local var_20_4, var_20_5, var_20_6 = AutoChessCardTools.GetMixCombinations(arg_20_0.exp_1, arg_20_0.exp_2, arg_20_0.exp_5, var_20_0 - var_20_2)

	for iter_20_0, iter_20_1 in pairs(arg_20_0.selectIndexList_) do
		if iter_20_1 and iter_20_0 ~= arg_20_1 then
			local var_20_7 = AutoChessCardCfg[iter_20_1]

			if var_20_7.type == AutoChessCardConst.CARD_TYPE.UR then
				if var_20_6 > 0 then
					var_20_6 = var_20_6 - 1
				else
					arg_20_0.selectIndexList_[iter_20_0] = nil
				end
			elseif var_20_7.type == AutoChessCardConst.CARD_TYPE.SR then
				if var_20_5 > 0 then
					var_20_5 = var_20_5 - 1
				else
					arg_20_0.selectIndexList_[iter_20_0] = nil
				end
			elseif var_20_7.type == AutoChessCardConst.CARD_TYPE.R then
				if var_20_4 > 0 then
					var_20_4 = var_20_4 - 1
				else
					arg_20_0.selectIndexList_[iter_20_0] = nil
				end
			end
		end
	end

	for iter_20_2, iter_20_3 in ipairs(arg_20_0.sortCardIdList_) do
		if not arg_20_0.selectIndexList_[iter_20_2] then
			local var_20_8 = AutoChessCardCfg[iter_20_3]

			if var_20_8.type == AutoChessCardConst.CARD_TYPE.R and var_20_4 > 0 then
				arg_20_0.selectIndexList_[iter_20_2] = iter_20_3
				var_20_4 = var_20_4 - 1
			elseif var_20_8.type == AutoChessCardConst.CARD_TYPE.SR and var_20_5 > 0 then
				arg_20_0.selectIndexList_[iter_20_2] = iter_20_3
				var_20_5 = var_20_5 - 1
			elseif var_20_8.type == AutoChessCardConst.CARD_TYPE.UR and var_20_6 > 0 then
				arg_20_0.selectIndexList_[iter_20_2] = iter_20_3
				var_20_6 = var_20_6 - 1
			end

			if var_20_4 == 0 and var_20_5 == 0 and var_20_6 == 0 then
				break
			end
		end
	end

	arg_20_0.cardUiList_:Refresh()
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.cardUiList_ then
		arg_21_0.cardUiList_:Dispose()

		arg_21_0.cardUiList_ = nil
	end

	arg_21_0.URFactoryItem_:Dispose()
	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
