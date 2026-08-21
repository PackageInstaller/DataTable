return {
	Play113031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113031001
		arg_1_1.duration_ = 4.07

		local var_1_0 = {
			ja = 3.3,
			ko = 3.966,
			zh = 4.066,
			en = 3.4
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
				arg_1_0:Play113031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F01a"

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
				local var_4_5 = arg_1_1.bgs_.F01a

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
					if iter_4_0 ~= "F01a" then
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
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "effect"

				arg_1_1:AudioAction(var_4_24, var_4_25, "se_story_10", "se_story_10_energy_loop", "")
			end

			local var_4_26 = 0
			local var_4_27 = 1

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "music"

				arg_1_1:AudioAction(var_4_28, var_4_29, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_30 = ""
				local var_4_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_31 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_31 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_31

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_31
						arg_1_1.bgmTxt2_.text = var_4_31
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

			local var_4_32 = 2
			local var_4_33 = 1

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_34 = "play"
				local var_4_35 = "music"

				arg_1_1:AudioAction(var_4_34, var_4_35, "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_4_36 = ""
				local var_4_37 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if var_4_37 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_37 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_37

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_37
						arg_1_1.bgmTxt2_.text = var_4_37
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

			local var_4_38 = 2
			local var_4_39 = 0.15

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[210].name)

				arg_1_1.leftNameTxt_.text = var_4_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_42 = arg_1_1:GetWordFromCfg(113031001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 6
				local var_4_45 = utf8.len(var_4_43)
				local var_4_46 = var_4_44 <= 0 and var_4_39 or var_4_39 * (var_4_45 / var_4_44)

				if var_4_46 > 0 and var_4_39 < var_4_46 then
					arg_1_1.talkMaxDuration = var_4_46
					var_4_38 = var_4_38 + 0.3

					if var_4_46 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_43
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031001", "story_v_out_113031.awb") ~= 0 then
					local var_4_47 = manager.audio:GetVoiceLength("story_v_out_113031", "113031001", "story_v_out_113031.awb") / 1000

					if var_4_47 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_38
					end

					if var_4_42.prefab_name ~= "" and arg_1_1.actors_[var_4_42.prefab_name] ~= nil then
						local var_4_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_42.prefab_name].transform, "story_v_out_113031", "113031001", "story_v_out_113031.awb")

						arg_1_1:RecordAudio("113031001", var_4_48)
						arg_1_1:RecordAudio("113031001", var_4_48)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113031", "113031001", "story_v_out_113031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113031", "113031001", "story_v_out_113031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_49 = var_4_38 + 0.3
			local var_4_50 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_49 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_50 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_49) / var_4_50

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_49 + var_4_50 and arg_1_1.time_ < var_4_49 + var_4_50 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play113031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 113031002
		arg_9_1.duration_ = 3.2

		local var_9_0 = {
			ja = 1.999999999999,
			ko = 3.2,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play113031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1038ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_9_1.stage_.transform)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentInChildren(typeof(CharacterEffect))

					var_12_3.enabled = true

					local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_2, typeof(DynamicBoneHelper))

					if var_12_4 then
						var_12_4:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_3.transform, false)

					arg_9_1.var_[var_12_0 .. "Animator"] = var_12_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_0 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_0 .. "LipSync"] = var_12_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_5 = arg_9_1.actors_["1038ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1038ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -1.11, -5.9)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1038ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = 0

			if var_12_14 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				arg_9_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_12_16 = arg_9_1.actors_["1038ui_story"]
			local var_12_17 = 0

			if var_12_17 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1038ui_story == nil then
				arg_9_1.var_.characterEffect1038ui_story = var_12_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_18 = 0.2

			if var_12_17 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_18 and not isNil(var_12_16) then
				local var_12_19 = (arg_9_1.time_ - var_12_17) / var_12_18

				if arg_9_1.var_.characterEffect1038ui_story and not isNil(var_12_16) then
					arg_9_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_17 + var_12_18 and arg_9_1.time_ < var_12_17 + var_12_18 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1038ui_story then
				arg_9_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_12_20 = 0
			local var_12_21 = 0.225

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[94].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(113031002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 9
				local var_12_26 = utf8.len(var_12_24)
				local var_12_27 = var_12_25 <= 0 and var_12_21 or var_12_21 * (var_12_26 / var_12_25)

				if var_12_27 > 0 and var_12_21 < var_12_27 then
					arg_9_1.talkMaxDuration = var_12_27

					if var_12_27 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_27 + var_12_20
					end
				end

				arg_9_1.text_.text = var_12_24
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031002", "story_v_out_113031.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_113031", "113031002", "story_v_out_113031.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_113031", "113031002", "story_v_out_113031.awb")

						arg_9_1:RecordAudio("113031002", var_12_29)
						arg_9_1:RecordAudio("113031002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_113031", "113031002", "story_v_out_113031.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_113031", "113031002", "story_v_out_113031.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_30 = math.max(var_12_21, arg_9_1.talkMaxDuration)

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_30 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_20) / var_12_30

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_20 + var_12_30 and arg_9_1.time_ < var_12_20 + var_12_30 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play113031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 113031003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play113031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1038ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1038ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, 100, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1038ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, 100, 0)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = 0
			local var_16_10 = 1.025

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_11 = arg_13_1:GetWordFromCfg(113031003)
				local var_16_12 = arg_13_1:FormatText(var_16_11.content)

				arg_13_1.text_.text = var_16_12

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 41
				local var_16_14 = utf8.len(var_16_12)
				local var_16_15 = var_16_13 <= 0 and var_16_10 or var_16_10 * (var_16_14 / var_16_13)

				if var_16_15 > 0 and var_16_10 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_9 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_9
					end
				end

				arg_13_1.text_.text = var_16_12
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_10, arg_13_1.talkMaxDuration)

			if var_16_9 <= arg_13_1.time_ and arg_13_1.time_ < var_16_9 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_9) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_9 + var_16_16 and arg_13_1.time_ < var_16_9 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play113031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 113031004
		arg_17_1.duration_ = 5.7

		local var_17_0 = {
			ja = 5.7,
			ko = 4.666,
			zh = 2.766,
			en = 3.2
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
				arg_17_0:Play113031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.375

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[209].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(113031004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 15
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031004", "story_v_out_113031.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_113031", "113031004", "story_v_out_113031.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_113031", "113031004", "story_v_out_113031.awb")

						arg_17_1:RecordAudio("113031004", var_20_9)
						arg_17_1:RecordAudio("113031004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_113031", "113031004", "story_v_out_113031.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_113031", "113031004", "story_v_out_113031.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play113031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 113031005
		arg_21_1.duration_ = 7

		local var_21_0 = {
			ja = 4.666,
			ko = 5.266,
			zh = 4.933,
			en = 7
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
				arg_21_0:Play113031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1038ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1038ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, -1.11, -5.9)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1038ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_24_11 = arg_21_1.actors_["1038ui_story"]
			local var_24_12 = 0

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 and not isNil(var_24_11) and arg_21_1.var_.characterEffect1038ui_story == nil then
				arg_21_1.var_.characterEffect1038ui_story = var_24_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_13 = 0.2

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_13 and not isNil(var_24_11) then
				local var_24_14 = (arg_21_1.time_ - var_24_12) / var_24_13

				if arg_21_1.var_.characterEffect1038ui_story and not isNil(var_24_11) then
					arg_21_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_12 + var_24_13 and arg_21_1.time_ < var_24_12 + var_24_13 + arg_24_0 and not isNil(var_24_11) and arg_21_1.var_.characterEffect1038ui_story then
				arg_21_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_24_15 = 0
			local var_24_16 = 0.45

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[94].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(113031005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 18
				local var_24_21 = utf8.len(var_24_19)
				local var_24_22 = var_24_20 <= 0 and var_24_16 or var_24_16 * (var_24_21 / var_24_20)

				if var_24_22 > 0 and var_24_16 < var_24_22 then
					arg_21_1.talkMaxDuration = var_24_22

					if var_24_22 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_22 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_19
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031005", "story_v_out_113031.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_113031", "113031005", "story_v_out_113031.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_113031", "113031005", "story_v_out_113031.awb")

						arg_21_1:RecordAudio("113031005", var_24_24)
						arg_21_1:RecordAudio("113031005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_113031", "113031005", "story_v_out_113031.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_113031", "113031005", "story_v_out_113031.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_25 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_25 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_25

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_25 and arg_21_1.time_ < var_24_15 + var_24_25 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play113031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 113031006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play113031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1038ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1038ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1038ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, 100, 0)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = 0
			local var_28_10 = 0.775

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				local var_28_11 = "play"
				local var_28_12 = "effect"

				arg_25_1:AudioAction(var_28_11, var_28_12, "se_story_10", "se_story_10_skill", "")
			end

			local var_28_13 = 0
			local var_28_14 = 0.775

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_15 = arg_25_1:GetWordFromCfg(113031006)
				local var_28_16 = arg_25_1:FormatText(var_28_15.content)

				arg_25_1.text_.text = var_28_16

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_17 = 31
				local var_28_18 = utf8.len(var_28_16)
				local var_28_19 = var_28_17 <= 0 and var_28_14 or var_28_14 * (var_28_18 / var_28_17)

				if var_28_19 > 0 and var_28_14 < var_28_19 then
					arg_25_1.talkMaxDuration = var_28_19

					if var_28_19 + var_28_13 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_13
					end
				end

				arg_25_1.text_.text = var_28_16
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_20 = math.max(var_28_14, arg_25_1.talkMaxDuration)

			if var_28_13 <= arg_25_1.time_ and arg_25_1.time_ < var_28_13 + var_28_20 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_13) / var_28_20

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_13 + var_28_20 and arg_25_1.time_ < var_28_13 + var_28_20 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play113031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 113031007
		arg_29_1.duration_ = 1.97

		local var_29_0 = {
			ja = 1.966,
			ko = 0.999999999999,
			zh = 1.833,
			en = 1.833
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
				arg_29_0:Play113031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = manager.ui.mainCamera.transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.shakeOldPos1041ui_light = var_32_0.localPosition
			end

			local var_32_2 = 0.6

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / 0.066
				local var_32_4, var_32_5 = math.modf(var_32_3)

				var_32_0.localPosition = Vector3.New(var_32_5 * 0.13, var_32_5 * 0.13, var_32_5 * 0.13) + arg_29_1.var_.shakeOldPos1041ui_light
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = arg_29_1.var_.shakeOldPos1041ui_light
			end

			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			local var_32_7 = 0.6

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			local var_32_8 = 0
			local var_32_9 = 0.15

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_10 = arg_29_1:FormatText(StoryNameCfg[208].name)

				arg_29_1.leftNameTxt_.text = var_32_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_11 = arg_29_1:GetWordFromCfg(113031007)
				local var_32_12 = arg_29_1:FormatText(var_32_11.content)

				arg_29_1.text_.text = var_32_12

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 6
				local var_32_14 = utf8.len(var_32_12)
				local var_32_15 = var_32_13 <= 0 and var_32_9 or var_32_9 * (var_32_14 / var_32_13)

				if var_32_15 > 0 and var_32_9 < var_32_15 then
					arg_29_1.talkMaxDuration = var_32_15

					if var_32_15 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_15 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_12
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031007", "story_v_out_113031.awb") ~= 0 then
					local var_32_16 = manager.audio:GetVoiceLength("story_v_out_113031", "113031007", "story_v_out_113031.awb") / 1000

					if var_32_16 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_8
					end

					if var_32_11.prefab_name ~= "" and arg_29_1.actors_[var_32_11.prefab_name] ~= nil then
						local var_32_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_11.prefab_name].transform, "story_v_out_113031", "113031007", "story_v_out_113031.awb")

						arg_29_1:RecordAudio("113031007", var_32_17)
						arg_29_1:RecordAudio("113031007", var_32_17)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_113031", "113031007", "story_v_out_113031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_113031", "113031007", "story_v_out_113031.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_18 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_18 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_18

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_18 and arg_29_1.time_ < var_32_8 + var_32_18 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play113031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 113031008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play113031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				local var_36_2 = "stop"
				local var_36_3 = "music"

				arg_33_1:AudioAction(var_36_2, var_36_3, "se_story_10", "se_story_10_energy_loop", "")

				local var_36_4 = ""
				local var_36_5 = manager.audio:GetAudioName("se_story_10", "se_story_10_energy_loop")

				if var_36_5 ~= "" then
					if arg_33_1.bgmTxt_.text ~= var_36_5 and arg_33_1.bgmTxt_.text ~= "" then
						if arg_33_1.bgmTxt2_.text ~= "" then
							arg_33_1.bgmTxt_.text = arg_33_1.bgmTxt2_.text
						end

						arg_33_1.bgmTxt2_.text = var_36_5

						arg_33_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_33_1.bgmTxt_.text = var_36_5
						arg_33_1.bgmTxt2_.text = var_36_5
					end

					if arg_33_1.bgmTimer then
						arg_33_1.bgmTimer:Stop()

						arg_33_1.bgmTimer = nil
					end

					if arg_33_1.settingData.show_music_name == 1 then
						arg_33_1.musicController:SetSelectedState("show")
						arg_33_1.musicAnimator_:Play("open", 0, 0)

						if arg_33_1.settingData.music_time ~= 0 then
							arg_33_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_33_1.settingData.music_time), function()
								if arg_33_1 == nil or isNil(arg_33_1.bgmTxt_) then
									return
								end

								arg_33_1.musicController:SetSelectedState("hide")
								arg_33_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_36_6 = 0
			local var_36_7 = 0.666666666666667

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				local var_36_8 = "play"
				local var_36_9 = "effect"

				arg_33_1:AudioAction(var_36_8, var_36_9, "se_story_10", "se_story_10_sword", "")
			end

			local var_36_10 = 0
			local var_36_11 = 1.025

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_12 = arg_33_1:GetWordFromCfg(113031008)
				local var_36_13 = arg_33_1:FormatText(var_36_12.content)

				arg_33_1.text_.text = var_36_13

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_14 = 41
				local var_36_15 = utf8.len(var_36_13)
				local var_36_16 = var_36_14 <= 0 and var_36_11 or var_36_11 * (var_36_15 / var_36_14)

				if var_36_16 > 0 and var_36_11 < var_36_16 then
					arg_33_1.talkMaxDuration = var_36_16

					if var_36_16 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_16 + var_36_10
					end
				end

				arg_33_1.text_.text = var_36_13
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_17 = math.max(var_36_11, arg_33_1.talkMaxDuration)

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_17 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_10) / var_36_17

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_10 + var_36_17 and arg_33_1.time_ < var_36_10 + var_36_17 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play113031009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 113031009
		arg_38_1.duration_ = 5.23

		local var_38_0 = {
			ja = 4.566,
			ko = 5.233,
			zh = 5.066,
			en = 4.1
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play113031010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 0.475

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_2 = arg_38_1:FormatText(StoryNameCfg[209].name)

				arg_38_1.leftNameTxt_.text = var_41_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_3 = arg_38_1:GetWordFromCfg(113031009)
				local var_41_4 = arg_38_1:FormatText(var_41_3.content)

				arg_38_1.text_.text = var_41_4

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 19
				local var_41_6 = utf8.len(var_41_4)
				local var_41_7 = var_41_5 <= 0 and var_41_1 or var_41_1 * (var_41_6 / var_41_5)

				if var_41_7 > 0 and var_41_1 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_0
					end
				end

				arg_38_1.text_.text = var_41_4
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031009", "story_v_out_113031.awb") ~= 0 then
					local var_41_8 = manager.audio:GetVoiceLength("story_v_out_113031", "113031009", "story_v_out_113031.awb") / 1000

					if var_41_8 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_8 + var_41_0
					end

					if var_41_3.prefab_name ~= "" and arg_38_1.actors_[var_41_3.prefab_name] ~= nil then
						local var_41_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_3.prefab_name].transform, "story_v_out_113031", "113031009", "story_v_out_113031.awb")

						arg_38_1:RecordAudio("113031009", var_41_9)
						arg_38_1:RecordAudio("113031009", var_41_9)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_113031", "113031009", "story_v_out_113031.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_113031", "113031009", "story_v_out_113031.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_10 = math.max(var_41_1, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_10 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_0) / var_41_10

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_10 and arg_38_1.time_ < var_41_0 + var_41_10 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play113031010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 113031010
		arg_42_1.duration_ = 4.57

		local var_42_0 = {
			ja = 4.3,
			ko = 4.566,
			zh = 4.166,
			en = 2.466
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play113031011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1038ui_story"].transform
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.var_.moveOldPos1038ui_story = var_45_0.localPosition
			end

			local var_45_2 = 0.001

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2
				local var_45_4 = Vector3.New(-0.7, -1.11, -5.9)

				var_45_0.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1038ui_story, var_45_4, var_45_3)

				local var_45_5 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_5.x, var_45_5.y, var_45_5.z)

				local var_45_6 = var_45_0.localEulerAngles

				var_45_6.z = 0
				var_45_6.x = 0
				var_45_0.localEulerAngles = var_45_6
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 then
				var_45_0.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_45_7 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_7.x, var_45_7.y, var_45_7.z)

				local var_45_8 = var_45_0.localEulerAngles

				var_45_8.z = 0
				var_45_8.x = 0
				var_45_0.localEulerAngles = var_45_8
			end

			local var_45_9 = arg_42_1.actors_["1038ui_story"]
			local var_45_10 = 0

			if var_45_10 < arg_42_1.time_ and arg_42_1.time_ <= var_45_10 + arg_45_0 and not isNil(var_45_9) and arg_42_1.var_.characterEffect1038ui_story == nil then
				arg_42_1.var_.characterEffect1038ui_story = var_45_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_11 = 0.2

			if var_45_10 <= arg_42_1.time_ and arg_42_1.time_ < var_45_10 + var_45_11 and not isNil(var_45_9) then
				local var_45_12 = (arg_42_1.time_ - var_45_10) / var_45_11

				if arg_42_1.var_.characterEffect1038ui_story and not isNil(var_45_9) then
					arg_42_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_10 + var_45_11 and arg_42_1.time_ < var_45_10 + var_45_11 + arg_45_0 and not isNil(var_45_9) and arg_42_1.var_.characterEffect1038ui_story then
				arg_42_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_45_13 = 0

			if var_45_13 < arg_42_1.time_ and arg_42_1.time_ <= var_45_13 + arg_45_0 then
				arg_42_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_45_14 = 0

			if var_45_14 < arg_42_1.time_ and arg_42_1.time_ <= var_45_14 + arg_45_0 then
				arg_42_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_2")
			end

			local var_45_15 = 0
			local var_45_16 = 0.5

			if var_45_15 < arg_42_1.time_ and arg_42_1.time_ <= var_45_15 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_17 = arg_42_1:FormatText(StoryNameCfg[94].name)

				arg_42_1.leftNameTxt_.text = var_45_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_18 = arg_42_1:GetWordFromCfg(113031010)
				local var_45_19 = arg_42_1:FormatText(var_45_18.content)

				arg_42_1.text_.text = var_45_19

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_20 = 20
				local var_45_21 = utf8.len(var_45_19)
				local var_45_22 = var_45_20 <= 0 and var_45_16 or var_45_16 * (var_45_21 / var_45_20)

				if var_45_22 > 0 and var_45_16 < var_45_22 then
					arg_42_1.talkMaxDuration = var_45_22

					if var_45_22 + var_45_15 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_22 + var_45_15
					end
				end

				arg_42_1.text_.text = var_45_19
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031010", "story_v_out_113031.awb") ~= 0 then
					local var_45_23 = manager.audio:GetVoiceLength("story_v_out_113031", "113031010", "story_v_out_113031.awb") / 1000

					if var_45_23 + var_45_15 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_23 + var_45_15
					end

					if var_45_18.prefab_name ~= "" and arg_42_1.actors_[var_45_18.prefab_name] ~= nil then
						local var_45_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_18.prefab_name].transform, "story_v_out_113031", "113031010", "story_v_out_113031.awb")

						arg_42_1:RecordAudio("113031010", var_45_24)
						arg_42_1:RecordAudio("113031010", var_45_24)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_113031", "113031010", "story_v_out_113031.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_113031", "113031010", "story_v_out_113031.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_25 = math.max(var_45_16, arg_42_1.talkMaxDuration)

			if var_45_15 <= arg_42_1.time_ and arg_42_1.time_ < var_45_15 + var_45_25 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_15) / var_45_25

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_15 + var_45_25 and arg_42_1.time_ < var_45_15 + var_45_25 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play113031011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 113031011
		arg_46_1.duration_ = 2.1

		local var_46_0 = {
			ja = 1.999999999999,
			ko = 2.1,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_46_0:Play113031012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1038ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1038ui_story == nil then
				arg_46_1.var_.characterEffect1038ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.2

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect1038ui_story and not isNil(var_49_0) then
					local var_49_4 = Mathf.Lerp(0, 0.5, var_49_3)

					arg_46_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1038ui_story.fillRatio = var_49_4
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1038ui_story then
				local var_49_5 = 0.5

				arg_46_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1038ui_story.fillRatio = var_49_5
			end

			local var_49_6 = "1041ui_story"

			if arg_46_1.actors_[var_49_6] == nil then
				local var_49_7 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_49_7) then
					local var_49_8 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_46_1.stage_.transform)

					var_49_8.name = var_49_6
					var_49_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_46_1.actors_[var_49_6] = var_49_8

					local var_49_9 = var_49_8:GetComponentInChildren(typeof(CharacterEffect))

					var_49_9.enabled = true

					local var_49_10 = GameObjectTools.GetOrAddComponent(var_49_8, typeof(DynamicBoneHelper))

					if var_49_10 then
						var_49_10:EnableDynamicBone(false)
					end

					arg_46_1:ShowWeapon(var_49_9.transform, false)

					arg_46_1.var_[var_49_6 .. "Animator"] = var_49_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_46_1.var_[var_49_6 .. "Animator"].applyRootMotion = true
					arg_46_1.var_[var_49_6 .. "LipSync"] = var_49_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_49_11 = arg_46_1.actors_["1041ui_story"].transform
			local var_49_12 = 0

			if var_49_12 < arg_46_1.time_ and arg_46_1.time_ <= var_49_12 + arg_49_0 then
				arg_46_1.var_.moveOldPos1041ui_story = var_49_11.localPosition
			end

			local var_49_13 = 0.001

			if var_49_12 <= arg_46_1.time_ and arg_46_1.time_ < var_49_12 + var_49_13 then
				local var_49_14 = (arg_46_1.time_ - var_49_12) / var_49_13
				local var_49_15 = Vector3.New(0.7, -1.11, -5.9)

				var_49_11.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1041ui_story, var_49_15, var_49_14)

				local var_49_16 = manager.ui.mainCamera.transform.position - var_49_11.position

				var_49_11.forward = Vector3.New(var_49_16.x, var_49_16.y, var_49_16.z)

				local var_49_17 = var_49_11.localEulerAngles

				var_49_17.z = 0
				var_49_17.x = 0
				var_49_11.localEulerAngles = var_49_17
			end

			if arg_46_1.time_ >= var_49_12 + var_49_13 and arg_46_1.time_ < var_49_12 + var_49_13 + arg_49_0 then
				var_49_11.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_49_18 = manager.ui.mainCamera.transform.position - var_49_11.position

				var_49_11.forward = Vector3.New(var_49_18.x, var_49_18.y, var_49_18.z)

				local var_49_19 = var_49_11.localEulerAngles

				var_49_19.z = 0
				var_49_19.x = 0
				var_49_11.localEulerAngles = var_49_19
			end

			local var_49_20 = 0

			if var_49_20 < arg_46_1.time_ and arg_46_1.time_ <= var_49_20 + arg_49_0 then
				arg_46_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_49_21 = 0

			if var_49_21 < arg_46_1.time_ and arg_46_1.time_ <= var_49_21 + arg_49_0 then
				arg_46_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_49_22 = arg_46_1.actors_["1041ui_story"]
			local var_49_23 = 0

			if var_49_23 < arg_46_1.time_ and arg_46_1.time_ <= var_49_23 + arg_49_0 and not isNil(var_49_22) and arg_46_1.var_.characterEffect1041ui_story == nil then
				arg_46_1.var_.characterEffect1041ui_story = var_49_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_24 = 0.2

			if var_49_23 <= arg_46_1.time_ and arg_46_1.time_ < var_49_23 + var_49_24 and not isNil(var_49_22) then
				local var_49_25 = (arg_46_1.time_ - var_49_23) / var_49_24

				if arg_46_1.var_.characterEffect1041ui_story and not isNil(var_49_22) then
					arg_46_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_23 + var_49_24 and arg_46_1.time_ < var_49_23 + var_49_24 + arg_49_0 and not isNil(var_49_22) and arg_46_1.var_.characterEffect1041ui_story then
				arg_46_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_49_26 = 0
			local var_49_27 = 0.2

			if var_49_26 < arg_46_1.time_ and arg_46_1.time_ <= var_49_26 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_28 = arg_46_1:FormatText(StoryNameCfg[208].name)

				arg_46_1.leftNameTxt_.text = var_49_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_29 = arg_46_1:GetWordFromCfg(113031011)
				local var_49_30 = arg_46_1:FormatText(var_49_29.content)

				arg_46_1.text_.text = var_49_30

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_31 = 8
				local var_49_32 = utf8.len(var_49_30)
				local var_49_33 = var_49_31 <= 0 and var_49_27 or var_49_27 * (var_49_32 / var_49_31)

				if var_49_33 > 0 and var_49_27 < var_49_33 then
					arg_46_1.talkMaxDuration = var_49_33

					if var_49_33 + var_49_26 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_33 + var_49_26
					end
				end

				arg_46_1.text_.text = var_49_30
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031011", "story_v_out_113031.awb") ~= 0 then
					local var_49_34 = manager.audio:GetVoiceLength("story_v_out_113031", "113031011", "story_v_out_113031.awb") / 1000

					if var_49_34 + var_49_26 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_34 + var_49_26
					end

					if var_49_29.prefab_name ~= "" and arg_46_1.actors_[var_49_29.prefab_name] ~= nil then
						local var_49_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_29.prefab_name].transform, "story_v_out_113031", "113031011", "story_v_out_113031.awb")

						arg_46_1:RecordAudio("113031011", var_49_35)
						arg_46_1:RecordAudio("113031011", var_49_35)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_113031", "113031011", "story_v_out_113031.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_113031", "113031011", "story_v_out_113031.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_36 = math.max(var_49_27, arg_46_1.talkMaxDuration)

			if var_49_26 <= arg_46_1.time_ and arg_46_1.time_ < var_49_26 + var_49_36 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_26) / var_49_36

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_26 + var_49_36 and arg_46_1.time_ < var_49_26 + var_49_36 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play113031012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 113031012
		arg_50_1.duration_ = 1.57

		local var_50_0 = {
			ja = 1.466,
			ko = 1.566,
			zh = 1.266,
			en = 1.1
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
				arg_50_0:Play113031013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1041ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1041ui_story == nil then
				arg_50_1.var_.characterEffect1041ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.2

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect1041ui_story and not isNil(var_53_0) then
					local var_53_4 = Mathf.Lerp(0, 0.5, var_53_3)

					arg_50_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1041ui_story.fillRatio = var_53_4
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1041ui_story then
				local var_53_5 = 0.5

				arg_50_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1041ui_story.fillRatio = var_53_5
			end

			local var_53_6 = arg_50_1.actors_["1041ui_story"].transform
			local var_53_7 = 0

			if var_53_7 < arg_50_1.time_ and arg_50_1.time_ <= var_53_7 + arg_53_0 then
				arg_50_1.var_.moveOldPos1041ui_story = var_53_6.localPosition
			end

			local var_53_8 = 0.001

			if var_53_7 <= arg_50_1.time_ and arg_50_1.time_ < var_53_7 + var_53_8 then
				local var_53_9 = (arg_50_1.time_ - var_53_7) / var_53_8
				local var_53_10 = Vector3.New(0, 100, 0)

				var_53_6.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1041ui_story, var_53_10, var_53_9)

				local var_53_11 = manager.ui.mainCamera.transform.position - var_53_6.position

				var_53_6.forward = Vector3.New(var_53_11.x, var_53_11.y, var_53_11.z)

				local var_53_12 = var_53_6.localEulerAngles

				var_53_12.z = 0
				var_53_12.x = 0
				var_53_6.localEulerAngles = var_53_12
			end

			if arg_50_1.time_ >= var_53_7 + var_53_8 and arg_50_1.time_ < var_53_7 + var_53_8 + arg_53_0 then
				var_53_6.localPosition = Vector3.New(0, 100, 0)

				local var_53_13 = manager.ui.mainCamera.transform.position - var_53_6.position

				var_53_6.forward = Vector3.New(var_53_13.x, var_53_13.y, var_53_13.z)

				local var_53_14 = var_53_6.localEulerAngles

				var_53_14.z = 0
				var_53_14.x = 0
				var_53_6.localEulerAngles = var_53_14
			end

			local var_53_15 = arg_50_1.actors_["1038ui_story"].transform
			local var_53_16 = 0

			if var_53_16 < arg_50_1.time_ and arg_50_1.time_ <= var_53_16 + arg_53_0 then
				arg_50_1.var_.moveOldPos1038ui_story = var_53_15.localPosition
			end

			local var_53_17 = 0.001

			if var_53_16 <= arg_50_1.time_ and arg_50_1.time_ < var_53_16 + var_53_17 then
				local var_53_18 = (arg_50_1.time_ - var_53_16) / var_53_17
				local var_53_19 = Vector3.New(0, 100, 0)

				var_53_15.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1038ui_story, var_53_19, var_53_18)

				local var_53_20 = manager.ui.mainCamera.transform.position - var_53_15.position

				var_53_15.forward = Vector3.New(var_53_20.x, var_53_20.y, var_53_20.z)

				local var_53_21 = var_53_15.localEulerAngles

				var_53_21.z = 0
				var_53_21.x = 0
				var_53_15.localEulerAngles = var_53_21
			end

			if arg_50_1.time_ >= var_53_16 + var_53_17 and arg_50_1.time_ < var_53_16 + var_53_17 + arg_53_0 then
				var_53_15.localPosition = Vector3.New(0, 100, 0)

				local var_53_22 = manager.ui.mainCamera.transform.position - var_53_15.position

				var_53_15.forward = Vector3.New(var_53_22.x, var_53_22.y, var_53_22.z)

				local var_53_23 = var_53_15.localEulerAngles

				var_53_23.z = 0
				var_53_23.x = 0
				var_53_15.localEulerAngles = var_53_23
			end

			local var_53_24 = 0
			local var_53_25 = 0.2

			if var_53_24 < arg_50_1.time_ and arg_50_1.time_ <= var_53_24 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_26 = arg_50_1:FormatText(StoryNameCfg[210].name)

				arg_50_1.leftNameTxt_.text = var_53_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_27 = arg_50_1:GetWordFromCfg(113031012)
				local var_53_28 = arg_50_1:FormatText(var_53_27.content)

				arg_50_1.text_.text = var_53_28

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_29 = 5
				local var_53_30 = utf8.len(var_53_28)
				local var_53_31 = var_53_29 <= 0 and var_53_25 or var_53_25 * (var_53_30 / var_53_29)

				if var_53_31 > 0 and var_53_25 < var_53_31 then
					arg_50_1.talkMaxDuration = var_53_31

					if var_53_31 + var_53_24 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_31 + var_53_24
					end
				end

				arg_50_1.text_.text = var_53_28
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031012", "story_v_out_113031.awb") ~= 0 then
					local var_53_32 = manager.audio:GetVoiceLength("story_v_out_113031", "113031012", "story_v_out_113031.awb") / 1000

					if var_53_32 + var_53_24 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_32 + var_53_24
					end

					if var_53_27.prefab_name ~= "" and arg_50_1.actors_[var_53_27.prefab_name] ~= nil then
						local var_53_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_27.prefab_name].transform, "story_v_out_113031", "113031012", "story_v_out_113031.awb")

						arg_50_1:RecordAudio("113031012", var_53_33)
						arg_50_1:RecordAudio("113031012", var_53_33)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_113031", "113031012", "story_v_out_113031.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_113031", "113031012", "story_v_out_113031.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_34 = math.max(var_53_25, arg_50_1.talkMaxDuration)

			if var_53_24 <= arg_50_1.time_ and arg_50_1.time_ < var_53_24 + var_53_34 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_24) / var_53_34

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_24 + var_53_34 and arg_50_1.time_ < var_53_24 + var_53_34 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play113031013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 113031013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play113031014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 0.8

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_2 = arg_54_1:GetWordFromCfg(113031013)
				local var_57_3 = arg_54_1:FormatText(var_57_2.content)

				arg_54_1.text_.text = var_57_3

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 32
				local var_57_5 = utf8.len(var_57_3)
				local var_57_6 = var_57_4 <= 0 and var_57_1 or var_57_1 * (var_57_5 / var_57_4)

				if var_57_6 > 0 and var_57_1 < var_57_6 then
					arg_54_1.talkMaxDuration = var_57_6

					if var_57_6 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_6 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_3
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_7 and arg_54_1.time_ < var_57_0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play113031014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 113031014
		arg_58_1.duration_ = 5.53

		local var_58_0 = {
			ja = 4.3,
			ko = 5.533,
			zh = 3.233,
			en = 2.933
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
				arg_58_0:Play113031015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 0.4

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[210].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:GetWordFromCfg(113031014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031014", "story_v_out_113031.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_113031", "113031014", "story_v_out_113031.awb") / 1000

					if var_61_8 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_0
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_113031", "113031014", "story_v_out_113031.awb")

						arg_58_1:RecordAudio("113031014", var_61_9)
						arg_58_1:RecordAudio("113031014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_113031", "113031014", "story_v_out_113031.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_113031", "113031014", "story_v_out_113031.awb")
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
	Play113031015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 113031015
		arg_62_1.duration_ = 7.67

		local var_62_0 = {
			ja = 7.666,
			ko = 5.533,
			zh = 5.8,
			en = 6.5
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
				arg_62_0:Play113031016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_65_2 = arg_62_1.actors_["1038ui_story"]
			local var_65_3 = 0

			if var_65_3 < arg_62_1.time_ and arg_62_1.time_ <= var_65_3 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect1038ui_story == nil then
				arg_62_1.var_.characterEffect1038ui_story = var_65_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_4 = 0.2

			if var_65_3 <= arg_62_1.time_ and arg_62_1.time_ < var_65_3 + var_65_4 and not isNil(var_65_2) then
				local var_65_5 = (arg_62_1.time_ - var_65_3) / var_65_4

				if arg_62_1.var_.characterEffect1038ui_story and not isNil(var_65_2) then
					arg_62_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_3 + var_65_4 and arg_62_1.time_ < var_65_3 + var_65_4 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect1038ui_story then
				arg_62_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_65_6 = arg_62_1.actors_["1038ui_story"].transform
			local var_65_7 = 0

			if var_65_7 < arg_62_1.time_ and arg_62_1.time_ <= var_65_7 + arg_65_0 then
				arg_62_1.var_.moveOldPos1038ui_story = var_65_6.localPosition
			end

			local var_65_8 = 0.001

			if var_65_7 <= arg_62_1.time_ and arg_62_1.time_ < var_65_7 + var_65_8 then
				local var_65_9 = (arg_62_1.time_ - var_65_7) / var_65_8
				local var_65_10 = Vector3.New(-0.7, -1.11, -5.9)

				var_65_6.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1038ui_story, var_65_10, var_65_9)

				local var_65_11 = manager.ui.mainCamera.transform.position - var_65_6.position

				var_65_6.forward = Vector3.New(var_65_11.x, var_65_11.y, var_65_11.z)

				local var_65_12 = var_65_6.localEulerAngles

				var_65_12.z = 0
				var_65_12.x = 0
				var_65_6.localEulerAngles = var_65_12
			end

			if arg_62_1.time_ >= var_65_7 + var_65_8 and arg_62_1.time_ < var_65_7 + var_65_8 + arg_65_0 then
				var_65_6.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_65_13 = manager.ui.mainCamera.transform.position - var_65_6.position

				var_65_6.forward = Vector3.New(var_65_13.x, var_65_13.y, var_65_13.z)

				local var_65_14 = var_65_6.localEulerAngles

				var_65_14.z = 0
				var_65_14.x = 0
				var_65_6.localEulerAngles = var_65_14
			end

			local var_65_15 = 0
			local var_65_16 = 0.65

			if var_65_15 < arg_62_1.time_ and arg_62_1.time_ <= var_65_15 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_17 = arg_62_1:FormatText(StoryNameCfg[94].name)

				arg_62_1.leftNameTxt_.text = var_65_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_18 = arg_62_1:GetWordFromCfg(113031015)
				local var_65_19 = arg_62_1:FormatText(var_65_18.content)

				arg_62_1.text_.text = var_65_19

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_20 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031015", "story_v_out_113031.awb") ~= 0 then
					local var_65_23 = manager.audio:GetVoiceLength("story_v_out_113031", "113031015", "story_v_out_113031.awb") / 1000

					if var_65_23 + var_65_15 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_23 + var_65_15
					end

					if var_65_18.prefab_name ~= "" and arg_62_1.actors_[var_65_18.prefab_name] ~= nil then
						local var_65_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_18.prefab_name].transform, "story_v_out_113031", "113031015", "story_v_out_113031.awb")

						arg_62_1:RecordAudio("113031015", var_65_24)
						arg_62_1:RecordAudio("113031015", var_65_24)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_113031", "113031015", "story_v_out_113031.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_113031", "113031015", "story_v_out_113031.awb")
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
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play113031016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 113031016
		arg_66_1.duration_ = 14.9

		local var_66_0 = {
			ja = 14.9,
			ko = 10.4,
			zh = 10.9,
			en = 13.733
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
				arg_66_0:Play113031017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_69_1 = 0
			local var_69_2 = 1.25

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_3 = arg_66_1:FormatText(StoryNameCfg[94].name)

				arg_66_1.leftNameTxt_.text = var_69_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_4 = arg_66_1:GetWordFromCfg(113031016)
				local var_69_5 = arg_66_1:FormatText(var_69_4.content)

				arg_66_1.text_.text = var_69_5

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_6 = 46
				local var_69_7 = utf8.len(var_69_5)
				local var_69_8 = var_69_6 <= 0 and var_69_2 or var_69_2 * (var_69_7 / var_69_6)

				if var_69_8 > 0 and var_69_2 < var_69_8 then
					arg_66_1.talkMaxDuration = var_69_8

					if var_69_8 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_1
					end
				end

				arg_66_1.text_.text = var_69_5
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031016", "story_v_out_113031.awb") ~= 0 then
					local var_69_9 = manager.audio:GetVoiceLength("story_v_out_113031", "113031016", "story_v_out_113031.awb") / 1000

					if var_69_9 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_1
					end

					if var_69_4.prefab_name ~= "" and arg_66_1.actors_[var_69_4.prefab_name] ~= nil then
						local var_69_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_4.prefab_name].transform, "story_v_out_113031", "113031016", "story_v_out_113031.awb")

						arg_66_1:RecordAudio("113031016", var_69_10)
						arg_66_1:RecordAudio("113031016", var_69_10)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_113031", "113031016", "story_v_out_113031.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_113031", "113031016", "story_v_out_113031.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_11 = math.max(var_69_2, arg_66_1.talkMaxDuration)

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_11 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_1) / var_69_11

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_1 + var_69_11 and arg_66_1.time_ < var_69_1 + var_69_11 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play113031017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 113031017
		arg_70_1.duration_ = 10.53

		local var_70_0 = {
			ja = 5.4,
			ko = 10.533,
			zh = 7.9,
			en = 8.466
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
				arg_70_0:Play113031018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1038ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1038ui_story == nil then
				arg_70_1.var_.characterEffect1038ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect1038ui_story and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1038ui_story.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1038ui_story then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1038ui_story.fillRatio = var_73_5
			end

			local var_73_6 = 0

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_73_7 = arg_70_1.actors_["1041ui_story"]
			local var_73_8 = 0

			if var_73_8 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 and not isNil(var_73_7) and arg_70_1.var_.characterEffect1041ui_story == nil then
				arg_70_1.var_.characterEffect1041ui_story = var_73_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_9 = 0.2

			if var_73_8 <= arg_70_1.time_ and arg_70_1.time_ < var_73_8 + var_73_9 and not isNil(var_73_7) then
				local var_73_10 = (arg_70_1.time_ - var_73_8) / var_73_9

				if arg_70_1.var_.characterEffect1041ui_story and not isNil(var_73_7) then
					arg_70_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_8 + var_73_9 and arg_70_1.time_ < var_73_8 + var_73_9 + arg_73_0 and not isNil(var_73_7) and arg_70_1.var_.characterEffect1041ui_story then
				arg_70_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_73_11 = arg_70_1.actors_["1041ui_story"].transform
			local var_73_12 = 0

			if var_73_12 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 then
				arg_70_1.var_.moveOldPos1041ui_story = var_73_11.localPosition
			end

			local var_73_13 = 0.001

			if var_73_12 <= arg_70_1.time_ and arg_70_1.time_ < var_73_12 + var_73_13 then
				local var_73_14 = (arg_70_1.time_ - var_73_12) / var_73_13
				local var_73_15 = Vector3.New(0.7, -1.11, -5.9)

				var_73_11.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1041ui_story, var_73_15, var_73_14)

				local var_73_16 = manager.ui.mainCamera.transform.position - var_73_11.position

				var_73_11.forward = Vector3.New(var_73_16.x, var_73_16.y, var_73_16.z)

				local var_73_17 = var_73_11.localEulerAngles

				var_73_17.z = 0
				var_73_17.x = 0
				var_73_11.localEulerAngles = var_73_17
			end

			if arg_70_1.time_ >= var_73_12 + var_73_13 and arg_70_1.time_ < var_73_12 + var_73_13 + arg_73_0 then
				var_73_11.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_73_18 = manager.ui.mainCamera.transform.position - var_73_11.position

				var_73_11.forward = Vector3.New(var_73_18.x, var_73_18.y, var_73_18.z)

				local var_73_19 = var_73_11.localEulerAngles

				var_73_19.z = 0
				var_73_19.x = 0
				var_73_11.localEulerAngles = var_73_19
			end

			local var_73_20 = 0
			local var_73_21 = 1.05

			if var_73_20 < arg_70_1.time_ and arg_70_1.time_ <= var_73_20 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_22 = arg_70_1:FormatText(StoryNameCfg[208].name)

				arg_70_1.leftNameTxt_.text = var_73_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_23 = arg_70_1:GetWordFromCfg(113031017)
				local var_73_24 = arg_70_1:FormatText(var_73_23.content)

				arg_70_1.text_.text = var_73_24

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_25 = 42
				local var_73_26 = utf8.len(var_73_24)
				local var_73_27 = var_73_25 <= 0 and var_73_21 or var_73_21 * (var_73_26 / var_73_25)

				if var_73_27 > 0 and var_73_21 < var_73_27 then
					arg_70_1.talkMaxDuration = var_73_27

					if var_73_27 + var_73_20 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_27 + var_73_20
					end
				end

				arg_70_1.text_.text = var_73_24
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031017", "story_v_out_113031.awb") ~= 0 then
					local var_73_28 = manager.audio:GetVoiceLength("story_v_out_113031", "113031017", "story_v_out_113031.awb") / 1000

					if var_73_28 + var_73_20 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_28 + var_73_20
					end

					if var_73_23.prefab_name ~= "" and arg_70_1.actors_[var_73_23.prefab_name] ~= nil then
						local var_73_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_23.prefab_name].transform, "story_v_out_113031", "113031017", "story_v_out_113031.awb")

						arg_70_1:RecordAudio("113031017", var_73_29)
						arg_70_1:RecordAudio("113031017", var_73_29)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_113031", "113031017", "story_v_out_113031.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_113031", "113031017", "story_v_out_113031.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_30 = math.max(var_73_21, arg_70_1.talkMaxDuration)

			if var_73_20 <= arg_70_1.time_ and arg_70_1.time_ < var_73_20 + var_73_30 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_20) / var_73_30

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_20 + var_73_30 and arg_70_1.time_ < var_73_20 + var_73_30 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play113031018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 113031018
		arg_74_1.duration_ = 7.8

		local var_74_0 = {
			ja = 7.8,
			ko = 7.7,
			zh = 6.133,
			en = 5.4
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
				arg_74_0:Play113031019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_77_1 = 0
			local var_77_2 = 0.725

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_3 = arg_74_1:FormatText(StoryNameCfg[208].name)

				arg_74_1.leftNameTxt_.text = var_77_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_4 = arg_74_1:GetWordFromCfg(113031018)
				local var_77_5 = arg_74_1:FormatText(var_77_4.content)

				arg_74_1.text_.text = var_77_5

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_6 = 29
				local var_77_7 = utf8.len(var_77_5)
				local var_77_8 = var_77_6 <= 0 and var_77_2 or var_77_2 * (var_77_7 / var_77_6)

				if var_77_8 > 0 and var_77_2 < var_77_8 then
					arg_74_1.talkMaxDuration = var_77_8

					if var_77_8 + var_77_1 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_1
					end
				end

				arg_74_1.text_.text = var_77_5
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031018", "story_v_out_113031.awb") ~= 0 then
					local var_77_9 = manager.audio:GetVoiceLength("story_v_out_113031", "113031018", "story_v_out_113031.awb") / 1000

					if var_77_9 + var_77_1 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_1
					end

					if var_77_4.prefab_name ~= "" and arg_74_1.actors_[var_77_4.prefab_name] ~= nil then
						local var_77_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_4.prefab_name].transform, "story_v_out_113031", "113031018", "story_v_out_113031.awb")

						arg_74_1:RecordAudio("113031018", var_77_10)
						arg_74_1:RecordAudio("113031018", var_77_10)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_113031", "113031018", "story_v_out_113031.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_113031", "113031018", "story_v_out_113031.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_11 = math.max(var_77_2, arg_74_1.talkMaxDuration)

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_11 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_1) / var_77_11

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_1 + var_77_11 and arg_74_1.time_ < var_77_1 + var_77_11 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play113031019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 113031019
		arg_78_1.duration_ = 4.6

		local var_78_0 = {
			ja = 4.066,
			ko = 2.966,
			zh = 2.866,
			en = 4.6
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
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play113031020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action2_1")
			end

			local var_81_2 = 0
			local var_81_3 = 0.3

			if var_81_2 < arg_78_1.time_ and arg_78_1.time_ <= var_81_2 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_4 = arg_78_1:FormatText(StoryNameCfg[208].name)

				arg_78_1.leftNameTxt_.text = var_81_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_5 = arg_78_1:GetWordFromCfg(113031019)
				local var_81_6 = arg_78_1:FormatText(var_81_5.content)

				arg_78_1.text_.text = var_81_6

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 12
				local var_81_8 = utf8.len(var_81_6)
				local var_81_9 = var_81_7 <= 0 and var_81_3 or var_81_3 * (var_81_8 / var_81_7)

				if var_81_9 > 0 and var_81_3 < var_81_9 then
					arg_78_1.talkMaxDuration = var_81_9

					if var_81_9 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_2
					end
				end

				arg_78_1.text_.text = var_81_6
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031019", "story_v_out_113031.awb") ~= 0 then
					local var_81_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031019", "story_v_out_113031.awb") / 1000

					if var_81_10 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_2
					end

					if var_81_5.prefab_name ~= "" and arg_78_1.actors_[var_81_5.prefab_name] ~= nil then
						local var_81_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_5.prefab_name].transform, "story_v_out_113031", "113031019", "story_v_out_113031.awb")

						arg_78_1:RecordAudio("113031019", var_81_11)
						arg_78_1:RecordAudio("113031019", var_81_11)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_113031", "113031019", "story_v_out_113031.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_113031", "113031019", "story_v_out_113031.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_12 = math.max(var_81_3, arg_78_1.talkMaxDuration)

			if var_81_2 <= arg_78_1.time_ and arg_78_1.time_ < var_81_2 + var_81_12 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_2) / var_81_12

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_2 + var_81_12 and arg_78_1.time_ < var_81_2 + var_81_12 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play113031020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 113031020
		arg_82_1.duration_ = 2.63

		local var_82_0 = {
			ja = 2.633,
			ko = 1,
			zh = 1,
			en = 0.999999999999
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
				arg_82_0:Play113031021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1041ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1041ui_story == nil then
				arg_82_1.var_.characterEffect1041ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.2

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect1041ui_story and not isNil(var_85_0) then
					local var_85_4 = Mathf.Lerp(0, 0.5, var_85_3)

					arg_82_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1041ui_story.fillRatio = var_85_4
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1041ui_story then
				local var_85_5 = 0.5

				arg_82_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1041ui_story.fillRatio = var_85_5
			end

			local var_85_6 = arg_82_1.actors_["1038ui_story"]
			local var_85_7 = 0

			if var_85_7 < arg_82_1.time_ and arg_82_1.time_ <= var_85_7 + arg_85_0 and not isNil(var_85_6) and arg_82_1.var_.characterEffect1038ui_story == nil then
				arg_82_1.var_.characterEffect1038ui_story = var_85_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_8 = 0.2

			if var_85_7 <= arg_82_1.time_ and arg_82_1.time_ < var_85_7 + var_85_8 and not isNil(var_85_6) then
				local var_85_9 = (arg_82_1.time_ - var_85_7) / var_85_8

				if arg_82_1.var_.characterEffect1038ui_story and not isNil(var_85_6) then
					arg_82_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_7 + var_85_8 and arg_82_1.time_ < var_85_7 + var_85_8 + arg_85_0 and not isNil(var_85_6) and arg_82_1.var_.characterEffect1038ui_story then
				arg_82_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_85_10 = 0
			local var_85_11 = 0.175

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_12 = arg_82_1:FormatText(StoryNameCfg[94].name)

				arg_82_1.leftNameTxt_.text = var_85_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_13 = arg_82_1:GetWordFromCfg(113031020)
				local var_85_14 = arg_82_1:FormatText(var_85_13.content)

				arg_82_1.text_.text = var_85_14

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_15 = 3
				local var_85_16 = utf8.len(var_85_14)
				local var_85_17 = var_85_15 <= 0 and var_85_11 or var_85_11 * (var_85_16 / var_85_15)

				if var_85_17 > 0 and var_85_11 < var_85_17 then
					arg_82_1.talkMaxDuration = var_85_17

					if var_85_17 + var_85_10 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_17 + var_85_10
					end
				end

				arg_82_1.text_.text = var_85_14
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031020", "story_v_out_113031.awb") ~= 0 then
					local var_85_18 = manager.audio:GetVoiceLength("story_v_out_113031", "113031020", "story_v_out_113031.awb") / 1000

					if var_85_18 + var_85_10 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_18 + var_85_10
					end

					if var_85_13.prefab_name ~= "" and arg_82_1.actors_[var_85_13.prefab_name] ~= nil then
						local var_85_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_13.prefab_name].transform, "story_v_out_113031", "113031020", "story_v_out_113031.awb")

						arg_82_1:RecordAudio("113031020", var_85_19)
						arg_82_1:RecordAudio("113031020", var_85_19)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_113031", "113031020", "story_v_out_113031.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_113031", "113031020", "story_v_out_113031.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_20 = math.max(var_85_11, arg_82_1.talkMaxDuration)

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_20 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_10) / var_85_20

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_10 + var_85_20 and arg_82_1.time_ < var_85_10 + var_85_20 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play113031021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 113031021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play113031022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1038ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos1038ui_story = var_89_0.localPosition
			end

			local var_89_2 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2
				local var_89_4 = Vector3.New(0, 100, 0)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1038ui_story, var_89_4, var_89_3)

				local var_89_5 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_5.x, var_89_5.y, var_89_5.z)

				local var_89_6 = var_89_0.localEulerAngles

				var_89_6.z = 0
				var_89_6.x = 0
				var_89_0.localEulerAngles = var_89_6
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0, 100, 0)

				local var_89_7 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_7.x, var_89_7.y, var_89_7.z)

				local var_89_8 = var_89_0.localEulerAngles

				var_89_8.z = 0
				var_89_8.x = 0
				var_89_0.localEulerAngles = var_89_8
			end

			local var_89_9 = arg_86_1.actors_["1041ui_story"].transform
			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.var_.moveOldPos1041ui_story = var_89_9.localPosition
			end

			local var_89_11 = 0.001

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_11 then
				local var_89_12 = (arg_86_1.time_ - var_89_10) / var_89_11
				local var_89_13 = Vector3.New(0, 100, 0)

				var_89_9.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1041ui_story, var_89_13, var_89_12)

				local var_89_14 = manager.ui.mainCamera.transform.position - var_89_9.position

				var_89_9.forward = Vector3.New(var_89_14.x, var_89_14.y, var_89_14.z)

				local var_89_15 = var_89_9.localEulerAngles

				var_89_15.z = 0
				var_89_15.x = 0
				var_89_9.localEulerAngles = var_89_15
			end

			if arg_86_1.time_ >= var_89_10 + var_89_11 and arg_86_1.time_ < var_89_10 + var_89_11 + arg_89_0 then
				var_89_9.localPosition = Vector3.New(0, 100, 0)

				local var_89_16 = manager.ui.mainCamera.transform.position - var_89_9.position

				var_89_9.forward = Vector3.New(var_89_16.x, var_89_16.y, var_89_16.z)

				local var_89_17 = var_89_9.localEulerAngles

				var_89_17.z = 0
				var_89_17.x = 0
				var_89_9.localEulerAngles = var_89_17
			end

			local var_89_18 = 0
			local var_89_19 = 1.4

			if var_89_18 < arg_86_1.time_ and arg_86_1.time_ <= var_89_18 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_20 = arg_86_1:GetWordFromCfg(113031021)
				local var_89_21 = arg_86_1:FormatText(var_89_20.content)

				arg_86_1.text_.text = var_89_21

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_22 = 56
				local var_89_23 = utf8.len(var_89_21)
				local var_89_24 = var_89_22 <= 0 and var_89_19 or var_89_19 * (var_89_23 / var_89_22)

				if var_89_24 > 0 and var_89_19 < var_89_24 then
					arg_86_1.talkMaxDuration = var_89_24

					if var_89_24 + var_89_18 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_24 + var_89_18
					end
				end

				arg_86_1.text_.text = var_89_21
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_25 = math.max(var_89_19, arg_86_1.talkMaxDuration)

			if var_89_18 <= arg_86_1.time_ and arg_86_1.time_ < var_89_18 + var_89_25 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_18) / var_89_25

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_18 + var_89_25 and arg_86_1.time_ < var_89_18 + var_89_25 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play113031022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 113031022
		arg_90_1.duration_ = 14.3

		local var_90_0 = {
			ja = 12.3,
			ko = 11.533,
			zh = 14.3,
			en = 14.166
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play113031023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = "1042ui_story"

			if arg_90_1.actors_[var_93_0] == nil then
				local var_93_1 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_93_1) then
					local var_93_2 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_90_1.stage_.transform)

					var_93_2.name = var_93_0
					var_93_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_90_1.actors_[var_93_0] = var_93_2

					local var_93_3 = var_93_2:GetComponentInChildren(typeof(CharacterEffect))

					var_93_3.enabled = true

					local var_93_4 = GameObjectTools.GetOrAddComponent(var_93_2, typeof(DynamicBoneHelper))

					if var_93_4 then
						var_93_4:EnableDynamicBone(false)
					end

					arg_90_1:ShowWeapon(var_93_3.transform, false)

					arg_90_1.var_[var_93_0 .. "Animator"] = var_93_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_90_1.var_[var_93_0 .. "Animator"].applyRootMotion = true
					arg_90_1.var_[var_93_0 .. "LipSync"] = var_93_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_93_5 = arg_90_1.actors_["1042ui_story"].transform
			local var_93_6 = 0

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.var_.moveOldPos1042ui_story = var_93_5.localPosition
			end

			local var_93_7 = 0.001

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_7 then
				local var_93_8 = (arg_90_1.time_ - var_93_6) / var_93_7
				local var_93_9 = Vector3.New(-0.7, -1.06, -6.2)

				var_93_5.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1042ui_story, var_93_9, var_93_8)

				local var_93_10 = manager.ui.mainCamera.transform.position - var_93_5.position

				var_93_5.forward = Vector3.New(var_93_10.x, var_93_10.y, var_93_10.z)

				local var_93_11 = var_93_5.localEulerAngles

				var_93_11.z = 0
				var_93_11.x = 0
				var_93_5.localEulerAngles = var_93_11
			end

			if arg_90_1.time_ >= var_93_6 + var_93_7 and arg_90_1.time_ < var_93_6 + var_93_7 + arg_93_0 then
				var_93_5.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_93_12 = manager.ui.mainCamera.transform.position - var_93_5.position

				var_93_5.forward = Vector3.New(var_93_12.x, var_93_12.y, var_93_12.z)

				local var_93_13 = var_93_5.localEulerAngles

				var_93_13.z = 0
				var_93_13.x = 0
				var_93_5.localEulerAngles = var_93_13
			end

			local var_93_14 = 0

			if var_93_14 < arg_90_1.time_ and arg_90_1.time_ <= var_93_14 + arg_93_0 then
				arg_90_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_93_15 = 0

			if var_93_15 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 then
				arg_90_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_93_16 = arg_90_1.actors_["1042ui_story"]
			local var_93_17 = 0

			if var_93_17 < arg_90_1.time_ and arg_90_1.time_ <= var_93_17 + arg_93_0 and not isNil(var_93_16) and arg_90_1.var_.characterEffect1042ui_story == nil then
				arg_90_1.var_.characterEffect1042ui_story = var_93_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_18 = 0.2

			if var_93_17 <= arg_90_1.time_ and arg_90_1.time_ < var_93_17 + var_93_18 and not isNil(var_93_16) then
				local var_93_19 = (arg_90_1.time_ - var_93_17) / var_93_18

				if arg_90_1.var_.characterEffect1042ui_story and not isNil(var_93_16) then
					arg_90_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_17 + var_93_18 and arg_90_1.time_ < var_93_17 + var_93_18 + arg_93_0 and not isNil(var_93_16) and arg_90_1.var_.characterEffect1042ui_story then
				arg_90_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_93_20 = 0
			local var_93_21 = 1.35

			if var_93_20 < arg_90_1.time_ and arg_90_1.time_ <= var_93_20 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_22 = arg_90_1:FormatText(StoryNameCfg[205].name)

				arg_90_1.leftNameTxt_.text = var_93_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_23 = arg_90_1:GetWordFromCfg(113031022)
				local var_93_24 = arg_90_1:FormatText(var_93_23.content)

				arg_90_1.text_.text = var_93_24

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_25 = 54
				local var_93_26 = utf8.len(var_93_24)
				local var_93_27 = var_93_25 <= 0 and var_93_21 or var_93_21 * (var_93_26 / var_93_25)

				if var_93_27 > 0 and var_93_21 < var_93_27 then
					arg_90_1.talkMaxDuration = var_93_27

					if var_93_27 + var_93_20 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_27 + var_93_20
					end
				end

				arg_90_1.text_.text = var_93_24
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031022", "story_v_out_113031.awb") ~= 0 then
					local var_93_28 = manager.audio:GetVoiceLength("story_v_out_113031", "113031022", "story_v_out_113031.awb") / 1000

					if var_93_28 + var_93_20 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_28 + var_93_20
					end

					if var_93_23.prefab_name ~= "" and arg_90_1.actors_[var_93_23.prefab_name] ~= nil then
						local var_93_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_23.prefab_name].transform, "story_v_out_113031", "113031022", "story_v_out_113031.awb")

						arg_90_1:RecordAudio("113031022", var_93_29)
						arg_90_1:RecordAudio("113031022", var_93_29)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_113031", "113031022", "story_v_out_113031.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_113031", "113031022", "story_v_out_113031.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_30 = math.max(var_93_21, arg_90_1.talkMaxDuration)

			if var_93_20 <= arg_90_1.time_ and arg_90_1.time_ < var_93_20 + var_93_30 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_20) / var_93_30

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_20 + var_93_30 and arg_90_1.time_ < var_93_20 + var_93_30 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play113031023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 113031023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play113031024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1042ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1042ui_story == nil then
				arg_94_1.var_.characterEffect1042ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.2

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1042ui_story and not isNil(var_97_0) then
					local var_97_4 = Mathf.Lerp(0, 0.5, var_97_3)

					arg_94_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1042ui_story.fillRatio = var_97_4
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1042ui_story then
				local var_97_5 = 0.5

				arg_94_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1042ui_story.fillRatio = var_97_5
			end

			local var_97_6 = 0
			local var_97_7 = 0.225

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_8 = arg_94_1:FormatText(StoryNameCfg[7].name)

				arg_94_1.leftNameTxt_.text = var_97_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_9 = arg_94_1:GetWordFromCfg(113031023)
				local var_97_10 = arg_94_1:FormatText(var_97_9.content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 9
				local var_97_12 = utf8.len(var_97_10)
				local var_97_13 = var_97_11 <= 0 and var_97_7 or var_97_7 * (var_97_12 / var_97_11)

				if var_97_13 > 0 and var_97_7 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_6
					end
				end

				arg_94_1.text_.text = var_97_10
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_14 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_14 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_14

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_14 and arg_94_1.time_ < var_97_6 + var_97_14 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play113031024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 113031024
		arg_98_1.duration_ = 5.93

		local var_98_0 = {
			ja = 5.766,
			ko = 5.6,
			zh = 4.9,
			en = 5.933
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play113031025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_101_2 = arg_98_1.actors_["1041ui_story"]
			local var_101_3 = 0

			if var_101_3 < arg_98_1.time_ and arg_98_1.time_ <= var_101_3 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect1041ui_story == nil then
				arg_98_1.var_.characterEffect1041ui_story = var_101_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_4 = 0.2

			if var_101_3 <= arg_98_1.time_ and arg_98_1.time_ < var_101_3 + var_101_4 and not isNil(var_101_2) then
				local var_101_5 = (arg_98_1.time_ - var_101_3) / var_101_4

				if arg_98_1.var_.characterEffect1041ui_story and not isNil(var_101_2) then
					arg_98_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_3 + var_101_4 and arg_98_1.time_ < var_101_3 + var_101_4 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect1041ui_story then
				arg_98_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_101_6 = arg_98_1.actors_["1041ui_story"].transform
			local var_101_7 = 0

			if var_101_7 < arg_98_1.time_ and arg_98_1.time_ <= var_101_7 + arg_101_0 then
				arg_98_1.var_.moveOldPos1041ui_story = var_101_6.localPosition
			end

			local var_101_8 = 0.001

			if var_101_7 <= arg_98_1.time_ and arg_98_1.time_ < var_101_7 + var_101_8 then
				local var_101_9 = (arg_98_1.time_ - var_101_7) / var_101_8
				local var_101_10 = Vector3.New(0.7, -1.11, -5.9)

				var_101_6.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1041ui_story, var_101_10, var_101_9)

				local var_101_11 = manager.ui.mainCamera.transform.position - var_101_6.position

				var_101_6.forward = Vector3.New(var_101_11.x, var_101_11.y, var_101_11.z)

				local var_101_12 = var_101_6.localEulerAngles

				var_101_12.z = 0
				var_101_12.x = 0
				var_101_6.localEulerAngles = var_101_12
			end

			if arg_98_1.time_ >= var_101_7 + var_101_8 and arg_98_1.time_ < var_101_7 + var_101_8 + arg_101_0 then
				var_101_6.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_101_13 = manager.ui.mainCamera.transform.position - var_101_6.position

				var_101_6.forward = Vector3.New(var_101_13.x, var_101_13.y, var_101_13.z)

				local var_101_14 = var_101_6.localEulerAngles

				var_101_14.z = 0
				var_101_14.x = 0
				var_101_6.localEulerAngles = var_101_14
			end

			local var_101_15 = 0
			local var_101_16 = 0.525

			if var_101_15 < arg_98_1.time_ and arg_98_1.time_ <= var_101_15 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_17 = arg_98_1:FormatText(StoryNameCfg[208].name)

				arg_98_1.leftNameTxt_.text = var_101_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_18 = arg_98_1:GetWordFromCfg(113031024)
				local var_101_19 = arg_98_1:FormatText(var_101_18.content)

				arg_98_1.text_.text = var_101_19

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_20 = 20
				local var_101_21 = utf8.len(var_101_19)
				local var_101_22 = var_101_20 <= 0 and var_101_16 or var_101_16 * (var_101_21 / var_101_20)

				if var_101_22 > 0 and var_101_16 < var_101_22 then
					arg_98_1.talkMaxDuration = var_101_22

					if var_101_22 + var_101_15 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_22 + var_101_15
					end
				end

				arg_98_1.text_.text = var_101_19
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031024", "story_v_out_113031.awb") ~= 0 then
					local var_101_23 = manager.audio:GetVoiceLength("story_v_out_113031", "113031024", "story_v_out_113031.awb") / 1000

					if var_101_23 + var_101_15 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_23 + var_101_15
					end

					if var_101_18.prefab_name ~= "" and arg_98_1.actors_[var_101_18.prefab_name] ~= nil then
						local var_101_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_18.prefab_name].transform, "story_v_out_113031", "113031024", "story_v_out_113031.awb")

						arg_98_1:RecordAudio("113031024", var_101_24)
						arg_98_1:RecordAudio("113031024", var_101_24)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_113031", "113031024", "story_v_out_113031.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_113031", "113031024", "story_v_out_113031.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_25 = math.max(var_101_16, arg_98_1.talkMaxDuration)

			if var_101_15 <= arg_98_1.time_ and arg_98_1.time_ < var_101_15 + var_101_25 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_15) / var_101_25

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_15 + var_101_25 and arg_98_1.time_ < var_101_15 + var_101_25 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play113031025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 113031025
		arg_102_1.duration_ = 9.9

		local var_102_0 = {
			ja = 6.9,
			ko = 4.666,
			zh = 9,
			en = 9.9
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play113031026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1042ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos1042ui_story = var_105_0.localPosition
			end

			local var_105_2 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2
				local var_105_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1042ui_story, var_105_4, var_105_3)

				local var_105_5 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_5.x, var_105_5.y, var_105_5.z)

				local var_105_6 = var_105_0.localEulerAngles

				var_105_6.z = 0
				var_105_6.x = 0
				var_105_0.localEulerAngles = var_105_6
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_105_7 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_7.x, var_105_7.y, var_105_7.z)

				local var_105_8 = var_105_0.localEulerAngles

				var_105_8.z = 0
				var_105_8.x = 0
				var_105_0.localEulerAngles = var_105_8
			end

			local var_105_9 = 0

			if var_105_9 < arg_102_1.time_ and arg_102_1.time_ <= var_105_9 + arg_105_0 then
				arg_102_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_105_11 = arg_102_1.actors_["1042ui_story"]
			local var_105_12 = 0

			if var_105_12 < arg_102_1.time_ and arg_102_1.time_ <= var_105_12 + arg_105_0 and not isNil(var_105_11) and arg_102_1.var_.characterEffect1042ui_story == nil then
				arg_102_1.var_.characterEffect1042ui_story = var_105_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_13 = 0.2

			if var_105_12 <= arg_102_1.time_ and arg_102_1.time_ < var_105_12 + var_105_13 and not isNil(var_105_11) then
				local var_105_14 = (arg_102_1.time_ - var_105_12) / var_105_13

				if arg_102_1.var_.characterEffect1042ui_story and not isNil(var_105_11) then
					arg_102_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_12 + var_105_13 and arg_102_1.time_ < var_105_12 + var_105_13 + arg_105_0 and not isNil(var_105_11) and arg_102_1.var_.characterEffect1042ui_story then
				arg_102_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_105_15 = arg_102_1.actors_["1041ui_story"]
			local var_105_16 = 0

			if var_105_16 < arg_102_1.time_ and arg_102_1.time_ <= var_105_16 + arg_105_0 and not isNil(var_105_15) and arg_102_1.var_.characterEffect1041ui_story == nil then
				arg_102_1.var_.characterEffect1041ui_story = var_105_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_17 = 0.2

			if var_105_16 <= arg_102_1.time_ and arg_102_1.time_ < var_105_16 + var_105_17 and not isNil(var_105_15) then
				local var_105_18 = (arg_102_1.time_ - var_105_16) / var_105_17

				if arg_102_1.var_.characterEffect1041ui_story and not isNil(var_105_15) then
					local var_105_19 = Mathf.Lerp(0, 0.5, var_105_18)

					arg_102_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1041ui_story.fillRatio = var_105_19
				end
			end

			if arg_102_1.time_ >= var_105_16 + var_105_17 and arg_102_1.time_ < var_105_16 + var_105_17 + arg_105_0 and not isNil(var_105_15) and arg_102_1.var_.characterEffect1041ui_story then
				local var_105_20 = 0.5

				arg_102_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1041ui_story.fillRatio = var_105_20
			end

			local var_105_21 = 0
			local var_105_22 = 0.925

			if var_105_21 < arg_102_1.time_ and arg_102_1.time_ <= var_105_21 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_23 = arg_102_1:FormatText(StoryNameCfg[205].name)

				arg_102_1.leftNameTxt_.text = var_105_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_24 = arg_102_1:GetWordFromCfg(113031025)
				local var_105_25 = arg_102_1:FormatText(var_105_24.content)

				arg_102_1.text_.text = var_105_25

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_26 = 37
				local var_105_27 = utf8.len(var_105_25)
				local var_105_28 = var_105_26 <= 0 and var_105_22 or var_105_22 * (var_105_27 / var_105_26)

				if var_105_28 > 0 and var_105_22 < var_105_28 then
					arg_102_1.talkMaxDuration = var_105_28

					if var_105_28 + var_105_21 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_28 + var_105_21
					end
				end

				arg_102_1.text_.text = var_105_25
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031025", "story_v_out_113031.awb") ~= 0 then
					local var_105_29 = manager.audio:GetVoiceLength("story_v_out_113031", "113031025", "story_v_out_113031.awb") / 1000

					if var_105_29 + var_105_21 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_29 + var_105_21
					end

					if var_105_24.prefab_name ~= "" and arg_102_1.actors_[var_105_24.prefab_name] ~= nil then
						local var_105_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_24.prefab_name].transform, "story_v_out_113031", "113031025", "story_v_out_113031.awb")

						arg_102_1:RecordAudio("113031025", var_105_30)
						arg_102_1:RecordAudio("113031025", var_105_30)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_113031", "113031025", "story_v_out_113031.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_113031", "113031025", "story_v_out_113031.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_31 = math.max(var_105_22, arg_102_1.talkMaxDuration)

			if var_105_21 <= arg_102_1.time_ and arg_102_1.time_ < var_105_21 + var_105_31 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_21) / var_105_31

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_21 + var_105_31 and arg_102_1.time_ < var_105_21 + var_105_31 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play113031026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 113031026
		arg_106_1.duration_ = 2.5

		local var_106_0 = {
			ja = 2.5,
			ko = 1.999999999999,
			zh = 2.3,
			en = 2.5
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play113031027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_109_1 = 0
			local var_109_2 = 0.175

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_3 = arg_106_1:FormatText(StoryNameCfg[205].name)

				arg_106_1.leftNameTxt_.text = var_109_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_4 = arg_106_1:GetWordFromCfg(113031026)
				local var_109_5 = arg_106_1:FormatText(var_109_4.content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_6 = 7
				local var_109_7 = utf8.len(var_109_5)
				local var_109_8 = var_109_6 <= 0 and var_109_2 or var_109_2 * (var_109_7 / var_109_6)

				if var_109_8 > 0 and var_109_2 < var_109_8 then
					arg_106_1.talkMaxDuration = var_109_8

					if var_109_8 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_1
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031026", "story_v_out_113031.awb") ~= 0 then
					local var_109_9 = manager.audio:GetVoiceLength("story_v_out_113031", "113031026", "story_v_out_113031.awb") / 1000

					if var_109_9 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_1
					end

					if var_109_4.prefab_name ~= "" and arg_106_1.actors_[var_109_4.prefab_name] ~= nil then
						local var_109_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_4.prefab_name].transform, "story_v_out_113031", "113031026", "story_v_out_113031.awb")

						arg_106_1:RecordAudio("113031026", var_109_10)
						arg_106_1:RecordAudio("113031026", var_109_10)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_113031", "113031026", "story_v_out_113031.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_113031", "113031026", "story_v_out_113031.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_11 = math.max(var_109_2, arg_106_1.talkMaxDuration)

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_11 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_1) / var_109_11

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_1 + var_109_11 and arg_106_1.time_ < var_109_1 + var_109_11 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play113031027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 113031027
		arg_110_1.duration_ = 3.83

		local var_110_0 = {
			ja = 2.1,
			ko = 3.833,
			zh = 3.366,
			en = 3.2
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play113031028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1038ui_story"].transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPos1038ui_story = var_113_0.localPosition
			end

			local var_113_2 = 0.001

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2
				local var_113_4 = Vector3.New(0.7, -1.11, -5.9)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1038ui_story, var_113_4, var_113_3)

				local var_113_5 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_5.x, var_113_5.y, var_113_5.z)

				local var_113_6 = var_113_0.localEulerAngles

				var_113_6.z = 0
				var_113_6.x = 0
				var_113_0.localEulerAngles = var_113_6
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_113_7 = manager.ui.mainCamera.transform.position - var_113_0.position

				var_113_0.forward = Vector3.New(var_113_7.x, var_113_7.y, var_113_7.z)

				local var_113_8 = var_113_0.localEulerAngles

				var_113_8.z = 0
				var_113_8.x = 0
				var_113_0.localEulerAngles = var_113_8
			end

			local var_113_9 = 0

			if var_113_9 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 then
				arg_110_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_113_11 = arg_110_1.actors_["1038ui_story"]
			local var_113_12 = 0

			if var_113_12 < arg_110_1.time_ and arg_110_1.time_ <= var_113_12 + arg_113_0 and not isNil(var_113_11) and arg_110_1.var_.characterEffect1038ui_story == nil then
				arg_110_1.var_.characterEffect1038ui_story = var_113_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_13 = 0.2

			if var_113_12 <= arg_110_1.time_ and arg_110_1.time_ < var_113_12 + var_113_13 and not isNil(var_113_11) then
				local var_113_14 = (arg_110_1.time_ - var_113_12) / var_113_13

				if arg_110_1.var_.characterEffect1038ui_story and not isNil(var_113_11) then
					arg_110_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_12 + var_113_13 and arg_110_1.time_ < var_113_12 + var_113_13 + arg_113_0 and not isNil(var_113_11) and arg_110_1.var_.characterEffect1038ui_story then
				arg_110_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_113_15 = arg_110_1.actors_["1041ui_story"].transform
			local var_113_16 = 0

			if var_113_16 < arg_110_1.time_ and arg_110_1.time_ <= var_113_16 + arg_113_0 then
				arg_110_1.var_.moveOldPos1041ui_story = var_113_15.localPosition
			end

			local var_113_17 = 0.001

			if var_113_16 <= arg_110_1.time_ and arg_110_1.time_ < var_113_16 + var_113_17 then
				local var_113_18 = (arg_110_1.time_ - var_113_16) / var_113_17
				local var_113_19 = Vector3.New(0, 100, 0)

				var_113_15.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1041ui_story, var_113_19, var_113_18)

				local var_113_20 = manager.ui.mainCamera.transform.position - var_113_15.position

				var_113_15.forward = Vector3.New(var_113_20.x, var_113_20.y, var_113_20.z)

				local var_113_21 = var_113_15.localEulerAngles

				var_113_21.z = 0
				var_113_21.x = 0
				var_113_15.localEulerAngles = var_113_21
			end

			if arg_110_1.time_ >= var_113_16 + var_113_17 and arg_110_1.time_ < var_113_16 + var_113_17 + arg_113_0 then
				var_113_15.localPosition = Vector3.New(0, 100, 0)

				local var_113_22 = manager.ui.mainCamera.transform.position - var_113_15.position

				var_113_15.forward = Vector3.New(var_113_22.x, var_113_22.y, var_113_22.z)

				local var_113_23 = var_113_15.localEulerAngles

				var_113_23.z = 0
				var_113_23.x = 0
				var_113_15.localEulerAngles = var_113_23
			end

			local var_113_24 = arg_110_1.actors_["1042ui_story"]
			local var_113_25 = 0

			if var_113_25 < arg_110_1.time_ and arg_110_1.time_ <= var_113_25 + arg_113_0 and not isNil(var_113_24) and arg_110_1.var_.characterEffect1042ui_story == nil then
				arg_110_1.var_.characterEffect1042ui_story = var_113_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_26 = 0.2

			if var_113_25 <= arg_110_1.time_ and arg_110_1.time_ < var_113_25 + var_113_26 and not isNil(var_113_24) then
				local var_113_27 = (arg_110_1.time_ - var_113_25) / var_113_26

				if arg_110_1.var_.characterEffect1042ui_story and not isNil(var_113_24) then
					local var_113_28 = Mathf.Lerp(0, 0.5, var_113_27)

					arg_110_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1042ui_story.fillRatio = var_113_28
				end
			end

			if arg_110_1.time_ >= var_113_25 + var_113_26 and arg_110_1.time_ < var_113_25 + var_113_26 + arg_113_0 and not isNil(var_113_24) and arg_110_1.var_.characterEffect1042ui_story then
				local var_113_29 = 0.5

				arg_110_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1042ui_story.fillRatio = var_113_29
			end

			local var_113_30 = 0
			local var_113_31 = 0.35

			if var_113_30 < arg_110_1.time_ and arg_110_1.time_ <= var_113_30 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_32 = arg_110_1:FormatText(StoryNameCfg[94].name)

				arg_110_1.leftNameTxt_.text = var_113_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_33 = arg_110_1:GetWordFromCfg(113031027)
				local var_113_34 = arg_110_1:FormatText(var_113_33.content)

				arg_110_1.text_.text = var_113_34

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_35 = 14
				local var_113_36 = utf8.len(var_113_34)
				local var_113_37 = var_113_35 <= 0 and var_113_31 or var_113_31 * (var_113_36 / var_113_35)

				if var_113_37 > 0 and var_113_31 < var_113_37 then
					arg_110_1.talkMaxDuration = var_113_37

					if var_113_37 + var_113_30 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_37 + var_113_30
					end
				end

				arg_110_1.text_.text = var_113_34
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031027", "story_v_out_113031.awb") ~= 0 then
					local var_113_38 = manager.audio:GetVoiceLength("story_v_out_113031", "113031027", "story_v_out_113031.awb") / 1000

					if var_113_38 + var_113_30 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_38 + var_113_30
					end

					if var_113_33.prefab_name ~= "" and arg_110_1.actors_[var_113_33.prefab_name] ~= nil then
						local var_113_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_33.prefab_name].transform, "story_v_out_113031", "113031027", "story_v_out_113031.awb")

						arg_110_1:RecordAudio("113031027", var_113_39)
						arg_110_1:RecordAudio("113031027", var_113_39)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_113031", "113031027", "story_v_out_113031.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_113031", "113031027", "story_v_out_113031.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_40 = math.max(var_113_31, arg_110_1.talkMaxDuration)

			if var_113_30 <= arg_110_1.time_ and arg_110_1.time_ < var_113_30 + var_113_40 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_30) / var_113_40

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_30 + var_113_40 and arg_110_1.time_ < var_113_30 + var_113_40 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play113031028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 113031028
		arg_114_1.duration_ = 15.43

		local var_114_0 = {
			ja = 6.6,
			ko = 14.133,
			zh = 12.6,
			en = 15.433
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play113031029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1038ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1038ui_story == nil then
				arg_114_1.var_.characterEffect1038ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.2

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1038ui_story and not isNil(var_117_0) then
					local var_117_4 = Mathf.Lerp(0, 0.5, var_117_3)

					arg_114_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1038ui_story.fillRatio = var_117_4
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1038ui_story then
				local var_117_5 = 0.5

				arg_114_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1038ui_story.fillRatio = var_117_5
			end

			local var_117_6 = arg_114_1.actors_["1042ui_story"]
			local var_117_7 = 0

			if var_117_7 < arg_114_1.time_ and arg_114_1.time_ <= var_117_7 + arg_117_0 and not isNil(var_117_6) and arg_114_1.var_.characterEffect1042ui_story == nil then
				arg_114_1.var_.characterEffect1042ui_story = var_117_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_8 = 0.2

			if var_117_7 <= arg_114_1.time_ and arg_114_1.time_ < var_117_7 + var_117_8 and not isNil(var_117_6) then
				local var_117_9 = (arg_114_1.time_ - var_117_7) / var_117_8

				if arg_114_1.var_.characterEffect1042ui_story and not isNil(var_117_6) then
					arg_114_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_7 + var_117_8 and arg_114_1.time_ < var_117_7 + var_117_8 + arg_117_0 and not isNil(var_117_6) and arg_114_1.var_.characterEffect1042ui_story then
				arg_114_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_117_11 = 0

			if var_117_11 < arg_114_1.time_ and arg_114_1.time_ <= var_117_11 + arg_117_0 then
				arg_114_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_117_12 = 0
			local var_117_13 = 1.3

			if var_117_12 < arg_114_1.time_ and arg_114_1.time_ <= var_117_12 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_14 = arg_114_1:FormatText(StoryNameCfg[205].name)

				arg_114_1.leftNameTxt_.text = var_117_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_15 = arg_114_1:GetWordFromCfg(113031028)
				local var_117_16 = arg_114_1:FormatText(var_117_15.content)

				arg_114_1.text_.text = var_117_16

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_17 = 52
				local var_117_18 = utf8.len(var_117_16)
				local var_117_19 = var_117_17 <= 0 and var_117_13 or var_117_13 * (var_117_18 / var_117_17)

				if var_117_19 > 0 and var_117_13 < var_117_19 then
					arg_114_1.talkMaxDuration = var_117_19

					if var_117_19 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_19 + var_117_12
					end
				end

				arg_114_1.text_.text = var_117_16
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031028", "story_v_out_113031.awb") ~= 0 then
					local var_117_20 = manager.audio:GetVoiceLength("story_v_out_113031", "113031028", "story_v_out_113031.awb") / 1000

					if var_117_20 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_20 + var_117_12
					end

					if var_117_15.prefab_name ~= "" and arg_114_1.actors_[var_117_15.prefab_name] ~= nil then
						local var_117_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_15.prefab_name].transform, "story_v_out_113031", "113031028", "story_v_out_113031.awb")

						arg_114_1:RecordAudio("113031028", var_117_21)
						arg_114_1:RecordAudio("113031028", var_117_21)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_113031", "113031028", "story_v_out_113031.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_113031", "113031028", "story_v_out_113031.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_22 = math.max(var_117_13, arg_114_1.talkMaxDuration)

			if var_117_12 <= arg_114_1.time_ and arg_114_1.time_ < var_117_12 + var_117_22 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_12) / var_117_22

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_12 + var_117_22 and arg_114_1.time_ < var_117_12 + var_117_22 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play113031029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 113031029
		arg_118_1.duration_ = 20.7

		local var_118_0 = {
			ja = 13.3,
			ko = 12.233,
			zh = 14.566,
			en = 20.7
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play113031030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_121_1 = 0
			local var_121_2 = 1.375

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_3 = arg_118_1:FormatText(StoryNameCfg[205].name)

				arg_118_1.leftNameTxt_.text = var_121_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_4 = arg_118_1:GetWordFromCfg(113031029)
				local var_121_5 = arg_118_1:FormatText(var_121_4.content)

				arg_118_1.text_.text = var_121_5

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_6 = 55
				local var_121_7 = utf8.len(var_121_5)
				local var_121_8 = var_121_6 <= 0 and var_121_2 or var_121_2 * (var_121_7 / var_121_6)

				if var_121_8 > 0 and var_121_2 < var_121_8 then
					arg_118_1.talkMaxDuration = var_121_8

					if var_121_8 + var_121_1 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_1
					end
				end

				arg_118_1.text_.text = var_121_5
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031029", "story_v_out_113031.awb") ~= 0 then
					local var_121_9 = manager.audio:GetVoiceLength("story_v_out_113031", "113031029", "story_v_out_113031.awb") / 1000

					if var_121_9 + var_121_1 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_1
					end

					if var_121_4.prefab_name ~= "" and arg_118_1.actors_[var_121_4.prefab_name] ~= nil then
						local var_121_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_4.prefab_name].transform, "story_v_out_113031", "113031029", "story_v_out_113031.awb")

						arg_118_1:RecordAudio("113031029", var_121_10)
						arg_118_1:RecordAudio("113031029", var_121_10)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_113031", "113031029", "story_v_out_113031.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_113031", "113031029", "story_v_out_113031.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_11 = math.max(var_121_2, arg_118_1.talkMaxDuration)

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_11 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_1) / var_121_11

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_1 + var_121_11 and arg_118_1.time_ < var_121_1 + var_121_11 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play113031030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 113031030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play113031031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1042ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1042ui_story == nil then
				arg_122_1.var_.characterEffect1042ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1042ui_story and not isNil(var_125_0) then
					local var_125_4 = Mathf.Lerp(0, 0.5, var_125_3)

					arg_122_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1042ui_story.fillRatio = var_125_4
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1042ui_story then
				local var_125_5 = 0.5

				arg_122_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1042ui_story.fillRatio = var_125_5
			end

			local var_125_6 = 0
			local var_125_7 = 1.175

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_8 = arg_122_1:FormatText(StoryNameCfg[7].name)

				arg_122_1.leftNameTxt_.text = var_125_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_9 = arg_122_1:GetWordFromCfg(113031030)
				local var_125_10 = arg_122_1:FormatText(var_125_9.content)

				arg_122_1.text_.text = var_125_10

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 47
				local var_125_12 = utf8.len(var_125_10)
				local var_125_13 = var_125_11 <= 0 and var_125_7 or var_125_7 * (var_125_12 / var_125_11)

				if var_125_13 > 0 and var_125_7 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_10
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_14 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_14 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_14

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_14 and arg_122_1.time_ < var_125_6 + var_125_14 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play113031031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 113031031
		arg_126_1.duration_ = 8.7

		local var_126_0 = {
			ja = 5.333,
			ko = 7.9,
			zh = 5.4,
			en = 8.7
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play113031032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1042ui_story"].transform
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.var_.moveOldPos1042ui_story = var_129_0.localPosition
			end

			local var_129_2 = 0.5

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2
				local var_129_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_129_0.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1042ui_story, var_129_4, var_129_3)

				local var_129_5 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_5.x, var_129_5.y, var_129_5.z)

				local var_129_6 = var_129_0.localEulerAngles

				var_129_6.z = 0
				var_129_6.x = 0
				var_129_0.localEulerAngles = var_129_6
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 then
				var_129_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_129_7 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_7.x, var_129_7.y, var_129_7.z)

				local var_129_8 = var_129_0.localEulerAngles

				var_129_8.z = 0
				var_129_8.x = 0
				var_129_0.localEulerAngles = var_129_8
			end

			local var_129_9 = "1084ui_story"

			if arg_126_1.actors_[var_129_9] == nil then
				local var_129_10 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_129_10) then
					local var_129_11 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_126_1.stage_.transform)

					var_129_11.name = var_129_9
					var_129_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_126_1.actors_[var_129_9] = var_129_11

					local var_129_12 = var_129_11:GetComponentInChildren(typeof(CharacterEffect))

					var_129_12.enabled = true

					local var_129_13 = GameObjectTools.GetOrAddComponent(var_129_11, typeof(DynamicBoneHelper))

					if var_129_13 then
						var_129_13:EnableDynamicBone(false)
					end

					arg_126_1:ShowWeapon(var_129_12.transform, false)

					arg_126_1.var_[var_129_9 .. "Animator"] = var_129_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_126_1.var_[var_129_9 .. "Animator"].applyRootMotion = true
					arg_126_1.var_[var_129_9 .. "LipSync"] = var_129_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_129_14 = arg_126_1.actors_["1084ui_story"].transform
			local var_129_15 = 0

			if var_129_15 < arg_126_1.time_ and arg_126_1.time_ <= var_129_15 + arg_129_0 then
				arg_126_1.var_.moveOldPos1084ui_story = var_129_14.localPosition
			end

			local var_129_16 = 0.001

			if var_129_15 <= arg_126_1.time_ and arg_126_1.time_ < var_129_15 + var_129_16 then
				local var_129_17 = (arg_126_1.time_ - var_129_15) / var_129_16
				local var_129_18 = Vector3.New(0.7, -0.97, -6)

				var_129_14.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1084ui_story, var_129_18, var_129_17)

				local var_129_19 = manager.ui.mainCamera.transform.position - var_129_14.position

				var_129_14.forward = Vector3.New(var_129_19.x, var_129_19.y, var_129_19.z)

				local var_129_20 = var_129_14.localEulerAngles

				var_129_20.z = 0
				var_129_20.x = 0
				var_129_14.localEulerAngles = var_129_20
			end

			if arg_126_1.time_ >= var_129_15 + var_129_16 and arg_126_1.time_ < var_129_15 + var_129_16 + arg_129_0 then
				var_129_14.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_129_21 = manager.ui.mainCamera.transform.position - var_129_14.position

				var_129_14.forward = Vector3.New(var_129_21.x, var_129_21.y, var_129_21.z)

				local var_129_22 = var_129_14.localEulerAngles

				var_129_22.z = 0
				var_129_22.x = 0
				var_129_14.localEulerAngles = var_129_22
			end

			local var_129_23 = 0

			if var_129_23 < arg_126_1.time_ and arg_126_1.time_ <= var_129_23 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			local var_129_24 = 0

			if var_129_24 < arg_126_1.time_ and arg_126_1.time_ <= var_129_24 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_129_25 = arg_126_1.actors_["1084ui_story"]
			local var_129_26 = 0

			if var_129_26 < arg_126_1.time_ and arg_126_1.time_ <= var_129_26 + arg_129_0 and not isNil(var_129_25) and arg_126_1.var_.characterEffect1084ui_story == nil then
				arg_126_1.var_.characterEffect1084ui_story = var_129_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_27 = 0.2

			if var_129_26 <= arg_126_1.time_ and arg_126_1.time_ < var_129_26 + var_129_27 and not isNil(var_129_25) then
				local var_129_28 = (arg_126_1.time_ - var_129_26) / var_129_27

				if arg_126_1.var_.characterEffect1084ui_story and not isNil(var_129_25) then
					arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_26 + var_129_27 and arg_126_1.time_ < var_129_26 + var_129_27 + arg_129_0 and not isNil(var_129_25) and arg_126_1.var_.characterEffect1084ui_story then
				arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_129_29 = arg_126_1.actors_["1038ui_story"].transform
			local var_129_30 = 0

			if var_129_30 < arg_126_1.time_ and arg_126_1.time_ <= var_129_30 + arg_129_0 then
				arg_126_1.var_.moveOldPos1038ui_story = var_129_29.localPosition
			end

			local var_129_31 = 0.001

			if var_129_30 <= arg_126_1.time_ and arg_126_1.time_ < var_129_30 + var_129_31 then
				local var_129_32 = (arg_126_1.time_ - var_129_30) / var_129_31
				local var_129_33 = Vector3.New(0, 100, 0)

				var_129_29.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1038ui_story, var_129_33, var_129_32)

				local var_129_34 = manager.ui.mainCamera.transform.position - var_129_29.position

				var_129_29.forward = Vector3.New(var_129_34.x, var_129_34.y, var_129_34.z)

				local var_129_35 = var_129_29.localEulerAngles

				var_129_35.z = 0
				var_129_35.x = 0
				var_129_29.localEulerAngles = var_129_35
			end

			if arg_126_1.time_ >= var_129_30 + var_129_31 and arg_126_1.time_ < var_129_30 + var_129_31 + arg_129_0 then
				var_129_29.localPosition = Vector3.New(0, 100, 0)

				local var_129_36 = manager.ui.mainCamera.transform.position - var_129_29.position

				var_129_29.forward = Vector3.New(var_129_36.x, var_129_36.y, var_129_36.z)

				local var_129_37 = var_129_29.localEulerAngles

				var_129_37.z = 0
				var_129_37.x = 0
				var_129_29.localEulerAngles = var_129_37
			end

			local var_129_38 = 0
			local var_129_39 = 1

			if var_129_38 < arg_126_1.time_ and arg_126_1.time_ <= var_129_38 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_40 = arg_126_1:FormatText(StoryNameCfg[6].name)

				arg_126_1.leftNameTxt_.text = var_129_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_41 = arg_126_1:GetWordFromCfg(113031031)
				local var_129_42 = arg_126_1:FormatText(var_129_41.content)

				arg_126_1.text_.text = var_129_42

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_43 = 42
				local var_129_44 = utf8.len(var_129_42)
				local var_129_45 = var_129_43 <= 0 and var_129_39 or var_129_39 * (var_129_44 / var_129_43)

				if var_129_45 > 0 and var_129_39 < var_129_45 then
					arg_126_1.talkMaxDuration = var_129_45

					if var_129_45 + var_129_38 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_45 + var_129_38
					end
				end

				arg_126_1.text_.text = var_129_42
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031031", "story_v_out_113031.awb") ~= 0 then
					local var_129_46 = manager.audio:GetVoiceLength("story_v_out_113031", "113031031", "story_v_out_113031.awb") / 1000

					if var_129_46 + var_129_38 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_46 + var_129_38
					end

					if var_129_41.prefab_name ~= "" and arg_126_1.actors_[var_129_41.prefab_name] ~= nil then
						local var_129_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_41.prefab_name].transform, "story_v_out_113031", "113031031", "story_v_out_113031.awb")

						arg_126_1:RecordAudio("113031031", var_129_47)
						arg_126_1:RecordAudio("113031031", var_129_47)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_113031", "113031031", "story_v_out_113031.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_113031", "113031031", "story_v_out_113031.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_48 = math.max(var_129_39, arg_126_1.talkMaxDuration)

			if var_129_38 <= arg_126_1.time_ and arg_126_1.time_ < var_129_38 + var_129_48 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_38) / var_129_48

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_38 + var_129_48 and arg_126_1.time_ < var_129_38 + var_129_48 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play113031032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 113031032
		arg_130_1.duration_ = 9.1

		local var_130_0 = {
			ja = 7.633,
			ko = 6.133,
			zh = 5.766,
			en = 9.1
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
				arg_130_0:Play113031033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_133_1 = 0
			local var_133_2 = 0.65

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_3 = arg_130_1:FormatText(StoryNameCfg[6].name)

				arg_130_1.leftNameTxt_.text = var_133_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_4 = arg_130_1:GetWordFromCfg(113031032)
				local var_133_5 = arg_130_1:FormatText(var_133_4.content)

				arg_130_1.text_.text = var_133_5

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_6 = 26
				local var_133_7 = utf8.len(var_133_5)
				local var_133_8 = var_133_6 <= 0 and var_133_2 or var_133_2 * (var_133_7 / var_133_6)

				if var_133_8 > 0 and var_133_2 < var_133_8 then
					arg_130_1.talkMaxDuration = var_133_8

					if var_133_8 + var_133_1 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_8 + var_133_1
					end
				end

				arg_130_1.text_.text = var_133_5
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031032", "story_v_out_113031.awb") ~= 0 then
					local var_133_9 = manager.audio:GetVoiceLength("story_v_out_113031", "113031032", "story_v_out_113031.awb") / 1000

					if var_133_9 + var_133_1 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_1
					end

					if var_133_4.prefab_name ~= "" and arg_130_1.actors_[var_133_4.prefab_name] ~= nil then
						local var_133_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_4.prefab_name].transform, "story_v_out_113031", "113031032", "story_v_out_113031.awb")

						arg_130_1:RecordAudio("113031032", var_133_10)
						arg_130_1:RecordAudio("113031032", var_133_10)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_113031", "113031032", "story_v_out_113031.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_113031", "113031032", "story_v_out_113031.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_11 = math.max(var_133_2, arg_130_1.talkMaxDuration)

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_11 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_1) / var_133_11

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_1 + var_133_11 and arg_130_1.time_ < var_133_1 + var_133_11 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play113031033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 113031033
		arg_134_1.duration_ = 14.47

		local var_134_0 = {
			ja = 14.466,
			ko = 5,
			zh = 6.7,
			en = 8.733
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
				arg_134_0:Play113031034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1084ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1084ui_story == nil then
				arg_134_1.var_.characterEffect1084ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.2

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1084ui_story and not isNil(var_137_0) then
					local var_137_4 = Mathf.Lerp(0, 0.5, var_137_3)

					arg_134_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1084ui_story.fillRatio = var_137_4
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1084ui_story then
				local var_137_5 = 0.5

				arg_134_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1084ui_story.fillRatio = var_137_5
			end

			local var_137_6 = arg_134_1.actors_["1042ui_story"]
			local var_137_7 = 0

			if var_137_7 < arg_134_1.time_ and arg_134_1.time_ <= var_137_7 + arg_137_0 and not isNil(var_137_6) and arg_134_1.var_.characterEffect1042ui_story == nil then
				arg_134_1.var_.characterEffect1042ui_story = var_137_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_8 = 0.2

			if var_137_7 <= arg_134_1.time_ and arg_134_1.time_ < var_137_7 + var_137_8 and not isNil(var_137_6) then
				local var_137_9 = (arg_134_1.time_ - var_137_7) / var_137_8

				if arg_134_1.var_.characterEffect1042ui_story and not isNil(var_137_6) then
					arg_134_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_7 + var_137_8 and arg_134_1.time_ < var_137_7 + var_137_8 + arg_137_0 and not isNil(var_137_6) and arg_134_1.var_.characterEffect1042ui_story then
				arg_134_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_137_10 = 0

			if var_137_10 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 then
				arg_134_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action423")
			end

			local var_137_11 = 0

			if var_137_11 < arg_134_1.time_ and arg_134_1.time_ <= var_137_11 + arg_137_0 then
				arg_134_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_137_12 = 0

			if var_137_12 < arg_134_1.time_ and arg_134_1.time_ <= var_137_12 + arg_137_0 then
				arg_134_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_2")
			end

			local var_137_13 = 0

			if var_137_13 < arg_134_1.time_ and arg_134_1.time_ <= var_137_13 + arg_137_0 then
				arg_134_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_137_14 = 0
			local var_137_15 = 0.725

			if var_137_14 < arg_134_1.time_ and arg_134_1.time_ <= var_137_14 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_16 = arg_134_1:FormatText(StoryNameCfg[205].name)

				arg_134_1.leftNameTxt_.text = var_137_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_17 = arg_134_1:GetWordFromCfg(113031033)
				local var_137_18 = arg_134_1:FormatText(var_137_17.content)

				arg_134_1.text_.text = var_137_18

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_19 = 29
				local var_137_20 = utf8.len(var_137_18)
				local var_137_21 = var_137_19 <= 0 and var_137_15 or var_137_15 * (var_137_20 / var_137_19)

				if var_137_21 > 0 and var_137_15 < var_137_21 then
					arg_134_1.talkMaxDuration = var_137_21

					if var_137_21 + var_137_14 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_21 + var_137_14
					end
				end

				arg_134_1.text_.text = var_137_18
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031033", "story_v_out_113031.awb") ~= 0 then
					local var_137_22 = manager.audio:GetVoiceLength("story_v_out_113031", "113031033", "story_v_out_113031.awb") / 1000

					if var_137_22 + var_137_14 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_22 + var_137_14
					end

					if var_137_17.prefab_name ~= "" and arg_134_1.actors_[var_137_17.prefab_name] ~= nil then
						local var_137_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_17.prefab_name].transform, "story_v_out_113031", "113031033", "story_v_out_113031.awb")

						arg_134_1:RecordAudio("113031033", var_137_23)
						arg_134_1:RecordAudio("113031033", var_137_23)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_113031", "113031033", "story_v_out_113031.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_113031", "113031033", "story_v_out_113031.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_24 = math.max(var_137_15, arg_134_1.talkMaxDuration)

			if var_137_14 <= arg_134_1.time_ and arg_134_1.time_ < var_137_14 + var_137_24 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_14) / var_137_24

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_14 + var_137_24 and arg_134_1.time_ < var_137_14 + var_137_24 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play113031034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 113031034
		arg_138_1.duration_ = 9.23

		local var_138_0 = {
			ja = 5.766,
			ko = 8.233,
			zh = 8.833,
			en = 9.233
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
				arg_138_0:Play113031035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_141_2 = arg_138_1.actors_["1084ui_story"]
			local var_141_3 = 0

			if var_141_3 < arg_138_1.time_ and arg_138_1.time_ <= var_141_3 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect1084ui_story == nil then
				arg_138_1.var_.characterEffect1084ui_story = var_141_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_4 = 0.2

			if var_141_3 <= arg_138_1.time_ and arg_138_1.time_ < var_141_3 + var_141_4 and not isNil(var_141_2) then
				local var_141_5 = (arg_138_1.time_ - var_141_3) / var_141_4

				if arg_138_1.var_.characterEffect1084ui_story and not isNil(var_141_2) then
					arg_138_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_3 + var_141_4 and arg_138_1.time_ < var_141_3 + var_141_4 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect1084ui_story then
				arg_138_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_141_6 = arg_138_1.actors_["1042ui_story"]
			local var_141_7 = 0

			if var_141_7 < arg_138_1.time_ and arg_138_1.time_ <= var_141_7 + arg_141_0 and not isNil(var_141_6) and arg_138_1.var_.characterEffect1042ui_story == nil then
				arg_138_1.var_.characterEffect1042ui_story = var_141_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_8 = 0.2

			if var_141_7 <= arg_138_1.time_ and arg_138_1.time_ < var_141_7 + var_141_8 and not isNil(var_141_6) then
				local var_141_9 = (arg_138_1.time_ - var_141_7) / var_141_8

				if arg_138_1.var_.characterEffect1042ui_story and not isNil(var_141_6) then
					local var_141_10 = Mathf.Lerp(0, 0.5, var_141_9)

					arg_138_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1042ui_story.fillRatio = var_141_10
				end
			end

			if arg_138_1.time_ >= var_141_7 + var_141_8 and arg_138_1.time_ < var_141_7 + var_141_8 + arg_141_0 and not isNil(var_141_6) and arg_138_1.var_.characterEffect1042ui_story then
				local var_141_11 = 0.5

				arg_138_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1042ui_story.fillRatio = var_141_11
			end

			local var_141_12 = 0
			local var_141_13 = 0.85

			if var_141_12 < arg_138_1.time_ and arg_138_1.time_ <= var_141_12 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_14 = arg_138_1:FormatText(StoryNameCfg[6].name)

				arg_138_1.leftNameTxt_.text = var_141_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_15 = arg_138_1:GetWordFromCfg(113031034)
				local var_141_16 = arg_138_1:FormatText(var_141_15.content)

				arg_138_1.text_.text = var_141_16

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_17 = 30
				local var_141_18 = utf8.len(var_141_16)
				local var_141_19 = var_141_17 <= 0 and var_141_13 or var_141_13 * (var_141_18 / var_141_17)

				if var_141_19 > 0 and var_141_13 < var_141_19 then
					arg_138_1.talkMaxDuration = var_141_19

					if var_141_19 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_19 + var_141_12
					end
				end

				arg_138_1.text_.text = var_141_16
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031034", "story_v_out_113031.awb") ~= 0 then
					local var_141_20 = manager.audio:GetVoiceLength("story_v_out_113031", "113031034", "story_v_out_113031.awb") / 1000

					if var_141_20 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_20 + var_141_12
					end

					if var_141_15.prefab_name ~= "" and arg_138_1.actors_[var_141_15.prefab_name] ~= nil then
						local var_141_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_15.prefab_name].transform, "story_v_out_113031", "113031034", "story_v_out_113031.awb")

						arg_138_1:RecordAudio("113031034", var_141_21)
						arg_138_1:RecordAudio("113031034", var_141_21)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_113031", "113031034", "story_v_out_113031.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_113031", "113031034", "story_v_out_113031.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_22 = math.max(var_141_13, arg_138_1.talkMaxDuration)

			if var_141_12 <= arg_138_1.time_ and arg_138_1.time_ < var_141_12 + var_141_22 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_12) / var_141_22

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_12 + var_141_22 and arg_138_1.time_ < var_141_12 + var_141_22 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play113031035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 113031035
		arg_142_1.duration_ = 6.07

		local var_142_0 = {
			ja = 5,
			ko = 4.266,
			zh = 5.666,
			en = 6.066
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
				arg_142_0:Play113031036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1042ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1042ui_story == nil then
				arg_142_1.var_.characterEffect1042ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.2

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1042ui_story and not isNil(var_145_0) then
					arg_142_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1042ui_story then
				arg_142_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_145_4 = 0

			if var_145_4 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action434")
			end

			local var_145_5 = 0

			if var_145_5 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 then
				arg_142_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_145_6 = arg_142_1.actors_["1084ui_story"]
			local var_145_7 = 0

			if var_145_7 < arg_142_1.time_ and arg_142_1.time_ <= var_145_7 + arg_145_0 and not isNil(var_145_6) and arg_142_1.var_.characterEffect1084ui_story == nil then
				arg_142_1.var_.characterEffect1084ui_story = var_145_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_8 = 0.2

			if var_145_7 <= arg_142_1.time_ and arg_142_1.time_ < var_145_7 + var_145_8 and not isNil(var_145_6) then
				local var_145_9 = (arg_142_1.time_ - var_145_7) / var_145_8

				if arg_142_1.var_.characterEffect1084ui_story and not isNil(var_145_6) then
					local var_145_10 = Mathf.Lerp(0, 0.5, var_145_9)

					arg_142_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1084ui_story.fillRatio = var_145_10
				end
			end

			if arg_142_1.time_ >= var_145_7 + var_145_8 and arg_142_1.time_ < var_145_7 + var_145_8 + arg_145_0 and not isNil(var_145_6) and arg_142_1.var_.characterEffect1084ui_story then
				local var_145_11 = 0.5

				arg_142_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1084ui_story.fillRatio = var_145_11
			end

			local var_145_12 = 0
			local var_145_13 = 0.375

			if var_145_12 < arg_142_1.time_ and arg_142_1.time_ <= var_145_12 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_14 = arg_142_1:FormatText(StoryNameCfg[205].name)

				arg_142_1.leftNameTxt_.text = var_145_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_15 = arg_142_1:GetWordFromCfg(113031035)
				local var_145_16 = arg_142_1:FormatText(var_145_15.content)

				arg_142_1.text_.text = var_145_16

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_17 = 15
				local var_145_18 = utf8.len(var_145_16)
				local var_145_19 = var_145_17 <= 0 and var_145_13 or var_145_13 * (var_145_18 / var_145_17)

				if var_145_19 > 0 and var_145_13 < var_145_19 then
					arg_142_1.talkMaxDuration = var_145_19

					if var_145_19 + var_145_12 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_19 + var_145_12
					end
				end

				arg_142_1.text_.text = var_145_16
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031035", "story_v_out_113031.awb") ~= 0 then
					local var_145_20 = manager.audio:GetVoiceLength("story_v_out_113031", "113031035", "story_v_out_113031.awb") / 1000

					if var_145_20 + var_145_12 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_20 + var_145_12
					end

					if var_145_15.prefab_name ~= "" and arg_142_1.actors_[var_145_15.prefab_name] ~= nil then
						local var_145_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_15.prefab_name].transform, "story_v_out_113031", "113031035", "story_v_out_113031.awb")

						arg_142_1:RecordAudio("113031035", var_145_21)
						arg_142_1:RecordAudio("113031035", var_145_21)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_113031", "113031035", "story_v_out_113031.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_113031", "113031035", "story_v_out_113031.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_22 = math.max(var_145_13, arg_142_1.talkMaxDuration)

			if var_145_12 <= arg_142_1.time_ and arg_142_1.time_ < var_145_12 + var_145_22 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_12) / var_145_22

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_12 + var_145_22 and arg_142_1.time_ < var_145_12 + var_145_22 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play113031036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 113031036
		arg_146_1.duration_ = 2.47

		local var_146_0 = {
			ja = 2.466,
			ko = 1.999999999999,
			zh = 2.166,
			en = 2.1
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
				arg_146_0:Play113031037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action442")
			end

			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_149_2 = arg_146_1.actors_["1084ui_story"].transform
			local var_149_3 = 0

			if var_149_3 < arg_146_1.time_ and arg_146_1.time_ <= var_149_3 + arg_149_0 then
				arg_146_1.var_.moveOldPos1084ui_story = var_149_2.localPosition
			end

			local var_149_4 = 0.001

			if var_149_3 <= arg_146_1.time_ and arg_146_1.time_ < var_149_3 + var_149_4 then
				local var_149_5 = (arg_146_1.time_ - var_149_3) / var_149_4
				local var_149_6 = Vector3.New(0, 100, 0)

				var_149_2.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1084ui_story, var_149_6, var_149_5)

				local var_149_7 = manager.ui.mainCamera.transform.position - var_149_2.position

				var_149_2.forward = Vector3.New(var_149_7.x, var_149_7.y, var_149_7.z)

				local var_149_8 = var_149_2.localEulerAngles

				var_149_8.z = 0
				var_149_8.x = 0
				var_149_2.localEulerAngles = var_149_8
			end

			if arg_146_1.time_ >= var_149_3 + var_149_4 and arg_146_1.time_ < var_149_3 + var_149_4 + arg_149_0 then
				var_149_2.localPosition = Vector3.New(0, 100, 0)

				local var_149_9 = manager.ui.mainCamera.transform.position - var_149_2.position

				var_149_2.forward = Vector3.New(var_149_9.x, var_149_9.y, var_149_9.z)

				local var_149_10 = var_149_2.localEulerAngles

				var_149_10.z = 0
				var_149_10.x = 0
				var_149_2.localEulerAngles = var_149_10
			end

			local var_149_11 = arg_146_1.actors_["1042ui_story"].transform
			local var_149_12 = 0

			if var_149_12 < arg_146_1.time_ and arg_146_1.time_ <= var_149_12 + arg_149_0 then
				arg_146_1.var_.moveOldPos1042ui_story = var_149_11.localPosition
			end

			local var_149_13 = 0.5

			if var_149_12 <= arg_146_1.time_ and arg_146_1.time_ < var_149_12 + var_149_13 then
				local var_149_14 = (arg_146_1.time_ - var_149_12) / var_149_13
				local var_149_15 = Vector3.New(0, -1.06, -6.2)

				var_149_11.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1042ui_story, var_149_15, var_149_14)

				local var_149_16 = manager.ui.mainCamera.transform.position - var_149_11.position

				var_149_11.forward = Vector3.New(var_149_16.x, var_149_16.y, var_149_16.z)

				local var_149_17 = var_149_11.localEulerAngles

				var_149_17.z = 0
				var_149_17.x = 0
				var_149_11.localEulerAngles = var_149_17
			end

			if arg_146_1.time_ >= var_149_12 + var_149_13 and arg_146_1.time_ < var_149_12 + var_149_13 + arg_149_0 then
				var_149_11.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_149_18 = manager.ui.mainCamera.transform.position - var_149_11.position

				var_149_11.forward = Vector3.New(var_149_18.x, var_149_18.y, var_149_18.z)

				local var_149_19 = var_149_11.localEulerAngles

				var_149_19.z = 0
				var_149_19.x = 0
				var_149_11.localEulerAngles = var_149_19
			end

			local var_149_20 = 0
			local var_149_21 = 0.15

			if var_149_20 < arg_146_1.time_ and arg_146_1.time_ <= var_149_20 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_22 = arg_146_1:FormatText(StoryNameCfg[205].name)

				arg_146_1.leftNameTxt_.text = var_149_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_23 = arg_146_1:GetWordFromCfg(113031036)
				local var_149_24 = arg_146_1:FormatText(var_149_23.content)

				arg_146_1.text_.text = var_149_24

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_25 = 6
				local var_149_26 = utf8.len(var_149_24)
				local var_149_27 = var_149_25 <= 0 and var_149_21 or var_149_21 * (var_149_26 / var_149_25)

				if var_149_27 > 0 and var_149_21 < var_149_27 then
					arg_146_1.talkMaxDuration = var_149_27

					if var_149_27 + var_149_20 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_27 + var_149_20
					end
				end

				arg_146_1.text_.text = var_149_24
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031036", "story_v_out_113031.awb") ~= 0 then
					local var_149_28 = manager.audio:GetVoiceLength("story_v_out_113031", "113031036", "story_v_out_113031.awb") / 1000

					if var_149_28 + var_149_20 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_28 + var_149_20
					end

					if var_149_23.prefab_name ~= "" and arg_146_1.actors_[var_149_23.prefab_name] ~= nil then
						local var_149_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_23.prefab_name].transform, "story_v_out_113031", "113031036", "story_v_out_113031.awb")

						arg_146_1:RecordAudio("113031036", var_149_29)
						arg_146_1:RecordAudio("113031036", var_149_29)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_113031", "113031036", "story_v_out_113031.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_113031", "113031036", "story_v_out_113031.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_30 = math.max(var_149_21, arg_146_1.talkMaxDuration)

			if var_149_20 <= arg_146_1.time_ and arg_146_1.time_ < var_149_20 + var_149_30 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_20) / var_149_30

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_20 + var_149_30 and arg_146_1.time_ < var_149_20 + var_149_30 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play113031037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 113031037
		arg_150_1.duration_ = 2.37

		local var_150_0 = {
			ja = 2.166,
			ko = 1.999999999999,
			zh = 2.366,
			en = 2.166
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
				arg_150_0:Play113031038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1042ui_story"].transform
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.var_.moveOldPos1042ui_story = var_153_0.localPosition
			end

			local var_153_2 = 0.001

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2
				local var_153_4 = Vector3.New(0, 100, 0)

				var_153_0.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1042ui_story, var_153_4, var_153_3)

				local var_153_5 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_5.x, var_153_5.y, var_153_5.z)

				local var_153_6 = var_153_0.localEulerAngles

				var_153_6.z = 0
				var_153_6.x = 0
				var_153_0.localEulerAngles = var_153_6
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 then
				var_153_0.localPosition = Vector3.New(0, 100, 0)

				local var_153_7 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_7.x, var_153_7.y, var_153_7.z)

				local var_153_8 = var_153_0.localEulerAngles

				var_153_8.z = 0
				var_153_8.x = 0
				var_153_0.localEulerAngles = var_153_8
			end

			local var_153_9 = arg_150_1.actors_["1084ui_story"].transform
			local var_153_10 = 0

			if var_153_10 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 then
				arg_150_1.var_.moveOldPos1084ui_story = var_153_9.localPosition
			end

			local var_153_11 = 0.001

			if var_153_10 <= arg_150_1.time_ and arg_150_1.time_ < var_153_10 + var_153_11 then
				local var_153_12 = (arg_150_1.time_ - var_153_10) / var_153_11
				local var_153_13 = Vector3.New(0, 100, 0)

				var_153_9.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1084ui_story, var_153_13, var_153_12)

				local var_153_14 = manager.ui.mainCamera.transform.position - var_153_9.position

				var_153_9.forward = Vector3.New(var_153_14.x, var_153_14.y, var_153_14.z)

				local var_153_15 = var_153_9.localEulerAngles

				var_153_15.z = 0
				var_153_15.x = 0
				var_153_9.localEulerAngles = var_153_15
			end

			if arg_150_1.time_ >= var_153_10 + var_153_11 and arg_150_1.time_ < var_153_10 + var_153_11 + arg_153_0 then
				var_153_9.localPosition = Vector3.New(0, 100, 0)

				local var_153_16 = manager.ui.mainCamera.transform.position - var_153_9.position

				var_153_9.forward = Vector3.New(var_153_16.x, var_153_16.y, var_153_16.z)

				local var_153_17 = var_153_9.localEulerAngles

				var_153_17.z = 0
				var_153_17.x = 0
				var_153_9.localEulerAngles = var_153_17
			end

			local var_153_18 = "6045_story"

			if arg_150_1.actors_[var_153_18] == nil then
				local var_153_19 = Asset.Load("Char/" .. "6045_story")

				if not isNil(var_153_19) then
					local var_153_20 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_150_1.stage_.transform)

					var_153_20.name = var_153_18
					var_153_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_150_1.actors_[var_153_18] = var_153_20

					local var_153_21 = var_153_20:GetComponentInChildren(typeof(CharacterEffect))

					var_153_21.enabled = true

					local var_153_22 = GameObjectTools.GetOrAddComponent(var_153_20, typeof(DynamicBoneHelper))

					if var_153_22 then
						var_153_22:EnableDynamicBone(false)
					end

					arg_150_1:ShowWeapon(var_153_21.transform, false)

					arg_150_1.var_[var_153_18 .. "Animator"] = var_153_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_150_1.var_[var_153_18 .. "Animator"].applyRootMotion = true
					arg_150_1.var_[var_153_18 .. "LipSync"] = var_153_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_153_23 = arg_150_1.actors_["6045_story"].transform
			local var_153_24 = 0

			if var_153_24 < arg_150_1.time_ and arg_150_1.time_ <= var_153_24 + arg_153_0 then
				arg_150_1.var_.moveOldPos6045_story = var_153_23.localPosition

				local var_153_25 = GameObjectTools.GetOrAddComponent(var_153_23.gameObject, typeof(DynamicBoneHelper))

				if var_153_25 then
					var_153_25:EnableDynamicBone(false)
				end
			end

			local var_153_26 = 0.001

			if var_153_24 <= arg_150_1.time_ and arg_150_1.time_ < var_153_24 + var_153_26 then
				local var_153_27 = (arg_150_1.time_ - var_153_24) / var_153_26
				local var_153_28 = Vector3.New(-0.7, -0.5, -6.3)

				var_153_23.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos6045_story, var_153_28, var_153_27)

				local var_153_29 = manager.ui.mainCamera.transform.position - var_153_23.position

				var_153_23.forward = Vector3.New(var_153_29.x, var_153_29.y, var_153_29.z)

				local var_153_30 = var_153_23.localEulerAngles

				var_153_30.z = 0
				var_153_30.x = 0
				var_153_23.localEulerAngles = var_153_30
			end

			if arg_150_1.time_ >= var_153_24 + var_153_26 and arg_150_1.time_ < var_153_24 + var_153_26 + arg_153_0 then
				var_153_23.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_153_31 = manager.ui.mainCamera.transform.position - var_153_23.position

				var_153_23.forward = Vector3.New(var_153_31.x, var_153_31.y, var_153_31.z)

				local var_153_32 = var_153_23.localEulerAngles

				var_153_32.z = 0
				var_153_32.x = 0
				var_153_23.localEulerAngles = var_153_32

				local var_153_33 = GameObjectTools.GetOrAddComponent(var_153_23.gameObject, typeof(DynamicBoneHelper))

				if var_153_33 then
					var_153_33:EnableDynamicBone(true)
				end
			end

			local var_153_34 = 0

			if var_153_34 < arg_150_1.time_ and arg_150_1.time_ <= var_153_34 + arg_153_0 then
				arg_150_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_153_35 = 0

			if var_153_35 < arg_150_1.time_ and arg_150_1.time_ <= var_153_35 + arg_153_0 then
				arg_150_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_153_36 = arg_150_1.actors_["6045_story"]
			local var_153_37 = 0

			if var_153_37 < arg_150_1.time_ and arg_150_1.time_ <= var_153_37 + arg_153_0 and not isNil(var_153_36) and arg_150_1.var_.characterEffect6045_story == nil then
				arg_150_1.var_.characterEffect6045_story = var_153_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_38 = 0.2

			if var_153_37 <= arg_150_1.time_ and arg_150_1.time_ < var_153_37 + var_153_38 and not isNil(var_153_36) then
				local var_153_39 = (arg_150_1.time_ - var_153_37) / var_153_38

				if arg_150_1.var_.characterEffect6045_story and not isNil(var_153_36) then
					arg_150_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_37 + var_153_38 and arg_150_1.time_ < var_153_37 + var_153_38 + arg_153_0 and not isNil(var_153_36) and arg_150_1.var_.characterEffect6045_story then
				arg_150_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_153_40 = 0
			local var_153_41 = 0.2

			if var_153_40 < arg_150_1.time_ and arg_150_1.time_ <= var_153_40 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_42 = arg_150_1:FormatText(StoryNameCfg[215].name)

				arg_150_1.leftNameTxt_.text = var_153_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_43 = arg_150_1:GetWordFromCfg(113031037)
				local var_153_44 = arg_150_1:FormatText(var_153_43.content)

				arg_150_1.text_.text = var_153_44

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_45 = 8
				local var_153_46 = utf8.len(var_153_44)
				local var_153_47 = var_153_45 <= 0 and var_153_41 or var_153_41 * (var_153_46 / var_153_45)

				if var_153_47 > 0 and var_153_41 < var_153_47 then
					arg_150_1.talkMaxDuration = var_153_47

					if var_153_47 + var_153_40 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_47 + var_153_40
					end
				end

				arg_150_1.text_.text = var_153_44
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031037", "story_v_out_113031.awb") ~= 0 then
					local var_153_48 = manager.audio:GetVoiceLength("story_v_out_113031", "113031037", "story_v_out_113031.awb") / 1000

					if var_153_48 + var_153_40 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_48 + var_153_40
					end

					if var_153_43.prefab_name ~= "" and arg_150_1.actors_[var_153_43.prefab_name] ~= nil then
						local var_153_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_43.prefab_name].transform, "story_v_out_113031", "113031037", "story_v_out_113031.awb")

						arg_150_1:RecordAudio("113031037", var_153_49)
						arg_150_1:RecordAudio("113031037", var_153_49)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_113031", "113031037", "story_v_out_113031.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_113031", "113031037", "story_v_out_113031.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_50 = math.max(var_153_41, arg_150_1.talkMaxDuration)

			if var_153_40 <= arg_150_1.time_ and arg_150_1.time_ < var_153_40 + var_153_50 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_40) / var_153_50

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_40 + var_153_50 and arg_150_1.time_ < var_153_40 + var_153_50 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play113031038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 113031038
		arg_154_1.duration_ = 2.57

		local var_154_0 = {
			ja = 2.566,
			ko = 2.166,
			zh = 2.5,
			en = 1.999999999999
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play113031039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = "6046_story"

			if arg_154_1.actors_[var_157_0] == nil then
				local var_157_1 = Asset.Load("Char/" .. "6046_story")

				if not isNil(var_157_1) then
					local var_157_2 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_154_1.stage_.transform)

					var_157_2.name = var_157_0
					var_157_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_154_1.actors_[var_157_0] = var_157_2

					local var_157_3 = var_157_2:GetComponentInChildren(typeof(CharacterEffect))

					var_157_3.enabled = true

					local var_157_4 = GameObjectTools.GetOrAddComponent(var_157_2, typeof(DynamicBoneHelper))

					if var_157_4 then
						var_157_4:EnableDynamicBone(false)
					end

					arg_154_1:ShowWeapon(var_157_3.transform, false)

					arg_154_1.var_[var_157_0 .. "Animator"] = var_157_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_154_1.var_[var_157_0 .. "Animator"].applyRootMotion = true
					arg_154_1.var_[var_157_0 .. "LipSync"] = var_157_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_157_5 = 0

			if var_157_5 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 then
				arg_154_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_157_6 = 0

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_157_7 = arg_154_1.actors_["6045_story"]
			local var_157_8 = 0

			if var_157_8 < arg_154_1.time_ and arg_154_1.time_ <= var_157_8 + arg_157_0 and not isNil(var_157_7) and arg_154_1.var_.characterEffect6045_story == nil then
				arg_154_1.var_.characterEffect6045_story = var_157_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_9 = 0.2

			if var_157_8 <= arg_154_1.time_ and arg_154_1.time_ < var_157_8 + var_157_9 and not isNil(var_157_7) then
				local var_157_10 = (arg_154_1.time_ - var_157_8) / var_157_9

				if arg_154_1.var_.characterEffect6045_story and not isNil(var_157_7) then
					local var_157_11 = Mathf.Lerp(0, 0.5, var_157_10)

					arg_154_1.var_.characterEffect6045_story.fillFlat = true
					arg_154_1.var_.characterEffect6045_story.fillRatio = var_157_11
				end
			end

			if arg_154_1.time_ >= var_157_8 + var_157_9 and arg_154_1.time_ < var_157_8 + var_157_9 + arg_157_0 and not isNil(var_157_7) and arg_154_1.var_.characterEffect6045_story then
				local var_157_12 = 0.5

				arg_154_1.var_.characterEffect6045_story.fillFlat = true
				arg_154_1.var_.characterEffect6045_story.fillRatio = var_157_12
			end

			local var_157_13 = arg_154_1.actors_["6046_story"].transform
			local var_157_14 = 0

			if var_157_14 < arg_154_1.time_ and arg_154_1.time_ <= var_157_14 + arg_157_0 then
				arg_154_1.var_.moveOldPos6046_story = var_157_13.localPosition

				local var_157_15 = GameObjectTools.GetOrAddComponent(var_157_13.gameObject, typeof(DynamicBoneHelper))

				if var_157_15 then
					var_157_15:EnableDynamicBone(false)
				end
			end

			local var_157_16 = 0.001

			if var_157_14 <= arg_154_1.time_ and arg_154_1.time_ < var_157_14 + var_157_16 then
				local var_157_17 = (arg_154_1.time_ - var_157_14) / var_157_16
				local var_157_18 = Vector3.New(0.7, -0.5, -6.3)

				var_157_13.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos6046_story, var_157_18, var_157_17)

				local var_157_19 = manager.ui.mainCamera.transform.position - var_157_13.position

				var_157_13.forward = Vector3.New(var_157_19.x, var_157_19.y, var_157_19.z)

				local var_157_20 = var_157_13.localEulerAngles

				var_157_20.z = 0
				var_157_20.x = 0
				var_157_13.localEulerAngles = var_157_20
			end

			if arg_154_1.time_ >= var_157_14 + var_157_16 and arg_154_1.time_ < var_157_14 + var_157_16 + arg_157_0 then
				var_157_13.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_157_21 = manager.ui.mainCamera.transform.position - var_157_13.position

				var_157_13.forward = Vector3.New(var_157_21.x, var_157_21.y, var_157_21.z)

				local var_157_22 = var_157_13.localEulerAngles

				var_157_22.z = 0
				var_157_22.x = 0
				var_157_13.localEulerAngles = var_157_22

				local var_157_23 = GameObjectTools.GetOrAddComponent(var_157_13.gameObject, typeof(DynamicBoneHelper))

				if var_157_23 then
					var_157_23:EnableDynamicBone(true)
				end
			end

			local var_157_24 = arg_154_1.actors_["6046_story"]
			local var_157_25 = 0

			if var_157_25 < arg_154_1.time_ and arg_154_1.time_ <= var_157_25 + arg_157_0 and not isNil(var_157_24) and arg_154_1.var_.characterEffect6046_story == nil then
				arg_154_1.var_.characterEffect6046_story = var_157_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_26 = 0.2

			if var_157_25 <= arg_154_1.time_ and arg_154_1.time_ < var_157_25 + var_157_26 and not isNil(var_157_24) then
				local var_157_27 = (arg_154_1.time_ - var_157_25) / var_157_26

				if arg_154_1.var_.characterEffect6046_story and not isNil(var_157_24) then
					arg_154_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_25 + var_157_26 and arg_154_1.time_ < var_157_25 + var_157_26 + arg_157_0 and not isNil(var_157_24) and arg_154_1.var_.characterEffect6046_story then
				arg_154_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_157_28 = 0
			local var_157_29 = 0.2

			if var_157_28 < arg_154_1.time_ and arg_154_1.time_ <= var_157_28 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_30 = arg_154_1:FormatText(StoryNameCfg[214].name)

				arg_154_1.leftNameTxt_.text = var_157_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_31 = arg_154_1:GetWordFromCfg(113031038)
				local var_157_32 = arg_154_1:FormatText(var_157_31.content)

				arg_154_1.text_.text = var_157_32

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_33 = 8
				local var_157_34 = utf8.len(var_157_32)
				local var_157_35 = var_157_33 <= 0 and var_157_29 or var_157_29 * (var_157_34 / var_157_33)

				if var_157_35 > 0 and var_157_29 < var_157_35 then
					arg_154_1.talkMaxDuration = var_157_35

					if var_157_35 + var_157_28 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_35 + var_157_28
					end
				end

				arg_154_1.text_.text = var_157_32
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031038", "story_v_out_113031.awb") ~= 0 then
					local var_157_36 = manager.audio:GetVoiceLength("story_v_out_113031", "113031038", "story_v_out_113031.awb") / 1000

					if var_157_36 + var_157_28 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_36 + var_157_28
					end

					if var_157_31.prefab_name ~= "" and arg_154_1.actors_[var_157_31.prefab_name] ~= nil then
						local var_157_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_31.prefab_name].transform, "story_v_out_113031", "113031038", "story_v_out_113031.awb")

						arg_154_1:RecordAudio("113031038", var_157_37)
						arg_154_1:RecordAudio("113031038", var_157_37)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_113031", "113031038", "story_v_out_113031.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_113031", "113031038", "story_v_out_113031.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_38 = math.max(var_157_29, arg_154_1.talkMaxDuration)

			if var_157_28 <= arg_154_1.time_ and arg_154_1.time_ < var_157_28 + var_157_38 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_28) / var_157_38

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_28 + var_157_38 and arg_154_1.time_ < var_157_28 + var_157_38 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play113031039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 113031039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play113031040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = "6046_tpose"

			if arg_158_1.actors_[var_161_0] == nil then
				local var_161_1 = Asset.Load("Char/" .. "6046_tpose")

				if not isNil(var_161_1) then
					local var_161_2 = Object.Instantiate(Asset.Load("Char/" .. "6046_tpose"), arg_158_1.stage_.transform)

					var_161_2.name = var_161_0
					var_161_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_158_1.actors_[var_161_0] = var_161_2

					local var_161_3 = var_161_2:GetComponentInChildren(typeof(CharacterEffect))

					var_161_3.enabled = true

					local var_161_4 = GameObjectTools.GetOrAddComponent(var_161_2, typeof(DynamicBoneHelper))

					if var_161_4 then
						var_161_4:EnableDynamicBone(false)
					end

					arg_158_1:ShowWeapon(var_161_3.transform, false)

					arg_158_1.var_[var_161_0 .. "Animator"] = var_161_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_158_1.var_[var_161_0 .. "Animator"].applyRootMotion = true
					arg_158_1.var_[var_161_0 .. "LipSync"] = var_161_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_161_5 = arg_158_1.actors_["6046_tpose"]
			local var_161_6 = 0

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 and not isNil(var_161_5) and arg_158_1.var_.characterEffect6046_tpose == nil then
				arg_158_1.var_.characterEffect6046_tpose = var_161_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_7 = 0.2

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_7 and not isNil(var_161_5) then
				local var_161_8 = (arg_158_1.time_ - var_161_6) / var_161_7

				if arg_158_1.var_.characterEffect6046_tpose and not isNil(var_161_5) then
					local var_161_9 = Mathf.Lerp(0, 0.5, var_161_8)

					arg_158_1.var_.characterEffect6046_tpose.fillFlat = true
					arg_158_1.var_.characterEffect6046_tpose.fillRatio = var_161_9
				end
			end

			if arg_158_1.time_ >= var_161_6 + var_161_7 and arg_158_1.time_ < var_161_6 + var_161_7 + arg_161_0 and not isNil(var_161_5) and arg_158_1.var_.characterEffect6046_tpose then
				local var_161_10 = 0.5

				arg_158_1.var_.characterEffect6046_tpose.fillFlat = true
				arg_158_1.var_.characterEffect6046_tpose.fillRatio = var_161_10
			end

			local var_161_11 = 0
			local var_161_12 = 0.5

			if var_161_11 < arg_158_1.time_ and arg_158_1.time_ <= var_161_11 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_13 = arg_158_1:GetWordFromCfg(113031039)
				local var_161_14 = arg_158_1:FormatText(var_161_13.content)

				arg_158_1.text_.text = var_161_14

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_15 = 20
				local var_161_16 = utf8.len(var_161_14)
				local var_161_17 = var_161_15 <= 0 and var_161_12 or var_161_12 * (var_161_16 / var_161_15)

				if var_161_17 > 0 and var_161_12 < var_161_17 then
					arg_158_1.talkMaxDuration = var_161_17

					if var_161_17 + var_161_11 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_17 + var_161_11
					end
				end

				arg_158_1.text_.text = var_161_14
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_18 = math.max(var_161_12, arg_158_1.talkMaxDuration)

			if var_161_11 <= arg_158_1.time_ and arg_158_1.time_ < var_161_11 + var_161_18 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_11) / var_161_18

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_11 + var_161_18 and arg_158_1.time_ < var_161_11 + var_161_18 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play113031040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 113031040
		arg_162_1.duration_ = 6.53

		local var_162_0 = {
			ja = 6.533,
			ko = 4.833,
			zh = 5.6,
			en = 5.5
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
				arg_162_0:Play113031041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["6045_story"].transform
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.var_.moveOldPos6045_story = var_165_0.localPosition

				local var_165_2 = GameObjectTools.GetOrAddComponent(var_165_0.gameObject, typeof(DynamicBoneHelper))

				if var_165_2 then
					var_165_2:EnableDynamicBone(false)
				end
			end

			local var_165_3 = 0.001

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_3 then
				local var_165_4 = (arg_162_1.time_ - var_165_1) / var_165_3
				local var_165_5 = Vector3.New(0, 100, 0)

				var_165_0.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos6045_story, var_165_5, var_165_4)

				local var_165_6 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_6.x, var_165_6.y, var_165_6.z)

				local var_165_7 = var_165_0.localEulerAngles

				var_165_7.z = 0
				var_165_7.x = 0
				var_165_0.localEulerAngles = var_165_7
			end

			if arg_162_1.time_ >= var_165_1 + var_165_3 and arg_162_1.time_ < var_165_1 + var_165_3 + arg_165_0 then
				var_165_0.localPosition = Vector3.New(0, 100, 0)

				local var_165_8 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_8.x, var_165_8.y, var_165_8.z)

				local var_165_9 = var_165_0.localEulerAngles

				var_165_9.z = 0
				var_165_9.x = 0
				var_165_0.localEulerAngles = var_165_9

				local var_165_10 = GameObjectTools.GetOrAddComponent(var_165_0.gameObject, typeof(DynamicBoneHelper))

				if var_165_10 then
					var_165_10:EnableDynamicBone(true)
				end
			end

			local var_165_11 = arg_162_1.actors_["6046_story"].transform
			local var_165_12 = 0

			if var_165_12 < arg_162_1.time_ and arg_162_1.time_ <= var_165_12 + arg_165_0 then
				arg_162_1.var_.moveOldPos6046_story = var_165_11.localPosition

				local var_165_13 = GameObjectTools.GetOrAddComponent(var_165_11.gameObject, typeof(DynamicBoneHelper))

				if var_165_13 then
					var_165_13:EnableDynamicBone(false)
				end
			end

			local var_165_14 = 0.001

			if var_165_12 <= arg_162_1.time_ and arg_162_1.time_ < var_165_12 + var_165_14 then
				local var_165_15 = (arg_162_1.time_ - var_165_12) / var_165_14
				local var_165_16 = Vector3.New(0, 100, 0)

				var_165_11.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos6046_story, var_165_16, var_165_15)

				local var_165_17 = manager.ui.mainCamera.transform.position - var_165_11.position

				var_165_11.forward = Vector3.New(var_165_17.x, var_165_17.y, var_165_17.z)

				local var_165_18 = var_165_11.localEulerAngles

				var_165_18.z = 0
				var_165_18.x = 0
				var_165_11.localEulerAngles = var_165_18
			end

			if arg_162_1.time_ >= var_165_12 + var_165_14 and arg_162_1.time_ < var_165_12 + var_165_14 + arg_165_0 then
				var_165_11.localPosition = Vector3.New(0, 100, 0)

				local var_165_19 = manager.ui.mainCamera.transform.position - var_165_11.position

				var_165_11.forward = Vector3.New(var_165_19.x, var_165_19.y, var_165_19.z)

				local var_165_20 = var_165_11.localEulerAngles

				var_165_20.z = 0
				var_165_20.x = 0
				var_165_11.localEulerAngles = var_165_20

				local var_165_21 = GameObjectTools.GetOrAddComponent(var_165_11.gameObject, typeof(DynamicBoneHelper))

				if var_165_21 then
					var_165_21:EnableDynamicBone(true)
				end
			end

			local var_165_22 = 0

			if var_165_22 < arg_162_1.time_ and arg_162_1.time_ <= var_165_22 + arg_165_0 then
				arg_162_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_165_23 = 0

			if var_165_23 < arg_162_1.time_ and arg_162_1.time_ <= var_165_23 + arg_165_0 then
				arg_162_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_165_24 = arg_162_1.actors_["1042ui_story"]
			local var_165_25 = 0

			if var_165_25 < arg_162_1.time_ and arg_162_1.time_ <= var_165_25 + arg_165_0 and not isNil(var_165_24) and arg_162_1.var_.characterEffect1042ui_story == nil then
				arg_162_1.var_.characterEffect1042ui_story = var_165_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_26 = 0.2

			if var_165_25 <= arg_162_1.time_ and arg_162_1.time_ < var_165_25 + var_165_26 and not isNil(var_165_24) then
				local var_165_27 = (arg_162_1.time_ - var_165_25) / var_165_26

				if arg_162_1.var_.characterEffect1042ui_story and not isNil(var_165_24) then
					arg_162_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_25 + var_165_26 and arg_162_1.time_ < var_165_25 + var_165_26 + arg_165_0 and not isNil(var_165_24) and arg_162_1.var_.characterEffect1042ui_story then
				arg_162_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_165_28 = arg_162_1.actors_["1042ui_story"].transform
			local var_165_29 = 0

			if var_165_29 < arg_162_1.time_ and arg_162_1.time_ <= var_165_29 + arg_165_0 then
				arg_162_1.var_.moveOldPos1042ui_story = var_165_28.localPosition
			end

			local var_165_30 = 0.001

			if var_165_29 <= arg_162_1.time_ and arg_162_1.time_ < var_165_29 + var_165_30 then
				local var_165_31 = (arg_162_1.time_ - var_165_29) / var_165_30
				local var_165_32 = Vector3.New(0, -1.06, -6.2)

				var_165_28.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1042ui_story, var_165_32, var_165_31)

				local var_165_33 = manager.ui.mainCamera.transform.position - var_165_28.position

				var_165_28.forward = Vector3.New(var_165_33.x, var_165_33.y, var_165_33.z)

				local var_165_34 = var_165_28.localEulerAngles

				var_165_34.z = 0
				var_165_34.x = 0
				var_165_28.localEulerAngles = var_165_34
			end

			if arg_162_1.time_ >= var_165_29 + var_165_30 and arg_162_1.time_ < var_165_29 + var_165_30 + arg_165_0 then
				var_165_28.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_165_35 = manager.ui.mainCamera.transform.position - var_165_28.position

				var_165_28.forward = Vector3.New(var_165_35.x, var_165_35.y, var_165_35.z)

				local var_165_36 = var_165_28.localEulerAngles

				var_165_36.z = 0
				var_165_36.x = 0
				var_165_28.localEulerAngles = var_165_36
			end

			local var_165_37 = 0
			local var_165_38 = 0.6

			if var_165_37 < arg_162_1.time_ and arg_162_1.time_ <= var_165_37 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_39 = arg_162_1:FormatText(StoryNameCfg[205].name)

				arg_162_1.leftNameTxt_.text = var_165_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_40 = arg_162_1:GetWordFromCfg(113031040)
				local var_165_41 = arg_162_1:FormatText(var_165_40.content)

				arg_162_1.text_.text = var_165_41

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_42 = 24
				local var_165_43 = utf8.len(var_165_41)
				local var_165_44 = var_165_42 <= 0 and var_165_38 or var_165_38 * (var_165_43 / var_165_42)

				if var_165_44 > 0 and var_165_38 < var_165_44 then
					arg_162_1.talkMaxDuration = var_165_44

					if var_165_44 + var_165_37 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_44 + var_165_37
					end
				end

				arg_162_1.text_.text = var_165_41
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031040", "story_v_out_113031.awb") ~= 0 then
					local var_165_45 = manager.audio:GetVoiceLength("story_v_out_113031", "113031040", "story_v_out_113031.awb") / 1000

					if var_165_45 + var_165_37 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_45 + var_165_37
					end

					if var_165_40.prefab_name ~= "" and arg_162_1.actors_[var_165_40.prefab_name] ~= nil then
						local var_165_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_40.prefab_name].transform, "story_v_out_113031", "113031040", "story_v_out_113031.awb")

						arg_162_1:RecordAudio("113031040", var_165_46)
						arg_162_1:RecordAudio("113031040", var_165_46)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_113031", "113031040", "story_v_out_113031.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_113031", "113031040", "story_v_out_113031.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_47 = math.max(var_165_38, arg_162_1.talkMaxDuration)

			if var_165_37 <= arg_162_1.time_ and arg_162_1.time_ < var_165_37 + var_165_47 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_37) / var_165_47

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_37 + var_165_47 and arg_162_1.time_ < var_165_37 + var_165_47 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play113031041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 113031041
		arg_166_1.duration_ = 6.07

		local var_166_0 = {
			ja = 6.066,
			ko = 5.4,
			zh = 6.033,
			en = 5.266
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
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play113031042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1042ui_story"].transform
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.var_.moveOldPos1042ui_story = var_169_0.localPosition
			end

			local var_169_2 = 0.001

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2
				local var_169_4 = Vector3.New(0, 100, 0)

				var_169_0.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1042ui_story, var_169_4, var_169_3)

				local var_169_5 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_5.x, var_169_5.y, var_169_5.z)

				local var_169_6 = var_169_0.localEulerAngles

				var_169_6.z = 0
				var_169_6.x = 0
				var_169_0.localEulerAngles = var_169_6
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 then
				var_169_0.localPosition = Vector3.New(0, 100, 0)

				local var_169_7 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_7.x, var_169_7.y, var_169_7.z)

				local var_169_8 = var_169_0.localEulerAngles

				var_169_8.z = 0
				var_169_8.x = 0
				var_169_0.localEulerAngles = var_169_8
			end

			local var_169_9 = arg_166_1.actors_["6046_story"].transform
			local var_169_10 = 0

			if var_169_10 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1.var_.moveOldPos6046_story = var_169_9.localPosition

				local var_169_11 = GameObjectTools.GetOrAddComponent(var_169_9.gameObject, typeof(DynamicBoneHelper))

				if var_169_11 then
					var_169_11:EnableDynamicBone(false)
				end
			end

			local var_169_12 = 0.001

			if var_169_10 <= arg_166_1.time_ and arg_166_1.time_ < var_169_10 + var_169_12 then
				local var_169_13 = (arg_166_1.time_ - var_169_10) / var_169_12
				local var_169_14 = Vector3.New(0.7, -0.5, -6.3)

				var_169_9.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos6046_story, var_169_14, var_169_13)

				local var_169_15 = manager.ui.mainCamera.transform.position - var_169_9.position

				var_169_9.forward = Vector3.New(var_169_15.x, var_169_15.y, var_169_15.z)

				local var_169_16 = var_169_9.localEulerAngles

				var_169_16.z = 0
				var_169_16.x = 0
				var_169_9.localEulerAngles = var_169_16
			end

			if arg_166_1.time_ >= var_169_10 + var_169_12 and arg_166_1.time_ < var_169_10 + var_169_12 + arg_169_0 then
				var_169_9.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_169_17 = manager.ui.mainCamera.transform.position - var_169_9.position

				var_169_9.forward = Vector3.New(var_169_17.x, var_169_17.y, var_169_17.z)

				local var_169_18 = var_169_9.localEulerAngles

				var_169_18.z = 0
				var_169_18.x = 0
				var_169_9.localEulerAngles = var_169_18

				local var_169_19 = GameObjectTools.GetOrAddComponent(var_169_9.gameObject, typeof(DynamicBoneHelper))

				if var_169_19 then
					var_169_19:EnableDynamicBone(true)
				end
			end

			local var_169_20 = arg_166_1.actors_["6045_story"].transform
			local var_169_21 = 0

			if var_169_21 < arg_166_1.time_ and arg_166_1.time_ <= var_169_21 + arg_169_0 then
				arg_166_1.var_.moveOldPos6045_story = var_169_20.localPosition

				local var_169_22 = GameObjectTools.GetOrAddComponent(var_169_20.gameObject, typeof(DynamicBoneHelper))

				if var_169_22 then
					var_169_22:EnableDynamicBone(false)
				end
			end

			local var_169_23 = 0.001

			if var_169_21 <= arg_166_1.time_ and arg_166_1.time_ < var_169_21 + var_169_23 then
				local var_169_24 = (arg_166_1.time_ - var_169_21) / var_169_23
				local var_169_25 = Vector3.New(-0.7, -0.5, -6.3)

				var_169_20.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos6045_story, var_169_25, var_169_24)

				local var_169_26 = manager.ui.mainCamera.transform.position - var_169_20.position

				var_169_20.forward = Vector3.New(var_169_26.x, var_169_26.y, var_169_26.z)

				local var_169_27 = var_169_20.localEulerAngles

				var_169_27.z = 0
				var_169_27.x = 0
				var_169_20.localEulerAngles = var_169_27
			end

			if arg_166_1.time_ >= var_169_21 + var_169_23 and arg_166_1.time_ < var_169_21 + var_169_23 + arg_169_0 then
				var_169_20.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_169_28 = manager.ui.mainCamera.transform.position - var_169_20.position

				var_169_20.forward = Vector3.New(var_169_28.x, var_169_28.y, var_169_28.z)

				local var_169_29 = var_169_20.localEulerAngles

				var_169_29.z = 0
				var_169_29.x = 0
				var_169_20.localEulerAngles = var_169_29

				local var_169_30 = GameObjectTools.GetOrAddComponent(var_169_20.gameObject, typeof(DynamicBoneHelper))

				if var_169_30 then
					var_169_30:EnableDynamicBone(true)
				end
			end

			local var_169_31 = 0

			if var_169_31 < arg_166_1.time_ and arg_166_1.time_ <= var_169_31 + arg_169_0 then
				arg_166_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_169_32 = arg_166_1.actors_["6045_story"]
			local var_169_33 = 0

			if var_169_33 < arg_166_1.time_ and arg_166_1.time_ <= var_169_33 + arg_169_0 and not isNil(var_169_32) and arg_166_1.var_.characterEffect6045_story == nil then
				arg_166_1.var_.characterEffect6045_story = var_169_32:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_34 = 0.2

			if var_169_33 <= arg_166_1.time_ and arg_166_1.time_ < var_169_33 + var_169_34 and not isNil(var_169_32) then
				local var_169_35 = (arg_166_1.time_ - var_169_33) / var_169_34

				if arg_166_1.var_.characterEffect6045_story and not isNil(var_169_32) then
					arg_166_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= var_169_33 + var_169_34 and arg_166_1.time_ < var_169_33 + var_169_34 + arg_169_0 and not isNil(var_169_32) and arg_166_1.var_.characterEffect6045_story then
				arg_166_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_169_36 = 0

			if var_169_36 < arg_166_1.time_ and arg_166_1.time_ <= var_169_36 + arg_169_0 then
				arg_166_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_169_37 = 0
			local var_169_38 = 0.45

			if var_169_37 < arg_166_1.time_ and arg_166_1.time_ <= var_169_37 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_39 = arg_166_1:FormatText(StoryNameCfg[215].name)

				arg_166_1.leftNameTxt_.text = var_169_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_40 = arg_166_1:GetWordFromCfg(113031041)
				local var_169_41 = arg_166_1:FormatText(var_169_40.content)

				arg_166_1.text_.text = var_169_41

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_42 = 18
				local var_169_43 = utf8.len(var_169_41)
				local var_169_44 = var_169_42 <= 0 and var_169_38 or var_169_38 * (var_169_43 / var_169_42)

				if var_169_44 > 0 and var_169_38 < var_169_44 then
					arg_166_1.talkMaxDuration = var_169_44

					if var_169_44 + var_169_37 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_44 + var_169_37
					end
				end

				arg_166_1.text_.text = var_169_41
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031041", "story_v_out_113031.awb") ~= 0 then
					local var_169_45 = manager.audio:GetVoiceLength("story_v_out_113031", "113031041", "story_v_out_113031.awb") / 1000

					if var_169_45 + var_169_37 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_45 + var_169_37
					end

					if var_169_40.prefab_name ~= "" and arg_166_1.actors_[var_169_40.prefab_name] ~= nil then
						local var_169_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_40.prefab_name].transform, "story_v_out_113031", "113031041", "story_v_out_113031.awb")

						arg_166_1:RecordAudio("113031041", var_169_46)
						arg_166_1:RecordAudio("113031041", var_169_46)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_113031", "113031041", "story_v_out_113031.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_113031", "113031041", "story_v_out_113031.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_47 = math.max(var_169_38, arg_166_1.talkMaxDuration)

			if var_169_37 <= arg_166_1.time_ and arg_166_1.time_ < var_169_37 + var_169_47 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_37) / var_169_47

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_37 + var_169_47 and arg_166_1.time_ < var_169_37 + var_169_47 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play113031042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 113031042
		arg_170_1.duration_ = 4.37

		local var_170_0 = {
			ja = 3.2,
			ko = 3.3,
			zh = 4.366,
			en = 2.366
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play113031043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["6045_story"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect6045_story == nil then
				arg_170_1.var_.characterEffect6045_story = var_173_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.2

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.characterEffect6045_story and not isNil(var_173_0) then
					local var_173_4 = Mathf.Lerp(0, 0.5, var_173_3)

					arg_170_1.var_.characterEffect6045_story.fillFlat = true
					arg_170_1.var_.characterEffect6045_story.fillRatio = var_173_4
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect6045_story then
				local var_173_5 = 0.5

				arg_170_1.var_.characterEffect6045_story.fillFlat = true
				arg_170_1.var_.characterEffect6045_story.fillRatio = var_173_5
			end

			local var_173_6 = 0

			if var_173_6 < arg_170_1.time_ and arg_170_1.time_ <= var_173_6 + arg_173_0 then
				arg_170_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			local var_173_7 = arg_170_1.actors_["6046_story"]
			local var_173_8 = 0

			if var_173_8 < arg_170_1.time_ and arg_170_1.time_ <= var_173_8 + arg_173_0 and not isNil(var_173_7) and arg_170_1.var_.characterEffect6046_story == nil then
				arg_170_1.var_.characterEffect6046_story = var_173_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_9 = 0.2

			if var_173_8 <= arg_170_1.time_ and arg_170_1.time_ < var_173_8 + var_173_9 and not isNil(var_173_7) then
				local var_173_10 = (arg_170_1.time_ - var_173_8) / var_173_9

				if arg_170_1.var_.characterEffect6046_story and not isNil(var_173_7) then
					arg_170_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_8 + var_173_9 and arg_170_1.time_ < var_173_8 + var_173_9 + arg_173_0 and not isNil(var_173_7) and arg_170_1.var_.characterEffect6046_story then
				arg_170_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_173_11 = 0

			if var_173_11 < arg_170_1.time_ and arg_170_1.time_ <= var_173_11 + arg_173_0 then
				arg_170_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_173_12 = 0
			local var_173_13 = 0.425

			if var_173_12 < arg_170_1.time_ and arg_170_1.time_ <= var_173_12 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_14 = arg_170_1:FormatText(StoryNameCfg[214].name)

				arg_170_1.leftNameTxt_.text = var_173_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_15 = arg_170_1:GetWordFromCfg(113031042)
				local var_173_16 = arg_170_1:FormatText(var_173_15.content)

				arg_170_1.text_.text = var_173_16

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_17 = 17
				local var_173_18 = utf8.len(var_173_16)
				local var_173_19 = var_173_17 <= 0 and var_173_13 or var_173_13 * (var_173_18 / var_173_17)

				if var_173_19 > 0 and var_173_13 < var_173_19 then
					arg_170_1.talkMaxDuration = var_173_19

					if var_173_19 + var_173_12 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_19 + var_173_12
					end
				end

				arg_170_1.text_.text = var_173_16
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031042", "story_v_out_113031.awb") ~= 0 then
					local var_173_20 = manager.audio:GetVoiceLength("story_v_out_113031", "113031042", "story_v_out_113031.awb") / 1000

					if var_173_20 + var_173_12 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_20 + var_173_12
					end

					if var_173_15.prefab_name ~= "" and arg_170_1.actors_[var_173_15.prefab_name] ~= nil then
						local var_173_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_15.prefab_name].transform, "story_v_out_113031", "113031042", "story_v_out_113031.awb")

						arg_170_1:RecordAudio("113031042", var_173_21)
						arg_170_1:RecordAudio("113031042", var_173_21)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_113031", "113031042", "story_v_out_113031.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_113031", "113031042", "story_v_out_113031.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_22 = math.max(var_173_13, arg_170_1.talkMaxDuration)

			if var_173_12 <= arg_170_1.time_ and arg_170_1.time_ < var_173_12 + var_173_22 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_12) / var_173_22

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_12 + var_173_22 and arg_170_1.time_ < var_173_12 + var_173_22 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play113031043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 113031043
		arg_174_1.duration_ = 18.87

		local var_174_0 = {
			ja = 18.866,
			ko = 10.8,
			zh = 11.266,
			en = 13.166
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play113031044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["6045_story"].transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPos6045_story = var_177_0.localPosition

				local var_177_2 = GameObjectTools.GetOrAddComponent(var_177_0.gameObject, typeof(DynamicBoneHelper))

				if var_177_2 then
					var_177_2:EnableDynamicBone(false)
				end
			end

			local var_177_3 = 0.001

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_3 then
				local var_177_4 = (arg_174_1.time_ - var_177_1) / var_177_3
				local var_177_5 = Vector3.New(0, 100, 0)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos6045_story, var_177_5, var_177_4)

				local var_177_6 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_6.x, var_177_6.y, var_177_6.z)

				local var_177_7 = var_177_0.localEulerAngles

				var_177_7.z = 0
				var_177_7.x = 0
				var_177_0.localEulerAngles = var_177_7
			end

			if arg_174_1.time_ >= var_177_1 + var_177_3 and arg_174_1.time_ < var_177_1 + var_177_3 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(0, 100, 0)

				local var_177_8 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_8.x, var_177_8.y, var_177_8.z)

				local var_177_9 = var_177_0.localEulerAngles

				var_177_9.z = 0
				var_177_9.x = 0
				var_177_0.localEulerAngles = var_177_9

				local var_177_10 = GameObjectTools.GetOrAddComponent(var_177_0.gameObject, typeof(DynamicBoneHelper))

				if var_177_10 then
					var_177_10:EnableDynamicBone(true)
				end
			end

			local var_177_11 = arg_174_1.actors_["6046_story"].transform
			local var_177_12 = 0

			if var_177_12 < arg_174_1.time_ and arg_174_1.time_ <= var_177_12 + arg_177_0 then
				arg_174_1.var_.moveOldPos6046_story = var_177_11.localPosition

				local var_177_13 = GameObjectTools.GetOrAddComponent(var_177_11.gameObject, typeof(DynamicBoneHelper))

				if var_177_13 then
					var_177_13:EnableDynamicBone(false)
				end
			end

			local var_177_14 = 0.001

			if var_177_12 <= arg_174_1.time_ and arg_174_1.time_ < var_177_12 + var_177_14 then
				local var_177_15 = (arg_174_1.time_ - var_177_12) / var_177_14
				local var_177_16 = Vector3.New(0, 100, 0)

				var_177_11.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos6046_story, var_177_16, var_177_15)

				local var_177_17 = manager.ui.mainCamera.transform.position - var_177_11.position

				var_177_11.forward = Vector3.New(var_177_17.x, var_177_17.y, var_177_17.z)

				local var_177_18 = var_177_11.localEulerAngles

				var_177_18.z = 0
				var_177_18.x = 0
				var_177_11.localEulerAngles = var_177_18
			end

			if arg_174_1.time_ >= var_177_12 + var_177_14 and arg_174_1.time_ < var_177_12 + var_177_14 + arg_177_0 then
				var_177_11.localPosition = Vector3.New(0, 100, 0)

				local var_177_19 = manager.ui.mainCamera.transform.position - var_177_11.position

				var_177_11.forward = Vector3.New(var_177_19.x, var_177_19.y, var_177_19.z)

				local var_177_20 = var_177_11.localEulerAngles

				var_177_20.z = 0
				var_177_20.x = 0
				var_177_11.localEulerAngles = var_177_20

				local var_177_21 = GameObjectTools.GetOrAddComponent(var_177_11.gameObject, typeof(DynamicBoneHelper))

				if var_177_21 then
					var_177_21:EnableDynamicBone(true)
				end
			end

			local var_177_22 = arg_174_1.actors_["1041ui_story"].transform
			local var_177_23 = 0

			if var_177_23 < arg_174_1.time_ and arg_174_1.time_ <= var_177_23 + arg_177_0 then
				arg_174_1.var_.moveOldPos1041ui_story = var_177_22.localPosition
			end

			local var_177_24 = 0.001

			if var_177_23 <= arg_174_1.time_ and arg_174_1.time_ < var_177_23 + var_177_24 then
				local var_177_25 = (arg_174_1.time_ - var_177_23) / var_177_24
				local var_177_26 = Vector3.New(-0.7, -1.11, -5.9)

				var_177_22.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1041ui_story, var_177_26, var_177_25)

				local var_177_27 = manager.ui.mainCamera.transform.position - var_177_22.position

				var_177_22.forward = Vector3.New(var_177_27.x, var_177_27.y, var_177_27.z)

				local var_177_28 = var_177_22.localEulerAngles

				var_177_28.z = 0
				var_177_28.x = 0
				var_177_22.localEulerAngles = var_177_28
			end

			if arg_174_1.time_ >= var_177_23 + var_177_24 and arg_174_1.time_ < var_177_23 + var_177_24 + arg_177_0 then
				var_177_22.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_177_29 = manager.ui.mainCamera.transform.position - var_177_22.position

				var_177_22.forward = Vector3.New(var_177_29.x, var_177_29.y, var_177_29.z)

				local var_177_30 = var_177_22.localEulerAngles

				var_177_30.z = 0
				var_177_30.x = 0
				var_177_22.localEulerAngles = var_177_30
			end

			local var_177_31 = 0

			if var_177_31 < arg_174_1.time_ and arg_174_1.time_ <= var_177_31 + arg_177_0 then
				arg_174_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_177_32 = 0

			if var_177_32 < arg_174_1.time_ and arg_174_1.time_ <= var_177_32 + arg_177_0 then
				arg_174_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_177_33 = arg_174_1.actors_["1041ui_story"]
			local var_177_34 = 0

			if var_177_34 < arg_174_1.time_ and arg_174_1.time_ <= var_177_34 + arg_177_0 and not isNil(var_177_33) and arg_174_1.var_.characterEffect1041ui_story == nil then
				arg_174_1.var_.characterEffect1041ui_story = var_177_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_35 = 0.2

			if var_177_34 <= arg_174_1.time_ and arg_174_1.time_ < var_177_34 + var_177_35 and not isNil(var_177_33) then
				local var_177_36 = (arg_174_1.time_ - var_177_34) / var_177_35

				if arg_174_1.var_.characterEffect1041ui_story and not isNil(var_177_33) then
					arg_174_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= var_177_34 + var_177_35 and arg_174_1.time_ < var_177_34 + var_177_35 + arg_177_0 and not isNil(var_177_33) and arg_174_1.var_.characterEffect1041ui_story then
				arg_174_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_177_37 = 0
			local var_177_38 = 1.375

			if var_177_37 < arg_174_1.time_ and arg_174_1.time_ <= var_177_37 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_39 = arg_174_1:FormatText(StoryNameCfg[208].name)

				arg_174_1.leftNameTxt_.text = var_177_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_40 = arg_174_1:GetWordFromCfg(113031043)
				local var_177_41 = arg_174_1:FormatText(var_177_40.content)

				arg_174_1.text_.text = var_177_41

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_42 = 55
				local var_177_43 = utf8.len(var_177_41)
				local var_177_44 = var_177_42 <= 0 and var_177_38 or var_177_38 * (var_177_43 / var_177_42)

				if var_177_44 > 0 and var_177_38 < var_177_44 then
					arg_174_1.talkMaxDuration = var_177_44

					if var_177_44 + var_177_37 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_44 + var_177_37
					end
				end

				arg_174_1.text_.text = var_177_41
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031043", "story_v_out_113031.awb") ~= 0 then
					local var_177_45 = manager.audio:GetVoiceLength("story_v_out_113031", "113031043", "story_v_out_113031.awb") / 1000

					if var_177_45 + var_177_37 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_45 + var_177_37
					end

					if var_177_40.prefab_name ~= "" and arg_174_1.actors_[var_177_40.prefab_name] ~= nil then
						local var_177_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_40.prefab_name].transform, "story_v_out_113031", "113031043", "story_v_out_113031.awb")

						arg_174_1:RecordAudio("113031043", var_177_46)
						arg_174_1:RecordAudio("113031043", var_177_46)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_113031", "113031043", "story_v_out_113031.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_113031", "113031043", "story_v_out_113031.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_47 = math.max(var_177_38, arg_174_1.talkMaxDuration)

			if var_177_37 <= arg_174_1.time_ and arg_174_1.time_ < var_177_37 + var_177_47 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_37) / var_177_47

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_37 + var_177_47 and arg_174_1.time_ < var_177_37 + var_177_47 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play113031044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 113031044
		arg_178_1.duration_ = 10.27

		local var_178_0 = {
			ja = 10.266,
			ko = 4.933,
			zh = 4.2,
			en = 6.3
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play113031045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1041ui_story"]
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1041ui_story == nil then
				arg_178_1.var_.characterEffect1041ui_story = var_181_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.2

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 and not isNil(var_181_0) then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2

				if arg_178_1.var_.characterEffect1041ui_story and not isNil(var_181_0) then
					local var_181_4 = Mathf.Lerp(0, 0.5, var_181_3)

					arg_178_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1041ui_story.fillRatio = var_181_4
				end
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 and not isNil(var_181_0) and arg_178_1.var_.characterEffect1041ui_story then
				local var_181_5 = 0.5

				arg_178_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1041ui_story.fillRatio = var_181_5
			end

			local var_181_6 = arg_178_1.actors_["1038ui_story"].transform
			local var_181_7 = 0

			if var_181_7 < arg_178_1.time_ and arg_178_1.time_ <= var_181_7 + arg_181_0 then
				arg_178_1.var_.moveOldPos1038ui_story = var_181_6.localPosition
			end

			local var_181_8 = 0.001

			if var_181_7 <= arg_178_1.time_ and arg_178_1.time_ < var_181_7 + var_181_8 then
				local var_181_9 = (arg_178_1.time_ - var_181_7) / var_181_8
				local var_181_10 = Vector3.New(0.7, -1.11, -5.9)

				var_181_6.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1038ui_story, var_181_10, var_181_9)

				local var_181_11 = manager.ui.mainCamera.transform.position - var_181_6.position

				var_181_6.forward = Vector3.New(var_181_11.x, var_181_11.y, var_181_11.z)

				local var_181_12 = var_181_6.localEulerAngles

				var_181_12.z = 0
				var_181_12.x = 0
				var_181_6.localEulerAngles = var_181_12
			end

			if arg_178_1.time_ >= var_181_7 + var_181_8 and arg_178_1.time_ < var_181_7 + var_181_8 + arg_181_0 then
				var_181_6.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_181_13 = manager.ui.mainCamera.transform.position - var_181_6.position

				var_181_6.forward = Vector3.New(var_181_13.x, var_181_13.y, var_181_13.z)

				local var_181_14 = var_181_6.localEulerAngles

				var_181_14.z = 0
				var_181_14.x = 0
				var_181_6.localEulerAngles = var_181_14
			end

			local var_181_15 = 0

			if var_181_15 < arg_178_1.time_ and arg_178_1.time_ <= var_181_15 + arg_181_0 then
				arg_178_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action2_1")
			end

			local var_181_16 = 0

			if var_181_16 < arg_178_1.time_ and arg_178_1.time_ <= var_181_16 + arg_181_0 then
				arg_178_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_181_17 = arg_178_1.actors_["1038ui_story"]
			local var_181_18 = 0

			if var_181_18 < arg_178_1.time_ and arg_178_1.time_ <= var_181_18 + arg_181_0 and not isNil(var_181_17) and arg_178_1.var_.characterEffect1038ui_story == nil then
				arg_178_1.var_.characterEffect1038ui_story = var_181_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_19 = 0.2

			if var_181_18 <= arg_178_1.time_ and arg_178_1.time_ < var_181_18 + var_181_19 and not isNil(var_181_17) then
				local var_181_20 = (arg_178_1.time_ - var_181_18) / var_181_19

				if arg_178_1.var_.characterEffect1038ui_story and not isNil(var_181_17) then
					arg_178_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_18 + var_181_19 and arg_178_1.time_ < var_181_18 + var_181_19 + arg_181_0 and not isNil(var_181_17) and arg_178_1.var_.characterEffect1038ui_story then
				arg_178_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_181_21 = 0
			local var_181_22 = 0.625

			if var_181_21 < arg_178_1.time_ and arg_178_1.time_ <= var_181_21 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_23 = arg_178_1:FormatText(StoryNameCfg[94].name)

				arg_178_1.leftNameTxt_.text = var_181_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_24 = arg_178_1:GetWordFromCfg(113031044)
				local var_181_25 = arg_178_1:FormatText(var_181_24.content)

				arg_178_1.text_.text = var_181_25

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_26 = 25
				local var_181_27 = utf8.len(var_181_25)
				local var_181_28 = var_181_26 <= 0 and var_181_22 or var_181_22 * (var_181_27 / var_181_26)

				if var_181_28 > 0 and var_181_22 < var_181_28 then
					arg_178_1.talkMaxDuration = var_181_28

					if var_181_28 + var_181_21 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_28 + var_181_21
					end
				end

				arg_178_1.text_.text = var_181_25
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031044", "story_v_out_113031.awb") ~= 0 then
					local var_181_29 = manager.audio:GetVoiceLength("story_v_out_113031", "113031044", "story_v_out_113031.awb") / 1000

					if var_181_29 + var_181_21 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_29 + var_181_21
					end

					if var_181_24.prefab_name ~= "" and arg_178_1.actors_[var_181_24.prefab_name] ~= nil then
						local var_181_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_24.prefab_name].transform, "story_v_out_113031", "113031044", "story_v_out_113031.awb")

						arg_178_1:RecordAudio("113031044", var_181_30)
						arg_178_1:RecordAudio("113031044", var_181_30)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_113031", "113031044", "story_v_out_113031.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_113031", "113031044", "story_v_out_113031.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_31 = math.max(var_181_22, arg_178_1.talkMaxDuration)

			if var_181_21 <= arg_178_1.time_ and arg_178_1.time_ < var_181_21 + var_181_31 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_21) / var_181_31

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_21 + var_181_31 and arg_178_1.time_ < var_181_21 + var_181_31 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play113031045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 113031045
		arg_182_1.duration_ = 9.27

		local var_182_0 = {
			ja = 9.266,
			ko = 7.5,
			zh = 7.766,
			en = 8.8
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play113031046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1038ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1038ui_story == nil then
				arg_182_1.var_.characterEffect1038ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.2

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect1038ui_story and not isNil(var_185_0) then
					local var_185_4 = Mathf.Lerp(0, 0.5, var_185_3)

					arg_182_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1038ui_story.fillRatio = var_185_4
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1038ui_story then
				local var_185_5 = 0.5

				arg_182_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1038ui_story.fillRatio = var_185_5
			end

			local var_185_6 = arg_182_1.actors_["1041ui_story"]
			local var_185_7 = 0

			if var_185_7 < arg_182_1.time_ and arg_182_1.time_ <= var_185_7 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect1041ui_story == nil then
				arg_182_1.var_.characterEffect1041ui_story = var_185_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_8 = 0.2

			if var_185_7 <= arg_182_1.time_ and arg_182_1.time_ < var_185_7 + var_185_8 and not isNil(var_185_6) then
				local var_185_9 = (arg_182_1.time_ - var_185_7) / var_185_8

				if arg_182_1.var_.characterEffect1041ui_story and not isNil(var_185_6) then
					arg_182_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_7 + var_185_8 and arg_182_1.time_ < var_185_7 + var_185_8 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect1041ui_story then
				arg_182_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_185_10 = 0

			if var_185_10 < arg_182_1.time_ and arg_182_1.time_ <= var_185_10 + arg_185_0 then
				arg_182_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_185_11 = 0

			if var_185_11 < arg_182_1.time_ and arg_182_1.time_ <= var_185_11 + arg_185_0 then
				arg_182_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_1")
			end

			local var_185_12 = 0
			local var_185_13 = 0.85

			if var_185_12 < arg_182_1.time_ and arg_182_1.time_ <= var_185_12 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_14 = arg_182_1:FormatText(StoryNameCfg[208].name)

				arg_182_1.leftNameTxt_.text = var_185_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_15 = arg_182_1:GetWordFromCfg(113031045)
				local var_185_16 = arg_182_1:FormatText(var_185_15.content)

				arg_182_1.text_.text = var_185_16

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_17 = 34
				local var_185_18 = utf8.len(var_185_16)
				local var_185_19 = var_185_17 <= 0 and var_185_13 or var_185_13 * (var_185_18 / var_185_17)

				if var_185_19 > 0 and var_185_13 < var_185_19 then
					arg_182_1.talkMaxDuration = var_185_19

					if var_185_19 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_19 + var_185_12
					end
				end

				arg_182_1.text_.text = var_185_16
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031045", "story_v_out_113031.awb") ~= 0 then
					local var_185_20 = manager.audio:GetVoiceLength("story_v_out_113031", "113031045", "story_v_out_113031.awb") / 1000

					if var_185_20 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_20 + var_185_12
					end

					if var_185_15.prefab_name ~= "" and arg_182_1.actors_[var_185_15.prefab_name] ~= nil then
						local var_185_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_15.prefab_name].transform, "story_v_out_113031", "113031045", "story_v_out_113031.awb")

						arg_182_1:RecordAudio("113031045", var_185_21)
						arg_182_1:RecordAudio("113031045", var_185_21)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_113031", "113031045", "story_v_out_113031.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_113031", "113031045", "story_v_out_113031.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_22 = math.max(var_185_13, arg_182_1.talkMaxDuration)

			if var_185_12 <= arg_182_1.time_ and arg_182_1.time_ < var_185_12 + var_185_22 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_12) / var_185_22

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_12 + var_185_22 and arg_182_1.time_ < var_185_12 + var_185_22 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play113031046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 113031046
		arg_186_1.duration_ = 6.7

		local var_186_0 = {
			ja = 6.7,
			ko = 5.766,
			zh = 5.1,
			en = 5.866
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play113031047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_2")
			end

			local var_189_2 = 0
			local var_189_3 = 0.55

			if var_189_2 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_4 = arg_186_1:FormatText(StoryNameCfg[208].name)

				arg_186_1.leftNameTxt_.text = var_189_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_5 = arg_186_1:GetWordFromCfg(113031046)
				local var_189_6 = arg_186_1:FormatText(var_189_5.content)

				arg_186_1.text_.text = var_189_6

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_7 = 22
				local var_189_8 = utf8.len(var_189_6)
				local var_189_9 = var_189_7 <= 0 and var_189_3 or var_189_3 * (var_189_8 / var_189_7)

				if var_189_9 > 0 and var_189_3 < var_189_9 then
					arg_186_1.talkMaxDuration = var_189_9

					if var_189_9 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_9 + var_189_2
					end
				end

				arg_186_1.text_.text = var_189_6
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031046", "story_v_out_113031.awb") ~= 0 then
					local var_189_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031046", "story_v_out_113031.awb") / 1000

					if var_189_10 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_10 + var_189_2
					end

					if var_189_5.prefab_name ~= "" and arg_186_1.actors_[var_189_5.prefab_name] ~= nil then
						local var_189_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_5.prefab_name].transform, "story_v_out_113031", "113031046", "story_v_out_113031.awb")

						arg_186_1:RecordAudio("113031046", var_189_11)
						arg_186_1:RecordAudio("113031046", var_189_11)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_113031", "113031046", "story_v_out_113031.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_113031", "113031046", "story_v_out_113031.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_12 = math.max(var_189_3, arg_186_1.talkMaxDuration)

			if var_189_2 <= arg_186_1.time_ and arg_186_1.time_ < var_189_2 + var_189_12 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_2) / var_189_12

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_2 + var_189_12 and arg_186_1.time_ < var_189_2 + var_189_12 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play113031047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 113031047
		arg_190_1.duration_ = 5.53

		local var_190_0 = {
			ja = 5.533,
			ko = 3.833,
			zh = 4.6,
			en = 4.3
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play113031048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1041ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1041ui_story == nil then
				arg_190_1.var_.characterEffect1041ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.2

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1041ui_story and not isNil(var_193_0) then
					local var_193_4 = Mathf.Lerp(0, 0.5, var_193_3)

					arg_190_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1041ui_story.fillRatio = var_193_4
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1041ui_story then
				local var_193_5 = 0.5

				arg_190_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1041ui_story.fillRatio = var_193_5
			end

			local var_193_6 = 0

			if var_193_6 < arg_190_1.time_ and arg_190_1.time_ <= var_193_6 + arg_193_0 then
				arg_190_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_193_7 = arg_190_1.actors_["1038ui_story"]
			local var_193_8 = 0

			if var_193_8 < arg_190_1.time_ and arg_190_1.time_ <= var_193_8 + arg_193_0 and not isNil(var_193_7) and arg_190_1.var_.characterEffect1038ui_story == nil then
				arg_190_1.var_.characterEffect1038ui_story = var_193_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_9 = 0.2

			if var_193_8 <= arg_190_1.time_ and arg_190_1.time_ < var_193_8 + var_193_9 and not isNil(var_193_7) then
				local var_193_10 = (arg_190_1.time_ - var_193_8) / var_193_9

				if arg_190_1.var_.characterEffect1038ui_story and not isNil(var_193_7) then
					arg_190_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_8 + var_193_9 and arg_190_1.time_ < var_193_8 + var_193_9 + arg_193_0 and not isNil(var_193_7) and arg_190_1.var_.characterEffect1038ui_story then
				arg_190_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_193_11 = 0
			local var_193_12 = 0.45

			if var_193_11 < arg_190_1.time_ and arg_190_1.time_ <= var_193_11 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_13 = arg_190_1:FormatText(StoryNameCfg[94].name)

				arg_190_1.leftNameTxt_.text = var_193_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_14 = arg_190_1:GetWordFromCfg(113031047)
				local var_193_15 = arg_190_1:FormatText(var_193_14.content)

				arg_190_1.text_.text = var_193_15

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_16 = 18
				local var_193_17 = utf8.len(var_193_15)
				local var_193_18 = var_193_16 <= 0 and var_193_12 or var_193_12 * (var_193_17 / var_193_16)

				if var_193_18 > 0 and var_193_12 < var_193_18 then
					arg_190_1.talkMaxDuration = var_193_18

					if var_193_18 + var_193_11 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_18 + var_193_11
					end
				end

				arg_190_1.text_.text = var_193_15
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031047", "story_v_out_113031.awb") ~= 0 then
					local var_193_19 = manager.audio:GetVoiceLength("story_v_out_113031", "113031047", "story_v_out_113031.awb") / 1000

					if var_193_19 + var_193_11 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_19 + var_193_11
					end

					if var_193_14.prefab_name ~= "" and arg_190_1.actors_[var_193_14.prefab_name] ~= nil then
						local var_193_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_14.prefab_name].transform, "story_v_out_113031", "113031047", "story_v_out_113031.awb")

						arg_190_1:RecordAudio("113031047", var_193_20)
						arg_190_1:RecordAudio("113031047", var_193_20)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_113031", "113031047", "story_v_out_113031.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_113031", "113031047", "story_v_out_113031.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_21 = math.max(var_193_12, arg_190_1.talkMaxDuration)

			if var_193_11 <= arg_190_1.time_ and arg_190_1.time_ < var_193_11 + var_193_21 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_11) / var_193_21

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_11 + var_193_21 and arg_190_1.time_ < var_193_11 + var_193_21 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play113031048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 113031048
		arg_194_1.duration_ = 10.33

		local var_194_0 = {
			ja = 8.8,
			ko = 8.1,
			zh = 10.033,
			en = 10.333
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play113031049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1041ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1041ui_story == nil then
				arg_194_1.var_.characterEffect1041ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.2

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect1041ui_story and not isNil(var_197_0) then
					arg_194_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1041ui_story then
				arg_194_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_197_4 = 0

			if var_197_4 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_197_5 = arg_194_1.actors_["1038ui_story"]
			local var_197_6 = 0

			if var_197_6 < arg_194_1.time_ and arg_194_1.time_ <= var_197_6 + arg_197_0 and not isNil(var_197_5) and arg_194_1.var_.characterEffect1038ui_story == nil then
				arg_194_1.var_.characterEffect1038ui_story = var_197_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_7 = 0.2

			if var_197_6 <= arg_194_1.time_ and arg_194_1.time_ < var_197_6 + var_197_7 and not isNil(var_197_5) then
				local var_197_8 = (arg_194_1.time_ - var_197_6) / var_197_7

				if arg_194_1.var_.characterEffect1038ui_story and not isNil(var_197_5) then
					local var_197_9 = Mathf.Lerp(0, 0.5, var_197_8)

					arg_194_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1038ui_story.fillRatio = var_197_9
				end
			end

			if arg_194_1.time_ >= var_197_6 + var_197_7 and arg_194_1.time_ < var_197_6 + var_197_7 + arg_197_0 and not isNil(var_197_5) and arg_194_1.var_.characterEffect1038ui_story then
				local var_197_10 = 0.5

				arg_194_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1038ui_story.fillRatio = var_197_10
			end

			local var_197_11 = 0
			local var_197_12 = 1.225

			if var_197_11 < arg_194_1.time_ and arg_194_1.time_ <= var_197_11 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_13 = arg_194_1:FormatText(StoryNameCfg[208].name)

				arg_194_1.leftNameTxt_.text = var_197_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_14 = arg_194_1:GetWordFromCfg(113031048)
				local var_197_15 = arg_194_1:FormatText(var_197_14.content)

				arg_194_1.text_.text = var_197_15

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_16 = 49
				local var_197_17 = utf8.len(var_197_15)
				local var_197_18 = var_197_16 <= 0 and var_197_12 or var_197_12 * (var_197_17 / var_197_16)

				if var_197_18 > 0 and var_197_12 < var_197_18 then
					arg_194_1.talkMaxDuration = var_197_18

					if var_197_18 + var_197_11 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_18 + var_197_11
					end
				end

				arg_194_1.text_.text = var_197_15
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031048", "story_v_out_113031.awb") ~= 0 then
					local var_197_19 = manager.audio:GetVoiceLength("story_v_out_113031", "113031048", "story_v_out_113031.awb") / 1000

					if var_197_19 + var_197_11 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_19 + var_197_11
					end

					if var_197_14.prefab_name ~= "" and arg_194_1.actors_[var_197_14.prefab_name] ~= nil then
						local var_197_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_14.prefab_name].transform, "story_v_out_113031", "113031048", "story_v_out_113031.awb")

						arg_194_1:RecordAudio("113031048", var_197_20)
						arg_194_1:RecordAudio("113031048", var_197_20)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_113031", "113031048", "story_v_out_113031.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_113031", "113031048", "story_v_out_113031.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_21 = math.max(var_197_12, arg_194_1.talkMaxDuration)

			if var_197_11 <= arg_194_1.time_ and arg_194_1.time_ < var_197_11 + var_197_21 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_11) / var_197_21

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_11 + var_197_21 and arg_194_1.time_ < var_197_11 + var_197_21 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play113031049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 113031049
		arg_198_1.duration_ = 7.5

		local var_198_0 = {
			ja = 7.5,
			ko = 5.3,
			zh = 5.666,
			en = 5.9
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play113031050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1041ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1041ui_story == nil then
				arg_198_1.var_.characterEffect1041ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.2

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect1041ui_story and not isNil(var_201_0) then
					local var_201_4 = Mathf.Lerp(0, 0.5, var_201_3)

					arg_198_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1041ui_story.fillRatio = var_201_4
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1041ui_story then
				local var_201_5 = 0.5

				arg_198_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1041ui_story.fillRatio = var_201_5
			end

			local var_201_6 = arg_198_1.actors_["1038ui_story"]
			local var_201_7 = 0

			if var_201_7 < arg_198_1.time_ and arg_198_1.time_ <= var_201_7 + arg_201_0 and not isNil(var_201_6) and arg_198_1.var_.characterEffect1038ui_story == nil then
				arg_198_1.var_.characterEffect1038ui_story = var_201_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_8 = 0.2

			if var_201_7 <= arg_198_1.time_ and arg_198_1.time_ < var_201_7 + var_201_8 and not isNil(var_201_6) then
				local var_201_9 = (arg_198_1.time_ - var_201_7) / var_201_8

				if arg_198_1.var_.characterEffect1038ui_story and not isNil(var_201_6) then
					arg_198_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_7 + var_201_8 and arg_198_1.time_ < var_201_7 + var_201_8 + arg_201_0 and not isNil(var_201_6) and arg_198_1.var_.characterEffect1038ui_story then
				arg_198_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_201_10 = 0

			if var_201_10 < arg_198_1.time_ and arg_198_1.time_ <= var_201_10 + arg_201_0 then
				arg_198_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action425")
			end

			local var_201_11 = 0

			if var_201_11 < arg_198_1.time_ and arg_198_1.time_ <= var_201_11 + arg_201_0 then
				arg_198_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_201_12 = 0
			local var_201_13 = 0.525

			if var_201_12 < arg_198_1.time_ and arg_198_1.time_ <= var_201_12 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_14 = arg_198_1:FormatText(StoryNameCfg[94].name)

				arg_198_1.leftNameTxt_.text = var_201_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_15 = arg_198_1:GetWordFromCfg(113031049)
				local var_201_16 = arg_198_1:FormatText(var_201_15.content)

				arg_198_1.text_.text = var_201_16

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_17 = 21
				local var_201_18 = utf8.len(var_201_16)
				local var_201_19 = var_201_17 <= 0 and var_201_13 or var_201_13 * (var_201_18 / var_201_17)

				if var_201_19 > 0 and var_201_13 < var_201_19 then
					arg_198_1.talkMaxDuration = var_201_19

					if var_201_19 + var_201_12 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_19 + var_201_12
					end
				end

				arg_198_1.text_.text = var_201_16
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031049", "story_v_out_113031.awb") ~= 0 then
					local var_201_20 = manager.audio:GetVoiceLength("story_v_out_113031", "113031049", "story_v_out_113031.awb") / 1000

					if var_201_20 + var_201_12 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_20 + var_201_12
					end

					if var_201_15.prefab_name ~= "" and arg_198_1.actors_[var_201_15.prefab_name] ~= nil then
						local var_201_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_15.prefab_name].transform, "story_v_out_113031", "113031049", "story_v_out_113031.awb")

						arg_198_1:RecordAudio("113031049", var_201_21)
						arg_198_1:RecordAudio("113031049", var_201_21)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_113031", "113031049", "story_v_out_113031.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_113031", "113031049", "story_v_out_113031.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_22 = math.max(var_201_13, arg_198_1.talkMaxDuration)

			if var_201_12 <= arg_198_1.time_ and arg_198_1.time_ < var_201_12 + var_201_22 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_12) / var_201_22

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_12 + var_201_22 and arg_198_1.time_ < var_201_12 + var_201_22 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play113031050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 113031050
		arg_202_1.duration_ = 2

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play113031051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1038ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1038ui_story == nil then
				arg_202_1.var_.characterEffect1038ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.2

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect1038ui_story and not isNil(var_205_0) then
					local var_205_4 = Mathf.Lerp(0, 0.5, var_205_3)

					arg_202_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1038ui_story.fillRatio = var_205_4
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1038ui_story then
				local var_205_5 = 0.5

				arg_202_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1038ui_story.fillRatio = var_205_5
			end

			local var_205_6 = arg_202_1.actors_["1041ui_story"]
			local var_205_7 = 0

			if var_205_7 < arg_202_1.time_ and arg_202_1.time_ <= var_205_7 + arg_205_0 and not isNil(var_205_6) and arg_202_1.var_.characterEffect1041ui_story == nil then
				arg_202_1.var_.characterEffect1041ui_story = var_205_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_8 = 0.2

			if var_205_7 <= arg_202_1.time_ and arg_202_1.time_ < var_205_7 + var_205_8 and not isNil(var_205_6) then
				local var_205_9 = (arg_202_1.time_ - var_205_7) / var_205_8

				if arg_202_1.var_.characterEffect1041ui_story and not isNil(var_205_6) then
					arg_202_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_7 + var_205_8 and arg_202_1.time_ < var_205_7 + var_205_8 + arg_205_0 and not isNil(var_205_6) and arg_202_1.var_.characterEffect1041ui_story then
				arg_202_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_205_10 = 0

			if var_205_10 < arg_202_1.time_ and arg_202_1.time_ <= var_205_10 + arg_205_0 then
				arg_202_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_205_11 = 0
			local var_205_12 = 0.05

			if var_205_11 < arg_202_1.time_ and arg_202_1.time_ <= var_205_11 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_13 = arg_202_1:FormatText(StoryNameCfg[208].name)

				arg_202_1.leftNameTxt_.text = var_205_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_14 = arg_202_1:GetWordFromCfg(113031050)
				local var_205_15 = arg_202_1:FormatText(var_205_14.content)

				arg_202_1.text_.text = var_205_15

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_16 = 2
				local var_205_17 = utf8.len(var_205_15)
				local var_205_18 = var_205_16 <= 0 and var_205_12 or var_205_12 * (var_205_17 / var_205_16)

				if var_205_18 > 0 and var_205_12 < var_205_18 then
					arg_202_1.talkMaxDuration = var_205_18

					if var_205_18 + var_205_11 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_18 + var_205_11
					end
				end

				arg_202_1.text_.text = var_205_15
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031050", "story_v_out_113031.awb") ~= 0 then
					local var_205_19 = manager.audio:GetVoiceLength("story_v_out_113031", "113031050", "story_v_out_113031.awb") / 1000

					if var_205_19 + var_205_11 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_19 + var_205_11
					end

					if var_205_14.prefab_name ~= "" and arg_202_1.actors_[var_205_14.prefab_name] ~= nil then
						local var_205_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_14.prefab_name].transform, "story_v_out_113031", "113031050", "story_v_out_113031.awb")

						arg_202_1:RecordAudio("113031050", var_205_20)
						arg_202_1:RecordAudio("113031050", var_205_20)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_113031", "113031050", "story_v_out_113031.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_113031", "113031050", "story_v_out_113031.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_21 = math.max(var_205_12, arg_202_1.talkMaxDuration)

			if var_205_11 <= arg_202_1.time_ and arg_202_1.time_ < var_205_11 + var_205_21 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_11) / var_205_21

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_11 + var_205_21 and arg_202_1.time_ < var_205_11 + var_205_21 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play113031051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 113031051
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play113031052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1041ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos1041ui_story = var_209_0.localPosition
			end

			local var_209_2 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2
				local var_209_4 = Vector3.New(0, 100, 0)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1041ui_story, var_209_4, var_209_3)

				local var_209_5 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_5.x, var_209_5.y, var_209_5.z)

				local var_209_6 = var_209_0.localEulerAngles

				var_209_6.z = 0
				var_209_6.x = 0
				var_209_0.localEulerAngles = var_209_6
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0, 100, 0)

				local var_209_7 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_7.x, var_209_7.y, var_209_7.z)

				local var_209_8 = var_209_0.localEulerAngles

				var_209_8.z = 0
				var_209_8.x = 0
				var_209_0.localEulerAngles = var_209_8
			end

			local var_209_9 = arg_206_1.actors_["1038ui_story"].transform
			local var_209_10 = 0

			if var_209_10 < arg_206_1.time_ and arg_206_1.time_ <= var_209_10 + arg_209_0 then
				arg_206_1.var_.moveOldPos1038ui_story = var_209_9.localPosition
			end

			local var_209_11 = 0.001

			if var_209_10 <= arg_206_1.time_ and arg_206_1.time_ < var_209_10 + var_209_11 then
				local var_209_12 = (arg_206_1.time_ - var_209_10) / var_209_11
				local var_209_13 = Vector3.New(0, 100, 0)

				var_209_9.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1038ui_story, var_209_13, var_209_12)

				local var_209_14 = manager.ui.mainCamera.transform.position - var_209_9.position

				var_209_9.forward = Vector3.New(var_209_14.x, var_209_14.y, var_209_14.z)

				local var_209_15 = var_209_9.localEulerAngles

				var_209_15.z = 0
				var_209_15.x = 0
				var_209_9.localEulerAngles = var_209_15
			end

			if arg_206_1.time_ >= var_209_10 + var_209_11 and arg_206_1.time_ < var_209_10 + var_209_11 + arg_209_0 then
				var_209_9.localPosition = Vector3.New(0, 100, 0)

				local var_209_16 = manager.ui.mainCamera.transform.position - var_209_9.position

				var_209_9.forward = Vector3.New(var_209_16.x, var_209_16.y, var_209_16.z)

				local var_209_17 = var_209_9.localEulerAngles

				var_209_17.z = 0
				var_209_17.x = 0
				var_209_9.localEulerAngles = var_209_17
			end

			local var_209_18 = 0
			local var_209_19 = 0.45

			if var_209_18 < arg_206_1.time_ and arg_206_1.time_ <= var_209_18 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_20 = arg_206_1:GetWordFromCfg(113031051)
				local var_209_21 = arg_206_1:FormatText(var_209_20.content)

				arg_206_1.text_.text = var_209_21

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_22 = 18
				local var_209_23 = utf8.len(var_209_21)
				local var_209_24 = var_209_22 <= 0 and var_209_19 or var_209_19 * (var_209_23 / var_209_22)

				if var_209_24 > 0 and var_209_19 < var_209_24 then
					arg_206_1.talkMaxDuration = var_209_24

					if var_209_24 + var_209_18 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_24 + var_209_18
					end
				end

				arg_206_1.text_.text = var_209_21
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_25 = math.max(var_209_19, arg_206_1.talkMaxDuration)

			if var_209_18 <= arg_206_1.time_ and arg_206_1.time_ < var_209_18 + var_209_25 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_18) / var_209_25

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_18 + var_209_25 and arg_206_1.time_ < var_209_18 + var_209_25 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play113031052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 113031052
		arg_210_1.duration_ = 6.07

		local var_210_0 = {
			ja = 5.133,
			ko = 5.333,
			zh = 6.066,
			en = 5.766
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play113031053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1084ui_story"].transform
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.var_.moveOldPos1084ui_story = var_213_0.localPosition
			end

			local var_213_2 = 0.001

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2
				local var_213_4 = Vector3.New(0, -0.97, -6)

				var_213_0.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1084ui_story, var_213_4, var_213_3)

				local var_213_5 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_5.x, var_213_5.y, var_213_5.z)

				local var_213_6 = var_213_0.localEulerAngles

				var_213_6.z = 0
				var_213_6.x = 0
				var_213_0.localEulerAngles = var_213_6
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 then
				var_213_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_213_7 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_7.x, var_213_7.y, var_213_7.z)

				local var_213_8 = var_213_0.localEulerAngles

				var_213_8.z = 0
				var_213_8.x = 0
				var_213_0.localEulerAngles = var_213_8
			end

			local var_213_9 = 0

			if var_213_9 < arg_210_1.time_ and arg_210_1.time_ <= var_213_9 + arg_213_0 then
				arg_210_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_213_10 = 0

			if var_213_10 < arg_210_1.time_ and arg_210_1.time_ <= var_213_10 + arg_213_0 then
				arg_210_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_213_11 = arg_210_1.actors_["1084ui_story"]
			local var_213_12 = 0

			if var_213_12 < arg_210_1.time_ and arg_210_1.time_ <= var_213_12 + arg_213_0 and not isNil(var_213_11) and arg_210_1.var_.characterEffect1084ui_story == nil then
				arg_210_1.var_.characterEffect1084ui_story = var_213_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_13 = 0.2

			if var_213_12 <= arg_210_1.time_ and arg_210_1.time_ < var_213_12 + var_213_13 and not isNil(var_213_11) then
				local var_213_14 = (arg_210_1.time_ - var_213_12) / var_213_13

				if arg_210_1.var_.characterEffect1084ui_story and not isNil(var_213_11) then
					arg_210_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_12 + var_213_13 and arg_210_1.time_ < var_213_12 + var_213_13 + arg_213_0 and not isNil(var_213_11) and arg_210_1.var_.characterEffect1084ui_story then
				arg_210_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_213_15 = 0
			local var_213_16 = 0.55

			if var_213_15 < arg_210_1.time_ and arg_210_1.time_ <= var_213_15 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_17 = arg_210_1:FormatText(StoryNameCfg[6].name)

				arg_210_1.leftNameTxt_.text = var_213_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_18 = arg_210_1:GetWordFromCfg(113031052)
				local var_213_19 = arg_210_1:FormatText(var_213_18.content)

				arg_210_1.text_.text = var_213_19

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_20 = 22
				local var_213_21 = utf8.len(var_213_19)
				local var_213_22 = var_213_20 <= 0 and var_213_16 or var_213_16 * (var_213_21 / var_213_20)

				if var_213_22 > 0 and var_213_16 < var_213_22 then
					arg_210_1.talkMaxDuration = var_213_22

					if var_213_22 + var_213_15 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_22 + var_213_15
					end
				end

				arg_210_1.text_.text = var_213_19
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031052", "story_v_out_113031.awb") ~= 0 then
					local var_213_23 = manager.audio:GetVoiceLength("story_v_out_113031", "113031052", "story_v_out_113031.awb") / 1000

					if var_213_23 + var_213_15 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_23 + var_213_15
					end

					if var_213_18.prefab_name ~= "" and arg_210_1.actors_[var_213_18.prefab_name] ~= nil then
						local var_213_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_18.prefab_name].transform, "story_v_out_113031", "113031052", "story_v_out_113031.awb")

						arg_210_1:RecordAudio("113031052", var_213_24)
						arg_210_1:RecordAudio("113031052", var_213_24)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_113031", "113031052", "story_v_out_113031.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_113031", "113031052", "story_v_out_113031.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_25 = math.max(var_213_16, arg_210_1.talkMaxDuration)

			if var_213_15 <= arg_210_1.time_ and arg_210_1.time_ < var_213_15 + var_213_25 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_15) / var_213_25

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_15 + var_213_25 and arg_210_1.time_ < var_213_15 + var_213_25 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play113031053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 113031053
		arg_214_1.duration_ = 0.2

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"

			SetActive(arg_214_1.choicesGo_, true)

			for iter_215_0, iter_215_1 in ipairs(arg_214_1.choices_) do
				local var_215_0 = iter_215_0 <= 2

				SetActive(iter_215_1.go, var_215_0)
			end

			arg_214_1.choices_[1].txt.text = arg_214_1:FormatText(StoryChoiceCfg[186].name)
			arg_214_1.choices_[2].txt.text = arg_214_1:FormatText(StoryChoiceCfg[187].name)
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play113031054(arg_214_1)
			end

			if arg_216_0 == 2 then
				arg_214_0:Play113031054(arg_214_1)
			end

			arg_214_1:RecordChoiceLog(113031053, 186, 187)
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1084ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1084ui_story == nil then
				arg_214_1.var_.characterEffect1084ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.2

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect1084ui_story and not isNil(var_217_0) then
					local var_217_4 = Mathf.Lerp(0, 0.5, var_217_3)

					arg_214_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1084ui_story.fillRatio = var_217_4
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1084ui_story then
				local var_217_5 = 0.5

				arg_214_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1084ui_story.fillRatio = var_217_5
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play113031054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 113031054
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play113031055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 0.45

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_2 = arg_218_1:GetWordFromCfg(113031054)
				local var_221_3 = arg_218_1:FormatText(var_221_2.content)

				arg_218_1.text_.text = var_221_3

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 18
				local var_221_5 = utf8.len(var_221_3)
				local var_221_6 = var_221_4 <= 0 and var_221_1 or var_221_1 * (var_221_5 / var_221_4)

				if var_221_6 > 0 and var_221_1 < var_221_6 then
					arg_218_1.talkMaxDuration = var_221_6

					if var_221_6 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_6 + var_221_0
					end
				end

				arg_218_1.text_.text = var_221_3
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_1, arg_218_1.talkMaxDuration)

			if var_221_0 <= arg_218_1.time_ and arg_218_1.time_ < var_221_0 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_0) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_0 + var_221_7 and arg_218_1.time_ < var_221_0 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play113031055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 113031055
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play113031056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 0.5

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_2 = arg_222_1:GetWordFromCfg(113031055)
				local var_225_3 = arg_222_1:FormatText(var_225_2.content)

				arg_222_1.text_.text = var_225_3

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 20
				local var_225_5 = utf8.len(var_225_3)
				local var_225_6 = var_225_4 <= 0 and var_225_1 or var_225_1 * (var_225_5 / var_225_4)

				if var_225_6 > 0 and var_225_1 < var_225_6 then
					arg_222_1.talkMaxDuration = var_225_6

					if var_225_6 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_6 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_3
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_7 and arg_222_1.time_ < var_225_0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play113031056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 113031056
		arg_226_1.duration_ = 6.03

		local var_226_0 = {
			ja = 2.8,
			ko = 5.366,
			zh = 4.666,
			en = 6.033
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play113031057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1084ui_story"].transform
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.var_.moveOldPos1084ui_story = var_229_0.localPosition
			end

			local var_229_2 = 0.001

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2
				local var_229_4 = Vector3.New(0, 100, 0)

				var_229_0.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1084ui_story, var_229_4, var_229_3)

				local var_229_5 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_5.x, var_229_5.y, var_229_5.z)

				local var_229_6 = var_229_0.localEulerAngles

				var_229_6.z = 0
				var_229_6.x = 0
				var_229_0.localEulerAngles = var_229_6
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 then
				var_229_0.localPosition = Vector3.New(0, 100, 0)

				local var_229_7 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_7.x, var_229_7.y, var_229_7.z)

				local var_229_8 = var_229_0.localEulerAngles

				var_229_8.z = 0
				var_229_8.x = 0
				var_229_0.localEulerAngles = var_229_8
			end

			local var_229_9 = arg_226_1.actors_["1042ui_story"].transform
			local var_229_10 = 0

			if var_229_10 < arg_226_1.time_ and arg_226_1.time_ <= var_229_10 + arg_229_0 then
				arg_226_1.var_.moveOldPos1042ui_story = var_229_9.localPosition
			end

			local var_229_11 = 0.001

			if var_229_10 <= arg_226_1.time_ and arg_226_1.time_ < var_229_10 + var_229_11 then
				local var_229_12 = (arg_226_1.time_ - var_229_10) / var_229_11
				local var_229_13 = Vector3.New(-0.7, -1.06, -6.2)

				var_229_9.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1042ui_story, var_229_13, var_229_12)

				local var_229_14 = manager.ui.mainCamera.transform.position - var_229_9.position

				var_229_9.forward = Vector3.New(var_229_14.x, var_229_14.y, var_229_14.z)

				local var_229_15 = var_229_9.localEulerAngles

				var_229_15.z = 0
				var_229_15.x = 0
				var_229_9.localEulerAngles = var_229_15
			end

			if arg_226_1.time_ >= var_229_10 + var_229_11 and arg_226_1.time_ < var_229_10 + var_229_11 + arg_229_0 then
				var_229_9.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_229_16 = manager.ui.mainCamera.transform.position - var_229_9.position

				var_229_9.forward = Vector3.New(var_229_16.x, var_229_16.y, var_229_16.z)

				local var_229_17 = var_229_9.localEulerAngles

				var_229_17.z = 0
				var_229_17.x = 0
				var_229_9.localEulerAngles = var_229_17
			end

			local var_229_18 = 0

			if var_229_18 < arg_226_1.time_ and arg_226_1.time_ <= var_229_18 + arg_229_0 then
				arg_226_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_229_19 = 0

			if var_229_19 < arg_226_1.time_ and arg_226_1.time_ <= var_229_19 + arg_229_0 then
				arg_226_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_229_20 = arg_226_1.actors_["1042ui_story"]
			local var_229_21 = 0

			if var_229_21 < arg_226_1.time_ and arg_226_1.time_ <= var_229_21 + arg_229_0 and not isNil(var_229_20) and arg_226_1.var_.characterEffect1042ui_story == nil then
				arg_226_1.var_.characterEffect1042ui_story = var_229_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_22 = 0.2

			if var_229_21 <= arg_226_1.time_ and arg_226_1.time_ < var_229_21 + var_229_22 and not isNil(var_229_20) then
				local var_229_23 = (arg_226_1.time_ - var_229_21) / var_229_22

				if arg_226_1.var_.characterEffect1042ui_story and not isNil(var_229_20) then
					arg_226_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_21 + var_229_22 and arg_226_1.time_ < var_229_21 + var_229_22 + arg_229_0 and not isNil(var_229_20) and arg_226_1.var_.characterEffect1042ui_story then
				arg_226_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_229_24 = 0
			local var_229_25 = 0.55

			if var_229_24 < arg_226_1.time_ and arg_226_1.time_ <= var_229_24 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_26 = arg_226_1:FormatText(StoryNameCfg[205].name)

				arg_226_1.leftNameTxt_.text = var_229_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_27 = arg_226_1:GetWordFromCfg(113031056)
				local var_229_28 = arg_226_1:FormatText(var_229_27.content)

				arg_226_1.text_.text = var_229_28

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_29 = 22
				local var_229_30 = utf8.len(var_229_28)
				local var_229_31 = var_229_29 <= 0 and var_229_25 or var_229_25 * (var_229_30 / var_229_29)

				if var_229_31 > 0 and var_229_25 < var_229_31 then
					arg_226_1.talkMaxDuration = var_229_31

					if var_229_31 + var_229_24 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_31 + var_229_24
					end
				end

				arg_226_1.text_.text = var_229_28
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031056", "story_v_out_113031.awb") ~= 0 then
					local var_229_32 = manager.audio:GetVoiceLength("story_v_out_113031", "113031056", "story_v_out_113031.awb") / 1000

					if var_229_32 + var_229_24 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_32 + var_229_24
					end

					if var_229_27.prefab_name ~= "" and arg_226_1.actors_[var_229_27.prefab_name] ~= nil then
						local var_229_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_27.prefab_name].transform, "story_v_out_113031", "113031056", "story_v_out_113031.awb")

						arg_226_1:RecordAudio("113031056", var_229_33)
						arg_226_1:RecordAudio("113031056", var_229_33)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_113031", "113031056", "story_v_out_113031.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_113031", "113031056", "story_v_out_113031.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_34 = math.max(var_229_25, arg_226_1.talkMaxDuration)

			if var_229_24 <= arg_226_1.time_ and arg_226_1.time_ < var_229_24 + var_229_34 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_24) / var_229_34

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_24 + var_229_34 and arg_226_1.time_ < var_229_24 + var_229_34 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play113031057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 113031057
		arg_230_1.duration_ = 6.13

		local var_230_0 = {
			ja = 6.133,
			ko = 2.266,
			zh = 2.9,
			en = 2.366
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play113031058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_233_2 = 0
			local var_233_3 = 0.275

			if var_233_2 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_4 = arg_230_1:FormatText(StoryNameCfg[205].name)

				arg_230_1.leftNameTxt_.text = var_233_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_5 = arg_230_1:GetWordFromCfg(113031057)
				local var_233_6 = arg_230_1:FormatText(var_233_5.content)

				arg_230_1.text_.text = var_233_6

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_7 = 11
				local var_233_8 = utf8.len(var_233_6)
				local var_233_9 = var_233_7 <= 0 and var_233_3 or var_233_3 * (var_233_8 / var_233_7)

				if var_233_9 > 0 and var_233_3 < var_233_9 then
					arg_230_1.talkMaxDuration = var_233_9

					if var_233_9 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_9 + var_233_2
					end
				end

				arg_230_1.text_.text = var_233_6
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031057", "story_v_out_113031.awb") ~= 0 then
					local var_233_10 = manager.audio:GetVoiceLength("story_v_out_113031", "113031057", "story_v_out_113031.awb") / 1000

					if var_233_10 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_10 + var_233_2
					end

					if var_233_5.prefab_name ~= "" and arg_230_1.actors_[var_233_5.prefab_name] ~= nil then
						local var_233_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_5.prefab_name].transform, "story_v_out_113031", "113031057", "story_v_out_113031.awb")

						arg_230_1:RecordAudio("113031057", var_233_11)
						arg_230_1:RecordAudio("113031057", var_233_11)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_113031", "113031057", "story_v_out_113031.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_113031", "113031057", "story_v_out_113031.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_12 = math.max(var_233_3, arg_230_1.talkMaxDuration)

			if var_233_2 <= arg_230_1.time_ and arg_230_1.time_ < var_233_2 + var_233_12 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_2) / var_233_12

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_2 + var_233_12 and arg_230_1.time_ < var_233_2 + var_233_12 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play113031058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 113031058
		arg_234_1.duration_ = 6.33

		local var_234_0 = {
			ja = 6.166,
			ko = 5.6,
			zh = 4.866,
			en = 6.333
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play113031059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1042ui_story"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1042ui_story == nil then
				arg_234_1.var_.characterEffect1042ui_story = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.2

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect1042ui_story and not isNil(var_237_0) then
					local var_237_4 = Mathf.Lerp(0, 0.5, var_237_3)

					arg_234_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1042ui_story.fillRatio = var_237_4
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1042ui_story then
				local var_237_5 = 0.5

				arg_234_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1042ui_story.fillRatio = var_237_5
			end

			local var_237_6 = arg_234_1.actors_["1041ui_story"].transform
			local var_237_7 = 0

			if var_237_7 < arg_234_1.time_ and arg_234_1.time_ <= var_237_7 + arg_237_0 then
				arg_234_1.var_.moveOldPos1041ui_story = var_237_6.localPosition
			end

			local var_237_8 = 0.001

			if var_237_7 <= arg_234_1.time_ and arg_234_1.time_ < var_237_7 + var_237_8 then
				local var_237_9 = (arg_234_1.time_ - var_237_7) / var_237_8
				local var_237_10 = Vector3.New(0.7, -1.11, -5.9)

				var_237_6.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1041ui_story, var_237_10, var_237_9)

				local var_237_11 = manager.ui.mainCamera.transform.position - var_237_6.position

				var_237_6.forward = Vector3.New(var_237_11.x, var_237_11.y, var_237_11.z)

				local var_237_12 = var_237_6.localEulerAngles

				var_237_12.z = 0
				var_237_12.x = 0
				var_237_6.localEulerAngles = var_237_12
			end

			if arg_234_1.time_ >= var_237_7 + var_237_8 and arg_234_1.time_ < var_237_7 + var_237_8 + arg_237_0 then
				var_237_6.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_237_13 = manager.ui.mainCamera.transform.position - var_237_6.position

				var_237_6.forward = Vector3.New(var_237_13.x, var_237_13.y, var_237_13.z)

				local var_237_14 = var_237_6.localEulerAngles

				var_237_14.z = 0
				var_237_14.x = 0
				var_237_6.localEulerAngles = var_237_14
			end

			local var_237_15 = 0

			if var_237_15 < arg_234_1.time_ and arg_234_1.time_ <= var_237_15 + arg_237_0 then
				arg_234_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_237_16 = 0

			if var_237_16 < arg_234_1.time_ and arg_234_1.time_ <= var_237_16 + arg_237_0 then
				arg_234_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_237_17 = arg_234_1.actors_["1041ui_story"]
			local var_237_18 = 0

			if var_237_18 < arg_234_1.time_ and arg_234_1.time_ <= var_237_18 + arg_237_0 and not isNil(var_237_17) and arg_234_1.var_.characterEffect1041ui_story == nil then
				arg_234_1.var_.characterEffect1041ui_story = var_237_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_19 = 0.2

			if var_237_18 <= arg_234_1.time_ and arg_234_1.time_ < var_237_18 + var_237_19 and not isNil(var_237_17) then
				local var_237_20 = (arg_234_1.time_ - var_237_18) / var_237_19

				if arg_234_1.var_.characterEffect1041ui_story and not isNil(var_237_17) then
					arg_234_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_18 + var_237_19 and arg_234_1.time_ < var_237_18 + var_237_19 + arg_237_0 and not isNil(var_237_17) and arg_234_1.var_.characterEffect1041ui_story then
				arg_234_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_237_21 = 0
			local var_237_22 = 0.725

			if var_237_21 < arg_234_1.time_ and arg_234_1.time_ <= var_237_21 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_23 = arg_234_1:FormatText(StoryNameCfg[208].name)

				arg_234_1.leftNameTxt_.text = var_237_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_24 = arg_234_1:GetWordFromCfg(113031058)
				local var_237_25 = arg_234_1:FormatText(var_237_24.content)

				arg_234_1.text_.text = var_237_25

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_26 = 29
				local var_237_27 = utf8.len(var_237_25)
				local var_237_28 = var_237_26 <= 0 and var_237_22 or var_237_22 * (var_237_27 / var_237_26)

				if var_237_28 > 0 and var_237_22 < var_237_28 then
					arg_234_1.talkMaxDuration = var_237_28

					if var_237_28 + var_237_21 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_28 + var_237_21
					end
				end

				arg_234_1.text_.text = var_237_25
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031058", "story_v_out_113031.awb") ~= 0 then
					local var_237_29 = manager.audio:GetVoiceLength("story_v_out_113031", "113031058", "story_v_out_113031.awb") / 1000

					if var_237_29 + var_237_21 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_29 + var_237_21
					end

					if var_237_24.prefab_name ~= "" and arg_234_1.actors_[var_237_24.prefab_name] ~= nil then
						local var_237_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_24.prefab_name].transform, "story_v_out_113031", "113031058", "story_v_out_113031.awb")

						arg_234_1:RecordAudio("113031058", var_237_30)
						arg_234_1:RecordAudio("113031058", var_237_30)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_113031", "113031058", "story_v_out_113031.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_113031", "113031058", "story_v_out_113031.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_31 = math.max(var_237_22, arg_234_1.talkMaxDuration)

			if var_237_21 <= arg_234_1.time_ and arg_234_1.time_ < var_237_21 + var_237_31 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_21) / var_237_31

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_21 + var_237_31 and arg_234_1.time_ < var_237_21 + var_237_31 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play113031059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 113031059
		arg_238_1.duration_ = 2.03

		local var_238_0 = {
			ja = 2.033,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
			arg_238_1.auto_ = false
		end

		function arg_238_1.playNext_(arg_240_0)
			arg_238_1.onStoryFinished_()
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_241_1 = 0
			local var_241_2 = 0.175

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_3 = arg_238_1:FormatText(StoryNameCfg[208].name)

				arg_238_1.leftNameTxt_.text = var_241_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_4 = arg_238_1:GetWordFromCfg(113031059)
				local var_241_5 = arg_238_1:FormatText(var_241_4.content)

				arg_238_1.text_.text = var_241_5

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_6 = 7
				local var_241_7 = utf8.len(var_241_5)
				local var_241_8 = var_241_6 <= 0 and var_241_2 or var_241_2 * (var_241_7 / var_241_6)

				if var_241_8 > 0 and var_241_2 < var_241_8 then
					arg_238_1.talkMaxDuration = var_241_8

					if var_241_8 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_5
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113031", "113031059", "story_v_out_113031.awb") ~= 0 then
					local var_241_9 = manager.audio:GetVoiceLength("story_v_out_113031", "113031059", "story_v_out_113031.awb") / 1000

					if var_241_9 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_9 + var_241_1
					end

					if var_241_4.prefab_name ~= "" and arg_238_1.actors_[var_241_4.prefab_name] ~= nil then
						local var_241_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_4.prefab_name].transform, "story_v_out_113031", "113031059", "story_v_out_113031.awb")

						arg_238_1:RecordAudio("113031059", var_241_10)
						arg_238_1:RecordAudio("113031059", var_241_10)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_113031", "113031059", "story_v_out_113031.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_113031", "113031059", "story_v_out_113031.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_11 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_11 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_11

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_11 and arg_238_1.time_ < var_241_1 + var_241_11 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F01a"
	},
	voices = {
		"story_v_out_113031.awb"
	}
}
