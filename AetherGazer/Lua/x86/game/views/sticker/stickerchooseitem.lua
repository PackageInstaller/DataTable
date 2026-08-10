local var_0_0 = class("StickerChooseItem", ReduxView)

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

	arg_3_0.selectCon_ = ControllerUtil.GetController(arg_3_0.iconGo_.transform, "select")
	arg_3_0.lockCon_ = ControllerUtil.GetController(arg_3_0.iconGo_.transform, "lock")
	arg_3_0.useCon_ = ControllerUtil.GetController(arg_3_0.iconGo_.transform, "use")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.iconBtn_, nil, function()
		if arg_4_0.clickFunc_ then
			arg_4_0.clickFunc_()
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshItem(arg_7_0, arg_7_1)
	arg_7_0.itemID_ = arg_7_1

	local var_7_0 = PlayerData:GetSticker(arg_7_0.itemID_)

	arg_7_0.icon_.sprite = ItemTools.getItemSprite(arg_7_0.itemID_)

	arg_7_0.lockCon_:SetSelectedState(var_7_0.unlock == 0 and "lock" or "default")
end

function var_0_0.SetSelected(arg_8_0, arg_8_1)
	arg_8_0.selectCon_:SetSelectedState(arg_8_1 and "select" or "default")
end

function var_0_0.SetUsed(arg_9_0, arg_9_1)
	arg_9_0.useCon_:SetSelectedState(arg_9_1 and "used" or "default")
end

function var_0_0.RegisterClickListener(arg_10_0, arg_10_1)
	if arg_10_0.clickFunc_ == nil then
		arg_10_0.clickFunc_ = arg_10_1
	end
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()

	arg_12_0.clickFunc_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
