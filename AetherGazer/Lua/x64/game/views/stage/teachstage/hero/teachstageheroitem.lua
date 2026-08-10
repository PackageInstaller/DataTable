local var_0_0 = class("TeachStageHeroItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.icon_.immediate = true
	arg_2_0.indexcontroller_ = ControllerUtil.GetController(arg_2_0.transform_, "index")
	arg_2_0.selectcontroller_ = ControllerUtil.GetController(arg_2_0.transform_, "select")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if HeroData:GetHeroData(arg_3_0.heroID_).unlock ~= 1 then
			ShowTips("ERROR_HERO_NOT_UNLOCK")

			return
		end

		arg_3_0.selectCallBack_(arg_3_0.index_)
		BattleTeachData:SetCacheTeachHeroID(arg_3_0.heroID_)
		arg_3_0:Go("teachSectionInfo", {
			section = HeroCfg[arg_3_0.heroID_].study_stage[1],
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING
		})
	end)
end

function var_0_0.RefreshSelect(arg_5_0, arg_5_1)
	arg_5_0.selectcontroller_:SetSelectedState(arg_5_1 == arg_5_0.index_ and "true" or "false")
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.selectCallBack_ = nil
end

function var_0_0.IsOpenSectionInfo(arg_7_0)
	return arg_7_0:IsOpenRoute("teachSectionInfo")
end

function var_0_0.SetHeroID(arg_8_0, arg_8_1)
	if arg_8_0.heroID_ ~= arg_8_1 then
		arg_8_0.heroID_ = arg_8_1
		arg_8_0.icon_.spriteSync = getSpritePathViaConfig("HeroIcon", SkinCfg[arg_8_1].picture_id)
	end

	local var_8_0 = HeroData:GetHeroData(arg_8_1)

	SetActive(arg_8_0.lockGo_, var_8_0.unlock ~= 1)
	SetActive(arg_8_0.greyMask_, var_8_0.unlock ~= 1)

	arg_8_0.nameText_.text = GetI18NText(HeroCfg[arg_8_1].name)

	local var_8_1 = HeroCfg[arg_8_0.heroID_].study_stage[1]

	SetActive(arg_8_0.clearGo_, BattleTeachData:GetHeroTeachInfo(arg_8_0.heroID_, var_8_1) > 0)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.index_ = arg_9_1

	arg_9_0.indexcontroller_:SetSelectedState(arg_9_1 % 3)

	if not arg_9_3 then
		arg_9_0.selectcontroller_:SetSelectedState(arg_9_2 == arg_9_0.index_ and "true" or "false")
	end
end

function var_0_0.SetSelectCallBack(arg_10_0, arg_10_1)
	arg_10_0.selectCallBack_ = arg_10_1
end

return var_0_0
