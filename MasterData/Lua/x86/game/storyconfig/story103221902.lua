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
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			local var_4_11 = 1.333333333332
			local var_4_12 = manager.audio:GetVoiceLength("story_v_out_322192", "322192001", "story_v_out_322192.awb") / 1000

			if var_4_12 > 0 and 2.9 < var_4_12 and var_4_12 + var_4_11 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_12 + var_4_11
			end

			if var_4_11 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_322192", "322192001", "story_v_out_322192.awb")
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
			if arg_6_1.bgs_.L09f == nil then
				local var_9_0 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L09f")
				var_9_0.name = "L09f"
				var_9_0.transform.parent = arg_6_1.stage_.transform
				var_9_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_.L09f = var_9_0
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				local var_9_1 = arg_6_1.bgs_.L09f

				arg_6_1.bgs_.L09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_9_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_2 = var_9_1:GetComponent("SpriteRenderer")

				if var_9_2 and var_9_2.sprite then
					local var_9_3 = 2 * (var_9_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_9_1.transform.localScale = Vector3.New(var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "L09f" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_4 = 1.999999999999

			if 1.999999999999 < arg_6_1.time_ and arg_6_1.time_ <= var_9_4 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			if arg_6_1.time_ >= var_9_4 + 0.1 and arg_6_1.time_ < var_9_4 + 0.1 + arg_9_0 then
				arg_6_1.allBtn_.enabled = true
			end

			local var_9_5 = 0

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_5 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_6 = 2

			if var_9_5 <= arg_6_1.time_ and arg_6_1.time_ < var_9_5 + var_9_6 then
				local var_9_7 = Color.New(0, 0, 0)

				var_9_7.a = Mathf.Lerp(1, 0, (arg_6_1.time_ - var_9_5) / var_9_6)
				arg_6_1.mask_.color = var_9_7
			end

			if arg_6_1.time_ >= var_9_5 + var_9_6 and arg_6_1.time_ < var_9_5 + var_9_6 + arg_9_0 then
				local var_9_8 = Color.New(0, 0, 0)

				arg_6_1.mask_.enabled = false
				var_9_8.a = 0
				arg_6_1.mask_.color = var_9_8
			end

			local var_9_9 = "1111ui_story"

			if arg_6_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_9_10 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_6_1.stage_.transform)

				var_9_10.name = var_9_9
				var_9_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.actors_[var_9_9] = var_9_10

				local var_9_11 = var_9_10:GetComponentInChildren(typeof(CharacterEffect))

				var_9_11.enabled = true

				local var_9_12 = GameObjectTools.GetOrAddComponent(var_9_10, typeof(DynamicBoneHelper))

				if var_9_12 then
					var_9_12:EnableDynamicBone(false)
				end

				arg_6_1:ShowWeapon(var_9_11.transform, false)

				arg_6_1.var_[var_9_9 .. "Animator"] = var_9_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_6_1.var_[var_9_9 .. "Animator"].applyRootMotion = true
				arg_6_1.var_[var_9_9 .. "LipSync"] = var_9_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_9_13 = arg_6_1.actors_["1111ui_story"].transform

			if 2 < arg_6_1.time_ and arg_6_1.time_ <= 2 + arg_9_0 then
				arg_6_1.var_.moveOldPos1111ui_story = var_9_13.localPosition
			end

			local var_9_14 = 0.001

			if 2 <= arg_6_1.time_ and arg_6_1.time_ < 2 + var_9_14 then
				var_9_13.localPosition = Vector3.Lerp(arg_6_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_6_1.time_ - 2) / var_9_14)
				var_9_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_9_13.position).x, (manager.ui.mainCamera.transform.position - var_9_13.position).y, (manager.ui.mainCamera.transform.position - var_9_13.position).z)
				var_9_13.localEulerAngles.z = 0
				var_9_13.localEulerAngles.x = 0
				var_9_13.localEulerAngles = var_9_13.localEulerAngles
			end

			if arg_6_1.time_ >= 2 + var_9_14 and arg_6_1.time_ < 2 + var_9_14 + arg_9_0 then
				var_9_13.localPosition = Vector3.New(0, -0.87, -5.7)
				var_9_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_9_13.position).x, (manager.ui.mainCamera.transform.position - var_9_13.position).y, (manager.ui.mainCamera.transform.position - var_9_13.position).z)
				var_9_13.localEulerAngles.z = 0
				var_9_13.localEulerAngles.x = 0
				var_9_13.localEulerAngles = var_9_13.localEulerAngles
			end

			local var_9_15 = arg_6_1.actors_["1111ui_story"]

			if 2 < arg_6_1.time_ and arg_6_1.time_ <= 2 + arg_9_0 and not isNil(var_9_15) and arg_6_1.var_.characterEffect1111ui_story == nil then
				arg_6_1.var_.characterEffect1111ui_story = var_9_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_9_16 = 0.200000002980232

			if 2 <= arg_6_1.time_ and arg_6_1.time_ < 2 + var_9_16 and not isNil(var_9_15) then
				if arg_6_1.var_.characterEffect1111ui_story and not isNil(var_9_15) then
					arg_6_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_6_1.time_ >= 2 + var_9_16 and arg_6_1.time_ < 2 + var_9_16 + arg_9_0 and not isNil(var_9_15) and arg_6_1.var_.characterEffect1111ui_story then
				arg_6_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 2 < arg_6_1.time_ and arg_6_1.time_ <= 2 + arg_9_0 then
				arg_6_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			if 2 < arg_6_1.time_ and arg_6_1.time_ <= 2 + arg_9_0 then
				arg_6_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_9_18

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				local var_9_19 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_9_19 then
					var_9_19.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_9_19.radialBlurScale = 1
					var_9_19.radialBlurGradient = 1
					var_9_19.radialBlurIntensity = 1

					if var_9_18 then
						var_9_19.radialBlurTarget = var_9_18.transform
					end
				end
			end

			local var_9_20 = 4

			if 0 <= arg_6_1.time_ and arg_6_1.time_ < 0 + var_9_20 then
				local var_9_21 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_9_21 then
					var_9_21.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_9_21.radialBlurScale = Mathf.Lerp(1, 1, (arg_6_1.time_ - 0) / var_9_20)
					var_9_21.radialBlurGradient = Mathf.Lerp(1, 1, (arg_6_1.time_ - 0) / var_9_20)
					var_9_21.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_6_1.time_ - 0) / var_9_20)
				end
			end

			if arg_6_1.time_ >= 0 + var_9_20 and arg_6_1.time_ < 0 + var_9_20 + arg_9_0 then
				local var_9_22 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_9_22 then
					var_9_22.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_9_22.radialBlurScale = 1
					var_9_22.radialBlurGradient = 1
					var_9_22.radialBlurIntensity = 1
				end
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_9_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_6_1.bgmTxt_.text ~= var_9_25 and arg_6_1.bgmTxt_.text ~= "" then
						if arg_6_1.bgmTxt2_.text ~= "" then
							arg_6_1.bgmTxt_.text = arg_6_1.bgmTxt2_.text
						end

						arg_6_1.bgmTxt2_.text = var_9_25

						arg_6_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_6_1.bgmTxt_.text = var_9_25
						arg_6_1.bgmTxt2_.text = var_9_25
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

			if 0.500666666666667 < arg_6_1.time_ and arg_6_1.time_ <= 0.500666666666667 + arg_9_0 then
				arg_6_1:AudioAction("play", "music", "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source.awb")

				local var_9_28 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source")

				if "" ~= "" then
					if arg_6_1.bgmTxt_.text ~= var_9_28 and arg_6_1.bgmTxt_.text ~= "" then
						if arg_6_1.bgmTxt2_.text ~= "" then
							arg_6_1.bgmTxt_.text = arg_6_1.bgmTxt2_.text
						end

						arg_6_1.bgmTxt2_.text = var_9_28

						arg_6_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_6_1.bgmTxt_.text = var_9_28
						arg_6_1.bgmTxt2_.text = var_9_28
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

			if 0.3 < arg_6_1.time_ and arg_6_1.time_ <= 0.3 + arg_9_0 then
				arg_6_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_dark_L09", "")
			end

			if 0.51 < arg_6_1.time_ and arg_6_1.time_ <= 0.51 + arg_9_0 then
				arg_6_1:AudioAction("play", "music", "bgm_activity_4_5_story_source", "init_story", "bgm_activity_4_5_story_source.awb")

				local var_9_32 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "init_story")

				if "" ~= "" then
					if arg_6_1.bgmTxt_.text ~= var_9_32 and arg_6_1.bgmTxt_.text ~= "" then
						if arg_6_1.bgmTxt2_.text ~= "" then
							arg_6_1.bgmTxt_.text = arg_6_1.bgmTxt2_.text
						end

						arg_6_1.bgmTxt2_.text = var_9_32

						arg_6_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_6_1.bgmTxt_.text = var_9_32
						arg_6_1.bgmTxt2_.text = var_9_32
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

			local var_9_33 = 1.999999999999
			local var_9_34 = 0.1

			if 1.999999999999 < arg_6_1.time_ and arg_6_1.time_ <= var_9_33 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_35 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_35:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_6_1.dialogCg_.alpha = arg_13_0
				end))
				var_9_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, true)

				arg_6_1.leftNameTxt_.text = arg_6_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_1.leftNameTxt_.transform)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1.leftNameTxt_.text)
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_36 = arg_6_1:GetWordFromCfg(322192002)
				local var_9_37 = arg_6_1:FormatText(var_9_36.content)

				arg_6_1.text_.text = var_9_37

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_39 = 4 <= 0 and var_9_34 or var_9_34 * (utf8.len(var_9_37) / 4)

				if (4 <= 0 and var_9_34 or var_9_34 * (utf8.len(var_9_37) / 4)) > 0 and var_9_34 < var_9_39 then
					arg_6_1.talkMaxDuration = var_9_39
					var_9_33 = var_9_33 + 0.3

					if var_9_39 + var_9_33 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_39 + var_9_33
					end
				end

				arg_6_1.text_.text = var_9_37
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192002", "story_v_out_322192.awb") ~= 0 then
					local var_9_40 = manager.audio:GetVoiceLength("story_v_out_322192", "322192002", "story_v_out_322192.awb") / 1000

					if var_9_40 + var_9_33 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_40 + var_9_33
					end

					if var_9_36.prefab_name ~= "" and arg_6_1.actors_[var_9_36.prefab_name] ~= nil then
						local var_9_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_6_1.actors_[var_9_36.prefab_name].transform, "story_v_out_322192", "322192002", "story_v_out_322192.awb")

						arg_6_1:RecordAudio("322192002", var_9_41)
						arg_6_1:RecordAudio("322192002", var_9_41)
					else
						arg_6_1:AudioAction("play", "voice", "story_v_out_322192", "322192002", "story_v_out_322192.awb")
					end

					arg_6_1:RecordHistoryTalkVoice("story_v_out_322192", "322192002", "story_v_out_322192.awb")
				end

				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_42 = var_9_33 + 0.3
			local var_9_43 = math.max(var_9_34, arg_6_1.talkMaxDuration)

			if var_9_33 + 0.3 <= arg_6_1.time_ and arg_6_1.time_ < var_9_42 + var_9_43 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_42) / var_9_43

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_42 + var_9_43 and arg_6_1.time_ < var_9_42 + var_9_43 + arg_9_0 then
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
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1111ui_story = arg_15_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_18_0 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 then
				arg_15_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_15_1.time_ - 0) / var_18_0)
				arg_15_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1111ui_story"].transform.position).z)
				arg_15_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1111ui_story"].transform.localEulerAngles = arg_15_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 then
				arg_15_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1111ui_story"].transform.position).z)
				arg_15_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1111ui_story"].transform.localEulerAngles = arg_15_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_18_1

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				local var_18_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_18_2 then
					var_18_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_18_2.radialBlurScale = 0
					var_18_2.radialBlurGradient = 1
					var_18_2.radialBlurIntensity = 1

					if var_18_1 then
						var_18_2.radialBlurTarget = var_18_1.transform
					end
				end
			end

			local var_18_3 = 1

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_3 then
				local var_18_4 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_18_4 then
					var_18_4.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_18_4.radialBlurScale = Mathf.Lerp(0, 0, (arg_15_1.time_ - 0) / var_18_3)
					var_18_4.radialBlurGradient = Mathf.Lerp(1, 1, (arg_15_1.time_ - 0) / var_18_3)
					var_18_4.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_15_1.time_ - 0) / var_18_3)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_3 and arg_15_1.time_ < 0 + var_18_3 + arg_18_0 then
				local var_18_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_18_5 then
					var_18_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_18_5.radialBlurScale = 0
					var_18_5.radialBlurGradient = 1
					var_18_5.radialBlurIntensity = 1
				end
			end

			local var_18_6 = 0
			local var_18_7 = 1.2

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_8 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(322192003).content)

				arg_15_1.text_.text = var_18_8

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_10 = 48 <= 0 and var_18_7 or var_18_7 * (utf8.len(var_18_8) / 48)

				if (48 <= 0 and var_18_7 or var_18_7 * (utf8.len(var_18_8) / 48)) > 0 and var_18_7 < var_18_10 then
					arg_15_1.talkMaxDuration = var_18_10

					if var_18_10 + var_18_6 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_10 + var_18_6
					end
				end

				arg_15_1.text_.text = var_18_8
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_11 = math.max(var_18_7, arg_15_1.talkMaxDuration)

			if var_18_6 <= arg_15_1.time_ and arg_15_1.time_ < var_18_6 + var_18_11 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_6) / var_18_11

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_6 + var_18_11 and arg_15_1.time_ < var_18_6 + var_18_11 + arg_18_0 then
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
			local var_22_0 = 0.5

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[37].name)

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

				local var_22_1 = arg_19_1:GetWordFromCfg(322192004)
				local var_22_2 = arg_19_1:FormatText(var_22_1.content)

				arg_19_1.text_.text = var_22_2

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_4 = 20 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_2) / 20)

				if (20 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_2) / 20)) > 0 and var_22_0 < var_22_4 then
					arg_19_1.talkMaxDuration = var_22_4

					if var_22_4 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_4 + 0
					end
				end

				arg_19_1.text_.text = var_22_2
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192004", "story_v_out_322192.awb") ~= 0 then
					local var_22_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192004", "story_v_out_322192.awb") / 1000

					if var_22_5 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_5 + 0
					end

					if var_22_1.prefab_name ~= "" and arg_19_1.actors_[var_22_1.prefab_name] ~= nil then
						local var_22_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_1.prefab_name].transform, "story_v_out_322192", "322192004", "story_v_out_322192.awb")

						arg_19_1:RecordAudio("322192004", var_22_6)
						arg_19_1:RecordAudio("322192004", var_22_6)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_322192", "322192004", "story_v_out_322192.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_322192", "322192004", "story_v_out_322192.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_7 = math.max(var_22_0, arg_19_1.talkMaxDuration)

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_7 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - 0) / var_22_7

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= 0 + var_22_7 and arg_19_1.time_ < 0 + var_22_7 + arg_22_0 then
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
			local var_26_0 = 0.15

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[67].name)

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

				local var_26_1 = arg_23_1:GetWordFromCfg(322192005)
				local var_26_2 = arg_23_1:FormatText(var_26_1.content)

				arg_23_1.text_.text = var_26_2

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 6 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 6)

				if (6 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 6)) > 0 and var_26_0 < var_26_4 then
					arg_23_1.talkMaxDuration = var_26_4

					if var_26_4 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_4 + 0
					end
				end

				arg_23_1.text_.text = var_26_2
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192005", "story_v_out_322192.awb") ~= 0 then
					local var_26_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192005", "story_v_out_322192.awb") / 1000

					if var_26_5 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + 0
					end

					if var_26_1.prefab_name ~= "" and arg_23_1.actors_[var_26_1.prefab_name] ~= nil then
						local var_26_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_1.prefab_name].transform, "story_v_out_322192", "322192005", "story_v_out_322192.awb")

						arg_23_1:RecordAudio("322192005", var_26_6)
						arg_23_1:RecordAudio("322192005", var_26_6)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_322192", "322192005", "story_v_out_322192.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_322192", "322192005", "story_v_out_322192.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_7 and arg_23_1.time_ < 0 + var_26_7 + arg_26_0 then
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
			if 1 < arg_27_1.time_ and arg_27_1.time_ <= 1 + arg_30_0 then
				local var_30_0 = arg_27_1.bgs_.L09f

				arg_27_1.bgs_.L09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_30_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_30_1 = var_30_0:GetComponent("SpriteRenderer")

				if var_30_1 and var_30_1.sprite then
					local var_30_2 = 2 * (var_30_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_30_0.transform.localScale = Vector3.New(var_30_2 / var_30_1.sprite.bounds.size.y < var_30_2 * manager.ui.mainCameraCom_.aspect / var_30_1.sprite.bounds.size.x and var_30_2 * manager.ui.mainCameraCom_.aspect / var_30_1.sprite.bounds.size.x or var_30_2 / var_30_1.sprite.bounds.size.y, var_30_2 / var_30_1.sprite.bounds.size.y < var_30_2 * manager.ui.mainCameraCom_.aspect / var_30_1.sprite.bounds.size.x and var_30_2 * manager.ui.mainCameraCom_.aspect / var_30_1.sprite.bounds.size.x or var_30_2 / var_30_1.sprite.bounds.size.y, 0)
				end

				for iter_30_0, iter_30_1 in pairs(arg_27_1.bgs_) do
					if iter_30_0 ~= "L09f" then
						iter_30_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_30_3 = 2

			if 2 < arg_27_1.time_ and arg_27_1.time_ <= var_30_3 + arg_30_0 then
				arg_27_1.allBtn_.enabled = false
			end

			if arg_27_1.time_ >= var_30_3 + 0.225 and arg_27_1.time_ < var_30_3 + 0.225 + arg_30_0 then
				arg_27_1.allBtn_.enabled = true
			end

			local var_30_4 = 0

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_4 + arg_30_0 then
				arg_27_1.mask_.enabled = true
				arg_27_1.mask_.raycastTarget = true

				arg_27_1:SetGaussion(false)
			end

			local var_30_5 = 1

			if var_30_4 <= arg_27_1.time_ and arg_27_1.time_ < var_30_4 + var_30_5 then
				local var_30_6 = Color.New(0, 0, 0)

				var_30_6.a = Mathf.Lerp(0, 1, (arg_27_1.time_ - var_30_4) / var_30_5)
				arg_27_1.mask_.color = var_30_6
			end

			if arg_27_1.time_ >= var_30_4 + var_30_5 and arg_27_1.time_ < var_30_4 + var_30_5 + arg_30_0 then
				local var_30_7 = Color.New(0, 0, 0)

				var_30_7.a = 1
				arg_27_1.mask_.color = var_30_7
			end

			local var_30_8 = 1

			if 1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 then
				arg_27_1.mask_.enabled = true
				arg_27_1.mask_.raycastTarget = true

				arg_27_1:SetGaussion(false)
			end

			local var_30_9 = 1

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_9 then
				local var_30_10 = Color.New(0, 0, 0)

				var_30_10.a = Mathf.Lerp(1, 0, (arg_27_1.time_ - var_30_8) / var_30_9)
				arg_27_1.mask_.color = var_30_10
			end

			if arg_27_1.time_ >= var_30_8 + var_30_9 and arg_27_1.time_ < var_30_8 + var_30_9 + arg_30_0 then
				local var_30_11 = Color.New(0, 0, 0)

				arg_27_1.mask_.enabled = false
				var_30_11.a = 0
				arg_27_1.mask_.color = var_30_11
			end

			local var_30_12 = "1211ui_story"

			if arg_27_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_30_13 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_27_1.stage_.transform)

				var_30_13.name = var_30_12
				var_30_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_[var_30_12] = var_30_13

				local var_30_14 = var_30_13:GetComponentInChildren(typeof(CharacterEffect))

				var_30_14.enabled = true

				local var_30_15 = GameObjectTools.GetOrAddComponent(var_30_13, typeof(DynamicBoneHelper))

				if var_30_15 then
					var_30_15:EnableDynamicBone(false)
				end

				arg_27_1:ShowWeapon(var_30_14.transform, false)

				arg_27_1.var_[var_30_12 .. "Animator"] = var_30_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_27_1.var_[var_30_12 .. "Animator"].applyRootMotion = true
				arg_27_1.var_[var_30_12 .. "LipSync"] = var_30_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_30_16 = arg_27_1.actors_["1211ui_story"].transform

			if 2 < arg_27_1.time_ and arg_27_1.time_ <= 2 + arg_30_0 then
				arg_27_1.var_.moveOldPos1211ui_story = var_30_16.localPosition

				arg_27_1:ShowWeapon(arg_27_1.var_["1211ui_story" .. "Animator"].transform, false)
			end

			local var_30_17 = 0.001

			if 2 <= arg_27_1.time_ and arg_27_1.time_ < 2 + var_30_17 then
				var_30_16.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_27_1.time_ - 2) / var_30_17)
				var_30_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_16.position).x, (manager.ui.mainCamera.transform.position - var_30_16.position).y, (manager.ui.mainCamera.transform.position - var_30_16.position).z)
				var_30_16.localEulerAngles.z = 0
				var_30_16.localEulerAngles.x = 0
				var_30_16.localEulerAngles = var_30_16.localEulerAngles
			end

			if arg_27_1.time_ >= 2 + var_30_17 and arg_27_1.time_ < 2 + var_30_17 + arg_30_0 then
				var_30_16.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				var_30_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_16.position).x, (manager.ui.mainCamera.transform.position - var_30_16.position).y, (manager.ui.mainCamera.transform.position - var_30_16.position).z)
				var_30_16.localEulerAngles.z = 0
				var_30_16.localEulerAngles.x = 0
				var_30_16.localEulerAngles = var_30_16.localEulerAngles
			end

			local var_30_18 = arg_27_1.actors_["1211ui_story"]

			if 2 < arg_27_1.time_ and arg_27_1.time_ <= 2 + arg_30_0 and not isNil(var_30_18) and arg_27_1.var_.characterEffect1211ui_story == nil then
				arg_27_1.var_.characterEffect1211ui_story = var_30_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_19 = 0.200000002980232

			if 2 <= arg_27_1.time_ and arg_27_1.time_ < 2 + var_30_19 and not isNil(var_30_18) then
				if arg_27_1.var_.characterEffect1211ui_story and not isNil(var_30_18) then
					arg_27_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 2 + var_30_19 and arg_27_1.time_ < 2 + var_30_19 + arg_30_0 and not isNil(var_30_18) and arg_27_1.var_.characterEffect1211ui_story then
				arg_27_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 2 < arg_27_1.time_ and arg_27_1.time_ <= 2 + arg_30_0 then
				arg_27_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action8_1")
			end

			if 2 < arg_27_1.time_ and arg_27_1.time_ <= 2 + arg_30_0 then
				arg_27_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if arg_27_1.frameCnt_ <= 1 then
				arg_27_1.dialog_:SetActive(false)
			end

			local var_30_21 = 2
			local var_30_22 = 0.225

			if 2 < arg_27_1.time_ and arg_27_1.time_ <= var_30_21 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0

				arg_27_1.dialog_:SetActive(true)

				arg_27_1.dialogCg_.alpha = 0

				local var_30_23 = LeanTween.value(arg_27_1.dialog_, 0, 1, 0.3)

				var_30_23:setOnUpdate(LuaHelper.FloatAction(function(arg_31_0)
					arg_27_1.dialogCg_.alpha = arg_31_0
				end))
				var_30_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_27_1.dialog_)
					var_30_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_27_1.duration_ = arg_27_1.duration_ + 0.3

				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_24 = arg_27_1:GetWordFromCfg(322192006)
				local var_30_25 = arg_27_1:FormatText(var_30_24.content)

				arg_27_1.text_.text = var_30_25

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_27 = 9 <= 0 and var_30_22 or var_30_22 * (utf8.len(var_30_25) / 9)

				if (9 <= 0 and var_30_22 or var_30_22 * (utf8.len(var_30_25) / 9)) > 0 and var_30_22 < var_30_27 then
					arg_27_1.talkMaxDuration = var_30_27
					var_30_21 = var_30_21 + 0.3

					if var_30_27 + var_30_21 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_27 + var_30_21
					end
				end

				arg_27_1.text_.text = var_30_25
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192006", "story_v_out_322192.awb") ~= 0 then
					local var_30_28 = manager.audio:GetVoiceLength("story_v_out_322192", "322192006", "story_v_out_322192.awb") / 1000

					if var_30_28 + var_30_21 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_28 + var_30_21
					end

					if var_30_24.prefab_name ~= "" and arg_27_1.actors_[var_30_24.prefab_name] ~= nil then
						local var_30_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_24.prefab_name].transform, "story_v_out_322192", "322192006", "story_v_out_322192.awb")

						arg_27_1:RecordAudio("322192006", var_30_29)
						arg_27_1:RecordAudio("322192006", var_30_29)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_322192", "322192006", "story_v_out_322192.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_322192", "322192006", "story_v_out_322192.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_30 = var_30_21 + 0.3
			local var_30_31 = math.max(var_30_22, arg_27_1.talkMaxDuration)

			if var_30_21 + 0.3 <= arg_27_1.time_ and arg_27_1.time_ < var_30_30 + var_30_31 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_30) / var_30_31

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_30 + var_30_31 and arg_27_1.time_ < var_30_30 + var_30_31 + arg_30_0 then
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
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1111ui_story = arg_33_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).z)
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles = arg_33_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_33_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).z)
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles = arg_33_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1111ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1111ui_story == nil then
				arg_33_1.var_.characterEffect1111ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1111ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1111ui_story then
				arg_33_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_36_4 = arg_33_1.actors_["1211ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1211ui_story == nil then
				arg_33_1.var_.characterEffect1211ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_5 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 and not isNil(var_36_4) then
				if arg_33_1.var_.characterEffect1211ui_story and not isNil(var_36_4) then
					arg_33_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_5)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1211ui_story then
				arg_33_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_36_6 = 0
			local var_36_7 = 0.625

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(322192007)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 25 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 25)

				if (25 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 25)) > 0 and var_36_7 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192007", "story_v_out_322192.awb") ~= 0 then
					local var_36_12 = manager.audio:GetVoiceLength("story_v_out_322192", "322192007", "story_v_out_322192.awb") / 1000

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_322192", "322192007", "story_v_out_322192.awb")

						arg_33_1:RecordAudio("322192007", var_36_13)
						arg_33_1:RecordAudio("322192007", var_36_13)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_322192", "322192007", "story_v_out_322192.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_322192", "322192007", "story_v_out_322192.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
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
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1211ui_story = arg_37_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1211ui_story"].transform.position).z)
				arg_37_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1211ui_story"].transform.localEulerAngles = arg_37_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1211ui_story"].transform.position).z)
				arg_37_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1211ui_story"].transform.localEulerAngles = arg_37_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1111ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1111ui_story = var_40_1.localPosition
			end

			local var_40_2 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 then
				var_40_1.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_2)
				var_40_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_1.position).x, (manager.ui.mainCamera.transform.position - var_40_1.position).y, (manager.ui.mainCamera.transform.position - var_40_1.position).z)
				var_40_1.localEulerAngles.z = 0
				var_40_1.localEulerAngles.x = 0
				var_40_1.localEulerAngles = var_40_1.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 then
				var_40_1.localPosition = Vector3.New(0, 100, 0)
				var_40_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_1.position).x, (manager.ui.mainCamera.transform.position - var_40_1.position).y, (manager.ui.mainCamera.transform.position - var_40_1.position).z)
				var_40_1.localEulerAngles.z = 0
				var_40_1.localEulerAngles.x = 0
				var_40_1.localEulerAngles = var_40_1.localEulerAngles
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action8_2")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_40_3 = 0
			local var_40_4 = 1.7

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_5 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(322192008).content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 68 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 68)

				if (68 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 68)) > 0 and var_40_4 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_3
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_4, arg_37_1.talkMaxDuration)

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_3) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_3 + var_40_8 and arg_37_1.time_ < var_40_3 + var_40_8 + arg_40_0 then
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
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1211ui_story = arg_41_1.actors_["1211ui_story"].transform.localPosition

				arg_41_1:ShowWeapon(arg_41_1.var_["1211ui_story" .. "Animator"].transform, false)
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1211ui_story"].transform.position).z)
				arg_41_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1211ui_story"].transform.localEulerAngles = arg_41_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				arg_41_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1211ui_story"].transform.position).z)
				arg_41_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1211ui_story"].transform.localEulerAngles = arg_41_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1211ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1211ui_story == nil then
				arg_41_1.var_.characterEffect1211ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1211ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1211ui_story then
				arg_41_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_44_4 = 0
			local var_44_5 = 0.3

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(322192009)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 12 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 12)

				if (12 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 12)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192009", "story_v_out_322192.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192009", "story_v_out_322192.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_322192", "322192009", "story_v_out_322192.awb")

						arg_41_1:RecordAudio("322192009", var_44_11)
						arg_41_1:RecordAudio("322192009", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322192", "322192009", "story_v_out_322192.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322192", "322192009", "story_v_out_322192.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
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
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_2")
			end

			local var_48_0 = 0
			local var_48_1 = 0.45

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(322192010)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 18 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 18)

				if (18 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 18)) > 0 and var_48_1 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192010", "story_v_out_322192.awb") ~= 0 then
					local var_48_6 = manager.audio:GetVoiceLength("story_v_out_322192", "322192010", "story_v_out_322192.awb") / 1000

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end

					if var_48_2.prefab_name ~= "" and arg_45_1.actors_[var_48_2.prefab_name] ~= nil then
						local var_48_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_2.prefab_name].transform, "story_v_out_322192", "322192010", "story_v_out_322192.awb")

						arg_45_1:RecordAudio("322192010", var_48_7)
						arg_45_1:RecordAudio("322192010", var_48_7)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_322192", "322192010", "story_v_out_322192.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_322192", "322192010", "story_v_out_322192.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_8 and arg_45_1.time_ < var_48_0 + var_48_8 + arg_48_0 then
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
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1111ui_story = arg_49_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1111ui_story"].transform.position).z)
				arg_49_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1111ui_story"].transform.localEulerAngles = arg_49_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_49_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1111ui_story"].transform.position).z)
				arg_49_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1111ui_story"].transform.localEulerAngles = arg_49_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1111ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1111ui_story == nil then
				arg_49_1.var_.characterEffect1111ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1111ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1111ui_story then
				arg_49_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_52_4 = arg_49_1.actors_["1211ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1211ui_story == nil then
				arg_49_1.var_.characterEffect1211ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_5 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 and not isNil(var_52_4) then
				if arg_49_1.var_.characterEffect1211ui_story and not isNil(var_52_4) then
					arg_49_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_5)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1211ui_story then
				arg_49_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_52_6 = 0
			local var_52_7 = 0.9

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(322192011)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 36 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 36)

				if (36 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 36)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192011", "story_v_out_322192.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_322192", "322192011", "story_v_out_322192.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_322192", "322192011", "story_v_out_322192.awb")

						arg_49_1:RecordAudio("322192011", var_52_13)
						arg_49_1:RecordAudio("322192011", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322192", "322192011", "story_v_out_322192.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322192", "322192011", "story_v_out_322192.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
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
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1211ui_story"]) and arg_53_1.var_.characterEffect1211ui_story == nil then
				arg_53_1.var_.characterEffect1211ui_story = arg_53_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1211ui_story"]) then
				if arg_53_1.var_.characterEffect1211ui_story and not isNil(arg_53_1.actors_["1211ui_story"]) then
					arg_53_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1211ui_story"]) and arg_53_1.var_.characterEffect1211ui_story then
				arg_53_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_56_2 = arg_53_1.actors_["1111ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect1111ui_story == nil then
				arg_53_1.var_.characterEffect1111ui_story = var_56_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_3 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.characterEffect1111ui_story and not isNil(var_56_2) then
					arg_53_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_3)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect1111ui_story then
				arg_53_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action7_1")
			end

			local var_56_4 = 0
			local var_56_5 = 0.25

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(322192012)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 10 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 10)

				if (10 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 10)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192012", "story_v_out_322192.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192012", "story_v_out_322192.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_322192", "322192012", "story_v_out_322192.awb")

						arg_53_1:RecordAudio("322192012", var_56_11)
						arg_53_1:RecordAudio("322192012", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_322192", "322192012", "story_v_out_322192.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_322192", "322192012", "story_v_out_322192.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
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
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1111ui_story"]) and arg_57_1.var_.characterEffect1111ui_story == nil then
				arg_57_1.var_.characterEffect1111ui_story = arg_57_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1111ui_story"]) then
				if arg_57_1.var_.characterEffect1111ui_story and not isNil(arg_57_1.actors_["1111ui_story"]) then
					arg_57_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1111ui_story"]) and arg_57_1.var_.characterEffect1111ui_story then
				arg_57_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_60_2 = arg_57_1.actors_["1211ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1211ui_story == nil then
				arg_57_1.var_.characterEffect1211ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect1211ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_3)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1211ui_story then
				arg_57_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			local var_60_4 = 0
			local var_60_5 = 0.65

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(322192013)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 26 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 26)

				if (26 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 26)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192013", "story_v_out_322192.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192013", "story_v_out_322192.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_322192", "322192013", "story_v_out_322192.awb")

						arg_57_1:RecordAudio("322192013", var_60_11)
						arg_57_1:RecordAudio("322192013", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_322192", "322192013", "story_v_out_322192.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_322192", "322192013", "story_v_out_322192.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
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
			local var_64_0 = 0.75

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(322192014)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 30 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 30)

				if (30 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 30)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192014", "story_v_out_322192.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192014", "story_v_out_322192.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_322192", "322192014", "story_v_out_322192.awb")

						arg_61_1:RecordAudio("322192014", var_64_6)
						arg_61_1:RecordAudio("322192014", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_322192", "322192014", "story_v_out_322192.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_322192", "322192014", "story_v_out_322192.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
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
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1211ui_story"]) and arg_65_1.var_.characterEffect1211ui_story == nil then
				arg_65_1.var_.characterEffect1211ui_story = arg_65_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1211ui_story"]) then
				if arg_65_1.var_.characterEffect1211ui_story and not isNil(arg_65_1.actors_["1211ui_story"]) then
					arg_65_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1211ui_story"]) and arg_65_1.var_.characterEffect1211ui_story then
				arg_65_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_68_2 = arg_65_1.actors_["1111ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1111ui_story == nil then
				arg_65_1.var_.characterEffect1111ui_story = var_68_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_3 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.characterEffect1111ui_story and not isNil(var_68_2) then
					arg_65_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_3)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1111ui_story then
				arg_65_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action7_2")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_68_4 = 0
			local var_68_5 = 0.5

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(322192015)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 20 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 20)

				if (20 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 20)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192015", "story_v_out_322192.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192015", "story_v_out_322192.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_322192", "322192015", "story_v_out_322192.awb")

						arg_65_1:RecordAudio("322192015", var_68_11)
						arg_65_1:RecordAudio("322192015", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_322192", "322192015", "story_v_out_322192.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_322192", "322192015", "story_v_out_322192.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
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
			local var_72_0 = 0.825

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(322192016)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 33 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 33)

				if (33 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 33)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192016", "story_v_out_322192.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192016", "story_v_out_322192.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_322192", "322192016", "story_v_out_322192.awb")

						arg_69_1:RecordAudio("322192016", var_72_6)
						arg_69_1:RecordAudio("322192016", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_322192", "322192016", "story_v_out_322192.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_322192", "322192016", "story_v_out_322192.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
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
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1111ui_story"]) and arg_73_1.var_.characterEffect1111ui_story == nil then
				arg_73_1.var_.characterEffect1111ui_story = arg_73_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1111ui_story"]) then
				if arg_73_1.var_.characterEffect1111ui_story and not isNil(arg_73_1.actors_["1111ui_story"]) then
					arg_73_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1111ui_story"]) and arg_73_1.var_.characterEffect1111ui_story then
				arg_73_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_76_2 = arg_73_1.actors_["1211ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1211ui_story == nil then
				arg_73_1.var_.characterEffect1211ui_story = var_76_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_3 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.characterEffect1211ui_story and not isNil(var_76_2) then
					arg_73_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_3)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1211ui_story then
				arg_73_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_76_4 = 0
			local var_76_5 = 0.2

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(322192017)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 8 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 8)

				if (8 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 8)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192017", "story_v_out_322192.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192017", "story_v_out_322192.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_322192", "322192017", "story_v_out_322192.awb")

						arg_73_1:RecordAudio("322192017", var_76_11)
						arg_73_1:RecordAudio("322192017", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_322192", "322192017", "story_v_out_322192.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_322192", "322192017", "story_v_out_322192.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
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
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1111ui_story = arg_77_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1111ui_story"].transform.position).z)
				arg_77_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1111ui_story"].transform.localEulerAngles = arg_77_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1111ui_story"].transform.position).z)
				arg_77_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1111ui_story"].transform.localEulerAngles = arg_77_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_80_1 = "1043ui_story"

			if arg_77_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_80_2 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_77_1.stage_.transform)

				var_80_2.name = var_80_1
				var_80_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_[var_80_1] = var_80_2

				local var_80_3 = var_80_2:GetComponentInChildren(typeof(CharacterEffect))

				var_80_3.enabled = true

				local var_80_4 = GameObjectTools.GetOrAddComponent(var_80_2, typeof(DynamicBoneHelper))

				if var_80_4 then
					var_80_4:EnableDynamicBone(false)
				end

				arg_77_1:ShowWeapon(var_80_3.transform, false)

				arg_77_1.var_[var_80_1 .. "Animator"] = var_80_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_77_1.var_[var_80_1 .. "Animator"].applyRootMotion = true
				arg_77_1.var_[var_80_1 .. "LipSync"] = var_80_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_80_5 = arg_77_1.actors_["1043ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1043ui_story = var_80_5.localPosition
			end

			local var_80_6 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 then
				var_80_5.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_77_1.time_ - 0) / var_80_6)
				var_80_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_5.position).x, (manager.ui.mainCamera.transform.position - var_80_5.position).y, (manager.ui.mainCamera.transform.position - var_80_5.position).z)
				var_80_5.localEulerAngles.z = 0
				var_80_5.localEulerAngles.x = 0
				var_80_5.localEulerAngles = var_80_5.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 then
				var_80_5.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_80_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_5.position).x, (manager.ui.mainCamera.transform.position - var_80_5.position).y, (manager.ui.mainCamera.transform.position - var_80_5.position).z)
				var_80_5.localEulerAngles.z = 0
				var_80_5.localEulerAngles.x = 0
				var_80_5.localEulerAngles = var_80_5.localEulerAngles
			end

			local var_80_7 = arg_77_1.actors_["1043ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.characterEffect1043ui_story == nil then
				arg_77_1.var_.characterEffect1043ui_story = var_80_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_8 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_8 and not isNil(var_80_7) then
				if arg_77_1.var_.characterEffect1043ui_story and not isNil(var_80_7) then
					arg_77_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_8 and arg_77_1.time_ < 0 + var_80_8 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.characterEffect1043ui_story then
				arg_77_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_80_10 = arg_77_1.actors_["1111ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_10) and arg_77_1.var_.characterEffect1111ui_story == nil then
				arg_77_1.var_.characterEffect1111ui_story = var_80_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_11 and not isNil(var_80_10) then
				if arg_77_1.var_.characterEffect1111ui_story and not isNil(var_80_10) then
					arg_77_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_11)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_11 and arg_77_1.time_ < 0 + var_80_11 + arg_80_0 and not isNil(var_80_10) and arg_77_1.var_.characterEffect1111ui_story then
				arg_77_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_80_12 = 0
			local var_80_13 = 0.425

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_12 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_14 = arg_77_1:GetWordFromCfg(322192018)
				local var_80_15 = arg_77_1:FormatText(var_80_14.content)

				arg_77_1.text_.text = var_80_15

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_17 = 17 <= 0 and var_80_13 or var_80_13 * (utf8.len(var_80_15) / 17)

				if (17 <= 0 and var_80_13 or var_80_13 * (utf8.len(var_80_15) / 17)) > 0 and var_80_13 < var_80_17 then
					arg_77_1.talkMaxDuration = var_80_17

					if var_80_17 + var_80_12 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_12
					end
				end

				arg_77_1.text_.text = var_80_15
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192018", "story_v_out_322192.awb") ~= 0 then
					local var_80_18 = manager.audio:GetVoiceLength("story_v_out_322192", "322192018", "story_v_out_322192.awb") / 1000

					if var_80_18 + var_80_12 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_18 + var_80_12
					end

					if var_80_14.prefab_name ~= "" and arg_77_1.actors_[var_80_14.prefab_name] ~= nil then
						local var_80_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_14.prefab_name].transform, "story_v_out_322192", "322192018", "story_v_out_322192.awb")

						arg_77_1:RecordAudio("322192018", var_80_19)
						arg_77_1:RecordAudio("322192018", var_80_19)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_322192", "322192018", "story_v_out_322192.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_322192", "322192018", "story_v_out_322192.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_20 = math.max(var_80_13, arg_77_1.talkMaxDuration)

			if var_80_12 <= arg_77_1.time_ and arg_77_1.time_ < var_80_12 + var_80_20 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_12) / var_80_20

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_12 + var_80_20 and arg_77_1.time_ < var_80_12 + var_80_20 + arg_80_0 then
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
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1111ui_story"]) and arg_81_1.var_.characterEffect1111ui_story == nil then
				arg_81_1.var_.characterEffect1111ui_story = arg_81_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1111ui_story"]) then
				if arg_81_1.var_.characterEffect1111ui_story and not isNil(arg_81_1.actors_["1111ui_story"]) then
					arg_81_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1111ui_story"]) and arg_81_1.var_.characterEffect1111ui_story then
				arg_81_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_84_2 = arg_81_1.actors_["1043ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1043ui_story == nil then
				arg_81_1.var_.characterEffect1043ui_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect1043ui_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1043ui_story then
				arg_81_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_84_4 = arg_81_1.actors_["1111ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1111ui_story = var_84_4.localPosition
			end

			local var_84_5 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_5 then
				var_84_4.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_81_1.time_ - 0) / var_84_5)
				var_84_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_4.position).x, (manager.ui.mainCamera.transform.position - var_84_4.position).y, (manager.ui.mainCamera.transform.position - var_84_4.position).z)
				var_84_4.localEulerAngles.z = 0
				var_84_4.localEulerAngles.x = 0
				var_84_4.localEulerAngles = var_84_4.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_5 and arg_81_1.time_ < 0 + var_84_5 + arg_84_0 then
				var_84_4.localPosition = Vector3.New(0, -0.87, -5.7)
				var_84_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_4.position).x, (manager.ui.mainCamera.transform.position - var_84_4.position).y, (manager.ui.mainCamera.transform.position - var_84_4.position).z)
				var_84_4.localEulerAngles.z = 0
				var_84_4.localEulerAngles.x = 0
				var_84_4.localEulerAngles = var_84_4.localEulerAngles
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_84_6 = arg_81_1.actors_["1211ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1211ui_story = var_84_6.localPosition

				arg_81_1:ShowWeapon(arg_81_1.var_["1211ui_story" .. "Animator"].transform, false)
			end

			local var_84_7 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				var_84_6.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_7)
				var_84_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_6.position).x, (manager.ui.mainCamera.transform.position - var_84_6.position).y, (manager.ui.mainCamera.transform.position - var_84_6.position).z)
				var_84_6.localEulerAngles.z = 0
				var_84_6.localEulerAngles.x = 0
				var_84_6.localEulerAngles = var_84_6.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				var_84_6.localPosition = Vector3.New(0, 100, 0)
				var_84_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_6.position).x, (manager.ui.mainCamera.transform.position - var_84_6.position).y, (manager.ui.mainCamera.transform.position - var_84_6.position).z)
				var_84_6.localEulerAngles.z = 0
				var_84_6.localEulerAngles.x = 0
				var_84_6.localEulerAngles = var_84_6.localEulerAngles
			end

			local var_84_8 = arg_81_1.actors_["1043ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1043ui_story = var_84_8.localPosition
			end

			local var_84_9 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_9 then
				var_84_8.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_9)
				var_84_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_8.position).x, (manager.ui.mainCamera.transform.position - var_84_8.position).y, (manager.ui.mainCamera.transform.position - var_84_8.position).z)
				var_84_8.localEulerAngles.z = 0
				var_84_8.localEulerAngles.x = 0
				var_84_8.localEulerAngles = var_84_8.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_9 and arg_81_1.time_ < 0 + var_84_9 + arg_84_0 then
				var_84_8.localPosition = Vector3.New(0, 100, 0)
				var_84_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_8.position).x, (manager.ui.mainCamera.transform.position - var_84_8.position).y, (manager.ui.mainCamera.transform.position - var_84_8.position).z)
				var_84_8.localEulerAngles.z = 0
				var_84_8.localEulerAngles.x = 0
				var_84_8.localEulerAngles = var_84_8.localEulerAngles
			end

			local var_84_10 = 0
			local var_84_11 = 0.725

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_12 = arg_81_1:GetWordFromCfg(322192019)
				local var_84_13 = arg_81_1:FormatText(var_84_12.content)

				arg_81_1.text_.text = var_84_13

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_15 = 29 <= 0 and var_84_11 or var_84_11 * (utf8.len(var_84_13) / 29)

				if (29 <= 0 and var_84_11 or var_84_11 * (utf8.len(var_84_13) / 29)) > 0 and var_84_11 < var_84_15 then
					arg_81_1.talkMaxDuration = var_84_15

					if var_84_15 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_15 + var_84_10
					end
				end

				arg_81_1.text_.text = var_84_13
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192019", "story_v_out_322192.awb") ~= 0 then
					local var_84_16 = manager.audio:GetVoiceLength("story_v_out_322192", "322192019", "story_v_out_322192.awb") / 1000

					if var_84_16 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_16 + var_84_10
					end

					if var_84_12.prefab_name ~= "" and arg_81_1.actors_[var_84_12.prefab_name] ~= nil then
						local var_84_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_12.prefab_name].transform, "story_v_out_322192", "322192019", "story_v_out_322192.awb")

						arg_81_1:RecordAudio("322192019", var_84_17)
						arg_81_1:RecordAudio("322192019", var_84_17)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_322192", "322192019", "story_v_out_322192.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_322192", "322192019", "story_v_out_322192.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_18 = math.max(var_84_11, arg_81_1.talkMaxDuration)

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_18 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_10) / var_84_18

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_10 + var_84_18 and arg_81_1.time_ < var_84_10 + var_84_18 + arg_84_0 then
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
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1111ui_story = arg_85_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1111ui_story"].transform.position).z)
				arg_85_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1111ui_story"].transform.localEulerAngles = arg_85_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1111ui_story"].transform.position).z)
				arg_85_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1111ui_story"].transform.localEulerAngles = arg_85_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_88_1 = 0
			local var_88_2 = 0.4

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(322192020).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 16 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 16)

				if (16 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 16)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
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
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1111ui_story = arg_89_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1111ui_story"].transform.position).z)
				arg_89_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1111ui_story"].transform.localEulerAngles = arg_89_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_89_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1111ui_story"].transform.position).z)
				arg_89_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1111ui_story"].transform.localEulerAngles = arg_89_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1111ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1111ui_story == nil then
				arg_89_1.var_.characterEffect1111ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1111ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1111ui_story then
				arg_89_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_92_4 = 0
			local var_92_5 = 0.15

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(322192021)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 6 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 6)

				if (6 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 6)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192021", "story_v_out_322192.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192021", "story_v_out_322192.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_322192", "322192021", "story_v_out_322192.awb")

						arg_89_1:RecordAudio("322192021", var_92_11)
						arg_89_1:RecordAudio("322192021", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_322192", "322192021", "story_v_out_322192.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_322192", "322192021", "story_v_out_322192.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
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
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1111ui_story = arg_93_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1111ui_story"].transform.position).z)
				arg_93_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1111ui_story"].transform.localEulerAngles = arg_93_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_93_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1111ui_story"].transform.position).z)
				arg_93_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1111ui_story"].transform.localEulerAngles = arg_93_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1211ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1211ui_story = var_96_1.localPosition
			end

			local var_96_2 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 then
				var_96_1.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_93_1.time_ - 0) / var_96_2)
				var_96_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_1.position).x, (manager.ui.mainCamera.transform.position - var_96_1.position).y, (manager.ui.mainCamera.transform.position - var_96_1.position).z)
				var_96_1.localEulerAngles.z = 0
				var_96_1.localEulerAngles.x = 0
				var_96_1.localEulerAngles = var_96_1.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 then
				var_96_1.localPosition = Vector3.New(0.7, -0.67, -6.07)
				var_96_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_1.position).x, (manager.ui.mainCamera.transform.position - var_96_1.position).y, (manager.ui.mainCamera.transform.position - var_96_1.position).z)
				var_96_1.localEulerAngles.z = 0
				var_96_1.localEulerAngles.x = 0
				var_96_1.localEulerAngles = var_96_1.localEulerAngles
			end

			local var_96_3 = arg_93_1.actors_["1211ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_3) and arg_93_1.var_.characterEffect1211ui_story == nil then
				arg_93_1.var_.characterEffect1211ui_story = var_96_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_4 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 and not isNil(var_96_3) then
				if arg_93_1.var_.characterEffect1211ui_story and not isNil(var_96_3) then
					arg_93_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 and not isNil(var_96_3) and arg_93_1.var_.characterEffect1211ui_story then
				arg_93_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_96_6 = arg_93_1.actors_["1111ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect1111ui_story == nil then
				arg_93_1.var_.characterEffect1111ui_story = var_96_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_7 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 and not isNil(var_96_6) then
				if arg_93_1.var_.characterEffect1111ui_story and not isNil(var_96_6) then
					arg_93_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_7)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect1111ui_story then
				arg_93_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action1_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_8 = 0
			local var_96_9 = 0.225

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:GetWordFromCfg(322192022)
				local var_96_11 = arg_93_1:FormatText(var_96_10.content)

				arg_93_1.text_.text = var_96_11

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 9 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 9)

				if (9 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 9)) > 0 and var_96_9 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_11
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192022", "story_v_out_322192.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192022", "story_v_out_322192.awb") / 1000

					if var_96_14 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_8
					end

					if var_96_10.prefab_name ~= "" and arg_93_1.actors_[var_96_10.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_10.prefab_name].transform, "story_v_out_322192", "322192022", "story_v_out_322192.awb")

						arg_93_1:RecordAudio("322192022", var_96_15)
						arg_93_1:RecordAudio("322192022", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_322192", "322192022", "story_v_out_322192.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_322192", "322192022", "story_v_out_322192.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_16 and arg_93_1.time_ < var_96_8 + var_96_16 + arg_96_0 then
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
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1111ui_story"]) and arg_97_1.var_.characterEffect1111ui_story == nil then
				arg_97_1.var_.characterEffect1111ui_story = arg_97_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1111ui_story"]) then
				if arg_97_1.var_.characterEffect1111ui_story and not isNil(arg_97_1.actors_["1111ui_story"]) then
					arg_97_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1111ui_story"]) and arg_97_1.var_.characterEffect1111ui_story then
				arg_97_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_100_2 = arg_97_1.actors_["1211ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.characterEffect1211ui_story == nil then
				arg_97_1.var_.characterEffect1211ui_story = var_100_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_3 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.characterEffect1211ui_story and not isNil(var_100_2) then
					arg_97_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_3)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.characterEffect1211ui_story then
				arg_97_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_100_4 = 0
			local var_100_5 = 0.525

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(322192023)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 21 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 21)

				if (21 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 21)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192023", "story_v_out_322192.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192023", "story_v_out_322192.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_322192", "322192023", "story_v_out_322192.awb")

						arg_97_1:RecordAudio("322192023", var_100_11)
						arg_97_1:RecordAudio("322192023", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_322192", "322192023", "story_v_out_322192.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_322192", "322192023", "story_v_out_322192.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
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
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1111ui_story = arg_101_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1111ui_story"].transform.position).z)
				arg_101_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1111ui_story"].transform.localEulerAngles = arg_101_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1111ui_story"].transform.position).z)
				arg_101_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1111ui_story"].transform.localEulerAngles = arg_101_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1211ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1211ui_story = var_104_1.localPosition
			end

			local var_104_2 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 then
				var_104_1.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_2)
				var_104_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_1.position).x, (manager.ui.mainCamera.transform.position - var_104_1.position).y, (manager.ui.mainCamera.transform.position - var_104_1.position).z)
				var_104_1.localEulerAngles.z = 0
				var_104_1.localEulerAngles.x = 0
				var_104_1.localEulerAngles = var_104_1.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 then
				var_104_1.localPosition = Vector3.New(0, 100, 0)
				var_104_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_1.position).x, (manager.ui.mainCamera.transform.position - var_104_1.position).y, (manager.ui.mainCamera.transform.position - var_104_1.position).z)
				var_104_1.localEulerAngles.z = 0
				var_104_1.localEulerAngles.x = 0
				var_104_1.localEulerAngles = var_104_1.localEulerAngles
			end

			if 0.3 < arg_101_1.time_ and arg_101_1.time_ <= 0.3 + arg_104_0 then
				arg_101_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_side_1033_footstep", "")
			end

			local var_104_4 = 0
			local var_104_5 = 0.675

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(322192024).content)

				arg_101_1.text_.text = var_104_6

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_8 = 27 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_6) / 27)

				if (27 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_6) / 27)) > 0 and var_104_5 < var_104_8 then
					arg_101_1.talkMaxDuration = var_104_8

					if var_104_8 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_6
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_9 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_9 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_9

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_9 and arg_101_1.time_ < var_104_4 + var_104_9 + arg_104_0 then
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
			local var_108_0 = 0.95

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(322192025).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 38 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 38)

				if (38 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 38)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
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
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1211ui_story = arg_109_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1211ui_story"].transform.position).z)
				arg_109_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1211ui_story"].transform.localEulerAngles = arg_109_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, -0.67, -6.07)
				arg_109_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1211ui_story"].transform.position).z)
				arg_109_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1211ui_story"].transform.localEulerAngles = arg_109_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1211ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1211ui_story == nil then
				arg_109_1.var_.characterEffect1211ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1211ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1211ui_story then
				arg_109_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_112_4 = 0
			local var_112_5 = 0.225

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(322192026)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 9 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 9)

				if (9 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 9)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192026", "story_v_out_322192.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192026", "story_v_out_322192.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_322192", "322192026", "story_v_out_322192.awb")

						arg_109_1:RecordAudio("322192026", var_112_11)
						arg_109_1:RecordAudio("322192026", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_322192", "322192026", "story_v_out_322192.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_322192", "322192026", "story_v_out_322192.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
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
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1111ui_story = arg_113_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).z)
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles = arg_113_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_113_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).z)
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles = arg_113_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1211ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1211ui_story = var_116_1.localPosition
			end

			local var_116_2 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 then
				var_116_1.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_113_1.time_ - 0) / var_116_2)
				var_116_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_1.position).x, (manager.ui.mainCamera.transform.position - var_116_1.position).y, (manager.ui.mainCamera.transform.position - var_116_1.position).z)
				var_116_1.localEulerAngles.z = 0
				var_116_1.localEulerAngles.x = 0
				var_116_1.localEulerAngles = var_116_1.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 then
				var_116_1.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				var_116_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_1.position).x, (manager.ui.mainCamera.transform.position - var_116_1.position).y, (manager.ui.mainCamera.transform.position - var_116_1.position).z)
				var_116_1.localEulerAngles.z = 0
				var_116_1.localEulerAngles.x = 0
				var_116_1.localEulerAngles = var_116_1.localEulerAngles
			end

			local var_116_3 = arg_113_1.actors_["1111ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_3) and arg_113_1.var_.characterEffect1111ui_story == nil then
				arg_113_1.var_.characterEffect1111ui_story = var_116_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_4 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 and not isNil(var_116_3) then
				if arg_113_1.var_.characterEffect1111ui_story and not isNil(var_116_3) then
					arg_113_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 and not isNil(var_116_3) and arg_113_1.var_.characterEffect1111ui_story then
				arg_113_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_116_6 = arg_113_1.actors_["1211ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect1211ui_story == nil then
				arg_113_1.var_.characterEffect1211ui_story = var_116_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_7 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 and not isNil(var_116_6) then
				if arg_113_1.var_.characterEffect1211ui_story and not isNil(var_116_6) then
					arg_113_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_7)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 and not isNil(var_116_6) and arg_113_1.var_.characterEffect1211ui_story then
				arg_113_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_116_8 = 0
			local var_116_9 = 0.45

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_10 = arg_113_1:GetWordFromCfg(322192027)
				local var_116_11 = arg_113_1:FormatText(var_116_10.content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 18 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 18)

				if (18 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 18)) > 0 and var_116_9 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192027", "story_v_out_322192.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192027", "story_v_out_322192.awb") / 1000

					if var_116_14 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_8
					end

					if var_116_10.prefab_name ~= "" and arg_113_1.actors_[var_116_10.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_10.prefab_name].transform, "story_v_out_322192", "322192027", "story_v_out_322192.awb")

						arg_113_1:RecordAudio("322192027", var_116_15)
						arg_113_1:RecordAudio("322192027", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_322192", "322192027", "story_v_out_322192.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_322192", "322192027", "story_v_out_322192.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_16 and arg_113_1.time_ < var_116_8 + var_116_16 + arg_116_0 then
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
			local var_120_0 = 0.975

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:GetWordFromCfg(322192028)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 39 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 39)

				if (39 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 39)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192028", "story_v_out_322192.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192028", "story_v_out_322192.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_322192", "322192028", "story_v_out_322192.awb")

						arg_117_1:RecordAudio("322192028", var_120_6)
						arg_117_1:RecordAudio("322192028", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_322192", "322192028", "story_v_out_322192.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_322192", "322192028", "story_v_out_322192.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
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
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1111ui_story = arg_121_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1111ui_story"].transform.position).z)
				arg_121_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1111ui_story"].transform.localEulerAngles = arg_121_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_121_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1111ui_story"].transform.position).z)
				arg_121_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1111ui_story"].transform.localEulerAngles = arg_121_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1211ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1211ui_story = var_124_1.localPosition
			end

			local var_124_2 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 then
				var_124_1.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_121_1.time_ - 0) / var_124_2)
				var_124_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_1.position).x, (manager.ui.mainCamera.transform.position - var_124_1.position).y, (manager.ui.mainCamera.transform.position - var_124_1.position).z)
				var_124_1.localEulerAngles.z = 0
				var_124_1.localEulerAngles.x = 0
				var_124_1.localEulerAngles = var_124_1.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 then
				var_124_1.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				var_124_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_1.position).x, (manager.ui.mainCamera.transform.position - var_124_1.position).y, (manager.ui.mainCamera.transform.position - var_124_1.position).z)
				var_124_1.localEulerAngles.z = 0
				var_124_1.localEulerAngles.x = 0
				var_124_1.localEulerAngles = var_124_1.localEulerAngles
			end

			local var_124_3 = arg_121_1.actors_["1211ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_3) and arg_121_1.var_.characterEffect1211ui_story == nil then
				arg_121_1.var_.characterEffect1211ui_story = var_124_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_4 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 and not isNil(var_124_3) then
				if arg_121_1.var_.characterEffect1211ui_story and not isNil(var_124_3) then
					arg_121_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 and not isNil(var_124_3) and arg_121_1.var_.characterEffect1211ui_story then
				arg_121_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_124_6 = arg_121_1.actors_["1111ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1111ui_story == nil then
				arg_121_1.var_.characterEffect1111ui_story = var_124_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_7 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 and not isNil(var_124_6) then
				if arg_121_1.var_.characterEffect1111ui_story and not isNil(var_124_6) then
					arg_121_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_7)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1111ui_story then
				arg_121_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_2")
			end

			local var_124_8 = 0
			local var_124_9 = 0.3

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:GetWordFromCfg(322192029)
				local var_124_11 = arg_121_1:FormatText(var_124_10.content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 12 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 12)

				if (12 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 12)) > 0 and var_124_9 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192029", "story_v_out_322192.awb") ~= 0 then
					local var_124_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192029", "story_v_out_322192.awb") / 1000

					if var_124_14 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_8
					end

					if var_124_10.prefab_name ~= "" and arg_121_1.actors_[var_124_10.prefab_name] ~= nil then
						local var_124_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_10.prefab_name].transform, "story_v_out_322192", "322192029", "story_v_out_322192.awb")

						arg_121_1:RecordAudio("322192029", var_124_15)
						arg_121_1:RecordAudio("322192029", var_124_15)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_322192", "322192029", "story_v_out_322192.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_322192", "322192029", "story_v_out_322192.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_16 and arg_121_1.time_ < var_124_8 + var_124_16 + arg_124_0 then
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
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1111ui_story"]) and arg_125_1.var_.characterEffect1111ui_story == nil then
				arg_125_1.var_.characterEffect1111ui_story = arg_125_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1111ui_story"]) then
				if arg_125_1.var_.characterEffect1111ui_story and not isNil(arg_125_1.actors_["1111ui_story"]) then
					arg_125_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1111ui_story"]) and arg_125_1.var_.characterEffect1111ui_story then
				arg_125_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_128_2 = arg_125_1.actors_["1211ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect1211ui_story == nil then
				arg_125_1.var_.characterEffect1211ui_story = var_128_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_3 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.characterEffect1211ui_story and not isNil(var_128_2) then
					arg_125_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_3)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect1211ui_story then
				arg_125_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			local var_128_4 = 0
			local var_128_5 = 0.575

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(322192030)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 23 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 23)

				if (23 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 23)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192030", "story_v_out_322192.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192030", "story_v_out_322192.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_322192", "322192030", "story_v_out_322192.awb")

						arg_125_1:RecordAudio("322192030", var_128_11)
						arg_125_1:RecordAudio("322192030", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_322192", "322192030", "story_v_out_322192.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_322192", "322192030", "story_v_out_322192.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
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
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_2")
			end

			local var_132_0 = 0
			local var_132_1 = 0.35

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_2 = arg_129_1:GetWordFromCfg(322192031)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 14 <= 0 and var_132_1 or var_132_1 * (utf8.len(var_132_3) / 14)

				if (14 <= 0 and var_132_1 or var_132_1 * (utf8.len(var_132_3) / 14)) > 0 and var_132_1 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192031", "story_v_out_322192.awb") ~= 0 then
					local var_132_6 = manager.audio:GetVoiceLength("story_v_out_322192", "322192031", "story_v_out_322192.awb") / 1000

					if var_132_6 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_0
					end

					if var_132_2.prefab_name ~= "" and arg_129_1.actors_[var_132_2.prefab_name] ~= nil then
						local var_132_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_2.prefab_name].transform, "story_v_out_322192", "322192031", "story_v_out_322192.awb")

						arg_129_1:RecordAudio("322192031", var_132_7)
						arg_129_1:RecordAudio("322192031", var_132_7)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_322192", "322192031", "story_v_out_322192.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_322192", "322192031", "story_v_out_322192.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_8 and arg_129_1.time_ < var_132_0 + var_132_8 + arg_132_0 then
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
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1211ui_story"]) and arg_133_1.var_.characterEffect1211ui_story == nil then
				arg_133_1.var_.characterEffect1211ui_story = arg_133_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1211ui_story"]) then
				if arg_133_1.var_.characterEffect1211ui_story and not isNil(arg_133_1.actors_["1211ui_story"]) then
					arg_133_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1211ui_story"]) and arg_133_1.var_.characterEffect1211ui_story then
				arg_133_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_136_2 = arg_133_1.actors_["1111ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect1111ui_story == nil then
				arg_133_1.var_.characterEffect1111ui_story = var_136_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_3 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.characterEffect1111ui_story and not isNil(var_136_2) then
					arg_133_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_3)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect1111ui_story then
				arg_133_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action7_1")
			end

			local var_136_4 = 0
			local var_136_5 = 0.2

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(322192032)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 8 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 8)

				if (8 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 8)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192032", "story_v_out_322192.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192032", "story_v_out_322192.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_322192", "322192032", "story_v_out_322192.awb")

						arg_133_1:RecordAudio("322192032", var_136_11)
						arg_133_1:RecordAudio("322192032", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_322192", "322192032", "story_v_out_322192.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_322192", "322192032", "story_v_out_322192.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
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
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1111ui_story = arg_137_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).z)
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles = arg_137_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1111ui_story"].transform.position).z)
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1111ui_story"].transform.localEulerAngles = arg_137_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["1211ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1211ui_story = var_140_1.localPosition
			end

			local var_140_2 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 then
				var_140_1.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_2)
				var_140_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_1.position).x, (manager.ui.mainCamera.transform.position - var_140_1.position).y, (manager.ui.mainCamera.transform.position - var_140_1.position).z)
				var_140_1.localEulerAngles.z = 0
				var_140_1.localEulerAngles.x = 0
				var_140_1.localEulerAngles = var_140_1.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 then
				var_140_1.localPosition = Vector3.New(0, 100, 0)
				var_140_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_1.position).x, (manager.ui.mainCamera.transform.position - var_140_1.position).y, (manager.ui.mainCamera.transform.position - var_140_1.position).z)
				var_140_1.localEulerAngles.z = 0
				var_140_1.localEulerAngles.x = 0
				var_140_1.localEulerAngles = var_140_1.localEulerAngles
			end

			local var_140_3 = 0
			local var_140_4 = 1.175

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_3 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_5 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(322192033).content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 47 <= 0 and var_140_4 or var_140_4 * (utf8.len(var_140_5) / 47)

				if (47 <= 0 and var_140_4 or var_140_4 * (utf8.len(var_140_5) / 47)) > 0 and var_140_4 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_3 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_3
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_4, arg_137_1.talkMaxDuration)

			if var_140_3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_3 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_3) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_3 + var_140_8 and arg_137_1.time_ < var_140_3 + var_140_8 + arg_140_0 then
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
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1111ui_story = arg_141_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1111ui_story"].transform.position).z)
				arg_141_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1111ui_story"].transform.localEulerAngles = arg_141_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_141_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1111ui_story"].transform.position).z)
				arg_141_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1111ui_story"].transform.localEulerAngles = arg_141_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1111ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1111ui_story == nil then
				arg_141_1.var_.characterEffect1111ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1111ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1111ui_story then
				arg_141_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_144_4 = 0
			local var_144_5 = 0.625

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(322192034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 25 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 25)

				if (25 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 25)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192034", "story_v_out_322192.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192034", "story_v_out_322192.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_322192", "322192034", "story_v_out_322192.awb")

						arg_141_1:RecordAudio("322192034", var_144_11)
						arg_141_1:RecordAudio("322192034", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_322192", "322192034", "story_v_out_322192.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_322192", "322192034", "story_v_out_322192.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
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
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1111ui_story = arg_145_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1111ui_story"].transform.position).z)
				arg_145_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1111ui_story"].transform.localEulerAngles = arg_145_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_145_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1111ui_story"].transform.position).z)
				arg_145_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1111ui_story"].transform.localEulerAngles = arg_145_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1211ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1211ui_story = var_148_1.localPosition
			end

			local var_148_2 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 then
				var_148_1.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_145_1.time_ - 0) / var_148_2)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 then
				var_148_1.localPosition = Vector3.New(0.7, -0.67, -6.07)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			local var_148_3 = arg_145_1.actors_["1211ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_3) and arg_145_1.var_.characterEffect1211ui_story == nil then
				arg_145_1.var_.characterEffect1211ui_story = var_148_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_4 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 and not isNil(var_148_3) then
				if arg_145_1.var_.characterEffect1211ui_story and not isNil(var_148_3) then
					arg_145_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 and not isNil(var_148_3) and arg_145_1.var_.characterEffect1211ui_story then
				arg_145_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_148_6 = arg_145_1.actors_["1111ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1111ui_story == nil then
				arg_145_1.var_.characterEffect1111ui_story = var_148_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_7 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 and not isNil(var_148_6) then
				if arg_145_1.var_.characterEffect1111ui_story and not isNil(var_148_6) then
					arg_145_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_7)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1111ui_story then
				arg_145_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action7_2")
			end

			local var_148_8 = 0
			local var_148_9 = 0.25

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_10 = arg_145_1:GetWordFromCfg(322192035)
				local var_148_11 = arg_145_1:FormatText(var_148_10.content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 10 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 10)

				if (10 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 10)) > 0 and var_148_9 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192035", "story_v_out_322192.awb") ~= 0 then
					local var_148_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192035", "story_v_out_322192.awb") / 1000

					if var_148_14 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_8
					end

					if var_148_10.prefab_name ~= "" and arg_145_1.actors_[var_148_10.prefab_name] ~= nil then
						local var_148_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_10.prefab_name].transform, "story_v_out_322192", "322192035", "story_v_out_322192.awb")

						arg_145_1:RecordAudio("322192035", var_148_15)
						arg_145_1:RecordAudio("322192035", var_148_15)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_322192", "322192035", "story_v_out_322192.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_322192", "322192035", "story_v_out_322192.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_16 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_16 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_16

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_16 and arg_145_1.time_ < var_148_8 + var_148_16 + arg_148_0 then
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
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1111ui_story"]) and arg_149_1.var_.characterEffect1111ui_story == nil then
				arg_149_1.var_.characterEffect1111ui_story = arg_149_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1111ui_story"]) then
				if arg_149_1.var_.characterEffect1111ui_story and not isNil(arg_149_1.actors_["1111ui_story"]) then
					arg_149_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1111ui_story"]) and arg_149_1.var_.characterEffect1111ui_story then
				arg_149_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_152_2 = arg_149_1.actors_["1211ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1211ui_story == nil then
				arg_149_1.var_.characterEffect1211ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect1211ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1211ui_story then
				arg_149_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_1")
			end

			local var_152_4 = 0
			local var_152_5 = 0.85

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(322192036)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 34 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 34)

				if (34 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 34)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192036", "story_v_out_322192.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192036", "story_v_out_322192.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_322192", "322192036", "story_v_out_322192.awb")

						arg_149_1:RecordAudio("322192036", var_152_11)
						arg_149_1:RecordAudio("322192036", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_322192", "322192036", "story_v_out_322192.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_322192", "322192036", "story_v_out_322192.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
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
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_2")
			end

			local var_156_0 = 0
			local var_156_1 = 0.275

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_2 = arg_153_1:GetWordFromCfg(322192037)
				local var_156_3 = arg_153_1:FormatText(var_156_2.content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 11 <= 0 and var_156_1 or var_156_1 * (utf8.len(var_156_3) / 11)

				if (11 <= 0 and var_156_1 or var_156_1 * (utf8.len(var_156_3) / 11)) > 0 and var_156_1 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192037", "story_v_out_322192.awb") ~= 0 then
					local var_156_6 = manager.audio:GetVoiceLength("story_v_out_322192", "322192037", "story_v_out_322192.awb") / 1000

					if var_156_6 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_0
					end

					if var_156_2.prefab_name ~= "" and arg_153_1.actors_[var_156_2.prefab_name] ~= nil then
						local var_156_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_2.prefab_name].transform, "story_v_out_322192", "322192037", "story_v_out_322192.awb")

						arg_153_1:RecordAudio("322192037", var_156_7)
						arg_153_1:RecordAudio("322192037", var_156_7)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_322192", "322192037", "story_v_out_322192.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_322192", "322192037", "story_v_out_322192.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_8 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_8 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_8

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_8 and arg_153_1.time_ < var_156_0 + var_156_8 + arg_156_0 then
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
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1111ui_story = arg_157_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1111ui_story"].transform.position).z)
				arg_157_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1111ui_story"].transform.localEulerAngles = arg_157_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1111ui_story"].transform.position).z)
				arg_157_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1111ui_story"].transform.localEulerAngles = arg_157_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1211ui_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1211ui_story = var_160_1.localPosition
			end

			local var_160_2 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 then
				var_160_1.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_2)
				var_160_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_1.position).x, (manager.ui.mainCamera.transform.position - var_160_1.position).y, (manager.ui.mainCamera.transform.position - var_160_1.position).z)
				var_160_1.localEulerAngles.z = 0
				var_160_1.localEulerAngles.x = 0
				var_160_1.localEulerAngles = var_160_1.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 then
				var_160_1.localPosition = Vector3.New(0, 100, 0)
				var_160_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_1.position).x, (manager.ui.mainCamera.transform.position - var_160_1.position).y, (manager.ui.mainCamera.transform.position - var_160_1.position).z)
				var_160_1.localEulerAngles.z = 0
				var_160_1.localEulerAngles.x = 0
				var_160_1.localEulerAngles = var_160_1.localEulerAngles
			end

			local var_160_3 = 0
			local var_160_4 = 1.225

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_3 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_5 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(322192038).content)

				arg_157_1.text_.text = var_160_5

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_7 = 49 <= 0 and var_160_4 or var_160_4 * (utf8.len(var_160_5) / 49)

				if (49 <= 0 and var_160_4 or var_160_4 * (utf8.len(var_160_5) / 49)) > 0 and var_160_4 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_3 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_3
					end
				end

				arg_157_1.text_.text = var_160_5
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_8 = math.max(var_160_4, arg_157_1.talkMaxDuration)

			if var_160_3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_3 + var_160_8 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_3) / var_160_8

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_3 + var_160_8 and arg_157_1.time_ < var_160_3 + var_160_8 + arg_160_0 then
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
			local var_164_0 = 0.575

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1020].name)

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

				local var_164_1 = arg_161_1:GetWordFromCfg(322192039)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 23 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 23)

				if (23 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 23)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192039", "story_v_out_322192.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192039", "story_v_out_322192.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_322192", "322192039", "story_v_out_322192.awb")

						arg_161_1:RecordAudio("322192039", var_164_6)
						arg_161_1:RecordAudio("322192039", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_322192", "322192039", "story_v_out_322192.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_322192", "322192039", "story_v_out_322192.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
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
			local var_168_0 = 0.2

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[591].name)

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

				local var_168_1 = arg_165_1:GetWordFromCfg(322192040)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 8 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 8)

				if (8 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 8)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192040", "story_v_out_322192.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192040", "story_v_out_322192.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_322192", "322192040", "story_v_out_322192.awb")

						arg_165_1:RecordAudio("322192040", var_168_6)
						arg_165_1:RecordAudio("322192040", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_322192", "322192040", "story_v_out_322192.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_322192", "322192040", "story_v_out_322192.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
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
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1211ui_story = arg_169_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1211ui_story"].transform.position).z)
				arg_169_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1211ui_story"].transform.localEulerAngles = arg_169_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, -0.67, -6.07)
				arg_169_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1211ui_story"].transform.position).z)
				arg_169_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1211ui_story"].transform.localEulerAngles = arg_169_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1211ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1211ui_story == nil then
				arg_169_1.var_.characterEffect1211ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1211ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1211ui_story then
				arg_169_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action8_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_172_4 = 0
			local var_172_5 = 0.325

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(322192041)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 13 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 13)

				if (13 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 13)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192041", "story_v_out_322192.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192041", "story_v_out_322192.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_out_322192", "322192041", "story_v_out_322192.awb")

						arg_169_1:RecordAudio("322192041", var_172_11)
						arg_169_1:RecordAudio("322192041", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_322192", "322192041", "story_v_out_322192.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_322192", "322192041", "story_v_out_322192.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
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
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1211ui_story"]) and arg_173_1.var_.characterEffect1211ui_story == nil then
				arg_173_1.var_.characterEffect1211ui_story = arg_173_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1211ui_story"]) then
				if arg_173_1.var_.characterEffect1211ui_story and not isNil(arg_173_1.actors_["1211ui_story"]) then
					arg_173_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1211ui_story"]) and arg_173_1.var_.characterEffect1211ui_story then
				arg_173_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			local var_176_1 = 0
			local var_176_2 = 0.8

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[591].name)

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

				local var_176_3 = arg_173_1:GetWordFromCfg(322192042)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_6 = 32 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_4) / 32)

				if (32 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_4) / 32)) > 0 and var_176_2 < var_176_6 then
					arg_173_1.talkMaxDuration = var_176_6

					if var_176_6 + var_176_1 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_1
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192042", "story_v_out_322192.awb") ~= 0 then
					local var_176_7 = manager.audio:GetVoiceLength("story_v_out_322192", "322192042", "story_v_out_322192.awb") / 1000

					if var_176_7 + var_176_1 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_1
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_out_322192", "322192042", "story_v_out_322192.awb")

						arg_173_1:RecordAudio("322192042", var_176_8)
						arg_173_1:RecordAudio("322192042", var_176_8)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_322192", "322192042", "story_v_out_322192.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_322192", "322192042", "story_v_out_322192.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_9 = math.max(var_176_2, arg_173_1.talkMaxDuration)

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_9 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_1) / var_176_9

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_1 + var_176_9 and arg_173_1.time_ < var_176_1 + var_176_9 + arg_176_0 then
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
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1111ui_story"]) and arg_177_1.var_.characterEffect1111ui_story == nil then
				arg_177_1.var_.characterEffect1111ui_story = arg_177_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1111ui_story"]) then
				if arg_177_1.var_.characterEffect1111ui_story and not isNil(arg_177_1.actors_["1111ui_story"]) then
					arg_177_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1111ui_story"]) and arg_177_1.var_.characterEffect1111ui_story then
				arg_177_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_180_2 = arg_177_1.actors_["1211ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1211ui_story = var_180_2.localPosition
			end

			local var_180_3 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 then
				var_180_2.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 0) / var_180_3)
				var_180_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_2.position).x, (manager.ui.mainCamera.transform.position - var_180_2.position).y, (manager.ui.mainCamera.transform.position - var_180_2.position).z)
				var_180_2.localEulerAngles.z = 0
				var_180_2.localEulerAngles.x = 0
				var_180_2.localEulerAngles = var_180_2.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 then
				var_180_2.localPosition = Vector3.New(0, 100, 0)
				var_180_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_2.position).x, (manager.ui.mainCamera.transform.position - var_180_2.position).y, (manager.ui.mainCamera.transform.position - var_180_2.position).z)
				var_180_2.localEulerAngles.z = 0
				var_180_2.localEulerAngles.x = 0
				var_180_2.localEulerAngles = var_180_2.localEulerAngles
			end

			local var_180_4 = arg_177_1.actors_["1111ui_story"].transform

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1111ui_story = var_180_4.localPosition
			end

			local var_180_5 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_5 then
				var_180_4.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_177_1.time_ - 0) / var_180_5)
				var_180_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_4.position).x, (manager.ui.mainCamera.transform.position - var_180_4.position).y, (manager.ui.mainCamera.transform.position - var_180_4.position).z)
				var_180_4.localEulerAngles.z = 0
				var_180_4.localEulerAngles.x = 0
				var_180_4.localEulerAngles = var_180_4.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_5 and arg_177_1.time_ < 0 + var_180_5 + arg_180_0 then
				var_180_4.localPosition = Vector3.New(0, -0.87, -5.7)
				var_180_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_4.position).x, (manager.ui.mainCamera.transform.position - var_180_4.position).y, (manager.ui.mainCamera.transform.position - var_180_4.position).z)
				var_180_4.localEulerAngles.z = 0
				var_180_4.localEulerAngles.x = 0
				var_180_4.localEulerAngles = var_180_4.localEulerAngles
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_180_6 = 0
			local var_180_7 = 0.85

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:GetWordFromCfg(322192043)
				local var_180_9 = arg_177_1:FormatText(var_180_8.content)

				arg_177_1.text_.text = var_180_9

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 34 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 34)

				if (34 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 34)) > 0 and var_180_7 < var_180_11 then
					arg_177_1.talkMaxDuration = var_180_11

					if var_180_11 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_9
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192043", "story_v_out_322192.awb") ~= 0 then
					local var_180_12 = manager.audio:GetVoiceLength("story_v_out_322192", "322192043", "story_v_out_322192.awb") / 1000

					if var_180_12 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_6
					end

					if var_180_8.prefab_name ~= "" and arg_177_1.actors_[var_180_8.prefab_name] ~= nil then
						local var_180_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_8.prefab_name].transform, "story_v_out_322192", "322192043", "story_v_out_322192.awb")

						arg_177_1:RecordAudio("322192043", var_180_13)
						arg_177_1:RecordAudio("322192043", var_180_13)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_322192", "322192043", "story_v_out_322192.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_322192", "322192043", "story_v_out_322192.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_14 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_14 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_14

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_14 and arg_177_1.time_ < var_180_6 + var_180_14 + arg_180_0 then
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
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1111ui_story = arg_181_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1111ui_story"].transform.position).z)
				arg_181_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1111ui_story"].transform.localEulerAngles = arg_181_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1111ui_story"].transform.position).z)
				arg_181_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1111ui_story"].transform.localEulerAngles = arg_181_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_184_1 = 0
			local var_184_2 = 0.325

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(322192044).content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 13 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 13)

				if (13 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 13)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_6 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_6 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_6

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_6 and arg_181_1.time_ < var_184_1 + var_184_6 + arg_184_0 then
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
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1111ui_story = arg_185_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1111ui_story"].transform.position).z)
				arg_185_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1111ui_story"].transform.localEulerAngles = arg_185_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_185_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1111ui_story"].transform.position).z)
				arg_185_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1111ui_story"].transform.localEulerAngles = arg_185_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1111ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1111ui_story == nil then
				arg_185_1.var_.characterEffect1111ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1111ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1111ui_story then
				arg_185_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_188_4 = 0
			local var_188_5 = 0.35

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:GetWordFromCfg(322192045)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 14 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 14)

				if (14 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 14)) > 0 and var_188_5 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192045", "story_v_out_322192.awb") ~= 0 then
					local var_188_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192045", "story_v_out_322192.awb") / 1000

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end

					if var_188_6.prefab_name ~= "" and arg_185_1.actors_[var_188_6.prefab_name] ~= nil then
						local var_188_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_6.prefab_name].transform, "story_v_out_322192", "322192045", "story_v_out_322192.awb")

						arg_185_1:RecordAudio("322192045", var_188_11)
						arg_185_1:RecordAudio("322192045", var_188_11)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_322192", "322192045", "story_v_out_322192.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_322192", "322192045", "story_v_out_322192.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_12 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_12 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_12

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_12 and arg_185_1.time_ < var_188_4 + var_188_12 + arg_188_0 then
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
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1111ui_story"]) and arg_189_1.var_.characterEffect1111ui_story == nil then
				arg_189_1.var_.characterEffect1111ui_story = arg_189_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1111ui_story"]) then
				if arg_189_1.var_.characterEffect1111ui_story and not isNil(arg_189_1.actors_["1111ui_story"]) then
					arg_189_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_0)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1111ui_story"]) and arg_189_1.var_.characterEffect1111ui_story then
				arg_189_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_192_1 = 0
			local var_192_2 = 0.8

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[591].name)

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

				local var_192_3 = arg_189_1:GetWordFromCfg(322192046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_6 = 32 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_4) / 32)

				if (32 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_4) / 32)) > 0 and var_192_2 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192046", "story_v_out_322192.awb") ~= 0 then
					local var_192_7 = manager.audio:GetVoiceLength("story_v_out_322192", "322192046", "story_v_out_322192.awb") / 1000

					if var_192_7 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_1
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_322192", "322192046", "story_v_out_322192.awb")

						arg_189_1:RecordAudio("322192046", var_192_8)
						arg_189_1:RecordAudio("322192046", var_192_8)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_322192", "322192046", "story_v_out_322192.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_322192", "322192046", "story_v_out_322192.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_9 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_9 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_9

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_9 and arg_189_1.time_ < var_192_1 + var_192_9 + arg_192_0 then
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
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1111ui_story = arg_193_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1111ui_story"].transform.position).z)
				arg_193_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1111ui_story"].transform.localEulerAngles = arg_193_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_193_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1111ui_story"].transform.position).z)
				arg_193_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1111ui_story"].transform.localEulerAngles = arg_193_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1211ui_story"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1211ui_story = var_196_1.localPosition
			end

			local var_196_2 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 then
				var_196_1.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_193_1.time_ - 0) / var_196_2)
				var_196_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_1.position).x, (manager.ui.mainCamera.transform.position - var_196_1.position).y, (manager.ui.mainCamera.transform.position - var_196_1.position).z)
				var_196_1.localEulerAngles.z = 0
				var_196_1.localEulerAngles.x = 0
				var_196_1.localEulerAngles = var_196_1.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 then
				var_196_1.localPosition = Vector3.New(0.7, -0.67, -6.07)
				var_196_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_1.position).x, (manager.ui.mainCamera.transform.position - var_196_1.position).y, (manager.ui.mainCamera.transform.position - var_196_1.position).z)
				var_196_1.localEulerAngles.z = 0
				var_196_1.localEulerAngles.x = 0
				var_196_1.localEulerAngles = var_196_1.localEulerAngles
			end

			local var_196_3 = arg_193_1.actors_["1211ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_3) and arg_193_1.var_.characterEffect1211ui_story == nil then
				arg_193_1.var_.characterEffect1211ui_story = var_196_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_4 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 and not isNil(var_196_3) then
				if arg_193_1.var_.characterEffect1211ui_story and not isNil(var_196_3) then
					arg_193_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 and not isNil(var_196_3) and arg_193_1.var_.characterEffect1211ui_story then
				arg_193_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action2_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_196_6 = 0
			local var_196_7 = 0.45

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_8 = arg_193_1:GetWordFromCfg(322192047)
				local var_196_9 = arg_193_1:FormatText(var_196_8.content)

				arg_193_1.text_.text = var_196_9

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 18 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_9) / 18)

				if (18 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_9) / 18)) > 0 and var_196_7 < var_196_11 then
					arg_193_1.talkMaxDuration = var_196_11

					if var_196_11 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_9
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192047", "story_v_out_322192.awb") ~= 0 then
					local var_196_12 = manager.audio:GetVoiceLength("story_v_out_322192", "322192047", "story_v_out_322192.awb") / 1000

					if var_196_12 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_12 + var_196_6
					end

					if var_196_8.prefab_name ~= "" and arg_193_1.actors_[var_196_8.prefab_name] ~= nil then
						local var_196_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_8.prefab_name].transform, "story_v_out_322192", "322192047", "story_v_out_322192.awb")

						arg_193_1:RecordAudio("322192047", var_196_13)
						arg_193_1:RecordAudio("322192047", var_196_13)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_322192", "322192047", "story_v_out_322192.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_322192", "322192047", "story_v_out_322192.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_14 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_14 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_14

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_14 and arg_193_1.time_ < var_196_6 + var_196_14 + arg_196_0 then
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
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1111ui_story = arg_197_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1111ui_story"].transform.position).z)
				arg_197_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1111ui_story"].transform.localEulerAngles = arg_197_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1111ui_story"].transform.position).z)
				arg_197_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1111ui_story"].transform.localEulerAngles = arg_197_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["1211ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1211ui_story = var_200_1.localPosition
			end

			local var_200_2 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 then
				var_200_1.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_2)
				var_200_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_1.position).x, (manager.ui.mainCamera.transform.position - var_200_1.position).y, (manager.ui.mainCamera.transform.position - var_200_1.position).z)
				var_200_1.localEulerAngles.z = 0
				var_200_1.localEulerAngles.x = 0
				var_200_1.localEulerAngles = var_200_1.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 then
				var_200_1.localPosition = Vector3.New(0, 100, 0)
				var_200_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_1.position).x, (manager.ui.mainCamera.transform.position - var_200_1.position).y, (manager.ui.mainCamera.transform.position - var_200_1.position).z)
				var_200_1.localEulerAngles.z = 0
				var_200_1.localEulerAngles.x = 0
				var_200_1.localEulerAngles = var_200_1.localEulerAngles
			end

			local var_200_3 = arg_197_1.actors_["1043ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1043ui_story = var_200_3.localPosition
			end

			local var_200_4 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				var_200_3.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_197_1.time_ - 0) / var_200_4)
				var_200_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_3.position).x, (manager.ui.mainCamera.transform.position - var_200_3.position).y, (manager.ui.mainCamera.transform.position - var_200_3.position).z)
				var_200_3.localEulerAngles.z = 0
				var_200_3.localEulerAngles.x = 0
				var_200_3.localEulerAngles = var_200_3.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				var_200_3.localPosition = Vector3.New(0.01, -1.01, -5.73)
				var_200_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_3.position).x, (manager.ui.mainCamera.transform.position - var_200_3.position).y, (manager.ui.mainCamera.transform.position - var_200_3.position).z)
				var_200_3.localEulerAngles.z = 0
				var_200_3.localEulerAngles.x = 0
				var_200_3.localEulerAngles = var_200_3.localEulerAngles
			end

			local var_200_5 = arg_197_1.actors_["1043ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.characterEffect1043ui_story == nil then
				arg_197_1.var_.characterEffect1043ui_story = var_200_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_6 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_6 and not isNil(var_200_5) then
				if arg_197_1.var_.characterEffect1043ui_story and not isNil(var_200_5) then
					arg_197_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_6 and arg_197_1.time_ < 0 + var_200_6 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.characterEffect1043ui_story then
				arg_197_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_200_8 = arg_197_1.actors_["1211ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.characterEffect1211ui_story == nil then
				arg_197_1.var_.characterEffect1211ui_story = var_200_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_9 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_9 and not isNil(var_200_8) then
				if arg_197_1.var_.characterEffect1211ui_story and not isNil(var_200_8) then
					arg_197_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_9)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_9 and arg_197_1.time_ < 0 + var_200_9 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.characterEffect1211ui_story then
				arg_197_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_200_10 = 0
			local var_200_11 = 0.275

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_12 = arg_197_1:GetWordFromCfg(322192048)
				local var_200_13 = arg_197_1:FormatText(var_200_12.content)

				arg_197_1.text_.text = var_200_13

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_15 = 11 <= 0 and var_200_11 or var_200_11 * (utf8.len(var_200_13) / 11)

				if (11 <= 0 and var_200_11 or var_200_11 * (utf8.len(var_200_13) / 11)) > 0 and var_200_11 < var_200_15 then
					arg_197_1.talkMaxDuration = var_200_15

					if var_200_15 + var_200_10 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_15 + var_200_10
					end
				end

				arg_197_1.text_.text = var_200_13
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192048", "story_v_out_322192.awb") ~= 0 then
					local var_200_16 = manager.audio:GetVoiceLength("story_v_out_322192", "322192048", "story_v_out_322192.awb") / 1000

					if var_200_16 + var_200_10 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_16 + var_200_10
					end

					if var_200_12.prefab_name ~= "" and arg_197_1.actors_[var_200_12.prefab_name] ~= nil then
						local var_200_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_12.prefab_name].transform, "story_v_out_322192", "322192048", "story_v_out_322192.awb")

						arg_197_1:RecordAudio("322192048", var_200_17)
						arg_197_1:RecordAudio("322192048", var_200_17)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_322192", "322192048", "story_v_out_322192.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_322192", "322192048", "story_v_out_322192.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_18 = math.max(var_200_11, arg_197_1.talkMaxDuration)

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_18 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_10) / var_200_18

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_10 + var_200_18 and arg_197_1.time_ < var_200_10 + var_200_18 + arg_200_0 then
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
			local var_204_0 = 1.025

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:GetWordFromCfg(322192049)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 41 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 41)

				if (41 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 41)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192049", "story_v_out_322192.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192049", "story_v_out_322192.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_322192", "322192049", "story_v_out_322192.awb")

						arg_201_1:RecordAudio("322192049", var_204_6)
						arg_201_1:RecordAudio("322192049", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_322192", "322192049", "story_v_out_322192.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_322192", "322192049", "story_v_out_322192.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
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
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_2")
			end

			local var_208_0 = 0
			local var_208_1 = 0.55

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_2 = arg_205_1:GetWordFromCfg(322192050)
				local var_208_3 = arg_205_1:FormatText(var_208_2.content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 22 <= 0 and var_208_1 or var_208_1 * (utf8.len(var_208_3) / 22)

				if (22 <= 0 and var_208_1 or var_208_1 * (utf8.len(var_208_3) / 22)) > 0 and var_208_1 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192050", "story_v_out_322192.awb") ~= 0 then
					local var_208_6 = manager.audio:GetVoiceLength("story_v_out_322192", "322192050", "story_v_out_322192.awb") / 1000

					if var_208_6 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_0
					end

					if var_208_2.prefab_name ~= "" and arg_205_1.actors_[var_208_2.prefab_name] ~= nil then
						local var_208_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_2.prefab_name].transform, "story_v_out_322192", "322192050", "story_v_out_322192.awb")

						arg_205_1:RecordAudio("322192050", var_208_7)
						arg_205_1:RecordAudio("322192050", var_208_7)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_322192", "322192050", "story_v_out_322192.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_322192", "322192050", "story_v_out_322192.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_8 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_8 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_8

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_8 and arg_205_1.time_ < var_208_0 + var_208_8 + arg_208_0 then
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
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1043ui_story = arg_209_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1043ui_story"].transform.position).z)
				arg_209_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1043ui_story"].transform.localEulerAngles = arg_209_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1043ui_story"].transform.position).z)
				arg_209_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1043ui_story"].transform.localEulerAngles = arg_209_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_212_1 = 0
			local var_212_2 = 0.775

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_3 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(322192051).content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 31 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 31)

				if (31 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 31)) > 0 and var_212_2 < var_212_5 then
					arg_209_1.talkMaxDuration = var_212_5

					if var_212_5 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + var_212_1
					end
				end

				arg_209_1.text_.text = var_212_3
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_6 = math.max(var_212_2, arg_209_1.talkMaxDuration)

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_6 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_1) / var_212_6

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_1 + var_212_6 and arg_209_1.time_ < var_212_1 + var_212_6 + arg_212_0 then
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
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1043ui_story = arg_213_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1043ui_story"].transform.position).z)
				arg_213_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1043ui_story"].transform.localEulerAngles = arg_213_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_213_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1043ui_story"].transform.position).z)
				arg_213_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1043ui_story"].transform.localEulerAngles = arg_213_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1043ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1043ui_story == nil then
				arg_213_1.var_.characterEffect1043ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1043ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1043ui_story then
				arg_213_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_216_4 = 0
			local var_216_5 = 0.2

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(322192052)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 8 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 8)

				if (8 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 8)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192052", "story_v_out_322192.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192052", "story_v_out_322192.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_out_322192", "322192052", "story_v_out_322192.awb")

						arg_213_1:RecordAudio("322192052", var_216_11)
						arg_213_1:RecordAudio("322192052", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_322192", "322192052", "story_v_out_322192.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_322192", "322192052", "story_v_out_322192.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
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
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1043ui_story = arg_217_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1043ui_story, Vector3.New(-0.92, -1.01, -5.73), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1043ui_story"].transform.position).z)
				arg_217_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1043ui_story"].transform.localEulerAngles = arg_217_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(-0.92, -1.01, -5.73)
				arg_217_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1043ui_story"].transform.position).z)
				arg_217_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1043ui_story"].transform.localEulerAngles = arg_217_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["1111ui_story"].transform

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1111ui_story = var_220_1.localPosition
			end

			local var_220_2 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 then
				var_220_1.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_217_1.time_ - 0) / var_220_2)
				var_220_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_1.position).x, (manager.ui.mainCamera.transform.position - var_220_1.position).y, (manager.ui.mainCamera.transform.position - var_220_1.position).z)
				var_220_1.localEulerAngles.z = 0
				var_220_1.localEulerAngles.x = 0
				var_220_1.localEulerAngles = var_220_1.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 then
				var_220_1.localPosition = Vector3.New(0.7, -0.87, -5.7)
				var_220_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_1.position).x, (manager.ui.mainCamera.transform.position - var_220_1.position).y, (manager.ui.mainCamera.transform.position - var_220_1.position).z)
				var_220_1.localEulerAngles.z = 0
				var_220_1.localEulerAngles.x = 0
				var_220_1.localEulerAngles = var_220_1.localEulerAngles
			end

			local var_220_3 = arg_217_1.actors_["1111ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_3) and arg_217_1.var_.characterEffect1111ui_story == nil then
				arg_217_1.var_.characterEffect1111ui_story = var_220_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_4 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 and not isNil(var_220_3) then
				if arg_217_1.var_.characterEffect1111ui_story and not isNil(var_220_3) then
					arg_217_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 and not isNil(var_220_3) and arg_217_1.var_.characterEffect1111ui_story then
				arg_217_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_220_6 = arg_217_1.actors_["1043ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_6) and arg_217_1.var_.characterEffect1043ui_story == nil then
				arg_217_1.var_.characterEffect1043ui_story = var_220_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_7 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 and not isNil(var_220_6) then
				if arg_217_1.var_.characterEffect1043ui_story and not isNil(var_220_6) then
					arg_217_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_7)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 and not isNil(var_220_6) and arg_217_1.var_.characterEffect1043ui_story then
				arg_217_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_220_8 = 0
			local var_220_9 = 0.475

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_10 = arg_217_1:GetWordFromCfg(322192053)
				local var_220_11 = arg_217_1:FormatText(var_220_10.content)

				arg_217_1.text_.text = var_220_11

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_13 = 19 <= 0 and var_220_9 or var_220_9 * (utf8.len(var_220_11) / 19)

				if (19 <= 0 and var_220_9 or var_220_9 * (utf8.len(var_220_11) / 19)) > 0 and var_220_9 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_8
					end
				end

				arg_217_1.text_.text = var_220_11
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192053", "story_v_out_322192.awb") ~= 0 then
					local var_220_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192053", "story_v_out_322192.awb") / 1000

					if var_220_14 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_14 + var_220_8
					end

					if var_220_10.prefab_name ~= "" and arg_217_1.actors_[var_220_10.prefab_name] ~= nil then
						local var_220_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_10.prefab_name].transform, "story_v_out_322192", "322192053", "story_v_out_322192.awb")

						arg_217_1:RecordAudio("322192053", var_220_15)
						arg_217_1:RecordAudio("322192053", var_220_15)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_322192", "322192053", "story_v_out_322192.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_322192", "322192053", "story_v_out_322192.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_16 = math.max(var_220_9, arg_217_1.talkMaxDuration)

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_16 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_8) / var_220_16

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_8 + var_220_16 and arg_217_1.time_ < var_220_8 + var_220_16 + arg_220_0 then
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
			local var_224_0 = 0.55

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:GetWordFromCfg(322192054)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 22 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 22)

				if (22 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 22)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192054", "story_v_out_322192.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192054", "story_v_out_322192.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_322192", "322192054", "story_v_out_322192.awb")

						arg_221_1:RecordAudio("322192054", var_224_6)
						arg_221_1:RecordAudio("322192054", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_322192", "322192054", "story_v_out_322192.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_322192", "322192054", "story_v_out_322192.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
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
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_1")
			end

			local var_228_0 = 0
			local var_228_1 = 0.425

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_2 = arg_225_1:GetWordFromCfg(322192055)
				local var_228_3 = arg_225_1:FormatText(var_228_2.content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 17 <= 0 and var_228_1 or var_228_1 * (utf8.len(var_228_3) / 17)

				if (17 <= 0 and var_228_1 or var_228_1 * (utf8.len(var_228_3) / 17)) > 0 and var_228_1 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192055", "story_v_out_322192.awb") ~= 0 then
					local var_228_6 = manager.audio:GetVoiceLength("story_v_out_322192", "322192055", "story_v_out_322192.awb") / 1000

					if var_228_6 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_0
					end

					if var_228_2.prefab_name ~= "" and arg_225_1.actors_[var_228_2.prefab_name] ~= nil then
						local var_228_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_2.prefab_name].transform, "story_v_out_322192", "322192055", "story_v_out_322192.awb")

						arg_225_1:RecordAudio("322192055", var_228_7)
						arg_225_1:RecordAudio("322192055", var_228_7)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_322192", "322192055", "story_v_out_322192.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_322192", "322192055", "story_v_out_322192.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_8 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_8 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_8

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_8 and arg_225_1.time_ < var_228_0 + var_228_8 + arg_228_0 then
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
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1043ui_story = arg_229_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1043ui_story"].transform.position).z)
				arg_229_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1043ui_story"].transform.localEulerAngles = arg_229_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1043ui_story"].transform.position).z)
				arg_229_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1043ui_story"].transform.localEulerAngles = arg_229_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["1111ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1111ui_story = var_232_1.localPosition
			end

			local var_232_2 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 then
				var_232_1.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 0) / var_232_2)
				var_232_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_1.position).x, (manager.ui.mainCamera.transform.position - var_232_1.position).y, (manager.ui.mainCamera.transform.position - var_232_1.position).z)
				var_232_1.localEulerAngles.z = 0
				var_232_1.localEulerAngles.x = 0
				var_232_1.localEulerAngles = var_232_1.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 then
				var_232_1.localPosition = Vector3.New(0, 100, 0)
				var_232_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_1.position).x, (manager.ui.mainCamera.transform.position - var_232_1.position).y, (manager.ui.mainCamera.transform.position - var_232_1.position).z)
				var_232_1.localEulerAngles.z = 0
				var_232_1.localEulerAngles.x = 0
				var_232_1.localEulerAngles = var_232_1.localEulerAngles
			end

			local var_232_3 = 0
			local var_232_4 = 1.175

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_3 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_5 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(322192056).content)

				arg_229_1.text_.text = var_232_5

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_7 = 47 <= 0 and var_232_4 or var_232_4 * (utf8.len(var_232_5) / 47)

				if (47 <= 0 and var_232_4 or var_232_4 * (utf8.len(var_232_5) / 47)) > 0 and var_232_4 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_3 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_3
					end
				end

				arg_229_1.text_.text = var_232_5
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_8 = math.max(var_232_4, arg_229_1.talkMaxDuration)

			if var_232_3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_3 + var_232_8 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_3) / var_232_8

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_3 + var_232_8 and arg_229_1.time_ < var_232_3 + var_232_8 + arg_232_0 then
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
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1211ui_story = arg_233_1.actors_["1211ui_story"].transform.localPosition

				arg_233_1:ShowWeapon(arg_233_1.var_["1211ui_story" .. "Animator"].transform, false)
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1211ui_story"].transform.position).z)
				arg_233_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1211ui_story"].transform.localEulerAngles = arg_233_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, -0.67, -6.07)
				arg_233_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1211ui_story"].transform.position).z)
				arg_233_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1211ui_story"].transform.localEulerAngles = arg_233_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1211ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1211ui_story == nil then
				arg_233_1.var_.characterEffect1211ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect1211ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1211ui_story then
				arg_233_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_236_4 = 0
			local var_236_5 = 0.45

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(322192057)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 18 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 18)

				if (18 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 18)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192057", "story_v_out_322192.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192057", "story_v_out_322192.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_out_322192", "322192057", "story_v_out_322192.awb")

						arg_233_1:RecordAudio("322192057", var_236_11)
						arg_233_1:RecordAudio("322192057", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_322192", "322192057", "story_v_out_322192.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_322192", "322192057", "story_v_out_322192.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_12 and arg_233_1.time_ < var_236_4 + var_236_12 + arg_236_0 then
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
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1111ui_story = arg_237_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1111ui_story"].transform.position).z)
				arg_237_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1111ui_story"].transform.localEulerAngles = arg_237_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_237_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1111ui_story"].transform.position).z)
				arg_237_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1111ui_story"].transform.localEulerAngles = arg_237_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["1211ui_story"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1211ui_story = var_240_1.localPosition
			end

			local var_240_2 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 then
				var_240_1.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_237_1.time_ - 0) / var_240_2)
				var_240_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_1.position).x, (manager.ui.mainCamera.transform.position - var_240_1.position).y, (manager.ui.mainCamera.transform.position - var_240_1.position).z)
				var_240_1.localEulerAngles.z = 0
				var_240_1.localEulerAngles.x = 0
				var_240_1.localEulerAngles = var_240_1.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 then
				var_240_1.localPosition = Vector3.New(0, 100, 0)
				var_240_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_1.position).x, (manager.ui.mainCamera.transform.position - var_240_1.position).y, (manager.ui.mainCamera.transform.position - var_240_1.position).z)
				var_240_1.localEulerAngles.z = 0
				var_240_1.localEulerAngles.x = 0
				var_240_1.localEulerAngles = var_240_1.localEulerAngles
			end

			local var_240_3 = arg_237_1.actors_["1111ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_3) and arg_237_1.var_.characterEffect1111ui_story == nil then
				arg_237_1.var_.characterEffect1111ui_story = var_240_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_4 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 and not isNil(var_240_3) then
				if arg_237_1.var_.characterEffect1111ui_story and not isNil(var_240_3) then
					arg_237_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 and not isNil(var_240_3) and arg_237_1.var_.characterEffect1111ui_story then
				arg_237_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_240_6 = arg_237_1.actors_["1211ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_6) and arg_237_1.var_.characterEffect1211ui_story == nil then
				arg_237_1.var_.characterEffect1211ui_story = var_240_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_7 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_7 and not isNil(var_240_6) then
				if arg_237_1.var_.characterEffect1211ui_story and not isNil(var_240_6) then
					arg_237_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_7)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_7 and arg_237_1.time_ < 0 + var_240_7 + arg_240_0 and not isNil(var_240_6) and arg_237_1.var_.characterEffect1211ui_story then
				arg_237_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_240_8 = 0
			local var_240_9 = 0.275

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_10 = arg_237_1:GetWordFromCfg(322192058)
				local var_240_11 = arg_237_1:FormatText(var_240_10.content)

				arg_237_1.text_.text = var_240_11

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_13 = 11 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 11)

				if (11 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 11)) > 0 and var_240_9 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_8
					end
				end

				arg_237_1.text_.text = var_240_11
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192058", "story_v_out_322192.awb") ~= 0 then
					local var_240_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192058", "story_v_out_322192.awb") / 1000

					if var_240_14 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_8
					end

					if var_240_10.prefab_name ~= "" and arg_237_1.actors_[var_240_10.prefab_name] ~= nil then
						local var_240_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_10.prefab_name].transform, "story_v_out_322192", "322192058", "story_v_out_322192.awb")

						arg_237_1:RecordAudio("322192058", var_240_15)
						arg_237_1:RecordAudio("322192058", var_240_15)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_322192", "322192058", "story_v_out_322192.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_322192", "322192058", "story_v_out_322192.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_16 = math.max(var_240_9, arg_237_1.talkMaxDuration)

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_16 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_8) / var_240_16

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_8 + var_240_16 and arg_237_1.time_ < var_240_8 + var_240_16 + arg_240_0 then
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
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1111ui_story = arg_241_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1111ui_story"].transform.position).z)
				arg_241_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1111ui_story"].transform.localEulerAngles = arg_241_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_241_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1111ui_story"].transform.position).z)
				arg_241_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1111ui_story"].transform.localEulerAngles = arg_241_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1211ui_story"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1211ui_story = var_244_1.localPosition
			end

			local var_244_2 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 then
				var_244_1.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_241_1.time_ - 0) / var_244_2)
				var_244_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_1.position).x, (manager.ui.mainCamera.transform.position - var_244_1.position).y, (manager.ui.mainCamera.transform.position - var_244_1.position).z)
				var_244_1.localEulerAngles.z = 0
				var_244_1.localEulerAngles.x = 0
				var_244_1.localEulerAngles = var_244_1.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 then
				var_244_1.localPosition = Vector3.New(0.7, -0.67, -6.07)
				var_244_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_1.position).x, (manager.ui.mainCamera.transform.position - var_244_1.position).y, (manager.ui.mainCamera.transform.position - var_244_1.position).z)
				var_244_1.localEulerAngles.z = 0
				var_244_1.localEulerAngles.x = 0
				var_244_1.localEulerAngles = var_244_1.localEulerAngles
			end

			local var_244_3 = arg_241_1.actors_["1211ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_3) and arg_241_1.var_.characterEffect1211ui_story == nil then
				arg_241_1.var_.characterEffect1211ui_story = var_244_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_4 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 and not isNil(var_244_3) then
				if arg_241_1.var_.characterEffect1211ui_story and not isNil(var_244_3) then
					arg_241_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 and not isNil(var_244_3) and arg_241_1.var_.characterEffect1211ui_story then
				arg_241_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_244_6 = arg_241_1.actors_["1111ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_6) and arg_241_1.var_.characterEffect1111ui_story == nil then
				arg_241_1.var_.characterEffect1111ui_story = var_244_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_7 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 and not isNil(var_244_6) then
				if arg_241_1.var_.characterEffect1111ui_story and not isNil(var_244_6) then
					arg_241_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_7)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 and not isNil(var_244_6) and arg_241_1.var_.characterEffect1111ui_story then
				arg_241_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211actionlink/1211action435")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_244_8 = 0
			local var_244_9 = 1.05

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_8 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_10 = arg_241_1:GetWordFromCfg(322192059)
				local var_244_11 = arg_241_1:FormatText(var_244_10.content)

				arg_241_1.text_.text = var_244_11

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_13 = 42 <= 0 and var_244_9 or var_244_9 * (utf8.len(var_244_11) / 42)

				if (42 <= 0 and var_244_9 or var_244_9 * (utf8.len(var_244_11) / 42)) > 0 and var_244_9 < var_244_13 then
					arg_241_1.talkMaxDuration = var_244_13

					if var_244_13 + var_244_8 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_8
					end
				end

				arg_241_1.text_.text = var_244_11
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192059", "story_v_out_322192.awb") ~= 0 then
					local var_244_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192059", "story_v_out_322192.awb") / 1000

					if var_244_14 + var_244_8 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_14 + var_244_8
					end

					if var_244_10.prefab_name ~= "" and arg_241_1.actors_[var_244_10.prefab_name] ~= nil then
						local var_244_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_10.prefab_name].transform, "story_v_out_322192", "322192059", "story_v_out_322192.awb")

						arg_241_1:RecordAudio("322192059", var_244_15)
						arg_241_1:RecordAudio("322192059", var_244_15)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_322192", "322192059", "story_v_out_322192.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_322192", "322192059", "story_v_out_322192.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_16 = math.max(var_244_9, arg_241_1.talkMaxDuration)

			if var_244_8 <= arg_241_1.time_ and arg_241_1.time_ < var_244_8 + var_244_16 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_8) / var_244_16

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_8 + var_244_16 and arg_241_1.time_ < var_244_8 + var_244_16 + arg_244_0 then
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
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1111ui_story"]) and arg_245_1.var_.characterEffect1111ui_story == nil then
				arg_245_1.var_.characterEffect1111ui_story = arg_245_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1111ui_story"]) then
				if arg_245_1.var_.characterEffect1111ui_story and not isNil(arg_245_1.actors_["1111ui_story"]) then
					arg_245_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1111ui_story"]) and arg_245_1.var_.characterEffect1111ui_story then
				arg_245_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_248_2 = arg_245_1.actors_["1211ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.characterEffect1211ui_story == nil then
				arg_245_1.var_.characterEffect1211ui_story = var_248_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_3 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_3 and not isNil(var_248_2) then
				if arg_245_1.var_.characterEffect1211ui_story and not isNil(var_248_2) then
					arg_245_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_3)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_3 and arg_245_1.time_ < 0 + var_248_3 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.characterEffect1211ui_story then
				arg_245_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_248_4 = 0
			local var_248_5 = 0.225

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_6 = arg_245_1:GetWordFromCfg(322192060)
				local var_248_7 = arg_245_1:FormatText(var_248_6.content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 9 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 9)

				if (9 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 9)) > 0 and var_248_5 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192060", "story_v_out_322192.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192060", "story_v_out_322192.awb") / 1000

					if var_248_10 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_4
					end

					if var_248_6.prefab_name ~= "" and arg_245_1.actors_[var_248_6.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_6.prefab_name].transform, "story_v_out_322192", "322192060", "story_v_out_322192.awb")

						arg_245_1:RecordAudio("322192060", var_248_11)
						arg_245_1:RecordAudio("322192060", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_322192", "322192060", "story_v_out_322192.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_322192", "322192060", "story_v_out_322192.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_12 = math.max(var_248_5, arg_245_1.talkMaxDuration)

			if var_248_4 <= arg_245_1.time_ and arg_245_1.time_ < var_248_4 + var_248_12 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_4) / var_248_12

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_4 + var_248_12 and arg_245_1.time_ < var_248_4 + var_248_12 + arg_248_0 then
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
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1211ui_story"]) and arg_249_1.var_.characterEffect1211ui_story == nil then
				arg_249_1.var_.characterEffect1211ui_story = arg_249_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1211ui_story"]) then
				if arg_249_1.var_.characterEffect1211ui_story and not isNil(arg_249_1.actors_["1211ui_story"]) then
					arg_249_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1211ui_story"]) and arg_249_1.var_.characterEffect1211ui_story then
				arg_249_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_252_2 = arg_249_1.actors_["1111ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.characterEffect1111ui_story == nil then
				arg_249_1.var_.characterEffect1111ui_story = var_252_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_3 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_3 and not isNil(var_252_2) then
				if arg_249_1.var_.characterEffect1111ui_story and not isNil(var_252_2) then
					arg_249_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_3)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_3 and arg_249_1.time_ < 0 + var_252_3 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.characterEffect1111ui_story then
				arg_249_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_2")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_252_4 = 0
			local var_252_5 = 0.325

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(322192061)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 13 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 13)

				if (13 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 13)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192061", "story_v_out_322192.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192061", "story_v_out_322192.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_322192", "322192061", "story_v_out_322192.awb")

						arg_249_1:RecordAudio("322192061", var_252_11)
						arg_249_1:RecordAudio("322192061", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_322192", "322192061", "story_v_out_322192.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_322192", "322192061", "story_v_out_322192.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_12 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_12 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_12

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_12 and arg_249_1.time_ < var_252_4 + var_252_12 + arg_252_0 then
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
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1111ui_story"]) and arg_253_1.var_.characterEffect1111ui_story == nil then
				arg_253_1.var_.characterEffect1111ui_story = arg_253_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1111ui_story"]) then
				if arg_253_1.var_.characterEffect1111ui_story and not isNil(arg_253_1.actors_["1111ui_story"]) then
					arg_253_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1111ui_story"]) and arg_253_1.var_.characterEffect1111ui_story then
				arg_253_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_256_2 = arg_253_1.actors_["1211ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.characterEffect1211ui_story == nil then
				arg_253_1.var_.characterEffect1211ui_story = var_256_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_3 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 and not isNil(var_256_2) then
				if arg_253_1.var_.characterEffect1211ui_story and not isNil(var_256_2) then
					arg_253_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_3)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.characterEffect1211ui_story then
				arg_253_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_256_4 = 0
			local var_256_5 = 0.25

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_6 = arg_253_1:GetWordFromCfg(322192062)
				local var_256_7 = arg_253_1:FormatText(var_256_6.content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 10 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 10)

				if (10 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 10)) > 0 and var_256_5 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192062", "story_v_out_322192.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192062", "story_v_out_322192.awb") / 1000

					if var_256_10 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_4
					end

					if var_256_6.prefab_name ~= "" and arg_253_1.actors_[var_256_6.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_6.prefab_name].transform, "story_v_out_322192", "322192062", "story_v_out_322192.awb")

						arg_253_1:RecordAudio("322192062", var_256_11)
						arg_253_1:RecordAudio("322192062", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_322192", "322192062", "story_v_out_322192.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_322192", "322192062", "story_v_out_322192.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_12 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_12 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_12

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_12 and arg_253_1.time_ < var_256_4 + var_256_12 + arg_256_0 then
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
			local var_260_0 = 0.85

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:GetWordFromCfg(322192063)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 34 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 34)

				if (34 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 34)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192063", "story_v_out_322192.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192063", "story_v_out_322192.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_322192", "322192063", "story_v_out_322192.awb")

						arg_257_1:RecordAudio("322192063", var_260_6)
						arg_257_1:RecordAudio("322192063", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_322192", "322192063", "story_v_out_322192.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_322192", "322192063", "story_v_out_322192.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
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
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1211ui_story"]) and arg_261_1.var_.characterEffect1211ui_story == nil then
				arg_261_1.var_.characterEffect1211ui_story = arg_261_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1211ui_story"]) then
				if arg_261_1.var_.characterEffect1211ui_story and not isNil(arg_261_1.actors_["1211ui_story"]) then
					arg_261_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1211ui_story"]) and arg_261_1.var_.characterEffect1211ui_story then
				arg_261_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_264_2 = arg_261_1.actors_["1111ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.characterEffect1111ui_story == nil then
				arg_261_1.var_.characterEffect1111ui_story = var_264_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_3 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.characterEffect1111ui_story and not isNil(var_264_2) then
					arg_261_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_3)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.characterEffect1111ui_story then
				arg_261_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_1")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_264_4 = 0
			local var_264_5 = 0.5

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(322192064)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 20 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 20)

				if (20 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 20)) > 0 and var_264_5 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192064", "story_v_out_322192.awb") ~= 0 then
					local var_264_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192064", "story_v_out_322192.awb") / 1000

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end

					if var_264_6.prefab_name ~= "" and arg_261_1.actors_[var_264_6.prefab_name] ~= nil then
						local var_264_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_6.prefab_name].transform, "story_v_out_322192", "322192064", "story_v_out_322192.awb")

						arg_261_1:RecordAudio("322192064", var_264_11)
						arg_261_1:RecordAudio("322192064", var_264_11)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_322192", "322192064", "story_v_out_322192.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_322192", "322192064", "story_v_out_322192.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_12 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_12 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_12

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_12 and arg_261_1.time_ < var_264_4 + var_264_12 + arg_264_0 then
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
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1111ui_story"]) and arg_265_1.var_.characterEffect1111ui_story == nil then
				arg_265_1.var_.characterEffect1111ui_story = arg_265_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1111ui_story"]) then
				if arg_265_1.var_.characterEffect1111ui_story and not isNil(arg_265_1.actors_["1111ui_story"]) then
					arg_265_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1111ui_story"]) and arg_265_1.var_.characterEffect1111ui_story then
				arg_265_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_268_2 = arg_265_1.actors_["1211ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect1211ui_story == nil then
				arg_265_1.var_.characterEffect1211ui_story = var_268_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_3 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.characterEffect1211ui_story and not isNil(var_268_2) then
					arg_265_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_3)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect1211ui_story then
				arg_265_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_268_4 = 0
			local var_268_5 = 0.5

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(322192065)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 20 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 20)

				if (20 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 20)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192065", "story_v_out_322192.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192065", "story_v_out_322192.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_out_322192", "322192065", "story_v_out_322192.awb")

						arg_265_1:RecordAudio("322192065", var_268_11)
						arg_265_1:RecordAudio("322192065", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_322192", "322192065", "story_v_out_322192.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_322192", "322192065", "story_v_out_322192.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
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
			local var_272_0 = 1.025

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:GetWordFromCfg(322192066)
				local var_272_2 = arg_269_1:FormatText(var_272_1.content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 41 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 41)

				if (41 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 41)) > 0 and var_272_0 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192066", "story_v_out_322192.awb") ~= 0 then
					local var_272_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192066", "story_v_out_322192.awb") / 1000

					if var_272_5 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + 0
					end

					if var_272_1.prefab_name ~= "" and arg_269_1.actors_[var_272_1.prefab_name] ~= nil then
						local var_272_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_1.prefab_name].transform, "story_v_out_322192", "322192066", "story_v_out_322192.awb")

						arg_269_1:RecordAudio("322192066", var_272_6)
						arg_269_1:RecordAudio("322192066", var_272_6)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_322192", "322192066", "story_v_out_322192.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_322192", "322192066", "story_v_out_322192.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_7 and arg_269_1.time_ < 0 + var_272_7 + arg_272_0 then
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
			local var_276_0 = 0.975

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:GetWordFromCfg(322192067)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 39 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 39)

				if (39 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 39)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192067", "story_v_out_322192.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192067", "story_v_out_322192.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_322192", "322192067", "story_v_out_322192.awb")

						arg_273_1:RecordAudio("322192067", var_276_6)
						arg_273_1:RecordAudio("322192067", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322192", "322192067", "story_v_out_322192.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322192", "322192067", "story_v_out_322192.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
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
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_280_0 = 0
			local var_280_1 = 1

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_2 = arg_277_1:GetWordFromCfg(322192068)
				local var_280_3 = arg_277_1:FormatText(var_280_2.content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 40 <= 0 and var_280_1 or var_280_1 * (utf8.len(var_280_3) / 40)

				if (40 <= 0 and var_280_1 or var_280_1 * (utf8.len(var_280_3) / 40)) > 0 and var_280_1 < var_280_5 then
					arg_277_1.talkMaxDuration = var_280_5

					if var_280_5 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192068", "story_v_out_322192.awb") ~= 0 then
					local var_280_6 = manager.audio:GetVoiceLength("story_v_out_322192", "322192068", "story_v_out_322192.awb") / 1000

					if var_280_6 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_6 + var_280_0
					end

					if var_280_2.prefab_name ~= "" and arg_277_1.actors_[var_280_2.prefab_name] ~= nil then
						local var_280_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_2.prefab_name].transform, "story_v_out_322192", "322192068", "story_v_out_322192.awb")

						arg_277_1:RecordAudio("322192068", var_280_7)
						arg_277_1:RecordAudio("322192068", var_280_7)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322192", "322192068", "story_v_out_322192.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322192", "322192068", "story_v_out_322192.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_8 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_8 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_8

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_8 and arg_277_1.time_ < var_280_0 + var_280_8 + arg_280_0 then
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
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1211ui_story"]) and arg_281_1.var_.characterEffect1211ui_story == nil then
				arg_281_1.var_.characterEffect1211ui_story = arg_281_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1211ui_story"]) then
				if arg_281_1.var_.characterEffect1211ui_story and not isNil(arg_281_1.actors_["1211ui_story"]) then
					arg_281_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1211ui_story"]) and arg_281_1.var_.characterEffect1211ui_story then
				arg_281_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_284_2 = arg_281_1.actors_["1111ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect1111ui_story == nil then
				arg_281_1.var_.characterEffect1111ui_story = var_284_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_3 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.characterEffect1111ui_story and not isNil(var_284_2) then
					arg_281_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_3)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect1111ui_story then
				arg_281_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_2")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_284_4 = 0
			local var_284_5 = 0.5

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(322192069)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 20 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 20)

				if (20 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 20)) > 0 and var_284_5 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192069", "story_v_out_322192.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192069", "story_v_out_322192.awb") / 1000

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end

					if var_284_6.prefab_name ~= "" and arg_281_1.actors_[var_284_6.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_6.prefab_name].transform, "story_v_out_322192", "322192069", "story_v_out_322192.awb")

						arg_281_1:RecordAudio("322192069", var_284_11)
						arg_281_1:RecordAudio("322192069", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_322192", "322192069", "story_v_out_322192.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_322192", "322192069", "story_v_out_322192.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_12 = math.max(var_284_5, arg_281_1.talkMaxDuration)

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_4) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_4 + var_284_12 and arg_281_1.time_ < var_284_4 + var_284_12 + arg_284_0 then
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
			local var_288_0 = 0.45

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_1 = arg_285_1:GetWordFromCfg(322192070)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 18 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 18)

				if (18 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 18)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192070", "story_v_out_322192.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192070", "story_v_out_322192.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_out_322192", "322192070", "story_v_out_322192.awb")

						arg_285_1:RecordAudio("322192070", var_288_6)
						arg_285_1:RecordAudio("322192070", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_322192", "322192070", "story_v_out_322192.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_322192", "322192070", "story_v_out_322192.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
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
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["1111ui_story"]) and arg_289_1.var_.characterEffect1111ui_story == nil then
				arg_289_1.var_.characterEffect1111ui_story = arg_289_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["1111ui_story"]) then
				if arg_289_1.var_.characterEffect1111ui_story and not isNil(arg_289_1.actors_["1111ui_story"]) then
					arg_289_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["1111ui_story"]) and arg_289_1.var_.characterEffect1111ui_story then
				arg_289_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_292_2 = arg_289_1.actors_["1211ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.characterEffect1211ui_story == nil then
				arg_289_1.var_.characterEffect1211ui_story = var_292_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_3 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.characterEffect1211ui_story and not isNil(var_292_2) then
					arg_289_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_3)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.characterEffect1211ui_story then
				arg_289_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			local var_292_4 = 0
			local var_292_5 = 0.425

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:GetWordFromCfg(322192071)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 17 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 17)

				if (17 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 17)) > 0 and var_292_5 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192071", "story_v_out_322192.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192071", "story_v_out_322192.awb") / 1000

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end

					if var_292_6.prefab_name ~= "" and arg_289_1.actors_[var_292_6.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_6.prefab_name].transform, "story_v_out_322192", "322192071", "story_v_out_322192.awb")

						arg_289_1:RecordAudio("322192071", var_292_11)
						arg_289_1:RecordAudio("322192071", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_322192", "322192071", "story_v_out_322192.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_322192", "322192071", "story_v_out_322192.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_12 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_12 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_12

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_12 and arg_289_1.time_ < var_292_4 + var_292_12 + arg_292_0 then
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
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_1")
			end

			local var_296_0 = 0
			local var_296_1 = 0.45

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_2 = arg_293_1:GetWordFromCfg(322192072)
				local var_296_3 = arg_293_1:FormatText(var_296_2.content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 18 <= 0 and var_296_1 or var_296_1 * (utf8.len(var_296_3) / 18)

				if (18 <= 0 and var_296_1 or var_296_1 * (utf8.len(var_296_3) / 18)) > 0 and var_296_1 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192072", "story_v_out_322192.awb") ~= 0 then
					local var_296_6 = manager.audio:GetVoiceLength("story_v_out_322192", "322192072", "story_v_out_322192.awb") / 1000

					if var_296_6 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_6 + var_296_0
					end

					if var_296_2.prefab_name ~= "" and arg_293_1.actors_[var_296_2.prefab_name] ~= nil then
						local var_296_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_2.prefab_name].transform, "story_v_out_322192", "322192072", "story_v_out_322192.awb")

						arg_293_1:RecordAudio("322192072", var_296_7)
						arg_293_1:RecordAudio("322192072", var_296_7)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_322192", "322192072", "story_v_out_322192.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_322192", "322192072", "story_v_out_322192.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_8 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_8 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_8

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_8 and arg_293_1.time_ < var_296_0 + var_296_8 + arg_296_0 then
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
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1111ui_story = arg_297_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1111ui_story"].transform.position).z)
				arg_297_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1111ui_story"].transform.localEulerAngles = arg_297_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1111ui_story"].transform.position).z)
				arg_297_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1111ui_story"].transform.localEulerAngles = arg_297_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_300_1 = arg_297_1.actors_["1211ui_story"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1211ui_story = var_300_1.localPosition
			end

			local var_300_2 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 then
				var_300_1.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 0) / var_300_2)
				var_300_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_1.position).x, (manager.ui.mainCamera.transform.position - var_300_1.position).y, (manager.ui.mainCamera.transform.position - var_300_1.position).z)
				var_300_1.localEulerAngles.z = 0
				var_300_1.localEulerAngles.x = 0
				var_300_1.localEulerAngles = var_300_1.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 then
				var_300_1.localPosition = Vector3.New(0, 100, 0)
				var_300_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_1.position).x, (manager.ui.mainCamera.transform.position - var_300_1.position).y, (manager.ui.mainCamera.transform.position - var_300_1.position).z)
				var_300_1.localEulerAngles.z = 0
				var_300_1.localEulerAngles.x = 0
				var_300_1.localEulerAngles = var_300_1.localEulerAngles
			end

			local var_300_3 = 0
			local var_300_4 = 1.25

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_3 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_5 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(322192073).content)

				arg_297_1.text_.text = var_300_5

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_7 = 50 <= 0 and var_300_4 or var_300_4 * (utf8.len(var_300_5) / 50)

				if (50 <= 0 and var_300_4 or var_300_4 * (utf8.len(var_300_5) / 50)) > 0 and var_300_4 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_3 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_3
					end
				end

				arg_297_1.text_.text = var_300_5
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_8 = math.max(var_300_4, arg_297_1.talkMaxDuration)

			if var_300_3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_3 + var_300_8 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_3) / var_300_8

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_3 + var_300_8 and arg_297_1.time_ < var_300_3 + var_300_8 + arg_300_0 then
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
			local var_304_0 = 1.425

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(322192074).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 57 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 57)

				if (57 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 57)) > 0 and var_304_0 < var_304_3 then
					arg_301_1.talkMaxDuration = var_304_3

					if var_304_3 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_3 + 0
					end
				end

				arg_301_1.text_.text = var_304_1
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_4 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_4

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
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
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1211ui_story = arg_305_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_308_0 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 then
				arg_305_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_305_1.time_ - 0) / var_308_0)
				arg_305_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1211ui_story"].transform.position).z)
				arg_305_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1211ui_story"].transform.localEulerAngles = arg_305_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 then
				arg_305_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, -0.67, -6.07)
				arg_305_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1211ui_story"].transform.position).z)
				arg_305_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1211ui_story"].transform.localEulerAngles = arg_305_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_308_1 = arg_305_1.actors_["1211ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1211ui_story == nil then
				arg_305_1.var_.characterEffect1211ui_story = var_308_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 and not isNil(var_308_1) then
				if arg_305_1.var_.characterEffect1211ui_story and not isNil(var_308_1) then
					arg_305_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1211ui_story then
				arg_305_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_1")
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_308_4 = 0
			local var_308_5 = 0.45

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_6 = arg_305_1:GetWordFromCfg(322192075)
				local var_308_7 = arg_305_1:FormatText(var_308_6.content)

				arg_305_1.text_.text = var_308_7

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_9 = 18 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 18)

				if (18 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 18)) > 0 and var_308_5 < var_308_9 then
					arg_305_1.talkMaxDuration = var_308_9

					if var_308_9 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_9 + var_308_4
					end
				end

				arg_305_1.text_.text = var_308_7
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192075", "story_v_out_322192.awb") ~= 0 then
					local var_308_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192075", "story_v_out_322192.awb") / 1000

					if var_308_10 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_4
					end

					if var_308_6.prefab_name ~= "" and arg_305_1.actors_[var_308_6.prefab_name] ~= nil then
						local var_308_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_6.prefab_name].transform, "story_v_out_322192", "322192075", "story_v_out_322192.awb")

						arg_305_1:RecordAudio("322192075", var_308_11)
						arg_305_1:RecordAudio("322192075", var_308_11)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_322192", "322192075", "story_v_out_322192.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_322192", "322192075", "story_v_out_322192.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_12 = math.max(var_308_5, arg_305_1.talkMaxDuration)

			if var_308_4 <= arg_305_1.time_ and arg_305_1.time_ < var_308_4 + var_308_12 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_4) / var_308_12

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_4 + var_308_12 and arg_305_1.time_ < var_308_4 + var_308_12 + arg_308_0 then
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
			local var_312_0 = 1.075

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:GetWordFromCfg(322192076)
				local var_312_2 = arg_309_1:FormatText(var_312_1.content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 43 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 43)

				if (43 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 43)) > 0 and var_312_0 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192076", "story_v_out_322192.awb") ~= 0 then
					local var_312_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192076", "story_v_out_322192.awb") / 1000

					if var_312_5 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + 0
					end

					if var_312_1.prefab_name ~= "" and arg_309_1.actors_[var_312_1.prefab_name] ~= nil then
						local var_312_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_1.prefab_name].transform, "story_v_out_322192", "322192076", "story_v_out_322192.awb")

						arg_309_1:RecordAudio("322192076", var_312_6)
						arg_309_1:RecordAudio("322192076", var_312_6)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_322192", "322192076", "story_v_out_322192.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_322192", "322192076", "story_v_out_322192.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_7 and arg_309_1.time_ < 0 + var_312_7 + arg_312_0 then
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
			local var_316_0 = 0.325

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:GetWordFromCfg(322192077)
				local var_316_2 = arg_313_1:FormatText(var_316_1.content)

				arg_313_1.text_.text = var_316_2

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 13 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 13)

				if (13 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 13)) > 0 and var_316_0 < var_316_4 then
					arg_313_1.talkMaxDuration = var_316_4

					if var_316_4 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_4 + 0
					end
				end

				arg_313_1.text_.text = var_316_2
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192077", "story_v_out_322192.awb") ~= 0 then
					local var_316_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192077", "story_v_out_322192.awb") / 1000

					if var_316_5 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + 0
					end

					if var_316_1.prefab_name ~= "" and arg_313_1.actors_[var_316_1.prefab_name] ~= nil then
						local var_316_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_1.prefab_name].transform, "story_v_out_322192", "322192077", "story_v_out_322192.awb")

						arg_313_1:RecordAudio("322192077", var_316_6)
						arg_313_1:RecordAudio("322192077", var_316_6)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_322192", "322192077", "story_v_out_322192.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_322192", "322192077", "story_v_out_322192.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 then
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
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1211ui_story = arg_317_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1211ui_story"].transform.position).z)
				arg_317_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1211ui_story"].transform.localEulerAngles = arg_317_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_317_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1211ui_story"].transform.position).z)
				arg_317_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1211ui_story"].transform.localEulerAngles = arg_317_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1111ui_story"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1111ui_story = var_320_1.localPosition
			end

			local var_320_2 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 then
				var_320_1.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_317_1.time_ - 0) / var_320_2)
				var_320_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_1.position).x, (manager.ui.mainCamera.transform.position - var_320_1.position).y, (manager.ui.mainCamera.transform.position - var_320_1.position).z)
				var_320_1.localEulerAngles.z = 0
				var_320_1.localEulerAngles.x = 0
				var_320_1.localEulerAngles = var_320_1.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 then
				var_320_1.localPosition = Vector3.New(0, -0.87, -5.7)
				var_320_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_1.position).x, (manager.ui.mainCamera.transform.position - var_320_1.position).y, (manager.ui.mainCamera.transform.position - var_320_1.position).z)
				var_320_1.localEulerAngles.z = 0
				var_320_1.localEulerAngles.x = 0
				var_320_1.localEulerAngles = var_320_1.localEulerAngles
			end

			local var_320_3 = arg_317_1.actors_["1111ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_3) and arg_317_1.var_.characterEffect1111ui_story == nil then
				arg_317_1.var_.characterEffect1111ui_story = var_320_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_4 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 and not isNil(var_320_3) then
				if arg_317_1.var_.characterEffect1111ui_story and not isNil(var_320_3) then
					arg_317_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 and not isNil(var_320_3) and arg_317_1.var_.characterEffect1111ui_story then
				arg_317_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_320_6 = arg_317_1.actors_["1211ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_6) and arg_317_1.var_.characterEffect1211ui_story == nil then
				arg_317_1.var_.characterEffect1211ui_story = var_320_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_7 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_7 and not isNil(var_320_6) then
				if arg_317_1.var_.characterEffect1211ui_story and not isNil(var_320_6) then
					arg_317_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_7)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_7 and arg_317_1.time_ < 0 + var_320_7 + arg_320_0 and not isNil(var_320_6) and arg_317_1.var_.characterEffect1211ui_story then
				arg_317_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_2")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_320_8 = 0
			local var_320_9 = 0.1

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_8 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_10 = arg_317_1:GetWordFromCfg(322192078)
				local var_320_11 = arg_317_1:FormatText(var_320_10.content)

				arg_317_1.text_.text = var_320_11

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_13 = 4 <= 0 and var_320_9 or var_320_9 * (utf8.len(var_320_11) / 4)

				if (4 <= 0 and var_320_9 or var_320_9 * (utf8.len(var_320_11) / 4)) > 0 and var_320_9 < var_320_13 then
					arg_317_1.talkMaxDuration = var_320_13

					if var_320_13 + var_320_8 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_8
					end
				end

				arg_317_1.text_.text = var_320_11
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192078", "story_v_out_322192.awb") ~= 0 then
					local var_320_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192078", "story_v_out_322192.awb") / 1000

					if var_320_14 + var_320_8 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_14 + var_320_8
					end

					if var_320_10.prefab_name ~= "" and arg_317_1.actors_[var_320_10.prefab_name] ~= nil then
						local var_320_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_10.prefab_name].transform, "story_v_out_322192", "322192078", "story_v_out_322192.awb")

						arg_317_1:RecordAudio("322192078", var_320_15)
						arg_317_1:RecordAudio("322192078", var_320_15)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_322192", "322192078", "story_v_out_322192.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_322192", "322192078", "story_v_out_322192.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_16 = math.max(var_320_9, arg_317_1.talkMaxDuration)

			if var_320_8 <= arg_317_1.time_ and arg_317_1.time_ < var_320_8 + var_320_16 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_8) / var_320_16

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_8 + var_320_16 and arg_317_1.time_ < var_320_8 + var_320_16 + arg_320_0 then
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
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1111ui_story = arg_321_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1111ui_story"].transform.position).z)
				arg_321_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1111ui_story"].transform.localEulerAngles = arg_321_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_321_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1111ui_story"].transform.position).z)
				arg_321_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1111ui_story"].transform.localEulerAngles = arg_321_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_324_1 = 0
			local var_324_2 = 0.85

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_3 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(322192079).content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 34 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 34)

				if (34 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 34)) > 0 and var_324_2 < var_324_5 then
					arg_321_1.talkMaxDuration = var_324_5

					if var_324_5 + var_324_1 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + var_324_1
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_6 = math.max(var_324_2, arg_321_1.talkMaxDuration)

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_6 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_1) / var_324_6

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_1 + var_324_6 and arg_321_1.time_ < var_324_1 + var_324_6 + arg_324_0 then
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
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1211ui_story = arg_325_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1211ui_story"].transform.position).z)
				arg_325_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1211ui_story"].transform.localEulerAngles = arg_325_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, -0.67, -6.07)
				arg_325_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1211ui_story"].transform.position).z)
				arg_325_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1211ui_story"].transform.localEulerAngles = arg_325_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["1211ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1211ui_story == nil then
				arg_325_1.var_.characterEffect1211ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect1211ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1211ui_story then
				arg_325_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_1")
			end

			local var_328_4 = 0
			local var_328_5 = 0.675

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_6 = arg_325_1:GetWordFromCfg(322192080)
				local var_328_7 = arg_325_1:FormatText(var_328_6.content)

				arg_325_1.text_.text = var_328_7

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_9 = 27 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 27)

				if (27 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 27)) > 0 and var_328_5 < var_328_9 then
					arg_325_1.talkMaxDuration = var_328_9

					if var_328_9 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_9 + var_328_4
					end
				end

				arg_325_1.text_.text = var_328_7
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192080", "story_v_out_322192.awb") ~= 0 then
					local var_328_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192080", "story_v_out_322192.awb") / 1000

					if var_328_10 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_4
					end

					if var_328_6.prefab_name ~= "" and arg_325_1.actors_[var_328_6.prefab_name] ~= nil then
						local var_328_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_6.prefab_name].transform, "story_v_out_322192", "322192080", "story_v_out_322192.awb")

						arg_325_1:RecordAudio("322192080", var_328_11)
						arg_325_1:RecordAudio("322192080", var_328_11)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_322192", "322192080", "story_v_out_322192.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_322192", "322192080", "story_v_out_322192.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_12 = math.max(var_328_5, arg_325_1.talkMaxDuration)

			if var_328_4 <= arg_325_1.time_ and arg_325_1.time_ < var_328_4 + var_328_12 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_4) / var_328_12

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_4 + var_328_12 and arg_325_1.time_ < var_328_4 + var_328_12 + arg_328_0 then
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
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1111ui_story = arg_329_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1111ui_story"].transform.position).z)
				arg_329_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1111ui_story"].transform.localEulerAngles = arg_329_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1111ui_story"].transform.position).z)
				arg_329_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1111ui_story"].transform.localEulerAngles = arg_329_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["1211ui_story"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1211ui_story = var_332_1.localPosition
			end

			local var_332_2 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 then
				var_332_1.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_2)
				var_332_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_1.position).x, (manager.ui.mainCamera.transform.position - var_332_1.position).y, (manager.ui.mainCamera.transform.position - var_332_1.position).z)
				var_332_1.localEulerAngles.z = 0
				var_332_1.localEulerAngles.x = 0
				var_332_1.localEulerAngles = var_332_1.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 then
				var_332_1.localPosition = Vector3.New(0, 100, 0)
				var_332_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_1.position).x, (manager.ui.mainCamera.transform.position - var_332_1.position).y, (manager.ui.mainCamera.transform.position - var_332_1.position).z)
				var_332_1.localEulerAngles.z = 0
				var_332_1.localEulerAngles.x = 0
				var_332_1.localEulerAngles = var_332_1.localEulerAngles
			end

			if 0.1 < arg_329_1.time_ and arg_329_1.time_ <= 0.1 + arg_332_0 then
				arg_329_1:AudioAction("play", "effect", "se_story_140", "se_story_140_pistol2", "")
			end

			local var_332_4 = 0
			local var_332_5 = 1

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_6 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(322192081).content)

				arg_329_1.text_.text = var_332_6

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_8 = 40 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_6) / 40)

				if (40 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_6) / 40)) > 0 and var_332_5 < var_332_8 then
					arg_329_1.talkMaxDuration = var_332_8

					if var_332_8 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_8 + var_332_4
					end
				end

				arg_329_1.text_.text = var_332_6
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_9 = math.max(var_332_5, arg_329_1.talkMaxDuration)

			if var_332_4 <= arg_329_1.time_ and arg_329_1.time_ < var_332_4 + var_332_9 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_4) / var_332_9

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_4 + var_332_9 and arg_329_1.time_ < var_332_4 + var_332_9 + arg_332_0 then
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
			if 0.1 < arg_333_1.time_ and arg_333_1.time_ <= 0.1 + arg_336_0 then
				arg_333_1:AudioAction("play", "effect", "se_story_5", "se_story_5_back", "")
			end

			local var_336_1 = 0
			local var_336_2 = 0.95

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_3 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(322192082).content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 38 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 38)

				if (38 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 38)) > 0 and var_336_2 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_6 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_6 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_6

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_6 and arg_333_1.time_ < var_336_1 + var_336_6 + arg_336_0 then
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
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1211ui_story = arg_337_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_340_0 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 then
				arg_337_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_337_1.time_ - 0) / var_340_0)
				arg_337_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1211ui_story"].transform.position).z)
				arg_337_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1211ui_story"].transform.localEulerAngles = arg_337_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 then
				arg_337_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, -0.67, -6.07)
				arg_337_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1211ui_story"].transform.position).z)
				arg_337_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1211ui_story"].transform.localEulerAngles = arg_337_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_340_1 = arg_337_1.actors_["1211ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1211ui_story == nil then
				arg_337_1.var_.characterEffect1211ui_story = var_340_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_2 and not isNil(var_340_1) then
				if arg_337_1.var_.characterEffect1211ui_story and not isNil(var_340_1) then
					arg_337_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_2 and arg_337_1.time_ < 0 + var_340_2 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1211ui_story then
				arg_337_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211actionlink/1211action459")
			end

			local var_340_4 = 0
			local var_340_5 = 0.725

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_6 = arg_337_1:GetWordFromCfg(322192083)
				local var_340_7 = arg_337_1:FormatText(var_340_6.content)

				arg_337_1.text_.text = var_340_7

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_9 = 29 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 29)

				if (29 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 29)) > 0 and var_340_5 < var_340_9 then
					arg_337_1.talkMaxDuration = var_340_9

					if var_340_9 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_4
					end
				end

				arg_337_1.text_.text = var_340_7
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192083", "story_v_out_322192.awb") ~= 0 then
					local var_340_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192083", "story_v_out_322192.awb") / 1000

					if var_340_10 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_10 + var_340_4
					end

					if var_340_6.prefab_name ~= "" and arg_337_1.actors_[var_340_6.prefab_name] ~= nil then
						local var_340_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_6.prefab_name].transform, "story_v_out_322192", "322192083", "story_v_out_322192.awb")

						arg_337_1:RecordAudio("322192083", var_340_11)
						arg_337_1:RecordAudio("322192083", var_340_11)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_322192", "322192083", "story_v_out_322192.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_322192", "322192083", "story_v_out_322192.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_12 = math.max(var_340_5, arg_337_1.talkMaxDuration)

			if var_340_4 <= arg_337_1.time_ and arg_337_1.time_ < var_340_4 + var_340_12 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_4) / var_340_12

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_4 + var_340_12 and arg_337_1.time_ < var_340_4 + var_340_12 + arg_340_0 then
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
			local var_344_0 = 0.525

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_1 = arg_341_1:GetWordFromCfg(322192084)
				local var_344_2 = arg_341_1:FormatText(var_344_1.content)

				arg_341_1.text_.text = var_344_2

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_4 = 21 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 21)

				if (21 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 21)) > 0 and var_344_0 < var_344_4 then
					arg_341_1.talkMaxDuration = var_344_4

					if var_344_4 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_4 + 0
					end
				end

				arg_341_1.text_.text = var_344_2
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192084", "story_v_out_322192.awb") ~= 0 then
					local var_344_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192084", "story_v_out_322192.awb") / 1000

					if var_344_5 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + 0
					end

					if var_344_1.prefab_name ~= "" and arg_341_1.actors_[var_344_1.prefab_name] ~= nil then
						local var_344_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_1.prefab_name].transform, "story_v_out_322192", "322192084", "story_v_out_322192.awb")

						arg_341_1:RecordAudio("322192084", var_344_6)
						arg_341_1:RecordAudio("322192084", var_344_6)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_322192", "322192084", "story_v_out_322192.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_322192", "322192084", "story_v_out_322192.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_7 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_7 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_7

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_7 and arg_341_1.time_ < 0 + var_344_7 + arg_344_0 then
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
			if 1 < arg_345_1.time_ and arg_345_1.time_ <= 1 + arg_348_0 then
				local var_348_0 = arg_345_1.bgs_.STblack

				arg_345_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_348_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_348_1 = var_348_0:GetComponent("SpriteRenderer")

				if var_348_1 and var_348_1.sprite then
					local var_348_2 = 2 * (var_348_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_348_0.transform.localScale = Vector3.New(var_348_2 / var_348_1.sprite.bounds.size.y < var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x and var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x or var_348_2 / var_348_1.sprite.bounds.size.y, var_348_2 / var_348_1.sprite.bounds.size.y < var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x and var_348_2 * manager.ui.mainCameraCom_.aspect / var_348_1.sprite.bounds.size.x or var_348_2 / var_348_1.sprite.bounds.size.y, 0)
				end

				for iter_348_0, iter_348_1 in pairs(arg_345_1.bgs_) do
					if iter_348_0 ~= "STblack" then
						iter_348_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_348_3 = 2

			if 2 < arg_345_1.time_ and arg_345_1.time_ <= var_348_3 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			if arg_345_1.time_ >= var_348_3 + 0.0499999999999998 and arg_345_1.time_ < var_348_3 + 0.0499999999999998 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end

			local var_348_4 = 0

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_5 = 1

			if var_348_4 <= arg_345_1.time_ and arg_345_1.time_ < var_348_4 + var_348_5 then
				local var_348_6 = Color.New(0, 0, 0)

				var_348_6.a = Mathf.Lerp(0, 1, (arg_345_1.time_ - var_348_4) / var_348_5)
				arg_345_1.mask_.color = var_348_6
			end

			if arg_345_1.time_ >= var_348_4 + var_348_5 and arg_345_1.time_ < var_348_4 + var_348_5 + arg_348_0 then
				local var_348_7 = Color.New(0, 0, 0)

				var_348_7.a = 1
				arg_345_1.mask_.color = var_348_7
			end

			local var_348_8 = 1

			if 1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
				arg_345_1.mask_.enabled = true
				arg_345_1.mask_.raycastTarget = true

				arg_345_1:SetGaussion(false)
			end

			local var_348_9 = 1

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_9 then
				local var_348_10 = Color.New(0, 0, 0)

				var_348_10.a = Mathf.Lerp(1, 0, (arg_345_1.time_ - var_348_8) / var_348_9)
				arg_345_1.mask_.color = var_348_10
			end

			if arg_345_1.time_ >= var_348_8 + var_348_9 and arg_345_1.time_ < var_348_8 + var_348_9 + arg_348_0 then
				local var_348_11 = Color.New(0, 0, 0)

				arg_345_1.mask_.enabled = false
				var_348_11.a = 0
				arg_345_1.mask_.color = var_348_11
			end

			local var_348_12 = arg_345_1.actors_["1111ui_story"].transform

			if 2 < arg_345_1.time_ and arg_345_1.time_ <= 2 + arg_348_0 then
				arg_345_1.var_.moveOldPos1111ui_story = var_348_12.localPosition
			end

			local var_348_13 = 0.001

			if 2 <= arg_345_1.time_ and arg_345_1.time_ < 2 + var_348_13 then
				var_348_12.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_345_1.time_ - 2) / var_348_13)
				var_348_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_12.position).x, (manager.ui.mainCamera.transform.position - var_348_12.position).y, (manager.ui.mainCamera.transform.position - var_348_12.position).z)
				var_348_12.localEulerAngles.z = 0
				var_348_12.localEulerAngles.x = 0
				var_348_12.localEulerAngles = var_348_12.localEulerAngles
			end

			if arg_345_1.time_ >= 2 + var_348_13 and arg_345_1.time_ < 2 + var_348_13 + arg_348_0 then
				var_348_12.localPosition = Vector3.New(0, -0.87, -5.7)
				var_348_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_12.position).x, (manager.ui.mainCamera.transform.position - var_348_12.position).y, (manager.ui.mainCamera.transform.position - var_348_12.position).z)
				var_348_12.localEulerAngles.z = 0
				var_348_12.localEulerAngles.x = 0
				var_348_12.localEulerAngles = var_348_12.localEulerAngles
			end

			local var_348_14 = arg_345_1.actors_["1211ui_story"].transform

			if 1 < arg_345_1.time_ and arg_345_1.time_ <= 1 + arg_348_0 then
				arg_345_1.var_.moveOldPos1211ui_story = var_348_14.localPosition
			end

			local var_348_15 = 0.001

			if 1 <= arg_345_1.time_ and arg_345_1.time_ < 1 + var_348_15 then
				var_348_14.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_345_1.time_ - 1) / var_348_15)
				var_348_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_14.position).x, (manager.ui.mainCamera.transform.position - var_348_14.position).y, (manager.ui.mainCamera.transform.position - var_348_14.position).z)
				var_348_14.localEulerAngles.z = 0
				var_348_14.localEulerAngles.x = 0
				var_348_14.localEulerAngles = var_348_14.localEulerAngles
			end

			if arg_345_1.time_ >= 1 + var_348_15 and arg_345_1.time_ < 1 + var_348_15 + arg_348_0 then
				var_348_14.localPosition = Vector3.New(0, 100, 0)
				var_348_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_14.position).x, (manager.ui.mainCamera.transform.position - var_348_14.position).y, (manager.ui.mainCamera.transform.position - var_348_14.position).z)
				var_348_14.localEulerAngles.z = 0
				var_348_14.localEulerAngles.x = 0
				var_348_14.localEulerAngles = var_348_14.localEulerAngles
			end

			local var_348_16 = arg_345_1.actors_["1111ui_story"]

			if 2 < arg_345_1.time_ and arg_345_1.time_ <= 2 + arg_348_0 and not isNil(var_348_16) and arg_345_1.var_.characterEffect1111ui_story == nil then
				arg_345_1.var_.characterEffect1111ui_story = var_348_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_17 = 0.200000002980232

			if 2 <= arg_345_1.time_ and arg_345_1.time_ < 2 + var_348_17 and not isNil(var_348_16) then
				if arg_345_1.var_.characterEffect1111ui_story and not isNil(var_348_16) then
					arg_345_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 2 + var_348_17 and arg_345_1.time_ < 2 + var_348_17 + arg_348_0 and not isNil(var_348_16) and arg_345_1.var_.characterEffect1111ui_story then
				arg_345_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 2 < arg_345_1.time_ and arg_345_1.time_ <= 2 + arg_348_0 then
				arg_345_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 2 < arg_345_1.time_ and arg_345_1.time_ <= 2 + arg_348_0 then
				arg_345_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			if arg_345_1.frameCnt_ <= 1 then
				arg_345_1.dialog_:SetActive(false)
			end

			local var_348_19 = 2
			local var_348_20 = 0.05

			if 2 < arg_345_1.time_ and arg_345_1.time_ <= var_348_19 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0

				arg_345_1.dialog_:SetActive(true)

				arg_345_1.dialogCg_.alpha = 0

				local var_348_21 = LeanTween.value(arg_345_1.dialog_, 0, 1, 0.3)

				var_348_21:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_345_1.dialogCg_.alpha = arg_349_0
				end))
				var_348_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_345_1.dialog_)
					var_348_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_345_1.duration_ = arg_345_1.duration_ + 0.3

				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_22 = arg_345_1:GetWordFromCfg(322192085)
				local var_348_23 = arg_345_1:FormatText(var_348_22.content)

				arg_345_1.text_.text = var_348_23

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_25 = 2 <= 0 and var_348_20 or var_348_20 * (utf8.len(var_348_23) / 2)

				if (2 <= 0 and var_348_20 or var_348_20 * (utf8.len(var_348_23) / 2)) > 0 and var_348_20 < var_348_25 then
					arg_345_1.talkMaxDuration = var_348_25
					var_348_19 = var_348_19 + 0.3

					if var_348_25 + var_348_19 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_25 + var_348_19
					end
				end

				arg_345_1.text_.text = var_348_23
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192085", "story_v_out_322192.awb") ~= 0 then
					local var_348_26 = manager.audio:GetVoiceLength("story_v_out_322192", "322192085", "story_v_out_322192.awb") / 1000

					if var_348_26 + var_348_19 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_26 + var_348_19
					end

					if var_348_22.prefab_name ~= "" and arg_345_1.actors_[var_348_22.prefab_name] ~= nil then
						local var_348_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_22.prefab_name].transform, "story_v_out_322192", "322192085", "story_v_out_322192.awb")

						arg_345_1:RecordAudio("322192085", var_348_27)
						arg_345_1:RecordAudio("322192085", var_348_27)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_322192", "322192085", "story_v_out_322192.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_322192", "322192085", "story_v_out_322192.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_28 = var_348_19 + 0.3
			local var_348_29 = math.max(var_348_20, arg_345_1.talkMaxDuration)

			if var_348_19 + 0.3 <= arg_345_1.time_ and arg_345_1.time_ < var_348_28 + var_348_29 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_28) / var_348_29

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_28 + var_348_29 and arg_345_1.time_ < var_348_28 + var_348_29 + arg_348_0 then
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
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1111ui_story = arg_351_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_354_0 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 then
				arg_351_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_351_1.time_ - 0) / var_354_0)
				arg_351_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).z)
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles = arg_351_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 then
				arg_351_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_351_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).z)
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles = arg_351_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if 0.1 < arg_351_1.time_ and arg_351_1.time_ <= 0.1 + arg_354_0 then
				arg_351_1:AudioAction("play", "effect", "se_story_140", "se_story_140_footstep_run05", "")
			end

			local var_354_2 = 0
			local var_354_3 = 1.075

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_2 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_4 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(322192086).content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_6 = 43 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_4) / 43)

				if (43 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_4) / 43)) > 0 and var_354_3 < var_354_6 then
					arg_351_1.talkMaxDuration = var_354_6

					if var_354_6 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_2
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_3, arg_351_1.talkMaxDuration)

			if var_354_2 <= arg_351_1.time_ and arg_351_1.time_ < var_354_2 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_2) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_2 + var_354_7 and arg_351_1.time_ < var_354_2 + var_354_7 + arg_354_0 then
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
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos1111ui_story = arg_355_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_358_0 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 then
				arg_355_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_355_1.time_ - 0) / var_358_0)
				arg_355_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1111ui_story"].transform.position).z)
				arg_355_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1111ui_story"].transform.localEulerAngles = arg_355_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 then
				arg_355_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_355_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1111ui_story"].transform.position).z)
				arg_355_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1111ui_story"].transform.localEulerAngles = arg_355_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_358_1 = arg_355_1.actors_["1111ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1111ui_story == nil then
				arg_355_1.var_.characterEffect1111ui_story = var_358_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_2 and not isNil(var_358_1) then
				if arg_355_1.var_.characterEffect1111ui_story and not isNil(var_358_1) then
					arg_355_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_2 and arg_355_1.time_ < 0 + var_358_2 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1111ui_story then
				arg_355_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_358_4 = 0
			local var_358_5 = 0.2

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_6 = arg_355_1:GetWordFromCfg(322192087)
				local var_358_7 = arg_355_1:FormatText(var_358_6.content)

				arg_355_1.text_.text = var_358_7

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_9 = 8 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 8)

				if (8 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 8)) > 0 and var_358_5 < var_358_9 then
					arg_355_1.talkMaxDuration = var_358_9

					if var_358_9 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_4
					end
				end

				arg_355_1.text_.text = var_358_7
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192087", "story_v_out_322192.awb") ~= 0 then
					local var_358_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192087", "story_v_out_322192.awb") / 1000

					if var_358_10 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_10 + var_358_4
					end

					if var_358_6.prefab_name ~= "" and arg_355_1.actors_[var_358_6.prefab_name] ~= nil then
						local var_358_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_6.prefab_name].transform, "story_v_out_322192", "322192087", "story_v_out_322192.awb")

						arg_355_1:RecordAudio("322192087", var_358_11)
						arg_355_1:RecordAudio("322192087", var_358_11)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_322192", "322192087", "story_v_out_322192.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_322192", "322192087", "story_v_out_322192.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_12 = math.max(var_358_5, arg_355_1.talkMaxDuration)

			if var_358_4 <= arg_355_1.time_ and arg_355_1.time_ < var_358_4 + var_358_12 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_4) / var_358_12

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_4 + var_358_12 and arg_355_1.time_ < var_358_4 + var_358_12 + arg_358_0 then
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
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1111ui_story = arg_359_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1111ui_story"].transform.position).z)
				arg_359_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1111ui_story"].transform.localEulerAngles = arg_359_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_359_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1111ui_story"].transform.position).z)
				arg_359_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1111ui_story"].transform.localEulerAngles = arg_359_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_362_1 = arg_359_1.actors_["1043ui_story"].transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1043ui_story = var_362_1.localPosition
			end

			local var_362_2 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_2 then
				var_362_1.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_359_1.time_ - 0) / var_362_2)
				var_362_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_1.position).x, (manager.ui.mainCamera.transform.position - var_362_1.position).y, (manager.ui.mainCamera.transform.position - var_362_1.position).z)
				var_362_1.localEulerAngles.z = 0
				var_362_1.localEulerAngles.x = 0
				var_362_1.localEulerAngles = var_362_1.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_2 and arg_359_1.time_ < 0 + var_362_2 + arg_362_0 then
				var_362_1.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_362_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_1.position).x, (manager.ui.mainCamera.transform.position - var_362_1.position).y, (manager.ui.mainCamera.transform.position - var_362_1.position).z)
				var_362_1.localEulerAngles.z = 0
				var_362_1.localEulerAngles.x = 0
				var_362_1.localEulerAngles = var_362_1.localEulerAngles
			end

			local var_362_3 = arg_359_1.actors_["1043ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_3) and arg_359_1.var_.characterEffect1043ui_story == nil then
				arg_359_1.var_.characterEffect1043ui_story = var_362_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_4 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 and not isNil(var_362_3) then
				if arg_359_1.var_.characterEffect1043ui_story and not isNil(var_362_3) then
					arg_359_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 and not isNil(var_362_3) and arg_359_1.var_.characterEffect1043ui_story then
				arg_359_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_362_6 = arg_359_1.actors_["1111ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_6) and arg_359_1.var_.characterEffect1111ui_story == nil then
				arg_359_1.var_.characterEffect1111ui_story = var_362_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_7 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_7 and not isNil(var_362_6) then
				if arg_359_1.var_.characterEffect1111ui_story and not isNil(var_362_6) then
					arg_359_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_7)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_7 and arg_359_1.time_ < 0 + var_362_7 + arg_362_0 and not isNil(var_362_6) and arg_359_1.var_.characterEffect1111ui_story then
				arg_359_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_362_8 = 0
			local var_362_9 = 0.175

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_8 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_10 = arg_359_1:GetWordFromCfg(322192088)
				local var_362_11 = arg_359_1:FormatText(var_362_10.content)

				arg_359_1.text_.text = var_362_11

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_13 = 7 <= 0 and var_362_9 or var_362_9 * (utf8.len(var_362_11) / 7)

				if (7 <= 0 and var_362_9 or var_362_9 * (utf8.len(var_362_11) / 7)) > 0 and var_362_9 < var_362_13 then
					arg_359_1.talkMaxDuration = var_362_13

					if var_362_13 + var_362_8 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_13 + var_362_8
					end
				end

				arg_359_1.text_.text = var_362_11
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192088", "story_v_out_322192.awb") ~= 0 then
					local var_362_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192088", "story_v_out_322192.awb") / 1000

					if var_362_14 + var_362_8 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_14 + var_362_8
					end

					if var_362_10.prefab_name ~= "" and arg_359_1.actors_[var_362_10.prefab_name] ~= nil then
						local var_362_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_10.prefab_name].transform, "story_v_out_322192", "322192088", "story_v_out_322192.awb")

						arg_359_1:RecordAudio("322192088", var_362_15)
						arg_359_1:RecordAudio("322192088", var_362_15)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_322192", "322192088", "story_v_out_322192.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_322192", "322192088", "story_v_out_322192.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_16 = math.max(var_362_9, arg_359_1.talkMaxDuration)

			if var_362_8 <= arg_359_1.time_ and arg_359_1.time_ < var_362_8 + var_362_16 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_8) / var_362_16

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_8 + var_362_16 and arg_359_1.time_ < var_362_8 + var_362_16 + arg_362_0 then
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
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1111ui_story"]) and arg_363_1.var_.characterEffect1111ui_story == nil then
				arg_363_1.var_.characterEffect1111ui_story = arg_363_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1111ui_story"]) then
				if arg_363_1.var_.characterEffect1111ui_story and not isNil(arg_363_1.actors_["1111ui_story"]) then
					arg_363_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1111ui_story"]) and arg_363_1.var_.characterEffect1111ui_story then
				arg_363_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_366_2 = arg_363_1.actors_["1043ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_2) and arg_363_1.var_.characterEffect1043ui_story == nil then
				arg_363_1.var_.characterEffect1043ui_story = var_366_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_3 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_3 and not isNil(var_366_2) then
				if arg_363_1.var_.characterEffect1043ui_story and not isNil(var_366_2) then
					arg_363_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_3)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_3 and arg_363_1.time_ < 0 + var_366_3 + arg_366_0 and not isNil(var_366_2) and arg_363_1.var_.characterEffect1043ui_story then
				arg_363_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_366_4 = 0
			local var_366_5 = 0.275

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_4 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_6 = arg_363_1:GetWordFromCfg(322192089)
				local var_366_7 = arg_363_1:FormatText(var_366_6.content)

				arg_363_1.text_.text = var_366_7

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_9 = 11 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 11)

				if (11 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 11)) > 0 and var_366_5 < var_366_9 then
					arg_363_1.talkMaxDuration = var_366_9

					if var_366_9 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_9 + var_366_4
					end
				end

				arg_363_1.text_.text = var_366_7
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192089", "story_v_out_322192.awb") ~= 0 then
					local var_366_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192089", "story_v_out_322192.awb") / 1000

					if var_366_10 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_10 + var_366_4
					end

					if var_366_6.prefab_name ~= "" and arg_363_1.actors_[var_366_6.prefab_name] ~= nil then
						local var_366_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_6.prefab_name].transform, "story_v_out_322192", "322192089", "story_v_out_322192.awb")

						arg_363_1:RecordAudio("322192089", var_366_11)
						arg_363_1:RecordAudio("322192089", var_366_11)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_322192", "322192089", "story_v_out_322192.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_322192", "322192089", "story_v_out_322192.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_12 = math.max(var_366_5, arg_363_1.talkMaxDuration)

			if var_366_4 <= arg_363_1.time_ and arg_363_1.time_ < var_366_4 + var_366_12 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_4) / var_366_12

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_4 + var_366_12 and arg_363_1.time_ < var_366_4 + var_366_12 + arg_366_0 then
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
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["1043ui_story"]) and arg_367_1.var_.characterEffect1043ui_story == nil then
				arg_367_1.var_.characterEffect1043ui_story = arg_367_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_0 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["1043ui_story"]) then
				if arg_367_1.var_.characterEffect1043ui_story and not isNil(arg_367_1.actors_["1043ui_story"]) then
					arg_367_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["1043ui_story"]) and arg_367_1.var_.characterEffect1043ui_story then
				arg_367_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_370_2 = arg_367_1.actors_["1111ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.characterEffect1111ui_story == nil then
				arg_367_1.var_.characterEffect1111ui_story = var_370_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_3 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_3 and not isNil(var_370_2) then
				if arg_367_1.var_.characterEffect1111ui_story and not isNil(var_370_2) then
					arg_367_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_3)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_3 and arg_367_1.time_ < 0 + var_370_3 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.characterEffect1111ui_story then
				arg_367_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_370_4 = 0
			local var_370_5 = 0.35

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_6 = arg_367_1:GetWordFromCfg(322192090)
				local var_370_7 = arg_367_1:FormatText(var_370_6.content)

				arg_367_1.text_.text = var_370_7

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 14 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 14)

				if (14 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 14)) > 0 and var_370_5 < var_370_9 then
					arg_367_1.talkMaxDuration = var_370_9

					if var_370_9 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_4
					end
				end

				arg_367_1.text_.text = var_370_7
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192090", "story_v_out_322192.awb") ~= 0 then
					local var_370_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192090", "story_v_out_322192.awb") / 1000

					if var_370_10 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_4
					end

					if var_370_6.prefab_name ~= "" and arg_367_1.actors_[var_370_6.prefab_name] ~= nil then
						local var_370_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_6.prefab_name].transform, "story_v_out_322192", "322192090", "story_v_out_322192.awb")

						arg_367_1:RecordAudio("322192090", var_370_11)
						arg_367_1:RecordAudio("322192090", var_370_11)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_322192", "322192090", "story_v_out_322192.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_322192", "322192090", "story_v_out_322192.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_12 = math.max(var_370_5, arg_367_1.talkMaxDuration)

			if var_370_4 <= arg_367_1.time_ and arg_367_1.time_ < var_370_4 + var_370_12 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_4) / var_370_12

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_4 + var_370_12 and arg_367_1.time_ < var_370_4 + var_370_12 + arg_370_0 then
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
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["1111ui_story"]) and arg_371_1.var_.characterEffect1111ui_story == nil then
				arg_371_1.var_.characterEffect1111ui_story = arg_371_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_0 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["1111ui_story"]) then
				if arg_371_1.var_.characterEffect1111ui_story and not isNil(arg_371_1.actors_["1111ui_story"]) then
					arg_371_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["1111ui_story"]) and arg_371_1.var_.characterEffect1111ui_story then
				arg_371_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_374_2 = arg_371_1.actors_["1043ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.characterEffect1043ui_story == nil then
				arg_371_1.var_.characterEffect1043ui_story = var_374_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_3 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_3 and not isNil(var_374_2) then
				if arg_371_1.var_.characterEffect1043ui_story and not isNil(var_374_2) then
					arg_371_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_3)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_3 and arg_371_1.time_ < 0 + var_374_3 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.characterEffect1043ui_story then
				arg_371_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_374_4 = 0
			local var_374_5 = 0.1

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_6 = arg_371_1:GetWordFromCfg(322192091)
				local var_374_7 = arg_371_1:FormatText(var_374_6.content)

				arg_371_1.text_.text = var_374_7

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_9 = 4 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 4)

				if (4 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 4)) > 0 and var_374_5 < var_374_9 then
					arg_371_1.talkMaxDuration = var_374_9

					if var_374_9 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_9 + var_374_4
					end
				end

				arg_371_1.text_.text = var_374_7
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192091", "story_v_out_322192.awb") ~= 0 then
					local var_374_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192091", "story_v_out_322192.awb") / 1000

					if var_374_10 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_10 + var_374_4
					end

					if var_374_6.prefab_name ~= "" and arg_371_1.actors_[var_374_6.prefab_name] ~= nil then
						local var_374_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_6.prefab_name].transform, "story_v_out_322192", "322192091", "story_v_out_322192.awb")

						arg_371_1:RecordAudio("322192091", var_374_11)
						arg_371_1:RecordAudio("322192091", var_374_11)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_322192", "322192091", "story_v_out_322192.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_322192", "322192091", "story_v_out_322192.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_12 = math.max(var_374_5, arg_371_1.talkMaxDuration)

			if var_374_4 <= arg_371_1.time_ and arg_371_1.time_ < var_374_4 + var_374_12 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_4) / var_374_12

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_4 + var_374_12 and arg_371_1.time_ < var_374_4 + var_374_12 + arg_374_0 then
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
			if 1 < arg_375_1.time_ and arg_375_1.time_ <= 1 + arg_378_0 then
				local var_378_0 = arg_375_1.bgs_.L09f

				arg_375_1.bgs_.L09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_378_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_378_1 = var_378_0:GetComponent("SpriteRenderer")

				if var_378_1 and var_378_1.sprite then
					local var_378_2 = 2 * (var_378_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_378_0.transform.localScale = Vector3.New(var_378_2 / var_378_1.sprite.bounds.size.y < var_378_2 * manager.ui.mainCameraCom_.aspect / var_378_1.sprite.bounds.size.x and var_378_2 * manager.ui.mainCameraCom_.aspect / var_378_1.sprite.bounds.size.x or var_378_2 / var_378_1.sprite.bounds.size.y, var_378_2 / var_378_1.sprite.bounds.size.y < var_378_2 * manager.ui.mainCameraCom_.aspect / var_378_1.sprite.bounds.size.x and var_378_2 * manager.ui.mainCameraCom_.aspect / var_378_1.sprite.bounds.size.x or var_378_2 / var_378_1.sprite.bounds.size.y, 0)
				end

				for iter_378_0, iter_378_1 in pairs(arg_375_1.bgs_) do
					if iter_378_0 ~= "L09f" then
						iter_378_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_378_3 = 2

			if 2 < arg_375_1.time_ and arg_375_1.time_ <= var_378_3 + arg_378_0 then
				arg_375_1.allBtn_.enabled = false
			end

			if arg_375_1.time_ >= var_378_3 + 0.3 and arg_375_1.time_ < var_378_3 + 0.3 + arg_378_0 then
				arg_375_1.allBtn_.enabled = true
			end

			local var_378_4 = 0

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.mask_.enabled = true
				arg_375_1.mask_.raycastTarget = true

				arg_375_1:SetGaussion(false)
			end

			local var_378_5 = 1

			if var_378_4 <= arg_375_1.time_ and arg_375_1.time_ < var_378_4 + var_378_5 then
				local var_378_6 = Color.New(0, 0, 0)

				var_378_6.a = Mathf.Lerp(0, 1, (arg_375_1.time_ - var_378_4) / var_378_5)
				arg_375_1.mask_.color = var_378_6
			end

			if arg_375_1.time_ >= var_378_4 + var_378_5 and arg_375_1.time_ < var_378_4 + var_378_5 + arg_378_0 then
				local var_378_7 = Color.New(0, 0, 0)

				var_378_7.a = 1
				arg_375_1.mask_.color = var_378_7
			end

			local var_378_8 = 1

			if 1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_8 + arg_378_0 then
				arg_375_1.mask_.enabled = true
				arg_375_1.mask_.raycastTarget = true

				arg_375_1:SetGaussion(false)
			end

			local var_378_9 = 1

			if var_378_8 <= arg_375_1.time_ and arg_375_1.time_ < var_378_8 + var_378_9 then
				local var_378_10 = Color.New(0, 0, 0)

				var_378_10.a = Mathf.Lerp(1, 0, (arg_375_1.time_ - var_378_8) / var_378_9)
				arg_375_1.mask_.color = var_378_10
			end

			if arg_375_1.time_ >= var_378_8 + var_378_9 and arg_375_1.time_ < var_378_8 + var_378_9 + arg_378_0 then
				local var_378_11 = Color.New(0, 0, 0)

				arg_375_1.mask_.enabled = false
				var_378_11.a = 0
				arg_375_1.mask_.color = var_378_11
			end

			local var_378_12 = arg_375_1.actors_["1111ui_story"].transform

			if 1 < arg_375_1.time_ and arg_375_1.time_ <= 1 + arg_378_0 then
				arg_375_1.var_.moveOldPos1111ui_story = var_378_12.localPosition
			end

			local var_378_13 = 0.001

			if 1 <= arg_375_1.time_ and arg_375_1.time_ < 1 + var_378_13 then
				var_378_12.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_375_1.time_ - 1) / var_378_13)
				var_378_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_378_12.position).x, (manager.ui.mainCamera.transform.position - var_378_12.position).y, (manager.ui.mainCamera.transform.position - var_378_12.position).z)
				var_378_12.localEulerAngles.z = 0
				var_378_12.localEulerAngles.x = 0
				var_378_12.localEulerAngles = var_378_12.localEulerAngles
			end

			if arg_375_1.time_ >= 1 + var_378_13 and arg_375_1.time_ < 1 + var_378_13 + arg_378_0 then
				var_378_12.localPosition = Vector3.New(0, 100, 0)
				var_378_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_378_12.position).x, (manager.ui.mainCamera.transform.position - var_378_12.position).y, (manager.ui.mainCamera.transform.position - var_378_12.position).z)
				var_378_12.localEulerAngles.z = 0
				var_378_12.localEulerAngles.x = 0
				var_378_12.localEulerAngles = var_378_12.localEulerAngles
			end

			local var_378_14 = arg_375_1.actors_["1043ui_story"].transform

			if 1 < arg_375_1.time_ and arg_375_1.time_ <= 1 + arg_378_0 then
				arg_375_1.var_.moveOldPos1043ui_story = var_378_14.localPosition
			end

			local var_378_15 = 0.001

			if 1 <= arg_375_1.time_ and arg_375_1.time_ < 1 + var_378_15 then
				var_378_14.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_375_1.time_ - 1) / var_378_15)
				var_378_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_378_14.position).x, (manager.ui.mainCamera.transform.position - var_378_14.position).y, (manager.ui.mainCamera.transform.position - var_378_14.position).z)
				var_378_14.localEulerAngles.z = 0
				var_378_14.localEulerAngles.x = 0
				var_378_14.localEulerAngles = var_378_14.localEulerAngles
			end

			if arg_375_1.time_ >= 1 + var_378_15 and arg_375_1.time_ < 1 + var_378_15 + arg_378_0 then
				var_378_14.localPosition = Vector3.New(0, 100, 0)
				var_378_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_378_14.position).x, (manager.ui.mainCamera.transform.position - var_378_14.position).y, (manager.ui.mainCamera.transform.position - var_378_14.position).z)
				var_378_14.localEulerAngles.z = 0
				var_378_14.localEulerAngles.x = 0
				var_378_14.localEulerAngles = var_378_14.localEulerAngles
			end

			if 2 < arg_375_1.time_ and arg_375_1.time_ <= 2 + arg_378_0 then
				arg_375_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_clothhit", "")
			end

			if 0.6 < arg_375_1.time_ and arg_375_1.time_ <= 0.6 + arg_378_0 then
				arg_375_1:AudioAction("play", "music", "bgm_activity_4_5_story_source", "battle", "bgm_activity_4_5_story_source.awb")

				local var_378_19 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "battle")

				if "" ~= "" then
					if arg_375_1.bgmTxt_.text ~= var_378_19 and arg_375_1.bgmTxt_.text ~= "" then
						if arg_375_1.bgmTxt2_.text ~= "" then
							arg_375_1.bgmTxt_.text = arg_375_1.bgmTxt2_.text
						end

						arg_375_1.bgmTxt2_.text = var_378_19

						arg_375_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_375_1.bgmTxt_.text = var_378_19
						arg_375_1.bgmTxt2_.text = var_378_19
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

			local var_378_20 = 2
			local var_378_21 = 0.525

			if 2 < arg_375_1.time_ and arg_375_1.time_ <= var_378_20 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0

				arg_375_1.dialog_:SetActive(true)

				arg_375_1.dialogCg_.alpha = 0

				local var_378_22 = LeanTween.value(arg_375_1.dialog_, 0, 1, 0.3)

				var_378_22:setOnUpdate(LuaHelper.FloatAction(function(arg_380_0)
					arg_375_1.dialogCg_.alpha = arg_380_0
				end))
				var_378_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_375_1.dialog_)
					var_378_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_375_1.duration_ = arg_375_1.duration_ + 0.3

				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_23 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(322192092).content)

				arg_375_1.text_.text = var_378_23

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_25 = 21 <= 0 and var_378_21 or var_378_21 * (utf8.len(var_378_23) / 21)

				if (21 <= 0 and var_378_21 or var_378_21 * (utf8.len(var_378_23) / 21)) > 0 and var_378_21 < var_378_25 then
					arg_375_1.talkMaxDuration = var_378_25
					var_378_20 = var_378_20 + 0.3

					if var_378_25 + var_378_20 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_25 + var_378_20
					end
				end

				arg_375_1.text_.text = var_378_23
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_26 = var_378_20 + 0.3
			local var_378_27 = math.max(var_378_21, arg_375_1.talkMaxDuration)

			if var_378_20 + 0.3 <= arg_375_1.time_ and arg_375_1.time_ < var_378_26 + var_378_27 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_26) / var_378_27

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_26 + var_378_27 and arg_375_1.time_ < var_378_26 + var_378_27 + arg_378_0 then
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
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos1111ui_story = arg_382_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_385_0 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 then
				arg_382_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_382_1.time_ - 0) / var_385_0)
				arg_382_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1111ui_story"].transform.position).z)
				arg_382_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["1111ui_story"].transform.localEulerAngles = arg_382_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 then
				arg_382_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_382_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1111ui_story"].transform.position).z)
				arg_382_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["1111ui_story"].transform.localEulerAngles = arg_382_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_385_1 = arg_382_1.actors_["1111ui_story"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_1) and arg_382_1.var_.characterEffect1111ui_story == nil then
				arg_382_1.var_.characterEffect1111ui_story = var_385_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_2 and not isNil(var_385_1) then
				if arg_382_1.var_.characterEffect1111ui_story and not isNil(var_385_1) then
					arg_382_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= 0 + var_385_2 and arg_382_1.time_ < 0 + var_385_2 + arg_385_0 and not isNil(var_385_1) and arg_382_1.var_.characterEffect1111ui_story then
				arg_382_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_385_4 = 0
			local var_385_5 = 0.6

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_4 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_6 = arg_382_1:GetWordFromCfg(322192093)
				local var_385_7 = arg_382_1:FormatText(var_385_6.content)

				arg_382_1.text_.text = var_385_7

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_9 = 24 <= 0 and var_385_5 or var_385_5 * (utf8.len(var_385_7) / 24)

				if (24 <= 0 and var_385_5 or var_385_5 * (utf8.len(var_385_7) / 24)) > 0 and var_385_5 < var_385_9 then
					arg_382_1.talkMaxDuration = var_385_9

					if var_385_9 + var_385_4 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_9 + var_385_4
					end
				end

				arg_382_1.text_.text = var_385_7
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192093", "story_v_out_322192.awb") ~= 0 then
					local var_385_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192093", "story_v_out_322192.awb") / 1000

					if var_385_10 + var_385_4 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_10 + var_385_4
					end

					if var_385_6.prefab_name ~= "" and arg_382_1.actors_[var_385_6.prefab_name] ~= nil then
						local var_385_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_6.prefab_name].transform, "story_v_out_322192", "322192093", "story_v_out_322192.awb")

						arg_382_1:RecordAudio("322192093", var_385_11)
						arg_382_1:RecordAudio("322192093", var_385_11)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_322192", "322192093", "story_v_out_322192.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_322192", "322192093", "story_v_out_322192.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_12 = math.max(var_385_5, arg_382_1.talkMaxDuration)

			if var_385_4 <= arg_382_1.time_ and arg_382_1.time_ < var_385_4 + var_385_12 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_4) / var_385_12

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_4 + var_385_12 and arg_382_1.time_ < var_385_4 + var_385_12 + arg_385_0 then
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
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_389_0 = 0
			local var_389_1 = 1.15

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_2 = arg_386_1:GetWordFromCfg(322192094)
				local var_389_3 = arg_386_1:FormatText(var_389_2.content)

				arg_386_1.text_.text = var_389_3

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 46 <= 0 and var_389_1 or var_389_1 * (utf8.len(var_389_3) / 46)

				if (46 <= 0 and var_389_1 or var_389_1 * (utf8.len(var_389_3) / 46)) > 0 and var_389_1 < var_389_5 then
					arg_386_1.talkMaxDuration = var_389_5

					if var_389_5 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + var_389_0
					end
				end

				arg_386_1.text_.text = var_389_3
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192094", "story_v_out_322192.awb") ~= 0 then
					local var_389_6 = manager.audio:GetVoiceLength("story_v_out_322192", "322192094", "story_v_out_322192.awb") / 1000

					if var_389_6 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_6 + var_389_0
					end

					if var_389_2.prefab_name ~= "" and arg_386_1.actors_[var_389_2.prefab_name] ~= nil then
						local var_389_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_2.prefab_name].transform, "story_v_out_322192", "322192094", "story_v_out_322192.awb")

						arg_386_1:RecordAudio("322192094", var_389_7)
						arg_386_1:RecordAudio("322192094", var_389_7)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_322192", "322192094", "story_v_out_322192.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_322192", "322192094", "story_v_out_322192.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_8 = math.max(var_389_1, arg_386_1.talkMaxDuration)

			if var_389_0 <= arg_386_1.time_ and arg_386_1.time_ < var_389_0 + var_389_8 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_0) / var_389_8

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_0 + var_389_8 and arg_386_1.time_ < var_389_0 + var_389_8 + arg_389_0 then
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
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos1111ui_story = arg_390_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_393_0 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 then
				arg_390_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_390_1.time_ - 0) / var_393_0)
				arg_390_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1111ui_story"].transform.position).z)
				arg_390_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["1111ui_story"].transform.localEulerAngles = arg_390_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 then
				arg_390_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_390_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1111ui_story"].transform.position).z)
				arg_390_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["1111ui_story"].transform.localEulerAngles = arg_390_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_393_1 = arg_390_1.actors_["1043ui_story"].transform

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos1043ui_story = var_393_1.localPosition
			end

			local var_393_2 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_2 then
				var_393_1.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_390_1.time_ - 0) / var_393_2)
				var_393_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_1.position).x, (manager.ui.mainCamera.transform.position - var_393_1.position).y, (manager.ui.mainCamera.transform.position - var_393_1.position).z)
				var_393_1.localEulerAngles.z = 0
				var_393_1.localEulerAngles.x = 0
				var_393_1.localEulerAngles = var_393_1.localEulerAngles
			end

			if arg_390_1.time_ >= 0 + var_393_2 and arg_390_1.time_ < 0 + var_393_2 + arg_393_0 then
				var_393_1.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_393_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_393_1.position).x, (manager.ui.mainCamera.transform.position - var_393_1.position).y, (manager.ui.mainCamera.transform.position - var_393_1.position).z)
				var_393_1.localEulerAngles.z = 0
				var_393_1.localEulerAngles.x = 0
				var_393_1.localEulerAngles = var_393_1.localEulerAngles
			end

			local var_393_3 = arg_390_1.actors_["1043ui_story"]

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(var_393_3) and arg_390_1.var_.characterEffect1043ui_story == nil then
				arg_390_1.var_.characterEffect1043ui_story = var_393_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_4 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 and not isNil(var_393_3) then
				if arg_390_1.var_.characterEffect1043ui_story and not isNil(var_393_3) then
					arg_390_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 and not isNil(var_393_3) and arg_390_1.var_.characterEffect1043ui_story then
				arg_390_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_393_6 = arg_390_1.actors_["1111ui_story"]

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(var_393_6) and arg_390_1.var_.characterEffect1111ui_story == nil then
				arg_390_1.var_.characterEffect1111ui_story = var_393_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_7 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_7 and not isNil(var_393_6) then
				if arg_390_1.var_.characterEffect1111ui_story and not isNil(var_393_6) then
					arg_390_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_390_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_390_1.time_ - 0) / var_393_7)
				end
			end

			if arg_390_1.time_ >= 0 + var_393_7 and arg_390_1.time_ < 0 + var_393_7 + arg_393_0 and not isNil(var_393_6) and arg_390_1.var_.characterEffect1111ui_story then
				arg_390_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_390_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_1")
			end

			local var_393_8 = 0
			local var_393_9 = 0.3

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_8 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_10 = arg_390_1:GetWordFromCfg(322192095)
				local var_393_11 = arg_390_1:FormatText(var_393_10.content)

				arg_390_1.text_.text = var_393_11

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_13 = 12 <= 0 and var_393_9 or var_393_9 * (utf8.len(var_393_11) / 12)

				if (12 <= 0 and var_393_9 or var_393_9 * (utf8.len(var_393_11) / 12)) > 0 and var_393_9 < var_393_13 then
					arg_390_1.talkMaxDuration = var_393_13

					if var_393_13 + var_393_8 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_13 + var_393_8
					end
				end

				arg_390_1.text_.text = var_393_11
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192095", "story_v_out_322192.awb") ~= 0 then
					local var_393_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192095", "story_v_out_322192.awb") / 1000

					if var_393_14 + var_393_8 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_14 + var_393_8
					end

					if var_393_10.prefab_name ~= "" and arg_390_1.actors_[var_393_10.prefab_name] ~= nil then
						local var_393_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_10.prefab_name].transform, "story_v_out_322192", "322192095", "story_v_out_322192.awb")

						arg_390_1:RecordAudio("322192095", var_393_15)
						arg_390_1:RecordAudio("322192095", var_393_15)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_322192", "322192095", "story_v_out_322192.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_322192", "322192095", "story_v_out_322192.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_16 = math.max(var_393_9, arg_390_1.talkMaxDuration)

			if var_393_8 <= arg_390_1.time_ and arg_390_1.time_ < var_393_8 + var_393_16 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_8) / var_393_16

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_8 + var_393_16 and arg_390_1.time_ < var_393_8 + var_393_16 + arg_393_0 then
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
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1111ui_story"]) and arg_394_1.var_.characterEffect1111ui_story == nil then
				arg_394_1.var_.characterEffect1111ui_story = arg_394_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_0 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1111ui_story"]) then
				if arg_394_1.var_.characterEffect1111ui_story and not isNil(arg_394_1.actors_["1111ui_story"]) then
					arg_394_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1111ui_story"]) and arg_394_1.var_.characterEffect1111ui_story then
				arg_394_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_397_2 = arg_394_1.actors_["1043ui_story"]

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(var_397_2) and arg_394_1.var_.characterEffect1043ui_story == nil then
				arg_394_1.var_.characterEffect1043ui_story = var_397_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_3 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_3 and not isNil(var_397_2) then
				if arg_394_1.var_.characterEffect1043ui_story and not isNil(var_397_2) then
					arg_394_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_394_1.time_ - 0) / var_397_3)
				end
			end

			if arg_394_1.time_ >= 0 + var_397_3 and arg_394_1.time_ < 0 + var_397_3 + arg_397_0 and not isNil(var_397_2) and arg_394_1.var_.characterEffect1043ui_story then
				arg_394_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			local var_397_4 = 0
			local var_397_5 = 0.35

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_4 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_6 = arg_394_1:GetWordFromCfg(322192096)
				local var_397_7 = arg_394_1:FormatText(var_397_6.content)

				arg_394_1.text_.text = var_397_7

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_9 = 14 <= 0 and var_397_5 or var_397_5 * (utf8.len(var_397_7) / 14)

				if (14 <= 0 and var_397_5 or var_397_5 * (utf8.len(var_397_7) / 14)) > 0 and var_397_5 < var_397_9 then
					arg_394_1.talkMaxDuration = var_397_9

					if var_397_9 + var_397_4 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_9 + var_397_4
					end
				end

				arg_394_1.text_.text = var_397_7
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192096", "story_v_out_322192.awb") ~= 0 then
					local var_397_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192096", "story_v_out_322192.awb") / 1000

					if var_397_10 + var_397_4 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_10 + var_397_4
					end

					if var_397_6.prefab_name ~= "" and arg_394_1.actors_[var_397_6.prefab_name] ~= nil then
						local var_397_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_6.prefab_name].transform, "story_v_out_322192", "322192096", "story_v_out_322192.awb")

						arg_394_1:RecordAudio("322192096", var_397_11)
						arg_394_1:RecordAudio("322192096", var_397_11)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_322192", "322192096", "story_v_out_322192.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_322192", "322192096", "story_v_out_322192.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_12 = math.max(var_397_5, arg_394_1.talkMaxDuration)

			if var_397_4 <= arg_394_1.time_ and arg_394_1.time_ < var_397_4 + var_397_12 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_4) / var_397_12

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_4 + var_397_12 and arg_394_1.time_ < var_397_4 + var_397_12 + arg_397_0 then
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
			local var_401_0 = 1.275

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_1 = arg_398_1:GetWordFromCfg(322192097)
				local var_401_2 = arg_398_1:FormatText(var_401_1.content)

				arg_398_1.text_.text = var_401_2

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_4 = 51 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 51)

				if (51 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 51)) > 0 and var_401_0 < var_401_4 then
					arg_398_1.talkMaxDuration = var_401_4

					if var_401_4 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_4 + 0
					end
				end

				arg_398_1.text_.text = var_401_2
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192097", "story_v_out_322192.awb") ~= 0 then
					local var_401_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192097", "story_v_out_322192.awb") / 1000

					if var_401_5 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + 0
					end

					if var_401_1.prefab_name ~= "" and arg_398_1.actors_[var_401_1.prefab_name] ~= nil then
						local var_401_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_1.prefab_name].transform, "story_v_out_322192", "322192097", "story_v_out_322192.awb")

						arg_398_1:RecordAudio("322192097", var_401_6)
						arg_398_1:RecordAudio("322192097", var_401_6)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_322192", "322192097", "story_v_out_322192.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_322192", "322192097", "story_v_out_322192.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_7 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_7 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_7

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_7 and arg_398_1.time_ < 0 + var_401_7 + arg_401_0 then
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
			local var_405_0 = 0.8

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_1 = arg_402_1:GetWordFromCfg(322192098)
				local var_405_2 = arg_402_1:FormatText(var_405_1.content)

				arg_402_1.text_.text = var_405_2

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_4 = 32 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 32)

				if (32 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 32)) > 0 and var_405_0 < var_405_4 then
					arg_402_1.talkMaxDuration = var_405_4

					if var_405_4 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_4 + 0
					end
				end

				arg_402_1.text_.text = var_405_2
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192098", "story_v_out_322192.awb") ~= 0 then
					local var_405_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192098", "story_v_out_322192.awb") / 1000

					if var_405_5 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + 0
					end

					if var_405_1.prefab_name ~= "" and arg_402_1.actors_[var_405_1.prefab_name] ~= nil then
						local var_405_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_1.prefab_name].transform, "story_v_out_322192", "322192098", "story_v_out_322192.awb")

						arg_402_1:RecordAudio("322192098", var_405_6)
						arg_402_1:RecordAudio("322192098", var_405_6)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_322192", "322192098", "story_v_out_322192.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_322192", "322192098", "story_v_out_322192.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_7 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_7 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_7

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_7 and arg_402_1.time_ < 0 + var_405_7 + arg_405_0 then
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
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["1043ui_story"]) and arg_406_1.var_.characterEffect1043ui_story == nil then
				arg_406_1.var_.characterEffect1043ui_story = arg_406_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_0 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["1043ui_story"]) then
				if arg_406_1.var_.characterEffect1043ui_story and not isNil(arg_406_1.actors_["1043ui_story"]) then
					arg_406_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["1043ui_story"]) and arg_406_1.var_.characterEffect1043ui_story then
				arg_406_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_409_2 = arg_406_1.actors_["1111ui_story"]

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(var_409_2) and arg_406_1.var_.characterEffect1111ui_story == nil then
				arg_406_1.var_.characterEffect1111ui_story = var_409_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_3 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_3 and not isNil(var_409_2) then
				if arg_406_1.var_.characterEffect1111ui_story and not isNil(var_409_2) then
					arg_406_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_406_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_406_1.time_ - 0) / var_409_3)
				end
			end

			if arg_406_1.time_ >= 0 + var_409_3 and arg_406_1.time_ < 0 + var_409_3 + arg_409_0 and not isNil(var_409_2) and arg_406_1.var_.characterEffect1111ui_story then
				arg_406_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_406_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_2")
			end

			local var_409_4 = 0
			local var_409_5 = 1.15

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_4 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_6 = arg_406_1:GetWordFromCfg(322192099)
				local var_409_7 = arg_406_1:FormatText(var_409_6.content)

				arg_406_1.text_.text = var_409_7

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_9 = 46 <= 0 and var_409_5 or var_409_5 * (utf8.len(var_409_7) / 46)

				if (46 <= 0 and var_409_5 or var_409_5 * (utf8.len(var_409_7) / 46)) > 0 and var_409_5 < var_409_9 then
					arg_406_1.talkMaxDuration = var_409_9

					if var_409_9 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_9 + var_409_4
					end
				end

				arg_406_1.text_.text = var_409_7
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192099", "story_v_out_322192.awb") ~= 0 then
					local var_409_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192099", "story_v_out_322192.awb") / 1000

					if var_409_10 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_10 + var_409_4
					end

					if var_409_6.prefab_name ~= "" and arg_406_1.actors_[var_409_6.prefab_name] ~= nil then
						local var_409_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_6.prefab_name].transform, "story_v_out_322192", "322192099", "story_v_out_322192.awb")

						arg_406_1:RecordAudio("322192099", var_409_11)
						arg_406_1:RecordAudio("322192099", var_409_11)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_322192", "322192099", "story_v_out_322192.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_322192", "322192099", "story_v_out_322192.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_12 = math.max(var_409_5, arg_406_1.talkMaxDuration)

			if var_409_4 <= arg_406_1.time_ and arg_406_1.time_ < var_409_4 + var_409_12 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_4) / var_409_12

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_4 + var_409_12 and arg_406_1.time_ < var_409_4 + var_409_12 + arg_409_0 then
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
			local var_413_0 = 0.85

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_1 = arg_410_1:GetWordFromCfg(322192100)
				local var_413_2 = arg_410_1:FormatText(var_413_1.content)

				arg_410_1.text_.text = var_413_2

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_4 = 34 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 34)

				if (34 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 34)) > 0 and var_413_0 < var_413_4 then
					arg_410_1.talkMaxDuration = var_413_4

					if var_413_4 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_4 + 0
					end
				end

				arg_410_1.text_.text = var_413_2
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192100", "story_v_out_322192.awb") ~= 0 then
					local var_413_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192100", "story_v_out_322192.awb") / 1000

					if var_413_5 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + 0
					end

					if var_413_1.prefab_name ~= "" and arg_410_1.actors_[var_413_1.prefab_name] ~= nil then
						local var_413_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_1.prefab_name].transform, "story_v_out_322192", "322192100", "story_v_out_322192.awb")

						arg_410_1:RecordAudio("322192100", var_413_6)
						arg_410_1:RecordAudio("322192100", var_413_6)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_322192", "322192100", "story_v_out_322192.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_322192", "322192100", "story_v_out_322192.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_7 = math.max(var_413_0, arg_410_1.talkMaxDuration)

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_7 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - 0) / var_413_7

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= 0 + var_413_7 and arg_410_1.time_ < 0 + var_413_7 + arg_413_0 then
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
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(arg_414_1.actors_["1111ui_story"]) and arg_414_1.var_.characterEffect1111ui_story == nil then
				arg_414_1.var_.characterEffect1111ui_story = arg_414_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_0 = 0.200000002980232

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 and not isNil(arg_414_1.actors_["1111ui_story"]) then
				if arg_414_1.var_.characterEffect1111ui_story and not isNil(arg_414_1.actors_["1111ui_story"]) then
					arg_414_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 and not isNil(arg_414_1.actors_["1111ui_story"]) and arg_414_1.var_.characterEffect1111ui_story then
				arg_414_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_417_2 = arg_414_1.actors_["1043ui_story"]

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(var_417_2) and arg_414_1.var_.characterEffect1043ui_story == nil then
				arg_414_1.var_.characterEffect1043ui_story = var_417_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_3 = 0.200000002980232

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_3 and not isNil(var_417_2) then
				if arg_414_1.var_.characterEffect1043ui_story and not isNil(var_417_2) then
					arg_414_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_414_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_414_1.time_ - 0) / var_417_3)
				end
			end

			if arg_414_1.time_ >= 0 + var_417_3 and arg_414_1.time_ < 0 + var_417_3 + arg_417_0 and not isNil(var_417_2) and arg_414_1.var_.characterEffect1043ui_story then
				arg_414_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_414_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_2")
			end

			local var_417_4 = 0
			local var_417_5 = 0.35

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_4 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_6 = arg_414_1:GetWordFromCfg(322192101)
				local var_417_7 = arg_414_1:FormatText(var_417_6.content)

				arg_414_1.text_.text = var_417_7

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_9 = 14 <= 0 and var_417_5 or var_417_5 * (utf8.len(var_417_7) / 14)

				if (14 <= 0 and var_417_5 or var_417_5 * (utf8.len(var_417_7) / 14)) > 0 and var_417_5 < var_417_9 then
					arg_414_1.talkMaxDuration = var_417_9

					if var_417_9 + var_417_4 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_9 + var_417_4
					end
				end

				arg_414_1.text_.text = var_417_7
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192101", "story_v_out_322192.awb") ~= 0 then
					local var_417_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192101", "story_v_out_322192.awb") / 1000

					if var_417_10 + var_417_4 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_10 + var_417_4
					end

					if var_417_6.prefab_name ~= "" and arg_414_1.actors_[var_417_6.prefab_name] ~= nil then
						local var_417_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_6.prefab_name].transform, "story_v_out_322192", "322192101", "story_v_out_322192.awb")

						arg_414_1:RecordAudio("322192101", var_417_11)
						arg_414_1:RecordAudio("322192101", var_417_11)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_322192", "322192101", "story_v_out_322192.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_322192", "322192101", "story_v_out_322192.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_12 = math.max(var_417_5, arg_414_1.talkMaxDuration)

			if var_417_4 <= arg_414_1.time_ and arg_414_1.time_ < var_417_4 + var_417_12 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_4) / var_417_12

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_4 + var_417_12 and arg_414_1.time_ < var_417_4 + var_417_12 + arg_417_0 then
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
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["1043ui_story"]) and arg_418_1.var_.characterEffect1043ui_story == nil then
				arg_418_1.var_.characterEffect1043ui_story = arg_418_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_0 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["1043ui_story"]) then
				if arg_418_1.var_.characterEffect1043ui_story and not isNil(arg_418_1.actors_["1043ui_story"]) then
					arg_418_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["1043ui_story"]) and arg_418_1.var_.characterEffect1043ui_story then
				arg_418_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_421_2 = arg_418_1.actors_["1111ui_story"]

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(var_421_2) and arg_418_1.var_.characterEffect1111ui_story == nil then
				arg_418_1.var_.characterEffect1111ui_story = var_421_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_3 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_3 and not isNil(var_421_2) then
				if arg_418_1.var_.characterEffect1111ui_story and not isNil(var_421_2) then
					arg_418_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_418_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_418_1.time_ - 0) / var_421_3)
				end
			end

			if arg_418_1.time_ >= 0 + var_421_3 and arg_418_1.time_ < 0 + var_421_3 + arg_421_0 and not isNil(var_421_2) and arg_418_1.var_.characterEffect1111ui_story then
				arg_418_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_418_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_421_4 = 0
			local var_421_5 = 1.025

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_4 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_6 = arg_418_1:GetWordFromCfg(322192102)
				local var_421_7 = arg_418_1:FormatText(var_421_6.content)

				arg_418_1.text_.text = var_421_7

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_9 = 41 <= 0 and var_421_5 or var_421_5 * (utf8.len(var_421_7) / 41)

				if (41 <= 0 and var_421_5 or var_421_5 * (utf8.len(var_421_7) / 41)) > 0 and var_421_5 < var_421_9 then
					arg_418_1.talkMaxDuration = var_421_9

					if var_421_9 + var_421_4 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_9 + var_421_4
					end
				end

				arg_418_1.text_.text = var_421_7
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192102", "story_v_out_322192.awb") ~= 0 then
					local var_421_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192102", "story_v_out_322192.awb") / 1000

					if var_421_10 + var_421_4 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_10 + var_421_4
					end

					if var_421_6.prefab_name ~= "" and arg_418_1.actors_[var_421_6.prefab_name] ~= nil then
						local var_421_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_6.prefab_name].transform, "story_v_out_322192", "322192102", "story_v_out_322192.awb")

						arg_418_1:RecordAudio("322192102", var_421_11)
						arg_418_1:RecordAudio("322192102", var_421_11)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_322192", "322192102", "story_v_out_322192.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_322192", "322192102", "story_v_out_322192.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_12 = math.max(var_421_5, arg_418_1.talkMaxDuration)

			if var_421_4 <= arg_418_1.time_ and arg_418_1.time_ < var_421_4 + var_421_12 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_4) / var_421_12

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_4 + var_421_12 and arg_418_1.time_ < var_421_4 + var_421_12 + arg_421_0 then
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
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.var_.moveOldPos1111ui_story = arg_422_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_425_0 = 0.001

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 then
				arg_422_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_422_1.time_ - 0) / var_425_0)
				arg_422_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_422_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1111ui_story"].transform.position).z)
				arg_422_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_422_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_422_1.actors_["1111ui_story"].transform.localEulerAngles = arg_422_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 then
				arg_422_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_422_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_422_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_422_1.actors_["1111ui_story"].transform.position).z)
				arg_422_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_422_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_422_1.actors_["1111ui_story"].transform.localEulerAngles = arg_422_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_425_1 = arg_422_1.actors_["1043ui_story"].transform

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.var_.moveOldPos1043ui_story = var_425_1.localPosition
			end

			local var_425_2 = 0.001

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_2 then
				var_425_1.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_422_1.time_ - 0) / var_425_2)
				var_425_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_425_1.position).x, (manager.ui.mainCamera.transform.position - var_425_1.position).y, (manager.ui.mainCamera.transform.position - var_425_1.position).z)
				var_425_1.localEulerAngles.z = 0
				var_425_1.localEulerAngles.x = 0
				var_425_1.localEulerAngles = var_425_1.localEulerAngles
			end

			if arg_422_1.time_ >= 0 + var_425_2 and arg_422_1.time_ < 0 + var_425_2 + arg_425_0 then
				var_425_1.localPosition = Vector3.New(0, 100, 0)
				var_425_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_425_1.position).x, (manager.ui.mainCamera.transform.position - var_425_1.position).y, (manager.ui.mainCamera.transform.position - var_425_1.position).z)
				var_425_1.localEulerAngles.z = 0
				var_425_1.localEulerAngles.x = 0
				var_425_1.localEulerAngles = var_425_1.localEulerAngles
			end

			local var_425_3 = 0
			local var_425_4 = 1.75

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_3 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_5 = arg_422_1:FormatText(arg_422_1:GetWordFromCfg(322192103).content)

				arg_422_1.text_.text = var_425_5

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_7 = 70 <= 0 and var_425_4 or var_425_4 * (utf8.len(var_425_5) / 70)

				if (70 <= 0 and var_425_4 or var_425_4 * (utf8.len(var_425_5) / 70)) > 0 and var_425_4 < var_425_7 then
					arg_422_1.talkMaxDuration = var_425_7

					if var_425_7 + var_425_3 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_7 + var_425_3
					end
				end

				arg_422_1.text_.text = var_425_5
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_8 = math.max(var_425_4, arg_422_1.talkMaxDuration)

			if var_425_3 <= arg_422_1.time_ and arg_422_1.time_ < var_425_3 + var_425_8 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_3) / var_425_8

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_3 + var_425_8 and arg_422_1.time_ < var_425_3 + var_425_8 + arg_425_0 then
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
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.var_.moveOldPos1043ui_story = arg_426_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_429_0 = 0.001

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 then
				arg_426_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_426_1.time_ - 0) / var_429_0)
				arg_426_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_426_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1043ui_story"].transform.position).z)
				arg_426_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_426_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_426_1.actors_["1043ui_story"].transform.localEulerAngles = arg_426_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 then
				arg_426_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_426_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_426_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1043ui_story"].transform.position).z)
				arg_426_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_426_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_426_1.actors_["1043ui_story"].transform.localEulerAngles = arg_426_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_429_1 = arg_426_1.actors_["1043ui_story"]

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(var_429_1) and arg_426_1.var_.characterEffect1043ui_story == nil then
				arg_426_1.var_.characterEffect1043ui_story = var_429_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_2 = 0.200000002980232

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_2 and not isNil(var_429_1) then
				if arg_426_1.var_.characterEffect1043ui_story and not isNil(var_429_1) then
					arg_426_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= 0 + var_429_2 and arg_426_1.time_ < 0 + var_429_2 + arg_429_0 and not isNil(var_429_1) and arg_426_1.var_.characterEffect1043ui_story then
				arg_426_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_429_4 = 0
			local var_429_5 = 1

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_4 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_6 = arg_426_1:GetWordFromCfg(322192104)
				local var_429_7 = arg_426_1:FormatText(var_429_6.content)

				arg_426_1.text_.text = var_429_7

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_9 = 40 <= 0 and var_429_5 or var_429_5 * (utf8.len(var_429_7) / 40)

				if (40 <= 0 and var_429_5 or var_429_5 * (utf8.len(var_429_7) / 40)) > 0 and var_429_5 < var_429_9 then
					arg_426_1.talkMaxDuration = var_429_9

					if var_429_9 + var_429_4 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_9 + var_429_4
					end
				end

				arg_426_1.text_.text = var_429_7
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192104", "story_v_out_322192.awb") ~= 0 then
					local var_429_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192104", "story_v_out_322192.awb") / 1000

					if var_429_10 + var_429_4 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_10 + var_429_4
					end

					if var_429_6.prefab_name ~= "" and arg_426_1.actors_[var_429_6.prefab_name] ~= nil then
						local var_429_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_6.prefab_name].transform, "story_v_out_322192", "322192104", "story_v_out_322192.awb")

						arg_426_1:RecordAudio("322192104", var_429_11)
						arg_426_1:RecordAudio("322192104", var_429_11)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_322192", "322192104", "story_v_out_322192.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_322192", "322192104", "story_v_out_322192.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_12 = math.max(var_429_5, arg_426_1.talkMaxDuration)

			if var_429_4 <= arg_426_1.time_ and arg_426_1.time_ < var_429_4 + var_429_12 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_4) / var_429_12

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_4 + var_429_12 and arg_426_1.time_ < var_429_4 + var_429_12 + arg_429_0 then
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
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos1111ui_story = arg_430_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_433_0 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 then
				arg_430_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_430_1.time_ - 0) / var_433_0)
				arg_430_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1111ui_story"].transform.position).z)
				arg_430_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["1111ui_story"].transform.localEulerAngles = arg_430_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 then
				arg_430_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_430_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1111ui_story"].transform.position).z)
				arg_430_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["1111ui_story"].transform.localEulerAngles = arg_430_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_433_1 = arg_430_1.actors_["1043ui_story"].transform

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos1043ui_story = var_433_1.localPosition
			end

			local var_433_2 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_2 then
				var_433_1.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_430_1.time_ - 0) / var_433_2)
				var_433_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_433_1.position).x, (manager.ui.mainCamera.transform.position - var_433_1.position).y, (manager.ui.mainCamera.transform.position - var_433_1.position).z)
				var_433_1.localEulerAngles.z = 0
				var_433_1.localEulerAngles.x = 0
				var_433_1.localEulerAngles = var_433_1.localEulerAngles
			end

			if arg_430_1.time_ >= 0 + var_433_2 and arg_430_1.time_ < 0 + var_433_2 + arg_433_0 then
				var_433_1.localPosition = Vector3.New(0, 100, 0)
				var_433_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_433_1.position).x, (manager.ui.mainCamera.transform.position - var_433_1.position).y, (manager.ui.mainCamera.transform.position - var_433_1.position).z)
				var_433_1.localEulerAngles.z = 0
				var_433_1.localEulerAngles.x = 0
				var_433_1.localEulerAngles = var_433_1.localEulerAngles
			end

			local var_433_3 = arg_430_1.actors_["1111ui_story"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_3) and arg_430_1.var_.characterEffect1111ui_story == nil then
				arg_430_1.var_.characterEffect1111ui_story = var_433_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_4 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_4 and not isNil(var_433_3) then
				if arg_430_1.var_.characterEffect1111ui_story and not isNil(var_433_3) then
					arg_430_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= 0 + var_433_4 and arg_430_1.time_ < 0 + var_433_4 + arg_433_0 and not isNil(var_433_3) and arg_430_1.var_.characterEffect1111ui_story then
				arg_430_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_433_6 = arg_430_1.actors_["1043ui_story"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_6) and arg_430_1.var_.characterEffect1043ui_story == nil then
				arg_430_1.var_.characterEffect1043ui_story = var_433_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_7 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_7 and not isNil(var_433_6) then
				if arg_430_1.var_.characterEffect1043ui_story and not isNil(var_433_6) then
					arg_430_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_430_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_430_1.time_ - 0) / var_433_7)
				end
			end

			if arg_430_1.time_ >= 0 + var_433_7 and arg_430_1.time_ < 0 + var_433_7 + arg_433_0 and not isNil(var_433_6) and arg_430_1.var_.characterEffect1043ui_story then
				arg_430_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_430_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_433_8 = 0
			local var_433_9 = 0.375

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_8 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_10 = arg_430_1:GetWordFromCfg(322192105)
				local var_433_11 = arg_430_1:FormatText(var_433_10.content)

				arg_430_1.text_.text = var_433_11

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_13 = 15 <= 0 and var_433_9 or var_433_9 * (utf8.len(var_433_11) / 15)

				if (15 <= 0 and var_433_9 or var_433_9 * (utf8.len(var_433_11) / 15)) > 0 and var_433_9 < var_433_13 then
					arg_430_1.talkMaxDuration = var_433_13

					if var_433_13 + var_433_8 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_13 + var_433_8
					end
				end

				arg_430_1.text_.text = var_433_11
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192105", "story_v_out_322192.awb") ~= 0 then
					local var_433_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192105", "story_v_out_322192.awb") / 1000

					if var_433_14 + var_433_8 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_14 + var_433_8
					end

					if var_433_10.prefab_name ~= "" and arg_430_1.actors_[var_433_10.prefab_name] ~= nil then
						local var_433_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_10.prefab_name].transform, "story_v_out_322192", "322192105", "story_v_out_322192.awb")

						arg_430_1:RecordAudio("322192105", var_433_15)
						arg_430_1:RecordAudio("322192105", var_433_15)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_322192", "322192105", "story_v_out_322192.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_322192", "322192105", "story_v_out_322192.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_16 = math.max(var_433_9, arg_430_1.talkMaxDuration)

			if var_433_8 <= arg_430_1.time_ and arg_430_1.time_ < var_433_8 + var_433_16 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_8) / var_433_16

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_8 + var_433_16 and arg_430_1.time_ < var_433_8 + var_433_16 + arg_433_0 then
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
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.var_.moveOldPos1111ui_story = arg_434_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_437_0 = 0.001

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 then
				arg_434_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_434_1.time_ - 0) / var_437_0)
				arg_434_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_434_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1111ui_story"].transform.position).z)
				arg_434_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_434_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_434_1.actors_["1111ui_story"].transform.localEulerAngles = arg_434_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 then
				arg_434_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_434_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_434_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1111ui_story"].transform.position).z)
				arg_434_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_434_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_434_1.actors_["1111ui_story"].transform.localEulerAngles = arg_434_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_437_1 = arg_434_1.actors_["1043ui_story"].transform

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.var_.moveOldPos1043ui_story = var_437_1.localPosition
			end

			local var_437_2 = 0.001

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_2 then
				var_437_1.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_434_1.time_ - 0) / var_437_2)
				var_437_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_437_1.position).x, (manager.ui.mainCamera.transform.position - var_437_1.position).y, (manager.ui.mainCamera.transform.position - var_437_1.position).z)
				var_437_1.localEulerAngles.z = 0
				var_437_1.localEulerAngles.x = 0
				var_437_1.localEulerAngles = var_437_1.localEulerAngles
			end

			if arg_434_1.time_ >= 0 + var_437_2 and arg_434_1.time_ < 0 + var_437_2 + arg_437_0 then
				var_437_1.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_437_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_437_1.position).x, (manager.ui.mainCamera.transform.position - var_437_1.position).y, (manager.ui.mainCamera.transform.position - var_437_1.position).z)
				var_437_1.localEulerAngles.z = 0
				var_437_1.localEulerAngles.x = 0
				var_437_1.localEulerAngles = var_437_1.localEulerAngles
			end

			local var_437_3 = arg_434_1.actors_["1043ui_story"]

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(var_437_3) and arg_434_1.var_.characterEffect1043ui_story == nil then
				arg_434_1.var_.characterEffect1043ui_story = var_437_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_4 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_4 and not isNil(var_437_3) then
				if arg_434_1.var_.characterEffect1043ui_story and not isNil(var_437_3) then
					arg_434_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= 0 + var_437_4 and arg_434_1.time_ < 0 + var_437_4 + arg_437_0 and not isNil(var_437_3) and arg_434_1.var_.characterEffect1043ui_story then
				arg_434_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_437_6 = arg_434_1.actors_["1111ui_story"]

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(var_437_6) and arg_434_1.var_.characterEffect1111ui_story == nil then
				arg_434_1.var_.characterEffect1111ui_story = var_437_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_7 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_7 and not isNil(var_437_6) then
				if arg_434_1.var_.characterEffect1111ui_story and not isNil(var_437_6) then
					arg_434_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_434_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_434_1.time_ - 0) / var_437_7)
				end
			end

			if arg_434_1.time_ >= 0 + var_437_7 and arg_434_1.time_ < 0 + var_437_7 + arg_437_0 and not isNil(var_437_6) and arg_434_1.var_.characterEffect1111ui_story then
				arg_434_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_434_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_437_8 = 0
			local var_437_9 = 0.125

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_8 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_10 = arg_434_1:GetWordFromCfg(322192106)
				local var_437_11 = arg_434_1:FormatText(var_437_10.content)

				arg_434_1.text_.text = var_437_11

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_13 = 5 <= 0 and var_437_9 or var_437_9 * (utf8.len(var_437_11) / 5)

				if (5 <= 0 and var_437_9 or var_437_9 * (utf8.len(var_437_11) / 5)) > 0 and var_437_9 < var_437_13 then
					arg_434_1.talkMaxDuration = var_437_13

					if var_437_13 + var_437_8 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_13 + var_437_8
					end
				end

				arg_434_1.text_.text = var_437_11
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192106", "story_v_out_322192.awb") ~= 0 then
					local var_437_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192106", "story_v_out_322192.awb") / 1000

					if var_437_14 + var_437_8 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_14 + var_437_8
					end

					if var_437_10.prefab_name ~= "" and arg_434_1.actors_[var_437_10.prefab_name] ~= nil then
						local var_437_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_10.prefab_name].transform, "story_v_out_322192", "322192106", "story_v_out_322192.awb")

						arg_434_1:RecordAudio("322192106", var_437_15)
						arg_434_1:RecordAudio("322192106", var_437_15)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_322192", "322192106", "story_v_out_322192.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_322192", "322192106", "story_v_out_322192.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_16 = math.max(var_437_9, arg_434_1.talkMaxDuration)

			if var_437_8 <= arg_434_1.time_ and arg_434_1.time_ < var_437_8 + var_437_16 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_8) / var_437_16

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_8 + var_437_16 and arg_434_1.time_ < var_437_8 + var_437_16 + arg_437_0 then
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
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(arg_438_1.actors_["1111ui_story"]) and arg_438_1.var_.characterEffect1111ui_story == nil then
				arg_438_1.var_.characterEffect1111ui_story = arg_438_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_0 = 0.200000002980232

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 and not isNil(arg_438_1.actors_["1111ui_story"]) then
				if arg_438_1.var_.characterEffect1111ui_story and not isNil(arg_438_1.actors_["1111ui_story"]) then
					arg_438_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 and not isNil(arg_438_1.actors_["1111ui_story"]) and arg_438_1.var_.characterEffect1111ui_story then
				arg_438_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_441_2 = arg_438_1.actors_["1043ui_story"]

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(var_441_2) and arg_438_1.var_.characterEffect1043ui_story == nil then
				arg_438_1.var_.characterEffect1043ui_story = var_441_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_3 = 0.200000002980232

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_3 and not isNil(var_441_2) then
				if arg_438_1.var_.characterEffect1043ui_story and not isNil(var_441_2) then
					arg_438_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_438_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_438_1.time_ - 0) / var_441_3)
				end
			end

			if arg_438_1.time_ >= 0 + var_441_3 and arg_438_1.time_ < 0 + var_441_3 + arg_441_0 and not isNil(var_441_2) and arg_438_1.var_.characterEffect1043ui_story then
				arg_438_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_438_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_2")
			end

			local var_441_4 = 0
			local var_441_5 = 1.3

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_4 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_6 = arg_438_1:GetWordFromCfg(322192107)
				local var_441_7 = arg_438_1:FormatText(var_441_6.content)

				arg_438_1.text_.text = var_441_7

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_9 = 52 <= 0 and var_441_5 or var_441_5 * (utf8.len(var_441_7) / 52)

				if (52 <= 0 and var_441_5 or var_441_5 * (utf8.len(var_441_7) / 52)) > 0 and var_441_5 < var_441_9 then
					arg_438_1.talkMaxDuration = var_441_9

					if var_441_9 + var_441_4 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_9 + var_441_4
					end
				end

				arg_438_1.text_.text = var_441_7
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192107", "story_v_out_322192.awb") ~= 0 then
					local var_441_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192107", "story_v_out_322192.awb") / 1000

					if var_441_10 + var_441_4 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_10 + var_441_4
					end

					if var_441_6.prefab_name ~= "" and arg_438_1.actors_[var_441_6.prefab_name] ~= nil then
						local var_441_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_6.prefab_name].transform, "story_v_out_322192", "322192107", "story_v_out_322192.awb")

						arg_438_1:RecordAudio("322192107", var_441_11)
						arg_438_1:RecordAudio("322192107", var_441_11)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_322192", "322192107", "story_v_out_322192.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_322192", "322192107", "story_v_out_322192.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_12 = math.max(var_441_5, arg_438_1.talkMaxDuration)

			if var_441_4 <= arg_438_1.time_ and arg_438_1.time_ < var_441_4 + var_441_12 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_4) / var_441_12

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_4 + var_441_12 and arg_438_1.time_ < var_441_4 + var_441_12 + arg_441_0 then
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
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(arg_442_1.actors_["1043ui_story"]) and arg_442_1.var_.characterEffect1043ui_story == nil then
				arg_442_1.var_.characterEffect1043ui_story = arg_442_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_0 = 0.200000002980232

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 and not isNil(arg_442_1.actors_["1043ui_story"]) then
				if arg_442_1.var_.characterEffect1043ui_story and not isNil(arg_442_1.actors_["1043ui_story"]) then
					arg_442_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 and not isNil(arg_442_1.actors_["1043ui_story"]) and arg_442_1.var_.characterEffect1043ui_story then
				arg_442_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_445_2 = arg_442_1.actors_["1111ui_story"]

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(var_445_2) and arg_442_1.var_.characterEffect1111ui_story == nil then
				arg_442_1.var_.characterEffect1111ui_story = var_445_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_3 = 0.200000002980232

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_3 and not isNil(var_445_2) then
				if arg_442_1.var_.characterEffect1111ui_story and not isNil(var_445_2) then
					arg_442_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_442_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_442_1.time_ - 0) / var_445_3)
				end
			end

			if arg_442_1.time_ >= 0 + var_445_3 and arg_442_1.time_ < 0 + var_445_3 + arg_445_0 and not isNil(var_445_2) and arg_442_1.var_.characterEffect1111ui_story then
				arg_442_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_442_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			local var_445_4 = 0
			local var_445_5 = 0.175

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_4 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_6 = arg_442_1:GetWordFromCfg(322192108)
				local var_445_7 = arg_442_1:FormatText(var_445_6.content)

				arg_442_1.text_.text = var_445_7

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_9 = 7 <= 0 and var_445_5 or var_445_5 * (utf8.len(var_445_7) / 7)

				if (7 <= 0 and var_445_5 or var_445_5 * (utf8.len(var_445_7) / 7)) > 0 and var_445_5 < var_445_9 then
					arg_442_1.talkMaxDuration = var_445_9

					if var_445_9 + var_445_4 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_9 + var_445_4
					end
				end

				arg_442_1.text_.text = var_445_7
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192108", "story_v_out_322192.awb") ~= 0 then
					local var_445_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192108", "story_v_out_322192.awb") / 1000

					if var_445_10 + var_445_4 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_10 + var_445_4
					end

					if var_445_6.prefab_name ~= "" and arg_442_1.actors_[var_445_6.prefab_name] ~= nil then
						local var_445_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_6.prefab_name].transform, "story_v_out_322192", "322192108", "story_v_out_322192.awb")

						arg_442_1:RecordAudio("322192108", var_445_11)
						arg_442_1:RecordAudio("322192108", var_445_11)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_322192", "322192108", "story_v_out_322192.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_322192", "322192108", "story_v_out_322192.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_12 = math.max(var_445_5, arg_442_1.talkMaxDuration)

			if var_445_4 <= arg_442_1.time_ and arg_442_1.time_ < var_445_4 + var_445_12 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_4) / var_445_12

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_4 + var_445_12 and arg_442_1.time_ < var_445_4 + var_445_12 + arg_445_0 then
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
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(arg_446_1.actors_["1111ui_story"]) and arg_446_1.var_.characterEffect1111ui_story == nil then
				arg_446_1.var_.characterEffect1111ui_story = arg_446_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_0 = 0.200000002980232

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 and not isNil(arg_446_1.actors_["1111ui_story"]) then
				if arg_446_1.var_.characterEffect1111ui_story and not isNil(arg_446_1.actors_["1111ui_story"]) then
					arg_446_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 and not isNil(arg_446_1.actors_["1111ui_story"]) and arg_446_1.var_.characterEffect1111ui_story then
				arg_446_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_449_2 = arg_446_1.actors_["1043ui_story"]

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(var_449_2) and arg_446_1.var_.characterEffect1043ui_story == nil then
				arg_446_1.var_.characterEffect1043ui_story = var_449_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_3 = 0.200000002980232

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_3 and not isNil(var_449_2) then
				if arg_446_1.var_.characterEffect1043ui_story and not isNil(var_449_2) then
					arg_446_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_446_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_446_1.time_ - 0) / var_449_3)
				end
			end

			if arg_446_1.time_ >= 0 + var_449_3 and arg_446_1.time_ < 0 + var_449_3 + arg_449_0 and not isNil(var_449_2) and arg_446_1.var_.characterEffect1043ui_story then
				arg_446_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_446_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_449_4 = 0
			local var_449_5 = 0.55

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_4 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_6 = arg_446_1:GetWordFromCfg(322192109)
				local var_449_7 = arg_446_1:FormatText(var_449_6.content)

				arg_446_1.text_.text = var_449_7

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_9 = 22 <= 0 and var_449_5 or var_449_5 * (utf8.len(var_449_7) / 22)

				if (22 <= 0 and var_449_5 or var_449_5 * (utf8.len(var_449_7) / 22)) > 0 and var_449_5 < var_449_9 then
					arg_446_1.talkMaxDuration = var_449_9

					if var_449_9 + var_449_4 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_9 + var_449_4
					end
				end

				arg_446_1.text_.text = var_449_7
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192109", "story_v_out_322192.awb") ~= 0 then
					local var_449_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192109", "story_v_out_322192.awb") / 1000

					if var_449_10 + var_449_4 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_10 + var_449_4
					end

					if var_449_6.prefab_name ~= "" and arg_446_1.actors_[var_449_6.prefab_name] ~= nil then
						local var_449_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_6.prefab_name].transform, "story_v_out_322192", "322192109", "story_v_out_322192.awb")

						arg_446_1:RecordAudio("322192109", var_449_11)
						arg_446_1:RecordAudio("322192109", var_449_11)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_322192", "322192109", "story_v_out_322192.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_322192", "322192109", "story_v_out_322192.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_12 = math.max(var_449_5, arg_446_1.talkMaxDuration)

			if var_449_4 <= arg_446_1.time_ and arg_446_1.time_ < var_449_4 + var_449_12 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_4) / var_449_12

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_4 + var_449_12 and arg_446_1.time_ < var_449_4 + var_449_12 + arg_449_0 then
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
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_453_0 = 0
			local var_453_1 = 0.625

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_2 = arg_450_1:GetWordFromCfg(322192110)
				local var_453_3 = arg_450_1:FormatText(var_453_2.content)

				arg_450_1.text_.text = var_453_3

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 25 <= 0 and var_453_1 or var_453_1 * (utf8.len(var_453_3) / 25)

				if (25 <= 0 and var_453_1 or var_453_1 * (utf8.len(var_453_3) / 25)) > 0 and var_453_1 < var_453_5 then
					arg_450_1.talkMaxDuration = var_453_5

					if var_453_5 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + var_453_0
					end
				end

				arg_450_1.text_.text = var_453_3
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192110", "story_v_out_322192.awb") ~= 0 then
					local var_453_6 = manager.audio:GetVoiceLength("story_v_out_322192", "322192110", "story_v_out_322192.awb") / 1000

					if var_453_6 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_6 + var_453_0
					end

					if var_453_2.prefab_name ~= "" and arg_450_1.actors_[var_453_2.prefab_name] ~= nil then
						local var_453_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_2.prefab_name].transform, "story_v_out_322192", "322192110", "story_v_out_322192.awb")

						arg_450_1:RecordAudio("322192110", var_453_7)
						arg_450_1:RecordAudio("322192110", var_453_7)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_322192", "322192110", "story_v_out_322192.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_322192", "322192110", "story_v_out_322192.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_8 = math.max(var_453_1, arg_450_1.talkMaxDuration)

			if var_453_0 <= arg_450_1.time_ and arg_450_1.time_ < var_453_0 + var_453_8 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_0) / var_453_8

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_0 + var_453_8 and arg_450_1.time_ < var_453_0 + var_453_8 + arg_453_0 then
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
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(arg_454_1.actors_["1043ui_story"]) and arg_454_1.var_.characterEffect1043ui_story == nil then
				arg_454_1.var_.characterEffect1043ui_story = arg_454_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_0 = 0.200000002980232

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 and not isNil(arg_454_1.actors_["1043ui_story"]) then
				if arg_454_1.var_.characterEffect1043ui_story and not isNil(arg_454_1.actors_["1043ui_story"]) then
					arg_454_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 and not isNil(arg_454_1.actors_["1043ui_story"]) and arg_454_1.var_.characterEffect1043ui_story then
				arg_454_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_457_2 = arg_454_1.actors_["1111ui_story"]

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(var_457_2) and arg_454_1.var_.characterEffect1111ui_story == nil then
				arg_454_1.var_.characterEffect1111ui_story = var_457_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_3 = 0.200000002980232

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_3 and not isNil(var_457_2) then
				if arg_454_1.var_.characterEffect1111ui_story and not isNil(var_457_2) then
					arg_454_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_454_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_454_1.time_ - 0) / var_457_3)
				end
			end

			if arg_454_1.time_ >= 0 + var_457_3 and arg_454_1.time_ < 0 + var_457_3 + arg_457_0 and not isNil(var_457_2) and arg_454_1.var_.characterEffect1111ui_story then
				arg_454_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_454_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_2")
			end

			local var_457_4 = 0
			local var_457_5 = 0.175

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_4 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_6 = arg_454_1:GetWordFromCfg(322192111)
				local var_457_7 = arg_454_1:FormatText(var_457_6.content)

				arg_454_1.text_.text = var_457_7

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_9 = 7 <= 0 and var_457_5 or var_457_5 * (utf8.len(var_457_7) / 7)

				if (7 <= 0 and var_457_5 or var_457_5 * (utf8.len(var_457_7) / 7)) > 0 and var_457_5 < var_457_9 then
					arg_454_1.talkMaxDuration = var_457_9

					if var_457_9 + var_457_4 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_9 + var_457_4
					end
				end

				arg_454_1.text_.text = var_457_7
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192111", "story_v_out_322192.awb") ~= 0 then
					local var_457_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192111", "story_v_out_322192.awb") / 1000

					if var_457_10 + var_457_4 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_10 + var_457_4
					end

					if var_457_6.prefab_name ~= "" and arg_454_1.actors_[var_457_6.prefab_name] ~= nil then
						local var_457_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_6.prefab_name].transform, "story_v_out_322192", "322192111", "story_v_out_322192.awb")

						arg_454_1:RecordAudio("322192111", var_457_11)
						arg_454_1:RecordAudio("322192111", var_457_11)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_322192", "322192111", "story_v_out_322192.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_322192", "322192111", "story_v_out_322192.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_12 = math.max(var_457_5, arg_454_1.talkMaxDuration)

			if var_457_4 <= arg_454_1.time_ and arg_454_1.time_ < var_457_4 + var_457_12 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_4) / var_457_12

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_4 + var_457_12 and arg_454_1.time_ < var_457_4 + var_457_12 + arg_457_0 then
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
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["1111ui_story"]) and arg_458_1.var_.characterEffect1111ui_story == nil then
				arg_458_1.var_.characterEffect1111ui_story = arg_458_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_0 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["1111ui_story"]) then
				if arg_458_1.var_.characterEffect1111ui_story and not isNil(arg_458_1.actors_["1111ui_story"]) then
					arg_458_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["1111ui_story"]) and arg_458_1.var_.characterEffect1111ui_story then
				arg_458_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_461_2 = arg_458_1.actors_["1043ui_story"]

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(var_461_2) and arg_458_1.var_.characterEffect1043ui_story == nil then
				arg_458_1.var_.characterEffect1043ui_story = var_461_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_3 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_3 and not isNil(var_461_2) then
				if arg_458_1.var_.characterEffect1043ui_story and not isNil(var_461_2) then
					arg_458_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_458_1.time_ - 0) / var_461_3)
				end
			end

			if arg_458_1.time_ >= 0 + var_461_3 and arg_458_1.time_ < 0 + var_461_3 + arg_461_0 and not isNil(var_461_2) and arg_458_1.var_.characterEffect1043ui_story then
				arg_458_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_461_4 = 0
			local var_461_5 = 0.375

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_4 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_6 = arg_458_1:GetWordFromCfg(322192112)
				local var_461_7 = arg_458_1:FormatText(var_461_6.content)

				arg_458_1.text_.text = var_461_7

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_9 = 15 <= 0 and var_461_5 or var_461_5 * (utf8.len(var_461_7) / 15)

				if (15 <= 0 and var_461_5 or var_461_5 * (utf8.len(var_461_7) / 15)) > 0 and var_461_5 < var_461_9 then
					arg_458_1.talkMaxDuration = var_461_9

					if var_461_9 + var_461_4 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_9 + var_461_4
					end
				end

				arg_458_1.text_.text = var_461_7
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192112", "story_v_out_322192.awb") ~= 0 then
					local var_461_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192112", "story_v_out_322192.awb") / 1000

					if var_461_10 + var_461_4 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_10 + var_461_4
					end

					if var_461_6.prefab_name ~= "" and arg_458_1.actors_[var_461_6.prefab_name] ~= nil then
						local var_461_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_6.prefab_name].transform, "story_v_out_322192", "322192112", "story_v_out_322192.awb")

						arg_458_1:RecordAudio("322192112", var_461_11)
						arg_458_1:RecordAudio("322192112", var_461_11)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_322192", "322192112", "story_v_out_322192.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_322192", "322192112", "story_v_out_322192.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_12 = math.max(var_461_5, arg_458_1.talkMaxDuration)

			if var_461_4 <= arg_458_1.time_ and arg_458_1.time_ < var_461_4 + var_461_12 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_4) / var_461_12

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_4 + var_461_12 and arg_458_1.time_ < var_461_4 + var_461_12 + arg_461_0 then
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
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(arg_462_1.actors_["1043ui_story"]) and arg_462_1.var_.characterEffect1043ui_story == nil then
				arg_462_1.var_.characterEffect1043ui_story = arg_462_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_0 = 0.200000002980232

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 and not isNil(arg_462_1.actors_["1043ui_story"]) then
				if arg_462_1.var_.characterEffect1043ui_story and not isNil(arg_462_1.actors_["1043ui_story"]) then
					arg_462_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 and not isNil(arg_462_1.actors_["1043ui_story"]) and arg_462_1.var_.characterEffect1043ui_story then
				arg_462_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_465_2 = arg_462_1.actors_["1111ui_story"]

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(var_465_2) and arg_462_1.var_.characterEffect1111ui_story == nil then
				arg_462_1.var_.characterEffect1111ui_story = var_465_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_3 = 0.200000002980232

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_3 and not isNil(var_465_2) then
				if arg_462_1.var_.characterEffect1111ui_story and not isNil(var_465_2) then
					arg_462_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_462_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_462_1.time_ - 0) / var_465_3)
				end
			end

			if arg_462_1.time_ >= 0 + var_465_3 and arg_462_1.time_ < 0 + var_465_3 + arg_465_0 and not isNil(var_465_2) and arg_462_1.var_.characterEffect1111ui_story then
				arg_462_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_462_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_465_4 = 0
			local var_465_5 = 0.525

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_4 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_6 = arg_462_1:GetWordFromCfg(322192113)
				local var_465_7 = arg_462_1:FormatText(var_465_6.content)

				arg_462_1.text_.text = var_465_7

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_9 = 21 <= 0 and var_465_5 or var_465_5 * (utf8.len(var_465_7) / 21)

				if (21 <= 0 and var_465_5 or var_465_5 * (utf8.len(var_465_7) / 21)) > 0 and var_465_5 < var_465_9 then
					arg_462_1.talkMaxDuration = var_465_9

					if var_465_9 + var_465_4 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_9 + var_465_4
					end
				end

				arg_462_1.text_.text = var_465_7
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192113", "story_v_out_322192.awb") ~= 0 then
					local var_465_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192113", "story_v_out_322192.awb") / 1000

					if var_465_10 + var_465_4 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_10 + var_465_4
					end

					if var_465_6.prefab_name ~= "" and arg_462_1.actors_[var_465_6.prefab_name] ~= nil then
						local var_465_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_6.prefab_name].transform, "story_v_out_322192", "322192113", "story_v_out_322192.awb")

						arg_462_1:RecordAudio("322192113", var_465_11)
						arg_462_1:RecordAudio("322192113", var_465_11)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_322192", "322192113", "story_v_out_322192.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_322192", "322192113", "story_v_out_322192.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_12 = math.max(var_465_5, arg_462_1.talkMaxDuration)

			if var_465_4 <= arg_462_1.time_ and arg_462_1.time_ < var_465_4 + var_465_12 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_4) / var_465_12

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_4 + var_465_12 and arg_462_1.time_ < var_465_4 + var_465_12 + arg_465_0 then
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
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["1111ui_story"]) and arg_466_1.var_.characterEffect1111ui_story == nil then
				arg_466_1.var_.characterEffect1111ui_story = arg_466_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_0 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["1111ui_story"]) then
				if arg_466_1.var_.characterEffect1111ui_story and not isNil(arg_466_1.actors_["1111ui_story"]) then
					arg_466_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["1111ui_story"]) and arg_466_1.var_.characterEffect1111ui_story then
				arg_466_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_469_2 = arg_466_1.actors_["1043ui_story"]

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(var_469_2) and arg_466_1.var_.characterEffect1043ui_story == nil then
				arg_466_1.var_.characterEffect1043ui_story = var_469_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_3 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_3 and not isNil(var_469_2) then
				if arg_466_1.var_.characterEffect1043ui_story and not isNil(var_469_2) then
					arg_466_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_466_1.time_ - 0) / var_469_3)
				end
			end

			if arg_466_1.time_ >= 0 + var_469_3 and arg_466_1.time_ < 0 + var_469_3 + arg_469_0 and not isNil(var_469_2) and arg_466_1.var_.characterEffect1043ui_story then
				arg_466_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_469_4 = 0
			local var_469_5 = 0.2

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_4 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_6 = arg_466_1:GetWordFromCfg(322192114)
				local var_469_7 = arg_466_1:FormatText(var_469_6.content)

				arg_466_1.text_.text = var_469_7

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_9 = 8 <= 0 and var_469_5 or var_469_5 * (utf8.len(var_469_7) / 8)

				if (8 <= 0 and var_469_5 or var_469_5 * (utf8.len(var_469_7) / 8)) > 0 and var_469_5 < var_469_9 then
					arg_466_1.talkMaxDuration = var_469_9

					if var_469_9 + var_469_4 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_9 + var_469_4
					end
				end

				arg_466_1.text_.text = var_469_7
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192114", "story_v_out_322192.awb") ~= 0 then
					local var_469_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192114", "story_v_out_322192.awb") / 1000

					if var_469_10 + var_469_4 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_10 + var_469_4
					end

					if var_469_6.prefab_name ~= "" and arg_466_1.actors_[var_469_6.prefab_name] ~= nil then
						local var_469_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_6.prefab_name].transform, "story_v_out_322192", "322192114", "story_v_out_322192.awb")

						arg_466_1:RecordAudio("322192114", var_469_11)
						arg_466_1:RecordAudio("322192114", var_469_11)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_322192", "322192114", "story_v_out_322192.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_322192", "322192114", "story_v_out_322192.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_12 = math.max(var_469_5, arg_466_1.talkMaxDuration)

			if var_469_4 <= arg_466_1.time_ and arg_466_1.time_ < var_469_4 + var_469_12 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_4) / var_469_12

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_4 + var_469_12 and arg_466_1.time_ < var_469_4 + var_469_12 + arg_469_0 then
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
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos1111ui_story = arg_470_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_473_0 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 then
				arg_470_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_470_1.time_ - 0) / var_473_0)
				arg_470_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1111ui_story"].transform.position).z)
				arg_470_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1111ui_story"].transform.localEulerAngles = arg_470_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 then
				arg_470_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_470_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_470_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_470_1.actors_["1111ui_story"].transform.position).z)
				arg_470_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_470_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_470_1.actors_["1111ui_story"].transform.localEulerAngles = arg_470_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_473_1 = arg_470_1.actors_["1043ui_story"].transform

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.var_.moveOldPos1043ui_story = var_473_1.localPosition
			end

			local var_473_2 = 0.001

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_2 then
				var_473_1.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_470_1.time_ - 0) / var_473_2)
				var_473_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_473_1.position).x, (manager.ui.mainCamera.transform.position - var_473_1.position).y, (manager.ui.mainCamera.transform.position - var_473_1.position).z)
				var_473_1.localEulerAngles.z = 0
				var_473_1.localEulerAngles.x = 0
				var_473_1.localEulerAngles = var_473_1.localEulerAngles
			end

			if arg_470_1.time_ >= 0 + var_473_2 and arg_470_1.time_ < 0 + var_473_2 + arg_473_0 then
				var_473_1.localPosition = Vector3.New(0, 100, 0)
				var_473_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_473_1.position).x, (manager.ui.mainCamera.transform.position - var_473_1.position).y, (manager.ui.mainCamera.transform.position - var_473_1.position).z)
				var_473_1.localEulerAngles.z = 0
				var_473_1.localEulerAngles.x = 0
				var_473_1.localEulerAngles = var_473_1.localEulerAngles
			end

			local var_473_3 = 0
			local var_473_4 = 1.375

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_3 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_5 = arg_470_1:FormatText(arg_470_1:GetWordFromCfg(322192115).content)

				arg_470_1.text_.text = var_473_5

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_7 = 55 <= 0 and var_473_4 or var_473_4 * (utf8.len(var_473_5) / 55)

				if (55 <= 0 and var_473_4 or var_473_4 * (utf8.len(var_473_5) / 55)) > 0 and var_473_4 < var_473_7 then
					arg_470_1.talkMaxDuration = var_473_7

					if var_473_7 + var_473_3 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_7 + var_473_3
					end
				end

				arg_470_1.text_.text = var_473_5
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_8 = math.max(var_473_4, arg_470_1.talkMaxDuration)

			if var_473_3 <= arg_470_1.time_ and arg_470_1.time_ < var_473_3 + var_473_8 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_3) / var_473_8

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_3 + var_473_8 and arg_470_1.time_ < var_473_3 + var_473_8 + arg_473_0 then
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
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.var_.moveOldPos1043ui_story = arg_474_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_477_0 = 0.001

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_0 then
				arg_474_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_474_1.time_ - 0) / var_477_0)
				arg_474_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1043ui_story"].transform.position).z)
				arg_474_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["1043ui_story"].transform.localEulerAngles = arg_474_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_474_1.time_ >= 0 + var_477_0 and arg_474_1.time_ < 0 + var_477_0 + arg_477_0 then
				arg_474_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_474_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_474_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_474_1.actors_["1043ui_story"].transform.position).z)
				arg_474_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_474_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_474_1.actors_["1043ui_story"].transform.localEulerAngles = arg_474_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_477_1 = arg_474_1.actors_["1043ui_story"]

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(var_477_1) and arg_474_1.var_.characterEffect1043ui_story == nil then
				arg_474_1.var_.characterEffect1043ui_story = var_477_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_2 = 0.200000002980232

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_2 and not isNil(var_477_1) then
				if arg_474_1.var_.characterEffect1043ui_story and not isNil(var_477_1) then
					arg_474_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= 0 + var_477_2 and arg_474_1.time_ < 0 + var_477_2 + arg_477_0 and not isNil(var_477_1) and arg_474_1.var_.characterEffect1043ui_story then
				arg_474_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_477_4 = 0
			local var_477_5 = 0.775

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_4 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_6 = arg_474_1:GetWordFromCfg(322192116)
				local var_477_7 = arg_474_1:FormatText(var_477_6.content)

				arg_474_1.text_.text = var_477_7

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_9 = 31 <= 0 and var_477_5 or var_477_5 * (utf8.len(var_477_7) / 31)

				if (31 <= 0 and var_477_5 or var_477_5 * (utf8.len(var_477_7) / 31)) > 0 and var_477_5 < var_477_9 then
					arg_474_1.talkMaxDuration = var_477_9

					if var_477_9 + var_477_4 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_9 + var_477_4
					end
				end

				arg_474_1.text_.text = var_477_7
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192116", "story_v_out_322192.awb") ~= 0 then
					local var_477_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192116", "story_v_out_322192.awb") / 1000

					if var_477_10 + var_477_4 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_10 + var_477_4
					end

					if var_477_6.prefab_name ~= "" and arg_474_1.actors_[var_477_6.prefab_name] ~= nil then
						local var_477_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_6.prefab_name].transform, "story_v_out_322192", "322192116", "story_v_out_322192.awb")

						arg_474_1:RecordAudio("322192116", var_477_11)
						arg_474_1:RecordAudio("322192116", var_477_11)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_322192", "322192116", "story_v_out_322192.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_322192", "322192116", "story_v_out_322192.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_12 = math.max(var_477_5, arg_474_1.talkMaxDuration)

			if var_477_4 <= arg_474_1.time_ and arg_474_1.time_ < var_477_4 + var_477_12 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_4) / var_477_12

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_4 + var_477_12 and arg_474_1.time_ < var_477_4 + var_477_12 + arg_477_0 then
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
			local var_481_0 = 1

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_1 = arg_478_1:GetWordFromCfg(322192117)
				local var_481_2 = arg_478_1:FormatText(var_481_1.content)

				arg_478_1.text_.text = var_481_2

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_4 = 40 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_2) / 40)

				if (40 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_2) / 40)) > 0 and var_481_0 < var_481_4 then
					arg_478_1.talkMaxDuration = var_481_4

					if var_481_4 + 0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_4 + 0
					end
				end

				arg_478_1.text_.text = var_481_2
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192117", "story_v_out_322192.awb") ~= 0 then
					local var_481_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192117", "story_v_out_322192.awb") / 1000

					if var_481_5 + 0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_5 + 0
					end

					if var_481_1.prefab_name ~= "" and arg_478_1.actors_[var_481_1.prefab_name] ~= nil then
						local var_481_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_1.prefab_name].transform, "story_v_out_322192", "322192117", "story_v_out_322192.awb")

						arg_478_1:RecordAudio("322192117", var_481_6)
						arg_478_1:RecordAudio("322192117", var_481_6)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_322192", "322192117", "story_v_out_322192.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_322192", "322192117", "story_v_out_322192.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_7 = math.max(var_481_0, arg_478_1.talkMaxDuration)

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_7 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - 0) / var_481_7

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= 0 + var_481_7 and arg_478_1.time_ < 0 + var_481_7 + arg_481_0 then
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
			local var_485_0 = 0.275

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_1 = arg_482_1:GetWordFromCfg(322192118)
				local var_485_2 = arg_482_1:FormatText(var_485_1.content)

				arg_482_1.text_.text = var_485_2

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_4 = 11 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 11)

				if (11 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 11)) > 0 and var_485_0 < var_485_4 then
					arg_482_1.talkMaxDuration = var_485_4

					if var_485_4 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_4 + 0
					end
				end

				arg_482_1.text_.text = var_485_2
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192118", "story_v_out_322192.awb") ~= 0 then
					local var_485_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192118", "story_v_out_322192.awb") / 1000

					if var_485_5 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_5 + 0
					end

					if var_485_1.prefab_name ~= "" and arg_482_1.actors_[var_485_1.prefab_name] ~= nil then
						local var_485_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_1.prefab_name].transform, "story_v_out_322192", "322192118", "story_v_out_322192.awb")

						arg_482_1:RecordAudio("322192118", var_485_6)
						arg_482_1:RecordAudio("322192118", var_485_6)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_322192", "322192118", "story_v_out_322192.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_322192", "322192118", "story_v_out_322192.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_7 = math.max(var_485_0, arg_482_1.talkMaxDuration)

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_7 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - 0) / var_485_7

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= 0 + var_485_7 and arg_482_1.time_ < 0 + var_485_7 + arg_485_0 then
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
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.var_.moveOldPos1043ui_story = arg_486_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_489_0 = 0.001

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_0 then
				arg_486_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos1043ui_story, Vector3.New(-0.92, -1.01, -5.73), (arg_486_1.time_ - 0) / var_489_0)
				arg_486_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_486_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1043ui_story"].transform.position).z)
				arg_486_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_486_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_486_1.actors_["1043ui_story"].transform.localEulerAngles = arg_486_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_486_1.time_ >= 0 + var_489_0 and arg_486_1.time_ < 0 + var_489_0 + arg_489_0 then
				arg_486_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(-0.92, -1.01, -5.73)
				arg_486_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_486_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1043ui_story"].transform.position).z)
				arg_486_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_486_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_486_1.actors_["1043ui_story"].transform.localEulerAngles = arg_486_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_489_1 = "10131ui_story"

			if arg_486_1.actors_["10131ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10131ui_story"))) then
				local var_489_2 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_486_1.stage_.transform)

				var_489_2.name = var_489_1
				var_489_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_486_1.actors_[var_489_1] = var_489_2

				local var_489_3 = var_489_2:GetComponentInChildren(typeof(CharacterEffect))

				var_489_3.enabled = true

				local var_489_4 = GameObjectTools.GetOrAddComponent(var_489_2, typeof(DynamicBoneHelper))

				if var_489_4 then
					var_489_4:EnableDynamicBone(false)
				end

				arg_486_1:ShowWeapon(var_489_3.transform, false)

				arg_486_1.var_[var_489_1 .. "Animator"] = var_489_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_486_1.var_[var_489_1 .. "Animator"].applyRootMotion = true
				arg_486_1.var_[var_489_1 .. "LipSync"] = var_489_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_489_5 = arg_486_1.actors_["10131ui_story"].transform

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.var_.moveOldPos10131ui_story = var_489_5.localPosition
			end

			local var_489_6 = 0.001

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_6 then
				var_489_5.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_486_1.time_ - 0) / var_489_6)
				var_489_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_489_5.position).x, (manager.ui.mainCamera.transform.position - var_489_5.position).y, (manager.ui.mainCamera.transform.position - var_489_5.position).z)
				var_489_5.localEulerAngles.z = 0
				var_489_5.localEulerAngles.x = 0
				var_489_5.localEulerAngles = var_489_5.localEulerAngles
			end

			if arg_486_1.time_ >= 0 + var_489_6 and arg_486_1.time_ < 0 + var_489_6 + arg_489_0 then
				var_489_5.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_489_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_489_5.position).x, (manager.ui.mainCamera.transform.position - var_489_5.position).y, (manager.ui.mainCamera.transform.position - var_489_5.position).z)
				var_489_5.localEulerAngles.z = 0
				var_489_5.localEulerAngles.x = 0
				var_489_5.localEulerAngles = var_489_5.localEulerAngles
			end

			local var_489_7 = arg_486_1.actors_["10131ui_story"]

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(var_489_7) and arg_486_1.var_.characterEffect10131ui_story == nil then
				arg_486_1.var_.characterEffect10131ui_story = var_489_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_8 = 0.200000002980232

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_8 and not isNil(var_489_7) then
				if arg_486_1.var_.characterEffect10131ui_story and not isNil(var_489_7) then
					arg_486_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= 0 + var_489_8 and arg_486_1.time_ < 0 + var_489_8 + arg_489_0 and not isNil(var_489_7) and arg_486_1.var_.characterEffect10131ui_story then
				arg_486_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_489_10 = arg_486_1.actors_["1043ui_story"]

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(var_489_10) and arg_486_1.var_.characterEffect1043ui_story == nil then
				arg_486_1.var_.characterEffect1043ui_story = var_489_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_11 = 0.200000002980232

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_11 and not isNil(var_489_10) then
				if arg_486_1.var_.characterEffect1043ui_story and not isNil(var_489_10) then
					arg_486_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_486_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_486_1.time_ - 0) / var_489_11)
				end
			end

			if arg_486_1.time_ >= 0 + var_489_11 and arg_486_1.time_ < 0 + var_489_11 + arg_489_0 and not isNil(var_489_10) and arg_486_1.var_.characterEffect1043ui_story then
				arg_486_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_486_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_489_12 = 0
			local var_489_13 = 0.35

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_12 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_14 = arg_486_1:GetWordFromCfg(322192119)
				local var_489_15 = arg_486_1:FormatText(var_489_14.content)

				arg_486_1.text_.text = var_489_15

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_17 = 14 <= 0 and var_489_13 or var_489_13 * (utf8.len(var_489_15) / 14)

				if (14 <= 0 and var_489_13 or var_489_13 * (utf8.len(var_489_15) / 14)) > 0 and var_489_13 < var_489_17 then
					arg_486_1.talkMaxDuration = var_489_17

					if var_489_17 + var_489_12 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_17 + var_489_12
					end
				end

				arg_486_1.text_.text = var_489_15
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192119", "story_v_out_322192.awb") ~= 0 then
					local var_489_18 = manager.audio:GetVoiceLength("story_v_out_322192", "322192119", "story_v_out_322192.awb") / 1000

					if var_489_18 + var_489_12 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_18 + var_489_12
					end

					if var_489_14.prefab_name ~= "" and arg_486_1.actors_[var_489_14.prefab_name] ~= nil then
						local var_489_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_14.prefab_name].transform, "story_v_out_322192", "322192119", "story_v_out_322192.awb")

						arg_486_1:RecordAudio("322192119", var_489_19)
						arg_486_1:RecordAudio("322192119", var_489_19)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_322192", "322192119", "story_v_out_322192.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_322192", "322192119", "story_v_out_322192.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_20 = math.max(var_489_13, arg_486_1.talkMaxDuration)

			if var_489_12 <= arg_486_1.time_ and arg_486_1.time_ < var_489_12 + var_489_20 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_12) / var_489_20

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_12 + var_489_20 and arg_486_1.time_ < var_489_12 + var_489_20 + arg_489_0 then
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
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(arg_490_1.actors_["1111ui_story"]) and arg_490_1.var_.characterEffect1111ui_story == nil then
				arg_490_1.var_.characterEffect1111ui_story = arg_490_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_0 = 0.200000002980232

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_0 and not isNil(arg_490_1.actors_["1111ui_story"]) then
				if arg_490_1.var_.characterEffect1111ui_story and not isNil(arg_490_1.actors_["1111ui_story"]) then
					arg_490_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= 0 + var_493_0 and arg_490_1.time_ < 0 + var_493_0 + arg_493_0 and not isNil(arg_490_1.actors_["1111ui_story"]) and arg_490_1.var_.characterEffect1111ui_story then
				arg_490_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_493_2 = arg_490_1.actors_["10131ui_story"]

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(var_493_2) and arg_490_1.var_.characterEffect10131ui_story == nil then
				arg_490_1.var_.characterEffect10131ui_story = var_493_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_3 = 0.200000002980232

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_3 and not isNil(var_493_2) then
				if arg_490_1.var_.characterEffect10131ui_story and not isNil(var_493_2) then
					arg_490_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_490_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_490_1.time_ - 0) / var_493_3)
				end
			end

			if arg_490_1.time_ >= 0 + var_493_3 and arg_490_1.time_ < 0 + var_493_3 + arg_493_0 and not isNil(var_493_2) and arg_490_1.var_.characterEffect10131ui_story then
				arg_490_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_490_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_493_4 = 0
			local var_493_5 = 0.166666666666667

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_4 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0

				arg_490_1.dialog_:SetActive(true)

				arg_490_1.dialogCg_.alpha = 0

				local var_493_6 = LeanTween.value(arg_490_1.dialog_, 0, 1, 0.3)

				var_493_6:setOnUpdate(LuaHelper.FloatAction(function(arg_494_0)
					arg_490_1.dialogCg_.alpha = arg_494_0
				end))
				var_493_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_490_1.dialog_)
					var_493_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_490_1.duration_ = arg_490_1.duration_ + 0.3

				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[67].name)

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

				local var_493_7 = arg_490_1:GetWordFromCfg(322192120)
				local var_493_8 = arg_490_1:FormatText(var_493_7.content)

				arg_490_1.text_.text = var_493_8

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_10 = 2 <= 0 and var_493_5 or var_493_5 * (utf8.len(var_493_8) / 2)

				if (2 <= 0 and var_493_5 or var_493_5 * (utf8.len(var_493_8) / 2)) > 0 and var_493_5 < var_493_10 then
					arg_490_1.talkMaxDuration = var_493_10
					var_493_4 = var_493_4 + 0.3

					if var_493_10 + var_493_4 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_10 + var_493_4
					end
				end

				arg_490_1.text_.text = var_493_8
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192120", "story_v_out_322192.awb") ~= 0 then
					local var_493_11 = manager.audio:GetVoiceLength("story_v_out_322192", "322192120", "story_v_out_322192.awb") / 1000

					if var_493_11 + var_493_4 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_11 + var_493_4
					end

					if var_493_7.prefab_name ~= "" and arg_490_1.actors_[var_493_7.prefab_name] ~= nil then
						local var_493_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_7.prefab_name].transform, "story_v_out_322192", "322192120", "story_v_out_322192.awb")

						arg_490_1:RecordAudio("322192120", var_493_12)
						arg_490_1:RecordAudio("322192120", var_493_12)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_322192", "322192120", "story_v_out_322192.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_322192", "322192120", "story_v_out_322192.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_13 = var_493_4 + 0.3
			local var_493_14 = math.max(var_493_5, arg_490_1.talkMaxDuration)

			if var_493_4 + 0.3 <= arg_490_1.time_ and arg_490_1.time_ < var_493_13 + var_493_14 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_13) / var_493_14

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_13 + var_493_14 and arg_490_1.time_ < var_493_13 + var_493_14 + arg_493_0 then
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
			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.var_.moveOldPos1043ui_story = arg_496_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_499_0 = 0.001

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_0 then
				arg_496_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_496_1.time_ - 0) / var_499_0)
				arg_496_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_496_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["1043ui_story"].transform.position).z)
				arg_496_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_496_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_496_1.actors_["1043ui_story"].transform.localEulerAngles = arg_496_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_496_1.time_ >= 0 + var_499_0 and arg_496_1.time_ < 0 + var_499_0 + arg_499_0 then
				arg_496_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_496_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_496_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["1043ui_story"].transform.position).z)
				arg_496_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_496_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_496_1.actors_["1043ui_story"].transform.localEulerAngles = arg_496_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_499_1 = arg_496_1.actors_["10131ui_story"].transform

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.var_.moveOldPos10131ui_story = var_499_1.localPosition
			end

			local var_499_2 = 0.001

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_2 then
				var_499_1.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_496_1.time_ - 0) / var_499_2)
				var_499_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_499_1.position).x, (manager.ui.mainCamera.transform.position - var_499_1.position).y, (manager.ui.mainCamera.transform.position - var_499_1.position).z)
				var_499_1.localEulerAngles.z = 0
				var_499_1.localEulerAngles.x = 0
				var_499_1.localEulerAngles = var_499_1.localEulerAngles
			end

			if arg_496_1.time_ >= 0 + var_499_2 and arg_496_1.time_ < 0 + var_499_2 + arg_499_0 then
				var_499_1.localPosition = Vector3.New(0, 100, 0)
				var_499_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_499_1.position).x, (manager.ui.mainCamera.transform.position - var_499_1.position).y, (manager.ui.mainCamera.transform.position - var_499_1.position).z)
				var_499_1.localEulerAngles.z = 0
				var_499_1.localEulerAngles.x = 0
				var_499_1.localEulerAngles = var_499_1.localEulerAngles
			end

			local var_499_3 = 0
			local var_499_4 = 0.875

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_3 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, false)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_5 = arg_496_1:FormatText(arg_496_1:GetWordFromCfg(322192121).content)

				arg_496_1.text_.text = var_499_5

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_7 = 35 <= 0 and var_499_4 or var_499_4 * (utf8.len(var_499_5) / 35)

				if (35 <= 0 and var_499_4 or var_499_4 * (utf8.len(var_499_5) / 35)) > 0 and var_499_4 < var_499_7 then
					arg_496_1.talkMaxDuration = var_499_7

					if var_499_7 + var_499_3 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_7 + var_499_3
					end
				end

				arg_496_1.text_.text = var_499_5
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_8 = math.max(var_499_4, arg_496_1.talkMaxDuration)

			if var_499_3 <= arg_496_1.time_ and arg_496_1.time_ < var_499_3 + var_499_8 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_3) / var_499_8

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_3 + var_499_8 and arg_496_1.time_ < var_499_3 + var_499_8 + arg_499_0 then
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
			local var_503_0 = 0.7

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, false)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_1 = arg_500_1:FormatText(arg_500_1:GetWordFromCfg(322192122).content)

				arg_500_1.text_.text = var_503_1

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_3 = 28 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 28)

				if (28 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 28)) > 0 and var_503_0 < var_503_3 then
					arg_500_1.talkMaxDuration = var_503_3

					if var_503_3 + 0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_3 + 0
					end
				end

				arg_500_1.text_.text = var_503_1
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_4 = math.max(var_503_0, arg_500_1.talkMaxDuration)

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_4 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - 0) / var_503_4

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= 0 + var_503_4 and arg_500_1.time_ < 0 + var_503_4 + arg_503_0 then
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
			if 1 < arg_504_1.time_ and arg_504_1.time_ <= 1 + arg_507_0 then
				local var_507_0 = arg_504_1.bgs_.STblack

				arg_504_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_507_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_507_1 = var_507_0:GetComponent("SpriteRenderer")

				if var_507_1 and var_507_1.sprite then
					local var_507_2 = 2 * (var_507_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_507_0.transform.localScale = Vector3.New(var_507_2 / var_507_1.sprite.bounds.size.y < var_507_2 * manager.ui.mainCameraCom_.aspect / var_507_1.sprite.bounds.size.x and var_507_2 * manager.ui.mainCameraCom_.aspect / var_507_1.sprite.bounds.size.x or var_507_2 / var_507_1.sprite.bounds.size.y, var_507_2 / var_507_1.sprite.bounds.size.y < var_507_2 * manager.ui.mainCameraCom_.aspect / var_507_1.sprite.bounds.size.x and var_507_2 * manager.ui.mainCameraCom_.aspect / var_507_1.sprite.bounds.size.x or var_507_2 / var_507_1.sprite.bounds.size.y, 0)
				end

				for iter_507_0, iter_507_1 in pairs(arg_504_1.bgs_) do
					if iter_507_0 ~= "STblack" then
						iter_507_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_507_3 = 2

			if 2 < arg_504_1.time_ and arg_504_1.time_ <= var_507_3 + arg_507_0 then
				arg_504_1.allBtn_.enabled = false
			end

			if arg_504_1.time_ >= var_507_3 + 0.3 and arg_504_1.time_ < var_507_3 + 0.3 + arg_507_0 then
				arg_504_1.allBtn_.enabled = true
			end

			local var_507_4 = 0

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_4 + arg_507_0 then
				arg_504_1.mask_.enabled = true
				arg_504_1.mask_.raycastTarget = true

				arg_504_1:SetGaussion(false)
			end

			local var_507_5 = 1

			if var_507_4 <= arg_504_1.time_ and arg_504_1.time_ < var_507_4 + var_507_5 then
				local var_507_6 = Color.New(0, 0, 0)

				var_507_6.a = Mathf.Lerp(0, 1, (arg_504_1.time_ - var_507_4) / var_507_5)
				arg_504_1.mask_.color = var_507_6
			end

			if arg_504_1.time_ >= var_507_4 + var_507_5 and arg_504_1.time_ < var_507_4 + var_507_5 + arg_507_0 then
				local var_507_7 = Color.New(0, 0, 0)

				var_507_7.a = 1
				arg_504_1.mask_.color = var_507_7
			end

			local var_507_8 = 1

			if 1 < arg_504_1.time_ and arg_504_1.time_ <= var_507_8 + arg_507_0 then
				arg_504_1.mask_.enabled = true
				arg_504_1.mask_.raycastTarget = true

				arg_504_1:SetGaussion(false)
			end

			local var_507_9 = 1

			if var_507_8 <= arg_504_1.time_ and arg_504_1.time_ < var_507_8 + var_507_9 then
				local var_507_10 = Color.New(0, 0, 0)

				var_507_10.a = Mathf.Lerp(1, 0, (arg_504_1.time_ - var_507_8) / var_507_9)
				arg_504_1.mask_.color = var_507_10
			end

			if arg_504_1.time_ >= var_507_8 + var_507_9 and arg_504_1.time_ < var_507_8 + var_507_9 + arg_507_0 then
				local var_507_11 = Color.New(0, 0, 0)

				arg_504_1.mask_.enabled = false
				var_507_11.a = 0
				arg_504_1.mask_.color = var_507_11
			end

			local var_507_12 = 1
			local var_507_13 = manager.audio:GetVoiceLength("story_v_out_321122", "321122038", "story_v_out_321122.awb") / 1000

			if var_507_13 > 0 and 3.3 < var_507_13 and var_507_13 + var_507_12 > arg_504_1.duration_ then
				arg_504_1.duration_ = var_507_13 + var_507_12
			end

			if var_507_12 < arg_504_1.time_ and arg_504_1.time_ <= var_507_12 + arg_507_0 then
				arg_504_1:AudioAction("play", "voice", "story_v_out_321122", "321122038", "story_v_out_321122.awb")
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
			if 1 < arg_508_1.time_ and arg_508_1.time_ <= 1 + arg_511_0 then
				local var_511_0 = arg_508_1.bgs_.L09f

				arg_508_1.bgs_.L09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_511_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_511_1 = var_511_0:GetComponent("SpriteRenderer")

				if var_511_1 and var_511_1.sprite then
					local var_511_2 = 2 * (var_511_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_511_0.transform.localScale = Vector3.New(var_511_2 / var_511_1.sprite.bounds.size.y < var_511_2 * manager.ui.mainCameraCom_.aspect / var_511_1.sprite.bounds.size.x and var_511_2 * manager.ui.mainCameraCom_.aspect / var_511_1.sprite.bounds.size.x or var_511_2 / var_511_1.sprite.bounds.size.y, var_511_2 / var_511_1.sprite.bounds.size.y < var_511_2 * manager.ui.mainCameraCom_.aspect / var_511_1.sprite.bounds.size.x and var_511_2 * manager.ui.mainCameraCom_.aspect / var_511_1.sprite.bounds.size.x or var_511_2 / var_511_1.sprite.bounds.size.y, 0)
				end

				for iter_511_0, iter_511_1 in pairs(arg_508_1.bgs_) do
					if iter_511_0 ~= "L09f" then
						iter_511_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_511_3 = 2

			if 2 < arg_508_1.time_ and arg_508_1.time_ <= var_511_3 + arg_511_0 then
				arg_508_1.allBtn_.enabled = false
			end

			if arg_508_1.time_ >= var_511_3 + 0.3 and arg_508_1.time_ < var_511_3 + 0.3 + arg_511_0 then
				arg_508_1.allBtn_.enabled = true
			end

			local var_511_4 = 0

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_4 + arg_511_0 then
				arg_508_1.mask_.enabled = true
				arg_508_1.mask_.raycastTarget = true

				arg_508_1:SetGaussion(false)
			end

			local var_511_5 = 1

			if var_511_4 <= arg_508_1.time_ and arg_508_1.time_ < var_511_4 + var_511_5 then
				local var_511_6 = Color.New(0, 0, 0)

				var_511_6.a = Mathf.Lerp(0, 1, (arg_508_1.time_ - var_511_4) / var_511_5)
				arg_508_1.mask_.color = var_511_6
			end

			if arg_508_1.time_ >= var_511_4 + var_511_5 and arg_508_1.time_ < var_511_4 + var_511_5 + arg_511_0 then
				local var_511_7 = Color.New(0, 0, 0)

				var_511_7.a = 1
				arg_508_1.mask_.color = var_511_7
			end

			local var_511_8 = 1

			if 1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_8 + arg_511_0 then
				arg_508_1.mask_.enabled = true
				arg_508_1.mask_.raycastTarget = true

				arg_508_1:SetGaussion(false)
			end

			local var_511_9 = 1

			if var_511_8 <= arg_508_1.time_ and arg_508_1.time_ < var_511_8 + var_511_9 then
				local var_511_10 = Color.New(0, 0, 0)

				var_511_10.a = Mathf.Lerp(1, 0, (arg_508_1.time_ - var_511_8) / var_511_9)
				arg_508_1.mask_.color = var_511_10
			end

			if arg_508_1.time_ >= var_511_8 + var_511_9 and arg_508_1.time_ < var_511_8 + var_511_9 + arg_511_0 then
				local var_511_11 = Color.New(0, 0, 0)

				arg_508_1.mask_.enabled = false
				var_511_11.a = 0
				arg_508_1.mask_.color = var_511_11
			end

			local var_511_12 = arg_508_1.actors_["10131ui_story"].transform

			if 2 < arg_508_1.time_ and arg_508_1.time_ <= 2 + arg_511_0 then
				arg_508_1.var_.moveOldPos10131ui_story = var_511_12.localPosition
			end

			local var_511_13 = 0.001

			if 2 <= arg_508_1.time_ and arg_508_1.time_ < 2 + var_511_13 then
				var_511_12.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos10131ui_story, Vector3.New(0.05, -0.96, -5.8), (arg_508_1.time_ - 2) / var_511_13)
				var_511_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_511_12.position).x, (manager.ui.mainCamera.transform.position - var_511_12.position).y, (manager.ui.mainCamera.transform.position - var_511_12.position).z)
				var_511_12.localEulerAngles.z = 0
				var_511_12.localEulerAngles.x = 0
				var_511_12.localEulerAngles = var_511_12.localEulerAngles
			end

			if arg_508_1.time_ >= 2 + var_511_13 and arg_508_1.time_ < 2 + var_511_13 + arg_511_0 then
				var_511_12.localPosition = Vector3.New(0.05, -0.96, -5.8)
				var_511_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_511_12.position).x, (manager.ui.mainCamera.transform.position - var_511_12.position).y, (manager.ui.mainCamera.transform.position - var_511_12.position).z)
				var_511_12.localEulerAngles.z = 0
				var_511_12.localEulerAngles.x = 0
				var_511_12.localEulerAngles = var_511_12.localEulerAngles
			end

			local var_511_14 = arg_508_1.actors_["10131ui_story"]

			if 2 < arg_508_1.time_ and arg_508_1.time_ <= 2 + arg_511_0 and not isNil(var_511_14) and arg_508_1.var_.characterEffect10131ui_story == nil then
				arg_508_1.var_.characterEffect10131ui_story = var_511_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_15 = 0.200000002980232

			if 2 <= arg_508_1.time_ and arg_508_1.time_ < 2 + var_511_15 and not isNil(var_511_14) then
				if arg_508_1.var_.characterEffect10131ui_story and not isNil(var_511_14) then
					arg_508_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_508_1.time_ >= 2 + var_511_15 and arg_508_1.time_ < 2 + var_511_15 + arg_511_0 and not isNil(var_511_14) and arg_508_1.var_.characterEffect10131ui_story then
				arg_508_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			if 2 < arg_508_1.time_ and arg_508_1.time_ <= 2 + arg_511_0 then
				arg_508_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 2 < arg_508_1.time_ and arg_508_1.time_ <= 2 + arg_511_0 then
				arg_508_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if arg_508_1.frameCnt_ <= 1 then
				arg_508_1.dialog_:SetActive(false)
			end

			local var_511_17 = 2
			local var_511_18 = 1.05

			if 2 < arg_508_1.time_ and arg_508_1.time_ <= var_511_17 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0

				arg_508_1.dialog_:SetActive(true)

				arg_508_1.dialogCg_.alpha = 0

				local var_511_19 = LeanTween.value(arg_508_1.dialog_, 0, 1, 0.3)

				var_511_19:setOnUpdate(LuaHelper.FloatAction(function(arg_512_0)
					arg_508_1.dialogCg_.alpha = arg_512_0
				end))
				var_511_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_508_1.dialog_)
					var_511_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_508_1.duration_ = arg_508_1.duration_ + 0.3

				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_20 = arg_508_1:GetWordFromCfg(322192124)
				local var_511_21 = arg_508_1:FormatText(var_511_20.content)

				arg_508_1.text_.text = var_511_21

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_23 = 42 <= 0 and var_511_18 or var_511_18 * (utf8.len(var_511_21) / 42)

				if (42 <= 0 and var_511_18 or var_511_18 * (utf8.len(var_511_21) / 42)) > 0 and var_511_18 < var_511_23 then
					arg_508_1.talkMaxDuration = var_511_23
					var_511_17 = var_511_17 + 0.3

					if var_511_23 + var_511_17 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_23 + var_511_17
					end
				end

				arg_508_1.text_.text = var_511_21
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192124", "story_v_out_322192.awb") ~= 0 then
					local var_511_24 = manager.audio:GetVoiceLength("story_v_out_322192", "322192124", "story_v_out_322192.awb") / 1000

					if var_511_24 + var_511_17 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_24 + var_511_17
					end

					if var_511_20.prefab_name ~= "" and arg_508_1.actors_[var_511_20.prefab_name] ~= nil then
						local var_511_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_20.prefab_name].transform, "story_v_out_322192", "322192124", "story_v_out_322192.awb")

						arg_508_1:RecordAudio("322192124", var_511_25)
						arg_508_1:RecordAudio("322192124", var_511_25)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_322192", "322192124", "story_v_out_322192.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_322192", "322192124", "story_v_out_322192.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_26 = var_511_17 + 0.3
			local var_511_27 = math.max(var_511_18, arg_508_1.talkMaxDuration)

			if var_511_17 + 0.3 <= arg_508_1.time_ and arg_508_1.time_ < var_511_26 + var_511_27 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_26) / var_511_27

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_26 + var_511_27 and arg_508_1.time_ < var_511_26 + var_511_27 + arg_511_0 then
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
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.var_.moveOldPos10131ui_story = arg_514_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_517_0 = 0.001

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_0 then
				arg_514_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos10131ui_story, Vector3.New(-0.78, -0.96, -5.8), (arg_514_1.time_ - 0) / var_517_0)
				arg_514_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_514_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["10131ui_story"].transform.position).z)
				arg_514_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_514_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_514_1.actors_["10131ui_story"].transform.localEulerAngles = arg_514_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_514_1.time_ >= 0 + var_517_0 and arg_514_1.time_ < 0 + var_517_0 + arg_517_0 then
				arg_514_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(-0.78, -0.96, -5.8)
				arg_514_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_514_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["10131ui_story"].transform.position).z)
				arg_514_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_514_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_514_1.actors_["10131ui_story"].transform.localEulerAngles = arg_514_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_517_1 = arg_514_1.actors_["1111ui_story"].transform

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.var_.moveOldPos1111ui_story = var_517_1.localPosition
			end

			local var_517_2 = 0.001

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_2 then
				var_517_1.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_514_1.time_ - 0) / var_517_2)
				var_517_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_1.position).x, (manager.ui.mainCamera.transform.position - var_517_1.position).y, (manager.ui.mainCamera.transform.position - var_517_1.position).z)
				var_517_1.localEulerAngles.z = 0
				var_517_1.localEulerAngles.x = 0
				var_517_1.localEulerAngles = var_517_1.localEulerAngles
			end

			if arg_514_1.time_ >= 0 + var_517_2 and arg_514_1.time_ < 0 + var_517_2 + arg_517_0 then
				var_517_1.localPosition = Vector3.New(0.7, -0.87, -5.7)
				var_517_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_1.position).x, (manager.ui.mainCamera.transform.position - var_517_1.position).y, (manager.ui.mainCamera.transform.position - var_517_1.position).z)
				var_517_1.localEulerAngles.z = 0
				var_517_1.localEulerAngles.x = 0
				var_517_1.localEulerAngles = var_517_1.localEulerAngles
			end

			local var_517_3 = arg_514_1.actors_["1111ui_story"]

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(var_517_3) and arg_514_1.var_.characterEffect1111ui_story == nil then
				arg_514_1.var_.characterEffect1111ui_story = var_517_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_4 = 0.200000002980232

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_4 and not isNil(var_517_3) then
				if arg_514_1.var_.characterEffect1111ui_story and not isNil(var_517_3) then
					arg_514_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= 0 + var_517_4 and arg_514_1.time_ < 0 + var_517_4 + arg_517_0 and not isNil(var_517_3) and arg_514_1.var_.characterEffect1111ui_story then
				arg_514_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_517_6 = arg_514_1.actors_["10131ui_story"]

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(var_517_6) and arg_514_1.var_.characterEffect10131ui_story == nil then
				arg_514_1.var_.characterEffect10131ui_story = var_517_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_7 = 0.200000002980232

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_7 and not isNil(var_517_6) then
				if arg_514_1.var_.characterEffect10131ui_story and not isNil(var_517_6) then
					arg_514_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_514_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_514_1.time_ - 0) / var_517_7)
				end
			end

			if arg_514_1.time_ >= 0 + var_517_7 and arg_514_1.time_ < 0 + var_517_7 + arg_517_0 and not isNil(var_517_6) and arg_514_1.var_.characterEffect10131ui_story then
				arg_514_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_514_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_517_8 = 0
			local var_517_9 = 0.275

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_8 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_10 = arg_514_1:GetWordFromCfg(322192125)
				local var_517_11 = arg_514_1:FormatText(var_517_10.content)

				arg_514_1.text_.text = var_517_11

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_13 = 11 <= 0 and var_517_9 or var_517_9 * (utf8.len(var_517_11) / 11)

				if (11 <= 0 and var_517_9 or var_517_9 * (utf8.len(var_517_11) / 11)) > 0 and var_517_9 < var_517_13 then
					arg_514_1.talkMaxDuration = var_517_13

					if var_517_13 + var_517_8 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_13 + var_517_8
					end
				end

				arg_514_1.text_.text = var_517_11
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192125", "story_v_out_322192.awb") ~= 0 then
					local var_517_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192125", "story_v_out_322192.awb") / 1000

					if var_517_14 + var_517_8 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_14 + var_517_8
					end

					if var_517_10.prefab_name ~= "" and arg_514_1.actors_[var_517_10.prefab_name] ~= nil then
						local var_517_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_10.prefab_name].transform, "story_v_out_322192", "322192125", "story_v_out_322192.awb")

						arg_514_1:RecordAudio("322192125", var_517_15)
						arg_514_1:RecordAudio("322192125", var_517_15)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_322192", "322192125", "story_v_out_322192.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_322192", "322192125", "story_v_out_322192.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_16 = math.max(var_517_9, arg_514_1.talkMaxDuration)

			if var_517_8 <= arg_514_1.time_ and arg_514_1.time_ < var_517_8 + var_517_16 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_8) / var_517_16

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_8 + var_517_16 and arg_514_1.time_ < var_517_8 + var_517_16 + arg_517_0 then
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
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(arg_518_1.actors_["10131ui_story"]) and arg_518_1.var_.characterEffect10131ui_story == nil then
				arg_518_1.var_.characterEffect10131ui_story = arg_518_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_0 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 and not isNil(arg_518_1.actors_["10131ui_story"]) then
				if arg_518_1.var_.characterEffect10131ui_story and not isNil(arg_518_1.actors_["10131ui_story"]) then
					arg_518_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 and not isNil(arg_518_1.actors_["10131ui_story"]) and arg_518_1.var_.characterEffect10131ui_story then
				arg_518_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_521_2 = arg_518_1.actors_["1111ui_story"]

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(var_521_2) and arg_518_1.var_.characterEffect1111ui_story == nil then
				arg_518_1.var_.characterEffect1111ui_story = var_521_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_3 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_3 and not isNil(var_521_2) then
				if arg_518_1.var_.characterEffect1111ui_story and not isNil(var_521_2) then
					arg_518_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_518_1.time_ - 0) / var_521_3)
				end
			end

			if arg_518_1.time_ >= 0 + var_521_3 and arg_518_1.time_ < 0 + var_521_3 + arg_521_0 and not isNil(var_521_2) and arg_518_1.var_.characterEffect1111ui_story then
				arg_518_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_521_4 = 0
			local var_521_5 = 0.925

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_4 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_6 = arg_518_1:GetWordFromCfg(322192126)
				local var_521_7 = arg_518_1:FormatText(var_521_6.content)

				arg_518_1.text_.text = var_521_7

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_9 = 37 <= 0 and var_521_5 or var_521_5 * (utf8.len(var_521_7) / 37)

				if (37 <= 0 and var_521_5 or var_521_5 * (utf8.len(var_521_7) / 37)) > 0 and var_521_5 < var_521_9 then
					arg_518_1.talkMaxDuration = var_521_9

					if var_521_9 + var_521_4 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_9 + var_521_4
					end
				end

				arg_518_1.text_.text = var_521_7
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192126", "story_v_out_322192.awb") ~= 0 then
					local var_521_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192126", "story_v_out_322192.awb") / 1000

					if var_521_10 + var_521_4 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_10 + var_521_4
					end

					if var_521_6.prefab_name ~= "" and arg_518_1.actors_[var_521_6.prefab_name] ~= nil then
						local var_521_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_6.prefab_name].transform, "story_v_out_322192", "322192126", "story_v_out_322192.awb")

						arg_518_1:RecordAudio("322192126", var_521_11)
						arg_518_1:RecordAudio("322192126", var_521_11)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_322192", "322192126", "story_v_out_322192.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_322192", "322192126", "story_v_out_322192.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_12 = math.max(var_521_5, arg_518_1.talkMaxDuration)

			if var_521_4 <= arg_518_1.time_ and arg_518_1.time_ < var_521_4 + var_521_12 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_4) / var_521_12

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_4 + var_521_12 and arg_518_1.time_ < var_521_4 + var_521_12 + arg_521_0 then
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
			local var_525_0 = 0.675

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_1 = arg_522_1:GetWordFromCfg(322192127)
				local var_525_2 = arg_522_1:FormatText(var_525_1.content)

				arg_522_1.text_.text = var_525_2

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_4 = 27 <= 0 and var_525_0 or var_525_0 * (utf8.len(var_525_2) / 27)

				if (27 <= 0 and var_525_0 or var_525_0 * (utf8.len(var_525_2) / 27)) > 0 and var_525_0 < var_525_4 then
					arg_522_1.talkMaxDuration = var_525_4

					if var_525_4 + 0 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_4 + 0
					end
				end

				arg_522_1.text_.text = var_525_2
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192127", "story_v_out_322192.awb") ~= 0 then
					local var_525_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192127", "story_v_out_322192.awb") / 1000

					if var_525_5 + 0 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_5 + 0
					end

					if var_525_1.prefab_name ~= "" and arg_522_1.actors_[var_525_1.prefab_name] ~= nil then
						local var_525_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_1.prefab_name].transform, "story_v_out_322192", "322192127", "story_v_out_322192.awb")

						arg_522_1:RecordAudio("322192127", var_525_6)
						arg_522_1:RecordAudio("322192127", var_525_6)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_322192", "322192127", "story_v_out_322192.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_322192", "322192127", "story_v_out_322192.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_7 = math.max(var_525_0, arg_522_1.talkMaxDuration)

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_7 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - 0) / var_525_7

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= 0 + var_525_7 and arg_522_1.time_ < 0 + var_525_7 + arg_525_0 then
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
			local var_529_0 = 0.775

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				arg_526_1.leftNameTxt_.text = arg_526_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_1 = arg_526_1:GetWordFromCfg(322192128)
				local var_529_2 = arg_526_1:FormatText(var_529_1.content)

				arg_526_1.text_.text = var_529_2

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_4 = 32 <= 0 and var_529_0 or var_529_0 * (utf8.len(var_529_2) / 32)

				if (32 <= 0 and var_529_0 or var_529_0 * (utf8.len(var_529_2) / 32)) > 0 and var_529_0 < var_529_4 then
					arg_526_1.talkMaxDuration = var_529_4

					if var_529_4 + 0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_4 + 0
					end
				end

				arg_526_1.text_.text = var_529_2
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192128", "story_v_out_322192.awb") ~= 0 then
					local var_529_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192128", "story_v_out_322192.awb") / 1000

					if var_529_5 + 0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_5 + 0
					end

					if var_529_1.prefab_name ~= "" and arg_526_1.actors_[var_529_1.prefab_name] ~= nil then
						local var_529_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_1.prefab_name].transform, "story_v_out_322192", "322192128", "story_v_out_322192.awb")

						arg_526_1:RecordAudio("322192128", var_529_6)
						arg_526_1:RecordAudio("322192128", var_529_6)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_out_322192", "322192128", "story_v_out_322192.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_out_322192", "322192128", "story_v_out_322192.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_7 = math.max(var_529_0, arg_526_1.talkMaxDuration)

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_7 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - 0) / var_529_7

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= 0 + var_529_7 and arg_526_1.time_ < 0 + var_529_7 + arg_529_0 then
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
			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 and not isNil(arg_530_1.actors_["1111ui_story"]) and arg_530_1.var_.characterEffect1111ui_story == nil then
				arg_530_1.var_.characterEffect1111ui_story = arg_530_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_0 = 0.200000002980232

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_0 and not isNil(arg_530_1.actors_["1111ui_story"]) then
				if arg_530_1.var_.characterEffect1111ui_story and not isNil(arg_530_1.actors_["1111ui_story"]) then
					arg_530_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_530_1.time_ >= 0 + var_533_0 and arg_530_1.time_ < 0 + var_533_0 + arg_533_0 and not isNil(arg_530_1.actors_["1111ui_story"]) and arg_530_1.var_.characterEffect1111ui_story then
				arg_530_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_533_2 = arg_530_1.actors_["10131ui_story"]

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 and not isNil(var_533_2) and arg_530_1.var_.characterEffect10131ui_story == nil then
				arg_530_1.var_.characterEffect10131ui_story = var_533_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_3 = 0.200000002980232

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_3 and not isNil(var_533_2) then
				if arg_530_1.var_.characterEffect10131ui_story and not isNil(var_533_2) then
					arg_530_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_530_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_530_1.time_ - 0) / var_533_3)
				end
			end

			if arg_530_1.time_ >= 0 + var_533_3 and arg_530_1.time_ < 0 + var_533_3 + arg_533_0 and not isNil(var_533_2) and arg_530_1.var_.characterEffect10131ui_story then
				arg_530_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_530_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_533_4 = 0
			local var_533_5 = 0.175

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_4 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_6 = arg_530_1:GetWordFromCfg(322192129)
				local var_533_7 = arg_530_1:FormatText(var_533_6.content)

				arg_530_1.text_.text = var_533_7

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_9 = 7 <= 0 and var_533_5 or var_533_5 * (utf8.len(var_533_7) / 7)

				if (7 <= 0 and var_533_5 or var_533_5 * (utf8.len(var_533_7) / 7)) > 0 and var_533_5 < var_533_9 then
					arg_530_1.talkMaxDuration = var_533_9

					if var_533_9 + var_533_4 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_9 + var_533_4
					end
				end

				arg_530_1.text_.text = var_533_7
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192129", "story_v_out_322192.awb") ~= 0 then
					local var_533_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192129", "story_v_out_322192.awb") / 1000

					if var_533_10 + var_533_4 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_10 + var_533_4
					end

					if var_533_6.prefab_name ~= "" and arg_530_1.actors_[var_533_6.prefab_name] ~= nil then
						local var_533_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_6.prefab_name].transform, "story_v_out_322192", "322192129", "story_v_out_322192.awb")

						arg_530_1:RecordAudio("322192129", var_533_11)
						arg_530_1:RecordAudio("322192129", var_533_11)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_322192", "322192129", "story_v_out_322192.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_322192", "322192129", "story_v_out_322192.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_12 = math.max(var_533_5, arg_530_1.talkMaxDuration)

			if var_533_4 <= arg_530_1.time_ and arg_530_1.time_ < var_533_4 + var_533_12 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_4) / var_533_12

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_4 + var_533_12 and arg_530_1.time_ < var_533_4 + var_533_12 + arg_533_0 then
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
			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 and not isNil(arg_534_1.actors_["10131ui_story"]) and arg_534_1.var_.characterEffect10131ui_story == nil then
				arg_534_1.var_.characterEffect10131ui_story = arg_534_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_0 = 0.200000002980232

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_0 and not isNil(arg_534_1.actors_["10131ui_story"]) then
				if arg_534_1.var_.characterEffect10131ui_story and not isNil(arg_534_1.actors_["10131ui_story"]) then
					arg_534_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_534_1.time_ >= 0 + var_537_0 and arg_534_1.time_ < 0 + var_537_0 + arg_537_0 and not isNil(arg_534_1.actors_["10131ui_story"]) and arg_534_1.var_.characterEffect10131ui_story then
				arg_534_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_537_2 = arg_534_1.actors_["1111ui_story"]

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 and not isNil(var_537_2) and arg_534_1.var_.characterEffect1111ui_story == nil then
				arg_534_1.var_.characterEffect1111ui_story = var_537_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_3 = 0.200000002980232

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_3 and not isNil(var_537_2) then
				if arg_534_1.var_.characterEffect1111ui_story and not isNil(var_537_2) then
					arg_534_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_534_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_534_1.time_ - 0) / var_537_3)
				end
			end

			if arg_534_1.time_ >= 0 + var_537_3 and arg_534_1.time_ < 0 + var_537_3 + arg_537_0 and not isNil(var_537_2) and arg_534_1.var_.characterEffect1111ui_story then
				arg_534_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_534_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_537_4 = 0
			local var_537_5 = 1.125

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_4 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				arg_534_1.leftNameTxt_.text = arg_534_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_6 = arg_534_1:GetWordFromCfg(322192130)
				local var_537_7 = arg_534_1:FormatText(var_537_6.content)

				arg_534_1.text_.text = var_537_7

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_9 = 45 <= 0 and var_537_5 or var_537_5 * (utf8.len(var_537_7) / 45)

				if (45 <= 0 and var_537_5 or var_537_5 * (utf8.len(var_537_7) / 45)) > 0 and var_537_5 < var_537_9 then
					arg_534_1.talkMaxDuration = var_537_9

					if var_537_9 + var_537_4 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_9 + var_537_4
					end
				end

				arg_534_1.text_.text = var_537_7
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192130", "story_v_out_322192.awb") ~= 0 then
					local var_537_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192130", "story_v_out_322192.awb") / 1000

					if var_537_10 + var_537_4 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_10 + var_537_4
					end

					if var_537_6.prefab_name ~= "" and arg_534_1.actors_[var_537_6.prefab_name] ~= nil then
						local var_537_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_6.prefab_name].transform, "story_v_out_322192", "322192130", "story_v_out_322192.awb")

						arg_534_1:RecordAudio("322192130", var_537_11)
						arg_534_1:RecordAudio("322192130", var_537_11)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_out_322192", "322192130", "story_v_out_322192.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_out_322192", "322192130", "story_v_out_322192.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_12 = math.max(var_537_5, arg_534_1.talkMaxDuration)

			if var_537_4 <= arg_534_1.time_ and arg_534_1.time_ < var_537_4 + var_537_12 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_4) / var_537_12

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_4 + var_537_12 and arg_534_1.time_ < var_537_4 + var_537_12 + arg_537_0 then
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
			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 and not isNil(arg_538_1.actors_["1043ui_story"]) and arg_538_1.var_.characterEffect1043ui_story == nil then
				arg_538_1.var_.characterEffect1043ui_story = arg_538_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_0 = 0.200000002980232

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_0 and not isNil(arg_538_1.actors_["1043ui_story"]) then
				if arg_538_1.var_.characterEffect1043ui_story and not isNil(arg_538_1.actors_["1043ui_story"]) then
					arg_538_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_538_1.time_ >= 0 + var_541_0 and arg_538_1.time_ < 0 + var_541_0 + arg_541_0 and not isNil(arg_538_1.actors_["1043ui_story"]) and arg_538_1.var_.characterEffect1043ui_story then
				arg_538_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_541_2 = arg_538_1.actors_["10131ui_story"]

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 and not isNil(var_541_2) and arg_538_1.var_.characterEffect10131ui_story == nil then
				arg_538_1.var_.characterEffect10131ui_story = var_541_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_3 = 0.200000002980232

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_3 and not isNil(var_541_2) then
				if arg_538_1.var_.characterEffect10131ui_story and not isNil(var_541_2) then
					arg_538_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_538_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_538_1.time_ - 0) / var_541_3)
				end
			end

			if arg_538_1.time_ >= 0 + var_541_3 and arg_538_1.time_ < 0 + var_541_3 + arg_541_0 and not isNil(var_541_2) and arg_538_1.var_.characterEffect10131ui_story then
				arg_538_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_538_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_541_4 = 0
			local var_541_5 = 0.925

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_4 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				arg_538_1.leftNameTxt_.text = arg_538_1:FormatText(StoryNameCfg[1156].name)

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

				local var_541_6 = arg_538_1:GetWordFromCfg(322192131)
				local var_541_7 = arg_538_1:FormatText(var_541_6.content)

				arg_538_1.text_.text = var_541_7

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_9 = 37 <= 0 and var_541_5 or var_541_5 * (utf8.len(var_541_7) / 37)

				if (37 <= 0 and var_541_5 or var_541_5 * (utf8.len(var_541_7) / 37)) > 0 and var_541_5 < var_541_9 then
					arg_538_1.talkMaxDuration = var_541_9

					if var_541_9 + var_541_4 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_9 + var_541_4
					end
				end

				arg_538_1.text_.text = var_541_7
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192131", "story_v_out_322192.awb") ~= 0 then
					local var_541_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192131", "story_v_out_322192.awb") / 1000

					if var_541_10 + var_541_4 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_10 + var_541_4
					end

					if var_541_6.prefab_name ~= "" and arg_538_1.actors_[var_541_6.prefab_name] ~= nil then
						local var_541_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_6.prefab_name].transform, "story_v_out_322192", "322192131", "story_v_out_322192.awb")

						arg_538_1:RecordAudio("322192131", var_541_11)
						arg_538_1:RecordAudio("322192131", var_541_11)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_out_322192", "322192131", "story_v_out_322192.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_out_322192", "322192131", "story_v_out_322192.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_12 = math.max(var_541_5, arg_538_1.talkMaxDuration)

			if var_541_4 <= arg_538_1.time_ and arg_538_1.time_ < var_541_4 + var_541_12 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_4) / var_541_12

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_4 + var_541_12 and arg_538_1.time_ < var_541_4 + var_541_12 + arg_541_0 then
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
			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1.var_.moveOldPos1111ui_story = arg_542_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_545_0 = 0.001

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_0 then
				arg_542_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_542_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_542_1.time_ - 0) / var_545_0)
				arg_542_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_542_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1111ui_story"].transform.position).z)
				arg_542_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_542_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_542_1.actors_["1111ui_story"].transform.localEulerAngles = arg_542_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_542_1.time_ >= 0 + var_545_0 and arg_542_1.time_ < 0 + var_545_0 + arg_545_0 then
				arg_542_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_542_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_542_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_542_1.actors_["1111ui_story"].transform.position).z)
				arg_542_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_542_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_542_1.actors_["1111ui_story"].transform.localEulerAngles = arg_542_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_545_1 = arg_542_1.actors_["1111ui_story"]

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 and not isNil(var_545_1) and arg_542_1.var_.characterEffect1111ui_story == nil then
				arg_542_1.var_.characterEffect1111ui_story = var_545_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_2 = 0.200000002980232

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_2 and not isNil(var_545_1) then
				if arg_542_1.var_.characterEffect1111ui_story and not isNil(var_545_1) then
					arg_542_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_542_1.time_ >= 0 + var_545_2 and arg_542_1.time_ < 0 + var_545_2 + arg_545_0 and not isNil(var_545_1) and arg_542_1.var_.characterEffect1111ui_story then
				arg_542_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_545_4 = arg_542_1.actors_["1043ui_story"]

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 and not isNil(var_545_4) and arg_542_1.var_.characterEffect1043ui_story == nil then
				arg_542_1.var_.characterEffect1043ui_story = var_545_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_5 = 0.200000002980232

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_5 and not isNil(var_545_4) then
				if arg_542_1.var_.characterEffect1043ui_story and not isNil(var_545_4) then
					arg_542_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_542_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_542_1.time_ - 0) / var_545_5)
				end
			end

			if arg_542_1.time_ >= 0 + var_545_5 and arg_542_1.time_ < 0 + var_545_5 + arg_545_0 and not isNil(var_545_4) and arg_542_1.var_.characterEffect1043ui_story then
				arg_542_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_542_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			local var_545_6 = 0
			local var_545_7 = 0.475

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_6 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				arg_542_1.leftNameTxt_.text = arg_542_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_8 = arg_542_1:GetWordFromCfg(322192132)
				local var_545_9 = arg_542_1:FormatText(var_545_8.content)

				arg_542_1.text_.text = var_545_9

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_11 = 19 <= 0 and var_545_7 or var_545_7 * (utf8.len(var_545_9) / 19)

				if (19 <= 0 and var_545_7 or var_545_7 * (utf8.len(var_545_9) / 19)) > 0 and var_545_7 < var_545_11 then
					arg_542_1.talkMaxDuration = var_545_11

					if var_545_11 + var_545_6 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_11 + var_545_6
					end
				end

				arg_542_1.text_.text = var_545_9
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192132", "story_v_out_322192.awb") ~= 0 then
					local var_545_12 = manager.audio:GetVoiceLength("story_v_out_322192", "322192132", "story_v_out_322192.awb") / 1000

					if var_545_12 + var_545_6 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_12 + var_545_6
					end

					if var_545_8.prefab_name ~= "" and arg_542_1.actors_[var_545_8.prefab_name] ~= nil then
						local var_545_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_542_1.actors_[var_545_8.prefab_name].transform, "story_v_out_322192", "322192132", "story_v_out_322192.awb")

						arg_542_1:RecordAudio("322192132", var_545_13)
						arg_542_1:RecordAudio("322192132", var_545_13)
					else
						arg_542_1:AudioAction("play", "voice", "story_v_out_322192", "322192132", "story_v_out_322192.awb")
					end

					arg_542_1:RecordHistoryTalkVoice("story_v_out_322192", "322192132", "story_v_out_322192.awb")
				end

				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_14 = math.max(var_545_7, arg_542_1.talkMaxDuration)

			if var_545_6 <= arg_542_1.time_ and arg_542_1.time_ < var_545_6 + var_545_14 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_6) / var_545_14

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_6 + var_545_14 and arg_542_1.time_ < var_545_6 + var_545_14 + arg_545_0 then
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
			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.var_.moveOldPos1111ui_story = arg_546_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_549_0 = 0.001

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_0 then
				arg_546_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_546_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_546_1.time_ - 0) / var_549_0)
				arg_546_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_546_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["1111ui_story"].transform.position).z)
				arg_546_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_546_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_546_1.actors_["1111ui_story"].transform.localEulerAngles = arg_546_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_546_1.time_ >= 0 + var_549_0 and arg_546_1.time_ < 0 + var_549_0 + arg_549_0 then
				arg_546_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_546_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_546_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["1111ui_story"].transform.position).z)
				arg_546_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_546_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_546_1.actors_["1111ui_story"].transform.localEulerAngles = arg_546_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_549_1 = arg_546_1.actors_["10131ui_story"].transform

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.var_.moveOldPos10131ui_story = var_549_1.localPosition
			end

			local var_549_2 = 0.001

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_2 then
				var_549_1.localPosition = Vector3.Lerp(arg_546_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_546_1.time_ - 0) / var_549_2)
				var_549_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_549_1.position).x, (manager.ui.mainCamera.transform.position - var_549_1.position).y, (manager.ui.mainCamera.transform.position - var_549_1.position).z)
				var_549_1.localEulerAngles.z = 0
				var_549_1.localEulerAngles.x = 0
				var_549_1.localEulerAngles = var_549_1.localEulerAngles
			end

			if arg_546_1.time_ >= 0 + var_549_2 and arg_546_1.time_ < 0 + var_549_2 + arg_549_0 then
				var_549_1.localPosition = Vector3.New(0, 100, 0)
				var_549_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_549_1.position).x, (manager.ui.mainCamera.transform.position - var_549_1.position).y, (manager.ui.mainCamera.transform.position - var_549_1.position).z)
				var_549_1.localEulerAngles.z = 0
				var_549_1.localEulerAngles.x = 0
				var_549_1.localEulerAngles = var_549_1.localEulerAngles
			end

			if 0.666666666666667 < arg_546_1.time_ and arg_546_1.time_ <= 0.666666666666667 + arg_549_0 then
				arg_546_1:AudioAction("play", "effect", "se_story_140", "se_story_140_drop02", "")
			end

			local var_549_4 = 0
			local var_549_5 = 0.95

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_4 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, false)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_6 = arg_546_1:FormatText(arg_546_1:GetWordFromCfg(322192133).content)

				arg_546_1.text_.text = var_549_6

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_8 = 38 <= 0 and var_549_5 or var_549_5 * (utf8.len(var_549_6) / 38)

				if (38 <= 0 and var_549_5 or var_549_5 * (utf8.len(var_549_6) / 38)) > 0 and var_549_5 < var_549_8 then
					arg_546_1.talkMaxDuration = var_549_8

					if var_549_8 + var_549_4 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_8 + var_549_4
					end
				end

				arg_546_1.text_.text = var_549_6
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_9 = math.max(var_549_5, arg_546_1.talkMaxDuration)

			if var_549_4 <= arg_546_1.time_ and arg_546_1.time_ < var_549_4 + var_549_9 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_4) / var_549_9

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_4 + var_549_9 and arg_546_1.time_ < var_549_4 + var_549_9 + arg_549_0 then
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
			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.var_.moveOldPos1111ui_story = arg_550_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_553_0 = 0.001

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_0 then
				arg_550_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_550_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_550_1.time_ - 0) / var_553_0)
				arg_550_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_550_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_550_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_550_1.actors_["1111ui_story"].transform.position).z)
				arg_550_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_550_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_550_1.actors_["1111ui_story"].transform.localEulerAngles = arg_550_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_550_1.time_ >= 0 + var_553_0 and arg_550_1.time_ < 0 + var_553_0 + arg_553_0 then
				arg_550_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_550_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_550_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_550_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_550_1.actors_["1111ui_story"].transform.position).z)
				arg_550_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_550_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_550_1.actors_["1111ui_story"].transform.localEulerAngles = arg_550_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_553_1 = arg_550_1.actors_["1111ui_story"]

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 and not isNil(var_553_1) and arg_550_1.var_.characterEffect1111ui_story == nil then
				arg_550_1.var_.characterEffect1111ui_story = var_553_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_553_2 = 0.200000002980232

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_2 and not isNil(var_553_1) then
				if arg_550_1.var_.characterEffect1111ui_story and not isNil(var_553_1) then
					arg_550_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_550_1.time_ >= 0 + var_553_2 and arg_550_1.time_ < 0 + var_553_2 + arg_553_0 and not isNil(var_553_1) and arg_550_1.var_.characterEffect1111ui_story then
				arg_550_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_2")
			end

			local var_553_4 = 0
			local var_553_5 = 0.775

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_4 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				arg_550_1.leftNameTxt_.text = arg_550_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_6 = arg_550_1:GetWordFromCfg(322192134)
				local var_553_7 = arg_550_1:FormatText(var_553_6.content)

				arg_550_1.text_.text = var_553_7

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_9 = 31 <= 0 and var_553_5 or var_553_5 * (utf8.len(var_553_7) / 31)

				if (31 <= 0 and var_553_5 or var_553_5 * (utf8.len(var_553_7) / 31)) > 0 and var_553_5 < var_553_9 then
					arg_550_1.talkMaxDuration = var_553_9

					if var_553_9 + var_553_4 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_9 + var_553_4
					end
				end

				arg_550_1.text_.text = var_553_7
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192134", "story_v_out_322192.awb") ~= 0 then
					local var_553_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192134", "story_v_out_322192.awb") / 1000

					if var_553_10 + var_553_4 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_10 + var_553_4
					end

					if var_553_6.prefab_name ~= "" and arg_550_1.actors_[var_553_6.prefab_name] ~= nil then
						local var_553_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_550_1.actors_[var_553_6.prefab_name].transform, "story_v_out_322192", "322192134", "story_v_out_322192.awb")

						arg_550_1:RecordAudio("322192134", var_553_11)
						arg_550_1:RecordAudio("322192134", var_553_11)
					else
						arg_550_1:AudioAction("play", "voice", "story_v_out_322192", "322192134", "story_v_out_322192.awb")
					end

					arg_550_1:RecordHistoryTalkVoice("story_v_out_322192", "322192134", "story_v_out_322192.awb")
				end

				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_12 = math.max(var_553_5, arg_550_1.talkMaxDuration)

			if var_553_4 <= arg_550_1.time_ and arg_550_1.time_ < var_553_4 + var_553_12 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_4) / var_553_12

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_4 + var_553_12 and arg_550_1.time_ < var_553_4 + var_553_12 + arg_553_0 then
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
			local var_557_0 = 0.325

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				arg_554_1.leftNameTxt_.text = arg_554_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_1 = arg_554_1:GetWordFromCfg(322192135)
				local var_557_2 = arg_554_1:FormatText(var_557_1.content)

				arg_554_1.text_.text = var_557_2

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_4 = 13 <= 0 and var_557_0 or var_557_0 * (utf8.len(var_557_2) / 13)

				if (13 <= 0 and var_557_0 or var_557_0 * (utf8.len(var_557_2) / 13)) > 0 and var_557_0 < var_557_4 then
					arg_554_1.talkMaxDuration = var_557_4

					if var_557_4 + 0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_4 + 0
					end
				end

				arg_554_1.text_.text = var_557_2
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192135", "story_v_out_322192.awb") ~= 0 then
					local var_557_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192135", "story_v_out_322192.awb") / 1000

					if var_557_5 + 0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_5 + 0
					end

					if var_557_1.prefab_name ~= "" and arg_554_1.actors_[var_557_1.prefab_name] ~= nil then
						local var_557_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_1.prefab_name].transform, "story_v_out_322192", "322192135", "story_v_out_322192.awb")

						arg_554_1:RecordAudio("322192135", var_557_6)
						arg_554_1:RecordAudio("322192135", var_557_6)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_322192", "322192135", "story_v_out_322192.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_322192", "322192135", "story_v_out_322192.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_7 = math.max(var_557_0, arg_554_1.talkMaxDuration)

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_7 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - 0) / var_557_7

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= 0 + var_557_7 and arg_554_1.time_ < 0 + var_557_7 + arg_557_0 then
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
			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1.var_.moveOldPos10131ui_story = arg_558_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_561_0 = 0.001

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_0 then
				arg_558_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_558_1.var_.moveOldPos10131ui_story, Vector3.New(-0.78, -0.96, -5.8), (arg_558_1.time_ - 0) / var_561_0)
				arg_558_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_558_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_558_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_558_1.actors_["10131ui_story"].transform.position).z)
				arg_558_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_558_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_558_1.actors_["10131ui_story"].transform.localEulerAngles = arg_558_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_558_1.time_ >= 0 + var_561_0 and arg_558_1.time_ < 0 + var_561_0 + arg_561_0 then
				arg_558_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(-0.78, -0.96, -5.8)
				arg_558_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_558_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_558_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_558_1.actors_["10131ui_story"].transform.position).z)
				arg_558_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_558_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_558_1.actors_["10131ui_story"].transform.localEulerAngles = arg_558_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_561_1 = arg_558_1.actors_["1111ui_story"].transform

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1.var_.moveOldPos1111ui_story = var_561_1.localPosition
			end

			local var_561_2 = 0.001

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_2 then
				var_561_1.localPosition = Vector3.Lerp(arg_558_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_558_1.time_ - 0) / var_561_2)
				var_561_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_561_1.position).x, (manager.ui.mainCamera.transform.position - var_561_1.position).y, (manager.ui.mainCamera.transform.position - var_561_1.position).z)
				var_561_1.localEulerAngles.z = 0
				var_561_1.localEulerAngles.x = 0
				var_561_1.localEulerAngles = var_561_1.localEulerAngles
			end

			if arg_558_1.time_ >= 0 + var_561_2 and arg_558_1.time_ < 0 + var_561_2 + arg_561_0 then
				var_561_1.localPosition = Vector3.New(0.7, -0.87, -5.7)
				var_561_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_561_1.position).x, (manager.ui.mainCamera.transform.position - var_561_1.position).y, (manager.ui.mainCamera.transform.position - var_561_1.position).z)
				var_561_1.localEulerAngles.z = 0
				var_561_1.localEulerAngles.x = 0
				var_561_1.localEulerAngles = var_561_1.localEulerAngles
			end

			local var_561_3 = arg_558_1.actors_["10131ui_story"]

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 and not isNil(var_561_3) and arg_558_1.var_.characterEffect10131ui_story == nil then
				arg_558_1.var_.characterEffect10131ui_story = var_561_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_4 = 0.200000002980232

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_4 and not isNil(var_561_3) then
				if arg_558_1.var_.characterEffect10131ui_story and not isNil(var_561_3) then
					arg_558_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_558_1.time_ >= 0 + var_561_4 and arg_558_1.time_ < 0 + var_561_4 + arg_561_0 and not isNil(var_561_3) and arg_558_1.var_.characterEffect10131ui_story then
				arg_558_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_561_6 = arg_558_1.actors_["1111ui_story"]

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 and not isNil(var_561_6) and arg_558_1.var_.characterEffect1111ui_story == nil then
				arg_558_1.var_.characterEffect1111ui_story = var_561_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_7 = 0.200000002980232

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_7 and not isNil(var_561_6) then
				if arg_558_1.var_.characterEffect1111ui_story and not isNil(var_561_6) then
					arg_558_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_558_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_558_1.time_ - 0) / var_561_7)
				end
			end

			if arg_558_1.time_ >= 0 + var_561_7 and arg_558_1.time_ < 0 + var_561_7 + arg_561_0 and not isNil(var_561_6) and arg_558_1.var_.characterEffect1111ui_story then
				arg_558_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_558_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_561_8 = 0
			local var_561_9 = 1.1

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_8 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				arg_558_1.leftNameTxt_.text = arg_558_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_10 = arg_558_1:GetWordFromCfg(322192136)
				local var_561_11 = arg_558_1:FormatText(var_561_10.content)

				arg_558_1.text_.text = var_561_11

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_13 = 44 <= 0 and var_561_9 or var_561_9 * (utf8.len(var_561_11) / 44)

				if (44 <= 0 and var_561_9 or var_561_9 * (utf8.len(var_561_11) / 44)) > 0 and var_561_9 < var_561_13 then
					arg_558_1.talkMaxDuration = var_561_13

					if var_561_13 + var_561_8 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_13 + var_561_8
					end
				end

				arg_558_1.text_.text = var_561_11
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192136", "story_v_out_322192.awb") ~= 0 then
					local var_561_14 = manager.audio:GetVoiceLength("story_v_out_322192", "322192136", "story_v_out_322192.awb") / 1000

					if var_561_14 + var_561_8 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_14 + var_561_8
					end

					if var_561_10.prefab_name ~= "" and arg_558_1.actors_[var_561_10.prefab_name] ~= nil then
						local var_561_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_10.prefab_name].transform, "story_v_out_322192", "322192136", "story_v_out_322192.awb")

						arg_558_1:RecordAudio("322192136", var_561_15)
						arg_558_1:RecordAudio("322192136", var_561_15)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_out_322192", "322192136", "story_v_out_322192.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_out_322192", "322192136", "story_v_out_322192.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_16 = math.max(var_561_9, arg_558_1.talkMaxDuration)

			if var_561_8 <= arg_558_1.time_ and arg_558_1.time_ < var_561_8 + var_561_16 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_8) / var_561_16

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_8 + var_561_16 and arg_558_1.time_ < var_561_8 + var_561_16 + arg_561_0 then
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
			local var_565_0 = 1.4

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				arg_562_1.leftNameTxt_.text = arg_562_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_1 = arg_562_1:GetWordFromCfg(322192137)
				local var_565_2 = arg_562_1:FormatText(var_565_1.content)

				arg_562_1.text_.text = var_565_2

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_4 = 56 <= 0 and var_565_0 or var_565_0 * (utf8.len(var_565_2) / 56)

				if (56 <= 0 and var_565_0 or var_565_0 * (utf8.len(var_565_2) / 56)) > 0 and var_565_0 < var_565_4 then
					arg_562_1.talkMaxDuration = var_565_4

					if var_565_4 + 0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_4 + 0
					end
				end

				arg_562_1.text_.text = var_565_2
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192137", "story_v_out_322192.awb") ~= 0 then
					local var_565_5 = manager.audio:GetVoiceLength("story_v_out_322192", "322192137", "story_v_out_322192.awb") / 1000

					if var_565_5 + 0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_5 + 0
					end

					if var_565_1.prefab_name ~= "" and arg_562_1.actors_[var_565_1.prefab_name] ~= nil then
						local var_565_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_1.prefab_name].transform, "story_v_out_322192", "322192137", "story_v_out_322192.awb")

						arg_562_1:RecordAudio("322192137", var_565_6)
						arg_562_1:RecordAudio("322192137", var_565_6)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_322192", "322192137", "story_v_out_322192.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_322192", "322192137", "story_v_out_322192.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_7 = math.max(var_565_0, arg_562_1.talkMaxDuration)

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_7 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - 0) / var_565_7

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= 0 + var_565_7 and arg_562_1.time_ < 0 + var_565_7 + arg_565_0 then
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
			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_2")
			end

			local var_569_0 = 0
			local var_569_1 = 0.6

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_0 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				arg_566_1.leftNameTxt_.text = arg_566_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_2 = arg_566_1:GetWordFromCfg(322192138)
				local var_569_3 = arg_566_1:FormatText(var_569_2.content)

				arg_566_1.text_.text = var_569_3

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_5 = 24 <= 0 and var_569_1 or var_569_1 * (utf8.len(var_569_3) / 24)

				if (24 <= 0 and var_569_1 or var_569_1 * (utf8.len(var_569_3) / 24)) > 0 and var_569_1 < var_569_5 then
					arg_566_1.talkMaxDuration = var_569_5

					if var_569_5 + var_569_0 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_5 + var_569_0
					end
				end

				arg_566_1.text_.text = var_569_3
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192138", "story_v_out_322192.awb") ~= 0 then
					local var_569_6 = manager.audio:GetVoiceLength("story_v_out_322192", "322192138", "story_v_out_322192.awb") / 1000

					if var_569_6 + var_569_0 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_6 + var_569_0
					end

					if var_569_2.prefab_name ~= "" and arg_566_1.actors_[var_569_2.prefab_name] ~= nil then
						local var_569_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_2.prefab_name].transform, "story_v_out_322192", "322192138", "story_v_out_322192.awb")

						arg_566_1:RecordAudio("322192138", var_569_7)
						arg_566_1:RecordAudio("322192138", var_569_7)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_out_322192", "322192138", "story_v_out_322192.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_out_322192", "322192138", "story_v_out_322192.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_8 = math.max(var_569_1, arg_566_1.talkMaxDuration)

			if var_569_0 <= arg_566_1.time_ and arg_566_1.time_ < var_569_0 + var_569_8 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_0) / var_569_8

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_0 + var_569_8 and arg_566_1.time_ < var_569_0 + var_569_8 + arg_569_0 then
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
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1.var_.moveOldPos1111ui_story = arg_570_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_573_0 = 0.001

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_0 then
				arg_570_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_570_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_570_1.time_ - 0) / var_573_0)
				arg_570_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_570_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_570_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_570_1.actors_["1111ui_story"].transform.position).z)
				arg_570_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_570_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_570_1.actors_["1111ui_story"].transform.localEulerAngles = arg_570_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_570_1.time_ >= 0 + var_573_0 and arg_570_1.time_ < 0 + var_573_0 + arg_573_0 then
				arg_570_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_570_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_570_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_570_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_570_1.actors_["1111ui_story"].transform.position).z)
				arg_570_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_570_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_570_1.actors_["1111ui_story"].transform.localEulerAngles = arg_570_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_573_1 = arg_570_1.actors_["1111ui_story"]

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 and not isNil(var_573_1) and arg_570_1.var_.characterEffect1111ui_story == nil then
				arg_570_1.var_.characterEffect1111ui_story = var_573_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_2 = 0.200000002980232

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_2 and not isNil(var_573_1) then
				if arg_570_1.var_.characterEffect1111ui_story and not isNil(var_573_1) then
					arg_570_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_570_1.time_ >= 0 + var_573_2 and arg_570_1.time_ < 0 + var_573_2 + arg_573_0 and not isNil(var_573_1) and arg_570_1.var_.characterEffect1111ui_story then
				arg_570_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_573_4 = arg_570_1.actors_["10131ui_story"]

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 and not isNil(var_573_4) and arg_570_1.var_.characterEffect10131ui_story == nil then
				arg_570_1.var_.characterEffect10131ui_story = var_573_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_5 = 0.200000002980232

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_5 and not isNil(var_573_4) then
				if arg_570_1.var_.characterEffect10131ui_story and not isNil(var_573_4) then
					arg_570_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_570_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_570_1.time_ - 0) / var_573_5)
				end
			end

			if arg_570_1.time_ >= 0 + var_573_5 and arg_570_1.time_ < 0 + var_573_5 + arg_573_0 and not isNil(var_573_4) and arg_570_1.var_.characterEffect10131ui_story then
				arg_570_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_570_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_573_6 = 0
			local var_573_7 = 0.3

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_6 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				arg_570_1.leftNameTxt_.text = arg_570_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_8 = arg_570_1:GetWordFromCfg(322192139)
				local var_573_9 = arg_570_1:FormatText(var_573_8.content)

				arg_570_1.text_.text = var_573_9

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_11 = 12 <= 0 and var_573_7 or var_573_7 * (utf8.len(var_573_9) / 12)

				if (12 <= 0 and var_573_7 or var_573_7 * (utf8.len(var_573_9) / 12)) > 0 and var_573_7 < var_573_11 then
					arg_570_1.talkMaxDuration = var_573_11

					if var_573_11 + var_573_6 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_11 + var_573_6
					end
				end

				arg_570_1.text_.text = var_573_9
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192139", "story_v_out_322192.awb") ~= 0 then
					local var_573_12 = manager.audio:GetVoiceLength("story_v_out_322192", "322192139", "story_v_out_322192.awb") / 1000

					if var_573_12 + var_573_6 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_12 + var_573_6
					end

					if var_573_8.prefab_name ~= "" and arg_570_1.actors_[var_573_8.prefab_name] ~= nil then
						local var_573_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_8.prefab_name].transform, "story_v_out_322192", "322192139", "story_v_out_322192.awb")

						arg_570_1:RecordAudio("322192139", var_573_13)
						arg_570_1:RecordAudio("322192139", var_573_13)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_out_322192", "322192139", "story_v_out_322192.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_out_322192", "322192139", "story_v_out_322192.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_14 = math.max(var_573_7, arg_570_1.talkMaxDuration)

			if var_573_6 <= arg_570_1.time_ and arg_570_1.time_ < var_573_6 + var_573_14 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_6) / var_573_14

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_6 + var_573_14 and arg_570_1.time_ < var_573_6 + var_573_14 + arg_573_0 then
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
			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 and not isNil(arg_574_1.actors_["10131ui_story"]) and arg_574_1.var_.characterEffect10131ui_story == nil then
				arg_574_1.var_.characterEffect10131ui_story = arg_574_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_0 = 0.200000002980232

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_0 and not isNil(arg_574_1.actors_["10131ui_story"]) then
				if arg_574_1.var_.characterEffect10131ui_story and not isNil(arg_574_1.actors_["10131ui_story"]) then
					arg_574_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_574_1.time_ >= 0 + var_577_0 and arg_574_1.time_ < 0 + var_577_0 + arg_577_0 and not isNil(arg_574_1.actors_["10131ui_story"]) and arg_574_1.var_.characterEffect10131ui_story then
				arg_574_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_577_2 = arg_574_1.actors_["1111ui_story"]

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 and not isNil(var_577_2) and arg_574_1.var_.characterEffect1111ui_story == nil then
				arg_574_1.var_.characterEffect1111ui_story = var_577_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_3 = 0.200000002980232

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_3 and not isNil(var_577_2) then
				if arg_574_1.var_.characterEffect1111ui_story and not isNil(var_577_2) then
					arg_574_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_574_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_574_1.time_ - 0) / var_577_3)
				end
			end

			if arg_574_1.time_ >= 0 + var_577_3 and arg_574_1.time_ < 0 + var_577_3 + arg_577_0 and not isNil(var_577_2) and arg_574_1.var_.characterEffect1111ui_story then
				arg_574_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_574_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 then
				arg_574_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_577_4 = 0
			local var_577_5 = 0.15

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_4 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				arg_574_1.leftNameTxt_.text = arg_574_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_6 = arg_574_1:GetWordFromCfg(322192140)
				local var_577_7 = arg_574_1:FormatText(var_577_6.content)

				arg_574_1.text_.text = var_577_7

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_9 = 6 <= 0 and var_577_5 or var_577_5 * (utf8.len(var_577_7) / 6)

				if (6 <= 0 and var_577_5 or var_577_5 * (utf8.len(var_577_7) / 6)) > 0 and var_577_5 < var_577_9 then
					arg_574_1.talkMaxDuration = var_577_9

					if var_577_9 + var_577_4 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_9 + var_577_4
					end
				end

				arg_574_1.text_.text = var_577_7
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192140", "story_v_out_322192.awb") ~= 0 then
					local var_577_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192140", "story_v_out_322192.awb") / 1000

					if var_577_10 + var_577_4 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_10 + var_577_4
					end

					if var_577_6.prefab_name ~= "" and arg_574_1.actors_[var_577_6.prefab_name] ~= nil then
						local var_577_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_574_1.actors_[var_577_6.prefab_name].transform, "story_v_out_322192", "322192140", "story_v_out_322192.awb")

						arg_574_1:RecordAudio("322192140", var_577_11)
						arg_574_1:RecordAudio("322192140", var_577_11)
					else
						arg_574_1:AudioAction("play", "voice", "story_v_out_322192", "322192140", "story_v_out_322192.awb")
					end

					arg_574_1:RecordHistoryTalkVoice("story_v_out_322192", "322192140", "story_v_out_322192.awb")
				end

				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_12 = math.max(var_577_5, arg_574_1.talkMaxDuration)

			if var_577_4 <= arg_574_1.time_ and arg_574_1.time_ < var_577_4 + var_577_12 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_4) / var_577_12

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_4 + var_577_12 and arg_574_1.time_ < var_577_4 + var_577_12 + arg_577_0 then
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
			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1.var_.moveOldPos1111ui_story = arg_578_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_581_0 = 0.001

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_0 then
				arg_578_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_578_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_578_1.time_ - 0) / var_581_0)
				arg_578_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_578_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1111ui_story"].transform.position).z)
				arg_578_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_578_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_578_1.actors_["1111ui_story"].transform.localEulerAngles = arg_578_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_578_1.time_ >= 0 + var_581_0 and arg_578_1.time_ < 0 + var_581_0 + arg_581_0 then
				arg_578_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_578_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_578_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1111ui_story"].transform.position).z)
				arg_578_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_578_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_578_1.actors_["1111ui_story"].transform.localEulerAngles = arg_578_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_581_1 = arg_578_1.actors_["10131ui_story"].transform

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1.var_.moveOldPos10131ui_story = var_581_1.localPosition
			end

			local var_581_2 = 0.001

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_2 then
				var_581_1.localPosition = Vector3.Lerp(arg_578_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_578_1.time_ - 0) / var_581_2)
				var_581_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_581_1.position).x, (manager.ui.mainCamera.transform.position - var_581_1.position).y, (manager.ui.mainCamera.transform.position - var_581_1.position).z)
				var_581_1.localEulerAngles.z = 0
				var_581_1.localEulerAngles.x = 0
				var_581_1.localEulerAngles = var_581_1.localEulerAngles
			end

			if arg_578_1.time_ >= 0 + var_581_2 and arg_578_1.time_ < 0 + var_581_2 + arg_581_0 then
				var_581_1.localPosition = Vector3.New(0, 100, 0)
				var_581_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_581_1.position).x, (manager.ui.mainCamera.transform.position - var_581_1.position).y, (manager.ui.mainCamera.transform.position - var_581_1.position).z)
				var_581_1.localEulerAngles.z = 0
				var_581_1.localEulerAngles.x = 0
				var_581_1.localEulerAngles = var_581_1.localEulerAngles
			end

			local var_581_3 = arg_578_1.actors_["10131ui_story"]

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 and not isNil(var_581_3) and arg_578_1.var_.characterEffect10131ui_story == nil then
				arg_578_1.var_.characterEffect10131ui_story = var_581_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_4 = 0.200000002980232

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_4 and not isNil(var_581_3) then
				if arg_578_1.var_.characterEffect10131ui_story and not isNil(var_581_3) then
					arg_578_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_578_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_578_1.time_ - 0) / var_581_4)
				end
			end

			if arg_578_1.time_ >= 0 + var_581_4 and arg_578_1.time_ < 0 + var_581_4 + arg_581_0 and not isNil(var_581_3) and arg_578_1.var_.characterEffect10131ui_story then
				arg_578_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_578_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_581_5 = 0
			local var_581_6 = 1.35

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= var_581_5 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, false)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_7 = arg_578_1:FormatText(arg_578_1:GetWordFromCfg(322192141).content)

				arg_578_1.text_.text = var_581_7

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_9 = 54 <= 0 and var_581_6 or var_581_6 * (utf8.len(var_581_7) / 54)

				if (54 <= 0 and var_581_6 or var_581_6 * (utf8.len(var_581_7) / 54)) > 0 and var_581_6 < var_581_9 then
					arg_578_1.talkMaxDuration = var_581_9

					if var_581_9 + var_581_5 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_9 + var_581_5
					end
				end

				arg_578_1.text_.text = var_581_7
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)
				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_10 = math.max(var_581_6, arg_578_1.talkMaxDuration)

			if var_581_5 <= arg_578_1.time_ and arg_578_1.time_ < var_581_5 + var_581_10 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_5) / var_581_10

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_5 + var_581_10 and arg_578_1.time_ < var_581_5 + var_581_10 + arg_581_0 then
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
			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1.var_.moveOldPos10131ui_story = arg_582_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_585_0 = 0.001

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_0 then
				arg_582_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos10131ui_story, Vector3.New(0.05, -0.96, -5.8), (arg_582_1.time_ - 0) / var_585_0)
				arg_582_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_582_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["10131ui_story"].transform.position).z)
				arg_582_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_582_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_582_1.actors_["10131ui_story"].transform.localEulerAngles = arg_582_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_582_1.time_ >= 0 + var_585_0 and arg_582_1.time_ < 0 + var_585_0 + arg_585_0 then
				arg_582_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.05, -0.96, -5.8)
				arg_582_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_582_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_582_1.actors_["10131ui_story"].transform.position).z)
				arg_582_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_582_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_582_1.actors_["10131ui_story"].transform.localEulerAngles = arg_582_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_585_1 = arg_582_1.actors_["10131ui_story"]

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 and not isNil(var_585_1) and arg_582_1.var_.characterEffect10131ui_story == nil then
				arg_582_1.var_.characterEffect10131ui_story = var_585_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_585_2 = 0.200000002980232

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_2 and not isNil(var_585_1) then
				if arg_582_1.var_.characterEffect10131ui_story and not isNil(var_585_1) then
					arg_582_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_582_1.time_ >= 0 + var_585_2 and arg_582_1.time_ < 0 + var_585_2 + arg_585_0 and not isNil(var_585_1) and arg_582_1.var_.characterEffect10131ui_story then
				arg_582_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_585_4 = 0
			local var_585_5 = 0.65

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_4 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				arg_582_1.leftNameTxt_.text = arg_582_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_6 = arg_582_1:GetWordFromCfg(322192142)
				local var_585_7 = arg_582_1:FormatText(var_585_6.content)

				arg_582_1.text_.text = var_585_7

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_9 = 26 <= 0 and var_585_5 or var_585_5 * (utf8.len(var_585_7) / 26)

				if (26 <= 0 and var_585_5 or var_585_5 * (utf8.len(var_585_7) / 26)) > 0 and var_585_5 < var_585_9 then
					arg_582_1.talkMaxDuration = var_585_9

					if var_585_9 + var_585_4 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_9 + var_585_4
					end
				end

				arg_582_1.text_.text = var_585_7
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322192", "322192142", "story_v_out_322192.awb") ~= 0 then
					local var_585_10 = manager.audio:GetVoiceLength("story_v_out_322192", "322192142", "story_v_out_322192.awb") / 1000

					if var_585_10 + var_585_4 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_10 + var_585_4
					end

					if var_585_6.prefab_name ~= "" and arg_582_1.actors_[var_585_6.prefab_name] ~= nil then
						local var_585_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_582_1.actors_[var_585_6.prefab_name].transform, "story_v_out_322192", "322192142", "story_v_out_322192.awb")

						arg_582_1:RecordAudio("322192142", var_585_11)
						arg_582_1:RecordAudio("322192142", var_585_11)
					else
						arg_582_1:AudioAction("play", "voice", "story_v_out_322192", "322192142", "story_v_out_322192.awb")
					end

					arg_582_1:RecordHistoryTalkVoice("story_v_out_322192", "322192142", "story_v_out_322192.awb")
				end

				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_12 = math.max(var_585_5, arg_582_1.talkMaxDuration)

			if var_585_4 <= arg_582_1.time_ and arg_582_1.time_ < var_585_4 + var_585_12 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_4) / var_585_12

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_4 + var_585_12 and arg_582_1.time_ < var_585_4 + var_585_12 + arg_585_0 then
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
