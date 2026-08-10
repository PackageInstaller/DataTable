local var_0_0 = class("NewHeroHead", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:SetProxy()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.lockedController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "locked")
	arg_3_0.campController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "camp")
	arg_3_0.gradeController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "grade")
	arg_3_0.sizeController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "size")
	arg_3_0.selectedController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "selected")
	arg_3_0.hpController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "hp")
	arg_3_0.loveCon_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "love")
end

function var_0_0.SetRedPointEnable(arg_4_0, arg_4_1)
	SetActive(arg_4_0.noticePos_.gameObject, arg_4_1)
end

function var_0_0.SetProxy(arg_5_0, arg_5_1)
	arg_5_0.heroViewProxy_ = arg_5_1 or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function var_0_0.SetHeroId(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.heroDataType = arg_6_2

	if arg_6_2 == HeroConst.HERO_DATA_TYPE.TRIAL then
		arg_6_1 = arg_6_0.heroViewProxy_:GetHeroData(arg_6_1).tempID
	end

	arg_6_0:SetHeroData(arg_6_1, arg_6_2)
end

function var_0_0.SetHeroData(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 == HeroConst.HERO_DATA_TYPE.TRIAL or arg_7_2 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		arg_7_0.trialID_ = arg_7_1
		arg_7_0.heroId_ = HeroStandardSystemCfg[arg_7_1].hero_id
		arg_7_1 = arg_7_0.heroId_
	else
		arg_7_0.heroId_ = arg_7_1
		arg_7_0.trialID_ = 0
	end

	arg_7_0.heroDataType_ = arg_7_2
	arg_7_0.heroCfg_ = HeroCfg[arg_7_1]
	arg_7_0.heroInfo_ = arg_7_0.heroViewProxy_:GetHeroData(arg_7_1)

	arg_7_0:UpdateView()

	if arg_7_0.heroViewProxy_ and arg_7_0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT then
		local var_7_0 = RedPointConst.HERO_ID .. arg_7_1

		manager.redPoint:bindUIandKey(arg_7_0.noticePos_, var_7_0, {
			x = 0,
			y = 0
		})
	end

	if not arg_7_0.heroViewProxy_.showfavorBtn then
		if arg_7_0.loveCon_ then
			arg_7_0.loveCon_:SetSelectedState(HeroData:IsFavorite(arg_7_1) == false and "off" or "on")
		end
	elseif arg_7_0.loveCon_ then
		arg_7_0.loveCon_:SetSelectedState("off")
	end
end

function var_0_0.UpdateView(arg_8_0)
	local var_8_0 = arg_8_0.heroViewProxy_:GetHeroUsingSkinInfo(arg_8_0.heroId_).id

	arg_8_0.headIcon_.sprite = HeroTools.GetHeadSprite(var_8_0)

	arg_8_0.headIcon_:SetNativeSize()
	arg_8_0.campController_:SetSelectedState(arg_8_0.heroCfg_.race)

	if arg_8_0:GetHeroUnLock() then
		arg_8_0.lockedController_:SetSelectedState("false")

		if arg_8_0.heroDataType_ == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			local var_8_1 = HeroStarCfg[arg_8_0.heroInfo_.star].star

			arg_8_0.levelText_.text = tostring(arg_8_0.heroInfo_.level or 1)

			arg_8_0.gradeController_:SetSelectedState(var_8_1)
		elseif arg_8_0.heroDataType_ == HeroConst.HERO_DATA_TYPE.PREVIEW or arg_8_0.heroDataType_ == HeroConst.HERO_DATA_TYPE.DRAW then
			SetActive(arg_8_0.lvGo_, false)

			local var_8_2 = HeroStarCfg[arg_8_0.heroCfg_.unlock_star].star

			arg_8_0.gradeController_:SetSelectedState(var_8_2)
		else
			arg_8_0.levelText_.text = tostring(arg_8_0.heroInfo_.level or 1)

			local var_8_3 = HeroStarCfg[arg_8_0.heroInfo_.star].star

			arg_8_0.gradeController_:SetSelectedState(var_8_3)
		end
	else
		if not arg_8_0.heroDataType_ == HeroConst.HERO_DATA_TYPE.PREVIEW and not arg_8_0.heroDataType_ == HeroConst.HERO_DATA_TYPE.DRAW then
			local var_8_4 = arg_8_0.heroInfo_.piece
			local var_8_5 = arg_8_0.heroCfg_.rare
			local var_8_6 = GameSetting.unlock_hero_need.value[var_8_5]

			arg_8_0.pieceText_.text = string.format("%d/%d", var_8_4, var_8_6)
		else
			arg_8_0.pieceText_.text = ""
		end

		arg_8_0.lockedController_:SetSelectedState("true")

		local var_8_7 = HeroStarCfg[arg_8_0.heroCfg_.unlock_star].star

		arg_8_0.gradeController_:SetSelectedState(var_8_7)
	end

	if arg_8_0.level_ then
		arg_8_0.level_.text = GetTips("LEVEL")
	end
end

function var_0_0.GetHeroUnLock(arg_9_0)
	return arg_9_0.heroInfo_.unlock == 1
end

function var_0_0.SetUnlockDisplay(arg_10_0, arg_10_1)
	arg_10_0.lockedController_:SetSelectedState(arg_10_1 and "true" or "false")
end

function var_0_0.SetSelected(arg_11_0, arg_11_1)
	arg_11_0.selectedController_:SetSelectedState(arg_11_1 and "true" or "false")
end

function var_0_0.SetSize(arg_12_0, arg_12_1)
	arg_12_0.sizeController_:SetSelectedState(arg_12_1)
end

function var_0_0.RegisterClickListener(arg_13_0, arg_13_1)
	arg_13_0.clickListener_ = arg_13_1
end

function var_0_0.AddUIListener(arg_14_0)
	arg_14_0:AddBtnListener(arg_14_0.selfBtn_, nil, function()
		arg_14_0:ClearNewHeroRed(arg_14_0.heroCfg_.id)

		if arg_14_0.clickListener_ ~= nil then
			arg_14_0.clickListener_(arg_14_0.heroCfg_.id)
		end
	end)
end

function var_0_0.ClearNewHeroRed(arg_16_0, arg_16_1)
	if arg_16_1 and arg_16_0.heroViewProxy_ and arg_16_0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT then
		HeroTools.SetHeroNewTagRed(arg_16_1, "unlockHero", RedPointConst.HERO_ID .. arg_16_1, false)
	end
end

function var_0_0.Dispose(arg_17_0)
	manager.redPoint:unbindUIandKey(arg_17_0.noticePos_)
	arg_17_0:RemoveAllListeners()

	arg_17_0.clickListener_ = nil

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
