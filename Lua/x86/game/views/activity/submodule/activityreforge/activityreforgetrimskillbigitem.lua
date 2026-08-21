local var_0_0 = class("ActivityReforgeTrimSkillBigItem", ReduxView)

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

	arg_3_0.stateController_ = arg_3_0.controllerEx_:GetController("state")
	arg_3_0.skillStateController_ = arg_3_0.controllerEx_:GetController("skillState")
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
	arg_4_0:AddBtnListener(arg_4_0.addBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewStatus = 1,
			viewType = 2,
			activityID = arg_4_0.activityID_,
			chapterActivityID = arg_4_0.chapterActivityID_,
			levelID = arg_4_0.levelID_,
			slot = arg_4_0.index_
		})
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.activityID_ = arg_7_1
	arg_7_0.chapterActivityID_ = arg_7_2
	arg_7_0.levelID_ = arg_7_3
	arg_7_0.index_ = arg_7_4
	arg_7_0.skillID_ = ActivityReforgeData:GetCurUsingInitiativeSkill(arg_7_0.index_)

	if arg_7_0.skillID_ == 0 then
		arg_7_0.stateController_:SetSelectedState("empty")
	else
		arg_7_0.stateController_:SetSelectedState("icon")

		local var_7_0 = ActivityReforgeSkillCfg[arg_7_0.skillID_]

		arg_7_0.nameText_.text = var_7_0.name
		arg_7_0.icon_.sprite = getSprite("Atlas/ValhallaSkillAtlas", var_7_0.icon)
		arg_7_0.skillStatus_, arg_7_0.skillCanUseNum_ = ActivityReforgeData:GetSkillStatus(arg_7_0.activityID_, arg_7_0.levelID_, arg_7_0.skillID_)

		if arg_7_0.skillStatus_ == "freeUsing" or arg_7_0.skillStatus_ == "infiniteUsing" then
			arg_7_0.skillStateController_:SetSelectedState("infinite")
		else
			local var_7_1 = "useNum" .. var_7_0.count

			arg_7_0.skillStateController_:SetSelectedState(var_7_1)

			for iter_7_0 = 1, 3 do
				if iter_7_0 <= arg_7_0.skillCanUseNum_ then
					SetActive(arg_7_0["useNumGo" .. iter_7_0 .. "_"], true)
				else
					SetActive(arg_7_0["useNumGo" .. iter_7_0 .. "_"], false)
				end
			end
		end
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
