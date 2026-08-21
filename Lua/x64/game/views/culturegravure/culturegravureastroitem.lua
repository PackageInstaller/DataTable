local var_0_0 = class("CultureGravureAstroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.btnController_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "state")
	arg_2_0.astroItems = {}

	for iter_2_0 = 1, 3 do
		arg_2_0.astroItems[iter_2_0] = CultureGravureRecommendAstroItem.New(arg_2_0["astro_" .. iter_2_0])
	end
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.data_ = arg_3_2
	arg_3_0.rate_ = arg_3_2.rate
	arg_3_0.heroID_ = arg_3_3
	arg_3_0.astroDataList_ = arg_3_2.list

	arg_3_0:RefreshUI()
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.getBtn_, nil, function()
		local var_5_0, var_5_1 = CultureGravureData:GetHasUnlockAllAstro(arg_4_0.heroID_, arg_4_0.astroDataList_)
		local var_5_2 = HeroAstrolabeCfg[var_5_1]
		local var_5_3 = table.indexof(HeroCfg[arg_4_0.heroID_].astrolabe, var_5_2.hero_astrolabe_suit_id)
		local var_5_4 = var_5_2.pos
		local var_5_5 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_ASTROLABE)

		if not var_5_5 then
			JumpTools.OpenPageByJump("/astrolabeAdjust", {
				isEnter = true,
				heroId = arg_4_0.heroID_,
				selectPos = {
					var_5_3,
					var_5_4
				}
			})
		else
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.HERO_ASTROLABE, var_5_5))
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.equipBtn_, nil, function()
		AstrolabeAction.AstrolabeEquipByList(arg_4_0.heroID_, arg_4_0.astroDataList_)
	end)
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()
end

function var_0_0.SetClickCallBack(arg_8_0, arg_8_1)
	arg_8_0.callback = arg_8_1
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.rateText_.text = math.floor(arg_9_0.rate_ / 100)

	arg_9_0:RefreshAstroItem()
	arg_9_0:RefreshState()
end

function var_0_0.RefreshAstroItem(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.astroItems) do
		iter_10_1:SetData(iter_10_0, arg_10_0.astroDataList_[iter_10_0], arg_10_0.heroID_)
		iter_10_1:SetClickCallBack(arg_10_0.callback, arg_10_0.rightTrans_)
	end
end

function var_0_0.RefreshState(arg_11_0)
	local var_11_0 = CultureGravureData:GetHasEquippedAllAstro(arg_11_0.heroID_, arg_11_0.astroDataList_)
	local var_11_1 = CultureGravureData:GetHasUnlockAllAstro(arg_11_0.heroID_, arg_11_0.astroDataList_)

	if var_11_0 then
		arg_11_0.btnController_:SetSelectedState("equip")
	elseif var_11_1 then
		arg_11_0.btnController_:SetSelectedState("had")
	else
		arg_11_0.btnController_:SetSelectedState("get")
	end
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.astroItems) do
		iter_12_1:Dispose()
	end

	arg_12_0.astroItems = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
