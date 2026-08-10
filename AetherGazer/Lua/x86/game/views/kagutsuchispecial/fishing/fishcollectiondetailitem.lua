local var_0_0 = class("FishCollectionDetailItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	if arg_2_0.card_ then
		arg_2_0.cardItem = HanafudaCardView.New(arg_2_0.card_)
	end

	arg_2_0:AddBtnListener(arg_2_0.detailMaskBtn_, nil, function()
		if arg_2_0.clickOnMaskFunc then
			arg_2_0.clickOnMaskFunc()
		end
	end)

	arg_2_0.controller = ControllerUtil.GetController(arg_2_0.transform_, "rarity")
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	if arg_4_0.cardItem then
		arg_4_0.cardItem:Dispose()
	end
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	local var_5_0 = HanafudaCardCfg[arg_5_1]
	local var_5_1 = RareFishCfg[var_5_0.desc]

	arg_5_0.name = var_5_1.name
	arg_5_0.name_.text = arg_5_0.name

	local var_5_2 = KagutsuchiFishingEventData:GetRarity(arg_5_1)
	local var_5_3 = {
		id = arg_5_1,
		race = var_5_0.race,
		desc = var_5_0.desc,
		placeType = HanafudaData.CARD_PLACE_TYPE.COLLECTION,
		rarity = var_5_2.order
	}

	if arg_5_0.cardItem then
		arg_5_0.cardItem:SetData(1, var_5_3)
	end

	if var_5_2 == KagutsuchiFishingEventData.EnumFishRarity.B then
		arg_5_0.descText_.text = GetTipsF("ACTIVITY_KAGUTSUCHI_FISH_CARD_UNLOCK_TIPS", var_5_1.name)
	else
		arg_5_0.descText_.text = var_5_1.desc
	end

	arg_5_0.descText2_.text = var_5_1.talk

	if arg_5_0.controller then
		local var_5_4, var_5_5 = KagutsuchiFishingEventData:GetNextRarity(arg_5_1)

		arg_5_0.controller:SetSelectedState(var_5_2.name)

		arg_5_0.tips_.text = var_5_4 and GetTipsF("ACTIVITY_KAGUTSUCHI_CARD_LEVEL_UP", var_5_5, var_5_1.name, var_5_4.name) or ""
	end
end

function var_0_0.SetClickOnMask(arg_6_0, arg_6_1)
	arg_6_0.clickOnMaskFunc = arg_6_1
end

return var_0_0
