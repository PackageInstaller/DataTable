return {
	Play319451001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319451001
		arg_1_1.duration_ = 6.63

		local var_1_0 = {
			zh = 5.2,
			ja = 6.633
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
				arg_1_0:Play319451002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST07a"

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
				local var_4_5 = arg_1_1.bgs_.ST07a

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
					if iter_4_0 ~= "ST07a" then
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
			local var_4_23 = 0.9

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_28 = 2
			local var_4_29 = 0.075

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_30 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_30:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_31 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_31

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

				local var_4_32 = arg_1_1:GetWordFromCfg(319451001)
				local var_4_33 = arg_1_1:FormatText(var_4_32.content)

				arg_1_1.text_.text = var_4_33

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_34 = 3
				local var_4_35 = utf8.len(var_4_33)
				local var_4_36 = var_4_34 <= 0 and var_4_29 or var_4_29 * (var_4_35 / var_4_34)

				if var_4_36 > 0 and var_4_29 < var_4_36 then
					arg_1_1.talkMaxDuration = var_4_36
					var_4_28 = var_4_28 + 0.3

					if var_4_36 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_36 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_33
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451001", "story_v_out_319451.awb") ~= 0 then
					local var_4_37 = manager.audio:GetVoiceLength("story_v_out_319451", "319451001", "story_v_out_319451.awb") / 1000

					if var_4_37 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_28
					end

					if var_4_32.prefab_name ~= "" and arg_1_1.actors_[var_4_32.prefab_name] ~= nil then
						local var_4_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_32.prefab_name].transform, "story_v_out_319451", "319451001", "story_v_out_319451.awb")

						arg_1_1:RecordAudio("319451001", var_4_38)
						arg_1_1:RecordAudio("319451001", var_4_38)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319451", "319451001", "story_v_out_319451.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319451", "319451001", "story_v_out_319451.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_39 = var_4_28 + 0.3
			local var_4_40 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_39) / var_4_40

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319451002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 319451002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play319451003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1084ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1084ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.200000002980232

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_5) then
					local var_11_9 = Mathf.Lerp(0, 0.5, var_11_8)

					arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1084ui_story.fillRatio = var_11_9
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1084ui_story then
				local var_11_10 = 0.5

				arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1084ui_story.fillRatio = var_11_10
			end

			local var_11_11 = 0
			local var_11_12 = 0.1

			if var_11_11 < arg_8_1.time_ and arg_8_1.time_ <= var_11_11 + arg_11_0 then
				local var_11_13 = "play"
				local var_11_14 = "music"

				arg_8_1:AudioAction(var_11_13, var_11_14, "ui_battle", "ui_battle_stopbgm", "")

				local var_11_15 = ""
				local var_11_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_11_16 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_16 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_16

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_16
						arg_8_1.bgmTxt2_.text = var_11_16
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_17 = 0.133333333333333
			local var_11_18 = 0.899999997019768

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 then
				local var_11_19 = "play"
				local var_11_20 = "music"

				arg_8_1:AudioAction(var_11_19, var_11_20, "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room.awb")

				local var_11_21 = ""
				local var_11_22 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room")

				if var_11_22 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_22 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_22

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_22
						arg_8_1.bgmTxt2_.text = var_11_22
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_23 = 0
			local var_11_24 = 0.825

			if var_11_23 < arg_8_1.time_ and arg_8_1.time_ <= var_11_23 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_25 = arg_8_1:GetWordFromCfg(319451002)
				local var_11_26 = arg_8_1:FormatText(var_11_25.content)

				arg_8_1.text_.text = var_11_26

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_27 = 33
				local var_11_28 = utf8.len(var_11_26)
				local var_11_29 = var_11_27 <= 0 and var_11_24 or var_11_24 * (var_11_28 / var_11_27)

				if var_11_29 > 0 and var_11_24 < var_11_29 then
					arg_8_1.talkMaxDuration = var_11_29

					if var_11_29 + var_11_23 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_29 + var_11_23
					end
				end

				arg_8_1.text_.text = var_11_26
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_30 = math.max(var_11_24, arg_8_1.talkMaxDuration)

			if var_11_23 <= arg_8_1.time_ and arg_8_1.time_ < var_11_23 + var_11_30 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_23) / var_11_30

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_23 + var_11_30 and arg_8_1.time_ < var_11_23 + var_11_30 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play319451003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 319451003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play319451004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0
			local var_17_1 = 1.775

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_2 = arg_14_1:GetWordFromCfg(319451003)
				local var_17_3 = arg_14_1:FormatText(var_17_2.content)

				arg_14_1.text_.text = var_17_3

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_4 = 71
				local var_17_5 = utf8.len(var_17_3)
				local var_17_6 = var_17_4 <= 0 and var_17_1 or var_17_1 * (var_17_5 / var_17_4)

				if var_17_6 > 0 and var_17_1 < var_17_6 then
					arg_14_1.talkMaxDuration = var_17_6

					if var_17_6 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_6 + var_17_0
					end
				end

				arg_14_1.text_.text = var_17_3
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_7 = math.max(var_17_1, arg_14_1.talkMaxDuration)

			if var_17_0 <= arg_14_1.time_ and arg_14_1.time_ < var_17_0 + var_17_7 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_0) / var_17_7

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_0 + var_17_7 and arg_14_1.time_ < var_17_0 + var_17_7 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play319451004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 319451004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play319451005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 0.2

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_2 = arg_18_1:FormatText(StoryNameCfg[698].name)

				arg_18_1.leftNameTxt_.text = var_21_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_3 = arg_18_1:GetWordFromCfg(319451004)
				local var_21_4 = arg_18_1:FormatText(var_21_3.content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 8
				local var_21_6 = utf8.len(var_21_4)
				local var_21_7 = var_21_5 <= 0 and var_21_1 or var_21_1 * (var_21_6 / var_21_5)

				if var_21_7 > 0 and var_21_1 < var_21_7 then
					arg_18_1.talkMaxDuration = var_21_7

					if var_21_7 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_4
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_8 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_8 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_8

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_8 and arg_18_1.time_ < var_21_0 + var_21_8 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play319451005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 319451005
		arg_22_1.duration_ = 7.53

		local var_22_0 = {
			zh = 3.866,
			ja = 7.533
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play319451006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1084ui_story"].transform
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 then
				arg_22_1.var_.moveOldPos1084ui_story = var_25_0.localPosition

				local var_25_2 = "1084ui_story"

				arg_22_1:ShowWeapon(arg_22_1.var_[var_25_2 .. "Animator"].transform, false)
			end

			local var_25_3 = 0.001

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_3 then
				local var_25_4 = (arg_22_1.time_ - var_25_1) / var_25_3
				local var_25_5 = Vector3.New(0, -0.97, -6)

				var_25_0.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1084ui_story, var_25_5, var_25_4)

				local var_25_6 = manager.ui.mainCamera.transform.position - var_25_0.position

				var_25_0.forward = Vector3.New(var_25_6.x, var_25_6.y, var_25_6.z)

				local var_25_7 = var_25_0.localEulerAngles

				var_25_7.z = 0
				var_25_7.x = 0
				var_25_0.localEulerAngles = var_25_7
			end

			if arg_22_1.time_ >= var_25_1 + var_25_3 and arg_22_1.time_ < var_25_1 + var_25_3 + arg_25_0 then
				var_25_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_25_8 = manager.ui.mainCamera.transform.position - var_25_0.position

				var_25_0.forward = Vector3.New(var_25_8.x, var_25_8.y, var_25_8.z)

				local var_25_9 = var_25_0.localEulerAngles

				var_25_9.z = 0
				var_25_9.x = 0
				var_25_0.localEulerAngles = var_25_9
			end

			local var_25_10 = arg_22_1.actors_["1084ui_story"]
			local var_25_11 = 0

			if var_25_11 < arg_22_1.time_ and arg_22_1.time_ <= var_25_11 + arg_25_0 and not isNil(var_25_10) and arg_22_1.var_.characterEffect1084ui_story == nil then
				arg_22_1.var_.characterEffect1084ui_story = var_25_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_12 = 0.200000002980232

			if var_25_11 <= arg_22_1.time_ and arg_22_1.time_ < var_25_11 + var_25_12 and not isNil(var_25_10) then
				local var_25_13 = (arg_22_1.time_ - var_25_11) / var_25_12

				if arg_22_1.var_.characterEffect1084ui_story and not isNil(var_25_10) then
					arg_22_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= var_25_11 + var_25_12 and arg_22_1.time_ < var_25_11 + var_25_12 + arg_25_0 and not isNil(var_25_10) and arg_22_1.var_.characterEffect1084ui_story then
				arg_22_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_25_14 = 0

			if var_25_14 < arg_22_1.time_ and arg_22_1.time_ <= var_25_14 + arg_25_0 then
				arg_22_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_25_15 = 0

			if var_25_15 < arg_22_1.time_ and arg_22_1.time_ <= var_25_15 + arg_25_0 then
				arg_22_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_25_16 = 0
			local var_25_17 = 0.25

			if var_25_16 < arg_22_1.time_ and arg_22_1.time_ <= var_25_16 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_18 = arg_22_1:FormatText(StoryNameCfg[6].name)

				arg_22_1.leftNameTxt_.text = var_25_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_19 = arg_22_1:GetWordFromCfg(319451005)
				local var_25_20 = arg_22_1:FormatText(var_25_19.content)

				arg_22_1.text_.text = var_25_20

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_21 = 10
				local var_25_22 = utf8.len(var_25_20)
				local var_25_23 = var_25_21 <= 0 and var_25_17 or var_25_17 * (var_25_22 / var_25_21)

				if var_25_23 > 0 and var_25_17 < var_25_23 then
					arg_22_1.talkMaxDuration = var_25_23

					if var_25_23 + var_25_16 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_23 + var_25_16
					end
				end

				arg_22_1.text_.text = var_25_20
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451005", "story_v_out_319451.awb") ~= 0 then
					local var_25_24 = manager.audio:GetVoiceLength("story_v_out_319451", "319451005", "story_v_out_319451.awb") / 1000

					if var_25_24 + var_25_16 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_24 + var_25_16
					end

					if var_25_19.prefab_name ~= "" and arg_22_1.actors_[var_25_19.prefab_name] ~= nil then
						local var_25_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_19.prefab_name].transform, "story_v_out_319451", "319451005", "story_v_out_319451.awb")

						arg_22_1:RecordAudio("319451005", var_25_25)
						arg_22_1:RecordAudio("319451005", var_25_25)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_319451", "319451005", "story_v_out_319451.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_319451", "319451005", "story_v_out_319451.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_26 = math.max(var_25_17, arg_22_1.talkMaxDuration)

			if var_25_16 <= arg_22_1.time_ and arg_22_1.time_ < var_25_16 + var_25_26 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_16) / var_25_26

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_16 + var_25_26 and arg_22_1.time_ < var_25_16 + var_25_26 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play319451006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 319451006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play319451007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["1084ui_story"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1084ui_story == nil then
				arg_26_1.var_.characterEffect1084ui_story = var_29_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.200000002980232

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.characterEffect1084ui_story and not isNil(var_29_0) then
					local var_29_4 = Mathf.Lerp(0, 0.5, var_29_3)

					arg_26_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_26_1.var_.characterEffect1084ui_story.fillRatio = var_29_4
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1084ui_story then
				local var_29_5 = 0.5

				arg_26_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_26_1.var_.characterEffect1084ui_story.fillRatio = var_29_5
			end

			local var_29_6 = 0
			local var_29_7 = 1.475

			if var_29_6 < arg_26_1.time_ and arg_26_1.time_ <= var_29_6 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_8 = arg_26_1:GetWordFromCfg(319451006)
				local var_29_9 = arg_26_1:FormatText(var_29_8.content)

				arg_26_1.text_.text = var_29_9

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_10 = 59
				local var_29_11 = utf8.len(var_29_9)
				local var_29_12 = var_29_10 <= 0 and var_29_7 or var_29_7 * (var_29_11 / var_29_10)

				if var_29_12 > 0 and var_29_7 < var_29_12 then
					arg_26_1.talkMaxDuration = var_29_12

					if var_29_12 + var_29_6 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_12 + var_29_6
					end
				end

				arg_26_1.text_.text = var_29_9
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_13 = math.max(var_29_7, arg_26_1.talkMaxDuration)

			if var_29_6 <= arg_26_1.time_ and arg_26_1.time_ < var_29_6 + var_29_13 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_6) / var_29_13

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_6 + var_29_13 and arg_26_1.time_ < var_29_6 + var_29_13 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play319451007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 319451007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play319451008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 1.6

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_2 = arg_30_1:GetWordFromCfg(319451007)
				local var_33_3 = arg_30_1:FormatText(var_33_2.content)

				arg_30_1.text_.text = var_33_3

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_4 = 64
				local var_33_5 = utf8.len(var_33_3)
				local var_33_6 = var_33_4 <= 0 and var_33_1 or var_33_1 * (var_33_5 / var_33_4)

				if var_33_6 > 0 and var_33_1 < var_33_6 then
					arg_30_1.talkMaxDuration = var_33_6

					if var_33_6 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_6 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_3
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_7 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_7 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_7

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_7 and arg_30_1.time_ < var_33_0 + var_33_7 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play319451008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 319451008
		arg_34_1.duration_ = 7.17

		local var_34_0 = {
			zh = 3.266,
			ja = 7.166
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play319451009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1084ui_story"].transform
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.var_.moveOldPos1084ui_story = var_37_0.localPosition
			end

			local var_37_2 = 0.001

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2
				local var_37_4 = Vector3.New(0, -0.97, -6)

				var_37_0.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1084ui_story, var_37_4, var_37_3)

				local var_37_5 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_5.x, var_37_5.y, var_37_5.z)

				local var_37_6 = var_37_0.localEulerAngles

				var_37_6.z = 0
				var_37_6.x = 0
				var_37_0.localEulerAngles = var_37_6
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 then
				var_37_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_37_7 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_7.x, var_37_7.y, var_37_7.z)

				local var_37_8 = var_37_0.localEulerAngles

				var_37_8.z = 0
				var_37_8.x = 0
				var_37_0.localEulerAngles = var_37_8
			end

			local var_37_9 = arg_34_1.actors_["1084ui_story"]
			local var_37_10 = 0

			if var_37_10 < arg_34_1.time_ and arg_34_1.time_ <= var_37_10 + arg_37_0 and not isNil(var_37_9) and arg_34_1.var_.characterEffect1084ui_story == nil then
				arg_34_1.var_.characterEffect1084ui_story = var_37_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_11 = 0.200000002980232

			if var_37_10 <= arg_34_1.time_ and arg_34_1.time_ < var_37_10 + var_37_11 and not isNil(var_37_9) then
				local var_37_12 = (arg_34_1.time_ - var_37_10) / var_37_11

				if arg_34_1.var_.characterEffect1084ui_story and not isNil(var_37_9) then
					arg_34_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_10 + var_37_11 and arg_34_1.time_ < var_37_10 + var_37_11 + arg_37_0 and not isNil(var_37_9) and arg_34_1.var_.characterEffect1084ui_story then
				arg_34_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_37_13 = 0

			if var_37_13 < arg_34_1.time_ and arg_34_1.time_ <= var_37_13 + arg_37_0 then
				arg_34_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_37_14 = 0
			local var_37_15 = 0.25

			if var_37_14 < arg_34_1.time_ and arg_34_1.time_ <= var_37_14 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_16 = arg_34_1:FormatText(StoryNameCfg[6].name)

				arg_34_1.leftNameTxt_.text = var_37_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_17 = arg_34_1:GetWordFromCfg(319451008)
				local var_37_18 = arg_34_1:FormatText(var_37_17.content)

				arg_34_1.text_.text = var_37_18

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_19 = 10
				local var_37_20 = utf8.len(var_37_18)
				local var_37_21 = var_37_19 <= 0 and var_37_15 or var_37_15 * (var_37_20 / var_37_19)

				if var_37_21 > 0 and var_37_15 < var_37_21 then
					arg_34_1.talkMaxDuration = var_37_21

					if var_37_21 + var_37_14 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_21 + var_37_14
					end
				end

				arg_34_1.text_.text = var_37_18
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451008", "story_v_out_319451.awb") ~= 0 then
					local var_37_22 = manager.audio:GetVoiceLength("story_v_out_319451", "319451008", "story_v_out_319451.awb") / 1000

					if var_37_22 + var_37_14 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_22 + var_37_14
					end

					if var_37_17.prefab_name ~= "" and arg_34_1.actors_[var_37_17.prefab_name] ~= nil then
						local var_37_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_17.prefab_name].transform, "story_v_out_319451", "319451008", "story_v_out_319451.awb")

						arg_34_1:RecordAudio("319451008", var_37_23)
						arg_34_1:RecordAudio("319451008", var_37_23)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_319451", "319451008", "story_v_out_319451.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_319451", "319451008", "story_v_out_319451.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_24 = math.max(var_37_15, arg_34_1.talkMaxDuration)

			if var_37_14 <= arg_34_1.time_ and arg_34_1.time_ < var_37_14 + var_37_24 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_14) / var_37_24

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_14 + var_37_24 and arg_34_1.time_ < var_37_14 + var_37_24 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play319451009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 319451009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play319451010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1084ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1084ui_story == nil then
				arg_38_1.var_.characterEffect1084ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect1084ui_story and not isNil(var_41_0) then
					local var_41_4 = Mathf.Lerp(0, 0.5, var_41_3)

					arg_38_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1084ui_story.fillRatio = var_41_4
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1084ui_story then
				local var_41_5 = 0.5

				arg_38_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1084ui_story.fillRatio = var_41_5
			end

			local var_41_6 = 0
			local var_41_7 = 0.825

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_8 = arg_38_1:FormatText(StoryNameCfg[698].name)

				arg_38_1.leftNameTxt_.text = var_41_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_9 = arg_38_1:GetWordFromCfg(319451009)
				local var_41_10 = arg_38_1:FormatText(var_41_9.content)

				arg_38_1.text_.text = var_41_10

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 33
				local var_41_12 = utf8.len(var_41_10)
				local var_41_13 = var_41_11 <= 0 and var_41_7 or var_41_7 * (var_41_12 / var_41_11)

				if var_41_13 > 0 and var_41_7 < var_41_13 then
					arg_38_1.talkMaxDuration = var_41_13

					if var_41_13 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_13 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_10
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_14 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_14 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_14

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_14 and arg_38_1.time_ < var_41_6 + var_41_14 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play319451010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 319451010
		arg_42_1.duration_ = 4.37

		local var_42_0 = {
			zh = 2.333,
			ja = 4.366
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
				arg_42_0:Play319451011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = "10069ui_story"

			if arg_42_1.actors_[var_45_0] == nil then
				local var_45_1 = Asset.Load("Char/" .. "10069ui_story")

				if not isNil(var_45_1) then
					local var_45_2 = Object.Instantiate(Asset.Load("Char/" .. "10069ui_story"), arg_42_1.stage_.transform)

					var_45_2.name = var_45_0
					var_45_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_42_1.actors_[var_45_0] = var_45_2

					local var_45_3 = var_45_2:GetComponentInChildren(typeof(CharacterEffect))

					var_45_3.enabled = true

					local var_45_4 = GameObjectTools.GetOrAddComponent(var_45_2, typeof(DynamicBoneHelper))

					if var_45_4 then
						var_45_4:EnableDynamicBone(false)
					end

					arg_42_1:ShowWeapon(var_45_3.transform, false)

					arg_42_1.var_[var_45_0 .. "Animator"] = var_45_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_42_1.var_[var_45_0 .. "Animator"].applyRootMotion = true
					arg_42_1.var_[var_45_0 .. "LipSync"] = var_45_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_45_5 = arg_42_1.actors_["10069ui_story"].transform
			local var_45_6 = 0

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.var_.moveOldPos10069ui_story = var_45_5.localPosition
			end

			local var_45_7 = 0.001

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_7 then
				local var_45_8 = (arg_42_1.time_ - var_45_6) / var_45_7
				local var_45_9 = Vector3.New(0.7, -1.08, -6.33)

				var_45_5.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10069ui_story, var_45_9, var_45_8)

				local var_45_10 = manager.ui.mainCamera.transform.position - var_45_5.position

				var_45_5.forward = Vector3.New(var_45_10.x, var_45_10.y, var_45_10.z)

				local var_45_11 = var_45_5.localEulerAngles

				var_45_11.z = 0
				var_45_11.x = 0
				var_45_5.localEulerAngles = var_45_11
			end

			if arg_42_1.time_ >= var_45_6 + var_45_7 and arg_42_1.time_ < var_45_6 + var_45_7 + arg_45_0 then
				var_45_5.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_45_12 = manager.ui.mainCamera.transform.position - var_45_5.position

				var_45_5.forward = Vector3.New(var_45_12.x, var_45_12.y, var_45_12.z)

				local var_45_13 = var_45_5.localEulerAngles

				var_45_13.z = 0
				var_45_13.x = 0
				var_45_5.localEulerAngles = var_45_13
			end

			local var_45_14 = arg_42_1.actors_["10069ui_story"]
			local var_45_15 = 0

			if var_45_15 < arg_42_1.time_ and arg_42_1.time_ <= var_45_15 + arg_45_0 and not isNil(var_45_14) and arg_42_1.var_.characterEffect10069ui_story == nil then
				arg_42_1.var_.characterEffect10069ui_story = var_45_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_16 = 0.200000002980232

			if var_45_15 <= arg_42_1.time_ and arg_42_1.time_ < var_45_15 + var_45_16 and not isNil(var_45_14) then
				local var_45_17 = (arg_42_1.time_ - var_45_15) / var_45_16

				if arg_42_1.var_.characterEffect10069ui_story and not isNil(var_45_14) then
					arg_42_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_15 + var_45_16 and arg_42_1.time_ < var_45_15 + var_45_16 + arg_45_0 and not isNil(var_45_14) and arg_42_1.var_.characterEffect10069ui_story then
				arg_42_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_45_18 = 0

			if var_45_18 < arg_42_1.time_ and arg_42_1.time_ <= var_45_18 + arg_45_0 then
				arg_42_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_45_19 = 0

			if var_45_19 < arg_42_1.time_ and arg_42_1.time_ <= var_45_19 + arg_45_0 then
				arg_42_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_45_20 = arg_42_1.actors_["1084ui_story"].transform
			local var_45_21 = 0

			if var_45_21 < arg_42_1.time_ and arg_42_1.time_ <= var_45_21 + arg_45_0 then
				arg_42_1.var_.moveOldPos1084ui_story = var_45_20.localPosition
			end

			local var_45_22 = 0.001

			if var_45_21 <= arg_42_1.time_ and arg_42_1.time_ < var_45_21 + var_45_22 then
				local var_45_23 = (arg_42_1.time_ - var_45_21) / var_45_22
				local var_45_24 = Vector3.New(-0.7, -0.97, -6)

				var_45_20.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1084ui_story, var_45_24, var_45_23)

				local var_45_25 = manager.ui.mainCamera.transform.position - var_45_20.position

				var_45_20.forward = Vector3.New(var_45_25.x, var_45_25.y, var_45_25.z)

				local var_45_26 = var_45_20.localEulerAngles

				var_45_26.z = 0
				var_45_26.x = 0
				var_45_20.localEulerAngles = var_45_26
			end

			if arg_42_1.time_ >= var_45_21 + var_45_22 and arg_42_1.time_ < var_45_21 + var_45_22 + arg_45_0 then
				var_45_20.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_45_27 = manager.ui.mainCamera.transform.position - var_45_20.position

				var_45_20.forward = Vector3.New(var_45_27.x, var_45_27.y, var_45_27.z)

				local var_45_28 = var_45_20.localEulerAngles

				var_45_28.z = 0
				var_45_28.x = 0
				var_45_20.localEulerAngles = var_45_28
			end

			local var_45_29 = arg_42_1.actors_["1084ui_story"]
			local var_45_30 = 0

			if var_45_30 < arg_42_1.time_ and arg_42_1.time_ <= var_45_30 + arg_45_0 and not isNil(var_45_29) and arg_42_1.var_.characterEffect1084ui_story == nil then
				arg_42_1.var_.characterEffect1084ui_story = var_45_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_31 = 0.200000002980232

			if var_45_30 <= arg_42_1.time_ and arg_42_1.time_ < var_45_30 + var_45_31 and not isNil(var_45_29) then
				local var_45_32 = (arg_42_1.time_ - var_45_30) / var_45_31

				if arg_42_1.var_.characterEffect1084ui_story and not isNil(var_45_29) then
					local var_45_33 = Mathf.Lerp(0, 0.5, var_45_32)

					arg_42_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1084ui_story.fillRatio = var_45_33
				end
			end

			if arg_42_1.time_ >= var_45_30 + var_45_31 and arg_42_1.time_ < var_45_30 + var_45_31 + arg_45_0 and not isNil(var_45_29) and arg_42_1.var_.characterEffect1084ui_story then
				local var_45_34 = 0.5

				arg_42_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1084ui_story.fillRatio = var_45_34
			end

			local var_45_35 = 0
			local var_45_36 = 0.25

			if var_45_35 < arg_42_1.time_ and arg_42_1.time_ <= var_45_35 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_37 = arg_42_1:FormatText(StoryNameCfg[693].name)

				arg_42_1.leftNameTxt_.text = var_45_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_38 = arg_42_1:GetWordFromCfg(319451010)
				local var_45_39 = arg_42_1:FormatText(var_45_38.content)

				arg_42_1.text_.text = var_45_39

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_40 = 10
				local var_45_41 = utf8.len(var_45_39)
				local var_45_42 = var_45_40 <= 0 and var_45_36 or var_45_36 * (var_45_41 / var_45_40)

				if var_45_42 > 0 and var_45_36 < var_45_42 then
					arg_42_1.talkMaxDuration = var_45_42

					if var_45_42 + var_45_35 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_42 + var_45_35
					end
				end

				arg_42_1.text_.text = var_45_39
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451010", "story_v_out_319451.awb") ~= 0 then
					local var_45_43 = manager.audio:GetVoiceLength("story_v_out_319451", "319451010", "story_v_out_319451.awb") / 1000

					if var_45_43 + var_45_35 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_43 + var_45_35
					end

					if var_45_38.prefab_name ~= "" and arg_42_1.actors_[var_45_38.prefab_name] ~= nil then
						local var_45_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_38.prefab_name].transform, "story_v_out_319451", "319451010", "story_v_out_319451.awb")

						arg_42_1:RecordAudio("319451010", var_45_44)
						arg_42_1:RecordAudio("319451010", var_45_44)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_319451", "319451010", "story_v_out_319451.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_319451", "319451010", "story_v_out_319451.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_45 = math.max(var_45_36, arg_42_1.talkMaxDuration)

			if var_45_35 <= arg_42_1.time_ and arg_42_1.time_ < var_45_35 + var_45_45 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_35) / var_45_45

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_35 + var_45_45 and arg_42_1.time_ < var_45_35 + var_45_45 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play319451011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 319451011
		arg_46_1.duration_ = 8.03

		local var_46_0 = {
			zh = 4.366,
			ja = 8.033
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
				arg_46_0:Play319451012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["10069ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect10069ui_story == nil then
				arg_46_1.var_.characterEffect10069ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.200000002980232

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect10069ui_story and not isNil(var_49_0) then
					local var_49_4 = Mathf.Lerp(0, 0.5, var_49_3)

					arg_46_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_46_1.var_.characterEffect10069ui_story.fillRatio = var_49_4
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect10069ui_story then
				local var_49_5 = 0.5

				arg_46_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_46_1.var_.characterEffect10069ui_story.fillRatio = var_49_5
			end

			local var_49_6 = arg_46_1.actors_["1084ui_story"]
			local var_49_7 = 0

			if var_49_7 < arg_46_1.time_ and arg_46_1.time_ <= var_49_7 + arg_49_0 and not isNil(var_49_6) and arg_46_1.var_.characterEffect1084ui_story == nil then
				arg_46_1.var_.characterEffect1084ui_story = var_49_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_8 = 0.200000002980232

			if var_49_7 <= arg_46_1.time_ and arg_46_1.time_ < var_49_7 + var_49_8 and not isNil(var_49_6) then
				local var_49_9 = (arg_46_1.time_ - var_49_7) / var_49_8

				if arg_46_1.var_.characterEffect1084ui_story and not isNil(var_49_6) then
					arg_46_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_7 + var_49_8 and arg_46_1.time_ < var_49_7 + var_49_8 + arg_49_0 and not isNil(var_49_6) and arg_46_1.var_.characterEffect1084ui_story then
				arg_46_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_49_10 = 0
			local var_49_11 = 0.35

			if var_49_10 < arg_46_1.time_ and arg_46_1.time_ <= var_49_10 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_12 = arg_46_1:FormatText(StoryNameCfg[6].name)

				arg_46_1.leftNameTxt_.text = var_49_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_13 = arg_46_1:GetWordFromCfg(319451011)
				local var_49_14 = arg_46_1:FormatText(var_49_13.content)

				arg_46_1.text_.text = var_49_14

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_15 = 14
				local var_49_16 = utf8.len(var_49_14)
				local var_49_17 = var_49_15 <= 0 and var_49_11 or var_49_11 * (var_49_16 / var_49_15)

				if var_49_17 > 0 and var_49_11 < var_49_17 then
					arg_46_1.talkMaxDuration = var_49_17

					if var_49_17 + var_49_10 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_17 + var_49_10
					end
				end

				arg_46_1.text_.text = var_49_14
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451011", "story_v_out_319451.awb") ~= 0 then
					local var_49_18 = manager.audio:GetVoiceLength("story_v_out_319451", "319451011", "story_v_out_319451.awb") / 1000

					if var_49_18 + var_49_10 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_18 + var_49_10
					end

					if var_49_13.prefab_name ~= "" and arg_46_1.actors_[var_49_13.prefab_name] ~= nil then
						local var_49_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_13.prefab_name].transform, "story_v_out_319451", "319451011", "story_v_out_319451.awb")

						arg_46_1:RecordAudio("319451011", var_49_19)
						arg_46_1:RecordAudio("319451011", var_49_19)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_319451", "319451011", "story_v_out_319451.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_319451", "319451011", "story_v_out_319451.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_20 = math.max(var_49_11, arg_46_1.talkMaxDuration)

			if var_49_10 <= arg_46_1.time_ and arg_46_1.time_ < var_49_10 + var_49_20 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_10) / var_49_20

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_10 + var_49_20 and arg_46_1.time_ < var_49_10 + var_49_20 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play319451012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 319451012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play319451013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1084ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1084ui_story == nil then
				arg_50_1.var_.characterEffect1084ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect1084ui_story and not isNil(var_53_0) then
					local var_53_4 = Mathf.Lerp(0, 0.5, var_53_3)

					arg_50_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1084ui_story.fillRatio = var_53_4
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1084ui_story then
				local var_53_5 = 0.5

				arg_50_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1084ui_story.fillRatio = var_53_5
			end

			local var_53_6 = 0
			local var_53_7 = 0.2

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[698].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_9 = arg_50_1:GetWordFromCfg(319451012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 8
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
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_14 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_14 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_14

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_14 and arg_50_1.time_ < var_53_6 + var_53_14 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play319451013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 319451013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play319451014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 0.175

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_2 = arg_54_1:FormatText(StoryNameCfg[698].name)

				arg_54_1.leftNameTxt_.text = var_57_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_3 = arg_54_1:GetWordFromCfg(319451013)
				local var_57_4 = arg_54_1:FormatText(var_57_3.content)

				arg_54_1.text_.text = var_57_4

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 7
				local var_57_6 = utf8.len(var_57_4)
				local var_57_7 = var_57_5 <= 0 and var_57_1 or var_57_1 * (var_57_6 / var_57_5)

				if var_57_7 > 0 and var_57_1 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_4
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_8 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_8 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_8

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_8 and arg_54_1.time_ < var_57_0 + var_57_8 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play319451014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 319451014
		arg_58_1.duration_ = 6.63

		local var_58_0 = {
			zh = 5.066,
			ja = 6.633
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
				arg_58_0:Play319451015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1084ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1084ui_story == nil then
				arg_58_1.var_.characterEffect1084ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect1084ui_story and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1084ui_story then
				arg_58_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_61_4 = 0
			local var_61_5 = 0.5

			if var_61_4 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_6 = arg_58_1:FormatText(StoryNameCfg[6].name)

				arg_58_1.leftNameTxt_.text = var_61_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_7 = arg_58_1:GetWordFromCfg(319451014)
				local var_61_8 = arg_58_1:FormatText(var_61_7.content)

				arg_58_1.text_.text = var_61_8

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_9 = 20
				local var_61_10 = utf8.len(var_61_8)
				local var_61_11 = var_61_9 <= 0 and var_61_5 or var_61_5 * (var_61_10 / var_61_9)

				if var_61_11 > 0 and var_61_5 < var_61_11 then
					arg_58_1.talkMaxDuration = var_61_11

					if var_61_11 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_11 + var_61_4
					end
				end

				arg_58_1.text_.text = var_61_8
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451014", "story_v_out_319451.awb") ~= 0 then
					local var_61_12 = manager.audio:GetVoiceLength("story_v_out_319451", "319451014", "story_v_out_319451.awb") / 1000

					if var_61_12 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_12 + var_61_4
					end

					if var_61_7.prefab_name ~= "" and arg_58_1.actors_[var_61_7.prefab_name] ~= nil then
						local var_61_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_7.prefab_name].transform, "story_v_out_319451", "319451014", "story_v_out_319451.awb")

						arg_58_1:RecordAudio("319451014", var_61_13)
						arg_58_1:RecordAudio("319451014", var_61_13)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_319451", "319451014", "story_v_out_319451.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_319451", "319451014", "story_v_out_319451.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_14 = math.max(var_61_5, arg_58_1.talkMaxDuration)

			if var_61_4 <= arg_58_1.time_ and arg_58_1.time_ < var_61_4 + var_61_14 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_4) / var_61_14

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_4 + var_61_14 and arg_58_1.time_ < var_61_4 + var_61_14 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play319451015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 319451015
		arg_62_1.duration_ = 11.43

		local var_62_0 = {
			zh = 9.3,
			ja = 11.433
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
				arg_62_0:Play319451016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4137")
			end

			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_65_2 = 0
			local var_65_3 = 0.8

			if var_65_2 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_4 = arg_62_1:FormatText(StoryNameCfg[6].name)

				arg_62_1.leftNameTxt_.text = var_65_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_5 = arg_62_1:GetWordFromCfg(319451015)
				local var_65_6 = arg_62_1:FormatText(var_65_5.content)

				arg_62_1.text_.text = var_65_6

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_7 = 32
				local var_65_8 = utf8.len(var_65_6)
				local var_65_9 = var_65_7 <= 0 and var_65_3 or var_65_3 * (var_65_8 / var_65_7)

				if var_65_9 > 0 and var_65_3 < var_65_9 then
					arg_62_1.talkMaxDuration = var_65_9

					if var_65_9 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_9 + var_65_2
					end
				end

				arg_62_1.text_.text = var_65_6
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451015", "story_v_out_319451.awb") ~= 0 then
					local var_65_10 = manager.audio:GetVoiceLength("story_v_out_319451", "319451015", "story_v_out_319451.awb") / 1000

					if var_65_10 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_2
					end

					if var_65_5.prefab_name ~= "" and arg_62_1.actors_[var_65_5.prefab_name] ~= nil then
						local var_65_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_5.prefab_name].transform, "story_v_out_319451", "319451015", "story_v_out_319451.awb")

						arg_62_1:RecordAudio("319451015", var_65_11)
						arg_62_1:RecordAudio("319451015", var_65_11)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_319451", "319451015", "story_v_out_319451.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_319451", "319451015", "story_v_out_319451.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_12 = math.max(var_65_3, arg_62_1.talkMaxDuration)

			if var_65_2 <= arg_62_1.time_ and arg_62_1.time_ < var_65_2 + var_65_12 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_2) / var_65_12

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_2 + var_65_12 and arg_62_1.time_ < var_65_2 + var_65_12 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play319451016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 319451016
		arg_66_1.duration_ = 11.63

		local var_66_0 = {
			zh = 7.033,
			ja = 11.633
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
				arg_66_0:Play319451017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["10069ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos10069ui_story = var_69_0.localPosition
			end

			local var_69_2 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2
				local var_69_4 = Vector3.New(0.7, -1.08, -6.33)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10069ui_story, var_69_4, var_69_3)

				local var_69_5 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_5.x, var_69_5.y, var_69_5.z)

				local var_69_6 = var_69_0.localEulerAngles

				var_69_6.z = 0
				var_69_6.x = 0
				var_69_0.localEulerAngles = var_69_6
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_69_7 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_7.x, var_69_7.y, var_69_7.z)

				local var_69_8 = var_69_0.localEulerAngles

				var_69_8.z = 0
				var_69_8.x = 0
				var_69_0.localEulerAngles = var_69_8
			end

			local var_69_9 = arg_66_1.actors_["10069ui_story"]
			local var_69_10 = 0

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 and not isNil(var_69_9) and arg_66_1.var_.characterEffect10069ui_story == nil then
				arg_66_1.var_.characterEffect10069ui_story = var_69_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_11 = 0.200000002980232

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_11 and not isNil(var_69_9) then
				local var_69_12 = (arg_66_1.time_ - var_69_10) / var_69_11

				if arg_66_1.var_.characterEffect10069ui_story and not isNil(var_69_9) then
					arg_66_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_10 + var_69_11 and arg_66_1.time_ < var_69_10 + var_69_11 + arg_69_0 and not isNil(var_69_9) and arg_66_1.var_.characterEffect10069ui_story then
				arg_66_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_69_13 = arg_66_1.actors_["1084ui_story"]
			local var_69_14 = 0

			if var_69_14 < arg_66_1.time_ and arg_66_1.time_ <= var_69_14 + arg_69_0 and not isNil(var_69_13) and arg_66_1.var_.characterEffect1084ui_story == nil then
				arg_66_1.var_.characterEffect1084ui_story = var_69_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_15 = 0.200000002980232

			if var_69_14 <= arg_66_1.time_ and arg_66_1.time_ < var_69_14 + var_69_15 and not isNil(var_69_13) then
				local var_69_16 = (arg_66_1.time_ - var_69_14) / var_69_15

				if arg_66_1.var_.characterEffect1084ui_story and not isNil(var_69_13) then
					local var_69_17 = Mathf.Lerp(0, 0.5, var_69_16)

					arg_66_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1084ui_story.fillRatio = var_69_17
				end
			end

			if arg_66_1.time_ >= var_69_14 + var_69_15 and arg_66_1.time_ < var_69_14 + var_69_15 + arg_69_0 and not isNil(var_69_13) and arg_66_1.var_.characterEffect1084ui_story then
				local var_69_18 = 0.5

				arg_66_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1084ui_story.fillRatio = var_69_18
			end

			local var_69_19 = 0
			local var_69_20 = 0.85

			if var_69_19 < arg_66_1.time_ and arg_66_1.time_ <= var_69_19 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_21 = arg_66_1:FormatText(StoryNameCfg[693].name)

				arg_66_1.leftNameTxt_.text = var_69_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_22 = arg_66_1:GetWordFromCfg(319451016)
				local var_69_23 = arg_66_1:FormatText(var_69_22.content)

				arg_66_1.text_.text = var_69_23

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_24 = 35
				local var_69_25 = utf8.len(var_69_23)
				local var_69_26 = var_69_24 <= 0 and var_69_20 or var_69_20 * (var_69_25 / var_69_24)

				if var_69_26 > 0 and var_69_20 < var_69_26 then
					arg_66_1.talkMaxDuration = var_69_26

					if var_69_26 + var_69_19 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_26 + var_69_19
					end
				end

				arg_66_1.text_.text = var_69_23
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451016", "story_v_out_319451.awb") ~= 0 then
					local var_69_27 = manager.audio:GetVoiceLength("story_v_out_319451", "319451016", "story_v_out_319451.awb") / 1000

					if var_69_27 + var_69_19 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_27 + var_69_19
					end

					if var_69_22.prefab_name ~= "" and arg_66_1.actors_[var_69_22.prefab_name] ~= nil then
						local var_69_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_22.prefab_name].transform, "story_v_out_319451", "319451016", "story_v_out_319451.awb")

						arg_66_1:RecordAudio("319451016", var_69_28)
						arg_66_1:RecordAudio("319451016", var_69_28)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_319451", "319451016", "story_v_out_319451.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_319451", "319451016", "story_v_out_319451.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_29 = math.max(var_69_20, arg_66_1.talkMaxDuration)

			if var_69_19 <= arg_66_1.time_ and arg_66_1.time_ < var_69_19 + var_69_29 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_19) / var_69_29

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_19 + var_69_29 and arg_66_1.time_ < var_69_19 + var_69_29 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
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
	Play319451017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 319451017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play319451018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10069ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10069ui_story == nil then
				arg_70_1.var_.characterEffect10069ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect10069ui_story and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10069ui_story.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10069ui_story then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10069ui_story.fillRatio = var_73_5
			end

			local var_73_6 = 0
			local var_73_7 = 0.65

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_8 = arg_70_1:FormatText(StoryNameCfg[698].name)

				arg_70_1.leftNameTxt_.text = var_73_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_9 = arg_70_1:GetWordFromCfg(319451017)
				local var_73_10 = arg_70_1:FormatText(var_73_9.content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 26
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
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_14 and arg_70_1.time_ < var_73_6 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play319451018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 319451018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play319451019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.5

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[698].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(319451018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 20
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
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_8 and arg_74_1.time_ < var_77_0 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play319451019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 319451019
		arg_78_1.duration_ = 3.57

		local var_78_0 = {
			zh = 3.033,
			ja = 3.566
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
				arg_78_0:Play319451020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1084ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos1084ui_story = var_81_0.localPosition
			end

			local var_81_2 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2
				local var_81_4 = Vector3.New(-0.7, -0.97, -6)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1084ui_story, var_81_4, var_81_3)

				local var_81_5 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_5.x, var_81_5.y, var_81_5.z)

				local var_81_6 = var_81_0.localEulerAngles

				var_81_6.z = 0
				var_81_6.x = 0
				var_81_0.localEulerAngles = var_81_6
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_81_7 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_7.x, var_81_7.y, var_81_7.z)

				local var_81_8 = var_81_0.localEulerAngles

				var_81_8.z = 0
				var_81_8.x = 0
				var_81_0.localEulerAngles = var_81_8
			end

			local var_81_9 = arg_78_1.actors_["1084ui_story"]
			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 and not isNil(var_81_9) and arg_78_1.var_.characterEffect1084ui_story == nil then
				arg_78_1.var_.characterEffect1084ui_story = var_81_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_11 = 0.200000002980232

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_11 and not isNil(var_81_9) then
				local var_81_12 = (arg_78_1.time_ - var_81_10) / var_81_11

				if arg_78_1.var_.characterEffect1084ui_story and not isNil(var_81_9) then
					arg_78_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_10 + var_81_11 and arg_78_1.time_ < var_81_10 + var_81_11 + arg_81_0 and not isNil(var_81_9) and arg_78_1.var_.characterEffect1084ui_story then
				arg_78_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_81_13 = 0

			if var_81_13 < arg_78_1.time_ and arg_78_1.time_ <= var_81_13 + arg_81_0 then
				arg_78_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_81_14 = 0

			if var_81_14 < arg_78_1.time_ and arg_78_1.time_ <= var_81_14 + arg_81_0 then
				arg_78_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_81_15 = 0
			local var_81_16 = 0.175

			if var_81_15 < arg_78_1.time_ and arg_78_1.time_ <= var_81_15 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_17 = arg_78_1:FormatText(StoryNameCfg[6].name)

				arg_78_1.leftNameTxt_.text = var_81_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_18 = arg_78_1:GetWordFromCfg(319451019)
				local var_81_19 = arg_78_1:FormatText(var_81_18.content)

				arg_78_1.text_.text = var_81_19

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_20 = 7
				local var_81_21 = utf8.len(var_81_19)
				local var_81_22 = var_81_20 <= 0 and var_81_16 or var_81_16 * (var_81_21 / var_81_20)

				if var_81_22 > 0 and var_81_16 < var_81_22 then
					arg_78_1.talkMaxDuration = var_81_22

					if var_81_22 + var_81_15 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_22 + var_81_15
					end
				end

				arg_78_1.text_.text = var_81_19
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451019", "story_v_out_319451.awb") ~= 0 then
					local var_81_23 = manager.audio:GetVoiceLength("story_v_out_319451", "319451019", "story_v_out_319451.awb") / 1000

					if var_81_23 + var_81_15 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_23 + var_81_15
					end

					if var_81_18.prefab_name ~= "" and arg_78_1.actors_[var_81_18.prefab_name] ~= nil then
						local var_81_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_18.prefab_name].transform, "story_v_out_319451", "319451019", "story_v_out_319451.awb")

						arg_78_1:RecordAudio("319451019", var_81_24)
						arg_78_1:RecordAudio("319451019", var_81_24)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_319451", "319451019", "story_v_out_319451.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_319451", "319451019", "story_v_out_319451.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_25 = math.max(var_81_16, arg_78_1.talkMaxDuration)

			if var_81_15 <= arg_78_1.time_ and arg_78_1.time_ < var_81_15 + var_81_25 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_15) / var_81_25

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_15 + var_81_25 and arg_78_1.time_ < var_81_15 + var_81_25 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play319451020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 319451020
		arg_82_1.duration_ = 6.2

		local var_82_0 = {
			zh = 2.5,
			ja = 6.2
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
				arg_82_0:Play319451021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1084ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1084ui_story == nil then
				arg_82_1.var_.characterEffect1084ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect1084ui_story and not isNil(var_85_0) then
					local var_85_4 = Mathf.Lerp(0, 0.5, var_85_3)

					arg_82_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1084ui_story.fillRatio = var_85_4
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1084ui_story then
				local var_85_5 = 0.5

				arg_82_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1084ui_story.fillRatio = var_85_5
			end

			local var_85_6 = arg_82_1.actors_["10069ui_story"]
			local var_85_7 = 0

			if var_85_7 < arg_82_1.time_ and arg_82_1.time_ <= var_85_7 + arg_85_0 and not isNil(var_85_6) and arg_82_1.var_.characterEffect10069ui_story == nil then
				arg_82_1.var_.characterEffect10069ui_story = var_85_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_8 = 0.200000002980232

			if var_85_7 <= arg_82_1.time_ and arg_82_1.time_ < var_85_7 + var_85_8 and not isNil(var_85_6) then
				local var_85_9 = (arg_82_1.time_ - var_85_7) / var_85_8

				if arg_82_1.var_.characterEffect10069ui_story and not isNil(var_85_6) then
					arg_82_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_7 + var_85_8 and arg_82_1.time_ < var_85_7 + var_85_8 + arg_85_0 and not isNil(var_85_6) and arg_82_1.var_.characterEffect10069ui_story then
				arg_82_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				arg_82_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action4_1")
			end

			local var_85_11 = 0
			local var_85_12 = 0.325

			if var_85_11 < arg_82_1.time_ and arg_82_1.time_ <= var_85_11 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_13 = arg_82_1:FormatText(StoryNameCfg[693].name)

				arg_82_1.leftNameTxt_.text = var_85_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_14 = arg_82_1:GetWordFromCfg(319451020)
				local var_85_15 = arg_82_1:FormatText(var_85_14.content)

				arg_82_1.text_.text = var_85_15

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_16 = 13
				local var_85_17 = utf8.len(var_85_15)
				local var_85_18 = var_85_16 <= 0 and var_85_12 or var_85_12 * (var_85_17 / var_85_16)

				if var_85_18 > 0 and var_85_12 < var_85_18 then
					arg_82_1.talkMaxDuration = var_85_18

					if var_85_18 + var_85_11 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_18 + var_85_11
					end
				end

				arg_82_1.text_.text = var_85_15
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451020", "story_v_out_319451.awb") ~= 0 then
					local var_85_19 = manager.audio:GetVoiceLength("story_v_out_319451", "319451020", "story_v_out_319451.awb") / 1000

					if var_85_19 + var_85_11 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_19 + var_85_11
					end

					if var_85_14.prefab_name ~= "" and arg_82_1.actors_[var_85_14.prefab_name] ~= nil then
						local var_85_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_14.prefab_name].transform, "story_v_out_319451", "319451020", "story_v_out_319451.awb")

						arg_82_1:RecordAudio("319451020", var_85_20)
						arg_82_1:RecordAudio("319451020", var_85_20)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_319451", "319451020", "story_v_out_319451.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_319451", "319451020", "story_v_out_319451.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_21 = math.max(var_85_12, arg_82_1.talkMaxDuration)

			if var_85_11 <= arg_82_1.time_ and arg_82_1.time_ < var_85_11 + var_85_21 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_11) / var_85_21

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_11 + var_85_21 and arg_82_1.time_ < var_85_11 + var_85_21 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play319451021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 319451021
		arg_86_1.duration_ = 8.03

		local var_86_0 = {
			zh = 7.333,
			ja = 8.033
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
				arg_86_0:Play319451022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1084ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1084ui_story == nil then
				arg_86_1.var_.characterEffect1084ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1084ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1084ui_story then
				arg_86_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_89_4 = arg_86_1.actors_["10069ui_story"]
			local var_89_5 = 0

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect10069ui_story == nil then
				arg_86_1.var_.characterEffect10069ui_story = var_89_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.200000002980232

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 and not isNil(var_89_4) then
				local var_89_7 = (arg_86_1.time_ - var_89_5) / var_89_6

				if arg_86_1.var_.characterEffect10069ui_story and not isNil(var_89_4) then
					local var_89_8 = Mathf.Lerp(0, 0.5, var_89_7)

					arg_86_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10069ui_story.fillRatio = var_89_8
				end
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect10069ui_story then
				local var_89_9 = 0.5

				arg_86_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10069ui_story.fillRatio = var_89_9
			end

			local var_89_10 = 0
			local var_89_11 = 0.625

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_12 = arg_86_1:FormatText(StoryNameCfg[6].name)

				arg_86_1.leftNameTxt_.text = var_89_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_13 = arg_86_1:GetWordFromCfg(319451021)
				local var_89_14 = arg_86_1:FormatText(var_89_13.content)

				arg_86_1.text_.text = var_89_14

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_15 = 25
				local var_89_16 = utf8.len(var_89_14)
				local var_89_17 = var_89_15 <= 0 and var_89_11 or var_89_11 * (var_89_16 / var_89_15)

				if var_89_17 > 0 and var_89_11 < var_89_17 then
					arg_86_1.talkMaxDuration = var_89_17

					if var_89_17 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_17 + var_89_10
					end
				end

				arg_86_1.text_.text = var_89_14
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451021", "story_v_out_319451.awb") ~= 0 then
					local var_89_18 = manager.audio:GetVoiceLength("story_v_out_319451", "319451021", "story_v_out_319451.awb") / 1000

					if var_89_18 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_18 + var_89_10
					end

					if var_89_13.prefab_name ~= "" and arg_86_1.actors_[var_89_13.prefab_name] ~= nil then
						local var_89_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_13.prefab_name].transform, "story_v_out_319451", "319451021", "story_v_out_319451.awb")

						arg_86_1:RecordAudio("319451021", var_89_19)
						arg_86_1:RecordAudio("319451021", var_89_19)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_319451", "319451021", "story_v_out_319451.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_319451", "319451021", "story_v_out_319451.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_20 = math.max(var_89_11, arg_86_1.talkMaxDuration)

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_20 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_10) / var_89_20

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_10 + var_89_20 and arg_86_1.time_ < var_89_10 + var_89_20 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play319451022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 319451022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play319451023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1084ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1084ui_story == nil then
				arg_90_1.var_.characterEffect1084ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1084ui_story and not isNil(var_93_0) then
					local var_93_4 = Mathf.Lerp(0, 0.5, var_93_3)

					arg_90_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1084ui_story.fillRatio = var_93_4
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1084ui_story then
				local var_93_5 = 0.5

				arg_90_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1084ui_story.fillRatio = var_93_5
			end

			local var_93_6 = 0
			local var_93_7 = 0.975

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_8 = arg_90_1:GetWordFromCfg(319451022)
				local var_93_9 = arg_90_1:FormatText(var_93_8.content)

				arg_90_1.text_.text = var_93_9

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_10 = 39
				local var_93_11 = utf8.len(var_93_9)
				local var_93_12 = var_93_10 <= 0 and var_93_7 or var_93_7 * (var_93_11 / var_93_10)

				if var_93_12 > 0 and var_93_7 < var_93_12 then
					arg_90_1.talkMaxDuration = var_93_12

					if var_93_12 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_12 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_9
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_13 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_13 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_13

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_13 and arg_90_1.time_ < var_93_6 + var_93_13 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play319451023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 319451023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play319451024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.7

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[698].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:GetWordFromCfg(319451023)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 28
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_8 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_8 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_8

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_8 and arg_94_1.time_ < var_97_0 + var_97_8 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play319451024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 319451024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play319451025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.475

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[698].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_3 = arg_98_1:GetWordFromCfg(319451024)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 19
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_8 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_8 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_8

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_8 and arg_98_1.time_ < var_101_0 + var_101_8 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play319451025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 319451025
		arg_102_1.duration_ = 2.07

		local var_102_0 = {
			zh = 1.999999999999,
			ja = 2.066
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
				arg_102_0:Play319451026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["10069ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos10069ui_story = var_105_0.localPosition
			end

			local var_105_2 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2
				local var_105_4 = Vector3.New(0.7, -1.08, -6.33)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10069ui_story, var_105_4, var_105_3)

				local var_105_5 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_5.x, var_105_5.y, var_105_5.z)

				local var_105_6 = var_105_0.localEulerAngles

				var_105_6.z = 0
				var_105_6.x = 0
				var_105_0.localEulerAngles = var_105_6
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_105_7 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_7.x, var_105_7.y, var_105_7.z)

				local var_105_8 = var_105_0.localEulerAngles

				var_105_8.z = 0
				var_105_8.x = 0
				var_105_0.localEulerAngles = var_105_8
			end

			local var_105_9 = arg_102_1.actors_["10069ui_story"]
			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 and not isNil(var_105_9) and arg_102_1.var_.characterEffect10069ui_story == nil then
				arg_102_1.var_.characterEffect10069ui_story = var_105_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_11 = 0.200000002980232

			if var_105_10 <= arg_102_1.time_ and arg_102_1.time_ < var_105_10 + var_105_11 and not isNil(var_105_9) then
				local var_105_12 = (arg_102_1.time_ - var_105_10) / var_105_11

				if arg_102_1.var_.characterEffect10069ui_story and not isNil(var_105_9) then
					arg_102_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_10 + var_105_11 and arg_102_1.time_ < var_105_10 + var_105_11 + arg_105_0 and not isNil(var_105_9) and arg_102_1.var_.characterEffect10069ui_story then
				arg_102_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_105_13 = 0

			if var_105_13 < arg_102_1.time_ and arg_102_1.time_ <= var_105_13 + arg_105_0 then
				arg_102_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_105_14 = 0

			if var_105_14 < arg_102_1.time_ and arg_102_1.time_ <= var_105_14 + arg_105_0 then
				arg_102_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10069/story10069action/10069action4_2")
			end

			local var_105_15 = 0
			local var_105_16 = 0.075

			if var_105_15 < arg_102_1.time_ and arg_102_1.time_ <= var_105_15 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_17 = arg_102_1:FormatText(StoryNameCfg[693].name)

				arg_102_1.leftNameTxt_.text = var_105_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_18 = arg_102_1:GetWordFromCfg(319451025)
				local var_105_19 = arg_102_1:FormatText(var_105_18.content)

				arg_102_1.text_.text = var_105_19

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_20 = 3
				local var_105_21 = utf8.len(var_105_19)
				local var_105_22 = var_105_20 <= 0 and var_105_16 or var_105_16 * (var_105_21 / var_105_20)

				if var_105_22 > 0 and var_105_16 < var_105_22 then
					arg_102_1.talkMaxDuration = var_105_22

					if var_105_22 + var_105_15 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_22 + var_105_15
					end
				end

				arg_102_1.text_.text = var_105_19
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451025", "story_v_out_319451.awb") ~= 0 then
					local var_105_23 = manager.audio:GetVoiceLength("story_v_out_319451", "319451025", "story_v_out_319451.awb") / 1000

					if var_105_23 + var_105_15 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_23 + var_105_15
					end

					if var_105_18.prefab_name ~= "" and arg_102_1.actors_[var_105_18.prefab_name] ~= nil then
						local var_105_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_18.prefab_name].transform, "story_v_out_319451", "319451025", "story_v_out_319451.awb")

						arg_102_1:RecordAudio("319451025", var_105_24)
						arg_102_1:RecordAudio("319451025", var_105_24)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_319451", "319451025", "story_v_out_319451.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_319451", "319451025", "story_v_out_319451.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_25 = math.max(var_105_16, arg_102_1.talkMaxDuration)

			if var_105_15 <= arg_102_1.time_ and arg_102_1.time_ < var_105_15 + var_105_25 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_15) / var_105_25

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_15 + var_105_25 and arg_102_1.time_ < var_105_15 + var_105_25 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play319451026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 319451026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play319451027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["10069ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10069ui_story == nil then
				arg_106_1.var_.characterEffect10069ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect10069ui_story and not isNil(var_109_0) then
					local var_109_4 = Mathf.Lerp(0, 0.5, var_109_3)

					arg_106_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_106_1.var_.characterEffect10069ui_story.fillRatio = var_109_4
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10069ui_story then
				local var_109_5 = 0.5

				arg_106_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_106_1.var_.characterEffect10069ui_story.fillRatio = var_109_5
			end

			local var_109_6 = 0
			local var_109_7 = 0.95

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_8 = arg_106_1:GetWordFromCfg(319451026)
				local var_109_9 = arg_106_1:FormatText(var_109_8.content)

				arg_106_1.text_.text = var_109_9

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_10 = 38
				local var_109_11 = utf8.len(var_109_9)
				local var_109_12 = var_109_10 <= 0 and var_109_7 or var_109_7 * (var_109_11 / var_109_10)

				if var_109_12 > 0 and var_109_7 < var_109_12 then
					arg_106_1.talkMaxDuration = var_109_12

					if var_109_12 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_9
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_13 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_13 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_13

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_13 and arg_106_1.time_ < var_109_6 + var_109_13 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play319451027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 319451027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play319451028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 1.375

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_2 = arg_110_1:GetWordFromCfg(319451027)
				local var_113_3 = arg_110_1:FormatText(var_113_2.content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 55
				local var_113_5 = utf8.len(var_113_3)
				local var_113_6 = var_113_4 <= 0 and var_113_1 or var_113_1 * (var_113_5 / var_113_4)

				if var_113_6 > 0 and var_113_1 < var_113_6 then
					arg_110_1.talkMaxDuration = var_113_6

					if var_113_6 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_6 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_3
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_7 and arg_110_1.time_ < var_113_0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play319451028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 319451028
		arg_114_1.duration_ = 6.93

		local var_114_0 = {
			zh = 6.06666666666667,
			ja = 6.93266666666667
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
				arg_114_0:Play319451029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1084ui_story"].transform
			local var_117_1 = 3.36666666666667

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos1084ui_story = var_117_0.localPosition
			end

			local var_117_2 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2
				local var_117_4 = Vector3.New(0, -0.97, -6)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1084ui_story, var_117_4, var_117_3)

				local var_117_5 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_5.x, var_117_5.y, var_117_5.z)

				local var_117_6 = var_117_0.localEulerAngles

				var_117_6.z = 0
				var_117_6.x = 0
				var_117_0.localEulerAngles = var_117_6
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_117_7 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_7.x, var_117_7.y, var_117_7.z)

				local var_117_8 = var_117_0.localEulerAngles

				var_117_8.z = 0
				var_117_8.x = 0
				var_117_0.localEulerAngles = var_117_8
			end

			local var_117_9 = arg_114_1.actors_["1084ui_story"]
			local var_117_10 = 3.36666666666667

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 and not isNil(var_117_9) and arg_114_1.var_.characterEffect1084ui_story == nil then
				arg_114_1.var_.characterEffect1084ui_story = var_117_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_11 = 0.200000002980232

			if var_117_10 <= arg_114_1.time_ and arg_114_1.time_ < var_117_10 + var_117_11 and not isNil(var_117_9) then
				local var_117_12 = (arg_114_1.time_ - var_117_10) / var_117_11

				if arg_114_1.var_.characterEffect1084ui_story and not isNil(var_117_9) then
					arg_114_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_10 + var_117_11 and arg_114_1.time_ < var_117_10 + var_117_11 + arg_117_0 and not isNil(var_117_9) and arg_114_1.var_.characterEffect1084ui_story then
				arg_114_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_117_13 = 3.36666666666667

			if var_117_13 < arg_114_1.time_ and arg_114_1.time_ <= var_117_13 + arg_117_0 then
				arg_114_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_117_14 = 3.36666666666667

			if var_117_14 < arg_114_1.time_ and arg_114_1.time_ <= var_117_14 + arg_117_0 then
				arg_114_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_117_15 = 0

			if var_117_15 < arg_114_1.time_ and arg_114_1.time_ <= var_117_15 + arg_117_0 then
				local var_117_16 = manager.ui.mainCamera.transform.localPosition
				local var_117_17 = Vector3.New(0, 0, 10) + Vector3.New(var_117_16.x, var_117_16.y, 0)
				local var_117_18 = arg_114_1.bgs_.ST07a

				var_117_18.transform.localPosition = var_117_17
				var_117_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_19 = var_117_18:GetComponent("SpriteRenderer")

				if var_117_19 and var_117_19.sprite then
					local var_117_20 = (var_117_18.transform.localPosition - var_117_16).z
					local var_117_21 = manager.ui.mainCameraCom_
					local var_117_22 = 2 * var_117_20 * Mathf.Tan(var_117_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_117_23 = var_117_22 * var_117_21.aspect
					local var_117_24 = var_117_19.sprite.bounds.size.x
					local var_117_25 = var_117_19.sprite.bounds.size.y
					local var_117_26 = var_117_23 / var_117_24
					local var_117_27 = var_117_22 / var_117_25
					local var_117_28 = var_117_27 < var_117_26 and var_117_26 or var_117_27

					var_117_18.transform.localScale = Vector3.New(var_117_28, var_117_28, 0)
				end

				for iter_117_0, iter_117_1 in pairs(arg_114_1.bgs_) do
					if iter_117_0 ~= "ST07a" then
						iter_117_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_29 = 2

			if var_117_29 < arg_114_1.time_ and arg_114_1.time_ <= var_117_29 + arg_117_0 then
				local var_117_30 = manager.ui.mainCamera.transform.localPosition
				local var_117_31 = Vector3.New(0, 0, 10) + Vector3.New(var_117_30.x, var_117_30.y, 0)
				local var_117_32 = arg_114_1.bgs_.ST07a

				var_117_32.transform.localPosition = var_117_31
				var_117_32.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_33 = var_117_32:GetComponent("SpriteRenderer")

				if var_117_33 and var_117_33.sprite then
					local var_117_34 = (var_117_32.transform.localPosition - var_117_30).z
					local var_117_35 = manager.ui.mainCameraCom_
					local var_117_36 = 2 * var_117_34 * Mathf.Tan(var_117_35.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_117_37 = var_117_36 * var_117_35.aspect
					local var_117_38 = var_117_33.sprite.bounds.size.x
					local var_117_39 = var_117_33.sprite.bounds.size.y
					local var_117_40 = var_117_37 / var_117_38
					local var_117_41 = var_117_36 / var_117_39
					local var_117_42 = var_117_41 < var_117_40 and var_117_40 or var_117_41

					var_117_32.transform.localScale = Vector3.New(var_117_42, var_117_42, 0)
				end

				for iter_117_2, iter_117_3 in pairs(arg_114_1.bgs_) do
					if iter_117_2 ~= "ST07a" then
						iter_117_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_43 = 0

			if var_117_43 < arg_114_1.time_ and arg_114_1.time_ <= var_117_43 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_44 = 2

			if var_117_43 <= arg_114_1.time_ and arg_114_1.time_ < var_117_43 + var_117_44 then
				local var_117_45 = (arg_114_1.time_ - var_117_43) / var_117_44
				local var_117_46 = Color.New(0, 0, 0)

				var_117_46.a = Mathf.Lerp(0, 1, var_117_45)
				arg_114_1.mask_.color = var_117_46
			end

			if arg_114_1.time_ >= var_117_43 + var_117_44 and arg_114_1.time_ < var_117_43 + var_117_44 + arg_117_0 then
				local var_117_47 = Color.New(0, 0, 0)

				var_117_47.a = 1
				arg_114_1.mask_.color = var_117_47
			end

			local var_117_48 = 2

			if var_117_48 < arg_114_1.time_ and arg_114_1.time_ <= var_117_48 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_49 = 2

			if var_117_48 <= arg_114_1.time_ and arg_114_1.time_ < var_117_48 + var_117_49 then
				local var_117_50 = (arg_114_1.time_ - var_117_48) / var_117_49
				local var_117_51 = Color.New(0, 0, 0)

				var_117_51.a = Mathf.Lerp(1, 0, var_117_50)
				arg_114_1.mask_.color = var_117_51
			end

			if arg_114_1.time_ >= var_117_48 + var_117_49 and arg_114_1.time_ < var_117_48 + var_117_49 + arg_117_0 then
				local var_117_52 = Color.New(0, 0, 0)
				local var_117_53 = 0

				arg_114_1.mask_.enabled = false
				var_117_52.a = var_117_53
				arg_114_1.mask_.color = var_117_52
			end

			local var_117_54 = arg_114_1.actors_["1084ui_story"].transform
			local var_117_55 = 2

			if var_117_55 < arg_114_1.time_ and arg_114_1.time_ <= var_117_55 + arg_117_0 then
				arg_114_1.var_.moveOldPos1084ui_story = var_117_54.localPosition
			end

			local var_117_56 = 0.001

			if var_117_55 <= arg_114_1.time_ and arg_114_1.time_ < var_117_55 + var_117_56 then
				local var_117_57 = (arg_114_1.time_ - var_117_55) / var_117_56
				local var_117_58 = Vector3.New(0, 100, 0)

				var_117_54.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1084ui_story, var_117_58, var_117_57)

				local var_117_59 = manager.ui.mainCamera.transform.position - var_117_54.position

				var_117_54.forward = Vector3.New(var_117_59.x, var_117_59.y, var_117_59.z)

				local var_117_60 = var_117_54.localEulerAngles

				var_117_60.z = 0
				var_117_60.x = 0
				var_117_54.localEulerAngles = var_117_60
			end

			if arg_114_1.time_ >= var_117_55 + var_117_56 and arg_114_1.time_ < var_117_55 + var_117_56 + arg_117_0 then
				var_117_54.localPosition = Vector3.New(0, 100, 0)

				local var_117_61 = manager.ui.mainCamera.transform.position - var_117_54.position

				var_117_54.forward = Vector3.New(var_117_61.x, var_117_61.y, var_117_61.z)

				local var_117_62 = var_117_54.localEulerAngles

				var_117_62.z = 0
				var_117_62.x = 0
				var_117_54.localEulerAngles = var_117_62
			end

			local var_117_63 = arg_114_1.actors_["10069ui_story"].transform
			local var_117_64 = 2

			if var_117_64 < arg_114_1.time_ and arg_114_1.time_ <= var_117_64 + arg_117_0 then
				arg_114_1.var_.moveOldPos10069ui_story = var_117_63.localPosition
			end

			local var_117_65 = 0.001

			if var_117_64 <= arg_114_1.time_ and arg_114_1.time_ < var_117_64 + var_117_65 then
				local var_117_66 = (arg_114_1.time_ - var_117_64) / var_117_65
				local var_117_67 = Vector3.New(0, 100, 0)

				var_117_63.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10069ui_story, var_117_67, var_117_66)

				local var_117_68 = manager.ui.mainCamera.transform.position - var_117_63.position

				var_117_63.forward = Vector3.New(var_117_68.x, var_117_68.y, var_117_68.z)

				local var_117_69 = var_117_63.localEulerAngles

				var_117_69.z = 0
				var_117_69.x = 0
				var_117_63.localEulerAngles = var_117_69
			end

			if arg_114_1.time_ >= var_117_64 + var_117_65 and arg_114_1.time_ < var_117_64 + var_117_65 + arg_117_0 then
				var_117_63.localPosition = Vector3.New(0, 100, 0)

				local var_117_70 = manager.ui.mainCamera.transform.position - var_117_63.position

				var_117_63.forward = Vector3.New(var_117_70.x, var_117_70.y, var_117_70.z)

				local var_117_71 = var_117_63.localEulerAngles

				var_117_71.z = 0
				var_117_71.x = 0
				var_117_63.localEulerAngles = var_117_71
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_72 = 3.36666666666667
			local var_117_73 = 0.175

			if var_117_72 < arg_114_1.time_ and arg_114_1.time_ <= var_117_72 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_74 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_74:setOnUpdate(LuaHelper.FloatAction(function(arg_118_0)
					arg_114_1.dialogCg_.alpha = arg_118_0
				end))
				var_117_74:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_74:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_75 = arg_114_1:FormatText(StoryNameCfg[6].name)

				arg_114_1.leftNameTxt_.text = var_117_75

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_76 = arg_114_1:GetWordFromCfg(319451028)
				local var_117_77 = arg_114_1:FormatText(var_117_76.content)

				arg_114_1.text_.text = var_117_77

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_78 = 7
				local var_117_79 = utf8.len(var_117_77)
				local var_117_80 = var_117_78 <= 0 and var_117_73 or var_117_73 * (var_117_79 / var_117_78)

				if var_117_80 > 0 and var_117_73 < var_117_80 then
					arg_114_1.talkMaxDuration = var_117_80
					var_117_72 = var_117_72 + 0.3

					if var_117_80 + var_117_72 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_80 + var_117_72
					end
				end

				arg_114_1.text_.text = var_117_77
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451028", "story_v_out_319451.awb") ~= 0 then
					local var_117_81 = manager.audio:GetVoiceLength("story_v_out_319451", "319451028", "story_v_out_319451.awb") / 1000

					if var_117_81 + var_117_72 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_81 + var_117_72
					end

					if var_117_76.prefab_name ~= "" and arg_114_1.actors_[var_117_76.prefab_name] ~= nil then
						local var_117_82 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_76.prefab_name].transform, "story_v_out_319451", "319451028", "story_v_out_319451.awb")

						arg_114_1:RecordAudio("319451028", var_117_82)
						arg_114_1:RecordAudio("319451028", var_117_82)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_319451", "319451028", "story_v_out_319451.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_319451", "319451028", "story_v_out_319451.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_83 = var_117_72 + 0.3
			local var_117_84 = math.max(var_117_73, arg_114_1.talkMaxDuration)

			if var_117_83 <= arg_114_1.time_ and arg_114_1.time_ < var_117_83 + var_117_84 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_83) / var_117_84

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_83 + var_117_84 and arg_114_1.time_ < var_117_83 + var_117_84 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play319451029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 319451029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play319451030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1084ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1084ui_story == nil then
				arg_120_1.var_.characterEffect1084ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1084ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1084ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1084ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1084ui_story.fillRatio = var_123_5
			end

			local var_123_6 = 0
			local var_123_7 = 0.325

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_8 = arg_120_1:FormatText(StoryNameCfg[698].name)

				arg_120_1.leftNameTxt_.text = var_123_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_9 = arg_120_1:GetWordFromCfg(319451029)
				local var_123_10 = arg_120_1:FormatText(var_123_9.content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 13
				local var_123_12 = utf8.len(var_123_10)
				local var_123_13 = var_123_11 <= 0 and var_123_7 or var_123_7 * (var_123_12 / var_123_11)

				if var_123_13 > 0 and var_123_7 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_10
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_14 and arg_120_1.time_ < var_123_6 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play319451030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 319451030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play319451031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.4

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[698].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:GetWordFromCfg(319451030)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 16
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_8 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_8 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_8

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_8 and arg_124_1.time_ < var_127_0 + var_127_8 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play319451031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 319451031
		arg_128_1.duration_ = 6

		local var_128_0 = {
			zh = 5.966,
			ja = 6
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play319451032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1084ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1084ui_story == nil then
				arg_128_1.var_.characterEffect1084ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1084ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1084ui_story then
				arg_128_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_131_4 = 0
			local var_131_5 = 0.5

			if var_131_4 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_6 = arg_128_1:FormatText(StoryNameCfg[6].name)

				arg_128_1.leftNameTxt_.text = var_131_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_7 = arg_128_1:GetWordFromCfg(319451031)
				local var_131_8 = arg_128_1:FormatText(var_131_7.content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 20
				local var_131_10 = utf8.len(var_131_8)
				local var_131_11 = var_131_9 <= 0 and var_131_5 or var_131_5 * (var_131_10 / var_131_9)

				if var_131_11 > 0 and var_131_5 < var_131_11 then
					arg_128_1.talkMaxDuration = var_131_11

					if var_131_11 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451031", "story_v_out_319451.awb") ~= 0 then
					local var_131_12 = manager.audio:GetVoiceLength("story_v_out_319451", "319451031", "story_v_out_319451.awb") / 1000

					if var_131_12 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_12 + var_131_4
					end

					if var_131_7.prefab_name ~= "" and arg_128_1.actors_[var_131_7.prefab_name] ~= nil then
						local var_131_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_7.prefab_name].transform, "story_v_out_319451", "319451031", "story_v_out_319451.awb")

						arg_128_1:RecordAudio("319451031", var_131_13)
						arg_128_1:RecordAudio("319451031", var_131_13)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_319451", "319451031", "story_v_out_319451.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_319451", "319451031", "story_v_out_319451.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_14 and arg_128_1.time_ < var_131_4 + var_131_14 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play319451032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 319451032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play319451033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1084ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1084ui_story == nil then
				arg_132_1.var_.characterEffect1084ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1084ui_story and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1084ui_story.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1084ui_story then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1084ui_story.fillRatio = var_135_5
			end

			local var_135_6 = 0
			local var_135_7 = 0.35

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_8 = arg_132_1:FormatText(StoryNameCfg[698].name)

				arg_132_1.leftNameTxt_.text = var_135_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_9 = arg_132_1:GetWordFromCfg(319451032)
				local var_135_10 = arg_132_1:FormatText(var_135_9.content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 14
				local var_135_12 = utf8.len(var_135_10)
				local var_135_13 = var_135_11 <= 0 and var_135_7 or var_135_7 * (var_135_12 / var_135_11)

				if var_135_13 > 0 and var_135_7 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_10
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_14 and arg_132_1.time_ < var_135_6 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play319451033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 319451033
		arg_136_1.duration_ = 5.9

		local var_136_0 = {
			zh = 1.566,
			ja = 5.9
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play319451034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1084ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1084ui_story == nil then
				arg_136_1.var_.characterEffect1084ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1084ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1084ui_story then
				arg_136_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_139_4 = 0
			local var_139_5 = 0.1

			if var_139_4 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_6 = arg_136_1:FormatText(StoryNameCfg[6].name)

				arg_136_1.leftNameTxt_.text = var_139_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_7 = arg_136_1:GetWordFromCfg(319451033)
				local var_139_8 = arg_136_1:FormatText(var_139_7.content)

				arg_136_1.text_.text = var_139_8

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 4
				local var_139_10 = utf8.len(var_139_8)
				local var_139_11 = var_139_9 <= 0 and var_139_5 or var_139_5 * (var_139_10 / var_139_9)

				if var_139_11 > 0 and var_139_5 < var_139_11 then
					arg_136_1.talkMaxDuration = var_139_11

					if var_139_11 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_8
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451033", "story_v_out_319451.awb") ~= 0 then
					local var_139_12 = manager.audio:GetVoiceLength("story_v_out_319451", "319451033", "story_v_out_319451.awb") / 1000

					if var_139_12 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_12 + var_139_4
					end

					if var_139_7.prefab_name ~= "" and arg_136_1.actors_[var_139_7.prefab_name] ~= nil then
						local var_139_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_7.prefab_name].transform, "story_v_out_319451", "319451033", "story_v_out_319451.awb")

						arg_136_1:RecordAudio("319451033", var_139_13)
						arg_136_1:RecordAudio("319451033", var_139_13)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_319451", "319451033", "story_v_out_319451.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_319451", "319451033", "story_v_out_319451.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_14 and arg_136_1.time_ < var_139_4 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play319451034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 319451034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play319451035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1084ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1084ui_story == nil then
				arg_140_1.var_.characterEffect1084ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1084ui_story and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1084ui_story.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1084ui_story then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1084ui_story.fillRatio = var_143_5
			end

			local var_143_6 = 0
			local var_143_7 = 0.7

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_8 = arg_140_1:FormatText(StoryNameCfg[698].name)

				arg_140_1.leftNameTxt_.text = var_143_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_9 = arg_140_1:GetWordFromCfg(319451034)
				local var_143_10 = arg_140_1:FormatText(var_143_9.content)

				arg_140_1.text_.text = var_143_10

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 28
				local var_143_12 = utf8.len(var_143_10)
				local var_143_13 = var_143_11 <= 0 and var_143_7 or var_143_7 * (var_143_12 / var_143_11)

				if var_143_13 > 0 and var_143_7 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_10
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_14 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_14 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_14

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_14 and arg_140_1.time_ < var_143_6 + var_143_14 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play319451035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 319451035
		arg_144_1.duration_ = 12.07

		local var_144_0 = {
			zh = 7.1,
			ja = 12.066
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play319451036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.525

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[693].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10069")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(319451035)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 21
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451035", "story_v_out_319451.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_319451", "319451035", "story_v_out_319451.awb") / 1000

					if var_147_8 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_0
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_319451", "319451035", "story_v_out_319451.awb")

						arg_144_1:RecordAudio("319451035", var_147_9)
						arg_144_1:RecordAudio("319451035", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_319451", "319451035", "story_v_out_319451.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_319451", "319451035", "story_v_out_319451.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_10 and arg_144_1.time_ < var_147_0 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play319451036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 319451036
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play319451037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1084ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1084ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0, 100, 0)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1084ui_story, var_151_4, var_151_3)

				local var_151_5 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_5.x, var_151_5.y, var_151_5.z)

				local var_151_6 = var_151_0.localEulerAngles

				var_151_6.z = 0
				var_151_6.x = 0
				var_151_0.localEulerAngles = var_151_6
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0, 100, 0)

				local var_151_7 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_7.x, var_151_7.y, var_151_7.z)

				local var_151_8 = var_151_0.localEulerAngles

				var_151_8.z = 0
				var_151_8.x = 0
				var_151_0.localEulerAngles = var_151_8
			end

			local var_151_9 = arg_148_1.actors_["1084ui_story"]
			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect1084ui_story == nil then
				arg_148_1.var_.characterEffect1084ui_story = var_151_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_11 = 0.200000002980232

			if var_151_10 <= arg_148_1.time_ and arg_148_1.time_ < var_151_10 + var_151_11 and not isNil(var_151_9) then
				local var_151_12 = (arg_148_1.time_ - var_151_10) / var_151_11

				if arg_148_1.var_.characterEffect1084ui_story and not isNil(var_151_9) then
					local var_151_13 = Mathf.Lerp(0, 0.5, var_151_12)

					arg_148_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1084ui_story.fillRatio = var_151_13
				end
			end

			if arg_148_1.time_ >= var_151_10 + var_151_11 and arg_148_1.time_ < var_151_10 + var_151_11 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect1084ui_story then
				local var_151_14 = 0.5

				arg_148_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1084ui_story.fillRatio = var_151_14
			end

			local var_151_15 = arg_148_1.actors_["10069ui_story"].transform
			local var_151_16 = 0

			if var_151_16 < arg_148_1.time_ and arg_148_1.time_ <= var_151_16 + arg_151_0 then
				arg_148_1.var_.moveOldPos10069ui_story = var_151_15.localPosition
			end

			local var_151_17 = 0.001

			if var_151_16 <= arg_148_1.time_ and arg_148_1.time_ < var_151_16 + var_151_17 then
				local var_151_18 = (arg_148_1.time_ - var_151_16) / var_151_17
				local var_151_19 = Vector3.New(0, 100, 0)

				var_151_15.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10069ui_story, var_151_19, var_151_18)

				local var_151_20 = manager.ui.mainCamera.transform.position - var_151_15.position

				var_151_15.forward = Vector3.New(var_151_20.x, var_151_20.y, var_151_20.z)

				local var_151_21 = var_151_15.localEulerAngles

				var_151_21.z = 0
				var_151_21.x = 0
				var_151_15.localEulerAngles = var_151_21
			end

			if arg_148_1.time_ >= var_151_16 + var_151_17 and arg_148_1.time_ < var_151_16 + var_151_17 + arg_151_0 then
				var_151_15.localPosition = Vector3.New(0, 100, 0)

				local var_151_22 = manager.ui.mainCamera.transform.position - var_151_15.position

				var_151_15.forward = Vector3.New(var_151_22.x, var_151_22.y, var_151_22.z)

				local var_151_23 = var_151_15.localEulerAngles

				var_151_23.z = 0
				var_151_23.x = 0
				var_151_15.localEulerAngles = var_151_23
			end

			local var_151_24 = arg_148_1.actors_["10069ui_story"]
			local var_151_25 = 0

			if var_151_25 < arg_148_1.time_ and arg_148_1.time_ <= var_151_25 + arg_151_0 and not isNil(var_151_24) and arg_148_1.var_.characterEffect10069ui_story == nil then
				arg_148_1.var_.characterEffect10069ui_story = var_151_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_26 = 0.200000002980232

			if var_151_25 <= arg_148_1.time_ and arg_148_1.time_ < var_151_25 + var_151_26 and not isNil(var_151_24) then
				local var_151_27 = (arg_148_1.time_ - var_151_25) / var_151_26

				if arg_148_1.var_.characterEffect10069ui_story and not isNil(var_151_24) then
					local var_151_28 = Mathf.Lerp(0, 0.5, var_151_27)

					arg_148_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10069ui_story.fillRatio = var_151_28
				end
			end

			if arg_148_1.time_ >= var_151_25 + var_151_26 and arg_148_1.time_ < var_151_25 + var_151_26 + arg_151_0 and not isNil(var_151_24) and arg_148_1.var_.characterEffect10069ui_story then
				local var_151_29 = 0.5

				arg_148_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10069ui_story.fillRatio = var_151_29
			end

			local var_151_30 = 0
			local var_151_31 = 1.4

			if var_151_30 < arg_148_1.time_ and arg_148_1.time_ <= var_151_30 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_32 = arg_148_1:GetWordFromCfg(319451036)
				local var_151_33 = arg_148_1:FormatText(var_151_32.content)

				arg_148_1.text_.text = var_151_33

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_34 = 56
				local var_151_35 = utf8.len(var_151_33)
				local var_151_36 = var_151_34 <= 0 and var_151_31 or var_151_31 * (var_151_35 / var_151_34)

				if var_151_36 > 0 and var_151_31 < var_151_36 then
					arg_148_1.talkMaxDuration = var_151_36

					if var_151_36 + var_151_30 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_36 + var_151_30
					end
				end

				arg_148_1.text_.text = var_151_33
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_37 = math.max(var_151_31, arg_148_1.talkMaxDuration)

			if var_151_30 <= arg_148_1.time_ and arg_148_1.time_ < var_151_30 + var_151_37 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_30) / var_151_37

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_30 + var_151_37 and arg_148_1.time_ < var_151_30 + var_151_37 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play319451037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 319451037
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play319451038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.225

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[698].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:GetWordFromCfg(319451037)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 9
				local var_155_6 = utf8.len(var_155_4)
				local var_155_7 = var_155_5 <= 0 and var_155_1 or var_155_1 * (var_155_6 / var_155_5)

				if var_155_7 > 0 and var_155_1 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_8 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_8 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_8

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_8 and arg_152_1.time_ < var_155_0 + var_155_8 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play319451038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 319451038
		arg_156_1.duration_ = 4.47

		local var_156_0 = {
			zh = 4.466,
			ja = 3.433
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play319451039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1084ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos1084ui_story = var_159_0.localPosition

				local var_159_2 = "1084ui_story"

				arg_156_1:ShowWeapon(arg_156_1.var_[var_159_2 .. "Animator"].transform, false)
			end

			local var_159_3 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_3 then
				local var_159_4 = (arg_156_1.time_ - var_159_1) / var_159_3
				local var_159_5 = Vector3.New(0, -0.97, -6)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1084ui_story, var_159_5, var_159_4)

				local var_159_6 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_6.x, var_159_6.y, var_159_6.z)

				local var_159_7 = var_159_0.localEulerAngles

				var_159_7.z = 0
				var_159_7.x = 0
				var_159_0.localEulerAngles = var_159_7
			end

			if arg_156_1.time_ >= var_159_1 + var_159_3 and arg_156_1.time_ < var_159_1 + var_159_3 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_159_8 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_8.x, var_159_8.y, var_159_8.z)

				local var_159_9 = var_159_0.localEulerAngles

				var_159_9.z = 0
				var_159_9.x = 0
				var_159_0.localEulerAngles = var_159_9
			end

			local var_159_10 = arg_156_1.actors_["1084ui_story"]
			local var_159_11 = 0

			if var_159_11 < arg_156_1.time_ and arg_156_1.time_ <= var_159_11 + arg_159_0 and not isNil(var_159_10) and arg_156_1.var_.characterEffect1084ui_story == nil then
				arg_156_1.var_.characterEffect1084ui_story = var_159_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_12 = 0.200000002980232

			if var_159_11 <= arg_156_1.time_ and arg_156_1.time_ < var_159_11 + var_159_12 and not isNil(var_159_10) then
				local var_159_13 = (arg_156_1.time_ - var_159_11) / var_159_12

				if arg_156_1.var_.characterEffect1084ui_story and not isNil(var_159_10) then
					arg_156_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_11 + var_159_12 and arg_156_1.time_ < var_159_11 + var_159_12 + arg_159_0 and not isNil(var_159_10) and arg_156_1.var_.characterEffect1084ui_story then
				arg_156_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_159_14 = 0

			if var_159_14 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_159_15 = 0

			if var_159_15 < arg_156_1.time_ and arg_156_1.time_ <= var_159_15 + arg_159_0 then
				arg_156_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_159_16 = 0
			local var_159_17 = 0.4

			if var_159_16 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_18 = arg_156_1:FormatText(StoryNameCfg[6].name)

				arg_156_1.leftNameTxt_.text = var_159_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_19 = arg_156_1:GetWordFromCfg(319451038)
				local var_159_20 = arg_156_1:FormatText(var_159_19.content)

				arg_156_1.text_.text = var_159_20

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_21 = 16
				local var_159_22 = utf8.len(var_159_20)
				local var_159_23 = var_159_21 <= 0 and var_159_17 or var_159_17 * (var_159_22 / var_159_21)

				if var_159_23 > 0 and var_159_17 < var_159_23 then
					arg_156_1.talkMaxDuration = var_159_23

					if var_159_23 + var_159_16 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_23 + var_159_16
					end
				end

				arg_156_1.text_.text = var_159_20
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451038", "story_v_out_319451.awb") ~= 0 then
					local var_159_24 = manager.audio:GetVoiceLength("story_v_out_319451", "319451038", "story_v_out_319451.awb") / 1000

					if var_159_24 + var_159_16 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_24 + var_159_16
					end

					if var_159_19.prefab_name ~= "" and arg_156_1.actors_[var_159_19.prefab_name] ~= nil then
						local var_159_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_19.prefab_name].transform, "story_v_out_319451", "319451038", "story_v_out_319451.awb")

						arg_156_1:RecordAudio("319451038", var_159_25)
						arg_156_1:RecordAudio("319451038", var_159_25)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_319451", "319451038", "story_v_out_319451.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_319451", "319451038", "story_v_out_319451.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_26 = math.max(var_159_17, arg_156_1.talkMaxDuration)

			if var_159_16 <= arg_156_1.time_ and arg_156_1.time_ < var_159_16 + var_159_26 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_16) / var_159_26

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_16 + var_159_26 and arg_156_1.time_ < var_159_16 + var_159_26 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play319451039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 319451039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play319451040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1084ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1084ui_story == nil then
				arg_160_1.var_.characterEffect1084ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1084ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1084ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1084ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1084ui_story.fillRatio = var_163_5
			end

			local var_163_6 = 0
			local var_163_7 = 0.6

			if var_163_6 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_8 = arg_160_1:FormatText(StoryNameCfg[698].name)

				arg_160_1.leftNameTxt_.text = var_163_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_9 = arg_160_1:GetWordFromCfg(319451039)
				local var_163_10 = arg_160_1:FormatText(var_163_9.content)

				arg_160_1.text_.text = var_163_10

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 24
				local var_163_12 = utf8.len(var_163_10)
				local var_163_13 = var_163_11 <= 0 and var_163_7 or var_163_7 * (var_163_12 / var_163_11)

				if var_163_13 > 0 and var_163_7 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_10
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_14 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_14 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_14

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_14 and arg_160_1.time_ < var_163_6 + var_163_14 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play319451040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 319451040
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play319451041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 0.7

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[698].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_3 = arg_164_1:GetWordFromCfg(319451040)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 28
				local var_167_6 = utf8.len(var_167_4)
				local var_167_7 = var_167_5 <= 0 and var_167_1 or var_167_1 * (var_167_6 / var_167_5)

				if var_167_7 > 0 and var_167_1 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_8 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_8 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_8

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_8 and arg_164_1.time_ < var_167_0 + var_167_8 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play319451041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 319451041
		arg_168_1.duration_ = 3.33

		local var_168_0 = {
			zh = 1.8,
			ja = 3.333
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play319451042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1084ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1084ui_story == nil then
				arg_168_1.var_.characterEffect1084ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1084ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1084ui_story then
				arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_171_4 = 0
			local var_171_5 = 0.125

			if var_171_4 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_6 = arg_168_1:FormatText(StoryNameCfg[6].name)

				arg_168_1.leftNameTxt_.text = var_171_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_7 = arg_168_1:GetWordFromCfg(319451041)
				local var_171_8 = arg_168_1:FormatText(var_171_7.content)

				arg_168_1.text_.text = var_171_8

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_9 = 5
				local var_171_10 = utf8.len(var_171_8)
				local var_171_11 = var_171_9 <= 0 and var_171_5 or var_171_5 * (var_171_10 / var_171_9)

				if var_171_11 > 0 and var_171_5 < var_171_11 then
					arg_168_1.talkMaxDuration = var_171_11

					if var_171_11 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_11 + var_171_4
					end
				end

				arg_168_1.text_.text = var_171_8
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451041", "story_v_out_319451.awb") ~= 0 then
					local var_171_12 = manager.audio:GetVoiceLength("story_v_out_319451", "319451041", "story_v_out_319451.awb") / 1000

					if var_171_12 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_12 + var_171_4
					end

					if var_171_7.prefab_name ~= "" and arg_168_1.actors_[var_171_7.prefab_name] ~= nil then
						local var_171_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_7.prefab_name].transform, "story_v_out_319451", "319451041", "story_v_out_319451.awb")

						arg_168_1:RecordAudio("319451041", var_171_13)
						arg_168_1:RecordAudio("319451041", var_171_13)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_319451", "319451041", "story_v_out_319451.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_319451", "319451041", "story_v_out_319451.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_14 = math.max(var_171_5, arg_168_1.talkMaxDuration)

			if var_171_4 <= arg_168_1.time_ and arg_168_1.time_ < var_171_4 + var_171_14 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_4) / var_171_14

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_4 + var_171_14 and arg_168_1.time_ < var_171_4 + var_171_14 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play319451042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 319451042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play319451043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1084ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1084ui_story == nil then
				arg_172_1.var_.characterEffect1084ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1084ui_story and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1084ui_story.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1084ui_story then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1084ui_story.fillRatio = var_175_5
			end

			local var_175_6 = 0
			local var_175_7 = 1.05

			if var_175_6 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_8 = arg_172_1:FormatText(StoryNameCfg[698].name)

				arg_172_1.leftNameTxt_.text = var_175_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_9 = arg_172_1:GetWordFromCfg(319451042)
				local var_175_10 = arg_172_1:FormatText(var_175_9.content)

				arg_172_1.text_.text = var_175_10

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_11 = 42
				local var_175_12 = utf8.len(var_175_10)
				local var_175_13 = var_175_11 <= 0 and var_175_7 or var_175_7 * (var_175_12 / var_175_11)

				if var_175_13 > 0 and var_175_7 < var_175_13 then
					arg_172_1.talkMaxDuration = var_175_13

					if var_175_13 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_13 + var_175_6
					end
				end

				arg_172_1.text_.text = var_175_10
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_14 = math.max(var_175_7, arg_172_1.talkMaxDuration)

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_14 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_6) / var_175_14

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_6 + var_175_14 and arg_172_1.time_ < var_175_6 + var_175_14 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play319451043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 319451043
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play319451044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0
			local var_179_1 = 0.375

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_2 = arg_176_1:FormatText(StoryNameCfg[698].name)

				arg_176_1.leftNameTxt_.text = var_179_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_3 = arg_176_1:GetWordFromCfg(319451043)
				local var_179_4 = arg_176_1:FormatText(var_179_3.content)

				arg_176_1.text_.text = var_179_4

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 15
				local var_179_6 = utf8.len(var_179_4)
				local var_179_7 = var_179_5 <= 0 and var_179_1 or var_179_1 * (var_179_6 / var_179_5)

				if var_179_7 > 0 and var_179_1 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_0
					end
				end

				arg_176_1.text_.text = var_179_4
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_8 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_8 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_8

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_8 and arg_176_1.time_ < var_179_0 + var_179_8 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play319451044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 319451044
		arg_180_1.duration_ = 5.78

		local var_180_0 = {
			zh = 3.075,
			ja = 5.775
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play319451045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1084ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1084ui_story == nil then
				arg_180_1.var_.characterEffect1084ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1084ui_story and not isNil(var_183_0) then
					arg_180_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1084ui_story then
				arg_180_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_183_4 = 0

			if var_183_4 < arg_180_1.time_ and arg_180_1.time_ <= var_183_4 + arg_183_0 then
				arg_180_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_183_5 = 0

			if var_183_5 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 then
				arg_180_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_183_6 = 0.875
			local var_183_7 = 0.125

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_8 = arg_180_1:FormatText(StoryNameCfg[6].name)

				arg_180_1.leftNameTxt_.text = var_183_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_9 = arg_180_1:GetWordFromCfg(319451044)
				local var_183_10 = arg_180_1:FormatText(var_183_9.content)

				arg_180_1.text_.text = var_183_10

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 5
				local var_183_12 = utf8.len(var_183_10)
				local var_183_13 = var_183_11 <= 0 and var_183_7 or var_183_7 * (var_183_12 / var_183_11)

				if var_183_13 > 0 and var_183_7 < var_183_13 then
					arg_180_1.talkMaxDuration = var_183_13

					if var_183_13 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_13 + var_183_6
					end
				end

				arg_180_1.text_.text = var_183_10
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451044", "story_v_out_319451.awb") ~= 0 then
					local var_183_14 = manager.audio:GetVoiceLength("story_v_out_319451", "319451044", "story_v_out_319451.awb") / 1000

					if var_183_14 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_14 + var_183_6
					end

					if var_183_9.prefab_name ~= "" and arg_180_1.actors_[var_183_9.prefab_name] ~= nil then
						local var_183_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_9.prefab_name].transform, "story_v_out_319451", "319451044", "story_v_out_319451.awb")

						arg_180_1:RecordAudio("319451044", var_183_15)
						arg_180_1:RecordAudio("319451044", var_183_15)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_319451", "319451044", "story_v_out_319451.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_319451", "319451044", "story_v_out_319451.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_16 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_16 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_16

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_16 and arg_180_1.time_ < var_183_6 + var_183_16 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play319451045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 319451045
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play319451046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1084ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1084ui_story == nil then
				arg_184_1.var_.characterEffect1084ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1084ui_story and not isNil(var_187_0) then
					local var_187_4 = Mathf.Lerp(0, 0.5, var_187_3)

					arg_184_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1084ui_story.fillRatio = var_187_4
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1084ui_story then
				local var_187_5 = 0.5

				arg_184_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1084ui_story.fillRatio = var_187_5
			end

			local var_187_6 = 0
			local var_187_7 = 0.15

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_8 = arg_184_1:FormatText(StoryNameCfg[698].name)

				arg_184_1.leftNameTxt_.text = var_187_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_9 = arg_184_1:GetWordFromCfg(319451045)
				local var_187_10 = arg_184_1:FormatText(var_187_9.content)

				arg_184_1.text_.text = var_187_10

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_11 = 6
				local var_187_12 = utf8.len(var_187_10)
				local var_187_13 = var_187_11 <= 0 and var_187_7 or var_187_7 * (var_187_12 / var_187_11)

				if var_187_13 > 0 and var_187_7 < var_187_13 then
					arg_184_1.talkMaxDuration = var_187_13

					if var_187_13 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_6
					end
				end

				arg_184_1.text_.text = var_187_10
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_14 = math.max(var_187_7, arg_184_1.talkMaxDuration)

			if var_187_6 <= arg_184_1.time_ and arg_184_1.time_ < var_187_6 + var_187_14 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_6) / var_187_14

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_6 + var_187_14 and arg_184_1.time_ < var_187_6 + var_187_14 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play319451046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 319451046
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play319451047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1084ui_story"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos1084ui_story = var_191_0.localPosition
			end

			local var_191_2 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2
				local var_191_4 = Vector3.New(0, 100, 0)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1084ui_story, var_191_4, var_191_3)

				local var_191_5 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_5.x, var_191_5.y, var_191_5.z)

				local var_191_6 = var_191_0.localEulerAngles

				var_191_6.z = 0
				var_191_6.x = 0
				var_191_0.localEulerAngles = var_191_6
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(0, 100, 0)

				local var_191_7 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_7.x, var_191_7.y, var_191_7.z)

				local var_191_8 = var_191_0.localEulerAngles

				var_191_8.z = 0
				var_191_8.x = 0
				var_191_0.localEulerAngles = var_191_8
			end

			local var_191_9 = 0
			local var_191_10 = 0.875

			if var_191_9 < arg_188_1.time_ and arg_188_1.time_ <= var_191_9 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_11 = arg_188_1:GetWordFromCfg(319451046)
				local var_191_12 = arg_188_1:FormatText(var_191_11.content)

				arg_188_1.text_.text = var_191_12

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_13 = 35
				local var_191_14 = utf8.len(var_191_12)
				local var_191_15 = var_191_13 <= 0 and var_191_10 or var_191_10 * (var_191_14 / var_191_13)

				if var_191_15 > 0 and var_191_10 < var_191_15 then
					arg_188_1.talkMaxDuration = var_191_15

					if var_191_15 + var_191_9 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_15 + var_191_9
					end
				end

				arg_188_1.text_.text = var_191_12
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_16 = math.max(var_191_10, arg_188_1.talkMaxDuration)

			if var_191_9 <= arg_188_1.time_ and arg_188_1.time_ < var_191_9 + var_191_16 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_9) / var_191_16

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_9 + var_191_16 and arg_188_1.time_ < var_191_9 + var_191_16 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play319451047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 319451047
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play319451048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 1.25

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_2 = arg_192_1:GetWordFromCfg(319451047)
				local var_195_3 = arg_192_1:FormatText(var_195_2.content)

				arg_192_1.text_.text = var_195_3

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_4 = 50
				local var_195_5 = utf8.len(var_195_3)
				local var_195_6 = var_195_4 <= 0 and var_195_1 or var_195_1 * (var_195_5 / var_195_4)

				if var_195_6 > 0 and var_195_1 < var_195_6 then
					arg_192_1.talkMaxDuration = var_195_6

					if var_195_6 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_6 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_3
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_7 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_7 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_7

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_7 and arg_192_1.time_ < var_195_0 + var_195_7 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play319451048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 319451048
		arg_196_1.duration_ = 8.6

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play319451049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1084ui_story"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos1084ui_story = var_199_0.localPosition
			end

			local var_199_2 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2
				local var_199_4 = Vector3.New(0, 100, 0)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1084ui_story, var_199_4, var_199_3)

				local var_199_5 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_5.x, var_199_5.y, var_199_5.z)

				local var_199_6 = var_199_0.localEulerAngles

				var_199_6.z = 0
				var_199_6.x = 0
				var_199_0.localEulerAngles = var_199_6
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0, 100, 0)

				local var_199_7 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_7.x, var_199_7.y, var_199_7.z)

				local var_199_8 = var_199_0.localEulerAngles

				var_199_8.z = 0
				var_199_8.x = 0
				var_199_0.localEulerAngles = var_199_8
			end

			local var_199_9 = "STblack"

			if arg_196_1.bgs_[var_199_9] == nil then
				local var_199_10 = Object.Instantiate(arg_196_1.paintGo_)

				var_199_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_199_9)
				var_199_10.name = var_199_9
				var_199_10.transform.parent = arg_196_1.stage_.transform
				var_199_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_196_1.bgs_[var_199_9] = var_199_10
			end

			local var_199_11 = 0

			if var_199_11 < arg_196_1.time_ and arg_196_1.time_ <= var_199_11 + arg_199_0 then
				local var_199_12 = manager.ui.mainCamera.transform.localPosition
				local var_199_13 = Vector3.New(0, 0, 10) + Vector3.New(var_199_12.x, var_199_12.y, 0)
				local var_199_14 = arg_196_1.bgs_.STblack

				var_199_14.transform.localPosition = var_199_13
				var_199_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_199_15 = var_199_14:GetComponent("SpriteRenderer")

				if var_199_15 and var_199_15.sprite then
					local var_199_16 = (var_199_14.transform.localPosition - var_199_12).z
					local var_199_17 = manager.ui.mainCameraCom_
					local var_199_18 = 2 * var_199_16 * Mathf.Tan(var_199_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_199_19 = var_199_18 * var_199_17.aspect
					local var_199_20 = var_199_15.sprite.bounds.size.x
					local var_199_21 = var_199_15.sprite.bounds.size.y
					local var_199_22 = var_199_19 / var_199_20
					local var_199_23 = var_199_18 / var_199_21
					local var_199_24 = var_199_23 < var_199_22 and var_199_22 or var_199_23

					var_199_14.transform.localScale = Vector3.New(var_199_24, var_199_24, 0)
				end

				for iter_199_0, iter_199_1 in pairs(arg_196_1.bgs_) do
					if iter_199_0 ~= "STblack" then
						iter_199_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_199_25 = 0

			if var_199_25 < arg_196_1.time_ and arg_196_1.time_ <= var_199_25 + arg_199_0 then
				local var_199_26 = arg_196_1.fswbg_.transform:Find("textbox/adapt/content") or arg_196_1.fswbg_.transform:Find("textbox/content")
				local var_199_27 = arg_196_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_199_28 = var_199_26:GetComponent("Text")
				local var_199_29 = var_199_26:GetComponent("RectTransform")

				var_199_28.alignment = UnityEngine.TextAnchor.LowerCenter
				var_199_29.offsetMin = Vector2.New(0, 0)
				var_199_29.offsetMax = Vector2.New(0, 0)
			end

			local var_199_30 = 0

			if var_199_30 < arg_196_1.time_ and arg_196_1.time_ <= var_199_30 + arg_199_0 then
				arg_196_1.fswbg_:SetActive(true)
				arg_196_1.dialog_:SetActive(false)

				arg_196_1.fswtw_.percent = 0

				local var_199_31 = arg_196_1:GetWordFromCfg(319451048)
				local var_199_32 = arg_196_1:FormatText(var_199_31.content)

				arg_196_1.fswt_.text = var_199_32

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.fswt_)

				arg_196_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_196_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_196_1.fswtw_:SetDirty()

				arg_196_1.typewritterCharCountI18N = 0

				SetActive(arg_196_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_196_1:ShowNextGo(false)
			end

			local var_199_33 = 0.333333333333333

			if var_199_33 < arg_196_1.time_ and arg_196_1.time_ <= var_199_33 + arg_199_0 then
				arg_196_1.var_.oldValueTypewriter = arg_196_1.fswtw_.percent

				SetActive(arg_196_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_196_1:ShowNextGo(false)
			end

			local var_199_34 = 36
			local var_199_35 = 2.4
			local var_199_36 = arg_196_1:GetWordFromCfg(319451048)
			local var_199_37 = arg_196_1:FormatText(var_199_36.content)
			local var_199_38, var_199_39 = arg_196_1:GetPercentByPara(var_199_37, 1)

			if var_199_33 < arg_196_1.time_ and arg_196_1.time_ <= var_199_33 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0

				local var_199_40 = var_199_34 <= 0 and var_199_35 or var_199_35 * ((var_199_39 - arg_196_1.typewritterCharCountI18N) / var_199_34)

				if var_199_40 > 0 and var_199_35 < var_199_40 then
					arg_196_1.talkMaxDuration = var_199_40

					if var_199_40 + var_199_33 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_40 + var_199_33
					end
				end
			end

			local var_199_41 = 2.4
			local var_199_42 = math.max(var_199_41, arg_196_1.talkMaxDuration)

			if var_199_33 <= arg_196_1.time_ and arg_196_1.time_ < var_199_33 + var_199_42 then
				local var_199_43 = (arg_196_1.time_ - var_199_33) / var_199_42

				arg_196_1.fswtw_.percent = Mathf.Lerp(arg_196_1.var_.oldValueTypewriter, var_199_38, var_199_43)
				arg_196_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_196_1.fswtw_:SetDirty()
			end

			if arg_196_1.time_ >= var_199_33 + var_199_42 and arg_196_1.time_ < var_199_33 + var_199_42 + arg_199_0 then
				arg_196_1.fswtw_.percent = var_199_38

				arg_196_1.fswtw_:SetDirty()
				arg_196_1:ShowNextGo(true)

				arg_196_1.typewritterCharCountI18N = var_199_39
			end

			local var_199_44 = 0

			if var_199_44 < arg_196_1.time_ and arg_196_1.time_ <= var_199_44 + arg_199_0 then
				arg_196_1.cswbg_:SetActive(true)

				local var_199_45 = arg_196_1.cswt_:GetComponent("RectTransform")

				arg_196_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_199_45.offsetMin = Vector2.New(410, 330)
				var_199_45.offsetMax = Vector2.New(-400, -175)

				local var_199_46 = arg_196_1:GetWordFromCfg(419021)
				local var_199_47 = arg_196_1:FormatText(var_199_46.content)

				arg_196_1.cswt_.text = var_199_47

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.cswt_)

				arg_196_1.cswt_.fontSize = 180
				arg_196_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_196_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_196_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_199_48 = 0.333333333333333
			local var_199_49 = 8.266
			local var_199_50 = manager.audio:GetVoiceLength("story_v_out_319451", "319451048", "story_v_out_319451.awb") / 1000

			if var_199_50 > 0 and var_199_49 < var_199_50 and var_199_50 + var_199_48 > arg_196_1.duration_ then
				local var_199_51 = var_199_50

				arg_196_1.duration_ = var_199_50 + var_199_48
			end

			if var_199_48 < arg_196_1.time_ and arg_196_1.time_ <= var_199_48 + arg_199_0 then
				local var_199_52 = "play"
				local var_199_53 = "voice"

				arg_196_1:AudioAction(var_199_52, var_199_53, "story_v_out_319451", "319451048", "story_v_out_319451.awb")
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play319451049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 319451049
		arg_200_1.duration_ = 8.83

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play319451050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.fswbg_:SetActive(true)
				arg_200_1.dialog_:SetActive(false)

				arg_200_1.fswtw_.percent = 0

				local var_203_1 = arg_200_1:GetWordFromCfg(319451049)
				local var_203_2 = arg_200_1:FormatText(var_203_1.content)

				arg_200_1.fswt_.text = var_203_2

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.fswt_)

				arg_200_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_200_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_200_1.fswtw_:SetDirty()

				arg_200_1.typewritterCharCountI18N = 0

				SetActive(arg_200_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_200_1:ShowNextGo(false)
			end

			local var_203_3 = 0.2

			if var_203_3 < arg_200_1.time_ and arg_200_1.time_ <= var_203_3 + arg_203_0 then
				arg_200_1.var_.oldValueTypewriter = arg_200_1.fswtw_.percent

				SetActive(arg_200_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_200_1:ShowNextGo(false)
			end

			local var_203_4 = 35
			local var_203_5 = 2.33333333333333
			local var_203_6 = arg_200_1:GetWordFromCfg(319451049)
			local var_203_7 = arg_200_1:FormatText(var_203_6.content)
			local var_203_8, var_203_9 = arg_200_1:GetPercentByPara(var_203_7, 1)

			if var_203_3 < arg_200_1.time_ and arg_200_1.time_ <= var_203_3 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0

				local var_203_10 = var_203_4 <= 0 and var_203_5 or var_203_5 * ((var_203_9 - arg_200_1.typewritterCharCountI18N) / var_203_4)

				if var_203_10 > 0 and var_203_5 < var_203_10 then
					arg_200_1.talkMaxDuration = var_203_10

					if var_203_10 + var_203_3 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_3
					end
				end
			end

			local var_203_11 = 2.33333333333333
			local var_203_12 = math.max(var_203_11, arg_200_1.talkMaxDuration)

			if var_203_3 <= arg_200_1.time_ and arg_200_1.time_ < var_203_3 + var_203_12 then
				local var_203_13 = (arg_200_1.time_ - var_203_3) / var_203_12

				arg_200_1.fswtw_.percent = Mathf.Lerp(arg_200_1.var_.oldValueTypewriter, var_203_8, var_203_13)
				arg_200_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_200_1.fswtw_:SetDirty()
			end

			if arg_200_1.time_ >= var_203_3 + var_203_12 and arg_200_1.time_ < var_203_3 + var_203_12 + arg_203_0 then
				arg_200_1.fswtw_.percent = var_203_8

				arg_200_1.fswtw_:SetDirty()
				arg_200_1:ShowNextGo(true)

				arg_200_1.typewritterCharCountI18N = var_203_9
			end

			local var_203_14 = 0.2
			local var_203_15 = 8.633
			local var_203_16 = manager.audio:GetVoiceLength("story_v_out_319451", "319451049", "story_v_out_319451.awb") / 1000

			if var_203_16 > 0 and var_203_15 < var_203_16 and var_203_16 + var_203_14 > arg_200_1.duration_ then
				local var_203_17 = var_203_16

				arg_200_1.duration_ = var_203_16 + var_203_14
			end

			if var_203_14 < arg_200_1.time_ and arg_200_1.time_ <= var_203_14 + arg_203_0 then
				local var_203_18 = "play"
				local var_203_19 = "voice"

				arg_200_1:AudioAction(var_203_18, var_203_19, "story_v_out_319451", "319451049", "story_v_out_319451.awb")
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play319451050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 319451050
		arg_204_1.duration_ = 6.1

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play319451051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				local var_207_1 = manager.ui.mainCamera.transform.localPosition
				local var_207_2 = Vector3.New(0, 0, 10) + Vector3.New(var_207_1.x, var_207_1.y, 0)
				local var_207_3 = arg_204_1.bgs_.ST07a

				var_207_3.transform.localPosition = var_207_2
				var_207_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_207_4 = var_207_3:GetComponent("SpriteRenderer")

				if var_207_4 and var_207_4.sprite then
					local var_207_5 = (var_207_3.transform.localPosition - var_207_1).z
					local var_207_6 = manager.ui.mainCameraCom_
					local var_207_7 = 2 * var_207_5 * Mathf.Tan(var_207_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_207_8 = var_207_7 * var_207_6.aspect
					local var_207_9 = var_207_4.sprite.bounds.size.x
					local var_207_10 = var_207_4.sprite.bounds.size.y
					local var_207_11 = var_207_8 / var_207_9
					local var_207_12 = var_207_7 / var_207_10
					local var_207_13 = var_207_12 < var_207_11 and var_207_11 or var_207_12

					var_207_3.transform.localScale = Vector3.New(var_207_13, var_207_13, 0)
				end

				for iter_207_0, iter_207_1 in pairs(arg_204_1.bgs_) do
					if iter_207_0 ~= "ST07a" then
						iter_207_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_207_14 = arg_204_1.actors_["1084ui_story"]
			local var_207_15 = 0

			if var_207_15 < arg_204_1.time_ and arg_204_1.time_ <= var_207_15 + arg_207_0 and not isNil(var_207_14) and arg_204_1.var_.characterEffect1084ui_story == nil then
				arg_204_1.var_.characterEffect1084ui_story = var_207_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_16 = 0.200000002980232

			if var_207_15 <= arg_204_1.time_ and arg_204_1.time_ < var_207_15 + var_207_16 and not isNil(var_207_14) then
				local var_207_17 = (arg_204_1.time_ - var_207_15) / var_207_16

				if arg_204_1.var_.characterEffect1084ui_story and not isNil(var_207_14) then
					local var_207_18 = Mathf.Lerp(0, 0.5, var_207_17)

					arg_204_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1084ui_story.fillRatio = var_207_18
				end
			end

			if arg_204_1.time_ >= var_207_15 + var_207_16 and arg_204_1.time_ < var_207_15 + var_207_16 + arg_207_0 and not isNil(var_207_14) and arg_204_1.var_.characterEffect1084ui_story then
				local var_207_19 = 0.5

				arg_204_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1084ui_story.fillRatio = var_207_19
			end

			local var_207_20 = 0

			if var_207_20 < arg_204_1.time_ and arg_204_1.time_ <= var_207_20 + arg_207_0 then
				arg_204_1.fswbg_:SetActive(false)
				arg_204_1.dialog_:SetActive(false)
				SetActive(arg_204_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_204_1:ShowNextGo(false)
			end

			local var_207_21 = 0

			if var_207_21 < arg_204_1.time_ and arg_204_1.time_ <= var_207_21 + arg_207_0 then
				arg_204_1.cswbg_:SetActive(false)
			end

			if arg_204_1.frameCnt_ <= 1 then
				arg_204_1.dialog_:SetActive(false)
			end

			local var_207_22 = 1.1
			local var_207_23 = 0.2

			if var_207_22 < arg_204_1.time_ and arg_204_1.time_ <= var_207_22 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0

				arg_204_1.dialog_:SetActive(true)

				arg_204_1.dialogCg_.alpha = 0

				local var_207_24 = LeanTween.value(arg_204_1.dialog_, 0, 1, 0.3)

				var_207_24:setOnUpdate(LuaHelper.FloatAction(function(arg_208_0)
					arg_204_1.dialogCg_.alpha = arg_208_0
				end))
				var_207_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_204_1.dialog_)
					var_207_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_204_1.duration_ = arg_204_1.duration_ + 0.3

				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_25 = arg_204_1:FormatText(StoryNameCfg[698].name)

				arg_204_1.leftNameTxt_.text = var_207_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_26 = arg_204_1:GetWordFromCfg(319451050)
				local var_207_27 = arg_204_1:FormatText(var_207_26.content)

				arg_204_1.text_.text = var_207_27

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_28 = 8
				local var_207_29 = utf8.len(var_207_27)
				local var_207_30 = var_207_28 <= 0 and var_207_23 or var_207_23 * (var_207_29 / var_207_28)

				if var_207_30 > 0 and var_207_23 < var_207_30 then
					arg_204_1.talkMaxDuration = var_207_30
					var_207_22 = var_207_22 + 0.3

					if var_207_30 + var_207_22 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_30 + var_207_22
					end
				end

				arg_204_1.text_.text = var_207_27
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_31 = var_207_22 + 0.3
			local var_207_32 = math.max(var_207_23, arg_204_1.talkMaxDuration)

			if var_207_31 <= arg_204_1.time_ and arg_204_1.time_ < var_207_31 + var_207_32 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_31) / var_207_32

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_31 + var_207_32 and arg_204_1.time_ < var_207_31 + var_207_32 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play319451051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 319451051
		arg_210_1.duration_ = 18.7

		local var_210_0 = {
			zh = 11.333,
			ja = 18.7
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
				arg_210_0:Play319451052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1084ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1084ui_story == nil then
				arg_210_1.var_.characterEffect1084ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect1084ui_story and not isNil(var_213_0) then
					arg_210_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1084ui_story then
				arg_210_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_213_4 = arg_210_1.actors_["1084ui_story"].transform
			local var_213_5 = 0

			if var_213_5 < arg_210_1.time_ and arg_210_1.time_ <= var_213_5 + arg_213_0 then
				arg_210_1.var_.moveOldPos1084ui_story = var_213_4.localPosition
			end

			local var_213_6 = 0.001

			if var_213_5 <= arg_210_1.time_ and arg_210_1.time_ < var_213_5 + var_213_6 then
				local var_213_7 = (arg_210_1.time_ - var_213_5) / var_213_6
				local var_213_8 = Vector3.New(0, -0.97, -6)

				var_213_4.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1084ui_story, var_213_8, var_213_7)

				local var_213_9 = manager.ui.mainCamera.transform.position - var_213_4.position

				var_213_4.forward = Vector3.New(var_213_9.x, var_213_9.y, var_213_9.z)

				local var_213_10 = var_213_4.localEulerAngles

				var_213_10.z = 0
				var_213_10.x = 0
				var_213_4.localEulerAngles = var_213_10
			end

			if arg_210_1.time_ >= var_213_5 + var_213_6 and arg_210_1.time_ < var_213_5 + var_213_6 + arg_213_0 then
				var_213_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_213_11 = manager.ui.mainCamera.transform.position - var_213_4.position

				var_213_4.forward = Vector3.New(var_213_11.x, var_213_11.y, var_213_11.z)

				local var_213_12 = var_213_4.localEulerAngles

				var_213_12.z = 0
				var_213_12.x = 0
				var_213_4.localEulerAngles = var_213_12
			end

			local var_213_13 = 0

			if var_213_13 < arg_210_1.time_ and arg_210_1.time_ <= var_213_13 + arg_213_0 then
				arg_210_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_213_14 = 0

			if var_213_14 < arg_210_1.time_ and arg_210_1.time_ <= var_213_14 + arg_213_0 then
				arg_210_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_213_15 = 0
			local var_213_16 = 0.95

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

				local var_213_18 = arg_210_1:GetWordFromCfg(319451051)
				local var_213_19 = arg_210_1:FormatText(var_213_18.content)

				arg_210_1.text_.text = var_213_19

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_20 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451051", "story_v_out_319451.awb") ~= 0 then
					local var_213_23 = manager.audio:GetVoiceLength("story_v_out_319451", "319451051", "story_v_out_319451.awb") / 1000

					if var_213_23 + var_213_15 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_23 + var_213_15
					end

					if var_213_18.prefab_name ~= "" and arg_210_1.actors_[var_213_18.prefab_name] ~= nil then
						local var_213_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_18.prefab_name].transform, "story_v_out_319451", "319451051", "story_v_out_319451.awb")

						arg_210_1:RecordAudio("319451051", var_213_24)
						arg_210_1:RecordAudio("319451051", var_213_24)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_319451", "319451051", "story_v_out_319451.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_319451", "319451051", "story_v_out_319451.awb")
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play319451052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 319451052
		arg_214_1.duration_ = 7

		local var_214_0 = {
			zh = 4.033,
			ja = 7
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play319451053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_217_1 = 0
			local var_217_2 = 0.475

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_3 = arg_214_1:FormatText(StoryNameCfg[6].name)

				arg_214_1.leftNameTxt_.text = var_217_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_4 = arg_214_1:GetWordFromCfg(319451052)
				local var_217_5 = arg_214_1:FormatText(var_217_4.content)

				arg_214_1.text_.text = var_217_5

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_6 = 19
				local var_217_7 = utf8.len(var_217_5)
				local var_217_8 = var_217_6 <= 0 and var_217_2 or var_217_2 * (var_217_7 / var_217_6)

				if var_217_8 > 0 and var_217_2 < var_217_8 then
					arg_214_1.talkMaxDuration = var_217_8

					if var_217_8 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_5
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451052", "story_v_out_319451.awb") ~= 0 then
					local var_217_9 = manager.audio:GetVoiceLength("story_v_out_319451", "319451052", "story_v_out_319451.awb") / 1000

					if var_217_9 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_9 + var_217_1
					end

					if var_217_4.prefab_name ~= "" and arg_214_1.actors_[var_217_4.prefab_name] ~= nil then
						local var_217_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_4.prefab_name].transform, "story_v_out_319451", "319451052", "story_v_out_319451.awb")

						arg_214_1:RecordAudio("319451052", var_217_10)
						arg_214_1:RecordAudio("319451052", var_217_10)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_319451", "319451052", "story_v_out_319451.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_319451", "319451052", "story_v_out_319451.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_11 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_11 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_11

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_11 and arg_214_1.time_ < var_217_1 + var_217_11 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play319451053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 319451053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play319451054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1084ui_story"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1084ui_story == nil then
				arg_218_1.var_.characterEffect1084ui_story = var_221_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.characterEffect1084ui_story and not isNil(var_221_0) then
					local var_221_4 = Mathf.Lerp(0, 0.5, var_221_3)

					arg_218_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1084ui_story.fillRatio = var_221_4
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1084ui_story then
				local var_221_5 = 0.5

				arg_218_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1084ui_story.fillRatio = var_221_5
			end

			local var_221_6 = 0
			local var_221_7 = 0.525

			if var_221_6 < arg_218_1.time_ and arg_218_1.time_ <= var_221_6 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_8 = arg_218_1:GetWordFromCfg(319451053)
				local var_221_9 = arg_218_1:FormatText(var_221_8.content)

				arg_218_1.text_.text = var_221_9

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_10 = 21
				local var_221_11 = utf8.len(var_221_9)
				local var_221_12 = var_221_10 <= 0 and var_221_7 or var_221_7 * (var_221_11 / var_221_10)

				if var_221_12 > 0 and var_221_7 < var_221_12 then
					arg_218_1.talkMaxDuration = var_221_12

					if var_221_12 + var_221_6 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_12 + var_221_6
					end
				end

				arg_218_1.text_.text = var_221_9
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_13 = math.max(var_221_7, arg_218_1.talkMaxDuration)

			if var_221_6 <= arg_218_1.time_ and arg_218_1.time_ < var_221_6 + var_221_13 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_6) / var_221_13

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_6 + var_221_13 and arg_218_1.time_ < var_221_6 + var_221_13 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play319451054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 319451054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play319451055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 0.125

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_2 = arg_222_1:FormatText(StoryNameCfg[698].name)

				arg_222_1.leftNameTxt_.text = var_225_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_3 = arg_222_1:GetWordFromCfg(319451054)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 5
				local var_225_6 = utf8.len(var_225_4)
				local var_225_7 = var_225_5 <= 0 and var_225_1 or var_225_1 * (var_225_6 / var_225_5)

				if var_225_7 > 0 and var_225_1 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_4
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_8 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_8 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_8

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_8 and arg_222_1.time_ < var_225_0 + var_225_8 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play319451055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 319451055
		arg_226_1.duration_ = 2

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play319451056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1084ui_story"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1084ui_story == nil then
				arg_226_1.var_.characterEffect1084ui_story = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect1084ui_story and not isNil(var_229_0) then
					arg_226_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1084ui_story then
				arg_226_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_229_4 = 0

			if var_229_4 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_229_5 = 0
			local var_229_6 = 0.15

			if var_229_5 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_7 = arg_226_1:FormatText(StoryNameCfg[6].name)

				arg_226_1.leftNameTxt_.text = var_229_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_8 = arg_226_1:GetWordFromCfg(319451055)
				local var_229_9 = arg_226_1:FormatText(var_229_8.content)

				arg_226_1.text_.text = var_229_9

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_10 = 6
				local var_229_11 = utf8.len(var_229_9)
				local var_229_12 = var_229_10 <= 0 and var_229_6 or var_229_6 * (var_229_11 / var_229_10)

				if var_229_12 > 0 and var_229_6 < var_229_12 then
					arg_226_1.talkMaxDuration = var_229_12

					if var_229_12 + var_229_5 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_12 + var_229_5
					end
				end

				arg_226_1.text_.text = var_229_9
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451055", "story_v_out_319451.awb") ~= 0 then
					local var_229_13 = manager.audio:GetVoiceLength("story_v_out_319451", "319451055", "story_v_out_319451.awb") / 1000

					if var_229_13 + var_229_5 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_5
					end

					if var_229_8.prefab_name ~= "" and arg_226_1.actors_[var_229_8.prefab_name] ~= nil then
						local var_229_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_8.prefab_name].transform, "story_v_out_319451", "319451055", "story_v_out_319451.awb")

						arg_226_1:RecordAudio("319451055", var_229_14)
						arg_226_1:RecordAudio("319451055", var_229_14)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_319451", "319451055", "story_v_out_319451.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_319451", "319451055", "story_v_out_319451.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_15 = math.max(var_229_6, arg_226_1.talkMaxDuration)

			if var_229_5 <= arg_226_1.time_ and arg_226_1.time_ < var_229_5 + var_229_15 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_5) / var_229_15

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_5 + var_229_15 and arg_226_1.time_ < var_229_5 + var_229_15 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play319451056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 319451056
		arg_230_1.duration_ = 8.6

		local var_230_0 = {
			zh = 6.366,
			ja = 8.6
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
				arg_230_0:Play319451057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = "ST71"

			if arg_230_1.bgs_[var_233_0] == nil then
				local var_233_1 = Object.Instantiate(arg_230_1.paintGo_)

				var_233_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_233_0)
				var_233_1.name = var_233_0
				var_233_1.transform.parent = arg_230_1.stage_.transform
				var_233_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_230_1.bgs_[var_233_0] = var_233_1
			end

			local var_233_2 = 2

			if var_233_2 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				local var_233_3 = manager.ui.mainCamera.transform.localPosition
				local var_233_4 = Vector3.New(0, 0, 10) + Vector3.New(var_233_3.x, var_233_3.y, 0)
				local var_233_5 = arg_230_1.bgs_.ST71

				var_233_5.transform.localPosition = var_233_4
				var_233_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_233_6 = var_233_5:GetComponent("SpriteRenderer")

				if var_233_6 and var_233_6.sprite then
					local var_233_7 = (var_233_5.transform.localPosition - var_233_3).z
					local var_233_8 = manager.ui.mainCameraCom_
					local var_233_9 = 2 * var_233_7 * Mathf.Tan(var_233_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_233_10 = var_233_9 * var_233_8.aspect
					local var_233_11 = var_233_6.sprite.bounds.size.x
					local var_233_12 = var_233_6.sprite.bounds.size.y
					local var_233_13 = var_233_10 / var_233_11
					local var_233_14 = var_233_9 / var_233_12
					local var_233_15 = var_233_14 < var_233_13 and var_233_13 or var_233_14

					var_233_5.transform.localScale = Vector3.New(var_233_15, var_233_15, 0)
				end

				for iter_233_0, iter_233_1 in pairs(arg_230_1.bgs_) do
					if iter_233_0 ~= "ST71" then
						iter_233_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_233_16 = 0

			if var_233_16 < arg_230_1.time_ and arg_230_1.time_ <= var_233_16 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_17 = 2

			if var_233_16 <= arg_230_1.time_ and arg_230_1.time_ < var_233_16 + var_233_17 then
				local var_233_18 = (arg_230_1.time_ - var_233_16) / var_233_17
				local var_233_19 = Color.New(0, 0, 0)

				var_233_19.a = Mathf.Lerp(0, 1, var_233_18)
				arg_230_1.mask_.color = var_233_19
			end

			if arg_230_1.time_ >= var_233_16 + var_233_17 and arg_230_1.time_ < var_233_16 + var_233_17 + arg_233_0 then
				local var_233_20 = Color.New(0, 0, 0)

				var_233_20.a = 1
				arg_230_1.mask_.color = var_233_20
			end

			local var_233_21 = 2

			if var_233_21 < arg_230_1.time_ and arg_230_1.time_ <= var_233_21 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_22 = 2

			if var_233_21 <= arg_230_1.time_ and arg_230_1.time_ < var_233_21 + var_233_22 then
				local var_233_23 = (arg_230_1.time_ - var_233_21) / var_233_22
				local var_233_24 = Color.New(0, 0, 0)

				var_233_24.a = Mathf.Lerp(1, 0, var_233_23)
				arg_230_1.mask_.color = var_233_24
			end

			if arg_230_1.time_ >= var_233_21 + var_233_22 and arg_230_1.time_ < var_233_21 + var_233_22 + arg_233_0 then
				local var_233_25 = Color.New(0, 0, 0)
				local var_233_26 = 0

				arg_230_1.mask_.enabled = false
				var_233_25.a = var_233_26
				arg_230_1.mask_.color = var_233_25
			end

			local var_233_27 = arg_230_1.actors_["1084ui_story"].transform
			local var_233_28 = 2

			if var_233_28 < arg_230_1.time_ and arg_230_1.time_ <= var_233_28 + arg_233_0 then
				arg_230_1.var_.moveOldPos1084ui_story = var_233_27.localPosition
			end

			local var_233_29 = 0.001

			if var_233_28 <= arg_230_1.time_ and arg_230_1.time_ < var_233_28 + var_233_29 then
				local var_233_30 = (arg_230_1.time_ - var_233_28) / var_233_29
				local var_233_31 = Vector3.New(0, 100, 0)

				var_233_27.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1084ui_story, var_233_31, var_233_30)

				local var_233_32 = manager.ui.mainCamera.transform.position - var_233_27.position

				var_233_27.forward = Vector3.New(var_233_32.x, var_233_32.y, var_233_32.z)

				local var_233_33 = var_233_27.localEulerAngles

				var_233_33.z = 0
				var_233_33.x = 0
				var_233_27.localEulerAngles = var_233_33
			end

			if arg_230_1.time_ >= var_233_28 + var_233_29 and arg_230_1.time_ < var_233_28 + var_233_29 + arg_233_0 then
				var_233_27.localPosition = Vector3.New(0, 100, 0)

				local var_233_34 = manager.ui.mainCamera.transform.position - var_233_27.position

				var_233_27.forward = Vector3.New(var_233_34.x, var_233_34.y, var_233_34.z)

				local var_233_35 = var_233_27.localEulerAngles

				var_233_35.z = 0
				var_233_35.x = 0
				var_233_27.localEulerAngles = var_233_35
			end

			local var_233_36 = arg_230_1.actors_["1084ui_story"]
			local var_233_37 = 2

			if var_233_37 < arg_230_1.time_ and arg_230_1.time_ <= var_233_37 + arg_233_0 and not isNil(var_233_36) and arg_230_1.var_.characterEffect1084ui_story == nil then
				arg_230_1.var_.characterEffect1084ui_story = var_233_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_38 = 0.200000002980232

			if var_233_37 <= arg_230_1.time_ and arg_230_1.time_ < var_233_37 + var_233_38 and not isNil(var_233_36) then
				local var_233_39 = (arg_230_1.time_ - var_233_37) / var_233_38

				if arg_230_1.var_.characterEffect1084ui_story and not isNil(var_233_36) then
					local var_233_40 = Mathf.Lerp(0, 0.5, var_233_39)

					arg_230_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1084ui_story.fillRatio = var_233_40
				end
			end

			if arg_230_1.time_ >= var_233_37 + var_233_38 and arg_230_1.time_ < var_233_37 + var_233_38 + arg_233_0 and not isNil(var_233_36) and arg_230_1.var_.characterEffect1084ui_story then
				local var_233_41 = 0.5

				arg_230_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1084ui_story.fillRatio = var_233_41
			end

			local var_233_42 = 2

			arg_230_1.isInRecall_ = false

			if var_233_42 < arg_230_1.time_ and arg_230_1.time_ <= var_233_42 + arg_233_0 then
				arg_230_1.screenFilterGo_:SetActive(true)

				arg_230_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_233_2, iter_233_3 in pairs(arg_230_1.actors_) do
					local var_233_43 = iter_233_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_233_4, iter_233_5 in ipairs(var_233_43) do
						if iter_233_5.color.r > 0.51 then
							iter_233_5.color = Color.New(1, 1, 1)
						else
							iter_233_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_233_44 = 0.034000001847744

			if var_233_42 <= arg_230_1.time_ and arg_230_1.time_ < var_233_42 + var_233_44 then
				local var_233_45 = (arg_230_1.time_ - var_233_42) / var_233_44

				arg_230_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_233_45)
			end

			if arg_230_1.time_ >= var_233_42 + var_233_44 and arg_230_1.time_ < var_233_42 + var_233_44 + arg_233_0 then
				arg_230_1.screenFilterEffect_.weight = 1
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_46 = 4
			local var_233_47 = 0.225

			if var_233_46 < arg_230_1.time_ and arg_230_1.time_ <= var_233_46 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_48 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_48:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_49 = arg_230_1:FormatText(StoryNameCfg[36].name)

				arg_230_1.leftNameTxt_.text = var_233_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_50 = arg_230_1:GetWordFromCfg(319451056)
				local var_233_51 = arg_230_1:FormatText(var_233_50.content)

				arg_230_1.text_.text = var_233_51

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_52 = 9
				local var_233_53 = utf8.len(var_233_51)
				local var_233_54 = var_233_52 <= 0 and var_233_47 or var_233_47 * (var_233_53 / var_233_52)

				if var_233_54 > 0 and var_233_47 < var_233_54 then
					arg_230_1.talkMaxDuration = var_233_54
					var_233_46 = var_233_46 + 0.3

					if var_233_54 + var_233_46 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_54 + var_233_46
					end
				end

				arg_230_1.text_.text = var_233_51
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451056", "story_v_out_319451.awb") ~= 0 then
					local var_233_55 = manager.audio:GetVoiceLength("story_v_out_319451", "319451056", "story_v_out_319451.awb") / 1000

					if var_233_55 + var_233_46 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_55 + var_233_46
					end

					if var_233_50.prefab_name ~= "" and arg_230_1.actors_[var_233_50.prefab_name] ~= nil then
						local var_233_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_50.prefab_name].transform, "story_v_out_319451", "319451056", "story_v_out_319451.awb")

						arg_230_1:RecordAudio("319451056", var_233_56)
						arg_230_1:RecordAudio("319451056", var_233_56)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_319451", "319451056", "story_v_out_319451.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_319451", "319451056", "story_v_out_319451.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_57 = var_233_46 + 0.3
			local var_233_58 = math.max(var_233_47, arg_230_1.talkMaxDuration)

			if var_233_57 <= arg_230_1.time_ and arg_230_1.time_ < var_233_57 + var_233_58 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_57) / var_233_58

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_57 + var_233_58 and arg_230_1.time_ < var_233_57 + var_233_58 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play319451057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 319451057
		arg_236_1.duration_ = 2.83

		local var_236_0 = {
			zh = 2,
			ja = 2.833
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play319451058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = "10050ui_story"

			if arg_236_1.actors_[var_239_0] == nil then
				local var_239_1 = Asset.Load("Char/" .. "10050ui_story")

				if not isNil(var_239_1) then
					local var_239_2 = Object.Instantiate(Asset.Load("Char/" .. "10050ui_story"), arg_236_1.stage_.transform)

					var_239_2.name = var_239_0
					var_239_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_236_1.actors_[var_239_0] = var_239_2

					local var_239_3 = var_239_2:GetComponentInChildren(typeof(CharacterEffect))

					var_239_3.enabled = true

					local var_239_4 = GameObjectTools.GetOrAddComponent(var_239_2, typeof(DynamicBoneHelper))

					if var_239_4 then
						var_239_4:EnableDynamicBone(false)
					end

					arg_236_1:ShowWeapon(var_239_3.transform, false)

					arg_236_1.var_[var_239_0 .. "Animator"] = var_239_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_236_1.var_[var_239_0 .. "Animator"].applyRootMotion = true
					arg_236_1.var_[var_239_0 .. "LipSync"] = var_239_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_239_5 = arg_236_1.actors_["10050ui_story"].transform
			local var_239_6 = 0

			if var_239_6 < arg_236_1.time_ and arg_236_1.time_ <= var_239_6 + arg_239_0 then
				arg_236_1.var_.moveOldPos10050ui_story = var_239_5.localPosition
			end

			local var_239_7 = 0.001

			if var_239_6 <= arg_236_1.time_ and arg_236_1.time_ < var_239_6 + var_239_7 then
				local var_239_8 = (arg_236_1.time_ - var_239_6) / var_239_7
				local var_239_9 = Vector3.New(0, -0.715, -6.15)

				var_239_5.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10050ui_story, var_239_9, var_239_8)

				local var_239_10 = manager.ui.mainCamera.transform.position - var_239_5.position

				var_239_5.forward = Vector3.New(var_239_10.x, var_239_10.y, var_239_10.z)

				local var_239_11 = var_239_5.localEulerAngles

				var_239_11.z = 0
				var_239_11.x = 0
				var_239_5.localEulerAngles = var_239_11
			end

			if arg_236_1.time_ >= var_239_6 + var_239_7 and arg_236_1.time_ < var_239_6 + var_239_7 + arg_239_0 then
				var_239_5.localPosition = Vector3.New(0, -0.715, -6.15)

				local var_239_12 = manager.ui.mainCamera.transform.position - var_239_5.position

				var_239_5.forward = Vector3.New(var_239_12.x, var_239_12.y, var_239_12.z)

				local var_239_13 = var_239_5.localEulerAngles

				var_239_13.z = 0
				var_239_13.x = 0
				var_239_5.localEulerAngles = var_239_13
			end

			local var_239_14 = arg_236_1.actors_["10050ui_story"]
			local var_239_15 = 0

			if var_239_15 < arg_236_1.time_ and arg_236_1.time_ <= var_239_15 + arg_239_0 and not isNil(var_239_14) and arg_236_1.var_.characterEffect10050ui_story == nil then
				arg_236_1.var_.characterEffect10050ui_story = var_239_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_16 = 0.200000002980232

			if var_239_15 <= arg_236_1.time_ and arg_236_1.time_ < var_239_15 + var_239_16 and not isNil(var_239_14) then
				local var_239_17 = (arg_236_1.time_ - var_239_15) / var_239_16

				if arg_236_1.var_.characterEffect10050ui_story and not isNil(var_239_14) then
					arg_236_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= var_239_15 + var_239_16 and arg_236_1.time_ < var_239_15 + var_239_16 + arg_239_0 and not isNil(var_239_14) and arg_236_1.var_.characterEffect10050ui_story then
				arg_236_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_239_18 = 0

			if var_239_18 < arg_236_1.time_ and arg_236_1.time_ <= var_239_18 + arg_239_0 then
				arg_236_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_1")
			end

			local var_239_19 = 0

			if var_239_19 < arg_236_1.time_ and arg_236_1.time_ <= var_239_19 + arg_239_0 then
				arg_236_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_239_20 = 0
			local var_239_21 = 0.175

			if var_239_20 < arg_236_1.time_ and arg_236_1.time_ <= var_239_20 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_22 = arg_236_1:FormatText(StoryNameCfg[692].name)

				arg_236_1.leftNameTxt_.text = var_239_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_23 = arg_236_1:GetWordFromCfg(319451057)
				local var_239_24 = arg_236_1:FormatText(var_239_23.content)

				arg_236_1.text_.text = var_239_24

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_25 = 7
				local var_239_26 = utf8.len(var_239_24)
				local var_239_27 = var_239_25 <= 0 and var_239_21 or var_239_21 * (var_239_26 / var_239_25)

				if var_239_27 > 0 and var_239_21 < var_239_27 then
					arg_236_1.talkMaxDuration = var_239_27

					if var_239_27 + var_239_20 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_27 + var_239_20
					end
				end

				arg_236_1.text_.text = var_239_24
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451057", "story_v_out_319451.awb") ~= 0 then
					local var_239_28 = manager.audio:GetVoiceLength("story_v_out_319451", "319451057", "story_v_out_319451.awb") / 1000

					if var_239_28 + var_239_20 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_28 + var_239_20
					end

					if var_239_23.prefab_name ~= "" and arg_236_1.actors_[var_239_23.prefab_name] ~= nil then
						local var_239_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_23.prefab_name].transform, "story_v_out_319451", "319451057", "story_v_out_319451.awb")

						arg_236_1:RecordAudio("319451057", var_239_29)
						arg_236_1:RecordAudio("319451057", var_239_29)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_319451", "319451057", "story_v_out_319451.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_319451", "319451057", "story_v_out_319451.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_30 = math.max(var_239_21, arg_236_1.talkMaxDuration)

			if var_239_20 <= arg_236_1.time_ and arg_236_1.time_ < var_239_20 + var_239_30 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_20) / var_239_30

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_20 + var_239_30 and arg_236_1.time_ < var_239_20 + var_239_30 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play319451058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 319451058
		arg_240_1.duration_ = 16.2

		local var_240_0 = {
			zh = 9.8,
			ja = 16.2
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play319451059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 0.95

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_2 = arg_240_1:FormatText(StoryNameCfg[692].name)

				arg_240_1.leftNameTxt_.text = var_243_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_3 = arg_240_1:GetWordFromCfg(319451058)
				local var_243_4 = arg_240_1:FormatText(var_243_3.content)

				arg_240_1.text_.text = var_243_4

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 38
				local var_243_6 = utf8.len(var_243_4)
				local var_243_7 = var_243_5 <= 0 and var_243_1 or var_243_1 * (var_243_6 / var_243_5)

				if var_243_7 > 0 and var_243_1 < var_243_7 then
					arg_240_1.talkMaxDuration = var_243_7

					if var_243_7 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_4
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451058", "story_v_out_319451.awb") ~= 0 then
					local var_243_8 = manager.audio:GetVoiceLength("story_v_out_319451", "319451058", "story_v_out_319451.awb") / 1000

					if var_243_8 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_8 + var_243_0
					end

					if var_243_3.prefab_name ~= "" and arg_240_1.actors_[var_243_3.prefab_name] ~= nil then
						local var_243_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_3.prefab_name].transform, "story_v_out_319451", "319451058", "story_v_out_319451.awb")

						arg_240_1:RecordAudio("319451058", var_243_9)
						arg_240_1:RecordAudio("319451058", var_243_9)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_319451", "319451058", "story_v_out_319451.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_319451", "319451058", "story_v_out_319451.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_10 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_10 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_10

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_10 and arg_240_1.time_ < var_243_0 + var_243_10 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play319451059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 319451059
		arg_244_1.duration_ = 7.07

		local var_244_0 = {
			zh = 6.766,
			ja = 7.066
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play319451060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 0.8

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_2 = arg_244_1:FormatText(StoryNameCfg[692].name)

				arg_244_1.leftNameTxt_.text = var_247_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_3 = arg_244_1:GetWordFromCfg(319451059)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 32
				local var_247_6 = utf8.len(var_247_4)
				local var_247_7 = var_247_5 <= 0 and var_247_1 or var_247_1 * (var_247_6 / var_247_5)

				if var_247_7 > 0 and var_247_1 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_4
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451059", "story_v_out_319451.awb") ~= 0 then
					local var_247_8 = manager.audio:GetVoiceLength("story_v_out_319451", "319451059", "story_v_out_319451.awb") / 1000

					if var_247_8 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_0
					end

					if var_247_3.prefab_name ~= "" and arg_244_1.actors_[var_247_3.prefab_name] ~= nil then
						local var_247_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_3.prefab_name].transform, "story_v_out_319451", "319451059", "story_v_out_319451.awb")

						arg_244_1:RecordAudio("319451059", var_247_9)
						arg_244_1:RecordAudio("319451059", var_247_9)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_319451", "319451059", "story_v_out_319451.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_319451", "319451059", "story_v_out_319451.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_10 and arg_244_1.time_ < var_247_0 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play319451060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 319451060
		arg_248_1.duration_ = 4.97

		local var_248_0 = {
			zh = 3,
			ja = 4.966
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play319451061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["10050ui_story"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect10050ui_story == nil then
				arg_248_1.var_.characterEffect10050ui_story = var_251_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.characterEffect10050ui_story and not isNil(var_251_0) then
					local var_251_4 = Mathf.Lerp(0, 0.5, var_251_3)

					arg_248_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_248_1.var_.characterEffect10050ui_story.fillRatio = var_251_4
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect10050ui_story then
				local var_251_5 = 0.5

				arg_248_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_248_1.var_.characterEffect10050ui_story.fillRatio = var_251_5
			end

			local var_251_6 = 0
			local var_251_7 = 0.25

			if var_251_6 < arg_248_1.time_ and arg_248_1.time_ <= var_251_6 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_8 = arg_248_1:FormatText(StoryNameCfg[36].name)

				arg_248_1.leftNameTxt_.text = var_251_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_9 = arg_248_1:GetWordFromCfg(319451060)
				local var_251_10 = arg_248_1:FormatText(var_251_9.content)

				arg_248_1.text_.text = var_251_10

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_11 = 10
				local var_251_12 = utf8.len(var_251_10)
				local var_251_13 = var_251_11 <= 0 and var_251_7 or var_251_7 * (var_251_12 / var_251_11)

				if var_251_13 > 0 and var_251_7 < var_251_13 then
					arg_248_1.talkMaxDuration = var_251_13

					if var_251_13 + var_251_6 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_13 + var_251_6
					end
				end

				arg_248_1.text_.text = var_251_10
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451060", "story_v_out_319451.awb") ~= 0 then
					local var_251_14 = manager.audio:GetVoiceLength("story_v_out_319451", "319451060", "story_v_out_319451.awb") / 1000

					if var_251_14 + var_251_6 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_14 + var_251_6
					end

					if var_251_9.prefab_name ~= "" and arg_248_1.actors_[var_251_9.prefab_name] ~= nil then
						local var_251_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_9.prefab_name].transform, "story_v_out_319451", "319451060", "story_v_out_319451.awb")

						arg_248_1:RecordAudio("319451060", var_251_15)
						arg_248_1:RecordAudio("319451060", var_251_15)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_319451", "319451060", "story_v_out_319451.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_319451", "319451060", "story_v_out_319451.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_16 = math.max(var_251_7, arg_248_1.talkMaxDuration)

			if var_251_6 <= arg_248_1.time_ and arg_248_1.time_ < var_251_6 + var_251_16 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_6) / var_251_16

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_6 + var_251_16 and arg_248_1.time_ < var_251_6 + var_251_16 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play319451061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 319451061
		arg_252_1.duration_ = 12.23

		local var_252_0 = {
			zh = 4.366,
			ja = 12.233
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play319451062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["10050ui_story"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect10050ui_story == nil then
				arg_252_1.var_.characterEffect10050ui_story = var_255_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.characterEffect10050ui_story and not isNil(var_255_0) then
					arg_252_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect10050ui_story then
				arg_252_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_255_4 = 0

			if var_255_4 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_255_5 = 0
			local var_255_6 = 0.475

			if var_255_5 < arg_252_1.time_ and arg_252_1.time_ <= var_255_5 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_7 = arg_252_1:FormatText(StoryNameCfg[692].name)

				arg_252_1.leftNameTxt_.text = var_255_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_8 = arg_252_1:GetWordFromCfg(319451061)
				local var_255_9 = arg_252_1:FormatText(var_255_8.content)

				arg_252_1.text_.text = var_255_9

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_10 = 19
				local var_255_11 = utf8.len(var_255_9)
				local var_255_12 = var_255_10 <= 0 and var_255_6 or var_255_6 * (var_255_11 / var_255_10)

				if var_255_12 > 0 and var_255_6 < var_255_12 then
					arg_252_1.talkMaxDuration = var_255_12

					if var_255_12 + var_255_5 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_12 + var_255_5
					end
				end

				arg_252_1.text_.text = var_255_9
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451061", "story_v_out_319451.awb") ~= 0 then
					local var_255_13 = manager.audio:GetVoiceLength("story_v_out_319451", "319451061", "story_v_out_319451.awb") / 1000

					if var_255_13 + var_255_5 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_5
					end

					if var_255_8.prefab_name ~= "" and arg_252_1.actors_[var_255_8.prefab_name] ~= nil then
						local var_255_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_8.prefab_name].transform, "story_v_out_319451", "319451061", "story_v_out_319451.awb")

						arg_252_1:RecordAudio("319451061", var_255_14)
						arg_252_1:RecordAudio("319451061", var_255_14)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_319451", "319451061", "story_v_out_319451.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_319451", "319451061", "story_v_out_319451.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_15 = math.max(var_255_6, arg_252_1.talkMaxDuration)

			if var_255_5 <= arg_252_1.time_ and arg_252_1.time_ < var_255_5 + var_255_15 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_5) / var_255_15

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_5 + var_255_15 and arg_252_1.time_ < var_255_5 + var_255_15 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play319451062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 319451062
		arg_256_1.duration_ = 14.13

		local var_256_0 = {
			zh = 9.766,
			ja = 14.133
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play319451063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_259_1 = 0
			local var_259_2 = 1.15

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_3 = arg_256_1:FormatText(StoryNameCfg[692].name)

				arg_256_1.leftNameTxt_.text = var_259_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_4 = arg_256_1:GetWordFromCfg(319451062)
				local var_259_5 = arg_256_1:FormatText(var_259_4.content)

				arg_256_1.text_.text = var_259_5

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_6 = 46
				local var_259_7 = utf8.len(var_259_5)
				local var_259_8 = var_259_6 <= 0 and var_259_2 or var_259_2 * (var_259_7 / var_259_6)

				if var_259_8 > 0 and var_259_2 < var_259_8 then
					arg_256_1.talkMaxDuration = var_259_8

					if var_259_8 + var_259_1 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_1
					end
				end

				arg_256_1.text_.text = var_259_5
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451062", "story_v_out_319451.awb") ~= 0 then
					local var_259_9 = manager.audio:GetVoiceLength("story_v_out_319451", "319451062", "story_v_out_319451.awb") / 1000

					if var_259_9 + var_259_1 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_9 + var_259_1
					end

					if var_259_4.prefab_name ~= "" and arg_256_1.actors_[var_259_4.prefab_name] ~= nil then
						local var_259_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_4.prefab_name].transform, "story_v_out_319451", "319451062", "story_v_out_319451.awb")

						arg_256_1:RecordAudio("319451062", var_259_10)
						arg_256_1:RecordAudio("319451062", var_259_10)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_319451", "319451062", "story_v_out_319451.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_319451", "319451062", "story_v_out_319451.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_11 = math.max(var_259_2, arg_256_1.talkMaxDuration)

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_11 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_1) / var_259_11

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_1 + var_259_11 and arg_256_1.time_ < var_259_1 + var_259_11 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play319451063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 319451063
		arg_260_1.duration_ = 3.67

		local var_260_0 = {
			zh = 3.666,
			ja = 3.633
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play319451064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["10050ui_story"]
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect10050ui_story == nil then
				arg_260_1.var_.characterEffect10050ui_story = var_263_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.200000002980232

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 and not isNil(var_263_0) then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2

				if arg_260_1.var_.characterEffect10050ui_story and not isNil(var_263_0) then
					local var_263_4 = Mathf.Lerp(0, 0.5, var_263_3)

					arg_260_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_260_1.var_.characterEffect10050ui_story.fillRatio = var_263_4
				end
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect10050ui_story then
				local var_263_5 = 0.5

				arg_260_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_260_1.var_.characterEffect10050ui_story.fillRatio = var_263_5
			end

			local var_263_6 = 0
			local var_263_7 = 0.4

			if var_263_6 < arg_260_1.time_ and arg_260_1.time_ <= var_263_6 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_8 = arg_260_1:FormatText(StoryNameCfg[36].name)

				arg_260_1.leftNameTxt_.text = var_263_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_9 = arg_260_1:GetWordFromCfg(319451063)
				local var_263_10 = arg_260_1:FormatText(var_263_9.content)

				arg_260_1.text_.text = var_263_10

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_11 = 16
				local var_263_12 = utf8.len(var_263_10)
				local var_263_13 = var_263_11 <= 0 and var_263_7 or var_263_7 * (var_263_12 / var_263_11)

				if var_263_13 > 0 and var_263_7 < var_263_13 then
					arg_260_1.talkMaxDuration = var_263_13

					if var_263_13 + var_263_6 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_13 + var_263_6
					end
				end

				arg_260_1.text_.text = var_263_10
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451063", "story_v_out_319451.awb") ~= 0 then
					local var_263_14 = manager.audio:GetVoiceLength("story_v_out_319451", "319451063", "story_v_out_319451.awb") / 1000

					if var_263_14 + var_263_6 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_14 + var_263_6
					end

					if var_263_9.prefab_name ~= "" and arg_260_1.actors_[var_263_9.prefab_name] ~= nil then
						local var_263_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_9.prefab_name].transform, "story_v_out_319451", "319451063", "story_v_out_319451.awb")

						arg_260_1:RecordAudio("319451063", var_263_15)
						arg_260_1:RecordAudio("319451063", var_263_15)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_319451", "319451063", "story_v_out_319451.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_319451", "319451063", "story_v_out_319451.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_16 = math.max(var_263_7, arg_260_1.talkMaxDuration)

			if var_263_6 <= arg_260_1.time_ and arg_260_1.time_ < var_263_6 + var_263_16 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_6) / var_263_16

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_6 + var_263_16 and arg_260_1.time_ < var_263_6 + var_263_16 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play319451064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 319451064
		arg_264_1.duration_ = 4.23

		local var_264_0 = {
			zh = 3.4,
			ja = 4.233
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play319451065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["10050ui_story"].transform
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.var_.moveOldPos10050ui_story = var_267_0.localPosition
			end

			local var_267_2 = 0.001

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2
				local var_267_4 = Vector3.New(0, -0.715, -6.15)

				var_267_0.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10050ui_story, var_267_4, var_267_3)

				local var_267_5 = manager.ui.mainCamera.transform.position - var_267_0.position

				var_267_0.forward = Vector3.New(var_267_5.x, var_267_5.y, var_267_5.z)

				local var_267_6 = var_267_0.localEulerAngles

				var_267_6.z = 0
				var_267_6.x = 0
				var_267_0.localEulerAngles = var_267_6
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 then
				var_267_0.localPosition = Vector3.New(0, -0.715, -6.15)

				local var_267_7 = manager.ui.mainCamera.transform.position - var_267_0.position

				var_267_0.forward = Vector3.New(var_267_7.x, var_267_7.y, var_267_7.z)

				local var_267_8 = var_267_0.localEulerAngles

				var_267_8.z = 0
				var_267_8.x = 0
				var_267_0.localEulerAngles = var_267_8
			end

			local var_267_9 = arg_264_1.actors_["10050ui_story"]
			local var_267_10 = 0

			if var_267_10 < arg_264_1.time_ and arg_264_1.time_ <= var_267_10 + arg_267_0 and not isNil(var_267_9) and arg_264_1.var_.characterEffect10050ui_story == nil then
				arg_264_1.var_.characterEffect10050ui_story = var_267_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_11 = 0.200000002980232

			if var_267_10 <= arg_264_1.time_ and arg_264_1.time_ < var_267_10 + var_267_11 and not isNil(var_267_9) then
				local var_267_12 = (arg_264_1.time_ - var_267_10) / var_267_11

				if arg_264_1.var_.characterEffect10050ui_story and not isNil(var_267_9) then
					arg_264_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= var_267_10 + var_267_11 and arg_264_1.time_ < var_267_10 + var_267_11 + arg_267_0 and not isNil(var_267_9) and arg_264_1.var_.characterEffect10050ui_story then
				arg_264_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_267_13 = 0

			if var_267_13 < arg_264_1.time_ and arg_264_1.time_ <= var_267_13 + arg_267_0 then
				arg_264_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050actionlink/10050action423")
			end

			local var_267_14 = 0

			if var_267_14 < arg_264_1.time_ and arg_264_1.time_ <= var_267_14 + arg_267_0 then
				arg_264_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_267_15 = 0
			local var_267_16 = 0.35

			if var_267_15 < arg_264_1.time_ and arg_264_1.time_ <= var_267_15 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_17 = arg_264_1:FormatText(StoryNameCfg[692].name)

				arg_264_1.leftNameTxt_.text = var_267_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_18 = arg_264_1:GetWordFromCfg(319451064)
				local var_267_19 = arg_264_1:FormatText(var_267_18.content)

				arg_264_1.text_.text = var_267_19

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_20 = 14
				local var_267_21 = utf8.len(var_267_19)
				local var_267_22 = var_267_20 <= 0 and var_267_16 or var_267_16 * (var_267_21 / var_267_20)

				if var_267_22 > 0 and var_267_16 < var_267_22 then
					arg_264_1.talkMaxDuration = var_267_22

					if var_267_22 + var_267_15 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_22 + var_267_15
					end
				end

				arg_264_1.text_.text = var_267_19
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451064", "story_v_out_319451.awb") ~= 0 then
					local var_267_23 = manager.audio:GetVoiceLength("story_v_out_319451", "319451064", "story_v_out_319451.awb") / 1000

					if var_267_23 + var_267_15 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_23 + var_267_15
					end

					if var_267_18.prefab_name ~= "" and arg_264_1.actors_[var_267_18.prefab_name] ~= nil then
						local var_267_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_18.prefab_name].transform, "story_v_out_319451", "319451064", "story_v_out_319451.awb")

						arg_264_1:RecordAudio("319451064", var_267_24)
						arg_264_1:RecordAudio("319451064", var_267_24)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_319451", "319451064", "story_v_out_319451.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_319451", "319451064", "story_v_out_319451.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_25 = math.max(var_267_16, arg_264_1.talkMaxDuration)

			if var_267_15 <= arg_264_1.time_ and arg_264_1.time_ < var_267_15 + var_267_25 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_15) / var_267_25

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_15 + var_267_25 and arg_264_1.time_ < var_267_15 + var_267_25 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play319451065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 319451065
		arg_268_1.duration_ = 13.57

		local var_268_0 = {
			zh = 5.2,
			ja = 13.566
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play319451066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_271_1 = 0
			local var_271_2 = 0.7

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_3 = arg_268_1:FormatText(StoryNameCfg[692].name)

				arg_268_1.leftNameTxt_.text = var_271_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_4 = arg_268_1:GetWordFromCfg(319451065)
				local var_271_5 = arg_268_1:FormatText(var_271_4.content)

				arg_268_1.text_.text = var_271_5

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_6 = 28
				local var_271_7 = utf8.len(var_271_5)
				local var_271_8 = var_271_6 <= 0 and var_271_2 or var_271_2 * (var_271_7 / var_271_6)

				if var_271_8 > 0 and var_271_2 < var_271_8 then
					arg_268_1.talkMaxDuration = var_271_8

					if var_271_8 + var_271_1 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_8 + var_271_1
					end
				end

				arg_268_1.text_.text = var_271_5
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451065", "story_v_out_319451.awb") ~= 0 then
					local var_271_9 = manager.audio:GetVoiceLength("story_v_out_319451", "319451065", "story_v_out_319451.awb") / 1000

					if var_271_9 + var_271_1 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_9 + var_271_1
					end

					if var_271_4.prefab_name ~= "" and arg_268_1.actors_[var_271_4.prefab_name] ~= nil then
						local var_271_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_4.prefab_name].transform, "story_v_out_319451", "319451065", "story_v_out_319451.awb")

						arg_268_1:RecordAudio("319451065", var_271_10)
						arg_268_1:RecordAudio("319451065", var_271_10)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_319451", "319451065", "story_v_out_319451.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_319451", "319451065", "story_v_out_319451.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_11 = math.max(var_271_2, arg_268_1.talkMaxDuration)

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_11 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_1) / var_271_11

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_1 + var_271_11 and arg_268_1.time_ < var_271_1 + var_271_11 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play319451066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 319451066
		arg_272_1.duration_ = 11.9

		local var_272_0 = {
			zh = 11.9,
			ja = 9.133
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play319451067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 1.35

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_2 = arg_272_1:FormatText(StoryNameCfg[692].name)

				arg_272_1.leftNameTxt_.text = var_275_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_3 = arg_272_1:GetWordFromCfg(319451066)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 54
				local var_275_6 = utf8.len(var_275_4)
				local var_275_7 = var_275_5 <= 0 and var_275_1 or var_275_1 * (var_275_6 / var_275_5)

				if var_275_7 > 0 and var_275_1 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451066", "story_v_out_319451.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_out_319451", "319451066", "story_v_out_319451.awb") / 1000

					if var_275_8 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_0
					end

					if var_275_3.prefab_name ~= "" and arg_272_1.actors_[var_275_3.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_3.prefab_name].transform, "story_v_out_319451", "319451066", "story_v_out_319451.awb")

						arg_272_1:RecordAudio("319451066", var_275_9)
						arg_272_1:RecordAudio("319451066", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_319451", "319451066", "story_v_out_319451.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_319451", "319451066", "story_v_out_319451.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_10 and arg_272_1.time_ < var_275_0 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play319451067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 319451067
		arg_276_1.duration_ = 16.23

		local var_276_0 = {
			zh = 12,
			ja = 16.233
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play319451068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["10050ui_story"].transform
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.var_.moveOldPos10050ui_story = var_279_0.localPosition
			end

			local var_279_2 = 0.001

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2
				local var_279_4 = Vector3.New(0, -0.715, -6.15)

				var_279_0.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10050ui_story, var_279_4, var_279_3)

				local var_279_5 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_5.x, var_279_5.y, var_279_5.z)

				local var_279_6 = var_279_0.localEulerAngles

				var_279_6.z = 0
				var_279_6.x = 0
				var_279_0.localEulerAngles = var_279_6
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 then
				var_279_0.localPosition = Vector3.New(0, -0.715, -6.15)

				local var_279_7 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_7.x, var_279_7.y, var_279_7.z)

				local var_279_8 = var_279_0.localEulerAngles

				var_279_8.z = 0
				var_279_8.x = 0
				var_279_0.localEulerAngles = var_279_8
			end

			local var_279_9 = arg_276_1.actors_["10050ui_story"]
			local var_279_10 = 0

			if var_279_10 < arg_276_1.time_ and arg_276_1.time_ <= var_279_10 + arg_279_0 and not isNil(var_279_9) and arg_276_1.var_.characterEffect10050ui_story == nil then
				arg_276_1.var_.characterEffect10050ui_story = var_279_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_11 = 0.200000002980232

			if var_279_10 <= arg_276_1.time_ and arg_276_1.time_ < var_279_10 + var_279_11 and not isNil(var_279_9) then
				local var_279_12 = (arg_276_1.time_ - var_279_10) / var_279_11

				if arg_276_1.var_.characterEffect10050ui_story and not isNil(var_279_9) then
					arg_276_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= var_279_10 + var_279_11 and arg_276_1.time_ < var_279_10 + var_279_11 + arg_279_0 and not isNil(var_279_9) and arg_276_1.var_.characterEffect10050ui_story then
				arg_276_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_279_13 = 0

			if var_279_13 < arg_276_1.time_ and arg_276_1.time_ <= var_279_13 + arg_279_0 then
				arg_276_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action3_2")
			end

			local var_279_14 = 0
			local var_279_15 = 1.375

			if var_279_14 < arg_276_1.time_ and arg_276_1.time_ <= var_279_14 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_16 = arg_276_1:FormatText(StoryNameCfg[692].name)

				arg_276_1.leftNameTxt_.text = var_279_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_17 = arg_276_1:GetWordFromCfg(319451067)
				local var_279_18 = arg_276_1:FormatText(var_279_17.content)

				arg_276_1.text_.text = var_279_18

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_19 = 55
				local var_279_20 = utf8.len(var_279_18)
				local var_279_21 = var_279_19 <= 0 and var_279_15 or var_279_15 * (var_279_20 / var_279_19)

				if var_279_21 > 0 and var_279_15 < var_279_21 then
					arg_276_1.talkMaxDuration = var_279_21

					if var_279_21 + var_279_14 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_21 + var_279_14
					end
				end

				arg_276_1.text_.text = var_279_18
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451067", "story_v_out_319451.awb") ~= 0 then
					local var_279_22 = manager.audio:GetVoiceLength("story_v_out_319451", "319451067", "story_v_out_319451.awb") / 1000

					if var_279_22 + var_279_14 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_22 + var_279_14
					end

					if var_279_17.prefab_name ~= "" and arg_276_1.actors_[var_279_17.prefab_name] ~= nil then
						local var_279_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_17.prefab_name].transform, "story_v_out_319451", "319451067", "story_v_out_319451.awb")

						arg_276_1:RecordAudio("319451067", var_279_23)
						arg_276_1:RecordAudio("319451067", var_279_23)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_319451", "319451067", "story_v_out_319451.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_319451", "319451067", "story_v_out_319451.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_24 = math.max(var_279_15, arg_276_1.talkMaxDuration)

			if var_279_14 <= arg_276_1.time_ and arg_276_1.time_ < var_279_14 + var_279_24 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_14) / var_279_24

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_14 + var_279_24 and arg_276_1.time_ < var_279_14 + var_279_24 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play319451068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 319451068
		arg_280_1.duration_ = 11.43

		local var_280_0 = {
			zh = 9.46633333333333,
			ja = 11.4333333333333
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play319451069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 2

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				local var_283_1 = manager.ui.mainCamera.transform.localPosition
				local var_283_2 = Vector3.New(0, 0, 10) + Vector3.New(var_283_1.x, var_283_1.y, 0)
				local var_283_3 = arg_280_1.bgs_.ST07a

				var_283_3.transform.localPosition = var_283_2
				var_283_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_283_4 = var_283_3:GetComponent("SpriteRenderer")

				if var_283_4 and var_283_4.sprite then
					local var_283_5 = (var_283_3.transform.localPosition - var_283_1).z
					local var_283_6 = manager.ui.mainCameraCom_
					local var_283_7 = 2 * var_283_5 * Mathf.Tan(var_283_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_283_8 = var_283_7 * var_283_6.aspect
					local var_283_9 = var_283_4.sprite.bounds.size.x
					local var_283_10 = var_283_4.sprite.bounds.size.y
					local var_283_11 = var_283_8 / var_283_9
					local var_283_12 = var_283_7 / var_283_10
					local var_283_13 = var_283_12 < var_283_11 and var_283_11 or var_283_12

					var_283_3.transform.localScale = Vector3.New(var_283_13, var_283_13, 0)
				end

				for iter_283_0, iter_283_1 in pairs(arg_280_1.bgs_) do
					if iter_283_0 ~= "ST07a" then
						iter_283_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_283_14 = 0

			if var_283_14 < arg_280_1.time_ and arg_280_1.time_ <= var_283_14 + arg_283_0 then
				arg_280_1.mask_.enabled = true
				arg_280_1.mask_.raycastTarget = true

				arg_280_1:SetGaussion(false)
			end

			local var_283_15 = 2

			if var_283_14 <= arg_280_1.time_ and arg_280_1.time_ < var_283_14 + var_283_15 then
				local var_283_16 = (arg_280_1.time_ - var_283_14) / var_283_15
				local var_283_17 = Color.New(0, 0, 0)

				var_283_17.a = Mathf.Lerp(0, 1, var_283_16)
				arg_280_1.mask_.color = var_283_17
			end

			if arg_280_1.time_ >= var_283_14 + var_283_15 and arg_280_1.time_ < var_283_14 + var_283_15 + arg_283_0 then
				local var_283_18 = Color.New(0, 0, 0)

				var_283_18.a = 1
				arg_280_1.mask_.color = var_283_18
			end

			local var_283_19 = 2

			if var_283_19 < arg_280_1.time_ and arg_280_1.time_ <= var_283_19 + arg_283_0 then
				arg_280_1.mask_.enabled = true
				arg_280_1.mask_.raycastTarget = true

				arg_280_1:SetGaussion(false)
			end

			local var_283_20 = 2

			if var_283_19 <= arg_280_1.time_ and arg_280_1.time_ < var_283_19 + var_283_20 then
				local var_283_21 = (arg_280_1.time_ - var_283_19) / var_283_20
				local var_283_22 = Color.New(0, 0, 0)

				var_283_22.a = Mathf.Lerp(1, 0, var_283_21)
				arg_280_1.mask_.color = var_283_22
			end

			if arg_280_1.time_ >= var_283_19 + var_283_20 and arg_280_1.time_ < var_283_19 + var_283_20 + arg_283_0 then
				local var_283_23 = Color.New(0, 0, 0)
				local var_283_24 = 0

				arg_280_1.mask_.enabled = false
				var_283_23.a = var_283_24
				arg_280_1.mask_.color = var_283_23
			end

			local var_283_25 = arg_280_1.actors_["1084ui_story"].transform
			local var_283_26 = 3.53333333333333

			if var_283_26 < arg_280_1.time_ and arg_280_1.time_ <= var_283_26 + arg_283_0 then
				arg_280_1.var_.moveOldPos1084ui_story = var_283_25.localPosition
			end

			local var_283_27 = 0.001

			if var_283_26 <= arg_280_1.time_ and arg_280_1.time_ < var_283_26 + var_283_27 then
				local var_283_28 = (arg_280_1.time_ - var_283_26) / var_283_27
				local var_283_29 = Vector3.New(0, -0.97, -6)

				var_283_25.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1084ui_story, var_283_29, var_283_28)

				local var_283_30 = manager.ui.mainCamera.transform.position - var_283_25.position

				var_283_25.forward = Vector3.New(var_283_30.x, var_283_30.y, var_283_30.z)

				local var_283_31 = var_283_25.localEulerAngles

				var_283_31.z = 0
				var_283_31.x = 0
				var_283_25.localEulerAngles = var_283_31
			end

			if arg_280_1.time_ >= var_283_26 + var_283_27 and arg_280_1.time_ < var_283_26 + var_283_27 + arg_283_0 then
				var_283_25.localPosition = Vector3.New(0, -0.97, -6)

				local var_283_32 = manager.ui.mainCamera.transform.position - var_283_25.position

				var_283_25.forward = Vector3.New(var_283_32.x, var_283_32.y, var_283_32.z)

				local var_283_33 = var_283_25.localEulerAngles

				var_283_33.z = 0
				var_283_33.x = 0
				var_283_25.localEulerAngles = var_283_33
			end

			local var_283_34 = arg_280_1.actors_["1084ui_story"]
			local var_283_35 = 3.53333333333333

			if var_283_35 < arg_280_1.time_ and arg_280_1.time_ <= var_283_35 + arg_283_0 and not isNil(var_283_34) and arg_280_1.var_.characterEffect1084ui_story == nil then
				arg_280_1.var_.characterEffect1084ui_story = var_283_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_36 = 0.200000002980232

			if var_283_35 <= arg_280_1.time_ and arg_280_1.time_ < var_283_35 + var_283_36 and not isNil(var_283_34) then
				local var_283_37 = (arg_280_1.time_ - var_283_35) / var_283_36

				if arg_280_1.var_.characterEffect1084ui_story and not isNil(var_283_34) then
					arg_280_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= var_283_35 + var_283_36 and arg_280_1.time_ < var_283_35 + var_283_36 + arg_283_0 and not isNil(var_283_34) and arg_280_1.var_.characterEffect1084ui_story then
				arg_280_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_283_38 = 3.53333333333333

			if var_283_38 < arg_280_1.time_ and arg_280_1.time_ <= var_283_38 + arg_283_0 then
				arg_280_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_283_39 = 3.53333333333333

			if var_283_39 < arg_280_1.time_ and arg_280_1.time_ <= var_283_39 + arg_283_0 then
				arg_280_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_283_40 = arg_280_1.actors_["10050ui_story"].transform
			local var_283_41 = 2

			if var_283_41 < arg_280_1.time_ and arg_280_1.time_ <= var_283_41 + arg_283_0 then
				arg_280_1.var_.moveOldPos10050ui_story = var_283_40.localPosition
			end

			local var_283_42 = 0.001

			if var_283_41 <= arg_280_1.time_ and arg_280_1.time_ < var_283_41 + var_283_42 then
				local var_283_43 = (arg_280_1.time_ - var_283_41) / var_283_42
				local var_283_44 = Vector3.New(0, 100, 0)

				var_283_40.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10050ui_story, var_283_44, var_283_43)

				local var_283_45 = manager.ui.mainCamera.transform.position - var_283_40.position

				var_283_40.forward = Vector3.New(var_283_45.x, var_283_45.y, var_283_45.z)

				local var_283_46 = var_283_40.localEulerAngles

				var_283_46.z = 0
				var_283_46.x = 0
				var_283_40.localEulerAngles = var_283_46
			end

			if arg_280_1.time_ >= var_283_41 + var_283_42 and arg_280_1.time_ < var_283_41 + var_283_42 + arg_283_0 then
				var_283_40.localPosition = Vector3.New(0, 100, 0)

				local var_283_47 = manager.ui.mainCamera.transform.position - var_283_40.position

				var_283_40.forward = Vector3.New(var_283_47.x, var_283_47.y, var_283_47.z)

				local var_283_48 = var_283_40.localEulerAngles

				var_283_48.z = 0
				var_283_48.x = 0
				var_283_40.localEulerAngles = var_283_48
			end

			local var_283_49 = arg_280_1.actors_["10050ui_story"]
			local var_283_50 = 2

			if var_283_50 < arg_280_1.time_ and arg_280_1.time_ <= var_283_50 + arg_283_0 and not isNil(var_283_49) and arg_280_1.var_.characterEffect10050ui_story == nil then
				arg_280_1.var_.characterEffect10050ui_story = var_283_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_51 = 0.200000002980232

			if var_283_50 <= arg_280_1.time_ and arg_280_1.time_ < var_283_50 + var_283_51 and not isNil(var_283_49) then
				local var_283_52 = (arg_280_1.time_ - var_283_50) / var_283_51

				if arg_280_1.var_.characterEffect10050ui_story and not isNil(var_283_49) then
					local var_283_53 = Mathf.Lerp(0, 0.5, var_283_52)

					arg_280_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_280_1.var_.characterEffect10050ui_story.fillRatio = var_283_53
				end
			end

			if arg_280_1.time_ >= var_283_50 + var_283_51 and arg_280_1.time_ < var_283_50 + var_283_51 + arg_283_0 and not isNil(var_283_49) and arg_280_1.var_.characterEffect10050ui_story then
				local var_283_54 = 0.5

				arg_280_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_280_1.var_.characterEffect10050ui_story.fillRatio = var_283_54
			end

			local var_283_55 = 2

			arg_280_1.isInRecall_ = false

			if var_283_55 < arg_280_1.time_ and arg_280_1.time_ <= var_283_55 + arg_283_0 then
				arg_280_1.screenFilterGo_:SetActive(false)

				for iter_283_2, iter_283_3 in pairs(arg_280_1.actors_) do
					local var_283_56 = iter_283_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_283_4, iter_283_5 in ipairs(var_283_56) do
						if iter_283_5.color.r > 0.51 then
							iter_283_5.color = Color.New(1, 1, 1)
						else
							iter_283_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_283_57 = 0.166000001132488

			if var_283_55 <= arg_280_1.time_ and arg_280_1.time_ < var_283_55 + var_283_57 then
				local var_283_58 = (arg_280_1.time_ - var_283_55) / var_283_57

				arg_280_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_283_58)
			end

			if arg_280_1.time_ >= var_283_55 + var_283_57 and arg_280_1.time_ < var_283_55 + var_283_57 + arg_283_0 then
				arg_280_1.screenFilterEffect_.weight = 0
			end

			if arg_280_1.frameCnt_ <= 1 then
				arg_280_1.dialog_:SetActive(false)
			end

			local var_283_59 = 3.53333333333333
			local var_283_60 = 0.75

			if var_283_59 < arg_280_1.time_ and arg_280_1.time_ <= var_283_59 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0

				arg_280_1.dialog_:SetActive(true)

				arg_280_1.dialogCg_.alpha = 0

				local var_283_61 = LeanTween.value(arg_280_1.dialog_, 0, 1, 0.3)

				var_283_61:setOnUpdate(LuaHelper.FloatAction(function(arg_284_0)
					arg_280_1.dialogCg_.alpha = arg_284_0
				end))
				var_283_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_280_1.dialog_)
					var_283_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_280_1.duration_ = arg_280_1.duration_ + 0.3

				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_62 = arg_280_1:FormatText(StoryNameCfg[6].name)

				arg_280_1.leftNameTxt_.text = var_283_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_63 = arg_280_1:GetWordFromCfg(319451068)
				local var_283_64 = arg_280_1:FormatText(var_283_63.content)

				arg_280_1.text_.text = var_283_64

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_65 = 30
				local var_283_66 = utf8.len(var_283_64)
				local var_283_67 = var_283_65 <= 0 and var_283_60 or var_283_60 * (var_283_66 / var_283_65)

				if var_283_67 > 0 and var_283_60 < var_283_67 then
					arg_280_1.talkMaxDuration = var_283_67
					var_283_59 = var_283_59 + 0.3

					if var_283_67 + var_283_59 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_67 + var_283_59
					end
				end

				arg_280_1.text_.text = var_283_64
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451068", "story_v_out_319451.awb") ~= 0 then
					local var_283_68 = manager.audio:GetVoiceLength("story_v_out_319451", "319451068", "story_v_out_319451.awb") / 1000

					if var_283_68 + var_283_59 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_68 + var_283_59
					end

					if var_283_63.prefab_name ~= "" and arg_280_1.actors_[var_283_63.prefab_name] ~= nil then
						local var_283_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_63.prefab_name].transform, "story_v_out_319451", "319451068", "story_v_out_319451.awb")

						arg_280_1:RecordAudio("319451068", var_283_69)
						arg_280_1:RecordAudio("319451068", var_283_69)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_319451", "319451068", "story_v_out_319451.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_319451", "319451068", "story_v_out_319451.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_70 = var_283_59 + 0.3
			local var_283_71 = math.max(var_283_60, arg_280_1.talkMaxDuration)

			if var_283_70 <= arg_280_1.time_ and arg_280_1.time_ < var_283_70 + var_283_71 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_70) / var_283_71

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_70 + var_283_71 and arg_280_1.time_ < var_283_70 + var_283_71 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play319451069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 319451069
		arg_286_1.duration_ = 7.3

		local var_286_0 = {
			zh = 7.033,
			ja = 7.3
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play319451070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_289_2 = 0
			local var_289_3 = 0.825

			if var_289_2 < arg_286_1.time_ and arg_286_1.time_ <= var_289_2 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_4 = arg_286_1:FormatText(StoryNameCfg[6].name)

				arg_286_1.leftNameTxt_.text = var_289_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_5 = arg_286_1:GetWordFromCfg(319451069)
				local var_289_6 = arg_286_1:FormatText(var_289_5.content)

				arg_286_1.text_.text = var_289_6

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_7 = 33
				local var_289_8 = utf8.len(var_289_6)
				local var_289_9 = var_289_7 <= 0 and var_289_3 or var_289_3 * (var_289_8 / var_289_7)

				if var_289_9 > 0 and var_289_3 < var_289_9 then
					arg_286_1.talkMaxDuration = var_289_9

					if var_289_9 + var_289_2 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_9 + var_289_2
					end
				end

				arg_286_1.text_.text = var_289_6
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451069", "story_v_out_319451.awb") ~= 0 then
					local var_289_10 = manager.audio:GetVoiceLength("story_v_out_319451", "319451069", "story_v_out_319451.awb") / 1000

					if var_289_10 + var_289_2 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_10 + var_289_2
					end

					if var_289_5.prefab_name ~= "" and arg_286_1.actors_[var_289_5.prefab_name] ~= nil then
						local var_289_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_5.prefab_name].transform, "story_v_out_319451", "319451069", "story_v_out_319451.awb")

						arg_286_1:RecordAudio("319451069", var_289_11)
						arg_286_1:RecordAudio("319451069", var_289_11)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_319451", "319451069", "story_v_out_319451.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_319451", "319451069", "story_v_out_319451.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_12 = math.max(var_289_3, arg_286_1.talkMaxDuration)

			if var_289_2 <= arg_286_1.time_ and arg_286_1.time_ < var_289_2 + var_289_12 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_2) / var_289_12

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_2 + var_289_12 and arg_286_1.time_ < var_289_2 + var_289_12 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play319451070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 319451070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play319451071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1084ui_story"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1084ui_story == nil then
				arg_290_1.var_.characterEffect1084ui_story = var_293_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_2 = 0.200000002980232

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.characterEffect1084ui_story and not isNil(var_293_0) then
					local var_293_4 = Mathf.Lerp(0, 0.5, var_293_3)

					arg_290_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1084ui_story.fillRatio = var_293_4
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1084ui_story then
				local var_293_5 = 0.5

				arg_290_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1084ui_story.fillRatio = var_293_5
			end

			local var_293_6 = 0
			local var_293_7 = 0.175

			if var_293_6 < arg_290_1.time_ and arg_290_1.time_ <= var_293_6 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_8 = arg_290_1:FormatText(StoryNameCfg[698].name)

				arg_290_1.leftNameTxt_.text = var_293_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_9 = arg_290_1:GetWordFromCfg(319451070)
				local var_293_10 = arg_290_1:FormatText(var_293_9.content)

				arg_290_1.text_.text = var_293_10

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_11 = 7
				local var_293_12 = utf8.len(var_293_10)
				local var_293_13 = var_293_11 <= 0 and var_293_7 or var_293_7 * (var_293_12 / var_293_11)

				if var_293_13 > 0 and var_293_7 < var_293_13 then
					arg_290_1.talkMaxDuration = var_293_13

					if var_293_13 + var_293_6 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_13 + var_293_6
					end
				end

				arg_290_1.text_.text = var_293_10
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_14 = math.max(var_293_7, arg_290_1.talkMaxDuration)

			if var_293_6 <= arg_290_1.time_ and arg_290_1.time_ < var_293_6 + var_293_14 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_6) / var_293_14

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_6 + var_293_14 and arg_290_1.time_ < var_293_6 + var_293_14 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play319451071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 319451071
		arg_294_1.duration_ = 4.6

		local var_294_0 = {
			zh = 1.999999999999,
			ja = 4.6
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play319451072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["10069ui_story"].transform
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.var_.moveOldPos10069ui_story = var_297_0.localPosition
			end

			local var_297_2 = 0.001

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2
				local var_297_4 = Vector3.New(0.7, -1.08, -6.33)

				var_297_0.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos10069ui_story, var_297_4, var_297_3)

				local var_297_5 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_5.x, var_297_5.y, var_297_5.z)

				local var_297_6 = var_297_0.localEulerAngles

				var_297_6.z = 0
				var_297_6.x = 0
				var_297_0.localEulerAngles = var_297_6
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 then
				var_297_0.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_297_7 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_7.x, var_297_7.y, var_297_7.z)

				local var_297_8 = var_297_0.localEulerAngles

				var_297_8.z = 0
				var_297_8.x = 0
				var_297_0.localEulerAngles = var_297_8
			end

			local var_297_9 = arg_294_1.actors_["10069ui_story"]
			local var_297_10 = 0

			if var_297_10 < arg_294_1.time_ and arg_294_1.time_ <= var_297_10 + arg_297_0 and not isNil(var_297_9) and arg_294_1.var_.characterEffect10069ui_story == nil then
				arg_294_1.var_.characterEffect10069ui_story = var_297_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_11 = 0.200000002980232

			if var_297_10 <= arg_294_1.time_ and arg_294_1.time_ < var_297_10 + var_297_11 and not isNil(var_297_9) then
				local var_297_12 = (arg_294_1.time_ - var_297_10) / var_297_11

				if arg_294_1.var_.characterEffect10069ui_story and not isNil(var_297_9) then
					arg_294_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= var_297_10 + var_297_11 and arg_294_1.time_ < var_297_10 + var_297_11 + arg_297_0 and not isNil(var_297_9) and arg_294_1.var_.characterEffect10069ui_story then
				arg_294_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_297_13 = 0

			if var_297_13 < arg_294_1.time_ and arg_294_1.time_ <= var_297_13 + arg_297_0 then
				arg_294_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_297_14 = 0

			if var_297_14 < arg_294_1.time_ and arg_294_1.time_ <= var_297_14 + arg_297_0 then
				arg_294_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_297_15 = arg_294_1.actors_["1084ui_story"].transform
			local var_297_16 = 0

			if var_297_16 < arg_294_1.time_ and arg_294_1.time_ <= var_297_16 + arg_297_0 then
				arg_294_1.var_.moveOldPos1084ui_story = var_297_15.localPosition
			end

			local var_297_17 = 0.001

			if var_297_16 <= arg_294_1.time_ and arg_294_1.time_ < var_297_16 + var_297_17 then
				local var_297_18 = (arg_294_1.time_ - var_297_16) / var_297_17
				local var_297_19 = Vector3.New(-0.7, -0.97, -6)

				var_297_15.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1084ui_story, var_297_19, var_297_18)

				local var_297_20 = manager.ui.mainCamera.transform.position - var_297_15.position

				var_297_15.forward = Vector3.New(var_297_20.x, var_297_20.y, var_297_20.z)

				local var_297_21 = var_297_15.localEulerAngles

				var_297_21.z = 0
				var_297_21.x = 0
				var_297_15.localEulerAngles = var_297_21
			end

			if arg_294_1.time_ >= var_297_16 + var_297_17 and arg_294_1.time_ < var_297_16 + var_297_17 + arg_297_0 then
				var_297_15.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_297_22 = manager.ui.mainCamera.transform.position - var_297_15.position

				var_297_15.forward = Vector3.New(var_297_22.x, var_297_22.y, var_297_22.z)

				local var_297_23 = var_297_15.localEulerAngles

				var_297_23.z = 0
				var_297_23.x = 0
				var_297_15.localEulerAngles = var_297_23
			end

			local var_297_24 = arg_294_1.actors_["1084ui_story"]
			local var_297_25 = 0

			if var_297_25 < arg_294_1.time_ and arg_294_1.time_ <= var_297_25 + arg_297_0 and not isNil(var_297_24) and arg_294_1.var_.characterEffect1084ui_story == nil then
				arg_294_1.var_.characterEffect1084ui_story = var_297_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_26 = 0.200000002980232

			if var_297_25 <= arg_294_1.time_ and arg_294_1.time_ < var_297_25 + var_297_26 and not isNil(var_297_24) then
				local var_297_27 = (arg_294_1.time_ - var_297_25) / var_297_26

				if arg_294_1.var_.characterEffect1084ui_story and not isNil(var_297_24) then
					local var_297_28 = Mathf.Lerp(0, 0.5, var_297_27)

					arg_294_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_294_1.var_.characterEffect1084ui_story.fillRatio = var_297_28
				end
			end

			if arg_294_1.time_ >= var_297_25 + var_297_26 and arg_294_1.time_ < var_297_25 + var_297_26 + arg_297_0 and not isNil(var_297_24) and arg_294_1.var_.characterEffect1084ui_story then
				local var_297_29 = 0.5

				arg_294_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_294_1.var_.characterEffect1084ui_story.fillRatio = var_297_29
			end

			local var_297_30 = 0
			local var_297_31 = 0.15

			if var_297_30 < arg_294_1.time_ and arg_294_1.time_ <= var_297_30 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_32 = arg_294_1:FormatText(StoryNameCfg[693].name)

				arg_294_1.leftNameTxt_.text = var_297_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_33 = arg_294_1:GetWordFromCfg(319451071)
				local var_297_34 = arg_294_1:FormatText(var_297_33.content)

				arg_294_1.text_.text = var_297_34

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_35 = 6
				local var_297_36 = utf8.len(var_297_34)
				local var_297_37 = var_297_35 <= 0 and var_297_31 or var_297_31 * (var_297_36 / var_297_35)

				if var_297_37 > 0 and var_297_31 < var_297_37 then
					arg_294_1.talkMaxDuration = var_297_37

					if var_297_37 + var_297_30 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_37 + var_297_30
					end
				end

				arg_294_1.text_.text = var_297_34
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451071", "story_v_out_319451.awb") ~= 0 then
					local var_297_38 = manager.audio:GetVoiceLength("story_v_out_319451", "319451071", "story_v_out_319451.awb") / 1000

					if var_297_38 + var_297_30 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_38 + var_297_30
					end

					if var_297_33.prefab_name ~= "" and arg_294_1.actors_[var_297_33.prefab_name] ~= nil then
						local var_297_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_33.prefab_name].transform, "story_v_out_319451", "319451071", "story_v_out_319451.awb")

						arg_294_1:RecordAudio("319451071", var_297_39)
						arg_294_1:RecordAudio("319451071", var_297_39)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_319451", "319451071", "story_v_out_319451.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_319451", "319451071", "story_v_out_319451.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_40 = math.max(var_297_31, arg_294_1.talkMaxDuration)

			if var_297_30 <= arg_294_1.time_ and arg_294_1.time_ < var_297_30 + var_297_40 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_30) / var_297_40

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_30 + var_297_40 and arg_294_1.time_ < var_297_30 + var_297_40 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play319451072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 319451072
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play319451073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["10069ui_story"]
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.characterEffect10069ui_story == nil then
				arg_298_1.var_.characterEffect10069ui_story = var_301_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_2 = 0.200000002980232

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 and not isNil(var_301_0) then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2

				if arg_298_1.var_.characterEffect10069ui_story and not isNil(var_301_0) then
					local var_301_4 = Mathf.Lerp(0, 0.5, var_301_3)

					arg_298_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_298_1.var_.characterEffect10069ui_story.fillRatio = var_301_4
				end
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.characterEffect10069ui_story then
				local var_301_5 = 0.5

				arg_298_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_298_1.var_.characterEffect10069ui_story.fillRatio = var_301_5
			end

			local var_301_6 = 0
			local var_301_7 = 1.375

			if var_301_6 < arg_298_1.time_ and arg_298_1.time_ <= var_301_6 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_8 = arg_298_1:GetWordFromCfg(319451072)
				local var_301_9 = arg_298_1:FormatText(var_301_8.content)

				arg_298_1.text_.text = var_301_9

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_10 = 55
				local var_301_11 = utf8.len(var_301_9)
				local var_301_12 = var_301_10 <= 0 and var_301_7 or var_301_7 * (var_301_11 / var_301_10)

				if var_301_12 > 0 and var_301_7 < var_301_12 then
					arg_298_1.talkMaxDuration = var_301_12

					if var_301_12 + var_301_6 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_12 + var_301_6
					end
				end

				arg_298_1.text_.text = var_301_9
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_13 = math.max(var_301_7, arg_298_1.talkMaxDuration)

			if var_301_6 <= arg_298_1.time_ and arg_298_1.time_ < var_301_6 + var_301_13 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_6) / var_301_13

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_6 + var_301_13 and arg_298_1.time_ < var_301_6 + var_301_13 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play319451073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 319451073
		arg_302_1.duration_ = 6.87

		local var_302_0 = {
			zh = 2.766,
			ja = 6.866
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play319451074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["10069ui_story"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect10069ui_story == nil then
				arg_302_1.var_.characterEffect10069ui_story = var_305_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.characterEffect10069ui_story and not isNil(var_305_0) then
					arg_302_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect10069ui_story then
				arg_302_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_305_4 = 0
			local var_305_5 = 0.325

			if var_305_4 < arg_302_1.time_ and arg_302_1.time_ <= var_305_4 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_6 = arg_302_1:FormatText(StoryNameCfg[693].name)

				arg_302_1.leftNameTxt_.text = var_305_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_7 = arg_302_1:GetWordFromCfg(319451073)
				local var_305_8 = arg_302_1:FormatText(var_305_7.content)

				arg_302_1.text_.text = var_305_8

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_9 = 13
				local var_305_10 = utf8.len(var_305_8)
				local var_305_11 = var_305_9 <= 0 and var_305_5 or var_305_5 * (var_305_10 / var_305_9)

				if var_305_11 > 0 and var_305_5 < var_305_11 then
					arg_302_1.talkMaxDuration = var_305_11

					if var_305_11 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_11 + var_305_4
					end
				end

				arg_302_1.text_.text = var_305_8
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451073", "story_v_out_319451.awb") ~= 0 then
					local var_305_12 = manager.audio:GetVoiceLength("story_v_out_319451", "319451073", "story_v_out_319451.awb") / 1000

					if var_305_12 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_12 + var_305_4
					end

					if var_305_7.prefab_name ~= "" and arg_302_1.actors_[var_305_7.prefab_name] ~= nil then
						local var_305_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_7.prefab_name].transform, "story_v_out_319451", "319451073", "story_v_out_319451.awb")

						arg_302_1:RecordAudio("319451073", var_305_13)
						arg_302_1:RecordAudio("319451073", var_305_13)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_319451", "319451073", "story_v_out_319451.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_319451", "319451073", "story_v_out_319451.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_14 = math.max(var_305_5, arg_302_1.talkMaxDuration)

			if var_305_4 <= arg_302_1.time_ and arg_302_1.time_ < var_305_4 + var_305_14 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_4) / var_305_14

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_4 + var_305_14 and arg_302_1.time_ < var_305_4 + var_305_14 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play319451074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 319451074
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play319451075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 0.275

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_2 = arg_306_1:FormatText(StoryNameCfg[698].name)

				arg_306_1.leftNameTxt_.text = var_309_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_3 = arg_306_1:GetWordFromCfg(319451074)
				local var_309_4 = arg_306_1:FormatText(var_309_3.content)

				arg_306_1.text_.text = var_309_4

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 11
				local var_309_6 = utf8.len(var_309_4)
				local var_309_7 = var_309_5 <= 0 and var_309_1 or var_309_1 * (var_309_6 / var_309_5)

				if var_309_7 > 0 and var_309_1 < var_309_7 then
					arg_306_1.talkMaxDuration = var_309_7

					if var_309_7 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_7 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_4
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_8 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_8 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_8

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_8 and arg_306_1.time_ < var_309_0 + var_309_8 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play319451075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 319451075
		arg_310_1.duration_ = 4.5

		local var_310_0 = {
			zh = 3.6,
			ja = 4.5
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play319451076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["10069ui_story"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect10069ui_story == nil then
				arg_310_1.var_.characterEffect10069ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.characterEffect10069ui_story and not isNil(var_313_0) then
					arg_310_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect10069ui_story then
				arg_310_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_313_4 = 0
			local var_313_5 = 0.45

			if var_313_4 < arg_310_1.time_ and arg_310_1.time_ <= var_313_4 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_6 = arg_310_1:FormatText(StoryNameCfg[693].name)

				arg_310_1.leftNameTxt_.text = var_313_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_7 = arg_310_1:GetWordFromCfg(319451075)
				local var_313_8 = arg_310_1:FormatText(var_313_7.content)

				arg_310_1.text_.text = var_313_8

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_9 = 18
				local var_313_10 = utf8.len(var_313_8)
				local var_313_11 = var_313_9 <= 0 and var_313_5 or var_313_5 * (var_313_10 / var_313_9)

				if var_313_11 > 0 and var_313_5 < var_313_11 then
					arg_310_1.talkMaxDuration = var_313_11

					if var_313_11 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_11 + var_313_4
					end
				end

				arg_310_1.text_.text = var_313_8
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451075", "story_v_out_319451.awb") ~= 0 then
					local var_313_12 = manager.audio:GetVoiceLength("story_v_out_319451", "319451075", "story_v_out_319451.awb") / 1000

					if var_313_12 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_12 + var_313_4
					end

					if var_313_7.prefab_name ~= "" and arg_310_1.actors_[var_313_7.prefab_name] ~= nil then
						local var_313_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_7.prefab_name].transform, "story_v_out_319451", "319451075", "story_v_out_319451.awb")

						arg_310_1:RecordAudio("319451075", var_313_13)
						arg_310_1:RecordAudio("319451075", var_313_13)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_319451", "319451075", "story_v_out_319451.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_319451", "319451075", "story_v_out_319451.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_14 = math.max(var_313_5, arg_310_1.talkMaxDuration)

			if var_313_4 <= arg_310_1.time_ and arg_310_1.time_ < var_313_4 + var_313_14 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_4) / var_313_14

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_4 + var_313_14 and arg_310_1.time_ < var_313_4 + var_313_14 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play319451076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 319451076
		arg_314_1.duration_ = 12.3

		local var_314_0 = {
			zh = 9.533,
			ja = 12.3
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play319451077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action6_1")
			end

			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_317_2 = 0
			local var_317_3 = 1.075

			if var_317_2 < arg_314_1.time_ and arg_314_1.time_ <= var_317_2 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_4 = arg_314_1:FormatText(StoryNameCfg[693].name)

				arg_314_1.leftNameTxt_.text = var_317_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_5 = arg_314_1:GetWordFromCfg(319451076)
				local var_317_6 = arg_314_1:FormatText(var_317_5.content)

				arg_314_1.text_.text = var_317_6

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_7 = 43
				local var_317_8 = utf8.len(var_317_6)
				local var_317_9 = var_317_7 <= 0 and var_317_3 or var_317_3 * (var_317_8 / var_317_7)

				if var_317_9 > 0 and var_317_3 < var_317_9 then
					arg_314_1.talkMaxDuration = var_317_9

					if var_317_9 + var_317_2 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_9 + var_317_2
					end
				end

				arg_314_1.text_.text = var_317_6
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451076", "story_v_out_319451.awb") ~= 0 then
					local var_317_10 = manager.audio:GetVoiceLength("story_v_out_319451", "319451076", "story_v_out_319451.awb") / 1000

					if var_317_10 + var_317_2 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_10 + var_317_2
					end

					if var_317_5.prefab_name ~= "" and arg_314_1.actors_[var_317_5.prefab_name] ~= nil then
						local var_317_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_5.prefab_name].transform, "story_v_out_319451", "319451076", "story_v_out_319451.awb")

						arg_314_1:RecordAudio("319451076", var_317_11)
						arg_314_1:RecordAudio("319451076", var_317_11)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_319451", "319451076", "story_v_out_319451.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_319451", "319451076", "story_v_out_319451.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_12 = math.max(var_317_3, arg_314_1.talkMaxDuration)

			if var_317_2 <= arg_314_1.time_ and arg_314_1.time_ < var_317_2 + var_317_12 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_2) / var_317_12

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_2 + var_317_12 and arg_314_1.time_ < var_317_2 + var_317_12 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play319451077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 319451077
		arg_318_1.duration_ = 15.4

		local var_318_0 = {
			zh = 6.7,
			ja = 15.4
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play319451078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 0.875

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_2 = arg_318_1:FormatText(StoryNameCfg[693].name)

				arg_318_1.leftNameTxt_.text = var_321_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_3 = arg_318_1:GetWordFromCfg(319451077)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 35
				local var_321_6 = utf8.len(var_321_4)
				local var_321_7 = var_321_5 <= 0 and var_321_1 or var_321_1 * (var_321_6 / var_321_5)

				if var_321_7 > 0 and var_321_1 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_4
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451077", "story_v_out_319451.awb") ~= 0 then
					local var_321_8 = manager.audio:GetVoiceLength("story_v_out_319451", "319451077", "story_v_out_319451.awb") / 1000

					if var_321_8 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_8 + var_321_0
					end

					if var_321_3.prefab_name ~= "" and arg_318_1.actors_[var_321_3.prefab_name] ~= nil then
						local var_321_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_3.prefab_name].transform, "story_v_out_319451", "319451077", "story_v_out_319451.awb")

						arg_318_1:RecordAudio("319451077", var_321_9)
						arg_318_1:RecordAudio("319451077", var_321_9)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_319451", "319451077", "story_v_out_319451.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_319451", "319451077", "story_v_out_319451.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_10 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_10 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_10

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_10 and arg_318_1.time_ < var_321_0 + var_321_10 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play319451078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 319451078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play319451079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["10069ui_story"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect10069ui_story == nil then
				arg_322_1.var_.characterEffect10069ui_story = var_325_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.200000002980232

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.characterEffect10069ui_story and not isNil(var_325_0) then
					local var_325_4 = Mathf.Lerp(0, 0.5, var_325_3)

					arg_322_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_322_1.var_.characterEffect10069ui_story.fillRatio = var_325_4
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect10069ui_story then
				local var_325_5 = 0.5

				arg_322_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_322_1.var_.characterEffect10069ui_story.fillRatio = var_325_5
			end

			local var_325_6 = 0
			local var_325_7 = 0.2

			if var_325_6 < arg_322_1.time_ and arg_322_1.time_ <= var_325_6 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_8 = arg_322_1:FormatText(StoryNameCfg[698].name)

				arg_322_1.leftNameTxt_.text = var_325_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_9 = arg_322_1:GetWordFromCfg(319451078)
				local var_325_10 = arg_322_1:FormatText(var_325_9.content)

				arg_322_1.text_.text = var_325_10

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_11 = 8
				local var_325_12 = utf8.len(var_325_10)
				local var_325_13 = var_325_11 <= 0 and var_325_7 or var_325_7 * (var_325_12 / var_325_11)

				if var_325_13 > 0 and var_325_7 < var_325_13 then
					arg_322_1.talkMaxDuration = var_325_13

					if var_325_13 + var_325_6 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_13 + var_325_6
					end
				end

				arg_322_1.text_.text = var_325_10
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_14 = math.max(var_325_7, arg_322_1.talkMaxDuration)

			if var_325_6 <= arg_322_1.time_ and arg_322_1.time_ < var_325_6 + var_325_14 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_6) / var_325_14

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_6 + var_325_14 and arg_322_1.time_ < var_325_6 + var_325_14 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play319451079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 319451079
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play319451080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				arg_326_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_329_2 = 0
			local var_329_3 = 0.15

			if var_329_2 < arg_326_1.time_ and arg_326_1.time_ <= var_329_2 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_4 = arg_326_1:GetWordFromCfg(319451079)
				local var_329_5 = arg_326_1:FormatText(var_329_4.content)

				arg_326_1.text_.text = var_329_5

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_6 = 6
				local var_329_7 = utf8.len(var_329_5)
				local var_329_8 = var_329_6 <= 0 and var_329_3 or var_329_3 * (var_329_7 / var_329_6)

				if var_329_8 > 0 and var_329_3 < var_329_8 then
					arg_326_1.talkMaxDuration = var_329_8

					if var_329_8 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_2
					end
				end

				arg_326_1.text_.text = var_329_5
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_9 = math.max(var_329_3, arg_326_1.talkMaxDuration)

			if var_329_2 <= arg_326_1.time_ and arg_326_1.time_ < var_329_2 + var_329_9 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_2) / var_329_9

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_2 + var_329_9 and arg_326_1.time_ < var_329_2 + var_329_9 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play319451080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 319451080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play319451081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["1084ui_story"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect1084ui_story == nil then
				arg_330_1.var_.characterEffect1084ui_story = var_333_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.characterEffect1084ui_story and not isNil(var_333_0) then
					local var_333_4 = Mathf.Lerp(0, 0.5, var_333_3)

					arg_330_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1084ui_story.fillRatio = var_333_4
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect1084ui_story then
				local var_333_5 = 0.5

				arg_330_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1084ui_story.fillRatio = var_333_5
			end

			local var_333_6 = 0
			local var_333_7 = 0.1

			if var_333_6 < arg_330_1.time_ and arg_330_1.time_ <= var_333_6 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_8 = arg_330_1:FormatText(StoryNameCfg[698].name)

				arg_330_1.leftNameTxt_.text = var_333_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_9 = arg_330_1:GetWordFromCfg(319451080)
				local var_333_10 = arg_330_1:FormatText(var_333_9.content)

				arg_330_1.text_.text = var_333_10

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_11 = 4
				local var_333_12 = utf8.len(var_333_10)
				local var_333_13 = var_333_11 <= 0 and var_333_7 or var_333_7 * (var_333_12 / var_333_11)

				if var_333_13 > 0 and var_333_7 < var_333_13 then
					arg_330_1.talkMaxDuration = var_333_13

					if var_333_13 + var_333_6 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_13 + var_333_6
					end
				end

				arg_330_1.text_.text = var_333_10
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_14 = math.max(var_333_7, arg_330_1.talkMaxDuration)

			if var_333_6 <= arg_330_1.time_ and arg_330_1.time_ < var_333_6 + var_333_14 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_6) / var_333_14

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_6 + var_333_14 and arg_330_1.time_ < var_333_6 + var_333_14 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play319451081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 319451081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play319451082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["1084ui_story"]
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect1084ui_story == nil then
				arg_334_1.var_.characterEffect1084ui_story = var_337_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_2 = 0.200000002980232

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 and not isNil(var_337_0) then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2

				if arg_334_1.var_.characterEffect1084ui_story and not isNil(var_337_0) then
					arg_334_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect1084ui_story then
				arg_334_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_337_4 = 0

			if var_337_4 < arg_334_1.time_ and arg_334_1.time_ <= var_337_4 + arg_337_0 then
				arg_334_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action437")
			end

			local var_337_5 = 0

			if var_337_5 < arg_334_1.time_ and arg_334_1.time_ <= var_337_5 + arg_337_0 then
				arg_334_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_337_6 = 0
			local var_337_7 = 0.775

			if var_337_6 < arg_334_1.time_ and arg_334_1.time_ <= var_337_6 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_8 = arg_334_1:GetWordFromCfg(319451081)
				local var_337_9 = arg_334_1:FormatText(var_337_8.content)

				arg_334_1.text_.text = var_337_9

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_10 = 31
				local var_337_11 = utf8.len(var_337_9)
				local var_337_12 = var_337_10 <= 0 and var_337_7 or var_337_7 * (var_337_11 / var_337_10)

				if var_337_12 > 0 and var_337_7 < var_337_12 then
					arg_334_1.talkMaxDuration = var_337_12

					if var_337_12 + var_337_6 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_12 + var_337_6
					end
				end

				arg_334_1.text_.text = var_337_9
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_13 = math.max(var_337_7, arg_334_1.talkMaxDuration)

			if var_337_6 <= arg_334_1.time_ and arg_334_1.time_ < var_337_6 + var_337_13 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_6) / var_337_13

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_6 + var_337_13 and arg_334_1.time_ < var_337_6 + var_337_13 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play319451082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 319451082
		arg_338_1.duration_ = 8.03

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play319451083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1084ui_story"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1084ui_story == nil then
				arg_338_1.var_.characterEffect1084ui_story = var_341_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.characterEffect1084ui_story and not isNil(var_341_0) then
					local var_341_4 = Mathf.Lerp(0, 0.5, var_341_3)

					arg_338_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_338_1.var_.characterEffect1084ui_story.fillRatio = var_341_4
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1084ui_story then
				local var_341_5 = 0.5

				arg_338_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_338_1.var_.characterEffect1084ui_story.fillRatio = var_341_5
			end

			local var_341_6 = 2

			if var_341_6 < arg_338_1.time_ and arg_338_1.time_ <= var_341_6 + arg_341_0 then
				local var_341_7 = manager.ui.mainCamera.transform.localPosition
				local var_341_8 = Vector3.New(0, 0, 10) + Vector3.New(var_341_7.x, var_341_7.y, 0)
				local var_341_9 = arg_338_1.bgs_.ST07a

				var_341_9.transform.localPosition = var_341_8
				var_341_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_341_10 = var_341_9:GetComponent("SpriteRenderer")

				if var_341_10 and var_341_10.sprite then
					local var_341_11 = (var_341_9.transform.localPosition - var_341_7).z
					local var_341_12 = manager.ui.mainCameraCom_
					local var_341_13 = 2 * var_341_11 * Mathf.Tan(var_341_12.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_341_14 = var_341_13 * var_341_12.aspect
					local var_341_15 = var_341_10.sprite.bounds.size.x
					local var_341_16 = var_341_10.sprite.bounds.size.y
					local var_341_17 = var_341_14 / var_341_15
					local var_341_18 = var_341_13 / var_341_16
					local var_341_19 = var_341_18 < var_341_17 and var_341_17 or var_341_18

					var_341_9.transform.localScale = Vector3.New(var_341_19, var_341_19, 0)
				end

				for iter_341_0, iter_341_1 in pairs(arg_338_1.bgs_) do
					if iter_341_0 ~= "ST07a" then
						iter_341_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_341_20 = 0

			if var_341_20 < arg_338_1.time_ and arg_338_1.time_ <= var_341_20 + arg_341_0 then
				arg_338_1.mask_.enabled = true
				arg_338_1.mask_.raycastTarget = true

				arg_338_1:SetGaussion(false)
			end

			local var_341_21 = 2

			if var_341_20 <= arg_338_1.time_ and arg_338_1.time_ < var_341_20 + var_341_21 then
				local var_341_22 = (arg_338_1.time_ - var_341_20) / var_341_21
				local var_341_23 = Color.New(0, 0, 0)

				var_341_23.a = Mathf.Lerp(0, 1, var_341_22)
				arg_338_1.mask_.color = var_341_23
			end

			if arg_338_1.time_ >= var_341_20 + var_341_21 and arg_338_1.time_ < var_341_20 + var_341_21 + arg_341_0 then
				local var_341_24 = Color.New(0, 0, 0)

				var_341_24.a = 1
				arg_338_1.mask_.color = var_341_24
			end

			local var_341_25 = 2

			if var_341_25 < arg_338_1.time_ and arg_338_1.time_ <= var_341_25 + arg_341_0 then
				arg_338_1.mask_.enabled = true
				arg_338_1.mask_.raycastTarget = true

				arg_338_1:SetGaussion(false)
			end

			local var_341_26 = 1.03333333333333

			if var_341_25 <= arg_338_1.time_ and arg_338_1.time_ < var_341_25 + var_341_26 then
				local var_341_27 = (arg_338_1.time_ - var_341_25) / var_341_26
				local var_341_28 = Color.New(0, 0, 0)

				var_341_28.a = Mathf.Lerp(1, 0, var_341_27)
				arg_338_1.mask_.color = var_341_28
			end

			if arg_338_1.time_ >= var_341_25 + var_341_26 and arg_338_1.time_ < var_341_25 + var_341_26 + arg_341_0 then
				local var_341_29 = Color.New(0, 0, 0)
				local var_341_30 = 0

				arg_338_1.mask_.enabled = false
				var_341_29.a = var_341_30
				arg_338_1.mask_.color = var_341_29
			end

			local var_341_31 = arg_338_1.actors_["1084ui_story"].transform
			local var_341_32 = 2

			if var_341_32 < arg_338_1.time_ and arg_338_1.time_ <= var_341_32 + arg_341_0 then
				arg_338_1.var_.moveOldPos1084ui_story = var_341_31.localPosition
			end

			local var_341_33 = 0.001

			if var_341_32 <= arg_338_1.time_ and arg_338_1.time_ < var_341_32 + var_341_33 then
				local var_341_34 = (arg_338_1.time_ - var_341_32) / var_341_33
				local var_341_35 = Vector3.New(0, 100, 0)

				var_341_31.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1084ui_story, var_341_35, var_341_34)

				local var_341_36 = manager.ui.mainCamera.transform.position - var_341_31.position

				var_341_31.forward = Vector3.New(var_341_36.x, var_341_36.y, var_341_36.z)

				local var_341_37 = var_341_31.localEulerAngles

				var_341_37.z = 0
				var_341_37.x = 0
				var_341_31.localEulerAngles = var_341_37
			end

			if arg_338_1.time_ >= var_341_32 + var_341_33 and arg_338_1.time_ < var_341_32 + var_341_33 + arg_341_0 then
				var_341_31.localPosition = Vector3.New(0, 100, 0)

				local var_341_38 = manager.ui.mainCamera.transform.position - var_341_31.position

				var_341_31.forward = Vector3.New(var_341_38.x, var_341_38.y, var_341_38.z)

				local var_341_39 = var_341_31.localEulerAngles

				var_341_39.z = 0
				var_341_39.x = 0
				var_341_31.localEulerAngles = var_341_39
			end

			local var_341_40 = arg_338_1.actors_["10069ui_story"].transform
			local var_341_41 = 2

			if var_341_41 < arg_338_1.time_ and arg_338_1.time_ <= var_341_41 + arg_341_0 then
				arg_338_1.var_.moveOldPos10069ui_story = var_341_40.localPosition
			end

			local var_341_42 = 0.001

			if var_341_41 <= arg_338_1.time_ and arg_338_1.time_ < var_341_41 + var_341_42 then
				local var_341_43 = (arg_338_1.time_ - var_341_41) / var_341_42
				local var_341_44 = Vector3.New(0, 100, 0)

				var_341_40.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10069ui_story, var_341_44, var_341_43)

				local var_341_45 = manager.ui.mainCamera.transform.position - var_341_40.position

				var_341_40.forward = Vector3.New(var_341_45.x, var_341_45.y, var_341_45.z)

				local var_341_46 = var_341_40.localEulerAngles

				var_341_46.z = 0
				var_341_46.x = 0
				var_341_40.localEulerAngles = var_341_46
			end

			if arg_338_1.time_ >= var_341_41 + var_341_42 and arg_338_1.time_ < var_341_41 + var_341_42 + arg_341_0 then
				var_341_40.localPosition = Vector3.New(0, 100, 0)

				local var_341_47 = manager.ui.mainCamera.transform.position - var_341_40.position

				var_341_40.forward = Vector3.New(var_341_47.x, var_341_47.y, var_341_47.z)

				local var_341_48 = var_341_40.localEulerAngles

				var_341_48.z = 0
				var_341_48.x = 0
				var_341_40.localEulerAngles = var_341_48
			end

			if arg_338_1.frameCnt_ <= 1 then
				arg_338_1.dialog_:SetActive(false)
			end

			local var_341_49 = 3.03333333333333
			local var_341_50 = 0.575

			if var_341_49 < arg_338_1.time_ and arg_338_1.time_ <= var_341_49 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0

				arg_338_1.dialog_:SetActive(true)

				arg_338_1.dialogCg_.alpha = 0

				local var_341_51 = LeanTween.value(arg_338_1.dialog_, 0, 1, 0.3)

				var_341_51:setOnUpdate(LuaHelper.FloatAction(function(arg_342_0)
					arg_338_1.dialogCg_.alpha = arg_342_0
				end))
				var_341_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_338_1.dialog_)
					var_341_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_338_1.duration_ = arg_338_1.duration_ + 0.3

				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_52 = arg_338_1:FormatText(StoryNameCfg[698].name)

				arg_338_1.leftNameTxt_.text = var_341_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_53 = arg_338_1:GetWordFromCfg(319451082)
				local var_341_54 = arg_338_1:FormatText(var_341_53.content)

				arg_338_1.text_.text = var_341_54

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_55 = 23
				local var_341_56 = utf8.len(var_341_54)
				local var_341_57 = var_341_55 <= 0 and var_341_50 or var_341_50 * (var_341_56 / var_341_55)

				if var_341_57 > 0 and var_341_50 < var_341_57 then
					arg_338_1.talkMaxDuration = var_341_57
					var_341_49 = var_341_49 + 0.3

					if var_341_57 + var_341_49 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_57 + var_341_49
					end
				end

				arg_338_1.text_.text = var_341_54
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_58 = var_341_49 + 0.3
			local var_341_59 = math.max(var_341_50, arg_338_1.talkMaxDuration)

			if var_341_58 <= arg_338_1.time_ and arg_338_1.time_ < var_341_58 + var_341_59 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_58) / var_341_59

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_58 + var_341_59 and arg_338_1.time_ < var_341_58 + var_341_59 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play319451083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 319451083
		arg_344_1.duration_ = 13.7

		local var_344_0 = {
			zh = 7.8,
			ja = 13.7
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play319451084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1084ui_story"].transform
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.var_.moveOldPos1084ui_story = var_347_0.localPosition
			end

			local var_347_2 = 0.001

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2
				local var_347_4 = Vector3.New(0, -0.97, -6)

				var_347_0.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos1084ui_story, var_347_4, var_347_3)

				local var_347_5 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_5.x, var_347_5.y, var_347_5.z)

				local var_347_6 = var_347_0.localEulerAngles

				var_347_6.z = 0
				var_347_6.x = 0
				var_347_0.localEulerAngles = var_347_6
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 then
				var_347_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_347_7 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_7.x, var_347_7.y, var_347_7.z)

				local var_347_8 = var_347_0.localEulerAngles

				var_347_8.z = 0
				var_347_8.x = 0
				var_347_0.localEulerAngles = var_347_8
			end

			local var_347_9 = arg_344_1.actors_["1084ui_story"]
			local var_347_10 = 0

			if var_347_10 < arg_344_1.time_ and arg_344_1.time_ <= var_347_10 + arg_347_0 and not isNil(var_347_9) and arg_344_1.var_.characterEffect1084ui_story == nil then
				arg_344_1.var_.characterEffect1084ui_story = var_347_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_11 = 0.200000002980232

			if var_347_10 <= arg_344_1.time_ and arg_344_1.time_ < var_347_10 + var_347_11 and not isNil(var_347_9) then
				local var_347_12 = (arg_344_1.time_ - var_347_10) / var_347_11

				if arg_344_1.var_.characterEffect1084ui_story and not isNil(var_347_9) then
					arg_344_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= var_347_10 + var_347_11 and arg_344_1.time_ < var_347_10 + var_347_11 + arg_347_0 and not isNil(var_347_9) and arg_344_1.var_.characterEffect1084ui_story then
				arg_344_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_347_13 = 0

			if var_347_13 < arg_344_1.time_ and arg_344_1.time_ <= var_347_13 + arg_347_0 then
				arg_344_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_347_14 = 0

			if var_347_14 < arg_344_1.time_ and arg_344_1.time_ <= var_347_14 + arg_347_0 then
				arg_344_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_347_15 = 0
			local var_347_16 = 0.8

			if var_347_15 < arg_344_1.time_ and arg_344_1.time_ <= var_347_15 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_17 = arg_344_1:FormatText(StoryNameCfg[6].name)

				arg_344_1.leftNameTxt_.text = var_347_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_18 = arg_344_1:GetWordFromCfg(319451083)
				local var_347_19 = arg_344_1:FormatText(var_347_18.content)

				arg_344_1.text_.text = var_347_19

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_20 = 32
				local var_347_21 = utf8.len(var_347_19)
				local var_347_22 = var_347_20 <= 0 and var_347_16 or var_347_16 * (var_347_21 / var_347_20)

				if var_347_22 > 0 and var_347_16 < var_347_22 then
					arg_344_1.talkMaxDuration = var_347_22

					if var_347_22 + var_347_15 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_22 + var_347_15
					end
				end

				arg_344_1.text_.text = var_347_19
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451083", "story_v_out_319451.awb") ~= 0 then
					local var_347_23 = manager.audio:GetVoiceLength("story_v_out_319451", "319451083", "story_v_out_319451.awb") / 1000

					if var_347_23 + var_347_15 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_23 + var_347_15
					end

					if var_347_18.prefab_name ~= "" and arg_344_1.actors_[var_347_18.prefab_name] ~= nil then
						local var_347_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_18.prefab_name].transform, "story_v_out_319451", "319451083", "story_v_out_319451.awb")

						arg_344_1:RecordAudio("319451083", var_347_24)
						arg_344_1:RecordAudio("319451083", var_347_24)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_319451", "319451083", "story_v_out_319451.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_319451", "319451083", "story_v_out_319451.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_25 = math.max(var_347_16, arg_344_1.talkMaxDuration)

			if var_347_15 <= arg_344_1.time_ and arg_344_1.time_ < var_347_15 + var_347_25 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_15) / var_347_25

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_15 + var_347_25 and arg_344_1.time_ < var_347_15 + var_347_25 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play319451084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 319451084
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play319451085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1084ui_story"]
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect1084ui_story == nil then
				arg_348_1.var_.characterEffect1084ui_story = var_351_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_2 = 0.200000002980232

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 and not isNil(var_351_0) then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2

				if arg_348_1.var_.characterEffect1084ui_story and not isNil(var_351_0) then
					local var_351_4 = Mathf.Lerp(0, 0.5, var_351_3)

					arg_348_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_348_1.var_.characterEffect1084ui_story.fillRatio = var_351_4
				end
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect1084ui_story then
				local var_351_5 = 0.5

				arg_348_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_348_1.var_.characterEffect1084ui_story.fillRatio = var_351_5
			end

			local var_351_6 = 0
			local var_351_7 = 0.35

			if var_351_6 < arg_348_1.time_ and arg_348_1.time_ <= var_351_6 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_8 = arg_348_1:FormatText(StoryNameCfg[698].name)

				arg_348_1.leftNameTxt_.text = var_351_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_9 = arg_348_1:GetWordFromCfg(319451084)
				local var_351_10 = arg_348_1:FormatText(var_351_9.content)

				arg_348_1.text_.text = var_351_10

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_11 = 14
				local var_351_12 = utf8.len(var_351_10)
				local var_351_13 = var_351_11 <= 0 and var_351_7 or var_351_7 * (var_351_12 / var_351_11)

				if var_351_13 > 0 and var_351_7 < var_351_13 then
					arg_348_1.talkMaxDuration = var_351_13

					if var_351_13 + var_351_6 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_13 + var_351_6
					end
				end

				arg_348_1.text_.text = var_351_10
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_14 = math.max(var_351_7, arg_348_1.talkMaxDuration)

			if var_351_6 <= arg_348_1.time_ and arg_348_1.time_ < var_351_6 + var_351_14 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_6) / var_351_14

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_6 + var_351_14 and arg_348_1.time_ < var_351_6 + var_351_14 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play319451085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 319451085
		arg_352_1.duration_ = 5.6

		local var_352_0 = {
			zh = 3.1,
			ja = 5.6
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play319451086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1084ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1084ui_story == nil then
				arg_352_1.var_.characterEffect1084ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect1084ui_story and not isNil(var_355_0) then
					arg_352_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1084ui_story then
				arg_352_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_355_4 = 0

			if var_355_4 < arg_352_1.time_ and arg_352_1.time_ <= var_355_4 + arg_355_0 then
				arg_352_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_355_5 = 0

			if var_355_5 < arg_352_1.time_ and arg_352_1.time_ <= var_355_5 + arg_355_0 then
				arg_352_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_355_6 = 0
			local var_355_7 = 0.375

			if var_355_6 < arg_352_1.time_ and arg_352_1.time_ <= var_355_6 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_8 = arg_352_1:FormatText(StoryNameCfg[6].name)

				arg_352_1.leftNameTxt_.text = var_355_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_9 = arg_352_1:GetWordFromCfg(319451085)
				local var_355_10 = arg_352_1:FormatText(var_355_9.content)

				arg_352_1.text_.text = var_355_10

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_11 = 15
				local var_355_12 = utf8.len(var_355_10)
				local var_355_13 = var_355_11 <= 0 and var_355_7 or var_355_7 * (var_355_12 / var_355_11)

				if var_355_13 > 0 and var_355_7 < var_355_13 then
					arg_352_1.talkMaxDuration = var_355_13

					if var_355_13 + var_355_6 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_13 + var_355_6
					end
				end

				arg_352_1.text_.text = var_355_10
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451085", "story_v_out_319451.awb") ~= 0 then
					local var_355_14 = manager.audio:GetVoiceLength("story_v_out_319451", "319451085", "story_v_out_319451.awb") / 1000

					if var_355_14 + var_355_6 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_14 + var_355_6
					end

					if var_355_9.prefab_name ~= "" and arg_352_1.actors_[var_355_9.prefab_name] ~= nil then
						local var_355_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_9.prefab_name].transform, "story_v_out_319451", "319451085", "story_v_out_319451.awb")

						arg_352_1:RecordAudio("319451085", var_355_15)
						arg_352_1:RecordAudio("319451085", var_355_15)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_319451", "319451085", "story_v_out_319451.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_319451", "319451085", "story_v_out_319451.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_16 = math.max(var_355_7, arg_352_1.talkMaxDuration)

			if var_355_6 <= arg_352_1.time_ and arg_352_1.time_ < var_355_6 + var_355_16 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_6) / var_355_16

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_6 + var_355_16 and arg_352_1.time_ < var_355_6 + var_355_16 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play319451086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 319451086
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play319451087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["1084ui_story"]
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect1084ui_story == nil then
				arg_356_1.var_.characterEffect1084ui_story = var_359_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.200000002980232

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 and not isNil(var_359_0) then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2

				if arg_356_1.var_.characterEffect1084ui_story and not isNil(var_359_0) then
					local var_359_4 = Mathf.Lerp(0, 0.5, var_359_3)

					arg_356_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_356_1.var_.characterEffect1084ui_story.fillRatio = var_359_4
				end
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect1084ui_story then
				local var_359_5 = 0.5

				arg_356_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_356_1.var_.characterEffect1084ui_story.fillRatio = var_359_5
			end

			local var_359_6 = 0
			local var_359_7 = 1.525

			if var_359_6 < arg_356_1.time_ and arg_356_1.time_ <= var_359_6 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_8 = arg_356_1:GetWordFromCfg(319451086)
				local var_359_9 = arg_356_1:FormatText(var_359_8.content)

				arg_356_1.text_.text = var_359_9

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_10 = 61
				local var_359_11 = utf8.len(var_359_9)
				local var_359_12 = var_359_10 <= 0 and var_359_7 or var_359_7 * (var_359_11 / var_359_10)

				if var_359_12 > 0 and var_359_7 < var_359_12 then
					arg_356_1.talkMaxDuration = var_359_12

					if var_359_12 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_12 + var_359_6
					end
				end

				arg_356_1.text_.text = var_359_9
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_13 = math.max(var_359_7, arg_356_1.talkMaxDuration)

			if var_359_6 <= arg_356_1.time_ and arg_356_1.time_ < var_359_6 + var_359_13 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_6) / var_359_13

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_6 + var_359_13 and arg_356_1.time_ < var_359_6 + var_359_13 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play319451087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 319451087
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play319451088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 1.1

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_2 = arg_360_1:GetWordFromCfg(319451087)
				local var_363_3 = arg_360_1:FormatText(var_363_2.content)

				arg_360_1.text_.text = var_363_3

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_4 = 44
				local var_363_5 = utf8.len(var_363_3)
				local var_363_6 = var_363_4 <= 0 and var_363_1 or var_363_1 * (var_363_5 / var_363_4)

				if var_363_6 > 0 and var_363_1 < var_363_6 then
					arg_360_1.talkMaxDuration = var_363_6

					if var_363_6 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_6 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_3
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_7 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_7 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_7

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_7 and arg_360_1.time_ < var_363_0 + var_363_7 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play319451088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 319451088
		arg_364_1.duration_ = 6.17

		local var_364_0 = {
			zh = 2.733,
			ja = 6.166
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play319451089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 0.3

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_2 = arg_364_1:FormatText(StoryNameCfg[693].name)

				arg_364_1.leftNameTxt_.text = var_367_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10069")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_3 = arg_364_1:GetWordFromCfg(319451088)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 12
				local var_367_6 = utf8.len(var_367_4)
				local var_367_7 = var_367_5 <= 0 and var_367_1 or var_367_1 * (var_367_6 / var_367_5)

				if var_367_7 > 0 and var_367_1 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451088", "story_v_out_319451.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_out_319451", "319451088", "story_v_out_319451.awb") / 1000

					if var_367_8 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_0
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_out_319451", "319451088", "story_v_out_319451.awb")

						arg_364_1:RecordAudio("319451088", var_367_9)
						arg_364_1:RecordAudio("319451088", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_319451", "319451088", "story_v_out_319451.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_319451", "319451088", "story_v_out_319451.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_10 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_10

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_10 and arg_364_1.time_ < var_367_0 + var_367_10 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play319451089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 319451089
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play319451090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["10069ui_story"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect10069ui_story == nil then
				arg_368_1.var_.characterEffect10069ui_story = var_371_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.characterEffect10069ui_story and not isNil(var_371_0) then
					local var_371_4 = Mathf.Lerp(0, 0.5, var_371_3)

					arg_368_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_368_1.var_.characterEffect10069ui_story.fillRatio = var_371_4
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect10069ui_story then
				local var_371_5 = 0.5

				arg_368_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_368_1.var_.characterEffect10069ui_story.fillRatio = var_371_5
			end

			local var_371_6 = 0
			local var_371_7 = 0.35

			if var_371_6 < arg_368_1.time_ and arg_368_1.time_ <= var_371_6 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_8 = arg_368_1:FormatText(StoryNameCfg[698].name)

				arg_368_1.leftNameTxt_.text = var_371_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_9 = arg_368_1:GetWordFromCfg(319451089)
				local var_371_10 = arg_368_1:FormatText(var_371_9.content)

				arg_368_1.text_.text = var_371_10

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_11 = 14
				local var_371_12 = utf8.len(var_371_10)
				local var_371_13 = var_371_11 <= 0 and var_371_7 or var_371_7 * (var_371_12 / var_371_11)

				if var_371_13 > 0 and var_371_7 < var_371_13 then
					arg_368_1.talkMaxDuration = var_371_13

					if var_371_13 + var_371_6 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_13 + var_371_6
					end
				end

				arg_368_1.text_.text = var_371_10
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_14 = math.max(var_371_7, arg_368_1.talkMaxDuration)

			if var_371_6 <= arg_368_1.time_ and arg_368_1.time_ < var_371_6 + var_371_14 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_6) / var_371_14

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_6 + var_371_14 and arg_368_1.time_ < var_371_6 + var_371_14 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play319451090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 319451090
		arg_372_1.duration_ = 8.1

		local var_372_0 = {
			zh = 4.6,
			ja = 8.1
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play319451091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["10069ui_story"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect10069ui_story == nil then
				arg_372_1.var_.characterEffect10069ui_story = var_375_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.200000002980232

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.characterEffect10069ui_story and not isNil(var_375_0) then
					arg_372_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect10069ui_story then
				arg_372_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_375_4 = 0
			local var_375_5 = 0.525

			if var_375_4 < arg_372_1.time_ and arg_372_1.time_ <= var_375_4 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_6 = arg_372_1:FormatText(StoryNameCfg[693].name)

				arg_372_1.leftNameTxt_.text = var_375_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10069")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_7 = arg_372_1:GetWordFromCfg(319451090)
				local var_375_8 = arg_372_1:FormatText(var_375_7.content)

				arg_372_1.text_.text = var_375_8

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_9 = 21
				local var_375_10 = utf8.len(var_375_8)
				local var_375_11 = var_375_9 <= 0 and var_375_5 or var_375_5 * (var_375_10 / var_375_9)

				if var_375_11 > 0 and var_375_5 < var_375_11 then
					arg_372_1.talkMaxDuration = var_375_11

					if var_375_11 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_11 + var_375_4
					end
				end

				arg_372_1.text_.text = var_375_8
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451090", "story_v_out_319451.awb") ~= 0 then
					local var_375_12 = manager.audio:GetVoiceLength("story_v_out_319451", "319451090", "story_v_out_319451.awb") / 1000

					if var_375_12 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_12 + var_375_4
					end

					if var_375_7.prefab_name ~= "" and arg_372_1.actors_[var_375_7.prefab_name] ~= nil then
						local var_375_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_7.prefab_name].transform, "story_v_out_319451", "319451090", "story_v_out_319451.awb")

						arg_372_1:RecordAudio("319451090", var_375_13)
						arg_372_1:RecordAudio("319451090", var_375_13)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_319451", "319451090", "story_v_out_319451.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_319451", "319451090", "story_v_out_319451.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_14 = math.max(var_375_5, arg_372_1.talkMaxDuration)

			if var_375_4 <= arg_372_1.time_ and arg_372_1.time_ < var_375_4 + var_375_14 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_4) / var_375_14

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_4 + var_375_14 and arg_372_1.time_ < var_375_4 + var_375_14 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play319451091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 319451091
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play319451092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["10069ui_story"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect10069ui_story == nil then
				arg_376_1.var_.characterEffect10069ui_story = var_379_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.200000002980232

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.characterEffect10069ui_story and not isNil(var_379_0) then
					local var_379_4 = Mathf.Lerp(0, 0.5, var_379_3)

					arg_376_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_376_1.var_.characterEffect10069ui_story.fillRatio = var_379_4
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect10069ui_story then
				local var_379_5 = 0.5

				arg_376_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_376_1.var_.characterEffect10069ui_story.fillRatio = var_379_5
			end

			local var_379_6 = 0

			if var_379_6 < arg_376_1.time_ and arg_376_1.time_ <= var_379_6 + arg_379_0 then
				arg_376_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_379_7 = 0
			local var_379_8 = 1.175

			if var_379_7 < arg_376_1.time_ and arg_376_1.time_ <= var_379_7 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_9 = arg_376_1:GetWordFromCfg(319451091)
				local var_379_10 = arg_376_1:FormatText(var_379_9.content)

				arg_376_1.text_.text = var_379_10

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_11 = 47
				local var_379_12 = utf8.len(var_379_10)
				local var_379_13 = var_379_11 <= 0 and var_379_8 or var_379_8 * (var_379_12 / var_379_11)

				if var_379_13 > 0 and var_379_8 < var_379_13 then
					arg_376_1.talkMaxDuration = var_379_13

					if var_379_13 + var_379_7 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_13 + var_379_7
					end
				end

				arg_376_1.text_.text = var_379_10
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_14 = math.max(var_379_8, arg_376_1.talkMaxDuration)

			if var_379_7 <= arg_376_1.time_ and arg_376_1.time_ < var_379_7 + var_379_14 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_7) / var_379_14

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_7 + var_379_14 and arg_376_1.time_ < var_379_7 + var_379_14 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play319451092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 319451092
		arg_380_1.duration_ = 7.8

		local var_380_0 = {
			zh = 2.966,
			ja = 7.8
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play319451093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["1084ui_story"]
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect1084ui_story == nil then
				arg_380_1.var_.characterEffect1084ui_story = var_383_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_2 = 0.200000002980232

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 and not isNil(var_383_0) then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2

				if arg_380_1.var_.characterEffect1084ui_story and not isNil(var_383_0) then
					arg_380_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect1084ui_story then
				arg_380_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_383_4 = 0

			if var_383_4 < arg_380_1.time_ and arg_380_1.time_ <= var_383_4 + arg_383_0 then
				arg_380_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_383_5 = 0

			if var_383_5 < arg_380_1.time_ and arg_380_1.time_ <= var_383_5 + arg_383_0 then
				arg_380_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_383_6 = 0
			local var_383_7 = 0.35

			if var_383_6 < arg_380_1.time_ and arg_380_1.time_ <= var_383_6 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_8 = arg_380_1:FormatText(StoryNameCfg[6].name)

				arg_380_1.leftNameTxt_.text = var_383_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_9 = arg_380_1:GetWordFromCfg(319451092)
				local var_383_10 = arg_380_1:FormatText(var_383_9.content)

				arg_380_1.text_.text = var_383_10

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_11 = 14
				local var_383_12 = utf8.len(var_383_10)
				local var_383_13 = var_383_11 <= 0 and var_383_7 or var_383_7 * (var_383_12 / var_383_11)

				if var_383_13 > 0 and var_383_7 < var_383_13 then
					arg_380_1.talkMaxDuration = var_383_13

					if var_383_13 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_13 + var_383_6
					end
				end

				arg_380_1.text_.text = var_383_10
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451092", "story_v_out_319451.awb") ~= 0 then
					local var_383_14 = manager.audio:GetVoiceLength("story_v_out_319451", "319451092", "story_v_out_319451.awb") / 1000

					if var_383_14 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_14 + var_383_6
					end

					if var_383_9.prefab_name ~= "" and arg_380_1.actors_[var_383_9.prefab_name] ~= nil then
						local var_383_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_9.prefab_name].transform, "story_v_out_319451", "319451092", "story_v_out_319451.awb")

						arg_380_1:RecordAudio("319451092", var_383_15)
						arg_380_1:RecordAudio("319451092", var_383_15)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_319451", "319451092", "story_v_out_319451.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_319451", "319451092", "story_v_out_319451.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_16 = math.max(var_383_7, arg_380_1.talkMaxDuration)

			if var_383_6 <= arg_380_1.time_ and arg_380_1.time_ < var_383_6 + var_383_16 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_6) / var_383_16

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_6 + var_383_16 and arg_380_1.time_ < var_383_6 + var_383_16 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play319451093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 319451093
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play319451094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["1084ui_story"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect1084ui_story == nil then
				arg_384_1.var_.characterEffect1084ui_story = var_387_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.200000002980232

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.characterEffect1084ui_story and not isNil(var_387_0) then
					local var_387_4 = Mathf.Lerp(0, 0.5, var_387_3)

					arg_384_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_384_1.var_.characterEffect1084ui_story.fillRatio = var_387_4
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect1084ui_story then
				local var_387_5 = 0.5

				arg_384_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_384_1.var_.characterEffect1084ui_story.fillRatio = var_387_5
			end

			local var_387_6 = 0
			local var_387_7 = 0.3

			if var_387_6 < arg_384_1.time_ and arg_384_1.time_ <= var_387_6 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_8 = arg_384_1:FormatText(StoryNameCfg[698].name)

				arg_384_1.leftNameTxt_.text = var_387_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_9 = arg_384_1:GetWordFromCfg(319451093)
				local var_387_10 = arg_384_1:FormatText(var_387_9.content)

				arg_384_1.text_.text = var_387_10

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_11 = 12
				local var_387_12 = utf8.len(var_387_10)
				local var_387_13 = var_387_11 <= 0 and var_387_7 or var_387_7 * (var_387_12 / var_387_11)

				if var_387_13 > 0 and var_387_7 < var_387_13 then
					arg_384_1.talkMaxDuration = var_387_13

					if var_387_13 + var_387_6 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_13 + var_387_6
					end
				end

				arg_384_1.text_.text = var_387_10
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_14 = math.max(var_387_7, arg_384_1.talkMaxDuration)

			if var_387_6 <= arg_384_1.time_ and arg_384_1.time_ < var_387_6 + var_387_14 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_6) / var_387_14

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_6 + var_387_14 and arg_384_1.time_ < var_387_6 + var_387_14 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play319451094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 319451094
		arg_388_1.duration_ = 2

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play319451095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1084ui_story"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1084ui_story == nil then
				arg_388_1.var_.characterEffect1084ui_story = var_391_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.200000002980232

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.characterEffect1084ui_story and not isNil(var_391_0) then
					arg_388_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1084ui_story then
				arg_388_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_391_4 = 0

			if var_391_4 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_391_5 = 0

			if var_391_5 < arg_388_1.time_ and arg_388_1.time_ <= var_391_5 + arg_391_0 then
				arg_388_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_391_6 = 0
			local var_391_7 = 0.225

			if var_391_6 < arg_388_1.time_ and arg_388_1.time_ <= var_391_6 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_8 = arg_388_1:FormatText(StoryNameCfg[6].name)

				arg_388_1.leftNameTxt_.text = var_391_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_9 = arg_388_1:GetWordFromCfg(319451094)
				local var_391_10 = arg_388_1:FormatText(var_391_9.content)

				arg_388_1.text_.text = var_391_10

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_11 = 9
				local var_391_12 = utf8.len(var_391_10)
				local var_391_13 = var_391_11 <= 0 and var_391_7 or var_391_7 * (var_391_12 / var_391_11)

				if var_391_13 > 0 and var_391_7 < var_391_13 then
					arg_388_1.talkMaxDuration = var_391_13

					if var_391_13 + var_391_6 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_13 + var_391_6
					end
				end

				arg_388_1.text_.text = var_391_10
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451094", "story_v_out_319451.awb") ~= 0 then
					local var_391_14 = manager.audio:GetVoiceLength("story_v_out_319451", "319451094", "story_v_out_319451.awb") / 1000

					if var_391_14 + var_391_6 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_14 + var_391_6
					end

					if var_391_9.prefab_name ~= "" and arg_388_1.actors_[var_391_9.prefab_name] ~= nil then
						local var_391_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_9.prefab_name].transform, "story_v_out_319451", "319451094", "story_v_out_319451.awb")

						arg_388_1:RecordAudio("319451094", var_391_15)
						arg_388_1:RecordAudio("319451094", var_391_15)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_319451", "319451094", "story_v_out_319451.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_319451", "319451094", "story_v_out_319451.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_16 = math.max(var_391_7, arg_388_1.talkMaxDuration)

			if var_391_6 <= arg_388_1.time_ and arg_388_1.time_ < var_391_6 + var_391_16 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_6) / var_391_16

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_6 + var_391_16 and arg_388_1.time_ < var_391_6 + var_391_16 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play319451095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 319451095
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play319451096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1084ui_story"]
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1084ui_story == nil then
				arg_392_1.var_.characterEffect1084ui_story = var_395_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_2 = 0.200000002980232

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 and not isNil(var_395_0) then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2

				if arg_392_1.var_.characterEffect1084ui_story and not isNil(var_395_0) then
					local var_395_4 = Mathf.Lerp(0, 0.5, var_395_3)

					arg_392_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_392_1.var_.characterEffect1084ui_story.fillRatio = var_395_4
				end
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1084ui_story then
				local var_395_5 = 0.5

				arg_392_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_392_1.var_.characterEffect1084ui_story.fillRatio = var_395_5
			end

			local var_395_6 = 0
			local var_395_7 = 0.525

			if var_395_6 < arg_392_1.time_ and arg_392_1.time_ <= var_395_6 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_8 = arg_392_1:FormatText(StoryNameCfg[698].name)

				arg_392_1.leftNameTxt_.text = var_395_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_9 = arg_392_1:GetWordFromCfg(319451095)
				local var_395_10 = arg_392_1:FormatText(var_395_9.content)

				arg_392_1.text_.text = var_395_10

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_11 = 21
				local var_395_12 = utf8.len(var_395_10)
				local var_395_13 = var_395_11 <= 0 and var_395_7 or var_395_7 * (var_395_12 / var_395_11)

				if var_395_13 > 0 and var_395_7 < var_395_13 then
					arg_392_1.talkMaxDuration = var_395_13

					if var_395_13 + var_395_6 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_13 + var_395_6
					end
				end

				arg_392_1.text_.text = var_395_10
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_14 = math.max(var_395_7, arg_392_1.talkMaxDuration)

			if var_395_6 <= arg_392_1.time_ and arg_392_1.time_ < var_395_6 + var_395_14 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_6) / var_395_14

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_6 + var_395_14 and arg_392_1.time_ < var_395_6 + var_395_14 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play319451096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 319451096
		arg_396_1.duration_ = 8.27

		local var_396_0 = {
			zh = 8.266,
			ja = 6.1
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play319451097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["1084ui_story"].transform
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.var_.moveOldPos1084ui_story = var_399_0.localPosition
			end

			local var_399_2 = 0.001

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2
				local var_399_4 = Vector3.New(0, -0.97, -6)

				var_399_0.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1084ui_story, var_399_4, var_399_3)

				local var_399_5 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_5.x, var_399_5.y, var_399_5.z)

				local var_399_6 = var_399_0.localEulerAngles

				var_399_6.z = 0
				var_399_6.x = 0
				var_399_0.localEulerAngles = var_399_6
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 then
				var_399_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_399_7 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_7.x, var_399_7.y, var_399_7.z)

				local var_399_8 = var_399_0.localEulerAngles

				var_399_8.z = 0
				var_399_8.x = 0
				var_399_0.localEulerAngles = var_399_8
			end

			local var_399_9 = arg_396_1.actors_["1084ui_story"]
			local var_399_10 = 0

			if var_399_10 < arg_396_1.time_ and arg_396_1.time_ <= var_399_10 + arg_399_0 and not isNil(var_399_9) and arg_396_1.var_.characterEffect1084ui_story == nil then
				arg_396_1.var_.characterEffect1084ui_story = var_399_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_11 = 0.200000002980232

			if var_399_10 <= arg_396_1.time_ and arg_396_1.time_ < var_399_10 + var_399_11 and not isNil(var_399_9) then
				local var_399_12 = (arg_396_1.time_ - var_399_10) / var_399_11

				if arg_396_1.var_.characterEffect1084ui_story and not isNil(var_399_9) then
					arg_396_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= var_399_10 + var_399_11 and arg_396_1.time_ < var_399_10 + var_399_11 + arg_399_0 and not isNil(var_399_9) and arg_396_1.var_.characterEffect1084ui_story then
				arg_396_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_399_13 = 0

			if var_399_13 < arg_396_1.time_ and arg_396_1.time_ <= var_399_13 + arg_399_0 then
				arg_396_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_399_14 = 0
			local var_399_15 = 1

			if var_399_14 < arg_396_1.time_ and arg_396_1.time_ <= var_399_14 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_16 = arg_396_1:FormatText(StoryNameCfg[6].name)

				arg_396_1.leftNameTxt_.text = var_399_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_17 = arg_396_1:GetWordFromCfg(319451096)
				local var_399_18 = arg_396_1:FormatText(var_399_17.content)

				arg_396_1.text_.text = var_399_18

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_19 = 40
				local var_399_20 = utf8.len(var_399_18)
				local var_399_21 = var_399_19 <= 0 and var_399_15 or var_399_15 * (var_399_20 / var_399_19)

				if var_399_21 > 0 and var_399_15 < var_399_21 then
					arg_396_1.talkMaxDuration = var_399_21

					if var_399_21 + var_399_14 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_21 + var_399_14
					end
				end

				arg_396_1.text_.text = var_399_18
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451096", "story_v_out_319451.awb") ~= 0 then
					local var_399_22 = manager.audio:GetVoiceLength("story_v_out_319451", "319451096", "story_v_out_319451.awb") / 1000

					if var_399_22 + var_399_14 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_22 + var_399_14
					end

					if var_399_17.prefab_name ~= "" and arg_396_1.actors_[var_399_17.prefab_name] ~= nil then
						local var_399_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_17.prefab_name].transform, "story_v_out_319451", "319451096", "story_v_out_319451.awb")

						arg_396_1:RecordAudio("319451096", var_399_23)
						arg_396_1:RecordAudio("319451096", var_399_23)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_319451", "319451096", "story_v_out_319451.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_319451", "319451096", "story_v_out_319451.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_24 = math.max(var_399_15, arg_396_1.talkMaxDuration)

			if var_399_14 <= arg_396_1.time_ and arg_396_1.time_ < var_399_14 + var_399_24 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_14) / var_399_24

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_14 + var_399_24 and arg_396_1.time_ < var_399_14 + var_399_24 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play319451097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 319451097
		arg_400_1.duration_ = 14.63

		local var_400_0 = {
			zh = 5.433,
			ja = 14.633
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play319451098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 then
				arg_400_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_403_2 = 0
			local var_403_3 = 0.775

			if var_403_2 < arg_400_1.time_ and arg_400_1.time_ <= var_403_2 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_4 = arg_400_1:FormatText(StoryNameCfg[6].name)

				arg_400_1.leftNameTxt_.text = var_403_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_5 = arg_400_1:GetWordFromCfg(319451097)
				local var_403_6 = arg_400_1:FormatText(var_403_5.content)

				arg_400_1.text_.text = var_403_6

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_7 = 31
				local var_403_8 = utf8.len(var_403_6)
				local var_403_9 = var_403_7 <= 0 and var_403_3 or var_403_3 * (var_403_8 / var_403_7)

				if var_403_9 > 0 and var_403_3 < var_403_9 then
					arg_400_1.talkMaxDuration = var_403_9

					if var_403_9 + var_403_2 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_9 + var_403_2
					end
				end

				arg_400_1.text_.text = var_403_6
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451097", "story_v_out_319451.awb") ~= 0 then
					local var_403_10 = manager.audio:GetVoiceLength("story_v_out_319451", "319451097", "story_v_out_319451.awb") / 1000

					if var_403_10 + var_403_2 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_10 + var_403_2
					end

					if var_403_5.prefab_name ~= "" and arg_400_1.actors_[var_403_5.prefab_name] ~= nil then
						local var_403_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_5.prefab_name].transform, "story_v_out_319451", "319451097", "story_v_out_319451.awb")

						arg_400_1:RecordAudio("319451097", var_403_11)
						arg_400_1:RecordAudio("319451097", var_403_11)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_319451", "319451097", "story_v_out_319451.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_319451", "319451097", "story_v_out_319451.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_12 = math.max(var_403_3, arg_400_1.talkMaxDuration)

			if var_403_2 <= arg_400_1.time_ and arg_400_1.time_ < var_403_2 + var_403_12 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_2) / var_403_12

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_2 + var_403_12 and arg_400_1.time_ < var_403_2 + var_403_12 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play319451098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 319451098
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play319451099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["10069ui_story"].transform
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 then
				arg_404_1.var_.moveOldPos10069ui_story = var_407_0.localPosition
			end

			local var_407_2 = 0.001

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2
				local var_407_4 = Vector3.New(0, 100, 0)

				var_407_0.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos10069ui_story, var_407_4, var_407_3)

				local var_407_5 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_5.x, var_407_5.y, var_407_5.z)

				local var_407_6 = var_407_0.localEulerAngles

				var_407_6.z = 0
				var_407_6.x = 0
				var_407_0.localEulerAngles = var_407_6
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 then
				var_407_0.localPosition = Vector3.New(0, 100, 0)

				local var_407_7 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_7.x, var_407_7.y, var_407_7.z)

				local var_407_8 = var_407_0.localEulerAngles

				var_407_8.z = 0
				var_407_8.x = 0
				var_407_0.localEulerAngles = var_407_8
			end

			local var_407_9 = arg_404_1.actors_["10069ui_story"]
			local var_407_10 = 0

			if var_407_10 < arg_404_1.time_ and arg_404_1.time_ <= var_407_10 + arg_407_0 and not isNil(var_407_9) and arg_404_1.var_.characterEffect10069ui_story == nil then
				arg_404_1.var_.characterEffect10069ui_story = var_407_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_11 = 0.200000002980232

			if var_407_10 <= arg_404_1.time_ and arg_404_1.time_ < var_407_10 + var_407_11 and not isNil(var_407_9) then
				local var_407_12 = (arg_404_1.time_ - var_407_10) / var_407_11

				if arg_404_1.var_.characterEffect10069ui_story and not isNil(var_407_9) then
					local var_407_13 = Mathf.Lerp(0, 0.5, var_407_12)

					arg_404_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_404_1.var_.characterEffect10069ui_story.fillRatio = var_407_13
				end
			end

			if arg_404_1.time_ >= var_407_10 + var_407_11 and arg_404_1.time_ < var_407_10 + var_407_11 + arg_407_0 and not isNil(var_407_9) and arg_404_1.var_.characterEffect10069ui_story then
				local var_407_14 = 0.5

				arg_404_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_404_1.var_.characterEffect10069ui_story.fillRatio = var_407_14
			end

			local var_407_15 = arg_404_1.actors_["1084ui_story"].transform
			local var_407_16 = 0

			if var_407_16 < arg_404_1.time_ and arg_404_1.time_ <= var_407_16 + arg_407_0 then
				arg_404_1.var_.moveOldPos1084ui_story = var_407_15.localPosition
			end

			local var_407_17 = 0.001

			if var_407_16 <= arg_404_1.time_ and arg_404_1.time_ < var_407_16 + var_407_17 then
				local var_407_18 = (arg_404_1.time_ - var_407_16) / var_407_17
				local var_407_19 = Vector3.New(0, 100, 0)

				var_407_15.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1084ui_story, var_407_19, var_407_18)

				local var_407_20 = manager.ui.mainCamera.transform.position - var_407_15.position

				var_407_15.forward = Vector3.New(var_407_20.x, var_407_20.y, var_407_20.z)

				local var_407_21 = var_407_15.localEulerAngles

				var_407_21.z = 0
				var_407_21.x = 0
				var_407_15.localEulerAngles = var_407_21
			end

			if arg_404_1.time_ >= var_407_16 + var_407_17 and arg_404_1.time_ < var_407_16 + var_407_17 + arg_407_0 then
				var_407_15.localPosition = Vector3.New(0, 100, 0)

				local var_407_22 = manager.ui.mainCamera.transform.position - var_407_15.position

				var_407_15.forward = Vector3.New(var_407_22.x, var_407_22.y, var_407_22.z)

				local var_407_23 = var_407_15.localEulerAngles

				var_407_23.z = 0
				var_407_23.x = 0
				var_407_15.localEulerAngles = var_407_23
			end

			local var_407_24 = arg_404_1.actors_["1084ui_story"]
			local var_407_25 = 0

			if var_407_25 < arg_404_1.time_ and arg_404_1.time_ <= var_407_25 + arg_407_0 and not isNil(var_407_24) and arg_404_1.var_.characterEffect1084ui_story == nil then
				arg_404_1.var_.characterEffect1084ui_story = var_407_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_26 = 0.200000002980232

			if var_407_25 <= arg_404_1.time_ and arg_404_1.time_ < var_407_25 + var_407_26 and not isNil(var_407_24) then
				local var_407_27 = (arg_404_1.time_ - var_407_25) / var_407_26

				if arg_404_1.var_.characterEffect1084ui_story and not isNil(var_407_24) then
					local var_407_28 = Mathf.Lerp(0, 0.5, var_407_27)

					arg_404_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1084ui_story.fillRatio = var_407_28
				end
			end

			if arg_404_1.time_ >= var_407_25 + var_407_26 and arg_404_1.time_ < var_407_25 + var_407_26 + arg_407_0 and not isNil(var_407_24) and arg_404_1.var_.characterEffect1084ui_story then
				local var_407_29 = 0.5

				arg_404_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1084ui_story.fillRatio = var_407_29
			end

			local var_407_30 = 0
			local var_407_31 = 0.85

			if var_407_30 < arg_404_1.time_ and arg_404_1.time_ <= var_407_30 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_32 = arg_404_1:GetWordFromCfg(319451098)
				local var_407_33 = arg_404_1:FormatText(var_407_32.content)

				arg_404_1.text_.text = var_407_33

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_34 = 34
				local var_407_35 = utf8.len(var_407_33)
				local var_407_36 = var_407_34 <= 0 and var_407_31 or var_407_31 * (var_407_35 / var_407_34)

				if var_407_36 > 0 and var_407_31 < var_407_36 then
					arg_404_1.talkMaxDuration = var_407_36

					if var_407_36 + var_407_30 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_36 + var_407_30
					end
				end

				arg_404_1.text_.text = var_407_33
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_37 = math.max(var_407_31, arg_404_1.talkMaxDuration)

			if var_407_30 <= arg_404_1.time_ and arg_404_1.time_ < var_407_30 + var_407_37 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_30) / var_407_37

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_30 + var_407_37 and arg_404_1.time_ < var_407_30 + var_407_37 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play319451099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 319451099
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play319451100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 0.325

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_2 = arg_408_1:FormatText(StoryNameCfg[698].name)

				arg_408_1.leftNameTxt_.text = var_411_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_3 = arg_408_1:GetWordFromCfg(319451099)
				local var_411_4 = arg_408_1:FormatText(var_411_3.content)

				arg_408_1.text_.text = var_411_4

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 13
				local var_411_6 = utf8.len(var_411_4)
				local var_411_7 = var_411_5 <= 0 and var_411_1 or var_411_1 * (var_411_6 / var_411_5)

				if var_411_7 > 0 and var_411_1 < var_411_7 then
					arg_408_1.talkMaxDuration = var_411_7

					if var_411_7 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_7 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_4
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_8 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_8 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_8

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_8 and arg_408_1.time_ < var_411_0 + var_411_8 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play319451100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 319451100
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play319451101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 1.35

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_2 = arg_412_1:GetWordFromCfg(319451100)
				local var_415_3 = arg_412_1:FormatText(var_415_2.content)

				arg_412_1.text_.text = var_415_3

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_4 = 54
				local var_415_5 = utf8.len(var_415_3)
				local var_415_6 = var_415_4 <= 0 and var_415_1 or var_415_1 * (var_415_5 / var_415_4)

				if var_415_6 > 0 and var_415_1 < var_415_6 then
					arg_412_1.talkMaxDuration = var_415_6

					if var_415_6 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_6 + var_415_0
					end
				end

				arg_412_1.text_.text = var_415_3
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_7 = math.max(var_415_1, arg_412_1.talkMaxDuration)

			if var_415_0 <= arg_412_1.time_ and arg_412_1.time_ < var_415_0 + var_415_7 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_0) / var_415_7

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_0 + var_415_7 and arg_412_1.time_ < var_415_0 + var_415_7 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play319451101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 319451101
		arg_416_1.duration_ = 5.5

		local var_416_0 = {
			zh = 2.166,
			ja = 5.5
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play319451102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["10069ui_story"]
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.characterEffect10069ui_story == nil then
				arg_416_1.var_.characterEffect10069ui_story = var_419_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_2 = 0.200000002980232

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 and not isNil(var_419_0) then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2

				if arg_416_1.var_.characterEffect10069ui_story and not isNil(var_419_0) then
					arg_416_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.characterEffect10069ui_story then
				arg_416_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_419_4 = arg_416_1.actors_["10069ui_story"].transform
			local var_419_5 = 0

			if var_419_5 < arg_416_1.time_ and arg_416_1.time_ <= var_419_5 + arg_419_0 then
				arg_416_1.var_.moveOldPos10069ui_story = var_419_4.localPosition
			end

			local var_419_6 = 0.001

			if var_419_5 <= arg_416_1.time_ and arg_416_1.time_ < var_419_5 + var_419_6 then
				local var_419_7 = (arg_416_1.time_ - var_419_5) / var_419_6
				local var_419_8 = Vector3.New(0, -1.08, -6.33)

				var_419_4.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos10069ui_story, var_419_8, var_419_7)

				local var_419_9 = manager.ui.mainCamera.transform.position - var_419_4.position

				var_419_4.forward = Vector3.New(var_419_9.x, var_419_9.y, var_419_9.z)

				local var_419_10 = var_419_4.localEulerAngles

				var_419_10.z = 0
				var_419_10.x = 0
				var_419_4.localEulerAngles = var_419_10
			end

			if arg_416_1.time_ >= var_419_5 + var_419_6 and arg_416_1.time_ < var_419_5 + var_419_6 + arg_419_0 then
				var_419_4.localPosition = Vector3.New(0, -1.08, -6.33)

				local var_419_11 = manager.ui.mainCamera.transform.position - var_419_4.position

				var_419_4.forward = Vector3.New(var_419_11.x, var_419_11.y, var_419_11.z)

				local var_419_12 = var_419_4.localEulerAngles

				var_419_12.z = 0
				var_419_12.x = 0
				var_419_4.localEulerAngles = var_419_12
			end

			local var_419_13 = 0

			if var_419_13 < arg_416_1.time_ and arg_416_1.time_ <= var_419_13 + arg_419_0 then
				arg_416_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_419_14 = 0

			if var_419_14 < arg_416_1.time_ and arg_416_1.time_ <= var_419_14 + arg_419_0 then
				arg_416_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_419_15 = 0
			local var_419_16 = 0.225

			if var_419_15 < arg_416_1.time_ and arg_416_1.time_ <= var_419_15 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_17 = arg_416_1:FormatText(StoryNameCfg[693].name)

				arg_416_1.leftNameTxt_.text = var_419_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_18 = arg_416_1:GetWordFromCfg(319451101)
				local var_419_19 = arg_416_1:FormatText(var_419_18.content)

				arg_416_1.text_.text = var_419_19

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_20 = 9
				local var_419_21 = utf8.len(var_419_19)
				local var_419_22 = var_419_20 <= 0 and var_419_16 or var_419_16 * (var_419_21 / var_419_20)

				if var_419_22 > 0 and var_419_16 < var_419_22 then
					arg_416_1.talkMaxDuration = var_419_22

					if var_419_22 + var_419_15 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_22 + var_419_15
					end
				end

				arg_416_1.text_.text = var_419_19
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451101", "story_v_out_319451.awb") ~= 0 then
					local var_419_23 = manager.audio:GetVoiceLength("story_v_out_319451", "319451101", "story_v_out_319451.awb") / 1000

					if var_419_23 + var_419_15 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_23 + var_419_15
					end

					if var_419_18.prefab_name ~= "" and arg_416_1.actors_[var_419_18.prefab_name] ~= nil then
						local var_419_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_18.prefab_name].transform, "story_v_out_319451", "319451101", "story_v_out_319451.awb")

						arg_416_1:RecordAudio("319451101", var_419_24)
						arg_416_1:RecordAudio("319451101", var_419_24)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_319451", "319451101", "story_v_out_319451.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_319451", "319451101", "story_v_out_319451.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_25 = math.max(var_419_16, arg_416_1.talkMaxDuration)

			if var_419_15 <= arg_416_1.time_ and arg_416_1.time_ < var_419_15 + var_419_25 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_15) / var_419_25

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_15 + var_419_25 and arg_416_1.time_ < var_419_15 + var_419_25 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_416_1:InitPlayNodeList()
	end,
	Play319451102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 319451102
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play319451103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["10069ui_story"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect10069ui_story == nil then
				arg_420_1.var_.characterEffect10069ui_story = var_423_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.characterEffect10069ui_story and not isNil(var_423_0) then
					local var_423_4 = Mathf.Lerp(0, 0.5, var_423_3)

					arg_420_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_420_1.var_.characterEffect10069ui_story.fillRatio = var_423_4
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect10069ui_story then
				local var_423_5 = 0.5

				arg_420_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_420_1.var_.characterEffect10069ui_story.fillRatio = var_423_5
			end

			local var_423_6 = 0
			local var_423_7 = 0.275

			if var_423_6 < arg_420_1.time_ and arg_420_1.time_ <= var_423_6 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_8 = arg_420_1:FormatText(StoryNameCfg[698].name)

				arg_420_1.leftNameTxt_.text = var_423_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, true)
				arg_420_1.iconController_:SetSelectedState("hero")

				arg_420_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_420_1.callingController_:SetSelectedState("normal")

				arg_420_1.keyicon_.color = Color.New(1, 1, 1)
				arg_420_1.icon_.color = Color.New(1, 1, 1)

				local var_423_9 = arg_420_1:GetWordFromCfg(319451102)
				local var_423_10 = arg_420_1:FormatText(var_423_9.content)

				arg_420_1.text_.text = var_423_10

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_11 = 11
				local var_423_12 = utf8.len(var_423_10)
				local var_423_13 = var_423_11 <= 0 and var_423_7 or var_423_7 * (var_423_12 / var_423_11)

				if var_423_13 > 0 and var_423_7 < var_423_13 then
					arg_420_1.talkMaxDuration = var_423_13

					if var_423_13 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_13 + var_423_6
					end
				end

				arg_420_1.text_.text = var_423_10
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_14 = math.max(var_423_7, arg_420_1.talkMaxDuration)

			if var_423_6 <= arg_420_1.time_ and arg_420_1.time_ < var_423_6 + var_423_14 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_6) / var_423_14

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_6 + var_423_14 and arg_420_1.time_ < var_423_6 + var_423_14 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play319451103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 319451103
		arg_424_1.duration_ = 14.4

		local var_424_0 = {
			zh = 6.333,
			ja = 14.4
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play319451104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["10069ui_story"]
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect10069ui_story == nil then
				arg_424_1.var_.characterEffect10069ui_story = var_427_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.200000002980232

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 and not isNil(var_427_0) then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2

				if arg_424_1.var_.characterEffect10069ui_story and not isNil(var_427_0) then
					arg_424_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect10069ui_story then
				arg_424_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_427_4 = 0

			if var_427_4 < arg_424_1.time_ and arg_424_1.time_ <= var_427_4 + arg_427_0 then
				arg_424_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10069/story10069action/10069action2_1")
			end

			local var_427_5 = 0
			local var_427_6 = 0.8

			if var_427_5 < arg_424_1.time_ and arg_424_1.time_ <= var_427_5 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_7 = arg_424_1:FormatText(StoryNameCfg[693].name)

				arg_424_1.leftNameTxt_.text = var_427_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_8 = arg_424_1:GetWordFromCfg(319451103)
				local var_427_9 = arg_424_1:FormatText(var_427_8.content)

				arg_424_1.text_.text = var_427_9

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_10 = 32
				local var_427_11 = utf8.len(var_427_9)
				local var_427_12 = var_427_10 <= 0 and var_427_6 or var_427_6 * (var_427_11 / var_427_10)

				if var_427_12 > 0 and var_427_6 < var_427_12 then
					arg_424_1.talkMaxDuration = var_427_12

					if var_427_12 + var_427_5 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_12 + var_427_5
					end
				end

				arg_424_1.text_.text = var_427_9
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451103", "story_v_out_319451.awb") ~= 0 then
					local var_427_13 = manager.audio:GetVoiceLength("story_v_out_319451", "319451103", "story_v_out_319451.awb") / 1000

					if var_427_13 + var_427_5 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_13 + var_427_5
					end

					if var_427_8.prefab_name ~= "" and arg_424_1.actors_[var_427_8.prefab_name] ~= nil then
						local var_427_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_8.prefab_name].transform, "story_v_out_319451", "319451103", "story_v_out_319451.awb")

						arg_424_1:RecordAudio("319451103", var_427_14)
						arg_424_1:RecordAudio("319451103", var_427_14)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_319451", "319451103", "story_v_out_319451.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_319451", "319451103", "story_v_out_319451.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_15 = math.max(var_427_6, arg_424_1.talkMaxDuration)

			if var_427_5 <= arg_424_1.time_ and arg_424_1.time_ < var_427_5 + var_427_15 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_5) / var_427_15

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_5 + var_427_15 and arg_424_1.time_ < var_427_5 + var_427_15 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play319451104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 319451104
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play319451105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["10069ui_story"]
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect10069ui_story == nil then
				arg_428_1.var_.characterEffect10069ui_story = var_431_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_2 = 0.200000002980232

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 and not isNil(var_431_0) then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2

				if arg_428_1.var_.characterEffect10069ui_story and not isNil(var_431_0) then
					local var_431_4 = Mathf.Lerp(0, 0.5, var_431_3)

					arg_428_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_428_1.var_.characterEffect10069ui_story.fillRatio = var_431_4
				end
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect10069ui_story then
				local var_431_5 = 0.5

				arg_428_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_428_1.var_.characterEffect10069ui_story.fillRatio = var_431_5
			end

			local var_431_6 = 0
			local var_431_7 = 0.375

			if var_431_6 < arg_428_1.time_ and arg_428_1.time_ <= var_431_6 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_8 = arg_428_1:FormatText(StoryNameCfg[698].name)

				arg_428_1.leftNameTxt_.text = var_431_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_9 = arg_428_1:GetWordFromCfg(319451104)
				local var_431_10 = arg_428_1:FormatText(var_431_9.content)

				arg_428_1.text_.text = var_431_10

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_11 = 15
				local var_431_12 = utf8.len(var_431_10)
				local var_431_13 = var_431_11 <= 0 and var_431_7 or var_431_7 * (var_431_12 / var_431_11)

				if var_431_13 > 0 and var_431_7 < var_431_13 then
					arg_428_1.talkMaxDuration = var_431_13

					if var_431_13 + var_431_6 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_13 + var_431_6
					end
				end

				arg_428_1.text_.text = var_431_10
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_14 = math.max(var_431_7, arg_428_1.talkMaxDuration)

			if var_431_6 <= arg_428_1.time_ and arg_428_1.time_ < var_431_6 + var_431_14 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_6) / var_431_14

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_6 + var_431_14 and arg_428_1.time_ < var_431_6 + var_431_14 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play319451105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 319451105
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play319451106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0
			local var_435_1 = 0.775

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_2 = arg_432_1:FormatText(StoryNameCfg[698].name)

				arg_432_1.leftNameTxt_.text = var_435_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_3 = arg_432_1:GetWordFromCfg(319451105)
				local var_435_4 = arg_432_1:FormatText(var_435_3.content)

				arg_432_1.text_.text = var_435_4

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_5 = 31
				local var_435_6 = utf8.len(var_435_4)
				local var_435_7 = var_435_5 <= 0 and var_435_1 or var_435_1 * (var_435_6 / var_435_5)

				if var_435_7 > 0 and var_435_1 < var_435_7 then
					arg_432_1.talkMaxDuration = var_435_7

					if var_435_7 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_7 + var_435_0
					end
				end

				arg_432_1.text_.text = var_435_4
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_8 = math.max(var_435_1, arg_432_1.talkMaxDuration)

			if var_435_0 <= arg_432_1.time_ and arg_432_1.time_ < var_435_0 + var_435_8 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_0) / var_435_8

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_0 + var_435_8 and arg_432_1.time_ < var_435_0 + var_435_8 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play319451106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 319451106
		arg_436_1.duration_ = 2.67

		local var_436_0 = {
			zh = 1.999999999999,
			ja = 2.666
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play319451107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["10069ui_story"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect10069ui_story == nil then
				arg_436_1.var_.characterEffect10069ui_story = var_439_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.200000002980232

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.characterEffect10069ui_story and not isNil(var_439_0) then
					arg_436_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect10069ui_story then
				arg_436_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_439_4 = 0

			if var_439_4 < arg_436_1.time_ and arg_436_1.time_ <= var_439_4 + arg_439_0 then
				arg_436_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10069/story10069actionlink/10069action423")
			end

			local var_439_5 = 0
			local var_439_6 = 0.175

			if var_439_5 < arg_436_1.time_ and arg_436_1.time_ <= var_439_5 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_7 = arg_436_1:FormatText(StoryNameCfg[693].name)

				arg_436_1.leftNameTxt_.text = var_439_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_8 = arg_436_1:GetWordFromCfg(319451106)
				local var_439_9 = arg_436_1:FormatText(var_439_8.content)

				arg_436_1.text_.text = var_439_9

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_10 = 7
				local var_439_11 = utf8.len(var_439_9)
				local var_439_12 = var_439_10 <= 0 and var_439_6 or var_439_6 * (var_439_11 / var_439_10)

				if var_439_12 > 0 and var_439_6 < var_439_12 then
					arg_436_1.talkMaxDuration = var_439_12

					if var_439_12 + var_439_5 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_12 + var_439_5
					end
				end

				arg_436_1.text_.text = var_439_9
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319451", "319451106", "story_v_out_319451.awb") ~= 0 then
					local var_439_13 = manager.audio:GetVoiceLength("story_v_out_319451", "319451106", "story_v_out_319451.awb") / 1000

					if var_439_13 + var_439_5 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_13 + var_439_5
					end

					if var_439_8.prefab_name ~= "" and arg_436_1.actors_[var_439_8.prefab_name] ~= nil then
						local var_439_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_8.prefab_name].transform, "story_v_out_319451", "319451106", "story_v_out_319451.awb")

						arg_436_1:RecordAudio("319451106", var_439_14)
						arg_436_1:RecordAudio("319451106", var_439_14)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_319451", "319451106", "story_v_out_319451.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_319451", "319451106", "story_v_out_319451.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_15 = math.max(var_439_6, arg_436_1.talkMaxDuration)

			if var_439_5 <= arg_436_1.time_ and arg_436_1.time_ < var_439_5 + var_439_15 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_5) / var_439_15

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_5 + var_439_15 and arg_436_1.time_ < var_439_5 + var_439_15 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play319451107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 319451107
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play319451108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["10069ui_story"]
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect10069ui_story == nil then
				arg_440_1.var_.characterEffect10069ui_story = var_443_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.200000002980232

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 and not isNil(var_443_0) then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2

				if arg_440_1.var_.characterEffect10069ui_story and not isNil(var_443_0) then
					local var_443_4 = Mathf.Lerp(0, 0.5, var_443_3)

					arg_440_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_440_1.var_.characterEffect10069ui_story.fillRatio = var_443_4
				end
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect10069ui_story then
				local var_443_5 = 0.5

				arg_440_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_440_1.var_.characterEffect10069ui_story.fillRatio = var_443_5
			end

			local var_443_6 = 0
			local var_443_7 = 1.025

			if var_443_6 < arg_440_1.time_ and arg_440_1.time_ <= var_443_6 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_8 = arg_440_1:FormatText(StoryNameCfg[698].name)

				arg_440_1.leftNameTxt_.text = var_443_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_9 = arg_440_1:GetWordFromCfg(319451107)
				local var_443_10 = arg_440_1:FormatText(var_443_9.content)

				arg_440_1.text_.text = var_443_10

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_11 = 41
				local var_443_12 = utf8.len(var_443_10)
				local var_443_13 = var_443_11 <= 0 and var_443_7 or var_443_7 * (var_443_12 / var_443_11)

				if var_443_13 > 0 and var_443_7 < var_443_13 then
					arg_440_1.talkMaxDuration = var_443_13

					if var_443_13 + var_443_6 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_13 + var_443_6
					end
				end

				arg_440_1.text_.text = var_443_10
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_14 = math.max(var_443_7, arg_440_1.talkMaxDuration)

			if var_443_6 <= arg_440_1.time_ and arg_440_1.time_ < var_443_6 + var_443_14 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_6) / var_443_14

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_6 + var_443_14 and arg_440_1.time_ < var_443_6 + var_443_14 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play319451108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 319451108
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play319451109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0
			local var_447_1 = 0.25

			if var_447_0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_2 = arg_444_1:FormatText(StoryNameCfg[698].name)

				arg_444_1.leftNameTxt_.text = var_447_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_3 = arg_444_1:GetWordFromCfg(319451108)
				local var_447_4 = arg_444_1:FormatText(var_447_3.content)

				arg_444_1.text_.text = var_447_4

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_5 = 10
				local var_447_6 = utf8.len(var_447_4)
				local var_447_7 = var_447_5 <= 0 and var_447_1 or var_447_1 * (var_447_6 / var_447_5)

				if var_447_7 > 0 and var_447_1 < var_447_7 then
					arg_444_1.talkMaxDuration = var_447_7

					if var_447_7 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_7 + var_447_0
					end
				end

				arg_444_1.text_.text = var_447_4
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_8 = math.max(var_447_1, arg_444_1.talkMaxDuration)

			if var_447_0 <= arg_444_1.time_ and arg_444_1.time_ < var_447_0 + var_447_8 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_0) / var_447_8

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_0 + var_447_8 and arg_444_1.time_ < var_447_0 + var_447_8 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play319451109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 319451109
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play319451110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["10069ui_story"].transform
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 then
				arg_448_1.var_.moveOldPos10069ui_story = var_451_0.localPosition
			end

			local var_451_2 = 0.001

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2
				local var_451_4 = Vector3.New(0, 100, 0)

				var_451_0.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos10069ui_story, var_451_4, var_451_3)

				local var_451_5 = manager.ui.mainCamera.transform.position - var_451_0.position

				var_451_0.forward = Vector3.New(var_451_5.x, var_451_5.y, var_451_5.z)

				local var_451_6 = var_451_0.localEulerAngles

				var_451_6.z = 0
				var_451_6.x = 0
				var_451_0.localEulerAngles = var_451_6
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 then
				var_451_0.localPosition = Vector3.New(0, 100, 0)

				local var_451_7 = manager.ui.mainCamera.transform.position - var_451_0.position

				var_451_0.forward = Vector3.New(var_451_7.x, var_451_7.y, var_451_7.z)

				local var_451_8 = var_451_0.localEulerAngles

				var_451_8.z = 0
				var_451_8.x = 0
				var_451_0.localEulerAngles = var_451_8
			end

			local var_451_9 = 0
			local var_451_10 = 0.65

			if var_451_9 < arg_448_1.time_ and arg_448_1.time_ <= var_451_9 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, false)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_11 = arg_448_1:GetWordFromCfg(319451109)
				local var_451_12 = arg_448_1:FormatText(var_451_11.content)

				arg_448_1.text_.text = var_451_12

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_13 = 26
				local var_451_14 = utf8.len(var_451_12)
				local var_451_15 = var_451_13 <= 0 and var_451_10 or var_451_10 * (var_451_14 / var_451_13)

				if var_451_15 > 0 and var_451_10 < var_451_15 then
					arg_448_1.talkMaxDuration = var_451_15

					if var_451_15 + var_451_9 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_15 + var_451_9
					end
				end

				arg_448_1.text_.text = var_451_12
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_16 = math.max(var_451_10, arg_448_1.talkMaxDuration)

			if var_451_9 <= arg_448_1.time_ and arg_448_1.time_ < var_451_9 + var_451_16 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_9) / var_451_16

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_9 + var_451_16 and arg_448_1.time_ < var_451_9 + var_451_16 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_448_1:InitPlayNodeList()
	end,
	Play319451110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 319451110
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
			arg_452_1.auto_ = false
		end

		function arg_452_1.playNext_(arg_454_0)
			arg_452_1.onStoryFinished_()
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0
			local var_455_1 = 0.15

			if var_455_0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_2 = arg_452_1:FormatText(StoryNameCfg[698].name)

				arg_452_1.leftNameTxt_.text = var_455_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_3 = arg_452_1:GetWordFromCfg(319451110)
				local var_455_4 = arg_452_1:FormatText(var_455_3.content)

				arg_452_1.text_.text = var_455_4

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_5 = 6
				local var_455_6 = utf8.len(var_455_4)
				local var_455_7 = var_455_5 <= 0 and var_455_1 or var_455_1 * (var_455_6 / var_455_5)

				if var_455_7 > 0 and var_455_1 < var_455_7 then
					arg_452_1.talkMaxDuration = var_455_7

					if var_455_7 + var_455_0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_7 + var_455_0
					end
				end

				arg_452_1.text_.text = var_455_4
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_8 = math.max(var_455_1, arg_452_1.talkMaxDuration)

			if var_455_0 <= arg_452_1.time_ and arg_452_1.time_ < var_455_0 + var_455_8 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_0) / var_455_8

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_0 + var_455_8 and arg_452_1.time_ < var_455_0 + var_455_8 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST07a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST71"
	},
	voices = {
		"story_v_out_319451.awb"
	}
}
