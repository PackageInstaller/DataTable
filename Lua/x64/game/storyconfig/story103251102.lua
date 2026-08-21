return {
	Play325112001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325112001
		arg_1_1.duration_ = 6.5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325112002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2010"

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
				local var_4_5 = arg_1_1.bgs_.ST2010

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
					if iter_4_0 ~= "ST2010" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 0.631675865563254

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_25 = 0.733333333333333

			if var_4_24 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				local var_4_26 = (arg_1_1.time_ - var_4_24) / var_4_25
				local var_4_27 = Color.New(1, 1, 1)

				var_4_27.a = Mathf.Lerp(1, 0, var_4_26)
				arg_1_1.mask_.color = var_4_27
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				local var_4_28 = Color.New(1, 1, 1)
				local var_4_29 = 0

				arg_1_1.mask_.enabled = false
				var_4_28.a = var_4_29
				arg_1_1.mask_.color = var_4_28
			end

			local var_4_30 = 0.1
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "effect"

				arg_1_1:AudioAction(var_4_32, var_4_33, "se_story_148", "se_story_148_amb_drone02", "")
			end

			local var_4_34 = 0.4
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_150", "se_story_150_sword08", "")
			end

			local var_4_38 = 0
			local var_4_39 = 1

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_40 = "play"
				local var_4_41 = "music"

				arg_1_1:AudioAction(var_4_40, var_4_41, "bgm_activity_5_1_story_zhujianlu", "bgm_activity_5_1_story_zhujianlu", "bgm_activity_5_1_story_zhujianlu.awb")

				local var_4_42 = ""
				local var_4_43 = manager.audio:GetAudioName("bgm_activity_5_1_story_zhujianlu", "bgm_activity_5_1_story_zhujianlu")

				if var_4_43 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_43 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_43

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_43
						arg_1_1.bgmTxt2_.text = var_4_43
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_44 = 1.5
			local var_4_45 = 1.2

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_46 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_46:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_47 = arg_1_1:GetWordFromCfg(325112001)
				local var_4_48 = arg_1_1:FormatText(var_4_47.content)

				arg_1_1.text_.text = var_4_48

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_49 = 48
				local var_4_50 = utf8.len(var_4_48)
				local var_4_51 = var_4_49 <= 0 and var_4_45 or var_4_45 * (var_4_50 / var_4_49)

				if var_4_51 > 0 and var_4_45 < var_4_51 then
					arg_1_1.talkMaxDuration = var_4_51
					var_4_44 = var_4_44 + 0.3

					if var_4_51 + var_4_44 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_51 + var_4_44
					end
				end

				arg_1_1.text_.text = var_4_48
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_52 = var_4_44 + 0.3
			local var_4_53 = math.max(var_4_45, arg_1_1.talkMaxDuration)

			if var_4_52 <= arg_1_1.time_ and arg_1_1.time_ < var_4_52 + var_4_53 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_52) / var_4_53

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_52 + var_4_53 and arg_1_1.time_ < var_4_52 + var_4_53 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1.5,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.06666666666667,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325112002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325112002
		arg_8_1.duration_ = 6.8

		local var_8_0 = {
			zh = 6.8,
			ja = 5.966
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325112003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.625

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[1455].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(325112002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 25
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112002", "story_v_out_325112.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_325112", "325112002", "story_v_out_325112.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_325112", "325112002", "story_v_out_325112.awb")

						arg_8_1:RecordAudio("325112002", var_11_9)
						arg_8_1:RecordAudio("325112002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_325112", "325112002", "story_v_out_325112.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_325112", "325112002", "story_v_out_325112.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_10 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_10 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_10

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_10 and arg_8_1.time_ < var_11_0 + var_11_10 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play325112003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325112003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325112004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1059ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_12_1.stage_.transform)

					var_15_2.name = var_15_0
					var_15_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_12_1.actors_[var_15_0] = var_15_2

					local var_15_3 = var_15_2:GetComponentInChildren(typeof(CharacterEffect))

					var_15_3.enabled = true

					local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_2, typeof(DynamicBoneHelper))

					if var_15_4 then
						var_15_4:EnableDynamicBone(false)
					end

					arg_12_1:ShowWeapon(var_15_3.transform, false)

					arg_12_1.var_[var_15_0 .. "Animator"] = var_15_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_12_1.var_[var_15_0 .. "Animator"].applyRootMotion = true
					arg_12_1.var_[var_15_0 .. "LipSync"] = var_15_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_15_5 = arg_12_1.actors_["1059ui_story"].transform
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.moveOldPos1059ui_story = var_15_5.localPosition
			end

			local var_15_7 = 0.001

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7
				local var_15_9 = Vector3.New(0, 100, 0)

				var_15_5.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1059ui_story, var_15_9, var_15_8)

				local var_15_10 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_10.x, var_15_10.y, var_15_10.z)

				local var_15_11 = var_15_5.localEulerAngles

				var_15_11.z = 0
				var_15_11.x = 0
				var_15_5.localEulerAngles = var_15_11
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 then
				var_15_5.localPosition = Vector3.New(0, 100, 0)

				local var_15_12 = manager.ui.mainCamera.transform.position - var_15_5.position

				var_15_5.forward = Vector3.New(var_15_12.x, var_15_12.y, var_15_12.z)

				local var_15_13 = var_15_5.localEulerAngles

				var_15_13.z = 0
				var_15_13.x = 0
				var_15_5.localEulerAngles = var_15_13
			end

			local var_15_14 = arg_12_1.actors_["1059ui_story"]
			local var_15_15 = 0

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1059ui_story == nil then
				arg_12_1.var_.characterEffect1059ui_story = var_15_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_16 = 0.200000002980232

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_16 and not isNil(var_15_14) then
				local var_15_17 = (arg_12_1.time_ - var_15_15) / var_15_16

				if arg_12_1.var_.characterEffect1059ui_story and not isNil(var_15_14) then
					local var_15_18 = Mathf.Lerp(0, 0.5, var_15_17)

					arg_12_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1059ui_story.fillRatio = var_15_18
				end
			end

			if arg_12_1.time_ >= var_15_15 + var_15_16 and arg_12_1.time_ < var_15_15 + var_15_16 + arg_15_0 and not isNil(var_15_14) and arg_12_1.var_.characterEffect1059ui_story then
				local var_15_19 = 0.5

				arg_12_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1059ui_story.fillRatio = var_15_19
			end

			local var_15_20 = 0
			local var_15_21 = 1.125

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_22 = arg_12_1:GetWordFromCfg(325112003)
				local var_15_23 = arg_12_1:FormatText(var_15_22.content)

				arg_12_1.text_.text = var_15_23

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_24 = 45
				local var_15_25 = utf8.len(var_15_23)
				local var_15_26 = var_15_24 <= 0 and var_15_21 or var_15_21 * (var_15_25 / var_15_24)

				if var_15_26 > 0 and var_15_21 < var_15_26 then
					arg_12_1.talkMaxDuration = var_15_26

					if var_15_26 + var_15_20 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_26 + var_15_20
					end
				end

				arg_12_1.text_.text = var_15_23
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_27 = math.max(var_15_21, arg_12_1.talkMaxDuration)

			if var_15_20 <= arg_12_1.time_ and arg_12_1.time_ < var_15_20 + var_15_27 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_20) / var_15_27

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_20 + var_15_27 and arg_12_1.time_ < var_15_20 + var_15_27 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play325112004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325112004
		arg_16_1.duration_ = 6.9

		local var_16_0 = {
			zh = 5.233,
			ja = 6.9
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325112005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.55

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[1455].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(325112004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 22
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112004", "story_v_out_325112.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_325112", "325112004", "story_v_out_325112.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_325112", "325112004", "story_v_out_325112.awb")

						arg_16_1:RecordAudio("325112004", var_19_9)
						arg_16_1:RecordAudio("325112004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325112", "325112004", "story_v_out_325112.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325112", "325112004", "story_v_out_325112.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_10 and arg_16_1.time_ < var_19_0 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play325112005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325112005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325112006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.775

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_2 = arg_20_1:GetWordFromCfg(325112005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 31
				local var_23_5 = utf8.len(var_23_3)
				local var_23_6 = var_23_4 <= 0 and var_23_1 or var_23_1 * (var_23_5 / var_23_4)

				if var_23_6 > 0 and var_23_1 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_7 and arg_20_1.time_ < var_23_0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play325112006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325112006
		arg_24_1.duration_ = 7.27

		local var_24_0 = {
			zh = 6.366,
			ja = 7.266
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play325112007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.55

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[1455].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(325112006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 22
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112006", "story_v_out_325112.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_325112", "325112006", "story_v_out_325112.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_325112", "325112006", "story_v_out_325112.awb")

						arg_24_1:RecordAudio("325112006", var_27_9)
						arg_24_1:RecordAudio("325112006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325112", "325112006", "story_v_out_325112.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325112", "325112006", "story_v_out_325112.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_10 and arg_24_1.time_ < var_27_0 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325112007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325112007
		arg_28_1.duration_ = 9.93

		local var_28_0 = {
			zh = 7.166,
			ja = 9.933
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325112008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "1077ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "1077ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_28_1.stage_.transform)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentInChildren(typeof(CharacterEffect))

					var_31_3.enabled = true

					local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_2, typeof(DynamicBoneHelper))

					if var_31_4 then
						var_31_4:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_3.transform, false)

					arg_28_1.var_[var_31_0 .. "Animator"] = var_31_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_0 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_0 .. "LipSync"] = var_31_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_5 = arg_28_1.actors_["1077ui_story"].transform
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.var_.moveOldPos1077ui_story = var_31_5.localPosition

				local var_31_7 = GameObjectTools.GetOrAddComponent(var_31_5.gameObject, typeof(DynamicBoneHelper))

				if var_31_7 then
					var_31_7:EnableDynamicBone(false)
				end
			end

			local var_31_8 = 0.001

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_8 then
				local var_31_9 = (arg_28_1.time_ - var_31_6) / var_31_8
				local var_31_10 = Vector3.New(-0.03, -1.02, -5.92)

				var_31_5.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1077ui_story, var_31_10, var_31_9)

				local var_31_11 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_11.x, var_31_11.y, var_31_11.z)

				local var_31_12 = var_31_5.localEulerAngles

				var_31_12.z = 0
				var_31_12.x = 0
				var_31_5.localEulerAngles = var_31_12
			end

			if arg_28_1.time_ >= var_31_6 + var_31_8 and arg_28_1.time_ < var_31_6 + var_31_8 + arg_31_0 then
				var_31_5.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_31_13 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_13.x, var_31_13.y, var_31_13.z)

				local var_31_14 = var_31_5.localEulerAngles

				var_31_14.z = 0
				var_31_14.x = 0
				var_31_5.localEulerAngles = var_31_14

				local var_31_15 = GameObjectTools.GetOrAddComponent(var_31_5.gameObject, typeof(DynamicBoneHelper))

				if var_31_15 then
					var_31_15:EnableDynamicBone(true)
				end
			end

			local var_31_16 = arg_28_1.actors_["1077ui_story"]
			local var_31_17 = 0

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect1077ui_story == nil then
				arg_28_1.var_.characterEffect1077ui_story = var_31_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_18 = 0.200000002980232

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_18 and not isNil(var_31_16) then
				local var_31_19 = (arg_28_1.time_ - var_31_17) / var_31_18

				if arg_28_1.var_.characterEffect1077ui_story and not isNil(var_31_16) then
					arg_28_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_17 + var_31_18 and arg_28_1.time_ < var_31_17 + var_31_18 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect1077ui_story then
				arg_28_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_31_20 = 0

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action9_2")
			end

			local var_31_21 = 0

			if var_31_21 < arg_28_1.time_ and arg_28_1.time_ <= var_31_21 + arg_31_0 then
				arg_28_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_31_22 = 0
			local var_31_23 = 0.675

			if var_31_22 < arg_28_1.time_ and arg_28_1.time_ <= var_31_22 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_24 = arg_28_1:FormatText(StoryNameCfg[1467].name)

				arg_28_1.leftNameTxt_.text = var_31_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_25 = arg_28_1:GetWordFromCfg(325112007)
				local var_31_26 = arg_28_1:FormatText(var_31_25.content)

				arg_28_1.text_.text = var_31_26

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_27 = 27
				local var_31_28 = utf8.len(var_31_26)
				local var_31_29 = var_31_27 <= 0 and var_31_23 or var_31_23 * (var_31_28 / var_31_27)

				if var_31_29 > 0 and var_31_23 < var_31_29 then
					arg_28_1.talkMaxDuration = var_31_29

					if var_31_29 + var_31_22 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_29 + var_31_22
					end
				end

				arg_28_1.text_.text = var_31_26
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112007", "story_v_out_325112.awb") ~= 0 then
					local var_31_30 = manager.audio:GetVoiceLength("story_v_out_325112", "325112007", "story_v_out_325112.awb") / 1000

					if var_31_30 + var_31_22 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_30 + var_31_22
					end

					if var_31_25.prefab_name ~= "" and arg_28_1.actors_[var_31_25.prefab_name] ~= nil then
						local var_31_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_25.prefab_name].transform, "story_v_out_325112", "325112007", "story_v_out_325112.awb")

						arg_28_1:RecordAudio("325112007", var_31_31)
						arg_28_1:RecordAudio("325112007", var_31_31)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325112", "325112007", "story_v_out_325112.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325112", "325112007", "story_v_out_325112.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_32 = math.max(var_31_23, arg_28_1.talkMaxDuration)

			if var_31_22 <= arg_28_1.time_ and arg_28_1.time_ < var_31_22 + var_31_32 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_22) / var_31_32

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_22 + var_31_32 and arg_28_1.time_ < var_31_22 + var_31_32 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play325112008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325112008
		arg_32_1.duration_ = 5.93

		local var_32_0 = {
			zh = 4.833,
			ja = 5.933
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325112009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1077ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1077ui_story == nil then
				arg_32_1.var_.characterEffect1077ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1077ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1077ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1077ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1077ui_story.fillRatio = var_35_5
			end

			local var_35_6 = 0
			local var_35_7 = 0.45

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_8 = arg_32_1:FormatText(StoryNameCfg[1455].name)

				arg_32_1.leftNameTxt_.text = var_35_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_9 = arg_32_1:GetWordFromCfg(325112008)
				local var_35_10 = arg_32_1:FormatText(var_35_9.content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 18
				local var_35_12 = utf8.len(var_35_10)
				local var_35_13 = var_35_11 <= 0 and var_35_7 or var_35_7 * (var_35_12 / var_35_11)

				if var_35_13 > 0 and var_35_7 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112008", "story_v_out_325112.awb") ~= 0 then
					local var_35_14 = manager.audio:GetVoiceLength("story_v_out_325112", "325112008", "story_v_out_325112.awb") / 1000

					if var_35_14 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_6
					end

					if var_35_9.prefab_name ~= "" and arg_32_1.actors_[var_35_9.prefab_name] ~= nil then
						local var_35_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_9.prefab_name].transform, "story_v_out_325112", "325112008", "story_v_out_325112.awb")

						arg_32_1:RecordAudio("325112008", var_35_15)
						arg_32_1:RecordAudio("325112008", var_35_15)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325112", "325112008", "story_v_out_325112.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325112", "325112008", "story_v_out_325112.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_16 and arg_32_1.time_ < var_35_6 + var_35_16 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325112009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325112009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325112010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1059ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1059ui_story = var_39_0.localPosition
			end

			local var_39_2 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2
				local var_39_4 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1059ui_story, var_39_4, var_39_3)

				local var_39_5 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_5.x, var_39_5.y, var_39_5.z)

				local var_39_6 = var_39_0.localEulerAngles

				var_39_6.z = 0
				var_39_6.x = 0
				var_39_0.localEulerAngles = var_39_6
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, 100, 0)

				local var_39_7 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_7.x, var_39_7.y, var_39_7.z)

				local var_39_8 = var_39_0.localEulerAngles

				var_39_8.z = 0
				var_39_8.x = 0
				var_39_0.localEulerAngles = var_39_8
			end

			local var_39_9 = arg_36_1.actors_["1077ui_story"].transform
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.var_.moveOldPos1077ui_story = var_39_9.localPosition

				local var_39_11 = GameObjectTools.GetOrAddComponent(var_39_9.gameObject, typeof(DynamicBoneHelper))

				if var_39_11 then
					var_39_11:EnableDynamicBone(false)
				end
			end

			local var_39_12 = 0.001

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_12 then
				local var_39_13 = (arg_36_1.time_ - var_39_10) / var_39_12
				local var_39_14 = Vector3.New(0, 100, 0)

				var_39_9.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1077ui_story, var_39_14, var_39_13)

				local var_39_15 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_15.x, var_39_15.y, var_39_15.z)

				local var_39_16 = var_39_9.localEulerAngles

				var_39_16.z = 0
				var_39_16.x = 0
				var_39_9.localEulerAngles = var_39_16
			end

			if arg_36_1.time_ >= var_39_10 + var_39_12 and arg_36_1.time_ < var_39_10 + var_39_12 + arg_39_0 then
				var_39_9.localPosition = Vector3.New(0, 100, 0)

				local var_39_17 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_17.x, var_39_17.y, var_39_17.z)

				local var_39_18 = var_39_9.localEulerAngles

				var_39_18.z = 0
				var_39_18.x = 0
				var_39_9.localEulerAngles = var_39_18

				local var_39_19 = GameObjectTools.GetOrAddComponent(var_39_9.gameObject, typeof(DynamicBoneHelper))

				if var_39_19 then
					var_39_19:EnableDynamicBone(true)
				end
			end

			local var_39_20 = arg_36_1.actors_["1059ui_story"]
			local var_39_21 = 0

			if var_39_21 < arg_36_1.time_ and arg_36_1.time_ <= var_39_21 + arg_39_0 and not isNil(var_39_20) and arg_36_1.var_.characterEffect1059ui_story == nil then
				arg_36_1.var_.characterEffect1059ui_story = var_39_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_22 = 0.200000002980232

			if var_39_21 <= arg_36_1.time_ and arg_36_1.time_ < var_39_21 + var_39_22 and not isNil(var_39_20) then
				local var_39_23 = (arg_36_1.time_ - var_39_21) / var_39_22

				if arg_36_1.var_.characterEffect1059ui_story and not isNil(var_39_20) then
					local var_39_24 = Mathf.Lerp(0, 0.5, var_39_23)

					arg_36_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1059ui_story.fillRatio = var_39_24
				end
			end

			if arg_36_1.time_ >= var_39_21 + var_39_22 and arg_36_1.time_ < var_39_21 + var_39_22 + arg_39_0 and not isNil(var_39_20) and arg_36_1.var_.characterEffect1059ui_story then
				local var_39_25 = 0.5

				arg_36_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1059ui_story.fillRatio = var_39_25
			end

			local var_39_26 = 0.3
			local var_39_27 = 1

			if var_39_26 < arg_36_1.time_ and arg_36_1.time_ <= var_39_26 + arg_39_0 then
				local var_39_28 = "play"
				local var_39_29 = "effect"

				arg_36_1:AudioAction(var_39_28, var_39_29, "se_story_148", "se_story_148_sword12", "")
			end

			local var_39_30 = 0
			local var_39_31 = 1.15

			if var_39_30 < arg_36_1.time_ and arg_36_1.time_ <= var_39_30 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_32 = arg_36_1:GetWordFromCfg(325112009)
				local var_39_33 = arg_36_1:FormatText(var_39_32.content)

				arg_36_1.text_.text = var_39_33

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_34 = 46
				local var_39_35 = utf8.len(var_39_33)
				local var_39_36 = var_39_34 <= 0 and var_39_31 or var_39_31 * (var_39_35 / var_39_34)

				if var_39_36 > 0 and var_39_31 < var_39_36 then
					arg_36_1.talkMaxDuration = var_39_36

					if var_39_36 + var_39_30 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_36 + var_39_30
					end
				end

				arg_36_1.text_.text = var_39_33
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_37 = math.max(var_39_31, arg_36_1.talkMaxDuration)

			if var_39_30 <= arg_36_1.time_ and arg_36_1.time_ < var_39_30 + var_39_37 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_30) / var_39_37

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_30 + var_39_37 and arg_36_1.time_ < var_39_30 + var_39_37 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play325112010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325112010
		arg_40_1.duration_ = 6.1

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325112011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = manager.ui.mainCamera.transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				local var_43_2 = arg_40_1.var_.effect34234
				local var_43_3
				local var_43_4 = var_43_0

				if not var_43_2 then
					var_43_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), var_43_4)
					var_43_2.name = "34234"
					arg_40_1.var_.effect34234 = var_43_2
				else
					var_43_2.transform:SetParent(var_43_4)
				end

				var_43_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_43_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_43_5 = 1.7777777777777777
				local var_43_6 = Screen.width / Screen.height
				local var_43_7 = var_43_6 / var_43_5
				local var_43_8 = Mathf.Max(var_43_5 / var_43_6, 1)
				local var_43_9 = Mathf.Max(var_43_7, var_43_8)

				var_43_2.transform.localScale = Vector3.New(var_43_2.transform.localScale.x * var_43_9, var_43_2.transform.localScale.y * var_43_9, var_43_2.transform.localScale.z * var_43_9)
			end

			local var_43_10 = manager.ui.mainCamera.transform
			local var_43_11 = 1.475

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				local var_43_12 = arg_40_1.var_.effect34234

				if var_43_12 then
					Object.Destroy(var_43_12)

					arg_40_1.var_.effect34234 = nil
				end
			end

			local var_43_13 = 0

			if var_43_13 < arg_40_1.time_ and arg_40_1.time_ <= var_43_13 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			local var_43_14 = 1.43333333333333

			if arg_40_1.time_ >= var_43_13 + var_43_14 and arg_40_1.time_ < var_43_13 + var_43_14 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_15 = 1.1
			local var_43_16 = 1.475

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_17 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_17:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_40_1.dialogCg_.alpha = arg_44_0
				end))
				var_43_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_18 = arg_40_1:GetWordFromCfg(325112010)
				local var_43_19 = arg_40_1:FormatText(var_43_18.content)

				arg_40_1.text_.text = var_43_19

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 59
				local var_43_21 = utf8.len(var_43_19)
				local var_43_22 = var_43_20 <= 0 and var_43_16 or var_43_16 * (var_43_21 / var_43_20)

				if var_43_22 > 0 and var_43_16 < var_43_22 then
					arg_40_1.talkMaxDuration = var_43_22
					var_43_15 = var_43_15 + 0.3

					if var_43_22 + var_43_15 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_22 + var_43_15
					end
				end

				arg_40_1.text_.text = var_43_19
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_23 = var_43_15 + 0.3
			local var_43_24 = math.max(var_43_16, arg_40_1.talkMaxDuration)

			if var_43_23 <= arg_40_1.time_ and arg_40_1.time_ < var_43_23 + var_43_24 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_23) / var_43_24

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_23 + var_43_24 and arg_40_1.time_ < var_43_23 + var_43_24 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325112011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 325112011
		arg_46_1.duration_ = 3.7

		local var_46_0 = {
			zh = 3.7,
			ja = 2.933
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play325112012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1077ui_story"].transform
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.var_.moveOldPos1077ui_story = var_49_0.localPosition

				local var_49_2 = GameObjectTools.GetOrAddComponent(var_49_0.gameObject, typeof(DynamicBoneHelper))

				if var_49_2 then
					var_49_2:EnableDynamicBone(false)
				end
			end

			local var_49_3 = 0.001

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_3 then
				local var_49_4 = (arg_46_1.time_ - var_49_1) / var_49_3
				local var_49_5 = Vector3.New(0, 100, 0)

				var_49_0.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1077ui_story, var_49_5, var_49_4)

				local var_49_6 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_6.x, var_49_6.y, var_49_6.z)

				local var_49_7 = var_49_0.localEulerAngles

				var_49_7.z = 0
				var_49_7.x = 0
				var_49_0.localEulerAngles = var_49_7
			end

			if arg_46_1.time_ >= var_49_1 + var_49_3 and arg_46_1.time_ < var_49_1 + var_49_3 + arg_49_0 then
				var_49_0.localPosition = Vector3.New(0, 100, 0)

				local var_49_8 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_8.x, var_49_8.y, var_49_8.z)

				local var_49_9 = var_49_0.localEulerAngles

				var_49_9.z = 0
				var_49_9.x = 0
				var_49_0.localEulerAngles = var_49_9

				local var_49_10 = GameObjectTools.GetOrAddComponent(var_49_0.gameObject, typeof(DynamicBoneHelper))

				if var_49_10 then
					var_49_10:EnableDynamicBone(true)
				end
			end

			local var_49_11 = arg_46_1.actors_["1077ui_story"]
			local var_49_12 = 0

			if var_49_12 < arg_46_1.time_ and arg_46_1.time_ <= var_49_12 + arg_49_0 and not isNil(var_49_11) and arg_46_1.var_.characterEffect1077ui_story == nil then
				arg_46_1.var_.characterEffect1077ui_story = var_49_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_13 = 0.200000002980232

			if var_49_12 <= arg_46_1.time_ and arg_46_1.time_ < var_49_12 + var_49_13 and not isNil(var_49_11) then
				local var_49_14 = (arg_46_1.time_ - var_49_12) / var_49_13

				if arg_46_1.var_.characterEffect1077ui_story and not isNil(var_49_11) then
					arg_46_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_12 + var_49_13 and arg_46_1.time_ < var_49_12 + var_49_13 + arg_49_0 and not isNil(var_49_11) and arg_46_1.var_.characterEffect1077ui_story then
				arg_46_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_49_15 = 0
			local var_49_16 = 0.15

			if var_49_15 < arg_46_1.time_ and arg_46_1.time_ <= var_49_15 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_17 = arg_46_1:FormatText(StoryNameCfg[1467].name)

				arg_46_1.leftNameTxt_.text = var_49_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_18 = arg_46_1:GetWordFromCfg(325112011)
				local var_49_19 = arg_46_1:FormatText(var_49_18.content)

				arg_46_1.text_.text = var_49_19

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_20 = 6
				local var_49_21 = utf8.len(var_49_19)
				local var_49_22 = var_49_20 <= 0 and var_49_16 or var_49_16 * (var_49_21 / var_49_20)

				if var_49_22 > 0 and var_49_16 < var_49_22 then
					arg_46_1.talkMaxDuration = var_49_22

					if var_49_22 + var_49_15 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_22 + var_49_15
					end
				end

				arg_46_1.text_.text = var_49_19
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112011", "story_v_out_325112.awb") ~= 0 then
					local var_49_23 = manager.audio:GetVoiceLength("story_v_out_325112", "325112011", "story_v_out_325112.awb") / 1000

					if var_49_23 + var_49_15 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_23 + var_49_15
					end

					if var_49_18.prefab_name ~= "" and arg_46_1.actors_[var_49_18.prefab_name] ~= nil then
						local var_49_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_18.prefab_name].transform, "story_v_out_325112", "325112011", "story_v_out_325112.awb")

						arg_46_1:RecordAudio("325112011", var_49_24)
						arg_46_1:RecordAudio("325112011", var_49_24)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_325112", "325112011", "story_v_out_325112.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_325112", "325112011", "story_v_out_325112.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_25 = math.max(var_49_16, arg_46_1.talkMaxDuration)

			if var_49_15 <= arg_46_1.time_ and arg_46_1.time_ < var_49_15 + var_49_25 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_15) / var_49_25

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_15 + var_49_25 and arg_46_1.time_ < var_49_15 + var_49_25 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play325112012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 325112012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play325112013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1077ui_story"].transform
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.var_.moveOldPos1077ui_story = var_53_0.localPosition

				local var_53_2 = GameObjectTools.GetOrAddComponent(var_53_0.gameObject, typeof(DynamicBoneHelper))

				if var_53_2 then
					var_53_2:EnableDynamicBone(false)
				end
			end

			local var_53_3 = 0.001

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_3 then
				local var_53_4 = (arg_50_1.time_ - var_53_1) / var_53_3
				local var_53_5 = Vector3.New(0, 100, 0)

				var_53_0.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1077ui_story, var_53_5, var_53_4)

				local var_53_6 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_6.x, var_53_6.y, var_53_6.z)

				local var_53_7 = var_53_0.localEulerAngles

				var_53_7.z = 0
				var_53_7.x = 0
				var_53_0.localEulerAngles = var_53_7
			end

			if arg_50_1.time_ >= var_53_1 + var_53_3 and arg_50_1.time_ < var_53_1 + var_53_3 + arg_53_0 then
				var_53_0.localPosition = Vector3.New(0, 100, 0)

				local var_53_8 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_8.x, var_53_8.y, var_53_8.z)

				local var_53_9 = var_53_0.localEulerAngles

				var_53_9.z = 0
				var_53_9.x = 0
				var_53_0.localEulerAngles = var_53_9

				local var_53_10 = GameObjectTools.GetOrAddComponent(var_53_0.gameObject, typeof(DynamicBoneHelper))

				if var_53_10 then
					var_53_10:EnableDynamicBone(true)
				end
			end

			local var_53_11 = arg_50_1.actors_["1077ui_story"]
			local var_53_12 = 0

			if var_53_12 < arg_50_1.time_ and arg_50_1.time_ <= var_53_12 + arg_53_0 and not isNil(var_53_11) and arg_50_1.var_.characterEffect1077ui_story == nil then
				arg_50_1.var_.characterEffect1077ui_story = var_53_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_13 = 0.200000002980232

			if var_53_12 <= arg_50_1.time_ and arg_50_1.time_ < var_53_12 + var_53_13 and not isNil(var_53_11) then
				local var_53_14 = (arg_50_1.time_ - var_53_12) / var_53_13

				if arg_50_1.var_.characterEffect1077ui_story and not isNil(var_53_11) then
					local var_53_15 = Mathf.Lerp(0, 0.5, var_53_14)

					arg_50_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1077ui_story.fillRatio = var_53_15
				end
			end

			if arg_50_1.time_ >= var_53_12 + var_53_13 and arg_50_1.time_ < var_53_12 + var_53_13 + arg_53_0 and not isNil(var_53_11) and arg_50_1.var_.characterEffect1077ui_story then
				local var_53_16 = 0.5

				arg_50_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1077ui_story.fillRatio = var_53_16
			end

			local var_53_17 = 0
			local var_53_18 = 1.15

			if var_53_17 < arg_50_1.time_ and arg_50_1.time_ <= var_53_17 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_19 = arg_50_1:GetWordFromCfg(325112012)
				local var_53_20 = arg_50_1:FormatText(var_53_19.content)

				arg_50_1.text_.text = var_53_20

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_21 = 46
				local var_53_22 = utf8.len(var_53_20)
				local var_53_23 = var_53_21 <= 0 and var_53_18 or var_53_18 * (var_53_22 / var_53_21)

				if var_53_23 > 0 and var_53_18 < var_53_23 then
					arg_50_1.talkMaxDuration = var_53_23

					if var_53_23 + var_53_17 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_23 + var_53_17
					end
				end

				arg_50_1.text_.text = var_53_20
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_24 = math.max(var_53_18, arg_50_1.talkMaxDuration)

			if var_53_17 <= arg_50_1.time_ and arg_50_1.time_ < var_53_17 + var_53_24 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_17) / var_53_24

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_17 + var_53_24 and arg_50_1.time_ < var_53_17 + var_53_24 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play325112013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 325112013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play325112014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.3
			local var_57_1 = 1

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				local var_57_2 = "play"
				local var_57_3 = "effect"

				arg_54_1:AudioAction(var_57_2, var_57_3, "se_story_145", "se_story_145_summon_barrier", "")
			end

			local var_57_4 = 0
			local var_57_5 = 0.975

			if var_57_4 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_6 = arg_54_1:GetWordFromCfg(325112013)
				local var_57_7 = arg_54_1:FormatText(var_57_6.content)

				arg_54_1.text_.text = var_57_7

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_8 = 39
				local var_57_9 = utf8.len(var_57_7)
				local var_57_10 = var_57_8 <= 0 and var_57_5 or var_57_5 * (var_57_9 / var_57_8)

				if var_57_10 > 0 and var_57_5 < var_57_10 then
					arg_54_1.talkMaxDuration = var_57_10

					if var_57_10 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_4
					end
				end

				arg_54_1.text_.text = var_57_7
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_11 = math.max(var_57_5, arg_54_1.talkMaxDuration)

			if var_57_4 <= arg_54_1.time_ and arg_54_1.time_ < var_57_4 + var_57_11 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_4) / var_57_11

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_4 + var_57_11 and arg_54_1.time_ < var_57_4 + var_57_11 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play325112014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 325112014
		arg_58_1.duration_ = 6.3

		local var_58_0 = {
			zh = 6.3,
			ja = 5.7
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play325112015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 0.6

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[1455].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:GetWordFromCfg(325112014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 24
				local var_61_6 = utf8.len(var_61_4)
				local var_61_7 = var_61_5 <= 0 and var_61_1 or var_61_1 * (var_61_6 / var_61_5)

				if var_61_7 > 0 and var_61_1 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112014", "story_v_out_325112.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_325112", "325112014", "story_v_out_325112.awb") / 1000

					if var_61_8 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_0
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_325112", "325112014", "story_v_out_325112.awb")

						arg_58_1:RecordAudio("325112014", var_61_9)
						arg_58_1:RecordAudio("325112014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_325112", "325112014", "story_v_out_325112.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_325112", "325112014", "story_v_out_325112.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_10 and arg_58_1.time_ < var_61_0 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play325112015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 325112015
		arg_62_1.duration_ = 10.53

		local var_62_0 = {
			zh = 10.533,
			ja = 9.266
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play325112016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1077ui_story"].transform
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.var_.moveOldPos1077ui_story = var_65_0.localPosition

				local var_65_2 = GameObjectTools.GetOrAddComponent(var_65_0.gameObject, typeof(DynamicBoneHelper))

				if var_65_2 then
					var_65_2:EnableDynamicBone(false)
				end
			end

			local var_65_3 = 0.001

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_3 then
				local var_65_4 = (arg_62_1.time_ - var_65_1) / var_65_3
				local var_65_5 = Vector3.New(0, 100, 0)

				var_65_0.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1077ui_story, var_65_5, var_65_4)

				local var_65_6 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_6.x, var_65_6.y, var_65_6.z)

				local var_65_7 = var_65_0.localEulerAngles

				var_65_7.z = 0
				var_65_7.x = 0
				var_65_0.localEulerAngles = var_65_7
			end

			if arg_62_1.time_ >= var_65_1 + var_65_3 and arg_62_1.time_ < var_65_1 + var_65_3 + arg_65_0 then
				var_65_0.localPosition = Vector3.New(0, 100, 0)

				local var_65_8 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_8.x, var_65_8.y, var_65_8.z)

				local var_65_9 = var_65_0.localEulerAngles

				var_65_9.z = 0
				var_65_9.x = 0
				var_65_0.localEulerAngles = var_65_9

				local var_65_10 = GameObjectTools.GetOrAddComponent(var_65_0.gameObject, typeof(DynamicBoneHelper))

				if var_65_10 then
					var_65_10:EnableDynamicBone(true)
				end
			end

			local var_65_11 = arg_62_1.actors_["1077ui_story"]
			local var_65_12 = 0

			if var_65_12 < arg_62_1.time_ and arg_62_1.time_ <= var_65_12 + arg_65_0 and not isNil(var_65_11) and arg_62_1.var_.characterEffect1077ui_story == nil then
				arg_62_1.var_.characterEffect1077ui_story = var_65_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_13 = 0.200000002980232

			if var_65_12 <= arg_62_1.time_ and arg_62_1.time_ < var_65_12 + var_65_13 and not isNil(var_65_11) then
				local var_65_14 = (arg_62_1.time_ - var_65_12) / var_65_13

				if arg_62_1.var_.characterEffect1077ui_story and not isNil(var_65_11) then
					arg_62_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_12 + var_65_13 and arg_62_1.time_ < var_65_12 + var_65_13 + arg_65_0 and not isNil(var_65_11) and arg_62_1.var_.characterEffect1077ui_story then
				arg_62_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_65_15 = 0
			local var_65_16 = 0.675

			if var_65_15 < arg_62_1.time_ and arg_62_1.time_ <= var_65_15 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_17 = arg_62_1:FormatText(StoryNameCfg[1467].name)

				arg_62_1.leftNameTxt_.text = var_65_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_18 = arg_62_1:GetWordFromCfg(325112015)
				local var_65_19 = arg_62_1:FormatText(var_65_18.content)

				arg_62_1.text_.text = var_65_19

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_20 = 27
				local var_65_21 = utf8.len(var_65_19)
				local var_65_22 = var_65_20 <= 0 and var_65_16 or var_65_16 * (var_65_21 / var_65_20)

				if var_65_22 > 0 and var_65_16 < var_65_22 then
					arg_62_1.talkMaxDuration = var_65_22

					if var_65_22 + var_65_15 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_22 + var_65_15
					end
				end

				arg_62_1.text_.text = var_65_19
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112015", "story_v_out_325112.awb") ~= 0 then
					local var_65_23 = manager.audio:GetVoiceLength("story_v_out_325112", "325112015", "story_v_out_325112.awb") / 1000

					if var_65_23 + var_65_15 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_23 + var_65_15
					end

					if var_65_18.prefab_name ~= "" and arg_62_1.actors_[var_65_18.prefab_name] ~= nil then
						local var_65_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_18.prefab_name].transform, "story_v_out_325112", "325112015", "story_v_out_325112.awb")

						arg_62_1:RecordAudio("325112015", var_65_24)
						arg_62_1:RecordAudio("325112015", var_65_24)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_325112", "325112015", "story_v_out_325112.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_325112", "325112015", "story_v_out_325112.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_25 = math.max(var_65_16, arg_62_1.talkMaxDuration)

			if var_65_15 <= arg_62_1.time_ and arg_62_1.time_ < var_65_15 + var_65_25 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_15) / var_65_25

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_15 + var_65_25 and arg_62_1.time_ < var_65_15 + var_65_25 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play325112016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 325112016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play325112017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1059ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos1059ui_story = var_69_0.localPosition
			end

			local var_69_2 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2
				local var_69_4 = Vector3.New(0, 100, 0)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1059ui_story, var_69_4, var_69_3)

				local var_69_5 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_5.x, var_69_5.y, var_69_5.z)

				local var_69_6 = var_69_0.localEulerAngles

				var_69_6.z = 0
				var_69_6.x = 0
				var_69_0.localEulerAngles = var_69_6
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(0, 100, 0)

				local var_69_7 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_7.x, var_69_7.y, var_69_7.z)

				local var_69_8 = var_69_0.localEulerAngles

				var_69_8.z = 0
				var_69_8.x = 0
				var_69_0.localEulerAngles = var_69_8
			end

			local var_69_9 = arg_66_1.actors_["1077ui_story"].transform
			local var_69_10 = 0

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1.var_.moveOldPos1077ui_story = var_69_9.localPosition

				local var_69_11 = GameObjectTools.GetOrAddComponent(var_69_9.gameObject, typeof(DynamicBoneHelper))

				if var_69_11 then
					var_69_11:EnableDynamicBone(false)
				end
			end

			local var_69_12 = 0.001

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_12 then
				local var_69_13 = (arg_66_1.time_ - var_69_10) / var_69_12
				local var_69_14 = Vector3.New(0, 100, 0)

				var_69_9.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1077ui_story, var_69_14, var_69_13)

				local var_69_15 = manager.ui.mainCamera.transform.position - var_69_9.position

				var_69_9.forward = Vector3.New(var_69_15.x, var_69_15.y, var_69_15.z)

				local var_69_16 = var_69_9.localEulerAngles

				var_69_16.z = 0
				var_69_16.x = 0
				var_69_9.localEulerAngles = var_69_16
			end

			if arg_66_1.time_ >= var_69_10 + var_69_12 and arg_66_1.time_ < var_69_10 + var_69_12 + arg_69_0 then
				var_69_9.localPosition = Vector3.New(0, 100, 0)

				local var_69_17 = manager.ui.mainCamera.transform.position - var_69_9.position

				var_69_9.forward = Vector3.New(var_69_17.x, var_69_17.y, var_69_17.z)

				local var_69_18 = var_69_9.localEulerAngles

				var_69_18.z = 0
				var_69_18.x = 0
				var_69_9.localEulerAngles = var_69_18

				local var_69_19 = GameObjectTools.GetOrAddComponent(var_69_9.gameObject, typeof(DynamicBoneHelper))

				if var_69_19 then
					var_69_19:EnableDynamicBone(true)
				end
			end

			local var_69_20 = arg_66_1.actors_["1077ui_story"]
			local var_69_21 = 0

			if var_69_21 < arg_66_1.time_ and arg_66_1.time_ <= var_69_21 + arg_69_0 and not isNil(var_69_20) and arg_66_1.var_.characterEffect1077ui_story == nil then
				arg_66_1.var_.characterEffect1077ui_story = var_69_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_22 = 0.200000002980232

			if var_69_21 <= arg_66_1.time_ and arg_66_1.time_ < var_69_21 + var_69_22 and not isNil(var_69_20) then
				local var_69_23 = (arg_66_1.time_ - var_69_21) / var_69_22

				if arg_66_1.var_.characterEffect1077ui_story and not isNil(var_69_20) then
					local var_69_24 = Mathf.Lerp(0, 0.5, var_69_23)

					arg_66_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1077ui_story.fillRatio = var_69_24
				end
			end

			if arg_66_1.time_ >= var_69_21 + var_69_22 and arg_66_1.time_ < var_69_21 + var_69_22 + arg_69_0 and not isNil(var_69_20) and arg_66_1.var_.characterEffect1077ui_story then
				local var_69_25 = 0.5

				arg_66_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1077ui_story.fillRatio = var_69_25
			end

			local var_69_26 = 0.1
			local var_69_27 = 1

			if var_69_26 < arg_66_1.time_ and arg_66_1.time_ <= var_69_26 + arg_69_0 then
				local var_69_28 = "play"
				local var_69_29 = "effect"

				arg_66_1:AudioAction(var_69_28, var_69_29, "se_story_144", "se_story_144_footstep_back", "")
			end

			local var_69_30 = 0
			local var_69_31 = 0.95

			if var_69_30 < arg_66_1.time_ and arg_66_1.time_ <= var_69_30 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_32 = arg_66_1:GetWordFromCfg(325112016)
				local var_69_33 = arg_66_1:FormatText(var_69_32.content)

				arg_66_1.text_.text = var_69_33

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_34 = 38
				local var_69_35 = utf8.len(var_69_33)
				local var_69_36 = var_69_34 <= 0 and var_69_31 or var_69_31 * (var_69_35 / var_69_34)

				if var_69_36 > 0 and var_69_31 < var_69_36 then
					arg_66_1.talkMaxDuration = var_69_36

					if var_69_36 + var_69_30 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_36 + var_69_30
					end
				end

				arg_66_1.text_.text = var_69_33
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_37 = math.max(var_69_31, arg_66_1.talkMaxDuration)

			if var_69_30 <= arg_66_1.time_ and arg_66_1.time_ < var_69_30 + var_69_37 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_30) / var_69_37

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_30 + var_69_37 and arg_66_1.time_ < var_69_30 + var_69_37 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play325112017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325112017
		arg_70_1.duration_ = 3.13

		local var_70_0 = {
			zh = 2.5,
			ja = 3.133
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play325112018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.15

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[1455].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:GetWordFromCfg(325112017)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 6
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112017", "story_v_out_325112.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_325112", "325112017", "story_v_out_325112.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_325112", "325112017", "story_v_out_325112.awb")

						arg_70_1:RecordAudio("325112017", var_73_9)
						arg_70_1:RecordAudio("325112017", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_325112", "325112017", "story_v_out_325112.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_325112", "325112017", "story_v_out_325112.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play325112018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325112018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play325112019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.5
			local var_77_1 = 1

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				local var_77_2 = "play"
				local var_77_3 = "effect"

				arg_74_1:AudioAction(var_77_2, var_77_3, "se_story_1310", "se_story_1310_sword02", "")
			end

			local var_77_4 = 0
			local var_77_5 = 0.75

			if var_77_4 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_6 = arg_74_1:GetWordFromCfg(325112018)
				local var_77_7 = arg_74_1:FormatText(var_77_6.content)

				arg_74_1.text_.text = var_77_7

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_8 = 30
				local var_77_9 = utf8.len(var_77_7)
				local var_77_10 = var_77_8 <= 0 and var_77_5 or var_77_5 * (var_77_9 / var_77_8)

				if var_77_10 > 0 and var_77_5 < var_77_10 then
					arg_74_1.talkMaxDuration = var_77_10

					if var_77_10 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_4
					end
				end

				arg_74_1.text_.text = var_77_7
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_11 = math.max(var_77_5, arg_74_1.talkMaxDuration)

			if var_77_4 <= arg_74_1.time_ and arg_74_1.time_ < var_77_4 + var_77_11 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_4) / var_77_11

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_4 + var_77_11 and arg_74_1.time_ < var_77_4 + var_77_11 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play325112019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325112019
		arg_78_1.duration_ = 3.1

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play325112020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.275

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[1455].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_3 = arg_78_1:GetWordFromCfg(325112019)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 11
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112019", "story_v_out_325112.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_325112", "325112019", "story_v_out_325112.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_325112", "325112019", "story_v_out_325112.awb")

						arg_78_1:RecordAudio("325112019", var_81_9)
						arg_78_1:RecordAudio("325112019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_325112", "325112019", "story_v_out_325112.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_325112", "325112019", "story_v_out_325112.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play325112020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325112020
		arg_82_1.duration_ = 4.83

		local var_82_0 = {
			zh = 3.433,
			ja = 4.833
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play325112021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.25

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[1467].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:GetWordFromCfg(325112020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 10
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112020", "story_v_out_325112.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_325112", "325112020", "story_v_out_325112.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_325112", "325112020", "story_v_out_325112.awb")

						arg_82_1:RecordAudio("325112020", var_85_9)
						arg_82_1:RecordAudio("325112020", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_325112", "325112020", "story_v_out_325112.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_325112", "325112020", "story_v_out_325112.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play325112021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325112021
		arg_86_1.duration_ = 9.3

		local var_86_0 = {
			zh = 7.333,
			ja = 9.3
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play325112022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0
			local var_89_1 = 0.625

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_2 = arg_86_1:FormatText(StoryNameCfg[1455].name)

				arg_86_1.leftNameTxt_.text = var_89_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_3 = arg_86_1:GetWordFromCfg(325112021)
				local var_89_4 = arg_86_1:FormatText(var_89_3.content)

				arg_86_1.text_.text = var_89_4

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 25
				local var_89_6 = utf8.len(var_89_4)
				local var_89_7 = var_89_5 <= 0 and var_89_1 or var_89_1 * (var_89_6 / var_89_5)

				if var_89_7 > 0 and var_89_1 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_4
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112021", "story_v_out_325112.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_out_325112", "325112021", "story_v_out_325112.awb") / 1000

					if var_89_8 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_0
					end

					if var_89_3.prefab_name ~= "" and arg_86_1.actors_[var_89_3.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_3.prefab_name].transform, "story_v_out_325112", "325112021", "story_v_out_325112.awb")

						arg_86_1:RecordAudio("325112021", var_89_9)
						arg_86_1:RecordAudio("325112021", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_325112", "325112021", "story_v_out_325112.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_325112", "325112021", "story_v_out_325112.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_10 and arg_86_1.time_ < var_89_0 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play325112022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325112022
		arg_90_1.duration_ = 6.23

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play325112023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1059ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1059ui_story == nil then
				arg_90_1.var_.characterEffect1059ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1059ui_story and not isNil(var_93_0) then
					local var_93_4 = Mathf.Lerp(0, 0.5, var_93_3)

					arg_90_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1059ui_story.fillRatio = var_93_4
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1059ui_story then
				local var_93_5 = 0.5

				arg_90_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1059ui_story.fillRatio = var_93_5
			end

			local var_93_6 = manager.ui.mainCamera.transform
			local var_93_7 = 0

			if var_93_7 < arg_90_1.time_ and arg_90_1.time_ <= var_93_7 + arg_93_0 then
				local var_93_8 = arg_90_1.var_.effect4324
				local var_93_9
				local var_93_10 = var_93_6

				if not var_93_8 then
					var_93_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), var_93_10)
					var_93_8.name = "4324"
					arg_90_1.var_.effect4324 = var_93_8
				else
					var_93_8.transform:SetParent(var_93_10)
				end

				var_93_8.transform.localPosition = Vector3.New(0, 0, 0.48)
				var_93_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_93_11 = 1.7777777777777777
				local var_93_12 = Screen.width / Screen.height
				local var_93_13 = var_93_12 / var_93_11
				local var_93_14 = Mathf.Max(var_93_11 / var_93_12, 1)

				var_93_8.transform.localScale = Vector3.New(var_93_8.transform.localScale.x * var_93_13, var_93_8.transform.localScale.y * var_93_14, var_93_8.transform.localScale.z)
			end

			local var_93_15 = manager.ui.mainCamera.transform
			local var_93_16 = 2.73333333333333

			if var_93_16 < arg_90_1.time_ and arg_90_1.time_ <= var_93_16 + arg_93_0 then
				local var_93_17 = arg_90_1.var_.effect4324

				if var_93_17 then
					Object.Destroy(var_93_17)

					arg_90_1.var_.effect4324 = nil
				end
			end

			local var_93_18 = manager.ui.mainCamera.transform
			local var_93_19 = 0.333333333333333

			if var_93_19 < arg_90_1.time_ and arg_90_1.time_ <= var_93_19 + arg_93_0 then
				local var_93_20 = arg_90_1.var_.effect43241
				local var_93_21
				local var_93_22 = var_93_18

				if not var_93_20 then
					var_93_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), var_93_22)
					var_93_20.name = "43241"
					arg_90_1.var_.effect43241 = var_93_20
				else
					var_93_20.transform:SetParent(var_93_22)
				end

				var_93_20.transform.localPosition = Vector3.New(0, 0, -1.78)
				var_93_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_93_23 = 1.7777777777777777
				local var_93_24 = Screen.width / Screen.height
				local var_93_25 = var_93_24 / var_93_23
				local var_93_26 = Mathf.Max(var_93_23 / var_93_24, 1)

				var_93_20.transform.localScale = Vector3.New(var_93_20.transform.localScale.x * var_93_25, var_93_20.transform.localScale.y * var_93_26, var_93_20.transform.localScale.z)
			end

			local var_93_27 = manager.ui.mainCamera.transform
			local var_93_28 = 3.06666666666667

			if var_93_28 < arg_90_1.time_ and arg_90_1.time_ <= var_93_28 + arg_93_0 then
				local var_93_29 = arg_90_1.var_.effect43241

				if var_93_29 then
					Object.Destroy(var_93_29)

					arg_90_1.var_.effect43241 = nil
				end
			end

			local var_93_30 = manager.ui.mainCamera.transform
			local var_93_31 = 0.733333333333333

			if var_93_31 < arg_90_1.time_ and arg_90_1.time_ <= var_93_31 + arg_93_0 then
				local var_93_32 = arg_90_1.var_.effect42432
				local var_93_33
				local var_93_34 = var_93_30

				if not var_93_32 then
					var_93_32 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), var_93_34)
					var_93_32.name = "42432"
					arg_90_1.var_.effect42432 = var_93_32
				else
					var_93_32.transform:SetParent(var_93_34)
				end

				var_93_32.transform.localPosition = Vector3.New(0, 0, 0)
				var_93_32.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_93_35 = 0

			if var_93_35 < arg_90_1.time_ and arg_90_1.time_ <= var_93_35 + arg_93_0 then
				arg_90_1.allBtn_.enabled = false
			end

			local var_93_36 = 1.96666666666667

			if arg_90_1.time_ >= var_93_35 + var_93_36 and arg_90_1.time_ < var_93_35 + var_93_36 + arg_93_0 then
				arg_90_1.allBtn_.enabled = true
			end

			local var_93_37 = 0.4
			local var_93_38 = 1

			if var_93_37 < arg_90_1.time_ and arg_90_1.time_ <= var_93_37 + arg_93_0 then
				local var_93_39 = "play"
				local var_93_40 = "effect"

				arg_90_1:AudioAction(var_93_39, var_93_40, "se_story_122_03", "se_story_122_03_power", "")
			end

			local var_93_41 = 0.3
			local var_93_42 = 1

			if var_93_41 < arg_90_1.time_ and arg_90_1.time_ <= var_93_41 + arg_93_0 then
				local var_93_43 = "play"
				local var_93_44 = "effect"

				arg_90_1:AudioAction(var_93_43, var_93_44, "se_story_148", "se_story_148_sword07", "")
			end

			if arg_90_1.frameCnt_ <= 1 then
				arg_90_1.dialog_:SetActive(false)
			end

			local var_93_45 = 1.23333333333333
			local var_93_46 = 1.725

			if var_93_45 < arg_90_1.time_ and arg_90_1.time_ <= var_93_45 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0

				arg_90_1.dialog_:SetActive(true)

				arg_90_1.dialogCg_.alpha = 0

				local var_93_47 = LeanTween.value(arg_90_1.dialog_, 0, 1, 0.3)

				var_93_47:setOnUpdate(LuaHelper.FloatAction(function(arg_94_0)
					arg_90_1.dialogCg_.alpha = arg_94_0
				end))
				var_93_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_90_1.dialog_)
					var_93_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_90_1.duration_ = arg_90_1.duration_ + 0.3

				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_48 = arg_90_1:GetWordFromCfg(325112022)
				local var_93_49 = arg_90_1:FormatText(var_93_48.content)

				arg_90_1.text_.text = var_93_49

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_50 = 69
				local var_93_51 = utf8.len(var_93_49)
				local var_93_52 = var_93_50 <= 0 and var_93_46 or var_93_46 * (var_93_51 / var_93_50)

				if var_93_52 > 0 and var_93_46 < var_93_52 then
					arg_90_1.talkMaxDuration = var_93_52
					var_93_45 = var_93_45 + 0.3

					if var_93_52 + var_93_45 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_52 + var_93_45
					end
				end

				arg_90_1.text_.text = var_93_49
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_53 = var_93_45 + 0.3
			local var_93_54 = math.max(var_93_46, arg_90_1.talkMaxDuration)

			if var_93_53 <= arg_90_1.time_ and arg_90_1.time_ < var_93_53 + var_93_54 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_53) / var_93_54

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_53 + var_93_54 and arg_90_1.time_ < var_93_53 + var_93_54 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play325112023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325112023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play325112024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 1.4

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_2 = arg_96_1:GetWordFromCfg(325112023)
				local var_99_3 = arg_96_1:FormatText(var_99_2.content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 56
				local var_99_5 = utf8.len(var_99_3)
				local var_99_6 = var_99_4 <= 0 and var_99_1 or var_99_1 * (var_99_5 / var_99_4)

				if var_99_6 > 0 and var_99_1 < var_99_6 then
					arg_96_1.talkMaxDuration = var_99_6

					if var_99_6 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_7 and arg_96_1.time_ < var_99_0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play325112024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 325112024
		arg_100_1.duration_ = 11.03

		local var_100_0 = {
			zh = 4.866,
			ja = 11.033
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play325112025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.425

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[1455].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:GetWordFromCfg(325112024)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 17
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112024", "story_v_out_325112.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_325112", "325112024", "story_v_out_325112.awb") / 1000

					if var_103_8 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_0
					end

					if var_103_3.prefab_name ~= "" and arg_100_1.actors_[var_103_3.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_3.prefab_name].transform, "story_v_out_325112", "325112024", "story_v_out_325112.awb")

						arg_100_1:RecordAudio("325112024", var_103_9)
						arg_100_1:RecordAudio("325112024", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_325112", "325112024", "story_v_out_325112.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_325112", "325112024", "story_v_out_325112.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_10 and arg_100_1.time_ < var_103_0 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play325112025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 325112025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play325112026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.875

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_2 = arg_104_1:GetWordFromCfg(325112025)
				local var_107_3 = arg_104_1:FormatText(var_107_2.content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 35
				local var_107_5 = utf8.len(var_107_3)
				local var_107_6 = var_107_4 <= 0 and var_107_1 or var_107_1 * (var_107_5 / var_107_4)

				if var_107_6 > 0 and var_107_1 < var_107_6 then
					arg_104_1.talkMaxDuration = var_107_6

					if var_107_6 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_7 and arg_104_1.time_ < var_107_0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play325112026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 325112026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play325112027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 1.4

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_2 = arg_108_1:GetWordFromCfg(325112026)
				local var_111_3 = arg_108_1:FormatText(var_111_2.content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 56
				local var_111_5 = utf8.len(var_111_3)
				local var_111_6 = var_111_4 <= 0 and var_111_1 or var_111_1 * (var_111_5 / var_111_4)

				if var_111_6 > 0 and var_111_1 < var_111_6 then
					arg_108_1.talkMaxDuration = var_111_6

					if var_111_6 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_7 and arg_108_1.time_ < var_111_0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play325112027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 325112027
		arg_112_1.duration_ = 6.27

		local var_112_0 = {
			zh = 3.533,
			ja = 6.266
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play325112028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.25

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[1455].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(325112027)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 10
				local var_115_6 = utf8.len(var_115_4)
				local var_115_7 = var_115_5 <= 0 and var_115_1 or var_115_1 * (var_115_6 / var_115_5)

				if var_115_7 > 0 and var_115_1 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325112", "325112027", "story_v_out_325112.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_325112", "325112027", "story_v_out_325112.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_325112", "325112027", "story_v_out_325112.awb")

						arg_112_1:RecordAudio("325112027", var_115_9)
						arg_112_1:RecordAudio("325112027", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_325112", "325112027", "story_v_out_325112.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_325112", "325112027", "story_v_out_325112.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_10 and arg_112_1.time_ < var_115_0 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play325112028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 325112028
		arg_116_1.duration_ = 7.3

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
			arg_116_1.auto_ = false
		end

		function arg_116_1.playNext_(arg_118_0)
			arg_116_1.onStoryFinished_()
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = manager.ui.mainCamera.transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				local var_119_2 = arg_116_1.var_.effecteqewe
				local var_119_3
				local var_119_4 = var_119_0

				if not var_119_2 then
					var_119_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapblink"), var_119_4)
					var_119_2.name = "eqewe"
					arg_116_1.var_.effecteqewe = var_119_2
				else
					var_119_2.transform:SetParent(var_119_4)
				end

				var_119_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_119_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_119_5 = 1.7777777777777777
				local var_119_6 = Screen.width / Screen.height
				local var_119_7 = var_119_6 / var_119_5
				local var_119_8 = Mathf.Max(var_119_5 / var_119_6, 1)

				var_119_2.transform.localScale = Vector3.New(var_119_2.transform.localScale.x * var_119_7, var_119_2.transform.localScale.y * var_119_8, var_119_2.transform.localScale.z)
			end

			local var_119_9 = manager.ui.mainCamera.transform
			local var_119_10 = 1.96793889906257

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				local var_119_11 = arg_116_1.var_.effectewqe
				local var_119_12
				local var_119_13 = var_119_9

				if not var_119_11 then
					var_119_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapshut"), var_119_13)
					var_119_11.name = "ewqe"
					arg_116_1.var_.effectewqe = var_119_11
				else
					var_119_11.transform:SetParent(var_119_13)
				end

				var_119_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_119_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_119_14 = 0

			if var_119_14 < arg_116_1.time_ and arg_116_1.time_ <= var_119_14 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			local var_119_15 = 2.53333333333333

			if arg_116_1.time_ >= var_119_14 + var_119_15 and arg_116_1.time_ < var_119_14 + var_119_15 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			local var_119_16 = 0.266666666666667

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_17 = 0.733333333333333

			if var_119_16 <= arg_116_1.time_ and arg_116_1.time_ < var_119_16 + var_119_17 then
				local var_119_18 = (arg_116_1.time_ - var_119_16) / var_119_17
				local var_119_19 = Color.New(1, 1, 1)

				var_119_19.a = Mathf.Lerp(1, 0, var_119_18)
				arg_116_1.mask_.color = var_119_19
			end

			if arg_116_1.time_ >= var_119_16 + var_119_17 and arg_116_1.time_ < var_119_16 + var_119_17 + arg_119_0 then
				local var_119_20 = Color.New(1, 1, 1)
				local var_119_21 = 0

				arg_116_1.mask_.enabled = false
				var_119_20.a = var_119_21
				arg_116_1.mask_.color = var_119_20
			end

			local var_119_22 = 0.6
			local var_119_23 = 1

			if var_119_22 < arg_116_1.time_ and arg_116_1.time_ <= var_119_22 + arg_119_0 then
				local var_119_24 = "play"
				local var_119_25 = "effect"

				arg_116_1:AudioAction(var_119_24, var_119_25, "se_story_151", "se_story_151_door", "")
			end

			local var_119_26 = 0
			local var_119_27 = 1

			if var_119_26 < arg_116_1.time_ and arg_116_1.time_ <= var_119_26 + arg_119_0 then
				local var_119_28 = "play"
				local var_119_29 = "effect"

				arg_116_1:AudioAction(var_119_28, var_119_29, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_30 = 2.3
			local var_119_31 = 1.1

			if var_119_30 < arg_116_1.time_ and arg_116_1.time_ <= var_119_30 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_32 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_32:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_116_1.dialogCg_.alpha = arg_120_0
				end))
				var_119_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_33 = arg_116_1:GetWordFromCfg(325112028)
				local var_119_34 = arg_116_1:FormatText(var_119_33.content)

				arg_116_1.text_.text = var_119_34

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_35 = 44
				local var_119_36 = utf8.len(var_119_34)
				local var_119_37 = var_119_35 <= 0 and var_119_31 or var_119_31 * (var_119_36 / var_119_35)

				if var_119_37 > 0 and var_119_31 < var_119_37 then
					arg_116_1.talkMaxDuration = var_119_37
					var_119_30 = var_119_30 + 0.3

					if var_119_37 + var_119_30 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_37 + var_119_30
					end
				end

				arg_116_1.text_.text = var_119_34
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_38 = var_119_30 + 0.3
			local var_119_39 = math.max(var_119_31, arg_116_1.talkMaxDuration)

			if var_119_38 <= arg_116_1.time_ and arg_116_1.time_ < var_119_38 + var_119_39 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_38) / var_119_39

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_38 + var_119_39 and arg_116_1.time_ < var_119_38 + var_119_39 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2010"
	},
	voices = {
		"story_v_out_325112.awb"
	}
}
