local var_0_0 = class("ActivityReforgeSkillItem", ReduxView)

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

	arg_3_0.skillUseStateController_ = arg_3_0.controllerEx_:GetController("skillUseState")
	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("select")
	arg_3_0.skillStatusController_ = arg_3_0.controllerEx_:GetController("skillStatus")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0 = RedPointConst.ACTIVITY_REFORGE_SKILL .. arg_4_0.skillID_

		manager.redPoint:setTip(var_5_0, 0)

		if arg_4_0.clickHandle_ then
			arg_4_0.clickHandle_(arg_4_0.skillID_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	arg_6_0.viewType_ = arg_6_1
	arg_6_0.skillID_ = arg_6_2

	local var_6_0 = ActivityReforgeSkillCfg[arg_6_0.skillID_]

	arg_6_0.clickHandle_ = arg_6_3
	arg_6_0.activityID_ = arg_6_4
	arg_6_0.levelID_ = arg_6_5
	arg_6_0.curSkillID_ = arg_6_6

	if arg_6_0.skillID_ == arg_6_0.curSkillID_ then
		arg_6_0.selectController_:SetSelectedState("true")
	else
		arg_6_0.selectController_:SetSelectedState("false")
	end

	arg_6_0.iconImage_.sprite = getSprite("Atlas/ValhallaSkillAtlas", var_6_0.icon)
	arg_6_0.skillNameText_.text = var_6_0.name

	if arg_6_0.viewType_ == 1 then
		if ActivityReforgeData:GetSkillIsLock(arg_6_0.activityID_, arg_6_0.skillID_) then
			arg_6_0.skillUseStateController_:SetSelectedState("illustratedLock")
		elseif var_6_0.count == -1 then
			arg_6_0.skillUseStateController_:SetSelectedState("freeNormal")
		else
			arg_6_0.skillUseStateController_:SetSelectedState("normal")

			local var_6_1 = "useNum" .. var_6_0.count

			arg_6_0.skillStatusController_:SetSelectedState(var_6_1)

			for iter_6_0 = 1, 3 do
				SetActive(arg_6_0["useNumGo" .. iter_6_0 .. "_"], true)
			end
		end
	else
		arg_6_0.skillStatus_, arg_6_0.skillCanUseNum_ = ActivityReforgeData:GetSkillStatus(arg_6_0.activityID_, arg_6_0.levelID_, arg_6_0.skillID_)

		arg_6_0.skillUseStateController_:SetSelectedState(arg_6_0.skillStatus_)

		if arg_6_0.skillStatus_ == "using" or arg_6_0.skillStatus_ == "normal" or arg_6_0.skillStatus_ == "lock" or arg_6_0.skillStatus_ == "haveNot" or arg_6_0.skillStatus_ == "ban" then
			local var_6_2 = "useNum" .. var_6_0.count

			arg_6_0.skillStatusController_:SetSelectedState(var_6_2)

			if arg_6_0.skillStatus_ == "using" or arg_6_0.skillStatus_ == "normal" then
				for iter_6_1 = 1, 3 do
					if iter_6_1 <= arg_6_0.skillCanUseNum_ then
						SetActive(arg_6_0["useNumGo" .. iter_6_1 .. "_"], true)
					else
						SetActive(arg_6_0["useNumGo" .. iter_6_1 .. "_"], false)
					end
				end
			else
				for iter_6_2 = 1, 3 do
					SetActive(arg_6_0["useNumGo" .. iter_6_2 .. "_"], false)
				end
			end
		end
	end

	local var_6_3 = RedPointConst.ACTIVITY_REFORGE_SKILL .. arg_6_0.skillID_

	manager.redPoint:bindUIandKey(arg_6_0.transform_, var_6_3)
end

function var_0_0.OnExit(arg_7_0)
	local var_7_0 = RedPointConst.ACTIVITY_REFORGE_SKILL .. arg_7_0.skillID_

	manager.redPoint:unbindUIandKey(arg_7_0.transform_, var_7_0)
end

function var_0_0.SetIsActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.clickHandle_ = nil

	Object.Destroy(arg_9_0.gameObject_)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
