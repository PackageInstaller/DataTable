return {
	Play322192001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322192001
		arg_1_1.duration_ = 4.23

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322192002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.STblack

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 0
			local var_4_23 = 0.3

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_4_28 = 1.333333333332
			local var_4_29 = 2.9
			local var_4_30 = manager.audio:GetVoiceLength("story_v_out_322192", "322192001", "story_v_out_322192.awb") / 1000

			if var_4_30 > 0 and var_4_29 < var_4_30 and var_4_30 + var_4_28 > arg_1_1.duration_ then
				local var_4_31 = var_4_30

				arg_1_1.duration_ = var_4_30 + var_4_28
			end

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "voice"

				arg_1_1:AudioAction(var_4_32, var_4_33, "story_v_out_322192", "322192001", "story_v_out_322192.awb")
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322192001,
				charCount = 10,
				enableLayoutChange = true,
				duration = 0.666666666666667,
				groupID = "1",
				startTime = 1.33333333333333,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322192002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 322192002
		arg_6_1.duration_ = 4

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play322192003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = "L09f"

			if arg_6_1.bgs_[var_9_0] == nil then
				local var_9_1 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_9_0)
				var_9_1.name = var_9_0
				var_9_1.transform.parent = arg_6_1.stage_.transform
				var_9_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_[var_9_0] = var_9_1
			end

			local var_9_2 = 0

			if var_9_2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_2 + arg_9_0 then
				local var_9_3 = manager.ui.mainCamera.transform.localPosition
				local var_9_4 = Vector3.New(0, 0, 10) + Vector3.New(var_9_3.x, var_9_3.y, 0)
				local var_9_5 = arg_6_1.bgs_.L09f

				var_9_5.transform.localPosition = var_9_4
				var_9_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_6 = var_9_5:GetComponent("SpriteRenderer")

				if var_9_6 and var_9_6.sprite then
					local var_9_7 = (var_9_5.transform.localPosition - var_9_3).z
					local var_9_8 = manager.ui.mainCameraCom_
					local var_9_9 = 2 * var_9_7 * Mathf.Tan(var_9_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_9_10 = var_9_9 * var_9_8.aspect
					local var_9_11 = var_9_6.sprite.bounds.size.x
					local var_9_12 = var_9_6.sprite.bounds.size.y
					local var_9_13 = var_9_10 / var_9_11
					local var_9_14 = var_9_9 / var_9_12
					local var_9_15 = var_9_14 < var_9_13 and var_9_13 or var_9_14

					var_9_5.transform.localScale = Vector3.New(var_9_15, var_9_15, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "L09f" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_16 = 1.999999999999

			if var_9_16 < arg_6_1.time_ and arg_6_1.time_ <= var_9_16 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			local var_9_17 = 0.1

			if arg_6_1.time_ >= var_9_16 + var_9_17 and arg_6_1.time_ < var_9_16 + var_9_17 + arg_9_0 then
				arg_6_1.allBtn_.enabled = true
			end

			local var_9_18 = 0

			if var_9_18 < arg_6_1.time_ and arg_6_1.time_ <= var_9_18 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_19 = 2

			if var_9_18 <= arg_6_1.time_ and arg_6_1.time_ < var_9_18 + var_9_19 then
				local var_9_20 = (arg_6_1.time_ - var_9_18) / var_9_19
				local var_9_21 = Color.New(0, 0, 0)

				var_9_21.a = Mathf.Lerp(1, 0, var_9_20)
				arg_6_1.mask_.color = var_9_21
			end

			if arg_6_1.time_ >= var_9_18 + var_9_19 and arg_6_1.time_ < var_9_18 + var_9_19 + arg_9_0 then
				local var_9_22 = Color.New(0, 0, 0)
				local var_9_23 = 0

				arg_6_1.mask_.enabled = false
				var_9_22.a = var_9_23
				arg_6_1.mask_.color = var_9_22
			end

			local var_9_24 = "1111ui_story"

			if arg_6_1.actors_[var_9_24] == nil then
				local var_9_25 = Asset.Load("Char/" .. "1111ui_story")

				if not isNil(var_9_25) then
					local var_9_26 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_6_1.stage_.transform)

					var_9_26.name = var_9_24
					var_9_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_6_1.actors_[var_9_24] = var_9_26

					local var_9_27 = var_9_26:GetComponentInChildren(typeof(CharacterEffect))

					var_9_27.enabled = true

					local var_9_28 = GameObjectTools.GetOrAddComponent(var_9_26, typeof(DynamicBoneHelper))

					if var_9_28 then
						var_9_28:EnableDynamicBone(false)
					end

					arg_6_1:ShowWeapon(var_9_27.transform, false)

					arg_6_1.var_[var_9_24 .. "Animator"] = var_9_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_6_1.var_[var_9_24 .. "Animator"].applyRootMotion = true
					arg_6_1.var_[var_9_24 .. "LipSync"] = var_9_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_9_29 = arg_6_1.actors_["1111ui_story"].transform
			local var_9_30 = 2

			if var_9_30 < arg_6_1.time_ and arg_6_1.time_ <= var_9_30 + arg_9_0 then
				arg_6_1.var_.moveOldPos1111ui_story = var_9_29.localPosition
			end

			local var_9_31 = 0.001

			if var_9_30 <= arg_6_1.time_ and arg_6_1.time_ < var_9_30 + var_9_31 then
				local var_9_32 = (arg_6_1.time_ - var_9_30) / var_9_31
				local var_9_33 = Vector3.New(0, -0.87, -5.7)

				var_9_29.localPosition = Vector3.Lerp(arg_6_1.var_.moveOldPos1111ui_story, var_9_33, var_9_32)

				local var_9_34 = manager.ui.mainCamera.transform.position - var_9_29.position

				var_9_29.forward = Vector3.New(var_9_34.x, var_9_34.y, var_9_34.z)

				local var_9_35 = var_9_29.localEulerAngles

				var_9_35.z = 0
				var_9_35.x = 0
				var_9_29.localEulerAngles = var_9_35
			end

			if arg_6_1.time_ >= var_9_30 + var_9_31 and arg_6_1.time_ < var_9_30 + var_9_31 + arg_9_0 then
				var_9_29.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_9_36 = manager.ui.mainCamera.transform.position - var_9_29.position

				var_9_29.forward = Vector3.New(var_9_36.x, var_9_36.y, var_9_36.z)

				local var_9_37 = var_9_29.localEulerAngles

				var_9_37.z = 0
				var_9_37.x = 0
				var_9_29.localEulerAngles = var_9_37
			end

			local var_9_38 = arg_6_1.actors_["1111ui_story"]
			local var_9_39 = 2

			if var_9_39 < arg_6_1.time_ and arg_6_1.time_ <= var_9_39 + arg_9_0 and not isNil(var_9_38) and arg_6_1.var_.characterEffect1111ui_story == nil then
				arg_6_1.var_.characterEffect1111ui_story = var_9_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_9_40 = 0.200000002980232

			if var_9_39 <= arg_6_1.time_ and arg_6_1.time_ < var_9_39 + var_9_40 and not isNil(var_9_38) then
				local var_9_41 = (arg_6_1.time_ - var_9_39) / var_9_40

				if arg_6_1.var_.characterEffect1111ui_story and not isNil(var_9_38) then
					arg_6_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_6_1.time_ >= var_9_39 + var_9_40 and arg_6_1.time_ < var_9_39 + var_9_40 + arg_9_0 and not isNil(var_9_38) and arg_6_1.var_.characterEffect1111ui_story then
				arg_6_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_9_42 = 2

			if var_9_42 < arg_6_1.time_ and arg_6_1.time_ <= var_9_42 + arg_9_0 then
				arg_6_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			local var_9_43 = 2

			if var_9_43 < arg_6_1.time_ and arg_6_1.time_ <= var_9_43 + arg_9_0 then
				arg_6_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_9_44
			local var_9_45 = 0

			if var_9_45 < arg_6_1.time_ and arg_6_1.time_ <= var_9_45 + arg_9_0 then
				local var_9_46 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_9_46 then
					var_9_46.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_9_46.radialBlurScale = 1
					var_9_46.radialBlurGradient = 1
					var_9_46.radialBlurIntensity = 1

					if var_9_44 then
						var_9_46.radialBlurTarget = var_9_44.transform
					end
				end
			end

			local var_9_47 = 4

			if var_9_45 <= arg_6_1.time_ and arg_6_1.time_ < var_9_45 + var_9_47 then
				local var_9_48 = (arg_6_1.time_ - var_9_45) / var_9_47
				local var_9_49 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_9_49 then
					var_9_49.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_9_49.radialBlurScale = Mathf.Lerp(1, 1, var_9_48)
					var_9_49.radialBlurGradient = Mathf.Lerp(1, 1, var_9_48)
					var_9_49.radialBlurIntensity = Mathf.Lerp(1, 1, var_9_48)
				end
			end

			if arg_6_1.time_ >= var_9_45 + var_9_47 and arg_6_1.time_ < var_9_45 + var_9_47 + arg_9_0 then
				local var_9_50 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_9_50 then
					var_9_50.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_9_50.radialBlurScale = 1
					var_9_50.radialBlurGradient = 1
					var_9_50.radialBlurIntensity = 1
				end
			end

			local var_9_51 = 0
			local var_9_52 = 0.3

			if var_9_51 < arg_6_1.time_ and arg_6_1.time_ <= var_9_51 + arg_9_0 then
				local var_9_53 = "play"
				local var_9_54 = "music"

				arg_6_1:AudioAction(var_9_53, var_9_54, "ui_battle", "ui_battle_stopbgm", "")

				local var_9_55 = ""
				local var_9_56 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_9_56 ~= "" then
					if arg_6_1.bgmTxt_.text ~= var_9_56 and arg_6_1.bgmTxt_.text ~= "" then
						if arg_6_1.bgmTxt2_.text ~= "" then
							arg_6_1.bgmTxt_.text = arg_6_1.bgmTxt2_.text
						end

						arg_6_1.bgmTxt2_.text = var_9_56

						arg_6_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_6_1.bgmTxt_.text = var_9_56
						arg_6_1.bgmTxt2_.text = var_9_56
					end

					if arg_6_1.bgmTimer then
						arg_6_1.bgmTimer:Stop()

						arg_6_1.bgmTimer = nil
					end

					if arg_6_1.settingData.show_music_name == 1 then
						arg_6_1.musicController:SetSelectedState("show")
						arg_6_1.musicAnimator_:Play("open", 0, 0)

						if arg_6_1.settingData.music_time ~= 0 then
							arg_6_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_6_1.settingData.music_time), function()
								if arg_6_1 == nil or isNil(arg_6_1.bgmTxt_) then
									return
								end

								arg_6_1.musicController:SetSelectedState("hide")
								arg_6_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_9_57 = 0.500666666666667
			local var_9_58 = 1

			if var_9_57 < arg_6_1.time_ and arg_6_1.time_ <= var_9_57 + arg_9_0 then
				local var_9_59 = "play"
				local var_9_60 = "music"

				arg_6_1:AudioAction(var_9_59, var_9_60, "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source.awb")

				local var_9_61 = ""
				local var_9_62 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source")

				if var_9_62 ~= "" then
					if arg_6_1.bgmTxt_.text ~= var_9_62 and arg_6_1.bgmTxt_.text ~= "" then
						if arg_6_1.bgmTxt2_.text ~= "" then
							arg_6_1.bgmTxt_.text = arg_6_1.bgmTxt2_.text
						end

						arg_6_1.bgmTxt2_.text = var_9_62

						arg_6_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_6_1.bgmTxt_.text = var_9_62
						arg_6_1.bgmTxt2_.text = var_9_62
					end

					if arg_6_1.bgmTimer then
						arg_6_1.bgmTimer:Stop()

						arg_6_1.bgmTimer = nil
					end

					if arg_6_1.settingData.show_music_name == 1 then
						arg_6_1.musicController:SetSelectedState("show")
						arg_6_1.musicAnimator_:Play("open", 0, 0)

						if arg_6_1.settingData.music_time ~= 0 then
							arg_6_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_6_1.settingData.music_time), function()
								if arg_6_1 == nil or isNil(arg_6_1.bgmTxt_) then
									return
								end

								arg_6_1.musicController:SetSelectedState("hide")
								arg_6_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_9_63 = 0.3
			local var_9_64 = 1

			if var_9_63 < arg_6_1.time_ and arg_6_1.time_ <= var_9_63 + arg_9_0 then
				local var_9_65 = "play"
				local var_9_66 = "effect"

				arg_6_1:AudioAction(var_9_65, var_9_66, "se_story_145", "se_story_145_amb_dark_L09", "")
			end

			local var_9_67 = 0.51
			local var_9_68 = 1

			if var_9_67 < arg_6_1.time_ and arg_6_1.time_ <= var_9_67 + arg_9_0 then
				local var_9_69 = "play"
				local var_9_70 = "music"

				arg_6_1:AudioAction(var_9_69, var_9_70, "bgm_activity_4_5_story_source", "init_story", "bgm_activity_4_5_story_source.awb")

				local var_9_71 = ""
				local var_9_72 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "init_story")

				if var_9_72 ~= "" then
					if arg_6_1.bgmTxt_.text ~= var_9_72 and arg_6_1.bgmTxt_.text ~= "" then
						if arg_6_1.bgmTxt2_.text ~= "" then
							arg_6_1.bgmTxt_.text = arg_6_1.bgmTxt2_.text
						end

						arg_6_1.bgmTxt2_.text = var_9_72

						arg_6_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_6_1.bgmTxt_.text = var_9_72
						arg_6_1.bgmTxt2_.text = var_9_72
					end

					if arg_6_1.bgmTimer then
						arg_6_1.bgmTimer:Stop()

						arg_6_1.bgmTimer = nil
					end

					if arg_6_1.settingData.show_music_name == 1 then
						arg_6_1.musicController:SetSelectedState("show")
						arg_6_1.musicAnimator_:Play("open", 0, 0)

						if arg_6_1.settingData.music_time ~= 0 then
							arg_6_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_6_1.settingData.music_time), function()
								if arg_6_1 == nil or isNil(arg_6_1.bgmTxt_) then
									return
								end

								arg_6_1.musicController:SetSelectedState("hide")
								arg_6_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_73 = 1.999999999999
			local var_9_74 = 0.1

			if var_9_73 < arg_6_1.time_ and arg_6_1.time_ <= var_9_73 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_75 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_75:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_6_1.dialogCg_.alpha = arg_13_0
				end))
				var_9_75:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_75:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, true)

				local var_9_76 = arg_6_1:FormatText(StoryNameCfg[67].name)

				arg_6_1.leftNameTxt_.text = var_9_76

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_1.leftNameTxt_.transform)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1.leftNameTxt_.text)
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_77 = arg_6_1:GetWordFromCfg(322192002)
				local var_9_78 = arg_6_1:FormatText(var_9_77.content)

				arg_6_1.text_.text = var_9_78

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_79 = 4
				local var_9_80 = utf8.len(var_9_78)
				local var_9_81 = var_9_79 <= 0 and var_9_74 or var_9_74 * (var_9_80 / var_9_79)

				if var_9_81 > 0 and var_9_74 < var_9_81 then
					arg_6_1.talkMaxDuration = var_9_81
					var_9_73 = var_9_73 + 0.3

					if var_9_81 + var_9_73 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_81 + var_9_73
					end
				end

				arg_6_1.text_.text = var_9_78
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192002", "story_v_out_322192.awb") ~= 0 then
					local var_9_82 = manager.audio:GetVoiceLength("story_v_out_322192", "322192002", "story_v_out_322192.awb") / 1000

					if var_9_82 + var_9_73 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_82 + var_9_73
					end

					if var_9_77.prefab_name ~= "" and arg_6_1.actors_[var_9_77.prefab_name] ~= nil then
						local var_9_83 = LuaForUtil.PlayVoiceWithCriLipsync(arg_6_1.actors_[var_9_77.prefab_name].transform, "story_v_out_322192", "322192002", "story_v_out_322192.awb")

						arg_6_1:RecordAudio("322192002", var_9_83)
						arg_6_1:RecordAudio("322192002", var_9_83)
					else
						arg_6_1:AudioAction("play", "voice", "story_v_out_322192", "322192002", "story_v_out_322192.awb")
					end

					arg_6_1:RecordHistoryTalkVoice("story_v_out_322192", "322192002", "story_v_out_322192.awb")
				end

				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_84 = var_9_73 + 0.3
			local var_9_85 = math.max(var_9_74, arg_6_1.talkMaxDuration)

			if var_9_84 <= arg_6_1.time_ and arg_6_1.time_ < var_9_84 + var_9_85 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_84) / var_9_85

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_84 + var_9_85 and arg_6_1.time_ < var_9_84 + var_9_85 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				groupID = "1",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_6_1:InitPlayNodeList()
	end,
	Play322192003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 322192003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play322192004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = arg_15_1.actors_["1111ui_story"].transform
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.var_.moveOldPos1111ui_story = var_18_0.localPosition
			end

			local var_18_2 = 0.001

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_2 then
				local var_18_3 = (arg_15_1.time_ - var_18_1) / var_18_2
				local var_18_4 = Vector3.New(0, 100, 0)

				var_18_0.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1111ui_story, var_18_4, var_18_3)

				local var_18_5 = manager.ui.mainCamera.transform.position - var_18_0.position

				var_18_0.forward = Vector3.New(var_18_5.x, var_18_5.y, var_18_5.z)

				local var_18_6 = var_18_0.localEulerAngles

				var_18_6.z = 0
				var_18_6.x = 0
				var_18_0.localEulerAngles = var_18_6
			end

			if arg_15_1.time_ >= var_18_1 + var_18_2 and arg_15_1.time_ < var_18_1 + var_18_2 + arg_18_0 then
				var_18_0.localPosition = Vector3.New(0, 100, 0)

				local var_18_7 = manager.ui.mainCamera.transform.position - var_18_0.position

				var_18_0.forward = Vector3.New(var_18_7.x, var_18_7.y, var_18_7.z)

				local var_18_8 = var_18_0.localEulerAngles

				var_18_8.z = 0
				var_18_8.x = 0
				var_18_0.localEulerAngles = var_18_8
			end

			local var_18_9
			local var_18_10 = 0

			if var_18_10 < arg_15_1.time_ and arg_15_1.time_ <= var_18_10 + arg_18_0 then
				local var_18_11 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_18_11 then
					var_18_11.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_18_11.radialBlurScale = 0
					var_18_11.radialBlurGradient = 1
					var_18_11.radialBlurIntensity = 1

					if var_18_9 then
						var_18_11.radialBlurTarget = var_18_9.transform
					end
				end
			end

			local var_18_12 = 1

			if var_18_10 <= arg_15_1.time_ and arg_15_1.time_ < var_18_10 + var_18_12 then
				local var_18_13 = (arg_15_1.time_ - var_18_10) / var_18_12
				local var_18_14 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_18_14 then
					var_18_14.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_18_14.radialBlurScale = Mathf.Lerp(0, 0, var_18_13)
					var_18_14.radialBlurGradient = Mathf.Lerp(1, 1, var_18_13)
					var_18_14.radialBlurIntensity = Mathf.Lerp(1, 1, var_18_13)
				end
			end

			if arg_15_1.time_ >= var_18_10 + var_18_12 and arg_15_1.time_ < var_18_10 + var_18_12 + arg_18_0 then
				local var_18_15 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_18_15 then
					var_18_15.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_18_15.radialBlurScale = 0
					var_18_15.radialBlurGradient = 1
					var_18_15.radialBlurIntensity = 1
				end
			end

			local var_18_16 = 0
			local var_18_17 = 1.2

			if var_18_16 < arg_15_1.time_ and arg_15_1.time_ <= var_18_16 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_18 = arg_15_1:GetWordFromCfg(322192003)
				local var_18_19 = arg_15_1:FormatText(var_18_18.content)

				arg_15_1.text_.text = var_18_19

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_20 = 48
				local var_18_21 = utf8.len(var_18_19)
				local var_18_22 = var_18_20 <= 0 and var_18_17 or var_18_17 * (var_18_21 / var_18_20)

				if var_18_22 > 0 and var_18_17 < var_18_22 then
					arg_15_1.talkMaxDuration = var_18_22

					if var_18_22 + var_18_16 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_22 + var_18_16
					end
				end

				arg_15_1.text_.text = var_18_19
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_23 = math.max(var_18_17, arg_15_1.talkMaxDuration)

			if var_18_16 <= arg_15_1.time_ and arg_15_1.time_ < var_18_16 + var_18_23 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_16) / var_18_23

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_16 + var_18_23 and arg_15_1.time_ < var_18_16 + var_18_23 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play322192004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 322192004
		arg_19_1.duration_ = 6.47

		local var_19_0 = {
			zh = 4.8,
			ja = 6.466
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play322192005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0
			local var_22_1 = 0.5

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_2 = arg_19_1:FormatText(StoryNameCfg[37].name)

				arg_19_1.leftNameTxt_.text = var_22_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1211")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_3 = arg_19_1:GetWordFromCfg(322192004)
				local var_22_4 = arg_19_1:FormatText(var_22_3.content)

				arg_19_1.text_.text = var_22_4

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 20
				local var_22_6 = utf8.len(var_22_4)
				local var_22_7 = var_22_5 <= 0 and var_22_1 or var_22_1 * (var_22_6 / var_22_5)

				if var_22_7 > 0 and var_22_1 < var_22_7 then
					arg_19_1.talkMaxDuration = var_22_7

					if var_22_7 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_4
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192004", "story_v_out_322192.awb") ~= 0 then
					local var_22_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192004", "story_v_out_322192.awb") / 1000

					if var_22_8 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_0
					end

					if var_22_3.prefab_name ~= "" and arg_19_1.actors_[var_22_3.prefab_name] ~= nil then
						local var_22_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_3.prefab_name].transform, "story_v_out_322192", "322192004", "story_v_out_322192.awb")

						arg_19_1:RecordAudio("322192004", var_22_9)
						arg_19_1:RecordAudio("322192004", var_22_9)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_322192", "322192004", "story_v_out_322192.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_322192", "322192004", "story_v_out_322192.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_10 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_10 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_10

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_10 and arg_19_1.time_ < var_22_0 + var_22_10 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play322192005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 322192005
		arg_23_1.duration_ = 1.73

		local var_23_0 = {
			zh = 1.733,
			ja = 1.533
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play322192006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 0.15

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_2 = arg_23_1:FormatText(StoryNameCfg[67].name)

				arg_23_1.leftNameTxt_.text = var_26_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_3 = arg_23_1:GetWordFromCfg(322192005)
				local var_26_4 = arg_23_1:FormatText(var_26_3.content)

				arg_23_1.text_.text = var_26_4

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 6
				local var_26_6 = utf8.len(var_26_4)
				local var_26_7 = var_26_5 <= 0 and var_26_1 or var_26_1 * (var_26_6 / var_26_5)

				if var_26_7 > 0 and var_26_1 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_4
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192005", "story_v_out_322192.awb") ~= 0 then
					local var_26_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192005", "story_v_out_322192.awb") / 1000

					if var_26_8 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_8 + var_26_0
					end

					if var_26_3.prefab_name ~= "" and arg_23_1.actors_[var_26_3.prefab_name] ~= nil then
						local var_26_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_3.prefab_name].transform, "story_v_out_322192", "322192005", "story_v_out_322192.awb")

						arg_23_1:RecordAudio("322192005", var_26_9)
						arg_23_1:RecordAudio("322192005", var_26_9)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_322192", "322192005", "story_v_out_322192.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_322192", "322192005", "story_v_out_322192.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_10 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_10 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_10

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_10 and arg_23_1.time_ < var_26_0 + var_26_10 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play322192006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 322192006
		arg_27_1.duration_ = 6.2

		local var_27_0 = {
			zh = 4.533,
			ja = 6.2
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play322192007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 1

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				local var_30_1 = manager.ui.mainCamera.transform.localPosition
				local var_30_2 = Vector3.New(0, 0, 10) + Vector3.New(var_30_1.x, var_30_1.y, 0)
				local var_30_3 = arg_27_1.bgs_.L09f

				var_30_3.transform.localPosition = var_30_2
				var_30_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_30_4 = var_30_3:GetComponent("SpriteRenderer")

				if var_30_4 and var_30_4.sprite then
					local var_30_5 = (var_30_3.transform.localPosition - var_30_1).z
					local var_30_6 = manager.ui.mainCameraCom_
					local var_30_7 = 2 * var_30_5 * Mathf.Tan(var_30_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_30_8 = var_30_7 * var_30_6.aspect
					local var_30_9 = var_30_4.sprite.bounds.size.x
					local var_30_10 = var_30_4.sprite.bounds.size.y
					local var_30_11 = var_30_8 / var_30_9
					local var_30_12 = var_30_7 / var_30_10
					local var_30_13 = var_30_12 < var_30_11 and var_30_11 or var_30_12

					var_30_3.transform.localScale = Vector3.New(var_30_13, var_30_13, 0)
				end

				for iter_30_0, iter_30_1 in pairs(arg_27_1.bgs_) do
					if iter_30_0 ~= "L09f" then
						iter_30_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_30_14 = 2

			if var_30_14 < arg_27_1.time_ and arg_27_1.time_ <= var_30_14 + arg_30_0 then
				arg_27_1.allBtn_.enabled = false
			end

			local var_30_15 = 0.225

			if arg_27_1.time_ >= var_30_14 + var_30_15 and arg_27_1.time_ < var_30_14 + var_30_15 + arg_30_0 then
				arg_27_1.allBtn_.enabled = true
			end

			local var_30_16 = 0

			if var_30_16 < arg_27_1.time_ and arg_27_1.time_ <= var_30_16 + arg_30_0 then
				arg_27_1.mask_.enabled = true
				arg_27_1.mask_.raycastTarget = true

				arg_27_1:SetGaussion(false)
			end

			local var_30_17 = 1

			if var_30_16 <= arg_27_1.time_ and arg_27_1.time_ < var_30_16 + var_30_17 then
				local var_30_18 = (arg_27_1.time_ - var_30_16) / var_30_17
				local var_30_19 = Color.New(0, 0, 0)

				var_30_19.a = Mathf.Lerp(0, 1, var_30_18)
				arg_27_1.mask_.color = var_30_19
			end

			if arg_27_1.time_ >= var_30_16 + var_30_17 and arg_27_1.time_ < var_30_16 + var_30_17 + arg_30_0 then
				local var_30_20 = Color.New(0, 0, 0)

				var_30_20.a = 1
				arg_27_1.mask_.color = var_30_20
			end

			local var_30_21 = 1

			if var_30_21 < arg_27_1.time_ and arg_27_1.time_ <= var_30_21 + arg_30_0 then
				arg_27_1.mask_.enabled = true
				arg_27_1.mask_.raycastTarget = true

				arg_27_1:SetGaussion(false)
			end

			local var_30_22 = 1

			if var_30_21 <= arg_27_1.time_ and arg_27_1.time_ < var_30_21 + var_30_22 then
				local var_30_23 = (arg_27_1.time_ - var_30_21) / var_30_22
				local var_30_24 = Color.New(0, 0, 0)

				var_30_24.a = Mathf.Lerp(1, 0, var_30_23)
				arg_27_1.mask_.color = var_30_24
			end

			if arg_27_1.time_ >= var_30_21 + var_30_22 and arg_27_1.time_ < var_30_21 + var_30_22 + arg_30_0 then
				local var_30_25 = Color.New(0, 0, 0)
				local var_30_26 = 0

				arg_27_1.mask_.enabled = false
				var_30_25.a = var_30_26
				arg_27_1.mask_.color = var_30_25
			end

			local var_30_27 = "1211ui_story"

			if arg_27_1.actors_[var_30_27] == nil then
				local var_30_28 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_30_28) then
					local var_30_29 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_27_1.stage_.transform)

					var_30_29.name = var_30_27
					var_30_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_27_1.actors_[var_30_27] = var_30_29

					local var_30_30 = var_30_29:GetComponentInChildren(typeof(CharacterEffect))

					var_30_30.enabled = true

					local var_30_31 = GameObjectTools.GetOrAddComponent(var_30_29, typeof(DynamicBoneHelper))

					if var_30_31 then
						var_30_31:EnableDynamicBone(false)
					end

					arg_27_1:ShowWeapon(var_30_30.transform, false)

					arg_27_1.var_[var_30_27 .. "Animator"] = var_30_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_27_1.var_[var_30_27 .. "Animator"].applyRootMotion = true
					arg_27_1.var_[var_30_27 .. "LipSync"] = var_30_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_30_32 = arg_27_1.actors_["1211ui_story"].transform
			local var_30_33 = 2

			if var_30_33 < arg_27_1.time_ and arg_27_1.time_ <= var_30_33 + arg_30_0 then
				arg_27_1.var_.moveOldPos1211ui_story = var_30_32.localPosition

				local var_30_34 = "1211ui_story"

				arg_27_1:ShowWeapon(arg_27_1.var_[var_30_34 .. "Animator"].transform, false)
			end

			local var_30_35 = 0.001

			if var_30_33 <= arg_27_1.time_ and arg_27_1.time_ < var_30_33 + var_30_35 then
				local var_30_36 = (arg_27_1.time_ - var_30_33) / var_30_35
				local var_30_37 = Vector3.New(-0.7, -0.67, -6.07)

				var_30_32.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1211ui_story, var_30_37, var_30_36)

				local var_30_38 = manager.ui.mainCamera.transform.position - var_30_32.position

				var_30_32.forward = Vector3.New(var_30_38.x, var_30_38.y, var_30_38.z)

				local var_30_39 = var_30_32.localEulerAngles

				var_30_39.z = 0
				var_30_39.x = 0
				var_30_32.localEulerAngles = var_30_39
			end

			if arg_27_1.time_ >= var_30_33 + var_30_35 and arg_27_1.time_ < var_30_33 + var_30_35 + arg_30_0 then
				var_30_32.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_30_40 = manager.ui.mainCamera.transform.position - var_30_32.position

				var_30_32.forward = Vector3.New(var_30_40.x, var_30_40.y, var_30_40.z)

				local var_30_41 = var_30_32.localEulerAngles

				var_30_41.z = 0
				var_30_41.x = 0
				var_30_32.localEulerAngles = var_30_41
			end

			local var_30_42 = arg_27_1.actors_["1211ui_story"]
			local var_30_43 = 2

			if var_30_43 < arg_27_1.time_ and arg_27_1.time_ <= var_30_43 + arg_30_0 and not isNil(var_30_42) and arg_27_1.var_.characterEffect1211ui_story == nil then
				arg_27_1.var_.characterEffect1211ui_story = var_30_42:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_44 = 0.200000002980232

			if var_30_43 <= arg_27_1.time_ and arg_27_1.time_ < var_30_43 + var_30_44 and not isNil(var_30_42) then
				local var_30_45 = (arg_27_1.time_ - var_30_43) / var_30_44

				if arg_27_1.var_.characterEffect1211ui_story and not isNil(var_30_42) then
					arg_27_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_43 + var_30_44 and arg_27_1.time_ < var_30_43 + var_30_44 + arg_30_0 and not isNil(var_30_42) and arg_27_1.var_.characterEffect1211ui_story then
				arg_27_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_30_46 = 2

			if var_30_46 < arg_27_1.time_ and arg_27_1.time_ <= var_30_46 + arg_30_0 then
				arg_27_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action8_1")
			end

			local var_30_47 = 2

			if var_30_47 < arg_27_1.time_ and arg_27_1.time_ <= var_30_47 + arg_30_0 then
				arg_27_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if arg_27_1.frameCnt_ <= 1 then
				arg_27_1.dialog_:SetActive(false)
			end

			local var_30_48 = 2
			local var_30_49 = 0.225

			if var_30_48 < arg_27_1.time_ and arg_27_1.time_ <= var_30_48 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0

				arg_27_1.dialog_:SetActive(true)

				arg_27_1.dialogCg_.alpha = 0

				local var_30_50 = LeanTween.value(arg_27_1.dialog_, 0, 1, 0.3)

				var_30_50:setOnUpdate(LuaHelper.FloatAction(function(arg_31_0)
					arg_27_1.dialogCg_.alpha = arg_31_0
				end))
				var_30_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_27_1.dialog_)
					var_30_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_27_1.duration_ = arg_27_1.duration_ + 0.3

				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_51 = arg_27_1:FormatText(StoryNameCfg[37].name)

				arg_27_1.leftNameTxt_.text = var_30_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_52 = arg_27_1:GetWordFromCfg(322192006)
				local var_30_53 = arg_27_1:FormatText(var_30_52.content)

				arg_27_1.text_.text = var_30_53

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_54 = 9
				local var_30_55 = utf8.len(var_30_53)
				local var_30_56 = var_30_54 <= 0 and var_30_49 or var_30_49 * (var_30_55 / var_30_54)

				if var_30_56 > 0 and var_30_49 < var_30_56 then
					arg_27_1.talkMaxDuration = var_30_56
					var_30_48 = var_30_48 + 0.3

					if var_30_56 + var_30_48 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_56 + var_30_48
					end
				end

				arg_27_1.text_.text = var_30_53
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192006", "story_v_out_322192.awb") ~= 0 then
					local var_30_57 = manager.audio:GetVoiceLength("story_v_out_322192", "322192006", "story_v_out_322192.awb") / 1000

					if var_30_57 + var_30_48 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_57 + var_30_48
					end

					if var_30_52.prefab_name ~= "" and arg_27_1.actors_[var_30_52.prefab_name] ~= nil then
						local var_30_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_52.prefab_name].transform, "story_v_out_322192", "322192006", "story_v_out_322192.awb")

						arg_27_1:RecordAudio("322192006", var_30_58)
						arg_27_1:RecordAudio("322192006", var_30_58)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_322192", "322192006", "story_v_out_322192.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_322192", "322192006", "story_v_out_322192.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_59 = var_30_48 + 0.3
			local var_30_60 = math.max(var_30_49, arg_27_1.talkMaxDuration)

			if var_30_59 <= arg_27_1.time_ and arg_27_1.time_ < var_30_59 + var_30_60 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_59) / var_30_60

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_59 + var_30_60 and arg_27_1.time_ < var_30_59 + var_30_60 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play322192007 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322192007
		arg_33_1.duration_ = 13.43

		local var_33_0 = {
			zh = 6.833,
			ja = 13.433
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play322192008(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1111ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1111ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0.7, -0.87, -5.7)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1111ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1111ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1111ui_story == nil then
				arg_33_1.var_.characterEffect1111ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect1111ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1111ui_story then
				arg_33_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_36_13 = arg_33_1.actors_["1211ui_story"]
			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 and not isNil(var_36_13) and arg_33_1.var_.characterEffect1211ui_story == nil then
				arg_33_1.var_.characterEffect1211ui_story = var_36_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_15 = 0.200000002980232

			if var_36_14 <= arg_33_1.time_ and arg_33_1.time_ < var_36_14 + var_36_15 and not isNil(var_36_13) then
				local var_36_16 = (arg_33_1.time_ - var_36_14) / var_36_15

				if arg_33_1.var_.characterEffect1211ui_story and not isNil(var_36_13) then
					local var_36_17 = Mathf.Lerp(0, 0.5, var_36_16)

					arg_33_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1211ui_story.fillRatio = var_36_17
				end
			end

			if arg_33_1.time_ >= var_36_14 + var_36_15 and arg_33_1.time_ < var_36_14 + var_36_15 + arg_36_0 and not isNil(var_36_13) and arg_33_1.var_.characterEffect1211ui_story then
				local var_36_18 = 0.5

				arg_33_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1211ui_story.fillRatio = var_36_18
			end

			local var_36_19 = 0

			if var_36_19 < arg_33_1.time_ and arg_33_1.time_ <= var_36_19 + arg_36_0 then
				arg_33_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_36_20 = 0

			if var_36_20 < arg_33_1.time_ and arg_33_1.time_ <= var_36_20 + arg_36_0 then
				arg_33_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_36_21 = 0
			local var_36_22 = 0.625

			if var_36_21 < arg_33_1.time_ and arg_33_1.time_ <= var_36_21 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_23 = arg_33_1:FormatText(StoryNameCfg[67].name)

				arg_33_1.leftNameTxt_.text = var_36_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_24 = arg_33_1:GetWordFromCfg(322192007)
				local var_36_25 = arg_33_1:FormatText(var_36_24.content)

				arg_33_1.text_.text = var_36_25

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_26 = 25
				local var_36_27 = utf8.len(var_36_25)
				local var_36_28 = var_36_26 <= 0 and var_36_22 or var_36_22 * (var_36_27 / var_36_26)

				if var_36_28 > 0 and var_36_22 < var_36_28 then
					arg_33_1.talkMaxDuration = var_36_28

					if var_36_28 + var_36_21 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_28 + var_36_21
					end
				end

				arg_33_1.text_.text = var_36_25
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192007", "story_v_out_322192.awb") ~= 0 then
					local var_36_29 = manager.audio:GetVoiceLength("story_v_out_322192", "322192007", "story_v_out_322192.awb") / 1000

					if var_36_29 + var_36_21 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_29 + var_36_21
					end

					if var_36_24.prefab_name ~= "" and arg_33_1.actors_[var_36_24.prefab_name] ~= nil then
						local var_36_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_24.prefab_name].transform, "story_v_out_322192", "322192007", "story_v_out_322192.awb")

						arg_33_1:RecordAudio("322192007", var_36_30)
						arg_33_1:RecordAudio("322192007", var_36_30)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_322192", "322192007", "story_v_out_322192.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_322192", "322192007", "story_v_out_322192.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_31 = math.max(var_36_22, arg_33_1.talkMaxDuration)

			if var_36_21 <= arg_33_1.time_ and arg_33_1.time_ < var_36_21 + var_36_31 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_21) / var_36_31

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_21 + var_36_31 and arg_33_1.time_ < var_36_21 + var_36_31 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play322192008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322192008
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play322192009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1211ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1211ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, 100, 0)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1211ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, 100, 0)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["1111ui_story"].transform
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1.var_.moveOldPos1111ui_story = var_40_9.localPosition
			end

			local var_40_11 = 0.001

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11
				local var_40_13 = Vector3.New(0, 100, 0)

				var_40_9.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1111ui_story, var_40_13, var_40_12)

				local var_40_14 = manager.ui.mainCamera.transform.position - var_40_9.position

				var_40_9.forward = Vector3.New(var_40_14.x, var_40_14.y, var_40_14.z)

				local var_40_15 = var_40_9.localEulerAngles

				var_40_15.z = 0
				var_40_15.x = 0
				var_40_9.localEulerAngles = var_40_15
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 then
				var_40_9.localPosition = Vector3.New(0, 100, 0)

				local var_40_16 = manager.ui.mainCamera.transform.position - var_40_9.position

				var_40_9.forward = Vector3.New(var_40_16.x, var_40_16.y, var_40_16.z)

				local var_40_17 = var_40_9.localEulerAngles

				var_40_17.z = 0
				var_40_17.x = 0
				var_40_9.localEulerAngles = var_40_17
			end

			local var_40_18 = 0

			if var_40_18 < arg_37_1.time_ and arg_37_1.time_ <= var_40_18 + arg_40_0 then
				arg_37_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action8_2")
			end

			local var_40_19 = 0

			if var_40_19 < arg_37_1.time_ and arg_37_1.time_ <= var_40_19 + arg_40_0 then
				arg_37_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_40_20 = 0
			local var_40_21 = 1.7

			if var_40_20 < arg_37_1.time_ and arg_37_1.time_ <= var_40_20 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_22 = arg_37_1:GetWordFromCfg(322192008)
				local var_40_23 = arg_37_1:FormatText(var_40_22.content)

				arg_37_1.text_.text = var_40_23

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_24 = 68
				local var_40_25 = utf8.len(var_40_23)
				local var_40_26 = var_40_24 <= 0 and var_40_21 or var_40_21 * (var_40_25 / var_40_24)

				if var_40_26 > 0 and var_40_21 < var_40_26 then
					arg_37_1.talkMaxDuration = var_40_26

					if var_40_26 + var_40_20 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_26 + var_40_20
					end
				end

				arg_37_1.text_.text = var_40_23
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_27 = math.max(var_40_21, arg_37_1.talkMaxDuration)

			if var_40_20 <= arg_37_1.time_ and arg_37_1.time_ < var_40_20 + var_40_27 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_20) / var_40_27

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_20 + var_40_27 and arg_37_1.time_ < var_40_20 + var_40_27 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play322192009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322192009
		arg_41_1.duration_ = 2.57

		local var_41_0 = {
			zh = 2.366,
			ja = 2.566
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play322192010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1211ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1211ui_story = var_44_0.localPosition

				local var_44_2 = "1211ui_story"

				arg_41_1:ShowWeapon(arg_41_1.var_[var_44_2 .. "Animator"].transform, false)
			end

			local var_44_3 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_3 then
				local var_44_4 = (arg_41_1.time_ - var_44_1) / var_44_3
				local var_44_5 = Vector3.New(-0.7, -0.67, -6.07)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1211ui_story, var_44_5, var_44_4)

				local var_44_6 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_6.x, var_44_6.y, var_44_6.z)

				local var_44_7 = var_44_0.localEulerAngles

				var_44_7.z = 0
				var_44_7.x = 0
				var_44_0.localEulerAngles = var_44_7
			end

			if arg_41_1.time_ >= var_44_1 + var_44_3 and arg_41_1.time_ < var_44_1 + var_44_3 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_44_8 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_8.x, var_44_8.y, var_44_8.z)

				local var_44_9 = var_44_0.localEulerAngles

				var_44_9.z = 0
				var_44_9.x = 0
				var_44_0.localEulerAngles = var_44_9
			end

			local var_44_10 = arg_41_1.actors_["1211ui_story"]
			local var_44_11 = 0

			if var_44_11 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 and not isNil(var_44_10) and arg_41_1.var_.characterEffect1211ui_story == nil then
				arg_41_1.var_.characterEffect1211ui_story = var_44_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_12 = 0.200000002980232

			if var_44_11 <= arg_41_1.time_ and arg_41_1.time_ < var_44_11 + var_44_12 and not isNil(var_44_10) then
				local var_44_13 = (arg_41_1.time_ - var_44_11) / var_44_12

				if arg_41_1.var_.characterEffect1211ui_story and not isNil(var_44_10) then
					arg_41_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_11 + var_44_12 and arg_41_1.time_ < var_44_11 + var_44_12 + arg_44_0 and not isNil(var_44_10) and arg_41_1.var_.characterEffect1211ui_story then
				arg_41_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_44_14 = 0

			if var_44_14 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_44_15 = 0
			local var_44_16 = 0.3

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_17 = arg_41_1:FormatText(StoryNameCfg[37].name)

				arg_41_1.leftNameTxt_.text = var_44_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_18 = arg_41_1:GetWordFromCfg(322192009)
				local var_44_19 = arg_41_1:FormatText(var_44_18.content)

				arg_41_1.text_.text = var_44_19

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_20 = 12
				local var_44_21 = utf8.len(var_44_19)
				local var_44_22 = var_44_20 <= 0 and var_44_16 or var_44_16 * (var_44_21 / var_44_20)

				if var_44_22 > 0 and var_44_16 < var_44_22 then
					arg_41_1.talkMaxDuration = var_44_22

					if var_44_22 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_22 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_19
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192009", "story_v_out_322192.awb") ~= 0 then
					local var_44_23 = manager.audio:GetVoiceLength("story_v_out_322192", "322192009", "story_v_out_322192.awb") / 1000

					if var_44_23 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_15
					end

					if var_44_18.prefab_name ~= "" and arg_41_1.actors_[var_44_18.prefab_name] ~= nil then
						local var_44_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_18.prefab_name].transform, "story_v_out_322192", "322192009", "story_v_out_322192.awb")

						arg_41_1:RecordAudio("322192009", var_44_24)
						arg_41_1:RecordAudio("322192009", var_44_24)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322192", "322192009", "story_v_out_322192.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322192", "322192009", "story_v_out_322192.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_25 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_25 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_25

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_25 and arg_41_1.time_ < var_44_15 + var_44_25 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play322192010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322192010
		arg_45_1.duration_ = 7.07

		local var_45_0 = {
			zh = 4.8,
			ja = 7.066
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play322192011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_2")
			end

			local var_48_1 = 0
			local var_48_2 = 0.45

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_3 = arg_45_1:FormatText(StoryNameCfg[37].name)

				arg_45_1.leftNameTxt_.text = var_48_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(322192010)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 18
				local var_48_7 = utf8.len(var_48_5)
				local var_48_8 = var_48_6 <= 0 and var_48_2 or var_48_2 * (var_48_7 / var_48_6)

				if var_48_8 > 0 and var_48_2 < var_48_8 then
					arg_45_1.talkMaxDuration = var_48_8

					if var_48_8 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192010", "story_v_out_322192.awb") ~= 0 then
					local var_48_9 = manager.audio:GetVoiceLength("story_v_out_322192", "322192010", "story_v_out_322192.awb") / 1000

					if var_48_9 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_1
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_322192", "322192010", "story_v_out_322192.awb")

						arg_45_1:RecordAudio("322192010", var_48_10)
						arg_45_1:RecordAudio("322192010", var_48_10)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_322192", "322192010", "story_v_out_322192.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_322192", "322192010", "story_v_out_322192.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_11 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_11 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_11

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_11 and arg_45_1.time_ < var_48_1 + var_48_11 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play322192011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322192011
		arg_49_1.duration_ = 9.63

		local var_49_0 = {
			zh = 8.3,
			ja = 9.633
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play322192012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1111ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1111ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0.7, -0.87, -5.7)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1111ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["1111ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1111ui_story == nil then
				arg_49_1.var_.characterEffect1111ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect1111ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1111ui_story then
				arg_49_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_52_13 = arg_49_1.actors_["1211ui_story"]
			local var_52_14 = 0

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 and not isNil(var_52_13) and arg_49_1.var_.characterEffect1211ui_story == nil then
				arg_49_1.var_.characterEffect1211ui_story = var_52_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_15 = 0.200000002980232

			if var_52_14 <= arg_49_1.time_ and arg_49_1.time_ < var_52_14 + var_52_15 and not isNil(var_52_13) then
				local var_52_16 = (arg_49_1.time_ - var_52_14) / var_52_15

				if arg_49_1.var_.characterEffect1211ui_story and not isNil(var_52_13) then
					local var_52_17 = Mathf.Lerp(0, 0.5, var_52_16)

					arg_49_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1211ui_story.fillRatio = var_52_17
				end
			end

			if arg_49_1.time_ >= var_52_14 + var_52_15 and arg_49_1.time_ < var_52_14 + var_52_15 + arg_52_0 and not isNil(var_52_13) and arg_49_1.var_.characterEffect1211ui_story then
				local var_52_18 = 0.5

				arg_49_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1211ui_story.fillRatio = var_52_18
			end

			local var_52_19 = 0

			if var_52_19 < arg_49_1.time_ and arg_49_1.time_ <= var_52_19 + arg_52_0 then
				arg_49_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_52_20 = 0

			if var_52_20 < arg_49_1.time_ and arg_49_1.time_ <= var_52_20 + arg_52_0 then
				arg_49_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_52_21 = 0
			local var_52_22 = 0.9

			if var_52_21 < arg_49_1.time_ and arg_49_1.time_ <= var_52_21 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_23 = arg_49_1:FormatText(StoryNameCfg[67].name)

				arg_49_1.leftNameTxt_.text = var_52_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_24 = arg_49_1:GetWordFromCfg(322192011)
				local var_52_25 = arg_49_1:FormatText(var_52_24.content)

				arg_49_1.text_.text = var_52_25

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_26 = 36
				local var_52_27 = utf8.len(var_52_25)
				local var_52_28 = var_52_26 <= 0 and var_52_22 or var_52_22 * (var_52_27 / var_52_26)

				if var_52_28 > 0 and var_52_22 < var_52_28 then
					arg_49_1.talkMaxDuration = var_52_28

					if var_52_28 + var_52_21 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_28 + var_52_21
					end
				end

				arg_49_1.text_.text = var_52_25
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192011", "story_v_out_322192.awb") ~= 0 then
					local var_52_29 = manager.audio:GetVoiceLength("story_v_out_322192", "322192011", "story_v_out_322192.awb") / 1000

					if var_52_29 + var_52_21 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_29 + var_52_21
					end

					if var_52_24.prefab_name ~= "" and arg_49_1.actors_[var_52_24.prefab_name] ~= nil then
						local var_52_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_24.prefab_name].transform, "story_v_out_322192", "322192011", "story_v_out_322192.awb")

						arg_49_1:RecordAudio("322192011", var_52_30)
						arg_49_1:RecordAudio("322192011", var_52_30)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322192", "322192011", "story_v_out_322192.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322192", "322192011", "story_v_out_322192.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_31 = math.max(var_52_22, arg_49_1.talkMaxDuration)

			if var_52_21 <= arg_49_1.time_ and arg_49_1.time_ < var_52_21 + var_52_31 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_21) / var_52_31

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_21 + var_52_31 and arg_49_1.time_ < var_52_21 + var_52_31 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play322192012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322192012
		arg_53_1.duration_ = 4.3

		local var_53_0 = {
			zh = 2.2,
			ja = 4.3
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play322192013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1211ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1211ui_story == nil then
				arg_53_1.var_.characterEffect1211ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1211ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1211ui_story then
				arg_53_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_56_4 = arg_53_1.actors_["1111ui_story"]
			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect1111ui_story == nil then
				arg_53_1.var_.characterEffect1111ui_story = var_56_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_6 = 0.200000002980232

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_6 and not isNil(var_56_4) then
				local var_56_7 = (arg_53_1.time_ - var_56_5) / var_56_6

				if arg_53_1.var_.characterEffect1111ui_story and not isNil(var_56_4) then
					local var_56_8 = Mathf.Lerp(0, 0.5, var_56_7)

					arg_53_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1111ui_story.fillRatio = var_56_8
				end
			end

			if arg_53_1.time_ >= var_56_5 + var_56_6 and arg_53_1.time_ < var_56_5 + var_56_6 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect1111ui_story then
				local var_56_9 = 0.5

				arg_53_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1111ui_story.fillRatio = var_56_9
			end

			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action7_1")
			end

			local var_56_11 = 0
			local var_56_12 = 0.25

			if var_56_11 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_13 = arg_53_1:FormatText(StoryNameCfg[37].name)

				arg_53_1.leftNameTxt_.text = var_56_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_14 = arg_53_1:GetWordFromCfg(322192012)
				local var_56_15 = arg_53_1:FormatText(var_56_14.content)

				arg_53_1.text_.text = var_56_15

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_16 = 10
				local var_56_17 = utf8.len(var_56_15)
				local var_56_18 = var_56_16 <= 0 and var_56_12 or var_56_12 * (var_56_17 / var_56_16)

				if var_56_18 > 0 and var_56_12 < var_56_18 then
					arg_53_1.talkMaxDuration = var_56_18

					if var_56_18 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_11
					end
				end

				arg_53_1.text_.text = var_56_15
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192012", "story_v_out_322192.awb") ~= 0 then
					local var_56_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192012", "story_v_out_322192.awb") / 1000

					if var_56_19 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_19 + var_56_11
					end

					if var_56_14.prefab_name ~= "" and arg_53_1.actors_[var_56_14.prefab_name] ~= nil then
						local var_56_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_14.prefab_name].transform, "story_v_out_322192", "322192012", "story_v_out_322192.awb")

						arg_53_1:RecordAudio("322192012", var_56_20)
						arg_53_1:RecordAudio("322192012", var_56_20)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_322192", "322192012", "story_v_out_322192.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_322192", "322192012", "story_v_out_322192.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_21 = math.max(var_56_12, arg_53_1.talkMaxDuration)

			if var_56_11 <= arg_53_1.time_ and arg_53_1.time_ < var_56_11 + var_56_21 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_11) / var_56_21

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_11 + var_56_21 and arg_53_1.time_ < var_56_11 + var_56_21 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play322192013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322192013
		arg_57_1.duration_ = 9.93

		local var_57_0 = {
			zh = 6.5,
			ja = 9.933
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play322192014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1111ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1111ui_story == nil then
				arg_57_1.var_.characterEffect1111ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1111ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1111ui_story then
				arg_57_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_60_4 = arg_57_1.actors_["1211ui_story"]
			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1211ui_story == nil then
				arg_57_1.var_.characterEffect1211ui_story = var_60_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_6 = 0.200000002980232

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_6 and not isNil(var_60_4) then
				local var_60_7 = (arg_57_1.time_ - var_60_5) / var_60_6

				if arg_57_1.var_.characterEffect1211ui_story and not isNil(var_60_4) then
					local var_60_8 = Mathf.Lerp(0, 0.5, var_60_7)

					arg_57_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1211ui_story.fillRatio = var_60_8
				end
			end

			if arg_57_1.time_ >= var_60_5 + var_60_6 and arg_57_1.time_ < var_60_5 + var_60_6 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1211ui_story then
				local var_60_9 = 0.5

				arg_57_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1211ui_story.fillRatio = var_60_9
			end

			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			local var_60_11 = 0
			local var_60_12 = 0.65

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_13 = arg_57_1:FormatText(StoryNameCfg[67].name)

				arg_57_1.leftNameTxt_.text = var_60_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_14 = arg_57_1:GetWordFromCfg(322192013)
				local var_60_15 = arg_57_1:FormatText(var_60_14.content)

				arg_57_1.text_.text = var_60_15

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_16 = 26
				local var_60_17 = utf8.len(var_60_15)
				local var_60_18 = var_60_16 <= 0 and var_60_12 or var_60_12 * (var_60_17 / var_60_16)

				if var_60_18 > 0 and var_60_12 < var_60_18 then
					arg_57_1.talkMaxDuration = var_60_18

					if var_60_18 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_18 + var_60_11
					end
				end

				arg_57_1.text_.text = var_60_15
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192013", "story_v_out_322192.awb") ~= 0 then
					local var_60_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192013", "story_v_out_322192.awb") / 1000

					if var_60_19 + var_60_11 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_19 + var_60_11
					end

					if var_60_14.prefab_name ~= "" and arg_57_1.actors_[var_60_14.prefab_name] ~= nil then
						local var_60_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_14.prefab_name].transform, "story_v_out_322192", "322192013", "story_v_out_322192.awb")

						arg_57_1:RecordAudio("322192013", var_60_20)
						arg_57_1:RecordAudio("322192013", var_60_20)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_322192", "322192013", "story_v_out_322192.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_322192", "322192013", "story_v_out_322192.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_21 = math.max(var_60_12, arg_57_1.talkMaxDuration)

			if var_60_11 <= arg_57_1.time_ and arg_57_1.time_ < var_60_11 + var_60_21 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_11) / var_60_21

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_11 + var_60_21 and arg_57_1.time_ < var_60_11 + var_60_21 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play322192014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322192014
		arg_61_1.duration_ = 10.17

		local var_61_0 = {
			zh = 6.666,
			ja = 10.166
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play322192015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.75

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[67].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(322192014)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 30
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192014", "story_v_out_322192.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192014", "story_v_out_322192.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_322192", "322192014", "story_v_out_322192.awb")

						arg_61_1:RecordAudio("322192014", var_64_9)
						arg_61_1:RecordAudio("322192014", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_322192", "322192014", "story_v_out_322192.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_322192", "322192014", "story_v_out_322192.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play322192015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322192015
		arg_65_1.duration_ = 5.5

		local var_65_0 = {
			zh = 4.533,
			ja = 5.5
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play322192016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1211ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1211ui_story == nil then
				arg_65_1.var_.characterEffect1211ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1211ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1211ui_story then
				arg_65_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_68_4 = arg_65_1.actors_["1111ui_story"]
			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1111ui_story == nil then
				arg_65_1.var_.characterEffect1111ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.200000002980232

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_6 and not isNil(var_68_4) then
				local var_68_7 = (arg_65_1.time_ - var_68_5) / var_68_6

				if arg_65_1.var_.characterEffect1111ui_story and not isNil(var_68_4) then
					local var_68_8 = Mathf.Lerp(0, 0.5, var_68_7)

					arg_65_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1111ui_story.fillRatio = var_68_8
				end
			end

			if arg_65_1.time_ >= var_68_5 + var_68_6 and arg_65_1.time_ < var_68_5 + var_68_6 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1111ui_story then
				local var_68_9 = 0.5

				arg_65_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1111ui_story.fillRatio = var_68_9
			end

			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action7_2")
			end

			local var_68_11 = 0

			if var_68_11 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_68_12 = 0
			local var_68_13 = 0.5

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_14 = arg_65_1:FormatText(StoryNameCfg[37].name)

				arg_65_1.leftNameTxt_.text = var_68_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:GetWordFromCfg(322192015)
				local var_68_16 = arg_65_1:FormatText(var_68_15.content)

				arg_65_1.text_.text = var_68_16

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 20
				local var_68_18 = utf8.len(var_68_16)
				local var_68_19 = var_68_17 <= 0 and var_68_13 or var_68_13 * (var_68_18 / var_68_17)

				if var_68_19 > 0 and var_68_13 < var_68_19 then
					arg_65_1.talkMaxDuration = var_68_19

					if var_68_19 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_16
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192015", "story_v_out_322192.awb") ~= 0 then
					local var_68_20 = manager.audio:GetVoiceLength("story_v_out_322192", "322192015", "story_v_out_322192.awb") / 1000

					if var_68_20 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_12
					end

					if var_68_15.prefab_name ~= "" and arg_65_1.actors_[var_68_15.prefab_name] ~= nil then
						local var_68_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_15.prefab_name].transform, "story_v_out_322192", "322192015", "story_v_out_322192.awb")

						arg_65_1:RecordAudio("322192015", var_68_21)
						arg_65_1:RecordAudio("322192015", var_68_21)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_322192", "322192015", "story_v_out_322192.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_322192", "322192015", "story_v_out_322192.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_22 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_22 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_12) / var_68_22

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_12 + var_68_22 and arg_65_1.time_ < var_68_12 + var_68_22 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play322192016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 322192016
		arg_69_1.duration_ = 10.3

		local var_69_0 = {
			zh = 6.733,
			ja = 10.3
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play322192017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.825

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[37].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(322192016)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 33
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192016", "story_v_out_322192.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192016", "story_v_out_322192.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_322192", "322192016", "story_v_out_322192.awb")

						arg_69_1:RecordAudio("322192016", var_72_9)
						arg_69_1:RecordAudio("322192016", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_322192", "322192016", "story_v_out_322192.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_322192", "322192016", "story_v_out_322192.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play322192017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 322192017
		arg_73_1.duration_ = 3.1

		local var_73_0 = {
			zh = 3.1,
			ja = 2.9
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play322192018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1111ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1111ui_story == nil then
				arg_73_1.var_.characterEffect1111ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1111ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1111ui_story then
				arg_73_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_76_4 = arg_73_1.actors_["1211ui_story"]
			local var_76_5 = 0

			if var_76_5 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect1211ui_story == nil then
				arg_73_1.var_.characterEffect1211ui_story = var_76_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_6 = 0.200000002980232

			if var_76_5 <= arg_73_1.time_ and arg_73_1.time_ < var_76_5 + var_76_6 and not isNil(var_76_4) then
				local var_76_7 = (arg_73_1.time_ - var_76_5) / var_76_6

				if arg_73_1.var_.characterEffect1211ui_story and not isNil(var_76_4) then
					local var_76_8 = Mathf.Lerp(0, 0.5, var_76_7)

					arg_73_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1211ui_story.fillRatio = var_76_8
				end
			end

			if arg_73_1.time_ >= var_76_5 + var_76_6 and arg_73_1.time_ < var_76_5 + var_76_6 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect1211ui_story then
				local var_76_9 = 0.5

				arg_73_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1211ui_story.fillRatio = var_76_9
			end

			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 then
				arg_73_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_76_11 = 0
			local var_76_12 = 0.2

			if var_76_11 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_13 = arg_73_1:FormatText(StoryNameCfg[67].name)

				arg_73_1.leftNameTxt_.text = var_76_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_14 = arg_73_1:GetWordFromCfg(322192017)
				local var_76_15 = arg_73_1:FormatText(var_76_14.content)

				arg_73_1.text_.text = var_76_15

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_16 = 8
				local var_76_17 = utf8.len(var_76_15)
				local var_76_18 = var_76_16 <= 0 and var_76_12 or var_76_12 * (var_76_17 / var_76_16)

				if var_76_18 > 0 and var_76_12 < var_76_18 then
					arg_73_1.talkMaxDuration = var_76_18

					if var_76_18 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_18 + var_76_11
					end
				end

				arg_73_1.text_.text = var_76_15
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192017", "story_v_out_322192.awb") ~= 0 then
					local var_76_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192017", "story_v_out_322192.awb") / 1000

					if var_76_19 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_11
					end

					if var_76_14.prefab_name ~= "" and arg_73_1.actors_[var_76_14.prefab_name] ~= nil then
						local var_76_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_14.prefab_name].transform, "story_v_out_322192", "322192017", "story_v_out_322192.awb")

						arg_73_1:RecordAudio("322192017", var_76_20)
						arg_73_1:RecordAudio("322192017", var_76_20)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_322192", "322192017", "story_v_out_322192.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_322192", "322192017", "story_v_out_322192.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_21 = math.max(var_76_12, arg_73_1.talkMaxDuration)

			if var_76_11 <= arg_73_1.time_ and arg_73_1.time_ < var_76_11 + var_76_21 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_11) / var_76_21

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_11 + var_76_21 and arg_73_1.time_ < var_76_11 + var_76_21 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play322192018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 322192018
		arg_77_1.duration_ = 4.33

		local var_77_0 = {
			zh = 3.7,
			ja = 4.333
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play322192019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1111ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1111ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, 100, 0)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1111ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, 100, 0)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = "1043ui_story"

			if arg_77_1.actors_[var_80_9] == nil then
				local var_80_10 = Asset.Load("Char/" .. "1043ui_story")

				if not isNil(var_80_10) then
					local var_80_11 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_77_1.stage_.transform)

					var_80_11.name = var_80_9
					var_80_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_77_1.actors_[var_80_9] = var_80_11

					local var_80_12 = var_80_11:GetComponentInChildren(typeof(CharacterEffect))

					var_80_12.enabled = true

					local var_80_13 = GameObjectTools.GetOrAddComponent(var_80_11, typeof(DynamicBoneHelper))

					if var_80_13 then
						var_80_13:EnableDynamicBone(false)
					end

					arg_77_1:ShowWeapon(var_80_12.transform, false)

					arg_77_1.var_[var_80_9 .. "Animator"] = var_80_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_77_1.var_[var_80_9 .. "Animator"].applyRootMotion = true
					arg_77_1.var_[var_80_9 .. "LipSync"] = var_80_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_80_14 = arg_77_1.actors_["1043ui_story"].transform
			local var_80_15 = 0

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.var_.moveOldPos1043ui_story = var_80_14.localPosition
			end

			local var_80_16 = 0.001

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_16 then
				local var_80_17 = (arg_77_1.time_ - var_80_15) / var_80_16
				local var_80_18 = Vector3.New(0.81, -1.01, -5.73)

				var_80_14.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1043ui_story, var_80_18, var_80_17)

				local var_80_19 = manager.ui.mainCamera.transform.position - var_80_14.position

				var_80_14.forward = Vector3.New(var_80_19.x, var_80_19.y, var_80_19.z)

				local var_80_20 = var_80_14.localEulerAngles

				var_80_20.z = 0
				var_80_20.x = 0
				var_80_14.localEulerAngles = var_80_20
			end

			if arg_77_1.time_ >= var_80_15 + var_80_16 and arg_77_1.time_ < var_80_15 + var_80_16 + arg_80_0 then
				var_80_14.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_80_21 = manager.ui.mainCamera.transform.position - var_80_14.position

				var_80_14.forward = Vector3.New(var_80_21.x, var_80_21.y, var_80_21.z)

				local var_80_22 = var_80_14.localEulerAngles

				var_80_22.z = 0
				var_80_22.x = 0
				var_80_14.localEulerAngles = var_80_22
			end

			local var_80_23 = arg_77_1.actors_["1043ui_story"]
			local var_80_24 = 0

			if var_80_24 < arg_77_1.time_ and arg_77_1.time_ <= var_80_24 + arg_80_0 and not isNil(var_80_23) and arg_77_1.var_.characterEffect1043ui_story == nil then
				arg_77_1.var_.characterEffect1043ui_story = var_80_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_25 = 0.200000002980232

			if var_80_24 <= arg_77_1.time_ and arg_77_1.time_ < var_80_24 + var_80_25 and not isNil(var_80_23) then
				local var_80_26 = (arg_77_1.time_ - var_80_24) / var_80_25

				if arg_77_1.var_.characterEffect1043ui_story and not isNil(var_80_23) then
					arg_77_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_24 + var_80_25 and arg_77_1.time_ < var_80_24 + var_80_25 + arg_80_0 and not isNil(var_80_23) and arg_77_1.var_.characterEffect1043ui_story then
				arg_77_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_80_27 = arg_77_1.actors_["1111ui_story"]
			local var_80_28 = 0

			if var_80_28 < arg_77_1.time_ and arg_77_1.time_ <= var_80_28 + arg_80_0 and not isNil(var_80_27) and arg_77_1.var_.characterEffect1111ui_story == nil then
				arg_77_1.var_.characterEffect1111ui_story = var_80_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_29 = 0.200000002980232

			if var_80_28 <= arg_77_1.time_ and arg_77_1.time_ < var_80_28 + var_80_29 and not isNil(var_80_27) then
				local var_80_30 = (arg_77_1.time_ - var_80_28) / var_80_29

				if arg_77_1.var_.characterEffect1111ui_story and not isNil(var_80_27) then
					local var_80_31 = Mathf.Lerp(0, 0.5, var_80_30)

					arg_77_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1111ui_story.fillRatio = var_80_31
				end
			end

			if arg_77_1.time_ >= var_80_28 + var_80_29 and arg_77_1.time_ < var_80_28 + var_80_29 + arg_80_0 and not isNil(var_80_27) and arg_77_1.var_.characterEffect1111ui_story then
				local var_80_32 = 0.5

				arg_77_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1111ui_story.fillRatio = var_80_32
			end

			local var_80_33 = 0

			if var_80_33 < arg_77_1.time_ and arg_77_1.time_ <= var_80_33 + arg_80_0 then
				arg_77_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_80_34 = 0

			if var_80_34 < arg_77_1.time_ and arg_77_1.time_ <= var_80_34 + arg_80_0 then
				arg_77_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_80_35 = 0
			local var_80_36 = 0.425

			if var_80_35 < arg_77_1.time_ and arg_77_1.time_ <= var_80_35 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_37 = arg_77_1:FormatText(StoryNameCfg[1156].name)

				arg_77_1.leftNameTxt_.text = var_80_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_38 = arg_77_1:GetWordFromCfg(322192018)
				local var_80_39 = arg_77_1:FormatText(var_80_38.content)

				arg_77_1.text_.text = var_80_39

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_40 = 17
				local var_80_41 = utf8.len(var_80_39)
				local var_80_42 = var_80_40 <= 0 and var_80_36 or var_80_36 * (var_80_41 / var_80_40)

				if var_80_42 > 0 and var_80_36 < var_80_42 then
					arg_77_1.talkMaxDuration = var_80_42

					if var_80_42 + var_80_35 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_42 + var_80_35
					end
				end

				arg_77_1.text_.text = var_80_39
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192018", "story_v_out_322192.awb") ~= 0 then
					local var_80_43 = manager.audio:GetVoiceLength("story_v_out_322192", "322192018", "story_v_out_322192.awb") / 1000

					if var_80_43 + var_80_35 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_43 + var_80_35
					end

					if var_80_38.prefab_name ~= "" and arg_77_1.actors_[var_80_38.prefab_name] ~= nil then
						local var_80_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_38.prefab_name].transform, "story_v_out_322192", "322192018", "story_v_out_322192.awb")

						arg_77_1:RecordAudio("322192018", var_80_44)
						arg_77_1:RecordAudio("322192018", var_80_44)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_322192", "322192018", "story_v_out_322192.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_322192", "322192018", "story_v_out_322192.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_45 = math.max(var_80_36, arg_77_1.talkMaxDuration)

			if var_80_35 <= arg_77_1.time_ and arg_77_1.time_ < var_80_35 + var_80_45 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_35) / var_80_45

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_35 + var_80_45 and arg_77_1.time_ < var_80_35 + var_80_45 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play322192019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 322192019
		arg_81_1.duration_ = 8.2

		local var_81_0 = {
			zh = 5.966,
			ja = 8.2
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play322192020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1111ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1111ui_story == nil then
				arg_81_1.var_.characterEffect1111ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1111ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1111ui_story then
				arg_81_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_84_4 = arg_81_1.actors_["1043ui_story"]
			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1043ui_story == nil then
				arg_81_1.var_.characterEffect1043ui_story = var_84_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_6 = 0.200000002980232

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_6 and not isNil(var_84_4) then
				local var_84_7 = (arg_81_1.time_ - var_84_5) / var_84_6

				if arg_81_1.var_.characterEffect1043ui_story and not isNil(var_84_4) then
					local var_84_8 = Mathf.Lerp(0, 0.5, var_84_7)

					arg_81_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1043ui_story.fillRatio = var_84_8
				end
			end

			if arg_81_1.time_ >= var_84_5 + var_84_6 and arg_81_1.time_ < var_84_5 + var_84_6 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1043ui_story then
				local var_84_9 = 0.5

				arg_81_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1043ui_story.fillRatio = var_84_9
			end

			local var_84_10 = arg_81_1.actors_["1111ui_story"].transform
			local var_84_11 = 0

			if var_84_11 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1.var_.moveOldPos1111ui_story = var_84_10.localPosition
			end

			local var_84_12 = 0.001

			if var_84_11 <= arg_81_1.time_ and arg_81_1.time_ < var_84_11 + var_84_12 then
				local var_84_13 = (arg_81_1.time_ - var_84_11) / var_84_12
				local var_84_14 = Vector3.New(0, -0.87, -5.7)

				var_84_10.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1111ui_story, var_84_14, var_84_13)

				local var_84_15 = manager.ui.mainCamera.transform.position - var_84_10.position

				var_84_10.forward = Vector3.New(var_84_15.x, var_84_15.y, var_84_15.z)

				local var_84_16 = var_84_10.localEulerAngles

				var_84_16.z = 0
				var_84_16.x = 0
				var_84_10.localEulerAngles = var_84_16
			end

			if arg_81_1.time_ >= var_84_11 + var_84_12 and arg_81_1.time_ < var_84_11 + var_84_12 + arg_84_0 then
				var_84_10.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_84_17 = manager.ui.mainCamera.transform.position - var_84_10.position

				var_84_10.forward = Vector3.New(var_84_17.x, var_84_17.y, var_84_17.z)

				local var_84_18 = var_84_10.localEulerAngles

				var_84_18.z = 0
				var_84_18.x = 0
				var_84_10.localEulerAngles = var_84_18
			end

			local var_84_19 = 0

			if var_84_19 < arg_81_1.time_ and arg_81_1.time_ <= var_84_19 + arg_84_0 then
				arg_81_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_84_20 = arg_81_1.actors_["1211ui_story"].transform
			local var_84_21 = 0

			if var_84_21 < arg_81_1.time_ and arg_81_1.time_ <= var_84_21 + arg_84_0 then
				arg_81_1.var_.moveOldPos1211ui_story = var_84_20.localPosition

				local var_84_22 = "1211ui_story"

				arg_81_1:ShowWeapon(arg_81_1.var_[var_84_22 .. "Animator"].transform, false)
			end

			local var_84_23 = 0.001

			if var_84_21 <= arg_81_1.time_ and arg_81_1.time_ < var_84_21 + var_84_23 then
				local var_84_24 = (arg_81_1.time_ - var_84_21) / var_84_23
				local var_84_25 = Vector3.New(0, 100, 0)

				var_84_20.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1211ui_story, var_84_25, var_84_24)

				local var_84_26 = manager.ui.mainCamera.transform.position - var_84_20.position

				var_84_20.forward = Vector3.New(var_84_26.x, var_84_26.y, var_84_26.z)

				local var_84_27 = var_84_20.localEulerAngles

				var_84_27.z = 0
				var_84_27.x = 0
				var_84_20.localEulerAngles = var_84_27
			end

			if arg_81_1.time_ >= var_84_21 + var_84_23 and arg_81_1.time_ < var_84_21 + var_84_23 + arg_84_0 then
				var_84_20.localPosition = Vector3.New(0, 100, 0)

				local var_84_28 = manager.ui.mainCamera.transform.position - var_84_20.position

				var_84_20.forward = Vector3.New(var_84_28.x, var_84_28.y, var_84_28.z)

				local var_84_29 = var_84_20.localEulerAngles

				var_84_29.z = 0
				var_84_29.x = 0
				var_84_20.localEulerAngles = var_84_29
			end

			local var_84_30 = arg_81_1.actors_["1043ui_story"].transform
			local var_84_31 = 0

			if var_84_31 < arg_81_1.time_ and arg_81_1.time_ <= var_84_31 + arg_84_0 then
				arg_81_1.var_.moveOldPos1043ui_story = var_84_30.localPosition
			end

			local var_84_32 = 0.001

			if var_84_31 <= arg_81_1.time_ and arg_81_1.time_ < var_84_31 + var_84_32 then
				local var_84_33 = (arg_81_1.time_ - var_84_31) / var_84_32
				local var_84_34 = Vector3.New(0, 100, 0)

				var_84_30.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1043ui_story, var_84_34, var_84_33)

				local var_84_35 = manager.ui.mainCamera.transform.position - var_84_30.position

				var_84_30.forward = Vector3.New(var_84_35.x, var_84_35.y, var_84_35.z)

				local var_84_36 = var_84_30.localEulerAngles

				var_84_36.z = 0
				var_84_36.x = 0
				var_84_30.localEulerAngles = var_84_36
			end

			if arg_81_1.time_ >= var_84_31 + var_84_32 and arg_81_1.time_ < var_84_31 + var_84_32 + arg_84_0 then
				var_84_30.localPosition = Vector3.New(0, 100, 0)

				local var_84_37 = manager.ui.mainCamera.transform.position - var_84_30.position

				var_84_30.forward = Vector3.New(var_84_37.x, var_84_37.y, var_84_37.z)

				local var_84_38 = var_84_30.localEulerAngles

				var_84_38.z = 0
				var_84_38.x = 0
				var_84_30.localEulerAngles = var_84_38
			end

			local var_84_39 = 0
			local var_84_40 = 0.725

			if var_84_39 < arg_81_1.time_ and arg_81_1.time_ <= var_84_39 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_41 = arg_81_1:FormatText(StoryNameCfg[67].name)

				arg_81_1.leftNameTxt_.text = var_84_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_42 = arg_81_1:GetWordFromCfg(322192019)
				local var_84_43 = arg_81_1:FormatText(var_84_42.content)

				arg_81_1.text_.text = var_84_43

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_44 = 29
				local var_84_45 = utf8.len(var_84_43)
				local var_84_46 = var_84_44 <= 0 and var_84_40 or var_84_40 * (var_84_45 / var_84_44)

				if var_84_46 > 0 and var_84_40 < var_84_46 then
					arg_81_1.talkMaxDuration = var_84_46

					if var_84_46 + var_84_39 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_46 + var_84_39
					end
				end

				arg_81_1.text_.text = var_84_43
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192019", "story_v_out_322192.awb") ~= 0 then
					local var_84_47 = manager.audio:GetVoiceLength("story_v_out_322192", "322192019", "story_v_out_322192.awb") / 1000

					if var_84_47 + var_84_39 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_47 + var_84_39
					end

					if var_84_42.prefab_name ~= "" and arg_81_1.actors_[var_84_42.prefab_name] ~= nil then
						local var_84_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_42.prefab_name].transform, "story_v_out_322192", "322192019", "story_v_out_322192.awb")

						arg_81_1:RecordAudio("322192019", var_84_48)
						arg_81_1:RecordAudio("322192019", var_84_48)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_322192", "322192019", "story_v_out_322192.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_322192", "322192019", "story_v_out_322192.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_49 = math.max(var_84_40, arg_81_1.talkMaxDuration)

			if var_84_39 <= arg_81_1.time_ and arg_81_1.time_ < var_84_39 + var_84_49 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_39) / var_84_49

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_39 + var_84_49 and arg_81_1.time_ < var_84_39 + var_84_49 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play322192020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 322192020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play322192021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1111ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1111ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, 100, 0)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1111ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, 100, 0)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = 0
			local var_88_10 = 0.4

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_11 = arg_85_1:GetWordFromCfg(322192020)
				local var_88_12 = arg_85_1:FormatText(var_88_11.content)

				arg_85_1.text_.text = var_88_12

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 16
				local var_88_14 = utf8.len(var_88_12)
				local var_88_15 = var_88_13 <= 0 and var_88_10 or var_88_10 * (var_88_14 / var_88_13)

				if var_88_15 > 0 and var_88_10 < var_88_15 then
					arg_85_1.talkMaxDuration = var_88_15

					if var_88_15 + var_88_9 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_15 + var_88_9
					end
				end

				arg_85_1.text_.text = var_88_12
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_10, arg_85_1.talkMaxDuration)

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_9) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_9 + var_88_16 and arg_85_1.time_ < var_88_9 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play322192021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 322192021
		arg_89_1.duration_ = 2.37

		local var_89_0 = {
			zh = 2.366,
			ja = 2.3
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play322192022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1111ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1111ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, -0.87, -5.7)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1111ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["1111ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1111ui_story == nil then
				arg_89_1.var_.characterEffect1111ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect1111ui_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1111ui_story then
				arg_89_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_92_13 = 0

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_92_15 = 0
			local var_92_16 = 0.15

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_17 = arg_89_1:FormatText(StoryNameCfg[67].name)

				arg_89_1.leftNameTxt_.text = var_92_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_18 = arg_89_1:GetWordFromCfg(322192021)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 6
				local var_92_21 = utf8.len(var_92_19)
				local var_92_22 = var_92_20 <= 0 and var_92_16 or var_92_16 * (var_92_21 / var_92_20)

				if var_92_22 > 0 and var_92_16 < var_92_22 then
					arg_89_1.talkMaxDuration = var_92_22

					if var_92_22 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_19
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192021", "story_v_out_322192.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_out_322192", "322192021", "story_v_out_322192.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_out_322192", "322192021", "story_v_out_322192.awb")

						arg_89_1:RecordAudio("322192021", var_92_24)
						arg_89_1:RecordAudio("322192021", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_322192", "322192021", "story_v_out_322192.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_322192", "322192021", "story_v_out_322192.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_25 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_25 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_25

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_25 and arg_89_1.time_ < var_92_15 + var_92_25 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play322192022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 322192022
		arg_93_1.duration_ = 3.67

		local var_93_0 = {
			zh = 2.1,
			ja = 3.666
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play322192023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1111ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1111ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1111ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1211ui_story"].transform
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1.var_.moveOldPos1211ui_story = var_96_9.localPosition
			end

			local var_96_11 = 0.001

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11
				local var_96_13 = Vector3.New(0.7, -0.67, -6.07)

				var_96_9.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1211ui_story, var_96_13, var_96_12)

				local var_96_14 = manager.ui.mainCamera.transform.position - var_96_9.position

				var_96_9.forward = Vector3.New(var_96_14.x, var_96_14.y, var_96_14.z)

				local var_96_15 = var_96_9.localEulerAngles

				var_96_15.z = 0
				var_96_15.x = 0
				var_96_9.localEulerAngles = var_96_15
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 then
				var_96_9.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_96_16 = manager.ui.mainCamera.transform.position - var_96_9.position

				var_96_9.forward = Vector3.New(var_96_16.x, var_96_16.y, var_96_16.z)

				local var_96_17 = var_96_9.localEulerAngles

				var_96_17.z = 0
				var_96_17.x = 0
				var_96_9.localEulerAngles = var_96_17
			end

			local var_96_18 = arg_93_1.actors_["1211ui_story"]
			local var_96_19 = 0

			if var_96_19 < arg_93_1.time_ and arg_93_1.time_ <= var_96_19 + arg_96_0 and not isNil(var_96_18) and arg_93_1.var_.characterEffect1211ui_story == nil then
				arg_93_1.var_.characterEffect1211ui_story = var_96_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_20 = 0.200000002980232

			if var_96_19 <= arg_93_1.time_ and arg_93_1.time_ < var_96_19 + var_96_20 and not isNil(var_96_18) then
				local var_96_21 = (arg_93_1.time_ - var_96_19) / var_96_20

				if arg_93_1.var_.characterEffect1211ui_story and not isNil(var_96_18) then
					arg_93_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_19 + var_96_20 and arg_93_1.time_ < var_96_19 + var_96_20 + arg_96_0 and not isNil(var_96_18) and arg_93_1.var_.characterEffect1211ui_story then
				arg_93_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_96_22 = arg_93_1.actors_["1111ui_story"]
			local var_96_23 = 0

			if var_96_23 < arg_93_1.time_ and arg_93_1.time_ <= var_96_23 + arg_96_0 and not isNil(var_96_22) and arg_93_1.var_.characterEffect1111ui_story == nil then
				arg_93_1.var_.characterEffect1111ui_story = var_96_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_24 = 0.200000002980232

			if var_96_23 <= arg_93_1.time_ and arg_93_1.time_ < var_96_23 + var_96_24 and not isNil(var_96_22) then
				local var_96_25 = (arg_93_1.time_ - var_96_23) / var_96_24

				if arg_93_1.var_.characterEffect1111ui_story and not isNil(var_96_22) then
					local var_96_26 = Mathf.Lerp(0, 0.5, var_96_25)

					arg_93_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1111ui_story.fillRatio = var_96_26
				end
			end

			if arg_93_1.time_ >= var_96_23 + var_96_24 and arg_93_1.time_ < var_96_23 + var_96_24 + arg_96_0 and not isNil(var_96_22) and arg_93_1.var_.characterEffect1111ui_story then
				local var_96_27 = 0.5

				arg_93_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1111ui_story.fillRatio = var_96_27
			end

			local var_96_28 = 0

			if var_96_28 < arg_93_1.time_ and arg_93_1.time_ <= var_96_28 + arg_96_0 then
				arg_93_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action1_1")
			end

			local var_96_29 = 0

			if var_96_29 < arg_93_1.time_ and arg_93_1.time_ <= var_96_29 + arg_96_0 then
				arg_93_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_30 = 0
			local var_96_31 = 0.225

			if var_96_30 < arg_93_1.time_ and arg_93_1.time_ <= var_96_30 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_32 = arg_93_1:FormatText(StoryNameCfg[37].name)

				arg_93_1.leftNameTxt_.text = var_96_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_33 = arg_93_1:GetWordFromCfg(322192022)
				local var_96_34 = arg_93_1:FormatText(var_96_33.content)

				arg_93_1.text_.text = var_96_34

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_35 = 9
				local var_96_36 = utf8.len(var_96_34)
				local var_96_37 = var_96_35 <= 0 and var_96_31 or var_96_31 * (var_96_36 / var_96_35)

				if var_96_37 > 0 and var_96_31 < var_96_37 then
					arg_93_1.talkMaxDuration = var_96_37

					if var_96_37 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_37 + var_96_30
					end
				end

				arg_93_1.text_.text = var_96_34
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192022", "story_v_out_322192.awb") ~= 0 then
					local var_96_38 = manager.audio:GetVoiceLength("story_v_out_322192", "322192022", "story_v_out_322192.awb") / 1000

					if var_96_38 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_38 + var_96_30
					end

					if var_96_33.prefab_name ~= "" and arg_93_1.actors_[var_96_33.prefab_name] ~= nil then
						local var_96_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_33.prefab_name].transform, "story_v_out_322192", "322192022", "story_v_out_322192.awb")

						arg_93_1:RecordAudio("322192022", var_96_39)
						arg_93_1:RecordAudio("322192022", var_96_39)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_322192", "322192022", "story_v_out_322192.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_322192", "322192022", "story_v_out_322192.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_40 = math.max(var_96_31, arg_93_1.talkMaxDuration)

			if var_96_30 <= arg_93_1.time_ and arg_93_1.time_ < var_96_30 + var_96_40 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_30) / var_96_40

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_30 + var_96_40 and arg_93_1.time_ < var_96_30 + var_96_40 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play322192023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322192023
		arg_97_1.duration_ = 8.03

		local var_97_0 = {
			zh = 6.6,
			ja = 8.033
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play322192024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1111ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1111ui_story == nil then
				arg_97_1.var_.characterEffect1111ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1111ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1111ui_story then
				arg_97_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_100_4 = arg_97_1.actors_["1211ui_story"]
			local var_100_5 = 0

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect1211ui_story == nil then
				arg_97_1.var_.characterEffect1211ui_story = var_100_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_6 = 0.200000002980232

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_6 and not isNil(var_100_4) then
				local var_100_7 = (arg_97_1.time_ - var_100_5) / var_100_6

				if arg_97_1.var_.characterEffect1211ui_story and not isNil(var_100_4) then
					local var_100_8 = Mathf.Lerp(0, 0.5, var_100_7)

					arg_97_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1211ui_story.fillRatio = var_100_8
				end
			end

			if arg_97_1.time_ >= var_100_5 + var_100_6 and arg_97_1.time_ < var_100_5 + var_100_6 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect1211ui_story then
				local var_100_9 = 0.5

				arg_97_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1211ui_story.fillRatio = var_100_9
			end

			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 then
				arg_97_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_100_11 = 0
			local var_100_12 = 0.525

			if var_100_11 < arg_97_1.time_ and arg_97_1.time_ <= var_100_11 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_13 = arg_97_1:FormatText(StoryNameCfg[67].name)

				arg_97_1.leftNameTxt_.text = var_100_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_14 = arg_97_1:GetWordFromCfg(322192023)
				local var_100_15 = arg_97_1:FormatText(var_100_14.content)

				arg_97_1.text_.text = var_100_15

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_16 = 21
				local var_100_17 = utf8.len(var_100_15)
				local var_100_18 = var_100_16 <= 0 and var_100_12 or var_100_12 * (var_100_17 / var_100_16)

				if var_100_18 > 0 and var_100_12 < var_100_18 then
					arg_97_1.talkMaxDuration = var_100_18

					if var_100_18 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_18 + var_100_11
					end
				end

				arg_97_1.text_.text = var_100_15
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192023", "story_v_out_322192.awb") ~= 0 then
					local var_100_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192023", "story_v_out_322192.awb") / 1000

					if var_100_19 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_19 + var_100_11
					end

					if var_100_14.prefab_name ~= "" and arg_97_1.actors_[var_100_14.prefab_name] ~= nil then
						local var_100_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_14.prefab_name].transform, "story_v_out_322192", "322192023", "story_v_out_322192.awb")

						arg_97_1:RecordAudio("322192023", var_100_20)
						arg_97_1:RecordAudio("322192023", var_100_20)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_322192", "322192023", "story_v_out_322192.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_322192", "322192023", "story_v_out_322192.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_21 = math.max(var_100_12, arg_97_1.talkMaxDuration)

			if var_100_11 <= arg_97_1.time_ and arg_97_1.time_ < var_100_11 + var_100_21 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_11) / var_100_21

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_11 + var_100_21 and arg_97_1.time_ < var_100_11 + var_100_21 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play322192024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322192024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play322192025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1111ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1111ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, 100, 0)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1111ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, 100, 0)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1211ui_story"].transform
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 then
				arg_101_1.var_.moveOldPos1211ui_story = var_104_9.localPosition
			end

			local var_104_11 = 0.001

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11
				local var_104_13 = Vector3.New(0, 100, 0)

				var_104_9.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1211ui_story, var_104_13, var_104_12)

				local var_104_14 = manager.ui.mainCamera.transform.position - var_104_9.position

				var_104_9.forward = Vector3.New(var_104_14.x, var_104_14.y, var_104_14.z)

				local var_104_15 = var_104_9.localEulerAngles

				var_104_15.z = 0
				var_104_15.x = 0
				var_104_9.localEulerAngles = var_104_15
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 then
				var_104_9.localPosition = Vector3.New(0, 100, 0)

				local var_104_16 = manager.ui.mainCamera.transform.position - var_104_9.position

				var_104_9.forward = Vector3.New(var_104_16.x, var_104_16.y, var_104_16.z)

				local var_104_17 = var_104_9.localEulerAngles

				var_104_17.z = 0
				var_104_17.x = 0
				var_104_9.localEulerAngles = var_104_17
			end

			local var_104_18 = 0.3
			local var_104_19 = 1

			if var_104_18 < arg_101_1.time_ and arg_101_1.time_ <= var_104_18 + arg_104_0 then
				local var_104_20 = "play"
				local var_104_21 = "effect"

				arg_101_1:AudioAction(var_104_20, var_104_21, "se_story_side_1033", "se_story_side_1033_footstep", "")
			end

			local var_104_22 = 0
			local var_104_23 = 0.675

			if var_104_22 < arg_101_1.time_ and arg_101_1.time_ <= var_104_22 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_24 = arg_101_1:GetWordFromCfg(322192024)
				local var_104_25 = arg_101_1:FormatText(var_104_24.content)

				arg_101_1.text_.text = var_104_25

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_26 = 27
				local var_104_27 = utf8.len(var_104_25)
				local var_104_28 = var_104_26 <= 0 and var_104_23 or var_104_23 * (var_104_27 / var_104_26)

				if var_104_28 > 0 and var_104_23 < var_104_28 then
					arg_101_1.talkMaxDuration = var_104_28

					if var_104_28 + var_104_22 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_28 + var_104_22
					end
				end

				arg_101_1.text_.text = var_104_25
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_29 = math.max(var_104_23, arg_101_1.talkMaxDuration)

			if var_104_22 <= arg_101_1.time_ and arg_101_1.time_ < var_104_22 + var_104_29 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_22) / var_104_29

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_22 + var_104_29 and arg_101_1.time_ < var_104_22 + var_104_29 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play322192025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322192025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play322192026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.95

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(322192025)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 38
				local var_108_5 = utf8.len(var_108_3)
				local var_108_6 = var_108_4 <= 0 and var_108_1 or var_108_1 * (var_108_5 / var_108_4)

				if var_108_6 > 0 and var_108_1 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_7 and arg_105_1.time_ < var_108_0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play322192026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322192026
		arg_109_1.duration_ = 3.7

		local var_109_0 = {
			zh = 2.7,
			ja = 3.7
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play322192027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1211ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1211ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, -0.67, -6.07)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1211ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["1211ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1211ui_story == nil then
				arg_109_1.var_.characterEffect1211ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect1211ui_story and not isNil(var_112_9) then
					arg_109_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1211ui_story then
				arg_109_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_1")
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_112_15 = 0
			local var_112_16 = 0.225

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[37].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(322192026)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 9
				local var_112_21 = utf8.len(var_112_19)
				local var_112_22 = var_112_20 <= 0 and var_112_16 or var_112_16 * (var_112_21 / var_112_20)

				if var_112_22 > 0 and var_112_16 < var_112_22 then
					arg_109_1.talkMaxDuration = var_112_22

					if var_112_22 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_22 + var_112_15
					end
				end

				arg_109_1.text_.text = var_112_19
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192026", "story_v_out_322192.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_out_322192", "322192026", "story_v_out_322192.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_out_322192", "322192026", "story_v_out_322192.awb")

						arg_109_1:RecordAudio("322192026", var_112_24)
						arg_109_1:RecordAudio("322192026", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_322192", "322192026", "story_v_out_322192.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_322192", "322192026", "story_v_out_322192.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_25 = math.max(var_112_16, arg_109_1.talkMaxDuration)

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_25 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_15) / var_112_25

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_15 + var_112_25 and arg_109_1.time_ < var_112_15 + var_112_25 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play322192027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 322192027
		arg_113_1.duration_ = 5.8

		local var_113_0 = {
			zh = 4.533,
			ja = 5.8
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play322192028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1111ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1111ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0.7, -0.87, -5.7)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1111ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["1211ui_story"].transform
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				arg_113_1.var_.moveOldPos1211ui_story = var_116_9.localPosition
			end

			local var_116_11 = 0.001

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11
				local var_116_13 = Vector3.New(-0.7, -0.67, -6.07)

				var_116_9.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1211ui_story, var_116_13, var_116_12)

				local var_116_14 = manager.ui.mainCamera.transform.position - var_116_9.position

				var_116_9.forward = Vector3.New(var_116_14.x, var_116_14.y, var_116_14.z)

				local var_116_15 = var_116_9.localEulerAngles

				var_116_15.z = 0
				var_116_15.x = 0
				var_116_9.localEulerAngles = var_116_15
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 then
				var_116_9.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_116_16 = manager.ui.mainCamera.transform.position - var_116_9.position

				var_116_9.forward = Vector3.New(var_116_16.x, var_116_16.y, var_116_16.z)

				local var_116_17 = var_116_9.localEulerAngles

				var_116_17.z = 0
				var_116_17.x = 0
				var_116_9.localEulerAngles = var_116_17
			end

			local var_116_18 = arg_113_1.actors_["1111ui_story"]
			local var_116_19 = 0

			if var_116_19 < arg_113_1.time_ and arg_113_1.time_ <= var_116_19 + arg_116_0 and not isNil(var_116_18) and arg_113_1.var_.characterEffect1111ui_story == nil then
				arg_113_1.var_.characterEffect1111ui_story = var_116_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_20 = 0.200000002980232

			if var_116_19 <= arg_113_1.time_ and arg_113_1.time_ < var_116_19 + var_116_20 and not isNil(var_116_18) then
				local var_116_21 = (arg_113_1.time_ - var_116_19) / var_116_20

				if arg_113_1.var_.characterEffect1111ui_story and not isNil(var_116_18) then
					arg_113_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_19 + var_116_20 and arg_113_1.time_ < var_116_19 + var_116_20 + arg_116_0 and not isNil(var_116_18) and arg_113_1.var_.characterEffect1111ui_story then
				arg_113_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_116_22 = arg_113_1.actors_["1211ui_story"]
			local var_116_23 = 0

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 and not isNil(var_116_22) and arg_113_1.var_.characterEffect1211ui_story == nil then
				arg_113_1.var_.characterEffect1211ui_story = var_116_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_24 = 0.200000002980232

			if var_116_23 <= arg_113_1.time_ and arg_113_1.time_ < var_116_23 + var_116_24 and not isNil(var_116_22) then
				local var_116_25 = (arg_113_1.time_ - var_116_23) / var_116_24

				if arg_113_1.var_.characterEffect1211ui_story and not isNil(var_116_22) then
					local var_116_26 = Mathf.Lerp(0, 0.5, var_116_25)

					arg_113_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1211ui_story.fillRatio = var_116_26
				end
			end

			if arg_113_1.time_ >= var_116_23 + var_116_24 and arg_113_1.time_ < var_116_23 + var_116_24 + arg_116_0 and not isNil(var_116_22) and arg_113_1.var_.characterEffect1211ui_story then
				local var_116_27 = 0.5

				arg_113_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1211ui_story.fillRatio = var_116_27
			end

			local var_116_28 = 0

			if var_116_28 < arg_113_1.time_ and arg_113_1.time_ <= var_116_28 + arg_116_0 then
				arg_113_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_116_29 = 0
			local var_116_30 = 0.45

			if var_116_29 < arg_113_1.time_ and arg_113_1.time_ <= var_116_29 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_31 = arg_113_1:FormatText(StoryNameCfg[67].name)

				arg_113_1.leftNameTxt_.text = var_116_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_32 = arg_113_1:GetWordFromCfg(322192027)
				local var_116_33 = arg_113_1:FormatText(var_116_32.content)

				arg_113_1.text_.text = var_116_33

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_34 = 18
				local var_116_35 = utf8.len(var_116_33)
				local var_116_36 = var_116_34 <= 0 and var_116_30 or var_116_30 * (var_116_35 / var_116_34)

				if var_116_36 > 0 and var_116_30 < var_116_36 then
					arg_113_1.talkMaxDuration = var_116_36

					if var_116_36 + var_116_29 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_36 + var_116_29
					end
				end

				arg_113_1.text_.text = var_116_33
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192027", "story_v_out_322192.awb") ~= 0 then
					local var_116_37 = manager.audio:GetVoiceLength("story_v_out_322192", "322192027", "story_v_out_322192.awb") / 1000

					if var_116_37 + var_116_29 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_37 + var_116_29
					end

					if var_116_32.prefab_name ~= "" and arg_113_1.actors_[var_116_32.prefab_name] ~= nil then
						local var_116_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_32.prefab_name].transform, "story_v_out_322192", "322192027", "story_v_out_322192.awb")

						arg_113_1:RecordAudio("322192027", var_116_38)
						arg_113_1:RecordAudio("322192027", var_116_38)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_322192", "322192027", "story_v_out_322192.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_322192", "322192027", "story_v_out_322192.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_39 = math.max(var_116_30, arg_113_1.talkMaxDuration)

			if var_116_29 <= arg_113_1.time_ and arg_113_1.time_ < var_116_29 + var_116_39 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_29) / var_116_39

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_29 + var_116_39 and arg_113_1.time_ < var_116_29 + var_116_39 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play322192028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 322192028
		arg_117_1.duration_ = 14.7

		local var_117_0 = {
			zh = 8.5,
			ja = 14.7
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play322192029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.975

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[67].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(322192028)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 39
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192028", "story_v_out_322192.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192028", "story_v_out_322192.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_322192", "322192028", "story_v_out_322192.awb")

						arg_117_1:RecordAudio("322192028", var_120_9)
						arg_117_1:RecordAudio("322192028", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_322192", "322192028", "story_v_out_322192.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_322192", "322192028", "story_v_out_322192.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play322192029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 322192029
		arg_121_1.duration_ = 3.73

		local var_121_0 = {
			zh = 3.033,
			ja = 3.733
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play322192030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1111ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1111ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0.7, -0.87, -5.7)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1111ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["1211ui_story"].transform
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 then
				arg_121_1.var_.moveOldPos1211ui_story = var_124_9.localPosition
			end

			local var_124_11 = 0.001

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11
				local var_124_13 = Vector3.New(-0.7, -0.67, -6.07)

				var_124_9.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1211ui_story, var_124_13, var_124_12)

				local var_124_14 = manager.ui.mainCamera.transform.position - var_124_9.position

				var_124_9.forward = Vector3.New(var_124_14.x, var_124_14.y, var_124_14.z)

				local var_124_15 = var_124_9.localEulerAngles

				var_124_15.z = 0
				var_124_15.x = 0
				var_124_9.localEulerAngles = var_124_15
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 then
				var_124_9.localPosition = Vector3.New(-0.7, -0.67, -6.07)

				local var_124_16 = manager.ui.mainCamera.transform.position - var_124_9.position

				var_124_9.forward = Vector3.New(var_124_16.x, var_124_16.y, var_124_16.z)

				local var_124_17 = var_124_9.localEulerAngles

				var_124_17.z = 0
				var_124_17.x = 0
				var_124_9.localEulerAngles = var_124_17
			end

			local var_124_18 = arg_121_1.actors_["1211ui_story"]
			local var_124_19 = 0

			if var_124_19 < arg_121_1.time_ and arg_121_1.time_ <= var_124_19 + arg_124_0 and not isNil(var_124_18) and arg_121_1.var_.characterEffect1211ui_story == nil then
				arg_121_1.var_.characterEffect1211ui_story = var_124_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_20 = 0.200000002980232

			if var_124_19 <= arg_121_1.time_ and arg_121_1.time_ < var_124_19 + var_124_20 and not isNil(var_124_18) then
				local var_124_21 = (arg_121_1.time_ - var_124_19) / var_124_20

				if arg_121_1.var_.characterEffect1211ui_story and not isNil(var_124_18) then
					arg_121_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_19 + var_124_20 and arg_121_1.time_ < var_124_19 + var_124_20 + arg_124_0 and not isNil(var_124_18) and arg_121_1.var_.characterEffect1211ui_story then
				arg_121_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_124_22 = arg_121_1.actors_["1111ui_story"]
			local var_124_23 = 0

			if var_124_23 < arg_121_1.time_ and arg_121_1.time_ <= var_124_23 + arg_124_0 and not isNil(var_124_22) and arg_121_1.var_.characterEffect1111ui_story == nil then
				arg_121_1.var_.characterEffect1111ui_story = var_124_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_24 = 0.200000002980232

			if var_124_23 <= arg_121_1.time_ and arg_121_1.time_ < var_124_23 + var_124_24 and not isNil(var_124_22) then
				local var_124_25 = (arg_121_1.time_ - var_124_23) / var_124_24

				if arg_121_1.var_.characterEffect1111ui_story and not isNil(var_124_22) then
					local var_124_26 = Mathf.Lerp(0, 0.5, var_124_25)

					arg_121_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1111ui_story.fillRatio = var_124_26
				end
			end

			if arg_121_1.time_ >= var_124_23 + var_124_24 and arg_121_1.time_ < var_124_23 + var_124_24 + arg_124_0 and not isNil(var_124_22) and arg_121_1.var_.characterEffect1111ui_story then
				local var_124_27 = 0.5

				arg_121_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1111ui_story.fillRatio = var_124_27
			end

			local var_124_28 = 0

			if var_124_28 < arg_121_1.time_ and arg_121_1.time_ <= var_124_28 + arg_124_0 then
				arg_121_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_124_29 = 0

			if var_124_29 < arg_121_1.time_ and arg_121_1.time_ <= var_124_29 + arg_124_0 then
				arg_121_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_2")
			end

			local var_124_30 = 0
			local var_124_31 = 0.3

			if var_124_30 < arg_121_1.time_ and arg_121_1.time_ <= var_124_30 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_32 = arg_121_1:FormatText(StoryNameCfg[37].name)

				arg_121_1.leftNameTxt_.text = var_124_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_33 = arg_121_1:GetWordFromCfg(322192029)
				local var_124_34 = arg_121_1:FormatText(var_124_33.content)

				arg_121_1.text_.text = var_124_34

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_35 = 12
				local var_124_36 = utf8.len(var_124_34)
				local var_124_37 = var_124_35 <= 0 and var_124_31 or var_124_31 * (var_124_36 / var_124_35)

				if var_124_37 > 0 and var_124_31 < var_124_37 then
					arg_121_1.talkMaxDuration = var_124_37

					if var_124_37 + var_124_30 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_37 + var_124_30
					end
				end

				arg_121_1.text_.text = var_124_34
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192029", "story_v_out_322192.awb") ~= 0 then
					local var_124_38 = manager.audio:GetVoiceLength("story_v_out_322192", "322192029", "story_v_out_322192.awb") / 1000

					if var_124_38 + var_124_30 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_38 + var_124_30
					end

					if var_124_33.prefab_name ~= "" and arg_121_1.actors_[var_124_33.prefab_name] ~= nil then
						local var_124_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_33.prefab_name].transform, "story_v_out_322192", "322192029", "story_v_out_322192.awb")

						arg_121_1:RecordAudio("322192029", var_124_39)
						arg_121_1:RecordAudio("322192029", var_124_39)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_322192", "322192029", "story_v_out_322192.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_322192", "322192029", "story_v_out_322192.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_40 = math.max(var_124_31, arg_121_1.talkMaxDuration)

			if var_124_30 <= arg_121_1.time_ and arg_121_1.time_ < var_124_30 + var_124_40 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_30) / var_124_40

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_30 + var_124_40 and arg_121_1.time_ < var_124_30 + var_124_40 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play322192030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 322192030
		arg_125_1.duration_ = 7.2

		local var_125_0 = {
			zh = 7.2,
			ja = 6.466
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play322192031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1111ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1111ui_story == nil then
				arg_125_1.var_.characterEffect1111ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1111ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1111ui_story then
				arg_125_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_128_4 = arg_125_1.actors_["1211ui_story"]
			local var_128_5 = 0

			if var_128_5 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1211ui_story == nil then
				arg_125_1.var_.characterEffect1211ui_story = var_128_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_6 = 0.200000002980232

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_6 and not isNil(var_128_4) then
				local var_128_7 = (arg_125_1.time_ - var_128_5) / var_128_6

				if arg_125_1.var_.characterEffect1211ui_story and not isNil(var_128_4) then
					local var_128_8 = Mathf.Lerp(0, 0.5, var_128_7)

					arg_125_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1211ui_story.fillRatio = var_128_8
				end
			end

			if arg_125_1.time_ >= var_128_5 + var_128_6 and arg_125_1.time_ < var_128_5 + var_128_6 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1211ui_story then
				local var_128_9 = 0.5

				arg_125_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1211ui_story.fillRatio = var_128_9
			end

			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			local var_128_11 = 0
			local var_128_12 = 0.575

			if var_128_11 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_13 = arg_125_1:FormatText(StoryNameCfg[67].name)

				arg_125_1.leftNameTxt_.text = var_128_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_14 = arg_125_1:GetWordFromCfg(322192030)
				local var_128_15 = arg_125_1:FormatText(var_128_14.content)

				arg_125_1.text_.text = var_128_15

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_16 = 23
				local var_128_17 = utf8.len(var_128_15)
				local var_128_18 = var_128_16 <= 0 and var_128_12 or var_128_12 * (var_128_17 / var_128_16)

				if var_128_18 > 0 and var_128_12 < var_128_18 then
					arg_125_1.talkMaxDuration = var_128_18

					if var_128_18 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_18 + var_128_11
					end
				end

				arg_125_1.text_.text = var_128_15
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192030", "story_v_out_322192.awb") ~= 0 then
					local var_128_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192030", "story_v_out_322192.awb") / 1000

					if var_128_19 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_19 + var_128_11
					end

					if var_128_14.prefab_name ~= "" and arg_125_1.actors_[var_128_14.prefab_name] ~= nil then
						local var_128_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_14.prefab_name].transform, "story_v_out_322192", "322192030", "story_v_out_322192.awb")

						arg_125_1:RecordAudio("322192030", var_128_20)
						arg_125_1:RecordAudio("322192030", var_128_20)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_322192", "322192030", "story_v_out_322192.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_322192", "322192030", "story_v_out_322192.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_21 = math.max(var_128_12, arg_125_1.talkMaxDuration)

			if var_128_11 <= arg_125_1.time_ and arg_125_1.time_ < var_128_11 + var_128_21 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_11) / var_128_21

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_11 + var_128_21 and arg_125_1.time_ < var_128_11 + var_128_21 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play322192031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 322192031
		arg_129_1.duration_ = 4.27

		local var_129_0 = {
			zh = 3.433,
			ja = 4.266
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play322192032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_2")
			end

			local var_132_1 = 0
			local var_132_2 = 0.35

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_3 = arg_129_1:FormatText(StoryNameCfg[67].name)

				arg_129_1.leftNameTxt_.text = var_132_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_4 = arg_129_1:GetWordFromCfg(322192031)
				local var_132_5 = arg_129_1:FormatText(var_132_4.content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 14
				local var_132_7 = utf8.len(var_132_5)
				local var_132_8 = var_132_6 <= 0 and var_132_2 or var_132_2 * (var_132_7 / var_132_6)

				if var_132_8 > 0 and var_132_2 < var_132_8 then
					arg_129_1.talkMaxDuration = var_132_8

					if var_132_8 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192031", "story_v_out_322192.awb") ~= 0 then
					local var_132_9 = manager.audio:GetVoiceLength("story_v_out_322192", "322192031", "story_v_out_322192.awb") / 1000

					if var_132_9 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_1
					end

					if var_132_4.prefab_name ~= "" and arg_129_1.actors_[var_132_4.prefab_name] ~= nil then
						local var_132_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_4.prefab_name].transform, "story_v_out_322192", "322192031", "story_v_out_322192.awb")

						arg_129_1:RecordAudio("322192031", var_132_10)
						arg_129_1:RecordAudio("322192031", var_132_10)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_322192", "322192031", "story_v_out_322192.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_322192", "322192031", "story_v_out_322192.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_11 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_11 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_11

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_11 and arg_129_1.time_ < var_132_1 + var_132_11 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play322192032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 322192032
		arg_133_1.duration_ = 2.73

		local var_133_0 = {
			zh = 2.733,
			ja = 2.5
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play322192033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1211ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1211ui_story == nil then
				arg_133_1.var_.characterEffect1211ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1211ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1211ui_story then
				arg_133_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_136_4 = arg_133_1.actors_["1111ui_story"]
			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect1111ui_story == nil then
				arg_133_1.var_.characterEffect1111ui_story = var_136_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_6 = 0.200000002980232

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_6 and not isNil(var_136_4) then
				local var_136_7 = (arg_133_1.time_ - var_136_5) / var_136_6

				if arg_133_1.var_.characterEffect1111ui_story and not isNil(var_136_4) then
					local var_136_8 = Mathf.Lerp(0, 0.5, var_136_7)

					arg_133_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1111ui_story.fillRatio = var_136_8
				end
			end

			if arg_133_1.time_ >= var_136_5 + var_136_6 and arg_133_1.time_ < var_136_5 + var_136_6 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect1111ui_story then
				local var_136_9 = 0.5

				arg_133_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1111ui_story.fillRatio = var_136_9
			end

			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 then
				arg_133_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action7_1")
			end

			local var_136_11 = 0
			local var_136_12 = 0.2

			if var_136_11 < arg_133_1.time_ and arg_133_1.time_ <= var_136_11 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_13 = arg_133_1:FormatText(StoryNameCfg[37].name)

				arg_133_1.leftNameTxt_.text = var_136_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_14 = arg_133_1:GetWordFromCfg(322192032)
				local var_136_15 = arg_133_1:FormatText(var_136_14.content)

				arg_133_1.text_.text = var_136_15

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_16 = 8
				local var_136_17 = utf8.len(var_136_15)
				local var_136_18 = var_136_16 <= 0 and var_136_12 or var_136_12 * (var_136_17 / var_136_16)

				if var_136_18 > 0 and var_136_12 < var_136_18 then
					arg_133_1.talkMaxDuration = var_136_18

					if var_136_18 + var_136_11 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_18 + var_136_11
					end
				end

				arg_133_1.text_.text = var_136_15
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192032", "story_v_out_322192.awb") ~= 0 then
					local var_136_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192032", "story_v_out_322192.awb") / 1000

					if var_136_19 + var_136_11 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_19 + var_136_11
					end

					if var_136_14.prefab_name ~= "" and arg_133_1.actors_[var_136_14.prefab_name] ~= nil then
						local var_136_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_14.prefab_name].transform, "story_v_out_322192", "322192032", "story_v_out_322192.awb")

						arg_133_1:RecordAudio("322192032", var_136_20)
						arg_133_1:RecordAudio("322192032", var_136_20)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_322192", "322192032", "story_v_out_322192.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_322192", "322192032", "story_v_out_322192.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_21 = math.max(var_136_12, arg_133_1.talkMaxDuration)

			if var_136_11 <= arg_133_1.time_ and arg_133_1.time_ < var_136_11 + var_136_21 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_11) / var_136_21

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_11 + var_136_21 and arg_133_1.time_ < var_136_11 + var_136_21 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play322192033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 322192033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play322192034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1111ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1111ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0, 100, 0)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1111ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, 100, 0)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = arg_137_1.actors_["1211ui_story"].transform
			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 then
				arg_137_1.var_.moveOldPos1211ui_story = var_140_9.localPosition
			end

			local var_140_11 = 0.001

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_11 then
				local var_140_12 = (arg_137_1.time_ - var_140_10) / var_140_11
				local var_140_13 = Vector3.New(0, 100, 0)

				var_140_9.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1211ui_story, var_140_13, var_140_12)

				local var_140_14 = manager.ui.mainCamera.transform.position - var_140_9.position

				var_140_9.forward = Vector3.New(var_140_14.x, var_140_14.y, var_140_14.z)

				local var_140_15 = var_140_9.localEulerAngles

				var_140_15.z = 0
				var_140_15.x = 0
				var_140_9.localEulerAngles = var_140_15
			end

			if arg_137_1.time_ >= var_140_10 + var_140_11 and arg_137_1.time_ < var_140_10 + var_140_11 + arg_140_0 then
				var_140_9.localPosition = Vector3.New(0, 100, 0)

				local var_140_16 = manager.ui.mainCamera.transform.position - var_140_9.position

				var_140_9.forward = Vector3.New(var_140_16.x, var_140_16.y, var_140_16.z)

				local var_140_17 = var_140_9.localEulerAngles

				var_140_17.z = 0
				var_140_17.x = 0
				var_140_9.localEulerAngles = var_140_17
			end

			local var_140_18 = 0
			local var_140_19 = 1.175

			if var_140_18 < arg_137_1.time_ and arg_137_1.time_ <= var_140_18 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_20 = arg_137_1:GetWordFromCfg(322192033)
				local var_140_21 = arg_137_1:FormatText(var_140_20.content)

				arg_137_1.text_.text = var_140_21

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_22 = 47
				local var_140_23 = utf8.len(var_140_21)
				local var_140_24 = var_140_22 <= 0 and var_140_19 or var_140_19 * (var_140_23 / var_140_22)

				if var_140_24 > 0 and var_140_19 < var_140_24 then
					arg_137_1.talkMaxDuration = var_140_24

					if var_140_24 + var_140_18 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_24 + var_140_18
					end
				end

				arg_137_1.text_.text = var_140_21
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_25 = math.max(var_140_19, arg_137_1.talkMaxDuration)

			if var_140_18 <= arg_137_1.time_ and arg_137_1.time_ < var_140_18 + var_140_25 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_18) / var_140_25

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_18 + var_140_25 and arg_137_1.time_ < var_140_18 + var_140_25 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play322192034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 322192034
		arg_141_1.duration_ = 7.13

		local var_141_0 = {
			zh = 5.9,
			ja = 7.133
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play322192035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1111ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1111ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(0, -0.87, -5.7)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1111ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = arg_141_1.actors_["1111ui_story"]
			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1111ui_story == nil then
				arg_141_1.var_.characterEffect1111ui_story = var_144_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_11 = 0.200000002980232

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_11 and not isNil(var_144_9) then
				local var_144_12 = (arg_141_1.time_ - var_144_10) / var_144_11

				if arg_141_1.var_.characterEffect1111ui_story and not isNil(var_144_9) then
					arg_141_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1111ui_story then
				arg_141_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_144_13 = 0

			if var_144_13 < arg_141_1.time_ and arg_141_1.time_ <= var_144_13 + arg_144_0 then
				arg_141_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_144_14 = 0

			if var_144_14 < arg_141_1.time_ and arg_141_1.time_ <= var_144_14 + arg_144_0 then
				arg_141_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_144_15 = 0
			local var_144_16 = 0.625

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_17 = arg_141_1:FormatText(StoryNameCfg[67].name)

				arg_141_1.leftNameTxt_.text = var_144_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_18 = arg_141_1:GetWordFromCfg(322192034)
				local var_144_19 = arg_141_1:FormatText(var_144_18.content)

				arg_141_1.text_.text = var_144_19

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_20 = 25
				local var_144_21 = utf8.len(var_144_19)
				local var_144_22 = var_144_20 <= 0 and var_144_16 or var_144_16 * (var_144_21 / var_144_20)

				if var_144_22 > 0 and var_144_16 < var_144_22 then
					arg_141_1.talkMaxDuration = var_144_22

					if var_144_22 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_22 + var_144_15
					end
				end

				arg_141_1.text_.text = var_144_19
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192034", "story_v_out_322192.awb") ~= 0 then
					local var_144_23 = manager.audio:GetVoiceLength("story_v_out_322192", "322192034", "story_v_out_322192.awb") / 1000

					if var_144_23 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_23 + var_144_15
					end

					if var_144_18.prefab_name ~= "" and arg_141_1.actors_[var_144_18.prefab_name] ~= nil then
						local var_144_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_18.prefab_name].transform, "story_v_out_322192", "322192034", "story_v_out_322192.awb")

						arg_141_1:RecordAudio("322192034", var_144_24)
						arg_141_1:RecordAudio("322192034", var_144_24)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_322192", "322192034", "story_v_out_322192.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_322192", "322192034", "story_v_out_322192.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_25 = math.max(var_144_16, arg_141_1.talkMaxDuration)

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_25 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_15) / var_144_25

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_15 + var_144_25 and arg_141_1.time_ < var_144_15 + var_144_25 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play322192035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 322192035
		arg_145_1.duration_ = 3.73

		local var_145_0 = {
			zh = 2.366,
			ja = 3.733
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play322192036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1111ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1111ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1111ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["1211ui_story"].transform
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.var_.moveOldPos1211ui_story = var_148_9.localPosition
			end

			local var_148_11 = 0.001

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11
				local var_148_13 = Vector3.New(0.7, -0.67, -6.07)

				var_148_9.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1211ui_story, var_148_13, var_148_12)

				local var_148_14 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_14.x, var_148_14.y, var_148_14.z)

				local var_148_15 = var_148_9.localEulerAngles

				var_148_15.z = 0
				var_148_15.x = 0
				var_148_9.localEulerAngles = var_148_15
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 then
				var_148_9.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_148_16 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_16.x, var_148_16.y, var_148_16.z)

				local var_148_17 = var_148_9.localEulerAngles

				var_148_17.z = 0
				var_148_17.x = 0
				var_148_9.localEulerAngles = var_148_17
			end

			local var_148_18 = arg_145_1.actors_["1211ui_story"]
			local var_148_19 = 0

			if var_148_19 < arg_145_1.time_ and arg_145_1.time_ <= var_148_19 + arg_148_0 and not isNil(var_148_18) and arg_145_1.var_.characterEffect1211ui_story == nil then
				arg_145_1.var_.characterEffect1211ui_story = var_148_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_20 = 0.200000002980232

			if var_148_19 <= arg_145_1.time_ and arg_145_1.time_ < var_148_19 + var_148_20 and not isNil(var_148_18) then
				local var_148_21 = (arg_145_1.time_ - var_148_19) / var_148_20

				if arg_145_1.var_.characterEffect1211ui_story and not isNil(var_148_18) then
					arg_145_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_19 + var_148_20 and arg_145_1.time_ < var_148_19 + var_148_20 + arg_148_0 and not isNil(var_148_18) and arg_145_1.var_.characterEffect1211ui_story then
				arg_145_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_148_22 = arg_145_1.actors_["1111ui_story"]
			local var_148_23 = 0

			if var_148_23 < arg_145_1.time_ and arg_145_1.time_ <= var_148_23 + arg_148_0 and not isNil(var_148_22) and arg_145_1.var_.characterEffect1111ui_story == nil then
				arg_145_1.var_.characterEffect1111ui_story = var_148_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_24 = 0.200000002980232

			if var_148_23 <= arg_145_1.time_ and arg_145_1.time_ < var_148_23 + var_148_24 and not isNil(var_148_22) then
				local var_148_25 = (arg_145_1.time_ - var_148_23) / var_148_24

				if arg_145_1.var_.characterEffect1111ui_story and not isNil(var_148_22) then
					local var_148_26 = Mathf.Lerp(0, 0.5, var_148_25)

					arg_145_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1111ui_story.fillRatio = var_148_26
				end
			end

			if arg_145_1.time_ >= var_148_23 + var_148_24 and arg_145_1.time_ < var_148_23 + var_148_24 + arg_148_0 and not isNil(var_148_22) and arg_145_1.var_.characterEffect1111ui_story then
				local var_148_27 = 0.5

				arg_145_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1111ui_story.fillRatio = var_148_27
			end

			local var_148_28 = 0

			if var_148_28 < arg_145_1.time_ and arg_145_1.time_ <= var_148_28 + arg_148_0 then
				arg_145_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action7_2")
			end

			local var_148_29 = 0
			local var_148_30 = 0.25

			if var_148_29 < arg_145_1.time_ and arg_145_1.time_ <= var_148_29 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_31 = arg_145_1:FormatText(StoryNameCfg[37].name)

				arg_145_1.leftNameTxt_.text = var_148_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_32 = arg_145_1:GetWordFromCfg(322192035)
				local var_148_33 = arg_145_1:FormatText(var_148_32.content)

				arg_145_1.text_.text = var_148_33

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_34 = 10
				local var_148_35 = utf8.len(var_148_33)
				local var_148_36 = var_148_34 <= 0 and var_148_30 or var_148_30 * (var_148_35 / var_148_34)

				if var_148_36 > 0 and var_148_30 < var_148_36 then
					arg_145_1.talkMaxDuration = var_148_36

					if var_148_36 + var_148_29 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_36 + var_148_29
					end
				end

				arg_145_1.text_.text = var_148_33
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192035", "story_v_out_322192.awb") ~= 0 then
					local var_148_37 = manager.audio:GetVoiceLength("story_v_out_322192", "322192035", "story_v_out_322192.awb") / 1000

					if var_148_37 + var_148_29 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_37 + var_148_29
					end

					if var_148_32.prefab_name ~= "" and arg_145_1.actors_[var_148_32.prefab_name] ~= nil then
						local var_148_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_32.prefab_name].transform, "story_v_out_322192", "322192035", "story_v_out_322192.awb")

						arg_145_1:RecordAudio("322192035", var_148_38)
						arg_145_1:RecordAudio("322192035", var_148_38)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_322192", "322192035", "story_v_out_322192.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_322192", "322192035", "story_v_out_322192.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_39 = math.max(var_148_30, arg_145_1.talkMaxDuration)

			if var_148_29 <= arg_145_1.time_ and arg_145_1.time_ < var_148_29 + var_148_39 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_29) / var_148_39

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_29 + var_148_39 and arg_145_1.time_ < var_148_29 + var_148_39 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play322192036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 322192036
		arg_149_1.duration_ = 10.67

		local var_149_0 = {
			zh = 10.6,
			ja = 10.666
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play322192037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1111ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1111ui_story == nil then
				arg_149_1.var_.characterEffect1111ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect1111ui_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1111ui_story then
				arg_149_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_152_4 = arg_149_1.actors_["1211ui_story"]
			local var_152_5 = 0

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1211ui_story == nil then
				arg_149_1.var_.characterEffect1211ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_6 = 0.200000002980232

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_6 and not isNil(var_152_4) then
				local var_152_7 = (arg_149_1.time_ - var_152_5) / var_152_6

				if arg_149_1.var_.characterEffect1211ui_story and not isNil(var_152_4) then
					local var_152_8 = Mathf.Lerp(0, 0.5, var_152_7)

					arg_149_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1211ui_story.fillRatio = var_152_8
				end
			end

			if arg_149_1.time_ >= var_152_5 + var_152_6 and arg_149_1.time_ < var_152_5 + var_152_6 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1211ui_story then
				local var_152_9 = 0.5

				arg_149_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1211ui_story.fillRatio = var_152_9
			end

			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_1")
			end

			local var_152_11 = 0
			local var_152_12 = 0.85

			if var_152_11 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_13 = arg_149_1:FormatText(StoryNameCfg[67].name)

				arg_149_1.leftNameTxt_.text = var_152_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_14 = arg_149_1:GetWordFromCfg(322192036)
				local var_152_15 = arg_149_1:FormatText(var_152_14.content)

				arg_149_1.text_.text = var_152_15

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_16 = 34
				local var_152_17 = utf8.len(var_152_15)
				local var_152_18 = var_152_16 <= 0 and var_152_12 or var_152_12 * (var_152_17 / var_152_16)

				if var_152_18 > 0 and var_152_12 < var_152_18 then
					arg_149_1.talkMaxDuration = var_152_18

					if var_152_18 + var_152_11 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_18 + var_152_11
					end
				end

				arg_149_1.text_.text = var_152_15
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192036", "story_v_out_322192.awb") ~= 0 then
					local var_152_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192036", "story_v_out_322192.awb") / 1000

					if var_152_19 + var_152_11 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_19 + var_152_11
					end

					if var_152_14.prefab_name ~= "" and arg_149_1.actors_[var_152_14.prefab_name] ~= nil then
						local var_152_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_14.prefab_name].transform, "story_v_out_322192", "322192036", "story_v_out_322192.awb")

						arg_149_1:RecordAudio("322192036", var_152_20)
						arg_149_1:RecordAudio("322192036", var_152_20)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_322192", "322192036", "story_v_out_322192.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_322192", "322192036", "story_v_out_322192.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_21 = math.max(var_152_12, arg_149_1.talkMaxDuration)

			if var_152_11 <= arg_149_1.time_ and arg_149_1.time_ < var_152_11 + var_152_21 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_11) / var_152_21

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_11 + var_152_21 and arg_149_1.time_ < var_152_11 + var_152_21 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play322192037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 322192037
		arg_153_1.duration_ = 6.3

		local var_153_0 = {
			zh = 4.433,
			ja = 6.3
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play322192038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_2")
			end

			local var_156_1 = 0
			local var_156_2 = 0.275

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_3 = arg_153_1:FormatText(StoryNameCfg[67].name)

				arg_153_1.leftNameTxt_.text = var_156_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_4 = arg_153_1:GetWordFromCfg(322192037)
				local var_156_5 = arg_153_1:FormatText(var_156_4.content)

				arg_153_1.text_.text = var_156_5

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_6 = 11
				local var_156_7 = utf8.len(var_156_5)
				local var_156_8 = var_156_6 <= 0 and var_156_2 or var_156_2 * (var_156_7 / var_156_6)

				if var_156_8 > 0 and var_156_2 < var_156_8 then
					arg_153_1.talkMaxDuration = var_156_8

					if var_156_8 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_5
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192037", "story_v_out_322192.awb") ~= 0 then
					local var_156_9 = manager.audio:GetVoiceLength("story_v_out_322192", "322192037", "story_v_out_322192.awb") / 1000

					if var_156_9 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_1
					end

					if var_156_4.prefab_name ~= "" and arg_153_1.actors_[var_156_4.prefab_name] ~= nil then
						local var_156_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_4.prefab_name].transform, "story_v_out_322192", "322192037", "story_v_out_322192.awb")

						arg_153_1:RecordAudio("322192037", var_156_10)
						arg_153_1:RecordAudio("322192037", var_156_10)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_322192", "322192037", "story_v_out_322192.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_322192", "322192037", "story_v_out_322192.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_11 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_11 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_11

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_11 and arg_153_1.time_ < var_156_1 + var_156_11 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play322192038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 322192038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play322192039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1111ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1111ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(0, 100, 0)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1111ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0, 100, 0)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["1211ui_story"].transform
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1.var_.moveOldPos1211ui_story = var_160_9.localPosition
			end

			local var_160_11 = 0.001

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11
				local var_160_13 = Vector3.New(0, 100, 0)

				var_160_9.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1211ui_story, var_160_13, var_160_12)

				local var_160_14 = manager.ui.mainCamera.transform.position - var_160_9.position

				var_160_9.forward = Vector3.New(var_160_14.x, var_160_14.y, var_160_14.z)

				local var_160_15 = var_160_9.localEulerAngles

				var_160_15.z = 0
				var_160_15.x = 0
				var_160_9.localEulerAngles = var_160_15
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 then
				var_160_9.localPosition = Vector3.New(0, 100, 0)

				local var_160_16 = manager.ui.mainCamera.transform.position - var_160_9.position

				var_160_9.forward = Vector3.New(var_160_16.x, var_160_16.y, var_160_16.z)

				local var_160_17 = var_160_9.localEulerAngles

				var_160_17.z = 0
				var_160_17.x = 0
				var_160_9.localEulerAngles = var_160_17
			end

			local var_160_18 = 0
			local var_160_19 = 1.225

			if var_160_18 < arg_157_1.time_ and arg_157_1.time_ <= var_160_18 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_20 = arg_157_1:GetWordFromCfg(322192038)
				local var_160_21 = arg_157_1:FormatText(var_160_20.content)

				arg_157_1.text_.text = var_160_21

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_22 = 49
				local var_160_23 = utf8.len(var_160_21)
				local var_160_24 = var_160_22 <= 0 and var_160_19 or var_160_19 * (var_160_23 / var_160_22)

				if var_160_24 > 0 and var_160_19 < var_160_24 then
					arg_157_1.talkMaxDuration = var_160_24

					if var_160_24 + var_160_18 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_24 + var_160_18
					end
				end

				arg_157_1.text_.text = var_160_21
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_25 = math.max(var_160_19, arg_157_1.talkMaxDuration)

			if var_160_18 <= arg_157_1.time_ and arg_157_1.time_ < var_160_18 + var_160_25 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_18) / var_160_25

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_18 + var_160_25 and arg_157_1.time_ < var_160_18 + var_160_25 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play322192039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 322192039
		arg_161_1.duration_ = 7.3

		local var_161_0 = {
			zh = 6.233,
			ja = 7.3
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play322192040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.575

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[1020].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:GetWordFromCfg(322192039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 23
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192039", "story_v_out_322192.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192039", "story_v_out_322192.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_322192", "322192039", "story_v_out_322192.awb")

						arg_161_1:RecordAudio("322192039", var_164_9)
						arg_161_1:RecordAudio("322192039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_322192", "322192039", "story_v_out_322192.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_322192", "322192039", "story_v_out_322192.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_10 and arg_161_1.time_ < var_164_0 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play322192040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 322192040
		arg_165_1.duration_ = 1.7

		local var_165_0 = {
			zh = 1.7,
			ja = 1.633
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play322192041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.2

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[591].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:GetWordFromCfg(322192040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 8
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192040", "story_v_out_322192.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192040", "story_v_out_322192.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_322192", "322192040", "story_v_out_322192.awb")

						arg_165_1:RecordAudio("322192040", var_168_9)
						arg_165_1:RecordAudio("322192040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_322192", "322192040", "story_v_out_322192.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_322192", "322192040", "story_v_out_322192.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play322192041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 322192041
		arg_169_1.duration_ = 5.9

		local var_169_0 = {
			zh = 3.5,
			ja = 5.9
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play322192042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1211ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1211ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0, -0.67, -6.07)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1211ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["1211ui_story"]
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1211ui_story == nil then
				arg_169_1.var_.characterEffect1211ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 and not isNil(var_172_9) then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11

				if arg_169_1.var_.characterEffect1211ui_story and not isNil(var_172_9) then
					arg_169_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1211ui_story then
				arg_169_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_172_13 = 0

			if var_172_13 < arg_169_1.time_ and arg_169_1.time_ <= var_172_13 + arg_172_0 then
				arg_169_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action8_1")
			end

			local var_172_14 = 0

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 then
				arg_169_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_172_15 = 0
			local var_172_16 = 0.325

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_17 = arg_169_1:FormatText(StoryNameCfg[37].name)

				arg_169_1.leftNameTxt_.text = var_172_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_18 = arg_169_1:GetWordFromCfg(322192041)
				local var_172_19 = arg_169_1:FormatText(var_172_18.content)

				arg_169_1.text_.text = var_172_19

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_20 = 13
				local var_172_21 = utf8.len(var_172_19)
				local var_172_22 = var_172_20 <= 0 and var_172_16 or var_172_16 * (var_172_21 / var_172_20)

				if var_172_22 > 0 and var_172_16 < var_172_22 then
					arg_169_1.talkMaxDuration = var_172_22

					if var_172_22 + var_172_15 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_22 + var_172_15
					end
				end

				arg_169_1.text_.text = var_172_19
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192041", "story_v_out_322192.awb") ~= 0 then
					local var_172_23 = manager.audio:GetVoiceLength("story_v_out_322192", "322192041", "story_v_out_322192.awb") / 1000

					if var_172_23 + var_172_15 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_23 + var_172_15
					end

					if var_172_18.prefab_name ~= "" and arg_169_1.actors_[var_172_18.prefab_name] ~= nil then
						local var_172_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_18.prefab_name].transform, "story_v_out_322192", "322192041", "story_v_out_322192.awb")

						arg_169_1:RecordAudio("322192041", var_172_24)
						arg_169_1:RecordAudio("322192041", var_172_24)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_322192", "322192041", "story_v_out_322192.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_322192", "322192041", "story_v_out_322192.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_25 = math.max(var_172_16, arg_169_1.talkMaxDuration)

			if var_172_15 <= arg_169_1.time_ and arg_169_1.time_ < var_172_15 + var_172_25 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_15) / var_172_25

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_15 + var_172_25 and arg_169_1.time_ < var_172_15 + var_172_25 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play322192042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 322192042
		arg_173_1.duration_ = 13.77

		local var_173_0 = {
			zh = 6.066,
			ja = 13.766
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play322192043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1211ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1211ui_story == nil then
				arg_173_1.var_.characterEffect1211ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1211ui_story and not isNil(var_176_0) then
					local var_176_4 = Mathf.Lerp(0, 0.5, var_176_3)

					arg_173_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1211ui_story.fillRatio = var_176_4
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1211ui_story then
				local var_176_5 = 0.5

				arg_173_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1211ui_story.fillRatio = var_176_5
			end

			local var_176_6 = 0
			local var_176_7 = 0.8

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_8 = arg_173_1:FormatText(StoryNameCfg[591].name)

				arg_173_1.leftNameTxt_.text = var_176_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_9 = arg_173_1:GetWordFromCfg(322192042)
				local var_176_10 = arg_173_1:FormatText(var_176_9.content)

				arg_173_1.text_.text = var_176_10

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 32
				local var_176_12 = utf8.len(var_176_10)
				local var_176_13 = var_176_11 <= 0 and var_176_7 or var_176_7 * (var_176_12 / var_176_11)

				if var_176_13 > 0 and var_176_7 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_10
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192042", "story_v_out_322192.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192042", "story_v_out_322192.awb") / 1000

					if var_176_14 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_6
					end

					if var_176_9.prefab_name ~= "" and arg_173_1.actors_[var_176_9.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_9.prefab_name].transform, "story_v_out_322192", "322192042", "story_v_out_322192.awb")

						arg_173_1:RecordAudio("322192042", var_176_15)
						arg_173_1:RecordAudio("322192042", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_322192", "322192042", "story_v_out_322192.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_322192", "322192042", "story_v_out_322192.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_16 and arg_173_1.time_ < var_176_6 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play322192043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 322192043
		arg_177_1.duration_ = 15.8

		local var_177_0 = {
			zh = 8.633,
			ja = 15.8
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play322192044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1111ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1111ui_story == nil then
				arg_177_1.var_.characterEffect1111ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1111ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1111ui_story then
				arg_177_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_180_4 = arg_177_1.actors_["1211ui_story"].transform
			local var_180_5 = 0

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.var_.moveOldPos1211ui_story = var_180_4.localPosition
			end

			local var_180_6 = 0.001

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_6 then
				local var_180_7 = (arg_177_1.time_ - var_180_5) / var_180_6
				local var_180_8 = Vector3.New(0, 100, 0)

				var_180_4.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1211ui_story, var_180_8, var_180_7)

				local var_180_9 = manager.ui.mainCamera.transform.position - var_180_4.position

				var_180_4.forward = Vector3.New(var_180_9.x, var_180_9.y, var_180_9.z)

				local var_180_10 = var_180_4.localEulerAngles

				var_180_10.z = 0
				var_180_10.x = 0
				var_180_4.localEulerAngles = var_180_10
			end

			if arg_177_1.time_ >= var_180_5 + var_180_6 and arg_177_1.time_ < var_180_5 + var_180_6 + arg_180_0 then
				var_180_4.localPosition = Vector3.New(0, 100, 0)

				local var_180_11 = manager.ui.mainCamera.transform.position - var_180_4.position

				var_180_4.forward = Vector3.New(var_180_11.x, var_180_11.y, var_180_11.z)

				local var_180_12 = var_180_4.localEulerAngles

				var_180_12.z = 0
				var_180_12.x = 0
				var_180_4.localEulerAngles = var_180_12
			end

			local var_180_13 = arg_177_1.actors_["1111ui_story"].transform
			local var_180_14 = 0

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 then
				arg_177_1.var_.moveOldPos1111ui_story = var_180_13.localPosition
			end

			local var_180_15 = 0.001

			if var_180_14 <= arg_177_1.time_ and arg_177_1.time_ < var_180_14 + var_180_15 then
				local var_180_16 = (arg_177_1.time_ - var_180_14) / var_180_15
				local var_180_17 = Vector3.New(0, -0.87, -5.7)

				var_180_13.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1111ui_story, var_180_17, var_180_16)

				local var_180_18 = manager.ui.mainCamera.transform.position - var_180_13.position

				var_180_13.forward = Vector3.New(var_180_18.x, var_180_18.y, var_180_18.z)

				local var_180_19 = var_180_13.localEulerAngles

				var_180_19.z = 0
				var_180_19.x = 0
				var_180_13.localEulerAngles = var_180_19
			end

			if arg_177_1.time_ >= var_180_14 + var_180_15 and arg_177_1.time_ < var_180_14 + var_180_15 + arg_180_0 then
				var_180_13.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_180_20 = manager.ui.mainCamera.transform.position - var_180_13.position

				var_180_13.forward = Vector3.New(var_180_20.x, var_180_20.y, var_180_20.z)

				local var_180_21 = var_180_13.localEulerAngles

				var_180_21.z = 0
				var_180_21.x = 0
				var_180_13.localEulerAngles = var_180_21
			end

			local var_180_22 = 0

			if var_180_22 < arg_177_1.time_ and arg_177_1.time_ <= var_180_22 + arg_180_0 then
				arg_177_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_180_23 = 0

			if var_180_23 < arg_177_1.time_ and arg_177_1.time_ <= var_180_23 + arg_180_0 then
				arg_177_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_180_24 = 0
			local var_180_25 = 0.85

			if var_180_24 < arg_177_1.time_ and arg_177_1.time_ <= var_180_24 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_26 = arg_177_1:FormatText(StoryNameCfg[67].name)

				arg_177_1.leftNameTxt_.text = var_180_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_27 = arg_177_1:GetWordFromCfg(322192043)
				local var_180_28 = arg_177_1:FormatText(var_180_27.content)

				arg_177_1.text_.text = var_180_28

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_29 = 34
				local var_180_30 = utf8.len(var_180_28)
				local var_180_31 = var_180_29 <= 0 and var_180_25 or var_180_25 * (var_180_30 / var_180_29)

				if var_180_31 > 0 and var_180_25 < var_180_31 then
					arg_177_1.talkMaxDuration = var_180_31

					if var_180_31 + var_180_24 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_31 + var_180_24
					end
				end

				arg_177_1.text_.text = var_180_28
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192043", "story_v_out_322192.awb") ~= 0 then
					local var_180_32 = manager.audio:GetVoiceLength("story_v_out_322192", "322192043", "story_v_out_322192.awb") / 1000

					if var_180_32 + var_180_24 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_32 + var_180_24
					end

					if var_180_27.prefab_name ~= "" and arg_177_1.actors_[var_180_27.prefab_name] ~= nil then
						local var_180_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_27.prefab_name].transform, "story_v_out_322192", "322192043", "story_v_out_322192.awb")

						arg_177_1:RecordAudio("322192043", var_180_33)
						arg_177_1:RecordAudio("322192043", var_180_33)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_322192", "322192043", "story_v_out_322192.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_322192", "322192043", "story_v_out_322192.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_34 = math.max(var_180_25, arg_177_1.talkMaxDuration)

			if var_180_24 <= arg_177_1.time_ and arg_177_1.time_ < var_180_24 + var_180_34 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_24) / var_180_34

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_24 + var_180_34 and arg_177_1.time_ < var_180_24 + var_180_34 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play322192044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 322192044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play322192045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1111ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1111ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0, 100, 0)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1111ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, 100, 0)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = 0
			local var_184_10 = 0.325

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_11 = arg_181_1:GetWordFromCfg(322192044)
				local var_184_12 = arg_181_1:FormatText(var_184_11.content)

				arg_181_1.text_.text = var_184_12

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 13
				local var_184_14 = utf8.len(var_184_12)
				local var_184_15 = var_184_13 <= 0 and var_184_10 or var_184_10 * (var_184_14 / var_184_13)

				if var_184_15 > 0 and var_184_10 < var_184_15 then
					arg_181_1.talkMaxDuration = var_184_15

					if var_184_15 + var_184_9 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_15 + var_184_9
					end
				end

				arg_181_1.text_.text = var_184_12
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_10, arg_181_1.talkMaxDuration)

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_9) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_9 + var_184_16 and arg_181_1.time_ < var_184_9 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play322192045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 322192045
		arg_185_1.duration_ = 5.27

		local var_185_0 = {
			zh = 3.3,
			ja = 5.266
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play322192046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1111ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1111ui_story = var_188_0.localPosition
			end

			local var_188_2 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2
				local var_188_4 = Vector3.New(0, -0.87, -5.7)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1111ui_story, var_188_4, var_188_3)

				local var_188_5 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_5.x, var_188_5.y, var_188_5.z)

				local var_188_6 = var_188_0.localEulerAngles

				var_188_6.z = 0
				var_188_6.x = 0
				var_188_0.localEulerAngles = var_188_6
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_188_7 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_7.x, var_188_7.y, var_188_7.z)

				local var_188_8 = var_188_0.localEulerAngles

				var_188_8.z = 0
				var_188_8.x = 0
				var_188_0.localEulerAngles = var_188_8
			end

			local var_188_9 = arg_185_1.actors_["1111ui_story"]
			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect1111ui_story == nil then
				arg_185_1.var_.characterEffect1111ui_story = var_188_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_11 = 0.200000002980232

			if var_188_10 <= arg_185_1.time_ and arg_185_1.time_ < var_188_10 + var_188_11 and not isNil(var_188_9) then
				local var_188_12 = (arg_185_1.time_ - var_188_10) / var_188_11

				if arg_185_1.var_.characterEffect1111ui_story and not isNil(var_188_9) then
					arg_185_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_10 + var_188_11 and arg_185_1.time_ < var_188_10 + var_188_11 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect1111ui_story then
				arg_185_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_188_13 = 0

			if var_188_13 < arg_185_1.time_ and arg_185_1.time_ <= var_188_13 + arg_188_0 then
				arg_185_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_188_14 = 0

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				arg_185_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_188_15 = 0
			local var_188_16 = 0.35

			if var_188_15 < arg_185_1.time_ and arg_185_1.time_ <= var_188_15 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_17 = arg_185_1:FormatText(StoryNameCfg[67].name)

				arg_185_1.leftNameTxt_.text = var_188_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_18 = arg_185_1:GetWordFromCfg(322192045)
				local var_188_19 = arg_185_1:FormatText(var_188_18.content)

				arg_185_1.text_.text = var_188_19

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_20 = 14
				local var_188_21 = utf8.len(var_188_19)
				local var_188_22 = var_188_20 <= 0 and var_188_16 or var_188_16 * (var_188_21 / var_188_20)

				if var_188_22 > 0 and var_188_16 < var_188_22 then
					arg_185_1.talkMaxDuration = var_188_22

					if var_188_22 + var_188_15 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_22 + var_188_15
					end
				end

				arg_185_1.text_.text = var_188_19
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192045", "story_v_out_322192.awb") ~= 0 then
					local var_188_23 = manager.audio:GetVoiceLength("story_v_out_322192", "322192045", "story_v_out_322192.awb") / 1000

					if var_188_23 + var_188_15 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_23 + var_188_15
					end

					if var_188_18.prefab_name ~= "" and arg_185_1.actors_[var_188_18.prefab_name] ~= nil then
						local var_188_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_18.prefab_name].transform, "story_v_out_322192", "322192045", "story_v_out_322192.awb")

						arg_185_1:RecordAudio("322192045", var_188_24)
						arg_185_1:RecordAudio("322192045", var_188_24)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_322192", "322192045", "story_v_out_322192.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_322192", "322192045", "story_v_out_322192.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_25 = math.max(var_188_16, arg_185_1.talkMaxDuration)

			if var_188_15 <= arg_185_1.time_ and arg_185_1.time_ < var_188_15 + var_188_25 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_15) / var_188_25

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_15 + var_188_25 and arg_185_1.time_ < var_188_15 + var_188_25 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play322192046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 322192046
		arg_189_1.duration_ = 8.9

		local var_189_0 = {
			zh = 6.4,
			ja = 8.9
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play322192047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1111ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1111ui_story == nil then
				arg_189_1.var_.characterEffect1111ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect1111ui_story and not isNil(var_192_0) then
					local var_192_4 = Mathf.Lerp(0, 0.5, var_192_3)

					arg_189_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1111ui_story.fillRatio = var_192_4
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1111ui_story then
				local var_192_5 = 0.5

				arg_189_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1111ui_story.fillRatio = var_192_5
			end

			local var_192_6 = 0
			local var_192_7 = 0.8

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_8 = arg_189_1:FormatText(StoryNameCfg[591].name)

				arg_189_1.leftNameTxt_.text = var_192_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_9 = arg_189_1:GetWordFromCfg(322192046)
				local var_192_10 = arg_189_1:FormatText(var_192_9.content)

				arg_189_1.text_.text = var_192_10

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 32
				local var_192_12 = utf8.len(var_192_10)
				local var_192_13 = var_192_11 <= 0 and var_192_7 or var_192_7 * (var_192_12 / var_192_11)

				if var_192_13 > 0 and var_192_7 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13

					if var_192_13 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_10
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192046", "story_v_out_322192.awb") ~= 0 then
					local var_192_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192046", "story_v_out_322192.awb") / 1000

					if var_192_14 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_14 + var_192_6
					end

					if var_192_9.prefab_name ~= "" and arg_189_1.actors_[var_192_9.prefab_name] ~= nil then
						local var_192_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_9.prefab_name].transform, "story_v_out_322192", "322192046", "story_v_out_322192.awb")

						arg_189_1:RecordAudio("322192046", var_192_15)
						arg_189_1:RecordAudio("322192046", var_192_15)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_322192", "322192046", "story_v_out_322192.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_322192", "322192046", "story_v_out_322192.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_16 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_16 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_16

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_16 and arg_189_1.time_ < var_192_6 + var_192_16 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play322192047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 322192047
		arg_193_1.duration_ = 5.8

		local var_193_0 = {
			zh = 4.4,
			ja = 5.8
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play322192048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1111ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1111ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1111ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["1211ui_story"].transform
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1.var_.moveOldPos1211ui_story = var_196_9.localPosition
			end

			local var_196_11 = 0.001

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11
				local var_196_13 = Vector3.New(0.7, -0.67, -6.07)

				var_196_9.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1211ui_story, var_196_13, var_196_12)

				local var_196_14 = manager.ui.mainCamera.transform.position - var_196_9.position

				var_196_9.forward = Vector3.New(var_196_14.x, var_196_14.y, var_196_14.z)

				local var_196_15 = var_196_9.localEulerAngles

				var_196_15.z = 0
				var_196_15.x = 0
				var_196_9.localEulerAngles = var_196_15
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 then
				var_196_9.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_196_16 = manager.ui.mainCamera.transform.position - var_196_9.position

				var_196_9.forward = Vector3.New(var_196_16.x, var_196_16.y, var_196_16.z)

				local var_196_17 = var_196_9.localEulerAngles

				var_196_17.z = 0
				var_196_17.x = 0
				var_196_9.localEulerAngles = var_196_17
			end

			local var_196_18 = arg_193_1.actors_["1211ui_story"]
			local var_196_19 = 0

			if var_196_19 < arg_193_1.time_ and arg_193_1.time_ <= var_196_19 + arg_196_0 and not isNil(var_196_18) and arg_193_1.var_.characterEffect1211ui_story == nil then
				arg_193_1.var_.characterEffect1211ui_story = var_196_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_20 = 0.200000002980232

			if var_196_19 <= arg_193_1.time_ and arg_193_1.time_ < var_196_19 + var_196_20 and not isNil(var_196_18) then
				local var_196_21 = (arg_193_1.time_ - var_196_19) / var_196_20

				if arg_193_1.var_.characterEffect1211ui_story and not isNil(var_196_18) then
					arg_193_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_19 + var_196_20 and arg_193_1.time_ < var_196_19 + var_196_20 + arg_196_0 and not isNil(var_196_18) and arg_193_1.var_.characterEffect1211ui_story then
				arg_193_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_196_22 = 0

			if var_196_22 < arg_193_1.time_ and arg_193_1.time_ <= var_196_22 + arg_196_0 then
				arg_193_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action2_1")
			end

			local var_196_23 = 0

			if var_196_23 < arg_193_1.time_ and arg_193_1.time_ <= var_196_23 + arg_196_0 then
				arg_193_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_196_24 = 0
			local var_196_25 = 0.45

			if var_196_24 < arg_193_1.time_ and arg_193_1.time_ <= var_196_24 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_26 = arg_193_1:FormatText(StoryNameCfg[37].name)

				arg_193_1.leftNameTxt_.text = var_196_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_27 = arg_193_1:GetWordFromCfg(322192047)
				local var_196_28 = arg_193_1:FormatText(var_196_27.content)

				arg_193_1.text_.text = var_196_28

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_29 = 18
				local var_196_30 = utf8.len(var_196_28)
				local var_196_31 = var_196_29 <= 0 and var_196_25 or var_196_25 * (var_196_30 / var_196_29)

				if var_196_31 > 0 and var_196_25 < var_196_31 then
					arg_193_1.talkMaxDuration = var_196_31

					if var_196_31 + var_196_24 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_31 + var_196_24
					end
				end

				arg_193_1.text_.text = var_196_28
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192047", "story_v_out_322192.awb") ~= 0 then
					local var_196_32 = manager.audio:GetVoiceLength("story_v_out_322192", "322192047", "story_v_out_322192.awb") / 1000

					if var_196_32 + var_196_24 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_32 + var_196_24
					end

					if var_196_27.prefab_name ~= "" and arg_193_1.actors_[var_196_27.prefab_name] ~= nil then
						local var_196_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_27.prefab_name].transform, "story_v_out_322192", "322192047", "story_v_out_322192.awb")

						arg_193_1:RecordAudio("322192047", var_196_33)
						arg_193_1:RecordAudio("322192047", var_196_33)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_322192", "322192047", "story_v_out_322192.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_322192", "322192047", "story_v_out_322192.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_34 = math.max(var_196_25, arg_193_1.talkMaxDuration)

			if var_196_24 <= arg_193_1.time_ and arg_193_1.time_ < var_196_24 + var_196_34 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_24) / var_196_34

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_24 + var_196_34 and arg_193_1.time_ < var_196_24 + var_196_34 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play322192048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 322192048
		arg_197_1.duration_ = 2.47

		local var_197_0 = {
			zh = 1.999999999999,
			ja = 2.466
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play322192049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1111ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos1111ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0, 100, 0)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1111ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, 100, 0)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["1211ui_story"].transform
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 then
				arg_197_1.var_.moveOldPos1211ui_story = var_200_9.localPosition
			end

			local var_200_11 = 0.001

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11
				local var_200_13 = Vector3.New(0, 100, 0)

				var_200_9.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1211ui_story, var_200_13, var_200_12)

				local var_200_14 = manager.ui.mainCamera.transform.position - var_200_9.position

				var_200_9.forward = Vector3.New(var_200_14.x, var_200_14.y, var_200_14.z)

				local var_200_15 = var_200_9.localEulerAngles

				var_200_15.z = 0
				var_200_15.x = 0
				var_200_9.localEulerAngles = var_200_15
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 then
				var_200_9.localPosition = Vector3.New(0, 100, 0)

				local var_200_16 = manager.ui.mainCamera.transform.position - var_200_9.position

				var_200_9.forward = Vector3.New(var_200_16.x, var_200_16.y, var_200_16.z)

				local var_200_17 = var_200_9.localEulerAngles

				var_200_17.z = 0
				var_200_17.x = 0
				var_200_9.localEulerAngles = var_200_17
			end

			local var_200_18 = arg_197_1.actors_["1043ui_story"].transform
			local var_200_19 = 0

			if var_200_19 < arg_197_1.time_ and arg_197_1.time_ <= var_200_19 + arg_200_0 then
				arg_197_1.var_.moveOldPos1043ui_story = var_200_18.localPosition
			end

			local var_200_20 = 0.001

			if var_200_19 <= arg_197_1.time_ and arg_197_1.time_ < var_200_19 + var_200_20 then
				local var_200_21 = (arg_197_1.time_ - var_200_19) / var_200_20
				local var_200_22 = Vector3.New(0.01, -1.01, -5.73)

				var_200_18.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1043ui_story, var_200_22, var_200_21)

				local var_200_23 = manager.ui.mainCamera.transform.position - var_200_18.position

				var_200_18.forward = Vector3.New(var_200_23.x, var_200_23.y, var_200_23.z)

				local var_200_24 = var_200_18.localEulerAngles

				var_200_24.z = 0
				var_200_24.x = 0
				var_200_18.localEulerAngles = var_200_24
			end

			if arg_197_1.time_ >= var_200_19 + var_200_20 and arg_197_1.time_ < var_200_19 + var_200_20 + arg_200_0 then
				var_200_18.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_200_25 = manager.ui.mainCamera.transform.position - var_200_18.position

				var_200_18.forward = Vector3.New(var_200_25.x, var_200_25.y, var_200_25.z)

				local var_200_26 = var_200_18.localEulerAngles

				var_200_26.z = 0
				var_200_26.x = 0
				var_200_18.localEulerAngles = var_200_26
			end

			local var_200_27 = arg_197_1.actors_["1043ui_story"]
			local var_200_28 = 0

			if var_200_28 < arg_197_1.time_ and arg_197_1.time_ <= var_200_28 + arg_200_0 and not isNil(var_200_27) and arg_197_1.var_.characterEffect1043ui_story == nil then
				arg_197_1.var_.characterEffect1043ui_story = var_200_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_29 = 0.200000002980232

			if var_200_28 <= arg_197_1.time_ and arg_197_1.time_ < var_200_28 + var_200_29 and not isNil(var_200_27) then
				local var_200_30 = (arg_197_1.time_ - var_200_28) / var_200_29

				if arg_197_1.var_.characterEffect1043ui_story and not isNil(var_200_27) then
					arg_197_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_28 + var_200_29 and arg_197_1.time_ < var_200_28 + var_200_29 + arg_200_0 and not isNil(var_200_27) and arg_197_1.var_.characterEffect1043ui_story then
				arg_197_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_200_31 = arg_197_1.actors_["1211ui_story"]
			local var_200_32 = 0

			if var_200_32 < arg_197_1.time_ and arg_197_1.time_ <= var_200_32 + arg_200_0 and not isNil(var_200_31) and arg_197_1.var_.characterEffect1211ui_story == nil then
				arg_197_1.var_.characterEffect1211ui_story = var_200_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_33 = 0.200000002980232

			if var_200_32 <= arg_197_1.time_ and arg_197_1.time_ < var_200_32 + var_200_33 and not isNil(var_200_31) then
				local var_200_34 = (arg_197_1.time_ - var_200_32) / var_200_33

				if arg_197_1.var_.characterEffect1211ui_story and not isNil(var_200_31) then
					local var_200_35 = Mathf.Lerp(0, 0.5, var_200_34)

					arg_197_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1211ui_story.fillRatio = var_200_35
				end
			end

			if arg_197_1.time_ >= var_200_32 + var_200_33 and arg_197_1.time_ < var_200_32 + var_200_33 + arg_200_0 and not isNil(var_200_31) and arg_197_1.var_.characterEffect1211ui_story then
				local var_200_36 = 0.5

				arg_197_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1211ui_story.fillRatio = var_200_36
			end

			local var_200_37 = 0

			if var_200_37 < arg_197_1.time_ and arg_197_1.time_ <= var_200_37 + arg_200_0 then
				arg_197_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_1")
			end

			local var_200_38 = 0

			if var_200_38 < arg_197_1.time_ and arg_197_1.time_ <= var_200_38 + arg_200_0 then
				arg_197_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_200_39 = 0
			local var_200_40 = 0.275

			if var_200_39 < arg_197_1.time_ and arg_197_1.time_ <= var_200_39 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_41 = arg_197_1:FormatText(StoryNameCfg[1156].name)

				arg_197_1.leftNameTxt_.text = var_200_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_42 = arg_197_1:GetWordFromCfg(322192048)
				local var_200_43 = arg_197_1:FormatText(var_200_42.content)

				arg_197_1.text_.text = var_200_43

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_44 = 11
				local var_200_45 = utf8.len(var_200_43)
				local var_200_46 = var_200_44 <= 0 and var_200_40 or var_200_40 * (var_200_45 / var_200_44)

				if var_200_46 > 0 and var_200_40 < var_200_46 then
					arg_197_1.talkMaxDuration = var_200_46

					if var_200_46 + var_200_39 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_46 + var_200_39
					end
				end

				arg_197_1.text_.text = var_200_43
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192048", "story_v_out_322192.awb") ~= 0 then
					local var_200_47 = manager.audio:GetVoiceLength("story_v_out_322192", "322192048", "story_v_out_322192.awb") / 1000

					if var_200_47 + var_200_39 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_47 + var_200_39
					end

					if var_200_42.prefab_name ~= "" and arg_197_1.actors_[var_200_42.prefab_name] ~= nil then
						local var_200_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_42.prefab_name].transform, "story_v_out_322192", "322192048", "story_v_out_322192.awb")

						arg_197_1:RecordAudio("322192048", var_200_48)
						arg_197_1:RecordAudio("322192048", var_200_48)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_322192", "322192048", "story_v_out_322192.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_322192", "322192048", "story_v_out_322192.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_49 = math.max(var_200_40, arg_197_1.talkMaxDuration)

			if var_200_39 <= arg_197_1.time_ and arg_197_1.time_ < var_200_39 + var_200_49 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_39) / var_200_49

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_39 + var_200_49 and arg_197_1.time_ < var_200_39 + var_200_49 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play322192049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 322192049
		arg_201_1.duration_ = 12.5

		local var_201_0 = {
			zh = 8.566,
			ja = 12.5
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play322192050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 1.025

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[1156].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(322192049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 41
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_1 or var_204_1 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_1 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192049", "story_v_out_322192.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192049", "story_v_out_322192.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_322192", "322192049", "story_v_out_322192.awb")

						arg_201_1:RecordAudio("322192049", var_204_9)
						arg_201_1:RecordAudio("322192049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_322192", "322192049", "story_v_out_322192.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_322192", "322192049", "story_v_out_322192.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_10 and arg_201_1.time_ < var_204_0 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play322192050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 322192050
		arg_205_1.duration_ = 5.33

		local var_205_0 = {
			zh = 4.633,
			ja = 5.333
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play322192051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_2")
			end

			local var_208_1 = 0
			local var_208_2 = 0.55

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_3 = arg_205_1:FormatText(StoryNameCfg[1156].name)

				arg_205_1.leftNameTxt_.text = var_208_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_4 = arg_205_1:GetWordFromCfg(322192050)
				local var_208_5 = arg_205_1:FormatText(var_208_4.content)

				arg_205_1.text_.text = var_208_5

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_6 = 22
				local var_208_7 = utf8.len(var_208_5)
				local var_208_8 = var_208_6 <= 0 and var_208_2 or var_208_2 * (var_208_7 / var_208_6)

				if var_208_8 > 0 and var_208_2 < var_208_8 then
					arg_205_1.talkMaxDuration = var_208_8

					if var_208_8 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_5
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192050", "story_v_out_322192.awb") ~= 0 then
					local var_208_9 = manager.audio:GetVoiceLength("story_v_out_322192", "322192050", "story_v_out_322192.awb") / 1000

					if var_208_9 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_1
					end

					if var_208_4.prefab_name ~= "" and arg_205_1.actors_[var_208_4.prefab_name] ~= nil then
						local var_208_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_4.prefab_name].transform, "story_v_out_322192", "322192050", "story_v_out_322192.awb")

						arg_205_1:RecordAudio("322192050", var_208_10)
						arg_205_1:RecordAudio("322192050", var_208_10)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_322192", "322192050", "story_v_out_322192.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_322192", "322192050", "story_v_out_322192.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_11 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_11 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_11

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_11 and arg_205_1.time_ < var_208_1 + var_208_11 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play322192051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 322192051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play322192052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1043ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1043ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0, 100, 0)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1043ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, 100, 0)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = 0
			local var_212_10 = 0.775

			if var_212_9 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_11 = arg_209_1:GetWordFromCfg(322192051)
				local var_212_12 = arg_209_1:FormatText(var_212_11.content)

				arg_209_1.text_.text = var_212_12

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 31
				local var_212_14 = utf8.len(var_212_12)
				local var_212_15 = var_212_13 <= 0 and var_212_10 or var_212_10 * (var_212_14 / var_212_13)

				if var_212_15 > 0 and var_212_10 < var_212_15 then
					arg_209_1.talkMaxDuration = var_212_15

					if var_212_15 + var_212_9 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_15 + var_212_9
					end
				end

				arg_209_1.text_.text = var_212_12
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_10, arg_209_1.talkMaxDuration)

			if var_212_9 <= arg_209_1.time_ and arg_209_1.time_ < var_212_9 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_9) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_9 + var_212_16 and arg_209_1.time_ < var_212_9 + var_212_16 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play322192052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 322192052
		arg_213_1.duration_ = 3.3

		local var_213_0 = {
			zh = 1.733,
			ja = 3.3
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play322192053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1043ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos1043ui_story = var_216_0.localPosition
			end

			local var_216_2 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2
				local var_216_4 = Vector3.New(0.01, -1.01, -5.73)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1043ui_story, var_216_4, var_216_3)

				local var_216_5 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_5.x, var_216_5.y, var_216_5.z)

				local var_216_6 = var_216_0.localEulerAngles

				var_216_6.z = 0
				var_216_6.x = 0
				var_216_0.localEulerAngles = var_216_6
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_216_7 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_7.x, var_216_7.y, var_216_7.z)

				local var_216_8 = var_216_0.localEulerAngles

				var_216_8.z = 0
				var_216_8.x = 0
				var_216_0.localEulerAngles = var_216_8
			end

			local var_216_9 = arg_213_1.actors_["1043ui_story"]
			local var_216_10 = 0

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1043ui_story == nil then
				arg_213_1.var_.characterEffect1043ui_story = var_216_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_11 = 0.200000002980232

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_11 and not isNil(var_216_9) then
				local var_216_12 = (arg_213_1.time_ - var_216_10) / var_216_11

				if arg_213_1.var_.characterEffect1043ui_story and not isNil(var_216_9) then
					arg_213_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_10 + var_216_11 and arg_213_1.time_ < var_216_10 + var_216_11 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1043ui_story then
				arg_213_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_216_13 = 0

			if var_216_13 < arg_213_1.time_ and arg_213_1.time_ <= var_216_13 + arg_216_0 then
				arg_213_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_216_14 = 0

			if var_216_14 < arg_213_1.time_ and arg_213_1.time_ <= var_216_14 + arg_216_0 then
				arg_213_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_216_15 = 0
			local var_216_16 = 0.2

			if var_216_15 < arg_213_1.time_ and arg_213_1.time_ <= var_216_15 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_17 = arg_213_1:FormatText(StoryNameCfg[1156].name)

				arg_213_1.leftNameTxt_.text = var_216_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_18 = arg_213_1:GetWordFromCfg(322192052)
				local var_216_19 = arg_213_1:FormatText(var_216_18.content)

				arg_213_1.text_.text = var_216_19

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_20 = 8
				local var_216_21 = utf8.len(var_216_19)
				local var_216_22 = var_216_20 <= 0 and var_216_16 or var_216_16 * (var_216_21 / var_216_20)

				if var_216_22 > 0 and var_216_16 < var_216_22 then
					arg_213_1.talkMaxDuration = var_216_22

					if var_216_22 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_22 + var_216_15
					end
				end

				arg_213_1.text_.text = var_216_19
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192052", "story_v_out_322192.awb") ~= 0 then
					local var_216_23 = manager.audio:GetVoiceLength("story_v_out_322192", "322192052", "story_v_out_322192.awb") / 1000

					if var_216_23 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_23 + var_216_15
					end

					if var_216_18.prefab_name ~= "" and arg_213_1.actors_[var_216_18.prefab_name] ~= nil then
						local var_216_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_18.prefab_name].transform, "story_v_out_322192", "322192052", "story_v_out_322192.awb")

						arg_213_1:RecordAudio("322192052", var_216_24)
						arg_213_1:RecordAudio("322192052", var_216_24)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_322192", "322192052", "story_v_out_322192.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_322192", "322192052", "story_v_out_322192.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_25 = math.max(var_216_16, arg_213_1.talkMaxDuration)

			if var_216_15 <= arg_213_1.time_ and arg_213_1.time_ < var_216_15 + var_216_25 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_15) / var_216_25

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_15 + var_216_25 and arg_213_1.time_ < var_216_15 + var_216_25 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play322192053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 322192053
		arg_217_1.duration_ = 6.17

		local var_217_0 = {
			zh = 4.2,
			ja = 6.166
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play322192054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1043ui_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos1043ui_story = var_220_0.localPosition
			end

			local var_220_2 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2
				local var_220_4 = Vector3.New(-0.92, -1.01, -5.73)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1043ui_story, var_220_4, var_220_3)

				local var_220_5 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_5.x, var_220_5.y, var_220_5.z)

				local var_220_6 = var_220_0.localEulerAngles

				var_220_6.z = 0
				var_220_6.x = 0
				var_220_0.localEulerAngles = var_220_6
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(-0.92, -1.01, -5.73)

				local var_220_7 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_7.x, var_220_7.y, var_220_7.z)

				local var_220_8 = var_220_0.localEulerAngles

				var_220_8.z = 0
				var_220_8.x = 0
				var_220_0.localEulerAngles = var_220_8
			end

			local var_220_9 = arg_217_1.actors_["1111ui_story"].transform
			local var_220_10 = 0

			if var_220_10 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 then
				arg_217_1.var_.moveOldPos1111ui_story = var_220_9.localPosition
			end

			local var_220_11 = 0.001

			if var_220_10 <= arg_217_1.time_ and arg_217_1.time_ < var_220_10 + var_220_11 then
				local var_220_12 = (arg_217_1.time_ - var_220_10) / var_220_11
				local var_220_13 = Vector3.New(0.7, -0.87, -5.7)

				var_220_9.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1111ui_story, var_220_13, var_220_12)

				local var_220_14 = manager.ui.mainCamera.transform.position - var_220_9.position

				var_220_9.forward = Vector3.New(var_220_14.x, var_220_14.y, var_220_14.z)

				local var_220_15 = var_220_9.localEulerAngles

				var_220_15.z = 0
				var_220_15.x = 0
				var_220_9.localEulerAngles = var_220_15
			end

			if arg_217_1.time_ >= var_220_10 + var_220_11 and arg_217_1.time_ < var_220_10 + var_220_11 + arg_220_0 then
				var_220_9.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_220_16 = manager.ui.mainCamera.transform.position - var_220_9.position

				var_220_9.forward = Vector3.New(var_220_16.x, var_220_16.y, var_220_16.z)

				local var_220_17 = var_220_9.localEulerAngles

				var_220_17.z = 0
				var_220_17.x = 0
				var_220_9.localEulerAngles = var_220_17
			end

			local var_220_18 = arg_217_1.actors_["1111ui_story"]
			local var_220_19 = 0

			if var_220_19 < arg_217_1.time_ and arg_217_1.time_ <= var_220_19 + arg_220_0 and not isNil(var_220_18) and arg_217_1.var_.characterEffect1111ui_story == nil then
				arg_217_1.var_.characterEffect1111ui_story = var_220_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_20 = 0.200000002980232

			if var_220_19 <= arg_217_1.time_ and arg_217_1.time_ < var_220_19 + var_220_20 and not isNil(var_220_18) then
				local var_220_21 = (arg_217_1.time_ - var_220_19) / var_220_20

				if arg_217_1.var_.characterEffect1111ui_story and not isNil(var_220_18) then
					arg_217_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_19 + var_220_20 and arg_217_1.time_ < var_220_19 + var_220_20 + arg_220_0 and not isNil(var_220_18) and arg_217_1.var_.characterEffect1111ui_story then
				arg_217_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_220_22 = arg_217_1.actors_["1043ui_story"]
			local var_220_23 = 0

			if var_220_23 < arg_217_1.time_ and arg_217_1.time_ <= var_220_23 + arg_220_0 and not isNil(var_220_22) and arg_217_1.var_.characterEffect1043ui_story == nil then
				arg_217_1.var_.characterEffect1043ui_story = var_220_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_24 = 0.200000002980232

			if var_220_23 <= arg_217_1.time_ and arg_217_1.time_ < var_220_23 + var_220_24 and not isNil(var_220_22) then
				local var_220_25 = (arg_217_1.time_ - var_220_23) / var_220_24

				if arg_217_1.var_.characterEffect1043ui_story and not isNil(var_220_22) then
					local var_220_26 = Mathf.Lerp(0, 0.5, var_220_25)

					arg_217_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1043ui_story.fillRatio = var_220_26
				end
			end

			if arg_217_1.time_ >= var_220_23 + var_220_24 and arg_217_1.time_ < var_220_23 + var_220_24 + arg_220_0 and not isNil(var_220_22) and arg_217_1.var_.characterEffect1043ui_story then
				local var_220_27 = 0.5

				arg_217_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1043ui_story.fillRatio = var_220_27
			end

			local var_220_28 = 0

			if var_220_28 < arg_217_1.time_ and arg_217_1.time_ <= var_220_28 + arg_220_0 then
				arg_217_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_220_29 = 0

			if var_220_29 < arg_217_1.time_ and arg_217_1.time_ <= var_220_29 + arg_220_0 then
				arg_217_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_220_30 = 0
			local var_220_31 = 0.475

			if var_220_30 < arg_217_1.time_ and arg_217_1.time_ <= var_220_30 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_32 = arg_217_1:FormatText(StoryNameCfg[67].name)

				arg_217_1.leftNameTxt_.text = var_220_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_33 = arg_217_1:GetWordFromCfg(322192053)
				local var_220_34 = arg_217_1:FormatText(var_220_33.content)

				arg_217_1.text_.text = var_220_34

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_35 = 19
				local var_220_36 = utf8.len(var_220_34)
				local var_220_37 = var_220_35 <= 0 and var_220_31 or var_220_31 * (var_220_36 / var_220_35)

				if var_220_37 > 0 and var_220_31 < var_220_37 then
					arg_217_1.talkMaxDuration = var_220_37

					if var_220_37 + var_220_30 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_37 + var_220_30
					end
				end

				arg_217_1.text_.text = var_220_34
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192053", "story_v_out_322192.awb") ~= 0 then
					local var_220_38 = manager.audio:GetVoiceLength("story_v_out_322192", "322192053", "story_v_out_322192.awb") / 1000

					if var_220_38 + var_220_30 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_38 + var_220_30
					end

					if var_220_33.prefab_name ~= "" and arg_217_1.actors_[var_220_33.prefab_name] ~= nil then
						local var_220_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_33.prefab_name].transform, "story_v_out_322192", "322192053", "story_v_out_322192.awb")

						arg_217_1:RecordAudio("322192053", var_220_39)
						arg_217_1:RecordAudio("322192053", var_220_39)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_322192", "322192053", "story_v_out_322192.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_322192", "322192053", "story_v_out_322192.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_40 = math.max(var_220_31, arg_217_1.talkMaxDuration)

			if var_220_30 <= arg_217_1.time_ and arg_217_1.time_ < var_220_30 + var_220_40 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_30) / var_220_40

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_30 + var_220_40 and arg_217_1.time_ < var_220_30 + var_220_40 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play322192054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 322192054
		arg_221_1.duration_ = 6

		local var_221_0 = {
			zh = 5.033,
			ja = 6
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play322192055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.55

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[67].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_3 = arg_221_1:GetWordFromCfg(322192054)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 22
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192054", "story_v_out_322192.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192054", "story_v_out_322192.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_322192", "322192054", "story_v_out_322192.awb")

						arg_221_1:RecordAudio("322192054", var_224_9)
						arg_221_1:RecordAudio("322192054", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_322192", "322192054", "story_v_out_322192.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_322192", "322192054", "story_v_out_322192.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_10 and arg_221_1.time_ < var_224_0 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play322192055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 322192055
		arg_225_1.duration_ = 5.57

		local var_225_0 = {
			zh = 3.066,
			ja = 5.566
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play322192056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_1")
			end

			local var_228_1 = 0
			local var_228_2 = 0.425

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_3 = arg_225_1:FormatText(StoryNameCfg[67].name)

				arg_225_1.leftNameTxt_.text = var_228_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_4 = arg_225_1:GetWordFromCfg(322192055)
				local var_228_5 = arg_225_1:FormatText(var_228_4.content)

				arg_225_1.text_.text = var_228_5

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_6 = 17
				local var_228_7 = utf8.len(var_228_5)
				local var_228_8 = var_228_6 <= 0 and var_228_2 or var_228_2 * (var_228_7 / var_228_6)

				if var_228_8 > 0 and var_228_2 < var_228_8 then
					arg_225_1.talkMaxDuration = var_228_8

					if var_228_8 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_5
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192055", "story_v_out_322192.awb") ~= 0 then
					local var_228_9 = manager.audio:GetVoiceLength("story_v_out_322192", "322192055", "story_v_out_322192.awb") / 1000

					if var_228_9 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_1
					end

					if var_228_4.prefab_name ~= "" and arg_225_1.actors_[var_228_4.prefab_name] ~= nil then
						local var_228_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_4.prefab_name].transform, "story_v_out_322192", "322192055", "story_v_out_322192.awb")

						arg_225_1:RecordAudio("322192055", var_228_10)
						arg_225_1:RecordAudio("322192055", var_228_10)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_322192", "322192055", "story_v_out_322192.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_322192", "322192055", "story_v_out_322192.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_11 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_11 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_11

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_11 and arg_225_1.time_ < var_228_1 + var_228_11 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play322192056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 322192056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play322192057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1043ui_story"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos1043ui_story = var_232_0.localPosition
			end

			local var_232_2 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2
				local var_232_4 = Vector3.New(0, 100, 0)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1043ui_story, var_232_4, var_232_3)

				local var_232_5 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_5.x, var_232_5.y, var_232_5.z)

				local var_232_6 = var_232_0.localEulerAngles

				var_232_6.z = 0
				var_232_6.x = 0
				var_232_0.localEulerAngles = var_232_6
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(0, 100, 0)

				local var_232_7 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_7.x, var_232_7.y, var_232_7.z)

				local var_232_8 = var_232_0.localEulerAngles

				var_232_8.z = 0
				var_232_8.x = 0
				var_232_0.localEulerAngles = var_232_8
			end

			local var_232_9 = arg_229_1.actors_["1111ui_story"].transform
			local var_232_10 = 0

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 then
				arg_229_1.var_.moveOldPos1111ui_story = var_232_9.localPosition
			end

			local var_232_11 = 0.001

			if var_232_10 <= arg_229_1.time_ and arg_229_1.time_ < var_232_10 + var_232_11 then
				local var_232_12 = (arg_229_1.time_ - var_232_10) / var_232_11
				local var_232_13 = Vector3.New(0, 100, 0)

				var_232_9.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1111ui_story, var_232_13, var_232_12)

				local var_232_14 = manager.ui.mainCamera.transform.position - var_232_9.position

				var_232_9.forward = Vector3.New(var_232_14.x, var_232_14.y, var_232_14.z)

				local var_232_15 = var_232_9.localEulerAngles

				var_232_15.z = 0
				var_232_15.x = 0
				var_232_9.localEulerAngles = var_232_15
			end

			if arg_229_1.time_ >= var_232_10 + var_232_11 and arg_229_1.time_ < var_232_10 + var_232_11 + arg_232_0 then
				var_232_9.localPosition = Vector3.New(0, 100, 0)

				local var_232_16 = manager.ui.mainCamera.transform.position - var_232_9.position

				var_232_9.forward = Vector3.New(var_232_16.x, var_232_16.y, var_232_16.z)

				local var_232_17 = var_232_9.localEulerAngles

				var_232_17.z = 0
				var_232_17.x = 0
				var_232_9.localEulerAngles = var_232_17
			end

			local var_232_18 = 0
			local var_232_19 = 1.175

			if var_232_18 < arg_229_1.time_ and arg_229_1.time_ <= var_232_18 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_20 = arg_229_1:GetWordFromCfg(322192056)
				local var_232_21 = arg_229_1:FormatText(var_232_20.content)

				arg_229_1.text_.text = var_232_21

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_22 = 47
				local var_232_23 = utf8.len(var_232_21)
				local var_232_24 = var_232_22 <= 0 and var_232_19 or var_232_19 * (var_232_23 / var_232_22)

				if var_232_24 > 0 and var_232_19 < var_232_24 then
					arg_229_1.talkMaxDuration = var_232_24

					if var_232_24 + var_232_18 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_24 + var_232_18
					end
				end

				arg_229_1.text_.text = var_232_21
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_25 = math.max(var_232_19, arg_229_1.talkMaxDuration)

			if var_232_18 <= arg_229_1.time_ and arg_229_1.time_ < var_232_18 + var_232_25 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_18) / var_232_25

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_18 + var_232_25 and arg_229_1.time_ < var_232_18 + var_232_25 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play322192057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 322192057
		arg_233_1.duration_ = 7.7

		local var_233_0 = {
			zh = 4.066,
			ja = 7.7
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play322192058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1211ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1211ui_story = var_236_0.localPosition

				local var_236_2 = "1211ui_story"

				arg_233_1:ShowWeapon(arg_233_1.var_[var_236_2 .. "Animator"].transform, false)
			end

			local var_236_3 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_3 then
				local var_236_4 = (arg_233_1.time_ - var_236_1) / var_236_3
				local var_236_5 = Vector3.New(0, -0.67, -6.07)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1211ui_story, var_236_5, var_236_4)

				local var_236_6 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_6.x, var_236_6.y, var_236_6.z)

				local var_236_7 = var_236_0.localEulerAngles

				var_236_7.z = 0
				var_236_7.x = 0
				var_236_0.localEulerAngles = var_236_7
			end

			if arg_233_1.time_ >= var_236_1 + var_236_3 and arg_233_1.time_ < var_236_1 + var_236_3 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_236_8 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_8.x, var_236_8.y, var_236_8.z)

				local var_236_9 = var_236_0.localEulerAngles

				var_236_9.z = 0
				var_236_9.x = 0
				var_236_0.localEulerAngles = var_236_9
			end

			local var_236_10 = arg_233_1.actors_["1211ui_story"]
			local var_236_11 = 0

			if var_236_11 < arg_233_1.time_ and arg_233_1.time_ <= var_236_11 + arg_236_0 and not isNil(var_236_10) and arg_233_1.var_.characterEffect1211ui_story == nil then
				arg_233_1.var_.characterEffect1211ui_story = var_236_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_12 = 0.200000002980232

			if var_236_11 <= arg_233_1.time_ and arg_233_1.time_ < var_236_11 + var_236_12 and not isNil(var_236_10) then
				local var_236_13 = (arg_233_1.time_ - var_236_11) / var_236_12

				if arg_233_1.var_.characterEffect1211ui_story and not isNil(var_236_10) then
					arg_233_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_11 + var_236_12 and arg_233_1.time_ < var_236_11 + var_236_12 + arg_236_0 and not isNil(var_236_10) and arg_233_1.var_.characterEffect1211ui_story then
				arg_233_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_236_14 = 0

			if var_236_14 < arg_233_1.time_ and arg_233_1.time_ <= var_236_14 + arg_236_0 then
				arg_233_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_236_15 = 0

			if var_236_15 < arg_233_1.time_ and arg_233_1.time_ <= var_236_15 + arg_236_0 then
				arg_233_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_236_16 = 0
			local var_236_17 = 0.45

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_18 = arg_233_1:FormatText(StoryNameCfg[37].name)

				arg_233_1.leftNameTxt_.text = var_236_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_19 = arg_233_1:GetWordFromCfg(322192057)
				local var_236_20 = arg_233_1:FormatText(var_236_19.content)

				arg_233_1.text_.text = var_236_20

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_21 = 18
				local var_236_22 = utf8.len(var_236_20)
				local var_236_23 = var_236_21 <= 0 and var_236_17 or var_236_17 * (var_236_22 / var_236_21)

				if var_236_23 > 0 and var_236_17 < var_236_23 then
					arg_233_1.talkMaxDuration = var_236_23

					if var_236_23 + var_236_16 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_23 + var_236_16
					end
				end

				arg_233_1.text_.text = var_236_20
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192057", "story_v_out_322192.awb") ~= 0 then
					local var_236_24 = manager.audio:GetVoiceLength("story_v_out_322192", "322192057", "story_v_out_322192.awb") / 1000

					if var_236_24 + var_236_16 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_24 + var_236_16
					end

					if var_236_19.prefab_name ~= "" and arg_233_1.actors_[var_236_19.prefab_name] ~= nil then
						local var_236_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_19.prefab_name].transform, "story_v_out_322192", "322192057", "story_v_out_322192.awb")

						arg_233_1:RecordAudio("322192057", var_236_25)
						arg_233_1:RecordAudio("322192057", var_236_25)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_322192", "322192057", "story_v_out_322192.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_322192", "322192057", "story_v_out_322192.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_26 = math.max(var_236_17, arg_233_1.talkMaxDuration)

			if var_236_16 <= arg_233_1.time_ and arg_233_1.time_ < var_236_16 + var_236_26 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_16) / var_236_26

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_16 + var_236_26 and arg_233_1.time_ < var_236_16 + var_236_26 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play322192058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 322192058
		arg_237_1.duration_ = 5.47

		local var_237_0 = {
			zh = 2.033,
			ja = 5.466
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play322192059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1111ui_story"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1111ui_story = var_240_0.localPosition
			end

			local var_240_2 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2
				local var_240_4 = Vector3.New(0, -0.87, -5.7)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1111ui_story, var_240_4, var_240_3)

				local var_240_5 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_5.x, var_240_5.y, var_240_5.z)

				local var_240_6 = var_240_0.localEulerAngles

				var_240_6.z = 0
				var_240_6.x = 0
				var_240_0.localEulerAngles = var_240_6
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_240_7 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_7.x, var_240_7.y, var_240_7.z)

				local var_240_8 = var_240_0.localEulerAngles

				var_240_8.z = 0
				var_240_8.x = 0
				var_240_0.localEulerAngles = var_240_8
			end

			local var_240_9 = arg_237_1.actors_["1211ui_story"].transform
			local var_240_10 = 0

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 then
				arg_237_1.var_.moveOldPos1211ui_story = var_240_9.localPosition
			end

			local var_240_11 = 0.001

			if var_240_10 <= arg_237_1.time_ and arg_237_1.time_ < var_240_10 + var_240_11 then
				local var_240_12 = (arg_237_1.time_ - var_240_10) / var_240_11
				local var_240_13 = Vector3.New(0, 100, 0)

				var_240_9.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1211ui_story, var_240_13, var_240_12)

				local var_240_14 = manager.ui.mainCamera.transform.position - var_240_9.position

				var_240_9.forward = Vector3.New(var_240_14.x, var_240_14.y, var_240_14.z)

				local var_240_15 = var_240_9.localEulerAngles

				var_240_15.z = 0
				var_240_15.x = 0
				var_240_9.localEulerAngles = var_240_15
			end

			if arg_237_1.time_ >= var_240_10 + var_240_11 and arg_237_1.time_ < var_240_10 + var_240_11 + arg_240_0 then
				var_240_9.localPosition = Vector3.New(0, 100, 0)

				local var_240_16 = manager.ui.mainCamera.transform.position - var_240_9.position

				var_240_9.forward = Vector3.New(var_240_16.x, var_240_16.y, var_240_16.z)

				local var_240_17 = var_240_9.localEulerAngles

				var_240_17.z = 0
				var_240_17.x = 0
				var_240_9.localEulerAngles = var_240_17
			end

			local var_240_18 = arg_237_1.actors_["1111ui_story"]
			local var_240_19 = 0

			if var_240_19 < arg_237_1.time_ and arg_237_1.time_ <= var_240_19 + arg_240_0 and not isNil(var_240_18) and arg_237_1.var_.characterEffect1111ui_story == nil then
				arg_237_1.var_.characterEffect1111ui_story = var_240_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_20 = 0.200000002980232

			if var_240_19 <= arg_237_1.time_ and arg_237_1.time_ < var_240_19 + var_240_20 and not isNil(var_240_18) then
				local var_240_21 = (arg_237_1.time_ - var_240_19) / var_240_20

				if arg_237_1.var_.characterEffect1111ui_story and not isNil(var_240_18) then
					arg_237_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_19 + var_240_20 and arg_237_1.time_ < var_240_19 + var_240_20 + arg_240_0 and not isNil(var_240_18) and arg_237_1.var_.characterEffect1111ui_story then
				arg_237_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_240_22 = arg_237_1.actors_["1211ui_story"]
			local var_240_23 = 0

			if var_240_23 < arg_237_1.time_ and arg_237_1.time_ <= var_240_23 + arg_240_0 and not isNil(var_240_22) and arg_237_1.var_.characterEffect1211ui_story == nil then
				arg_237_1.var_.characterEffect1211ui_story = var_240_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_24 = 0.200000002980232

			if var_240_23 <= arg_237_1.time_ and arg_237_1.time_ < var_240_23 + var_240_24 and not isNil(var_240_22) then
				local var_240_25 = (arg_237_1.time_ - var_240_23) / var_240_24

				if arg_237_1.var_.characterEffect1211ui_story and not isNil(var_240_22) then
					local var_240_26 = Mathf.Lerp(0, 0.5, var_240_25)

					arg_237_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1211ui_story.fillRatio = var_240_26
				end
			end

			if arg_237_1.time_ >= var_240_23 + var_240_24 and arg_237_1.time_ < var_240_23 + var_240_24 + arg_240_0 and not isNil(var_240_22) and arg_237_1.var_.characterEffect1211ui_story then
				local var_240_27 = 0.5

				arg_237_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1211ui_story.fillRatio = var_240_27
			end

			local var_240_28 = 0

			if var_240_28 < arg_237_1.time_ and arg_237_1.time_ <= var_240_28 + arg_240_0 then
				arg_237_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_240_29 = 0

			if var_240_29 < arg_237_1.time_ and arg_237_1.time_ <= var_240_29 + arg_240_0 then
				arg_237_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_240_30 = 0
			local var_240_31 = 0.275

			if var_240_30 < arg_237_1.time_ and arg_237_1.time_ <= var_240_30 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_32 = arg_237_1:FormatText(StoryNameCfg[67].name)

				arg_237_1.leftNameTxt_.text = var_240_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_33 = arg_237_1:GetWordFromCfg(322192058)
				local var_240_34 = arg_237_1:FormatText(var_240_33.content)

				arg_237_1.text_.text = var_240_34

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_35 = 11
				local var_240_36 = utf8.len(var_240_34)
				local var_240_37 = var_240_35 <= 0 and var_240_31 or var_240_31 * (var_240_36 / var_240_35)

				if var_240_37 > 0 and var_240_31 < var_240_37 then
					arg_237_1.talkMaxDuration = var_240_37

					if var_240_37 + var_240_30 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_37 + var_240_30
					end
				end

				arg_237_1.text_.text = var_240_34
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192058", "story_v_out_322192.awb") ~= 0 then
					local var_240_38 = manager.audio:GetVoiceLength("story_v_out_322192", "322192058", "story_v_out_322192.awb") / 1000

					if var_240_38 + var_240_30 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_38 + var_240_30
					end

					if var_240_33.prefab_name ~= "" and arg_237_1.actors_[var_240_33.prefab_name] ~= nil then
						local var_240_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_33.prefab_name].transform, "story_v_out_322192", "322192058", "story_v_out_322192.awb")

						arg_237_1:RecordAudio("322192058", var_240_39)
						arg_237_1:RecordAudio("322192058", var_240_39)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_322192", "322192058", "story_v_out_322192.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_322192", "322192058", "story_v_out_322192.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_40 = math.max(var_240_31, arg_237_1.talkMaxDuration)

			if var_240_30 <= arg_237_1.time_ and arg_237_1.time_ < var_240_30 + var_240_40 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_30) / var_240_40

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_30 + var_240_40 and arg_237_1.time_ < var_240_30 + var_240_40 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play322192059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 322192059
		arg_241_1.duration_ = 13.07

		local var_241_0 = {
			zh = 8.2,
			ja = 13.066
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play322192060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1111ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1111ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1111ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = arg_241_1.actors_["1211ui_story"].transform
			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				arg_241_1.var_.moveOldPos1211ui_story = var_244_9.localPosition
			end

			local var_244_11 = 0.001

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_11 then
				local var_244_12 = (arg_241_1.time_ - var_244_10) / var_244_11
				local var_244_13 = Vector3.New(0.7, -0.67, -6.07)

				var_244_9.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1211ui_story, var_244_13, var_244_12)

				local var_244_14 = manager.ui.mainCamera.transform.position - var_244_9.position

				var_244_9.forward = Vector3.New(var_244_14.x, var_244_14.y, var_244_14.z)

				local var_244_15 = var_244_9.localEulerAngles

				var_244_15.z = 0
				var_244_15.x = 0
				var_244_9.localEulerAngles = var_244_15
			end

			if arg_241_1.time_ >= var_244_10 + var_244_11 and arg_241_1.time_ < var_244_10 + var_244_11 + arg_244_0 then
				var_244_9.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_244_16 = manager.ui.mainCamera.transform.position - var_244_9.position

				var_244_9.forward = Vector3.New(var_244_16.x, var_244_16.y, var_244_16.z)

				local var_244_17 = var_244_9.localEulerAngles

				var_244_17.z = 0
				var_244_17.x = 0
				var_244_9.localEulerAngles = var_244_17
			end

			local var_244_18 = arg_241_1.actors_["1211ui_story"]
			local var_244_19 = 0

			if var_244_19 < arg_241_1.time_ and arg_241_1.time_ <= var_244_19 + arg_244_0 and not isNil(var_244_18) and arg_241_1.var_.characterEffect1211ui_story == nil then
				arg_241_1.var_.characterEffect1211ui_story = var_244_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_20 = 0.200000002980232

			if var_244_19 <= arg_241_1.time_ and arg_241_1.time_ < var_244_19 + var_244_20 and not isNil(var_244_18) then
				local var_244_21 = (arg_241_1.time_ - var_244_19) / var_244_20

				if arg_241_1.var_.characterEffect1211ui_story and not isNil(var_244_18) then
					arg_241_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_19 + var_244_20 and arg_241_1.time_ < var_244_19 + var_244_20 + arg_244_0 and not isNil(var_244_18) and arg_241_1.var_.characterEffect1211ui_story then
				arg_241_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_244_22 = arg_241_1.actors_["1111ui_story"]
			local var_244_23 = 0

			if var_244_23 < arg_241_1.time_ and arg_241_1.time_ <= var_244_23 + arg_244_0 and not isNil(var_244_22) and arg_241_1.var_.characterEffect1111ui_story == nil then
				arg_241_1.var_.characterEffect1111ui_story = var_244_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_24 = 0.200000002980232

			if var_244_23 <= arg_241_1.time_ and arg_241_1.time_ < var_244_23 + var_244_24 and not isNil(var_244_22) then
				local var_244_25 = (arg_241_1.time_ - var_244_23) / var_244_24

				if arg_241_1.var_.characterEffect1111ui_story and not isNil(var_244_22) then
					local var_244_26 = Mathf.Lerp(0, 0.5, var_244_25)

					arg_241_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1111ui_story.fillRatio = var_244_26
				end
			end

			if arg_241_1.time_ >= var_244_23 + var_244_24 and arg_241_1.time_ < var_244_23 + var_244_24 + arg_244_0 and not isNil(var_244_22) and arg_241_1.var_.characterEffect1111ui_story then
				local var_244_27 = 0.5

				arg_241_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1111ui_story.fillRatio = var_244_27
			end

			local var_244_28 = 0

			if var_244_28 < arg_241_1.time_ and arg_241_1.time_ <= var_244_28 + arg_244_0 then
				arg_241_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211actionlink/1211action435")
			end

			local var_244_29 = 0

			if var_244_29 < arg_241_1.time_ and arg_241_1.time_ <= var_244_29 + arg_244_0 then
				arg_241_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_244_30 = 0
			local var_244_31 = 1.05

			if var_244_30 < arg_241_1.time_ and arg_241_1.time_ <= var_244_30 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_32 = arg_241_1:FormatText(StoryNameCfg[37].name)

				arg_241_1.leftNameTxt_.text = var_244_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_33 = arg_241_1:GetWordFromCfg(322192059)
				local var_244_34 = arg_241_1:FormatText(var_244_33.content)

				arg_241_1.text_.text = var_244_34

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_35 = 42
				local var_244_36 = utf8.len(var_244_34)
				local var_244_37 = var_244_35 <= 0 and var_244_31 or var_244_31 * (var_244_36 / var_244_35)

				if var_244_37 > 0 and var_244_31 < var_244_37 then
					arg_241_1.talkMaxDuration = var_244_37

					if var_244_37 + var_244_30 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_37 + var_244_30
					end
				end

				arg_241_1.text_.text = var_244_34
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192059", "story_v_out_322192.awb") ~= 0 then
					local var_244_38 = manager.audio:GetVoiceLength("story_v_out_322192", "322192059", "story_v_out_322192.awb") / 1000

					if var_244_38 + var_244_30 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_38 + var_244_30
					end

					if var_244_33.prefab_name ~= "" and arg_241_1.actors_[var_244_33.prefab_name] ~= nil then
						local var_244_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_33.prefab_name].transform, "story_v_out_322192", "322192059", "story_v_out_322192.awb")

						arg_241_1:RecordAudio("322192059", var_244_39)
						arg_241_1:RecordAudio("322192059", var_244_39)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_322192", "322192059", "story_v_out_322192.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_322192", "322192059", "story_v_out_322192.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_40 = math.max(var_244_31, arg_241_1.talkMaxDuration)

			if var_244_30 <= arg_241_1.time_ and arg_241_1.time_ < var_244_30 + var_244_40 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_30) / var_244_40

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_30 + var_244_40 and arg_241_1.time_ < var_244_30 + var_244_40 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play322192060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 322192060
		arg_245_1.duration_ = 2.57

		local var_245_0 = {
			zh = 2.2,
			ja = 2.566
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play322192061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1111ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1111ui_story == nil then
				arg_245_1.var_.characterEffect1111ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect1111ui_story and not isNil(var_248_0) then
					arg_245_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1111ui_story then
				arg_245_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_248_4 = arg_245_1.actors_["1211ui_story"]
			local var_248_5 = 0

			if var_248_5 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 and not isNil(var_248_4) and arg_245_1.var_.characterEffect1211ui_story == nil then
				arg_245_1.var_.characterEffect1211ui_story = var_248_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_6 = 0.200000002980232

			if var_248_5 <= arg_245_1.time_ and arg_245_1.time_ < var_248_5 + var_248_6 and not isNil(var_248_4) then
				local var_248_7 = (arg_245_1.time_ - var_248_5) / var_248_6

				if arg_245_1.var_.characterEffect1211ui_story and not isNil(var_248_4) then
					local var_248_8 = Mathf.Lerp(0, 0.5, var_248_7)

					arg_245_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1211ui_story.fillRatio = var_248_8
				end
			end

			if arg_245_1.time_ >= var_248_5 + var_248_6 and arg_245_1.time_ < var_248_5 + var_248_6 + arg_248_0 and not isNil(var_248_4) and arg_245_1.var_.characterEffect1211ui_story then
				local var_248_9 = 0.5

				arg_245_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1211ui_story.fillRatio = var_248_9
			end

			local var_248_10 = 0

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 then
				arg_245_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_248_11 = 0
			local var_248_12 = 0.225

			if var_248_11 < arg_245_1.time_ and arg_245_1.time_ <= var_248_11 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_13 = arg_245_1:FormatText(StoryNameCfg[67].name)

				arg_245_1.leftNameTxt_.text = var_248_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_14 = arg_245_1:GetWordFromCfg(322192060)
				local var_248_15 = arg_245_1:FormatText(var_248_14.content)

				arg_245_1.text_.text = var_248_15

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_16 = 9
				local var_248_17 = utf8.len(var_248_15)
				local var_248_18 = var_248_16 <= 0 and var_248_12 or var_248_12 * (var_248_17 / var_248_16)

				if var_248_18 > 0 and var_248_12 < var_248_18 then
					arg_245_1.talkMaxDuration = var_248_18

					if var_248_18 + var_248_11 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_18 + var_248_11
					end
				end

				arg_245_1.text_.text = var_248_15
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192060", "story_v_out_322192.awb") ~= 0 then
					local var_248_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192060", "story_v_out_322192.awb") / 1000

					if var_248_19 + var_248_11 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_19 + var_248_11
					end

					if var_248_14.prefab_name ~= "" and arg_245_1.actors_[var_248_14.prefab_name] ~= nil then
						local var_248_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_14.prefab_name].transform, "story_v_out_322192", "322192060", "story_v_out_322192.awb")

						arg_245_1:RecordAudio("322192060", var_248_20)
						arg_245_1:RecordAudio("322192060", var_248_20)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_322192", "322192060", "story_v_out_322192.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_322192", "322192060", "story_v_out_322192.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_21 = math.max(var_248_12, arg_245_1.talkMaxDuration)

			if var_248_11 <= arg_245_1.time_ and arg_245_1.time_ < var_248_11 + var_248_21 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_11) / var_248_21

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_11 + var_248_21 and arg_245_1.time_ < var_248_11 + var_248_21 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play322192061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 322192061
		arg_249_1.duration_ = 5.1

		local var_249_0 = {
			zh = 4.4,
			ja = 5.1
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play322192062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1211ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1211ui_story == nil then
				arg_249_1.var_.characterEffect1211ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1211ui_story and not isNil(var_252_0) then
					arg_249_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1211ui_story then
				arg_249_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_252_4 = arg_249_1.actors_["1111ui_story"]
			local var_252_5 = 0

			if var_252_5 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 and not isNil(var_252_4) and arg_249_1.var_.characterEffect1111ui_story == nil then
				arg_249_1.var_.characterEffect1111ui_story = var_252_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_6 = 0.200000002980232

			if var_252_5 <= arg_249_1.time_ and arg_249_1.time_ < var_252_5 + var_252_6 and not isNil(var_252_4) then
				local var_252_7 = (arg_249_1.time_ - var_252_5) / var_252_6

				if arg_249_1.var_.characterEffect1111ui_story and not isNil(var_252_4) then
					local var_252_8 = Mathf.Lerp(0, 0.5, var_252_7)

					arg_249_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1111ui_story.fillRatio = var_252_8
				end
			end

			if arg_249_1.time_ >= var_252_5 + var_252_6 and arg_249_1.time_ < var_252_5 + var_252_6 + arg_252_0 and not isNil(var_252_4) and arg_249_1.var_.characterEffect1111ui_story then
				local var_252_9 = 0.5

				arg_249_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1111ui_story.fillRatio = var_252_9
			end

			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 then
				arg_249_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_2")
			end

			local var_252_11 = 0

			if var_252_11 < arg_249_1.time_ and arg_249_1.time_ <= var_252_11 + arg_252_0 then
				arg_249_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_252_12 = 0
			local var_252_13 = 0.325

			if var_252_12 < arg_249_1.time_ and arg_249_1.time_ <= var_252_12 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_14 = arg_249_1:FormatText(StoryNameCfg[37].name)

				arg_249_1.leftNameTxt_.text = var_252_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_15 = arg_249_1:GetWordFromCfg(322192061)
				local var_252_16 = arg_249_1:FormatText(var_252_15.content)

				arg_249_1.text_.text = var_252_16

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_17 = 13
				local var_252_18 = utf8.len(var_252_16)
				local var_252_19 = var_252_17 <= 0 and var_252_13 or var_252_13 * (var_252_18 / var_252_17)

				if var_252_19 > 0 and var_252_13 < var_252_19 then
					arg_249_1.talkMaxDuration = var_252_19

					if var_252_19 + var_252_12 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_19 + var_252_12
					end
				end

				arg_249_1.text_.text = var_252_16
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192061", "story_v_out_322192.awb") ~= 0 then
					local var_252_20 = manager.audio:GetVoiceLength("story_v_out_322192", "322192061", "story_v_out_322192.awb") / 1000

					if var_252_20 + var_252_12 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_20 + var_252_12
					end

					if var_252_15.prefab_name ~= "" and arg_249_1.actors_[var_252_15.prefab_name] ~= nil then
						local var_252_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_15.prefab_name].transform, "story_v_out_322192", "322192061", "story_v_out_322192.awb")

						arg_249_1:RecordAudio("322192061", var_252_21)
						arg_249_1:RecordAudio("322192061", var_252_21)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_322192", "322192061", "story_v_out_322192.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_322192", "322192061", "story_v_out_322192.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_22 = math.max(var_252_13, arg_249_1.talkMaxDuration)

			if var_252_12 <= arg_249_1.time_ and arg_249_1.time_ < var_252_12 + var_252_22 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_12) / var_252_22

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_12 + var_252_22 and arg_249_1.time_ < var_252_12 + var_252_22 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play322192062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 322192062
		arg_253_1.duration_ = 4.43

		local var_253_0 = {
			zh = 3.566,
			ja = 4.433
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play322192063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1111ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1111ui_story == nil then
				arg_253_1.var_.characterEffect1111ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect1111ui_story and not isNil(var_256_0) then
					arg_253_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1111ui_story then
				arg_253_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_256_4 = arg_253_1.actors_["1211ui_story"]
			local var_256_5 = 0

			if var_256_5 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect1211ui_story == nil then
				arg_253_1.var_.characterEffect1211ui_story = var_256_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_6 = 0.200000002980232

			if var_256_5 <= arg_253_1.time_ and arg_253_1.time_ < var_256_5 + var_256_6 and not isNil(var_256_4) then
				local var_256_7 = (arg_253_1.time_ - var_256_5) / var_256_6

				if arg_253_1.var_.characterEffect1211ui_story and not isNil(var_256_4) then
					local var_256_8 = Mathf.Lerp(0, 0.5, var_256_7)

					arg_253_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1211ui_story.fillRatio = var_256_8
				end
			end

			if arg_253_1.time_ >= var_256_5 + var_256_6 and arg_253_1.time_ < var_256_5 + var_256_6 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect1211ui_story then
				local var_256_9 = 0.5

				arg_253_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1211ui_story.fillRatio = var_256_9
			end

			local var_256_10 = 0

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 then
				arg_253_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_256_11 = 0
			local var_256_12 = 0.25

			if var_256_11 < arg_253_1.time_ and arg_253_1.time_ <= var_256_11 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_13 = arg_253_1:FormatText(StoryNameCfg[67].name)

				arg_253_1.leftNameTxt_.text = var_256_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_14 = arg_253_1:GetWordFromCfg(322192062)
				local var_256_15 = arg_253_1:FormatText(var_256_14.content)

				arg_253_1.text_.text = var_256_15

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_16 = 10
				local var_256_17 = utf8.len(var_256_15)
				local var_256_18 = var_256_16 <= 0 and var_256_12 or var_256_12 * (var_256_17 / var_256_16)

				if var_256_18 > 0 and var_256_12 < var_256_18 then
					arg_253_1.talkMaxDuration = var_256_18

					if var_256_18 + var_256_11 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_18 + var_256_11
					end
				end

				arg_253_1.text_.text = var_256_15
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192062", "story_v_out_322192.awb") ~= 0 then
					local var_256_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192062", "story_v_out_322192.awb") / 1000

					if var_256_19 + var_256_11 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_19 + var_256_11
					end

					if var_256_14.prefab_name ~= "" and arg_253_1.actors_[var_256_14.prefab_name] ~= nil then
						local var_256_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_14.prefab_name].transform, "story_v_out_322192", "322192062", "story_v_out_322192.awb")

						arg_253_1:RecordAudio("322192062", var_256_20)
						arg_253_1:RecordAudio("322192062", var_256_20)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_322192", "322192062", "story_v_out_322192.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_322192", "322192062", "story_v_out_322192.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_21 = math.max(var_256_12, arg_253_1.talkMaxDuration)

			if var_256_11 <= arg_253_1.time_ and arg_253_1.time_ < var_256_11 + var_256_21 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_11) / var_256_21

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_11 + var_256_21 and arg_253_1.time_ < var_256_11 + var_256_21 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play322192063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 322192063
		arg_257_1.duration_ = 9.73

		local var_257_0 = {
			zh = 7.933,
			ja = 9.733
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play322192064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.85

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[67].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:GetWordFromCfg(322192063)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 34
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192063", "story_v_out_322192.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192063", "story_v_out_322192.awb") / 1000

					if var_260_8 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_0
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_322192", "322192063", "story_v_out_322192.awb")

						arg_257_1:RecordAudio("322192063", var_260_9)
						arg_257_1:RecordAudio("322192063", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_322192", "322192063", "story_v_out_322192.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_322192", "322192063", "story_v_out_322192.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_10 and arg_257_1.time_ < var_260_0 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play322192064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 322192064
		arg_261_1.duration_ = 7.3

		local var_261_0 = {
			zh = 5.3,
			ja = 7.3
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play322192065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1211ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1211ui_story == nil then
				arg_261_1.var_.characterEffect1211ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1211ui_story and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1211ui_story then
				arg_261_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_264_4 = arg_261_1.actors_["1111ui_story"]
			local var_264_5 = 0

			if var_264_5 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect1111ui_story == nil then
				arg_261_1.var_.characterEffect1111ui_story = var_264_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_6 = 0.200000002980232

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_6 and not isNil(var_264_4) then
				local var_264_7 = (arg_261_1.time_ - var_264_5) / var_264_6

				if arg_261_1.var_.characterEffect1111ui_story and not isNil(var_264_4) then
					local var_264_8 = Mathf.Lerp(0, 0.5, var_264_7)

					arg_261_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1111ui_story.fillRatio = var_264_8
				end
			end

			if arg_261_1.time_ >= var_264_5 + var_264_6 and arg_261_1.time_ < var_264_5 + var_264_6 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect1111ui_story then
				local var_264_9 = 0.5

				arg_261_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1111ui_story.fillRatio = var_264_9
			end

			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_1")
			end

			local var_264_11 = 0

			if var_264_11 < arg_261_1.time_ and arg_261_1.time_ <= var_264_11 + arg_264_0 then
				arg_261_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_264_12 = 0
			local var_264_13 = 0.5

			if var_264_12 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_14 = arg_261_1:FormatText(StoryNameCfg[37].name)

				arg_261_1.leftNameTxt_.text = var_264_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_15 = arg_261_1:GetWordFromCfg(322192064)
				local var_264_16 = arg_261_1:FormatText(var_264_15.content)

				arg_261_1.text_.text = var_264_16

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_17 = 20
				local var_264_18 = utf8.len(var_264_16)
				local var_264_19 = var_264_17 <= 0 and var_264_13 or var_264_13 * (var_264_18 / var_264_17)

				if var_264_19 > 0 and var_264_13 < var_264_19 then
					arg_261_1.talkMaxDuration = var_264_19

					if var_264_19 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_19 + var_264_12
					end
				end

				arg_261_1.text_.text = var_264_16
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192064", "story_v_out_322192.awb") ~= 0 then
					local var_264_20 = manager.audio:GetVoiceLength("story_v_out_322192", "322192064", "story_v_out_322192.awb") / 1000

					if var_264_20 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_20 + var_264_12
					end

					if var_264_15.prefab_name ~= "" and arg_261_1.actors_[var_264_15.prefab_name] ~= nil then
						local var_264_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_15.prefab_name].transform, "story_v_out_322192", "322192064", "story_v_out_322192.awb")

						arg_261_1:RecordAudio("322192064", var_264_21)
						arg_261_1:RecordAudio("322192064", var_264_21)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_322192", "322192064", "story_v_out_322192.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_322192", "322192064", "story_v_out_322192.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_22 = math.max(var_264_13, arg_261_1.talkMaxDuration)

			if var_264_12 <= arg_261_1.time_ and arg_261_1.time_ < var_264_12 + var_264_22 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_12) / var_264_22

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_12 + var_264_22 and arg_261_1.time_ < var_264_12 + var_264_22 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play322192065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 322192065
		arg_265_1.duration_ = 6.23

		local var_265_0 = {
			zh = 6.233,
			ja = 5.8
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play322192066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1111ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1111ui_story == nil then
				arg_265_1.var_.characterEffect1111ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1111ui_story and not isNil(var_268_0) then
					arg_265_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1111ui_story then
				arg_265_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_268_4 = arg_265_1.actors_["1211ui_story"]
			local var_268_5 = 0

			if var_268_5 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 and not isNil(var_268_4) and arg_265_1.var_.characterEffect1211ui_story == nil then
				arg_265_1.var_.characterEffect1211ui_story = var_268_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_6 = 0.200000002980232

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_6 and not isNil(var_268_4) then
				local var_268_7 = (arg_265_1.time_ - var_268_5) / var_268_6

				if arg_265_1.var_.characterEffect1211ui_story and not isNil(var_268_4) then
					local var_268_8 = Mathf.Lerp(0, 0.5, var_268_7)

					arg_265_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1211ui_story.fillRatio = var_268_8
				end
			end

			if arg_265_1.time_ >= var_268_5 + var_268_6 and arg_265_1.time_ < var_268_5 + var_268_6 + arg_268_0 and not isNil(var_268_4) and arg_265_1.var_.characterEffect1211ui_story then
				local var_268_9 = 0.5

				arg_265_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1211ui_story.fillRatio = var_268_9
			end

			local var_268_10 = 0

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 then
				arg_265_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_268_11 = 0

			if var_268_11 < arg_265_1.time_ and arg_265_1.time_ <= var_268_11 + arg_268_0 then
				arg_265_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_268_12 = 0
			local var_268_13 = 0.5

			if var_268_12 < arg_265_1.time_ and arg_265_1.time_ <= var_268_12 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_14 = arg_265_1:FormatText(StoryNameCfg[67].name)

				arg_265_1.leftNameTxt_.text = var_268_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_15 = arg_265_1:GetWordFromCfg(322192065)
				local var_268_16 = arg_265_1:FormatText(var_268_15.content)

				arg_265_1.text_.text = var_268_16

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_17 = 20
				local var_268_18 = utf8.len(var_268_16)
				local var_268_19 = var_268_17 <= 0 and var_268_13 or var_268_13 * (var_268_18 / var_268_17)

				if var_268_19 > 0 and var_268_13 < var_268_19 then
					arg_265_1.talkMaxDuration = var_268_19

					if var_268_19 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_19 + var_268_12
					end
				end

				arg_265_1.text_.text = var_268_16
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192065", "story_v_out_322192.awb") ~= 0 then
					local var_268_20 = manager.audio:GetVoiceLength("story_v_out_322192", "322192065", "story_v_out_322192.awb") / 1000

					if var_268_20 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_20 + var_268_12
					end

					if var_268_15.prefab_name ~= "" and arg_265_1.actors_[var_268_15.prefab_name] ~= nil then
						local var_268_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_15.prefab_name].transform, "story_v_out_322192", "322192065", "story_v_out_322192.awb")

						arg_265_1:RecordAudio("322192065", var_268_21)
						arg_265_1:RecordAudio("322192065", var_268_21)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_322192", "322192065", "story_v_out_322192.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_322192", "322192065", "story_v_out_322192.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_22 = math.max(var_268_13, arg_265_1.talkMaxDuration)

			if var_268_12 <= arg_265_1.time_ and arg_265_1.time_ < var_268_12 + var_268_22 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_12) / var_268_22

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_12 + var_268_22 and arg_265_1.time_ < var_268_12 + var_268_22 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play322192066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322192066
		arg_269_1.duration_ = 9.93

		local var_269_0 = {
			zh = 8.2,
			ja = 9.933
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play322192067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 1.025

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[67].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_3 = arg_269_1:GetWordFromCfg(322192066)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 41
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192066", "story_v_out_322192.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192066", "story_v_out_322192.awb") / 1000

					if var_272_8 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_0
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_out_322192", "322192066", "story_v_out_322192.awb")

						arg_269_1:RecordAudio("322192066", var_272_9)
						arg_269_1:RecordAudio("322192066", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_322192", "322192066", "story_v_out_322192.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_322192", "322192066", "story_v_out_322192.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_10 and arg_269_1.time_ < var_272_0 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play322192067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322192067
		arg_273_1.duration_ = 12.7

		local var_273_0 = {
			zh = 10.2,
			ja = 12.7
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play322192068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.975

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[67].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:GetWordFromCfg(322192067)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 39
				local var_276_6 = utf8.len(var_276_4)
				local var_276_7 = var_276_5 <= 0 and var_276_1 or var_276_1 * (var_276_6 / var_276_5)

				if var_276_7 > 0 and var_276_1 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192067", "story_v_out_322192.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192067", "story_v_out_322192.awb") / 1000

					if var_276_8 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_0
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_322192", "322192067", "story_v_out_322192.awb")

						arg_273_1:RecordAudio("322192067", var_276_9)
						arg_273_1:RecordAudio("322192067", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322192", "322192067", "story_v_out_322192.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322192", "322192067", "story_v_out_322192.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_10 and arg_273_1.time_ < var_276_0 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play322192068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322192068
		arg_277_1.duration_ = 10.77

		local var_277_0 = {
			zh = 10.766,
			ja = 8.366
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play322192069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_280_1 = 0
			local var_280_2 = 1

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_3 = arg_277_1:FormatText(StoryNameCfg[67].name)

				arg_277_1.leftNameTxt_.text = var_280_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_4 = arg_277_1:GetWordFromCfg(322192068)
				local var_280_5 = arg_277_1:FormatText(var_280_4.content)

				arg_277_1.text_.text = var_280_5

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_6 = 40
				local var_280_7 = utf8.len(var_280_5)
				local var_280_8 = var_280_6 <= 0 and var_280_2 or var_280_2 * (var_280_7 / var_280_6)

				if var_280_8 > 0 and var_280_2 < var_280_8 then
					arg_277_1.talkMaxDuration = var_280_8

					if var_280_8 + var_280_1 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_1
					end
				end

				arg_277_1.text_.text = var_280_5
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192068", "story_v_out_322192.awb") ~= 0 then
					local var_280_9 = manager.audio:GetVoiceLength("story_v_out_322192", "322192068", "story_v_out_322192.awb") / 1000

					if var_280_9 + var_280_1 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_1
					end

					if var_280_4.prefab_name ~= "" and arg_277_1.actors_[var_280_4.prefab_name] ~= nil then
						local var_280_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_4.prefab_name].transform, "story_v_out_322192", "322192068", "story_v_out_322192.awb")

						arg_277_1:RecordAudio("322192068", var_280_10)
						arg_277_1:RecordAudio("322192068", var_280_10)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322192", "322192068", "story_v_out_322192.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322192", "322192068", "story_v_out_322192.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_11 = math.max(var_280_2, arg_277_1.talkMaxDuration)

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_11 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_1) / var_280_11

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_1 + var_280_11 and arg_277_1.time_ < var_280_1 + var_280_11 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play322192069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322192069
		arg_281_1.duration_ = 6.6

		local var_281_0 = {
			zh = 5.9,
			ja = 6.6
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play322192070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1211ui_story"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1211ui_story == nil then
				arg_281_1.var_.characterEffect1211ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.characterEffect1211ui_story and not isNil(var_284_0) then
					arg_281_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1211ui_story then
				arg_281_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_284_4 = arg_281_1.actors_["1111ui_story"]
			local var_284_5 = 0

			if var_284_5 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 and not isNil(var_284_4) and arg_281_1.var_.characterEffect1111ui_story == nil then
				arg_281_1.var_.characterEffect1111ui_story = var_284_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_6 = 0.200000002980232

			if var_284_5 <= arg_281_1.time_ and arg_281_1.time_ < var_284_5 + var_284_6 and not isNil(var_284_4) then
				local var_284_7 = (arg_281_1.time_ - var_284_5) / var_284_6

				if arg_281_1.var_.characterEffect1111ui_story and not isNil(var_284_4) then
					local var_284_8 = Mathf.Lerp(0, 0.5, var_284_7)

					arg_281_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1111ui_story.fillRatio = var_284_8
				end
			end

			if arg_281_1.time_ >= var_284_5 + var_284_6 and arg_281_1.time_ < var_284_5 + var_284_6 + arg_284_0 and not isNil(var_284_4) and arg_281_1.var_.characterEffect1111ui_story then
				local var_284_9 = 0.5

				arg_281_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1111ui_story.fillRatio = var_284_9
			end

			local var_284_10 = 0

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 then
				arg_281_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_2")
			end

			local var_284_11 = 0

			if var_284_11 < arg_281_1.time_ and arg_281_1.time_ <= var_284_11 + arg_284_0 then
				arg_281_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_284_12 = 0
			local var_284_13 = 0.5

			if var_284_12 < arg_281_1.time_ and arg_281_1.time_ <= var_284_12 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_14 = arg_281_1:FormatText(StoryNameCfg[37].name)

				arg_281_1.leftNameTxt_.text = var_284_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_15 = arg_281_1:GetWordFromCfg(322192069)
				local var_284_16 = arg_281_1:FormatText(var_284_15.content)

				arg_281_1.text_.text = var_284_16

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_17 = 20
				local var_284_18 = utf8.len(var_284_16)
				local var_284_19 = var_284_17 <= 0 and var_284_13 or var_284_13 * (var_284_18 / var_284_17)

				if var_284_19 > 0 and var_284_13 < var_284_19 then
					arg_281_1.talkMaxDuration = var_284_19

					if var_284_19 + var_284_12 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_19 + var_284_12
					end
				end

				arg_281_1.text_.text = var_284_16
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192069", "story_v_out_322192.awb") ~= 0 then
					local var_284_20 = manager.audio:GetVoiceLength("story_v_out_322192", "322192069", "story_v_out_322192.awb") / 1000

					if var_284_20 + var_284_12 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_20 + var_284_12
					end

					if var_284_15.prefab_name ~= "" and arg_281_1.actors_[var_284_15.prefab_name] ~= nil then
						local var_284_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_15.prefab_name].transform, "story_v_out_322192", "322192069", "story_v_out_322192.awb")

						arg_281_1:RecordAudio("322192069", var_284_21)
						arg_281_1:RecordAudio("322192069", var_284_21)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_322192", "322192069", "story_v_out_322192.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_322192", "322192069", "story_v_out_322192.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_22 = math.max(var_284_13, arg_281_1.talkMaxDuration)

			if var_284_12 <= arg_281_1.time_ and arg_281_1.time_ < var_284_12 + var_284_22 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_12) / var_284_22

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_12 + var_284_22 and arg_281_1.time_ < var_284_12 + var_284_22 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play322192070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322192070
		arg_285_1.duration_ = 10.3

		local var_285_0 = {
			zh = 4.7,
			ja = 10.3
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play322192071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.45

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_2 = arg_285_1:FormatText(StoryNameCfg[37].name)

				arg_285_1.leftNameTxt_.text = var_288_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_3 = arg_285_1:GetWordFromCfg(322192070)
				local var_288_4 = arg_285_1:FormatText(var_288_3.content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 18
				local var_288_6 = utf8.len(var_288_4)
				local var_288_7 = var_288_5 <= 0 and var_288_1 or var_288_1 * (var_288_6 / var_288_5)

				if var_288_7 > 0 and var_288_1 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_0
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192070", "story_v_out_322192.awb") ~= 0 then
					local var_288_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192070", "story_v_out_322192.awb") / 1000

					if var_288_8 + var_288_0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_0
					end

					if var_288_3.prefab_name ~= "" and arg_285_1.actors_[var_288_3.prefab_name] ~= nil then
						local var_288_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_3.prefab_name].transform, "story_v_out_322192", "322192070", "story_v_out_322192.awb")

						arg_285_1:RecordAudio("322192070", var_288_9)
						arg_285_1:RecordAudio("322192070", var_288_9)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_322192", "322192070", "story_v_out_322192.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_322192", "322192070", "story_v_out_322192.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_1, arg_285_1.talkMaxDuration)

			if var_288_0 <= arg_285_1.time_ and arg_285_1.time_ < var_288_0 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_0) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_0 + var_288_10 and arg_285_1.time_ < var_288_0 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play322192071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322192071
		arg_289_1.duration_ = 4.8

		local var_289_0 = {
			zh = 4.8,
			ja = 4.566
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play322192072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1111ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1111ui_story == nil then
				arg_289_1.var_.characterEffect1111ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1111ui_story and not isNil(var_292_0) then
					arg_289_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1111ui_story then
				arg_289_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_292_4 = arg_289_1.actors_["1211ui_story"]
			local var_292_5 = 0

			if var_292_5 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 and not isNil(var_292_4) and arg_289_1.var_.characterEffect1211ui_story == nil then
				arg_289_1.var_.characterEffect1211ui_story = var_292_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_6 = 0.200000002980232

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_6 and not isNil(var_292_4) then
				local var_292_7 = (arg_289_1.time_ - var_292_5) / var_292_6

				if arg_289_1.var_.characterEffect1211ui_story and not isNil(var_292_4) then
					local var_292_8 = Mathf.Lerp(0, 0.5, var_292_7)

					arg_289_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1211ui_story.fillRatio = var_292_8
				end
			end

			if arg_289_1.time_ >= var_292_5 + var_292_6 and arg_289_1.time_ < var_292_5 + var_292_6 + arg_292_0 and not isNil(var_292_4) and arg_289_1.var_.characterEffect1211ui_story then
				local var_292_9 = 0.5

				arg_289_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1211ui_story.fillRatio = var_292_9
			end

			local var_292_10 = 0
			local var_292_11 = 0.425

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_12 = arg_289_1:FormatText(StoryNameCfg[67].name)

				arg_289_1.leftNameTxt_.text = var_292_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_13 = arg_289_1:GetWordFromCfg(322192071)
				local var_292_14 = arg_289_1:FormatText(var_292_13.content)

				arg_289_1.text_.text = var_292_14

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_15 = 17
				local var_292_16 = utf8.len(var_292_14)
				local var_292_17 = var_292_15 <= 0 and var_292_11 or var_292_11 * (var_292_16 / var_292_15)

				if var_292_17 > 0 and var_292_11 < var_292_17 then
					arg_289_1.talkMaxDuration = var_292_17

					if var_292_17 + var_292_10 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_17 + var_292_10
					end
				end

				arg_289_1.text_.text = var_292_14
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192071", "story_v_out_322192.awb") ~= 0 then
					local var_292_18 = manager.audio:GetVoiceLength("story_v_out_322192", "322192071", "story_v_out_322192.awb") / 1000

					if var_292_18 + var_292_10 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_18 + var_292_10
					end

					if var_292_13.prefab_name ~= "" and arg_289_1.actors_[var_292_13.prefab_name] ~= nil then
						local var_292_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_13.prefab_name].transform, "story_v_out_322192", "322192071", "story_v_out_322192.awb")

						arg_289_1:RecordAudio("322192071", var_292_19)
						arg_289_1:RecordAudio("322192071", var_292_19)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_322192", "322192071", "story_v_out_322192.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_322192", "322192071", "story_v_out_322192.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_20 = math.max(var_292_11, arg_289_1.talkMaxDuration)

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_20 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_10) / var_292_20

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_10 + var_292_20 and arg_289_1.time_ < var_292_10 + var_292_20 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play322192072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 322192072
		arg_293_1.duration_ = 6.67

		local var_293_0 = {
			zh = 4.7,
			ja = 6.666
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play322192073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_1")
			end

			local var_296_1 = 0
			local var_296_2 = 0.45

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_3 = arg_293_1:FormatText(StoryNameCfg[67].name)

				arg_293_1.leftNameTxt_.text = var_296_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_4 = arg_293_1:GetWordFromCfg(322192072)
				local var_296_5 = arg_293_1:FormatText(var_296_4.content)

				arg_293_1.text_.text = var_296_5

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_6 = 18
				local var_296_7 = utf8.len(var_296_5)
				local var_296_8 = var_296_6 <= 0 and var_296_2 or var_296_2 * (var_296_7 / var_296_6)

				if var_296_8 > 0 and var_296_2 < var_296_8 then
					arg_293_1.talkMaxDuration = var_296_8

					if var_296_8 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_1
					end
				end

				arg_293_1.text_.text = var_296_5
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192072", "story_v_out_322192.awb") ~= 0 then
					local var_296_9 = manager.audio:GetVoiceLength("story_v_out_322192", "322192072", "story_v_out_322192.awb") / 1000

					if var_296_9 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_9 + var_296_1
					end

					if var_296_4.prefab_name ~= "" and arg_293_1.actors_[var_296_4.prefab_name] ~= nil then
						local var_296_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_4.prefab_name].transform, "story_v_out_322192", "322192072", "story_v_out_322192.awb")

						arg_293_1:RecordAudio("322192072", var_296_10)
						arg_293_1:RecordAudio("322192072", var_296_10)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_322192", "322192072", "story_v_out_322192.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_322192", "322192072", "story_v_out_322192.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_11 = math.max(var_296_2, arg_293_1.talkMaxDuration)

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_11 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_1) / var_296_11

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_1 + var_296_11 and arg_293_1.time_ < var_296_1 + var_296_11 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play322192073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 322192073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play322192074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1111ui_story"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos1111ui_story = var_300_0.localPosition
			end

			local var_300_2 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2
				local var_300_4 = Vector3.New(0, 100, 0)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1111ui_story, var_300_4, var_300_3)

				local var_300_5 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_5.x, var_300_5.y, var_300_5.z)

				local var_300_6 = var_300_0.localEulerAngles

				var_300_6.z = 0
				var_300_6.x = 0
				var_300_0.localEulerAngles = var_300_6
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0, 100, 0)

				local var_300_7 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_7.x, var_300_7.y, var_300_7.z)

				local var_300_8 = var_300_0.localEulerAngles

				var_300_8.z = 0
				var_300_8.x = 0
				var_300_0.localEulerAngles = var_300_8
			end

			local var_300_9 = arg_297_1.actors_["1211ui_story"].transform
			local var_300_10 = 0

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 then
				arg_297_1.var_.moveOldPos1211ui_story = var_300_9.localPosition
			end

			local var_300_11 = 0.001

			if var_300_10 <= arg_297_1.time_ and arg_297_1.time_ < var_300_10 + var_300_11 then
				local var_300_12 = (arg_297_1.time_ - var_300_10) / var_300_11
				local var_300_13 = Vector3.New(0, 100, 0)

				var_300_9.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1211ui_story, var_300_13, var_300_12)

				local var_300_14 = manager.ui.mainCamera.transform.position - var_300_9.position

				var_300_9.forward = Vector3.New(var_300_14.x, var_300_14.y, var_300_14.z)

				local var_300_15 = var_300_9.localEulerAngles

				var_300_15.z = 0
				var_300_15.x = 0
				var_300_9.localEulerAngles = var_300_15
			end

			if arg_297_1.time_ >= var_300_10 + var_300_11 and arg_297_1.time_ < var_300_10 + var_300_11 + arg_300_0 then
				var_300_9.localPosition = Vector3.New(0, 100, 0)

				local var_300_16 = manager.ui.mainCamera.transform.position - var_300_9.position

				var_300_9.forward = Vector3.New(var_300_16.x, var_300_16.y, var_300_16.z)

				local var_300_17 = var_300_9.localEulerAngles

				var_300_17.z = 0
				var_300_17.x = 0
				var_300_9.localEulerAngles = var_300_17
			end

			local var_300_18 = 0
			local var_300_19 = 1.25

			if var_300_18 < arg_297_1.time_ and arg_297_1.time_ <= var_300_18 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_20 = arg_297_1:GetWordFromCfg(322192073)
				local var_300_21 = arg_297_1:FormatText(var_300_20.content)

				arg_297_1.text_.text = var_300_21

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_22 = 50
				local var_300_23 = utf8.len(var_300_21)
				local var_300_24 = var_300_22 <= 0 and var_300_19 or var_300_19 * (var_300_23 / var_300_22)

				if var_300_24 > 0 and var_300_19 < var_300_24 then
					arg_297_1.talkMaxDuration = var_300_24

					if var_300_24 + var_300_18 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_24 + var_300_18
					end
				end

				arg_297_1.text_.text = var_300_21
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_25 = math.max(var_300_19, arg_297_1.talkMaxDuration)

			if var_300_18 <= arg_297_1.time_ and arg_297_1.time_ < var_300_18 + var_300_25 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_18) / var_300_25

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_18 + var_300_25 and arg_297_1.time_ < var_300_18 + var_300_25 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play322192074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 322192074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play322192075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 1.425

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_2 = arg_301_1:GetWordFromCfg(322192074)
				local var_304_3 = arg_301_1:FormatText(var_304_2.content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 57
				local var_304_5 = utf8.len(var_304_3)
				local var_304_6 = var_304_4 <= 0 and var_304_1 or var_304_1 * (var_304_5 / var_304_4)

				if var_304_6 > 0 and var_304_1 < var_304_6 then
					arg_301_1.talkMaxDuration = var_304_6

					if var_304_6 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_6 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_7 and arg_301_1.time_ < var_304_0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play322192075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 322192075
		arg_305_1.duration_ = 6.93

		local var_305_0 = {
			zh = 6.933,
			ja = 6.666
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play322192076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1211ui_story"].transform
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.var_.moveOldPos1211ui_story = var_308_0.localPosition
			end

			local var_308_2 = 0.001

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2
				local var_308_4 = Vector3.New(0, -0.67, -6.07)

				var_308_0.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1211ui_story, var_308_4, var_308_3)

				local var_308_5 = manager.ui.mainCamera.transform.position - var_308_0.position

				var_308_0.forward = Vector3.New(var_308_5.x, var_308_5.y, var_308_5.z)

				local var_308_6 = var_308_0.localEulerAngles

				var_308_6.z = 0
				var_308_6.x = 0
				var_308_0.localEulerAngles = var_308_6
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 then
				var_308_0.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_308_7 = manager.ui.mainCamera.transform.position - var_308_0.position

				var_308_0.forward = Vector3.New(var_308_7.x, var_308_7.y, var_308_7.z)

				local var_308_8 = var_308_0.localEulerAngles

				var_308_8.z = 0
				var_308_8.x = 0
				var_308_0.localEulerAngles = var_308_8
			end

			local var_308_9 = arg_305_1.actors_["1211ui_story"]
			local var_308_10 = 0

			if var_308_10 < arg_305_1.time_ and arg_305_1.time_ <= var_308_10 + arg_308_0 and not isNil(var_308_9) and arg_305_1.var_.characterEffect1211ui_story == nil then
				arg_305_1.var_.characterEffect1211ui_story = var_308_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_11 = 0.200000002980232

			if var_308_10 <= arg_305_1.time_ and arg_305_1.time_ < var_308_10 + var_308_11 and not isNil(var_308_9) then
				local var_308_12 = (arg_305_1.time_ - var_308_10) / var_308_11

				if arg_305_1.var_.characterEffect1211ui_story and not isNil(var_308_9) then
					arg_305_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= var_308_10 + var_308_11 and arg_305_1.time_ < var_308_10 + var_308_11 + arg_308_0 and not isNil(var_308_9) and arg_305_1.var_.characterEffect1211ui_story then
				arg_305_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_308_13 = 0

			if var_308_13 < arg_305_1.time_ and arg_305_1.time_ <= var_308_13 + arg_308_0 then
				arg_305_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_1")
			end

			local var_308_14 = 0

			if var_308_14 < arg_305_1.time_ and arg_305_1.time_ <= var_308_14 + arg_308_0 then
				arg_305_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_308_15 = 0
			local var_308_16 = 0.45

			if var_308_15 < arg_305_1.time_ and arg_305_1.time_ <= var_308_15 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_17 = arg_305_1:FormatText(StoryNameCfg[37].name)

				arg_305_1.leftNameTxt_.text = var_308_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_18 = arg_305_1:GetWordFromCfg(322192075)
				local var_308_19 = arg_305_1:FormatText(var_308_18.content)

				arg_305_1.text_.text = var_308_19

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_20 = 18
				local var_308_21 = utf8.len(var_308_19)
				local var_308_22 = var_308_20 <= 0 and var_308_16 or var_308_16 * (var_308_21 / var_308_20)

				if var_308_22 > 0 and var_308_16 < var_308_22 then
					arg_305_1.talkMaxDuration = var_308_22

					if var_308_22 + var_308_15 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_22 + var_308_15
					end
				end

				arg_305_1.text_.text = var_308_19
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192075", "story_v_out_322192.awb") ~= 0 then
					local var_308_23 = manager.audio:GetVoiceLength("story_v_out_322192", "322192075", "story_v_out_322192.awb") / 1000

					if var_308_23 + var_308_15 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_23 + var_308_15
					end

					if var_308_18.prefab_name ~= "" and arg_305_1.actors_[var_308_18.prefab_name] ~= nil then
						local var_308_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_18.prefab_name].transform, "story_v_out_322192", "322192075", "story_v_out_322192.awb")

						arg_305_1:RecordAudio("322192075", var_308_24)
						arg_305_1:RecordAudio("322192075", var_308_24)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_322192", "322192075", "story_v_out_322192.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_322192", "322192075", "story_v_out_322192.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_25 = math.max(var_308_16, arg_305_1.talkMaxDuration)

			if var_308_15 <= arg_305_1.time_ and arg_305_1.time_ < var_308_15 + var_308_25 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_15) / var_308_25

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_15 + var_308_25 and arg_305_1.time_ < var_308_15 + var_308_25 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play322192076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 322192076
		arg_309_1.duration_ = 20.13

		local var_309_0 = {
			zh = 12.8,
			ja = 20.133
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play322192077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 1.075

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[37].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_3 = arg_309_1:GetWordFromCfg(322192076)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 43
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192076", "story_v_out_322192.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192076", "story_v_out_322192.awb") / 1000

					if var_312_8 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_0
					end

					if var_312_3.prefab_name ~= "" and arg_309_1.actors_[var_312_3.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_3.prefab_name].transform, "story_v_out_322192", "322192076", "story_v_out_322192.awb")

						arg_309_1:RecordAudio("322192076", var_312_9)
						arg_309_1:RecordAudio("322192076", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_322192", "322192076", "story_v_out_322192.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_322192", "322192076", "story_v_out_322192.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_10 and arg_309_1.time_ < var_312_0 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play322192077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 322192077
		arg_313_1.duration_ = 6.9

		local var_313_0 = {
			zh = 4.466,
			ja = 6.9
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play322192078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.325

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_2 = arg_313_1:FormatText(StoryNameCfg[37].name)

				arg_313_1.leftNameTxt_.text = var_316_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_3 = arg_313_1:GetWordFromCfg(322192077)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 13
				local var_316_6 = utf8.len(var_316_4)
				local var_316_7 = var_316_5 <= 0 and var_316_1 or var_316_1 * (var_316_6 / var_316_5)

				if var_316_7 > 0 and var_316_1 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192077", "story_v_out_322192.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192077", "story_v_out_322192.awb") / 1000

					if var_316_8 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_0
					end

					if var_316_3.prefab_name ~= "" and arg_313_1.actors_[var_316_3.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_3.prefab_name].transform, "story_v_out_322192", "322192077", "story_v_out_322192.awb")

						arg_313_1:RecordAudio("322192077", var_316_9)
						arg_313_1:RecordAudio("322192077", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_322192", "322192077", "story_v_out_322192.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_322192", "322192077", "story_v_out_322192.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_10 and arg_313_1.time_ < var_316_0 + var_316_10 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play322192078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 322192078
		arg_317_1.duration_ = 2

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play322192079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1211ui_story"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos1211ui_story = var_320_0.localPosition
			end

			local var_320_2 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2
				local var_320_4 = Vector3.New(0, 100, 0)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1211ui_story, var_320_4, var_320_3)

				local var_320_5 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_5.x, var_320_5.y, var_320_5.z)

				local var_320_6 = var_320_0.localEulerAngles

				var_320_6.z = 0
				var_320_6.x = 0
				var_320_0.localEulerAngles = var_320_6
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(0, 100, 0)

				local var_320_7 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_7.x, var_320_7.y, var_320_7.z)

				local var_320_8 = var_320_0.localEulerAngles

				var_320_8.z = 0
				var_320_8.x = 0
				var_320_0.localEulerAngles = var_320_8
			end

			local var_320_9 = arg_317_1.actors_["1111ui_story"].transform
			local var_320_10 = 0

			if var_320_10 < arg_317_1.time_ and arg_317_1.time_ <= var_320_10 + arg_320_0 then
				arg_317_1.var_.moveOldPos1111ui_story = var_320_9.localPosition
			end

			local var_320_11 = 0.001

			if var_320_10 <= arg_317_1.time_ and arg_317_1.time_ < var_320_10 + var_320_11 then
				local var_320_12 = (arg_317_1.time_ - var_320_10) / var_320_11
				local var_320_13 = Vector3.New(0, -0.87, -5.7)

				var_320_9.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1111ui_story, var_320_13, var_320_12)

				local var_320_14 = manager.ui.mainCamera.transform.position - var_320_9.position

				var_320_9.forward = Vector3.New(var_320_14.x, var_320_14.y, var_320_14.z)

				local var_320_15 = var_320_9.localEulerAngles

				var_320_15.z = 0
				var_320_15.x = 0
				var_320_9.localEulerAngles = var_320_15
			end

			if arg_317_1.time_ >= var_320_10 + var_320_11 and arg_317_1.time_ < var_320_10 + var_320_11 + arg_320_0 then
				var_320_9.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_320_16 = manager.ui.mainCamera.transform.position - var_320_9.position

				var_320_9.forward = Vector3.New(var_320_16.x, var_320_16.y, var_320_16.z)

				local var_320_17 = var_320_9.localEulerAngles

				var_320_17.z = 0
				var_320_17.x = 0
				var_320_9.localEulerAngles = var_320_17
			end

			local var_320_18 = arg_317_1.actors_["1111ui_story"]
			local var_320_19 = 0

			if var_320_19 < arg_317_1.time_ and arg_317_1.time_ <= var_320_19 + arg_320_0 and not isNil(var_320_18) and arg_317_1.var_.characterEffect1111ui_story == nil then
				arg_317_1.var_.characterEffect1111ui_story = var_320_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_20 = 0.200000002980232

			if var_320_19 <= arg_317_1.time_ and arg_317_1.time_ < var_320_19 + var_320_20 and not isNil(var_320_18) then
				local var_320_21 = (arg_317_1.time_ - var_320_19) / var_320_20

				if arg_317_1.var_.characterEffect1111ui_story and not isNil(var_320_18) then
					arg_317_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_19 + var_320_20 and arg_317_1.time_ < var_320_19 + var_320_20 + arg_320_0 and not isNil(var_320_18) and arg_317_1.var_.characterEffect1111ui_story then
				arg_317_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_320_22 = arg_317_1.actors_["1211ui_story"]
			local var_320_23 = 0

			if var_320_23 < arg_317_1.time_ and arg_317_1.time_ <= var_320_23 + arg_320_0 and not isNil(var_320_22) and arg_317_1.var_.characterEffect1211ui_story == nil then
				arg_317_1.var_.characterEffect1211ui_story = var_320_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_24 = 0.200000002980232

			if var_320_23 <= arg_317_1.time_ and arg_317_1.time_ < var_320_23 + var_320_24 and not isNil(var_320_22) then
				local var_320_25 = (arg_317_1.time_ - var_320_23) / var_320_24

				if arg_317_1.var_.characterEffect1211ui_story and not isNil(var_320_22) then
					local var_320_26 = Mathf.Lerp(0, 0.5, var_320_25)

					arg_317_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1211ui_story.fillRatio = var_320_26
				end
			end

			if arg_317_1.time_ >= var_320_23 + var_320_24 and arg_317_1.time_ < var_320_23 + var_320_24 + arg_320_0 and not isNil(var_320_22) and arg_317_1.var_.characterEffect1211ui_story then
				local var_320_27 = 0.5

				arg_317_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1211ui_story.fillRatio = var_320_27
			end

			local var_320_28 = 0

			if var_320_28 < arg_317_1.time_ and arg_317_1.time_ <= var_320_28 + arg_320_0 then
				arg_317_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_2")
			end

			local var_320_29 = 0

			if var_320_29 < arg_317_1.time_ and arg_317_1.time_ <= var_320_29 + arg_320_0 then
				arg_317_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_320_30 = 0
			local var_320_31 = 0.1

			if var_320_30 < arg_317_1.time_ and arg_317_1.time_ <= var_320_30 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_32 = arg_317_1:FormatText(StoryNameCfg[67].name)

				arg_317_1.leftNameTxt_.text = var_320_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_33 = arg_317_1:GetWordFromCfg(322192078)
				local var_320_34 = arg_317_1:FormatText(var_320_33.content)

				arg_317_1.text_.text = var_320_34

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_35 = 4
				local var_320_36 = utf8.len(var_320_34)
				local var_320_37 = var_320_35 <= 0 and var_320_31 or var_320_31 * (var_320_36 / var_320_35)

				if var_320_37 > 0 and var_320_31 < var_320_37 then
					arg_317_1.talkMaxDuration = var_320_37

					if var_320_37 + var_320_30 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_37 + var_320_30
					end
				end

				arg_317_1.text_.text = var_320_34
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192078", "story_v_out_322192.awb") ~= 0 then
					local var_320_38 = manager.audio:GetVoiceLength("story_v_out_322192", "322192078", "story_v_out_322192.awb") / 1000

					if var_320_38 + var_320_30 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_38 + var_320_30
					end

					if var_320_33.prefab_name ~= "" and arg_317_1.actors_[var_320_33.prefab_name] ~= nil then
						local var_320_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_33.prefab_name].transform, "story_v_out_322192", "322192078", "story_v_out_322192.awb")

						arg_317_1:RecordAudio("322192078", var_320_39)
						arg_317_1:RecordAudio("322192078", var_320_39)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_322192", "322192078", "story_v_out_322192.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_322192", "322192078", "story_v_out_322192.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_40 = math.max(var_320_31, arg_317_1.talkMaxDuration)

			if var_320_30 <= arg_317_1.time_ and arg_317_1.time_ < var_320_30 + var_320_40 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_30) / var_320_40

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_30 + var_320_40 and arg_317_1.time_ < var_320_30 + var_320_40 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play322192079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 322192079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play322192080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1111ui_story"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos1111ui_story = var_324_0.localPosition
			end

			local var_324_2 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2
				local var_324_4 = Vector3.New(0, 100, 0)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1111ui_story, var_324_4, var_324_3)

				local var_324_5 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_5.x, var_324_5.y, var_324_5.z)

				local var_324_6 = var_324_0.localEulerAngles

				var_324_6.z = 0
				var_324_6.x = 0
				var_324_0.localEulerAngles = var_324_6
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(0, 100, 0)

				local var_324_7 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_7.x, var_324_7.y, var_324_7.z)

				local var_324_8 = var_324_0.localEulerAngles

				var_324_8.z = 0
				var_324_8.x = 0
				var_324_0.localEulerAngles = var_324_8
			end

			local var_324_9 = 0
			local var_324_10 = 0.85

			if var_324_9 < arg_321_1.time_ and arg_321_1.time_ <= var_324_9 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_11 = arg_321_1:GetWordFromCfg(322192079)
				local var_324_12 = arg_321_1:FormatText(var_324_11.content)

				arg_321_1.text_.text = var_324_12

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_13 = 34
				local var_324_14 = utf8.len(var_324_12)
				local var_324_15 = var_324_13 <= 0 and var_324_10 or var_324_10 * (var_324_14 / var_324_13)

				if var_324_15 > 0 and var_324_10 < var_324_15 then
					arg_321_1.talkMaxDuration = var_324_15

					if var_324_15 + var_324_9 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_15 + var_324_9
					end
				end

				arg_321_1.text_.text = var_324_12
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_16 = math.max(var_324_10, arg_321_1.talkMaxDuration)

			if var_324_9 <= arg_321_1.time_ and arg_321_1.time_ < var_324_9 + var_324_16 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_9) / var_324_16

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_9 + var_324_16 and arg_321_1.time_ < var_324_9 + var_324_16 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play322192080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 322192080
		arg_325_1.duration_ = 12.23

		local var_325_0 = {
			zh = 9.2,
			ja = 12.233
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play322192081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1211ui_story"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos1211ui_story = var_328_0.localPosition
			end

			local var_328_2 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2
				local var_328_4 = Vector3.New(0, -0.67, -6.07)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1211ui_story, var_328_4, var_328_3)

				local var_328_5 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_5.x, var_328_5.y, var_328_5.z)

				local var_328_6 = var_328_0.localEulerAngles

				var_328_6.z = 0
				var_328_6.x = 0
				var_328_0.localEulerAngles = var_328_6
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_328_7 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_7.x, var_328_7.y, var_328_7.z)

				local var_328_8 = var_328_0.localEulerAngles

				var_328_8.z = 0
				var_328_8.x = 0
				var_328_0.localEulerAngles = var_328_8
			end

			local var_328_9 = arg_325_1.actors_["1211ui_story"]
			local var_328_10 = 0

			if var_328_10 < arg_325_1.time_ and arg_325_1.time_ <= var_328_10 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1211ui_story == nil then
				arg_325_1.var_.characterEffect1211ui_story = var_328_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_11 = 0.200000002980232

			if var_328_10 <= arg_325_1.time_ and arg_325_1.time_ < var_328_10 + var_328_11 and not isNil(var_328_9) then
				local var_328_12 = (arg_325_1.time_ - var_328_10) / var_328_11

				if arg_325_1.var_.characterEffect1211ui_story and not isNil(var_328_9) then
					arg_325_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_10 + var_328_11 and arg_325_1.time_ < var_328_10 + var_328_11 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1211ui_story then
				arg_325_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_328_13 = 0

			if var_328_13 < arg_325_1.time_ and arg_325_1.time_ <= var_328_13 + arg_328_0 then
				arg_325_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_1")
			end

			local var_328_14 = 0
			local var_328_15 = 0.675

			if var_328_14 < arg_325_1.time_ and arg_325_1.time_ <= var_328_14 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_16 = arg_325_1:FormatText(StoryNameCfg[37].name)

				arg_325_1.leftNameTxt_.text = var_328_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_17 = arg_325_1:GetWordFromCfg(322192080)
				local var_328_18 = arg_325_1:FormatText(var_328_17.content)

				arg_325_1.text_.text = var_328_18

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_19 = 27
				local var_328_20 = utf8.len(var_328_18)
				local var_328_21 = var_328_19 <= 0 and var_328_15 or var_328_15 * (var_328_20 / var_328_19)

				if var_328_21 > 0 and var_328_15 < var_328_21 then
					arg_325_1.talkMaxDuration = var_328_21

					if var_328_21 + var_328_14 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_21 + var_328_14
					end
				end

				arg_325_1.text_.text = var_328_18
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192080", "story_v_out_322192.awb") ~= 0 then
					local var_328_22 = manager.audio:GetVoiceLength("story_v_out_322192", "322192080", "story_v_out_322192.awb") / 1000

					if var_328_22 + var_328_14 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_22 + var_328_14
					end

					if var_328_17.prefab_name ~= "" and arg_325_1.actors_[var_328_17.prefab_name] ~= nil then
						local var_328_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_17.prefab_name].transform, "story_v_out_322192", "322192080", "story_v_out_322192.awb")

						arg_325_1:RecordAudio("322192080", var_328_23)
						arg_325_1:RecordAudio("322192080", var_328_23)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_322192", "322192080", "story_v_out_322192.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_322192", "322192080", "story_v_out_322192.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_24 = math.max(var_328_15, arg_325_1.talkMaxDuration)

			if var_328_14 <= arg_325_1.time_ and arg_325_1.time_ < var_328_14 + var_328_24 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_14) / var_328_24

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_14 + var_328_24 and arg_325_1.time_ < var_328_14 + var_328_24 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play322192081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 322192081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play322192082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1111ui_story"].transform
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.var_.moveOldPos1111ui_story = var_332_0.localPosition
			end

			local var_332_2 = 0.001

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2
				local var_332_4 = Vector3.New(0, 100, 0)

				var_332_0.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1111ui_story, var_332_4, var_332_3)

				local var_332_5 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_5.x, var_332_5.y, var_332_5.z)

				local var_332_6 = var_332_0.localEulerAngles

				var_332_6.z = 0
				var_332_6.x = 0
				var_332_0.localEulerAngles = var_332_6
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 then
				var_332_0.localPosition = Vector3.New(0, 100, 0)

				local var_332_7 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_7.x, var_332_7.y, var_332_7.z)

				local var_332_8 = var_332_0.localEulerAngles

				var_332_8.z = 0
				var_332_8.x = 0
				var_332_0.localEulerAngles = var_332_8
			end

			local var_332_9 = arg_329_1.actors_["1211ui_story"].transform
			local var_332_10 = 0

			if var_332_10 < arg_329_1.time_ and arg_329_1.time_ <= var_332_10 + arg_332_0 then
				arg_329_1.var_.moveOldPos1211ui_story = var_332_9.localPosition
			end

			local var_332_11 = 0.001

			if var_332_10 <= arg_329_1.time_ and arg_329_1.time_ < var_332_10 + var_332_11 then
				local var_332_12 = (arg_329_1.time_ - var_332_10) / var_332_11
				local var_332_13 = Vector3.New(0, 100, 0)

				var_332_9.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1211ui_story, var_332_13, var_332_12)

				local var_332_14 = manager.ui.mainCamera.transform.position - var_332_9.position

				var_332_9.forward = Vector3.New(var_332_14.x, var_332_14.y, var_332_14.z)

				local var_332_15 = var_332_9.localEulerAngles

				var_332_15.z = 0
				var_332_15.x = 0
				var_332_9.localEulerAngles = var_332_15
			end

			if arg_329_1.time_ >= var_332_10 + var_332_11 and arg_329_1.time_ < var_332_10 + var_332_11 + arg_332_0 then
				var_332_9.localPosition = Vector3.New(0, 100, 0)

				local var_332_16 = manager.ui.mainCamera.transform.position - var_332_9.position

				var_332_9.forward = Vector3.New(var_332_16.x, var_332_16.y, var_332_16.z)

				local var_332_17 = var_332_9.localEulerAngles

				var_332_17.z = 0
				var_332_17.x = 0
				var_332_9.localEulerAngles = var_332_17
			end

			local var_332_18 = 0.1
			local var_332_19 = 1

			if var_332_18 < arg_329_1.time_ and arg_329_1.time_ <= var_332_18 + arg_332_0 then
				local var_332_20 = "play"
				local var_332_21 = "effect"

				arg_329_1:AudioAction(var_332_20, var_332_21, "se_story_140", "se_story_140_pistol2", "")
			end

			local var_332_22 = 0
			local var_332_23 = 1

			if var_332_22 < arg_329_1.time_ and arg_329_1.time_ <= var_332_22 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_24 = arg_329_1:GetWordFromCfg(322192081)
				local var_332_25 = arg_329_1:FormatText(var_332_24.content)

				arg_329_1.text_.text = var_332_25

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_26 = 40
				local var_332_27 = utf8.len(var_332_25)
				local var_332_28 = var_332_26 <= 0 and var_332_23 or var_332_23 * (var_332_27 / var_332_26)

				if var_332_28 > 0 and var_332_23 < var_332_28 then
					arg_329_1.talkMaxDuration = var_332_28

					if var_332_28 + var_332_22 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_28 + var_332_22
					end
				end

				arg_329_1.text_.text = var_332_25
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_29 = math.max(var_332_23, arg_329_1.talkMaxDuration)

			if var_332_22 <= arg_329_1.time_ and arg_329_1.time_ < var_332_22 + var_332_29 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_22) / var_332_29

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_22 + var_332_29 and arg_329_1.time_ < var_332_22 + var_332_29 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play322192082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 322192082
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play322192083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0.1
			local var_336_1 = 1

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				local var_336_2 = "play"
				local var_336_3 = "effect"

				arg_333_1:AudioAction(var_336_2, var_336_3, "se_story_5", "se_story_5_back", "")
			end

			local var_336_4 = 0
			local var_336_5 = 0.95

			if var_336_4 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_6 = arg_333_1:GetWordFromCfg(322192082)
				local var_336_7 = arg_333_1:FormatText(var_336_6.content)

				arg_333_1.text_.text = var_336_7

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_8 = 38
				local var_336_9 = utf8.len(var_336_7)
				local var_336_10 = var_336_8 <= 0 and var_336_5 or var_336_5 * (var_336_9 / var_336_8)

				if var_336_10 > 0 and var_336_5 < var_336_10 then
					arg_333_1.talkMaxDuration = var_336_10

					if var_336_10 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_4
					end
				end

				arg_333_1.text_.text = var_336_7
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_11 = math.max(var_336_5, arg_333_1.talkMaxDuration)

			if var_336_4 <= arg_333_1.time_ and arg_333_1.time_ < var_336_4 + var_336_11 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_4) / var_336_11

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_4 + var_336_11 and arg_333_1.time_ < var_336_4 + var_336_11 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play322192083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 322192083
		arg_337_1.duration_ = 10.67

		local var_337_0 = {
			zh = 10.666,
			ja = 9.766
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play322192084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1211ui_story"].transform
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.var_.moveOldPos1211ui_story = var_340_0.localPosition
			end

			local var_340_2 = 0.001

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2
				local var_340_4 = Vector3.New(0, -0.67, -6.07)

				var_340_0.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1211ui_story, var_340_4, var_340_3)

				local var_340_5 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_5.x, var_340_5.y, var_340_5.z)

				local var_340_6 = var_340_0.localEulerAngles

				var_340_6.z = 0
				var_340_6.x = 0
				var_340_0.localEulerAngles = var_340_6
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 then
				var_340_0.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_340_7 = manager.ui.mainCamera.transform.position - var_340_0.position

				var_340_0.forward = Vector3.New(var_340_7.x, var_340_7.y, var_340_7.z)

				local var_340_8 = var_340_0.localEulerAngles

				var_340_8.z = 0
				var_340_8.x = 0
				var_340_0.localEulerAngles = var_340_8
			end

			local var_340_9 = arg_337_1.actors_["1211ui_story"]
			local var_340_10 = 0

			if var_340_10 < arg_337_1.time_ and arg_337_1.time_ <= var_340_10 + arg_340_0 and not isNil(var_340_9) and arg_337_1.var_.characterEffect1211ui_story == nil then
				arg_337_1.var_.characterEffect1211ui_story = var_340_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_11 = 0.200000002980232

			if var_340_10 <= arg_337_1.time_ and arg_337_1.time_ < var_340_10 + var_340_11 and not isNil(var_340_9) then
				local var_340_12 = (arg_337_1.time_ - var_340_10) / var_340_11

				if arg_337_1.var_.characterEffect1211ui_story and not isNil(var_340_9) then
					arg_337_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= var_340_10 + var_340_11 and arg_337_1.time_ < var_340_10 + var_340_11 + arg_340_0 and not isNil(var_340_9) and arg_337_1.var_.characterEffect1211ui_story then
				arg_337_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_340_13 = 0

			if var_340_13 < arg_337_1.time_ and arg_337_1.time_ <= var_340_13 + arg_340_0 then
				arg_337_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211actionlink/1211action459")
			end

			local var_340_14 = 0
			local var_340_15 = 0.725

			if var_340_14 < arg_337_1.time_ and arg_337_1.time_ <= var_340_14 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_16 = arg_337_1:FormatText(StoryNameCfg[37].name)

				arg_337_1.leftNameTxt_.text = var_340_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_17 = arg_337_1:GetWordFromCfg(322192083)
				local var_340_18 = arg_337_1:FormatText(var_340_17.content)

				arg_337_1.text_.text = var_340_18

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_19 = 29
				local var_340_20 = utf8.len(var_340_18)
				local var_340_21 = var_340_19 <= 0 and var_340_15 or var_340_15 * (var_340_20 / var_340_19)

				if var_340_21 > 0 and var_340_15 < var_340_21 then
					arg_337_1.talkMaxDuration = var_340_21

					if var_340_21 + var_340_14 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_21 + var_340_14
					end
				end

				arg_337_1.text_.text = var_340_18
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192083", "story_v_out_322192.awb") ~= 0 then
					local var_340_22 = manager.audio:GetVoiceLength("story_v_out_322192", "322192083", "story_v_out_322192.awb") / 1000

					if var_340_22 + var_340_14 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_22 + var_340_14
					end

					if var_340_17.prefab_name ~= "" and arg_337_1.actors_[var_340_17.prefab_name] ~= nil then
						local var_340_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_17.prefab_name].transform, "story_v_out_322192", "322192083", "story_v_out_322192.awb")

						arg_337_1:RecordAudio("322192083", var_340_23)
						arg_337_1:RecordAudio("322192083", var_340_23)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_322192", "322192083", "story_v_out_322192.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_322192", "322192083", "story_v_out_322192.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_24 = math.max(var_340_15, arg_337_1.talkMaxDuration)

			if var_340_14 <= arg_337_1.time_ and arg_337_1.time_ < var_340_14 + var_340_24 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_14) / var_340_24

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_14 + var_340_24 and arg_337_1.time_ < var_340_14 + var_340_24 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play322192084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 322192084
		arg_341_1.duration_ = 8.53

		local var_341_0 = {
			zh = 7.266,
			ja = 8.533
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play322192085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 0.525

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_2 = arg_341_1:FormatText(StoryNameCfg[37].name)

				arg_341_1.leftNameTxt_.text = var_344_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_3 = arg_341_1:GetWordFromCfg(322192084)
				local var_344_4 = arg_341_1:FormatText(var_344_3.content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 21
				local var_344_6 = utf8.len(var_344_4)
				local var_344_7 = var_344_5 <= 0 and var_344_1 or var_344_1 * (var_344_6 / var_344_5)

				if var_344_7 > 0 and var_344_1 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_4
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192084", "story_v_out_322192.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192084", "story_v_out_322192.awb") / 1000

					if var_344_8 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_0
					end

					if var_344_3.prefab_name ~= "" and arg_341_1.actors_[var_344_3.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_3.prefab_name].transform, "story_v_out_322192", "322192084", "story_v_out_322192.awb")

						arg_341_1:RecordAudio("322192084", var_344_9)
						arg_341_1:RecordAudio("322192084", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_322192", "322192084", "story_v_out_322192.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_322192", "322192084", "story_v_out_322192.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_10 and arg_341_1.time_ < var_344_0 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play322192085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 322192085
		arg_345_1.duration_ = 4

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play322192086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 1

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				local var_348_1 = manager.ui.mainCamera.transform.localPosition
				local var_348_2 = Vector3.New(0, 0, 10) + Vector3.New(var_348_1.x, var_348_1.y, 0)
				local var_348_3 = arg_345_1.bgs_.STblack

				var_348_3.transform.localPosition = var_348_2
				var_348_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_348_4 = var_348_3:GetComponent("SpriteRenderer")

				if var_348_4 and var_348_4.sprite then
					local var_348_5 = (var_348_3.transform.localPosition - var_348_1).z
					local var_348_6 = manager.ui.mainCameraCom_
					local var_348_7 = 2 * var_348_5 * Mathf.Tan(var_348_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_348_8 = var_348_7 * var_348_6.aspect
					local var_348_9 = var_348_4.sprite.bounds.size.x
					local var_348_10 = var_348_4.sprite.bounds.size.y
					local var_348_11 = var_348_8 / var_348_9
					local var_348_12 = var_348_7 / var_348_10
					local var_348_13 = var_348_12 < var_348_11 and var_348_11 or var_348_12

					var_348_3.transform.localScale = Vector3.New(var_348_13, var_348_13, 0)
				end

				for iter_348_0, iter_348_1 in pairs(arg_345_1.bgs_) do
					if iter_348_0 ~= "STblack" then
						iter_348_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_348_14 = 2

			if var_348_14 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			local var_348_15 = 0.0499999999999998

			if arg_345_1.time_ >= var_348_14 + var_348_15 and arg_345_1.time_ < var_348_14 + var_348_15 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end

			local var_348_16 = 0

			if var_348_16 < arg_345_1.time_ and arg_345_1.time_ <= var_348_16 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_17 = 1

			if var_348_16 <= arg_345_1.time_ and arg_345_1.time_ < var_348_16 + var_348_17 then
				local var_348_18 = (arg_345_1.time_ - var_348_16) / var_348_17
				local var_348_19 = Color.New(0, 0, 0)

				var_348_19.a = Mathf.Lerp(0, 1, var_348_18)
				arg_345_1.mask_.color = var_348_19
			end

			if arg_345_1.time_ >= var_348_16 + var_348_17 and arg_345_1.time_ < var_348_16 + var_348_17 + arg_348_0 then
				local var_348_20 = Color.New(0, 0, 0)

				var_348_20.a = 1
				arg_345_1.mask_.color = var_348_20
			end

			local var_348_21 = 1

			if var_348_21 < arg_345_1.time_ and arg_345_1.time_ <= var_348_21 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_22 = 1

			if var_348_21 <= arg_345_1.time_ and arg_345_1.time_ < var_348_21 + var_348_22 then
				local var_348_23 = (arg_345_1.time_ - var_348_21) / var_348_22
				local var_348_24 = Color.New(0, 0, 0)

				var_348_24.a = Mathf.Lerp(1, 0, var_348_23)
				arg_345_1.mask_.color = var_348_24
			end

			if arg_345_1.time_ >= var_348_21 + var_348_22 and arg_345_1.time_ < var_348_21 + var_348_22 + arg_348_0 then
				local var_348_25 = Color.New(0, 0, 0)
				local var_348_26 = 0

				arg_345_1.mask_.enabled = false
				var_348_25.a = var_348_26
				arg_345_1.mask_.color = var_348_25
			end

			local var_348_27 = arg_345_1.actors_["1111ui_story"].transform
			local var_348_28 = 2

			if var_348_28 < arg_345_1.time_ and arg_345_1.time_ <= var_348_28 + arg_348_0 then
				arg_345_1.var_.moveOldPos1111ui_story = var_348_27.localPosition
			end

			local var_348_29 = 0.001

			if var_348_28 <= arg_345_1.time_ and arg_345_1.time_ < var_348_28 + var_348_29 then
				local var_348_30 = (arg_345_1.time_ - var_348_28) / var_348_29
				local var_348_31 = Vector3.New(0, -0.87, -5.7)

				var_348_27.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1111ui_story, var_348_31, var_348_30)

				local var_348_32 = manager.ui.mainCamera.transform.position - var_348_27.position

				var_348_27.forward = Vector3.New(var_348_32.x, var_348_32.y, var_348_32.z)

				local var_348_33 = var_348_27.localEulerAngles

				var_348_33.z = 0
				var_348_33.x = 0
				var_348_27.localEulerAngles = var_348_33
			end

			if arg_345_1.time_ >= var_348_28 + var_348_29 and arg_345_1.time_ < var_348_28 + var_348_29 + arg_348_0 then
				var_348_27.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_348_34 = manager.ui.mainCamera.transform.position - var_348_27.position

				var_348_27.forward = Vector3.New(var_348_34.x, var_348_34.y, var_348_34.z)

				local var_348_35 = var_348_27.localEulerAngles

				var_348_35.z = 0
				var_348_35.x = 0
				var_348_27.localEulerAngles = var_348_35
			end

			local var_348_36 = arg_345_1.actors_["1211ui_story"].transform
			local var_348_37 = 1

			if var_348_37 < arg_345_1.time_ and arg_345_1.time_ <= var_348_37 + arg_348_0 then
				arg_345_1.var_.moveOldPos1211ui_story = var_348_36.localPosition
			end

			local var_348_38 = 0.001

			if var_348_37 <= arg_345_1.time_ and arg_345_1.time_ < var_348_37 + var_348_38 then
				local var_348_39 = (arg_345_1.time_ - var_348_37) / var_348_38
				local var_348_40 = Vector3.New(0, 100, 0)

				var_348_36.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1211ui_story, var_348_40, var_348_39)

				local var_348_41 = manager.ui.mainCamera.transform.position - var_348_36.position

				var_348_36.forward = Vector3.New(var_348_41.x, var_348_41.y, var_348_41.z)

				local var_348_42 = var_348_36.localEulerAngles

				var_348_42.z = 0
				var_348_42.x = 0
				var_348_36.localEulerAngles = var_348_42
			end

			if arg_345_1.time_ >= var_348_37 + var_348_38 and arg_345_1.time_ < var_348_37 + var_348_38 + arg_348_0 then
				var_348_36.localPosition = Vector3.New(0, 100, 0)

				local var_348_43 = manager.ui.mainCamera.transform.position - var_348_36.position

				var_348_36.forward = Vector3.New(var_348_43.x, var_348_43.y, var_348_43.z)

				local var_348_44 = var_348_36.localEulerAngles

				var_348_44.z = 0
				var_348_44.x = 0
				var_348_36.localEulerAngles = var_348_44
			end

			local var_348_45 = arg_345_1.actors_["1111ui_story"]
			local var_348_46 = 2

			if var_348_46 < arg_345_1.time_ and arg_345_1.time_ <= var_348_46 + arg_348_0 and not isNil(var_348_45) and arg_345_1.var_.characterEffect1111ui_story == nil then
				arg_345_1.var_.characterEffect1111ui_story = var_348_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_47 = 0.200000002980232

			if var_348_46 <= arg_345_1.time_ and arg_345_1.time_ < var_348_46 + var_348_47 and not isNil(var_348_45) then
				local var_348_48 = (arg_345_1.time_ - var_348_46) / var_348_47

				if arg_345_1.var_.characterEffect1111ui_story and not isNil(var_348_45) then
					arg_345_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_46 + var_348_47 and arg_345_1.time_ < var_348_46 + var_348_47 + arg_348_0 and not isNil(var_348_45) and arg_345_1.var_.characterEffect1111ui_story then
				arg_345_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_348_49 = 2

			if var_348_49 < arg_345_1.time_ and arg_345_1.time_ <= var_348_49 + arg_348_0 then
				arg_345_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_348_50 = 2

			if var_348_50 < arg_345_1.time_ and arg_345_1.time_ <= var_348_50 + arg_348_0 then
				arg_345_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			if arg_345_1.frameCnt_ <= 1 then
				arg_345_1.dialog_:SetActive(false)
			end

			local var_348_51 = 2
			local var_348_52 = 0.05

			if var_348_51 < arg_345_1.time_ and arg_345_1.time_ <= var_348_51 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0

				arg_345_1.dialog_:SetActive(true)

				arg_345_1.dialogCg_.alpha = 0

				local var_348_53 = LeanTween.value(arg_345_1.dialog_, 0, 1, 0.3)

				var_348_53:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_345_1.dialogCg_.alpha = arg_349_0
				end))
				var_348_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_345_1.dialog_)
					var_348_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_345_1.duration_ = arg_345_1.duration_ + 0.3

				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_54 = arg_345_1:FormatText(StoryNameCfg[67].name)

				arg_345_1.leftNameTxt_.text = var_348_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_55 = arg_345_1:GetWordFromCfg(322192085)
				local var_348_56 = arg_345_1:FormatText(var_348_55.content)

				arg_345_1.text_.text = var_348_56

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_57 = 2
				local var_348_58 = utf8.len(var_348_56)
				local var_348_59 = var_348_57 <= 0 and var_348_52 or var_348_52 * (var_348_58 / var_348_57)

				if var_348_59 > 0 and var_348_52 < var_348_59 then
					arg_345_1.talkMaxDuration = var_348_59
					var_348_51 = var_348_51 + 0.3

					if var_348_59 + var_348_51 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_59 + var_348_51
					end
				end

				arg_345_1.text_.text = var_348_56
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192085", "story_v_out_322192.awb") ~= 0 then
					local var_348_60 = manager.audio:GetVoiceLength("story_v_out_322192", "322192085", "story_v_out_322192.awb") / 1000

					if var_348_60 + var_348_51 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_60 + var_348_51
					end

					if var_348_55.prefab_name ~= "" and arg_345_1.actors_[var_348_55.prefab_name] ~= nil then
						local var_348_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_55.prefab_name].transform, "story_v_out_322192", "322192085", "story_v_out_322192.awb")

						arg_345_1:RecordAudio("322192085", var_348_61)
						arg_345_1:RecordAudio("322192085", var_348_61)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_322192", "322192085", "story_v_out_322192.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_322192", "322192085", "story_v_out_322192.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_62 = var_348_51 + 0.3
			local var_348_63 = math.max(var_348_52, arg_345_1.talkMaxDuration)

			if var_348_62 <= arg_345_1.time_ and arg_345_1.time_ < var_348_62 + var_348_63 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_62) / var_348_63

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_62 + var_348_63 and arg_345_1.time_ < var_348_62 + var_348_63 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play322192086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 322192086
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play322192087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1111ui_story"].transform
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.var_.moveOldPos1111ui_story = var_354_0.localPosition
			end

			local var_354_2 = 0.001

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2
				local var_354_4 = Vector3.New(0, 100, 0)

				var_354_0.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1111ui_story, var_354_4, var_354_3)

				local var_354_5 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_5.x, var_354_5.y, var_354_5.z)

				local var_354_6 = var_354_0.localEulerAngles

				var_354_6.z = 0
				var_354_6.x = 0
				var_354_0.localEulerAngles = var_354_6
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 then
				var_354_0.localPosition = Vector3.New(0, 100, 0)

				local var_354_7 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_7.x, var_354_7.y, var_354_7.z)

				local var_354_8 = var_354_0.localEulerAngles

				var_354_8.z = 0
				var_354_8.x = 0
				var_354_0.localEulerAngles = var_354_8
			end

			local var_354_9 = 0.1
			local var_354_10 = 1

			if var_354_9 < arg_351_1.time_ and arg_351_1.time_ <= var_354_9 + arg_354_0 then
				local var_354_11 = "play"
				local var_354_12 = "effect"

				arg_351_1:AudioAction(var_354_11, var_354_12, "se_story_140", "se_story_140_footstep_run05", "")
			end

			local var_354_13 = 0
			local var_354_14 = 1.075

			if var_354_13 < arg_351_1.time_ and arg_351_1.time_ <= var_354_13 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_15 = arg_351_1:GetWordFromCfg(322192086)
				local var_354_16 = arg_351_1:FormatText(var_354_15.content)

				arg_351_1.text_.text = var_354_16

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_17 = 43
				local var_354_18 = utf8.len(var_354_16)
				local var_354_19 = var_354_17 <= 0 and var_354_14 or var_354_14 * (var_354_18 / var_354_17)

				if var_354_19 > 0 and var_354_14 < var_354_19 then
					arg_351_1.talkMaxDuration = var_354_19

					if var_354_19 + var_354_13 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_19 + var_354_13
					end
				end

				arg_351_1.text_.text = var_354_16
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_20 = math.max(var_354_14, arg_351_1.talkMaxDuration)

			if var_354_13 <= arg_351_1.time_ and arg_351_1.time_ < var_354_13 + var_354_20 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_13) / var_354_20

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_13 + var_354_20 and arg_351_1.time_ < var_354_13 + var_354_20 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play322192087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 322192087
		arg_355_1.duration_ = 2.8

		local var_355_0 = {
			zh = 1.999999999999,
			ja = 2.8
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play322192088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1111ui_story"].transform
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.var_.moveOldPos1111ui_story = var_358_0.localPosition
			end

			local var_358_2 = 0.001

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2
				local var_358_4 = Vector3.New(0, -0.87, -5.7)

				var_358_0.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1111ui_story, var_358_4, var_358_3)

				local var_358_5 = manager.ui.mainCamera.transform.position - var_358_0.position

				var_358_0.forward = Vector3.New(var_358_5.x, var_358_5.y, var_358_5.z)

				local var_358_6 = var_358_0.localEulerAngles

				var_358_6.z = 0
				var_358_6.x = 0
				var_358_0.localEulerAngles = var_358_6
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 then
				var_358_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_358_7 = manager.ui.mainCamera.transform.position - var_358_0.position

				var_358_0.forward = Vector3.New(var_358_7.x, var_358_7.y, var_358_7.z)

				local var_358_8 = var_358_0.localEulerAngles

				var_358_8.z = 0
				var_358_8.x = 0
				var_358_0.localEulerAngles = var_358_8
			end

			local var_358_9 = arg_355_1.actors_["1111ui_story"]
			local var_358_10 = 0

			if var_358_10 < arg_355_1.time_ and arg_355_1.time_ <= var_358_10 + arg_358_0 and not isNil(var_358_9) and arg_355_1.var_.characterEffect1111ui_story == nil then
				arg_355_1.var_.characterEffect1111ui_story = var_358_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_11 = 0.200000002980232

			if var_358_10 <= arg_355_1.time_ and arg_355_1.time_ < var_358_10 + var_358_11 and not isNil(var_358_9) then
				local var_358_12 = (arg_355_1.time_ - var_358_10) / var_358_11

				if arg_355_1.var_.characterEffect1111ui_story and not isNil(var_358_9) then
					arg_355_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= var_358_10 + var_358_11 and arg_355_1.time_ < var_358_10 + var_358_11 + arg_358_0 and not isNil(var_358_9) and arg_355_1.var_.characterEffect1111ui_story then
				arg_355_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_358_13 = 0

			if var_358_13 < arg_355_1.time_ and arg_355_1.time_ <= var_358_13 + arg_358_0 then
				arg_355_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_358_14 = 0

			if var_358_14 < arg_355_1.time_ and arg_355_1.time_ <= var_358_14 + arg_358_0 then
				arg_355_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_358_15 = 0
			local var_358_16 = 0.2

			if var_358_15 < arg_355_1.time_ and arg_355_1.time_ <= var_358_15 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_17 = arg_355_1:FormatText(StoryNameCfg[67].name)

				arg_355_1.leftNameTxt_.text = var_358_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_18 = arg_355_1:GetWordFromCfg(322192087)
				local var_358_19 = arg_355_1:FormatText(var_358_18.content)

				arg_355_1.text_.text = var_358_19

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_20 = 8
				local var_358_21 = utf8.len(var_358_19)
				local var_358_22 = var_358_20 <= 0 and var_358_16 or var_358_16 * (var_358_21 / var_358_20)

				if var_358_22 > 0 and var_358_16 < var_358_22 then
					arg_355_1.talkMaxDuration = var_358_22

					if var_358_22 + var_358_15 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_22 + var_358_15
					end
				end

				arg_355_1.text_.text = var_358_19
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192087", "story_v_out_322192.awb") ~= 0 then
					local var_358_23 = manager.audio:GetVoiceLength("story_v_out_322192", "322192087", "story_v_out_322192.awb") / 1000

					if var_358_23 + var_358_15 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_23 + var_358_15
					end

					if var_358_18.prefab_name ~= "" and arg_355_1.actors_[var_358_18.prefab_name] ~= nil then
						local var_358_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_18.prefab_name].transform, "story_v_out_322192", "322192087", "story_v_out_322192.awb")

						arg_355_1:RecordAudio("322192087", var_358_24)
						arg_355_1:RecordAudio("322192087", var_358_24)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_322192", "322192087", "story_v_out_322192.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_322192", "322192087", "story_v_out_322192.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_25 = math.max(var_358_16, arg_355_1.talkMaxDuration)

			if var_358_15 <= arg_355_1.time_ and arg_355_1.time_ < var_358_15 + var_358_25 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_15) / var_358_25

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_15 + var_358_25 and arg_355_1.time_ < var_358_15 + var_358_25 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play322192088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 322192088
		arg_359_1.duration_ = 2.4

		local var_359_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play322192089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1111ui_story"].transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.moveOldPos1111ui_story = var_362_0.localPosition
			end

			local var_362_2 = 0.001

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2
				local var_362_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_362_0.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1111ui_story, var_362_4, var_362_3)

				local var_362_5 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_5.x, var_362_5.y, var_362_5.z)

				local var_362_6 = var_362_0.localEulerAngles

				var_362_6.z = 0
				var_362_6.x = 0
				var_362_0.localEulerAngles = var_362_6
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 then
				var_362_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_362_7 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_7.x, var_362_7.y, var_362_7.z)

				local var_362_8 = var_362_0.localEulerAngles

				var_362_8.z = 0
				var_362_8.x = 0
				var_362_0.localEulerAngles = var_362_8
			end

			local var_362_9 = arg_359_1.actors_["1043ui_story"].transform
			local var_362_10 = 0

			if var_362_10 < arg_359_1.time_ and arg_359_1.time_ <= var_362_10 + arg_362_0 then
				arg_359_1.var_.moveOldPos1043ui_story = var_362_9.localPosition
			end

			local var_362_11 = 0.001

			if var_362_10 <= arg_359_1.time_ and arg_359_1.time_ < var_362_10 + var_362_11 then
				local var_362_12 = (arg_359_1.time_ - var_362_10) / var_362_11
				local var_362_13 = Vector3.New(0.81, -1.01, -5.73)

				var_362_9.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1043ui_story, var_362_13, var_362_12)

				local var_362_14 = manager.ui.mainCamera.transform.position - var_362_9.position

				var_362_9.forward = Vector3.New(var_362_14.x, var_362_14.y, var_362_14.z)

				local var_362_15 = var_362_9.localEulerAngles

				var_362_15.z = 0
				var_362_15.x = 0
				var_362_9.localEulerAngles = var_362_15
			end

			if arg_359_1.time_ >= var_362_10 + var_362_11 and arg_359_1.time_ < var_362_10 + var_362_11 + arg_362_0 then
				var_362_9.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_362_16 = manager.ui.mainCamera.transform.position - var_362_9.position

				var_362_9.forward = Vector3.New(var_362_16.x, var_362_16.y, var_362_16.z)

				local var_362_17 = var_362_9.localEulerAngles

				var_362_17.z = 0
				var_362_17.x = 0
				var_362_9.localEulerAngles = var_362_17
			end

			local var_362_18 = arg_359_1.actors_["1043ui_story"]
			local var_362_19 = 0

			if var_362_19 < arg_359_1.time_ and arg_359_1.time_ <= var_362_19 + arg_362_0 and not isNil(var_362_18) and arg_359_1.var_.characterEffect1043ui_story == nil then
				arg_359_1.var_.characterEffect1043ui_story = var_362_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_20 = 0.200000002980232

			if var_362_19 <= arg_359_1.time_ and arg_359_1.time_ < var_362_19 + var_362_20 and not isNil(var_362_18) then
				local var_362_21 = (arg_359_1.time_ - var_362_19) / var_362_20

				if arg_359_1.var_.characterEffect1043ui_story and not isNil(var_362_18) then
					arg_359_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= var_362_19 + var_362_20 and arg_359_1.time_ < var_362_19 + var_362_20 + arg_362_0 and not isNil(var_362_18) and arg_359_1.var_.characterEffect1043ui_story then
				arg_359_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_362_22 = arg_359_1.actors_["1111ui_story"]
			local var_362_23 = 0

			if var_362_23 < arg_359_1.time_ and arg_359_1.time_ <= var_362_23 + arg_362_0 and not isNil(var_362_22) and arg_359_1.var_.characterEffect1111ui_story == nil then
				arg_359_1.var_.characterEffect1111ui_story = var_362_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_24 = 0.200000002980232

			if var_362_23 <= arg_359_1.time_ and arg_359_1.time_ < var_362_23 + var_362_24 and not isNil(var_362_22) then
				local var_362_25 = (arg_359_1.time_ - var_362_23) / var_362_24

				if arg_359_1.var_.characterEffect1111ui_story and not isNil(var_362_22) then
					local var_362_26 = Mathf.Lerp(0, 0.5, var_362_25)

					arg_359_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1111ui_story.fillRatio = var_362_26
				end
			end

			if arg_359_1.time_ >= var_362_23 + var_362_24 and arg_359_1.time_ < var_362_23 + var_362_24 + arg_362_0 and not isNil(var_362_22) and arg_359_1.var_.characterEffect1111ui_story then
				local var_362_27 = 0.5

				arg_359_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1111ui_story.fillRatio = var_362_27
			end

			local var_362_28 = 0

			if var_362_28 < arg_359_1.time_ and arg_359_1.time_ <= var_362_28 + arg_362_0 then
				arg_359_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_362_29 = 0
			local var_362_30 = 0.175

			if var_362_29 < arg_359_1.time_ and arg_359_1.time_ <= var_362_29 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_31 = arg_359_1:FormatText(StoryNameCfg[1156].name)

				arg_359_1.leftNameTxt_.text = var_362_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_32 = arg_359_1:GetWordFromCfg(322192088)
				local var_362_33 = arg_359_1:FormatText(var_362_32.content)

				arg_359_1.text_.text = var_362_33

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_34 = 7
				local var_362_35 = utf8.len(var_362_33)
				local var_362_36 = var_362_34 <= 0 and var_362_30 or var_362_30 * (var_362_35 / var_362_34)

				if var_362_36 > 0 and var_362_30 < var_362_36 then
					arg_359_1.talkMaxDuration = var_362_36

					if var_362_36 + var_362_29 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_36 + var_362_29
					end
				end

				arg_359_1.text_.text = var_362_33
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192088", "story_v_out_322192.awb") ~= 0 then
					local var_362_37 = manager.audio:GetVoiceLength("story_v_out_322192", "322192088", "story_v_out_322192.awb") / 1000

					if var_362_37 + var_362_29 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_37 + var_362_29
					end

					if var_362_32.prefab_name ~= "" and arg_359_1.actors_[var_362_32.prefab_name] ~= nil then
						local var_362_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_32.prefab_name].transform, "story_v_out_322192", "322192088", "story_v_out_322192.awb")

						arg_359_1:RecordAudio("322192088", var_362_38)
						arg_359_1:RecordAudio("322192088", var_362_38)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_322192", "322192088", "story_v_out_322192.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_322192", "322192088", "story_v_out_322192.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_39 = math.max(var_362_30, arg_359_1.talkMaxDuration)

			if var_362_29 <= arg_359_1.time_ and arg_359_1.time_ < var_362_29 + var_362_39 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_29) / var_362_39

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_29 + var_362_39 and arg_359_1.time_ < var_362_29 + var_362_39 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play322192089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 322192089
		arg_363_1.duration_ = 3.57

		local var_363_0 = {
			zh = 2.7,
			ja = 3.566
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play322192090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1111ui_story"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1111ui_story == nil then
				arg_363_1.var_.characterEffect1111ui_story = var_366_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.200000002980232

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.characterEffect1111ui_story and not isNil(var_366_0) then
					arg_363_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1111ui_story then
				arg_363_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_366_4 = arg_363_1.actors_["1043ui_story"]
			local var_366_5 = 0

			if var_366_5 < arg_363_1.time_ and arg_363_1.time_ <= var_366_5 + arg_366_0 and not isNil(var_366_4) and arg_363_1.var_.characterEffect1043ui_story == nil then
				arg_363_1.var_.characterEffect1043ui_story = var_366_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_6 = 0.200000002980232

			if var_366_5 <= arg_363_1.time_ and arg_363_1.time_ < var_366_5 + var_366_6 and not isNil(var_366_4) then
				local var_366_7 = (arg_363_1.time_ - var_366_5) / var_366_6

				if arg_363_1.var_.characterEffect1043ui_story and not isNil(var_366_4) then
					local var_366_8 = Mathf.Lerp(0, 0.5, var_366_7)

					arg_363_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1043ui_story.fillRatio = var_366_8
				end
			end

			if arg_363_1.time_ >= var_366_5 + var_366_6 and arg_363_1.time_ < var_366_5 + var_366_6 + arg_366_0 and not isNil(var_366_4) and arg_363_1.var_.characterEffect1043ui_story then
				local var_366_9 = 0.5

				arg_363_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1043ui_story.fillRatio = var_366_9
			end

			local var_366_10 = 0

			if var_366_10 < arg_363_1.time_ and arg_363_1.time_ <= var_366_10 + arg_366_0 then
				arg_363_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_366_11 = 0
			local var_366_12 = 0.275

			if var_366_11 < arg_363_1.time_ and arg_363_1.time_ <= var_366_11 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_13 = arg_363_1:FormatText(StoryNameCfg[67].name)

				arg_363_1.leftNameTxt_.text = var_366_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_14 = arg_363_1:GetWordFromCfg(322192089)
				local var_366_15 = arg_363_1:FormatText(var_366_14.content)

				arg_363_1.text_.text = var_366_15

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_16 = 11
				local var_366_17 = utf8.len(var_366_15)
				local var_366_18 = var_366_16 <= 0 and var_366_12 or var_366_12 * (var_366_17 / var_366_16)

				if var_366_18 > 0 and var_366_12 < var_366_18 then
					arg_363_1.talkMaxDuration = var_366_18

					if var_366_18 + var_366_11 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_18 + var_366_11
					end
				end

				arg_363_1.text_.text = var_366_15
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192089", "story_v_out_322192.awb") ~= 0 then
					local var_366_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192089", "story_v_out_322192.awb") / 1000

					if var_366_19 + var_366_11 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_19 + var_366_11
					end

					if var_366_14.prefab_name ~= "" and arg_363_1.actors_[var_366_14.prefab_name] ~= nil then
						local var_366_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_14.prefab_name].transform, "story_v_out_322192", "322192089", "story_v_out_322192.awb")

						arg_363_1:RecordAudio("322192089", var_366_20)
						arg_363_1:RecordAudio("322192089", var_366_20)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_322192", "322192089", "story_v_out_322192.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_322192", "322192089", "story_v_out_322192.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_21 = math.max(var_366_12, arg_363_1.talkMaxDuration)

			if var_366_11 <= arg_363_1.time_ and arg_363_1.time_ < var_366_11 + var_366_21 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_11) / var_366_21

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_11 + var_366_21 and arg_363_1.time_ < var_366_11 + var_366_21 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play322192090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 322192090
		arg_367_1.duration_ = 3.7

		local var_367_0 = {
			zh = 3.3,
			ja = 3.7
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play322192091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1043ui_story"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1043ui_story == nil then
				arg_367_1.var_.characterEffect1043ui_story = var_370_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.characterEffect1043ui_story and not isNil(var_370_0) then
					arg_367_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1043ui_story then
				arg_367_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_370_4 = arg_367_1.actors_["1111ui_story"]
			local var_370_5 = 0

			if var_370_5 < arg_367_1.time_ and arg_367_1.time_ <= var_370_5 + arg_370_0 and not isNil(var_370_4) and arg_367_1.var_.characterEffect1111ui_story == nil then
				arg_367_1.var_.characterEffect1111ui_story = var_370_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_6 = 0.200000002980232

			if var_370_5 <= arg_367_1.time_ and arg_367_1.time_ < var_370_5 + var_370_6 and not isNil(var_370_4) then
				local var_370_7 = (arg_367_1.time_ - var_370_5) / var_370_6

				if arg_367_1.var_.characterEffect1111ui_story and not isNil(var_370_4) then
					local var_370_8 = Mathf.Lerp(0, 0.5, var_370_7)

					arg_367_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1111ui_story.fillRatio = var_370_8
				end
			end

			if arg_367_1.time_ >= var_370_5 + var_370_6 and arg_367_1.time_ < var_370_5 + var_370_6 + arg_370_0 and not isNil(var_370_4) and arg_367_1.var_.characterEffect1111ui_story then
				local var_370_9 = 0.5

				arg_367_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1111ui_story.fillRatio = var_370_9
			end

			local var_370_10 = 0
			local var_370_11 = 0.35

			if var_370_10 < arg_367_1.time_ and arg_367_1.time_ <= var_370_10 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_12 = arg_367_1:FormatText(StoryNameCfg[1156].name)

				arg_367_1.leftNameTxt_.text = var_370_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_13 = arg_367_1:GetWordFromCfg(322192090)
				local var_370_14 = arg_367_1:FormatText(var_370_13.content)

				arg_367_1.text_.text = var_370_14

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_15 = 14
				local var_370_16 = utf8.len(var_370_14)
				local var_370_17 = var_370_15 <= 0 and var_370_11 or var_370_11 * (var_370_16 / var_370_15)

				if var_370_17 > 0 and var_370_11 < var_370_17 then
					arg_367_1.talkMaxDuration = var_370_17

					if var_370_17 + var_370_10 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_17 + var_370_10
					end
				end

				arg_367_1.text_.text = var_370_14
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192090", "story_v_out_322192.awb") ~= 0 then
					local var_370_18 = manager.audio:GetVoiceLength("story_v_out_322192", "322192090", "story_v_out_322192.awb") / 1000

					if var_370_18 + var_370_10 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_18 + var_370_10
					end

					if var_370_13.prefab_name ~= "" and arg_367_1.actors_[var_370_13.prefab_name] ~= nil then
						local var_370_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_13.prefab_name].transform, "story_v_out_322192", "322192090", "story_v_out_322192.awb")

						arg_367_1:RecordAudio("322192090", var_370_19)
						arg_367_1:RecordAudio("322192090", var_370_19)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_322192", "322192090", "story_v_out_322192.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_322192", "322192090", "story_v_out_322192.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_20 = math.max(var_370_11, arg_367_1.talkMaxDuration)

			if var_370_10 <= arg_367_1.time_ and arg_367_1.time_ < var_370_10 + var_370_20 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_10) / var_370_20

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_10 + var_370_20 and arg_367_1.time_ < var_370_10 + var_370_20 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play322192091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 322192091
		arg_371_1.duration_ = 1.9

		local var_371_0 = {
			zh = 1.766,
			ja = 1.9
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play322192092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1111ui_story"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1111ui_story == nil then
				arg_371_1.var_.characterEffect1111ui_story = var_374_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.characterEffect1111ui_story and not isNil(var_374_0) then
					arg_371_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1111ui_story then
				arg_371_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_374_4 = arg_371_1.actors_["1043ui_story"]
			local var_374_5 = 0

			if var_374_5 < arg_371_1.time_ and arg_371_1.time_ <= var_374_5 + arg_374_0 and not isNil(var_374_4) and arg_371_1.var_.characterEffect1043ui_story == nil then
				arg_371_1.var_.characterEffect1043ui_story = var_374_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_6 = 0.200000002980232

			if var_374_5 <= arg_371_1.time_ and arg_371_1.time_ < var_374_5 + var_374_6 and not isNil(var_374_4) then
				local var_374_7 = (arg_371_1.time_ - var_374_5) / var_374_6

				if arg_371_1.var_.characterEffect1043ui_story and not isNil(var_374_4) then
					local var_374_8 = Mathf.Lerp(0, 0.5, var_374_7)

					arg_371_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1043ui_story.fillRatio = var_374_8
				end
			end

			if arg_371_1.time_ >= var_374_5 + var_374_6 and arg_371_1.time_ < var_374_5 + var_374_6 + arg_374_0 and not isNil(var_374_4) and arg_371_1.var_.characterEffect1043ui_story then
				local var_374_9 = 0.5

				arg_371_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1043ui_story.fillRatio = var_374_9
			end

			local var_374_10 = 0
			local var_374_11 = 0.1

			if var_374_10 < arg_371_1.time_ and arg_371_1.time_ <= var_374_10 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_12 = arg_371_1:FormatText(StoryNameCfg[67].name)

				arg_371_1.leftNameTxt_.text = var_374_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_13 = arg_371_1:GetWordFromCfg(322192091)
				local var_374_14 = arg_371_1:FormatText(var_374_13.content)

				arg_371_1.text_.text = var_374_14

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_15 = 4
				local var_374_16 = utf8.len(var_374_14)
				local var_374_17 = var_374_15 <= 0 and var_374_11 or var_374_11 * (var_374_16 / var_374_15)

				if var_374_17 > 0 and var_374_11 < var_374_17 then
					arg_371_1.talkMaxDuration = var_374_17

					if var_374_17 + var_374_10 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_17 + var_374_10
					end
				end

				arg_371_1.text_.text = var_374_14
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192091", "story_v_out_322192.awb") ~= 0 then
					local var_374_18 = manager.audio:GetVoiceLength("story_v_out_322192", "322192091", "story_v_out_322192.awb") / 1000

					if var_374_18 + var_374_10 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_18 + var_374_10
					end

					if var_374_13.prefab_name ~= "" and arg_371_1.actors_[var_374_13.prefab_name] ~= nil then
						local var_374_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_13.prefab_name].transform, "story_v_out_322192", "322192091", "story_v_out_322192.awb")

						arg_371_1:RecordAudio("322192091", var_374_19)
						arg_371_1:RecordAudio("322192091", var_374_19)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_322192", "322192091", "story_v_out_322192.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_322192", "322192091", "story_v_out_322192.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_20 = math.max(var_374_11, arg_371_1.talkMaxDuration)

			if var_374_10 <= arg_371_1.time_ and arg_371_1.time_ < var_374_10 + var_374_20 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_10) / var_374_20

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_10 + var_374_20 and arg_371_1.time_ < var_374_10 + var_374_20 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play322192092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 322192092
		arg_375_1.duration_ = 7

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play322192093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 1

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				local var_378_1 = manager.ui.mainCamera.transform.localPosition
				local var_378_2 = Vector3.New(0, 0, 10) + Vector3.New(var_378_1.x, var_378_1.y, 0)
				local var_378_3 = arg_375_1.bgs_.L09f

				var_378_3.transform.localPosition = var_378_2
				var_378_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_378_4 = var_378_3:GetComponent("SpriteRenderer")

				if var_378_4 and var_378_4.sprite then
					local var_378_5 = (var_378_3.transform.localPosition - var_378_1).z
					local var_378_6 = manager.ui.mainCameraCom_
					local var_378_7 = 2 * var_378_5 * Mathf.Tan(var_378_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_378_8 = var_378_7 * var_378_6.aspect
					local var_378_9 = var_378_4.sprite.bounds.size.x
					local var_378_10 = var_378_4.sprite.bounds.size.y
					local var_378_11 = var_378_8 / var_378_9
					local var_378_12 = var_378_7 / var_378_10
					local var_378_13 = var_378_12 < var_378_11 and var_378_11 or var_378_12

					var_378_3.transform.localScale = Vector3.New(var_378_13, var_378_13, 0)
				end

				for iter_378_0, iter_378_1 in pairs(arg_375_1.bgs_) do
					if iter_378_0 ~= "L09f" then
						iter_378_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_378_14 = 2

			if var_378_14 < arg_375_1.time_ and arg_375_1.time_ <= var_378_14 + arg_378_0 then
				arg_375_1.allBtn_.enabled = false
			end

			local var_378_15 = 0.3

			if arg_375_1.time_ >= var_378_14 + var_378_15 and arg_375_1.time_ < var_378_14 + var_378_15 + arg_378_0 then
				arg_375_1.allBtn_.enabled = true
			end

			local var_378_16 = 0

			if var_378_16 < arg_375_1.time_ and arg_375_1.time_ <= var_378_16 + arg_378_0 then
				arg_375_1.mask_.enabled = true
				arg_375_1.mask_.raycastTarget = true

				arg_375_1:SetGaussion(false)
			end

			local var_378_17 = 1

			if var_378_16 <= arg_375_1.time_ and arg_375_1.time_ < var_378_16 + var_378_17 then
				local var_378_18 = (arg_375_1.time_ - var_378_16) / var_378_17
				local var_378_19 = Color.New(0, 0, 0)

				var_378_19.a = Mathf.Lerp(0, 1, var_378_18)
				arg_375_1.mask_.color = var_378_19
			end

			if arg_375_1.time_ >= var_378_16 + var_378_17 and arg_375_1.time_ < var_378_16 + var_378_17 + arg_378_0 then
				local var_378_20 = Color.New(0, 0, 0)

				var_378_20.a = 1
				arg_375_1.mask_.color = var_378_20
			end

			local var_378_21 = 1

			if var_378_21 < arg_375_1.time_ and arg_375_1.time_ <= var_378_21 + arg_378_0 then
				arg_375_1.mask_.enabled = true
				arg_375_1.mask_.raycastTarget = true

				arg_375_1:SetGaussion(false)
			end

			local var_378_22 = 1

			if var_378_21 <= arg_375_1.time_ and arg_375_1.time_ < var_378_21 + var_378_22 then
				local var_378_23 = (arg_375_1.time_ - var_378_21) / var_378_22
				local var_378_24 = Color.New(0, 0, 0)

				var_378_24.a = Mathf.Lerp(1, 0, var_378_23)
				arg_375_1.mask_.color = var_378_24
			end

			if arg_375_1.time_ >= var_378_21 + var_378_22 and arg_375_1.time_ < var_378_21 + var_378_22 + arg_378_0 then
				local var_378_25 = Color.New(0, 0, 0)
				local var_378_26 = 0

				arg_375_1.mask_.enabled = false
				var_378_25.a = var_378_26
				arg_375_1.mask_.color = var_378_25
			end

			local var_378_27 = arg_375_1.actors_["1111ui_story"].transform
			local var_378_28 = 1

			if var_378_28 < arg_375_1.time_ and arg_375_1.time_ <= var_378_28 + arg_378_0 then
				arg_375_1.var_.moveOldPos1111ui_story = var_378_27.localPosition
			end

			local var_378_29 = 0.001

			if var_378_28 <= arg_375_1.time_ and arg_375_1.time_ < var_378_28 + var_378_29 then
				local var_378_30 = (arg_375_1.time_ - var_378_28) / var_378_29
				local var_378_31 = Vector3.New(0, 100, 0)

				var_378_27.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1111ui_story, var_378_31, var_378_30)

				local var_378_32 = manager.ui.mainCamera.transform.position - var_378_27.position

				var_378_27.forward = Vector3.New(var_378_32.x, var_378_32.y, var_378_32.z)

				local var_378_33 = var_378_27.localEulerAngles

				var_378_33.z = 0
				var_378_33.x = 0
				var_378_27.localEulerAngles = var_378_33
			end

			if arg_375_1.time_ >= var_378_28 + var_378_29 and arg_375_1.time_ < var_378_28 + var_378_29 + arg_378_0 then
				var_378_27.localPosition = Vector3.New(0, 100, 0)

				local var_378_34 = manager.ui.mainCamera.transform.position - var_378_27.position

				var_378_27.forward = Vector3.New(var_378_34.x, var_378_34.y, var_378_34.z)

				local var_378_35 = var_378_27.localEulerAngles

				var_378_35.z = 0
				var_378_35.x = 0
				var_378_27.localEulerAngles = var_378_35
			end

			local var_378_36 = arg_375_1.actors_["1043ui_story"].transform
			local var_378_37 = 1

			if var_378_37 < arg_375_1.time_ and arg_375_1.time_ <= var_378_37 + arg_378_0 then
				arg_375_1.var_.moveOldPos1043ui_story = var_378_36.localPosition
			end

			local var_378_38 = 0.001

			if var_378_37 <= arg_375_1.time_ and arg_375_1.time_ < var_378_37 + var_378_38 then
				local var_378_39 = (arg_375_1.time_ - var_378_37) / var_378_38
				local var_378_40 = Vector3.New(0, 100, 0)

				var_378_36.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1043ui_story, var_378_40, var_378_39)

				local var_378_41 = manager.ui.mainCamera.transform.position - var_378_36.position

				var_378_36.forward = Vector3.New(var_378_41.x, var_378_41.y, var_378_41.z)

				local var_378_42 = var_378_36.localEulerAngles

				var_378_42.z = 0
				var_378_42.x = 0
				var_378_36.localEulerAngles = var_378_42
			end

			if arg_375_1.time_ >= var_378_37 + var_378_38 and arg_375_1.time_ < var_378_37 + var_378_38 + arg_378_0 then
				var_378_36.localPosition = Vector3.New(0, 100, 0)

				local var_378_43 = manager.ui.mainCamera.transform.position - var_378_36.position

				var_378_36.forward = Vector3.New(var_378_43.x, var_378_43.y, var_378_43.z)

				local var_378_44 = var_378_36.localEulerAngles

				var_378_44.z = 0
				var_378_44.x = 0
				var_378_36.localEulerAngles = var_378_44
			end

			local var_378_45 = 2
			local var_378_46 = 1

			if var_378_45 < arg_375_1.time_ and arg_375_1.time_ <= var_378_45 + arg_378_0 then
				local var_378_47 = "play"
				local var_378_48 = "effect"

				arg_375_1:AudioAction(var_378_47, var_378_48, "se_story_1311", "se_story_1311_clothhit", "")
			end

			local var_378_49 = 0.6
			local var_378_50 = 1

			if var_378_49 < arg_375_1.time_ and arg_375_1.time_ <= var_378_49 + arg_378_0 then
				local var_378_51 = "play"
				local var_378_52 = "music"

				arg_375_1:AudioAction(var_378_51, var_378_52, "bgm_activity_4_5_story_source", "battle", "bgm_activity_4_5_story_source.awb")

				local var_378_53 = ""
				local var_378_54 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "battle")

				if var_378_54 ~= "" then
					if arg_375_1.bgmTxt_.text ~= var_378_54 and arg_375_1.bgmTxt_.text ~= "" then
						if arg_375_1.bgmTxt2_.text ~= "" then
							arg_375_1.bgmTxt_.text = arg_375_1.bgmTxt2_.text
						end

						arg_375_1.bgmTxt2_.text = var_378_54

						arg_375_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_375_1.bgmTxt_.text = var_378_54
						arg_375_1.bgmTxt2_.text = var_378_54
					end

					if arg_375_1.bgmTimer then
						arg_375_1.bgmTimer:Stop()

						arg_375_1.bgmTimer = nil
					end

					if arg_375_1.settingData.show_music_name == 1 then
						arg_375_1.musicController:SetSelectedState("show")
						arg_375_1.musicAnimator_:Play("open", 0, 0)

						if arg_375_1.settingData.music_time ~= 0 then
							arg_375_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_375_1.settingData.music_time), function()
								if arg_375_1 == nil or isNil(arg_375_1.bgmTxt_) then
									return
								end

								arg_375_1.musicController:SetSelectedState("hide")
								arg_375_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_375_1.frameCnt_ <= 1 then
				arg_375_1.dialog_:SetActive(false)
			end

			local var_378_55 = 2
			local var_378_56 = 0.525

			if var_378_55 < arg_375_1.time_ and arg_375_1.time_ <= var_378_55 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0

				arg_375_1.dialog_:SetActive(true)

				arg_375_1.dialogCg_.alpha = 0

				local var_378_57 = LeanTween.value(arg_375_1.dialog_, 0, 1, 0.3)

				var_378_57:setOnUpdate(LuaHelper.FloatAction(function(arg_380_0)
					arg_375_1.dialogCg_.alpha = arg_380_0
				end))
				var_378_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_375_1.dialog_)
					var_378_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_375_1.duration_ = arg_375_1.duration_ + 0.3

				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_58 = arg_375_1:GetWordFromCfg(322192092)
				local var_378_59 = arg_375_1:FormatText(var_378_58.content)

				arg_375_1.text_.text = var_378_59

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_60 = 21
				local var_378_61 = utf8.len(var_378_59)
				local var_378_62 = var_378_60 <= 0 and var_378_56 or var_378_56 * (var_378_61 / var_378_60)

				if var_378_62 > 0 and var_378_56 < var_378_62 then
					arg_375_1.talkMaxDuration = var_378_62
					var_378_55 = var_378_55 + 0.3

					if var_378_62 + var_378_55 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_62 + var_378_55
					end
				end

				arg_375_1.text_.text = var_378_59
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_63 = var_378_55 + 0.3
			local var_378_64 = math.max(var_378_56, arg_375_1.talkMaxDuration)

			if var_378_63 <= arg_375_1.time_ and arg_375_1.time_ < var_378_63 + var_378_64 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_63) / var_378_64

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_63 + var_378_64 and arg_375_1.time_ < var_378_63 + var_378_64 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play322192093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 322192093
		arg_382_1.duration_ = 7.57

		local var_382_0 = {
			zh = 6.033,
			ja = 7.566
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play322192094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["1111ui_story"].transform
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.var_.moveOldPos1111ui_story = var_385_0.localPosition
			end

			local var_385_2 = 0.001

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2
				local var_385_4 = Vector3.New(0, -0.87, -5.7)

				var_385_0.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1111ui_story, var_385_4, var_385_3)

				local var_385_5 = manager.ui.mainCamera.transform.position - var_385_0.position

				var_385_0.forward = Vector3.New(var_385_5.x, var_385_5.y, var_385_5.z)

				local var_385_6 = var_385_0.localEulerAngles

				var_385_6.z = 0
				var_385_6.x = 0
				var_385_0.localEulerAngles = var_385_6
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 then
				var_385_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_385_7 = manager.ui.mainCamera.transform.position - var_385_0.position

				var_385_0.forward = Vector3.New(var_385_7.x, var_385_7.y, var_385_7.z)

				local var_385_8 = var_385_0.localEulerAngles

				var_385_8.z = 0
				var_385_8.x = 0
				var_385_0.localEulerAngles = var_385_8
			end

			local var_385_9 = arg_382_1.actors_["1111ui_story"]
			local var_385_10 = 0

			if var_385_10 < arg_382_1.time_ and arg_382_1.time_ <= var_385_10 + arg_385_0 and not isNil(var_385_9) and arg_382_1.var_.characterEffect1111ui_story == nil then
				arg_382_1.var_.characterEffect1111ui_story = var_385_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_11 = 0.200000002980232

			if var_385_10 <= arg_382_1.time_ and arg_382_1.time_ < var_385_10 + var_385_11 and not isNil(var_385_9) then
				local var_385_12 = (arg_382_1.time_ - var_385_10) / var_385_11

				if arg_382_1.var_.characterEffect1111ui_story and not isNil(var_385_9) then
					arg_382_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= var_385_10 + var_385_11 and arg_382_1.time_ < var_385_10 + var_385_11 + arg_385_0 and not isNil(var_385_9) and arg_382_1.var_.characterEffect1111ui_story then
				arg_382_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_385_13 = 0

			if var_385_13 < arg_382_1.time_ and arg_382_1.time_ <= var_385_13 + arg_385_0 then
				arg_382_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_385_14 = 0

			if var_385_14 < arg_382_1.time_ and arg_382_1.time_ <= var_385_14 + arg_385_0 then
				arg_382_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_385_15 = 0
			local var_385_16 = 0.6

			if var_385_15 < arg_382_1.time_ and arg_382_1.time_ <= var_385_15 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_17 = arg_382_1:FormatText(StoryNameCfg[67].name)

				arg_382_1.leftNameTxt_.text = var_385_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_18 = arg_382_1:GetWordFromCfg(322192093)
				local var_385_19 = arg_382_1:FormatText(var_385_18.content)

				arg_382_1.text_.text = var_385_19

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_20 = 24
				local var_385_21 = utf8.len(var_385_19)
				local var_385_22 = var_385_20 <= 0 and var_385_16 or var_385_16 * (var_385_21 / var_385_20)

				if var_385_22 > 0 and var_385_16 < var_385_22 then
					arg_382_1.talkMaxDuration = var_385_22

					if var_385_22 + var_385_15 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_22 + var_385_15
					end
				end

				arg_382_1.text_.text = var_385_19
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192093", "story_v_out_322192.awb") ~= 0 then
					local var_385_23 = manager.audio:GetVoiceLength("story_v_out_322192", "322192093", "story_v_out_322192.awb") / 1000

					if var_385_23 + var_385_15 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_23 + var_385_15
					end

					if var_385_18.prefab_name ~= "" and arg_382_1.actors_[var_385_18.prefab_name] ~= nil then
						local var_385_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_18.prefab_name].transform, "story_v_out_322192", "322192093", "story_v_out_322192.awb")

						arg_382_1:RecordAudio("322192093", var_385_24)
						arg_382_1:RecordAudio("322192093", var_385_24)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_322192", "322192093", "story_v_out_322192.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_322192", "322192093", "story_v_out_322192.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_25 = math.max(var_385_16, arg_382_1.talkMaxDuration)

			if var_385_15 <= arg_382_1.time_ and arg_382_1.time_ < var_385_15 + var_385_25 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_15) / var_385_25

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_15 + var_385_25 and arg_382_1.time_ < var_385_15 + var_385_25 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play322192094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 322192094
		arg_386_1.duration_ = 10.07

		local var_386_0 = {
			zh = 10.066,
			ja = 9.2
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play322192095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_389_2 = 0
			local var_389_3 = 1.15

			if var_389_2 < arg_386_1.time_ and arg_386_1.time_ <= var_389_2 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_4 = arg_386_1:FormatText(StoryNameCfg[67].name)

				arg_386_1.leftNameTxt_.text = var_389_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_5 = arg_386_1:GetWordFromCfg(322192094)
				local var_389_6 = arg_386_1:FormatText(var_389_5.content)

				arg_386_1.text_.text = var_389_6

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_7 = 46
				local var_389_8 = utf8.len(var_389_6)
				local var_389_9 = var_389_7 <= 0 and var_389_3 or var_389_3 * (var_389_8 / var_389_7)

				if var_389_9 > 0 and var_389_3 < var_389_9 then
					arg_386_1.talkMaxDuration = var_389_9

					if var_389_9 + var_389_2 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_9 + var_389_2
					end
				end

				arg_386_1.text_.text = var_389_6
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192094", "story_v_out_322192.awb") ~= 0 then
					local var_389_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192094", "story_v_out_322192.awb") / 1000

					if var_389_10 + var_389_2 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_10 + var_389_2
					end

					if var_389_5.prefab_name ~= "" and arg_386_1.actors_[var_389_5.prefab_name] ~= nil then
						local var_389_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_5.prefab_name].transform, "story_v_out_322192", "322192094", "story_v_out_322192.awb")

						arg_386_1:RecordAudio("322192094", var_389_11)
						arg_386_1:RecordAudio("322192094", var_389_11)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_322192", "322192094", "story_v_out_322192.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_322192", "322192094", "story_v_out_322192.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_12 = math.max(var_389_3, arg_386_1.talkMaxDuration)

			if var_389_2 <= arg_386_1.time_ and arg_386_1.time_ < var_389_2 + var_389_12 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_2) / var_389_12

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_2 + var_389_12 and arg_386_1.time_ < var_389_2 + var_389_12 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play322192095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 322192095
		arg_390_1.duration_ = 3.7

		local var_390_0 = {
			zh = 2.366,
			ja = 3.7
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play322192096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["1111ui_story"].transform
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.var_.moveOldPos1111ui_story = var_393_0.localPosition
			end

			local var_393_2 = 0.001

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2
				local var_393_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_393_0.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1111ui_story, var_393_4, var_393_3)

				local var_393_5 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_5.x, var_393_5.y, var_393_5.z)

				local var_393_6 = var_393_0.localEulerAngles

				var_393_6.z = 0
				var_393_6.x = 0
				var_393_0.localEulerAngles = var_393_6
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 then
				var_393_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_393_7 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_7.x, var_393_7.y, var_393_7.z)

				local var_393_8 = var_393_0.localEulerAngles

				var_393_8.z = 0
				var_393_8.x = 0
				var_393_0.localEulerAngles = var_393_8
			end

			local var_393_9 = arg_390_1.actors_["1043ui_story"].transform
			local var_393_10 = 0

			if var_393_10 < arg_390_1.time_ and arg_390_1.time_ <= var_393_10 + arg_393_0 then
				arg_390_1.var_.moveOldPos1043ui_story = var_393_9.localPosition
			end

			local var_393_11 = 0.001

			if var_393_10 <= arg_390_1.time_ and arg_390_1.time_ < var_393_10 + var_393_11 then
				local var_393_12 = (arg_390_1.time_ - var_393_10) / var_393_11
				local var_393_13 = Vector3.New(0.81, -1.01, -5.73)

				var_393_9.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1043ui_story, var_393_13, var_393_12)

				local var_393_14 = manager.ui.mainCamera.transform.position - var_393_9.position

				var_393_9.forward = Vector3.New(var_393_14.x, var_393_14.y, var_393_14.z)

				local var_393_15 = var_393_9.localEulerAngles

				var_393_15.z = 0
				var_393_15.x = 0
				var_393_9.localEulerAngles = var_393_15
			end

			if arg_390_1.time_ >= var_393_10 + var_393_11 and arg_390_1.time_ < var_393_10 + var_393_11 + arg_393_0 then
				var_393_9.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_393_16 = manager.ui.mainCamera.transform.position - var_393_9.position

				var_393_9.forward = Vector3.New(var_393_16.x, var_393_16.y, var_393_16.z)

				local var_393_17 = var_393_9.localEulerAngles

				var_393_17.z = 0
				var_393_17.x = 0
				var_393_9.localEulerAngles = var_393_17
			end

			local var_393_18 = arg_390_1.actors_["1043ui_story"]
			local var_393_19 = 0

			if var_393_19 < arg_390_1.time_ and arg_390_1.time_ <= var_393_19 + arg_393_0 and not isNil(var_393_18) and arg_390_1.var_.characterEffect1043ui_story == nil then
				arg_390_1.var_.characterEffect1043ui_story = var_393_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_20 = 0.200000002980232

			if var_393_19 <= arg_390_1.time_ and arg_390_1.time_ < var_393_19 + var_393_20 and not isNil(var_393_18) then
				local var_393_21 = (arg_390_1.time_ - var_393_19) / var_393_20

				if arg_390_1.var_.characterEffect1043ui_story and not isNil(var_393_18) then
					arg_390_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= var_393_19 + var_393_20 and arg_390_1.time_ < var_393_19 + var_393_20 + arg_393_0 and not isNil(var_393_18) and arg_390_1.var_.characterEffect1043ui_story then
				arg_390_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_393_22 = arg_390_1.actors_["1111ui_story"]
			local var_393_23 = 0

			if var_393_23 < arg_390_1.time_ and arg_390_1.time_ <= var_393_23 + arg_393_0 and not isNil(var_393_22) and arg_390_1.var_.characterEffect1111ui_story == nil then
				arg_390_1.var_.characterEffect1111ui_story = var_393_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_24 = 0.200000002980232

			if var_393_23 <= arg_390_1.time_ and arg_390_1.time_ < var_393_23 + var_393_24 and not isNil(var_393_22) then
				local var_393_25 = (arg_390_1.time_ - var_393_23) / var_393_24

				if arg_390_1.var_.characterEffect1111ui_story and not isNil(var_393_22) then
					local var_393_26 = Mathf.Lerp(0, 0.5, var_393_25)

					arg_390_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_390_1.var_.characterEffect1111ui_story.fillRatio = var_393_26
				end
			end

			if arg_390_1.time_ >= var_393_23 + var_393_24 and arg_390_1.time_ < var_393_23 + var_393_24 + arg_393_0 and not isNil(var_393_22) and arg_390_1.var_.characterEffect1111ui_story then
				local var_393_27 = 0.5

				arg_390_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_390_1.var_.characterEffect1111ui_story.fillRatio = var_393_27
			end

			local var_393_28 = 0

			if var_393_28 < arg_390_1.time_ and arg_390_1.time_ <= var_393_28 + arg_393_0 then
				arg_390_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_1")
			end

			local var_393_29 = 0
			local var_393_30 = 0.3

			if var_393_29 < arg_390_1.time_ and arg_390_1.time_ <= var_393_29 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_31 = arg_390_1:FormatText(StoryNameCfg[1156].name)

				arg_390_1.leftNameTxt_.text = var_393_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_32 = arg_390_1:GetWordFromCfg(322192095)
				local var_393_33 = arg_390_1:FormatText(var_393_32.content)

				arg_390_1.text_.text = var_393_33

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_34 = 12
				local var_393_35 = utf8.len(var_393_33)
				local var_393_36 = var_393_34 <= 0 and var_393_30 or var_393_30 * (var_393_35 / var_393_34)

				if var_393_36 > 0 and var_393_30 < var_393_36 then
					arg_390_1.talkMaxDuration = var_393_36

					if var_393_36 + var_393_29 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_36 + var_393_29
					end
				end

				arg_390_1.text_.text = var_393_33
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192095", "story_v_out_322192.awb") ~= 0 then
					local var_393_37 = manager.audio:GetVoiceLength("story_v_out_322192", "322192095", "story_v_out_322192.awb") / 1000

					if var_393_37 + var_393_29 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_37 + var_393_29
					end

					if var_393_32.prefab_name ~= "" and arg_390_1.actors_[var_393_32.prefab_name] ~= nil then
						local var_393_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_32.prefab_name].transform, "story_v_out_322192", "322192095", "story_v_out_322192.awb")

						arg_390_1:RecordAudio("322192095", var_393_38)
						arg_390_1:RecordAudio("322192095", var_393_38)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_322192", "322192095", "story_v_out_322192.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_322192", "322192095", "story_v_out_322192.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_39 = math.max(var_393_30, arg_390_1.talkMaxDuration)

			if var_393_29 <= arg_390_1.time_ and arg_390_1.time_ < var_393_29 + var_393_39 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_29) / var_393_39

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_29 + var_393_39 and arg_390_1.time_ < var_393_29 + var_393_39 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play322192096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 322192096
		arg_394_1.duration_ = 4.4

		local var_394_0 = {
			zh = 4.4,
			ja = 3.166
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play322192097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["1111ui_story"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1111ui_story == nil then
				arg_394_1.var_.characterEffect1111ui_story = var_397_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.200000002980232

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.characterEffect1111ui_story and not isNil(var_397_0) then
					arg_394_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1111ui_story then
				arg_394_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_397_4 = arg_394_1.actors_["1043ui_story"]
			local var_397_5 = 0

			if var_397_5 < arg_394_1.time_ and arg_394_1.time_ <= var_397_5 + arg_397_0 and not isNil(var_397_4) and arg_394_1.var_.characterEffect1043ui_story == nil then
				arg_394_1.var_.characterEffect1043ui_story = var_397_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_6 = 0.200000002980232

			if var_397_5 <= arg_394_1.time_ and arg_394_1.time_ < var_397_5 + var_397_6 and not isNil(var_397_4) then
				local var_397_7 = (arg_394_1.time_ - var_397_5) / var_397_6

				if arg_394_1.var_.characterEffect1043ui_story and not isNil(var_397_4) then
					local var_397_8 = Mathf.Lerp(0, 0.5, var_397_7)

					arg_394_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1043ui_story.fillRatio = var_397_8
				end
			end

			if arg_394_1.time_ >= var_397_5 + var_397_6 and arg_394_1.time_ < var_397_5 + var_397_6 + arg_397_0 and not isNil(var_397_4) and arg_394_1.var_.characterEffect1043ui_story then
				local var_397_9 = 0.5

				arg_394_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1043ui_story.fillRatio = var_397_9
			end

			local var_397_10 = 0

			if var_397_10 < arg_394_1.time_ and arg_394_1.time_ <= var_397_10 + arg_397_0 then
				arg_394_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			local var_397_11 = 0
			local var_397_12 = 0.35

			if var_397_11 < arg_394_1.time_ and arg_394_1.time_ <= var_397_11 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_13 = arg_394_1:FormatText(StoryNameCfg[67].name)

				arg_394_1.leftNameTxt_.text = var_397_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_14 = arg_394_1:GetWordFromCfg(322192096)
				local var_397_15 = arg_394_1:FormatText(var_397_14.content)

				arg_394_1.text_.text = var_397_15

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_16 = 14
				local var_397_17 = utf8.len(var_397_15)
				local var_397_18 = var_397_16 <= 0 and var_397_12 or var_397_12 * (var_397_17 / var_397_16)

				if var_397_18 > 0 and var_397_12 < var_397_18 then
					arg_394_1.talkMaxDuration = var_397_18

					if var_397_18 + var_397_11 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_18 + var_397_11
					end
				end

				arg_394_1.text_.text = var_397_15
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192096", "story_v_out_322192.awb") ~= 0 then
					local var_397_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192096", "story_v_out_322192.awb") / 1000

					if var_397_19 + var_397_11 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_19 + var_397_11
					end

					if var_397_14.prefab_name ~= "" and arg_394_1.actors_[var_397_14.prefab_name] ~= nil then
						local var_397_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_14.prefab_name].transform, "story_v_out_322192", "322192096", "story_v_out_322192.awb")

						arg_394_1:RecordAudio("322192096", var_397_20)
						arg_394_1:RecordAudio("322192096", var_397_20)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_322192", "322192096", "story_v_out_322192.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_322192", "322192096", "story_v_out_322192.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_21 = math.max(var_397_12, arg_394_1.talkMaxDuration)

			if var_397_11 <= arg_394_1.time_ and arg_394_1.time_ < var_397_11 + var_397_21 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_11) / var_397_21

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_11 + var_397_21 and arg_394_1.time_ < var_397_11 + var_397_21 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play322192097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 322192097
		arg_398_1.duration_ = 16.03

		local var_398_0 = {
			zh = 12.233,
			ja = 16.033
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play322192098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 1.275

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_2 = arg_398_1:FormatText(StoryNameCfg[67].name)

				arg_398_1.leftNameTxt_.text = var_401_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_3 = arg_398_1:GetWordFromCfg(322192097)
				local var_401_4 = arg_398_1:FormatText(var_401_3.content)

				arg_398_1.text_.text = var_401_4

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 51
				local var_401_6 = utf8.len(var_401_4)
				local var_401_7 = var_401_5 <= 0 and var_401_1 or var_401_1 * (var_401_6 / var_401_5)

				if var_401_7 > 0 and var_401_1 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_4
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192097", "story_v_out_322192.awb") ~= 0 then
					local var_401_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192097", "story_v_out_322192.awb") / 1000

					if var_401_8 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_8 + var_401_0
					end

					if var_401_3.prefab_name ~= "" and arg_398_1.actors_[var_401_3.prefab_name] ~= nil then
						local var_401_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_3.prefab_name].transform, "story_v_out_322192", "322192097", "story_v_out_322192.awb")

						arg_398_1:RecordAudio("322192097", var_401_9)
						arg_398_1:RecordAudio("322192097", var_401_9)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_322192", "322192097", "story_v_out_322192.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_322192", "322192097", "story_v_out_322192.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_10 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_10 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_10

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_10 and arg_398_1.time_ < var_401_0 + var_401_10 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play322192098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 322192098
		arg_402_1.duration_ = 11.93

		local var_402_0 = {
			zh = 10.3,
			ja = 11.933
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play322192099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0
			local var_405_1 = 0.8

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_2 = arg_402_1:FormatText(StoryNameCfg[67].name)

				arg_402_1.leftNameTxt_.text = var_405_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_3 = arg_402_1:GetWordFromCfg(322192098)
				local var_405_4 = arg_402_1:FormatText(var_405_3.content)

				arg_402_1.text_.text = var_405_4

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 32
				local var_405_6 = utf8.len(var_405_4)
				local var_405_7 = var_405_5 <= 0 and var_405_1 or var_405_1 * (var_405_6 / var_405_5)

				if var_405_7 > 0 and var_405_1 < var_405_7 then
					arg_402_1.talkMaxDuration = var_405_7

					if var_405_7 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_7 + var_405_0
					end
				end

				arg_402_1.text_.text = var_405_4
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192098", "story_v_out_322192.awb") ~= 0 then
					local var_405_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192098", "story_v_out_322192.awb") / 1000

					if var_405_8 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_8 + var_405_0
					end

					if var_405_3.prefab_name ~= "" and arg_402_1.actors_[var_405_3.prefab_name] ~= nil then
						local var_405_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_3.prefab_name].transform, "story_v_out_322192", "322192098", "story_v_out_322192.awb")

						arg_402_1:RecordAudio("322192098", var_405_9)
						arg_402_1:RecordAudio("322192098", var_405_9)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_322192", "322192098", "story_v_out_322192.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_322192", "322192098", "story_v_out_322192.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_10 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_10 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_10

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_10 and arg_402_1.time_ < var_405_0 + var_405_10 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play322192099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 322192099
		arg_406_1.duration_ = 12.6

		local var_406_0 = {
			zh = 9.566,
			ja = 12.6
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play322192100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1043ui_story"]
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1043ui_story == nil then
				arg_406_1.var_.characterEffect1043ui_story = var_409_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_2 = 0.200000002980232

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 and not isNil(var_409_0) then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2

				if arg_406_1.var_.characterEffect1043ui_story and not isNil(var_409_0) then
					arg_406_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1043ui_story then
				arg_406_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_409_4 = arg_406_1.actors_["1111ui_story"]
			local var_409_5 = 0

			if var_409_5 < arg_406_1.time_ and arg_406_1.time_ <= var_409_5 + arg_409_0 and not isNil(var_409_4) and arg_406_1.var_.characterEffect1111ui_story == nil then
				arg_406_1.var_.characterEffect1111ui_story = var_409_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_6 = 0.200000002980232

			if var_409_5 <= arg_406_1.time_ and arg_406_1.time_ < var_409_5 + var_409_6 and not isNil(var_409_4) then
				local var_409_7 = (arg_406_1.time_ - var_409_5) / var_409_6

				if arg_406_1.var_.characterEffect1111ui_story and not isNil(var_409_4) then
					local var_409_8 = Mathf.Lerp(0, 0.5, var_409_7)

					arg_406_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_406_1.var_.characterEffect1111ui_story.fillRatio = var_409_8
				end
			end

			if arg_406_1.time_ >= var_409_5 + var_409_6 and arg_406_1.time_ < var_409_5 + var_409_6 + arg_409_0 and not isNil(var_409_4) and arg_406_1.var_.characterEffect1111ui_story then
				local var_409_9 = 0.5

				arg_406_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_406_1.var_.characterEffect1111ui_story.fillRatio = var_409_9
			end

			local var_409_10 = 0

			if var_409_10 < arg_406_1.time_ and arg_406_1.time_ <= var_409_10 + arg_409_0 then
				arg_406_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_2")
			end

			local var_409_11 = 0
			local var_409_12 = 1.15

			if var_409_11 < arg_406_1.time_ and arg_406_1.time_ <= var_409_11 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_13 = arg_406_1:FormatText(StoryNameCfg[1156].name)

				arg_406_1.leftNameTxt_.text = var_409_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_14 = arg_406_1:GetWordFromCfg(322192099)
				local var_409_15 = arg_406_1:FormatText(var_409_14.content)

				arg_406_1.text_.text = var_409_15

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_16 = 46
				local var_409_17 = utf8.len(var_409_15)
				local var_409_18 = var_409_16 <= 0 and var_409_12 or var_409_12 * (var_409_17 / var_409_16)

				if var_409_18 > 0 and var_409_12 < var_409_18 then
					arg_406_1.talkMaxDuration = var_409_18

					if var_409_18 + var_409_11 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_18 + var_409_11
					end
				end

				arg_406_1.text_.text = var_409_15
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192099", "story_v_out_322192.awb") ~= 0 then
					local var_409_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192099", "story_v_out_322192.awb") / 1000

					if var_409_19 + var_409_11 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_19 + var_409_11
					end

					if var_409_14.prefab_name ~= "" and arg_406_1.actors_[var_409_14.prefab_name] ~= nil then
						local var_409_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_14.prefab_name].transform, "story_v_out_322192", "322192099", "story_v_out_322192.awb")

						arg_406_1:RecordAudio("322192099", var_409_20)
						arg_406_1:RecordAudio("322192099", var_409_20)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_322192", "322192099", "story_v_out_322192.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_322192", "322192099", "story_v_out_322192.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_21 = math.max(var_409_12, arg_406_1.talkMaxDuration)

			if var_409_11 <= arg_406_1.time_ and arg_406_1.time_ < var_409_11 + var_409_21 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_11) / var_409_21

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_11 + var_409_21 and arg_406_1.time_ < var_409_11 + var_409_21 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play322192100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 322192100
		arg_410_1.duration_ = 8.7

		local var_410_0 = {
			zh = 6.766,
			ja = 8.7
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play322192101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0
			local var_413_1 = 0.85

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_2 = arg_410_1:FormatText(StoryNameCfg[1156].name)

				arg_410_1.leftNameTxt_.text = var_413_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_3 = arg_410_1:GetWordFromCfg(322192100)
				local var_413_4 = arg_410_1:FormatText(var_413_3.content)

				arg_410_1.text_.text = var_413_4

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 34
				local var_413_6 = utf8.len(var_413_4)
				local var_413_7 = var_413_5 <= 0 and var_413_1 or var_413_1 * (var_413_6 / var_413_5)

				if var_413_7 > 0 and var_413_1 < var_413_7 then
					arg_410_1.talkMaxDuration = var_413_7

					if var_413_7 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_7 + var_413_0
					end
				end

				arg_410_1.text_.text = var_413_4
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192100", "story_v_out_322192.awb") ~= 0 then
					local var_413_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192100", "story_v_out_322192.awb") / 1000

					if var_413_8 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_8 + var_413_0
					end

					if var_413_3.prefab_name ~= "" and arg_410_1.actors_[var_413_3.prefab_name] ~= nil then
						local var_413_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_3.prefab_name].transform, "story_v_out_322192", "322192100", "story_v_out_322192.awb")

						arg_410_1:RecordAudio("322192100", var_413_9)
						arg_410_1:RecordAudio("322192100", var_413_9)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_322192", "322192100", "story_v_out_322192.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_322192", "322192100", "story_v_out_322192.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_10 = math.max(var_413_1, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_10 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_0) / var_413_10

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_10 and arg_410_1.time_ < var_413_0 + var_413_10 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play322192101 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 322192101
		arg_414_1.duration_ = 4.73

		local var_414_0 = {
			zh = 3.133,
			ja = 4.733
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play322192102(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["1111ui_story"]
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.characterEffect1111ui_story == nil then
				arg_414_1.var_.characterEffect1111ui_story = var_417_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_2 = 0.200000002980232

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_2 and not isNil(var_417_0) then
				local var_417_3 = (arg_414_1.time_ - var_417_1) / var_417_2

				if arg_414_1.var_.characterEffect1111ui_story and not isNil(var_417_0) then
					arg_414_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= var_417_1 + var_417_2 and arg_414_1.time_ < var_417_1 + var_417_2 + arg_417_0 and not isNil(var_417_0) and arg_414_1.var_.characterEffect1111ui_story then
				arg_414_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_417_4 = arg_414_1.actors_["1043ui_story"]
			local var_417_5 = 0

			if var_417_5 < arg_414_1.time_ and arg_414_1.time_ <= var_417_5 + arg_417_0 and not isNil(var_417_4) and arg_414_1.var_.characterEffect1043ui_story == nil then
				arg_414_1.var_.characterEffect1043ui_story = var_417_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_6 = 0.200000002980232

			if var_417_5 <= arg_414_1.time_ and arg_414_1.time_ < var_417_5 + var_417_6 and not isNil(var_417_4) then
				local var_417_7 = (arg_414_1.time_ - var_417_5) / var_417_6

				if arg_414_1.var_.characterEffect1043ui_story and not isNil(var_417_4) then
					local var_417_8 = Mathf.Lerp(0, 0.5, var_417_7)

					arg_414_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_414_1.var_.characterEffect1043ui_story.fillRatio = var_417_8
				end
			end

			if arg_414_1.time_ >= var_417_5 + var_417_6 and arg_414_1.time_ < var_417_5 + var_417_6 + arg_417_0 and not isNil(var_417_4) and arg_414_1.var_.characterEffect1043ui_story then
				local var_417_9 = 0.5

				arg_414_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_414_1.var_.characterEffect1043ui_story.fillRatio = var_417_9
			end

			local var_417_10 = 0

			if var_417_10 < arg_414_1.time_ and arg_414_1.time_ <= var_417_10 + arg_417_0 then
				arg_414_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_2")
			end

			local var_417_11 = 0
			local var_417_12 = 0.35

			if var_417_11 < arg_414_1.time_ and arg_414_1.time_ <= var_417_11 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_13 = arg_414_1:FormatText(StoryNameCfg[67].name)

				arg_414_1.leftNameTxt_.text = var_417_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_14 = arg_414_1:GetWordFromCfg(322192101)
				local var_417_15 = arg_414_1:FormatText(var_417_14.content)

				arg_414_1.text_.text = var_417_15

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_16 = 14
				local var_417_17 = utf8.len(var_417_15)
				local var_417_18 = var_417_16 <= 0 and var_417_12 or var_417_12 * (var_417_17 / var_417_16)

				if var_417_18 > 0 and var_417_12 < var_417_18 then
					arg_414_1.talkMaxDuration = var_417_18

					if var_417_18 + var_417_11 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_18 + var_417_11
					end
				end

				arg_414_1.text_.text = var_417_15
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192101", "story_v_out_322192.awb") ~= 0 then
					local var_417_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192101", "story_v_out_322192.awb") / 1000

					if var_417_19 + var_417_11 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_19 + var_417_11
					end

					if var_417_14.prefab_name ~= "" and arg_414_1.actors_[var_417_14.prefab_name] ~= nil then
						local var_417_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_14.prefab_name].transform, "story_v_out_322192", "322192101", "story_v_out_322192.awb")

						arg_414_1:RecordAudio("322192101", var_417_20)
						arg_414_1:RecordAudio("322192101", var_417_20)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_322192", "322192101", "story_v_out_322192.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_322192", "322192101", "story_v_out_322192.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_21 = math.max(var_417_12, arg_414_1.talkMaxDuration)

			if var_417_11 <= arg_414_1.time_ and arg_414_1.time_ < var_417_11 + var_417_21 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_11) / var_417_21

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_11 + var_417_21 and arg_414_1.time_ < var_417_11 + var_417_21 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play322192102 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 322192102
		arg_418_1.duration_ = 12.13

		local var_418_0 = {
			zh = 9.1,
			ja = 12.133
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play322192103(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["1043ui_story"]
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect1043ui_story == nil then
				arg_418_1.var_.characterEffect1043ui_story = var_421_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_2 = 0.200000002980232

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_2 and not isNil(var_421_0) then
				local var_421_3 = (arg_418_1.time_ - var_421_1) / var_421_2

				if arg_418_1.var_.characterEffect1043ui_story and not isNil(var_421_0) then
					arg_418_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= var_421_1 + var_421_2 and arg_418_1.time_ < var_421_1 + var_421_2 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect1043ui_story then
				arg_418_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_421_4 = arg_418_1.actors_["1111ui_story"]
			local var_421_5 = 0

			if var_421_5 < arg_418_1.time_ and arg_418_1.time_ <= var_421_5 + arg_421_0 and not isNil(var_421_4) and arg_418_1.var_.characterEffect1111ui_story == nil then
				arg_418_1.var_.characterEffect1111ui_story = var_421_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_6 = 0.200000002980232

			if var_421_5 <= arg_418_1.time_ and arg_418_1.time_ < var_421_5 + var_421_6 and not isNil(var_421_4) then
				local var_421_7 = (arg_418_1.time_ - var_421_5) / var_421_6

				if arg_418_1.var_.characterEffect1111ui_story and not isNil(var_421_4) then
					local var_421_8 = Mathf.Lerp(0, 0.5, var_421_7)

					arg_418_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_418_1.var_.characterEffect1111ui_story.fillRatio = var_421_8
				end
			end

			if arg_418_1.time_ >= var_421_5 + var_421_6 and arg_418_1.time_ < var_421_5 + var_421_6 + arg_421_0 and not isNil(var_421_4) and arg_418_1.var_.characterEffect1111ui_story then
				local var_421_9 = 0.5

				arg_418_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_418_1.var_.characterEffect1111ui_story.fillRatio = var_421_9
			end

			local var_421_10 = 0
			local var_421_11 = 1.025

			if var_421_10 < arg_418_1.time_ and arg_418_1.time_ <= var_421_10 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_12 = arg_418_1:FormatText(StoryNameCfg[1156].name)

				arg_418_1.leftNameTxt_.text = var_421_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_13 = arg_418_1:GetWordFromCfg(322192102)
				local var_421_14 = arg_418_1:FormatText(var_421_13.content)

				arg_418_1.text_.text = var_421_14

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_15 = 41
				local var_421_16 = utf8.len(var_421_14)
				local var_421_17 = var_421_15 <= 0 and var_421_11 or var_421_11 * (var_421_16 / var_421_15)

				if var_421_17 > 0 and var_421_11 < var_421_17 then
					arg_418_1.talkMaxDuration = var_421_17

					if var_421_17 + var_421_10 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_17 + var_421_10
					end
				end

				arg_418_1.text_.text = var_421_14
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192102", "story_v_out_322192.awb") ~= 0 then
					local var_421_18 = manager.audio:GetVoiceLength("story_v_out_322192", "322192102", "story_v_out_322192.awb") / 1000

					if var_421_18 + var_421_10 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_18 + var_421_10
					end

					if var_421_13.prefab_name ~= "" and arg_418_1.actors_[var_421_13.prefab_name] ~= nil then
						local var_421_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_13.prefab_name].transform, "story_v_out_322192", "322192102", "story_v_out_322192.awb")

						arg_418_1:RecordAudio("322192102", var_421_19)
						arg_418_1:RecordAudio("322192102", var_421_19)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_322192", "322192102", "story_v_out_322192.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_322192", "322192102", "story_v_out_322192.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_20 = math.max(var_421_11, arg_418_1.talkMaxDuration)

			if var_421_10 <= arg_418_1.time_ and arg_418_1.time_ < var_421_10 + var_421_20 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_10) / var_421_20

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_10 + var_421_20 and arg_418_1.time_ < var_421_10 + var_421_20 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play322192103 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 322192103
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play322192104(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["1111ui_story"].transform
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 then
				arg_422_1.var_.moveOldPos1111ui_story = var_425_0.localPosition
			end

			local var_425_2 = 0.001

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_2 then
				local var_425_3 = (arg_422_1.time_ - var_425_1) / var_425_2
				local var_425_4 = Vector3.New(0, 100, 0)

				var_425_0.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1111ui_story, var_425_4, var_425_3)

				local var_425_5 = manager.ui.mainCamera.transform.position - var_425_0.position

				var_425_0.forward = Vector3.New(var_425_5.x, var_425_5.y, var_425_5.z)

				local var_425_6 = var_425_0.localEulerAngles

				var_425_6.z = 0
				var_425_6.x = 0
				var_425_0.localEulerAngles = var_425_6
			end

			if arg_422_1.time_ >= var_425_1 + var_425_2 and arg_422_1.time_ < var_425_1 + var_425_2 + arg_425_0 then
				var_425_0.localPosition = Vector3.New(0, 100, 0)

				local var_425_7 = manager.ui.mainCamera.transform.position - var_425_0.position

				var_425_0.forward = Vector3.New(var_425_7.x, var_425_7.y, var_425_7.z)

				local var_425_8 = var_425_0.localEulerAngles

				var_425_8.z = 0
				var_425_8.x = 0
				var_425_0.localEulerAngles = var_425_8
			end

			local var_425_9 = arg_422_1.actors_["1043ui_story"].transform
			local var_425_10 = 0

			if var_425_10 < arg_422_1.time_ and arg_422_1.time_ <= var_425_10 + arg_425_0 then
				arg_422_1.var_.moveOldPos1043ui_story = var_425_9.localPosition
			end

			local var_425_11 = 0.001

			if var_425_10 <= arg_422_1.time_ and arg_422_1.time_ < var_425_10 + var_425_11 then
				local var_425_12 = (arg_422_1.time_ - var_425_10) / var_425_11
				local var_425_13 = Vector3.New(0, 100, 0)

				var_425_9.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1043ui_story, var_425_13, var_425_12)

				local var_425_14 = manager.ui.mainCamera.transform.position - var_425_9.position

				var_425_9.forward = Vector3.New(var_425_14.x, var_425_14.y, var_425_14.z)

				local var_425_15 = var_425_9.localEulerAngles

				var_425_15.z = 0
				var_425_15.x = 0
				var_425_9.localEulerAngles = var_425_15
			end

			if arg_422_1.time_ >= var_425_10 + var_425_11 and arg_422_1.time_ < var_425_10 + var_425_11 + arg_425_0 then
				var_425_9.localPosition = Vector3.New(0, 100, 0)

				local var_425_16 = manager.ui.mainCamera.transform.position - var_425_9.position

				var_425_9.forward = Vector3.New(var_425_16.x, var_425_16.y, var_425_16.z)

				local var_425_17 = var_425_9.localEulerAngles

				var_425_17.z = 0
				var_425_17.x = 0
				var_425_9.localEulerAngles = var_425_17
			end

			local var_425_18 = 0
			local var_425_19 = 1.75

			if var_425_18 < arg_422_1.time_ and arg_422_1.time_ <= var_425_18 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_20 = arg_422_1:GetWordFromCfg(322192103)
				local var_425_21 = arg_422_1:FormatText(var_425_20.content)

				arg_422_1.text_.text = var_425_21

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_22 = 70
				local var_425_23 = utf8.len(var_425_21)
				local var_425_24 = var_425_22 <= 0 and var_425_19 or var_425_19 * (var_425_23 / var_425_22)

				if var_425_24 > 0 and var_425_19 < var_425_24 then
					arg_422_1.talkMaxDuration = var_425_24

					if var_425_24 + var_425_18 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_24 + var_425_18
					end
				end

				arg_422_1.text_.text = var_425_21
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_25 = math.max(var_425_19, arg_422_1.talkMaxDuration)

			if var_425_18 <= arg_422_1.time_ and arg_422_1.time_ < var_425_18 + var_425_25 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_18) / var_425_25

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_18 + var_425_25 and arg_422_1.time_ < var_425_18 + var_425_25 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	Play322192104 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 322192104
		arg_426_1.duration_ = 8.73

		local var_426_0 = {
			zh = 7.4,
			ja = 8.733
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play322192105(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["1043ui_story"].transform
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 then
				arg_426_1.var_.moveOldPos1043ui_story = var_429_0.localPosition
			end

			local var_429_2 = 0.001

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_2 then
				local var_429_3 = (arg_426_1.time_ - var_429_1) / var_429_2
				local var_429_4 = Vector3.New(0.01, -1.01, -5.73)

				var_429_0.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1043ui_story, var_429_4, var_429_3)

				local var_429_5 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_5.x, var_429_5.y, var_429_5.z)

				local var_429_6 = var_429_0.localEulerAngles

				var_429_6.z = 0
				var_429_6.x = 0
				var_429_0.localEulerAngles = var_429_6
			end

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 then
				var_429_0.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_429_7 = manager.ui.mainCamera.transform.position - var_429_0.position

				var_429_0.forward = Vector3.New(var_429_7.x, var_429_7.y, var_429_7.z)

				local var_429_8 = var_429_0.localEulerAngles

				var_429_8.z = 0
				var_429_8.x = 0
				var_429_0.localEulerAngles = var_429_8
			end

			local var_429_9 = arg_426_1.actors_["1043ui_story"]
			local var_429_10 = 0

			if var_429_10 < arg_426_1.time_ and arg_426_1.time_ <= var_429_10 + arg_429_0 and not isNil(var_429_9) and arg_426_1.var_.characterEffect1043ui_story == nil then
				arg_426_1.var_.characterEffect1043ui_story = var_429_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_11 = 0.200000002980232

			if var_429_10 <= arg_426_1.time_ and arg_426_1.time_ < var_429_10 + var_429_11 and not isNil(var_429_9) then
				local var_429_12 = (arg_426_1.time_ - var_429_10) / var_429_11

				if arg_426_1.var_.characterEffect1043ui_story and not isNil(var_429_9) then
					arg_426_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= var_429_10 + var_429_11 and arg_426_1.time_ < var_429_10 + var_429_11 + arg_429_0 and not isNil(var_429_9) and arg_426_1.var_.characterEffect1043ui_story then
				arg_426_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_429_13 = 0

			if var_429_13 < arg_426_1.time_ and arg_426_1.time_ <= var_429_13 + arg_429_0 then
				arg_426_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_429_14 = 0

			if var_429_14 < arg_426_1.time_ and arg_426_1.time_ <= var_429_14 + arg_429_0 then
				arg_426_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_429_15 = 0
			local var_429_16 = 1

			if var_429_15 < arg_426_1.time_ and arg_426_1.time_ <= var_429_15 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_17 = arg_426_1:FormatText(StoryNameCfg[1156].name)

				arg_426_1.leftNameTxt_.text = var_429_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_18 = arg_426_1:GetWordFromCfg(322192104)
				local var_429_19 = arg_426_1:FormatText(var_429_18.content)

				arg_426_1.text_.text = var_429_19

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_20 = 40
				local var_429_21 = utf8.len(var_429_19)
				local var_429_22 = var_429_20 <= 0 and var_429_16 or var_429_16 * (var_429_21 / var_429_20)

				if var_429_22 > 0 and var_429_16 < var_429_22 then
					arg_426_1.talkMaxDuration = var_429_22

					if var_429_22 + var_429_15 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_22 + var_429_15
					end
				end

				arg_426_1.text_.text = var_429_19
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192104", "story_v_out_322192.awb") ~= 0 then
					local var_429_23 = manager.audio:GetVoiceLength("story_v_out_322192", "322192104", "story_v_out_322192.awb") / 1000

					if var_429_23 + var_429_15 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_23 + var_429_15
					end

					if var_429_18.prefab_name ~= "" and arg_426_1.actors_[var_429_18.prefab_name] ~= nil then
						local var_429_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_18.prefab_name].transform, "story_v_out_322192", "322192104", "story_v_out_322192.awb")

						arg_426_1:RecordAudio("322192104", var_429_24)
						arg_426_1:RecordAudio("322192104", var_429_24)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_322192", "322192104", "story_v_out_322192.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_322192", "322192104", "story_v_out_322192.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_25 = math.max(var_429_16, arg_426_1.talkMaxDuration)

			if var_429_15 <= arg_426_1.time_ and arg_426_1.time_ < var_429_15 + var_429_25 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_15) / var_429_25

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_15 + var_429_25 and arg_426_1.time_ < var_429_15 + var_429_25 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play322192105 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 322192105
		arg_430_1.duration_ = 4.67

		local var_430_0 = {
			zh = 4.666,
			ja = 4.166
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play322192106(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["1111ui_story"].transform
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 then
				arg_430_1.var_.moveOldPos1111ui_story = var_433_0.localPosition
			end

			local var_433_2 = 0.001

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2
				local var_433_4 = Vector3.New(0, -0.87, -5.7)

				var_433_0.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1111ui_story, var_433_4, var_433_3)

				local var_433_5 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_5.x, var_433_5.y, var_433_5.z)

				local var_433_6 = var_433_0.localEulerAngles

				var_433_6.z = 0
				var_433_6.x = 0
				var_433_0.localEulerAngles = var_433_6
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 then
				var_433_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_433_7 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_7.x, var_433_7.y, var_433_7.z)

				local var_433_8 = var_433_0.localEulerAngles

				var_433_8.z = 0
				var_433_8.x = 0
				var_433_0.localEulerAngles = var_433_8
			end

			local var_433_9 = arg_430_1.actors_["1043ui_story"].transform
			local var_433_10 = 0

			if var_433_10 < arg_430_1.time_ and arg_430_1.time_ <= var_433_10 + arg_433_0 then
				arg_430_1.var_.moveOldPos1043ui_story = var_433_9.localPosition
			end

			local var_433_11 = 0.001

			if var_433_10 <= arg_430_1.time_ and arg_430_1.time_ < var_433_10 + var_433_11 then
				local var_433_12 = (arg_430_1.time_ - var_433_10) / var_433_11
				local var_433_13 = Vector3.New(0, 100, 0)

				var_433_9.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1043ui_story, var_433_13, var_433_12)

				local var_433_14 = manager.ui.mainCamera.transform.position - var_433_9.position

				var_433_9.forward = Vector3.New(var_433_14.x, var_433_14.y, var_433_14.z)

				local var_433_15 = var_433_9.localEulerAngles

				var_433_15.z = 0
				var_433_15.x = 0
				var_433_9.localEulerAngles = var_433_15
			end

			if arg_430_1.time_ >= var_433_10 + var_433_11 and arg_430_1.time_ < var_433_10 + var_433_11 + arg_433_0 then
				var_433_9.localPosition = Vector3.New(0, 100, 0)

				local var_433_16 = manager.ui.mainCamera.transform.position - var_433_9.position

				var_433_9.forward = Vector3.New(var_433_16.x, var_433_16.y, var_433_16.z)

				local var_433_17 = var_433_9.localEulerAngles

				var_433_17.z = 0
				var_433_17.x = 0
				var_433_9.localEulerAngles = var_433_17
			end

			local var_433_18 = arg_430_1.actors_["1111ui_story"]
			local var_433_19 = 0

			if var_433_19 < arg_430_1.time_ and arg_430_1.time_ <= var_433_19 + arg_433_0 and not isNil(var_433_18) and arg_430_1.var_.characterEffect1111ui_story == nil then
				arg_430_1.var_.characterEffect1111ui_story = var_433_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_20 = 0.200000002980232

			if var_433_19 <= arg_430_1.time_ and arg_430_1.time_ < var_433_19 + var_433_20 and not isNil(var_433_18) then
				local var_433_21 = (arg_430_1.time_ - var_433_19) / var_433_20

				if arg_430_1.var_.characterEffect1111ui_story and not isNil(var_433_18) then
					arg_430_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= var_433_19 + var_433_20 and arg_430_1.time_ < var_433_19 + var_433_20 + arg_433_0 and not isNil(var_433_18) and arg_430_1.var_.characterEffect1111ui_story then
				arg_430_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_433_22 = arg_430_1.actors_["1043ui_story"]
			local var_433_23 = 0

			if var_433_23 < arg_430_1.time_ and arg_430_1.time_ <= var_433_23 + arg_433_0 and not isNil(var_433_22) and arg_430_1.var_.characterEffect1043ui_story == nil then
				arg_430_1.var_.characterEffect1043ui_story = var_433_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_24 = 0.200000002980232

			if var_433_23 <= arg_430_1.time_ and arg_430_1.time_ < var_433_23 + var_433_24 and not isNil(var_433_22) then
				local var_433_25 = (arg_430_1.time_ - var_433_23) / var_433_24

				if arg_430_1.var_.characterEffect1043ui_story and not isNil(var_433_22) then
					local var_433_26 = Mathf.Lerp(0, 0.5, var_433_25)

					arg_430_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_430_1.var_.characterEffect1043ui_story.fillRatio = var_433_26
				end
			end

			if arg_430_1.time_ >= var_433_23 + var_433_24 and arg_430_1.time_ < var_433_23 + var_433_24 + arg_433_0 and not isNil(var_433_22) and arg_430_1.var_.characterEffect1043ui_story then
				local var_433_27 = 0.5

				arg_430_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_430_1.var_.characterEffect1043ui_story.fillRatio = var_433_27
			end

			local var_433_28 = 0

			if var_433_28 < arg_430_1.time_ and arg_430_1.time_ <= var_433_28 + arg_433_0 then
				arg_430_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			local var_433_29 = 0

			if var_433_29 < arg_430_1.time_ and arg_430_1.time_ <= var_433_29 + arg_433_0 then
				arg_430_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_433_30 = 0
			local var_433_31 = 0.375

			if var_433_30 < arg_430_1.time_ and arg_430_1.time_ <= var_433_30 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_32 = arg_430_1:FormatText(StoryNameCfg[67].name)

				arg_430_1.leftNameTxt_.text = var_433_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_33 = arg_430_1:GetWordFromCfg(322192105)
				local var_433_34 = arg_430_1:FormatText(var_433_33.content)

				arg_430_1.text_.text = var_433_34

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_35 = 15
				local var_433_36 = utf8.len(var_433_34)
				local var_433_37 = var_433_35 <= 0 and var_433_31 or var_433_31 * (var_433_36 / var_433_35)

				if var_433_37 > 0 and var_433_31 < var_433_37 then
					arg_430_1.talkMaxDuration = var_433_37

					if var_433_37 + var_433_30 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_37 + var_433_30
					end
				end

				arg_430_1.text_.text = var_433_34
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192105", "story_v_out_322192.awb") ~= 0 then
					local var_433_38 = manager.audio:GetVoiceLength("story_v_out_322192", "322192105", "story_v_out_322192.awb") / 1000

					if var_433_38 + var_433_30 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_38 + var_433_30
					end

					if var_433_33.prefab_name ~= "" and arg_430_1.actors_[var_433_33.prefab_name] ~= nil then
						local var_433_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_33.prefab_name].transform, "story_v_out_322192", "322192105", "story_v_out_322192.awb")

						arg_430_1:RecordAudio("322192105", var_433_39)
						arg_430_1:RecordAudio("322192105", var_433_39)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_322192", "322192105", "story_v_out_322192.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_322192", "322192105", "story_v_out_322192.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_40 = math.max(var_433_31, arg_430_1.talkMaxDuration)

			if var_433_30 <= arg_430_1.time_ and arg_430_1.time_ < var_433_30 + var_433_40 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_30) / var_433_40

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_30 + var_433_40 and arg_430_1.time_ < var_433_30 + var_433_40 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play322192106 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 322192106
		arg_434_1.duration_ = 1.6

		local var_434_0 = {
			zh = 1.466,
			ja = 1.6
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play322192107(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["1111ui_story"].transform
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 then
				arg_434_1.var_.moveOldPos1111ui_story = var_437_0.localPosition
			end

			local var_437_2 = 0.001

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2
				local var_437_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_437_0.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1111ui_story, var_437_4, var_437_3)

				local var_437_5 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_5.x, var_437_5.y, var_437_5.z)

				local var_437_6 = var_437_0.localEulerAngles

				var_437_6.z = 0
				var_437_6.x = 0
				var_437_0.localEulerAngles = var_437_6
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 then
				var_437_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_437_7 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_7.x, var_437_7.y, var_437_7.z)

				local var_437_8 = var_437_0.localEulerAngles

				var_437_8.z = 0
				var_437_8.x = 0
				var_437_0.localEulerAngles = var_437_8
			end

			local var_437_9 = arg_434_1.actors_["1043ui_story"].transform
			local var_437_10 = 0

			if var_437_10 < arg_434_1.time_ and arg_434_1.time_ <= var_437_10 + arg_437_0 then
				arg_434_1.var_.moveOldPos1043ui_story = var_437_9.localPosition
			end

			local var_437_11 = 0.001

			if var_437_10 <= arg_434_1.time_ and arg_434_1.time_ < var_437_10 + var_437_11 then
				local var_437_12 = (arg_434_1.time_ - var_437_10) / var_437_11
				local var_437_13 = Vector3.New(0.81, -1.01, -5.73)

				var_437_9.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1043ui_story, var_437_13, var_437_12)

				local var_437_14 = manager.ui.mainCamera.transform.position - var_437_9.position

				var_437_9.forward = Vector3.New(var_437_14.x, var_437_14.y, var_437_14.z)

				local var_437_15 = var_437_9.localEulerAngles

				var_437_15.z = 0
				var_437_15.x = 0
				var_437_9.localEulerAngles = var_437_15
			end

			if arg_434_1.time_ >= var_437_10 + var_437_11 and arg_434_1.time_ < var_437_10 + var_437_11 + arg_437_0 then
				var_437_9.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_437_16 = manager.ui.mainCamera.transform.position - var_437_9.position

				var_437_9.forward = Vector3.New(var_437_16.x, var_437_16.y, var_437_16.z)

				local var_437_17 = var_437_9.localEulerAngles

				var_437_17.z = 0
				var_437_17.x = 0
				var_437_9.localEulerAngles = var_437_17
			end

			local var_437_18 = arg_434_1.actors_["1043ui_story"]
			local var_437_19 = 0

			if var_437_19 < arg_434_1.time_ and arg_434_1.time_ <= var_437_19 + arg_437_0 and not isNil(var_437_18) and arg_434_1.var_.characterEffect1043ui_story == nil then
				arg_434_1.var_.characterEffect1043ui_story = var_437_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_20 = 0.200000002980232

			if var_437_19 <= arg_434_1.time_ and arg_434_1.time_ < var_437_19 + var_437_20 and not isNil(var_437_18) then
				local var_437_21 = (arg_434_1.time_ - var_437_19) / var_437_20

				if arg_434_1.var_.characterEffect1043ui_story and not isNil(var_437_18) then
					arg_434_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= var_437_19 + var_437_20 and arg_434_1.time_ < var_437_19 + var_437_20 + arg_437_0 and not isNil(var_437_18) and arg_434_1.var_.characterEffect1043ui_story then
				arg_434_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_437_22 = arg_434_1.actors_["1111ui_story"]
			local var_437_23 = 0

			if var_437_23 < arg_434_1.time_ and arg_434_1.time_ <= var_437_23 + arg_437_0 and not isNil(var_437_22) and arg_434_1.var_.characterEffect1111ui_story == nil then
				arg_434_1.var_.characterEffect1111ui_story = var_437_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_24 = 0.200000002980232

			if var_437_23 <= arg_434_1.time_ and arg_434_1.time_ < var_437_23 + var_437_24 and not isNil(var_437_22) then
				local var_437_25 = (arg_434_1.time_ - var_437_23) / var_437_24

				if arg_434_1.var_.characterEffect1111ui_story and not isNil(var_437_22) then
					local var_437_26 = Mathf.Lerp(0, 0.5, var_437_25)

					arg_434_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_434_1.var_.characterEffect1111ui_story.fillRatio = var_437_26
				end
			end

			if arg_434_1.time_ >= var_437_23 + var_437_24 and arg_434_1.time_ < var_437_23 + var_437_24 + arg_437_0 and not isNil(var_437_22) and arg_434_1.var_.characterEffect1111ui_story then
				local var_437_27 = 0.5

				arg_434_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_434_1.var_.characterEffect1111ui_story.fillRatio = var_437_27
			end

			local var_437_28 = 0

			if var_437_28 < arg_434_1.time_ and arg_434_1.time_ <= var_437_28 + arg_437_0 then
				arg_434_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_437_29 = 0

			if var_437_29 < arg_434_1.time_ and arg_434_1.time_ <= var_437_29 + arg_437_0 then
				arg_434_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_437_30 = 0
			local var_437_31 = 0.125

			if var_437_30 < arg_434_1.time_ and arg_434_1.time_ <= var_437_30 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_32 = arg_434_1:FormatText(StoryNameCfg[1156].name)

				arg_434_1.leftNameTxt_.text = var_437_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_33 = arg_434_1:GetWordFromCfg(322192106)
				local var_437_34 = arg_434_1:FormatText(var_437_33.content)

				arg_434_1.text_.text = var_437_34

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_35 = 5
				local var_437_36 = utf8.len(var_437_34)
				local var_437_37 = var_437_35 <= 0 and var_437_31 or var_437_31 * (var_437_36 / var_437_35)

				if var_437_37 > 0 and var_437_31 < var_437_37 then
					arg_434_1.talkMaxDuration = var_437_37

					if var_437_37 + var_437_30 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_37 + var_437_30
					end
				end

				arg_434_1.text_.text = var_437_34
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192106", "story_v_out_322192.awb") ~= 0 then
					local var_437_38 = manager.audio:GetVoiceLength("story_v_out_322192", "322192106", "story_v_out_322192.awb") / 1000

					if var_437_38 + var_437_30 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_38 + var_437_30
					end

					if var_437_33.prefab_name ~= "" and arg_434_1.actors_[var_437_33.prefab_name] ~= nil then
						local var_437_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_33.prefab_name].transform, "story_v_out_322192", "322192106", "story_v_out_322192.awb")

						arg_434_1:RecordAudio("322192106", var_437_39)
						arg_434_1:RecordAudio("322192106", var_437_39)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_322192", "322192106", "story_v_out_322192.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_322192", "322192106", "story_v_out_322192.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_40 = math.max(var_437_31, arg_434_1.talkMaxDuration)

			if var_437_30 <= arg_434_1.time_ and arg_434_1.time_ < var_437_30 + var_437_40 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_30) / var_437_40

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_30 + var_437_40 and arg_434_1.time_ < var_437_30 + var_437_40 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_434_1:InitPlayNodeList()
	end,
	Play322192107 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 322192107
		arg_438_1.duration_ = 20.37

		local var_438_0 = {
			zh = 14.533,
			ja = 20.366
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play322192108(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["1111ui_story"]
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect1111ui_story == nil then
				arg_438_1.var_.characterEffect1111ui_story = var_441_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_2 = 0.200000002980232

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 and not isNil(var_441_0) then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2

				if arg_438_1.var_.characterEffect1111ui_story and not isNil(var_441_0) then
					arg_438_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect1111ui_story then
				arg_438_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_441_4 = arg_438_1.actors_["1043ui_story"]
			local var_441_5 = 0

			if var_441_5 < arg_438_1.time_ and arg_438_1.time_ <= var_441_5 + arg_441_0 and not isNil(var_441_4) and arg_438_1.var_.characterEffect1043ui_story == nil then
				arg_438_1.var_.characterEffect1043ui_story = var_441_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_6 = 0.200000002980232

			if var_441_5 <= arg_438_1.time_ and arg_438_1.time_ < var_441_5 + var_441_6 and not isNil(var_441_4) then
				local var_441_7 = (arg_438_1.time_ - var_441_5) / var_441_6

				if arg_438_1.var_.characterEffect1043ui_story and not isNil(var_441_4) then
					local var_441_8 = Mathf.Lerp(0, 0.5, var_441_7)

					arg_438_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_438_1.var_.characterEffect1043ui_story.fillRatio = var_441_8
				end
			end

			if arg_438_1.time_ >= var_441_5 + var_441_6 and arg_438_1.time_ < var_441_5 + var_441_6 + arg_441_0 and not isNil(var_441_4) and arg_438_1.var_.characterEffect1043ui_story then
				local var_441_9 = 0.5

				arg_438_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_438_1.var_.characterEffect1043ui_story.fillRatio = var_441_9
			end

			local var_441_10 = 0

			if var_441_10 < arg_438_1.time_ and arg_438_1.time_ <= var_441_10 + arg_441_0 then
				arg_438_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_2")
			end

			local var_441_11 = 0
			local var_441_12 = 1.3

			if var_441_11 < arg_438_1.time_ and arg_438_1.time_ <= var_441_11 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_13 = arg_438_1:FormatText(StoryNameCfg[67].name)

				arg_438_1.leftNameTxt_.text = var_441_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_14 = arg_438_1:GetWordFromCfg(322192107)
				local var_441_15 = arg_438_1:FormatText(var_441_14.content)

				arg_438_1.text_.text = var_441_15

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_16 = 52
				local var_441_17 = utf8.len(var_441_15)
				local var_441_18 = var_441_16 <= 0 and var_441_12 or var_441_12 * (var_441_17 / var_441_16)

				if var_441_18 > 0 and var_441_12 < var_441_18 then
					arg_438_1.talkMaxDuration = var_441_18

					if var_441_18 + var_441_11 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_18 + var_441_11
					end
				end

				arg_438_1.text_.text = var_441_15
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192107", "story_v_out_322192.awb") ~= 0 then
					local var_441_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192107", "story_v_out_322192.awb") / 1000

					if var_441_19 + var_441_11 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_19 + var_441_11
					end

					if var_441_14.prefab_name ~= "" and arg_438_1.actors_[var_441_14.prefab_name] ~= nil then
						local var_441_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_14.prefab_name].transform, "story_v_out_322192", "322192107", "story_v_out_322192.awb")

						arg_438_1:RecordAudio("322192107", var_441_20)
						arg_438_1:RecordAudio("322192107", var_441_20)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_322192", "322192107", "story_v_out_322192.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_322192", "322192107", "story_v_out_322192.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_21 = math.max(var_441_12, arg_438_1.talkMaxDuration)

			if var_441_11 <= arg_438_1.time_ and arg_438_1.time_ < var_441_11 + var_441_21 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_11) / var_441_21

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_11 + var_441_21 and arg_438_1.time_ < var_441_11 + var_441_21 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play322192108 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 322192108
		arg_442_1.duration_ = 2.83

		local var_442_0 = {
			zh = 1.999999999999,
			ja = 2.833
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play322192109(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["1043ui_story"]
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.characterEffect1043ui_story == nil then
				arg_442_1.var_.characterEffect1043ui_story = var_445_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_2 = 0.200000002980232

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 and not isNil(var_445_0) then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2

				if arg_442_1.var_.characterEffect1043ui_story and not isNil(var_445_0) then
					arg_442_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.characterEffect1043ui_story then
				arg_442_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_445_4 = arg_442_1.actors_["1111ui_story"]
			local var_445_5 = 0

			if var_445_5 < arg_442_1.time_ and arg_442_1.time_ <= var_445_5 + arg_445_0 and not isNil(var_445_4) and arg_442_1.var_.characterEffect1111ui_story == nil then
				arg_442_1.var_.characterEffect1111ui_story = var_445_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_6 = 0.200000002980232

			if var_445_5 <= arg_442_1.time_ and arg_442_1.time_ < var_445_5 + var_445_6 and not isNil(var_445_4) then
				local var_445_7 = (arg_442_1.time_ - var_445_5) / var_445_6

				if arg_442_1.var_.characterEffect1111ui_story and not isNil(var_445_4) then
					local var_445_8 = Mathf.Lerp(0, 0.5, var_445_7)

					arg_442_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_442_1.var_.characterEffect1111ui_story.fillRatio = var_445_8
				end
			end

			if arg_442_1.time_ >= var_445_5 + var_445_6 and arg_442_1.time_ < var_445_5 + var_445_6 + arg_445_0 and not isNil(var_445_4) and arg_442_1.var_.characterEffect1111ui_story then
				local var_445_9 = 0.5

				arg_442_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_442_1.var_.characterEffect1111ui_story.fillRatio = var_445_9
			end

			local var_445_10 = 0

			if var_445_10 < arg_442_1.time_ and arg_442_1.time_ <= var_445_10 + arg_445_0 then
				arg_442_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			local var_445_11 = 0
			local var_445_12 = 0.175

			if var_445_11 < arg_442_1.time_ and arg_442_1.time_ <= var_445_11 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_13 = arg_442_1:FormatText(StoryNameCfg[1156].name)

				arg_442_1.leftNameTxt_.text = var_445_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_14 = arg_442_1:GetWordFromCfg(322192108)
				local var_445_15 = arg_442_1:FormatText(var_445_14.content)

				arg_442_1.text_.text = var_445_15

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_16 = 7
				local var_445_17 = utf8.len(var_445_15)
				local var_445_18 = var_445_16 <= 0 and var_445_12 or var_445_12 * (var_445_17 / var_445_16)

				if var_445_18 > 0 and var_445_12 < var_445_18 then
					arg_442_1.talkMaxDuration = var_445_18

					if var_445_18 + var_445_11 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_18 + var_445_11
					end
				end

				arg_442_1.text_.text = var_445_15
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192108", "story_v_out_322192.awb") ~= 0 then
					local var_445_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192108", "story_v_out_322192.awb") / 1000

					if var_445_19 + var_445_11 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_19 + var_445_11
					end

					if var_445_14.prefab_name ~= "" and arg_442_1.actors_[var_445_14.prefab_name] ~= nil then
						local var_445_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_14.prefab_name].transform, "story_v_out_322192", "322192108", "story_v_out_322192.awb")

						arg_442_1:RecordAudio("322192108", var_445_20)
						arg_442_1:RecordAudio("322192108", var_445_20)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_322192", "322192108", "story_v_out_322192.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_322192", "322192108", "story_v_out_322192.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_21 = math.max(var_445_12, arg_442_1.talkMaxDuration)

			if var_445_11 <= arg_442_1.time_ and arg_442_1.time_ < var_445_11 + var_445_21 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_11) / var_445_21

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_11 + var_445_21 and arg_442_1.time_ < var_445_11 + var_445_21 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play322192109 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 322192109
		arg_446_1.duration_ = 6.37

		local var_446_0 = {
			zh = 6.366,
			ja = 4.466
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play322192110(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["1111ui_story"]
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.characterEffect1111ui_story == nil then
				arg_446_1.var_.characterEffect1111ui_story = var_449_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_2 = 0.200000002980232

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_2 and not isNil(var_449_0) then
				local var_449_3 = (arg_446_1.time_ - var_449_1) / var_449_2

				if arg_446_1.var_.characterEffect1111ui_story and not isNil(var_449_0) then
					arg_446_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_446_1.time_ >= var_449_1 + var_449_2 and arg_446_1.time_ < var_449_1 + var_449_2 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.characterEffect1111ui_story then
				arg_446_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_449_4 = arg_446_1.actors_["1043ui_story"]
			local var_449_5 = 0

			if var_449_5 < arg_446_1.time_ and arg_446_1.time_ <= var_449_5 + arg_449_0 and not isNil(var_449_4) and arg_446_1.var_.characterEffect1043ui_story == nil then
				arg_446_1.var_.characterEffect1043ui_story = var_449_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_6 = 0.200000002980232

			if var_449_5 <= arg_446_1.time_ and arg_446_1.time_ < var_449_5 + var_449_6 and not isNil(var_449_4) then
				local var_449_7 = (arg_446_1.time_ - var_449_5) / var_449_6

				if arg_446_1.var_.characterEffect1043ui_story and not isNil(var_449_4) then
					local var_449_8 = Mathf.Lerp(0, 0.5, var_449_7)

					arg_446_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_446_1.var_.characterEffect1043ui_story.fillRatio = var_449_8
				end
			end

			if arg_446_1.time_ >= var_449_5 + var_449_6 and arg_446_1.time_ < var_449_5 + var_449_6 + arg_449_0 and not isNil(var_449_4) and arg_446_1.var_.characterEffect1043ui_story then
				local var_449_9 = 0.5

				arg_446_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_446_1.var_.characterEffect1043ui_story.fillRatio = var_449_9
			end

			local var_449_10 = 0
			local var_449_11 = 0.55

			if var_449_10 < arg_446_1.time_ and arg_446_1.time_ <= var_449_10 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_12 = arg_446_1:FormatText(StoryNameCfg[67].name)

				arg_446_1.leftNameTxt_.text = var_449_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_13 = arg_446_1:GetWordFromCfg(322192109)
				local var_449_14 = arg_446_1:FormatText(var_449_13.content)

				arg_446_1.text_.text = var_449_14

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_15 = 22
				local var_449_16 = utf8.len(var_449_14)
				local var_449_17 = var_449_15 <= 0 and var_449_11 or var_449_11 * (var_449_16 / var_449_15)

				if var_449_17 > 0 and var_449_11 < var_449_17 then
					arg_446_1.talkMaxDuration = var_449_17

					if var_449_17 + var_449_10 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_17 + var_449_10
					end
				end

				arg_446_1.text_.text = var_449_14
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192109", "story_v_out_322192.awb") ~= 0 then
					local var_449_18 = manager.audio:GetVoiceLength("story_v_out_322192", "322192109", "story_v_out_322192.awb") / 1000

					if var_449_18 + var_449_10 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_18 + var_449_10
					end

					if var_449_13.prefab_name ~= "" and arg_446_1.actors_[var_449_13.prefab_name] ~= nil then
						local var_449_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_13.prefab_name].transform, "story_v_out_322192", "322192109", "story_v_out_322192.awb")

						arg_446_1:RecordAudio("322192109", var_449_19)
						arg_446_1:RecordAudio("322192109", var_449_19)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_322192", "322192109", "story_v_out_322192.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_322192", "322192109", "story_v_out_322192.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_20 = math.max(var_449_11, arg_446_1.talkMaxDuration)

			if var_449_10 <= arg_446_1.time_ and arg_446_1.time_ < var_449_10 + var_449_20 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_10) / var_449_20

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_10 + var_449_20 and arg_446_1.time_ < var_449_10 + var_449_20 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play322192110 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 322192110
		arg_450_1.duration_ = 7.83

		local var_450_0 = {
			zh = 6.2,
			ja = 7.833
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play322192111(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0

			if var_453_0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_0 + arg_453_0 then
				arg_450_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_453_1 = 0
			local var_453_2 = 0.625

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_3 = arg_450_1:FormatText(StoryNameCfg[67].name)

				arg_450_1.leftNameTxt_.text = var_453_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_4 = arg_450_1:GetWordFromCfg(322192110)
				local var_453_5 = arg_450_1:FormatText(var_453_4.content)

				arg_450_1.text_.text = var_453_5

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_6 = 25
				local var_453_7 = utf8.len(var_453_5)
				local var_453_8 = var_453_6 <= 0 and var_453_2 or var_453_2 * (var_453_7 / var_453_6)

				if var_453_8 > 0 and var_453_2 < var_453_8 then
					arg_450_1.talkMaxDuration = var_453_8

					if var_453_8 + var_453_1 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_8 + var_453_1
					end
				end

				arg_450_1.text_.text = var_453_5
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192110", "story_v_out_322192.awb") ~= 0 then
					local var_453_9 = manager.audio:GetVoiceLength("story_v_out_322192", "322192110", "story_v_out_322192.awb") / 1000

					if var_453_9 + var_453_1 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_9 + var_453_1
					end

					if var_453_4.prefab_name ~= "" and arg_450_1.actors_[var_453_4.prefab_name] ~= nil then
						local var_453_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_4.prefab_name].transform, "story_v_out_322192", "322192110", "story_v_out_322192.awb")

						arg_450_1:RecordAudio("322192110", var_453_10)
						arg_450_1:RecordAudio("322192110", var_453_10)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_322192", "322192110", "story_v_out_322192.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_322192", "322192110", "story_v_out_322192.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_11 = math.max(var_453_2, arg_450_1.talkMaxDuration)

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_11 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_1) / var_453_11

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_1 + var_453_11 and arg_450_1.time_ < var_453_1 + var_453_11 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play322192111 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 322192111
		arg_454_1.duration_ = 2

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play322192112(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["1043ui_story"]
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1043ui_story == nil then
				arg_454_1.var_.characterEffect1043ui_story = var_457_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_2 = 0.200000002980232

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_2 and not isNil(var_457_0) then
				local var_457_3 = (arg_454_1.time_ - var_457_1) / var_457_2

				if arg_454_1.var_.characterEffect1043ui_story and not isNil(var_457_0) then
					arg_454_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= var_457_1 + var_457_2 and arg_454_1.time_ < var_457_1 + var_457_2 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1043ui_story then
				arg_454_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_457_4 = arg_454_1.actors_["1111ui_story"]
			local var_457_5 = 0

			if var_457_5 < arg_454_1.time_ and arg_454_1.time_ <= var_457_5 + arg_457_0 and not isNil(var_457_4) and arg_454_1.var_.characterEffect1111ui_story == nil then
				arg_454_1.var_.characterEffect1111ui_story = var_457_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_6 = 0.200000002980232

			if var_457_5 <= arg_454_1.time_ and arg_454_1.time_ < var_457_5 + var_457_6 and not isNil(var_457_4) then
				local var_457_7 = (arg_454_1.time_ - var_457_5) / var_457_6

				if arg_454_1.var_.characterEffect1111ui_story and not isNil(var_457_4) then
					local var_457_8 = Mathf.Lerp(0, 0.5, var_457_7)

					arg_454_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_454_1.var_.characterEffect1111ui_story.fillRatio = var_457_8
				end
			end

			if arg_454_1.time_ >= var_457_5 + var_457_6 and arg_454_1.time_ < var_457_5 + var_457_6 + arg_457_0 and not isNil(var_457_4) and arg_454_1.var_.characterEffect1111ui_story then
				local var_457_9 = 0.5

				arg_454_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_454_1.var_.characterEffect1111ui_story.fillRatio = var_457_9
			end

			local var_457_10 = 0

			if var_457_10 < arg_454_1.time_ and arg_454_1.time_ <= var_457_10 + arg_457_0 then
				arg_454_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_2")
			end

			local var_457_11 = 0
			local var_457_12 = 0.175

			if var_457_11 < arg_454_1.time_ and arg_454_1.time_ <= var_457_11 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_13 = arg_454_1:FormatText(StoryNameCfg[1156].name)

				arg_454_1.leftNameTxt_.text = var_457_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_14 = arg_454_1:GetWordFromCfg(322192111)
				local var_457_15 = arg_454_1:FormatText(var_457_14.content)

				arg_454_1.text_.text = var_457_15

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_16 = 7
				local var_457_17 = utf8.len(var_457_15)
				local var_457_18 = var_457_16 <= 0 and var_457_12 or var_457_12 * (var_457_17 / var_457_16)

				if var_457_18 > 0 and var_457_12 < var_457_18 then
					arg_454_1.talkMaxDuration = var_457_18

					if var_457_18 + var_457_11 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_18 + var_457_11
					end
				end

				arg_454_1.text_.text = var_457_15
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192111", "story_v_out_322192.awb") ~= 0 then
					local var_457_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192111", "story_v_out_322192.awb") / 1000

					if var_457_19 + var_457_11 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_19 + var_457_11
					end

					if var_457_14.prefab_name ~= "" and arg_454_1.actors_[var_457_14.prefab_name] ~= nil then
						local var_457_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_14.prefab_name].transform, "story_v_out_322192", "322192111", "story_v_out_322192.awb")

						arg_454_1:RecordAudio("322192111", var_457_20)
						arg_454_1:RecordAudio("322192111", var_457_20)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_322192", "322192111", "story_v_out_322192.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_322192", "322192111", "story_v_out_322192.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_21 = math.max(var_457_12, arg_454_1.talkMaxDuration)

			if var_457_11 <= arg_454_1.time_ and arg_454_1.time_ < var_457_11 + var_457_21 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_11) / var_457_21

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_11 + var_457_21 and arg_454_1.time_ < var_457_11 + var_457_21 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play322192112 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 322192112
		arg_458_1.duration_ = 4.83

		local var_458_0 = {
			zh = 3.7,
			ja = 4.833
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play322192113(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["1111ui_story"]
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1111ui_story == nil then
				arg_458_1.var_.characterEffect1111ui_story = var_461_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_2 = 0.200000002980232

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 and not isNil(var_461_0) then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2

				if arg_458_1.var_.characterEffect1111ui_story and not isNil(var_461_0) then
					arg_458_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1111ui_story then
				arg_458_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_461_4 = arg_458_1.actors_["1043ui_story"]
			local var_461_5 = 0

			if var_461_5 < arg_458_1.time_ and arg_458_1.time_ <= var_461_5 + arg_461_0 and not isNil(var_461_4) and arg_458_1.var_.characterEffect1043ui_story == nil then
				arg_458_1.var_.characterEffect1043ui_story = var_461_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_6 = 0.200000002980232

			if var_461_5 <= arg_458_1.time_ and arg_458_1.time_ < var_461_5 + var_461_6 and not isNil(var_461_4) then
				local var_461_7 = (arg_458_1.time_ - var_461_5) / var_461_6

				if arg_458_1.var_.characterEffect1043ui_story and not isNil(var_461_4) then
					local var_461_8 = Mathf.Lerp(0, 0.5, var_461_7)

					arg_458_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1043ui_story.fillRatio = var_461_8
				end
			end

			if arg_458_1.time_ >= var_461_5 + var_461_6 and arg_458_1.time_ < var_461_5 + var_461_6 + arg_461_0 and not isNil(var_461_4) and arg_458_1.var_.characterEffect1043ui_story then
				local var_461_9 = 0.5

				arg_458_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1043ui_story.fillRatio = var_461_9
			end

			local var_461_10 = 0

			if var_461_10 < arg_458_1.time_ and arg_458_1.time_ <= var_461_10 + arg_461_0 then
				arg_458_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_461_11 = 0
			local var_461_12 = 0.375

			if var_461_11 < arg_458_1.time_ and arg_458_1.time_ <= var_461_11 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_13 = arg_458_1:FormatText(StoryNameCfg[67].name)

				arg_458_1.leftNameTxt_.text = var_461_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_14 = arg_458_1:GetWordFromCfg(322192112)
				local var_461_15 = arg_458_1:FormatText(var_461_14.content)

				arg_458_1.text_.text = var_461_15

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_16 = 15
				local var_461_17 = utf8.len(var_461_15)
				local var_461_18 = var_461_16 <= 0 and var_461_12 or var_461_12 * (var_461_17 / var_461_16)

				if var_461_18 > 0 and var_461_12 < var_461_18 then
					arg_458_1.talkMaxDuration = var_461_18

					if var_461_18 + var_461_11 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_18 + var_461_11
					end
				end

				arg_458_1.text_.text = var_461_15
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192112", "story_v_out_322192.awb") ~= 0 then
					local var_461_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192112", "story_v_out_322192.awb") / 1000

					if var_461_19 + var_461_11 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_19 + var_461_11
					end

					if var_461_14.prefab_name ~= "" and arg_458_1.actors_[var_461_14.prefab_name] ~= nil then
						local var_461_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_14.prefab_name].transform, "story_v_out_322192", "322192112", "story_v_out_322192.awb")

						arg_458_1:RecordAudio("322192112", var_461_20)
						arg_458_1:RecordAudio("322192112", var_461_20)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_322192", "322192112", "story_v_out_322192.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_322192", "322192112", "story_v_out_322192.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_21 = math.max(var_461_12, arg_458_1.talkMaxDuration)

			if var_461_11 <= arg_458_1.time_ and arg_458_1.time_ < var_461_11 + var_461_21 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_11) / var_461_21

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_11 + var_461_21 and arg_458_1.time_ < var_461_11 + var_461_21 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play322192113 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 322192113
		arg_462_1.duration_ = 6.53

		local var_462_0 = {
			zh = 6.266,
			ja = 6.533
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play322192114(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["1043ui_story"]
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect1043ui_story == nil then
				arg_462_1.var_.characterEffect1043ui_story = var_465_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_2 = 0.200000002980232

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 and not isNil(var_465_0) then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2

				if arg_462_1.var_.characterEffect1043ui_story and not isNil(var_465_0) then
					arg_462_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect1043ui_story then
				arg_462_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_465_4 = arg_462_1.actors_["1111ui_story"]
			local var_465_5 = 0

			if var_465_5 < arg_462_1.time_ and arg_462_1.time_ <= var_465_5 + arg_465_0 and not isNil(var_465_4) and arg_462_1.var_.characterEffect1111ui_story == nil then
				arg_462_1.var_.characterEffect1111ui_story = var_465_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_6 = 0.200000002980232

			if var_465_5 <= arg_462_1.time_ and arg_462_1.time_ < var_465_5 + var_465_6 and not isNil(var_465_4) then
				local var_465_7 = (arg_462_1.time_ - var_465_5) / var_465_6

				if arg_462_1.var_.characterEffect1111ui_story and not isNil(var_465_4) then
					local var_465_8 = Mathf.Lerp(0, 0.5, var_465_7)

					arg_462_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_462_1.var_.characterEffect1111ui_story.fillRatio = var_465_8
				end
			end

			if arg_462_1.time_ >= var_465_5 + var_465_6 and arg_462_1.time_ < var_465_5 + var_465_6 + arg_465_0 and not isNil(var_465_4) and arg_462_1.var_.characterEffect1111ui_story then
				local var_465_9 = 0.5

				arg_462_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_462_1.var_.characterEffect1111ui_story.fillRatio = var_465_9
			end

			local var_465_10 = 0
			local var_465_11 = 0.525

			if var_465_10 < arg_462_1.time_ and arg_462_1.time_ <= var_465_10 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_12 = arg_462_1:FormatText(StoryNameCfg[1156].name)

				arg_462_1.leftNameTxt_.text = var_465_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_13 = arg_462_1:GetWordFromCfg(322192113)
				local var_465_14 = arg_462_1:FormatText(var_465_13.content)

				arg_462_1.text_.text = var_465_14

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_15 = 21
				local var_465_16 = utf8.len(var_465_14)
				local var_465_17 = var_465_15 <= 0 and var_465_11 or var_465_11 * (var_465_16 / var_465_15)

				if var_465_17 > 0 and var_465_11 < var_465_17 then
					arg_462_1.talkMaxDuration = var_465_17

					if var_465_17 + var_465_10 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_17 + var_465_10
					end
				end

				arg_462_1.text_.text = var_465_14
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192113", "story_v_out_322192.awb") ~= 0 then
					local var_465_18 = manager.audio:GetVoiceLength("story_v_out_322192", "322192113", "story_v_out_322192.awb") / 1000

					if var_465_18 + var_465_10 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_18 + var_465_10
					end

					if var_465_13.prefab_name ~= "" and arg_462_1.actors_[var_465_13.prefab_name] ~= nil then
						local var_465_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_13.prefab_name].transform, "story_v_out_322192", "322192113", "story_v_out_322192.awb")

						arg_462_1:RecordAudio("322192113", var_465_19)
						arg_462_1:RecordAudio("322192113", var_465_19)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_322192", "322192113", "story_v_out_322192.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_322192", "322192113", "story_v_out_322192.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_20 = math.max(var_465_11, arg_462_1.talkMaxDuration)

			if var_465_10 <= arg_462_1.time_ and arg_462_1.time_ < var_465_10 + var_465_20 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_10) / var_465_20

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_10 + var_465_20 and arg_462_1.time_ < var_465_10 + var_465_20 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play322192114 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 322192114
		arg_466_1.duration_ = 1.6

		local var_466_0 = {
			zh = 1.6,
			ja = 1.1
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play322192115(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["1111ui_story"]
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1111ui_story == nil then
				arg_466_1.var_.characterEffect1111ui_story = var_469_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.200000002980232

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 and not isNil(var_469_0) then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2

				if arg_466_1.var_.characterEffect1111ui_story and not isNil(var_469_0) then
					arg_466_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1111ui_story then
				arg_466_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_469_4 = arg_466_1.actors_["1043ui_story"]
			local var_469_5 = 0

			if var_469_5 < arg_466_1.time_ and arg_466_1.time_ <= var_469_5 + arg_469_0 and not isNil(var_469_4) and arg_466_1.var_.characterEffect1043ui_story == nil then
				arg_466_1.var_.characterEffect1043ui_story = var_469_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_6 = 0.200000002980232

			if var_469_5 <= arg_466_1.time_ and arg_466_1.time_ < var_469_5 + var_469_6 and not isNil(var_469_4) then
				local var_469_7 = (arg_466_1.time_ - var_469_5) / var_469_6

				if arg_466_1.var_.characterEffect1043ui_story and not isNil(var_469_4) then
					local var_469_8 = Mathf.Lerp(0, 0.5, var_469_7)

					arg_466_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1043ui_story.fillRatio = var_469_8
				end
			end

			if arg_466_1.time_ >= var_469_5 + var_469_6 and arg_466_1.time_ < var_469_5 + var_469_6 + arg_469_0 and not isNil(var_469_4) and arg_466_1.var_.characterEffect1043ui_story then
				local var_469_9 = 0.5

				arg_466_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1043ui_story.fillRatio = var_469_9
			end

			local var_469_10 = 0
			local var_469_11 = 0.2

			if var_469_10 < arg_466_1.time_ and arg_466_1.time_ <= var_469_10 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_12 = arg_466_1:FormatText(StoryNameCfg[67].name)

				arg_466_1.leftNameTxt_.text = var_469_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_13 = arg_466_1:GetWordFromCfg(322192114)
				local var_469_14 = arg_466_1:FormatText(var_469_13.content)

				arg_466_1.text_.text = var_469_14

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_15 = 8
				local var_469_16 = utf8.len(var_469_14)
				local var_469_17 = var_469_15 <= 0 and var_469_11 or var_469_11 * (var_469_16 / var_469_15)

				if var_469_17 > 0 and var_469_11 < var_469_17 then
					arg_466_1.talkMaxDuration = var_469_17

					if var_469_17 + var_469_10 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_17 + var_469_10
					end
				end

				arg_466_1.text_.text = var_469_14
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192114", "story_v_out_322192.awb") ~= 0 then
					local var_469_18 = manager.audio:GetVoiceLength("story_v_out_322192", "322192114", "story_v_out_322192.awb") / 1000

					if var_469_18 + var_469_10 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_18 + var_469_10
					end

					if var_469_13.prefab_name ~= "" and arg_466_1.actors_[var_469_13.prefab_name] ~= nil then
						local var_469_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_13.prefab_name].transform, "story_v_out_322192", "322192114", "story_v_out_322192.awb")

						arg_466_1:RecordAudio("322192114", var_469_19)
						arg_466_1:RecordAudio("322192114", var_469_19)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_322192", "322192114", "story_v_out_322192.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_322192", "322192114", "story_v_out_322192.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_20 = math.max(var_469_11, arg_466_1.talkMaxDuration)

			if var_469_10 <= arg_466_1.time_ and arg_466_1.time_ < var_469_10 + var_469_20 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_10) / var_469_20

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_10 + var_469_20 and arg_466_1.time_ < var_469_10 + var_469_20 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play322192115 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 322192115
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play322192116(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["1111ui_story"].transform
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1.var_.moveOldPos1111ui_story = var_473_0.localPosition
			end

			local var_473_2 = 0.001

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2
				local var_473_4 = Vector3.New(0, 100, 0)

				var_473_0.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1111ui_story, var_473_4, var_473_3)

				local var_473_5 = manager.ui.mainCamera.transform.position - var_473_0.position

				var_473_0.forward = Vector3.New(var_473_5.x, var_473_5.y, var_473_5.z)

				local var_473_6 = var_473_0.localEulerAngles

				var_473_6.z = 0
				var_473_6.x = 0
				var_473_0.localEulerAngles = var_473_6
			end

			if arg_470_1.time_ >= var_473_1 + var_473_2 and arg_470_1.time_ < var_473_1 + var_473_2 + arg_473_0 then
				var_473_0.localPosition = Vector3.New(0, 100, 0)

				local var_473_7 = manager.ui.mainCamera.transform.position - var_473_0.position

				var_473_0.forward = Vector3.New(var_473_7.x, var_473_7.y, var_473_7.z)

				local var_473_8 = var_473_0.localEulerAngles

				var_473_8.z = 0
				var_473_8.x = 0
				var_473_0.localEulerAngles = var_473_8
			end

			local var_473_9 = arg_470_1.actors_["1043ui_story"].transform
			local var_473_10 = 0

			if var_473_10 < arg_470_1.time_ and arg_470_1.time_ <= var_473_10 + arg_473_0 then
				arg_470_1.var_.moveOldPos1043ui_story = var_473_9.localPosition
			end

			local var_473_11 = 0.001

			if var_473_10 <= arg_470_1.time_ and arg_470_1.time_ < var_473_10 + var_473_11 then
				local var_473_12 = (arg_470_1.time_ - var_473_10) / var_473_11
				local var_473_13 = Vector3.New(0, 100, 0)

				var_473_9.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1043ui_story, var_473_13, var_473_12)

				local var_473_14 = manager.ui.mainCamera.transform.position - var_473_9.position

				var_473_9.forward = Vector3.New(var_473_14.x, var_473_14.y, var_473_14.z)

				local var_473_15 = var_473_9.localEulerAngles

				var_473_15.z = 0
				var_473_15.x = 0
				var_473_9.localEulerAngles = var_473_15
			end

			if arg_470_1.time_ >= var_473_10 + var_473_11 and arg_470_1.time_ < var_473_10 + var_473_11 + arg_473_0 then
				var_473_9.localPosition = Vector3.New(0, 100, 0)

				local var_473_16 = manager.ui.mainCamera.transform.position - var_473_9.position

				var_473_9.forward = Vector3.New(var_473_16.x, var_473_16.y, var_473_16.z)

				local var_473_17 = var_473_9.localEulerAngles

				var_473_17.z = 0
				var_473_17.x = 0
				var_473_9.localEulerAngles = var_473_17
			end

			local var_473_18 = 0
			local var_473_19 = 1.375

			if var_473_18 < arg_470_1.time_ and arg_470_1.time_ <= var_473_18 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_20 = arg_470_1:GetWordFromCfg(322192115)
				local var_473_21 = arg_470_1:FormatText(var_473_20.content)

				arg_470_1.text_.text = var_473_21

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_22 = 55
				local var_473_23 = utf8.len(var_473_21)
				local var_473_24 = var_473_22 <= 0 and var_473_19 or var_473_19 * (var_473_23 / var_473_22)

				if var_473_24 > 0 and var_473_19 < var_473_24 then
					arg_470_1.talkMaxDuration = var_473_24

					if var_473_24 + var_473_18 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_24 + var_473_18
					end
				end

				arg_470_1.text_.text = var_473_21
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_25 = math.max(var_473_19, arg_470_1.talkMaxDuration)

			if var_473_18 <= arg_470_1.time_ and arg_470_1.time_ < var_473_18 + var_473_25 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_18) / var_473_25

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_18 + var_473_25 and arg_470_1.time_ < var_473_18 + var_473_25 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play322192116 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 322192116
		arg_474_1.duration_ = 7.9

		local var_474_0 = {
			zh = 7.9,
			ja = 7.2
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play322192117(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["1043ui_story"].transform
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.var_.moveOldPos1043ui_story = var_477_0.localPosition
			end

			local var_477_2 = 0.001

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2
				local var_477_4 = Vector3.New(0.01, -1.01, -5.73)

				var_477_0.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1043ui_story, var_477_4, var_477_3)

				local var_477_5 = manager.ui.mainCamera.transform.position - var_477_0.position

				var_477_0.forward = Vector3.New(var_477_5.x, var_477_5.y, var_477_5.z)

				local var_477_6 = var_477_0.localEulerAngles

				var_477_6.z = 0
				var_477_6.x = 0
				var_477_0.localEulerAngles = var_477_6
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 then
				var_477_0.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_477_7 = manager.ui.mainCamera.transform.position - var_477_0.position

				var_477_0.forward = Vector3.New(var_477_7.x, var_477_7.y, var_477_7.z)

				local var_477_8 = var_477_0.localEulerAngles

				var_477_8.z = 0
				var_477_8.x = 0
				var_477_0.localEulerAngles = var_477_8
			end

			local var_477_9 = arg_474_1.actors_["1043ui_story"]
			local var_477_10 = 0

			if var_477_10 < arg_474_1.time_ and arg_474_1.time_ <= var_477_10 + arg_477_0 and not isNil(var_477_9) and arg_474_1.var_.characterEffect1043ui_story == nil then
				arg_474_1.var_.characterEffect1043ui_story = var_477_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_11 = 0.200000002980232

			if var_477_10 <= arg_474_1.time_ and arg_474_1.time_ < var_477_10 + var_477_11 and not isNil(var_477_9) then
				local var_477_12 = (arg_474_1.time_ - var_477_10) / var_477_11

				if arg_474_1.var_.characterEffect1043ui_story and not isNil(var_477_9) then
					arg_474_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= var_477_10 + var_477_11 and arg_474_1.time_ < var_477_10 + var_477_11 + arg_477_0 and not isNil(var_477_9) and arg_474_1.var_.characterEffect1043ui_story then
				arg_474_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_477_13 = 0

			if var_477_13 < arg_474_1.time_ and arg_474_1.time_ <= var_477_13 + arg_477_0 then
				arg_474_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_477_14 = 0

			if var_477_14 < arg_474_1.time_ and arg_474_1.time_ <= var_477_14 + arg_477_0 then
				arg_474_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_477_15 = 0
			local var_477_16 = 0.775

			if var_477_15 < arg_474_1.time_ and arg_474_1.time_ <= var_477_15 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_17 = arg_474_1:FormatText(StoryNameCfg[1156].name)

				arg_474_1.leftNameTxt_.text = var_477_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_18 = arg_474_1:GetWordFromCfg(322192116)
				local var_477_19 = arg_474_1:FormatText(var_477_18.content)

				arg_474_1.text_.text = var_477_19

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_20 = 31
				local var_477_21 = utf8.len(var_477_19)
				local var_477_22 = var_477_20 <= 0 and var_477_16 or var_477_16 * (var_477_21 / var_477_20)

				if var_477_22 > 0 and var_477_16 < var_477_22 then
					arg_474_1.talkMaxDuration = var_477_22

					if var_477_22 + var_477_15 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_22 + var_477_15
					end
				end

				arg_474_1.text_.text = var_477_19
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192116", "story_v_out_322192.awb") ~= 0 then
					local var_477_23 = manager.audio:GetVoiceLength("story_v_out_322192", "322192116", "story_v_out_322192.awb") / 1000

					if var_477_23 + var_477_15 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_23 + var_477_15
					end

					if var_477_18.prefab_name ~= "" and arg_474_1.actors_[var_477_18.prefab_name] ~= nil then
						local var_477_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_18.prefab_name].transform, "story_v_out_322192", "322192116", "story_v_out_322192.awb")

						arg_474_1:RecordAudio("322192116", var_477_24)
						arg_474_1:RecordAudio("322192116", var_477_24)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_322192", "322192116", "story_v_out_322192.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_322192", "322192116", "story_v_out_322192.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_25 = math.max(var_477_16, arg_474_1.talkMaxDuration)

			if var_477_15 <= arg_474_1.time_ and arg_474_1.time_ < var_477_15 + var_477_25 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_15) / var_477_25

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_15 + var_477_25 and arg_474_1.time_ < var_477_15 + var_477_25 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play322192117 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 322192117
		arg_478_1.duration_ = 10.17

		local var_478_0 = {
			zh = 8.9,
			ja = 10.166
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play322192118(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0
			local var_481_1 = 1

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_2 = arg_478_1:FormatText(StoryNameCfg[1156].name)

				arg_478_1.leftNameTxt_.text = var_481_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_3 = arg_478_1:GetWordFromCfg(322192117)
				local var_481_4 = arg_478_1:FormatText(var_481_3.content)

				arg_478_1.text_.text = var_481_4

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_5 = 40
				local var_481_6 = utf8.len(var_481_4)
				local var_481_7 = var_481_5 <= 0 and var_481_1 or var_481_1 * (var_481_6 / var_481_5)

				if var_481_7 > 0 and var_481_1 < var_481_7 then
					arg_478_1.talkMaxDuration = var_481_7

					if var_481_7 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_7 + var_481_0
					end
				end

				arg_478_1.text_.text = var_481_4
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192117", "story_v_out_322192.awb") ~= 0 then
					local var_481_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192117", "story_v_out_322192.awb") / 1000

					if var_481_8 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_8 + var_481_0
					end

					if var_481_3.prefab_name ~= "" and arg_478_1.actors_[var_481_3.prefab_name] ~= nil then
						local var_481_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_3.prefab_name].transform, "story_v_out_322192", "322192117", "story_v_out_322192.awb")

						arg_478_1:RecordAudio("322192117", var_481_9)
						arg_478_1:RecordAudio("322192117", var_481_9)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_322192", "322192117", "story_v_out_322192.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_322192", "322192117", "story_v_out_322192.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_10 = math.max(var_481_1, arg_478_1.talkMaxDuration)

			if var_481_0 <= arg_478_1.time_ and arg_478_1.time_ < var_481_0 + var_481_10 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_0) / var_481_10

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_0 + var_481_10 and arg_478_1.time_ < var_481_0 + var_481_10 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play322192118 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 322192118
		arg_482_1.duration_ = 3.8

		local var_482_0 = {
			zh = 3.8,
			ja = 3.133
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play322192119(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0
			local var_485_1 = 0.275

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_2 = arg_482_1:FormatText(StoryNameCfg[1156].name)

				arg_482_1.leftNameTxt_.text = var_485_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_3 = arg_482_1:GetWordFromCfg(322192118)
				local var_485_4 = arg_482_1:FormatText(var_485_3.content)

				arg_482_1.text_.text = var_485_4

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_5 = 11
				local var_485_6 = utf8.len(var_485_4)
				local var_485_7 = var_485_5 <= 0 and var_485_1 or var_485_1 * (var_485_6 / var_485_5)

				if var_485_7 > 0 and var_485_1 < var_485_7 then
					arg_482_1.talkMaxDuration = var_485_7

					if var_485_7 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_0
					end
				end

				arg_482_1.text_.text = var_485_4
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192118", "story_v_out_322192.awb") ~= 0 then
					local var_485_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192118", "story_v_out_322192.awb") / 1000

					if var_485_8 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_8 + var_485_0
					end

					if var_485_3.prefab_name ~= "" and arg_482_1.actors_[var_485_3.prefab_name] ~= nil then
						local var_485_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_3.prefab_name].transform, "story_v_out_322192", "322192118", "story_v_out_322192.awb")

						arg_482_1:RecordAudio("322192118", var_485_9)
						arg_482_1:RecordAudio("322192118", var_485_9)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_322192", "322192118", "story_v_out_322192.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_322192", "322192118", "story_v_out_322192.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_10 = math.max(var_485_1, arg_482_1.talkMaxDuration)

			if var_485_0 <= arg_482_1.time_ and arg_482_1.time_ < var_485_0 + var_485_10 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_0) / var_485_10

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_0 + var_485_10 and arg_482_1.time_ < var_485_0 + var_485_10 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play322192119 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 322192119
		arg_486_1.duration_ = 4.1

		local var_486_0 = {
			zh = 2.333,
			ja = 4.1
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play322192120(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = arg_486_1.actors_["1043ui_story"].transform
			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 then
				arg_486_1.var_.moveOldPos1043ui_story = var_489_0.localPosition
			end

			local var_489_2 = 0.001

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_2 then
				local var_489_3 = (arg_486_1.time_ - var_489_1) / var_489_2
				local var_489_4 = Vector3.New(-0.92, -1.01, -5.73)

				var_489_0.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos1043ui_story, var_489_4, var_489_3)

				local var_489_5 = manager.ui.mainCamera.transform.position - var_489_0.position

				var_489_0.forward = Vector3.New(var_489_5.x, var_489_5.y, var_489_5.z)

				local var_489_6 = var_489_0.localEulerAngles

				var_489_6.z = 0
				var_489_6.x = 0
				var_489_0.localEulerAngles = var_489_6
			end

			if arg_486_1.time_ >= var_489_1 + var_489_2 and arg_486_1.time_ < var_489_1 + var_489_2 + arg_489_0 then
				var_489_0.localPosition = Vector3.New(-0.92, -1.01, -5.73)

				local var_489_7 = manager.ui.mainCamera.transform.position - var_489_0.position

				var_489_0.forward = Vector3.New(var_489_7.x, var_489_7.y, var_489_7.z)

				local var_489_8 = var_489_0.localEulerAngles

				var_489_8.z = 0
				var_489_8.x = 0
				var_489_0.localEulerAngles = var_489_8
			end

			local var_489_9 = "10131ui_story"

			if arg_486_1.actors_[var_489_9] == nil then
				local var_489_10 = Asset.Load("Char/" .. "10131ui_story")

				if not isNil(var_489_10) then
					local var_489_11 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_486_1.stage_.transform)

					var_489_11.name = var_489_9
					var_489_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_486_1.actors_[var_489_9] = var_489_11

					local var_489_12 = var_489_11:GetComponentInChildren(typeof(CharacterEffect))

					var_489_12.enabled = true

					local var_489_13 = GameObjectTools.GetOrAddComponent(var_489_11, typeof(DynamicBoneHelper))

					if var_489_13 then
						var_489_13:EnableDynamicBone(false)
					end

					arg_486_1:ShowWeapon(var_489_12.transform, false)

					arg_486_1.var_[var_489_9 .. "Animator"] = var_489_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_486_1.var_[var_489_9 .. "Animator"].applyRootMotion = true
					arg_486_1.var_[var_489_9 .. "LipSync"] = var_489_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_489_14 = arg_486_1.actors_["10131ui_story"].transform
			local var_489_15 = 0

			if var_489_15 < arg_486_1.time_ and arg_486_1.time_ <= var_489_15 + arg_489_0 then
				arg_486_1.var_.moveOldPos10131ui_story = var_489_14.localPosition
			end

			local var_489_16 = 0.001

			if var_489_15 <= arg_486_1.time_ and arg_486_1.time_ < var_489_15 + var_489_16 then
				local var_489_17 = (arg_486_1.time_ - var_489_15) / var_489_16
				local var_489_18 = Vector3.New(0.83, -0.96, -5.8)

				var_489_14.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos10131ui_story, var_489_18, var_489_17)

				local var_489_19 = manager.ui.mainCamera.transform.position - var_489_14.position

				var_489_14.forward = Vector3.New(var_489_19.x, var_489_19.y, var_489_19.z)

				local var_489_20 = var_489_14.localEulerAngles

				var_489_20.z = 0
				var_489_20.x = 0
				var_489_14.localEulerAngles = var_489_20
			end

			if arg_486_1.time_ >= var_489_15 + var_489_16 and arg_486_1.time_ < var_489_15 + var_489_16 + arg_489_0 then
				var_489_14.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_489_21 = manager.ui.mainCamera.transform.position - var_489_14.position

				var_489_14.forward = Vector3.New(var_489_21.x, var_489_21.y, var_489_21.z)

				local var_489_22 = var_489_14.localEulerAngles

				var_489_22.z = 0
				var_489_22.x = 0
				var_489_14.localEulerAngles = var_489_22
			end

			local var_489_23 = arg_486_1.actors_["10131ui_story"]
			local var_489_24 = 0

			if var_489_24 < arg_486_1.time_ and arg_486_1.time_ <= var_489_24 + arg_489_0 and not isNil(var_489_23) and arg_486_1.var_.characterEffect10131ui_story == nil then
				arg_486_1.var_.characterEffect10131ui_story = var_489_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_25 = 0.200000002980232

			if var_489_24 <= arg_486_1.time_ and arg_486_1.time_ < var_489_24 + var_489_25 and not isNil(var_489_23) then
				local var_489_26 = (arg_486_1.time_ - var_489_24) / var_489_25

				if arg_486_1.var_.characterEffect10131ui_story and not isNil(var_489_23) then
					arg_486_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= var_489_24 + var_489_25 and arg_486_1.time_ < var_489_24 + var_489_25 + arg_489_0 and not isNil(var_489_23) and arg_486_1.var_.characterEffect10131ui_story then
				arg_486_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_489_27 = arg_486_1.actors_["1043ui_story"]
			local var_489_28 = 0

			if var_489_28 < arg_486_1.time_ and arg_486_1.time_ <= var_489_28 + arg_489_0 and not isNil(var_489_27) and arg_486_1.var_.characterEffect1043ui_story == nil then
				arg_486_1.var_.characterEffect1043ui_story = var_489_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_29 = 0.200000002980232

			if var_489_28 <= arg_486_1.time_ and arg_486_1.time_ < var_489_28 + var_489_29 and not isNil(var_489_27) then
				local var_489_30 = (arg_486_1.time_ - var_489_28) / var_489_29

				if arg_486_1.var_.characterEffect1043ui_story and not isNil(var_489_27) then
					local var_489_31 = Mathf.Lerp(0, 0.5, var_489_30)

					arg_486_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_486_1.var_.characterEffect1043ui_story.fillRatio = var_489_31
				end
			end

			if arg_486_1.time_ >= var_489_28 + var_489_29 and arg_486_1.time_ < var_489_28 + var_489_29 + arg_489_0 and not isNil(var_489_27) and arg_486_1.var_.characterEffect1043ui_story then
				local var_489_32 = 0.5

				arg_486_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_486_1.var_.characterEffect1043ui_story.fillRatio = var_489_32
			end

			local var_489_33 = 0

			if var_489_33 < arg_486_1.time_ and arg_486_1.time_ <= var_489_33 + arg_489_0 then
				arg_486_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_489_34 = 0

			if var_489_34 < arg_486_1.time_ and arg_486_1.time_ <= var_489_34 + arg_489_0 then
				arg_486_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_489_35 = 0
			local var_489_36 = 0.35

			if var_489_35 < arg_486_1.time_ and arg_486_1.time_ <= var_489_35 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_37 = arg_486_1:FormatText(StoryNameCfg[1178].name)

				arg_486_1.leftNameTxt_.text = var_489_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_38 = arg_486_1:GetWordFromCfg(322192119)
				local var_489_39 = arg_486_1:FormatText(var_489_38.content)

				arg_486_1.text_.text = var_489_39

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_40 = 14
				local var_489_41 = utf8.len(var_489_39)
				local var_489_42 = var_489_40 <= 0 and var_489_36 or var_489_36 * (var_489_41 / var_489_40)

				if var_489_42 > 0 and var_489_36 < var_489_42 then
					arg_486_1.talkMaxDuration = var_489_42

					if var_489_42 + var_489_35 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_42 + var_489_35
					end
				end

				arg_486_1.text_.text = var_489_39
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192119", "story_v_out_322192.awb") ~= 0 then
					local var_489_43 = manager.audio:GetVoiceLength("story_v_out_322192", "322192119", "story_v_out_322192.awb") / 1000

					if var_489_43 + var_489_35 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_43 + var_489_35
					end

					if var_489_38.prefab_name ~= "" and arg_486_1.actors_[var_489_38.prefab_name] ~= nil then
						local var_489_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_38.prefab_name].transform, "story_v_out_322192", "322192119", "story_v_out_322192.awb")

						arg_486_1:RecordAudio("322192119", var_489_44)
						arg_486_1:RecordAudio("322192119", var_489_44)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_322192", "322192119", "story_v_out_322192.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_322192", "322192119", "story_v_out_322192.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_45 = math.max(var_489_36, arg_486_1.talkMaxDuration)

			if var_489_35 <= arg_486_1.time_ and arg_486_1.time_ < var_489_35 + var_489_45 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_35) / var_489_45

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_35 + var_489_45 and arg_486_1.time_ < var_489_35 + var_489_45 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_486_1:InitPlayNodeList()
	end,
	Play322192120 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 322192120
		arg_490_1.duration_ = 1.1

		local var_490_0 = {
			zh = 1,
			ja = 1.1
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play322192121(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = arg_490_1.actors_["1111ui_story"]
			local var_493_1 = 0

			if var_493_1 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect1111ui_story == nil then
				arg_490_1.var_.characterEffect1111ui_story = var_493_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_2 = 0.200000002980232

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_2 and not isNil(var_493_0) then
				local var_493_3 = (arg_490_1.time_ - var_493_1) / var_493_2

				if arg_490_1.var_.characterEffect1111ui_story and not isNil(var_493_0) then
					arg_490_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= var_493_1 + var_493_2 and arg_490_1.time_ < var_493_1 + var_493_2 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect1111ui_story then
				arg_490_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_493_4 = arg_490_1.actors_["10131ui_story"]
			local var_493_5 = 0

			if var_493_5 < arg_490_1.time_ and arg_490_1.time_ <= var_493_5 + arg_493_0 and not isNil(var_493_4) and arg_490_1.var_.characterEffect10131ui_story == nil then
				arg_490_1.var_.characterEffect10131ui_story = var_493_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_6 = 0.200000002980232

			if var_493_5 <= arg_490_1.time_ and arg_490_1.time_ < var_493_5 + var_493_6 and not isNil(var_493_4) then
				local var_493_7 = (arg_490_1.time_ - var_493_5) / var_493_6

				if arg_490_1.var_.characterEffect10131ui_story and not isNil(var_493_4) then
					local var_493_8 = Mathf.Lerp(0, 0.5, var_493_7)

					arg_490_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_490_1.var_.characterEffect10131ui_story.fillRatio = var_493_8
				end
			end

			if arg_490_1.time_ >= var_493_5 + var_493_6 and arg_490_1.time_ < var_493_5 + var_493_6 + arg_493_0 and not isNil(var_493_4) and arg_490_1.var_.characterEffect10131ui_story then
				local var_493_9 = 0.5

				arg_490_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_490_1.var_.characterEffect10131ui_story.fillRatio = var_493_9
			end

			local var_493_10 = 0
			local var_493_11 = 0.166666666666667

			if var_493_10 < arg_490_1.time_ and arg_490_1.time_ <= var_493_10 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0

				arg_490_1.dialog_:SetActive(true)

				arg_490_1.dialogCg_.alpha = 0

				local var_493_12 = LeanTween.value(arg_490_1.dialog_, 0, 1, 0.3)

				var_493_12:setOnUpdate(LuaHelper.FloatAction(function(arg_494_0)
					arg_490_1.dialogCg_.alpha = arg_494_0
				end))
				var_493_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_490_1.dialog_)
					var_493_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_490_1.duration_ = arg_490_1.duration_ + 0.3

				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_13 = arg_490_1:FormatText(StoryNameCfg[67].name)

				arg_490_1.leftNameTxt_.text = var_493_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, true)
				arg_490_1.iconController_:SetSelectedState("hero")

				arg_490_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_490_1.callingController_:SetSelectedState("normal")

				arg_490_1.keyicon_.color = Color.New(1, 1, 1)
				arg_490_1.icon_.color = Color.New(1, 1, 1)

				local var_493_14 = arg_490_1:GetWordFromCfg(322192120)
				local var_493_15 = arg_490_1:FormatText(var_493_14.content)

				arg_490_1.text_.text = var_493_15

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_16 = 2
				local var_493_17 = utf8.len(var_493_15)
				local var_493_18 = var_493_16 <= 0 and var_493_11 or var_493_11 * (var_493_17 / var_493_16)

				if var_493_18 > 0 and var_493_11 < var_493_18 then
					arg_490_1.talkMaxDuration = var_493_18
					var_493_10 = var_493_10 + 0.3

					if var_493_18 + var_493_10 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_18 + var_493_10
					end
				end

				arg_490_1.text_.text = var_493_15
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192120", "story_v_out_322192.awb") ~= 0 then
					local var_493_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192120", "story_v_out_322192.awb") / 1000

					if var_493_19 + var_493_10 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_19 + var_493_10
					end

					if var_493_14.prefab_name ~= "" and arg_490_1.actors_[var_493_14.prefab_name] ~= nil then
						local var_493_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_14.prefab_name].transform, "story_v_out_322192", "322192120", "story_v_out_322192.awb")

						arg_490_1:RecordAudio("322192120", var_493_20)
						arg_490_1:RecordAudio("322192120", var_493_20)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_322192", "322192120", "story_v_out_322192.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_322192", "322192120", "story_v_out_322192.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_21 = var_493_10 + 0.3
			local var_493_22 = math.max(var_493_11, arg_490_1.talkMaxDuration)

			if var_493_21 <= arg_490_1.time_ and arg_490_1.time_ < var_493_21 + var_493_22 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_21) / var_493_22

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_21 + var_493_22 and arg_490_1.time_ < var_493_21 + var_493_22 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 11,
				className = "StoryShakeNode",
				duration = 0.233333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG_HEAD,
				offset = Vector3.New(4, 4, 4)
			}
		}

		arg_490_1:InitPlayNodeList()
	end,
	Play322192121 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 322192121
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play322192122(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["1043ui_story"].transform
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 then
				arg_496_1.var_.moveOldPos1043ui_story = var_499_0.localPosition
			end

			local var_499_2 = 0.001

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_2 then
				local var_499_3 = (arg_496_1.time_ - var_499_1) / var_499_2
				local var_499_4 = Vector3.New(0, 100, 0)

				var_499_0.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos1043ui_story, var_499_4, var_499_3)

				local var_499_5 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_5.x, var_499_5.y, var_499_5.z)

				local var_499_6 = var_499_0.localEulerAngles

				var_499_6.z = 0
				var_499_6.x = 0
				var_499_0.localEulerAngles = var_499_6
			end

			if arg_496_1.time_ >= var_499_1 + var_499_2 and arg_496_1.time_ < var_499_1 + var_499_2 + arg_499_0 then
				var_499_0.localPosition = Vector3.New(0, 100, 0)

				local var_499_7 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_7.x, var_499_7.y, var_499_7.z)

				local var_499_8 = var_499_0.localEulerAngles

				var_499_8.z = 0
				var_499_8.x = 0
				var_499_0.localEulerAngles = var_499_8
			end

			local var_499_9 = arg_496_1.actors_["10131ui_story"].transform
			local var_499_10 = 0

			if var_499_10 < arg_496_1.time_ and arg_496_1.time_ <= var_499_10 + arg_499_0 then
				arg_496_1.var_.moveOldPos10131ui_story = var_499_9.localPosition
			end

			local var_499_11 = 0.001

			if var_499_10 <= arg_496_1.time_ and arg_496_1.time_ < var_499_10 + var_499_11 then
				local var_499_12 = (arg_496_1.time_ - var_499_10) / var_499_11
				local var_499_13 = Vector3.New(0, 100, 0)

				var_499_9.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos10131ui_story, var_499_13, var_499_12)

				local var_499_14 = manager.ui.mainCamera.transform.position - var_499_9.position

				var_499_9.forward = Vector3.New(var_499_14.x, var_499_14.y, var_499_14.z)

				local var_499_15 = var_499_9.localEulerAngles

				var_499_15.z = 0
				var_499_15.x = 0
				var_499_9.localEulerAngles = var_499_15
			end

			if arg_496_1.time_ >= var_499_10 + var_499_11 and arg_496_1.time_ < var_499_10 + var_499_11 + arg_499_0 then
				var_499_9.localPosition = Vector3.New(0, 100, 0)

				local var_499_16 = manager.ui.mainCamera.transform.position - var_499_9.position

				var_499_9.forward = Vector3.New(var_499_16.x, var_499_16.y, var_499_16.z)

				local var_499_17 = var_499_9.localEulerAngles

				var_499_17.z = 0
				var_499_17.x = 0
				var_499_9.localEulerAngles = var_499_17
			end

			local var_499_18 = 0
			local var_499_19 = 0.875

			if var_499_18 < arg_496_1.time_ and arg_496_1.time_ <= var_499_18 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, false)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_20 = arg_496_1:GetWordFromCfg(322192121)
				local var_499_21 = arg_496_1:FormatText(var_499_20.content)

				arg_496_1.text_.text = var_499_21

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_22 = 35
				local var_499_23 = utf8.len(var_499_21)
				local var_499_24 = var_499_22 <= 0 and var_499_19 or var_499_19 * (var_499_23 / var_499_22)

				if var_499_24 > 0 and var_499_19 < var_499_24 then
					arg_496_1.talkMaxDuration = var_499_24

					if var_499_24 + var_499_18 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_24 + var_499_18
					end
				end

				arg_496_1.text_.text = var_499_21
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_25 = math.max(var_499_19, arg_496_1.talkMaxDuration)

			if var_499_18 <= arg_496_1.time_ and arg_496_1.time_ < var_499_18 + var_499_25 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_18) / var_499_25

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_18 + var_499_25 and arg_496_1.time_ < var_499_18 + var_499_25 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play322192122 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 322192122
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play322192123(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 0.7

			if var_503_0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, false)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_2 = arg_500_1:GetWordFromCfg(322192122)
				local var_503_3 = arg_500_1:FormatText(var_503_2.content)

				arg_500_1.text_.text = var_503_3

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_4 = 28
				local var_503_5 = utf8.len(var_503_3)
				local var_503_6 = var_503_4 <= 0 and var_503_1 or var_503_1 * (var_503_5 / var_503_4)

				if var_503_6 > 0 and var_503_1 < var_503_6 then
					arg_500_1.talkMaxDuration = var_503_6

					if var_503_6 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_6 + var_503_0
					end
				end

				arg_500_1.text_.text = var_503_3
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_7 = math.max(var_503_1, arg_500_1.talkMaxDuration)

			if var_503_0 <= arg_500_1.time_ and arg_500_1.time_ < var_503_0 + var_503_7 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_0) / var_503_7

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_0 + var_503_7 and arg_500_1.time_ < var_503_0 + var_503_7 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play322192123 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 322192123
		arg_504_1.duration_ = 4.3

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play322192124(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 1

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				local var_507_1 = manager.ui.mainCamera.transform.localPosition
				local var_507_2 = Vector3.New(0, 0, 10) + Vector3.New(var_507_1.x, var_507_1.y, 0)
				local var_507_3 = arg_504_1.bgs_.STblack

				var_507_3.transform.localPosition = var_507_2
				var_507_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_507_4 = var_507_3:GetComponent("SpriteRenderer")

				if var_507_4 and var_507_4.sprite then
					local var_507_5 = (var_507_3.transform.localPosition - var_507_1).z
					local var_507_6 = manager.ui.mainCameraCom_
					local var_507_7 = 2 * var_507_5 * Mathf.Tan(var_507_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_507_8 = var_507_7 * var_507_6.aspect
					local var_507_9 = var_507_4.sprite.bounds.size.x
					local var_507_10 = var_507_4.sprite.bounds.size.y
					local var_507_11 = var_507_8 / var_507_9
					local var_507_12 = var_507_7 / var_507_10
					local var_507_13 = var_507_12 < var_507_11 and var_507_11 or var_507_12

					var_507_3.transform.localScale = Vector3.New(var_507_13, var_507_13, 0)
				end

				for iter_507_0, iter_507_1 in pairs(arg_504_1.bgs_) do
					if iter_507_0 ~= "STblack" then
						iter_507_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_507_14 = 2

			if var_507_14 < arg_504_1.time_ and arg_504_1.time_ <= var_507_14 + arg_507_0 then
				arg_504_1.allBtn_.enabled = false
			end

			local var_507_15 = 0.3

			if arg_504_1.time_ >= var_507_14 + var_507_15 and arg_504_1.time_ < var_507_14 + var_507_15 + arg_507_0 then
				arg_504_1.allBtn_.enabled = true
			end

			local var_507_16 = 0

			if var_507_16 < arg_504_1.time_ and arg_504_1.time_ <= var_507_16 + arg_507_0 then
				arg_504_1.mask_.enabled = true
				arg_504_1.mask_.raycastTarget = true

				arg_504_1:SetGaussion(false)
			end

			local var_507_17 = 1

			if var_507_16 <= arg_504_1.time_ and arg_504_1.time_ < var_507_16 + var_507_17 then
				local var_507_18 = (arg_504_1.time_ - var_507_16) / var_507_17
				local var_507_19 = Color.New(0, 0, 0)

				var_507_19.a = Mathf.Lerp(0, 1, var_507_18)
				arg_504_1.mask_.color = var_507_19
			end

			if arg_504_1.time_ >= var_507_16 + var_507_17 and arg_504_1.time_ < var_507_16 + var_507_17 + arg_507_0 then
				local var_507_20 = Color.New(0, 0, 0)

				var_507_20.a = 1
				arg_504_1.mask_.color = var_507_20
			end

			local var_507_21 = 1

			if var_507_21 < arg_504_1.time_ and arg_504_1.time_ <= var_507_21 + arg_507_0 then
				arg_504_1.mask_.enabled = true
				arg_504_1.mask_.raycastTarget = true

				arg_504_1:SetGaussion(false)
			end

			local var_507_22 = 1

			if var_507_21 <= arg_504_1.time_ and arg_504_1.time_ < var_507_21 + var_507_22 then
				local var_507_23 = (arg_504_1.time_ - var_507_21) / var_507_22
				local var_507_24 = Color.New(0, 0, 0)

				var_507_24.a = Mathf.Lerp(1, 0, var_507_23)
				arg_504_1.mask_.color = var_507_24
			end

			if arg_504_1.time_ >= var_507_21 + var_507_22 and arg_504_1.time_ < var_507_21 + var_507_22 + arg_507_0 then
				local var_507_25 = Color.New(0, 0, 0)
				local var_507_26 = 0

				arg_504_1.mask_.enabled = false
				var_507_25.a = var_507_26
				arg_504_1.mask_.color = var_507_25
			end

			local var_507_27 = 1
			local var_507_28 = 3.3
			local var_507_29 = manager.audio:GetVoiceLength("story_v_out_321122", "321122038", "story_v_out_321122.awb") / 1000

			if var_507_29 > 0 and var_507_28 < var_507_29 and var_507_29 + var_507_27 > arg_504_1.duration_ then
				local var_507_30 = var_507_29

				arg_504_1.duration_ = var_507_29 + var_507_27
			end

			if var_507_27 < arg_504_1.time_ and arg_504_1.time_ <= var_507_27 + arg_507_0 then
				local var_507_31 = "play"
				local var_507_32 = "voice"

				arg_504_1:AudioAction(var_507_31, var_507_32, "story_v_out_321122", "321122038", "story_v_out_321122.awb")
			end
		end

		arg_504_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 419164,
				charCount = 9,
				enableLayoutChange = true,
				duration = 1.66666666666667,
				groupID = "11",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 110,
					fontAssetPath = "Fonts/SourceHanSerifCN-Bold-3.0",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_504_1:InitPlayNodeList()
	end,
	Play322192124 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 322192124
		arg_508_1.duration_ = 12.6

		local var_508_0 = {
			zh = 11.1,
			ja = 12.6
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play322192125(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 1

			if var_511_0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_0 + arg_511_0 then
				local var_511_1 = manager.ui.mainCamera.transform.localPosition
				local var_511_2 = Vector3.New(0, 0, 10) + Vector3.New(var_511_1.x, var_511_1.y, 0)
				local var_511_3 = arg_508_1.bgs_.L09f

				var_511_3.transform.localPosition = var_511_2
				var_511_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_511_4 = var_511_3:GetComponent("SpriteRenderer")

				if var_511_4 and var_511_4.sprite then
					local var_511_5 = (var_511_3.transform.localPosition - var_511_1).z
					local var_511_6 = manager.ui.mainCameraCom_
					local var_511_7 = 2 * var_511_5 * Mathf.Tan(var_511_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_511_8 = var_511_7 * var_511_6.aspect
					local var_511_9 = var_511_4.sprite.bounds.size.x
					local var_511_10 = var_511_4.sprite.bounds.size.y
					local var_511_11 = var_511_8 / var_511_9
					local var_511_12 = var_511_7 / var_511_10
					local var_511_13 = var_511_12 < var_511_11 and var_511_11 or var_511_12

					var_511_3.transform.localScale = Vector3.New(var_511_13, var_511_13, 0)
				end

				for iter_511_0, iter_511_1 in pairs(arg_508_1.bgs_) do
					if iter_511_0 ~= "L09f" then
						iter_511_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_511_14 = 2

			if var_511_14 < arg_508_1.time_ and arg_508_1.time_ <= var_511_14 + arg_511_0 then
				arg_508_1.allBtn_.enabled = false
			end

			local var_511_15 = 0.3

			if arg_508_1.time_ >= var_511_14 + var_511_15 and arg_508_1.time_ < var_511_14 + var_511_15 + arg_511_0 then
				arg_508_1.allBtn_.enabled = true
			end

			local var_511_16 = 0

			if var_511_16 < arg_508_1.time_ and arg_508_1.time_ <= var_511_16 + arg_511_0 then
				arg_508_1.mask_.enabled = true
				arg_508_1.mask_.raycastTarget = true

				arg_508_1:SetGaussion(false)
			end

			local var_511_17 = 1

			if var_511_16 <= arg_508_1.time_ and arg_508_1.time_ < var_511_16 + var_511_17 then
				local var_511_18 = (arg_508_1.time_ - var_511_16) / var_511_17
				local var_511_19 = Color.New(0, 0, 0)

				var_511_19.a = Mathf.Lerp(0, 1, var_511_18)
				arg_508_1.mask_.color = var_511_19
			end

			if arg_508_1.time_ >= var_511_16 + var_511_17 and arg_508_1.time_ < var_511_16 + var_511_17 + arg_511_0 then
				local var_511_20 = Color.New(0, 0, 0)

				var_511_20.a = 1
				arg_508_1.mask_.color = var_511_20
			end

			local var_511_21 = 1

			if var_511_21 < arg_508_1.time_ and arg_508_1.time_ <= var_511_21 + arg_511_0 then
				arg_508_1.mask_.enabled = true
				arg_508_1.mask_.raycastTarget = true

				arg_508_1:SetGaussion(false)
			end

			local var_511_22 = 1

			if var_511_21 <= arg_508_1.time_ and arg_508_1.time_ < var_511_21 + var_511_22 then
				local var_511_23 = (arg_508_1.time_ - var_511_21) / var_511_22
				local var_511_24 = Color.New(0, 0, 0)

				var_511_24.a = Mathf.Lerp(1, 0, var_511_23)
				arg_508_1.mask_.color = var_511_24
			end

			if arg_508_1.time_ >= var_511_21 + var_511_22 and arg_508_1.time_ < var_511_21 + var_511_22 + arg_511_0 then
				local var_511_25 = Color.New(0, 0, 0)
				local var_511_26 = 0

				arg_508_1.mask_.enabled = false
				var_511_25.a = var_511_26
				arg_508_1.mask_.color = var_511_25
			end

			local var_511_27 = arg_508_1.actors_["10131ui_story"].transform
			local var_511_28 = 2

			if var_511_28 < arg_508_1.time_ and arg_508_1.time_ <= var_511_28 + arg_511_0 then
				arg_508_1.var_.moveOldPos10131ui_story = var_511_27.localPosition
			end

			local var_511_29 = 0.001

			if var_511_28 <= arg_508_1.time_ and arg_508_1.time_ < var_511_28 + var_511_29 then
				local var_511_30 = (arg_508_1.time_ - var_511_28) / var_511_29
				local var_511_31 = Vector3.New(0.05, -0.96, -5.8)

				var_511_27.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos10131ui_story, var_511_31, var_511_30)

				local var_511_32 = manager.ui.mainCamera.transform.position - var_511_27.position

				var_511_27.forward = Vector3.New(var_511_32.x, var_511_32.y, var_511_32.z)

				local var_511_33 = var_511_27.localEulerAngles

				var_511_33.z = 0
				var_511_33.x = 0
				var_511_27.localEulerAngles = var_511_33
			end

			if arg_508_1.time_ >= var_511_28 + var_511_29 and arg_508_1.time_ < var_511_28 + var_511_29 + arg_511_0 then
				var_511_27.localPosition = Vector3.New(0.05, -0.96, -5.8)

				local var_511_34 = manager.ui.mainCamera.transform.position - var_511_27.position

				var_511_27.forward = Vector3.New(var_511_34.x, var_511_34.y, var_511_34.z)

				local var_511_35 = var_511_27.localEulerAngles

				var_511_35.z = 0
				var_511_35.x = 0
				var_511_27.localEulerAngles = var_511_35
			end

			local var_511_36 = arg_508_1.actors_["10131ui_story"]
			local var_511_37 = 2

			if var_511_37 < arg_508_1.time_ and arg_508_1.time_ <= var_511_37 + arg_511_0 and not isNil(var_511_36) and arg_508_1.var_.characterEffect10131ui_story == nil then
				arg_508_1.var_.characterEffect10131ui_story = var_511_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_38 = 0.200000002980232

			if var_511_37 <= arg_508_1.time_ and arg_508_1.time_ < var_511_37 + var_511_38 and not isNil(var_511_36) then
				local var_511_39 = (arg_508_1.time_ - var_511_37) / var_511_38

				if arg_508_1.var_.characterEffect10131ui_story and not isNil(var_511_36) then
					arg_508_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_508_1.time_ >= var_511_37 + var_511_38 and arg_508_1.time_ < var_511_37 + var_511_38 + arg_511_0 and not isNil(var_511_36) and arg_508_1.var_.characterEffect10131ui_story then
				arg_508_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_511_40 = 2

			if var_511_40 < arg_508_1.time_ and arg_508_1.time_ <= var_511_40 + arg_511_0 then
				arg_508_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			local var_511_41 = 2

			if var_511_41 < arg_508_1.time_ and arg_508_1.time_ <= var_511_41 + arg_511_0 then
				arg_508_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if arg_508_1.frameCnt_ <= 1 then
				arg_508_1.dialog_:SetActive(false)
			end

			local var_511_42 = 2
			local var_511_43 = 1.05

			if var_511_42 < arg_508_1.time_ and arg_508_1.time_ <= var_511_42 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0

				arg_508_1.dialog_:SetActive(true)

				arg_508_1.dialogCg_.alpha = 0

				local var_511_44 = LeanTween.value(arg_508_1.dialog_, 0, 1, 0.3)

				var_511_44:setOnUpdate(LuaHelper.FloatAction(function(arg_512_0)
					arg_508_1.dialogCg_.alpha = arg_512_0
				end))
				var_511_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_508_1.dialog_)
					var_511_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_508_1.duration_ = arg_508_1.duration_ + 0.3

				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_45 = arg_508_1:FormatText(StoryNameCfg[1178].name)

				arg_508_1.leftNameTxt_.text = var_511_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_46 = arg_508_1:GetWordFromCfg(322192124)
				local var_511_47 = arg_508_1:FormatText(var_511_46.content)

				arg_508_1.text_.text = var_511_47

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_48 = 42
				local var_511_49 = utf8.len(var_511_47)
				local var_511_50 = var_511_48 <= 0 and var_511_43 or var_511_43 * (var_511_49 / var_511_48)

				if var_511_50 > 0 and var_511_43 < var_511_50 then
					arg_508_1.talkMaxDuration = var_511_50
					var_511_42 = var_511_42 + 0.3

					if var_511_50 + var_511_42 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_50 + var_511_42
					end
				end

				arg_508_1.text_.text = var_511_47
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192124", "story_v_out_322192.awb") ~= 0 then
					local var_511_51 = manager.audio:GetVoiceLength("story_v_out_322192", "322192124", "story_v_out_322192.awb") / 1000

					if var_511_51 + var_511_42 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_51 + var_511_42
					end

					if var_511_46.prefab_name ~= "" and arg_508_1.actors_[var_511_46.prefab_name] ~= nil then
						local var_511_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_46.prefab_name].transform, "story_v_out_322192", "322192124", "story_v_out_322192.awb")

						arg_508_1:RecordAudio("322192124", var_511_52)
						arg_508_1:RecordAudio("322192124", var_511_52)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_322192", "322192124", "story_v_out_322192.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_322192", "322192124", "story_v_out_322192.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_53 = var_511_42 + 0.3
			local var_511_54 = math.max(var_511_43, arg_508_1.talkMaxDuration)

			if var_511_53 <= arg_508_1.time_ and arg_508_1.time_ < var_511_53 + var_511_54 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_53) / var_511_54

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_53 + var_511_54 and arg_508_1.time_ < var_511_53 + var_511_54 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				groupID = "11",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_508_1:InitPlayNodeList()
	end,
	Play322192125 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 322192125
		arg_514_1.duration_ = 2.87

		local var_514_0 = {
			zh = 2.866,
			ja = 1.999999999999
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play322192126(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = arg_514_1.actors_["10131ui_story"].transform
			local var_517_1 = 0

			if var_517_1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 then
				arg_514_1.var_.moveOldPos10131ui_story = var_517_0.localPosition
			end

			local var_517_2 = 0.001

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_2 then
				local var_517_3 = (arg_514_1.time_ - var_517_1) / var_517_2
				local var_517_4 = Vector3.New(-0.78, -0.96, -5.8)

				var_517_0.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos10131ui_story, var_517_4, var_517_3)

				local var_517_5 = manager.ui.mainCamera.transform.position - var_517_0.position

				var_517_0.forward = Vector3.New(var_517_5.x, var_517_5.y, var_517_5.z)

				local var_517_6 = var_517_0.localEulerAngles

				var_517_6.z = 0
				var_517_6.x = 0
				var_517_0.localEulerAngles = var_517_6
			end

			if arg_514_1.time_ >= var_517_1 + var_517_2 and arg_514_1.time_ < var_517_1 + var_517_2 + arg_517_0 then
				var_517_0.localPosition = Vector3.New(-0.78, -0.96, -5.8)

				local var_517_7 = manager.ui.mainCamera.transform.position - var_517_0.position

				var_517_0.forward = Vector3.New(var_517_7.x, var_517_7.y, var_517_7.z)

				local var_517_8 = var_517_0.localEulerAngles

				var_517_8.z = 0
				var_517_8.x = 0
				var_517_0.localEulerAngles = var_517_8
			end

			local var_517_9 = arg_514_1.actors_["1111ui_story"].transform
			local var_517_10 = 0

			if var_517_10 < arg_514_1.time_ and arg_514_1.time_ <= var_517_10 + arg_517_0 then
				arg_514_1.var_.moveOldPos1111ui_story = var_517_9.localPosition
			end

			local var_517_11 = 0.001

			if var_517_10 <= arg_514_1.time_ and arg_514_1.time_ < var_517_10 + var_517_11 then
				local var_517_12 = (arg_514_1.time_ - var_517_10) / var_517_11
				local var_517_13 = Vector3.New(0.7, -0.87, -5.7)

				var_517_9.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1111ui_story, var_517_13, var_517_12)

				local var_517_14 = manager.ui.mainCamera.transform.position - var_517_9.position

				var_517_9.forward = Vector3.New(var_517_14.x, var_517_14.y, var_517_14.z)

				local var_517_15 = var_517_9.localEulerAngles

				var_517_15.z = 0
				var_517_15.x = 0
				var_517_9.localEulerAngles = var_517_15
			end

			if arg_514_1.time_ >= var_517_10 + var_517_11 and arg_514_1.time_ < var_517_10 + var_517_11 + arg_517_0 then
				var_517_9.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_517_16 = manager.ui.mainCamera.transform.position - var_517_9.position

				var_517_9.forward = Vector3.New(var_517_16.x, var_517_16.y, var_517_16.z)

				local var_517_17 = var_517_9.localEulerAngles

				var_517_17.z = 0
				var_517_17.x = 0
				var_517_9.localEulerAngles = var_517_17
			end

			local var_517_18 = arg_514_1.actors_["1111ui_story"]
			local var_517_19 = 0

			if var_517_19 < arg_514_1.time_ and arg_514_1.time_ <= var_517_19 + arg_517_0 and not isNil(var_517_18) and arg_514_1.var_.characterEffect1111ui_story == nil then
				arg_514_1.var_.characterEffect1111ui_story = var_517_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_20 = 0.200000002980232

			if var_517_19 <= arg_514_1.time_ and arg_514_1.time_ < var_517_19 + var_517_20 and not isNil(var_517_18) then
				local var_517_21 = (arg_514_1.time_ - var_517_19) / var_517_20

				if arg_514_1.var_.characterEffect1111ui_story and not isNil(var_517_18) then
					arg_514_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= var_517_19 + var_517_20 and arg_514_1.time_ < var_517_19 + var_517_20 + arg_517_0 and not isNil(var_517_18) and arg_514_1.var_.characterEffect1111ui_story then
				arg_514_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_517_22 = arg_514_1.actors_["10131ui_story"]
			local var_517_23 = 0

			if var_517_23 < arg_514_1.time_ and arg_514_1.time_ <= var_517_23 + arg_517_0 and not isNil(var_517_22) and arg_514_1.var_.characterEffect10131ui_story == nil then
				arg_514_1.var_.characterEffect10131ui_story = var_517_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_24 = 0.200000002980232

			if var_517_23 <= arg_514_1.time_ and arg_514_1.time_ < var_517_23 + var_517_24 and not isNil(var_517_22) then
				local var_517_25 = (arg_514_1.time_ - var_517_23) / var_517_24

				if arg_514_1.var_.characterEffect10131ui_story and not isNil(var_517_22) then
					local var_517_26 = Mathf.Lerp(0, 0.5, var_517_25)

					arg_514_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_514_1.var_.characterEffect10131ui_story.fillRatio = var_517_26
				end
			end

			if arg_514_1.time_ >= var_517_23 + var_517_24 and arg_514_1.time_ < var_517_23 + var_517_24 + arg_517_0 and not isNil(var_517_22) and arg_514_1.var_.characterEffect10131ui_story then
				local var_517_27 = 0.5

				arg_514_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_514_1.var_.characterEffect10131ui_story.fillRatio = var_517_27
			end

			local var_517_28 = 0

			if var_517_28 < arg_514_1.time_ and arg_514_1.time_ <= var_517_28 + arg_517_0 then
				arg_514_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_517_29 = 0

			if var_517_29 < arg_514_1.time_ and arg_514_1.time_ <= var_517_29 + arg_517_0 then
				arg_514_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_517_30 = 0
			local var_517_31 = 0.275

			if var_517_30 < arg_514_1.time_ and arg_514_1.time_ <= var_517_30 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_32 = arg_514_1:FormatText(StoryNameCfg[67].name)

				arg_514_1.leftNameTxt_.text = var_517_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_33 = arg_514_1:GetWordFromCfg(322192125)
				local var_517_34 = arg_514_1:FormatText(var_517_33.content)

				arg_514_1.text_.text = var_517_34

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_35 = 11
				local var_517_36 = utf8.len(var_517_34)
				local var_517_37 = var_517_35 <= 0 and var_517_31 or var_517_31 * (var_517_36 / var_517_35)

				if var_517_37 > 0 and var_517_31 < var_517_37 then
					arg_514_1.talkMaxDuration = var_517_37

					if var_517_37 + var_517_30 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_37 + var_517_30
					end
				end

				arg_514_1.text_.text = var_517_34
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192125", "story_v_out_322192.awb") ~= 0 then
					local var_517_38 = manager.audio:GetVoiceLength("story_v_out_322192", "322192125", "story_v_out_322192.awb") / 1000

					if var_517_38 + var_517_30 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_38 + var_517_30
					end

					if var_517_33.prefab_name ~= "" and arg_514_1.actors_[var_517_33.prefab_name] ~= nil then
						local var_517_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_33.prefab_name].transform, "story_v_out_322192", "322192125", "story_v_out_322192.awb")

						arg_514_1:RecordAudio("322192125", var_517_39)
						arg_514_1:RecordAudio("322192125", var_517_39)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_322192", "322192125", "story_v_out_322192.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_322192", "322192125", "story_v_out_322192.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_40 = math.max(var_517_31, arg_514_1.talkMaxDuration)

			if var_517_30 <= arg_514_1.time_ and arg_514_1.time_ < var_517_30 + var_517_40 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_30) / var_517_40

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_30 + var_517_40 and arg_514_1.time_ < var_517_30 + var_517_40 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play322192126 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 322192126
		arg_518_1.duration_ = 8.03

		local var_518_0 = {
			zh = 7.4,
			ja = 8.033
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play322192127(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = arg_518_1.actors_["10131ui_story"]
			local var_521_1 = 0

			if var_521_1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.characterEffect10131ui_story == nil then
				arg_518_1.var_.characterEffect10131ui_story = var_521_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_2 = 0.200000002980232

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_2 and not isNil(var_521_0) then
				local var_521_3 = (arg_518_1.time_ - var_521_1) / var_521_2

				if arg_518_1.var_.characterEffect10131ui_story and not isNil(var_521_0) then
					arg_518_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_518_1.time_ >= var_521_1 + var_521_2 and arg_518_1.time_ < var_521_1 + var_521_2 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.characterEffect10131ui_story then
				arg_518_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_521_4 = arg_518_1.actors_["1111ui_story"]
			local var_521_5 = 0

			if var_521_5 < arg_518_1.time_ and arg_518_1.time_ <= var_521_5 + arg_521_0 and not isNil(var_521_4) and arg_518_1.var_.characterEffect1111ui_story == nil then
				arg_518_1.var_.characterEffect1111ui_story = var_521_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_6 = 0.200000002980232

			if var_521_5 <= arg_518_1.time_ and arg_518_1.time_ < var_521_5 + var_521_6 and not isNil(var_521_4) then
				local var_521_7 = (arg_518_1.time_ - var_521_5) / var_521_6

				if arg_518_1.var_.characterEffect1111ui_story and not isNil(var_521_4) then
					local var_521_8 = Mathf.Lerp(0, 0.5, var_521_7)

					arg_518_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1111ui_story.fillRatio = var_521_8
				end
			end

			if arg_518_1.time_ >= var_521_5 + var_521_6 and arg_518_1.time_ < var_521_5 + var_521_6 + arg_521_0 and not isNil(var_521_4) and arg_518_1.var_.characterEffect1111ui_story then
				local var_521_9 = 0.5

				arg_518_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1111ui_story.fillRatio = var_521_9
			end

			local var_521_10 = 0
			local var_521_11 = 0.925

			if var_521_10 < arg_518_1.time_ and arg_518_1.time_ <= var_521_10 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_12 = arg_518_1:FormatText(StoryNameCfg[1178].name)

				arg_518_1.leftNameTxt_.text = var_521_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_13 = arg_518_1:GetWordFromCfg(322192126)
				local var_521_14 = arg_518_1:FormatText(var_521_13.content)

				arg_518_1.text_.text = var_521_14

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_15 = 37
				local var_521_16 = utf8.len(var_521_14)
				local var_521_17 = var_521_15 <= 0 and var_521_11 or var_521_11 * (var_521_16 / var_521_15)

				if var_521_17 > 0 and var_521_11 < var_521_17 then
					arg_518_1.talkMaxDuration = var_521_17

					if var_521_17 + var_521_10 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_17 + var_521_10
					end
				end

				arg_518_1.text_.text = var_521_14
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192126", "story_v_out_322192.awb") ~= 0 then
					local var_521_18 = manager.audio:GetVoiceLength("story_v_out_322192", "322192126", "story_v_out_322192.awb") / 1000

					if var_521_18 + var_521_10 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_18 + var_521_10
					end

					if var_521_13.prefab_name ~= "" and arg_518_1.actors_[var_521_13.prefab_name] ~= nil then
						local var_521_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_13.prefab_name].transform, "story_v_out_322192", "322192126", "story_v_out_322192.awb")

						arg_518_1:RecordAudio("322192126", var_521_19)
						arg_518_1:RecordAudio("322192126", var_521_19)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_322192", "322192126", "story_v_out_322192.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_322192", "322192126", "story_v_out_322192.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_20 = math.max(var_521_11, arg_518_1.talkMaxDuration)

			if var_521_10 <= arg_518_1.time_ and arg_518_1.time_ < var_521_10 + var_521_20 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_10) / var_521_20

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_10 + var_521_20 and arg_518_1.time_ < var_521_10 + var_521_20 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play322192127 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 322192127
		arg_522_1.duration_ = 8.8

		local var_522_0 = {
			zh = 5.5,
			ja = 8.8
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play322192128(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = 0
			local var_525_1 = 0.675

			if var_525_0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_0 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_2 = arg_522_1:FormatText(StoryNameCfg[1178].name)

				arg_522_1.leftNameTxt_.text = var_525_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_3 = arg_522_1:GetWordFromCfg(322192127)
				local var_525_4 = arg_522_1:FormatText(var_525_3.content)

				arg_522_1.text_.text = var_525_4

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_5 = 27
				local var_525_6 = utf8.len(var_525_4)
				local var_525_7 = var_525_5 <= 0 and var_525_1 or var_525_1 * (var_525_6 / var_525_5)

				if var_525_7 > 0 and var_525_1 < var_525_7 then
					arg_522_1.talkMaxDuration = var_525_7

					if var_525_7 + var_525_0 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_7 + var_525_0
					end
				end

				arg_522_1.text_.text = var_525_4
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192127", "story_v_out_322192.awb") ~= 0 then
					local var_525_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192127", "story_v_out_322192.awb") / 1000

					if var_525_8 + var_525_0 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_8 + var_525_0
					end

					if var_525_3.prefab_name ~= "" and arg_522_1.actors_[var_525_3.prefab_name] ~= nil then
						local var_525_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_3.prefab_name].transform, "story_v_out_322192", "322192127", "story_v_out_322192.awb")

						arg_522_1:RecordAudio("322192127", var_525_9)
						arg_522_1:RecordAudio("322192127", var_525_9)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_322192", "322192127", "story_v_out_322192.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_322192", "322192127", "story_v_out_322192.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_10 = math.max(var_525_1, arg_522_1.talkMaxDuration)

			if var_525_0 <= arg_522_1.time_ and arg_522_1.time_ < var_525_0 + var_525_10 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_0) / var_525_10

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_0 + var_525_10 and arg_522_1.time_ < var_525_0 + var_525_10 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play322192128 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 322192128
		arg_526_1.duration_ = 11.87

		local var_526_0 = {
			zh = 6.5,
			ja = 11.866
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play322192129(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = 0
			local var_529_1 = 0.775

			if var_529_0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_0 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_2 = arg_526_1:FormatText(StoryNameCfg[1178].name)

				arg_526_1.leftNameTxt_.text = var_529_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_3 = arg_526_1:GetWordFromCfg(322192128)
				local var_529_4 = arg_526_1:FormatText(var_529_3.content)

				arg_526_1.text_.text = var_529_4

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_5 = 32
				local var_529_6 = utf8.len(var_529_4)
				local var_529_7 = var_529_5 <= 0 and var_529_1 or var_529_1 * (var_529_6 / var_529_5)

				if var_529_7 > 0 and var_529_1 < var_529_7 then
					arg_526_1.talkMaxDuration = var_529_7

					if var_529_7 + var_529_0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_7 + var_529_0
					end
				end

				arg_526_1.text_.text = var_529_4
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192128", "story_v_out_322192.awb") ~= 0 then
					local var_529_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192128", "story_v_out_322192.awb") / 1000

					if var_529_8 + var_529_0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_8 + var_529_0
					end

					if var_529_3.prefab_name ~= "" and arg_526_1.actors_[var_529_3.prefab_name] ~= nil then
						local var_529_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_3.prefab_name].transform, "story_v_out_322192", "322192128", "story_v_out_322192.awb")

						arg_526_1:RecordAudio("322192128", var_529_9)
						arg_526_1:RecordAudio("322192128", var_529_9)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_out_322192", "322192128", "story_v_out_322192.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_out_322192", "322192128", "story_v_out_322192.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_10 = math.max(var_529_1, arg_526_1.talkMaxDuration)

			if var_529_0 <= arg_526_1.time_ and arg_526_1.time_ < var_529_0 + var_529_10 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_0) / var_529_10

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_0 + var_529_10 and arg_526_1.time_ < var_529_0 + var_529_10 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play322192129 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 322192129
		arg_530_1.duration_ = 4.63

		local var_530_0 = {
			zh = 2.3,
			ja = 4.633
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play322192130(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = arg_530_1.actors_["1111ui_story"]
			local var_533_1 = 0

			if var_533_1 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.characterEffect1111ui_story == nil then
				arg_530_1.var_.characterEffect1111ui_story = var_533_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_2 = 0.200000002980232

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_2 and not isNil(var_533_0) then
				local var_533_3 = (arg_530_1.time_ - var_533_1) / var_533_2

				if arg_530_1.var_.characterEffect1111ui_story and not isNil(var_533_0) then
					arg_530_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_530_1.time_ >= var_533_1 + var_533_2 and arg_530_1.time_ < var_533_1 + var_533_2 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.characterEffect1111ui_story then
				arg_530_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_533_4 = arg_530_1.actors_["10131ui_story"]
			local var_533_5 = 0

			if var_533_5 < arg_530_1.time_ and arg_530_1.time_ <= var_533_5 + arg_533_0 and not isNil(var_533_4) and arg_530_1.var_.characterEffect10131ui_story == nil then
				arg_530_1.var_.characterEffect10131ui_story = var_533_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_6 = 0.200000002980232

			if var_533_5 <= arg_530_1.time_ and arg_530_1.time_ < var_533_5 + var_533_6 and not isNil(var_533_4) then
				local var_533_7 = (arg_530_1.time_ - var_533_5) / var_533_6

				if arg_530_1.var_.characterEffect10131ui_story and not isNil(var_533_4) then
					local var_533_8 = Mathf.Lerp(0, 0.5, var_533_7)

					arg_530_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_530_1.var_.characterEffect10131ui_story.fillRatio = var_533_8
				end
			end

			if arg_530_1.time_ >= var_533_5 + var_533_6 and arg_530_1.time_ < var_533_5 + var_533_6 + arg_533_0 and not isNil(var_533_4) and arg_530_1.var_.characterEffect10131ui_story then
				local var_533_9 = 0.5

				arg_530_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_530_1.var_.characterEffect10131ui_story.fillRatio = var_533_9
			end

			local var_533_10 = 0

			if var_533_10 < arg_530_1.time_ and arg_530_1.time_ <= var_533_10 + arg_533_0 then
				arg_530_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_533_11 = 0
			local var_533_12 = 0.175

			if var_533_11 < arg_530_1.time_ and arg_530_1.time_ <= var_533_11 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				local var_533_13 = arg_530_1:FormatText(StoryNameCfg[67].name)

				arg_530_1.leftNameTxt_.text = var_533_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_14 = arg_530_1:GetWordFromCfg(322192129)
				local var_533_15 = arg_530_1:FormatText(var_533_14.content)

				arg_530_1.text_.text = var_533_15

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_16 = 7
				local var_533_17 = utf8.len(var_533_15)
				local var_533_18 = var_533_16 <= 0 and var_533_12 or var_533_12 * (var_533_17 / var_533_16)

				if var_533_18 > 0 and var_533_12 < var_533_18 then
					arg_530_1.talkMaxDuration = var_533_18

					if var_533_18 + var_533_11 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_18 + var_533_11
					end
				end

				arg_530_1.text_.text = var_533_15
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192129", "story_v_out_322192.awb") ~= 0 then
					local var_533_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192129", "story_v_out_322192.awb") / 1000

					if var_533_19 + var_533_11 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_19 + var_533_11
					end

					if var_533_14.prefab_name ~= "" and arg_530_1.actors_[var_533_14.prefab_name] ~= nil then
						local var_533_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_14.prefab_name].transform, "story_v_out_322192", "322192129", "story_v_out_322192.awb")

						arg_530_1:RecordAudio("322192129", var_533_20)
						arg_530_1:RecordAudio("322192129", var_533_20)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_322192", "322192129", "story_v_out_322192.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_322192", "322192129", "story_v_out_322192.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_21 = math.max(var_533_12, arg_530_1.talkMaxDuration)

			if var_533_11 <= arg_530_1.time_ and arg_530_1.time_ < var_533_11 + var_533_21 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_11) / var_533_21

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_11 + var_533_21 and arg_530_1.time_ < var_533_11 + var_533_21 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play322192130 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 322192130
		arg_534_1.duration_ = 11.13

		local var_534_0 = {
			zh = 10.633,
			ja = 11.133
		}
		local var_534_1 = manager.audio:GetLocalizationFlag()

		if var_534_0[var_534_1] ~= nil then
			arg_534_1.duration_ = var_534_0[var_534_1]
		end

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play322192131(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = arg_534_1.actors_["10131ui_story"]
			local var_537_1 = 0

			if var_537_1 < arg_534_1.time_ and arg_534_1.time_ <= var_537_1 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.characterEffect10131ui_story == nil then
				arg_534_1.var_.characterEffect10131ui_story = var_537_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_2 = 0.200000002980232

			if var_537_1 <= arg_534_1.time_ and arg_534_1.time_ < var_537_1 + var_537_2 and not isNil(var_537_0) then
				local var_537_3 = (arg_534_1.time_ - var_537_1) / var_537_2

				if arg_534_1.var_.characterEffect10131ui_story and not isNil(var_537_0) then
					arg_534_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_534_1.time_ >= var_537_1 + var_537_2 and arg_534_1.time_ < var_537_1 + var_537_2 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.characterEffect10131ui_story then
				arg_534_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_537_4 = arg_534_1.actors_["1111ui_story"]
			local var_537_5 = 0

			if var_537_5 < arg_534_1.time_ and arg_534_1.time_ <= var_537_5 + arg_537_0 and not isNil(var_537_4) and arg_534_1.var_.characterEffect1111ui_story == nil then
				arg_534_1.var_.characterEffect1111ui_story = var_537_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_6 = 0.200000002980232

			if var_537_5 <= arg_534_1.time_ and arg_534_1.time_ < var_537_5 + var_537_6 and not isNil(var_537_4) then
				local var_537_7 = (arg_534_1.time_ - var_537_5) / var_537_6

				if arg_534_1.var_.characterEffect1111ui_story and not isNil(var_537_4) then
					local var_537_8 = Mathf.Lerp(0, 0.5, var_537_7)

					arg_534_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_534_1.var_.characterEffect1111ui_story.fillRatio = var_537_8
				end
			end

			if arg_534_1.time_ >= var_537_5 + var_537_6 and arg_534_1.time_ < var_537_5 + var_537_6 + arg_537_0 and not isNil(var_537_4) and arg_534_1.var_.characterEffect1111ui_story then
				local var_537_9 = 0.5

				arg_534_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_534_1.var_.characterEffect1111ui_story.fillRatio = var_537_9
			end

			local var_537_10 = 0
			local var_537_11 = 1.125

			if var_537_10 < arg_534_1.time_ and arg_534_1.time_ <= var_537_10 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				local var_537_12 = arg_534_1:FormatText(StoryNameCfg[1178].name)

				arg_534_1.leftNameTxt_.text = var_537_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_13 = arg_534_1:GetWordFromCfg(322192130)
				local var_537_14 = arg_534_1:FormatText(var_537_13.content)

				arg_534_1.text_.text = var_537_14

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_15 = 45
				local var_537_16 = utf8.len(var_537_14)
				local var_537_17 = var_537_15 <= 0 and var_537_11 or var_537_11 * (var_537_16 / var_537_15)

				if var_537_17 > 0 and var_537_11 < var_537_17 then
					arg_534_1.talkMaxDuration = var_537_17

					if var_537_17 + var_537_10 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_17 + var_537_10
					end
				end

				arg_534_1.text_.text = var_537_14
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192130", "story_v_out_322192.awb") ~= 0 then
					local var_537_18 = manager.audio:GetVoiceLength("story_v_out_322192", "322192130", "story_v_out_322192.awb") / 1000

					if var_537_18 + var_537_10 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_18 + var_537_10
					end

					if var_537_13.prefab_name ~= "" and arg_534_1.actors_[var_537_13.prefab_name] ~= nil then
						local var_537_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_13.prefab_name].transform, "story_v_out_322192", "322192130", "story_v_out_322192.awb")

						arg_534_1:RecordAudio("322192130", var_537_19)
						arg_534_1:RecordAudio("322192130", var_537_19)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_out_322192", "322192130", "story_v_out_322192.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_out_322192", "322192130", "story_v_out_322192.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_20 = math.max(var_537_11, arg_534_1.talkMaxDuration)

			if var_537_10 <= arg_534_1.time_ and arg_534_1.time_ < var_537_10 + var_537_20 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_10) / var_537_20

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_10 + var_537_20 and arg_534_1.time_ < var_537_10 + var_537_20 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play322192131 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 322192131
		arg_538_1.duration_ = 12.6

		local var_538_0 = {
			zh = 8.233,
			ja = 12.6
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play322192132(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = arg_538_1.actors_["1043ui_story"]
			local var_541_1 = 0

			if var_541_1 < arg_538_1.time_ and arg_538_1.time_ <= var_541_1 + arg_541_0 and not isNil(var_541_0) and arg_538_1.var_.characterEffect1043ui_story == nil then
				arg_538_1.var_.characterEffect1043ui_story = var_541_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_2 = 0.200000002980232

			if var_541_1 <= arg_538_1.time_ and arg_538_1.time_ < var_541_1 + var_541_2 and not isNil(var_541_0) then
				local var_541_3 = (arg_538_1.time_ - var_541_1) / var_541_2

				if arg_538_1.var_.characterEffect1043ui_story and not isNil(var_541_0) then
					arg_538_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_538_1.time_ >= var_541_1 + var_541_2 and arg_538_1.time_ < var_541_1 + var_541_2 + arg_541_0 and not isNil(var_541_0) and arg_538_1.var_.characterEffect1043ui_story then
				arg_538_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_541_4 = arg_538_1.actors_["10131ui_story"]
			local var_541_5 = 0

			if var_541_5 < arg_538_1.time_ and arg_538_1.time_ <= var_541_5 + arg_541_0 and not isNil(var_541_4) and arg_538_1.var_.characterEffect10131ui_story == nil then
				arg_538_1.var_.characterEffect10131ui_story = var_541_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_6 = 0.200000002980232

			if var_541_5 <= arg_538_1.time_ and arg_538_1.time_ < var_541_5 + var_541_6 and not isNil(var_541_4) then
				local var_541_7 = (arg_538_1.time_ - var_541_5) / var_541_6

				if arg_538_1.var_.characterEffect10131ui_story and not isNil(var_541_4) then
					local var_541_8 = Mathf.Lerp(0, 0.5, var_541_7)

					arg_538_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_538_1.var_.characterEffect10131ui_story.fillRatio = var_541_8
				end
			end

			if arg_538_1.time_ >= var_541_5 + var_541_6 and arg_538_1.time_ < var_541_5 + var_541_6 + arg_541_0 and not isNil(var_541_4) and arg_538_1.var_.characterEffect10131ui_story then
				local var_541_9 = 0.5

				arg_538_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_538_1.var_.characterEffect10131ui_story.fillRatio = var_541_9
			end

			local var_541_10 = 0
			local var_541_11 = 0.925

			if var_541_10 < arg_538_1.time_ and arg_538_1.time_ <= var_541_10 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				local var_541_12 = arg_538_1:FormatText(StoryNameCfg[1156].name)

				arg_538_1.leftNameTxt_.text = var_541_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, true)
				arg_538_1.iconController_:SetSelectedState("hero")

				arg_538_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_538_1.callingController_:SetSelectedState("normal")

				arg_538_1.keyicon_.color = Color.New(1, 1, 1)
				arg_538_1.icon_.color = Color.New(1, 1, 1)

				local var_541_13 = arg_538_1:GetWordFromCfg(322192131)
				local var_541_14 = arg_538_1:FormatText(var_541_13.content)

				arg_538_1.text_.text = var_541_14

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_15 = 37
				local var_541_16 = utf8.len(var_541_14)
				local var_541_17 = var_541_15 <= 0 and var_541_11 or var_541_11 * (var_541_16 / var_541_15)

				if var_541_17 > 0 and var_541_11 < var_541_17 then
					arg_538_1.talkMaxDuration = var_541_17

					if var_541_17 + var_541_10 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_17 + var_541_10
					end
				end

				arg_538_1.text_.text = var_541_14
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192131", "story_v_out_322192.awb") ~= 0 then
					local var_541_18 = manager.audio:GetVoiceLength("story_v_out_322192", "322192131", "story_v_out_322192.awb") / 1000

					if var_541_18 + var_541_10 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_18 + var_541_10
					end

					if var_541_13.prefab_name ~= "" and arg_538_1.actors_[var_541_13.prefab_name] ~= nil then
						local var_541_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_13.prefab_name].transform, "story_v_out_322192", "322192131", "story_v_out_322192.awb")

						arg_538_1:RecordAudio("322192131", var_541_19)
						arg_538_1:RecordAudio("322192131", var_541_19)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_out_322192", "322192131", "story_v_out_322192.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_out_322192", "322192131", "story_v_out_322192.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_20 = math.max(var_541_11, arg_538_1.talkMaxDuration)

			if var_541_10 <= arg_538_1.time_ and arg_538_1.time_ < var_541_10 + var_541_20 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_10) / var_541_20

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_10 + var_541_20 and arg_538_1.time_ < var_541_10 + var_541_20 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play322192132 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 322192132
		arg_542_1.duration_ = 8.5

		local var_542_0 = {
			zh = 7.733,
			ja = 8.5
		}
		local var_542_1 = manager.audio:GetLocalizationFlag()

		if var_542_0[var_542_1] ~= nil then
			arg_542_1.duration_ = var_542_0[var_542_1]
		end

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play322192133(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = arg_542_1.actors_["1111ui_story"].transform
			local var_545_1 = 0

			if var_545_1 < arg_542_1.time_ and arg_542_1.time_ <= var_545_1 + arg_545_0 then
				arg_542_1.var_.moveOldPos1111ui_story = var_545_0.localPosition
			end

			local var_545_2 = 0.001

			if var_545_1 <= arg_542_1.time_ and arg_542_1.time_ < var_545_1 + var_545_2 then
				local var_545_3 = (arg_542_1.time_ - var_545_1) / var_545_2
				local var_545_4 = Vector3.New(0.7, -0.87, -5.7)

				var_545_0.localPosition = Vector3.Lerp(arg_542_1.var_.moveOldPos1111ui_story, var_545_4, var_545_3)

				local var_545_5 = manager.ui.mainCamera.transform.position - var_545_0.position

				var_545_0.forward = Vector3.New(var_545_5.x, var_545_5.y, var_545_5.z)

				local var_545_6 = var_545_0.localEulerAngles

				var_545_6.z = 0
				var_545_6.x = 0
				var_545_0.localEulerAngles = var_545_6
			end

			if arg_542_1.time_ >= var_545_1 + var_545_2 and arg_542_1.time_ < var_545_1 + var_545_2 + arg_545_0 then
				var_545_0.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_545_7 = manager.ui.mainCamera.transform.position - var_545_0.position

				var_545_0.forward = Vector3.New(var_545_7.x, var_545_7.y, var_545_7.z)

				local var_545_8 = var_545_0.localEulerAngles

				var_545_8.z = 0
				var_545_8.x = 0
				var_545_0.localEulerAngles = var_545_8
			end

			local var_545_9 = arg_542_1.actors_["1111ui_story"]
			local var_545_10 = 0

			if var_545_10 < arg_542_1.time_ and arg_542_1.time_ <= var_545_10 + arg_545_0 and not isNil(var_545_9) and arg_542_1.var_.characterEffect1111ui_story == nil then
				arg_542_1.var_.characterEffect1111ui_story = var_545_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_11 = 0.200000002980232

			if var_545_10 <= arg_542_1.time_ and arg_542_1.time_ < var_545_10 + var_545_11 and not isNil(var_545_9) then
				local var_545_12 = (arg_542_1.time_ - var_545_10) / var_545_11

				if arg_542_1.var_.characterEffect1111ui_story and not isNil(var_545_9) then
					arg_542_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_542_1.time_ >= var_545_10 + var_545_11 and arg_542_1.time_ < var_545_10 + var_545_11 + arg_545_0 and not isNil(var_545_9) and arg_542_1.var_.characterEffect1111ui_story then
				arg_542_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_545_13 = arg_542_1.actors_["1043ui_story"]
			local var_545_14 = 0

			if var_545_14 < arg_542_1.time_ and arg_542_1.time_ <= var_545_14 + arg_545_0 and not isNil(var_545_13) and arg_542_1.var_.characterEffect1043ui_story == nil then
				arg_542_1.var_.characterEffect1043ui_story = var_545_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_15 = 0.200000002980232

			if var_545_14 <= arg_542_1.time_ and arg_542_1.time_ < var_545_14 + var_545_15 and not isNil(var_545_13) then
				local var_545_16 = (arg_542_1.time_ - var_545_14) / var_545_15

				if arg_542_1.var_.characterEffect1043ui_story and not isNil(var_545_13) then
					local var_545_17 = Mathf.Lerp(0, 0.5, var_545_16)

					arg_542_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_542_1.var_.characterEffect1043ui_story.fillRatio = var_545_17
				end
			end

			if arg_542_1.time_ >= var_545_14 + var_545_15 and arg_542_1.time_ < var_545_14 + var_545_15 + arg_545_0 and not isNil(var_545_13) and arg_542_1.var_.characterEffect1043ui_story then
				local var_545_18 = 0.5

				arg_542_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_542_1.var_.characterEffect1043ui_story.fillRatio = var_545_18
			end

			local var_545_19 = 0

			if var_545_19 < arg_542_1.time_ and arg_542_1.time_ <= var_545_19 + arg_545_0 then
				arg_542_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			local var_545_20 = 0
			local var_545_21 = 0.475

			if var_545_20 < arg_542_1.time_ and arg_542_1.time_ <= var_545_20 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				local var_545_22 = arg_542_1:FormatText(StoryNameCfg[67].name)

				arg_542_1.leftNameTxt_.text = var_545_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_23 = arg_542_1:GetWordFromCfg(322192132)
				local var_545_24 = arg_542_1:FormatText(var_545_23.content)

				arg_542_1.text_.text = var_545_24

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_25 = 19
				local var_545_26 = utf8.len(var_545_24)
				local var_545_27 = var_545_25 <= 0 and var_545_21 or var_545_21 * (var_545_26 / var_545_25)

				if var_545_27 > 0 and var_545_21 < var_545_27 then
					arg_542_1.talkMaxDuration = var_545_27

					if var_545_27 + var_545_20 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_27 + var_545_20
					end
				end

				arg_542_1.text_.text = var_545_24
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192132", "story_v_out_322192.awb") ~= 0 then
					local var_545_28 = manager.audio:GetVoiceLength("story_v_out_322192", "322192132", "story_v_out_322192.awb") / 1000

					if var_545_28 + var_545_20 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_28 + var_545_20
					end

					if var_545_23.prefab_name ~= "" and arg_542_1.actors_[var_545_23.prefab_name] ~= nil then
						local var_545_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_542_1.actors_[var_545_23.prefab_name].transform, "story_v_out_322192", "322192132", "story_v_out_322192.awb")

						arg_542_1:RecordAudio("322192132", var_545_29)
						arg_542_1:RecordAudio("322192132", var_545_29)
					else
						arg_542_1:AudioAction("play", "voice", "story_v_out_322192", "322192132", "story_v_out_322192.awb")
					end

					arg_542_1:RecordHistoryTalkVoice("story_v_out_322192", "322192132", "story_v_out_322192.awb")
				end

				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_30 = math.max(var_545_21, arg_542_1.talkMaxDuration)

			if var_545_20 <= arg_542_1.time_ and arg_542_1.time_ < var_545_20 + var_545_30 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_20) / var_545_30

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_20 + var_545_30 and arg_542_1.time_ < var_545_20 + var_545_30 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_542_1:InitPlayNodeList()
	end,
	Play322192133 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 322192133
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play322192134(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = arg_546_1.actors_["1111ui_story"].transform
			local var_549_1 = 0

			if var_549_1 < arg_546_1.time_ and arg_546_1.time_ <= var_549_1 + arg_549_0 then
				arg_546_1.var_.moveOldPos1111ui_story = var_549_0.localPosition
			end

			local var_549_2 = 0.001

			if var_549_1 <= arg_546_1.time_ and arg_546_1.time_ < var_549_1 + var_549_2 then
				local var_549_3 = (arg_546_1.time_ - var_549_1) / var_549_2
				local var_549_4 = Vector3.New(0, 100, 0)

				var_549_0.localPosition = Vector3.Lerp(arg_546_1.var_.moveOldPos1111ui_story, var_549_4, var_549_3)

				local var_549_5 = manager.ui.mainCamera.transform.position - var_549_0.position

				var_549_0.forward = Vector3.New(var_549_5.x, var_549_5.y, var_549_5.z)

				local var_549_6 = var_549_0.localEulerAngles

				var_549_6.z = 0
				var_549_6.x = 0
				var_549_0.localEulerAngles = var_549_6
			end

			if arg_546_1.time_ >= var_549_1 + var_549_2 and arg_546_1.time_ < var_549_1 + var_549_2 + arg_549_0 then
				var_549_0.localPosition = Vector3.New(0, 100, 0)

				local var_549_7 = manager.ui.mainCamera.transform.position - var_549_0.position

				var_549_0.forward = Vector3.New(var_549_7.x, var_549_7.y, var_549_7.z)

				local var_549_8 = var_549_0.localEulerAngles

				var_549_8.z = 0
				var_549_8.x = 0
				var_549_0.localEulerAngles = var_549_8
			end

			local var_549_9 = arg_546_1.actors_["10131ui_story"].transform
			local var_549_10 = 0

			if var_549_10 < arg_546_1.time_ and arg_546_1.time_ <= var_549_10 + arg_549_0 then
				arg_546_1.var_.moveOldPos10131ui_story = var_549_9.localPosition
			end

			local var_549_11 = 0.001

			if var_549_10 <= arg_546_1.time_ and arg_546_1.time_ < var_549_10 + var_549_11 then
				local var_549_12 = (arg_546_1.time_ - var_549_10) / var_549_11
				local var_549_13 = Vector3.New(0, 100, 0)

				var_549_9.localPosition = Vector3.Lerp(arg_546_1.var_.moveOldPos10131ui_story, var_549_13, var_549_12)

				local var_549_14 = manager.ui.mainCamera.transform.position - var_549_9.position

				var_549_9.forward = Vector3.New(var_549_14.x, var_549_14.y, var_549_14.z)

				local var_549_15 = var_549_9.localEulerAngles

				var_549_15.z = 0
				var_549_15.x = 0
				var_549_9.localEulerAngles = var_549_15
			end

			if arg_546_1.time_ >= var_549_10 + var_549_11 and arg_546_1.time_ < var_549_10 + var_549_11 + arg_549_0 then
				var_549_9.localPosition = Vector3.New(0, 100, 0)

				local var_549_16 = manager.ui.mainCamera.transform.position - var_549_9.position

				var_549_9.forward = Vector3.New(var_549_16.x, var_549_16.y, var_549_16.z)

				local var_549_17 = var_549_9.localEulerAngles

				var_549_17.z = 0
				var_549_17.x = 0
				var_549_9.localEulerAngles = var_549_17
			end

			local var_549_18 = 0.666666666666667
			local var_549_19 = 1

			if var_549_18 < arg_546_1.time_ and arg_546_1.time_ <= var_549_18 + arg_549_0 then
				local var_549_20 = "play"
				local var_549_21 = "effect"

				arg_546_1:AudioAction(var_549_20, var_549_21, "se_story_140", "se_story_140_drop02", "")
			end

			local var_549_22 = 0
			local var_549_23 = 0.95

			if var_549_22 < arg_546_1.time_ and arg_546_1.time_ <= var_549_22 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, false)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_24 = arg_546_1:GetWordFromCfg(322192133)
				local var_549_25 = arg_546_1:FormatText(var_549_24.content)

				arg_546_1.text_.text = var_549_25

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_26 = 38
				local var_549_27 = utf8.len(var_549_25)
				local var_549_28 = var_549_26 <= 0 and var_549_23 or var_549_23 * (var_549_27 / var_549_26)

				if var_549_28 > 0 and var_549_23 < var_549_28 then
					arg_546_1.talkMaxDuration = var_549_28

					if var_549_28 + var_549_22 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_28 + var_549_22
					end
				end

				arg_546_1.text_.text = var_549_25
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_29 = math.max(var_549_23, arg_546_1.talkMaxDuration)

			if var_549_22 <= arg_546_1.time_ and arg_546_1.time_ < var_549_22 + var_549_29 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_22) / var_549_29

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_22 + var_549_29 and arg_546_1.time_ < var_549_22 + var_549_29 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_546_1:InitPlayNodeList()
	end,
	Play322192134 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 322192134
		arg_550_1.duration_ = 7.43

		local var_550_0 = {
			zh = 7.433,
			ja = 7.166
		}
		local var_550_1 = manager.audio:GetLocalizationFlag()

		if var_550_0[var_550_1] ~= nil then
			arg_550_1.duration_ = var_550_0[var_550_1]
		end

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play322192135(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = arg_550_1.actors_["1111ui_story"].transform
			local var_553_1 = 0

			if var_553_1 < arg_550_1.time_ and arg_550_1.time_ <= var_553_1 + arg_553_0 then
				arg_550_1.var_.moveOldPos1111ui_story = var_553_0.localPosition
			end

			local var_553_2 = 0.001

			if var_553_1 <= arg_550_1.time_ and arg_550_1.time_ < var_553_1 + var_553_2 then
				local var_553_3 = (arg_550_1.time_ - var_553_1) / var_553_2
				local var_553_4 = Vector3.New(0, -0.87, -5.7)

				var_553_0.localPosition = Vector3.Lerp(arg_550_1.var_.moveOldPos1111ui_story, var_553_4, var_553_3)

				local var_553_5 = manager.ui.mainCamera.transform.position - var_553_0.position

				var_553_0.forward = Vector3.New(var_553_5.x, var_553_5.y, var_553_5.z)

				local var_553_6 = var_553_0.localEulerAngles

				var_553_6.z = 0
				var_553_6.x = 0
				var_553_0.localEulerAngles = var_553_6
			end

			if arg_550_1.time_ >= var_553_1 + var_553_2 and arg_550_1.time_ < var_553_1 + var_553_2 + arg_553_0 then
				var_553_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_553_7 = manager.ui.mainCamera.transform.position - var_553_0.position

				var_553_0.forward = Vector3.New(var_553_7.x, var_553_7.y, var_553_7.z)

				local var_553_8 = var_553_0.localEulerAngles

				var_553_8.z = 0
				var_553_8.x = 0
				var_553_0.localEulerAngles = var_553_8
			end

			local var_553_9 = arg_550_1.actors_["1111ui_story"]
			local var_553_10 = 0

			if var_553_10 < arg_550_1.time_ and arg_550_1.time_ <= var_553_10 + arg_553_0 and not isNil(var_553_9) and arg_550_1.var_.characterEffect1111ui_story == nil then
				arg_550_1.var_.characterEffect1111ui_story = var_553_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_553_11 = 0.200000002980232

			if var_553_10 <= arg_550_1.time_ and arg_550_1.time_ < var_553_10 + var_553_11 and not isNil(var_553_9) then
				local var_553_12 = (arg_550_1.time_ - var_553_10) / var_553_11

				if arg_550_1.var_.characterEffect1111ui_story and not isNil(var_553_9) then
					arg_550_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_550_1.time_ >= var_553_10 + var_553_11 and arg_550_1.time_ < var_553_10 + var_553_11 + arg_553_0 and not isNil(var_553_9) and arg_550_1.var_.characterEffect1111ui_story then
				arg_550_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_553_13 = 0

			if var_553_13 < arg_550_1.time_ and arg_550_1.time_ <= var_553_13 + arg_553_0 then
				arg_550_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_2")
			end

			local var_553_14 = 0
			local var_553_15 = 0.775

			if var_553_14 < arg_550_1.time_ and arg_550_1.time_ <= var_553_14 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				local var_553_16 = arg_550_1:FormatText(StoryNameCfg[67].name)

				arg_550_1.leftNameTxt_.text = var_553_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_17 = arg_550_1:GetWordFromCfg(322192134)
				local var_553_18 = arg_550_1:FormatText(var_553_17.content)

				arg_550_1.text_.text = var_553_18

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_19 = 31
				local var_553_20 = utf8.len(var_553_18)
				local var_553_21 = var_553_19 <= 0 and var_553_15 or var_553_15 * (var_553_20 / var_553_19)

				if var_553_21 > 0 and var_553_15 < var_553_21 then
					arg_550_1.talkMaxDuration = var_553_21

					if var_553_21 + var_553_14 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_21 + var_553_14
					end
				end

				arg_550_1.text_.text = var_553_18
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192134", "story_v_out_322192.awb") ~= 0 then
					local var_553_22 = manager.audio:GetVoiceLength("story_v_out_322192", "322192134", "story_v_out_322192.awb") / 1000

					if var_553_22 + var_553_14 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_22 + var_553_14
					end

					if var_553_17.prefab_name ~= "" and arg_550_1.actors_[var_553_17.prefab_name] ~= nil then
						local var_553_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_550_1.actors_[var_553_17.prefab_name].transform, "story_v_out_322192", "322192134", "story_v_out_322192.awb")

						arg_550_1:RecordAudio("322192134", var_553_23)
						arg_550_1:RecordAudio("322192134", var_553_23)
					else
						arg_550_1:AudioAction("play", "voice", "story_v_out_322192", "322192134", "story_v_out_322192.awb")
					end

					arg_550_1:RecordHistoryTalkVoice("story_v_out_322192", "322192134", "story_v_out_322192.awb")
				end

				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_24 = math.max(var_553_15, arg_550_1.talkMaxDuration)

			if var_553_14 <= arg_550_1.time_ and arg_550_1.time_ < var_553_14 + var_553_24 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_14) / var_553_24

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_14 + var_553_24 and arg_550_1.time_ < var_553_14 + var_553_24 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_550_1:InitPlayNodeList()
	end,
	Play322192135 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 322192135
		arg_554_1.duration_ = 4.37

		local var_554_0 = {
			zh = 4.366,
			ja = 4.333
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play322192136(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0
			local var_557_1 = 0.325

			if var_557_0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				local var_557_2 = arg_554_1:FormatText(StoryNameCfg[67].name)

				arg_554_1.leftNameTxt_.text = var_557_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_3 = arg_554_1:GetWordFromCfg(322192135)
				local var_557_4 = arg_554_1:FormatText(var_557_3.content)

				arg_554_1.text_.text = var_557_4

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_5 = 13
				local var_557_6 = utf8.len(var_557_4)
				local var_557_7 = var_557_5 <= 0 and var_557_1 or var_557_1 * (var_557_6 / var_557_5)

				if var_557_7 > 0 and var_557_1 < var_557_7 then
					arg_554_1.talkMaxDuration = var_557_7

					if var_557_7 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_7 + var_557_0
					end
				end

				arg_554_1.text_.text = var_557_4
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192135", "story_v_out_322192.awb") ~= 0 then
					local var_557_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192135", "story_v_out_322192.awb") / 1000

					if var_557_8 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_8 + var_557_0
					end

					if var_557_3.prefab_name ~= "" and arg_554_1.actors_[var_557_3.prefab_name] ~= nil then
						local var_557_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_3.prefab_name].transform, "story_v_out_322192", "322192135", "story_v_out_322192.awb")

						arg_554_1:RecordAudio("322192135", var_557_9)
						arg_554_1:RecordAudio("322192135", var_557_9)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_322192", "322192135", "story_v_out_322192.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_322192", "322192135", "story_v_out_322192.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_10 = math.max(var_557_1, arg_554_1.talkMaxDuration)

			if var_557_0 <= arg_554_1.time_ and arg_554_1.time_ < var_557_0 + var_557_10 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_0) / var_557_10

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_0 + var_557_10 and arg_554_1.time_ < var_557_0 + var_557_10 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play322192136 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 322192136
		arg_558_1.duration_ = 14.23

		local var_558_0 = {
			zh = 10.433,
			ja = 14.233
		}
		local var_558_1 = manager.audio:GetLocalizationFlag()

		if var_558_0[var_558_1] ~= nil then
			arg_558_1.duration_ = var_558_0[var_558_1]
		end

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play322192137(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = arg_558_1.actors_["10131ui_story"].transform
			local var_561_1 = 0

			if var_561_1 < arg_558_1.time_ and arg_558_1.time_ <= var_561_1 + arg_561_0 then
				arg_558_1.var_.moveOldPos10131ui_story = var_561_0.localPosition
			end

			local var_561_2 = 0.001

			if var_561_1 <= arg_558_1.time_ and arg_558_1.time_ < var_561_1 + var_561_2 then
				local var_561_3 = (arg_558_1.time_ - var_561_1) / var_561_2
				local var_561_4 = Vector3.New(-0.78, -0.96, -5.8)

				var_561_0.localPosition = Vector3.Lerp(arg_558_1.var_.moveOldPos10131ui_story, var_561_4, var_561_3)

				local var_561_5 = manager.ui.mainCamera.transform.position - var_561_0.position

				var_561_0.forward = Vector3.New(var_561_5.x, var_561_5.y, var_561_5.z)

				local var_561_6 = var_561_0.localEulerAngles

				var_561_6.z = 0
				var_561_6.x = 0
				var_561_0.localEulerAngles = var_561_6
			end

			if arg_558_1.time_ >= var_561_1 + var_561_2 and arg_558_1.time_ < var_561_1 + var_561_2 + arg_561_0 then
				var_561_0.localPosition = Vector3.New(-0.78, -0.96, -5.8)

				local var_561_7 = manager.ui.mainCamera.transform.position - var_561_0.position

				var_561_0.forward = Vector3.New(var_561_7.x, var_561_7.y, var_561_7.z)

				local var_561_8 = var_561_0.localEulerAngles

				var_561_8.z = 0
				var_561_8.x = 0
				var_561_0.localEulerAngles = var_561_8
			end

			local var_561_9 = arg_558_1.actors_["1111ui_story"].transform
			local var_561_10 = 0

			if var_561_10 < arg_558_1.time_ and arg_558_1.time_ <= var_561_10 + arg_561_0 then
				arg_558_1.var_.moveOldPos1111ui_story = var_561_9.localPosition
			end

			local var_561_11 = 0.001

			if var_561_10 <= arg_558_1.time_ and arg_558_1.time_ < var_561_10 + var_561_11 then
				local var_561_12 = (arg_558_1.time_ - var_561_10) / var_561_11
				local var_561_13 = Vector3.New(0.7, -0.87, -5.7)

				var_561_9.localPosition = Vector3.Lerp(arg_558_1.var_.moveOldPos1111ui_story, var_561_13, var_561_12)

				local var_561_14 = manager.ui.mainCamera.transform.position - var_561_9.position

				var_561_9.forward = Vector3.New(var_561_14.x, var_561_14.y, var_561_14.z)

				local var_561_15 = var_561_9.localEulerAngles

				var_561_15.z = 0
				var_561_15.x = 0
				var_561_9.localEulerAngles = var_561_15
			end

			if arg_558_1.time_ >= var_561_10 + var_561_11 and arg_558_1.time_ < var_561_10 + var_561_11 + arg_561_0 then
				var_561_9.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_561_16 = manager.ui.mainCamera.transform.position - var_561_9.position

				var_561_9.forward = Vector3.New(var_561_16.x, var_561_16.y, var_561_16.z)

				local var_561_17 = var_561_9.localEulerAngles

				var_561_17.z = 0
				var_561_17.x = 0
				var_561_9.localEulerAngles = var_561_17
			end

			local var_561_18 = arg_558_1.actors_["10131ui_story"]
			local var_561_19 = 0

			if var_561_19 < arg_558_1.time_ and arg_558_1.time_ <= var_561_19 + arg_561_0 and not isNil(var_561_18) and arg_558_1.var_.characterEffect10131ui_story == nil then
				arg_558_1.var_.characterEffect10131ui_story = var_561_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_20 = 0.200000002980232

			if var_561_19 <= arg_558_1.time_ and arg_558_1.time_ < var_561_19 + var_561_20 and not isNil(var_561_18) then
				local var_561_21 = (arg_558_1.time_ - var_561_19) / var_561_20

				if arg_558_1.var_.characterEffect10131ui_story and not isNil(var_561_18) then
					arg_558_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_558_1.time_ >= var_561_19 + var_561_20 and arg_558_1.time_ < var_561_19 + var_561_20 + arg_561_0 and not isNil(var_561_18) and arg_558_1.var_.characterEffect10131ui_story then
				arg_558_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_561_22 = arg_558_1.actors_["1111ui_story"]
			local var_561_23 = 0

			if var_561_23 < arg_558_1.time_ and arg_558_1.time_ <= var_561_23 + arg_561_0 and not isNil(var_561_22) and arg_558_1.var_.characterEffect1111ui_story == nil then
				arg_558_1.var_.characterEffect1111ui_story = var_561_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_24 = 0.200000002980232

			if var_561_23 <= arg_558_1.time_ and arg_558_1.time_ < var_561_23 + var_561_24 and not isNil(var_561_22) then
				local var_561_25 = (arg_558_1.time_ - var_561_23) / var_561_24

				if arg_558_1.var_.characterEffect1111ui_story and not isNil(var_561_22) then
					local var_561_26 = Mathf.Lerp(0, 0.5, var_561_25)

					arg_558_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_558_1.var_.characterEffect1111ui_story.fillRatio = var_561_26
				end
			end

			if arg_558_1.time_ >= var_561_23 + var_561_24 and arg_558_1.time_ < var_561_23 + var_561_24 + arg_561_0 and not isNil(var_561_22) and arg_558_1.var_.characterEffect1111ui_story then
				local var_561_27 = 0.5

				arg_558_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_558_1.var_.characterEffect1111ui_story.fillRatio = var_561_27
			end

			local var_561_28 = 0

			if var_561_28 < arg_558_1.time_ and arg_558_1.time_ <= var_561_28 + arg_561_0 then
				arg_558_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			local var_561_29 = 0

			if var_561_29 < arg_558_1.time_ and arg_558_1.time_ <= var_561_29 + arg_561_0 then
				arg_558_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_561_30 = 0
			local var_561_31 = 1.1

			if var_561_30 < arg_558_1.time_ and arg_558_1.time_ <= var_561_30 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_32 = arg_558_1:FormatText(StoryNameCfg[1178].name)

				arg_558_1.leftNameTxt_.text = var_561_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_33 = arg_558_1:GetWordFromCfg(322192136)
				local var_561_34 = arg_558_1:FormatText(var_561_33.content)

				arg_558_1.text_.text = var_561_34

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_35 = 44
				local var_561_36 = utf8.len(var_561_34)
				local var_561_37 = var_561_35 <= 0 and var_561_31 or var_561_31 * (var_561_36 / var_561_35)

				if var_561_37 > 0 and var_561_31 < var_561_37 then
					arg_558_1.talkMaxDuration = var_561_37

					if var_561_37 + var_561_30 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_37 + var_561_30
					end
				end

				arg_558_1.text_.text = var_561_34
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192136", "story_v_out_322192.awb") ~= 0 then
					local var_561_38 = manager.audio:GetVoiceLength("story_v_out_322192", "322192136", "story_v_out_322192.awb") / 1000

					if var_561_38 + var_561_30 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_38 + var_561_30
					end

					if var_561_33.prefab_name ~= "" and arg_558_1.actors_[var_561_33.prefab_name] ~= nil then
						local var_561_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_33.prefab_name].transform, "story_v_out_322192", "322192136", "story_v_out_322192.awb")

						arg_558_1:RecordAudio("322192136", var_561_39)
						arg_558_1:RecordAudio("322192136", var_561_39)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_out_322192", "322192136", "story_v_out_322192.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_out_322192", "322192136", "story_v_out_322192.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_40 = math.max(var_561_31, arg_558_1.talkMaxDuration)

			if var_561_30 <= arg_558_1.time_ and arg_558_1.time_ < var_561_30 + var_561_40 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_30) / var_561_40

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_30 + var_561_40 and arg_558_1.time_ < var_561_30 + var_561_40 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_558_1:InitPlayNodeList()
	end,
	Play322192137 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 322192137
		arg_562_1.duration_ = 18.57

		local var_562_0 = {
			zh = 12.8,
			ja = 18.566
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play322192138(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0
			local var_565_1 = 1.4

			if var_565_0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				local var_565_2 = arg_562_1:FormatText(StoryNameCfg[1178].name)

				arg_562_1.leftNameTxt_.text = var_565_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_3 = arg_562_1:GetWordFromCfg(322192137)
				local var_565_4 = arg_562_1:FormatText(var_565_3.content)

				arg_562_1.text_.text = var_565_4

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_5 = 56
				local var_565_6 = utf8.len(var_565_4)
				local var_565_7 = var_565_5 <= 0 and var_565_1 or var_565_1 * (var_565_6 / var_565_5)

				if var_565_7 > 0 and var_565_1 < var_565_7 then
					arg_562_1.talkMaxDuration = var_565_7

					if var_565_7 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_7 + var_565_0
					end
				end

				arg_562_1.text_.text = var_565_4
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192137", "story_v_out_322192.awb") ~= 0 then
					local var_565_8 = manager.audio:GetVoiceLength("story_v_out_322192", "322192137", "story_v_out_322192.awb") / 1000

					if var_565_8 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_8 + var_565_0
					end

					if var_565_3.prefab_name ~= "" and arg_562_1.actors_[var_565_3.prefab_name] ~= nil then
						local var_565_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_3.prefab_name].transform, "story_v_out_322192", "322192137", "story_v_out_322192.awb")

						arg_562_1:RecordAudio("322192137", var_565_9)
						arg_562_1:RecordAudio("322192137", var_565_9)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_322192", "322192137", "story_v_out_322192.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_322192", "322192137", "story_v_out_322192.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_10 = math.max(var_565_1, arg_562_1.talkMaxDuration)

			if var_565_0 <= arg_562_1.time_ and arg_562_1.time_ < var_565_0 + var_565_10 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_0) / var_565_10

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_0 + var_565_10 and arg_562_1.time_ < var_565_0 + var_565_10 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play322192138 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 322192138
		arg_566_1.duration_ = 6.63

		local var_566_0 = {
			zh = 4.7,
			ja = 6.633
		}
		local var_566_1 = manager.audio:GetLocalizationFlag()

		if var_566_0[var_566_1] ~= nil then
			arg_566_1.duration_ = var_566_0[var_566_1]
		end

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play322192139(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = 0

			if var_569_0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_0 + arg_569_0 then
				arg_566_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_2")
			end

			local var_569_1 = 0
			local var_569_2 = 0.6

			if var_569_1 < arg_566_1.time_ and arg_566_1.time_ <= var_569_1 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				local var_569_3 = arg_566_1:FormatText(StoryNameCfg[1178].name)

				arg_566_1.leftNameTxt_.text = var_569_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_4 = arg_566_1:GetWordFromCfg(322192138)
				local var_569_5 = arg_566_1:FormatText(var_569_4.content)

				arg_566_1.text_.text = var_569_5

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_6 = 24
				local var_569_7 = utf8.len(var_569_5)
				local var_569_8 = var_569_6 <= 0 and var_569_2 or var_569_2 * (var_569_7 / var_569_6)

				if var_569_8 > 0 and var_569_2 < var_569_8 then
					arg_566_1.talkMaxDuration = var_569_8

					if var_569_8 + var_569_1 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_8 + var_569_1
					end
				end

				arg_566_1.text_.text = var_569_5
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192138", "story_v_out_322192.awb") ~= 0 then
					local var_569_9 = manager.audio:GetVoiceLength("story_v_out_322192", "322192138", "story_v_out_322192.awb") / 1000

					if var_569_9 + var_569_1 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_9 + var_569_1
					end

					if var_569_4.prefab_name ~= "" and arg_566_1.actors_[var_569_4.prefab_name] ~= nil then
						local var_569_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_4.prefab_name].transform, "story_v_out_322192", "322192138", "story_v_out_322192.awb")

						arg_566_1:RecordAudio("322192138", var_569_10)
						arg_566_1:RecordAudio("322192138", var_569_10)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_out_322192", "322192138", "story_v_out_322192.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_out_322192", "322192138", "story_v_out_322192.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_11 = math.max(var_569_2, arg_566_1.talkMaxDuration)

			if var_569_1 <= arg_566_1.time_ and arg_566_1.time_ < var_569_1 + var_569_11 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_1) / var_569_11

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_1 + var_569_11 and arg_566_1.time_ < var_569_1 + var_569_11 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play322192139 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 322192139
		arg_570_1.duration_ = 5.43

		local var_570_0 = {
			zh = 4.033,
			ja = 5.433
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play322192140(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = arg_570_1.actors_["1111ui_story"].transform
			local var_573_1 = 0

			if var_573_1 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 then
				arg_570_1.var_.moveOldPos1111ui_story = var_573_0.localPosition
			end

			local var_573_2 = 0.001

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_2 then
				local var_573_3 = (arg_570_1.time_ - var_573_1) / var_573_2
				local var_573_4 = Vector3.New(0.7, -0.87, -5.7)

				var_573_0.localPosition = Vector3.Lerp(arg_570_1.var_.moveOldPos1111ui_story, var_573_4, var_573_3)

				local var_573_5 = manager.ui.mainCamera.transform.position - var_573_0.position

				var_573_0.forward = Vector3.New(var_573_5.x, var_573_5.y, var_573_5.z)

				local var_573_6 = var_573_0.localEulerAngles

				var_573_6.z = 0
				var_573_6.x = 0
				var_573_0.localEulerAngles = var_573_6
			end

			if arg_570_1.time_ >= var_573_1 + var_573_2 and arg_570_1.time_ < var_573_1 + var_573_2 + arg_573_0 then
				var_573_0.localPosition = Vector3.New(0.7, -0.87, -5.7)

				local var_573_7 = manager.ui.mainCamera.transform.position - var_573_0.position

				var_573_0.forward = Vector3.New(var_573_7.x, var_573_7.y, var_573_7.z)

				local var_573_8 = var_573_0.localEulerAngles

				var_573_8.z = 0
				var_573_8.x = 0
				var_573_0.localEulerAngles = var_573_8
			end

			local var_573_9 = arg_570_1.actors_["1111ui_story"]
			local var_573_10 = 0

			if var_573_10 < arg_570_1.time_ and arg_570_1.time_ <= var_573_10 + arg_573_0 and not isNil(var_573_9) and arg_570_1.var_.characterEffect1111ui_story == nil then
				arg_570_1.var_.characterEffect1111ui_story = var_573_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_11 = 0.200000002980232

			if var_573_10 <= arg_570_1.time_ and arg_570_1.time_ < var_573_10 + var_573_11 and not isNil(var_573_9) then
				local var_573_12 = (arg_570_1.time_ - var_573_10) / var_573_11

				if arg_570_1.var_.characterEffect1111ui_story and not isNil(var_573_9) then
					arg_570_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_570_1.time_ >= var_573_10 + var_573_11 and arg_570_1.time_ < var_573_10 + var_573_11 + arg_573_0 and not isNil(var_573_9) and arg_570_1.var_.characterEffect1111ui_story then
				arg_570_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_573_13 = arg_570_1.actors_["10131ui_story"]
			local var_573_14 = 0

			if var_573_14 < arg_570_1.time_ and arg_570_1.time_ <= var_573_14 + arg_573_0 and not isNil(var_573_13) and arg_570_1.var_.characterEffect10131ui_story == nil then
				arg_570_1.var_.characterEffect10131ui_story = var_573_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_15 = 0.200000002980232

			if var_573_14 <= arg_570_1.time_ and arg_570_1.time_ < var_573_14 + var_573_15 and not isNil(var_573_13) then
				local var_573_16 = (arg_570_1.time_ - var_573_14) / var_573_15

				if arg_570_1.var_.characterEffect10131ui_story and not isNil(var_573_13) then
					local var_573_17 = Mathf.Lerp(0, 0.5, var_573_16)

					arg_570_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_570_1.var_.characterEffect10131ui_story.fillRatio = var_573_17
				end
			end

			if arg_570_1.time_ >= var_573_14 + var_573_15 and arg_570_1.time_ < var_573_14 + var_573_15 + arg_573_0 and not isNil(var_573_13) and arg_570_1.var_.characterEffect10131ui_story then
				local var_573_18 = 0.5

				arg_570_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_570_1.var_.characterEffect10131ui_story.fillRatio = var_573_18
			end

			local var_573_19 = 0

			if var_573_19 < arg_570_1.time_ and arg_570_1.time_ <= var_573_19 + arg_573_0 then
				arg_570_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_573_20 = 0
			local var_573_21 = 0.3

			if var_573_20 < arg_570_1.time_ and arg_570_1.time_ <= var_573_20 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				local var_573_22 = arg_570_1:FormatText(StoryNameCfg[67].name)

				arg_570_1.leftNameTxt_.text = var_573_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_23 = arg_570_1:GetWordFromCfg(322192139)
				local var_573_24 = arg_570_1:FormatText(var_573_23.content)

				arg_570_1.text_.text = var_573_24

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_25 = 12
				local var_573_26 = utf8.len(var_573_24)
				local var_573_27 = var_573_25 <= 0 and var_573_21 or var_573_21 * (var_573_26 / var_573_25)

				if var_573_27 > 0 and var_573_21 < var_573_27 then
					arg_570_1.talkMaxDuration = var_573_27

					if var_573_27 + var_573_20 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_27 + var_573_20
					end
				end

				arg_570_1.text_.text = var_573_24
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192139", "story_v_out_322192.awb") ~= 0 then
					local var_573_28 = manager.audio:GetVoiceLength("story_v_out_322192", "322192139", "story_v_out_322192.awb") / 1000

					if var_573_28 + var_573_20 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_28 + var_573_20
					end

					if var_573_23.prefab_name ~= "" and arg_570_1.actors_[var_573_23.prefab_name] ~= nil then
						local var_573_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_23.prefab_name].transform, "story_v_out_322192", "322192139", "story_v_out_322192.awb")

						arg_570_1:RecordAudio("322192139", var_573_29)
						arg_570_1:RecordAudio("322192139", var_573_29)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_out_322192", "322192139", "story_v_out_322192.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_out_322192", "322192139", "story_v_out_322192.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_30 = math.max(var_573_21, arg_570_1.talkMaxDuration)

			if var_573_20 <= arg_570_1.time_ and arg_570_1.time_ < var_573_20 + var_573_30 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_20) / var_573_30

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_20 + var_573_30 and arg_570_1.time_ < var_573_20 + var_573_30 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_570_1:InitPlayNodeList()
	end,
	Play322192140 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 322192140
		arg_574_1.duration_ = 2.17

		local var_574_0 = {
			zh = 1.999999999999,
			ja = 2.166
		}
		local var_574_1 = manager.audio:GetLocalizationFlag()

		if var_574_0[var_574_1] ~= nil then
			arg_574_1.duration_ = var_574_0[var_574_1]
		end

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play322192141(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = arg_574_1.actors_["10131ui_story"]
			local var_577_1 = 0

			if var_577_1 < arg_574_1.time_ and arg_574_1.time_ <= var_577_1 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.characterEffect10131ui_story == nil then
				arg_574_1.var_.characterEffect10131ui_story = var_577_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_2 = 0.200000002980232

			if var_577_1 <= arg_574_1.time_ and arg_574_1.time_ < var_577_1 + var_577_2 and not isNil(var_577_0) then
				local var_577_3 = (arg_574_1.time_ - var_577_1) / var_577_2

				if arg_574_1.var_.characterEffect10131ui_story and not isNil(var_577_0) then
					arg_574_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_574_1.time_ >= var_577_1 + var_577_2 and arg_574_1.time_ < var_577_1 + var_577_2 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.characterEffect10131ui_story then
				arg_574_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_577_4 = arg_574_1.actors_["1111ui_story"]
			local var_577_5 = 0

			if var_577_5 < arg_574_1.time_ and arg_574_1.time_ <= var_577_5 + arg_577_0 and not isNil(var_577_4) and arg_574_1.var_.characterEffect1111ui_story == nil then
				arg_574_1.var_.characterEffect1111ui_story = var_577_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_6 = 0.200000002980232

			if var_577_5 <= arg_574_1.time_ and arg_574_1.time_ < var_577_5 + var_577_6 and not isNil(var_577_4) then
				local var_577_7 = (arg_574_1.time_ - var_577_5) / var_577_6

				if arg_574_1.var_.characterEffect1111ui_story and not isNil(var_577_4) then
					local var_577_8 = Mathf.Lerp(0, 0.5, var_577_7)

					arg_574_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_574_1.var_.characterEffect1111ui_story.fillRatio = var_577_8
				end
			end

			if arg_574_1.time_ >= var_577_5 + var_577_6 and arg_574_1.time_ < var_577_5 + var_577_6 + arg_577_0 and not isNil(var_577_4) and arg_574_1.var_.characterEffect1111ui_story then
				local var_577_9 = 0.5

				arg_574_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_574_1.var_.characterEffect1111ui_story.fillRatio = var_577_9
			end

			local var_577_10 = 0

			if var_577_10 < arg_574_1.time_ and arg_574_1.time_ <= var_577_10 + arg_577_0 then
				arg_574_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_577_11 = 0
			local var_577_12 = 0.15

			if var_577_11 < arg_574_1.time_ and arg_574_1.time_ <= var_577_11 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				local var_577_13 = arg_574_1:FormatText(StoryNameCfg[1178].name)

				arg_574_1.leftNameTxt_.text = var_577_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_14 = arg_574_1:GetWordFromCfg(322192140)
				local var_577_15 = arg_574_1:FormatText(var_577_14.content)

				arg_574_1.text_.text = var_577_15

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_16 = 6
				local var_577_17 = utf8.len(var_577_15)
				local var_577_18 = var_577_16 <= 0 and var_577_12 or var_577_12 * (var_577_17 / var_577_16)

				if var_577_18 > 0 and var_577_12 < var_577_18 then
					arg_574_1.talkMaxDuration = var_577_18

					if var_577_18 + var_577_11 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_18 + var_577_11
					end
				end

				arg_574_1.text_.text = var_577_15
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192140", "story_v_out_322192.awb") ~= 0 then
					local var_577_19 = manager.audio:GetVoiceLength("story_v_out_322192", "322192140", "story_v_out_322192.awb") / 1000

					if var_577_19 + var_577_11 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_19 + var_577_11
					end

					if var_577_14.prefab_name ~= "" and arg_574_1.actors_[var_577_14.prefab_name] ~= nil then
						local var_577_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_574_1.actors_[var_577_14.prefab_name].transform, "story_v_out_322192", "322192140", "story_v_out_322192.awb")

						arg_574_1:RecordAudio("322192140", var_577_20)
						arg_574_1:RecordAudio("322192140", var_577_20)
					else
						arg_574_1:AudioAction("play", "voice", "story_v_out_322192", "322192140", "story_v_out_322192.awb")
					end

					arg_574_1:RecordHistoryTalkVoice("story_v_out_322192", "322192140", "story_v_out_322192.awb")
				end

				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_21 = math.max(var_577_12, arg_574_1.talkMaxDuration)

			if var_577_11 <= arg_574_1.time_ and arg_574_1.time_ < var_577_11 + var_577_21 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_11) / var_577_21

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_11 + var_577_21 and arg_574_1.time_ < var_577_11 + var_577_21 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play322192141 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 322192141
		arg_578_1.duration_ = 5

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play322192142(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = arg_578_1.actors_["1111ui_story"].transform
			local var_581_1 = 0

			if var_581_1 < arg_578_1.time_ and arg_578_1.time_ <= var_581_1 + arg_581_0 then
				arg_578_1.var_.moveOldPos1111ui_story = var_581_0.localPosition
			end

			local var_581_2 = 0.001

			if var_581_1 <= arg_578_1.time_ and arg_578_1.time_ < var_581_1 + var_581_2 then
				local var_581_3 = (arg_578_1.time_ - var_581_1) / var_581_2
				local var_581_4 = Vector3.New(0, 100, 0)

				var_581_0.localPosition = Vector3.Lerp(arg_578_1.var_.moveOldPos1111ui_story, var_581_4, var_581_3)

				local var_581_5 = manager.ui.mainCamera.transform.position - var_581_0.position

				var_581_0.forward = Vector3.New(var_581_5.x, var_581_5.y, var_581_5.z)

				local var_581_6 = var_581_0.localEulerAngles

				var_581_6.z = 0
				var_581_6.x = 0
				var_581_0.localEulerAngles = var_581_6
			end

			if arg_578_1.time_ >= var_581_1 + var_581_2 and arg_578_1.time_ < var_581_1 + var_581_2 + arg_581_0 then
				var_581_0.localPosition = Vector3.New(0, 100, 0)

				local var_581_7 = manager.ui.mainCamera.transform.position - var_581_0.position

				var_581_0.forward = Vector3.New(var_581_7.x, var_581_7.y, var_581_7.z)

				local var_581_8 = var_581_0.localEulerAngles

				var_581_8.z = 0
				var_581_8.x = 0
				var_581_0.localEulerAngles = var_581_8
			end

			local var_581_9 = arg_578_1.actors_["10131ui_story"].transform
			local var_581_10 = 0

			if var_581_10 < arg_578_1.time_ and arg_578_1.time_ <= var_581_10 + arg_581_0 then
				arg_578_1.var_.moveOldPos10131ui_story = var_581_9.localPosition
			end

			local var_581_11 = 0.001

			if var_581_10 <= arg_578_1.time_ and arg_578_1.time_ < var_581_10 + var_581_11 then
				local var_581_12 = (arg_578_1.time_ - var_581_10) / var_581_11
				local var_581_13 = Vector3.New(0, 100, 0)

				var_581_9.localPosition = Vector3.Lerp(arg_578_1.var_.moveOldPos10131ui_story, var_581_13, var_581_12)

				local var_581_14 = manager.ui.mainCamera.transform.position - var_581_9.position

				var_581_9.forward = Vector3.New(var_581_14.x, var_581_14.y, var_581_14.z)

				local var_581_15 = var_581_9.localEulerAngles

				var_581_15.z = 0
				var_581_15.x = 0
				var_581_9.localEulerAngles = var_581_15
			end

			if arg_578_1.time_ >= var_581_10 + var_581_11 and arg_578_1.time_ < var_581_10 + var_581_11 + arg_581_0 then
				var_581_9.localPosition = Vector3.New(0, 100, 0)

				local var_581_16 = manager.ui.mainCamera.transform.position - var_581_9.position

				var_581_9.forward = Vector3.New(var_581_16.x, var_581_16.y, var_581_16.z)

				local var_581_17 = var_581_9.localEulerAngles

				var_581_17.z = 0
				var_581_17.x = 0
				var_581_9.localEulerAngles = var_581_17
			end

			local var_581_18 = arg_578_1.actors_["10131ui_story"]
			local var_581_19 = 0

			if var_581_19 < arg_578_1.time_ and arg_578_1.time_ <= var_581_19 + arg_581_0 and not isNil(var_581_18) and arg_578_1.var_.characterEffect10131ui_story == nil then
				arg_578_1.var_.characterEffect10131ui_story = var_581_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_20 = 0.200000002980232

			if var_581_19 <= arg_578_1.time_ and arg_578_1.time_ < var_581_19 + var_581_20 and not isNil(var_581_18) then
				local var_581_21 = (arg_578_1.time_ - var_581_19) / var_581_20

				if arg_578_1.var_.characterEffect10131ui_story and not isNil(var_581_18) then
					local var_581_22 = Mathf.Lerp(0, 0.5, var_581_21)

					arg_578_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_578_1.var_.characterEffect10131ui_story.fillRatio = var_581_22
				end
			end

			if arg_578_1.time_ >= var_581_19 + var_581_20 and arg_578_1.time_ < var_581_19 + var_581_20 + arg_581_0 and not isNil(var_581_18) and arg_578_1.var_.characterEffect10131ui_story then
				local var_581_23 = 0.5

				arg_578_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_578_1.var_.characterEffect10131ui_story.fillRatio = var_581_23
			end

			local var_581_24 = 0
			local var_581_25 = 1.35

			if var_581_24 < arg_578_1.time_ and arg_578_1.time_ <= var_581_24 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, false)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_26 = arg_578_1:GetWordFromCfg(322192141)
				local var_581_27 = arg_578_1:FormatText(var_581_26.content)

				arg_578_1.text_.text = var_581_27

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_28 = 54
				local var_581_29 = utf8.len(var_581_27)
				local var_581_30 = var_581_28 <= 0 and var_581_25 or var_581_25 * (var_581_29 / var_581_28)

				if var_581_30 > 0 and var_581_25 < var_581_30 then
					arg_578_1.talkMaxDuration = var_581_30

					if var_581_30 + var_581_24 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_30 + var_581_24
					end
				end

				arg_578_1.text_.text = var_581_27
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)
				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_31 = math.max(var_581_25, arg_578_1.talkMaxDuration)

			if var_581_24 <= arg_578_1.time_ and arg_578_1.time_ < var_581_24 + var_581_31 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_24) / var_581_31

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_24 + var_581_31 and arg_578_1.time_ < var_581_24 + var_581_31 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_578_1:InitPlayNodeList()
	end,
	Play322192142 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 322192142
		arg_582_1.duration_ = 7.6

		local var_582_0 = {
			zh = 7.6,
			ja = 6.933
		}
		local var_582_1 = manager.audio:GetLocalizationFlag()

		if var_582_0[var_582_1] ~= nil then
			arg_582_1.duration_ = var_582_0[var_582_1]
		end

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
			arg_582_1.auto_ = false
		end

		function arg_582_1.playNext_(arg_584_0)
			arg_582_1.onStoryFinished_()
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = arg_582_1.actors_["10131ui_story"].transform
			local var_585_1 = 0

			if var_585_1 < arg_582_1.time_ and arg_582_1.time_ <= var_585_1 + arg_585_0 then
				arg_582_1.var_.moveOldPos10131ui_story = var_585_0.localPosition
			end

			local var_585_2 = 0.001

			if var_585_1 <= arg_582_1.time_ and arg_582_1.time_ < var_585_1 + var_585_2 then
				local var_585_3 = (arg_582_1.time_ - var_585_1) / var_585_2
				local var_585_4 = Vector3.New(0.05, -0.96, -5.8)

				var_585_0.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos10131ui_story, var_585_4, var_585_3)

				local var_585_5 = manager.ui.mainCamera.transform.position - var_585_0.position

				var_585_0.forward = Vector3.New(var_585_5.x, var_585_5.y, var_585_5.z)

				local var_585_6 = var_585_0.localEulerAngles

				var_585_6.z = 0
				var_585_6.x = 0
				var_585_0.localEulerAngles = var_585_6
			end

			if arg_582_1.time_ >= var_585_1 + var_585_2 and arg_582_1.time_ < var_585_1 + var_585_2 + arg_585_0 then
				var_585_0.localPosition = Vector3.New(0.05, -0.96, -5.8)

				local var_585_7 = manager.ui.mainCamera.transform.position - var_585_0.position

				var_585_0.forward = Vector3.New(var_585_7.x, var_585_7.y, var_585_7.z)

				local var_585_8 = var_585_0.localEulerAngles

				var_585_8.z = 0
				var_585_8.x = 0
				var_585_0.localEulerAngles = var_585_8
			end

			local var_585_9 = arg_582_1.actors_["10131ui_story"]
			local var_585_10 = 0

			if var_585_10 < arg_582_1.time_ and arg_582_1.time_ <= var_585_10 + arg_585_0 and not isNil(var_585_9) and arg_582_1.var_.characterEffect10131ui_story == nil then
				arg_582_1.var_.characterEffect10131ui_story = var_585_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_585_11 = 0.200000002980232

			if var_585_10 <= arg_582_1.time_ and arg_582_1.time_ < var_585_10 + var_585_11 and not isNil(var_585_9) then
				local var_585_12 = (arg_582_1.time_ - var_585_10) / var_585_11

				if arg_582_1.var_.characterEffect10131ui_story and not isNil(var_585_9) then
					arg_582_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_582_1.time_ >= var_585_10 + var_585_11 and arg_582_1.time_ < var_585_10 + var_585_11 + arg_585_0 and not isNil(var_585_9) and arg_582_1.var_.characterEffect10131ui_story then
				arg_582_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_585_13 = 0

			if var_585_13 < arg_582_1.time_ and arg_582_1.time_ <= var_585_13 + arg_585_0 then
				arg_582_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_585_14 = 0

			if var_585_14 < arg_582_1.time_ and arg_582_1.time_ <= var_585_14 + arg_585_0 then
				arg_582_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_585_15 = 0
			local var_585_16 = 0.65

			if var_585_15 < arg_582_1.time_ and arg_582_1.time_ <= var_585_15 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				local var_585_17 = arg_582_1:FormatText(StoryNameCfg[1178].name)

				arg_582_1.leftNameTxt_.text = var_585_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_18 = arg_582_1:GetWordFromCfg(322192142)
				local var_585_19 = arg_582_1:FormatText(var_585_18.content)

				arg_582_1.text_.text = var_585_19

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_20 = 26
				local var_585_21 = utf8.len(var_585_19)
				local var_585_22 = var_585_20 <= 0 and var_585_16 or var_585_16 * (var_585_21 / var_585_20)

				if var_585_22 > 0 and var_585_16 < var_585_22 then
					arg_582_1.talkMaxDuration = var_585_22

					if var_585_22 + var_585_15 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_22 + var_585_15
					end
				end

				arg_582_1.text_.text = var_585_19
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192142", "story_v_out_322192.awb") ~= 0 then
					local var_585_23 = manager.audio:GetVoiceLength("story_v_out_322192", "322192142", "story_v_out_322192.awb") / 1000

					if var_585_23 + var_585_15 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_23 + var_585_15
					end

					if var_585_18.prefab_name ~= "" and arg_582_1.actors_[var_585_18.prefab_name] ~= nil then
						local var_585_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_582_1.actors_[var_585_18.prefab_name].transform, "story_v_out_322192", "322192142", "story_v_out_322192.awb")

						arg_582_1:RecordAudio("322192142", var_585_24)
						arg_582_1:RecordAudio("322192142", var_585_24)
					else
						arg_582_1:AudioAction("play", "voice", "story_v_out_322192", "322192142", "story_v_out_322192.awb")
					end

					arg_582_1:RecordHistoryTalkVoice("story_v_out_322192", "322192142", "story_v_out_322192.awb")
				end

				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_25 = math.max(var_585_16, arg_582_1.talkMaxDuration)

			if var_585_15 <= arg_582_1.time_ and arg_582_1.time_ < var_585_15 + var_585_25 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_15) / var_585_25

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_15 + var_585_25 and arg_582_1.time_ < var_585_15 + var_585_25 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_582_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/L09f"
	},
	voices = {
		"story_v_out_322192.awb",
		"story_v_out_321122.awb"
	}
}
