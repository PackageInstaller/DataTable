local var_0_0 = class("ChallengeRogueTeamShopItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index_ = arg_1_4
	arg_1_0.type_ = arg_1_3

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateController_ = arg_1_0.controllerEx_:GetController("state")
	arg_1_0.discountController_ = arg_1_0.controllerEx_:GetController("price")
	arg_1_0.isNewController_ = arg_1_0.controllerEx_:GetController("collect")
	arg_1_0.bgController_ = arg_1_0.controllerEx_:GetController("bg")
	arg_1_0.qualityController_ = arg_1_0.controllerEx_:GetController("quality")
	arg_1_0.sufficientController_ = arg_1_0.controllerEx_:GetController("sufficient")

	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		local var_4_0 = arg_3_0.data_

		if var_4_0 == nil then
			return
		end

		local var_4_1 = var_4_0.id

		if var_4_0.buyTimes <= 0 then
			return
		end

		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_SELECTED, arg_3_0.data_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.data_ = arg_5_1

	if arg_5_1 == nil then
		local var_5_0

		if arg_5_0.type_ == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
			var_5_0 = ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.SHOP_SELL_TREASURE_MAX_CNT)
		else
			var_5_0 = ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.SHOP_SELL_RELIC_MAX_CNT)
		end

		if var_5_0 >= arg_5_0.index_ then
			arg_5_0.stateController_:SetSelectedState("soldout")
			arg_5_0.isNewController_:SetSelectedState("off")
			arg_5_0.bgController_:SetSelectedState("off")
			arg_5_0.discountController_:SetSelectedState("off")
		else
			arg_5_0.stateController_:SetSelectedState("lock")
			arg_5_0.isNewController_:SetSelectedState("off")
			arg_5_0.discountController_:SetSelectedState("off")
			arg_5_0.bgController_:SetSelectedState("off")
		end

		return
	end

	local var_5_1 = arg_5_1.id

	if arg_5_1.buyTimes <= 0 then
		arg_5_0.stateController_:SetSelectedState("owned")
		arg_5_0.isNewController_:SetSelectedState("off")
		arg_5_0.bgController_:SetSelectedState("off")
		arg_5_0.discountController_:SetSelectedState("off")
	else
		arg_5_0.stateController_:SetSelectedState("normal")
	end

	local var_5_2 = RogueTeamItemCfg[var_5_1]

	arg_5_0.nameText_.text = var_5_2.name

	local var_5_3 = ChallengeRogueTeamTools.GetShopItemDefaultPrice(var_5_1, arg_5_1.rare)
	local var_5_4 = math.ceil(var_5_3 * arg_5_1.discount / 100)

	if arg_5_1.discount == 100 then
		arg_5_0.discountController_:SetSelectedState("off")
	else
		arg_5_0.discountController_:SetSelectedState("on")

		arg_5_0.discountText_.text = string.format("%.01f%s", arg_5_1.discount / 10, GetTips("LABEL_DISCOUNT"))
		arg_5_0.originPriceText_.text = var_5_3
	end

	if var_5_4 > ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD) then
		arg_5_0.sufficientController_:SetSelectedState("false")
	else
		arg_5_0.sufficientController_:SetSelectedState("true")
	end

	arg_5_0.priceText_.text = var_5_4
	arg_5_0.costImage_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetAttributeIconPath(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD))
	arg_5_0.iconImage_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(var_5_1))

	if arg_5_1.isNew then
		arg_5_0.isNewController_:SetSelectedState("on")
	else
		arg_5_0.isNewController_:SetSelectedState("off")
	end

	if var_5_2.type == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
		arg_5_0.qualityController_:SetSelectedIndex(arg_5_1.rare)
		arg_5_0.bgController_:SetSelectedState("on")
	else
		arg_5_0.qualityController_:SetSelectedIndex(0)
		arg_5_0.bgController_:SetSelectedState("off")
	end
end

return var_0_0
