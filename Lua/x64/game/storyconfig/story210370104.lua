return {
	Play103704001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103704001
		arg_1_1.duration_ = 6.5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play103704002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "S0903"

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
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.S0903

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
					if iter_4_0 ~= "S0903" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.S0903
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueS0903 = var_4_18.color.a
					arg_1_1.var_.alphaMatValueS0903 = var_4_18
				end

				arg_1_1.var_.alphaOldValueS0903 = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueS0903, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueS0903 then
					local var_4_22 = arg_1_1.var_.alphaMatValueS0903.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueS0903.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueS0903 then
				local var_4_23 = arg_1_1.var_.alphaMatValueS0903
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0
			local var_4_26 = 0.7

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_27 = "play"
				local var_4_28 = "music"

				arg_1_1:AudioAction(var_4_27, var_4_28, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_29 = ""
				local var_4_30 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_30 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_30 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_30

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_30
						arg_1_1.bgmTxt2_.text = var_4_30
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

			local var_4_31 = 1.5
			local var_4_32 = 0.5

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				local var_4_33 = "play"
				local var_4_34 = "music"

				arg_1_1:AudioAction(var_4_33, var_4_34, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_35 = ""
				local var_4_36 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_37 = 1.5
			local var_4_38 = 0.35

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_39 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_39:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_40 = arg_1_1:GetWordFromCfg(103704001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 14
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_38 or var_4_38 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_38 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_37 = var_4_37 + 0.3

					if var_4_44 + var_4_37 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_37
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_37 + 0.3
			local var_4_46 = math.max(var_4_38, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play103704002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 103704002
		arg_9_1.duration_ = 2.9

		local var_9_0 = {
			ja = 2.9,
			ko = 1,
			en = 1.2
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
				arg_9_0:Play103704003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.075

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[15].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(103704002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704002", "story_v_side_old_103704.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704002", "story_v_side_old_103704.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_side_old_103704", "103704002", "story_v_side_old_103704.awb")

						arg_9_1:RecordAudio("103704002", var_12_9)
						arg_9_1:RecordAudio("103704002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704002", "story_v_side_old_103704.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704002", "story_v_side_old_103704.awb")
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
	Play103704003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 103704003
		arg_13_1.duration_ = 5.73

		local var_13_0 = {
			ja = 5.066,
			ko = 5.2,
			en = 5.733
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
				arg_13_0:Play103704004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.45

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[5].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:GetWordFromCfg(103704003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 18
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704003", "story_v_side_old_103704.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704003", "story_v_side_old_103704.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_side_old_103704", "103704003", "story_v_side_old_103704.awb")

						arg_13_1:RecordAudio("103704003", var_16_9)
						arg_13_1:RecordAudio("103704003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704003", "story_v_side_old_103704.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704003", "story_v_side_old_103704.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play103704004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 103704004
		arg_17_1.duration_ = 8.57

		local var_17_0 = {
			ja = 8.566,
			ko = 6.2,
			en = 7.5
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
				arg_17_0:Play103704005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.575

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[15].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(103704004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704004", "story_v_side_old_103704.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704004", "story_v_side_old_103704.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_side_old_103704", "103704004", "story_v_side_old_103704.awb")

						arg_17_1:RecordAudio("103704004", var_20_9)
						arg_17_1:RecordAudio("103704004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704004", "story_v_side_old_103704.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704004", "story_v_side_old_103704.awb")
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
	Play103704005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 103704005
		arg_21_1.duration_ = 7.27

		local var_21_0 = {
			ja = 4.166,
			ko = 4.233,
			en = 7.266
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
				arg_21_0:Play103704006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.45

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[15].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(103704005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704005", "story_v_side_old_103704.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704005", "story_v_side_old_103704.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_side_old_103704", "103704005", "story_v_side_old_103704.awb")

						arg_21_1:RecordAudio("103704005", var_24_9)
						arg_21_1:RecordAudio("103704005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704005", "story_v_side_old_103704.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704005", "story_v_side_old_103704.awb")
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
	Play103704006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 103704006
		arg_25_1.duration_ = 7.23

		local var_25_0 = {
			ja = 7.233,
			ko = 5.233,
			en = 4.466
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
				arg_25_0:Play103704007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.675

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[15].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(103704006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704006", "story_v_side_old_103704.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704006", "story_v_side_old_103704.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_side_old_103704", "103704006", "story_v_side_old_103704.awb")

						arg_25_1:RecordAudio("103704006", var_28_9)
						arg_25_1:RecordAudio("103704006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704006", "story_v_side_old_103704.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704006", "story_v_side_old_103704.awb")
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
	Play103704007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 103704007
		arg_29_1.duration_ = 3.4

		local var_29_0 = {
			ja = 3.4,
			ko = 2.233,
			en = 2.333
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
				arg_29_0:Play103704008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.25

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[5].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(103704007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704007", "story_v_side_old_103704.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704007", "story_v_side_old_103704.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_side_old_103704", "103704007", "story_v_side_old_103704.awb")

						arg_29_1:RecordAudio("103704007", var_32_9)
						arg_29_1:RecordAudio("103704007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704007", "story_v_side_old_103704.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704007", "story_v_side_old_103704.awb")
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
	Play103704008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 103704008
		arg_33_1.duration_ = 2.07

		local var_33_0 = {
			ja = 1.033,
			ko = 0.766,
			en = 2.066
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
				arg_33_0:Play103704009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.05

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[15].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(103704008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704008", "story_v_side_old_103704.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704008", "story_v_side_old_103704.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_side_old_103704", "103704008", "story_v_side_old_103704.awb")

						arg_33_1:RecordAudio("103704008", var_36_9)
						arg_33_1:RecordAudio("103704008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704008", "story_v_side_old_103704.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704008", "story_v_side_old_103704.awb")
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
	Play103704009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 103704009
		arg_37_1.duration_ = 10.33

		local var_37_0 = {
			ja = 10.333,
			ko = 9.4,
			en = 8.1
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
				arg_37_0:Play103704010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.95

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[5].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(103704009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704009", "story_v_side_old_103704.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704009", "story_v_side_old_103704.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_side_old_103704", "103704009", "story_v_side_old_103704.awb")

						arg_37_1:RecordAudio("103704009", var_40_9)
						arg_37_1:RecordAudio("103704009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704009", "story_v_side_old_103704.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704009", "story_v_side_old_103704.awb")
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
	Play103704010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 103704010
		arg_41_1.duration_ = 8.73

		local var_41_0 = {
			ja = 8.733,
			ko = 8.2,
			en = 6.9
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
				arg_41_0:Play103704011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.625

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[15].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(103704010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 25
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704010", "story_v_side_old_103704.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704010", "story_v_side_old_103704.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_side_old_103704", "103704010", "story_v_side_old_103704.awb")

						arg_41_1:RecordAudio("103704010", var_44_9)
						arg_41_1:RecordAudio("103704010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704010", "story_v_side_old_103704.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704010", "story_v_side_old_103704.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play103704011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 103704011
		arg_45_1.duration_ = 7.03

		local var_45_0 = {
			ja = 7.033,
			ko = 6.2,
			en = 5.166
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
				arg_45_0:Play103704012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.65

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[5].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(103704011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704011", "story_v_side_old_103704.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704011", "story_v_side_old_103704.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_side_old_103704", "103704011", "story_v_side_old_103704.awb")

						arg_45_1:RecordAudio("103704011", var_48_9)
						arg_45_1:RecordAudio("103704011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704011", "story_v_side_old_103704.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704011", "story_v_side_old_103704.awb")
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
	Play103704012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 103704012
		arg_49_1.duration_ = 10.67

		local var_49_0 = {
			ja = 10.133,
			ko = 10.666,
			en = 10.266
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play103704013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 1

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[15].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(103704012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 40
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704012", "story_v_side_old_103704.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704012", "story_v_side_old_103704.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_side_old_103704", "103704012", "story_v_side_old_103704.awb")

						arg_49_1:RecordAudio("103704012", var_52_9)
						arg_49_1:RecordAudio("103704012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704012", "story_v_side_old_103704.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704012", "story_v_side_old_103704.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play103704013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 103704013
		arg_53_1.duration_ = 5.37

		local var_53_0 = {
			ja = 5.366,
			ko = 4.366,
			en = 2.966
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
				arg_53_0:Play103704014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.35

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[5].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(103704013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 14
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704013", "story_v_side_old_103704.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704013", "story_v_side_old_103704.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_side_old_103704", "103704013", "story_v_side_old_103704.awb")

						arg_53_1:RecordAudio("103704013", var_56_9)
						arg_53_1:RecordAudio("103704013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704013", "story_v_side_old_103704.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704013", "story_v_side_old_103704.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play103704014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 103704014
		arg_57_1.duration_ = 11.6

		local var_57_0 = {
			ja = 10.1,
			ko = 7.666,
			en = 11.6
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
				arg_57_0:Play103704015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.75

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[15].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(103704014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704014", "story_v_side_old_103704.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704014", "story_v_side_old_103704.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_side_old_103704", "103704014", "story_v_side_old_103704.awb")

						arg_57_1:RecordAudio("103704014", var_60_9)
						arg_57_1:RecordAudio("103704014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704014", "story_v_side_old_103704.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704014", "story_v_side_old_103704.awb")
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
	Play103704015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 103704015
		arg_61_1.duration_ = 4.07

		local var_61_0 = {
			ja = 2.133,
			ko = 4.066,
			en = 3.1
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
				arg_61_0:Play103704016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.375

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[5].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(103704015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 15
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704015", "story_v_side_old_103704.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704015", "story_v_side_old_103704.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_side_old_103704", "103704015", "story_v_side_old_103704.awb")

						arg_61_1:RecordAudio("103704015", var_64_9)
						arg_61_1:RecordAudio("103704015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704015", "story_v_side_old_103704.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704015", "story_v_side_old_103704.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play103704016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 103704016
		arg_65_1.duration_ = 11.2

		local var_65_0 = {
			ja = 11.2,
			ko = 10.3,
			en = 9.033
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
				arg_65_0:Play103704017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.875

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[5].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(103704016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704016", "story_v_side_old_103704.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704016", "story_v_side_old_103704.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_side_old_103704", "103704016", "story_v_side_old_103704.awb")

						arg_65_1:RecordAudio("103704016", var_68_9)
						arg_65_1:RecordAudio("103704016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704016", "story_v_side_old_103704.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704016", "story_v_side_old_103704.awb")
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
	Play103704017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 103704017
		arg_69_1.duration_ = 6.9

		local var_69_0 = {
			ja = 5.8,
			ko = 6.9,
			en = 4.5
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
				arg_69_0:Play103704018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.45

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[15].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(103704017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 18
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704017", "story_v_side_old_103704.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704017", "story_v_side_old_103704.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_side_old_103704", "103704017", "story_v_side_old_103704.awb")

						arg_69_1:RecordAudio("103704017", var_72_9)
						arg_69_1:RecordAudio("103704017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704017", "story_v_side_old_103704.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704017", "story_v_side_old_103704.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play103704018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 103704018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play103704019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.825

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_2 = arg_73_1:GetWordFromCfg(103704018)
				local var_76_3 = arg_73_1:FormatText(var_76_2.content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 33
				local var_76_5 = utf8.len(var_76_3)
				local var_76_6 = var_76_4 <= 0 and var_76_1 or var_76_1 * (var_76_5 / var_76_4)

				if var_76_6 > 0 and var_76_1 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_7 and arg_73_1.time_ < var_76_0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play103704019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 103704019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play103704020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.775

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(103704019)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 31
				local var_80_5 = utf8.len(var_80_3)
				local var_80_6 = var_80_4 <= 0 and var_80_1 or var_80_1 * (var_80_5 / var_80_4)

				if var_80_6 > 0 and var_80_1 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_7 and arg_77_1.time_ < var_80_0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play103704020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 103704020
		arg_81_1.duration_ = 2.4

		local var_81_0 = {
			ja = 2.4,
			ko = 2.066,
			en = 1.6
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
				arg_81_0:Play103704021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.225

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[5].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(103704020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704020", "story_v_side_old_103704.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704020", "story_v_side_old_103704.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_side_old_103704", "103704020", "story_v_side_old_103704.awb")

						arg_81_1:RecordAudio("103704020", var_84_9)
						arg_81_1:RecordAudio("103704020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704020", "story_v_side_old_103704.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704020", "story_v_side_old_103704.awb")
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
	Play103704021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 103704021
		arg_85_1.duration_ = 4.37

		local var_85_0 = {
			ja = 4.366,
			ko = 1.2,
			en = 1.033
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
				arg_85_0:Play103704022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.05

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[15].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(103704021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 2
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704021", "story_v_side_old_103704.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704021", "story_v_side_old_103704.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_side_old_103704", "103704021", "story_v_side_old_103704.awb")

						arg_85_1:RecordAudio("103704021", var_88_9)
						arg_85_1:RecordAudio("103704021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704021", "story_v_side_old_103704.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704021", "story_v_side_old_103704.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_10 and arg_85_1.time_ < var_88_0 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play103704022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 103704022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play103704023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.975

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(103704022)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 39
				local var_92_5 = utf8.len(var_92_3)
				local var_92_6 = var_92_4 <= 0 and var_92_1 or var_92_1 * (var_92_5 / var_92_4)

				if var_92_6 > 0 and var_92_1 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_7 and arg_89_1.time_ < var_92_0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play103704023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 103704023
		arg_93_1.duration_ = 4.1

		local var_93_0 = {
			ja = 2.9,
			ko = 3.333,
			en = 4.1
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
				arg_93_0:Play103704024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.275

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[5].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(103704023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 11
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704023", "story_v_side_old_103704.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704023", "story_v_side_old_103704.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_side_old_103704", "103704023", "story_v_side_old_103704.awb")

						arg_93_1:RecordAudio("103704023", var_96_9)
						arg_93_1:RecordAudio("103704023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704023", "story_v_side_old_103704.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704023", "story_v_side_old_103704.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play103704024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 103704024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play103704025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 1.175

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(103704024)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 47
				local var_100_5 = utf8.len(var_100_3)
				local var_100_6 = var_100_4 <= 0 and var_100_1 or var_100_1 * (var_100_5 / var_100_4)

				if var_100_6 > 0 and var_100_1 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_7 and arg_97_1.time_ < var_100_0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play103704025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 103704025
		arg_101_1.duration_ = 4.13

		local var_101_0 = {
			ja = 4.133,
			ko = 2.8,
			en = 4.133
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
				arg_101_0:Play103704026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.225

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[5].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:GetWordFromCfg(103704025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704025", "story_v_side_old_103704.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704025", "story_v_side_old_103704.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_side_old_103704", "103704025", "story_v_side_old_103704.awb")

						arg_101_1:RecordAudio("103704025", var_104_9)
						arg_101_1:RecordAudio("103704025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704025", "story_v_side_old_103704.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704025", "story_v_side_old_103704.awb")
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
	Play103704026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 103704026
		arg_105_1.duration_ = 9.57

		local var_105_0 = {
			ja = 9.566,
			ko = 4.966,
			en = 4.866
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
				arg_105_0:Play103704027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.35

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[15].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:GetWordFromCfg(103704026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 14
				local var_108_6 = utf8.len(var_108_4)
				local var_108_7 = var_108_5 <= 0 and var_108_1 or var_108_1 * (var_108_6 / var_108_5)

				if var_108_7 > 0 and var_108_1 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704026", "story_v_side_old_103704.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704026", "story_v_side_old_103704.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_side_old_103704", "103704026", "story_v_side_old_103704.awb")

						arg_105_1:RecordAudio("103704026", var_108_9)
						arg_105_1:RecordAudio("103704026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704026", "story_v_side_old_103704.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704026", "story_v_side_old_103704.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_10 and arg_105_1.time_ < var_108_0 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play103704027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 103704027
		arg_109_1.duration_ = 6.07

		local var_109_0 = {
			ja = 6.066,
			ko = 4.2,
			en = 2.966
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
				arg_109_0:Play103704028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.375

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[5].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(103704027)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 15
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704027", "story_v_side_old_103704.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704027", "story_v_side_old_103704.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_side_old_103704", "103704027", "story_v_side_old_103704.awb")

						arg_109_1:RecordAudio("103704027", var_112_9)
						arg_109_1:RecordAudio("103704027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704027", "story_v_side_old_103704.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704027", "story_v_side_old_103704.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_10 and arg_109_1.time_ < var_112_0 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play103704028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 103704028
		arg_113_1.duration_ = 8.4

		local var_113_0 = {
			ja = 8.4,
			ko = 5.7,
			en = 4.233
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
				arg_113_0:Play103704029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.3

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[15].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:GetWordFromCfg(103704028)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 12
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704028", "story_v_side_old_103704.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704028", "story_v_side_old_103704.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_side_old_103704", "103704028", "story_v_side_old_103704.awb")

						arg_113_1:RecordAudio("103704028", var_116_9)
						arg_113_1:RecordAudio("103704028", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704028", "story_v_side_old_103704.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704028", "story_v_side_old_103704.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_10 and arg_113_1.time_ < var_116_0 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play103704029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 103704029
		arg_117_1.duration_ = 6.27

		local var_117_0 = {
			ja = 6.266,
			ko = 3.6,
			en = 5.933
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
				arg_117_0:Play103704030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.425

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[5].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(103704029)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 17
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704029", "story_v_side_old_103704.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704029", "story_v_side_old_103704.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_side_old_103704", "103704029", "story_v_side_old_103704.awb")

						arg_117_1:RecordAudio("103704029", var_120_9)
						arg_117_1:RecordAudio("103704029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704029", "story_v_side_old_103704.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704029", "story_v_side_old_103704.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play103704030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 103704030
		arg_121_1.duration_ = 5.83

		local var_121_0 = {
			ja = 5.833,
			ko = 4.066,
			en = 5.833
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
				arg_121_0:Play103704031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.325

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[15].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:GetWordFromCfg(103704030)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 13
				local var_124_6 = utf8.len(var_124_4)
				local var_124_7 = var_124_5 <= 0 and var_124_1 or var_124_1 * (var_124_6 / var_124_5)

				if var_124_7 > 0 and var_124_1 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704030", "story_v_side_old_103704.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704030", "story_v_side_old_103704.awb") / 1000

					if var_124_8 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_0
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_side_old_103704", "103704030", "story_v_side_old_103704.awb")

						arg_121_1:RecordAudio("103704030", var_124_9)
						arg_121_1:RecordAudio("103704030", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704030", "story_v_side_old_103704.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704030", "story_v_side_old_103704.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_10 and arg_121_1.time_ < var_124_0 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play103704031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 103704031
		arg_125_1.duration_ = 8.7

		local var_125_0 = {
			ja = 8.7,
			ko = 6.433,
			en = 7.1
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
				arg_125_0:Play103704032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.75

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[5].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:GetWordFromCfg(103704031)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704031", "story_v_side_old_103704.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704031", "story_v_side_old_103704.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_side_old_103704", "103704031", "story_v_side_old_103704.awb")

						arg_125_1:RecordAudio("103704031", var_128_9)
						arg_125_1:RecordAudio("103704031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704031", "story_v_side_old_103704.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704031", "story_v_side_old_103704.awb")
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
	Play103704032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 103704032
		arg_129_1.duration_ = 3.87

		local var_129_0 = {
			ja = 3.866,
			ko = 1.333,
			en = 1.4
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
				arg_129_0:Play103704033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.1

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[15].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(103704032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 4
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704032", "story_v_side_old_103704.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704032", "story_v_side_old_103704.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_side_old_103704", "103704032", "story_v_side_old_103704.awb")

						arg_129_1:RecordAudio("103704032", var_132_9)
						arg_129_1:RecordAudio("103704032", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704032", "story_v_side_old_103704.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704032", "story_v_side_old_103704.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_10 and arg_129_1.time_ < var_132_0 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play103704033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 103704033
		arg_133_1.duration_ = 8.5

		local var_133_0 = {
			ja = 8.5,
			ko = 5.266,
			en = 7.2
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
				arg_133_0:Play103704034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.65

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[5].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(103704033)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 26
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704033", "story_v_side_old_103704.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704033", "story_v_side_old_103704.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_side_old_103704", "103704033", "story_v_side_old_103704.awb")

						arg_133_1:RecordAudio("103704033", var_136_9)
						arg_133_1:RecordAudio("103704033", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704033", "story_v_side_old_103704.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704033", "story_v_side_old_103704.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play103704034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 103704034
		arg_137_1.duration_ = 11.2

		local var_137_0 = {
			ja = 11.2,
			ko = 7.6,
			en = 7.366
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play103704035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.925

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[5].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:GetWordFromCfg(103704034)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 37
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704034", "story_v_side_old_103704.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704034", "story_v_side_old_103704.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_side_old_103704", "103704034", "story_v_side_old_103704.awb")

						arg_137_1:RecordAudio("103704034", var_140_9)
						arg_137_1:RecordAudio("103704034", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704034", "story_v_side_old_103704.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704034", "story_v_side_old_103704.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_10 and arg_137_1.time_ < var_140_0 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play103704035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 103704035
		arg_141_1.duration_ = 5.27

		local var_141_0 = {
			ja = 5.2,
			ko = 3.6,
			en = 5.266
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
				arg_141_0:Play103704036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.45

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[5].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(103704035)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 18
				local var_144_6 = utf8.len(var_144_4)
				local var_144_7 = var_144_5 <= 0 and var_144_1 or var_144_1 * (var_144_6 / var_144_5)

				if var_144_7 > 0 and var_144_1 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704035", "story_v_side_old_103704.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704035", "story_v_side_old_103704.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_side_old_103704", "103704035", "story_v_side_old_103704.awb")

						arg_141_1:RecordAudio("103704035", var_144_9)
						arg_141_1:RecordAudio("103704035", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704035", "story_v_side_old_103704.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704035", "story_v_side_old_103704.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_10 and arg_141_1.time_ < var_144_0 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play103704036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 103704036
		arg_145_1.duration_ = 6.17

		local var_145_0 = {
			ja = 6.166,
			ko = 5.666,
			en = 4.866
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play103704037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.55

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[15].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_3 = arg_145_1:GetWordFromCfg(103704036)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 22
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704036", "story_v_side_old_103704.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704036", "story_v_side_old_103704.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_side_old_103704", "103704036", "story_v_side_old_103704.awb")

						arg_145_1:RecordAudio("103704036", var_148_9)
						arg_145_1:RecordAudio("103704036", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704036", "story_v_side_old_103704.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704036", "story_v_side_old_103704.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play103704037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 103704037
		arg_149_1.duration_ = 10.03

		local var_149_0 = {
			ja = 10.033,
			ko = 7.733,
			en = 8.266
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
				arg_149_0:Play103704038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.825

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[15].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(103704037)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 33
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704037", "story_v_side_old_103704.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704037", "story_v_side_old_103704.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_side_old_103704", "103704037", "story_v_side_old_103704.awb")

						arg_149_1:RecordAudio("103704037", var_152_9)
						arg_149_1:RecordAudio("103704037", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704037", "story_v_side_old_103704.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704037", "story_v_side_old_103704.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_10 and arg_149_1.time_ < var_152_0 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play103704038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 103704038
		arg_153_1.duration_ = 9

		local var_153_0 = {
			ja = 5.533,
			ko = 7.566,
			en = 9
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
				arg_153_0:Play103704039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.775

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[5].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(103704038)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 31
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704038", "story_v_side_old_103704.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704038", "story_v_side_old_103704.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_side_old_103704", "103704038", "story_v_side_old_103704.awb")

						arg_153_1:RecordAudio("103704038", var_156_9)
						arg_153_1:RecordAudio("103704038", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704038", "story_v_side_old_103704.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704038", "story_v_side_old_103704.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play103704039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 103704039
		arg_157_1.duration_ = 12.9

		local var_157_0 = {
			ja = 12.9,
			ko = 10.166,
			en = 8.2
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
				arg_157_0:Play103704040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 1

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[5].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(103704039)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 40
				local var_160_6 = utf8.len(var_160_4)
				local var_160_7 = var_160_5 <= 0 and var_160_1 or var_160_1 * (var_160_6 / var_160_5)

				if var_160_7 > 0 and var_160_1 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704039", "story_v_side_old_103704.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704039", "story_v_side_old_103704.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_side_old_103704", "103704039", "story_v_side_old_103704.awb")

						arg_157_1:RecordAudio("103704039", var_160_9)
						arg_157_1:RecordAudio("103704039", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704039", "story_v_side_old_103704.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704039", "story_v_side_old_103704.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_10 and arg_157_1.time_ < var_160_0 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play103704040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 103704040
		arg_161_1.duration_ = 6.77

		local var_161_0 = {
			ja = 6.766,
			ko = 4.366,
			en = 5.3
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
				arg_161_0:Play103704041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.425

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[5].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(103704040)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704040", "story_v_side_old_103704.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704040", "story_v_side_old_103704.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_side_old_103704", "103704040", "story_v_side_old_103704.awb")

						arg_161_1:RecordAudio("103704040", var_164_9)
						arg_161_1:RecordAudio("103704040", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704040", "story_v_side_old_103704.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704040", "story_v_side_old_103704.awb")
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
	Play103704041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 103704041
		arg_165_1.duration_ = 3.1

		local var_165_0 = {
			ja = 2.266,
			ko = 3.1,
			en = 1.366
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
				arg_165_0:Play103704042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.075

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[15].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:GetWordFromCfg(103704041)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 3
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704041", "story_v_side_old_103704.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704041", "story_v_side_old_103704.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_side_old_103704", "103704041", "story_v_side_old_103704.awb")

						arg_165_1:RecordAudio("103704041", var_168_9)
						arg_165_1:RecordAudio("103704041", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704041", "story_v_side_old_103704.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704041", "story_v_side_old_103704.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play103704042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 103704042
		arg_169_1.duration_ = 9.63

		local var_169_0 = {
			ja = 9.633,
			ko = 4.166,
			en = 5.8
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play103704043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.425

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[5].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:GetWordFromCfg(103704042)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 17
				local var_172_6 = utf8.len(var_172_4)
				local var_172_7 = var_172_5 <= 0 and var_172_1 or var_172_1 * (var_172_6 / var_172_5)

				if var_172_7 > 0 and var_172_1 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704042", "story_v_side_old_103704.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704042", "story_v_side_old_103704.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_side_old_103704", "103704042", "story_v_side_old_103704.awb")

						arg_169_1:RecordAudio("103704042", var_172_9)
						arg_169_1:RecordAudio("103704042", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704042", "story_v_side_old_103704.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704042", "story_v_side_old_103704.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_10 and arg_169_1.time_ < var_172_0 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play103704043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 103704043
		arg_173_1.duration_ = 3.83

		local var_173_0 = {
			ja = 3.133,
			ko = 3.833,
			en = 3.2
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
				arg_173_0:Play103704044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.325

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[15].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:GetWordFromCfg(103704043)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 13
				local var_176_6 = utf8.len(var_176_4)
				local var_176_7 = var_176_5 <= 0 and var_176_1 or var_176_1 * (var_176_6 / var_176_5)

				if var_176_7 > 0 and var_176_1 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704043", "story_v_side_old_103704.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704043", "story_v_side_old_103704.awb") / 1000

					if var_176_8 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_0
					end

					if var_176_3.prefab_name ~= "" and arg_173_1.actors_[var_176_3.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_3.prefab_name].transform, "story_v_side_old_103704", "103704043", "story_v_side_old_103704.awb")

						arg_173_1:RecordAudio("103704043", var_176_9)
						arg_173_1:RecordAudio("103704043", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704043", "story_v_side_old_103704.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704043", "story_v_side_old_103704.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_10 and arg_173_1.time_ < var_176_0 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play103704044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 103704044
		arg_177_1.duration_ = 6.4

		local var_177_0 = {
			ja = 6.1,
			ko = 6.4,
			en = 6.366
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
				arg_177_0:Play103704045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.825

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[5].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(103704044)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 33
				local var_180_6 = utf8.len(var_180_4)
				local var_180_7 = var_180_5 <= 0 and var_180_1 or var_180_1 * (var_180_6 / var_180_5)

				if var_180_7 > 0 and var_180_1 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704044", "story_v_side_old_103704.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704044", "story_v_side_old_103704.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_side_old_103704", "103704044", "story_v_side_old_103704.awb")

						arg_177_1:RecordAudio("103704044", var_180_9)
						arg_177_1:RecordAudio("103704044", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704044", "story_v_side_old_103704.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704044", "story_v_side_old_103704.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_10 and arg_177_1.time_ < var_180_0 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play103704045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 103704045
		arg_181_1.duration_ = 8.03

		local var_181_0 = {
			ja = 8.033,
			ko = 4.9,
			en = 8
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
				arg_181_0:Play103704046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.575

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[5].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:GetWordFromCfg(103704045)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 23
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704045", "story_v_side_old_103704.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704045", "story_v_side_old_103704.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_side_old_103704", "103704045", "story_v_side_old_103704.awb")

						arg_181_1:RecordAudio("103704045", var_184_9)
						arg_181_1:RecordAudio("103704045", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704045", "story_v_side_old_103704.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704045", "story_v_side_old_103704.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_10 and arg_181_1.time_ < var_184_0 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play103704046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 103704046
		arg_185_1.duration_ = 9.2

		local var_185_0 = {
			ja = 9.2,
			ko = 8.133,
			en = 7.1
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
				arg_185_0:Play103704047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.875

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[5].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:GetWordFromCfg(103704046)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 35
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704046", "story_v_side_old_103704.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704046", "story_v_side_old_103704.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_side_old_103704", "103704046", "story_v_side_old_103704.awb")

						arg_185_1:RecordAudio("103704046", var_188_9)
						arg_185_1:RecordAudio("103704046", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704046", "story_v_side_old_103704.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704046", "story_v_side_old_103704.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_10 and arg_185_1.time_ < var_188_0 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play103704047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 103704047
		arg_189_1.duration_ = 12

		local var_189_0 = {
			ja = 12,
			ko = 5.766,
			en = 5.333
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
				arg_189_0:Play103704048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.45

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[15].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:GetWordFromCfg(103704047)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 18
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704047", "story_v_side_old_103704.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704047", "story_v_side_old_103704.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_side_old_103704", "103704047", "story_v_side_old_103704.awb")

						arg_189_1:RecordAudio("103704047", var_192_9)
						arg_189_1:RecordAudio("103704047", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704047", "story_v_side_old_103704.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704047", "story_v_side_old_103704.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play103704048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 103704048
		arg_193_1.duration_ = 6.8

		local var_193_0 = {
			ja = 6.8,
			ko = 4.1,
			en = 5.9
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play103704049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.525

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[5].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(103704048)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 21
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704048", "story_v_side_old_103704.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704048", "story_v_side_old_103704.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_side_old_103704", "103704048", "story_v_side_old_103704.awb")

						arg_193_1:RecordAudio("103704048", var_196_9)
						arg_193_1:RecordAudio("103704048", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704048", "story_v_side_old_103704.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704048", "story_v_side_old_103704.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_10 and arg_193_1.time_ < var_196_0 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play103704049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 103704049
		arg_197_1.duration_ = 1.67

		local var_197_0 = {
			ja = 1.1,
			ko = 0.8,
			en = 1.666
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play103704050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.05

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[15].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(103704049)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 2
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704049", "story_v_side_old_103704.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704049", "story_v_side_old_103704.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_side_old_103704", "103704049", "story_v_side_old_103704.awb")

						arg_197_1:RecordAudio("103704049", var_200_9)
						arg_197_1:RecordAudio("103704049", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704049", "story_v_side_old_103704.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704049", "story_v_side_old_103704.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_10 and arg_197_1.time_ < var_200_0 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play103704050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 103704050
		arg_201_1.duration_ = 4.8

		local var_201_0 = {
			ja = 4.8,
			ko = 1.866,
			en = 3.366
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play103704051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.225

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[5].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(103704050)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 9
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_1 or var_204_1 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_1 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704050", "story_v_side_old_103704.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704050", "story_v_side_old_103704.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_side_old_103704", "103704050", "story_v_side_old_103704.awb")

						arg_201_1:RecordAudio("103704050", var_204_9)
						arg_201_1:RecordAudio("103704050", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704050", "story_v_side_old_103704.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704050", "story_v_side_old_103704.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_10 and arg_201_1.time_ < var_204_0 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play103704051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 103704051
		arg_205_1.duration_ = 3.13

		local var_205_0 = {
			ja = 1.8,
			ko = 2.1,
			en = 3.133
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
				arg_205_0:Play103704052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.05

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[15].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:GetWordFromCfg(103704051)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 2
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704051", "story_v_side_old_103704.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704051", "story_v_side_old_103704.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_side_old_103704", "103704051", "story_v_side_old_103704.awb")

						arg_205_1:RecordAudio("103704051", var_208_9)
						arg_205_1:RecordAudio("103704051", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704051", "story_v_side_old_103704.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704051", "story_v_side_old_103704.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_10 and arg_205_1.time_ < var_208_0 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play103704052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 103704052
		arg_209_1.duration_ = 9.53

		local var_209_0 = {
			ja = 7.166,
			ko = 7.233,
			en = 9.533
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play103704053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.8

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[5].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_3 = arg_209_1:GetWordFromCfg(103704052)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 32
				local var_212_6 = utf8.len(var_212_4)
				local var_212_7 = var_212_5 <= 0 and var_212_1 or var_212_1 * (var_212_6 / var_212_5)

				if var_212_7 > 0 and var_212_1 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704052", "story_v_side_old_103704.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704052", "story_v_side_old_103704.awb") / 1000

					if var_212_8 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_0
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_side_old_103704", "103704052", "story_v_side_old_103704.awb")

						arg_209_1:RecordAudio("103704052", var_212_9)
						arg_209_1:RecordAudio("103704052", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704052", "story_v_side_old_103704.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704052", "story_v_side_old_103704.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_10 and arg_209_1.time_ < var_212_0 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play103704053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 103704053
		arg_213_1.duration_ = 6.1

		local var_213_0 = {
			ja = 6.1,
			ko = 5.2,
			en = 5.333
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play103704054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.375

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[15].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(103704053)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 15
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704053", "story_v_side_old_103704.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704053", "story_v_side_old_103704.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_side_old_103704", "103704053", "story_v_side_old_103704.awb")

						arg_213_1:RecordAudio("103704053", var_216_9)
						arg_213_1:RecordAudio("103704053", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704053", "story_v_side_old_103704.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704053", "story_v_side_old_103704.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_10 and arg_213_1.time_ < var_216_0 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play103704054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 103704054
		arg_217_1.duration_ = 6.2

		local var_217_0 = {
			ja = 4.666,
			ko = 4.4,
			en = 6.2
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play103704055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.375

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[5].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_3 = arg_217_1:GetWordFromCfg(103704054)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 15
				local var_220_6 = utf8.len(var_220_4)
				local var_220_7 = var_220_5 <= 0 and var_220_1 or var_220_1 * (var_220_6 / var_220_5)

				if var_220_7 > 0 and var_220_1 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704054", "story_v_side_old_103704.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704054", "story_v_side_old_103704.awb") / 1000

					if var_220_8 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_0
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_side_old_103704", "103704054", "story_v_side_old_103704.awb")

						arg_217_1:RecordAudio("103704054", var_220_9)
						arg_217_1:RecordAudio("103704054", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704054", "story_v_side_old_103704.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704054", "story_v_side_old_103704.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_10 and arg_217_1.time_ < var_220_0 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play103704055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 103704055
		arg_221_1.duration_ = 2.33

		local var_221_0 = {
			ja = 2.333,
			ko = 1.333,
			en = 1.7
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play103704056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.075

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[15].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_3 = arg_221_1:GetWordFromCfg(103704055)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 3
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704055", "story_v_side_old_103704.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704055", "story_v_side_old_103704.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_side_old_103704", "103704055", "story_v_side_old_103704.awb")

						arg_221_1:RecordAudio("103704055", var_224_9)
						arg_221_1:RecordAudio("103704055", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704055", "story_v_side_old_103704.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704055", "story_v_side_old_103704.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_10 and arg_221_1.time_ < var_224_0 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play103704056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 103704056
		arg_225_1.duration_ = 12.03

		local var_225_0 = {
			ja = 9.633,
			ko = 7.766,
			en = 12.033
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
				arg_225_0:Play103704057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 1.025

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[5].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_3 = arg_225_1:GetWordFromCfg(103704056)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704056", "story_v_side_old_103704.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704056", "story_v_side_old_103704.awb") / 1000

					if var_228_8 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_0
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_side_old_103704", "103704056", "story_v_side_old_103704.awb")

						arg_225_1:RecordAudio("103704056", var_228_9)
						arg_225_1:RecordAudio("103704056", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704056", "story_v_side_old_103704.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704056", "story_v_side_old_103704.awb")
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
	Play103704057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 103704057
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play103704058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.35

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_2 = arg_229_1:GetWordFromCfg(103704057)
				local var_232_3 = arg_229_1:FormatText(var_232_2.content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 14
				local var_232_5 = utf8.len(var_232_3)
				local var_232_6 = var_232_4 <= 0 and var_232_1 or var_232_1 * (var_232_5 / var_232_4)

				if var_232_6 > 0 and var_232_1 < var_232_6 then
					arg_229_1.talkMaxDuration = var_232_6

					if var_232_6 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_6 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_7 and arg_229_1.time_ < var_232_0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play103704058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 103704058
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play103704060(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.4

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_2 = arg_233_1:GetWordFromCfg(103704058)
				local var_236_3 = arg_233_1:FormatText(var_236_2.content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 16
				local var_236_5 = utf8.len(var_236_3)
				local var_236_6 = var_236_4 <= 0 and var_236_1 or var_236_1 * (var_236_5 / var_236_4)

				if var_236_6 > 0 and var_236_1 < var_236_6 then
					arg_233_1.talkMaxDuration = var_236_6

					if var_236_6 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_6 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_7 and arg_233_1.time_ < var_236_0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play103704060 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 103704060
		arg_237_1.duration_ = 5.87

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play103704061(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = "ST12"

			if arg_237_1.bgs_[var_240_0] == nil then
				local var_240_1 = Object.Instantiate(arg_237_1.paintGo_)

				var_240_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_240_0)
				var_240_1.name = var_240_0
				var_240_1.transform.parent = arg_237_1.stage_.transform
				var_240_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.bgs_[var_240_0] = var_240_1
			end

			local var_240_2 = 0

			if var_240_2 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				local var_240_3 = manager.ui.mainCamera.transform.localPosition
				local var_240_4 = Vector3.New(0, 0, 10) + Vector3.New(var_240_3.x, var_240_3.y, 0)
				local var_240_5 = arg_237_1.bgs_.ST12

				var_240_5.transform.localPosition = var_240_4
				var_240_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_240_6 = var_240_5:GetComponent("SpriteRenderer")

				if var_240_6 and var_240_6.sprite then
					local var_240_7 = (var_240_5.transform.localPosition - var_240_3).z
					local var_240_8 = manager.ui.mainCameraCom_
					local var_240_9 = 2 * var_240_7 * Mathf.Tan(var_240_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_240_10 = var_240_9 * var_240_8.aspect
					local var_240_11 = var_240_6.sprite.bounds.size.x
					local var_240_12 = var_240_6.sprite.bounds.size.y
					local var_240_13 = var_240_10 / var_240_11
					local var_240_14 = var_240_9 / var_240_12
					local var_240_15 = var_240_14 < var_240_13 and var_240_13 or var_240_14

					var_240_5.transform.localScale = Vector3.New(var_240_15, var_240_15, 0)
				end

				for iter_240_0, iter_240_1 in pairs(arg_237_1.bgs_) do
					if iter_240_0 ~= "ST12" then
						iter_240_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_240_16 = arg_237_1.bgs_.S0903
			local var_240_17 = 0

			if var_240_17 < arg_237_1.time_ and arg_237_1.time_ <= var_240_17 + arg_240_0 then
				local var_240_18 = var_240_16:GetComponent("SpriteRenderer")

				if var_240_18 then
					arg_237_1.var_.alphaOldValueS0903 = var_240_18.color.a
					arg_237_1.var_.alphaMatValueS0903 = var_240_18
				end

				arg_237_1.var_.alphaOldValueS0903 = 1
			end

			local var_240_19 = 1.5

			if var_240_17 <= arg_237_1.time_ and arg_237_1.time_ < var_240_17 + var_240_19 then
				local var_240_20 = (arg_237_1.time_ - var_240_17) / var_240_19
				local var_240_21 = Mathf.Lerp(arg_237_1.var_.alphaOldValueS0903, 0, var_240_20)

				if arg_237_1.var_.alphaMatValueS0903 then
					local var_240_22 = arg_237_1.var_.alphaMatValueS0903.color

					var_240_22.a = var_240_21
					arg_237_1.var_.alphaMatValueS0903.color = var_240_22
				end
			end

			if arg_237_1.time_ >= var_240_17 + var_240_19 and arg_237_1.time_ < var_240_17 + var_240_19 + arg_240_0 and arg_237_1.var_.alphaMatValueS0903 then
				local var_240_23 = arg_237_1.var_.alphaMatValueS0903
				local var_240_24 = var_240_23.color

				var_240_24.a = 0
				var_240_23.color = var_240_24
			end

			local var_240_25 = arg_237_1.bgs_.ST12
			local var_240_26 = 1.5

			if var_240_26 < arg_237_1.time_ and arg_237_1.time_ <= var_240_26 + arg_240_0 then
				local var_240_27 = var_240_25:GetComponent("SpriteRenderer")

				if var_240_27 then
					arg_237_1.var_.alphaOldValueST12 = var_240_27.color.a
					arg_237_1.var_.alphaMatValueST12 = var_240_27
				end

				arg_237_1.var_.alphaOldValueST12 = 0
			end

			local var_240_28 = 1.5

			if var_240_26 <= arg_237_1.time_ and arg_237_1.time_ < var_240_26 + var_240_28 then
				local var_240_29 = (arg_237_1.time_ - var_240_26) / var_240_28
				local var_240_30 = Mathf.Lerp(arg_237_1.var_.alphaOldValueST12, 1, var_240_29)

				if arg_237_1.var_.alphaMatValueST12 then
					local var_240_31 = arg_237_1.var_.alphaMatValueST12.color

					var_240_31.a = var_240_30
					arg_237_1.var_.alphaMatValueST12.color = var_240_31
				end
			end

			if arg_237_1.time_ >= var_240_26 + var_240_28 and arg_237_1.time_ < var_240_26 + var_240_28 + arg_240_0 and arg_237_1.var_.alphaMatValueST12 then
				local var_240_32 = arg_237_1.var_.alphaMatValueST12
				local var_240_33 = var_240_32.color

				var_240_33.a = 1
				var_240_32.color = var_240_33
			end

			local var_240_34 = 0
			local var_240_35 = 1

			if var_240_34 < arg_237_1.time_ and arg_237_1.time_ <= var_240_34 + arg_240_0 then
				local var_240_36 = "play"
				local var_240_37 = "music"

				arg_237_1:AudioAction(var_240_36, var_240_37, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_240_38 = ""
				local var_240_39 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if var_240_39 ~= "" then
					if arg_237_1.bgmTxt_.text ~= var_240_39 and arg_237_1.bgmTxt_.text ~= "" then
						if arg_237_1.bgmTxt2_.text ~= "" then
							arg_237_1.bgmTxt_.text = arg_237_1.bgmTxt2_.text
						end

						arg_237_1.bgmTxt2_.text = var_240_39

						arg_237_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_237_1.bgmTxt_.text = var_240_39
						arg_237_1.bgmTxt2_.text = var_240_39
					end

					if arg_237_1.bgmTimer then
						arg_237_1.bgmTimer:Stop()

						arg_237_1.bgmTimer = nil
					end

					if arg_237_1.settingData.show_music_name == 1 then
						arg_237_1.musicController:SetSelectedState("show")
						arg_237_1.musicAnimator_:Play("open", 0, 0)

						if arg_237_1.settingData.music_time ~= 0 then
							arg_237_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_237_1.settingData.music_time), function()
								if arg_237_1 == nil or isNil(arg_237_1.bgmTxt_) then
									return
								end

								arg_237_1.musicController:SetSelectedState("hide")
								arg_237_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_237_1.frameCnt_ <= 1 then
				arg_237_1.dialog_:SetActive(false)
			end

			local var_240_40 = 0.866666666666667
			local var_240_41 = 0.3

			if var_240_40 < arg_237_1.time_ and arg_237_1.time_ <= var_240_40 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				arg_237_1.dialog_:SetActive(true)

				arg_237_1.dialogCg_.alpha = 0

				local var_240_42 = LeanTween.value(arg_237_1.dialog_, 0, 1, 0.3)

				var_240_42:setOnUpdate(LuaHelper.FloatAction(function(arg_242_0)
					arg_237_1.dialogCg_.alpha = arg_242_0
				end))
				var_240_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_237_1.dialog_)
					var_240_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_237_1.duration_ = arg_237_1.duration_ + 0.3

				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_43 = arg_237_1:GetWordFromCfg(103704060)
				local var_240_44 = arg_237_1:FormatText(var_240_43.content)

				arg_237_1.text_.text = var_240_44

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_45 = 12
				local var_240_46 = utf8.len(var_240_44)
				local var_240_47 = var_240_45 <= 0 and var_240_41 or var_240_41 * (var_240_46 / var_240_45)

				if var_240_47 > 0 and var_240_41 < var_240_47 then
					arg_237_1.talkMaxDuration = var_240_47
					var_240_40 = var_240_40 + 0.3

					if var_240_47 + var_240_40 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_47 + var_240_40
					end
				end

				arg_237_1.text_.text = var_240_44
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_48 = var_240_40 + 0.3
			local var_240_49 = math.max(var_240_41, arg_237_1.talkMaxDuration)

			if var_240_48 <= arg_237_1.time_ and arg_237_1.time_ < var_240_48 + var_240_49 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_48) / var_240_49

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_48 + var_240_49 and arg_237_1.time_ < var_240_48 + var_240_49 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play103704061 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 103704061
		arg_244_1.duration_ = 4.5

		local var_244_0 = {
			ja = 4.5,
			ko = 1.933,
			en = 3.566
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
				arg_244_0:Play103704062(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 0.325

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_2 = arg_244_1:FormatText(StoryNameCfg[190].name)

				arg_244_1.leftNameTxt_.text = var_247_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_3 = arg_244_1:GetWordFromCfg(103704061)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704061", "story_v_side_old_103704.awb") ~= 0 then
					local var_247_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704061", "story_v_side_old_103704.awb") / 1000

					if var_247_8 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_0
					end

					if var_247_3.prefab_name ~= "" and arg_244_1.actors_[var_247_3.prefab_name] ~= nil then
						local var_247_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_3.prefab_name].transform, "story_v_side_old_103704", "103704061", "story_v_side_old_103704.awb")

						arg_244_1:RecordAudio("103704061", var_247_9)
						arg_244_1:RecordAudio("103704061", var_247_9)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704061", "story_v_side_old_103704.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704061", "story_v_side_old_103704.awb")
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
	Play103704062 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 103704062
		arg_248_1.duration_ = 11.67

		local var_248_0 = {
			ja = 11.666,
			ko = 5.7,
			en = 7.366
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
				arg_248_0:Play103704063(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = "1037ui_story"

			if arg_248_1.actors_[var_251_0] == nil then
				local var_251_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_251_1) then
					local var_251_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_248_1.stage_.transform)

					var_251_2.name = var_251_0
					var_251_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_248_1.actors_[var_251_0] = var_251_2

					local var_251_3 = var_251_2:GetComponentInChildren(typeof(CharacterEffect))

					var_251_3.enabled = true

					local var_251_4 = GameObjectTools.GetOrAddComponent(var_251_2, typeof(DynamicBoneHelper))

					if var_251_4 then
						var_251_4:EnableDynamicBone(false)
					end

					arg_248_1:ShowWeapon(var_251_3.transform, false)

					arg_248_1.var_[var_251_0 .. "Animator"] = var_251_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_248_1.var_[var_251_0 .. "Animator"].applyRootMotion = true
					arg_248_1.var_[var_251_0 .. "LipSync"] = var_251_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_251_5 = arg_248_1.actors_["1037ui_story"].transform
			local var_251_6 = 0

			if var_251_6 < arg_248_1.time_ and arg_248_1.time_ <= var_251_6 + arg_251_0 then
				arg_248_1.var_.moveOldPos1037ui_story = var_251_5.localPosition
			end

			local var_251_7 = 0.001

			if var_251_6 <= arg_248_1.time_ and arg_248_1.time_ < var_251_6 + var_251_7 then
				local var_251_8 = (arg_248_1.time_ - var_251_6) / var_251_7
				local var_251_9 = Vector3.New(0, -1.09, -5.81)

				var_251_5.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1037ui_story, var_251_9, var_251_8)

				local var_251_10 = manager.ui.mainCamera.transform.position - var_251_5.position

				var_251_5.forward = Vector3.New(var_251_10.x, var_251_10.y, var_251_10.z)

				local var_251_11 = var_251_5.localEulerAngles

				var_251_11.z = 0
				var_251_11.x = 0
				var_251_5.localEulerAngles = var_251_11
			end

			if arg_248_1.time_ >= var_251_6 + var_251_7 and arg_248_1.time_ < var_251_6 + var_251_7 + arg_251_0 then
				var_251_5.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_251_12 = manager.ui.mainCamera.transform.position - var_251_5.position

				var_251_5.forward = Vector3.New(var_251_12.x, var_251_12.y, var_251_12.z)

				local var_251_13 = var_251_5.localEulerAngles

				var_251_13.z = 0
				var_251_13.x = 0
				var_251_5.localEulerAngles = var_251_13
			end

			local var_251_14 = arg_248_1.actors_["1037ui_story"]
			local var_251_15 = 0

			if var_251_15 < arg_248_1.time_ and arg_248_1.time_ <= var_251_15 + arg_251_0 and not isNil(var_251_14) and arg_248_1.var_.characterEffect1037ui_story == nil then
				arg_248_1.var_.characterEffect1037ui_story = var_251_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_16 = 0.2

			if var_251_15 <= arg_248_1.time_ and arg_248_1.time_ < var_251_15 + var_251_16 and not isNil(var_251_14) then
				local var_251_17 = (arg_248_1.time_ - var_251_15) / var_251_16

				if arg_248_1.var_.characterEffect1037ui_story and not isNil(var_251_14) then
					arg_248_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= var_251_15 + var_251_16 and arg_248_1.time_ < var_251_15 + var_251_16 + arg_251_0 and not isNil(var_251_14) and arg_248_1.var_.characterEffect1037ui_story then
				arg_248_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_251_18 = 0

			if var_251_18 < arg_248_1.time_ and arg_248_1.time_ <= var_251_18 + arg_251_0 then
				arg_248_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_251_19 = 0

			if var_251_19 < arg_248_1.time_ and arg_248_1.time_ <= var_251_19 + arg_251_0 then
				arg_248_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_251_20 = 0
			local var_251_21 = 0.875

			if var_251_20 < arg_248_1.time_ and arg_248_1.time_ <= var_251_20 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_22 = arg_248_1:FormatText(StoryNameCfg[15].name)

				arg_248_1.leftNameTxt_.text = var_251_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_23 = arg_248_1:GetWordFromCfg(103704062)
				local var_251_24 = arg_248_1:FormatText(var_251_23.content)

				arg_248_1.text_.text = var_251_24

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_25 = 35
				local var_251_26 = utf8.len(var_251_24)
				local var_251_27 = var_251_25 <= 0 and var_251_21 or var_251_21 * (var_251_26 / var_251_25)

				if var_251_27 > 0 and var_251_21 < var_251_27 then
					arg_248_1.talkMaxDuration = var_251_27

					if var_251_27 + var_251_20 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_27 + var_251_20
					end
				end

				arg_248_1.text_.text = var_251_24
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704062", "story_v_side_old_103704.awb") ~= 0 then
					local var_251_28 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704062", "story_v_side_old_103704.awb") / 1000

					if var_251_28 + var_251_20 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_28 + var_251_20
					end

					if var_251_23.prefab_name ~= "" and arg_248_1.actors_[var_251_23.prefab_name] ~= nil then
						local var_251_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_23.prefab_name].transform, "story_v_side_old_103704", "103704062", "story_v_side_old_103704.awb")

						arg_248_1:RecordAudio("103704062", var_251_29)
						arg_248_1:RecordAudio("103704062", var_251_29)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704062", "story_v_side_old_103704.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704062", "story_v_side_old_103704.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_30 = math.max(var_251_21, arg_248_1.talkMaxDuration)

			if var_251_20 <= arg_248_1.time_ and arg_248_1.time_ < var_251_20 + var_251_30 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_20) / var_251_30

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_20 + var_251_30 and arg_248_1.time_ < var_251_20 + var_251_30 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play103704063 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 103704063
		arg_252_1.duration_ = 2.2

		local var_252_0 = {
			ja = 2.2,
			ko = 1.4,
			en = 1.8
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
				arg_252_0:Play103704064(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["1037ui_story"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1037ui_story == nil then
				arg_252_1.var_.characterEffect1037ui_story = var_255_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.2

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.characterEffect1037ui_story and not isNil(var_255_0) then
					local var_255_4 = Mathf.Lerp(0, 0.5, var_255_3)

					arg_252_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1037ui_story.fillRatio = var_255_4
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1037ui_story then
				local var_255_5 = 0.5

				arg_252_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1037ui_story.fillRatio = var_255_5
			end

			local var_255_6 = 0
			local var_255_7 = 0.125

			if var_255_6 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_8 = arg_252_1:FormatText(StoryNameCfg[190].name)

				arg_252_1.leftNameTxt_.text = var_255_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_9 = arg_252_1:GetWordFromCfg(103704063)
				local var_255_10 = arg_252_1:FormatText(var_255_9.content)

				arg_252_1.text_.text = var_255_10

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_11 = 5
				local var_255_12 = utf8.len(var_255_10)
				local var_255_13 = var_255_11 <= 0 and var_255_7 or var_255_7 * (var_255_12 / var_255_11)

				if var_255_13 > 0 and var_255_7 < var_255_13 then
					arg_252_1.talkMaxDuration = var_255_13

					if var_255_13 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_6
					end
				end

				arg_252_1.text_.text = var_255_10
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704063", "story_v_side_old_103704.awb") ~= 0 then
					local var_255_14 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704063", "story_v_side_old_103704.awb") / 1000

					if var_255_14 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_14 + var_255_6
					end

					if var_255_9.prefab_name ~= "" and arg_252_1.actors_[var_255_9.prefab_name] ~= nil then
						local var_255_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_9.prefab_name].transform, "story_v_side_old_103704", "103704063", "story_v_side_old_103704.awb")

						arg_252_1:RecordAudio("103704063", var_255_15)
						arg_252_1:RecordAudio("103704063", var_255_15)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704063", "story_v_side_old_103704.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704063", "story_v_side_old_103704.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_16 = math.max(var_255_7, arg_252_1.talkMaxDuration)

			if var_255_6 <= arg_252_1.time_ and arg_252_1.time_ < var_255_6 + var_255_16 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_6) / var_255_16

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_6 + var_255_16 and arg_252_1.time_ < var_255_6 + var_255_16 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play103704064 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 103704064
		arg_256_1.duration_ = 4.6

		local var_256_0 = {
			ja = 3.133,
			ko = 4.6,
			en = 3.566
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
				arg_256_0:Play103704065(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["1037ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1037ui_story == nil then
				arg_256_1.var_.characterEffect1037ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.2

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect1037ui_story and not isNil(var_259_0) then
					arg_256_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1037ui_story then
				arg_256_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_259_4 = 0

			if var_259_4 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_259_5 = 0
			local var_259_6 = 0.55

			if var_259_5 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_7 = arg_256_1:FormatText(StoryNameCfg[15].name)

				arg_256_1.leftNameTxt_.text = var_259_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_8 = arg_256_1:GetWordFromCfg(103704064)
				local var_259_9 = arg_256_1:FormatText(var_259_8.content)

				arg_256_1.text_.text = var_259_9

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_10 = 22
				local var_259_11 = utf8.len(var_259_9)
				local var_259_12 = var_259_10 <= 0 and var_259_6 or var_259_6 * (var_259_11 / var_259_10)

				if var_259_12 > 0 and var_259_6 < var_259_12 then
					arg_256_1.talkMaxDuration = var_259_12

					if var_259_12 + var_259_5 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_12 + var_259_5
					end
				end

				arg_256_1.text_.text = var_259_9
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704064", "story_v_side_old_103704.awb") ~= 0 then
					local var_259_13 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704064", "story_v_side_old_103704.awb") / 1000

					if var_259_13 + var_259_5 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_13 + var_259_5
					end

					if var_259_8.prefab_name ~= "" and arg_256_1.actors_[var_259_8.prefab_name] ~= nil then
						local var_259_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_8.prefab_name].transform, "story_v_side_old_103704", "103704064", "story_v_side_old_103704.awb")

						arg_256_1:RecordAudio("103704064", var_259_14)
						arg_256_1:RecordAudio("103704064", var_259_14)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704064", "story_v_side_old_103704.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704064", "story_v_side_old_103704.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_15 = math.max(var_259_6, arg_256_1.talkMaxDuration)

			if var_259_5 <= arg_256_1.time_ and arg_256_1.time_ < var_259_5 + var_259_15 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_5) / var_259_15

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_5 + var_259_15 and arg_256_1.time_ < var_259_5 + var_259_15 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play103704065 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 103704065
		arg_260_1.duration_ = 7.93

		local var_260_0 = {
			ja = 7.933,
			ko = 3.233,
			en = 4.1
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
				arg_260_0:Play103704066(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["1037ui_story"]
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1037ui_story == nil then
				arg_260_1.var_.characterEffect1037ui_story = var_263_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.2

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 and not isNil(var_263_0) then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2

				if arg_260_1.var_.characterEffect1037ui_story and not isNil(var_263_0) then
					arg_260_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1037ui_story then
				arg_260_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_263_4 = 0

			if var_263_4 < arg_260_1.time_ and arg_260_1.time_ <= var_263_4 + arg_263_0 then
				arg_260_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_263_5 = 0

			if var_263_5 < arg_260_1.time_ and arg_260_1.time_ <= var_263_5 + arg_263_0 then
				arg_260_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_263_6 = 0
			local var_263_7 = 0.375

			if var_263_6 < arg_260_1.time_ and arg_260_1.time_ <= var_263_6 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_8 = arg_260_1:FormatText(StoryNameCfg[15].name)

				arg_260_1.leftNameTxt_.text = var_263_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_9 = arg_260_1:GetWordFromCfg(103704065)
				local var_263_10 = arg_260_1:FormatText(var_263_9.content)

				arg_260_1.text_.text = var_263_10

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_11 = 15
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704065", "story_v_side_old_103704.awb") ~= 0 then
					local var_263_14 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704065", "story_v_side_old_103704.awb") / 1000

					if var_263_14 + var_263_6 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_14 + var_263_6
					end

					if var_263_9.prefab_name ~= "" and arg_260_1.actors_[var_263_9.prefab_name] ~= nil then
						local var_263_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_9.prefab_name].transform, "story_v_side_old_103704", "103704065", "story_v_side_old_103704.awb")

						arg_260_1:RecordAudio("103704065", var_263_15)
						arg_260_1:RecordAudio("103704065", var_263_15)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704065", "story_v_side_old_103704.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704065", "story_v_side_old_103704.awb")
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
	Play103704066 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 103704066
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play103704067(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["1037ui_story"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1037ui_story == nil then
				arg_264_1.var_.characterEffect1037ui_story = var_267_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.2

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.characterEffect1037ui_story and not isNil(var_267_0) then
					local var_267_4 = Mathf.Lerp(0, 0.5, var_267_3)

					arg_264_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_264_1.var_.characterEffect1037ui_story.fillRatio = var_267_4
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect1037ui_story then
				local var_267_5 = 0.5

				arg_264_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_264_1.var_.characterEffect1037ui_story.fillRatio = var_267_5
			end

			local var_267_6 = 0
			local var_267_7 = 0.925

			if var_267_6 < arg_264_1.time_ and arg_264_1.time_ <= var_267_6 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_8 = arg_264_1:GetWordFromCfg(103704066)
				local var_267_9 = arg_264_1:FormatText(var_267_8.content)

				arg_264_1.text_.text = var_267_9

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_10 = 37
				local var_267_11 = utf8.len(var_267_9)
				local var_267_12 = var_267_10 <= 0 and var_267_7 or var_267_7 * (var_267_11 / var_267_10)

				if var_267_12 > 0 and var_267_7 < var_267_12 then
					arg_264_1.talkMaxDuration = var_267_12

					if var_267_12 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_12 + var_267_6
					end
				end

				arg_264_1.text_.text = var_267_9
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_13 = math.max(var_267_7, arg_264_1.talkMaxDuration)

			if var_267_6 <= arg_264_1.time_ and arg_264_1.time_ < var_267_6 + var_267_13 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_6) / var_267_13

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_6 + var_267_13 and arg_264_1.time_ < var_267_6 + var_267_13 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play103704067 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 103704067
		arg_268_1.duration_ = 13.27

		local var_268_0 = {
			ja = 13.266,
			ko = 9.033,
			en = 11.066
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
				arg_268_0:Play103704068(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["1037ui_story"]
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.characterEffect1037ui_story == nil then
				arg_268_1.var_.characterEffect1037ui_story = var_271_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_2 = 0.2

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 and not isNil(var_271_0) then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2

				if arg_268_1.var_.characterEffect1037ui_story and not isNil(var_271_0) then
					arg_268_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.characterEffect1037ui_story then
				arg_268_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_271_4 = 0

			if var_271_4 < arg_268_1.time_ and arg_268_1.time_ <= var_271_4 + arg_271_0 then
				arg_268_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_271_5 = 0
			local var_271_6 = 1.15

			if var_271_5 < arg_268_1.time_ and arg_268_1.time_ <= var_271_5 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_7 = arg_268_1:FormatText(StoryNameCfg[15].name)

				arg_268_1.leftNameTxt_.text = var_271_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_8 = arg_268_1:GetWordFromCfg(103704067)
				local var_271_9 = arg_268_1:FormatText(var_271_8.content)

				arg_268_1.text_.text = var_271_9

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_10 = 46
				local var_271_11 = utf8.len(var_271_9)
				local var_271_12 = var_271_10 <= 0 and var_271_6 or var_271_6 * (var_271_11 / var_271_10)

				if var_271_12 > 0 and var_271_6 < var_271_12 then
					arg_268_1.talkMaxDuration = var_271_12

					if var_271_12 + var_271_5 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_12 + var_271_5
					end
				end

				arg_268_1.text_.text = var_271_9
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704067", "story_v_side_old_103704.awb") ~= 0 then
					local var_271_13 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704067", "story_v_side_old_103704.awb") / 1000

					if var_271_13 + var_271_5 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_13 + var_271_5
					end

					if var_271_8.prefab_name ~= "" and arg_268_1.actors_[var_271_8.prefab_name] ~= nil then
						local var_271_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_8.prefab_name].transform, "story_v_side_old_103704", "103704067", "story_v_side_old_103704.awb")

						arg_268_1:RecordAudio("103704067", var_271_14)
						arg_268_1:RecordAudio("103704067", var_271_14)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704067", "story_v_side_old_103704.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704067", "story_v_side_old_103704.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_15 = math.max(var_271_6, arg_268_1.talkMaxDuration)

			if var_271_5 <= arg_268_1.time_ and arg_268_1.time_ < var_271_5 + var_271_15 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_5) / var_271_15

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_5 + var_271_15 and arg_268_1.time_ < var_271_5 + var_271_15 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play103704068 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 103704068
		arg_272_1.duration_ = 15.3

		local var_272_0 = {
			ja = 15.3,
			ko = 6.5,
			en = 9.733
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
				arg_272_0:Play103704069(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_275_1 = 0
			local var_275_2 = 0.925

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_3 = arg_272_1:FormatText(StoryNameCfg[15].name)

				arg_272_1.leftNameTxt_.text = var_275_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_4 = arg_272_1:GetWordFromCfg(103704068)
				local var_275_5 = arg_272_1:FormatText(var_275_4.content)

				arg_272_1.text_.text = var_275_5

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_6 = 37
				local var_275_7 = utf8.len(var_275_5)
				local var_275_8 = var_275_6 <= 0 and var_275_2 or var_275_2 * (var_275_7 / var_275_6)

				if var_275_8 > 0 and var_275_2 < var_275_8 then
					arg_272_1.talkMaxDuration = var_275_8

					if var_275_8 + var_275_1 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_1
					end
				end

				arg_272_1.text_.text = var_275_5
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704068", "story_v_side_old_103704.awb") ~= 0 then
					local var_275_9 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704068", "story_v_side_old_103704.awb") / 1000

					if var_275_9 + var_275_1 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_9 + var_275_1
					end

					if var_275_4.prefab_name ~= "" and arg_272_1.actors_[var_275_4.prefab_name] ~= nil then
						local var_275_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_4.prefab_name].transform, "story_v_side_old_103704", "103704068", "story_v_side_old_103704.awb")

						arg_272_1:RecordAudio("103704068", var_275_10)
						arg_272_1:RecordAudio("103704068", var_275_10)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704068", "story_v_side_old_103704.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704068", "story_v_side_old_103704.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_11 = math.max(var_275_2, arg_272_1.talkMaxDuration)

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_11 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_1) / var_275_11

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_1 + var_275_11 and arg_272_1.time_ < var_275_1 + var_275_11 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play103704069 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 103704069
		arg_276_1.duration_ = 15.27

		local var_276_0 = {
			ja = 15.266,
			ko = 7.6,
			en = 12.4
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
				arg_276_0:Play103704070(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_279_1 = 0
			local var_279_2 = 1.15

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_3 = arg_276_1:FormatText(StoryNameCfg[15].name)

				arg_276_1.leftNameTxt_.text = var_279_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_4 = arg_276_1:GetWordFromCfg(103704069)
				local var_279_5 = arg_276_1:FormatText(var_279_4.content)

				arg_276_1.text_.text = var_279_5

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_6 = 46
				local var_279_7 = utf8.len(var_279_5)
				local var_279_8 = var_279_6 <= 0 and var_279_2 or var_279_2 * (var_279_7 / var_279_6)

				if var_279_8 > 0 and var_279_2 < var_279_8 then
					arg_276_1.talkMaxDuration = var_279_8

					if var_279_8 + var_279_1 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_8 + var_279_1
					end
				end

				arg_276_1.text_.text = var_279_5
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704069", "story_v_side_old_103704.awb") ~= 0 then
					local var_279_9 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704069", "story_v_side_old_103704.awb") / 1000

					if var_279_9 + var_279_1 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_9 + var_279_1
					end

					if var_279_4.prefab_name ~= "" and arg_276_1.actors_[var_279_4.prefab_name] ~= nil then
						local var_279_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_4.prefab_name].transform, "story_v_side_old_103704", "103704069", "story_v_side_old_103704.awb")

						arg_276_1:RecordAudio("103704069", var_279_10)
						arg_276_1:RecordAudio("103704069", var_279_10)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704069", "story_v_side_old_103704.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704069", "story_v_side_old_103704.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_11 = math.max(var_279_2, arg_276_1.talkMaxDuration)

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_11 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_1) / var_279_11

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_1 + var_279_11 and arg_276_1.time_ < var_279_1 + var_279_11 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play103704070 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 103704070
		arg_280_1.duration_ = 7.8

		local var_280_0 = {
			ja = 4.4,
			ko = 6.766,
			en = 7.8
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
				arg_280_0:Play103704071(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_2")
			end

			local var_283_2 = 0
			local var_283_3 = 0.825

			if var_283_2 < arg_280_1.time_ and arg_280_1.time_ <= var_283_2 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_4 = arg_280_1:FormatText(StoryNameCfg[15].name)

				arg_280_1.leftNameTxt_.text = var_283_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_5 = arg_280_1:GetWordFromCfg(103704070)
				local var_283_6 = arg_280_1:FormatText(var_283_5.content)

				arg_280_1.text_.text = var_283_6

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_7 = 33
				local var_283_8 = utf8.len(var_283_6)
				local var_283_9 = var_283_7 <= 0 and var_283_3 or var_283_3 * (var_283_8 / var_283_7)

				if var_283_9 > 0 and var_283_3 < var_283_9 then
					arg_280_1.talkMaxDuration = var_283_9

					if var_283_9 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_9 + var_283_2
					end
				end

				arg_280_1.text_.text = var_283_6
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704070", "story_v_side_old_103704.awb") ~= 0 then
					local var_283_10 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704070", "story_v_side_old_103704.awb") / 1000

					if var_283_10 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_10 + var_283_2
					end

					if var_283_5.prefab_name ~= "" and arg_280_1.actors_[var_283_5.prefab_name] ~= nil then
						local var_283_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_5.prefab_name].transform, "story_v_side_old_103704", "103704070", "story_v_side_old_103704.awb")

						arg_280_1:RecordAudio("103704070", var_283_11)
						arg_280_1:RecordAudio("103704070", var_283_11)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704070", "story_v_side_old_103704.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704070", "story_v_side_old_103704.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_12 = math.max(var_283_3, arg_280_1.talkMaxDuration)

			if var_283_2 <= arg_280_1.time_ and arg_280_1.time_ < var_283_2 + var_283_12 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_2) / var_283_12

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_2 + var_283_12 and arg_280_1.time_ < var_283_2 + var_283_12 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play103704071 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 103704071
		arg_284_1.duration_ = 2.97

		local var_284_0 = {
			ja = 2.7,
			ko = 2.966,
			en = 2.266
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play103704072(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1037ui_story"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1037ui_story == nil then
				arg_284_1.var_.characterEffect1037ui_story = var_287_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.2

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.characterEffect1037ui_story and not isNil(var_287_0) then
					local var_287_4 = Mathf.Lerp(0, 0.5, var_287_3)

					arg_284_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1037ui_story.fillRatio = var_287_4
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1037ui_story then
				local var_287_5 = 0.5

				arg_284_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1037ui_story.fillRatio = var_287_5
			end

			local var_287_6 = 0
			local var_287_7 = 0.3

			if var_287_6 < arg_284_1.time_ and arg_284_1.time_ <= var_287_6 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_8 = arg_284_1:FormatText(StoryNameCfg[190].name)

				arg_284_1.leftNameTxt_.text = var_287_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_9 = arg_284_1:GetWordFromCfg(103704071)
				local var_287_10 = arg_284_1:FormatText(var_287_9.content)

				arg_284_1.text_.text = var_287_10

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_11 = 12
				local var_287_12 = utf8.len(var_287_10)
				local var_287_13 = var_287_11 <= 0 and var_287_7 or var_287_7 * (var_287_12 / var_287_11)

				if var_287_13 > 0 and var_287_7 < var_287_13 then
					arg_284_1.talkMaxDuration = var_287_13

					if var_287_13 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_13 + var_287_6
					end
				end

				arg_284_1.text_.text = var_287_10
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704071", "story_v_side_old_103704.awb") ~= 0 then
					local var_287_14 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704071", "story_v_side_old_103704.awb") / 1000

					if var_287_14 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_14 + var_287_6
					end

					if var_287_9.prefab_name ~= "" and arg_284_1.actors_[var_287_9.prefab_name] ~= nil then
						local var_287_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_9.prefab_name].transform, "story_v_side_old_103704", "103704071", "story_v_side_old_103704.awb")

						arg_284_1:RecordAudio("103704071", var_287_15)
						arg_284_1:RecordAudio("103704071", var_287_15)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704071", "story_v_side_old_103704.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704071", "story_v_side_old_103704.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_16 = math.max(var_287_7, arg_284_1.talkMaxDuration)

			if var_287_6 <= arg_284_1.time_ and arg_284_1.time_ < var_287_6 + var_287_16 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_6) / var_287_16

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_6 + var_287_16 and arg_284_1.time_ < var_287_6 + var_287_16 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play103704072 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 103704072
		arg_288_1.duration_ = 6

		local var_288_0 = {
			ja = 4.4,
			ko = 5.3,
			en = 6
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play103704073(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0
			local var_291_1 = 0.75

			if var_291_0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_2 = arg_288_1:FormatText(StoryNameCfg[190].name)

				arg_288_1.leftNameTxt_.text = var_291_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_3 = arg_288_1:GetWordFromCfg(103704072)
				local var_291_4 = arg_288_1:FormatText(var_291_3.content)

				arg_288_1.text_.text = var_291_4

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_5 = 30
				local var_291_6 = utf8.len(var_291_4)
				local var_291_7 = var_291_5 <= 0 and var_291_1 or var_291_1 * (var_291_6 / var_291_5)

				if var_291_7 > 0 and var_291_1 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_0
					end
				end

				arg_288_1.text_.text = var_291_4
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704072", "story_v_side_old_103704.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704072", "story_v_side_old_103704.awb") / 1000

					if var_291_8 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_0
					end

					if var_291_3.prefab_name ~= "" and arg_288_1.actors_[var_291_3.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_3.prefab_name].transform, "story_v_side_old_103704", "103704072", "story_v_side_old_103704.awb")

						arg_288_1:RecordAudio("103704072", var_291_9)
						arg_288_1:RecordAudio("103704072", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704072", "story_v_side_old_103704.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704072", "story_v_side_old_103704.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_1, arg_288_1.talkMaxDuration)

			if var_291_0 <= arg_288_1.time_ and arg_288_1.time_ < var_291_0 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_0) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_0 + var_291_10 and arg_288_1.time_ < var_291_0 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play103704073 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 103704073
		arg_292_1.duration_ = 7.87

		local var_292_0 = {
			ja = 6.9,
			ko = 7.866,
			en = 6.533
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play103704074(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0
			local var_295_1 = 0.925

			if var_295_0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_2 = arg_292_1:FormatText(StoryNameCfg[190].name)

				arg_292_1.leftNameTxt_.text = var_295_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_3 = arg_292_1:GetWordFromCfg(103704073)
				local var_295_4 = arg_292_1:FormatText(var_295_3.content)

				arg_292_1.text_.text = var_295_4

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 37
				local var_295_6 = utf8.len(var_295_4)
				local var_295_7 = var_295_5 <= 0 and var_295_1 or var_295_1 * (var_295_6 / var_295_5)

				if var_295_7 > 0 and var_295_1 < var_295_7 then
					arg_292_1.talkMaxDuration = var_295_7

					if var_295_7 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_7 + var_295_0
					end
				end

				arg_292_1.text_.text = var_295_4
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704073", "story_v_side_old_103704.awb") ~= 0 then
					local var_295_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704073", "story_v_side_old_103704.awb") / 1000

					if var_295_8 + var_295_0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_8 + var_295_0
					end

					if var_295_3.prefab_name ~= "" and arg_292_1.actors_[var_295_3.prefab_name] ~= nil then
						local var_295_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_3.prefab_name].transform, "story_v_side_old_103704", "103704073", "story_v_side_old_103704.awb")

						arg_292_1:RecordAudio("103704073", var_295_9)
						arg_292_1:RecordAudio("103704073", var_295_9)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704073", "story_v_side_old_103704.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704073", "story_v_side_old_103704.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_10 = math.max(var_295_1, arg_292_1.talkMaxDuration)

			if var_295_0 <= arg_292_1.time_ and arg_292_1.time_ < var_295_0 + var_295_10 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_0) / var_295_10

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_0 + var_295_10 and arg_292_1.time_ < var_295_0 + var_295_10 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play103704074 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 103704074
		arg_296_1.duration_ = 4.33

		local var_296_0 = {
			ja = 4.333,
			ko = 2.266,
			en = 1.999999999999
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play103704075(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["1037ui_story"]
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect1037ui_story == nil then
				arg_296_1.var_.characterEffect1037ui_story = var_299_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.2

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 and not isNil(var_299_0) then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2

				if arg_296_1.var_.characterEffect1037ui_story and not isNil(var_299_0) then
					arg_296_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect1037ui_story then
				arg_296_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_299_4 = 0

			if var_299_4 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_299_5 = 0

			if var_299_5 < arg_296_1.time_ and arg_296_1.time_ <= var_299_5 + arg_299_0 then
				arg_296_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_299_6 = 0
			local var_299_7 = 0.2

			if var_299_6 < arg_296_1.time_ and arg_296_1.time_ <= var_299_6 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_8 = arg_296_1:FormatText(StoryNameCfg[15].name)

				arg_296_1.leftNameTxt_.text = var_299_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_9 = arg_296_1:GetWordFromCfg(103704074)
				local var_299_10 = arg_296_1:FormatText(var_299_9.content)

				arg_296_1.text_.text = var_299_10

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_11 = 8
				local var_299_12 = utf8.len(var_299_10)
				local var_299_13 = var_299_11 <= 0 and var_299_7 or var_299_7 * (var_299_12 / var_299_11)

				if var_299_13 > 0 and var_299_7 < var_299_13 then
					arg_296_1.talkMaxDuration = var_299_13

					if var_299_13 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_13 + var_299_6
					end
				end

				arg_296_1.text_.text = var_299_10
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704074", "story_v_side_old_103704.awb") ~= 0 then
					local var_299_14 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704074", "story_v_side_old_103704.awb") / 1000

					if var_299_14 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_14 + var_299_6
					end

					if var_299_9.prefab_name ~= "" and arg_296_1.actors_[var_299_9.prefab_name] ~= nil then
						local var_299_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_9.prefab_name].transform, "story_v_side_old_103704", "103704074", "story_v_side_old_103704.awb")

						arg_296_1:RecordAudio("103704074", var_299_15)
						arg_296_1:RecordAudio("103704074", var_299_15)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704074", "story_v_side_old_103704.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704074", "story_v_side_old_103704.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_16 = math.max(var_299_7, arg_296_1.talkMaxDuration)

			if var_299_6 <= arg_296_1.time_ and arg_296_1.time_ < var_299_6 + var_299_16 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_6) / var_299_16

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_6 + var_299_16 and arg_296_1.time_ < var_299_6 + var_299_16 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play103704075 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 103704075
		arg_300_1.duration_ = 3.97

		local var_300_0 = {
			ja = 3.966,
			ko = 2.1,
			en = 2.1
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play103704076(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["1037ui_story"]
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect1037ui_story == nil then
				arg_300_1.var_.characterEffect1037ui_story = var_303_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_2 = 0.2

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 and not isNil(var_303_0) then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2

				if arg_300_1.var_.characterEffect1037ui_story and not isNil(var_303_0) then
					local var_303_4 = Mathf.Lerp(0, 0.5, var_303_3)

					arg_300_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_300_1.var_.characterEffect1037ui_story.fillRatio = var_303_4
				end
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect1037ui_story then
				local var_303_5 = 0.5

				arg_300_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_300_1.var_.characterEffect1037ui_story.fillRatio = var_303_5
			end

			local var_303_6 = 0
			local var_303_7 = 0.225

			if var_303_6 < arg_300_1.time_ and arg_300_1.time_ <= var_303_6 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_8 = arg_300_1:FormatText(StoryNameCfg[190].name)

				arg_300_1.leftNameTxt_.text = var_303_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_9 = arg_300_1:GetWordFromCfg(103704075)
				local var_303_10 = arg_300_1:FormatText(var_303_9.content)

				arg_300_1.text_.text = var_303_10

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_11 = 9
				local var_303_12 = utf8.len(var_303_10)
				local var_303_13 = var_303_11 <= 0 and var_303_7 or var_303_7 * (var_303_12 / var_303_11)

				if var_303_13 > 0 and var_303_7 < var_303_13 then
					arg_300_1.talkMaxDuration = var_303_13

					if var_303_13 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_13 + var_303_6
					end
				end

				arg_300_1.text_.text = var_303_10
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704075", "story_v_side_old_103704.awb") ~= 0 then
					local var_303_14 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704075", "story_v_side_old_103704.awb") / 1000

					if var_303_14 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_14 + var_303_6
					end

					if var_303_9.prefab_name ~= "" and arg_300_1.actors_[var_303_9.prefab_name] ~= nil then
						local var_303_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_9.prefab_name].transform, "story_v_side_old_103704", "103704075", "story_v_side_old_103704.awb")

						arg_300_1:RecordAudio("103704075", var_303_15)
						arg_300_1:RecordAudio("103704075", var_303_15)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704075", "story_v_side_old_103704.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704075", "story_v_side_old_103704.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_16 = math.max(var_303_7, arg_300_1.talkMaxDuration)

			if var_303_6 <= arg_300_1.time_ and arg_300_1.time_ < var_303_6 + var_303_16 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_6) / var_303_16

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_6 + var_303_16 and arg_300_1.time_ < var_303_6 + var_303_16 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play103704076 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 103704076
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play103704077(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1037ui_story"].transform
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.var_.moveOldPos1037ui_story = var_307_0.localPosition
			end

			local var_307_2 = 0.001

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2
				local var_307_4 = Vector3.New(0, 100, 0)

				var_307_0.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1037ui_story, var_307_4, var_307_3)

				local var_307_5 = manager.ui.mainCamera.transform.position - var_307_0.position

				var_307_0.forward = Vector3.New(var_307_5.x, var_307_5.y, var_307_5.z)

				local var_307_6 = var_307_0.localEulerAngles

				var_307_6.z = 0
				var_307_6.x = 0
				var_307_0.localEulerAngles = var_307_6
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 then
				var_307_0.localPosition = Vector3.New(0, 100, 0)

				local var_307_7 = manager.ui.mainCamera.transform.position - var_307_0.position

				var_307_0.forward = Vector3.New(var_307_7.x, var_307_7.y, var_307_7.z)

				local var_307_8 = var_307_0.localEulerAngles

				var_307_8.z = 0
				var_307_8.x = 0
				var_307_0.localEulerAngles = var_307_8
			end

			local var_307_9 = 0
			local var_307_10 = 0.55

			if var_307_9 < arg_304_1.time_ and arg_304_1.time_ <= var_307_9 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_11 = arg_304_1:GetWordFromCfg(103704076)
				local var_307_12 = arg_304_1:FormatText(var_307_11.content)

				arg_304_1.text_.text = var_307_12

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_13 = 22
				local var_307_14 = utf8.len(var_307_12)
				local var_307_15 = var_307_13 <= 0 and var_307_10 or var_307_10 * (var_307_14 / var_307_13)

				if var_307_15 > 0 and var_307_10 < var_307_15 then
					arg_304_1.talkMaxDuration = var_307_15

					if var_307_15 + var_307_9 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_15 + var_307_9
					end
				end

				arg_304_1.text_.text = var_307_12
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_16 = math.max(var_307_10, arg_304_1.talkMaxDuration)

			if var_307_9 <= arg_304_1.time_ and arg_304_1.time_ < var_307_9 + var_307_16 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_9) / var_307_16

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_9 + var_307_16 and arg_304_1.time_ < var_307_9 + var_307_16 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play103704077 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 103704077
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play103704078(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0
			local var_311_1 = 0.7

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_2 = arg_308_1:GetWordFromCfg(103704077)
				local var_311_3 = arg_308_1:FormatText(var_311_2.content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_4 = 28
				local var_311_5 = utf8.len(var_311_3)
				local var_311_6 = var_311_4 <= 0 and var_311_1 or var_311_1 * (var_311_5 / var_311_4)

				if var_311_6 > 0 and var_311_1 < var_311_6 then
					arg_308_1.talkMaxDuration = var_311_6

					if var_311_6 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_6 + var_311_0
					end
				end

				arg_308_1.text_.text = var_311_3
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_7 = math.max(var_311_1, arg_308_1.talkMaxDuration)

			if var_311_0 <= arg_308_1.time_ and arg_308_1.time_ < var_311_0 + var_311_7 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_0) / var_311_7

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_0 + var_311_7 and arg_308_1.time_ < var_311_0 + var_311_7 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play103704078 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 103704078
		arg_312_1.duration_ = 5.17

		local var_312_0 = {
			ja = 4.1,
			ko = 3.766,
			en = 5.166
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play103704079(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0
			local var_315_1 = 0.325

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_2 = arg_312_1:FormatText(StoryNameCfg[190].name)

				arg_312_1.leftNameTxt_.text = var_315_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_3 = arg_312_1:GetWordFromCfg(103704078)
				local var_315_4 = arg_312_1:FormatText(var_315_3.content)

				arg_312_1.text_.text = var_315_4

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_5 = 13
				local var_315_6 = utf8.len(var_315_4)
				local var_315_7 = var_315_5 <= 0 and var_315_1 or var_315_1 * (var_315_6 / var_315_5)

				if var_315_7 > 0 and var_315_1 < var_315_7 then
					arg_312_1.talkMaxDuration = var_315_7

					if var_315_7 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_7 + var_315_0
					end
				end

				arg_312_1.text_.text = var_315_4
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704078", "story_v_side_old_103704.awb") ~= 0 then
					local var_315_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704078", "story_v_side_old_103704.awb") / 1000

					if var_315_8 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_8 + var_315_0
					end

					if var_315_3.prefab_name ~= "" and arg_312_1.actors_[var_315_3.prefab_name] ~= nil then
						local var_315_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_3.prefab_name].transform, "story_v_side_old_103704", "103704078", "story_v_side_old_103704.awb")

						arg_312_1:RecordAudio("103704078", var_315_9)
						arg_312_1:RecordAudio("103704078", var_315_9)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704078", "story_v_side_old_103704.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704078", "story_v_side_old_103704.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_10 = math.max(var_315_1, arg_312_1.talkMaxDuration)

			if var_315_0 <= arg_312_1.time_ and arg_312_1.time_ < var_315_0 + var_315_10 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_0) / var_315_10

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_0 + var_315_10 and arg_312_1.time_ < var_315_0 + var_315_10 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play103704079 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 103704079
		arg_316_1.duration_ = 8.93

		local var_316_0 = {
			ja = 8.633,
			ko = 8.933,
			en = 8.4
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play103704080(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["1037ui_story"].transform
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.var_.moveOldPos1037ui_story = var_319_0.localPosition
			end

			local var_319_2 = 0.001

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2
				local var_319_4 = Vector3.New(0, -1.09, -5.81)

				var_319_0.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1037ui_story, var_319_4, var_319_3)

				local var_319_5 = manager.ui.mainCamera.transform.position - var_319_0.position

				var_319_0.forward = Vector3.New(var_319_5.x, var_319_5.y, var_319_5.z)

				local var_319_6 = var_319_0.localEulerAngles

				var_319_6.z = 0
				var_319_6.x = 0
				var_319_0.localEulerAngles = var_319_6
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 then
				var_319_0.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_319_7 = manager.ui.mainCamera.transform.position - var_319_0.position

				var_319_0.forward = Vector3.New(var_319_7.x, var_319_7.y, var_319_7.z)

				local var_319_8 = var_319_0.localEulerAngles

				var_319_8.z = 0
				var_319_8.x = 0
				var_319_0.localEulerAngles = var_319_8
			end

			local var_319_9 = arg_316_1.actors_["1037ui_story"]
			local var_319_10 = 0

			if var_319_10 < arg_316_1.time_ and arg_316_1.time_ <= var_319_10 + arg_319_0 and not isNil(var_319_9) and arg_316_1.var_.characterEffect1037ui_story == nil then
				arg_316_1.var_.characterEffect1037ui_story = var_319_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_11 = 0.2

			if var_319_10 <= arg_316_1.time_ and arg_316_1.time_ < var_319_10 + var_319_11 and not isNil(var_319_9) then
				local var_319_12 = (arg_316_1.time_ - var_319_10) / var_319_11

				if arg_316_1.var_.characterEffect1037ui_story and not isNil(var_319_9) then
					arg_316_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= var_319_10 + var_319_11 and arg_316_1.time_ < var_319_10 + var_319_11 + arg_319_0 and not isNil(var_319_9) and arg_316_1.var_.characterEffect1037ui_story then
				arg_316_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_319_13 = 0

			if var_319_13 < arg_316_1.time_ and arg_316_1.time_ <= var_319_13 + arg_319_0 then
				arg_316_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_319_14 = 0

			if var_319_14 < arg_316_1.time_ and arg_316_1.time_ <= var_319_14 + arg_319_0 then
				arg_316_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action6_1")
			end

			local var_319_15 = 0
			local var_319_16 = 0.825

			if var_319_15 < arg_316_1.time_ and arg_316_1.time_ <= var_319_15 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_17 = arg_316_1:FormatText(StoryNameCfg[15].name)

				arg_316_1.leftNameTxt_.text = var_319_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_18 = arg_316_1:GetWordFromCfg(103704079)
				local var_319_19 = arg_316_1:FormatText(var_319_18.content)

				arg_316_1.text_.text = var_319_19

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_20 = 33
				local var_319_21 = utf8.len(var_319_19)
				local var_319_22 = var_319_20 <= 0 and var_319_16 or var_319_16 * (var_319_21 / var_319_20)

				if var_319_22 > 0 and var_319_16 < var_319_22 then
					arg_316_1.talkMaxDuration = var_319_22

					if var_319_22 + var_319_15 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_22 + var_319_15
					end
				end

				arg_316_1.text_.text = var_319_19
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704079", "story_v_side_old_103704.awb") ~= 0 then
					local var_319_23 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704079", "story_v_side_old_103704.awb") / 1000

					if var_319_23 + var_319_15 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_23 + var_319_15
					end

					if var_319_18.prefab_name ~= "" and arg_316_1.actors_[var_319_18.prefab_name] ~= nil then
						local var_319_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_18.prefab_name].transform, "story_v_side_old_103704", "103704079", "story_v_side_old_103704.awb")

						arg_316_1:RecordAudio("103704079", var_319_24)
						arg_316_1:RecordAudio("103704079", var_319_24)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704079", "story_v_side_old_103704.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704079", "story_v_side_old_103704.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_25 = math.max(var_319_16, arg_316_1.talkMaxDuration)

			if var_319_15 <= arg_316_1.time_ and arg_316_1.time_ < var_319_15 + var_319_25 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_15) / var_319_25

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_15 + var_319_25 and arg_316_1.time_ < var_319_15 + var_319_25 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play103704080 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 103704080
		arg_320_1.duration_ = 6.3

		local var_320_0 = {
			ja = 2.566,
			ko = 5.566,
			en = 6.3
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play103704081(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["1037ui_story"]
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect1037ui_story == nil then
				arg_320_1.var_.characterEffect1037ui_story = var_323_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_2 = 0.2

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 and not isNil(var_323_0) then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2

				if arg_320_1.var_.characterEffect1037ui_story and not isNil(var_323_0) then
					local var_323_4 = Mathf.Lerp(0, 0.5, var_323_3)

					arg_320_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_320_1.var_.characterEffect1037ui_story.fillRatio = var_323_4
				end
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect1037ui_story then
				local var_323_5 = 0.5

				arg_320_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_320_1.var_.characterEffect1037ui_story.fillRatio = var_323_5
			end

			local var_323_6 = 0
			local var_323_7 = 0.5

			if var_323_6 < arg_320_1.time_ and arg_320_1.time_ <= var_323_6 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_8 = arg_320_1:FormatText(StoryNameCfg[190].name)

				arg_320_1.leftNameTxt_.text = var_323_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_9 = arg_320_1:GetWordFromCfg(103704080)
				local var_323_10 = arg_320_1:FormatText(var_323_9.content)

				arg_320_1.text_.text = var_323_10

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_11 = 20
				local var_323_12 = utf8.len(var_323_10)
				local var_323_13 = var_323_11 <= 0 and var_323_7 or var_323_7 * (var_323_12 / var_323_11)

				if var_323_13 > 0 and var_323_7 < var_323_13 then
					arg_320_1.talkMaxDuration = var_323_13

					if var_323_13 + var_323_6 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_13 + var_323_6
					end
				end

				arg_320_1.text_.text = var_323_10
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704080", "story_v_side_old_103704.awb") ~= 0 then
					local var_323_14 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704080", "story_v_side_old_103704.awb") / 1000

					if var_323_14 + var_323_6 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_14 + var_323_6
					end

					if var_323_9.prefab_name ~= "" and arg_320_1.actors_[var_323_9.prefab_name] ~= nil then
						local var_323_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_9.prefab_name].transform, "story_v_side_old_103704", "103704080", "story_v_side_old_103704.awb")

						arg_320_1:RecordAudio("103704080", var_323_15)
						arg_320_1:RecordAudio("103704080", var_323_15)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704080", "story_v_side_old_103704.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704080", "story_v_side_old_103704.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_16 = math.max(var_323_7, arg_320_1.talkMaxDuration)

			if var_323_6 <= arg_320_1.time_ and arg_320_1.time_ < var_323_6 + var_323_16 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_6) / var_323_16

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_6 + var_323_16 and arg_320_1.time_ < var_323_6 + var_323_16 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play103704081 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 103704081
		arg_324_1.duration_ = 6.4

		local var_324_0 = {
			ja = 6.4,
			ko = 4.533,
			en = 3.7
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play103704082(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["1037ui_story"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1037ui_story == nil then
				arg_324_1.var_.characterEffect1037ui_story = var_327_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.2

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.characterEffect1037ui_story and not isNil(var_327_0) then
					arg_324_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1037ui_story then
				arg_324_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_327_4 = 0

			if var_327_4 < arg_324_1.time_ and arg_324_1.time_ <= var_327_4 + arg_327_0 then
				arg_324_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_327_5 = 0

			if var_327_5 < arg_324_1.time_ and arg_324_1.time_ <= var_327_5 + arg_327_0 then
				arg_324_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action464")
			end

			local var_327_6 = 0
			local var_327_7 = 0.275

			if var_327_6 < arg_324_1.time_ and arg_324_1.time_ <= var_327_6 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_8 = arg_324_1:FormatText(StoryNameCfg[15].name)

				arg_324_1.leftNameTxt_.text = var_327_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_9 = arg_324_1:GetWordFromCfg(103704081)
				local var_327_10 = arg_324_1:FormatText(var_327_9.content)

				arg_324_1.text_.text = var_327_10

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_11 = 11
				local var_327_12 = utf8.len(var_327_10)
				local var_327_13 = var_327_11 <= 0 and var_327_7 or var_327_7 * (var_327_12 / var_327_11)

				if var_327_13 > 0 and var_327_7 < var_327_13 then
					arg_324_1.talkMaxDuration = var_327_13

					if var_327_13 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_13 + var_327_6
					end
				end

				arg_324_1.text_.text = var_327_10
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704081", "story_v_side_old_103704.awb") ~= 0 then
					local var_327_14 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704081", "story_v_side_old_103704.awb") / 1000

					if var_327_14 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_14 + var_327_6
					end

					if var_327_9.prefab_name ~= "" and arg_324_1.actors_[var_327_9.prefab_name] ~= nil then
						local var_327_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_9.prefab_name].transform, "story_v_side_old_103704", "103704081", "story_v_side_old_103704.awb")

						arg_324_1:RecordAudio("103704081", var_327_15)
						arg_324_1:RecordAudio("103704081", var_327_15)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704081", "story_v_side_old_103704.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704081", "story_v_side_old_103704.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_16 = math.max(var_327_7, arg_324_1.talkMaxDuration)

			if var_327_6 <= arg_324_1.time_ and arg_324_1.time_ < var_327_6 + var_327_16 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_6) / var_327_16

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_6 + var_327_16 and arg_324_1.time_ < var_327_6 + var_327_16 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play103704082 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 103704082
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play103704083(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["1037ui_story"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1037ui_story == nil then
				arg_328_1.var_.characterEffect1037ui_story = var_331_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.2

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.characterEffect1037ui_story and not isNil(var_331_0) then
					local var_331_4 = Mathf.Lerp(0, 0.5, var_331_3)

					arg_328_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_328_1.var_.characterEffect1037ui_story.fillRatio = var_331_4
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1037ui_story then
				local var_331_5 = 0.5

				arg_328_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_328_1.var_.characterEffect1037ui_story.fillRatio = var_331_5
			end

			local var_331_6 = 0
			local var_331_7 = 1.25

			if var_331_6 < arg_328_1.time_ and arg_328_1.time_ <= var_331_6 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_8 = arg_328_1:GetWordFromCfg(103704082)
				local var_331_9 = arg_328_1:FormatText(var_331_8.content)

				arg_328_1.text_.text = var_331_9

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_10 = 50
				local var_331_11 = utf8.len(var_331_9)
				local var_331_12 = var_331_10 <= 0 and var_331_7 or var_331_7 * (var_331_11 / var_331_10)

				if var_331_12 > 0 and var_331_7 < var_331_12 then
					arg_328_1.talkMaxDuration = var_331_12

					if var_331_12 + var_331_6 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_12 + var_331_6
					end
				end

				arg_328_1.text_.text = var_331_9
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_13 = math.max(var_331_7, arg_328_1.talkMaxDuration)

			if var_331_6 <= arg_328_1.time_ and arg_328_1.time_ < var_331_6 + var_331_13 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_6) / var_331_13

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_6 + var_331_13 and arg_328_1.time_ < var_331_6 + var_331_13 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play103704083 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 103704083
		arg_332_1.duration_ = 3.7

		local var_332_0 = {
			ja = 3.7,
			ko = 2.6,
			en = 1.866
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play103704084(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0
			local var_335_1 = 0.225

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_2 = arg_332_1:FormatText(StoryNameCfg[190].name)

				arg_332_1.leftNameTxt_.text = var_335_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_3 = arg_332_1:GetWordFromCfg(103704083)
				local var_335_4 = arg_332_1:FormatText(var_335_3.content)

				arg_332_1.text_.text = var_335_4

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_5 = 9
				local var_335_6 = utf8.len(var_335_4)
				local var_335_7 = var_335_5 <= 0 and var_335_1 or var_335_1 * (var_335_6 / var_335_5)

				if var_335_7 > 0 and var_335_1 < var_335_7 then
					arg_332_1.talkMaxDuration = var_335_7

					if var_335_7 + var_335_0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_0
					end
				end

				arg_332_1.text_.text = var_335_4
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704083", "story_v_side_old_103704.awb") ~= 0 then
					local var_335_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704083", "story_v_side_old_103704.awb") / 1000

					if var_335_8 + var_335_0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_8 + var_335_0
					end

					if var_335_3.prefab_name ~= "" and arg_332_1.actors_[var_335_3.prefab_name] ~= nil then
						local var_335_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_3.prefab_name].transform, "story_v_side_old_103704", "103704083", "story_v_side_old_103704.awb")

						arg_332_1:RecordAudio("103704083", var_335_9)
						arg_332_1:RecordAudio("103704083", var_335_9)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704083", "story_v_side_old_103704.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704083", "story_v_side_old_103704.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_10 = math.max(var_335_1, arg_332_1.talkMaxDuration)

			if var_335_0 <= arg_332_1.time_ and arg_332_1.time_ < var_335_0 + var_335_10 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_0) / var_335_10

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_0 + var_335_10 and arg_332_1.time_ < var_335_0 + var_335_10 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play103704084 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 103704084
		arg_336_1.duration_ = 2.6

		local var_336_0 = {
			ja = 1.833,
			ko = 1.766,
			en = 2.6
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play103704085(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["1037ui_story"].transform
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1.var_.moveOldPos1037ui_story = var_339_0.localPosition
			end

			local var_339_2 = 0.001

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2
				local var_339_4 = Vector3.New(0, 100, 0)

				var_339_0.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1037ui_story, var_339_4, var_339_3)

				local var_339_5 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_5.x, var_339_5.y, var_339_5.z)

				local var_339_6 = var_339_0.localEulerAngles

				var_339_6.z = 0
				var_339_6.x = 0
				var_339_0.localEulerAngles = var_339_6
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 then
				var_339_0.localPosition = Vector3.New(0, 100, 0)

				local var_339_7 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_7.x, var_339_7.y, var_339_7.z)

				local var_339_8 = var_339_0.localEulerAngles

				var_339_8.z = 0
				var_339_8.x = 0
				var_339_0.localEulerAngles = var_339_8
			end

			local var_339_9 = 0
			local var_339_10 = 1

			if var_339_9 < arg_336_1.time_ and arg_336_1.time_ <= var_339_9 + arg_339_0 then
				local var_339_11 = "play"
				local var_339_12 = "effect"

				arg_336_1:AudioAction(var_339_11, var_339_12, "se_story_side_1037", "se_story_1037_electric", "")
			end

			local var_339_13 = 0
			local var_339_14 = 0.3

			if var_339_13 < arg_336_1.time_ and arg_336_1.time_ <= var_339_13 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_15 = arg_336_1:FormatText(StoryNameCfg[190].name)

				arg_336_1.leftNameTxt_.text = var_339_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_16 = arg_336_1:GetWordFromCfg(103704084)
				local var_339_17 = arg_336_1:FormatText(var_339_16.content)

				arg_336_1.text_.text = var_339_17

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_18 = 12
				local var_339_19 = utf8.len(var_339_17)
				local var_339_20 = var_339_18 <= 0 and var_339_14 or var_339_14 * (var_339_19 / var_339_18)

				if var_339_20 > 0 and var_339_14 < var_339_20 then
					arg_336_1.talkMaxDuration = var_339_20

					if var_339_20 + var_339_13 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_20 + var_339_13
					end
				end

				arg_336_1.text_.text = var_339_17
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704084", "story_v_side_old_103704.awb") ~= 0 then
					local var_339_21 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704084", "story_v_side_old_103704.awb") / 1000

					if var_339_21 + var_339_13 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_21 + var_339_13
					end

					if var_339_16.prefab_name ~= "" and arg_336_1.actors_[var_339_16.prefab_name] ~= nil then
						local var_339_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_16.prefab_name].transform, "story_v_side_old_103704", "103704084", "story_v_side_old_103704.awb")

						arg_336_1:RecordAudio("103704084", var_339_22)
						arg_336_1:RecordAudio("103704084", var_339_22)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704084", "story_v_side_old_103704.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704084", "story_v_side_old_103704.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_23 = math.max(var_339_14, arg_336_1.talkMaxDuration)

			if var_339_13 <= arg_336_1.time_ and arg_336_1.time_ < var_339_13 + var_339_23 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_13) / var_339_23

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_13 + var_339_23 and arg_336_1.time_ < var_339_13 + var_339_23 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play103704085 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 103704085
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play103704086(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0.333333333333333
			local var_343_1 = 1

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				local var_343_2 = "play"
				local var_343_3 = "effect"

				arg_340_1:AudioAction(var_343_2, var_343_3, "se_story_side_1037", "se_story_1037_fall", "")
			end

			local var_343_4 = 0
			local var_343_5 = 0.875

			if var_343_4 < arg_340_1.time_ and arg_340_1.time_ <= var_343_4 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_6 = arg_340_1:GetWordFromCfg(103704085)
				local var_343_7 = arg_340_1:FormatText(var_343_6.content)

				arg_340_1.text_.text = var_343_7

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_8 = 35
				local var_343_9 = utf8.len(var_343_7)
				local var_343_10 = var_343_8 <= 0 and var_343_5 or var_343_5 * (var_343_9 / var_343_8)

				if var_343_10 > 0 and var_343_5 < var_343_10 then
					arg_340_1.talkMaxDuration = var_343_10

					if var_343_10 + var_343_4 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_10 + var_343_4
					end
				end

				arg_340_1.text_.text = var_343_7
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_11 = math.max(var_343_5, arg_340_1.talkMaxDuration)

			if var_343_4 <= arg_340_1.time_ and arg_340_1.time_ < var_343_4 + var_343_11 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_4) / var_343_11

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_4 + var_343_11 and arg_340_1.time_ < var_343_4 + var_343_11 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play103704086 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 103704086
		arg_344_1.duration_ = 2.4

		local var_344_0 = {
			ja = 2.3,
			ko = 2.4,
			en = 2.266
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
				arg_344_0:Play103704087(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 0.225

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_2 = arg_344_1:FormatText(StoryNameCfg[36].name)

				arg_344_1.leftNameTxt_.text = var_347_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_3 = arg_344_1:GetWordFromCfg(103704086)
				local var_347_4 = arg_344_1:FormatText(var_347_3.content)

				arg_344_1.text_.text = var_347_4

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 9
				local var_347_6 = utf8.len(var_347_4)
				local var_347_7 = var_347_5 <= 0 and var_347_1 or var_347_1 * (var_347_6 / var_347_5)

				if var_347_7 > 0 and var_347_1 < var_347_7 then
					arg_344_1.talkMaxDuration = var_347_7

					if var_347_7 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_4
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704086", "story_v_side_old_103704.awb") ~= 0 then
					local var_347_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704086", "story_v_side_old_103704.awb") / 1000

					if var_347_8 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_8 + var_347_0
					end

					if var_347_3.prefab_name ~= "" and arg_344_1.actors_[var_347_3.prefab_name] ~= nil then
						local var_347_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_3.prefab_name].transform, "story_v_side_old_103704", "103704086", "story_v_side_old_103704.awb")

						arg_344_1:RecordAudio("103704086", var_347_9)
						arg_344_1:RecordAudio("103704086", var_347_9)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704086", "story_v_side_old_103704.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704086", "story_v_side_old_103704.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_10 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_10 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_10

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_10 and arg_344_1.time_ < var_347_0 + var_347_10 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play103704087 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 103704087
		arg_348_1.duration_ = 2

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play103704088(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1037ui_story"].transform
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.var_.moveOldPos1037ui_story = var_351_0.localPosition
			end

			local var_351_2 = 0.001

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2
				local var_351_4 = Vector3.New(0, -1.09, -5.81)

				var_351_0.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1037ui_story, var_351_4, var_351_3)

				local var_351_5 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_5.x, var_351_5.y, var_351_5.z)

				local var_351_6 = var_351_0.localEulerAngles

				var_351_6.z = 0
				var_351_6.x = 0
				var_351_0.localEulerAngles = var_351_6
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 then
				var_351_0.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_351_7 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_7.x, var_351_7.y, var_351_7.z)

				local var_351_8 = var_351_0.localEulerAngles

				var_351_8.z = 0
				var_351_8.x = 0
				var_351_0.localEulerAngles = var_351_8
			end

			local var_351_9 = arg_348_1.actors_["1037ui_story"]
			local var_351_10 = 0

			if var_351_10 < arg_348_1.time_ and arg_348_1.time_ <= var_351_10 + arg_351_0 and not isNil(var_351_9) and arg_348_1.var_.characterEffect1037ui_story == nil then
				arg_348_1.var_.characterEffect1037ui_story = var_351_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_11 = 0.2

			if var_351_10 <= arg_348_1.time_ and arg_348_1.time_ < var_351_10 + var_351_11 and not isNil(var_351_9) then
				local var_351_12 = (arg_348_1.time_ - var_351_10) / var_351_11

				if arg_348_1.var_.characterEffect1037ui_story and not isNil(var_351_9) then
					arg_348_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= var_351_10 + var_351_11 and arg_348_1.time_ < var_351_10 + var_351_11 + arg_351_0 and not isNil(var_351_9) and arg_348_1.var_.characterEffect1037ui_story then
				arg_348_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_351_13 = 0

			if var_351_13 < arg_348_1.time_ and arg_348_1.time_ <= var_351_13 + arg_351_0 then
				arg_348_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_351_14 = 0

			if var_351_14 < arg_348_1.time_ and arg_348_1.time_ <= var_351_14 + arg_351_0 then
				arg_348_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_1")
			end

			local var_351_15 = 0
			local var_351_16 = 0.15

			if var_351_15 < arg_348_1.time_ and arg_348_1.time_ <= var_351_15 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_17 = arg_348_1:FormatText(StoryNameCfg[15].name)

				arg_348_1.leftNameTxt_.text = var_351_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_18 = arg_348_1:GetWordFromCfg(103704087)
				local var_351_19 = arg_348_1:FormatText(var_351_18.content)

				arg_348_1.text_.text = var_351_19

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_20 = 6
				local var_351_21 = utf8.len(var_351_19)
				local var_351_22 = var_351_20 <= 0 and var_351_16 or var_351_16 * (var_351_21 / var_351_20)

				if var_351_22 > 0 and var_351_16 < var_351_22 then
					arg_348_1.talkMaxDuration = var_351_22

					if var_351_22 + var_351_15 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_22 + var_351_15
					end
				end

				arg_348_1.text_.text = var_351_19
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704087", "story_v_side_old_103704.awb") ~= 0 then
					local var_351_23 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704087", "story_v_side_old_103704.awb") / 1000

					if var_351_23 + var_351_15 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_23 + var_351_15
					end

					if var_351_18.prefab_name ~= "" and arg_348_1.actors_[var_351_18.prefab_name] ~= nil then
						local var_351_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_18.prefab_name].transform, "story_v_side_old_103704", "103704087", "story_v_side_old_103704.awb")

						arg_348_1:RecordAudio("103704087", var_351_24)
						arg_348_1:RecordAudio("103704087", var_351_24)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704087", "story_v_side_old_103704.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704087", "story_v_side_old_103704.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_25 = math.max(var_351_16, arg_348_1.talkMaxDuration)

			if var_351_15 <= arg_348_1.time_ and arg_348_1.time_ < var_351_15 + var_351_25 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_15) / var_351_25

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_15 + var_351_25 and arg_348_1.time_ < var_351_15 + var_351_25 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play103704088 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 103704088
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play103704089(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1037ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1037ui_story == nil then
				arg_352_1.var_.characterEffect1037ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.2

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect1037ui_story and not isNil(var_355_0) then
					local var_355_4 = Mathf.Lerp(0, 0.5, var_355_3)

					arg_352_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1037ui_story.fillRatio = var_355_4
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1037ui_story then
				local var_355_5 = 0.5

				arg_352_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1037ui_story.fillRatio = var_355_5
			end

			local var_355_6 = 0
			local var_355_7 = 0.525

			if var_355_6 < arg_352_1.time_ and arg_352_1.time_ <= var_355_6 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, false)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_8 = arg_352_1:GetWordFromCfg(103704088)
				local var_355_9 = arg_352_1:FormatText(var_355_8.content)

				arg_352_1.text_.text = var_355_9

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_10 = 21
				local var_355_11 = utf8.len(var_355_9)
				local var_355_12 = var_355_10 <= 0 and var_355_7 or var_355_7 * (var_355_11 / var_355_10)

				if var_355_12 > 0 and var_355_7 < var_355_12 then
					arg_352_1.talkMaxDuration = var_355_12

					if var_355_12 + var_355_6 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_12 + var_355_6
					end
				end

				arg_352_1.text_.text = var_355_9
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_13 = math.max(var_355_7, arg_352_1.talkMaxDuration)

			if var_355_6 <= arg_352_1.time_ and arg_352_1.time_ < var_355_6 + var_355_13 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_6) / var_355_13

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_6 + var_355_13 and arg_352_1.time_ < var_355_6 + var_355_13 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play103704089 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 103704089
		arg_356_1.duration_ = 7.03

		local var_356_0 = {
			ja = 4.533,
			ko = 7.033,
			en = 3.533
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play103704090(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["1037ui_story"]
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect1037ui_story == nil then
				arg_356_1.var_.characterEffect1037ui_story = var_359_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.2

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 and not isNil(var_359_0) then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2

				if arg_356_1.var_.characterEffect1037ui_story and not isNil(var_359_0) then
					arg_356_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect1037ui_story then
				arg_356_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_359_4 = 0

			if var_359_4 < arg_356_1.time_ and arg_356_1.time_ <= var_359_4 + arg_359_0 then
				arg_356_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_359_5 = 0

			if var_359_5 < arg_356_1.time_ and arg_356_1.time_ <= var_359_5 + arg_359_0 then
				arg_356_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action443")
			end

			local var_359_6 = 0
			local var_359_7 = 0.525

			if var_359_6 < arg_356_1.time_ and arg_356_1.time_ <= var_359_6 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_8 = arg_356_1:FormatText(StoryNameCfg[15].name)

				arg_356_1.leftNameTxt_.text = var_359_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_9 = arg_356_1:GetWordFromCfg(103704089)
				local var_359_10 = arg_356_1:FormatText(var_359_9.content)

				arg_356_1.text_.text = var_359_10

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_11 = 21
				local var_359_12 = utf8.len(var_359_10)
				local var_359_13 = var_359_11 <= 0 and var_359_7 or var_359_7 * (var_359_12 / var_359_11)

				if var_359_13 > 0 and var_359_7 < var_359_13 then
					arg_356_1.talkMaxDuration = var_359_13

					if var_359_13 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_13 + var_359_6
					end
				end

				arg_356_1.text_.text = var_359_10
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704089", "story_v_side_old_103704.awb") ~= 0 then
					local var_359_14 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704089", "story_v_side_old_103704.awb") / 1000

					if var_359_14 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_14 + var_359_6
					end

					if var_359_9.prefab_name ~= "" and arg_356_1.actors_[var_359_9.prefab_name] ~= nil then
						local var_359_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_9.prefab_name].transform, "story_v_side_old_103704", "103704089", "story_v_side_old_103704.awb")

						arg_356_1:RecordAudio("103704089", var_359_15)
						arg_356_1:RecordAudio("103704089", var_359_15)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704089", "story_v_side_old_103704.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704089", "story_v_side_old_103704.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_16 = math.max(var_359_7, arg_356_1.talkMaxDuration)

			if var_359_6 <= arg_356_1.time_ and arg_356_1.time_ < var_359_6 + var_359_16 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_6) / var_359_16

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_6 + var_359_16 and arg_356_1.time_ < var_359_6 + var_359_16 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play103704090 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 103704090
		arg_360_1.duration_ = 4.7

		local var_360_0 = {
			ja = 4.633,
			ko = 4.7,
			en = 4.5
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play103704091(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_363_1 = 0
			local var_363_2 = 0.575

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_3 = arg_360_1:FormatText(StoryNameCfg[15].name)

				arg_360_1.leftNameTxt_.text = var_363_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_4 = arg_360_1:GetWordFromCfg(103704090)
				local var_363_5 = arg_360_1:FormatText(var_363_4.content)

				arg_360_1.text_.text = var_363_5

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_6 = 23
				local var_363_7 = utf8.len(var_363_5)
				local var_363_8 = var_363_6 <= 0 and var_363_2 or var_363_2 * (var_363_7 / var_363_6)

				if var_363_8 > 0 and var_363_2 < var_363_8 then
					arg_360_1.talkMaxDuration = var_363_8

					if var_363_8 + var_363_1 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_1
					end
				end

				arg_360_1.text_.text = var_363_5
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704090", "story_v_side_old_103704.awb") ~= 0 then
					local var_363_9 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704090", "story_v_side_old_103704.awb") / 1000

					if var_363_9 + var_363_1 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_9 + var_363_1
					end

					if var_363_4.prefab_name ~= "" and arg_360_1.actors_[var_363_4.prefab_name] ~= nil then
						local var_363_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_4.prefab_name].transform, "story_v_side_old_103704", "103704090", "story_v_side_old_103704.awb")

						arg_360_1:RecordAudio("103704090", var_363_10)
						arg_360_1:RecordAudio("103704090", var_363_10)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704090", "story_v_side_old_103704.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704090", "story_v_side_old_103704.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_11 = math.max(var_363_2, arg_360_1.talkMaxDuration)

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_11 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_1) / var_363_11

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_1 + var_363_11 and arg_360_1.time_ < var_363_1 + var_363_11 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play103704091 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 103704091
		arg_364_1.duration_ = 7.4

		local var_364_0 = {
			ja = 7.4,
			ko = 4.8,
			en = 4.666
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
				arg_364_0:Play103704092(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["1037ui_story"].transform
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.var_.moveOldPos1037ui_story = var_367_0.localPosition
			end

			local var_367_2 = 0.001

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2
				local var_367_4 = Vector3.New(-0.7, -1.09, -5.81)

				var_367_0.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1037ui_story, var_367_4, var_367_3)

				local var_367_5 = manager.ui.mainCamera.transform.position - var_367_0.position

				var_367_0.forward = Vector3.New(var_367_5.x, var_367_5.y, var_367_5.z)

				local var_367_6 = var_367_0.localEulerAngles

				var_367_6.z = 0
				var_367_6.x = 0
				var_367_0.localEulerAngles = var_367_6
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 then
				var_367_0.localPosition = Vector3.New(-0.7, -1.09, -5.81)

				local var_367_7 = manager.ui.mainCamera.transform.position - var_367_0.position

				var_367_0.forward = Vector3.New(var_367_7.x, var_367_7.y, var_367_7.z)

				local var_367_8 = var_367_0.localEulerAngles

				var_367_8.z = 0
				var_367_8.x = 0
				var_367_0.localEulerAngles = var_367_8
			end

			local var_367_9 = "1036ui_story"

			if arg_364_1.actors_[var_367_9] == nil then
				local var_367_10 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_367_10) then
					local var_367_11 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_364_1.stage_.transform)

					var_367_11.name = var_367_9
					var_367_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_364_1.actors_[var_367_9] = var_367_11

					local var_367_12 = var_367_11:GetComponentInChildren(typeof(CharacterEffect))

					var_367_12.enabled = true

					local var_367_13 = GameObjectTools.GetOrAddComponent(var_367_11, typeof(DynamicBoneHelper))

					if var_367_13 then
						var_367_13:EnableDynamicBone(false)
					end

					arg_364_1:ShowWeapon(var_367_12.transform, false)

					arg_364_1.var_[var_367_9 .. "Animator"] = var_367_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_364_1.var_[var_367_9 .. "Animator"].applyRootMotion = true
					arg_364_1.var_[var_367_9 .. "LipSync"] = var_367_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_367_14 = arg_364_1.actors_["1036ui_story"].transform
			local var_367_15 = 0

			if var_367_15 < arg_364_1.time_ and arg_364_1.time_ <= var_367_15 + arg_367_0 then
				arg_364_1.var_.moveOldPos1036ui_story = var_367_14.localPosition
			end

			local var_367_16 = 0.001

			if var_367_15 <= arg_364_1.time_ and arg_364_1.time_ < var_367_15 + var_367_16 then
				local var_367_17 = (arg_364_1.time_ - var_367_15) / var_367_16
				local var_367_18 = Vector3.New(0.7, -1.09, -5.78)

				var_367_14.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1036ui_story, var_367_18, var_367_17)

				local var_367_19 = manager.ui.mainCamera.transform.position - var_367_14.position

				var_367_14.forward = Vector3.New(var_367_19.x, var_367_19.y, var_367_19.z)

				local var_367_20 = var_367_14.localEulerAngles

				var_367_20.z = 0
				var_367_20.x = 0
				var_367_14.localEulerAngles = var_367_20
			end

			if arg_364_1.time_ >= var_367_15 + var_367_16 and arg_364_1.time_ < var_367_15 + var_367_16 + arg_367_0 then
				var_367_14.localPosition = Vector3.New(0.7, -1.09, -5.78)

				local var_367_21 = manager.ui.mainCamera.transform.position - var_367_14.position

				var_367_14.forward = Vector3.New(var_367_21.x, var_367_21.y, var_367_21.z)

				local var_367_22 = var_367_14.localEulerAngles

				var_367_22.z = 0
				var_367_22.x = 0
				var_367_14.localEulerAngles = var_367_22
			end

			local var_367_23 = arg_364_1.actors_["1037ui_story"]
			local var_367_24 = 0

			if var_367_24 < arg_364_1.time_ and arg_364_1.time_ <= var_367_24 + arg_367_0 and not isNil(var_367_23) and arg_364_1.var_.characterEffect1037ui_story == nil then
				arg_364_1.var_.characterEffect1037ui_story = var_367_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_25 = 0.2

			if var_367_24 <= arg_364_1.time_ and arg_364_1.time_ < var_367_24 + var_367_25 and not isNil(var_367_23) then
				local var_367_26 = (arg_364_1.time_ - var_367_24) / var_367_25

				if arg_364_1.var_.characterEffect1037ui_story and not isNil(var_367_23) then
					local var_367_27 = Mathf.Lerp(0, 0.5, var_367_26)

					arg_364_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_364_1.var_.characterEffect1037ui_story.fillRatio = var_367_27
				end
			end

			if arg_364_1.time_ >= var_367_24 + var_367_25 and arg_364_1.time_ < var_367_24 + var_367_25 + arg_367_0 and not isNil(var_367_23) and arg_364_1.var_.characterEffect1037ui_story then
				local var_367_28 = 0.5

				arg_364_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_364_1.var_.characterEffect1037ui_story.fillRatio = var_367_28
			end

			local var_367_29 = arg_364_1.actors_["1036ui_story"]
			local var_367_30 = 0

			if var_367_30 < arg_364_1.time_ and arg_364_1.time_ <= var_367_30 + arg_367_0 and not isNil(var_367_29) and arg_364_1.var_.characterEffect1036ui_story == nil then
				arg_364_1.var_.characterEffect1036ui_story = var_367_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_31 = 0.2

			if var_367_30 <= arg_364_1.time_ and arg_364_1.time_ < var_367_30 + var_367_31 and not isNil(var_367_29) then
				local var_367_32 = (arg_364_1.time_ - var_367_30) / var_367_31

				if arg_364_1.var_.characterEffect1036ui_story and not isNil(var_367_29) then
					arg_364_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_364_1.time_ >= var_367_30 + var_367_31 and arg_364_1.time_ < var_367_30 + var_367_31 + arg_367_0 and not isNil(var_367_29) and arg_364_1.var_.characterEffect1036ui_story then
				arg_364_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_367_33 = 0

			if var_367_33 < arg_364_1.time_ and arg_364_1.time_ <= var_367_33 + arg_367_0 then
				arg_364_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_367_34 = 0

			if var_367_34 < arg_364_1.time_ and arg_364_1.time_ <= var_367_34 + arg_367_0 then
				arg_364_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_367_35 = 0
			local var_367_36 = 0.55

			if var_367_35 < arg_364_1.time_ and arg_364_1.time_ <= var_367_35 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_37 = arg_364_1:FormatText(StoryNameCfg[5].name)

				arg_364_1.leftNameTxt_.text = var_367_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_38 = arg_364_1:GetWordFromCfg(103704091)
				local var_367_39 = arg_364_1:FormatText(var_367_38.content)

				arg_364_1.text_.text = var_367_39

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_40 = 22
				local var_367_41 = utf8.len(var_367_39)
				local var_367_42 = var_367_40 <= 0 and var_367_36 or var_367_36 * (var_367_41 / var_367_40)

				if var_367_42 > 0 and var_367_36 < var_367_42 then
					arg_364_1.talkMaxDuration = var_367_42

					if var_367_42 + var_367_35 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_42 + var_367_35
					end
				end

				arg_364_1.text_.text = var_367_39
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704091", "story_v_side_old_103704.awb") ~= 0 then
					local var_367_43 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704091", "story_v_side_old_103704.awb") / 1000

					if var_367_43 + var_367_35 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_43 + var_367_35
					end

					if var_367_38.prefab_name ~= "" and arg_364_1.actors_[var_367_38.prefab_name] ~= nil then
						local var_367_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_38.prefab_name].transform, "story_v_side_old_103704", "103704091", "story_v_side_old_103704.awb")

						arg_364_1:RecordAudio("103704091", var_367_44)
						arg_364_1:RecordAudio("103704091", var_367_44)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704091", "story_v_side_old_103704.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704091", "story_v_side_old_103704.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_45 = math.max(var_367_36, arg_364_1.talkMaxDuration)

			if var_367_35 <= arg_364_1.time_ and arg_364_1.time_ < var_367_35 + var_367_45 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_35) / var_367_45

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_35 + var_367_45 and arg_364_1.time_ < var_367_35 + var_367_45 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	Play103704092 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 103704092
		arg_368_1.duration_ = 10.07

		local var_368_0 = {
			ja = 10.066,
			ko = 6.533,
			en = 6.366
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play103704093(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_371_1 = 0
			local var_371_2 = 0.75

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_3 = arg_368_1:FormatText(StoryNameCfg[5].name)

				arg_368_1.leftNameTxt_.text = var_371_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_4 = arg_368_1:GetWordFromCfg(103704092)
				local var_371_5 = arg_368_1:FormatText(var_371_4.content)

				arg_368_1.text_.text = var_371_5

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_6 = 30
				local var_371_7 = utf8.len(var_371_5)
				local var_371_8 = var_371_6 <= 0 and var_371_2 or var_371_2 * (var_371_7 / var_371_6)

				if var_371_8 > 0 and var_371_2 < var_371_8 then
					arg_368_1.talkMaxDuration = var_371_8

					if var_371_8 + var_371_1 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_1
					end
				end

				arg_368_1.text_.text = var_371_5
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704092", "story_v_side_old_103704.awb") ~= 0 then
					local var_371_9 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704092", "story_v_side_old_103704.awb") / 1000

					if var_371_9 + var_371_1 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_9 + var_371_1
					end

					if var_371_4.prefab_name ~= "" and arg_368_1.actors_[var_371_4.prefab_name] ~= nil then
						local var_371_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_4.prefab_name].transform, "story_v_side_old_103704", "103704092", "story_v_side_old_103704.awb")

						arg_368_1:RecordAudio("103704092", var_371_10)
						arg_368_1:RecordAudio("103704092", var_371_10)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704092", "story_v_side_old_103704.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704092", "story_v_side_old_103704.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_11 = math.max(var_371_2, arg_368_1.talkMaxDuration)

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_11 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_1) / var_371_11

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_1 + var_371_11 and arg_368_1.time_ < var_371_1 + var_371_11 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play103704093 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 103704093
		arg_372_1.duration_ = 9.87

		local var_372_0 = {
			ja = 7.366,
			ko = 9.866,
			en = 7.1
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
				arg_372_0:Play103704094(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["1036ui_story"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect1036ui_story == nil then
				arg_372_1.var_.characterEffect1036ui_story = var_375_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.2

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.characterEffect1036ui_story and not isNil(var_375_0) then
					local var_375_4 = Mathf.Lerp(0, 0.5, var_375_3)

					arg_372_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_372_1.var_.characterEffect1036ui_story.fillRatio = var_375_4
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect1036ui_story then
				local var_375_5 = 0.5

				arg_372_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_372_1.var_.characterEffect1036ui_story.fillRatio = var_375_5
			end

			local var_375_6 = 0
			local var_375_7 = 0.675

			if var_375_6 < arg_372_1.time_ and arg_372_1.time_ <= var_375_6 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_8 = arg_372_1:FormatText(StoryNameCfg[52].name)

				arg_372_1.leftNameTxt_.text = var_375_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6061")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_9 = arg_372_1:GetWordFromCfg(103704093)
				local var_375_10 = arg_372_1:FormatText(var_375_9.content)

				arg_372_1.text_.text = var_375_10

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_11 = 27
				local var_375_12 = utf8.len(var_375_10)
				local var_375_13 = var_375_11 <= 0 and var_375_7 or var_375_7 * (var_375_12 / var_375_11)

				if var_375_13 > 0 and var_375_7 < var_375_13 then
					arg_372_1.talkMaxDuration = var_375_13

					if var_375_13 + var_375_6 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_13 + var_375_6
					end
				end

				arg_372_1.text_.text = var_375_10
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704093", "story_v_side_old_103704.awb") ~= 0 then
					local var_375_14 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704093", "story_v_side_old_103704.awb") / 1000

					if var_375_14 + var_375_6 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_14 + var_375_6
					end

					if var_375_9.prefab_name ~= "" and arg_372_1.actors_[var_375_9.prefab_name] ~= nil then
						local var_375_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_9.prefab_name].transform, "story_v_side_old_103704", "103704093", "story_v_side_old_103704.awb")

						arg_372_1:RecordAudio("103704093", var_375_15)
						arg_372_1:RecordAudio("103704093", var_375_15)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704093", "story_v_side_old_103704.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704093", "story_v_side_old_103704.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_16 = math.max(var_375_7, arg_372_1.talkMaxDuration)

			if var_375_6 <= arg_372_1.time_ and arg_372_1.time_ < var_375_6 + var_375_16 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_6) / var_375_16

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_6 + var_375_16 and arg_372_1.time_ < var_375_6 + var_375_16 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play103704094 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 103704094
		arg_376_1.duration_ = 4.33

		local var_376_0 = {
			ja = 2.933,
			ko = 4.333,
			en = 3.133
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play103704095(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["1036ui_story"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect1036ui_story == nil then
				arg_376_1.var_.characterEffect1036ui_story = var_379_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.2

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.characterEffect1036ui_story and not isNil(var_379_0) then
					arg_376_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect1036ui_story then
				arg_376_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_379_4 = 0

			if var_379_4 < arg_376_1.time_ and arg_376_1.time_ <= var_379_4 + arg_379_0 then
				arg_376_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_379_5 = 0
			local var_379_6 = 0.35

			if var_379_5 < arg_376_1.time_ and arg_376_1.time_ <= var_379_5 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_7 = arg_376_1:FormatText(StoryNameCfg[5].name)

				arg_376_1.leftNameTxt_.text = var_379_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_8 = arg_376_1:GetWordFromCfg(103704094)
				local var_379_9 = arg_376_1:FormatText(var_379_8.content)

				arg_376_1.text_.text = var_379_9

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_10 = 14
				local var_379_11 = utf8.len(var_379_9)
				local var_379_12 = var_379_10 <= 0 and var_379_6 or var_379_6 * (var_379_11 / var_379_10)

				if var_379_12 > 0 and var_379_6 < var_379_12 then
					arg_376_1.talkMaxDuration = var_379_12

					if var_379_12 + var_379_5 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_12 + var_379_5
					end
				end

				arg_376_1.text_.text = var_379_9
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704094", "story_v_side_old_103704.awb") ~= 0 then
					local var_379_13 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704094", "story_v_side_old_103704.awb") / 1000

					if var_379_13 + var_379_5 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_13 + var_379_5
					end

					if var_379_8.prefab_name ~= "" and arg_376_1.actors_[var_379_8.prefab_name] ~= nil then
						local var_379_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_8.prefab_name].transform, "story_v_side_old_103704", "103704094", "story_v_side_old_103704.awb")

						arg_376_1:RecordAudio("103704094", var_379_14)
						arg_376_1:RecordAudio("103704094", var_379_14)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704094", "story_v_side_old_103704.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704094", "story_v_side_old_103704.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_15 = math.max(var_379_6, arg_376_1.talkMaxDuration)

			if var_379_5 <= arg_376_1.time_ and arg_376_1.time_ < var_379_5 + var_379_15 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_5) / var_379_15

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_5 + var_379_15 and arg_376_1.time_ < var_379_5 + var_379_15 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play103704095 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 103704095
		arg_380_1.duration_ = 5.77

		local var_380_0 = {
			ja = 4.666,
			ko = 5.766,
			en = 2.666
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
				arg_380_0:Play103704096(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["1036ui_story"]
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect1036ui_story == nil then
				arg_380_1.var_.characterEffect1036ui_story = var_383_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_2 = 0.2

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 and not isNil(var_383_0) then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2

				if arg_380_1.var_.characterEffect1036ui_story and not isNil(var_383_0) then
					local var_383_4 = Mathf.Lerp(0, 0.5, var_383_3)

					arg_380_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_380_1.var_.characterEffect1036ui_story.fillRatio = var_383_4
				end
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 and not isNil(var_383_0) and arg_380_1.var_.characterEffect1036ui_story then
				local var_383_5 = 0.5

				arg_380_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_380_1.var_.characterEffect1036ui_story.fillRatio = var_383_5
			end

			local var_383_6 = arg_380_1.actors_["1037ui_story"]
			local var_383_7 = 0

			if var_383_7 < arg_380_1.time_ and arg_380_1.time_ <= var_383_7 + arg_383_0 and not isNil(var_383_6) and arg_380_1.var_.characterEffect1037ui_story == nil then
				arg_380_1.var_.characterEffect1037ui_story = var_383_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_8 = 0.2

			if var_383_7 <= arg_380_1.time_ and arg_380_1.time_ < var_383_7 + var_383_8 and not isNil(var_383_6) then
				local var_383_9 = (arg_380_1.time_ - var_383_7) / var_383_8

				if arg_380_1.var_.characterEffect1037ui_story and not isNil(var_383_6) then
					arg_380_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= var_383_7 + var_383_8 and arg_380_1.time_ < var_383_7 + var_383_8 + arg_383_0 and not isNil(var_383_6) and arg_380_1.var_.characterEffect1037ui_story then
				arg_380_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_383_10 = 0

			if var_383_10 < arg_380_1.time_ and arg_380_1.time_ <= var_383_10 + arg_383_0 then
				arg_380_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_383_11 = 0

			if var_383_11 < arg_380_1.time_ and arg_380_1.time_ <= var_383_11 + arg_383_0 then
				arg_380_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action432")
			end

			local var_383_12 = 0
			local var_383_13 = 0.4

			if var_383_12 < arg_380_1.time_ and arg_380_1.time_ <= var_383_12 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_14 = arg_380_1:FormatText(StoryNameCfg[15].name)

				arg_380_1.leftNameTxt_.text = var_383_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_15 = arg_380_1:GetWordFromCfg(103704095)
				local var_383_16 = arg_380_1:FormatText(var_383_15.content)

				arg_380_1.text_.text = var_383_16

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_17 = 16
				local var_383_18 = utf8.len(var_383_16)
				local var_383_19 = var_383_17 <= 0 and var_383_13 or var_383_13 * (var_383_18 / var_383_17)

				if var_383_19 > 0 and var_383_13 < var_383_19 then
					arg_380_1.talkMaxDuration = var_383_19

					if var_383_19 + var_383_12 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_19 + var_383_12
					end
				end

				arg_380_1.text_.text = var_383_16
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704095", "story_v_side_old_103704.awb") ~= 0 then
					local var_383_20 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704095", "story_v_side_old_103704.awb") / 1000

					if var_383_20 + var_383_12 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_20 + var_383_12
					end

					if var_383_15.prefab_name ~= "" and arg_380_1.actors_[var_383_15.prefab_name] ~= nil then
						local var_383_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_15.prefab_name].transform, "story_v_side_old_103704", "103704095", "story_v_side_old_103704.awb")

						arg_380_1:RecordAudio("103704095", var_383_21)
						arg_380_1:RecordAudio("103704095", var_383_21)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704095", "story_v_side_old_103704.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704095", "story_v_side_old_103704.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_22 = math.max(var_383_13, arg_380_1.talkMaxDuration)

			if var_383_12 <= arg_380_1.time_ and arg_380_1.time_ < var_383_12 + var_383_22 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_12) / var_383_22

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_12 + var_383_22 and arg_380_1.time_ < var_383_12 + var_383_22 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play103704096 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 103704096
		arg_384_1.duration_ = 7.07

		local var_384_0 = {
			ja = 7.066,
			ko = 5.166,
			en = 5.266
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play103704097(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["1037ui_story"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect1037ui_story == nil then
				arg_384_1.var_.characterEffect1037ui_story = var_387_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.2

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.characterEffect1037ui_story and not isNil(var_387_0) then
					local var_387_4 = Mathf.Lerp(0, 0.5, var_387_3)

					arg_384_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_384_1.var_.characterEffect1037ui_story.fillRatio = var_387_4
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect1037ui_story then
				local var_387_5 = 0.5

				arg_384_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_384_1.var_.characterEffect1037ui_story.fillRatio = var_387_5
			end

			local var_387_6 = arg_384_1.actors_["1036ui_story"]
			local var_387_7 = 0

			if var_387_7 < arg_384_1.time_ and arg_384_1.time_ <= var_387_7 + arg_387_0 and not isNil(var_387_6) and arg_384_1.var_.characterEffect1036ui_story == nil then
				arg_384_1.var_.characterEffect1036ui_story = var_387_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_8 = 0.2

			if var_387_7 <= arg_384_1.time_ and arg_384_1.time_ < var_387_7 + var_387_8 and not isNil(var_387_6) then
				local var_387_9 = (arg_384_1.time_ - var_387_7) / var_387_8

				if arg_384_1.var_.characterEffect1036ui_story and not isNil(var_387_6) then
					arg_384_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= var_387_7 + var_387_8 and arg_384_1.time_ < var_387_7 + var_387_8 + arg_387_0 and not isNil(var_387_6) and arg_384_1.var_.characterEffect1036ui_story then
				arg_384_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_387_10 = 0

			if var_387_10 < arg_384_1.time_ and arg_384_1.time_ <= var_387_10 + arg_387_0 then
				arg_384_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_387_11 = 0

			if var_387_11 < arg_384_1.time_ and arg_384_1.time_ <= var_387_11 + arg_387_0 then
				arg_384_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action454")
			end

			local var_387_12 = 0
			local var_387_13 = 0.5

			if var_387_12 < arg_384_1.time_ and arg_384_1.time_ <= var_387_12 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_14 = arg_384_1:FormatText(StoryNameCfg[5].name)

				arg_384_1.leftNameTxt_.text = var_387_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_15 = arg_384_1:GetWordFromCfg(103704096)
				local var_387_16 = arg_384_1:FormatText(var_387_15.content)

				arg_384_1.text_.text = var_387_16

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_17 = 20
				local var_387_18 = utf8.len(var_387_16)
				local var_387_19 = var_387_17 <= 0 and var_387_13 or var_387_13 * (var_387_18 / var_387_17)

				if var_387_19 > 0 and var_387_13 < var_387_19 then
					arg_384_1.talkMaxDuration = var_387_19

					if var_387_19 + var_387_12 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_19 + var_387_12
					end
				end

				arg_384_1.text_.text = var_387_16
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704096", "story_v_side_old_103704.awb") ~= 0 then
					local var_387_20 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704096", "story_v_side_old_103704.awb") / 1000

					if var_387_20 + var_387_12 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_20 + var_387_12
					end

					if var_387_15.prefab_name ~= "" and arg_384_1.actors_[var_387_15.prefab_name] ~= nil then
						local var_387_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_15.prefab_name].transform, "story_v_side_old_103704", "103704096", "story_v_side_old_103704.awb")

						arg_384_1:RecordAudio("103704096", var_387_21)
						arg_384_1:RecordAudio("103704096", var_387_21)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704096", "story_v_side_old_103704.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704096", "story_v_side_old_103704.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_22 = math.max(var_387_13, arg_384_1.talkMaxDuration)

			if var_387_12 <= arg_384_1.time_ and arg_384_1.time_ < var_387_12 + var_387_22 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_12) / var_387_22

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_12 + var_387_22 and arg_384_1.time_ < var_387_12 + var_387_22 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play103704097 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 103704097
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play103704098(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1036ui_story"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1036ui_story == nil then
				arg_388_1.var_.characterEffect1036ui_story = var_391_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.2

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.characterEffect1036ui_story and not isNil(var_391_0) then
					local var_391_4 = Mathf.Lerp(0, 0.5, var_391_3)

					arg_388_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_388_1.var_.characterEffect1036ui_story.fillRatio = var_391_4
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1036ui_story then
				local var_391_5 = 0.5

				arg_388_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_388_1.var_.characterEffect1036ui_story.fillRatio = var_391_5
			end

			local var_391_6 = 0
			local var_391_7 = 0.75

			if var_391_6 < arg_388_1.time_ and arg_388_1.time_ <= var_391_6 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_8 = arg_388_1:GetWordFromCfg(103704097)
				local var_391_9 = arg_388_1:FormatText(var_391_8.content)

				arg_388_1.text_.text = var_391_9

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_10 = 30
				local var_391_11 = utf8.len(var_391_9)
				local var_391_12 = var_391_10 <= 0 and var_391_7 or var_391_7 * (var_391_11 / var_391_10)

				if var_391_12 > 0 and var_391_7 < var_391_12 then
					arg_388_1.talkMaxDuration = var_391_12

					if var_391_12 + var_391_6 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_12 + var_391_6
					end
				end

				arg_388_1.text_.text = var_391_9
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_13 = math.max(var_391_7, arg_388_1.talkMaxDuration)

			if var_391_6 <= arg_388_1.time_ and arg_388_1.time_ < var_391_6 + var_391_13 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_6) / var_391_13

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_6 + var_391_13 and arg_388_1.time_ < var_391_6 + var_391_13 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play103704098 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 103704098
		arg_392_1.duration_ = 6.77

		local var_392_0 = {
			ja = 4.8,
			ko = 4.9,
			en = 6.766
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play103704099(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1036ui_story"]
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1036ui_story == nil then
				arg_392_1.var_.characterEffect1036ui_story = var_395_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_2 = 0.2

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 and not isNil(var_395_0) then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2

				if arg_392_1.var_.characterEffect1036ui_story and not isNil(var_395_0) then
					arg_392_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect1036ui_story then
				arg_392_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_395_4 = 0

			if var_395_4 < arg_392_1.time_ and arg_392_1.time_ <= var_395_4 + arg_395_0 then
				arg_392_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_395_5 = 0

			if var_395_5 < arg_392_1.time_ and arg_392_1.time_ <= var_395_5 + arg_395_0 then
				arg_392_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action446")
			end

			local var_395_6 = 0
			local var_395_7 = 0.375

			if var_395_6 < arg_392_1.time_ and arg_392_1.time_ <= var_395_6 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_8 = arg_392_1:FormatText(StoryNameCfg[5].name)

				arg_392_1.leftNameTxt_.text = var_395_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_9 = arg_392_1:GetWordFromCfg(103704098)
				local var_395_10 = arg_392_1:FormatText(var_395_9.content)

				arg_392_1.text_.text = var_395_10

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_11 = 15
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

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704098", "story_v_side_old_103704.awb") ~= 0 then
					local var_395_14 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704098", "story_v_side_old_103704.awb") / 1000

					if var_395_14 + var_395_6 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_14 + var_395_6
					end

					if var_395_9.prefab_name ~= "" and arg_392_1.actors_[var_395_9.prefab_name] ~= nil then
						local var_395_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_9.prefab_name].transform, "story_v_side_old_103704", "103704098", "story_v_side_old_103704.awb")

						arg_392_1:RecordAudio("103704098", var_395_15)
						arg_392_1:RecordAudio("103704098", var_395_15)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704098", "story_v_side_old_103704.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704098", "story_v_side_old_103704.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_16 = math.max(var_395_7, arg_392_1.talkMaxDuration)

			if var_395_6 <= arg_392_1.time_ and arg_392_1.time_ < var_395_6 + var_395_16 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_6) / var_395_16

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_6 + var_395_16 and arg_392_1.time_ < var_395_6 + var_395_16 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play103704099 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 103704099
		arg_396_1.duration_ = 6

		local var_396_0 = {
			ja = 5.7,
			ko = 6,
			en = 5.4
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
				arg_396_0:Play103704100(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["1037ui_story"].transform
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.var_.moveOldPos1037ui_story = var_399_0.localPosition
			end

			local var_399_2 = 0.001

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2
				local var_399_4 = Vector3.New(0, 100, 0)

				var_399_0.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1037ui_story, var_399_4, var_399_3)

				local var_399_5 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_5.x, var_399_5.y, var_399_5.z)

				local var_399_6 = var_399_0.localEulerAngles

				var_399_6.z = 0
				var_399_6.x = 0
				var_399_0.localEulerAngles = var_399_6
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 then
				var_399_0.localPosition = Vector3.New(0, 100, 0)

				local var_399_7 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_7.x, var_399_7.y, var_399_7.z)

				local var_399_8 = var_399_0.localEulerAngles

				var_399_8.z = 0
				var_399_8.x = 0
				var_399_0.localEulerAngles = var_399_8
			end

			local var_399_9 = arg_396_1.actors_["1036ui_story"].transform
			local var_399_10 = 0

			if var_399_10 < arg_396_1.time_ and arg_396_1.time_ <= var_399_10 + arg_399_0 then
				arg_396_1.var_.moveOldPos1036ui_story = var_399_9.localPosition
			end

			local var_399_11 = 0.001

			if var_399_10 <= arg_396_1.time_ and arg_396_1.time_ < var_399_10 + var_399_11 then
				local var_399_12 = (arg_396_1.time_ - var_399_10) / var_399_11
				local var_399_13 = Vector3.New(0, 100, 0)

				var_399_9.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1036ui_story, var_399_13, var_399_12)

				local var_399_14 = manager.ui.mainCamera.transform.position - var_399_9.position

				var_399_9.forward = Vector3.New(var_399_14.x, var_399_14.y, var_399_14.z)

				local var_399_15 = var_399_9.localEulerAngles

				var_399_15.z = 0
				var_399_15.x = 0
				var_399_9.localEulerAngles = var_399_15
			end

			if arg_396_1.time_ >= var_399_10 + var_399_11 and arg_396_1.time_ < var_399_10 + var_399_11 + arg_399_0 then
				var_399_9.localPosition = Vector3.New(0, 100, 0)

				local var_399_16 = manager.ui.mainCamera.transform.position - var_399_9.position

				var_399_9.forward = Vector3.New(var_399_16.x, var_399_16.y, var_399_16.z)

				local var_399_17 = var_399_9.localEulerAngles

				var_399_17.z = 0
				var_399_17.x = 0
				var_399_9.localEulerAngles = var_399_17
			end

			local var_399_18 = 0
			local var_399_19 = 0.6

			if var_399_18 < arg_396_1.time_ and arg_396_1.time_ <= var_399_18 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_20 = arg_396_1:FormatText(StoryNameCfg[52].name)

				arg_396_1.leftNameTxt_.text = var_399_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6061")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_21 = arg_396_1:GetWordFromCfg(103704099)
				local var_399_22 = arg_396_1:FormatText(var_399_21.content)

				arg_396_1.text_.text = var_399_22

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_23 = 24
				local var_399_24 = utf8.len(var_399_22)
				local var_399_25 = var_399_23 <= 0 and var_399_19 or var_399_19 * (var_399_24 / var_399_23)

				if var_399_25 > 0 and var_399_19 < var_399_25 then
					arg_396_1.talkMaxDuration = var_399_25

					if var_399_25 + var_399_18 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_25 + var_399_18
					end
				end

				arg_396_1.text_.text = var_399_22
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704099", "story_v_side_old_103704.awb") ~= 0 then
					local var_399_26 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704099", "story_v_side_old_103704.awb") / 1000

					if var_399_26 + var_399_18 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_26 + var_399_18
					end

					if var_399_21.prefab_name ~= "" and arg_396_1.actors_[var_399_21.prefab_name] ~= nil then
						local var_399_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_21.prefab_name].transform, "story_v_side_old_103704", "103704099", "story_v_side_old_103704.awb")

						arg_396_1:RecordAudio("103704099", var_399_27)
						arg_396_1:RecordAudio("103704099", var_399_27)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704099", "story_v_side_old_103704.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704099", "story_v_side_old_103704.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_28 = math.max(var_399_19, arg_396_1.talkMaxDuration)

			if var_399_18 <= arg_396_1.time_ and arg_396_1.time_ < var_399_18 + var_399_28 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_18) / var_399_28

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_18 + var_399_28 and arg_396_1.time_ < var_399_18 + var_399_28 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play103704100 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 103704100
		arg_400_1.duration_ = 7.43

		local var_400_0 = {
			ja = 7.433,
			ko = 3.9,
			en = 6.133
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
				arg_400_0:Play103704101(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 0.3

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_2 = arg_400_1:FormatText(StoryNameCfg[5].name)

				arg_400_1.leftNameTxt_.text = var_403_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_3 = arg_400_1:GetWordFromCfg(103704100)
				local var_403_4 = arg_400_1:FormatText(var_403_3.content)

				arg_400_1.text_.text = var_403_4

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_5 = 12
				local var_403_6 = utf8.len(var_403_4)
				local var_403_7 = var_403_5 <= 0 and var_403_1 or var_403_1 * (var_403_6 / var_403_5)

				if var_403_7 > 0 and var_403_1 < var_403_7 then
					arg_400_1.talkMaxDuration = var_403_7

					if var_403_7 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_7 + var_403_0
					end
				end

				arg_400_1.text_.text = var_403_4
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704100", "story_v_side_old_103704.awb") ~= 0 then
					local var_403_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704100", "story_v_side_old_103704.awb") / 1000

					if var_403_8 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_8 + var_403_0
					end

					if var_403_3.prefab_name ~= "" and arg_400_1.actors_[var_403_3.prefab_name] ~= nil then
						local var_403_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_3.prefab_name].transform, "story_v_side_old_103704", "103704100", "story_v_side_old_103704.awb")

						arg_400_1:RecordAudio("103704100", var_403_9)
						arg_400_1:RecordAudio("103704100", var_403_9)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704100", "story_v_side_old_103704.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704100", "story_v_side_old_103704.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_10 = math.max(var_403_1, arg_400_1.talkMaxDuration)

			if var_403_0 <= arg_400_1.time_ and arg_400_1.time_ < var_403_0 + var_403_10 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_0) / var_403_10

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_0 + var_403_10 and arg_400_1.time_ < var_403_0 + var_403_10 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play103704101 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 103704101
		arg_404_1.duration_ = 2.17

		local var_404_0 = {
			ja = 1.3,
			ko = 2.166,
			en = 1.166
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play103704102(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0
			local var_407_1 = 0.075

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_2 = arg_404_1:FormatText(StoryNameCfg[15].name)

				arg_404_1.leftNameTxt_.text = var_407_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_3 = arg_404_1:GetWordFromCfg(103704101)
				local var_407_4 = arg_404_1:FormatText(var_407_3.content)

				arg_404_1.text_.text = var_407_4

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_5 = 3
				local var_407_6 = utf8.len(var_407_4)
				local var_407_7 = var_407_5 <= 0 and var_407_1 or var_407_1 * (var_407_6 / var_407_5)

				if var_407_7 > 0 and var_407_1 < var_407_7 then
					arg_404_1.talkMaxDuration = var_407_7

					if var_407_7 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_7 + var_407_0
					end
				end

				arg_404_1.text_.text = var_407_4
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704101", "story_v_side_old_103704.awb") ~= 0 then
					local var_407_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704101", "story_v_side_old_103704.awb") / 1000

					if var_407_8 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_8 + var_407_0
					end

					if var_407_3.prefab_name ~= "" and arg_404_1.actors_[var_407_3.prefab_name] ~= nil then
						local var_407_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_3.prefab_name].transform, "story_v_side_old_103704", "103704101", "story_v_side_old_103704.awb")

						arg_404_1:RecordAudio("103704101", var_407_9)
						arg_404_1:RecordAudio("103704101", var_407_9)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704101", "story_v_side_old_103704.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704101", "story_v_side_old_103704.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_10 = math.max(var_407_1, arg_404_1.talkMaxDuration)

			if var_407_0 <= arg_404_1.time_ and arg_404_1.time_ < var_407_0 + var_407_10 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_0) / var_407_10

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_0 + var_407_10 and arg_404_1.time_ < var_407_0 + var_407_10 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play103704102 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 103704102
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play103704103(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 0.75

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_2 = arg_408_1:GetWordFromCfg(103704102)
				local var_411_3 = arg_408_1:FormatText(var_411_2.content)

				arg_408_1.text_.text = var_411_3

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_4 = 30
				local var_411_5 = utf8.len(var_411_3)
				local var_411_6 = var_411_4 <= 0 and var_411_1 or var_411_1 * (var_411_5 / var_411_4)

				if var_411_6 > 0 and var_411_1 < var_411_6 then
					arg_408_1.talkMaxDuration = var_411_6

					if var_411_6 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_6 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_3
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_7 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_7 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_7

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_7 and arg_408_1.time_ < var_411_0 + var_411_7 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play103704103 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 103704103
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play103704104(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 1.2

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

				local var_415_2 = arg_412_1:GetWordFromCfg(103704103)
				local var_415_3 = arg_412_1:FormatText(var_415_2.content)

				arg_412_1.text_.text = var_415_3

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_4 = 48
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
	Play103704104 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 103704104
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play103704105(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 1.275

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, false)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_2 = arg_416_1:GetWordFromCfg(103704104)
				local var_419_3 = arg_416_1:FormatText(var_419_2.content)

				arg_416_1.text_.text = var_419_3

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 51
				local var_419_5 = utf8.len(var_419_3)
				local var_419_6 = var_419_4 <= 0 and var_419_1 or var_419_1 * (var_419_5 / var_419_4)

				if var_419_6 > 0 and var_419_1 < var_419_6 then
					arg_416_1.talkMaxDuration = var_419_6

					if var_419_6 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_6 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_3
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_7 and arg_416_1.time_ < var_419_0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play103704105 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 103704105
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play103704106(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0
			local var_423_1 = 0.975

			if var_423_0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_2 = arg_420_1:GetWordFromCfg(103704105)
				local var_423_3 = arg_420_1:FormatText(var_423_2.content)

				arg_420_1.text_.text = var_423_3

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_4 = 39
				local var_423_5 = utf8.len(var_423_3)
				local var_423_6 = var_423_4 <= 0 and var_423_1 or var_423_1 * (var_423_5 / var_423_4)

				if var_423_6 > 0 and var_423_1 < var_423_6 then
					arg_420_1.talkMaxDuration = var_423_6

					if var_423_6 + var_423_0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_6 + var_423_0
					end
				end

				arg_420_1.text_.text = var_423_3
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_7 = math.max(var_423_1, arg_420_1.talkMaxDuration)

			if var_423_0 <= arg_420_1.time_ and arg_420_1.time_ < var_423_0 + var_423_7 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_0) / var_423_7

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_0 + var_423_7 and arg_420_1.time_ < var_423_0 + var_423_7 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play103704106 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 103704106
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play103704107(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0
			local var_427_1 = 0.925

			if var_427_0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, false)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_2 = arg_424_1:GetWordFromCfg(103704106)
				local var_427_3 = arg_424_1:FormatText(var_427_2.content)

				arg_424_1.text_.text = var_427_3

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_4 = 37
				local var_427_5 = utf8.len(var_427_3)
				local var_427_6 = var_427_4 <= 0 and var_427_1 or var_427_1 * (var_427_5 / var_427_4)

				if var_427_6 > 0 and var_427_1 < var_427_6 then
					arg_424_1.talkMaxDuration = var_427_6

					if var_427_6 + var_427_0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_6 + var_427_0
					end
				end

				arg_424_1.text_.text = var_427_3
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_7 = math.max(var_427_1, arg_424_1.talkMaxDuration)

			if var_427_0 <= arg_424_1.time_ and arg_424_1.time_ < var_427_0 + var_427_7 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_0) / var_427_7

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_0 + var_427_7 and arg_424_1.time_ < var_427_0 + var_427_7 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play103704107 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 103704107
		arg_428_1.duration_ = 13.2

		local var_428_0 = {
			ja = 13.2,
			ko = 11.6,
			en = 12.7
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play103704108(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = "A00"

			if arg_428_1.bgs_[var_431_0] == nil then
				local var_431_1 = Object.Instantiate(arg_428_1.paintGo_)

				var_431_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_431_0)
				var_431_1.name = var_431_0
				var_431_1.transform.parent = arg_428_1.stage_.transform
				var_431_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_428_1.bgs_[var_431_0] = var_431_1
			end

			local var_431_2 = 0

			if var_431_2 < arg_428_1.time_ and arg_428_1.time_ <= var_431_2 + arg_431_0 then
				local var_431_3 = manager.ui.mainCamera.transform.localPosition
				local var_431_4 = Vector3.New(0, 0, 10) + Vector3.New(var_431_3.x, var_431_3.y, 0)
				local var_431_5 = arg_428_1.bgs_.A00

				var_431_5.transform.localPosition = var_431_4
				var_431_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_431_6 = var_431_5:GetComponent("SpriteRenderer")

				if var_431_6 and var_431_6.sprite then
					local var_431_7 = (var_431_5.transform.localPosition - var_431_3).z
					local var_431_8 = manager.ui.mainCameraCom_
					local var_431_9 = 2 * var_431_7 * Mathf.Tan(var_431_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_431_10 = var_431_9 * var_431_8.aspect
					local var_431_11 = var_431_6.sprite.bounds.size.x
					local var_431_12 = var_431_6.sprite.bounds.size.y
					local var_431_13 = var_431_10 / var_431_11
					local var_431_14 = var_431_9 / var_431_12
					local var_431_15 = var_431_14 < var_431_13 and var_431_13 or var_431_14

					var_431_5.transform.localScale = Vector3.New(var_431_15, var_431_15, 0)
				end

				for iter_431_0, iter_431_1 in pairs(arg_428_1.bgs_) do
					if iter_431_0 ~= "A00" then
						iter_431_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_431_16 = arg_428_1.bgs_.ST12
			local var_431_17 = 0

			if var_431_17 < arg_428_1.time_ and arg_428_1.time_ <= var_431_17 + arg_431_0 then
				local var_431_18 = var_431_16:GetComponent("SpriteRenderer")

				if var_431_18 then
					arg_428_1.var_.alphaOldValueST12 = var_431_18.color.a
					arg_428_1.var_.alphaMatValueST12 = var_431_18
				end

				arg_428_1.var_.alphaOldValueST12 = 1
			end

			local var_431_19 = 1.5

			if var_431_17 <= arg_428_1.time_ and arg_428_1.time_ < var_431_17 + var_431_19 then
				local var_431_20 = (arg_428_1.time_ - var_431_17) / var_431_19
				local var_431_21 = Mathf.Lerp(arg_428_1.var_.alphaOldValueST12, 0, var_431_20)

				if arg_428_1.var_.alphaMatValueST12 then
					local var_431_22 = arg_428_1.var_.alphaMatValueST12.color

					var_431_22.a = var_431_21
					arg_428_1.var_.alphaMatValueST12.color = var_431_22
				end
			end

			if arg_428_1.time_ >= var_431_17 + var_431_19 and arg_428_1.time_ < var_431_17 + var_431_19 + arg_431_0 and arg_428_1.var_.alphaMatValueST12 then
				local var_431_23 = arg_428_1.var_.alphaMatValueST12
				local var_431_24 = var_431_23.color

				var_431_24.a = 0
				var_431_23.color = var_431_24
			end

			local var_431_25 = arg_428_1.bgs_.A00
			local var_431_26 = 1.5

			if var_431_26 < arg_428_1.time_ and arg_428_1.time_ <= var_431_26 + arg_431_0 then
				local var_431_27 = var_431_25:GetComponent("SpriteRenderer")

				if var_431_27 then
					arg_428_1.var_.alphaOldValueA00 = var_431_27.color.a
					arg_428_1.var_.alphaMatValueA00 = var_431_27
				end

				arg_428_1.var_.alphaOldValueA00 = 0
			end

			local var_431_28 = 1.5

			if var_431_26 <= arg_428_1.time_ and arg_428_1.time_ < var_431_26 + var_431_28 then
				local var_431_29 = (arg_428_1.time_ - var_431_26) / var_431_28
				local var_431_30 = Mathf.Lerp(arg_428_1.var_.alphaOldValueA00, 1, var_431_29)

				if arg_428_1.var_.alphaMatValueA00 then
					local var_431_31 = arg_428_1.var_.alphaMatValueA00.color

					var_431_31.a = var_431_30
					arg_428_1.var_.alphaMatValueA00.color = var_431_31
				end
			end

			if arg_428_1.time_ >= var_431_26 + var_431_28 and arg_428_1.time_ < var_431_26 + var_431_28 + arg_431_0 and arg_428_1.var_.alphaMatValueA00 then
				local var_431_32 = arg_428_1.var_.alphaMatValueA00
				local var_431_33 = var_431_32.color

				var_431_33.a = 1
				var_431_32.color = var_431_33
			end

			if arg_428_1.frameCnt_ <= 1 then
				arg_428_1.dialog_:SetActive(false)
			end

			local var_431_34 = 3
			local var_431_35 = 1.075

			if var_431_34 < arg_428_1.time_ and arg_428_1.time_ <= var_431_34 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0

				arg_428_1.dialog_:SetActive(true)

				arg_428_1.dialogCg_.alpha = 0

				local var_431_36 = LeanTween.value(arg_428_1.dialog_, 0, 1, 0.3)

				var_431_36:setOnUpdate(LuaHelper.FloatAction(function(arg_432_0)
					arg_428_1.dialogCg_.alpha = arg_432_0
				end))
				var_431_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_428_1.dialog_)
					var_431_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_428_1.duration_ = arg_428_1.duration_ + 0.3

				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_37 = arg_428_1:FormatText(StoryNameCfg[10].name)

				arg_428_1.leftNameTxt_.text = var_431_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_38 = arg_428_1:GetWordFromCfg(103704107)
				local var_431_39 = arg_428_1:FormatText(var_431_38.content)

				arg_428_1.text_.text = var_431_39

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_40 = 43
				local var_431_41 = utf8.len(var_431_39)
				local var_431_42 = var_431_40 <= 0 and var_431_35 or var_431_35 * (var_431_41 / var_431_40)

				if var_431_42 > 0 and var_431_35 < var_431_42 then
					arg_428_1.talkMaxDuration = var_431_42
					var_431_34 = var_431_34 + 0.3

					if var_431_42 + var_431_34 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_42 + var_431_34
					end
				end

				arg_428_1.text_.text = var_431_39
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704107", "story_v_side_old_103704.awb") ~= 0 then
					local var_431_43 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704107", "story_v_side_old_103704.awb") / 1000

					if var_431_43 + var_431_34 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_43 + var_431_34
					end

					if var_431_38.prefab_name ~= "" and arg_428_1.actors_[var_431_38.prefab_name] ~= nil then
						local var_431_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_38.prefab_name].transform, "story_v_side_old_103704", "103704107", "story_v_side_old_103704.awb")

						arg_428_1:RecordAudio("103704107", var_431_44)
						arg_428_1:RecordAudio("103704107", var_431_44)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704107", "story_v_side_old_103704.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704107", "story_v_side_old_103704.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_45 = var_431_34 + 0.3
			local var_431_46 = math.max(var_431_35, arg_428_1.talkMaxDuration)

			if var_431_45 <= arg_428_1.time_ and arg_428_1.time_ < var_431_45 + var_431_46 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_45) / var_431_46

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_45 + var_431_46 and arg_428_1.time_ < var_431_45 + var_431_46 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play103704108 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 103704108
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play103704109(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0
			local var_437_1 = 0.733333333333333

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_2 = arg_434_1:FormatText(StoryNameCfg[7].name)

				arg_434_1.leftNameTxt_.text = var_437_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_3 = arg_434_1:GetWordFromCfg(103704108)
				local var_437_4 = arg_434_1:FormatText(var_437_3.content)

				arg_434_1.text_.text = var_437_4

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 15
				local var_437_6 = utf8.len(var_437_4)
				local var_437_7 = var_437_5 <= 0 and var_437_1 or var_437_1 * (var_437_6 / var_437_5)

				if var_437_7 > 0 and var_437_1 < var_437_7 then
					arg_434_1.talkMaxDuration = var_437_7

					if var_437_7 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_7 + var_437_0
					end
				end

				arg_434_1.text_.text = var_437_4
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_8 = math.max(var_437_1, arg_434_1.talkMaxDuration)

			if var_437_0 <= arg_434_1.time_ and arg_434_1.time_ < var_437_0 + var_437_8 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_0) / var_437_8

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_0 + var_437_8 and arg_434_1.time_ < var_437_0 + var_437_8 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play103704109 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 103704109
		arg_438_1.duration_ = 6.57

		local var_438_0 = {
			ja = 6.466,
			ko = 6.133,
			en = 6.566
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play103704110(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0
			local var_441_1 = 0.525

			if var_441_0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_2 = arg_438_1:FormatText(StoryNameCfg[10].name)

				arg_438_1.leftNameTxt_.text = var_441_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_3 = arg_438_1:GetWordFromCfg(103704109)
				local var_441_4 = arg_438_1:FormatText(var_441_3.content)

				arg_438_1.text_.text = var_441_4

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_5 = 21
				local var_441_6 = utf8.len(var_441_4)
				local var_441_7 = var_441_5 <= 0 and var_441_1 or var_441_1 * (var_441_6 / var_441_5)

				if var_441_7 > 0 and var_441_1 < var_441_7 then
					arg_438_1.talkMaxDuration = var_441_7

					if var_441_7 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_7 + var_441_0
					end
				end

				arg_438_1.text_.text = var_441_4
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704109", "story_v_side_old_103704.awb") ~= 0 then
					local var_441_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704109", "story_v_side_old_103704.awb") / 1000

					if var_441_8 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_8 + var_441_0
					end

					if var_441_3.prefab_name ~= "" and arg_438_1.actors_[var_441_3.prefab_name] ~= nil then
						local var_441_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_3.prefab_name].transform, "story_v_side_old_103704", "103704109", "story_v_side_old_103704.awb")

						arg_438_1:RecordAudio("103704109", var_441_9)
						arg_438_1:RecordAudio("103704109", var_441_9)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704109", "story_v_side_old_103704.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704109", "story_v_side_old_103704.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_10 = math.max(var_441_1, arg_438_1.talkMaxDuration)

			if var_441_0 <= arg_438_1.time_ and arg_438_1.time_ < var_441_0 + var_441_10 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_0) / var_441_10

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_0 + var_441_10 and arg_438_1.time_ < var_441_0 + var_441_10 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play103704110 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 103704110
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play103704111(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0
			local var_445_1 = 0.85

			if var_445_0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, false)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_2 = arg_442_1:GetWordFromCfg(103704110)
				local var_445_3 = arg_442_1:FormatText(var_445_2.content)

				arg_442_1.text_.text = var_445_3

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_4 = 34
				local var_445_5 = utf8.len(var_445_3)
				local var_445_6 = var_445_4 <= 0 and var_445_1 or var_445_1 * (var_445_5 / var_445_4)

				if var_445_6 > 0 and var_445_1 < var_445_6 then
					arg_442_1.talkMaxDuration = var_445_6

					if var_445_6 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_6 + var_445_0
					end
				end

				arg_442_1.text_.text = var_445_3
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_7 = math.max(var_445_1, arg_442_1.talkMaxDuration)

			if var_445_0 <= arg_442_1.time_ and arg_442_1.time_ < var_445_0 + var_445_7 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_0) / var_445_7

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_0 + var_445_7 and arg_442_1.time_ < var_445_0 + var_445_7 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play103704111 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 103704111
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play103704112(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0
			local var_449_1 = 0.55

			if var_449_0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_2 = arg_446_1:GetWordFromCfg(103704111)
				local var_449_3 = arg_446_1:FormatText(var_449_2.content)

				arg_446_1.text_.text = var_449_3

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_4 = 22
				local var_449_5 = utf8.len(var_449_3)
				local var_449_6 = var_449_4 <= 0 and var_449_1 or var_449_1 * (var_449_5 / var_449_4)

				if var_449_6 > 0 and var_449_1 < var_449_6 then
					arg_446_1.talkMaxDuration = var_449_6

					if var_449_6 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_6 + var_449_0
					end
				end

				arg_446_1.text_.text = var_449_3
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_7 = math.max(var_449_1, arg_446_1.talkMaxDuration)

			if var_449_0 <= arg_446_1.time_ and arg_446_1.time_ < var_449_0 + var_449_7 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_0) / var_449_7

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_0 + var_449_7 and arg_446_1.time_ < var_449_0 + var_449_7 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play103704112 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 103704112
		arg_450_1.duration_ = 5.87

		local var_450_0 = {
			ja = 5.866,
			ko = 3.833,
			en = 3.8
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play103704113(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["1037ui_story"].transform
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 then
				arg_450_1.var_.moveOldPos1037ui_story = var_453_0.localPosition
			end

			local var_453_2 = 0.001

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_2 then
				local var_453_3 = (arg_450_1.time_ - var_453_1) / var_453_2
				local var_453_4 = Vector3.New(0, -1.09, -5.81)

				var_453_0.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1037ui_story, var_453_4, var_453_3)

				local var_453_5 = manager.ui.mainCamera.transform.position - var_453_0.position

				var_453_0.forward = Vector3.New(var_453_5.x, var_453_5.y, var_453_5.z)

				local var_453_6 = var_453_0.localEulerAngles

				var_453_6.z = 0
				var_453_6.x = 0
				var_453_0.localEulerAngles = var_453_6
			end

			if arg_450_1.time_ >= var_453_1 + var_453_2 and arg_450_1.time_ < var_453_1 + var_453_2 + arg_453_0 then
				var_453_0.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_453_7 = manager.ui.mainCamera.transform.position - var_453_0.position

				var_453_0.forward = Vector3.New(var_453_7.x, var_453_7.y, var_453_7.z)

				local var_453_8 = var_453_0.localEulerAngles

				var_453_8.z = 0
				var_453_8.x = 0
				var_453_0.localEulerAngles = var_453_8
			end

			local var_453_9 = arg_450_1.actors_["1037ui_story"]
			local var_453_10 = 0

			if var_453_10 < arg_450_1.time_ and arg_450_1.time_ <= var_453_10 + arg_453_0 and not isNil(var_453_9) and arg_450_1.var_.characterEffect1037ui_story == nil then
				arg_450_1.var_.characterEffect1037ui_story = var_453_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_11 = 0.2

			if var_453_10 <= arg_450_1.time_ and arg_450_1.time_ < var_453_10 + var_453_11 and not isNil(var_453_9) then
				local var_453_12 = (arg_450_1.time_ - var_453_10) / var_453_11

				if arg_450_1.var_.characterEffect1037ui_story and not isNil(var_453_9) then
					arg_450_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_450_1.time_ >= var_453_10 + var_453_11 and arg_450_1.time_ < var_453_10 + var_453_11 + arg_453_0 and not isNil(var_453_9) and arg_450_1.var_.characterEffect1037ui_story then
				arg_450_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_453_13 = 0

			if var_453_13 < arg_450_1.time_ and arg_450_1.time_ <= var_453_13 + arg_453_0 then
				arg_450_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_453_14 = 0

			if var_453_14 < arg_450_1.time_ and arg_450_1.time_ <= var_453_14 + arg_453_0 then
				arg_450_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_453_15 = 0
			local var_453_16 = 0.425

			if var_453_15 < arg_450_1.time_ and arg_450_1.time_ <= var_453_15 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_17 = arg_450_1:FormatText(StoryNameCfg[15].name)

				arg_450_1.leftNameTxt_.text = var_453_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_18 = arg_450_1:GetWordFromCfg(103704112)
				local var_453_19 = arg_450_1:FormatText(var_453_18.content)

				arg_450_1.text_.text = var_453_19

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_20 = 17
				local var_453_21 = utf8.len(var_453_19)
				local var_453_22 = var_453_20 <= 0 and var_453_16 or var_453_16 * (var_453_21 / var_453_20)

				if var_453_22 > 0 and var_453_16 < var_453_22 then
					arg_450_1.talkMaxDuration = var_453_22

					if var_453_22 + var_453_15 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_22 + var_453_15
					end
				end

				arg_450_1.text_.text = var_453_19
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704112", "story_v_side_old_103704.awb") ~= 0 then
					local var_453_23 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704112", "story_v_side_old_103704.awb") / 1000

					if var_453_23 + var_453_15 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_23 + var_453_15
					end

					if var_453_18.prefab_name ~= "" and arg_450_1.actors_[var_453_18.prefab_name] ~= nil then
						local var_453_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_18.prefab_name].transform, "story_v_side_old_103704", "103704112", "story_v_side_old_103704.awb")

						arg_450_1:RecordAudio("103704112", var_453_24)
						arg_450_1:RecordAudio("103704112", var_453_24)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704112", "story_v_side_old_103704.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704112", "story_v_side_old_103704.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_25 = math.max(var_453_16, arg_450_1.talkMaxDuration)

			if var_453_15 <= arg_450_1.time_ and arg_450_1.time_ < var_453_15 + var_453_25 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_15) / var_453_25

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_15 + var_453_25 and arg_450_1.time_ < var_453_15 + var_453_25 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_450_1:InitPlayNodeList()
	end,
	Play103704113 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 103704113
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play103704114(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["1037ui_story"]
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1037ui_story == nil then
				arg_454_1.var_.characterEffect1037ui_story = var_457_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_2 = 0.2

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_2 and not isNil(var_457_0) then
				local var_457_3 = (arg_454_1.time_ - var_457_1) / var_457_2

				if arg_454_1.var_.characterEffect1037ui_story and not isNil(var_457_0) then
					local var_457_4 = Mathf.Lerp(0, 0.5, var_457_3)

					arg_454_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_454_1.var_.characterEffect1037ui_story.fillRatio = var_457_4
				end
			end

			if arg_454_1.time_ >= var_457_1 + var_457_2 and arg_454_1.time_ < var_457_1 + var_457_2 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1037ui_story then
				local var_457_5 = 0.5

				arg_454_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_454_1.var_.characterEffect1037ui_story.fillRatio = var_457_5
			end

			local var_457_6 = 0
			local var_457_7 = 0.325

			if var_457_6 < arg_454_1.time_ and arg_454_1.time_ <= var_457_6 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_8 = arg_454_1:FormatText(StoryNameCfg[7].name)

				arg_454_1.leftNameTxt_.text = var_457_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_9 = arg_454_1:GetWordFromCfg(103704113)
				local var_457_10 = arg_454_1:FormatText(var_457_9.content)

				arg_454_1.text_.text = var_457_10

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_11 = 13
				local var_457_12 = utf8.len(var_457_10)
				local var_457_13 = var_457_11 <= 0 and var_457_7 or var_457_7 * (var_457_12 / var_457_11)

				if var_457_13 > 0 and var_457_7 < var_457_13 then
					arg_454_1.talkMaxDuration = var_457_13

					if var_457_13 + var_457_6 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_13 + var_457_6
					end
				end

				arg_454_1.text_.text = var_457_10
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_14 = math.max(var_457_7, arg_454_1.talkMaxDuration)

			if var_457_6 <= arg_454_1.time_ and arg_454_1.time_ < var_457_6 + var_457_14 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_6) / var_457_14

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_6 + var_457_14 and arg_454_1.time_ < var_457_6 + var_457_14 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play103704114 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 103704114
		arg_458_1.duration_ = 11.97

		local var_458_0 = {
			ja = 7.833,
			ko = 8.9,
			en = 11.966
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play103704115(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["1037ui_story"]
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1037ui_story == nil then
				arg_458_1.var_.characterEffect1037ui_story = var_461_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_2 = 0.2

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 and not isNil(var_461_0) then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2

				if arg_458_1.var_.characterEffect1037ui_story and not isNil(var_461_0) then
					arg_458_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1037ui_story then
				arg_458_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_461_4 = 0

			if var_461_4 < arg_458_1.time_ and arg_458_1.time_ <= var_461_4 + arg_461_0 then
				arg_458_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_461_5 = 0

			if var_461_5 < arg_458_1.time_ and arg_458_1.time_ <= var_461_5 + arg_461_0 then
				arg_458_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_461_6 = 0
			local var_461_7 = 0.85

			if var_461_6 < arg_458_1.time_ and arg_458_1.time_ <= var_461_6 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_8 = arg_458_1:FormatText(StoryNameCfg[15].name)

				arg_458_1.leftNameTxt_.text = var_461_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_9 = arg_458_1:GetWordFromCfg(103704114)
				local var_461_10 = arg_458_1:FormatText(var_461_9.content)

				arg_458_1.text_.text = var_461_10

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_11 = 34
				local var_461_12 = utf8.len(var_461_10)
				local var_461_13 = var_461_11 <= 0 and var_461_7 or var_461_7 * (var_461_12 / var_461_11)

				if var_461_13 > 0 and var_461_7 < var_461_13 then
					arg_458_1.talkMaxDuration = var_461_13

					if var_461_13 + var_461_6 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_13 + var_461_6
					end
				end

				arg_458_1.text_.text = var_461_10
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704114", "story_v_side_old_103704.awb") ~= 0 then
					local var_461_14 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704114", "story_v_side_old_103704.awb") / 1000

					if var_461_14 + var_461_6 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_14 + var_461_6
					end

					if var_461_9.prefab_name ~= "" and arg_458_1.actors_[var_461_9.prefab_name] ~= nil then
						local var_461_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_9.prefab_name].transform, "story_v_side_old_103704", "103704114", "story_v_side_old_103704.awb")

						arg_458_1:RecordAudio("103704114", var_461_15)
						arg_458_1:RecordAudio("103704114", var_461_15)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704114", "story_v_side_old_103704.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704114", "story_v_side_old_103704.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_16 = math.max(var_461_7, arg_458_1.talkMaxDuration)

			if var_461_6 <= arg_458_1.time_ and arg_458_1.time_ < var_461_6 + var_461_16 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_6) / var_461_16

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_6 + var_461_16 and arg_458_1.time_ < var_461_6 + var_461_16 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play103704115 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 103704115
		arg_462_1.duration_ = 21.03

		local var_462_0 = {
			ja = 21.033,
			ko = 6.8,
			en = 9.466
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play103704116(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 0

			if var_465_0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_0 + arg_465_0 then
				arg_462_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_465_1 = 0
			local var_465_2 = 0.875

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_3 = arg_462_1:FormatText(StoryNameCfg[15].name)

				arg_462_1.leftNameTxt_.text = var_465_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_4 = arg_462_1:GetWordFromCfg(103704115)
				local var_465_5 = arg_462_1:FormatText(var_465_4.content)

				arg_462_1.text_.text = var_465_5

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_6 = 35
				local var_465_7 = utf8.len(var_465_5)
				local var_465_8 = var_465_6 <= 0 and var_465_2 or var_465_2 * (var_465_7 / var_465_6)

				if var_465_8 > 0 and var_465_2 < var_465_8 then
					arg_462_1.talkMaxDuration = var_465_8

					if var_465_8 + var_465_1 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_8 + var_465_1
					end
				end

				arg_462_1.text_.text = var_465_5
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704115", "story_v_side_old_103704.awb") ~= 0 then
					local var_465_9 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704115", "story_v_side_old_103704.awb") / 1000

					if var_465_9 + var_465_1 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_9 + var_465_1
					end

					if var_465_4.prefab_name ~= "" and arg_462_1.actors_[var_465_4.prefab_name] ~= nil then
						local var_465_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_4.prefab_name].transform, "story_v_side_old_103704", "103704115", "story_v_side_old_103704.awb")

						arg_462_1:RecordAudio("103704115", var_465_10)
						arg_462_1:RecordAudio("103704115", var_465_10)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704115", "story_v_side_old_103704.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704115", "story_v_side_old_103704.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_11 = math.max(var_465_2, arg_462_1.talkMaxDuration)

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_11 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_1) / var_465_11

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_1 + var_465_11 and arg_462_1.time_ < var_465_1 + var_465_11 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play103704116 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 103704116
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play103704117(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["1037ui_story"]
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1037ui_story == nil then
				arg_466_1.var_.characterEffect1037ui_story = var_469_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.2

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 and not isNil(var_469_0) then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2

				if arg_466_1.var_.characterEffect1037ui_story and not isNil(var_469_0) then
					local var_469_4 = Mathf.Lerp(0, 0.5, var_469_3)

					arg_466_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_466_1.var_.characterEffect1037ui_story.fillRatio = var_469_4
				end
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1037ui_story then
				local var_469_5 = 0.5

				arg_466_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_466_1.var_.characterEffect1037ui_story.fillRatio = var_469_5
			end

			local var_469_6 = 0
			local var_469_7 = 0.25

			if var_469_6 < arg_466_1.time_ and arg_466_1.time_ <= var_469_6 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_8 = arg_466_1:FormatText(StoryNameCfg[7].name)

				arg_466_1.leftNameTxt_.text = var_469_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_9 = arg_466_1:GetWordFromCfg(103704116)
				local var_469_10 = arg_466_1:FormatText(var_469_9.content)

				arg_466_1.text_.text = var_469_10

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_11 = 10
				local var_469_12 = utf8.len(var_469_10)
				local var_469_13 = var_469_11 <= 0 and var_469_7 or var_469_7 * (var_469_12 / var_469_11)

				if var_469_13 > 0 and var_469_7 < var_469_13 then
					arg_466_1.talkMaxDuration = var_469_13

					if var_469_13 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_13 + var_469_6
					end
				end

				arg_466_1.text_.text = var_469_10
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_14 = math.max(var_469_7, arg_466_1.talkMaxDuration)

			if var_469_6 <= arg_466_1.time_ and arg_466_1.time_ < var_469_6 + var_469_14 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_6) / var_469_14

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_6 + var_469_14 and arg_466_1.time_ < var_469_6 + var_469_14 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play103704117 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 103704117
		arg_470_1.duration_ = 6.13

		local var_470_0 = {
			ja = 5.933,
			ko = 5.8,
			en = 6.133
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play103704118(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["1037ui_story"].transform
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1.var_.moveOldPos1037ui_story = var_473_0.localPosition
			end

			local var_473_2 = 0.001

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2
				local var_473_4 = Vector3.New(0, 100, 0)

				var_473_0.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1037ui_story, var_473_4, var_473_3)

				local var_473_5 = manager.ui.mainCamera.transform.position - var_473_0.position

				var_473_0.forward = Vector3.New(var_473_5.x, var_473_5.y, var_473_5.z)

				local var_473_6 = var_473_0.localEulerAngles

				var_473_6.z = 0
				var_473_6.x = 0
				var_473_0.localEulerAngles = var_473_6
			end

			if arg_470_1.time_ >= var_473_1 + var_473_2 and arg_470_1.time_ < var_473_1 + var_473_2 + arg_473_0 then
				var_473_0.localPosition = Vector3.New(0, 100, 0)

				local var_473_7 = manager.ui.mainCamera.transform.position - var_473_0.position

				var_473_0.forward = Vector3.New(var_473_7.x, var_473_7.y, var_473_7.z)

				local var_473_8 = var_473_0.localEulerAngles

				var_473_8.z = 0
				var_473_8.x = 0
				var_473_0.localEulerAngles = var_473_8
			end

			local var_473_9 = 0
			local var_473_10 = 0.6

			if var_473_9 < arg_470_1.time_ and arg_470_1.time_ <= var_473_9 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_11 = arg_470_1:FormatText(StoryNameCfg[10].name)

				arg_470_1.leftNameTxt_.text = var_473_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, true)
				arg_470_1.iconController_:SetSelectedState("hero")

				arg_470_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_470_1.callingController_:SetSelectedState("normal")

				arg_470_1.keyicon_.color = Color.New(1, 1, 1)
				arg_470_1.icon_.color = Color.New(1, 1, 1)

				local var_473_12 = arg_470_1:GetWordFromCfg(103704117)
				local var_473_13 = arg_470_1:FormatText(var_473_12.content)

				arg_470_1.text_.text = var_473_13

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_14 = 24
				local var_473_15 = utf8.len(var_473_13)
				local var_473_16 = var_473_14 <= 0 and var_473_10 or var_473_10 * (var_473_15 / var_473_14)

				if var_473_16 > 0 and var_473_10 < var_473_16 then
					arg_470_1.talkMaxDuration = var_473_16

					if var_473_16 + var_473_9 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_16 + var_473_9
					end
				end

				arg_470_1.text_.text = var_473_13
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704117", "story_v_side_old_103704.awb") ~= 0 then
					local var_473_17 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704117", "story_v_side_old_103704.awb") / 1000

					if var_473_17 + var_473_9 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_17 + var_473_9
					end

					if var_473_12.prefab_name ~= "" and arg_470_1.actors_[var_473_12.prefab_name] ~= nil then
						local var_473_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_12.prefab_name].transform, "story_v_side_old_103704", "103704117", "story_v_side_old_103704.awb")

						arg_470_1:RecordAudio("103704117", var_473_18)
						arg_470_1:RecordAudio("103704117", var_473_18)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704117", "story_v_side_old_103704.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704117", "story_v_side_old_103704.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_19 = math.max(var_473_10, arg_470_1.talkMaxDuration)

			if var_473_9 <= arg_470_1.time_ and arg_470_1.time_ < var_473_9 + var_473_19 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_9) / var_473_19

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_9 + var_473_19 and arg_470_1.time_ < var_473_9 + var_473_19 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play103704118 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 103704118
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play103704119(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0
			local var_477_1 = 0.55

			if var_477_0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_2 = arg_474_1:FormatText(StoryNameCfg[7].name)

				arg_474_1.leftNameTxt_.text = var_477_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, true)
				arg_474_1.iconController_:SetSelectedState("hero")

				arg_474_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_474_1.callingController_:SetSelectedState("normal")

				arg_474_1.keyicon_.color = Color.New(1, 1, 1)
				arg_474_1.icon_.color = Color.New(1, 1, 1)

				local var_477_3 = arg_474_1:GetWordFromCfg(103704118)
				local var_477_4 = arg_474_1:FormatText(var_477_3.content)

				arg_474_1.text_.text = var_477_4

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_5 = 22
				local var_477_6 = utf8.len(var_477_4)
				local var_477_7 = var_477_5 <= 0 and var_477_1 or var_477_1 * (var_477_6 / var_477_5)

				if var_477_7 > 0 and var_477_1 < var_477_7 then
					arg_474_1.talkMaxDuration = var_477_7

					if var_477_7 + var_477_0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_7 + var_477_0
					end
				end

				arg_474_1.text_.text = var_477_4
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_8 = math.max(var_477_1, arg_474_1.talkMaxDuration)

			if var_477_0 <= arg_474_1.time_ and arg_474_1.time_ < var_477_0 + var_477_8 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_0) / var_477_8

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_0 + var_477_8 and arg_474_1.time_ < var_477_0 + var_477_8 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play103704119 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 103704119
		arg_478_1.duration_ = 9.43

		local var_478_0 = {
			ja = 9.433,
			ko = 3.666,
			en = 3.166
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play103704120(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0
			local var_481_1 = 0.425

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_2 = arg_478_1:FormatText(StoryNameCfg[10].name)

				arg_478_1.leftNameTxt_.text = var_481_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, true)
				arg_478_1.iconController_:SetSelectedState("hero")

				arg_478_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_478_1.callingController_:SetSelectedState("normal")

				arg_478_1.keyicon_.color = Color.New(1, 1, 1)
				arg_478_1.icon_.color = Color.New(1, 1, 1)

				local var_481_3 = arg_478_1:GetWordFromCfg(103704119)
				local var_481_4 = arg_478_1:FormatText(var_481_3.content)

				arg_478_1.text_.text = var_481_4

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_5 = 17
				local var_481_6 = utf8.len(var_481_4)
				local var_481_7 = var_481_5 <= 0 and var_481_1 or var_481_1 * (var_481_6 / var_481_5)

				if var_481_7 > 0 and var_481_1 < var_481_7 then
					arg_478_1.talkMaxDuration = var_481_7

					if var_481_7 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_7 + var_481_0
					end
				end

				arg_478_1.text_.text = var_481_4
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704119", "story_v_side_old_103704.awb") ~= 0 then
					local var_481_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704119", "story_v_side_old_103704.awb") / 1000

					if var_481_8 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_8 + var_481_0
					end

					if var_481_3.prefab_name ~= "" and arg_478_1.actors_[var_481_3.prefab_name] ~= nil then
						local var_481_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_3.prefab_name].transform, "story_v_side_old_103704", "103704119", "story_v_side_old_103704.awb")

						arg_478_1:RecordAudio("103704119", var_481_9)
						arg_478_1:RecordAudio("103704119", var_481_9)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704119", "story_v_side_old_103704.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704119", "story_v_side_old_103704.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_10 = math.max(var_481_1, arg_478_1.talkMaxDuration)

			if var_481_0 <= arg_478_1.time_ and arg_478_1.time_ < var_481_0 + var_481_10 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_0) / var_481_10

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_0 + var_481_10 and arg_478_1.time_ < var_481_0 + var_481_10 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play103704120 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 103704120
		arg_482_1.duration_ = 8

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play103704121(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = "ST16"

			if arg_482_1.bgs_[var_485_0] == nil then
				local var_485_1 = Object.Instantiate(arg_482_1.paintGo_)

				var_485_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_485_0)
				var_485_1.name = var_485_0
				var_485_1.transform.parent = arg_482_1.stage_.transform
				var_485_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_482_1.bgs_[var_485_0] = var_485_1
			end

			local var_485_2 = 0

			if var_485_2 < arg_482_1.time_ and arg_482_1.time_ <= var_485_2 + arg_485_0 then
				local var_485_3 = manager.ui.mainCamera.transform.localPosition
				local var_485_4 = Vector3.New(0, 0, 10) + Vector3.New(var_485_3.x, var_485_3.y, 0)
				local var_485_5 = arg_482_1.bgs_.ST16

				var_485_5.transform.localPosition = var_485_4
				var_485_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_485_6 = var_485_5:GetComponent("SpriteRenderer")

				if var_485_6 and var_485_6.sprite then
					local var_485_7 = (var_485_5.transform.localPosition - var_485_3).z
					local var_485_8 = manager.ui.mainCameraCom_
					local var_485_9 = 2 * var_485_7 * Mathf.Tan(var_485_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_485_10 = var_485_9 * var_485_8.aspect
					local var_485_11 = var_485_6.sprite.bounds.size.x
					local var_485_12 = var_485_6.sprite.bounds.size.y
					local var_485_13 = var_485_10 / var_485_11
					local var_485_14 = var_485_9 / var_485_12
					local var_485_15 = var_485_14 < var_485_13 and var_485_13 or var_485_14

					var_485_5.transform.localScale = Vector3.New(var_485_15, var_485_15, 0)
				end

				for iter_485_0, iter_485_1 in pairs(arg_482_1.bgs_) do
					if iter_485_0 ~= "ST16" then
						iter_485_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_485_16 = arg_482_1.bgs_.A00
			local var_485_17 = 0

			if var_485_17 < arg_482_1.time_ and arg_482_1.time_ <= var_485_17 + arg_485_0 then
				local var_485_18 = var_485_16:GetComponent("SpriteRenderer")

				if var_485_18 then
					arg_482_1.var_.alphaOldValueA00 = var_485_18.color.a
					arg_482_1.var_.alphaMatValueA00 = var_485_18
				end

				arg_482_1.var_.alphaOldValueA00 = 1
			end

			local var_485_19 = 1.5

			if var_485_17 <= arg_482_1.time_ and arg_482_1.time_ < var_485_17 + var_485_19 then
				local var_485_20 = (arg_482_1.time_ - var_485_17) / var_485_19
				local var_485_21 = Mathf.Lerp(arg_482_1.var_.alphaOldValueA00, 0, var_485_20)

				if arg_482_1.var_.alphaMatValueA00 then
					local var_485_22 = arg_482_1.var_.alphaMatValueA00.color

					var_485_22.a = var_485_21
					arg_482_1.var_.alphaMatValueA00.color = var_485_22
				end
			end

			if arg_482_1.time_ >= var_485_17 + var_485_19 and arg_482_1.time_ < var_485_17 + var_485_19 + arg_485_0 and arg_482_1.var_.alphaMatValueA00 then
				local var_485_23 = arg_482_1.var_.alphaMatValueA00
				local var_485_24 = var_485_23.color

				var_485_24.a = 0
				var_485_23.color = var_485_24
			end

			local var_485_25 = arg_482_1.bgs_.ST16
			local var_485_26 = 1.5

			if var_485_26 < arg_482_1.time_ and arg_482_1.time_ <= var_485_26 + arg_485_0 then
				local var_485_27 = var_485_25:GetComponent("SpriteRenderer")

				if var_485_27 then
					arg_482_1.var_.alphaOldValueST16 = var_485_27.color.a
					arg_482_1.var_.alphaMatValueST16 = var_485_27
				end

				arg_482_1.var_.alphaOldValueST16 = 0
			end

			local var_485_28 = 1.5

			if var_485_26 <= arg_482_1.time_ and arg_482_1.time_ < var_485_26 + var_485_28 then
				local var_485_29 = (arg_482_1.time_ - var_485_26) / var_485_28
				local var_485_30 = Mathf.Lerp(arg_482_1.var_.alphaOldValueST16, 1, var_485_29)

				if arg_482_1.var_.alphaMatValueST16 then
					local var_485_31 = arg_482_1.var_.alphaMatValueST16.color

					var_485_31.a = var_485_30
					arg_482_1.var_.alphaMatValueST16.color = var_485_31
				end
			end

			if arg_482_1.time_ >= var_485_26 + var_485_28 and arg_482_1.time_ < var_485_26 + var_485_28 + arg_485_0 and arg_482_1.var_.alphaMatValueST16 then
				local var_485_32 = arg_482_1.var_.alphaMatValueST16
				local var_485_33 = var_485_32.color

				var_485_33.a = 1
				var_485_32.color = var_485_33
			end

			if arg_482_1.frameCnt_ <= 1 then
				arg_482_1.dialog_:SetActive(false)
			end

			local var_485_34 = 3
			local var_485_35 = 1

			if var_485_34 < arg_482_1.time_ and arg_482_1.time_ <= var_485_34 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0

				arg_482_1.dialog_:SetActive(true)

				arg_482_1.dialogCg_.alpha = 0

				local var_485_36 = LeanTween.value(arg_482_1.dialog_, 0, 1, 0.3)

				var_485_36:setOnUpdate(LuaHelper.FloatAction(function(arg_486_0)
					arg_482_1.dialogCg_.alpha = arg_486_0
				end))
				var_485_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_482_1.dialog_)
					var_485_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_482_1.duration_ = arg_482_1.duration_ + 0.3

				SetActive(arg_482_1.leftNameGo_, false)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_37 = arg_482_1:GetWordFromCfg(103704120)
				local var_485_38 = arg_482_1:FormatText(var_485_37.content)

				arg_482_1.text_.text = var_485_38

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_39 = 41
				local var_485_40 = utf8.len(var_485_38)
				local var_485_41 = var_485_39 <= 0 and var_485_35 or var_485_35 * (var_485_40 / var_485_39)

				if var_485_41 > 0 and var_485_35 < var_485_41 then
					arg_482_1.talkMaxDuration = var_485_41
					var_485_34 = var_485_34 + 0.3

					if var_485_41 + var_485_34 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_41 + var_485_34
					end
				end

				arg_482_1.text_.text = var_485_38
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_42 = var_485_34 + 0.3
			local var_485_43 = math.max(var_485_35, arg_482_1.talkMaxDuration)

			if var_485_42 <= arg_482_1.time_ and arg_482_1.time_ < var_485_42 + var_485_43 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_42) / var_485_43

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_42 + var_485_43 and arg_482_1.time_ < var_485_42 + var_485_43 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play103704121 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 103704121
		arg_488_1.duration_ = 8.63

		local var_488_0 = {
			ja = 8.633,
			ko = 5.933,
			en = 5.9
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play103704122(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["1037ui_story"].transform
			local var_491_1 = 0

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 then
				arg_488_1.var_.moveOldPos1037ui_story = var_491_0.localPosition
			end

			local var_491_2 = 0.001

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2
				local var_491_4 = Vector3.New(0, -1.09, -5.81)

				var_491_0.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos1037ui_story, var_491_4, var_491_3)

				local var_491_5 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_5.x, var_491_5.y, var_491_5.z)

				local var_491_6 = var_491_0.localEulerAngles

				var_491_6.z = 0
				var_491_6.x = 0
				var_491_0.localEulerAngles = var_491_6
			end

			if arg_488_1.time_ >= var_491_1 + var_491_2 and arg_488_1.time_ < var_491_1 + var_491_2 + arg_491_0 then
				var_491_0.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_491_7 = manager.ui.mainCamera.transform.position - var_491_0.position

				var_491_0.forward = Vector3.New(var_491_7.x, var_491_7.y, var_491_7.z)

				local var_491_8 = var_491_0.localEulerAngles

				var_491_8.z = 0
				var_491_8.x = 0
				var_491_0.localEulerAngles = var_491_8
			end

			local var_491_9 = arg_488_1.actors_["1037ui_story"]
			local var_491_10 = 0

			if var_491_10 < arg_488_1.time_ and arg_488_1.time_ <= var_491_10 + arg_491_0 and not isNil(var_491_9) and arg_488_1.var_.characterEffect1037ui_story == nil then
				arg_488_1.var_.characterEffect1037ui_story = var_491_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_11 = 0.2

			if var_491_10 <= arg_488_1.time_ and arg_488_1.time_ < var_491_10 + var_491_11 and not isNil(var_491_9) then
				local var_491_12 = (arg_488_1.time_ - var_491_10) / var_491_11

				if arg_488_1.var_.characterEffect1037ui_story and not isNil(var_491_9) then
					arg_488_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_488_1.time_ >= var_491_10 + var_491_11 and arg_488_1.time_ < var_491_10 + var_491_11 + arg_491_0 and not isNil(var_491_9) and arg_488_1.var_.characterEffect1037ui_story then
				arg_488_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_491_13 = 0

			if var_491_13 < arg_488_1.time_ and arg_488_1.time_ <= var_491_13 + arg_491_0 then
				arg_488_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_491_14 = 0

			if var_491_14 < arg_488_1.time_ and arg_488_1.time_ <= var_491_14 + arg_491_0 then
				arg_488_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_491_15 = 0
			local var_491_16 = 0.45

			if var_491_15 < arg_488_1.time_ and arg_488_1.time_ <= var_491_15 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_17 = arg_488_1:FormatText(StoryNameCfg[15].name)

				arg_488_1.leftNameTxt_.text = var_491_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_18 = arg_488_1:GetWordFromCfg(103704121)
				local var_491_19 = arg_488_1:FormatText(var_491_18.content)

				arg_488_1.text_.text = var_491_19

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_20 = 18
				local var_491_21 = utf8.len(var_491_19)
				local var_491_22 = var_491_20 <= 0 and var_491_16 or var_491_16 * (var_491_21 / var_491_20)

				if var_491_22 > 0 and var_491_16 < var_491_22 then
					arg_488_1.talkMaxDuration = var_491_22

					if var_491_22 + var_491_15 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_22 + var_491_15
					end
				end

				arg_488_1.text_.text = var_491_19
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704121", "story_v_side_old_103704.awb") ~= 0 then
					local var_491_23 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704121", "story_v_side_old_103704.awb") / 1000

					if var_491_23 + var_491_15 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_23 + var_491_15
					end

					if var_491_18.prefab_name ~= "" and arg_488_1.actors_[var_491_18.prefab_name] ~= nil then
						local var_491_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_18.prefab_name].transform, "story_v_side_old_103704", "103704121", "story_v_side_old_103704.awb")

						arg_488_1:RecordAudio("103704121", var_491_24)
						arg_488_1:RecordAudio("103704121", var_491_24)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704121", "story_v_side_old_103704.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704121", "story_v_side_old_103704.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_25 = math.max(var_491_16, arg_488_1.talkMaxDuration)

			if var_491_15 <= arg_488_1.time_ and arg_488_1.time_ < var_491_15 + var_491_25 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_15) / var_491_25

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_15 + var_491_25 and arg_488_1.time_ < var_491_15 + var_491_25 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play103704122 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 103704122
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play103704123(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = arg_492_1.actors_["1037ui_story"]
			local var_495_1 = 0

			if var_495_1 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 and not isNil(var_495_0) and arg_492_1.var_.characterEffect1037ui_story == nil then
				arg_492_1.var_.characterEffect1037ui_story = var_495_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_2 = 0.2

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_2 and not isNil(var_495_0) then
				local var_495_3 = (arg_492_1.time_ - var_495_1) / var_495_2

				if arg_492_1.var_.characterEffect1037ui_story and not isNil(var_495_0) then
					local var_495_4 = Mathf.Lerp(0, 0.5, var_495_3)

					arg_492_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_492_1.var_.characterEffect1037ui_story.fillRatio = var_495_4
				end
			end

			if arg_492_1.time_ >= var_495_1 + var_495_2 and arg_492_1.time_ < var_495_1 + var_495_2 + arg_495_0 and not isNil(var_495_0) and arg_492_1.var_.characterEffect1037ui_story then
				local var_495_5 = 0.5

				arg_492_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_492_1.var_.characterEffect1037ui_story.fillRatio = var_495_5
			end

			local var_495_6 = 0
			local var_495_7 = 0.625

			if var_495_6 < arg_492_1.time_ and arg_492_1.time_ <= var_495_6 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_8 = arg_492_1:FormatText(StoryNameCfg[7].name)

				arg_492_1.leftNameTxt_.text = var_495_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, true)
				arg_492_1.iconController_:SetSelectedState("hero")

				arg_492_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_492_1.callingController_:SetSelectedState("normal")

				arg_492_1.keyicon_.color = Color.New(1, 1, 1)
				arg_492_1.icon_.color = Color.New(1, 1, 1)

				local var_495_9 = arg_492_1:GetWordFromCfg(103704122)
				local var_495_10 = arg_492_1:FormatText(var_495_9.content)

				arg_492_1.text_.text = var_495_10

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_11 = 25
				local var_495_12 = utf8.len(var_495_10)
				local var_495_13 = var_495_11 <= 0 and var_495_7 or var_495_7 * (var_495_12 / var_495_11)

				if var_495_13 > 0 and var_495_7 < var_495_13 then
					arg_492_1.talkMaxDuration = var_495_13

					if var_495_13 + var_495_6 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_13 + var_495_6
					end
				end

				arg_492_1.text_.text = var_495_10
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_14 = math.max(var_495_7, arg_492_1.talkMaxDuration)

			if var_495_6 <= arg_492_1.time_ and arg_492_1.time_ < var_495_6 + var_495_14 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_6) / var_495_14

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_6 + var_495_14 and arg_492_1.time_ < var_495_6 + var_495_14 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play103704123 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 103704123
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play103704124(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0
			local var_499_1 = 0.6

			if var_499_0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_2 = arg_496_1:FormatText(StoryNameCfg[7].name)

				arg_496_1.leftNameTxt_.text = var_499_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_3 = arg_496_1:GetWordFromCfg(103704123)
				local var_499_4 = arg_496_1:FormatText(var_499_3.content)

				arg_496_1.text_.text = var_499_4

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_5 = 24
				local var_499_6 = utf8.len(var_499_4)
				local var_499_7 = var_499_5 <= 0 and var_499_1 or var_499_1 * (var_499_6 / var_499_5)

				if var_499_7 > 0 and var_499_1 < var_499_7 then
					arg_496_1.talkMaxDuration = var_499_7

					if var_499_7 + var_499_0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_7 + var_499_0
					end
				end

				arg_496_1.text_.text = var_499_4
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_8 = math.max(var_499_1, arg_496_1.talkMaxDuration)

			if var_499_0 <= arg_496_1.time_ and arg_496_1.time_ < var_499_0 + var_499_8 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_0) / var_499_8

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_0 + var_499_8 and arg_496_1.time_ < var_499_0 + var_499_8 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play103704124 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 103704124
		arg_500_1.duration_ = 11

		local var_500_0 = {
			ja = 11,
			ko = 7.966,
			en = 10.366
		}
		local var_500_1 = manager.audio:GetLocalizationFlag()

		if var_500_0[var_500_1] ~= nil then
			arg_500_1.duration_ = var_500_0[var_500_1]
		end

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play103704125(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = arg_500_1.actors_["1037ui_story"]
			local var_503_1 = 0

			if var_503_1 < arg_500_1.time_ and arg_500_1.time_ <= var_503_1 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.characterEffect1037ui_story == nil then
				arg_500_1.var_.characterEffect1037ui_story = var_503_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_2 = 0.2

			if var_503_1 <= arg_500_1.time_ and arg_500_1.time_ < var_503_1 + var_503_2 and not isNil(var_503_0) then
				local var_503_3 = (arg_500_1.time_ - var_503_1) / var_503_2

				if arg_500_1.var_.characterEffect1037ui_story and not isNil(var_503_0) then
					arg_500_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_500_1.time_ >= var_503_1 + var_503_2 and arg_500_1.time_ < var_503_1 + var_503_2 + arg_503_0 and not isNil(var_503_0) and arg_500_1.var_.characterEffect1037ui_story then
				arg_500_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_503_4 = 0

			if var_503_4 < arg_500_1.time_ and arg_500_1.time_ <= var_503_4 + arg_503_0 then
				arg_500_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_503_5 = 0

			if var_503_5 < arg_500_1.time_ and arg_500_1.time_ <= var_503_5 + arg_503_0 then
				arg_500_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_1")
			end

			local var_503_6 = 0
			local var_503_7 = 0.575

			if var_503_6 < arg_500_1.time_ and arg_500_1.time_ <= var_503_6 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_8 = arg_500_1:FormatText(StoryNameCfg[15].name)

				arg_500_1.leftNameTxt_.text = var_503_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_9 = arg_500_1:GetWordFromCfg(103704124)
				local var_503_10 = arg_500_1:FormatText(var_503_9.content)

				arg_500_1.text_.text = var_503_10

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_11 = 23
				local var_503_12 = utf8.len(var_503_10)
				local var_503_13 = var_503_11 <= 0 and var_503_7 or var_503_7 * (var_503_12 / var_503_11)

				if var_503_13 > 0 and var_503_7 < var_503_13 then
					arg_500_1.talkMaxDuration = var_503_13

					if var_503_13 + var_503_6 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_13 + var_503_6
					end
				end

				arg_500_1.text_.text = var_503_10
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704124", "story_v_side_old_103704.awb") ~= 0 then
					local var_503_14 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704124", "story_v_side_old_103704.awb") / 1000

					if var_503_14 + var_503_6 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_14 + var_503_6
					end

					if var_503_9.prefab_name ~= "" and arg_500_1.actors_[var_503_9.prefab_name] ~= nil then
						local var_503_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_9.prefab_name].transform, "story_v_side_old_103704", "103704124", "story_v_side_old_103704.awb")

						arg_500_1:RecordAudio("103704124", var_503_15)
						arg_500_1:RecordAudio("103704124", var_503_15)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704124", "story_v_side_old_103704.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704124", "story_v_side_old_103704.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_16 = math.max(var_503_7, arg_500_1.talkMaxDuration)

			if var_503_6 <= arg_500_1.time_ and arg_500_1.time_ < var_503_6 + var_503_16 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_6) / var_503_16

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_6 + var_503_16 and arg_500_1.time_ < var_503_6 + var_503_16 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play103704125 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 103704125
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play103704126(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = arg_504_1.actors_["1037ui_story"]
			local var_507_1 = 0

			if var_507_1 < arg_504_1.time_ and arg_504_1.time_ <= var_507_1 + arg_507_0 and not isNil(var_507_0) and arg_504_1.var_.characterEffect1037ui_story == nil then
				arg_504_1.var_.characterEffect1037ui_story = var_507_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_2 = 0.2

			if var_507_1 <= arg_504_1.time_ and arg_504_1.time_ < var_507_1 + var_507_2 and not isNil(var_507_0) then
				local var_507_3 = (arg_504_1.time_ - var_507_1) / var_507_2

				if arg_504_1.var_.characterEffect1037ui_story and not isNil(var_507_0) then
					local var_507_4 = Mathf.Lerp(0, 0.5, var_507_3)

					arg_504_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_504_1.var_.characterEffect1037ui_story.fillRatio = var_507_4
				end
			end

			if arg_504_1.time_ >= var_507_1 + var_507_2 and arg_504_1.time_ < var_507_1 + var_507_2 + arg_507_0 and not isNil(var_507_0) and arg_504_1.var_.characterEffect1037ui_story then
				local var_507_5 = 0.5

				arg_504_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_504_1.var_.characterEffect1037ui_story.fillRatio = var_507_5
			end

			local var_507_6 = 0
			local var_507_7 = 0.8

			if var_507_6 < arg_504_1.time_ and arg_504_1.time_ <= var_507_6 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_8 = arg_504_1:FormatText(StoryNameCfg[7].name)

				arg_504_1.leftNameTxt_.text = var_507_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, true)
				arg_504_1.iconController_:SetSelectedState("hero")

				arg_504_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_504_1.callingController_:SetSelectedState("normal")

				arg_504_1.keyicon_.color = Color.New(1, 1, 1)
				arg_504_1.icon_.color = Color.New(1, 1, 1)

				local var_507_9 = arg_504_1:GetWordFromCfg(103704125)
				local var_507_10 = arg_504_1:FormatText(var_507_9.content)

				arg_504_1.text_.text = var_507_10

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_11 = 32
				local var_507_12 = utf8.len(var_507_10)
				local var_507_13 = var_507_11 <= 0 and var_507_7 or var_507_7 * (var_507_12 / var_507_11)

				if var_507_13 > 0 and var_507_7 < var_507_13 then
					arg_504_1.talkMaxDuration = var_507_13

					if var_507_13 + var_507_6 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_13 + var_507_6
					end
				end

				arg_504_1.text_.text = var_507_10
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_14 = math.max(var_507_7, arg_504_1.talkMaxDuration)

			if var_507_6 <= arg_504_1.time_ and arg_504_1.time_ < var_507_6 + var_507_14 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_6) / var_507_14

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_6 + var_507_14 and arg_504_1.time_ < var_507_6 + var_507_14 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play103704126 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 103704126
		arg_508_1.duration_ = 5.7

		local var_508_0 = {
			ja = 5.666,
			ko = 5.7,
			en = 5.5
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play103704127(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = arg_508_1.actors_["1037ui_story"]
			local var_511_1 = 0

			if var_511_1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.characterEffect1037ui_story == nil then
				arg_508_1.var_.characterEffect1037ui_story = var_511_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_2 = 0.2

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_2 and not isNil(var_511_0) then
				local var_511_3 = (arg_508_1.time_ - var_511_1) / var_511_2

				if arg_508_1.var_.characterEffect1037ui_story and not isNil(var_511_0) then
					arg_508_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_508_1.time_ >= var_511_1 + var_511_2 and arg_508_1.time_ < var_511_1 + var_511_2 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.characterEffect1037ui_story then
				arg_508_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_511_4 = 0

			if var_511_4 < arg_508_1.time_ and arg_508_1.time_ <= var_511_4 + arg_511_0 then
				arg_508_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_511_5 = 0

			if var_511_5 < arg_508_1.time_ and arg_508_1.time_ <= var_511_5 + arg_511_0 then
				arg_508_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action452")
			end

			local var_511_6 = 0
			local var_511_7 = 0.625

			if var_511_6 < arg_508_1.time_ and arg_508_1.time_ <= var_511_6 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_8 = arg_508_1:FormatText(StoryNameCfg[15].name)

				arg_508_1.leftNameTxt_.text = var_511_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_9 = arg_508_1:GetWordFromCfg(103704126)
				local var_511_10 = arg_508_1:FormatText(var_511_9.content)

				arg_508_1.text_.text = var_511_10

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_11 = 25
				local var_511_12 = utf8.len(var_511_10)
				local var_511_13 = var_511_11 <= 0 and var_511_7 or var_511_7 * (var_511_12 / var_511_11)

				if var_511_13 > 0 and var_511_7 < var_511_13 then
					arg_508_1.talkMaxDuration = var_511_13

					if var_511_13 + var_511_6 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_13 + var_511_6
					end
				end

				arg_508_1.text_.text = var_511_10
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704126", "story_v_side_old_103704.awb") ~= 0 then
					local var_511_14 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704126", "story_v_side_old_103704.awb") / 1000

					if var_511_14 + var_511_6 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_14 + var_511_6
					end

					if var_511_9.prefab_name ~= "" and arg_508_1.actors_[var_511_9.prefab_name] ~= nil then
						local var_511_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_9.prefab_name].transform, "story_v_side_old_103704", "103704126", "story_v_side_old_103704.awb")

						arg_508_1:RecordAudio("103704126", var_511_15)
						arg_508_1:RecordAudio("103704126", var_511_15)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704126", "story_v_side_old_103704.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704126", "story_v_side_old_103704.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_16 = math.max(var_511_7, arg_508_1.talkMaxDuration)

			if var_511_6 <= arg_508_1.time_ and arg_508_1.time_ < var_511_6 + var_511_16 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_6) / var_511_16

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_6 + var_511_16 and arg_508_1.time_ < var_511_6 + var_511_16 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play103704127 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 103704127
		arg_512_1.duration_ = 11.5

		local var_512_0 = {
			ja = 7.9,
			ko = 7.9,
			en = 11.5
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play103704128(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = 0

			if var_515_0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_0 + arg_515_0 then
				arg_512_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_515_1 = 0
			local var_515_2 = 0.7

			if var_515_1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_3 = arg_512_1:FormatText(StoryNameCfg[15].name)

				arg_512_1.leftNameTxt_.text = var_515_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_4 = arg_512_1:GetWordFromCfg(103704127)
				local var_515_5 = arg_512_1:FormatText(var_515_4.content)

				arg_512_1.text_.text = var_515_5

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_6 = 28
				local var_515_7 = utf8.len(var_515_5)
				local var_515_8 = var_515_6 <= 0 and var_515_2 or var_515_2 * (var_515_7 / var_515_6)

				if var_515_8 > 0 and var_515_2 < var_515_8 then
					arg_512_1.talkMaxDuration = var_515_8

					if var_515_8 + var_515_1 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_8 + var_515_1
					end
				end

				arg_512_1.text_.text = var_515_5
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704127", "story_v_side_old_103704.awb") ~= 0 then
					local var_515_9 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704127", "story_v_side_old_103704.awb") / 1000

					if var_515_9 + var_515_1 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_9 + var_515_1
					end

					if var_515_4.prefab_name ~= "" and arg_512_1.actors_[var_515_4.prefab_name] ~= nil then
						local var_515_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_4.prefab_name].transform, "story_v_side_old_103704", "103704127", "story_v_side_old_103704.awb")

						arg_512_1:RecordAudio("103704127", var_515_10)
						arg_512_1:RecordAudio("103704127", var_515_10)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704127", "story_v_side_old_103704.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704127", "story_v_side_old_103704.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_11 = math.max(var_515_2, arg_512_1.talkMaxDuration)

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_11 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_1) / var_515_11

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_1 + var_515_11 and arg_512_1.time_ < var_515_1 + var_515_11 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play103704128 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 103704128
		arg_516_1.duration_ = 8

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play103704129(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = "R3701"

			if arg_516_1.bgs_[var_519_0] == nil then
				local var_519_1 = Object.Instantiate(arg_516_1.paintGo_)

				var_519_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_519_0)
				var_519_1.name = var_519_0
				var_519_1.transform.parent = arg_516_1.stage_.transform
				var_519_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_516_1.bgs_[var_519_0] = var_519_1
			end

			local var_519_2 = 1.5

			if var_519_2 < arg_516_1.time_ and arg_516_1.time_ <= var_519_2 + arg_519_0 then
				local var_519_3 = manager.ui.mainCamera.transform.localPosition
				local var_519_4 = Vector3.New(0, 0, 10) + Vector3.New(var_519_3.x, var_519_3.y, 0)
				local var_519_5 = arg_516_1.bgs_.R3701

				var_519_5.transform.localPosition = var_519_4
				var_519_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_519_6 = var_519_5:GetComponent("SpriteRenderer")

				if var_519_6 and var_519_6.sprite then
					local var_519_7 = (var_519_5.transform.localPosition - var_519_3).z
					local var_519_8 = manager.ui.mainCameraCom_
					local var_519_9 = 2 * var_519_7 * Mathf.Tan(var_519_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_519_10 = var_519_9 * var_519_8.aspect
					local var_519_11 = var_519_6.sprite.bounds.size.x
					local var_519_12 = var_519_6.sprite.bounds.size.y
					local var_519_13 = var_519_10 / var_519_11
					local var_519_14 = var_519_9 / var_519_12
					local var_519_15 = var_519_14 < var_519_13 and var_519_13 or var_519_14

					var_519_5.transform.localScale = Vector3.New(var_519_15, var_519_15, 0)
				end

				for iter_519_0, iter_519_1 in pairs(arg_516_1.bgs_) do
					if iter_519_0 ~= "R3701" then
						iter_519_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_519_16 = arg_516_1.bgs_.ST16
			local var_519_17 = 0

			if var_519_17 < arg_516_1.time_ and arg_516_1.time_ <= var_519_17 + arg_519_0 then
				local var_519_18 = var_519_16:GetComponent("SpriteRenderer")

				if var_519_18 then
					arg_516_1.var_.alphaOldValueST16 = var_519_18.color.a
					arg_516_1.var_.alphaMatValueST16 = var_519_18
				end

				arg_516_1.var_.alphaOldValueST16 = 1
			end

			local var_519_19 = 1.5

			if var_519_17 <= arg_516_1.time_ and arg_516_1.time_ < var_519_17 + var_519_19 then
				local var_519_20 = (arg_516_1.time_ - var_519_17) / var_519_19
				local var_519_21 = Mathf.Lerp(arg_516_1.var_.alphaOldValueST16, 0, var_519_20)

				if arg_516_1.var_.alphaMatValueST16 then
					local var_519_22 = arg_516_1.var_.alphaMatValueST16.color

					var_519_22.a = var_519_21
					arg_516_1.var_.alphaMatValueST16.color = var_519_22
				end
			end

			if arg_516_1.time_ >= var_519_17 + var_519_19 and arg_516_1.time_ < var_519_17 + var_519_19 + arg_519_0 and arg_516_1.var_.alphaMatValueST16 then
				local var_519_23 = arg_516_1.var_.alphaMatValueST16
				local var_519_24 = var_519_23.color

				var_519_24.a = 0
				var_519_23.color = var_519_24
			end

			local var_519_25 = arg_516_1.bgs_.R3701
			local var_519_26 = 1.5

			if var_519_26 < arg_516_1.time_ and arg_516_1.time_ <= var_519_26 + arg_519_0 then
				local var_519_27 = var_519_25:GetComponent("SpriteRenderer")

				if var_519_27 then
					arg_516_1.var_.alphaOldValueR3701 = var_519_27.color.a
					arg_516_1.var_.alphaMatValueR3701 = var_519_27
				end

				arg_516_1.var_.alphaOldValueR3701 = 0
			end

			local var_519_28 = 1.5

			if var_519_26 <= arg_516_1.time_ and arg_516_1.time_ < var_519_26 + var_519_28 then
				local var_519_29 = (arg_516_1.time_ - var_519_26) / var_519_28
				local var_519_30 = Mathf.Lerp(arg_516_1.var_.alphaOldValueR3701, 1, var_519_29)

				if arg_516_1.var_.alphaMatValueR3701 then
					local var_519_31 = arg_516_1.var_.alphaMatValueR3701.color

					var_519_31.a = var_519_30
					arg_516_1.var_.alphaMatValueR3701.color = var_519_31
				end
			end

			if arg_516_1.time_ >= var_519_26 + var_519_28 and arg_516_1.time_ < var_519_26 + var_519_28 + arg_519_0 and arg_516_1.var_.alphaMatValueR3701 then
				local var_519_32 = arg_516_1.var_.alphaMatValueR3701
				local var_519_33 = var_519_32.color

				var_519_33.a = 1
				var_519_32.color = var_519_33
			end

			local var_519_34 = arg_516_1.actors_["1037ui_story"].transform
			local var_519_35 = 0

			if var_519_35 < arg_516_1.time_ and arg_516_1.time_ <= var_519_35 + arg_519_0 then
				arg_516_1.var_.moveOldPos1037ui_story = var_519_34.localPosition
			end

			local var_519_36 = 0.001

			if var_519_35 <= arg_516_1.time_ and arg_516_1.time_ < var_519_35 + var_519_36 then
				local var_519_37 = (arg_516_1.time_ - var_519_35) / var_519_36
				local var_519_38 = Vector3.New(0, 100, 0)

				var_519_34.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos1037ui_story, var_519_38, var_519_37)

				local var_519_39 = manager.ui.mainCamera.transform.position - var_519_34.position

				var_519_34.forward = Vector3.New(var_519_39.x, var_519_39.y, var_519_39.z)

				local var_519_40 = var_519_34.localEulerAngles

				var_519_40.z = 0
				var_519_40.x = 0
				var_519_34.localEulerAngles = var_519_40
			end

			if arg_516_1.time_ >= var_519_35 + var_519_36 and arg_516_1.time_ < var_519_35 + var_519_36 + arg_519_0 then
				var_519_34.localPosition = Vector3.New(0, 100, 0)

				local var_519_41 = manager.ui.mainCamera.transform.position - var_519_34.position

				var_519_34.forward = Vector3.New(var_519_41.x, var_519_41.y, var_519_41.z)

				local var_519_42 = var_519_34.localEulerAngles

				var_519_42.z = 0
				var_519_42.x = 0
				var_519_34.localEulerAngles = var_519_42
			end

			local var_519_43 = 3
			local var_519_44 = 0.05

			if var_519_43 < arg_516_1.time_ and arg_516_1.time_ <= var_519_43 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_45 = arg_516_1:FormatText(StoryNameCfg[7].name)

				arg_516_1.leftNameTxt_.text = var_519_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, true)
				arg_516_1.iconController_:SetSelectedState("hero")

				arg_516_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_516_1.callingController_:SetSelectedState("normal")

				arg_516_1.keyicon_.color = Color.New(1, 1, 1)
				arg_516_1.icon_.color = Color.New(1, 1, 1)

				local var_519_46 = arg_516_1:GetWordFromCfg(103704128)
				local var_519_47 = arg_516_1:FormatText(var_519_46.content)

				arg_516_1.text_.text = var_519_47

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_48 = 2
				local var_519_49 = utf8.len(var_519_47)
				local var_519_50 = var_519_48 <= 0 and var_519_44 or var_519_44 * (var_519_49 / var_519_48)

				if var_519_50 > 0 and var_519_44 < var_519_50 then
					arg_516_1.talkMaxDuration = var_519_50

					if var_519_50 + var_519_43 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_50 + var_519_43
					end
				end

				arg_516_1.text_.text = var_519_47
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_51 = math.max(var_519_44, arg_516_1.talkMaxDuration)

			if var_519_43 <= arg_516_1.time_ and arg_516_1.time_ < var_519_43 + var_519_51 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_43) / var_519_51

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_43 + var_519_51 and arg_516_1.time_ < var_519_43 + var_519_51 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_516_1:InitPlayNodeList()
	end,
	Play103704129 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 103704129
		arg_520_1.duration_ = 8.73

		local var_520_0 = {
			ja = 6.733,
			ko = 6.566,
			en = 8.733
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play103704130(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0
			local var_523_1 = 1

			if var_523_0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_0 + arg_523_0 then
				local var_523_2 = "play"
				local var_523_3 = "effect"

				arg_520_1:AudioAction(var_523_2, var_523_3, "se_story_side_1037", "se_story_1037_shoot", "")
			end

			local var_523_4 = 0
			local var_523_5 = 0.825

			if var_523_4 < arg_520_1.time_ and arg_520_1.time_ <= var_523_4 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_6 = arg_520_1:FormatText(StoryNameCfg[15].name)

				arg_520_1.leftNameTxt_.text = var_523_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_7 = arg_520_1:GetWordFromCfg(103704129)
				local var_523_8 = arg_520_1:FormatText(var_523_7.content)

				arg_520_1.text_.text = var_523_8

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_9 = 33
				local var_523_10 = utf8.len(var_523_8)
				local var_523_11 = var_523_9 <= 0 and var_523_5 or var_523_5 * (var_523_10 / var_523_9)

				if var_523_11 > 0 and var_523_5 < var_523_11 then
					arg_520_1.talkMaxDuration = var_523_11

					if var_523_11 + var_523_4 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_11 + var_523_4
					end
				end

				arg_520_1.text_.text = var_523_8
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704129", "story_v_side_old_103704.awb") ~= 0 then
					local var_523_12 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704129", "story_v_side_old_103704.awb") / 1000

					if var_523_12 + var_523_4 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_12 + var_523_4
					end

					if var_523_7.prefab_name ~= "" and arg_520_1.actors_[var_523_7.prefab_name] ~= nil then
						local var_523_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_7.prefab_name].transform, "story_v_side_old_103704", "103704129", "story_v_side_old_103704.awb")

						arg_520_1:RecordAudio("103704129", var_523_13)
						arg_520_1:RecordAudio("103704129", var_523_13)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704129", "story_v_side_old_103704.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704129", "story_v_side_old_103704.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_14 = math.max(var_523_5, arg_520_1.talkMaxDuration)

			if var_523_4 <= arg_520_1.time_ and arg_520_1.time_ < var_523_4 + var_523_14 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_4) / var_523_14

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_4 + var_523_14 and arg_520_1.time_ < var_523_4 + var_523_14 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play103704130 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 103704130
		arg_524_1.duration_ = 11.43

		local var_524_0 = {
			ja = 11.433,
			ko = 9.6,
			en = 8.2
		}
		local var_524_1 = manager.audio:GetLocalizationFlag()

		if var_524_0[var_524_1] ~= nil then
			arg_524_1.duration_ = var_524_0[var_524_1]
		end

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play103704131(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 0
			local var_527_1 = 0.825

			if var_527_0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				local var_527_2 = arg_524_1:FormatText(StoryNameCfg[15].name)

				arg_524_1.leftNameTxt_.text = var_527_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_3 = arg_524_1:GetWordFromCfg(103704130)
				local var_527_4 = arg_524_1:FormatText(var_527_3.content)

				arg_524_1.text_.text = var_527_4

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_5 = 33
				local var_527_6 = utf8.len(var_527_4)
				local var_527_7 = var_527_5 <= 0 and var_527_1 or var_527_1 * (var_527_6 / var_527_5)

				if var_527_7 > 0 and var_527_1 < var_527_7 then
					arg_524_1.talkMaxDuration = var_527_7

					if var_527_7 + var_527_0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_7 + var_527_0
					end
				end

				arg_524_1.text_.text = var_527_4
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704130", "story_v_side_old_103704.awb") ~= 0 then
					local var_527_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704130", "story_v_side_old_103704.awb") / 1000

					if var_527_8 + var_527_0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_8 + var_527_0
					end

					if var_527_3.prefab_name ~= "" and arg_524_1.actors_[var_527_3.prefab_name] ~= nil then
						local var_527_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_3.prefab_name].transform, "story_v_side_old_103704", "103704130", "story_v_side_old_103704.awb")

						arg_524_1:RecordAudio("103704130", var_527_9)
						arg_524_1:RecordAudio("103704130", var_527_9)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704130", "story_v_side_old_103704.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704130", "story_v_side_old_103704.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_10 = math.max(var_527_1, arg_524_1.talkMaxDuration)

			if var_527_0 <= arg_524_1.time_ and arg_524_1.time_ < var_527_0 + var_527_10 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_0) / var_527_10

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_0 + var_527_10 and arg_524_1.time_ < var_527_0 + var_527_10 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play103704131 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 103704131
		arg_528_1.duration_ = 16.1

		local var_528_0 = {
			ja = 16.1,
			ko = 10.266,
			en = 12.733
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play103704132(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0
			local var_531_1 = 0.975

			if var_531_0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_2 = arg_528_1:FormatText(StoryNameCfg[15].name)

				arg_528_1.leftNameTxt_.text = var_531_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_3 = arg_528_1:GetWordFromCfg(103704131)
				local var_531_4 = arg_528_1:FormatText(var_531_3.content)

				arg_528_1.text_.text = var_531_4

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_5 = 39
				local var_531_6 = utf8.len(var_531_4)
				local var_531_7 = var_531_5 <= 0 and var_531_1 or var_531_1 * (var_531_6 / var_531_5)

				if var_531_7 > 0 and var_531_1 < var_531_7 then
					arg_528_1.talkMaxDuration = var_531_7

					if var_531_7 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_7 + var_531_0
					end
				end

				arg_528_1.text_.text = var_531_4
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704131", "story_v_side_old_103704.awb") ~= 0 then
					local var_531_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704131", "story_v_side_old_103704.awb") / 1000

					if var_531_8 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_8 + var_531_0
					end

					if var_531_3.prefab_name ~= "" and arg_528_1.actors_[var_531_3.prefab_name] ~= nil then
						local var_531_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_3.prefab_name].transform, "story_v_side_old_103704", "103704131", "story_v_side_old_103704.awb")

						arg_528_1:RecordAudio("103704131", var_531_9)
						arg_528_1:RecordAudio("103704131", var_531_9)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704131", "story_v_side_old_103704.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704131", "story_v_side_old_103704.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_10 = math.max(var_531_1, arg_528_1.talkMaxDuration)

			if var_531_0 <= arg_528_1.time_ and arg_528_1.time_ < var_531_0 + var_531_10 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_0) / var_531_10

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_0 + var_531_10 and arg_528_1.time_ < var_531_0 + var_531_10 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play103704132 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 103704132
		arg_532_1.duration_ = 13.87

		local var_532_0 = {
			ja = 13.866,
			ko = 9.7,
			en = 8.966
		}
		local var_532_1 = manager.audio:GetLocalizationFlag()

		if var_532_0[var_532_1] ~= nil then
			arg_532_1.duration_ = var_532_0[var_532_1]
		end

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play103704133(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0
			local var_535_1 = 0.8

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_2 = arg_532_1:FormatText(StoryNameCfg[15].name)

				arg_532_1.leftNameTxt_.text = var_535_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_3 = arg_532_1:GetWordFromCfg(103704132)
				local var_535_4 = arg_532_1:FormatText(var_535_3.content)

				arg_532_1.text_.text = var_535_4

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_5 = 32
				local var_535_6 = utf8.len(var_535_4)
				local var_535_7 = var_535_5 <= 0 and var_535_1 or var_535_1 * (var_535_6 / var_535_5)

				if var_535_7 > 0 and var_535_1 < var_535_7 then
					arg_532_1.talkMaxDuration = var_535_7

					if var_535_7 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_7 + var_535_0
					end
				end

				arg_532_1.text_.text = var_535_4
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103704", "103704132", "story_v_side_old_103704.awb") ~= 0 then
					local var_535_8 = manager.audio:GetVoiceLength("story_v_side_old_103704", "103704132", "story_v_side_old_103704.awb") / 1000

					if var_535_8 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_8 + var_535_0
					end

					if var_535_3.prefab_name ~= "" and arg_532_1.actors_[var_535_3.prefab_name] ~= nil then
						local var_535_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_3.prefab_name].transform, "story_v_side_old_103704", "103704132", "story_v_side_old_103704.awb")

						arg_532_1:RecordAudio("103704132", var_535_9)
						arg_532_1:RecordAudio("103704132", var_535_9)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_side_old_103704", "103704132", "story_v_side_old_103704.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_side_old_103704", "103704132", "story_v_side_old_103704.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_10 = math.max(var_535_1, arg_532_1.talkMaxDuration)

			if var_535_0 <= arg_532_1.time_ and arg_532_1.time_ < var_535_0 + var_535_10 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_0) / var_535_10

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_0 + var_535_10 and arg_532_1.time_ < var_535_0 + var_535_10 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play103704133 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 103704133
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play103704134(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = 0
			local var_539_1 = 1

			if var_539_0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_0 + arg_539_0 then
				local var_539_2 = "play"
				local var_539_3 = "effect"

				arg_536_1:AudioAction(var_539_2, var_539_3, "se_story_side_1037", "se_story_1037_release", "")
			end

			local var_539_4 = 0.766666666666667
			local var_539_5 = 1

			if var_539_4 < arg_536_1.time_ and arg_536_1.time_ <= var_539_4 + arg_539_0 then
				local var_539_6 = "play"
				local var_539_7 = "effect"

				arg_536_1:AudioAction(var_539_6, var_539_7, "se_story_side_1037", "se_story_1037_hit", "")
			end

			local var_539_8 = 0
			local var_539_9 = 0.425

			if var_539_8 < arg_536_1.time_ and arg_536_1.time_ <= var_539_8 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, false)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_10 = arg_536_1:GetWordFromCfg(103704133)
				local var_539_11 = arg_536_1:FormatText(var_539_10.content)

				arg_536_1.text_.text = var_539_11

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_12 = 17
				local var_539_13 = utf8.len(var_539_11)
				local var_539_14 = var_539_12 <= 0 and var_539_9 or var_539_9 * (var_539_13 / var_539_12)

				if var_539_14 > 0 and var_539_9 < var_539_14 then
					arg_536_1.talkMaxDuration = var_539_14

					if var_539_14 + var_539_8 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_14 + var_539_8
					end
				end

				arg_536_1.text_.text = var_539_11
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_15 = math.max(var_539_9, arg_536_1.talkMaxDuration)

			if var_539_8 <= arg_536_1.time_ and arg_536_1.time_ < var_539_8 + var_539_15 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_8) / var_539_15

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_8 + var_539_15 and arg_536_1.time_ < var_539_8 + var_539_15 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play103704134 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 103704134
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
			arg_540_1.auto_ = false
		end

		function arg_540_1.playNext_(arg_542_0)
			arg_540_1.onStoryFinished_()
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0
			local var_543_1 = 0.125

			if var_543_0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, false)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_2 = arg_540_1:GetWordFromCfg(103704134)
				local var_543_3 = arg_540_1:FormatText(var_543_2.content)

				arg_540_1.text_.text = var_543_3

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_4 = 5
				local var_543_5 = utf8.len(var_543_3)
				local var_543_6 = var_543_4 <= 0 and var_543_1 or var_543_1 * (var_543_5 / var_543_4)

				if var_543_6 > 0 and var_543_1 < var_543_6 then
					arg_540_1.talkMaxDuration = var_543_6

					if var_543_6 + var_543_0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_6 + var_543_0
					end
				end

				arg_540_1.text_.text = var_543_3
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_7 = math.max(var_543_1, arg_540_1.talkMaxDuration)

			if var_543_0 <= arg_540_1.time_ and arg_540_1.time_ < var_543_0 + var_543_7 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_0) / var_543_7

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_0 + var_543_7 and arg_540_1.time_ < var_543_0 + var_543_7 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0903",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/A00",
		"TextureConfig/Background/ST16",
		"TextureConfig/Background/R3701"
	},
	voices = {
		"story_v_side_old_103704.awb"
	}
}
