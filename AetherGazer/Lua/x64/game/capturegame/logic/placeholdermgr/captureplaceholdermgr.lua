local var_0_0 = class("CapturePlaceHolderMgr", CaptureLogicMgrBase)

function var_0_0.Ctor(arg_1_0)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.context = {
		isFocus = false,
		curSelectIdx = 1,
		placeHolderSlot = {},
		skinEntity = {},
		holderOrder = {}
	}
end

function var_0_0.AddPlaceHolder(arg_3_0, arg_3_1)
	table.insert(arg_3_0.context.placeHolderSlot, arg_3_1)
	arg_3_1:SetIndex(#arg_3_0.context.placeHolderSlot)
end

function var_0_0.GetEntity(arg_4_0, arg_4_1)
	return arg_4_0.context.placeHolderSlot[arg_4_1]
end

function var_0_0.SetCurrentSelect(arg_5_0, arg_5_1)
	arg_5_0.context.curSelectIdx = arg_5_1
end

function var_0_0.GetCurrentSelect(arg_6_0)
	return arg_6_0.context.curSelectIdx
end

function var_0_0.GetSkinHolderId(arg_7_0, arg_7_1)
	if arg_7_0.context.skinEntity[arg_7_1] then
		return arg_7_0.context.skinEntity[arg_7_1].useHolder or -1
	else
		return -1
	end
end

function var_0_0.FocusCurrentSelect(arg_8_0, arg_8_1)
	local var_8_0 = CaptureGameMgr:GetCameraMgr():GetMainCam()

	arg_8_0.context.isFocus = arg_8_1

	local var_8_1 = arg_8_0.context.curSelectIdx

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.context.placeHolderSlot) do
		if iter_8_1:GetIndex() ~= var_8_1 then
			iter_8_1:FocusSelf(false)
		elseif arg_8_1 then
			iter_8_1:FocusSelf(true)
		else
			iter_8_1:FocusSelf(false)
		end

		if arg_8_1 then
			iter_8_1:EnableCollider(false)
		else
			iter_8_1:EnableCollider(true)
		end
	end

	if not arg_8_1 then
		arg_8_0:SetCurrentSelect(1)
	end
end

function var_0_0.SwitchSkin(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.context.placeHolderSlot[arg_9_1]
	local var_9_1 = var_9_0:GetSkinEntityId()

	if var_9_1 == arg_9_2 then
		return
	end

	local var_9_2

	if var_9_1 ~= -1 then
		local var_9_3 = CaptureGameMgr:GetEntityMgr():GetEntity(var_9_1)

		var_9_3:Hide(true)

		arg_9_0.context.skinEntity[var_9_3:GetRoleId()].useHolder = -1
	end

	local var_9_4 = arg_9_0:GetOrInstNewRoleEntity(arg_9_2)
	local var_9_5 = CaptureGameMgr:GetEntityMgr():GetEntity(var_9_4.etId)

	if var_9_4.useHolder ~= -1 then
		arg_9_0.context.placeHolderSlot[var_9_4.useHolder]:SwitchSkin(-1)
	end

	var_9_0:SwitchSkin(var_9_4.etId)
	var_9_5:Hide(false)
	var_9_5:ResetToTransformPos(var_9_0:GetPlaceHolderTransform())
	var_9_5:PlayAnimation(-1)

	var_9_4.useHolder = arg_9_1

	manager.notify:Invoke(CAPTURE_GAME_MULTI_HERO_CHANGE)
end

function var_0_0.HolderSelectedSkin(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.context.skinEntity) do
		if iter_10_1.useHolder == arg_10_1 then
			return iter_10_0
		end
	end

	return -1
end

function var_0_0.GetAllUsingSkin(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_0.context.skinEntity) do
		if iter_11_1.useHolder and iter_11_1.useHolder ~= -1 then
			table.insert(var_11_0, iter_11_0)
		end
	end

	return var_11_0
end

function var_0_0.GetAllUsingSkinPose(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0.context.skinEntity) do
		if iter_12_1.useHolder and iter_12_1.useHolder ~= -1 then
			local var_12_1 = CaptureGameMgr:GetEntityMgr():QueryRole(iter_12_0)

			table.insert(var_12_0, var_12_1:GetCurrentAnimation())
		end
	end

	return var_12_0
end

function var_0_0.GetOrInstNewRoleEntity(arg_13_0, arg_13_1)
	if not arg_13_0.context.skinEntity[arg_13_1] then
		arg_13_0.context.skinEntity[arg_13_1] = {
			useHolder = -1,
			etId = CaptureGameBridge.InstNewRole(arg_13_1)
		}
	end

	return arg_13_0.context.skinEntity[arg_13_1]
end

function var_0_0.CheckSkinCanRotate(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return false
	end

	local var_14_0 = arg_14_0.context.skinEntity[arg_14_1]

	if not var_14_0 then
		return false
	end

	if arg_14_0.context.isFocus then
		return var_14_0.useHolder == arg_14_0:GetCurrentSelect()
	else
		return false
	end
end

function var_0_0.IsSlotFull(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.context.placeHolderSlot) do
		if not iter_15_1:HasSkin() then
			return false
		end

		if arg_15_1 and not CaptureGameMgr:GetEntityMgr():GetEntity(iter_15_1:GetSkinEntityId()):OnScreen() then
			return false
		end
	end

	return true
end

function var_0_0.HideAll(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.context.placeHolderSlot) do
		iter_16_1:Hide(arg_16_1)
	end
end

function var_0_0.ReposAnchor(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.context.placeHolderSlot) do
		iter_17_1:ReposAnchor()
	end
end

function var_0_0.SortHolderWithCamera(arg_18_0)
	local var_18_0 = UnityEngine.Camera.main
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.context.placeHolderSlot) do
		local var_18_2 = iter_18_1.context.transform
		local var_18_3 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_18_0, var_18_2.position)

		table.insert(var_18_1, {
			x = var_18_3.x,
			idx = iter_18_0
		})
	end

	table.sort(var_18_1, function(arg_19_0, arg_19_1)
		if arg_19_0.x == arg_19_1.x then
			return false
		end

		return arg_19_0.x < arg_19_1.x
	end)

	for iter_18_2, iter_18_3 in ipairs(var_18_1) do
		arg_18_0.context.holderOrder[iter_18_3.idx] = iter_18_2
	end
end

function var_0_0.GetHolderPhysicsIdx(arg_20_0, arg_20_1)
	return arg_20_0.context.holderOrder[arg_20_1]
end

function var_0_0.Dispose(arg_21_0)
	return
end

return var_0_0
