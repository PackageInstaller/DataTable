local var_0_0 = class("GuelGameTileItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.colorControlller = arg_1_0.coloritemControllerexcollection_:GetController("color")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:RemoveBtnListener(nil, arg_2_0.imageBtn_.transform)
	arg_2_0:AddBtnListener(arg_2_0.imageBtn_, nil, function()
		if arg_2_0.data and arg_2_0.data.canclick and GuelGameManager.GetInstance().gameData.playerState == GueGameConst.GameState.playing then
			GuelGameManager.GetInstance():DoClickTile(true, arg_2_0.data.index)
		end
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.data = arg_4_1

	if arg_4_1.color then
		arg_4_0.colorControlller:SetSelectedState(arg_4_1.color)
	else
		arg_4_0.colorControlller:SetSelectedState("none")
	end
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.ShowEffect(arg_6_0, arg_6_1)
	arg_6_0.coloritemAni_:Play("colorItem", 0, 0)
end

function var_0_0.SetPosition(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.gameObject_ and not isNil(arg_7_0.gameObject_) then
		arg_7_0.gameObject_.transform.anchoredPosition = Vector3.New(arg_7_1, arg_7_2, 0)
	end
end

function var_0_0.GetPositionX(arg_8_0)
	if arg_8_0.gameObject_ and not isNil(arg_8_0.gameObject_) then
		return arg_8_0.gameObject_.transform.anchoredPosition.x
	end

	return 0
end

function var_0_0.OnExit(arg_9_0)
	var_0_0.super.OnExit(arg_9_0)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
