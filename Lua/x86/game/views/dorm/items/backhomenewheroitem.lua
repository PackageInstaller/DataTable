local var_0_0 = class("BackHomeNewHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.fatigueController = ControllerUtil.GetController(arg_2_0.transform_, "fatigue")
	arg_2_0.jobController = ControllerUtil.GetController(arg_2_0.transform_, "state")
	arg_2_0.curPositionController = ControllerUtil.GetController(arg_2_0.transform_, "currentPosition")
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1)
	if arg_3_1 and arg_3_1 > 0 then
		arg_3_0.jobController:SetSelectedState("hero")

		if DormNpcTools:CheckIDIsNpc(arg_3_1) then
			arg_3_0:RefreshNpcInfo(arg_3_1)
		else
			arg_3_0:RefreshHeroInfo(arg_3_1)
		end
	elseif arg_3_0.showJobState then
		arg_3_0.jobController:SetSelectedState("vacancy")
	end
end

function var_0_0.RefreshNpcInfo(arg_4_0, arg_4_1)
	arg_4_0.heroID = arg_4_1
	arg_4_0.iconImg_.sprite = DormNpcTools:GetNpcHeadSprite(arg_4_1)

	if arg_4_0.showFatigue then
		arg_4_0.fatigueController:SetSelectedState("suff")
	else
		arg_4_0.fatigueController:SetSelectedState("none")
	end

	if arg_4_0.showState then
		arg_4_0.state = BackHomeNpcData:GetNpcInfoById(arg_4_1):GetHeroState()

		if arg_4_0.state == DormEnum.DormHeroState.InCanteenEntrust then
			arg_4_0.jobController:SetSelectedState("busy")
		elseif arg_4_0.state == DormEnum.DormHeroState.InCanteenJob then
			arg_4_0.jobController:SetSelectedState("restaurant")
		elseif arg_4_0.state == DormEnum.DormHeroState.InPublicDorm then
			arg_4_0.jobController:SetSelectedState("hall")
		elseif arg_4_0.state == DormEnum.DormHeroState.InPrivateDorm then
			arg_4_0.curPositionController:SetSelectedState("dorm")
		elseif arg_4_0.state == DormEnum.DormHeroState.OutDorm then
			arg_4_0.curPositionController:SetSelectedState("dorm")
		elseif arg_4_0.state == DormEnum.DormHeroState.InIdolTraineeCamp then
			arg_4_0.jobController:SetSelectedState("train")
		end
	else
		arg_4_0.curPositionController:SetSelectedState("no")
	end
end

function var_0_0.RefreshHeroInfo(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.heroID = arg_5_1
	arg_5_0.archiveID = DormData:GetHeroArchiveID(arg_5_1)
	arg_5_0.iconImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_5_1)

	local var_5_0 = DormData:GetHeroTemplateInfo(arg_5_0.heroID)

	if arg_5_0.showFatigue then
		local var_5_1 = var_5_0:GetFatigue()
		local var_5_2 = GameDisplayCfg.dorm_hero_fatigue_level.value

		if var_5_0:GetFatigue() <= var_5_2[1] then
			arg_5_0.fatigueController:SetSelectedState("low")
		elseif var_5_0:GetFatigue() > var_5_2[1] and var_5_0:GetFatigue() <= var_5_2[2] then
			arg_5_0.fatigueController:SetSelectedState("middle")
		else
			arg_5_0.fatigueController:SetSelectedState("suff")
		end
	else
		arg_5_0.fatigueController:SetSelectedState("none")
	end

	if arg_5_0.showState then
		arg_5_0.state = var_5_0:GetHeroState()

		if arg_5_0.state == DormEnum.DormHeroState.InCanteenEntrust then
			arg_5_0.jobController:SetSelectedState("busy")
		elseif arg_5_0.state == DormEnum.DormHeroState.InCanteenJob then
			arg_5_0.jobController:SetSelectedState("restaurant")
		elseif arg_5_0.state == DormEnum.DormHeroState.InPublicDorm then
			arg_5_0.jobController:SetSelectedState("hall")
		elseif arg_5_0.state == DormEnum.DormHeroState.InPrivateDorm then
			arg_5_0.curPositionController:SetSelectedState("dorm")
		elseif arg_5_0.state == DormEnum.DormHeroState.OutDorm then
			arg_5_0.curPositionController:SetSelectedState("dorm")
		elseif arg_5_0.state == DormEnum.DormHeroState.InIdolTraineeCamp then
			arg_5_0.jobController:SetSelectedState("train")
		end
	else
		arg_5_0.curPositionController:SetSelectedState("no")
	end
end

function var_0_0.SetItemFunction(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.showState = arg_6_1.showState
		arg_6_0.showFatigue = arg_6_1.showFatigue
		arg_6_0.showJobState = arg_6_1.showJobState
	end
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
