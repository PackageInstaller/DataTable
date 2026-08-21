local var_0_0 = class("GoldMinerThingItem", ReduxView)

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
	arg_3_0.direct_ = 1
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.AddEventListeners(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.id_ = arg_6_2
	arg_6_0.data_ = arg_6_1
	arg_6_0.cfg_ = GameFishCfg[arg_6_1.fishId]
	arg_6_0.hitArea_.sizeDelta = Vector2(arg_6_0.data_.hitWidth, arg_6_0.data_.hitHeight)
end

function var_0_0.GetData(arg_7_0)
	return arg_7_0.data_
end

function var_0_0.GetID(arg_8_0)
	return arg_8_0.id_
end

function var_0_0.GetLocalPosition(arg_9_0)
	return arg_9_0.transform_.localPosition
end

function var_0_0.UpdateView(arg_10_0)
	return
end

function var_0_0.Update(arg_11_0, arg_11_1)
	if arg_11_0.data_ and arg_11_0.data_.moveable == 1 then
		local var_11_0 = arg_11_0.transform_.localPosition

		var_11_0.x = var_11_0.x + arg_11_1 * arg_11_0.direct_ * arg_11_0.cfg_.speed / 10 * 60

		if var_11_0.x < arg_11_0.oriX_ - arg_11_0.data_.radius then
			var_11_0.x = arg_11_0.oriX_ - arg_11_0.data_.radius
			arg_11_0.direct_ = 1

			local var_11_1 = arg_11_0.imageTransform_.localScale

			if var_11_1 == nil then
				CustomLog.Log(string.format("scale is nil"))
			end

			var_11_1.x = 1
			arg_11_0.imageTransform_.localScale = var_11_1
		elseif var_11_0.x > arg_11_0.oriX_ + arg_11_0.data_.radius then
			var_11_0.x = arg_11_0.oriX_ + arg_11_0.data_.radius
			arg_11_0.direct_ = -1

			local var_11_2 = arg_11_0.imageTransform_.localScale

			var_11_2.x = -1
			arg_11_0.imageTransform_.localScale = var_11_2
		end

		arg_11_0.transform_.localPosition = var_11_0
	end
end

function var_0_0.SetActive(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, arg_12_1)
end

function var_0_0.Dispose(arg_13_0)
	Object.Destroy(arg_13_0.gameObject_)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
