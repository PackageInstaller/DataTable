local var_0_0 = class("BlisterPointItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.rewardItemList_ = {}
	arg_2_0.itemDataList_ = {}
	arg_2_0.starControl = arg_2_0.bubblebtn01Controllerexcollection_:GetController("stars")
	arg_2_0.selectControl = arg_2_0.bubblebtn01Controllerexcollection_:GetController("select")
	arg_2_0.lockControl = arg_2_0.bubblebtn01Controllerexcollection_:GetController("lock")
	arg_2_0.dustingControl = arg_2_0.bubblebtn01Controllerexcollection_:GetController("isDusting")
	arg_2_0.stateControl = arg_2_0.bubblebtn01Controllerexcollection_:GetController("showState")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(arg_3_0.bubblebtn01Btn_, nil, function()
		arg_3_0:OnClick()
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.ctrl = arg_5_3
	arg_5_0.index = arg_5_2
	arg_5_0.data = arg_5_1

	arg_5_0:RefreshUI(arg_5_1, arg_5_2)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.txtsignText_.text = ActivityBubbleCfg[arg_6_1.id].name

	local var_6_0 = BlisterGameData:GetStageIdIsOpen(arg_6_1.id)

	arg_6_0.lockControl:SetSelectedState(var_6_0 and "false" or "true")
	arg_6_0.starControl:SetSelectedState("state" .. arg_6_1.star)
	arg_6_0.dustingControl:SetSelectedState(arg_6_1.isPass and "false" or "true")
	manager.redPoint:unbindUIandKey(arg_6_0.con_panelTrs_.transform)
	manager.redPoint:bindUIandKey(arg_6_0.con_panelTrs_.transform, string.format("%s_%s", RedPointConst.BLISTER_GAME_PLAY, arg_6_0.data.id))
	arg_6_0.stateControl:SetSelectedState("state" .. (arg_6_2 <= 6 and arg_6_2 - 1 or arg_6_2 % 6))
	arg_6_0.appearAnim_:Play("Fx_bubblebtn01_cx", 0, 0)
end

function var_0_0.RefreshItem(arg_7_0)
	return
end

function var_0_0.OnClick(arg_8_0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.BLISTER_GAME_PLAY, arg_8_0.data.id), 0)

	if ActivityBubbleCfg[arg_8_0.data.id] then
		arg_8_0.ctrl:SetSelect(arg_8_0.index)

		arg_8_0.ctrl.scrollviewSr_.enabled = false

		BlisterGameTool.GoToChapterSectionInfoView(arg_8_0.data.id)
	else
		ShowTips(GetTips("TIME_OVER"))
	end
end

function var_0_0.SetSelect(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.selectControl:SetSelectedState("state1")
	else
		arg_9_0.selectControl:SetSelectedState("state0")
	end
end

function var_0_0.OnExit(arg_10_0)
	var_0_0.super.OnExit(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.con_panelTrs_.transform)
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
