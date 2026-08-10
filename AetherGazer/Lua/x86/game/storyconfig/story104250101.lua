return {
	Play425011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425011001
		arg_1_1.duration_ = 2.63

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play425011002(arg_1_1)
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

			local var_4_17 = 0.991666666667667

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

			local var_4_22 = 0.991666666667667

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_23 = 0.174999999998

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_24 = 0.166666666666667
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_147", "se_story_147_amb_interrogation", "")
			end

			local var_4_28 = 0
			local var_4_29 = 0.3

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			local var_4_34 = 0.500666666666667
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "music"

				arg_1_1:AudioAction(var_4_36, var_4_37, "bgm_activity_4_7_story_interrogation_1", "bgm_activity_4_7_story_interrogation_1", "bgm_activity_4_7_story_interrogation_1.awb")

				local var_4_38 = ""
				local var_4_39 = manager.audio:GetAudioName("bgm_activity_4_7_story_interrogation_1", "bgm_activity_4_7_story_interrogation_1")

				if var_4_39 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_39 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_39

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_39
						arg_1_1.bgmTxt2_.text = var_4_39
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

			local var_4_40 = 0
			local var_4_41 = 2.633
			local var_4_42 = manager.audio:GetVoiceLength("story_v_out_425011", "425011001", "story_v_out_425011.awb") / 1000

			if var_4_42 > 0 and var_4_41 < var_4_42 and var_4_42 + var_4_40 > arg_1_1.duration_ then
				local var_4_43 = var_4_42

				arg_1_1.duration_ = var_4_42 + var_4_40
			end

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "voice"

				arg_1_1:AudioAction(var_4_44, var_4_45, "story_v_out_425011", "425011001", "story_v_out_425011.awb")
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425011001,
				charCount = 7,
				enableLayoutChange = true,
				duration = 0.875,
				groupID = "1001",
				startTime = 0,
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
	Play425011002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 425011002
		arg_7_1.duration_ = 13.37

		local var_7_0 = {
			zh = 7.29933333333333,
			ja = 13.3663333333333
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play425011003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = manager.ui.mainCamera.transform
			local var_10_1 = 0

			if var_10_1 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 then
				local var_10_2 = arg_7_1.var_.effect10011

				if var_10_2 then
					Object.Destroy(var_10_2)

					arg_7_1.var_.effect10011 = nil
				end
			end

			local var_10_3
			local var_10_4 = 0

			if var_10_4 < arg_7_1.time_ and arg_7_1.time_ <= var_10_4 + arg_10_0 then
				local var_10_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_10_5 then
					var_10_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_10_5.radialBlurScale = 1
					var_10_5.radialBlurGradient = 1
					var_10_5.radialBlurIntensity = 1

					if var_10_3 then
						var_10_5.radialBlurTarget = var_10_3.transform
					end
				end
			end

			local var_10_6 = 2.73333333333333

			if var_10_4 <= arg_7_1.time_ and arg_7_1.time_ < var_10_4 + var_10_6 then
				local var_10_7 = (arg_7_1.time_ - var_10_4) / var_10_6
				local var_10_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_10_8 then
					var_10_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_10_8.radialBlurScale = Mathf.Lerp(1, 0, var_10_7)
					var_10_8.radialBlurGradient = Mathf.Lerp(1, 0, var_10_7)
					var_10_8.radialBlurIntensity = Mathf.Lerp(1, 0, var_10_7)
				end
			end

			if arg_7_1.time_ >= var_10_4 + var_10_6 and arg_7_1.time_ < var_10_4 + var_10_6 + arg_10_0 then
				local var_10_9 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_10_9 then
					var_10_9.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_10_9.radialBlurScale = 0
					var_10_9.radialBlurGradient = 0
					var_10_9.radialBlurIntensity = 0
				end
			end

			local var_10_10 = manager.ui.mainCamera.transform
			local var_10_11 = 0

			if var_10_11 < arg_7_1.time_ and arg_7_1.time_ <= var_10_11 + arg_10_0 then
				local var_10_12 = arg_7_1.var_.effect10012
				local var_10_13
				local var_10_14 = var_10_10

				if not var_10_12 then
					var_10_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapblink"), var_10_14)
					var_10_12.name = "10012"
					arg_7_1.var_.effect10012 = var_10_12
				else
					var_10_12.transform:SetParent(var_10_14)
				end

				var_10_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_10_12.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_10_15 = 1.7777777777777777
				local var_10_16 = Screen.width / Screen.height
				local var_10_17 = var_10_16 / var_10_15
				local var_10_18 = Mathf.Max(var_10_15 / var_10_16, 1)

				var_10_12.transform.localScale = Vector3.New(var_10_12.transform.localScale.x * var_10_17, var_10_12.transform.localScale.y * var_10_18, var_10_12.transform.localScale.z)
			end

			local var_10_19 = "ST2403"

			if arg_7_1.bgs_[var_10_19] == nil then
				local var_10_20 = Object.Instantiate(arg_7_1.paintGo_)

				var_10_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_10_19)
				var_10_20.name = var_10_19
				var_10_20.transform.parent = arg_7_1.stage_.transform
				var_10_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.bgs_[var_10_19] = var_10_20
			end

			local var_10_21 = 0

			if var_10_21 < arg_7_1.time_ and arg_7_1.time_ <= var_10_21 + arg_10_0 then
				local var_10_22 = manager.ui.mainCamera.transform.localPosition
				local var_10_23 = Vector3.New(0, 0, 10) + Vector3.New(var_10_22.x, var_10_22.y, 0)
				local var_10_24 = arg_7_1.bgs_.ST2403

				var_10_24.transform.localPosition = var_10_23
				var_10_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_10_25 = var_10_24:GetComponent("SpriteRenderer")

				if var_10_25 and var_10_25.sprite then
					local var_10_26 = (var_10_24.transform.localPosition - var_10_22).z
					local var_10_27 = manager.ui.mainCameraCom_
					local var_10_28 = 2 * var_10_26 * Mathf.Tan(var_10_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_10_29 = var_10_28 * var_10_27.aspect
					local var_10_30 = var_10_25.sprite.bounds.size.x
					local var_10_31 = var_10_25.sprite.bounds.size.y
					local var_10_32 = var_10_29 / var_10_30
					local var_10_33 = var_10_28 / var_10_31
					local var_10_34 = var_10_33 < var_10_32 and var_10_32 or var_10_33

					var_10_24.transform.localScale = Vector3.New(var_10_34, var_10_34, 0)
				end

				for iter_10_0, iter_10_1 in pairs(arg_7_1.bgs_) do
					if iter_10_0 ~= "ST2403" then
						iter_10_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_10_35 = 0

			if var_10_35 < arg_7_1.time_ and arg_7_1.time_ <= var_10_35 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_36 = 2.73333333333333

			if var_10_35 <= arg_7_1.time_ and arg_7_1.time_ < var_10_35 + var_10_36 then
				local var_10_37 = (arg_7_1.time_ - var_10_35) / var_10_36
				local var_10_38 = Color.New(0, 0, 0)

				var_10_38.a = Mathf.Lerp(1, 0, var_10_37)
				arg_7_1.mask_.color = var_10_38
			end

			if arg_7_1.time_ >= var_10_35 + var_10_36 and arg_7_1.time_ < var_10_35 + var_10_36 + arg_10_0 then
				local var_10_39 = Color.New(0, 0, 0)
				local var_10_40 = 0

				arg_7_1.mask_.enabled = false
				var_10_39.a = var_10_40
				arg_7_1.mask_.color = var_10_39
			end

			if arg_7_1.frameCnt_ <= 1 then
				arg_7_1.dialog_:SetActive(false)
			end

			local var_10_41 = 3.03333333333333
			local var_10_42 = 0.55

			if var_10_41 < arg_7_1.time_ and arg_7_1.time_ <= var_10_41 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_43 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_43:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
					arg_7_1.dialogCg_.alpha = arg_11_0
				end))
				var_10_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_44 = arg_7_1:FormatText(StoryNameCfg[15].name)

				arg_7_1.leftNameTxt_.text = var_10_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_45 = arg_7_1:GetWordFromCfg(425011002)
				local var_10_46 = arg_7_1:FormatText(var_10_45.content)

				arg_7_1.text_.text = var_10_46

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_47 = 22
				local var_10_48 = utf8.len(var_10_46)
				local var_10_49 = var_10_47 <= 0 and var_10_42 or var_10_42 * (var_10_48 / var_10_47)

				if var_10_49 > 0 and var_10_42 < var_10_49 then
					arg_7_1.talkMaxDuration = var_10_49
					var_10_41 = var_10_41 + 0.3

					if var_10_49 + var_10_41 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_49 + var_10_41
					end
				end

				arg_7_1.text_.text = var_10_46
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011002", "story_v_out_425011.awb") ~= 0 then
					local var_10_50 = manager.audio:GetVoiceLength("story_v_out_425011", "425011002", "story_v_out_425011.awb") / 1000

					if var_10_50 + var_10_41 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_50 + var_10_41
					end

					if var_10_45.prefab_name ~= "" and arg_7_1.actors_[var_10_45.prefab_name] ~= nil then
						local var_10_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_45.prefab_name].transform, "story_v_out_425011", "425011002", "story_v_out_425011.awb")

						arg_7_1:RecordAudio("425011002", var_10_51)
						arg_7_1:RecordAudio("425011002", var_10_51)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_425011", "425011002", "story_v_out_425011.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_425011", "425011002", "story_v_out_425011.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_52 = var_10_41 + 0.3
			local var_10_53 = math.max(var_10_42, arg_7_1.talkMaxDuration)

			if var_10_52 <= arg_7_1.time_ and arg_7_1.time_ < var_10_52 + var_10_53 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_52) / var_10_53

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_52 + var_10_53 and arg_7_1.time_ < var_10_52 + var_10_53 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				groupID = "1001",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_ALL_TEXT_GROUP
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play425011003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 425011003
		arg_13_1.duration_ = 10.6

		local var_13_0 = {
			zh = 8.1,
			ja = 10.6
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play425011004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.95

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[36].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:GetWordFromCfg(425011003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 38
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011003", "story_v_out_425011.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011003", "story_v_out_425011.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_425011", "425011003", "story_v_out_425011.awb")

						arg_13_1:RecordAudio("425011003", var_16_9)
						arg_13_1:RecordAudio("425011003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_425011", "425011003", "story_v_out_425011.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_425011", "425011003", "story_v_out_425011.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play425011004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 425011004
		arg_17_1.duration_ = 6.43

		local var_17_0 = {
			zh = 1.233,
			ja = 6.433
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play425011005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			local var_20_1 = 0.366666666666667

			if arg_17_1.time_ >= var_20_0 + var_20_1 and arg_17_1.time_ < var_20_0 + var_20_1 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end

			local var_20_2 = 0
			local var_20_3 = 0.1

			if var_20_2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_4 = arg_17_1:FormatText(StoryNameCfg[15].name)

				arg_17_1.leftNameTxt_.text = var_20_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_5 = arg_17_1:GetWordFromCfg(425011004)
				local var_20_6 = arg_17_1:FormatText(var_20_5.content)

				arg_17_1.text_.text = var_20_6

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 4
				local var_20_8 = utf8.len(var_20_6)
				local var_20_9 = var_20_7 <= 0 and var_20_3 or var_20_3 * (var_20_8 / var_20_7)

				if var_20_9 > 0 and var_20_3 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_6
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011004", "story_v_out_425011.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_425011", "425011004", "story_v_out_425011.awb") / 1000

					if var_20_10 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_2
					end

					if var_20_5.prefab_name ~= "" and arg_17_1.actors_[var_20_5.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_5.prefab_name].transform, "story_v_out_425011", "425011004", "story_v_out_425011.awb")

						arg_17_1:RecordAudio("425011004", var_20_11)
						arg_17_1:RecordAudio("425011004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_425011", "425011004", "story_v_out_425011.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_425011", "425011004", "story_v_out_425011.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_12 and arg_17_1.time_ < var_20_2 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play425011005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 425011005
		arg_21_1.duration_ = 13

		local var_21_0 = {
			zh = 12.066,
			ja = 13
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play425011006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 1.3

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[36].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(425011005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 52
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011005", "story_v_out_425011.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011005", "story_v_out_425011.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_425011", "425011005", "story_v_out_425011.awb")

						arg_21_1:RecordAudio("425011005", var_24_9)
						arg_21_1:RecordAudio("425011005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_425011", "425011005", "story_v_out_425011.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_425011", "425011005", "story_v_out_425011.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play425011006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 425011006
		arg_25_1.duration_ = 5.6

		local var_25_0 = {
			zh = 5.6,
			ja = 5.033
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play425011007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.425

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[15].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(425011006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 17
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011006", "story_v_out_425011.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011006", "story_v_out_425011.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_425011", "425011006", "story_v_out_425011.awb")

						arg_25_1:RecordAudio("425011006", var_28_9)
						arg_25_1:RecordAudio("425011006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_425011", "425011006", "story_v_out_425011.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_425011", "425011006", "story_v_out_425011.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play425011007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 425011007
		arg_29_1.duration_ = 4.9

		local var_29_0 = {
			zh = 2.9,
			ja = 4.9
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play425011008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			local var_32_1 = 0.7

			if arg_29_1.time_ >= var_32_0 + var_32_1 and arg_29_1.time_ < var_32_0 + var_32_1 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			local var_32_2 = 0
			local var_32_3 = 0.35

			if var_32_2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_4 = arg_29_1:FormatText(StoryNameCfg[15].name)

				arg_29_1.leftNameTxt_.text = var_32_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_6")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_5 = arg_29_1:GetWordFromCfg(425011007)
				local var_32_6 = arg_29_1:FormatText(var_32_5.content)

				arg_29_1.text_.text = var_32_6

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 14
				local var_32_8 = utf8.len(var_32_6)
				local var_32_9 = var_32_7 <= 0 and var_32_3 or var_32_3 * (var_32_8 / var_32_7)

				if var_32_9 > 0 and var_32_3 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_6
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011007", "story_v_out_425011.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_425011", "425011007", "story_v_out_425011.awb") / 1000

					if var_32_10 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_2
					end

					if var_32_5.prefab_name ~= "" and arg_29_1.actors_[var_32_5.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_5.prefab_name].transform, "story_v_out_425011", "425011007", "story_v_out_425011.awb")

						arg_29_1:RecordAudio("425011007", var_32_11)
						arg_29_1:RecordAudio("425011007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_425011", "425011007", "story_v_out_425011.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_425011", "425011007", "story_v_out_425011.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_12 and arg_29_1.time_ < var_32_2 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play425011008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 425011008
		arg_33_1.duration_ = 12.4

		local var_33_0 = {
			zh = 8.533,
			ja = 12.4
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
				arg_33_0:Play425011009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.95

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[36].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(425011008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 38
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011008", "story_v_out_425011.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011008", "story_v_out_425011.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_425011", "425011008", "story_v_out_425011.awb")

						arg_33_1:RecordAudio("425011008", var_36_9)
						arg_33_1:RecordAudio("425011008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_425011", "425011008", "story_v_out_425011.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_425011", "425011008", "story_v_out_425011.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play425011009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 425011009
		arg_37_1.duration_ = 7.6

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play425011010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = manager.ui.mainCamera.transform
			local var_40_1 = 4.33333333333333

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.shakeOldPos = var_40_0.localPosition
			end

			local var_40_2 = 0.866666666666667

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / 0.066
				local var_40_4, var_40_5 = math.modf(var_40_3)

				var_40_0.localPosition = Vector3.New(var_40_5 * 0.13, var_40_5 * 0.13, var_40_5 * 0.13) + arg_37_1.var_.shakeOldPos
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = arg_37_1.var_.shakeOldPos
			end

			local var_40_6 = 0

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			local var_40_7 = 1.76666666666667

			if arg_37_1.time_ >= var_40_6 + var_40_7 and arg_37_1.time_ < var_40_6 + var_40_7 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end

			local var_40_8 = manager.ui.mainCamera.transform
			local var_40_9 = 4.33333333333333

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				local var_40_10 = arg_37_1.var_.effect10091009
				local var_40_11
				local var_40_12 = var_40_8

				if not var_40_10 then
					var_40_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple2"), var_40_12)
					var_40_10.name = "1009"
					arg_37_1.var_.effect10091009 = var_40_10
				else
					var_40_10.transform:SetParent(var_40_12)
				end

				var_40_10.transform.localPosition = Vector3.New(0, 0.12, -1)
				var_40_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_40_13 = 4.3
			local var_40_14 = 1

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				local var_40_15 = "play"
				local var_40_16 = "effect"

				arg_37_1:AudioAction(var_40_15, var_40_16, "se_story_147", "se_story_147_electric_shock_01", "")
			end

			local var_40_17 = 0

			if var_40_17 < arg_37_1.time_ and arg_37_1.time_ <= var_40_17 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			local var_40_18 = 5.9

			if arg_37_1.time_ >= var_40_17 + var_40_18 and arg_37_1.time_ < var_40_17 + var_40_18 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end

			local var_40_19 = manager.ui.mainCamera.transform
			local var_40_20 = 4.3

			if var_40_20 < arg_37_1.time_ and arg_37_1.time_ <= var_40_20 + arg_40_0 then
				local var_40_21 = arg_37_1.var_.effect100910141
				local var_40_22
				local var_40_23 = var_40_19

				if not var_40_21 then
					var_40_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_40_23)
					var_40_21.name = "10141"
					arg_37_1.var_.effect100910141 = var_40_21
				else
					var_40_21.transform:SetParent(var_40_23)
				end

				var_40_21.transform.localPosition = Vector3.New(0, 0, 6)
				var_40_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_40_24 = manager.ui.mainCamera.transform
			local var_40_25 = 5.73333333333333

			if var_40_25 < arg_37_1.time_ and arg_37_1.time_ <= var_40_25 + arg_40_0 then
				local var_40_26 = arg_37_1.var_.effect100910141

				if var_40_26 then
					Object.Destroy(var_40_26)

					arg_37_1.var_.effect100910141 = nil
				end
			end

			local var_40_27 = 0
			local var_40_28 = 0.9

			if var_40_27 < arg_37_1.time_ and arg_37_1.time_ <= var_40_27 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_29 = arg_37_1:FormatText(StoryNameCfg[15].name)

				arg_37_1.leftNameTxt_.text = var_40_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_6")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_30 = arg_37_1:GetWordFromCfg(425011009)
				local var_40_31 = arg_37_1:FormatText(var_40_30.content)

				arg_37_1.text_.text = var_40_31

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_32 = 36
				local var_40_33 = utf8.len(var_40_31)
				local var_40_34 = var_40_32 <= 0 and var_40_28 or var_40_28 * (var_40_33 / var_40_32)

				if var_40_34 > 0 and var_40_28 < var_40_34 then
					arg_37_1.talkMaxDuration = var_40_34

					if var_40_34 + var_40_27 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_34 + var_40_27
					end
				end

				arg_37_1.text_.text = var_40_31
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011009", "story_v_out_425011.awb") ~= 0 then
					local var_40_35 = manager.audio:GetVoiceLength("story_v_out_425011", "425011009", "story_v_out_425011.awb") / 1000

					if var_40_35 + var_40_27 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_35 + var_40_27
					end

					if var_40_30.prefab_name ~= "" and arg_37_1.actors_[var_40_30.prefab_name] ~= nil then
						local var_40_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_30.prefab_name].transform, "story_v_out_425011", "425011009", "story_v_out_425011.awb")

						arg_37_1:RecordAudio("425011009", var_40_36)
						arg_37_1:RecordAudio("425011009", var_40_36)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_425011", "425011009", "story_v_out_425011.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_425011", "425011009", "story_v_out_425011.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_37 = math.max(var_40_28, arg_37_1.talkMaxDuration)

			if var_40_27 <= arg_37_1.time_ and arg_37_1.time_ < var_40_27 + var_40_37 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_27) / var_40_37

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_27 + var_40_37 and arg_37_1.time_ < var_40_27 + var_40_37 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play425011010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 425011010
		arg_41_1.duration_ = 5.23

		local var_41_0 = {
			zh = 4.633,
			ja = 5.233
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
				arg_41_0:Play425011011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.575

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[36].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:GetWordFromCfg(425011010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 23
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011010", "story_v_out_425011.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011010", "story_v_out_425011.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_425011", "425011010", "story_v_out_425011.awb")

						arg_41_1:RecordAudio("425011010", var_44_9)
						arg_41_1:RecordAudio("425011010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_425011", "425011010", "story_v_out_425011.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_425011", "425011010", "story_v_out_425011.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play425011011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 425011011
		arg_45_1.duration_ = 4.83

		local var_45_0 = {
			zh = 4.833,
			ja = 2.933
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
				arg_45_0:Play425011012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			local var_48_1 = 0.3

			if arg_45_1.time_ >= var_48_0 + var_48_1 and arg_45_1.time_ < var_48_0 + var_48_1 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			local var_48_2 = 0
			local var_48_3 = 0.075

			if var_48_2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_4 = arg_45_1:FormatText(StoryNameCfg[15].name)

				arg_45_1.leftNameTxt_.text = var_48_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_3")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_5 = arg_45_1:GetWordFromCfg(425011011)
				local var_48_6 = arg_45_1:FormatText(var_48_5.content)

				arg_45_1.text_.text = var_48_6

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 3
				local var_48_8 = utf8.len(var_48_6)
				local var_48_9 = var_48_7 <= 0 and var_48_3 or var_48_3 * (var_48_8 / var_48_7)

				if var_48_9 > 0 and var_48_3 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_6
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011011", "story_v_out_425011.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_425011", "425011011", "story_v_out_425011.awb") / 1000

					if var_48_10 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_2
					end

					if var_48_5.prefab_name ~= "" and arg_45_1.actors_[var_48_5.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_5.prefab_name].transform, "story_v_out_425011", "425011011", "story_v_out_425011.awb")

						arg_45_1:RecordAudio("425011011", var_48_11)
						arg_45_1:RecordAudio("425011011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_425011", "425011011", "story_v_out_425011.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_425011", "425011011", "story_v_out_425011.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_12 and arg_45_1.time_ < var_48_2 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 10,
				className = "StoryShakeNode",
				duration = 0.3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(3, 5, 0)
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play425011012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 425011012
		arg_49_1.duration_ = 5.67

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play425011013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				local var_52_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_52_2 then
					var_52_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_52_2.radialBlurScale = 0
					var_52_2.radialBlurGradient = 0
					var_52_2.radialBlurIntensity = 0

					if var_52_0 then
						var_52_2.radialBlurTarget = var_52_0.transform
					end
				end
			end

			local var_52_3 = 0.666666666666667

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_3 then
				local var_52_4 = (arg_49_1.time_ - var_52_1) / var_52_3
				local var_52_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_52_5 then
					var_52_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_52_5.radialBlurScale = Mathf.Lerp(0, 1, var_52_4)
					var_52_5.radialBlurGradient = Mathf.Lerp(0, 1, var_52_4)
					var_52_5.radialBlurIntensity = Mathf.Lerp(0, 1, var_52_4)
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_3 and arg_49_1.time_ < var_52_1 + var_52_3 + arg_52_0 then
				local var_52_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_52_6 then
					var_52_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_52_6.radialBlurScale = 1
					var_52_6.radialBlurGradient = 1
					var_52_6.radialBlurIntensity = 1
				end
			end

			local var_52_7 = 0

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			local var_52_8 = 1.53333333333333

			if arg_49_1.time_ >= var_52_7 + var_52_8 and arg_49_1.time_ < var_52_7 + var_52_8 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			local var_52_9 = 0
			local var_52_10 = 1

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 then
				local var_52_11 = "play"
				local var_52_12 = "effect"

				arg_49_1:AudioAction(var_52_11, var_52_12, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_52_13 = 0.666666666666667
			local var_52_14 = 1

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_15 = arg_49_1:GetWordFromCfg(425011012)
				local var_52_16 = arg_49_1:FormatText(var_52_15.content)

				arg_49_1.text_.text = var_52_16

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_17 = 40
				local var_52_18 = utf8.len(var_52_16)
				local var_52_19 = var_52_17 <= 0 and var_52_14 or var_52_14 * (var_52_18 / var_52_17)

				if var_52_19 > 0 and var_52_14 < var_52_19 then
					arg_49_1.talkMaxDuration = var_52_19

					if var_52_19 + var_52_13 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_13
					end
				end

				arg_49_1.text_.text = var_52_16
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_20 = math.max(var_52_14, arg_49_1.talkMaxDuration)

			if var_52_13 <= arg_49_1.time_ and arg_49_1.time_ < var_52_13 + var_52_20 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_13) / var_52_20

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_13 + var_52_20 and arg_49_1.time_ < var_52_13 + var_52_20 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play425011013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 425011013
		arg_53_1.duration_ = 19.07

		local var_53_0 = {
			zh = 9.933,
			ja = 19.066
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
				arg_53_0:Play425011014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.275

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[36].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(425011013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 51
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011013", "story_v_out_425011.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011013", "story_v_out_425011.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_425011", "425011013", "story_v_out_425011.awb")

						arg_53_1:RecordAudio("425011013", var_56_9)
						arg_53_1:RecordAudio("425011013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_425011", "425011013", "story_v_out_425011.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_425011", "425011013", "story_v_out_425011.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play425011014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 425011014
		arg_57_1.duration_ = 3.28

		local var_57_0 = {
			zh = 3.275,
			ja = 3.166666666666
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
				arg_57_0:Play425011015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.8
			local var_60_1 = 1

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				local var_60_2 = "play"
				local var_60_3 = "effect"

				arg_57_1:AudioAction(var_60_2, var_60_3, "se_story_147", "se_story_147_electric_shock_02", "")
			end

			local var_60_4 = 0

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			local var_60_5 = 1

			if arg_57_1.time_ >= var_60_4 + var_60_5 and arg_57_1.time_ < var_60_4 + var_60_5 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			local var_60_6 = manager.ui.mainCamera.transform
			local var_60_7 = 0.8

			if var_60_7 < arg_57_1.time_ and arg_57_1.time_ <= var_60_7 + arg_60_0 then
				local var_60_8 = arg_57_1.var_.effect10091014
				local var_60_9
				local var_60_10 = var_60_6

				if not var_60_8 then
					var_60_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple2"), var_60_10)
					var_60_8.name = "1014"
					arg_57_1.var_.effect10091014 = var_60_8
				else
					var_60_8.transform:SetParent(var_60_10)
				end

				var_60_8.transform.localPosition = Vector3.New(0, 0.12, -1)
				var_60_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_60_11 = 0

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			local var_60_12 = 1.5

			if arg_57_1.time_ >= var_60_11 + var_60_12 and arg_57_1.time_ < var_60_11 + var_60_12 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			local var_60_13 = manager.ui.mainCamera.transform
			local var_60_14 = 0.733333333333333

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				local var_60_15 = arg_57_1.var_.effect100910141
				local var_60_16
				local var_60_17 = var_60_13

				if not var_60_15 then
					var_60_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_60_17)
					var_60_15.name = "10141"
					arg_57_1.var_.effect100910141 = var_60_15
				else
					var_60_15.transform:SetParent(var_60_17)
				end

				var_60_15.transform.localPosition = Vector3.New(0, 0, 6)
				var_60_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_60_18 = manager.ui.mainCamera.transform
			local var_60_19 = 2.16666666666667

			if var_60_19 < arg_57_1.time_ and arg_57_1.time_ <= var_60_19 + arg_60_0 then
				local var_60_20 = arg_57_1.var_.effect100910141

				if var_60_20 then
					Object.Destroy(var_60_20)

					arg_57_1.var_.effect100910141 = nil
				end
			end

			local var_60_21 = manager.ui.mainCamera.transform
			local var_60_22 = 0.8

			if var_60_22 < arg_57_1.time_ and arg_57_1.time_ <= var_60_22 + arg_60_0 then
				arg_57_1.var_.shakeOldPos = var_60_21.localPosition
			end

			local var_60_23 = 0.4

			if var_60_22 <= arg_57_1.time_ and arg_57_1.time_ < var_60_22 + var_60_23 then
				local var_60_24 = (arg_57_1.time_ - var_60_22) / 0.066
				local var_60_25, var_60_26 = math.modf(var_60_24)

				var_60_21.localPosition = Vector3.New(var_60_26 * 0.13, var_60_26 * 0.13, var_60_26 * 0.13) + arg_57_1.var_.shakeOldPos
			end

			if arg_57_1.time_ >= var_60_22 + var_60_23 and arg_57_1.time_ < var_60_22 + var_60_23 + arg_60_0 then
				var_60_21.localPosition = arg_57_1.var_.shakeOldPos
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_27 = 0.875
			local var_60_28 = 0.125

			if var_60_27 < arg_57_1.time_ and arg_57_1.time_ <= var_60_27 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_29 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_29:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_30 = arg_57_1:FormatText(StoryNameCfg[15].name)

				arg_57_1.leftNameTxt_.text = var_60_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_3")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_31 = arg_57_1:GetWordFromCfg(425011014)
				local var_60_32 = arg_57_1:FormatText(var_60_31.content)

				arg_57_1.text_.text = var_60_32

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_33 = 5
				local var_60_34 = utf8.len(var_60_32)
				local var_60_35 = var_60_33 <= 0 and var_60_28 or var_60_28 * (var_60_34 / var_60_33)

				if var_60_35 > 0 and var_60_28 < var_60_35 then
					arg_57_1.talkMaxDuration = var_60_35
					var_60_27 = var_60_27 + 0.3

					if var_60_35 + var_60_27 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_35 + var_60_27
					end
				end

				arg_57_1.text_.text = var_60_32
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011014", "story_v_out_425011.awb") ~= 0 then
					local var_60_36 = manager.audio:GetVoiceLength("story_v_out_425011", "425011014", "story_v_out_425011.awb") / 1000

					if var_60_36 + var_60_27 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_36 + var_60_27
					end

					if var_60_31.prefab_name ~= "" and arg_57_1.actors_[var_60_31.prefab_name] ~= nil then
						local var_60_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_31.prefab_name].transform, "story_v_out_425011", "425011014", "story_v_out_425011.awb")

						arg_57_1:RecordAudio("425011014", var_60_37)
						arg_57_1:RecordAudio("425011014", var_60_37)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_425011", "425011014", "story_v_out_425011.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_425011", "425011014", "story_v_out_425011.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_38 = var_60_27 + 0.3
			local var_60_39 = math.max(var_60_28, arg_57_1.talkMaxDuration)

			if var_60_38 <= arg_57_1.time_ and arg_57_1.time_ < var_60_38 + var_60_39 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_38) / var_60_39

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_38 + var_60_39 and arg_57_1.time_ < var_60_38 + var_60_39 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play425011015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 425011015
		arg_63_1.duration_ = 3

		local var_63_0 = {
			zh = 1.9,
			ja = 3
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play425011016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.2

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[36].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_3 = arg_63_1:GetWordFromCfg(425011015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 8
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011015", "story_v_out_425011.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011015", "story_v_out_425011.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_425011", "425011015", "story_v_out_425011.awb")

						arg_63_1:RecordAudio("425011015", var_66_9)
						arg_63_1:RecordAudio("425011015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_425011", "425011015", "story_v_out_425011.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_425011", "425011015", "story_v_out_425011.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_10 and arg_63_1.time_ < var_66_0 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play425011016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 425011016
		arg_67_1.duration_ = 6.17

		local var_67_0 = {
			zh = 6.166,
			ja = 4.166
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play425011017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.05

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[15].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_3")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(425011016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 2
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011016", "story_v_out_425011.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011016", "story_v_out_425011.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_425011", "425011016", "story_v_out_425011.awb")

						arg_67_1:RecordAudio("425011016", var_70_9)
						arg_67_1:RecordAudio("425011016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_425011", "425011016", "story_v_out_425011.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_425011", "425011016", "story_v_out_425011.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play425011017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 425011017
		arg_71_1.duration_ = 9.3

		local var_71_0 = {
			zh = 9.3,
			ja = 8.666
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play425011018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 1.125

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[36].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(425011017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 45
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011017", "story_v_out_425011.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011017", "story_v_out_425011.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_425011", "425011017", "story_v_out_425011.awb")

						arg_71_1:RecordAudio("425011017", var_74_9)
						arg_71_1:RecordAudio("425011017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_425011", "425011017", "story_v_out_425011.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_425011", "425011017", "story_v_out_425011.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_10 and arg_71_1.time_ < var_74_0 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play425011018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 425011018
		arg_75_1.duration_ = 4.23

		local var_75_0 = {
			zh = 4.233,
			ja = 2.3
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play425011019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.375

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[36].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(425011018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 15
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011018", "story_v_out_425011.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011018", "story_v_out_425011.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_425011", "425011018", "story_v_out_425011.awb")

						arg_75_1:RecordAudio("425011018", var_78_9)
						arg_75_1:RecordAudio("425011018", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_425011", "425011018", "story_v_out_425011.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_425011", "425011018", "story_v_out_425011.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_10 and arg_75_1.time_ < var_78_0 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play425011019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 425011019
		arg_79_1.duration_ = 5.64

		local var_79_0 = {
			zh = 5.64009019847401,
			ja = 5.00709019847401
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play425011020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				local var_82_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_82_2 then
					var_82_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_82_2.radialBlurScale = 1
					var_82_2.radialBlurGradient = 1
					var_82_2.radialBlurIntensity = 1

					if var_82_0 then
						var_82_2.radialBlurTarget = var_82_0.transform
					end
				end
			end

			local var_82_3 = 0.674090198474005

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_3 then
				local var_82_4 = (arg_79_1.time_ - var_82_1) / var_82_3
				local var_82_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_82_5 then
					var_82_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_82_5.radialBlurScale = Mathf.Lerp(1, 0, var_82_4)
					var_82_5.radialBlurGradient = Mathf.Lerp(1, 0, var_82_4)
					var_82_5.radialBlurIntensity = Mathf.Lerp(1, 0, var_82_4)
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_3 and arg_79_1.time_ < var_82_1 + var_82_3 + arg_82_0 then
				local var_82_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_82_6 then
					var_82_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_82_6.radialBlurScale = 0
					var_82_6.radialBlurGradient = 0
					var_82_6.radialBlurIntensity = 0
				end
			end

			local var_82_7 = 0

			if var_82_7 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			local var_82_8 = 0.774090198474005

			if arg_79_1.time_ >= var_82_7 + var_82_8 and arg_79_1.time_ < var_82_7 + var_82_8 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			local var_82_9 = manager.ui.mainCamera.transform
			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 then
				local var_82_11 = arg_79_1.var_.effect10091014

				if var_82_11 then
					Object.Destroy(var_82_11)

					arg_79_1.var_.effect10091014 = nil
				end
			end

			local var_82_12 = 0
			local var_82_13 = 1

			if var_82_12 < arg_79_1.time_ and arg_79_1.time_ <= var_82_12 + arg_82_0 then
				local var_82_14 = "stop"
				local var_82_15 = "effect"

				arg_79_1:AudioAction(var_82_14, var_82_15, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_16 = 0.674090198474005
			local var_82_17 = 0.1

			if var_82_16 < arg_79_1.time_ and arg_79_1.time_ <= var_82_16 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_18 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_18:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_19 = arg_79_1:FormatText(StoryNameCfg[15].name)

				arg_79_1.leftNameTxt_.text = var_82_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_20 = arg_79_1:GetWordFromCfg(425011019)
				local var_82_21 = arg_79_1:FormatText(var_82_20.content)

				arg_79_1.text_.text = var_82_21

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_22 = 4
				local var_82_23 = utf8.len(var_82_21)
				local var_82_24 = var_82_22 <= 0 and var_82_17 or var_82_17 * (var_82_23 / var_82_22)

				if var_82_24 > 0 and var_82_17 < var_82_24 then
					arg_79_1.talkMaxDuration = var_82_24
					var_82_16 = var_82_16 + 0.3

					if var_82_24 + var_82_16 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_24 + var_82_16
					end
				end

				arg_79_1.text_.text = var_82_21
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011019", "story_v_out_425011.awb") ~= 0 then
					local var_82_25 = manager.audio:GetVoiceLength("story_v_out_425011", "425011019", "story_v_out_425011.awb") / 1000

					if var_82_25 + var_82_16 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_25 + var_82_16
					end

					if var_82_20.prefab_name ~= "" and arg_79_1.actors_[var_82_20.prefab_name] ~= nil then
						local var_82_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_20.prefab_name].transform, "story_v_out_425011", "425011019", "story_v_out_425011.awb")

						arg_79_1:RecordAudio("425011019", var_82_26)
						arg_79_1:RecordAudio("425011019", var_82_26)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_425011", "425011019", "story_v_out_425011.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_425011", "425011019", "story_v_out_425011.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_27 = var_82_16 + 0.3
			local var_82_28 = math.max(var_82_17, arg_79_1.talkMaxDuration)

			if var_82_27 <= arg_79_1.time_ and arg_79_1.time_ < var_82_27 + var_82_28 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_27) / var_82_28

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_27 + var_82_28 and arg_79_1.time_ < var_82_27 + var_82_28 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play425011020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 425011020
		arg_85_1.duration_ = 6

		local var_85_0 = {
			zh = 4.466,
			ja = 6
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play425011021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.375

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[36].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(425011020)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 15
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011020", "story_v_out_425011.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011020", "story_v_out_425011.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_425011", "425011020", "story_v_out_425011.awb")

						arg_85_1:RecordAudio("425011020", var_88_9)
						arg_85_1:RecordAudio("425011020", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_425011", "425011020", "story_v_out_425011.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_425011", "425011020", "story_v_out_425011.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_10 and arg_85_1.time_ < var_88_0 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play425011021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 425011021
		arg_89_1.duration_ = 3.27

		local var_89_0 = {
			zh = 2.566,
			ja = 3.266
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
				arg_89_0:Play425011022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.15

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[15].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(425011021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 6
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011021", "story_v_out_425011.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011021", "story_v_out_425011.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_425011", "425011021", "story_v_out_425011.awb")

						arg_89_1:RecordAudio("425011021", var_92_9)
						arg_89_1:RecordAudio("425011021", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_425011", "425011021", "story_v_out_425011.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_425011", "425011021", "story_v_out_425011.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play425011022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 425011022
		arg_93_1.duration_ = 5.53

		local var_93_0 = {
			zh = 5.3,
			ja = 5.533
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
				arg_93_0:Play425011023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.525

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[36].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(425011022)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 21
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011022", "story_v_out_425011.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011022", "story_v_out_425011.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_425011", "425011022", "story_v_out_425011.awb")

						arg_93_1:RecordAudio("425011022", var_96_9)
						arg_93_1:RecordAudio("425011022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_425011", "425011022", "story_v_out_425011.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_425011", "425011022", "story_v_out_425011.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play425011023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 425011023
		arg_97_1.duration_ = 5.2

		local var_97_0 = {
			zh = 4,
			ja = 5.2
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
				arg_97_0:Play425011024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.4

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[15].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(425011023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 16
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011023", "story_v_out_425011.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011023", "story_v_out_425011.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_425011", "425011023", "story_v_out_425011.awb")

						arg_97_1:RecordAudio("425011023", var_100_9)
						arg_97_1:RecordAudio("425011023", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_425011", "425011023", "story_v_out_425011.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_425011", "425011023", "story_v_out_425011.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play425011024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 425011024
		arg_101_1.duration_ = 17.43

		local var_101_0 = {
			zh = 11.133,
			ja = 17.433
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play425011025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.075

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[36].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:GetWordFromCfg(425011024)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 43
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_1 or var_104_1 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_1 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011024", "story_v_out_425011.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011024", "story_v_out_425011.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_425011", "425011024", "story_v_out_425011.awb")

						arg_101_1:RecordAudio("425011024", var_104_9)
						arg_101_1:RecordAudio("425011024", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_425011", "425011024", "story_v_out_425011.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_425011", "425011024", "story_v_out_425011.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_10 and arg_101_1.time_ < var_104_0 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play425011025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 425011025
		arg_105_1.duration_ = 46.24

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play425011033(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_1 = 1.2

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_1 then
				local var_108_2 = (arg_105_1.time_ - var_108_0) / var_108_1
				local var_108_3 = Color.New(0, 0, 0)

				var_108_3.a = Mathf.Lerp(0, 1, var_108_2)
				arg_105_1.mask_.color = var_108_3
			end

			if arg_105_1.time_ >= var_108_0 + var_108_1 and arg_105_1.time_ < var_108_0 + var_108_1 + arg_108_0 then
				local var_108_4 = Color.New(0, 0, 0)

				var_108_4.a = 1
				arg_105_1.mask_.color = var_108_4
			end

			local var_108_5 = 1.2

			if var_108_5 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_6 = 1.2

			if var_108_5 <= arg_105_1.time_ and arg_105_1.time_ < var_108_5 + var_108_6 then
				local var_108_7 = (arg_105_1.time_ - var_108_5) / var_108_6
				local var_108_8 = Color.New(0, 0, 0)

				var_108_8.a = Mathf.Lerp(1, 0, var_108_7)
				arg_105_1.mask_.color = var_108_8
			end

			if arg_105_1.time_ >= var_108_5 + var_108_6 and arg_105_1.time_ < var_108_5 + var_108_6 + arg_108_0 then
				local var_108_9 = Color.New(0, 0, 0)
				local var_108_10 = 0

				arg_105_1.mask_.enabled = false
				var_108_9.a = var_108_10
				arg_105_1.mask_.color = var_108_9
			end

			local var_108_11 = 1.2

			if var_108_11 < arg_105_1.time_ and arg_105_1.time_ <= var_108_11 + arg_108_0 then
				SetActive(arg_105_1.dialog_, false)
				SetActive(arg_105_1.allBtn_.gameObject, false)
				arg_105_1.hideBtnsController_:SetSelectedIndex(1)
				arg_105_1:PlayOnlyBgm()

				arg_105_1.marker = "stop1"

				manager.video:Play("SofdecAsset/story/story_104250101.usm", function(arg_109_0)
					if arg_105_1.state_ == "playing" then
						arg_105_1:JumpToEnd()
					end

					if arg_105_1.playNext_ and not arg_105_1.auto_ then
						arg_105_1.playNext_(1)
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_110_0)
					if arg_110_0 then
						arg_105_1.state_ = "pause"
					else
						arg_105_1.state_ = "playing"
					end
				end, 10425011)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_108_12 = 45.0416666666667

			if var_108_11 <= arg_105_1.time_ and arg_105_1.time_ < var_108_11 + var_108_12 then
				-- block empty
			end

			if arg_105_1.time_ >= var_108_11 + var_108_12 and arg_105_1.time_ < var_108_11 + var_108_12 + arg_108_0 then
				arg_105_1.marker = ""
			end

			local var_108_13
			local var_108_14 = 0

			if var_108_14 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 then
				local var_108_15 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_108_15 then
					var_108_15.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_108_15.radialBlurScale = 0
					var_108_15.radialBlurGradient = 0
					var_108_15.radialBlurIntensity = 0

					if var_108_13 then
						var_108_15.radialBlurTarget = var_108_13.transform
					end
				end
			end

			local var_108_16 = 0.0166666666666667

			if var_108_14 <= arg_105_1.time_ and arg_105_1.time_ < var_108_14 + var_108_16 then
				local var_108_17 = (arg_105_1.time_ - var_108_14) / var_108_16
				local var_108_18 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_108_18 then
					var_108_18.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_108_18.radialBlurScale = Mathf.Lerp(0, 0, var_108_17)
					var_108_18.radialBlurGradient = Mathf.Lerp(0, 0, var_108_17)
					var_108_18.radialBlurIntensity = Mathf.Lerp(0, 0, var_108_17)
				end
			end

			if arg_105_1.time_ >= var_108_14 + var_108_16 and arg_105_1.time_ < var_108_14 + var_108_16 + arg_108_0 then
				local var_108_19 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_108_19 then
					var_108_19.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_108_19.radialBlurScale = 0
					var_108_19.radialBlurGradient = 0
					var_108_19.radialBlurIntensity = 0
				end
			end

			local var_108_20 = manager.ui.mainCamera.transform
			local var_108_21 = 0

			if var_108_21 < arg_105_1.time_ and arg_105_1.time_ <= var_108_21 + arg_108_0 then
				local var_108_22 = arg_105_1.var_.effect1001

				if var_108_22 then
					Object.Destroy(var_108_22)

					arg_105_1.var_.effect1001 = nil
				end
			end

			local var_108_23 = 1.2
			local var_108_24 = 1

			if var_108_23 < arg_105_1.time_ and arg_105_1.time_ <= var_108_23 + arg_108_0 then
				local var_108_25 = "stop"
				local var_108_26 = "effect"

				arg_105_1:AudioAction(var_108_25, var_108_26, "se_story_147", "se_story_147_amb_interrogation", "")
			end

			local var_108_27 = manager.ui.mainCamera.transform
			local var_108_28 = 1.2

			if var_108_28 < arg_105_1.time_ and arg_105_1.time_ <= var_108_28 + arg_108_0 then
				local var_108_29 = arg_105_1.var_.effect10091009

				if var_108_29 then
					Object.Destroy(var_108_29)

					arg_105_1.var_.effect10091009 = nil
				end
			end

			local var_108_30 = 1.2
			local var_108_31 = 1

			if var_108_30 < arg_105_1.time_ and arg_105_1.time_ <= var_108_30 + arg_108_0 then
				local var_108_32 = "stop"
				local var_108_33 = "effect"

				arg_105_1:AudioAction(var_108_32, var_108_33, "story_v_out_424021", "425011024", "story_v_out_424021.awb")
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play425011033 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 425011033
		arg_111_1.duration_ = 9.87

		local var_111_0 = {
			zh = 7.60000033333333,
			ja = 9.86600033333333
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play425011034(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 5.60000033333333

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			local var_114_1 = 0.2

			if arg_111_1.time_ >= var_114_0 + var_114_1 and arg_111_1.time_ < var_114_0 + var_114_1 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			local var_114_2 = 0

			if var_114_2 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_3 = 1.2

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_3 then
				local var_114_4 = (arg_111_1.time_ - var_114_2) / var_114_3
				local var_114_5 = Color.New(0, 0, 0)

				var_114_5.a = Mathf.Lerp(0, 1, var_114_4)
				arg_111_1.mask_.color = var_114_5
			end

			if arg_111_1.time_ >= var_114_2 + var_114_3 and arg_111_1.time_ < var_114_2 + var_114_3 + arg_114_0 then
				local var_114_6 = Color.New(0, 0, 0)

				var_114_6.a = 1
				arg_111_1.mask_.color = var_114_6
			end

			local var_114_7 = 1.2

			if var_114_7 < arg_111_1.time_ and arg_111_1.time_ <= var_114_7 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_8 = 1.2

			if var_114_7 <= arg_111_1.time_ and arg_111_1.time_ < var_114_7 + var_114_8 then
				local var_114_9 = (arg_111_1.time_ - var_114_7) / var_114_8
				local var_114_10 = Color.New(0, 0, 0)

				var_114_10.a = Mathf.Lerp(1, 0, var_114_9)
				arg_111_1.mask_.color = var_114_10
			end

			if arg_111_1.time_ >= var_114_7 + var_114_8 and arg_111_1.time_ < var_114_7 + var_114_8 + arg_114_0 then
				local var_114_11 = Color.New(0, 0, 0)
				local var_114_12 = 0

				arg_111_1.mask_.enabled = false
				var_114_11.a = var_114_12
				arg_111_1.mask_.color = var_114_11
			end

			local var_114_13 = 4.40000033333333

			if var_114_13 < arg_111_1.time_ and arg_111_1.time_ <= var_114_13 + arg_114_0 then
				arg_111_1.fswbg_:SetActive(false)
				arg_111_1.dialog_:SetActive(false)
				SetActive(arg_111_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_111_1:ShowNextGo(false)
			end

			local var_114_14 = 1.2

			if var_114_14 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 then
				SetActive(arg_111_1.dialog_, true)
				SetActive(arg_111_1.allBtn_.gameObject, true)
				arg_111_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_111_1.isInLoopVideo = false
			end

			local var_114_15 = 0.0166666666666667

			if var_114_14 <= arg_111_1.time_ and arg_111_1.time_ < var_114_14 + var_114_15 then
				-- block empty
			end

			if arg_111_1.time_ >= var_114_14 + var_114_15 and arg_111_1.time_ < var_114_14 + var_114_15 + arg_114_0 then
				arg_111_1.marker = ""
			end

			local var_114_16 = 1.2
			local var_114_17 = 1.999999999999
			local var_114_18 = "M01K"

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 then
				arg_111_1.timestampController_:SetSelectedState("show")
				arg_111_1.timestampAni_:Play("in")

				arg_111_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_114_18)

				arg_111_1.timestampColorController_:SetSelectedState("hot")
				arg_111_1.timeColdImg_:SetAlpha(0.031)

				local var_114_19 = arg_111_1:GetWordFromCfg(501098)
				local var_114_20 = arg_111_1:FormatText(var_114_19.content)

				arg_111_1.text_timeText_.text = var_114_20

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_timeText_)

				local var_114_21 = arg_111_1:GetWordFromCfg(501099)
				local var_114_22 = arg_111_1:FormatText(var_114_21.content)

				arg_111_1.text_siteText_.text = var_114_22

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_siteText_)
			end

			if arg_111_1.time_ >= var_114_16 + var_114_17 and arg_111_1.time_ < var_114_16 + var_114_17 + arg_114_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_111_1.timestampAni_, "out", function()
					arg_111_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_114_23 = 3.20000033333333

			if var_114_23 < arg_111_1.time_ and arg_111_1.time_ <= var_114_23 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_24 = 1.2

			if var_114_23 <= arg_111_1.time_ and arg_111_1.time_ < var_114_23 + var_114_24 then
				local var_114_25 = (arg_111_1.time_ - var_114_23) / var_114_24
				local var_114_26 = Color.New(0, 0, 0)

				var_114_26.a = Mathf.Lerp(0, 1, var_114_25)
				arg_111_1.mask_.color = var_114_26
			end

			if arg_111_1.time_ >= var_114_23 + var_114_24 and arg_111_1.time_ < var_114_23 + var_114_24 + arg_114_0 then
				local var_114_27 = Color.New(0, 0, 0)

				var_114_27.a = 1
				arg_111_1.mask_.color = var_114_27
			end

			local var_114_28 = 4.40000033333333

			if var_114_28 < arg_111_1.time_ and arg_111_1.time_ <= var_114_28 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_29 = 1.2

			if var_114_28 <= arg_111_1.time_ and arg_111_1.time_ < var_114_28 + var_114_29 then
				local var_114_30 = (arg_111_1.time_ - var_114_28) / var_114_29
				local var_114_31 = Color.New(0, 0, 0)

				var_114_31.a = Mathf.Lerp(1, 0, var_114_30)
				arg_111_1.mask_.color = var_114_31
			end

			if arg_111_1.time_ >= var_114_28 + var_114_29 and arg_111_1.time_ < var_114_28 + var_114_29 + arg_114_0 then
				local var_114_32 = Color.New(0, 0, 0)
				local var_114_33 = 0

				arg_111_1.mask_.enabled = false
				var_114_32.a = var_114_33
				arg_111_1.mask_.color = var_114_32
			end

			local var_114_34 = "M01K"

			if arg_111_1.bgs_[var_114_34] == nil then
				local var_114_35 = Object.Instantiate(arg_111_1.paintGo_)

				var_114_35:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_114_34)
				var_114_35.name = var_114_34
				var_114_35.transform.parent = arg_111_1.stage_.transform
				var_114_35.transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.bgs_[var_114_34] = var_114_35
			end

			local var_114_36 = 1.2

			if var_114_36 < arg_111_1.time_ and arg_111_1.time_ <= var_114_36 + arg_114_0 then
				local var_114_37 = manager.ui.mainCamera.transform.localPosition
				local var_114_38 = Vector3.New(0, 0, 10) + Vector3.New(var_114_37.x, var_114_37.y, 0)
				local var_114_39 = arg_111_1.bgs_.M01K

				var_114_39.transform.localPosition = var_114_38
				var_114_39.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_114_40 = var_114_39:GetComponent("SpriteRenderer")

				if var_114_40 and var_114_40.sprite then
					local var_114_41 = (var_114_39.transform.localPosition - var_114_37).z
					local var_114_42 = manager.ui.mainCameraCom_
					local var_114_43 = 2 * var_114_41 * Mathf.Tan(var_114_42.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_114_44 = var_114_43 * var_114_42.aspect
					local var_114_45 = var_114_40.sprite.bounds.size.x
					local var_114_46 = var_114_40.sprite.bounds.size.y
					local var_114_47 = var_114_44 / var_114_45
					local var_114_48 = var_114_43 / var_114_46
					local var_114_49 = var_114_48 < var_114_47 and var_114_47 or var_114_48

					var_114_39.transform.localScale = Vector3.New(var_114_49, var_114_49, 0)
				end

				for iter_114_0, iter_114_1 in pairs(arg_111_1.bgs_) do
					if iter_114_0 ~= "M01K" then
						iter_114_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_114_50
			local var_114_51 = 1.2

			if var_114_51 < arg_111_1.time_ and arg_111_1.time_ <= var_114_51 + arg_114_0 then
				local var_114_52 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_114_52 then
					var_114_52.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_114_52.radialBlurScale = 0
					var_114_52.radialBlurGradient = 0
					var_114_52.radialBlurIntensity = 0

					if var_114_50 then
						var_114_52.radialBlurTarget = var_114_50.transform
					end
				end
			end

			local var_114_53 = 0.0166666666666667

			if var_114_51 <= arg_111_1.time_ and arg_111_1.time_ < var_114_51 + var_114_53 then
				local var_114_54 = (arg_111_1.time_ - var_114_51) / var_114_53
				local var_114_55 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_114_55 then
					var_114_55.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_114_55.radialBlurScale = Mathf.Lerp(0, 0, var_114_54)
					var_114_55.radialBlurGradient = Mathf.Lerp(0, 0, var_114_54)
					var_114_55.radialBlurIntensity = Mathf.Lerp(0, 0, var_114_54)
				end
			end

			if arg_111_1.time_ >= var_114_51 + var_114_53 and arg_111_1.time_ < var_114_51 + var_114_53 + arg_114_0 then
				local var_114_56 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_114_56 then
					var_114_56.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_114_56.radialBlurScale = 0
					var_114_56.radialBlurGradient = 0
					var_114_56.radialBlurIntensity = 0
				end
			end

			local var_114_57 = 1.2
			local var_114_58 = 0.3

			if var_114_57 < arg_111_1.time_ and arg_111_1.time_ <= var_114_57 + arg_114_0 then
				local var_114_59 = "play"
				local var_114_60 = "music"

				arg_111_1:AudioAction(var_114_59, var_114_60, "ui_battle", "ui_battle_stopbgm", "")

				local var_114_61 = ""
				local var_114_62 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_114_62 ~= "" then
					if arg_111_1.bgmTxt_.text ~= var_114_62 and arg_111_1.bgmTxt_.text ~= "" then
						if arg_111_1.bgmTxt2_.text ~= "" then
							arg_111_1.bgmTxt_.text = arg_111_1.bgmTxt2_.text
						end

						arg_111_1.bgmTxt2_.text = var_114_62

						arg_111_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_111_1.bgmTxt_.text = var_114_62
						arg_111_1.bgmTxt2_.text = var_114_62
					end

					if arg_111_1.bgmTimer then
						arg_111_1.bgmTimer:Stop()

						arg_111_1.bgmTimer = nil
					end

					if arg_111_1.settingData.show_music_name == 1 then
						arg_111_1.musicController:SetSelectedState("show")
						arg_111_1.musicAnimator_:Play("open", 0, 0)

						if arg_111_1.settingData.music_time ~= 0 then
							arg_111_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_111_1.settingData.music_time), function()
								if arg_111_1 == nil or isNil(arg_111_1.bgmTxt_) then
									return
								end

								arg_111_1.musicController:SetSelectedState("hide")
								arg_111_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_114_63 = 4.1
			local var_114_64 = 1

			if var_114_63 < arg_111_1.time_ and arg_111_1.time_ <= var_114_63 + arg_114_0 then
				local var_114_65 = "play"
				local var_114_66 = "effect"

				arg_111_1:AudioAction(var_114_65, var_114_66, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_114_67 = 4.1
			local var_114_68 = 1

			if var_114_67 < arg_111_1.time_ and arg_111_1.time_ <= var_114_67 + arg_114_0 then
				local var_114_69 = "play"
				local var_114_70 = "effect"

				arg_111_1:AudioAction(var_114_69, var_114_70, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_71 = 5.60000033333333
			local var_114_72 = 0.2

			if var_114_71 < arg_111_1.time_ and arg_111_1.time_ <= var_114_71 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_73 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_73:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_111_1.dialogCg_.alpha = arg_117_0
				end))
				var_114_73:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_73:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_74 = arg_111_1:FormatText(StoryNameCfg[1430].name)

				arg_111_1.leftNameTxt_.text = var_114_74

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_75 = arg_111_1:GetWordFromCfg(425011033)
				local var_114_76 = arg_111_1:FormatText(var_114_75.content)

				arg_111_1.text_.text = var_114_76

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_77 = 8
				local var_114_78 = utf8.len(var_114_76)
				local var_114_79 = var_114_77 <= 0 and var_114_72 or var_114_72 * (var_114_78 / var_114_77)

				if var_114_79 > 0 and var_114_72 < var_114_79 then
					arg_111_1.talkMaxDuration = var_114_79
					var_114_71 = var_114_71 + 0.3

					if var_114_79 + var_114_71 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_79 + var_114_71
					end
				end

				arg_111_1.text_.text = var_114_76
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011033", "story_v_out_425011.awb") ~= 0 then
					local var_114_80 = manager.audio:GetVoiceLength("story_v_out_425011", "425011033", "story_v_out_425011.awb") / 1000

					if var_114_80 + var_114_71 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_80 + var_114_71
					end

					if var_114_75.prefab_name ~= "" and arg_111_1.actors_[var_114_75.prefab_name] ~= nil then
						local var_114_81 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_75.prefab_name].transform, "story_v_out_425011", "425011033", "story_v_out_425011.awb")

						arg_111_1:RecordAudio("425011033", var_114_81)
						arg_111_1:RecordAudio("425011033", var_114_81)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_425011", "425011033", "story_v_out_425011.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_425011", "425011033", "story_v_out_425011.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_82 = var_114_71 + 0.3
			local var_114_83 = math.max(var_114_72, arg_111_1.talkMaxDuration)

			if var_114_82 <= arg_111_1.time_ and arg_111_1.time_ < var_114_82 + var_114_83 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_82) / var_114_83

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_82 + var_114_83 and arg_111_1.time_ < var_114_82 + var_114_83 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play425011034 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 425011034
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play425011035(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = manager.ui.mainCamera.transform
			local var_122_1 = 1

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.shakeOldPos = var_122_0.localPosition
			end

			local var_122_2 = 0.8

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / 0.066
				local var_122_4, var_122_5 = math.modf(var_122_3)

				var_122_0.localPosition = Vector3.New(var_122_5 * 0.13, var_122_5 * 0.13, var_122_5 * 0.13) + arg_119_1.var_.shakeOldPos
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = arg_119_1.var_.shakeOldPos
			end

			local var_122_6 = manager.ui.mainCamera.transform
			local var_122_7 = 1

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 then
				local var_122_8 = arg_119_1.var_.effect10091034
				local var_122_9
				local var_122_10 = var_122_6

				if not var_122_8 then
					var_122_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), var_122_10)
					var_122_8.name = "1034"
					arg_119_1.var_.effect10091034 = var_122_8
				else
					var_122_8.transform:SetParent(var_122_10)
				end

				var_122_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_122_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_122_11 = manager.ui.mainCamera.transform
			local var_122_12 = 2.43333333333333

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				local var_122_13 = arg_119_1.var_.effect10091009

				if var_122_13 then
					Object.Destroy(var_122_13)

					arg_119_1.var_.effect10091009 = nil
				end
			end

			local var_122_14 = 0

			if var_122_14 < arg_119_1.time_ and arg_119_1.time_ <= var_122_14 + arg_122_0 then
				arg_119_1.allBtn_.enabled = false
			end

			local var_122_15 = 2.43333333333333

			if arg_119_1.time_ >= var_122_14 + var_122_15 and arg_119_1.time_ < var_122_14 + var_122_15 + arg_122_0 then
				arg_119_1.allBtn_.enabled = true
			end

			local var_122_16 = 0.5
			local var_122_17 = 1

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				local var_122_18 = "play"
				local var_122_19 = "effect"

				arg_119_1:AudioAction(var_122_18, var_122_19, "se_story_147", "se_story_147_alarm", "")
			end

			local var_122_20 = 1
			local var_122_21 = 1

			if var_122_20 < arg_119_1.time_ and arg_119_1.time_ <= var_122_20 + arg_122_0 then
				local var_122_22 = "play"
				local var_122_23 = "effect"

				arg_119_1:AudioAction(var_122_22, var_122_23, "se_story_140", "se_story_140_amb_battle monster", "")
			end

			local var_122_24 = 0
			local var_122_25 = 0.3

			if var_122_24 < arg_119_1.time_ and arg_119_1.time_ <= var_122_24 + arg_122_0 then
				local var_122_26 = "play"
				local var_122_27 = "music"

				arg_119_1:AudioAction(var_122_26, var_122_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_122_28 = ""
				local var_122_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_122_29 ~= "" then
					if arg_119_1.bgmTxt_.text ~= var_122_29 and arg_119_1.bgmTxt_.text ~= "" then
						if arg_119_1.bgmTxt2_.text ~= "" then
							arg_119_1.bgmTxt_.text = arg_119_1.bgmTxt2_.text
						end

						arg_119_1.bgmTxt2_.text = var_122_29

						arg_119_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_119_1.bgmTxt_.text = var_122_29
						arg_119_1.bgmTxt2_.text = var_122_29
					end

					if arg_119_1.bgmTimer then
						arg_119_1.bgmTimer:Stop()

						arg_119_1.bgmTimer = nil
					end

					if arg_119_1.settingData.show_music_name == 1 then
						arg_119_1.musicController:SetSelectedState("show")
						arg_119_1.musicAnimator_:Play("open", 0, 0)

						if arg_119_1.settingData.music_time ~= 0 then
							arg_119_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_119_1.settingData.music_time), function()
								if arg_119_1 == nil or isNil(arg_119_1.bgmTxt_) then
									return
								end

								arg_119_1.musicController:SetSelectedState("hide")
								arg_119_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_122_30 = 0.500666666666667
			local var_122_31 = 1

			if var_122_30 < arg_119_1.time_ and arg_119_1.time_ <= var_122_30 + arg_122_0 then
				local var_122_32 = "play"
				local var_122_33 = "music"

				arg_119_1:AudioAction(var_122_32, var_122_33, "bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy.awb")

				local var_122_34 = ""
				local var_122_35 = manager.audio:GetAudioName("bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy")

				if var_122_35 ~= "" then
					if arg_119_1.bgmTxt_.text ~= var_122_35 and arg_119_1.bgmTxt_.text ~= "" then
						if arg_119_1.bgmTxt2_.text ~= "" then
							arg_119_1.bgmTxt_.text = arg_119_1.bgmTxt2_.text
						end

						arg_119_1.bgmTxt2_.text = var_122_35

						arg_119_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_119_1.bgmTxt_.text = var_122_35
						arg_119_1.bgmTxt2_.text = var_122_35
					end

					if arg_119_1.bgmTimer then
						arg_119_1.bgmTimer:Stop()

						arg_119_1.bgmTimer = nil
					end

					if arg_119_1.settingData.show_music_name == 1 then
						arg_119_1.musicController:SetSelectedState("show")
						arg_119_1.musicAnimator_:Play("open", 0, 0)

						if arg_119_1.settingData.music_time ~= 0 then
							arg_119_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_119_1.settingData.music_time), function()
								if arg_119_1 == nil or isNil(arg_119_1.bgmTxt_) then
									return
								end

								arg_119_1.musicController:SetSelectedState("hide")
								arg_119_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_122_36 = manager.ui.mainCamera.transform
			local var_122_37 = 0

			if var_122_37 < arg_119_1.time_ and arg_119_1.time_ <= var_122_37 + arg_122_0 then
				local var_122_38 = arg_119_1.var_.effect100910344
				local var_122_39
				local var_122_40 = var_122_36

				if not var_122_38 then
					var_122_38 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), var_122_40)
					var_122_38.name = "10344"
					arg_119_1.var_.effect100910344 = var_122_38
				else
					var_122_38.transform:SetParent(var_122_40)
				end

				var_122_38.transform.localPosition = Vector3.New(0, 0, -2)
				var_122_38.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_122_41 = 1.7777777777777777
				local var_122_42 = Screen.width / Screen.height
				local var_122_43 = var_122_42 / var_122_41
				local var_122_44 = Mathf.Max(var_122_41 / var_122_42, 1)

				var_122_38.transform.localScale = Vector3.New(var_122_38.transform.localScale.x * var_122_43, var_122_38.transform.localScale.y * var_122_44, var_122_38.transform.localScale.z)
			end

			local var_122_45 = 1.06666666666667
			local var_122_46 = 0.933333333333333

			if var_122_45 < arg_119_1.time_ and arg_119_1.time_ <= var_122_45 + arg_122_0 then
				local var_122_47 = "play"
				local var_122_48 = "effect"

				arg_119_1:AudioAction(var_122_47, var_122_48, "se_story_147", "se_story_147_battle_down", "")
			end

			local var_122_49 = 0
			local var_122_50 = 1.025

			if var_122_49 < arg_119_1.time_ and arg_119_1.time_ <= var_122_49 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_51 = arg_119_1:GetWordFromCfg(425011034)
				local var_122_52 = arg_119_1:FormatText(var_122_51.content)

				arg_119_1.text_.text = var_122_52

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_53 = 41
				local var_122_54 = utf8.len(var_122_52)
				local var_122_55 = var_122_53 <= 0 and var_122_50 or var_122_50 * (var_122_54 / var_122_53)

				if var_122_55 > 0 and var_122_50 < var_122_55 then
					arg_119_1.talkMaxDuration = var_122_55

					if var_122_55 + var_122_49 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_55 + var_122_49
					end
				end

				arg_119_1.text_.text = var_122_52
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_56 = math.max(var_122_50, arg_119_1.talkMaxDuration)

			if var_122_49 <= arg_119_1.time_ and arg_119_1.time_ < var_122_49 + var_122_56 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_49) / var_122_56

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_49 + var_122_56 and arg_119_1.time_ < var_122_49 + var_122_56 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play425011035 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 425011035
		arg_125_1.duration_ = 6.87

		local var_125_0 = {
			zh = 4.733,
			ja = 6.866
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
				arg_125_0:Play425011036(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = manager.ui.mainCamera.transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				local var_128_2 = arg_125_1.var_.effect100910344

				if var_128_2 then
					Object.Destroy(var_128_2)

					arg_125_1.var_.effect100910344 = nil
				end
			end

			local var_128_3 = 0
			local var_128_4 = 0.625

			if var_128_3 < arg_125_1.time_ and arg_125_1.time_ <= var_128_3 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_5 = arg_125_1:FormatText(StoryNameCfg[1430].name)

				arg_125_1.leftNameTxt_.text = var_128_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_6 = arg_125_1:GetWordFromCfg(425011035)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_8 = 25
				local var_128_9 = utf8.len(var_128_7)
				local var_128_10 = var_128_8 <= 0 and var_128_4 or var_128_4 * (var_128_9 / var_128_8)

				if var_128_10 > 0 and var_128_4 < var_128_10 then
					arg_125_1.talkMaxDuration = var_128_10

					if var_128_10 + var_128_3 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_3
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011035", "story_v_out_425011.awb") ~= 0 then
					local var_128_11 = manager.audio:GetVoiceLength("story_v_out_425011", "425011035", "story_v_out_425011.awb") / 1000

					if var_128_11 + var_128_3 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_3
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_425011", "425011035", "story_v_out_425011.awb")

						arg_125_1:RecordAudio("425011035", var_128_12)
						arg_125_1:RecordAudio("425011035", var_128_12)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_425011", "425011035", "story_v_out_425011.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_425011", "425011035", "story_v_out_425011.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_13 = math.max(var_128_4, arg_125_1.talkMaxDuration)

			if var_128_3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_3 + var_128_13 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_3) / var_128_13

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_3 + var_128_13 and arg_125_1.time_ < var_128_3 + var_128_13 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play425011036 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 425011036
		arg_129_1.duration_ = 1.27

		local var_129_0 = {
			zh = 1.066,
			ja = 1.266
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
				arg_129_0:Play425011037(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.075

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[688].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(425011036)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 3
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011036", "story_v_out_425011.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011036", "story_v_out_425011.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_425011", "425011036", "story_v_out_425011.awb")

						arg_129_1:RecordAudio("425011036", var_132_9)
						arg_129_1:RecordAudio("425011036", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_425011", "425011036", "story_v_out_425011.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_425011", "425011036", "story_v_out_425011.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_10 and arg_129_1.time_ < var_132_0 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play425011037 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 425011037
		arg_133_1.duration_ = 5.53

		local var_133_0 = {
			zh = 3.466,
			ja = 5.533
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
				arg_133_0:Play425011038(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.475

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[688].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:GetWordFromCfg(425011037)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 19
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011037", "story_v_out_425011.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011037", "story_v_out_425011.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_425011", "425011037", "story_v_out_425011.awb")

						arg_133_1:RecordAudio("425011037", var_136_9)
						arg_133_1:RecordAudio("425011037", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_425011", "425011037", "story_v_out_425011.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_425011", "425011037", "story_v_out_425011.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play425011038 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 425011038
		arg_137_1.duration_ = 1.4

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play425011039(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.225

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[1430].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:GetWordFromCfg(425011038)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 9
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011038", "story_v_out_425011.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011038", "story_v_out_425011.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_425011", "425011038", "story_v_out_425011.awb")

						arg_137_1:RecordAudio("425011038", var_140_9)
						arg_137_1:RecordAudio("425011038", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_425011", "425011038", "story_v_out_425011.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_425011", "425011038", "story_v_out_425011.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_10 and arg_137_1.time_ < var_140_0 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play425011039 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 425011039
		arg_141_1.duration_ = 1

		local var_141_0 = {
			zh = 0.999999999999,
			ja = 1
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
				arg_141_0:Play425011040(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.075

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[688].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:GetWordFromCfg(425011039)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 3
				local var_144_6 = utf8.len(var_144_4)
				local var_144_7 = var_144_5 <= 0 and var_144_1 or var_144_1 * (var_144_6 / var_144_5)

				if var_144_7 > 0 and var_144_1 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011039", "story_v_out_425011.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011039", "story_v_out_425011.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_425011", "425011039", "story_v_out_425011.awb")

						arg_141_1:RecordAudio("425011039", var_144_9)
						arg_141_1:RecordAudio("425011039", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_425011", "425011039", "story_v_out_425011.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_425011", "425011039", "story_v_out_425011.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_10 and arg_141_1.time_ < var_144_0 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play425011040 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 425011040
		arg_145_1.duration_ = 4.1

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play425011041(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.45

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[1430].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:GetWordFromCfg(425011040)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 18
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011040", "story_v_out_425011.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011040", "story_v_out_425011.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_425011", "425011040", "story_v_out_425011.awb")

						arg_145_1:RecordAudio("425011040", var_148_9)
						arg_145_1:RecordAudio("425011040", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_425011", "425011040", "story_v_out_425011.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_425011", "425011040", "story_v_out_425011.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play425011041 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 425011041
		arg_149_1.duration_ = 5.57

		local var_149_0 = {
			zh = 3,
			ja = 5.566
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
				arg_149_0:Play425011042(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = "1086"

			if arg_149_1.actors_[var_152_0] == nil then
				local var_152_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_152_1) then
					local var_152_2 = Object.Instantiate(var_152_1, arg_149_1.canvasGo_.transform)

					var_152_2.transform:SetSiblingIndex(1)

					var_152_2.name = var_152_0
					var_152_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_149_1.actors_[var_152_0] = var_152_2

					local var_152_3 = var_152_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_149_1.isInRecall_ then
						for iter_152_0, iter_152_1 in ipairs(var_152_3) do
							iter_152_1.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_152_4 = arg_149_1.actors_["1086"]
			local var_152_5 = 0

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.actorSpriteComps1086 == nil then
				arg_149_1.var_.actorSpriteComps1086 = var_152_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_6 = 0.2

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_6 and not isNil(var_152_4) then
				local var_152_7 = (arg_149_1.time_ - var_152_5) / var_152_6

				if arg_149_1.var_.actorSpriteComps1086 then
					for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_152_3 then
							if arg_149_1.isInRecall_ then
								local var_152_8 = Mathf.Lerp(iter_152_3.color.r, arg_149_1.hightColor1.r, var_152_7)
								local var_152_9 = Mathf.Lerp(iter_152_3.color.g, arg_149_1.hightColor1.g, var_152_7)
								local var_152_10 = Mathf.Lerp(iter_152_3.color.b, arg_149_1.hightColor1.b, var_152_7)

								iter_152_3.color = Color.New(var_152_8, var_152_9, var_152_10)
							else
								local var_152_11 = Mathf.Lerp(iter_152_3.color.r, 1, var_152_7)

								iter_152_3.color = Color.New(var_152_11, var_152_11, var_152_11)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_5 + var_152_6 and arg_149_1.time_ < var_152_5 + var_152_6 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.actorSpriteComps1086 then
				for iter_152_4, iter_152_5 in pairs(arg_149_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_152_5 then
						if arg_149_1.isInRecall_ then
							iter_152_5.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_152_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps1086 = nil
			end

			local var_152_12 = arg_149_1.actors_["1086"].transform
			local var_152_13 = 0

			if var_152_13 < arg_149_1.time_ and arg_149_1.time_ <= var_152_13 + arg_152_0 then
				arg_149_1.var_.moveOldPos1086 = var_152_12.localPosition
				var_152_12.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("1086", 3)

				local var_152_14 = var_152_12.childCount

				for iter_152_6 = 0, var_152_14 - 1 do
					local var_152_15 = var_152_12:GetChild(iter_152_6)

					if var_152_15.name == "split_6" or not string.find(var_152_15.name, "split") then
						var_152_15.gameObject:SetActive(true)
					else
						var_152_15.gameObject:SetActive(false)
					end
				end
			end

			local var_152_16 = 0.001

			if var_152_13 <= arg_149_1.time_ and arg_149_1.time_ < var_152_13 + var_152_16 then
				local var_152_17 = (arg_149_1.time_ - var_152_13) / var_152_16
				local var_152_18 = Vector3.New(0, -404.2, -237.9)

				var_152_12.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1086, var_152_18, var_152_17)
			end

			if arg_149_1.time_ >= var_152_13 + var_152_16 and arg_149_1.time_ < var_152_13 + var_152_16 + arg_152_0 then
				var_152_12.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_152_19 = 0
			local var_152_20 = 0.4

			if var_152_19 < arg_149_1.time_ and arg_149_1.time_ <= var_152_19 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_21 = arg_149_1:FormatText(StoryNameCfg[1080].name)

				arg_149_1.leftNameTxt_.text = var_152_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_22 = arg_149_1:GetWordFromCfg(425011041)
				local var_152_23 = arg_149_1:FormatText(var_152_22.content)

				arg_149_1.text_.text = var_152_23

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_24 = 16
				local var_152_25 = utf8.len(var_152_23)
				local var_152_26 = var_152_24 <= 0 and var_152_20 or var_152_20 * (var_152_25 / var_152_24)

				if var_152_26 > 0 and var_152_20 < var_152_26 then
					arg_149_1.talkMaxDuration = var_152_26

					if var_152_26 + var_152_19 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_26 + var_152_19
					end
				end

				arg_149_1.text_.text = var_152_23
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011041", "story_v_out_425011.awb") ~= 0 then
					local var_152_27 = manager.audio:GetVoiceLength("story_v_out_425011", "425011041", "story_v_out_425011.awb") / 1000

					if var_152_27 + var_152_19 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_27 + var_152_19
					end

					if var_152_22.prefab_name ~= "" and arg_149_1.actors_[var_152_22.prefab_name] ~= nil then
						local var_152_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_22.prefab_name].transform, "story_v_out_425011", "425011041", "story_v_out_425011.awb")

						arg_149_1:RecordAudio("425011041", var_152_28)
						arg_149_1:RecordAudio("425011041", var_152_28)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_425011", "425011041", "story_v_out_425011.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_425011", "425011041", "story_v_out_425011.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_29 = math.max(var_152_20, arg_149_1.talkMaxDuration)

			if var_152_19 <= arg_149_1.time_ and arg_149_1.time_ < var_152_19 + var_152_29 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_19) / var_152_29

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_19 + var_152_29 and arg_149_1.time_ < var_152_19 + var_152_29 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play425011042 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 425011042
		arg_153_1.duration_ = 2.6

		local var_153_0 = {
			zh = 1.1,
			ja = 2.6
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
				arg_153_0:Play425011043(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1086"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps1086 == nil then
				arg_153_1.var_.actorSpriteComps1086 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps1086 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								local var_156_4 = Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor2.r, var_156_3)
								local var_156_5 = Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor2.g, var_156_3)
								local var_156_6 = Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor2.b, var_156_3)

								iter_156_1.color = Color.New(var_156_4, var_156_5, var_156_6)
							else
								local var_156_7 = Mathf.Lerp(iter_156_1.color.r, 0.5, var_156_3)

								iter_156_1.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps1086 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_156_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1086 = nil
			end

			local var_156_8 = 0
			local var_156_9 = 0.15

			if var_156_8 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_10 = arg_153_1:FormatText(StoryNameCfg[1430].name)

				arg_153_1.leftNameTxt_.text = var_156_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_11 = arg_153_1:GetWordFromCfg(425011042)
				local var_156_12 = arg_153_1:FormatText(var_156_11.content)

				arg_153_1.text_.text = var_156_12

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_13 = 6
				local var_156_14 = utf8.len(var_156_12)
				local var_156_15 = var_156_13 <= 0 and var_156_9 or var_156_9 * (var_156_14 / var_156_13)

				if var_156_15 > 0 and var_156_9 < var_156_15 then
					arg_153_1.talkMaxDuration = var_156_15

					if var_156_15 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_15 + var_156_8
					end
				end

				arg_153_1.text_.text = var_156_12
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011042", "story_v_out_425011.awb") ~= 0 then
					local var_156_16 = manager.audio:GetVoiceLength("story_v_out_425011", "425011042", "story_v_out_425011.awb") / 1000

					if var_156_16 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_16 + var_156_8
					end

					if var_156_11.prefab_name ~= "" and arg_153_1.actors_[var_156_11.prefab_name] ~= nil then
						local var_156_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_11.prefab_name].transform, "story_v_out_425011", "425011042", "story_v_out_425011.awb")

						arg_153_1:RecordAudio("425011042", var_156_17)
						arg_153_1:RecordAudio("425011042", var_156_17)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_425011", "425011042", "story_v_out_425011.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_425011", "425011042", "story_v_out_425011.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_18 = math.max(var_156_9, arg_153_1.talkMaxDuration)

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_18 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_8) / var_156_18

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_8 + var_156_18 and arg_153_1.time_ < var_156_8 + var_156_18 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play425011043 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 425011043
		arg_157_1.duration_ = 7.37

		local var_157_0 = {
			zh = 4.266,
			ja = 7.366
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play425011044(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1086"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps1086 == nil then
				arg_157_1.var_.actorSpriteComps1086 = var_160_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.actorSpriteComps1086 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								local var_160_4 = Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor1.r, var_160_3)
								local var_160_5 = Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor1.g, var_160_3)
								local var_160_6 = Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor1.b, var_160_3)

								iter_160_1.color = Color.New(var_160_4, var_160_5, var_160_6)
							else
								local var_160_7 = Mathf.Lerp(iter_160_1.color.r, 1, var_160_3)

								iter_160_1.color = Color.New(var_160_7, var_160_7, var_160_7)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps1086 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1086 = nil
			end

			local var_160_8 = 0
			local var_160_9 = 0.575

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_10 = arg_157_1:FormatText(StoryNameCfg[1080].name)

				arg_157_1.leftNameTxt_.text = var_160_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_11 = arg_157_1:GetWordFromCfg(425011043)
				local var_160_12 = arg_157_1:FormatText(var_160_11.content)

				arg_157_1.text_.text = var_160_12

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 23
				local var_160_14 = utf8.len(var_160_12)
				local var_160_15 = var_160_13 <= 0 and var_160_9 or var_160_9 * (var_160_14 / var_160_13)

				if var_160_15 > 0 and var_160_9 < var_160_15 then
					arg_157_1.talkMaxDuration = var_160_15

					if var_160_15 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_15 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_12
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011043", "story_v_out_425011.awb") ~= 0 then
					local var_160_16 = manager.audio:GetVoiceLength("story_v_out_425011", "425011043", "story_v_out_425011.awb") / 1000

					if var_160_16 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_16 + var_160_8
					end

					if var_160_11.prefab_name ~= "" and arg_157_1.actors_[var_160_11.prefab_name] ~= nil then
						local var_160_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_11.prefab_name].transform, "story_v_out_425011", "425011043", "story_v_out_425011.awb")

						arg_157_1:RecordAudio("425011043", var_160_17)
						arg_157_1:RecordAudio("425011043", var_160_17)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_425011", "425011043", "story_v_out_425011.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_425011", "425011043", "story_v_out_425011.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_18 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_18 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_18

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_18 and arg_157_1.time_ < var_160_8 + var_160_18 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play425011044 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 425011044
		arg_161_1.duration_ = 3.73

		local var_161_0 = {
			zh = 3.5,
			ja = 3.733
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
				arg_161_0:Play425011045(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 1

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				local var_164_2 = "play"
				local var_164_3 = "effect"

				arg_161_1:AudioAction(var_164_2, var_164_3, "se_story_147", "se_story_147_dizzy_down", "")
			end

			local var_164_4 = arg_161_1.actors_["1086"].transform
			local var_164_5 = 0

			if var_164_5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1.var_.moveOldPos1086 = var_164_4.localPosition
				var_164_4.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1086", 3)

				local var_164_6 = var_164_4.childCount

				for iter_164_0 = 0, var_164_6 - 1 do
					local var_164_7 = var_164_4:GetChild(iter_164_0)

					if var_164_7.name == "split_3" then
						var_164_7:SetAsLastSibling()
						var_164_7.gameObject:SetActive(true)

						arg_161_1.var_.actorSpriteSplit1086 = var_164_7.gameObject:GetComponent(typeof(Image))

						arg_161_1.var_.actorSpriteSplit1086:SetAlpha(0)
					end
				end
			end

			local var_164_8 = 0.5

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_8 then
				local var_164_9 = (arg_161_1.time_ - var_164_5) / var_164_8
				local var_164_10 = Vector3.New(0, -404.2, -237.9)

				var_164_4.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1086, var_164_10, var_164_9)

				if arg_161_1.var_.actorSpriteSplit1086 ~= nil then
					arg_161_1.var_.actorSpriteSplit1086:SetAlpha(var_164_9)
				end
			end

			if arg_161_1.time_ >= var_164_5 + var_164_8 and arg_161_1.time_ < var_164_5 + var_164_8 + arg_164_0 then
				var_164_4.localPosition = Vector3.New(0, -404.2, -237.9)

				if arg_161_1.var_.actorSpriteSplit1086 ~= nil then
					arg_161_1.var_.actorSpriteSplit1086:SetAlpha(1)
				end
			end

			local var_164_11 = 0
			local var_164_12 = 0.225

			if var_164_11 < arg_161_1.time_ and arg_161_1.time_ <= var_164_11 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_13 = arg_161_1:FormatText(StoryNameCfg[1080].name)

				arg_161_1.leftNameTxt_.text = var_164_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_14 = arg_161_1:GetWordFromCfg(425011044)
				local var_164_15 = arg_161_1:FormatText(var_164_14.content)

				arg_161_1.text_.text = var_164_15

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_16 = 9
				local var_164_17 = utf8.len(var_164_15)
				local var_164_18 = var_164_16 <= 0 and var_164_12 or var_164_12 * (var_164_17 / var_164_16)

				if var_164_18 > 0 and var_164_12 < var_164_18 then
					arg_161_1.talkMaxDuration = var_164_18

					if var_164_18 + var_164_11 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_18 + var_164_11
					end
				end

				arg_161_1.text_.text = var_164_15
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011044", "story_v_out_425011.awb") ~= 0 then
					local var_164_19 = manager.audio:GetVoiceLength("story_v_out_425011", "425011044", "story_v_out_425011.awb") / 1000

					if var_164_19 + var_164_11 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_19 + var_164_11
					end

					if var_164_14.prefab_name ~= "" and arg_161_1.actors_[var_164_14.prefab_name] ~= nil then
						local var_164_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_14.prefab_name].transform, "story_v_out_425011", "425011044", "story_v_out_425011.awb")

						arg_161_1:RecordAudio("425011044", var_164_20)
						arg_161_1:RecordAudio("425011044", var_164_20)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_425011", "425011044", "story_v_out_425011.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_425011", "425011044", "story_v_out_425011.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_21 = math.max(var_164_12, arg_161_1.talkMaxDuration)

			if var_164_11 <= arg_161_1.time_ and arg_161_1.time_ < var_164_11 + var_164_21 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_11) / var_164_21

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_11 + var_164_21 and arg_161_1.time_ < var_164_11 + var_164_21 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play425011045 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 425011045
		arg_165_1.duration_ = 3

		local var_165_0 = {
			zh = 3,
			ja = 2.066
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
				arg_165_0:Play425011046(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = "1137"

			if arg_165_1.actors_[var_168_0] == nil then
				local var_168_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1137")

				if not isNil(var_168_1) then
					local var_168_2 = Object.Instantiate(var_168_1, arg_165_1.canvasGo_.transform)

					var_168_2.transform:SetSiblingIndex(1)

					var_168_2.name = var_168_0
					var_168_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_165_1.actors_[var_168_0] = var_168_2

					local var_168_3 = var_168_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_165_1.isInRecall_ then
						for iter_168_0, iter_168_1 in ipairs(var_168_3) do
							iter_168_1.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_168_4 = arg_165_1.actors_["1137"]
			local var_168_5 = 0

			if var_168_5 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.actorSpriteComps1137 == nil then
				arg_165_1.var_.actorSpriteComps1137 = var_168_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_6 = 0.2

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_6 and not isNil(var_168_4) then
				local var_168_7 = (arg_165_1.time_ - var_168_5) / var_168_6

				if arg_165_1.var_.actorSpriteComps1137 then
					for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_168_3 then
							if arg_165_1.isInRecall_ then
								local var_168_8 = Mathf.Lerp(iter_168_3.color.r, arg_165_1.hightColor1.r, var_168_7)
								local var_168_9 = Mathf.Lerp(iter_168_3.color.g, arg_165_1.hightColor1.g, var_168_7)
								local var_168_10 = Mathf.Lerp(iter_168_3.color.b, arg_165_1.hightColor1.b, var_168_7)

								iter_168_3.color = Color.New(var_168_8, var_168_9, var_168_10)
							else
								local var_168_11 = Mathf.Lerp(iter_168_3.color.r, 1, var_168_7)

								iter_168_3.color = Color.New(var_168_11, var_168_11, var_168_11)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_5 + var_168_6 and arg_165_1.time_ < var_168_5 + var_168_6 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.actorSpriteComps1137 then
				for iter_168_4, iter_168_5 in pairs(arg_165_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_168_5 then
						if arg_165_1.isInRecall_ then
							iter_168_5.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps1137 = nil
			end

			local var_168_12 = arg_165_1.actors_["1086"]
			local var_168_13 = 0

			if var_168_13 < arg_165_1.time_ and arg_165_1.time_ <= var_168_13 + arg_168_0 and not isNil(var_168_12) and arg_165_1.var_.actorSpriteComps1086 == nil then
				arg_165_1.var_.actorSpriteComps1086 = var_168_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_14 = 0.2

			if var_168_13 <= arg_165_1.time_ and arg_165_1.time_ < var_168_13 + var_168_14 and not isNil(var_168_12) then
				local var_168_15 = (arg_165_1.time_ - var_168_13) / var_168_14

				if arg_165_1.var_.actorSpriteComps1086 then
					for iter_168_6, iter_168_7 in pairs(arg_165_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_168_7 then
							if arg_165_1.isInRecall_ then
								local var_168_16 = Mathf.Lerp(iter_168_7.color.r, arg_165_1.hightColor2.r, var_168_15)
								local var_168_17 = Mathf.Lerp(iter_168_7.color.g, arg_165_1.hightColor2.g, var_168_15)
								local var_168_18 = Mathf.Lerp(iter_168_7.color.b, arg_165_1.hightColor2.b, var_168_15)

								iter_168_7.color = Color.New(var_168_16, var_168_17, var_168_18)
							else
								local var_168_19 = Mathf.Lerp(iter_168_7.color.r, 0.5, var_168_15)

								iter_168_7.color = Color.New(var_168_19, var_168_19, var_168_19)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_13 + var_168_14 and arg_165_1.time_ < var_168_13 + var_168_14 + arg_168_0 and not isNil(var_168_12) and arg_165_1.var_.actorSpriteComps1086 then
				for iter_168_8, iter_168_9 in pairs(arg_165_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_168_9 then
						if arg_165_1.isInRecall_ then
							iter_168_9.color = arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_168_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps1086 = nil
			end

			local var_168_20 = arg_165_1.actors_["1086"].transform
			local var_168_21 = 0

			if var_168_21 < arg_165_1.time_ and arg_165_1.time_ <= var_168_21 + arg_168_0 then
				arg_165_1.var_.moveOldPos1086 = var_168_20.localPosition
				var_168_20.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1086", 7)

				local var_168_22 = var_168_20.childCount

				for iter_168_10 = 0, var_168_22 - 1 do
					local var_168_23 = var_168_20:GetChild(iter_168_10)

					if var_168_23.name == "" or not string.find(var_168_23.name, "split") then
						var_168_23.gameObject:SetActive(true)
					else
						var_168_23.gameObject:SetActive(false)
					end
				end
			end

			local var_168_24 = 0.001

			if var_168_21 <= arg_165_1.time_ and arg_165_1.time_ < var_168_21 + var_168_24 then
				local var_168_25 = (arg_165_1.time_ - var_168_21) / var_168_24
				local var_168_26 = Vector3.New(0, -2000, 0)

				var_168_20.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1086, var_168_26, var_168_25)
			end

			if arg_165_1.time_ >= var_168_21 + var_168_24 and arg_165_1.time_ < var_168_21 + var_168_24 + arg_168_0 then
				var_168_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_168_27 = arg_165_1.actors_["1137"].transform
			local var_168_28 = 0

			if var_168_28 < arg_165_1.time_ and arg_165_1.time_ <= var_168_28 + arg_168_0 then
				arg_165_1.var_.moveOldPos1137 = var_168_27.localPosition
				var_168_27.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1137", 3)

				local var_168_29 = var_168_27.childCount

				for iter_168_11 = 0, var_168_29 - 1 do
					local var_168_30 = var_168_27:GetChild(iter_168_11)

					if var_168_30.name == "split_5" or not string.find(var_168_30.name, "split") then
						var_168_30.gameObject:SetActive(true)
					else
						var_168_30.gameObject:SetActive(false)
					end
				end
			end

			local var_168_31 = 0.001

			if var_168_28 <= arg_165_1.time_ and arg_165_1.time_ < var_168_28 + var_168_31 then
				local var_168_32 = (arg_165_1.time_ - var_168_28) / var_168_31
				local var_168_33 = Vector3.New(0, -425, -200)

				var_168_27.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1137, var_168_33, var_168_32)
			end

			if arg_165_1.time_ >= var_168_28 + var_168_31 and arg_165_1.time_ < var_168_28 + var_168_31 + arg_168_0 then
				var_168_27.localPosition = Vector3.New(0, -425, -200)
			end

			local var_168_34 = arg_165_1.actors_["1137"]
			local var_168_35 = 0

			if var_168_35 < arg_165_1.time_ and arg_165_1.time_ <= var_168_35 + arg_168_0 then
				local var_168_36 = var_168_34:GetComponentInChildren(typeof(CanvasGroup))

				if var_168_36 then
					arg_165_1.var_.alphaOldValue1137 = var_168_36.alpha
					arg_165_1.var_.characterEffect1137 = var_168_36
				end

				arg_165_1.var_.alphaOldValue1137 = 0
			end

			local var_168_37 = 0.2

			if var_168_35 <= arg_165_1.time_ and arg_165_1.time_ < var_168_35 + var_168_37 then
				local var_168_38 = (arg_165_1.time_ - var_168_35) / var_168_37
				local var_168_39 = Mathf.Lerp(arg_165_1.var_.alphaOldValue1137, 1, var_168_38)

				if arg_165_1.var_.characterEffect1137 then
					arg_165_1.var_.characterEffect1137.alpha = var_168_39
				end
			end

			if arg_165_1.time_ >= var_168_35 + var_168_37 and arg_165_1.time_ < var_168_35 + var_168_37 + arg_168_0 and arg_165_1.var_.characterEffect1137 then
				arg_165_1.var_.characterEffect1137.alpha = 1
			end

			local var_168_40 = 0
			local var_168_41 = 0.1

			if var_168_40 < arg_165_1.time_ and arg_165_1.time_ <= var_168_40 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_42 = arg_165_1:FormatText(StoryNameCfg[15].name)

				arg_165_1.leftNameTxt_.text = var_168_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_43 = arg_165_1:GetWordFromCfg(425011045)
				local var_168_44 = arg_165_1:FormatText(var_168_43.content)

				arg_165_1.text_.text = var_168_44

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_45 = 4
				local var_168_46 = utf8.len(var_168_44)
				local var_168_47 = var_168_45 <= 0 and var_168_41 or var_168_41 * (var_168_46 / var_168_45)

				if var_168_47 > 0 and var_168_41 < var_168_47 then
					arg_165_1.talkMaxDuration = var_168_47

					if var_168_47 + var_168_40 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_47 + var_168_40
					end
				end

				arg_165_1.text_.text = var_168_44
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011045", "story_v_out_425011.awb") ~= 0 then
					local var_168_48 = manager.audio:GetVoiceLength("story_v_out_425011", "425011045", "story_v_out_425011.awb") / 1000

					if var_168_48 + var_168_40 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_48 + var_168_40
					end

					if var_168_43.prefab_name ~= "" and arg_165_1.actors_[var_168_43.prefab_name] ~= nil then
						local var_168_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_43.prefab_name].transform, "story_v_out_425011", "425011045", "story_v_out_425011.awb")

						arg_165_1:RecordAudio("425011045", var_168_49)
						arg_165_1:RecordAudio("425011045", var_168_49)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_425011", "425011045", "story_v_out_425011.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_425011", "425011045", "story_v_out_425011.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_50 = math.max(var_168_41, arg_165_1.talkMaxDuration)

			if var_168_40 <= arg_165_1.time_ and arg_165_1.time_ < var_168_40 + var_168_50 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_40) / var_168_50

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_40 + var_168_50 and arg_165_1.time_ < var_168_40 + var_168_50 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play425011046 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 425011046
		arg_169_1.duration_ = 6

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play425011047(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1137"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1137 = var_172_0.localPosition
				var_172_0.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("1137", 7)

				local var_172_2 = var_172_0.childCount

				for iter_172_0 = 0, var_172_2 - 1 do
					local var_172_3 = var_172_0:GetChild(iter_172_0)

					if var_172_3.name == "" or not string.find(var_172_3.name, "split") then
						var_172_3.gameObject:SetActive(true)
					else
						var_172_3.gameObject:SetActive(false)
					end
				end
			end

			local var_172_4 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_4 then
				local var_172_5 = (arg_169_1.time_ - var_172_1) / var_172_4
				local var_172_6 = Vector3.New(0, -2000, 0)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1137, var_172_6, var_172_5)
			end

			if arg_169_1.time_ >= var_172_1 + var_172_4 and arg_169_1.time_ < var_172_1 + var_172_4 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_172_7
			local var_172_8 = 0

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				local var_172_9 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_172_9 then
					var_172_9.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_172_9.radialBlurScale = 0
					var_172_9.radialBlurGradient = 0.5
					var_172_9.radialBlurIntensity = 0.5

					if var_172_7 then
						var_172_9.radialBlurTarget = var_172_7.transform
					end
				end
			end

			local var_172_10 = 1

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_10 then
				local var_172_11 = (arg_169_1.time_ - var_172_8) / var_172_10
				local var_172_12 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_172_12 then
					var_172_12.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_172_12.radialBlurScale = Mathf.Lerp(0, 1, var_172_11)
					var_172_12.radialBlurGradient = Mathf.Lerp(0.5, 1, var_172_11)
					var_172_12.radialBlurIntensity = Mathf.Lerp(0.5, 1, var_172_11)
				end
			end

			if arg_169_1.time_ >= var_172_8 + var_172_10 and arg_169_1.time_ < var_172_8 + var_172_10 + arg_172_0 then
				local var_172_13 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_172_13 then
					var_172_13.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_172_13.radialBlurScale = 1
					var_172_13.radialBlurGradient = 1
					var_172_13.radialBlurIntensity = 1
				end
			end

			local var_172_14 = manager.ui.mainCamera.transform
			local var_172_15 = 0

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 then
				local var_172_16 = arg_169_1.var_.effect100910461
				local var_172_17
				local var_172_18 = var_172_14

				if not var_172_16 then
					var_172_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple2"), var_172_18)
					var_172_16.name = "10461"
					arg_169_1.var_.effect100910461 = var_172_16
				else
					var_172_16.transform:SetParent(var_172_18)
				end

				var_172_16.transform.localPosition = Vector3.New(0, 0.12, -1)
				var_172_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_172_19 = 0
			local var_172_20 = 1

			if var_172_19 < arg_169_1.time_ and arg_169_1.time_ <= var_172_19 + arg_172_0 then
				local var_172_21 = "play"
				local var_172_22 = "effect"

				arg_169_1:AudioAction(var_172_21, var_172_22, "se_story_147", "se_story_147_electric_shock_01", "")
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_23 = 1
			local var_172_24 = 1.45

			if var_172_23 < arg_169_1.time_ and arg_169_1.time_ <= var_172_23 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_25 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_25:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_26 = arg_169_1:GetWordFromCfg(425011046)
				local var_172_27 = arg_169_1:FormatText(var_172_26.content)

				arg_169_1.text_.text = var_172_27

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_28 = 58
				local var_172_29 = utf8.len(var_172_27)
				local var_172_30 = var_172_28 <= 0 and var_172_24 or var_172_24 * (var_172_29 / var_172_28)

				if var_172_30 > 0 and var_172_24 < var_172_30 then
					arg_169_1.talkMaxDuration = var_172_30
					var_172_23 = var_172_23 + 0.3

					if var_172_30 + var_172_23 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_30 + var_172_23
					end
				end

				arg_169_1.text_.text = var_172_27
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_31 = var_172_23 + 0.3
			local var_172_32 = math.max(var_172_24, arg_169_1.talkMaxDuration)

			if var_172_31 <= arg_169_1.time_ and arg_169_1.time_ < var_172_31 + var_172_32 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_31) / var_172_32

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_31 + var_172_32 and arg_169_1.time_ < var_172_31 + var_172_32 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play425011047 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 425011047
		arg_175_1.duration_ = 5.53

		local var_175_0 = {
			zh = 2.10066666666667,
			ja = 5.53366666666667
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play425011048(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1086"]
			local var_178_1 = 0.400666666666667

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps1086 == nil then
				arg_175_1.var_.actorSpriteComps1086 = var_178_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_2 = 0.2

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.actorSpriteComps1086 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_178_1 then
							if arg_175_1.isInRecall_ then
								local var_178_4 = Mathf.Lerp(iter_178_1.color.r, arg_175_1.hightColor1.r, var_178_3)
								local var_178_5 = Mathf.Lerp(iter_178_1.color.g, arg_175_1.hightColor1.g, var_178_3)
								local var_178_6 = Mathf.Lerp(iter_178_1.color.b, arg_175_1.hightColor1.b, var_178_3)

								iter_178_1.color = Color.New(var_178_4, var_178_5, var_178_6)
							else
								local var_178_7 = Mathf.Lerp(iter_178_1.color.r, 1, var_178_3)

								iter_178_1.color = Color.New(var_178_7, var_178_7, var_178_7)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.actorSpriteComps1086 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_178_3 then
						if arg_175_1.isInRecall_ then
							iter_178_3.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_178_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps1086 = nil
			end

			local var_178_8 = arg_175_1.actors_["1086"].transform
			local var_178_9 = 0.400666666666667

			if var_178_9 < arg_175_1.time_ and arg_175_1.time_ <= var_178_9 + arg_178_0 then
				arg_175_1.var_.moveOldPos1086 = var_178_8.localPosition
				var_178_8.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("1086", 3)

				local var_178_10 = var_178_8.childCount

				for iter_178_4 = 0, var_178_10 - 1 do
					local var_178_11 = var_178_8:GetChild(iter_178_4)

					if var_178_11.name == "split_6" or not string.find(var_178_11.name, "split") then
						var_178_11.gameObject:SetActive(true)
					else
						var_178_11.gameObject:SetActive(false)
					end
				end
			end

			local var_178_12 = 0.001

			if var_178_9 <= arg_175_1.time_ and arg_175_1.time_ < var_178_9 + var_178_12 then
				local var_178_13 = (arg_175_1.time_ - var_178_9) / var_178_12
				local var_178_14 = Vector3.New(0, -404.2, -237.9)

				var_178_8.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1086, var_178_14, var_178_13)
			end

			if arg_175_1.time_ >= var_178_9 + var_178_12 and arg_175_1.time_ < var_178_9 + var_178_12 + arg_178_0 then
				var_178_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_178_15
			local var_178_16 = 0

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				local var_178_17 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_178_17 then
					var_178_17.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_178_17.radialBlurScale = 1
					var_178_17.radialBlurGradient = 1
					var_178_17.radialBlurIntensity = 1

					if var_178_15 then
						var_178_17.radialBlurTarget = var_178_15.transform
					end
				end
			end

			local var_178_18 = 0.400666666666667

			if var_178_16 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_18 then
				local var_178_19 = (arg_175_1.time_ - var_178_16) / var_178_18
				local var_178_20 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_178_20 then
					var_178_20.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_178_20.radialBlurScale = Mathf.Lerp(1, 0.5, var_178_19)
					var_178_20.radialBlurGradient = Mathf.Lerp(1, 1, var_178_19)
					var_178_20.radialBlurIntensity = Mathf.Lerp(1, 1, var_178_19)
				end
			end

			if arg_175_1.time_ >= var_178_16 + var_178_18 and arg_175_1.time_ < var_178_16 + var_178_18 + arg_178_0 then
				local var_178_21 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_178_21 then
					var_178_21.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_178_21.radialBlurScale = 0.5
					var_178_21.radialBlurGradient = 1
					var_178_21.radialBlurIntensity = 1
				end
			end

			local var_178_22
			local var_178_23 = 0.434666666666667

			if var_178_23 < arg_175_1.time_ and arg_175_1.time_ <= var_178_23 + arg_178_0 then
				local var_178_24 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_178_24 then
					var_178_24.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_178_24.radialBlurScale = 0.5
					var_178_24.radialBlurGradient = 0
					var_178_24.radialBlurIntensity = 0

					if var_178_22 then
						var_178_24.radialBlurTarget = var_178_22.transform
					end
				end
			end

			local var_178_25 = 0.366666666666667

			if var_178_23 <= arg_175_1.time_ and arg_175_1.time_ < var_178_23 + var_178_25 then
				local var_178_26 = (arg_175_1.time_ - var_178_23) / var_178_25
				local var_178_27 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_178_27 then
					var_178_27.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_178_27.radialBlurScale = Mathf.Lerp(0.5, 0, var_178_26)
					var_178_27.radialBlurGradient = Mathf.Lerp(0, 0, var_178_26)
					var_178_27.radialBlurIntensity = Mathf.Lerp(0, 0, var_178_26)
				end
			end

			if arg_175_1.time_ >= var_178_23 + var_178_25 and arg_175_1.time_ < var_178_23 + var_178_25 + arg_178_0 then
				local var_178_28 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_178_28 then
					var_178_28.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_178_28.radialBlurScale = 0
					var_178_28.radialBlurGradient = 0
					var_178_28.radialBlurIntensity = 0
				end
			end

			local var_178_29 = 0.299999999998
			local var_178_30 = 1

			if var_178_29 < arg_175_1.time_ and arg_175_1.time_ <= var_178_29 + arg_178_0 then
				local var_178_31 = "stop"
				local var_178_32 = "effect"

				arg_175_1:AudioAction(var_178_31, var_178_32, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_178_33 = 0.299999999999
			local var_178_34 = 1

			if var_178_33 < arg_175_1.time_ and arg_175_1.time_ <= var_178_33 + arg_178_0 then
				local var_178_35 = "play"
				local var_178_36 = "effect"

				arg_175_1:AudioAction(var_178_35, var_178_36, "se_story_147", "se_story_147_clap", "")
			end

			local var_178_37 = manager.ui.mainCamera.transform
			local var_178_38 = 0.400666666666667

			if var_178_38 < arg_175_1.time_ and arg_175_1.time_ <= var_178_38 + arg_178_0 then
				local var_178_39 = arg_175_1.var_.effect100910461

				if var_178_39 then
					Object.Destroy(var_178_39)

					arg_175_1.var_.effect100910461 = nil
				end
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_40 = 0.400666666666667
			local var_178_41 = 0.175

			if var_178_40 < arg_175_1.time_ and arg_175_1.time_ <= var_178_40 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_42 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_42:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_43 = arg_175_1:FormatText(StoryNameCfg[1080].name)

				arg_175_1.leftNameTxt_.text = var_178_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_44 = arg_175_1:GetWordFromCfg(425011047)
				local var_178_45 = arg_175_1:FormatText(var_178_44.content)

				arg_175_1.text_.text = var_178_45

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_46 = 7
				local var_178_47 = utf8.len(var_178_45)
				local var_178_48 = var_178_46 <= 0 and var_178_41 or var_178_41 * (var_178_47 / var_178_46)

				if var_178_48 > 0 and var_178_41 < var_178_48 then
					arg_175_1.talkMaxDuration = var_178_48
					var_178_40 = var_178_40 + 0.3

					if var_178_48 + var_178_40 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_48 + var_178_40
					end
				end

				arg_175_1.text_.text = var_178_45
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011047", "story_v_out_425011.awb") ~= 0 then
					local var_178_49 = manager.audio:GetVoiceLength("story_v_out_425011", "425011047", "story_v_out_425011.awb") / 1000

					if var_178_49 + var_178_40 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_49 + var_178_40
					end

					if var_178_44.prefab_name ~= "" and arg_175_1.actors_[var_178_44.prefab_name] ~= nil then
						local var_178_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_44.prefab_name].transform, "story_v_out_425011", "425011047", "story_v_out_425011.awb")

						arg_175_1:RecordAudio("425011047", var_178_50)
						arg_175_1:RecordAudio("425011047", var_178_50)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_425011", "425011047", "story_v_out_425011.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_425011", "425011047", "story_v_out_425011.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_51 = var_178_40 + 0.3
			local var_178_52 = math.max(var_178_41, arg_175_1.talkMaxDuration)

			if var_178_51 <= arg_175_1.time_ and arg_175_1.time_ < var_178_51 + var_178_52 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_51) / var_178_52

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_51 + var_178_52 and arg_175_1.time_ < var_178_51 + var_178_52 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.400666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play425011048 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 425011048
		arg_181_1.duration_ = 7.3

		local var_181_0 = {
			zh = 4.866,
			ja = 7.3
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play425011049(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1137"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps1137 == nil then
				arg_181_1.var_.actorSpriteComps1137 = var_184_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.actorSpriteComps1137 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								local var_184_4 = Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor1.r, var_184_3)
								local var_184_5 = Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor1.g, var_184_3)
								local var_184_6 = Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor1.b, var_184_3)

								iter_184_1.color = Color.New(var_184_4, var_184_5, var_184_6)
							else
								local var_184_7 = Mathf.Lerp(iter_184_1.color.r, 1, var_184_3)

								iter_184_1.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps1137 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps1137 = nil
			end

			local var_184_8 = arg_181_1.actors_["1086"]
			local var_184_9 = 0

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps1086 == nil then
				arg_181_1.var_.actorSpriteComps1086 = var_184_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_10 = 0.2

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_10 and not isNil(var_184_8) then
				local var_184_11 = (arg_181_1.time_ - var_184_9) / var_184_10

				if arg_181_1.var_.actorSpriteComps1086 then
					for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_184_5 then
							if arg_181_1.isInRecall_ then
								local var_184_12 = Mathf.Lerp(iter_184_5.color.r, arg_181_1.hightColor2.r, var_184_11)
								local var_184_13 = Mathf.Lerp(iter_184_5.color.g, arg_181_1.hightColor2.g, var_184_11)
								local var_184_14 = Mathf.Lerp(iter_184_5.color.b, arg_181_1.hightColor2.b, var_184_11)

								iter_184_5.color = Color.New(var_184_12, var_184_13, var_184_14)
							else
								local var_184_15 = Mathf.Lerp(iter_184_5.color.r, 0.5, var_184_11)

								iter_184_5.color = Color.New(var_184_15, var_184_15, var_184_15)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_9 + var_184_10 and arg_181_1.time_ < var_184_9 + var_184_10 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps1086 then
				for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_184_7 then
						if arg_181_1.isInRecall_ then
							iter_184_7.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps1086 = nil
			end

			local var_184_16 = arg_181_1.actors_["1137"].transform
			local var_184_17 = 0

			if var_184_17 < arg_181_1.time_ and arg_181_1.time_ <= var_184_17 + arg_184_0 then
				arg_181_1.var_.moveOldPos1137 = var_184_16.localPosition
				var_184_16.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("1137", 2)

				local var_184_18 = var_184_16.childCount

				for iter_184_8 = 0, var_184_18 - 1 do
					local var_184_19 = var_184_16:GetChild(iter_184_8)

					if var_184_19.name == "split_5" or not string.find(var_184_19.name, "split") then
						var_184_19.gameObject:SetActive(true)
					else
						var_184_19.gameObject:SetActive(false)
					end
				end
			end

			local var_184_20 = 0.001

			if var_184_17 <= arg_181_1.time_ and arg_181_1.time_ < var_184_17 + var_184_20 then
				local var_184_21 = (arg_181_1.time_ - var_184_17) / var_184_20
				local var_184_22 = Vector3.New(-390, -425, -200)

				var_184_16.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1137, var_184_22, var_184_21)
			end

			if arg_181_1.time_ >= var_184_17 + var_184_20 and arg_181_1.time_ < var_184_17 + var_184_20 + arg_184_0 then
				var_184_16.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_184_23 = arg_181_1.actors_["1086"].transform
			local var_184_24 = 0

			if var_184_24 < arg_181_1.time_ and arg_181_1.time_ <= var_184_24 + arg_184_0 then
				arg_181_1.var_.moveOldPos1086 = var_184_23.localPosition
				var_184_23.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("1086", 4)

				local var_184_25 = var_184_23.childCount

				for iter_184_9 = 0, var_184_25 - 1 do
					local var_184_26 = var_184_23:GetChild(iter_184_9)

					if var_184_26.name == "" or not string.find(var_184_26.name, "split") then
						var_184_26.gameObject:SetActive(true)
					else
						var_184_26.gameObject:SetActive(false)
					end
				end
			end

			local var_184_27 = 0.001

			if var_184_24 <= arg_181_1.time_ and arg_181_1.time_ < var_184_24 + var_184_27 then
				local var_184_28 = (arg_181_1.time_ - var_184_24) / var_184_27
				local var_184_29 = Vector3.New(390, -404.2, -237.9)

				var_184_23.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1086, var_184_29, var_184_28)
			end

			if arg_181_1.time_ >= var_184_24 + var_184_27 and arg_181_1.time_ < var_184_24 + var_184_27 + arg_184_0 then
				var_184_23.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_184_30 = 0
			local var_184_31 = 0.225

			if var_184_30 < arg_181_1.time_ and arg_181_1.time_ <= var_184_30 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_32 = arg_181_1:FormatText(StoryNameCfg[15].name)

				arg_181_1.leftNameTxt_.text = var_184_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_33 = arg_181_1:GetWordFromCfg(425011048)
				local var_184_34 = arg_181_1:FormatText(var_184_33.content)

				arg_181_1.text_.text = var_184_34

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_35 = 9
				local var_184_36 = utf8.len(var_184_34)
				local var_184_37 = var_184_35 <= 0 and var_184_31 or var_184_31 * (var_184_36 / var_184_35)

				if var_184_37 > 0 and var_184_31 < var_184_37 then
					arg_181_1.talkMaxDuration = var_184_37

					if var_184_37 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_37 + var_184_30
					end
				end

				arg_181_1.text_.text = var_184_34
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011048", "story_v_out_425011.awb") ~= 0 then
					local var_184_38 = manager.audio:GetVoiceLength("story_v_out_425011", "425011048", "story_v_out_425011.awb") / 1000

					if var_184_38 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_38 + var_184_30
					end

					if var_184_33.prefab_name ~= "" and arg_181_1.actors_[var_184_33.prefab_name] ~= nil then
						local var_184_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_33.prefab_name].transform, "story_v_out_425011", "425011048", "story_v_out_425011.awb")

						arg_181_1:RecordAudio("425011048", var_184_39)
						arg_181_1:RecordAudio("425011048", var_184_39)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_425011", "425011048", "story_v_out_425011.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_425011", "425011048", "story_v_out_425011.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_40 = math.max(var_184_31, arg_181_1.talkMaxDuration)

			if var_184_30 <= arg_181_1.time_ and arg_181_1.time_ < var_184_30 + var_184_40 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_30) / var_184_40

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_30 + var_184_40 and arg_181_1.time_ < var_184_30 + var_184_40 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play425011049 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 425011049
		arg_185_1.duration_ = 7.6

		local var_185_0 = {
			zh = 6.366,
			ja = 7.6
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
				arg_185_0:Play425011050(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1086"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps1086 == nil then
				arg_185_1.var_.actorSpriteComps1086 = var_188_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.actorSpriteComps1086 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								local var_188_4 = Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor1.r, var_188_3)
								local var_188_5 = Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor1.g, var_188_3)
								local var_188_6 = Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor1.b, var_188_3)

								iter_188_1.color = Color.New(var_188_4, var_188_5, var_188_6)
							else
								local var_188_7 = Mathf.Lerp(iter_188_1.color.r, 1, var_188_3)

								iter_188_1.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps1086 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_188_3 then
						if arg_185_1.isInRecall_ then
							iter_188_3.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps1086 = nil
			end

			local var_188_8 = arg_185_1.actors_["1137"]
			local var_188_9 = 0

			if var_188_9 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 and not isNil(var_188_8) and arg_185_1.var_.actorSpriteComps1137 == nil then
				arg_185_1.var_.actorSpriteComps1137 = var_188_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_10 = 0.2

			if var_188_9 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_10 and not isNil(var_188_8) then
				local var_188_11 = (arg_185_1.time_ - var_188_9) / var_188_10

				if arg_185_1.var_.actorSpriteComps1137 then
					for iter_188_4, iter_188_5 in pairs(arg_185_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_188_5 then
							if arg_185_1.isInRecall_ then
								local var_188_12 = Mathf.Lerp(iter_188_5.color.r, arg_185_1.hightColor2.r, var_188_11)
								local var_188_13 = Mathf.Lerp(iter_188_5.color.g, arg_185_1.hightColor2.g, var_188_11)
								local var_188_14 = Mathf.Lerp(iter_188_5.color.b, arg_185_1.hightColor2.b, var_188_11)

								iter_188_5.color = Color.New(var_188_12, var_188_13, var_188_14)
							else
								local var_188_15 = Mathf.Lerp(iter_188_5.color.r, 0.5, var_188_11)

								iter_188_5.color = Color.New(var_188_15, var_188_15, var_188_15)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_9 + var_188_10 and arg_185_1.time_ < var_188_9 + var_188_10 + arg_188_0 and not isNil(var_188_8) and arg_185_1.var_.actorSpriteComps1137 then
				for iter_188_6, iter_188_7 in pairs(arg_185_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_188_7 then
						if arg_185_1.isInRecall_ then
							iter_188_7.color = arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_188_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps1137 = nil
			end

			local var_188_16 = arg_185_1.actors_["1086"].transform
			local var_188_17 = 0

			if var_188_17 < arg_185_1.time_ and arg_185_1.time_ <= var_188_17 + arg_188_0 then
				arg_185_1.var_.moveOldPos1086 = var_188_16.localPosition
				var_188_16.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("1086", 4)

				local var_188_18 = var_188_16.childCount

				for iter_188_8 = 0, var_188_18 - 1 do
					local var_188_19 = var_188_16:GetChild(iter_188_8)

					if var_188_19.name == "split_2" then
						var_188_19:SetAsLastSibling()
						var_188_19.gameObject:SetActive(true)

						arg_185_1.var_.actorSpriteSplit1086 = var_188_19.gameObject:GetComponent(typeof(Image))

						arg_185_1.var_.actorSpriteSplit1086:SetAlpha(0)
					end
				end
			end

			local var_188_20 = 0.5

			if var_188_17 <= arg_185_1.time_ and arg_185_1.time_ < var_188_17 + var_188_20 then
				local var_188_21 = (arg_185_1.time_ - var_188_17) / var_188_20
				local var_188_22 = Vector3.New(390, -404.2, -237.9)

				var_188_16.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1086, var_188_22, var_188_21)

				if arg_185_1.var_.actorSpriteSplit1086 ~= nil then
					arg_185_1.var_.actorSpriteSplit1086:SetAlpha(var_188_21)
				end
			end

			if arg_185_1.time_ >= var_188_17 + var_188_20 and arg_185_1.time_ < var_188_17 + var_188_20 + arg_188_0 then
				var_188_16.localPosition = Vector3.New(390, -404.2, -237.9)

				if arg_185_1.var_.actorSpriteSplit1086 ~= nil then
					arg_185_1.var_.actorSpriteSplit1086:SetAlpha(1)
				end
			end

			local var_188_23 = 0
			local var_188_24 = 0.775

			if var_188_23 < arg_185_1.time_ and arg_185_1.time_ <= var_188_23 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_25 = arg_185_1:FormatText(StoryNameCfg[1080].name)

				arg_185_1.leftNameTxt_.text = var_188_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_26 = arg_185_1:GetWordFromCfg(425011049)
				local var_188_27 = arg_185_1:FormatText(var_188_26.content)

				arg_185_1.text_.text = var_188_27

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_28 = 31
				local var_188_29 = utf8.len(var_188_27)
				local var_188_30 = var_188_28 <= 0 and var_188_24 or var_188_24 * (var_188_29 / var_188_28)

				if var_188_30 > 0 and var_188_24 < var_188_30 then
					arg_185_1.talkMaxDuration = var_188_30

					if var_188_30 + var_188_23 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_30 + var_188_23
					end
				end

				arg_185_1.text_.text = var_188_27
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011049", "story_v_out_425011.awb") ~= 0 then
					local var_188_31 = manager.audio:GetVoiceLength("story_v_out_425011", "425011049", "story_v_out_425011.awb") / 1000

					if var_188_31 + var_188_23 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_31 + var_188_23
					end

					if var_188_26.prefab_name ~= "" and arg_185_1.actors_[var_188_26.prefab_name] ~= nil then
						local var_188_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_26.prefab_name].transform, "story_v_out_425011", "425011049", "story_v_out_425011.awb")

						arg_185_1:RecordAudio("425011049", var_188_32)
						arg_185_1:RecordAudio("425011049", var_188_32)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_425011", "425011049", "story_v_out_425011.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_425011", "425011049", "story_v_out_425011.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_33 = math.max(var_188_24, arg_185_1.talkMaxDuration)

			if var_188_23 <= arg_185_1.time_ and arg_185_1.time_ < var_188_23 + var_188_33 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_23) / var_188_33

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_23 + var_188_33 and arg_185_1.time_ < var_188_23 + var_188_33 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play425011050 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 425011050
		arg_189_1.duration_ = 5.1

		local var_189_0 = {
			zh = 4.233,
			ja = 5.1
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
				arg_189_0:Play425011051(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1086"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1086 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1086", 4)

				local var_192_2 = var_192_0.childCount

				for iter_192_0 = 0, var_192_2 - 1 do
					local var_192_3 = var_192_0:GetChild(iter_192_0)

					if var_192_3.name == "split_6" then
						var_192_3:SetAsLastSibling()
						var_192_3.gameObject:SetActive(true)

						arg_189_1.var_.actorSpriteSplit1086 = var_192_3.gameObject:GetComponent(typeof(Image))

						arg_189_1.var_.actorSpriteSplit1086:SetAlpha(0)
					end
				end
			end

			local var_192_4 = 0.5

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_4 then
				local var_192_5 = (arg_189_1.time_ - var_192_1) / var_192_4
				local var_192_6 = Vector3.New(390, -404.2, -237.9)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1086, var_192_6, var_192_5)

				if arg_189_1.var_.actorSpriteSplit1086 ~= nil then
					arg_189_1.var_.actorSpriteSplit1086:SetAlpha(var_192_5)
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_4 and arg_189_1.time_ < var_192_1 + var_192_4 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(390, -404.2, -237.9)

				if arg_189_1.var_.actorSpriteSplit1086 ~= nil then
					arg_189_1.var_.actorSpriteSplit1086:SetAlpha(1)
				end
			end

			local var_192_7 = 0
			local var_192_8 = 0.575

			if var_192_7 < arg_189_1.time_ and arg_189_1.time_ <= var_192_7 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_9 = arg_189_1:FormatText(StoryNameCfg[1080].name)

				arg_189_1.leftNameTxt_.text = var_192_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_10 = arg_189_1:GetWordFromCfg(425011050)
				local var_192_11 = arg_189_1:FormatText(var_192_10.content)

				arg_189_1.text_.text = var_192_11

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_12 = 23
				local var_192_13 = utf8.len(var_192_11)
				local var_192_14 = var_192_12 <= 0 and var_192_8 or var_192_8 * (var_192_13 / var_192_12)

				if var_192_14 > 0 and var_192_8 < var_192_14 then
					arg_189_1.talkMaxDuration = var_192_14

					if var_192_14 + var_192_7 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_14 + var_192_7
					end
				end

				arg_189_1.text_.text = var_192_11
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011050", "story_v_out_425011.awb") ~= 0 then
					local var_192_15 = manager.audio:GetVoiceLength("story_v_out_425011", "425011050", "story_v_out_425011.awb") / 1000

					if var_192_15 + var_192_7 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_15 + var_192_7
					end

					if var_192_10.prefab_name ~= "" and arg_189_1.actors_[var_192_10.prefab_name] ~= nil then
						local var_192_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_10.prefab_name].transform, "story_v_out_425011", "425011050", "story_v_out_425011.awb")

						arg_189_1:RecordAudio("425011050", var_192_16)
						arg_189_1:RecordAudio("425011050", var_192_16)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_425011", "425011050", "story_v_out_425011.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_425011", "425011050", "story_v_out_425011.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_17 = math.max(var_192_8, arg_189_1.talkMaxDuration)

			if var_192_7 <= arg_189_1.time_ and arg_189_1.time_ < var_192_7 + var_192_17 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_7) / var_192_17

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_7 + var_192_17 and arg_189_1.time_ < var_192_7 + var_192_17 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play425011051 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 425011051
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
			arg_193_1.auto_ = false
		end

		function arg_193_1.playNext_(arg_195_0)
			arg_193_1.onStoryFinished_()
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1137"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1137 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1137", 7)

				local var_196_2 = var_196_0.childCount

				for iter_196_0 = 0, var_196_2 - 1 do
					local var_196_3 = var_196_0:GetChild(iter_196_0)

					if var_196_3.name == "" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_4 then
				local var_196_5 = (arg_193_1.time_ - var_196_1) / var_196_4
				local var_196_6 = Vector3.New(0, -2000, 0)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1137, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_196_7 = arg_193_1.actors_["1086"].transform
			local var_196_8 = 0

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.var_.moveOldPos1086 = var_196_7.localPosition
				var_196_7.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1086", 7)

				local var_196_9 = var_196_7.childCount

				for iter_196_1 = 0, var_196_9 - 1 do
					local var_196_10 = var_196_7:GetChild(iter_196_1)

					if var_196_10.name == "" or not string.find(var_196_10.name, "split") then
						var_196_10.gameObject:SetActive(true)
					else
						var_196_10.gameObject:SetActive(false)
					end
				end
			end

			local var_196_11 = 0.001

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_11 then
				local var_196_12 = (arg_193_1.time_ - var_196_8) / var_196_11
				local var_196_13 = Vector3.New(0, -2000, 0)

				var_196_7.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1086, var_196_13, var_196_12)
			end

			if arg_193_1.time_ >= var_196_8 + var_196_11 and arg_193_1.time_ < var_196_8 + var_196_11 + arg_196_0 then
				var_196_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_196_14 = 0
			local var_196_15 = 1

			if var_196_14 < arg_193_1.time_ and arg_193_1.time_ <= var_196_14 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_16 = arg_193_1:GetWordFromCfg(425011051)
				local var_196_17 = arg_193_1:FormatText(var_196_16.content)

				arg_193_1.text_.text = var_196_17

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_18 = 40
				local var_196_19 = utf8.len(var_196_17)
				local var_196_20 = var_196_18 <= 0 and var_196_15 or var_196_15 * (var_196_19 / var_196_18)

				if var_196_20 > 0 and var_196_15 < var_196_20 then
					arg_193_1.talkMaxDuration = var_196_20

					if var_196_20 + var_196_14 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_20 + var_196_14
					end
				end

				arg_193_1.text_.text = var_196_17
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_21 = math.max(var_196_15, arg_193_1.talkMaxDuration)

			if var_196_14 <= arg_193_1.time_ and arg_193_1.time_ < var_196_14 + var_196_21 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_14) / var_196_21

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_14 + var_196_21 and arg_193_1.time_ < var_196_14 + var_196_21 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST2403",
		"SofdecAsset/story/story_104250101.usm",
		"TextureConfig/Background/M01K"
	},
	voices = {
		"story_v_out_425011.awb",
		"story_v_out_424021.awb"
	},
	skipMarkers = {
		425011025
	}
}
