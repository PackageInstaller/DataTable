local var_0_0 = {}
local var_0_1 = {
	ThingAttach = "ThingAttach",
	Point = "Point",
	RoleAttach = "RoleAttach"
}
local var_0_2 = {
	DelayTime = "DelayTime",
	Event = "Event",
	DontDestroy = "DontDestroy"
}

function var_0_0.Inject(arg_1_0, arg_1_1)
	arg_1_1.effectContext = {
		maxId = 1,
		effectMap = {},
		effectBundle = {}
	}

	local var_1_0 = arg_1_1.effectContext
	local var_1_1 = arg_1_1.blackboardObj.transform:Find("Dynamic")

	if isNil(var_1_1) then
		local var_1_2 = GameObject.New("Dynamic")

		var_1_2.transform.parent = arg_1_1.blackboardObj.transform
		var_1_2.transform.localPosition = Vector3.zero
		var_1_2.transform.localRotation = Quaternion.identity
		var_1_2.transform.localScale = Vector3.one
		arg_1_1.effectContext.root = var_1_2
		var_1_1 = var_1_2.transform
	end

	function arg_1_1.AcquireEffect(arg_2_0, arg_2_1)
		var_1_0.effectBundle[arg_2_1.path] = var_1_0.effectBundle[arg_2_1.path] or {
			ref = 0,
			obj = Asset.Load(arg_2_1.path)
		}
		arg_2_1.obj = GameObject.Instantiate(var_1_0.effectBundle[arg_2_1.path].obj, var_1_1)
		var_1_0.effectBundle[arg_2_1.path].ref = var_1_0.effectBundle[arg_2_1.path].ref + 1
		var_1_0.maxId = var_1_0.maxId + 1
		var_1_0.effectMap[var_1_0.maxId] = arg_2_1

		return var_1_0.maxId
	end

	function arg_1_1:InstEffectAction(arg_3_1)
		local var_3_0 = self:AcquireEffect(arg_3_1)

		if arg_3_1.createMode == var_0_1.Point then
			local var_3_1 = self.blackboard:GetPoint(arg_3_1.pointTag)

			if not isNil(var_3_1) then
				arg_3_1.obj.transform.position = var_3_1.position
				arg_3_1.obj.transform.rotation = var_3_1.rotation
				arg_3_1.obj.transform.localScale = var_3_1.localScale
			end
		elseif arg_3_1.createMode == var_0_1.RoleAttach then
			local var_3_2 = self:LoadActor(arg_3_1.roleId):GetAttachPoint(arg_3_1.attachType)

			if not isNil(var_3_2) then
				if arg_3_1.attachFollow then
					arg_3_1.obj.transform.parent = var_3_2
					arg_3_1.obj.transform.localPosition = Vector3.zero
					arg_3_1.obj.transform.localRotation = Quaternion.identity
					arg_3_1.obj.transform.localScale = Vector3.one
				else
					local var_3_3 = arg_3_1.obj.transform

					var_3_3.position = var_3_2.position
					var_3_3.rotation = var_3_2.rotation
					var_3_3.localScale = var_3_2.localScale
				end
			end
		elseif arg_3_1.createMode == var_0_1.ThingAttach then
			local var_3_4 = self.blackboard:GetThing(arg_3_1.thingId):GetAttachPoint(arg_3_1.attachPoint)

			if arg_3_1.attachFollow then
				arg_3_1.obj.transform.parent = var_3_4
				arg_3_1.obj.transform.localPosition = Vector3.zero
				arg_3_1.obj.transform.localRotation = Quaternion.identity
				arg_3_1.obj.transform.localScale = Vector3.one
			else
				local var_3_5 = arg_3_1.obj.transform

				var_3_5.position = var_3_4.position
				var_3_5.rotation = var_3_4.rotation
				var_3_5.localScale = var_3_4.localScale
			end
		end

		if arg_3_1.destroyMode == var_0_2.DelayTime then
			local var_3_6 = self:AddAutoTask(QWStoryConst.StoryNodeTaskType.DestroyEffect)

			self:RegisterDelayAction(function()
				self:RemoveEffect(var_3_0)
				var_3_6.Complete()
			end, arg_3_1.delayTime)
		elseif arg_3_1.destroyMode == var_0_2.Event then
			self:RegisterEvent(arg_3_1.event, function()
				self:RemoveEffect(var_3_0)
				self:UnRegisterEvent(arg_3_1.event)
			end)
		end
	end

	function arg_1_1.RemoveEffect(arg_6_0, arg_6_1)
		if var_1_0.effectMap[arg_6_1] then
			if not isNil(var_1_0.effectMap[arg_6_1].obj) then
				GameObject.Destroy(var_1_0.effectMap[arg_6_1].obj)
			end

			local var_6_0 = var_1_0.effectBundle[var_1_0.effectMap[arg_6_1].path]

			var_6_0.ref = var_1_0.effectBundle[var_1_0.effectMap[arg_6_1].path].ref - 1

			if var_6_0.ref <= 0 then
				Asset.Unload(var_1_0.effectMap[arg_6_1].path)

				var_1_0.effectBundle[var_1_0.effectMap[arg_6_1].path] = nil
			end

			var_1_0.effectMap[arg_6_1] = nil
		end
	end

	function arg_1_1.DisposeEffect(arg_7_0)
		for iter_7_0, iter_7_1 in pairs(var_1_0.effectBundle) do
			if not isNil(iter_7_1.obj) then
				Asset.Unload(iter_7_0)
			end
		end

		arg_7_0.effectContext = {
			maxId = 1,
			effectMap = {},
			effectBundle = {}
		}
	end

	function arg_1_1:BlackFadeAction(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
		local var_8_0 = self:AddAutoTask(QWStoryConst.StoryNodeTaskType.BlackFadeEffect)

		QWorldMgr:GetQWorldStoryMgr():GetTalkView():BlackFadeEffect(arg_8_1, arg_8_2, arg_8_3, function()
			if arg_8_4 then
				arg_8_4()
			end

			var_8_0.Complete()
		end, function()
			if arg_8_5 then
				arg_8_5()
			end
		end)
	end
end

return var_0_0
