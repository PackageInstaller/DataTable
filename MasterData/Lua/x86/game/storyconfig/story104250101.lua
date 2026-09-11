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

			local var_4_5 = 0.991666666667667

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

			local var_4_8 = 0.991666666667667

			if 0.991666666667667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_8 + 0.174999999998 and arg_1_1.time_ < var_4_8 + 0.174999999998 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_147", "se_story_147_amb_interrogation", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_7_story_interrogation_1", "bgm_activity_4_7_story_interrogation_1", "bgm_activity_4_7_story_interrogation_1.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_activity_4_7_story_interrogation_1", "bgm_activity_4_7_story_interrogation_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			local var_4_16 = 0
			local var_4_17 = manager.audio:GetVoiceLength("story_v_out_425011", "425011001", "story_v_out_425011.awb") / 1000

			if var_4_17 > 0 and 2.633 < var_4_17 and var_4_17 + var_4_16 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_17 + var_4_16
			end

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_425011", "425011001", "story_v_out_425011.awb")
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
			local var_10_9000

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				if arg_7_1.var_.effect10011 then
					Object.Destroy(arg_7_1.var_.effect10011)

					arg_7_1.var_.effect10011 = nil
				end
			end

			local var_10_1

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				local var_10_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_10_2 then
					var_10_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_10_2.radialBlurScale = 1
					var_10_2.radialBlurGradient = 1
					var_10_2.radialBlurIntensity = 1

					if var_10_1 then
						var_10_2.radialBlurTarget = var_10_1.transform
					end
				end
			end

			local var_10_3 = 2.73333333333333

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_3 then
				local var_10_4 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_10_4 then
					var_10_4.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_10_4.radialBlurScale = Mathf.Lerp(1, 0, (arg_7_1.time_ - 0) / var_10_3)
					var_10_4.radialBlurGradient = Mathf.Lerp(1, 0, (arg_7_1.time_ - 0) / var_10_3)
					var_10_4.radialBlurIntensity = Mathf.Lerp(1, 0, (arg_7_1.time_ - 0) / var_10_3)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_3 and arg_7_1.time_ < 0 + var_10_3 + arg_10_0 then
				local var_10_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_10_5 then
					var_10_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_10_5.radialBlurScale = 0
					var_10_5.radialBlurGradient = 0
					var_10_5.radialBlurIntensity = 0
				end
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				local var_10_6 = arg_7_1.var_.effect10012

				if not arg_7_1.var_.effect10012 then
					var_10_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapblink"), manager.ui.mainCamera.transform)
					var_10_6.name = "10012"
					arg_7_1.var_.effect10012 = var_10_6
				else
					var_10_6.transform:SetParent(var_10_9000)
				end

				var_10_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_10_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_10_6.transform.localScale = Vector3.New(var_10_6.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_10_6.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_10_6.transform.localScale.z)
			end

			local var_10_8 = "ST2403"

			if arg_7_1.bgs_.ST2403 == nil then
				local var_10_9 = Object.Instantiate(arg_7_1.paintGo_)

				var_10_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_10_8)
				var_10_9.name = var_10_8
				var_10_9.transform.parent = arg_7_1.stage_.transform
				var_10_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.bgs_[var_10_8] = var_10_9
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				local var_10_10 = arg_7_1.bgs_.ST2403

				arg_7_1.bgs_.ST2403.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_10_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_10_11 = var_10_10:GetComponent("SpriteRenderer")

				if var_10_11 and var_10_11.sprite then
					local var_10_12 = 2 * (var_10_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_10_10.transform.localScale = Vector3.New(var_10_12 / var_10_11.sprite.bounds.size.y < var_10_12 * manager.ui.mainCameraCom_.aspect / var_10_11.sprite.bounds.size.x and var_10_12 * manager.ui.mainCameraCom_.aspect / var_10_11.sprite.bounds.size.x or var_10_12 / var_10_11.sprite.bounds.size.y, var_10_12 / var_10_11.sprite.bounds.size.y < var_10_12 * manager.ui.mainCameraCom_.aspect / var_10_11.sprite.bounds.size.x and var_10_12 * manager.ui.mainCameraCom_.aspect / var_10_11.sprite.bounds.size.x or var_10_12 / var_10_11.sprite.bounds.size.y, 0)
				end

				for iter_10_0, iter_10_1 in pairs(arg_7_1.bgs_) do
					if iter_10_0 ~= "ST2403" then
						iter_10_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_10_13 = 0

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_13 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_14 = 2.73333333333333

			if var_10_13 <= arg_7_1.time_ and arg_7_1.time_ < var_10_13 + var_10_14 then
				local var_10_15 = Color.New(0, 0, 0)

				var_10_15.a = Mathf.Lerp(1, 0, (arg_7_1.time_ - var_10_13) / var_10_14)
				arg_7_1.mask_.color = var_10_15
			end

			if arg_7_1.time_ >= var_10_13 + var_10_14 and arg_7_1.time_ < var_10_13 + var_10_14 + arg_10_0 then
				local var_10_16 = Color.New(0, 0, 0)

				arg_7_1.mask_.enabled = false
				var_10_16.a = 0
				arg_7_1.mask_.color = var_10_16
			end

			if arg_7_1.frameCnt_ <= 1 then
				arg_7_1.dialog_:SetActive(false)
			end

			local var_10_17 = 3.03333333333333
			local var_10_18 = 0.55

			if 3.03333333333333 < arg_7_1.time_ and arg_7_1.time_ <= var_10_17 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_19 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_19:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
					arg_7_1.dialogCg_.alpha = arg_11_0
				end))
				var_10_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[15].name)

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

				local var_10_20 = arg_7_1:GetWordFromCfg(425011002)
				local var_10_21 = arg_7_1:FormatText(var_10_20.content)

				arg_7_1.text_.text = var_10_21

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_23 = 22 <= 0 and var_10_18 or var_10_18 * (utf8.len(var_10_21) / 22)

				if (22 <= 0 and var_10_18 or var_10_18 * (utf8.len(var_10_21) / 22)) > 0 and var_10_18 < var_10_23 then
					arg_7_1.talkMaxDuration = var_10_23
					var_10_17 = var_10_17 + 0.3

					if var_10_23 + var_10_17 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_23 + var_10_17
					end
				end

				arg_7_1.text_.text = var_10_21
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011002", "story_v_out_425011.awb") ~= 0 then
					local var_10_24 = manager.audio:GetVoiceLength("story_v_out_425011", "425011002", "story_v_out_425011.awb") / 1000

					if var_10_24 + var_10_17 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_24 + var_10_17
					end

					if var_10_20.prefab_name ~= "" and arg_7_1.actors_[var_10_20.prefab_name] ~= nil then
						local var_10_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_20.prefab_name].transform, "story_v_out_425011", "425011002", "story_v_out_425011.awb")

						arg_7_1:RecordAudio("425011002", var_10_25)
						arg_7_1:RecordAudio("425011002", var_10_25)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_425011", "425011002", "story_v_out_425011.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_425011", "425011002", "story_v_out_425011.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_26 = var_10_17 + 0.3
			local var_10_27 = math.max(var_10_18, arg_7_1.talkMaxDuration)

			if var_10_17 + 0.3 <= arg_7_1.time_ and arg_7_1.time_ < var_10_26 + var_10_27 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_26) / var_10_27

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_26 + var_10_27 and arg_7_1.time_ < var_10_26 + var_10_27 + arg_10_0 then
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
			local var_16_0 = 0.95

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(425011003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 38 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 38)

				if (38 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 38)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011003", "story_v_out_425011.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011003", "story_v_out_425011.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_425011", "425011003", "story_v_out_425011.awb")

						arg_13_1:RecordAudio("425011003", var_16_6)
						arg_13_1:RecordAudio("425011003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_425011", "425011003", "story_v_out_425011.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_425011", "425011003", "story_v_out_425011.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
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
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			if arg_17_1.time_ >= 0 + 0.366666666666667 and arg_17_1.time_ < 0 + 0.366666666666667 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end

			local var_20_0 = 0
			local var_20_1 = 0.1

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[15].name)

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

				local var_20_2 = arg_17_1:GetWordFromCfg(425011004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 4 <= 0 and var_20_1 or var_20_1 * (utf8.len(var_20_3) / 4)

				if (4 <= 0 and var_20_1 or var_20_1 * (utf8.len(var_20_3) / 4)) > 0 and var_20_1 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011004", "story_v_out_425011.awb") ~= 0 then
					local var_20_6 = manager.audio:GetVoiceLength("story_v_out_425011", "425011004", "story_v_out_425011.awb") / 1000

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end

					if var_20_2.prefab_name ~= "" and arg_17_1.actors_[var_20_2.prefab_name] ~= nil then
						local var_20_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_2.prefab_name].transform, "story_v_out_425011", "425011004", "story_v_out_425011.awb")

						arg_17_1:RecordAudio("425011004", var_20_7)
						arg_17_1:RecordAudio("425011004", var_20_7)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_425011", "425011004", "story_v_out_425011.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_425011", "425011004", "story_v_out_425011.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_8 and arg_17_1.time_ < var_20_0 + var_20_8 + arg_20_0 then
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
			local var_24_0 = 1.3

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(425011005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 52 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 52)

				if (52 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 52)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011005", "story_v_out_425011.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011005", "story_v_out_425011.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_425011", "425011005", "story_v_out_425011.awb")

						arg_21_1:RecordAudio("425011005", var_24_6)
						arg_21_1:RecordAudio("425011005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_425011", "425011005", "story_v_out_425011.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_425011", "425011005", "story_v_out_425011.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
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
			local var_28_0 = 0.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[15].name)

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

				local var_28_1 = arg_25_1:GetWordFromCfg(425011006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 17 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 17)

				if (17 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 17)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011006", "story_v_out_425011.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011006", "story_v_out_425011.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_425011", "425011006", "story_v_out_425011.awb")

						arg_25_1:RecordAudio("425011006", var_28_6)
						arg_25_1:RecordAudio("425011006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_425011", "425011006", "story_v_out_425011.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_425011", "425011006", "story_v_out_425011.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
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
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			if arg_29_1.time_ >= 0 + 0.7 and arg_29_1.time_ < 0 + 0.7 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			local var_32_0 = 0
			local var_32_1 = 0.35

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[15].name)

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

				local var_32_2 = arg_29_1:GetWordFromCfg(425011007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 14 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 14)

				if (14 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 14)) > 0 and var_32_1 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011007", "story_v_out_425011.awb") ~= 0 then
					local var_32_6 = manager.audio:GetVoiceLength("story_v_out_425011", "425011007", "story_v_out_425011.awb") / 1000

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end

					if var_32_2.prefab_name ~= "" and arg_29_1.actors_[var_32_2.prefab_name] ~= nil then
						local var_32_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_2.prefab_name].transform, "story_v_out_425011", "425011007", "story_v_out_425011.awb")

						arg_29_1:RecordAudio("425011007", var_32_7)
						arg_29_1:RecordAudio("425011007", var_32_7)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_425011", "425011007", "story_v_out_425011.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_425011", "425011007", "story_v_out_425011.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
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
			local var_36_0 = 0.95

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(425011008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 38 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 38)

				if (38 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 38)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011008", "story_v_out_425011.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011008", "story_v_out_425011.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_425011", "425011008", "story_v_out_425011.awb")

						arg_33_1:RecordAudio("425011008", var_36_6)
						arg_33_1:RecordAudio("425011008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_425011", "425011008", "story_v_out_425011.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_425011", "425011008", "story_v_out_425011.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
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
			local var_40_9001
			local var_40_9000

			if 4.33333333333333 < arg_37_1.time_ and arg_37_1.time_ <= 4.33333333333333 + arg_40_0 then
				arg_37_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_40_0 = 0.866666666666667

			if 4.33333333333333 <= arg_37_1.time_ and arg_37_1.time_ < 4.33333333333333 + var_40_0 then
				local var_40_1, var_40_2 = math.modf((arg_37_1.time_ - 4.33333333333333) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_40_2 * 0.13, var_40_2 * 0.13, var_40_2 * 0.13) + arg_37_1.var_.shakeOldPos
			end

			if arg_37_1.time_ >= 4.33333333333333 + var_40_0 and arg_37_1.time_ < 4.33333333333333 + var_40_0 + arg_40_0 then
				manager.ui.mainCamera.transform.localPosition = arg_37_1.var_.shakeOldPos
			end

			local var_40_3 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			if arg_37_1.time_ >= var_40_3 + 1.76666666666667 and arg_37_1.time_ < var_40_3 + 1.76666666666667 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end

			if 4.33333333333333 < arg_37_1.time_ and arg_37_1.time_ <= 4.33333333333333 + arg_40_0 then
				local var_40_4 = arg_37_1.var_.effect10091009

				if not arg_37_1.var_.effect10091009 then
					var_40_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple2"), manager.ui.mainCamera.transform)
					var_40_4.name = "1009"
					arg_37_1.var_.effect10091009 = var_40_4
				else
					var_40_4.transform:SetParent(var_40_9001)
				end

				var_40_4.transform.localPosition = Vector3.New(0, 0.12, -1)
				var_40_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.3 < arg_37_1.time_ and arg_37_1.time_ <= 4.3 + arg_40_0 then
				arg_37_1:AudioAction("play", "effect", "se_story_147", "se_story_147_electric_shock_01", "")
			end

			local var_40_7 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			if arg_37_1.time_ >= var_40_7 + 5.9 and arg_37_1.time_ < var_40_7 + 5.9 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end

			if 4.3 < arg_37_1.time_ and arg_37_1.time_ <= 4.3 + arg_40_0 then
				local var_40_8 = arg_37_1.var_.effect100910141

				if not arg_37_1.var_.effect100910141 then
					var_40_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_40_8.name = "10141"
					arg_37_1.var_.effect100910141 = var_40_8
				else
					var_40_8.transform:SetParent(var_40_9000)
				end

				var_40_8.transform.localPosition = Vector3.New(0, 0, 6)
				var_40_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 5.73333333333333 < arg_37_1.time_ and arg_37_1.time_ <= 5.73333333333333 + arg_40_0 then
				if arg_37_1.var_.effect100910141 then
					Object.Destroy(arg_37_1.var_.effect100910141)

					arg_37_1.var_.effect100910141 = nil
				end
			end

			local var_40_11 = 0
			local var_40_12 = 0.9

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[15].name)

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

				local var_40_13 = arg_37_1:GetWordFromCfg(425011009)
				local var_40_14 = arg_37_1:FormatText(var_40_13.content)

				arg_37_1.text_.text = var_40_14

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 36 <= 0 and var_40_12 or var_40_12 * (utf8.len(var_40_14) / 36)

				if (36 <= 0 and var_40_12 or var_40_12 * (utf8.len(var_40_14) / 36)) > 0 and var_40_12 < var_40_16 then
					arg_37_1.talkMaxDuration = var_40_16

					if var_40_16 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_16 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_14
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011009", "story_v_out_425011.awb") ~= 0 then
					local var_40_17 = manager.audio:GetVoiceLength("story_v_out_425011", "425011009", "story_v_out_425011.awb") / 1000

					if var_40_17 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_11
					end

					if var_40_13.prefab_name ~= "" and arg_37_1.actors_[var_40_13.prefab_name] ~= nil then
						local var_40_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_13.prefab_name].transform, "story_v_out_425011", "425011009", "story_v_out_425011.awb")

						arg_37_1:RecordAudio("425011009", var_40_18)
						arg_37_1:RecordAudio("425011009", var_40_18)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_425011", "425011009", "story_v_out_425011.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_425011", "425011009", "story_v_out_425011.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_19 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_19 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_11) / var_40_19

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_11 + var_40_19 and arg_37_1.time_ < var_40_11 + var_40_19 + arg_40_0 then
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
			local var_44_0 = 0.575

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:GetWordFromCfg(425011010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 23 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 23)

				if (23 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 23)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011010", "story_v_out_425011.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011010", "story_v_out_425011.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_425011", "425011010", "story_v_out_425011.awb")

						arg_41_1:RecordAudio("425011010", var_44_6)
						arg_41_1:RecordAudio("425011010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_425011", "425011010", "story_v_out_425011.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_425011", "425011010", "story_v_out_425011.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
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
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			if arg_45_1.time_ >= 0 + 0.3 and arg_45_1.time_ < 0 + 0.3 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			local var_48_0 = 0
			local var_48_1 = 0.075

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[15].name)

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

				local var_48_2 = arg_45_1:GetWordFromCfg(425011011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 3 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 3)

				if (3 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 3)) > 0 and var_48_1 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011011", "story_v_out_425011.awb") ~= 0 then
					local var_48_6 = manager.audio:GetVoiceLength("story_v_out_425011", "425011011", "story_v_out_425011.awb") / 1000

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end

					if var_48_2.prefab_name ~= "" and arg_45_1.actors_[var_48_2.prefab_name] ~= nil then
						local var_48_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_2.prefab_name].transform, "story_v_out_425011", "425011011", "story_v_out_425011.awb")

						arg_45_1:RecordAudio("425011011", var_48_7)
						arg_45_1:RecordAudio("425011011", var_48_7)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_425011", "425011011", "story_v_out_425011.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_425011", "425011011", "story_v_out_425011.awb")
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
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				local var_52_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_52_0 then
					var_52_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_52_0.radialBlurScale = 0
					var_52_0.radialBlurGradient = 0
					var_52_0.radialBlurIntensity = 0

					if nil then
						var_52_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_52_1 = 0.666666666666667

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				local var_52_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_52_2 then
					var_52_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_52_2.radialBlurScale = Mathf.Lerp(0, 1, (arg_49_1.time_ - 0) / var_52_1)
					var_52_2.radialBlurGradient = Mathf.Lerp(0, 1, (arg_49_1.time_ - 0) / var_52_1)
					var_52_2.radialBlurIntensity = Mathf.Lerp(0, 1, (arg_49_1.time_ - 0) / var_52_1)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				local var_52_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_52_3 then
					var_52_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_52_3.radialBlurScale = 1
					var_52_3.radialBlurGradient = 1
					var_52_3.radialBlurIntensity = 1
				end
			end

			local var_52_4 = 0

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			if arg_49_1.time_ >= var_52_4 + 1.53333333333333 and arg_49_1.time_ < var_52_4 + 1.53333333333333 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_52_6 = 0.666666666666667
			local var_52_7 = 1

			if 0.666666666666667 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(425011012).content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 40 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_8) / 40)

				if (40 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_8) / 40)) > 0 and var_52_7 < var_52_10 then
					arg_49_1.talkMaxDuration = var_52_10

					if var_52_10 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_11 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_11 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_11

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_11 and arg_49_1.time_ < var_52_6 + var_52_11 + arg_52_0 then
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
			local var_56_0 = 1.275

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(425011013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 51 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 51)

				if (51 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 51)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011013", "story_v_out_425011.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011013", "story_v_out_425011.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_425011", "425011013", "story_v_out_425011.awb")

						arg_53_1:RecordAudio("425011013", var_56_6)
						arg_53_1:RecordAudio("425011013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_425011", "425011013", "story_v_out_425011.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_425011", "425011013", "story_v_out_425011.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
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
			local var_60_9001
			local var_60_9000

			if 0.8 < arg_57_1.time_ and arg_57_1.time_ <= 0.8 + arg_60_0 then
				arg_57_1:AudioAction("play", "effect", "se_story_147", "se_story_147_electric_shock_02", "")
			end

			local var_60_1 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			if arg_57_1.time_ >= var_60_1 + 1 and arg_57_1.time_ < var_60_1 + 1 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			if 0.8 < arg_57_1.time_ and arg_57_1.time_ <= 0.8 + arg_60_0 then
				local var_60_2 = arg_57_1.var_.effect10091014

				if not arg_57_1.var_.effect10091014 then
					var_60_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple2"), manager.ui.mainCamera.transform)
					var_60_2.name = "1014"
					arg_57_1.var_.effect10091014 = var_60_2
				else
					var_60_2.transform:SetParent(var_60_9001)
				end

				var_60_2.transform.localPosition = Vector3.New(0, 0.12, -1)
				var_60_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_60_4 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			if arg_57_1.time_ >= var_60_4 + 1.5 and arg_57_1.time_ < var_60_4 + 1.5 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			if 0.733333333333333 < arg_57_1.time_ and arg_57_1.time_ <= 0.733333333333333 + arg_60_0 then
				local var_60_5 = arg_57_1.var_.effect100910141

				if not arg_57_1.var_.effect100910141 then
					var_60_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_60_5.name = "10141"
					arg_57_1.var_.effect100910141 = var_60_5
				else
					var_60_5.transform:SetParent(var_60_9000)
				end

				var_60_5.transform.localPosition = Vector3.New(0, 0, 6)
				var_60_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.16666666666667 < arg_57_1.time_ and arg_57_1.time_ <= 2.16666666666667 + arg_60_0 then
				if arg_57_1.var_.effect100910141 then
					Object.Destroy(arg_57_1.var_.effect100910141)

					arg_57_1.var_.effect100910141 = nil
				end
			end

			local var_60_8 = manager.ui.mainCamera.transform

			if 0.8 < arg_57_1.time_ and arg_57_1.time_ <= 0.8 + arg_60_0 then
				arg_57_1.var_.shakeOldPos = var_60_8.localPosition
			end

			local var_60_9 = 0.4

			if 0.8 <= arg_57_1.time_ and arg_57_1.time_ < 0.8 + var_60_9 then
				local var_60_10, var_60_11 = math.modf((arg_57_1.time_ - 0.8) / 0.066)

				var_60_8.localPosition = Vector3.New(var_60_11 * 0.13, var_60_11 * 0.13, var_60_11 * 0.13) + arg_57_1.var_.shakeOldPos
			end

			if arg_57_1.time_ >= 0.8 + var_60_9 and arg_57_1.time_ < 0.8 + var_60_9 + arg_60_0 then
				var_60_8.localPosition = arg_57_1.var_.shakeOldPos
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_12 = 0.875
			local var_60_13 = 0.125

			if 0.875 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
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

				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[15].name)

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

				local var_60_15 = arg_57_1:GetWordFromCfg(425011014)
				local var_60_16 = arg_57_1:FormatText(var_60_15.content)

				arg_57_1.text_.text = var_60_16

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_18 = 5 <= 0 and var_60_13 or var_60_13 * (utf8.len(var_60_16) / 5)

				if (5 <= 0 and var_60_13 or var_60_13 * (utf8.len(var_60_16) / 5)) > 0 and var_60_13 < var_60_18 then
					arg_57_1.talkMaxDuration = var_60_18
					var_60_12 = var_60_12 + 0.3

					if var_60_18 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_18 + var_60_12
					end
				end

				arg_57_1.text_.text = var_60_16
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011014", "story_v_out_425011.awb") ~= 0 then
					local var_60_19 = manager.audio:GetVoiceLength("story_v_out_425011", "425011014", "story_v_out_425011.awb") / 1000

					if var_60_19 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_19 + var_60_12
					end

					if var_60_15.prefab_name ~= "" and arg_57_1.actors_[var_60_15.prefab_name] ~= nil then
						local var_60_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_15.prefab_name].transform, "story_v_out_425011", "425011014", "story_v_out_425011.awb")

						arg_57_1:RecordAudio("425011014", var_60_20)
						arg_57_1:RecordAudio("425011014", var_60_20)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_425011", "425011014", "story_v_out_425011.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_425011", "425011014", "story_v_out_425011.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_21 = var_60_12 + 0.3
			local var_60_22 = math.max(var_60_13, arg_57_1.talkMaxDuration)

			if var_60_12 + 0.3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_21 + var_60_22 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_21) / var_60_22

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_21 + var_60_22 and arg_57_1.time_ < var_60_21 + var_60_22 + arg_60_0 then
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
			local var_66_0 = 0.2

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:GetWordFromCfg(425011015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 8 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 8)

				if (8 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 8)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011015", "story_v_out_425011.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011015", "story_v_out_425011.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_425011", "425011015", "story_v_out_425011.awb")

						arg_63_1:RecordAudio("425011015", var_66_6)
						arg_63_1:RecordAudio("425011015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_425011", "425011015", "story_v_out_425011.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_425011", "425011015", "story_v_out_425011.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
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
			local var_70_0 = 0.05

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[15].name)

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

				local var_70_1 = arg_67_1:GetWordFromCfg(425011016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 2 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 2)

				if (2 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 2)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011016", "story_v_out_425011.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011016", "story_v_out_425011.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_425011", "425011016", "story_v_out_425011.awb")

						arg_67_1:RecordAudio("425011016", var_70_6)
						arg_67_1:RecordAudio("425011016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_425011", "425011016", "story_v_out_425011.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_425011", "425011016", "story_v_out_425011.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
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
			local var_74_0 = 1.125

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:GetWordFromCfg(425011017)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 45 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 45)

				if (45 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 45)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011017", "story_v_out_425011.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011017", "story_v_out_425011.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_425011", "425011017", "story_v_out_425011.awb")

						arg_71_1:RecordAudio("425011017", var_74_6)
						arg_71_1:RecordAudio("425011017", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_425011", "425011017", "story_v_out_425011.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_425011", "425011017", "story_v_out_425011.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
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
			local var_78_0 = 0.375

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:GetWordFromCfg(425011018)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 15 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 15)

				if (15 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 15)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011018", "story_v_out_425011.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011018", "story_v_out_425011.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_425011", "425011018", "story_v_out_425011.awb")

						arg_75_1:RecordAudio("425011018", var_78_6)
						arg_75_1:RecordAudio("425011018", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_425011", "425011018", "story_v_out_425011.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_425011", "425011018", "story_v_out_425011.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
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
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				local var_82_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_82_0 then
					var_82_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_82_0.radialBlurScale = 1
					var_82_0.radialBlurGradient = 1
					var_82_0.radialBlurIntensity = 1

					if nil then
						var_82_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_82_1 = 0.674090198474005

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 then
				local var_82_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_82_2 then
					var_82_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_82_2.radialBlurScale = Mathf.Lerp(1, 0, (arg_79_1.time_ - 0) / var_82_1)
					var_82_2.radialBlurGradient = Mathf.Lerp(1, 0, (arg_79_1.time_ - 0) / var_82_1)
					var_82_2.radialBlurIntensity = Mathf.Lerp(1, 0, (arg_79_1.time_ - 0) / var_82_1)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 then
				local var_82_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_82_3 then
					var_82_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_82_3.radialBlurScale = 0
					var_82_3.radialBlurGradient = 0
					var_82_3.radialBlurIntensity = 0
				end
			end

			local var_82_4 = 0

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			if arg_79_1.time_ >= var_82_4 + 0.774090198474005 and arg_79_1.time_ < var_82_4 + 0.774090198474005 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				if arg_79_1.var_.effect10091014 then
					Object.Destroy(arg_79_1.var_.effect10091014)

					arg_79_1.var_.effect10091014 = nil
				end
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:AudioAction("stop", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_7 = 0.674090198474005
			local var_82_8 = 0.1

			if 0.674090198474005 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_9 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_9:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[15].name)

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

				local var_82_10 = arg_79_1:GetWordFromCfg(425011019)
				local var_82_11 = arg_79_1:FormatText(var_82_10.content)

				arg_79_1.text_.text = var_82_11

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_13 = 4 <= 0 and var_82_8 or var_82_8 * (utf8.len(var_82_11) / 4)

				if (4 <= 0 and var_82_8 or var_82_8 * (utf8.len(var_82_11) / 4)) > 0 and var_82_8 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13
					var_82_7 = var_82_7 + 0.3

					if var_82_13 + var_82_7 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_7
					end
				end

				arg_79_1.text_.text = var_82_11
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011019", "story_v_out_425011.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_425011", "425011019", "story_v_out_425011.awb") / 1000

					if var_82_14 + var_82_7 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_7
					end

					if var_82_10.prefab_name ~= "" and arg_79_1.actors_[var_82_10.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_10.prefab_name].transform, "story_v_out_425011", "425011019", "story_v_out_425011.awb")

						arg_79_1:RecordAudio("425011019", var_82_15)
						arg_79_1:RecordAudio("425011019", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_425011", "425011019", "story_v_out_425011.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_425011", "425011019", "story_v_out_425011.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = var_82_7 + 0.3
			local var_82_17 = math.max(var_82_8, arg_79_1.talkMaxDuration)

			if var_82_7 + 0.3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_16 + var_82_17 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_16) / var_82_17

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_16 + var_82_17 and arg_79_1.time_ < var_82_16 + var_82_17 + arg_82_0 then
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
			local var_88_0 = 0.375

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(425011020)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 15 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 15)

				if (15 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 15)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011020", "story_v_out_425011.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011020", "story_v_out_425011.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_425011", "425011020", "story_v_out_425011.awb")

						arg_85_1:RecordAudio("425011020", var_88_6)
						arg_85_1:RecordAudio("425011020", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_425011", "425011020", "story_v_out_425011.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_425011", "425011020", "story_v_out_425011.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
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
			local var_92_0 = 0.15

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[15].name)

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

				local var_92_1 = arg_89_1:GetWordFromCfg(425011021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 6 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 6)

				if (6 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 6)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011021", "story_v_out_425011.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011021", "story_v_out_425011.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_425011", "425011021", "story_v_out_425011.awb")

						arg_89_1:RecordAudio("425011021", var_92_6)
						arg_89_1:RecordAudio("425011021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_425011", "425011021", "story_v_out_425011.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_425011", "425011021", "story_v_out_425011.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
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
			local var_96_0 = 0.525

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(425011022)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 21 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 21)

				if (21 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 21)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011022", "story_v_out_425011.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011022", "story_v_out_425011.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_425011", "425011022", "story_v_out_425011.awb")

						arg_93_1:RecordAudio("425011022", var_96_6)
						arg_93_1:RecordAudio("425011022", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_425011", "425011022", "story_v_out_425011.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_425011", "425011022", "story_v_out_425011.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
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
			local var_100_0 = 0.4

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[15].name)

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

				local var_100_1 = arg_97_1:GetWordFromCfg(425011023)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 16 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 16)

				if (16 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 16)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011023", "story_v_out_425011.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011023", "story_v_out_425011.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_425011", "425011023", "story_v_out_425011.awb")

						arg_97_1:RecordAudio("425011023", var_100_6)
						arg_97_1:RecordAudio("425011023", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_425011", "425011023", "story_v_out_425011.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_425011", "425011023", "story_v_out_425011.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
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
			local var_104_0 = 1.075

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(425011024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 43 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 43)

				if (43 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 43)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011024", "story_v_out_425011.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011024", "story_v_out_425011.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_425011", "425011024", "story_v_out_425011.awb")

						arg_101_1:RecordAudio("425011024", var_104_6)
						arg_101_1:RecordAudio("425011024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_425011", "425011024", "story_v_out_425011.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_425011", "425011024", "story_v_out_425011.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
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
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_0 = 1.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				local var_108_1 = Color.New(0, 0, 0)

				var_108_1.a = Mathf.Lerp(0, 1, (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.mask_.color = var_108_1
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				local var_108_2 = Color.New(0, 0, 0)

				var_108_2.a = 1
				arg_105_1.mask_.color = var_108_2
			end

			local var_108_3 = 1.2

			if 1.2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_3 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_4 = 1.2

			if var_108_3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_3 + var_108_4 then
				local var_108_5 = Color.New(0, 0, 0)

				var_108_5.a = Mathf.Lerp(1, 0, (arg_105_1.time_ - var_108_3) / var_108_4)
				arg_105_1.mask_.color = var_108_5
			end

			if arg_105_1.time_ >= var_108_3 + var_108_4 and arg_105_1.time_ < var_108_3 + var_108_4 + arg_108_0 then
				local var_108_6 = Color.New(0, 0, 0)

				arg_105_1.mask_.enabled = false
				var_108_6.a = 0
				arg_105_1.mask_.color = var_108_6
			end

			local var_108_7 = 1.2

			if 1.2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 then
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
					arg_105_1.state_ = arg_110_0 and "pause" or "playing"
				end, 10425011)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_108_8 = 45.0416666666667

			if var_108_7 <= arg_105_1.time_ and arg_105_1.time_ < var_108_7 + var_108_8 then
				-- block empty
			end

			if arg_105_1.time_ >= var_108_7 + var_108_8 and arg_105_1.time_ < var_108_7 + var_108_8 + arg_108_0 then
				arg_105_1.marker = ""
			end

			local var_108_9

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				local var_108_10 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_108_10 then
					var_108_10.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_108_10.radialBlurScale = 0
					var_108_10.radialBlurGradient = 0
					var_108_10.radialBlurIntensity = 0

					if var_108_9 then
						var_108_10.radialBlurTarget = var_108_9.transform
					end
				end
			end

			local var_108_11 = 0.0166666666666667

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_11 then
				local var_108_12 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_108_12 then
					var_108_12.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_108_12.radialBlurScale = Mathf.Lerp(0, 0, (arg_105_1.time_ - 0) / var_108_11)
					var_108_12.radialBlurGradient = Mathf.Lerp(0, 0, (arg_105_1.time_ - 0) / var_108_11)
					var_108_12.radialBlurIntensity = Mathf.Lerp(0, 0, (arg_105_1.time_ - 0) / var_108_11)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_11 and arg_105_1.time_ < 0 + var_108_11 + arg_108_0 then
				local var_108_13 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_108_13 then
					var_108_13.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_108_13.radialBlurScale = 0
					var_108_13.radialBlurGradient = 0
					var_108_13.radialBlurIntensity = 0
				end
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				if arg_105_1.var_.effect1001 then
					Object.Destroy(arg_105_1.var_.effect1001)

					arg_105_1.var_.effect1001 = nil
				end
			end

			if 1.2 < arg_105_1.time_ and arg_105_1.time_ <= 1.2 + arg_108_0 then
				arg_105_1:AudioAction("stop", "effect", "se_story_147", "se_story_147_amb_interrogation", "")
			end

			if 1.2 < arg_105_1.time_ and arg_105_1.time_ <= 1.2 + arg_108_0 then
				if arg_105_1.var_.effect10091009 then
					Object.Destroy(arg_105_1.var_.effect10091009)

					arg_105_1.var_.effect10091009 = nil
				end
			end

			if 1.2 < arg_105_1.time_ and arg_105_1.time_ <= 1.2 + arg_108_0 then
				arg_105_1:AudioAction("stop", "effect", "story_v_out_424021", "425011024", "story_v_out_424021.awb")
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
			if 5.60000033333333 < arg_111_1.time_ and arg_111_1.time_ <= 5.60000033333333 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			if arg_111_1.time_ >= 5.60000033333333 + 0.2 and arg_111_1.time_ < 5.60000033333333 + 0.2 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			local var_114_0 = 0

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_1 = 1.2

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_1 then
				local var_114_2 = Color.New(0, 0, 0)

				var_114_2.a = Mathf.Lerp(0, 1, (arg_111_1.time_ - var_114_0) / var_114_1)
				arg_111_1.mask_.color = var_114_2
			end

			if arg_111_1.time_ >= var_114_0 + var_114_1 and arg_111_1.time_ < var_114_0 + var_114_1 + arg_114_0 then
				local var_114_3 = Color.New(0, 0, 0)

				var_114_3.a = 1
				arg_111_1.mask_.color = var_114_3
			end

			local var_114_4 = 1.2

			if 1.2 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_5 = 1.2

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_5 then
				local var_114_6 = Color.New(0, 0, 0)

				var_114_6.a = Mathf.Lerp(1, 0, (arg_111_1.time_ - var_114_4) / var_114_5)
				arg_111_1.mask_.color = var_114_6
			end

			if arg_111_1.time_ >= var_114_4 + var_114_5 and arg_111_1.time_ < var_114_4 + var_114_5 + arg_114_0 then
				local var_114_7 = Color.New(0, 0, 0)

				arg_111_1.mask_.enabled = false
				var_114_7.a = 0
				arg_111_1.mask_.color = var_114_7
			end

			if 4.40000033333333 < arg_111_1.time_ and arg_111_1.time_ <= 4.40000033333333 + arg_114_0 then
				arg_111_1.fswbg_:SetActive(false)
				arg_111_1.dialog_:SetActive(false)
				SetActive(arg_111_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_111_1:ShowNextGo(false)
			end

			local var_114_8 = 1.2

			if 1.2 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				SetActive(arg_111_1.dialog_, true)
				SetActive(arg_111_1.allBtn_.gameObject, true)
				arg_111_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_111_1.isInLoopVideo = false
			end

			local var_114_9 = 0.0166666666666667

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_9 then
				-- block empty
			end

			if arg_111_1.time_ >= var_114_8 + var_114_9 and arg_111_1.time_ < var_114_8 + var_114_9 + arg_114_0 then
				arg_111_1.marker = ""
			end

			local var_114_10 = 1.2

			if 1.2 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1.timestampController_:SetSelectedState("show")
				arg_111_1.timestampAni_:Play("in")

				arg_111_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "M01K")

				arg_111_1.timestampColorController_:SetSelectedState("hot")
				arg_111_1.timeColdImg_:SetAlpha(0.031)

				arg_111_1.text_timeText_.text = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(501098).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_timeText_)

				arg_111_1.text_siteText_.text = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(501099).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_siteText_)
			end

			if arg_111_1.time_ >= var_114_10 + 1.999999999999 and arg_111_1.time_ < var_114_10 + 1.999999999999 + arg_114_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_111_1.timestampAni_, "out", function()
					arg_111_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_114_11 = 3.20000033333333

			if 3.20000033333333 < arg_111_1.time_ and arg_111_1.time_ <= var_114_11 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_12 = 1.2

			if var_114_11 <= arg_111_1.time_ and arg_111_1.time_ < var_114_11 + var_114_12 then
				local var_114_13 = Color.New(0, 0, 0)

				var_114_13.a = Mathf.Lerp(0, 1, (arg_111_1.time_ - var_114_11) / var_114_12)
				arg_111_1.mask_.color = var_114_13
			end

			if arg_111_1.time_ >= var_114_11 + var_114_12 and arg_111_1.time_ < var_114_11 + var_114_12 + arg_114_0 then
				local var_114_14 = Color.New(0, 0, 0)

				var_114_14.a = 1
				arg_111_1.mask_.color = var_114_14
			end

			local var_114_15 = 4.40000033333333

			if 4.40000033333333 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 then
				arg_111_1.mask_.enabled = true
				arg_111_1.mask_.raycastTarget = true

				arg_111_1:SetGaussion(false)
			end

			local var_114_16 = 1.2

			if var_114_15 <= arg_111_1.time_ and arg_111_1.time_ < var_114_15 + var_114_16 then
				local var_114_17 = Color.New(0, 0, 0)

				var_114_17.a = Mathf.Lerp(1, 0, (arg_111_1.time_ - var_114_15) / var_114_16)
				arg_111_1.mask_.color = var_114_17
			end

			if arg_111_1.time_ >= var_114_15 + var_114_16 and arg_111_1.time_ < var_114_15 + var_114_16 + arg_114_0 then
				local var_114_18 = Color.New(0, 0, 0)

				arg_111_1.mask_.enabled = false
				var_114_18.a = 0
				arg_111_1.mask_.color = var_114_18
			end

			local var_114_19 = "M01K"

			if arg_111_1.bgs_.M01K == nil then
				local var_114_20 = Object.Instantiate(arg_111_1.paintGo_)

				var_114_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_114_19)
				var_114_20.name = var_114_19
				var_114_20.transform.parent = arg_111_1.stage_.transform
				var_114_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.bgs_[var_114_19] = var_114_20
			end

			if 1.2 < arg_111_1.time_ and arg_111_1.time_ <= 1.2 + arg_114_0 then
				local var_114_21 = arg_111_1.bgs_.M01K

				arg_111_1.bgs_.M01K.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_114_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_114_22 = var_114_21:GetComponent("SpriteRenderer")

				if var_114_22 and var_114_22.sprite then
					local var_114_23 = 2 * (var_114_21.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_114_21.transform.localScale = Vector3.New(var_114_23 / var_114_22.sprite.bounds.size.y < var_114_23 * manager.ui.mainCameraCom_.aspect / var_114_22.sprite.bounds.size.x and var_114_23 * manager.ui.mainCameraCom_.aspect / var_114_22.sprite.bounds.size.x or var_114_23 / var_114_22.sprite.bounds.size.y, var_114_23 / var_114_22.sprite.bounds.size.y < var_114_23 * manager.ui.mainCameraCom_.aspect / var_114_22.sprite.bounds.size.x and var_114_23 * manager.ui.mainCameraCom_.aspect / var_114_22.sprite.bounds.size.x or var_114_23 / var_114_22.sprite.bounds.size.y, 0)
				end

				for iter_114_0, iter_114_1 in pairs(arg_111_1.bgs_) do
					if iter_114_0 ~= "M01K" then
						iter_114_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_114_24

			if 1.2 < arg_111_1.time_ and arg_111_1.time_ <= 1.2 + arg_114_0 then
				local var_114_25 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_114_25 then
					var_114_25.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_114_25.radialBlurScale = 0
					var_114_25.radialBlurGradient = 0
					var_114_25.radialBlurIntensity = 0

					if var_114_24 then
						var_114_25.radialBlurTarget = var_114_24.transform
					end
				end
			end

			local var_114_26 = 0.0166666666666667

			if 1.2 <= arg_111_1.time_ and arg_111_1.time_ < 1.2 + var_114_26 then
				local var_114_27 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_114_27 then
					var_114_27.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_114_27.radialBlurScale = Mathf.Lerp(0, 0, (arg_111_1.time_ - 1.2) / var_114_26)
					var_114_27.radialBlurGradient = Mathf.Lerp(0, 0, (arg_111_1.time_ - 1.2) / var_114_26)
					var_114_27.radialBlurIntensity = Mathf.Lerp(0, 0, (arg_111_1.time_ - 1.2) / var_114_26)
				end
			end

			if arg_111_1.time_ >= 1.2 + var_114_26 and arg_111_1.time_ < 1.2 + var_114_26 + arg_114_0 then
				local var_114_28 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_114_28 then
					var_114_28.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_114_28.radialBlurScale = 0
					var_114_28.radialBlurGradient = 0
					var_114_28.radialBlurIntensity = 0
				end
			end

			if 1.2 < arg_111_1.time_ and arg_111_1.time_ <= 1.2 + arg_114_0 then
				arg_111_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_114_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_111_1.bgmTxt_.text ~= var_114_31 and arg_111_1.bgmTxt_.text ~= "" then
						if arg_111_1.bgmTxt2_.text ~= "" then
							arg_111_1.bgmTxt_.text = arg_111_1.bgmTxt2_.text
						end

						arg_111_1.bgmTxt2_.text = var_114_31

						arg_111_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_111_1.bgmTxt_.text = var_114_31
						arg_111_1.bgmTxt2_.text = var_114_31
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

			if 4.1 < arg_111_1.time_ and arg_111_1.time_ <= 4.1 + arg_114_0 then
				arg_111_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if 4.1 < arg_111_1.time_ and arg_111_1.time_ <= 4.1 + arg_114_0 then
				arg_111_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_34 = 5.60000033333333
			local var_114_35 = 0.2

			if 5.60000033333333 < arg_111_1.time_ and arg_111_1.time_ <= var_114_34 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_36 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_36:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_111_1.dialogCg_.alpha = arg_117_0
				end))
				var_114_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1430].name)

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

				local var_114_37 = arg_111_1:GetWordFromCfg(425011033)
				local var_114_38 = arg_111_1:FormatText(var_114_37.content)

				arg_111_1.text_.text = var_114_38

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_40 = 8 <= 0 and var_114_35 or var_114_35 * (utf8.len(var_114_38) / 8)

				if (8 <= 0 and var_114_35 or var_114_35 * (utf8.len(var_114_38) / 8)) > 0 and var_114_35 < var_114_40 then
					arg_111_1.talkMaxDuration = var_114_40
					var_114_34 = var_114_34 + 0.3

					if var_114_40 + var_114_34 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_40 + var_114_34
					end
				end

				arg_111_1.text_.text = var_114_38
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011033", "story_v_out_425011.awb") ~= 0 then
					local var_114_41 = manager.audio:GetVoiceLength("story_v_out_425011", "425011033", "story_v_out_425011.awb") / 1000

					if var_114_41 + var_114_34 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_41 + var_114_34
					end

					if var_114_37.prefab_name ~= "" and arg_111_1.actors_[var_114_37.prefab_name] ~= nil then
						local var_114_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_37.prefab_name].transform, "story_v_out_425011", "425011033", "story_v_out_425011.awb")

						arg_111_1:RecordAudio("425011033", var_114_42)
						arg_111_1:RecordAudio("425011033", var_114_42)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_425011", "425011033", "story_v_out_425011.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_425011", "425011033", "story_v_out_425011.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_43 = var_114_34 + 0.3
			local var_114_44 = math.max(var_114_35, arg_111_1.talkMaxDuration)

			if var_114_34 + 0.3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_43 + var_114_44 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_43) / var_114_44

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_43 + var_114_44 and arg_111_1.time_ < var_114_43 + var_114_44 + arg_114_0 then
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
			local var_122_9001
			local var_122_9000

			if 1 < arg_119_1.time_ and arg_119_1.time_ <= 1 + arg_122_0 then
				arg_119_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_122_0 = 0.8

			if 1 <= arg_119_1.time_ and arg_119_1.time_ < 1 + var_122_0 then
				local var_122_1, var_122_2 = math.modf((arg_119_1.time_ - 1) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_122_2 * 0.13, var_122_2 * 0.13, var_122_2 * 0.13) + arg_119_1.var_.shakeOldPos
			end

			if arg_119_1.time_ >= 1 + var_122_0 and arg_119_1.time_ < 1 + var_122_0 + arg_122_0 then
				manager.ui.mainCamera.transform.localPosition = arg_119_1.var_.shakeOldPos
			end

			if 1 < arg_119_1.time_ and arg_119_1.time_ <= 1 + arg_122_0 then
				local var_122_3 = arg_119_1.var_.effect10091034

				if not arg_119_1.var_.effect10091034 then
					var_122_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), manager.ui.mainCamera.transform)
					var_122_3.name = "1034"
					arg_119_1.var_.effect10091034 = var_122_3
				else
					var_122_3.transform:SetParent(var_122_9001)
				end

				var_122_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_122_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.43333333333333 < arg_119_1.time_ and arg_119_1.time_ <= 2.43333333333333 + arg_122_0 then
				if arg_119_1.var_.effect10091009 then
					Object.Destroy(arg_119_1.var_.effect10091009)

					arg_119_1.var_.effect10091009 = nil
				end
			end

			local var_122_6 = 0

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.allBtn_.enabled = false
			end

			if arg_119_1.time_ >= var_122_6 + 2.43333333333333 and arg_119_1.time_ < var_122_6 + 2.43333333333333 + arg_122_0 then
				arg_119_1.allBtn_.enabled = true
			end

			if 0.5 < arg_119_1.time_ and arg_119_1.time_ <= 0.5 + arg_122_0 then
				arg_119_1:AudioAction("play", "effect", "se_story_147", "se_story_147_alarm", "")
			end

			if 1 < arg_119_1.time_ and arg_119_1.time_ <= 1 + arg_122_0 then
				arg_119_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_battle monster", "")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_122_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_119_1.bgmTxt_.text ~= var_122_11 and arg_119_1.bgmTxt_.text ~= "" then
						if arg_119_1.bgmTxt2_.text ~= "" then
							arg_119_1.bgmTxt_.text = arg_119_1.bgmTxt2_.text
						end

						arg_119_1.bgmTxt2_.text = var_122_11

						arg_119_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_119_1.bgmTxt_.text = var_122_11
						arg_119_1.bgmTxt2_.text = var_122_11
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

			if 0.500666666666667 < arg_119_1.time_ and arg_119_1.time_ <= 0.500666666666667 + arg_122_0 then
				arg_119_1:AudioAction("play", "music", "bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy.awb")

				local var_122_14 = manager.audio:GetAudioName("bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy")

				if "" ~= "" then
					if arg_119_1.bgmTxt_.text ~= var_122_14 and arg_119_1.bgmTxt_.text ~= "" then
						if arg_119_1.bgmTxt2_.text ~= "" then
							arg_119_1.bgmTxt_.text = arg_119_1.bgmTxt2_.text
						end

						arg_119_1.bgmTxt2_.text = var_122_14

						arg_119_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_119_1.bgmTxt_.text = var_122_14
						arg_119_1.bgmTxt2_.text = var_122_14
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

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				local var_122_15 = arg_119_1.var_.effect100910344

				if not arg_119_1.var_.effect100910344 then
					var_122_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), manager.ui.mainCamera.transform)
					var_122_15.name = "10344"
					arg_119_1.var_.effect100910344 = var_122_15
				else
					var_122_15.transform:SetParent(var_122_9000)
				end

				var_122_15.transform.localPosition = Vector3.New(0, 0, -2)
				var_122_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_122_15.transform.localScale = Vector3.New(var_122_15.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_122_15.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_122_15.transform.localScale.z)
			end

			if 1.06666666666667 < arg_119_1.time_ and arg_119_1.time_ <= 1.06666666666667 + arg_122_0 then
				arg_119_1:AudioAction("play", "effect", "se_story_147", "se_story_147_battle_down", "")
			end

			local var_122_18 = 0
			local var_122_19 = 1.025

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_18 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_20 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(425011034).content)

				arg_119_1.text_.text = var_122_20

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_22 = 41 <= 0 and var_122_19 or var_122_19 * (utf8.len(var_122_20) / 41)

				if (41 <= 0 and var_122_19 or var_122_19 * (utf8.len(var_122_20) / 41)) > 0 and var_122_19 < var_122_22 then
					arg_119_1.talkMaxDuration = var_122_22

					if var_122_22 + var_122_18 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_22 + var_122_18
					end
				end

				arg_119_1.text_.text = var_122_20
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_23 = math.max(var_122_19, arg_119_1.talkMaxDuration)

			if var_122_18 <= arg_119_1.time_ and arg_119_1.time_ < var_122_18 + var_122_23 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_18) / var_122_23

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_18 + var_122_23 and arg_119_1.time_ < var_122_18 + var_122_23 + arg_122_0 then
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
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				if arg_125_1.var_.effect100910344 then
					Object.Destroy(arg_125_1.var_.effect100910344)

					arg_125_1.var_.effect100910344 = nil
				end
			end

			local var_128_1 = 0
			local var_128_2 = 0.625

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1430].name)

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

				local var_128_3 = arg_125_1:GetWordFromCfg(425011035)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_6 = 25 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_4) / 25)

				if (25 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_4) / 25)) > 0 and var_128_2 < var_128_6 then
					arg_125_1.talkMaxDuration = var_128_6

					if var_128_6 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011035", "story_v_out_425011.awb") ~= 0 then
					local var_128_7 = manager.audio:GetVoiceLength("story_v_out_425011", "425011035", "story_v_out_425011.awb") / 1000

					if var_128_7 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_1
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_425011", "425011035", "story_v_out_425011.awb")

						arg_125_1:RecordAudio("425011035", var_128_8)
						arg_125_1:RecordAudio("425011035", var_128_8)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_425011", "425011035", "story_v_out_425011.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_425011", "425011035", "story_v_out_425011.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_9 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_9 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_9

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_9 and arg_125_1.time_ < var_128_1 + var_128_9 + arg_128_0 then
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
			local var_132_0 = 0.075

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[688].name)

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

				local var_132_1 = arg_129_1:GetWordFromCfg(425011036)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 3 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 3)

				if (3 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 3)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011036", "story_v_out_425011.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011036", "story_v_out_425011.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_425011", "425011036", "story_v_out_425011.awb")

						arg_129_1:RecordAudio("425011036", var_132_6)
						arg_129_1:RecordAudio("425011036", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_425011", "425011036", "story_v_out_425011.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_425011", "425011036", "story_v_out_425011.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
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
			local var_136_0 = 0.475

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[688].name)

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

				local var_136_1 = arg_133_1:GetWordFromCfg(425011037)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 19 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 19)

				if (19 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 19)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011037", "story_v_out_425011.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011037", "story_v_out_425011.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_425011", "425011037", "story_v_out_425011.awb")

						arg_133_1:RecordAudio("425011037", var_136_6)
						arg_133_1:RecordAudio("425011037", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_425011", "425011037", "story_v_out_425011.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_425011", "425011037", "story_v_out_425011.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
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
			local var_140_0 = 0.225

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1430].name)

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

				local var_140_1 = arg_137_1:GetWordFromCfg(425011038)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 9 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 9)

				if (9 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 9)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011038", "story_v_out_425011.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011038", "story_v_out_425011.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_425011", "425011038", "story_v_out_425011.awb")

						arg_137_1:RecordAudio("425011038", var_140_6)
						arg_137_1:RecordAudio("425011038", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_425011", "425011038", "story_v_out_425011.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_425011", "425011038", "story_v_out_425011.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
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
			local var_144_0 = 0.075

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[688].name)

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

				local var_144_1 = arg_141_1:GetWordFromCfg(425011039)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 3 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 3)

				if (3 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 3)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011039", "story_v_out_425011.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011039", "story_v_out_425011.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_425011", "425011039", "story_v_out_425011.awb")

						arg_141_1:RecordAudio("425011039", var_144_6)
						arg_141_1:RecordAudio("425011039", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_425011", "425011039", "story_v_out_425011.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_425011", "425011039", "story_v_out_425011.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
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
			local var_148_0 = 0.45

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1430].name)

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

				local var_148_1 = arg_145_1:GetWordFromCfg(425011040)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 18 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 18)

				if (18 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 18)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011040", "story_v_out_425011.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_425011", "425011040", "story_v_out_425011.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_425011", "425011040", "story_v_out_425011.awb")

						arg_145_1:RecordAudio("425011040", var_148_6)
						arg_145_1:RecordAudio("425011040", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_425011", "425011040", "story_v_out_425011.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_425011", "425011040", "story_v_out_425011.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
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
			if arg_149_1.actors_["1086"] == nil then
				local var_152_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_152_0) then
					local var_152_1 = Object.Instantiate(var_152_0, arg_149_1.canvasGo_.transform)

					var_152_1.transform:SetSiblingIndex(1)

					var_152_1.name = "1086"
					var_152_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_149_1.actors_["1086"] = var_152_1

					if arg_149_1.isInRecall_ then
						for iter_152_0, iter_152_1 in ipairs((var_152_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_152_1.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_152_2 = arg_149_1.actors_["1086"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps1086 == nil then
				arg_149_1.var_.actorSpriteComps1086 = var_152_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_3 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.actorSpriteComps1086 then
					for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_152_3 then
							if arg_149_1.isInRecall_ then
								iter_152_3.color = Color.New(Mathf.Lerp(iter_152_3.color.r, arg_149_1.hightColor1.r, (arg_149_1.time_ - 0) / var_152_3), Mathf.Lerp(iter_152_3.color.g, arg_149_1.hightColor1.g, (arg_149_1.time_ - 0) / var_152_3), (Mathf.Lerp(iter_152_3.color.b, arg_149_1.hightColor1.b, (arg_149_1.time_ - 0) / var_152_3)))
							else
								local var_152_4 = Mathf.Lerp(iter_152_3.color.r, 1, (arg_149_1.time_ - 0) / var_152_3)

								iter_152_3.color = Color.New(var_152_4, var_152_4, var_152_4)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps1086 then
				for iter_152_4, iter_152_5 in pairs(arg_149_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_152_5 then
						iter_152_5.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps1086 = nil
			end

			local var_152_5 = arg_149_1.actors_["1086"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1086 = var_152_5.localPosition
				var_152_5.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("1086", 3)

				for iter_152_6 = 0, var_152_5.childCount - 1 do
					local var_152_6 = var_152_5:GetChild(iter_152_6)

					if var_152_6.name == "split_6" or not string.find(var_152_6.name, "split") then
						var_152_6.gameObject:SetActive(true)
					else
						var_152_6.gameObject:SetActive(false)
					end
				end
			end

			local var_152_7 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				var_152_5.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_149_1.time_ - 0) / var_152_7)
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				var_152_5.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_152_8 = 0
			local var_152_9 = 0.4

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:GetWordFromCfg(425011041)
				local var_152_11 = arg_149_1:FormatText(var_152_10.content)

				arg_149_1.text_.text = var_152_11

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 16 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 16)

				if (16 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 16)) > 0 and var_152_9 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_11
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011041", "story_v_out_425011.awb") ~= 0 then
					local var_152_14 = manager.audio:GetVoiceLength("story_v_out_425011", "425011041", "story_v_out_425011.awb") / 1000

					if var_152_14 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_14 + var_152_8
					end

					if var_152_10.prefab_name ~= "" and arg_149_1.actors_[var_152_10.prefab_name] ~= nil then
						local var_152_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_10.prefab_name].transform, "story_v_out_425011", "425011041", "story_v_out_425011.awb")

						arg_149_1:RecordAudio("425011041", var_152_15)
						arg_149_1:RecordAudio("425011041", var_152_15)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_425011", "425011041", "story_v_out_425011.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_425011", "425011041", "story_v_out_425011.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_16 and arg_149_1.time_ < var_152_8 + var_152_16 + arg_152_0 then
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
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1086"]) and arg_153_1.var_.actorSpriteComps1086 == nil then
				arg_153_1.var_.actorSpriteComps1086 = arg_153_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_0 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1086"]) then
				if arg_153_1.var_.actorSpriteComps1086 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								iter_156_1.color = Color.New(Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor2.r, (arg_153_1.time_ - 0) / var_156_0), Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor2.g, (arg_153_1.time_ - 0) / var_156_0), (Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor2.b, (arg_153_1.time_ - 0) / var_156_0)))
							else
								local var_156_1 = Mathf.Lerp(iter_156_1.color.r, 0.5, (arg_153_1.time_ - 0) / var_156_0)

								iter_156_1.color = Color.New(var_156_1, var_156_1, var_156_1)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1086"]) and arg_153_1.var_.actorSpriteComps1086 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_156_3 then
						iter_156_3.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_153_1.var_.actorSpriteComps1086 = nil
			end

			local var_156_2 = 0
			local var_156_3 = 0.15

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1430].name)

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

				local var_156_4 = arg_153_1:GetWordFromCfg(425011042)
				local var_156_5 = arg_153_1:FormatText(var_156_4.content)

				arg_153_1.text_.text = var_156_5

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_7 = 6 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 6)

				if (6 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 6)) > 0 and var_156_3 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_2
					end
				end

				arg_153_1.text_.text = var_156_5
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011042", "story_v_out_425011.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011042", "story_v_out_425011.awb") / 1000

					if var_156_8 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_2
					end

					if var_156_4.prefab_name ~= "" and arg_153_1.actors_[var_156_4.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_4.prefab_name].transform, "story_v_out_425011", "425011042", "story_v_out_425011.awb")

						arg_153_1:RecordAudio("425011042", var_156_9)
						arg_153_1:RecordAudio("425011042", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_425011", "425011042", "story_v_out_425011.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_425011", "425011042", "story_v_out_425011.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_3, arg_153_1.talkMaxDuration)

			if var_156_2 <= arg_153_1.time_ and arg_153_1.time_ < var_156_2 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_2) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_2 + var_156_10 and arg_153_1.time_ < var_156_2 + var_156_10 + arg_156_0 then
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
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1086"]) and arg_157_1.var_.actorSpriteComps1086 == nil then
				arg_157_1.var_.actorSpriteComps1086 = arg_157_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_0 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1086"]) then
				if arg_157_1.var_.actorSpriteComps1086 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								iter_160_1.color = Color.New(Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor1.r, (arg_157_1.time_ - 0) / var_160_0), Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor1.g, (arg_157_1.time_ - 0) / var_160_0), (Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor1.b, (arg_157_1.time_ - 0) / var_160_0)))
							else
								local var_160_1 = Mathf.Lerp(iter_160_1.color.r, 1, (arg_157_1.time_ - 0) / var_160_0)

								iter_160_1.color = Color.New(var_160_1, var_160_1, var_160_1)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1086"]) and arg_157_1.var_.actorSpriteComps1086 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_160_3 then
						iter_160_3.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps1086 = nil
			end

			local var_160_2 = 0
			local var_160_3 = 0.575

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_4 = arg_157_1:GetWordFromCfg(425011043)
				local var_160_5 = arg_157_1:FormatText(var_160_4.content)

				arg_157_1.text_.text = var_160_5

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_7 = 23 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_5) / 23)

				if (23 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_5) / 23)) > 0 and var_160_3 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_2
					end
				end

				arg_157_1.text_.text = var_160_5
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011043", "story_v_out_425011.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011043", "story_v_out_425011.awb") / 1000

					if var_160_8 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_2
					end

					if var_160_4.prefab_name ~= "" and arg_157_1.actors_[var_160_4.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_4.prefab_name].transform, "story_v_out_425011", "425011043", "story_v_out_425011.awb")

						arg_157_1:RecordAudio("425011043", var_160_9)
						arg_157_1:RecordAudio("425011043", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_425011", "425011043", "story_v_out_425011.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_425011", "425011043", "story_v_out_425011.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_3, arg_157_1.talkMaxDuration)

			if var_160_2 <= arg_157_1.time_ and arg_157_1.time_ < var_160_2 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_2) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_2 + var_160_10 and arg_157_1.time_ < var_160_2 + var_160_10 + arg_160_0 then
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
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:AudioAction("play", "effect", "se_story_147", "se_story_147_dizzy_down", "")
			end

			local var_164_1 = arg_161_1.actors_["1086"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1086 = var_164_1.localPosition
				var_164_1.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1086", 3)

				for iter_164_0 = 0, var_164_1.childCount - 1 do
					local var_164_2 = var_164_1:GetChild(iter_164_0)

					if var_164_2.name == "split_3" then
						var_164_2:SetAsLastSibling()
						var_164_2.gameObject:SetActive(true)

						arg_161_1.var_.actorSpriteSplit1086 = var_164_2.gameObject:GetComponent(typeof(Image))

						arg_161_1.var_.actorSpriteSplit1086:SetAlpha(0)
					end
				end
			end

			local var_164_3 = 0.5

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 then
				var_164_1.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_161_1.time_ - 0) / var_164_3)

				if arg_161_1.var_.actorSpriteSplit1086 ~= nil then
					arg_161_1.var_.actorSpriteSplit1086:SetAlpha((arg_161_1.time_ - 0) / var_164_3)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 then
				var_164_1.localPosition = Vector3.New(0, -404.2, -237.9)

				if arg_161_1.var_.actorSpriteSplit1086 ~= nil then
					arg_161_1.var_.actorSpriteSplit1086:SetAlpha(1)
				end
			end

			local var_164_4 = 0
			local var_164_5 = 0.225

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(425011044)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 9 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 9)

				if (9 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 9)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011044", "story_v_out_425011.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_out_425011", "425011044", "story_v_out_425011.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_out_425011", "425011044", "story_v_out_425011.awb")

						arg_161_1:RecordAudio("425011044", var_164_11)
						arg_161_1:RecordAudio("425011044", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_425011", "425011044", "story_v_out_425011.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_425011", "425011044", "story_v_out_425011.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_12 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_12 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_12

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_12 and arg_161_1.time_ < var_164_4 + var_164_12 + arg_164_0 then
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
			if arg_165_1.actors_["1137"] == nil then
				local var_168_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1137")

				if not isNil(var_168_0) then
					local var_168_1 = Object.Instantiate(var_168_0, arg_165_1.canvasGo_.transform)

					var_168_1.transform:SetSiblingIndex(1)

					var_168_1.name = "1137"
					var_168_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_165_1.actors_["1137"] = var_168_1

					if arg_165_1.isInRecall_ then
						for iter_168_0, iter_168_1 in ipairs((var_168_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_168_1.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_168_2 = arg_165_1.actors_["1137"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1137 == nil then
				arg_165_1.var_.actorSpriteComps1137 = var_168_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_3 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.actorSpriteComps1137 then
					for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_168_3 then
							if arg_165_1.isInRecall_ then
								iter_168_3.color = Color.New(Mathf.Lerp(iter_168_3.color.r, arg_165_1.hightColor1.r, (arg_165_1.time_ - 0) / var_168_3), Mathf.Lerp(iter_168_3.color.g, arg_165_1.hightColor1.g, (arg_165_1.time_ - 0) / var_168_3), (Mathf.Lerp(iter_168_3.color.b, arg_165_1.hightColor1.b, (arg_165_1.time_ - 0) / var_168_3)))
							else
								local var_168_4 = Mathf.Lerp(iter_168_3.color.r, 1, (arg_165_1.time_ - 0) / var_168_3)

								iter_168_3.color = Color.New(var_168_4, var_168_4, var_168_4)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1137 then
				for iter_168_4, iter_168_5 in pairs(arg_165_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_168_5 then
						iter_168_5.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps1137 = nil
			end

			local var_168_5 = arg_165_1.actors_["1086"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.actorSpriteComps1086 == nil then
				arg_165_1.var_.actorSpriteComps1086 = var_168_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_6 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_6 and not isNil(var_168_5) then
				if arg_165_1.var_.actorSpriteComps1086 then
					for iter_168_6, iter_168_7 in pairs(arg_165_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_168_7 then
							if arg_165_1.isInRecall_ then
								iter_168_7.color = Color.New(Mathf.Lerp(iter_168_7.color.r, arg_165_1.hightColor2.r, (arg_165_1.time_ - 0) / var_168_6), Mathf.Lerp(iter_168_7.color.g, arg_165_1.hightColor2.g, (arg_165_1.time_ - 0) / var_168_6), (Mathf.Lerp(iter_168_7.color.b, arg_165_1.hightColor2.b, (arg_165_1.time_ - 0) / var_168_6)))
							else
								local var_168_7 = Mathf.Lerp(iter_168_7.color.r, 0.5, (arg_165_1.time_ - 0) / var_168_6)

								iter_168_7.color = Color.New(var_168_7, var_168_7, var_168_7)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_6 and arg_165_1.time_ < 0 + var_168_6 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.actorSpriteComps1086 then
				for iter_168_8, iter_168_9 in pairs(arg_165_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_168_9 then
						iter_168_9.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_165_1.var_.actorSpriteComps1086 = nil
			end

			local var_168_8 = arg_165_1.actors_["1086"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1086 = var_168_8.localPosition
				var_168_8.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1086", 7)

				for iter_168_10 = 0, var_168_8.childCount - 1 do
					local var_168_9 = var_168_8:GetChild(iter_168_10)

					if var_168_9.name == "" or not string.find(var_168_9.name, "split") then
						var_168_9.gameObject:SetActive(true)
					else
						var_168_9.gameObject:SetActive(false)
					end
				end
			end

			local var_168_10 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_10 then
				var_168_8.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_165_1.time_ - 0) / var_168_10)
			end

			if arg_165_1.time_ >= 0 + var_168_10 and arg_165_1.time_ < 0 + var_168_10 + arg_168_0 then
				var_168_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_168_11 = arg_165_1.actors_["1137"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1137 = var_168_11.localPosition
				var_168_11.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1137", 3)

				for iter_168_11 = 0, var_168_11.childCount - 1 do
					local var_168_12 = var_168_11:GetChild(iter_168_11)

					if var_168_12.name == "split_5" or not string.find(var_168_12.name, "split") then
						var_168_12.gameObject:SetActive(true)
					else
						var_168_12.gameObject:SetActive(false)
					end
				end
			end

			local var_168_13 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_13 then
				var_168_11.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1137, Vector3.New(0, -425, -200), (arg_165_1.time_ - 0) / var_168_13)
			end

			if arg_165_1.time_ >= 0 + var_168_13 and arg_165_1.time_ < 0 + var_168_13 + arg_168_0 then
				var_168_11.localPosition = Vector3.New(0, -425, -200)
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				local var_168_14 = arg_165_1.actors_["1137"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_168_14 then
					arg_165_1.var_.alphaOldValue1137 = var_168_14.alpha
					arg_165_1.var_.characterEffect1137 = var_168_14
				end

				arg_165_1.var_.alphaOldValue1137 = 0
			end

			local var_168_15 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_15 then
				if arg_165_1.var_.characterEffect1137 then
					arg_165_1.var_.characterEffect1137.alpha = Mathf.Lerp(arg_165_1.var_.alphaOldValue1137, 1, (arg_165_1.time_ - 0) / var_168_15)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_15 and arg_165_1.time_ < 0 + var_168_15 + arg_168_0 and arg_165_1.var_.characterEffect1137 then
				arg_165_1.var_.characterEffect1137.alpha = 1
			end

			local var_168_16 = 0
			local var_168_17 = 0.1

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_18 = arg_165_1:GetWordFromCfg(425011045)
				local var_168_19 = arg_165_1:FormatText(var_168_18.content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_21 = 4 <= 0 and var_168_17 or var_168_17 * (utf8.len(var_168_19) / 4)

				if (4 <= 0 and var_168_17 or var_168_17 * (utf8.len(var_168_19) / 4)) > 0 and var_168_17 < var_168_21 then
					arg_165_1.talkMaxDuration = var_168_21

					if var_168_21 + var_168_16 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_21 + var_168_16
					end
				end

				arg_165_1.text_.text = var_168_19
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011045", "story_v_out_425011.awb") ~= 0 then
					local var_168_22 = manager.audio:GetVoiceLength("story_v_out_425011", "425011045", "story_v_out_425011.awb") / 1000

					if var_168_22 + var_168_16 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_16
					end

					if var_168_18.prefab_name ~= "" and arg_165_1.actors_[var_168_18.prefab_name] ~= nil then
						local var_168_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_18.prefab_name].transform, "story_v_out_425011", "425011045", "story_v_out_425011.awb")

						arg_165_1:RecordAudio("425011045", var_168_23)
						arg_165_1:RecordAudio("425011045", var_168_23)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_425011", "425011045", "story_v_out_425011.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_425011", "425011045", "story_v_out_425011.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_24 = math.max(var_168_17, arg_165_1.talkMaxDuration)

			if var_168_16 <= arg_165_1.time_ and arg_165_1.time_ < var_168_16 + var_168_24 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_16) / var_168_24

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_16 + var_168_24 and arg_165_1.time_ < var_168_16 + var_168_24 + arg_168_0 then
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
			local var_172_9000

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1137 = arg_169_1.actors_["1137"].transform.localPosition
				arg_169_1.actors_["1137"].transform.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("1137", 7)

				for iter_172_0 = 0, arg_169_1.actors_["1137"].transform.childCount - 1 do
					local var_172_0 = arg_169_1.actors_["1137"].transform:GetChild(iter_172_0)

					if var_172_0.name == "" or not string.find(var_172_0.name, "split") then
						var_172_0.gameObject:SetActive(true)
					else
						var_172_0.gameObject:SetActive(false)
					end
				end
			end

			local var_172_1 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 then
				arg_169_1.actors_["1137"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_169_1.time_ - 0) / var_172_1)
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				arg_169_1.actors_["1137"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_172_2

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				local var_172_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_172_3 then
					var_172_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_172_3.radialBlurScale = 0
					var_172_3.radialBlurGradient = 0.5
					var_172_3.radialBlurIntensity = 0.5

					if var_172_2 then
						var_172_3.radialBlurTarget = var_172_2.transform
					end
				end
			end

			local var_172_4 = 1

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				local var_172_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_172_5 then
					var_172_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_172_5.radialBlurScale = Mathf.Lerp(0, 1, (arg_169_1.time_ - 0) / var_172_4)
					var_172_5.radialBlurGradient = Mathf.Lerp(0.5, 1, (arg_169_1.time_ - 0) / var_172_4)
					var_172_5.radialBlurIntensity = Mathf.Lerp(0.5, 1, (arg_169_1.time_ - 0) / var_172_4)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				local var_172_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_172_6 then
					var_172_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_172_6.radialBlurScale = 1
					var_172_6.radialBlurGradient = 1
					var_172_6.radialBlurIntensity = 1
				end
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				local var_172_7 = arg_169_1.var_.effect100910461

				if not arg_169_1.var_.effect100910461 then
					var_172_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple2"), manager.ui.mainCamera.transform)
					var_172_7.name = "10461"
					arg_169_1.var_.effect100910461 = var_172_7
				else
					var_172_7.transform:SetParent(var_172_9000)
				end

				var_172_7.transform.localPosition = Vector3.New(0, 0.12, -1)
				var_172_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:AudioAction("play", "effect", "se_story_147", "se_story_147_electric_shock_01", "")
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_10 = 1
			local var_172_11 = 1.45

			if 1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_12 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_12:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_13 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(425011046).content)

				arg_169_1.text_.text = var_172_13

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_15 = 58 <= 0 and var_172_11 or var_172_11 * (utf8.len(var_172_13) / 58)

				if (58 <= 0 and var_172_11 or var_172_11 * (utf8.len(var_172_13) / 58)) > 0 and var_172_11 < var_172_15 then
					arg_169_1.talkMaxDuration = var_172_15
					var_172_10 = var_172_10 + 0.3

					if var_172_15 + var_172_10 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_15 + var_172_10
					end
				end

				arg_169_1.text_.text = var_172_13
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_16 = var_172_10 + 0.3
			local var_172_17 = math.max(var_172_11, arg_169_1.talkMaxDuration)

			if var_172_10 + 0.3 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_17 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_16) / var_172_17

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 then
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
			if 0.400666666666667 < arg_175_1.time_ and arg_175_1.time_ <= 0.400666666666667 + arg_178_0 and not isNil(arg_175_1.actors_["1086"]) and arg_175_1.var_.actorSpriteComps1086 == nil then
				arg_175_1.var_.actorSpriteComps1086 = arg_175_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_0 = 0.2

			if 0.400666666666667 <= arg_175_1.time_ and arg_175_1.time_ < 0.400666666666667 + var_178_0 and not isNil(arg_175_1.actors_["1086"]) then
				if arg_175_1.var_.actorSpriteComps1086 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_178_1 then
							if arg_175_1.isInRecall_ then
								iter_178_1.color = Color.New(Mathf.Lerp(iter_178_1.color.r, arg_175_1.hightColor1.r, (arg_175_1.time_ - 0.400666666666667) / var_178_0), Mathf.Lerp(iter_178_1.color.g, arg_175_1.hightColor1.g, (arg_175_1.time_ - 0.400666666666667) / var_178_0), (Mathf.Lerp(iter_178_1.color.b, arg_175_1.hightColor1.b, (arg_175_1.time_ - 0.400666666666667) / var_178_0)))
							else
								local var_178_1 = Mathf.Lerp(iter_178_1.color.r, 1, (arg_175_1.time_ - 0.400666666666667) / var_178_0)

								iter_178_1.color = Color.New(var_178_1, var_178_1, var_178_1)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0.400666666666667 + var_178_0 and arg_175_1.time_ < 0.400666666666667 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1086"]) and arg_175_1.var_.actorSpriteComps1086 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_178_3 then
						iter_178_3.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_175_1.var_.actorSpriteComps1086 = nil
			end

			local var_178_2 = arg_175_1.actors_["1086"].transform

			if 0.400666666666667 < arg_175_1.time_ and arg_175_1.time_ <= 0.400666666666667 + arg_178_0 then
				arg_175_1.var_.moveOldPos1086 = var_178_2.localPosition
				var_178_2.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("1086", 3)

				for iter_178_4 = 0, var_178_2.childCount - 1 do
					local var_178_3 = var_178_2:GetChild(iter_178_4)

					if var_178_3.name == "split_6" or not string.find(var_178_3.name, "split") then
						var_178_3.gameObject:SetActive(true)
					else
						var_178_3.gameObject:SetActive(false)
					end
				end
			end

			local var_178_4 = 0.001

			if 0.400666666666667 <= arg_175_1.time_ and arg_175_1.time_ < 0.400666666666667 + var_178_4 then
				var_178_2.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_175_1.time_ - 0.400666666666667) / var_178_4)
			end

			if arg_175_1.time_ >= 0.400666666666667 + var_178_4 and arg_175_1.time_ < 0.400666666666667 + var_178_4 + arg_178_0 then
				var_178_2.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_178_5

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				local var_178_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_178_6 then
					var_178_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_178_6.radialBlurScale = 1
					var_178_6.radialBlurGradient = 1
					var_178_6.radialBlurIntensity = 1

					if var_178_5 then
						var_178_6.radialBlurTarget = var_178_5.transform
					end
				end
			end

			local var_178_7 = 0.400666666666667

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				local var_178_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_178_8 then
					var_178_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_178_8.radialBlurScale = Mathf.Lerp(1, 0.5, (arg_175_1.time_ - 0) / var_178_7)
					var_178_8.radialBlurGradient = Mathf.Lerp(1, 1, (arg_175_1.time_ - 0) / var_178_7)
					var_178_8.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_175_1.time_ - 0) / var_178_7)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				local var_178_9 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_178_9 then
					var_178_9.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_178_9.radialBlurScale = 0.5
					var_178_9.radialBlurGradient = 1
					var_178_9.radialBlurIntensity = 1
				end
			end

			local var_178_10

			if 0.434666666666667 < arg_175_1.time_ and arg_175_1.time_ <= 0.434666666666667 + arg_178_0 then
				local var_178_11 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_178_11 then
					var_178_11.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_178_11.radialBlurScale = 0.5
					var_178_11.radialBlurGradient = 0
					var_178_11.radialBlurIntensity = 0

					if var_178_10 then
						var_178_11.radialBlurTarget = var_178_10.transform
					end
				end
			end

			local var_178_12 = 0.366666666666667

			if 0.434666666666667 <= arg_175_1.time_ and arg_175_1.time_ < 0.434666666666667 + var_178_12 then
				local var_178_13 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_178_13 then
					var_178_13.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_178_13.radialBlurScale = Mathf.Lerp(0.5, 0, (arg_175_1.time_ - 0.434666666666667) / var_178_12)
					var_178_13.radialBlurGradient = Mathf.Lerp(0, 0, (arg_175_1.time_ - 0.434666666666667) / var_178_12)
					var_178_13.radialBlurIntensity = Mathf.Lerp(0, 0, (arg_175_1.time_ - 0.434666666666667) / var_178_12)
				end
			end

			if arg_175_1.time_ >= 0.434666666666667 + var_178_12 and arg_175_1.time_ < 0.434666666666667 + var_178_12 + arg_178_0 then
				local var_178_14 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_178_14 then
					var_178_14.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_178_14.radialBlurScale = 0
					var_178_14.radialBlurGradient = 0
					var_178_14.radialBlurIntensity = 0
				end
			end

			if 0.299999999998 < arg_175_1.time_ and arg_175_1.time_ <= 0.299999999998 + arg_178_0 then
				arg_175_1:AudioAction("stop", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if 0.299999999999 < arg_175_1.time_ and arg_175_1.time_ <= 0.299999999999 + arg_178_0 then
				arg_175_1:AudioAction("play", "effect", "se_story_147", "se_story_147_clap", "")
			end

			if 0.400666666666667 < arg_175_1.time_ and arg_175_1.time_ <= 0.400666666666667 + arg_178_0 then
				if arg_175_1.var_.effect100910461 then
					Object.Destroy(arg_175_1.var_.effect100910461)

					arg_175_1.var_.effect100910461 = nil
				end
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_18 = 0.400666666666667
			local var_178_19 = 0.175

			if 0.400666666666667 < arg_175_1.time_ and arg_175_1.time_ <= var_178_18 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_20 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_20:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_21 = arg_175_1:GetWordFromCfg(425011047)
				local var_178_22 = arg_175_1:FormatText(var_178_21.content)

				arg_175_1.text_.text = var_178_22

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_24 = 7 <= 0 and var_178_19 or var_178_19 * (utf8.len(var_178_22) / 7)

				if (7 <= 0 and var_178_19 or var_178_19 * (utf8.len(var_178_22) / 7)) > 0 and var_178_19 < var_178_24 then
					arg_175_1.talkMaxDuration = var_178_24
					var_178_18 = var_178_18 + 0.3

					if var_178_24 + var_178_18 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_24 + var_178_18
					end
				end

				arg_175_1.text_.text = var_178_22
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011047", "story_v_out_425011.awb") ~= 0 then
					local var_178_25 = manager.audio:GetVoiceLength("story_v_out_425011", "425011047", "story_v_out_425011.awb") / 1000

					if var_178_25 + var_178_18 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_25 + var_178_18
					end

					if var_178_21.prefab_name ~= "" and arg_175_1.actors_[var_178_21.prefab_name] ~= nil then
						local var_178_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_21.prefab_name].transform, "story_v_out_425011", "425011047", "story_v_out_425011.awb")

						arg_175_1:RecordAudio("425011047", var_178_26)
						arg_175_1:RecordAudio("425011047", var_178_26)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_425011", "425011047", "story_v_out_425011.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_425011", "425011047", "story_v_out_425011.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_27 = var_178_18 + 0.3
			local var_178_28 = math.max(var_178_19, arg_175_1.talkMaxDuration)

			if var_178_18 + 0.3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_27 + var_178_28 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_27) / var_178_28

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_27 + var_178_28 and arg_175_1.time_ < var_178_27 + var_178_28 + arg_178_0 then
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
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1137"]) and arg_181_1.var_.actorSpriteComps1137 == nil then
				arg_181_1.var_.actorSpriteComps1137 = arg_181_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_0 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1137"]) then
				if arg_181_1.var_.actorSpriteComps1137 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								iter_184_1.color = Color.New(Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_0), Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_0), (Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_0)))
							else
								local var_184_1 = Mathf.Lerp(iter_184_1.color.r, 1, (arg_181_1.time_ - 0) / var_184_0)

								iter_184_1.color = Color.New(var_184_1, var_184_1, var_184_1)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1137"]) and arg_181_1.var_.actorSpriteComps1137 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_184_3 then
						iter_184_3.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps1137 = nil
			end

			local var_184_2 = arg_181_1.actors_["1086"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps1086 == nil then
				arg_181_1.var_.actorSpriteComps1086 = var_184_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_3 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.actorSpriteComps1086 then
					for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_184_5 then
							if arg_181_1.isInRecall_ then
								iter_184_5.color = Color.New(Mathf.Lerp(iter_184_5.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_3), Mathf.Lerp(iter_184_5.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_3), (Mathf.Lerp(iter_184_5.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_3)))
							else
								local var_184_4 = Mathf.Lerp(iter_184_5.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_3)

								iter_184_5.color = Color.New(var_184_4, var_184_4, var_184_4)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps1086 then
				for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_184_7 then
						iter_184_7.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps1086 = nil
			end

			local var_184_5 = arg_181_1.actors_["1137"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1137 = var_184_5.localPosition
				var_184_5.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("1137", 2)

				for iter_184_8 = 0, var_184_5.childCount - 1 do
					local var_184_6 = var_184_5:GetChild(iter_184_8)

					if var_184_6.name == "split_5" or not string.find(var_184_6.name, "split") then
						var_184_6.gameObject:SetActive(true)
					else
						var_184_6.gameObject:SetActive(false)
					end
				end
			end

			local var_184_7 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				var_184_5.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1137, Vector3.New(-390, -425, -200), (arg_181_1.time_ - 0) / var_184_7)
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				var_184_5.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_184_8 = arg_181_1.actors_["1086"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1086 = var_184_8.localPosition
				var_184_8.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("1086", 4)

				for iter_184_9 = 0, var_184_8.childCount - 1 do
					local var_184_9 = var_184_8:GetChild(iter_184_9)

					if var_184_9.name == "" or not string.find(var_184_9.name, "split") then
						var_184_9.gameObject:SetActive(true)
					else
						var_184_9.gameObject:SetActive(false)
					end
				end
			end

			local var_184_10 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_10 then
				var_184_8.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_181_1.time_ - 0) / var_184_10)
			end

			if arg_181_1.time_ >= 0 + var_184_10 and arg_181_1.time_ < 0 + var_184_10 + arg_184_0 then
				var_184_8.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_184_11 = 0
			local var_184_12 = 0.225

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_11 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_13 = arg_181_1:GetWordFromCfg(425011048)
				local var_184_14 = arg_181_1:FormatText(var_184_13.content)

				arg_181_1.text_.text = var_184_14

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_16 = 9 <= 0 and var_184_12 or var_184_12 * (utf8.len(var_184_14) / 9)

				if (9 <= 0 and var_184_12 or var_184_12 * (utf8.len(var_184_14) / 9)) > 0 and var_184_12 < var_184_16 then
					arg_181_1.talkMaxDuration = var_184_16

					if var_184_16 + var_184_11 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_16 + var_184_11
					end
				end

				arg_181_1.text_.text = var_184_14
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011048", "story_v_out_425011.awb") ~= 0 then
					local var_184_17 = manager.audio:GetVoiceLength("story_v_out_425011", "425011048", "story_v_out_425011.awb") / 1000

					if var_184_17 + var_184_11 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_17 + var_184_11
					end

					if var_184_13.prefab_name ~= "" and arg_181_1.actors_[var_184_13.prefab_name] ~= nil then
						local var_184_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_13.prefab_name].transform, "story_v_out_425011", "425011048", "story_v_out_425011.awb")

						arg_181_1:RecordAudio("425011048", var_184_18)
						arg_181_1:RecordAudio("425011048", var_184_18)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_425011", "425011048", "story_v_out_425011.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_425011", "425011048", "story_v_out_425011.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_19 = math.max(var_184_12, arg_181_1.talkMaxDuration)

			if var_184_11 <= arg_181_1.time_ and arg_181_1.time_ < var_184_11 + var_184_19 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_11) / var_184_19

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_11 + var_184_19 and arg_181_1.time_ < var_184_11 + var_184_19 + arg_184_0 then
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
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1086"]) and arg_185_1.var_.actorSpriteComps1086 == nil then
				arg_185_1.var_.actorSpriteComps1086 = arg_185_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_0 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1086"]) then
				if arg_185_1.var_.actorSpriteComps1086 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								iter_188_1.color = Color.New(Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor1.r, (arg_185_1.time_ - 0) / var_188_0), Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor1.g, (arg_185_1.time_ - 0) / var_188_0), (Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor1.b, (arg_185_1.time_ - 0) / var_188_0)))
							else
								local var_188_1 = Mathf.Lerp(iter_188_1.color.r, 1, (arg_185_1.time_ - 0) / var_188_0)

								iter_188_1.color = Color.New(var_188_1, var_188_1, var_188_1)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1086"]) and arg_185_1.var_.actorSpriteComps1086 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_188_3 then
						iter_188_3.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_185_1.var_.actorSpriteComps1086 = nil
			end

			local var_188_2 = arg_185_1.actors_["1137"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps1137 == nil then
				arg_185_1.var_.actorSpriteComps1137 = var_188_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_3 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.actorSpriteComps1137 then
					for iter_188_4, iter_188_5 in pairs(arg_185_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_188_5 then
							if arg_185_1.isInRecall_ then
								iter_188_5.color = Color.New(Mathf.Lerp(iter_188_5.color.r, arg_185_1.hightColor2.r, (arg_185_1.time_ - 0) / var_188_3), Mathf.Lerp(iter_188_5.color.g, arg_185_1.hightColor2.g, (arg_185_1.time_ - 0) / var_188_3), (Mathf.Lerp(iter_188_5.color.b, arg_185_1.hightColor2.b, (arg_185_1.time_ - 0) / var_188_3)))
							else
								local var_188_4 = Mathf.Lerp(iter_188_5.color.r, 0.5, (arg_185_1.time_ - 0) / var_188_3)

								iter_188_5.color = Color.New(var_188_4, var_188_4, var_188_4)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps1137 then
				for iter_188_6, iter_188_7 in pairs(arg_185_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_188_7 then
						iter_188_7.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps1137 = nil
			end

			local var_188_5 = arg_185_1.actors_["1086"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1086 = var_188_5.localPosition
				var_188_5.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("1086", 4)

				for iter_188_8 = 0, var_188_5.childCount - 1 do
					local var_188_6 = var_188_5:GetChild(iter_188_8)

					if var_188_6.name == "split_2" then
						var_188_6:SetAsLastSibling()
						var_188_6.gameObject:SetActive(true)

						arg_185_1.var_.actorSpriteSplit1086 = var_188_6.gameObject:GetComponent(typeof(Image))

						arg_185_1.var_.actorSpriteSplit1086:SetAlpha(0)
					end
				end
			end

			local var_188_7 = 0.5

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				var_188_5.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_185_1.time_ - 0) / var_188_7)

				if arg_185_1.var_.actorSpriteSplit1086 ~= nil then
					arg_185_1.var_.actorSpriteSplit1086:SetAlpha((arg_185_1.time_ - 0) / var_188_7)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				var_188_5.localPosition = Vector3.New(390, -404.2, -237.9)

				if arg_185_1.var_.actorSpriteSplit1086 ~= nil then
					arg_185_1.var_.actorSpriteSplit1086:SetAlpha(1)
				end
			end

			local var_188_8 = 0
			local var_188_9 = 0.775

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(425011049)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 31 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 31)

				if (31 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 31)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011049", "story_v_out_425011.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_425011", "425011049", "story_v_out_425011.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_425011", "425011049", "story_v_out_425011.awb")

						arg_185_1:RecordAudio("425011049", var_188_15)
						arg_185_1:RecordAudio("425011049", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_425011", "425011049", "story_v_out_425011.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_425011", "425011049", "story_v_out_425011.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_16 and arg_185_1.time_ < var_188_8 + var_188_16 + arg_188_0 then
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
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1086 = arg_189_1.actors_["1086"].transform.localPosition
				arg_189_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1086", 4)

				for iter_192_0 = 0, arg_189_1.actors_["1086"].transform.childCount - 1 do
					local var_192_0 = arg_189_1.actors_["1086"].transform:GetChild(iter_192_0)

					if var_192_0.name == "split_6" then
						var_192_0:SetAsLastSibling()
						var_192_0.gameObject:SetActive(true)

						arg_189_1.var_.actorSpriteSplit1086 = var_192_0.gameObject:GetComponent(typeof(Image))

						arg_189_1.var_.actorSpriteSplit1086:SetAlpha(0)
					end
				end
			end

			local var_192_1 = 0.5

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_189_1.time_ - 0) / var_192_1)

				if arg_189_1.var_.actorSpriteSplit1086 ~= nil then
					arg_189_1.var_.actorSpriteSplit1086:SetAlpha((arg_189_1.time_ - 0) / var_192_1)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["1086"].transform.localPosition = Vector3.New(390, -404.2, -237.9)

				if arg_189_1.var_.actorSpriteSplit1086 ~= nil then
					arg_189_1.var_.actorSpriteSplit1086:SetAlpha(1)
				end
			end

			local var_192_2 = 0
			local var_192_3 = 0.575

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_4 = arg_189_1:GetWordFromCfg(425011050)
				local var_192_5 = arg_189_1:FormatText(var_192_4.content)

				arg_189_1.text_.text = var_192_5

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_7 = 23 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_5) / 23)

				if (23 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_5) / 23)) > 0 and var_192_3 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_2
					end
				end

				arg_189_1.text_.text = var_192_5
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425011", "425011050", "story_v_out_425011.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_425011", "425011050", "story_v_out_425011.awb") / 1000

					if var_192_8 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_2
					end

					if var_192_4.prefab_name ~= "" and arg_189_1.actors_[var_192_4.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_4.prefab_name].transform, "story_v_out_425011", "425011050", "story_v_out_425011.awb")

						arg_189_1:RecordAudio("425011050", var_192_9)
						arg_189_1:RecordAudio("425011050", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_425011", "425011050", "story_v_out_425011.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_425011", "425011050", "story_v_out_425011.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_3, arg_189_1.talkMaxDuration)

			if var_192_2 <= arg_189_1.time_ and arg_189_1.time_ < var_192_2 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_2) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_2 + var_192_10 and arg_189_1.time_ < var_192_2 + var_192_10 + arg_192_0 then
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
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1137 = arg_193_1.actors_["1137"].transform.localPosition
				arg_193_1.actors_["1137"].transform.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1137", 7)

				for iter_196_0 = 0, arg_193_1.actors_["1137"].transform.childCount - 1 do
					local var_196_0 = arg_193_1.actors_["1137"].transform:GetChild(iter_196_0)

					if var_196_0.name == "" or not string.find(var_196_0.name, "split") then
						var_196_0.gameObject:SetActive(true)
					else
						var_196_0.gameObject:SetActive(false)
					end
				end
			end

			local var_196_1 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_1 then
				arg_193_1.actors_["1137"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_193_1.time_ - 0) / var_196_1)
			end

			if arg_193_1.time_ >= 0 + var_196_1 and arg_193_1.time_ < 0 + var_196_1 + arg_196_0 then
				arg_193_1.actors_["1137"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_196_2 = arg_193_1.actors_["1086"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1086 = var_196_2.localPosition
				var_196_2.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1086", 7)

				for iter_196_1 = 0, var_196_2.childCount - 1 do
					local var_196_3 = var_196_2:GetChild(iter_196_1)

					if var_196_3.name == "" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				var_196_2.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_193_1.time_ - 0) / var_196_4)
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				var_196_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_196_5 = 0
			local var_196_6 = 1

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_7 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(425011051).content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 40 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_7) / 40)

				if (40 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_7) / 40)) > 0 and var_196_6 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_5
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_6, arg_193_1.talkMaxDuration)

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_5) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_5 + var_196_10 and arg_193_1.time_ < var_196_5 + var_196_10 + arg_196_0 then
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
