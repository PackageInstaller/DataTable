local var_0_0 = class("ChallengeRogueTeamShopPopItemView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.itemList_ = {}
	arg_1_0.itemView_ = ChallengeRogueTeamTreasureItem.New(arg_1_0.itemGo_, 1)
	arg_1_0.costController_ = arg_1_0.controllerEx_:GetController("cost")
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.itemView_:Dispose()

	arg_2_0.itemView_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.closeBtn_, nil, function()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_SELECTED)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.itemData_ = arg_5_1

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0.costImage_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetAttributeIconPath(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD))

	local var_6_0 = ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD)
	local var_6_1 = arg_6_0.itemData_
	local var_6_2 = math.ceil(ChallengeRogueTeamTools.GetShopItemDefaultPrice(var_6_1.id, var_6_1.rare) * var_6_1.discount / 100)

	arg_6_0.priceText_.text = var_6_2

	if var_6_0 < var_6_2 then
		arg_6_0.costController_:SetSelectedState("sufficient")
	else
		arg_6_0.costController_:SetSelectedState("Insufficient")
	end

	arg_6_0.itemData_.descRaycastFlag = true
	arg_6_0.itemData_.needShowCampFlag = true

	arg_6_0.itemView_:SetData(arg_6_0.itemData_)
	arg_6_0.itemView_:SelectTreasure(1)
end

return var_0_0
