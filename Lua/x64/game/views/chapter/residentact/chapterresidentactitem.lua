local var_0_0 = class("ChapterResidentActItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("select")
	arg_3_0.stateController_ = arg_3_0.controllerEx_:GetController("state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickCallback then
			arg_4_0:clickCallback(arg_4_0)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	local var_6_0 = ChapterClientCfg[arg_6_1]

	arg_6_0.chapterID = arg_6_1
	arg_6_0.paintImage_.spriteAsync = "TextureConfig/Chapter/" .. var_6_0.chapter_paint

	local var_6_1 = arg_6_0:GetActID()
	local var_6_2 = ChapterResidentTools.GetResidentActFinishState(var_6_1)

	arg_6_0.stateController_:SetSelectedState(var_6_2 and "completed" or "normal")
	manager.redPoint:bindUIandKey(arg_6_0.transform_, RedPointConst.RESIDENT_ACT .. arg_6_0:GetActID())
end

function var_0_0.SetClickCallback(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.clickCallback = arg_7_1
	end
end

function var_0_0.GetChapterID(arg_8_0)
	return arg_8_0.chapterID
end

function var_0_0.GetActID(arg_9_0)
	return ChapterClientCfg[arg_9_0.chapterID].activity_id
end

function var_0_0.UpdateSelectState(arg_10_0, arg_10_1)
	arg_10_0.selectController_:SetSelectedState(arg_10_1 and "true" or "false")
end

function var_0_0.OnExit(arg_11_0)
	manager.redPoint:unbindUIandKey(arg_11_0.transform_, RedPointConst.RESIDENT_ACT .. arg_11_0:GetActID())
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
