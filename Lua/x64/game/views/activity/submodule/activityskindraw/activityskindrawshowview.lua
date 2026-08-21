local var_0_0 = class("ActivitySkinDrawShowView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddBtnListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.typeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
end

function var_0_0.AddBtnListeners(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	SetActive(arg_6_0.gameObject_, true)
	arg_6_0:DestroySticker()

	local var_6_0 = ActivityLimitedDrawPoolCfg[arg_6_1]
	local var_6_1 = var_6_0.reward[1][1]
	local var_6_2 = ItemCfg[var_6_1]

	if ActivitySkinDrawTools.GetIsSkinGift(var_6_1) then
		var_6_1 = var_6_2.param[1][1]
		var_6_2 = ItemCfg[var_6_1]
	end

	local var_6_3 = var_6_0.reward[1][2]

	if var_6_2.type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
		local var_6_4 = var_6_2.param[1]
		local var_6_5 = ChatStickerCfg[var_6_4]

		arg_6_0.dynamicStickerGo_ = Object.Instantiate(Asset.Load(var_6_5.icon), arg_6_0.dynamicTf_)

		arg_6_0.typeCon_:SetSelectedState("dynamic")
	elseif var_6_2.type == ItemConst.ITEM_TYPE.HERO_SKIN then
		arg_6_0.role_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. var_6_1)

		arg_6_0.typeCon_:SetSelectedState("skin")
	else
		arg_6_0.icon_.sprite = ItemTools.getItemSprite(var_6_1)

		arg_6_0.typeCon_:SetSelectedState("icon")
		arg_6_0.icon_:SetNativeSize()
	end

	arg_6_0.name_.text = ItemTools.getItemName(var_6_1) .. "×" .. var_6_3

	arg_6_0.playable_:Evaluate()

	arg_6_0.playable_.time = 0

	arg_6_0.playable_:Play()
end

function var_0_0.DestroySticker(arg_7_0)
	if arg_7_0.dynamicStickerGo_ then
		Object.Destroy(arg_7_0.dynamicStickerGo_)

		arg_7_0.dynamicStickerGo_ = nil
	end
end

function var_0_0.Hide(arg_8_0)
	SetActive(arg_8_0.gameObject_, false)
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	arg_10_0:DestroySticker()
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
