local var_0_0 = class("NewWarChessBlockerManager")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.Blocker_ = nil
	arg_1_0.moveBlockTimes_ = 0
	arg_1_0.blockTimes_ = 0

	arg_1_0:CreateBlocker(arg_1_1)
end

function var_0_0.ShowMoveBlocker(arg_2_0)
	arg_2_0.moveBlockTimes_ = 1

	arg_2_0:CheckBlockerGo()
end

function var_0_0.HideMoveBlocker(arg_3_0)
	arg_3_0.moveBlockTimes_ = 0

	arg_3_0:CheckBlockerGo()
end

function var_0_0.ShowBlocker(arg_4_0)
	if arg_4_0.blockTimes_ < 0 then
		arg_4_0.blockTimes_ = 0
	end

	arg_4_0.blockTimes_ = arg_4_0.blockTimes_ + 1

	arg_4_0:CheckBlockerGo()
end

function var_0_0.HideBlocker(arg_5_0)
	if arg_5_0.blockTimes_ > 0 then
		arg_5_0.blockTimes_ = arg_5_0.blockTimes_ == 0 and 0 or arg_5_0.blockTimes_ - 1
	end

	arg_5_0:CheckBlockerGo()
end

function var_0_0.CheckBlockerGo(arg_6_0)
	if arg_6_0.moveBlockTimes_ == 1 or arg_6_0.blockTimes_ >= 1 then
		SetActive(arg_6_0.Blocker_, true)
		NewChessLuaBridge.SetChessInputEnable(false)
	elseif arg_6_0.moveBlockTimes_ == 0 and arg_6_0.blockTimes_ <= 0 then
		SetActive(arg_6_0.Blocker_, false)
		NewChessLuaBridge.SetChessInputEnable(true)
	end
end

function var_0_0.CreateBlocker(arg_7_0, arg_7_1)
	local var_7_0 = GameObject("Blocker")
	local var_7_1 = var_7_0:AddComponent(typeof(RectTransform))

	var_7_1:SetParent(arg_7_1.transform, false)

	var_7_1.anchorMin = Vector3.zero
	var_7_1.anchorMax = Vector3.one
	var_7_1.sizeDelta = Vector2.zero
	var_7_0:AddComponent(typeof(Image)).color = Color.clear

	SetActive(var_7_0, false)

	arg_7_0.Blocker_ = var_7_0
end

function var_0_0.DestroyBlocker(arg_8_0)
	Object.Destroy(arg_8_0.Blocker_)
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:DestroyBlocker()
end

return var_0_0
