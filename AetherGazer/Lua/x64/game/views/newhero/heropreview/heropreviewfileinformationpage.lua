local var_0_0 = class("HeroPreviewFileInformationPage", HeroFileInformationPage)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()
	arg_1_0:AddBtnListeners()

	arg_1_0.curHeroID_ = 0
	arg_1_0.curRecordID_ = 0
	arg_1_0.relationNetController_ = arg_1_0.rightControllerEx_:GetController("relationNet")
	arg_1_0.lockController_ = arg_1_0.controller_:GetController("lock")
	arg_1_0.recommendController_ = arg_1_0.controller_:GetController("recommend")
	arg_1_0.items = {}
end

function var_0_0.AddBtnListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.portraitBtn_, nil, function()
		arg_2_0:Go("heroPortrait", {
			heroID = arg_2_0.curHeroID_
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.poltBtn_, nil, function()
		if ObtainHeroMovieCfg[arg_2_0.curHeroID_] then
			arg_2_0:Go("/heroMovieReplay", {
				heroID = arg_2_0.curHeroID_
			})
			OperationRecorder.RecordButtonTouch("video_play_recruit_illustration" .. arg_2_0.curHeroID_)
		end
	end)
	arg_2_0:AddBtnListener(arg_2_0.recommendBtn_, nil, function()
		arg_2_0.recommendController_:SetSelectedState("true")
	end)
	arg_2_0:AddBtnListener(arg_2_0.bgmask_, nil, function()
		arg_2_0.recommendController_:SetSelectedState("false")
	end)
	arg_2_0:AddBtnListener(arg_2_0.cooperationBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("video_play_comboskill_illustration")
		DestroyLua()

		HeroCooperationBridge.heroId = arg_2_0.curHeroID_
		HeroCooperationBridge.entrance = ViewConst.SYSTEM_ID.ILLUSTRATION

		CooperateSkillBridge.Launcher()
	end)
end

function var_0_0.Show(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 ~= arg_8_0.curHeroID_ then
		local var_8_0 = HeroCfg[arg_8_2]

		arg_8_0.heroCfg_ = var_8_0
		arg_8_0.lableText_.text = GetI18NText(var_8_0.name)
		arg_8_0.summaryText_.text = GetI18NText(var_8_0.hero_desc)
		arg_8_0.campImg_.sprite = HeroTools.GetRaceIcon(var_8_0.race)
		arg_8_0.attackTypeImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_8_0.heroCfg_.id)

		arg_8_0:RefreshChargeType()

		arg_8_0.rareImg_.sprite = getSprite("Atlas/Common", "star_" .. var_8_0.rare)
		arg_8_0.rangeTypeText_.text = CharactorParamCfg[arg_8_0.heroCfg_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
		arg_8_0.lockSummaryText_.text = GetI18NText(var_8_0.hero_desc)
		arg_8_0.curHeroID_ = arg_8_2
	end

	if arg_8_1 ~= arg_8_0.curRecordID_ then
		local var_8_1 = HeroRecordCfg[arg_8_1]

		arg_8_0.nameText_.text = GetI18NText(var_8_1.name)
		arg_8_0.heightText_.text = GetI18NText(var_8_1.height)
		arg_8_0.weightText_.text = GetI18NText(var_8_1.weight)
		arg_8_0.birthdayText_.text = GetI18NText(var_8_1.birthday)
		arg_8_0.organizationText_.text = GetI18NText(var_8_1.organization)
		arg_8_0.hobbyText_.text = GetI18NText(var_8_1.like)
		arg_8_0.curRecordID_ = arg_8_1
	end

	arg_8_0.lockController_:SetSelectedState("false")
	SetActive(arg_8_0.portraitBtn_.gameObject, HeroData:GetHeroData(arg_8_2).unlock == 1)

	if HeroData:GetHeroData(arg_8_2).unlock == 1 then
		arg_8_0.plotTxt_.text = GetTips("PULL_ANIMATION_REPLAY")
	else
		arg_8_0.plotTxt_.text = GetTips("PULL_ANIMATION_PREVIEW")
	end

	arg_8_0.scroll_.enabled = false
	arg_8_0.scroll_.enabled = true

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.summaryContent_)
	arg_8_0.relationNetController_:SetSelectedState("lock")
	SetActive(arg_8_0.poltBtn_.gameObject, ObtainHeroMovieCfg[arg_8_0.curHeroID_] ~= nil)
	SetActive(arg_8_0.gameObject_, true)
	arg_8_0:RefreshRecommend(arg_8_3)
	arg_8_0:RefreshCooperationBtn()
	arg_8_0:UpdateAdult()
end

function var_0_0.UpdateAdult(arg_9_0)
	SetActive(arg_9_0.adultMarkGo_, HeroTools.IsNeedDisplayAdult(arg_9_0.curHeroID_))
end

function var_0_0.RefreshRecommend(arg_10_0, arg_10_1)
	arg_10_0.recommendController_:SetSelectedState("false")

	local var_10_0 = HeroCfg[arg_10_0.curHeroID_].recommend_team

	if var_10_0 and #var_10_0 > 0 and arg_10_1 then
		SetActive(arg_10_0.recommendBtn_.gameObject, true)

		for iter_10_0 = 1, #var_10_0 do
			if not arg_10_0.items[iter_10_0] then
				local var_10_1 = Object.Instantiate(arg_10_0.boxGo_, arg_10_0.boxParent_)

				arg_10_0.items[iter_10_0] = HeroPreviewReCommendItem.New(var_10_1)
			end

			arg_10_0.items[iter_10_0]:RefreshData(var_10_0[iter_10_0], arg_10_0.curHeroID_)
		end

		for iter_10_1 = #var_10_0 + 1, #arg_10_0.items do
			arg_10_0.items[iter_10_1]:Show(false)
		end
	else
		SetActive(arg_10_0.recommendBtn_.gameObject, false)
	end
end

function var_0_0.UpdateView(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	var_0_0.super.UpdateView(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.relationNetController_:SetSelectedState("lock")
	arg_11_0:RefreshRecommend(arg_11_3)
end

function var_0_0.RefreshChargeType(arg_12_0)
	arg_12_0.chargeTypeText_.text = HeroTools.GetChargeTextByType(arg_12_0.heroCfg_.mechanism_type[1])
end

function var_0_0.RefreshCooperationBtn(arg_13_0)
	local var_13_0 = ComboSkillTools.GetHeroComboSkill(arg_13_0.curHeroID_)

	if var_13_0 and #var_13_0 > 0 then
		SetActive(arg_13_0.cooperationBtn_.gameObject, true)
	else
		SetActive(arg_13_0.cooperationBtn_.gameObject, false)
	end
end

function var_0_0.CameraEnter(arg_14_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		1
	}, arg_14_0.displayGo_)
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.items then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0.items) do
			iter_15_1:Dispose()
		end

		arg_15_0.items = nil
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
