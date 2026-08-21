return {
	Play107052001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 107052001
		arg_1_1.duration_ = 3.53

		local var_1_0 = {
			ja = 3,
			ko = 3.166,
			zh = 3.533,
			en = 3.066
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
				arg_1_0:Play107052002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "C04a"

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
				local var_4_5 = arg_1_1.bgs_.C04a

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
					if iter_4_0 ~= "C04a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.C04a
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueC04a = var_4_18.color.a
					arg_1_1.var_.alphaMatValueC04a = var_4_18
				end

				arg_1_1.var_.alphaOldValueC04a = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueC04a, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueC04a then
					local var_4_22 = arg_1_1.var_.alphaMatValueC04a.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueC04a.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueC04a then
				local var_4_23 = arg_1_1.var_.alphaMatValueC04a
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = manager.ui.mainCamera.transform
			local var_4_26 = 2

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_25.localPosition
			end

			local var_4_27 = 0.6

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				local var_4_28 = (arg_1_1.time_ - var_4_26) / 0.066
				local var_4_29, var_4_30 = math.modf(var_4_28)

				var_4_25.localPosition = Vector3.New(var_4_30 * 0.13, var_4_30 * 0.13, var_4_30 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				var_4_25.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_31 = 0
			local var_4_32 = 1

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				local var_4_33 = "play"
				local var_4_34 = "music"

				arg_1_1:AudioAction(var_4_33, var_4_34, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_35 = ""
				local var_4_36 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_36 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_36 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_36

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_36
						arg_1_1.bgmTxt2_.text = var_4_36
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

			local var_4_37 = 0

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_38 = 2

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_39 = 0
			local var_4_40 = 1

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_41 = "play"
				local var_4_42 = "effect"

				arg_1_1:AudioAction(var_4_41, var_4_42, "se_story_7", "se_story_7_lift", "")
			end

			local var_4_43 = 0.5
			local var_4_44 = 1

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "effect"

				arg_1_1:AudioAction(var_4_45, var_4_46, "se_story_7", "se_story_7_lastcharge_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_47 = 2
			local var_4_48 = 0.125

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

				local var_4_50 = arg_1_1:FormatText(StoryNameCfg[84].name)

				arg_1_1.leftNameTxt_.text = var_4_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_51 = arg_1_1:GetWordFromCfg(107052001)
				local var_4_52 = arg_1_1:FormatText(var_4_51.content)

				arg_1_1.text_.text = var_4_52

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_53 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_107052", "107052001", "story_v_out_107052.awb") ~= 0 then
					local var_4_56 = manager.audio:GetVoiceLength("story_v_out_107052", "107052001", "story_v_out_107052.awb") / 1000

					if var_4_56 + var_4_47 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_56 + var_4_47
					end

					if var_4_51.prefab_name ~= "" and arg_1_1.actors_[var_4_51.prefab_name] ~= nil then
						local var_4_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_51.prefab_name].transform, "story_v_out_107052", "107052001", "story_v_out_107052.awb")

						arg_1_1:RecordAudio("107052001", var_4_57)
						arg_1_1:RecordAudio("107052001", var_4_57)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_107052", "107052001", "story_v_out_107052.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_107052", "107052001", "story_v_out_107052.awb")
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
	Play107052002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 107052002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play107052003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "stop"
				local var_11_3 = "music"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story_7", "se_story_7_lastcharge_loop", "")

				local var_11_4 = ""
				local var_11_5 = manager.audio:GetAudioName("se_story_7", "se_story_7_lastcharge_loop")

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

			local var_11_6 = 0.375
			local var_11_7 = 1

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				local var_11_8 = "play"
				local var_11_9 = "effect"

				arg_8_1:AudioAction(var_11_8, var_11_9, "se_story_7", "se_story_7_Chop", "")
			end

			local var_11_10 = 0
			local var_11_11 = 1.375

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:GetWordFromCfg(107052002)
				local var_11_13 = arg_8_1:FormatText(var_11_12.content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_14 = 55
				local var_11_15 = utf8.len(var_11_13)
				local var_11_16 = var_11_14 <= 0 and var_11_11 or var_11_11 * (var_11_15 / var_11_14)

				if var_11_16 > 0 and var_11_11 < var_11_16 then
					arg_8_1.talkMaxDuration = var_11_16

					if var_11_16 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_17 = math.max(var_11_11, arg_8_1.talkMaxDuration)

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_17 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_10) / var_11_17

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_10 + var_11_17 and arg_8_1.time_ < var_11_10 + var_11_17 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play107052003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 107052003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play107052004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.65

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

				local var_16_2 = arg_13_1:GetWordFromCfg(107052003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 26
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
	Play107052004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 107052004
		arg_17_1.duration_ = 3.8

		local var_17_0 = {
			ja = 3.8,
			ko = 3.366,
			zh = 3.266,
			en = 3.666
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
				arg_17_0:Play107052005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1050ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1050ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_17_1.stage_.transform)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

					var_20_3.enabled = true

					local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

					if var_20_4 then
						var_20_4:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_3.transform, false)

					arg_17_1.var_[var_20_0 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_0 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_0 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_5 = arg_17_1.actors_["1050ui_story"]
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1050ui_story == nil then
				arg_17_1.var_.characterEffect1050ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_7 = 0.1

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 and not isNil(var_20_5) then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7

				if arg_17_1.var_.characterEffect1050ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1050ui_story then
				arg_17_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_20_9 = arg_17_1.actors_["1050ui_story"].transform
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.var_.moveOldPos1050ui_story = var_20_9.localPosition
			end

			local var_20_11 = 0.001

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11
				local var_20_13 = Vector3.New(0, -1, -6.1)

				var_20_9.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1050ui_story, var_20_13, var_20_12)

				local var_20_14 = manager.ui.mainCamera.transform.position - var_20_9.position

				var_20_9.forward = Vector3.New(var_20_14.x, var_20_14.y, var_20_14.z)

				local var_20_15 = var_20_9.localEulerAngles

				var_20_15.z = 0
				var_20_15.x = 0
				var_20_9.localEulerAngles = var_20_15
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 then
				var_20_9.localPosition = Vector3.New(0, -1, -6.1)

				local var_20_16 = manager.ui.mainCamera.transform.position - var_20_9.position

				var_20_9.forward = Vector3.New(var_20_16.x, var_20_16.y, var_20_16.z)

				local var_20_17 = var_20_9.localEulerAngles

				var_20_17.z = 0
				var_20_17.x = 0
				var_20_9.localEulerAngles = var_20_17
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action7_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_20_20 = 0
			local var_20_21 = 0.35

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_22 = arg_17_1:FormatText(StoryNameCfg[74].name)

				arg_17_1.leftNameTxt_.text = var_20_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_23 = arg_17_1:GetWordFromCfg(107052004)
				local var_20_24 = arg_17_1:FormatText(var_20_23.content)

				arg_17_1.text_.text = var_20_24

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_25 = 14
				local var_20_26 = utf8.len(var_20_24)
				local var_20_27 = var_20_25 <= 0 and var_20_21 or var_20_21 * (var_20_26 / var_20_25)

				if var_20_27 > 0 and var_20_21 < var_20_27 then
					arg_17_1.talkMaxDuration = var_20_27

					if var_20_27 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_27 + var_20_20
					end
				end

				arg_17_1.text_.text = var_20_24
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107052", "107052004", "story_v_out_107052.awb") ~= 0 then
					local var_20_28 = manager.audio:GetVoiceLength("story_v_out_107052", "107052004", "story_v_out_107052.awb") / 1000

					if var_20_28 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_20
					end

					if var_20_23.prefab_name ~= "" and arg_17_1.actors_[var_20_23.prefab_name] ~= nil then
						local var_20_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_23.prefab_name].transform, "story_v_out_107052", "107052004", "story_v_out_107052.awb")

						arg_17_1:RecordAudio("107052004", var_20_29)
						arg_17_1:RecordAudio("107052004", var_20_29)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_107052", "107052004", "story_v_out_107052.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_107052", "107052004", "story_v_out_107052.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_30 = math.max(var_20_21, arg_17_1.talkMaxDuration)

			if var_20_20 <= arg_17_1.time_ and arg_17_1.time_ < var_20_20 + var_20_30 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_20) / var_20_30

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_20 + var_20_30 and arg_17_1.time_ < var_20_20 + var_20_30 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play107052005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 107052005
		arg_21_1.duration_ = 5

		local var_21_0 = {
			ja = 3.8,
			ko = 5,
			zh = 4,
			en = 4.833
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
				arg_21_0:Play107052006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1050ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1050ui_story == nil then
				arg_21_1.var_.characterEffect1050ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.1

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1050ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1050ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1050ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1050ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 0.55

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[76].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_9 = arg_21_1:GetWordFromCfg(107052005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 22
				local var_24_12 = utf8.len(var_24_10)
				local var_24_13 = var_24_11 <= 0 and var_24_7 or var_24_7 * (var_24_12 / var_24_11)

				if var_24_13 > 0 and var_24_7 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_10
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107052", "107052005", "story_v_out_107052.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_107052", "107052005", "story_v_out_107052.awb") / 1000

					if var_24_14 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_6
					end

					if var_24_9.prefab_name ~= "" and arg_21_1.actors_[var_24_9.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_9.prefab_name].transform, "story_v_out_107052", "107052005", "story_v_out_107052.awb")

						arg_21_1:RecordAudio("107052005", var_24_15)
						arg_21_1:RecordAudio("107052005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_107052", "107052005", "story_v_out_107052.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_107052", "107052005", "story_v_out_107052.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_16 and arg_21_1.time_ < var_24_6 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play107052006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 107052006
		arg_25_1.duration_ = 2.83

		local var_25_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.833,
			en = 2.166
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
				arg_25_0:Play107052007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "1099ui_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "1099ui_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_25_1.stage_.transform)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentInChildren(typeof(CharacterEffect))

					var_28_3.enabled = true

					local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_2, typeof(DynamicBoneHelper))

					if var_28_4 then
						var_28_4:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_3.transform, false)

					arg_25_1.var_[var_28_0 .. "Animator"] = var_28_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_0 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_0 .. "LipSync"] = var_28_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_5 = arg_25_1.actors_["1099ui_story"]
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1099ui_story == nil then
				arg_25_1.var_.characterEffect1099ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_7 = 0.1

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 and not isNil(var_28_5) then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7

				if arg_25_1.var_.characterEffect1099ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1099ui_story then
				arg_25_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_28_9 = arg_25_1.actors_["1050ui_story"].transform
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.var_.moveOldPos1050ui_story = var_28_9.localPosition
			end

			local var_28_11 = 0.001

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11
				local var_28_13 = Vector3.New(0, 100, 0)

				var_28_9.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1050ui_story, var_28_13, var_28_12)

				local var_28_14 = manager.ui.mainCamera.transform.position - var_28_9.position

				var_28_9.forward = Vector3.New(var_28_14.x, var_28_14.y, var_28_14.z)

				local var_28_15 = var_28_9.localEulerAngles

				var_28_15.z = 0
				var_28_15.x = 0
				var_28_9.localEulerAngles = var_28_15
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 then
				var_28_9.localPosition = Vector3.New(0, 100, 0)

				local var_28_16 = manager.ui.mainCamera.transform.position - var_28_9.position

				var_28_9.forward = Vector3.New(var_28_16.x, var_28_16.y, var_28_16.z)

				local var_28_17 = var_28_9.localEulerAngles

				var_28_17.z = 0
				var_28_17.x = 0
				var_28_9.localEulerAngles = var_28_17
			end

			local var_28_18 = arg_25_1.actors_["1099ui_story"].transform
			local var_28_19 = 0

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				arg_25_1.var_.moveOldPos1099ui_story = var_28_18.localPosition
			end

			local var_28_20 = 0.001

			if var_28_19 <= arg_25_1.time_ and arg_25_1.time_ < var_28_19 + var_28_20 then
				local var_28_21 = (arg_25_1.time_ - var_28_19) / var_28_20
				local var_28_22 = Vector3.New(0, -1.08, -5.9)

				var_28_18.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1099ui_story, var_28_22, var_28_21)

				local var_28_23 = manager.ui.mainCamera.transform.position - var_28_18.position

				var_28_18.forward = Vector3.New(var_28_23.x, var_28_23.y, var_28_23.z)

				local var_28_24 = var_28_18.localEulerAngles

				var_28_24.z = 0
				var_28_24.x = 0
				var_28_18.localEulerAngles = var_28_24
			end

			if arg_25_1.time_ >= var_28_19 + var_28_20 and arg_25_1.time_ < var_28_19 + var_28_20 + arg_28_0 then
				var_28_18.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_28_25 = manager.ui.mainCamera.transform.position - var_28_18.position

				var_28_18.forward = Vector3.New(var_28_25.x, var_28_25.y, var_28_25.z)

				local var_28_26 = var_28_18.localEulerAngles

				var_28_26.z = 0
				var_28_26.x = 0
				var_28_18.localEulerAngles = var_28_26
			end

			local var_28_27 = 0

			if var_28_27 < arg_25_1.time_ and arg_25_1.time_ <= var_28_27 + arg_28_0 then
				arg_25_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			local var_28_28 = 0

			if var_28_28 < arg_25_1.time_ and arg_25_1.time_ <= var_28_28 + arg_28_0 then
				arg_25_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_28_29 = 0
			local var_28_30 = 0.2

			if var_28_29 < arg_25_1.time_ and arg_25_1.time_ <= var_28_29 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_31 = arg_25_1:FormatText(StoryNameCfg[84].name)

				arg_25_1.leftNameTxt_.text = var_28_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_32 = arg_25_1:GetWordFromCfg(107052006)
				local var_28_33 = arg_25_1:FormatText(var_28_32.content)

				arg_25_1.text_.text = var_28_33

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_34 = 8
				local var_28_35 = utf8.len(var_28_33)
				local var_28_36 = var_28_34 <= 0 and var_28_30 or var_28_30 * (var_28_35 / var_28_34)

				if var_28_36 > 0 and var_28_30 < var_28_36 then
					arg_25_1.talkMaxDuration = var_28_36

					if var_28_36 + var_28_29 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_36 + var_28_29
					end
				end

				arg_25_1.text_.text = var_28_33
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107052", "107052006", "story_v_out_107052.awb") ~= 0 then
					local var_28_37 = manager.audio:GetVoiceLength("story_v_out_107052", "107052006", "story_v_out_107052.awb") / 1000

					if var_28_37 + var_28_29 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_37 + var_28_29
					end

					if var_28_32.prefab_name ~= "" and arg_25_1.actors_[var_28_32.prefab_name] ~= nil then
						local var_28_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_32.prefab_name].transform, "story_v_out_107052", "107052006", "story_v_out_107052.awb")

						arg_25_1:RecordAudio("107052006", var_28_38)
						arg_25_1:RecordAudio("107052006", var_28_38)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_107052", "107052006", "story_v_out_107052.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_107052", "107052006", "story_v_out_107052.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_39 = math.max(var_28_30, arg_25_1.talkMaxDuration)

			if var_28_29 <= arg_25_1.time_ and arg_25_1.time_ < var_28_29 + var_28_39 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_29) / var_28_39

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_29 + var_28_39 and arg_25_1.time_ < var_28_29 + var_28_39 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play107052007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 107052007
		arg_29_1.duration_ = 11.8

		local var_29_0 = {
			ja = 10.166,
			ko = 8.766,
			zh = 10.9,
			en = 11.8
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
				arg_29_0:Play107052008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "3014_tpose"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Char/" .. "3014_tpose")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(Asset.Load("Char/" .. "3014_tpose"), arg_29_1.stage_.transform)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentInChildren(typeof(CharacterEffect))

					var_32_3.enabled = true

					local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_2, typeof(DynamicBoneHelper))

					if var_32_4 then
						var_32_4:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_3.transform, false)

					arg_29_1.var_[var_32_0 .. "Animator"] = var_32_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_0 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_0 .. "LipSync"] = var_32_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_5 = arg_29_1.actors_["3014_tpose"]
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect3014_tpose == nil then
				arg_29_1.var_.characterEffect3014_tpose = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_7 = 0.1

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_7 and not isNil(var_32_5) then
				local var_32_8 = (arg_29_1.time_ - var_32_6) / var_32_7

				if arg_29_1.var_.characterEffect3014_tpose and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect3014_tpose then
				arg_29_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_32_9 = arg_29_1.actors_["1099ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1099ui_story == nil then
				arg_29_1.var_.characterEffect1099ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.1

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect1099ui_story and not isNil(var_32_9) then
					local var_32_13 = Mathf.Lerp(0, 0.5, var_32_12)

					arg_29_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1099ui_story.fillRatio = var_32_13
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1099ui_story then
				local var_32_14 = 0.5

				arg_29_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1099ui_story.fillRatio = var_32_14
			end

			local var_32_15 = arg_29_1.actors_["1099ui_story"].transform
			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.var_.moveOldPos1099ui_story = var_32_15.localPosition
			end

			local var_32_17 = 0.001

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_17 then
				local var_32_18 = (arg_29_1.time_ - var_32_16) / var_32_17
				local var_32_19 = Vector3.New(0, 100, 0)

				var_32_15.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1099ui_story, var_32_19, var_32_18)

				local var_32_20 = manager.ui.mainCamera.transform.position - var_32_15.position

				var_32_15.forward = Vector3.New(var_32_20.x, var_32_20.y, var_32_20.z)

				local var_32_21 = var_32_15.localEulerAngles

				var_32_21.z = 0
				var_32_21.x = 0
				var_32_15.localEulerAngles = var_32_21
			end

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 then
				var_32_15.localPosition = Vector3.New(0, 100, 0)

				local var_32_22 = manager.ui.mainCamera.transform.position - var_32_15.position

				var_32_15.forward = Vector3.New(var_32_22.x, var_32_22.y, var_32_22.z)

				local var_32_23 = var_32_15.localEulerAngles

				var_32_23.z = 0
				var_32_23.x = 0
				var_32_15.localEulerAngles = var_32_23
			end

			local var_32_24 = arg_29_1.actors_["3014_tpose"].transform
			local var_32_25 = 0

			if var_32_25 < arg_29_1.time_ and arg_29_1.time_ <= var_32_25 + arg_32_0 then
				arg_29_1.var_.moveOldPos3014_tpose = var_32_24.localPosition

				local var_32_26 = GameObjectTools.GetOrAddComponent(var_32_24.gameObject, typeof(DynamicBoneHelper))

				if var_32_26 then
					var_32_26:EnableDynamicBone(false)
				end
			end

			local var_32_27 = 0.001

			if var_32_25 <= arg_29_1.time_ and arg_29_1.time_ < var_32_25 + var_32_27 then
				local var_32_28 = (arg_29_1.time_ - var_32_25) / var_32_27
				local var_32_29 = Vector3.New(0, -2.35, -2.9)

				var_32_24.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos3014_tpose, var_32_29, var_32_28)

				local var_32_30 = manager.ui.mainCamera.transform.position - var_32_24.position

				var_32_24.forward = Vector3.New(var_32_30.x, var_32_30.y, var_32_30.z)

				local var_32_31 = var_32_24.localEulerAngles

				var_32_31.z = 0
				var_32_31.x = 0
				var_32_24.localEulerAngles = var_32_31
			end

			if arg_29_1.time_ >= var_32_25 + var_32_27 and arg_29_1.time_ < var_32_25 + var_32_27 + arg_32_0 then
				var_32_24.localPosition = Vector3.New(0, -2.35, -2.9)

				local var_32_32 = manager.ui.mainCamera.transform.position - var_32_24.position

				var_32_24.forward = Vector3.New(var_32_32.x, var_32_32.y, var_32_32.z)

				local var_32_33 = var_32_24.localEulerAngles

				var_32_33.z = 0
				var_32_33.x = 0
				var_32_24.localEulerAngles = var_32_33

				local var_32_34 = GameObjectTools.GetOrAddComponent(var_32_24.gameObject, typeof(DynamicBoneHelper))

				if var_32_34 then
					var_32_34:EnableDynamicBone(true)
				end
			end

			local var_32_35 = 0

			if var_32_35 < arg_29_1.time_ and arg_29_1.time_ <= var_32_35 + arg_32_0 then
				arg_29_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_32_36 = 0
			local var_32_37 = 0.8

			if var_32_36 < arg_29_1.time_ and arg_29_1.time_ <= var_32_36 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_38 = arg_29_1:FormatText(StoryNameCfg[96].name)

				arg_29_1.leftNameTxt_.text = var_32_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_39 = arg_29_1:GetWordFromCfg(107052007)
				local var_32_40 = arg_29_1:FormatText(var_32_39.content)

				arg_29_1.text_.text = var_32_40

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_41 = 32
				local var_32_42 = utf8.len(var_32_40)
				local var_32_43 = var_32_41 <= 0 and var_32_37 or var_32_37 * (var_32_42 / var_32_41)

				if var_32_43 > 0 and var_32_37 < var_32_43 then
					arg_29_1.talkMaxDuration = var_32_43

					if var_32_43 + var_32_36 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_43 + var_32_36
					end
				end

				arg_29_1.text_.text = var_32_40
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107052", "107052007", "story_v_out_107052.awb") ~= 0 then
					local var_32_44 = manager.audio:GetVoiceLength("story_v_out_107052", "107052007", "story_v_out_107052.awb") / 1000

					if var_32_44 + var_32_36 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_44 + var_32_36
					end

					if var_32_39.prefab_name ~= "" and arg_29_1.actors_[var_32_39.prefab_name] ~= nil then
						local var_32_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_39.prefab_name].transform, "story_v_out_107052", "107052007", "story_v_out_107052.awb")

						arg_29_1:RecordAudio("107052007", var_32_45)
						arg_29_1:RecordAudio("107052007", var_32_45)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_107052", "107052007", "story_v_out_107052.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_107052", "107052007", "story_v_out_107052.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_46 = math.max(var_32_37, arg_29_1.talkMaxDuration)

			if var_32_36 <= arg_29_1.time_ and arg_29_1.time_ < var_32_36 + var_32_46 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_36) / var_32_46

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_36 + var_32_46 and arg_29_1.time_ < var_32_36 + var_32_46 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play107052008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 107052008
		arg_33_1.duration_ = 10.13

		local var_33_0 = {
			ja = 9.3,
			ko = 8.6,
			zh = 10.133,
			en = 8.433
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
				arg_33_0:Play107052009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.7

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[96].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(107052008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_107052", "107052008", "story_v_out_107052.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_107052", "107052008", "story_v_out_107052.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_107052", "107052008", "story_v_out_107052.awb")

						arg_33_1:RecordAudio("107052008", var_36_9)
						arg_33_1:RecordAudio("107052008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_107052", "107052008", "story_v_out_107052.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_107052", "107052008", "story_v_out_107052.awb")
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
	Play107052009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 107052009
		arg_37_1.duration_ = 9.93

		local var_37_0 = {
			ja = 6.566,
			ko = 7.9,
			zh = 9.933,
			en = 9.2
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
				arg_37_0:Play107052010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.75

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[96].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(107052009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 25
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107052", "107052009", "story_v_out_107052.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_107052", "107052009", "story_v_out_107052.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_107052", "107052009", "story_v_out_107052.awb")

						arg_37_1:RecordAudio("107052009", var_40_9)
						arg_37_1:RecordAudio("107052009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_107052", "107052009", "story_v_out_107052.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_107052", "107052009", "story_v_out_107052.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play107052010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 107052010
		arg_41_1.duration_ = 3.6

		local var_41_0 = {
			ja = 2.533,
			ko = 3.6,
			zh = 1.999999999999,
			en = 2.766
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
				arg_41_0:Play107052011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1099ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1099ui_story == nil then
				arg_41_1.var_.characterEffect1099ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.1

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1099ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1099ui_story then
				arg_41_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["3014_tpose"]
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect3014_tpose == nil then
				arg_41_1.var_.characterEffect3014_tpose = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.1

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 and not isNil(var_44_4) then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6

				if arg_41_1.var_.characterEffect3014_tpose and not isNil(var_44_4) then
					local var_44_8 = Mathf.Lerp(0, 0.5, var_44_7)

					arg_41_1.var_.characterEffect3014_tpose.fillFlat = true
					arg_41_1.var_.characterEffect3014_tpose.fillRatio = var_44_8
				end
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect3014_tpose then
				local var_44_9 = 0.5

				arg_41_1.var_.characterEffect3014_tpose.fillFlat = true
				arg_41_1.var_.characterEffect3014_tpose.fillRatio = var_44_9
			end

			local var_44_10 = arg_41_1.actors_["3014_tpose"].transform
			local var_44_11 = 0

			if var_44_11 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1.var_.moveOldPos3014_tpose = var_44_10.localPosition

				local var_44_12 = GameObjectTools.GetOrAddComponent(var_44_10.gameObject, typeof(DynamicBoneHelper))

				if var_44_12 then
					var_44_12:EnableDynamicBone(false)
				end
			end

			local var_44_13 = 0.001

			if var_44_11 <= arg_41_1.time_ and arg_41_1.time_ < var_44_11 + var_44_13 then
				local var_44_14 = (arg_41_1.time_ - var_44_11) / var_44_13
				local var_44_15 = Vector3.New(0, 100, 0)

				var_44_10.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos3014_tpose, var_44_15, var_44_14)

				local var_44_16 = manager.ui.mainCamera.transform.position - var_44_10.position

				var_44_10.forward = Vector3.New(var_44_16.x, var_44_16.y, var_44_16.z)

				local var_44_17 = var_44_10.localEulerAngles

				var_44_17.z = 0
				var_44_17.x = 0
				var_44_10.localEulerAngles = var_44_17
			end

			if arg_41_1.time_ >= var_44_11 + var_44_13 and arg_41_1.time_ < var_44_11 + var_44_13 + arg_44_0 then
				var_44_10.localPosition = Vector3.New(0, 100, 0)

				local var_44_18 = manager.ui.mainCamera.transform.position - var_44_10.position

				var_44_10.forward = Vector3.New(var_44_18.x, var_44_18.y, var_44_18.z)

				local var_44_19 = var_44_10.localEulerAngles

				var_44_19.z = 0
				var_44_19.x = 0
				var_44_10.localEulerAngles = var_44_19

				local var_44_20 = GameObjectTools.GetOrAddComponent(var_44_10.gameObject, typeof(DynamicBoneHelper))

				if var_44_20 then
					var_44_20:EnableDynamicBone(true)
				end
			end

			local var_44_21 = arg_41_1.actors_["1099ui_story"].transform
			local var_44_22 = 0

			if var_44_22 < arg_41_1.time_ and arg_41_1.time_ <= var_44_22 + arg_44_0 then
				arg_41_1.var_.moveOldPos1099ui_story = var_44_21.localPosition
			end

			local var_44_23 = 0.001

			if var_44_22 <= arg_41_1.time_ and arg_41_1.time_ < var_44_22 + var_44_23 then
				local var_44_24 = (arg_41_1.time_ - var_44_22) / var_44_23
				local var_44_25 = Vector3.New(0, -1.08, -5.9)

				var_44_21.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1099ui_story, var_44_25, var_44_24)

				local var_44_26 = manager.ui.mainCamera.transform.position - var_44_21.position

				var_44_21.forward = Vector3.New(var_44_26.x, var_44_26.y, var_44_26.z)

				local var_44_27 = var_44_21.localEulerAngles

				var_44_27.z = 0
				var_44_27.x = 0
				var_44_21.localEulerAngles = var_44_27
			end

			if arg_41_1.time_ >= var_44_22 + var_44_23 and arg_41_1.time_ < var_44_22 + var_44_23 + arg_44_0 then
				var_44_21.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_44_28 = manager.ui.mainCamera.transform.position - var_44_21.position

				var_44_21.forward = Vector3.New(var_44_28.x, var_44_28.y, var_44_28.z)

				local var_44_29 = var_44_21.localEulerAngles

				var_44_29.z = 0
				var_44_29.x = 0
				var_44_21.localEulerAngles = var_44_29
			end

			local var_44_30 = 0

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			local var_44_31 = 0

			if var_44_31 < arg_41_1.time_ and arg_41_1.time_ <= var_44_31 + arg_44_0 then
				arg_41_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_44_32 = 0
			local var_44_33 = 0.35

			if var_44_32 < arg_41_1.time_ and arg_41_1.time_ <= var_44_32 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_34 = arg_41_1:FormatText(StoryNameCfg[84].name)

				arg_41_1.leftNameTxt_.text = var_44_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_35 = arg_41_1:GetWordFromCfg(107052010)
				local var_44_36 = arg_41_1:FormatText(var_44_35.content)

				arg_41_1.text_.text = var_44_36

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_37 = 11
				local var_44_38 = utf8.len(var_44_36)
				local var_44_39 = var_44_37 <= 0 and var_44_33 or var_44_33 * (var_44_38 / var_44_37)

				if var_44_39 > 0 and var_44_33 < var_44_39 then
					arg_41_1.talkMaxDuration = var_44_39

					if var_44_39 + var_44_32 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_39 + var_44_32
					end
				end

				arg_41_1.text_.text = var_44_36
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107052", "107052010", "story_v_out_107052.awb") ~= 0 then
					local var_44_40 = manager.audio:GetVoiceLength("story_v_out_107052", "107052010", "story_v_out_107052.awb") / 1000

					if var_44_40 + var_44_32 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_40 + var_44_32
					end

					if var_44_35.prefab_name ~= "" and arg_41_1.actors_[var_44_35.prefab_name] ~= nil then
						local var_44_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_35.prefab_name].transform, "story_v_out_107052", "107052010", "story_v_out_107052.awb")

						arg_41_1:RecordAudio("107052010", var_44_41)
						arg_41_1:RecordAudio("107052010", var_44_41)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_107052", "107052010", "story_v_out_107052.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_107052", "107052010", "story_v_out_107052.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_42 = math.max(var_44_33, arg_41_1.talkMaxDuration)

			if var_44_32 <= arg_41_1.time_ and arg_41_1.time_ < var_44_32 + var_44_42 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_32) / var_44_42

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_32 + var_44_42 and arg_41_1.time_ < var_44_32 + var_44_42 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play107052011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 107052011
		arg_45_1.duration_ = 13.63

		local var_45_0 = {
			ja = 11.9,
			ko = 11.7,
			zh = 13.633,
			en = 11.766
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
				arg_45_0:Play107052012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1099ui_story"].transform
			local var_48_1 = 1.5

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1099ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, 100, 0)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1099ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, 100, 0)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				local var_48_11 = manager.ui.mainCamera.transform.localPosition
				local var_48_12 = Vector3.New(0, 0, 10) + Vector3.New(var_48_11.x, var_48_11.y, 0)
				local var_48_13 = arg_45_1.bgs_.C04a

				var_48_13.transform.localPosition = var_48_12
				var_48_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_14 = var_48_13:GetComponent("SpriteRenderer")

				if var_48_14 and var_48_14.sprite then
					local var_48_15 = (var_48_13.transform.localPosition - var_48_11).z
					local var_48_16 = manager.ui.mainCameraCom_
					local var_48_17 = 2 * var_48_15 * Mathf.Tan(var_48_16.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_48_18 = var_48_17 * var_48_16.aspect
					local var_48_19 = var_48_14.sprite.bounds.size.x
					local var_48_20 = var_48_14.sprite.bounds.size.y
					local var_48_21 = var_48_18 / var_48_19
					local var_48_22 = var_48_17 / var_48_20
					local var_48_23 = var_48_22 < var_48_21 and var_48_21 or var_48_22

					var_48_13.transform.localScale = Vector3.New(var_48_23, var_48_23, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "C04a" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_24 = "S0702"

			if arg_45_1.bgs_[var_48_24] == nil then
				local var_48_25 = Object.Instantiate(arg_45_1.paintGo_)

				var_48_25:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_48_24)
				var_48_25.name = var_48_24
				var_48_25.transform.parent = arg_45_1.stage_.transform
				var_48_25.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.bgs_[var_48_24] = var_48_25
			end

			local var_48_26 = 1.5

			if var_48_26 < arg_45_1.time_ and arg_45_1.time_ <= var_48_26 + arg_48_0 then
				local var_48_27 = manager.ui.mainCamera.transform.localPosition
				local var_48_28 = Vector3.New(0, 0, 10) + Vector3.New(var_48_27.x, var_48_27.y, 0)
				local var_48_29 = arg_45_1.bgs_.S0702

				var_48_29.transform.localPosition = var_48_28
				var_48_29.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_30 = var_48_29:GetComponent("SpriteRenderer")

				if var_48_30 and var_48_30.sprite then
					local var_48_31 = (var_48_29.transform.localPosition - var_48_27).z
					local var_48_32 = manager.ui.mainCameraCom_
					local var_48_33 = 2 * var_48_31 * Mathf.Tan(var_48_32.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_48_34 = var_48_33 * var_48_32.aspect
					local var_48_35 = var_48_30.sprite.bounds.size.x
					local var_48_36 = var_48_30.sprite.bounds.size.y
					local var_48_37 = var_48_34 / var_48_35
					local var_48_38 = var_48_33 / var_48_36
					local var_48_39 = var_48_38 < var_48_37 and var_48_37 or var_48_38

					var_48_29.transform.localScale = Vector3.New(var_48_39, var_48_39, 0)
				end

				for iter_48_2, iter_48_3 in pairs(arg_45_1.bgs_) do
					if iter_48_2 ~= "S0702" then
						iter_48_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_40 = arg_45_1.bgs_.C04a
			local var_48_41 = 0

			if var_48_41 < arg_45_1.time_ and arg_45_1.time_ <= var_48_41 + arg_48_0 then
				local var_48_42 = var_48_40:GetComponent("SpriteRenderer")

				if var_48_42 then
					arg_45_1.var_.alphaOldValueC04a = var_48_42.color.a
					arg_45_1.var_.alphaMatValueC04a = var_48_42
				end

				arg_45_1.var_.alphaOldValueC04a = 1
			end

			local var_48_43 = 1.5

			if var_48_41 <= arg_45_1.time_ and arg_45_1.time_ < var_48_41 + var_48_43 then
				local var_48_44 = (arg_45_1.time_ - var_48_41) / var_48_43
				local var_48_45 = Mathf.Lerp(arg_45_1.var_.alphaOldValueC04a, 0, var_48_44)

				if arg_45_1.var_.alphaMatValueC04a then
					local var_48_46 = arg_45_1.var_.alphaMatValueC04a.color

					var_48_46.a = var_48_45
					arg_45_1.var_.alphaMatValueC04a.color = var_48_46
				end
			end

			if arg_45_1.time_ >= var_48_41 + var_48_43 and arg_45_1.time_ < var_48_41 + var_48_43 + arg_48_0 and arg_45_1.var_.alphaMatValueC04a then
				local var_48_47 = arg_45_1.var_.alphaMatValueC04a
				local var_48_48 = var_48_47.color

				var_48_48.a = 0
				var_48_47.color = var_48_48
			end

			local var_48_49 = arg_45_1.bgs_.S0702
			local var_48_50 = 1.5

			if var_48_50 < arg_45_1.time_ and arg_45_1.time_ <= var_48_50 + arg_48_0 then
				local var_48_51 = var_48_49:GetComponent("SpriteRenderer")

				if var_48_51 then
					arg_45_1.var_.alphaOldValueS0702 = var_48_51.color.a
					arg_45_1.var_.alphaMatValueS0702 = var_48_51
				end

				arg_45_1.var_.alphaOldValueS0702 = 0
			end

			local var_48_52 = 1.5

			if var_48_50 <= arg_45_1.time_ and arg_45_1.time_ < var_48_50 + var_48_52 then
				local var_48_53 = (arg_45_1.time_ - var_48_50) / var_48_52
				local var_48_54 = Mathf.Lerp(arg_45_1.var_.alphaOldValueS0702, 1, var_48_53)

				if arg_45_1.var_.alphaMatValueS0702 then
					local var_48_55 = arg_45_1.var_.alphaMatValueS0702.color

					var_48_55.a = var_48_54
					arg_45_1.var_.alphaMatValueS0702.color = var_48_55
				end
			end

			if arg_45_1.time_ >= var_48_50 + var_48_52 and arg_45_1.time_ < var_48_50 + var_48_52 + arg_48_0 and arg_45_1.var_.alphaMatValueS0702 then
				local var_48_56 = arg_45_1.var_.alphaMatValueS0702
				local var_48_57 = var_48_56.color

				var_48_57.a = 1
				var_48_56.color = var_48_57
			end

			local var_48_58 = 0

			if var_48_58 < arg_45_1.time_ and arg_45_1.time_ <= var_48_58 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			local var_48_59 = 2.5

			if arg_45_1.time_ >= var_48_58 + var_48_59 and arg_45_1.time_ < var_48_58 + var_48_59 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_60 = 2.5
			local var_48_61 = 0.675

			if var_48_60 < arg_45_1.time_ and arg_45_1.time_ <= var_48_60 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_62 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_62:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_63 = arg_45_1:FormatText(StoryNameCfg[96].name)

				arg_45_1.leftNameTxt_.text = var_48_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3014")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_64 = arg_45_1:GetWordFromCfg(107052011)
				local var_48_65 = arg_45_1:FormatText(var_48_64.content)

				arg_45_1.text_.text = var_48_65

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_66 = 27
				local var_48_67 = utf8.len(var_48_65)
				local var_48_68 = var_48_66 <= 0 and var_48_61 or var_48_61 * (var_48_67 / var_48_66)

				if var_48_68 > 0 and var_48_61 < var_48_68 then
					arg_45_1.talkMaxDuration = var_48_68
					var_48_60 = var_48_60 + 0.3

					if var_48_68 + var_48_60 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_68 + var_48_60
					end
				end

				arg_45_1.text_.text = var_48_65
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107052", "107052011", "story_v_out_107052.awb") ~= 0 then
					local var_48_69 = manager.audio:GetVoiceLength("story_v_out_107052", "107052011", "story_v_out_107052.awb") / 1000

					if var_48_69 + var_48_60 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_69 + var_48_60
					end

					if var_48_64.prefab_name ~= "" and arg_45_1.actors_[var_48_64.prefab_name] ~= nil then
						local var_48_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_64.prefab_name].transform, "story_v_out_107052", "107052011", "story_v_out_107052.awb")

						arg_45_1:RecordAudio("107052011", var_48_70)
						arg_45_1:RecordAudio("107052011", var_48_70)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_107052", "107052011", "story_v_out_107052.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_107052", "107052011", "story_v_out_107052.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_71 = var_48_60 + 0.3
			local var_48_72 = math.max(var_48_61, arg_45_1.talkMaxDuration)

			if var_48_71 <= arg_45_1.time_ and arg_45_1.time_ < var_48_71 + var_48_72 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_71) / var_48_72

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_71 + var_48_72 and arg_45_1.time_ < var_48_71 + var_48_72 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play107052012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 107052012
		arg_51_1.duration_ = 5.87

		local var_51_0 = {
			ja = 3.266,
			ko = 4.633,
			zh = 5.866,
			en = 3.566
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play107052013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.35

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[96].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3014")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(107052012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 14
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107052", "107052012", "story_v_out_107052.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_107052", "107052012", "story_v_out_107052.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_107052", "107052012", "story_v_out_107052.awb")

						arg_51_1:RecordAudio("107052012", var_54_9)
						arg_51_1:RecordAudio("107052012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_107052", "107052012", "story_v_out_107052.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_107052", "107052012", "story_v_out_107052.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_10 and arg_51_1.time_ < var_54_0 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play107052013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 107052013
		arg_55_1.duration_ = 4.47

		local var_55_0 = {
			ja = 2.733,
			ko = 3.3,
			zh = 4.466,
			en = 3.733
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
				arg_55_0:Play107052014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.2

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[74].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(107052013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 8
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107052", "107052013", "story_v_out_107052.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_107052", "107052013", "story_v_out_107052.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_107052", "107052013", "story_v_out_107052.awb")

						arg_55_1:RecordAudio("107052013", var_58_9)
						arg_55_1:RecordAudio("107052013", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_107052", "107052013", "story_v_out_107052.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_107052", "107052013", "story_v_out_107052.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_10 and arg_55_1.time_ < var_58_0 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play107052014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 107052014
		arg_59_1.duration_ = 4.4

		local var_59_0 = {
			ja = 4.4,
			ko = 3.766,
			zh = 3.266,
			en = 3.833
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play107052015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.425

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[76].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:GetWordFromCfg(107052014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 17
				local var_62_6 = utf8.len(var_62_4)
				local var_62_7 = var_62_5 <= 0 and var_62_1 or var_62_1 * (var_62_6 / var_62_5)

				if var_62_7 > 0 and var_62_1 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107052", "107052014", "story_v_out_107052.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_107052", "107052014", "story_v_out_107052.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_107052", "107052014", "story_v_out_107052.awb")

						arg_59_1:RecordAudio("107052014", var_62_9)
						arg_59_1:RecordAudio("107052014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_107052", "107052014", "story_v_out_107052.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_107052", "107052014", "story_v_out_107052.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_10 and arg_59_1.time_ < var_62_0 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play107052015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 107052015
		arg_63_1.duration_ = 6.97

		local var_63_0 = {
			ja = 6.966,
			ko = 5.366,
			zh = 4.633,
			en = 5.633
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
				arg_63_0:Play107052016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.4

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[84].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(107052015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_107052", "107052015", "story_v_out_107052.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_107052", "107052015", "story_v_out_107052.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_107052", "107052015", "story_v_out_107052.awb")

						arg_63_1:RecordAudio("107052015", var_66_9)
						arg_63_1:RecordAudio("107052015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_107052", "107052015", "story_v_out_107052.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_107052", "107052015", "story_v_out_107052.awb")
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
	Play107052016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 107052016
		arg_67_1.duration_ = 10.67

		local var_67_0 = {
			ja = 8.766,
			ko = 5.1,
			zh = 10.666,
			en = 8.866
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
			arg_67_1.auto_ = false
		end

		function arg_67_1.playNext_(arg_69_0)
			arg_67_1.onStoryFinished_()
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.575

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[96].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3014")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(107052016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_107052", "107052016", "story_v_out_107052.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_107052", "107052016", "story_v_out_107052.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_107052", "107052016", "story_v_out_107052.awb")

						arg_67_1:RecordAudio("107052016", var_70_9)
						arg_67_1:RecordAudio("107052016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_107052", "107052016", "story_v_out_107052.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_107052", "107052016", "story_v_out_107052.awb")
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
	assets = {
		"TextureConfig/Background/C04a",
		"TextureConfig/Background/S0702"
	},
	voices = {
		"story_v_out_107052.awb"
	}
}
