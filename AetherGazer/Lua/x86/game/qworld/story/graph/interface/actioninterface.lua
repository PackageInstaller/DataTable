local var_0_0 = {}
local var_0_1 = {}

function var_0_0.Inject(arg_1_0, arg_1_1)
	function arg_1_1.EnableCameraCutAction(arg_2_0, arg_2_1)
		arg_2_0.blackboard:EnableCameraCut(arg_2_1)
	end

	function arg_1_1.EnableCameraByTagAction(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		arg_3_0.blackboard:EnableCameraByTag(arg_3_1, arg_3_2, arg_3_3)
	end

	function arg_1_1.BirdsGlobleCull(arg_4_0, arg_4_1)
		if not GameToSDK.IsIOSPlatform() then
			QWorldLuaBridge.BirdsGlobleCull = arg_4_1
		end
	end

	function arg_1_1.WalkingPeopleGlobleCull(arg_5_0, arg_5_1)
		QWorldLuaBridge.WalkingPeopleGlobleCull = arg_5_1
	end

	function arg_1_1.EnableCameraShakeAction(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
		if arg_6_1 then
			arg_6_0.blackboard:StartCameraShake(arg_6_2, arg_6_3, arg_6_4)

			local var_6_0 = Time.time
			local var_6_1 = {
				id = -1
			}
			local var_6_2 = arg_6_0:AddAutoTask(QWStoryConst.StoryNodeTaskType.EnableCameraShake)

			local function var_6_3(arg_7_0)
				if Time.time - var_6_0 >= arg_6_5 then
					arg_6_0:RemoveUpdateAction(var_6_1.id)
					arg_6_0.blackboard:StopCameraShake()
					var_6_2.Complete()
				end
			end

			var_6_1.id = arg_6_0:RegisterUpdateAction(var_6_3)
		else
			arg_6_0.blackboard:StopCameraShake()
		end
	end

	function arg_1_1.CameraMoveAction(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
		arg_8_0.blackboard:CameraMove(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	end

	function arg_1_1.EventAction(arg_9_0, arg_9_1)
		arg_9_1()
	end

	function arg_1_1.PlayActorAnimationAction(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
		local var_10_0 = arg_10_0:LoadActor(arg_10_1)

		if arg_10_5 then
			local var_10_1 = arg_10_0:AddAutoTask(QWStoryConst.StoryNodeTaskType.PlayActorAnimation)

			function var_10_0.OnAnimatorEnd()
				arg_10_5()
				var_10_1.Complete()
			end
		end

		var_10_0:PlayAnimaton(true, arg_10_2, arg_10_3, arg_10_4)
	end

	function arg_1_1.PlayActorEmoteAction(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6, arg_12_7)
		local var_12_0 = arg_12_0:LoadActor(arg_12_1)

		if arg_12_6 then
			if arg_12_5 then
				local var_12_1 = arg_12_0:AddAutoTask(QWStoryConst.StoryNodeTaskType.PlayActorEmote)

				function var_12_0.OnEmoteEnd()
					arg_12_5()
					var_12_1.Complete()
				end
			end

			var_12_0:PlayEmote(arg_12_2, arg_12_3, arg_12_4, arg_12_7)
		else
			if arg_12_5 then
				local var_12_2 = arg_12_0:AddAutoTask(QWStoryConst.StoryNodeTaskType.PlayActorEmote)

				function var_12_0.OnEmoteEnd()
					arg_12_5()
					var_12_2.Complete()
				end
			end

			var_12_0:EndEmote()
		end
	end

	function arg_1_1.EnableRootMotionAction(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		arg_15_0:LoadActor(arg_15_1):EnableRootmotion(arg_15_2)

		if arg_15_3 then
			arg_15_3()
		end
	end

	function arg_1_1.SetCharToTagAction(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
		local var_16_0 = arg_16_0:LoadActor(arg_16_1)
		local var_16_1 = arg_16_0.blackboard:GetPoint(arg_16_2)

		if not isNil(var_16_1) then
			var_16_0:SetTransform(var_16_1)
		end

		if arg_16_3 then
			arg_16_3()
		end
	end

	function arg_1_1.DestroyCharAction(arg_17_0, arg_17_1)
		arg_17_0:UnloadActor(arg_17_1)
	end

	function arg_1_1.ActorSeekerAction(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
		local var_18_0 = arg_18_0:LoadActor(arg_18_1)
		local var_18_1 = {}
		local var_18_2 = Vector3.zero

		for iter_18_0, iter_18_1 in ipairs(arg_18_2) do
			if iter_18_1 then
				local var_18_3 = arg_18_0.blackboard:GetPoint(iter_18_1)

				if not isNil(var_18_3) then
					table.insert(var_18_1, var_18_3.position)

					var_18_2 = var_18_3.forward
				end
			end
		end

		local var_18_4 = arg_18_0:AddAutoTask(QWStoryConst.StoryNodeTaskType.ActorSeeker)

		var_18_0:StartSeeker(var_18_2, var_18_1, arg_18_3, function()
			if arg_18_4 then
				arg_18_4()
			end

			var_18_4.Complete()
		end)
	end

	function arg_1_1.LookAtAction(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
		local var_20_0 = arg_20_0:LoadActor(arg_20_2)

		if arg_20_1 then
			local var_20_1 = arg_20_0.blackboard:GetPoint(arg_20_3)

			var_20_0:EnableLookAt(arg_20_1, var_20_1)
		else
			var_20_0:EnableLookAt(false, nil)
		end
	end

	function arg_1_1.LookAtRoleAction(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
		local var_21_0 = arg_21_0:LoadActor(arg_21_2)

		if arg_21_2 == arg_21_3 or not arg_21_1 then
			var_21_0:EnableLookAt(false, nil)
		end

		local var_21_1 = arg_21_0:LoadActor(arg_21_3)

		var_21_0:EnableLookAt(arg_21_1, var_21_1:GetHeadTrans())
	end

	function arg_1_1.RotateActorToAction(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6)
		return
	end

	function arg_1_1.SetLookAtParamsAction(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
		arg_23_0:LoadActor(arg_23_1):SetLookAtParams(arg_23_2, arg_23_3, arg_23_4)
	end

	function arg_1_1.DelayTimeAction(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = Time.time
		local var_24_1 = {
			id = -1
		}
		local var_24_2 = arg_24_0:AddAutoTask(QWStoryConst.StoryNodeTaskType.DelayTime)

		local function var_24_3(arg_25_0)
			if Time.time - var_24_0 >= arg_24_1 then
				arg_24_0:RemoveUpdateAction(var_24_1.id)

				if arg_24_2 then
					arg_24_2()
				end

				var_24_2.Complete()
			end
		end

		var_24_1.id = arg_24_0:RegisterUpdateAction(var_24_3)
	end

	function arg_1_1.HideAllDynamicAction(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
		QWorldLuaBridge.HidePlayer(arg_26_2 or false)

		if arg_26_3 then
			QWorldLuaBridge.CullingAllDynamic(arg_26_1, arg_26_4, arg_26_3)
		else
			QWorldLuaBridge.CullingAllDynamic(arg_26_1, arg_26_4)
		end
	end

	function arg_1_1.PlaySoundsAction(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
		if arg_27_1 == QWStoryConst.SoundsType.Music then
			arg_27_0.isChangeBGM = true

			manager.audio:PlayBGM(arg_27_2, arg_27_3, arg_27_4)
		elseif arg_27_1 == QWStoryConst.SoundsType.Voice then
			manager.audio:PlayVoice(arg_27_2, arg_27_3, arg_27_4)
		elseif arg_27_1 == QWStoryConst.SoundsType.Effect then
			manager.audio:PlayEffect(arg_27_2, arg_27_3, arg_27_4)
		end
	end

	function arg_1_1.StopSoundsAction(arg_28_0, arg_28_1)
		if arg_28_1 == QWStoryConst.SoundsType.Music then
			manager.audio:Stop("music")
		elseif arg_28_1 == QWStoryConst.SoundsType.Voice then
			manager.audio:Stop("voice")
		elseif arg_28_1 == QWStoryConst.SoundsType.Effect then
			manager.audio:Stop("effect")
		end
	end
end

return var_0_0
