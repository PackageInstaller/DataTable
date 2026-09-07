pg = pg or {}

local var_0_0 = singletonClass("IKMgr")

pg.IKMgr = var_0_0

function var_0_0.Ctor(arg_1_0)
	arg_1_0.activeIKLayers = {}
	arg_1_0.holdingStatus = {}
	arg_1_0.cacheIKInfos = {}

	return
end

function var_0_0:RegisterEnv(arg_2_1, arg_2_2)
	self.ladyIKRoot = arg_2_1
	self.ladyBoneMaps = arg_2_2

	self:CreateUpdate()

	return
end

function var_0_0.RegisterOnIKLayerActive(arg_3_0, arg_3_1)
	arg_3_0.onIKLayerActive = arg_3_1

	return
end

function var_0_0.RegisterOnIKLayerDeactive(arg_4_0, arg_4_1)
	arg_4_0.onIKLayerDeactive = arg_4_1

	return
end

function var_0_0.RegisterOnIKLayerDrag(arg_5_0, arg_5_1)
	arg_5_0.onIKLayerDrag = arg_5_1

	return
end

function var_0_0.RegisterOnIKLayerAction(arg_6_0, arg_6_1)
	arg_6_0.onIKLayerAction = arg_6_1

	return
end

function var_0_0:UnregisterEnv()
	self.onIKLayerActive = nil
	self.onIKLayerDeactive = nil
	self.onIKLayerDrag = nil
	self.onIKLayerAction = nil

	self:ExitIKStatus()

	self.ladyIKRoot = nil
	self.ladyBoneMaps = nil

	self:DisposeUpdate()

	return
end

function var_0_0:CreateUpdate()
	if self.updateHandler then
		return
	end

	self.updateHandler = UpdateBeat:CreateListener(function()
		xpcall(function()
			self:Update()

			return
		end, function(...)
			errorMsg(debug.traceback(...))

			return
		end)

		return
	end)

	UpdateBeat:AddListener(self.updateHandler)

	return
end

function var_0_0:DisposeUpdate()
	if not self.updateHandler then
		return
	end

	UpdateBeat:RemoveListener(self.updateHandler)

	self.updateHandler = nil

	return
end

function var_0_0.SetIKStatus(arg_13_0, arg_13_1)
	arg_13_0.readyIKLayers = arg_13_1

	table.Foreach(arg_13_1, function(arg_14_0, arg_14_1)
		arg_13_0.cacheIKInfos[arg_14_1] = {}

		local var_14_0 = arg_13_0.ladyIKRoot:Find((arg_14_1:GetControllerPath())):GetComponent(typeof(RootMotion.FinalIK.IKExecutionOrder))
		local var_14_1 = {}

		table.IpairsCArray(var_14_0.IKComponents, function(arg_15_0, arg_15_1)
			var_14_1[arg_15_0 + 1] = arg_15_1:GetIKSolver()

			return
		end)

		arg_13_0.cacheIKInfos[arg_14_1].solvers = var_14_1
		arg_13_0.cacheIKInfos[arg_14_1].weights = _.map(var_14_1, function(arg_16_0)
			return arg_16_0.IKPositionWeight
		end)

		local var_14_2 = tf(var_14_0):Find("Container/SubTargets")

		table.Foreach(arg_14_1:GetSubTargets(), function(arg_17_0, arg_17_1)
			local var_17_0 = var_14_2:Find(arg_17_1.name .. "/Plane")

			var_17_0.localRotation = arg_17_1.planeRot
			var_17_0.localScale = arg_17_1.planeScale

			return
		end)

		return
	end)

	return
end

function var_0_0:ExitIKStatus()
	self:ResetAllIKLayers()

	self.readyIKLayers = nil
	self.ikHandler = nil
	self.ikRevertHandler = nil

	table.clear(self.activeIKLayers)
	table.clear(self.cacheIKInfos)
	table.clear(self.holdingStatus)

	return
end

function var_0_0:Update()
	(function()
		if not self.ikHandler then
			return
		end

		if not self.ikHandler.targetScreenOffset then
			return
		end

		local var_20_0 = self.ikHandler.rect:PointToNormalized(self.ikHandler.targetScreenOffset) - self.ikHandler.rect:PointToNormalized(Vector2.zero)

		_.each(self.ikHandler.subPlanes, function(arg_21_0)
			arg_21_0.target.position = var_0_0.GetPostionByRatio(arg_21_0.planeData, var_20_0)

			return
		end)

		return
	end)()

	if self.ikRevertHandler then
		self.ikRevertHandler()
	end

	return
end

function var_0_0:OnDragBegin(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = _.detect(self.readyIKLayers, function(arg_23_0)
		return arg_23_0:GetTriggerName() == arg_22_1
	end)

	if not var_22_0 then
		return
	end

	if not arg_22_3 and var_22_0:IsIgnoreDrag() then
		return
	end

	warning("ENABLEIK", var_22_0:GetControllerPath())

	local var_22_1 = self.ladyIKRoot:Find((var_22_0:GetControllerPath()))
	local var_22_2 = var_22_1:GetComponent(typeof(RootMotion.FinalIK.IKExecutionOrder))

	arg_22_2 = Vector2.New(arg_22_2.x / Screen.width * var_22_1.width, arg_22_2.y / Screen.height * pg.UIMgr.GetInstance().uiCamera:Find("Canvas").rect.height)

	local var_22_3 = {
		ikData = var_22_0,
		list = var_22_2
	}

	if not self.holdingStatus[var_22_0] then
		var_22_3.rect = var_22_0:GetControlRect()

		local var_22_4 = var_22_0:GetActionType()

		if var_22_4 == Dorm3dIK.ACTION_TRIGGER.RELEASE_ON_TARGET or var_22_4 == Dorm3dIK.ACTION_TRIGGER.TOUCH_TARGET then
			var_22_3.triggerRect = var_22_0:GetActionRect()
		end

		var_22_3.originScreenPosition = arg_22_2

		local var_22_5 = tf(var_22_2):Find("Container/SubTargets")
		local var_22_6 = {}

		assert(var_22_5)
		_.each(var_22_0:GetSubTargets(), function(arg_24_0)
			local var_24_0 = var_22_5:Find(arg_24_0.name)
			local var_24_1 = var_24_0:Find("Plane")
			local var_24_2 = var_24_0:Find("Target")
			local var_24_3 = var_0_0.TransformMesh(var_24_1:GetComponent(typeof(UnityEngine.MeshCollider)))

			var_24_3.origin = self.ladyBoneMaps[arg_24_0.name].position
			var_24_1.position = var_0_0.GetPostionByRatio(var_24_3, (Vector2.New(var_22_3.rect.center.x / var_22_3.rect.width, var_22_3.rect.center.y / var_22_3.rect.height)))
			var_24_2.position = self.ladyBoneMaps[arg_24_0.name].position

			table.insert(var_22_6, {
				planeData = var_24_3,
				target = var_24_2
			})

			return
		end)

		var_22_3.subPlanes = var_22_6

		setActive(var_22_2, true)
	else
		var_22_3 = self.holdingStatus[var_22_0].ikHandler
		var_22_3.originScreenPosition = self.holdingStatus[var_22_0].ikHandler.originScreenPosition + (arg_22_2 - self.holdingStatus[var_22_0].ikHandler.screenPosition)
		self.holdingStatus[var_22_0] = nil
	end

	self.ikHandler = var_22_3

	existCall(self.onIKLayerActive, var_22_3)

	return
end

function var_0_0:HandleBodyDrag(arg_25_1)
	if not self.ikHandler then
		return
	end

	local var_25_0 = self.ikHandler
	local var_25_1 = pg.UIMgr.GetInstance().uiCamera:Find("Canvas").rect

	arg_25_1 = Vector2.New(arg_25_1.x / Screen.width * var_25_1.width, arg_25_1.y / Screen.height * var_25_1.height)
	var_25_0.screenPosition = arg_25_1

	local var_25_2 = arg_25_1 - var_25_0.originScreenPosition
	local var_25_3 = var_25_0.rect
	local var_25_4 = var_25_0.rect:Contains(arg_25_1 - var_25_0.originScreenPosition)

	if not var_25_4 and var_25_0.ikData:GetActionType() == Dorm3dIK.ACTION_TRIGGER.TOUCH_TARGET and var_25_0.triggerRect and var_25_0.triggerRect:Contains(arg_25_1 - var_25_0.originScreenPosition) then
		self.ikHandler = nil

		existCall(self.onIKLayerDeactive, var_25_0, true)
		table.insert(self.activeIKLayers, var_25_0.ikData)
		self:PlayIKAction(var_25_0)

		return
	end

	self.ikHandler.targetScreenOffset = (function()
		if var_25_4 then
			return var_25_2
		end

		local var_26_0 = var_25_2
		local var_26_1 = {
			{
				Vector2.New(var_25_3.xMin, var_25_3.yMin),
				Vector2.New(var_25_3.xMin, var_25_3.yMax)
			},
			{
				Vector2.New(var_25_3.xMin, var_25_3.yMax),
				Vector2.New(var_25_3.xMax, var_25_3.yMax)
			},
			{
				Vector2.New(var_25_3.xMax, var_25_3.yMax),
				Vector2.New(var_25_3.xMax, var_25_3.yMin)
			},
			{
				Vector2.New(var_25_3.xMax, var_25_3.yMin),
				Vector2.New(var_25_3.xMin, var_25_3.yMin)
			}
		}

		for iter_26_0 = 1, 4 do
			local var_26_2, var_26_3 = SegmentUtil.GetCrossPoint(var_25_3.center, var_26_0, unpack(var_26_1[iter_26_0]))

			if var_26_2 then
				return var_26_3
			end
		end

		assert(false)

		return var_26_0
	end)()

	existCall(self.onIKLayerDrag, self.ikHandler)

	return
end

function var_0_0:ReleaseDrag()
	if not self.ikHandler then
		return
	end

	local var_27_0 = self.ikHandler
	local var_27_1 = self.ikHandler.ikData
	local var_27_2
	local var_27_3 = self.ikHandler.ikData:GetActionType()

	if var_27_3 == Dorm3dIK.ACTION_TRIGGER.RELEASE then
		var_27_2 = true
	elseif var_27_3 == Dorm3dIK.ACTION_TRIGGER.RELEASE_ON_TARGET then
		if var_27_0.triggerRect and var_27_0.triggerRect:Contains(var_27_0.screenPosition - var_27_0.originScreenPosition) then
			var_27_2 = true
		end
	end

	self.ikHandler = nil

	existCall(self.onIKLayerDeactive, var_27_0, var_27_2)

	if var_27_2 then
		table.insert(self.activeIKLayers, var_27_1)
		self:PlayIKAction(var_27_0)

		return
	end

	local var_27_4 = var_27_1:GetBackTime()

	if var_27_4 < 999 then
		table.insert(self.activeIKLayers, var_27_1)
		self:PlayIKRevert(var_27_4)
	else
		self.holdingStatus[var_27_1] = {
			ikHandler = var_27_0
		}
	end

	return
end

function var_0_0:PlayIKRevert(arg_28_1, arg_28_2)
	local var_28_0 = Time.time

	function self.ikRevertHandler()
		local var_29_0 = Time.time - var_28_0

		_.each(self.activeIKLayers, function(arg_30_0)
			local var_30_0 = 1

			if arg_28_1 > 0 then
				var_30_0 = var_29_0 / arg_28_1

				local var_30_1 = self.cacheIKInfos[arg_30_0].weights
			end

			table.Foreach(self.cacheIKInfos[arg_30_0].solvers, function(arg_31_0, arg_31_1)
				arg_31_1.IKPositionWeight = math.lerp(var_30_1[arg_31_0], 0, var_30_0)

				return
			end)

			return
		end)

		if Time.time - var_28_0 >= arg_28_1 then
			self:ResetActiveIKs()

			self.ikRevertHandler = nil

			existCall(arg_28_2)
		end

		return
	end

	self.ikRevertHandler()

	return
end

function var_0_0:ResetIK(arg_32_1)
	local var_32_0 = _.detect(self.readyIKLayers, function(arg_33_0)
		return arg_33_0:GetTriggerName() == arg_32_1
	end)

	if not var_32_0 then
		return
	end

	setActive(self.ladyIKRoot:Find((var_32_0:GetControllerPath())):GetComponent(typeof(RootMotion.FinalIK.IKExecutionOrder)), false)

	local var_32_1 = self.cacheIKInfos[var_32_0].weights

	table.Foreach(self.cacheIKInfos[var_32_0].solvers, function(arg_34_0, arg_34_1)
		arg_34_1.IKPositionWeight = var_32_1[arg_34_0]

		arg_34_1:FixTransforms()

		return
	end)

	self.holdingStatus[var_32_0] = nil

	if self.moveTimer then
		self.moveTimer:Stop()

		self.moveTimer = nil
	end

	return
end

function var_0_0.ResetIKLayers(arg_35_0, arg_35_1)
	local var_35_0 = {}

	_.each(arg_35_1 or {}, function(arg_36_0)
		if not arg_36_0 or var_35_0[arg_36_0] then
			return
		end

		var_35_0[arg_36_0] = true

		local var_36_0 = arg_35_0.ladyIKRoot and arg_35_0.ladyIKRoot:Find((arg_36_0:GetControllerPath()))

		if var_36_0 and not IsNil(var_36_0) then
			setActive(var_36_0, false)
		end

		local var_36_1 = arg_35_0.cacheIKInfos[arg_36_0]

		if arg_35_0.cacheIKInfos[arg_36_0] then
			local var_36_2 = var_36_1.weights

			table.Foreach(var_36_1.solvers, function(arg_37_0, arg_37_1)
				arg_37_1.IKPositionWeight = var_36_2[arg_37_0]

				return
			end)
		end

		return
	end)

	return
end

function var_0_0:ResetAllIKLayers()
	local var_38_0 = {}

	local function var_38_1(arg_39_0)
		if not arg_39_0 then
			return
		end

		table.insert(var_38_0, arg_39_0)

		return
	end

	_.each(self.readyIKLayers or {}, var_38_1)
	_.each(self.activeIKLayers or {}, var_38_1)
	_.each(_.keys(self.holdingStatus), var_38_1)

	if self.ikHandler then
		var_38_1(self.ikHandler.ikData)
	end

	self:ResetIKLayers(var_38_0)
	table.clear(self.activeIKLayers)
	table.clear(self.holdingStatus)

	self.ikHandler = nil
	self.ikRevertHandler = nil

	if self.moveTimer then
		self.moveTimer:Stop()

		self.moveTimer = nil
	end

	return
end

function var_0_0:ResetActiveIKs()
	table.insertto(self.activeIKLayers, _.keys(self.holdingStatus))
	table.clear(self.holdingStatus)
	self:ResetIKLayers(self.activeIKLayers)
	table.clear(self.activeIKLayers)

	if self.moveTimer then
		self.moveTimer:Stop()

		self.moveTimer = nil
	end

	return
end

function var_0_0.PlayIKAction(arg_41_0, arg_41_1)
	warning("Trigger IK", arg_41_1.ikData:GetControllerPath())
	seriesAsync({
		function(arg_42_0)
			table.insertto(arg_41_0.activeIKLayers, _.keys(arg_41_0.holdingStatus))
			table.clear(arg_41_0.holdingStatus)
			arg_41_0:PlayIKRevert(arg_41_1.ikData:GetActionRevertTime(), arg_42_0)

			return
		end,
		function(arg_43_0)
			existCall(arg_41_0.onIKLayerAction, arg_41_1)

			return
		end
	})

	return
end

function var_0_0:PlayIKMove(arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5, arg_44_6)
	if self.moveTimer then
		self.moveTimer:Stop()

		self.moveTimer = nil
	end

	self.ikRevertHandler = nil

	local var_44_0 = _.detect(self.readyIKLayers, function(arg_45_0)
		return arg_45_0:GetTriggerName() == arg_44_2
	end)

	if not var_44_0 then
		existCall(arg_44_6)

		return
	end

	warning("PLAY IKMOVE", var_44_0:GetControllerPath())
	self:OnDragBegin(arg_44_2, arg_44_1, true)

	if not self.ikHandler then
		existCall(arg_44_6)

		return
	end

	local var_44_1 = Time.time + arg_44_5
	local var_44_2 = arg_44_1
	local var_44_3 = self.ikHandler.originScreenPosition + self.ikHandler.rect:NormalizedToPoint(arg_44_3) * arg_44_4

	local function var_44_4()
		if not self.ikHandler or Time.time > var_44_1 then
			self:ReleaseDrag()

			if self.moveTimer then
				self.moveTimer:Stop()

				self.moveTimer = nil
			end

			existCall(arg_44_6)

			return
		end

		local var_46_0 = Vector2.Lerp(var_44_3, var_44_2, math.max(0, var_44_1 - Time.time) / arg_44_5)
		local var_46_1 = pg.UIMgr.GetInstance().uiCamera:Find("Canvas").rect

		self:HandleBodyDrag((Vector2.New(var_46_0.x / var_46_1.width * Screen.width, var_46_0.y / var_46_1.height * Screen.height)))

		return
	end

	self.moveTimer = FrameTimer.New(var_44_4, 1, -1)

	self.moveTimer:Start()
	var_44_4()

	return
end

function var_0_0:TransformMesh()
	local var_47_0 = {}
	local var_47_1 = self.transform:TransformPoint(self.sharedMesh.vertices[0])

	var_47_0.horizontal = self.transform:TransformPoint(self.sharedMesh.vertices[1]) - var_47_1
	var_47_0.verticle = self.transform:TransformPoint(self.sharedMesh.vertices[2]) - var_47_1
	var_47_0.origin = var_47_1

	return var_47_0
end

function var_0_0:GetPostionByRatio(arg_48_1)
	return self.horizontal * arg_48_1.x + self.verticle * arg_48_1.y + self.origin
end

return
