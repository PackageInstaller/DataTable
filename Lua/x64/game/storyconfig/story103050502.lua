return {
	Play305052001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 305052001
		arg_1_1.duration_ = 7.2

		local var_1_0 = {
			zh = 7.19933333333333,
			ja = 4.999999999999
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play305052002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "S0409"

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
				local var_4_5 = arg_1_1.bgs_.S0409

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
					if iter_4_0 ~= "S0409" then
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

			local var_4_24 = "1084ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentInChildren(typeof(CharacterEffect))

					var_4_27.enabled = true

					local var_4_28 = GameObjectTools.GetOrAddComponent(var_4_26, typeof(DynamicBoneHelper))

					if var_4_28 then
						var_4_28:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_27.transform, false)

					arg_1_1.var_[var_4_24 .. "Animator"] = var_4_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_24 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_24 .. "LipSync"] = var_4_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_29 = arg_1_1.actors_["1084ui_story"]
			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_31 = 0.200000002980232

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 and not isNil(var_4_29) then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31

				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_29) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_33 = manager.ui.mainCamera.transform
			local var_4_34 = 0

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_35 = arg_1_1.var_.effect32131111
				local var_4_36
				local var_4_37 = var_4_33

				if not var_4_35 then
					var_4_35 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), var_4_37)
					var_4_35.name = "32131111"
					arg_1_1.var_.effect32131111 = var_4_35
				else
					var_4_35.transform:SetParent(var_4_37)
				end

				var_4_35.transform.localPosition = Vector3.New(0, 0, -2.91)
				var_4_35.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_38 = 1.7777777777777777
				local var_4_39 = Screen.width / Screen.height
				local var_4_40 = var_4_39 / var_4_38
				local var_4_41 = Mathf.Max(var_4_38 / var_4_39, 1)

				var_4_35.transform.localScale = Vector3.New(var_4_35.transform.localScale.x * var_4_40, var_4_35.transform.localScale.y * var_4_41, var_4_35.transform.localScale.z)
			end

			local var_4_42 = 0.2
			local var_4_43 = 1

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "effect"

				arg_1_1:AudioAction(var_4_44, var_4_45, "se_story_148", "se_story_148_amb_drone02", "")
			end

			local var_4_46 = 1
			local var_4_47 = 1

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "music"

				arg_1_1:AudioAction(var_4_48, var_4_49, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_50 = ""
				local var_4_51 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_4_51 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_51 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_51

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_51
						arg_1_1.bgmTxt2_.text = var_4_51
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

			local var_4_52 = 0
			local var_4_53 = 1

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				local var_4_54 = "play"
				local var_4_55 = "effect"

				arg_1_1:AudioAction(var_4_54, var_4_55, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_56 = 1.63333333333333
			local var_4_57 = 0.7

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_58 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_58:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_60 = arg_1_1:GetWordFromCfg(305052001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 28
				local var_4_63 = utf8.len(var_4_61)
				local var_4_64 = var_4_62 <= 0 and var_4_57 or var_4_57 * (var_4_63 / var_4_62)

				if var_4_64 > 0 and var_4_57 < var_4_64 then
					arg_1_1.talkMaxDuration = var_4_64
					var_4_56 = var_4_56 + 0.3

					if var_4_64 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_56
					end
				end

				arg_1_1.text_.text = var_4_61
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052001", "story_v_out_305052.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_305052", "305052001", "story_v_out_305052.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_305052", "305052001", "story_v_out_305052.awb")

						arg_1_1:RecordAudio("305052001", var_4_66)
						arg_1_1:RecordAudio("305052001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_305052", "305052001", "story_v_out_305052.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_305052", "305052001", "story_v_out_305052.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_67 = var_4_56 + 0.3
			local var_4_68 = math.max(var_4_57, arg_1_1.talkMaxDuration)

			if var_4_67 <= arg_1_1.time_ and arg_1_1.time_ < var_4_67 + var_4_68 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_67) / var_4_68

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_67 + var_4_68 and arg_1_1.time_ < var_4_67 + var_4_68 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play305052002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 305052002
		arg_8_1.duration_ = 3.47

		local var_8_0 = {
			zh = 3.466,
			ja = 1.333
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
				arg_8_0:Play305052003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.375

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[6].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(305052002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052002", "story_v_out_305052.awb") ~= 0 then
					local var_11_8 = manager.audio:GetVoiceLength("story_v_out_305052", "305052002", "story_v_out_305052.awb") / 1000

					if var_11_8 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_8 + var_11_0
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_305052", "305052002", "story_v_out_305052.awb")

						arg_8_1:RecordAudio("305052002", var_11_9)
						arg_8_1:RecordAudio("305052002", var_11_9)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_305052", "305052002", "story_v_out_305052.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_305052", "305052002", "story_v_out_305052.awb")
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
	Play305052003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 305052003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play305052004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1084ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1084ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 0.8

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_8 = arg_12_1:GetWordFromCfg(305052003)
				local var_15_9 = arg_12_1:FormatText(var_15_8.content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_10 = 32
				local var_15_11 = utf8.len(var_15_9)
				local var_15_12 = var_15_10 <= 0 and var_15_7 or var_15_7 * (var_15_11 / var_15_10)

				if var_15_12 > 0 and var_15_7 < var_15_12 then
					arg_12_1.talkMaxDuration = var_15_12

					if var_15_12 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_9
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_13 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_13 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_13

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_13 and arg_12_1.time_ < var_15_6 + var_15_13 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play305052004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 305052004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play305052005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.45

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_2 = arg_16_1:GetWordFromCfg(305052004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 58
				local var_19_5 = utf8.len(var_19_3)
				local var_19_6 = var_19_4 <= 0 and var_19_1 or var_19_1 * (var_19_5 / var_19_4)

				if var_19_6 > 0 and var_19_1 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_7 and arg_16_1.time_ < var_19_0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play305052005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 305052005
		arg_20_1.duration_ = 13.5

		local var_20_0 = {
			zh = 9.533,
			ja = 13.5
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
				arg_20_0:Play305052006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.775

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[49].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:GetWordFromCfg(305052005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 31
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052005", "story_v_out_305052.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_305052", "305052005", "story_v_out_305052.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_305052", "305052005", "story_v_out_305052.awb")

						arg_20_1:RecordAudio("305052005", var_23_9)
						arg_20_1:RecordAudio("305052005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_305052", "305052005", "story_v_out_305052.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_305052", "305052005", "story_v_out_305052.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play305052006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 305052006
		arg_24_1.duration_ = 11.33

		local var_24_0 = {
			zh = 11.333,
			ja = 10.066
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
				arg_24_0:Play305052007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.775

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[49].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:GetWordFromCfg(305052006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052006", "story_v_out_305052.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_305052", "305052006", "story_v_out_305052.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_305052", "305052006", "story_v_out_305052.awb")

						arg_24_1:RecordAudio("305052006", var_27_9)
						arg_24_1:RecordAudio("305052006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_305052", "305052006", "story_v_out_305052.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_305052", "305052006", "story_v_out_305052.awb")
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
	Play305052007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 305052007
		arg_28_1.duration_ = 8.7

		local var_28_0 = {
			zh = 4.3,
			ja = 8.7
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
				arg_28_0:Play305052008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "1019ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_28_1.stage_.transform)

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

			local var_31_5 = arg_28_1.actors_["1019ui_story"]
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_7 = 0.200000002980232

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 and not isNil(var_31_5) then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7

				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_31_9 = 0
			local var_31_10 = 0.575

			if var_31_9 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_11 = arg_28_1:FormatText(StoryNameCfg[13].name)

				arg_28_1.leftNameTxt_.text = var_31_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_12 = arg_28_1:GetWordFromCfg(305052007)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_14 = 23
				local var_31_15 = utf8.len(var_31_13)
				local var_31_16 = var_31_14 <= 0 and var_31_10 or var_31_10 * (var_31_15 / var_31_14)

				if var_31_16 > 0 and var_31_10 < var_31_16 then
					arg_28_1.talkMaxDuration = var_31_16

					if var_31_16 + var_31_9 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_9
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052007", "story_v_out_305052.awb") ~= 0 then
					local var_31_17 = manager.audio:GetVoiceLength("story_v_out_305052", "305052007", "story_v_out_305052.awb") / 1000

					if var_31_17 + var_31_9 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_17 + var_31_9
					end

					if var_31_12.prefab_name ~= "" and arg_28_1.actors_[var_31_12.prefab_name] ~= nil then
						local var_31_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_12.prefab_name].transform, "story_v_out_305052", "305052007", "story_v_out_305052.awb")

						arg_28_1:RecordAudio("305052007", var_31_18)
						arg_28_1:RecordAudio("305052007", var_31_18)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_305052", "305052007", "story_v_out_305052.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_305052", "305052007", "story_v_out_305052.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_19 = math.max(var_31_10, arg_28_1.talkMaxDuration)

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_19 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_9) / var_31_19

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_9 + var_31_19 and arg_28_1.time_ < var_31_9 + var_31_19 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play305052008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 305052008
		arg_32_1.duration_ = 3.17

		local var_32_0 = {
			zh = 3.166,
			ja = 1.333
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
				arg_32_0:Play305052009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1084ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1084ui_story == nil then
				arg_32_1.var_.characterEffect1084ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1084ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1084ui_story then
				arg_32_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["1019ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect1019ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1019ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1019ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1019ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0
			local var_35_11 = 0.375

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_12 = arg_32_1:FormatText(StoryNameCfg[6].name)

				arg_32_1.leftNameTxt_.text = var_35_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_13 = arg_32_1:GetWordFromCfg(305052008)
				local var_35_14 = arg_32_1:FormatText(var_35_13.content)

				arg_32_1.text_.text = var_35_14

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 15
				local var_35_16 = utf8.len(var_35_14)
				local var_35_17 = var_35_15 <= 0 and var_35_11 or var_35_11 * (var_35_16 / var_35_15)

				if var_35_17 > 0 and var_35_11 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_10
					end
				end

				arg_32_1.text_.text = var_35_14
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052008", "story_v_out_305052.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_305052", "305052008", "story_v_out_305052.awb") / 1000

					if var_35_18 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_10
					end

					if var_35_13.prefab_name ~= "" and arg_32_1.actors_[var_35_13.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_13.prefab_name].transform, "story_v_out_305052", "305052008", "story_v_out_305052.awb")

						arg_32_1:RecordAudio("305052008", var_35_19)
						arg_32_1:RecordAudio("305052008", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_305052", "305052008", "story_v_out_305052.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_305052", "305052008", "story_v_out_305052.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = math.max(var_35_11, arg_32_1.talkMaxDuration)

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_20 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_10) / var_35_20

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_10 + var_35_20 and arg_32_1.time_ < var_35_10 + var_35_20 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play305052009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 305052009
		arg_36_1.duration_ = 5.33

		local var_36_0 = {
			zh = 2.466,
			ja = 5.333
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play305052010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1019ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1019ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1019ui_story then
				arg_36_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1084ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1084ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1084ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1084ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0
			local var_39_11 = 0.35

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_12 = arg_36_1:FormatText(StoryNameCfg[13].name)

				arg_36_1.leftNameTxt_.text = var_39_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_13 = arg_36_1:GetWordFromCfg(305052009)
				local var_39_14 = arg_36_1:FormatText(var_39_13.content)

				arg_36_1.text_.text = var_39_14

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 14
				local var_39_16 = utf8.len(var_39_14)
				local var_39_17 = var_39_15 <= 0 and var_39_11 or var_39_11 * (var_39_16 / var_39_15)

				if var_39_17 > 0 and var_39_11 < var_39_17 then
					arg_36_1.talkMaxDuration = var_39_17

					if var_39_17 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_10
					end
				end

				arg_36_1.text_.text = var_39_14
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052009", "story_v_out_305052.awb") ~= 0 then
					local var_39_18 = manager.audio:GetVoiceLength("story_v_out_305052", "305052009", "story_v_out_305052.awb") / 1000

					if var_39_18 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_10
					end

					if var_39_13.prefab_name ~= "" and arg_36_1.actors_[var_39_13.prefab_name] ~= nil then
						local var_39_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_13.prefab_name].transform, "story_v_out_305052", "305052009", "story_v_out_305052.awb")

						arg_36_1:RecordAudio("305052009", var_39_19)
						arg_36_1:RecordAudio("305052009", var_39_19)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_305052", "305052009", "story_v_out_305052.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_305052", "305052009", "story_v_out_305052.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_20 = math.max(var_39_11, arg_36_1.talkMaxDuration)

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_20 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_10) / var_39_20

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_10 + var_39_20 and arg_36_1.time_ < var_39_10 + var_39_20 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play305052010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 305052010
		arg_40_1.duration_ = 13.3

		local var_40_0 = {
			zh = 5.866,
			ja = 13.3
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play305052011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.85

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[13].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:GetWordFromCfg(305052010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 34
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052010", "story_v_out_305052.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_305052", "305052010", "story_v_out_305052.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_305052", "305052010", "story_v_out_305052.awb")

						arg_40_1:RecordAudio("305052010", var_43_9)
						arg_40_1:RecordAudio("305052010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_305052", "305052010", "story_v_out_305052.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_305052", "305052010", "story_v_out_305052.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play305052011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 305052011
		arg_44_1.duration_ = 7.87

		local var_44_0 = {
			zh = 4.2,
			ja = 7.866
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play305052012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "1011ui_story"

			if arg_44_1.actors_[var_47_0] == nil then
				local var_47_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_47_1) then
					local var_47_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_44_1.stage_.transform)

					var_47_2.name = var_47_0
					var_47_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_44_1.actors_[var_47_0] = var_47_2

					local var_47_3 = var_47_2:GetComponentInChildren(typeof(CharacterEffect))

					var_47_3.enabled = true

					local var_47_4 = GameObjectTools.GetOrAddComponent(var_47_2, typeof(DynamicBoneHelper))

					if var_47_4 then
						var_47_4:EnableDynamicBone(false)
					end

					arg_44_1:ShowWeapon(var_47_3.transform, false)

					arg_44_1.var_[var_47_0 .. "Animator"] = var_47_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_44_1.var_[var_47_0 .. "Animator"].applyRootMotion = true
					arg_44_1.var_[var_47_0 .. "LipSync"] = var_47_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_47_5 = arg_44_1.actors_["1011ui_story"]
			local var_47_6 = 0

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1011ui_story == nil then
				arg_44_1.var_.characterEffect1011ui_story = var_47_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_7 = 0.200000002980232

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_7 and not isNil(var_47_5) then
				local var_47_8 = (arg_44_1.time_ - var_47_6) / var_47_7

				if arg_44_1.var_.characterEffect1011ui_story and not isNil(var_47_5) then
					arg_44_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_6 + var_47_7 and arg_44_1.time_ < var_47_6 + var_47_7 + arg_47_0 and not isNil(var_47_5) and arg_44_1.var_.characterEffect1011ui_story then
				arg_44_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_47_9 = arg_44_1.actors_["1019ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect1019ui_story and not isNil(var_47_9) then
					local var_47_13 = Mathf.Lerp(0, 0.5, var_47_12)

					arg_44_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1019ui_story.fillRatio = var_47_13
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1019ui_story then
				local var_47_14 = 0.5

				arg_44_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1019ui_story.fillRatio = var_47_14
			end

			local var_47_15 = 0
			local var_47_16 = 0.425

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_17 = arg_44_1:FormatText(StoryNameCfg[37].name)

				arg_44_1.leftNameTxt_.text = var_47_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_18 = arg_44_1:GetWordFromCfg(305052011)
				local var_47_19 = arg_44_1:FormatText(var_47_18.content)

				arg_44_1.text_.text = var_47_19

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_20 = 17
				local var_47_21 = utf8.len(var_47_19)
				local var_47_22 = var_47_20 <= 0 and var_47_16 or var_47_16 * (var_47_21 / var_47_20)

				if var_47_22 > 0 and var_47_16 < var_47_22 then
					arg_44_1.talkMaxDuration = var_47_22

					if var_47_22 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_22 + var_47_15
					end
				end

				arg_44_1.text_.text = var_47_19
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052011", "story_v_out_305052.awb") ~= 0 then
					local var_47_23 = manager.audio:GetVoiceLength("story_v_out_305052", "305052011", "story_v_out_305052.awb") / 1000

					if var_47_23 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_23 + var_47_15
					end

					if var_47_18.prefab_name ~= "" and arg_44_1.actors_[var_47_18.prefab_name] ~= nil then
						local var_47_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_18.prefab_name].transform, "story_v_out_305052", "305052011", "story_v_out_305052.awb")

						arg_44_1:RecordAudio("305052011", var_47_24)
						arg_44_1:RecordAudio("305052011", var_47_24)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_305052", "305052011", "story_v_out_305052.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_305052", "305052011", "story_v_out_305052.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_25 = math.max(var_47_16, arg_44_1.talkMaxDuration)

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_25 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_15) / var_47_25

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_15 + var_47_25 and arg_44_1.time_ < var_47_15 + var_47_25 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play305052012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 305052012
		arg_48_1.duration_ = 3.53

		local var_48_0 = {
			zh = 1.833,
			ja = 3.533
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play305052013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1019ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1019ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1019ui_story then
				arg_48_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1011ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1011ui_story == nil then
				arg_48_1.var_.characterEffect1011ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.200000002980232

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1011ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1011ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1011ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1011ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0
			local var_51_11 = 0.2

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_12 = arg_48_1:FormatText(StoryNameCfg[13].name)

				arg_48_1.leftNameTxt_.text = var_51_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_13 = arg_48_1:GetWordFromCfg(305052012)
				local var_51_14 = arg_48_1:FormatText(var_51_13.content)

				arg_48_1.text_.text = var_51_14

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_15 = 8
				local var_51_16 = utf8.len(var_51_14)
				local var_51_17 = var_51_15 <= 0 and var_51_11 or var_51_11 * (var_51_16 / var_51_15)

				if var_51_17 > 0 and var_51_11 < var_51_17 then
					arg_48_1.talkMaxDuration = var_51_17

					if var_51_17 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_17 + var_51_10
					end
				end

				arg_48_1.text_.text = var_51_14
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052012", "story_v_out_305052.awb") ~= 0 then
					local var_51_18 = manager.audio:GetVoiceLength("story_v_out_305052", "305052012", "story_v_out_305052.awb") / 1000

					if var_51_18 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_10
					end

					if var_51_13.prefab_name ~= "" and arg_48_1.actors_[var_51_13.prefab_name] ~= nil then
						local var_51_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_13.prefab_name].transform, "story_v_out_305052", "305052012", "story_v_out_305052.awb")

						arg_48_1:RecordAudio("305052012", var_51_19)
						arg_48_1:RecordAudio("305052012", var_51_19)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_305052", "305052012", "story_v_out_305052.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_305052", "305052012", "story_v_out_305052.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_20 = math.max(var_51_11, arg_48_1.talkMaxDuration)

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_20 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_10) / var_51_20

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_10 + var_51_20 and arg_48_1.time_ < var_51_10 + var_51_20 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play305052013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 305052013
		arg_52_1.duration_ = 7.72

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play305052014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 1.16666666666667

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				local var_55_1 = manager.ui.mainCamera.transform.localPosition
				local var_55_2 = Vector3.New(0, 0, 10) + Vector3.New(var_55_1.x, var_55_1.y, 0)
				local var_55_3 = arg_52_1.bgs_.S0409

				var_55_3.transform.localPosition = var_55_2
				var_55_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_4 = var_55_3:GetComponent("SpriteRenderer")

				if var_55_4 and var_55_4.sprite then
					local var_55_5 = (var_55_3.transform.localPosition - var_55_1).z
					local var_55_6 = manager.ui.mainCameraCom_
					local var_55_7 = 2 * var_55_5 * Mathf.Tan(var_55_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_55_8 = var_55_7 * var_55_6.aspect
					local var_55_9 = var_55_4.sprite.bounds.size.x
					local var_55_10 = var_55_4.sprite.bounds.size.y
					local var_55_11 = var_55_8 / var_55_9
					local var_55_12 = var_55_7 / var_55_10
					local var_55_13 = var_55_12 < var_55_11 and var_55_11 or var_55_12

					var_55_3.transform.localScale = Vector3.New(var_55_13, var_55_13, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "S0409" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_14 = 1.16666666666667

			if var_55_14 < arg_52_1.time_ and arg_52_1.time_ <= var_55_14 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			local var_55_15 = 0.3

			if arg_52_1.time_ >= var_55_14 + var_55_15 and arg_52_1.time_ < var_55_14 + var_55_15 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			local var_55_16 = 0

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_17 = 1.16666666666667

			if var_55_16 <= arg_52_1.time_ and arg_52_1.time_ < var_55_16 + var_55_17 then
				local var_55_18 = (arg_52_1.time_ - var_55_16) / var_55_17
				local var_55_19 = Color.New(0, 0, 0)

				var_55_19.a = Mathf.Lerp(0, 1, var_55_18)
				arg_52_1.mask_.color = var_55_19
			end

			if arg_52_1.time_ >= var_55_16 + var_55_17 and arg_52_1.time_ < var_55_16 + var_55_17 + arg_55_0 then
				local var_55_20 = Color.New(0, 0, 0)

				var_55_20.a = 1
				arg_52_1.mask_.color = var_55_20
			end

			local var_55_21 = 1.16666666666667

			if var_55_21 < arg_52_1.time_ and arg_52_1.time_ <= var_55_21 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_22 = 1.4

			if var_55_21 <= arg_52_1.time_ and arg_52_1.time_ < var_55_21 + var_55_22 then
				local var_55_23 = (arg_52_1.time_ - var_55_21) / var_55_22
				local var_55_24 = Color.New(0, 0, 0)

				var_55_24.a = Mathf.Lerp(1, 0, var_55_23)
				arg_52_1.mask_.color = var_55_24
			end

			if arg_52_1.time_ >= var_55_21 + var_55_22 and arg_52_1.time_ < var_55_21 + var_55_22 + arg_55_0 then
				local var_55_25 = Color.New(0, 0, 0)
				local var_55_26 = 0

				arg_52_1.mask_.enabled = false
				var_55_25.a = var_55_26
				arg_52_1.mask_.color = var_55_25
			end

			local var_55_27 = arg_52_1.actors_["1019ui_story"]
			local var_55_28 = 1.16666666666667

			if var_55_28 < arg_52_1.time_ and arg_52_1.time_ <= var_55_28 + arg_55_0 and not isNil(var_55_27) and arg_52_1.var_.characterEffect1019ui_story == nil then
				arg_52_1.var_.characterEffect1019ui_story = var_55_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_29 = 0.200000002980232

			if var_55_28 <= arg_52_1.time_ and arg_52_1.time_ < var_55_28 + var_55_29 and not isNil(var_55_27) then
				local var_55_30 = (arg_52_1.time_ - var_55_28) / var_55_29

				if arg_52_1.var_.characterEffect1019ui_story and not isNil(var_55_27) then
					local var_55_31 = Mathf.Lerp(0, 0.5, var_55_30)

					arg_52_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1019ui_story.fillRatio = var_55_31
				end
			end

			if arg_52_1.time_ >= var_55_28 + var_55_29 and arg_52_1.time_ < var_55_28 + var_55_29 + arg_55_0 and not isNil(var_55_27) and arg_52_1.var_.characterEffect1019ui_story then
				local var_55_32 = 0.5

				arg_52_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1019ui_story.fillRatio = var_55_32
			end

			local var_55_33 = manager.ui.mainCamera.transform
			local var_55_34 = 1.16666666666667

			if var_55_34 < arg_52_1.time_ and arg_52_1.time_ <= var_55_34 + arg_55_0 then
				local var_55_35 = arg_52_1.var_.effect32131111

				if var_55_35 then
					Object.Destroy(var_55_35)

					arg_52_1.var_.effect32131111 = nil
				end
			end

			local var_55_36 = arg_52_1.bgs_.S0409.transform
			local var_55_37 = 1.16666666666667

			if var_55_37 < arg_52_1.time_ and arg_52_1.time_ <= var_55_37 + arg_55_0 then
				arg_52_1.var_.moveOldPosS0409 = var_55_36.localPosition
			end

			local var_55_38 = 2

			if var_55_37 <= arg_52_1.time_ and arg_52_1.time_ < var_55_37 + var_55_38 then
				local var_55_39 = (arg_52_1.time_ - var_55_37) / var_55_38
				local var_55_40 = Vector3.New(0, 0.56, 8)

				var_55_36.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPosS0409, var_55_40, var_55_39)
			end

			if arg_52_1.time_ >= var_55_37 + var_55_38 and arg_52_1.time_ < var_55_37 + var_55_38 + arg_55_0 then
				var_55_36.localPosition = Vector3.New(0, 0.56, 8)
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_41 = 2.71644048262388
			local var_55_42 = 1.475

			if var_55_41 < arg_52_1.time_ and arg_52_1.time_ <= var_55_41 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_43 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_43:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_52_1.dialogCg_.alpha = arg_56_0
				end))
				var_55_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_44 = arg_52_1:GetWordFromCfg(305052013)
				local var_55_45 = arg_52_1:FormatText(var_55_44.content)

				arg_52_1.text_.text = var_55_45

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_46 = 59
				local var_55_47 = utf8.len(var_55_45)
				local var_55_48 = var_55_46 <= 0 and var_55_42 or var_55_42 * (var_55_47 / var_55_46)

				if var_55_48 > 0 and var_55_42 < var_55_48 then
					arg_52_1.talkMaxDuration = var_55_48
					var_55_41 = var_55_41 + 0.3

					if var_55_48 + var_55_41 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_48 + var_55_41
					end
				end

				arg_52_1.text_.text = var_55_45
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_49 = var_55_41 + 0.3
			local var_55_50 = math.max(var_55_42, arg_52_1.talkMaxDuration)

			if var_55_49 <= arg_52_1.time_ and arg_52_1.time_ < var_55_49 + var_55_50 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_49) / var_55_50

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_49 + var_55_50 and arg_52_1.time_ < var_55_49 + var_55_50 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "S0409",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 0.56, 8),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play305052014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 305052014
		arg_58_1.duration_ = 5.47

		local var_58_0 = {
			zh = 5.166,
			ja = 5.466
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
				arg_58_0:Play305052015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 0.35

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[49].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_3 = arg_58_1:GetWordFromCfg(305052014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052014", "story_v_out_305052.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_305052", "305052014", "story_v_out_305052.awb") / 1000

					if var_61_8 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_0
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_305052", "305052014", "story_v_out_305052.awb")

						arg_58_1:RecordAudio("305052014", var_61_9)
						arg_58_1:RecordAudio("305052014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_305052", "305052014", "story_v_out_305052.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_305052", "305052014", "story_v_out_305052.awb")
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
	Play305052015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 305052015
		arg_62_1.duration_ = 21.37

		local var_62_0 = {
			zh = 21.366,
			ja = 19.033
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
				arg_62_0:Play305052016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 1.65

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_2 = arg_62_1:FormatText(StoryNameCfg[49].name)

				arg_62_1.leftNameTxt_.text = var_65_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_3 = arg_62_1:GetWordFromCfg(305052015)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 66
				local var_65_6 = utf8.len(var_65_4)
				local var_65_7 = var_65_5 <= 0 and var_65_1 or var_65_1 * (var_65_6 / var_65_5)

				if var_65_7 > 0 and var_65_1 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052015", "story_v_out_305052.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_305052", "305052015", "story_v_out_305052.awb") / 1000

					if var_65_8 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_0
					end

					if var_65_3.prefab_name ~= "" and arg_62_1.actors_[var_65_3.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_3.prefab_name].transform, "story_v_out_305052", "305052015", "story_v_out_305052.awb")

						arg_62_1:RecordAudio("305052015", var_65_9)
						arg_62_1:RecordAudio("305052015", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_305052", "305052015", "story_v_out_305052.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_305052", "305052015", "story_v_out_305052.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_10 and arg_62_1.time_ < var_65_0 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play305052016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 305052016
		arg_66_1.duration_ = 15.3

		local var_66_0 = {
			zh = 12.8,
			ja = 15.3
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
				arg_66_0:Play305052017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 1.025

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[49].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_3 = arg_66_1:GetWordFromCfg(305052016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 41
				local var_69_6 = utf8.len(var_69_4)
				local var_69_7 = var_69_5 <= 0 and var_69_1 or var_69_1 * (var_69_6 / var_69_5)

				if var_69_7 > 0 and var_69_1 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052016", "story_v_out_305052.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_305052", "305052016", "story_v_out_305052.awb") / 1000

					if var_69_8 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_0
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_305052", "305052016", "story_v_out_305052.awb")

						arg_66_1:RecordAudio("305052016", var_69_9)
						arg_66_1:RecordAudio("305052016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_305052", "305052016", "story_v_out_305052.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_305052", "305052016", "story_v_out_305052.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_10 and arg_66_1.time_ < var_69_0 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play305052017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 305052017
		arg_70_1.duration_ = 2.53

		local var_70_0 = {
			zh = 1.8,
			ja = 2.533
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
				arg_70_0:Play305052018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1019ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1019ui_story == nil then
				arg_70_1.var_.characterEffect1019ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect1019ui_story and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1019ui_story then
				arg_70_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_73_4 = 0
			local var_73_5 = 0.25

			if var_73_4 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_6 = arg_70_1:FormatText(StoryNameCfg[13].name)

				arg_70_1.leftNameTxt_.text = var_73_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_7 = arg_70_1:GetWordFromCfg(305052017)
				local var_73_8 = arg_70_1:FormatText(var_73_7.content)

				arg_70_1.text_.text = var_73_8

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_9 = 10
				local var_73_10 = utf8.len(var_73_8)
				local var_73_11 = var_73_9 <= 0 and var_73_5 or var_73_5 * (var_73_10 / var_73_9)

				if var_73_11 > 0 and var_73_5 < var_73_11 then
					arg_70_1.talkMaxDuration = var_73_11

					if var_73_11 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_11 + var_73_4
					end
				end

				arg_70_1.text_.text = var_73_8
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052017", "story_v_out_305052.awb") ~= 0 then
					local var_73_12 = manager.audio:GetVoiceLength("story_v_out_305052", "305052017", "story_v_out_305052.awb") / 1000

					if var_73_12 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_12 + var_73_4
					end

					if var_73_7.prefab_name ~= "" and arg_70_1.actors_[var_73_7.prefab_name] ~= nil then
						local var_73_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_7.prefab_name].transform, "story_v_out_305052", "305052017", "story_v_out_305052.awb")

						arg_70_1:RecordAudio("305052017", var_73_13)
						arg_70_1:RecordAudio("305052017", var_73_13)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_305052", "305052017", "story_v_out_305052.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_305052", "305052017", "story_v_out_305052.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_5, arg_70_1.talkMaxDuration)

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_4) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_4 + var_73_14 and arg_70_1.time_ < var_73_4 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play305052018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 305052018
		arg_74_1.duration_ = 6.97

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play305052019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = "S0506a"

			if arg_74_1.bgs_[var_77_0] == nil then
				local var_77_1 = Object.Instantiate(arg_74_1.paintGo_)

				var_77_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_77_0)
				var_77_1.name = var_77_0
				var_77_1.transform.parent = arg_74_1.stage_.transform
				var_77_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_74_1.bgs_[var_77_0] = var_77_1
			end

			local var_77_2 = 0.333333330353101

			if var_77_2 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				local var_77_3 = manager.ui.mainCamera.transform.localPosition
				local var_77_4 = Vector3.New(0, 0, 10) + Vector3.New(var_77_3.x, var_77_3.y, 0)
				local var_77_5 = arg_74_1.bgs_.S0506a

				var_77_5.transform.localPosition = var_77_4
				var_77_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_77_6 = var_77_5:GetComponent("SpriteRenderer")

				if var_77_6 and var_77_6.sprite then
					local var_77_7 = (var_77_5.transform.localPosition - var_77_3).z
					local var_77_8 = manager.ui.mainCameraCom_
					local var_77_9 = 2 * var_77_7 * Mathf.Tan(var_77_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_77_10 = var_77_9 * var_77_8.aspect
					local var_77_11 = var_77_6.sprite.bounds.size.x
					local var_77_12 = var_77_6.sprite.bounds.size.y
					local var_77_13 = var_77_10 / var_77_11
					local var_77_14 = var_77_9 / var_77_12
					local var_77_15 = var_77_14 < var_77_13 and var_77_13 or var_77_14

					var_77_5.transform.localScale = Vector3.New(var_77_15, var_77_15, 0)
				end

				for iter_77_0, iter_77_1 in pairs(arg_74_1.bgs_) do
					if iter_77_0 ~= "S0506a" then
						iter_77_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_77_16 = 0

			if var_77_16 < arg_74_1.time_ and arg_74_1.time_ <= var_77_16 + arg_77_0 then
				arg_74_1.allBtn_.enabled = false
			end

			local var_77_17 = 0.3

			if arg_74_1.time_ >= var_77_16 + var_77_17 and arg_74_1.time_ < var_77_16 + var_77_17 + arg_77_0 then
				arg_74_1.allBtn_.enabled = true
			end

			local var_77_18 = 0

			if var_77_18 < arg_74_1.time_ and arg_74_1.time_ <= var_77_18 + arg_77_0 then
				arg_74_1.mask_.enabled = true
				arg_74_1.mask_.raycastTarget = true

				arg_74_1:SetGaussion(false)
			end

			local var_77_19 = 0.2

			if var_77_18 <= arg_74_1.time_ and arg_74_1.time_ < var_77_18 + var_77_19 then
				local var_77_20 = (arg_74_1.time_ - var_77_18) / var_77_19
				local var_77_21 = Color.New(1, 1, 1)

				var_77_21.a = Mathf.Lerp(0, 1, var_77_20)
				arg_74_1.mask_.color = var_77_21
			end

			if arg_74_1.time_ >= var_77_18 + var_77_19 and arg_74_1.time_ < var_77_18 + var_77_19 + arg_77_0 then
				local var_77_22 = Color.New(1, 1, 1)

				var_77_22.a = 1
				arg_74_1.mask_.color = var_77_22
			end

			local var_77_23 = 0.2

			if var_77_23 < arg_74_1.time_ and arg_74_1.time_ <= var_77_23 + arg_77_0 then
				arg_74_1.mask_.enabled = true
				arg_74_1.mask_.raycastTarget = true

				arg_74_1:SetGaussion(false)
			end

			local var_77_24 = 0.333333333333333

			if var_77_23 <= arg_74_1.time_ and arg_74_1.time_ < var_77_23 + var_77_24 then
				local var_77_25 = (arg_74_1.time_ - var_77_23) / var_77_24
				local var_77_26 = Color.New(1, 1, 1)

				var_77_26.a = Mathf.Lerp(1, 0, var_77_25)
				arg_74_1.mask_.color = var_77_26
			end

			if arg_74_1.time_ >= var_77_23 + var_77_24 and arg_74_1.time_ < var_77_23 + var_77_24 + arg_77_0 then
				local var_77_27 = Color.New(1, 1, 1)
				local var_77_28 = 0

				arg_74_1.mask_.enabled = false
				var_77_27.a = var_77_28
				arg_74_1.mask_.color = var_77_27
			end

			local var_77_29 = arg_74_1.actors_["1019ui_story"]
			local var_77_30 = 0

			if var_77_30 < arg_74_1.time_ and arg_74_1.time_ <= var_77_30 + arg_77_0 and not isNil(var_77_29) and arg_74_1.var_.characterEffect1019ui_story == nil then
				arg_74_1.var_.characterEffect1019ui_story = var_77_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_31 = 0.200000002980232

			if var_77_30 <= arg_74_1.time_ and arg_74_1.time_ < var_77_30 + var_77_31 and not isNil(var_77_29) then
				local var_77_32 = (arg_74_1.time_ - var_77_30) / var_77_31

				if arg_74_1.var_.characterEffect1019ui_story and not isNil(var_77_29) then
					local var_77_33 = Mathf.Lerp(0, 0.5, var_77_32)

					arg_74_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1019ui_story.fillRatio = var_77_33
				end
			end

			if arg_74_1.time_ >= var_77_30 + var_77_31 and arg_74_1.time_ < var_77_30 + var_77_31 + arg_77_0 and not isNil(var_77_29) and arg_74_1.var_.characterEffect1019ui_story then
				local var_77_34 = 0.5

				arg_74_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1019ui_story.fillRatio = var_77_34
			end

			local var_77_35 = manager.ui.mainCamera.transform
			local var_77_36 = 0.533333330353101

			if var_77_36 < arg_74_1.time_ and arg_74_1.time_ <= var_77_36 + arg_77_0 then
				local var_77_37 = arg_74_1.var_.effectsssfsssf
				local var_77_38
				local var_77_39 = var_77_35

				if not var_77_37 then
					var_77_37 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boguang"), var_77_39)
					var_77_37.name = "sssf"
					arg_74_1.var_.effectsssfsssf = var_77_37
				else
					var_77_37.transform:SetParent(var_77_39)
				end

				var_77_37.transform.localPosition = Vector3.New(0, 0, 0)
				var_77_37.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_77_40 = 1.7777777777777777
				local var_77_41 = Screen.width / Screen.height
				local var_77_42 = var_77_41 / var_77_40
				local var_77_43 = Mathf.Max(var_77_40 / var_77_41, 1)

				var_77_37.transform.localScale = Vector3.New(var_77_37.transform.localScale.x * var_77_42, var_77_37.transform.localScale.y * var_77_43, var_77_37.transform.localScale.z)
			end

			local var_77_44 = manager.ui.mainCamera.transform
			local var_77_45 = 2.66666666368643

			if var_77_45 < arg_74_1.time_ and arg_74_1.time_ <= var_77_45 + arg_77_0 then
				local var_77_46 = arg_74_1.var_.effectsssfsssf

				if var_77_46 then
					Object.Destroy(var_77_46)

					arg_74_1.var_.effectsssfsssf = nil
				end
			end

			if arg_74_1.frameCnt_ <= 1 then
				arg_74_1.dialog_:SetActive(false)
			end

			local var_77_47 = 1.96666666666667
			local var_77_48 = 1

			if var_77_47 < arg_74_1.time_ and arg_74_1.time_ <= var_77_47 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0

				arg_74_1.dialog_:SetActive(true)

				arg_74_1.dialogCg_.alpha = 0

				local var_77_49 = LeanTween.value(arg_74_1.dialog_, 0, 1, 0.3)

				var_77_49:setOnUpdate(LuaHelper.FloatAction(function(arg_78_0)
					arg_74_1.dialogCg_.alpha = arg_78_0
				end))
				var_77_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_74_1.dialog_)
					var_77_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_74_1.duration_ = arg_74_1.duration_ + 0.3

				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_50 = arg_74_1:GetWordFromCfg(305052018)
				local var_77_51 = arg_74_1:FormatText(var_77_50.content)

				arg_74_1.text_.text = var_77_51

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_52 = 40
				local var_77_53 = utf8.len(var_77_51)
				local var_77_54 = var_77_52 <= 0 and var_77_48 or var_77_48 * (var_77_53 / var_77_52)

				if var_77_54 > 0 and var_77_48 < var_77_54 then
					arg_74_1.talkMaxDuration = var_77_54
					var_77_47 = var_77_47 + 0.3

					if var_77_54 + var_77_47 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_54 + var_77_47
					end
				end

				arg_74_1.text_.text = var_77_51
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_55 = var_77_47 + 0.3
			local var_77_56 = math.max(var_77_48, arg_74_1.talkMaxDuration)

			if var_77_55 <= arg_74_1.time_ and arg_74_1.time_ < var_77_55 + var_77_56 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_55) / var_77_56

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_55 + var_77_56 and arg_74_1.time_ < var_77_55 + var_77_56 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.48333333333333,
				amplitudeGain = 0.7,
				startTime = 0.333333330353101,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play305052019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 305052019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play305052020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 1.4

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_2 = arg_80_1:GetWordFromCfg(305052019)
				local var_83_3 = arg_80_1:FormatText(var_83_2.content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 56
				local var_83_5 = utf8.len(var_83_3)
				local var_83_6 = var_83_4 <= 0 and var_83_1 or var_83_1 * (var_83_5 / var_83_4)

				if var_83_6 > 0 and var_83_1 < var_83_6 then
					arg_80_1.talkMaxDuration = var_83_6

					if var_83_6 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_7 and arg_80_1.time_ < var_83_0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play305052020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 305052020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play305052021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 1.25

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_2 = arg_84_1:GetWordFromCfg(305052020)
				local var_87_3 = arg_84_1:FormatText(var_87_2.content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 50
				local var_87_5 = utf8.len(var_87_3)
				local var_87_6 = var_87_4 <= 0 and var_87_1 or var_87_1 * (var_87_5 / var_87_4)

				if var_87_6 > 0 and var_87_1 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_7 and arg_84_1.time_ < var_87_0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play305052021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 305052021
		arg_88_1.duration_ = 7.52

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play305052022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = "S0506"

			if arg_88_1.bgs_[var_91_0] == nil then
				local var_91_1 = Object.Instantiate(arg_88_1.paintGo_)

				var_91_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_91_0)
				var_91_1.name = var_91_0
				var_91_1.transform.parent = arg_88_1.stage_.transform
				var_91_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.bgs_[var_91_0] = var_91_1
			end

			local var_91_2 = 0.691666666666667

			if var_91_2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				local var_91_3 = manager.ui.mainCamera.transform.localPosition
				local var_91_4 = Vector3.New(0, 0, 10) + Vector3.New(var_91_3.x, var_91_3.y, 0)
				local var_91_5 = arg_88_1.bgs_.S0506

				var_91_5.transform.localPosition = var_91_4
				var_91_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_6 = var_91_5:GetComponent("SpriteRenderer")

				if var_91_6 and var_91_6.sprite then
					local var_91_7 = (var_91_5.transform.localPosition - var_91_3).z
					local var_91_8 = manager.ui.mainCameraCom_
					local var_91_9 = 2 * var_91_7 * Mathf.Tan(var_91_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_91_10 = var_91_9 * var_91_8.aspect
					local var_91_11 = var_91_6.sprite.bounds.size.x
					local var_91_12 = var_91_6.sprite.bounds.size.y
					local var_91_13 = var_91_10 / var_91_11
					local var_91_14 = var_91_9 / var_91_12
					local var_91_15 = var_91_14 < var_91_13 and var_91_13 or var_91_14

					var_91_5.transform.localScale = Vector3.New(var_91_15, var_91_15, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "S0506" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_91_16 = 0

			if var_91_16 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 then
				arg_88_1.allBtn_.enabled = false
			end

			local var_91_17 = 0.3

			if arg_88_1.time_ >= var_91_16 + var_91_17 and arg_88_1.time_ < var_91_16 + var_91_17 + arg_91_0 then
				arg_88_1.allBtn_.enabled = true
			end

			local var_91_18 = 0

			if var_91_18 < arg_88_1.time_ and arg_88_1.time_ <= var_91_18 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_19 = 0.691666666666667

			if var_91_18 <= arg_88_1.time_ and arg_88_1.time_ < var_91_18 + var_91_19 then
				local var_91_20 = (arg_88_1.time_ - var_91_18) / var_91_19
				local var_91_21 = Color.New(0, 0, 0)

				var_91_21.a = Mathf.Lerp(0, 1, var_91_20)
				arg_88_1.mask_.color = var_91_21
			end

			if arg_88_1.time_ >= var_91_18 + var_91_19 and arg_88_1.time_ < var_91_18 + var_91_19 + arg_91_0 then
				local var_91_22 = Color.New(0, 0, 0)

				var_91_22.a = 1
				arg_88_1.mask_.color = var_91_22
			end

			local var_91_23 = 0.691666666666667

			if var_91_23 < arg_88_1.time_ and arg_88_1.time_ <= var_91_23 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_24 = 0.508333333333333

			if var_91_23 <= arg_88_1.time_ and arg_88_1.time_ < var_91_23 + var_91_24 then
				local var_91_25 = (arg_88_1.time_ - var_91_23) / var_91_24
				local var_91_26 = Color.New(1, 1, 1)

				var_91_26.a = Mathf.Lerp(1, 0, var_91_25)
				arg_88_1.mask_.color = var_91_26
			end

			if arg_88_1.time_ >= var_91_23 + var_91_24 and arg_88_1.time_ < var_91_23 + var_91_24 + arg_91_0 then
				local var_91_27 = Color.New(1, 1, 1)
				local var_91_28 = 0

				arg_88_1.mask_.enabled = false
				var_91_27.a = var_91_28
				arg_88_1.mask_.color = var_91_27
			end

			local var_91_29 = 1.56666666666667

			if var_91_29 < arg_88_1.time_ and arg_88_1.time_ <= var_91_29 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_30 = 0.508333333333333

			if var_91_29 <= arg_88_1.time_ and arg_88_1.time_ < var_91_29 + var_91_30 then
				local var_91_31 = (arg_88_1.time_ - var_91_29) / var_91_30
				local var_91_32 = Color.New(1, 1, 1)

				var_91_32.a = Mathf.Lerp(1, 0, var_91_31)
				arg_88_1.mask_.color = var_91_32
			end

			if arg_88_1.time_ >= var_91_29 + var_91_30 and arg_88_1.time_ < var_91_29 + var_91_30 + arg_91_0 then
				local var_91_33 = Color.New(1, 1, 1)
				local var_91_34 = 0

				arg_88_1.mask_.enabled = false
				var_91_33.a = var_91_34
				arg_88_1.mask_.color = var_91_33
			end

			local var_91_35
			local var_91_36 = 0.691666666666667

			if var_91_36 < arg_88_1.time_ and arg_88_1.time_ <= var_91_36 + arg_91_0 then
				local var_91_37 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_91_37 then
					var_91_37.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_91_37.radialBlurScale = 0
					var_91_37.radialBlurGradient = 1
					var_91_37.radialBlurIntensity = 1

					if var_91_35 then
						var_91_37.radialBlurTarget = var_91_35.transform
					end
				end
			end

			local var_91_38 = 1.675

			if var_91_36 <= arg_88_1.time_ and arg_88_1.time_ < var_91_36 + var_91_38 then
				local var_91_39 = (arg_88_1.time_ - var_91_36) / var_91_38
				local var_91_40 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_91_40 then
					var_91_40.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_91_40.radialBlurScale = Mathf.Lerp(0, 0.986, var_91_39)
					var_91_40.radialBlurGradient = Mathf.Lerp(1, 1, var_91_39)
					var_91_40.radialBlurIntensity = Mathf.Lerp(1, 1, var_91_39)
				end
			end

			if arg_88_1.time_ >= var_91_36 + var_91_38 and arg_88_1.time_ < var_91_36 + var_91_38 + arg_91_0 then
				local var_91_41 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_91_41 then
					var_91_41.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_91_41.radialBlurScale = 0.986
					var_91_41.radialBlurGradient = 1
					var_91_41.radialBlurIntensity = 1
				end
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_42 = 2.52499999403954
			local var_91_43 = 1.325

			if var_91_42 < arg_88_1.time_ and arg_88_1.time_ <= var_91_42 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_44 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_44:setOnUpdate(LuaHelper.FloatAction(function(arg_92_0)
					arg_88_1.dialogCg_.alpha = arg_92_0
				end))
				var_91_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_45 = arg_88_1:GetWordFromCfg(305052021)
				local var_91_46 = arg_88_1:FormatText(var_91_45.content)

				arg_88_1.text_.text = var_91_46

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_47 = 53
				local var_91_48 = utf8.len(var_91_46)
				local var_91_49 = var_91_47 <= 0 and var_91_43 or var_91_43 * (var_91_48 / var_91_47)

				if var_91_49 > 0 and var_91_43 < var_91_49 then
					arg_88_1.talkMaxDuration = var_91_49
					var_91_42 = var_91_42 + 0.3

					if var_91_49 + var_91_42 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_49 + var_91_42
					end
				end

				arg_88_1.text_.text = var_91_46
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_50 = var_91_42 + 0.3
			local var_91_51 = math.max(var_91_43, arg_88_1.talkMaxDuration)

			if var_91_50 <= arg_88_1.time_ and arg_88_1.time_ < var_91_50 + var_91_51 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_50) / var_91_51

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_50 + var_91_51 and arg_88_1.time_ < var_91_50 + var_91_51 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D Wobble",
				duration = 0.7,
				amplitudeGain = 0.1,
				startTime = 0.691666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play305052022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 305052022
		arg_94_1.duration_ = 3.2

		local var_94_0 = {
			zh = 3.2,
			ja = 1.333
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play305052023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1084ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1084ui_story == nil then
				arg_94_1.var_.characterEffect1084ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1084ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1084ui_story then
				arg_94_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_97_4 = 0
			local var_97_5 = 0.275

			if var_97_4 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_6 = arg_94_1:FormatText(StoryNameCfg[6].name)

				arg_94_1.leftNameTxt_.text = var_97_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_7 = arg_94_1:GetWordFromCfg(305052022)
				local var_97_8 = arg_94_1:FormatText(var_97_7.content)

				arg_94_1.text_.text = var_97_8

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_9 = 11
				local var_97_10 = utf8.len(var_97_8)
				local var_97_11 = var_97_9 <= 0 and var_97_5 or var_97_5 * (var_97_10 / var_97_9)

				if var_97_11 > 0 and var_97_5 < var_97_11 then
					arg_94_1.talkMaxDuration = var_97_11

					if var_97_11 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_11 + var_97_4
					end
				end

				arg_94_1.text_.text = var_97_8
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052022", "story_v_out_305052.awb") ~= 0 then
					local var_97_12 = manager.audio:GetVoiceLength("story_v_out_305052", "305052022", "story_v_out_305052.awb") / 1000

					if var_97_12 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_12 + var_97_4
					end

					if var_97_7.prefab_name ~= "" and arg_94_1.actors_[var_97_7.prefab_name] ~= nil then
						local var_97_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_7.prefab_name].transform, "story_v_out_305052", "305052022", "story_v_out_305052.awb")

						arg_94_1:RecordAudio("305052022", var_97_13)
						arg_94_1:RecordAudio("305052022", var_97_13)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_305052", "305052022", "story_v_out_305052.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_305052", "305052022", "story_v_out_305052.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_14 = math.max(var_97_5, arg_94_1.talkMaxDuration)

			if var_97_4 <= arg_94_1.time_ and arg_94_1.time_ < var_97_4 + var_97_14 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_4) / var_97_14

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_4 + var_97_14 and arg_94_1.time_ < var_97_4 + var_97_14 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play305052023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 305052023
		arg_98_1.duration_ = 8.11

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play305052024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = "B04f"

			if arg_98_1.bgs_[var_101_0] == nil then
				local var_101_1 = Object.Instantiate(arg_98_1.paintGo_)

				var_101_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_101_0)
				var_101_1.name = var_101_0
				var_101_1.transform.parent = arg_98_1.stage_.transform
				var_101_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.bgs_[var_101_0] = var_101_1
			end

			local var_101_2 = 1.53333333333333

			if var_101_2 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 then
				local var_101_3 = manager.ui.mainCamera.transform.localPosition
				local var_101_4 = Vector3.New(0, 0, 10) + Vector3.New(var_101_3.x, var_101_3.y, 0)
				local var_101_5 = arg_98_1.bgs_.B04f

				var_101_5.transform.localPosition = var_101_4
				var_101_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_101_6 = var_101_5:GetComponent("SpriteRenderer")

				if var_101_6 and var_101_6.sprite then
					local var_101_7 = (var_101_5.transform.localPosition - var_101_3).z
					local var_101_8 = manager.ui.mainCameraCom_
					local var_101_9 = 2 * var_101_7 * Mathf.Tan(var_101_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_101_10 = var_101_9 * var_101_8.aspect
					local var_101_11 = var_101_6.sprite.bounds.size.x
					local var_101_12 = var_101_6.sprite.bounds.size.y
					local var_101_13 = var_101_10 / var_101_11
					local var_101_14 = var_101_9 / var_101_12
					local var_101_15 = var_101_14 < var_101_13 and var_101_13 or var_101_14

					var_101_5.transform.localScale = Vector3.New(var_101_15, var_101_15, 0)
				end

				for iter_101_0, iter_101_1 in pairs(arg_98_1.bgs_) do
					if iter_101_0 ~= "B04f" then
						iter_101_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_101_16 = 0

			if var_101_16 < arg_98_1.time_ and arg_98_1.time_ <= var_101_16 + arg_101_0 then
				arg_98_1.allBtn_.enabled = false
			end

			local var_101_17 = 0.3

			if arg_98_1.time_ >= var_101_16 + var_101_17 and arg_98_1.time_ < var_101_16 + var_101_17 + arg_101_0 then
				arg_98_1.allBtn_.enabled = true
			end

			local var_101_18 = 0

			if var_101_18 < arg_98_1.time_ and arg_98_1.time_ <= var_101_18 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_19 = 1.53333333333333

			if var_101_18 <= arg_98_1.time_ and arg_98_1.time_ < var_101_18 + var_101_19 then
				local var_101_20 = (arg_98_1.time_ - var_101_18) / var_101_19
				local var_101_21 = Color.New(0, 0, 0)

				var_101_21.a = Mathf.Lerp(0, 1, var_101_20)
				arg_98_1.mask_.color = var_101_21
			end

			if arg_98_1.time_ >= var_101_18 + var_101_19 and arg_98_1.time_ < var_101_18 + var_101_19 + arg_101_0 then
				local var_101_22 = Color.New(0, 0, 0)

				var_101_22.a = 1
				arg_98_1.mask_.color = var_101_22
			end

			local var_101_23 = 1.53333333333333

			if var_101_23 < arg_98_1.time_ and arg_98_1.time_ <= var_101_23 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_24 = 1.23333333333333

			if var_101_23 <= arg_98_1.time_ and arg_98_1.time_ < var_101_23 + var_101_24 then
				local var_101_25 = (arg_98_1.time_ - var_101_23) / var_101_24
				local var_101_26 = Color.New(0, 0, 0)

				var_101_26.a = Mathf.Lerp(1, 0, var_101_25)
				arg_98_1.mask_.color = var_101_26
			end

			if arg_98_1.time_ >= var_101_23 + var_101_24 and arg_98_1.time_ < var_101_23 + var_101_24 + arg_101_0 then
				local var_101_27 = Color.New(0, 0, 0)
				local var_101_28 = 0

				arg_98_1.mask_.enabled = false
				var_101_27.a = var_101_28
				arg_98_1.mask_.color = var_101_27
			end

			local var_101_29 = arg_98_1.actors_["1084ui_story"]
			local var_101_30 = 0

			if var_101_30 < arg_98_1.time_ and arg_98_1.time_ <= var_101_30 + arg_101_0 and not isNil(var_101_29) and arg_98_1.var_.characterEffect1084ui_story == nil then
				arg_98_1.var_.characterEffect1084ui_story = var_101_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_31 = 0.200000002980232

			if var_101_30 <= arg_98_1.time_ and arg_98_1.time_ < var_101_30 + var_101_31 and not isNil(var_101_29) then
				local var_101_32 = (arg_98_1.time_ - var_101_30) / var_101_31

				if arg_98_1.var_.characterEffect1084ui_story and not isNil(var_101_29) then
					local var_101_33 = Mathf.Lerp(0, 0.5, var_101_32)

					arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1084ui_story.fillRatio = var_101_33
				end
			end

			if arg_98_1.time_ >= var_101_30 + var_101_31 and arg_98_1.time_ < var_101_30 + var_101_31 + arg_101_0 and not isNil(var_101_29) and arg_98_1.var_.characterEffect1084ui_story then
				local var_101_34 = 0.5

				arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1084ui_story.fillRatio = var_101_34
			end

			local var_101_35
			local var_101_36 = 1.43333333333333

			if var_101_36 < arg_98_1.time_ and arg_98_1.time_ <= var_101_36 + arg_101_0 then
				local var_101_37 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_101_37 then
					var_101_37.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_101_37.radialBlurScale = 1
					var_101_37.radialBlurGradient = 1
					var_101_37.radialBlurIntensity = 1

					if var_101_35 then
						var_101_37.radialBlurTarget = var_101_35.transform
					end
				end
			end

			local var_101_38 = 0.233333333333333

			if var_101_36 <= arg_98_1.time_ and arg_98_1.time_ < var_101_36 + var_101_38 then
				local var_101_39 = (arg_98_1.time_ - var_101_36) / var_101_38
				local var_101_40 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_101_40 then
					var_101_40.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_101_40.radialBlurScale = Mathf.Lerp(1, 0, var_101_39)
					var_101_40.radialBlurGradient = Mathf.Lerp(1, 1, var_101_39)
					var_101_40.radialBlurIntensity = Mathf.Lerp(1, 1, var_101_39)
				end
			end

			if arg_98_1.time_ >= var_101_36 + var_101_38 and arg_98_1.time_ < var_101_36 + var_101_38 + arg_101_0 then
				local var_101_41 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_101_41 then
					var_101_41.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_101_41.radialBlurScale = 0
					var_101_41.radialBlurGradient = 1
					var_101_41.radialBlurIntensity = 1
				end
			end

			if arg_98_1.frameCnt_ <= 1 then
				arg_98_1.dialog_:SetActive(false)
			end

			local var_101_42 = 3.10833333333333
			local var_101_43 = 1.65

			if var_101_42 < arg_98_1.time_ and arg_98_1.time_ <= var_101_42 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_44 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_44:setOnUpdate(LuaHelper.FloatAction(function(arg_102_0)
					arg_98_1.dialogCg_.alpha = arg_102_0
				end))
				var_101_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_45 = arg_98_1:GetWordFromCfg(305052023)
				local var_101_46 = arg_98_1:FormatText(var_101_45.content)

				arg_98_1.text_.text = var_101_46

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_47 = 66
				local var_101_48 = utf8.len(var_101_46)
				local var_101_49 = var_101_47 <= 0 and var_101_43 or var_101_43 * (var_101_48 / var_101_47)

				if var_101_49 > 0 and var_101_43 < var_101_49 then
					arg_98_1.talkMaxDuration = var_101_49
					var_101_42 = var_101_42 + 0.3

					if var_101_49 + var_101_42 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_49 + var_101_42
					end
				end

				arg_98_1.text_.text = var_101_46
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_50 = var_101_42 + 0.3
			local var_101_51 = math.max(var_101_43, arg_98_1.talkMaxDuration)

			if var_101_50 <= arg_98_1.time_ and arg_98_1.time_ < var_101_50 + var_101_51 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_50) / var_101_51

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_50 + var_101_51 and arg_98_1.time_ < var_101_50 + var_101_51 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play305052024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 305052024
		arg_104_1.duration_ = 8.93

		local var_104_0 = {
			zh = 6.833,
			ja = 8.933
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play305052025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.575

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[49].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(305052024)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 23
				local var_107_6 = utf8.len(var_107_4)
				local var_107_7 = var_107_5 <= 0 and var_107_1 or var_107_1 * (var_107_6 / var_107_5)

				if var_107_7 > 0 and var_107_1 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052024", "story_v_out_305052.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_305052", "305052024", "story_v_out_305052.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_305052", "305052024", "story_v_out_305052.awb")

						arg_104_1:RecordAudio("305052024", var_107_9)
						arg_104_1:RecordAudio("305052024", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_305052", "305052024", "story_v_out_305052.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_305052", "305052024", "story_v_out_305052.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_10 and arg_104_1.time_ < var_107_0 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play305052025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 305052025
		arg_108_1.duration_ = 9.4

		local var_108_0 = {
			zh = 9.4,
			ja = 8.7
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play305052026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1019ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1019ui_story = var_111_0.localPosition
			end

			local var_111_2 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2
				local var_111_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1019ui_story, var_111_4, var_111_3)

				local var_111_5 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_5.x, var_111_5.y, var_111_5.z)

				local var_111_6 = var_111_0.localEulerAngles

				var_111_6.z = 0
				var_111_6.x = 0
				var_111_0.localEulerAngles = var_111_6
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_111_7 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_7.x, var_111_7.y, var_111_7.z)

				local var_111_8 = var_111_0.localEulerAngles

				var_111_8.z = 0
				var_111_8.x = 0
				var_111_0.localEulerAngles = var_111_8
			end

			local var_111_9 = arg_108_1.actors_["1019ui_story"]
			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect1019ui_story == nil then
				arg_108_1.var_.characterEffect1019ui_story = var_111_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_11 = 0.200000002980232

			if var_111_10 <= arg_108_1.time_ and arg_108_1.time_ < var_111_10 + var_111_11 and not isNil(var_111_9) then
				local var_111_12 = (arg_108_1.time_ - var_111_10) / var_111_11

				if arg_108_1.var_.characterEffect1019ui_story and not isNil(var_111_9) then
					arg_108_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_10 + var_111_11 and arg_108_1.time_ < var_111_10 + var_111_11 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect1019ui_story then
				arg_108_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_111_13 = 0

			if var_111_13 < arg_108_1.time_ and arg_108_1.time_ <= var_111_13 + arg_111_0 then
				arg_108_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_111_14 = 0

			if var_111_14 < arg_108_1.time_ and arg_108_1.time_ <= var_111_14 + arg_111_0 then
				arg_108_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_111_15 = 0
			local var_111_16 = 1.175

			if var_111_15 < arg_108_1.time_ and arg_108_1.time_ <= var_111_15 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_17 = arg_108_1:FormatText(StoryNameCfg[13].name)

				arg_108_1.leftNameTxt_.text = var_111_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_18 = arg_108_1:GetWordFromCfg(305052025)
				local var_111_19 = arg_108_1:FormatText(var_111_18.content)

				arg_108_1.text_.text = var_111_19

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_20 = 47
				local var_111_21 = utf8.len(var_111_19)
				local var_111_22 = var_111_20 <= 0 and var_111_16 or var_111_16 * (var_111_21 / var_111_20)

				if var_111_22 > 0 and var_111_16 < var_111_22 then
					arg_108_1.talkMaxDuration = var_111_22

					if var_111_22 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_22 + var_111_15
					end
				end

				arg_108_1.text_.text = var_111_19
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052025", "story_v_out_305052.awb") ~= 0 then
					local var_111_23 = manager.audio:GetVoiceLength("story_v_out_305052", "305052025", "story_v_out_305052.awb") / 1000

					if var_111_23 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_23 + var_111_15
					end

					if var_111_18.prefab_name ~= "" and arg_108_1.actors_[var_111_18.prefab_name] ~= nil then
						local var_111_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_18.prefab_name].transform, "story_v_out_305052", "305052025", "story_v_out_305052.awb")

						arg_108_1:RecordAudio("305052025", var_111_24)
						arg_108_1:RecordAudio("305052025", var_111_24)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_305052", "305052025", "story_v_out_305052.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_305052", "305052025", "story_v_out_305052.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_25 = math.max(var_111_16, arg_108_1.talkMaxDuration)

			if var_111_15 <= arg_108_1.time_ and arg_108_1.time_ < var_111_15 + var_111_25 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_15) / var_111_25

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_15 + var_111_25 and arg_108_1.time_ < var_111_15 + var_111_25 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play305052026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 305052026
		arg_112_1.duration_ = 13.2

		local var_112_0 = {
			zh = 7.633,
			ja = 13.2
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
				arg_112_0:Play305052027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 1.025

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[13].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_3 = arg_112_1:GetWordFromCfg(305052026)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052026", "story_v_out_305052.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_305052", "305052026", "story_v_out_305052.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_305052", "305052026", "story_v_out_305052.awb")

						arg_112_1:RecordAudio("305052026", var_115_9)
						arg_112_1:RecordAudio("305052026", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_305052", "305052026", "story_v_out_305052.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_305052", "305052026", "story_v_out_305052.awb")
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
	Play305052027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 305052027
		arg_116_1.duration_ = 7.67

		local var_116_0 = {
			zh = 7.666,
			ja = 7.5
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play305052028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1019ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1019ui_story == nil then
				arg_116_1.var_.characterEffect1019ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1019ui_story and not isNil(var_119_0) then
					local var_119_4 = Mathf.Lerp(0, 0.5, var_119_3)

					arg_116_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1019ui_story.fillRatio = var_119_4
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1019ui_story then
				local var_119_5 = 0.5

				arg_116_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1019ui_story.fillRatio = var_119_5
			end

			local var_119_6 = arg_116_1.actors_["1019ui_story"].transform
			local var_119_7 = 0

			if var_119_7 < arg_116_1.time_ and arg_116_1.time_ <= var_119_7 + arg_119_0 then
				arg_116_1.var_.moveOldPos1019ui_story = var_119_6.localPosition
			end

			local var_119_8 = 0.001

			if var_119_7 <= arg_116_1.time_ and arg_116_1.time_ < var_119_7 + var_119_8 then
				local var_119_9 = (arg_116_1.time_ - var_119_7) / var_119_8
				local var_119_10 = Vector3.New(0, 100, 0)

				var_119_6.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1019ui_story, var_119_10, var_119_9)

				local var_119_11 = manager.ui.mainCamera.transform.position - var_119_6.position

				var_119_6.forward = Vector3.New(var_119_11.x, var_119_11.y, var_119_11.z)

				local var_119_12 = var_119_6.localEulerAngles

				var_119_12.z = 0
				var_119_12.x = 0
				var_119_6.localEulerAngles = var_119_12
			end

			if arg_116_1.time_ >= var_119_7 + var_119_8 and arg_116_1.time_ < var_119_7 + var_119_8 + arg_119_0 then
				var_119_6.localPosition = Vector3.New(0, 100, 0)

				local var_119_13 = manager.ui.mainCamera.transform.position - var_119_6.position

				var_119_6.forward = Vector3.New(var_119_13.x, var_119_13.y, var_119_13.z)

				local var_119_14 = var_119_6.localEulerAngles

				var_119_14.z = 0
				var_119_14.x = 0
				var_119_6.localEulerAngles = var_119_14
			end

			local var_119_15 = 0
			local var_119_16 = 0.55

			if var_119_15 < arg_116_1.time_ and arg_116_1.time_ <= var_119_15 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_17 = arg_116_1:FormatText(StoryNameCfg[49].name)

				arg_116_1.leftNameTxt_.text = var_119_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_18 = arg_116_1:GetWordFromCfg(305052027)
				local var_119_19 = arg_116_1:FormatText(var_119_18.content)

				arg_116_1.text_.text = var_119_19

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_20 = 22
				local var_119_21 = utf8.len(var_119_19)
				local var_119_22 = var_119_20 <= 0 and var_119_16 or var_119_16 * (var_119_21 / var_119_20)

				if var_119_22 > 0 and var_119_16 < var_119_22 then
					arg_116_1.talkMaxDuration = var_119_22

					if var_119_22 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_22 + var_119_15
					end
				end

				arg_116_1.text_.text = var_119_19
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052027", "story_v_out_305052.awb") ~= 0 then
					local var_119_23 = manager.audio:GetVoiceLength("story_v_out_305052", "305052027", "story_v_out_305052.awb") / 1000

					if var_119_23 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_23 + var_119_15
					end

					if var_119_18.prefab_name ~= "" and arg_116_1.actors_[var_119_18.prefab_name] ~= nil then
						local var_119_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_18.prefab_name].transform, "story_v_out_305052", "305052027", "story_v_out_305052.awb")

						arg_116_1:RecordAudio("305052027", var_119_24)
						arg_116_1:RecordAudio("305052027", var_119_24)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_305052", "305052027", "story_v_out_305052.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_305052", "305052027", "story_v_out_305052.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_25 = math.max(var_119_16, arg_116_1.talkMaxDuration)

			if var_119_15 <= arg_116_1.time_ and arg_116_1.time_ < var_119_15 + var_119_25 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_15) / var_119_25

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_15 + var_119_25 and arg_116_1.time_ < var_119_15 + var_119_25 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play305052028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 305052028
		arg_120_1.duration_ = 14.97

		local var_120_0 = {
			zh = 14.966,
			ja = 14.3
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play305052029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.975

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[49].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(305052028)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 39
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052028", "story_v_out_305052.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_305052", "305052028", "story_v_out_305052.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_305052", "305052028", "story_v_out_305052.awb")

						arg_120_1:RecordAudio("305052028", var_123_9)
						arg_120_1:RecordAudio("305052028", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_305052", "305052028", "story_v_out_305052.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_305052", "305052028", "story_v_out_305052.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play305052029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 305052029
		arg_124_1.duration_ = 7.9

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play305052030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = "S0501"

			if arg_124_1.bgs_[var_127_0] == nil then
				local var_127_1 = Object.Instantiate(arg_124_1.paintGo_)

				var_127_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_127_0)
				var_127_1.name = var_127_0
				var_127_1.transform.parent = arg_124_1.stage_.transform
				var_127_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_124_1.bgs_[var_127_0] = var_127_1
			end

			local var_127_2 = 0.9

			if var_127_2 < arg_124_1.time_ and arg_124_1.time_ <= var_127_2 + arg_127_0 then
				local var_127_3 = manager.ui.mainCamera.transform.localPosition
				local var_127_4 = Vector3.New(0, 0, 10) + Vector3.New(var_127_3.x, var_127_3.y, 0)
				local var_127_5 = arg_124_1.bgs_.S0501

				var_127_5.transform.localPosition = var_127_4
				var_127_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_127_6 = var_127_5:GetComponent("SpriteRenderer")

				if var_127_6 and var_127_6.sprite then
					local var_127_7 = (var_127_5.transform.localPosition - var_127_3).z
					local var_127_8 = manager.ui.mainCameraCom_
					local var_127_9 = 2 * var_127_7 * Mathf.Tan(var_127_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_127_10 = var_127_9 * var_127_8.aspect
					local var_127_11 = var_127_6.sprite.bounds.size.x
					local var_127_12 = var_127_6.sprite.bounds.size.y
					local var_127_13 = var_127_10 / var_127_11
					local var_127_14 = var_127_9 / var_127_12
					local var_127_15 = var_127_14 < var_127_13 and var_127_13 or var_127_14

					var_127_5.transform.localScale = Vector3.New(var_127_15, var_127_15, 0)
				end

				for iter_127_0, iter_127_1 in pairs(arg_124_1.bgs_) do
					if iter_127_0 ~= "S0501" then
						iter_127_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_127_16 = 0.9

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 then
				arg_124_1.allBtn_.enabled = false
			end

			local var_127_17 = 0.3

			if arg_124_1.time_ >= var_127_16 + var_127_17 and arg_124_1.time_ < var_127_16 + var_127_17 + arg_127_0 then
				arg_124_1.allBtn_.enabled = true
			end

			local var_127_18 = 0

			if var_127_18 < arg_124_1.time_ and arg_124_1.time_ <= var_127_18 + arg_127_0 then
				arg_124_1.mask_.enabled = true
				arg_124_1.mask_.raycastTarget = true

				arg_124_1:SetGaussion(false)
			end

			local var_127_19 = 0.9

			if var_127_18 <= arg_124_1.time_ and arg_124_1.time_ < var_127_18 + var_127_19 then
				local var_127_20 = (arg_124_1.time_ - var_127_18) / var_127_19
				local var_127_21 = Color.New(0, 0, 0)

				var_127_21.a = Mathf.Lerp(0, 1, var_127_20)
				arg_124_1.mask_.color = var_127_21
			end

			if arg_124_1.time_ >= var_127_18 + var_127_19 and arg_124_1.time_ < var_127_18 + var_127_19 + arg_127_0 then
				local var_127_22 = Color.New(0, 0, 0)

				var_127_22.a = 1
				arg_124_1.mask_.color = var_127_22
			end

			local var_127_23 = 0.9

			if var_127_23 < arg_124_1.time_ and arg_124_1.time_ <= var_127_23 + arg_127_0 then
				arg_124_1.mask_.enabled = true
				arg_124_1.mask_.raycastTarget = true

				arg_124_1:SetGaussion(false)
			end

			local var_127_24 = 1.4

			if var_127_23 <= arg_124_1.time_ and arg_124_1.time_ < var_127_23 + var_127_24 then
				local var_127_25 = (arg_124_1.time_ - var_127_23) / var_127_24
				local var_127_26 = Color.New(0.9716981, 0.9716981, 0.9716981)

				var_127_26.a = Mathf.Lerp(1, 0, var_127_25)
				arg_124_1.mask_.color = var_127_26
			end

			if arg_124_1.time_ >= var_127_23 + var_127_24 and arg_124_1.time_ < var_127_23 + var_127_24 + arg_127_0 then
				local var_127_27 = Color.New(0.9716981, 0.9716981, 0.9716981)
				local var_127_28 = 0

				arg_124_1.mask_.enabled = false
				var_127_27.a = var_127_28
				arg_124_1.mask_.color = var_127_27
			end

			local var_127_29 = arg_124_1.actors_["1019ui_story"].transform
			local var_127_30 = 0.2

			if var_127_30 < arg_124_1.time_ and arg_124_1.time_ <= var_127_30 + arg_127_0 then
				arg_124_1.var_.moveOldPos1019ui_story = var_127_29.localPosition
			end

			local var_127_31 = 0.001

			if var_127_30 <= arg_124_1.time_ and arg_124_1.time_ < var_127_30 + var_127_31 then
				local var_127_32 = (arg_124_1.time_ - var_127_30) / var_127_31
				local var_127_33 = Vector3.New(0, 100, 0)

				var_127_29.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1019ui_story, var_127_33, var_127_32)

				local var_127_34 = manager.ui.mainCamera.transform.position - var_127_29.position

				var_127_29.forward = Vector3.New(var_127_34.x, var_127_34.y, var_127_34.z)

				local var_127_35 = var_127_29.localEulerAngles

				var_127_35.z = 0
				var_127_35.x = 0
				var_127_29.localEulerAngles = var_127_35
			end

			if arg_124_1.time_ >= var_127_30 + var_127_31 and arg_124_1.time_ < var_127_30 + var_127_31 + arg_127_0 then
				var_127_29.localPosition = Vector3.New(0, 100, 0)

				local var_127_36 = manager.ui.mainCamera.transform.position - var_127_29.position

				var_127_29.forward = Vector3.New(var_127_36.x, var_127_36.y, var_127_36.z)

				local var_127_37 = var_127_29.localEulerAngles

				var_127_37.z = 0
				var_127_37.x = 0
				var_127_29.localEulerAngles = var_127_37
			end

			local var_127_38 = manager.ui.mainCamera.transform
			local var_127_39 = 0

			if var_127_39 < arg_124_1.time_ and arg_124_1.time_ <= var_127_39 + arg_127_0 then
				local var_127_40 = arg_124_1.var_.effect柔柔弱弱
				local var_127_41
				local var_127_42 = var_127_38

				if not var_127_40 then
					var_127_40 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_127_42)
					var_127_40.name = "柔柔弱弱"
					arg_124_1.var_.effect柔柔弱弱 = var_127_40
				else
					var_127_40.transform:SetParent(var_127_42)
				end

				var_127_40.transform.localPosition = Vector3.New(0, 0, 0)
				var_127_40.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_127_43 = 1.7777777777777777
				local var_127_44 = Screen.width / Screen.height
				local var_127_45 = var_127_44 / var_127_43
				local var_127_46 = Mathf.Max(var_127_43 / var_127_44, 1)

				var_127_40.transform.localScale = Vector3.New(var_127_40.transform.localScale.x * var_127_45, var_127_40.transform.localScale.y * var_127_46, var_127_40.transform.localScale.z)
			end

			local var_127_47 = manager.ui.mainCamera.transform
			local var_127_48 = 1.6

			if var_127_48 < arg_124_1.time_ and arg_124_1.time_ <= var_127_48 + arg_127_0 then
				local var_127_49 = arg_124_1.var_.effect柔柔弱弱

				if var_127_49 then
					Object.Destroy(var_127_49)

					arg_124_1.var_.effect柔柔弱弱 = nil
				end
			end

			local var_127_50 = manager.ui.mainCamera.transform
			local var_127_51 = 0.9

			if var_127_51 < arg_124_1.time_ and arg_124_1.time_ <= var_127_51 + arg_127_0 then
				local var_127_52 = arg_124_1.var_.effect烦烦烦
				local var_127_53
				local var_127_54 = var_127_50

				if not var_127_52 then
					var_127_52 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), var_127_54)
					var_127_52.name = "烦烦烦"
					arg_124_1.var_.effect烦烦烦 = var_127_52
				else
					var_127_52.transform:SetParent(var_127_54)
				end

				var_127_52.transform.localPosition = Vector3.New(0, 0, 0)
				var_127_52.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_127_55 = 1.7777777777777777
				local var_127_56 = Screen.width / Screen.height
				local var_127_57 = var_127_56 / var_127_55
				local var_127_58 = Mathf.Max(var_127_55 / var_127_56, 1)

				var_127_52.transform.localScale = Vector3.New(var_127_52.transform.localScale.x * var_127_57, var_127_52.transform.localScale.y * var_127_58, var_127_52.transform.localScale.z)
			end

			local var_127_59 = arg_124_1.bgs_.S0501.transform
			local var_127_60 = 0.934000001847744

			if var_127_60 < arg_124_1.time_ and arg_124_1.time_ <= var_127_60 + arg_127_0 then
				arg_124_1.var_.moveOldPosS0501 = var_127_59.localPosition
			end

			local var_127_61 = 0.665999998152256

			if var_127_60 <= arg_124_1.time_ and arg_124_1.time_ < var_127_60 + var_127_61 then
				local var_127_62 = (arg_124_1.time_ - var_127_60) / var_127_61
				local var_127_63 = Vector3.New(0, 1, 10)

				var_127_59.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPosS0501, var_127_63, var_127_62)
			end

			if arg_124_1.time_ >= var_127_60 + var_127_61 and arg_124_1.time_ < var_127_60 + var_127_61 + arg_127_0 then
				var_127_59.localPosition = Vector3.New(0, 1, 10)
			end

			local var_127_64 = manager.ui.mainCamera.transform
			local var_127_65 = 0.934000001847744

			if var_127_65 < arg_124_1.time_ and arg_124_1.time_ <= var_127_65 + arg_127_0 then
				local var_127_66 = arg_124_1.var_.effect321311112
				local var_127_67
				local var_127_68 = var_127_64

				if not var_127_66 then
					var_127_66 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), var_127_68)
					var_127_66.name = "321311112"
					arg_124_1.var_.effect321311112 = var_127_66
				else
					var_127_66.transform:SetParent(var_127_68)
				end

				var_127_66.transform.localPosition = Vector3.New(0, 0, -2.91)
				var_127_66.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_127_69 = 1.7777777777777777
				local var_127_70 = Screen.width / Screen.height
				local var_127_71 = var_127_70 / var_127_69
				local var_127_72 = Mathf.Max(var_127_69 / var_127_70, 1)

				var_127_66.transform.localScale = Vector3.New(var_127_66.transform.localScale.x * var_127_71, var_127_66.transform.localScale.y * var_127_72, var_127_66.transform.localScale.z)
			end

			local var_127_73 = 1.2
			local var_127_74 = 1

			if var_127_73 < arg_124_1.time_ and arg_124_1.time_ <= var_127_73 + arg_127_0 then
				local var_127_75 = "play"
				local var_127_76 = "effect"

				arg_124_1:AudioAction(var_127_75, var_127_76, "se_story_152", "se_story_152_amb_drone", "")
			end

			local var_127_77 = 0.2
			local var_127_78 = 1

			if var_127_77 < arg_124_1.time_ and arg_124_1.time_ <= var_127_77 + arg_127_0 then
				local var_127_79 = "stop"
				local var_127_80 = "effect"

				arg_124_1:AudioAction(var_127_79, var_127_80, "se_story_148", "se_story_148_amb_drone02", "")
			end

			if arg_124_1.frameCnt_ <= 1 then
				arg_124_1.dialog_:SetActive(false)
			end

			local var_127_81 = 2.9
			local var_127_82 = 1.7

			if var_127_81 < arg_124_1.time_ and arg_124_1.time_ <= var_127_81 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0

				arg_124_1.dialog_:SetActive(true)

				arg_124_1.dialogCg_.alpha = 0

				local var_127_83 = LeanTween.value(arg_124_1.dialog_, 0, 1, 0.3)

				var_127_83:setOnUpdate(LuaHelper.FloatAction(function(arg_128_0)
					arg_124_1.dialogCg_.alpha = arg_128_0
				end))
				var_127_83:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_124_1.dialog_)
					var_127_83:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_124_1.duration_ = arg_124_1.duration_ + 0.3

				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_84 = arg_124_1:GetWordFromCfg(305052029)
				local var_127_85 = arg_124_1:FormatText(var_127_84.content)

				arg_124_1.text_.text = var_127_85

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_86 = 68
				local var_127_87 = utf8.len(var_127_85)
				local var_127_88 = var_127_86 <= 0 and var_127_82 or var_127_82 * (var_127_87 / var_127_86)

				if var_127_88 > 0 and var_127_82 < var_127_88 then
					arg_124_1.talkMaxDuration = var_127_88
					var_127_81 = var_127_81 + 0.3

					if var_127_88 + var_127_81 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_88 + var_127_81
					end
				end

				arg_124_1.text_.text = var_127_85
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_89 = var_127_81 + 0.3
			local var_127_90 = math.max(var_127_82, arg_124_1.talkMaxDuration)

			if var_127_89 <= arg_124_1.time_ and arg_124_1.time_ < var_127_89 + var_127_90 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_89) / var_127_90

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_89 + var_127_90 and arg_124_1.time_ < var_127_89 + var_127_90 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "S0501",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.665999998152256,
				startTime = 0.934000001847744,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1.75, 3.05),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play305052030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 305052030
		arg_130_1.duration_ = 6.47

		local var_130_0 = {
			zh = 4.433,
			ja = 6.466
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play305052031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1011ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1011ui_story == nil then
				arg_130_1.var_.characterEffect1011ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect1011ui_story and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1011ui_story then
				arg_130_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_133_4 = 0
			local var_133_5 = 0.425

			if var_133_4 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_6 = arg_130_1:FormatText(StoryNameCfg[37].name)

				arg_130_1.leftNameTxt_.text = var_133_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_7 = arg_130_1:GetWordFromCfg(305052030)
				local var_133_8 = arg_130_1:FormatText(var_133_7.content)

				arg_130_1.text_.text = var_133_8

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_9 = 17
				local var_133_10 = utf8.len(var_133_8)
				local var_133_11 = var_133_9 <= 0 and var_133_5 or var_133_5 * (var_133_10 / var_133_9)

				if var_133_11 > 0 and var_133_5 < var_133_11 then
					arg_130_1.talkMaxDuration = var_133_11

					if var_133_11 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_11 + var_133_4
					end
				end

				arg_130_1.text_.text = var_133_8
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052030", "story_v_out_305052.awb") ~= 0 then
					local var_133_12 = manager.audio:GetVoiceLength("story_v_out_305052", "305052030", "story_v_out_305052.awb") / 1000

					if var_133_12 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_12 + var_133_4
					end

					if var_133_7.prefab_name ~= "" and arg_130_1.actors_[var_133_7.prefab_name] ~= nil then
						local var_133_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_7.prefab_name].transform, "story_v_out_305052", "305052030", "story_v_out_305052.awb")

						arg_130_1:RecordAudio("305052030", var_133_13)
						arg_130_1:RecordAudio("305052030", var_133_13)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_305052", "305052030", "story_v_out_305052.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_305052", "305052030", "story_v_out_305052.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_14 = math.max(var_133_5, arg_130_1.talkMaxDuration)

			if var_133_4 <= arg_130_1.time_ and arg_130_1.time_ < var_133_4 + var_133_14 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_4) / var_133_14

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_4 + var_133_14 and arg_130_1.time_ < var_133_4 + var_133_14 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play305052031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 305052031
		arg_134_1.duration_ = 4.2

		local var_134_0 = {
			zh = 4.2,
			ja = 1.333
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play305052032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1084ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1084ui_story == nil then
				arg_134_1.var_.characterEffect1084ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1084ui_story and not isNil(var_137_0) then
					arg_134_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1084ui_story then
				arg_134_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_137_4 = arg_134_1.actors_["1011ui_story"]
			local var_137_5 = 0

			if var_137_5 < arg_134_1.time_ and arg_134_1.time_ <= var_137_5 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect1011ui_story == nil then
				arg_134_1.var_.characterEffect1011ui_story = var_137_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_6 = 0.200000002980232

			if var_137_5 <= arg_134_1.time_ and arg_134_1.time_ < var_137_5 + var_137_6 and not isNil(var_137_4) then
				local var_137_7 = (arg_134_1.time_ - var_137_5) / var_137_6

				if arg_134_1.var_.characterEffect1011ui_story and not isNil(var_137_4) then
					local var_137_8 = Mathf.Lerp(0, 0.5, var_137_7)

					arg_134_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1011ui_story.fillRatio = var_137_8
				end
			end

			if arg_134_1.time_ >= var_137_5 + var_137_6 and arg_134_1.time_ < var_137_5 + var_137_6 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect1011ui_story then
				local var_137_9 = 0.5

				arg_134_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1011ui_story.fillRatio = var_137_9
			end

			local var_137_10 = 0
			local var_137_11 = 0.35

			if var_137_10 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_12 = arg_134_1:FormatText(StoryNameCfg[6].name)

				arg_134_1.leftNameTxt_.text = var_137_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_13 = arg_134_1:GetWordFromCfg(305052031)
				local var_137_14 = arg_134_1:FormatText(var_137_13.content)

				arg_134_1.text_.text = var_137_14

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_15 = 14
				local var_137_16 = utf8.len(var_137_14)
				local var_137_17 = var_137_15 <= 0 and var_137_11 or var_137_11 * (var_137_16 / var_137_15)

				if var_137_17 > 0 and var_137_11 < var_137_17 then
					arg_134_1.talkMaxDuration = var_137_17

					if var_137_17 + var_137_10 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_17 + var_137_10
					end
				end

				arg_134_1.text_.text = var_137_14
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052031", "story_v_out_305052.awb") ~= 0 then
					local var_137_18 = manager.audio:GetVoiceLength("story_v_out_305052", "305052031", "story_v_out_305052.awb") / 1000

					if var_137_18 + var_137_10 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_18 + var_137_10
					end

					if var_137_13.prefab_name ~= "" and arg_134_1.actors_[var_137_13.prefab_name] ~= nil then
						local var_137_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_13.prefab_name].transform, "story_v_out_305052", "305052031", "story_v_out_305052.awb")

						arg_134_1:RecordAudio("305052031", var_137_19)
						arg_134_1:RecordAudio("305052031", var_137_19)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_305052", "305052031", "story_v_out_305052.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_305052", "305052031", "story_v_out_305052.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_20 = math.max(var_137_11, arg_134_1.talkMaxDuration)

			if var_137_10 <= arg_134_1.time_ and arg_134_1.time_ < var_137_10 + var_137_20 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_10) / var_137_20

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_10 + var_137_20 and arg_134_1.time_ < var_137_10 + var_137_20 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play305052032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 305052032
		arg_138_1.duration_ = 8.6

		local var_138_0 = {
			zh = 5,
			ja = 8.6
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play305052033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1019ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1019ui_story == nil then
				arg_138_1.var_.characterEffect1019ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1019ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1019ui_story then
				arg_138_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_141_4 = arg_138_1.actors_["1084ui_story"]
			local var_141_5 = 0

			if var_141_5 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect1084ui_story == nil then
				arg_138_1.var_.characterEffect1084ui_story = var_141_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_6 = 0.200000002980232

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_6 and not isNil(var_141_4) then
				local var_141_7 = (arg_138_1.time_ - var_141_5) / var_141_6

				if arg_138_1.var_.characterEffect1084ui_story and not isNil(var_141_4) then
					local var_141_8 = Mathf.Lerp(0, 0.5, var_141_7)

					arg_138_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1084ui_story.fillRatio = var_141_8
				end
			end

			if arg_138_1.time_ >= var_141_5 + var_141_6 and arg_138_1.time_ < var_141_5 + var_141_6 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect1084ui_story then
				local var_141_9 = 0.5

				arg_138_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1084ui_story.fillRatio = var_141_9
			end

			local var_141_10 = 0
			local var_141_11 = 0.675

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_12 = arg_138_1:FormatText(StoryNameCfg[13].name)

				arg_138_1.leftNameTxt_.text = var_141_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_13 = arg_138_1:GetWordFromCfg(305052032)
				local var_141_14 = arg_138_1:FormatText(var_141_13.content)

				arg_138_1.text_.text = var_141_14

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_15 = 27
				local var_141_16 = utf8.len(var_141_14)
				local var_141_17 = var_141_15 <= 0 and var_141_11 or var_141_11 * (var_141_16 / var_141_15)

				if var_141_17 > 0 and var_141_11 < var_141_17 then
					arg_138_1.talkMaxDuration = var_141_17

					if var_141_17 + var_141_10 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_17 + var_141_10
					end
				end

				arg_138_1.text_.text = var_141_14
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052032", "story_v_out_305052.awb") ~= 0 then
					local var_141_18 = manager.audio:GetVoiceLength("story_v_out_305052", "305052032", "story_v_out_305052.awb") / 1000

					if var_141_18 + var_141_10 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_18 + var_141_10
					end

					if var_141_13.prefab_name ~= "" and arg_138_1.actors_[var_141_13.prefab_name] ~= nil then
						local var_141_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_13.prefab_name].transform, "story_v_out_305052", "305052032", "story_v_out_305052.awb")

						arg_138_1:RecordAudio("305052032", var_141_19)
						arg_138_1:RecordAudio("305052032", var_141_19)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_305052", "305052032", "story_v_out_305052.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_305052", "305052032", "story_v_out_305052.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_20 = math.max(var_141_11, arg_138_1.talkMaxDuration)

			if var_141_10 <= arg_138_1.time_ and arg_138_1.time_ < var_141_10 + var_141_20 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_10) / var_141_20

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_10 + var_141_20 and arg_138_1.time_ < var_141_10 + var_141_20 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play305052033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 305052033
		arg_142_1.duration_ = 8.13

		local var_142_0 = {
			zh = 5.333,
			ja = 8.133
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play305052034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.675

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[13].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_3 = arg_142_1:GetWordFromCfg(305052033)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 27
				local var_145_6 = utf8.len(var_145_4)
				local var_145_7 = var_145_5 <= 0 and var_145_1 or var_145_1 * (var_145_6 / var_145_5)

				if var_145_7 > 0 and var_145_1 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_4
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052033", "story_v_out_305052.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_305052", "305052033", "story_v_out_305052.awb") / 1000

					if var_145_8 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_0
					end

					if var_145_3.prefab_name ~= "" and arg_142_1.actors_[var_145_3.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_3.prefab_name].transform, "story_v_out_305052", "305052033", "story_v_out_305052.awb")

						arg_142_1:RecordAudio("305052033", var_145_9)
						arg_142_1:RecordAudio("305052033", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_305052", "305052033", "story_v_out_305052.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_305052", "305052033", "story_v_out_305052.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_10 and arg_142_1.time_ < var_145_0 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play305052034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 305052034
		arg_146_1.duration_ = 2.07

		local var_146_0 = {
			zh = 2.033,
			ja = 2.066
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play305052035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1019ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1019ui_story == nil then
				arg_146_1.var_.characterEffect1019ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1019ui_story and not isNil(var_149_0) then
					local var_149_4 = Mathf.Lerp(0, 0.5, var_149_3)

					arg_146_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1019ui_story.fillRatio = var_149_4
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1019ui_story then
				local var_149_5 = 0.5

				arg_146_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1019ui_story.fillRatio = var_149_5
			end

			local var_149_6 = 0
			local var_149_7 = 0.2

			if var_149_6 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_8 = arg_146_1:FormatText(StoryNameCfg[661].name)

				arg_146_1.leftNameTxt_.text = var_149_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_9 = arg_146_1:GetWordFromCfg(305052034)
				local var_149_10 = arg_146_1:FormatText(var_149_9.content)

				arg_146_1.text_.text = var_149_10

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_11 = 8
				local var_149_12 = utf8.len(var_149_10)
				local var_149_13 = var_149_11 <= 0 and var_149_7 or var_149_7 * (var_149_12 / var_149_11)

				if var_149_13 > 0 and var_149_7 < var_149_13 then
					arg_146_1.talkMaxDuration = var_149_13

					if var_149_13 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_13 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_10
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052034", "story_v_out_305052.awb") ~= 0 then
					local var_149_14 = manager.audio:GetVoiceLength("story_v_out_305052", "305052034", "story_v_out_305052.awb") / 1000

					if var_149_14 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_14 + var_149_6
					end

					if var_149_9.prefab_name ~= "" and arg_146_1.actors_[var_149_9.prefab_name] ~= nil then
						local var_149_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_9.prefab_name].transform, "story_v_out_305052", "305052034", "story_v_out_305052.awb")

						arg_146_1:RecordAudio("305052034", var_149_15)
						arg_146_1:RecordAudio("305052034", var_149_15)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_305052", "305052034", "story_v_out_305052.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_305052", "305052034", "story_v_out_305052.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_16 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_16 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_16

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_16 and arg_146_1.time_ < var_149_6 + var_149_16 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play305052035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 305052035
		arg_150_1.duration_ = 8.7

		local var_150_0 = {
			zh = 5.733,
			ja = 8.7
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play305052036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = "1036ui_story"

			if arg_150_1.actors_[var_153_0] == nil then
				local var_153_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_153_1) then
					local var_153_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_150_1.stage_.transform)

					var_153_2.name = var_153_0
					var_153_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_150_1.actors_[var_153_0] = var_153_2

					local var_153_3 = var_153_2:GetComponentInChildren(typeof(CharacterEffect))

					var_153_3.enabled = true

					local var_153_4 = GameObjectTools.GetOrAddComponent(var_153_2, typeof(DynamicBoneHelper))

					if var_153_4 then
						var_153_4:EnableDynamicBone(false)
					end

					arg_150_1:ShowWeapon(var_153_3.transform, false)

					arg_150_1.var_[var_153_0 .. "Animator"] = var_153_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_150_1.var_[var_153_0 .. "Animator"].applyRootMotion = true
					arg_150_1.var_[var_153_0 .. "LipSync"] = var_153_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_153_5 = arg_150_1.actors_["1036ui_story"]
			local var_153_6 = 0

			if var_153_6 < arg_150_1.time_ and arg_150_1.time_ <= var_153_6 + arg_153_0 and not isNil(var_153_5) and arg_150_1.var_.characterEffect1036ui_story == nil then
				arg_150_1.var_.characterEffect1036ui_story = var_153_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_7 = 0.200000002980232

			if var_153_6 <= arg_150_1.time_ and arg_150_1.time_ < var_153_6 + var_153_7 and not isNil(var_153_5) then
				local var_153_8 = (arg_150_1.time_ - var_153_6) / var_153_7

				if arg_150_1.var_.characterEffect1036ui_story and not isNil(var_153_5) then
					arg_150_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_6 + var_153_7 and arg_150_1.time_ < var_153_6 + var_153_7 + arg_153_0 and not isNil(var_153_5) and arg_150_1.var_.characterEffect1036ui_story then
				arg_150_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_153_9 = 0
			local var_153_10 = 0.375

			if var_153_9 < arg_150_1.time_ and arg_150_1.time_ <= var_153_9 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_11 = arg_150_1:FormatText(StoryNameCfg[5].name)

				arg_150_1.leftNameTxt_.text = var_153_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_12 = arg_150_1:GetWordFromCfg(305052035)
				local var_153_13 = arg_150_1:FormatText(var_153_12.content)

				arg_150_1.text_.text = var_153_13

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_14 = 15
				local var_153_15 = utf8.len(var_153_13)
				local var_153_16 = var_153_14 <= 0 and var_153_10 or var_153_10 * (var_153_15 / var_153_14)

				if var_153_16 > 0 and var_153_10 < var_153_16 then
					arg_150_1.talkMaxDuration = var_153_16

					if var_153_16 + var_153_9 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_16 + var_153_9
					end
				end

				arg_150_1.text_.text = var_153_13
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052035", "story_v_out_305052.awb") ~= 0 then
					local var_153_17 = manager.audio:GetVoiceLength("story_v_out_305052", "305052035", "story_v_out_305052.awb") / 1000

					if var_153_17 + var_153_9 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_17 + var_153_9
					end

					if var_153_12.prefab_name ~= "" and arg_150_1.actors_[var_153_12.prefab_name] ~= nil then
						local var_153_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_12.prefab_name].transform, "story_v_out_305052", "305052035", "story_v_out_305052.awb")

						arg_150_1:RecordAudio("305052035", var_153_18)
						arg_150_1:RecordAudio("305052035", var_153_18)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_305052", "305052035", "story_v_out_305052.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_305052", "305052035", "story_v_out_305052.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_19 = math.max(var_153_10, arg_150_1.talkMaxDuration)

			if var_153_9 <= arg_150_1.time_ and arg_150_1.time_ < var_153_9 + var_153_19 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_9) / var_153_19

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_9 + var_153_19 and arg_150_1.time_ < var_153_9 + var_153_19 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play305052036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 305052036
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play305052037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1036ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1036ui_story == nil then
				arg_154_1.var_.characterEffect1036ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect1036ui_story and not isNil(var_157_0) then
					local var_157_4 = Mathf.Lerp(0, 0.5, var_157_3)

					arg_154_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1036ui_story.fillRatio = var_157_4
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1036ui_story then
				local var_157_5 = 0.5

				arg_154_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1036ui_story.fillRatio = var_157_5
			end

			local var_157_6 = 0
			local var_157_7 = 1.075

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_8 = arg_154_1:GetWordFromCfg(305052036)
				local var_157_9 = arg_154_1:FormatText(var_157_8.content)

				arg_154_1.text_.text = var_157_9

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_10 = 43
				local var_157_11 = utf8.len(var_157_9)
				local var_157_12 = var_157_10 <= 0 and var_157_7 or var_157_7 * (var_157_11 / var_157_10)

				if var_157_12 > 0 and var_157_7 < var_157_12 then
					arg_154_1.talkMaxDuration = var_157_12

					if var_157_12 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_12 + var_157_6
					end
				end

				arg_154_1.text_.text = var_157_9
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_13 = math.max(var_157_7, arg_154_1.talkMaxDuration)

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_13 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_6) / var_157_13

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_6 + var_157_13 and arg_154_1.time_ < var_157_6 + var_157_13 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play305052037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 305052037
		arg_158_1.duration_ = 9.27

		local var_158_0 = {
			zh = 4.233,
			ja = 9.266
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play305052038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1036ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1036ui_story == nil then
				arg_158_1.var_.characterEffect1036ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect1036ui_story and not isNil(var_161_0) then
					arg_158_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1036ui_story then
				arg_158_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_161_4 = 0
			local var_161_5 = 0.525

			if var_161_4 < arg_158_1.time_ and arg_158_1.time_ <= var_161_4 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_6 = arg_158_1:FormatText(StoryNameCfg[5].name)

				arg_158_1.leftNameTxt_.text = var_161_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_7 = arg_158_1:GetWordFromCfg(305052037)
				local var_161_8 = arg_158_1:FormatText(var_161_7.content)

				arg_158_1.text_.text = var_161_8

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_9 = 21
				local var_161_10 = utf8.len(var_161_8)
				local var_161_11 = var_161_9 <= 0 and var_161_5 or var_161_5 * (var_161_10 / var_161_9)

				if var_161_11 > 0 and var_161_5 < var_161_11 then
					arg_158_1.talkMaxDuration = var_161_11

					if var_161_11 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_11 + var_161_4
					end
				end

				arg_158_1.text_.text = var_161_8
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052037", "story_v_out_305052.awb") ~= 0 then
					local var_161_12 = manager.audio:GetVoiceLength("story_v_out_305052", "305052037", "story_v_out_305052.awb") / 1000

					if var_161_12 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_12 + var_161_4
					end

					if var_161_7.prefab_name ~= "" and arg_158_1.actors_[var_161_7.prefab_name] ~= nil then
						local var_161_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_7.prefab_name].transform, "story_v_out_305052", "305052037", "story_v_out_305052.awb")

						arg_158_1:RecordAudio("305052037", var_161_13)
						arg_158_1:RecordAudio("305052037", var_161_13)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_305052", "305052037", "story_v_out_305052.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_305052", "305052037", "story_v_out_305052.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_14 = math.max(var_161_5, arg_158_1.talkMaxDuration)

			if var_161_4 <= arg_158_1.time_ and arg_158_1.time_ < var_161_4 + var_161_14 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_4) / var_161_14

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_4 + var_161_14 and arg_158_1.time_ < var_161_4 + var_161_14 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play305052038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 305052038
		arg_162_1.duration_ = 3.4

		local var_162_0 = {
			zh = 2.2,
			ja = 3.4
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play305052039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1019ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1019ui_story == nil then
				arg_162_1.var_.characterEffect1019ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect1019ui_story and not isNil(var_165_0) then
					arg_162_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1019ui_story then
				arg_162_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_165_4 = arg_162_1.actors_["1036ui_story"]
			local var_165_5 = 0

			if var_165_5 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 and not isNil(var_165_4) and arg_162_1.var_.characterEffect1036ui_story == nil then
				arg_162_1.var_.characterEffect1036ui_story = var_165_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_6 = 0.200000002980232

			if var_165_5 <= arg_162_1.time_ and arg_162_1.time_ < var_165_5 + var_165_6 and not isNil(var_165_4) then
				local var_165_7 = (arg_162_1.time_ - var_165_5) / var_165_6

				if arg_162_1.var_.characterEffect1036ui_story and not isNil(var_165_4) then
					local var_165_8 = Mathf.Lerp(0, 0.5, var_165_7)

					arg_162_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1036ui_story.fillRatio = var_165_8
				end
			end

			if arg_162_1.time_ >= var_165_5 + var_165_6 and arg_162_1.time_ < var_165_5 + var_165_6 + arg_165_0 and not isNil(var_165_4) and arg_162_1.var_.characterEffect1036ui_story then
				local var_165_9 = 0.5

				arg_162_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1036ui_story.fillRatio = var_165_9
			end

			local var_165_10 = 0
			local var_165_11 = 0.275

			if var_165_10 < arg_162_1.time_ and arg_162_1.time_ <= var_165_10 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_12 = arg_162_1:FormatText(StoryNameCfg[13].name)

				arg_162_1.leftNameTxt_.text = var_165_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_13 = arg_162_1:GetWordFromCfg(305052038)
				local var_165_14 = arg_162_1:FormatText(var_165_13.content)

				arg_162_1.text_.text = var_165_14

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_15 = 11
				local var_165_16 = utf8.len(var_165_14)
				local var_165_17 = var_165_15 <= 0 and var_165_11 or var_165_11 * (var_165_16 / var_165_15)

				if var_165_17 > 0 and var_165_11 < var_165_17 then
					arg_162_1.talkMaxDuration = var_165_17

					if var_165_17 + var_165_10 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_17 + var_165_10
					end
				end

				arg_162_1.text_.text = var_165_14
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052038", "story_v_out_305052.awb") ~= 0 then
					local var_165_18 = manager.audio:GetVoiceLength("story_v_out_305052", "305052038", "story_v_out_305052.awb") / 1000

					if var_165_18 + var_165_10 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_18 + var_165_10
					end

					if var_165_13.prefab_name ~= "" and arg_162_1.actors_[var_165_13.prefab_name] ~= nil then
						local var_165_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_13.prefab_name].transform, "story_v_out_305052", "305052038", "story_v_out_305052.awb")

						arg_162_1:RecordAudio("305052038", var_165_19)
						arg_162_1:RecordAudio("305052038", var_165_19)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_305052", "305052038", "story_v_out_305052.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_305052", "305052038", "story_v_out_305052.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_20 = math.max(var_165_11, arg_162_1.talkMaxDuration)

			if var_165_10 <= arg_162_1.time_ and arg_162_1.time_ < var_165_10 + var_165_20 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_10) / var_165_20

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_10 + var_165_20 and arg_162_1.time_ < var_165_10 + var_165_20 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play305052039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 305052039
		arg_166_1.duration_ = 7.27

		local var_166_0 = {
			zh = 4.2,
			ja = 7.266
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
			arg_166_1.auto_ = false
		end

		function arg_166_1.playNext_(arg_168_0)
			arg_166_1.onStoryFinished_()
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1036ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1036ui_story == nil then
				arg_166_1.var_.characterEffect1036ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.200000002980232

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect1036ui_story and not isNil(var_169_0) then
					arg_166_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1036ui_story then
				arg_166_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_169_4 = arg_166_1.actors_["1019ui_story"]
			local var_169_5 = 0

			if var_169_5 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.characterEffect1019ui_story == nil then
				arg_166_1.var_.characterEffect1019ui_story = var_169_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_6 = 0.200000002980232

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_6 and not isNil(var_169_4) then
				local var_169_7 = (arg_166_1.time_ - var_169_5) / var_169_6

				if arg_166_1.var_.characterEffect1019ui_story and not isNil(var_169_4) then
					local var_169_8 = Mathf.Lerp(0, 0.5, var_169_7)

					arg_166_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1019ui_story.fillRatio = var_169_8
				end
			end

			if arg_166_1.time_ >= var_169_5 + var_169_6 and arg_166_1.time_ < var_169_5 + var_169_6 + arg_169_0 and not isNil(var_169_4) and arg_166_1.var_.characterEffect1019ui_story then
				local var_169_9 = 0.5

				arg_166_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1019ui_story.fillRatio = var_169_9
			end

			local var_169_10 = 0
			local var_169_11 = 0.6

			if var_169_10 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_12 = arg_166_1:FormatText(StoryNameCfg[5].name)

				arg_166_1.leftNameTxt_.text = var_169_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_13 = arg_166_1:GetWordFromCfg(305052039)
				local var_169_14 = arg_166_1:FormatText(var_169_13.content)

				arg_166_1.text_.text = var_169_14

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_15 = 24
				local var_169_16 = utf8.len(var_169_14)
				local var_169_17 = var_169_15 <= 0 and var_169_11 or var_169_11 * (var_169_16 / var_169_15)

				if var_169_17 > 0 and var_169_11 < var_169_17 then
					arg_166_1.talkMaxDuration = var_169_17

					if var_169_17 + var_169_10 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_17 + var_169_10
					end
				end

				arg_166_1.text_.text = var_169_14
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305052", "305052039", "story_v_out_305052.awb") ~= 0 then
					local var_169_18 = manager.audio:GetVoiceLength("story_v_out_305052", "305052039", "story_v_out_305052.awb") / 1000

					if var_169_18 + var_169_10 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_18 + var_169_10
					end

					if var_169_13.prefab_name ~= "" and arg_166_1.actors_[var_169_13.prefab_name] ~= nil then
						local var_169_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_13.prefab_name].transform, "story_v_out_305052", "305052039", "story_v_out_305052.awb")

						arg_166_1:RecordAudio("305052039", var_169_19)
						arg_166_1:RecordAudio("305052039", var_169_19)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_305052", "305052039", "story_v_out_305052.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_305052", "305052039", "story_v_out_305052.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_20 = math.max(var_169_11, arg_166_1.talkMaxDuration)

			if var_169_10 <= arg_166_1.time_ and arg_166_1.time_ < var_169_10 + var_169_20 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_10) / var_169_20

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_10 + var_169_20 and arg_166_1.time_ < var_169_10 + var_169_20 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0409",
		"TextureConfig/Background/S0506a",
		"TextureConfig/Background/S0506",
		"TextureConfig/Background/B04f",
		"TextureConfig/Background/S0501"
	},
	voices = {
		"story_v_out_305052.awb"
	}
}
