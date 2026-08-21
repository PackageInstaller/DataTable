local var_0_0 = class("CustomCenterHeroSkinItem", ReduxView)
local var_0_1 = 154
local var_0_2 = 0.85
local var_0_3 = 0.775

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.isActive = false

	arg_1_0:BindCfgUI()

	arg_1_0.roleImg_.immediate = true

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.isUnlock(arg_2_0, arg_2_1)
	return HeroTools.GetHasOwnedSkin(arg_2_1)
end

function var_0_0.isUnlockOrCanChange(arg_3_0, arg_3_1)
	return arg_3_0:isUnlock(arg_3_1) or HeroTools.CanChangeSkin(arg_3_1)
end

function var_0_0.SetActive(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)

	arg_4_0.isActive = arg_4_1
end

function var_0_0.SetOrder(arg_5_0, arg_5_1)
	arg_5_0.spriterenderer_.sortingOrder = arg_5_1
end

function var_0_0.SetDelegate(arg_6_0, arg_6_1)
	arg_6_0.delegate_ = arg_6_1
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0.selController_ = arg_7_0.controllerEx_:GetController("sel")
	arg_7_0.useController_ = arg_7_0.controllerEx_:GetController("use")
	arg_7_0.transform_.pivot = Vector2(0.5, 0.5)
	arg_7_0.itemWidth_ = arg_7_0.transform_.rect.width / 2 * (var_0_2 + var_0_3)
	arg_7_0.battleSkinController_ = arg_7_0.controllerEx_:GetController("battleSkin")
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.itemBtn_, nil, function()
		arg_8_0.delegate_(arg_8_0)
	end)
end

function var_0_0.Show(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.skinID_ = arg_10_1
	arg_10_0.index_ = arg_10_2

	arg_10_0:RefreshUI()
end

function var_0_0.PlayAni(arg_11_0, arg_11_1)
	if arg_11_0.aniTimer_ then
		arg_11_0.aniTimer_:Stop()

		arg_11_0.aniTimer_ = nil
	end

	arg_11_0.itemAni_.enabled = false
	arg_11_0.itemTrs_.localPosition = Vector3(arg_11_0.itemTrs_.localPosition.x, -562, arg_11_0.itemTrs_.localPosition.z)
	arg_11_0.aniTimer_ = Timer.New(function()
		arg_11_0.itemAni_.enabled = true

		arg_11_0.itemAni_:Play("aniSkinUI_item")
	end, arg_11_1, 1)

	arg_11_0.aniTimer_:Start()
end

function var_0_0.GetSkinID(arg_13_0)
	return arg_13_0.skinID_
end

function var_0_0.RefreshUI(arg_14_0)
	local var_14_0 = SkinCfg[arg_14_0.skinID_]

	arg_14_0.roleImg_.spriteSync = getSpritePathViaConfig("HeroIcon", var_14_0.picture_id)
	arg_14_0.nameText_.text = GetI18NText(var_14_0.name)

	local var_14_1 = false

	if not CustomCenterTools.IsRandomHero() then
		local var_14_2 = PlayerData:GetPosterGirlHeroSkinId()

		var_14_1 = arg_14_0.skinID_ == var_14_2
	else
		local var_14_3 = PlayerData:GetCacheHeroSkinList()

		var_14_1 = table.keyof(var_14_3, arg_14_0.skinID_) ~= nil
	end

	arg_14_0.useController_:SetSelectedState(tostring(var_14_1))
end

function var_0_0.ShowSelect(arg_15_0, arg_15_1)
	arg_15_0.selController_:SetSelectedState(arg_15_1 and "true" or "false")
end

function var_0_0.RefreshShow(arg_16_0)
	local var_16_0 = arg_16_0.scrollTf_.rect.width / 2
	local var_16_1 = arg_16_0.scrollTf_:InverseTransformPoint(arg_16_0.transform_:TransformPoint(Vector3.zero))
	local var_16_2 = math.abs(var_16_1.x)
	local var_16_3 = math.max(var_0_2 - (var_0_2 - var_0_3) * (var_16_2 / arg_16_0.itemWidth_), var_0_3)

	arg_16_0.transform_.localScale = Vector3.New(var_16_3, var_16_3, var_16_3)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_0.contentTf_)
end

function var_0_0.GetLocalPosition(arg_17_0)
	return arg_17_0.transform_.localPosition
end

function var_0_0.ShowBattleSkin(arg_18_0, arg_18_1)
	arg_18_0.battleSkinController_:SetSelectedState(arg_18_1 and "true" or "false")
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.aniTimer_ then
		arg_19_0.aniTimer_:Stop()

		arg_19_0.aniTimer_ = nil
	end

	var_0_0.super.Dispose(arg_19_0)
	Object.Destroy(arg_19_0.gameObject_)

	arg_19_0.gameObject_ = nil
	arg_19_0.transform_ = nil
end

return var_0_0
