local var_0_0 = class("SelectOpponentListItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.commonPortrait_ = CommonHeadPortrait.New(arg_2_0.headItem_)

	arg_2_0:AddUIListener()
	arg_2_0:InitAbilityItem()

	arg_2_0.typeController_ = arg_2_0.mainControllerEx_:GetController("strenthTier")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.challengeBtn_, nil, function()
		local var_4_0 = IdolTraineeData:GetCurPVPStage()

		if arg_3_0.curUserID_ and arg_3_0.friendType and var_4_0 then
			BackHomeCricketAction:AskPvPBattleData(arg_3_0.curUserID_, var_4_0)
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.compareBtn_, nil, function()
		JumpTools.OpenPageByJump("idolTraineeBattleComparePop", {
			userID = arg_3_0.curUserID_,
			friendType = arg_3_0.friendType
		})
	end)
	arg_3_0.commonPortrait_:RegisteClickCallback(function()
		if arg_3_0.curUserID_ then
			ForeignInfoAction:TryToCheckForeignDetailInfo(arg_3_0.curUserID_, true)
		end
	end)
end

function var_0_0.InitAbilityItem(arg_7_0)
	arg_7_0.abilityList = {}

	for iter_7_0 = 1, IdolTraineeConst.AbilityNum do
		arg_7_0.abilityList[iter_7_0] = IdolTraineeAbilityItem.New(arg_7_0["propitem" .. iter_7_0 .. "Go_"])
	end
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.curUserID_ = arg_8_1
	arg_8_0.friendType = arg_8_2

	local var_8_0 = IdolTraineeTools:GetOpponentData(arg_8_1, arg_8_2)

	arg_8_0.playerName_.text = GetI18NText(var_8_0.nick)

	arg_8_0.commonPortrait_:RenderHead(var_8_0.icon)
	arg_8_0.commonPortrait_:RenderFrame(var_8_0.icon_frame)

	arg_8_0.heroIcon_.sprite = IdolTraineeTools.GetBackHomeHeadSprite(var_8_0.skin_id)
	arg_8_0.raceIcon_.sprite = HeroTools.GetHeroRaceIcon(var_8_0.hero_id)

	local var_8_1 = 0

	for iter_8_0 = 1, IdolTraineeConst.AbilityNum do
		arg_8_0.abilityList[iter_8_0]:SetData(var_8_0.property[iter_8_0])

		var_8_1 = var_8_1 + var_8_0.property[iter_8_0]
	end

	local var_8_2 = IdolTraineeData:GetCurAttackHeroInfo()
	local var_8_3 = 0

	for iter_8_1, iter_8_2 in pairs(var_8_2) do
		for iter_8_3 = 1, IdolTraineeConst.AbilityNum do
			var_8_3 = var_8_3 + iter_8_2[iter_8_3]
		end
	end

	if var_8_1 / var_8_3 < 0.8 then
		arg_8_0.typeController_:SetSelectedState("strong")
	elseif var_8_1 / var_8_3 > 1.1 then
		arg_8_0.typeController_:SetSelectedState("weak")
	else
		arg_8_0.typeController_:SetSelectedState("middle")
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.commonPortrait_:Dispose()

	if arg_9_0.abilityList then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.abilityList) do
			iter_9_1:Dispose(arg_9_0)
		end
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
