local var_0_0 = class("RandomSceneItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.icon_.immediate = true
	arg_3_0.typeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
	arg_3_0.selectCon_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickFunc_ then
			arg_4_0.clickFunc_()
		end
	end)
end

function var_0_0.RefreshData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.id_ = arg_6_1
	arg_6_0.cfg_ = HomeSceneSettingCfg[arg_6_0.id_]
	arg_6_0.title_.text = arg_6_0.cfg_.title
	arg_6_0.source_.text = arg_6_0.cfg_.obtain_word
	arg_6_0.icon_.spriteSync = "TextureConfig/SceneChangeUI/item/" .. arg_6_0.id_

	arg_6_0:RefreshType(arg_6_2, arg_6_3)
end

function var_0_0.RefreshType(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.selectCon_:SetSelectedState(arg_7_2 and "true" or "false")

	local var_7_0 = HomeSceneSettingData:GetCurScene()

	if arg_7_1 == 0 then
		if #arg_7_0.cfg_.obtain_way > 0 and not JumpTools.NeedHide(arg_7_0.cfg_.obtain_way, arg_7_0.id_) then
			arg_7_0.typeCon_:SetSelectedState("get")
		else
			arg_7_0.typeCon_:SetSelectedState("ban")
		end
	elseif var_7_0 == arg_7_0.id_ then
		if arg_7_1 == 1 then
			arg_7_0.typeCon_:SetSelectedState("trial")
		elseif arg_7_1 == 2 then
			arg_7_0.typeCon_:SetSelectedState("normal")
		end
	else
		arg_7_0.typeCon_:SetSelectedState("normal")
	end
end

function var_0_0.RegistClickFunc(arg_8_0, arg_8_1)
	arg_8_0.clickFunc_ = arg_8_1
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
