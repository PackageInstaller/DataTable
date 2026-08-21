local var_0_0 = class("SpringFestivalBuffItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.TalentID = arg_1_2

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lockStateController = arg_2_0.controllerexcollection_:GetController("lock")
	arg_2_0.selectStateController = arg_2_0.controllerexcollection_:GetController("select")
	arg_2_0.baseStateController = arg_2_0.controllerexcollection_:GetController("base")

	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if arg_2_0.clickCallBack then
			arg_2_0.clickCallBack(arg_2_0.TalentID)
		end
	end)
end

function var_0_0.GetTalentID(arg_4_0)
	return arg_4_0.TalentID
end

function var_0_0.SetClickCallBack(arg_5_0, arg_5_1)
	arg_5_0.clickCallBack = arg_5_1
end

function var_0_0.PlayUnLockAni(arg_6_0)
	arg_6_0.ani_:Play("UI_SandPlay_3_11_ZumaTalent_UnLock")
end

function var_0_0.UpdateBaseState(arg_7_0)
	if arg_7_0.TalentID == 2002 then
		arg_7_0.baseStateController:SetSelectedState("1")
	elseif arg_7_0.TalentID == 2007 then
		arg_7_0.baseStateController:SetSelectedState("2")
	elseif arg_7_0.TalentID == 2012 then
		arg_7_0.baseStateController:SetSelectedState("3")
	end
end

function var_0_0.UpdateSelectState(arg_8_0, arg_8_1)
	arg_8_0.selectStateController:SetSelectedState(arg_8_1 and "on" or "off")
end

function var_0_0.RefreshUI(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.TalentID = arg_9_1
	end

	if arg_9_0.iconImg_ then
		local var_9_0 = ActivityZumaTalentCfg[arg_9_0.TalentID]

		arg_9_0.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/" .. var_9_0.icon)
	end

	local var_9_1 = arg_9_0:GetIsCanUse()

	arg_9_0.lockStateController:SetSelectedState(var_9_1 and "unlock" or "lock")
end

function var_0_0.GetIsCanUse(arg_10_0)
	return ZumaData:GetZumaTalentIsOpen(arg_10_0.TalentID)
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
