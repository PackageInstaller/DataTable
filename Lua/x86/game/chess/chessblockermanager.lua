local var_0_0 = class("ChessBlockerManager")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.Blocker_ = nil
	arg_1_0.blockTimes_ = 0

	arg_1_0:CreateBlocker(arg_1_1)
end

function var_0_0.ShowBlocker(arg_2_0)
	arg_2_0.blockTimes_ = arg_2_0.blockTimes_ + 1

	if arg_2_0.blockTimes_ >= 1 then
		SetActive(arg_2_0.Blocker_, true)
		ChessLuaBridge.SetChessInputEnable(false)
	end
end

function var_0_0.HideBlocker(arg_3_0)
	arg_3_0.blockTimes_ = arg_3_0.blockTimes_ == 0 and 0 or arg_3_0.blockTimes_ - 1

	if arg_3_0.blockTimes_ <= 0 then
		SetActive(arg_3_0.Blocker_, false)
		ChessLuaBridge.SetChessInputEnable(true)
	end
end

function var_0_0.CreateBlocker(arg_4_0, arg_4_1)
	local var_4_0 = GameObject("Blocker")
	local var_4_1 = var_4_0:AddComponent(typeof(RectTransform))

	var_4_1:SetParent(arg_4_1.transform, false)

	var_4_1.anchorMin = Vector3.zero
	var_4_1.anchorMax = Vector3.one
	var_4_1.sizeDelta = Vector2.zero
	var_4_0:AddComponent(typeof(Image)).color = Color.clear

	SetActive(var_4_0, false)

	arg_4_0.Blocker_ = var_4_0
end

function var_0_0.DestroyBlocker(arg_5_0)
	Object.Destroy(arg_5_0.Blocker_)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:DestroyBlocker()
end

return var_0_0
