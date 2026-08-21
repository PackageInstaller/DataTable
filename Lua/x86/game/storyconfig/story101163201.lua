return {
	Play116321001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116321001
		arg_1_1.duration_ = 12.8

		local var_1_0 = {
			zh = 9.066,
			ja = 12.8
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
				arg_1_0:Play116321002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I07a"

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
				local var_4_5 = arg_1_1.bgs_.I07a

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
					if iter_4_0 ~= "I07a" then
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
			local var_4_23 = 0.666666666666667

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
			local var_4_29 = 0.875

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

				local var_4_31 = arg_1_1:FormatText(StoryNameCfg[337].name)

				arg_1_1.leftNameTxt_.text = var_4_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_32 = arg_1_1:GetWordFromCfg(116321001)
				local var_4_33 = arg_1_1:FormatText(var_4_32.content)

				arg_1_1.text_.text = var_4_33

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_34 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321001", "story_v_out_116321.awb") ~= 0 then
					local var_4_37 = manager.audio:GetVoiceLength("story_v_out_116321", "116321001", "story_v_out_116321.awb") / 1000

					if var_4_37 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_28
					end

					if var_4_32.prefab_name ~= "" and arg_1_1.actors_[var_4_32.prefab_name] ~= nil then
						local var_4_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_32.prefab_name].transform, "story_v_out_116321", "116321001", "story_v_out_116321.awb")

						arg_1_1:RecordAudio("116321001", var_4_38)
						arg_1_1:RecordAudio("116321001", var_4_38)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116321", "116321001", "story_v_out_116321.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116321", "116321001", "story_v_out_116321.awb")
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
	Play116321002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 116321002
		arg_8_1.duration_ = 5.97

		local var_8_0 = {
			zh = 4,
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
				arg_8_0:Play116321003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.266666666666667

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "music"

				arg_8_1:AudioAction(var_11_2, var_11_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_11_4 = ""
				local var_11_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_11_5 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_5 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_5

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_5
						arg_8_1.bgmTxt2_.text = var_11_5
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

			local var_11_6 = 0.4
			local var_11_7 = 0.6

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				local var_11_8 = "play"
				local var_11_9 = "music"

				arg_8_1:AudioAction(var_11_8, var_11_9, "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				local var_11_10 = ""

				if var_11_10 ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_10 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_10

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_10
						arg_8_1.bgmTxt2_.text = var_11_10
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

			local var_11_11 = 0.575
			local var_11_12 = 0.425

			if var_11_11 < arg_8_1.time_ and arg_8_1.time_ <= var_11_11 + arg_11_0 then
				local var_11_13 = "play"
				local var_11_14 = "music"

				arg_8_1:AudioAction(var_11_13, var_11_14, "bgm_activity_1_6_story_story", "corg", "bgm_activity_1_6_story_story.awb")

				local var_11_15 = ""
				local var_11_16 = MusicRecordCfg[96].musicName

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

			local var_11_17 = 0
			local var_11_18 = 0.45

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_19 = arg_8_1:FormatText(StoryNameCfg[337].name)

				arg_8_1.leftNameTxt_.text = var_11_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_20 = arg_8_1:GetWordFromCfg(116321002)
				local var_11_21 = arg_8_1:FormatText(var_11_20.content)

				arg_8_1.text_.text = var_11_21

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_22 = 18
				local var_11_23 = utf8.len(var_11_21)
				local var_11_24 = var_11_22 <= 0 and var_11_18 or var_11_18 * (var_11_23 / var_11_22)

				if var_11_24 > 0 and var_11_18 < var_11_24 then
					arg_8_1.talkMaxDuration = var_11_24

					if var_11_24 + var_11_17 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_24 + var_11_17
					end
				end

				arg_8_1.text_.text = var_11_21
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321002", "story_v_out_116321.awb") ~= 0 then
					local var_11_25 = manager.audio:GetVoiceLength("story_v_out_116321", "116321002", "story_v_out_116321.awb") / 1000

					if var_11_25 + var_11_17 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_25 + var_11_17
					end

					if var_11_20.prefab_name ~= "" and arg_8_1.actors_[var_11_20.prefab_name] ~= nil then
						local var_11_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_20.prefab_name].transform, "story_v_out_116321", "116321002", "story_v_out_116321.awb")

						arg_8_1:RecordAudio("116321002", var_11_26)
						arg_8_1:RecordAudio("116321002", var_11_26)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_116321", "116321002", "story_v_out_116321.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_116321", "116321002", "story_v_out_116321.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_27 = math.max(var_11_18, arg_8_1.talkMaxDuration)

			if var_11_17 <= arg_8_1.time_ and arg_8_1.time_ < var_11_17 + var_11_27 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_17) / var_11_27

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_17 + var_11_27 and arg_8_1.time_ < var_11_17 + var_11_27 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play116321003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 116321003
		arg_15_1.duration_ = 3.73

		local var_15_0 = {
			zh = 3.366,
			ja = 3.733
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play116321004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = "10032ui_story"

			if arg_15_1.actors_[var_18_0] == nil then
				local var_18_1 = Asset.Load("Char/" .. "10032ui_story")

				if not isNil(var_18_1) then
					local var_18_2 = Object.Instantiate(Asset.Load("Char/" .. "10032ui_story"), arg_15_1.stage_.transform)

					var_18_2.name = var_18_0
					var_18_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_15_1.actors_[var_18_0] = var_18_2

					local var_18_3 = var_18_2:GetComponentInChildren(typeof(CharacterEffect))

					var_18_3.enabled = true

					local var_18_4 = GameObjectTools.GetOrAddComponent(var_18_2, typeof(DynamicBoneHelper))

					if var_18_4 then
						var_18_4:EnableDynamicBone(false)
					end

					arg_15_1:ShowWeapon(var_18_3.transform, false)

					arg_15_1.var_[var_18_0 .. "Animator"] = var_18_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_15_1.var_[var_18_0 .. "Animator"].applyRootMotion = true
					arg_15_1.var_[var_18_0 .. "LipSync"] = var_18_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_18_5 = arg_15_1.actors_["10032ui_story"].transform
			local var_18_6 = 0

			if var_18_6 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1.var_.moveOldPos10032ui_story = var_18_5.localPosition
			end

			local var_18_7 = 0.001

			if var_18_6 <= arg_15_1.time_ and arg_15_1.time_ < var_18_6 + var_18_7 then
				local var_18_8 = (arg_15_1.time_ - var_18_6) / var_18_7
				local var_18_9 = Vector3.New(0, -1.1, -5.9)

				var_18_5.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos10032ui_story, var_18_9, var_18_8)

				local var_18_10 = manager.ui.mainCamera.transform.position - var_18_5.position

				var_18_5.forward = Vector3.New(var_18_10.x, var_18_10.y, var_18_10.z)

				local var_18_11 = var_18_5.localEulerAngles

				var_18_11.z = 0
				var_18_11.x = 0
				var_18_5.localEulerAngles = var_18_11
			end

			if arg_15_1.time_ >= var_18_6 + var_18_7 and arg_15_1.time_ < var_18_6 + var_18_7 + arg_18_0 then
				var_18_5.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_18_12 = manager.ui.mainCamera.transform.position - var_18_5.position

				var_18_5.forward = Vector3.New(var_18_12.x, var_18_12.y, var_18_12.z)

				local var_18_13 = var_18_5.localEulerAngles

				var_18_13.z = 0
				var_18_13.x = 0
				var_18_5.localEulerAngles = var_18_13
			end

			local var_18_14 = arg_15_1.actors_["10032ui_story"]
			local var_18_15 = 0

			if var_18_15 < arg_15_1.time_ and arg_15_1.time_ <= var_18_15 + arg_18_0 and not isNil(var_18_14) and arg_15_1.var_.characterEffect10032ui_story == nil then
				arg_15_1.var_.characterEffect10032ui_story = var_18_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_16 = 0.2

			if var_18_15 <= arg_15_1.time_ and arg_15_1.time_ < var_18_15 + var_18_16 and not isNil(var_18_14) then
				local var_18_17 = (arg_15_1.time_ - var_18_15) / var_18_16

				if arg_15_1.var_.characterEffect10032ui_story and not isNil(var_18_14) then
					arg_15_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_15 + var_18_16 and arg_15_1.time_ < var_18_15 + var_18_16 + arg_18_0 and not isNil(var_18_14) and arg_15_1.var_.characterEffect10032ui_story then
				arg_15_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_18_18 = 0

			if var_18_18 < arg_15_1.time_ and arg_15_1.time_ <= var_18_18 + arg_18_0 then
				arg_15_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_18_19 = 0

			if var_18_19 < arg_15_1.time_ and arg_15_1.time_ <= var_18_19 + arg_18_0 then
				arg_15_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_18_20 = 0
			local var_18_21 = 0.25

			if var_18_20 < arg_15_1.time_ and arg_15_1.time_ <= var_18_20 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_22 = arg_15_1:FormatText(StoryNameCfg[328].name)

				arg_15_1.leftNameTxt_.text = var_18_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_23 = arg_15_1:GetWordFromCfg(116321003)
				local var_18_24 = arg_15_1:FormatText(var_18_23.content)

				arg_15_1.text_.text = var_18_24

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_25 = 10
				local var_18_26 = utf8.len(var_18_24)
				local var_18_27 = var_18_25 <= 0 and var_18_21 or var_18_21 * (var_18_26 / var_18_25)

				if var_18_27 > 0 and var_18_21 < var_18_27 then
					arg_15_1.talkMaxDuration = var_18_27

					if var_18_27 + var_18_20 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_27 + var_18_20
					end
				end

				arg_15_1.text_.text = var_18_24
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321003", "story_v_out_116321.awb") ~= 0 then
					local var_18_28 = manager.audio:GetVoiceLength("story_v_out_116321", "116321003", "story_v_out_116321.awb") / 1000

					if var_18_28 + var_18_20 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_28 + var_18_20
					end

					if var_18_23.prefab_name ~= "" and arg_15_1.actors_[var_18_23.prefab_name] ~= nil then
						local var_18_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_23.prefab_name].transform, "story_v_out_116321", "116321003", "story_v_out_116321.awb")

						arg_15_1:RecordAudio("116321003", var_18_29)
						arg_15_1:RecordAudio("116321003", var_18_29)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_116321", "116321003", "story_v_out_116321.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_116321", "116321003", "story_v_out_116321.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_30 = math.max(var_18_21, arg_15_1.talkMaxDuration)

			if var_18_20 <= arg_15_1.time_ and arg_15_1.time_ < var_18_20 + var_18_30 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_20) / var_18_30

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_20 + var_18_30 and arg_15_1.time_ < var_18_20 + var_18_30 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
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
	Play116321004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 116321004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play116321005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["10032ui_story"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect10032ui_story == nil then
				arg_19_1.var_.characterEffect10032ui_story = var_22_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.2

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_2 and not isNil(var_22_0) then
				local var_22_3 = (arg_19_1.time_ - var_22_1) / var_22_2

				if arg_19_1.var_.characterEffect10032ui_story and not isNil(var_22_0) then
					local var_22_4 = Mathf.Lerp(0, 0.5, var_22_3)

					arg_19_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_19_1.var_.characterEffect10032ui_story.fillRatio = var_22_4
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_2 and arg_19_1.time_ < var_22_1 + var_22_2 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect10032ui_story then
				local var_22_5 = 0.5

				arg_19_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_19_1.var_.characterEffect10032ui_story.fillRatio = var_22_5
			end

			local var_22_6 = 0
			local var_22_7 = 0.525

			if var_22_6 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_8 = arg_19_1:GetWordFromCfg(116321004)
				local var_22_9 = arg_19_1:FormatText(var_22_8.content)

				arg_19_1.text_.text = var_22_9

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_10 = 21
				local var_22_11 = utf8.len(var_22_9)
				local var_22_12 = var_22_10 <= 0 and var_22_7 or var_22_7 * (var_22_11 / var_22_10)

				if var_22_12 > 0 and var_22_7 < var_22_12 then
					arg_19_1.talkMaxDuration = var_22_12

					if var_22_12 + var_22_6 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_12 + var_22_6
					end
				end

				arg_19_1.text_.text = var_22_9
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_13 = math.max(var_22_7, arg_19_1.talkMaxDuration)

			if var_22_6 <= arg_19_1.time_ and arg_19_1.time_ < var_22_6 + var_22_13 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_6) / var_22_13

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_6 + var_22_13 and arg_19_1.time_ < var_22_6 + var_22_13 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play116321005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 116321005
		arg_23_1.duration_ = 5.8

		local var_23_0 = {
			zh = 4.466,
			ja = 5.8
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
				arg_23_0:Play116321006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 0.525

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_2 = arg_23_1:FormatText(StoryNameCfg[337].name)

				arg_23_1.leftNameTxt_.text = var_26_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_3 = arg_23_1:GetWordFromCfg(116321005)
				local var_26_4 = arg_23_1:FormatText(var_26_3.content)

				arg_23_1.text_.text = var_26_4

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321005", "story_v_out_116321.awb") ~= 0 then
					local var_26_8 = manager.audio:GetVoiceLength("story_v_out_116321", "116321005", "story_v_out_116321.awb") / 1000

					if var_26_8 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_8 + var_26_0
					end

					if var_26_3.prefab_name ~= "" and arg_23_1.actors_[var_26_3.prefab_name] ~= nil then
						local var_26_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_3.prefab_name].transform, "story_v_out_116321", "116321005", "story_v_out_116321.awb")

						arg_23_1:RecordAudio("116321005", var_26_9)
						arg_23_1:RecordAudio("116321005", var_26_9)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_116321", "116321005", "story_v_out_116321.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_116321", "116321005", "story_v_out_116321.awb")
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
	Play116321006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 116321006
		arg_27_1.duration_ = 4.77

		local var_27_0 = {
			zh = 4.766,
			ja = 3.733
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
				arg_27_0:Play116321007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["10032ui_story"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos10032ui_story = var_30_0.localPosition
			end

			local var_30_2 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2
				local var_30_4 = Vector3.New(0, -1.1, -5.9)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10032ui_story, var_30_4, var_30_3)

				local var_30_5 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_5.x, var_30_5.y, var_30_5.z)

				local var_30_6 = var_30_0.localEulerAngles

				var_30_6.z = 0
				var_30_6.x = 0
				var_30_0.localEulerAngles = var_30_6
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_30_7 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_7.x, var_30_7.y, var_30_7.z)

				local var_30_8 = var_30_0.localEulerAngles

				var_30_8.z = 0
				var_30_8.x = 0
				var_30_0.localEulerAngles = var_30_8
			end

			local var_30_9 = arg_27_1.actors_["10032ui_story"]
			local var_30_10 = 0

			if var_30_10 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 and not isNil(var_30_9) and arg_27_1.var_.characterEffect10032ui_story == nil then
				arg_27_1.var_.characterEffect10032ui_story = var_30_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_11 = 0.2

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_11 and not isNil(var_30_9) then
				local var_30_12 = (arg_27_1.time_ - var_30_10) / var_30_11

				if arg_27_1.var_.characterEffect10032ui_story and not isNil(var_30_9) then
					arg_27_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_10 + var_30_11 and arg_27_1.time_ < var_30_10 + var_30_11 + arg_30_0 and not isNil(var_30_9) and arg_27_1.var_.characterEffect10032ui_story then
				arg_27_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_30_13 = 0

			if var_30_13 < arg_27_1.time_ and arg_27_1.time_ <= var_30_13 + arg_30_0 then
				arg_27_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_30_14 = 0

			if var_30_14 < arg_27_1.time_ and arg_27_1.time_ <= var_30_14 + arg_30_0 then
				arg_27_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_30_15 = 0
			local var_30_16 = 0.4

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_17 = arg_27_1:FormatText(StoryNameCfg[328].name)

				arg_27_1.leftNameTxt_.text = var_30_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_18 = arg_27_1:GetWordFromCfg(116321006)
				local var_30_19 = arg_27_1:FormatText(var_30_18.content)

				arg_27_1.text_.text = var_30_19

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_20 = 16
				local var_30_21 = utf8.len(var_30_19)
				local var_30_22 = var_30_20 <= 0 and var_30_16 or var_30_16 * (var_30_21 / var_30_20)

				if var_30_22 > 0 and var_30_16 < var_30_22 then
					arg_27_1.talkMaxDuration = var_30_22

					if var_30_22 + var_30_15 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_22 + var_30_15
					end
				end

				arg_27_1.text_.text = var_30_19
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321006", "story_v_out_116321.awb") ~= 0 then
					local var_30_23 = manager.audio:GetVoiceLength("story_v_out_116321", "116321006", "story_v_out_116321.awb") / 1000

					if var_30_23 + var_30_15 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_23 + var_30_15
					end

					if var_30_18.prefab_name ~= "" and arg_27_1.actors_[var_30_18.prefab_name] ~= nil then
						local var_30_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_18.prefab_name].transform, "story_v_out_116321", "116321006", "story_v_out_116321.awb")

						arg_27_1:RecordAudio("116321006", var_30_24)
						arg_27_1:RecordAudio("116321006", var_30_24)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_116321", "116321006", "story_v_out_116321.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_116321", "116321006", "story_v_out_116321.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_25 = math.max(var_30_16, arg_27_1.talkMaxDuration)

			if var_30_15 <= arg_27_1.time_ and arg_27_1.time_ < var_30_15 + var_30_25 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_15) / var_30_25

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_15 + var_30_25 and arg_27_1.time_ < var_30_15 + var_30_25 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play116321007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 116321007
		arg_31_1.duration_ = 9.63

		local var_31_0 = {
			zh = 8.4,
			ja = 9.633
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play116321008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["10032ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos10032ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(0, -1.1, -5.9)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10032ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = arg_31_1.actors_["10032ui_story"]
			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect10032ui_story == nil then
				arg_31_1.var_.characterEffect10032ui_story = var_34_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_11 = 0.2

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 and not isNil(var_34_9) then
				local var_34_12 = (arg_31_1.time_ - var_34_10) / var_34_11

				if arg_31_1.var_.characterEffect10032ui_story and not isNil(var_34_9) then
					arg_31_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect10032ui_story then
				arg_31_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_34_13 = 0

			if var_34_13 < arg_31_1.time_ and arg_31_1.time_ <= var_34_13 + arg_34_0 then
				arg_31_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_34_14 = 0
			local var_34_15 = 0.925

			if var_34_14 < arg_31_1.time_ and arg_31_1.time_ <= var_34_14 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_16 = arg_31_1:FormatText(StoryNameCfg[328].name)

				arg_31_1.leftNameTxt_.text = var_34_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_17 = arg_31_1:GetWordFromCfg(116321007)
				local var_34_18 = arg_31_1:FormatText(var_34_17.content)

				arg_31_1.text_.text = var_34_18

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_19 = 37
				local var_34_20 = utf8.len(var_34_18)
				local var_34_21 = var_34_19 <= 0 and var_34_15 or var_34_15 * (var_34_20 / var_34_19)

				if var_34_21 > 0 and var_34_15 < var_34_21 then
					arg_31_1.talkMaxDuration = var_34_21

					if var_34_21 + var_34_14 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_21 + var_34_14
					end
				end

				arg_31_1.text_.text = var_34_18
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321007", "story_v_out_116321.awb") ~= 0 then
					local var_34_22 = manager.audio:GetVoiceLength("story_v_out_116321", "116321007", "story_v_out_116321.awb") / 1000

					if var_34_22 + var_34_14 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_22 + var_34_14
					end

					if var_34_17.prefab_name ~= "" and arg_31_1.actors_[var_34_17.prefab_name] ~= nil then
						local var_34_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_17.prefab_name].transform, "story_v_out_116321", "116321007", "story_v_out_116321.awb")

						arg_31_1:RecordAudio("116321007", var_34_23)
						arg_31_1:RecordAudio("116321007", var_34_23)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_116321", "116321007", "story_v_out_116321.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_116321", "116321007", "story_v_out_116321.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_24 = math.max(var_34_15, arg_31_1.talkMaxDuration)

			if var_34_14 <= arg_31_1.time_ and arg_31_1.time_ < var_34_14 + var_34_24 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_14) / var_34_24

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_14 + var_34_24 and arg_31_1.time_ < var_34_14 + var_34_24 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play116321008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 116321008
		arg_35_1.duration_ = 5.03

		local var_35_0 = {
			zh = 5.033,
			ja = 4.1
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play116321009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["10032ui_story"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect10032ui_story == nil then
				arg_35_1.var_.characterEffect10032ui_story = var_38_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.2

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.characterEffect10032ui_story and not isNil(var_38_0) then
					local var_38_4 = Mathf.Lerp(0, 0.5, var_38_3)

					arg_35_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_35_1.var_.characterEffect10032ui_story.fillRatio = var_38_4
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect10032ui_story then
				local var_38_5 = 0.5

				arg_35_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_35_1.var_.characterEffect10032ui_story.fillRatio = var_38_5
			end

			local var_38_6 = 0
			local var_38_7 = 0.675

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_8 = arg_35_1:FormatText(StoryNameCfg[337].name)

				arg_35_1.leftNameTxt_.text = var_38_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_9 = arg_35_1:GetWordFromCfg(116321008)
				local var_38_10 = arg_35_1:FormatText(var_38_9.content)

				arg_35_1.text_.text = var_38_10

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_11 = 27
				local var_38_12 = utf8.len(var_38_10)
				local var_38_13 = var_38_11 <= 0 and var_38_7 or var_38_7 * (var_38_12 / var_38_11)

				if var_38_13 > 0 and var_38_7 < var_38_13 then
					arg_35_1.talkMaxDuration = var_38_13

					if var_38_13 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_6
					end
				end

				arg_35_1.text_.text = var_38_10
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321008", "story_v_out_116321.awb") ~= 0 then
					local var_38_14 = manager.audio:GetVoiceLength("story_v_out_116321", "116321008", "story_v_out_116321.awb") / 1000

					if var_38_14 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_14 + var_38_6
					end

					if var_38_9.prefab_name ~= "" and arg_35_1.actors_[var_38_9.prefab_name] ~= nil then
						local var_38_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_9.prefab_name].transform, "story_v_out_116321", "116321008", "story_v_out_116321.awb")

						arg_35_1:RecordAudio("116321008", var_38_15)
						arg_35_1:RecordAudio("116321008", var_38_15)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_116321", "116321008", "story_v_out_116321.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_116321", "116321008", "story_v_out_116321.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_16 = math.max(var_38_7, arg_35_1.talkMaxDuration)

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_16 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_6) / var_38_16

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_6 + var_38_16 and arg_35_1.time_ < var_38_6 + var_38_16 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play116321009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 116321009
		arg_39_1.duration_ = 9.1

		local var_39_0 = {
			zh = 6.8,
			ja = 9.1
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play116321010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.65

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_2 = arg_39_1:FormatText(StoryNameCfg[337].name)

				arg_39_1.leftNameTxt_.text = var_42_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:GetWordFromCfg(116321009)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 26
				local var_42_6 = utf8.len(var_42_4)
				local var_42_7 = var_42_5 <= 0 and var_42_1 or var_42_1 * (var_42_6 / var_42_5)

				if var_42_7 > 0 and var_42_1 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321009", "story_v_out_116321.awb") ~= 0 then
					local var_42_8 = manager.audio:GetVoiceLength("story_v_out_116321", "116321009", "story_v_out_116321.awb") / 1000

					if var_42_8 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_0
					end

					if var_42_3.prefab_name ~= "" and arg_39_1.actors_[var_42_3.prefab_name] ~= nil then
						local var_42_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_3.prefab_name].transform, "story_v_out_116321", "116321009", "story_v_out_116321.awb")

						arg_39_1:RecordAudio("116321009", var_42_9)
						arg_39_1:RecordAudio("116321009", var_42_9)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_116321", "116321009", "story_v_out_116321.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_116321", "116321009", "story_v_out_116321.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_10 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_10 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_10

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_10 and arg_39_1.time_ < var_42_0 + var_42_10 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play116321010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 116321010
		arg_43_1.duration_ = 2.5

		local var_43_0 = {
			zh = 2.399999999999,
			ja = 2.5
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play116321011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["10032ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos10032ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(0, -1.1, -5.9)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10032ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = arg_43_1.actors_["10032ui_story"]
			local var_46_10 = 0

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect10032ui_story == nil then
				arg_43_1.var_.characterEffect10032ui_story = var_46_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_11 = 0.2

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_11 and not isNil(var_46_9) then
				local var_46_12 = (arg_43_1.time_ - var_46_10) / var_46_11

				if arg_43_1.var_.characterEffect10032ui_story and not isNil(var_46_9) then
					arg_43_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_10 + var_46_11 and arg_43_1.time_ < var_46_10 + var_46_11 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect10032ui_story then
				arg_43_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_46_13 = 0

			if var_46_13 < arg_43_1.time_ and arg_43_1.time_ <= var_46_13 + arg_46_0 then
				arg_43_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_46_14 = 0

			if var_46_14 < arg_43_1.time_ and arg_43_1.time_ <= var_46_14 + arg_46_0 then
				arg_43_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_46_15 = 0
			local var_46_16 = 0.125

			if var_46_15 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_17 = arg_43_1:FormatText(StoryNameCfg[328].name)

				arg_43_1.leftNameTxt_.text = var_46_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_18 = arg_43_1:GetWordFromCfg(116321010)
				local var_46_19 = arg_43_1:FormatText(var_46_18.content)

				arg_43_1.text_.text = var_46_19

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_20 = 5
				local var_46_21 = utf8.len(var_46_19)
				local var_46_22 = var_46_20 <= 0 and var_46_16 or var_46_16 * (var_46_21 / var_46_20)

				if var_46_22 > 0 and var_46_16 < var_46_22 then
					arg_43_1.talkMaxDuration = var_46_22

					if var_46_22 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_22 + var_46_15
					end
				end

				arg_43_1.text_.text = var_46_19
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321010", "story_v_out_116321.awb") ~= 0 then
					local var_46_23 = manager.audio:GetVoiceLength("story_v_out_116321", "116321010", "story_v_out_116321.awb") / 1000

					if var_46_23 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_23 + var_46_15
					end

					if var_46_18.prefab_name ~= "" and arg_43_1.actors_[var_46_18.prefab_name] ~= nil then
						local var_46_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_18.prefab_name].transform, "story_v_out_116321", "116321010", "story_v_out_116321.awb")

						arg_43_1:RecordAudio("116321010", var_46_24)
						arg_43_1:RecordAudio("116321010", var_46_24)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_116321", "116321010", "story_v_out_116321.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_116321", "116321010", "story_v_out_116321.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_25 = math.max(var_46_16, arg_43_1.talkMaxDuration)

			if var_46_15 <= arg_43_1.time_ and arg_43_1.time_ < var_46_15 + var_46_25 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_15) / var_46_25

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_15 + var_46_25 and arg_43_1.time_ < var_46_15 + var_46_25 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play116321011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 116321011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play116321012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10032ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect10032ui_story == nil then
				arg_47_1.var_.characterEffect10032ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.2

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect10032ui_story and not isNil(var_50_0) then
					local var_50_4 = Mathf.Lerp(0, 0.5, var_50_3)

					arg_47_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10032ui_story.fillRatio = var_50_4
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect10032ui_story then
				local var_50_5 = 0.5

				arg_47_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10032ui_story.fillRatio = var_50_5
			end

			local var_50_6 = arg_47_1.actors_["10032ui_story"].transform
			local var_50_7 = 0

			if var_50_7 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 then
				arg_47_1.var_.moveOldPos10032ui_story = var_50_6.localPosition
			end

			local var_50_8 = 0.1

			if var_50_7 <= arg_47_1.time_ and arg_47_1.time_ < var_50_7 + var_50_8 then
				local var_50_9 = (arg_47_1.time_ - var_50_7) / var_50_8
				local var_50_10 = Vector3.New(0, 100, 0)

				var_50_6.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10032ui_story, var_50_10, var_50_9)

				local var_50_11 = manager.ui.mainCamera.transform.position - var_50_6.position

				var_50_6.forward = Vector3.New(var_50_11.x, var_50_11.y, var_50_11.z)

				local var_50_12 = var_50_6.localEulerAngles

				var_50_12.z = 0
				var_50_12.x = 0
				var_50_6.localEulerAngles = var_50_12
			end

			if arg_47_1.time_ >= var_50_7 + var_50_8 and arg_47_1.time_ < var_50_7 + var_50_8 + arg_50_0 then
				var_50_6.localPosition = Vector3.New(0, 100, 0)

				local var_50_13 = manager.ui.mainCamera.transform.position - var_50_6.position

				var_50_6.forward = Vector3.New(var_50_13.x, var_50_13.y, var_50_13.z)

				local var_50_14 = var_50_6.localEulerAngles

				var_50_14.z = 0
				var_50_14.x = 0
				var_50_6.localEulerAngles = var_50_14
			end

			local var_50_15 = 0
			local var_50_16 = 0.325

			if var_50_15 < arg_47_1.time_ and arg_47_1.time_ <= var_50_15 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_17 = arg_47_1:GetWordFromCfg(116321011)
				local var_50_18 = arg_47_1:FormatText(var_50_17.content)

				arg_47_1.text_.text = var_50_18

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_19 = 13
				local var_50_20 = utf8.len(var_50_18)
				local var_50_21 = var_50_19 <= 0 and var_50_16 or var_50_16 * (var_50_20 / var_50_19)

				if var_50_21 > 0 and var_50_16 < var_50_21 then
					arg_47_1.talkMaxDuration = var_50_21

					if var_50_21 + var_50_15 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_21 + var_50_15
					end
				end

				arg_47_1.text_.text = var_50_18
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_22 = math.max(var_50_16, arg_47_1.talkMaxDuration)

			if var_50_15 <= arg_47_1.time_ and arg_47_1.time_ < var_50_15 + var_50_22 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_15) / var_50_22

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_15 + var_50_22 and arg_47_1.time_ < var_50_15 + var_50_22 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play116321012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 116321012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play116321013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.975

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_2 = arg_51_1:GetWordFromCfg(116321012)
				local var_54_3 = arg_51_1:FormatText(var_54_2.content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 39
				local var_54_5 = utf8.len(var_54_3)
				local var_54_6 = var_54_4 <= 0 and var_54_1 or var_54_1 * (var_54_5 / var_54_4)

				if var_54_6 > 0 and var_54_1 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_7 and arg_51_1.time_ < var_54_0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play116321013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 116321013
		arg_55_1.duration_ = 13.8

		local var_55_0 = {
			zh = 10.566,
			ja = 13.8
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play116321014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.266666666666667

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				local var_58_2 = "play"
				local var_58_3 = "music"

				arg_55_1:AudioAction(var_58_2, var_58_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_58_4 = ""
				local var_58_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_58_5 ~= "" then
					if arg_55_1.bgmTxt_.text ~= var_58_5 and arg_55_1.bgmTxt_.text ~= "" then
						if arg_55_1.bgmTxt2_.text ~= "" then
							arg_55_1.bgmTxt_.text = arg_55_1.bgmTxt2_.text
						end

						arg_55_1.bgmTxt2_.text = var_58_5

						arg_55_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_55_1.bgmTxt_.text = var_58_5
						arg_55_1.bgmTxt2_.text = var_58_5
					end

					if arg_55_1.bgmTimer then
						arg_55_1.bgmTimer:Stop()

						arg_55_1.bgmTimer = nil
					end

					if arg_55_1.settingData.show_music_name == 1 then
						arg_55_1.musicController:SetSelectedState("show")
						arg_55_1.musicAnimator_:Play("open", 0, 0)

						if arg_55_1.settingData.music_time ~= 0 then
							arg_55_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_55_1.settingData.music_time), function()
								if arg_55_1 == nil or isNil(arg_55_1.bgmTxt_) then
									return
								end

								arg_55_1.musicController:SetSelectedState("hide")
								arg_55_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_58_6 = 0
			local var_58_7 = 0.95

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_8 = arg_55_1:GetWordFromCfg(116321013)
				local var_58_9 = arg_55_1:FormatText(var_58_8.content)

				arg_55_1.text_.text = var_58_9

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_10 = 38
				local var_58_11 = utf8.len(var_58_9)
				local var_58_12 = var_58_10 <= 0 and var_58_7 or var_58_7 * (var_58_11 / var_58_10)

				if var_58_12 > 0 and var_58_7 < var_58_12 then
					arg_55_1.talkMaxDuration = var_58_12

					if var_58_12 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_12 + var_58_6
					end
				end

				arg_55_1.text_.text = var_58_9
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321013", "story_v_out_116321.awb") ~= 0 then
					local var_58_13 = manager.audio:GetVoiceLength("story_v_out_116321", "116321013", "story_v_out_116321.awb") / 1000

					if var_58_13 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_6
					end

					if var_58_8.prefab_name ~= "" and arg_55_1.actors_[var_58_8.prefab_name] ~= nil then
						local var_58_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_8.prefab_name].transform, "story_v_out_116321", "116321013", "story_v_out_116321.awb")

						arg_55_1:RecordAudio("116321013", var_58_14)
						arg_55_1:RecordAudio("116321013", var_58_14)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_116321", "116321013", "story_v_out_116321.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_116321", "116321013", "story_v_out_116321.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_15 = math.max(var_58_7, arg_55_1.talkMaxDuration)

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_15 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_6) / var_58_15

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_6 + var_58_15 and arg_55_1.time_ < var_58_6 + var_58_15 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play116321014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 116321014
		arg_60_1.duration_ = 18.37

		local var_60_0 = {
			zh = 11.266,
			ja = 18.366
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
				arg_60_0:Play116321015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 1.1

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_2 = arg_60_1:GetWordFromCfg(116321014)
				local var_63_3 = arg_60_1:FormatText(var_63_2.content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 44
				local var_63_5 = utf8.len(var_63_3)
				local var_63_6 = var_63_4 <= 0 and var_63_1 or var_63_1 * (var_63_5 / var_63_4)

				if var_63_6 > 0 and var_63_1 < var_63_6 then
					arg_60_1.talkMaxDuration = var_63_6

					if var_63_6 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321014", "story_v_out_116321.awb") ~= 0 then
					local var_63_7 = manager.audio:GetVoiceLength("story_v_out_116321", "116321014", "story_v_out_116321.awb") / 1000

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end

					if var_63_2.prefab_name ~= "" and arg_60_1.actors_[var_63_2.prefab_name] ~= nil then
						local var_63_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_2.prefab_name].transform, "story_v_out_116321", "116321014", "story_v_out_116321.awb")

						arg_60_1:RecordAudio("116321014", var_63_8)
						arg_60_1:RecordAudio("116321014", var_63_8)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_116321", "116321014", "story_v_out_116321.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_116321", "116321014", "story_v_out_116321.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_9 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_9 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_9

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_9 and arg_60_1.time_ < var_63_0 + var_63_9 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play116321015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 116321015
		arg_64_1.duration_ = 9.83

		local var_64_0 = {
			zh = 5,
			ja = 9.833
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
				arg_64_0:Play116321016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.5

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_2 = arg_64_1:GetWordFromCfg(116321015)
				local var_67_3 = arg_64_1:FormatText(var_67_2.content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 20
				local var_67_5 = utf8.len(var_67_3)
				local var_67_6 = var_67_4 <= 0 and var_67_1 or var_67_1 * (var_67_5 / var_67_4)

				if var_67_6 > 0 and var_67_1 < var_67_6 then
					arg_64_1.talkMaxDuration = var_67_6

					if var_67_6 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321015", "story_v_out_116321.awb") ~= 0 then
					local var_67_7 = manager.audio:GetVoiceLength("story_v_out_116321", "116321015", "story_v_out_116321.awb") / 1000

					if var_67_7 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_0
					end

					if var_67_2.prefab_name ~= "" and arg_64_1.actors_[var_67_2.prefab_name] ~= nil then
						local var_67_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_2.prefab_name].transform, "story_v_out_116321", "116321015", "story_v_out_116321.awb")

						arg_64_1:RecordAudio("116321015", var_67_8)
						arg_64_1:RecordAudio("116321015", var_67_8)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_116321", "116321015", "story_v_out_116321.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_116321", "116321015", "story_v_out_116321.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_9 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_9 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_9

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_9 and arg_64_1.time_ < var_67_0 + var_67_9 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play116321016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 116321016
		arg_68_1.duration_ = 12.03

		local var_68_0 = {
			zh = 9.1,
			ja = 12.033
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
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play116321017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.65

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_2 = arg_68_1:GetWordFromCfg(116321016)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 25
				local var_71_5 = utf8.len(var_71_3)
				local var_71_6 = var_71_4 <= 0 and var_71_1 or var_71_1 * (var_71_5 / var_71_4)

				if var_71_6 > 0 and var_71_1 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321016", "story_v_out_116321.awb") ~= 0 then
					local var_71_7 = manager.audio:GetVoiceLength("story_v_out_116321", "116321016", "story_v_out_116321.awb") / 1000

					if var_71_7 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_0
					end

					if var_71_2.prefab_name ~= "" and arg_68_1.actors_[var_71_2.prefab_name] ~= nil then
						local var_71_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_2.prefab_name].transform, "story_v_out_116321", "116321016", "story_v_out_116321.awb")

						arg_68_1:RecordAudio("116321016", var_71_8)
						arg_68_1:RecordAudio("116321016", var_71_8)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_116321", "116321016", "story_v_out_116321.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_116321", "116321016", "story_v_out_116321.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_9 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_9 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_9

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_9 and arg_68_1.time_ < var_71_0 + var_71_9 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play116321017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 116321017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play116321018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.475

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(116321017)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 19
				local var_75_5 = utf8.len(var_75_3)
				local var_75_6 = var_75_4 <= 0 and var_75_1 or var_75_1 * (var_75_5 / var_75_4)

				if var_75_6 > 0 and var_75_1 < var_75_6 then
					arg_72_1.talkMaxDuration = var_75_6

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_7 and arg_72_1.time_ < var_75_0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play116321018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 116321018
		arg_76_1.duration_ = 10.5

		local var_76_0 = {
			zh = 7.6,
			ja = 10.5
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play116321019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = "I07"

			if arg_76_1.bgs_[var_79_0] == nil then
				local var_79_1 = Object.Instantiate(arg_76_1.paintGo_)

				var_79_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_79_0)
				var_79_1.name = var_79_0
				var_79_1.transform.parent = arg_76_1.stage_.transform
				var_79_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.bgs_[var_79_0] = var_79_1
			end

			local var_79_2 = 2

			if var_79_2 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				local var_79_3 = manager.ui.mainCamera.transform.localPosition
				local var_79_4 = Vector3.New(0, 0, 10) + Vector3.New(var_79_3.x, var_79_3.y, 0)
				local var_79_5 = arg_76_1.bgs_.I07

				var_79_5.transform.localPosition = var_79_4
				var_79_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_79_6 = var_79_5:GetComponent("SpriteRenderer")

				if var_79_6 and var_79_6.sprite then
					local var_79_7 = (var_79_5.transform.localPosition - var_79_3).z
					local var_79_8 = manager.ui.mainCameraCom_
					local var_79_9 = 2 * var_79_7 * Mathf.Tan(var_79_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_79_10 = var_79_9 * var_79_8.aspect
					local var_79_11 = var_79_6.sprite.bounds.size.x
					local var_79_12 = var_79_6.sprite.bounds.size.y
					local var_79_13 = var_79_10 / var_79_11
					local var_79_14 = var_79_9 / var_79_12
					local var_79_15 = var_79_14 < var_79_13 and var_79_13 or var_79_14

					var_79_5.transform.localScale = Vector3.New(var_79_15, var_79_15, 0)
				end

				for iter_79_0, iter_79_1 in pairs(arg_76_1.bgs_) do
					if iter_79_0 ~= "I07" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_17 = 2

			if var_79_16 <= arg_76_1.time_ and arg_76_1.time_ < var_79_16 + var_79_17 then
				local var_79_18 = (arg_76_1.time_ - var_79_16) / var_79_17
				local var_79_19 = Color.New(0, 0, 0)

				var_79_19.a = Mathf.Lerp(0, 1, var_79_18)
				arg_76_1.mask_.color = var_79_19
			end

			if arg_76_1.time_ >= var_79_16 + var_79_17 and arg_76_1.time_ < var_79_16 + var_79_17 + arg_79_0 then
				local var_79_20 = Color.New(0, 0, 0)

				var_79_20.a = 1
				arg_76_1.mask_.color = var_79_20
			end

			local var_79_21 = 2

			if var_79_21 < arg_76_1.time_ and arg_76_1.time_ <= var_79_21 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_22 = 2

			if var_79_21 <= arg_76_1.time_ and arg_76_1.time_ < var_79_21 + var_79_22 then
				local var_79_23 = (arg_76_1.time_ - var_79_21) / var_79_22
				local var_79_24 = Color.New(0, 0, 0)

				var_79_24.a = Mathf.Lerp(1, 0, var_79_23)
				arg_76_1.mask_.color = var_79_24
			end

			if arg_76_1.time_ >= var_79_21 + var_79_22 and arg_76_1.time_ < var_79_21 + var_79_22 + arg_79_0 then
				local var_79_25 = Color.New(0, 0, 0)
				local var_79_26 = 0

				arg_76_1.mask_.enabled = false
				var_79_25.a = var_79_26
				arg_76_1.mask_.color = var_79_25
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_27 = 4
			local var_79_28 = 0.275

			if var_79_27 < arg_76_1.time_ and arg_76_1.time_ <= var_79_27 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_29 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_29:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_30 = arg_76_1:GetWordFromCfg(116321018)
				local var_79_31 = arg_76_1:FormatText(var_79_30.content)

				arg_76_1.text_.text = var_79_31

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_32 = 11
				local var_79_33 = utf8.len(var_79_31)
				local var_79_34 = var_79_32 <= 0 and var_79_28 or var_79_28 * (var_79_33 / var_79_32)

				if var_79_34 > 0 and var_79_28 < var_79_34 then
					arg_76_1.talkMaxDuration = var_79_34
					var_79_27 = var_79_27 + 0.3

					if var_79_34 + var_79_27 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_34 + var_79_27
					end
				end

				arg_76_1.text_.text = var_79_31
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321018", "story_v_out_116321.awb") ~= 0 then
					local var_79_35 = manager.audio:GetVoiceLength("story_v_out_116321", "116321018", "story_v_out_116321.awb") / 1000

					if var_79_35 + var_79_27 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_35 + var_79_27
					end

					if var_79_30.prefab_name ~= "" and arg_76_1.actors_[var_79_30.prefab_name] ~= nil then
						local var_79_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_30.prefab_name].transform, "story_v_out_116321", "116321018", "story_v_out_116321.awb")

						arg_76_1:RecordAudio("116321018", var_79_36)
						arg_76_1:RecordAudio("116321018", var_79_36)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_116321", "116321018", "story_v_out_116321.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_116321", "116321018", "story_v_out_116321.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_37 = var_79_27 + 0.3
			local var_79_38 = math.max(var_79_28, arg_76_1.talkMaxDuration)

			if var_79_37 <= arg_76_1.time_ and arg_76_1.time_ < var_79_37 + var_79_38 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_37) / var_79_38

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_37 + var_79_38 and arg_76_1.time_ < var_79_37 + var_79_38 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play116321019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 116321019
		arg_82_1.duration_ = 7.2

		local var_82_0 = {
			zh = 5.666,
			ja = 7.2
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
				arg_82_0:Play116321020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.266666666666667

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				local var_85_2 = "play"
				local var_85_3 = "music"

				arg_82_1:AudioAction(var_85_2, var_85_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_85_4 = ""
				local var_85_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_85_5 ~= "" then
					if arg_82_1.bgmTxt_.text ~= var_85_5 and arg_82_1.bgmTxt_.text ~= "" then
						if arg_82_1.bgmTxt2_.text ~= "" then
							arg_82_1.bgmTxt_.text = arg_82_1.bgmTxt2_.text
						end

						arg_82_1.bgmTxt2_.text = var_85_5

						arg_82_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_82_1.bgmTxt_.text = var_85_5
						arg_82_1.bgmTxt2_.text = var_85_5
					end

					if arg_82_1.bgmTimer then
						arg_82_1.bgmTimer:Stop()

						arg_82_1.bgmTimer = nil
					end

					if arg_82_1.settingData.show_music_name == 1 then
						arg_82_1.musicController:SetSelectedState("show")
						arg_82_1.musicAnimator_:Play("open", 0, 0)

						if arg_82_1.settingData.music_time ~= 0 then
							arg_82_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_82_1.settingData.music_time), function()
								if arg_82_1 == nil or isNil(arg_82_1.bgmTxt_) then
									return
								end

								arg_82_1.musicController:SetSelectedState("hide")
								arg_82_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_85_6 = 0.4
			local var_85_7 = 0.6

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				local var_85_8 = "play"
				local var_85_9 = "music"

				arg_82_1:AudioAction(var_85_8, var_85_9, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_85_10 = ""
				local var_85_11 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_85_11 ~= "" then
					if arg_82_1.bgmTxt_.text ~= var_85_11 and arg_82_1.bgmTxt_.text ~= "" then
						if arg_82_1.bgmTxt2_.text ~= "" then
							arg_82_1.bgmTxt_.text = arg_82_1.bgmTxt2_.text
						end

						arg_82_1.bgmTxt2_.text = var_85_11

						arg_82_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_82_1.bgmTxt_.text = var_85_11
						arg_82_1.bgmTxt2_.text = var_85_11
					end

					if arg_82_1.bgmTimer then
						arg_82_1.bgmTimer:Stop()

						arg_82_1.bgmTimer = nil
					end

					if arg_82_1.settingData.show_music_name == 1 then
						arg_82_1.musicController:SetSelectedState("show")
						arg_82_1.musicAnimator_:Play("open", 0, 0)

						if arg_82_1.settingData.music_time ~= 0 then
							arg_82_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_82_1.settingData.music_time), function()
								if arg_82_1 == nil or isNil(arg_82_1.bgmTxt_) then
									return
								end

								arg_82_1.musicController:SetSelectedState("hide")
								arg_82_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_85_12 = 0
			local var_85_13 = 0.65

			if var_85_12 < arg_82_1.time_ and arg_82_1.time_ <= var_85_12 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_14 = arg_82_1:GetWordFromCfg(116321019)
				local var_85_15 = arg_82_1:FormatText(var_85_14.content)

				arg_82_1.text_.text = var_85_15

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_16 = 23
				local var_85_17 = utf8.len(var_85_15)
				local var_85_18 = var_85_16 <= 0 and var_85_13 or var_85_13 * (var_85_17 / var_85_16)

				if var_85_18 > 0 and var_85_13 < var_85_18 then
					arg_82_1.talkMaxDuration = var_85_18

					if var_85_18 + var_85_12 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_18 + var_85_12
					end
				end

				arg_82_1.text_.text = var_85_15
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321019", "story_v_out_116321.awb") ~= 0 then
					local var_85_19 = manager.audio:GetVoiceLength("story_v_out_116321", "116321019", "story_v_out_116321.awb") / 1000

					if var_85_19 + var_85_12 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_19 + var_85_12
					end

					if var_85_14.prefab_name ~= "" and arg_82_1.actors_[var_85_14.prefab_name] ~= nil then
						local var_85_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_14.prefab_name].transform, "story_v_out_116321", "116321019", "story_v_out_116321.awb")

						arg_82_1:RecordAudio("116321019", var_85_20)
						arg_82_1:RecordAudio("116321019", var_85_20)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_116321", "116321019", "story_v_out_116321.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_116321", "116321019", "story_v_out_116321.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_21 = math.max(var_85_13, arg_82_1.talkMaxDuration)

			if var_85_12 <= arg_82_1.time_ and arg_82_1.time_ < var_85_12 + var_85_21 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_12) / var_85_21

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_12 + var_85_21 and arg_82_1.time_ < var_85_12 + var_85_21 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play116321020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 116321020
		arg_88_1.duration_ = 9.23

		local var_88_0 = {
			zh = 5.466,
			ja = 9.233
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play116321021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.725

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[338].name)

				arg_88_1.leftNameTxt_.text = var_91_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:GetWordFromCfg(116321020)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 29
				local var_91_6 = utf8.len(var_91_4)
				local var_91_7 = var_91_5 <= 0 and var_91_1 or var_91_1 * (var_91_6 / var_91_5)

				if var_91_7 > 0 and var_91_1 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321020", "story_v_out_116321.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_116321", "116321020", "story_v_out_116321.awb") / 1000

					if var_91_8 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_0
					end

					if var_91_3.prefab_name ~= "" and arg_88_1.actors_[var_91_3.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_3.prefab_name].transform, "story_v_out_116321", "116321020", "story_v_out_116321.awb")

						arg_88_1:RecordAudio("116321020", var_91_9)
						arg_88_1:RecordAudio("116321020", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_116321", "116321020", "story_v_out_116321.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_116321", "116321020", "story_v_out_116321.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_10 and arg_88_1.time_ < var_91_0 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play116321021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 116321021
		arg_92_1.duration_ = 13.77

		local var_92_0 = {
			zh = 9.4,
			ja = 13.766
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play116321022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 1.075

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[339].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(116321021)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 43
				local var_95_6 = utf8.len(var_95_4)
				local var_95_7 = var_95_5 <= 0 and var_95_1 or var_95_1 * (var_95_6 / var_95_5)

				if var_95_7 > 0 and var_95_1 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321021", "story_v_out_116321.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_116321", "116321021", "story_v_out_116321.awb") / 1000

					if var_95_8 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_0
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_116321", "116321021", "story_v_out_116321.awb")

						arg_92_1:RecordAudio("116321021", var_95_9)
						arg_92_1:RecordAudio("116321021", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_116321", "116321021", "story_v_out_116321.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_116321", "116321021", "story_v_out_116321.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_10 and arg_92_1.time_ < var_95_0 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play116321022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 116321022
		arg_96_1.duration_ = 9.8

		local var_96_0 = {
			zh = 4.6,
			ja = 9.8
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play116321023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = "10014ui_story"

			if arg_96_1.actors_[var_99_0] == nil then
				local var_99_1 = Asset.Load("Char/" .. "10014ui_story")

				if not isNil(var_99_1) then
					local var_99_2 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_96_1.stage_.transform)

					var_99_2.name = var_99_0
					var_99_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_96_1.actors_[var_99_0] = var_99_2

					local var_99_3 = var_99_2:GetComponentInChildren(typeof(CharacterEffect))

					var_99_3.enabled = true

					local var_99_4 = GameObjectTools.GetOrAddComponent(var_99_2, typeof(DynamicBoneHelper))

					if var_99_4 then
						var_99_4:EnableDynamicBone(false)
					end

					arg_96_1:ShowWeapon(var_99_3.transform, false)

					arg_96_1.var_[var_99_0 .. "Animator"] = var_99_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_96_1.var_[var_99_0 .. "Animator"].applyRootMotion = true
					arg_96_1.var_[var_99_0 .. "LipSync"] = var_99_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_99_5 = arg_96_1.actors_["10014ui_story"].transform
			local var_99_6 = 0

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.var_.moveOldPos10014ui_story = var_99_5.localPosition
			end

			local var_99_7 = 0.001

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_7 then
				local var_99_8 = (arg_96_1.time_ - var_99_6) / var_99_7
				local var_99_9 = Vector3.New(0, -1.06, -6.2)

				var_99_5.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10014ui_story, var_99_9, var_99_8)

				local var_99_10 = manager.ui.mainCamera.transform.position - var_99_5.position

				var_99_5.forward = Vector3.New(var_99_10.x, var_99_10.y, var_99_10.z)

				local var_99_11 = var_99_5.localEulerAngles

				var_99_11.z = 0
				var_99_11.x = 0
				var_99_5.localEulerAngles = var_99_11
			end

			if arg_96_1.time_ >= var_99_6 + var_99_7 and arg_96_1.time_ < var_99_6 + var_99_7 + arg_99_0 then
				var_99_5.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_99_12 = manager.ui.mainCamera.transform.position - var_99_5.position

				var_99_5.forward = Vector3.New(var_99_12.x, var_99_12.y, var_99_12.z)

				local var_99_13 = var_99_5.localEulerAngles

				var_99_13.z = 0
				var_99_13.x = 0
				var_99_5.localEulerAngles = var_99_13
			end

			local var_99_14 = 0

			if var_99_14 < arg_96_1.time_ and arg_96_1.time_ <= var_99_14 + arg_99_0 then
				arg_96_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action6_1")
			end

			local var_99_15 = 0

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_99_16 = arg_96_1.actors_["10014ui_story"]
			local var_99_17 = 0

			if var_99_17 < arg_96_1.time_ and arg_96_1.time_ <= var_99_17 + arg_99_0 and not isNil(var_99_16) and arg_96_1.var_.characterEffect10014ui_story == nil then
				arg_96_1.var_.characterEffect10014ui_story = var_99_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_18 = 0.2

			if var_99_17 <= arg_96_1.time_ and arg_96_1.time_ < var_99_17 + var_99_18 and not isNil(var_99_16) then
				local var_99_19 = (arg_96_1.time_ - var_99_17) / var_99_18

				if arg_96_1.var_.characterEffect10014ui_story and not isNil(var_99_16) then
					arg_96_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_17 + var_99_18 and arg_96_1.time_ < var_99_17 + var_99_18 + arg_99_0 and not isNil(var_99_16) and arg_96_1.var_.characterEffect10014ui_story then
				arg_96_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_99_20 = 0
			local var_99_21 = 0.625

			if var_99_20 < arg_96_1.time_ and arg_96_1.time_ <= var_99_20 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_22 = arg_96_1:FormatText(StoryNameCfg[264].name)

				arg_96_1.leftNameTxt_.text = var_99_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_23 = arg_96_1:GetWordFromCfg(116321022)
				local var_99_24 = arg_96_1:FormatText(var_99_23.content)

				arg_96_1.text_.text = var_99_24

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_25 = 25
				local var_99_26 = utf8.len(var_99_24)
				local var_99_27 = var_99_25 <= 0 and var_99_21 or var_99_21 * (var_99_26 / var_99_25)

				if var_99_27 > 0 and var_99_21 < var_99_27 then
					arg_96_1.talkMaxDuration = var_99_27

					if var_99_27 + var_99_20 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_27 + var_99_20
					end
				end

				arg_96_1.text_.text = var_99_24
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321022", "story_v_out_116321.awb") ~= 0 then
					local var_99_28 = manager.audio:GetVoiceLength("story_v_out_116321", "116321022", "story_v_out_116321.awb") / 1000

					if var_99_28 + var_99_20 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_28 + var_99_20
					end

					if var_99_23.prefab_name ~= "" and arg_96_1.actors_[var_99_23.prefab_name] ~= nil then
						local var_99_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_23.prefab_name].transform, "story_v_out_116321", "116321022", "story_v_out_116321.awb")

						arg_96_1:RecordAudio("116321022", var_99_29)
						arg_96_1:RecordAudio("116321022", var_99_29)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_116321", "116321022", "story_v_out_116321.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_116321", "116321022", "story_v_out_116321.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_30 = math.max(var_99_21, arg_96_1.talkMaxDuration)

			if var_99_20 <= arg_96_1.time_ and arg_96_1.time_ < var_99_20 + var_99_30 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_20) / var_99_30

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_20 + var_99_30 and arg_96_1.time_ < var_99_20 + var_99_30 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play116321023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 116321023
		arg_100_1.duration_ = 3.93

		local var_100_0 = {
			zh = 3.933,
			ja = 3.466
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
				arg_100_0:Play116321024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["10014ui_story"].transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.var_.moveOldPos10014ui_story = var_103_0.localPosition
			end

			local var_103_2 = 0.001

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2
				local var_103_4 = Vector3.New(0, -1.06, -6.2)

				var_103_0.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10014ui_story, var_103_4, var_103_3)

				local var_103_5 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_5.x, var_103_5.y, var_103_5.z)

				local var_103_6 = var_103_0.localEulerAngles

				var_103_6.z = 0
				var_103_6.x = 0
				var_103_0.localEulerAngles = var_103_6
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 then
				var_103_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_103_7 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_7.x, var_103_7.y, var_103_7.z)

				local var_103_8 = var_103_0.localEulerAngles

				var_103_8.z = 0
				var_103_8.x = 0
				var_103_0.localEulerAngles = var_103_8
			end

			local var_103_9 = 0

			if var_103_9 < arg_100_1.time_ and arg_100_1.time_ <= var_103_9 + arg_103_0 then
				arg_100_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_103_10 = arg_100_1.actors_["10014ui_story"]
			local var_103_11 = 0

			if var_103_11 < arg_100_1.time_ and arg_100_1.time_ <= var_103_11 + arg_103_0 and not isNil(var_103_10) and arg_100_1.var_.characterEffect10014ui_story == nil then
				arg_100_1.var_.characterEffect10014ui_story = var_103_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_12 = 0.2

			if var_103_11 <= arg_100_1.time_ and arg_100_1.time_ < var_103_11 + var_103_12 and not isNil(var_103_10) then
				local var_103_13 = (arg_100_1.time_ - var_103_11) / var_103_12

				if arg_100_1.var_.characterEffect10014ui_story and not isNil(var_103_10) then
					arg_100_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_11 + var_103_12 and arg_100_1.time_ < var_103_11 + var_103_12 + arg_103_0 and not isNil(var_103_10) and arg_100_1.var_.characterEffect10014ui_story then
				arg_100_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_103_14 = 0

			if var_103_14 < arg_100_1.time_ and arg_100_1.time_ <= var_103_14 + arg_103_0 then
				arg_100_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action6_2")
			end

			local var_103_15 = 0
			local var_103_16 = 0.475

			if var_103_15 < arg_100_1.time_ and arg_100_1.time_ <= var_103_15 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_17 = arg_100_1:FormatText(StoryNameCfg[264].name)

				arg_100_1.leftNameTxt_.text = var_103_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_18 = arg_100_1:GetWordFromCfg(116321023)
				local var_103_19 = arg_100_1:FormatText(var_103_18.content)

				arg_100_1.text_.text = var_103_19

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_20 = 19
				local var_103_21 = utf8.len(var_103_19)
				local var_103_22 = var_103_20 <= 0 and var_103_16 or var_103_16 * (var_103_21 / var_103_20)

				if var_103_22 > 0 and var_103_16 < var_103_22 then
					arg_100_1.talkMaxDuration = var_103_22

					if var_103_22 + var_103_15 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_22 + var_103_15
					end
				end

				arg_100_1.text_.text = var_103_19
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321023", "story_v_out_116321.awb") ~= 0 then
					local var_103_23 = manager.audio:GetVoiceLength("story_v_out_116321", "116321023", "story_v_out_116321.awb") / 1000

					if var_103_23 + var_103_15 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_23 + var_103_15
					end

					if var_103_18.prefab_name ~= "" and arg_100_1.actors_[var_103_18.prefab_name] ~= nil then
						local var_103_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_18.prefab_name].transform, "story_v_out_116321", "116321023", "story_v_out_116321.awb")

						arg_100_1:RecordAudio("116321023", var_103_24)
						arg_100_1:RecordAudio("116321023", var_103_24)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_116321", "116321023", "story_v_out_116321.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_116321", "116321023", "story_v_out_116321.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_25 = math.max(var_103_16, arg_100_1.talkMaxDuration)

			if var_103_15 <= arg_100_1.time_ and arg_100_1.time_ < var_103_15 + var_103_25 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_15) / var_103_25

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_15 + var_103_25 and arg_100_1.time_ < var_103_15 + var_103_25 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play116321024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 116321024
		arg_104_1.duration_ = 8.47

		local var_104_0 = {
			zh = 4.733,
			ja = 8.466
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
				arg_104_0:Play116321025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10014ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos10014ui_story = var_107_0.localPosition
			end

			local var_107_2 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2
				local var_107_4 = Vector3.New(0, 100, 0)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10014ui_story, var_107_4, var_107_3)

				local var_107_5 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_5.x, var_107_5.y, var_107_5.z)

				local var_107_6 = var_107_0.localEulerAngles

				var_107_6.z = 0
				var_107_6.x = 0
				var_107_0.localEulerAngles = var_107_6
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, 100, 0)

				local var_107_7 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_7.x, var_107_7.y, var_107_7.z)

				local var_107_8 = var_107_0.localEulerAngles

				var_107_8.z = 0
				var_107_8.x = 0
				var_107_0.localEulerAngles = var_107_8
			end

			local var_107_9 = 0
			local var_107_10 = 0.55

			if var_107_9 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_11 = arg_104_1:FormatText(StoryNameCfg[338].name)

				arg_104_1.leftNameTxt_.text = var_107_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_12 = arg_104_1:GetWordFromCfg(116321024)
				local var_107_13 = arg_104_1:FormatText(var_107_12.content)

				arg_104_1.text_.text = var_107_13

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_14 = 22
				local var_107_15 = utf8.len(var_107_13)
				local var_107_16 = var_107_14 <= 0 and var_107_10 or var_107_10 * (var_107_15 / var_107_14)

				if var_107_16 > 0 and var_107_10 < var_107_16 then
					arg_104_1.talkMaxDuration = var_107_16

					if var_107_16 + var_107_9 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_16 + var_107_9
					end
				end

				arg_104_1.text_.text = var_107_13
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321024", "story_v_out_116321.awb") ~= 0 then
					local var_107_17 = manager.audio:GetVoiceLength("story_v_out_116321", "116321024", "story_v_out_116321.awb") / 1000

					if var_107_17 + var_107_9 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_17 + var_107_9
					end

					if var_107_12.prefab_name ~= "" and arg_104_1.actors_[var_107_12.prefab_name] ~= nil then
						local var_107_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_12.prefab_name].transform, "story_v_out_116321", "116321024", "story_v_out_116321.awb")

						arg_104_1:RecordAudio("116321024", var_107_18)
						arg_104_1:RecordAudio("116321024", var_107_18)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_116321", "116321024", "story_v_out_116321.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_116321", "116321024", "story_v_out_116321.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_19 = math.max(var_107_10, arg_104_1.talkMaxDuration)

			if var_107_9 <= arg_104_1.time_ and arg_104_1.time_ < var_107_9 + var_107_19 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_9) / var_107_19

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_9 + var_107_19 and arg_104_1.time_ < var_107_9 + var_107_19 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play116321025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 116321025
		arg_108_1.duration_ = 17.3

		local var_108_0 = {
			zh = 12.866,
			ja = 17.3
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
				arg_108_0:Play116321026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 1.15

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

				local var_111_2 = arg_108_1:GetWordFromCfg(116321025)
				local var_111_3 = arg_108_1:FormatText(var_111_2.content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321025", "story_v_out_116321.awb") ~= 0 then
					local var_111_7 = manager.audio:GetVoiceLength("story_v_out_116321", "116321025", "story_v_out_116321.awb") / 1000

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end

					if var_111_2.prefab_name ~= "" and arg_108_1.actors_[var_111_2.prefab_name] ~= nil then
						local var_111_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_2.prefab_name].transform, "story_v_out_116321", "116321025", "story_v_out_116321.awb")

						arg_108_1:RecordAudio("116321025", var_111_8)
						arg_108_1:RecordAudio("116321025", var_111_8)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_116321", "116321025", "story_v_out_116321.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_116321", "116321025", "story_v_out_116321.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_9 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_9 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_9

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_9 and arg_108_1.time_ < var_111_0 + var_111_9 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play116321026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 116321026
		arg_112_1.duration_ = 5.57

		local var_112_0 = {
			zh = 4.333,
			ja = 5.566
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
				arg_112_0:Play116321027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10032ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos10032ui_story = var_115_0.localPosition
			end

			local var_115_2 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2
				local var_115_4 = Vector3.New(0, -1.1, -5.9)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10032ui_story, var_115_4, var_115_3)

				local var_115_5 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_5.x, var_115_5.y, var_115_5.z)

				local var_115_6 = var_115_0.localEulerAngles

				var_115_6.z = 0
				var_115_6.x = 0
				var_115_0.localEulerAngles = var_115_6
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_115_7 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_7.x, var_115_7.y, var_115_7.z)

				local var_115_8 = var_115_0.localEulerAngles

				var_115_8.z = 0
				var_115_8.x = 0
				var_115_0.localEulerAngles = var_115_8
			end

			local var_115_9 = 0

			if var_115_9 < arg_112_1.time_ and arg_112_1.time_ <= var_115_9 + arg_115_0 then
				arg_112_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_115_10 = 0
			local var_115_11 = 0.425

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_12 = arg_112_1:FormatText(StoryNameCfg[332].name)

				arg_112_1.leftNameTxt_.text = var_115_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_13 = arg_112_1:GetWordFromCfg(116321026)
				local var_115_14 = arg_112_1:FormatText(var_115_13.content)

				arg_112_1.text_.text = var_115_14

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_15 = 17
				local var_115_16 = utf8.len(var_115_14)
				local var_115_17 = var_115_15 <= 0 and var_115_11 or var_115_11 * (var_115_16 / var_115_15)

				if var_115_17 > 0 and var_115_11 < var_115_17 then
					arg_112_1.talkMaxDuration = var_115_17

					if var_115_17 + var_115_10 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_17 + var_115_10
					end
				end

				arg_112_1.text_.text = var_115_14
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321026", "story_v_out_116321.awb") ~= 0 then
					local var_115_18 = manager.audio:GetVoiceLength("story_v_out_116321", "116321026", "story_v_out_116321.awb") / 1000

					if var_115_18 + var_115_10 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_18 + var_115_10
					end

					if var_115_13.prefab_name ~= "" and arg_112_1.actors_[var_115_13.prefab_name] ~= nil then
						local var_115_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_13.prefab_name].transform, "story_v_out_116321", "116321026", "story_v_out_116321.awb")

						arg_112_1:RecordAudio("116321026", var_115_19)
						arg_112_1:RecordAudio("116321026", var_115_19)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_116321", "116321026", "story_v_out_116321.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_116321", "116321026", "story_v_out_116321.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_20 = math.max(var_115_11, arg_112_1.talkMaxDuration)

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_20 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_10) / var_115_20

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_10 + var_115_20 and arg_112_1.time_ < var_115_10 + var_115_20 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play116321027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 116321027
		arg_116_1.duration_ = 5.53

		local var_116_0 = {
			zh = 4.1,
			ja = 5.533
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
				arg_116_0:Play116321028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_119_1 = arg_116_1.actors_["10032ui_story"]
			local var_119_2 = 0

			if var_119_2 < arg_116_1.time_ and arg_116_1.time_ <= var_119_2 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect10032ui_story == nil then
				arg_116_1.var_.characterEffect10032ui_story = var_119_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_3 = 0.2

			if var_119_2 <= arg_116_1.time_ and arg_116_1.time_ < var_119_2 + var_119_3 and not isNil(var_119_1) then
				local var_119_4 = (arg_116_1.time_ - var_119_2) / var_119_3

				if arg_116_1.var_.characterEffect10032ui_story and not isNil(var_119_1) then
					arg_116_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_2 + var_119_3 and arg_116_1.time_ < var_119_2 + var_119_3 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect10032ui_story then
				arg_116_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_119_6 = 0
			local var_119_7 = 0.325

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_8 = arg_116_1:FormatText(StoryNameCfg[328].name)

				arg_116_1.leftNameTxt_.text = var_119_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_9 = arg_116_1:GetWordFromCfg(116321027)
				local var_119_10 = arg_116_1:FormatText(var_119_9.content)

				arg_116_1.text_.text = var_119_10

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 13
				local var_119_12 = utf8.len(var_119_10)
				local var_119_13 = var_119_11 <= 0 and var_119_7 or var_119_7 * (var_119_12 / var_119_11)

				if var_119_13 > 0 and var_119_7 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_10
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321027", "story_v_out_116321.awb") ~= 0 then
					local var_119_14 = manager.audio:GetVoiceLength("story_v_out_116321", "116321027", "story_v_out_116321.awb") / 1000

					if var_119_14 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_6
					end

					if var_119_9.prefab_name ~= "" and arg_116_1.actors_[var_119_9.prefab_name] ~= nil then
						local var_119_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_9.prefab_name].transform, "story_v_out_116321", "116321027", "story_v_out_116321.awb")

						arg_116_1:RecordAudio("116321027", var_119_15)
						arg_116_1:RecordAudio("116321027", var_119_15)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_116321", "116321027", "story_v_out_116321.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_116321", "116321027", "story_v_out_116321.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_16 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_16 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_16

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_16 and arg_116_1.time_ < var_119_6 + var_119_16 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play116321028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 116321028
		arg_120_1.duration_ = 5.3

		local var_120_0 = {
			zh = 3.8,
			ja = 5.3
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
				arg_120_0:Play116321029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["10032ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos10032ui_story = var_123_0.localPosition
			end

			local var_123_2 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2
				local var_123_4 = Vector3.New(0, -1.1, -5.9)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos10032ui_story, var_123_4, var_123_3)

				local var_123_5 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_5.x, var_123_5.y, var_123_5.z)

				local var_123_6 = var_123_0.localEulerAngles

				var_123_6.z = 0
				var_123_6.x = 0
				var_123_0.localEulerAngles = var_123_6
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_123_7 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_7.x, var_123_7.y, var_123_7.z)

				local var_123_8 = var_123_0.localEulerAngles

				var_123_8.z = 0
				var_123_8.x = 0
				var_123_0.localEulerAngles = var_123_8
			end

			local var_123_9 = arg_120_1.actors_["10032ui_story"]
			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect10032ui_story == nil then
				arg_120_1.var_.characterEffect10032ui_story = var_123_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_11 = 0.2

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_11 and not isNil(var_123_9) then
				local var_123_12 = (arg_120_1.time_ - var_123_10) / var_123_11

				if arg_120_1.var_.characterEffect10032ui_story and not isNil(var_123_9) then
					local var_123_13 = Mathf.Lerp(0, 0.5, var_123_12)

					arg_120_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_120_1.var_.characterEffect10032ui_story.fillRatio = var_123_13
				end
			end

			if arg_120_1.time_ >= var_123_10 + var_123_11 and arg_120_1.time_ < var_123_10 + var_123_11 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect10032ui_story then
				local var_123_14 = 0.5

				arg_120_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_120_1.var_.characterEffect10032ui_story.fillRatio = var_123_14
			end

			local var_123_15 = 0
			local var_123_16 = 0.4

			if var_123_15 < arg_120_1.time_ and arg_120_1.time_ <= var_123_15 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_17 = arg_120_1:FormatText(StoryNameCfg[332].name)

				arg_120_1.leftNameTxt_.text = var_123_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_18 = arg_120_1:GetWordFromCfg(116321028)
				local var_123_19 = arg_120_1:FormatText(var_123_18.content)

				arg_120_1.text_.text = var_123_19

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_20 = 16
				local var_123_21 = utf8.len(var_123_19)
				local var_123_22 = var_123_20 <= 0 and var_123_16 or var_123_16 * (var_123_21 / var_123_20)

				if var_123_22 > 0 and var_123_16 < var_123_22 then
					arg_120_1.talkMaxDuration = var_123_22

					if var_123_22 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_22 + var_123_15
					end
				end

				arg_120_1.text_.text = var_123_19
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321028", "story_v_out_116321.awb") ~= 0 then
					local var_123_23 = manager.audio:GetVoiceLength("story_v_out_116321", "116321028", "story_v_out_116321.awb") / 1000

					if var_123_23 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_23 + var_123_15
					end

					if var_123_18.prefab_name ~= "" and arg_120_1.actors_[var_123_18.prefab_name] ~= nil then
						local var_123_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_18.prefab_name].transform, "story_v_out_116321", "116321028", "story_v_out_116321.awb")

						arg_120_1:RecordAudio("116321028", var_123_24)
						arg_120_1:RecordAudio("116321028", var_123_24)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_116321", "116321028", "story_v_out_116321.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_116321", "116321028", "story_v_out_116321.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_25 = math.max(var_123_16, arg_120_1.talkMaxDuration)

			if var_123_15 <= arg_120_1.time_ and arg_120_1.time_ < var_123_15 + var_123_25 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_15) / var_123_25

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_15 + var_123_25 and arg_120_1.time_ < var_123_15 + var_123_25 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play116321029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 116321029
		arg_124_1.duration_ = 10.37

		local var_124_0 = {
			zh = 10.366,
			ja = 7.133
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play116321030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_1")
			end

			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_127_2 = arg_124_1.actors_["10032ui_story"]
			local var_127_3 = 0

			if var_127_3 < arg_124_1.time_ and arg_124_1.time_ <= var_127_3 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.characterEffect10032ui_story == nil then
				arg_124_1.var_.characterEffect10032ui_story = var_127_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_4 = 0.2

			if var_127_3 <= arg_124_1.time_ and arg_124_1.time_ < var_127_3 + var_127_4 and not isNil(var_127_2) then
				local var_127_5 = (arg_124_1.time_ - var_127_3) / var_127_4

				if arg_124_1.var_.characterEffect10032ui_story and not isNil(var_127_2) then
					arg_124_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_3 + var_127_4 and arg_124_1.time_ < var_127_3 + var_127_4 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.characterEffect10032ui_story then
				arg_124_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_127_6 = 0
			local var_127_7 = 0.75

			if var_127_6 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_8 = arg_124_1:FormatText(StoryNameCfg[328].name)

				arg_124_1.leftNameTxt_.text = var_127_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_9 = arg_124_1:GetWordFromCfg(116321029)
				local var_127_10 = arg_124_1:FormatText(var_127_9.content)

				arg_124_1.text_.text = var_127_10

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_11 = 30
				local var_127_12 = utf8.len(var_127_10)
				local var_127_13 = var_127_11 <= 0 and var_127_7 or var_127_7 * (var_127_12 / var_127_11)

				if var_127_13 > 0 and var_127_7 < var_127_13 then
					arg_124_1.talkMaxDuration = var_127_13

					if var_127_13 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_13 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_10
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321029", "story_v_out_116321.awb") ~= 0 then
					local var_127_14 = manager.audio:GetVoiceLength("story_v_out_116321", "116321029", "story_v_out_116321.awb") / 1000

					if var_127_14 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_14 + var_127_6
					end

					if var_127_9.prefab_name ~= "" and arg_124_1.actors_[var_127_9.prefab_name] ~= nil then
						local var_127_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_9.prefab_name].transform, "story_v_out_116321", "116321029", "story_v_out_116321.awb")

						arg_124_1:RecordAudio("116321029", var_127_15)
						arg_124_1:RecordAudio("116321029", var_127_15)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_116321", "116321029", "story_v_out_116321.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_116321", "116321029", "story_v_out_116321.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_16 and arg_124_1.time_ < var_127_6 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play116321030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 116321030
		arg_128_1.duration_ = 5.67

		local var_128_0 = {
			zh = 5.666,
			ja = 3.066
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
				arg_128_0:Play116321031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_131_1 = 0
			local var_131_2 = 0.475

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_3 = arg_128_1:FormatText(StoryNameCfg[328].name)

				arg_128_1.leftNameTxt_.text = var_131_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_4 = arg_128_1:GetWordFromCfg(116321030)
				local var_131_5 = arg_128_1:FormatText(var_131_4.content)

				arg_128_1.text_.text = var_131_5

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_6 = 19
				local var_131_7 = utf8.len(var_131_5)
				local var_131_8 = var_131_6 <= 0 and var_131_2 or var_131_2 * (var_131_7 / var_131_6)

				if var_131_8 > 0 and var_131_2 < var_131_8 then
					arg_128_1.talkMaxDuration = var_131_8

					if var_131_8 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_1
					end
				end

				arg_128_1.text_.text = var_131_5
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321030", "story_v_out_116321.awb") ~= 0 then
					local var_131_9 = manager.audio:GetVoiceLength("story_v_out_116321", "116321030", "story_v_out_116321.awb") / 1000

					if var_131_9 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_1
					end

					if var_131_4.prefab_name ~= "" and arg_128_1.actors_[var_131_4.prefab_name] ~= nil then
						local var_131_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_4.prefab_name].transform, "story_v_out_116321", "116321030", "story_v_out_116321.awb")

						arg_128_1:RecordAudio("116321030", var_131_10)
						arg_128_1:RecordAudio("116321030", var_131_10)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_116321", "116321030", "story_v_out_116321.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_116321", "116321030", "story_v_out_116321.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_11 = math.max(var_131_2, arg_128_1.talkMaxDuration)

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_11 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_1) / var_131_11

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_1 + var_131_11 and arg_128_1.time_ < var_131_1 + var_131_11 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play116321031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 116321031
		arg_132_1.duration_ = 5.63

		local var_132_0 = {
			zh = 4.233,
			ja = 5.633
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play116321032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["10032ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect10032ui_story == nil then
				arg_132_1.var_.characterEffect10032ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect10032ui_story and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_132_1.var_.characterEffect10032ui_story.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect10032ui_story then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_132_1.var_.characterEffect10032ui_story.fillRatio = var_135_5
			end

			local var_135_6 = 0
			local var_135_7 = 0.4

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_8 = arg_132_1:FormatText(StoryNameCfg[332].name)

				arg_132_1.leftNameTxt_.text = var_135_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_9 = arg_132_1:GetWordFromCfg(116321031)
				local var_135_10 = arg_132_1:FormatText(var_135_9.content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321031", "story_v_out_116321.awb") ~= 0 then
					local var_135_14 = manager.audio:GetVoiceLength("story_v_out_116321", "116321031", "story_v_out_116321.awb") / 1000

					if var_135_14 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_14 + var_135_6
					end

					if var_135_9.prefab_name ~= "" and arg_132_1.actors_[var_135_9.prefab_name] ~= nil then
						local var_135_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_9.prefab_name].transform, "story_v_out_116321", "116321031", "story_v_out_116321.awb")

						arg_132_1:RecordAudio("116321031", var_135_15)
						arg_132_1:RecordAudio("116321031", var_135_15)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_116321", "116321031", "story_v_out_116321.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_116321", "116321031", "story_v_out_116321.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_16 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_16 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_16

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_16 and arg_132_1.time_ < var_135_6 + var_135_16 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play116321032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 116321032
		arg_136_1.duration_ = 15.43

		local var_136_0 = {
			zh = 10.333,
			ja = 15.433
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
				arg_136_0:Play116321033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = "10024ui_story"

			if arg_136_1.actors_[var_139_0] == nil then
				local var_139_1 = Asset.Load("Char/" .. "10024ui_story")

				if not isNil(var_139_1) then
					local var_139_2 = Object.Instantiate(Asset.Load("Char/" .. "10024ui_story"), arg_136_1.stage_.transform)

					var_139_2.name = var_139_0
					var_139_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_136_1.actors_[var_139_0] = var_139_2

					local var_139_3 = var_139_2:GetComponentInChildren(typeof(CharacterEffect))

					var_139_3.enabled = true

					local var_139_4 = GameObjectTools.GetOrAddComponent(var_139_2, typeof(DynamicBoneHelper))

					if var_139_4 then
						var_139_4:EnableDynamicBone(false)
					end

					arg_136_1:ShowWeapon(var_139_3.transform, false)

					arg_136_1.var_[var_139_0 .. "Animator"] = var_139_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_136_1.var_[var_139_0 .. "Animator"].applyRootMotion = true
					arg_136_1.var_[var_139_0 .. "LipSync"] = var_139_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_139_5 = arg_136_1.actors_["10024ui_story"].transform
			local var_139_6 = 0

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.var_.moveOldPos10024ui_story = var_139_5.localPosition
			end

			local var_139_7 = 0.001

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_7 then
				local var_139_8 = (arg_136_1.time_ - var_139_6) / var_139_7
				local var_139_9 = Vector3.New(0, 100, 0)

				var_139_5.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10024ui_story, var_139_9, var_139_8)

				local var_139_10 = manager.ui.mainCamera.transform.position - var_139_5.position

				var_139_5.forward = Vector3.New(var_139_10.x, var_139_10.y, var_139_10.z)

				local var_139_11 = var_139_5.localEulerAngles

				var_139_11.z = 0
				var_139_11.x = 0
				var_139_5.localEulerAngles = var_139_11
			end

			if arg_136_1.time_ >= var_139_6 + var_139_7 and arg_136_1.time_ < var_139_6 + var_139_7 + arg_139_0 then
				var_139_5.localPosition = Vector3.New(0, 100, 0)

				local var_139_12 = manager.ui.mainCamera.transform.position - var_139_5.position

				var_139_5.forward = Vector3.New(var_139_12.x, var_139_12.y, var_139_12.z)

				local var_139_13 = var_139_5.localEulerAngles

				var_139_13.z = 0
				var_139_13.x = 0
				var_139_5.localEulerAngles = var_139_13
			end

			local var_139_14 = arg_136_1.actors_["10032ui_story"].transform
			local var_139_15 = 0

			if var_139_15 < arg_136_1.time_ and arg_136_1.time_ <= var_139_15 + arg_139_0 then
				arg_136_1.var_.moveOldPos10032ui_story = var_139_14.localPosition
			end

			local var_139_16 = 0.001

			if var_139_15 <= arg_136_1.time_ and arg_136_1.time_ < var_139_15 + var_139_16 then
				local var_139_17 = (arg_136_1.time_ - var_139_15) / var_139_16
				local var_139_18 = Vector3.New(0, 100, 0)

				var_139_14.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10032ui_story, var_139_18, var_139_17)

				local var_139_19 = manager.ui.mainCamera.transform.position - var_139_14.position

				var_139_14.forward = Vector3.New(var_139_19.x, var_139_19.y, var_139_19.z)

				local var_139_20 = var_139_14.localEulerAngles

				var_139_20.z = 0
				var_139_20.x = 0
				var_139_14.localEulerAngles = var_139_20
			end

			if arg_136_1.time_ >= var_139_15 + var_139_16 and arg_136_1.time_ < var_139_15 + var_139_16 + arg_139_0 then
				var_139_14.localPosition = Vector3.New(0, 100, 0)

				local var_139_21 = manager.ui.mainCamera.transform.position - var_139_14.position

				var_139_14.forward = Vector3.New(var_139_21.x, var_139_21.y, var_139_21.z)

				local var_139_22 = var_139_14.localEulerAngles

				var_139_22.z = 0
				var_139_22.x = 0
				var_139_14.localEulerAngles = var_139_22
			end

			local var_139_23 = 0
			local var_139_24 = 0.95

			if var_139_23 < arg_136_1.time_ and arg_136_1.time_ <= var_139_23 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_25 = arg_136_1:GetWordFromCfg(116321032)
				local var_139_26 = arg_136_1:FormatText(var_139_25.content)

				arg_136_1.text_.text = var_139_26

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_27 = 38
				local var_139_28 = utf8.len(var_139_26)
				local var_139_29 = var_139_27 <= 0 and var_139_24 or var_139_24 * (var_139_28 / var_139_27)

				if var_139_29 > 0 and var_139_24 < var_139_29 then
					arg_136_1.talkMaxDuration = var_139_29

					if var_139_29 + var_139_23 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_29 + var_139_23
					end
				end

				arg_136_1.text_.text = var_139_26
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321032", "story_v_out_116321.awb") ~= 0 then
					local var_139_30 = manager.audio:GetVoiceLength("story_v_out_116321", "116321032", "story_v_out_116321.awb") / 1000

					if var_139_30 + var_139_23 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_30 + var_139_23
					end

					if var_139_25.prefab_name ~= "" and arg_136_1.actors_[var_139_25.prefab_name] ~= nil then
						local var_139_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_25.prefab_name].transform, "story_v_out_116321", "116321032", "story_v_out_116321.awb")

						arg_136_1:RecordAudio("116321032", var_139_31)
						arg_136_1:RecordAudio("116321032", var_139_31)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_116321", "116321032", "story_v_out_116321.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_116321", "116321032", "story_v_out_116321.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_32 = math.max(var_139_24, arg_136_1.talkMaxDuration)

			if var_139_23 <= arg_136_1.time_ and arg_136_1.time_ < var_139_23 + var_139_32 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_23) / var_139_32

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_23 + var_139_32 and arg_136_1.time_ < var_139_23 + var_139_32 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play116321033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 116321033
		arg_140_1.duration_ = 13.1

		local var_140_0 = {
			zh = 13.1,
			ja = 9.4
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play116321034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 1.2

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_2 = arg_140_1:GetWordFromCfg(116321033)
				local var_143_3 = arg_140_1:FormatText(var_143_2.content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_4 = 48
				local var_143_5 = utf8.len(var_143_3)
				local var_143_6 = var_143_4 <= 0 and var_143_1 or var_143_1 * (var_143_5 / var_143_4)

				if var_143_6 > 0 and var_143_1 < var_143_6 then
					arg_140_1.talkMaxDuration = var_143_6

					if var_143_6 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_6 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321033", "story_v_out_116321.awb") ~= 0 then
					local var_143_7 = manager.audio:GetVoiceLength("story_v_out_116321", "116321033", "story_v_out_116321.awb") / 1000

					if var_143_7 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_0
					end

					if var_143_2.prefab_name ~= "" and arg_140_1.actors_[var_143_2.prefab_name] ~= nil then
						local var_143_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_2.prefab_name].transform, "story_v_out_116321", "116321033", "story_v_out_116321.awb")

						arg_140_1:RecordAudio("116321033", var_143_8)
						arg_140_1:RecordAudio("116321033", var_143_8)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_116321", "116321033", "story_v_out_116321.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_116321", "116321033", "story_v_out_116321.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_9 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_9 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_9

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_9 and arg_140_1.time_ < var_143_0 + var_143_9 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play116321034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 116321034
		arg_144_1.duration_ = 10.57

		local var_144_0 = {
			zh = 9.9,
			ja = 10.566
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
				arg_144_0:Play116321035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.95

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_2 = arg_144_1:GetWordFromCfg(116321034)
				local var_147_3 = arg_144_1:FormatText(var_147_2.content)

				arg_144_1.text_.text = var_147_3

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 38
				local var_147_5 = utf8.len(var_147_3)
				local var_147_6 = var_147_4 <= 0 and var_147_1 or var_147_1 * (var_147_5 / var_147_4)

				if var_147_6 > 0 and var_147_1 < var_147_6 then
					arg_144_1.talkMaxDuration = var_147_6

					if var_147_6 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_6 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_3
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321034", "story_v_out_116321.awb") ~= 0 then
					local var_147_7 = manager.audio:GetVoiceLength("story_v_out_116321", "116321034", "story_v_out_116321.awb") / 1000

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end

					if var_147_2.prefab_name ~= "" and arg_144_1.actors_[var_147_2.prefab_name] ~= nil then
						local var_147_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_2.prefab_name].transform, "story_v_out_116321", "116321034", "story_v_out_116321.awb")

						arg_144_1:RecordAudio("116321034", var_147_8)
						arg_144_1:RecordAudio("116321034", var_147_8)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_116321", "116321034", "story_v_out_116321.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_116321", "116321034", "story_v_out_116321.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_9 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_9 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_9

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_9 and arg_144_1.time_ < var_147_0 + var_147_9 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play116321035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 116321035
		arg_148_1.duration_ = 7.93

		local var_148_0 = {
			zh = 5.833,
			ja = 7.933
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play116321036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 0.55

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_2 = arg_148_1:GetWordFromCfg(116321035)
				local var_151_3 = arg_148_1:FormatText(var_151_2.content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 22
				local var_151_5 = utf8.len(var_151_3)
				local var_151_6 = var_151_4 <= 0 and var_151_1 or var_151_1 * (var_151_5 / var_151_4)

				if var_151_6 > 0 and var_151_1 < var_151_6 then
					arg_148_1.talkMaxDuration = var_151_6

					if var_151_6 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_3
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321035", "story_v_out_116321.awb") ~= 0 then
					local var_151_7 = manager.audio:GetVoiceLength("story_v_out_116321", "116321035", "story_v_out_116321.awb") / 1000

					if var_151_7 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_0
					end

					if var_151_2.prefab_name ~= "" and arg_148_1.actors_[var_151_2.prefab_name] ~= nil then
						local var_151_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_2.prefab_name].transform, "story_v_out_116321", "116321035", "story_v_out_116321.awb")

						arg_148_1:RecordAudio("116321035", var_151_8)
						arg_148_1:RecordAudio("116321035", var_151_8)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_116321", "116321035", "story_v_out_116321.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_116321", "116321035", "story_v_out_116321.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_9 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_9 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_9

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_9 and arg_148_1.time_ < var_151_0 + var_151_9 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play116321036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 116321036
		arg_152_1.duration_ = 5.9

		local var_152_0 = {
			zh = 5.9,
			ja = 4.066
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play116321037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.625

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[340].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:GetWordFromCfg(116321036)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321036", "story_v_out_116321.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_116321", "116321036", "story_v_out_116321.awb") / 1000

					if var_155_8 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_0
					end

					if var_155_3.prefab_name ~= "" and arg_152_1.actors_[var_155_3.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_3.prefab_name].transform, "story_v_out_116321", "116321036", "story_v_out_116321.awb")

						arg_152_1:RecordAudio("116321036", var_155_9)
						arg_152_1:RecordAudio("116321036", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_116321", "116321036", "story_v_out_116321.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_116321", "116321036", "story_v_out_116321.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_10 and arg_152_1.time_ < var_155_0 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play116321037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 116321037
		arg_156_1.duration_ = 9.1

		local var_156_0 = {
			zh = 5.966,
			ja = 9.1
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
				arg_156_0:Play116321038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 0.266666666666667

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				local var_159_2 = "play"
				local var_159_3 = "music"

				arg_156_1:AudioAction(var_159_2, var_159_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_159_4 = ""
				local var_159_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_159_5 ~= "" then
					if arg_156_1.bgmTxt_.text ~= var_159_5 and arg_156_1.bgmTxt_.text ~= "" then
						if arg_156_1.bgmTxt2_.text ~= "" then
							arg_156_1.bgmTxt_.text = arg_156_1.bgmTxt2_.text
						end

						arg_156_1.bgmTxt2_.text = var_159_5

						arg_156_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_156_1.bgmTxt_.text = var_159_5
						arg_156_1.bgmTxt2_.text = var_159_5
					end

					if arg_156_1.bgmTimer then
						arg_156_1.bgmTimer:Stop()

						arg_156_1.bgmTimer = nil
					end

					if arg_156_1.settingData.show_music_name == 1 then
						arg_156_1.musicController:SetSelectedState("show")
						arg_156_1.musicAnimator_:Play("open", 0, 0)

						if arg_156_1.settingData.music_time ~= 0 then
							arg_156_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_156_1.settingData.music_time), function()
								if arg_156_1 == nil or isNil(arg_156_1.bgmTxt_) then
									return
								end

								arg_156_1.musicController:SetSelectedState("hide")
								arg_156_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_159_6 = arg_156_1.actors_["10014ui_story"].transform
			local var_159_7 = 0

			if var_159_7 < arg_156_1.time_ and arg_156_1.time_ <= var_159_7 + arg_159_0 then
				arg_156_1.var_.moveOldPos10014ui_story = var_159_6.localPosition
			end

			local var_159_8 = 0.001

			if var_159_7 <= arg_156_1.time_ and arg_156_1.time_ < var_159_7 + var_159_8 then
				local var_159_9 = (arg_156_1.time_ - var_159_7) / var_159_8
				local var_159_10 = Vector3.New(0, -1.06, -6.2)

				var_159_6.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10014ui_story, var_159_10, var_159_9)

				local var_159_11 = manager.ui.mainCamera.transform.position - var_159_6.position

				var_159_6.forward = Vector3.New(var_159_11.x, var_159_11.y, var_159_11.z)

				local var_159_12 = var_159_6.localEulerAngles

				var_159_12.z = 0
				var_159_12.x = 0
				var_159_6.localEulerAngles = var_159_12
			end

			if arg_156_1.time_ >= var_159_7 + var_159_8 and arg_156_1.time_ < var_159_7 + var_159_8 + arg_159_0 then
				var_159_6.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_159_13 = manager.ui.mainCamera.transform.position - var_159_6.position

				var_159_6.forward = Vector3.New(var_159_13.x, var_159_13.y, var_159_13.z)

				local var_159_14 = var_159_6.localEulerAngles

				var_159_14.z = 0
				var_159_14.x = 0
				var_159_6.localEulerAngles = var_159_14
			end

			local var_159_15 = 0

			if var_159_15 < arg_156_1.time_ and arg_156_1.time_ <= var_159_15 + arg_159_0 then
				arg_156_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_159_16 = 0

			if var_159_16 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 then
				arg_156_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_159_17 = arg_156_1.actors_["10014ui_story"]
			local var_159_18 = 0

			if var_159_18 < arg_156_1.time_ and arg_156_1.time_ <= var_159_18 + arg_159_0 and not isNil(var_159_17) and arg_156_1.var_.characterEffect10014ui_story == nil then
				arg_156_1.var_.characterEffect10014ui_story = var_159_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_19 = 0.2

			if var_159_18 <= arg_156_1.time_ and arg_156_1.time_ < var_159_18 + var_159_19 and not isNil(var_159_17) then
				local var_159_20 = (arg_156_1.time_ - var_159_18) / var_159_19

				if arg_156_1.var_.characterEffect10014ui_story and not isNil(var_159_17) then
					arg_156_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_18 + var_159_19 and arg_156_1.time_ < var_159_18 + var_159_19 + arg_159_0 and not isNil(var_159_17) and arg_156_1.var_.characterEffect10014ui_story then
				arg_156_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_159_21 = 0
			local var_159_22 = 0.8

			if var_159_21 < arg_156_1.time_ and arg_156_1.time_ <= var_159_21 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_23 = arg_156_1:FormatText(StoryNameCfg[264].name)

				arg_156_1.leftNameTxt_.text = var_159_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_24 = arg_156_1:GetWordFromCfg(116321037)
				local var_159_25 = arg_156_1:FormatText(var_159_24.content)

				arg_156_1.text_.text = var_159_25

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_26 = 32
				local var_159_27 = utf8.len(var_159_25)
				local var_159_28 = var_159_26 <= 0 and var_159_22 or var_159_22 * (var_159_27 / var_159_26)

				if var_159_28 > 0 and var_159_22 < var_159_28 then
					arg_156_1.talkMaxDuration = var_159_28

					if var_159_28 + var_159_21 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_28 + var_159_21
					end
				end

				arg_156_1.text_.text = var_159_25
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321037", "story_v_out_116321.awb") ~= 0 then
					local var_159_29 = manager.audio:GetVoiceLength("story_v_out_116321", "116321037", "story_v_out_116321.awb") / 1000

					if var_159_29 + var_159_21 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_29 + var_159_21
					end

					if var_159_24.prefab_name ~= "" and arg_156_1.actors_[var_159_24.prefab_name] ~= nil then
						local var_159_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_24.prefab_name].transform, "story_v_out_116321", "116321037", "story_v_out_116321.awb")

						arg_156_1:RecordAudio("116321037", var_159_30)
						arg_156_1:RecordAudio("116321037", var_159_30)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_116321", "116321037", "story_v_out_116321.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_116321", "116321037", "story_v_out_116321.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_31 = math.max(var_159_22, arg_156_1.talkMaxDuration)

			if var_159_21 <= arg_156_1.time_ and arg_156_1.time_ < var_159_21 + var_159_31 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_21) / var_159_31

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_21 + var_159_31 and arg_156_1.time_ < var_159_21 + var_159_31 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play116321038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 116321038
		arg_161_1.duration_ = 1.73

		local var_161_0 = {
			zh = 1.5,
			ja = 1.733
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
				arg_161_0:Play116321039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10014ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect10014ui_story == nil then
				arg_161_1.var_.characterEffect10014ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect10014ui_story and not isNil(var_164_0) then
					local var_164_4 = Mathf.Lerp(0, 0.5, var_164_3)

					arg_161_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10014ui_story.fillRatio = var_164_4
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect10014ui_story then
				local var_164_5 = 0.5

				arg_161_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10014ui_story.fillRatio = var_164_5
			end

			local var_164_6 = 0
			local var_164_7 = 0.15

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_8 = arg_161_1:FormatText(StoryNameCfg[341].name)

				arg_161_1.leftNameTxt_.text = var_164_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_9 = arg_161_1:GetWordFromCfg(116321038)
				local var_164_10 = arg_161_1:FormatText(var_164_9.content)

				arg_161_1.text_.text = var_164_10

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 6
				local var_164_12 = utf8.len(var_164_10)
				local var_164_13 = var_164_11 <= 0 and var_164_7 or var_164_7 * (var_164_12 / var_164_11)

				if var_164_13 > 0 and var_164_7 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_10
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321038", "story_v_out_116321.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_out_116321", "116321038", "story_v_out_116321.awb") / 1000

					if var_164_14 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_6
					end

					if var_164_9.prefab_name ~= "" and arg_161_1.actors_[var_164_9.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_9.prefab_name].transform, "story_v_out_116321", "116321038", "story_v_out_116321.awb")

						arg_161_1:RecordAudio("116321038", var_164_15)
						arg_161_1:RecordAudio("116321038", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_116321", "116321038", "story_v_out_116321.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_116321", "116321038", "story_v_out_116321.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_16 and arg_161_1.time_ < var_164_6 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play116321039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 116321039
		arg_165_1.duration_ = 11.59

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play116321040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = "STwhite"

			if arg_165_1.bgs_[var_168_0] == nil then
				local var_168_1 = Object.Instantiate(arg_165_1.paintGo_)

				var_168_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_168_0)
				var_168_1.name = var_168_0
				var_168_1.transform.parent = arg_165_1.stage_.transform
				var_168_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.bgs_[var_168_0] = var_168_1
			end

			local var_168_2 = 2

			if var_168_2 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 then
				local var_168_3 = manager.ui.mainCamera.transform.localPosition
				local var_168_4 = Vector3.New(0, 0, 10) + Vector3.New(var_168_3.x, var_168_3.y, 0)
				local var_168_5 = arg_165_1.bgs_.STwhite

				var_168_5.transform.localPosition = var_168_4
				var_168_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_168_6 = var_168_5:GetComponent("SpriteRenderer")

				if var_168_6 and var_168_6.sprite then
					local var_168_7 = (var_168_5.transform.localPosition - var_168_3).z
					local var_168_8 = manager.ui.mainCameraCom_
					local var_168_9 = 2 * var_168_7 * Mathf.Tan(var_168_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_168_10 = var_168_9 * var_168_8.aspect
					local var_168_11 = var_168_6.sprite.bounds.size.x
					local var_168_12 = var_168_6.sprite.bounds.size.y
					local var_168_13 = var_168_10 / var_168_11
					local var_168_14 = var_168_9 / var_168_12
					local var_168_15 = var_168_14 < var_168_13 and var_168_13 or var_168_14

					var_168_5.transform.localScale = Vector3.New(var_168_15, var_168_15, 0)
				end

				for iter_168_0, iter_168_1 in pairs(arg_165_1.bgs_) do
					if iter_168_0 ~= "STwhite" then
						iter_168_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_168_16 = 2

			if var_168_16 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 then
				arg_165_1.fswbg_:SetActive(true)
				arg_165_1.dialog_:SetActive(false)

				arg_165_1.fswtw_.percent = 0

				local var_168_17 = arg_165_1:GetWordFromCfg(116321039)
				local var_168_18 = arg_165_1:FormatText(var_168_17.content)

				arg_165_1.fswt_.text = var_168_18

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.fswt_)

				arg_165_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_165_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_165_1.fswtw_:SetDirty()

				arg_165_1.typewritterCharCountI18N = 0

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_165_1:ShowNextGo(false)
			end

			local var_168_19 = 2.01666666666667

			if var_168_19 < arg_165_1.time_ and arg_165_1.time_ <= var_168_19 + arg_168_0 then
				arg_165_1.var_.oldValueTypewriter = arg_165_1.fswtw_.percent

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_165_1:ShowNextGo(false)
			end

			local var_168_20 = 48
			local var_168_21 = 3.2
			local var_168_22 = arg_165_1:GetWordFromCfg(116321039)
			local var_168_23 = arg_165_1:FormatText(var_168_22.content)
			local var_168_24, var_168_25 = arg_165_1:GetPercentByPara(var_168_23, 1)

			if var_168_19 < arg_165_1.time_ and arg_165_1.time_ <= var_168_19 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				local var_168_26 = var_168_20 <= 0 and var_168_21 or var_168_21 * ((var_168_25 - arg_165_1.typewritterCharCountI18N) / var_168_20)

				if var_168_26 > 0 and var_168_21 < var_168_26 then
					arg_165_1.talkMaxDuration = var_168_26

					if var_168_26 + var_168_19 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_26 + var_168_19
					end
				end
			end

			local var_168_27 = 3.2
			local var_168_28 = math.max(var_168_27, arg_165_1.talkMaxDuration)

			if var_168_19 <= arg_165_1.time_ and arg_165_1.time_ < var_168_19 + var_168_28 then
				local var_168_29 = (arg_165_1.time_ - var_168_19) / var_168_28

				arg_165_1.fswtw_.percent = Mathf.Lerp(arg_165_1.var_.oldValueTypewriter, var_168_24, var_168_29)
				arg_165_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_165_1.fswtw_:SetDirty()
			end

			if arg_165_1.time_ >= var_168_19 + var_168_28 and arg_165_1.time_ < var_168_19 + var_168_28 + arg_168_0 then
				arg_165_1.fswtw_.percent = var_168_24

				arg_165_1.fswtw_:SetDirty()
				arg_165_1:ShowNextGo(true)

				arg_165_1.typewritterCharCountI18N = var_168_25
			end

			local var_168_30 = 2
			local var_168_31 = 9.594
			local var_168_32 = manager.audio:GetVoiceLength("story_v_out_116321", "116321039", "story_v_out_116321.awb") / 1000

			if var_168_32 > 0 and var_168_31 < var_168_32 and var_168_32 + var_168_30 > arg_165_1.duration_ then
				local var_168_33 = var_168_32

				arg_165_1.duration_ = var_168_32 + var_168_30
			end

			if var_168_30 < arg_165_1.time_ and arg_165_1.time_ <= var_168_30 + arg_168_0 then
				local var_168_34 = "play"
				local var_168_35 = "voice"

				arg_165_1:AudioAction(var_168_34, var_168_35, "story_v_out_116321", "116321039", "story_v_out_116321.awb")
			end

			local var_168_36 = 2
			local var_168_37 = 0.266666666666667

			if var_168_36 < arg_165_1.time_ and arg_165_1.time_ <= var_168_36 + arg_168_0 then
				local var_168_38 = "play"
				local var_168_39 = "music"

				arg_165_1:AudioAction(var_168_38, var_168_39, "ui_battle", "ui_battle_stopbgm", "")

				local var_168_40 = ""
				local var_168_41 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_168_41 ~= "" then
					if arg_165_1.bgmTxt_.text ~= var_168_41 and arg_165_1.bgmTxt_.text ~= "" then
						if arg_165_1.bgmTxt2_.text ~= "" then
							arg_165_1.bgmTxt_.text = arg_165_1.bgmTxt2_.text
						end

						arg_165_1.bgmTxt2_.text = var_168_41

						arg_165_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_165_1.bgmTxt_.text = var_168_41
						arg_165_1.bgmTxt2_.text = var_168_41
					end

					if arg_165_1.bgmTimer then
						arg_165_1.bgmTimer:Stop()

						arg_165_1.bgmTimer = nil
					end

					if arg_165_1.settingData.show_music_name == 1 then
						arg_165_1.musicController:SetSelectedState("show")
						arg_165_1.musicAnimator_:Play("open", 0, 0)

						if arg_165_1.settingData.music_time ~= 0 then
							arg_165_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_165_1.settingData.music_time), function()
								if arg_165_1 == nil or isNil(arg_165_1.bgmTxt_) then
									return
								end

								arg_165_1.musicController:SetSelectedState("hide")
								arg_165_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_168_42 = 2.4
			local var_168_43 = 0.6

			if var_168_42 < arg_165_1.time_ and arg_165_1.time_ <= var_168_42 + arg_168_0 then
				local var_168_44 = "play"
				local var_168_45 = "music"

				arg_165_1:AudioAction(var_168_44, var_168_45, "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				local var_168_46 = ""

				if var_168_46 ~= "" then
					if arg_165_1.bgmTxt_.text ~= var_168_46 and arg_165_1.bgmTxt_.text ~= "" then
						if arg_165_1.bgmTxt2_.text ~= "" then
							arg_165_1.bgmTxt_.text = arg_165_1.bgmTxt2_.text
						end

						arg_165_1.bgmTxt2_.text = var_168_46

						arg_165_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_165_1.bgmTxt_.text = var_168_46
						arg_165_1.bgmTxt2_.text = var_168_46
					end

					if arg_165_1.bgmTimer then
						arg_165_1.bgmTimer:Stop()

						arg_165_1.bgmTimer = nil
					end

					if arg_165_1.settingData.show_music_name == 1 then
						arg_165_1.musicController:SetSelectedState("show")
						arg_165_1.musicAnimator_:Play("open", 0, 0)

						if arg_165_1.settingData.music_time ~= 0 then
							arg_165_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_165_1.settingData.music_time), function()
								if arg_165_1 == nil or isNil(arg_165_1.bgmTxt_) then
									return
								end

								arg_165_1.musicController:SetSelectedState("hide")
								arg_165_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_168_47 = 2.575
			local var_168_48 = 0.425

			if var_168_47 < arg_165_1.time_ and arg_165_1.time_ <= var_168_47 + arg_168_0 then
				local var_168_49 = "play"
				local var_168_50 = "music"

				arg_165_1:AudioAction(var_168_49, var_168_50, "bgm_activity_1_6_story_story", "story", "bgm_activity_1_6_story_story.awb")

				local var_168_51 = ""
				local var_168_52 = MusicRecordCfg[97].musicName

				if var_168_52 ~= "" then
					if arg_165_1.bgmTxt_.text ~= var_168_52 and arg_165_1.bgmTxt_.text ~= "" then
						if arg_165_1.bgmTxt2_.text ~= "" then
							arg_165_1.bgmTxt_.text = arg_165_1.bgmTxt2_.text
						end

						arg_165_1.bgmTxt2_.text = var_168_52

						arg_165_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_165_1.bgmTxt_.text = var_168_52
						arg_165_1.bgmTxt2_.text = var_168_52
					end

					if arg_165_1.bgmTimer then
						arg_165_1.bgmTimer:Stop()

						arg_165_1.bgmTimer = nil
					end

					if arg_165_1.settingData.show_music_name == 1 then
						arg_165_1.musicController:SetSelectedState("show")
						arg_165_1.musicAnimator_:Play("open", 0, 0)

						if arg_165_1.settingData.music_time ~= 0 then
							arg_165_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_165_1.settingData.music_time), function()
								if arg_165_1 == nil or isNil(arg_165_1.bgmTxt_) then
									return
								end

								arg_165_1.musicController:SetSelectedState("hide")
								arg_165_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_168_53 = 0

			if var_168_53 < arg_165_1.time_ and arg_165_1.time_ <= var_168_53 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_54 = 2

			if var_168_53 <= arg_165_1.time_ and arg_165_1.time_ < var_168_53 + var_168_54 then
				local var_168_55 = (arg_165_1.time_ - var_168_53) / var_168_54
				local var_168_56 = Color.New(0, 0, 0)

				var_168_56.a = Mathf.Lerp(0, 1, var_168_55)
				arg_165_1.mask_.color = var_168_56
			end

			if arg_165_1.time_ >= var_168_53 + var_168_54 and arg_165_1.time_ < var_168_53 + var_168_54 + arg_168_0 then
				local var_168_57 = Color.New(0, 0, 0)

				var_168_57.a = 1
				arg_165_1.mask_.color = var_168_57
			end

			local var_168_58 = 2

			if var_168_58 < arg_165_1.time_ and arg_165_1.time_ <= var_168_58 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_59 = 2

			if var_168_58 <= arg_165_1.time_ and arg_165_1.time_ < var_168_58 + var_168_59 then
				local var_168_60 = (arg_165_1.time_ - var_168_58) / var_168_59
				local var_168_61 = Color.New(0, 0, 0)

				var_168_61.a = Mathf.Lerp(1, 0, var_168_60)
				arg_165_1.mask_.color = var_168_61
			end

			if arg_165_1.time_ >= var_168_58 + var_168_59 and arg_165_1.time_ < var_168_58 + var_168_59 + arg_168_0 then
				local var_168_62 = Color.New(0, 0, 0)
				local var_168_63 = 0

				arg_165_1.mask_.enabled = false
				var_168_62.a = var_168_63
				arg_165_1.mask_.color = var_168_62
			end

			local var_168_64 = 2

			if var_168_64 < arg_165_1.time_ and arg_165_1.time_ <= var_168_64 + arg_168_0 then
				arg_165_1.allBtn_.enabled = false
			end

			local var_168_65 = 3.21666666666667

			if arg_165_1.time_ >= var_168_64 + var_168_65 and arg_165_1.time_ < var_168_64 + var_168_65 + arg_168_0 then
				arg_165_1.allBtn_.enabled = true
			end

			local var_168_66 = arg_165_1.actors_["10014ui_story"].transform
			local var_168_67 = 1.966

			if var_168_67 < arg_165_1.time_ and arg_165_1.time_ <= var_168_67 + arg_168_0 then
				arg_165_1.var_.moveOldPos10014ui_story = var_168_66.localPosition
			end

			local var_168_68 = 0.001

			if var_168_67 <= arg_165_1.time_ and arg_165_1.time_ < var_168_67 + var_168_68 then
				local var_168_69 = (arg_165_1.time_ - var_168_67) / var_168_68
				local var_168_70 = Vector3.New(0, 100, 0)

				var_168_66.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10014ui_story, var_168_70, var_168_69)

				local var_168_71 = manager.ui.mainCamera.transform.position - var_168_66.position

				var_168_66.forward = Vector3.New(var_168_71.x, var_168_71.y, var_168_71.z)

				local var_168_72 = var_168_66.localEulerAngles

				var_168_72.z = 0
				var_168_72.x = 0
				var_168_66.localEulerAngles = var_168_72
			end

			if arg_165_1.time_ >= var_168_67 + var_168_68 and arg_165_1.time_ < var_168_67 + var_168_68 + arg_168_0 then
				var_168_66.localPosition = Vector3.New(0, 100, 0)

				local var_168_73 = manager.ui.mainCamera.transform.position - var_168_66.position

				var_168_66.forward = Vector3.New(var_168_73.x, var_168_73.y, var_168_73.z)

				local var_168_74 = var_168_66.localEulerAngles

				var_168_74.z = 0
				var_168_74.x = 0
				var_168_66.localEulerAngles = var_168_74
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play116321040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 116321040
		arg_172_1.duration_ = 11.77

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play116321041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.var_.oldValueTypewriter = arg_172_1.fswtw_.percent

				SetActive(arg_172_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_172_1:ShowNextGo(false)
			end

			local var_175_1 = 52
			local var_175_2 = 3.46666666666667
			local var_175_3 = arg_172_1:GetWordFromCfg(116321039)
			local var_175_4 = arg_172_1:FormatText(var_175_3.content)
			local var_175_5, var_175_6 = arg_172_1:GetPercentByPara(var_175_4, 2)

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				local var_175_7 = var_175_1 <= 0 and var_175_2 or var_175_2 * ((var_175_6 - arg_172_1.typewritterCharCountI18N) / var_175_1)

				if var_175_7 > 0 and var_175_2 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_0
					end
				end
			end

			local var_175_8 = 3.46666666666667
			local var_175_9 = math.max(var_175_8, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_9 then
				local var_175_10 = (arg_172_1.time_ - var_175_0) / var_175_9

				arg_172_1.fswtw_.percent = Mathf.Lerp(arg_172_1.var_.oldValueTypewriter, var_175_5, var_175_10)
				arg_172_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_172_1.fswtw_:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_9 and arg_172_1.time_ < var_175_0 + var_175_9 + arg_175_0 then
				arg_172_1.fswtw_.percent = var_175_5

				arg_172_1.fswtw_:SetDirty()
				arg_172_1:ShowNextGo(true)

				arg_172_1.typewritterCharCountI18N = var_175_6
			end

			local var_175_11 = 0
			local var_175_12 = 11.774
			local var_175_13 = manager.audio:GetVoiceLength("story_v_out_116321", "116321040", "story_v_out_116321.awb") / 1000

			if var_175_13 > 0 and var_175_12 < var_175_13 and var_175_13 + var_175_11 > arg_172_1.duration_ then
				local var_175_14 = var_175_13

				arg_172_1.duration_ = var_175_13 + var_175_11
			end

			if var_175_11 < arg_172_1.time_ and arg_172_1.time_ <= var_175_11 + arg_175_0 then
				local var_175_15 = "play"
				local var_175_16 = "voice"

				arg_172_1:AudioAction(var_175_15, var_175_16, "story_v_out_116321", "116321040", "story_v_out_116321.awb")
			end

			local var_175_17 = 0

			if var_175_17 < arg_172_1.time_ and arg_172_1.time_ <= var_175_17 + arg_175_0 then
				arg_172_1.allBtn_.enabled = false
			end

			local var_175_18 = 3.46666666666667

			if arg_172_1.time_ >= var_175_17 + var_175_18 and arg_172_1.time_ < var_175_17 + var_175_18 + arg_175_0 then
				arg_172_1.allBtn_.enabled = true
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play116321041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 116321041
		arg_176_1.duration_ = 7.89

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play116321042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.var_.oldValueTypewriter = arg_176_1.fswtw_.percent

				SetActive(arg_176_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_176_1:ShowNextGo(false)
			end

			local var_179_1 = 38
			local var_179_2 = 2.53333333333333
			local var_179_3 = arg_176_1:GetWordFromCfg(116321039)
			local var_179_4 = arg_176_1:FormatText(var_179_3.content)
			local var_179_5, var_179_6 = arg_176_1:GetPercentByPara(var_179_4, 3)

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0

				local var_179_7 = var_179_1 <= 0 and var_179_2 or var_179_2 * ((var_179_6 - arg_176_1.typewritterCharCountI18N) / var_179_1)

				if var_179_7 > 0 and var_179_2 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_0
					end
				end
			end

			local var_179_8 = 2.53333333333333
			local var_179_9 = math.max(var_179_8, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_9 then
				local var_179_10 = (arg_176_1.time_ - var_179_0) / var_179_9

				arg_176_1.fswtw_.percent = Mathf.Lerp(arg_176_1.var_.oldValueTypewriter, var_179_5, var_179_10)
				arg_176_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_176_1.fswtw_:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_9 and arg_176_1.time_ < var_179_0 + var_179_9 + arg_179_0 then
				arg_176_1.fswtw_.percent = var_179_5

				arg_176_1.fswtw_:SetDirty()
				arg_176_1:ShowNextGo(true)

				arg_176_1.typewritterCharCountI18N = var_179_6
			end

			local var_179_11 = 0
			local var_179_12 = 7.886
			local var_179_13 = manager.audio:GetVoiceLength("story_v_out_116321", "116321041", "story_v_out_116321.awb") / 1000

			if var_179_13 > 0 and var_179_12 < var_179_13 and var_179_13 + var_179_11 > arg_176_1.duration_ then
				local var_179_14 = var_179_13

				arg_176_1.duration_ = var_179_13 + var_179_11
			end

			if var_179_11 < arg_176_1.time_ and arg_176_1.time_ <= var_179_11 + arg_179_0 then
				local var_179_15 = "play"
				local var_179_16 = "voice"

				arg_176_1:AudioAction(var_179_15, var_179_16, "story_v_out_116321", "116321041", "story_v_out_116321.awb")
			end

			local var_179_17 = 0

			if var_179_17 < arg_176_1.time_ and arg_176_1.time_ <= var_179_17 + arg_179_0 then
				arg_176_1.allBtn_.enabled = false
			end

			local var_179_18 = 2.46666666666667

			if arg_176_1.time_ >= var_179_17 + var_179_18 and arg_176_1.time_ < var_179_17 + var_179_18 + arg_179_0 then
				arg_176_1.allBtn_.enabled = true
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play116321042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 116321042
		arg_180_1.duration_ = 16.39

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play116321043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.var_.oldValueTypewriter = arg_180_1.fswtw_.percent

				SetActive(arg_180_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_180_1:ShowNextGo(false)
			end

			local var_183_1 = 71
			local var_183_2 = 4.73333333333333
			local var_183_3 = arg_180_1:GetWordFromCfg(116321039)
			local var_183_4 = arg_180_1:FormatText(var_183_3.content)
			local var_183_5, var_183_6 = arg_180_1:GetPercentByPara(var_183_4, 4)

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0

				local var_183_7 = var_183_1 <= 0 and var_183_2 or var_183_2 * ((var_183_6 - arg_180_1.typewritterCharCountI18N) / var_183_1)

				if var_183_7 > 0 and var_183_2 < var_183_7 then
					arg_180_1.talkMaxDuration = var_183_7

					if var_183_7 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_0
					end
				end
			end

			local var_183_8 = 4.73333333333333
			local var_183_9 = math.max(var_183_8, arg_180_1.talkMaxDuration)

			if var_183_0 <= arg_180_1.time_ and arg_180_1.time_ < var_183_0 + var_183_9 then
				local var_183_10 = (arg_180_1.time_ - var_183_0) / var_183_9

				arg_180_1.fswtw_.percent = Mathf.Lerp(arg_180_1.var_.oldValueTypewriter, var_183_5, var_183_10)
				arg_180_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_180_1.fswtw_:SetDirty()
			end

			if arg_180_1.time_ >= var_183_0 + var_183_9 and arg_180_1.time_ < var_183_0 + var_183_9 + arg_183_0 then
				arg_180_1.fswtw_.percent = var_183_5

				arg_180_1.fswtw_:SetDirty()
				arg_180_1:ShowNextGo(true)

				arg_180_1.typewritterCharCountI18N = var_183_6
			end

			local var_183_11 = 0
			local var_183_12 = 16.386
			local var_183_13 = manager.audio:GetVoiceLength("story_v_out_116321", "116321042", "story_v_out_116321.awb") / 1000

			if var_183_13 > 0 and var_183_12 < var_183_13 and var_183_13 + var_183_11 > arg_180_1.duration_ then
				local var_183_14 = var_183_13

				arg_180_1.duration_ = var_183_13 + var_183_11
			end

			if var_183_11 < arg_180_1.time_ and arg_180_1.time_ <= var_183_11 + arg_183_0 then
				local var_183_15 = "play"
				local var_183_16 = "voice"

				arg_180_1:AudioAction(var_183_15, var_183_16, "story_v_out_116321", "116321042", "story_v_out_116321.awb")
			end

			local var_183_17 = 0

			if var_183_17 < arg_180_1.time_ and arg_180_1.time_ <= var_183_17 + arg_183_0 then
				arg_180_1.allBtn_.enabled = false
			end

			local var_183_18 = 4.73333333333333

			if arg_180_1.time_ >= var_183_17 + var_183_18 and arg_180_1.time_ < var_183_17 + var_183_18 + arg_183_0 then
				arg_180_1.allBtn_.enabled = true
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play116321043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 116321043
		arg_184_1.duration_ = 10.87

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play116321044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.var_.oldValueTypewriter = arg_184_1.fswtw_.percent

				SetActive(arg_184_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_184_1:ShowNextGo(false)
			end

			local var_187_1 = 44
			local var_187_2 = 2.93333333333333
			local var_187_3 = arg_184_1:GetWordFromCfg(116321039)
			local var_187_4 = arg_184_1:FormatText(var_187_3.content)
			local var_187_5, var_187_6 = arg_184_1:GetPercentByPara(var_187_4, 5)

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0

				local var_187_7 = var_187_1 <= 0 and var_187_2 or var_187_2 * ((var_187_6 - arg_184_1.typewritterCharCountI18N) / var_187_1)

				if var_187_7 > 0 and var_187_2 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_0
					end
				end
			end

			local var_187_8 = 2.93333333333333
			local var_187_9 = math.max(var_187_8, arg_184_1.talkMaxDuration)

			if var_187_0 <= arg_184_1.time_ and arg_184_1.time_ < var_187_0 + var_187_9 then
				local var_187_10 = (arg_184_1.time_ - var_187_0) / var_187_9

				arg_184_1.fswtw_.percent = Mathf.Lerp(arg_184_1.var_.oldValueTypewriter, var_187_5, var_187_10)
				arg_184_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_184_1.fswtw_:SetDirty()
			end

			if arg_184_1.time_ >= var_187_0 + var_187_9 and arg_184_1.time_ < var_187_0 + var_187_9 + arg_187_0 then
				arg_184_1.fswtw_.percent = var_187_5

				arg_184_1.fswtw_:SetDirty()
				arg_184_1:ShowNextGo(true)

				arg_184_1.typewritterCharCountI18N = var_187_6
			end

			local var_187_11 = 0
			local var_187_12 = 10.866
			local var_187_13 = manager.audio:GetVoiceLength("story_v_out_116321", "116321043", "story_v_out_116321.awb") / 1000

			if var_187_13 > 0 and var_187_12 < var_187_13 and var_187_13 + var_187_11 > arg_184_1.duration_ then
				local var_187_14 = var_187_13

				arg_184_1.duration_ = var_187_13 + var_187_11
			end

			if var_187_11 < arg_184_1.time_ and arg_184_1.time_ <= var_187_11 + arg_187_0 then
				local var_187_15 = "play"
				local var_187_16 = "voice"

				arg_184_1:AudioAction(var_187_15, var_187_16, "story_v_out_116321", "116321043", "story_v_out_116321.awb")
			end

			local var_187_17 = 0

			if var_187_17 < arg_184_1.time_ and arg_184_1.time_ <= var_187_17 + arg_187_0 then
				arg_184_1.allBtn_.enabled = false
			end

			local var_187_18 = 2.93333333333333

			if arg_184_1.time_ >= var_187_17 + var_187_18 and arg_184_1.time_ < var_187_17 + var_187_18 + arg_187_0 then
				arg_184_1.allBtn_.enabled = true
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play116321044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 116321044
		arg_188_1.duration_ = 9

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play116321045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 2

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				local var_191_1 = manager.ui.mainCamera.transform.localPosition
				local var_191_2 = Vector3.New(0, 0, 10) + Vector3.New(var_191_1.x, var_191_1.y, 0)
				local var_191_3 = arg_188_1.bgs_.I07a

				var_191_3.transform.localPosition = var_191_2
				var_191_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_191_4 = var_191_3:GetComponent("SpriteRenderer")

				if var_191_4 and var_191_4.sprite then
					local var_191_5 = (var_191_3.transform.localPosition - var_191_1).z
					local var_191_6 = manager.ui.mainCameraCom_
					local var_191_7 = 2 * var_191_5 * Mathf.Tan(var_191_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_191_8 = var_191_7 * var_191_6.aspect
					local var_191_9 = var_191_4.sprite.bounds.size.x
					local var_191_10 = var_191_4.sprite.bounds.size.y
					local var_191_11 = var_191_8 / var_191_9
					local var_191_12 = var_191_7 / var_191_10
					local var_191_13 = var_191_12 < var_191_11 and var_191_11 or var_191_12

					var_191_3.transform.localScale = Vector3.New(var_191_13, var_191_13, 0)
				end

				for iter_191_0, iter_191_1 in pairs(arg_188_1.bgs_) do
					if iter_191_0 ~= "I07a" then
						iter_191_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_191_14 = 0

			if var_191_14 < arg_188_1.time_ and arg_188_1.time_ <= var_191_14 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_15 = 2

			if var_191_14 <= arg_188_1.time_ and arg_188_1.time_ < var_191_14 + var_191_15 then
				local var_191_16 = (arg_188_1.time_ - var_191_14) / var_191_15
				local var_191_17 = Color.New(0, 0, 0)

				var_191_17.a = Mathf.Lerp(0, 1, var_191_16)
				arg_188_1.mask_.color = var_191_17
			end

			if arg_188_1.time_ >= var_191_14 + var_191_15 and arg_188_1.time_ < var_191_14 + var_191_15 + arg_191_0 then
				local var_191_18 = Color.New(0, 0, 0)

				var_191_18.a = 1
				arg_188_1.mask_.color = var_191_18
			end

			local var_191_19 = 2

			if var_191_19 < arg_188_1.time_ and arg_188_1.time_ <= var_191_19 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_20 = 2

			if var_191_19 <= arg_188_1.time_ and arg_188_1.time_ < var_191_19 + var_191_20 then
				local var_191_21 = (arg_188_1.time_ - var_191_19) / var_191_20
				local var_191_22 = Color.New(0, 0, 0)

				var_191_22.a = Mathf.Lerp(1, 0, var_191_21)
				arg_188_1.mask_.color = var_191_22
			end

			if arg_188_1.time_ >= var_191_19 + var_191_20 and arg_188_1.time_ < var_191_19 + var_191_20 + arg_191_0 then
				local var_191_23 = Color.New(0, 0, 0)
				local var_191_24 = 0

				arg_188_1.mask_.enabled = false
				var_191_23.a = var_191_24
				arg_188_1.mask_.color = var_191_23
			end

			local var_191_25 = 2

			if var_191_25 < arg_188_1.time_ and arg_188_1.time_ <= var_191_25 + arg_191_0 then
				arg_188_1.fswbg_:SetActive(false)
				arg_188_1.dialog_:SetActive(false)
				SetActive(arg_188_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_188_1:ShowNextGo(false)
			end

			if arg_188_1.frameCnt_ <= 1 then
				arg_188_1.dialog_:SetActive(false)
			end

			local var_191_26 = 4
			local var_191_27 = 0.05

			if var_191_26 < arg_188_1.time_ and arg_188_1.time_ <= var_191_26 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0

				arg_188_1.dialog_:SetActive(true)

				arg_188_1.dialogCg_.alpha = 0

				local var_191_28 = LeanTween.value(arg_188_1.dialog_, 0, 1, 0.3)

				var_191_28:setOnUpdate(LuaHelper.FloatAction(function(arg_192_0)
					arg_188_1.dialogCg_.alpha = arg_192_0
				end))
				var_191_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_188_1.dialog_)
					var_191_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_188_1.duration_ = arg_188_1.duration_ + 0.3

				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_29 = arg_188_1:GetWordFromCfg(116321044)
				local var_191_30 = arg_188_1:FormatText(var_191_29.content)

				arg_188_1.text_.text = var_191_30

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_31 = 2
				local var_191_32 = utf8.len(var_191_30)
				local var_191_33 = var_191_31 <= 0 and var_191_27 or var_191_27 * (var_191_32 / var_191_31)

				if var_191_33 > 0 and var_191_27 < var_191_33 then
					arg_188_1.talkMaxDuration = var_191_33
					var_191_26 = var_191_26 + 0.3

					if var_191_33 + var_191_26 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_33 + var_191_26
					end
				end

				arg_188_1.text_.text = var_191_30
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_34 = var_191_26 + 0.3
			local var_191_35 = math.max(var_191_27, arg_188_1.talkMaxDuration)

			if var_191_34 <= arg_188_1.time_ and arg_188_1.time_ < var_191_34 + var_191_35 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_34) / var_191_35

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_34 + var_191_35 and arg_188_1.time_ < var_191_34 + var_191_35 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play116321045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 116321045
		arg_194_1.duration_ = 11.9

		local var_194_0 = {
			zh = 11.9,
			ja = 11.574999999999
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
				arg_194_0:Play116321046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0
			local var_197_1 = 11.575
			local var_197_2 = manager.audio:GetVoiceLength("story_v_out_116321", "116321045", "story_v_out_116321.awb") / 1000

			if var_197_2 > 0 and var_197_1 < var_197_2 and var_197_2 + var_197_0 > arg_194_1.duration_ then
				local var_197_3 = var_197_2

				arg_194_1.duration_ = var_197_2 + var_197_0
			end

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				local var_197_4 = "play"
				local var_197_5 = "voice"

				arg_194_1:AudioAction(var_197_4, var_197_5, "story_v_out_116321", "116321045", "story_v_out_116321.awb")
			end

			local var_197_6 = 0
			local var_197_7 = 1.175

			if var_197_6 < arg_194_1.time_ and arg_194_1.time_ <= var_197_6 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, false)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_8 = arg_194_1:GetWordFromCfg(116321045)
				local var_197_9 = arg_194_1:FormatText(var_197_8.content)

				arg_194_1.text_.text = var_197_9

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_10 = 47
				local var_197_11 = utf8.len(var_197_9)
				local var_197_12 = var_197_10 <= 0 and var_197_7 or var_197_7 * (var_197_11 / var_197_10)

				if var_197_12 > 0 and var_197_7 < var_197_12 then
					arg_194_1.talkMaxDuration = var_197_12

					if var_197_12 + var_197_6 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_12 + var_197_6
					end
				end

				arg_194_1.text_.text = var_197_9
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321045", "story_v_out_116321.awb") ~= 0 then
					local var_197_13 = manager.audio:GetVoiceLength("story_v_out_116321", "116321045", "story_v_out_116321.awb") / 1000

					if var_197_13 + var_197_6 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_13 + var_197_6
					end

					if var_197_8.prefab_name ~= "" and arg_194_1.actors_[var_197_8.prefab_name] ~= nil then
						local var_197_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_8.prefab_name].transform, "story_v_out_116321", "116321045", "story_v_out_116321.awb")

						arg_194_1:RecordAudio("116321045", var_197_14)
						arg_194_1:RecordAudio("116321045", var_197_14)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_116321", "116321045", "story_v_out_116321.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_116321", "116321045", "story_v_out_116321.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_15 = math.max(var_197_7, arg_194_1.talkMaxDuration)

			if var_197_6 <= arg_194_1.time_ and arg_194_1.time_ < var_197_6 + var_197_15 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_6) / var_197_15

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_6 + var_197_15 and arg_194_1.time_ < var_197_6 + var_197_15 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play116321046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 116321046
		arg_198_1.duration_ = 15.83

		local var_198_0 = {
			zh = 13.666,
			ja = 15.833
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
				arg_198_0:Play116321047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0
			local var_201_1 = 1.075

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_2 = arg_198_1:GetWordFromCfg(116321046)
				local var_201_3 = arg_198_1:FormatText(var_201_2.content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_4 = 43
				local var_201_5 = utf8.len(var_201_3)
				local var_201_6 = var_201_4 <= 0 and var_201_1 or var_201_1 * (var_201_5 / var_201_4)

				if var_201_6 > 0 and var_201_1 < var_201_6 then
					arg_198_1.talkMaxDuration = var_201_6

					if var_201_6 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_6 + var_201_0
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321046", "story_v_out_116321.awb") ~= 0 then
					local var_201_7 = manager.audio:GetVoiceLength("story_v_out_116321", "116321046", "story_v_out_116321.awb") / 1000

					if var_201_7 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_0
					end

					if var_201_2.prefab_name ~= "" and arg_198_1.actors_[var_201_2.prefab_name] ~= nil then
						local var_201_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_2.prefab_name].transform, "story_v_out_116321", "116321046", "story_v_out_116321.awb")

						arg_198_1:RecordAudio("116321046", var_201_8)
						arg_198_1:RecordAudio("116321046", var_201_8)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_116321", "116321046", "story_v_out_116321.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_116321", "116321046", "story_v_out_116321.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_9 = math.max(var_201_1, arg_198_1.talkMaxDuration)

			if var_201_0 <= arg_198_1.time_ and arg_198_1.time_ < var_201_0 + var_201_9 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_0) / var_201_9

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_0 + var_201_9 and arg_198_1.time_ < var_201_0 + var_201_9 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play116321047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 116321047
		arg_202_1.duration_ = 5.73

		local var_202_0 = {
			zh = 5.733,
			ja = 4.7
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play116321048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0
			local var_205_1 = 0.375

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_2 = arg_202_1:GetWordFromCfg(116321047)
				local var_205_3 = arg_202_1:FormatText(var_205_2.content)

				arg_202_1.text_.text = var_205_3

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 15
				local var_205_5 = utf8.len(var_205_3)
				local var_205_6 = var_205_4 <= 0 and var_205_1 or var_205_1 * (var_205_5 / var_205_4)

				if var_205_6 > 0 and var_205_1 < var_205_6 then
					arg_202_1.talkMaxDuration = var_205_6

					if var_205_6 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_6 + var_205_0
					end
				end

				arg_202_1.text_.text = var_205_3
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321047", "story_v_out_116321.awb") ~= 0 then
					local var_205_7 = manager.audio:GetVoiceLength("story_v_out_116321", "116321047", "story_v_out_116321.awb") / 1000

					if var_205_7 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_0
					end

					if var_205_2.prefab_name ~= "" and arg_202_1.actors_[var_205_2.prefab_name] ~= nil then
						local var_205_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_2.prefab_name].transform, "story_v_out_116321", "116321047", "story_v_out_116321.awb")

						arg_202_1:RecordAudio("116321047", var_205_8)
						arg_202_1:RecordAudio("116321047", var_205_8)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_116321", "116321047", "story_v_out_116321.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_116321", "116321047", "story_v_out_116321.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_9 = math.max(var_205_1, arg_202_1.talkMaxDuration)

			if var_205_0 <= arg_202_1.time_ and arg_202_1.time_ < var_205_0 + var_205_9 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_0) / var_205_9

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_0 + var_205_9 and arg_202_1.time_ < var_205_0 + var_205_9 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play116321048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 116321048
		arg_206_1.duration_ = 7.33

		local var_206_0 = {
			zh = 7.333,
			ja = 3.533
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play116321049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["10032ui_story"].transform
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.var_.moveOldPos10032ui_story = var_209_0.localPosition
			end

			local var_209_2 = 0.001

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2
				local var_209_4 = Vector3.New(0, -1.1, -5.9)

				var_209_0.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10032ui_story, var_209_4, var_209_3)

				local var_209_5 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_5.x, var_209_5.y, var_209_5.z)

				local var_209_6 = var_209_0.localEulerAngles

				var_209_6.z = 0
				var_209_6.x = 0
				var_209_0.localEulerAngles = var_209_6
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 then
				var_209_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_209_7 = manager.ui.mainCamera.transform.position - var_209_0.position

				var_209_0.forward = Vector3.New(var_209_7.x, var_209_7.y, var_209_7.z)

				local var_209_8 = var_209_0.localEulerAngles

				var_209_8.z = 0
				var_209_8.x = 0
				var_209_0.localEulerAngles = var_209_8
			end

			local var_209_9 = 0

			if var_209_9 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 then
				arg_206_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_209_10 = 0

			if var_209_10 < arg_206_1.time_ and arg_206_1.time_ <= var_209_10 + arg_209_0 then
				arg_206_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_209_11 = arg_206_1.actors_["10032ui_story"]
			local var_209_12 = 0

			if var_209_12 < arg_206_1.time_ and arg_206_1.time_ <= var_209_12 + arg_209_0 and not isNil(var_209_11) and arg_206_1.var_.characterEffect10032ui_story == nil then
				arg_206_1.var_.characterEffect10032ui_story = var_209_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_13 = 0.2

			if var_209_12 <= arg_206_1.time_ and arg_206_1.time_ < var_209_12 + var_209_13 and not isNil(var_209_11) then
				local var_209_14 = (arg_206_1.time_ - var_209_12) / var_209_13

				if arg_206_1.var_.characterEffect10032ui_story and not isNil(var_209_11) then
					arg_206_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_12 + var_209_13 and arg_206_1.time_ < var_209_12 + var_209_13 + arg_209_0 and not isNil(var_209_11) and arg_206_1.var_.characterEffect10032ui_story then
				arg_206_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_209_15 = 0
			local var_209_16 = 0.65

			if var_209_15 < arg_206_1.time_ and arg_206_1.time_ <= var_209_15 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_17 = arg_206_1:FormatText(StoryNameCfg[328].name)

				arg_206_1.leftNameTxt_.text = var_209_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_18 = arg_206_1:GetWordFromCfg(116321048)
				local var_209_19 = arg_206_1:FormatText(var_209_18.content)

				arg_206_1.text_.text = var_209_19

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_20 = 26
				local var_209_21 = utf8.len(var_209_19)
				local var_209_22 = var_209_20 <= 0 and var_209_16 or var_209_16 * (var_209_21 / var_209_20)

				if var_209_22 > 0 and var_209_16 < var_209_22 then
					arg_206_1.talkMaxDuration = var_209_22

					if var_209_22 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_22 + var_209_15
					end
				end

				arg_206_1.text_.text = var_209_19
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321048", "story_v_out_116321.awb") ~= 0 then
					local var_209_23 = manager.audio:GetVoiceLength("story_v_out_116321", "116321048", "story_v_out_116321.awb") / 1000

					if var_209_23 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_23 + var_209_15
					end

					if var_209_18.prefab_name ~= "" and arg_206_1.actors_[var_209_18.prefab_name] ~= nil then
						local var_209_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_18.prefab_name].transform, "story_v_out_116321", "116321048", "story_v_out_116321.awb")

						arg_206_1:RecordAudio("116321048", var_209_24)
						arg_206_1:RecordAudio("116321048", var_209_24)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_116321", "116321048", "story_v_out_116321.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_116321", "116321048", "story_v_out_116321.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_25 = math.max(var_209_16, arg_206_1.talkMaxDuration)

			if var_209_15 <= arg_206_1.time_ and arg_206_1.time_ < var_209_15 + var_209_25 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_15) / var_209_25

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_15 + var_209_25 and arg_206_1.time_ < var_209_15 + var_209_25 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
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
	Play116321049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 116321049
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play116321050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["10032ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect10032ui_story == nil then
				arg_210_1.var_.characterEffect10032ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.2

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect10032ui_story and not isNil(var_213_0) then
					local var_213_4 = Mathf.Lerp(0, 0.5, var_213_3)

					arg_210_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_210_1.var_.characterEffect10032ui_story.fillRatio = var_213_4
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect10032ui_story then
				local var_213_5 = 0.5

				arg_210_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_210_1.var_.characterEffect10032ui_story.fillRatio = var_213_5
			end

			local var_213_6 = arg_210_1.actors_["10032ui_story"].transform
			local var_213_7 = 0

			if var_213_7 < arg_210_1.time_ and arg_210_1.time_ <= var_213_7 + arg_213_0 then
				arg_210_1.var_.moveOldPos10032ui_story = var_213_6.localPosition
			end

			local var_213_8 = 0.001

			if var_213_7 <= arg_210_1.time_ and arg_210_1.time_ < var_213_7 + var_213_8 then
				local var_213_9 = (arg_210_1.time_ - var_213_7) / var_213_8
				local var_213_10 = Vector3.New(0, 100, 0)

				var_213_6.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10032ui_story, var_213_10, var_213_9)

				local var_213_11 = manager.ui.mainCamera.transform.position - var_213_6.position

				var_213_6.forward = Vector3.New(var_213_11.x, var_213_11.y, var_213_11.z)

				local var_213_12 = var_213_6.localEulerAngles

				var_213_12.z = 0
				var_213_12.x = 0
				var_213_6.localEulerAngles = var_213_12
			end

			if arg_210_1.time_ >= var_213_7 + var_213_8 and arg_210_1.time_ < var_213_7 + var_213_8 + arg_213_0 then
				var_213_6.localPosition = Vector3.New(0, 100, 0)

				local var_213_13 = manager.ui.mainCamera.transform.position - var_213_6.position

				var_213_6.forward = Vector3.New(var_213_13.x, var_213_13.y, var_213_13.z)

				local var_213_14 = var_213_6.localEulerAngles

				var_213_14.z = 0
				var_213_14.x = 0
				var_213_6.localEulerAngles = var_213_14
			end

			local var_213_15 = 0
			local var_213_16 = 0.625

			if var_213_15 < arg_210_1.time_ and arg_210_1.time_ <= var_213_15 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_17 = arg_210_1:GetWordFromCfg(116321049)
				local var_213_18 = arg_210_1:FormatText(var_213_17.content)

				arg_210_1.text_.text = var_213_18

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_19 = 25
				local var_213_20 = utf8.len(var_213_18)
				local var_213_21 = var_213_19 <= 0 and var_213_16 or var_213_16 * (var_213_20 / var_213_19)

				if var_213_21 > 0 and var_213_16 < var_213_21 then
					arg_210_1.talkMaxDuration = var_213_21

					if var_213_21 + var_213_15 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_21 + var_213_15
					end
				end

				arg_210_1.text_.text = var_213_18
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_22 = math.max(var_213_16, arg_210_1.talkMaxDuration)

			if var_213_15 <= arg_210_1.time_ and arg_210_1.time_ < var_213_15 + var_213_22 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_15) / var_213_22

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_15 + var_213_22 and arg_210_1.time_ < var_213_15 + var_213_22 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
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
	Play116321050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 116321050
		arg_214_1.duration_ = 10.3

		local var_214_0 = {
			zh = 7.866,
			ja = 10.3
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
				arg_214_0:Play116321051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["10032ui_story"].transform
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.var_.moveOldPos10032ui_story = var_217_0.localPosition
			end

			local var_217_2 = 0.001

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2
				local var_217_4 = Vector3.New(0, -1.1, -5.9)

				var_217_0.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10032ui_story, var_217_4, var_217_3)

				local var_217_5 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_5.x, var_217_5.y, var_217_5.z)

				local var_217_6 = var_217_0.localEulerAngles

				var_217_6.z = 0
				var_217_6.x = 0
				var_217_0.localEulerAngles = var_217_6
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 then
				var_217_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_217_7 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_7.x, var_217_7.y, var_217_7.z)

				local var_217_8 = var_217_0.localEulerAngles

				var_217_8.z = 0
				var_217_8.x = 0
				var_217_0.localEulerAngles = var_217_8
			end

			local var_217_9 = 0

			if var_217_9 < arg_214_1.time_ and arg_214_1.time_ <= var_217_9 + arg_217_0 then
				arg_214_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_217_10 = arg_214_1.actors_["10032ui_story"]
			local var_217_11 = 0

			if var_217_11 < arg_214_1.time_ and arg_214_1.time_ <= var_217_11 + arg_217_0 and not isNil(var_217_10) and arg_214_1.var_.characterEffect10032ui_story == nil then
				arg_214_1.var_.characterEffect10032ui_story = var_217_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_12 = 0.2

			if var_217_11 <= arg_214_1.time_ and arg_214_1.time_ < var_217_11 + var_217_12 and not isNil(var_217_10) then
				local var_217_13 = (arg_214_1.time_ - var_217_11) / var_217_12

				if arg_214_1.var_.characterEffect10032ui_story and not isNil(var_217_10) then
					arg_214_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_11 + var_217_12 and arg_214_1.time_ < var_217_11 + var_217_12 + arg_217_0 and not isNil(var_217_10) and arg_214_1.var_.characterEffect10032ui_story then
				arg_214_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_217_14 = 0
			local var_217_15 = 0.65

			if var_217_14 < arg_214_1.time_ and arg_214_1.time_ <= var_217_14 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_16 = arg_214_1:FormatText(StoryNameCfg[328].name)

				arg_214_1.leftNameTxt_.text = var_217_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_17 = arg_214_1:GetWordFromCfg(116321050)
				local var_217_18 = arg_214_1:FormatText(var_217_17.content)

				arg_214_1.text_.text = var_217_18

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_19 = 26
				local var_217_20 = utf8.len(var_217_18)
				local var_217_21 = var_217_19 <= 0 and var_217_15 or var_217_15 * (var_217_20 / var_217_19)

				if var_217_21 > 0 and var_217_15 < var_217_21 then
					arg_214_1.talkMaxDuration = var_217_21

					if var_217_21 + var_217_14 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_21 + var_217_14
					end
				end

				arg_214_1.text_.text = var_217_18
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321050", "story_v_out_116321.awb") ~= 0 then
					local var_217_22 = manager.audio:GetVoiceLength("story_v_out_116321", "116321050", "story_v_out_116321.awb") / 1000

					if var_217_22 + var_217_14 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_22 + var_217_14
					end

					if var_217_17.prefab_name ~= "" and arg_214_1.actors_[var_217_17.prefab_name] ~= nil then
						local var_217_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_17.prefab_name].transform, "story_v_out_116321", "116321050", "story_v_out_116321.awb")

						arg_214_1:RecordAudio("116321050", var_217_23)
						arg_214_1:RecordAudio("116321050", var_217_23)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_116321", "116321050", "story_v_out_116321.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_116321", "116321050", "story_v_out_116321.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_24 = math.max(var_217_15, arg_214_1.talkMaxDuration)

			if var_217_14 <= arg_214_1.time_ and arg_214_1.time_ < var_217_14 + var_217_24 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_14) / var_217_24

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_14 + var_217_24 and arg_214_1.time_ < var_217_14 + var_217_24 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play116321051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 116321051
		arg_218_1.duration_ = 9.87

		local var_218_0 = {
			zh = 7.4,
			ja = 9.866
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
			arg_218_1.auto_ = false
		end

		function arg_218_1.playNext_(arg_220_0)
			arg_218_1.onStoryFinished_()
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["10032ui_story"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos10032ui_story = var_221_0.localPosition
			end

			local var_221_2 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2
				local var_221_4 = Vector3.New(0, -1.1, -5.9)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10032ui_story, var_221_4, var_221_3)

				local var_221_5 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_5.x, var_221_5.y, var_221_5.z)

				local var_221_6 = var_221_0.localEulerAngles

				var_221_6.z = 0
				var_221_6.x = 0
				var_221_0.localEulerAngles = var_221_6
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_221_7 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_7.x, var_221_7.y, var_221_7.z)

				local var_221_8 = var_221_0.localEulerAngles

				var_221_8.z = 0
				var_221_8.x = 0
				var_221_0.localEulerAngles = var_221_8
			end

			local var_221_9 = 0

			if var_221_9 < arg_218_1.time_ and arg_218_1.time_ <= var_221_9 + arg_221_0 then
				arg_218_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_221_10 = 0

			if var_221_10 < arg_218_1.time_ and arg_218_1.time_ <= var_221_10 + arg_221_0 then
				arg_218_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action448")
			end

			local var_221_11 = 0
			local var_221_12 = 0.6

			if var_221_11 < arg_218_1.time_ and arg_218_1.time_ <= var_221_11 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_13 = arg_218_1:FormatText(StoryNameCfg[328].name)

				arg_218_1.leftNameTxt_.text = var_221_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_14 = arg_218_1:GetWordFromCfg(116321051)
				local var_221_15 = arg_218_1:FormatText(var_221_14.content)

				arg_218_1.text_.text = var_221_15

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_16 = 24
				local var_221_17 = utf8.len(var_221_15)
				local var_221_18 = var_221_16 <= 0 and var_221_12 or var_221_12 * (var_221_17 / var_221_16)

				if var_221_18 > 0 and var_221_12 < var_221_18 then
					arg_218_1.talkMaxDuration = var_221_18

					if var_221_18 + var_221_11 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_18 + var_221_11
					end
				end

				arg_218_1.text_.text = var_221_15
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116321", "116321051", "story_v_out_116321.awb") ~= 0 then
					local var_221_19 = manager.audio:GetVoiceLength("story_v_out_116321", "116321051", "story_v_out_116321.awb") / 1000

					if var_221_19 + var_221_11 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_19 + var_221_11
					end

					if var_221_14.prefab_name ~= "" and arg_218_1.actors_[var_221_14.prefab_name] ~= nil then
						local var_221_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_14.prefab_name].transform, "story_v_out_116321", "116321051", "story_v_out_116321.awb")

						arg_218_1:RecordAudio("116321051", var_221_20)
						arg_218_1:RecordAudio("116321051", var_221_20)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_116321", "116321051", "story_v_out_116321.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_116321", "116321051", "story_v_out_116321.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_21 = math.max(var_221_12, arg_218_1.talkMaxDuration)

			if var_221_11 <= arg_218_1.time_ and arg_218_1.time_ < var_221_11 + var_221_21 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_11) / var_221_21

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_11 + var_221_21 and arg_218_1.time_ < var_221_11 + var_221_21 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I07a",
		"TextureConfig/Background/I07",
		"TextureConfig/Background/STwhite"
	},
	voices = {
		"story_v_out_116321.awb"
	}
}
