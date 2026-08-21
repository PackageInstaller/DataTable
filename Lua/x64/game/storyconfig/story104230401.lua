return {
	Play423041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423041001
		arg_1_1.duration_ = 11.7

		local var_1_0 = {
			zh = 6.6,
			ja = 11.7
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
				arg_1_0:Play423041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I25h"

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
				local var_4_5 = arg_1_1.bgs_.I25h

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
					if iter_4_0 ~= "I25h" then
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

			local var_4_24 = 0.166666666666667
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
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

				arg_1_1:AudioAction(var_4_36, var_4_37, "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_38 = ""
				local var_4_39 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 2
			local var_4_41 = 0.4

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_43 = arg_1_1:FormatText(StoryNameCfg[1335].name)

				arg_1_1.leftNameTxt_.text = var_4_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_44 = arg_1_1:GetWordFromCfg(423041001)
				local var_4_45 = arg_1_1:FormatText(var_4_44.content)

				arg_1_1.text_.text = var_4_45

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_46 = 16
				local var_4_47 = utf8.len(var_4_45)
				local var_4_48 = var_4_46 <= 0 and var_4_41 or var_4_41 * (var_4_47 / var_4_46)

				if var_4_48 > 0 and var_4_41 < var_4_48 then
					arg_1_1.talkMaxDuration = var_4_48
					var_4_40 = var_4_40 + 0.3

					if var_4_48 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_48 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_45
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041001", "story_v_out_423041.awb") ~= 0 then
					local var_4_49 = manager.audio:GetVoiceLength("story_v_out_423041", "423041001", "story_v_out_423041.awb") / 1000

					if var_4_49 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_49 + var_4_40
					end

					if var_4_44.prefab_name ~= "" and arg_1_1.actors_[var_4_44.prefab_name] ~= nil then
						local var_4_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_44.prefab_name].transform, "story_v_out_423041", "423041001", "story_v_out_423041.awb")

						arg_1_1:RecordAudio("423041001", var_4_50)
						arg_1_1:RecordAudio("423041001", var_4_50)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423041", "423041001", "story_v_out_423041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423041", "423041001", "story_v_out_423041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_51 = var_4_40 + 0.3
			local var_4_52 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_51 <= arg_1_1.time_ and arg_1_1.time_ < var_4_51 + var_4_52 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_51) / var_4_52

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_51 + var_4_52 and arg_1_1.time_ < var_4_51 + var_4_52 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play423041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423041002
		arg_9_1.duration_ = 5.73

		local var_9_0 = {
			zh = 5.733,
			ja = 4.033
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
				arg_9_0:Play423041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.575

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[1335].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(423041002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 23
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041002", "story_v_out_423041.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041002", "story_v_out_423041.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_423041", "423041002", "story_v_out_423041.awb")

						arg_9_1:RecordAudio("423041002", var_12_9)
						arg_9_1:RecordAudio("423041002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_423041", "423041002", "story_v_out_423041.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_423041", "423041002", "story_v_out_423041.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_10 and arg_9_1.time_ < var_12_0 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play423041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423041003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play423041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.35

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(423041003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 54
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play423041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 423041004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play423041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.2

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(423041004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 48
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play423041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 423041005
		arg_21_1.duration_ = 7.63

		local var_21_0 = {
			zh = 6.133,
			ja = 7.633
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
				arg_21_0:Play423041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.7

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[1335].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(423041005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041005", "story_v_out_423041.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041005", "story_v_out_423041.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_423041", "423041005", "story_v_out_423041.awb")

						arg_21_1:RecordAudio("423041005", var_24_9)
						arg_21_1:RecordAudio("423041005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_423041", "423041005", "story_v_out_423041.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_423041", "423041005", "story_v_out_423041.awb")
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
	Play423041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 423041006
		arg_25_1.duration_ = 5.8

		local var_25_0 = {
			zh = 5.8,
			ja = 5.4
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
				arg_25_0:Play423041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.775

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[1335].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(423041006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041006", "story_v_out_423041.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041006", "story_v_out_423041.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_423041", "423041006", "story_v_out_423041.awb")

						arg_25_1:RecordAudio("423041006", var_28_9)
						arg_25_1:RecordAudio("423041006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_423041", "423041006", "story_v_out_423041.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_423041", "423041006", "story_v_out_423041.awb")
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
	Play423041007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 423041007
		arg_29_1.duration_ = 5.27

		local var_29_0 = {
			zh = 4.8,
			ja = 5.266
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
				arg_29_0:Play423041008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.425

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[1336].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(423041007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 17
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041007", "story_v_out_423041.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041007", "story_v_out_423041.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_423041", "423041007", "story_v_out_423041.awb")

						arg_29_1:RecordAudio("423041007", var_32_9)
						arg_29_1:RecordAudio("423041007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_423041", "423041007", "story_v_out_423041.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_423041", "423041007", "story_v_out_423041.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play423041008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 423041008
		arg_33_1.duration_ = 6.83

		local var_33_0 = {
			zh = 6.833,
			ja = 5.233
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
				arg_33_0:Play423041009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.675

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[1336].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(423041008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041008", "story_v_out_423041.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041008", "story_v_out_423041.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_423041", "423041008", "story_v_out_423041.awb")

						arg_33_1:RecordAudio("423041008", var_36_9)
						arg_33_1:RecordAudio("423041008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_423041", "423041008", "story_v_out_423041.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_423041", "423041008", "story_v_out_423041.awb")
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
	Play423041009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423041009
		arg_37_1.duration_ = 3.8

		local var_37_0 = {
			zh = 3.8,
			ja = 3.466
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play423041010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "10148"

			if arg_37_1.actors_[var_40_0] == nil then
				local var_40_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10148")

				if not isNil(var_40_1) then
					local var_40_2 = Object.Instantiate(var_40_1, arg_37_1.canvasGo_.transform)

					var_40_2.transform:SetSiblingIndex(1)

					var_40_2.name = var_40_0
					var_40_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_37_1.actors_[var_40_0] = var_40_2

					local var_40_3 = var_40_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_37_1.isInRecall_ then
						for iter_40_0, iter_40_1 in ipairs(var_40_3) do
							iter_40_1.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_40_4 = arg_37_1.actors_["10148"]
			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.actorSpriteComps10148 == nil then
				arg_37_1.var_.actorSpriteComps10148 = var_40_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_6 = 0.2

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 and not isNil(var_40_4) then
				local var_40_7 = (arg_37_1.time_ - var_40_5) / var_40_6

				if arg_37_1.var_.actorSpriteComps10148 then
					for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_40_3 then
							if arg_37_1.isInRecall_ then
								local var_40_8 = Mathf.Lerp(iter_40_3.color.r, arg_37_1.hightColor1.r, var_40_7)
								local var_40_9 = Mathf.Lerp(iter_40_3.color.g, arg_37_1.hightColor1.g, var_40_7)
								local var_40_10 = Mathf.Lerp(iter_40_3.color.b, arg_37_1.hightColor1.b, var_40_7)

								iter_40_3.color = Color.New(var_40_8, var_40_9, var_40_10)
							else
								local var_40_11 = Mathf.Lerp(iter_40_3.color.r, 1, var_40_7)

								iter_40_3.color = Color.New(var_40_11, var_40_11, var_40_11)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.actorSpriteComps10148 then
				for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_40_5 then
						if arg_37_1.isInRecall_ then
							iter_40_5.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10148 = nil
			end

			local var_40_12 = arg_37_1.actors_["10148"].transform
			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1.var_.moveOldPos10148 = var_40_12.localPosition
				var_40_12.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10148", 3)

				local var_40_14 = var_40_12.childCount

				for iter_40_6 = 0, var_40_14 - 1 do
					local var_40_15 = var_40_12:GetChild(iter_40_6)

					if var_40_15.name == "" or not string.find(var_40_15.name, "split") then
						var_40_15.gameObject:SetActive(true)
					else
						var_40_15.gameObject:SetActive(false)
					end
				end
			end

			local var_40_16 = 0.001

			if var_40_13 <= arg_37_1.time_ and arg_37_1.time_ < var_40_13 + var_40_16 then
				local var_40_17 = (arg_37_1.time_ - var_40_13) / var_40_16
				local var_40_18 = Vector3.New(0, -350, -270)

				var_40_12.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10148, var_40_18, var_40_17)
			end

			if arg_37_1.time_ >= var_40_13 + var_40_16 and arg_37_1.time_ < var_40_13 + var_40_16 + arg_40_0 then
				var_40_12.localPosition = Vector3.New(0, -350, -270)
			end

			local var_40_19 = arg_37_1.actors_["10148"]
			local var_40_20 = 0

			if var_40_20 < arg_37_1.time_ and arg_37_1.time_ <= var_40_20 + arg_40_0 then
				local var_40_21 = var_40_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_40_21 then
					arg_37_1.var_.alphaOldValue10148 = var_40_21.alpha
					arg_37_1.var_.characterEffect10148 = var_40_21
				end

				arg_37_1.var_.alphaOldValue10148 = 0
			end

			local var_40_22 = 0.5

			if var_40_20 <= arg_37_1.time_ and arg_37_1.time_ < var_40_20 + var_40_22 then
				local var_40_23 = (arg_37_1.time_ - var_40_20) / var_40_22
				local var_40_24 = Mathf.Lerp(arg_37_1.var_.alphaOldValue10148, 1, var_40_23)

				if arg_37_1.var_.characterEffect10148 then
					arg_37_1.var_.characterEffect10148.alpha = var_40_24
				end
			end

			if arg_37_1.time_ >= var_40_20 + var_40_22 and arg_37_1.time_ < var_40_20 + var_40_22 + arg_40_0 and arg_37_1.var_.characterEffect10148 then
				arg_37_1.var_.characterEffect10148.alpha = 1
			end

			local var_40_25 = 0
			local var_40_26 = 0.5

			if var_40_25 < arg_37_1.time_ and arg_37_1.time_ <= var_40_25 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_27 = arg_37_1:FormatText(StoryNameCfg[1331].name)

				arg_37_1.leftNameTxt_.text = var_40_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_28 = arg_37_1:GetWordFromCfg(423041009)
				local var_40_29 = arg_37_1:FormatText(var_40_28.content)

				arg_37_1.text_.text = var_40_29

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_30 = 20
				local var_40_31 = utf8.len(var_40_29)
				local var_40_32 = var_40_30 <= 0 and var_40_26 or var_40_26 * (var_40_31 / var_40_30)

				if var_40_32 > 0 and var_40_26 < var_40_32 then
					arg_37_1.talkMaxDuration = var_40_32

					if var_40_32 + var_40_25 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_32 + var_40_25
					end
				end

				arg_37_1.text_.text = var_40_29
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041009", "story_v_out_423041.awb") ~= 0 then
					local var_40_33 = manager.audio:GetVoiceLength("story_v_out_423041", "423041009", "story_v_out_423041.awb") / 1000

					if var_40_33 + var_40_25 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_33 + var_40_25
					end

					if var_40_28.prefab_name ~= "" and arg_37_1.actors_[var_40_28.prefab_name] ~= nil then
						local var_40_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_28.prefab_name].transform, "story_v_out_423041", "423041009", "story_v_out_423041.awb")

						arg_37_1:RecordAudio("423041009", var_40_34)
						arg_37_1:RecordAudio("423041009", var_40_34)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_423041", "423041009", "story_v_out_423041.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_423041", "423041009", "story_v_out_423041.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_35 = math.max(var_40_26, arg_37_1.talkMaxDuration)

			if var_40_25 <= arg_37_1.time_ and arg_37_1.time_ < var_40_25 + var_40_35 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_25) / var_40_35

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_25 + var_40_35 and arg_37_1.time_ < var_40_25 + var_40_35 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play423041010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 423041010
		arg_41_1.duration_ = 7.17

		local var_41_0 = {
			zh = 7.166,
			ja = 6.1
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
				arg_41_0:Play423041011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10148"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10148 == nil then
				arg_41_1.var_.actorSpriteComps10148 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps10148 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 0.5, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10148 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10148 = nil
			end

			local var_44_8 = 0
			local var_44_9 = 0.75

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_10 = arg_41_1:FormatText(StoryNameCfg[1336].name)

				arg_41_1.leftNameTxt_.text = var_44_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_11 = arg_41_1:GetWordFromCfg(423041010)
				local var_44_12 = arg_41_1:FormatText(var_44_11.content)

				arg_41_1.text_.text = var_44_12

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 30
				local var_44_14 = utf8.len(var_44_12)
				local var_44_15 = var_44_13 <= 0 and var_44_9 or var_44_9 * (var_44_14 / var_44_13)

				if var_44_15 > 0 and var_44_9 < var_44_15 then
					arg_41_1.talkMaxDuration = var_44_15

					if var_44_15 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_15 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_12
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041010", "story_v_out_423041.awb") ~= 0 then
					local var_44_16 = manager.audio:GetVoiceLength("story_v_out_423041", "423041010", "story_v_out_423041.awb") / 1000

					if var_44_16 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_16 + var_44_8
					end

					if var_44_11.prefab_name ~= "" and arg_41_1.actors_[var_44_11.prefab_name] ~= nil then
						local var_44_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_11.prefab_name].transform, "story_v_out_423041", "423041010", "story_v_out_423041.awb")

						arg_41_1:RecordAudio("423041010", var_44_17)
						arg_41_1:RecordAudio("423041010", var_44_17)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_423041", "423041010", "story_v_out_423041.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_423041", "423041010", "story_v_out_423041.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_18 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_18 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_18

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_18 and arg_41_1.time_ < var_44_8 + var_44_18 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play423041011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 423041011
		arg_45_1.duration_ = 2.4

		local var_45_0 = {
			zh = 2.4,
			ja = 2.133
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
				arg_45_0:Play423041012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.25

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[1336].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(423041011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 10
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041011", "story_v_out_423041.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041011", "story_v_out_423041.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_423041", "423041011", "story_v_out_423041.awb")

						arg_45_1:RecordAudio("423041011", var_48_9)
						arg_45_1:RecordAudio("423041011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_423041", "423041011", "story_v_out_423041.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_423041", "423041011", "story_v_out_423041.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play423041012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 423041012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play423041013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10148"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10148 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10148", 7)

				local var_52_2 = var_52_0.childCount

				for iter_52_0 = 0, var_52_2 - 1 do
					local var_52_3 = var_52_0:GetChild(iter_52_0)

					if var_52_3.name == "" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_1) / var_52_4
				local var_52_6 = Vector3.New(0, -2000, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10148, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_7 = 0
			local var_52_8 = 1.675

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_9 = arg_49_1:GetWordFromCfg(423041012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 67
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_8 or var_52_8 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_8 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_7 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_7
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_8, arg_49_1.talkMaxDuration)

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_7) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_7 + var_52_14 and arg_49_1.time_ < var_52_7 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play423041013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 423041013
		arg_53_1.duration_ = 4.93

		local var_53_0 = {
			zh = 4.5,
			ja = 4.933
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
				arg_53_0:Play423041014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10148"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10148 == nil then
				arg_53_1.var_.actorSpriteComps10148 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps10148 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								local var_56_4 = Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor1.r, var_56_3)
								local var_56_5 = Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor1.g, var_56_3)
								local var_56_6 = Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor1.b, var_56_3)

								iter_56_1.color = Color.New(var_56_4, var_56_5, var_56_6)
							else
								local var_56_7 = Mathf.Lerp(iter_56_1.color.r, 1, var_56_3)

								iter_56_1.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10148 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10148 = nil
			end

			local var_56_8 = arg_53_1.actors_["10148"].transform
			local var_56_9 = 0

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				arg_53_1.var_.moveOldPos10148 = var_56_8.localPosition
				var_56_8.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10148", 3)

				local var_56_10 = var_56_8.childCount

				for iter_56_4 = 0, var_56_10 - 1 do
					local var_56_11 = var_56_8:GetChild(iter_56_4)

					if var_56_11.name == "split_6" or not string.find(var_56_11.name, "split") then
						var_56_11.gameObject:SetActive(true)
					else
						var_56_11.gameObject:SetActive(false)
					end
				end
			end

			local var_56_12 = 0.001

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_12 then
				local var_56_13 = (arg_53_1.time_ - var_56_9) / var_56_12
				local var_56_14 = Vector3.New(0, -350, -270)

				var_56_8.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10148, var_56_14, var_56_13)
			end

			if arg_53_1.time_ >= var_56_9 + var_56_12 and arg_53_1.time_ < var_56_9 + var_56_12 + arg_56_0 then
				var_56_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_56_15 = 0
			local var_56_16 = 0.5

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_17 = arg_53_1:FormatText(StoryNameCfg[1331].name)

				arg_53_1.leftNameTxt_.text = var_56_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_18 = arg_53_1:GetWordFromCfg(423041013)
				local var_56_19 = arg_53_1:FormatText(var_56_18.content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 20
				local var_56_21 = utf8.len(var_56_19)
				local var_56_22 = var_56_20 <= 0 and var_56_16 or var_56_16 * (var_56_21 / var_56_20)

				if var_56_22 > 0 and var_56_16 < var_56_22 then
					arg_53_1.talkMaxDuration = var_56_22

					if var_56_22 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_22 + var_56_15
					end
				end

				arg_53_1.text_.text = var_56_19
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041013", "story_v_out_423041.awb") ~= 0 then
					local var_56_23 = manager.audio:GetVoiceLength("story_v_out_423041", "423041013", "story_v_out_423041.awb") / 1000

					if var_56_23 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_15
					end

					if var_56_18.prefab_name ~= "" and arg_53_1.actors_[var_56_18.prefab_name] ~= nil then
						local var_56_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_18.prefab_name].transform, "story_v_out_423041", "423041013", "story_v_out_423041.awb")

						arg_53_1:RecordAudio("423041013", var_56_24)
						arg_53_1:RecordAudio("423041013", var_56_24)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_423041", "423041013", "story_v_out_423041.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_423041", "423041013", "story_v_out_423041.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_25 = math.max(var_56_16, arg_53_1.talkMaxDuration)

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_25 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_15) / var_56_25

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_15 + var_56_25 and arg_53_1.time_ < var_56_15 + var_56_25 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play423041014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 423041014
		arg_57_1.duration_ = 5.6

		local var_57_0 = {
			zh = 5.4,
			ja = 5.6
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
				arg_57_0:Play423041015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.45

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[1331].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(423041014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 18
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041014", "story_v_out_423041.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041014", "story_v_out_423041.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_423041", "423041014", "story_v_out_423041.awb")

						arg_57_1:RecordAudio("423041014", var_60_9)
						arg_57_1:RecordAudio("423041014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_423041", "423041014", "story_v_out_423041.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_423041", "423041014", "story_v_out_423041.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play423041015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 423041015
		arg_61_1.duration_ = 8.03

		local var_61_0 = {
			zh = 8.033,
			ja = 5.3
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
				arg_61_0:Play423041016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10148"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10148 == nil then
				arg_61_1.var_.actorSpriteComps10148 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10148 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor2.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor2.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor2.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 0.5, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10148 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10148 = nil
			end

			local var_64_8 = 0
			local var_64_9 = 0.825

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_10 = arg_61_1:FormatText(StoryNameCfg[1335].name)

				arg_61_1.leftNameTxt_.text = var_64_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_11 = arg_61_1:GetWordFromCfg(423041015)
				local var_64_12 = arg_61_1:FormatText(var_64_11.content)

				arg_61_1.text_.text = var_64_12

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 33
				local var_64_14 = utf8.len(var_64_12)
				local var_64_15 = var_64_13 <= 0 and var_64_9 or var_64_9 * (var_64_14 / var_64_13)

				if var_64_15 > 0 and var_64_9 < var_64_15 then
					arg_61_1.talkMaxDuration = var_64_15

					if var_64_15 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_15 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_12
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041015", "story_v_out_423041.awb") ~= 0 then
					local var_64_16 = manager.audio:GetVoiceLength("story_v_out_423041", "423041015", "story_v_out_423041.awb") / 1000

					if var_64_16 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_8
					end

					if var_64_11.prefab_name ~= "" and arg_61_1.actors_[var_64_11.prefab_name] ~= nil then
						local var_64_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_11.prefab_name].transform, "story_v_out_423041", "423041015", "story_v_out_423041.awb")

						arg_61_1:RecordAudio("423041015", var_64_17)
						arg_61_1:RecordAudio("423041015", var_64_17)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_423041", "423041015", "story_v_out_423041.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_423041", "423041015", "story_v_out_423041.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_18 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_18 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_18

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_18 and arg_61_1.time_ < var_64_8 + var_64_18 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play423041016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 423041016
		arg_65_1.duration_ = 5.23

		local var_65_0 = {
			zh = 4.533,
			ja = 5.233
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
				arg_65_0:Play423041017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.55

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[1335].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(423041016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 22
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041016", "story_v_out_423041.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041016", "story_v_out_423041.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_423041", "423041016", "story_v_out_423041.awb")

						arg_65_1:RecordAudio("423041016", var_68_9)
						arg_65_1:RecordAudio("423041016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_423041", "423041016", "story_v_out_423041.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_423041", "423041016", "story_v_out_423041.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_10 and arg_65_1.time_ < var_68_0 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play423041017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 423041017
		arg_69_1.duration_ = 8.57

		local var_69_0 = {
			zh = 8.566,
			ja = 8.533
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
				arg_69_0:Play423041018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10148"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10148 == nil then
				arg_69_1.var_.actorSpriteComps10148 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps10148 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								local var_72_4 = Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor1.r, var_72_3)
								local var_72_5 = Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor1.g, var_72_3)
								local var_72_6 = Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor1.b, var_72_3)

								iter_72_1.color = Color.New(var_72_4, var_72_5, var_72_6)
							else
								local var_72_7 = Mathf.Lerp(iter_72_1.color.r, 1, var_72_3)

								iter_72_1.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10148 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10148 = nil
			end

			local var_72_8 = arg_69_1.actors_["10148"].transform
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.var_.moveOldPos10148 = var_72_8.localPosition
				var_72_8.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10148", 3)

				local var_72_10 = var_72_8.childCount

				for iter_72_4 = 0, var_72_10 - 1 do
					local var_72_11 = var_72_8:GetChild(iter_72_4)

					if var_72_11.name == "" or not string.find(var_72_11.name, "split") then
						var_72_11.gameObject:SetActive(true)
					else
						var_72_11.gameObject:SetActive(false)
					end
				end
			end

			local var_72_12 = 0.001

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_12 then
				local var_72_13 = (arg_69_1.time_ - var_72_9) / var_72_12
				local var_72_14 = Vector3.New(0, -350, -270)

				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10148, var_72_14, var_72_13)
			end

			if arg_69_1.time_ >= var_72_9 + var_72_12 and arg_69_1.time_ < var_72_9 + var_72_12 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_72_15 = 0
			local var_72_16 = 0.975

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_17 = arg_69_1:FormatText(StoryNameCfg[1331].name)

				arg_69_1.leftNameTxt_.text = var_72_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_18 = arg_69_1:GetWordFromCfg(423041017)
				local var_72_19 = arg_69_1:FormatText(var_72_18.content)

				arg_69_1.text_.text = var_72_19

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_20 = 39
				local var_72_21 = utf8.len(var_72_19)
				local var_72_22 = var_72_20 <= 0 and var_72_16 or var_72_16 * (var_72_21 / var_72_20)

				if var_72_22 > 0 and var_72_16 < var_72_22 then
					arg_69_1.talkMaxDuration = var_72_22

					if var_72_22 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_22 + var_72_15
					end
				end

				arg_69_1.text_.text = var_72_19
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041017", "story_v_out_423041.awb") ~= 0 then
					local var_72_23 = manager.audio:GetVoiceLength("story_v_out_423041", "423041017", "story_v_out_423041.awb") / 1000

					if var_72_23 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_15
					end

					if var_72_18.prefab_name ~= "" and arg_69_1.actors_[var_72_18.prefab_name] ~= nil then
						local var_72_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_18.prefab_name].transform, "story_v_out_423041", "423041017", "story_v_out_423041.awb")

						arg_69_1:RecordAudio("423041017", var_72_24)
						arg_69_1:RecordAudio("423041017", var_72_24)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_423041", "423041017", "story_v_out_423041.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_423041", "423041017", "story_v_out_423041.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_25 = math.max(var_72_16, arg_69_1.talkMaxDuration)

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_25 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_15) / var_72_25

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_15 + var_72_25 and arg_69_1.time_ < var_72_15 + var_72_25 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play423041018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 423041018
		arg_73_1.duration_ = 10.23

		local var_73_0 = {
			zh = 9.266,
			ja = 10.233
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
				arg_73_0:Play423041019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10148"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10148 == nil then
				arg_73_1.var_.actorSpriteComps10148 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps10148 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								local var_76_4 = Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor2.r, var_76_3)
								local var_76_5 = Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor2.g, var_76_3)
								local var_76_6 = Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor2.b, var_76_3)

								iter_76_1.color = Color.New(var_76_4, var_76_5, var_76_6)
							else
								local var_76_7 = Mathf.Lerp(iter_76_1.color.r, 0.5, var_76_3)

								iter_76_1.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10148 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10148 = nil
			end

			local var_76_8 = 0
			local var_76_9 = 0.825

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_10 = arg_73_1:FormatText(StoryNameCfg[1335].name)

				arg_73_1.leftNameTxt_.text = var_76_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_11 = arg_73_1:GetWordFromCfg(423041018)
				local var_76_12 = arg_73_1:FormatText(var_76_11.content)

				arg_73_1.text_.text = var_76_12

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 33
				local var_76_14 = utf8.len(var_76_12)
				local var_76_15 = var_76_13 <= 0 and var_76_9 or var_76_9 * (var_76_14 / var_76_13)

				if var_76_15 > 0 and var_76_9 < var_76_15 then
					arg_73_1.talkMaxDuration = var_76_15

					if var_76_15 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_15 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_12
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041018", "story_v_out_423041.awb") ~= 0 then
					local var_76_16 = manager.audio:GetVoiceLength("story_v_out_423041", "423041018", "story_v_out_423041.awb") / 1000

					if var_76_16 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_8
					end

					if var_76_11.prefab_name ~= "" and arg_73_1.actors_[var_76_11.prefab_name] ~= nil then
						local var_76_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_11.prefab_name].transform, "story_v_out_423041", "423041018", "story_v_out_423041.awb")

						arg_73_1:RecordAudio("423041018", var_76_17)
						arg_73_1:RecordAudio("423041018", var_76_17)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_423041", "423041018", "story_v_out_423041.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_423041", "423041018", "story_v_out_423041.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_18 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_18 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_18

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_18 and arg_73_1.time_ < var_76_8 + var_76_18 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play423041019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 423041019
		arg_77_1.duration_ = 6.83

		local var_77_0 = {
			zh = 6.6,
			ja = 6.833
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
				arg_77_0:Play423041020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.525

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[1336].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(423041019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 21
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041019", "story_v_out_423041.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041019", "story_v_out_423041.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_423041", "423041019", "story_v_out_423041.awb")

						arg_77_1:RecordAudio("423041019", var_80_9)
						arg_77_1:RecordAudio("423041019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_423041", "423041019", "story_v_out_423041.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_423041", "423041019", "story_v_out_423041.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play423041020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 423041020
		arg_81_1.duration_ = 8.73

		local var_81_0 = {
			zh = 4.566,
			ja = 8.733
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
				arg_81_0:Play423041021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.45

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[1336].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(423041020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 18
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041020", "story_v_out_423041.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041020", "story_v_out_423041.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_423041", "423041020", "story_v_out_423041.awb")

						arg_81_1:RecordAudio("423041020", var_84_9)
						arg_81_1:RecordAudio("423041020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_423041", "423041020", "story_v_out_423041.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_423041", "423041020", "story_v_out_423041.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play423041021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 423041021
		arg_85_1.duration_ = 7.23

		local var_85_0 = {
			zh = 7.2,
			ja = 7.233
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
				arg_85_0:Play423041022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10148"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10148 == nil then
				arg_85_1.var_.actorSpriteComps10148 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps10148 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								local var_88_4 = Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor1.r, var_88_3)
								local var_88_5 = Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor1.g, var_88_3)
								local var_88_6 = Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor1.b, var_88_3)

								iter_88_1.color = Color.New(var_88_4, var_88_5, var_88_6)
							else
								local var_88_7 = Mathf.Lerp(iter_88_1.color.r, 1, var_88_3)

								iter_88_1.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10148 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10148 = nil
			end

			local var_88_8 = arg_85_1.actors_["10148"].transform
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 then
				arg_85_1.var_.moveOldPos10148 = var_88_8.localPosition
				var_88_8.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10148", 3)

				local var_88_10 = var_88_8.childCount

				for iter_88_4 = 0, var_88_10 - 1 do
					local var_88_11 = var_88_8:GetChild(iter_88_4)

					if var_88_11.name == "" or not string.find(var_88_11.name, "split") then
						var_88_11.gameObject:SetActive(true)
					else
						var_88_11.gameObject:SetActive(false)
					end
				end
			end

			local var_88_12 = 0.001

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_12 then
				local var_88_13 = (arg_85_1.time_ - var_88_9) / var_88_12
				local var_88_14 = Vector3.New(0, -350, -270)

				var_88_8.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10148, var_88_14, var_88_13)
			end

			if arg_85_1.time_ >= var_88_9 + var_88_12 and arg_85_1.time_ < var_88_9 + var_88_12 + arg_88_0 then
				var_88_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_88_15 = 0
			local var_88_16 = 0.85

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[1331].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(423041021)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 34
				local var_88_21 = utf8.len(var_88_19)
				local var_88_22 = var_88_20 <= 0 and var_88_16 or var_88_16 * (var_88_21 / var_88_20)

				if var_88_22 > 0 and var_88_16 < var_88_22 then
					arg_85_1.talkMaxDuration = var_88_22

					if var_88_22 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_22 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_19
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041021", "story_v_out_423041.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_423041", "423041021", "story_v_out_423041.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_out_423041", "423041021", "story_v_out_423041.awb")

						arg_85_1:RecordAudio("423041021", var_88_24)
						arg_85_1:RecordAudio("423041021", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_423041", "423041021", "story_v_out_423041.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_423041", "423041021", "story_v_out_423041.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_25 and arg_85_1.time_ < var_88_15 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play423041022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 423041022
		arg_89_1.duration_ = 4.67

		local var_89_0 = {
			zh = 4.5,
			ja = 4.666
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
				arg_89_0:Play423041023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10148"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10148 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10148", 3)

				local var_92_2 = var_92_0.childCount

				for iter_92_0 = 0, var_92_2 - 1 do
					local var_92_3 = var_92_0:GetChild(iter_92_0)

					if var_92_3.name == "" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_1) / var_92_4
				local var_92_6 = Vector3.New(0, -350, -270)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10148, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -350, -270)
			end

			local var_92_7 = 0
			local var_92_8 = 0.4

			if var_92_7 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_9 = arg_89_1:FormatText(StoryNameCfg[1331].name)

				arg_89_1.leftNameTxt_.text = var_92_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:GetWordFromCfg(423041022)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_12 = 16
				local var_92_13 = utf8.len(var_92_11)
				local var_92_14 = var_92_12 <= 0 and var_92_8 or var_92_8 * (var_92_13 / var_92_12)

				if var_92_14 > 0 and var_92_8 < var_92_14 then
					arg_89_1.talkMaxDuration = var_92_14

					if var_92_14 + var_92_7 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_7
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041022", "story_v_out_423041.awb") ~= 0 then
					local var_92_15 = manager.audio:GetVoiceLength("story_v_out_423041", "423041022", "story_v_out_423041.awb") / 1000

					if var_92_15 + var_92_7 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_15 + var_92_7
					end

					if var_92_10.prefab_name ~= "" and arg_89_1.actors_[var_92_10.prefab_name] ~= nil then
						local var_92_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_10.prefab_name].transform, "story_v_out_423041", "423041022", "story_v_out_423041.awb")

						arg_89_1:RecordAudio("423041022", var_92_16)
						arg_89_1:RecordAudio("423041022", var_92_16)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_423041", "423041022", "story_v_out_423041.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_423041", "423041022", "story_v_out_423041.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_17 = math.max(var_92_8, arg_89_1.talkMaxDuration)

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_17 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_7) / var_92_17

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_7 + var_92_17 and arg_89_1.time_ < var_92_7 + var_92_17 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play423041023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 423041023
		arg_93_1.duration_ = 6.63

		local var_93_0 = {
			zh = 5.633,
			ja = 6.633
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
				arg_93_0:Play423041024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10148"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10148 == nil then
				arg_93_1.var_.actorSpriteComps10148 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps10148 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								local var_96_4 = Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor2.r, var_96_3)
								local var_96_5 = Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor2.g, var_96_3)
								local var_96_6 = Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor2.b, var_96_3)

								iter_96_1.color = Color.New(var_96_4, var_96_5, var_96_6)
							else
								local var_96_7 = Mathf.Lerp(iter_96_1.color.r, 0.5, var_96_3)

								iter_96_1.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10148 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10148 = nil
			end

			local var_96_8 = 0
			local var_96_9 = 0.525

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_10 = arg_93_1:FormatText(StoryNameCfg[1335].name)

				arg_93_1.leftNameTxt_.text = var_96_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_11 = arg_93_1:GetWordFromCfg(423041023)
				local var_96_12 = arg_93_1:FormatText(var_96_11.content)

				arg_93_1.text_.text = var_96_12

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 21
				local var_96_14 = utf8.len(var_96_12)
				local var_96_15 = var_96_13 <= 0 and var_96_9 or var_96_9 * (var_96_14 / var_96_13)

				if var_96_15 > 0 and var_96_9 < var_96_15 then
					arg_93_1.talkMaxDuration = var_96_15

					if var_96_15 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_15 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_12
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041023", "story_v_out_423041.awb") ~= 0 then
					local var_96_16 = manager.audio:GetVoiceLength("story_v_out_423041", "423041023", "story_v_out_423041.awb") / 1000

					if var_96_16 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_8
					end

					if var_96_11.prefab_name ~= "" and arg_93_1.actors_[var_96_11.prefab_name] ~= nil then
						local var_96_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_11.prefab_name].transform, "story_v_out_423041", "423041023", "story_v_out_423041.awb")

						arg_93_1:RecordAudio("423041023", var_96_17)
						arg_93_1:RecordAudio("423041023", var_96_17)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_423041", "423041023", "story_v_out_423041.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_423041", "423041023", "story_v_out_423041.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_18 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_18 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_18

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_18 and arg_93_1.time_ < var_96_8 + var_96_18 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play423041024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 423041024
		arg_97_1.duration_ = 5.5

		local var_97_0 = {
			zh = 5.5,
			ja = 3.6
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
				arg_97_0:Play423041025(arg_97_1)
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

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[1336].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(423041024)
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

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041024", "story_v_out_423041.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041024", "story_v_out_423041.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_423041", "423041024", "story_v_out_423041.awb")

						arg_97_1:RecordAudio("423041024", var_100_9)
						arg_97_1:RecordAudio("423041024", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_423041", "423041024", "story_v_out_423041.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_423041", "423041024", "story_v_out_423041.awb")
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
	Play423041025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 423041025
		arg_101_1.duration_ = 6.07

		local var_101_0 = {
			zh = 6.066,
			ja = 4.866
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
				arg_101_0:Play423041026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.375

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[1336].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(423041025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041025", "story_v_out_423041.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041025", "story_v_out_423041.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_423041", "423041025", "story_v_out_423041.awb")

						arg_101_1:RecordAudio("423041025", var_104_9)
						arg_101_1:RecordAudio("423041025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_423041", "423041025", "story_v_out_423041.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_423041", "423041025", "story_v_out_423041.awb")
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
	Play423041026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 423041026
		arg_105_1.duration_ = 7.07

		local var_105_0 = {
			zh = 5.9,
			ja = 7.066
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play423041027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10148"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10148 == nil then
				arg_105_1.var_.actorSpriteComps10148 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps10148 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_4 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, var_108_3)
								local var_108_5 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, var_108_3)
								local var_108_6 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, var_108_3)

								iter_108_1.color = Color.New(var_108_4, var_108_5, var_108_6)
							else
								local var_108_7 = Mathf.Lerp(iter_108_1.color.r, 1, var_108_3)

								iter_108_1.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10148 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10148 = nil
			end

			local var_108_8 = arg_105_1.actors_["10148"].transform
			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 then
				arg_105_1.var_.moveOldPos10148 = var_108_8.localPosition
				var_108_8.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10148", 3)

				local var_108_10 = var_108_8.childCount

				for iter_108_4 = 0, var_108_10 - 1 do
					local var_108_11 = var_108_8:GetChild(iter_108_4)

					if var_108_11.name == "split_6" or not string.find(var_108_11.name, "split") then
						var_108_11.gameObject:SetActive(true)
					else
						var_108_11.gameObject:SetActive(false)
					end
				end
			end

			local var_108_12 = 0.001

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_12 then
				local var_108_13 = (arg_105_1.time_ - var_108_9) / var_108_12
				local var_108_14 = Vector3.New(0, -350, -270)

				var_108_8.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10148, var_108_14, var_108_13)
			end

			if arg_105_1.time_ >= var_108_9 + var_108_12 and arg_105_1.time_ < var_108_9 + var_108_12 + arg_108_0 then
				var_108_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_108_15 = 0
			local var_108_16 = 0.625

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_17 = arg_105_1:FormatText(StoryNameCfg[1331].name)

				arg_105_1.leftNameTxt_.text = var_108_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_18 = arg_105_1:GetWordFromCfg(423041026)
				local var_108_19 = arg_105_1:FormatText(var_108_18.content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 25
				local var_108_21 = utf8.len(var_108_19)
				local var_108_22 = var_108_20 <= 0 and var_108_16 or var_108_16 * (var_108_21 / var_108_20)

				if var_108_22 > 0 and var_108_16 < var_108_22 then
					arg_105_1.talkMaxDuration = var_108_22

					if var_108_22 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_22 + var_108_15
					end
				end

				arg_105_1.text_.text = var_108_19
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041026", "story_v_out_423041.awb") ~= 0 then
					local var_108_23 = manager.audio:GetVoiceLength("story_v_out_423041", "423041026", "story_v_out_423041.awb") / 1000

					if var_108_23 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_15
					end

					if var_108_18.prefab_name ~= "" and arg_105_1.actors_[var_108_18.prefab_name] ~= nil then
						local var_108_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_18.prefab_name].transform, "story_v_out_423041", "423041026", "story_v_out_423041.awb")

						arg_105_1:RecordAudio("423041026", var_108_24)
						arg_105_1:RecordAudio("423041026", var_108_24)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_423041", "423041026", "story_v_out_423041.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_423041", "423041026", "story_v_out_423041.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_25 = math.max(var_108_16, arg_105_1.talkMaxDuration)

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_25 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_15) / var_108_25

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_15 + var_108_25 and arg_105_1.time_ < var_108_15 + var_108_25 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play423041027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 423041027
		arg_109_1.duration_ = 6.63

		local var_109_0 = {
			zh = 5.8,
			ja = 6.633
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
				arg_109_0:Play423041028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10148"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10148 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10148", 3)

				local var_112_2 = var_112_0.childCount

				for iter_112_0 = 0, var_112_2 - 1 do
					local var_112_3 = var_112_0:GetChild(iter_112_0)

					if var_112_3.name == "split_1" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_4 then
				local var_112_5 = (arg_109_1.time_ - var_112_1) / var_112_4
				local var_112_6 = Vector3.New(0, -350, -270)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10148, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -350, -270)
			end

			local var_112_7 = 0
			local var_112_8 = 0.825

			if var_112_7 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_9 = arg_109_1:FormatText(StoryNameCfg[1331].name)

				arg_109_1.leftNameTxt_.text = var_112_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_10 = arg_109_1:GetWordFromCfg(423041027)
				local var_112_11 = arg_109_1:FormatText(var_112_10.content)

				arg_109_1.text_.text = var_112_11

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_12 = 33
				local var_112_13 = utf8.len(var_112_11)
				local var_112_14 = var_112_12 <= 0 and var_112_8 or var_112_8 * (var_112_13 / var_112_12)

				if var_112_14 > 0 and var_112_8 < var_112_14 then
					arg_109_1.talkMaxDuration = var_112_14

					if var_112_14 + var_112_7 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_7
					end
				end

				arg_109_1.text_.text = var_112_11
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041027", "story_v_out_423041.awb") ~= 0 then
					local var_112_15 = manager.audio:GetVoiceLength("story_v_out_423041", "423041027", "story_v_out_423041.awb") / 1000

					if var_112_15 + var_112_7 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_15 + var_112_7
					end

					if var_112_10.prefab_name ~= "" and arg_109_1.actors_[var_112_10.prefab_name] ~= nil then
						local var_112_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_10.prefab_name].transform, "story_v_out_423041", "423041027", "story_v_out_423041.awb")

						arg_109_1:RecordAudio("423041027", var_112_16)
						arg_109_1:RecordAudio("423041027", var_112_16)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_423041", "423041027", "story_v_out_423041.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_423041", "423041027", "story_v_out_423041.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_17 = math.max(var_112_8, arg_109_1.talkMaxDuration)

			if var_112_7 <= arg_109_1.time_ and arg_109_1.time_ < var_112_7 + var_112_17 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_7) / var_112_17

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_7 + var_112_17 and arg_109_1.time_ < var_112_7 + var_112_17 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play423041028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 423041028
		arg_113_1.duration_ = 7.4

		local var_113_0 = {
			zh = 3.7,
			ja = 7.4
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
				arg_113_0:Play423041029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10148"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10148 == nil then
				arg_113_1.var_.actorSpriteComps10148 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps10148 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								local var_116_4 = Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor2.r, var_116_3)
								local var_116_5 = Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor2.g, var_116_3)
								local var_116_6 = Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor2.b, var_116_3)

								iter_116_1.color = Color.New(var_116_4, var_116_5, var_116_6)
							else
								local var_116_7 = Mathf.Lerp(iter_116_1.color.r, 0.5, var_116_3)

								iter_116_1.color = Color.New(var_116_7, var_116_7, var_116_7)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10148 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_116_3 then
						if arg_113_1.isInRecall_ then
							iter_116_3.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10148 = nil
			end

			local var_116_8 = 0
			local var_116_9 = 0.5

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_10 = arg_113_1:FormatText(StoryNameCfg[1336].name)

				arg_113_1.leftNameTxt_.text = var_116_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_11 = arg_113_1:GetWordFromCfg(423041028)
				local var_116_12 = arg_113_1:FormatText(var_116_11.content)

				arg_113_1.text_.text = var_116_12

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 20
				local var_116_14 = utf8.len(var_116_12)
				local var_116_15 = var_116_13 <= 0 and var_116_9 or var_116_9 * (var_116_14 / var_116_13)

				if var_116_15 > 0 and var_116_9 < var_116_15 then
					arg_113_1.talkMaxDuration = var_116_15

					if var_116_15 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_15 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_12
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041028", "story_v_out_423041.awb") ~= 0 then
					local var_116_16 = manager.audio:GetVoiceLength("story_v_out_423041", "423041028", "story_v_out_423041.awb") / 1000

					if var_116_16 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_16 + var_116_8
					end

					if var_116_11.prefab_name ~= "" and arg_113_1.actors_[var_116_11.prefab_name] ~= nil then
						local var_116_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_11.prefab_name].transform, "story_v_out_423041", "423041028", "story_v_out_423041.awb")

						arg_113_1:RecordAudio("423041028", var_116_17)
						arg_113_1:RecordAudio("423041028", var_116_17)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_423041", "423041028", "story_v_out_423041.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_423041", "423041028", "story_v_out_423041.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_18 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_18 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_18

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_18 and arg_113_1.time_ < var_116_8 + var_116_18 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play423041029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 423041029
		arg_117_1.duration_ = 4.5

		local var_117_0 = {
			zh = 2.866,
			ja = 4.5
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
				arg_117_0:Play423041030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10148"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10148 == nil then
				arg_117_1.var_.actorSpriteComps10148 = var_120_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_2 = 0.2

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.actorSpriteComps10148 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								local var_120_4 = Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor1.r, var_120_3)
								local var_120_5 = Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor1.g, var_120_3)
								local var_120_6 = Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor1.b, var_120_3)

								iter_120_1.color = Color.New(var_120_4, var_120_5, var_120_6)
							else
								local var_120_7 = Mathf.Lerp(iter_120_1.color.r, 1, var_120_3)

								iter_120_1.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10148 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_120_3 then
						if arg_117_1.isInRecall_ then
							iter_120_3.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10148 = nil
			end

			local var_120_8 = arg_117_1.actors_["10148"].transform
			local var_120_9 = 0

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 then
				arg_117_1.var_.moveOldPos10148 = var_120_8.localPosition
				var_120_8.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10148", 3)

				local var_120_10 = var_120_8.childCount

				for iter_120_4 = 0, var_120_10 - 1 do
					local var_120_11 = var_120_8:GetChild(iter_120_4)

					if var_120_11.name == "split_6" or not string.find(var_120_11.name, "split") then
						var_120_11.gameObject:SetActive(true)
					else
						var_120_11.gameObject:SetActive(false)
					end
				end
			end

			local var_120_12 = 0.001

			if var_120_9 <= arg_117_1.time_ and arg_117_1.time_ < var_120_9 + var_120_12 then
				local var_120_13 = (arg_117_1.time_ - var_120_9) / var_120_12
				local var_120_14 = Vector3.New(0, -350, -270)

				var_120_8.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10148, var_120_14, var_120_13)
			end

			if arg_117_1.time_ >= var_120_9 + var_120_12 and arg_117_1.time_ < var_120_9 + var_120_12 + arg_120_0 then
				var_120_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_120_15 = 0
			local var_120_16 = 0.425

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_17 = arg_117_1:FormatText(StoryNameCfg[1331].name)

				arg_117_1.leftNameTxt_.text = var_120_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_18 = arg_117_1:GetWordFromCfg(423041029)
				local var_120_19 = arg_117_1:FormatText(var_120_18.content)

				arg_117_1.text_.text = var_120_19

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 17
				local var_120_21 = utf8.len(var_120_19)
				local var_120_22 = var_120_20 <= 0 and var_120_16 or var_120_16 * (var_120_21 / var_120_20)

				if var_120_22 > 0 and var_120_16 < var_120_22 then
					arg_117_1.talkMaxDuration = var_120_22

					if var_120_22 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_22 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_19
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041029", "story_v_out_423041.awb") ~= 0 then
					local var_120_23 = manager.audio:GetVoiceLength("story_v_out_423041", "423041029", "story_v_out_423041.awb") / 1000

					if var_120_23 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_15
					end

					if var_120_18.prefab_name ~= "" and arg_117_1.actors_[var_120_18.prefab_name] ~= nil then
						local var_120_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_18.prefab_name].transform, "story_v_out_423041", "423041029", "story_v_out_423041.awb")

						arg_117_1:RecordAudio("423041029", var_120_24)
						arg_117_1:RecordAudio("423041029", var_120_24)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_423041", "423041029", "story_v_out_423041.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_423041", "423041029", "story_v_out_423041.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_25 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_25 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_15) / var_120_25

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_15 + var_120_25 and arg_117_1.time_ < var_120_15 + var_120_25 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play423041030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 423041030
		arg_121_1.duration_ = 10.2

		local var_121_0 = {
			zh = 7.766,
			ja = 10.2
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
				arg_121_0:Play423041031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10148"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10148 == nil then
				arg_121_1.var_.actorSpriteComps10148 = var_124_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_2 = 0.2

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.actorSpriteComps10148 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								local var_124_4 = Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor2.r, var_124_3)
								local var_124_5 = Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor2.g, var_124_3)
								local var_124_6 = Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor2.b, var_124_3)

								iter_124_1.color = Color.New(var_124_4, var_124_5, var_124_6)
							else
								local var_124_7 = Mathf.Lerp(iter_124_1.color.r, 0.5, var_124_3)

								iter_124_1.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10148 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_124_3 then
						if arg_121_1.isInRecall_ then
							iter_124_3.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10148 = nil
			end

			local var_124_8 = 0
			local var_124_9 = 0.525

			if var_124_8 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_10 = arg_121_1:FormatText(StoryNameCfg[1336].name)

				arg_121_1.leftNameTxt_.text = var_124_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_11 = arg_121_1:GetWordFromCfg(423041030)
				local var_124_12 = arg_121_1:FormatText(var_124_11.content)

				arg_121_1.text_.text = var_124_12

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 21
				local var_124_14 = utf8.len(var_124_12)
				local var_124_15 = var_124_13 <= 0 and var_124_9 or var_124_9 * (var_124_14 / var_124_13)

				if var_124_15 > 0 and var_124_9 < var_124_15 then
					arg_121_1.talkMaxDuration = var_124_15

					if var_124_15 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_15 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_12
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041030", "story_v_out_423041.awb") ~= 0 then
					local var_124_16 = manager.audio:GetVoiceLength("story_v_out_423041", "423041030", "story_v_out_423041.awb") / 1000

					if var_124_16 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_16 + var_124_8
					end

					if var_124_11.prefab_name ~= "" and arg_121_1.actors_[var_124_11.prefab_name] ~= nil then
						local var_124_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_11.prefab_name].transform, "story_v_out_423041", "423041030", "story_v_out_423041.awb")

						arg_121_1:RecordAudio("423041030", var_124_17)
						arg_121_1:RecordAudio("423041030", var_124_17)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_423041", "423041030", "story_v_out_423041.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_423041", "423041030", "story_v_out_423041.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_18 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_18 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_18

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_18 and arg_121_1.time_ < var_124_8 + var_124_18 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play423041031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 423041031
		arg_125_1.duration_ = 5.3

		local var_125_0 = {
			zh = 5.3,
			ja = 5.266
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
				arg_125_0:Play423041032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.65

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[1336].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_3 = arg_125_1:GetWordFromCfg(423041031)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 26
				local var_128_6 = utf8.len(var_128_4)
				local var_128_7 = var_128_5 <= 0 and var_128_1 or var_128_1 * (var_128_6 / var_128_5)

				if var_128_7 > 0 and var_128_1 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041031", "story_v_out_423041.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041031", "story_v_out_423041.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_423041", "423041031", "story_v_out_423041.awb")

						arg_125_1:RecordAudio("423041031", var_128_9)
						arg_125_1:RecordAudio("423041031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_423041", "423041031", "story_v_out_423041.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_423041", "423041031", "story_v_out_423041.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_10 and arg_125_1.time_ < var_128_0 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play423041032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 423041032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play423041033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10148"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos10148 = var_132_0.localPosition
				var_132_0.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10148", 7)

				local var_132_2 = var_132_0.childCount

				for iter_132_0 = 0, var_132_2 - 1 do
					local var_132_3 = var_132_0:GetChild(iter_132_0)

					if var_132_3.name == "" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_4 then
				local var_132_5 = (arg_129_1.time_ - var_132_1) / var_132_4
				local var_132_6 = Vector3.New(0, -2000, 0)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10148, var_132_6, var_132_5)
			end

			if arg_129_1.time_ >= var_132_1 + var_132_4 and arg_129_1.time_ < var_132_1 + var_132_4 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_132_7 = manager.ui.mainCamera.transform
			local var_132_8 = 0.2

			if var_132_8 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				local var_132_9 = arg_129_1.var_.effectyanwudan1
				local var_132_10
				local var_132_11 = var_132_7

				if not var_132_9 then
					var_132_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), var_132_11)
					var_132_9.name = "yanwudan1"
					arg_129_1.var_.effectyanwudan1 = var_132_9
				else
					var_132_9.transform:SetParent(var_132_11)
				end

				var_132_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_132_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_132_12 = manager.ui.mainCamera.transform
			local var_132_13 = 1.7

			if var_132_13 < arg_129_1.time_ and arg_129_1.time_ <= var_132_13 + arg_132_0 then
				local var_132_14 = arg_129_1.var_.effectyanwudan1

				if var_132_14 then
					Object.Destroy(var_132_14)

					arg_129_1.var_.effectyanwudan1 = nil
				end
			end

			local var_132_15 = manager.ui.mainCamera.transform
			local var_132_16 = 0.1

			if var_132_16 < arg_129_1.time_ and arg_129_1.time_ <= var_132_16 + arg_132_0 then
				arg_129_1.var_.shakeOldPos = var_132_15.localPosition
			end

			local var_132_17 = 1

			if var_132_16 <= arg_129_1.time_ and arg_129_1.time_ < var_132_16 + var_132_17 then
				local var_132_18 = (arg_129_1.time_ - var_132_16) / 0.066
				local var_132_19, var_132_20 = math.modf(var_132_18)

				var_132_15.localPosition = Vector3.New(var_132_20 * 0.13, var_132_20 * 0.13, var_132_20 * 0.13) + arg_129_1.var_.shakeOldPos
			end

			if arg_129_1.time_ >= var_132_16 + var_132_17 and arg_129_1.time_ < var_132_16 + var_132_17 + arg_132_0 then
				var_132_15.localPosition = arg_129_1.var_.shakeOldPos
			end

			local var_132_21 = 0
			local var_132_22 = 1

			if var_132_21 < arg_129_1.time_ and arg_129_1.time_ <= var_132_21 + arg_132_0 then
				local var_132_23 = "play"
				local var_132_24 = "effect"

				arg_129_1:AudioAction(var_132_23, var_132_24, "se_story_144", "se_story_144_smoke", "")
			end

			local var_132_25 = arg_129_1.bgs_.I25h.transform
			local var_132_26 = 0

			if var_132_26 < arg_129_1.time_ and arg_129_1.time_ <= var_132_26 + arg_132_0 then
				arg_129_1.var_.moveOldPosI25h = var_132_25.localPosition
			end

			local var_132_27 = 0.8

			if var_132_26 <= arg_129_1.time_ and arg_129_1.time_ < var_132_26 + var_132_27 then
				local var_132_28 = (arg_129_1.time_ - var_132_26) / var_132_27
				local var_132_29 = Vector3.New(0, 1, 9)

				var_132_25.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPosI25h, var_132_29, var_132_28)
			end

			if arg_129_1.time_ >= var_132_26 + var_132_27 and arg_129_1.time_ < var_132_26 + var_132_27 + arg_132_0 then
				var_132_25.localPosition = Vector3.New(0, 1, 9)
			end

			local var_132_30 = 0

			if var_132_30 < arg_129_1.time_ and arg_129_1.time_ <= var_132_30 + arg_132_0 then
				arg_129_1.allBtn_.enabled = false
			end

			local var_132_31 = 0.8

			if arg_129_1.time_ >= var_132_30 + var_132_31 and arg_129_1.time_ < var_132_30 + var_132_31 + arg_132_0 then
				arg_129_1.allBtn_.enabled = true
			end

			local var_132_32 = 0
			local var_132_33 = 1.6

			if var_132_32 < arg_129_1.time_ and arg_129_1.time_ <= var_132_32 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				arg_129_1.dialog_:SetActive(true)

				arg_129_1.dialogCg_.alpha = 0

				local var_132_34 = LeanTween.value(arg_129_1.dialog_, 0, 1, 0.3)

				var_132_34:setOnUpdate(LuaHelper.FloatAction(function(arg_133_0)
					arg_129_1.dialogCg_.alpha = arg_133_0
				end))
				var_132_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_129_1.dialog_)
					var_132_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_129_1.duration_ = arg_129_1.duration_ + 0.3

				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_35 = arg_129_1:GetWordFromCfg(423041032)
				local var_132_36 = arg_129_1:FormatText(var_132_35.content)

				arg_129_1.text_.text = var_132_36

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_37 = 64
				local var_132_38 = utf8.len(var_132_36)
				local var_132_39 = var_132_37 <= 0 and var_132_33 or var_132_33 * (var_132_38 / var_132_37)

				if var_132_39 > 0 and var_132_33 < var_132_39 then
					arg_129_1.talkMaxDuration = var_132_39
					var_132_32 = var_132_32 + 0.3

					if var_132_39 + var_132_32 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_39 + var_132_32
					end
				end

				arg_129_1.text_.text = var_132_36
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_40 = var_132_32 + 0.3
			local var_132_41 = math.max(var_132_33, arg_129_1.talkMaxDuration)

			if var_132_40 <= arg_129_1.time_ and arg_129_1.time_ < var_132_40 + var_132_41 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_40) / var_132_41

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_40 + var_132_41 and arg_129_1.time_ < var_132_40 + var_132_41 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "I25h",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.8,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInOutCirc
				}
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play423041033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 423041033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play423041034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.1
			local var_138_1 = 1

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				local var_138_2 = "play"
				local var_138_3 = "effect"

				arg_135_1:AudioAction(var_138_2, var_138_3, "se_story_140", "se_story_140_surround", "")
			end

			local var_138_4 = manager.ui.mainCamera.transform
			local var_138_5 = 0.1

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1.var_.shakeOldPos = var_138_4.localPosition
			end

			local var_138_6 = 1

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_6 then
				local var_138_7 = (arg_135_1.time_ - var_138_5) / 0.066
				local var_138_8, var_138_9 = math.modf(var_138_7)

				var_138_4.localPosition = Vector3.New(var_138_9 * 0.13, var_138_9 * 0.13, var_138_9 * 0.13) + arg_135_1.var_.shakeOldPos
			end

			if arg_135_1.time_ >= var_138_5 + var_138_6 and arg_135_1.time_ < var_138_5 + var_138_6 + arg_138_0 then
				var_138_4.localPosition = arg_135_1.var_.shakeOldPos
			end

			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			local var_138_11 = 1.1

			if arg_135_1.time_ >= var_138_10 + var_138_11 and arg_135_1.time_ < var_138_10 + var_138_11 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			local var_138_12 = 0
			local var_138_13 = 1.5

			if var_138_12 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_14 = arg_135_1:GetWordFromCfg(423041033)
				local var_138_15 = arg_135_1:FormatText(var_138_14.content)

				arg_135_1.text_.text = var_138_15

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_16 = 60
				local var_138_17 = utf8.len(var_138_15)
				local var_138_18 = var_138_16 <= 0 and var_138_13 or var_138_13 * (var_138_17 / var_138_16)

				if var_138_18 > 0 and var_138_13 < var_138_18 then
					arg_135_1.talkMaxDuration = var_138_18

					if var_138_18 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_18 + var_138_12
					end
				end

				arg_135_1.text_.text = var_138_15
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_19 = math.max(var_138_13, arg_135_1.talkMaxDuration)

			if var_138_12 <= arg_135_1.time_ and arg_135_1.time_ < var_138_12 + var_138_19 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_12) / var_138_19

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_12 + var_138_19 and arg_135_1.time_ < var_138_12 + var_138_19 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play423041034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 423041034
		arg_139_1.duration_ = 9.17

		local var_139_0 = {
			zh = 6.2,
			ja = 9.166
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play423041035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 1

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				local var_142_2 = "play"
				local var_142_3 = "effect"

				arg_139_1:AudioAction(var_142_2, var_142_3, "se_story_141", "se_story_141_boxing_fight01", "")
			end

			local var_142_4 = 0
			local var_142_5 = 0.7

			if var_142_4 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_6 = arg_139_1:FormatText(StoryNameCfg[1336].name)

				arg_139_1.leftNameTxt_.text = var_142_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_7 = arg_139_1:GetWordFromCfg(423041034)
				local var_142_8 = arg_139_1:FormatText(var_142_7.content)

				arg_139_1.text_.text = var_142_8

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 28
				local var_142_10 = utf8.len(var_142_8)
				local var_142_11 = var_142_9 <= 0 and var_142_5 or var_142_5 * (var_142_10 / var_142_9)

				if var_142_11 > 0 and var_142_5 < var_142_11 then
					arg_139_1.talkMaxDuration = var_142_11

					if var_142_11 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_8
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041034", "story_v_out_423041.awb") ~= 0 then
					local var_142_12 = manager.audio:GetVoiceLength("story_v_out_423041", "423041034", "story_v_out_423041.awb") / 1000

					if var_142_12 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_12 + var_142_4
					end

					if var_142_7.prefab_name ~= "" and arg_139_1.actors_[var_142_7.prefab_name] ~= nil then
						local var_142_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_7.prefab_name].transform, "story_v_out_423041", "423041034", "story_v_out_423041.awb")

						arg_139_1:RecordAudio("423041034", var_142_13)
						arg_139_1:RecordAudio("423041034", var_142_13)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_423041", "423041034", "story_v_out_423041.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_423041", "423041034", "story_v_out_423041.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_14 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_14 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_14

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_14 and arg_139_1.time_ < var_142_4 + var_142_14 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play423041035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 423041035
		arg_143_1.duration_ = 6.57

		local var_143_0 = {
			zh = 5.833,
			ja = 6.566
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play423041036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.575

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[1335].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(423041035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 23
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041035", "story_v_out_423041.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041035", "story_v_out_423041.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_423041", "423041035", "story_v_out_423041.awb")

						arg_143_1:RecordAudio("423041035", var_146_9)
						arg_143_1:RecordAudio("423041035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_423041", "423041035", "story_v_out_423041.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_423041", "423041035", "story_v_out_423041.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play423041036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 423041036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play423041037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1.8

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:GetWordFromCfg(423041036)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 72
				local var_150_5 = utf8.len(var_150_3)
				local var_150_6 = var_150_4 <= 0 and var_150_1 or var_150_1 * (var_150_5 / var_150_4)

				if var_150_6 > 0 and var_150_1 < var_150_6 then
					arg_147_1.talkMaxDuration = var_150_6

					if var_150_6 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_7 and arg_147_1.time_ < var_150_0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play423041037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 423041037
		arg_151_1.duration_ = 8.3

		local var_151_0 = {
			zh = 6.433,
			ja = 8.3
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play423041038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10148"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10148 == nil then
				arg_151_1.var_.actorSpriteComps10148 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps10148 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								local var_154_4 = Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor1.r, var_154_3)
								local var_154_5 = Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor1.g, var_154_3)
								local var_154_6 = Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor1.b, var_154_3)

								iter_154_1.color = Color.New(var_154_4, var_154_5, var_154_6)
							else
								local var_154_7 = Mathf.Lerp(iter_154_1.color.r, 1, var_154_3)

								iter_154_1.color = Color.New(var_154_7, var_154_7, var_154_7)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10148 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_154_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10148 = nil
			end

			local var_154_8 = arg_151_1.actors_["10148"].transform
			local var_154_9 = 0

			if var_154_9 < arg_151_1.time_ and arg_151_1.time_ <= var_154_9 + arg_154_0 then
				arg_151_1.var_.moveOldPos10148 = var_154_8.localPosition
				var_154_8.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10148", 3)

				local var_154_10 = var_154_8.childCount

				for iter_154_4 = 0, var_154_10 - 1 do
					local var_154_11 = var_154_8:GetChild(iter_154_4)

					if var_154_11.name == "split_2" or not string.find(var_154_11.name, "split") then
						var_154_11.gameObject:SetActive(true)
					else
						var_154_11.gameObject:SetActive(false)
					end
				end
			end

			local var_154_12 = 0.001

			if var_154_9 <= arg_151_1.time_ and arg_151_1.time_ < var_154_9 + var_154_12 then
				local var_154_13 = (arg_151_1.time_ - var_154_9) / var_154_12
				local var_154_14 = Vector3.New(0, -350, -270)

				var_154_8.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10148, var_154_14, var_154_13)
			end

			if arg_151_1.time_ >= var_154_9 + var_154_12 and arg_151_1.time_ < var_154_9 + var_154_12 + arg_154_0 then
				var_154_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_154_15 = 0
			local var_154_16 = 0.675

			if var_154_15 < arg_151_1.time_ and arg_151_1.time_ <= var_154_15 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_17 = arg_151_1:FormatText(StoryNameCfg[1331].name)

				arg_151_1.leftNameTxt_.text = var_154_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_18 = arg_151_1:GetWordFromCfg(423041037)
				local var_154_19 = arg_151_1:FormatText(var_154_18.content)

				arg_151_1.text_.text = var_154_19

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_20 = 27
				local var_154_21 = utf8.len(var_154_19)
				local var_154_22 = var_154_20 <= 0 and var_154_16 or var_154_16 * (var_154_21 / var_154_20)

				if var_154_22 > 0 and var_154_16 < var_154_22 then
					arg_151_1.talkMaxDuration = var_154_22

					if var_154_22 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_22 + var_154_15
					end
				end

				arg_151_1.text_.text = var_154_19
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041037", "story_v_out_423041.awb") ~= 0 then
					local var_154_23 = manager.audio:GetVoiceLength("story_v_out_423041", "423041037", "story_v_out_423041.awb") / 1000

					if var_154_23 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_23 + var_154_15
					end

					if var_154_18.prefab_name ~= "" and arg_151_1.actors_[var_154_18.prefab_name] ~= nil then
						local var_154_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_18.prefab_name].transform, "story_v_out_423041", "423041037", "story_v_out_423041.awb")

						arg_151_1:RecordAudio("423041037", var_154_24)
						arg_151_1:RecordAudio("423041037", var_154_24)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_423041", "423041037", "story_v_out_423041.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_423041", "423041037", "story_v_out_423041.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_25 = math.max(var_154_16, arg_151_1.talkMaxDuration)

			if var_154_15 <= arg_151_1.time_ and arg_151_1.time_ < var_154_15 + var_154_25 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_15) / var_154_25

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_15 + var_154_25 and arg_151_1.time_ < var_154_15 + var_154_25 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play423041038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 423041038
		arg_155_1.duration_ = 7.77

		local var_155_0 = {
			zh = 7.766,
			ja = 5.133
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play423041039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10148"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10148 = var_158_0.localPosition
				var_158_0.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10148", 3)

				local var_158_2 = var_158_0.childCount

				for iter_158_0 = 0, var_158_2 - 1 do
					local var_158_3 = var_158_0:GetChild(iter_158_0)

					if var_158_3.name == "split_2" or not string.find(var_158_3.name, "split") then
						var_158_3.gameObject:SetActive(true)
					else
						var_158_3.gameObject:SetActive(false)
					end
				end
			end

			local var_158_4 = 1

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_4 then
				local var_158_5 = (arg_155_1.time_ - var_158_1) / var_158_4
				local var_158_6 = Vector3.New(-50, -350, -270)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10148, var_158_6, var_158_5)
			end

			if arg_155_1.time_ >= var_158_1 + var_158_4 and arg_155_1.time_ < var_158_1 + var_158_4 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(-50, -350, -270)
			end

			local var_158_7 = 0

			if var_158_7 < arg_155_1.time_ and arg_155_1.time_ <= var_158_7 + arg_158_0 then
				arg_155_1.allBtn_.enabled = false
			end

			local var_158_8 = 1

			if arg_155_1.time_ >= var_158_7 + var_158_8 and arg_155_1.time_ < var_158_7 + var_158_8 + arg_158_0 then
				arg_155_1.allBtn_.enabled = true
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_9 = 1
			local var_158_10 = 0.7

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_11 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_11:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_12 = arg_155_1:FormatText(StoryNameCfg[1335].name)

				arg_155_1.leftNameTxt_.text = var_158_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_13 = arg_155_1:GetWordFromCfg(423041038)
				local var_158_14 = arg_155_1:FormatText(var_158_13.content)

				arg_155_1.text_.text = var_158_14

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_15 = 28
				local var_158_16 = utf8.len(var_158_14)
				local var_158_17 = var_158_15 <= 0 and var_158_10 or var_158_10 * (var_158_16 / var_158_15)

				if var_158_17 > 0 and var_158_10 < var_158_17 then
					arg_155_1.talkMaxDuration = var_158_17
					var_158_9 = var_158_9 + 0.3

					if var_158_17 + var_158_9 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_17 + var_158_9
					end
				end

				arg_155_1.text_.text = var_158_14
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041038", "story_v_out_423041.awb") ~= 0 then
					local var_158_18 = manager.audio:GetVoiceLength("story_v_out_423041", "423041038", "story_v_out_423041.awb") / 1000

					if var_158_18 + var_158_9 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_18 + var_158_9
					end

					if var_158_13.prefab_name ~= "" and arg_155_1.actors_[var_158_13.prefab_name] ~= nil then
						local var_158_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_13.prefab_name].transform, "story_v_out_423041", "423041038", "story_v_out_423041.awb")

						arg_155_1:RecordAudio("423041038", var_158_19)
						arg_155_1:RecordAudio("423041038", var_158_19)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_423041", "423041038", "story_v_out_423041.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_423041", "423041038", "story_v_out_423041.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_20 = var_158_9 + 0.3
			local var_158_21 = math.max(var_158_10, arg_155_1.talkMaxDuration)

			if var_158_20 <= arg_155_1.time_ and arg_155_1.time_ < var_158_20 + var_158_21 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_20) / var_158_21

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_20 + var_158_21 and arg_155_1.time_ < var_158_20 + var_158_21 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "10148",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 0,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_OUT,
					startPos = Vector3.New(0, -350, -270),
					endPos = Vector3.New(-50, -350, -270),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play423041039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 423041039
		arg_161_1.duration_ = 4.37

		local var_161_0 = {
			zh = 4.366,
			ja = 3.666
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
				arg_161_0:Play423041040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.575

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[1335].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:GetWordFromCfg(423041039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 23
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041039", "story_v_out_423041.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041039", "story_v_out_423041.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_423041", "423041039", "story_v_out_423041.awb")

						arg_161_1:RecordAudio("423041039", var_164_9)
						arg_161_1:RecordAudio("423041039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_423041", "423041039", "story_v_out_423041.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_423041", "423041039", "story_v_out_423041.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_10 and arg_161_1.time_ < var_164_0 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play423041040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 423041040
		arg_165_1.duration_ = 9

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play423041041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = "I25g"

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
				local var_168_5 = arg_165_1.bgs_.I25g

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
					if iter_168_0 ~= "I25g" then
						iter_168_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_168_16 = 4

			if var_168_16 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 then
				arg_165_1.allBtn_.enabled = false
			end

			local var_168_17 = 0.3

			if arg_165_1.time_ >= var_168_16 + var_168_17 and arg_165_1.time_ < var_168_16 + var_168_17 + arg_168_0 then
				arg_165_1.allBtn_.enabled = true
			end

			local var_168_18 = 0

			if var_168_18 < arg_165_1.time_ and arg_165_1.time_ <= var_168_18 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_19 = 2

			if var_168_18 <= arg_165_1.time_ and arg_165_1.time_ < var_168_18 + var_168_19 then
				local var_168_20 = (arg_165_1.time_ - var_168_18) / var_168_19
				local var_168_21 = Color.New(0, 0, 0)

				var_168_21.a = Mathf.Lerp(0, 1, var_168_20)
				arg_165_1.mask_.color = var_168_21
			end

			if arg_165_1.time_ >= var_168_18 + var_168_19 and arg_165_1.time_ < var_168_18 + var_168_19 + arg_168_0 then
				local var_168_22 = Color.New(0, 0, 0)

				var_168_22.a = 1
				arg_165_1.mask_.color = var_168_22
			end

			local var_168_23 = 2

			if var_168_23 < arg_165_1.time_ and arg_165_1.time_ <= var_168_23 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_24 = 2

			if var_168_23 <= arg_165_1.time_ and arg_165_1.time_ < var_168_23 + var_168_24 then
				local var_168_25 = (arg_165_1.time_ - var_168_23) / var_168_24
				local var_168_26 = Color.New(0, 0, 0)

				var_168_26.a = Mathf.Lerp(1, 0, var_168_25)
				arg_165_1.mask_.color = var_168_26
			end

			if arg_165_1.time_ >= var_168_23 + var_168_24 and arg_165_1.time_ < var_168_23 + var_168_24 + arg_168_0 then
				local var_168_27 = Color.New(0, 0, 0)
				local var_168_28 = 0

				arg_165_1.mask_.enabled = false
				var_168_27.a = var_168_28
				arg_165_1.mask_.color = var_168_27
			end

			local var_168_29 = 0.233333333333333
			local var_168_30 = 1

			if var_168_29 < arg_165_1.time_ and arg_165_1.time_ <= var_168_29 + arg_168_0 then
				local var_168_31 = "stop"
				local var_168_32 = "effect"

				arg_165_1:AudioAction(var_168_31, var_168_32, "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			local var_168_33 = 1.63333333333333
			local var_168_34 = 1

			if var_168_33 < arg_165_1.time_ and arg_165_1.time_ <= var_168_33 + arg_168_0 then
				local var_168_35 = "play"
				local var_168_36 = "effect"

				arg_165_1:AudioAction(var_168_35, var_168_36, "se_story_144", "se_story_144_amb_town_loop", "")
			end

			local var_168_37 = 4.1
			local var_168_38 = 1

			if var_168_37 < arg_165_1.time_ and arg_165_1.time_ <= var_168_37 + arg_168_0 then
				local var_168_39 = "play"
				local var_168_40 = "effect"

				arg_165_1:AudioAction(var_168_39, var_168_40, "se_story_140", "se_story_140_footstep_run05", "")
			end

			local var_168_41 = 0.233333333333333
			local var_168_42 = 0.3

			if var_168_41 < arg_165_1.time_ and arg_165_1.time_ <= var_168_41 + arg_168_0 then
				local var_168_43 = "play"
				local var_168_44 = "music"

				arg_165_1:AudioAction(var_168_43, var_168_44, "ui_battle", "ui_battle_stopbgm", "")

				local var_168_45 = ""
				local var_168_46 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_168_47 = 1.63333333333333
			local var_168_48 = 1

			if var_168_47 < arg_165_1.time_ and arg_165_1.time_ <= var_168_47 + arg_168_0 then
				local var_168_49 = "play"
				local var_168_50 = "music"

				arg_165_1:AudioAction(var_168_49, var_168_50, "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street.awb")

				local var_168_51 = ""
				local var_168_52 = manager.audio:GetAudioName("bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street")

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

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_53 = 3.999999999999
			local var_168_54 = 1.35

			if var_168_53 < arg_165_1.time_ and arg_165_1.time_ <= var_168_53 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_55 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_55:setOnUpdate(LuaHelper.FloatAction(function(arg_171_0)
					arg_165_1.dialogCg_.alpha = arg_171_0
				end))
				var_168_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_56 = arg_165_1:GetWordFromCfg(423041040)
				local var_168_57 = arg_165_1:FormatText(var_168_56.content)

				arg_165_1.text_.text = var_168_57

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_58 = 54
				local var_168_59 = utf8.len(var_168_57)
				local var_168_60 = var_168_58 <= 0 and var_168_54 or var_168_54 * (var_168_59 / var_168_58)

				if var_168_60 > 0 and var_168_54 < var_168_60 then
					arg_165_1.talkMaxDuration = var_168_60
					var_168_53 = var_168_53 + 0.3

					if var_168_60 + var_168_53 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_60 + var_168_53
					end
				end

				arg_165_1.text_.text = var_168_57
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_61 = var_168_53 + 0.3
			local var_168_62 = math.max(var_168_54, arg_165_1.talkMaxDuration)

			if var_168_61 <= arg_165_1.time_ and arg_165_1.time_ < var_168_61 + var_168_62 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_61) / var_168_62

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_61 + var_168_62 and arg_165_1.time_ < var_168_61 + var_168_62 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play423041041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 423041041
		arg_173_1.duration_ = 4.43

		local var_173_0 = {
			zh = 3.5,
			ja = 4.433
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
				arg_173_0:Play423041042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10148"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps10148 == nil then
				arg_173_1.var_.actorSpriteComps10148 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.2

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps10148 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								local var_176_4 = Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor1.r, var_176_3)
								local var_176_5 = Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor1.g, var_176_3)
								local var_176_6 = Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor1.b, var_176_3)

								iter_176_1.color = Color.New(var_176_4, var_176_5, var_176_6)
							else
								local var_176_7 = Mathf.Lerp(iter_176_1.color.r, 1, var_176_3)

								iter_176_1.color = Color.New(var_176_7, var_176_7, var_176_7)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps10148 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_176_3 then
						if arg_173_1.isInRecall_ then
							iter_176_3.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_176_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10148 = nil
			end

			local var_176_8 = arg_173_1.actors_["10148"].transform
			local var_176_9 = 0

			if var_176_9 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 then
				arg_173_1.var_.moveOldPos10148 = var_176_8.localPosition
				var_176_8.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10148", 3)

				local var_176_10 = var_176_8.childCount

				for iter_176_4 = 0, var_176_10 - 1 do
					local var_176_11 = var_176_8:GetChild(iter_176_4)

					if var_176_11.name == "split_6" or not string.find(var_176_11.name, "split") then
						var_176_11.gameObject:SetActive(true)
					else
						var_176_11.gameObject:SetActive(false)
					end
				end
			end

			local var_176_12 = 0.001

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_12 then
				local var_176_13 = (arg_173_1.time_ - var_176_9) / var_176_12
				local var_176_14 = Vector3.New(0, -350, -270)

				var_176_8.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10148, var_176_14, var_176_13)
			end

			if arg_173_1.time_ >= var_176_9 + var_176_12 and arg_173_1.time_ < var_176_9 + var_176_12 + arg_176_0 then
				var_176_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_176_15 = arg_173_1.actors_["10148"]
			local var_176_16 = 0

			if var_176_16 < arg_173_1.time_ and arg_173_1.time_ <= var_176_16 + arg_176_0 then
				local var_176_17 = var_176_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_176_17 then
					arg_173_1.var_.alphaOldValue10148 = var_176_17.alpha
					arg_173_1.var_.characterEffect10148 = var_176_17
				end

				arg_173_1.var_.alphaOldValue10148 = 0
			end

			local var_176_18 = 0.5

			if var_176_16 <= arg_173_1.time_ and arg_173_1.time_ < var_176_16 + var_176_18 then
				local var_176_19 = (arg_173_1.time_ - var_176_16) / var_176_18
				local var_176_20 = Mathf.Lerp(arg_173_1.var_.alphaOldValue10148, 1, var_176_19)

				if arg_173_1.var_.characterEffect10148 then
					arg_173_1.var_.characterEffect10148.alpha = var_176_20
				end
			end

			if arg_173_1.time_ >= var_176_16 + var_176_18 and arg_173_1.time_ < var_176_16 + var_176_18 + arg_176_0 and arg_173_1.var_.characterEffect10148 then
				arg_173_1.var_.characterEffect10148.alpha = 1
			end

			local var_176_21 = 0
			local var_176_22 = 0.45

			if var_176_21 < arg_173_1.time_ and arg_173_1.time_ <= var_176_21 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_23 = arg_173_1:FormatText(StoryNameCfg[1331].name)

				arg_173_1.leftNameTxt_.text = var_176_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_24 = arg_173_1:GetWordFromCfg(423041041)
				local var_176_25 = arg_173_1:FormatText(var_176_24.content)

				arg_173_1.text_.text = var_176_25

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_26 = 18
				local var_176_27 = utf8.len(var_176_25)
				local var_176_28 = var_176_26 <= 0 and var_176_22 or var_176_22 * (var_176_27 / var_176_26)

				if var_176_28 > 0 and var_176_22 < var_176_28 then
					arg_173_1.talkMaxDuration = var_176_28

					if var_176_28 + var_176_21 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_28 + var_176_21
					end
				end

				arg_173_1.text_.text = var_176_25
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041041", "story_v_out_423041.awb") ~= 0 then
					local var_176_29 = manager.audio:GetVoiceLength("story_v_out_423041", "423041041", "story_v_out_423041.awb") / 1000

					if var_176_29 + var_176_21 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_29 + var_176_21
					end

					if var_176_24.prefab_name ~= "" and arg_173_1.actors_[var_176_24.prefab_name] ~= nil then
						local var_176_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_24.prefab_name].transform, "story_v_out_423041", "423041041", "story_v_out_423041.awb")

						arg_173_1:RecordAudio("423041041", var_176_30)
						arg_173_1:RecordAudio("423041041", var_176_30)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_423041", "423041041", "story_v_out_423041.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_423041", "423041041", "story_v_out_423041.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_31 = math.max(var_176_22, arg_173_1.talkMaxDuration)

			if var_176_21 <= arg_173_1.time_ and arg_173_1.time_ < var_176_21 + var_176_31 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_21) / var_176_31

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_21 + var_176_31 and arg_173_1.time_ < var_176_21 + var_176_31 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play423041042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 423041042
		arg_177_1.duration_ = 4.03

		local var_177_0 = {
			zh = 3.566,
			ja = 4.033
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
				arg_177_0:Play423041043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10148"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos10148 = var_180_0.localPosition
				var_180_0.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10148", 3)

				local var_180_2 = var_180_0.childCount

				for iter_180_0 = 0, var_180_2 - 1 do
					local var_180_3 = var_180_0:GetChild(iter_180_0)

					if var_180_3.name == "" or not string.find(var_180_3.name, "split") then
						var_180_3.gameObject:SetActive(true)
					else
						var_180_3.gameObject:SetActive(false)
					end
				end
			end

			local var_180_4 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_4 then
				local var_180_5 = (arg_177_1.time_ - var_180_1) / var_180_4
				local var_180_6 = Vector3.New(0, -350, -270)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10148, var_180_6, var_180_5)
			end

			if arg_177_1.time_ >= var_180_1 + var_180_4 and arg_177_1.time_ < var_180_1 + var_180_4 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -350, -270)
			end

			local var_180_7 = 0
			local var_180_8 = 0.5

			if var_180_7 < arg_177_1.time_ and arg_177_1.time_ <= var_180_7 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_9 = arg_177_1:FormatText(StoryNameCfg[1331].name)

				arg_177_1.leftNameTxt_.text = var_180_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_10 = arg_177_1:GetWordFromCfg(423041042)
				local var_180_11 = arg_177_1:FormatText(var_180_10.content)

				arg_177_1.text_.text = var_180_11

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_12 = 20
				local var_180_13 = utf8.len(var_180_11)
				local var_180_14 = var_180_12 <= 0 and var_180_8 or var_180_8 * (var_180_13 / var_180_12)

				if var_180_14 > 0 and var_180_8 < var_180_14 then
					arg_177_1.talkMaxDuration = var_180_14

					if var_180_14 + var_180_7 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_7
					end
				end

				arg_177_1.text_.text = var_180_11
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041042", "story_v_out_423041.awb") ~= 0 then
					local var_180_15 = manager.audio:GetVoiceLength("story_v_out_423041", "423041042", "story_v_out_423041.awb") / 1000

					if var_180_15 + var_180_7 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_15 + var_180_7
					end

					if var_180_10.prefab_name ~= "" and arg_177_1.actors_[var_180_10.prefab_name] ~= nil then
						local var_180_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_10.prefab_name].transform, "story_v_out_423041", "423041042", "story_v_out_423041.awb")

						arg_177_1:RecordAudio("423041042", var_180_16)
						arg_177_1:RecordAudio("423041042", var_180_16)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_423041", "423041042", "story_v_out_423041.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_423041", "423041042", "story_v_out_423041.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_17 = math.max(var_180_8, arg_177_1.talkMaxDuration)

			if var_180_7 <= arg_177_1.time_ and arg_177_1.time_ < var_180_7 + var_180_17 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_7) / var_180_17

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_7 + var_180_17 and arg_177_1.time_ < var_180_7 + var_180_17 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play423041043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 423041043
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play423041044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10148"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10148 == nil then
				arg_181_1.var_.actorSpriteComps10148 = var_184_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.actorSpriteComps10148 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								local var_184_4 = Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor2.r, var_184_3)
								local var_184_5 = Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor2.g, var_184_3)
								local var_184_6 = Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor2.b, var_184_3)

								iter_184_1.color = Color.New(var_184_4, var_184_5, var_184_6)
							else
								local var_184_7 = Mathf.Lerp(iter_184_1.color.r, 0.5, var_184_3)

								iter_184_1.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10148 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10148 = nil
			end

			local var_184_8 = arg_181_1.actors_["10148"].transform
			local var_184_9 = 0

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 then
				arg_181_1.var_.moveOldPos10148 = var_184_8.localPosition
				var_184_8.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10148", 7)

				local var_184_10 = var_184_8.childCount

				for iter_184_4 = 0, var_184_10 - 1 do
					local var_184_11 = var_184_8:GetChild(iter_184_4)

					if var_184_11.name == "" or not string.find(var_184_11.name, "split") then
						var_184_11.gameObject:SetActive(true)
					else
						var_184_11.gameObject:SetActive(false)
					end
				end
			end

			local var_184_12 = 0.001

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_12 then
				local var_184_13 = (arg_181_1.time_ - var_184_9) / var_184_12
				local var_184_14 = Vector3.New(0, -2000, 0)

				var_184_8.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10148, var_184_14, var_184_13)
			end

			if arg_181_1.time_ >= var_184_9 + var_184_12 and arg_181_1.time_ < var_184_9 + var_184_12 + arg_184_0 then
				var_184_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_184_15 = 0
			local var_184_16 = 1.175

			if var_184_15 < arg_181_1.time_ and arg_181_1.time_ <= var_184_15 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_17 = arg_181_1:GetWordFromCfg(423041043)
				local var_184_18 = arg_181_1:FormatText(var_184_17.content)

				arg_181_1.text_.text = var_184_18

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_19 = 47
				local var_184_20 = utf8.len(var_184_18)
				local var_184_21 = var_184_19 <= 0 and var_184_16 or var_184_16 * (var_184_20 / var_184_19)

				if var_184_21 > 0 and var_184_16 < var_184_21 then
					arg_181_1.talkMaxDuration = var_184_21

					if var_184_21 + var_184_15 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_21 + var_184_15
					end
				end

				arg_181_1.text_.text = var_184_18
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_22 = math.max(var_184_16, arg_181_1.talkMaxDuration)

			if var_184_15 <= arg_181_1.time_ and arg_181_1.time_ < var_184_15 + var_184_22 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_15) / var_184_22

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_15 + var_184_22 and arg_181_1.time_ < var_184_15 + var_184_22 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423041044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 423041044
		arg_185_1.duration_ = 4.27

		local var_185_0 = {
			zh = 4.266,
			ja = 2.866
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
				arg_185_0:Play423041045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10148"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps10148 == nil then
				arg_185_1.var_.actorSpriteComps10148 = var_188_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.actorSpriteComps10148 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps10148 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_188_3 then
						if arg_185_1.isInRecall_ then
							iter_188_3.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10148 = nil
			end

			local var_188_8 = arg_185_1.actors_["10148"].transform
			local var_188_9 = 0

			if var_188_9 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 then
				arg_185_1.var_.moveOldPos10148 = var_188_8.localPosition
				var_188_8.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10148", 3)

				local var_188_10 = var_188_8.childCount

				for iter_188_4 = 0, var_188_10 - 1 do
					local var_188_11 = var_188_8:GetChild(iter_188_4)

					if var_188_11.name == "split_3" or not string.find(var_188_11.name, "split") then
						var_188_11.gameObject:SetActive(true)
					else
						var_188_11.gameObject:SetActive(false)
					end
				end
			end

			local var_188_12 = 0.001

			if var_188_9 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_12 then
				local var_188_13 = (arg_185_1.time_ - var_188_9) / var_188_12
				local var_188_14 = Vector3.New(0, -350, -270)

				var_188_8.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10148, var_188_14, var_188_13)
			end

			if arg_185_1.time_ >= var_188_9 + var_188_12 and arg_185_1.time_ < var_188_9 + var_188_12 + arg_188_0 then
				var_188_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_188_15 = arg_185_1.bgs_.I25g.transform
			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.var_.shakeOldPosI25g = var_188_15.localPosition
			end

			local var_188_17 = 1

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / 0.066
				local var_188_19, var_188_20 = math.modf(var_188_18)

				var_188_15.localPosition = Vector3.New(var_188_20 * 0.13, var_188_20 * 0.13, var_188_20 * 0.13) + arg_185_1.var_.shakeOldPosI25g
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 then
				var_188_15.localPosition = arg_185_1.var_.shakeOldPosI25g
			end

			local var_188_21 = 0

			if var_188_21 < arg_185_1.time_ and arg_185_1.time_ <= var_188_21 + arg_188_0 then
				arg_185_1.allBtn_.enabled = false
			end

			local var_188_22 = 1

			if arg_185_1.time_ >= var_188_21 + var_188_22 and arg_185_1.time_ < var_188_21 + var_188_22 + arg_188_0 then
				arg_185_1.allBtn_.enabled = true
			end

			local var_188_23 = arg_185_1.actors_["10148"].transform
			local var_188_24 = 0

			if var_188_24 < arg_185_1.time_ and arg_185_1.time_ <= var_188_24 + arg_188_0 then
				arg_185_1.var_.moveOldPos10148 = var_188_23.localPosition
				var_188_23.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10148", 3)

				local var_188_25 = var_188_23.childCount

				for iter_188_5 = 0, var_188_25 - 1 do
					local var_188_26 = var_188_23:GetChild(iter_188_5)

					if var_188_26.name == "split_3" or not string.find(var_188_26.name, "split") then
						var_188_26.gameObject:SetActive(true)
					else
						var_188_26.gameObject:SetActive(false)
					end
				end
			end

			local var_188_27 = 0.5

			if var_188_24 <= arg_185_1.time_ and arg_185_1.time_ < var_188_24 + var_188_27 then
				local var_188_28 = (arg_185_1.time_ - var_188_24) / var_188_27
				local var_188_29 = Vector3.New(-2000, -350, -270)

				var_188_23.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10148, var_188_29, var_188_28)
			end

			if arg_185_1.time_ >= var_188_24 + var_188_27 and arg_185_1.time_ < var_188_24 + var_188_27 + arg_188_0 then
				var_188_23.localPosition = Vector3.New(-2000, -350, -270)
			end

			local var_188_30 = 0
			local var_188_31 = 0.4

			if var_188_30 < arg_185_1.time_ and arg_185_1.time_ <= var_188_30 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_32 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_32:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_33 = arg_185_1:FormatText(StoryNameCfg[1331].name)

				arg_185_1.leftNameTxt_.text = var_188_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_34 = arg_185_1:GetWordFromCfg(423041044)
				local var_188_35 = arg_185_1:FormatText(var_188_34.content)

				arg_185_1.text_.text = var_188_35

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_36 = 16
				local var_188_37 = utf8.len(var_188_35)
				local var_188_38 = var_188_36 <= 0 and var_188_31 or var_188_31 * (var_188_37 / var_188_36)

				if var_188_38 > 0 and var_188_31 < var_188_38 then
					arg_185_1.talkMaxDuration = var_188_38
					var_188_30 = var_188_30 + 0.3

					if var_188_38 + var_188_30 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_38 + var_188_30
					end
				end

				arg_185_1.text_.text = var_188_35
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041044", "story_v_out_423041.awb") ~= 0 then
					local var_188_39 = manager.audio:GetVoiceLength("story_v_out_423041", "423041044", "story_v_out_423041.awb") / 1000

					if var_188_39 + var_188_30 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_39 + var_188_30
					end

					if var_188_34.prefab_name ~= "" and arg_185_1.actors_[var_188_34.prefab_name] ~= nil then
						local var_188_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_34.prefab_name].transform, "story_v_out_423041", "423041044", "story_v_out_423041.awb")

						arg_185_1:RecordAudio("423041044", var_188_40)
						arg_185_1:RecordAudio("423041044", var_188_40)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_423041", "423041044", "story_v_out_423041.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_423041", "423041044", "story_v_out_423041.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_41 = var_188_30 + 0.3
			local var_188_42 = math.max(var_188_31, arg_185_1.talkMaxDuration)

			if var_188_41 <= arg_185_1.time_ and arg_185_1.time_ < var_188_41 + var_188_42 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_41) / var_188_42

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_41 + var_188_42 and arg_185_1.time_ < var_188_41 + var_188_42 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "10148",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.5,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_OUT,
					startPos = Vector3.New(1500, -350, -270),
					endPos = Vector3.New(-2000, -350, -270),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play423041045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 423041045
		arg_191_1.duration_ = 6.1

		local var_191_0 = {
			zh = 5.666,
			ja = 6.1
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play423041046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10148"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos10148 = var_194_0.localPosition
				var_194_0.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10148", 7)

				local var_194_2 = var_194_0.childCount

				for iter_194_0 = 0, var_194_2 - 1 do
					local var_194_3 = var_194_0:GetChild(iter_194_0)

					if var_194_3.name == "" or not string.find(var_194_3.name, "split") then
						var_194_3.gameObject:SetActive(true)
					else
						var_194_3.gameObject:SetActive(false)
					end
				end
			end

			local var_194_4 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_4 then
				local var_194_5 = (arg_191_1.time_ - var_194_1) / var_194_4
				local var_194_6 = Vector3.New(0, -2000, 0)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10148, var_194_6, var_194_5)
			end

			if arg_191_1.time_ >= var_194_1 + var_194_4 and arg_191_1.time_ < var_194_1 + var_194_4 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_194_7 = 0
			local var_194_8 = 0.45

			if var_194_7 < arg_191_1.time_ and arg_191_1.time_ <= var_194_7 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_9 = arg_191_1:FormatText(StoryNameCfg[1335].name)

				arg_191_1.leftNameTxt_.text = var_194_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_10 = arg_191_1:GetWordFromCfg(423041045)
				local var_194_11 = arg_191_1:FormatText(var_194_10.content)

				arg_191_1.text_.text = var_194_11

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_12 = 18
				local var_194_13 = utf8.len(var_194_11)
				local var_194_14 = var_194_12 <= 0 and var_194_8 or var_194_8 * (var_194_13 / var_194_12)

				if var_194_14 > 0 and var_194_8 < var_194_14 then
					arg_191_1.talkMaxDuration = var_194_14

					if var_194_14 + var_194_7 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_7
					end
				end

				arg_191_1.text_.text = var_194_11
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041045", "story_v_out_423041.awb") ~= 0 then
					local var_194_15 = manager.audio:GetVoiceLength("story_v_out_423041", "423041045", "story_v_out_423041.awb") / 1000

					if var_194_15 + var_194_7 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_15 + var_194_7
					end

					if var_194_10.prefab_name ~= "" and arg_191_1.actors_[var_194_10.prefab_name] ~= nil then
						local var_194_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_10.prefab_name].transform, "story_v_out_423041", "423041045", "story_v_out_423041.awb")

						arg_191_1:RecordAudio("423041045", var_194_16)
						arg_191_1:RecordAudio("423041045", var_194_16)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_423041", "423041045", "story_v_out_423041.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_423041", "423041045", "story_v_out_423041.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_17 = math.max(var_194_8, arg_191_1.talkMaxDuration)

			if var_194_7 <= arg_191_1.time_ and arg_191_1.time_ < var_194_7 + var_194_17 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_7) / var_194_17

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_7 + var_194_17 and arg_191_1.time_ < var_194_7 + var_194_17 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play423041046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 423041046
		arg_195_1.duration_ = 2.97

		local var_195_0 = {
			zh = 2.966,
			ja = 2.466
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play423041047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10148"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos10148 = var_198_0.localPosition
				var_198_0.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10148", 3)

				local var_198_2 = var_198_0.childCount

				for iter_198_0 = 0, var_198_2 - 1 do
					local var_198_3 = var_198_0:GetChild(iter_198_0)

					if var_198_3.name == "split_4" or not string.find(var_198_3.name, "split") then
						var_198_3.gameObject:SetActive(true)
					else
						var_198_3.gameObject:SetActive(false)
					end
				end
			end

			local var_198_4 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_4 then
				local var_198_5 = (arg_195_1.time_ - var_198_1) / var_198_4
				local var_198_6 = Vector3.New(0, -350, -270)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10148, var_198_6, var_198_5)
			end

			if arg_195_1.time_ >= var_198_1 + var_198_4 and arg_195_1.time_ < var_198_1 + var_198_4 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, -350, -270)
			end

			local var_198_7 = arg_195_1.actors_["10148"]
			local var_198_8 = 0

			if var_198_8 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 then
				local var_198_9 = var_198_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_198_9 then
					arg_195_1.var_.alphaOldValue10148 = var_198_9.alpha
					arg_195_1.var_.characterEffect10148 = var_198_9
				end

				arg_195_1.var_.alphaOldValue10148 = 0
			end

			local var_198_10 = 0.5

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_10 then
				local var_198_11 = (arg_195_1.time_ - var_198_8) / var_198_10
				local var_198_12 = Mathf.Lerp(arg_195_1.var_.alphaOldValue10148, 1, var_198_11)

				if arg_195_1.var_.characterEffect10148 then
					arg_195_1.var_.characterEffect10148.alpha = var_198_12
				end
			end

			if arg_195_1.time_ >= var_198_8 + var_198_10 and arg_195_1.time_ < var_198_8 + var_198_10 + arg_198_0 and arg_195_1.var_.characterEffect10148 then
				arg_195_1.var_.characterEffect10148.alpha = 1
			end

			local var_198_13 = 0
			local var_198_14 = 0.325

			if var_198_13 < arg_195_1.time_ and arg_195_1.time_ <= var_198_13 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_15 = arg_195_1:FormatText(StoryNameCfg[1331].name)

				arg_195_1.leftNameTxt_.text = var_198_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_16 = arg_195_1:GetWordFromCfg(423041046)
				local var_198_17 = arg_195_1:FormatText(var_198_16.content)

				arg_195_1.text_.text = var_198_17

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_18 = 13
				local var_198_19 = utf8.len(var_198_17)
				local var_198_20 = var_198_18 <= 0 and var_198_14 or var_198_14 * (var_198_19 / var_198_18)

				if var_198_20 > 0 and var_198_14 < var_198_20 then
					arg_195_1.talkMaxDuration = var_198_20

					if var_198_20 + var_198_13 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_20 + var_198_13
					end
				end

				arg_195_1.text_.text = var_198_17
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041046", "story_v_out_423041.awb") ~= 0 then
					local var_198_21 = manager.audio:GetVoiceLength("story_v_out_423041", "423041046", "story_v_out_423041.awb") / 1000

					if var_198_21 + var_198_13 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_21 + var_198_13
					end

					if var_198_16.prefab_name ~= "" and arg_195_1.actors_[var_198_16.prefab_name] ~= nil then
						local var_198_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_16.prefab_name].transform, "story_v_out_423041", "423041046", "story_v_out_423041.awb")

						arg_195_1:RecordAudio("423041046", var_198_22)
						arg_195_1:RecordAudio("423041046", var_198_22)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_423041", "423041046", "story_v_out_423041.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_423041", "423041046", "story_v_out_423041.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_23 = math.max(var_198_14, arg_195_1.talkMaxDuration)

			if var_198_13 <= arg_195_1.time_ and arg_195_1.time_ < var_198_13 + var_198_23 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_13) / var_198_23

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_13 + var_198_23 and arg_195_1.time_ < var_198_13 + var_198_23 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play423041047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 423041047
		arg_199_1.duration_ = 6.5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play423041048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = "STblack"

			if arg_199_1.bgs_[var_202_0] == nil then
				local var_202_1 = Object.Instantiate(arg_199_1.paintGo_)

				var_202_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_202_0)
				var_202_1.name = var_202_0
				var_202_1.transform.parent = arg_199_1.stage_.transform
				var_202_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.bgs_[var_202_0] = var_202_1
			end

			local var_202_2 = 0.5

			if var_202_2 < arg_199_1.time_ and arg_199_1.time_ <= var_202_2 + arg_202_0 then
				local var_202_3 = manager.ui.mainCamera.transform.localPosition
				local var_202_4 = Vector3.New(0, 0, 10) + Vector3.New(var_202_3.x, var_202_3.y, 0)
				local var_202_5 = arg_199_1.bgs_.STblack

				var_202_5.transform.localPosition = var_202_4
				var_202_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_202_6 = var_202_5:GetComponent("SpriteRenderer")

				if var_202_6 and var_202_6.sprite then
					local var_202_7 = (var_202_5.transform.localPosition - var_202_3).z
					local var_202_8 = manager.ui.mainCameraCom_
					local var_202_9 = 2 * var_202_7 * Mathf.Tan(var_202_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_202_10 = var_202_9 * var_202_8.aspect
					local var_202_11 = var_202_6.sprite.bounds.size.x
					local var_202_12 = var_202_6.sprite.bounds.size.y
					local var_202_13 = var_202_10 / var_202_11
					local var_202_14 = var_202_9 / var_202_12
					local var_202_15 = var_202_14 < var_202_13 and var_202_13 or var_202_14

					var_202_5.transform.localScale = Vector3.New(var_202_15, var_202_15, 0)
				end

				for iter_202_0, iter_202_1 in pairs(arg_199_1.bgs_) do
					if iter_202_0 ~= "STblack" then
						iter_202_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_202_16 = 1.5

			if var_202_16 < arg_199_1.time_ and arg_199_1.time_ <= var_202_16 + arg_202_0 then
				arg_199_1.allBtn_.enabled = false
			end

			local var_202_17 = 0.6

			if arg_199_1.time_ >= var_202_16 + var_202_17 and arg_199_1.time_ < var_202_16 + var_202_17 + arg_202_0 then
				arg_199_1.allBtn_.enabled = true
			end

			local var_202_18 = 0

			if var_202_18 < arg_199_1.time_ and arg_199_1.time_ <= var_202_18 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_19 = 0.5

			if var_202_18 <= arg_199_1.time_ and arg_199_1.time_ < var_202_18 + var_202_19 then
				local var_202_20 = (arg_199_1.time_ - var_202_18) / var_202_19
				local var_202_21 = Color.New(0, 0, 0)

				var_202_21.a = Mathf.Lerp(0, 1, var_202_20)
				arg_199_1.mask_.color = var_202_21
			end

			if arg_199_1.time_ >= var_202_18 + var_202_19 and arg_199_1.time_ < var_202_18 + var_202_19 + arg_202_0 then
				local var_202_22 = Color.New(0, 0, 0)

				var_202_22.a = 1
				arg_199_1.mask_.color = var_202_22
			end

			local var_202_23 = 0.5

			if var_202_23 < arg_199_1.time_ and arg_199_1.time_ <= var_202_23 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_24 = 1

			if var_202_23 <= arg_199_1.time_ and arg_199_1.time_ < var_202_23 + var_202_24 then
				local var_202_25 = (arg_199_1.time_ - var_202_23) / var_202_24
				local var_202_26 = Color.New(1, 1, 1)

				var_202_26.a = Mathf.Lerp(1, 0, var_202_25)
				arg_199_1.mask_.color = var_202_26
			end

			if arg_199_1.time_ >= var_202_23 + var_202_24 and arg_199_1.time_ < var_202_23 + var_202_24 + arg_202_0 then
				local var_202_27 = Color.New(1, 1, 1)
				local var_202_28 = 0

				arg_199_1.mask_.enabled = false
				var_202_27.a = var_202_28
				arg_199_1.mask_.color = var_202_27
			end

			local var_202_29 = arg_199_1.actors_["10148"]
			local var_202_30 = 0.5

			if var_202_30 < arg_199_1.time_ and arg_199_1.time_ <= var_202_30 + arg_202_0 and not isNil(var_202_29) and arg_199_1.var_.actorSpriteComps10148 == nil then
				arg_199_1.var_.actorSpriteComps10148 = var_202_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_31 = 0.034

			if var_202_30 <= arg_199_1.time_ and arg_199_1.time_ < var_202_30 + var_202_31 and not isNil(var_202_29) then
				local var_202_32 = (arg_199_1.time_ - var_202_30) / var_202_31

				if arg_199_1.var_.actorSpriteComps10148 then
					for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_202_3 then
							if arg_199_1.isInRecall_ then
								local var_202_33 = Mathf.Lerp(iter_202_3.color.r, arg_199_1.hightColor2.r, var_202_32)
								local var_202_34 = Mathf.Lerp(iter_202_3.color.g, arg_199_1.hightColor2.g, var_202_32)
								local var_202_35 = Mathf.Lerp(iter_202_3.color.b, arg_199_1.hightColor2.b, var_202_32)

								iter_202_3.color = Color.New(var_202_33, var_202_34, var_202_35)
							else
								local var_202_36 = Mathf.Lerp(iter_202_3.color.r, 0.5, var_202_32)

								iter_202_3.color = Color.New(var_202_36, var_202_36, var_202_36)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_30 + var_202_31 and arg_199_1.time_ < var_202_30 + var_202_31 + arg_202_0 and not isNil(var_202_29) and arg_199_1.var_.actorSpriteComps10148 then
				for iter_202_4, iter_202_5 in pairs(arg_199_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_202_5 then
						if arg_199_1.isInRecall_ then
							iter_202_5.color = arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_202_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps10148 = nil
			end

			local var_202_37 = arg_199_1.actors_["10148"].transform
			local var_202_38 = 0.5

			if var_202_38 < arg_199_1.time_ and arg_199_1.time_ <= var_202_38 + arg_202_0 then
				arg_199_1.var_.moveOldPos10148 = var_202_37.localPosition
				var_202_37.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10148", 7)

				local var_202_39 = var_202_37.childCount

				for iter_202_6 = 0, var_202_39 - 1 do
					local var_202_40 = var_202_37:GetChild(iter_202_6)

					if var_202_40.name == "" or not string.find(var_202_40.name, "split") then
						var_202_40.gameObject:SetActive(true)
					else
						var_202_40.gameObject:SetActive(false)
					end
				end
			end

			local var_202_41 = 0.001

			if var_202_38 <= arg_199_1.time_ and arg_199_1.time_ < var_202_38 + var_202_41 then
				local var_202_42 = (arg_199_1.time_ - var_202_38) / var_202_41
				local var_202_43 = Vector3.New(0, -2000, 0)

				var_202_37.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10148, var_202_43, var_202_42)
			end

			if arg_199_1.time_ >= var_202_38 + var_202_41 and arg_199_1.time_ < var_202_38 + var_202_41 + arg_202_0 then
				var_202_37.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_199_1.frameCnt_ <= 1 then
				arg_199_1.dialog_:SetActive(false)
			end

			local var_202_44 = 1.5
			local var_202_45 = 1.775

			if var_202_44 < arg_199_1.time_ and arg_199_1.time_ <= var_202_44 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				arg_199_1.dialog_:SetActive(true)

				arg_199_1.dialogCg_.alpha = 0

				local var_202_46 = LeanTween.value(arg_199_1.dialog_, 0, 1, 0.3)

				var_202_46:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_199_1.dialogCg_.alpha = arg_203_0
				end))
				var_202_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_199_1.dialog_)
					var_202_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_199_1.duration_ = arg_199_1.duration_ + 0.3

				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_47 = arg_199_1:GetWordFromCfg(423041047)
				local var_202_48 = arg_199_1:FormatText(var_202_47.content)

				arg_199_1.text_.text = var_202_48

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_49 = 71
				local var_202_50 = utf8.len(var_202_48)
				local var_202_51 = var_202_49 <= 0 and var_202_45 or var_202_45 * (var_202_50 / var_202_49)

				if var_202_51 > 0 and var_202_45 < var_202_51 then
					arg_199_1.talkMaxDuration = var_202_51
					var_202_44 = var_202_44 + 0.3

					if var_202_51 + var_202_44 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_51 + var_202_44
					end
				end

				arg_199_1.text_.text = var_202_48
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_52 = var_202_44 + 0.3
			local var_202_53 = math.max(var_202_45, arg_199_1.talkMaxDuration)

			if var_202_52 <= arg_199_1.time_ and arg_199_1.time_ < var_202_52 + var_202_53 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_52) / var_202_53

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_52 + var_202_53 and arg_199_1.time_ < var_202_52 + var_202_53 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play423041048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 423041048
		arg_205_1.duration_ = 5.27

		local var_205_0 = {
			zh = 3.766,
			ja = 5.266
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
				arg_205_0:Play423041049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 1

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				local var_208_2 = "play"
				local var_208_3 = "effect"

				arg_205_1:AudioAction(var_208_2, var_208_3, "se_story_144", "se_story_144_whip", "")
			end

			local var_208_4 = 0
			local var_208_5 = 0.4

			if var_208_4 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_6 = arg_205_1:FormatText(StoryNameCfg[1335].name)

				arg_205_1.leftNameTxt_.text = var_208_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_7 = arg_205_1:GetWordFromCfg(423041048)
				local var_208_8 = arg_205_1:FormatText(var_208_7.content)

				arg_205_1.text_.text = var_208_8

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 16
				local var_208_10 = utf8.len(var_208_8)
				local var_208_11 = var_208_9 <= 0 and var_208_5 or var_208_5 * (var_208_10 / var_208_9)

				if var_208_11 > 0 and var_208_5 < var_208_11 then
					arg_205_1.talkMaxDuration = var_208_11

					if var_208_11 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_11 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_8
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041048", "story_v_out_423041.awb") ~= 0 then
					local var_208_12 = manager.audio:GetVoiceLength("story_v_out_423041", "423041048", "story_v_out_423041.awb") / 1000

					if var_208_12 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_12 + var_208_4
					end

					if var_208_7.prefab_name ~= "" and arg_205_1.actors_[var_208_7.prefab_name] ~= nil then
						local var_208_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_7.prefab_name].transform, "story_v_out_423041", "423041048", "story_v_out_423041.awb")

						arg_205_1:RecordAudio("423041048", var_208_13)
						arg_205_1:RecordAudio("423041048", var_208_13)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_423041", "423041048", "story_v_out_423041.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_423041", "423041048", "story_v_out_423041.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_14 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_14 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_14

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_14 and arg_205_1.time_ < var_208_4 + var_208_14 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play423041049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 423041049
		arg_209_1.duration_ = 5.55

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play423041050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = "SS2302"

			if arg_209_1.bgs_[var_212_0] == nil then
				local var_212_1 = Object.Instantiate(arg_209_1.paintGo_)

				var_212_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_212_0)
				var_212_1.name = var_212_0
				var_212_1.transform.parent = arg_209_1.stage_.transform
				var_212_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.bgs_[var_212_0] = var_212_1
			end

			local var_212_2 = 1.00008890058234e-12

			if var_212_2 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				local var_212_3 = manager.ui.mainCamera.transform.localPosition
				local var_212_4 = Vector3.New(0, 0, 10) + Vector3.New(var_212_3.x, var_212_3.y, 0)
				local var_212_5 = arg_209_1.bgs_.SS2302

				var_212_5.transform.localPosition = var_212_4
				var_212_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_6 = var_212_5:GetComponent("SpriteRenderer")

				if var_212_6 and var_212_6.sprite then
					local var_212_7 = (var_212_5.transform.localPosition - var_212_3).z
					local var_212_8 = manager.ui.mainCameraCom_
					local var_212_9 = 2 * var_212_7 * Mathf.Tan(var_212_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_212_10 = var_212_9 * var_212_8.aspect
					local var_212_11 = var_212_6.sprite.bounds.size.x
					local var_212_12 = var_212_6.sprite.bounds.size.y
					local var_212_13 = var_212_10 / var_212_11
					local var_212_14 = var_212_9 / var_212_12
					local var_212_15 = var_212_14 < var_212_13 and var_212_13 or var_212_14

					var_212_5.transform.localScale = Vector3.New(var_212_15, var_212_15, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "SS2302" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_17 = 1

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_17 then
				local var_212_18 = (arg_209_1.time_ - var_212_16) / var_212_17
				local var_212_19 = Color.New(0, 0, 0)

				var_212_19.a = Mathf.Lerp(1, 0, var_212_18)
				arg_209_1.mask_.color = var_212_19
			end

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 then
				local var_212_20 = Color.New(0, 0, 0)
				local var_212_21 = 0

				arg_209_1.mask_.enabled = false
				var_212_20.a = var_212_21
				arg_209_1.mask_.color = var_212_20
			end

			local var_212_22 = manager.ui.mainCamera.transform
			local var_212_23 = 0

			if var_212_23 < arg_209_1.time_ and arg_209_1.time_ <= var_212_23 + arg_212_0 then
				local var_212_24 = arg_209_1.var_.effectlasibianzi1
				local var_212_25
				local var_212_26 = var_212_22

				if not var_212_24 then
					var_212_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), var_212_26)
					var_212_24.name = "lasibianzi1"
					arg_209_1.var_.effectlasibianzi1 = var_212_24
				else
					var_212_24.transform:SetParent(var_212_26)
				end

				var_212_24.transform.localPosition = Vector3.New(0, 0, 0)
				var_212_24.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_212_27 = arg_209_1.bgs_.SS2302.transform
			local var_212_28 = 0

			if var_212_28 < arg_209_1.time_ and arg_209_1.time_ <= var_212_28 + arg_212_0 then
				arg_209_1.var_.moveOldPosSS2302 = var_212_27.localPosition
			end

			local var_212_29 = 3.5

			if var_212_28 <= arg_209_1.time_ and arg_209_1.time_ < var_212_28 + var_212_29 then
				local var_212_30 = (arg_209_1.time_ - var_212_28) / var_212_29
				local var_212_31 = Vector3.New(0, 0.2, 2)

				var_212_27.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPosSS2302, var_212_31, var_212_30)
			end

			if arg_209_1.time_ >= var_212_28 + var_212_29 and arg_209_1.time_ < var_212_28 + var_212_29 + arg_212_0 then
				var_212_27.localPosition = Vector3.New(0, 0.2, 2)
			end

			local var_212_32 = 0

			if var_212_32 < arg_209_1.time_ and arg_209_1.time_ <= var_212_32 + arg_212_0 then
				arg_209_1.allBtn_.enabled = false
			end

			local var_212_33 = 1

			if arg_209_1.time_ >= var_212_32 + var_212_33 and arg_209_1.time_ < var_212_32 + var_212_33 + arg_212_0 then
				arg_209_1.allBtn_.enabled = true
			end

			local var_212_34 = 0
			local var_212_35 = 1

			if var_212_34 < arg_209_1.time_ and arg_209_1.time_ <= var_212_34 + arg_212_0 then
				local var_212_36 = "play"
				local var_212_37 = "effect"

				arg_209_1:AudioAction(var_212_36, var_212_37, "se_story_1311", "se_story_1311_sword", "")
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_38 = 0.550000000001002
			local var_212_39 = 1.45

			if var_212_38 < arg_209_1.time_ and arg_209_1.time_ <= var_212_38 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_40 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_40:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_41 = arg_209_1:GetWordFromCfg(423041049)
				local var_212_42 = arg_209_1:FormatText(var_212_41.content)

				arg_209_1.text_.text = var_212_42

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_43 = 58
				local var_212_44 = utf8.len(var_212_42)
				local var_212_45 = var_212_43 <= 0 and var_212_39 or var_212_39 * (var_212_44 / var_212_43)

				if var_212_45 > 0 and var_212_39 < var_212_45 then
					arg_209_1.talkMaxDuration = var_212_45
					var_212_38 = var_212_38 + 0.3

					if var_212_45 + var_212_38 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_45 + var_212_38
					end
				end

				arg_209_1.text_.text = var_212_42
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_46 = var_212_38 + 0.3
			local var_212_47 = math.max(var_212_39, arg_209_1.talkMaxDuration)

			if var_212_46 <= arg_209_1.time_ and arg_209_1.time_ < var_212_46 + var_212_47 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_46) / var_212_47

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_46 + var_212_47 and arg_209_1.time_ < var_212_46 + var_212_47 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2302",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.5,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0, 2),
					endPos = Vector3.New(0, 0.2, 2),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play423041050 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 423041050
		arg_215_1.duration_ = 7.33

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play423041051(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1.3

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				local var_218_1 = manager.ui.mainCamera.transform.localPosition
				local var_218_2 = Vector3.New(0, 0, 10) + Vector3.New(var_218_1.x, var_218_1.y, 0)
				local var_218_3 = arg_215_1.bgs_.SS2302

				var_218_3.transform.localPosition = var_218_2
				var_218_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_4 = var_218_3:GetComponent("SpriteRenderer")

				if var_218_4 and var_218_4.sprite then
					local var_218_5 = (var_218_3.transform.localPosition - var_218_1).z
					local var_218_6 = manager.ui.mainCameraCom_
					local var_218_7 = 2 * var_218_5 * Mathf.Tan(var_218_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_218_8 = var_218_7 * var_218_6.aspect
					local var_218_9 = var_218_4.sprite.bounds.size.x
					local var_218_10 = var_218_4.sprite.bounds.size.y
					local var_218_11 = var_218_8 / var_218_9
					local var_218_12 = var_218_7 / var_218_10
					local var_218_13 = var_218_12 < var_218_11 and var_218_11 or var_218_12

					var_218_3.transform.localScale = Vector3.New(var_218_13, var_218_13, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "SS2302" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_14 = manager.ui.mainCamera.transform
			local var_218_15 = 0

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				local var_218_16 = arg_215_1.var_.effectlagejiaoyang1
				local var_218_17
				local var_218_18 = var_218_14

				if not var_218_16 then
					var_218_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), var_218_18)
					var_218_16.name = "lagejiaoyang1"
					arg_215_1.var_.effectlagejiaoyang1 = var_218_16
				else
					var_218_16.transform:SetParent(var_218_18)
				end

				var_218_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_218_16.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_218_19 = manager.ui.mainCameraCom_
				local var_218_20 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_218_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_218_21 = var_218_16.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_218_22 = 15
				local var_218_23 = 2 * var_218_22 * Mathf.Tan(var_218_19.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_218_19.aspect
				local var_218_24 = 1
				local var_218_25 = 1.7777777777777777

				if var_218_25 < var_218_19.aspect then
					var_218_24 = var_218_23 / (2 * var_218_22 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_218_25)
				end

				for iter_218_2, iter_218_3 in ipairs(var_218_21) do
					local var_218_26 = iter_218_3.transform.localScale

					iter_218_3.transform.localScale = Vector3.New(var_218_26.x / var_218_20 * var_218_24, var_218_26.y / var_218_20, var_218_26.z)
				end
			end

			local var_218_27 = manager.ui.mainCamera.transform
			local var_218_28 = 1.3

			if var_218_28 < arg_215_1.time_ and arg_215_1.time_ <= var_218_28 + arg_218_0 then
				local var_218_29 = arg_215_1.var_.effectlagejiaoyang2
				local var_218_30
				local var_218_31 = var_218_27

				if not var_218_29 then
					var_218_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), var_218_31)
					var_218_29.name = "lagejiaoyang2"
					arg_215_1.var_.effectlagejiaoyang2 = var_218_29
				else
					var_218_29.transform:SetParent(var_218_31)
				end

				var_218_29.transform.localPosition = Vector3.New(0, 0, 0)
				var_218_29.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_218_32 = manager.ui.mainCameraCom_
				local var_218_33 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_218_32.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_218_34 = var_218_29.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_218_35 = 15
				local var_218_36 = 2 * var_218_35 * Mathf.Tan(var_218_32.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_218_32.aspect
				local var_218_37 = 1
				local var_218_38 = 1.7777777777777777

				if var_218_38 < var_218_32.aspect then
					var_218_37 = var_218_36 / (2 * var_218_35 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_218_38)
				end

				for iter_218_4, iter_218_5 in ipairs(var_218_34) do
					local var_218_39 = iter_218_5.transform.localScale

					iter_218_5.transform.localScale = Vector3.New(var_218_39.x / var_218_33 * var_218_37, var_218_39.y / var_218_33, var_218_39.z)
				end
			end

			local var_218_40 = manager.ui.mainCamera.transform
			local var_218_41 = 1.3

			if var_218_41 < arg_215_1.time_ and arg_215_1.time_ <= var_218_41 + arg_218_0 then
				local var_218_42 = arg_215_1.var_.effectlagejiaoyang1

				if var_218_42 then
					Object.Destroy(var_218_42)

					arg_215_1.var_.effectlagejiaoyang1 = nil
				end
			end

			local var_218_43 = arg_215_1.bgs_.SS2302.transform
			local var_218_44 = 1.3

			if var_218_44 < arg_215_1.time_ and arg_215_1.time_ <= var_218_44 + arg_218_0 then
				arg_215_1.var_.moveOldPosSS2302 = var_218_43.localPosition
			end

			local var_218_45 = 3.5

			if var_218_44 <= arg_215_1.time_ and arg_215_1.time_ < var_218_44 + var_218_45 then
				local var_218_46 = (arg_215_1.time_ - var_218_44) / var_218_45
				local var_218_47 = Vector3.New(0, 1, 10)

				var_218_43.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPosSS2302, var_218_47, var_218_46)
			end

			if arg_215_1.time_ >= var_218_44 + var_218_45 and arg_215_1.time_ < var_218_44 + var_218_45 + arg_218_0 then
				var_218_43.localPosition = Vector3.New(0, 1, 10)
			end

			local var_218_48 = 0

			if var_218_48 < arg_215_1.time_ and arg_215_1.time_ <= var_218_48 + arg_218_0 then
				arg_215_1.allBtn_.enabled = false
			end

			local var_218_49 = 2.33333333333333

			if arg_215_1.time_ >= var_218_48 + var_218_49 and arg_215_1.time_ < var_218_48 + var_218_49 + arg_218_0 then
				arg_215_1.allBtn_.enabled = true
			end

			local var_218_50 = 1.28333333333333
			local var_218_51 = 1

			if var_218_50 < arg_215_1.time_ and arg_215_1.time_ <= var_218_50 + arg_218_0 then
				local var_218_52 = "play"
				local var_218_53 = "effect"

				arg_215_1:AudioAction(var_218_52, var_218_53, "se_story_1310", "se_story_1310_rush", "")
			end

			local var_218_54 = 2.33333333333333
			local var_218_55 = 1.75

			if var_218_54 < arg_215_1.time_ and arg_215_1.time_ <= var_218_54 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_56 = arg_215_1:GetWordFromCfg(423041050)
				local var_218_57 = arg_215_1:FormatText(var_218_56.content)

				arg_215_1.text_.text = var_218_57

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_58 = 70
				local var_218_59 = utf8.len(var_218_57)
				local var_218_60 = var_218_58 <= 0 and var_218_55 or var_218_55 * (var_218_59 / var_218_58)

				if var_218_60 > 0 and var_218_55 < var_218_60 then
					arg_215_1.talkMaxDuration = var_218_60

					if var_218_60 + var_218_54 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_60 + var_218_54
					end
				end

				arg_215_1.text_.text = var_218_57
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_61 = math.max(var_218_55, arg_215_1.talkMaxDuration)

			if var_218_54 <= arg_215_1.time_ and arg_215_1.time_ < var_218_54 + var_218_61 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_54) / var_218_61

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_54 + var_218_61 and arg_215_1.time_ < var_218_54 + var_218_61 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2302",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.5,
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 6),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeOutExpo
				}
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play423041051 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 423041051
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play423041052(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.2
			local var_222_1 = 1

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				local var_222_2 = "play"
				local var_222_3 = "effect"

				arg_219_1:AudioAction(var_222_2, var_222_3, "se_story_side_1050", "se_story_side_1050_fall", "")
			end

			local var_222_4 = manager.ui.mainCamera.transform
			local var_222_5 = 0.2

			if var_222_5 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 then
				arg_219_1.var_.shakeOldPos = var_222_4.localPosition
			end

			local var_222_6 = 0.6

			if var_222_5 <= arg_219_1.time_ and arg_219_1.time_ < var_222_5 + var_222_6 then
				local var_222_7 = (arg_219_1.time_ - var_222_5) / 0.066
				local var_222_8, var_222_9 = math.modf(var_222_7)

				var_222_4.localPosition = Vector3.New(var_222_9 * 0.02, var_222_9 * 0.02, var_222_9 * 0.02) + arg_219_1.var_.shakeOldPos
			end

			if arg_219_1.time_ >= var_222_5 + var_222_6 and arg_219_1.time_ < var_222_5 + var_222_6 + arg_222_0 then
				var_222_4.localPosition = arg_219_1.var_.shakeOldPos
			end

			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 then
				arg_219_1.allBtn_.enabled = false
			end

			local var_222_11 = 0.8

			if arg_219_1.time_ >= var_222_10 + var_222_11 and arg_219_1.time_ < var_222_10 + var_222_11 + arg_222_0 then
				arg_219_1.allBtn_.enabled = true
			end

			local var_222_12 = 0
			local var_222_13 = 1.6

			if var_222_12 < arg_219_1.time_ and arg_219_1.time_ <= var_222_12 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_14 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_14:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_15 = arg_219_1:GetWordFromCfg(423041051)
				local var_222_16 = arg_219_1:FormatText(var_222_15.content)

				arg_219_1.text_.text = var_222_16

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_17 = 64
				local var_222_18 = utf8.len(var_222_16)
				local var_222_19 = var_222_17 <= 0 and var_222_13 or var_222_13 * (var_222_18 / var_222_17)

				if var_222_19 > 0 and var_222_13 < var_222_19 then
					arg_219_1.talkMaxDuration = var_222_19
					var_222_12 = var_222_12 + 0.3

					if var_222_19 + var_222_12 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_19 + var_222_12
					end
				end

				arg_219_1.text_.text = var_222_16
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_20 = var_222_12 + 0.3
			local var_222_21 = math.max(var_222_13, arg_219_1.talkMaxDuration)

			if var_222_20 <= arg_219_1.time_ and arg_219_1.time_ < var_222_20 + var_222_21 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_20) / var_222_21

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_20 + var_222_21 and arg_219_1.time_ < var_222_20 + var_222_21 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play423041052 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 423041052
		arg_225_1.duration_ = 5.8

		local var_225_0 = {
			zh = 4.7,
			ja = 5.8
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
				arg_225_0:Play423041053(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.575

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[1338].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_3 = arg_225_1:GetWordFromCfg(423041052)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 23
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041052", "story_v_out_423041.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041052", "story_v_out_423041.awb") / 1000

					if var_228_8 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_0
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_423041", "423041052", "story_v_out_423041.awb")

						arg_225_1:RecordAudio("423041052", var_228_9)
						arg_225_1:RecordAudio("423041052", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_423041", "423041052", "story_v_out_423041.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_423041", "423041052", "story_v_out_423041.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_10 and arg_225_1.time_ < var_228_0 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play423041053 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 423041053
		arg_229_1.duration_ = 4.73

		local var_229_0 = {
			zh = 4.066,
			ja = 4.733
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play423041054(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.5

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[1338].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:GetWordFromCfg(423041053)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 20
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041053", "story_v_out_423041.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041053", "story_v_out_423041.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_423041", "423041053", "story_v_out_423041.awb")

						arg_229_1:RecordAudio("423041053", var_232_9)
						arg_229_1:RecordAudio("423041053", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_423041", "423041053", "story_v_out_423041.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_423041", "423041053", "story_v_out_423041.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_10 and arg_229_1.time_ < var_232_0 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play423041054 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 423041054
		arg_233_1.duration_ = 7

		local var_233_0 = {
			zh = 5.4,
			ja = 7
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
				arg_233_0:Play423041055(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.45

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[1335].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:GetWordFromCfg(423041054)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 18
				local var_236_6 = utf8.len(var_236_4)
				local var_236_7 = var_236_5 <= 0 and var_236_1 or var_236_1 * (var_236_6 / var_236_5)

				if var_236_7 > 0 and var_236_1 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041054", "story_v_out_423041.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041054", "story_v_out_423041.awb") / 1000

					if var_236_8 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_0
					end

					if var_236_3.prefab_name ~= "" and arg_233_1.actors_[var_236_3.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_3.prefab_name].transform, "story_v_out_423041", "423041054", "story_v_out_423041.awb")

						arg_233_1:RecordAudio("423041054", var_236_9)
						arg_233_1:RecordAudio("423041054", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_423041", "423041054", "story_v_out_423041.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_423041", "423041054", "story_v_out_423041.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_10 and arg_233_1.time_ < var_236_0 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play423041055 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 423041055
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play423041056(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = manager.ui.mainCamera.transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				local var_240_2 = arg_237_1.var_.effectLAGEZIDAN1
				local var_240_3
				local var_240_4 = var_240_0

				if not var_240_2 then
					var_240_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_240_4)
					var_240_2.name = "LAGEZIDAN1"
					arg_237_1.var_.effectLAGEZIDAN1 = var_240_2
				else
					var_240_2.transform:SetParent(var_240_4)
				end

				var_240_2.transform.localPosition = Vector3.New(-1, 0.5, 0)
				var_240_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_240_5 = manager.ui.mainCamera.transform
			local var_240_6 = 1.5

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				local var_240_7 = arg_237_1.var_.effectLAGEZIDAN1

				if var_240_7 then
					Object.Destroy(var_240_7)

					arg_237_1.var_.effectLAGEZIDAN1 = nil
				end
			end

			local var_240_8 = manager.ui.mainCamera.transform
			local var_240_9 = 0.133333333333333

			if var_240_9 < arg_237_1.time_ and arg_237_1.time_ <= var_240_9 + arg_240_0 then
				local var_240_10 = arg_237_1.var_.effectLAGEZIDAN2
				local var_240_11
				local var_240_12 = var_240_8

				if not var_240_10 then
					var_240_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_240_12)
					var_240_10.name = "LAGEZIDAN2"
					arg_237_1.var_.effectLAGEZIDAN2 = var_240_10
				else
					var_240_10.transform:SetParent(var_240_12)
				end

				var_240_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_240_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_240_13 = manager.ui.mainCamera.transform
			local var_240_14 = 1.63333333333333

			if var_240_14 < arg_237_1.time_ and arg_237_1.time_ <= var_240_14 + arg_240_0 then
				local var_240_15 = arg_237_1.var_.effectLAGEZIDAN2

				if var_240_15 then
					Object.Destroy(var_240_15)

					arg_237_1.var_.effectLAGEZIDAN2 = nil
				end
			end

			local var_240_16 = manager.ui.mainCamera.transform
			local var_240_17 = 0.333333333333333

			if var_240_17 < arg_237_1.time_ and arg_237_1.time_ <= var_240_17 + arg_240_0 then
				local var_240_18 = arg_237_1.var_.effectLAGEZIDAN3
				local var_240_19
				local var_240_20 = var_240_16

				if not var_240_18 then
					var_240_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_240_20)
					var_240_18.name = "LAGEZIDAN3"
					arg_237_1.var_.effectLAGEZIDAN3 = var_240_18
				else
					var_240_18.transform:SetParent(var_240_20)
				end

				var_240_18.transform.localPosition = Vector3.New(1, 0.46, 0)
				var_240_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_240_21 = manager.ui.mainCamera.transform
			local var_240_22 = 1.83333333333333

			if var_240_22 < arg_237_1.time_ and arg_237_1.time_ <= var_240_22 + arg_240_0 then
				local var_240_23 = arg_237_1.var_.effectLAGEZIDAN3

				if var_240_23 then
					Object.Destroy(var_240_23)

					arg_237_1.var_.effectLAGEZIDAN3 = nil
				end
			end

			local var_240_24 = manager.ui.mainCamera.transform
			local var_240_25 = 0

			if var_240_25 < arg_237_1.time_ and arg_237_1.time_ <= var_240_25 + arg_240_0 then
				arg_237_1.var_.shakeOldPos = var_240_24.localPosition
			end

			local var_240_26 = 0.133333333333333

			if var_240_25 <= arg_237_1.time_ and arg_237_1.time_ < var_240_25 + var_240_26 then
				local var_240_27 = (arg_237_1.time_ - var_240_25) / 0.066
				local var_240_28, var_240_29 = math.modf(var_240_27)

				var_240_24.localPosition = Vector3.New(var_240_29 * 0.13, var_240_29 * 0.13, var_240_29 * 0.13) + arg_237_1.var_.shakeOldPos
			end

			if arg_237_1.time_ >= var_240_25 + var_240_26 and arg_237_1.time_ < var_240_25 + var_240_26 + arg_240_0 then
				var_240_24.localPosition = arg_237_1.var_.shakeOldPos
			end

			local var_240_30 = manager.ui.mainCamera.transform
			local var_240_31 = 0.2

			if var_240_31 < arg_237_1.time_ and arg_237_1.time_ <= var_240_31 + arg_240_0 then
				arg_237_1.var_.shakeOldPos = var_240_30.localPosition
			end

			local var_240_32 = 0.133333333333333

			if var_240_31 <= arg_237_1.time_ and arg_237_1.time_ < var_240_31 + var_240_32 then
				local var_240_33 = (arg_237_1.time_ - var_240_31) / 0.066
				local var_240_34, var_240_35 = math.modf(var_240_33)

				var_240_30.localPosition = Vector3.New(var_240_35 * 0.13, var_240_35 * 0.13, var_240_35 * 0.13) + arg_237_1.var_.shakeOldPos
			end

			if arg_237_1.time_ >= var_240_31 + var_240_32 and arg_237_1.time_ < var_240_31 + var_240_32 + arg_240_0 then
				var_240_30.localPosition = arg_237_1.var_.shakeOldPos
			end

			local var_240_36 = manager.ui.mainCamera.transform
			local var_240_37 = 0.333333333333333

			if var_240_37 < arg_237_1.time_ and arg_237_1.time_ <= var_240_37 + arg_240_0 then
				arg_237_1.var_.shakeOldPos = var_240_36.localPosition
			end

			local var_240_38 = 0.1

			if var_240_37 <= arg_237_1.time_ and arg_237_1.time_ < var_240_37 + var_240_38 then
				local var_240_39 = (arg_237_1.time_ - var_240_37) / 0.066
				local var_240_40, var_240_41 = math.modf(var_240_39)

				var_240_36.localPosition = Vector3.New(var_240_41 * 0.13, var_240_41 * 0.13, var_240_41 * 0.13) + arg_237_1.var_.shakeOldPos
			end

			if arg_237_1.time_ >= var_240_37 + var_240_38 and arg_237_1.time_ < var_240_37 + var_240_38 + arg_240_0 then
				var_240_36.localPosition = arg_237_1.var_.shakeOldPos
			end

			local var_240_42 = 0

			if var_240_42 < arg_237_1.time_ and arg_237_1.time_ <= var_240_42 + arg_240_0 then
				arg_237_1.allBtn_.enabled = false
			end

			local var_240_43 = 1.5

			if arg_237_1.time_ >= var_240_42 + var_240_43 and arg_237_1.time_ < var_240_42 + var_240_43 + arg_240_0 then
				arg_237_1.allBtn_.enabled = true
			end

			local var_240_44 = 0
			local var_240_45 = 1

			if var_240_44 < arg_237_1.time_ and arg_237_1.time_ <= var_240_44 + arg_240_0 then
				local var_240_46 = "play"
				local var_240_47 = "effect"

				arg_237_1:AudioAction(var_240_46, var_240_47, "se_story_136", "se_story_136_gun", "")
			end

			local var_240_48 = 0
			local var_240_49 = 1.375

			if var_240_48 < arg_237_1.time_ and arg_237_1.time_ <= var_240_48 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_50 = arg_237_1:GetWordFromCfg(423041055)
				local var_240_51 = arg_237_1:FormatText(var_240_50.content)

				arg_237_1.text_.text = var_240_51

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_52 = 55
				local var_240_53 = utf8.len(var_240_51)
				local var_240_54 = var_240_52 <= 0 and var_240_49 or var_240_49 * (var_240_53 / var_240_52)

				if var_240_54 > 0 and var_240_49 < var_240_54 then
					arg_237_1.talkMaxDuration = var_240_54

					if var_240_54 + var_240_48 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_54 + var_240_48
					end
				end

				arg_237_1.text_.text = var_240_51
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_55 = math.max(var_240_49, arg_237_1.talkMaxDuration)

			if var_240_48 <= arg_237_1.time_ and arg_237_1.time_ < var_240_48 + var_240_55 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_48) / var_240_55

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_48 + var_240_55 and arg_237_1.time_ < var_240_48 + var_240_55 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play423041056 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 423041056
		arg_241_1.duration_ = 6.1

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play423041057(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.466666666666667
			local var_244_1 = 1

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				local var_244_2 = "play"
				local var_244_3 = "effect"

				arg_241_1:AudioAction(var_244_2, var_244_3, "se_story_141", "se_story_141_foley_cloth", "")
			end

			local var_244_4 = arg_241_1.bgs_.SS2302.transform
			local var_244_5 = 0

			if var_244_5 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1.var_.moveOldPosSS2302 = var_244_4.localPosition
			end

			local var_244_6 = 2.5

			if var_244_5 <= arg_241_1.time_ and arg_241_1.time_ < var_244_5 + var_244_6 then
				local var_244_7 = (arg_241_1.time_ - var_244_5) / var_244_6
				local var_244_8 = Vector3.New(0, 0, 5)

				var_244_4.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPosSS2302, var_244_8, var_244_7)
			end

			if arg_241_1.time_ >= var_244_5 + var_244_6 and arg_241_1.time_ < var_244_5 + var_244_6 + arg_244_0 then
				var_244_4.localPosition = Vector3.New(0, 0, 5)
			end

			local var_244_9 = manager.ui.mainCamera.transform
			local var_244_10 = 0.8

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				local var_244_11 = arg_241_1.var_.effectbianzitexiao1
				local var_244_12
				local var_244_13 = var_244_9

				if not var_244_11 then
					var_244_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang02"), var_244_13)
					var_244_11.name = "bianzitexiao1"
					arg_241_1.var_.effectbianzitexiao1 = var_244_11
				else
					var_244_11.transform:SetParent(var_244_13)
				end

				var_244_11.transform.localPosition = Vector3.New(0, 0, -3.31)
				var_244_11.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_244_14 = manager.ui.mainCameraCom_
				local var_244_15 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_244_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_244_16 = var_244_11.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_244_17 = 15
				local var_244_18 = 2 * var_244_17 * Mathf.Tan(var_244_14.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_244_14.aspect
				local var_244_19 = 1
				local var_244_20 = 1.7777777777777777

				if var_244_20 < var_244_14.aspect then
					var_244_19 = var_244_18 / (2 * var_244_17 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_244_20)
				end

				for iter_244_0, iter_244_1 in ipairs(var_244_16) do
					local var_244_21 = iter_244_1.transform.localScale

					iter_244_1.transform.localScale = Vector3.New(var_244_21.x / var_244_15 * var_244_19, var_244_21.y / var_244_15, var_244_21.z)
				end
			end

			local var_244_22 = manager.ui.mainCamera.transform
			local var_244_23 = 2.8

			if var_244_23 < arg_241_1.time_ and arg_241_1.time_ <= var_244_23 + arg_244_0 then
				local var_244_24 = arg_241_1.var_.effectbianzitexiao1

				if var_244_24 then
					Object.Destroy(var_244_24)

					arg_241_1.var_.effectbianzitexiao1 = nil
				end
			end

			local var_244_25 = manager.ui.mainCamera.transform
			local var_244_26 = 0.8

			if var_244_26 < arg_241_1.time_ and arg_241_1.time_ <= var_244_26 + arg_244_0 then
				arg_241_1.var_.shakeOldPos = var_244_25.localPosition
			end

			local var_244_27 = 1

			if var_244_26 <= arg_241_1.time_ and arg_241_1.time_ < var_244_26 + var_244_27 then
				local var_244_28 = (arg_241_1.time_ - var_244_26) / 0.066
				local var_244_29, var_244_30 = math.modf(var_244_28)

				var_244_25.localPosition = Vector3.New(var_244_30 * 0.02, var_244_30 * 0.02, var_244_30 * 0.02) + arg_241_1.var_.shakeOldPos
			end

			if arg_241_1.time_ >= var_244_26 + var_244_27 and arg_241_1.time_ < var_244_26 + var_244_27 + arg_244_0 then
				var_244_25.localPosition = arg_241_1.var_.shakeOldPos
			end

			local var_244_31 = 0

			if var_244_31 < arg_241_1.time_ and arg_241_1.time_ <= var_244_31 + arg_244_0 then
				arg_241_1.allBtn_.enabled = false
			end

			local var_244_32 = 1.8

			if arg_241_1.time_ >= var_244_31 + var_244_32 and arg_241_1.time_ < var_244_31 + var_244_32 + arg_244_0 then
				arg_241_1.allBtn_.enabled = true
			end

			local var_244_33 = 0.8
			local var_244_34 = 1

			if var_244_33 < arg_241_1.time_ and arg_241_1.time_ <= var_244_33 + arg_244_0 then
				local var_244_35 = "play"
				local var_244_36 = "effect"

				arg_241_1:AudioAction(var_244_35, var_244_36, "se_story_142", "se_story_142_line", "")
			end

			if arg_241_1.frameCnt_ <= 1 then
				arg_241_1.dialog_:SetActive(false)
			end

			local var_244_37 = 1.1
			local var_244_38 = 1.4

			if var_244_37 < arg_241_1.time_ and arg_241_1.time_ <= var_244_37 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				arg_241_1.dialog_:SetActive(true)

				arg_241_1.dialogCg_.alpha = 0

				local var_244_39 = LeanTween.value(arg_241_1.dialog_, 0, 1, 0.3)

				var_244_39:setOnUpdate(LuaHelper.FloatAction(function(arg_245_0)
					arg_241_1.dialogCg_.alpha = arg_245_0
				end))
				var_244_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_241_1.dialog_)
					var_244_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_241_1.duration_ = arg_241_1.duration_ + 0.3

				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_40 = arg_241_1:GetWordFromCfg(423041056)
				local var_244_41 = arg_241_1:FormatText(var_244_40.content)

				arg_241_1.text_.text = var_244_41

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_42 = 56
				local var_244_43 = utf8.len(var_244_41)
				local var_244_44 = var_244_42 <= 0 and var_244_38 or var_244_38 * (var_244_43 / var_244_42)

				if var_244_44 > 0 and var_244_38 < var_244_44 then
					arg_241_1.talkMaxDuration = var_244_44
					var_244_37 = var_244_37 + 0.3

					if var_244_44 + var_244_37 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_44 + var_244_37
					end
				end

				arg_241_1.text_.text = var_244_41
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_45 = var_244_37 + 0.3
			local var_244_46 = math.max(var_244_38, arg_241_1.talkMaxDuration)

			if var_244_45 <= arg_241_1.time_ and arg_241_1.time_ < var_244_45 + var_244_46 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_45) / var_244_46

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_45 + var_244_46 and arg_241_1.time_ < var_244_45 + var_244_46 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2302",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.5,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 0, 5),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play423041057 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 423041057
		arg_247_1.duration_ = 4.77

		local var_247_0 = {
			zh = 4,
			ja = 4.766
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play423041058(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 0.5

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_2 = arg_247_1:FormatText(StoryNameCfg[1338].name)

				arg_247_1.leftNameTxt_.text = var_250_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_3 = arg_247_1:GetWordFromCfg(423041057)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 20
				local var_250_6 = utf8.len(var_250_4)
				local var_250_7 = var_250_5 <= 0 and var_250_1 or var_250_1 * (var_250_6 / var_250_5)

				if var_250_7 > 0 and var_250_1 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041057", "story_v_out_423041.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041057", "story_v_out_423041.awb") / 1000

					if var_250_8 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_0
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_423041", "423041057", "story_v_out_423041.awb")

						arg_247_1:RecordAudio("423041057", var_250_9)
						arg_247_1:RecordAudio("423041057", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_423041", "423041057", "story_v_out_423041.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_423041", "423041057", "story_v_out_423041.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_10 and arg_247_1.time_ < var_250_0 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play423041058 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 423041058
		arg_251_1.duration_ = 5.7

		local var_251_0 = {
			zh = 5.4,
			ja = 5.7
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play423041059(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.45

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[1335].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:GetWordFromCfg(423041058)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 18
				local var_254_6 = utf8.len(var_254_4)
				local var_254_7 = var_254_5 <= 0 and var_254_1 or var_254_1 * (var_254_6 / var_254_5)

				if var_254_7 > 0 and var_254_1 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041058", "story_v_out_423041.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041058", "story_v_out_423041.awb") / 1000

					if var_254_8 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_0
					end

					if var_254_3.prefab_name ~= "" and arg_251_1.actors_[var_254_3.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_3.prefab_name].transform, "story_v_out_423041", "423041058", "story_v_out_423041.awb")

						arg_251_1:RecordAudio("423041058", var_254_9)
						arg_251_1:RecordAudio("423041058", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_423041", "423041058", "story_v_out_423041.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_423041", "423041058", "story_v_out_423041.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_10 and arg_251_1.time_ < var_254_0 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play423041059 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 423041059
		arg_255_1.duration_ = 4.17

		local var_255_0 = {
			zh = 4.166,
			ja = 3.366
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play423041060(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.45

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[1338].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_3 = arg_255_1:GetWordFromCfg(423041059)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 18
				local var_258_6 = utf8.len(var_258_4)
				local var_258_7 = var_258_5 <= 0 and var_258_1 or var_258_1 * (var_258_6 / var_258_5)

				if var_258_7 > 0 and var_258_1 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041059", "story_v_out_423041.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041059", "story_v_out_423041.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_out_423041", "423041059", "story_v_out_423041.awb")

						arg_255_1:RecordAudio("423041059", var_258_9)
						arg_255_1:RecordAudio("423041059", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_423041", "423041059", "story_v_out_423041.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_423041", "423041059", "story_v_out_423041.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_10 and arg_255_1.time_ < var_258_0 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play423041060 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 423041060
		arg_259_1.duration_ = 9

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play423041061(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 2

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				local var_262_1 = manager.ui.mainCamera.transform.localPosition
				local var_262_2 = Vector3.New(0, 0, 10) + Vector3.New(var_262_1.x, var_262_1.y, 0)
				local var_262_3 = arg_259_1.bgs_.I25g

				var_262_3.transform.localPosition = var_262_2
				var_262_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_262_4 = var_262_3:GetComponent("SpriteRenderer")

				if var_262_4 and var_262_4.sprite then
					local var_262_5 = (var_262_3.transform.localPosition - var_262_1).z
					local var_262_6 = manager.ui.mainCameraCom_
					local var_262_7 = 2 * var_262_5 * Mathf.Tan(var_262_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_262_8 = var_262_7 * var_262_6.aspect
					local var_262_9 = var_262_4.sprite.bounds.size.x
					local var_262_10 = var_262_4.sprite.bounds.size.y
					local var_262_11 = var_262_8 / var_262_9
					local var_262_12 = var_262_7 / var_262_10
					local var_262_13 = var_262_12 < var_262_11 and var_262_11 or var_262_12

					var_262_3.transform.localScale = Vector3.New(var_262_13, var_262_13, 0)
				end

				for iter_262_0, iter_262_1 in pairs(arg_259_1.bgs_) do
					if iter_262_0 ~= "I25g" then
						iter_262_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_262_14 = 4

			if var_262_14 < arg_259_1.time_ and arg_259_1.time_ <= var_262_14 + arg_262_0 then
				arg_259_1.allBtn_.enabled = false
			end

			local var_262_15 = 0.3

			if arg_259_1.time_ >= var_262_14 + var_262_15 and arg_259_1.time_ < var_262_14 + var_262_15 + arg_262_0 then
				arg_259_1.allBtn_.enabled = true
			end

			local var_262_16 = 0

			if var_262_16 < arg_259_1.time_ and arg_259_1.time_ <= var_262_16 + arg_262_0 then
				arg_259_1.mask_.enabled = true
				arg_259_1.mask_.raycastTarget = true

				arg_259_1:SetGaussion(false)
			end

			local var_262_17 = 2

			if var_262_16 <= arg_259_1.time_ and arg_259_1.time_ < var_262_16 + var_262_17 then
				local var_262_18 = (arg_259_1.time_ - var_262_16) / var_262_17
				local var_262_19 = Color.New(0, 0, 0)

				var_262_19.a = Mathf.Lerp(0, 1, var_262_18)
				arg_259_1.mask_.color = var_262_19
			end

			if arg_259_1.time_ >= var_262_16 + var_262_17 and arg_259_1.time_ < var_262_16 + var_262_17 + arg_262_0 then
				local var_262_20 = Color.New(0, 0, 0)

				var_262_20.a = 1
				arg_259_1.mask_.color = var_262_20
			end

			local var_262_21 = 2

			if var_262_21 < arg_259_1.time_ and arg_259_1.time_ <= var_262_21 + arg_262_0 then
				arg_259_1.mask_.enabled = true
				arg_259_1.mask_.raycastTarget = true

				arg_259_1:SetGaussion(false)
			end

			local var_262_22 = 2

			if var_262_21 <= arg_259_1.time_ and arg_259_1.time_ < var_262_21 + var_262_22 then
				local var_262_23 = (arg_259_1.time_ - var_262_21) / var_262_22
				local var_262_24 = Color.New(0, 0, 0)

				var_262_24.a = Mathf.Lerp(1, 0, var_262_23)
				arg_259_1.mask_.color = var_262_24
			end

			if arg_259_1.time_ >= var_262_21 + var_262_22 and arg_259_1.time_ < var_262_21 + var_262_22 + arg_262_0 then
				local var_262_25 = Color.New(0, 0, 0)
				local var_262_26 = 0

				arg_259_1.mask_.enabled = false
				var_262_25.a = var_262_26
				arg_259_1.mask_.color = var_262_25
			end

			if arg_259_1.frameCnt_ <= 1 then
				arg_259_1.dialog_:SetActive(false)
			end

			local var_262_27 = 4
			local var_262_28 = 1.725

			if var_262_27 < arg_259_1.time_ and arg_259_1.time_ <= var_262_27 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0

				arg_259_1.dialog_:SetActive(true)

				arg_259_1.dialogCg_.alpha = 0

				local var_262_29 = LeanTween.value(arg_259_1.dialog_, 0, 1, 0.3)

				var_262_29:setOnUpdate(LuaHelper.FloatAction(function(arg_263_0)
					arg_259_1.dialogCg_.alpha = arg_263_0
				end))
				var_262_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_259_1.dialog_)
					var_262_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_259_1.duration_ = arg_259_1.duration_ + 0.3

				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_30 = arg_259_1:GetWordFromCfg(423041060)
				local var_262_31 = arg_259_1:FormatText(var_262_30.content)

				arg_259_1.text_.text = var_262_31

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_32 = 69
				local var_262_33 = utf8.len(var_262_31)
				local var_262_34 = var_262_32 <= 0 and var_262_28 or var_262_28 * (var_262_33 / var_262_32)

				if var_262_34 > 0 and var_262_28 < var_262_34 then
					arg_259_1.talkMaxDuration = var_262_34
					var_262_27 = var_262_27 + 0.3

					if var_262_34 + var_262_27 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_34 + var_262_27
					end
				end

				arg_259_1.text_.text = var_262_31
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_35 = var_262_27 + 0.3
			local var_262_36 = math.max(var_262_28, arg_259_1.talkMaxDuration)

			if var_262_35 <= arg_259_1.time_ and arg_259_1.time_ < var_262_35 + var_262_36 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_35) / var_262_36

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_35 + var_262_36 and arg_259_1.time_ < var_262_35 + var_262_36 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play423041061 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 423041061
		arg_265_1.duration_ = 5.2

		local var_265_0 = {
			zh = 4.5,
			ja = 5.2
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
				arg_265_0:Play423041062(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = "10146"

			if arg_265_1.actors_[var_268_0] == nil then
				local var_268_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10146")

				if not isNil(var_268_1) then
					local var_268_2 = Object.Instantiate(var_268_1, arg_265_1.canvasGo_.transform)

					var_268_2.transform:SetSiblingIndex(1)

					var_268_2.name = var_268_0
					var_268_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_265_1.actors_[var_268_0] = var_268_2

					local var_268_3 = var_268_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_265_1.isInRecall_ then
						for iter_268_0, iter_268_1 in ipairs(var_268_3) do
							iter_268_1.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_268_4 = arg_265_1.actors_["10146"]
			local var_268_5 = 0

			if var_268_5 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 and not isNil(var_268_4) and arg_265_1.var_.actorSpriteComps10146 == nil then
				arg_265_1.var_.actorSpriteComps10146 = var_268_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_6 = 0.2

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_6 and not isNil(var_268_4) then
				local var_268_7 = (arg_265_1.time_ - var_268_5) / var_268_6

				if arg_265_1.var_.actorSpriteComps10146 then
					for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_268_3 then
							if arg_265_1.isInRecall_ then
								local var_268_8 = Mathf.Lerp(iter_268_3.color.r, arg_265_1.hightColor1.r, var_268_7)
								local var_268_9 = Mathf.Lerp(iter_268_3.color.g, arg_265_1.hightColor1.g, var_268_7)
								local var_268_10 = Mathf.Lerp(iter_268_3.color.b, arg_265_1.hightColor1.b, var_268_7)

								iter_268_3.color = Color.New(var_268_8, var_268_9, var_268_10)
							else
								local var_268_11 = Mathf.Lerp(iter_268_3.color.r, 1, var_268_7)

								iter_268_3.color = Color.New(var_268_11, var_268_11, var_268_11)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_5 + var_268_6 and arg_265_1.time_ < var_268_5 + var_268_6 + arg_268_0 and not isNil(var_268_4) and arg_265_1.var_.actorSpriteComps10146 then
				for iter_268_4, iter_268_5 in pairs(arg_265_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_268_5 then
						if arg_265_1.isInRecall_ then
							iter_268_5.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_268_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps10146 = nil
			end

			local var_268_12 = arg_265_1.actors_["10146"].transform
			local var_268_13 = 0

			if var_268_13 < arg_265_1.time_ and arg_265_1.time_ <= var_268_13 + arg_268_0 then
				arg_265_1.var_.moveOldPos10146 = var_268_12.localPosition
				var_268_12.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("10146", 3)

				local var_268_14 = var_268_12.childCount

				for iter_268_6 = 0, var_268_14 - 1 do
					local var_268_15 = var_268_12:GetChild(iter_268_6)

					if var_268_15.name == "split_6" or not string.find(var_268_15.name, "split") then
						var_268_15.gameObject:SetActive(true)
					else
						var_268_15.gameObject:SetActive(false)
					end
				end
			end

			local var_268_16 = 0.001

			if var_268_13 <= arg_265_1.time_ and arg_265_1.time_ < var_268_13 + var_268_16 then
				local var_268_17 = (arg_265_1.time_ - var_268_13) / var_268_16
				local var_268_18 = Vector3.New(0, -350, -320)

				var_268_12.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10146, var_268_18, var_268_17)
			end

			if arg_265_1.time_ >= var_268_13 + var_268_16 and arg_265_1.time_ < var_268_13 + var_268_16 + arg_268_0 then
				var_268_12.localPosition = Vector3.New(0, -350, -320)
			end

			local var_268_19 = arg_265_1.actors_["10146"]
			local var_268_20 = 0

			if var_268_20 < arg_265_1.time_ and arg_265_1.time_ <= var_268_20 + arg_268_0 then
				local var_268_21 = var_268_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_268_21 then
					arg_265_1.var_.alphaOldValue10146 = var_268_21.alpha
					arg_265_1.var_.characterEffect10146 = var_268_21
				end

				arg_265_1.var_.alphaOldValue10146 = 0
			end

			local var_268_22 = 0.5

			if var_268_20 <= arg_265_1.time_ and arg_265_1.time_ < var_268_20 + var_268_22 then
				local var_268_23 = (arg_265_1.time_ - var_268_20) / var_268_22
				local var_268_24 = Mathf.Lerp(arg_265_1.var_.alphaOldValue10146, 1, var_268_23)

				if arg_265_1.var_.characterEffect10146 then
					arg_265_1.var_.characterEffect10146.alpha = var_268_24
				end
			end

			if arg_265_1.time_ >= var_268_20 + var_268_22 and arg_265_1.time_ < var_268_20 + var_268_22 + arg_268_0 and arg_265_1.var_.characterEffect10146 then
				arg_265_1.var_.characterEffect10146.alpha = 1
			end

			local var_268_25 = 0.5
			local var_268_26 = 0.475

			if var_268_25 < arg_265_1.time_ and arg_265_1.time_ <= var_268_25 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_27 = arg_265_1:FormatText(StoryNameCfg[1338].name)

				arg_265_1.leftNameTxt_.text = var_268_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_28 = arg_265_1:GetWordFromCfg(423041061)
				local var_268_29 = arg_265_1:FormatText(var_268_28.content)

				arg_265_1.text_.text = var_268_29

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_30 = 19
				local var_268_31 = utf8.len(var_268_29)
				local var_268_32 = var_268_30 <= 0 and var_268_26 or var_268_26 * (var_268_31 / var_268_30)

				if var_268_32 > 0 and var_268_26 < var_268_32 then
					arg_265_1.talkMaxDuration = var_268_32

					if var_268_32 + var_268_25 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_32 + var_268_25
					end
				end

				arg_265_1.text_.text = var_268_29
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041061", "story_v_out_423041.awb") ~= 0 then
					local var_268_33 = manager.audio:GetVoiceLength("story_v_out_423041", "423041061", "story_v_out_423041.awb") / 1000

					if var_268_33 + var_268_25 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_33 + var_268_25
					end

					if var_268_28.prefab_name ~= "" and arg_265_1.actors_[var_268_28.prefab_name] ~= nil then
						local var_268_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_28.prefab_name].transform, "story_v_out_423041", "423041061", "story_v_out_423041.awb")

						arg_265_1:RecordAudio("423041061", var_268_34)
						arg_265_1:RecordAudio("423041061", var_268_34)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_423041", "423041061", "story_v_out_423041.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_423041", "423041061", "story_v_out_423041.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_35 = math.max(var_268_26, arg_265_1.talkMaxDuration)

			if var_268_25 <= arg_265_1.time_ and arg_265_1.time_ < var_268_25 + var_268_35 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_25) / var_268_35

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_25 + var_268_35 and arg_265_1.time_ < var_268_25 + var_268_35 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play423041062 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 423041062
		arg_269_1.duration_ = 4.3

		local var_269_0 = {
			zh = 4.3,
			ja = 3.966
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
				arg_269_0:Play423041063(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.55

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[1338].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_3 = arg_269_1:GetWordFromCfg(423041062)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 22
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041062", "story_v_out_423041.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041062", "story_v_out_423041.awb") / 1000

					if var_272_8 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_0
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_out_423041", "423041062", "story_v_out_423041.awb")

						arg_269_1:RecordAudio("423041062", var_272_9)
						arg_269_1:RecordAudio("423041062", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_423041", "423041062", "story_v_out_423041.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_423041", "423041062", "story_v_out_423041.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_10 and arg_269_1.time_ < var_272_0 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play423041063 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 423041063
		arg_273_1.duration_ = 3.87

		local var_273_0 = {
			zh = 3.233,
			ja = 3.866
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
				arg_273_0:Play423041064(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10146"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos10146 = var_276_0.localPosition
				var_276_0.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("10146", 3)

				local var_276_2 = var_276_0.childCount

				for iter_276_0 = 0, var_276_2 - 1 do
					local var_276_3 = var_276_0:GetChild(iter_276_0)

					if var_276_3.name == "" or not string.find(var_276_3.name, "split") then
						var_276_3.gameObject:SetActive(true)
					else
						var_276_3.gameObject:SetActive(false)
					end
				end
			end

			local var_276_4 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_4 then
				local var_276_5 = (arg_273_1.time_ - var_276_1) / var_276_4
				local var_276_6 = Vector3.New(0, -350, -320)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10146, var_276_6, var_276_5)
			end

			if arg_273_1.time_ >= var_276_1 + var_276_4 and arg_273_1.time_ < var_276_1 + var_276_4 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, -350, -320)
			end

			local var_276_7 = 0
			local var_276_8 = 0.325

			if var_276_7 < arg_273_1.time_ and arg_273_1.time_ <= var_276_7 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_9 = arg_273_1:FormatText(StoryNameCfg[1338].name)

				arg_273_1.leftNameTxt_.text = var_276_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_10 = arg_273_1:GetWordFromCfg(423041063)
				local var_276_11 = arg_273_1:FormatText(var_276_10.content)

				arg_273_1.text_.text = var_276_11

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_12 = 13
				local var_276_13 = utf8.len(var_276_11)
				local var_276_14 = var_276_12 <= 0 and var_276_8 or var_276_8 * (var_276_13 / var_276_12)

				if var_276_14 > 0 and var_276_8 < var_276_14 then
					arg_273_1.talkMaxDuration = var_276_14

					if var_276_14 + var_276_7 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_14 + var_276_7
					end
				end

				arg_273_1.text_.text = var_276_11
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041063", "story_v_out_423041.awb") ~= 0 then
					local var_276_15 = manager.audio:GetVoiceLength("story_v_out_423041", "423041063", "story_v_out_423041.awb") / 1000

					if var_276_15 + var_276_7 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_15 + var_276_7
					end

					if var_276_10.prefab_name ~= "" and arg_273_1.actors_[var_276_10.prefab_name] ~= nil then
						local var_276_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_10.prefab_name].transform, "story_v_out_423041", "423041063", "story_v_out_423041.awb")

						arg_273_1:RecordAudio("423041063", var_276_16)
						arg_273_1:RecordAudio("423041063", var_276_16)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_423041", "423041063", "story_v_out_423041.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_423041", "423041063", "story_v_out_423041.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_17 = math.max(var_276_8, arg_273_1.talkMaxDuration)

			if var_276_7 <= arg_273_1.time_ and arg_273_1.time_ < var_276_7 + var_276_17 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_7) / var_276_17

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_7 + var_276_17 and arg_273_1.time_ < var_276_7 + var_276_17 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play423041064 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 423041064
		arg_277_1.duration_ = 6.63

		local var_277_0 = {
			zh = 5.266,
			ja = 6.633
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
				arg_277_0:Play423041065(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["10146"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps10146 == nil then
				arg_277_1.var_.actorSpriteComps10146 = var_280_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_2 = 0.2

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.actorSpriteComps10146 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_280_1 then
							if arg_277_1.isInRecall_ then
								local var_280_4 = Mathf.Lerp(iter_280_1.color.r, arg_277_1.hightColor2.r, var_280_3)
								local var_280_5 = Mathf.Lerp(iter_280_1.color.g, arg_277_1.hightColor2.g, var_280_3)
								local var_280_6 = Mathf.Lerp(iter_280_1.color.b, arg_277_1.hightColor2.b, var_280_3)

								iter_280_1.color = Color.New(var_280_4, var_280_5, var_280_6)
							else
								local var_280_7 = Mathf.Lerp(iter_280_1.color.r, 0.5, var_280_3)

								iter_280_1.color = Color.New(var_280_7, var_280_7, var_280_7)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps10146 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_280_3 then
						if arg_277_1.isInRecall_ then
							iter_280_3.color = arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_280_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps10146 = nil
			end

			local var_280_8 = 0
			local var_280_9 = 0.7

			if var_280_8 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_10 = arg_277_1:FormatText(StoryNameCfg[1335].name)

				arg_277_1.leftNameTxt_.text = var_280_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_11 = arg_277_1:GetWordFromCfg(423041064)
				local var_280_12 = arg_277_1:FormatText(var_280_11.content)

				arg_277_1.text_.text = var_280_12

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_13 = 28
				local var_280_14 = utf8.len(var_280_12)
				local var_280_15 = var_280_13 <= 0 and var_280_9 or var_280_9 * (var_280_14 / var_280_13)

				if var_280_15 > 0 and var_280_9 < var_280_15 then
					arg_277_1.talkMaxDuration = var_280_15

					if var_280_15 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_15 + var_280_8
					end
				end

				arg_277_1.text_.text = var_280_12
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041064", "story_v_out_423041.awb") ~= 0 then
					local var_280_16 = manager.audio:GetVoiceLength("story_v_out_423041", "423041064", "story_v_out_423041.awb") / 1000

					if var_280_16 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_16 + var_280_8
					end

					if var_280_11.prefab_name ~= "" and arg_277_1.actors_[var_280_11.prefab_name] ~= nil then
						local var_280_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_11.prefab_name].transform, "story_v_out_423041", "423041064", "story_v_out_423041.awb")

						arg_277_1:RecordAudio("423041064", var_280_17)
						arg_277_1:RecordAudio("423041064", var_280_17)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_423041", "423041064", "story_v_out_423041.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_423041", "423041064", "story_v_out_423041.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_18 = math.max(var_280_9, arg_277_1.talkMaxDuration)

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_18 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_8) / var_280_18

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_8 + var_280_18 and arg_277_1.time_ < var_280_8 + var_280_18 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play423041065 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 423041065
		arg_281_1.duration_ = 6.57

		local var_281_0 = {
			zh = 5.3,
			ja = 6.566
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
				arg_281_0:Play423041066(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.475

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[1335].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_3 = arg_281_1:GetWordFromCfg(423041065)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 19
				local var_284_6 = utf8.len(var_284_4)
				local var_284_7 = var_284_5 <= 0 and var_284_1 or var_284_1 * (var_284_6 / var_284_5)

				if var_284_7 > 0 and var_284_1 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041065", "story_v_out_423041.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041065", "story_v_out_423041.awb") / 1000

					if var_284_8 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_0
					end

					if var_284_3.prefab_name ~= "" and arg_281_1.actors_[var_284_3.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_3.prefab_name].transform, "story_v_out_423041", "423041065", "story_v_out_423041.awb")

						arg_281_1:RecordAudio("423041065", var_284_9)
						arg_281_1:RecordAudio("423041065", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_423041", "423041065", "story_v_out_423041.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_423041", "423041065", "story_v_out_423041.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_10 and arg_281_1.time_ < var_284_0 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play423041066 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 423041066
		arg_285_1.duration_ = 3.23

		local var_285_0 = {
			zh = 2.866,
			ja = 3.233
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
				arg_285_0:Play423041067(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10146"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps10146 == nil then
				arg_285_1.var_.actorSpriteComps10146 = var_288_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_2 = 0.2

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.actorSpriteComps10146 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								local var_288_4 = Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor1.r, var_288_3)
								local var_288_5 = Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor1.g, var_288_3)
								local var_288_6 = Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor1.b, var_288_3)

								iter_288_1.color = Color.New(var_288_4, var_288_5, var_288_6)
							else
								local var_288_7 = Mathf.Lerp(iter_288_1.color.r, 1, var_288_3)

								iter_288_1.color = Color.New(var_288_7, var_288_7, var_288_7)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps10146 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_288_3 then
						if arg_285_1.isInRecall_ then
							iter_288_3.color = arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_288_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps10146 = nil
			end

			local var_288_8 = arg_285_1.actors_["10146"].transform
			local var_288_9 = 0

			if var_288_9 < arg_285_1.time_ and arg_285_1.time_ <= var_288_9 + arg_288_0 then
				arg_285_1.var_.moveOldPos10146 = var_288_8.localPosition
				var_288_8.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10146", 3)

				local var_288_10 = var_288_8.childCount

				for iter_288_4 = 0, var_288_10 - 1 do
					local var_288_11 = var_288_8:GetChild(iter_288_4)

					if var_288_11.name == "split_6" or not string.find(var_288_11.name, "split") then
						var_288_11.gameObject:SetActive(true)
					else
						var_288_11.gameObject:SetActive(false)
					end
				end
			end

			local var_288_12 = 0.001

			if var_288_9 <= arg_285_1.time_ and arg_285_1.time_ < var_288_9 + var_288_12 then
				local var_288_13 = (arg_285_1.time_ - var_288_9) / var_288_12
				local var_288_14 = Vector3.New(0, -350, -320)

				var_288_8.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10146, var_288_14, var_288_13)
			end

			if arg_285_1.time_ >= var_288_9 + var_288_12 and arg_285_1.time_ < var_288_9 + var_288_12 + arg_288_0 then
				var_288_8.localPosition = Vector3.New(0, -350, -320)
			end

			local var_288_15 = 0
			local var_288_16 = 0.3

			if var_288_15 < arg_285_1.time_ and arg_285_1.time_ <= var_288_15 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_17 = arg_285_1:FormatText(StoryNameCfg[1338].name)

				arg_285_1.leftNameTxt_.text = var_288_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_18 = arg_285_1:GetWordFromCfg(423041066)
				local var_288_19 = arg_285_1:FormatText(var_288_18.content)

				arg_285_1.text_.text = var_288_19

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_20 = 13
				local var_288_21 = utf8.len(var_288_19)
				local var_288_22 = var_288_20 <= 0 and var_288_16 or var_288_16 * (var_288_21 / var_288_20)

				if var_288_22 > 0 and var_288_16 < var_288_22 then
					arg_285_1.talkMaxDuration = var_288_22

					if var_288_22 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_22 + var_288_15
					end
				end

				arg_285_1.text_.text = var_288_19
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041066", "story_v_out_423041.awb") ~= 0 then
					local var_288_23 = manager.audio:GetVoiceLength("story_v_out_423041", "423041066", "story_v_out_423041.awb") / 1000

					if var_288_23 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_23 + var_288_15
					end

					if var_288_18.prefab_name ~= "" and arg_285_1.actors_[var_288_18.prefab_name] ~= nil then
						local var_288_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_18.prefab_name].transform, "story_v_out_423041", "423041066", "story_v_out_423041.awb")

						arg_285_1:RecordAudio("423041066", var_288_24)
						arg_285_1:RecordAudio("423041066", var_288_24)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_423041", "423041066", "story_v_out_423041.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_423041", "423041066", "story_v_out_423041.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_25 = math.max(var_288_16, arg_285_1.talkMaxDuration)

			if var_288_15 <= arg_285_1.time_ and arg_285_1.time_ < var_288_15 + var_288_25 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_15) / var_288_25

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_15 + var_288_25 and arg_285_1.time_ < var_288_15 + var_288_25 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play423041067 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 423041067
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play423041068(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["10146"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps10146 == nil then
				arg_289_1.var_.actorSpriteComps10146 = var_292_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_2 = 0.2

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.actorSpriteComps10146 then
					for iter_292_0, iter_292_1 in pairs(arg_289_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_292_1 then
							if arg_289_1.isInRecall_ then
								local var_292_4 = Mathf.Lerp(iter_292_1.color.r, arg_289_1.hightColor2.r, var_292_3)
								local var_292_5 = Mathf.Lerp(iter_292_1.color.g, arg_289_1.hightColor2.g, var_292_3)
								local var_292_6 = Mathf.Lerp(iter_292_1.color.b, arg_289_1.hightColor2.b, var_292_3)

								iter_292_1.color = Color.New(var_292_4, var_292_5, var_292_6)
							else
								local var_292_7 = Mathf.Lerp(iter_292_1.color.r, 0.5, var_292_3)

								iter_292_1.color = Color.New(var_292_7, var_292_7, var_292_7)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps10146 then
				for iter_292_2, iter_292_3 in pairs(arg_289_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_292_3 then
						if arg_289_1.isInRecall_ then
							iter_292_3.color = arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_292_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps10146 = nil
			end

			local var_292_8 = arg_289_1.actors_["10146"].transform
			local var_292_9 = 0

			if var_292_9 < arg_289_1.time_ and arg_289_1.time_ <= var_292_9 + arg_292_0 then
				arg_289_1.var_.moveOldPos10146 = var_292_8.localPosition
				var_292_8.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("10146", 7)

				local var_292_10 = var_292_8.childCount

				for iter_292_4 = 0, var_292_10 - 1 do
					local var_292_11 = var_292_8:GetChild(iter_292_4)

					if var_292_11.name == "" or not string.find(var_292_11.name, "split") then
						var_292_11.gameObject:SetActive(true)
					else
						var_292_11.gameObject:SetActive(false)
					end
				end
			end

			local var_292_12 = 0.001

			if var_292_9 <= arg_289_1.time_ and arg_289_1.time_ < var_292_9 + var_292_12 then
				local var_292_13 = (arg_289_1.time_ - var_292_9) / var_292_12
				local var_292_14 = Vector3.New(0, -2000, 0)

				var_292_8.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10146, var_292_14, var_292_13)
			end

			if arg_289_1.time_ >= var_292_9 + var_292_12 and arg_289_1.time_ < var_292_9 + var_292_12 + arg_292_0 then
				var_292_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_292_15 = 0
			local var_292_16 = 2

			if var_292_15 < arg_289_1.time_ and arg_289_1.time_ <= var_292_15 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_17 = arg_289_1:GetWordFromCfg(423041067)
				local var_292_18 = arg_289_1:FormatText(var_292_17.content)

				arg_289_1.text_.text = var_292_18

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_19 = 80
				local var_292_20 = utf8.len(var_292_18)
				local var_292_21 = var_292_19 <= 0 and var_292_16 or var_292_16 * (var_292_20 / var_292_19)

				if var_292_21 > 0 and var_292_16 < var_292_21 then
					arg_289_1.talkMaxDuration = var_292_21

					if var_292_21 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_21 + var_292_15
					end
				end

				arg_289_1.text_.text = var_292_18
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_22 = math.max(var_292_16, arg_289_1.talkMaxDuration)

			if var_292_15 <= arg_289_1.time_ and arg_289_1.time_ < var_292_15 + var_292_22 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_15) / var_292_22

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_15 + var_292_22 and arg_289_1.time_ < var_292_15 + var_292_22 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play423041068 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 423041068
		arg_293_1.duration_ = 2.93

		local var_293_0 = {
			zh = 2.933,
			ja = 2.333
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
				arg_293_0:Play423041069(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["10146"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps10146 == nil then
				arg_293_1.var_.actorSpriteComps10146 = var_296_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_2 = 0.2

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.actorSpriteComps10146 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_296_1 then
							if arg_293_1.isInRecall_ then
								local var_296_4 = Mathf.Lerp(iter_296_1.color.r, arg_293_1.hightColor1.r, var_296_3)
								local var_296_5 = Mathf.Lerp(iter_296_1.color.g, arg_293_1.hightColor1.g, var_296_3)
								local var_296_6 = Mathf.Lerp(iter_296_1.color.b, arg_293_1.hightColor1.b, var_296_3)

								iter_296_1.color = Color.New(var_296_4, var_296_5, var_296_6)
							else
								local var_296_7 = Mathf.Lerp(iter_296_1.color.r, 1, var_296_3)

								iter_296_1.color = Color.New(var_296_7, var_296_7, var_296_7)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps10146 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_296_3 then
						if arg_293_1.isInRecall_ then
							iter_296_3.color = arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_296_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps10146 = nil
			end

			local var_296_8 = arg_293_1.actors_["10146"].transform
			local var_296_9 = 0

			if var_296_9 < arg_293_1.time_ and arg_293_1.time_ <= var_296_9 + arg_296_0 then
				arg_293_1.var_.moveOldPos10146 = var_296_8.localPosition
				var_296_8.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("10146", 3)

				local var_296_10 = var_296_8.childCount

				for iter_296_4 = 0, var_296_10 - 1 do
					local var_296_11 = var_296_8:GetChild(iter_296_4)

					if var_296_11.name == "" or not string.find(var_296_11.name, "split") then
						var_296_11.gameObject:SetActive(true)
					else
						var_296_11.gameObject:SetActive(false)
					end
				end
			end

			local var_296_12 = 0.001

			if var_296_9 <= arg_293_1.time_ and arg_293_1.time_ < var_296_9 + var_296_12 then
				local var_296_13 = (arg_293_1.time_ - var_296_9) / var_296_12
				local var_296_14 = Vector3.New(0, -350, -320)

				var_296_8.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10146, var_296_14, var_296_13)
			end

			if arg_293_1.time_ >= var_296_9 + var_296_12 and arg_293_1.time_ < var_296_9 + var_296_12 + arg_296_0 then
				var_296_8.localPosition = Vector3.New(0, -350, -320)
			end

			local var_296_15 = 0
			local var_296_16 = 0.4

			if var_296_15 < arg_293_1.time_ and arg_293_1.time_ <= var_296_15 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_17 = arg_293_1:FormatText(StoryNameCfg[1338].name)

				arg_293_1.leftNameTxt_.text = var_296_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_18 = arg_293_1:GetWordFromCfg(423041068)
				local var_296_19 = arg_293_1:FormatText(var_296_18.content)

				arg_293_1.text_.text = var_296_19

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_20 = 16
				local var_296_21 = utf8.len(var_296_19)
				local var_296_22 = var_296_20 <= 0 and var_296_16 or var_296_16 * (var_296_21 / var_296_20)

				if var_296_22 > 0 and var_296_16 < var_296_22 then
					arg_293_1.talkMaxDuration = var_296_22

					if var_296_22 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_22 + var_296_15
					end
				end

				arg_293_1.text_.text = var_296_19
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041068", "story_v_out_423041.awb") ~= 0 then
					local var_296_23 = manager.audio:GetVoiceLength("story_v_out_423041", "423041068", "story_v_out_423041.awb") / 1000

					if var_296_23 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_23 + var_296_15
					end

					if var_296_18.prefab_name ~= "" and arg_293_1.actors_[var_296_18.prefab_name] ~= nil then
						local var_296_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_18.prefab_name].transform, "story_v_out_423041", "423041068", "story_v_out_423041.awb")

						arg_293_1:RecordAudio("423041068", var_296_24)
						arg_293_1:RecordAudio("423041068", var_296_24)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_423041", "423041068", "story_v_out_423041.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_423041", "423041068", "story_v_out_423041.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_25 = math.max(var_296_16, arg_293_1.talkMaxDuration)

			if var_296_15 <= arg_293_1.time_ and arg_293_1.time_ < var_296_15 + var_296_25 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_15) / var_296_25

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_15 + var_296_25 and arg_293_1.time_ < var_296_15 + var_296_25 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play423041069 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 423041069
		arg_297_1.duration_ = 4.33

		local var_297_0 = {
			zh = 4.333,
			ja = 4.1
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play423041070(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["10146"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos10146 = var_300_0.localPosition
				var_300_0.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("10146", 3)

				local var_300_2 = var_300_0.childCount

				for iter_300_0 = 0, var_300_2 - 1 do
					local var_300_3 = var_300_0:GetChild(iter_300_0)

					if var_300_3.name == "" or not string.find(var_300_3.name, "split") then
						var_300_3.gameObject:SetActive(true)
					else
						var_300_3.gameObject:SetActive(false)
					end
				end
			end

			local var_300_4 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_4 then
				local var_300_5 = (arg_297_1.time_ - var_300_1) / var_300_4
				local var_300_6 = Vector3.New(0, -350, -320)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10146, var_300_6, var_300_5)
			end

			if arg_297_1.time_ >= var_300_1 + var_300_4 and arg_297_1.time_ < var_300_1 + var_300_4 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0, -350, -320)
			end

			local var_300_7 = 0
			local var_300_8 = 0.55

			if var_300_7 < arg_297_1.time_ and arg_297_1.time_ <= var_300_7 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_9 = arg_297_1:FormatText(StoryNameCfg[1338].name)

				arg_297_1.leftNameTxt_.text = var_300_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_10 = arg_297_1:GetWordFromCfg(423041069)
				local var_300_11 = arg_297_1:FormatText(var_300_10.content)

				arg_297_1.text_.text = var_300_11

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_12 = 22
				local var_300_13 = utf8.len(var_300_11)
				local var_300_14 = var_300_12 <= 0 and var_300_8 or var_300_8 * (var_300_13 / var_300_12)

				if var_300_14 > 0 and var_300_8 < var_300_14 then
					arg_297_1.talkMaxDuration = var_300_14

					if var_300_14 + var_300_7 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_14 + var_300_7
					end
				end

				arg_297_1.text_.text = var_300_11
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041069", "story_v_out_423041.awb") ~= 0 then
					local var_300_15 = manager.audio:GetVoiceLength("story_v_out_423041", "423041069", "story_v_out_423041.awb") / 1000

					if var_300_15 + var_300_7 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_15 + var_300_7
					end

					if var_300_10.prefab_name ~= "" and arg_297_1.actors_[var_300_10.prefab_name] ~= nil then
						local var_300_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_10.prefab_name].transform, "story_v_out_423041", "423041069", "story_v_out_423041.awb")

						arg_297_1:RecordAudio("423041069", var_300_16)
						arg_297_1:RecordAudio("423041069", var_300_16)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_423041", "423041069", "story_v_out_423041.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_423041", "423041069", "story_v_out_423041.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_17 = math.max(var_300_8, arg_297_1.talkMaxDuration)

			if var_300_7 <= arg_297_1.time_ and arg_297_1.time_ < var_300_7 + var_300_17 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_7) / var_300_17

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_7 + var_300_17 and arg_297_1.time_ < var_300_7 + var_300_17 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play423041070 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 423041070
		arg_301_1.duration_ = 9

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play423041071(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = "I26f"

			if arg_301_1.bgs_[var_304_0] == nil then
				local var_304_1 = Object.Instantiate(arg_301_1.paintGo_)

				var_304_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_304_0)
				var_304_1.name = var_304_0
				var_304_1.transform.parent = arg_301_1.stage_.transform
				var_304_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_301_1.bgs_[var_304_0] = var_304_1
			end

			local var_304_2 = 2

			if var_304_2 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 then
				local var_304_3 = manager.ui.mainCamera.transform.localPosition
				local var_304_4 = Vector3.New(0, 0, 10) + Vector3.New(var_304_3.x, var_304_3.y, 0)
				local var_304_5 = arg_301_1.bgs_.I26f

				var_304_5.transform.localPosition = var_304_4
				var_304_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_304_6 = var_304_5:GetComponent("SpriteRenderer")

				if var_304_6 and var_304_6.sprite then
					local var_304_7 = (var_304_5.transform.localPosition - var_304_3).z
					local var_304_8 = manager.ui.mainCameraCom_
					local var_304_9 = 2 * var_304_7 * Mathf.Tan(var_304_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_304_10 = var_304_9 * var_304_8.aspect
					local var_304_11 = var_304_6.sprite.bounds.size.x
					local var_304_12 = var_304_6.sprite.bounds.size.y
					local var_304_13 = var_304_10 / var_304_11
					local var_304_14 = var_304_9 / var_304_12
					local var_304_15 = var_304_14 < var_304_13 and var_304_13 or var_304_14

					var_304_5.transform.localScale = Vector3.New(var_304_15, var_304_15, 0)
				end

				for iter_304_0, iter_304_1 in pairs(arg_301_1.bgs_) do
					if iter_304_0 ~= "I26f" then
						iter_304_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_304_16 = 4

			if var_304_16 < arg_301_1.time_ and arg_301_1.time_ <= var_304_16 + arg_304_0 then
				arg_301_1.allBtn_.enabled = false
			end

			local var_304_17 = 0.3

			if arg_301_1.time_ >= var_304_16 + var_304_17 and arg_301_1.time_ < var_304_16 + var_304_17 + arg_304_0 then
				arg_301_1.allBtn_.enabled = true
			end

			local var_304_18 = 0

			if var_304_18 < arg_301_1.time_ and arg_301_1.time_ <= var_304_18 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_19 = 2

			if var_304_18 <= arg_301_1.time_ and arg_301_1.time_ < var_304_18 + var_304_19 then
				local var_304_20 = (arg_301_1.time_ - var_304_18) / var_304_19
				local var_304_21 = Color.New(0, 0, 0)

				var_304_21.a = Mathf.Lerp(0, 1, var_304_20)
				arg_301_1.mask_.color = var_304_21
			end

			if arg_301_1.time_ >= var_304_18 + var_304_19 and arg_301_1.time_ < var_304_18 + var_304_19 + arg_304_0 then
				local var_304_22 = Color.New(0, 0, 0)

				var_304_22.a = 1
				arg_301_1.mask_.color = var_304_22
			end

			local var_304_23 = 2

			if var_304_23 < arg_301_1.time_ and arg_301_1.time_ <= var_304_23 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_24 = 2

			if var_304_23 <= arg_301_1.time_ and arg_301_1.time_ < var_304_23 + var_304_24 then
				local var_304_25 = (arg_301_1.time_ - var_304_23) / var_304_24
				local var_304_26 = Color.New(0, 0, 0)

				var_304_26.a = Mathf.Lerp(1, 0, var_304_25)
				arg_301_1.mask_.color = var_304_26
			end

			if arg_301_1.time_ >= var_304_23 + var_304_24 and arg_301_1.time_ < var_304_23 + var_304_24 + arg_304_0 then
				local var_304_27 = Color.New(0, 0, 0)
				local var_304_28 = 0

				arg_301_1.mask_.enabled = false
				var_304_27.a = var_304_28
				arg_301_1.mask_.color = var_304_27
			end

			local var_304_29 = arg_301_1.actors_["10146"]
			local var_304_30 = 1.966

			if var_304_30 < arg_301_1.time_ and arg_301_1.time_ <= var_304_30 + arg_304_0 and not isNil(var_304_29) and arg_301_1.var_.actorSpriteComps10146 == nil then
				arg_301_1.var_.actorSpriteComps10146 = var_304_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_31 = 0.034

			if var_304_30 <= arg_301_1.time_ and arg_301_1.time_ < var_304_30 + var_304_31 and not isNil(var_304_29) then
				local var_304_32 = (arg_301_1.time_ - var_304_30) / var_304_31

				if arg_301_1.var_.actorSpriteComps10146 then
					for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_304_3 then
							if arg_301_1.isInRecall_ then
								local var_304_33 = Mathf.Lerp(iter_304_3.color.r, arg_301_1.hightColor2.r, var_304_32)
								local var_304_34 = Mathf.Lerp(iter_304_3.color.g, arg_301_1.hightColor2.g, var_304_32)
								local var_304_35 = Mathf.Lerp(iter_304_3.color.b, arg_301_1.hightColor2.b, var_304_32)

								iter_304_3.color = Color.New(var_304_33, var_304_34, var_304_35)
							else
								local var_304_36 = Mathf.Lerp(iter_304_3.color.r, 0.5, var_304_32)

								iter_304_3.color = Color.New(var_304_36, var_304_36, var_304_36)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_30 + var_304_31 and arg_301_1.time_ < var_304_30 + var_304_31 + arg_304_0 and not isNil(var_304_29) and arg_301_1.var_.actorSpriteComps10146 then
				for iter_304_4, iter_304_5 in pairs(arg_301_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_304_5 then
						if arg_301_1.isInRecall_ then
							iter_304_5.color = arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_304_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps10146 = nil
			end

			local var_304_37 = arg_301_1.actors_["10146"].transform
			local var_304_38 = 1.966

			if var_304_38 < arg_301_1.time_ and arg_301_1.time_ <= var_304_38 + arg_304_0 then
				arg_301_1.var_.moveOldPos10146 = var_304_37.localPosition
				var_304_37.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10146", 7)

				local var_304_39 = var_304_37.childCount

				for iter_304_6 = 0, var_304_39 - 1 do
					local var_304_40 = var_304_37:GetChild(iter_304_6)

					if var_304_40.name == "" or not string.find(var_304_40.name, "split") then
						var_304_40.gameObject:SetActive(true)
					else
						var_304_40.gameObject:SetActive(false)
					end
				end
			end

			local var_304_41 = 0.001

			if var_304_38 <= arg_301_1.time_ and arg_301_1.time_ < var_304_38 + var_304_41 then
				local var_304_42 = (arg_301_1.time_ - var_304_38) / var_304_41
				local var_304_43 = Vector3.New(0, -2000, 0)

				var_304_37.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10146, var_304_43, var_304_42)
			end

			if arg_301_1.time_ >= var_304_38 + var_304_41 and arg_301_1.time_ < var_304_38 + var_304_41 + arg_304_0 then
				var_304_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_304_44 = 0.166666666666667
			local var_304_45 = 1

			if var_304_44 < arg_301_1.time_ and arg_301_1.time_ <= var_304_44 + arg_304_0 then
				local var_304_46 = "stop"
				local var_304_47 = "effect"

				arg_301_1:AudioAction(var_304_46, var_304_47, "se_story_144", "se_story_144_amb_town_loop", "")
			end

			local var_304_48 = 1.56666666666667
			local var_304_49 = 1

			if var_304_48 < arg_301_1.time_ and arg_301_1.time_ <= var_304_48 + arg_304_0 then
				local var_304_50 = "play"
				local var_304_51 = "effect"

				arg_301_1:AudioAction(var_304_50, var_304_51, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_301_1.frameCnt_ <= 1 then
				arg_301_1.dialog_:SetActive(false)
			end

			local var_304_52 = 4
			local var_304_53 = 1.625

			if var_304_52 < arg_301_1.time_ and arg_301_1.time_ <= var_304_52 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0

				arg_301_1.dialog_:SetActive(true)

				arg_301_1.dialogCg_.alpha = 0

				local var_304_54 = LeanTween.value(arg_301_1.dialog_, 0, 1, 0.3)

				var_304_54:setOnUpdate(LuaHelper.FloatAction(function(arg_305_0)
					arg_301_1.dialogCg_.alpha = arg_305_0
				end))
				var_304_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_301_1.dialog_)
					var_304_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_301_1.duration_ = arg_301_1.duration_ + 0.3

				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_55 = arg_301_1:GetWordFromCfg(423041070)
				local var_304_56 = arg_301_1:FormatText(var_304_55.content)

				arg_301_1.text_.text = var_304_56

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_57 = 65
				local var_304_58 = utf8.len(var_304_56)
				local var_304_59 = var_304_57 <= 0 and var_304_53 or var_304_53 * (var_304_58 / var_304_57)

				if var_304_59 > 0 and var_304_53 < var_304_59 then
					arg_301_1.talkMaxDuration = var_304_59
					var_304_52 = var_304_52 + 0.3

					if var_304_59 + var_304_52 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_59 + var_304_52
					end
				end

				arg_301_1.text_.text = var_304_56
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_60 = var_304_52 + 0.3
			local var_304_61 = math.max(var_304_53, arg_301_1.talkMaxDuration)

			if var_304_60 <= arg_301_1.time_ and arg_301_1.time_ < var_304_60 + var_304_61 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_60) / var_304_61

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_60 + var_304_61 and arg_301_1.time_ < var_304_60 + var_304_61 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play423041071 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 423041071
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play423041072(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.833333333333333
			local var_310_1 = 1

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				local var_310_2 = "play"
				local var_310_3 = "effect"

				arg_307_1:AudioAction(var_310_2, var_310_3, "se_story_1310", "se_story_1310_clap", "")
			end

			local var_310_4 = 0
			local var_310_5 = 0.925

			if var_310_4 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_6 = arg_307_1:GetWordFromCfg(423041071)
				local var_310_7 = arg_307_1:FormatText(var_310_6.content)

				arg_307_1.text_.text = var_310_7

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_8 = 37
				local var_310_9 = utf8.len(var_310_7)
				local var_310_10 = var_310_8 <= 0 and var_310_5 or var_310_5 * (var_310_9 / var_310_8)

				if var_310_10 > 0 and var_310_5 < var_310_10 then
					arg_307_1.talkMaxDuration = var_310_10

					if var_310_10 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_4
					end
				end

				arg_307_1.text_.text = var_310_7
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_11 = math.max(var_310_5, arg_307_1.talkMaxDuration)

			if var_310_4 <= arg_307_1.time_ and arg_307_1.time_ < var_310_4 + var_310_11 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_4) / var_310_11

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_4 + var_310_11 and arg_307_1.time_ < var_310_4 + var_310_11 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play423041072 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 423041072
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play423041073(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.275

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_2 = arg_311_1:FormatText(StoryNameCfg[7].name)

				arg_311_1.leftNameTxt_.text = var_314_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:GetWordFromCfg(423041072)
				local var_314_4 = arg_311_1:FormatText(var_314_3.content)

				arg_311_1.text_.text = var_314_4

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 11
				local var_314_6 = utf8.len(var_314_4)
				local var_314_7 = var_314_5 <= 0 and var_314_1 or var_314_1 * (var_314_6 / var_314_5)

				if var_314_7 > 0 and var_314_1 < var_314_7 then
					arg_311_1.talkMaxDuration = var_314_7

					if var_314_7 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_7 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_4
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_8 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_8 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_8

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_8 and arg_311_1.time_ < var_314_0 + var_314_8 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play423041073 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 423041073
		arg_315_1.duration_ = 8.17

		local var_315_0 = {
			zh = 6,
			ja = 8.166
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play423041074(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["10148"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps10148 == nil then
				arg_315_1.var_.actorSpriteComps10148 = var_318_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_2 = 0.2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.actorSpriteComps10148 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								local var_318_4 = Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor1.r, var_318_3)
								local var_318_5 = Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor1.g, var_318_3)
								local var_318_6 = Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor1.b, var_318_3)

								iter_318_1.color = Color.New(var_318_4, var_318_5, var_318_6)
							else
								local var_318_7 = Mathf.Lerp(iter_318_1.color.r, 1, var_318_3)

								iter_318_1.color = Color.New(var_318_7, var_318_7, var_318_7)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps10148 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_318_3 then
						if arg_315_1.isInRecall_ then
							iter_318_3.color = arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_318_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps10148 = nil
			end

			local var_318_8 = arg_315_1.actors_["10148"].transform
			local var_318_9 = 0

			if var_318_9 < arg_315_1.time_ and arg_315_1.time_ <= var_318_9 + arg_318_0 then
				arg_315_1.var_.moveOldPos10148 = var_318_8.localPosition
				var_318_8.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("10148", 3)

				local var_318_10 = var_318_8.childCount

				for iter_318_4 = 0, var_318_10 - 1 do
					local var_318_11 = var_318_8:GetChild(iter_318_4)

					if var_318_11.name == "split_4" or not string.find(var_318_11.name, "split") then
						var_318_11.gameObject:SetActive(true)
					else
						var_318_11.gameObject:SetActive(false)
					end
				end
			end

			local var_318_12 = 0.001

			if var_318_9 <= arg_315_1.time_ and arg_315_1.time_ < var_318_9 + var_318_12 then
				local var_318_13 = (arg_315_1.time_ - var_318_9) / var_318_12
				local var_318_14 = Vector3.New(0, -350, -270)

				var_318_8.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos10148, var_318_14, var_318_13)
			end

			if arg_315_1.time_ >= var_318_9 + var_318_12 and arg_315_1.time_ < var_318_9 + var_318_12 + arg_318_0 then
				var_318_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_318_15 = 0
			local var_318_16 = 0.7

			if var_318_15 < arg_315_1.time_ and arg_315_1.time_ <= var_318_15 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_17 = arg_315_1:FormatText(StoryNameCfg[1331].name)

				arg_315_1.leftNameTxt_.text = var_318_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_18 = arg_315_1:GetWordFromCfg(423041073)
				local var_318_19 = arg_315_1:FormatText(var_318_18.content)

				arg_315_1.text_.text = var_318_19

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_20 = 28
				local var_318_21 = utf8.len(var_318_19)
				local var_318_22 = var_318_20 <= 0 and var_318_16 or var_318_16 * (var_318_21 / var_318_20)

				if var_318_22 > 0 and var_318_16 < var_318_22 then
					arg_315_1.talkMaxDuration = var_318_22

					if var_318_22 + var_318_15 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_22 + var_318_15
					end
				end

				arg_315_1.text_.text = var_318_19
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041073", "story_v_out_423041.awb") ~= 0 then
					local var_318_23 = manager.audio:GetVoiceLength("story_v_out_423041", "423041073", "story_v_out_423041.awb") / 1000

					if var_318_23 + var_318_15 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_23 + var_318_15
					end

					if var_318_18.prefab_name ~= "" and arg_315_1.actors_[var_318_18.prefab_name] ~= nil then
						local var_318_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_18.prefab_name].transform, "story_v_out_423041", "423041073", "story_v_out_423041.awb")

						arg_315_1:RecordAudio("423041073", var_318_24)
						arg_315_1:RecordAudio("423041073", var_318_24)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_423041", "423041073", "story_v_out_423041.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_423041", "423041073", "story_v_out_423041.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_25 = math.max(var_318_16, arg_315_1.talkMaxDuration)

			if var_318_15 <= arg_315_1.time_ and arg_315_1.time_ < var_318_15 + var_318_25 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_15) / var_318_25

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_15 + var_318_25 and arg_315_1.time_ < var_318_15 + var_318_25 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play423041074 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 423041074
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play423041075(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["10148"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10148 == nil then
				arg_319_1.var_.actorSpriteComps10148 = var_322_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_2 = 0.2

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.actorSpriteComps10148 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								local var_322_4 = Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor2.r, var_322_3)
								local var_322_5 = Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor2.g, var_322_3)
								local var_322_6 = Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor2.b, var_322_3)

								iter_322_1.color = Color.New(var_322_4, var_322_5, var_322_6)
							else
								local var_322_7 = Mathf.Lerp(iter_322_1.color.r, 0.5, var_322_3)

								iter_322_1.color = Color.New(var_322_7, var_322_7, var_322_7)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10148 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_322_3 then
						if arg_319_1.isInRecall_ then
							iter_322_3.color = arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_322_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps10148 = nil
			end

			local var_322_8 = 0
			local var_322_9 = 0.65

			if var_322_8 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_10 = arg_319_1:FormatText(StoryNameCfg[7].name)

				arg_319_1.leftNameTxt_.text = var_322_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_11 = arg_319_1:GetWordFromCfg(423041074)
				local var_322_12 = arg_319_1:FormatText(var_322_11.content)

				arg_319_1.text_.text = var_322_12

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_13 = 26
				local var_322_14 = utf8.len(var_322_12)
				local var_322_15 = var_322_13 <= 0 and var_322_9 or var_322_9 * (var_322_14 / var_322_13)

				if var_322_15 > 0 and var_322_9 < var_322_15 then
					arg_319_1.talkMaxDuration = var_322_15

					if var_322_15 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_15 + var_322_8
					end
				end

				arg_319_1.text_.text = var_322_12
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_16 = math.max(var_322_9, arg_319_1.talkMaxDuration)

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_16 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_8) / var_322_16

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_8 + var_322_16 and arg_319_1.time_ < var_322_8 + var_322_16 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play423041075 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 423041075
		arg_323_1.duration_ = 6.23

		local var_323_0 = {
			zh = 4.966,
			ja = 6.233
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play423041076(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10148"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps10148 == nil then
				arg_323_1.var_.actorSpriteComps10148 = var_326_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_2 = 0.2

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.actorSpriteComps10148 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_326_1 then
							if arg_323_1.isInRecall_ then
								local var_326_4 = Mathf.Lerp(iter_326_1.color.r, arg_323_1.hightColor1.r, var_326_3)
								local var_326_5 = Mathf.Lerp(iter_326_1.color.g, arg_323_1.hightColor1.g, var_326_3)
								local var_326_6 = Mathf.Lerp(iter_326_1.color.b, arg_323_1.hightColor1.b, var_326_3)

								iter_326_1.color = Color.New(var_326_4, var_326_5, var_326_6)
							else
								local var_326_7 = Mathf.Lerp(iter_326_1.color.r, 1, var_326_3)

								iter_326_1.color = Color.New(var_326_7, var_326_7, var_326_7)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps10148 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_326_3 then
						if arg_323_1.isInRecall_ then
							iter_326_3.color = arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_326_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps10148 = nil
			end

			local var_326_8 = arg_323_1.actors_["10148"].transform
			local var_326_9 = 0

			if var_326_9 < arg_323_1.time_ and arg_323_1.time_ <= var_326_9 + arg_326_0 then
				arg_323_1.var_.moveOldPos10148 = var_326_8.localPosition
				var_326_8.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10148", 3)

				local var_326_10 = var_326_8.childCount

				for iter_326_4 = 0, var_326_10 - 1 do
					local var_326_11 = var_326_8:GetChild(iter_326_4)

					if var_326_11.name == "split_4" or not string.find(var_326_11.name, "split") then
						var_326_11.gameObject:SetActive(true)
					else
						var_326_11.gameObject:SetActive(false)
					end
				end
			end

			local var_326_12 = 0.001

			if var_326_9 <= arg_323_1.time_ and arg_323_1.time_ < var_326_9 + var_326_12 then
				local var_326_13 = (arg_323_1.time_ - var_326_9) / var_326_12
				local var_326_14 = Vector3.New(0, -350, -270)

				var_326_8.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10148, var_326_14, var_326_13)
			end

			if arg_323_1.time_ >= var_326_9 + var_326_12 and arg_323_1.time_ < var_326_9 + var_326_12 + arg_326_0 then
				var_326_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_326_15 = 0
			local var_326_16 = 0.7

			if var_326_15 < arg_323_1.time_ and arg_323_1.time_ <= var_326_15 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_17 = arg_323_1:FormatText(StoryNameCfg[1331].name)

				arg_323_1.leftNameTxt_.text = var_326_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_18 = arg_323_1:GetWordFromCfg(423041075)
				local var_326_19 = arg_323_1:FormatText(var_326_18.content)

				arg_323_1.text_.text = var_326_19

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_20 = 28
				local var_326_21 = utf8.len(var_326_19)
				local var_326_22 = var_326_20 <= 0 and var_326_16 or var_326_16 * (var_326_21 / var_326_20)

				if var_326_22 > 0 and var_326_16 < var_326_22 then
					arg_323_1.talkMaxDuration = var_326_22

					if var_326_22 + var_326_15 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_22 + var_326_15
					end
				end

				arg_323_1.text_.text = var_326_19
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041075", "story_v_out_423041.awb") ~= 0 then
					local var_326_23 = manager.audio:GetVoiceLength("story_v_out_423041", "423041075", "story_v_out_423041.awb") / 1000

					if var_326_23 + var_326_15 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_23 + var_326_15
					end

					if var_326_18.prefab_name ~= "" and arg_323_1.actors_[var_326_18.prefab_name] ~= nil then
						local var_326_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_18.prefab_name].transform, "story_v_out_423041", "423041075", "story_v_out_423041.awb")

						arg_323_1:RecordAudio("423041075", var_326_24)
						arg_323_1:RecordAudio("423041075", var_326_24)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_423041", "423041075", "story_v_out_423041.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_423041", "423041075", "story_v_out_423041.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_25 = math.max(var_326_16, arg_323_1.talkMaxDuration)

			if var_326_15 <= arg_323_1.time_ and arg_323_1.time_ < var_326_15 + var_326_25 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_15) / var_326_25

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_15 + var_326_25 and arg_323_1.time_ < var_326_15 + var_326_25 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play423041076 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 423041076
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play423041077(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["10148"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps10148 == nil then
				arg_327_1.var_.actorSpriteComps10148 = var_330_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_2 = 0.2

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.actorSpriteComps10148 then
					for iter_330_0, iter_330_1 in pairs(arg_327_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_330_1 then
							if arg_327_1.isInRecall_ then
								local var_330_4 = Mathf.Lerp(iter_330_1.color.r, arg_327_1.hightColor2.r, var_330_3)
								local var_330_5 = Mathf.Lerp(iter_330_1.color.g, arg_327_1.hightColor2.g, var_330_3)
								local var_330_6 = Mathf.Lerp(iter_330_1.color.b, arg_327_1.hightColor2.b, var_330_3)

								iter_330_1.color = Color.New(var_330_4, var_330_5, var_330_6)
							else
								local var_330_7 = Mathf.Lerp(iter_330_1.color.r, 0.5, var_330_3)

								iter_330_1.color = Color.New(var_330_7, var_330_7, var_330_7)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps10148 then
				for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_330_3 then
						if arg_327_1.isInRecall_ then
							iter_330_3.color = arg_327_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_330_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps10148 = nil
			end

			local var_330_8 = arg_327_1.actors_["10148"].transform
			local var_330_9 = 0

			if var_330_9 < arg_327_1.time_ and arg_327_1.time_ <= var_330_9 + arg_330_0 then
				arg_327_1.var_.moveOldPos10148 = var_330_8.localPosition
				var_330_8.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("10148", 7)

				local var_330_10 = var_330_8.childCount

				for iter_330_4 = 0, var_330_10 - 1 do
					local var_330_11 = var_330_8:GetChild(iter_330_4)

					if var_330_11.name == "" or not string.find(var_330_11.name, "split") then
						var_330_11.gameObject:SetActive(true)
					else
						var_330_11.gameObject:SetActive(false)
					end
				end
			end

			local var_330_12 = 0.001

			if var_330_9 <= arg_327_1.time_ and arg_327_1.time_ < var_330_9 + var_330_12 then
				local var_330_13 = (arg_327_1.time_ - var_330_9) / var_330_12
				local var_330_14 = Vector3.New(0, -2000, 0)

				var_330_8.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10148, var_330_14, var_330_13)
			end

			if arg_327_1.time_ >= var_330_9 + var_330_12 and arg_327_1.time_ < var_330_9 + var_330_12 + arg_330_0 then
				var_330_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_330_15 = 1.2
			local var_330_16 = 1

			if var_330_15 < arg_327_1.time_ and arg_327_1.time_ <= var_330_15 + arg_330_0 then
				local var_330_17 = "play"
				local var_330_18 = "effect"

				arg_327_1:AudioAction(var_330_17, var_330_18, "se_story_140", "se_story_140_foley_hug", "")
			end

			local var_330_19 = 0
			local var_330_20 = 1.4

			if var_330_19 < arg_327_1.time_ and arg_327_1.time_ <= var_330_19 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_21 = arg_327_1:GetWordFromCfg(423041076)
				local var_330_22 = arg_327_1:FormatText(var_330_21.content)

				arg_327_1.text_.text = var_330_22

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_23 = 56
				local var_330_24 = utf8.len(var_330_22)
				local var_330_25 = var_330_23 <= 0 and var_330_20 or var_330_20 * (var_330_24 / var_330_23)

				if var_330_25 > 0 and var_330_20 < var_330_25 then
					arg_327_1.talkMaxDuration = var_330_25

					if var_330_25 + var_330_19 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_25 + var_330_19
					end
				end

				arg_327_1.text_.text = var_330_22
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_26 = math.max(var_330_20, arg_327_1.talkMaxDuration)

			if var_330_19 <= arg_327_1.time_ and arg_327_1.time_ < var_330_19 + var_330_26 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_19) / var_330_26

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_19 + var_330_26 and arg_327_1.time_ < var_330_19 + var_330_26 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play423041077 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 423041077
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play423041078(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 1.26666666666667
			local var_334_1 = 1

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				local var_334_2 = "play"
				local var_334_3 = "effect"

				arg_331_1:AudioAction(var_334_2, var_334_3, "se_story_1311", "se_story_1311_gun01", "")
			end

			local var_334_4 = 0
			local var_334_5 = 1.375

			if var_334_4 < arg_331_1.time_ and arg_331_1.time_ <= var_334_4 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_6 = arg_331_1:GetWordFromCfg(423041077)
				local var_334_7 = arg_331_1:FormatText(var_334_6.content)

				arg_331_1.text_.text = var_334_7

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_8 = 55
				local var_334_9 = utf8.len(var_334_7)
				local var_334_10 = var_334_8 <= 0 and var_334_5 or var_334_5 * (var_334_9 / var_334_8)

				if var_334_10 > 0 and var_334_5 < var_334_10 then
					arg_331_1.talkMaxDuration = var_334_10

					if var_334_10 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_10 + var_334_4
					end
				end

				arg_331_1.text_.text = var_334_7
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_11 = math.max(var_334_5, arg_331_1.talkMaxDuration)

			if var_334_4 <= arg_331_1.time_ and arg_331_1.time_ < var_334_4 + var_334_11 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_4) / var_334_11

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_4 + var_334_11 and arg_331_1.time_ < var_334_4 + var_334_11 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play423041078 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 423041078
		arg_335_1.duration_ = 10

		local var_335_0 = {
			zh = 10,
			ja = 6.133
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play423041079(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 0.475

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_2 = arg_335_1:FormatText(StoryNameCfg[1336].name)

				arg_335_1.leftNameTxt_.text = var_338_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_3 = arg_335_1:GetWordFromCfg(423041078)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 19
				local var_338_6 = utf8.len(var_338_4)
				local var_338_7 = var_338_5 <= 0 and var_338_1 or var_338_1 * (var_338_6 / var_338_5)

				if var_338_7 > 0 and var_338_1 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_4
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041078", "story_v_out_423041.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041078", "story_v_out_423041.awb") / 1000

					if var_338_8 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_0
					end

					if var_338_3.prefab_name ~= "" and arg_335_1.actors_[var_338_3.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_3.prefab_name].transform, "story_v_out_423041", "423041078", "story_v_out_423041.awb")

						arg_335_1:RecordAudio("423041078", var_338_9)
						arg_335_1:RecordAudio("423041078", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_423041", "423041078", "story_v_out_423041.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_423041", "423041078", "story_v_out_423041.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_10 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_10 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_10

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_10 and arg_335_1.time_ < var_338_0 + var_338_10 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play423041079 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 423041079
		arg_339_1.duration_ = 5.67

		local var_339_0 = {
			zh = 4.466,
			ja = 5.666
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play423041080(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0
			local var_342_1 = 0.55

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_2 = arg_339_1:FormatText(StoryNameCfg[1336].name)

				arg_339_1.leftNameTxt_.text = var_342_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_3 = arg_339_1:GetWordFromCfg(423041079)
				local var_342_4 = arg_339_1:FormatText(var_342_3.content)

				arg_339_1.text_.text = var_342_4

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 22
				local var_342_6 = utf8.len(var_342_4)
				local var_342_7 = var_342_5 <= 0 and var_342_1 or var_342_1 * (var_342_6 / var_342_5)

				if var_342_7 > 0 and var_342_1 < var_342_7 then
					arg_339_1.talkMaxDuration = var_342_7

					if var_342_7 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_0
					end
				end

				arg_339_1.text_.text = var_342_4
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041079", "story_v_out_423041.awb") ~= 0 then
					local var_342_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041079", "story_v_out_423041.awb") / 1000

					if var_342_8 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_0
					end

					if var_342_3.prefab_name ~= "" and arg_339_1.actors_[var_342_3.prefab_name] ~= nil then
						local var_342_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_3.prefab_name].transform, "story_v_out_423041", "423041079", "story_v_out_423041.awb")

						arg_339_1:RecordAudio("423041079", var_342_9)
						arg_339_1:RecordAudio("423041079", var_342_9)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_423041", "423041079", "story_v_out_423041.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_423041", "423041079", "story_v_out_423041.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_10 = math.max(var_342_1, arg_339_1.talkMaxDuration)

			if var_342_0 <= arg_339_1.time_ and arg_339_1.time_ < var_342_0 + var_342_10 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_0) / var_342_10

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_0 + var_342_10 and arg_339_1.time_ < var_342_0 + var_342_10 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play423041080 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 423041080
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play423041081(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 0.175

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_2 = arg_343_1:FormatText(StoryNameCfg[7].name)

				arg_343_1.leftNameTxt_.text = var_346_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_3 = arg_343_1:GetWordFromCfg(423041080)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 7
				local var_346_6 = utf8.len(var_346_4)
				local var_346_7 = var_346_5 <= 0 and var_346_1 or var_346_1 * (var_346_6 / var_346_5)

				if var_346_7 > 0 and var_346_1 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_8 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_8 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_8

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_8 and arg_343_1.time_ < var_346_0 + var_346_8 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play423041081 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 423041081
		arg_347_1.duration_ = 6.03

		local var_347_0 = {
			zh = 5.966,
			ja = 6.033
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play423041082(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0
			local var_350_1 = 0.45

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_2 = arg_347_1:FormatText(StoryNameCfg[1336].name)

				arg_347_1.leftNameTxt_.text = var_350_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_3 = arg_347_1:GetWordFromCfg(423041081)
				local var_350_4 = arg_347_1:FormatText(var_350_3.content)

				arg_347_1.text_.text = var_350_4

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 18
				local var_350_6 = utf8.len(var_350_4)
				local var_350_7 = var_350_5 <= 0 and var_350_1 or var_350_1 * (var_350_6 / var_350_5)

				if var_350_7 > 0 and var_350_1 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_0
					end
				end

				arg_347_1.text_.text = var_350_4
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041081", "story_v_out_423041.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041081", "story_v_out_423041.awb") / 1000

					if var_350_8 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_0
					end

					if var_350_3.prefab_name ~= "" and arg_347_1.actors_[var_350_3.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_3.prefab_name].transform, "story_v_out_423041", "423041081", "story_v_out_423041.awb")

						arg_347_1:RecordAudio("423041081", var_350_9)
						arg_347_1:RecordAudio("423041081", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_423041", "423041081", "story_v_out_423041.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_423041", "423041081", "story_v_out_423041.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_1, arg_347_1.talkMaxDuration)

			if var_350_0 <= arg_347_1.time_ and arg_347_1.time_ < var_350_0 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_0) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_0 + var_350_10 and arg_347_1.time_ < var_350_0 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play423041082 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 423041082
		arg_351_1.duration_ = 5.7

		local var_351_0 = {
			zh = 5.7,
			ja = 2.2
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play423041083(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0
			local var_354_1 = 0.475

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_2 = arg_351_1:FormatText(StoryNameCfg[1336].name)

				arg_351_1.leftNameTxt_.text = var_354_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:GetWordFromCfg(423041082)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 19
				local var_354_6 = utf8.len(var_354_4)
				local var_354_7 = var_354_5 <= 0 and var_354_1 or var_354_1 * (var_354_6 / var_354_5)

				if var_354_7 > 0 and var_354_1 < var_354_7 then
					arg_351_1.talkMaxDuration = var_354_7

					if var_354_7 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041082", "story_v_out_423041.awb") ~= 0 then
					local var_354_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041082", "story_v_out_423041.awb") / 1000

					if var_354_8 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_8 + var_354_0
					end

					if var_354_3.prefab_name ~= "" and arg_351_1.actors_[var_354_3.prefab_name] ~= nil then
						local var_354_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_3.prefab_name].transform, "story_v_out_423041", "423041082", "story_v_out_423041.awb")

						arg_351_1:RecordAudio("423041082", var_354_9)
						arg_351_1:RecordAudio("423041082", var_354_9)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_423041", "423041082", "story_v_out_423041.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_423041", "423041082", "story_v_out_423041.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_10 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_10 and arg_351_1.time_ < var_354_0 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play423041083 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 423041083
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play423041084(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0
			local var_358_1 = 1.025

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_2 = arg_355_1:GetWordFromCfg(423041083)
				local var_358_3 = arg_355_1:FormatText(var_358_2.content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 41
				local var_358_5 = utf8.len(var_358_3)
				local var_358_6 = var_358_4 <= 0 and var_358_1 or var_358_1 * (var_358_5 / var_358_4)

				if var_358_6 > 0 and var_358_1 < var_358_6 then
					arg_355_1.talkMaxDuration = var_358_6

					if var_358_6 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_6 + var_358_0
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_1, arg_355_1.talkMaxDuration)

			if var_358_0 <= arg_355_1.time_ and arg_355_1.time_ < var_358_0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_0 + var_358_7 and arg_355_1.time_ < var_358_0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play423041084 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 423041084
		arg_359_1.duration_ = 5.4

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play423041085(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = manager.ui.mainCamera.transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.shakeOldPos = var_362_0.localPosition
			end

			local var_362_2 = 0.6

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / 0.066
				local var_362_4, var_362_5 = math.modf(var_362_3)

				var_362_0.localPosition = Vector3.New(var_362_5 * 0.13, var_362_5 * 0.13, var_362_5 * 0.13) + arg_359_1.var_.shakeOldPos
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 then
				var_362_0.localPosition = arg_359_1.var_.shakeOldPos
			end

			local var_362_6 = 0

			if var_362_6 < arg_359_1.time_ and arg_359_1.time_ <= var_362_6 + arg_362_0 then
				arg_359_1.allBtn_.enabled = false
			end

			local var_362_7 = 0.6

			if arg_359_1.time_ >= var_362_6 + var_362_7 and arg_359_1.time_ < var_362_6 + var_362_7 + arg_362_0 then
				arg_359_1.allBtn_.enabled = true
			end

			local var_362_8 = 0
			local var_362_9 = 1

			if var_362_8 < arg_359_1.time_ and arg_359_1.time_ <= var_362_8 + arg_362_0 then
				local var_362_10 = "play"
				local var_362_11 = "effect"

				arg_359_1:AudioAction(var_362_10, var_362_11, "se_story_144", "se_story_144_gun", "")
			end

			if arg_359_1.frameCnt_ <= 1 then
				arg_359_1.dialog_:SetActive(false)
			end

			local var_362_12 = 0.4
			local var_362_13 = 1.6

			if var_362_12 < arg_359_1.time_ and arg_359_1.time_ <= var_362_12 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0

				arg_359_1.dialog_:SetActive(true)

				arg_359_1.dialogCg_.alpha = 0

				local var_362_14 = LeanTween.value(arg_359_1.dialog_, 0, 1, 0.3)

				var_362_14:setOnUpdate(LuaHelper.FloatAction(function(arg_363_0)
					arg_359_1.dialogCg_.alpha = arg_363_0
				end))
				var_362_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_359_1.dialog_)
					var_362_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_359_1.duration_ = arg_359_1.duration_ + 0.3

				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_15 = arg_359_1:GetWordFromCfg(423041084)
				local var_362_16 = arg_359_1:FormatText(var_362_15.content)

				arg_359_1.text_.text = var_362_16

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_17 = 64
				local var_362_18 = utf8.len(var_362_16)
				local var_362_19 = var_362_17 <= 0 and var_362_13 or var_362_13 * (var_362_18 / var_362_17)

				if var_362_19 > 0 and var_362_13 < var_362_19 then
					arg_359_1.talkMaxDuration = var_362_19
					var_362_12 = var_362_12 + 0.3

					if var_362_19 + var_362_12 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_19 + var_362_12
					end
				end

				arg_359_1.text_.text = var_362_16
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_20 = var_362_12 + 0.3
			local var_362_21 = math.max(var_362_13, arg_359_1.talkMaxDuration)

			if var_362_20 <= arg_359_1.time_ and arg_359_1.time_ < var_362_20 + var_362_21 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_20) / var_362_21

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_20 + var_362_21 and arg_359_1.time_ < var_362_20 + var_362_21 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play423041085 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 423041085
		arg_365_1.duration_ = 6.27

		local var_365_0 = {
			zh = 6.266,
			ja = 3.8
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play423041086(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.55

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[1336].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:GetWordFromCfg(423041085)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 22
				local var_368_6 = utf8.len(var_368_4)
				local var_368_7 = var_368_5 <= 0 and var_368_1 or var_368_1 * (var_368_6 / var_368_5)

				if var_368_7 > 0 and var_368_1 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041085", "story_v_out_423041.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041085", "story_v_out_423041.awb") / 1000

					if var_368_8 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_0
					end

					if var_368_3.prefab_name ~= "" and arg_365_1.actors_[var_368_3.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_3.prefab_name].transform, "story_v_out_423041", "423041085", "story_v_out_423041.awb")

						arg_365_1:RecordAudio("423041085", var_368_9)
						arg_365_1:RecordAudio("423041085", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_423041", "423041085", "story_v_out_423041.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_423041", "423041085", "story_v_out_423041.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_10 and arg_365_1.time_ < var_368_0 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play423041086 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 423041086
		arg_369_1.duration_ = 7.67

		local var_369_0 = {
			zh = 7.666,
			ja = 6.766
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play423041087(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = "1083"

			if arg_369_1.actors_[var_372_0] == nil then
				local var_372_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_372_1) then
					local var_372_2 = Object.Instantiate(var_372_1, arg_369_1.canvasGo_.transform)

					var_372_2.transform:SetSiblingIndex(1)

					var_372_2.name = var_372_0
					var_372_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_369_1.actors_[var_372_0] = var_372_2

					local var_372_3 = var_372_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_369_1.isInRecall_ then
						for iter_372_0, iter_372_1 in ipairs(var_372_3) do
							iter_372_1.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_372_4 = arg_369_1.actors_["1083"]
			local var_372_5 = 0

			if var_372_5 < arg_369_1.time_ and arg_369_1.time_ <= var_372_5 + arg_372_0 and not isNil(var_372_4) and arg_369_1.var_.actorSpriteComps1083 == nil then
				arg_369_1.var_.actorSpriteComps1083 = var_372_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_6 = 0.2

			if var_372_5 <= arg_369_1.time_ and arg_369_1.time_ < var_372_5 + var_372_6 and not isNil(var_372_4) then
				local var_372_7 = (arg_369_1.time_ - var_372_5) / var_372_6

				if arg_369_1.var_.actorSpriteComps1083 then
					for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_372_3 then
							if arg_369_1.isInRecall_ then
								local var_372_8 = Mathf.Lerp(iter_372_3.color.r, arg_369_1.hightColor1.r, var_372_7)
								local var_372_9 = Mathf.Lerp(iter_372_3.color.g, arg_369_1.hightColor1.g, var_372_7)
								local var_372_10 = Mathf.Lerp(iter_372_3.color.b, arg_369_1.hightColor1.b, var_372_7)

								iter_372_3.color = Color.New(var_372_8, var_372_9, var_372_10)
							else
								local var_372_11 = Mathf.Lerp(iter_372_3.color.r, 1, var_372_7)

								iter_372_3.color = Color.New(var_372_11, var_372_11, var_372_11)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_5 + var_372_6 and arg_369_1.time_ < var_372_5 + var_372_6 + arg_372_0 and not isNil(var_372_4) and arg_369_1.var_.actorSpriteComps1083 then
				for iter_372_4, iter_372_5 in pairs(arg_369_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_372_5 then
						if arg_369_1.isInRecall_ then
							iter_372_5.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_372_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps1083 = nil
			end

			local var_372_12 = arg_369_1.actors_["1083"].transform
			local var_372_13 = 0

			if var_372_13 < arg_369_1.time_ and arg_369_1.time_ <= var_372_13 + arg_372_0 then
				arg_369_1.var_.moveOldPos1083 = var_372_12.localPosition
				var_372_12.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("1083", 3)

				local var_372_14 = var_372_12.childCount

				for iter_372_6 = 0, var_372_14 - 1 do
					local var_372_15 = var_372_12:GetChild(iter_372_6)

					if var_372_15.name == "" or not string.find(var_372_15.name, "split") then
						var_372_15.gameObject:SetActive(true)
					else
						var_372_15.gameObject:SetActive(false)
					end
				end
			end

			local var_372_16 = 0.001

			if var_372_13 <= arg_369_1.time_ and arg_369_1.time_ < var_372_13 + var_372_16 then
				local var_372_17 = (arg_369_1.time_ - var_372_13) / var_372_16
				local var_372_18 = Vector3.New(-50, -345, -345)

				var_372_12.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1083, var_372_18, var_372_17)
			end

			if arg_369_1.time_ >= var_372_13 + var_372_16 and arg_369_1.time_ < var_372_13 + var_372_16 + arg_372_0 then
				var_372_12.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_372_19 = arg_369_1.actors_["1083"]
			local var_372_20 = 0

			if var_372_20 < arg_369_1.time_ and arg_369_1.time_ <= var_372_20 + arg_372_0 then
				local var_372_21 = var_372_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_372_21 then
					arg_369_1.var_.alphaOldValue1083 = var_372_21.alpha
					arg_369_1.var_.characterEffect1083 = var_372_21
				end

				arg_369_1.var_.alphaOldValue1083 = 0
			end

			local var_372_22 = 0.6

			if var_372_20 <= arg_369_1.time_ and arg_369_1.time_ < var_372_20 + var_372_22 then
				local var_372_23 = (arg_369_1.time_ - var_372_20) / var_372_22
				local var_372_24 = Mathf.Lerp(arg_369_1.var_.alphaOldValue1083, 1, var_372_23)

				if arg_369_1.var_.characterEffect1083 then
					arg_369_1.var_.characterEffect1083.alpha = var_372_24
				end
			end

			if arg_369_1.time_ >= var_372_20 + var_372_22 and arg_369_1.time_ < var_372_20 + var_372_22 + arg_372_0 and arg_369_1.var_.characterEffect1083 then
				arg_369_1.var_.characterEffect1083.alpha = 1
			end

			local var_372_25 = 0
			local var_372_26 = 0.7

			if var_372_25 < arg_369_1.time_ and arg_369_1.time_ <= var_372_25 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0

				arg_369_1.dialog_:SetActive(true)

				arg_369_1.dialogCg_.alpha = 0

				local var_372_27 = LeanTween.value(arg_369_1.dialog_, 0, 1, 0.3)

				var_372_27:setOnUpdate(LuaHelper.FloatAction(function(arg_373_0)
					arg_369_1.dialogCg_.alpha = arg_373_0
				end))
				var_372_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_369_1.dialog_)
					var_372_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_369_1.duration_ = arg_369_1.duration_ + 0.3

				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_28 = arg_369_1:FormatText(StoryNameCfg[1332].name)

				arg_369_1.leftNameTxt_.text = var_372_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_29 = arg_369_1:GetWordFromCfg(423041086)
				local var_372_30 = arg_369_1:FormatText(var_372_29.content)

				arg_369_1.text_.text = var_372_30

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_31 = 28
				local var_372_32 = utf8.len(var_372_30)
				local var_372_33 = var_372_31 <= 0 and var_372_26 or var_372_26 * (var_372_32 / var_372_31)

				if var_372_33 > 0 and var_372_26 < var_372_33 then
					arg_369_1.talkMaxDuration = var_372_33
					var_372_25 = var_372_25 + 0.3

					if var_372_33 + var_372_25 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_33 + var_372_25
					end
				end

				arg_369_1.text_.text = var_372_30
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041086", "story_v_out_423041.awb") ~= 0 then
					local var_372_34 = manager.audio:GetVoiceLength("story_v_out_423041", "423041086", "story_v_out_423041.awb") / 1000

					if var_372_34 + var_372_25 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_34 + var_372_25
					end

					if var_372_29.prefab_name ~= "" and arg_369_1.actors_[var_372_29.prefab_name] ~= nil then
						local var_372_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_29.prefab_name].transform, "story_v_out_423041", "423041086", "story_v_out_423041.awb")

						arg_369_1:RecordAudio("423041086", var_372_35)
						arg_369_1:RecordAudio("423041086", var_372_35)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_423041", "423041086", "story_v_out_423041.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_423041", "423041086", "story_v_out_423041.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_36 = var_372_25 + 0.3
			local var_372_37 = math.max(var_372_26, arg_369_1.talkMaxDuration)

			if var_372_36 <= arg_369_1.time_ and arg_369_1.time_ < var_372_36 + var_372_37 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_36) / var_372_37

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_36 + var_372_37 and arg_369_1.time_ < var_372_36 + var_372_37 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play423041087 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 423041087
		arg_375_1.duration_ = 4.87

		local var_375_0 = {
			zh = 4.866,
			ja = 4.033
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play423041088(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1083"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos1083 = var_378_0.localPosition
				var_378_0.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("1083", 3)

				local var_378_2 = var_378_0.childCount

				for iter_378_0 = 0, var_378_2 - 1 do
					local var_378_3 = var_378_0:GetChild(iter_378_0)

					if var_378_3.name == "" or not string.find(var_378_3.name, "split") then
						var_378_3.gameObject:SetActive(true)
					else
						var_378_3.gameObject:SetActive(false)
					end
				end
			end

			local var_378_4 = 0.001

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_4 then
				local var_378_5 = (arg_375_1.time_ - var_378_1) / var_378_4
				local var_378_6 = Vector3.New(-50, -345, -345)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1083, var_378_6, var_378_5)
			end

			if arg_375_1.time_ >= var_378_1 + var_378_4 and arg_375_1.time_ < var_378_1 + var_378_4 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_378_7 = 0
			local var_378_8 = 0.6

			if var_378_7 < arg_375_1.time_ and arg_375_1.time_ <= var_378_7 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_9 = arg_375_1:FormatText(StoryNameCfg[1332].name)

				arg_375_1.leftNameTxt_.text = var_378_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_10 = arg_375_1:GetWordFromCfg(423041087)
				local var_378_11 = arg_375_1:FormatText(var_378_10.content)

				arg_375_1.text_.text = var_378_11

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_12 = 24
				local var_378_13 = utf8.len(var_378_11)
				local var_378_14 = var_378_12 <= 0 and var_378_8 or var_378_8 * (var_378_13 / var_378_12)

				if var_378_14 > 0 and var_378_8 < var_378_14 then
					arg_375_1.talkMaxDuration = var_378_14

					if var_378_14 + var_378_7 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_14 + var_378_7
					end
				end

				arg_375_1.text_.text = var_378_11
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041087", "story_v_out_423041.awb") ~= 0 then
					local var_378_15 = manager.audio:GetVoiceLength("story_v_out_423041", "423041087", "story_v_out_423041.awb") / 1000

					if var_378_15 + var_378_7 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_15 + var_378_7
					end

					if var_378_10.prefab_name ~= "" and arg_375_1.actors_[var_378_10.prefab_name] ~= nil then
						local var_378_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_10.prefab_name].transform, "story_v_out_423041", "423041087", "story_v_out_423041.awb")

						arg_375_1:RecordAudio("423041087", var_378_16)
						arg_375_1:RecordAudio("423041087", var_378_16)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_423041", "423041087", "story_v_out_423041.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_423041", "423041087", "story_v_out_423041.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_17 = math.max(var_378_8, arg_375_1.talkMaxDuration)

			if var_378_7 <= arg_375_1.time_ and arg_375_1.time_ < var_378_7 + var_378_17 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_7) / var_378_17

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_7 + var_378_17 and arg_375_1.time_ < var_378_7 + var_378_17 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play423041088 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 423041088
		arg_379_1.duration_ = 7.1

		local var_379_0 = {
			zh = 4.433,
			ja = 7.1
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play423041089(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["10148"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.actorSpriteComps10148 == nil then
				arg_379_1.var_.actorSpriteComps10148 = var_382_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_2 = 0.2

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.actorSpriteComps10148 then
					for iter_382_0, iter_382_1 in pairs(arg_379_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_382_1 then
							if arg_379_1.isInRecall_ then
								local var_382_4 = Mathf.Lerp(iter_382_1.color.r, arg_379_1.hightColor1.r, var_382_3)
								local var_382_5 = Mathf.Lerp(iter_382_1.color.g, arg_379_1.hightColor1.g, var_382_3)
								local var_382_6 = Mathf.Lerp(iter_382_1.color.b, arg_379_1.hightColor1.b, var_382_3)

								iter_382_1.color = Color.New(var_382_4, var_382_5, var_382_6)
							else
								local var_382_7 = Mathf.Lerp(iter_382_1.color.r, 1, var_382_3)

								iter_382_1.color = Color.New(var_382_7, var_382_7, var_382_7)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.actorSpriteComps10148 then
				for iter_382_2, iter_382_3 in pairs(arg_379_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_382_3 then
						if arg_379_1.isInRecall_ then
							iter_382_3.color = arg_379_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_382_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_379_1.var_.actorSpriteComps10148 = nil
			end

			local var_382_8 = arg_379_1.actors_["1083"]
			local var_382_9 = 0

			if var_382_9 < arg_379_1.time_ and arg_379_1.time_ <= var_382_9 + arg_382_0 and not isNil(var_382_8) and arg_379_1.var_.actorSpriteComps1083 == nil then
				arg_379_1.var_.actorSpriteComps1083 = var_382_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_10 = 0.2

			if var_382_9 <= arg_379_1.time_ and arg_379_1.time_ < var_382_9 + var_382_10 and not isNil(var_382_8) then
				local var_382_11 = (arg_379_1.time_ - var_382_9) / var_382_10

				if arg_379_1.var_.actorSpriteComps1083 then
					for iter_382_4, iter_382_5 in pairs(arg_379_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_382_5 then
							if arg_379_1.isInRecall_ then
								local var_382_12 = Mathf.Lerp(iter_382_5.color.r, arg_379_1.hightColor2.r, var_382_11)
								local var_382_13 = Mathf.Lerp(iter_382_5.color.g, arg_379_1.hightColor2.g, var_382_11)
								local var_382_14 = Mathf.Lerp(iter_382_5.color.b, arg_379_1.hightColor2.b, var_382_11)

								iter_382_5.color = Color.New(var_382_12, var_382_13, var_382_14)
							else
								local var_382_15 = Mathf.Lerp(iter_382_5.color.r, 0.5, var_382_11)

								iter_382_5.color = Color.New(var_382_15, var_382_15, var_382_15)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= var_382_9 + var_382_10 and arg_379_1.time_ < var_382_9 + var_382_10 + arg_382_0 and not isNil(var_382_8) and arg_379_1.var_.actorSpriteComps1083 then
				for iter_382_6, iter_382_7 in pairs(arg_379_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_382_7 then
						if arg_379_1.isInRecall_ then
							iter_382_7.color = arg_379_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_382_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_379_1.var_.actorSpriteComps1083 = nil
			end

			local var_382_16 = arg_379_1.actors_["10148"].transform
			local var_382_17 = 0

			if var_382_17 < arg_379_1.time_ and arg_379_1.time_ <= var_382_17 + arg_382_0 then
				arg_379_1.var_.moveOldPos10148 = var_382_16.localPosition
				var_382_16.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("10148", 4)

				local var_382_18 = var_382_16.childCount

				for iter_382_8 = 0, var_382_18 - 1 do
					local var_382_19 = var_382_16:GetChild(iter_382_8)

					if var_382_19.name == "split_4" or not string.find(var_382_19.name, "split") then
						var_382_19.gameObject:SetActive(true)
					else
						var_382_19.gameObject:SetActive(false)
					end
				end
			end

			local var_382_20 = 0.001

			if var_382_17 <= arg_379_1.time_ and arg_379_1.time_ < var_382_17 + var_382_20 then
				local var_382_21 = (arg_379_1.time_ - var_382_17) / var_382_20
				local var_382_22 = Vector3.New(390, -350, -270)

				var_382_16.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos10148, var_382_22, var_382_21)
			end

			if arg_379_1.time_ >= var_382_17 + var_382_20 and arg_379_1.time_ < var_382_17 + var_382_20 + arg_382_0 then
				var_382_16.localPosition = Vector3.New(390, -350, -270)
			end

			local var_382_23 = arg_379_1.actors_["1083"].transform
			local var_382_24 = 0

			if var_382_24 < arg_379_1.time_ and arg_379_1.time_ <= var_382_24 + arg_382_0 then
				arg_379_1.var_.moveOldPos1083 = var_382_23.localPosition
				var_382_23.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("1083", 2)

				local var_382_25 = var_382_23.childCount

				for iter_382_9 = 0, var_382_25 - 1 do
					local var_382_26 = var_382_23:GetChild(iter_382_9)

					if var_382_26.name == "" or not string.find(var_382_26.name, "split") then
						var_382_26.gameObject:SetActive(true)
					else
						var_382_26.gameObject:SetActive(false)
					end
				end
			end

			local var_382_27 = 0.001

			if var_382_24 <= arg_379_1.time_ and arg_379_1.time_ < var_382_24 + var_382_27 then
				local var_382_28 = (arg_379_1.time_ - var_382_24) / var_382_27
				local var_382_29 = Vector3.New(-440, -345, -345)

				var_382_23.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1083, var_382_29, var_382_28)
			end

			if arg_379_1.time_ >= var_382_24 + var_382_27 and arg_379_1.time_ < var_382_24 + var_382_27 + arg_382_0 then
				var_382_23.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_382_30 = 0
			local var_382_31 = 0.55

			if var_382_30 < arg_379_1.time_ and arg_379_1.time_ <= var_382_30 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_32 = arg_379_1:FormatText(StoryNameCfg[1331].name)

				arg_379_1.leftNameTxt_.text = var_382_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_33 = arg_379_1:GetWordFromCfg(423041088)
				local var_382_34 = arg_379_1:FormatText(var_382_33.content)

				arg_379_1.text_.text = var_382_34

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_35 = 22
				local var_382_36 = utf8.len(var_382_34)
				local var_382_37 = var_382_35 <= 0 and var_382_31 or var_382_31 * (var_382_36 / var_382_35)

				if var_382_37 > 0 and var_382_31 < var_382_37 then
					arg_379_1.talkMaxDuration = var_382_37

					if var_382_37 + var_382_30 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_37 + var_382_30
					end
				end

				arg_379_1.text_.text = var_382_34
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041088", "story_v_out_423041.awb") ~= 0 then
					local var_382_38 = manager.audio:GetVoiceLength("story_v_out_423041", "423041088", "story_v_out_423041.awb") / 1000

					if var_382_38 + var_382_30 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_38 + var_382_30
					end

					if var_382_33.prefab_name ~= "" and arg_379_1.actors_[var_382_33.prefab_name] ~= nil then
						local var_382_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_33.prefab_name].transform, "story_v_out_423041", "423041088", "story_v_out_423041.awb")

						arg_379_1:RecordAudio("423041088", var_382_39)
						arg_379_1:RecordAudio("423041088", var_382_39)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_423041", "423041088", "story_v_out_423041.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_423041", "423041088", "story_v_out_423041.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_40 = math.max(var_382_31, arg_379_1.talkMaxDuration)

			if var_382_30 <= arg_379_1.time_ and arg_379_1.time_ < var_382_30 + var_382_40 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_30) / var_382_40

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_30 + var_382_40 and arg_379_1.time_ < var_382_30 + var_382_40 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play423041089 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 423041089
		arg_383_1.duration_ = 4.9

		local var_383_0 = {
			zh = 3.8,
			ja = 4.9
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play423041090(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1083"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.actorSpriteComps1083 == nil then
				arg_383_1.var_.actorSpriteComps1083 = var_386_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_2 = 0.2

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.actorSpriteComps1083 then
					for iter_386_0, iter_386_1 in pairs(arg_383_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_386_1 then
							if arg_383_1.isInRecall_ then
								local var_386_4 = Mathf.Lerp(iter_386_1.color.r, arg_383_1.hightColor1.r, var_386_3)
								local var_386_5 = Mathf.Lerp(iter_386_1.color.g, arg_383_1.hightColor1.g, var_386_3)
								local var_386_6 = Mathf.Lerp(iter_386_1.color.b, arg_383_1.hightColor1.b, var_386_3)

								iter_386_1.color = Color.New(var_386_4, var_386_5, var_386_6)
							else
								local var_386_7 = Mathf.Lerp(iter_386_1.color.r, 1, var_386_3)

								iter_386_1.color = Color.New(var_386_7, var_386_7, var_386_7)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.actorSpriteComps1083 then
				for iter_386_2, iter_386_3 in pairs(arg_383_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_386_3 then
						if arg_383_1.isInRecall_ then
							iter_386_3.color = arg_383_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_386_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_383_1.var_.actorSpriteComps1083 = nil
			end

			local var_386_8 = arg_383_1.actors_["10148"]
			local var_386_9 = 0

			if var_386_9 < arg_383_1.time_ and arg_383_1.time_ <= var_386_9 + arg_386_0 and not isNil(var_386_8) and arg_383_1.var_.actorSpriteComps10148 == nil then
				arg_383_1.var_.actorSpriteComps10148 = var_386_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_10 = 0.2

			if var_386_9 <= arg_383_1.time_ and arg_383_1.time_ < var_386_9 + var_386_10 and not isNil(var_386_8) then
				local var_386_11 = (arg_383_1.time_ - var_386_9) / var_386_10

				if arg_383_1.var_.actorSpriteComps10148 then
					for iter_386_4, iter_386_5 in pairs(arg_383_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_386_5 then
							if arg_383_1.isInRecall_ then
								local var_386_12 = Mathf.Lerp(iter_386_5.color.r, arg_383_1.hightColor2.r, var_386_11)
								local var_386_13 = Mathf.Lerp(iter_386_5.color.g, arg_383_1.hightColor2.g, var_386_11)
								local var_386_14 = Mathf.Lerp(iter_386_5.color.b, arg_383_1.hightColor2.b, var_386_11)

								iter_386_5.color = Color.New(var_386_12, var_386_13, var_386_14)
							else
								local var_386_15 = Mathf.Lerp(iter_386_5.color.r, 0.5, var_386_11)

								iter_386_5.color = Color.New(var_386_15, var_386_15, var_386_15)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= var_386_9 + var_386_10 and arg_383_1.time_ < var_386_9 + var_386_10 + arg_386_0 and not isNil(var_386_8) and arg_383_1.var_.actorSpriteComps10148 then
				for iter_386_6, iter_386_7 in pairs(arg_383_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_386_7 then
						if arg_383_1.isInRecall_ then
							iter_386_7.color = arg_383_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_386_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_383_1.var_.actorSpriteComps10148 = nil
			end

			local var_386_16 = arg_383_1.actors_["1083"].transform
			local var_386_17 = 0

			if var_386_17 < arg_383_1.time_ and arg_383_1.time_ <= var_386_17 + arg_386_0 then
				arg_383_1.var_.moveOldPos1083 = var_386_16.localPosition
				var_386_16.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("1083", 2)

				local var_386_18 = var_386_16.childCount

				for iter_386_8 = 0, var_386_18 - 1 do
					local var_386_19 = var_386_16:GetChild(iter_386_8)

					if var_386_19.name == "split_2" or not string.find(var_386_19.name, "split") then
						var_386_19.gameObject:SetActive(true)
					else
						var_386_19.gameObject:SetActive(false)
					end
				end
			end

			local var_386_20 = 0.001

			if var_386_17 <= arg_383_1.time_ and arg_383_1.time_ < var_386_17 + var_386_20 then
				local var_386_21 = (arg_383_1.time_ - var_386_17) / var_386_20
				local var_386_22 = Vector3.New(-440, -345, -345)

				var_386_16.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1083, var_386_22, var_386_21)
			end

			if arg_383_1.time_ >= var_386_17 + var_386_20 and arg_383_1.time_ < var_386_17 + var_386_20 + arg_386_0 then
				var_386_16.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_386_23 = 0
			local var_386_24 = 0.4

			if var_386_23 < arg_383_1.time_ and arg_383_1.time_ <= var_386_23 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_25 = arg_383_1:FormatText(StoryNameCfg[1332].name)

				arg_383_1.leftNameTxt_.text = var_386_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_26 = arg_383_1:GetWordFromCfg(423041089)
				local var_386_27 = arg_383_1:FormatText(var_386_26.content)

				arg_383_1.text_.text = var_386_27

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_28 = 16
				local var_386_29 = utf8.len(var_386_27)
				local var_386_30 = var_386_28 <= 0 and var_386_24 or var_386_24 * (var_386_29 / var_386_28)

				if var_386_30 > 0 and var_386_24 < var_386_30 then
					arg_383_1.talkMaxDuration = var_386_30

					if var_386_30 + var_386_23 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_30 + var_386_23
					end
				end

				arg_383_1.text_.text = var_386_27
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041089", "story_v_out_423041.awb") ~= 0 then
					local var_386_31 = manager.audio:GetVoiceLength("story_v_out_423041", "423041089", "story_v_out_423041.awb") / 1000

					if var_386_31 + var_386_23 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_31 + var_386_23
					end

					if var_386_26.prefab_name ~= "" and arg_383_1.actors_[var_386_26.prefab_name] ~= nil then
						local var_386_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_26.prefab_name].transform, "story_v_out_423041", "423041089", "story_v_out_423041.awb")

						arg_383_1:RecordAudio("423041089", var_386_32)
						arg_383_1:RecordAudio("423041089", var_386_32)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_423041", "423041089", "story_v_out_423041.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_423041", "423041089", "story_v_out_423041.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_33 = math.max(var_386_24, arg_383_1.talkMaxDuration)

			if var_386_23 <= arg_383_1.time_ and arg_383_1.time_ < var_386_23 + var_386_33 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_23) / var_386_33

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_23 + var_386_33 and arg_383_1.time_ < var_386_23 + var_386_33 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play423041090 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 423041090
		arg_387_1.duration_ = 6.53

		local var_387_0 = {
			zh = 5.2,
			ja = 6.533
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play423041091(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["1083"].transform
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.var_.moveOldPos1083 = var_390_0.localPosition
				var_390_0.localScale = Vector3.New(1, 1, 1)

				arg_387_1:CheckSpriteTmpPos("1083", 2)

				local var_390_2 = var_390_0.childCount

				for iter_390_0 = 0, var_390_2 - 1 do
					local var_390_3 = var_390_0:GetChild(iter_390_0)

					if var_390_3.name == "" or not string.find(var_390_3.name, "split") then
						var_390_3.gameObject:SetActive(true)
					else
						var_390_3.gameObject:SetActive(false)
					end
				end
			end

			local var_390_4 = 0.001

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_4 then
				local var_390_5 = (arg_387_1.time_ - var_390_1) / var_390_4
				local var_390_6 = Vector3.New(-440, -345, -345)

				var_390_0.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1083, var_390_6, var_390_5)
			end

			if arg_387_1.time_ >= var_390_1 + var_390_4 and arg_387_1.time_ < var_390_1 + var_390_4 + arg_390_0 then
				var_390_0.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_390_7 = 0
			local var_390_8 = 0.425

			if var_390_7 < arg_387_1.time_ and arg_387_1.time_ <= var_390_7 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_9 = arg_387_1:FormatText(StoryNameCfg[1332].name)

				arg_387_1.leftNameTxt_.text = var_390_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_10 = arg_387_1:GetWordFromCfg(423041090)
				local var_390_11 = arg_387_1:FormatText(var_390_10.content)

				arg_387_1.text_.text = var_390_11

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_12 = 17
				local var_390_13 = utf8.len(var_390_11)
				local var_390_14 = var_390_12 <= 0 and var_390_8 or var_390_8 * (var_390_13 / var_390_12)

				if var_390_14 > 0 and var_390_8 < var_390_14 then
					arg_387_1.talkMaxDuration = var_390_14

					if var_390_14 + var_390_7 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_14 + var_390_7
					end
				end

				arg_387_1.text_.text = var_390_11
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041090", "story_v_out_423041.awb") ~= 0 then
					local var_390_15 = manager.audio:GetVoiceLength("story_v_out_423041", "423041090", "story_v_out_423041.awb") / 1000

					if var_390_15 + var_390_7 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_15 + var_390_7
					end

					if var_390_10.prefab_name ~= "" and arg_387_1.actors_[var_390_10.prefab_name] ~= nil then
						local var_390_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_10.prefab_name].transform, "story_v_out_423041", "423041090", "story_v_out_423041.awb")

						arg_387_1:RecordAudio("423041090", var_390_16)
						arg_387_1:RecordAudio("423041090", var_390_16)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_423041", "423041090", "story_v_out_423041.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_423041", "423041090", "story_v_out_423041.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_17 = math.max(var_390_8, arg_387_1.talkMaxDuration)

			if var_390_7 <= arg_387_1.time_ and arg_387_1.time_ < var_390_7 + var_390_17 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_7) / var_390_17

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_7 + var_390_17 and arg_387_1.time_ < var_390_7 + var_390_17 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play423041091 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 423041091
		arg_391_1.duration_ = 9.13

		local var_391_0 = {
			zh = 6.033,
			ja = 9.133
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play423041092(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1083"].transform
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.var_.moveOldPos1083 = var_394_0.localPosition
				var_394_0.localScale = Vector3.New(1, 1, 1)

				arg_391_1:CheckSpriteTmpPos("1083", 2)

				local var_394_2 = var_394_0.childCount

				for iter_394_0 = 0, var_394_2 - 1 do
					local var_394_3 = var_394_0:GetChild(iter_394_0)

					if var_394_3.name == "" or not string.find(var_394_3.name, "split") then
						var_394_3.gameObject:SetActive(true)
					else
						var_394_3.gameObject:SetActive(false)
					end
				end
			end

			local var_394_4 = 0.001

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_4 then
				local var_394_5 = (arg_391_1.time_ - var_394_1) / var_394_4
				local var_394_6 = Vector3.New(-440, -345, -345)

				var_394_0.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1083, var_394_6, var_394_5)
			end

			if arg_391_1.time_ >= var_394_1 + var_394_4 and arg_391_1.time_ < var_394_1 + var_394_4 + arg_394_0 then
				var_394_0.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_394_7 = 0
			local var_394_8 = 0.675

			if var_394_7 < arg_391_1.time_ and arg_391_1.time_ <= var_394_7 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_9 = arg_391_1:FormatText(StoryNameCfg[1332].name)

				arg_391_1.leftNameTxt_.text = var_394_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_10 = arg_391_1:GetWordFromCfg(423041091)
				local var_394_11 = arg_391_1:FormatText(var_394_10.content)

				arg_391_1.text_.text = var_394_11

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_12 = 27
				local var_394_13 = utf8.len(var_394_11)
				local var_394_14 = var_394_12 <= 0 and var_394_8 or var_394_8 * (var_394_13 / var_394_12)

				if var_394_14 > 0 and var_394_8 < var_394_14 then
					arg_391_1.talkMaxDuration = var_394_14

					if var_394_14 + var_394_7 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_14 + var_394_7
					end
				end

				arg_391_1.text_.text = var_394_11
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041091", "story_v_out_423041.awb") ~= 0 then
					local var_394_15 = manager.audio:GetVoiceLength("story_v_out_423041", "423041091", "story_v_out_423041.awb") / 1000

					if var_394_15 + var_394_7 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_15 + var_394_7
					end

					if var_394_10.prefab_name ~= "" and arg_391_1.actors_[var_394_10.prefab_name] ~= nil then
						local var_394_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_10.prefab_name].transform, "story_v_out_423041", "423041091", "story_v_out_423041.awb")

						arg_391_1:RecordAudio("423041091", var_394_16)
						arg_391_1:RecordAudio("423041091", var_394_16)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_423041", "423041091", "story_v_out_423041.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_423041", "423041091", "story_v_out_423041.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_17 = math.max(var_394_8, arg_391_1.talkMaxDuration)

			if var_394_7 <= arg_391_1.time_ and arg_391_1.time_ < var_394_7 + var_394_17 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_7) / var_394_17

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_7 + var_394_17 and arg_391_1.time_ < var_394_7 + var_394_17 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play423041092 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 423041092
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play423041093(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["1083"]
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.actorSpriteComps1083 == nil then
				arg_395_1.var_.actorSpriteComps1083 = var_398_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_398_2 = 0.2

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 and not isNil(var_398_0) then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2

				if arg_395_1.var_.actorSpriteComps1083 then
					for iter_398_0, iter_398_1 in pairs(arg_395_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_398_1 then
							if arg_395_1.isInRecall_ then
								local var_398_4 = Mathf.Lerp(iter_398_1.color.r, arg_395_1.hightColor2.r, var_398_3)
								local var_398_5 = Mathf.Lerp(iter_398_1.color.g, arg_395_1.hightColor2.g, var_398_3)
								local var_398_6 = Mathf.Lerp(iter_398_1.color.b, arg_395_1.hightColor2.b, var_398_3)

								iter_398_1.color = Color.New(var_398_4, var_398_5, var_398_6)
							else
								local var_398_7 = Mathf.Lerp(iter_398_1.color.r, 0.5, var_398_3)

								iter_398_1.color = Color.New(var_398_7, var_398_7, var_398_7)
							end
						end
					end
				end
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.actorSpriteComps1083 then
				for iter_398_2, iter_398_3 in pairs(arg_395_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_398_3 then
						if arg_395_1.isInRecall_ then
							iter_398_3.color = arg_395_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_398_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_395_1.var_.actorSpriteComps1083 = nil
			end

			local var_398_8 = 0
			local var_398_9 = 0.425

			if var_398_8 < arg_395_1.time_ and arg_395_1.time_ <= var_398_8 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_10 = arg_395_1:FormatText(StoryNameCfg[7].name)

				arg_395_1.leftNameTxt_.text = var_398_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_11 = arg_395_1:GetWordFromCfg(423041092)
				local var_398_12 = arg_395_1:FormatText(var_398_11.content)

				arg_395_1.text_.text = var_398_12

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_13 = 17
				local var_398_14 = utf8.len(var_398_12)
				local var_398_15 = var_398_13 <= 0 and var_398_9 or var_398_9 * (var_398_14 / var_398_13)

				if var_398_15 > 0 and var_398_9 < var_398_15 then
					arg_395_1.talkMaxDuration = var_398_15

					if var_398_15 + var_398_8 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_15 + var_398_8
					end
				end

				arg_395_1.text_.text = var_398_12
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_16 = math.max(var_398_9, arg_395_1.talkMaxDuration)

			if var_398_8 <= arg_395_1.time_ and arg_395_1.time_ < var_398_8 + var_398_16 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_8) / var_398_16

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_8 + var_398_16 and arg_395_1.time_ < var_398_8 + var_398_16 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play423041093 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 423041093
		arg_399_1.duration_ = 3.1

		local var_399_0 = {
			zh = 3.1,
			ja = 2.933
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play423041094(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0
			local var_402_1 = 0.25

			if var_402_0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_2 = arg_399_1:FormatText(StoryNameCfg[1336].name)

				arg_399_1.leftNameTxt_.text = var_402_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_3 = arg_399_1:GetWordFromCfg(423041093)
				local var_402_4 = arg_399_1:FormatText(var_402_3.content)

				arg_399_1.text_.text = var_402_4

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 10
				local var_402_6 = utf8.len(var_402_4)
				local var_402_7 = var_402_5 <= 0 and var_402_1 or var_402_1 * (var_402_6 / var_402_5)

				if var_402_7 > 0 and var_402_1 < var_402_7 then
					arg_399_1.talkMaxDuration = var_402_7

					if var_402_7 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_7 + var_402_0
					end
				end

				arg_399_1.text_.text = var_402_4
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041093", "story_v_out_423041.awb") ~= 0 then
					local var_402_8 = manager.audio:GetVoiceLength("story_v_out_423041", "423041093", "story_v_out_423041.awb") / 1000

					if var_402_8 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_8 + var_402_0
					end

					if var_402_3.prefab_name ~= "" and arg_399_1.actors_[var_402_3.prefab_name] ~= nil then
						local var_402_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_3.prefab_name].transform, "story_v_out_423041", "423041093", "story_v_out_423041.awb")

						arg_399_1:RecordAudio("423041093", var_402_9)
						arg_399_1:RecordAudio("423041093", var_402_9)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_423041", "423041093", "story_v_out_423041.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_423041", "423041093", "story_v_out_423041.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_10 = math.max(var_402_1, arg_399_1.talkMaxDuration)

			if var_402_0 <= arg_399_1.time_ and arg_399_1.time_ < var_402_0 + var_402_10 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_0) / var_402_10

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_0 + var_402_10 and arg_399_1.time_ < var_402_0 + var_402_10 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play423041094 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 423041094
		arg_403_1.duration_ = 5.43

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play423041095(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["1083"].transform
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1.var_.moveOldPos1083 = var_406_0.localPosition
				var_406_0.localScale = Vector3.New(1, 1, 1)

				arg_403_1:CheckSpriteTmpPos("1083", 7)

				local var_406_2 = var_406_0.childCount

				for iter_406_0 = 0, var_406_2 - 1 do
					local var_406_3 = var_406_0:GetChild(iter_406_0)

					if var_406_3.name == "" or not string.find(var_406_3.name, "split") then
						var_406_3.gameObject:SetActive(true)
					else
						var_406_3.gameObject:SetActive(false)
					end
				end
			end

			local var_406_4 = 0.001

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_4 then
				local var_406_5 = (arg_403_1.time_ - var_406_1) / var_406_4
				local var_406_6 = Vector3.New(0, -2000, 0)

				var_406_0.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1083, var_406_6, var_406_5)
			end

			if arg_403_1.time_ >= var_406_1 + var_406_4 and arg_403_1.time_ < var_406_1 + var_406_4 + arg_406_0 then
				var_406_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_406_7 = arg_403_1.actors_["10148"].transform
			local var_406_8 = 0

			if var_406_8 < arg_403_1.time_ and arg_403_1.time_ <= var_406_8 + arg_406_0 then
				arg_403_1.var_.moveOldPos10148 = var_406_7.localPosition
				var_406_7.localScale = Vector3.New(1, 1, 1)

				arg_403_1:CheckSpriteTmpPos("10148", 7)

				local var_406_9 = var_406_7.childCount

				for iter_406_1 = 0, var_406_9 - 1 do
					local var_406_10 = var_406_7:GetChild(iter_406_1)

					if var_406_10.name == "" or not string.find(var_406_10.name, "split") then
						var_406_10.gameObject:SetActive(true)
					else
						var_406_10.gameObject:SetActive(false)
					end
				end
			end

			local var_406_11 = 0.001

			if var_406_8 <= arg_403_1.time_ and arg_403_1.time_ < var_406_8 + var_406_11 then
				local var_406_12 = (arg_403_1.time_ - var_406_8) / var_406_11
				local var_406_13 = Vector3.New(0, -2000, 0)

				var_406_7.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos10148, var_406_13, var_406_12)
			end

			if arg_403_1.time_ >= var_406_8 + var_406_11 and arg_403_1.time_ < var_406_8 + var_406_11 + arg_406_0 then
				var_406_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_406_14 = manager.ui.mainCamera.transform
			local var_406_15 = 0

			if var_406_15 < arg_403_1.time_ and arg_403_1.time_ <= var_406_15 + arg_406_0 then
				arg_403_1.var_.shakeOldPos = var_406_14.localPosition
			end

			local var_406_16 = 0.6

			if var_406_15 <= arg_403_1.time_ and arg_403_1.time_ < var_406_15 + var_406_16 then
				local var_406_17 = (arg_403_1.time_ - var_406_15) / 0.066
				local var_406_18, var_406_19 = math.modf(var_406_17)

				var_406_14.localPosition = Vector3.New(var_406_19 * 0.13, var_406_19 * 0.13, var_406_19 * 0.13) + arg_403_1.var_.shakeOldPos
			end

			if arg_403_1.time_ >= var_406_15 + var_406_16 and arg_403_1.time_ < var_406_15 + var_406_16 + arg_406_0 then
				var_406_14.localPosition = arg_403_1.var_.shakeOldPos
			end

			local var_406_20 = 0

			if var_406_20 < arg_403_1.time_ and arg_403_1.time_ <= var_406_20 + arg_406_0 then
				arg_403_1.allBtn_.enabled = false
			end

			local var_406_21 = 0.6

			if arg_403_1.time_ >= var_406_20 + var_406_21 and arg_403_1.time_ < var_406_20 + var_406_21 + arg_406_0 then
				arg_403_1.allBtn_.enabled = true
			end

			local var_406_22 = 0
			local var_406_23 = 1

			if var_406_22 < arg_403_1.time_ and arg_403_1.time_ <= var_406_22 + arg_406_0 then
				local var_406_24 = "play"
				local var_406_25 = "effect"

				arg_403_1:AudioAction(var_406_24, var_406_25, "se_story_140", "se_story_140_gun01", "")
			end

			if arg_403_1.frameCnt_ <= 1 then
				arg_403_1.dialog_:SetActive(false)
			end

			local var_406_26 = 0.433333333333333
			local var_406_27 = 1.825

			if var_406_26 < arg_403_1.time_ and arg_403_1.time_ <= var_406_26 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0

				arg_403_1.dialog_:SetActive(true)

				arg_403_1.dialogCg_.alpha = 0

				local var_406_28 = LeanTween.value(arg_403_1.dialog_, 0, 1, 0.3)

				var_406_28:setOnUpdate(LuaHelper.FloatAction(function(arg_407_0)
					arg_403_1.dialogCg_.alpha = arg_407_0
				end))
				var_406_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_403_1.dialog_)
					var_406_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_403_1.duration_ = arg_403_1.duration_ + 0.3

				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_29 = arg_403_1:GetWordFromCfg(423041094)
				local var_406_30 = arg_403_1:FormatText(var_406_29.content)

				arg_403_1.text_.text = var_406_30

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_31 = 73
				local var_406_32 = utf8.len(var_406_30)
				local var_406_33 = var_406_31 <= 0 and var_406_27 or var_406_27 * (var_406_32 / var_406_31)

				if var_406_33 > 0 and var_406_27 < var_406_33 then
					arg_403_1.talkMaxDuration = var_406_33
					var_406_26 = var_406_26 + 0.3

					if var_406_33 + var_406_26 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_33 + var_406_26
					end
				end

				arg_403_1.text_.text = var_406_30
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_34 = var_406_26 + 0.3
			local var_406_35 = math.max(var_406_27, arg_403_1.talkMaxDuration)

			if var_406_34 <= arg_403_1.time_ and arg_403_1.time_ < var_406_34 + var_406_35 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_34) / var_406_35

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_34 + var_406_35 and arg_403_1.time_ < var_406_34 + var_406_35 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play423041095 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 423041095
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play423041096(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0
			local var_412_1 = 0.775

			if var_412_0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_2 = arg_409_1:GetWordFromCfg(423041095)
				local var_412_3 = arg_409_1:FormatText(var_412_2.content)

				arg_409_1.text_.text = var_412_3

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_4 = 31
				local var_412_5 = utf8.len(var_412_3)
				local var_412_6 = var_412_4 <= 0 and var_412_1 or var_412_1 * (var_412_5 / var_412_4)

				if var_412_6 > 0 and var_412_1 < var_412_6 then
					arg_409_1.talkMaxDuration = var_412_6

					if var_412_6 + var_412_0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_6 + var_412_0
					end
				end

				arg_409_1.text_.text = var_412_3
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_7 = math.max(var_412_1, arg_409_1.talkMaxDuration)

			if var_412_0 <= arg_409_1.time_ and arg_409_1.time_ < var_412_0 + var_412_7 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_0) / var_412_7

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_0 + var_412_7 and arg_409_1.time_ < var_412_0 + var_412_7 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play423041096 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 423041096
		arg_413_1.duration_ = 3.9

		local var_413_0 = {
			zh = 3.733,
			ja = 3.9
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play423041097(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1083"]
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.actorSpriteComps1083 == nil then
				arg_413_1.var_.actorSpriteComps1083 = var_416_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_2 = 0.2

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 and not isNil(var_416_0) then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2

				if arg_413_1.var_.actorSpriteComps1083 then
					for iter_416_0, iter_416_1 in pairs(arg_413_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_416_1 then
							if arg_413_1.isInRecall_ then
								local var_416_4 = Mathf.Lerp(iter_416_1.color.r, arg_413_1.hightColor1.r, var_416_3)
								local var_416_5 = Mathf.Lerp(iter_416_1.color.g, arg_413_1.hightColor1.g, var_416_3)
								local var_416_6 = Mathf.Lerp(iter_416_1.color.b, arg_413_1.hightColor1.b, var_416_3)

								iter_416_1.color = Color.New(var_416_4, var_416_5, var_416_6)
							else
								local var_416_7 = Mathf.Lerp(iter_416_1.color.r, 1, var_416_3)

								iter_416_1.color = Color.New(var_416_7, var_416_7, var_416_7)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.actorSpriteComps1083 then
				for iter_416_2, iter_416_3 in pairs(arg_413_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_416_3 then
						if arg_413_1.isInRecall_ then
							iter_416_3.color = arg_413_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_416_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_413_1.var_.actorSpriteComps1083 = nil
			end

			local var_416_8 = arg_413_1.actors_["1083"].transform
			local var_416_9 = 0

			if var_416_9 < arg_413_1.time_ and arg_413_1.time_ <= var_416_9 + arg_416_0 then
				arg_413_1.var_.moveOldPos1083 = var_416_8.localPosition
				var_416_8.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("1083", 3)

				local var_416_10 = var_416_8.childCount

				for iter_416_4 = 0, var_416_10 - 1 do
					local var_416_11 = var_416_8:GetChild(iter_416_4)

					if var_416_11.name == "" or not string.find(var_416_11.name, "split") then
						var_416_11.gameObject:SetActive(true)
					else
						var_416_11.gameObject:SetActive(false)
					end
				end
			end

			local var_416_12 = 0.001

			if var_416_9 <= arg_413_1.time_ and arg_413_1.time_ < var_416_9 + var_416_12 then
				local var_416_13 = (arg_413_1.time_ - var_416_9) / var_416_12
				local var_416_14 = Vector3.New(-50, -345, -345)

				var_416_8.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1083, var_416_14, var_416_13)
			end

			if arg_413_1.time_ >= var_416_9 + var_416_12 and arg_413_1.time_ < var_416_9 + var_416_12 + arg_416_0 then
				var_416_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_416_15 = 0
			local var_416_16 = 0.35

			if var_416_15 < arg_413_1.time_ and arg_413_1.time_ <= var_416_15 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_17 = arg_413_1:FormatText(StoryNameCfg[1332].name)

				arg_413_1.leftNameTxt_.text = var_416_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_18 = arg_413_1:GetWordFromCfg(423041096)
				local var_416_19 = arg_413_1:FormatText(var_416_18.content)

				arg_413_1.text_.text = var_416_19

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_20 = 14
				local var_416_21 = utf8.len(var_416_19)
				local var_416_22 = var_416_20 <= 0 and var_416_16 or var_416_16 * (var_416_21 / var_416_20)

				if var_416_22 > 0 and var_416_16 < var_416_22 then
					arg_413_1.talkMaxDuration = var_416_22

					if var_416_22 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_22 + var_416_15
					end
				end

				arg_413_1.text_.text = var_416_19
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041096", "story_v_out_423041.awb") ~= 0 then
					local var_416_23 = manager.audio:GetVoiceLength("story_v_out_423041", "423041096", "story_v_out_423041.awb") / 1000

					if var_416_23 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_23 + var_416_15
					end

					if var_416_18.prefab_name ~= "" and arg_413_1.actors_[var_416_18.prefab_name] ~= nil then
						local var_416_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_18.prefab_name].transform, "story_v_out_423041", "423041096", "story_v_out_423041.awb")

						arg_413_1:RecordAudio("423041096", var_416_24)
						arg_413_1:RecordAudio("423041096", var_416_24)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_423041", "423041096", "story_v_out_423041.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_423041", "423041096", "story_v_out_423041.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_25 = math.max(var_416_16, arg_413_1.talkMaxDuration)

			if var_416_15 <= arg_413_1.time_ and arg_413_1.time_ < var_416_15 + var_416_25 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_15) / var_416_25

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_15 + var_416_25 and arg_413_1.time_ < var_416_15 + var_416_25 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play423041097 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 423041097
		arg_417_1.duration_ = 6.97

		local var_417_0 = {
			zh = 5.566,
			ja = 6.966
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
			arg_417_1.auto_ = false
		end

		function arg_417_1.playNext_(arg_419_0)
			arg_417_1.onStoryFinished_()
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["1083"].transform
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.var_.moveOldPos1083 = var_420_0.localPosition
				var_420_0.localScale = Vector3.New(1, 1, 1)

				arg_417_1:CheckSpriteTmpPos("1083", 3)

				local var_420_2 = var_420_0.childCount

				for iter_420_0 = 0, var_420_2 - 1 do
					local var_420_3 = var_420_0:GetChild(iter_420_0)

					if var_420_3.name == "" or not string.find(var_420_3.name, "split") then
						var_420_3.gameObject:SetActive(true)
					else
						var_420_3.gameObject:SetActive(false)
					end
				end
			end

			local var_420_4 = 0.001

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_4 then
				local var_420_5 = (arg_417_1.time_ - var_420_1) / var_420_4
				local var_420_6 = Vector3.New(-50, -345, -345)

				var_420_0.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1083, var_420_6, var_420_5)
			end

			if arg_417_1.time_ >= var_420_1 + var_420_4 and arg_417_1.time_ < var_420_1 + var_420_4 + arg_420_0 then
				var_420_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_420_7 = 0
			local var_420_8 = 0.45

			if var_420_7 < arg_417_1.time_ and arg_417_1.time_ <= var_420_7 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_9 = arg_417_1:FormatText(StoryNameCfg[1332].name)

				arg_417_1.leftNameTxt_.text = var_420_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_10 = arg_417_1:GetWordFromCfg(423041097)
				local var_420_11 = arg_417_1:FormatText(var_420_10.content)

				arg_417_1.text_.text = var_420_11

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_12 = 18
				local var_420_13 = utf8.len(var_420_11)
				local var_420_14 = var_420_12 <= 0 and var_420_8 or var_420_8 * (var_420_13 / var_420_12)

				if var_420_14 > 0 and var_420_8 < var_420_14 then
					arg_417_1.talkMaxDuration = var_420_14

					if var_420_14 + var_420_7 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_14 + var_420_7
					end
				end

				arg_417_1.text_.text = var_420_11
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423041", "423041097", "story_v_out_423041.awb") ~= 0 then
					local var_420_15 = manager.audio:GetVoiceLength("story_v_out_423041", "423041097", "story_v_out_423041.awb") / 1000

					if var_420_15 + var_420_7 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_15 + var_420_7
					end

					if var_420_10.prefab_name ~= "" and arg_417_1.actors_[var_420_10.prefab_name] ~= nil then
						local var_420_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_10.prefab_name].transform, "story_v_out_423041", "423041097", "story_v_out_423041.awb")

						arg_417_1:RecordAudio("423041097", var_420_16)
						arg_417_1:RecordAudio("423041097", var_420_16)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_423041", "423041097", "story_v_out_423041.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_423041", "423041097", "story_v_out_423041.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_17 = math.max(var_420_8, arg_417_1.talkMaxDuration)

			if var_420_7 <= arg_417_1.time_ and arg_417_1.time_ < var_420_7 + var_420_17 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_7) / var_420_17

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_7 + var_420_17 and arg_417_1.time_ < var_420_7 + var_420_17 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I25h",
		"TextureConfig/Background/I25g",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SS2302",
		"TextureConfig/Background/I26f"
	},
	voices = {
		"story_v_out_423041.awb"
	}
}
