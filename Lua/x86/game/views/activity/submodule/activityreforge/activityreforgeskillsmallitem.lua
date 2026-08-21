local var_0_0 = class("ActivityReforgeSkillSmallItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.emptyController_ = arg_3_0.controllerEx_:GetController("empty")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewStatus = 1,
			viewType = 2,
			activityID = arg_4_0.activityID_,
			chapterActivityID = arg_4_0.chapterActivityID_,
			levelID = arg_4_0.levelID_,
			skillID = arg_4_0.skillID_,
			slot = arg_4_0.index_
		})
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.activityID_ = arg_6_1
	arg_6_0.chapterActivityID_ = arg_6_2
	arg_6_0.levelID_ = arg_6_3
	arg_6_0.index_ = arg_6_4
	arg_6_0.skillID_ = ActivityReforgeData:GetCurUsingInitiativeSkill(arg_6_0.index_)

	if arg_6_0.skillID_ == 0 then
		arg_6_0.emptyController_:SetSelectedState("true")
	else
		arg_6_0.emptyController_:SetSelectedState("false")

		arg_6_0.icon_.sprite = getSprite("Atlas/ValhallaSkillAtlas", ActivityReforgeSkillCfg[arg_6_0.skillID_].icon)
	end
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.super.Dispose(arg_7_0)
end

return var_0_0
