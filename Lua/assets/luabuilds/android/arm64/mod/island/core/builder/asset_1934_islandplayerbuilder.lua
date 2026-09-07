local IslandPlayerBuilder = class("IslandPlayerBuilder", import(".IslandGenericBuilder"))

function IslandPlayerBuilder:GetModule(arg_1_1, arg_1_2)
	return IslandPlayerUnit.New(arg_1_1, arg_1_2)
end

function IslandPlayerBuilder:SetTag(arg_2_1)
	arg_2_1.tag = IslandConst.TAG_PLAYER

	return
end

function IslandPlayerBuilder:AddComponents(arg_3_1, arg_3_2)
	arg_3_1:GetComponent(typeof(WorldObjectItem)).isPlayer = true

	local var_3_0 = GetOrAddComponent(arg_3_1, typeof(CharacterController))

	var_3_0.slopeLimit = 50
	var_3_0.stepOffset = 0.3
	var_3_0.stepOffset = 0.08
	var_3_0.minMoveDistance = 0
	var_3_0.height = 1.76
	var_3_0.stepOffset = 0.4
	var_3_0.center = Vector3(0, 0.96, 0)

	GetOrAddComponent(arg_3_1, typeof(CharacterHandleController))
	GetOrAddComponent(arg_3_1, typeof(CharacterFootprintMgr))

	return
end

function IslandPlayerBuilder:LoadAsset(arg_4_1, arg_4_2)
	self:GetPoolMgr():GetCommanderModel({
		model = arg_4_1:GetAssetPath(),
		animator = arg_4_1:GetAnimator()
	}, arg_4_2)

	return
end

function IslandPlayerBuilder:LoadOtherPart(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	seriesAsync({
		function(arg_6_0)
			self:AddLoadingID((IslandAssetLoadDispatcher.Instance:Enqueue("island/jumpcurve/jumpcurve", "", typeof(JumpCurve), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_7_0)
				arg_5_2:InitJump(arg_7_0.curve)
				arg_6_0()

				return
			end), true, true)))

			return
		end,
		function(arg_8_0)
			local var_8_0 = IslandShipDressHelperNew.New()

			arg_5_2:SetShipDressHelper(var_8_0)
			var_8_0:PreLoadShipDressupItem(arg_5_1, 0, arg_8_0)

			return
		end
	}, function()
		existCall(arg_5_4)

		return
	end)

	return
end

function IslandPlayerBuilder:Recycle(arg_10_1, arg_10_2)
	self:GetPoolMgr():ReturnCommanderModel(arg_10_2)

	return
end

return IslandPlayerBuilder
