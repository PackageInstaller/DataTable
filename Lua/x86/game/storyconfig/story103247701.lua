return {
	Play324771001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324771001
		arg_1_1.duration_ = 4.83

		local var_1_0 = {
			zh = 4.233,
			ja = 4.833
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
				arg_1_0:Play324771002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2007"

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
				local var_4_5 = arg_1_1.bgs_.ST2007

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
					if iter_4_0 ~= "ST2007" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

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

			local var_4_24 = "1037ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1037ui_story"]
			local var_4_30 = 2

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1037ui_story == nil then
				arg_1_1.var_.characterEffect1037ui_story = var_4_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_31 = 0.200000002980232

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 and not isNil(var_4_29) then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31

				if arg_1_1.var_.characterEffect1037ui_story and not isNil(var_4_29) then
					arg_1_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1037ui_story then
				arg_1_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_4_33 = 0.1
			local var_4_34 = 1

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "effect"

				arg_1_1:AudioAction(var_4_35, var_4_36, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_4_37 = 0
			local var_4_38 = 1

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				local var_4_39 = "play"
				local var_4_40 = "effect"

				arg_1_1:AudioAction(var_4_39, var_4_40, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_41 = 1
			local var_4_42 = 1

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_43 = "play"
				local var_4_44 = "music"

				arg_1_1:AudioAction(var_4_43, var_4_44, "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong.awb")

				local var_4_45 = ""
				local var_4_46 = manager.audio:GetAudioName("bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong")

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

			local var_4_47 = 2
			local var_4_48 = 0.25

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_50 = arg_1_1:FormatText(StoryNameCfg[1488].name)

				arg_1_1.leftNameTxt_.text = var_4_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_51 = arg_1_1:GetWordFromCfg(324771001)
				local var_4_52 = arg_1_1:FormatText(var_4_51.content)

				arg_1_1.text_.text = var_4_52

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_53 = 10
				local var_4_54 = utf8.len(var_4_52)
				local var_4_55 = var_4_53 <= 0 and var_4_48 or var_4_48 * (var_4_54 / var_4_53)

				if var_4_55 > 0 and var_4_48 < var_4_55 then
					arg_1_1.talkMaxDuration = var_4_55
					var_4_47 = var_4_47 + 0.3

					if var_4_55 + var_4_47 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_55 + var_4_47
					end
				end

				arg_1_1.text_.text = var_4_52
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771001", "story_v_out_324771.awb") ~= 0 then
					local var_4_56 = manager.audio:GetVoiceLength("story_v_out_324771", "324771001", "story_v_out_324771.awb") / 1000

					if var_4_56 + var_4_47 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_56 + var_4_47
					end

					if var_4_51.prefab_name ~= "" and arg_1_1.actors_[var_4_51.prefab_name] ~= nil then
						local var_4_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_51.prefab_name].transform, "story_v_out_324771", "324771001", "story_v_out_324771.awb")

						arg_1_1:RecordAudio("324771001", var_4_57)
						arg_1_1:RecordAudio("324771001", var_4_57)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324771", "324771001", "story_v_out_324771.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324771", "324771001", "story_v_out_324771.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_58 = var_4_47 + 0.3
			local var_4_59 = math.max(var_4_48, arg_1_1.talkMaxDuration)

			if var_4_58 <= arg_1_1.time_ and arg_1_1.time_ < var_4_58 + var_4_59 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_58) / var_4_59

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_58 + var_4_59 and arg_1_1.time_ < var_4_58 + var_4_59 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324771002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324771002
		arg_8_1.duration_ = 4.87

		local var_8_0 = {
			zh = 3.633,
			ja = 4.866
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
				arg_8_0:Play324771003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1036ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_8_1.stage_.transform)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentInChildren(typeof(CharacterEffect))

					var_11_3.enabled = true

					local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_2, typeof(DynamicBoneHelper))

					if var_11_4 then
						var_11_4:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_3.transform, false)

					arg_8_1.var_[var_11_0 .. "Animator"] = var_11_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_0 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_0 .. "LipSync"] = var_11_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_5 = arg_8_1.actors_["1036ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1036ui_story == nil then
				arg_8_1.var_.characterEffect1036ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.200000002980232

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1036ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1036ui_story then
				arg_8_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["1037ui_story"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1037ui_story == nil then
				arg_8_1.var_.characterEffect1037ui_story = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.200000002980232

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect1037ui_story and not isNil(var_11_9) then
					local var_11_13 = Mathf.Lerp(0, 0.5, var_11_12)

					arg_8_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1037ui_story.fillRatio = var_11_13
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1037ui_story then
				local var_11_14 = 0.5

				arg_8_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1037ui_story.fillRatio = var_11_14
			end

			local var_11_15 = 0
			local var_11_16 = 0.4

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_17 = arg_8_1:FormatText(StoryNameCfg[1487].name)

				arg_8_1.leftNameTxt_.text = var_11_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_18 = arg_8_1:GetWordFromCfg(324771002)
				local var_11_19 = arg_8_1:FormatText(var_11_18.content)

				arg_8_1.text_.text = var_11_19

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_20 = 16
				local var_11_21 = utf8.len(var_11_19)
				local var_11_22 = var_11_20 <= 0 and var_11_16 or var_11_16 * (var_11_21 / var_11_20)

				if var_11_22 > 0 and var_11_16 < var_11_22 then
					arg_8_1.talkMaxDuration = var_11_22

					if var_11_22 + var_11_15 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_22 + var_11_15
					end
				end

				arg_8_1.text_.text = var_11_19
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771002", "story_v_out_324771.awb") ~= 0 then
					local var_11_23 = manager.audio:GetVoiceLength("story_v_out_324771", "324771002", "story_v_out_324771.awb") / 1000

					if var_11_23 + var_11_15 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_23 + var_11_15
					end

					if var_11_18.prefab_name ~= "" and arg_8_1.actors_[var_11_18.prefab_name] ~= nil then
						local var_11_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_18.prefab_name].transform, "story_v_out_324771", "324771002", "story_v_out_324771.awb")

						arg_8_1:RecordAudio("324771002", var_11_24)
						arg_8_1:RecordAudio("324771002", var_11_24)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324771", "324771002", "story_v_out_324771.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324771", "324771002", "story_v_out_324771.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_25 = math.max(var_11_16, arg_8_1.talkMaxDuration)

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_25 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_15) / var_11_25

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_15 + var_11_25 and arg_8_1.time_ < var_11_15 + var_11_25 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play324771003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324771003
		arg_12_1.duration_ = 5.9

		local var_12_0 = {
			zh = 2.5,
			ja = 5.9
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
				arg_12_0:Play324771004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1053ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1053ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["1053ui_story"]
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1053ui_story == nil then
				arg_12_1.var_.characterEffect1053ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.200000002980232

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 and not isNil(var_15_5) then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7

				if arg_12_1.var_.characterEffect1053ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1053ui_story then
				arg_12_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_15_9 = arg_12_1.actors_["1036ui_story"]
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect1036ui_story == nil then
				arg_12_1.var_.characterEffect1036ui_story = var_15_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_11 = 0.200000002980232

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 and not isNil(var_15_9) then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11

				if arg_12_1.var_.characterEffect1036ui_story and not isNil(var_15_9) then
					local var_15_13 = Mathf.Lerp(0, 0.5, var_15_12)

					arg_12_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1036ui_story.fillRatio = var_15_13
				end
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect1036ui_story then
				local var_15_14 = 0.5

				arg_12_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1036ui_story.fillRatio = var_15_14
			end

			local var_15_15 = 0
			local var_15_16 = 0.275

			if var_15_15 < arg_12_1.time_ and arg_12_1.time_ <= var_15_15 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_17 = arg_12_1:FormatText(StoryNameCfg[472].name)

				arg_12_1.leftNameTxt_.text = var_15_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1053")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_18 = arg_12_1:GetWordFromCfg(324771003)
				local var_15_19 = arg_12_1:FormatText(var_15_18.content)

				arg_12_1.text_.text = var_15_19

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_20 = 11
				local var_15_21 = utf8.len(var_15_19)
				local var_15_22 = var_15_20 <= 0 and var_15_16 or var_15_16 * (var_15_21 / var_15_20)

				if var_15_22 > 0 and var_15_16 < var_15_22 then
					arg_12_1.talkMaxDuration = var_15_22

					if var_15_22 + var_15_15 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_22 + var_15_15
					end
				end

				arg_12_1.text_.text = var_15_19
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771003", "story_v_out_324771.awb") ~= 0 then
					local var_15_23 = manager.audio:GetVoiceLength("story_v_out_324771", "324771003", "story_v_out_324771.awb") / 1000

					if var_15_23 + var_15_15 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_23 + var_15_15
					end

					if var_15_18.prefab_name ~= "" and arg_12_1.actors_[var_15_18.prefab_name] ~= nil then
						local var_15_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_18.prefab_name].transform, "story_v_out_324771", "324771003", "story_v_out_324771.awb")

						arg_12_1:RecordAudio("324771003", var_15_24)
						arg_12_1:RecordAudio("324771003", var_15_24)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_324771", "324771003", "story_v_out_324771.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_324771", "324771003", "story_v_out_324771.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_25 = math.max(var_15_16, arg_12_1.talkMaxDuration)

			if var_15_15 <= arg_12_1.time_ and arg_12_1.time_ < var_15_15 + var_15_25 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_15) / var_15_25

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_15 + var_15_25 and arg_12_1.time_ < var_15_15 + var_15_25 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324771004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324771004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324771005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1053ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1053ui_story == nil then
				arg_16_1.var_.characterEffect1053ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1053ui_story and not isNil(var_19_0) then
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1053ui_story.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1053ui_story then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1053ui_story.fillRatio = var_19_5
			end

			local var_19_6 = 0
			local var_19_7 = 1.1

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_8 = arg_16_1:GetWordFromCfg(324771004)
				local var_19_9 = arg_16_1:FormatText(var_19_8.content)

				arg_16_1.text_.text = var_19_9

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_10 = 44
				local var_19_11 = utf8.len(var_19_9)
				local var_19_12 = var_19_10 <= 0 and var_19_7 or var_19_7 * (var_19_11 / var_19_10)

				if var_19_12 > 0 and var_19_7 < var_19_12 then
					arg_16_1.talkMaxDuration = var_19_12

					if var_19_12 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_9
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_13 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_13 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_13

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_13 and arg_16_1.time_ < var_19_6 + var_19_13 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play324771005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324771005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324771006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.95

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

				local var_23_2 = arg_20_1:GetWordFromCfg(324771005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 38
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
	Play324771006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324771006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324771007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.4

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[7].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(324771006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 16
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
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_8 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_8 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_8

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_8 and arg_24_1.time_ < var_27_0 + var_27_8 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play324771007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324771007
		arg_28_1.duration_ = 5.47

		local var_28_0 = {
			zh = 4,
			ja = 5.466
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
				arg_28_0:Play324771008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "6148ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_28_1.stage_.transform)

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

			local var_31_5 = arg_28_1.actors_["6148ui_story"].transform
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.var_.moveOldPos6148ui_story = var_31_5.localPosition

				local var_31_7 = GameObjectTools.GetOrAddComponent(var_31_5.gameObject, typeof(DynamicBoneHelper))

				if var_31_7 then
					var_31_7:EnableDynamicBone(false)
				end
			end

			local var_31_8 = 0.001

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_8 then
				local var_31_9 = (arg_28_1.time_ - var_31_6) / var_31_8
				local var_31_10 = Vector3.New(-0.7, -0.985, -6)

				var_31_5.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos6148ui_story, var_31_10, var_31_9)

				local var_31_11 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_11.x, var_31_11.y, var_31_11.z)

				local var_31_12 = var_31_5.localEulerAngles

				var_31_12.z = 0
				var_31_12.x = 0
				var_31_5.localEulerAngles = var_31_12
			end

			if arg_28_1.time_ >= var_31_6 + var_31_8 and arg_28_1.time_ < var_31_6 + var_31_8 + arg_31_0 then
				var_31_5.localPosition = Vector3.New(-0.7, -0.985, -6)

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

			local var_31_16 = arg_28_1.actors_["6148ui_story"]
			local var_31_17 = 0

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect6148ui_story == nil then
				arg_28_1.var_.characterEffect6148ui_story = var_31_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_18 = 0.200000002980232

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_18 and not isNil(var_31_16) then
				local var_31_19 = (arg_28_1.time_ - var_31_17) / var_31_18

				if arg_28_1.var_.characterEffect6148ui_story and not isNil(var_31_16) then
					arg_28_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_17 + var_31_18 and arg_28_1.time_ < var_31_17 + var_31_18 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect6148ui_story then
				arg_28_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_31_20 = 0

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_31_21 = 0

			if var_31_21 < arg_28_1.time_ and arg_28_1.time_ <= var_31_21 + arg_31_0 then
				arg_28_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_31_22 = 0
			local var_31_23 = 0.5

			if var_31_22 < arg_28_1.time_ and arg_28_1.time_ <= var_31_22 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_24 = arg_28_1:FormatText(StoryNameCfg[1488].name)

				arg_28_1.leftNameTxt_.text = var_31_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_25 = arg_28_1:GetWordFromCfg(324771007)
				local var_31_26 = arg_28_1:FormatText(var_31_25.content)

				arg_28_1.text_.text = var_31_26

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_27 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771007", "story_v_out_324771.awb") ~= 0 then
					local var_31_30 = manager.audio:GetVoiceLength("story_v_out_324771", "324771007", "story_v_out_324771.awb") / 1000

					if var_31_30 + var_31_22 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_30 + var_31_22
					end

					if var_31_25.prefab_name ~= "" and arg_28_1.actors_[var_31_25.prefab_name] ~= nil then
						local var_31_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_25.prefab_name].transform, "story_v_out_324771", "324771007", "story_v_out_324771.awb")

						arg_28_1:RecordAudio("324771007", var_31_31)
						arg_28_1:RecordAudio("324771007", var_31_31)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324771", "324771007", "story_v_out_324771.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324771", "324771007", "story_v_out_324771.awb")
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
				actorName = "6148ui_story",
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
	Play324771008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324771008
		arg_32_1.duration_ = 6.4

		local var_32_0 = {
			zh = 5.033,
			ja = 6.4
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
				arg_32_0:Play324771009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "1054ui_story"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_32_1.stage_.transform)

					var_35_2.name = var_35_0
					var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_0] = var_35_2

					local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

					var_35_3.enabled = true

					local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

					if var_35_4 then
						var_35_4:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_3.transform, false)

					arg_32_1.var_[var_35_0 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_0 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_0 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_5 = arg_32_1.actors_["1054ui_story"].transform
			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.var_.moveOldPos1054ui_story = var_35_5.localPosition

				local var_35_7 = GameObjectTools.GetOrAddComponent(var_35_5.gameObject, typeof(DynamicBoneHelper))

				if var_35_7 then
					var_35_7:EnableDynamicBone(false)
				end
			end

			local var_35_8 = 0.001

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_8 then
				local var_35_9 = (arg_32_1.time_ - var_35_6) / var_35_8
				local var_35_10 = Vector3.New(0.7, -0.985, -6)

				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1054ui_story, var_35_10, var_35_9)

				local var_35_11 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_11.x, var_35_11.y, var_35_11.z)

				local var_35_12 = var_35_5.localEulerAngles

				var_35_12.z = 0
				var_35_12.x = 0
				var_35_5.localEulerAngles = var_35_12
			end

			if arg_32_1.time_ >= var_35_6 + var_35_8 and arg_32_1.time_ < var_35_6 + var_35_8 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_35_13 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_13.x, var_35_13.y, var_35_13.z)

				local var_35_14 = var_35_5.localEulerAngles

				var_35_14.z = 0
				var_35_14.x = 0
				var_35_5.localEulerAngles = var_35_14

				local var_35_15 = GameObjectTools.GetOrAddComponent(var_35_5.gameObject, typeof(DynamicBoneHelper))

				if var_35_15 then
					var_35_15:EnableDynamicBone(true)
				end
			end

			local var_35_16 = arg_32_1.actors_["1054ui_story"]
			local var_35_17 = 0

			if var_35_17 < arg_32_1.time_ and arg_32_1.time_ <= var_35_17 + arg_35_0 and not isNil(var_35_16) and arg_32_1.var_.characterEffect1054ui_story == nil then
				arg_32_1.var_.characterEffect1054ui_story = var_35_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_18 = 0.200000002980232

			if var_35_17 <= arg_32_1.time_ and arg_32_1.time_ < var_35_17 + var_35_18 and not isNil(var_35_16) then
				local var_35_19 = (arg_32_1.time_ - var_35_17) / var_35_18

				if arg_32_1.var_.characterEffect1054ui_story and not isNil(var_35_16) then
					arg_32_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_17 + var_35_18 and arg_32_1.time_ < var_35_17 + var_35_18 + arg_35_0 and not isNil(var_35_16) and arg_32_1.var_.characterEffect1054ui_story then
				arg_32_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_35_20 = 0

			if var_35_20 < arg_32_1.time_ and arg_32_1.time_ <= var_35_20 + arg_35_0 then
				arg_32_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_35_21 = 0

			if var_35_21 < arg_32_1.time_ and arg_32_1.time_ <= var_35_21 + arg_35_0 then
				arg_32_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1", "EmotionTimelineAnimator")
			end

			local var_35_22 = arg_32_1.actors_["6148ui_story"]
			local var_35_23 = 0

			if var_35_23 < arg_32_1.time_ and arg_32_1.time_ <= var_35_23 + arg_35_0 and not isNil(var_35_22) and arg_32_1.var_.characterEffect6148ui_story == nil then
				arg_32_1.var_.characterEffect6148ui_story = var_35_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_24 = 0.200000002980232

			if var_35_23 <= arg_32_1.time_ and arg_32_1.time_ < var_35_23 + var_35_24 and not isNil(var_35_22) then
				local var_35_25 = (arg_32_1.time_ - var_35_23) / var_35_24

				if arg_32_1.var_.characterEffect6148ui_story and not isNil(var_35_22) then
					local var_35_26 = Mathf.Lerp(0, 0.5, var_35_25)

					arg_32_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_32_1.var_.characterEffect6148ui_story.fillRatio = var_35_26
				end
			end

			if arg_32_1.time_ >= var_35_23 + var_35_24 and arg_32_1.time_ < var_35_23 + var_35_24 + arg_35_0 and not isNil(var_35_22) and arg_32_1.var_.characterEffect6148ui_story then
				local var_35_27 = 0.5

				arg_32_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_32_1.var_.characterEffect6148ui_story.fillRatio = var_35_27
			end

			local var_35_28 = 0
			local var_35_29 = 0.5

			if var_35_28 < arg_32_1.time_ and arg_32_1.time_ <= var_35_28 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_30 = arg_32_1:FormatText(StoryNameCfg[1487].name)

				arg_32_1.leftNameTxt_.text = var_35_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_31 = arg_32_1:GetWordFromCfg(324771008)
				local var_35_32 = arg_32_1:FormatText(var_35_31.content)

				arg_32_1.text_.text = var_35_32

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_33 = 20
				local var_35_34 = utf8.len(var_35_32)
				local var_35_35 = var_35_33 <= 0 and var_35_29 or var_35_29 * (var_35_34 / var_35_33)

				if var_35_35 > 0 and var_35_29 < var_35_35 then
					arg_32_1.talkMaxDuration = var_35_35

					if var_35_35 + var_35_28 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_35 + var_35_28
					end
				end

				arg_32_1.text_.text = var_35_32
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771008", "story_v_out_324771.awb") ~= 0 then
					local var_35_36 = manager.audio:GetVoiceLength("story_v_out_324771", "324771008", "story_v_out_324771.awb") / 1000

					if var_35_36 + var_35_28 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_36 + var_35_28
					end

					if var_35_31.prefab_name ~= "" and arg_32_1.actors_[var_35_31.prefab_name] ~= nil then
						local var_35_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_31.prefab_name].transform, "story_v_out_324771", "324771008", "story_v_out_324771.awb")

						arg_32_1:RecordAudio("324771008", var_35_37)
						arg_32_1:RecordAudio("324771008", var_35_37)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324771", "324771008", "story_v_out_324771.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324771", "324771008", "story_v_out_324771.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_38 = math.max(var_35_29, arg_32_1.talkMaxDuration)

			if var_35_28 <= arg_32_1.time_ and arg_32_1.time_ < var_35_28 + var_35_38 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_28) / var_35_38

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_28 + var_35_38 and arg_32_1.time_ < var_35_28 + var_35_38 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play324771009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324771009
		arg_36_1.duration_ = 5.1

		local var_36_0 = {
			zh = 4,
			ja = 5.1
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
				arg_36_0:Play324771010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1053ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos1053ui_story = var_39_0.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_3 then
				local var_39_4 = (arg_36_1.time_ - var_39_1) / var_39_3
				local var_39_5 = Vector3.New(0, -1.08, -6)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1053ui_story, var_39_5, var_39_4)

				local var_39_6 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_6.x, var_39_6.y, var_39_6.z)

				local var_39_7 = var_39_0.localEulerAngles

				var_39_7.z = 0
				var_39_7.x = 0
				var_39_0.localEulerAngles = var_39_7
			end

			if arg_36_1.time_ >= var_39_1 + var_39_3 and arg_36_1.time_ < var_39_1 + var_39_3 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, -1.08, -6)

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

			local var_39_11 = arg_36_1.actors_["1054ui_story"].transform
			local var_39_12 = 0

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.var_.moveOldPos1054ui_story = var_39_11.localPosition

				local var_39_13 = GameObjectTools.GetOrAddComponent(var_39_11.gameObject, typeof(DynamicBoneHelper))

				if var_39_13 then
					var_39_13:EnableDynamicBone(false)
				end
			end

			local var_39_14 = 0.001

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_14 then
				local var_39_15 = (arg_36_1.time_ - var_39_12) / var_39_14
				local var_39_16 = Vector3.New(0, 100, 0)

				var_39_11.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1054ui_story, var_39_16, var_39_15)

				local var_39_17 = manager.ui.mainCamera.transform.position - var_39_11.position

				var_39_11.forward = Vector3.New(var_39_17.x, var_39_17.y, var_39_17.z)

				local var_39_18 = var_39_11.localEulerAngles

				var_39_18.z = 0
				var_39_18.x = 0
				var_39_11.localEulerAngles = var_39_18
			end

			if arg_36_1.time_ >= var_39_12 + var_39_14 and arg_36_1.time_ < var_39_12 + var_39_14 + arg_39_0 then
				var_39_11.localPosition = Vector3.New(0, 100, 0)

				local var_39_19 = manager.ui.mainCamera.transform.position - var_39_11.position

				var_39_11.forward = Vector3.New(var_39_19.x, var_39_19.y, var_39_19.z)

				local var_39_20 = var_39_11.localEulerAngles

				var_39_20.z = 0
				var_39_20.x = 0
				var_39_11.localEulerAngles = var_39_20

				local var_39_21 = GameObjectTools.GetOrAddComponent(var_39_11.gameObject, typeof(DynamicBoneHelper))

				if var_39_21 then
					var_39_21:EnableDynamicBone(true)
				end
			end

			local var_39_22 = arg_36_1.actors_["1053ui_story"]
			local var_39_23 = 0

			if var_39_23 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 and not isNil(var_39_22) and arg_36_1.var_.characterEffect1053ui_story == nil then
				arg_36_1.var_.characterEffect1053ui_story = var_39_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_24 = 0.200000002980232

			if var_39_23 <= arg_36_1.time_ and arg_36_1.time_ < var_39_23 + var_39_24 and not isNil(var_39_22) then
				local var_39_25 = (arg_36_1.time_ - var_39_23) / var_39_24

				if arg_36_1.var_.characterEffect1053ui_story and not isNil(var_39_22) then
					arg_36_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_23 + var_39_24 and arg_36_1.time_ < var_39_23 + var_39_24 + arg_39_0 and not isNil(var_39_22) and arg_36_1.var_.characterEffect1053ui_story then
				arg_36_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_39_26 = 0

			if var_39_26 < arg_36_1.time_ and arg_36_1.time_ <= var_39_26 + arg_39_0 then
				arg_36_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			local var_39_27 = 0

			if var_39_27 < arg_36_1.time_ and arg_36_1.time_ <= var_39_27 + arg_39_0 then
				arg_36_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_39_28 = arg_36_1.actors_["1054ui_story"]
			local var_39_29 = 0

			if var_39_29 < arg_36_1.time_ and arg_36_1.time_ <= var_39_29 + arg_39_0 and not isNil(var_39_28) and arg_36_1.var_.characterEffect1054ui_story == nil then
				arg_36_1.var_.characterEffect1054ui_story = var_39_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_30 = 0.200000002980232

			if var_39_29 <= arg_36_1.time_ and arg_36_1.time_ < var_39_29 + var_39_30 and not isNil(var_39_28) then
				local var_39_31 = (arg_36_1.time_ - var_39_29) / var_39_30

				if arg_36_1.var_.characterEffect1054ui_story and not isNil(var_39_28) then
					arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_29 + var_39_30 and arg_36_1.time_ < var_39_29 + var_39_30 + arg_39_0 and not isNil(var_39_28) and arg_36_1.var_.characterEffect1054ui_story then
				arg_36_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_39_32 = arg_36_1.actors_["6148ui_story"].transform
			local var_39_33 = 0

			if var_39_33 < arg_36_1.time_ and arg_36_1.time_ <= var_39_33 + arg_39_0 then
				arg_36_1.var_.moveOldPos6148ui_story = var_39_32.localPosition

				local var_39_34 = GameObjectTools.GetOrAddComponent(var_39_32.gameObject, typeof(DynamicBoneHelper))

				if var_39_34 then
					var_39_34:EnableDynamicBone(false)
				end
			end

			local var_39_35 = 0.001

			if var_39_33 <= arg_36_1.time_ and arg_36_1.time_ < var_39_33 + var_39_35 then
				local var_39_36 = (arg_36_1.time_ - var_39_33) / var_39_35
				local var_39_37 = Vector3.New(0, 100, 0)

				var_39_32.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos6148ui_story, var_39_37, var_39_36)

				local var_39_38 = manager.ui.mainCamera.transform.position - var_39_32.position

				var_39_32.forward = Vector3.New(var_39_38.x, var_39_38.y, var_39_38.z)

				local var_39_39 = var_39_32.localEulerAngles

				var_39_39.z = 0
				var_39_39.x = 0
				var_39_32.localEulerAngles = var_39_39
			end

			if arg_36_1.time_ >= var_39_33 + var_39_35 and arg_36_1.time_ < var_39_33 + var_39_35 + arg_39_0 then
				var_39_32.localPosition = Vector3.New(0, 100, 0)

				local var_39_40 = manager.ui.mainCamera.transform.position - var_39_32.position

				var_39_32.forward = Vector3.New(var_39_40.x, var_39_40.y, var_39_40.z)

				local var_39_41 = var_39_32.localEulerAngles

				var_39_41.z = 0
				var_39_41.x = 0
				var_39_32.localEulerAngles = var_39_41

				local var_39_42 = GameObjectTools.GetOrAddComponent(var_39_32.gameObject, typeof(DynamicBoneHelper))

				if var_39_42 then
					var_39_42:EnableDynamicBone(true)
				end
			end

			local var_39_43 = 0
			local var_39_44 = 0.4

			if var_39_43 < arg_36_1.time_ and arg_36_1.time_ <= var_39_43 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_45 = arg_36_1:FormatText(StoryNameCfg[472].name)

				arg_36_1.leftNameTxt_.text = var_39_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_46 = arg_36_1:GetWordFromCfg(324771009)
				local var_39_47 = arg_36_1:FormatText(var_39_46.content)

				arg_36_1.text_.text = var_39_47

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_48 = 16
				local var_39_49 = utf8.len(var_39_47)
				local var_39_50 = var_39_48 <= 0 and var_39_44 or var_39_44 * (var_39_49 / var_39_48)

				if var_39_50 > 0 and var_39_44 < var_39_50 then
					arg_36_1.talkMaxDuration = var_39_50

					if var_39_50 + var_39_43 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_50 + var_39_43
					end
				end

				arg_36_1.text_.text = var_39_47
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771009", "story_v_out_324771.awb") ~= 0 then
					local var_39_51 = manager.audio:GetVoiceLength("story_v_out_324771", "324771009", "story_v_out_324771.awb") / 1000

					if var_39_51 + var_39_43 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_51 + var_39_43
					end

					if var_39_46.prefab_name ~= "" and arg_36_1.actors_[var_39_46.prefab_name] ~= nil then
						local var_39_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_46.prefab_name].transform, "story_v_out_324771", "324771009", "story_v_out_324771.awb")

						arg_36_1:RecordAudio("324771009", var_39_52)
						arg_36_1:RecordAudio("324771009", var_39_52)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324771", "324771009", "story_v_out_324771.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324771", "324771009", "story_v_out_324771.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_53 = math.max(var_39_44, arg_36_1.talkMaxDuration)

			if var_39_43 <= arg_36_1.time_ and arg_36_1.time_ < var_39_43 + var_39_53 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_43) / var_39_53

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_43 + var_39_53 and arg_36_1.time_ < var_39_43 + var_39_53 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play324771010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324771010
		arg_40_1.duration_ = 3.73

		local var_40_0 = {
			zh = 2.266,
			ja = 3.733
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
				arg_40_0:Play324771011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1037ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1037ui_story == nil then
				arg_40_1.var_.characterEffect1037ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1037ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1037ui_story then
				arg_40_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["1053ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1053ui_story == nil then
				arg_40_1.var_.characterEffect1053ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.200000002980232

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect1053ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1053ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1053ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1053ui_story.fillRatio = var_43_9
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_43_11 = arg_40_1.actors_["6148ui_story"]
			local var_43_12 = 0

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 and not isNil(var_43_11) and arg_40_1.var_.characterEffect6148ui_story == nil then
				arg_40_1.var_.characterEffect6148ui_story = var_43_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_13 = 0.200000002980232

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_13 and not isNil(var_43_11) then
				local var_43_14 = (arg_40_1.time_ - var_43_12) / var_43_13

				if arg_40_1.var_.characterEffect6148ui_story and not isNil(var_43_11) then
					arg_40_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_12 + var_43_13 and arg_40_1.time_ < var_43_12 + var_43_13 + arg_43_0 and not isNil(var_43_11) and arg_40_1.var_.characterEffect6148ui_story then
				arg_40_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_43_15 = arg_40_1.actors_["6148ui_story"].transform
			local var_43_16 = 0

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.var_.moveOldPos6148ui_story = var_43_15.localPosition

				local var_43_17 = GameObjectTools.GetOrAddComponent(var_43_15.gameObject, typeof(DynamicBoneHelper))

				if var_43_17 then
					var_43_17:EnableDynamicBone(false)
				end
			end

			local var_43_18 = 0.001

			if var_43_16 <= arg_40_1.time_ and arg_40_1.time_ < var_43_16 + var_43_18 then
				local var_43_19 = (arg_40_1.time_ - var_43_16) / var_43_18
				local var_43_20 = Vector3.New(-0.7, -0.985, -6)

				var_43_15.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos6148ui_story, var_43_20, var_43_19)

				local var_43_21 = manager.ui.mainCamera.transform.position - var_43_15.position

				var_43_15.forward = Vector3.New(var_43_21.x, var_43_21.y, var_43_21.z)

				local var_43_22 = var_43_15.localEulerAngles

				var_43_22.z = 0
				var_43_22.x = 0
				var_43_15.localEulerAngles = var_43_22
			end

			if arg_40_1.time_ >= var_43_16 + var_43_18 and arg_40_1.time_ < var_43_16 + var_43_18 + arg_43_0 then
				var_43_15.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_43_23 = manager.ui.mainCamera.transform.position - var_43_15.position

				var_43_15.forward = Vector3.New(var_43_23.x, var_43_23.y, var_43_23.z)

				local var_43_24 = var_43_15.localEulerAngles

				var_43_24.z = 0
				var_43_24.x = 0
				var_43_15.localEulerAngles = var_43_24

				local var_43_25 = GameObjectTools.GetOrAddComponent(var_43_15.gameObject, typeof(DynamicBoneHelper))

				if var_43_25 then
					var_43_25:EnableDynamicBone(true)
				end
			end

			local var_43_26 = arg_40_1.actors_["1053ui_story"].transform
			local var_43_27 = 0

			if var_43_27 < arg_40_1.time_ and arg_40_1.time_ <= var_43_27 + arg_43_0 then
				arg_40_1.var_.moveOldPos1053ui_story = var_43_26.localPosition

				local var_43_28 = GameObjectTools.GetOrAddComponent(var_43_26.gameObject, typeof(DynamicBoneHelper))

				if var_43_28 then
					var_43_28:EnableDynamicBone(false)
				end
			end

			local var_43_29 = 0.001

			if var_43_27 <= arg_40_1.time_ and arg_40_1.time_ < var_43_27 + var_43_29 then
				local var_43_30 = (arg_40_1.time_ - var_43_27) / var_43_29
				local var_43_31 = Vector3.New(0.7, -1.08, -6)

				var_43_26.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1053ui_story, var_43_31, var_43_30)

				local var_43_32 = manager.ui.mainCamera.transform.position - var_43_26.position

				var_43_26.forward = Vector3.New(var_43_32.x, var_43_32.y, var_43_32.z)

				local var_43_33 = var_43_26.localEulerAngles

				var_43_33.z = 0
				var_43_33.x = 0
				var_43_26.localEulerAngles = var_43_33
			end

			if arg_40_1.time_ >= var_43_27 + var_43_29 and arg_40_1.time_ < var_43_27 + var_43_29 + arg_43_0 then
				var_43_26.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_43_34 = manager.ui.mainCamera.transform.position - var_43_26.position

				var_43_26.forward = Vector3.New(var_43_34.x, var_43_34.y, var_43_34.z)

				local var_43_35 = var_43_26.localEulerAngles

				var_43_35.z = 0
				var_43_35.x = 0
				var_43_26.localEulerAngles = var_43_35

				local var_43_36 = GameObjectTools.GetOrAddComponent(var_43_26.gameObject, typeof(DynamicBoneHelper))

				if var_43_36 then
					var_43_36:EnableDynamicBone(true)
				end
			end

			local var_43_37 = 0
			local var_43_38 = 0.325

			if var_43_37 < arg_40_1.time_ and arg_40_1.time_ <= var_43_37 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_39 = arg_40_1:FormatText(StoryNameCfg[1488].name)

				arg_40_1.leftNameTxt_.text = var_43_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_40 = arg_40_1:GetWordFromCfg(324771010)
				local var_43_41 = arg_40_1:FormatText(var_43_40.content)

				arg_40_1.text_.text = var_43_41

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_42 = 13
				local var_43_43 = utf8.len(var_43_41)
				local var_43_44 = var_43_42 <= 0 and var_43_38 or var_43_38 * (var_43_43 / var_43_42)

				if var_43_44 > 0 and var_43_38 < var_43_44 then
					arg_40_1.talkMaxDuration = var_43_44

					if var_43_44 + var_43_37 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_44 + var_43_37
					end
				end

				arg_40_1.text_.text = var_43_41
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771010", "story_v_out_324771.awb") ~= 0 then
					local var_43_45 = manager.audio:GetVoiceLength("story_v_out_324771", "324771010", "story_v_out_324771.awb") / 1000

					if var_43_45 + var_43_37 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_45 + var_43_37
					end

					if var_43_40.prefab_name ~= "" and arg_40_1.actors_[var_43_40.prefab_name] ~= nil then
						local var_43_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_40.prefab_name].transform, "story_v_out_324771", "324771010", "story_v_out_324771.awb")

						arg_40_1:RecordAudio("324771010", var_43_46)
						arg_40_1:RecordAudio("324771010", var_43_46)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_324771", "324771010", "story_v_out_324771.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_324771", "324771010", "story_v_out_324771.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_47 = math.max(var_43_38, arg_40_1.talkMaxDuration)

			if var_43_37 <= arg_40_1.time_ and arg_40_1.time_ < var_43_37 + var_43_47 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_37) / var_43_47

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_37 + var_43_47 and arg_40_1.time_ < var_43_37 + var_43_47 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play324771011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324771011
		arg_44_1.duration_ = 4.33

		local var_44_0 = {
			zh = 1.999999999999,
			ja = 4.333
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
				arg_44_0:Play324771012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1053ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1053ui_story == nil then
				arg_44_1.var_.characterEffect1053ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1053ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1053ui_story then
				arg_44_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_47_4 = 0

			if var_47_4 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action4_1")
			end

			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_47_6 = arg_44_1.actors_["6148ui_story"]
			local var_47_7 = 0

			if var_47_7 < arg_44_1.time_ and arg_44_1.time_ <= var_47_7 + arg_47_0 and not isNil(var_47_6) and arg_44_1.var_.characterEffect6148ui_story == nil then
				arg_44_1.var_.characterEffect6148ui_story = var_47_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_8 = 0.200000002980232

			if var_47_7 <= arg_44_1.time_ and arg_44_1.time_ < var_47_7 + var_47_8 and not isNil(var_47_6) then
				local var_47_9 = (arg_44_1.time_ - var_47_7) / var_47_8

				if arg_44_1.var_.characterEffect6148ui_story and not isNil(var_47_6) then
					local var_47_10 = Mathf.Lerp(0, 0.5, var_47_9)

					arg_44_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_44_1.var_.characterEffect6148ui_story.fillRatio = var_47_10
				end
			end

			if arg_44_1.time_ >= var_47_7 + var_47_8 and arg_44_1.time_ < var_47_7 + var_47_8 + arg_47_0 and not isNil(var_47_6) and arg_44_1.var_.characterEffect6148ui_story then
				local var_47_11 = 0.5

				arg_44_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_44_1.var_.characterEffect6148ui_story.fillRatio = var_47_11
			end

			local var_47_12 = 0
			local var_47_13 = 0.25

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_14 = arg_44_1:FormatText(StoryNameCfg[472].name)

				arg_44_1.leftNameTxt_.text = var_47_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_15 = arg_44_1:GetWordFromCfg(324771011)
				local var_47_16 = arg_44_1:FormatText(var_47_15.content)

				arg_44_1.text_.text = var_47_16

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 10
				local var_47_18 = utf8.len(var_47_16)
				local var_47_19 = var_47_17 <= 0 and var_47_13 or var_47_13 * (var_47_18 / var_47_17)

				if var_47_19 > 0 and var_47_13 < var_47_19 then
					arg_44_1.talkMaxDuration = var_47_19

					if var_47_19 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_19 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_16
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771011", "story_v_out_324771.awb") ~= 0 then
					local var_47_20 = manager.audio:GetVoiceLength("story_v_out_324771", "324771011", "story_v_out_324771.awb") / 1000

					if var_47_20 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_20 + var_47_12
					end

					if var_47_15.prefab_name ~= "" and arg_44_1.actors_[var_47_15.prefab_name] ~= nil then
						local var_47_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_15.prefab_name].transform, "story_v_out_324771", "324771011", "story_v_out_324771.awb")

						arg_44_1:RecordAudio("324771011", var_47_21)
						arg_44_1:RecordAudio("324771011", var_47_21)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_324771", "324771011", "story_v_out_324771.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_324771", "324771011", "story_v_out_324771.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_22 and arg_44_1.time_ < var_47_12 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play324771012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324771012
		arg_48_1.duration_ = 6.2

		local var_48_0 = {
			zh = 5.166,
			ja = 6.2
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
				arg_48_0:Play324771013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1054ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1054ui_story == nil then
				arg_48_1.var_.characterEffect1054ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1054ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1054ui_story then
				arg_48_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1053ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1053ui_story == nil then
				arg_48_1.var_.characterEffect1053ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.200000002980232

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1053ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1053ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1053ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1053ui_story.fillRatio = var_51_9
			end

			local var_51_10 = arg_48_1.actors_["1037ui_story"].transform
			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1.var_.moveOldPos1037ui_story = var_51_10.localPosition
			end

			local var_51_12 = 0.001

			if var_51_11 <= arg_48_1.time_ and arg_48_1.time_ < var_51_11 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_11) / var_51_12
				local var_51_14 = Vector3.New(0, 100, 0)

				var_51_10.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1037ui_story, var_51_14, var_51_13)

				local var_51_15 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_15.x, var_51_15.y, var_51_15.z)

				local var_51_16 = var_51_10.localEulerAngles

				var_51_16.z = 0
				var_51_16.x = 0
				var_51_10.localEulerAngles = var_51_16
			end

			if arg_48_1.time_ >= var_51_11 + var_51_12 and arg_48_1.time_ < var_51_11 + var_51_12 + arg_51_0 then
				var_51_10.localPosition = Vector3.New(0, 100, 0)

				local var_51_17 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_17.x, var_51_17.y, var_51_17.z)

				local var_51_18 = var_51_10.localEulerAngles

				var_51_18.z = 0
				var_51_18.x = 0
				var_51_10.localEulerAngles = var_51_18
			end

			local var_51_19 = arg_48_1.actors_["1054ui_story"].transform
			local var_51_20 = 0

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1.var_.moveOldPos1054ui_story = var_51_19.localPosition

				local var_51_21 = GameObjectTools.GetOrAddComponent(var_51_19.gameObject, typeof(DynamicBoneHelper))

				if var_51_21 then
					var_51_21:EnableDynamicBone(false)
				end
			end

			local var_51_22 = 0.001

			if var_51_20 <= arg_48_1.time_ and arg_48_1.time_ < var_51_20 + var_51_22 then
				local var_51_23 = (arg_48_1.time_ - var_51_20) / var_51_22
				local var_51_24 = Vector3.New(-0.7, -0.985, -6)

				var_51_19.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1054ui_story, var_51_24, var_51_23)

				local var_51_25 = manager.ui.mainCamera.transform.position - var_51_19.position

				var_51_19.forward = Vector3.New(var_51_25.x, var_51_25.y, var_51_25.z)

				local var_51_26 = var_51_19.localEulerAngles

				var_51_26.z = 0
				var_51_26.x = 0
				var_51_19.localEulerAngles = var_51_26
			end

			if arg_48_1.time_ >= var_51_20 + var_51_22 and arg_48_1.time_ < var_51_20 + var_51_22 + arg_51_0 then
				var_51_19.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_51_27 = manager.ui.mainCamera.transform.position - var_51_19.position

				var_51_19.forward = Vector3.New(var_51_27.x, var_51_27.y, var_51_27.z)

				local var_51_28 = var_51_19.localEulerAngles

				var_51_28.z = 0
				var_51_28.x = 0
				var_51_19.localEulerAngles = var_51_28

				local var_51_29 = GameObjectTools.GetOrAddComponent(var_51_19.gameObject, typeof(DynamicBoneHelper))

				if var_51_29 then
					var_51_29:EnableDynamicBone(true)
				end
			end

			local var_51_30 = arg_48_1.actors_["6148ui_story"].transform
			local var_51_31 = 0

			if var_51_31 < arg_48_1.time_ and arg_48_1.time_ <= var_51_31 + arg_51_0 then
				arg_48_1.var_.moveOldPos6148ui_story = var_51_30.localPosition

				local var_51_32 = GameObjectTools.GetOrAddComponent(var_51_30.gameObject, typeof(DynamicBoneHelper))

				if var_51_32 then
					var_51_32:EnableDynamicBone(false)
				end
			end

			local var_51_33 = 0.001

			if var_51_31 <= arg_48_1.time_ and arg_48_1.time_ < var_51_31 + var_51_33 then
				local var_51_34 = (arg_48_1.time_ - var_51_31) / var_51_33
				local var_51_35 = Vector3.New(0, 100, 0)

				var_51_30.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos6148ui_story, var_51_35, var_51_34)

				local var_51_36 = manager.ui.mainCamera.transform.position - var_51_30.position

				var_51_30.forward = Vector3.New(var_51_36.x, var_51_36.y, var_51_36.z)

				local var_51_37 = var_51_30.localEulerAngles

				var_51_37.z = 0
				var_51_37.x = 0
				var_51_30.localEulerAngles = var_51_37
			end

			if arg_48_1.time_ >= var_51_31 + var_51_33 and arg_48_1.time_ < var_51_31 + var_51_33 + arg_51_0 then
				var_51_30.localPosition = Vector3.New(0, 100, 0)

				local var_51_38 = manager.ui.mainCamera.transform.position - var_51_30.position

				var_51_30.forward = Vector3.New(var_51_38.x, var_51_38.y, var_51_38.z)

				local var_51_39 = var_51_30.localEulerAngles

				var_51_39.z = 0
				var_51_39.x = 0
				var_51_30.localEulerAngles = var_51_39

				local var_51_40 = GameObjectTools.GetOrAddComponent(var_51_30.gameObject, typeof(DynamicBoneHelper))

				if var_51_40 then
					var_51_40:EnableDynamicBone(true)
				end
			end

			local var_51_41 = 0

			if var_51_41 < arg_48_1.time_ and arg_48_1.time_ <= var_51_41 + arg_51_0 then
				arg_48_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action7_1")
			end

			local var_51_42 = 0
			local var_51_43 = 0.525

			if var_51_42 < arg_48_1.time_ and arg_48_1.time_ <= var_51_42 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_44 = arg_48_1:FormatText(StoryNameCfg[1487].name)

				arg_48_1.leftNameTxt_.text = var_51_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_45 = arg_48_1:GetWordFromCfg(324771012)
				local var_51_46 = arg_48_1:FormatText(var_51_45.content)

				arg_48_1.text_.text = var_51_46

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_47 = 21
				local var_51_48 = utf8.len(var_51_46)
				local var_51_49 = var_51_47 <= 0 and var_51_43 or var_51_43 * (var_51_48 / var_51_47)

				if var_51_49 > 0 and var_51_43 < var_51_49 then
					arg_48_1.talkMaxDuration = var_51_49

					if var_51_49 + var_51_42 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_49 + var_51_42
					end
				end

				arg_48_1.text_.text = var_51_46
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771012", "story_v_out_324771.awb") ~= 0 then
					local var_51_50 = manager.audio:GetVoiceLength("story_v_out_324771", "324771012", "story_v_out_324771.awb") / 1000

					if var_51_50 + var_51_42 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_50 + var_51_42
					end

					if var_51_45.prefab_name ~= "" and arg_48_1.actors_[var_51_45.prefab_name] ~= nil then
						local var_51_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_45.prefab_name].transform, "story_v_out_324771", "324771012", "story_v_out_324771.awb")

						arg_48_1:RecordAudio("324771012", var_51_51)
						arg_48_1:RecordAudio("324771012", var_51_51)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324771", "324771012", "story_v_out_324771.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324771", "324771012", "story_v_out_324771.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_52 = math.max(var_51_43, arg_48_1.talkMaxDuration)

			if var_51_42 <= arg_48_1.time_ and arg_48_1.time_ < var_51_42 + var_51_52 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_42) / var_51_52

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_42 + var_51_52 and arg_48_1.time_ < var_51_42 + var_51_52 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play324771013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324771013
		arg_52_1.duration_ = 12.5

		local var_52_0 = {
			zh = 9.3,
			ja = 12.5
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play324771014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1053ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1053ui_story == nil then
				arg_52_1.var_.characterEffect1053ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1053ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1053ui_story then
				arg_52_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["1054ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1054ui_story == nil then
				arg_52_1.var_.characterEffect1054ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.200000002980232

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect1054ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1054ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1054ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1054ui_story.fillRatio = var_55_9
			end

			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action4_2")
			end

			local var_55_11 = 0

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_55_12 = 0
			local var_55_13 = 1

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_14 = arg_52_1:FormatText(StoryNameCfg[472].name)

				arg_52_1.leftNameTxt_.text = var_55_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_15 = arg_52_1:GetWordFromCfg(324771013)
				local var_55_16 = arg_52_1:FormatText(var_55_15.content)

				arg_52_1.text_.text = var_55_16

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_17 = 40
				local var_55_18 = utf8.len(var_55_16)
				local var_55_19 = var_55_17 <= 0 and var_55_13 or var_55_13 * (var_55_18 / var_55_17)

				if var_55_19 > 0 and var_55_13 < var_55_19 then
					arg_52_1.talkMaxDuration = var_55_19

					if var_55_19 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_19 + var_55_12
					end
				end

				arg_52_1.text_.text = var_55_16
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771013", "story_v_out_324771.awb") ~= 0 then
					local var_55_20 = manager.audio:GetVoiceLength("story_v_out_324771", "324771013", "story_v_out_324771.awb") / 1000

					if var_55_20 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_20 + var_55_12
					end

					if var_55_15.prefab_name ~= "" and arg_52_1.actors_[var_55_15.prefab_name] ~= nil then
						local var_55_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_15.prefab_name].transform, "story_v_out_324771", "324771013", "story_v_out_324771.awb")

						arg_52_1:RecordAudio("324771013", var_55_21)
						arg_52_1:RecordAudio("324771013", var_55_21)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_324771", "324771013", "story_v_out_324771.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_324771", "324771013", "story_v_out_324771.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_22 = math.max(var_55_13, arg_52_1.talkMaxDuration)

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_22 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_12) / var_55_22

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_12 + var_55_22 and arg_52_1.time_ < var_55_12 + var_55_22 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324771014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324771014
		arg_56_1.duration_ = 6.7

		local var_56_0 = {
			zh = 4.133,
			ja = 6.7
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play324771015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_1")
			end

			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_59_2 = 0
			local var_59_3 = 0.425

			if var_59_2 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_4 = arg_56_1:FormatText(StoryNameCfg[472].name)

				arg_56_1.leftNameTxt_.text = var_59_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_5 = arg_56_1:GetWordFromCfg(324771014)
				local var_59_6 = arg_56_1:FormatText(var_59_5.content)

				arg_56_1.text_.text = var_59_6

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 17
				local var_59_8 = utf8.len(var_59_6)
				local var_59_9 = var_59_7 <= 0 and var_59_3 or var_59_3 * (var_59_8 / var_59_7)

				if var_59_9 > 0 and var_59_3 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_6
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771014", "story_v_out_324771.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_324771", "324771014", "story_v_out_324771.awb") / 1000

					if var_59_10 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_2
					end

					if var_59_5.prefab_name ~= "" and arg_56_1.actors_[var_59_5.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_5.prefab_name].transform, "story_v_out_324771", "324771014", "story_v_out_324771.awb")

						arg_56_1:RecordAudio("324771014", var_59_11)
						arg_56_1:RecordAudio("324771014", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_324771", "324771014", "story_v_out_324771.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_324771", "324771014", "story_v_out_324771.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_3, arg_56_1.talkMaxDuration)

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_2) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_2 + var_59_12 and arg_56_1.time_ < var_59_2 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play324771015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324771015
		arg_60_1.duration_ = 3.33

		local var_60_0 = {
			zh = 3.333,
			ja = 2.8
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play324771016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1054ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1054ui_story == nil then
				arg_60_1.var_.characterEffect1054ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1054ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1054ui_story then
				arg_60_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["1053ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1053ui_story == nil then
				arg_60_1.var_.characterEffect1053ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.200000002980232

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect1053ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1053ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1053ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1053ui_story.fillRatio = var_63_9
			end

			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action7_2")
			end

			local var_63_11 = 0
			local var_63_12 = 0.25

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_13 = arg_60_1:FormatText(StoryNameCfg[1487].name)

				arg_60_1.leftNameTxt_.text = var_63_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_14 = arg_60_1:GetWordFromCfg(324771015)
				local var_63_15 = arg_60_1:FormatText(var_63_14.content)

				arg_60_1.text_.text = var_63_15

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_16 = 10
				local var_63_17 = utf8.len(var_63_15)
				local var_63_18 = var_63_16 <= 0 and var_63_12 or var_63_12 * (var_63_17 / var_63_16)

				if var_63_18 > 0 and var_63_12 < var_63_18 then
					arg_60_1.talkMaxDuration = var_63_18

					if var_63_18 + var_63_11 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_18 + var_63_11
					end
				end

				arg_60_1.text_.text = var_63_15
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771015", "story_v_out_324771.awb") ~= 0 then
					local var_63_19 = manager.audio:GetVoiceLength("story_v_out_324771", "324771015", "story_v_out_324771.awb") / 1000

					if var_63_19 + var_63_11 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_11
					end

					if var_63_14.prefab_name ~= "" and arg_60_1.actors_[var_63_14.prefab_name] ~= nil then
						local var_63_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_14.prefab_name].transform, "story_v_out_324771", "324771015", "story_v_out_324771.awb")

						arg_60_1:RecordAudio("324771015", var_63_20)
						arg_60_1:RecordAudio("324771015", var_63_20)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_324771", "324771015", "story_v_out_324771.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_324771", "324771015", "story_v_out_324771.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_21 = math.max(var_63_12, arg_60_1.talkMaxDuration)

			if var_63_11 <= arg_60_1.time_ and arg_60_1.time_ < var_63_11 + var_63_21 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_11) / var_63_21

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_11 + var_63_21 and arg_60_1.time_ < var_63_11 + var_63_21 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play324771016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324771016
		arg_64_1.duration_ = 4.3

		local var_64_0 = {
			zh = 2.533,
			ja = 4.3
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play324771017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["6148ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos6148ui_story = var_67_0.localPosition

				local var_67_2 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(false)
				end
			end

			local var_67_3 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_3 then
				local var_67_4 = (arg_64_1.time_ - var_67_1) / var_67_3
				local var_67_5 = Vector3.New(0.7, -0.985, -6)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos6148ui_story, var_67_5, var_67_4)

				local var_67_6 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_6.x, var_67_6.y, var_67_6.z)

				local var_67_7 = var_67_0.localEulerAngles

				var_67_7.z = 0
				var_67_7.x = 0
				var_67_0.localEulerAngles = var_67_7
			end

			if arg_64_1.time_ >= var_67_1 + var_67_3 and arg_64_1.time_ < var_67_1 + var_67_3 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_67_8 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_8.x, var_67_8.y, var_67_8.z)

				local var_67_9 = var_67_0.localEulerAngles

				var_67_9.z = 0
				var_67_9.x = 0
				var_67_0.localEulerAngles = var_67_9

				local var_67_10 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_10 then
					var_67_10:EnableDynamicBone(true)
				end
			end

			local var_67_11 = arg_64_1.actors_["1053ui_story"].transform
			local var_67_12 = 0

			if var_67_12 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 then
				arg_64_1.var_.moveOldPos1053ui_story = var_67_11.localPosition

				local var_67_13 = GameObjectTools.GetOrAddComponent(var_67_11.gameObject, typeof(DynamicBoneHelper))

				if var_67_13 then
					var_67_13:EnableDynamicBone(false)
				end
			end

			local var_67_14 = 0.001

			if var_67_12 <= arg_64_1.time_ and arg_64_1.time_ < var_67_12 + var_67_14 then
				local var_67_15 = (arg_64_1.time_ - var_67_12) / var_67_14
				local var_67_16 = Vector3.New(0, 100, 0)

				var_67_11.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1053ui_story, var_67_16, var_67_15)

				local var_67_17 = manager.ui.mainCamera.transform.position - var_67_11.position

				var_67_11.forward = Vector3.New(var_67_17.x, var_67_17.y, var_67_17.z)

				local var_67_18 = var_67_11.localEulerAngles

				var_67_18.z = 0
				var_67_18.x = 0
				var_67_11.localEulerAngles = var_67_18
			end

			if arg_64_1.time_ >= var_67_12 + var_67_14 and arg_64_1.time_ < var_67_12 + var_67_14 + arg_67_0 then
				var_67_11.localPosition = Vector3.New(0, 100, 0)

				local var_67_19 = manager.ui.mainCamera.transform.position - var_67_11.position

				var_67_11.forward = Vector3.New(var_67_19.x, var_67_19.y, var_67_19.z)

				local var_67_20 = var_67_11.localEulerAngles

				var_67_20.z = 0
				var_67_20.x = 0
				var_67_11.localEulerAngles = var_67_20

				local var_67_21 = GameObjectTools.GetOrAddComponent(var_67_11.gameObject, typeof(DynamicBoneHelper))

				if var_67_21 then
					var_67_21:EnableDynamicBone(true)
				end
			end

			local var_67_22 = arg_64_1.actors_["6148ui_story"]
			local var_67_23 = 0

			if var_67_23 < arg_64_1.time_ and arg_64_1.time_ <= var_67_23 + arg_67_0 and not isNil(var_67_22) and arg_64_1.var_.characterEffect6148ui_story == nil then
				arg_64_1.var_.characterEffect6148ui_story = var_67_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_24 = 0.200000002980232

			if var_67_23 <= arg_64_1.time_ and arg_64_1.time_ < var_67_23 + var_67_24 and not isNil(var_67_22) then
				local var_67_25 = (arg_64_1.time_ - var_67_23) / var_67_24

				if arg_64_1.var_.characterEffect6148ui_story and not isNil(var_67_22) then
					arg_64_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_23 + var_67_24 and arg_64_1.time_ < var_67_23 + var_67_24 + arg_67_0 and not isNil(var_67_22) and arg_64_1.var_.characterEffect6148ui_story then
				arg_64_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_67_26 = arg_64_1.actors_["1054ui_story"]
			local var_67_27 = 0

			if var_67_27 < arg_64_1.time_ and arg_64_1.time_ <= var_67_27 + arg_67_0 and not isNil(var_67_26) and arg_64_1.var_.characterEffect1054ui_story == nil then
				arg_64_1.var_.characterEffect1054ui_story = var_67_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_28 = 0.200000002980232

			if var_67_27 <= arg_64_1.time_ and arg_64_1.time_ < var_67_27 + var_67_28 and not isNil(var_67_26) then
				local var_67_29 = (arg_64_1.time_ - var_67_27) / var_67_28

				if arg_64_1.var_.characterEffect1054ui_story and not isNil(var_67_26) then
					local var_67_30 = Mathf.Lerp(0, 0.5, var_67_29)

					arg_64_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1054ui_story.fillRatio = var_67_30
				end
			end

			if arg_64_1.time_ >= var_67_27 + var_67_28 and arg_64_1.time_ < var_67_27 + var_67_28 + arg_67_0 and not isNil(var_67_26) and arg_64_1.var_.characterEffect1054ui_story then
				local var_67_31 = 0.5

				arg_64_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1054ui_story.fillRatio = var_67_31
			end

			local var_67_32 = 0

			if var_67_32 < arg_64_1.time_ and arg_64_1.time_ <= var_67_32 + arg_67_0 then
				arg_64_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_67_33 = 0
			local var_67_34 = 0.325

			if var_67_33 < arg_64_1.time_ and arg_64_1.time_ <= var_67_33 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_35 = arg_64_1:FormatText(StoryNameCfg[1488].name)

				arg_64_1.leftNameTxt_.text = var_67_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_36 = arg_64_1:GetWordFromCfg(324771016)
				local var_67_37 = arg_64_1:FormatText(var_67_36.content)

				arg_64_1.text_.text = var_67_37

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_38 = 13
				local var_67_39 = utf8.len(var_67_37)
				local var_67_40 = var_67_38 <= 0 and var_67_34 or var_67_34 * (var_67_39 / var_67_38)

				if var_67_40 > 0 and var_67_34 < var_67_40 then
					arg_64_1.talkMaxDuration = var_67_40

					if var_67_40 + var_67_33 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_40 + var_67_33
					end
				end

				arg_64_1.text_.text = var_67_37
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771016", "story_v_out_324771.awb") ~= 0 then
					local var_67_41 = manager.audio:GetVoiceLength("story_v_out_324771", "324771016", "story_v_out_324771.awb") / 1000

					if var_67_41 + var_67_33 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_41 + var_67_33
					end

					if var_67_36.prefab_name ~= "" and arg_64_1.actors_[var_67_36.prefab_name] ~= nil then
						local var_67_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_36.prefab_name].transform, "story_v_out_324771", "324771016", "story_v_out_324771.awb")

						arg_64_1:RecordAudio("324771016", var_67_42)
						arg_64_1:RecordAudio("324771016", var_67_42)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_324771", "324771016", "story_v_out_324771.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_324771", "324771016", "story_v_out_324771.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_43 = math.max(var_67_34, arg_64_1.talkMaxDuration)

			if var_67_33 <= arg_64_1.time_ and arg_64_1.time_ < var_67_33 + var_67_43 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_33) / var_67_43

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_33 + var_67_43 and arg_64_1.time_ < var_67_33 + var_67_43 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play324771017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324771017
		arg_68_1.duration_ = 6.5

		local var_68_0 = {
			zh = 3.933,
			ja = 6.5
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
			arg_68_1.auto_ = false
		end

		function arg_68_1.playNext_(arg_70_0)
			arg_68_1.onStoryFinished_()
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1053ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1053ui_story = var_71_0.localPosition

				local var_71_2 = GameObjectTools.GetOrAddComponent(var_71_0.gameObject, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(false)
				end
			end

			local var_71_3 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_3 then
				local var_71_4 = (arg_68_1.time_ - var_71_1) / var_71_3
				local var_71_5 = Vector3.New(0, -1.08, -6)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1053ui_story, var_71_5, var_71_4)

				local var_71_6 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_6.x, var_71_6.y, var_71_6.z)

				local var_71_7 = var_71_0.localEulerAngles

				var_71_7.z = 0
				var_71_7.x = 0
				var_71_0.localEulerAngles = var_71_7
			end

			if arg_68_1.time_ >= var_71_1 + var_71_3 and arg_68_1.time_ < var_71_1 + var_71_3 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_71_8 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_8.x, var_71_8.y, var_71_8.z)

				local var_71_9 = var_71_0.localEulerAngles

				var_71_9.z = 0
				var_71_9.x = 0
				var_71_0.localEulerAngles = var_71_9

				local var_71_10 = GameObjectTools.GetOrAddComponent(var_71_0.gameObject, typeof(DynamicBoneHelper))

				if var_71_10 then
					var_71_10:EnableDynamicBone(true)
				end
			end

			local var_71_11 = arg_68_1.actors_["6148ui_story"].transform
			local var_71_12 = 0

			if var_71_12 < arg_68_1.time_ and arg_68_1.time_ <= var_71_12 + arg_71_0 then
				arg_68_1.var_.moveOldPos6148ui_story = var_71_11.localPosition

				local var_71_13 = GameObjectTools.GetOrAddComponent(var_71_11.gameObject, typeof(DynamicBoneHelper))

				if var_71_13 then
					var_71_13:EnableDynamicBone(false)
				end
			end

			local var_71_14 = 0.001

			if var_71_12 <= arg_68_1.time_ and arg_68_1.time_ < var_71_12 + var_71_14 then
				local var_71_15 = (arg_68_1.time_ - var_71_12) / var_71_14
				local var_71_16 = Vector3.New(0, 100, 0)

				var_71_11.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos6148ui_story, var_71_16, var_71_15)

				local var_71_17 = manager.ui.mainCamera.transform.position - var_71_11.position

				var_71_11.forward = Vector3.New(var_71_17.x, var_71_17.y, var_71_17.z)

				local var_71_18 = var_71_11.localEulerAngles

				var_71_18.z = 0
				var_71_18.x = 0
				var_71_11.localEulerAngles = var_71_18
			end

			if arg_68_1.time_ >= var_71_12 + var_71_14 and arg_68_1.time_ < var_71_12 + var_71_14 + arg_71_0 then
				var_71_11.localPosition = Vector3.New(0, 100, 0)

				local var_71_19 = manager.ui.mainCamera.transform.position - var_71_11.position

				var_71_11.forward = Vector3.New(var_71_19.x, var_71_19.y, var_71_19.z)

				local var_71_20 = var_71_11.localEulerAngles

				var_71_20.z = 0
				var_71_20.x = 0
				var_71_11.localEulerAngles = var_71_20

				local var_71_21 = GameObjectTools.GetOrAddComponent(var_71_11.gameObject, typeof(DynamicBoneHelper))

				if var_71_21 then
					var_71_21:EnableDynamicBone(true)
				end
			end

			local var_71_22 = arg_68_1.actors_["1054ui_story"].transform
			local var_71_23 = 0

			if var_71_23 < arg_68_1.time_ and arg_68_1.time_ <= var_71_23 + arg_71_0 then
				arg_68_1.var_.moveOldPos1054ui_story = var_71_22.localPosition

				local var_71_24 = GameObjectTools.GetOrAddComponent(var_71_22.gameObject, typeof(DynamicBoneHelper))

				if var_71_24 then
					var_71_24:EnableDynamicBone(false)
				end
			end

			local var_71_25 = 0.001

			if var_71_23 <= arg_68_1.time_ and arg_68_1.time_ < var_71_23 + var_71_25 then
				local var_71_26 = (arg_68_1.time_ - var_71_23) / var_71_25
				local var_71_27 = Vector3.New(0, 100, 0)

				var_71_22.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1054ui_story, var_71_27, var_71_26)

				local var_71_28 = manager.ui.mainCamera.transform.position - var_71_22.position

				var_71_22.forward = Vector3.New(var_71_28.x, var_71_28.y, var_71_28.z)

				local var_71_29 = var_71_22.localEulerAngles

				var_71_29.z = 0
				var_71_29.x = 0
				var_71_22.localEulerAngles = var_71_29
			end

			if arg_68_1.time_ >= var_71_23 + var_71_25 and arg_68_1.time_ < var_71_23 + var_71_25 + arg_71_0 then
				var_71_22.localPosition = Vector3.New(0, 100, 0)

				local var_71_30 = manager.ui.mainCamera.transform.position - var_71_22.position

				var_71_22.forward = Vector3.New(var_71_30.x, var_71_30.y, var_71_30.z)

				local var_71_31 = var_71_22.localEulerAngles

				var_71_31.z = 0
				var_71_31.x = 0
				var_71_22.localEulerAngles = var_71_31

				local var_71_32 = GameObjectTools.GetOrAddComponent(var_71_22.gameObject, typeof(DynamicBoneHelper))

				if var_71_32 then
					var_71_32:EnableDynamicBone(true)
				end
			end

			local var_71_33 = arg_68_1.actors_["1053ui_story"]
			local var_71_34 = 0

			if var_71_34 < arg_68_1.time_ and arg_68_1.time_ <= var_71_34 + arg_71_0 and not isNil(var_71_33) and arg_68_1.var_.characterEffect1053ui_story == nil then
				arg_68_1.var_.characterEffect1053ui_story = var_71_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_35 = 0.200000002980232

			if var_71_34 <= arg_68_1.time_ and arg_68_1.time_ < var_71_34 + var_71_35 and not isNil(var_71_33) then
				local var_71_36 = (arg_68_1.time_ - var_71_34) / var_71_35

				if arg_68_1.var_.characterEffect1053ui_story and not isNil(var_71_33) then
					arg_68_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_34 + var_71_35 and arg_68_1.time_ < var_71_34 + var_71_35 + arg_71_0 and not isNil(var_71_33) and arg_68_1.var_.characterEffect1053ui_story then
				arg_68_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_71_37 = arg_68_1.actors_["1037ui_story"]
			local var_71_38 = 0

			if var_71_38 < arg_68_1.time_ and arg_68_1.time_ <= var_71_38 + arg_71_0 and not isNil(var_71_37) and arg_68_1.var_.characterEffect1037ui_story == nil then
				arg_68_1.var_.characterEffect1037ui_story = var_71_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_39 = 0.200000002980232

			if var_71_38 <= arg_68_1.time_ and arg_68_1.time_ < var_71_38 + var_71_39 and not isNil(var_71_37) then
				local var_71_40 = (arg_68_1.time_ - var_71_38) / var_71_39

				if arg_68_1.var_.characterEffect1037ui_story and not isNil(var_71_37) then
					local var_71_41 = Mathf.Lerp(0, 0.5, var_71_40)

					arg_68_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1037ui_story.fillRatio = var_71_41
				end
			end

			if arg_68_1.time_ >= var_71_38 + var_71_39 and arg_68_1.time_ < var_71_38 + var_71_39 + arg_71_0 and not isNil(var_71_37) and arg_68_1.var_.characterEffect1037ui_story then
				local var_71_42 = 0.5

				arg_68_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1037ui_story.fillRatio = var_71_42
			end

			local var_71_43 = 0

			if var_71_43 < arg_68_1.time_ and arg_68_1.time_ <= var_71_43 + arg_71_0 then
				arg_68_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action456")
			end

			local var_71_44 = 0

			if var_71_44 < arg_68_1.time_ and arg_68_1.time_ <= var_71_44 + arg_71_0 then
				arg_68_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_71_45 = 0
			local var_71_46 = 0.475

			if var_71_45 < arg_68_1.time_ and arg_68_1.time_ <= var_71_45 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_47 = arg_68_1:FormatText(StoryNameCfg[472].name)

				arg_68_1.leftNameTxt_.text = var_71_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_48 = arg_68_1:GetWordFromCfg(324771017)
				local var_71_49 = arg_68_1:FormatText(var_71_48.content)

				arg_68_1.text_.text = var_71_49

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_50 = 19
				local var_71_51 = utf8.len(var_71_49)
				local var_71_52 = var_71_50 <= 0 and var_71_46 or var_71_46 * (var_71_51 / var_71_50)

				if var_71_52 > 0 and var_71_46 < var_71_52 then
					arg_68_1.talkMaxDuration = var_71_52

					if var_71_52 + var_71_45 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_52 + var_71_45
					end
				end

				arg_68_1.text_.text = var_71_49
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324771", "324771017", "story_v_out_324771.awb") ~= 0 then
					local var_71_53 = manager.audio:GetVoiceLength("story_v_out_324771", "324771017", "story_v_out_324771.awb") / 1000

					if var_71_53 + var_71_45 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_53 + var_71_45
					end

					if var_71_48.prefab_name ~= "" and arg_68_1.actors_[var_71_48.prefab_name] ~= nil then
						local var_71_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_48.prefab_name].transform, "story_v_out_324771", "324771017", "story_v_out_324771.awb")

						arg_68_1:RecordAudio("324771017", var_71_54)
						arg_68_1:RecordAudio("324771017", var_71_54)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_324771", "324771017", "story_v_out_324771.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_324771", "324771017", "story_v_out_324771.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_55 = math.max(var_71_46, arg_68_1.talkMaxDuration)

			if var_71_45 <= arg_68_1.time_ and arg_68_1.time_ < var_71_45 + var_71_55 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_45) / var_71_55

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_45 + var_71_55 and arg_68_1.time_ < var_71_45 + var_71_55 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2007"
	},
	voices = {
		"story_v_out_324771.awb"
	}
}
