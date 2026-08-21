local var_0_0 = class("EquipDisc", ReduxView)

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

	arg_3_0.equipItem_ = {}

	for iter_3_0 = 1, 6 do
		local var_3_0 = arg_3_0["equipItem_" .. iter_3_0]

		arg_3_0.equipItem_[iter_3_0] = EquipItem.New(var_3_0)

		arg_3_0.equipItem_[iter_3_0]:RegistCallBack(function(arg_4_0, arg_4_1)
			if arg_3_0.itemClickCallBack then
				arg_3_0.itemClickCallBack(arg_4_0, iter_3_0)

				if arg_3_0.lastSelectItem_ then
					arg_3_0.lastSelectItem_:ShowSelect(false)
				end

				arg_4_1:ShowSelect(true)

				arg_3_0.lastSelectItem_ = arg_4_1
			end
		end)
	end

	arg_3_0.ringController_ = arg_3_0.discCon_:GetController("ring")
	arg_3_0.itemController_ = arg_3_0.itemCon_:GetController("default0")
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0, arg_6_1)
	arg_6_0.isShowDetail_ = arg_6_1 and arg_6_1.isShowDetail

	local var_6_0 = arg_6_0.isShowDetail_

	arg_6_0.ringController_:SetSelectedState(var_6_0 and "B" or "A")
	arg_6_0.ringAAni_:Play(var_6_0 and "UI_ringA" or "UI_ringB")
	arg_6_0.ringAAni_:Update(0)
	arg_6_0.itemController_:SetSelectedState(var_6_0 and "open" or "close")
end

function var_0_0.Rotate(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 and arg_7_2 then
		arg_7_0:ResetAngle()

		if arg_7_1 == arg_7_2 then
			local var_7_0 = -120 - (arg_7_2 - 1) * 60

			arg_7_0.rotateServant_.transform.localEulerAngles = Vector3.New(0, 0, var_7_0)

			arg_7_0:HideItems()
		else
			arg_7_0:RotateServant(arg_7_1, arg_7_2)
		end
	end
end

function var_0_0.RefreshItem(arg_8_0, arg_8_1)
	for iter_8_0 = 1, 6 do
		local var_8_0 = arg_8_1[iter_8_0]

		arg_8_0.equipItem_[iter_8_0]:RefreshData(var_8_0, arg_8_0.isShowDetail_)
	end
end

function var_0_0.Reset(arg_9_0)
	for iter_9_0 = 1, 6 do
		arg_9_0.equipItem_[iter_9_0]:ShowSelect(false)
	end
end

function var_0_0.PlayAnim(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_0.servantAnim_:Play("Fx_servant_cx")
	else
		arg_10_0.servantAnim_:Play("Fx_servant_cx")
	end
end

function var_0_0.RotateServant(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.index_ = arg_11_2

	local var_11_0 = arg_11_0:GetAngle(arg_11_1, arg_11_2)

	if var_11_0 ~= 0 then
		arg_11_0.rotateLeanTween_ = LeanTween.rotateAroundLocal(arg_11_0.rotateServant_, Vector3.New(0, 0, 1), var_11_0, 0.5):setEase(LeanTweenType.easeOutCubic)
	end
end

function var_0_0.GetAngle(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = (arg_12_1 - arg_12_2) * 60

	if math.abs(var_12_0) > 180 then
		var_12_0 = var_12_0 > 0 and var_12_0 - 360 or var_12_0 + 360
	end

	return var_12_0
end

function var_0_0.HideItems(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.equipItem_) do
		iter_13_1:Hide()
	end
end

function var_0_0.RegistItemButton(arg_14_0, arg_14_1)
	arg_14_0.itemClickCallBack = arg_14_1
end

function var_0_0.ShowAnim(arg_15_0, arg_15_1)
	arg_15_0.equipItem_[arg_15_1]:ShowAnim()
end

function var_0_0.RefreshItemByIndex(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.equipItem_[arg_16_1]:RefreshData(arg_16_2)
end

function var_0_0.ResetAngle(arg_17_0)
	arg_17_0.rotateServant_.transform.rotation = Vector3.zero
end

function var_0_0.OnExit(arg_18_0)
	return
end

function var_0_0.Dispose(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.equipItem_) do
		iter_19_1:Dispose()
	end

	arg_19_0.equipItem_ = nil

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
