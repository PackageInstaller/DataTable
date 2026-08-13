class = var_0_10000

local var_0_0 = var_0_10000("Dorm3dHxHelper")

function var_0_0.GetTimelineMainCharacter()
	GameObject = var_1_10000

	local var_1_0 = var_1_10000.Find("[actor]").transform
	local var_1_1

	table = var_2

	local var_1_2 = var_2.IpairsCArray
	local var_1_3 = var_1_0
	local var_1_4 = var_1_0.GetComponentsInChildren

	typeof = var_1_10007

	var_1_2(var_1_4(var_1_3, var_1_10007("BLHXCharacterPropertiesController")), function(arg_2_0, arg_2_1)
		if arg_2_0 == 0 or var_0_0.GetSkinIdByModelName(arg_2_1.gameObject.name) then
			var_1_1 = arg_2_1.transform
		end

		return
	end)

	return var_1_1
end

function var_0_0.GetSkinIdByModelName(arg_3_0)
	string = var_1_10001
	arg_3_0 = var_1_10001.gsub(arg_3_0, "%s*%(Clone%)$", "")
	ipairs = var_1
	pg = var_3

	for iter_3_0, iter_3_1 in var_1(var_3.dorm3d_resource.all) do
		pg = var_1_10006

		if var_1_10006.dorm3d_resource[iter_3_1].origin_model == arg_3_0 or var_1_10006.model_id == arg_3_0 then
			return iter_3_1
		end
	end

	return nil
end

function var_0_0.ReplaceCharacterParts(arg_4_0)
	HXSet = var_1_10001

	if not var_1_10001.isHx() then
		return false
	end

	if not var_0_0.GetSkinIdByModelName(arg_4_0.name) then
		return false
	end

	pg = var_1_10002

	if not var_1_10002.dorm3d_resource[var_1].hx_component or var_2 == "" or #var_2 == 0 then
		return false
	end

	local var_4_0 = false

	_ = var_1_10004

	var_1_10004.each(var_2, function(arg_5_0)
		checkABExist = var_2_10001

		if not var_2_10001(arg_5_0) then
			warning = var_1

			var_1("要替换的部件不存在", arg_5_0)

			return
		end

		GraphicsInterface = var_1

		local var_5_0 = var_1.Instance
		local var_5_1 = var_1.LoadCharacterComponent

		go = var_2_10004

		var_5_1(var_5_0, var_2_10004(arg_4_0), arg_5_0)

		warning = var_5_1

		var_5_1("ReplaceCharacterPart", arg_5_0)

		var_4_0 = true

		return
	end)

	return var_4_0
end

function var_0_0.ShowHolyLight(arg_6_0, arg_6_1, arg_6_2)
	HXSet = var_1_10003

	if not var_1_10003.isHx() then
		return false
	end

	arg_6_2 = arg_6_2 or false

	local var_6_0 = {}

	ipairs = var_1_10004

	for iter_6_0, iter_6_1 in var_1_10004(arg_6_0) do
		if iter_6_1 and var_0_0.GetSkinIdByModelName(iter_6_1.name) then
			ipairs = var_1_10010
			pg = var_1_10012

			if not var_1_10012.dorm3d_holylight.get_id_list_by_skin_id[var_9] then
				var_1_10012 = {}
			end

			for iter_6_2, iter_6_3 in var_1_10010(var_1_10012) do
				table = var_1_10015
				var_1_10015 = var_1_10015.insert

				local var_6_1 = var_6_0
				local var_6_2 = {
					iter_6_1
				}

				pg = var_1_10019
				var_6_2[2] = var_1_10019.dorm3d_holylight[iter_6_3]

				var_1_10015(var_6_1, var_6_2)
			end
		end
	end

	UIItemList = var_4

	var_4.StaticAlign(arg_6_1, arg_6_1:GetChild(0), #var_6_0, function(arg_7_0, arg_7_1, arg_7_2)
		unpack = var_2_10003

		local var_7_0, var_7_1 = var_2_10003(var_6_0[arg_7_1 + 1])
		local var_7_2 = arg_7_2
		local var_7_3 = arg_7_2.GetComponent

		typeof = var_2_10008
		HolyLightController = var_2_10010

		local var_7_4 = var_7_3(var_7_2, var_2_10008(var_2_10010))
		local var_7_5 = var_7_0

		var_7_4.targetBone = var_7_0.Find(var_7_5, var_7_1.target_bone)
		Vector3 = var_6
		unpack = var_7_5
		var_7_4.localAxis = var_6(var_7_5(var_7_1.axis))
		var_7_4.invertAxis = var_7_1.invert ~= 0
		var_7_4.defaultAxisThreshold = var_7_1.default_threshold
		var_7_4.axisThreshold = var_7_4.defaultAxisThreshold
		Vector3 = var_6
		unpack = var_8
		var_7_4.rotationOffset = var_6(var_8(var_7_1.rotation_offset))
		GetSpriteFromAtlasAsync = var_6

		var_6(var_7_1.texture, "", function(arg_8_0)
			local var_8_0 = arg_7_2
			local var_8_1 = var_1.GetComponent

			typeof = var_3_10004
			Image = var_3_10006

			local var_8_2 = var_8_1(var_8_0, var_3_10004(var_3_10006))

			var_8_2.sprite = arg_8_0
			Color = var_3_10002

			local var_8_3 = var_3_10002.New

			unpack = var_4
			var_8_2.color = var_8_3(var_4(var_7_1.color))

			return
		end)

		Vector2 = var_6
		unpack = var_8
		var_7_4.baseSize = var_6(var_8(var_7_1.base_size))
		var_7_4.useRaycastOcclusion = arg_6_2
		GetOrAddComponent = var_6

		local var_7_6 = var_7_0

		typeof = var_9
		DormAnimationEventDispatcher = var_2_10011
		var_7_4.targetDispatcher = var_6(var_7_6, var_9(var_2_10011))

		return
	end)

	return
end

function var_0_0.SetModelHolyLightActive(arg_9_0, arg_9_1, arg_9_2)
	HXSet = var_1_10003

	if not var_1_10003.isHx() then
		return false
	end

	if arg_9_0 then
		IsNil = var_3

		if not var_3(arg_9_0) and arg_9_1 then
			IsNil = var_3

			if var_3(arg_9_1) then
				return false
			end

			local var_9_0 = false

			for iter_9_0 = 0, arg_9_1.childCount - 1 do
				local var_9_1 = arg_9_1:GetChild(iter_9_0)
				local var_9_2 = var_8.GetComponent

				typeof = var_1_10012
				HolyLightController = var_1_10014

				if var_9_2(var_9_1, var_1_10012(var_1_10014)) and var_9.targetBone then
					IsNil = var_9_1

					if not var_9_1(var_10) and var_10:IsChildOf(arg_9_0) then
						setActive = var_11

						var_11(var_8, arg_9_2)

						var_9_0 = true
					end
				end
			end

			return var_9_0
		end
	end
end

function var_0_0.GetHolyLightScreenShotInfo(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = {}

	for iter_10_0 = 0, arg_10_0.childCount - 1 do
		local var_10_2 = arg_10_0:GetChild(iter_10_0).gameObject

		isActive = var_1_10008

		if var_1_10008(var_10_2) then
			local var_10_3 = var_10_2

			var_1_10008 = var_10_2.GetComponent
			typeof = var_1_10011
			HolyLightController = var_1_10013

			local var_10_4 = var_1_10008(var_10_3, var_1_10011(var_1_10013))
			local var_10_5, var_10_6

			var_1_10008, var_10_5, var_10_6 = var_1_10008.GetScreenShotInfo(var_10_4, nil, nil)

			if var_1_10008 then
				table = var_1_10011

				var_1_10011.insert(var_10_0, var_10_5)

				table = var_1_10011

				var_1_10011.insert(var_10_1, var_10_6)
			end
		end
	end

	return var_10_1, var_10_0
end

function var_0_0.HideCharacterPart(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = var_0_0.GetSkinIdByModelName(arg_11_0.name)

	warning = var_1_10004

	var_1_10004("HideCharacterPart skinId", var_11_0)

	if not var_11_0 then
		return
	end

	Dorm3dSkin = var_1_10004

	local var_11_1 = var_1_10004.New({
		configId = var_11_0
	})

	if arg_11_2 and not var_11_1:ShouldApplyHiddenPartInTimeline() then
		return
	end

	local var_11_2 = var_11_1:GetGroupId()

	if not arg_11_1 then
		getProxy = var_6
		ApartmentProxy = var_1_10008

		local var_11_3 = var_6(var_1_10008)
		local var_11_4 = var_6.getApartment(var_11_3, var_11_2)

		arg_11_1 = var_6.GetHiddenParts(var_11_4, var_11_0)
	end

	local var_11_5 = var_11_1
	local var_11_6, var_11_7 = var_11_1.GetActiveAndHiddenPartNames(var_11_5, arg_11_1)

	_ = var_11_5

	var_11_5.each(var_11_6, function(arg_12_0)
		setActive = var_2_10001

		local var_12_0 = arg_11_0

		var_2_10001(var_3.Find(var_12_0, arg_12_0), true)

		return
	end)

	_ = var_8

	var_8.each(var_11_7, function(arg_13_0)
		setActive = var_2_10001

		local var_13_0 = arg_11_0

		var_2_10001(var_3.Find(var_13_0, arg_13_0), false)

		return
	end)

	return
end

return var_0_0
