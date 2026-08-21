local var_0_0 = class("SectionAdditionalView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitSubViewCfg()
	arg_3_0:InitController()
	arg_3_0:InitCallback()
end

function var_0_0.InitSubViewCfg(arg_4_0)
	arg_4_0.subViewDic_ = {
		comboSkillView = {
			go = arg_4_0.comboSkillGo_,
			getClassFunc = handler(arg_4_0, arg_4_0.GetComboSkillViewClass)
		},
		mimirInfoView = {
			go = arg_4_0.mimirInfoGo_,
			getClassFunc = handler(arg_4_0, arg_4_0.GetMimirInfoViewClass)
		},
		stageInfoView = {
			go = arg_4_0.stageInfoGo_,
			getClassFunc = handler(arg_4_0, arg_4_0.GetStageInfoClass)
		},
		heroVoiceInfoView = {
			go = arg_4_0.heroVoiceInfoGo_,
			getClassFunc = handler(arg_4_0, arg_4_0.GetHeroVoiceInfoViewClass)
		}
	}
end

function var_0_0.InitController(arg_5_0)
	arg_5_0.stageInfoActiveController_ = arg_5_0.controllerExCollection_:GetController("stageInfoActive")
	arg_5_0.raceEffectController_ = arg_5_0.controllerExCollection_:GetController("raceEffect")
	arg_5_0.raceActiveController_ = arg_5_0.controllerExCollection_:GetController("raceActive")
	arg_5_0.reserveBtnController_ = arg_5_0.controllerExCollection_:GetController("reserveActive")
	arg_5_0.totalEnergyController_ = arg_5_0.controllerExCollection_:GetController("totalEnergy")
end

function var_0_0.InitCallback(arg_6_0)
	return
end

function var_0_0.SetProxy(arg_7_0, arg_7_1)
	arg_7_0.sectionProxy_ = arg_7_1
	arg_7_0.reserveParams_ = arg_7_1:GetReserveParams()

	arg_7_0:ProcessSubView()
end

function var_0_0.ProcessSubView(arg_8_0)
	arg_8_0:InitSubView()
	arg_8_0:TryReloadSubView()
	arg_8_0:ProcessSubViewParams()
end

function var_0_0.ProcessSubViewParams(arg_9_0)
	arg_9_0:SubViewCallFunc("SetProxy", arg_9_0.sectionProxy_)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:AddEventListener()
	arg_10_0:SubViewOnEnter()
end

function var_0_0.AddEventListener(arg_11_0)
	return
end

function var_0_0.SubViewOnEnter(arg_12_0)
	arg_12_0:SubViewCallFunc("OnEnter")
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
	arg_13_0:SubViewOnExit()
end

function var_0_0.SubViewOnExit(arg_14_0)
	arg_14_0:SubViewCallFunc("OnExit")
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:SubViewCallFunc("Dispose")

	for iter_15_0, iter_15_1 in pairs(arg_15_0.subViewDic_) do
		iter_15_1.go = nil
		iter_15_1.instance = nil
	end

	var_0_0.super.Dispose(arg_15_0)
end

function var_0_0.AddListener(arg_16_0)
	arg_16_0:AddBtnListener(arg_16_0.raceBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = arg_16_0.maxRaceID_,
			sameCamp = arg_16_0.sameCamp_
		})
	end)
	arg_16_0:AddBtnListener(arg_16_0.startBtn_, nil, function()
		manager.notify:Invoke(SECTION_CLICK_START_BATTLE)
	end)
	arg_16_0:AddBtnListener(arg_16_0.reservesBtn_, nil, function()
		if not arg_16_0.sectionProxy_.canChangeReserveProposal then
			return
		end

		arg_16_0:GotoReservesProposalUI()
	end)
end

function var_0_0.Refresh(arg_20_0)
	arg_20_0:RefreshSubView()
	arg_20_0:RefreshUI()
end

function var_0_0.RefreshSubView(arg_21_0)
	arg_21_0:SubViewCallFunc("Refresh")
end

function var_0_0.RefreshUI(arg_22_0)
	arg_22_0:RefresgStageInfoActive()
	arg_22_0:RefreshReservesBtn()
	arg_22_0:RefreshRace()
end

function var_0_0.RefresgStageInfoActive(arg_23_0)
	local var_23_0 = BattleStageTools.GetStageName(arg_23_0.sectionProxy_.stageType, arg_23_0.sectionProxy_.stageID)

	if not var_23_0 or var_23_0 == "" then
		arg_23_0.stageInfoActiveController_:SetSelectedState("false")
	else
		arg_23_0.stageInfoActiveController_:SetSelectedState("true")
	end
end

function var_0_0.RefreshReservesBtn(arg_24_0)
	local var_24_0 = true
	local var_24_1 = arg_24_0.sectionProxy_:GetLockStateList() or {}

	for iter_24_0 = 1, 3 do
		if var_24_1[iter_24_0] then
			var_24_0 = false
		end
	end

	if arg_24_0.sectionProxy_.canChangeTeam == false then
		var_24_0 = false
	end

	if arg_24_0.sectionProxy_.needReserveProposalPanel == true then
		arg_24_0.sectionProxy_.needReserveProposalPanel = var_24_0
		arg_24_0.sectionProxy_.canChangeReserveProposal = var_24_0
	end

	arg_24_0.reserveBtnController_:SetSelectedState(tostring(arg_24_0.sectionProxy_.needReserveProposalPanel))
end

function var_0_0.GotoReservesProposalUI(arg_25_0)
	arg_25_0.sectionProxy_:GotoReservesProposalUI()
end

function var_0_0.RefreshRace(arg_26_0)
	arg_26_0.raceActiveController_:SetSelectedState(tostring(arg_26_0.sectionProxy_.needRacePanel))

	if arg_26_0.sectionProxy_.needRacePanel then
		arg_26_0:RefreshRaceUI()
	end
end

function var_0_0.RefreshRaceUI(arg_27_0)
	local var_27_0
	local var_27_1
	local var_27_2

	if arg_27_0.sectionProxy_.forceRace == -1 then
		var_27_0, var_27_1, var_27_2 = arg_27_0:GetRaceEffect()
		arg_27_0.maxRaceID_ = var_27_0
		arg_27_0.sameCamp_ = var_27_2
	else
		var_27_0 = arg_27_0.sectionProxy_.forceRace
		var_27_1 = 0

		for iter_27_0, iter_27_1 in ipairs(arg_27_0.cacheHeroTeam_) do
			if iter_27_1 ~= 0 then
				var_27_1 = var_27_1 + 1
			end
		end
	end

	arg_27_0.maxRaceID_ = var_27_0
	arg_27_0.sameCamp_ = var_27_2

	if var_27_0 == 0 then
		arg_27_0.raceEffectController_:SetSelectedState("none")
	else
		arg_27_0.raceIcon_.sprite = HeroTools.GetRaceIcon(var_27_0)

		if var_27_1 > 1 then
			var_27_1 = var_27_1 <= 3 and var_27_1 or 3

			arg_27_0.raceEffectController_:SetSelectedState(tostring(var_27_1))
		end
	end
end

function var_0_0.GetRaceEffect(arg_28_0)
	return arg_28_0.sectionProxy_:GetRaceEffect()
end

function var_0_0.GetStageInfoClass(arg_29_0)
	return arg_29_0.sectionProxy_:GetStageInfoClass()
end

function var_0_0.GetMimirInfoViewClass(arg_30_0)
	return arg_30_0.sectionProxy_:GetMimirInfoViewClass()
end

function var_0_0.GetComboSkillViewClass(arg_31_0)
	return arg_31_0.sectionProxy_:GetComboSkillViewClass()
end

function var_0_0.GetHeroVoiceInfoViewClass(arg_32_0)
	return arg_32_0.sectionProxy_:GetHeroVoiceInfoViewClass()
end

function var_0_0.InitSubView(arg_33_0)
	if not arg_33_0.createdSubview_ then
		arg_33_0.createdSubview_ = true

		for iter_33_0, iter_33_1 in pairs(arg_33_0.subViewDic_) do
			local var_33_0 = iter_33_1.go

			iter_33_1.instance = iter_33_1.getClassFunc().New(var_33_0)

			if iter_33_1.initFunc then
				iter_33_1.initFunc()
			end
		end
	end
end

function var_0_0.TryReloadSubView(arg_34_0)
	for iter_34_0, iter_34_1 in pairs(arg_34_0.subViewDic_) do
		if SectionSelectHeroTools.IsDiffViewClass(iter_34_1.instance, iter_34_1.getClassFunc()) then
			iter_34_1.instance = SectionSelectHeroTools.ReloadView(iter_34_1.instance, iter_34_1.getClassFunc())

			if iter_34_1.initFunc then
				iter_34_1.initFunc()
			end
		end
	end
end

function var_0_0.SubViewCallFunc(arg_35_0, arg_35_1, ...)
	for iter_35_0, iter_35_1 in pairs(arg_35_0.subViewDic_) do
		local var_35_0 = iter_35_1.instance

		if var_35_0 and var_35_0[arg_35_1] then
			var_35_0[arg_35_1](var_35_0, ...)
		end
	end
end

return var_0_0
