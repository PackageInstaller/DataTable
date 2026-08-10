local var_0_0 = import("game.views.heroTeamInfo.SectionHeroTeamHeadItem")
local var_0_1 = class("MultHeartHeroTeamHeadItem", var_0_0)

function var_0_1.InitProxy(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.sectionLockTypeController_ = arg_1_0.sectionController_:GetController("sectionLockType")
	arg_1_0.sectionTeamMarkBgStyleController_ = arg_1_0.sectionController_:GetController("sectionTeamMarkBgStyle")
	arg_1_0.sectionEnergyController_ = arg_1_0.sectionController_:GetController("sectionEnergy")
	arg_1_0.sectionLockingController_ = arg_1_0.sectionController_:GetController("sectionLocking")
	arg_1_0.sectionHPController_ = arg_1_0.sectionController_:GetController("sectionHP")
	arg_1_0.multController_ = arg_1_0.sectionController_:GetController("multSelect")
end

function var_0_1.SetMultSelected(arg_2_0, arg_2_1)
	arg_2_0.multController_:SetSelectedState(arg_2_1 and "state0" or "state1")
end

function var_0_1.SetInTeamFlag(arg_3_0, arg_3_1)
	SetActive(arg_3_0.sectionTeamMarkGo_, false)

	if arg_3_0.inTeamIndex then
		SetActive(arg_3_0.labelGo_, arg_3_1)

		arg_3_0.labelTxt_.text = arg_3_0.inTeamIndex
	else
		SetActive(arg_3_0.labelGo_, false)
	end
end

function var_0_1.FindInEditTeam(arg_4_0)
	local var_4_0 = arg_4_0.sectionHeroData_.id
	local var_4_1 = arg_4_0.sectionHeroData_.trialID

	for iter_4_0, iter_4_1 in pairs(arg_4_0.multData) do
		if iter_4_1.id == var_4_0 and iter_4_1.trialID == var_4_1 then
			return iter_4_0
		end
	end
end

function var_0_1.SetSectionHeroData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.sectionHeroData_ = arg_5_1
	arg_5_0.multData = arg_5_3
	arg_5_0.isBattlePanel_ = true

	local var_5_0 = arg_5_0.sectionHeroData_.id
	local var_5_1 = arg_5_0.sectionHeroData_.type
	local var_5_2 = arg_5_0.sectionHeroData_.heroViewProxy

	arg_5_0.gameObject_.name = tostring(var_5_0)

	arg_5_0:SetProxy(var_5_2)
	arg_5_0:SetHeroId(var_5_0, var_5_1, var_5_2.tempHeroList)
	arg_5_0:SetRedPointEnable(false)
	arg_5_0:RefreshSectionUI()
	arg_5_0:UpdateMultiSelected(arg_5_2)
end

function var_0_1.UpdateMultiSelected(arg_6_0, arg_6_1)
	arg_6_0.inTeamIndex = arg_6_0:FindInEditTeam()

	arg_6_0:SetMultSelected(arg_6_0.inTeamIndex ~= nil and arg_6_1)
	arg_6_0:SetInTeamFlag(arg_6_0.inTeamIndex ~= nil)
end

return var_0_1
