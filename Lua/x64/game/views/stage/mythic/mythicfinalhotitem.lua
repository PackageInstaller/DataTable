local var_0_0 = class("MythicFinalHotItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "statu")

	arg_1_0:AddListeners()
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if MythicData:GetLevelIsOpen(arg_2_0.levelid_) then
			manager.net:SendWithLoadingNew(44024, {
				difficulty_id = arg_2_0.levelid_
			}, 44025, function(arg_4_0, arg_4_1)
				if isSuccess(arg_4_0.result) then
					MythicData:SetCurHotLevelId(arg_4_1.difficulty_id)
					manager.notify:Invoke(MYTHIC_FINAL_HOTITEM_CLICK, arg_2_0.selffilterid_)
				else
					ShowTips(arg_4_0.result)
				end
			end)
		end
	end)
end

function var_0_0.SetSpectID(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.levelid_ = arg_5_1
	arg_5_0.leveltext_.text = arg_5_0.levelid_
	arg_5_0.selffilterid_ = arg_5_2

	if MythicData:GetLevelIsOpen(arg_5_0.levelid_) then
		if MythicData:GetHotLevelIsPass(arg_5_0.levelid_) then
			arg_5_0.controller_:SetSelectedState("finsh")
		else
			arg_5_0.controller_:SetSelectedState("on")
		end
	else
		arg_5_0.controller_:SetSelectedState("lock")
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
