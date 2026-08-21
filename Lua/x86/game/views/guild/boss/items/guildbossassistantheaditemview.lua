local var_0_0 = class("GuildBossAssistantHeadItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.lockedController_ = ControllerUtil.GetController(arg_3_0.headGo_.transform, "locked")
	arg_3_0.campController_ = ControllerUtil.GetController(arg_3_0.headGo_.transform, "camp")
	arg_3_0.gradeController_ = ControllerUtil.GetController(arg_3_0.headGo_.transform, "grade")
	arg_3_0.sizeController_ = ControllerUtil.GetController(arg_3_0.headGo_.transform, "size")
	arg_3_0.hpController_ = ControllerUtil.GetController(arg_3_0.headGo_.transform, "hp")
	arg_3_0.selectedController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "selected")
	arg_3_0.positionController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "position")
	arg_3_0.loveCon_ = ControllerUtil.GetController(arg_3_0.headGo_.transform, "love")

	ComponentBinder.GetInstance():BindCfgUI(arg_3_0, arg_3_0.headGo_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.selfBtn_, nil, function()
		if arg_4_0.clickListener_ ~= nil then
			arg_4_0.clickListener_()
		end
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.data_ = arg_7_1
	arg_7_0.heroCfg_ = HeroCfg[arg_7_0.data_.assist_hero_id]

	arg_7_0:UpdateView()
end

function var_0_0.SetTeamMark(arg_8_0, arg_8_1, arg_8_2)
	SetActive(arg_8_0.teamMark_, arg_8_1)

	if arg_8_1 then
		arg_8_0.teamMarkText_.text = GetI18NText(arg_8_2)
	end
end

function var_0_0.GetHeroId(arg_9_0)
	return arg_9_0.data_.assist_hero_id
end

function var_0_0.GetOwnerId(arg_10_0)
	return arg_10_0.data_.member_id
end

function var_0_0.UpdateView(arg_11_0)
	local var_11_0 = arg_11_0.data_.assist_hero_skin

	if var_11_0 == 0 then
		var_11_0 = arg_11_0.data_.assist_hero_id
	end

	arg_11_0.nickLabel_.text = GetI18NText(arg_11_0.data_.nick)
	arg_11_0.headIcon_.sprite = HeroTools.GetHeadSprite(var_11_0)

	arg_11_0.headIcon_:SetNativeSize()
	arg_11_0.campController_:SetSelectedState(arg_11_0.heroCfg_.race)

	local var_11_1 = HeroStarCfg[arg_11_0.data_.hero_rare].star

	arg_11_0.gradeController_:SetSelectedState(var_11_1)

	arg_11_0.levelText_.text = arg_11_0.data_.hero_level
	arg_11_0.fightPowerLabel_.text = arg_11_0.data_.fight_capacity

	arg_11_0.positionController_:SetSelectedState(tostring(arg_11_0.data_.member_post))
	arg_11_0.loveCon_:SetSelectedState("off")

	if tostring(arg_11_0.data_.member_post) == "1" then
		arg_11_0.clubMemberLabel_.text = GetTips("CLUB_CHAIR_MAN")
	elseif tostring(arg_11_0.data_.member_post) == "2" then
		arg_11_0.clubMemberLabel_.text = GetTips("CLUB_VICE_CHAIR_MAN")
	elseif tostring(arg_11_0.data_.member_post) == "3" then
		arg_11_0.clubMemberLabel_.text = GetTips("CLUB_MEMBER")
	elseif tostring(arg_11_0.data_.member_post) == "4" then
		arg_11_0.clubMemberLabel_.text = GetTips("CLUB_NOVICIATE")
	end
end

function var_0_0.RegisterClickListener(arg_12_0, arg_12_1)
	arg_12_0.clickListener_ = arg_12_1
end

function var_0_0.SetSelected(arg_13_0, arg_13_1)
	arg_13_0.selectedController_:SetSelectedState(arg_13_1 and "true" or "false")
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:AddEventListeners()
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_16_0)
	return
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.data_ = nil
	arg_17_0.clickListener_ = nil

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
