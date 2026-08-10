local var_0_0 = class("ObtainSkinView", ObtainBaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	var_0_0.super.Init(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.dlcImg_.immediate = true
	arg_3_0.portrait_.immediate = true
	arg_3_0.AdaptImg_ = arg_3_0:FindCom("AdaptImage", nil, arg_3_0.portrait_.transform)
end

function var_0_0.SetInfo(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = SkinCfg[arg_4_1] or SkinCfg[ItemCfg[arg_4_1].param[1]]

	arg_4_0.obtainsParams_ = arg_4_2

	local var_4_1 = ShopTools.GetGoodsIdBySkinId(arg_4_1)

	if HeroTools.GetHasOwnedSkin(var_4_0.id) then
		arg_4_0.limitTimeText_.text = GetTips("ALREADY_GET")
	elseif ItemCfg[arg_4_1].time then
		arg_4_0.limitTimeText_.text = string.format(GetTips("SKIN_LIMIT_TIME"), ItemCfg[arg_4_1].time[2][1])
	end

	SetActive(arg_4_0.limitTimeGo_, ItemCfg[arg_4_1].time ~= nil)
	SetActive(arg_4_0.dlcGo_, arg_4_0.obtainsParams_.HasDlc)

	if arg_4_0.obtainsParams_.HasDlc then
		local var_4_2
		local var_4_3 = HomeSceneSettingCfg[arg_4_0.obtainsParams_.dlcCfg.param[1]]
		local var_4_4 = HomeSceneSettingData:GetUsedState(var_4_3.id) == SceneConst.HOME_SCENE_TYPE.UNLOCK

		if var_4_4 then
			arg_4_0.leftTimeText_.text = GetTips("ALREADY_GET")
		elseif arg_4_0.obtainsParams_.dlcCfg.time then
			var_4_2 = string.format(GetTips("SKIN_LIMIT_TIME"), arg_4_0.obtainsParams_.dlcCfg.time[2][1])
			arg_4_0.leftTimeText_.text = var_4_2
		end

		arg_4_0.dlcNameText_.text = GetI18NText(arg_4_0.obtainsParams_.dlcCfg.name)
		arg_4_0.dlcImg_.spriteSync = "TextureConfig/Item_l/" .. var_4_3.id

		SetActive(arg_4_0.leftTimeText_.gameObject, var_4_2 ~= nil)
		SetActive(arg_4_0.get1content_, var_4_2 ~= nil)
		SetActive(arg_4_0.dlcGo_, not var_4_4)
	end

	if not var_4_0 then
		return
	end

	local var_4_5 = HeroCfg[var_4_0.hero]

	arg_4_0.portrait_.spriteSync = "TextureConfig/Character/Portrait/" .. var_4_0.id
	arg_4_0.heroNameTxt_.text = HeroTools.GetHeroFullName(var_4_0.hero)

	arg_4_0.AdaptImg_:AdaptImg()

	arg_4_0.name_.text = GetI18NText(var_4_0.name)

	if var_4_1 then
		local var_4_6 = getShopCfg(var_4_1)

		if var_4_6.give_back_list and #var_4_6.give_back_list > 0 and arg_4_0.obtainsParams_.isBuy then
			SetActive(arg_4_0.itemGo_, true)
		else
			SetActive(arg_4_0.itemGo_, false)

			return
		end

		arg_4_0.itemNameTxt_.text = ItemTools.getItemName(var_4_6.give_back_list[1].id) .. "x" .. var_4_6.give_back_list[1].num
		arg_4_0.itemIcon_.sprite = ItemTools.getItemSprite(var_4_6.give_back_list[1].id)
	else
		SetActive(arg_4_0.itemGo_, false)
	end
end

function var_0_0.GetTimeLineEndTime(arg_5_0)
	return 6.27
end

function var_0_0.Hide(arg_6_0)
	var_0_0.super.Hide(arg_6_0)

	arg_6_0.portrait_.sprite = nil
end

return var_0_0
