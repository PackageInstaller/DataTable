local CapturePlaceHolderMgr = class("CapturePlaceHolderMgr", CaptureLogicMgrBase)

function CapturePlaceHolderMgr:Ctor()
	self:Init()
end

function CapturePlaceHolderMgr:Init()
	self.context = {
		isFocus = false,
		curSelectIdx = 1,
		placeHolderSlot = {},
		skinEntity = {},
		holderOrder = {}
	}
end

function CapturePlaceHolderMgr:AddPlaceHolder(arg_3_1)
	table.insert(self.context.placeHolderSlot, arg_3_1)
	arg_3_1:SetIndex(#self.context.placeHolderSlot)
end

function CapturePlaceHolderMgr:GetEntity(arg_4_1)
	return self.context.placeHolderSlot[arg_4_1]
end

function CapturePlaceHolderMgr:SetCurrentSelect(arg_5_1)
	self.context.curSelectIdx = arg_5_1
end

function CapturePlaceHolderMgr:GetCurrentSelect()
	return self.context.curSelectIdx
end

function CapturePlaceHolderMgr:GetSkinHolderId(arg_7_1)
	if self.context.skinEntity[arg_7_1] then
		return self.context.skinEntity[arg_7_1].useHolder or -1
	else
		return -1
	end
end

function CapturePlaceHolderMgr:FocusCurrentSelect(arg_8_1)
	local var_8_0 = CaptureGameMgr:GetCameraMgr():GetMainCam()

	self.context.isFocus = arg_8_1

	for iter_8_0, iter_8_1 in ipairs(self.context.placeHolderSlot) do
		if iter_8_1:GetIndex() ~= self.context.curSelectIdx then
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
		self:SetCurrentSelect(1)
	end
end

function CapturePlaceHolderMgr:SwitchSkin(arg_9_1, arg_9_2)
	local var_9_0 = self.context.placeHolderSlot[arg_9_1]:GetSkinEntityId()

	if var_9_0 == arg_9_2 then
		return
	end

	if var_9_0 ~= -1 then
		local var_9_2 = CaptureGameMgr:GetEntityMgr():GetEntity(var_9_0)

		var_9_2:Hide(true)

		self.context.skinEntity[var_9_2:GetRoleId()].useHolder = -1
	end

	local var_9_3 = self:GetOrInstNewRoleEntity(arg_9_2)
	local var_9_4 = CaptureGameMgr:GetEntityMgr():GetEntity(var_9_3.etId)

	if var_9_3.useHolder ~= -1 then
		self.context.placeHolderSlot[var_9_3.useHolder]:SwitchSkin(-1)
	end

	self.context.placeHolderSlot[arg_9_1]:SwitchSkin(var_9_3.etId)
	var_9_4:Hide(false)
	var_9_4:ResetToTransformPos(self.context.placeHolderSlot[arg_9_1]:GetPlaceHolderTransform())
	var_9_4:PlayAnimation(-1)

	var_9_3.useHolder = arg_9_1

	manager.notify:Invoke(CAPTURE_GAME_MULTI_HERO_CHANGE)
end

function CapturePlaceHolderMgr:HolderSelectedSkin(arg_10_1)
	for iter_10_0, iter_10_1 in pairs(self.context.skinEntity) do
		if iter_10_1.useHolder == arg_10_1 then
			return iter_10_0
		end
	end

	return -1
end

function CapturePlaceHolderMgr:GetAllUsingSkin()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(self.context.skinEntity) do
		if iter_11_1.useHolder and iter_11_1.useHolder ~= -1 then
			table.insert(var_11_0, iter_11_0)
		end
	end

	return var_11_0
end

function CapturePlaceHolderMgr:GetAllUsingSkinPose()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(self.context.skinEntity) do
		if iter_12_1.useHolder and iter_12_1.useHolder ~= -1 then
			table.insert(var_12_0, CaptureGameMgr:GetEntityMgr():QueryRole(iter_12_0):GetCurrentAnimation())
		end
	end

	return var_12_0
end

function CapturePlaceHolderMgr:GetOrInstNewRoleEntity(arg_13_1)
	self.context.skinEntity[arg_13_1] = self.context.skinEntity[arg_13_1] or {
		useHolder = -1,
		etId = CaptureGameBridge.InstNewRole(arg_13_1)
	}

	return self.context.skinEntity[arg_13_1]
end

function CapturePlaceHolderMgr:CheckSkinCanRotate(arg_14_1)
	if not arg_14_1 then
		return false
	end

	local var_14_0 = self.context.skinEntity[arg_14_1]

	if not self.context.skinEntity[arg_14_1] then
		return false
	end

	if self.context.isFocus then
		return var_14_0.useHolder == self:GetCurrentSelect()
	else
		return false
	end
end

function CapturePlaceHolderMgr:IsSlotFull(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(self.context.placeHolderSlot) do
		if not iter_15_1:HasSkin() then
			return false
		end

		if arg_15_1 then
			if not CaptureGameMgr:GetEntityMgr():GetEntity(iter_15_1:GetSkinEntityId()):OnScreen() then
				return false
			end
		end
	end

	return true
end

function CapturePlaceHolderMgr:HideAll(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(self.context.placeHolderSlot) do
		iter_16_1:Hide(arg_16_1)
	end
end

function CapturePlaceHolderMgr:ReposAnchor()
	for iter_17_0, iter_17_1 in ipairs(self.context.placeHolderSlot) do
		iter_17_1:ReposAnchor()
	end
end

function CapturePlaceHolderMgr:SortHolderWithCamera()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(self.context.placeHolderSlot) do
		table.insert(var_18_0, {
			x = UnityEngine.RectTransformUtility.WorldToScreenPoint(UnityEngine.Camera.main, iter_18_1.context.transform.position).x,
			idx = iter_18_0
		})
	end

	table.sort(var_18_0, function(arg_19_0, arg_19_1)
		if arg_19_0.x == arg_19_1.x then
			return false
		end

		return arg_19_0.x < arg_19_1.x
	end)

	for iter_18_2, iter_18_3 in ipairs(var_18_0) do
		self.context.holderOrder[iter_18_3.idx] = iter_18_2
	end
end

function CapturePlaceHolderMgr:GetHolderPhysicsIdx(arg_20_1)
	return self.context.holderOrder[arg_20_1]
end

function CapturePlaceHolderMgr:Dispose()
	return
end

return CapturePlaceHolderMgr
