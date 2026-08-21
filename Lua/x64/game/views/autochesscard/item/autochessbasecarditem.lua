local var_0_0 = class("AutoChessBaseCardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.cardID_ = 0

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	if arg_3_0.controller_ then
		arg_3_0.positionController_ = arg_3_0.controller_:GetController("position")
	end
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickHandler_ then
			arg_4_0.clickHandler_()
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.cardID_ = arg_6_1

	arg_6_0:RefreshUI()

	if not arg_6_2 then
		arg_6_0:SetImg()
	end
end

function var_0_0.SetClickHandler(arg_7_0, arg_7_1)
	arg_7_0.clickHandler_ = arg_7_1
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = AutoChessCardCfg[arg_8_0.cardID_]
	local var_8_1 = AutoChessCardTools.GetCardName(arg_8_0.cardID_)
	local var_8_2 = string.split(var_8_1, "·")

	arg_8_0.txtName_.text = var_8_2[2] or var_8_2[1]

	if var_8_2[2] then
		SetActive(arg_8_0.txtNick_.gameObject, true)

		arg_8_0.txtNick_.text = var_8_2[1]
	else
		SetActive(arg_8_0.txtNick_.gameObject, false)
	end
end

function var_0_0.SetImg(arg_9_0)
	local var_9_0 = AutoChessCardCfg[arg_9_0.cardID_]

	arg_9_0.img_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_AutoChess_Chess/RoleBattle/" .. var_9_0.pic)
end

function var_0_0.SetPositionState(arg_10_0, arg_10_1)
	if arg_10_0.positionController_ then
		arg_10_0.positionController_:SetSelectedState(arg_10_1)
	end
end

function var_0_0.SetActive(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
