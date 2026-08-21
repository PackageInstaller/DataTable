return {
	Play325092001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325092001
		arg_1_1.duration_ = 6.9

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325092002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J29g"

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
				local var_4_5 = arg_1_1.bgs_.J29g

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
					if iter_4_0 ~= "J29g" then
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

			local var_4_24 = manager.ui.mainCamera.transform
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_26 = arg_1_1.var_.effect46546
				local var_4_27
				local var_4_28 = var_4_24

				if not var_4_26 then
					var_4_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rockfall"), var_4_28)
					var_4_26.name = "46546"
					arg_1_1.var_.effect46546 = var_4_26
				else
					var_4_26.transform:SetParent(var_4_28)
				end

				var_4_26.transform.localPosition = Vector3.New(0, 0, -2.74)
				var_4_26.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_29 = 1.7777777777777777
				local var_4_30 = Screen.width / Screen.height
				local var_4_31 = var_4_30 / var_4_29
				local var_4_32 = Mathf.Max(var_4_29 / var_4_30, 1)

				var_4_26.transform.localScale = Vector3.New(var_4_26.transform.localScale.x * var_4_31, var_4_26.transform.localScale.y * var_4_32, var_4_26.transform.localScale.z)
			end

			local var_4_33 = 0.1
			local var_4_34 = 1

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "effect"

				arg_1_1:AudioAction(var_4_35, var_4_36, "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			local var_4_37 = 0.3
			local var_4_38 = 1

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				local var_4_39 = "play"
				local var_4_40 = "effect"

				arg_1_1:AudioAction(var_4_39, var_4_40, "se_story_148", "se_story_148_earthquake03", "")
			end

			local var_4_41 = 0
			local var_4_42 = 1

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_43 = "play"
				local var_4_44 = "music"

				arg_1_1:AudioAction(var_4_43, var_4_44, "bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong.awb")

				local var_4_45 = ""
				local var_4_46 = manager.audio:GetAudioName("bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong")

				if var_4_46 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_46 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_46

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_46
						arg_1_1.bgmTxt2_.text = var_4_46
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

			local var_4_47 = 1.9
			local var_4_48 = 0.9

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_49 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_49:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_50 = arg_1_1:GetWordFromCfg(325092001)
				local var_4_51 = arg_1_1:FormatText(var_4_50.content)

				arg_1_1.text_.text = var_4_51

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_52 = 36
				local var_4_53 = utf8.len(var_4_51)
				local var_4_54 = var_4_52 <= 0 and var_4_48 or var_4_48 * (var_4_53 / var_4_52)

				if var_4_54 > 0 and var_4_48 < var_4_54 then
					arg_1_1.talkMaxDuration = var_4_54
					var_4_47 = var_4_47 + 0.3

					if var_4_54 + var_4_47 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_54 + var_4_47
					end
				end

				arg_1_1.text_.text = var_4_51
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_55 = var_4_47 + 0.3
			local var_4_56 = math.max(var_4_48, arg_1_1.talkMaxDuration)

			if var_4_55 <= arg_1_1.time_ and arg_1_1.time_ < var_4_55 + var_4_56 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_55) / var_4_56

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_55 + var_4_56 and arg_1_1.time_ < var_4_55 + var_4_56 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.43333333333333,
				amplitudeGain = 1,
				startTime = 0.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325092002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325092002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325092003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.9

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(325092002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 36
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play325092003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325092003
		arg_12_1.duration_ = 7.97

		local var_12_0 = {
			zh = 6,
			ja = 7.966
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325092004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.525

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[1455].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(325092003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 21
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325092", "325092003", "story_v_out_325092.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_325092", "325092003", "story_v_out_325092.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_325092", "325092003", "story_v_out_325092.awb")

						arg_12_1:RecordAudio("325092003", var_15_9)
						arg_12_1:RecordAudio("325092003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325092", "325092003", "story_v_out_325092.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325092", "325092003", "story_v_out_325092.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_10 and arg_12_1.time_ < var_15_0 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325092004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325092004
		arg_16_1.duration_ = 6.8

		local var_16_0 = {
			zh = 3.5,
			ja = 6.8
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
				arg_16_0:Play325092005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1077ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1077ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["1077ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos1077ui_story = var_19_5.localPosition

				local var_19_7 = GameObjectTools.GetOrAddComponent(var_19_5.gameObject, typeof(DynamicBoneHelper))

				if var_19_7 then
					var_19_7:EnableDynamicBone(false)
				end
			end

			local var_19_8 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_8 then
				local var_19_9 = (arg_16_1.time_ - var_19_6) / var_19_8
				local var_19_10 = Vector3.New(-0.03, -1.02, -5.92)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1077ui_story, var_19_10, var_19_9)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_5.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_5.localEulerAngles = var_19_12
			end

			if arg_16_1.time_ >= var_19_6 + var_19_8 and arg_16_1.time_ < var_19_6 + var_19_8 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_19_13 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_13.x, var_19_13.y, var_19_13.z)

				local var_19_14 = var_19_5.localEulerAngles

				var_19_14.z = 0
				var_19_14.x = 0
				var_19_5.localEulerAngles = var_19_14

				local var_19_15 = GameObjectTools.GetOrAddComponent(var_19_5.gameObject, typeof(DynamicBoneHelper))

				if var_19_15 then
					var_19_15:EnableDynamicBone(true)
				end
			end

			local var_19_16 = arg_16_1.actors_["1077ui_story"]
			local var_19_17 = 0

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 and not isNil(var_19_16) and arg_16_1.var_.characterEffect1077ui_story == nil then
				arg_16_1.var_.characterEffect1077ui_story = var_19_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_18 = 0.200000002980232

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_18 and not isNil(var_19_16) then
				local var_19_19 = (arg_16_1.time_ - var_19_17) / var_19_18

				if arg_16_1.var_.characterEffect1077ui_story and not isNil(var_19_16) then
					arg_16_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_17 + var_19_18 and arg_16_1.time_ < var_19_17 + var_19_18 + arg_19_0 and not isNil(var_19_16) and arg_16_1.var_.characterEffect1077ui_story then
				arg_16_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_19_20 = 0

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_19_21 = 0

			if var_19_21 < arg_16_1.time_ and arg_16_1.time_ <= var_19_21 + arg_19_0 then
				arg_16_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_19_22 = 0
			local var_19_23 = 0.4

			if var_19_22 < arg_16_1.time_ and arg_16_1.time_ <= var_19_22 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_24 = arg_16_1:FormatText(StoryNameCfg[1467].name)

				arg_16_1.leftNameTxt_.text = var_19_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_25 = arg_16_1:GetWordFromCfg(325092004)
				local var_19_26 = arg_16_1:FormatText(var_19_25.content)

				arg_16_1.text_.text = var_19_26

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_27 = 16
				local var_19_28 = utf8.len(var_19_26)
				local var_19_29 = var_19_27 <= 0 and var_19_23 or var_19_23 * (var_19_28 / var_19_27)

				if var_19_29 > 0 and var_19_23 < var_19_29 then
					arg_16_1.talkMaxDuration = var_19_29

					if var_19_29 + var_19_22 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_29 + var_19_22
					end
				end

				arg_16_1.text_.text = var_19_26
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325092", "325092004", "story_v_out_325092.awb") ~= 0 then
					local var_19_30 = manager.audio:GetVoiceLength("story_v_out_325092", "325092004", "story_v_out_325092.awb") / 1000

					if var_19_30 + var_19_22 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_30 + var_19_22
					end

					if var_19_25.prefab_name ~= "" and arg_16_1.actors_[var_19_25.prefab_name] ~= nil then
						local var_19_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_25.prefab_name].transform, "story_v_out_325092", "325092004", "story_v_out_325092.awb")

						arg_16_1:RecordAudio("325092004", var_19_31)
						arg_16_1:RecordAudio("325092004", var_19_31)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325092", "325092004", "story_v_out_325092.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325092", "325092004", "story_v_out_325092.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_32 = math.max(var_19_23, arg_16_1.talkMaxDuration)

			if var_19_22 <= arg_16_1.time_ and arg_16_1.time_ < var_19_22 + var_19_32 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_22) / var_19_32

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_22 + var_19_32 and arg_16_1.time_ < var_19_22 + var_19_32 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play325092005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325092005
		arg_20_1.duration_ = 11.67

		local var_20_0 = {
			zh = 5.333,
			ja = 11.666
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325092006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1077ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1077ui_story == nil then
				arg_20_1.var_.characterEffect1077ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1077ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1077ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1077ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1077ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 0.625

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[1455].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_9 = arg_20_1:GetWordFromCfg(325092005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 25
				local var_23_12 = utf8.len(var_23_10)
				local var_23_13 = var_23_11 <= 0 and var_23_7 or var_23_7 * (var_23_12 / var_23_11)

				if var_23_13 > 0 and var_23_7 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325092", "325092005", "story_v_out_325092.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_325092", "325092005", "story_v_out_325092.awb") / 1000

					if var_23_14 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_6
					end

					if var_23_9.prefab_name ~= "" and arg_20_1.actors_[var_23_9.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_9.prefab_name].transform, "story_v_out_325092", "325092005", "story_v_out_325092.awb")

						arg_20_1:RecordAudio("325092005", var_23_15)
						arg_20_1:RecordAudio("325092005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325092", "325092005", "story_v_out_325092.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325092", "325092005", "story_v_out_325092.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_16 and arg_20_1.time_ < var_23_6 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play325092006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325092006
		arg_24_1.duration_ = 6.2

		local var_24_0 = {
			zh = 5.2,
			ja = 6.2
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
				arg_24_0:Play325092007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1077ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1077ui_story == nil then
				arg_24_1.var_.characterEffect1077ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1077ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1077ui_story then
				arg_24_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_27_4 = 0
			local var_27_5 = 0.75

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_6 = arg_24_1:FormatText(StoryNameCfg[1467].name)

				arg_24_1.leftNameTxt_.text = var_27_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_7 = arg_24_1:GetWordFromCfg(325092006)
				local var_27_8 = arg_24_1:FormatText(var_27_7.content)

				arg_24_1.text_.text = var_27_8

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 30
				local var_27_10 = utf8.len(var_27_8)
				local var_27_11 = var_27_9 <= 0 and var_27_5 or var_27_5 * (var_27_10 / var_27_9)

				if var_27_11 > 0 and var_27_5 < var_27_11 then
					arg_24_1.talkMaxDuration = var_27_11

					if var_27_11 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_11 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_8
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325092", "325092006", "story_v_out_325092.awb") ~= 0 then
					local var_27_12 = manager.audio:GetVoiceLength("story_v_out_325092", "325092006", "story_v_out_325092.awb") / 1000

					if var_27_12 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_4
					end

					if var_27_7.prefab_name ~= "" and arg_24_1.actors_[var_27_7.prefab_name] ~= nil then
						local var_27_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_7.prefab_name].transform, "story_v_out_325092", "325092006", "story_v_out_325092.awb")

						arg_24_1:RecordAudio("325092006", var_27_13)
						arg_24_1:RecordAudio("325092006", var_27_13)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325092", "325092006", "story_v_out_325092.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325092", "325092006", "story_v_out_325092.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_5, arg_24_1.talkMaxDuration)

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_4) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_4 + var_27_14 and arg_24_1.time_ < var_27_4 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325092007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325092007
		arg_28_1.duration_ = 3.47

		local var_28_0 = {
			zh = 3.466,
			ja = 3.333
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
				arg_28_0:Play325092008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1077ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1077ui_story == nil then
				arg_28_1.var_.characterEffect1077ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1077ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1077ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1077ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1077ui_story.fillRatio = var_31_5
			end

			local var_31_6 = 0
			local var_31_7 = 0.35

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[1455].name)

				arg_28_1.leftNameTxt_.text = var_31_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_9 = arg_28_1:GetWordFromCfg(325092007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 14
				local var_31_12 = utf8.len(var_31_10)
				local var_31_13 = var_31_11 <= 0 and var_31_7 or var_31_7 * (var_31_12 / var_31_11)

				if var_31_13 > 0 and var_31_7 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_10
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325092", "325092007", "story_v_out_325092.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_325092", "325092007", "story_v_out_325092.awb") / 1000

					if var_31_14 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_6
					end

					if var_31_9.prefab_name ~= "" and arg_28_1.actors_[var_31_9.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_9.prefab_name].transform, "story_v_out_325092", "325092007", "story_v_out_325092.awb")

						arg_28_1:RecordAudio("325092007", var_31_15)
						arg_28_1:RecordAudio("325092007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325092", "325092007", "story_v_out_325092.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325092", "325092007", "story_v_out_325092.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_16 and arg_28_1.time_ < var_31_6 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play325092008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325092008
		arg_32_1.duration_ = 1.2

		local var_32_0 = {
			zh = 0.999999999999,
			ja = 1.2
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
				arg_32_0:Play325092009(arg_32_1)
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
					arg_32_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1077ui_story then
				arg_32_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_35_4 = 0
			local var_35_5 = 0.075

			if var_35_4 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_6 = arg_32_1:FormatText(StoryNameCfg[1467].name)

				arg_32_1.leftNameTxt_.text = var_35_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_7 = arg_32_1:GetWordFromCfg(325092008)
				local var_35_8 = arg_32_1:FormatText(var_35_7.content)

				arg_32_1.text_.text = var_35_8

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 3
				local var_35_10 = utf8.len(var_35_8)
				local var_35_11 = var_35_9 <= 0 and var_35_5 or var_35_5 * (var_35_10 / var_35_9)

				if var_35_11 > 0 and var_35_5 < var_35_11 then
					arg_32_1.talkMaxDuration = var_35_11

					if var_35_11 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_11 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_8
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325092", "325092008", "story_v_out_325092.awb") ~= 0 then
					local var_35_12 = manager.audio:GetVoiceLength("story_v_out_325092", "325092008", "story_v_out_325092.awb") / 1000

					if var_35_12 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_4
					end

					if var_35_7.prefab_name ~= "" and arg_32_1.actors_[var_35_7.prefab_name] ~= nil then
						local var_35_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_7.prefab_name].transform, "story_v_out_325092", "325092008", "story_v_out_325092.awb")

						arg_32_1:RecordAudio("325092008", var_35_13)
						arg_32_1:RecordAudio("325092008", var_35_13)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325092", "325092008", "story_v_out_325092.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325092", "325092008", "story_v_out_325092.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_14 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_14 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_14

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_14 and arg_32_1.time_ < var_35_4 + var_35_14 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325092009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325092009
		arg_36_1.duration_ = 5.73

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325092010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1077ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1077ui_story = var_39_0.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_3 then
				local var_39_4 = (arg_36_1.time_ - var_39_1) / var_39_3
				local var_39_5 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1077ui_story, var_39_5, var_39_4)

				local var_39_6 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_6.x, var_39_6.y, var_39_6.z)

				local var_39_7 = var_39_0.localEulerAngles

				var_39_7.z = 0
				var_39_7.x = 0
				var_39_0.localEulerAngles = var_39_7
			end

			if arg_36_1.time_ >= var_39_1 + var_39_3 and arg_36_1.time_ < var_39_1 + var_39_3 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, 100, 0)

				local var_39_8 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_8.x, var_39_8.y, var_39_8.z)

				local var_39_9 = var_39_0.localEulerAngles

				var_39_9.z = 0
				var_39_9.x = 0
				var_39_0.localEulerAngles = var_39_9

				local var_39_10 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_10 then
					var_39_10:EnableDynamicBone(true)
				end
			end

			local var_39_11 = arg_36_1.actors_["1077ui_story"]
			local var_39_12 = 0

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect1077ui_story == nil then
				arg_36_1.var_.characterEffect1077ui_story = var_39_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_13 = 0.200000002980232

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_13 and not isNil(var_39_11) then
				local var_39_14 = (arg_36_1.time_ - var_39_12) / var_39_13

				if arg_36_1.var_.characterEffect1077ui_story and not isNil(var_39_11) then
					local var_39_15 = Mathf.Lerp(0, 0.5, var_39_14)

					arg_36_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1077ui_story.fillRatio = var_39_15
				end
			end

			if arg_36_1.time_ >= var_39_12 + var_39_13 and arg_36_1.time_ < var_39_12 + var_39_13 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect1077ui_story then
				local var_39_16 = 0.5

				arg_36_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1077ui_story.fillRatio = var_39_16
			end

			local var_39_17 = manager.ui.mainCamera.transform
			local var_39_18 = 0

			if var_39_18 < arg_36_1.time_ and arg_36_1.time_ <= var_39_18 + arg_39_0 then
				local var_39_19 = arg_36_1.var_.effect46546

				if var_39_19 then
					Object.Destroy(var_39_19)

					arg_36_1.var_.effect46546 = nil
				end
			end

			local var_39_20 = 0

			if var_39_20 < arg_36_1.time_ and arg_36_1.time_ <= var_39_20 + arg_39_0 then
				arg_36_1.mask_.enabled = true
				arg_36_1.mask_.raycastTarget = true

				arg_36_1:SetGaussion(false)
			end

			local var_39_21 = 0.733333333333333

			if var_39_20 <= arg_36_1.time_ and arg_36_1.time_ < var_39_20 + var_39_21 then
				local var_39_22 = (arg_36_1.time_ - var_39_20) / var_39_21
				local var_39_23 = Color.New(1, 1, 1)

				var_39_23.a = Mathf.Lerp(1, 0, var_39_22)
				arg_36_1.mask_.color = var_39_23
			end

			if arg_36_1.time_ >= var_39_20 + var_39_21 and arg_36_1.time_ < var_39_20 + var_39_21 + arg_39_0 then
				local var_39_24 = Color.New(1, 1, 1)
				local var_39_25 = 0

				arg_36_1.mask_.enabled = false
				var_39_24.a = var_39_25
				arg_36_1.mask_.color = var_39_24
			end

			local var_39_26 = 0

			if var_39_26 < arg_36_1.time_ and arg_36_1.time_ <= var_39_26 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			local var_39_27 = 1.43333333333333

			if arg_36_1.time_ >= var_39_26 + var_39_27 and arg_36_1.time_ < var_39_26 + var_39_27 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			local var_39_28 = 0.5
			local var_39_29 = 1

			if var_39_28 < arg_36_1.time_ and arg_36_1.time_ <= var_39_28 + arg_39_0 then
				local var_39_30 = "play"
				local var_39_31 = "effect"

				arg_36_1:AudioAction(var_39_30, var_39_31, "se_story_145", "se_story_145_stone", "")
			end

			if arg_36_1.frameCnt_ <= 1 then
				arg_36_1.dialog_:SetActive(false)
			end

			local var_39_32 = 0.733333333333333
			local var_39_33 = 1.025

			if var_39_32 < arg_36_1.time_ and arg_36_1.time_ <= var_39_32 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_34 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_34:setOnUpdate(LuaHelper.FloatAction(function(arg_40_0)
					arg_36_1.dialogCg_.alpha = arg_40_0
				end))
				var_39_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_35 = arg_36_1:GetWordFromCfg(325092009)
				local var_39_36 = arg_36_1:FormatText(var_39_35.content)

				arg_36_1.text_.text = var_39_36

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_37 = 41
				local var_39_38 = utf8.len(var_39_36)
				local var_39_39 = var_39_37 <= 0 and var_39_33 or var_39_33 * (var_39_38 / var_39_37)

				if var_39_39 > 0 and var_39_33 < var_39_39 then
					arg_36_1.talkMaxDuration = var_39_39
					var_39_32 = var_39_32 + 0.3

					if var_39_39 + var_39_32 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_39 + var_39_32
					end
				end

				arg_36_1.text_.text = var_39_36
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_40 = var_39_32 + 0.3
			local var_39_41 = math.max(var_39_33, arg_36_1.talkMaxDuration)

			if var_39_40 <= arg_36_1.time_ and arg_36_1.time_ < var_39_40 + var_39_41 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_40) / var_39_41

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_40 + var_39_41 and arg_36_1.time_ < var_39_40 + var_39_41 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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
	Play325092010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 325092010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play325092011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0.2
			local var_45_1 = 1

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				local var_45_2 = "play"
				local var_45_3 = "effect"

				arg_42_1:AudioAction(var_45_2, var_45_3, "se_story_127", "se_story_127_stone", "")
			end

			local var_45_4 = 0
			local var_45_5 = 1.125

			if var_45_4 < arg_42_1.time_ and arg_42_1.time_ <= var_45_4 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_6 = arg_42_1:GetWordFromCfg(325092010)
				local var_45_7 = arg_42_1:FormatText(var_45_6.content)

				arg_42_1.text_.text = var_45_7

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_8 = 45
				local var_45_9 = utf8.len(var_45_7)
				local var_45_10 = var_45_8 <= 0 and var_45_5 or var_45_5 * (var_45_9 / var_45_8)

				if var_45_10 > 0 and var_45_5 < var_45_10 then
					arg_42_1.talkMaxDuration = var_45_10

					if var_45_10 + var_45_4 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_10 + var_45_4
					end
				end

				arg_42_1.text_.text = var_45_7
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_11 = math.max(var_45_5, arg_42_1.talkMaxDuration)

			if var_45_4 <= arg_42_1.time_ and arg_42_1.time_ < var_45_4 + var_45_11 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_4) / var_45_11

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_4 + var_45_11 and arg_42_1.time_ < var_45_4 + var_45_11 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play325092011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 325092011
		arg_46_1.duration_ = 2.37

		local var_46_0 = {
			zh = 1.999999999999,
			ja = 2.366
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
				arg_46_0:Play325092012(arg_46_1)
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
				local var_49_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_49_0.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1077ui_story, var_49_5, var_49_4)

				local var_49_6 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_6.x, var_49_6.y, var_49_6.z)

				local var_49_7 = var_49_0.localEulerAngles

				var_49_7.z = 0
				var_49_7.x = 0
				var_49_0.localEulerAngles = var_49_7
			end

			if arg_46_1.time_ >= var_49_1 + var_49_3 and arg_46_1.time_ < var_49_1 + var_49_3 + arg_49_0 then
				var_49_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

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

			if var_49_15 < arg_46_1.time_ and arg_46_1.time_ <= var_49_15 + arg_49_0 then
				arg_46_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			local var_49_16 = 0
			local var_49_17 = 0.225

			if var_49_16 < arg_46_1.time_ and arg_46_1.time_ <= var_49_16 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_18 = arg_46_1:FormatText(StoryNameCfg[1467].name)

				arg_46_1.leftNameTxt_.text = var_49_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_19 = arg_46_1:GetWordFromCfg(325092011)
				local var_49_20 = arg_46_1:FormatText(var_49_19.content)

				arg_46_1.text_.text = var_49_20

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_21 = 9
				local var_49_22 = utf8.len(var_49_20)
				local var_49_23 = var_49_21 <= 0 and var_49_17 or var_49_17 * (var_49_22 / var_49_21)

				if var_49_23 > 0 and var_49_17 < var_49_23 then
					arg_46_1.talkMaxDuration = var_49_23

					if var_49_23 + var_49_16 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_23 + var_49_16
					end
				end

				arg_46_1.text_.text = var_49_20
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325092", "325092011", "story_v_out_325092.awb") ~= 0 then
					local var_49_24 = manager.audio:GetVoiceLength("story_v_out_325092", "325092011", "story_v_out_325092.awb") / 1000

					if var_49_24 + var_49_16 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_24 + var_49_16
					end

					if var_49_19.prefab_name ~= "" and arg_46_1.actors_[var_49_19.prefab_name] ~= nil then
						local var_49_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_19.prefab_name].transform, "story_v_out_325092", "325092011", "story_v_out_325092.awb")

						arg_46_1:RecordAudio("325092011", var_49_25)
						arg_46_1:RecordAudio("325092011", var_49_25)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_325092", "325092011", "story_v_out_325092.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_325092", "325092011", "story_v_out_325092.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_26 = math.max(var_49_17, arg_46_1.talkMaxDuration)

			if var_49_16 <= arg_46_1.time_ and arg_46_1.time_ < var_49_16 + var_49_26 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_16) / var_49_26

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_16 + var_49_26 and arg_46_1.time_ < var_49_16 + var_49_26 + arg_49_0 then
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
	Play325092012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 325092012
		arg_50_1.duration_ = 1.4

		local var_50_0 = {
			zh = 1.3,
			ja = 1.4
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play325092013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1077ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1077ui_story == nil then
				arg_50_1.var_.characterEffect1077ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect1077ui_story and not isNil(var_53_0) then
					local var_53_4 = Mathf.Lerp(0, 0.5, var_53_3)

					arg_50_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1077ui_story.fillRatio = var_53_4
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1077ui_story then
				local var_53_5 = 0.5

				arg_50_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1077ui_story.fillRatio = var_53_5
			end

			local var_53_6 = 0
			local var_53_7 = 0.075

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[1455].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_9 = arg_50_1:GetWordFromCfg(325092012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 3
				local var_53_12 = utf8.len(var_53_10)
				local var_53_13 = var_53_11 <= 0 and var_53_7 or var_53_7 * (var_53_12 / var_53_11)

				if var_53_13 > 0 and var_53_7 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_10
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325092", "325092012", "story_v_out_325092.awb") ~= 0 then
					local var_53_14 = manager.audio:GetVoiceLength("story_v_out_325092", "325092012", "story_v_out_325092.awb") / 1000

					if var_53_14 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_6
					end

					if var_53_9.prefab_name ~= "" and arg_50_1.actors_[var_53_9.prefab_name] ~= nil then
						local var_53_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_9.prefab_name].transform, "story_v_out_325092", "325092012", "story_v_out_325092.awb")

						arg_50_1:RecordAudio("325092012", var_53_15)
						arg_50_1:RecordAudio("325092012", var_53_15)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_325092", "325092012", "story_v_out_325092.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_325092", "325092012", "story_v_out_325092.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_16 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_16 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_16

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_16 and arg_50_1.time_ < var_53_6 + var_53_16 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play325092013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 325092013
		arg_54_1.duration_ = 4.9

		local var_54_0 = {
			zh = 3.033,
			ja = 4.9
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play325092014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1077ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1077ui_story == nil then
				arg_54_1.var_.characterEffect1077ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1077ui_story and not isNil(var_57_0) then
					arg_54_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1077ui_story then
				arg_54_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_57_4 = 0

			if var_57_4 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			local var_57_5 = 0

			if var_57_5 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 then
				arg_54_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_57_6 = 0
			local var_57_7 = 0.4

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_8 = arg_54_1:FormatText(StoryNameCfg[1467].name)

				arg_54_1.leftNameTxt_.text = var_57_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_9 = arg_54_1:GetWordFromCfg(325092013)
				local var_57_10 = arg_54_1:FormatText(var_57_9.content)

				arg_54_1.text_.text = var_57_10

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_11 = 16
				local var_57_12 = utf8.len(var_57_10)
				local var_57_13 = var_57_11 <= 0 and var_57_7 or var_57_7 * (var_57_12 / var_57_11)

				if var_57_13 > 0 and var_57_7 < var_57_13 then
					arg_54_1.talkMaxDuration = var_57_13

					if var_57_13 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_13 + var_57_6
					end
				end

				arg_54_1.text_.text = var_57_10
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325092", "325092013", "story_v_out_325092.awb") ~= 0 then
					local var_57_14 = manager.audio:GetVoiceLength("story_v_out_325092", "325092013", "story_v_out_325092.awb") / 1000

					if var_57_14 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_14 + var_57_6
					end

					if var_57_9.prefab_name ~= "" and arg_54_1.actors_[var_57_9.prefab_name] ~= nil then
						local var_57_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_9.prefab_name].transform, "story_v_out_325092", "325092013", "story_v_out_325092.awb")

						arg_54_1:RecordAudio("325092013", var_57_15)
						arg_54_1:RecordAudio("325092013", var_57_15)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_325092", "325092013", "story_v_out_325092.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_325092", "325092013", "story_v_out_325092.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_16 = math.max(var_57_7, arg_54_1.talkMaxDuration)

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_16 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_6) / var_57_16

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_6 + var_57_16 and arg_54_1.time_ < var_57_6 + var_57_16 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play325092014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 325092014
		arg_58_1.duration_ = 8.87

		local var_58_0 = {
			zh = 5.5,
			ja = 8.866
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
				arg_58_0:Play325092015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1077ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1077ui_story == nil then
				arg_58_1.var_.characterEffect1077ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect1077ui_story and not isNil(var_61_0) then
					local var_61_4 = Mathf.Lerp(0, 0.5, var_61_3)

					arg_58_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1077ui_story.fillRatio = var_61_4
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1077ui_story then
				local var_61_5 = 0.5

				arg_58_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1077ui_story.fillRatio = var_61_5
			end

			local var_61_6 = 0
			local var_61_7 = 0.525

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_8 = arg_58_1:FormatText(StoryNameCfg[1455].name)

				arg_58_1.leftNameTxt_.text = var_61_8

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

				local var_61_9 = arg_58_1:GetWordFromCfg(325092014)
				local var_61_10 = arg_58_1:FormatText(var_61_9.content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 21
				local var_61_12 = utf8.len(var_61_10)
				local var_61_13 = var_61_11 <= 0 and var_61_7 or var_61_7 * (var_61_12 / var_61_11)

				if var_61_13 > 0 and var_61_7 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_10
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325092", "325092014", "story_v_out_325092.awb") ~= 0 then
					local var_61_14 = manager.audio:GetVoiceLength("story_v_out_325092", "325092014", "story_v_out_325092.awb") / 1000

					if var_61_14 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_14 + var_61_6
					end

					if var_61_9.prefab_name ~= "" and arg_58_1.actors_[var_61_9.prefab_name] ~= nil then
						local var_61_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_9.prefab_name].transform, "story_v_out_325092", "325092014", "story_v_out_325092.awb")

						arg_58_1:RecordAudio("325092014", var_61_15)
						arg_58_1:RecordAudio("325092014", var_61_15)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_325092", "325092014", "story_v_out_325092.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_325092", "325092014", "story_v_out_325092.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_16 and arg_58_1.time_ < var_61_6 + var_61_16 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play325092015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 325092015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play325092016(arg_62_1)
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

			local var_65_11 = "1059ui_story"

			if arg_62_1.actors_[var_65_11] == nil then
				local var_65_12 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_65_12) then
					local var_65_13 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_62_1.stage_.transform)

					var_65_13.name = var_65_11
					var_65_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_62_1.actors_[var_65_11] = var_65_13

					local var_65_14 = var_65_13:GetComponentInChildren(typeof(CharacterEffect))

					var_65_14.enabled = true

					local var_65_15 = GameObjectTools.GetOrAddComponent(var_65_13, typeof(DynamicBoneHelper))

					if var_65_15 then
						var_65_15:EnableDynamicBone(false)
					end

					arg_62_1:ShowWeapon(var_65_14.transform, false)

					arg_62_1.var_[var_65_11 .. "Animator"] = var_65_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_62_1.var_[var_65_11 .. "Animator"].applyRootMotion = true
					arg_62_1.var_[var_65_11 .. "LipSync"] = var_65_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_65_16 = arg_62_1.actors_["1059ui_story"]
			local var_65_17 = 0

			if var_65_17 < arg_62_1.time_ and arg_62_1.time_ <= var_65_17 + arg_65_0 and not isNil(var_65_16) and arg_62_1.var_.characterEffect1059ui_story == nil then
				arg_62_1.var_.characterEffect1059ui_story = var_65_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_18 = 0.200000002980232

			if var_65_17 <= arg_62_1.time_ and arg_62_1.time_ < var_65_17 + var_65_18 and not isNil(var_65_16) then
				local var_65_19 = (arg_62_1.time_ - var_65_17) / var_65_18

				if arg_62_1.var_.characterEffect1059ui_story and not isNil(var_65_16) then
					local var_65_20 = Mathf.Lerp(0, 0.5, var_65_19)

					arg_62_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1059ui_story.fillRatio = var_65_20
				end
			end

			if arg_62_1.time_ >= var_65_17 + var_65_18 and arg_62_1.time_ < var_65_17 + var_65_18 + arg_65_0 and not isNil(var_65_16) and arg_62_1.var_.characterEffect1059ui_story then
				local var_65_21 = 0.5

				arg_62_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1059ui_story.fillRatio = var_65_21
			end

			local var_65_22 = 0.4
			local var_65_23 = 1

			if var_65_22 < arg_62_1.time_ and arg_62_1.time_ <= var_65_22 + arg_65_0 then
				local var_65_24 = "play"
				local var_65_25 = "effect"

				arg_62_1:AudioAction(var_65_24, var_65_25, "se_story_148", "se_story_148_sword15", "")
			end

			local var_65_26 = 0.4
			local var_65_27 = 1

			if var_65_26 < arg_62_1.time_ and arg_62_1.time_ <= var_65_26 + arg_65_0 then
				local var_65_28 = "play"
				local var_65_29 = "effect"

				arg_62_1:AudioAction(var_65_28, var_65_29, "se_story_143", "se_story_143_organic02", "")
			end

			local var_65_30 = 0
			local var_65_31 = 0.825

			if var_65_30 < arg_62_1.time_ and arg_62_1.time_ <= var_65_30 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_32 = arg_62_1:GetWordFromCfg(325092015)
				local var_65_33 = arg_62_1:FormatText(var_65_32.content)

				arg_62_1.text_.text = var_65_33

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_34 = 33
				local var_65_35 = utf8.len(var_65_33)
				local var_65_36 = var_65_34 <= 0 and var_65_31 or var_65_31 * (var_65_35 / var_65_34)

				if var_65_36 > 0 and var_65_31 < var_65_36 then
					arg_62_1.talkMaxDuration = var_65_36

					if var_65_36 + var_65_30 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_36 + var_65_30
					end
				end

				arg_62_1.text_.text = var_65_33
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_37 = math.max(var_65_31, arg_62_1.talkMaxDuration)

			if var_65_30 <= arg_62_1.time_ and arg_62_1.time_ < var_65_30 + var_65_37 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_30) / var_65_37

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_30 + var_65_37 and arg_62_1.time_ < var_65_30 + var_65_37 + arg_65_0 then
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
	Play325092016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 325092016
		arg_66_1.duration_ = 5.8

		local var_66_0 = {
			zh = 5.8,
			ja = 3.666
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play325092017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1077ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos1077ui_story = var_69_0.localPosition

				local var_69_2 = GameObjectTools.GetOrAddComponent(var_69_0.gameObject, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(false)
				end
			end

			local var_69_3 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_3 then
				local var_69_4 = (arg_66_1.time_ - var_69_1) / var_69_3
				local var_69_5 = Vector3.New(-0.03, -1.02, -5.92)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1077ui_story, var_69_5, var_69_4)

				local var_69_6 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_6.x, var_69_6.y, var_69_6.z)

				local var_69_7 = var_69_0.localEulerAngles

				var_69_7.z = 0
				var_69_7.x = 0
				var_69_0.localEulerAngles = var_69_7
			end

			if arg_66_1.time_ >= var_69_1 + var_69_3 and arg_66_1.time_ < var_69_1 + var_69_3 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(-0.03, -1.02, -5.92)

				local var_69_8 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_8.x, var_69_8.y, var_69_8.z)

				local var_69_9 = var_69_0.localEulerAngles

				var_69_9.z = 0
				var_69_9.x = 0
				var_69_0.localEulerAngles = var_69_9

				local var_69_10 = GameObjectTools.GetOrAddComponent(var_69_0.gameObject, typeof(DynamicBoneHelper))

				if var_69_10 then
					var_69_10:EnableDynamicBone(true)
				end
			end

			local var_69_11 = arg_66_1.actors_["1077ui_story"]
			local var_69_12 = 0

			if var_69_12 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 and not isNil(var_69_11) and arg_66_1.var_.characterEffect1077ui_story == nil then
				arg_66_1.var_.characterEffect1077ui_story = var_69_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_13 = 0.200000002980232

			if var_69_12 <= arg_66_1.time_ and arg_66_1.time_ < var_69_12 + var_69_13 and not isNil(var_69_11) then
				local var_69_14 = (arg_66_1.time_ - var_69_12) / var_69_13

				if arg_66_1.var_.characterEffect1077ui_story and not isNil(var_69_11) then
					arg_66_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_12 + var_69_13 and arg_66_1.time_ < var_69_12 + var_69_13 + arg_69_0 and not isNil(var_69_11) and arg_66_1.var_.characterEffect1077ui_story then
				arg_66_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_69_15 = 0

			if var_69_15 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 then
				arg_66_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action4_1")
			end

			local var_69_16 = 0

			if var_69_16 < arg_66_1.time_ and arg_66_1.time_ <= var_69_16 + arg_69_0 then
				arg_66_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_69_17 = 0
			local var_69_18 = 0.575

			if var_69_17 < arg_66_1.time_ and arg_66_1.time_ <= var_69_17 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_19 = arg_66_1:FormatText(StoryNameCfg[1467].name)

				arg_66_1.leftNameTxt_.text = var_69_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_20 = arg_66_1:GetWordFromCfg(325092016)
				local var_69_21 = arg_66_1:FormatText(var_69_20.content)

				arg_66_1.text_.text = var_69_21

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_22 = 23
				local var_69_23 = utf8.len(var_69_21)
				local var_69_24 = var_69_22 <= 0 and var_69_18 or var_69_18 * (var_69_23 / var_69_22)

				if var_69_24 > 0 and var_69_18 < var_69_24 then
					arg_66_1.talkMaxDuration = var_69_24

					if var_69_24 + var_69_17 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_24 + var_69_17
					end
				end

				arg_66_1.text_.text = var_69_21
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325092", "325092016", "story_v_out_325092.awb") ~= 0 then
					local var_69_25 = manager.audio:GetVoiceLength("story_v_out_325092", "325092016", "story_v_out_325092.awb") / 1000

					if var_69_25 + var_69_17 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_25 + var_69_17
					end

					if var_69_20.prefab_name ~= "" and arg_66_1.actors_[var_69_20.prefab_name] ~= nil then
						local var_69_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_20.prefab_name].transform, "story_v_out_325092", "325092016", "story_v_out_325092.awb")

						arg_66_1:RecordAudio("325092016", var_69_26)
						arg_66_1:RecordAudio("325092016", var_69_26)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_325092", "325092016", "story_v_out_325092.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_325092", "325092016", "story_v_out_325092.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_27 = math.max(var_69_18, arg_66_1.talkMaxDuration)

			if var_69_17 <= arg_66_1.time_ and arg_66_1.time_ < var_69_17 + var_69_27 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_17) / var_69_27

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_17 + var_69_27 and arg_66_1.time_ < var_69_17 + var_69_27 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
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
	Play325092017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325092017
		arg_70_1.duration_ = 16.73

		local var_70_0 = {
			zh = 7.033,
			ja = 16.733
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
				arg_70_0:Play325092018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1077ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1077ui_story == nil then
				arg_70_1.var_.characterEffect1077ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect1077ui_story and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1077ui_story.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1077ui_story then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1077ui_story.fillRatio = var_73_5
			end

			local var_73_6 = 0
			local var_73_7 = 0.7

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_8 = arg_70_1:FormatText(StoryNameCfg[1455].name)

				arg_70_1.leftNameTxt_.text = var_73_8

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

				local var_73_9 = arg_70_1:GetWordFromCfg(325092017)
				local var_73_10 = arg_70_1:FormatText(var_73_9.content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 28
				local var_73_12 = utf8.len(var_73_10)
				local var_73_13 = var_73_11 <= 0 and var_73_7 or var_73_7 * (var_73_12 / var_73_11)

				if var_73_13 > 0 and var_73_7 < var_73_13 then
					arg_70_1.talkMaxDuration = var_73_13

					if var_73_13 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_13 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_10
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325092", "325092017", "story_v_out_325092.awb") ~= 0 then
					local var_73_14 = manager.audio:GetVoiceLength("story_v_out_325092", "325092017", "story_v_out_325092.awb") / 1000

					if var_73_14 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_14 + var_73_6
					end

					if var_73_9.prefab_name ~= "" and arg_70_1.actors_[var_73_9.prefab_name] ~= nil then
						local var_73_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_9.prefab_name].transform, "story_v_out_325092", "325092017", "story_v_out_325092.awb")

						arg_70_1:RecordAudio("325092017", var_73_15)
						arg_70_1:RecordAudio("325092017", var_73_15)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_325092", "325092017", "story_v_out_325092.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_325092", "325092017", "story_v_out_325092.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_16 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_16 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_16

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_16 and arg_70_1.time_ < var_73_6 + var_73_16 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play325092018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325092018
		arg_74_1.duration_ = 10.13

		local var_74_0 = {
			zh = 6.3,
			ja = 10.133
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play325092019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.825

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[1455].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(325092018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 33
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325092", "325092018", "story_v_out_325092.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_325092", "325092018", "story_v_out_325092.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_325092", "325092018", "story_v_out_325092.awb")

						arg_74_1:RecordAudio("325092018", var_77_9)
						arg_74_1:RecordAudio("325092018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_325092", "325092018", "story_v_out_325092.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_325092", "325092018", "story_v_out_325092.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play325092019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325092019
		arg_78_1.duration_ = 7

		local var_78_0 = {
			zh = 3.966,
			ja = 7
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
			arg_78_1.auto_ = false
		end

		function arg_78_1.playNext_(arg_80_0)
			arg_78_1.onStoryFinished_()
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1077ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1077ui_story == nil then
				arg_78_1.var_.characterEffect1077ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1077ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1077ui_story then
				arg_78_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_81_4 = 0

			if var_81_4 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action4_2")
			end

			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_81_6 = 0
			local var_81_7 = 1

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				local var_81_8 = "play"
				local var_81_9 = "effect"

				arg_78_1:AudioAction(var_81_8, var_81_9, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_81_10 = 0
			local var_81_11 = 0.475

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_12 = arg_78_1:FormatText(StoryNameCfg[1467].name)

				arg_78_1.leftNameTxt_.text = var_81_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_13 = arg_78_1:GetWordFromCfg(325092019)
				local var_81_14 = arg_78_1:FormatText(var_81_13.content)

				arg_78_1.text_.text = var_81_14

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_15 = 19
				local var_81_16 = utf8.len(var_81_14)
				local var_81_17 = var_81_15 <= 0 and var_81_11 or var_81_11 * (var_81_16 / var_81_15)

				if var_81_17 > 0 and var_81_11 < var_81_17 then
					arg_78_1.talkMaxDuration = var_81_17

					if var_81_17 + var_81_10 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_17 + var_81_10
					end
				end

				arg_78_1.text_.text = var_81_14
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325092", "325092019", "story_v_out_325092.awb") ~= 0 then
					local var_81_18 = manager.audio:GetVoiceLength("story_v_out_325092", "325092019", "story_v_out_325092.awb") / 1000

					if var_81_18 + var_81_10 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_18 + var_81_10
					end

					if var_81_13.prefab_name ~= "" and arg_78_1.actors_[var_81_13.prefab_name] ~= nil then
						local var_81_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_13.prefab_name].transform, "story_v_out_325092", "325092019", "story_v_out_325092.awb")

						arg_78_1:RecordAudio("325092019", var_81_19)
						arg_78_1:RecordAudio("325092019", var_81_19)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_325092", "325092019", "story_v_out_325092.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_325092", "325092019", "story_v_out_325092.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_20 = math.max(var_81_11, arg_78_1.talkMaxDuration)

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_20 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_10) / var_81_20

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_10 + var_81_20 and arg_78_1.time_ < var_81_10 + var_81_20 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J29g"
	},
	voices = {
		"story_v_out_325092.awb"
	}
}
