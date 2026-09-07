local Dorm3dHxHelper = class("Dorm3dHxHelper")

function Dorm3dHxHelper.GetTimelineMainCharacter()
	local var_1_0

	table.IpairsCArray(GameObject.Find("[actor]").transform:GetComponentsInChildren(typeof("BLHXCharacterPropertiesController")), function(arg_2_0, arg_2_1)
		if arg_2_0 == 0 or Dorm3dHxHelper.GetSkinIdByModelName(arg_2_1.gameObject.name) then
			var_1_0 = arg_2_1.transform
		end

		return
	end)

	return nil
end

function Dorm3dHxHelper:GetSkinIdByModelName()
	self = string.gsub(self, "%s*%(Clone%)$", "")

	for iter_3_0, iter_3_1 in ipairs(pg.dorm3d_resource.all) do
		if pg.dorm3d_resource[iter_3_1].origin_model == self or pg.dorm3d_resource[iter_3_1].model_id == self then
			return iter_3_1
		end
	end

	return nil
end

function Dorm3dHxHelper:ReplaceCharacterParts()
	if not HXSet.isHx() then
		return false
	end

	local var_4_0 = Dorm3dHxHelper.GetSkinIdByModelName(self.name)

	if not var_4_0 then
		return false
	end

	local var_4_1 = pg.dorm3d_resource[var_4_0].hx_component

	if not pg.dorm3d_resource[var_4_0].hx_component or var_4_1 == "" or #var_4_1 == 0 then
		return false
	end

	local var_4_2 = false

	_.each(var_4_1, function(arg_5_0)
		if not checkABExist(arg_5_0) then
			warning("要替换的部件不存在", arg_5_0)

			return
		end

		GraphicsInterface.Instance:LoadCharacterComponent(go(self), arg_5_0)
		warning("ReplaceCharacterPart", arg_5_0)

		var_4_2 = true

		return
	end)

	return var_4_2
end

function Dorm3dHxHelper:ShowHolyLight(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(self) do
		if iter_6_1 then
			GetOrAddComponent(iter_6_1, typeof(DormAnimationEventDispatcher))
		end
	end

	if not HXSet.isHx() then
		return false
	end

	arg_6_2 = arg_6_2 or false

	local var_6_0 = {}

	for iter_6_2, iter_6_3 in ipairs(self) do
		if iter_6_3 then
			local var_6_1 = Dorm3dHxHelper.GetSkinIdByModelName(iter_6_3.name)

			if var_6_1 then
				for iter_6_4, iter_6_5 in ipairs(pg.dorm3d_holylight.get_id_list_by_skin_id[var_6_1] or {}) do
					table.insert(var_6_0, {
						iter_6_3,
						pg.dorm3d_holylight[iter_6_5]
					})
				end
			end
		end
	end

	UIItemList.StaticAlign(arg_6_1, arg_6_1:GetChild(0), #var_6_0, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0, var_7_1 = unpack(var_6_0[arg_7_1 + 1])
		local var_7_2 = arg_7_2:GetComponent(typeof(HolyLightController))

		var_7_2.targetBone = var_7_0:Find(var_7_1.target_bone)
		var_7_2.localAxis = Vector3(unpack(var_7_1.axis))
		var_7_2.invertAxis = var_7_1.invert ~= 0
		var_7_2.defaultAxisThreshold = var_7_1.default_threshold
		var_7_2.axisThreshold = var_7_2.defaultAxisThreshold
		var_7_2.rotationOffset = Vector3(unpack(var_7_1.rotation_offset))

		GetSpriteFromAtlasAsync(var_7_1.texture, "", function(arg_8_0)
			local var_8_0 = arg_7_2:GetComponent(typeof(Image))

			var_8_0.sprite = arg_8_0
			var_8_0.color = Color.New(unpack(var_7_1.color))

			return
		end)

		var_7_2.baseSize = Vector2(unpack(var_7_1.base_size))
		var_7_2.useRaycastOcclusion = arg_6_2
		var_7_2.targetDispatcher = GetOrAddComponent(var_7_0, typeof(DormAnimationEventDispatcher))

		return
	end)

	return
end

function Dorm3dHxHelper:SetModelHolyLightActive(arg_9_1, arg_9_2)
	if not HXSet.isHx() then
		return false
	end

	if not self or IsNil(self) or not arg_9_1 or IsNil(arg_9_1) then
		return false
	end

	local var_9_0 = false

	for iter_9_0 = 0, arg_9_1.childCount - 1 do
		local var_9_1 = arg_9_1:GetChild(iter_9_0)
		local var_9_2 = var_9_1:GetComponent(typeof(HolyLightController))
		local var_9_3 = var_9_2 and var_9_2.targetBone

		if var_9_2 and var_9_2.targetBone and not IsNil(var_9_3) and var_9_3:IsChildOf(self) then
			setActive(var_9_1, arg_9_2)

			var_9_0 = true
		end
	end

	return var_9_0
end

function Dorm3dHxHelper:GetHolyLightScreenShotInfo()
	local var_10_0 = {}
	local var_10_1 = {}

	for iter_10_0 = 0, self.childCount - 1 do
		local var_10_2 = self:GetChild(iter_10_0).gameObject

		if isActive(var_10_2) then
			local var_10_3, var_10_4, var_10_5 = var_10_2:GetComponent(typeof(HolyLightController)):GetScreenShotInfo(nil, nil)

			if var_10_3 then
				table.insert(var_10_0, var_10_4)
				table.insert(var_10_1, var_10_5)
			end
		end
	end

	return var_10_1, var_10_0
end

function Dorm3dHxHelper:HideCharacterPart(arg_11_1, arg_11_2)
	local var_11_0 = Dorm3dHxHelper.GetSkinIdByModelName(self.name)

	warning("HideCharacterPart skinId", var_11_0)

	if not var_11_0 then
		return
	end

	local var_11_1 = Dorm3dSkin.New({
		configId = var_11_0
	})

	if arg_11_2 and not var_11_1:ShouldApplyHiddenPartInTimeline() then
		return
	end

	arg_11_1 = arg_11_1 or getProxy(ApartmentProxy):getApartment((var_11_1:GetGroupId())):GetHiddenParts(var_11_0)

	local var_11_2, var_11_3 = var_11_1:GetActiveAndHiddenPartNames(arg_11_1)

	_.each(var_11_2, function(arg_12_0)
		setActive(self:Find(arg_12_0), true)

		return
	end)
	_.each(var_11_3, function(arg_13_0)
		setActive(self:Find(arg_13_0), false)

		return
	end)

	return
end

return Dorm3dHxHelper
