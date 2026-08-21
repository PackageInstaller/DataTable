local var_0_0 = class("AshSectionItem", ReduxView)
local var_0_1 = {
	OPEN = 2,
	COMPLETE = 3,
	LOCK = 1
}

function var_0_0.GetStageItem(arg_1_0)
	return "Widget/System/Activity_EkChuah/EkChuah_Com/Stage_item/OrdinaryStageItem"
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.gameObject_ = GameObject.Instantiate(Asset.Load(arg_2_0:GetStageItem()))
	arg_2_0.transform_ = arg_2_0.gameObject_.transform
	arg_2_0.transform_.parent = arg_2_1
	arg_2_0.transform_.localPosition = Vector3.zero
	arg_2_0.transform_.localRotation = Quaternion.identity
	arg_2_0.transform_.localScale = Vector3.one
	arg_2_0.Tf_ = arg_2_0.transform_:GetComponent("RectTransform")
	arg_2_0.parentView = arg_2_2
	arg_2_0.handler_ = arg_2_3

	arg_2_0:Init()
	arg_2_0:AddUIListener()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController = arg_3_0.controllerEx_:GetController("selectState")
	arg_3_0.stateController = arg_3_0.controllerEx_:GetController("passState")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		arg_4_0.parentView:SelectStage(arg_4_0)
		JumpTools.OpenPageByJump("ashSectionBaseView", {
			level = arg_4_0.data.level,
			backFunc = arg_4_0.handler_
		})
	end)
end

function var_0_0.RenderItem(arg_6_0, arg_6_1, arg_6_2)
	manager.redPoint:unbindUIandKey(arg_6_0.transform_)
	manager.redPoint:bindUIandKey(arg_6_0.transform_, RedPointConst.ASH_ACTIVITY_SECTION_AREA_SECTION .. arg_6_1.level)

	arg_6_0.Tf_.localPosition = arg_6_2
	arg_6_0.data = arg_6_1
	arg_6_0.stageDesc_.text = NumberTools.IntToRomam(arg_6_0:GetIndex())

	arg_6_0:RenderSelect(false)
	arg_6_0:CheckStageState()
end

function var_0_0.GetIndex(arg_7_0)
	return arg_7_0.data.index
end

function var_0_0.CheckStageState(arg_8_0)
	if AshSystemData:IsStagePass(arg_8_0.data.level) then
		arg_8_0.state = var_0_1.COMPLETE

		arg_8_0.stateController:SetSelectedState("complete")
	else
		local var_8_0 = AshSystemData:FindPreSection(arg_8_0.data.level)

		if not var_8_0 or var_8_0 and AshSystemData:IsStagePass(var_8_0) then
			arg_8_0.state = var_0_1.OPEN

			arg_8_0.stateController:SetSelectedState("unlock")

			local var_8_1 = "CowbotSectionLock" .. arg_8_0.data.level

			if not getData("ash", var_8_1) then
				saveData("ash", var_8_1, true)
				arg_8_0:StopLockTimer()

				arg_8_0.unlockTimer = Timer.New(function()
					arg_8_0.lockAnim_:Play("unlock", 0, 0)
				end, 1, 1)

				arg_8_0.unlockTimer:Start()
			end
		else
			arg_8_0.state = var_0_1.LOCK

			arg_8_0.stateController:SetSelectedState("lock")
		end
	end
end

function var_0_0.GetIsUnlock(arg_10_0)
	if AshSystemData:IsStagePass(arg_10_0.data.level) then
		return true
	end

	local var_10_0 = AshSystemData:FindPreSection(arg_10_0.data.level)

	if not var_10_0 or var_10_0 and AshSystemData:IsStagePass(var_10_0) then
		return true
	end

	return false
end

function var_0_0.StopLockTimer(arg_11_0)
	if arg_11_0.unlockTimer then
		arg_11_0.unlockTimer:Stop()

		arg_11_0.unlockTimer = nil
	end
end

function var_0_0.RenderSelect(arg_12_0, arg_12_1)
	if arg_12_1 then
		AshSystemData:RemoveSectionRed(arg_12_0.data.level)
	end

	arg_12_0.selectController:SetSelectedState(arg_12_1 and "true" or "false")
end

function var_0_0.RefreshAnim(arg_13_0)
	arg_13_0.lockAnim_:Play("OrdinaryStageItem_cx", 0, 0)
end

function var_0_0.Dispose(arg_14_0)
	manager.redPoint:unbindUIandKey(arg_14_0.transform_)
	GameObject.DestroyImmediate(arg_14_0.gameObject_)
	Asset.Unload(arg_14_0:GetStageItem())
	arg_14_0:StopLockTimer()
	arg_14_0.super.Dispose(arg_14_0)
end

return var_0_0
