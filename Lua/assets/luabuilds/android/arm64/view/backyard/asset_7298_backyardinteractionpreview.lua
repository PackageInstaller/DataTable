local BackYardInteractionPreview = class("BackYardInteractionPreview")
local var_0_1 = 0.5

function BackYardInteractionPreview:Ctor(arg_1_1, arg_1_2)
	self.container = arg_1_1
	self.initPosition = arg_1_2

	return
end

function BackYardInteractionPreview:Flush(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if self.furnitureId == arg_2_2 and self.shipSkinId == arg_2_1 then
		return
	end

	self.scale = arg_2_3 or 1
	self.position = arg_2_4 and Vector3(arg_2_4[1], arg_2_4[2], 0) or self.initPosition

	self:StartLoad(arg_2_1, arg_2_2)

	self.shipSkinId = arg_2_1
	self.furnitureId = arg_2_2

	return
end

function BackYardInteractionPreview:StartLoad(arg_3_1, arg_3_2)
	self:UnloadSpines()
	pg.UIMgr.GetInstance():LoadingOn()
	seriesAsync({
		function(arg_4_0)
			self:LoadFurniture(arg_3_2, arg_4_0)

			return
		end,
		function(arg_5_0)
			self:LoadShip(arg_3_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			self:StartInteraction(arg_3_2, arg_3_1, arg_6_0)

			return
		end
	}, function()
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function BackYardInteractionPreview:LoadShip(arg_8_1, arg_8_2)
	local var_8_0 = pg.ship_skin_template[arg_8_1].prefab

	self.loadedShip = SpineAnimChar.New()

	self.loadedShip:SetPaint(pg.ship_skin_template[arg_8_1].prefab)
	self.loadedShip:Load(true, function(arg_9_0)
		if self.loadedAnimator then
			arg_9_0:SetParent(self.loadedAnimator)
		else
			arg_9_0:SetParent(self.loadedFurniture)
		end

		arg_9_0:SetName(var_8_0)
		arg_9_0:SetLocalScale(Vector3(var_0_1, var_0_1, 1))
		arg_9_0:SetLocalPosition(Vector3())
		arg_8_2()

		return
	end)

	return
end

function BackYardInteractionPreview:LoadFurniture(arg_10_1, arg_10_2)
	local var_10_0 = pg.furniture_data_template[arg_10_1].spine[1][1]
	local var_10_1

	if pg.furniture_data_template[arg_10_1].spine[2] then
		var_10_1 = pg.furniture_data_template[arg_10_1].spine[2][1]
	end

	local var_10_2

	if pg.furniture_data_template[arg_10_1].animator and pg.furniture_data_template[arg_10_1].animator[1] then
		var_10_2 = pg.furniture_data_template[arg_10_1].animator[1][1]
	end

	seriesAsync({
		function(arg_11_0)
			self:LoadRes("sfurniture/" .. var_10_0, function(arg_12_0)
				setParent(arg_12_0, self.container)

				self.loadedFurniture = arg_12_0

				self:AdjustTranform(arg_12_0)
				arg_11_0()

				return
			end)

			return
		end,
		function(arg_13_0)
			if not var_10_2 then
				arg_13_0()

				return
			end

			self:LoadRes("sfurniture/" .. var_10_2, function(arg_14_0)
				setActive(arg_14_0, false)
				setParent(arg_14_0, self.loadedFurniture)

				self.loadedAnimator = arg_14_0

				arg_13_0()

				return
			end)

			return
		end,
		function(arg_15_0)
			if not var_10_1 then
				arg_15_0()

				return
			end

			self:LoadRes("sfurniture/" .. var_10_1, function(arg_16_0)
				setParent(arg_16_0, self.container)

				self.loadedFurnitureMask = arg_16_0

				self:AdjustTranform(arg_16_0)
				arg_15_0()

				return
			end)

			return
		end
	}, arg_10_2)

	return
end

function BackYardInteractionPreview:AdjustTranform(arg_17_1)
	arg_17_1.transform.localScale = Vector3(self.scale, self.scale, 1)
	arg_17_1.transform.localPosition = self.position

	return
end

function BackYardInteractionPreview:StartInteraction(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = pg.furniture_data_template[arg_18_1].spine_action_replace
	local var_18_1 = {}
	local var_18_2 = {}

	for iter_18_0, iter_18_1 in ipairs(pg.furniture_data_template[arg_18_1].spine[3][2]) do
		local var_18_3
		local var_18_4

		if type(iter_18_1) == "string" then
			var_18_3 = iter_18_1
			var_18_4 = iter_18_1
		elseif type(iter_18_1) == "table" then
			var_18_4, var_18_3 = iter_18_1[1], iter_18_1[3] or iter_18_1[1]
		end

		local var_18_5, var_18_6 = self:GetReplaceAction(var_18_0, arg_18_2, var_18_4, var_18_3)

		table.insert(var_18_1, var_18_5)
		table.insert(var_18_2, var_18_6)
	end

	self:StartActions(arg_18_1, var_18_1, var_18_2)
	arg_18_3()

	return
end

function BackYardInteractionPreview:GetReplaceAction(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	if not arg_19_1 or arg_19_1 == "" or #arg_19_1 == 0 then
		return arg_19_3, arg_19_4
	end

	local var_19_0 = _.detect(arg_19_1, function(arg_20_0)
		return _.any(arg_20_0[2], function(arg_21_0)
			return arg_21_0 == arg_19_2
		end) and arg_19_4 == arg_20_0[1] and arg_20_0[5] == 1
	end)

	if var_19_0 then
		local var_19_1 = var_19_0[4] or 0

		if var_19_1 == 0 then
			return var_19_0[3], var_19_0[3]
		elseif var_19_1 == 1 then
			return arg_19_3, var_19_0[3]
		elseif var_19_1 == 2 then
			return var_19_0[3], arg_19_4
		end
	else
		return arg_19_3, arg_19_4
	end

	return
end

function BackYardInteractionPreview:StartActions(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = 1
	local var_22_1 = 0
	local var_22_2

	local function var_22_3()
		var_22_1 = var_22_1 + 1

		if var_22_1 == 3 then
			var_22_1, var_22_0 = 0, var_22_0 + 1

			var_22_2(var_22_0)
		end

		return
	end

	function var_22_2(arg_24_0)
		if arg_24_0 > #arg_22_2 then
			if self.loadedAnimator then
				setActive(self.loadedAnimator, false)
			end

			return
		end

		local var_24_0 = arg_22_2[arg_24_0]
		local var_24_1 = arg_22_3[arg_24_0]

		self:PlayAction(self.loadedFurniture.transform:Find("spine"), arg_22_2[arg_24_0], var_22_3)

		if self.loadedFurnitureMask then
			self:PlayAction(self.loadedFurniture.transform:Find("spine"), var_24_0, var_22_3)
		else
			var_22_3()
		end

		self:PlayAction(self.loadedShip, var_24_1, var_22_3)

		return
	end

	;(nil)(1)

	if self.loadedAnimator then
		setActive(self.loadedAnimator, true)
	else
		self:StartFollowBone(arg_22_1)
	end

	return
end

function BackYardInteractionPreview:StartFollowBone(arg_25_1)
	if not pg.furniture_data_template[arg_25_1].followBone then
		return
	end

	local var_25_0 = pg.furniture_data_template[arg_25_1].followBone[1]

	self.loadedShip:SetLocalScale(Vector3(pg.furniture_data_template[arg_25_1].followBone[2] * var_0_1, var_0_1, 1))

	SpineAnimUI.AddFollower(var_25_0, self.loadedFurniture.transform:Find("spine"), self.loadedShip.transform):GetComponent("Spine.Unity.BoneFollowerGraphic").followLocalScale = true

	self.loadedShip:SetLocalPosition(Vector3(0, 0, 0))

	return
end

function BackYardInteractionPreview:PlayAction(arg_26_1, arg_26_2, arg_26_3)
	arg_26_1:SetActionCallBack(function(arg_27_0)
		if arg_27_0 == "finish" then
			arg_26_1:SetActionCallBack(nil)
			arg_26_3()
		end

		return
	end)
	arg_26_1:SetAction(arg_26_2, 0)

	return
end

function BackYardInteractionPreview:UnloadSpines()
	if not IsNil(self.loadedShip) then
		self.loadedShip:Dispose()
	end

	if not IsNil(self.loadedAnimator) then
		Object.Destroy(self.loadedAnimator)
	end

	if not IsNil(self.loadedFurniture) then
		Object.Destroy(self.loadedFurniture)
	end

	if not IsNil(self.loadedFurnitureMask) then
		Object.Destroy(self.loadedFurnitureMask)
	end

	self.shipSkinId = nil
	self.furnitureId = nil

	return
end

function BackYardInteractionPreview:Dispose()
	self:UnloadSpines()

	return
end

function BackYardInteractionPreview:LoadRes(arg_30_1, arg_30_2)
	ResourceMgr.Inst:getAssetAsync(arg_30_1, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_31_0)
		arg_30_2(Instantiate(arg_31_0))

		return
	end), true, true)

	return
end

return BackYardInteractionPreview
