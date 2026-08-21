local var_0_0 = class("ActivitySkinResultRewardItemOld", ReduxView)

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
	arg_6_0.cfg_ = ActivityLimitedDrawPoolCfg[arg_6_1]

	local var_6_0 = arg_6_0.cfg_.reward[1]

	arg_6_0.itemID_ = var_6_0[1]
	arg_6_0.id_ = arg_6_1
	arg_6_0.num_.text = GetI18NText("X" .. var_6_0[2])
	arg_6_0.name_.text = GetI18NText(ItemTools.getItemName(arg_6_0.itemID_))

	local var_6_1 = false

	if ItemCfg[arg_6_0.itemID_].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		arg_6_0.typeCon_:SetSelectedState("special")

		var_6_1 = true
	else
		arg_6_0.typeCon_:SetSelectedState(arg_6_0.cfg_.minimum_guarantee == 2 and 3 or 2)
	end

	SetActive(arg_6_0.role_.gameObject, var_6_1)
	SetActive(arg_6_0.icon_.gameObject, not var_6_1)

	if var_6_1 then
		arg_6_0.role_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. arg_6_0.itemID_)
	else
		arg_6_0.icon_.sprite = ItemTools.getItemSprite(arg_6_0.itemID_)
	end

	local var_6_2 = ActivitySkinDrawActionOld.GetIsCanReplace(arg_6_1)

	arg_6_0.numCon_:SetSelectedState(tostring(not var_6_2))

	if not arg_6_3 then
		arg_6_0.switchCon_:SetSelectedState("off")
	elseif ItemCfg[arg_6_0.itemID_].num_exchange_item then
		arg_6_0.switchCon_:SetSelectedState("on")
		arg_6_0.numCon_:SetSelectedState("false")

		local var_6_3 = ItemCfg[arg_6_0.itemID_].num_exchange_item[1]
		local var_6_4 = clone(ItemTemplateData)

		var_6_4.id = var_6_3[1]
		var_6_4.number = var_6_3[2]

		arg_6_0.commonItem_:SetData(var_6_4)
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
