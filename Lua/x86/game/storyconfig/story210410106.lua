return {
	Play1104106001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104106001
		arg_1_1.duration_ = 4.9

		local var_1_0 = {
			zh = 4.9,
			ja = 3.9
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
				arg_1_0:Play1104106002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F03_1"

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
				local var_4_5 = arg_1_1.bgs_.F03_1

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
					if iter_4_0 ~= "F03_1" then
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
			local var_4_23 = 0.425

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

			local var_4_28 = 1
			local var_4_29 = 0.466666666666667

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 2
			local var_4_35 = 0.125

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[622].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015_split2")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(1104106001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 5
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106001", "story_v_side_new_1104106.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106001", "story_v_side_new_1104106.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_side_new_1104106", "1104106001", "story_v_side_new_1104106.awb")

						arg_1_1:RecordAudio("1104106001", var_4_44)
						arg_1_1:RecordAudio("1104106001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106001", "story_v_side_new_1104106.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106001", "story_v_side_new_1104106.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_34 + 0.3
			local var_4_46 = math.max(var_4_35, arg_1_1.talkMaxDuration)

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
	Play1104106002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1104106002
		arg_9_1.duration_ = 1.33

		local var_9_0 = {
			zh = 0.999999999999,
			ja = 1.333
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
				arg_9_0:Play1104106003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.05

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[226].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10016")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(1104106002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106002", "story_v_side_new_1104106.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106002", "story_v_side_new_1104106.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_side_new_1104106", "1104106002", "story_v_side_new_1104106.awb")

						arg_9_1:RecordAudio("1104106002", var_12_9)
						arg_9_1:RecordAudio("1104106002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106002", "story_v_side_new_1104106.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106002", "story_v_side_new_1104106.awb")
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
	Play1104106003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1104106003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1104106004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.45

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

				local var_16_2 = arg_13_1:GetWordFromCfg(1104106003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 58
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
	Play1104106004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1104106004
		arg_17_1.duration_ = 5.43

		local var_17_0 = {
			zh = 3.733,
			ja = 5.433
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
				arg_17_0:Play1104106005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.35

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[622].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015_split3")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(1104106004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106004", "story_v_side_new_1104106.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106004", "story_v_side_new_1104106.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_side_new_1104106", "1104106004", "story_v_side_new_1104106.awb")

						arg_17_1:RecordAudio("1104106004", var_20_9)
						arg_17_1:RecordAudio("1104106004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106004", "story_v_side_new_1104106.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106004", "story_v_side_new_1104106.awb")
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
	Play1104106005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1104106005
		arg_21_1.duration_ = 4.17

		local var_21_0 = {
			zh = 2.233,
			ja = 4.166
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
				arg_21_0:Play1104106006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.2

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[226].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10016")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(1104106005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106005", "story_v_side_new_1104106.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106005", "story_v_side_new_1104106.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_side_new_1104106", "1104106005", "story_v_side_new_1104106.awb")

						arg_21_1:RecordAudio("1104106005", var_24_9)
						arg_21_1:RecordAudio("1104106005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106005", "story_v_side_new_1104106.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106005", "story_v_side_new_1104106.awb")
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
	Play1104106006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1104106006
		arg_25_1.duration_ = 2.57

		local var_25_0 = {
			zh = 1.6,
			ja = 2.566
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
				arg_25_0:Play1104106007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.15

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[622].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015_split4")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(1104106006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106006", "story_v_side_new_1104106.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106006", "story_v_side_new_1104106.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_side_new_1104106", "1104106006", "story_v_side_new_1104106.awb")

						arg_25_1:RecordAudio("1104106006", var_28_9)
						arg_25_1:RecordAudio("1104106006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106006", "story_v_side_new_1104106.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106006", "story_v_side_new_1104106.awb")
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
	Play1104106007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1104106007
		arg_29_1.duration_ = 12

		local var_29_0 = {
			zh = 8.633,
			ja = 12
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
				arg_29_0:Play1104106008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.675

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[226].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10016")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(1104106007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106007", "story_v_side_new_1104106.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106007", "story_v_side_new_1104106.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_side_new_1104106", "1104106007", "story_v_side_new_1104106.awb")

						arg_29_1:RecordAudio("1104106007", var_32_9)
						arg_29_1:RecordAudio("1104106007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106007", "story_v_side_new_1104106.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106007", "story_v_side_new_1104106.awb")
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
	Play1104106008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1104106008
		arg_33_1.duration_ = 6.4

		local var_33_0 = {
			zh = 1.833,
			ja = 6.4
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
				arg_33_0:Play1104106009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.2

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[622].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015_split3")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(1104106008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106008", "story_v_side_new_1104106.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106008", "story_v_side_new_1104106.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_side_new_1104106", "1104106008", "story_v_side_new_1104106.awb")

						arg_33_1:RecordAudio("1104106008", var_36_9)
						arg_33_1:RecordAudio("1104106008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106008", "story_v_side_new_1104106.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106008", "story_v_side_new_1104106.awb")
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
	Play1104106009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1104106009
		arg_37_1.duration_ = 3.43

		local var_37_0 = {
			zh = 0.999999999999,
			ja = 3.433
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
				arg_37_0:Play1104106010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.05

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[226].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10016")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(1104106009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106009", "story_v_side_new_1104106.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106009", "story_v_side_new_1104106.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_side_new_1104106", "1104106009", "story_v_side_new_1104106.awb")

						arg_37_1:RecordAudio("1104106009", var_40_9)
						arg_37_1:RecordAudio("1104106009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106009", "story_v_side_new_1104106.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106009", "story_v_side_new_1104106.awb")
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
	Play1104106010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1104106010
		arg_41_1.duration_ = 14.37

		local var_41_0 = {
			zh = 11.4,
			ja = 14.366
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
				arg_41_0:Play1104106011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.95

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[226].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10016")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(1104106010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106010", "story_v_side_new_1104106.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106010", "story_v_side_new_1104106.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_side_new_1104106", "1104106010", "story_v_side_new_1104106.awb")

						arg_41_1:RecordAudio("1104106010", var_44_9)
						arg_41_1:RecordAudio("1104106010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106010", "story_v_side_new_1104106.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106010", "story_v_side_new_1104106.awb")
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
	Play1104106011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1104106011
		arg_45_1.duration_ = 5.6

		local var_45_0 = {
			zh = 3.5,
			ja = 5.6
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
				arg_45_0:Play1104106012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.425

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[622].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(1104106011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106011", "story_v_side_new_1104106.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106011", "story_v_side_new_1104106.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_side_new_1104106", "1104106011", "story_v_side_new_1104106.awb")

						arg_45_1:RecordAudio("1104106011", var_48_9)
						arg_45_1:RecordAudio("1104106011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106011", "story_v_side_new_1104106.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106011", "story_v_side_new_1104106.awb")
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
	Play1104106012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1104106012
		arg_49_1.duration_ = 13.03

		local var_49_0 = {
			zh = 10.866,
			ja = 13.033
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
				arg_49_0:Play1104106013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.85

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[226].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10016")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(1104106012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106012", "story_v_side_new_1104106.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106012", "story_v_side_new_1104106.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_side_new_1104106", "1104106012", "story_v_side_new_1104106.awb")

						arg_49_1:RecordAudio("1104106012", var_52_9)
						arg_49_1:RecordAudio("1104106012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106012", "story_v_side_new_1104106.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106012", "story_v_side_new_1104106.awb")
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
	Play1104106013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1104106013
		arg_53_1.duration_ = 8.03

		local var_53_0 = {
			zh = 7.633,
			ja = 8.033
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
				arg_53_0:Play1104106014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = "F03_2"

			if arg_53_1.bgs_[var_56_0] == nil then
				local var_56_1 = Object.Instantiate(arg_53_1.paintGo_)

				var_56_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_56_0)
				var_56_1.name = var_56_0
				var_56_1.transform.parent = arg_53_1.stage_.transform
				var_56_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.bgs_[var_56_0] = var_56_1
			end

			local var_56_2 = 2

			if var_56_2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				local var_56_3 = manager.ui.mainCamera.transform.localPosition
				local var_56_4 = Vector3.New(0, 0, 10) + Vector3.New(var_56_3.x, var_56_3.y, 0)
				local var_56_5 = arg_53_1.bgs_.F03_2

				var_56_5.transform.localPosition = var_56_4
				var_56_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_6 = var_56_5:GetComponent("SpriteRenderer")

				if var_56_6 and var_56_6.sprite then
					local var_56_7 = (var_56_5.transform.localPosition - var_56_3).z
					local var_56_8 = manager.ui.mainCameraCom_
					local var_56_9 = 2 * var_56_7 * Mathf.Tan(var_56_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_56_10 = var_56_9 * var_56_8.aspect
					local var_56_11 = var_56_6.sprite.bounds.size.x
					local var_56_12 = var_56_6.sprite.bounds.size.y
					local var_56_13 = var_56_10 / var_56_11
					local var_56_14 = var_56_9 / var_56_12
					local var_56_15 = var_56_14 < var_56_13 and var_56_13 or var_56_14

					var_56_5.transform.localScale = Vector3.New(var_56_15, var_56_15, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "F03_2" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_17 = 2

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17
				local var_56_19 = Color.New(0, 0, 0)

				var_56_19.a = Mathf.Lerp(0, 1, var_56_18)
				arg_53_1.mask_.color = var_56_19
			end

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 then
				local var_56_20 = Color.New(0, 0, 0)

				var_56_20.a = 1
				arg_53_1.mask_.color = var_56_20
			end

			local var_56_21 = 2

			if var_56_21 < arg_53_1.time_ and arg_53_1.time_ <= var_56_21 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_22 = 2

			if var_56_21 <= arg_53_1.time_ and arg_53_1.time_ < var_56_21 + var_56_22 then
				local var_56_23 = (arg_53_1.time_ - var_56_21) / var_56_22
				local var_56_24 = Color.New(0, 0, 0)

				var_56_24.a = Mathf.Lerp(1, 0, var_56_23)
				arg_53_1.mask_.color = var_56_24
			end

			if arg_53_1.time_ >= var_56_21 + var_56_22 and arg_53_1.time_ < var_56_21 + var_56_22 + arg_56_0 then
				local var_56_25 = Color.New(0, 0, 0)
				local var_56_26 = 0

				arg_53_1.mask_.enabled = false
				var_56_25.a = var_56_26
				arg_53_1.mask_.color = var_56_25
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_27 = 4
			local var_56_28 = 0.3

			if var_56_27 < arg_53_1.time_ and arg_53_1.time_ <= var_56_27 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_29 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_29:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_30 = arg_53_1:FormatText(StoryNameCfg[614].name)

				arg_53_1.leftNameTxt_.text = var_56_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_3")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_31 = arg_53_1:GetWordFromCfg(1104106013)
				local var_56_32 = arg_53_1:FormatText(var_56_31.content)

				arg_53_1.text_.text = var_56_32

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_33 = 12
				local var_56_34 = utf8.len(var_56_32)
				local var_56_35 = var_56_33 <= 0 and var_56_28 or var_56_28 * (var_56_34 / var_56_33)

				if var_56_35 > 0 and var_56_28 < var_56_35 then
					arg_53_1.talkMaxDuration = var_56_35
					var_56_27 = var_56_27 + 0.3

					if var_56_35 + var_56_27 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_35 + var_56_27
					end
				end

				arg_53_1.text_.text = var_56_32
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106013", "story_v_side_new_1104106.awb") ~= 0 then
					local var_56_36 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106013", "story_v_side_new_1104106.awb") / 1000

					if var_56_36 + var_56_27 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_36 + var_56_27
					end

					if var_56_31.prefab_name ~= "" and arg_53_1.actors_[var_56_31.prefab_name] ~= nil then
						local var_56_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_31.prefab_name].transform, "story_v_side_new_1104106", "1104106013", "story_v_side_new_1104106.awb")

						arg_53_1:RecordAudio("1104106013", var_56_37)
						arg_53_1:RecordAudio("1104106013", var_56_37)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106013", "story_v_side_new_1104106.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106013", "story_v_side_new_1104106.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_38 = var_56_27 + 0.3
			local var_56_39 = math.max(var_56_28, arg_53_1.talkMaxDuration)

			if var_56_38 <= arg_53_1.time_ and arg_53_1.time_ < var_56_38 + var_56_39 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_38) / var_56_39

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_38 + var_56_39 and arg_53_1.time_ < var_56_38 + var_56_39 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1104106014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1104106014
		arg_59_1.duration_ = 3.5

		local var_59_0 = {
			zh = 3.5,
			ja = 0.999999999999
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
				arg_59_0:Play1104106015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.1

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[622].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015_split5")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:GetWordFromCfg(1104106014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106014", "story_v_side_new_1104106.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106014", "story_v_side_new_1104106.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_side_new_1104106", "1104106014", "story_v_side_new_1104106.awb")

						arg_59_1:RecordAudio("1104106014", var_62_9)
						arg_59_1:RecordAudio("1104106014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106014", "story_v_side_new_1104106.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106014", "story_v_side_new_1104106.awb")
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
	Play1104106015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1104106015
		arg_63_1.duration_ = 11.03

		local var_63_0 = {
			zh = 6.4,
			ja = 11.033
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
				arg_63_0:Play1104106016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.675

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[614].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(1104106015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106015", "story_v_side_new_1104106.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106015", "story_v_side_new_1104106.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_side_new_1104106", "1104106015", "story_v_side_new_1104106.awb")

						arg_63_1:RecordAudio("1104106015", var_66_9)
						arg_63_1:RecordAudio("1104106015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106015", "story_v_side_new_1104106.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106015", "story_v_side_new_1104106.awb")
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
	Play1104106016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1104106016
		arg_67_1.duration_ = 7.77

		local var_67_0 = {
			zh = 5,
			ja = 7.766
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
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1104106017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.575

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[622].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015_split5")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(1104106016)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106016", "story_v_side_new_1104106.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106016", "story_v_side_new_1104106.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_side_new_1104106", "1104106016", "story_v_side_new_1104106.awb")

						arg_67_1:RecordAudio("1104106016", var_70_9)
						arg_67_1:RecordAudio("1104106016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106016", "story_v_side_new_1104106.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106016", "story_v_side_new_1104106.awb")
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
	Play1104106017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1104106017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1104106018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 1.65

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_2 = arg_71_1:GetWordFromCfg(1104106017)
				local var_74_3 = arg_71_1:FormatText(var_74_2.content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 66
				local var_74_5 = utf8.len(var_74_3)
				local var_74_6 = var_74_4 <= 0 and var_74_1 or var_74_1 * (var_74_5 / var_74_4)

				if var_74_6 > 0 and var_74_1 < var_74_6 then
					arg_71_1.talkMaxDuration = var_74_6

					if var_74_6 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_6 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_7 and arg_71_1.time_ < var_74_0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play1104106018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1104106018
		arg_75_1.duration_ = 9.6

		local var_75_0 = {
			zh = 7.9,
			ja = 9.6
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1104106019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.875

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[614].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_3")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:GetWordFromCfg(1104106018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 35
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106018", "story_v_side_new_1104106.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106018", "story_v_side_new_1104106.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_side_new_1104106", "1104106018", "story_v_side_new_1104106.awb")

						arg_75_1:RecordAudio("1104106018", var_78_9)
						arg_75_1:RecordAudio("1104106018", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106018", "story_v_side_new_1104106.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106018", "story_v_side_new_1104106.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_10 and arg_75_1.time_ < var_78_0 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1104106019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1104106019
		arg_79_1.duration_ = 16.63

		local var_79_0 = {
			zh = 16.633,
			ja = 15.6
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1104106020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 1.55

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[622].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015_split5")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_3 = arg_79_1:GetWordFromCfg(1104106019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 62
				local var_82_6 = utf8.len(var_82_4)
				local var_82_7 = var_82_5 <= 0 and var_82_1 or var_82_1 * (var_82_6 / var_82_5)

				if var_82_7 > 0 and var_82_1 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106019", "story_v_side_new_1104106.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106019", "story_v_side_new_1104106.awb") / 1000

					if var_82_8 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_0
					end

					if var_82_3.prefab_name ~= "" and arg_79_1.actors_[var_82_3.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_3.prefab_name].transform, "story_v_side_new_1104106", "1104106019", "story_v_side_new_1104106.awb")

						arg_79_1:RecordAudio("1104106019", var_82_9)
						arg_79_1:RecordAudio("1104106019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106019", "story_v_side_new_1104106.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106019", "story_v_side_new_1104106.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_10 and arg_79_1.time_ < var_82_0 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1104106020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1104106020
		arg_83_1.duration_ = 2.03

		local var_83_0 = {
			zh = 1.533,
			ja = 2.033
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1104106021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.125

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[614].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(1104106020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 5
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106020", "story_v_side_new_1104106.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106020", "story_v_side_new_1104106.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_side_new_1104106", "1104106020", "story_v_side_new_1104106.awb")

						arg_83_1:RecordAudio("1104106020", var_86_9)
						arg_83_1:RecordAudio("1104106020", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106020", "story_v_side_new_1104106.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106020", "story_v_side_new_1104106.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_10 and arg_83_1.time_ < var_86_0 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play1104106021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1104106021
		arg_87_1.duration_ = 12.57

		local var_87_0 = {
			zh = 4.866,
			ja = 12.566
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1104106022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.525

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[622].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:GetWordFromCfg(1104106021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 21
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106021", "story_v_side_new_1104106.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106021", "story_v_side_new_1104106.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_side_new_1104106", "1104106021", "story_v_side_new_1104106.awb")

						arg_87_1:RecordAudio("1104106021", var_90_9)
						arg_87_1:RecordAudio("1104106021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106021", "story_v_side_new_1104106.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106021", "story_v_side_new_1104106.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_10 and arg_87_1.time_ < var_90_0 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play1104106022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1104106022
		arg_91_1.duration_ = 10.3

		local var_91_0 = {
			zh = 10.033,
			ja = 10.3
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1104106023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 1.025

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[622].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(1104106022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 41
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106022", "story_v_side_new_1104106.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106022", "story_v_side_new_1104106.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_side_new_1104106", "1104106022", "story_v_side_new_1104106.awb")

						arg_91_1:RecordAudio("1104106022", var_94_9)
						arg_91_1:RecordAudio("1104106022", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106022", "story_v_side_new_1104106.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106022", "story_v_side_new_1104106.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_10 and arg_91_1.time_ < var_94_0 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1104106023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1104106023
		arg_95_1.duration_ = 2.63

		local var_95_0 = {
			zh = 2.633,
			ja = 1.5
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1104106024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.05

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[614].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:GetWordFromCfg(1104106023)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 2
				local var_98_6 = utf8.len(var_98_4)
				local var_98_7 = var_98_5 <= 0 and var_98_1 or var_98_1 * (var_98_6 / var_98_5)

				if var_98_7 > 0 and var_98_1 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106023", "story_v_side_new_1104106.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106023", "story_v_side_new_1104106.awb") / 1000

					if var_98_8 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_0
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_side_new_1104106", "1104106023", "story_v_side_new_1104106.awb")

						arg_95_1:RecordAudio("1104106023", var_98_9)
						arg_95_1:RecordAudio("1104106023", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106023", "story_v_side_new_1104106.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106023", "story_v_side_new_1104106.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_10 and arg_95_1.time_ < var_98_0 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1104106024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1104106024
		arg_99_1.duration_ = 8.2

		local var_99_0 = {
			zh = 8.2,
			ja = 8
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1104106025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = "ST24a"

			if arg_99_1.bgs_[var_102_0] == nil then
				local var_102_1 = Object.Instantiate(arg_99_1.paintGo_)

				var_102_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_102_0)
				var_102_1.name = var_102_0
				var_102_1.transform.parent = arg_99_1.stage_.transform
				var_102_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.bgs_[var_102_0] = var_102_1
			end

			local var_102_2 = 2

			if var_102_2 < arg_99_1.time_ and arg_99_1.time_ <= var_102_2 + arg_102_0 then
				local var_102_3 = manager.ui.mainCamera.transform.localPosition
				local var_102_4 = Vector3.New(0, 0, 10) + Vector3.New(var_102_3.x, var_102_3.y, 0)
				local var_102_5 = arg_99_1.bgs_.ST24a

				var_102_5.transform.localPosition = var_102_4
				var_102_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_6 = var_102_5:GetComponent("SpriteRenderer")

				if var_102_6 and var_102_6.sprite then
					local var_102_7 = (var_102_5.transform.localPosition - var_102_3).z
					local var_102_8 = manager.ui.mainCameraCom_
					local var_102_9 = 2 * var_102_7 * Mathf.Tan(var_102_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_102_10 = var_102_9 * var_102_8.aspect
					local var_102_11 = var_102_6.sprite.bounds.size.x
					local var_102_12 = var_102_6.sprite.bounds.size.y
					local var_102_13 = var_102_10 / var_102_11
					local var_102_14 = var_102_9 / var_102_12
					local var_102_15 = var_102_14 < var_102_13 and var_102_13 or var_102_14

					var_102_5.transform.localScale = Vector3.New(var_102_15, var_102_15, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "ST24a" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_102_16 = 0

			if var_102_16 < arg_99_1.time_ and arg_99_1.time_ <= var_102_16 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_17 = 2

			if var_102_16 <= arg_99_1.time_ and arg_99_1.time_ < var_102_16 + var_102_17 then
				local var_102_18 = (arg_99_1.time_ - var_102_16) / var_102_17
				local var_102_19 = Color.New(0, 0, 0)

				var_102_19.a = Mathf.Lerp(0, 1, var_102_18)
				arg_99_1.mask_.color = var_102_19
			end

			if arg_99_1.time_ >= var_102_16 + var_102_17 and arg_99_1.time_ < var_102_16 + var_102_17 + arg_102_0 then
				local var_102_20 = Color.New(0, 0, 0)

				var_102_20.a = 1
				arg_99_1.mask_.color = var_102_20
			end

			local var_102_21 = 2

			if var_102_21 < arg_99_1.time_ and arg_99_1.time_ <= var_102_21 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_22 = 2

			if var_102_21 <= arg_99_1.time_ and arg_99_1.time_ < var_102_21 + var_102_22 then
				local var_102_23 = (arg_99_1.time_ - var_102_21) / var_102_22
				local var_102_24 = Color.New(0, 0, 0)

				var_102_24.a = Mathf.Lerp(1, 0, var_102_23)
				arg_99_1.mask_.color = var_102_24
			end

			if arg_99_1.time_ >= var_102_21 + var_102_22 and arg_99_1.time_ < var_102_21 + var_102_22 + arg_102_0 then
				local var_102_25 = Color.New(0, 0, 0)
				local var_102_26 = 0

				arg_99_1.mask_.enabled = false
				var_102_25.a = var_102_26
				arg_99_1.mask_.color = var_102_25
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_27 = 4
			local var_102_28 = 0.4

			if var_102_27 < arg_99_1.time_ and arg_99_1.time_ <= var_102_27 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_29 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_29:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_99_1.dialogCg_.alpha = arg_103_0
				end))
				var_102_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_30 = arg_99_1:FormatText(StoryNameCfg[36].name)

				arg_99_1.leftNameTxt_.text = var_102_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_31 = arg_99_1:GetWordFromCfg(1104106024)
				local var_102_32 = arg_99_1:FormatText(var_102_31.content)

				arg_99_1.text_.text = var_102_32

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_33 = 16
				local var_102_34 = utf8.len(var_102_32)
				local var_102_35 = var_102_33 <= 0 and var_102_28 or var_102_28 * (var_102_34 / var_102_33)

				if var_102_35 > 0 and var_102_28 < var_102_35 then
					arg_99_1.talkMaxDuration = var_102_35
					var_102_27 = var_102_27 + 0.3

					if var_102_35 + var_102_27 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_35 + var_102_27
					end
				end

				arg_99_1.text_.text = var_102_32
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106024", "story_v_side_new_1104106.awb") ~= 0 then
					local var_102_36 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106024", "story_v_side_new_1104106.awb") / 1000

					if var_102_36 + var_102_27 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_36 + var_102_27
					end

					if var_102_31.prefab_name ~= "" and arg_99_1.actors_[var_102_31.prefab_name] ~= nil then
						local var_102_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_31.prefab_name].transform, "story_v_side_new_1104106", "1104106024", "story_v_side_new_1104106.awb")

						arg_99_1:RecordAudio("1104106024", var_102_37)
						arg_99_1:RecordAudio("1104106024", var_102_37)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106024", "story_v_side_new_1104106.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106024", "story_v_side_new_1104106.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_38 = var_102_27 + 0.3
			local var_102_39 = math.max(var_102_28, arg_99_1.talkMaxDuration)

			if var_102_38 <= arg_99_1.time_ and arg_99_1.time_ < var_102_38 + var_102_39 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_38) / var_102_39

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_38 + var_102_39 and arg_99_1.time_ < var_102_38 + var_102_39 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1104106025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1104106025
		arg_105_1.duration_ = 7.37

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1104106026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = "STblack"

			if arg_105_1.bgs_[var_108_0] == nil then
				local var_108_1 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_108_0)
				var_108_1.name = var_108_0
				var_108_1.transform.parent = arg_105_1.stage_.transform
				var_108_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_[var_108_0] = var_108_1
			end

			local var_108_2 = 2

			if var_108_2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				local var_108_3 = manager.ui.mainCamera.transform.localPosition
				local var_108_4 = Vector3.New(0, 0, 10) + Vector3.New(var_108_3.x, var_108_3.y, 0)
				local var_108_5 = arg_105_1.bgs_.STblack

				var_108_5.transform.localPosition = var_108_4
				var_108_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_6 = var_108_5:GetComponent("SpriteRenderer")

				if var_108_6 and var_108_6.sprite then
					local var_108_7 = (var_108_5.transform.localPosition - var_108_3).z
					local var_108_8 = manager.ui.mainCameraCom_
					local var_108_9 = 2 * var_108_7 * Mathf.Tan(var_108_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_108_10 = var_108_9 * var_108_8.aspect
					local var_108_11 = var_108_6.sprite.bounds.size.x
					local var_108_12 = var_108_6.sprite.bounds.size.y
					local var_108_13 = var_108_10 / var_108_11
					local var_108_14 = var_108_9 / var_108_12
					local var_108_15 = var_108_14 < var_108_13 and var_108_13 or var_108_14

					var_108_5.transform.localScale = Vector3.New(var_108_15, var_108_15, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "STblack" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_16 = 0

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_17 = 2

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_17 then
				local var_108_18 = (arg_105_1.time_ - var_108_16) / var_108_17
				local var_108_19 = Color.New(0, 0, 0)

				var_108_19.a = Mathf.Lerp(0, 1, var_108_18)
				arg_105_1.mask_.color = var_108_19
			end

			if arg_105_1.time_ >= var_108_16 + var_108_17 and arg_105_1.time_ < var_108_16 + var_108_17 + arg_108_0 then
				local var_108_20 = Color.New(0, 0, 0)

				var_108_20.a = 1
				arg_105_1.mask_.color = var_108_20
			end

			local var_108_21 = 2

			if var_108_21 < arg_105_1.time_ and arg_105_1.time_ <= var_108_21 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_22 = 0.366666666666667

			if var_108_21 <= arg_105_1.time_ and arg_105_1.time_ < var_108_21 + var_108_22 then
				local var_108_23 = (arg_105_1.time_ - var_108_21) / var_108_22
				local var_108_24 = Color.New(0, 0, 0)

				var_108_24.a = Mathf.Lerp(1, 0, var_108_23)
				arg_105_1.mask_.color = var_108_24
			end

			if arg_105_1.time_ >= var_108_21 + var_108_22 and arg_105_1.time_ < var_108_21 + var_108_22 + arg_108_0 then
				local var_108_25 = Color.New(0, 0, 0)
				local var_108_26 = 0

				arg_105_1.mask_.enabled = false
				var_108_25.a = var_108_26
				arg_105_1.mask_.color = var_108_25
			end

			local var_108_27 = 0
			local var_108_28 = 0.425

			if var_108_27 < arg_105_1.time_ and arg_105_1.time_ <= var_108_27 + arg_108_0 then
				local var_108_29 = "play"
				local var_108_30 = "music"

				arg_105_1:AudioAction(var_108_29, var_108_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_108_31 = ""
				local var_108_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_108_32 ~= "" then
					if arg_105_1.bgmTxt_.text ~= var_108_32 and arg_105_1.bgmTxt_.text ~= "" then
						if arg_105_1.bgmTxt2_.text ~= "" then
							arg_105_1.bgmTxt_.text = arg_105_1.bgmTxt2_.text
						end

						arg_105_1.bgmTxt2_.text = var_108_32

						arg_105_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_105_1.bgmTxt_.text = var_108_32
						arg_105_1.bgmTxt2_.text = var_108_32
					end

					if arg_105_1.bgmTimer then
						arg_105_1.bgmTimer:Stop()

						arg_105_1.bgmTimer = nil
					end

					if arg_105_1.settingData.show_music_name == 1 then
						arg_105_1.musicController:SetSelectedState("show")
						arg_105_1.musicAnimator_:Play("open", 0, 0)

						if arg_105_1.settingData.music_time ~= 0 then
							arg_105_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_105_1.settingData.music_time), function()
								if arg_105_1 == nil or isNil(arg_105_1.bgmTxt_) then
									return
								end

								arg_105_1.musicController:SetSelectedState("hide")
								arg_105_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_33 = 2.36666666666667
			local var_108_34 = 0.175

			if var_108_33 < arg_105_1.time_ and arg_105_1.time_ <= var_108_33 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_35 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_35:setOnUpdate(LuaHelper.FloatAction(function(arg_110_0)
					arg_105_1.dialogCg_.alpha = arg_110_0
				end))
				var_108_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_36 = arg_105_1:GetWordFromCfg(1104106025)
				local var_108_37 = arg_105_1:FormatText(var_108_36.content)

				arg_105_1.text_.text = var_108_37

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_38 = 7
				local var_108_39 = utf8.len(var_108_37)
				local var_108_40 = var_108_38 <= 0 and var_108_34 or var_108_34 * (var_108_39 / var_108_38)

				if var_108_40 > 0 and var_108_34 < var_108_40 then
					arg_105_1.talkMaxDuration = var_108_40
					var_108_33 = var_108_33 + 0.3

					if var_108_40 + var_108_33 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_40 + var_108_33
					end
				end

				arg_105_1.text_.text = var_108_37
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_41 = var_108_33 + 0.3
			local var_108_42 = math.max(var_108_34, arg_105_1.talkMaxDuration)

			if var_108_41 <= arg_105_1.time_ and arg_105_1.time_ < var_108_41 + var_108_42 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_41) / var_108_42

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_41 + var_108_42 and arg_105_1.time_ < var_108_41 + var_108_42 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1104106026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1104106026
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1104106027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 1

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_2 = arg_112_1:GetWordFromCfg(1104106026)
				local var_115_3 = arg_112_1:FormatText(var_115_2.content)

				arg_112_1.text_.text = var_115_3

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 40
				local var_115_5 = utf8.len(var_115_3)
				local var_115_6 = var_115_4 <= 0 and var_115_1 or var_115_1 * (var_115_5 / var_115_4)

				if var_115_6 > 0 and var_115_1 < var_115_6 then
					arg_112_1.talkMaxDuration = var_115_6

					if var_115_6 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_6 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_3
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_7 and arg_112_1.time_ < var_115_0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play1104106027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1104106027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1104106028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.625

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[7].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:GetWordFromCfg(1104106027)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 25
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_8 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_8 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_8

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_8 and arg_116_1.time_ < var_119_0 + var_119_8 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play1104106028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1104106028
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1104106029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 1.225

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_2 = arg_120_1:GetWordFromCfg(1104106028)
				local var_123_3 = arg_120_1:FormatText(var_123_2.content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 49
				local var_123_5 = utf8.len(var_123_3)
				local var_123_6 = var_123_4 <= 0 and var_123_1 or var_123_1 * (var_123_5 / var_123_4)

				if var_123_6 > 0 and var_123_1 < var_123_6 then
					arg_120_1.talkMaxDuration = var_123_6

					if var_123_6 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_6 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_3
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_7 and arg_120_1.time_ < var_123_0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1104106029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1104106029
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1104106030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 1.4

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_2 = arg_124_1:GetWordFromCfg(1104106029)
				local var_127_3 = arg_124_1:FormatText(var_127_2.content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 56
				local var_127_5 = utf8.len(var_127_3)
				local var_127_6 = var_127_4 <= 0 and var_127_1 or var_127_1 * (var_127_5 / var_127_4)

				if var_127_6 > 0 and var_127_1 < var_127_6 then
					arg_124_1.talkMaxDuration = var_127_6

					if var_127_6 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_7 and arg_124_1.time_ < var_127_0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play1104106030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1104106030
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1104106031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.25

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[7].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_3 = arg_128_1:GetWordFromCfg(1104106030)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 10
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_8 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_8 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_8

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_8 and arg_128_1.time_ < var_131_0 + var_131_8 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play1104106031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1104106031
		arg_132_1.duration_ = 7

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1104106032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				local var_135_1 = manager.ui.mainCamera.transform.localPosition
				local var_135_2 = Vector3.New(0, 0, 10) + Vector3.New(var_135_1.x, var_135_1.y, 0)
				local var_135_3 = arg_132_1.bgs_.ST24a

				var_135_3.transform.localPosition = var_135_2
				var_135_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_135_4 = var_135_3:GetComponent("SpriteRenderer")

				if var_135_4 and var_135_4.sprite then
					local var_135_5 = (var_135_3.transform.localPosition - var_135_1).z
					local var_135_6 = manager.ui.mainCameraCom_
					local var_135_7 = 2 * var_135_5 * Mathf.Tan(var_135_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_135_8 = var_135_7 * var_135_6.aspect
					local var_135_9 = var_135_4.sprite.bounds.size.x
					local var_135_10 = var_135_4.sprite.bounds.size.y
					local var_135_11 = var_135_8 / var_135_9
					local var_135_12 = var_135_7 / var_135_10
					local var_135_13 = var_135_12 < var_135_11 and var_135_11 or var_135_12

					var_135_3.transform.localScale = Vector3.New(var_135_13, var_135_13, 0)
				end

				for iter_135_0, iter_135_1 in pairs(arg_132_1.bgs_) do
					if iter_135_0 ~= "ST24a" then
						iter_135_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_135_14 = 0

			if var_135_14 < arg_132_1.time_ and arg_132_1.time_ <= var_135_14 + arg_135_0 then
				arg_132_1.mask_.enabled = true
				arg_132_1.mask_.raycastTarget = true

				arg_132_1:SetGaussion(false)
			end

			local var_135_15 = 2

			if var_135_14 <= arg_132_1.time_ and arg_132_1.time_ < var_135_14 + var_135_15 then
				local var_135_16 = (arg_132_1.time_ - var_135_14) / var_135_15
				local var_135_17 = Color.New(0, 0, 0)

				var_135_17.a = Mathf.Lerp(1, 0, var_135_16)
				arg_132_1.mask_.color = var_135_17
			end

			if arg_132_1.time_ >= var_135_14 + var_135_15 and arg_132_1.time_ < var_135_14 + var_135_15 + arg_135_0 then
				local var_135_18 = Color.New(0, 0, 0)
				local var_135_19 = 0

				arg_132_1.mask_.enabled = false
				var_135_18.a = var_135_19
				arg_132_1.mask_.color = var_135_18
			end

			if arg_132_1.frameCnt_ <= 1 then
				arg_132_1.dialog_:SetActive(false)
			end

			local var_135_20 = 2
			local var_135_21 = 0.8

			if var_135_20 < arg_132_1.time_ and arg_132_1.time_ <= var_135_20 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0

				arg_132_1.dialog_:SetActive(true)

				arg_132_1.dialogCg_.alpha = 0

				local var_135_22 = LeanTween.value(arg_132_1.dialog_, 0, 1, 0.3)

				var_135_22:setOnUpdate(LuaHelper.FloatAction(function(arg_136_0)
					arg_132_1.dialogCg_.alpha = arg_136_0
				end))
				var_135_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_132_1.dialog_)
					var_135_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_132_1.duration_ = arg_132_1.duration_ + 0.3

				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_23 = arg_132_1:GetWordFromCfg(1104106031)
				local var_135_24 = arg_132_1:FormatText(var_135_23.content)

				arg_132_1.text_.text = var_135_24

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_25 = 32
				local var_135_26 = utf8.len(var_135_24)
				local var_135_27 = var_135_25 <= 0 and var_135_21 or var_135_21 * (var_135_26 / var_135_25)

				if var_135_27 > 0 and var_135_21 < var_135_27 then
					arg_132_1.talkMaxDuration = var_135_27
					var_135_20 = var_135_20 + 0.3

					if var_135_27 + var_135_20 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_27 + var_135_20
					end
				end

				arg_132_1.text_.text = var_135_24
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_28 = var_135_20 + 0.3
			local var_135_29 = math.max(var_135_21, arg_132_1.talkMaxDuration)

			if var_135_28 <= arg_132_1.time_ and arg_132_1.time_ < var_135_28 + var_135_29 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_28) / var_135_29

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_28 + var_135_29 and arg_132_1.time_ < var_135_28 + var_135_29 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play1104106032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1104106032
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play1104106033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 0.625

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_2 = arg_138_1:GetWordFromCfg(1104106032)
				local var_141_3 = arg_138_1:FormatText(var_141_2.content)

				arg_138_1.text_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_4 = 25
				local var_141_5 = utf8.len(var_141_3)
				local var_141_6 = var_141_4 <= 0 and var_141_1 or var_141_1 * (var_141_5 / var_141_4)

				if var_141_6 > 0 and var_141_1 < var_141_6 then
					arg_138_1.talkMaxDuration = var_141_6

					if var_141_6 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_6 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_3
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_7 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_7 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_7

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_7 and arg_138_1.time_ < var_141_0 + var_141_7 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play1104106033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1104106033
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play1104106034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.3

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_2 = arg_142_1:FormatText(StoryNameCfg[7].name)

				arg_142_1.leftNameTxt_.text = var_145_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_3 = arg_142_1:GetWordFromCfg(1104106033)
				local var_145_4 = arg_142_1:FormatText(var_145_3.content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 12
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
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_8 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_8 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_8

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_8 and arg_142_1.time_ < var_145_0 + var_145_8 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play1104106034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1104106034
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1104106035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 1.025

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_2 = arg_146_1:GetWordFromCfg(1104106034)
				local var_149_3 = arg_146_1:FormatText(var_149_2.content)

				arg_146_1.text_.text = var_149_3

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 41
				local var_149_5 = utf8.len(var_149_3)
				local var_149_6 = var_149_4 <= 0 and var_149_1 or var_149_1 * (var_149_5 / var_149_4)

				if var_149_6 > 0 and var_149_1 < var_149_6 then
					arg_146_1.talkMaxDuration = var_149_6

					if var_149_6 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_6 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_3
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_7 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_7 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_7

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_7 and arg_146_1.time_ < var_149_0 + var_149_7 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play1104106035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1104106035
		arg_150_1.duration_ = 2.77

		local var_150_0 = {
			zh = 2.166,
			ja = 2.766
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
				arg_150_0:Play1104106036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = "1041ui_story"

			if arg_150_1.actors_[var_153_0] == nil then
				local var_153_1 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_153_1) then
					local var_153_2 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_150_1.stage_.transform)

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

			local var_153_5 = arg_150_1.actors_["1041ui_story"].transform
			local var_153_6 = 0

			if var_153_6 < arg_150_1.time_ and arg_150_1.time_ <= var_153_6 + arg_153_0 then
				arg_150_1.var_.moveOldPos1041ui_story = var_153_5.localPosition
			end

			local var_153_7 = 0.001

			if var_153_6 <= arg_150_1.time_ and arg_150_1.time_ < var_153_6 + var_153_7 then
				local var_153_8 = (arg_150_1.time_ - var_153_6) / var_153_7
				local var_153_9 = Vector3.New(0, -1.11, -5.9)

				var_153_5.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1041ui_story, var_153_9, var_153_8)

				local var_153_10 = manager.ui.mainCamera.transform.position - var_153_5.position

				var_153_5.forward = Vector3.New(var_153_10.x, var_153_10.y, var_153_10.z)

				local var_153_11 = var_153_5.localEulerAngles

				var_153_11.z = 0
				var_153_11.x = 0
				var_153_5.localEulerAngles = var_153_11
			end

			if arg_150_1.time_ >= var_153_6 + var_153_7 and arg_150_1.time_ < var_153_6 + var_153_7 + arg_153_0 then
				var_153_5.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_153_12 = manager.ui.mainCamera.transform.position - var_153_5.position

				var_153_5.forward = Vector3.New(var_153_12.x, var_153_12.y, var_153_12.z)

				local var_153_13 = var_153_5.localEulerAngles

				var_153_13.z = 0
				var_153_13.x = 0
				var_153_5.localEulerAngles = var_153_13
			end

			local var_153_14 = arg_150_1.actors_["1041ui_story"]
			local var_153_15 = 0

			if var_153_15 < arg_150_1.time_ and arg_150_1.time_ <= var_153_15 + arg_153_0 and not isNil(var_153_14) and arg_150_1.var_.characterEffect1041ui_story == nil then
				arg_150_1.var_.characterEffect1041ui_story = var_153_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_16 = 0.200000002980232

			if var_153_15 <= arg_150_1.time_ and arg_150_1.time_ < var_153_15 + var_153_16 and not isNil(var_153_14) then
				local var_153_17 = (arg_150_1.time_ - var_153_15) / var_153_16

				if arg_150_1.var_.characterEffect1041ui_story and not isNil(var_153_14) then
					arg_150_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_15 + var_153_16 and arg_150_1.time_ < var_153_15 + var_153_16 + arg_153_0 and not isNil(var_153_14) and arg_150_1.var_.characterEffect1041ui_story then
				arg_150_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_153_18 = 0

			if var_153_18 < arg_150_1.time_ and arg_150_1.time_ <= var_153_18 + arg_153_0 then
				arg_150_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_153_19 = 0

			if var_153_19 < arg_150_1.time_ and arg_150_1.time_ <= var_153_19 + arg_153_0 then
				arg_150_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_153_20 = 0
			local var_153_21 = 0.375

			if var_153_20 < arg_150_1.time_ and arg_150_1.time_ <= var_153_20 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_22 = arg_150_1:FormatText(StoryNameCfg[208].name)

				arg_150_1.leftNameTxt_.text = var_153_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_23 = arg_150_1:GetWordFromCfg(1104106035)
				local var_153_24 = arg_150_1:FormatText(var_153_23.content)

				arg_150_1.text_.text = var_153_24

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_25 = 15
				local var_153_26 = utf8.len(var_153_24)
				local var_153_27 = var_153_25 <= 0 and var_153_21 or var_153_21 * (var_153_26 / var_153_25)

				if var_153_27 > 0 and var_153_21 < var_153_27 then
					arg_150_1.talkMaxDuration = var_153_27

					if var_153_27 + var_153_20 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_27 + var_153_20
					end
				end

				arg_150_1.text_.text = var_153_24
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106035", "story_v_side_new_1104106.awb") ~= 0 then
					local var_153_28 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106035", "story_v_side_new_1104106.awb") / 1000

					if var_153_28 + var_153_20 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_28 + var_153_20
					end

					if var_153_23.prefab_name ~= "" and arg_150_1.actors_[var_153_23.prefab_name] ~= nil then
						local var_153_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_23.prefab_name].transform, "story_v_side_new_1104106", "1104106035", "story_v_side_new_1104106.awb")

						arg_150_1:RecordAudio("1104106035", var_153_29)
						arg_150_1:RecordAudio("1104106035", var_153_29)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106035", "story_v_side_new_1104106.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106035", "story_v_side_new_1104106.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_30 = math.max(var_153_21, arg_150_1.talkMaxDuration)

			if var_153_20 <= arg_150_1.time_ and arg_150_1.time_ < var_153_20 + var_153_30 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_20) / var_153_30

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_20 + var_153_30 and arg_150_1.time_ < var_153_20 + var_153_30 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play1104106036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1104106036
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play1104106037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1041ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1041ui_story == nil then
				arg_154_1.var_.characterEffect1041ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect1041ui_story and not isNil(var_157_0) then
					local var_157_4 = Mathf.Lerp(0, 0.5, var_157_3)

					arg_154_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1041ui_story.fillRatio = var_157_4
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1041ui_story then
				local var_157_5 = 0.5

				arg_154_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1041ui_story.fillRatio = var_157_5
			end

			local var_157_6 = 0
			local var_157_7 = 0.425

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				local var_157_8 = "play"
				local var_157_9 = "music"

				arg_154_1:AudioAction(var_157_8, var_157_9, "ui_battle", "ui_battle_stopbgm", "")

				local var_157_10 = ""
				local var_157_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_157_11 ~= "" then
					if arg_154_1.bgmTxt_.text ~= var_157_11 and arg_154_1.bgmTxt_.text ~= "" then
						if arg_154_1.bgmTxt2_.text ~= "" then
							arg_154_1.bgmTxt_.text = arg_154_1.bgmTxt2_.text
						end

						arg_154_1.bgmTxt2_.text = var_157_11

						arg_154_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_154_1.bgmTxt_.text = var_157_11
						arg_154_1.bgmTxt2_.text = var_157_11
					end

					if arg_154_1.bgmTimer then
						arg_154_1.bgmTimer:Stop()

						arg_154_1.bgmTimer = nil
					end

					if arg_154_1.settingData.show_music_name == 1 then
						arg_154_1.musicController:SetSelectedState("show")
						arg_154_1.musicAnimator_:Play("open", 0, 0)

						if arg_154_1.settingData.music_time ~= 0 then
							arg_154_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_154_1.settingData.music_time), function()
								if arg_154_1 == nil or isNil(arg_154_1.bgmTxt_) then
									return
								end

								arg_154_1.musicController:SetSelectedState("hide")
								arg_154_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_157_12 = 1
			local var_157_13 = 0.466666666666667

			if var_157_12 < arg_154_1.time_ and arg_154_1.time_ <= var_157_12 + arg_157_0 then
				local var_157_14 = "play"
				local var_157_15 = "music"

				arg_154_1:AudioAction(var_157_14, var_157_15, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_157_16 = ""
				local var_157_17 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_157_17 ~= "" then
					if arg_154_1.bgmTxt_.text ~= var_157_17 and arg_154_1.bgmTxt_.text ~= "" then
						if arg_154_1.bgmTxt2_.text ~= "" then
							arg_154_1.bgmTxt_.text = arg_154_1.bgmTxt2_.text
						end

						arg_154_1.bgmTxt2_.text = var_157_17

						arg_154_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_154_1.bgmTxt_.text = var_157_17
						arg_154_1.bgmTxt2_.text = var_157_17
					end

					if arg_154_1.bgmTimer then
						arg_154_1.bgmTimer:Stop()

						arg_154_1.bgmTimer = nil
					end

					if arg_154_1.settingData.show_music_name == 1 then
						arg_154_1.musicController:SetSelectedState("show")
						arg_154_1.musicAnimator_:Play("open", 0, 0)

						if arg_154_1.settingData.music_time ~= 0 then
							arg_154_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_154_1.settingData.music_time), function()
								if arg_154_1 == nil or isNil(arg_154_1.bgmTxt_) then
									return
								end

								arg_154_1.musicController:SetSelectedState("hide")
								arg_154_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_157_18 = 0
			local var_157_19 = 0.85

			if var_157_18 < arg_154_1.time_ and arg_154_1.time_ <= var_157_18 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_20 = arg_154_1:GetWordFromCfg(1104106036)
				local var_157_21 = arg_154_1:FormatText(var_157_20.content)

				arg_154_1.text_.text = var_157_21

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_22 = 34
				local var_157_23 = utf8.len(var_157_21)
				local var_157_24 = var_157_22 <= 0 and var_157_19 or var_157_19 * (var_157_23 / var_157_22)

				if var_157_24 > 0 and var_157_19 < var_157_24 then
					arg_154_1.talkMaxDuration = var_157_24

					if var_157_24 + var_157_18 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_24 + var_157_18
					end
				end

				arg_154_1.text_.text = var_157_21
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_25 = math.max(var_157_19, arg_154_1.talkMaxDuration)

			if var_157_18 <= arg_154_1.time_ and arg_154_1.time_ < var_157_18 + var_157_25 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_18) / var_157_25

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_18 + var_157_25 and arg_154_1.time_ < var_157_18 + var_157_25 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play1104106037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1104106037
		arg_160_1.duration_ = 3.43

		local var_160_0 = {
			zh = 1.6,
			ja = 3.433
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1104106038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1041ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1041ui_story == nil then
				arg_160_1.var_.characterEffect1041ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1041ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1041ui_story then
				arg_160_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_163_4 = 0
			local var_163_5 = 0.2

			if var_163_4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_6 = arg_160_1:FormatText(StoryNameCfg[208].name)

				arg_160_1.leftNameTxt_.text = var_163_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_7 = arg_160_1:GetWordFromCfg(1104106037)
				local var_163_8 = arg_160_1:FormatText(var_163_7.content)

				arg_160_1.text_.text = var_163_8

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_9 = 8
				local var_163_10 = utf8.len(var_163_8)
				local var_163_11 = var_163_9 <= 0 and var_163_5 or var_163_5 * (var_163_10 / var_163_9)

				if var_163_11 > 0 and var_163_5 < var_163_11 then
					arg_160_1.talkMaxDuration = var_163_11

					if var_163_11 + var_163_4 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_11 + var_163_4
					end
				end

				arg_160_1.text_.text = var_163_8
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106037", "story_v_side_new_1104106.awb") ~= 0 then
					local var_163_12 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106037", "story_v_side_new_1104106.awb") / 1000

					if var_163_12 + var_163_4 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_12 + var_163_4
					end

					if var_163_7.prefab_name ~= "" and arg_160_1.actors_[var_163_7.prefab_name] ~= nil then
						local var_163_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_7.prefab_name].transform, "story_v_side_new_1104106", "1104106037", "story_v_side_new_1104106.awb")

						arg_160_1:RecordAudio("1104106037", var_163_13)
						arg_160_1:RecordAudio("1104106037", var_163_13)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106037", "story_v_side_new_1104106.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106037", "story_v_side_new_1104106.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_14 = math.max(var_163_5, arg_160_1.talkMaxDuration)

			if var_163_4 <= arg_160_1.time_ and arg_160_1.time_ < var_163_4 + var_163_14 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_4) / var_163_14

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_4 + var_163_14 and arg_160_1.time_ < var_163_4 + var_163_14 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play1104106038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1104106038
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1104106039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1041ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1041ui_story == nil then
				arg_164_1.var_.characterEffect1041ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1041ui_story and not isNil(var_167_0) then
					local var_167_4 = Mathf.Lerp(0, 0.5, var_167_3)

					arg_164_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1041ui_story.fillRatio = var_167_4
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1041ui_story then
				local var_167_5 = 0.5

				arg_164_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1041ui_story.fillRatio = var_167_5
			end

			local var_167_6 = 0
			local var_167_7 = 0.9

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_8 = arg_164_1:FormatText(StoryNameCfg[7].name)

				arg_164_1.leftNameTxt_.text = var_167_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_9 = arg_164_1:GetWordFromCfg(1104106038)
				local var_167_10 = arg_164_1:FormatText(var_167_9.content)

				arg_164_1.text_.text = var_167_10

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 36
				local var_167_12 = utf8.len(var_167_10)
				local var_167_13 = var_167_11 <= 0 and var_167_7 or var_167_7 * (var_167_12 / var_167_11)

				if var_167_13 > 0 and var_167_7 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13

					if var_167_13 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_10
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_14 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_14 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_14

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_14 and arg_164_1.time_ < var_167_6 + var_167_14 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play1104106039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1104106039
		arg_168_1.duration_ = 4.07

		local var_168_0 = {
			zh = 4,
			ja = 4.066
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
				arg_168_0:Play1104106040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1041ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1041ui_story == nil then
				arg_168_1.var_.characterEffect1041ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect1041ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1041ui_story then
				arg_168_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_171_4 = 0
			local var_171_5 = 0.4

			if var_171_4 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_6 = arg_168_1:FormatText(StoryNameCfg[208].name)

				arg_168_1.leftNameTxt_.text = var_171_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_7 = arg_168_1:GetWordFromCfg(1104106039)
				local var_171_8 = arg_168_1:FormatText(var_171_7.content)

				arg_168_1.text_.text = var_171_8

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_9 = 16
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106039", "story_v_side_new_1104106.awb") ~= 0 then
					local var_171_12 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106039", "story_v_side_new_1104106.awb") / 1000

					if var_171_12 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_12 + var_171_4
					end

					if var_171_7.prefab_name ~= "" and arg_168_1.actors_[var_171_7.prefab_name] ~= nil then
						local var_171_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_7.prefab_name].transform, "story_v_side_new_1104106", "1104106039", "story_v_side_new_1104106.awb")

						arg_168_1:RecordAudio("1104106039", var_171_13)
						arg_168_1:RecordAudio("1104106039", var_171_13)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106039", "story_v_side_new_1104106.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106039", "story_v_side_new_1104106.awb")
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
	Play1104106040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1104106040
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1104106041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1041ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1041ui_story == nil then
				arg_172_1.var_.characterEffect1041ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1041ui_story and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1041ui_story.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1041ui_story then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1041ui_story.fillRatio = var_175_5
			end

			local var_175_6 = 0

			if var_175_6 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_175_7 = 0
			local var_175_8 = 0.425

			if var_175_7 < arg_172_1.time_ and arg_172_1.time_ <= var_175_7 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_9 = arg_172_1:GetWordFromCfg(1104106040)
				local var_175_10 = arg_172_1:FormatText(var_175_9.content)

				arg_172_1.text_.text = var_175_10

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_11 = 17
				local var_175_12 = utf8.len(var_175_10)
				local var_175_13 = var_175_11 <= 0 and var_175_8 or var_175_8 * (var_175_12 / var_175_11)

				if var_175_13 > 0 and var_175_8 < var_175_13 then
					arg_172_1.talkMaxDuration = var_175_13

					if var_175_13 + var_175_7 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_13 + var_175_7
					end
				end

				arg_172_1.text_.text = var_175_10
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_14 = math.max(var_175_8, arg_172_1.talkMaxDuration)

			if var_175_7 <= arg_172_1.time_ and arg_172_1.time_ < var_175_7 + var_175_14 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_7) / var_175_14

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_7 + var_175_14 and arg_172_1.time_ < var_175_7 + var_175_14 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play1104106041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1104106041
		arg_176_1.duration_ = 12.23

		local var_176_0 = {
			zh = 9.233,
			ja = 12.233
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1104106042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1041ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1041ui_story == nil then
				arg_176_1.var_.characterEffect1041ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1041ui_story and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1041ui_story then
				arg_176_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_179_4 = 0
			local var_179_5 = 1.075

			if var_179_4 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_6 = arg_176_1:FormatText(StoryNameCfg[208].name)

				arg_176_1.leftNameTxt_.text = var_179_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_7 = arg_176_1:GetWordFromCfg(1104106041)
				local var_179_8 = arg_176_1:FormatText(var_179_7.content)

				arg_176_1.text_.text = var_179_8

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_9 = 43
				local var_179_10 = utf8.len(var_179_8)
				local var_179_11 = var_179_9 <= 0 and var_179_5 or var_179_5 * (var_179_10 / var_179_9)

				if var_179_11 > 0 and var_179_5 < var_179_11 then
					arg_176_1.talkMaxDuration = var_179_11

					if var_179_11 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_11 + var_179_4
					end
				end

				arg_176_1.text_.text = var_179_8
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106041", "story_v_side_new_1104106.awb") ~= 0 then
					local var_179_12 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106041", "story_v_side_new_1104106.awb") / 1000

					if var_179_12 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_12 + var_179_4
					end

					if var_179_7.prefab_name ~= "" and arg_176_1.actors_[var_179_7.prefab_name] ~= nil then
						local var_179_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_7.prefab_name].transform, "story_v_side_new_1104106", "1104106041", "story_v_side_new_1104106.awb")

						arg_176_1:RecordAudio("1104106041", var_179_13)
						arg_176_1:RecordAudio("1104106041", var_179_13)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106041", "story_v_side_new_1104106.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106041", "story_v_side_new_1104106.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_14 = math.max(var_179_5, arg_176_1.talkMaxDuration)

			if var_179_4 <= arg_176_1.time_ and arg_176_1.time_ < var_179_4 + var_179_14 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_4) / var_179_14

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_4 + var_179_14 and arg_176_1.time_ < var_179_4 + var_179_14 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play1104106042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1104106042
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1104106043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1041ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1041ui_story == nil then
				arg_180_1.var_.characterEffect1041ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1041ui_story and not isNil(var_183_0) then
					local var_183_4 = Mathf.Lerp(0, 0.5, var_183_3)

					arg_180_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1041ui_story.fillRatio = var_183_4
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1041ui_story then
				local var_183_5 = 0.5

				arg_180_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1041ui_story.fillRatio = var_183_5
			end

			local var_183_6 = 0
			local var_183_7 = 1.475

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_8 = arg_180_1:FormatText(StoryNameCfg[7].name)

				arg_180_1.leftNameTxt_.text = var_183_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_9 = arg_180_1:GetWordFromCfg(1104106042)
				local var_183_10 = arg_180_1:FormatText(var_183_9.content)

				arg_180_1.text_.text = var_183_10

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 59
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
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_14 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_14 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_14

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_14 and arg_180_1.time_ < var_183_6 + var_183_14 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play1104106043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1104106043
		arg_184_1.duration_ = 11.13

		local var_184_0 = {
			zh = 11.133,
			ja = 8.2
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1104106044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1041ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1041ui_story == nil then
				arg_184_1.var_.characterEffect1041ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1041ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1041ui_story then
				arg_184_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_187_4 = 0
			local var_187_5 = 1.025

			if var_187_4 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_6 = arg_184_1:FormatText(StoryNameCfg[208].name)

				arg_184_1.leftNameTxt_.text = var_187_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_7 = arg_184_1:GetWordFromCfg(1104106043)
				local var_187_8 = arg_184_1:FormatText(var_187_7.content)

				arg_184_1.text_.text = var_187_8

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_9 = 41
				local var_187_10 = utf8.len(var_187_8)
				local var_187_11 = var_187_9 <= 0 and var_187_5 or var_187_5 * (var_187_10 / var_187_9)

				if var_187_11 > 0 and var_187_5 < var_187_11 then
					arg_184_1.talkMaxDuration = var_187_11

					if var_187_11 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_11 + var_187_4
					end
				end

				arg_184_1.text_.text = var_187_8
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106043", "story_v_side_new_1104106.awb") ~= 0 then
					local var_187_12 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106043", "story_v_side_new_1104106.awb") / 1000

					if var_187_12 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_12 + var_187_4
					end

					if var_187_7.prefab_name ~= "" and arg_184_1.actors_[var_187_7.prefab_name] ~= nil then
						local var_187_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_7.prefab_name].transform, "story_v_side_new_1104106", "1104106043", "story_v_side_new_1104106.awb")

						arg_184_1:RecordAudio("1104106043", var_187_13)
						arg_184_1:RecordAudio("1104106043", var_187_13)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106043", "story_v_side_new_1104106.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106043", "story_v_side_new_1104106.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_14 = math.max(var_187_5, arg_184_1.talkMaxDuration)

			if var_187_4 <= arg_184_1.time_ and arg_184_1.time_ < var_187_4 + var_187_14 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_4) / var_187_14

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_4 + var_187_14 and arg_184_1.time_ < var_187_4 + var_187_14 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play1104106044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1104106044
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1104106045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1041ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1041ui_story == nil then
				arg_188_1.var_.characterEffect1041ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect1041ui_story and not isNil(var_191_0) then
					local var_191_4 = Mathf.Lerp(0, 0.5, var_191_3)

					arg_188_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1041ui_story.fillRatio = var_191_4
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1041ui_story then
				local var_191_5 = 0.5

				arg_188_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1041ui_story.fillRatio = var_191_5
			end

			local var_191_6 = 0
			local var_191_7 = 0.5

			if var_191_6 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_8 = arg_188_1:FormatText(StoryNameCfg[7].name)

				arg_188_1.leftNameTxt_.text = var_191_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_9 = arg_188_1:GetWordFromCfg(1104106044)
				local var_191_10 = arg_188_1:FormatText(var_191_9.content)

				arg_188_1.text_.text = var_191_10

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_11 = 20
				local var_191_12 = utf8.len(var_191_10)
				local var_191_13 = var_191_11 <= 0 and var_191_7 or var_191_7 * (var_191_12 / var_191_11)

				if var_191_13 > 0 and var_191_7 < var_191_13 then
					arg_188_1.talkMaxDuration = var_191_13

					if var_191_13 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_13 + var_191_6
					end
				end

				arg_188_1.text_.text = var_191_10
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_14 = math.max(var_191_7, arg_188_1.talkMaxDuration)

			if var_191_6 <= arg_188_1.time_ and arg_188_1.time_ < var_191_6 + var_191_14 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_6) / var_191_14

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_6 + var_191_14 and arg_188_1.time_ < var_191_6 + var_191_14 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play1104106045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1104106045
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1104106046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 0.675

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

				local var_195_2 = arg_192_1:GetWordFromCfg(1104106045)
				local var_195_3 = arg_192_1:FormatText(var_195_2.content)

				arg_192_1.text_.text = var_195_3

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_4 = 27
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
	Play1104106046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 1104106046
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play1104106047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 0.45

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_2 = arg_196_1:FormatText(StoryNameCfg[7].name)

				arg_196_1.leftNameTxt_.text = var_199_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_3 = arg_196_1:GetWordFromCfg(1104106046)
				local var_199_4 = arg_196_1:FormatText(var_199_3.content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 18
				local var_199_6 = utf8.len(var_199_4)
				local var_199_7 = var_199_5 <= 0 and var_199_1 or var_199_1 * (var_199_6 / var_199_5)

				if var_199_7 > 0 and var_199_1 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_8 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_8 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_8

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_8 and arg_196_1.time_ < var_199_0 + var_199_8 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play1104106047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1104106047
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1104106048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 0.825

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_2 = arg_200_1:GetWordFromCfg(1104106047)
				local var_203_3 = arg_200_1:FormatText(var_203_2.content)

				arg_200_1.text_.text = var_203_3

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 33
				local var_203_5 = utf8.len(var_203_3)
				local var_203_6 = var_203_4 <= 0 and var_203_1 or var_203_1 * (var_203_5 / var_203_4)

				if var_203_6 > 0 and var_203_1 < var_203_6 then
					arg_200_1.talkMaxDuration = var_203_6

					if var_203_6 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_6 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_3
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_7 and arg_200_1.time_ < var_203_0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play1104106048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1104106048
		arg_204_1.duration_ = 2.63

		local var_204_0 = {
			zh = 2.233,
			ja = 2.633
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1104106049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1041ui_story"].transform
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.var_.moveOldPos1041ui_story = var_207_0.localPosition
			end

			local var_207_2 = 0.001

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2
				local var_207_4 = Vector3.New(0, -1.11, -5.9)

				var_207_0.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1041ui_story, var_207_4, var_207_3)

				local var_207_5 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_5.x, var_207_5.y, var_207_5.z)

				local var_207_6 = var_207_0.localEulerAngles

				var_207_6.z = 0
				var_207_6.x = 0
				var_207_0.localEulerAngles = var_207_6
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 then
				var_207_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_207_7 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_7.x, var_207_7.y, var_207_7.z)

				local var_207_8 = var_207_0.localEulerAngles

				var_207_8.z = 0
				var_207_8.x = 0
				var_207_0.localEulerAngles = var_207_8
			end

			local var_207_9 = arg_204_1.actors_["1041ui_story"]
			local var_207_10 = 0

			if var_207_10 < arg_204_1.time_ and arg_204_1.time_ <= var_207_10 + arg_207_0 and not isNil(var_207_9) and arg_204_1.var_.characterEffect1041ui_story == nil then
				arg_204_1.var_.characterEffect1041ui_story = var_207_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_11 = 0.200000002980232

			if var_207_10 <= arg_204_1.time_ and arg_204_1.time_ < var_207_10 + var_207_11 and not isNil(var_207_9) then
				local var_207_12 = (arg_204_1.time_ - var_207_10) / var_207_11

				if arg_204_1.var_.characterEffect1041ui_story and not isNil(var_207_9) then
					arg_204_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_10 + var_207_11 and arg_204_1.time_ < var_207_10 + var_207_11 + arg_207_0 and not isNil(var_207_9) and arg_204_1.var_.characterEffect1041ui_story then
				arg_204_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_207_13 = 0

			if var_207_13 < arg_204_1.time_ and arg_204_1.time_ <= var_207_13 + arg_207_0 then
				arg_204_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_1")
			end

			local var_207_14 = 0

			if var_207_14 < arg_204_1.time_ and arg_204_1.time_ <= var_207_14 + arg_207_0 then
				arg_204_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_207_15 = 0
			local var_207_16 = 0.275

			if var_207_15 < arg_204_1.time_ and arg_204_1.time_ <= var_207_15 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_17 = arg_204_1:FormatText(StoryNameCfg[208].name)

				arg_204_1.leftNameTxt_.text = var_207_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_18 = arg_204_1:GetWordFromCfg(1104106048)
				local var_207_19 = arg_204_1:FormatText(var_207_18.content)

				arg_204_1.text_.text = var_207_19

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_20 = 11
				local var_207_21 = utf8.len(var_207_19)
				local var_207_22 = var_207_20 <= 0 and var_207_16 or var_207_16 * (var_207_21 / var_207_20)

				if var_207_22 > 0 and var_207_16 < var_207_22 then
					arg_204_1.talkMaxDuration = var_207_22

					if var_207_22 + var_207_15 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_22 + var_207_15
					end
				end

				arg_204_1.text_.text = var_207_19
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106048", "story_v_side_new_1104106.awb") ~= 0 then
					local var_207_23 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106048", "story_v_side_new_1104106.awb") / 1000

					if var_207_23 + var_207_15 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_23 + var_207_15
					end

					if var_207_18.prefab_name ~= "" and arg_204_1.actors_[var_207_18.prefab_name] ~= nil then
						local var_207_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_18.prefab_name].transform, "story_v_side_new_1104106", "1104106048", "story_v_side_new_1104106.awb")

						arg_204_1:RecordAudio("1104106048", var_207_24)
						arg_204_1:RecordAudio("1104106048", var_207_24)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106048", "story_v_side_new_1104106.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106048", "story_v_side_new_1104106.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_25 = math.max(var_207_16, arg_204_1.talkMaxDuration)

			if var_207_15 <= arg_204_1.time_ and arg_204_1.time_ < var_207_15 + var_207_25 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_15) / var_207_25

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_15 + var_207_25 and arg_204_1.time_ < var_207_15 + var_207_25 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play1104106049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1104106049
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1104106050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1041ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1041ui_story == nil then
				arg_208_1.var_.characterEffect1041ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect1041ui_story and not isNil(var_211_0) then
					local var_211_4 = Mathf.Lerp(0, 0.5, var_211_3)

					arg_208_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1041ui_story.fillRatio = var_211_4
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1041ui_story then
				local var_211_5 = 0.5

				arg_208_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1041ui_story.fillRatio = var_211_5
			end

			local var_211_6 = 0
			local var_211_7 = 0.075

			if var_211_6 < arg_208_1.time_ and arg_208_1.time_ <= var_211_6 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_8 = arg_208_1:FormatText(StoryNameCfg[7].name)

				arg_208_1.leftNameTxt_.text = var_211_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_9 = arg_208_1:GetWordFromCfg(1104106049)
				local var_211_10 = arg_208_1:FormatText(var_211_9.content)

				arg_208_1.text_.text = var_211_10

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_11 = 3
				local var_211_12 = utf8.len(var_211_10)
				local var_211_13 = var_211_11 <= 0 and var_211_7 or var_211_7 * (var_211_12 / var_211_11)

				if var_211_13 > 0 and var_211_7 < var_211_13 then
					arg_208_1.talkMaxDuration = var_211_13

					if var_211_13 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_13 + var_211_6
					end
				end

				arg_208_1.text_.text = var_211_10
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_14 = math.max(var_211_7, arg_208_1.talkMaxDuration)

			if var_211_6 <= arg_208_1.time_ and arg_208_1.time_ < var_211_6 + var_211_14 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_6) / var_211_14

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_6 + var_211_14 and arg_208_1.time_ < var_211_6 + var_211_14 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play1104106050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 1104106050
		arg_212_1.duration_ = 5.7

		local var_212_0 = {
			zh = 5.066,
			ja = 5.7
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play1104106051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1041ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1041ui_story == nil then
				arg_212_1.var_.characterEffect1041ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect1041ui_story and not isNil(var_215_0) then
					arg_212_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1041ui_story then
				arg_212_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_215_4 = 0
			local var_215_5 = 0.625

			if var_215_4 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_6 = arg_212_1:FormatText(StoryNameCfg[208].name)

				arg_212_1.leftNameTxt_.text = var_215_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_7 = arg_212_1:GetWordFromCfg(1104106050)
				local var_215_8 = arg_212_1:FormatText(var_215_7.content)

				arg_212_1.text_.text = var_215_8

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_9 = 25
				local var_215_10 = utf8.len(var_215_8)
				local var_215_11 = var_215_9 <= 0 and var_215_5 or var_215_5 * (var_215_10 / var_215_9)

				if var_215_11 > 0 and var_215_5 < var_215_11 then
					arg_212_1.talkMaxDuration = var_215_11

					if var_215_11 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_11 + var_215_4
					end
				end

				arg_212_1.text_.text = var_215_8
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106050", "story_v_side_new_1104106.awb") ~= 0 then
					local var_215_12 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106050", "story_v_side_new_1104106.awb") / 1000

					if var_215_12 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_12 + var_215_4
					end

					if var_215_7.prefab_name ~= "" and arg_212_1.actors_[var_215_7.prefab_name] ~= nil then
						local var_215_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_7.prefab_name].transform, "story_v_side_new_1104106", "1104106050", "story_v_side_new_1104106.awb")

						arg_212_1:RecordAudio("1104106050", var_215_13)
						arg_212_1:RecordAudio("1104106050", var_215_13)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106050", "story_v_side_new_1104106.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106050", "story_v_side_new_1104106.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_14 = math.max(var_215_5, arg_212_1.talkMaxDuration)

			if var_215_4 <= arg_212_1.time_ and arg_212_1.time_ < var_215_4 + var_215_14 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_4) / var_215_14

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_4 + var_215_14 and arg_212_1.time_ < var_215_4 + var_215_14 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play1104106051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 1104106051
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play1104106052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1041ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1041ui_story == nil then
				arg_216_1.var_.characterEffect1041ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect1041ui_story and not isNil(var_219_0) then
					local var_219_4 = Mathf.Lerp(0, 0.5, var_219_3)

					arg_216_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1041ui_story.fillRatio = var_219_4
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1041ui_story then
				local var_219_5 = 0.5

				arg_216_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1041ui_story.fillRatio = var_219_5
			end

			local var_219_6 = 0
			local var_219_7 = 0.4

			if var_219_6 < arg_216_1.time_ and arg_216_1.time_ <= var_219_6 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_8 = arg_216_1:FormatText(StoryNameCfg[7].name)

				arg_216_1.leftNameTxt_.text = var_219_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_9 = arg_216_1:GetWordFromCfg(1104106051)
				local var_219_10 = arg_216_1:FormatText(var_219_9.content)

				arg_216_1.text_.text = var_219_10

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_11 = 16
				local var_219_12 = utf8.len(var_219_10)
				local var_219_13 = var_219_11 <= 0 and var_219_7 or var_219_7 * (var_219_12 / var_219_11)

				if var_219_13 > 0 and var_219_7 < var_219_13 then
					arg_216_1.talkMaxDuration = var_219_13

					if var_219_13 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_13 + var_219_6
					end
				end

				arg_216_1.text_.text = var_219_10
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_14 = math.max(var_219_7, arg_216_1.talkMaxDuration)

			if var_219_6 <= arg_216_1.time_ and arg_216_1.time_ < var_219_6 + var_219_14 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_6) / var_219_14

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_6 + var_219_14 and arg_216_1.time_ < var_219_6 + var_219_14 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play1104106052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 1104106052
		arg_220_1.duration_ = 6.2

		local var_220_0 = {
			zh = 6.2,
			ja = 5.433
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play1104106053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1041ui_story"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1041ui_story == nil then
				arg_220_1.var_.characterEffect1041ui_story = var_223_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.characterEffect1041ui_story and not isNil(var_223_0) then
					arg_220_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1041ui_story then
				arg_220_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_223_4 = 0

			if var_223_4 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_2")
			end

			local var_223_5 = 0

			if var_223_5 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 then
				arg_220_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_223_6 = 0
			local var_223_7 = 0.5

			if var_223_6 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_8 = arg_220_1:FormatText(StoryNameCfg[208].name)

				arg_220_1.leftNameTxt_.text = var_223_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_9 = arg_220_1:GetWordFromCfg(1104106052)
				local var_223_10 = arg_220_1:FormatText(var_223_9.content)

				arg_220_1.text_.text = var_223_10

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_11 = 20
				local var_223_12 = utf8.len(var_223_10)
				local var_223_13 = var_223_11 <= 0 and var_223_7 or var_223_7 * (var_223_12 / var_223_11)

				if var_223_13 > 0 and var_223_7 < var_223_13 then
					arg_220_1.talkMaxDuration = var_223_13

					if var_223_13 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_13 + var_223_6
					end
				end

				arg_220_1.text_.text = var_223_10
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106052", "story_v_side_new_1104106.awb") ~= 0 then
					local var_223_14 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106052", "story_v_side_new_1104106.awb") / 1000

					if var_223_14 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_14 + var_223_6
					end

					if var_223_9.prefab_name ~= "" and arg_220_1.actors_[var_223_9.prefab_name] ~= nil then
						local var_223_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_9.prefab_name].transform, "story_v_side_new_1104106", "1104106052", "story_v_side_new_1104106.awb")

						arg_220_1:RecordAudio("1104106052", var_223_15)
						arg_220_1:RecordAudio("1104106052", var_223_15)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106052", "story_v_side_new_1104106.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106052", "story_v_side_new_1104106.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_16 = math.max(var_223_7, arg_220_1.talkMaxDuration)

			if var_223_6 <= arg_220_1.time_ and arg_220_1.time_ < var_223_6 + var_223_16 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_6) / var_223_16

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_6 + var_223_16 and arg_220_1.time_ < var_223_6 + var_223_16 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play1104106053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 1104106053
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play1104106054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1041ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1041ui_story == nil then
				arg_224_1.var_.characterEffect1041ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect1041ui_story and not isNil(var_227_0) then
					local var_227_4 = Mathf.Lerp(0, 0.5, var_227_3)

					arg_224_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1041ui_story.fillRatio = var_227_4
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1041ui_story then
				local var_227_5 = 0.5

				arg_224_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1041ui_story.fillRatio = var_227_5
			end

			local var_227_6 = 0
			local var_227_7 = 0.875

			if var_227_6 < arg_224_1.time_ and arg_224_1.time_ <= var_227_6 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_8 = arg_224_1:FormatText(StoryNameCfg[7].name)

				arg_224_1.leftNameTxt_.text = var_227_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_9 = arg_224_1:GetWordFromCfg(1104106053)
				local var_227_10 = arg_224_1:FormatText(var_227_9.content)

				arg_224_1.text_.text = var_227_10

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_11 = 35
				local var_227_12 = utf8.len(var_227_10)
				local var_227_13 = var_227_11 <= 0 and var_227_7 or var_227_7 * (var_227_12 / var_227_11)

				if var_227_13 > 0 and var_227_7 < var_227_13 then
					arg_224_1.talkMaxDuration = var_227_13

					if var_227_13 + var_227_6 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_13 + var_227_6
					end
				end

				arg_224_1.text_.text = var_227_10
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_14 = math.max(var_227_7, arg_224_1.talkMaxDuration)

			if var_227_6 <= arg_224_1.time_ and arg_224_1.time_ < var_227_6 + var_227_14 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_6) / var_227_14

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_6 + var_227_14 and arg_224_1.time_ < var_227_6 + var_227_14 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play1104106054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1104106054
		arg_228_1.duration_ = 10

		local var_228_0 = {
			zh = 6.8,
			ja = 10
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play1104106055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1041ui_story"].transform
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.var_.moveOldPos1041ui_story = var_231_0.localPosition
			end

			local var_231_2 = 0.001

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2
				local var_231_4 = Vector3.New(0, -1.11, -5.9)

				var_231_0.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1041ui_story, var_231_4, var_231_3)

				local var_231_5 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_5.x, var_231_5.y, var_231_5.z)

				local var_231_6 = var_231_0.localEulerAngles

				var_231_6.z = 0
				var_231_6.x = 0
				var_231_0.localEulerAngles = var_231_6
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 then
				var_231_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_231_7 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_7.x, var_231_7.y, var_231_7.z)

				local var_231_8 = var_231_0.localEulerAngles

				var_231_8.z = 0
				var_231_8.x = 0
				var_231_0.localEulerAngles = var_231_8
			end

			local var_231_9 = arg_228_1.actors_["1041ui_story"]
			local var_231_10 = 0

			if var_231_10 < arg_228_1.time_ and arg_228_1.time_ <= var_231_10 + arg_231_0 and not isNil(var_231_9) and arg_228_1.var_.characterEffect1041ui_story == nil then
				arg_228_1.var_.characterEffect1041ui_story = var_231_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_11 = 0.200000002980232

			if var_231_10 <= arg_228_1.time_ and arg_228_1.time_ < var_231_10 + var_231_11 and not isNil(var_231_9) then
				local var_231_12 = (arg_228_1.time_ - var_231_10) / var_231_11

				if arg_228_1.var_.characterEffect1041ui_story and not isNil(var_231_9) then
					arg_228_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_10 + var_231_11 and arg_228_1.time_ < var_231_10 + var_231_11 + arg_231_0 and not isNil(var_231_9) and arg_228_1.var_.characterEffect1041ui_story then
				arg_228_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_231_13 = 0

			if var_231_13 < arg_228_1.time_ and arg_228_1.time_ <= var_231_13 + arg_231_0 then
				arg_228_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_231_14 = 0
			local var_231_15 = 0.6

			if var_231_14 < arg_228_1.time_ and arg_228_1.time_ <= var_231_14 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_16 = arg_228_1:FormatText(StoryNameCfg[208].name)

				arg_228_1.leftNameTxt_.text = var_231_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_17 = arg_228_1:GetWordFromCfg(1104106054)
				local var_231_18 = arg_228_1:FormatText(var_231_17.content)

				arg_228_1.text_.text = var_231_18

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_19 = 24
				local var_231_20 = utf8.len(var_231_18)
				local var_231_21 = var_231_19 <= 0 and var_231_15 or var_231_15 * (var_231_20 / var_231_19)

				if var_231_21 > 0 and var_231_15 < var_231_21 then
					arg_228_1.talkMaxDuration = var_231_21

					if var_231_21 + var_231_14 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_21 + var_231_14
					end
				end

				arg_228_1.text_.text = var_231_18
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106054", "story_v_side_new_1104106.awb") ~= 0 then
					local var_231_22 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106054", "story_v_side_new_1104106.awb") / 1000

					if var_231_22 + var_231_14 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_22 + var_231_14
					end

					if var_231_17.prefab_name ~= "" and arg_228_1.actors_[var_231_17.prefab_name] ~= nil then
						local var_231_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_17.prefab_name].transform, "story_v_side_new_1104106", "1104106054", "story_v_side_new_1104106.awb")

						arg_228_1:RecordAudio("1104106054", var_231_23)
						arg_228_1:RecordAudio("1104106054", var_231_23)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106054", "story_v_side_new_1104106.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106054", "story_v_side_new_1104106.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_24 = math.max(var_231_15, arg_228_1.talkMaxDuration)

			if var_231_14 <= arg_228_1.time_ and arg_228_1.time_ < var_231_14 + var_231_24 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_14) / var_231_24

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_14 + var_231_24 and arg_228_1.time_ < var_231_14 + var_231_24 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play1104106055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 1104106055
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play1104106056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1041ui_story"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1041ui_story == nil then
				arg_232_1.var_.characterEffect1041ui_story = var_235_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.characterEffect1041ui_story and not isNil(var_235_0) then
					local var_235_4 = Mathf.Lerp(0, 0.5, var_235_3)

					arg_232_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1041ui_story.fillRatio = var_235_4
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1041ui_story then
				local var_235_5 = 0.5

				arg_232_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1041ui_story.fillRatio = var_235_5
			end

			local var_235_6 = 0
			local var_235_7 = 0.675

			if var_235_6 < arg_232_1.time_ and arg_232_1.time_ <= var_235_6 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_8 = arg_232_1:GetWordFromCfg(1104106055)
				local var_235_9 = arg_232_1:FormatText(var_235_8.content)

				arg_232_1.text_.text = var_235_9

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_10 = 27
				local var_235_11 = utf8.len(var_235_9)
				local var_235_12 = var_235_10 <= 0 and var_235_7 or var_235_7 * (var_235_11 / var_235_10)

				if var_235_12 > 0 and var_235_7 < var_235_12 then
					arg_232_1.talkMaxDuration = var_235_12

					if var_235_12 + var_235_6 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_12 + var_235_6
					end
				end

				arg_232_1.text_.text = var_235_9
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_13 = math.max(var_235_7, arg_232_1.talkMaxDuration)

			if var_235_6 <= arg_232_1.time_ and arg_232_1.time_ < var_235_6 + var_235_13 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_6) / var_235_13

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_6 + var_235_13 and arg_232_1.time_ < var_235_6 + var_235_13 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play1104106056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 1104106056
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play1104106057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 0.275

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_2 = arg_236_1:FormatText(StoryNameCfg[7].name)

				arg_236_1.leftNameTxt_.text = var_239_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_3 = arg_236_1:GetWordFromCfg(1104106056)
				local var_239_4 = arg_236_1:FormatText(var_239_3.content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 11
				local var_239_6 = utf8.len(var_239_4)
				local var_239_7 = var_239_5 <= 0 and var_239_1 or var_239_1 * (var_239_6 / var_239_5)

				if var_239_7 > 0 and var_239_1 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_4
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_8 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_8 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_8

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_8 and arg_236_1.time_ < var_239_0 + var_239_8 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play1104106057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 1104106057
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play1104106058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 0.9

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_2 = arg_240_1:GetWordFromCfg(1104106057)
				local var_243_3 = arg_240_1:FormatText(var_243_2.content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 36
				local var_243_5 = utf8.len(var_243_3)
				local var_243_6 = var_243_4 <= 0 and var_243_1 or var_243_1 * (var_243_5 / var_243_4)

				if var_243_6 > 0 and var_243_1 < var_243_6 then
					arg_240_1.talkMaxDuration = var_243_6

					if var_243_6 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_6 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_7 and arg_240_1.time_ < var_243_0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play1104106058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 1104106058
		arg_244_1.duration_ = 11.7

		local var_244_0 = {
			zh = 11.7,
			ja = 10.166
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
				arg_244_0:Play1104106059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1041ui_story"].transform
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.var_.moveOldPos1041ui_story = var_247_0.localPosition
			end

			local var_247_2 = 0.001

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2
				local var_247_4 = Vector3.New(0, -1.11, -5.9)

				var_247_0.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1041ui_story, var_247_4, var_247_3)

				local var_247_5 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_5.x, var_247_5.y, var_247_5.z)

				local var_247_6 = var_247_0.localEulerAngles

				var_247_6.z = 0
				var_247_6.x = 0
				var_247_0.localEulerAngles = var_247_6
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 then
				var_247_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_247_7 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_7.x, var_247_7.y, var_247_7.z)

				local var_247_8 = var_247_0.localEulerAngles

				var_247_8.z = 0
				var_247_8.x = 0
				var_247_0.localEulerAngles = var_247_8
			end

			local var_247_9 = arg_244_1.actors_["1041ui_story"]
			local var_247_10 = 0

			if var_247_10 < arg_244_1.time_ and arg_244_1.time_ <= var_247_10 + arg_247_0 and not isNil(var_247_9) and arg_244_1.var_.characterEffect1041ui_story == nil then
				arg_244_1.var_.characterEffect1041ui_story = var_247_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_11 = 0.200000002980232

			if var_247_10 <= arg_244_1.time_ and arg_244_1.time_ < var_247_10 + var_247_11 and not isNil(var_247_9) then
				local var_247_12 = (arg_244_1.time_ - var_247_10) / var_247_11

				if arg_244_1.var_.characterEffect1041ui_story and not isNil(var_247_9) then
					arg_244_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= var_247_10 + var_247_11 and arg_244_1.time_ < var_247_10 + var_247_11 + arg_247_0 and not isNil(var_247_9) and arg_244_1.var_.characterEffect1041ui_story then
				arg_244_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_247_13 = 0

			if var_247_13 < arg_244_1.time_ and arg_244_1.time_ <= var_247_13 + arg_247_0 then
				arg_244_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action5_1")
			end

			local var_247_14 = 0

			if var_247_14 < arg_244_1.time_ and arg_244_1.time_ <= var_247_14 + arg_247_0 then
				arg_244_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_247_15 = 0
			local var_247_16 = 1.675

			if var_247_15 < arg_244_1.time_ and arg_244_1.time_ <= var_247_15 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_17 = arg_244_1:FormatText(StoryNameCfg[208].name)

				arg_244_1.leftNameTxt_.text = var_247_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_18 = arg_244_1:GetWordFromCfg(1104106058)
				local var_247_19 = arg_244_1:FormatText(var_247_18.content)

				arg_244_1.text_.text = var_247_19

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_20 = 67
				local var_247_21 = utf8.len(var_247_19)
				local var_247_22 = var_247_20 <= 0 and var_247_16 or var_247_16 * (var_247_21 / var_247_20)

				if var_247_22 > 0 and var_247_16 < var_247_22 then
					arg_244_1.talkMaxDuration = var_247_22

					if var_247_22 + var_247_15 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_22 + var_247_15
					end
				end

				arg_244_1.text_.text = var_247_19
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106058", "story_v_side_new_1104106.awb") ~= 0 then
					local var_247_23 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106058", "story_v_side_new_1104106.awb") / 1000

					if var_247_23 + var_247_15 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_23 + var_247_15
					end

					if var_247_18.prefab_name ~= "" and arg_244_1.actors_[var_247_18.prefab_name] ~= nil then
						local var_247_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_18.prefab_name].transform, "story_v_side_new_1104106", "1104106058", "story_v_side_new_1104106.awb")

						arg_244_1:RecordAudio("1104106058", var_247_24)
						arg_244_1:RecordAudio("1104106058", var_247_24)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106058", "story_v_side_new_1104106.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106058", "story_v_side_new_1104106.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_25 = math.max(var_247_16, arg_244_1.talkMaxDuration)

			if var_247_15 <= arg_244_1.time_ and arg_244_1.time_ < var_247_15 + var_247_25 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_15) / var_247_25

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_15 + var_247_25 and arg_244_1.time_ < var_247_15 + var_247_25 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play1104106059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 1104106059
		arg_248_1.duration_ = 9.4

		local var_248_0 = {
			zh = 9.4,
			ja = 6.033
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
				arg_248_0:Play1104106060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 1.325

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_2 = arg_248_1:FormatText(StoryNameCfg[208].name)

				arg_248_1.leftNameTxt_.text = var_251_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_3 = arg_248_1:GetWordFromCfg(1104106059)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 53
				local var_251_6 = utf8.len(var_251_4)
				local var_251_7 = var_251_5 <= 0 and var_251_1 or var_251_1 * (var_251_6 / var_251_5)

				if var_251_7 > 0 and var_251_1 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_4
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106059", "story_v_side_new_1104106.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106059", "story_v_side_new_1104106.awb") / 1000

					if var_251_8 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_0
					end

					if var_251_3.prefab_name ~= "" and arg_248_1.actors_[var_251_3.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_3.prefab_name].transform, "story_v_side_new_1104106", "1104106059", "story_v_side_new_1104106.awb")

						arg_248_1:RecordAudio("1104106059", var_251_9)
						arg_248_1:RecordAudio("1104106059", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106059", "story_v_side_new_1104106.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106059", "story_v_side_new_1104106.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_10 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_10 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_10

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_10 and arg_248_1.time_ < var_251_0 + var_251_10 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play1104106060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 1104106060
		arg_252_1.duration_ = 7.4

		local var_252_0 = {
			zh = 7.4,
			ja = 7.166
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
				arg_252_0:Play1104106061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_255_1 = 0
			local var_255_2 = 1.075

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_3 = arg_252_1:FormatText(StoryNameCfg[208].name)

				arg_252_1.leftNameTxt_.text = var_255_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_4 = arg_252_1:GetWordFromCfg(1104106060)
				local var_255_5 = arg_252_1:FormatText(var_255_4.content)

				arg_252_1.text_.text = var_255_5

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_6 = 43
				local var_255_7 = utf8.len(var_255_5)
				local var_255_8 = var_255_6 <= 0 and var_255_2 or var_255_2 * (var_255_7 / var_255_6)

				if var_255_8 > 0 and var_255_2 < var_255_8 then
					arg_252_1.talkMaxDuration = var_255_8

					if var_255_8 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_8 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_5
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106060", "story_v_side_new_1104106.awb") ~= 0 then
					local var_255_9 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106060", "story_v_side_new_1104106.awb") / 1000

					if var_255_9 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_9 + var_255_1
					end

					if var_255_4.prefab_name ~= "" and arg_252_1.actors_[var_255_4.prefab_name] ~= nil then
						local var_255_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_4.prefab_name].transform, "story_v_side_new_1104106", "1104106060", "story_v_side_new_1104106.awb")

						arg_252_1:RecordAudio("1104106060", var_255_10)
						arg_252_1:RecordAudio("1104106060", var_255_10)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106060", "story_v_side_new_1104106.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106060", "story_v_side_new_1104106.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_11 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_11 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_11

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_11 and arg_252_1.time_ < var_255_1 + var_255_11 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play1104106061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 1104106061
		arg_256_1.duration_ = 12.73

		local var_256_0 = {
			zh = 7.333,
			ja = 12.733
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
				arg_256_0:Play1104106062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_259_1 = 0
			local var_259_2 = 0.8

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_3 = arg_256_1:FormatText(StoryNameCfg[208].name)

				arg_256_1.leftNameTxt_.text = var_259_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_4 = arg_256_1:GetWordFromCfg(1104106061)
				local var_259_5 = arg_256_1:FormatText(var_259_4.content)

				arg_256_1.text_.text = var_259_5

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_6 = 32
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106061", "story_v_side_new_1104106.awb") ~= 0 then
					local var_259_9 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106061", "story_v_side_new_1104106.awb") / 1000

					if var_259_9 + var_259_1 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_9 + var_259_1
					end

					if var_259_4.prefab_name ~= "" and arg_256_1.actors_[var_259_4.prefab_name] ~= nil then
						local var_259_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_4.prefab_name].transform, "story_v_side_new_1104106", "1104106061", "story_v_side_new_1104106.awb")

						arg_256_1:RecordAudio("1104106061", var_259_10)
						arg_256_1:RecordAudio("1104106061", var_259_10)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106061", "story_v_side_new_1104106.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106061", "story_v_side_new_1104106.awb")
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
	Play1104106062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 1104106062
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play1104106063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["1041ui_story"]
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1041ui_story == nil then
				arg_260_1.var_.characterEffect1041ui_story = var_263_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.200000002980232

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 and not isNil(var_263_0) then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2

				if arg_260_1.var_.characterEffect1041ui_story and not isNil(var_263_0) then
					local var_263_4 = Mathf.Lerp(0, 0.5, var_263_3)

					arg_260_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1041ui_story.fillRatio = var_263_4
				end
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 and not isNil(var_263_0) and arg_260_1.var_.characterEffect1041ui_story then
				local var_263_5 = 0.5

				arg_260_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1041ui_story.fillRatio = var_263_5
			end

			local var_263_6 = 0
			local var_263_7 = 1.4

			if var_263_6 < arg_260_1.time_ and arg_260_1.time_ <= var_263_6 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_8 = arg_260_1:GetWordFromCfg(1104106062)
				local var_263_9 = arg_260_1:FormatText(var_263_8.content)

				arg_260_1.text_.text = var_263_9

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_10 = 56
				local var_263_11 = utf8.len(var_263_9)
				local var_263_12 = var_263_10 <= 0 and var_263_7 or var_263_7 * (var_263_11 / var_263_10)

				if var_263_12 > 0 and var_263_7 < var_263_12 then
					arg_260_1.talkMaxDuration = var_263_12

					if var_263_12 + var_263_6 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_12 + var_263_6
					end
				end

				arg_260_1.text_.text = var_263_9
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_13 = math.max(var_263_7, arg_260_1.talkMaxDuration)

			if var_263_6 <= arg_260_1.time_ and arg_260_1.time_ < var_263_6 + var_263_13 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_6) / var_263_13

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_6 + var_263_13 and arg_260_1.time_ < var_263_6 + var_263_13 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play1104106063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 1104106063
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play1104106064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0
			local var_267_1 = 0.6

			if var_267_0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_2 = arg_264_1:FormatText(StoryNameCfg[7].name)

				arg_264_1.leftNameTxt_.text = var_267_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_3 = arg_264_1:GetWordFromCfg(1104106063)
				local var_267_4 = arg_264_1:FormatText(var_267_3.content)

				arg_264_1.text_.text = var_267_4

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 24
				local var_267_6 = utf8.len(var_267_4)
				local var_267_7 = var_267_5 <= 0 and var_267_1 or var_267_1 * (var_267_6 / var_267_5)

				if var_267_7 > 0 and var_267_1 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_0
					end
				end

				arg_264_1.text_.text = var_267_4
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_8 = math.max(var_267_1, arg_264_1.talkMaxDuration)

			if var_267_0 <= arg_264_1.time_ and arg_264_1.time_ < var_267_0 + var_267_8 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_0) / var_267_8

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_0 + var_267_8 and arg_264_1.time_ < var_267_0 + var_267_8 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play1104106064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 1104106064
		arg_268_1.duration_ = 2

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play1104106065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["1041ui_story"].transform
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.var_.moveOldPos1041ui_story = var_271_0.localPosition
			end

			local var_271_2 = 0.001

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2
				local var_271_4 = Vector3.New(0, -1.11, -5.9)

				var_271_0.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1041ui_story, var_271_4, var_271_3)

				local var_271_5 = manager.ui.mainCamera.transform.position - var_271_0.position

				var_271_0.forward = Vector3.New(var_271_5.x, var_271_5.y, var_271_5.z)

				local var_271_6 = var_271_0.localEulerAngles

				var_271_6.z = 0
				var_271_6.x = 0
				var_271_0.localEulerAngles = var_271_6
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 then
				var_271_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_271_7 = manager.ui.mainCamera.transform.position - var_271_0.position

				var_271_0.forward = Vector3.New(var_271_7.x, var_271_7.y, var_271_7.z)

				local var_271_8 = var_271_0.localEulerAngles

				var_271_8.z = 0
				var_271_8.x = 0
				var_271_0.localEulerAngles = var_271_8
			end

			local var_271_9 = arg_268_1.actors_["1041ui_story"]
			local var_271_10 = 0

			if var_271_10 < arg_268_1.time_ and arg_268_1.time_ <= var_271_10 + arg_271_0 and not isNil(var_271_9) and arg_268_1.var_.characterEffect1041ui_story == nil then
				arg_268_1.var_.characterEffect1041ui_story = var_271_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_11 = 0.200000002980232

			if var_271_10 <= arg_268_1.time_ and arg_268_1.time_ < var_271_10 + var_271_11 and not isNil(var_271_9) then
				local var_271_12 = (arg_268_1.time_ - var_271_10) / var_271_11

				if arg_268_1.var_.characterEffect1041ui_story and not isNil(var_271_9) then
					arg_268_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= var_271_10 + var_271_11 and arg_268_1.time_ < var_271_10 + var_271_11 + arg_271_0 and not isNil(var_271_9) and arg_268_1.var_.characterEffect1041ui_story then
				arg_268_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_271_13 = 0

			if var_271_13 < arg_268_1.time_ and arg_268_1.time_ <= var_271_13 + arg_271_0 then
				arg_268_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_271_14 = 0
			local var_271_15 = 0.05

			if var_271_14 < arg_268_1.time_ and arg_268_1.time_ <= var_271_14 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_16 = arg_268_1:FormatText(StoryNameCfg[208].name)

				arg_268_1.leftNameTxt_.text = var_271_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_17 = arg_268_1:GetWordFromCfg(1104106064)
				local var_271_18 = arg_268_1:FormatText(var_271_17.content)

				arg_268_1.text_.text = var_271_18

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_19 = 2
				local var_271_20 = utf8.len(var_271_18)
				local var_271_21 = var_271_19 <= 0 and var_271_15 or var_271_15 * (var_271_20 / var_271_19)

				if var_271_21 > 0 and var_271_15 < var_271_21 then
					arg_268_1.talkMaxDuration = var_271_21

					if var_271_21 + var_271_14 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_21 + var_271_14
					end
				end

				arg_268_1.text_.text = var_271_18
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106064", "story_v_side_new_1104106.awb") ~= 0 then
					local var_271_22 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106064", "story_v_side_new_1104106.awb") / 1000

					if var_271_22 + var_271_14 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_22 + var_271_14
					end

					if var_271_17.prefab_name ~= "" and arg_268_1.actors_[var_271_17.prefab_name] ~= nil then
						local var_271_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_17.prefab_name].transform, "story_v_side_new_1104106", "1104106064", "story_v_side_new_1104106.awb")

						arg_268_1:RecordAudio("1104106064", var_271_23)
						arg_268_1:RecordAudio("1104106064", var_271_23)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106064", "story_v_side_new_1104106.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106064", "story_v_side_new_1104106.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_24 = math.max(var_271_15, arg_268_1.talkMaxDuration)

			if var_271_14 <= arg_268_1.time_ and arg_268_1.time_ < var_271_14 + var_271_24 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_14) / var_271_24

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_14 + var_271_24 and arg_268_1.time_ < var_271_14 + var_271_24 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play1104106065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 1104106065
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play1104106066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["1041ui_story"]
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect1041ui_story == nil then
				arg_272_1.var_.characterEffect1041ui_story = var_275_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 and not isNil(var_275_0) then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2

				if arg_272_1.var_.characterEffect1041ui_story and not isNil(var_275_0) then
					local var_275_4 = Mathf.Lerp(0, 0.5, var_275_3)

					arg_272_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_272_1.var_.characterEffect1041ui_story.fillRatio = var_275_4
				end
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect1041ui_story then
				local var_275_5 = 0.5

				arg_272_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_272_1.var_.characterEffect1041ui_story.fillRatio = var_275_5
			end

			local var_275_6 = 0
			local var_275_7 = 1.25

			if var_275_6 < arg_272_1.time_ and arg_272_1.time_ <= var_275_6 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, false)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_8 = arg_272_1:GetWordFromCfg(1104106065)
				local var_275_9 = arg_272_1:FormatText(var_275_8.content)

				arg_272_1.text_.text = var_275_9

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_10 = 50
				local var_275_11 = utf8.len(var_275_9)
				local var_275_12 = var_275_10 <= 0 and var_275_7 or var_275_7 * (var_275_11 / var_275_10)

				if var_275_12 > 0 and var_275_7 < var_275_12 then
					arg_272_1.talkMaxDuration = var_275_12

					if var_275_12 + var_275_6 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_12 + var_275_6
					end
				end

				arg_272_1.text_.text = var_275_9
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_13 = math.max(var_275_7, arg_272_1.talkMaxDuration)

			if var_275_6 <= arg_272_1.time_ and arg_272_1.time_ < var_275_6 + var_275_13 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_6) / var_275_13

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_6 + var_275_13 and arg_272_1.time_ < var_275_6 + var_275_13 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play1104106066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 1104106066
		arg_276_1.duration_ = 5.8

		local var_276_0 = {
			zh = 5.233,
			ja = 5.8
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
				arg_276_0:Play1104106067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["1041ui_story"].transform
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.var_.moveOldPos1041ui_story = var_279_0.localPosition
			end

			local var_279_2 = 0.001

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2
				local var_279_4 = Vector3.New(0, -1.11, -5.9)

				var_279_0.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1041ui_story, var_279_4, var_279_3)

				local var_279_5 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_5.x, var_279_5.y, var_279_5.z)

				local var_279_6 = var_279_0.localEulerAngles

				var_279_6.z = 0
				var_279_6.x = 0
				var_279_0.localEulerAngles = var_279_6
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 then
				var_279_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_279_7 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_7.x, var_279_7.y, var_279_7.z)

				local var_279_8 = var_279_0.localEulerAngles

				var_279_8.z = 0
				var_279_8.x = 0
				var_279_0.localEulerAngles = var_279_8
			end

			local var_279_9 = arg_276_1.actors_["1041ui_story"]
			local var_279_10 = 0

			if var_279_10 < arg_276_1.time_ and arg_276_1.time_ <= var_279_10 + arg_279_0 and not isNil(var_279_9) and arg_276_1.var_.characterEffect1041ui_story == nil then
				arg_276_1.var_.characterEffect1041ui_story = var_279_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_11 = 0.200000002980232

			if var_279_10 <= arg_276_1.time_ and arg_276_1.time_ < var_279_10 + var_279_11 and not isNil(var_279_9) then
				local var_279_12 = (arg_276_1.time_ - var_279_10) / var_279_11

				if arg_276_1.var_.characterEffect1041ui_story and not isNil(var_279_9) then
					arg_276_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= var_279_10 + var_279_11 and arg_276_1.time_ < var_279_10 + var_279_11 + arg_279_0 and not isNil(var_279_9) and arg_276_1.var_.characterEffect1041ui_story then
				arg_276_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_279_13 = 0

			if var_279_13 < arg_276_1.time_ and arg_276_1.time_ <= var_279_13 + arg_279_0 then
				arg_276_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_279_14 = 0

			if var_279_14 < arg_276_1.time_ and arg_276_1.time_ <= var_279_14 + arg_279_0 then
				arg_276_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action5_2")
			end

			local var_279_15 = 0
			local var_279_16 = 0.775

			if var_279_15 < arg_276_1.time_ and arg_276_1.time_ <= var_279_15 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_17 = arg_276_1:FormatText(StoryNameCfg[208].name)

				arg_276_1.leftNameTxt_.text = var_279_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_18 = arg_276_1:GetWordFromCfg(1104106066)
				local var_279_19 = arg_276_1:FormatText(var_279_18.content)

				arg_276_1.text_.text = var_279_19

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_20 = 31
				local var_279_21 = utf8.len(var_279_19)
				local var_279_22 = var_279_20 <= 0 and var_279_16 or var_279_16 * (var_279_21 / var_279_20)

				if var_279_22 > 0 and var_279_16 < var_279_22 then
					arg_276_1.talkMaxDuration = var_279_22

					if var_279_22 + var_279_15 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_22 + var_279_15
					end
				end

				arg_276_1.text_.text = var_279_19
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106066", "story_v_side_new_1104106.awb") ~= 0 then
					local var_279_23 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106066", "story_v_side_new_1104106.awb") / 1000

					if var_279_23 + var_279_15 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_23 + var_279_15
					end

					if var_279_18.prefab_name ~= "" and arg_276_1.actors_[var_279_18.prefab_name] ~= nil then
						local var_279_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_18.prefab_name].transform, "story_v_side_new_1104106", "1104106066", "story_v_side_new_1104106.awb")

						arg_276_1:RecordAudio("1104106066", var_279_24)
						arg_276_1:RecordAudio("1104106066", var_279_24)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106066", "story_v_side_new_1104106.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106066", "story_v_side_new_1104106.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_25 = math.max(var_279_16, arg_276_1.talkMaxDuration)

			if var_279_15 <= arg_276_1.time_ and arg_276_1.time_ < var_279_15 + var_279_25 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_15) / var_279_25

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_15 + var_279_25 and arg_276_1.time_ < var_279_15 + var_279_25 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
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
	Play1104106067 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 1104106067
		arg_280_1.duration_ = 5.5

		local var_280_0 = {
			zh = 5.5,
			ja = 3.766
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
				arg_280_0:Play1104106068(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0
			local var_283_1 = 0.875

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_2 = arg_280_1:FormatText(StoryNameCfg[208].name)

				arg_280_1.leftNameTxt_.text = var_283_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_3 = arg_280_1:GetWordFromCfg(1104106067)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 35
				local var_283_6 = utf8.len(var_283_4)
				local var_283_7 = var_283_5 <= 0 and var_283_1 or var_283_1 * (var_283_6 / var_283_5)

				if var_283_7 > 0 and var_283_1 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106067", "story_v_side_new_1104106.awb") ~= 0 then
					local var_283_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106067", "story_v_side_new_1104106.awb") / 1000

					if var_283_8 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_8 + var_283_0
					end

					if var_283_3.prefab_name ~= "" and arg_280_1.actors_[var_283_3.prefab_name] ~= nil then
						local var_283_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_3.prefab_name].transform, "story_v_side_new_1104106", "1104106067", "story_v_side_new_1104106.awb")

						arg_280_1:RecordAudio("1104106067", var_283_9)
						arg_280_1:RecordAudio("1104106067", var_283_9)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106067", "story_v_side_new_1104106.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106067", "story_v_side_new_1104106.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_10 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_10 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_10

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_10 and arg_280_1.time_ < var_283_0 + var_283_10 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play1104106068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1104106068
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1104106069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1041ui_story"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1041ui_story == nil then
				arg_284_1.var_.characterEffect1041ui_story = var_287_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.characterEffect1041ui_story and not isNil(var_287_0) then
					local var_287_4 = Mathf.Lerp(0, 0.5, var_287_3)

					arg_284_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1041ui_story.fillRatio = var_287_4
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1041ui_story then
				local var_287_5 = 0.5

				arg_284_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1041ui_story.fillRatio = var_287_5
			end

			local var_287_6 = 0
			local var_287_7 = 0.375

			if var_287_6 < arg_284_1.time_ and arg_284_1.time_ <= var_287_6 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_8 = arg_284_1:FormatText(StoryNameCfg[7].name)

				arg_284_1.leftNameTxt_.text = var_287_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_9 = arg_284_1:GetWordFromCfg(1104106068)
				local var_287_10 = arg_284_1:FormatText(var_287_9.content)

				arg_284_1.text_.text = var_287_10

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_11 = 15
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
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_14 = math.max(var_287_7, arg_284_1.talkMaxDuration)

			if var_287_6 <= arg_284_1.time_ and arg_284_1.time_ < var_287_6 + var_287_14 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_6) / var_287_14

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_6 + var_287_14 and arg_284_1.time_ < var_287_6 + var_287_14 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play1104106069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1104106069
		arg_288_1.duration_ = 9.37

		local var_288_0 = {
			zh = 7.733,
			ja = 9.366
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
				arg_288_0:Play1104106070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1041ui_story"].transform
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1.var_.moveOldPos1041ui_story = var_291_0.localPosition
			end

			local var_291_2 = 0.001

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2
				local var_291_4 = Vector3.New(0, -1.11, -5.9)

				var_291_0.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1041ui_story, var_291_4, var_291_3)

				local var_291_5 = manager.ui.mainCamera.transform.position - var_291_0.position

				var_291_0.forward = Vector3.New(var_291_5.x, var_291_5.y, var_291_5.z)

				local var_291_6 = var_291_0.localEulerAngles

				var_291_6.z = 0
				var_291_6.x = 0
				var_291_0.localEulerAngles = var_291_6
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 then
				var_291_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_291_7 = manager.ui.mainCamera.transform.position - var_291_0.position

				var_291_0.forward = Vector3.New(var_291_7.x, var_291_7.y, var_291_7.z)

				local var_291_8 = var_291_0.localEulerAngles

				var_291_8.z = 0
				var_291_8.x = 0
				var_291_0.localEulerAngles = var_291_8
			end

			local var_291_9 = arg_288_1.actors_["1041ui_story"]
			local var_291_10 = 0

			if var_291_10 < arg_288_1.time_ and arg_288_1.time_ <= var_291_10 + arg_291_0 and not isNil(var_291_9) and arg_288_1.var_.characterEffect1041ui_story == nil then
				arg_288_1.var_.characterEffect1041ui_story = var_291_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_11 = 0.200000002980232

			if var_291_10 <= arg_288_1.time_ and arg_288_1.time_ < var_291_10 + var_291_11 and not isNil(var_291_9) then
				local var_291_12 = (arg_288_1.time_ - var_291_10) / var_291_11

				if arg_288_1.var_.characterEffect1041ui_story and not isNil(var_291_9) then
					arg_288_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= var_291_10 + var_291_11 and arg_288_1.time_ < var_291_10 + var_291_11 + arg_291_0 and not isNil(var_291_9) and arg_288_1.var_.characterEffect1041ui_story then
				arg_288_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_291_13 = 0

			if var_291_13 < arg_288_1.time_ and arg_288_1.time_ <= var_291_13 + arg_291_0 then
				arg_288_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_1")
			end

			local var_291_14 = 0

			if var_291_14 < arg_288_1.time_ and arg_288_1.time_ <= var_291_14 + arg_291_0 then
				arg_288_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_291_15 = 0
			local var_291_16 = 0.725

			if var_291_15 < arg_288_1.time_ and arg_288_1.time_ <= var_291_15 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_17 = arg_288_1:FormatText(StoryNameCfg[208].name)

				arg_288_1.leftNameTxt_.text = var_291_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_18 = arg_288_1:GetWordFromCfg(1104106069)
				local var_291_19 = arg_288_1:FormatText(var_291_18.content)

				arg_288_1.text_.text = var_291_19

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_20 = 29
				local var_291_21 = utf8.len(var_291_19)
				local var_291_22 = var_291_20 <= 0 and var_291_16 or var_291_16 * (var_291_21 / var_291_20)

				if var_291_22 > 0 and var_291_16 < var_291_22 then
					arg_288_1.talkMaxDuration = var_291_22

					if var_291_22 + var_291_15 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_22 + var_291_15
					end
				end

				arg_288_1.text_.text = var_291_19
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106069", "story_v_side_new_1104106.awb") ~= 0 then
					local var_291_23 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106069", "story_v_side_new_1104106.awb") / 1000

					if var_291_23 + var_291_15 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_23 + var_291_15
					end

					if var_291_18.prefab_name ~= "" and arg_288_1.actors_[var_291_18.prefab_name] ~= nil then
						local var_291_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_18.prefab_name].transform, "story_v_side_new_1104106", "1104106069", "story_v_side_new_1104106.awb")

						arg_288_1:RecordAudio("1104106069", var_291_24)
						arg_288_1:RecordAudio("1104106069", var_291_24)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106069", "story_v_side_new_1104106.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106069", "story_v_side_new_1104106.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_25 = math.max(var_291_16, arg_288_1.talkMaxDuration)

			if var_291_15 <= arg_288_1.time_ and arg_288_1.time_ < var_291_15 + var_291_25 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_15) / var_291_25

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_15 + var_291_25 and arg_288_1.time_ < var_291_15 + var_291_25 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play1104106070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1104106070
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1104106071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1041ui_story"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1041ui_story == nil then
				arg_292_1.var_.characterEffect1041ui_story = var_295_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.200000002980232

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.characterEffect1041ui_story and not isNil(var_295_0) then
					local var_295_4 = Mathf.Lerp(0, 0.5, var_295_3)

					arg_292_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1041ui_story.fillRatio = var_295_4
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1041ui_story then
				local var_295_5 = 0.5

				arg_292_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1041ui_story.fillRatio = var_295_5
			end

			local var_295_6 = 0

			if var_295_6 < arg_292_1.time_ and arg_292_1.time_ <= var_295_6 + arg_295_0 then
				arg_292_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_295_7 = 0
			local var_295_8 = 0.425

			if var_295_7 < arg_292_1.time_ and arg_292_1.time_ <= var_295_7 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_9 = arg_292_1:GetWordFromCfg(1104106070)
				local var_295_10 = arg_292_1:FormatText(var_295_9.content)

				arg_292_1.text_.text = var_295_10

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_11 = 17
				local var_295_12 = utf8.len(var_295_10)
				local var_295_13 = var_295_11 <= 0 and var_295_8 or var_295_8 * (var_295_12 / var_295_11)

				if var_295_13 > 0 and var_295_8 < var_295_13 then
					arg_292_1.talkMaxDuration = var_295_13

					if var_295_13 + var_295_7 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_13 + var_295_7
					end
				end

				arg_292_1.text_.text = var_295_10
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_14 = math.max(var_295_8, arg_292_1.talkMaxDuration)

			if var_295_7 <= arg_292_1.time_ and arg_292_1.time_ < var_295_7 + var_295_14 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_7) / var_295_14

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_7 + var_295_14 and arg_292_1.time_ < var_295_7 + var_295_14 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play1104106071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1104106071
		arg_296_1.duration_ = 4.47

		local var_296_0 = {
			zh = 4.133,
			ja = 4.466
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
				arg_296_0:Play1104106072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["1041ui_story"].transform
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.var_.moveOldPos1041ui_story = var_299_0.localPosition
			end

			local var_299_2 = 0.001

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2
				local var_299_4 = Vector3.New(0, -1.11, -5.9)

				var_299_0.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1041ui_story, var_299_4, var_299_3)

				local var_299_5 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_5.x, var_299_5.y, var_299_5.z)

				local var_299_6 = var_299_0.localEulerAngles

				var_299_6.z = 0
				var_299_6.x = 0
				var_299_0.localEulerAngles = var_299_6
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 then
				var_299_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_299_7 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_7.x, var_299_7.y, var_299_7.z)

				local var_299_8 = var_299_0.localEulerAngles

				var_299_8.z = 0
				var_299_8.x = 0
				var_299_0.localEulerAngles = var_299_8
			end

			local var_299_9 = arg_296_1.actors_["1041ui_story"]
			local var_299_10 = 0

			if var_299_10 < arg_296_1.time_ and arg_296_1.time_ <= var_299_10 + arg_299_0 and not isNil(var_299_9) and arg_296_1.var_.characterEffect1041ui_story == nil then
				arg_296_1.var_.characterEffect1041ui_story = var_299_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_11 = 0.200000002980232

			if var_299_10 <= arg_296_1.time_ and arg_296_1.time_ < var_299_10 + var_299_11 and not isNil(var_299_9) then
				local var_299_12 = (arg_296_1.time_ - var_299_10) / var_299_11

				if arg_296_1.var_.characterEffect1041ui_story and not isNil(var_299_9) then
					arg_296_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= var_299_10 + var_299_11 and arg_296_1.time_ < var_299_10 + var_299_11 + arg_299_0 and not isNil(var_299_9) and arg_296_1.var_.characterEffect1041ui_story then
				arg_296_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_299_13 = 0

			if var_299_13 < arg_296_1.time_ and arg_296_1.time_ <= var_299_13 + arg_299_0 then
				arg_296_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_2")
			end

			local var_299_14 = 0

			if var_299_14 < arg_296_1.time_ and arg_296_1.time_ <= var_299_14 + arg_299_0 then
				arg_296_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_299_15 = 0
			local var_299_16 = 0.5

			if var_299_15 < arg_296_1.time_ and arg_296_1.time_ <= var_299_15 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_17 = arg_296_1:FormatText(StoryNameCfg[208].name)

				arg_296_1.leftNameTxt_.text = var_299_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_18 = arg_296_1:GetWordFromCfg(1104106071)
				local var_299_19 = arg_296_1:FormatText(var_299_18.content)

				arg_296_1.text_.text = var_299_19

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_20 = 20
				local var_299_21 = utf8.len(var_299_19)
				local var_299_22 = var_299_20 <= 0 and var_299_16 or var_299_16 * (var_299_21 / var_299_20)

				if var_299_22 > 0 and var_299_16 < var_299_22 then
					arg_296_1.talkMaxDuration = var_299_22

					if var_299_22 + var_299_15 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_22 + var_299_15
					end
				end

				arg_296_1.text_.text = var_299_19
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106071", "story_v_side_new_1104106.awb") ~= 0 then
					local var_299_23 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106071", "story_v_side_new_1104106.awb") / 1000

					if var_299_23 + var_299_15 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_23 + var_299_15
					end

					if var_299_18.prefab_name ~= "" and arg_296_1.actors_[var_299_18.prefab_name] ~= nil then
						local var_299_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_18.prefab_name].transform, "story_v_side_new_1104106", "1104106071", "story_v_side_new_1104106.awb")

						arg_296_1:RecordAudio("1104106071", var_299_24)
						arg_296_1:RecordAudio("1104106071", var_299_24)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106071", "story_v_side_new_1104106.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106071", "story_v_side_new_1104106.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_25 = math.max(var_299_16, arg_296_1.talkMaxDuration)

			if var_299_15 <= arg_296_1.time_ and arg_296_1.time_ < var_299_15 + var_299_25 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_15) / var_299_25

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_15 + var_299_25 and arg_296_1.time_ < var_299_15 + var_299_25 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play1104106072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1104106072
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1104106073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["1041ui_story"]
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect1041ui_story == nil then
				arg_300_1.var_.characterEffect1041ui_story = var_303_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_2 = 0.200000002980232

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 and not isNil(var_303_0) then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2

				if arg_300_1.var_.characterEffect1041ui_story and not isNil(var_303_0) then
					local var_303_4 = Mathf.Lerp(0, 0.5, var_303_3)

					arg_300_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_300_1.var_.characterEffect1041ui_story.fillRatio = var_303_4
				end
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect1041ui_story then
				local var_303_5 = 0.5

				arg_300_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_300_1.var_.characterEffect1041ui_story.fillRatio = var_303_5
			end

			local var_303_6 = 0
			local var_303_7 = 0.125

			if var_303_6 < arg_300_1.time_ and arg_300_1.time_ <= var_303_6 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_8 = arg_300_1:FormatText(StoryNameCfg[7].name)

				arg_300_1.leftNameTxt_.text = var_303_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_9 = arg_300_1:GetWordFromCfg(1104106072)
				local var_303_10 = arg_300_1:FormatText(var_303_9.content)

				arg_300_1.text_.text = var_303_10

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_11 = 5
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
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_14 = math.max(var_303_7, arg_300_1.talkMaxDuration)

			if var_303_6 <= arg_300_1.time_ and arg_300_1.time_ < var_303_6 + var_303_14 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_6) / var_303_14

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_6 + var_303_14 and arg_300_1.time_ < var_303_6 + var_303_14 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play1104106073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1104106073
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1104106074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 0.35

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_2 = arg_304_1:GetWordFromCfg(1104106073)
				local var_307_3 = arg_304_1:FormatText(var_307_2.content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 14
				local var_307_5 = utf8.len(var_307_3)
				local var_307_6 = var_307_4 <= 0 and var_307_1 or var_307_1 * (var_307_5 / var_307_4)

				if var_307_6 > 0 and var_307_1 < var_307_6 then
					arg_304_1.talkMaxDuration = var_307_6

					if var_307_6 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_6 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_7 and arg_304_1.time_ < var_307_0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play1104106074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1104106074
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1104106075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0
			local var_311_1 = 0.9

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

				local var_311_2 = arg_308_1:GetWordFromCfg(1104106074)
				local var_311_3 = arg_308_1:FormatText(var_311_2.content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_4 = 36
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
	Play1104106075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1104106075
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1104106076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0
			local var_315_1 = 1.525

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_2 = arg_312_1:GetWordFromCfg(1104106075)
				local var_315_3 = arg_312_1:FormatText(var_315_2.content)

				arg_312_1.text_.text = var_315_3

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_4 = 61
				local var_315_5 = utf8.len(var_315_3)
				local var_315_6 = var_315_4 <= 0 and var_315_1 or var_315_1 * (var_315_5 / var_315_4)

				if var_315_6 > 0 and var_315_1 < var_315_6 then
					arg_312_1.talkMaxDuration = var_315_6

					if var_315_6 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_6 + var_315_0
					end
				end

				arg_312_1.text_.text = var_315_3
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_7 = math.max(var_315_1, arg_312_1.talkMaxDuration)

			if var_315_0 <= arg_312_1.time_ and arg_312_1.time_ < var_315_0 + var_315_7 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_0) / var_315_7

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_0 + var_315_7 and arg_312_1.time_ < var_315_0 + var_315_7 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play1104106076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1104106076
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1104106077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 0.375

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_2 = arg_316_1:FormatText(StoryNameCfg[7].name)

				arg_316_1.leftNameTxt_.text = var_319_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_3 = arg_316_1:GetWordFromCfg(1104106076)
				local var_319_4 = arg_316_1:FormatText(var_319_3.content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 15
				local var_319_6 = utf8.len(var_319_4)
				local var_319_7 = var_319_5 <= 0 and var_319_1 or var_319_1 * (var_319_6 / var_319_5)

				if var_319_7 > 0 and var_319_1 < var_319_7 then
					arg_316_1.talkMaxDuration = var_319_7

					if var_319_7 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_4
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_8 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_8 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_8

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_8 and arg_316_1.time_ < var_319_0 + var_319_8 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play1104106077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1104106077
		arg_320_1.duration_ = 5.87

		local var_320_0 = {
			zh = 5.633,
			ja = 5.866
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
				arg_320_0:Play1104106078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["1041ui_story"].transform
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.var_.moveOldPos1041ui_story = var_323_0.localPosition
			end

			local var_323_2 = 0.001

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2
				local var_323_4 = Vector3.New(0, -1.11, -5.9)

				var_323_0.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1041ui_story, var_323_4, var_323_3)

				local var_323_5 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_5.x, var_323_5.y, var_323_5.z)

				local var_323_6 = var_323_0.localEulerAngles

				var_323_6.z = 0
				var_323_6.x = 0
				var_323_0.localEulerAngles = var_323_6
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 then
				var_323_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_323_7 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_7.x, var_323_7.y, var_323_7.z)

				local var_323_8 = var_323_0.localEulerAngles

				var_323_8.z = 0
				var_323_8.x = 0
				var_323_0.localEulerAngles = var_323_8
			end

			local var_323_9 = arg_320_1.actors_["1041ui_story"]
			local var_323_10 = 0

			if var_323_10 < arg_320_1.time_ and arg_320_1.time_ <= var_323_10 + arg_323_0 and not isNil(var_323_9) and arg_320_1.var_.characterEffect1041ui_story == nil then
				arg_320_1.var_.characterEffect1041ui_story = var_323_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_11 = 0.200000002980232

			if var_323_10 <= arg_320_1.time_ and arg_320_1.time_ < var_323_10 + var_323_11 and not isNil(var_323_9) then
				local var_323_12 = (arg_320_1.time_ - var_323_10) / var_323_11

				if arg_320_1.var_.characterEffect1041ui_story and not isNil(var_323_9) then
					arg_320_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= var_323_10 + var_323_11 and arg_320_1.time_ < var_323_10 + var_323_11 + arg_323_0 and not isNil(var_323_9) and arg_320_1.var_.characterEffect1041ui_story then
				arg_320_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_323_13 = 0

			if var_323_13 < arg_320_1.time_ and arg_320_1.time_ <= var_323_13 + arg_323_0 then
				arg_320_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_323_14 = 0
			local var_323_15 = 0.8

			if var_323_14 < arg_320_1.time_ and arg_320_1.time_ <= var_323_14 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_16 = arg_320_1:FormatText(StoryNameCfg[208].name)

				arg_320_1.leftNameTxt_.text = var_323_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_17 = arg_320_1:GetWordFromCfg(1104106077)
				local var_323_18 = arg_320_1:FormatText(var_323_17.content)

				arg_320_1.text_.text = var_323_18

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_19 = 32
				local var_323_20 = utf8.len(var_323_18)
				local var_323_21 = var_323_19 <= 0 and var_323_15 or var_323_15 * (var_323_20 / var_323_19)

				if var_323_21 > 0 and var_323_15 < var_323_21 then
					arg_320_1.talkMaxDuration = var_323_21

					if var_323_21 + var_323_14 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_21 + var_323_14
					end
				end

				arg_320_1.text_.text = var_323_18
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106077", "story_v_side_new_1104106.awb") ~= 0 then
					local var_323_22 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106077", "story_v_side_new_1104106.awb") / 1000

					if var_323_22 + var_323_14 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_22 + var_323_14
					end

					if var_323_17.prefab_name ~= "" and arg_320_1.actors_[var_323_17.prefab_name] ~= nil then
						local var_323_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_17.prefab_name].transform, "story_v_side_new_1104106", "1104106077", "story_v_side_new_1104106.awb")

						arg_320_1:RecordAudio("1104106077", var_323_23)
						arg_320_1:RecordAudio("1104106077", var_323_23)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106077", "story_v_side_new_1104106.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106077", "story_v_side_new_1104106.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_24 = math.max(var_323_15, arg_320_1.talkMaxDuration)

			if var_323_14 <= arg_320_1.time_ and arg_320_1.time_ < var_323_14 + var_323_24 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_14) / var_323_24

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_14 + var_323_24 and arg_320_1.time_ < var_323_14 + var_323_24 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play1104106078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1104106078
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play1104106079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["1041ui_story"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1041ui_story == nil then
				arg_324_1.var_.characterEffect1041ui_story = var_327_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.200000002980232

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.characterEffect1041ui_story and not isNil(var_327_0) then
					local var_327_4 = Mathf.Lerp(0, 0.5, var_327_3)

					arg_324_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1041ui_story.fillRatio = var_327_4
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1041ui_story then
				local var_327_5 = 0.5

				arg_324_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1041ui_story.fillRatio = var_327_5
			end

			local var_327_6 = 0
			local var_327_7 = 0.6

			if var_327_6 < arg_324_1.time_ and arg_324_1.time_ <= var_327_6 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_8 = arg_324_1:GetWordFromCfg(1104106078)
				local var_327_9 = arg_324_1:FormatText(var_327_8.content)

				arg_324_1.text_.text = var_327_9

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_10 = 24
				local var_327_11 = utf8.len(var_327_9)
				local var_327_12 = var_327_10 <= 0 and var_327_7 or var_327_7 * (var_327_11 / var_327_10)

				if var_327_12 > 0 and var_327_7 < var_327_12 then
					arg_324_1.talkMaxDuration = var_327_12

					if var_327_12 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_12 + var_327_6
					end
				end

				arg_324_1.text_.text = var_327_9
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_13 = math.max(var_327_7, arg_324_1.talkMaxDuration)

			if var_327_6 <= arg_324_1.time_ and arg_324_1.time_ < var_327_6 + var_327_13 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_6) / var_327_13

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_6 + var_327_13 and arg_324_1.time_ < var_327_6 + var_327_13 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play1104106079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1104106079
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1104106080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0
			local var_331_1 = 0.725

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_2 = arg_328_1:GetWordFromCfg(1104106079)
				local var_331_3 = arg_328_1:FormatText(var_331_2.content)

				arg_328_1.text_.text = var_331_3

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_4 = 29
				local var_331_5 = utf8.len(var_331_3)
				local var_331_6 = var_331_4 <= 0 and var_331_1 or var_331_1 * (var_331_5 / var_331_4)

				if var_331_6 > 0 and var_331_1 < var_331_6 then
					arg_328_1.talkMaxDuration = var_331_6

					if var_331_6 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_6 + var_331_0
					end
				end

				arg_328_1.text_.text = var_331_3
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_7 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_7 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_7

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_7 and arg_328_1.time_ < var_331_0 + var_331_7 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play1104106080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1104106080
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1104106081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0
			local var_335_1 = 0.15

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_2 = arg_332_1:FormatText(StoryNameCfg[7].name)

				arg_332_1.leftNameTxt_.text = var_335_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_3 = arg_332_1:GetWordFromCfg(1104106080)
				local var_335_4 = arg_332_1:FormatText(var_335_3.content)

				arg_332_1.text_.text = var_335_4

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_5 = 6
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
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_8 = math.max(var_335_1, arg_332_1.talkMaxDuration)

			if var_335_0 <= arg_332_1.time_ and arg_332_1.time_ < var_335_0 + var_335_8 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_0) / var_335_8

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_0 + var_335_8 and arg_332_1.time_ < var_335_0 + var_335_8 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play1104106081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1104106081
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1104106082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0
			local var_339_1 = 1.55

			if var_339_0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, false)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_2 = arg_336_1:GetWordFromCfg(1104106081)
				local var_339_3 = arg_336_1:FormatText(var_339_2.content)

				arg_336_1.text_.text = var_339_3

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_4 = 62
				local var_339_5 = utf8.len(var_339_3)
				local var_339_6 = var_339_4 <= 0 and var_339_1 or var_339_1 * (var_339_5 / var_339_4)

				if var_339_6 > 0 and var_339_1 < var_339_6 then
					arg_336_1.talkMaxDuration = var_339_6

					if var_339_6 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_6 + var_339_0
					end
				end

				arg_336_1.text_.text = var_339_3
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_7 = math.max(var_339_1, arg_336_1.talkMaxDuration)

			if var_339_0 <= arg_336_1.time_ and arg_336_1.time_ < var_339_0 + var_339_7 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_0) / var_339_7

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_0 + var_339_7 and arg_336_1.time_ < var_339_0 + var_339_7 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play1104106082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1104106082
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1104106083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 0.4

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_2 = arg_340_1:FormatText(StoryNameCfg[7].name)

				arg_340_1.leftNameTxt_.text = var_343_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, true)
				arg_340_1.iconController_:SetSelectedState("hero")

				arg_340_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_340_1.callingController_:SetSelectedState("normal")

				arg_340_1.keyicon_.color = Color.New(1, 1, 1)
				arg_340_1.icon_.color = Color.New(1, 1, 1)

				local var_343_3 = arg_340_1:GetWordFromCfg(1104106082)
				local var_343_4 = arg_340_1:FormatText(var_343_3.content)

				arg_340_1.text_.text = var_343_4

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_5 = 16
				local var_343_6 = utf8.len(var_343_4)
				local var_343_7 = var_343_5 <= 0 and var_343_1 or var_343_1 * (var_343_6 / var_343_5)

				if var_343_7 > 0 and var_343_1 < var_343_7 then
					arg_340_1.talkMaxDuration = var_343_7

					if var_343_7 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_0
					end
				end

				arg_340_1.text_.text = var_343_4
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_8 = math.max(var_343_1, arg_340_1.talkMaxDuration)

			if var_343_0 <= arg_340_1.time_ and arg_340_1.time_ < var_343_0 + var_343_8 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_0) / var_343_8

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_0 + var_343_8 and arg_340_1.time_ < var_343_0 + var_343_8 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1104106083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1104106083
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1104106084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 1.1

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_2 = arg_344_1:GetWordFromCfg(1104106083)
				local var_347_3 = arg_344_1:FormatText(var_347_2.content)

				arg_344_1.text_.text = var_347_3

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_4 = 44
				local var_347_5 = utf8.len(var_347_3)
				local var_347_6 = var_347_4 <= 0 and var_347_1 or var_347_1 * (var_347_5 / var_347_4)

				if var_347_6 > 0 and var_347_1 < var_347_6 then
					arg_344_1.talkMaxDuration = var_347_6

					if var_347_6 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_6 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_3
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_7 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_7 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_7

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_7 and arg_344_1.time_ < var_347_0 + var_347_7 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play1104106084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1104106084
		arg_348_1.duration_ = 6.33

		local var_348_0 = {
			zh = 6.333,
			ja = 5.6
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1104106085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1041ui_story"].transform
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.var_.moveOldPos1041ui_story = var_351_0.localPosition
			end

			local var_351_2 = 0.001

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2
				local var_351_4 = Vector3.New(0, -1.11, -5.9)

				var_351_0.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1041ui_story, var_351_4, var_351_3)

				local var_351_5 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_5.x, var_351_5.y, var_351_5.z)

				local var_351_6 = var_351_0.localEulerAngles

				var_351_6.z = 0
				var_351_6.x = 0
				var_351_0.localEulerAngles = var_351_6
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 then
				var_351_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_351_7 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_7.x, var_351_7.y, var_351_7.z)

				local var_351_8 = var_351_0.localEulerAngles

				var_351_8.z = 0
				var_351_8.x = 0
				var_351_0.localEulerAngles = var_351_8
			end

			local var_351_9 = arg_348_1.actors_["1041ui_story"]
			local var_351_10 = 0

			if var_351_10 < arg_348_1.time_ and arg_348_1.time_ <= var_351_10 + arg_351_0 and not isNil(var_351_9) and arg_348_1.var_.characterEffect1041ui_story == nil then
				arg_348_1.var_.characterEffect1041ui_story = var_351_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_11 = 0.200000002980232

			if var_351_10 <= arg_348_1.time_ and arg_348_1.time_ < var_351_10 + var_351_11 and not isNil(var_351_9) then
				local var_351_12 = (arg_348_1.time_ - var_351_10) / var_351_11

				if arg_348_1.var_.characterEffect1041ui_story and not isNil(var_351_9) then
					arg_348_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= var_351_10 + var_351_11 and arg_348_1.time_ < var_351_10 + var_351_11 + arg_351_0 and not isNil(var_351_9) and arg_348_1.var_.characterEffect1041ui_story then
				arg_348_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_351_13 = 0

			if var_351_13 < arg_348_1.time_ and arg_348_1.time_ <= var_351_13 + arg_351_0 then
				arg_348_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_351_14 = 0
			local var_351_15 = 0.95

			if var_351_14 < arg_348_1.time_ and arg_348_1.time_ <= var_351_14 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_16 = arg_348_1:FormatText(StoryNameCfg[208].name)

				arg_348_1.leftNameTxt_.text = var_351_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_17 = arg_348_1:GetWordFromCfg(1104106084)
				local var_351_18 = arg_348_1:FormatText(var_351_17.content)

				arg_348_1.text_.text = var_351_18

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_19 = 38
				local var_351_20 = utf8.len(var_351_18)
				local var_351_21 = var_351_19 <= 0 and var_351_15 or var_351_15 * (var_351_20 / var_351_19)

				if var_351_21 > 0 and var_351_15 < var_351_21 then
					arg_348_1.talkMaxDuration = var_351_21

					if var_351_21 + var_351_14 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_21 + var_351_14
					end
				end

				arg_348_1.text_.text = var_351_18
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106084", "story_v_side_new_1104106.awb") ~= 0 then
					local var_351_22 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106084", "story_v_side_new_1104106.awb") / 1000

					if var_351_22 + var_351_14 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_22 + var_351_14
					end

					if var_351_17.prefab_name ~= "" and arg_348_1.actors_[var_351_17.prefab_name] ~= nil then
						local var_351_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_17.prefab_name].transform, "story_v_side_new_1104106", "1104106084", "story_v_side_new_1104106.awb")

						arg_348_1:RecordAudio("1104106084", var_351_23)
						arg_348_1:RecordAudio("1104106084", var_351_23)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106084", "story_v_side_new_1104106.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106084", "story_v_side_new_1104106.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_24 = math.max(var_351_15, arg_348_1.talkMaxDuration)

			if var_351_14 <= arg_348_1.time_ and arg_348_1.time_ < var_351_14 + var_351_24 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_14) / var_351_24

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_14 + var_351_24 and arg_348_1.time_ < var_351_14 + var_351_24 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play1104106085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1104106085
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1104106086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1041ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1041ui_story == nil then
				arg_352_1.var_.characterEffect1041ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect1041ui_story and not isNil(var_355_0) then
					local var_355_4 = Mathf.Lerp(0, 0.5, var_355_3)

					arg_352_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1041ui_story.fillRatio = var_355_4
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1041ui_story then
				local var_355_5 = 0.5

				arg_352_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1041ui_story.fillRatio = var_355_5
			end

			local var_355_6 = 0
			local var_355_7 = 0.125

			if var_355_6 < arg_352_1.time_ and arg_352_1.time_ <= var_355_6 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_8 = arg_352_1:FormatText(StoryNameCfg[7].name)

				arg_352_1.leftNameTxt_.text = var_355_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_9 = arg_352_1:GetWordFromCfg(1104106085)
				local var_355_10 = arg_352_1:FormatText(var_355_9.content)

				arg_352_1.text_.text = var_355_10

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_11 = 5
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
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_14 = math.max(var_355_7, arg_352_1.talkMaxDuration)

			if var_355_6 <= arg_352_1.time_ and arg_352_1.time_ < var_355_6 + var_355_14 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_6) / var_355_14

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_6 + var_355_14 and arg_352_1.time_ < var_355_6 + var_355_14 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play1104106086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1104106086
		arg_356_1.duration_ = 8.77

		local var_356_0 = {
			zh = 7.933,
			ja = 8.766
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
				arg_356_0:Play1104106087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["1041ui_story"].transform
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.var_.moveOldPos1041ui_story = var_359_0.localPosition
			end

			local var_359_2 = 0.001

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2
				local var_359_4 = Vector3.New(0, -1.11, -5.9)

				var_359_0.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1041ui_story, var_359_4, var_359_3)

				local var_359_5 = manager.ui.mainCamera.transform.position - var_359_0.position

				var_359_0.forward = Vector3.New(var_359_5.x, var_359_5.y, var_359_5.z)

				local var_359_6 = var_359_0.localEulerAngles

				var_359_6.z = 0
				var_359_6.x = 0
				var_359_0.localEulerAngles = var_359_6
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 then
				var_359_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_359_7 = manager.ui.mainCamera.transform.position - var_359_0.position

				var_359_0.forward = Vector3.New(var_359_7.x, var_359_7.y, var_359_7.z)

				local var_359_8 = var_359_0.localEulerAngles

				var_359_8.z = 0
				var_359_8.x = 0
				var_359_0.localEulerAngles = var_359_8
			end

			local var_359_9 = arg_356_1.actors_["1041ui_story"]
			local var_359_10 = 0

			if var_359_10 < arg_356_1.time_ and arg_356_1.time_ <= var_359_10 + arg_359_0 and not isNil(var_359_9) and arg_356_1.var_.characterEffect1041ui_story == nil then
				arg_356_1.var_.characterEffect1041ui_story = var_359_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_11 = 0.200000002980232

			if var_359_10 <= arg_356_1.time_ and arg_356_1.time_ < var_359_10 + var_359_11 and not isNil(var_359_9) then
				local var_359_12 = (arg_356_1.time_ - var_359_10) / var_359_11

				if arg_356_1.var_.characterEffect1041ui_story and not isNil(var_359_9) then
					arg_356_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= var_359_10 + var_359_11 and arg_356_1.time_ < var_359_10 + var_359_11 + arg_359_0 and not isNil(var_359_9) and arg_356_1.var_.characterEffect1041ui_story then
				arg_356_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_359_13 = 0

			if var_359_13 < arg_356_1.time_ and arg_356_1.time_ <= var_359_13 + arg_359_0 then
				arg_356_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_359_14 = 0
			local var_359_15 = 1.15

			if var_359_14 < arg_356_1.time_ and arg_356_1.time_ <= var_359_14 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_16 = arg_356_1:FormatText(StoryNameCfg[208].name)

				arg_356_1.leftNameTxt_.text = var_359_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_17 = arg_356_1:GetWordFromCfg(1104106086)
				local var_359_18 = arg_356_1:FormatText(var_359_17.content)

				arg_356_1.text_.text = var_359_18

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_19 = 46
				local var_359_20 = utf8.len(var_359_18)
				local var_359_21 = var_359_19 <= 0 and var_359_15 or var_359_15 * (var_359_20 / var_359_19)

				if var_359_21 > 0 and var_359_15 < var_359_21 then
					arg_356_1.talkMaxDuration = var_359_21

					if var_359_21 + var_359_14 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_21 + var_359_14
					end
				end

				arg_356_1.text_.text = var_359_18
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106086", "story_v_side_new_1104106.awb") ~= 0 then
					local var_359_22 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106086", "story_v_side_new_1104106.awb") / 1000

					if var_359_22 + var_359_14 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_22 + var_359_14
					end

					if var_359_17.prefab_name ~= "" and arg_356_1.actors_[var_359_17.prefab_name] ~= nil then
						local var_359_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_17.prefab_name].transform, "story_v_side_new_1104106", "1104106086", "story_v_side_new_1104106.awb")

						arg_356_1:RecordAudio("1104106086", var_359_23)
						arg_356_1:RecordAudio("1104106086", var_359_23)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106086", "story_v_side_new_1104106.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106086", "story_v_side_new_1104106.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_24 = math.max(var_359_15, arg_356_1.talkMaxDuration)

			if var_359_14 <= arg_356_1.time_ and arg_356_1.time_ < var_359_14 + var_359_24 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_14) / var_359_24

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_14 + var_359_24 and arg_356_1.time_ < var_359_14 + var_359_24 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play1104106087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1104106087
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1104106088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["1041ui_story"]
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect1041ui_story == nil then
				arg_360_1.var_.characterEffect1041ui_story = var_363_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 and not isNil(var_363_0) then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2

				if arg_360_1.var_.characterEffect1041ui_story and not isNil(var_363_0) then
					local var_363_4 = Mathf.Lerp(0, 0.5, var_363_3)

					arg_360_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_360_1.var_.characterEffect1041ui_story.fillRatio = var_363_4
				end
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect1041ui_story then
				local var_363_5 = 0.5

				arg_360_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_360_1.var_.characterEffect1041ui_story.fillRatio = var_363_5
			end

			local var_363_6 = 0
			local var_363_7 = 0.125

			if var_363_6 < arg_360_1.time_ and arg_360_1.time_ <= var_363_6 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_8 = arg_360_1:FormatText(StoryNameCfg[7].name)

				arg_360_1.leftNameTxt_.text = var_363_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_9 = arg_360_1:GetWordFromCfg(1104106087)
				local var_363_10 = arg_360_1:FormatText(var_363_9.content)

				arg_360_1.text_.text = var_363_10

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_11 = 5
				local var_363_12 = utf8.len(var_363_10)
				local var_363_13 = var_363_11 <= 0 and var_363_7 or var_363_7 * (var_363_12 / var_363_11)

				if var_363_13 > 0 and var_363_7 < var_363_13 then
					arg_360_1.talkMaxDuration = var_363_13

					if var_363_13 + var_363_6 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_13 + var_363_6
					end
				end

				arg_360_1.text_.text = var_363_10
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_14 = math.max(var_363_7, arg_360_1.talkMaxDuration)

			if var_363_6 <= arg_360_1.time_ and arg_360_1.time_ < var_363_6 + var_363_14 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_6) / var_363_14

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_6 + var_363_14 and arg_360_1.time_ < var_363_6 + var_363_14 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play1104106088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1104106088
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1104106089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 0.4

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, false)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_2 = arg_364_1:GetWordFromCfg(1104106088)
				local var_367_3 = arg_364_1:FormatText(var_367_2.content)

				arg_364_1.text_.text = var_367_3

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_4 = 16
				local var_367_5 = utf8.len(var_367_3)
				local var_367_6 = var_367_4 <= 0 and var_367_1 or var_367_1 * (var_367_5 / var_367_4)

				if var_367_6 > 0 and var_367_1 < var_367_6 then
					arg_364_1.talkMaxDuration = var_367_6

					if var_367_6 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_6 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_3
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_7 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_7 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_7

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_7 and arg_364_1.time_ < var_367_0 + var_367_7 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1104106089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1104106089
		arg_368_1.duration_ = 13.2

		local var_368_0 = {
			zh = 8.833,
			ja = 13.2
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
				arg_368_0:Play1104106090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["1041ui_story"].transform
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 then
				arg_368_1.var_.moveOldPos1041ui_story = var_371_0.localPosition
			end

			local var_371_2 = 0.001

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2
				local var_371_4 = Vector3.New(0, -1.11, -5.9)

				var_371_0.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos1041ui_story, var_371_4, var_371_3)

				local var_371_5 = manager.ui.mainCamera.transform.position - var_371_0.position

				var_371_0.forward = Vector3.New(var_371_5.x, var_371_5.y, var_371_5.z)

				local var_371_6 = var_371_0.localEulerAngles

				var_371_6.z = 0
				var_371_6.x = 0
				var_371_0.localEulerAngles = var_371_6
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 then
				var_371_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_371_7 = manager.ui.mainCamera.transform.position - var_371_0.position

				var_371_0.forward = Vector3.New(var_371_7.x, var_371_7.y, var_371_7.z)

				local var_371_8 = var_371_0.localEulerAngles

				var_371_8.z = 0
				var_371_8.x = 0
				var_371_0.localEulerAngles = var_371_8
			end

			local var_371_9 = arg_368_1.actors_["1041ui_story"]
			local var_371_10 = 0

			if var_371_10 < arg_368_1.time_ and arg_368_1.time_ <= var_371_10 + arg_371_0 and not isNil(var_371_9) and arg_368_1.var_.characterEffect1041ui_story == nil then
				arg_368_1.var_.characterEffect1041ui_story = var_371_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_11 = 0.200000002980232

			if var_371_10 <= arg_368_1.time_ and arg_368_1.time_ < var_371_10 + var_371_11 and not isNil(var_371_9) then
				local var_371_12 = (arg_368_1.time_ - var_371_10) / var_371_11

				if arg_368_1.var_.characterEffect1041ui_story and not isNil(var_371_9) then
					arg_368_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= var_371_10 + var_371_11 and arg_368_1.time_ < var_371_10 + var_371_11 + arg_371_0 and not isNil(var_371_9) and arg_368_1.var_.characterEffect1041ui_story then
				arg_368_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_371_13 = 0

			if var_371_13 < arg_368_1.time_ and arg_368_1.time_ <= var_371_13 + arg_371_0 then
				arg_368_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_371_14 = 0
			local var_371_15 = 1.125

			if var_371_14 < arg_368_1.time_ and arg_368_1.time_ <= var_371_14 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_16 = arg_368_1:FormatText(StoryNameCfg[208].name)

				arg_368_1.leftNameTxt_.text = var_371_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_17 = arg_368_1:GetWordFromCfg(1104106089)
				local var_371_18 = arg_368_1:FormatText(var_371_17.content)

				arg_368_1.text_.text = var_371_18

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_19 = 45
				local var_371_20 = utf8.len(var_371_18)
				local var_371_21 = var_371_19 <= 0 and var_371_15 or var_371_15 * (var_371_20 / var_371_19)

				if var_371_21 > 0 and var_371_15 < var_371_21 then
					arg_368_1.talkMaxDuration = var_371_21

					if var_371_21 + var_371_14 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_21 + var_371_14
					end
				end

				arg_368_1.text_.text = var_371_18
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106089", "story_v_side_new_1104106.awb") ~= 0 then
					local var_371_22 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106089", "story_v_side_new_1104106.awb") / 1000

					if var_371_22 + var_371_14 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_22 + var_371_14
					end

					if var_371_17.prefab_name ~= "" and arg_368_1.actors_[var_371_17.prefab_name] ~= nil then
						local var_371_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_17.prefab_name].transform, "story_v_side_new_1104106", "1104106089", "story_v_side_new_1104106.awb")

						arg_368_1:RecordAudio("1104106089", var_371_23)
						arg_368_1:RecordAudio("1104106089", var_371_23)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106089", "story_v_side_new_1104106.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106089", "story_v_side_new_1104106.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_24 = math.max(var_371_15, arg_368_1.talkMaxDuration)

			if var_371_14 <= arg_368_1.time_ and arg_368_1.time_ < var_371_14 + var_371_24 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_14) / var_371_24

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_14 + var_371_24 and arg_368_1.time_ < var_371_14 + var_371_24 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play1104106090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1104106090
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1104106091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["1041ui_story"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect1041ui_story == nil then
				arg_372_1.var_.characterEffect1041ui_story = var_375_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.200000002980232

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.characterEffect1041ui_story and not isNil(var_375_0) then
					local var_375_4 = Mathf.Lerp(0, 0.5, var_375_3)

					arg_372_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_372_1.var_.characterEffect1041ui_story.fillRatio = var_375_4
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect1041ui_story then
				local var_375_5 = 0.5

				arg_372_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_372_1.var_.characterEffect1041ui_story.fillRatio = var_375_5
			end

			local var_375_6 = 0
			local var_375_7 = 0.05

			if var_375_6 < arg_372_1.time_ and arg_372_1.time_ <= var_375_6 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_8 = arg_372_1:FormatText(StoryNameCfg[7].name)

				arg_372_1.leftNameTxt_.text = var_375_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_9 = arg_372_1:GetWordFromCfg(1104106090)
				local var_375_10 = arg_372_1:FormatText(var_375_9.content)

				arg_372_1.text_.text = var_375_10

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_11 = 2
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
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_14 = math.max(var_375_7, arg_372_1.talkMaxDuration)

			if var_375_6 <= arg_372_1.time_ and arg_372_1.time_ < var_375_6 + var_375_14 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_6) / var_375_14

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_6 + var_375_14 and arg_372_1.time_ < var_375_6 + var_375_14 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1104106091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1104106091
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1104106092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 1.125

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_2 = arg_376_1:GetWordFromCfg(1104106091)
				local var_379_3 = arg_376_1:FormatText(var_379_2.content)

				arg_376_1.text_.text = var_379_3

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_4 = 45
				local var_379_5 = utf8.len(var_379_3)
				local var_379_6 = var_379_4 <= 0 and var_379_1 or var_379_1 * (var_379_5 / var_379_4)

				if var_379_6 > 0 and var_379_1 < var_379_6 then
					arg_376_1.talkMaxDuration = var_379_6

					if var_379_6 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_6 + var_379_0
					end
				end

				arg_376_1.text_.text = var_379_3
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_7 = math.max(var_379_1, arg_376_1.talkMaxDuration)

			if var_379_0 <= arg_376_1.time_ and arg_376_1.time_ < var_379_0 + var_379_7 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_0) / var_379_7

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_0 + var_379_7 and arg_376_1.time_ < var_379_0 + var_379_7 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play1104106092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1104106092
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1104106093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 0.95

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_2 = arg_380_1:GetWordFromCfg(1104106092)
				local var_383_3 = arg_380_1:FormatText(var_383_2.content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_4 = 38
				local var_383_5 = utf8.len(var_383_3)
				local var_383_6 = var_383_4 <= 0 and var_383_1 or var_383_1 * (var_383_5 / var_383_4)

				if var_383_6 > 0 and var_383_1 < var_383_6 then
					arg_380_1.talkMaxDuration = var_383_6

					if var_383_6 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_6 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_3
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_7 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_7 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_7

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_7 and arg_380_1.time_ < var_383_0 + var_383_7 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play1104106093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1104106093
		arg_384_1.duration_ = 14.5

		local var_384_0 = {
			zh = 14.5,
			ja = 14.366
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
				arg_384_0:Play1104106094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["1041ui_story"].transform
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1.var_.moveOldPos1041ui_story = var_387_0.localPosition
			end

			local var_387_2 = 0.001

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2
				local var_387_4 = Vector3.New(0, -1.11, -5.9)

				var_387_0.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos1041ui_story, var_387_4, var_387_3)

				local var_387_5 = manager.ui.mainCamera.transform.position - var_387_0.position

				var_387_0.forward = Vector3.New(var_387_5.x, var_387_5.y, var_387_5.z)

				local var_387_6 = var_387_0.localEulerAngles

				var_387_6.z = 0
				var_387_6.x = 0
				var_387_0.localEulerAngles = var_387_6
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 then
				var_387_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_387_7 = manager.ui.mainCamera.transform.position - var_387_0.position

				var_387_0.forward = Vector3.New(var_387_7.x, var_387_7.y, var_387_7.z)

				local var_387_8 = var_387_0.localEulerAngles

				var_387_8.z = 0
				var_387_8.x = 0
				var_387_0.localEulerAngles = var_387_8
			end

			local var_387_9 = arg_384_1.actors_["1041ui_story"]
			local var_387_10 = 0

			if var_387_10 < arg_384_1.time_ and arg_384_1.time_ <= var_387_10 + arg_387_0 and not isNil(var_387_9) and arg_384_1.var_.characterEffect1041ui_story == nil then
				arg_384_1.var_.characterEffect1041ui_story = var_387_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_11 = 0.200000002980232

			if var_387_10 <= arg_384_1.time_ and arg_384_1.time_ < var_387_10 + var_387_11 and not isNil(var_387_9) then
				local var_387_12 = (arg_384_1.time_ - var_387_10) / var_387_11

				if arg_384_1.var_.characterEffect1041ui_story and not isNil(var_387_9) then
					arg_384_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= var_387_10 + var_387_11 and arg_384_1.time_ < var_387_10 + var_387_11 + arg_387_0 and not isNil(var_387_9) and arg_384_1.var_.characterEffect1041ui_story then
				arg_384_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_387_13 = 0

			if var_387_13 < arg_384_1.time_ and arg_384_1.time_ <= var_387_13 + arg_387_0 then
				arg_384_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_387_14 = 0
			local var_387_15 = 1.525

			if var_387_14 < arg_384_1.time_ and arg_384_1.time_ <= var_387_14 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_16 = arg_384_1:FormatText(StoryNameCfg[208].name)

				arg_384_1.leftNameTxt_.text = var_387_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_17 = arg_384_1:GetWordFromCfg(1104106093)
				local var_387_18 = arg_384_1:FormatText(var_387_17.content)

				arg_384_1.text_.text = var_387_18

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_19 = 61
				local var_387_20 = utf8.len(var_387_18)
				local var_387_21 = var_387_19 <= 0 and var_387_15 or var_387_15 * (var_387_20 / var_387_19)

				if var_387_21 > 0 and var_387_15 < var_387_21 then
					arg_384_1.talkMaxDuration = var_387_21

					if var_387_21 + var_387_14 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_21 + var_387_14
					end
				end

				arg_384_1.text_.text = var_387_18
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106093", "story_v_side_new_1104106.awb") ~= 0 then
					local var_387_22 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106093", "story_v_side_new_1104106.awb") / 1000

					if var_387_22 + var_387_14 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_22 + var_387_14
					end

					if var_387_17.prefab_name ~= "" and arg_384_1.actors_[var_387_17.prefab_name] ~= nil then
						local var_387_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_17.prefab_name].transform, "story_v_side_new_1104106", "1104106093", "story_v_side_new_1104106.awb")

						arg_384_1:RecordAudio("1104106093", var_387_23)
						arg_384_1:RecordAudio("1104106093", var_387_23)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106093", "story_v_side_new_1104106.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106093", "story_v_side_new_1104106.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_24 = math.max(var_387_15, arg_384_1.talkMaxDuration)

			if var_387_14 <= arg_384_1.time_ and arg_384_1.time_ < var_387_14 + var_387_24 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_14) / var_387_24

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_14 + var_387_24 and arg_384_1.time_ < var_387_14 + var_387_24 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play1104106094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1104106094
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1104106095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1041ui_story"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1041ui_story == nil then
				arg_388_1.var_.characterEffect1041ui_story = var_391_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.200000002980232

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.characterEffect1041ui_story and not isNil(var_391_0) then
					local var_391_4 = Mathf.Lerp(0, 0.5, var_391_3)

					arg_388_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_388_1.var_.characterEffect1041ui_story.fillRatio = var_391_4
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect1041ui_story then
				local var_391_5 = 0.5

				arg_388_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_388_1.var_.characterEffect1041ui_story.fillRatio = var_391_5
			end

			local var_391_6 = 0
			local var_391_7 = 0.225

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

				local var_391_8 = arg_388_1:GetWordFromCfg(1104106094)
				local var_391_9 = arg_388_1:FormatText(var_391_8.content)

				arg_388_1.text_.text = var_391_9

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_10 = 9
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
	Play1104106095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1104106095
		arg_392_1.duration_ = 7.93

		local var_392_0 = {
			zh = 5.033,
			ja = 7.933
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
				arg_392_0:Play1104106096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1041ui_story"].transform
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.var_.moveOldPos1041ui_story = var_395_0.localPosition
			end

			local var_395_2 = 0.001

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2
				local var_395_4 = Vector3.New(0, -1.11, -5.9)

				var_395_0.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1041ui_story, var_395_4, var_395_3)

				local var_395_5 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_5.x, var_395_5.y, var_395_5.z)

				local var_395_6 = var_395_0.localEulerAngles

				var_395_6.z = 0
				var_395_6.x = 0
				var_395_0.localEulerAngles = var_395_6
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 then
				var_395_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_395_7 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_7.x, var_395_7.y, var_395_7.z)

				local var_395_8 = var_395_0.localEulerAngles

				var_395_8.z = 0
				var_395_8.x = 0
				var_395_0.localEulerAngles = var_395_8
			end

			local var_395_9 = arg_392_1.actors_["1041ui_story"]
			local var_395_10 = 0

			if var_395_10 < arg_392_1.time_ and arg_392_1.time_ <= var_395_10 + arg_395_0 and not isNil(var_395_9) and arg_392_1.var_.characterEffect1041ui_story == nil then
				arg_392_1.var_.characterEffect1041ui_story = var_395_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_11 = 0.200000002980232

			if var_395_10 <= arg_392_1.time_ and arg_392_1.time_ < var_395_10 + var_395_11 and not isNil(var_395_9) then
				local var_395_12 = (arg_392_1.time_ - var_395_10) / var_395_11

				if arg_392_1.var_.characterEffect1041ui_story and not isNil(var_395_9) then
					arg_392_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= var_395_10 + var_395_11 and arg_392_1.time_ < var_395_10 + var_395_11 + arg_395_0 and not isNil(var_395_9) and arg_392_1.var_.characterEffect1041ui_story then
				arg_392_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_395_13 = 0

			if var_395_13 < arg_392_1.time_ and arg_392_1.time_ <= var_395_13 + arg_395_0 then
				arg_392_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_395_14 = 0
			local var_395_15 = 0.75

			if var_395_14 < arg_392_1.time_ and arg_392_1.time_ <= var_395_14 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_16 = arg_392_1:FormatText(StoryNameCfg[208].name)

				arg_392_1.leftNameTxt_.text = var_395_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_17 = arg_392_1:GetWordFromCfg(1104106095)
				local var_395_18 = arg_392_1:FormatText(var_395_17.content)

				arg_392_1.text_.text = var_395_18

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_19 = 30
				local var_395_20 = utf8.len(var_395_18)
				local var_395_21 = var_395_19 <= 0 and var_395_15 or var_395_15 * (var_395_20 / var_395_19)

				if var_395_21 > 0 and var_395_15 < var_395_21 then
					arg_392_1.talkMaxDuration = var_395_21

					if var_395_21 + var_395_14 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_21 + var_395_14
					end
				end

				arg_392_1.text_.text = var_395_18
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106095", "story_v_side_new_1104106.awb") ~= 0 then
					local var_395_22 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106095", "story_v_side_new_1104106.awb") / 1000

					if var_395_22 + var_395_14 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_22 + var_395_14
					end

					if var_395_17.prefab_name ~= "" and arg_392_1.actors_[var_395_17.prefab_name] ~= nil then
						local var_395_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_17.prefab_name].transform, "story_v_side_new_1104106", "1104106095", "story_v_side_new_1104106.awb")

						arg_392_1:RecordAudio("1104106095", var_395_23)
						arg_392_1:RecordAudio("1104106095", var_395_23)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106095", "story_v_side_new_1104106.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106095", "story_v_side_new_1104106.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_24 = math.max(var_395_15, arg_392_1.talkMaxDuration)

			if var_395_14 <= arg_392_1.time_ and arg_392_1.time_ < var_395_14 + var_395_24 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_14) / var_395_24

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_14 + var_395_24 and arg_392_1.time_ < var_395_14 + var_395_24 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play1104106096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1104106096
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play1104106097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["1041ui_story"]
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect1041ui_story == nil then
				arg_396_1.var_.characterEffect1041ui_story = var_399_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_2 = 0.200000002980232

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 and not isNil(var_399_0) then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2

				if arg_396_1.var_.characterEffect1041ui_story and not isNil(var_399_0) then
					local var_399_4 = Mathf.Lerp(0, 0.5, var_399_3)

					arg_396_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_396_1.var_.characterEffect1041ui_story.fillRatio = var_399_4
				end
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect1041ui_story then
				local var_399_5 = 0.5

				arg_396_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_396_1.var_.characterEffect1041ui_story.fillRatio = var_399_5
			end

			local var_399_6 = 0
			local var_399_7 = 0.05

			if var_399_6 < arg_396_1.time_ and arg_396_1.time_ <= var_399_6 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_8 = arg_396_1:FormatText(StoryNameCfg[7].name)

				arg_396_1.leftNameTxt_.text = var_399_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_9 = arg_396_1:GetWordFromCfg(1104106096)
				local var_399_10 = arg_396_1:FormatText(var_399_9.content)

				arg_396_1.text_.text = var_399_10

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_11 = 2
				local var_399_12 = utf8.len(var_399_10)
				local var_399_13 = var_399_11 <= 0 and var_399_7 or var_399_7 * (var_399_12 / var_399_11)

				if var_399_13 > 0 and var_399_7 < var_399_13 then
					arg_396_1.talkMaxDuration = var_399_13

					if var_399_13 + var_399_6 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_13 + var_399_6
					end
				end

				arg_396_1.text_.text = var_399_10
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_14 = math.max(var_399_7, arg_396_1.talkMaxDuration)

			if var_399_6 <= arg_396_1.time_ and arg_396_1.time_ < var_399_6 + var_399_14 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_6) / var_399_14

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_6 + var_399_14 and arg_396_1.time_ < var_399_6 + var_399_14 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play1104106097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1104106097
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1104106098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 0.466666666666667

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				local var_403_2 = "play"
				local var_403_3 = "music"

				arg_400_1:AudioAction(var_403_2, var_403_3, "bgm_side_daily07", "bgm_side_daily07", "bgm_side_daily07.awb")

				local var_403_4 = ""
				local var_403_5 = manager.audio:GetAudioName("bgm_side_daily07", "bgm_side_daily07")

				if var_403_5 ~= "" then
					if arg_400_1.bgmTxt_.text ~= var_403_5 and arg_400_1.bgmTxt_.text ~= "" then
						if arg_400_1.bgmTxt2_.text ~= "" then
							arg_400_1.bgmTxt_.text = arg_400_1.bgmTxt2_.text
						end

						arg_400_1.bgmTxt2_.text = var_403_5

						arg_400_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_400_1.bgmTxt_.text = var_403_5
						arg_400_1.bgmTxt2_.text = var_403_5
					end

					if arg_400_1.bgmTimer then
						arg_400_1.bgmTimer:Stop()

						arg_400_1.bgmTimer = nil
					end

					if arg_400_1.settingData.show_music_name == 1 then
						arg_400_1.musicController:SetSelectedState("show")
						arg_400_1.musicAnimator_:Play("open", 0, 0)

						if arg_400_1.settingData.music_time ~= 0 then
							arg_400_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_400_1.settingData.music_time), function()
								if arg_400_1 == nil or isNil(arg_400_1.bgmTxt_) then
									return
								end

								arg_400_1.musicController:SetSelectedState("hide")
								arg_400_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_403_6 = 0
			local var_403_7 = 0.925

			if var_403_6 < arg_400_1.time_ and arg_400_1.time_ <= var_403_6 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_8 = arg_400_1:FormatText(StoryNameCfg[7].name)

				arg_400_1.leftNameTxt_.text = var_403_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_9 = arg_400_1:GetWordFromCfg(1104106097)
				local var_403_10 = arg_400_1:FormatText(var_403_9.content)

				arg_400_1.text_.text = var_403_10

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_11 = 37
				local var_403_12 = utf8.len(var_403_10)
				local var_403_13 = var_403_11 <= 0 and var_403_7 or var_403_7 * (var_403_12 / var_403_11)

				if var_403_13 > 0 and var_403_7 < var_403_13 then
					arg_400_1.talkMaxDuration = var_403_13

					if var_403_13 + var_403_6 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_13 + var_403_6
					end
				end

				arg_400_1.text_.text = var_403_10
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_14 = math.max(var_403_7, arg_400_1.talkMaxDuration)

			if var_403_6 <= arg_400_1.time_ and arg_400_1.time_ < var_403_6 + var_403_14 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_6) / var_403_14

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_6 + var_403_14 and arg_400_1.time_ < var_403_6 + var_403_14 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play1104106098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1104106098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1104106099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0
			local var_408_1 = 0.7

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_2 = arg_405_1:FormatText(StoryNameCfg[7].name)

				arg_405_1.leftNameTxt_.text = var_408_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_3 = arg_405_1:GetWordFromCfg(1104106098)
				local var_408_4 = arg_405_1:FormatText(var_408_3.content)

				arg_405_1.text_.text = var_408_4

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 28
				local var_408_6 = utf8.len(var_408_4)
				local var_408_7 = var_408_5 <= 0 and var_408_1 or var_408_1 * (var_408_6 / var_408_5)

				if var_408_7 > 0 and var_408_1 < var_408_7 then
					arg_405_1.talkMaxDuration = var_408_7

					if var_408_7 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_7 + var_408_0
					end
				end

				arg_405_1.text_.text = var_408_4
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_8 = math.max(var_408_1, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_8 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_0) / var_408_8

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_8 and arg_405_1.time_ < var_408_0 + var_408_8 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1104106099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1104106099
		arg_409_1.duration_ = 2

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1104106100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1041ui_story"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos1041ui_story = var_412_0.localPosition
			end

			local var_412_2 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2
				local var_412_4 = Vector3.New(0, -1.11, -5.9)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1041ui_story, var_412_4, var_412_3)

				local var_412_5 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_5.x, var_412_5.y, var_412_5.z)

				local var_412_6 = var_412_0.localEulerAngles

				var_412_6.z = 0
				var_412_6.x = 0
				var_412_0.localEulerAngles = var_412_6
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_412_7 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_7.x, var_412_7.y, var_412_7.z)

				local var_412_8 = var_412_0.localEulerAngles

				var_412_8.z = 0
				var_412_8.x = 0
				var_412_0.localEulerAngles = var_412_8
			end

			local var_412_9 = arg_409_1.actors_["1041ui_story"]
			local var_412_10 = 0

			if var_412_10 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1041ui_story == nil then
				arg_409_1.var_.characterEffect1041ui_story = var_412_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_11 = 0.200000002980232

			if var_412_10 <= arg_409_1.time_ and arg_409_1.time_ < var_412_10 + var_412_11 and not isNil(var_412_9) then
				local var_412_12 = (arg_409_1.time_ - var_412_10) / var_412_11

				if arg_409_1.var_.characterEffect1041ui_story and not isNil(var_412_9) then
					arg_409_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= var_412_10 + var_412_11 and arg_409_1.time_ < var_412_10 + var_412_11 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1041ui_story then
				arg_409_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_412_13 = 0

			if var_412_13 < arg_409_1.time_ and arg_409_1.time_ <= var_412_13 + arg_412_0 then
				arg_409_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_412_14 = 0
			local var_412_15 = 0.05

			if var_412_14 < arg_409_1.time_ and arg_409_1.time_ <= var_412_14 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_16 = arg_409_1:FormatText(StoryNameCfg[208].name)

				arg_409_1.leftNameTxt_.text = var_412_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_17 = arg_409_1:GetWordFromCfg(1104106099)
				local var_412_18 = arg_409_1:FormatText(var_412_17.content)

				arg_409_1.text_.text = var_412_18

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_19 = 2
				local var_412_20 = utf8.len(var_412_18)
				local var_412_21 = var_412_19 <= 0 and var_412_15 or var_412_15 * (var_412_20 / var_412_19)

				if var_412_21 > 0 and var_412_15 < var_412_21 then
					arg_409_1.talkMaxDuration = var_412_21

					if var_412_21 + var_412_14 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_21 + var_412_14
					end
				end

				arg_409_1.text_.text = var_412_18
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106099", "story_v_side_new_1104106.awb") ~= 0 then
					local var_412_22 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106099", "story_v_side_new_1104106.awb") / 1000

					if var_412_22 + var_412_14 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_22 + var_412_14
					end

					if var_412_17.prefab_name ~= "" and arg_409_1.actors_[var_412_17.prefab_name] ~= nil then
						local var_412_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_17.prefab_name].transform, "story_v_side_new_1104106", "1104106099", "story_v_side_new_1104106.awb")

						arg_409_1:RecordAudio("1104106099", var_412_23)
						arg_409_1:RecordAudio("1104106099", var_412_23)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106099", "story_v_side_new_1104106.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106099", "story_v_side_new_1104106.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_24 = math.max(var_412_15, arg_409_1.talkMaxDuration)

			if var_412_14 <= arg_409_1.time_ and arg_409_1.time_ < var_412_14 + var_412_24 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_14) / var_412_24

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_14 + var_412_24 and arg_409_1.time_ < var_412_14 + var_412_24 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play1104106100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1104106100
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1104106101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1041ui_story"]
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1041ui_story == nil then
				arg_413_1.var_.characterEffect1041ui_story = var_416_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 and not isNil(var_416_0) then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2

				if arg_413_1.var_.characterEffect1041ui_story and not isNil(var_416_0) then
					local var_416_4 = Mathf.Lerp(0, 0.5, var_416_3)

					arg_413_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1041ui_story.fillRatio = var_416_4
				end
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1041ui_story then
				local var_416_5 = 0.5

				arg_413_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1041ui_story.fillRatio = var_416_5
			end

			local var_416_6 = 0
			local var_416_7 = 0.75

			if var_416_6 < arg_413_1.time_ and arg_413_1.time_ <= var_416_6 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_8 = arg_413_1:GetWordFromCfg(1104106100)
				local var_416_9 = arg_413_1:FormatText(var_416_8.content)

				arg_413_1.text_.text = var_416_9

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_10 = 30
				local var_416_11 = utf8.len(var_416_9)
				local var_416_12 = var_416_10 <= 0 and var_416_7 or var_416_7 * (var_416_11 / var_416_10)

				if var_416_12 > 0 and var_416_7 < var_416_12 then
					arg_413_1.talkMaxDuration = var_416_12

					if var_416_12 + var_416_6 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_12 + var_416_6
					end
				end

				arg_413_1.text_.text = var_416_9
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_13 = math.max(var_416_7, arg_413_1.talkMaxDuration)

			if var_416_6 <= arg_413_1.time_ and arg_413_1.time_ < var_416_6 + var_416_13 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_6) / var_416_13

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_6 + var_416_13 and arg_413_1.time_ < var_416_6 + var_416_13 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play1104106101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1104106101
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1104106102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0
			local var_420_1 = 1.65

			if var_420_0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_2 = arg_417_1:FormatText(StoryNameCfg[7].name)

				arg_417_1.leftNameTxt_.text = var_420_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_3 = arg_417_1:GetWordFromCfg(1104106101)
				local var_420_4 = arg_417_1:FormatText(var_420_3.content)

				arg_417_1.text_.text = var_420_4

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 66
				local var_420_6 = utf8.len(var_420_4)
				local var_420_7 = var_420_5 <= 0 and var_420_1 or var_420_1 * (var_420_6 / var_420_5)

				if var_420_7 > 0 and var_420_1 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_0
					end
				end

				arg_417_1.text_.text = var_420_4
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_8 = math.max(var_420_1, arg_417_1.talkMaxDuration)

			if var_420_0 <= arg_417_1.time_ and arg_417_1.time_ < var_420_0 + var_420_8 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_0) / var_420_8

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_0 + var_420_8 and arg_417_1.time_ < var_420_0 + var_420_8 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play1104106102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1104106102
		arg_421_1.duration_ = 2

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1104106103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["1041ui_story"].transform
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.var_.moveOldPos1041ui_story = var_424_0.localPosition
			end

			local var_424_2 = 0.001

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2
				local var_424_4 = Vector3.New(0, -1.11, -5.9)

				var_424_0.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1041ui_story, var_424_4, var_424_3)

				local var_424_5 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_5.x, var_424_5.y, var_424_5.z)

				local var_424_6 = var_424_0.localEulerAngles

				var_424_6.z = 0
				var_424_6.x = 0
				var_424_0.localEulerAngles = var_424_6
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 then
				var_424_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_424_7 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_7.x, var_424_7.y, var_424_7.z)

				local var_424_8 = var_424_0.localEulerAngles

				var_424_8.z = 0
				var_424_8.x = 0
				var_424_0.localEulerAngles = var_424_8
			end

			local var_424_9 = arg_421_1.actors_["1041ui_story"]
			local var_424_10 = 0

			if var_424_10 < arg_421_1.time_ and arg_421_1.time_ <= var_424_10 + arg_424_0 and not isNil(var_424_9) and arg_421_1.var_.characterEffect1041ui_story == nil then
				arg_421_1.var_.characterEffect1041ui_story = var_424_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_11 = 0.200000002980232

			if var_424_10 <= arg_421_1.time_ and arg_421_1.time_ < var_424_10 + var_424_11 and not isNil(var_424_9) then
				local var_424_12 = (arg_421_1.time_ - var_424_10) / var_424_11

				if arg_421_1.var_.characterEffect1041ui_story and not isNil(var_424_9) then
					arg_421_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= var_424_10 + var_424_11 and arg_421_1.time_ < var_424_10 + var_424_11 + arg_424_0 and not isNil(var_424_9) and arg_421_1.var_.characterEffect1041ui_story then
				arg_421_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_424_13 = 0

			if var_424_13 < arg_421_1.time_ and arg_421_1.time_ <= var_424_13 + arg_424_0 then
				arg_421_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_424_14 = 0

			if var_424_14 < arg_421_1.time_ and arg_421_1.time_ <= var_424_14 + arg_424_0 then
				arg_421_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_424_15 = 0
			local var_424_16 = 0.05

			if var_424_15 < arg_421_1.time_ and arg_421_1.time_ <= var_424_15 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_17 = arg_421_1:FormatText(StoryNameCfg[208].name)

				arg_421_1.leftNameTxt_.text = var_424_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_18 = arg_421_1:GetWordFromCfg(1104106102)
				local var_424_19 = arg_421_1:FormatText(var_424_18.content)

				arg_421_1.text_.text = var_424_19

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_20 = 2
				local var_424_21 = utf8.len(var_424_19)
				local var_424_22 = var_424_20 <= 0 and var_424_16 or var_424_16 * (var_424_21 / var_424_20)

				if var_424_22 > 0 and var_424_16 < var_424_22 then
					arg_421_1.talkMaxDuration = var_424_22

					if var_424_22 + var_424_15 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_22 + var_424_15
					end
				end

				arg_421_1.text_.text = var_424_19
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106102", "story_v_side_new_1104106.awb") ~= 0 then
					local var_424_23 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106102", "story_v_side_new_1104106.awb") / 1000

					if var_424_23 + var_424_15 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_23 + var_424_15
					end

					if var_424_18.prefab_name ~= "" and arg_421_1.actors_[var_424_18.prefab_name] ~= nil then
						local var_424_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_18.prefab_name].transform, "story_v_side_new_1104106", "1104106102", "story_v_side_new_1104106.awb")

						arg_421_1:RecordAudio("1104106102", var_424_24)
						arg_421_1:RecordAudio("1104106102", var_424_24)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106102", "story_v_side_new_1104106.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106102", "story_v_side_new_1104106.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_25 = math.max(var_424_16, arg_421_1.talkMaxDuration)

			if var_424_15 <= arg_421_1.time_ and arg_421_1.time_ < var_424_15 + var_424_25 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_15) / var_424_25

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_15 + var_424_25 and arg_421_1.time_ < var_424_15 + var_424_25 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play1104106103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1104106103
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1104106104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1041ui_story"]
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1041ui_story == nil then
				arg_425_1.var_.characterEffect1041ui_story = var_428_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.200000002980232

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 and not isNil(var_428_0) then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2

				if arg_425_1.var_.characterEffect1041ui_story and not isNil(var_428_0) then
					local var_428_4 = Mathf.Lerp(0, 0.5, var_428_3)

					arg_425_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1041ui_story.fillRatio = var_428_4
				end
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1041ui_story then
				local var_428_5 = 0.5

				arg_425_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1041ui_story.fillRatio = var_428_5
			end

			local var_428_6 = 0
			local var_428_7 = 0.75

			if var_428_6 < arg_425_1.time_ and arg_425_1.time_ <= var_428_6 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_8 = arg_425_1:GetWordFromCfg(1104106103)
				local var_428_9 = arg_425_1:FormatText(var_428_8.content)

				arg_425_1.text_.text = var_428_9

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_10 = 30
				local var_428_11 = utf8.len(var_428_9)
				local var_428_12 = var_428_10 <= 0 and var_428_7 or var_428_7 * (var_428_11 / var_428_10)

				if var_428_12 > 0 and var_428_7 < var_428_12 then
					arg_425_1.talkMaxDuration = var_428_12

					if var_428_12 + var_428_6 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_12 + var_428_6
					end
				end

				arg_425_1.text_.text = var_428_9
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_13 = math.max(var_428_7, arg_425_1.talkMaxDuration)

			if var_428_6 <= arg_425_1.time_ and arg_425_1.time_ < var_428_6 + var_428_13 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_6) / var_428_13

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_6 + var_428_13 and arg_425_1.time_ < var_428_6 + var_428_13 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1104106104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1104106104
		arg_429_1.duration_ = 11.77

		local var_429_0 = {
			zh = 8.233,
			ja = 11.766
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1104106105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["1041ui_story"].transform
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.var_.moveOldPos1041ui_story = var_432_0.localPosition
			end

			local var_432_2 = 0.001

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2
				local var_432_4 = Vector3.New(0, -1.11, -5.9)

				var_432_0.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1041ui_story, var_432_4, var_432_3)

				local var_432_5 = manager.ui.mainCamera.transform.position - var_432_0.position

				var_432_0.forward = Vector3.New(var_432_5.x, var_432_5.y, var_432_5.z)

				local var_432_6 = var_432_0.localEulerAngles

				var_432_6.z = 0
				var_432_6.x = 0
				var_432_0.localEulerAngles = var_432_6
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 then
				var_432_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_432_7 = manager.ui.mainCamera.transform.position - var_432_0.position

				var_432_0.forward = Vector3.New(var_432_7.x, var_432_7.y, var_432_7.z)

				local var_432_8 = var_432_0.localEulerAngles

				var_432_8.z = 0
				var_432_8.x = 0
				var_432_0.localEulerAngles = var_432_8
			end

			local var_432_9 = arg_429_1.actors_["1041ui_story"]
			local var_432_10 = 0

			if var_432_10 < arg_429_1.time_ and arg_429_1.time_ <= var_432_10 + arg_432_0 and not isNil(var_432_9) and arg_429_1.var_.characterEffect1041ui_story == nil then
				arg_429_1.var_.characterEffect1041ui_story = var_432_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_11 = 0.200000002980232

			if var_432_10 <= arg_429_1.time_ and arg_429_1.time_ < var_432_10 + var_432_11 and not isNil(var_432_9) then
				local var_432_12 = (arg_429_1.time_ - var_432_10) / var_432_11

				if arg_429_1.var_.characterEffect1041ui_story and not isNil(var_432_9) then
					arg_429_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= var_432_10 + var_432_11 and arg_429_1.time_ < var_432_10 + var_432_11 + arg_432_0 and not isNil(var_432_9) and arg_429_1.var_.characterEffect1041ui_story then
				arg_429_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_432_13 = 0

			if var_432_13 < arg_429_1.time_ and arg_429_1.time_ <= var_432_13 + arg_432_0 then
				arg_429_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_432_14 = 0
			local var_432_15 = 0.975

			if var_432_14 < arg_429_1.time_ and arg_429_1.time_ <= var_432_14 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_16 = arg_429_1:FormatText(StoryNameCfg[208].name)

				arg_429_1.leftNameTxt_.text = var_432_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_17 = arg_429_1:GetWordFromCfg(1104106104)
				local var_432_18 = arg_429_1:FormatText(var_432_17.content)

				arg_429_1.text_.text = var_432_18

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_19 = 39
				local var_432_20 = utf8.len(var_432_18)
				local var_432_21 = var_432_19 <= 0 and var_432_15 or var_432_15 * (var_432_20 / var_432_19)

				if var_432_21 > 0 and var_432_15 < var_432_21 then
					arg_429_1.talkMaxDuration = var_432_21

					if var_432_21 + var_432_14 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_21 + var_432_14
					end
				end

				arg_429_1.text_.text = var_432_18
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106104", "story_v_side_new_1104106.awb") ~= 0 then
					local var_432_22 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106104", "story_v_side_new_1104106.awb") / 1000

					if var_432_22 + var_432_14 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_22 + var_432_14
					end

					if var_432_17.prefab_name ~= "" and arg_429_1.actors_[var_432_17.prefab_name] ~= nil then
						local var_432_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_17.prefab_name].transform, "story_v_side_new_1104106", "1104106104", "story_v_side_new_1104106.awb")

						arg_429_1:RecordAudio("1104106104", var_432_23)
						arg_429_1:RecordAudio("1104106104", var_432_23)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106104", "story_v_side_new_1104106.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106104", "story_v_side_new_1104106.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_24 = math.max(var_432_15, arg_429_1.talkMaxDuration)

			if var_432_14 <= arg_429_1.time_ and arg_429_1.time_ < var_432_14 + var_432_24 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_14) / var_432_24

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_14 + var_432_24 and arg_429_1.time_ < var_432_14 + var_432_24 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play1104106105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1104106105
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1104106106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["1041ui_story"]
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.characterEffect1041ui_story == nil then
				arg_433_1.var_.characterEffect1041ui_story = var_436_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.200000002980232

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_2 and not isNil(var_436_0) then
				local var_436_3 = (arg_433_1.time_ - var_436_1) / var_436_2

				if arg_433_1.var_.characterEffect1041ui_story and not isNil(var_436_0) then
					local var_436_4 = Mathf.Lerp(0, 0.5, var_436_3)

					arg_433_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1041ui_story.fillRatio = var_436_4
				end
			end

			if arg_433_1.time_ >= var_436_1 + var_436_2 and arg_433_1.time_ < var_436_1 + var_436_2 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.characterEffect1041ui_story then
				local var_436_5 = 0.5

				arg_433_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1041ui_story.fillRatio = var_436_5
			end

			local var_436_6 = 0
			local var_436_7 = 0.1

			if var_436_6 < arg_433_1.time_ and arg_433_1.time_ <= var_436_6 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_8 = arg_433_1:FormatText(StoryNameCfg[7].name)

				arg_433_1.leftNameTxt_.text = var_436_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_9 = arg_433_1:GetWordFromCfg(1104106105)
				local var_436_10 = arg_433_1:FormatText(var_436_9.content)

				arg_433_1.text_.text = var_436_10

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_11 = 4
				local var_436_12 = utf8.len(var_436_10)
				local var_436_13 = var_436_11 <= 0 and var_436_7 or var_436_7 * (var_436_12 / var_436_11)

				if var_436_13 > 0 and var_436_7 < var_436_13 then
					arg_433_1.talkMaxDuration = var_436_13

					if var_436_13 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_13 + var_436_6
					end
				end

				arg_433_1.text_.text = var_436_10
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_14 = math.max(var_436_7, arg_433_1.talkMaxDuration)

			if var_436_6 <= arg_433_1.time_ and arg_433_1.time_ < var_436_6 + var_436_14 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_6) / var_436_14

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_6 + var_436_14 and arg_433_1.time_ < var_436_6 + var_436_14 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1104106106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1104106106
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1104106107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0
			local var_440_1 = 0.525

			if var_440_0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_2 = arg_437_1:GetWordFromCfg(1104106106)
				local var_440_3 = arg_437_1:FormatText(var_440_2.content)

				arg_437_1.text_.text = var_440_3

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_4 = 21
				local var_440_5 = utf8.len(var_440_3)
				local var_440_6 = var_440_4 <= 0 and var_440_1 or var_440_1 * (var_440_5 / var_440_4)

				if var_440_6 > 0 and var_440_1 < var_440_6 then
					arg_437_1.talkMaxDuration = var_440_6

					if var_440_6 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_6 + var_440_0
					end
				end

				arg_437_1.text_.text = var_440_3
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_7 = math.max(var_440_1, arg_437_1.talkMaxDuration)

			if var_440_0 <= arg_437_1.time_ and arg_437_1.time_ < var_440_0 + var_440_7 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_0) / var_440_7

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_0 + var_440_7 and arg_437_1.time_ < var_440_0 + var_440_7 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play1104106107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1104106107
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1104106108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0

			if var_444_0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_444_1 = 0
			local var_444_2 = 1.35

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_3 = arg_441_1:FormatText(StoryNameCfg[7].name)

				arg_441_1.leftNameTxt_.text = var_444_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_4 = arg_441_1:GetWordFromCfg(1104106107)
				local var_444_5 = arg_441_1:FormatText(var_444_4.content)

				arg_441_1.text_.text = var_444_5

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_6 = 54
				local var_444_7 = utf8.len(var_444_5)
				local var_444_8 = var_444_6 <= 0 and var_444_2 or var_444_2 * (var_444_7 / var_444_6)

				if var_444_8 > 0 and var_444_2 < var_444_8 then
					arg_441_1.talkMaxDuration = var_444_8

					if var_444_8 + var_444_1 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_8 + var_444_1
					end
				end

				arg_441_1.text_.text = var_444_5
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_9 = math.max(var_444_2, arg_441_1.talkMaxDuration)

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_9 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_1) / var_444_9

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_1 + var_444_9 and arg_441_1.time_ < var_444_1 + var_444_9 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1104106108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1104106108
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1104106109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 0.425

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_2 = arg_445_1:FormatText(StoryNameCfg[7].name)

				arg_445_1.leftNameTxt_.text = var_448_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_3 = arg_445_1:GetWordFromCfg(1104106108)
				local var_448_4 = arg_445_1:FormatText(var_448_3.content)

				arg_445_1.text_.text = var_448_4

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 17
				local var_448_6 = utf8.len(var_448_4)
				local var_448_7 = var_448_5 <= 0 and var_448_1 or var_448_1 * (var_448_6 / var_448_5)

				if var_448_7 > 0 and var_448_1 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_0
					end
				end

				arg_445_1.text_.text = var_448_4
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_8 = math.max(var_448_1, arg_445_1.talkMaxDuration)

			if var_448_0 <= arg_445_1.time_ and arg_445_1.time_ < var_448_0 + var_448_8 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_0) / var_448_8

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_0 + var_448_8 and arg_445_1.time_ < var_448_0 + var_448_8 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1104106109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1104106109
		arg_449_1.duration_ = 2.83

		local var_449_0 = {
			zh = 1.999999999999,
			ja = 2.833
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1104106110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["1041ui_story"].transform
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.var_.moveOldPos1041ui_story = var_452_0.localPosition
			end

			local var_452_2 = 0.001

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2
				local var_452_4 = Vector3.New(0, -1.11, -5.9)

				var_452_0.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1041ui_story, var_452_4, var_452_3)

				local var_452_5 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_5.x, var_452_5.y, var_452_5.z)

				local var_452_6 = var_452_0.localEulerAngles

				var_452_6.z = 0
				var_452_6.x = 0
				var_452_0.localEulerAngles = var_452_6
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 then
				var_452_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_452_7 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_7.x, var_452_7.y, var_452_7.z)

				local var_452_8 = var_452_0.localEulerAngles

				var_452_8.z = 0
				var_452_8.x = 0
				var_452_0.localEulerAngles = var_452_8
			end

			local var_452_9 = arg_449_1.actors_["1041ui_story"]
			local var_452_10 = 0

			if var_452_10 < arg_449_1.time_ and arg_449_1.time_ <= var_452_10 + arg_452_0 and not isNil(var_452_9) and arg_449_1.var_.characterEffect1041ui_story == nil then
				arg_449_1.var_.characterEffect1041ui_story = var_452_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_11 = 0.200000002980232

			if var_452_10 <= arg_449_1.time_ and arg_449_1.time_ < var_452_10 + var_452_11 and not isNil(var_452_9) then
				local var_452_12 = (arg_449_1.time_ - var_452_10) / var_452_11

				if arg_449_1.var_.characterEffect1041ui_story and not isNil(var_452_9) then
					arg_449_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= var_452_10 + var_452_11 and arg_449_1.time_ < var_452_10 + var_452_11 + arg_452_0 and not isNil(var_452_9) and arg_449_1.var_.characterEffect1041ui_story then
				arg_449_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_452_13 = 0

			if var_452_13 < arg_449_1.time_ and arg_449_1.time_ <= var_452_13 + arg_452_0 then
				arg_449_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_452_14 = 0
			local var_452_15 = 0.1

			if var_452_14 < arg_449_1.time_ and arg_449_1.time_ <= var_452_14 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_16 = arg_449_1:FormatText(StoryNameCfg[208].name)

				arg_449_1.leftNameTxt_.text = var_452_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_17 = arg_449_1:GetWordFromCfg(1104106109)
				local var_452_18 = arg_449_1:FormatText(var_452_17.content)

				arg_449_1.text_.text = var_452_18

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_19 = 4
				local var_452_20 = utf8.len(var_452_18)
				local var_452_21 = var_452_19 <= 0 and var_452_15 or var_452_15 * (var_452_20 / var_452_19)

				if var_452_21 > 0 and var_452_15 < var_452_21 then
					arg_449_1.talkMaxDuration = var_452_21

					if var_452_21 + var_452_14 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_21 + var_452_14
					end
				end

				arg_449_1.text_.text = var_452_18
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106109", "story_v_side_new_1104106.awb") ~= 0 then
					local var_452_22 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106109", "story_v_side_new_1104106.awb") / 1000

					if var_452_22 + var_452_14 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_22 + var_452_14
					end

					if var_452_17.prefab_name ~= "" and arg_449_1.actors_[var_452_17.prefab_name] ~= nil then
						local var_452_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_17.prefab_name].transform, "story_v_side_new_1104106", "1104106109", "story_v_side_new_1104106.awb")

						arg_449_1:RecordAudio("1104106109", var_452_23)
						arg_449_1:RecordAudio("1104106109", var_452_23)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106109", "story_v_side_new_1104106.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106109", "story_v_side_new_1104106.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_24 = math.max(var_452_15, arg_449_1.talkMaxDuration)

			if var_452_14 <= arg_449_1.time_ and arg_449_1.time_ < var_452_14 + var_452_24 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_14) / var_452_24

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_14 + var_452_24 and arg_449_1.time_ < var_452_14 + var_452_24 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play1104106110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1104106110
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1104106111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["1041ui_story"]
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 and not isNil(var_456_0) and arg_453_1.var_.characterEffect1041ui_story == nil then
				arg_453_1.var_.characterEffect1041ui_story = var_456_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_2 = 0.200000002980232

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 and not isNil(var_456_0) then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2

				if arg_453_1.var_.characterEffect1041ui_story and not isNil(var_456_0) then
					local var_456_4 = Mathf.Lerp(0, 0.5, var_456_3)

					arg_453_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_453_1.var_.characterEffect1041ui_story.fillRatio = var_456_4
				end
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 and not isNil(var_456_0) and arg_453_1.var_.characterEffect1041ui_story then
				local var_456_5 = 0.5

				arg_453_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_453_1.var_.characterEffect1041ui_story.fillRatio = var_456_5
			end

			local var_456_6 = 0
			local var_456_7 = 0.85

			if var_456_6 < arg_453_1.time_ and arg_453_1.time_ <= var_456_6 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_8 = arg_453_1:FormatText(StoryNameCfg[7].name)

				arg_453_1.leftNameTxt_.text = var_456_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_9 = arg_453_1:GetWordFromCfg(1104106110)
				local var_456_10 = arg_453_1:FormatText(var_456_9.content)

				arg_453_1.text_.text = var_456_10

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_11 = 34
				local var_456_12 = utf8.len(var_456_10)
				local var_456_13 = var_456_11 <= 0 and var_456_7 or var_456_7 * (var_456_12 / var_456_11)

				if var_456_13 > 0 and var_456_7 < var_456_13 then
					arg_453_1.talkMaxDuration = var_456_13

					if var_456_13 + var_456_6 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_13 + var_456_6
					end
				end

				arg_453_1.text_.text = var_456_10
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_14 = math.max(var_456_7, arg_453_1.talkMaxDuration)

			if var_456_6 <= arg_453_1.time_ and arg_453_1.time_ < var_456_6 + var_456_14 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_6) / var_456_14

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_6 + var_456_14 and arg_453_1.time_ < var_456_6 + var_456_14 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1104106111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1104106111
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1104106112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 0.4

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_2 = arg_457_1:FormatText(StoryNameCfg[7].name)

				arg_457_1.leftNameTxt_.text = var_460_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_3 = arg_457_1:GetWordFromCfg(1104106111)
				local var_460_4 = arg_457_1:FormatText(var_460_3.content)

				arg_457_1.text_.text = var_460_4

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 16
				local var_460_6 = utf8.len(var_460_4)
				local var_460_7 = var_460_5 <= 0 and var_460_1 or var_460_1 * (var_460_6 / var_460_5)

				if var_460_7 > 0 and var_460_1 < var_460_7 then
					arg_457_1.talkMaxDuration = var_460_7

					if var_460_7 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_7 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_4
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_8 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_8 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_8

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_8 and arg_457_1.time_ < var_460_0 + var_460_8 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1104106112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1104106112
		arg_461_1.duration_ = 3.83

		local var_461_0 = {
			zh = 3.833,
			ja = 3.666
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1104106113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["1041ui_story"].transform
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.var_.moveOldPos1041ui_story = var_464_0.localPosition
			end

			local var_464_2 = 0.001

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2
				local var_464_4 = Vector3.New(0, -1.11, -5.9)

				var_464_0.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1041ui_story, var_464_4, var_464_3)

				local var_464_5 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_5.x, var_464_5.y, var_464_5.z)

				local var_464_6 = var_464_0.localEulerAngles

				var_464_6.z = 0
				var_464_6.x = 0
				var_464_0.localEulerAngles = var_464_6
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 then
				var_464_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_464_7 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_7.x, var_464_7.y, var_464_7.z)

				local var_464_8 = var_464_0.localEulerAngles

				var_464_8.z = 0
				var_464_8.x = 0
				var_464_0.localEulerAngles = var_464_8
			end

			local var_464_9 = arg_461_1.actors_["1041ui_story"]
			local var_464_10 = 0

			if var_464_10 < arg_461_1.time_ and arg_461_1.time_ <= var_464_10 + arg_464_0 and not isNil(var_464_9) and arg_461_1.var_.characterEffect1041ui_story == nil then
				arg_461_1.var_.characterEffect1041ui_story = var_464_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_11 = 0.200000002980232

			if var_464_10 <= arg_461_1.time_ and arg_461_1.time_ < var_464_10 + var_464_11 and not isNil(var_464_9) then
				local var_464_12 = (arg_461_1.time_ - var_464_10) / var_464_11

				if arg_461_1.var_.characterEffect1041ui_story and not isNil(var_464_9) then
					arg_461_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= var_464_10 + var_464_11 and arg_461_1.time_ < var_464_10 + var_464_11 + arg_464_0 and not isNil(var_464_9) and arg_461_1.var_.characterEffect1041ui_story then
				arg_461_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_464_13 = 0
			local var_464_14 = 0.275

			if var_464_13 < arg_461_1.time_ and arg_461_1.time_ <= var_464_13 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_15 = arg_461_1:FormatText(StoryNameCfg[208].name)

				arg_461_1.leftNameTxt_.text = var_464_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_16 = arg_461_1:GetWordFromCfg(1104106112)
				local var_464_17 = arg_461_1:FormatText(var_464_16.content)

				arg_461_1.text_.text = var_464_17

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_18 = 11
				local var_464_19 = utf8.len(var_464_17)
				local var_464_20 = var_464_18 <= 0 and var_464_14 or var_464_14 * (var_464_19 / var_464_18)

				if var_464_20 > 0 and var_464_14 < var_464_20 then
					arg_461_1.talkMaxDuration = var_464_20

					if var_464_20 + var_464_13 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_20 + var_464_13
					end
				end

				arg_461_1.text_.text = var_464_17
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106112", "story_v_side_new_1104106.awb") ~= 0 then
					local var_464_21 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106112", "story_v_side_new_1104106.awb") / 1000

					if var_464_21 + var_464_13 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_21 + var_464_13
					end

					if var_464_16.prefab_name ~= "" and arg_461_1.actors_[var_464_16.prefab_name] ~= nil then
						local var_464_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_16.prefab_name].transform, "story_v_side_new_1104106", "1104106112", "story_v_side_new_1104106.awb")

						arg_461_1:RecordAudio("1104106112", var_464_22)
						arg_461_1:RecordAudio("1104106112", var_464_22)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106112", "story_v_side_new_1104106.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106112", "story_v_side_new_1104106.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_23 = math.max(var_464_14, arg_461_1.talkMaxDuration)

			if var_464_13 <= arg_461_1.time_ and arg_461_1.time_ < var_464_13 + var_464_23 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_13) / var_464_23

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_13 + var_464_23 and arg_461_1.time_ < var_464_13 + var_464_23 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play1104106113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1104106113
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1104106114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["1041ui_story"]
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.characterEffect1041ui_story == nil then
				arg_465_1.var_.characterEffect1041ui_story = var_468_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.200000002980232

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_2 and not isNil(var_468_0) then
				local var_468_3 = (arg_465_1.time_ - var_468_1) / var_468_2

				if arg_465_1.var_.characterEffect1041ui_story and not isNil(var_468_0) then
					local var_468_4 = Mathf.Lerp(0, 0.5, var_468_3)

					arg_465_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_465_1.var_.characterEffect1041ui_story.fillRatio = var_468_4
				end
			end

			if arg_465_1.time_ >= var_468_1 + var_468_2 and arg_465_1.time_ < var_468_1 + var_468_2 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.characterEffect1041ui_story then
				local var_468_5 = 0.5

				arg_465_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_465_1.var_.characterEffect1041ui_story.fillRatio = var_468_5
			end

			local var_468_6 = 0
			local var_468_7 = 0.325

			if var_468_6 < arg_465_1.time_ and arg_465_1.time_ <= var_468_6 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_8 = arg_465_1:FormatText(StoryNameCfg[7].name)

				arg_465_1.leftNameTxt_.text = var_468_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_9 = arg_465_1:GetWordFromCfg(1104106113)
				local var_468_10 = arg_465_1:FormatText(var_468_9.content)

				arg_465_1.text_.text = var_468_10

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_11 = 13
				local var_468_12 = utf8.len(var_468_10)
				local var_468_13 = var_468_11 <= 0 and var_468_7 or var_468_7 * (var_468_12 / var_468_11)

				if var_468_13 > 0 and var_468_7 < var_468_13 then
					arg_465_1.talkMaxDuration = var_468_13

					if var_468_13 + var_468_6 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_13 + var_468_6
					end
				end

				arg_465_1.text_.text = var_468_10
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_14 = math.max(var_468_7, arg_465_1.talkMaxDuration)

			if var_468_6 <= arg_465_1.time_ and arg_465_1.time_ < var_468_6 + var_468_14 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_6) / var_468_14

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_6 + var_468_14 and arg_465_1.time_ < var_468_6 + var_468_14 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1104106114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1104106114
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1104106115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0
			local var_472_1 = 1.025

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_2 = arg_469_1:FormatText(StoryNameCfg[7].name)

				arg_469_1.leftNameTxt_.text = var_472_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:GetWordFromCfg(1104106114)
				local var_472_4 = arg_469_1:FormatText(var_472_3.content)

				arg_469_1.text_.text = var_472_4

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 41
				local var_472_6 = utf8.len(var_472_4)
				local var_472_7 = var_472_5 <= 0 and var_472_1 or var_472_1 * (var_472_6 / var_472_5)

				if var_472_7 > 0 and var_472_1 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_4
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_8 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_8 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_8

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_8 and arg_469_1.time_ < var_472_0 + var_472_8 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1104106115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1104106115
		arg_473_1.duration_ = 2.9

		local var_473_0 = {
			zh = 1.999999999999,
			ja = 2.9
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1104106116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["1041ui_story"].transform
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.var_.moveOldPos1041ui_story = var_476_0.localPosition
			end

			local var_476_2 = 0.001

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2
				local var_476_4 = Vector3.New(0, -1.11, -5.9)

				var_476_0.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos1041ui_story, var_476_4, var_476_3)

				local var_476_5 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_5.x, var_476_5.y, var_476_5.z)

				local var_476_6 = var_476_0.localEulerAngles

				var_476_6.z = 0
				var_476_6.x = 0
				var_476_0.localEulerAngles = var_476_6
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 then
				var_476_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_476_7 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_7.x, var_476_7.y, var_476_7.z)

				local var_476_8 = var_476_0.localEulerAngles

				var_476_8.z = 0
				var_476_8.x = 0
				var_476_0.localEulerAngles = var_476_8
			end

			local var_476_9 = arg_473_1.actors_["1041ui_story"]
			local var_476_10 = 0

			if var_476_10 < arg_473_1.time_ and arg_473_1.time_ <= var_476_10 + arg_476_0 and not isNil(var_476_9) and arg_473_1.var_.characterEffect1041ui_story == nil then
				arg_473_1.var_.characterEffect1041ui_story = var_476_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_11 = 0.200000002980232

			if var_476_10 <= arg_473_1.time_ and arg_473_1.time_ < var_476_10 + var_476_11 and not isNil(var_476_9) then
				local var_476_12 = (arg_473_1.time_ - var_476_10) / var_476_11

				if arg_473_1.var_.characterEffect1041ui_story and not isNil(var_476_9) then
					arg_473_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= var_476_10 + var_476_11 and arg_473_1.time_ < var_476_10 + var_476_11 + arg_476_0 and not isNil(var_476_9) and arg_473_1.var_.characterEffect1041ui_story then
				arg_473_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_476_13 = 0

			if var_476_13 < arg_473_1.time_ and arg_473_1.time_ <= var_476_13 + arg_476_0 then
				arg_473_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_476_14 = 0

			if var_476_14 < arg_473_1.time_ and arg_473_1.time_ <= var_476_14 + arg_476_0 then
				arg_473_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_476_15 = 0
			local var_476_16 = 0.05

			if var_476_15 < arg_473_1.time_ and arg_473_1.time_ <= var_476_15 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_17 = arg_473_1:FormatText(StoryNameCfg[208].name)

				arg_473_1.leftNameTxt_.text = var_476_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_18 = arg_473_1:GetWordFromCfg(1104106115)
				local var_476_19 = arg_473_1:FormatText(var_476_18.content)

				arg_473_1.text_.text = var_476_19

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_20 = 2
				local var_476_21 = utf8.len(var_476_19)
				local var_476_22 = var_476_20 <= 0 and var_476_16 or var_476_16 * (var_476_21 / var_476_20)

				if var_476_22 > 0 and var_476_16 < var_476_22 then
					arg_473_1.talkMaxDuration = var_476_22

					if var_476_22 + var_476_15 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_22 + var_476_15
					end
				end

				arg_473_1.text_.text = var_476_19
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106115", "story_v_side_new_1104106.awb") ~= 0 then
					local var_476_23 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106115", "story_v_side_new_1104106.awb") / 1000

					if var_476_23 + var_476_15 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_23 + var_476_15
					end

					if var_476_18.prefab_name ~= "" and arg_473_1.actors_[var_476_18.prefab_name] ~= nil then
						local var_476_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_18.prefab_name].transform, "story_v_side_new_1104106", "1104106115", "story_v_side_new_1104106.awb")

						arg_473_1:RecordAudio("1104106115", var_476_24)
						arg_473_1:RecordAudio("1104106115", var_476_24)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106115", "story_v_side_new_1104106.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106115", "story_v_side_new_1104106.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_25 = math.max(var_476_16, arg_473_1.talkMaxDuration)

			if var_476_15 <= arg_473_1.time_ and arg_473_1.time_ < var_476_15 + var_476_25 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_15) / var_476_25

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_15 + var_476_25 and arg_473_1.time_ < var_476_15 + var_476_25 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play1104106116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1104106116
		arg_477_1.duration_ = 4.5

		local var_477_0 = {
			zh = 2.933,
			ja = 4.5
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1104106117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["1041ui_story"].transform
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.var_.moveOldPos1041ui_story = var_480_0.localPosition
			end

			local var_480_2 = 0.001

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2
				local var_480_4 = Vector3.New(0, -1.11, -5.9)

				var_480_0.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1041ui_story, var_480_4, var_480_3)

				local var_480_5 = manager.ui.mainCamera.transform.position - var_480_0.position

				var_480_0.forward = Vector3.New(var_480_5.x, var_480_5.y, var_480_5.z)

				local var_480_6 = var_480_0.localEulerAngles

				var_480_6.z = 0
				var_480_6.x = 0
				var_480_0.localEulerAngles = var_480_6
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 then
				var_480_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_480_7 = manager.ui.mainCamera.transform.position - var_480_0.position

				var_480_0.forward = Vector3.New(var_480_7.x, var_480_7.y, var_480_7.z)

				local var_480_8 = var_480_0.localEulerAngles

				var_480_8.z = 0
				var_480_8.x = 0
				var_480_0.localEulerAngles = var_480_8
			end

			local var_480_9 = arg_477_1.actors_["1041ui_story"]
			local var_480_10 = 0

			if var_480_10 < arg_477_1.time_ and arg_477_1.time_ <= var_480_10 + arg_480_0 and not isNil(var_480_9) and arg_477_1.var_.characterEffect1041ui_story == nil then
				arg_477_1.var_.characterEffect1041ui_story = var_480_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_11 = 0.200000002980232

			if var_480_10 <= arg_477_1.time_ and arg_477_1.time_ < var_480_10 + var_480_11 and not isNil(var_480_9) then
				local var_480_12 = (arg_477_1.time_ - var_480_10) / var_480_11

				if arg_477_1.var_.characterEffect1041ui_story and not isNil(var_480_9) then
					arg_477_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= var_480_10 + var_480_11 and arg_477_1.time_ < var_480_10 + var_480_11 + arg_480_0 and not isNil(var_480_9) and arg_477_1.var_.characterEffect1041ui_story then
				arg_477_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_480_13 = 0

			if var_480_13 < arg_477_1.time_ and arg_477_1.time_ <= var_480_13 + arg_480_0 then
				arg_477_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_480_14 = 0
			local var_480_15 = 0.525

			if var_480_14 < arg_477_1.time_ and arg_477_1.time_ <= var_480_14 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_16 = arg_477_1:FormatText(StoryNameCfg[208].name)

				arg_477_1.leftNameTxt_.text = var_480_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_17 = arg_477_1:GetWordFromCfg(1104106116)
				local var_480_18 = arg_477_1:FormatText(var_480_17.content)

				arg_477_1.text_.text = var_480_18

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_19 = 21
				local var_480_20 = utf8.len(var_480_18)
				local var_480_21 = var_480_19 <= 0 and var_480_15 or var_480_15 * (var_480_20 / var_480_19)

				if var_480_21 > 0 and var_480_15 < var_480_21 then
					arg_477_1.talkMaxDuration = var_480_21

					if var_480_21 + var_480_14 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_21 + var_480_14
					end
				end

				arg_477_1.text_.text = var_480_18
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106116", "story_v_side_new_1104106.awb") ~= 0 then
					local var_480_22 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106116", "story_v_side_new_1104106.awb") / 1000

					if var_480_22 + var_480_14 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_22 + var_480_14
					end

					if var_480_17.prefab_name ~= "" and arg_477_1.actors_[var_480_17.prefab_name] ~= nil then
						local var_480_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_17.prefab_name].transform, "story_v_side_new_1104106", "1104106116", "story_v_side_new_1104106.awb")

						arg_477_1:RecordAudio("1104106116", var_480_23)
						arg_477_1:RecordAudio("1104106116", var_480_23)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106116", "story_v_side_new_1104106.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106116", "story_v_side_new_1104106.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_24 = math.max(var_480_15, arg_477_1.talkMaxDuration)

			if var_480_14 <= arg_477_1.time_ and arg_477_1.time_ < var_480_14 + var_480_24 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_14) / var_480_24

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_14 + var_480_24 and arg_477_1.time_ < var_480_14 + var_480_24 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play1104106117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1104106117
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1104106118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = arg_481_1.actors_["1041ui_story"]
			local var_484_1 = 0

			if var_484_1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.characterEffect1041ui_story == nil then
				arg_481_1.var_.characterEffect1041ui_story = var_484_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.200000002980232

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_2 and not isNil(var_484_0) then
				local var_484_3 = (arg_481_1.time_ - var_484_1) / var_484_2

				if arg_481_1.var_.characterEffect1041ui_story and not isNil(var_484_0) then
					local var_484_4 = Mathf.Lerp(0, 0.5, var_484_3)

					arg_481_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_481_1.var_.characterEffect1041ui_story.fillRatio = var_484_4
				end
			end

			if arg_481_1.time_ >= var_484_1 + var_484_2 and arg_481_1.time_ < var_484_1 + var_484_2 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.characterEffect1041ui_story then
				local var_484_5 = 0.5

				arg_481_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_481_1.var_.characterEffect1041ui_story.fillRatio = var_484_5
			end

			local var_484_6 = 0
			local var_484_7 = 0.625

			if var_484_6 < arg_481_1.time_ and arg_481_1.time_ <= var_484_6 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_8 = arg_481_1:FormatText(StoryNameCfg[7].name)

				arg_481_1.leftNameTxt_.text = var_484_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_9 = arg_481_1:GetWordFromCfg(1104106117)
				local var_484_10 = arg_481_1:FormatText(var_484_9.content)

				arg_481_1.text_.text = var_484_10

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_11 = 25
				local var_484_12 = utf8.len(var_484_10)
				local var_484_13 = var_484_11 <= 0 and var_484_7 or var_484_7 * (var_484_12 / var_484_11)

				if var_484_13 > 0 and var_484_7 < var_484_13 then
					arg_481_1.talkMaxDuration = var_484_13

					if var_484_13 + var_484_6 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_13 + var_484_6
					end
				end

				arg_481_1.text_.text = var_484_10
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_14 = math.max(var_484_7, arg_481_1.talkMaxDuration)

			if var_484_6 <= arg_481_1.time_ and arg_481_1.time_ < var_484_6 + var_484_14 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_6) / var_484_14

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_6 + var_484_14 and arg_481_1.time_ < var_484_6 + var_484_14 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1104106118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1104106118
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1104106119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0
			local var_488_1 = 0.525

			if var_488_0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_2 = arg_485_1:FormatText(StoryNameCfg[7].name)

				arg_485_1.leftNameTxt_.text = var_488_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_3 = arg_485_1:GetWordFromCfg(1104106118)
				local var_488_4 = arg_485_1:FormatText(var_488_3.content)

				arg_485_1.text_.text = var_488_4

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_5 = 21
				local var_488_6 = utf8.len(var_488_4)
				local var_488_7 = var_488_5 <= 0 and var_488_1 or var_488_1 * (var_488_6 / var_488_5)

				if var_488_7 > 0 and var_488_1 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_0
					end
				end

				arg_485_1.text_.text = var_488_4
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_8 = math.max(var_488_1, arg_485_1.talkMaxDuration)

			if var_488_0 <= arg_485_1.time_ and arg_485_1.time_ < var_488_0 + var_488_8 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_0) / var_488_8

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_0 + var_488_8 and arg_485_1.time_ < var_488_0 + var_488_8 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1104106119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1104106119
		arg_489_1.duration_ = 7.83

		local var_489_0 = {
			zh = 4.1,
			ja = 7.833
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1104106120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = arg_489_1.actors_["1041ui_story"].transform
			local var_492_1 = 0

			if var_492_1 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 then
				arg_489_1.var_.moveOldPos1041ui_story = var_492_0.localPosition
			end

			local var_492_2 = 0.001

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_2 then
				local var_492_3 = (arg_489_1.time_ - var_492_1) / var_492_2
				local var_492_4 = Vector3.New(0, -1.11, -5.9)

				var_492_0.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1041ui_story, var_492_4, var_492_3)

				local var_492_5 = manager.ui.mainCamera.transform.position - var_492_0.position

				var_492_0.forward = Vector3.New(var_492_5.x, var_492_5.y, var_492_5.z)

				local var_492_6 = var_492_0.localEulerAngles

				var_492_6.z = 0
				var_492_6.x = 0
				var_492_0.localEulerAngles = var_492_6
			end

			if arg_489_1.time_ >= var_492_1 + var_492_2 and arg_489_1.time_ < var_492_1 + var_492_2 + arg_492_0 then
				var_492_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_492_7 = manager.ui.mainCamera.transform.position - var_492_0.position

				var_492_0.forward = Vector3.New(var_492_7.x, var_492_7.y, var_492_7.z)

				local var_492_8 = var_492_0.localEulerAngles

				var_492_8.z = 0
				var_492_8.x = 0
				var_492_0.localEulerAngles = var_492_8
			end

			local var_492_9 = arg_489_1.actors_["1041ui_story"]
			local var_492_10 = 0

			if var_492_10 < arg_489_1.time_ and arg_489_1.time_ <= var_492_10 + arg_492_0 and not isNil(var_492_9) and arg_489_1.var_.characterEffect1041ui_story == nil then
				arg_489_1.var_.characterEffect1041ui_story = var_492_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_11 = 0.200000002980232

			if var_492_10 <= arg_489_1.time_ and arg_489_1.time_ < var_492_10 + var_492_11 and not isNil(var_492_9) then
				local var_492_12 = (arg_489_1.time_ - var_492_10) / var_492_11

				if arg_489_1.var_.characterEffect1041ui_story and not isNil(var_492_9) then
					arg_489_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_489_1.time_ >= var_492_10 + var_492_11 and arg_489_1.time_ < var_492_10 + var_492_11 + arg_492_0 and not isNil(var_492_9) and arg_489_1.var_.characterEffect1041ui_story then
				arg_489_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_492_13 = 0

			if var_492_13 < arg_489_1.time_ and arg_489_1.time_ <= var_492_13 + arg_492_0 then
				arg_489_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_492_14 = 0
			local var_492_15 = 0.475

			if var_492_14 < arg_489_1.time_ and arg_489_1.time_ <= var_492_14 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_16 = arg_489_1:FormatText(StoryNameCfg[208].name)

				arg_489_1.leftNameTxt_.text = var_492_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_17 = arg_489_1:GetWordFromCfg(1104106119)
				local var_492_18 = arg_489_1:FormatText(var_492_17.content)

				arg_489_1.text_.text = var_492_18

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_19 = 19
				local var_492_20 = utf8.len(var_492_18)
				local var_492_21 = var_492_19 <= 0 and var_492_15 or var_492_15 * (var_492_20 / var_492_19)

				if var_492_21 > 0 and var_492_15 < var_492_21 then
					arg_489_1.talkMaxDuration = var_492_21

					if var_492_21 + var_492_14 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_21 + var_492_14
					end
				end

				arg_489_1.text_.text = var_492_18
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106119", "story_v_side_new_1104106.awb") ~= 0 then
					local var_492_22 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106119", "story_v_side_new_1104106.awb") / 1000

					if var_492_22 + var_492_14 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_22 + var_492_14
					end

					if var_492_17.prefab_name ~= "" and arg_489_1.actors_[var_492_17.prefab_name] ~= nil then
						local var_492_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_17.prefab_name].transform, "story_v_side_new_1104106", "1104106119", "story_v_side_new_1104106.awb")

						arg_489_1:RecordAudio("1104106119", var_492_23)
						arg_489_1:RecordAudio("1104106119", var_492_23)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106119", "story_v_side_new_1104106.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106119", "story_v_side_new_1104106.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_24 = math.max(var_492_15, arg_489_1.talkMaxDuration)

			if var_492_14 <= arg_489_1.time_ and arg_489_1.time_ < var_492_14 + var_492_24 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_14) / var_492_24

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_14 + var_492_24 and arg_489_1.time_ < var_492_14 + var_492_24 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play1104106120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1104106120
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1104106121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["1041ui_story"]
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.characterEffect1041ui_story == nil then
				arg_493_1.var_.characterEffect1041ui_story = var_496_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.200000002980232

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_2 and not isNil(var_496_0) then
				local var_496_3 = (arg_493_1.time_ - var_496_1) / var_496_2

				if arg_493_1.var_.characterEffect1041ui_story and not isNil(var_496_0) then
					local var_496_4 = Mathf.Lerp(0, 0.5, var_496_3)

					arg_493_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_493_1.var_.characterEffect1041ui_story.fillRatio = var_496_4
				end
			end

			if arg_493_1.time_ >= var_496_1 + var_496_2 and arg_493_1.time_ < var_496_1 + var_496_2 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.characterEffect1041ui_story then
				local var_496_5 = 0.5

				arg_493_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_493_1.var_.characterEffect1041ui_story.fillRatio = var_496_5
			end

			local var_496_6 = 0
			local var_496_7 = 0.65

			if var_496_6 < arg_493_1.time_ and arg_493_1.time_ <= var_496_6 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_8 = arg_493_1:FormatText(StoryNameCfg[7].name)

				arg_493_1.leftNameTxt_.text = var_496_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_9 = arg_493_1:GetWordFromCfg(1104106120)
				local var_496_10 = arg_493_1:FormatText(var_496_9.content)

				arg_493_1.text_.text = var_496_10

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_11 = 26
				local var_496_12 = utf8.len(var_496_10)
				local var_496_13 = var_496_11 <= 0 and var_496_7 or var_496_7 * (var_496_12 / var_496_11)

				if var_496_13 > 0 and var_496_7 < var_496_13 then
					arg_493_1.talkMaxDuration = var_496_13

					if var_496_13 + var_496_6 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_13 + var_496_6
					end
				end

				arg_493_1.text_.text = var_496_10
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_14 = math.max(var_496_7, arg_493_1.talkMaxDuration)

			if var_496_6 <= arg_493_1.time_ and arg_493_1.time_ < var_496_6 + var_496_14 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_6) / var_496_14

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_6 + var_496_14 and arg_493_1.time_ < var_496_6 + var_496_14 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play1104106121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1104106121
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1104106122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0
			local var_500_1 = 0.625

			if var_500_0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_2 = arg_497_1:FormatText(StoryNameCfg[7].name)

				arg_497_1.leftNameTxt_.text = var_500_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_3 = arg_497_1:GetWordFromCfg(1104106121)
				local var_500_4 = arg_497_1:FormatText(var_500_3.content)

				arg_497_1.text_.text = var_500_4

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_5 = 25
				local var_500_6 = utf8.len(var_500_4)
				local var_500_7 = var_500_5 <= 0 and var_500_1 or var_500_1 * (var_500_6 / var_500_5)

				if var_500_7 > 0 and var_500_1 < var_500_7 then
					arg_497_1.talkMaxDuration = var_500_7

					if var_500_7 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_7 + var_500_0
					end
				end

				arg_497_1.text_.text = var_500_4
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_8 = math.max(var_500_1, arg_497_1.talkMaxDuration)

			if var_500_0 <= arg_497_1.time_ and arg_497_1.time_ < var_500_0 + var_500_8 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_0) / var_500_8

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_0 + var_500_8 and arg_497_1.time_ < var_500_0 + var_500_8 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1104106122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1104106122
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1104106123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0
			local var_504_1 = 0.375

			if var_504_0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_2 = arg_501_1:FormatText(StoryNameCfg[7].name)

				arg_501_1.leftNameTxt_.text = var_504_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_3 = arg_501_1:GetWordFromCfg(1104106122)
				local var_504_4 = arg_501_1:FormatText(var_504_3.content)

				arg_501_1.text_.text = var_504_4

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_5 = 15
				local var_504_6 = utf8.len(var_504_4)
				local var_504_7 = var_504_5 <= 0 and var_504_1 or var_504_1 * (var_504_6 / var_504_5)

				if var_504_7 > 0 and var_504_1 < var_504_7 then
					arg_501_1.talkMaxDuration = var_504_7

					if var_504_7 + var_504_0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_7 + var_504_0
					end
				end

				arg_501_1.text_.text = var_504_4
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_8 = math.max(var_504_1, arg_501_1.talkMaxDuration)

			if var_504_0 <= arg_501_1.time_ and arg_501_1.time_ < var_504_0 + var_504_8 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_0) / var_504_8

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_0 + var_504_8 and arg_501_1.time_ < var_504_0 + var_504_8 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1104106123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1104106123
		arg_505_1.duration_ = 2

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1104106124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = arg_505_1.actors_["1041ui_story"].transform
			local var_508_1 = 0

			if var_508_1 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 then
				arg_505_1.var_.moveOldPos1041ui_story = var_508_0.localPosition
			end

			local var_508_2 = 0.001

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_2 then
				local var_508_3 = (arg_505_1.time_ - var_508_1) / var_508_2
				local var_508_4 = Vector3.New(0, -1.11, -5.9)

				var_508_0.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos1041ui_story, var_508_4, var_508_3)

				local var_508_5 = manager.ui.mainCamera.transform.position - var_508_0.position

				var_508_0.forward = Vector3.New(var_508_5.x, var_508_5.y, var_508_5.z)

				local var_508_6 = var_508_0.localEulerAngles

				var_508_6.z = 0
				var_508_6.x = 0
				var_508_0.localEulerAngles = var_508_6
			end

			if arg_505_1.time_ >= var_508_1 + var_508_2 and arg_505_1.time_ < var_508_1 + var_508_2 + arg_508_0 then
				var_508_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_508_7 = manager.ui.mainCamera.transform.position - var_508_0.position

				var_508_0.forward = Vector3.New(var_508_7.x, var_508_7.y, var_508_7.z)

				local var_508_8 = var_508_0.localEulerAngles

				var_508_8.z = 0
				var_508_8.x = 0
				var_508_0.localEulerAngles = var_508_8
			end

			local var_508_9 = arg_505_1.actors_["1041ui_story"]
			local var_508_10 = 0

			if var_508_10 < arg_505_1.time_ and arg_505_1.time_ <= var_508_10 + arg_508_0 and not isNil(var_508_9) and arg_505_1.var_.characterEffect1041ui_story == nil then
				arg_505_1.var_.characterEffect1041ui_story = var_508_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_11 = 0.200000002980232

			if var_508_10 <= arg_505_1.time_ and arg_505_1.time_ < var_508_10 + var_508_11 and not isNil(var_508_9) then
				local var_508_12 = (arg_505_1.time_ - var_508_10) / var_508_11

				if arg_505_1.var_.characterEffect1041ui_story and not isNil(var_508_9) then
					arg_505_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= var_508_10 + var_508_11 and arg_505_1.time_ < var_508_10 + var_508_11 + arg_508_0 and not isNil(var_508_9) and arg_505_1.var_.characterEffect1041ui_story then
				arg_505_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_508_13 = 0

			if var_508_13 < arg_505_1.time_ and arg_505_1.time_ <= var_508_13 + arg_508_0 then
				arg_505_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_508_14 = 0
			local var_508_15 = 0.05

			if var_508_14 < arg_505_1.time_ and arg_505_1.time_ <= var_508_14 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_16 = arg_505_1:FormatText(StoryNameCfg[208].name)

				arg_505_1.leftNameTxt_.text = var_508_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_17 = arg_505_1:GetWordFromCfg(1104106123)
				local var_508_18 = arg_505_1:FormatText(var_508_17.content)

				arg_505_1.text_.text = var_508_18

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_19 = 2
				local var_508_20 = utf8.len(var_508_18)
				local var_508_21 = var_508_19 <= 0 and var_508_15 or var_508_15 * (var_508_20 / var_508_19)

				if var_508_21 > 0 and var_508_15 < var_508_21 then
					arg_505_1.talkMaxDuration = var_508_21

					if var_508_21 + var_508_14 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_21 + var_508_14
					end
				end

				arg_505_1.text_.text = var_508_18
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106123", "story_v_side_new_1104106.awb") ~= 0 then
					local var_508_22 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106123", "story_v_side_new_1104106.awb") / 1000

					if var_508_22 + var_508_14 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_22 + var_508_14
					end

					if var_508_17.prefab_name ~= "" and arg_505_1.actors_[var_508_17.prefab_name] ~= nil then
						local var_508_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_17.prefab_name].transform, "story_v_side_new_1104106", "1104106123", "story_v_side_new_1104106.awb")

						arg_505_1:RecordAudio("1104106123", var_508_23)
						arg_505_1:RecordAudio("1104106123", var_508_23)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106123", "story_v_side_new_1104106.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106123", "story_v_side_new_1104106.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_24 = math.max(var_508_15, arg_505_1.talkMaxDuration)

			if var_508_14 <= arg_505_1.time_ and arg_505_1.time_ < var_508_14 + var_508_24 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_14) / var_508_24

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_14 + var_508_24 and arg_505_1.time_ < var_508_14 + var_508_24 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_505_1:InitPlayNodeList()
	end,
	Play1104106124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1104106124
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1104106125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = arg_509_1.actors_["1041ui_story"]
			local var_512_1 = 0

			if var_512_1 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.characterEffect1041ui_story == nil then
				arg_509_1.var_.characterEffect1041ui_story = var_512_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_2 = 0.200000002980232

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_2 and not isNil(var_512_0) then
				local var_512_3 = (arg_509_1.time_ - var_512_1) / var_512_2

				if arg_509_1.var_.characterEffect1041ui_story and not isNil(var_512_0) then
					local var_512_4 = Mathf.Lerp(0, 0.5, var_512_3)

					arg_509_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_509_1.var_.characterEffect1041ui_story.fillRatio = var_512_4
				end
			end

			if arg_509_1.time_ >= var_512_1 + var_512_2 and arg_509_1.time_ < var_512_1 + var_512_2 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.characterEffect1041ui_story then
				local var_512_5 = 0.5

				arg_509_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_509_1.var_.characterEffect1041ui_story.fillRatio = var_512_5
			end

			local var_512_6 = 0
			local var_512_7 = 0.575

			if var_512_6 < arg_509_1.time_ and arg_509_1.time_ <= var_512_6 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, false)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_8 = arg_509_1:GetWordFromCfg(1104106124)
				local var_512_9 = arg_509_1:FormatText(var_512_8.content)

				arg_509_1.text_.text = var_512_9

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_10 = 23
				local var_512_11 = utf8.len(var_512_9)
				local var_512_12 = var_512_10 <= 0 and var_512_7 or var_512_7 * (var_512_11 / var_512_10)

				if var_512_12 > 0 and var_512_7 < var_512_12 then
					arg_509_1.talkMaxDuration = var_512_12

					if var_512_12 + var_512_6 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_12 + var_512_6
					end
				end

				arg_509_1.text_.text = var_512_9
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_13 = math.max(var_512_7, arg_509_1.talkMaxDuration)

			if var_512_6 <= arg_509_1.time_ and arg_509_1.time_ < var_512_6 + var_512_13 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_6) / var_512_13

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_6 + var_512_13 and arg_509_1.time_ < var_512_6 + var_512_13 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1104106125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1104106125
		arg_513_1.duration_ = 2.4

		local var_513_0 = {
			zh = 2.4,
			ja = 1.999999999999
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1104106126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = arg_513_1.actors_["1041ui_story"].transform
			local var_516_1 = 0

			if var_516_1 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 then
				arg_513_1.var_.moveOldPos1041ui_story = var_516_0.localPosition
			end

			local var_516_2 = 0.001

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_2 then
				local var_516_3 = (arg_513_1.time_ - var_516_1) / var_516_2
				local var_516_4 = Vector3.New(0, -1.11, -5.9)

				var_516_0.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPos1041ui_story, var_516_4, var_516_3)

				local var_516_5 = manager.ui.mainCamera.transform.position - var_516_0.position

				var_516_0.forward = Vector3.New(var_516_5.x, var_516_5.y, var_516_5.z)

				local var_516_6 = var_516_0.localEulerAngles

				var_516_6.z = 0
				var_516_6.x = 0
				var_516_0.localEulerAngles = var_516_6
			end

			if arg_513_1.time_ >= var_516_1 + var_516_2 and arg_513_1.time_ < var_516_1 + var_516_2 + arg_516_0 then
				var_516_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_516_7 = manager.ui.mainCamera.transform.position - var_516_0.position

				var_516_0.forward = Vector3.New(var_516_7.x, var_516_7.y, var_516_7.z)

				local var_516_8 = var_516_0.localEulerAngles

				var_516_8.z = 0
				var_516_8.x = 0
				var_516_0.localEulerAngles = var_516_8
			end

			local var_516_9 = arg_513_1.actors_["1041ui_story"]
			local var_516_10 = 0

			if var_516_10 < arg_513_1.time_ and arg_513_1.time_ <= var_516_10 + arg_516_0 and not isNil(var_516_9) and arg_513_1.var_.characterEffect1041ui_story == nil then
				arg_513_1.var_.characterEffect1041ui_story = var_516_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_11 = 0.200000002980232

			if var_516_10 <= arg_513_1.time_ and arg_513_1.time_ < var_516_10 + var_516_11 and not isNil(var_516_9) then
				local var_516_12 = (arg_513_1.time_ - var_516_10) / var_516_11

				if arg_513_1.var_.characterEffect1041ui_story and not isNil(var_516_9) then
					arg_513_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_513_1.time_ >= var_516_10 + var_516_11 and arg_513_1.time_ < var_516_10 + var_516_11 + arg_516_0 and not isNil(var_516_9) and arg_513_1.var_.characterEffect1041ui_story then
				arg_513_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_516_13 = 0

			if var_516_13 < arg_513_1.time_ and arg_513_1.time_ <= var_516_13 + arg_516_0 then
				arg_513_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_516_14 = 0
			local var_516_15 = 0.5

			if var_516_14 < arg_513_1.time_ and arg_513_1.time_ <= var_516_14 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_16 = arg_513_1:FormatText(StoryNameCfg[208].name)

				arg_513_1.leftNameTxt_.text = var_516_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_17 = arg_513_1:GetWordFromCfg(1104106125)
				local var_516_18 = arg_513_1:FormatText(var_516_17.content)

				arg_513_1.text_.text = var_516_18

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_19 = 20
				local var_516_20 = utf8.len(var_516_18)
				local var_516_21 = var_516_19 <= 0 and var_516_15 or var_516_15 * (var_516_20 / var_516_19)

				if var_516_21 > 0 and var_516_15 < var_516_21 then
					arg_513_1.talkMaxDuration = var_516_21

					if var_516_21 + var_516_14 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_21 + var_516_14
					end
				end

				arg_513_1.text_.text = var_516_18
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106125", "story_v_side_new_1104106.awb") ~= 0 then
					local var_516_22 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106125", "story_v_side_new_1104106.awb") / 1000

					if var_516_22 + var_516_14 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_22 + var_516_14
					end

					if var_516_17.prefab_name ~= "" and arg_513_1.actors_[var_516_17.prefab_name] ~= nil then
						local var_516_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_17.prefab_name].transform, "story_v_side_new_1104106", "1104106125", "story_v_side_new_1104106.awb")

						arg_513_1:RecordAudio("1104106125", var_516_23)
						arg_513_1:RecordAudio("1104106125", var_516_23)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106125", "story_v_side_new_1104106.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106125", "story_v_side_new_1104106.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_24 = math.max(var_516_15, arg_513_1.talkMaxDuration)

			if var_516_14 <= arg_513_1.time_ and arg_513_1.time_ < var_516_14 + var_516_24 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_14) / var_516_24

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_14 + var_516_24 and arg_513_1.time_ < var_516_14 + var_516_24 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_513_1:InitPlayNodeList()
	end,
	Play1104106126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1104106126
		arg_517_1.duration_ = 7.37

		local var_517_0 = {
			zh = 4.7,
			ja = 7.366
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1104106127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0

			if var_520_0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_0 + arg_520_0 then
				arg_517_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_520_1 = 0
			local var_520_2 = 0.525

			if var_520_1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_3 = arg_517_1:FormatText(StoryNameCfg[208].name)

				arg_517_1.leftNameTxt_.text = var_520_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_4 = arg_517_1:GetWordFromCfg(1104106126)
				local var_520_5 = arg_517_1:FormatText(var_520_4.content)

				arg_517_1.text_.text = var_520_5

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_6 = 21
				local var_520_7 = utf8.len(var_520_5)
				local var_520_8 = var_520_6 <= 0 and var_520_2 or var_520_2 * (var_520_7 / var_520_6)

				if var_520_8 > 0 and var_520_2 < var_520_8 then
					arg_517_1.talkMaxDuration = var_520_8

					if var_520_8 + var_520_1 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_8 + var_520_1
					end
				end

				arg_517_1.text_.text = var_520_5
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106126", "story_v_side_new_1104106.awb") ~= 0 then
					local var_520_9 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106126", "story_v_side_new_1104106.awb") / 1000

					if var_520_9 + var_520_1 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_9 + var_520_1
					end

					if var_520_4.prefab_name ~= "" and arg_517_1.actors_[var_520_4.prefab_name] ~= nil then
						local var_520_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_4.prefab_name].transform, "story_v_side_new_1104106", "1104106126", "story_v_side_new_1104106.awb")

						arg_517_1:RecordAudio("1104106126", var_520_10)
						arg_517_1:RecordAudio("1104106126", var_520_10)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106126", "story_v_side_new_1104106.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106126", "story_v_side_new_1104106.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_11 = math.max(var_520_2, arg_517_1.talkMaxDuration)

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_11 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_1) / var_520_11

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_1 + var_520_11 and arg_517_1.time_ < var_520_1 + var_520_11 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1104106127 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1104106127
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1104106128(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = arg_521_1.actors_["1041ui_story"]
			local var_524_1 = 0

			if var_524_1 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.characterEffect1041ui_story == nil then
				arg_521_1.var_.characterEffect1041ui_story = var_524_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_2 = 0.200000002980232

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_2 and not isNil(var_524_0) then
				local var_524_3 = (arg_521_1.time_ - var_524_1) / var_524_2

				if arg_521_1.var_.characterEffect1041ui_story and not isNil(var_524_0) then
					local var_524_4 = Mathf.Lerp(0, 0.5, var_524_3)

					arg_521_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_521_1.var_.characterEffect1041ui_story.fillRatio = var_524_4
				end
			end

			if arg_521_1.time_ >= var_524_1 + var_524_2 and arg_521_1.time_ < var_524_1 + var_524_2 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.characterEffect1041ui_story then
				local var_524_5 = 0.5

				arg_521_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_521_1.var_.characterEffect1041ui_story.fillRatio = var_524_5
			end

			local var_524_6 = 0
			local var_524_7 = 0.6

			if var_524_6 < arg_521_1.time_ and arg_521_1.time_ <= var_524_6 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_8 = arg_521_1:GetWordFromCfg(1104106127)
				local var_524_9 = arg_521_1:FormatText(var_524_8.content)

				arg_521_1.text_.text = var_524_9

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_10 = 24
				local var_524_11 = utf8.len(var_524_9)
				local var_524_12 = var_524_10 <= 0 and var_524_7 or var_524_7 * (var_524_11 / var_524_10)

				if var_524_12 > 0 and var_524_7 < var_524_12 then
					arg_521_1.talkMaxDuration = var_524_12

					if var_524_12 + var_524_6 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_12 + var_524_6
					end
				end

				arg_521_1.text_.text = var_524_9
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_13 = math.max(var_524_7, arg_521_1.talkMaxDuration)

			if var_524_6 <= arg_521_1.time_ and arg_521_1.time_ < var_524_6 + var_524_13 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_6) / var_524_13

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_6 + var_524_13 and arg_521_1.time_ < var_524_6 + var_524_13 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play1104106128 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1104106128
		arg_525_1.duration_ = 3.5

		local var_525_0 = {
			zh = 3.5,
			ja = 2.5
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1104106129(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = arg_525_1.actors_["1041ui_story"].transform
			local var_528_1 = 0

			if var_528_1 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 then
				arg_525_1.var_.moveOldPos1041ui_story = var_528_0.localPosition
			end

			local var_528_2 = 0.001

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_2 then
				local var_528_3 = (arg_525_1.time_ - var_528_1) / var_528_2
				local var_528_4 = Vector3.New(0, -1.11, -5.9)

				var_528_0.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos1041ui_story, var_528_4, var_528_3)

				local var_528_5 = manager.ui.mainCamera.transform.position - var_528_0.position

				var_528_0.forward = Vector3.New(var_528_5.x, var_528_5.y, var_528_5.z)

				local var_528_6 = var_528_0.localEulerAngles

				var_528_6.z = 0
				var_528_6.x = 0
				var_528_0.localEulerAngles = var_528_6
			end

			if arg_525_1.time_ >= var_528_1 + var_528_2 and arg_525_1.time_ < var_528_1 + var_528_2 + arg_528_0 then
				var_528_0.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_528_7 = manager.ui.mainCamera.transform.position - var_528_0.position

				var_528_0.forward = Vector3.New(var_528_7.x, var_528_7.y, var_528_7.z)

				local var_528_8 = var_528_0.localEulerAngles

				var_528_8.z = 0
				var_528_8.x = 0
				var_528_0.localEulerAngles = var_528_8
			end

			local var_528_9 = arg_525_1.actors_["1041ui_story"]
			local var_528_10 = 0

			if var_528_10 < arg_525_1.time_ and arg_525_1.time_ <= var_528_10 + arg_528_0 and not isNil(var_528_9) and arg_525_1.var_.characterEffect1041ui_story == nil then
				arg_525_1.var_.characterEffect1041ui_story = var_528_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_11 = 0.200000002980232

			if var_528_10 <= arg_525_1.time_ and arg_525_1.time_ < var_528_10 + var_528_11 and not isNil(var_528_9) then
				local var_528_12 = (arg_525_1.time_ - var_528_10) / var_528_11

				if arg_525_1.var_.characterEffect1041ui_story and not isNil(var_528_9) then
					arg_525_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= var_528_10 + var_528_11 and arg_525_1.time_ < var_528_10 + var_528_11 + arg_528_0 and not isNil(var_528_9) and arg_525_1.var_.characterEffect1041ui_story then
				arg_525_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_528_13 = 0

			if var_528_13 < arg_525_1.time_ and arg_525_1.time_ <= var_528_13 + arg_528_0 then
				arg_525_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_1")
			end

			local var_528_14 = 0

			if var_528_14 < arg_525_1.time_ and arg_525_1.time_ <= var_528_14 + arg_528_0 then
				arg_525_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_528_15 = 0
			local var_528_16 = 0.45

			if var_528_15 < arg_525_1.time_ and arg_525_1.time_ <= var_528_15 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_17 = arg_525_1:FormatText(StoryNameCfg[208].name)

				arg_525_1.leftNameTxt_.text = var_528_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_18 = arg_525_1:GetWordFromCfg(1104106128)
				local var_528_19 = arg_525_1:FormatText(var_528_18.content)

				arg_525_1.text_.text = var_528_19

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_20 = 18
				local var_528_21 = utf8.len(var_528_19)
				local var_528_22 = var_528_20 <= 0 and var_528_16 or var_528_16 * (var_528_21 / var_528_20)

				if var_528_22 > 0 and var_528_16 < var_528_22 then
					arg_525_1.talkMaxDuration = var_528_22

					if var_528_22 + var_528_15 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_22 + var_528_15
					end
				end

				arg_525_1.text_.text = var_528_19
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106128", "story_v_side_new_1104106.awb") ~= 0 then
					local var_528_23 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106128", "story_v_side_new_1104106.awb") / 1000

					if var_528_23 + var_528_15 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_23 + var_528_15
					end

					if var_528_18.prefab_name ~= "" and arg_525_1.actors_[var_528_18.prefab_name] ~= nil then
						local var_528_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_18.prefab_name].transform, "story_v_side_new_1104106", "1104106128", "story_v_side_new_1104106.awb")

						arg_525_1:RecordAudio("1104106128", var_528_24)
						arg_525_1:RecordAudio("1104106128", var_528_24)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106128", "story_v_side_new_1104106.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106128", "story_v_side_new_1104106.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_25 = math.max(var_528_16, arg_525_1.talkMaxDuration)

			if var_528_15 <= arg_525_1.time_ and arg_525_1.time_ < var_528_15 + var_528_25 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_15) / var_528_25

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_15 + var_528_25 and arg_525_1.time_ < var_528_15 + var_528_25 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_525_1:InitPlayNodeList()
	end,
	Play1104106129 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1104106129
		arg_529_1.duration_ = 7.4

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1104106130(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 2

			if var_532_0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_0 + arg_532_0 then
				local var_532_1 = manager.ui.mainCamera.transform.localPosition
				local var_532_2 = Vector3.New(0, 0, 10) + Vector3.New(var_532_1.x, var_532_1.y, 0)
				local var_532_3 = arg_529_1.bgs_.STblack

				var_532_3.transform.localPosition = var_532_2
				var_532_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_532_4 = var_532_3:GetComponent("SpriteRenderer")

				if var_532_4 and var_532_4.sprite then
					local var_532_5 = (var_532_3.transform.localPosition - var_532_1).z
					local var_532_6 = manager.ui.mainCameraCom_
					local var_532_7 = 2 * var_532_5 * Mathf.Tan(var_532_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_532_8 = var_532_7 * var_532_6.aspect
					local var_532_9 = var_532_4.sprite.bounds.size.x
					local var_532_10 = var_532_4.sprite.bounds.size.y
					local var_532_11 = var_532_8 / var_532_9
					local var_532_12 = var_532_7 / var_532_10
					local var_532_13 = var_532_12 < var_532_11 and var_532_11 or var_532_12

					var_532_3.transform.localScale = Vector3.New(var_532_13, var_532_13, 0)
				end

				for iter_532_0, iter_532_1 in pairs(arg_529_1.bgs_) do
					if iter_532_0 ~= "STblack" then
						iter_532_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_532_14 = arg_529_1.actors_["1041ui_story"].transform
			local var_532_15 = 2

			if var_532_15 < arg_529_1.time_ and arg_529_1.time_ <= var_532_15 + arg_532_0 then
				arg_529_1.var_.moveOldPos1041ui_story = var_532_14.localPosition
			end

			local var_532_16 = 0.001

			if var_532_15 <= arg_529_1.time_ and arg_529_1.time_ < var_532_15 + var_532_16 then
				local var_532_17 = (arg_529_1.time_ - var_532_15) / var_532_16
				local var_532_18 = Vector3.New(0, 100, 0)

				var_532_14.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos1041ui_story, var_532_18, var_532_17)

				local var_532_19 = manager.ui.mainCamera.transform.position - var_532_14.position

				var_532_14.forward = Vector3.New(var_532_19.x, var_532_19.y, var_532_19.z)

				local var_532_20 = var_532_14.localEulerAngles

				var_532_20.z = 0
				var_532_20.x = 0
				var_532_14.localEulerAngles = var_532_20
			end

			if arg_529_1.time_ >= var_532_15 + var_532_16 and arg_529_1.time_ < var_532_15 + var_532_16 + arg_532_0 then
				var_532_14.localPosition = Vector3.New(0, 100, 0)

				local var_532_21 = manager.ui.mainCamera.transform.position - var_532_14.position

				var_532_14.forward = Vector3.New(var_532_21.x, var_532_21.y, var_532_21.z)

				local var_532_22 = var_532_14.localEulerAngles

				var_532_22.z = 0
				var_532_22.x = 0
				var_532_14.localEulerAngles = var_532_22
			end

			local var_532_23 = 0

			if var_532_23 < arg_529_1.time_ and arg_529_1.time_ <= var_532_23 + arg_532_0 then
				arg_529_1.mask_.enabled = true
				arg_529_1.mask_.raycastTarget = true

				arg_529_1:SetGaussion(false)
			end

			local var_532_24 = 2

			if var_532_23 <= arg_529_1.time_ and arg_529_1.time_ < var_532_23 + var_532_24 then
				local var_532_25 = (arg_529_1.time_ - var_532_23) / var_532_24
				local var_532_26 = Color.New(0, 0, 0)

				var_532_26.a = Mathf.Lerp(0, 1, var_532_25)
				arg_529_1.mask_.color = var_532_26
			end

			if arg_529_1.time_ >= var_532_23 + var_532_24 and arg_529_1.time_ < var_532_23 + var_532_24 + arg_532_0 then
				local var_532_27 = Color.New(0, 0, 0)

				var_532_27.a = 1
				arg_529_1.mask_.color = var_532_27
			end

			local var_532_28 = 2

			if var_532_28 < arg_529_1.time_ and arg_529_1.time_ <= var_532_28 + arg_532_0 then
				arg_529_1.mask_.enabled = true
				arg_529_1.mask_.raycastTarget = true

				arg_529_1:SetGaussion(false)
			end

			local var_532_29 = 0.366666666666667

			if var_532_28 <= arg_529_1.time_ and arg_529_1.time_ < var_532_28 + var_532_29 then
				local var_532_30 = (arg_529_1.time_ - var_532_28) / var_532_29
				local var_532_31 = Color.New(0, 0, 0)

				var_532_31.a = Mathf.Lerp(1, 0, var_532_30)
				arg_529_1.mask_.color = var_532_31
			end

			if arg_529_1.time_ >= var_532_28 + var_532_29 and arg_529_1.time_ < var_532_28 + var_532_29 + arg_532_0 then
				local var_532_32 = Color.New(0, 0, 0)
				local var_532_33 = 0

				arg_529_1.mask_.enabled = false
				var_532_32.a = var_532_33
				arg_529_1.mask_.color = var_532_32
			end

			if arg_529_1.frameCnt_ <= 1 then
				arg_529_1.dialog_:SetActive(false)
			end

			local var_532_34 = 2.40066666851441
			local var_532_35 = 0.875

			if var_532_34 < arg_529_1.time_ and arg_529_1.time_ <= var_532_34 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0

				arg_529_1.dialog_:SetActive(true)

				arg_529_1.dialogCg_.alpha = 0

				local var_532_36 = LeanTween.value(arg_529_1.dialog_, 0, 1, 0.3)

				var_532_36:setOnUpdate(LuaHelper.FloatAction(function(arg_533_0)
					arg_529_1.dialogCg_.alpha = arg_533_0
				end))
				var_532_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_529_1.dialog_)
					var_532_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_529_1.duration_ = arg_529_1.duration_ + 0.3

				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_37 = arg_529_1:GetWordFromCfg(1104106129)
				local var_532_38 = arg_529_1:FormatText(var_532_37.content)

				arg_529_1.text_.text = var_532_38

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_39 = 35
				local var_532_40 = utf8.len(var_532_38)
				local var_532_41 = var_532_39 <= 0 and var_532_35 or var_532_35 * (var_532_40 / var_532_39)

				if var_532_41 > 0 and var_532_35 < var_532_41 then
					arg_529_1.talkMaxDuration = var_532_41
					var_532_34 = var_532_34 + 0.3

					if var_532_41 + var_532_34 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_41 + var_532_34
					end
				end

				arg_529_1.text_.text = var_532_38
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_42 = var_532_34 + 0.3
			local var_532_43 = math.max(var_532_35, arg_529_1.talkMaxDuration)

			if var_532_42 <= arg_529_1.time_ and arg_529_1.time_ < var_532_42 + var_532_43 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_42) / var_532_43

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_42 + var_532_43 and arg_529_1.time_ < var_532_42 + var_532_43 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_529_1:InitPlayNodeList()
	end,
	Play1104106130 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1104106130
		arg_535_1.duration_ = 7

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1104106131(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = "R4102"

			if arg_535_1.bgs_[var_538_0] == nil then
				local var_538_1 = Object.Instantiate(arg_535_1.paintGo_)

				var_538_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_538_0)
				var_538_1.name = var_538_0
				var_538_1.transform.parent = arg_535_1.stage_.transform
				var_538_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_535_1.bgs_[var_538_0] = var_538_1
			end

			local var_538_2 = 0

			if var_538_2 < arg_535_1.time_ and arg_535_1.time_ <= var_538_2 + arg_538_0 then
				local var_538_3 = manager.ui.mainCamera.transform.localPosition
				local var_538_4 = Vector3.New(0, 0, 10) + Vector3.New(var_538_3.x, var_538_3.y, 0)
				local var_538_5 = arg_535_1.bgs_.R4102

				var_538_5.transform.localPosition = var_538_4
				var_538_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_538_6 = var_538_5:GetComponent("SpriteRenderer")

				if var_538_6 and var_538_6.sprite then
					local var_538_7 = (var_538_5.transform.localPosition - var_538_3).z
					local var_538_8 = manager.ui.mainCameraCom_
					local var_538_9 = 2 * var_538_7 * Mathf.Tan(var_538_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_538_10 = var_538_9 * var_538_8.aspect
					local var_538_11 = var_538_6.sprite.bounds.size.x
					local var_538_12 = var_538_6.sprite.bounds.size.y
					local var_538_13 = var_538_10 / var_538_11
					local var_538_14 = var_538_9 / var_538_12
					local var_538_15 = var_538_14 < var_538_13 and var_538_13 or var_538_14

					var_538_5.transform.localScale = Vector3.New(var_538_15, var_538_15, 0)
				end

				for iter_538_0, iter_538_1 in pairs(arg_535_1.bgs_) do
					if iter_538_0 ~= "R4102" then
						iter_538_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_538_16 = 0

			if var_538_16 < arg_535_1.time_ and arg_535_1.time_ <= var_538_16 + arg_538_0 then
				arg_535_1.mask_.enabled = true
				arg_535_1.mask_.raycastTarget = true

				arg_535_1:SetGaussion(false)
			end

			local var_538_17 = 2

			if var_538_16 <= arg_535_1.time_ and arg_535_1.time_ < var_538_16 + var_538_17 then
				local var_538_18 = (arg_535_1.time_ - var_538_16) / var_538_17
				local var_538_19 = Color.New(0, 0, 0)

				var_538_19.a = Mathf.Lerp(1, 0, var_538_18)
				arg_535_1.mask_.color = var_538_19
			end

			if arg_535_1.time_ >= var_538_16 + var_538_17 and arg_535_1.time_ < var_538_16 + var_538_17 + arg_538_0 then
				local var_538_20 = Color.New(0, 0, 0)
				local var_538_21 = 0

				arg_535_1.mask_.enabled = false
				var_538_20.a = var_538_21
				arg_535_1.mask_.color = var_538_20
			end

			local var_538_22 = arg_535_1.actors_["1041ui_story"].transform
			local var_538_23 = 0

			if var_538_23 < arg_535_1.time_ and arg_535_1.time_ <= var_538_23 + arg_538_0 then
				arg_535_1.var_.moveOldPos1041ui_story = var_538_22.localPosition
			end

			local var_538_24 = 0.001

			if var_538_23 <= arg_535_1.time_ and arg_535_1.time_ < var_538_23 + var_538_24 then
				local var_538_25 = (arg_535_1.time_ - var_538_23) / var_538_24
				local var_538_26 = Vector3.New(0, 100, 0)

				var_538_22.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1041ui_story, var_538_26, var_538_25)

				local var_538_27 = manager.ui.mainCamera.transform.position - var_538_22.position

				var_538_22.forward = Vector3.New(var_538_27.x, var_538_27.y, var_538_27.z)

				local var_538_28 = var_538_22.localEulerAngles

				var_538_28.z = 0
				var_538_28.x = 0
				var_538_22.localEulerAngles = var_538_28
			end

			if arg_535_1.time_ >= var_538_23 + var_538_24 and arg_535_1.time_ < var_538_23 + var_538_24 + arg_538_0 then
				var_538_22.localPosition = Vector3.New(0, 100, 0)

				local var_538_29 = manager.ui.mainCamera.transform.position - var_538_22.position

				var_538_22.forward = Vector3.New(var_538_29.x, var_538_29.y, var_538_29.z)

				local var_538_30 = var_538_22.localEulerAngles

				var_538_30.z = 0
				var_538_30.x = 0
				var_538_22.localEulerAngles = var_538_30
			end

			local var_538_31 = arg_535_1.actors_["1041ui_story"]
			local var_538_32 = 0

			if var_538_32 < arg_535_1.time_ and arg_535_1.time_ <= var_538_32 + arg_538_0 and not isNil(var_538_31) and arg_535_1.var_.characterEffect1041ui_story == nil then
				arg_535_1.var_.characterEffect1041ui_story = var_538_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_33 = 0.200000002980232

			if var_538_32 <= arg_535_1.time_ and arg_535_1.time_ < var_538_32 + var_538_33 and not isNil(var_538_31) then
				local var_538_34 = (arg_535_1.time_ - var_538_32) / var_538_33

				if arg_535_1.var_.characterEffect1041ui_story and not isNil(var_538_31) then
					local var_538_35 = Mathf.Lerp(0, 0.5, var_538_34)

					arg_535_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_535_1.var_.characterEffect1041ui_story.fillRatio = var_538_35
				end
			end

			if arg_535_1.time_ >= var_538_32 + var_538_33 and arg_535_1.time_ < var_538_32 + var_538_33 + arg_538_0 and not isNil(var_538_31) and arg_535_1.var_.characterEffect1041ui_story then
				local var_538_36 = 0.5

				arg_535_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_535_1.var_.characterEffect1041ui_story.fillRatio = var_538_36
			end

			if arg_535_1.frameCnt_ <= 1 then
				arg_535_1.dialog_:SetActive(false)
			end

			local var_538_37 = 2
			local var_538_38 = 0.675

			if var_538_37 < arg_535_1.time_ and arg_535_1.time_ <= var_538_37 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0

				arg_535_1.dialog_:SetActive(true)

				arg_535_1.dialogCg_.alpha = 0

				local var_538_39 = LeanTween.value(arg_535_1.dialog_, 0, 1, 0.3)

				var_538_39:setOnUpdate(LuaHelper.FloatAction(function(arg_539_0)
					arg_535_1.dialogCg_.alpha = arg_539_0
				end))
				var_538_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_535_1.dialog_)
					var_538_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_535_1.duration_ = arg_535_1.duration_ + 0.3

				SetActive(arg_535_1.leftNameGo_, true)

				local var_538_40 = arg_535_1:FormatText(StoryNameCfg[7].name)

				arg_535_1.leftNameTxt_.text = var_538_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_41 = arg_535_1:GetWordFromCfg(1104106130)
				local var_538_42 = arg_535_1:FormatText(var_538_41.content)

				arg_535_1.text_.text = var_538_42

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_43 = 27
				local var_538_44 = utf8.len(var_538_42)
				local var_538_45 = var_538_43 <= 0 and var_538_38 or var_538_38 * (var_538_44 / var_538_43)

				if var_538_45 > 0 and var_538_38 < var_538_45 then
					arg_535_1.talkMaxDuration = var_538_45
					var_538_37 = var_538_37 + 0.3

					if var_538_45 + var_538_37 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_45 + var_538_37
					end
				end

				arg_535_1.text_.text = var_538_42
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_46 = var_538_37 + 0.3
			local var_538_47 = math.max(var_538_38, arg_535_1.talkMaxDuration)

			if var_538_46 <= arg_535_1.time_ and arg_535_1.time_ < var_538_46 + var_538_47 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_46) / var_538_47

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_46 + var_538_47 and arg_535_1.time_ < var_538_46 + var_538_47 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play1104106131 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1104106131
		arg_541_1.duration_ = 5

		local var_541_0 = {
			zh = 5,
			ja = 3.733
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1104106132(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0
			local var_544_1 = 0.5

			if var_544_0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_2 = arg_541_1:FormatText(StoryNameCfg[208].name)

				arg_541_1.leftNameTxt_.text = var_544_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_3 = arg_541_1:GetWordFromCfg(1104106131)
				local var_544_4 = arg_541_1:FormatText(var_544_3.content)

				arg_541_1.text_.text = var_544_4

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 20
				local var_544_6 = utf8.len(var_544_4)
				local var_544_7 = var_544_5 <= 0 and var_544_1 or var_544_1 * (var_544_6 / var_544_5)

				if var_544_7 > 0 and var_544_1 < var_544_7 then
					arg_541_1.talkMaxDuration = var_544_7

					if var_544_7 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_7 + var_544_0
					end
				end

				arg_541_1.text_.text = var_544_4
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106131", "story_v_side_new_1104106.awb") ~= 0 then
					local var_544_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106131", "story_v_side_new_1104106.awb") / 1000

					if var_544_8 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_8 + var_544_0
					end

					if var_544_3.prefab_name ~= "" and arg_541_1.actors_[var_544_3.prefab_name] ~= nil then
						local var_544_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_3.prefab_name].transform, "story_v_side_new_1104106", "1104106131", "story_v_side_new_1104106.awb")

						arg_541_1:RecordAudio("1104106131", var_544_9)
						arg_541_1:RecordAudio("1104106131", var_544_9)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106131", "story_v_side_new_1104106.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106131", "story_v_side_new_1104106.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_10 = math.max(var_544_1, arg_541_1.talkMaxDuration)

			if var_544_0 <= arg_541_1.time_ and arg_541_1.time_ < var_544_0 + var_544_10 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_0) / var_544_10

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_0 + var_544_10 and arg_541_1.time_ < var_544_0 + var_544_10 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1104106132 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1104106132
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1104106133(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0
			local var_548_1 = 0.3

			if var_548_0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_2 = arg_545_1:FormatText(StoryNameCfg[7].name)

				arg_545_1.leftNameTxt_.text = var_548_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, true)
				arg_545_1.iconController_:SetSelectedState("hero")

				arg_545_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_545_1.callingController_:SetSelectedState("normal")

				arg_545_1.keyicon_.color = Color.New(1, 1, 1)
				arg_545_1.icon_.color = Color.New(1, 1, 1)

				local var_548_3 = arg_545_1:GetWordFromCfg(1104106132)
				local var_548_4 = arg_545_1:FormatText(var_548_3.content)

				arg_545_1.text_.text = var_548_4

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_5 = 12
				local var_548_6 = utf8.len(var_548_4)
				local var_548_7 = var_548_5 <= 0 and var_548_1 or var_548_1 * (var_548_6 / var_548_5)

				if var_548_7 > 0 and var_548_1 < var_548_7 then
					arg_545_1.talkMaxDuration = var_548_7

					if var_548_7 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_7 + var_548_0
					end
				end

				arg_545_1.text_.text = var_548_4
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_8 = math.max(var_548_1, arg_545_1.talkMaxDuration)

			if var_548_0 <= arg_545_1.time_ and arg_545_1.time_ < var_548_0 + var_548_8 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_0) / var_548_8

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_0 + var_548_8 and arg_545_1.time_ < var_548_0 + var_548_8 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play1104106133 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1104106133
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1104106134(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0
			local var_552_1 = 0.8

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, false)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_2 = arg_549_1:GetWordFromCfg(1104106133)
				local var_552_3 = arg_549_1:FormatText(var_552_2.content)

				arg_549_1.text_.text = var_552_3

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_4 = 32
				local var_552_5 = utf8.len(var_552_3)
				local var_552_6 = var_552_4 <= 0 and var_552_1 or var_552_1 * (var_552_5 / var_552_4)

				if var_552_6 > 0 and var_552_1 < var_552_6 then
					arg_549_1.talkMaxDuration = var_552_6

					if var_552_6 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_6 + var_552_0
					end
				end

				arg_549_1.text_.text = var_552_3
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_7 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_7 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_7

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_7 and arg_549_1.time_ < var_552_0 + var_552_7 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1104106134 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1104106134
		arg_553_1.duration_ = 3.53

		local var_553_0 = {
			zh = 2.2,
			ja = 3.533
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1104106135(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0
			local var_556_1 = 0.5

			if var_556_0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_2 = arg_553_1:FormatText(StoryNameCfg[208].name)

				arg_553_1.leftNameTxt_.text = var_556_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_3 = arg_553_1:GetWordFromCfg(1104106134)
				local var_556_4 = arg_553_1:FormatText(var_556_3.content)

				arg_553_1.text_.text = var_556_4

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_5 = 20
				local var_556_6 = utf8.len(var_556_4)
				local var_556_7 = var_556_5 <= 0 and var_556_1 or var_556_1 * (var_556_6 / var_556_5)

				if var_556_7 > 0 and var_556_1 < var_556_7 then
					arg_553_1.talkMaxDuration = var_556_7

					if var_556_7 + var_556_0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_7 + var_556_0
					end
				end

				arg_553_1.text_.text = var_556_4
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106134", "story_v_side_new_1104106.awb") ~= 0 then
					local var_556_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106134", "story_v_side_new_1104106.awb") / 1000

					if var_556_8 + var_556_0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_8 + var_556_0
					end

					if var_556_3.prefab_name ~= "" and arg_553_1.actors_[var_556_3.prefab_name] ~= nil then
						local var_556_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_3.prefab_name].transform, "story_v_side_new_1104106", "1104106134", "story_v_side_new_1104106.awb")

						arg_553_1:RecordAudio("1104106134", var_556_9)
						arg_553_1:RecordAudio("1104106134", var_556_9)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106134", "story_v_side_new_1104106.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106134", "story_v_side_new_1104106.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_10 = math.max(var_556_1, arg_553_1.talkMaxDuration)

			if var_556_0 <= arg_553_1.time_ and arg_553_1.time_ < var_556_0 + var_556_10 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_0) / var_556_10

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_0 + var_556_10 and arg_553_1.time_ < var_556_0 + var_556_10 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1104106135 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1104106135
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1104106136(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0
			local var_560_1 = 0.175

			if var_560_0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_2 = arg_557_1:FormatText(StoryNameCfg[7].name)

				arg_557_1.leftNameTxt_.text = var_560_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, true)
				arg_557_1.iconController_:SetSelectedState("hero")

				arg_557_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_557_1.callingController_:SetSelectedState("normal")

				arg_557_1.keyicon_.color = Color.New(1, 1, 1)
				arg_557_1.icon_.color = Color.New(1, 1, 1)

				local var_560_3 = arg_557_1:GetWordFromCfg(1104106135)
				local var_560_4 = arg_557_1:FormatText(var_560_3.content)

				arg_557_1.text_.text = var_560_4

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_5 = 7
				local var_560_6 = utf8.len(var_560_4)
				local var_560_7 = var_560_5 <= 0 and var_560_1 or var_560_1 * (var_560_6 / var_560_5)

				if var_560_7 > 0 and var_560_1 < var_560_7 then
					arg_557_1.talkMaxDuration = var_560_7

					if var_560_7 + var_560_0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_7 + var_560_0
					end
				end

				arg_557_1.text_.text = var_560_4
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_8 = math.max(var_560_1, arg_557_1.talkMaxDuration)

			if var_560_0 <= arg_557_1.time_ and arg_557_1.time_ < var_560_0 + var_560_8 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_0) / var_560_8

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_0 + var_560_8 and arg_557_1.time_ < var_560_0 + var_560_8 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1104106136 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1104106136
		arg_561_1.duration_ = 3.63

		local var_561_0 = {
			zh = 2.033,
			ja = 3.633
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1104106137(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0
			local var_564_1 = 0.225

			if var_564_0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_2 = arg_561_1:FormatText(StoryNameCfg[208].name)

				arg_561_1.leftNameTxt_.text = var_564_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_3 = arg_561_1:GetWordFromCfg(1104106136)
				local var_564_4 = arg_561_1:FormatText(var_564_3.content)

				arg_561_1.text_.text = var_564_4

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_5 = 9
				local var_564_6 = utf8.len(var_564_4)
				local var_564_7 = var_564_5 <= 0 and var_564_1 or var_564_1 * (var_564_6 / var_564_5)

				if var_564_7 > 0 and var_564_1 < var_564_7 then
					arg_561_1.talkMaxDuration = var_564_7

					if var_564_7 + var_564_0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_7 + var_564_0
					end
				end

				arg_561_1.text_.text = var_564_4
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106136", "story_v_side_new_1104106.awb") ~= 0 then
					local var_564_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106136", "story_v_side_new_1104106.awb") / 1000

					if var_564_8 + var_564_0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_8 + var_564_0
					end

					if var_564_3.prefab_name ~= "" and arg_561_1.actors_[var_564_3.prefab_name] ~= nil then
						local var_564_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_3.prefab_name].transform, "story_v_side_new_1104106", "1104106136", "story_v_side_new_1104106.awb")

						arg_561_1:RecordAudio("1104106136", var_564_9)
						arg_561_1:RecordAudio("1104106136", var_564_9)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106136", "story_v_side_new_1104106.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106136", "story_v_side_new_1104106.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_10 = math.max(var_564_1, arg_561_1.talkMaxDuration)

			if var_564_0 <= arg_561_1.time_ and arg_561_1.time_ < var_564_0 + var_564_10 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_0) / var_564_10

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_0 + var_564_10 and arg_561_1.time_ < var_564_0 + var_564_10 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1104106137 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1104106137
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1104106138(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = 0
			local var_568_1 = 0.3

			if var_568_0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_0 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_2 = arg_565_1:FormatText(StoryNameCfg[7].name)

				arg_565_1.leftNameTxt_.text = var_568_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, true)
				arg_565_1.iconController_:SetSelectedState("hero")

				arg_565_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_565_1.callingController_:SetSelectedState("normal")

				arg_565_1.keyicon_.color = Color.New(1, 1, 1)
				arg_565_1.icon_.color = Color.New(1, 1, 1)

				local var_568_3 = arg_565_1:GetWordFromCfg(1104106137)
				local var_568_4 = arg_565_1:FormatText(var_568_3.content)

				arg_565_1.text_.text = var_568_4

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_5 = 12
				local var_568_6 = utf8.len(var_568_4)
				local var_568_7 = var_568_5 <= 0 and var_568_1 or var_568_1 * (var_568_6 / var_568_5)

				if var_568_7 > 0 and var_568_1 < var_568_7 then
					arg_565_1.talkMaxDuration = var_568_7

					if var_568_7 + var_568_0 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_7 + var_568_0
					end
				end

				arg_565_1.text_.text = var_568_4
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_8 = math.max(var_568_1, arg_565_1.talkMaxDuration)

			if var_568_0 <= arg_565_1.time_ and arg_565_1.time_ < var_568_0 + var_568_8 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_0) / var_568_8

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_0 + var_568_8 and arg_565_1.time_ < var_568_0 + var_568_8 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play1104106138 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1104106138
		arg_569_1.duration_ = 6.13

		local var_569_0 = {
			zh = 4.033,
			ja = 6.133
		}
		local var_569_1 = manager.audio:GetLocalizationFlag()

		if var_569_0[var_569_1] ~= nil then
			arg_569_1.duration_ = var_569_0[var_569_1]
		end

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1104106139(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 0
			local var_572_1 = 0.375

			if var_572_0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				local var_572_2 = arg_569_1:FormatText(StoryNameCfg[208].name)

				arg_569_1.leftNameTxt_.text = var_572_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_3 = arg_569_1:GetWordFromCfg(1104106138)
				local var_572_4 = arg_569_1:FormatText(var_572_3.content)

				arg_569_1.text_.text = var_572_4

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_5 = 15
				local var_572_6 = utf8.len(var_572_4)
				local var_572_7 = var_572_5 <= 0 and var_572_1 or var_572_1 * (var_572_6 / var_572_5)

				if var_572_7 > 0 and var_572_1 < var_572_7 then
					arg_569_1.talkMaxDuration = var_572_7

					if var_572_7 + var_572_0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_7 + var_572_0
					end
				end

				arg_569_1.text_.text = var_572_4
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106138", "story_v_side_new_1104106.awb") ~= 0 then
					local var_572_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106138", "story_v_side_new_1104106.awb") / 1000

					if var_572_8 + var_572_0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_8 + var_572_0
					end

					if var_572_3.prefab_name ~= "" and arg_569_1.actors_[var_572_3.prefab_name] ~= nil then
						local var_572_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_3.prefab_name].transform, "story_v_side_new_1104106", "1104106138", "story_v_side_new_1104106.awb")

						arg_569_1:RecordAudio("1104106138", var_572_9)
						arg_569_1:RecordAudio("1104106138", var_572_9)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106138", "story_v_side_new_1104106.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106138", "story_v_side_new_1104106.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_10 = math.max(var_572_1, arg_569_1.talkMaxDuration)

			if var_572_0 <= arg_569_1.time_ and arg_569_1.time_ < var_572_0 + var_572_10 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_0) / var_572_10

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_0 + var_572_10 and arg_569_1.time_ < var_572_0 + var_572_10 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play1104106139 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1104106139
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1104106140(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = 0
			local var_576_1 = 0.05

			if var_576_0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_0 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				local var_576_2 = arg_573_1:FormatText(StoryNameCfg[7].name)

				arg_573_1.leftNameTxt_.text = var_576_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, true)
				arg_573_1.iconController_:SetSelectedState("hero")

				arg_573_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_573_1.callingController_:SetSelectedState("normal")

				arg_573_1.keyicon_.color = Color.New(1, 1, 1)
				arg_573_1.icon_.color = Color.New(1, 1, 1)

				local var_576_3 = arg_573_1:GetWordFromCfg(1104106139)
				local var_576_4 = arg_573_1:FormatText(var_576_3.content)

				arg_573_1.text_.text = var_576_4

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_5 = 2
				local var_576_6 = utf8.len(var_576_4)
				local var_576_7 = var_576_5 <= 0 and var_576_1 or var_576_1 * (var_576_6 / var_576_5)

				if var_576_7 > 0 and var_576_1 < var_576_7 then
					arg_573_1.talkMaxDuration = var_576_7

					if var_576_7 + var_576_0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_7 + var_576_0
					end
				end

				arg_573_1.text_.text = var_576_4
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_8 = math.max(var_576_1, arg_573_1.talkMaxDuration)

			if var_576_0 <= arg_573_1.time_ and arg_573_1.time_ < var_576_0 + var_576_8 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_0) / var_576_8

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_0 + var_576_8 and arg_573_1.time_ < var_576_0 + var_576_8 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play1104106140 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1104106140
		arg_577_1.duration_ = 13.2

		local var_577_0 = {
			zh = 13.2,
			ja = 7.366
		}
		local var_577_1 = manager.audio:GetLocalizationFlag()

		if var_577_0[var_577_1] ~= nil then
			arg_577_1.duration_ = var_577_0[var_577_1]
		end

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1104106141(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = 0
			local var_580_1 = 1.6

			if var_580_0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_0 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				local var_580_2 = arg_577_1:FormatText(StoryNameCfg[208].name)

				arg_577_1.leftNameTxt_.text = var_580_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_3 = arg_577_1:GetWordFromCfg(1104106140)
				local var_580_4 = arg_577_1:FormatText(var_580_3.content)

				arg_577_1.text_.text = var_580_4

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_5 = 64
				local var_580_6 = utf8.len(var_580_4)
				local var_580_7 = var_580_5 <= 0 and var_580_1 or var_580_1 * (var_580_6 / var_580_5)

				if var_580_7 > 0 and var_580_1 < var_580_7 then
					arg_577_1.talkMaxDuration = var_580_7

					if var_580_7 + var_580_0 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_7 + var_580_0
					end
				end

				arg_577_1.text_.text = var_580_4
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106140", "story_v_side_new_1104106.awb") ~= 0 then
					local var_580_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106140", "story_v_side_new_1104106.awb") / 1000

					if var_580_8 + var_580_0 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_8 + var_580_0
					end

					if var_580_3.prefab_name ~= "" and arg_577_1.actors_[var_580_3.prefab_name] ~= nil then
						local var_580_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_577_1.actors_[var_580_3.prefab_name].transform, "story_v_side_new_1104106", "1104106140", "story_v_side_new_1104106.awb")

						arg_577_1:RecordAudio("1104106140", var_580_9)
						arg_577_1:RecordAudio("1104106140", var_580_9)
					else
						arg_577_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106140", "story_v_side_new_1104106.awb")
					end

					arg_577_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106140", "story_v_side_new_1104106.awb")
				end

				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_10 = math.max(var_580_1, arg_577_1.talkMaxDuration)

			if var_580_0 <= arg_577_1.time_ and arg_577_1.time_ < var_580_0 + var_580_10 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_0) / var_580_10

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_0 + var_580_10 and arg_577_1.time_ < var_580_0 + var_580_10 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play1104106141 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 1104106141
		arg_581_1.duration_ = 7.23

		local var_581_0 = {
			zh = 2.4,
			ja = 7.233
		}
		local var_581_1 = manager.audio:GetLocalizationFlag()

		if var_581_0[var_581_1] ~= nil then
			arg_581_1.duration_ = var_581_0[var_581_1]
		end

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
			arg_581_1.auto_ = false
		end

		function arg_581_1.playNext_(arg_583_0)
			arg_581_1.onStoryFinished_()
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = 0
			local var_584_1 = 0.275

			if var_584_0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_0 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				local var_584_2 = arg_581_1:FormatText(StoryNameCfg[208].name)

				arg_581_1.leftNameTxt_.text = var_584_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_3 = arg_581_1:GetWordFromCfg(1104106141)
				local var_584_4 = arg_581_1:FormatText(var_584_3.content)

				arg_581_1.text_.text = var_584_4

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_5 = 11
				local var_584_6 = utf8.len(var_584_4)
				local var_584_7 = var_584_5 <= 0 and var_584_1 or var_584_1 * (var_584_6 / var_584_5)

				if var_584_7 > 0 and var_584_1 < var_584_7 then
					arg_581_1.talkMaxDuration = var_584_7

					if var_584_7 + var_584_0 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_7 + var_584_0
					end
				end

				arg_581_1.text_.text = var_584_4
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106141", "story_v_side_new_1104106.awb") ~= 0 then
					local var_584_8 = manager.audio:GetVoiceLength("story_v_side_new_1104106", "1104106141", "story_v_side_new_1104106.awb") / 1000

					if var_584_8 + var_584_0 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_8 + var_584_0
					end

					if var_584_3.prefab_name ~= "" and arg_581_1.actors_[var_584_3.prefab_name] ~= nil then
						local var_584_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_3.prefab_name].transform, "story_v_side_new_1104106", "1104106141", "story_v_side_new_1104106.awb")

						arg_581_1:RecordAudio("1104106141", var_584_9)
						arg_581_1:RecordAudio("1104106141", var_584_9)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_side_new_1104106", "1104106141", "story_v_side_new_1104106.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_side_new_1104106", "1104106141", "story_v_side_new_1104106.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_10 = math.max(var_584_1, arg_581_1.talkMaxDuration)

			if var_584_0 <= arg_581_1.time_ and arg_581_1.time_ < var_584_0 + var_584_10 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_0) / var_584_10

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_0 + var_584_10 and arg_581_1.time_ < var_584_0 + var_584_10 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F03_1",
		"TextureConfig/Background/F03_2",
		"TextureConfig/Background/ST24a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/R4102"
	},
	voices = {
		"story_v_side_new_1104106.awb"
	}
}
