local var_0_0 = class("FishItem", ReduxView)

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

	arg_3_0.oriX_ = arg_3_0.transform_.localPosition.x
	arg_3_0.direct_ = -1
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.AddEventListeners(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.data_ = arg_6_1
	arg_6_0.fishCfg_ = GameFishCfg[arg_6_1.fishId]

	arg_6_0:UpdateView()
end

function var_0_0.GetData(arg_7_0)
	return arg_7_0.data_
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.hitArea_.sizeDelta = Vector2(arg_8_0.data_.hitWidth, arg_8_0.data_.hitHeight)

	arg_8_0:DrawDebug()
end

function var_0_0.DrawDebug(arg_9_0)
	return
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_11_0)
	return
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:AddEventListeners()
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.Update(arg_14_0, arg_14_1)
	if arg_14_0.data_.moveable == 1 and FishGameManager.GetInstance():GetBuff() ~= 3 then
		local var_14_0 = arg_14_0.transform_.localPosition

		var_14_0.x = var_14_0.x + arg_14_1 * arg_14_0.direct_ * arg_14_0.fishCfg_.speed / 10 * 60

		if var_14_0.x < arg_14_0.oriX_ - arg_14_0.data_.radius then
			var_14_0.x = arg_14_0.oriX_ - arg_14_0.data_.radius
			arg_14_0.direct_ = 1

			local var_14_1 = arg_14_0.imageTransform_.localScale

			if var_14_1 == nil then
				CustomLog.Log(string.format("scale is nil"))
			end

			var_14_1.x = -1
			arg_14_0.imageTransform_.localScale = var_14_1
		elseif var_14_0.x > arg_14_0.oriX_ + arg_14_0.data_.radius then
			var_14_0.x = arg_14_0.oriX_ + arg_14_0.data_.radius
			arg_14_0.direct_ = -1

			local var_14_2 = arg_14_0.imageTransform_.localScale

			var_14_2.x = 1
			arg_14_0.imageTransform_.localScale = var_14_2
		end

		arg_14_0.transform_.localPosition = var_14_0
	end
end

function var_0_0.Dispose(arg_15_0)
	Object.Destroy(arg_15_0.gameObject_)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
