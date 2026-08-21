local var_0_0 = class("ChallengeRogueTeamTreasureItem", ReduxView)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/System/Activity_Roulike/item/SelectPopItem"
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.gameObject_ = Object.Instantiate(Asset.Load(arg_2_0:GetUIName()), arg_2_1.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform
	arg_2_0.index_ = arg_2_2

	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.commonItem_ = ChallengeRogueTeamCommonItemView.New(arg_2_0.gameObject_)
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	local var_3_0 = clone(ChallengeRogueTeamCommonItemData)

	var_3_0.id = arg_3_1.id
	var_3_0.rare = arg_3_1.rare
	var_3_0.selectFlag = false
	var_3_0.descRaycastFlag = arg_3_1.descRaycastFlag or false
	var_3_0.ownFlag = arg_3_1.isNew
	var_3_0.needShowCampFlag = arg_3_1.needShowCampFlag or false

	function var_3_0.clickFun()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SELECTED_TREASURE, arg_3_0.index_)
	end

	arg_3_0.commonItem_:SetData(var_3_0)
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.commonItem_:Dispose()

	arg_6_0.commonItem_ = nil

	var_0_0.super.Dispose(arg_6_0)
	Object.Destroy(arg_6_0.gameObject_)

	arg_6_0.transform_ = nil
	arg_6_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	return
end

function var_0_0.SelectTreasure(arg_8_0, arg_8_1)
	if arg_8_0.index_ == arg_8_1 then
		arg_8_0.commonItem_:RefreshSelectState(true)
		arg_8_0.commonItem_:RefreshDescTextRaycast(true)
	else
		arg_8_0.commonItem_:RefreshSelectState(false)
		arg_8_0.commonItem_:RefreshDescTextRaycast(false)
	end
end

function var_0_0.PlayAnimator(arg_9_0)
	arg_9_0.commonItem_:PlayAnimator()
end

return var_0_0
