return {
	Play100 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 100
		arg_1_1.duration_ = 7.97

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play101(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.A01 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A01")
				var_4_0.name = "A01"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.A01 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.A01

				arg_1_1.bgs_.A01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A01" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = "10149ui_story"

			if arg_1_1.actors_["10149ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10149ui_story"))) then
				local var_4_5 = Object.Instantiate(Asset.Load("Char/" .. "10149ui_story"), arg_1_1.stage_.transform)

				var_4_5.name = var_4_4
				var_4_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_4] = var_4_5

				local var_4_6 = var_4_5:GetComponentInChildren(typeof(CharacterEffect))

				var_4_6.enabled = true

				local var_4_7 = GameObjectTools.GetOrAddComponent(var_4_5, typeof(DynamicBoneHelper))

				if var_4_7 then
					var_4_7:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_6.transform, false)

				arg_1_1.var_[var_4_4 .. "Animator"] = var_4_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_4 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_4 .. "LipSync"] = var_4_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_8 = arg_1_1.actors_["10149ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos10149ui_story = var_4_8.localPosition

				local var_4_9 = GameObjectTools.GetOrAddComponent(var_4_8.gameObject, typeof(DynamicBoneHelper))

				if var_4_9 then
					var_4_9:EnableDynamicBone(false)
				end
			end

			local var_4_10 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_10 then
				var_4_8.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10149ui_story, Vector3.New(0, 100, 0), (arg_1_1.time_ - 0) / var_4_10)
				var_4_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_8.position).x, (manager.ui.mainCamera.transform.position - var_4_8.position).y, (manager.ui.mainCamera.transform.position - var_4_8.position).z)
				var_4_8.localEulerAngles.z = 0
				var_4_8.localEulerAngles.x = 0
				var_4_8.localEulerAngles = var_4_8.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_10 and arg_1_1.time_ < 0 + var_4_10 + arg_4_0 then
				var_4_8.localPosition = Vector3.New(0, 100, 0)
				var_4_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_8.position).x, (manager.ui.mainCamera.transform.position - var_4_8.position).y, (manager.ui.mainCamera.transform.position - var_4_8.position).z)
				var_4_8.localEulerAngles.z = 0
				var_4_8.localEulerAngles.x = 0
				var_4_8.localEulerAngles = var_4_8.localEulerAngles

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_8.gameObject, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(true)
				end
			end

			local var_4_12 = arg_1_1.actors_["10149ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.characterEffect10149ui_story == nil then
				arg_1_1.var_.characterEffect10149ui_story = var_4_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_13 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.characterEffect10149ui_story and not isNil(var_4_12) then
					arg_1_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.characterEffect10149ui_story then
				arg_1_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action1_1")
			end

			local var_4_15 = "10103ui_story"

			if arg_1_1.actors_["10103ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10103ui_story"))) then
				local var_4_16 = Object.Instantiate(Asset.Load("Char/" .. "10103ui_story"), arg_1_1.stage_.transform)

				var_4_16.name = var_4_15
				var_4_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_15] = var_4_16

				local var_4_17 = var_4_16:GetComponentInChildren(typeof(CharacterEffect))

				var_4_17.enabled = true

				local var_4_18 = GameObjectTools.GetOrAddComponent(var_4_16, typeof(DynamicBoneHelper))

				if var_4_18 then
					var_4_18:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_17.transform, false)

				arg_1_1.var_[var_4_15 .. "Animator"] = var_4_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_15 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_15 .. "LipSync"] = var_4_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_4_19 = "10049ui_story"

			if arg_1_1.actors_["10049ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10049ui_story"))) then
				local var_4_20 = Object.Instantiate(Asset.Load("Char/" .. "10049ui_story"), arg_1_1.stage_.transform)

				var_4_20.name = var_4_19
				var_4_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_19] = var_4_20

				local var_4_21 = var_4_20:GetComponentInChildren(typeof(CharacterEffect))

				var_4_21.enabled = true

				local var_4_22 = GameObjectTools.GetOrAddComponent(var_4_20, typeof(DynamicBoneHelper))

				if var_4_22 then
					var_4_22:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_21.transform, false)

				arg_1_1.var_[var_4_19 .. "Animator"] = var_4_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_19 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_19 .. "LipSync"] = var_4_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_23 = arg_1_1.actors_["10049ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos10049ui_story = var_4_23.localPosition

				local var_4_24 = GameObjectTools.GetOrAddComponent(var_4_23.gameObject, typeof(DynamicBoneHelper))

				if var_4_24 then
					var_4_24:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(arg_1_1.var_["10049ui_story" .. "Animator"].transform, false)
			end

			local var_4_25 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_25 then
				var_4_23.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10049ui_story, Vector3.New(0, 100, 0), (arg_1_1.time_ - 0) / var_4_25)
				var_4_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_23.position).x, (manager.ui.mainCamera.transform.position - var_4_23.position).y, (manager.ui.mainCamera.transform.position - var_4_23.position).z)
				var_4_23.localEulerAngles.z = 0
				var_4_23.localEulerAngles.x = 0
				var_4_23.localEulerAngles = var_4_23.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_25 and arg_1_1.time_ < 0 + var_4_25 + arg_4_0 then
				var_4_23.localPosition = Vector3.New(0, 100, 0)
				var_4_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_23.position).x, (manager.ui.mainCamera.transform.position - var_4_23.position).y, (manager.ui.mainCamera.transform.position - var_4_23.position).z)
				var_4_23.localEulerAngles.z = 0
				var_4_23.localEulerAngles.x = 0
				var_4_23.localEulerAngles = var_4_23.localEulerAngles

				local var_4_26 = GameObjectTools.GetOrAddComponent(var_4_23.gameObject, typeof(DynamicBoneHelper))

				if var_4_26 then
					var_4_26:EnableDynamicBone(true)
				end
			end

			local var_4_27 = arg_1_1.actors_["10049ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_27) and arg_1_1.var_.characterEffect10049ui_story == nil then
				arg_1_1.var_.characterEffect10049ui_story = var_4_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_28 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_28 and not isNil(var_4_27) then
				if arg_1_1.var_.characterEffect10049ui_story and not isNil(var_4_27) then
					arg_1_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_28 and arg_1_1.time_ < 0 + var_4_28 + arg_4_0 and not isNil(var_4_27) and arg_1_1.var_.characterEffect10049ui_story then
				arg_1_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action1_1")
			end

			local var_4_30 = "10150ui_story"

			if arg_1_1.actors_["10150ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10150ui_story"))) then
				local var_4_31 = Object.Instantiate(Asset.Load("Char/" .. "10150ui_story"), arg_1_1.stage_.transform)

				var_4_31.name = var_4_30
				var_4_31.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_30] = var_4_31

				local var_4_32 = var_4_31:GetComponentInChildren(typeof(CharacterEffect))

				var_4_32.enabled = true

				local var_4_33 = GameObjectTools.GetOrAddComponent(var_4_31, typeof(DynamicBoneHelper))

				if var_4_33 then
					var_4_33:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_32.transform, false)

				arg_1_1.var_[var_4_30 .. "Animator"] = var_4_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_30 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_30 .. "LipSync"] = var_4_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_4_34 = arg_1_1.actors_["10103ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos10103ui_story = var_4_34.localPosition

				local var_4_35 = GameObjectTools.GetOrAddComponent(var_4_34.gameObject, typeof(DynamicBoneHelper))

				if var_4_35 then
					var_4_35:EnableDynamicBone(false)
				end
			end

			local var_4_36 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_36 then
				var_4_34.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_1_1.time_ - 0) / var_4_36)
				var_4_34.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_34.position).x, (manager.ui.mainCamera.transform.position - var_4_34.position).y, (manager.ui.mainCamera.transform.position - var_4_34.position).z)
				var_4_34.localEulerAngles.z = 0
				var_4_34.localEulerAngles.x = 0
				var_4_34.localEulerAngles = var_4_34.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_36 and arg_1_1.time_ < 0 + var_4_36 + arg_4_0 then
				var_4_34.localPosition = Vector3.New(0, 100, 0)
				var_4_34.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_34.position).x, (manager.ui.mainCamera.transform.position - var_4_34.position).y, (manager.ui.mainCamera.transform.position - var_4_34.position).z)
				var_4_34.localEulerAngles.z = 0
				var_4_34.localEulerAngles.x = 0
				var_4_34.localEulerAngles = var_4_34.localEulerAngles

				local var_4_37 = GameObjectTools.GetOrAddComponent(var_4_34.gameObject, typeof(DynamicBoneHelper))

				if var_4_37 then
					var_4_37:EnableDynamicBone(true)
				end
			end

			local var_4_38 = arg_1_1.actors_["10103ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect10103ui_story == nil then
				arg_1_1.var_.characterEffect10103ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_39 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_39 and not isNil(var_4_38) then
				if arg_1_1.var_.characterEffect10103ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_39 and arg_1_1.time_ < 0 + var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect10103ui_story then
				arg_1_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			local var_4_41 = "10130ui_story"

			if arg_1_1.actors_["10130ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10130ui_story"))) then
				local var_4_42 = Object.Instantiate(Asset.Load("Char/" .. "10130ui_story"), arg_1_1.stage_.transform)

				var_4_42.name = var_4_41
				var_4_42.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_41] = var_4_42

				local var_4_43 = var_4_42:GetComponentInChildren(typeof(CharacterEffect))

				var_4_43.enabled = true

				local var_4_44 = GameObjectTools.GetOrAddComponent(var_4_42, typeof(DynamicBoneHelper))

				if var_4_44 then
					var_4_44:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_43.transform, false)

				arg_1_1.var_[var_4_41 .. "Animator"] = var_4_43.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_41 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_41 .. "LipSync"] = var_4_43.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("10130ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_45 = arg_1_1.var_.effectxiaxuetexiao1

				if not arg_1_1.var_.effectxiaxuetexiao1 then
					var_4_45 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snowfast_keep"), manager.ui.mainCamera.transform)
					var_4_45.name = "xiaxuetexiao1"
					arg_1_1.var_.effectxiaxuetexiao1 = var_4_45
				else
					var_4_45.transform:SetParent(var_4_9000)
				end

				var_4_45.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_45.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play101 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 101
		arg_5_1.duration_ = 10.93

		SetActive(arg_5_1.tipsGo_, false)

		function arg_5_1.onSingleLineFinish_()
			arg_5_1.onSingleLineUpdate_ = nil
			arg_5_1.onSingleLineFinish_ = nil
			arg_5_1.state_ = "waiting"
		end

		function arg_5_1.playNext_(arg_7_0)
			if arg_7_0 == 1 then
				arg_5_0:Play102(arg_5_1)
			end
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			local var_8_9000

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= 0 + arg_8_0 then
				if arg_5_1.var_.effectxiaxuetexiao1 then
					Object.Destroy(arg_5_1.var_.effectxiaxuetexiao1)

					arg_5_1.var_.effectxiaxuetexiao1 = nil
				end
			end

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= 0 + arg_8_0 then
				local var_8_1 = arg_5_1.var_.effectxiaxuetexiao2

				if not arg_5_1.var_.effectxiaxuetexiao2 then
					var_8_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snowfast_out"), manager.ui.mainCamera.transform)
					var_8_1.name = "xiaxuetexiao2"
					arg_5_1.var_.effectxiaxuetexiao2 = var_8_1
				else
					var_8_1.transform:SetParent(var_8_9000)
				end

				var_8_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_8_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_8_3 = 0
			local var_8_4 = 1.43333333333333

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= var_8_3 + arg_8_0 then
				arg_5_1.talkMaxDuration = 0

				arg_5_1.dialog_:SetActive(true)

				arg_5_1.dialogCg_.alpha = 0

				local var_8_5 = LeanTween.value(arg_5_1.dialog_, 0, 1, 0.3)

				var_8_5:setOnUpdate(LuaHelper.FloatAction(function(arg_9_0)
					arg_5_1.dialogCg_.alpha = arg_9_0
				end))
				var_8_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_5_1.dialog_)
					var_8_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_5_1.duration_ = arg_5_1.duration_ + 0.3

				SetActive(arg_5_1.leftNameGo_, false)

				arg_5_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_5_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_5_1:RecordName(arg_5_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_5_1.iconTrs_.gameObject, true)
				arg_5_1.iconController_:SetSelectedState("hero")

				arg_5_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_5_1.callingController_:SetSelectedState("normal")

				arg_5_1.keyicon_.color = Color.New(1, 1, 1)
				arg_5_1.icon_.color = Color.New(1, 1, 1)

				local var_8_6 = arg_5_1:FormatText(arg_5_1:GetWordFromCfg(100).content)

				arg_5_1.text_.text = var_8_6

				LuaForUtil.ClearLinePrefixSymbol(arg_5_1.text_)

				local var_8_8 = 4 <= 0 and var_8_4 or var_8_4 * (utf8.len(var_8_6) / 4)

				if (4 <= 0 and var_8_4 or var_8_4 * (utf8.len(var_8_6) / 4)) > 0 and var_8_4 < var_8_8 then
					arg_5_1.talkMaxDuration = var_8_8
					var_8_3 = var_8_3 + 0.3

					if var_8_8 + var_8_3 > arg_5_1.duration_ then
						arg_5_1.duration_ = var_8_8 + var_8_3
					end
				end

				arg_5_1.text_.text = var_8_6
				arg_5_1.typewritter.percent = 0

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(false)
				arg_5_1:RecordContent(arg_5_1.text_.text)
			end

			local var_8_9 = var_8_3 + 0.3
			local var_8_10 = math.max(var_8_4, arg_5_1.talkMaxDuration)

			if var_8_3 + 0.3 <= arg_5_1.time_ and arg_5_1.time_ < var_8_9 + var_8_10 then
				arg_5_1.typewritter.percent = (arg_5_1.time_ - var_8_9) / var_8_10

				arg_5_1.typewritter:SetDirty()
			end

			if arg_5_1.time_ >= var_8_9 + var_8_10 and arg_5_1.time_ < var_8_9 + var_8_10 + arg_8_0 then
				arg_5_1.typewritter.percent = 1

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(true)
			end
		end

		arg_5_1.nodeConfigList_ = {
			{
				groupID = "100",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_5_1:InitPlayNodeList()
	end,
	Play102 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 102
		arg_11_1.duration_ = 5.37

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play103(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if arg_11_1.bgs_.B02f == nil then
				local var_14_0 = Object.Instantiate(arg_11_1.paintGo_)

				var_14_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B02f")
				var_14_0.name = "B02f"
				var_14_0.transform.parent = arg_11_1.stage_.transform
				var_14_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.bgs_.B02f = var_14_0
			end

			if 0.5 < arg_11_1.time_ and arg_11_1.time_ <= 0.5 + arg_14_0 then
				local var_14_1 = arg_11_1.bgs_.B02f

				arg_11_1.bgs_.B02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_14_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_14_2 = var_14_1:GetComponent("SpriteRenderer")

				if var_14_2 and var_14_2.sprite then
					local var_14_3 = 2 * (var_14_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_14_1.transform.localScale = Vector3.New(var_14_3 / var_14_2.sprite.bounds.size.y < var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x and var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x or var_14_3 / var_14_2.sprite.bounds.size.y, var_14_3 / var_14_2.sprite.bounds.size.y < var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x and var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x or var_14_3 / var_14_2.sprite.bounds.size.y, 0)
				end

				for iter_14_0, iter_14_1 in pairs(arg_11_1.bgs_) do
					if iter_14_0 ~= "B02f" then
						iter_14_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_14_4 = 0

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_4 + arg_14_0 then
				arg_11_1.mask_.enabled = true
				arg_11_1.mask_.raycastTarget = false

				arg_11_1:SetGaussion(false)
			end

			local var_14_5 = 0.5

			if var_14_4 <= arg_11_1.time_ and arg_11_1.time_ < var_14_4 + var_14_5 then
				local var_14_6 = Color.New(0, 0, 0)

				var_14_6.a = Mathf.Lerp(0, 1, (arg_11_1.time_ - var_14_4) / var_14_5)
				arg_11_1.mask_.color = var_14_6
			end

			if arg_11_1.time_ >= var_14_4 + var_14_5 and arg_11_1.time_ < var_14_4 + var_14_5 + arg_14_0 then
				local var_14_7 = Color.New(0, 0, 0)

				var_14_7.a = 1
				arg_11_1.mask_.color = var_14_7
			end

			local var_14_8 = 0.5

			if 0.5 < arg_11_1.time_ and arg_11_1.time_ <= var_14_8 + arg_14_0 then
				arg_11_1.mask_.enabled = true
				arg_11_1.mask_.raycastTarget = false

				arg_11_1:SetGaussion(false)
			end

			local var_14_9 = 0.5

			if var_14_8 <= arg_11_1.time_ and arg_11_1.time_ < var_14_8 + var_14_9 then
				local var_14_10 = Color.New(0, 0, 0)

				var_14_10.a = Mathf.Lerp(1, 0, (arg_11_1.time_ - var_14_8) / var_14_9)
				arg_11_1.mask_.color = var_14_10
			end

			if arg_11_1.time_ >= var_14_8 + var_14_9 and arg_11_1.time_ < var_14_8 + var_14_9 + arg_14_0 then
				local var_14_11 = Color.New(0, 0, 0)

				arg_11_1.mask_.enabled = false
				var_14_11.a = 0
				arg_11_1.mask_.color = var_14_11
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 100011010,
				charCount = 41,
				enableLayoutChange = true,
				duration = 1.93333333333333,
				groupID = "101",
				startTime = 0.5,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play103 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 103
		arg_15_1.duration_ = 2

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play104(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_9001
			local var_18_9000

			if arg_15_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_18_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_15_1.stage_.transform)

				var_18_0.name = "1148ui_story"
				var_18_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_["1148ui_story"] = var_18_0

				local var_18_1 = var_18_0:GetComponentInChildren(typeof(CharacterEffect))

				var_18_1.enabled = true

				local var_18_2 = GameObjectTools.GetOrAddComponent(var_18_0, typeof(DynamicBoneHelper))

				if var_18_2 then
					var_18_2:EnableDynamicBone(false)
				end

				arg_15_1:ShowWeapon(var_18_1.transform, false)

				arg_15_1.var_["1148ui_story" .. "Animator"] = var_18_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_15_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_15_1.var_["1148ui_story" .. "LipSync"] = var_18_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_18_3 = arg_15_1.actors_["1148ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_3) and arg_15_1.var_.characterEffect1148ui_story == nil then
				arg_15_1.var_.characterEffect1148ui_story = var_18_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_4 = 0.1

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 and not isNil(var_18_3) then
				if arg_15_1.var_.characterEffect1148ui_story and not isNil(var_18_3) then
					arg_15_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 and not isNil(var_18_3) and arg_15_1.var_.characterEffect1148ui_story then
				arg_15_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_18_6 = "1084ui_story"

			if arg_15_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_18_7 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_15_1.stage_.transform)

				var_18_7.name = var_18_6
				var_18_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_[var_18_6] = var_18_7

				local var_18_8 = var_18_7:GetComponentInChildren(typeof(CharacterEffect))

				var_18_8.enabled = true

				local var_18_9 = GameObjectTools.GetOrAddComponent(var_18_7, typeof(DynamicBoneHelper))

				if var_18_9 then
					var_18_9:EnableDynamicBone(false)
				end

				arg_15_1:ShowWeapon(var_18_8.transform, false)

				arg_15_1.var_[var_18_6 .. "Animator"] = var_18_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_15_1.var_[var_18_6 .. "Animator"].applyRootMotion = true
				arg_15_1.var_[var_18_6 .. "LipSync"] = var_18_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_18_10 = arg_15_1.actors_["1084ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_10) and arg_15_1.var_.characterEffect1084ui_story == nil then
				arg_15_1.var_.characterEffect1084ui_story = var_18_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_11 = 0.1

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_11 and not isNil(var_18_10) then
				if arg_15_1.var_.characterEffect1084ui_story and not isNil(var_18_10) then
					arg_15_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_11 and arg_15_1.time_ < 0 + var_18_11 + arg_18_0 and not isNil(var_18_10) and arg_15_1.var_.characterEffect1084ui_story then
				arg_15_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_18_13 = "ST03a"

			if arg_15_1.bgs_.ST03a == nil then
				local var_18_14 = Object.Instantiate(arg_15_1.paintGo_)

				var_18_14:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_18_13)
				var_18_14.name = var_18_13
				var_18_14.transform.parent = arg_15_1.stage_.transform
				var_18_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.bgs_[var_18_13] = var_18_14
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				local var_18_15 = arg_15_1.bgs_.ST03a

				arg_15_1.bgs_.ST03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_18_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_18_16 = var_18_15:GetComponent("SpriteRenderer")

				if var_18_16 and var_18_16.sprite then
					local var_18_17 = 2 * (var_18_15.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_18_15.transform.localScale = Vector3.New(var_18_17 / var_18_16.sprite.bounds.size.y < var_18_17 * manager.ui.mainCameraCom_.aspect / var_18_16.sprite.bounds.size.x and var_18_17 * manager.ui.mainCameraCom_.aspect / var_18_16.sprite.bounds.size.x or var_18_17 / var_18_16.sprite.bounds.size.y, var_18_17 / var_18_16.sprite.bounds.size.y < var_18_17 * manager.ui.mainCameraCom_.aspect / var_18_16.sprite.bounds.size.x and var_18_17 * manager.ui.mainCameraCom_.aspect / var_18_16.sprite.bounds.size.x or var_18_17 / var_18_16.sprite.bounds.size.y, 0)
				end

				for iter_18_0, iter_18_1 in pairs(arg_15_1.bgs_) do
					if iter_18_0 ~= "ST03a" then
						iter_18_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_18_18 = "ST03"

			if arg_15_1.bgs_.ST03 == nil then
				local var_18_19 = Object.Instantiate(arg_15_1.paintGo_)

				var_18_19:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_18_18)
				var_18_19.name = var_18_18
				var_18_19.transform.parent = arg_15_1.stage_.transform
				var_18_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.bgs_[var_18_18] = var_18_19
			end

			local var_18_20 = arg_15_1.bgs_.ST03.transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPosST03 = var_18_20.localPosition
			end

			local var_18_21 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_21 then
				var_18_20.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPosST03, Vector3.New(0, -100, 10), (arg_15_1.time_ - 0) / var_18_21)
			end

			if arg_15_1.time_ >= 0 + var_18_21 and arg_15_1.time_ < 0 + var_18_21 + arg_18_0 then
				var_18_20.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				if arg_15_1.var_.effectxiayu2 then
					Object.Destroy(arg_15_1.var_.effectxiayu2)

					arg_15_1.var_.effectxiayu2 = nil
				end
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				if arg_15_1.var_.effectxiayu1 then
					Object.Destroy(arg_15_1.var_.effectxiayu1)

					arg_15_1.var_.effectxiayu1 = nil
				end
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				local var_18_24 = arg_15_1.var_.effectxiayu3

				if not arg_15_1.var_.effectxiayu3 then
					var_18_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax"), manager.ui.mainCamera.transform)
					var_18_24.name = "xiayu3"
					arg_15_1.var_.effectxiayu3 = var_18_24
				else
					var_18_24.transform:SetParent(var_18_9001)
				end

				var_18_24.transform.localPosition = Vector3.New(0, 0, 0)
				var_18_24.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				local var_18_26 = arg_15_1.var_.effectxiayu4

				if not arg_15_1.var_.effectxiayu4 then
					var_18_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), manager.ui.mainCamera.transform)
					var_18_26.name = "xiayu4"
					arg_15_1.var_.effectxiayu4 = var_18_26
				else
					var_18_26.transform:SetParent(var_18_9000)
				end

				var_18_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_18_26.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_18_28 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_18_29 = var_18_26.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_18_2, iter_18_3 in ipairs((var_18_29:ToTable())) do
					iter_18_3.transform.localScale = Vector3.New(iter_18_3.transform.localScale.x / var_18_28 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_18_29 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_18_3.transform.localScale.y / var_18_28, iter_18_3.transform.localScale.z)
				end
			end

			local var_18_31 = 0
			local var_18_32 = 1.43333333333333

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_31 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0

				arg_15_1.dialog_:SetActive(true)

				arg_15_1.dialogCg_.alpha = 0

				local var_18_33 = LeanTween.value(arg_15_1.dialog_, 0, 1, 0.3)

				var_18_33:setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
					arg_15_1.dialogCg_.alpha = arg_19_0
				end))
				var_18_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_15_1.dialog_)
					var_18_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_15_1.duration_ = arg_15_1.duration_ + 0.3

				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_34 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(100).content)

				arg_15_1.text_.text = var_18_34

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_36 = 4 <= 0 and var_18_32 or var_18_32 * (utf8.len(var_18_34) / 4)

				if (4 <= 0 and var_18_32 or var_18_32 * (utf8.len(var_18_34) / 4)) > 0 and var_18_32 < var_18_36 then
					arg_15_1.talkMaxDuration = var_18_36
					var_18_31 = var_18_31 + 0.3

					if var_18_36 + var_18_31 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_36 + var_18_31
					end
				end

				arg_15_1.text_.text = var_18_34
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_37 = var_18_31 + 0.3
			local var_18_38 = math.max(var_18_32, arg_15_1.talkMaxDuration)

			if var_18_31 + 0.3 <= arg_15_1.time_ and arg_15_1.time_ < var_18_37 + var_18_38 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_37) / var_18_38

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_37 + var_18_38 and arg_15_1.time_ < var_18_37 + var_18_38 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST03",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play104 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 104
		arg_21_1.duration_ = 2

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play105(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_9001
			local var_24_9000

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1148ui_story"]) and arg_21_1.var_.characterEffect1148ui_story == nil then
				arg_21_1.var_.characterEffect1148ui_story = arg_21_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.1

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1148ui_story"]) then
				if arg_21_1.var_.characterEffect1148ui_story and not isNil(arg_21_1.actors_["1148ui_story"]) then
					arg_21_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1148ui_story"]) and arg_21_1.var_.characterEffect1148ui_story then
				arg_21_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_24_2 = arg_21_1.actors_["1084ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = var_24_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_3 = 0.1

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.characterEffect1084ui_story and not isNil(var_24_2) then
					arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1084ui_story then
				arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_24_5 = "ST05"

			if arg_21_1.bgs_.ST05 == nil then
				local var_24_6 = Object.Instantiate(arg_21_1.paintGo_)

				var_24_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_24_5)
				var_24_6.name = var_24_5
				var_24_6.transform.parent = arg_21_1.stage_.transform
				var_24_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.bgs_[var_24_5] = var_24_6
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_7 = arg_21_1.bgs_.ST05

				arg_21_1.bgs_.ST05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_24_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_8 = var_24_7:GetComponent("SpriteRenderer")

				if var_24_8 and var_24_8.sprite then
					local var_24_9 = 2 * (var_24_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_24_7.transform.localScale = Vector3.New(var_24_9 / var_24_8.sprite.bounds.size.y < var_24_9 * manager.ui.mainCameraCom_.aspect / var_24_8.sprite.bounds.size.x and var_24_9 * manager.ui.mainCameraCom_.aspect / var_24_8.sprite.bounds.size.x or var_24_9 / var_24_8.sprite.bounds.size.y, var_24_9 / var_24_8.sprite.bounds.size.y < var_24_9 * manager.ui.mainCameraCom_.aspect / var_24_8.sprite.bounds.size.x and var_24_9 * manager.ui.mainCameraCom_.aspect / var_24_8.sprite.bounds.size.x or var_24_9 / var_24_8.sprite.bounds.size.y, 0)
				end

				for iter_24_0, iter_24_1 in pairs(arg_21_1.bgs_) do
					if iter_24_0 ~= "ST05" then
						iter_24_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_24_10 = arg_21_1.bgs_.ST03a.transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPosST03a = var_24_10.localPosition
			end

			local var_24_11 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_11 then
				var_24_10.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPosST03a, Vector3.New(0, -100, 10), (arg_21_1.time_ - 0) / var_24_11)
			end

			if arg_21_1.time_ >= 0 + var_24_11 and arg_21_1.time_ < 0 + var_24_11 + arg_24_0 then
				var_24_10.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action452")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				if arg_21_1.var_.effectxiayu3 then
					Object.Destroy(arg_21_1.var_.effectxiayu3)

					arg_21_1.var_.effectxiayu3 = nil
				end
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				if arg_21_1.var_.effectxiayu4 then
					Object.Destroy(arg_21_1.var_.effectxiayu4)

					arg_21_1.var_.effectxiayu4 = nil
				end
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_14 = arg_21_1.var_.effectxiayu5

				if not arg_21_1.var_.effectxiayu5 then
					var_24_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_light"), manager.ui.mainCamera.transform)
					var_24_14.name = "xiayu5"
					arg_21_1.var_.effectxiayu5 = var_24_14
				else
					var_24_14.transform:SetParent(var_24_9001)
				end

				var_24_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_24_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_16 = arg_21_1.var_.effectxiayu6

				if not arg_21_1.var_.effectxiayu6 then
					var_24_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_light_ui"), manager.ui.mainCamera.transform)
					var_24_16.name = "xiayu6"
					arg_21_1.var_.effectxiayu6 = var_24_16
				else
					var_24_16.transform:SetParent(var_24_9000)
				end

				var_24_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_24_16.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_24_18 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_24_19 = var_24_16.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_24_2, iter_24_3 in ipairs((var_24_19:ToTable())) do
					iter_24_3.transform.localScale = Vector3.New(iter_24_3.transform.localScale.x / var_24_18 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_24_19 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_24_3.transform.localScale.y / var_24_18, iter_24_3.transform.localScale.z)
				end
			end

			local var_24_21 = 0
			local var_24_22 = 0.1

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_23 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_23:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_24 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(100).content)

				arg_21_1.text_.text = var_24_24

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_26 = 4 <= 0 and var_24_22 or var_24_22 * (utf8.len(var_24_24) / 4)

				if (4 <= 0 and var_24_22 or var_24_22 * (utf8.len(var_24_24) / 4)) > 0 and var_24_22 < var_24_26 then
					arg_21_1.talkMaxDuration = var_24_26
					var_24_21 = var_24_21 + 0.3

					if var_24_26 + var_24_21 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_26 + var_24_21
					end
				end

				arg_21_1.text_.text = var_24_24
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_27 = var_24_21 + 0.3
			local var_24_28 = math.max(var_24_22, arg_21_1.talkMaxDuration)

			if var_24_21 + 0.3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_27 + var_24_28 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_27) / var_24_28

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_27 + var_24_28 and arg_21_1.time_ < var_24_27 + var_24_28 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST03a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play105 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 105
		arg_27_1.duration_ = 7.37

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play106(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1148ui_story"]) and arg_27_1.var_.characterEffect1148ui_story == nil then
				arg_27_1.var_.characterEffect1148ui_story = arg_27_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_0 = 0.1

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1148ui_story"]) then
				if arg_27_1.var_.characterEffect1148ui_story and not isNil(arg_27_1.actors_["1148ui_story"]) then
					arg_27_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1148ui_story"]) and arg_27_1.var_.characterEffect1148ui_story then
				arg_27_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_30_2 = arg_27_1.actors_["1084ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_2) and arg_27_1.var_.characterEffect1084ui_story == nil then
				arg_27_1.var_.characterEffect1084ui_story = var_30_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_3 = 0.1

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_3 and not isNil(var_30_2) then
				if arg_27_1.var_.characterEffect1084ui_story and not isNil(var_30_2) then
					arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_3 and arg_27_1.time_ < 0 + var_30_3 + arg_30_0 and not isNil(var_30_2) and arg_27_1.var_.characterEffect1084ui_story then
				arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_30_5 = "ST05a"

			if arg_27_1.bgs_.ST05a == nil then
				local var_30_6 = Object.Instantiate(arg_27_1.paintGo_)

				var_30_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_30_5)
				var_30_6.name = var_30_5
				var_30_6.transform.parent = arg_27_1.stage_.transform
				var_30_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.bgs_[var_30_5] = var_30_6
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				local var_30_7 = arg_27_1.bgs_.ST05a

				arg_27_1.bgs_.ST05a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_30_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_30_8 = var_30_7:GetComponent("SpriteRenderer")

				if var_30_8 and var_30_8.sprite then
					local var_30_9 = 2 * (var_30_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_30_7.transform.localScale = Vector3.New(var_30_9 / var_30_8.sprite.bounds.size.y < var_30_9 * manager.ui.mainCameraCom_.aspect / var_30_8.sprite.bounds.size.x and var_30_9 * manager.ui.mainCameraCom_.aspect / var_30_8.sprite.bounds.size.x or var_30_9 / var_30_8.sprite.bounds.size.y, var_30_9 / var_30_8.sprite.bounds.size.y < var_30_9 * manager.ui.mainCameraCom_.aspect / var_30_8.sprite.bounds.size.x and var_30_9 * manager.ui.mainCameraCom_.aspect / var_30_8.sprite.bounds.size.x or var_30_9 / var_30_8.sprite.bounds.size.y, 0)
				end

				for iter_30_0, iter_30_1 in pairs(arg_27_1.bgs_) do
					if iter_30_0 ~= "ST05a" then
						iter_30_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_30_10 = arg_27_1.bgs_.ST05.transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPosST05 = var_30_10.localPosition
			end

			local var_30_11 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_11 then
				var_30_10.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPosST05, Vector3.New(0, -100, 10), (arg_27_1.time_ - 0) / var_30_11)
			end

			if arg_27_1.time_ >= 0 + var_30_11 and arg_27_1.time_ < 0 + var_30_11 + arg_30_0 then
				var_30_10.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action423")
			end

			local var_30_12 = 0
			local var_30_13 = 0.1

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_12 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0

				arg_27_1.dialog_:SetActive(true)

				arg_27_1.dialogCg_.alpha = 0

				local var_30_14 = LeanTween.value(arg_27_1.dialog_, 0, 1, 0.3)

				var_30_14:setOnUpdate(LuaHelper.FloatAction(function(arg_31_0)
					arg_27_1.dialogCg_.alpha = arg_31_0
				end))
				var_30_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_27_1.dialog_)
					var_30_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_27_1.duration_ = arg_27_1.duration_ + 0.3

				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_15 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(100).content)

				arg_27_1.text_.text = var_30_15

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_17 = 4 <= 0 and var_30_13 or var_30_13 * (utf8.len(var_30_15) / 4)

				if (4 <= 0 and var_30_13 or var_30_13 * (utf8.len(var_30_15) / 4)) > 0 and var_30_13 < var_30_17 then
					arg_27_1.talkMaxDuration = var_30_17
					var_30_12 = var_30_12 + 0.3

					if var_30_17 + var_30_12 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_17 + var_30_12
					end
				end

				arg_27_1.text_.text = var_30_15
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_18 = var_30_12 + 0.3
			local var_30_19 = math.max(var_30_13, arg_27_1.talkMaxDuration)

			if var_30_12 + 0.3 <= arg_27_1.time_ and arg_27_1.time_ < var_30_18 + var_30_19 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_18) / var_30_19

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_18 + var_30_19 and arg_27_1.time_ < var_30_18 + var_30_19 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST05",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play106 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 106
		arg_33_1.duration_ = 2

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play107(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1148ui_story"]) and arg_33_1.var_.characterEffect1148ui_story == nil then
				arg_33_1.var_.characterEffect1148ui_story = arg_33_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.1

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1148ui_story"]) then
				if arg_33_1.var_.characterEffect1148ui_story and not isNil(arg_33_1.actors_["1148ui_story"]) then
					arg_33_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1148ui_story"]) and arg_33_1.var_.characterEffect1148ui_story then
				arg_33_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_36_2 = 0.100000001490116

			if 0.100000001490116 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				SetActive(arg_33_1.dialog_, true)
				SetActive(arg_33_1.allBtn_.gameObject, true)
				arg_33_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_33_1.isInLoopVideo = false
			end

			local var_36_3 = 0.1

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_3 then
				-- block empty
			end

			if arg_33_1.time_ >= var_36_2 + var_36_3 and arg_33_1.time_ < var_36_2 + var_36_3 + arg_36_0 then
				-- block empty
			end

			local var_36_4 = arg_33_1.actors_["1084ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1084ui_story == nil then
				arg_33_1.var_.characterEffect1084ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_5 = 0.1

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 and not isNil(var_36_4) then
				if arg_33_1.var_.characterEffect1084ui_story and not isNil(var_36_4) then
					arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1084ui_story then
				arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_36_7 = "ST06"

			if arg_33_1.bgs_.ST06 == nil then
				local var_36_8 = Object.Instantiate(arg_33_1.paintGo_)

				var_36_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_36_7)
				var_36_8.name = var_36_7
				var_36_8.transform.parent = arg_33_1.stage_.transform
				var_36_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_[var_36_7] = var_36_8
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				local var_36_9 = arg_33_1.bgs_.ST06

				arg_33_1.bgs_.ST06.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_36_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_10 = var_36_9:GetComponent("SpriteRenderer")

				if var_36_10 and var_36_10.sprite then
					local var_36_11 = 2 * (var_36_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_36_9.transform.localScale = Vector3.New(var_36_11 / var_36_10.sprite.bounds.size.y < var_36_11 * manager.ui.mainCameraCom_.aspect / var_36_10.sprite.bounds.size.x and var_36_11 * manager.ui.mainCameraCom_.aspect / var_36_10.sprite.bounds.size.x or var_36_11 / var_36_10.sprite.bounds.size.y, var_36_11 / var_36_10.sprite.bounds.size.y < var_36_11 * manager.ui.mainCameraCom_.aspect / var_36_10.sprite.bounds.size.x and var_36_11 * manager.ui.mainCameraCom_.aspect / var_36_10.sprite.bounds.size.x or var_36_11 / var_36_10.sprite.bounds.size.y, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "ST06" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_12 = arg_33_1.bgs_.ST05a.transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPosST05a = var_36_12.localPosition
			end

			local var_36_13 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_13 then
				var_36_12.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPosST05a, Vector3.New(0, -100, 10), (arg_33_1.time_ - 0) / var_36_13)
			end

			if arg_33_1.time_ >= 0 + var_36_13 and arg_33_1.time_ < 0 + var_36_13 + arg_36_0 then
				var_36_12.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action423")
			end

			local var_36_14 = 0
			local var_36_15 = 0.1

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_16 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_16:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_17 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(100).content)

				arg_33_1.text_.text = var_36_17

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_19 = 4 <= 0 and var_36_15 or var_36_15 * (utf8.len(var_36_17) / 4)

				if (4 <= 0 and var_36_15 or var_36_15 * (utf8.len(var_36_17) / 4)) > 0 and var_36_15 < var_36_19 then
					arg_33_1.talkMaxDuration = var_36_19
					var_36_14 = var_36_14 + 0.3

					if var_36_19 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_19 + var_36_14
					end
				end

				arg_33_1.text_.text = var_36_17
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_20 = var_36_14 + 0.3
			local var_36_21 = math.max(var_36_15, arg_33_1.talkMaxDuration)

			if var_36_14 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_20 + var_36_21 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_20) / var_36_21

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_20 + var_36_21 and arg_33_1.time_ < var_36_20 + var_36_21 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST05a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play107 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 107
		arg_39_1.duration_ = 6.8

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play108(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1148ui_story"]) and arg_39_1.var_.characterEffect1148ui_story == nil then
				arg_39_1.var_.characterEffect1148ui_story = arg_39_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.1

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1148ui_story"]) then
				if arg_39_1.var_.characterEffect1148ui_story and not isNil(arg_39_1.actors_["1148ui_story"]) then
					arg_39_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1148ui_story"]) and arg_39_1.var_.characterEffect1148ui_story then
				arg_39_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_42_2 = arg_39_1.actors_["1084ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.characterEffect1084ui_story == nil then
				arg_39_1.var_.characterEffect1084ui_story = var_42_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_3 = 0.1

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_3 and not isNil(var_42_2) then
				if arg_39_1.var_.characterEffect1084ui_story and not isNil(var_42_2) then
					arg_39_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_3 and arg_39_1.time_ < 0 + var_42_3 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.characterEffect1084ui_story then
				arg_39_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_42_5 = "ST06a"

			if arg_39_1.bgs_.ST06a == nil then
				local var_42_6 = Object.Instantiate(arg_39_1.paintGo_)

				var_42_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_42_5)
				var_42_6.name = var_42_5
				var_42_6.transform.parent = arg_39_1.stage_.transform
				var_42_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.bgs_[var_42_5] = var_42_6
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				local var_42_7 = arg_39_1.bgs_.ST06a

				arg_39_1.bgs_.ST06a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_42_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_42_8 = var_42_7:GetComponent("SpriteRenderer")

				if var_42_8 and var_42_8.sprite then
					local var_42_9 = 2 * (var_42_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_42_7.transform.localScale = Vector3.New(var_42_9 / var_42_8.sprite.bounds.size.y < var_42_9 * manager.ui.mainCameraCom_.aspect / var_42_8.sprite.bounds.size.x and var_42_9 * manager.ui.mainCameraCom_.aspect / var_42_8.sprite.bounds.size.x or var_42_9 / var_42_8.sprite.bounds.size.y, var_42_9 / var_42_8.sprite.bounds.size.y < var_42_9 * manager.ui.mainCameraCom_.aspect / var_42_8.sprite.bounds.size.x and var_42_9 * manager.ui.mainCameraCom_.aspect / var_42_8.sprite.bounds.size.x or var_42_9 / var_42_8.sprite.bounds.size.y, 0)
				end

				for iter_42_0, iter_42_1 in pairs(arg_39_1.bgs_) do
					if iter_42_0 ~= "ST06a" then
						iter_42_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_42_10 = arg_39_1.bgs_.ST06.transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPosST06 = var_42_10.localPosition
			end

			local var_42_11 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_11 then
				var_42_10.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPosST06, Vector3.New(0, -100, 10), (arg_39_1.time_ - 0) / var_42_11)
			end

			if arg_39_1.time_ >= 0 + var_42_11 and arg_39_1.time_ < 0 + var_42_11 + arg_42_0 then
				var_42_10.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action434")
			end

			local var_42_12 = 0
			local var_42_13 = 0.1

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_12 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_14 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_14:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_39_1.dialogCg_.alpha = arg_43_0
				end))
				var_42_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_15 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(100).content)

				arg_39_1.text_.text = var_42_15

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_17 = 4 <= 0 and var_42_13 or var_42_13 * (utf8.len(var_42_15) / 4)

				if (4 <= 0 and var_42_13 or var_42_13 * (utf8.len(var_42_15) / 4)) > 0 and var_42_13 < var_42_17 then
					arg_39_1.talkMaxDuration = var_42_17
					var_42_12 = var_42_12 + 0.3

					if var_42_17 + var_42_12 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_17 + var_42_12
					end
				end

				arg_39_1.text_.text = var_42_15
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_18 = var_42_12 + 0.3
			local var_42_19 = math.max(var_42_13, arg_39_1.talkMaxDuration)

			if var_42_12 + 0.3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_18 + var_42_19 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_18) / var_42_19

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_18 + var_42_19 and arg_39_1.time_ < var_42_18 + var_42_19 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST06",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play108 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 108
		arg_45_1.duration_ = 7.05

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play109(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1148ui_story"]) and arg_45_1.var_.characterEffect1148ui_story == nil then
				arg_45_1.var_.characterEffect1148ui_story = arg_45_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.1

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1148ui_story"]) then
				if arg_45_1.var_.characterEffect1148ui_story and not isNil(arg_45_1.actors_["1148ui_story"]) then
					arg_45_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1148ui_story"]) and arg_45_1.var_.characterEffect1148ui_story then
				arg_45_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_48_2 = arg_45_1.actors_["1084ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect1084ui_story == nil then
				arg_45_1.var_.characterEffect1084ui_story = var_48_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_3 = 0.1

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.characterEffect1084ui_story and not isNil(var_48_2) then
					arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect1084ui_story then
				arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_48_5 = "ST06b"

			if arg_45_1.bgs_.ST06b == nil then
				local var_48_6 = Object.Instantiate(arg_45_1.paintGo_)

				var_48_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_48_5)
				var_48_6.name = var_48_5
				var_48_6.transform.parent = arg_45_1.stage_.transform
				var_48_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.bgs_[var_48_5] = var_48_6
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				local var_48_7 = arg_45_1.bgs_.ST06b

				arg_45_1.bgs_.ST06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_48_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_8 = var_48_7:GetComponent("SpriteRenderer")

				if var_48_8 and var_48_8.sprite then
					local var_48_9 = 2 * (var_48_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_48_7.transform.localScale = Vector3.New(var_48_9 / var_48_8.sprite.bounds.size.y < var_48_9 * manager.ui.mainCameraCom_.aspect / var_48_8.sprite.bounds.size.x and var_48_9 * manager.ui.mainCameraCom_.aspect / var_48_8.sprite.bounds.size.x or var_48_9 / var_48_8.sprite.bounds.size.y, var_48_9 / var_48_8.sprite.bounds.size.y < var_48_9 * manager.ui.mainCameraCom_.aspect / var_48_8.sprite.bounds.size.x and var_48_9 * manager.ui.mainCameraCom_.aspect / var_48_8.sprite.bounds.size.x or var_48_9 / var_48_8.sprite.bounds.size.y, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "ST06b" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_10 = arg_45_1.bgs_.ST06a.transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPosST06a = var_48_10.localPosition
			end

			local var_48_11 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_11 then
				var_48_10.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPosST06a, Vector3.New(0, -100, 10), (arg_45_1.time_ - 0) / var_48_11)
			end

			if arg_45_1.time_ >= 0 + var_48_11 and arg_45_1.time_ < 0 + var_48_11 + arg_48_0 then
				var_48_10.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action434")
			end

			local var_48_12 = 0
			local var_48_13 = 0.1

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_12 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_14 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_14:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_15 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(100).content)

				arg_45_1.text_.text = var_48_15

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_17 = 4 <= 0 and var_48_13 or var_48_13 * (utf8.len(var_48_15) / 4)

				if (4 <= 0 and var_48_13 or var_48_13 * (utf8.len(var_48_15) / 4)) > 0 and var_48_13 < var_48_17 then
					arg_45_1.talkMaxDuration = var_48_17
					var_48_12 = var_48_12 + 0.3

					if var_48_17 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_17 + var_48_12
					end
				end

				arg_45_1.text_.text = var_48_15
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_18 = var_48_12 + 0.3
			local var_48_19 = math.max(var_48_13, arg_45_1.talkMaxDuration)

			if var_48_12 + 0.3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_18 + var_48_19 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_18) / var_48_19

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_18 + var_48_19 and arg_45_1.time_ < var_48_18 + var_48_19 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST06a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play109 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 109
		arg_51_1.duration_ = 6.67

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play110(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1148ui_story"]) and arg_51_1.var_.characterEffect1148ui_story == nil then
				arg_51_1.var_.characterEffect1148ui_story = arg_51_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.1

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1148ui_story"]) then
				if arg_51_1.var_.characterEffect1148ui_story and not isNil(arg_51_1.actors_["1148ui_story"]) then
					arg_51_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1148ui_story"]) and arg_51_1.var_.characterEffect1148ui_story then
				arg_51_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_54_2 = arg_51_1.actors_["1084ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.characterEffect1084ui_story == nil then
				arg_51_1.var_.characterEffect1084ui_story = var_54_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_3 = 0.1

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.characterEffect1084ui_story and not isNil(var_54_2) then
					arg_51_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.characterEffect1084ui_story then
				arg_51_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_54_5 = arg_51_1.bgs_.ST06b.transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPosST06b = var_54_5.localPosition
			end

			local var_54_6 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_6 then
				var_54_5.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPosST06b, Vector3.New(0, -100, 10), (arg_51_1.time_ - 0) / var_54_6)
			end

			if arg_51_1.time_ >= 0 + var_54_6 and arg_51_1.time_ < 0 + var_54_6 + arg_54_0 then
				var_54_5.localPosition = Vector3.New(0, -100, 10)
			end

			local var_54_7 = "ST07a"

			if arg_51_1.bgs_.ST07a == nil then
				local var_54_8 = Object.Instantiate(arg_51_1.paintGo_)

				var_54_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_54_7)
				var_54_8.name = var_54_7
				var_54_8.transform.parent = arg_51_1.stage_.transform
				var_54_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.bgs_[var_54_7] = var_54_8
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				local var_54_9 = arg_51_1.bgs_.ST07a

				arg_51_1.bgs_.ST07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_54_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_54_10 = var_54_9:GetComponent("SpriteRenderer")

				if var_54_10 and var_54_10.sprite then
					local var_54_11 = 2 * (var_54_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_54_9.transform.localScale = Vector3.New(var_54_11 / var_54_10.sprite.bounds.size.y < var_54_11 * manager.ui.mainCameraCom_.aspect / var_54_10.sprite.bounds.size.x and var_54_11 * manager.ui.mainCameraCom_.aspect / var_54_10.sprite.bounds.size.x or var_54_11 / var_54_10.sprite.bounds.size.y, var_54_11 / var_54_10.sprite.bounds.size.y < var_54_11 * manager.ui.mainCameraCom_.aspect / var_54_10.sprite.bounds.size.x and var_54_11 * manager.ui.mainCameraCom_.aspect / var_54_10.sprite.bounds.size.x or var_54_11 / var_54_10.sprite.bounds.size.y, 0)
				end

				for iter_54_0, iter_54_1 in pairs(arg_51_1.bgs_) do
					if iter_54_0 ~= "ST07a" then
						iter_54_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action445")
			end

			local var_54_12 = 0
			local var_54_13 = 0.1

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_12 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				arg_51_1.dialog_:SetActive(true)

				arg_51_1.dialogCg_.alpha = 0

				local var_54_14 = LeanTween.value(arg_51_1.dialog_, 0, 1, 0.3)

				var_54_14:setOnUpdate(LuaHelper.FloatAction(function(arg_55_0)
					arg_51_1.dialogCg_.alpha = arg_55_0
				end))
				var_54_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_51_1.dialog_)
					var_54_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_51_1.duration_ = arg_51_1.duration_ + 0.3

				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_15 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(100).content)

				arg_51_1.text_.text = var_54_15

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_17 = 4 <= 0 and var_54_13 or var_54_13 * (utf8.len(var_54_15) / 4)

				if (4 <= 0 and var_54_13 or var_54_13 * (utf8.len(var_54_15) / 4)) > 0 and var_54_13 < var_54_17 then
					arg_51_1.talkMaxDuration = var_54_17
					var_54_12 = var_54_12 + 0.3

					if var_54_17 + var_54_12 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_17 + var_54_12
					end
				end

				arg_51_1.text_.text = var_54_15
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_18 = var_54_12 + 0.3
			local var_54_19 = math.max(var_54_13, arg_51_1.talkMaxDuration)

			if var_54_12 + 0.3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_18 + var_54_19 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_18) / var_54_19

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_18 + var_54_19 and arg_51_1.time_ < var_54_18 + var_54_19 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST06b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play110 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 110
		arg_57_1.duration_ = 6.77

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play111(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1148ui_story"]) and arg_57_1.var_.characterEffect1148ui_story == nil then
				arg_57_1.var_.characterEffect1148ui_story = arg_57_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.1

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1148ui_story"]) then
				if arg_57_1.var_.characterEffect1148ui_story and not isNil(arg_57_1.actors_["1148ui_story"]) then
					arg_57_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1148ui_story"]) and arg_57_1.var_.characterEffect1148ui_story then
				arg_57_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_60_2 = arg_57_1.actors_["1084ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1084ui_story == nil then
				arg_57_1.var_.characterEffect1084ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.1

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect1084ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1084ui_story then
				arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_60_5 = arg_57_1.bgs_.ST07a.transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPosST07a = var_60_5.localPosition
			end

			local var_60_6 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_6 then
				var_60_5.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPosST07a, Vector3.New(0, -100, 10), (arg_57_1.time_ - 0) / var_60_6)
			end

			if arg_57_1.time_ >= 0 + var_60_6 and arg_57_1.time_ < 0 + var_60_6 + arg_60_0 then
				var_60_5.localPosition = Vector3.New(0, -100, 10)
			end

			local var_60_7 = "ST07b"

			if arg_57_1.bgs_.ST07b == nil then
				local var_60_8 = Object.Instantiate(arg_57_1.paintGo_)

				var_60_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_60_7)
				var_60_8.name = var_60_7
				var_60_8.transform.parent = arg_57_1.stage_.transform
				var_60_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.bgs_[var_60_7] = var_60_8
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				local var_60_9 = arg_57_1.bgs_.ST07b

				arg_57_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_60_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_60_10 = var_60_9:GetComponent("SpriteRenderer")

				if var_60_10 and var_60_10.sprite then
					local var_60_11 = 2 * (var_60_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_60_9.transform.localScale = Vector3.New(var_60_11 / var_60_10.sprite.bounds.size.y < var_60_11 * manager.ui.mainCameraCom_.aspect / var_60_10.sprite.bounds.size.x and var_60_11 * manager.ui.mainCameraCom_.aspect / var_60_10.sprite.bounds.size.x or var_60_11 / var_60_10.sprite.bounds.size.y, var_60_11 / var_60_10.sprite.bounds.size.y < var_60_11 * manager.ui.mainCameraCom_.aspect / var_60_10.sprite.bounds.size.x and var_60_11 * manager.ui.mainCameraCom_.aspect / var_60_10.sprite.bounds.size.x or var_60_11 / var_60_10.sprite.bounds.size.y, 0)
				end

				for iter_60_0, iter_60_1 in pairs(arg_57_1.bgs_) do
					if iter_60_0 ~= "ST07b" then
						iter_60_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action445")
			end

			local var_60_12 = 0
			local var_60_13 = 0.1

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_14 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_14:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_15 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(100).content)

				arg_57_1.text_.text = var_60_15

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_17 = 4 <= 0 and var_60_13 or var_60_13 * (utf8.len(var_60_15) / 4)

				if (4 <= 0 and var_60_13 or var_60_13 * (utf8.len(var_60_15) / 4)) > 0 and var_60_13 < var_60_17 then
					arg_57_1.talkMaxDuration = var_60_17
					var_60_12 = var_60_12 + 0.3

					if var_60_17 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_17 + var_60_12
					end
				end

				arg_57_1.text_.text = var_60_15
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_18 = var_60_12 + 0.3
			local var_60_19 = math.max(var_60_13, arg_57_1.talkMaxDuration)

			if var_60_12 + 0.3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_18 + var_60_19 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_18) / var_60_19

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_18 + var_60_19 and arg_57_1.time_ < var_60_18 + var_60_19 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST07a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play111 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 111
		arg_63_1.duration_ = 7.33

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play112(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1148ui_story"]) and arg_63_1.var_.characterEffect1148ui_story == nil then
				arg_63_1.var_.characterEffect1148ui_story = arg_63_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.1

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1148ui_story"]) then
				if arg_63_1.var_.characterEffect1148ui_story and not isNil(arg_63_1.actors_["1148ui_story"]) then
					arg_63_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1148ui_story"]) and arg_63_1.var_.characterEffect1148ui_story then
				arg_63_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_66_2 = arg_63_1.actors_["1084ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect1084ui_story == nil then
				arg_63_1.var_.characterEffect1084ui_story = var_66_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_3 = 0.1

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.characterEffect1084ui_story and not isNil(var_66_2) then
					arg_63_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect1084ui_story then
				arg_63_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_66_5 = arg_63_1.bgs_.ST07b.transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPosST07b = var_66_5.localPosition
			end

			local var_66_6 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_6 then
				var_66_5.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPosST07b, Vector3.New(0, -100, 10), (arg_63_1.time_ - 0) / var_66_6)
			end

			if arg_63_1.time_ >= 0 + var_66_6 and arg_63_1.time_ < 0 + var_66_6 + arg_66_0 then
				var_66_5.localPosition = Vector3.New(0, -100, 10)
			end

			local var_66_7 = "ST08"

			if arg_63_1.bgs_.ST08 == nil then
				local var_66_8 = Object.Instantiate(arg_63_1.paintGo_)

				var_66_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_66_7)
				var_66_8.name = var_66_7
				var_66_8.transform.parent = arg_63_1.stage_.transform
				var_66_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.bgs_[var_66_7] = var_66_8
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				local var_66_9 = arg_63_1.bgs_.ST08

				arg_63_1.bgs_.ST08.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_66_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_10 = var_66_9:GetComponent("SpriteRenderer")

				if var_66_10 and var_66_10.sprite then
					local var_66_11 = 2 * (var_66_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_66_9.transform.localScale = Vector3.New(var_66_11 / var_66_10.sprite.bounds.size.y < var_66_11 * manager.ui.mainCameraCom_.aspect / var_66_10.sprite.bounds.size.x and var_66_11 * manager.ui.mainCameraCom_.aspect / var_66_10.sprite.bounds.size.x or var_66_11 / var_66_10.sprite.bounds.size.y, var_66_11 / var_66_10.sprite.bounds.size.y < var_66_11 * manager.ui.mainCameraCom_.aspect / var_66_10.sprite.bounds.size.x and var_66_11 * manager.ui.mainCameraCom_.aspect / var_66_10.sprite.bounds.size.x or var_66_11 / var_66_10.sprite.bounds.size.y, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "ST08" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action456")
			end

			local var_66_12 = 0
			local var_66_13 = 0.1

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_12 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_14 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_14:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_15 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(100).content)

				arg_63_1.text_.text = var_66_15

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_17 = 4 <= 0 and var_66_13 or var_66_13 * (utf8.len(var_66_15) / 4)

				if (4 <= 0 and var_66_13 or var_66_13 * (utf8.len(var_66_15) / 4)) > 0 and var_66_13 < var_66_17 then
					arg_63_1.talkMaxDuration = var_66_17
					var_66_12 = var_66_12 + 0.3

					if var_66_17 + var_66_12 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_17 + var_66_12
					end
				end

				arg_63_1.text_.text = var_66_15
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_18 = var_66_12 + 0.3
			local var_66_19 = math.max(var_66_13, arg_63_1.talkMaxDuration)

			if var_66_12 + 0.3 <= arg_63_1.time_ and arg_63_1.time_ < var_66_18 + var_66_19 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_18) / var_66_19

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_18 + var_66_19 and arg_63_1.time_ < var_66_18 + var_66_19 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST07b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play112 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 112
		arg_69_1.duration_ = 6.93

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
			arg_69_1.auto_ = false
		end

		function arg_69_1.playNext_(arg_71_0)
			arg_69_1.onStoryFinished_()
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1148ui_story"]) and arg_69_1.var_.characterEffect1148ui_story == nil then
				arg_69_1.var_.characterEffect1148ui_story = arg_69_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.1

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1148ui_story"]) then
				if arg_69_1.var_.characterEffect1148ui_story and not isNil(arg_69_1.actors_["1148ui_story"]) then
					arg_69_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1148ui_story"]) and arg_69_1.var_.characterEffect1148ui_story then
				arg_69_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_72_2 = arg_69_1.actors_["1084ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect1084ui_story == nil then
				arg_69_1.var_.characterEffect1084ui_story = var_72_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_3 = 0.1

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.characterEffect1084ui_story and not isNil(var_72_2) then
					arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect1084ui_story then
				arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_72_5 = arg_69_1.bgs_.ST08.transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPosST08 = var_72_5.localPosition
			end

			local var_72_6 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 then
				var_72_5.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPosST08, Vector3.New(0, -100, 10), (arg_69_1.time_ - 0) / var_72_6)
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 then
				var_72_5.localPosition = Vector3.New(0, -100, 10)
			end

			local var_72_7 = "ST12"

			if arg_69_1.bgs_.ST12 == nil then
				local var_72_8 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_72_7)
				var_72_8.name = var_72_7
				var_72_8.transform.parent = arg_69_1.stage_.transform
				var_72_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_[var_72_7] = var_72_8
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				local var_72_9 = arg_69_1.bgs_.ST12

				arg_69_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_10 = var_72_9:GetComponent("SpriteRenderer")

				if var_72_10 and var_72_10.sprite then
					local var_72_11 = 2 * (var_72_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_9.transform.localScale = Vector3.New(var_72_11 / var_72_10.sprite.bounds.size.y < var_72_11 * manager.ui.mainCameraCom_.aspect / var_72_10.sprite.bounds.size.x and var_72_11 * manager.ui.mainCameraCom_.aspect / var_72_10.sprite.bounds.size.x or var_72_11 / var_72_10.sprite.bounds.size.y, var_72_11 / var_72_10.sprite.bounds.size.y < var_72_11 * manager.ui.mainCameraCom_.aspect / var_72_10.sprite.bounds.size.x and var_72_11 * manager.ui.mainCameraCom_.aspect / var_72_10.sprite.bounds.size.x or var_72_11 / var_72_10.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "ST12" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action456")
			end

			local var_72_12 = 0
			local var_72_13 = 0.1

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_14 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_14:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_15 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(100).content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 4 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 4)

				if (4 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 4)) > 0 and var_72_13 < var_72_17 then
					arg_69_1.talkMaxDuration = var_72_17
					var_72_12 = var_72_12 + 0.3

					if var_72_17 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_12
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_18 = var_72_12 + 0.3
			local var_72_19 = math.max(var_72_13, arg_69_1.talkMaxDuration)

			if var_72_12 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_18 + var_72_19 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_18) / var_72_19

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_18 + var_72_19 and arg_69_1.time_ < var_72_18 + var_72_19 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST08",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A01",
		"TextureConfig/Background/B02f",
		"TextureConfig/Background/ST03a",
		"TextureConfig/Background/ST05",
		"TextureConfig/Background/ST05a",
		"TextureConfig/Background/ST06",
		"TextureConfig/Background/ST06a",
		"TextureConfig/Background/ST06b",
		"TextureConfig/Background/ST07a",
		"TextureConfig/Background/ST07b",
		"TextureConfig/Background/ST08",
		"TextureConfig/Background/ST12"
	},
	voices = {}
}
