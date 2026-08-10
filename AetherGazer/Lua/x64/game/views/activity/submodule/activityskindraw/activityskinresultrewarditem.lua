local var_0_0 = class("ActivitySkinResultRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.typeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
	arg_3_0.switchCon_ = ControllerUtil.GetController(arg_3_0.transform_, "switch")
	arg_3_0.numCon_ = ControllerUtil.GetController(arg_3_0.transform_, "num")

	if arg_3_0.controllerEx_ then
		arg_3_0.giftController_ = arg_3_0.controllerEx_:GetController("gift")
	end

	arg_3_0.commonItem_ = CommonItemView.New(arg_3_0.commonItemGo_)
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		ShowPopItem(POP_ITEM, {
			arg_4_0.itemID_
		})
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.id_ = arg_6_1
	arg_6_0.cfg_ = ActivityLimitedDrawPoolCfg[arg_6_1]

	local var_6_0 = arg_6_0.cfg_.reward[1]

	arg_6_0.itemID_ = var_6_0[1]

	local var_6_1 = ItemCfg[arg_6_0.itemID_]

	if ActivitySkinDrawTools.GetIsSkinGift(arg_6_0.itemID_) then
		arg_6_0.itemID_ = var_6_1.param[1][1]
		arg_6_0.freeGiftID_ = var_6_1.param[2][1]
		arg_6_0.freeGiftNum_ = var_6_1.param[2][2]
		var_6_1 = ItemCfg[arg_6_0.itemID_]
	else
		arg_6_0.freeGiftID_ = nil
		arg_6_0.freeGiftNum_ = nil
	end

	local var_6_2 = var_6_1.type == ItemConst.ITEM_TYPE.HERO_SKIN

	if var_6_2 or var_6_1.type == ItemConst.ITEM_TYPE.SCENE then
		arg_6_0.typeCon_:SetSelectedState("special")
	else
		arg_6_0.typeCon_:SetSelectedState(arg_6_0.cfg_.minimum_guarantee == 2 and 3 or 2)
	end

	local var_6_3 = GetI18NText("x" .. var_6_0[2])
	local var_6_4 = GetI18NText(ItemTools.getItemName(arg_6_0.itemID_))

	arg_6_0.num_.text = var_6_3
	arg_6_0.name_.text = var_6_4

	SetActive(arg_6_0.role_.gameObject, var_6_2)
	SetActive(arg_6_0.icon_.gameObject, not var_6_2)

	if var_6_2 then
		arg_6_0.role_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. arg_6_0.itemID_)
	else
		arg_6_0.icon_.sprite = ItemTools.getItemSprite(arg_6_0.itemID_)
	end

	if arg_6_3 and ItemCfg[arg_6_0.itemID_].num_exchange_item then
		arg_6_0.switchCon_:SetSelectedState("on")

		arg_6_0.replaceNameText_.text = var_6_4

		arg_6_0.numCon_:SetSelectedState("false")

		local var_6_5 = ItemCfg[arg_6_0.itemID_].num_exchange_item[1]
		local var_6_6 = clone(ItemTemplateData)

		var_6_6.id = var_6_5[1]
		var_6_6.number = var_6_5[2]

		arg_6_0.commonItem_:SetData(var_6_6)
	elseif arg_6_0.freeGiftID_ then
		arg_6_0.numCon_:SetSelectedState("false")
		arg_6_0.switchCon_:SetSelectedState("on")

		if arg_6_0.giftController_ then
			arg_6_0.giftController_:SetSelectedState("on")
		end

		arg_6_0.replaceNameText_.text = var_6_4

		local var_6_7 = clone(ItemTemplateData)

		var_6_7.id = arg_6_0.freeGiftID_
		var_6_7.number = arg_6_0.freeGiftNum_

		arg_6_0.commonItem_:SetData(var_6_7)
	else
		arg_6_0.numCon_:SetSelectedState("true")
		arg_6_0.switchCon_:SetSelectedState("off")

		if arg_6_0.giftController_ then
			arg_6_0.giftController_:SetSelectedState("off")
		end
	end
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveAllListeners()
	arg_8_0.commonItem_:Dispose()
	arg_8_0.super.Dispose(arg_8_0)
end

return var_0_0
