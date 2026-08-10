return {
	Play410241001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410241001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play410241002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST67"

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
				local var_4_5 = arg_1_1.bgs_.ST67

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
					if iter_4_0 ~= "ST67" then
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
			local var_4_23 = 0.166666666666667

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

			local var_4_28 = 0.3
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building")

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

			local var_4_34 = 0
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_side_1070", "se_story_1070_cave_drip", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 2
			local var_4_39 = 0.075

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_41 = arg_1_1:GetWordFromCfg(410241001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 3
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_39 or var_4_39 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_39 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_38 = var_4_38 + 0.3

					if var_4_45 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_38 + 0.3
			local var_4_47 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_46) / var_4_47

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play410241002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410241002
		arg_9_1.duration_ = 3.73

		local var_9_0 = {
			ja = 1.166,
			CriLanguages = 3.733,
			zh = 3.733
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
				arg_9_0:Play410241003(arg_9_1)
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

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[612].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061_split_3")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(410241002)
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

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241002", "story_v_out_410241.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_410241", "410241002", "story_v_out_410241.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_410241", "410241002", "story_v_out_410241.awb")

						arg_9_1:RecordAudio("410241002", var_12_9)
						arg_9_1:RecordAudio("410241002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410241", "410241002", "story_v_out_410241.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410241", "410241002", "story_v_out_410241.awb")
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
	Play410241003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410241003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play410241004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.825

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

				local var_16_2 = arg_13_1:GetWordFromCfg(410241003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 33
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
	Play410241004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410241004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play410241005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.375

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

				local var_20_2 = arg_17_1:GetWordFromCfg(410241004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 55
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
	Play410241005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410241005
		arg_21_1.duration_ = 6.73

		local var_21_0 = {
			ja = 6.733,
			CriLanguages = 5.2,
			zh = 5.2
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
				arg_21_0:Play410241006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1061"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(var_24_1, arg_21_1.canvasGo_.transform)

					var_24_2.transform:SetSiblingIndex(1)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_21_1.isInRecall_ then
						for iter_24_0, iter_24_1 in ipairs(var_24_3) do
							iter_24_1.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_4 = arg_21_1.actors_["1061"].transform
			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.var_.moveOldPos1061 = var_24_4.localPosition
				var_24_4.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1061", 3)

				local var_24_6 = var_24_4.childCount

				for iter_24_2 = 0, var_24_6 - 1 do
					local var_24_7 = var_24_4:GetChild(iter_24_2)

					if var_24_7.name == "" or not string.find(var_24_7.name, "split") then
						var_24_7.gameObject:SetActive(true)
					else
						var_24_7.gameObject:SetActive(false)
					end
				end
			end

			local var_24_8 = 0.001

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_8 then
				local var_24_9 = (arg_21_1.time_ - var_24_5) / var_24_8
				local var_24_10 = Vector3.New(0, -490, 18)

				var_24_4.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1061, var_24_10, var_24_9)
			end

			if arg_21_1.time_ >= var_24_5 + var_24_8 and arg_21_1.time_ < var_24_5 + var_24_8 + arg_24_0 then
				var_24_4.localPosition = Vector3.New(0, -490, 18)
			end

			local var_24_11 = arg_21_1.actors_["1061"]
			local var_24_12 = 0

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 and not isNil(var_24_11) and arg_21_1.var_.actorSpriteComps1061 == nil then
				arg_21_1.var_.actorSpriteComps1061 = var_24_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_13 = 0.034

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_13 and not isNil(var_24_11) then
				local var_24_14 = (arg_21_1.time_ - var_24_12) / var_24_13

				if arg_21_1.var_.actorSpriteComps1061 then
					for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_24_4 then
							if arg_21_1.isInRecall_ then
								local var_24_15 = Mathf.Lerp(iter_24_4.color.r, arg_21_1.hightColor1.r, var_24_14)
								local var_24_16 = Mathf.Lerp(iter_24_4.color.g, arg_21_1.hightColor1.g, var_24_14)
								local var_24_17 = Mathf.Lerp(iter_24_4.color.b, arg_21_1.hightColor1.b, var_24_14)

								iter_24_4.color = Color.New(var_24_15, var_24_16, var_24_17)
							else
								local var_24_18 = Mathf.Lerp(iter_24_4.color.r, 1, var_24_14)

								iter_24_4.color = Color.New(var_24_18, var_24_18, var_24_18)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_12 + var_24_13 and arg_21_1.time_ < var_24_12 + var_24_13 + arg_24_0 and not isNil(var_24_11) and arg_21_1.var_.actorSpriteComps1061 then
				for iter_24_5, iter_24_6 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_24_6 then
						if arg_21_1.isInRecall_ then
							iter_24_6.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1061 = nil
			end

			local var_24_19 = 0
			local var_24_20 = 0.166666666666667

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				local var_24_21 = "stop"
				local var_24_22 = "effect"

				arg_21_1:AudioAction(var_24_21, var_24_22, "se_story_side_1070", "se_story_1070_cave_drip", "")
			end

			local var_24_23 = 0
			local var_24_24 = 0.275

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_25 = arg_21_1:FormatText(StoryNameCfg[612].name)

				arg_21_1.leftNameTxt_.text = var_24_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_26 = arg_21_1:GetWordFromCfg(410241005)
				local var_24_27 = arg_21_1:FormatText(var_24_26.content)

				arg_21_1.text_.text = var_24_27

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_28 = 11
				local var_24_29 = utf8.len(var_24_27)
				local var_24_30 = var_24_28 <= 0 and var_24_24 or var_24_24 * (var_24_29 / var_24_28)

				if var_24_30 > 0 and var_24_24 < var_24_30 then
					arg_21_1.talkMaxDuration = var_24_30

					if var_24_30 + var_24_23 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_30 + var_24_23
					end
				end

				arg_21_1.text_.text = var_24_27
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241005", "story_v_out_410241.awb") ~= 0 then
					local var_24_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241005", "story_v_out_410241.awb") / 1000

					if var_24_31 + var_24_23 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_31 + var_24_23
					end

					if var_24_26.prefab_name ~= "" and arg_21_1.actors_[var_24_26.prefab_name] ~= nil then
						local var_24_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_26.prefab_name].transform, "story_v_out_410241", "410241005", "story_v_out_410241.awb")

						arg_21_1:RecordAudio("410241005", var_24_32)
						arg_21_1:RecordAudio("410241005", var_24_32)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410241", "410241005", "story_v_out_410241.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410241", "410241005", "story_v_out_410241.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_33 = math.max(var_24_24, arg_21_1.talkMaxDuration)

			if var_24_23 <= arg_21_1.time_ and arg_21_1.time_ < var_24_23 + var_24_33 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_23) / var_24_33

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_23 + var_24_33 and arg_21_1.time_ < var_24_23 + var_24_33 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play410241006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410241006
		arg_25_1.duration_ = 4.03

		local var_25_0 = {
			ja = 4.033,
			CriLanguages = 2.2,
			zh = 2.2
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
				arg_25_0:Play410241007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "10060"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10060")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(var_28_1, arg_25_1.canvasGo_.transform)

					var_28_2.transform:SetSiblingIndex(1)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_25_1.isInRecall_ then
						for iter_28_0, iter_28_1 in ipairs(var_28_3) do
							iter_28_1.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_28_4 = arg_25_1.actors_["10060"].transform
			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.var_.moveOldPos10060 = var_28_4.localPosition
				var_28_4.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10060", 3)

				local var_28_6 = var_28_4.childCount

				for iter_28_2 = 0, var_28_6 - 1 do
					local var_28_7 = var_28_4:GetChild(iter_28_2)

					if var_28_7.name == "" or not string.find(var_28_7.name, "split") then
						var_28_7.gameObject:SetActive(true)
					else
						var_28_7.gameObject:SetActive(false)
					end
				end
			end

			local var_28_8 = 0.001

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_8 then
				local var_28_9 = (arg_25_1.time_ - var_28_5) / var_28_8
				local var_28_10 = Vector3.New(0, -400, 0)

				var_28_4.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10060, var_28_10, var_28_9)
			end

			if arg_25_1.time_ >= var_28_5 + var_28_8 and arg_25_1.time_ < var_28_5 + var_28_8 + arg_28_0 then
				var_28_4.localPosition = Vector3.New(0, -400, 0)
			end

			local var_28_11 = arg_25_1.actors_["1061"].transform
			local var_28_12 = 0

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 then
				arg_25_1.var_.moveOldPos1061 = var_28_11.localPosition
				var_28_11.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1061", 7)

				local var_28_13 = var_28_11.childCount

				for iter_28_3 = 0, var_28_13 - 1 do
					local var_28_14 = var_28_11:GetChild(iter_28_3)

					if var_28_14.name == "" or not string.find(var_28_14.name, "split") then
						var_28_14.gameObject:SetActive(true)
					else
						var_28_14.gameObject:SetActive(false)
					end
				end
			end

			local var_28_15 = 0.001

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_15 then
				local var_28_16 = (arg_25_1.time_ - var_28_12) / var_28_15
				local var_28_17 = Vector3.New(0, -2000, 18)

				var_28_11.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1061, var_28_17, var_28_16)
			end

			if arg_25_1.time_ >= var_28_12 + var_28_15 and arg_25_1.time_ < var_28_12 + var_28_15 + arg_28_0 then
				var_28_11.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_28_18 = arg_25_1.actors_["10060"]
			local var_28_19 = 0

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 and not isNil(var_28_18) and arg_25_1.var_.actorSpriteComps10060 == nil then
				arg_25_1.var_.actorSpriteComps10060 = var_28_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_20 = 0.034

			if var_28_19 <= arg_25_1.time_ and arg_25_1.time_ < var_28_19 + var_28_20 and not isNil(var_28_18) then
				local var_28_21 = (arg_25_1.time_ - var_28_19) / var_28_20

				if arg_25_1.var_.actorSpriteComps10060 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_28_5 then
							if arg_25_1.isInRecall_ then
								local var_28_22 = Mathf.Lerp(iter_28_5.color.r, arg_25_1.hightColor1.r, var_28_21)
								local var_28_23 = Mathf.Lerp(iter_28_5.color.g, arg_25_1.hightColor1.g, var_28_21)
								local var_28_24 = Mathf.Lerp(iter_28_5.color.b, arg_25_1.hightColor1.b, var_28_21)

								iter_28_5.color = Color.New(var_28_22, var_28_23, var_28_24)
							else
								local var_28_25 = Mathf.Lerp(iter_28_5.color.r, 1, var_28_21)

								iter_28_5.color = Color.New(var_28_25, var_28_25, var_28_25)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_19 + var_28_20 and arg_25_1.time_ < var_28_19 + var_28_20 + arg_28_0 and not isNil(var_28_18) and arg_25_1.var_.actorSpriteComps10060 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_28_7 then
						if arg_25_1.isInRecall_ then
							iter_28_7.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10060 = nil
			end

			local var_28_26 = arg_25_1.actors_["1061"]
			local var_28_27 = 0

			if var_28_27 < arg_25_1.time_ and arg_25_1.time_ <= var_28_27 + arg_28_0 and not isNil(var_28_26) and arg_25_1.var_.actorSpriteComps1061 == nil then
				arg_25_1.var_.actorSpriteComps1061 = var_28_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_28 = 0.034

			if var_28_27 <= arg_25_1.time_ and arg_25_1.time_ < var_28_27 + var_28_28 and not isNil(var_28_26) then
				local var_28_29 = (arg_25_1.time_ - var_28_27) / var_28_28

				if arg_25_1.var_.actorSpriteComps1061 then
					for iter_28_8, iter_28_9 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_28_9 then
							if arg_25_1.isInRecall_ then
								local var_28_30 = Mathf.Lerp(iter_28_9.color.r, arg_25_1.hightColor2.r, var_28_29)
								local var_28_31 = Mathf.Lerp(iter_28_9.color.g, arg_25_1.hightColor2.g, var_28_29)
								local var_28_32 = Mathf.Lerp(iter_28_9.color.b, arg_25_1.hightColor2.b, var_28_29)

								iter_28_9.color = Color.New(var_28_30, var_28_31, var_28_32)
							else
								local var_28_33 = Mathf.Lerp(iter_28_9.color.r, 0.5, var_28_29)

								iter_28_9.color = Color.New(var_28_33, var_28_33, var_28_33)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_27 + var_28_28 and arg_25_1.time_ < var_28_27 + var_28_28 + arg_28_0 and not isNil(var_28_26) and arg_25_1.var_.actorSpriteComps1061 then
				for iter_28_10, iter_28_11 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_28_11 then
						if arg_25_1.isInRecall_ then
							iter_28_11.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1061 = nil
			end

			local var_28_34 = 0
			local var_28_35 = 0.125

			if var_28_34 < arg_25_1.time_ and arg_25_1.time_ <= var_28_34 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_36 = arg_25_1:FormatText(StoryNameCfg[597].name)

				arg_25_1.leftNameTxt_.text = var_28_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_37 = arg_25_1:GetWordFromCfg(410241006)
				local var_28_38 = arg_25_1:FormatText(var_28_37.content)

				arg_25_1.text_.text = var_28_38

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_39 = 5
				local var_28_40 = utf8.len(var_28_38)
				local var_28_41 = var_28_39 <= 0 and var_28_35 or var_28_35 * (var_28_40 / var_28_39)

				if var_28_41 > 0 and var_28_35 < var_28_41 then
					arg_25_1.talkMaxDuration = var_28_41

					if var_28_41 + var_28_34 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_41 + var_28_34
					end
				end

				arg_25_1.text_.text = var_28_38
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241006", "story_v_out_410241.awb") ~= 0 then
					local var_28_42 = manager.audio:GetVoiceLength("story_v_out_410241", "410241006", "story_v_out_410241.awb") / 1000

					if var_28_42 + var_28_34 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_42 + var_28_34
					end

					if var_28_37.prefab_name ~= "" and arg_25_1.actors_[var_28_37.prefab_name] ~= nil then
						local var_28_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_37.prefab_name].transform, "story_v_out_410241", "410241006", "story_v_out_410241.awb")

						arg_25_1:RecordAudio("410241006", var_28_43)
						arg_25_1:RecordAudio("410241006", var_28_43)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410241", "410241006", "story_v_out_410241.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410241", "410241006", "story_v_out_410241.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_44 = math.max(var_28_35, arg_25_1.talkMaxDuration)

			if var_28_34 <= arg_25_1.time_ and arg_25_1.time_ < var_28_34 + var_28_44 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_34) / var_28_44

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_34 + var_28_44 and arg_25_1.time_ < var_28_34 + var_28_44 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play410241007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410241007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play410241008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10060"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10060 == nil then
				arg_29_1.var_.actorSpriteComps10060 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.034

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps10060 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								local var_32_4 = Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor2.r, var_32_3)
								local var_32_5 = Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor2.g, var_32_3)
								local var_32_6 = Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor2.b, var_32_3)

								iter_32_1.color = Color.New(var_32_4, var_32_5, var_32_6)
							else
								local var_32_7 = Mathf.Lerp(iter_32_1.color.r, 0.5, var_32_3)

								iter_32_1.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10060 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10060 = nil
			end

			local var_32_8 = 0
			local var_32_9 = 0.825

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(410241007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_12 = 33
				local var_32_13 = utf8.len(var_32_11)
				local var_32_14 = var_32_12 <= 0 and var_32_9 or var_32_9 * (var_32_13 / var_32_12)

				if var_32_14 > 0 and var_32_9 < var_32_14 then
					arg_29_1.talkMaxDuration = var_32_14

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_15 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_15 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_15

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_15 and arg_29_1.time_ < var_32_8 + var_32_15 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play410241008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410241008
		arg_33_1.duration_ = 1.97

		local var_33_0 = {
			ja = 1.966,
			CriLanguages = 1.333,
			zh = 1.333
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
				arg_33_0:Play410241009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10060"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10060 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10060", 3)

				local var_36_2 = var_36_0.childCount

				for iter_36_0 = 0, var_36_2 - 1 do
					local var_36_3 = var_36_0:GetChild(iter_36_0)

					if var_36_3.name == "split_5" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_4 then
				local var_36_5 = (arg_33_1.time_ - var_36_1) / var_36_4
				local var_36_6 = Vector3.New(0, -400, 0)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10060, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_36_7 = arg_33_1.actors_["10060"]
			local var_36_8 = 0

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps10060 == nil then
				arg_33_1.var_.actorSpriteComps10060 = var_36_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_9 = 0.034

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 and not isNil(var_36_7) then
				local var_36_10 = (arg_33_1.time_ - var_36_8) / var_36_9

				if arg_33_1.var_.actorSpriteComps10060 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								local var_36_11 = Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor1.r, var_36_10)
								local var_36_12 = Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor1.g, var_36_10)
								local var_36_13 = Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor1.b, var_36_10)

								iter_36_2.color = Color.New(var_36_11, var_36_12, var_36_13)
							else
								local var_36_14 = Mathf.Lerp(iter_36_2.color.r, 1, var_36_10)

								iter_36_2.color = Color.New(var_36_14, var_36_14, var_36_14)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps10060 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_36_4 then
						if arg_33_1.isInRecall_ then
							iter_36_4.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10060 = nil
			end

			local var_36_15 = 0
			local var_36_16 = 0.25

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[597].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(410241008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 10
				local var_36_21 = utf8.len(var_36_19)
				local var_36_22 = var_36_20 <= 0 and var_36_16 or var_36_16 * (var_36_21 / var_36_20)

				if var_36_22 > 0 and var_36_16 < var_36_22 then
					arg_33_1.talkMaxDuration = var_36_22

					if var_36_22 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_15
					end
				end

				arg_33_1.text_.text = var_36_19
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241008", "story_v_out_410241.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241008", "story_v_out_410241.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_410241", "410241008", "story_v_out_410241.awb")

						arg_33_1:RecordAudio("410241008", var_36_24)
						arg_33_1:RecordAudio("410241008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410241", "410241008", "story_v_out_410241.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410241", "410241008", "story_v_out_410241.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_25 = math.max(var_36_16, arg_33_1.talkMaxDuration)

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_25 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_15) / var_36_25

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_15 + var_36_25 and arg_33_1.time_ < var_36_15 + var_36_25 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play410241009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410241009
		arg_37_1.duration_ = 3.53

		local var_37_0 = {
			ja = 2.933,
			CriLanguages = 3.533,
			zh = 3.533
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
				arg_37_0:Play410241010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1061"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1061 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1061", 2)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "split_5" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(-390, -490, 18)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1061, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_40_7 = arg_37_1.actors_["10060"].transform
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.var_.moveOldPos10060 = var_40_7.localPosition
				var_40_7.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10060", 4)

				local var_40_9 = var_40_7.childCount

				for iter_40_1 = 0, var_40_9 - 1 do
					local var_40_10 = var_40_7:GetChild(iter_40_1)

					if var_40_10.name == "" or not string.find(var_40_10.name, "split") then
						var_40_10.gameObject:SetActive(true)
					else
						var_40_10.gameObject:SetActive(false)
					end
				end
			end

			local var_40_11 = 0.001

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_11 then
				local var_40_12 = (arg_37_1.time_ - var_40_8) / var_40_11
				local var_40_13 = Vector3.New(390, -400, 0)

				var_40_7.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10060, var_40_13, var_40_12)
			end

			if arg_37_1.time_ >= var_40_8 + var_40_11 and arg_37_1.time_ < var_40_8 + var_40_11 + arg_40_0 then
				var_40_7.localPosition = Vector3.New(390, -400, 0)
			end

			local var_40_14 = arg_37_1.actors_["1061"]
			local var_40_15 = 0

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.actorSpriteComps1061 == nil then
				arg_37_1.var_.actorSpriteComps1061 = var_40_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_16 = 0.034

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_16 and not isNil(var_40_14) then
				local var_40_17 = (arg_37_1.time_ - var_40_15) / var_40_16

				if arg_37_1.var_.actorSpriteComps1061 then
					for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_40_3 then
							if arg_37_1.isInRecall_ then
								local var_40_18 = Mathf.Lerp(iter_40_3.color.r, arg_37_1.hightColor1.r, var_40_17)
								local var_40_19 = Mathf.Lerp(iter_40_3.color.g, arg_37_1.hightColor1.g, var_40_17)
								local var_40_20 = Mathf.Lerp(iter_40_3.color.b, arg_37_1.hightColor1.b, var_40_17)

								iter_40_3.color = Color.New(var_40_18, var_40_19, var_40_20)
							else
								local var_40_21 = Mathf.Lerp(iter_40_3.color.r, 1, var_40_17)

								iter_40_3.color = Color.New(var_40_21, var_40_21, var_40_21)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_15 + var_40_16 and arg_37_1.time_ < var_40_15 + var_40_16 + arg_40_0 and not isNil(var_40_14) and arg_37_1.var_.actorSpriteComps1061 then
				for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_40_5 then
						if arg_37_1.isInRecall_ then
							iter_40_5.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1061 = nil
			end

			local var_40_22 = arg_37_1.actors_["10060"]
			local var_40_23 = 0

			if var_40_23 < arg_37_1.time_ and arg_37_1.time_ <= var_40_23 + arg_40_0 and not isNil(var_40_22) and arg_37_1.var_.actorSpriteComps10060 == nil then
				arg_37_1.var_.actorSpriteComps10060 = var_40_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_24 = 0.034

			if var_40_23 <= arg_37_1.time_ and arg_37_1.time_ < var_40_23 + var_40_24 and not isNil(var_40_22) then
				local var_40_25 = (arg_37_1.time_ - var_40_23) / var_40_24

				if arg_37_1.var_.actorSpriteComps10060 then
					for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_40_7 then
							if arg_37_1.isInRecall_ then
								local var_40_26 = Mathf.Lerp(iter_40_7.color.r, arg_37_1.hightColor2.r, var_40_25)
								local var_40_27 = Mathf.Lerp(iter_40_7.color.g, arg_37_1.hightColor2.g, var_40_25)
								local var_40_28 = Mathf.Lerp(iter_40_7.color.b, arg_37_1.hightColor2.b, var_40_25)

								iter_40_7.color = Color.New(var_40_26, var_40_27, var_40_28)
							else
								local var_40_29 = Mathf.Lerp(iter_40_7.color.r, 0.5, var_40_25)

								iter_40_7.color = Color.New(var_40_29, var_40_29, var_40_29)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_23 + var_40_24 and arg_37_1.time_ < var_40_23 + var_40_24 + arg_40_0 and not isNil(var_40_22) and arg_37_1.var_.actorSpriteComps10060 then
				for iter_40_8, iter_40_9 in pairs(arg_37_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_40_9 then
						if arg_37_1.isInRecall_ then
							iter_40_9.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10060 = nil
			end

			local var_40_30 = 0
			local var_40_31 = 0.2

			if var_40_30 < arg_37_1.time_ and arg_37_1.time_ <= var_40_30 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_32 = arg_37_1:FormatText(StoryNameCfg[612].name)

				arg_37_1.leftNameTxt_.text = var_40_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_33 = arg_37_1:GetWordFromCfg(410241009)
				local var_40_34 = arg_37_1:FormatText(var_40_33.content)

				arg_37_1.text_.text = var_40_34

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_35 = 8
				local var_40_36 = utf8.len(var_40_34)
				local var_40_37 = var_40_35 <= 0 and var_40_31 or var_40_31 * (var_40_36 / var_40_35)

				if var_40_37 > 0 and var_40_31 < var_40_37 then
					arg_37_1.talkMaxDuration = var_40_37

					if var_40_37 + var_40_30 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_37 + var_40_30
					end
				end

				arg_37_1.text_.text = var_40_34
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241009", "story_v_out_410241.awb") ~= 0 then
					local var_40_38 = manager.audio:GetVoiceLength("story_v_out_410241", "410241009", "story_v_out_410241.awb") / 1000

					if var_40_38 + var_40_30 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_38 + var_40_30
					end

					if var_40_33.prefab_name ~= "" and arg_37_1.actors_[var_40_33.prefab_name] ~= nil then
						local var_40_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_33.prefab_name].transform, "story_v_out_410241", "410241009", "story_v_out_410241.awb")

						arg_37_1:RecordAudio("410241009", var_40_39)
						arg_37_1:RecordAudio("410241009", var_40_39)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_410241", "410241009", "story_v_out_410241.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_410241", "410241009", "story_v_out_410241.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_40 = math.max(var_40_31, arg_37_1.talkMaxDuration)

			if var_40_30 <= arg_37_1.time_ and arg_37_1.time_ < var_40_30 + var_40_40 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_30) / var_40_40

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_30 + var_40_40 and arg_37_1.time_ < var_40_30 + var_40_40 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
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
	Play410241010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410241010
		arg_41_1.duration_ = 7.9

		local var_41_0 = {
			ja = 7.9,
			CriLanguages = 6.366,
			zh = 6.366
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
				arg_41_0:Play410241011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10060"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10060 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10060", 4)

				local var_44_2 = var_44_0.childCount

				for iter_44_0 = 0, var_44_2 - 1 do
					local var_44_3 = var_44_0:GetChild(iter_44_0)

					if var_44_3.name == "" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_4 then
				local var_44_5 = (arg_41_1.time_ - var_44_1) / var_44_4
				local var_44_6 = Vector3.New(390, -400, 0)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10060, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_44_7 = arg_41_1.actors_["10060"]
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps10060 == nil then
				arg_41_1.var_.actorSpriteComps10060 = var_44_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 0.034

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_9 and not isNil(var_44_7) then
				local var_44_10 = (arg_41_1.time_ - var_44_8) / var_44_9

				if arg_41_1.var_.actorSpriteComps10060 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								local var_44_11 = Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor1.r, var_44_10)
								local var_44_12 = Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor1.g, var_44_10)
								local var_44_13 = Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor1.b, var_44_10)

								iter_44_2.color = Color.New(var_44_11, var_44_12, var_44_13)
							else
								local var_44_14 = Mathf.Lerp(iter_44_2.color.r, 1, var_44_10)

								iter_44_2.color = Color.New(var_44_14, var_44_14, var_44_14)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_8 + var_44_9 and arg_41_1.time_ < var_44_8 + var_44_9 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps10060 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_44_4 then
						if arg_41_1.isInRecall_ then
							iter_44_4.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10060 = nil
			end

			local var_44_15 = arg_41_1.actors_["1061"]
			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.actorSpriteComps1061 == nil then
				arg_41_1.var_.actorSpriteComps1061 = var_44_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_17 = 0.034

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_17 and not isNil(var_44_15) then
				local var_44_18 = (arg_41_1.time_ - var_44_16) / var_44_17

				if arg_41_1.var_.actorSpriteComps1061 then
					for iter_44_5, iter_44_6 in pairs(arg_41_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_44_6 then
							if arg_41_1.isInRecall_ then
								local var_44_19 = Mathf.Lerp(iter_44_6.color.r, arg_41_1.hightColor2.r, var_44_18)
								local var_44_20 = Mathf.Lerp(iter_44_6.color.g, arg_41_1.hightColor2.g, var_44_18)
								local var_44_21 = Mathf.Lerp(iter_44_6.color.b, arg_41_1.hightColor2.b, var_44_18)

								iter_44_6.color = Color.New(var_44_19, var_44_20, var_44_21)
							else
								local var_44_22 = Mathf.Lerp(iter_44_6.color.r, 0.5, var_44_18)

								iter_44_6.color = Color.New(var_44_22, var_44_22, var_44_22)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.actorSpriteComps1061 then
				for iter_44_7, iter_44_8 in pairs(arg_41_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_44_8 then
						if arg_41_1.isInRecall_ then
							iter_44_8.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1061 = nil
			end

			local var_44_23 = 0
			local var_44_24 = 0.3

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_25 = arg_41_1:FormatText(StoryNameCfg[597].name)

				arg_41_1.leftNameTxt_.text = var_44_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_26 = arg_41_1:GetWordFromCfg(410241010)
				local var_44_27 = arg_41_1:FormatText(var_44_26.content)

				arg_41_1.text_.text = var_44_27

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_28 = 12
				local var_44_29 = utf8.len(var_44_27)
				local var_44_30 = var_44_28 <= 0 and var_44_24 or var_44_24 * (var_44_29 / var_44_28)

				if var_44_30 > 0 and var_44_24 < var_44_30 then
					arg_41_1.talkMaxDuration = var_44_30

					if var_44_30 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_30 + var_44_23
					end
				end

				arg_41_1.text_.text = var_44_27
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241010", "story_v_out_410241.awb") ~= 0 then
					local var_44_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241010", "story_v_out_410241.awb") / 1000

					if var_44_31 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_31 + var_44_23
					end

					if var_44_26.prefab_name ~= "" and arg_41_1.actors_[var_44_26.prefab_name] ~= nil then
						local var_44_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_26.prefab_name].transform, "story_v_out_410241", "410241010", "story_v_out_410241.awb")

						arg_41_1:RecordAudio("410241010", var_44_32)
						arg_41_1:RecordAudio("410241010", var_44_32)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410241", "410241010", "story_v_out_410241.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410241", "410241010", "story_v_out_410241.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_33 = math.max(var_44_24, arg_41_1.talkMaxDuration)

			if var_44_23 <= arg_41_1.time_ and arg_41_1.time_ < var_44_23 + var_44_33 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_23) / var_44_33

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_23 + var_44_33 and arg_41_1.time_ < var_44_23 + var_44_33 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play410241011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410241011
		arg_45_1.duration_ = 7.4

		local var_45_0 = {
			ja = 7.4,
			CriLanguages = 6.833,
			zh = 6.833
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
				arg_45_0:Play410241012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1061"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1061 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1061", 2)

				local var_48_2 = var_48_0.childCount

				for iter_48_0 = 0, var_48_2 - 1 do
					local var_48_3 = var_48_0:GetChild(iter_48_0)

					if var_48_3.name == "" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_4 then
				local var_48_5 = (arg_45_1.time_ - var_48_1) / var_48_4
				local var_48_6 = Vector3.New(-390, -490, 18)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1061, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_48_7 = arg_45_1.actors_["10060"]
			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps10060 == nil then
				arg_45_1.var_.actorSpriteComps10060 = var_48_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_9 = 0.034

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_9 and not isNil(var_48_7) then
				local var_48_10 = (arg_45_1.time_ - var_48_8) / var_48_9

				if arg_45_1.var_.actorSpriteComps10060 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_48_2 then
							if arg_45_1.isInRecall_ then
								local var_48_11 = Mathf.Lerp(iter_48_2.color.r, arg_45_1.hightColor2.r, var_48_10)
								local var_48_12 = Mathf.Lerp(iter_48_2.color.g, arg_45_1.hightColor2.g, var_48_10)
								local var_48_13 = Mathf.Lerp(iter_48_2.color.b, arg_45_1.hightColor2.b, var_48_10)

								iter_48_2.color = Color.New(var_48_11, var_48_12, var_48_13)
							else
								local var_48_14 = Mathf.Lerp(iter_48_2.color.r, 0.5, var_48_10)

								iter_48_2.color = Color.New(var_48_14, var_48_14, var_48_14)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_8 + var_48_9 and arg_45_1.time_ < var_48_8 + var_48_9 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps10060 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_48_4 then
						if arg_45_1.isInRecall_ then
							iter_48_4.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10060 = nil
			end

			local var_48_15 = arg_45_1.actors_["1061"]
			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps1061 == nil then
				arg_45_1.var_.actorSpriteComps1061 = var_48_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_17 = 0.034

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_17 and not isNil(var_48_15) then
				local var_48_18 = (arg_45_1.time_ - var_48_16) / var_48_17

				if arg_45_1.var_.actorSpriteComps1061 then
					for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_48_6 then
							if arg_45_1.isInRecall_ then
								local var_48_19 = Mathf.Lerp(iter_48_6.color.r, arg_45_1.hightColor1.r, var_48_18)
								local var_48_20 = Mathf.Lerp(iter_48_6.color.g, arg_45_1.hightColor1.g, var_48_18)
								local var_48_21 = Mathf.Lerp(iter_48_6.color.b, arg_45_1.hightColor1.b, var_48_18)

								iter_48_6.color = Color.New(var_48_19, var_48_20, var_48_21)
							else
								local var_48_22 = Mathf.Lerp(iter_48_6.color.r, 1, var_48_18)

								iter_48_6.color = Color.New(var_48_22, var_48_22, var_48_22)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps1061 then
				for iter_48_7, iter_48_8 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_48_8 then
						if arg_45_1.isInRecall_ then
							iter_48_8.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1061 = nil
			end

			local var_48_23 = 0
			local var_48_24 = 0.575

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_25 = arg_45_1:FormatText(StoryNameCfg[612].name)

				arg_45_1.leftNameTxt_.text = var_48_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_26 = arg_45_1:GetWordFromCfg(410241011)
				local var_48_27 = arg_45_1:FormatText(var_48_26.content)

				arg_45_1.text_.text = var_48_27

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_28 = 23
				local var_48_29 = utf8.len(var_48_27)
				local var_48_30 = var_48_28 <= 0 and var_48_24 or var_48_24 * (var_48_29 / var_48_28)

				if var_48_30 > 0 and var_48_24 < var_48_30 then
					arg_45_1.talkMaxDuration = var_48_30

					if var_48_30 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_30 + var_48_23
					end
				end

				arg_45_1.text_.text = var_48_27
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241011", "story_v_out_410241.awb") ~= 0 then
					local var_48_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241011", "story_v_out_410241.awb") / 1000

					if var_48_31 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_31 + var_48_23
					end

					if var_48_26.prefab_name ~= "" and arg_45_1.actors_[var_48_26.prefab_name] ~= nil then
						local var_48_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_26.prefab_name].transform, "story_v_out_410241", "410241011", "story_v_out_410241.awb")

						arg_45_1:RecordAudio("410241011", var_48_32)
						arg_45_1:RecordAudio("410241011", var_48_32)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410241", "410241011", "story_v_out_410241.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410241", "410241011", "story_v_out_410241.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_33 = math.max(var_48_24, arg_45_1.talkMaxDuration)

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_33 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_23) / var_48_33

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_23 + var_48_33 and arg_45_1.time_ < var_48_23 + var_48_33 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play410241012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410241012
		arg_49_1.duration_ = 3.2

		local var_49_0 = {
			ja = 3.2,
			CriLanguages = 2.1,
			zh = 2.1
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
				arg_49_0:Play410241013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10060"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10060 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10060", 4)

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
				local var_52_6 = Vector3.New(390, -400, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10060, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_52_7 = arg_49_1.actors_["10060"]
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps10060 == nil then
				arg_49_1.var_.actorSpriteComps10060 = var_52_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 0.034

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 and not isNil(var_52_7) then
				local var_52_10 = (arg_49_1.time_ - var_52_8) / var_52_9

				if arg_49_1.var_.actorSpriteComps10060 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								local var_52_11 = Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor1.r, var_52_10)
								local var_52_12 = Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor1.g, var_52_10)
								local var_52_13 = Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor1.b, var_52_10)

								iter_52_2.color = Color.New(var_52_11, var_52_12, var_52_13)
							else
								local var_52_14 = Mathf.Lerp(iter_52_2.color.r, 1, var_52_10)

								iter_52_2.color = Color.New(var_52_14, var_52_14, var_52_14)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps10060 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_52_4 then
						if arg_49_1.isInRecall_ then
							iter_52_4.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10060 = nil
			end

			local var_52_15 = arg_49_1.actors_["1061"]
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.actorSpriteComps1061 == nil then
				arg_49_1.var_.actorSpriteComps1061 = var_52_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_17 = 0.034

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 and not isNil(var_52_15) then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17

				if arg_49_1.var_.actorSpriteComps1061 then
					for iter_52_5, iter_52_6 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_52_6 then
							if arg_49_1.isInRecall_ then
								local var_52_19 = Mathf.Lerp(iter_52_6.color.r, arg_49_1.hightColor2.r, var_52_18)
								local var_52_20 = Mathf.Lerp(iter_52_6.color.g, arg_49_1.hightColor2.g, var_52_18)
								local var_52_21 = Mathf.Lerp(iter_52_6.color.b, arg_49_1.hightColor2.b, var_52_18)

								iter_52_6.color = Color.New(var_52_19, var_52_20, var_52_21)
							else
								local var_52_22 = Mathf.Lerp(iter_52_6.color.r, 0.5, var_52_18)

								iter_52_6.color = Color.New(var_52_22, var_52_22, var_52_22)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.actorSpriteComps1061 then
				for iter_52_7, iter_52_8 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_52_8 then
						if arg_49_1.isInRecall_ then
							iter_52_8.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1061 = nil
			end

			local var_52_23 = 0
			local var_52_24 = 0.175

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_25 = arg_49_1:FormatText(StoryNameCfg[597].name)

				arg_49_1.leftNameTxt_.text = var_52_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_26 = arg_49_1:GetWordFromCfg(410241012)
				local var_52_27 = arg_49_1:FormatText(var_52_26.content)

				arg_49_1.text_.text = var_52_27

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_28 = 7
				local var_52_29 = utf8.len(var_52_27)
				local var_52_30 = var_52_28 <= 0 and var_52_24 or var_52_24 * (var_52_29 / var_52_28)

				if var_52_30 > 0 and var_52_24 < var_52_30 then
					arg_49_1.talkMaxDuration = var_52_30

					if var_52_30 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_30 + var_52_23
					end
				end

				arg_49_1.text_.text = var_52_27
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241012", "story_v_out_410241.awb") ~= 0 then
					local var_52_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241012", "story_v_out_410241.awb") / 1000

					if var_52_31 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_31 + var_52_23
					end

					if var_52_26.prefab_name ~= "" and arg_49_1.actors_[var_52_26.prefab_name] ~= nil then
						local var_52_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_26.prefab_name].transform, "story_v_out_410241", "410241012", "story_v_out_410241.awb")

						arg_49_1:RecordAudio("410241012", var_52_32)
						arg_49_1:RecordAudio("410241012", var_52_32)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410241", "410241012", "story_v_out_410241.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410241", "410241012", "story_v_out_410241.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_33 = math.max(var_52_24, arg_49_1.talkMaxDuration)

			if var_52_23 <= arg_49_1.time_ and arg_49_1.time_ < var_52_23 + var_52_33 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_23) / var_52_33

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_23 + var_52_33 and arg_49_1.time_ < var_52_23 + var_52_33 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
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
	Play410241013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410241013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play410241014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1061"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1061 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1061", 7)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(0, -2000, 18)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1061, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_56_7 = arg_53_1.actors_["10060"].transform
			local var_56_8 = 0

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.var_.moveOldPos10060 = var_56_7.localPosition
				var_56_7.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10060", 7)

				local var_56_9 = var_56_7.childCount

				for iter_56_1 = 0, var_56_9 - 1 do
					local var_56_10 = var_56_7:GetChild(iter_56_1)

					if var_56_10.name == "" or not string.find(var_56_10.name, "split") then
						var_56_10.gameObject:SetActive(true)
					else
						var_56_10.gameObject:SetActive(false)
					end
				end
			end

			local var_56_11 = 0.001

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_11 then
				local var_56_12 = (arg_53_1.time_ - var_56_8) / var_56_11
				local var_56_13 = Vector3.New(0, -2000, 0)

				var_56_7.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10060, var_56_13, var_56_12)
			end

			if arg_53_1.time_ >= var_56_8 + var_56_11 and arg_53_1.time_ < var_56_8 + var_56_11 + arg_56_0 then
				var_56_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_56_14 = arg_53_1.actors_["1061"]
			local var_56_15 = 0

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.actorSpriteComps1061 == nil then
				arg_53_1.var_.actorSpriteComps1061 = var_56_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_16 = 0.034

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_16 and not isNil(var_56_14) then
				local var_56_17 = (arg_53_1.time_ - var_56_15) / var_56_16

				if arg_53_1.var_.actorSpriteComps1061 then
					for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_56_3 then
							if arg_53_1.isInRecall_ then
								local var_56_18 = Mathf.Lerp(iter_56_3.color.r, arg_53_1.hightColor2.r, var_56_17)
								local var_56_19 = Mathf.Lerp(iter_56_3.color.g, arg_53_1.hightColor2.g, var_56_17)
								local var_56_20 = Mathf.Lerp(iter_56_3.color.b, arg_53_1.hightColor2.b, var_56_17)

								iter_56_3.color = Color.New(var_56_18, var_56_19, var_56_20)
							else
								local var_56_21 = Mathf.Lerp(iter_56_3.color.r, 0.5, var_56_17)

								iter_56_3.color = Color.New(var_56_21, var_56_21, var_56_21)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_15 + var_56_16 and arg_53_1.time_ < var_56_15 + var_56_16 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.actorSpriteComps1061 then
				for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_56_5 then
						if arg_53_1.isInRecall_ then
							iter_56_5.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1061 = nil
			end

			local var_56_22 = arg_53_1.actors_["10060"]
			local var_56_23 = 0

			if var_56_23 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 and not isNil(var_56_22) and arg_53_1.var_.actorSpriteComps10060 == nil then
				arg_53_1.var_.actorSpriteComps10060 = var_56_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_24 = 0.034

			if var_56_23 <= arg_53_1.time_ and arg_53_1.time_ < var_56_23 + var_56_24 and not isNil(var_56_22) then
				local var_56_25 = (arg_53_1.time_ - var_56_23) / var_56_24

				if arg_53_1.var_.actorSpriteComps10060 then
					for iter_56_6, iter_56_7 in pairs(arg_53_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_56_7 then
							if arg_53_1.isInRecall_ then
								local var_56_26 = Mathf.Lerp(iter_56_7.color.r, arg_53_1.hightColor2.r, var_56_25)
								local var_56_27 = Mathf.Lerp(iter_56_7.color.g, arg_53_1.hightColor2.g, var_56_25)
								local var_56_28 = Mathf.Lerp(iter_56_7.color.b, arg_53_1.hightColor2.b, var_56_25)

								iter_56_7.color = Color.New(var_56_26, var_56_27, var_56_28)
							else
								local var_56_29 = Mathf.Lerp(iter_56_7.color.r, 0.5, var_56_25)

								iter_56_7.color = Color.New(var_56_29, var_56_29, var_56_29)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_23 + var_56_24 and arg_53_1.time_ < var_56_23 + var_56_24 + arg_56_0 and not isNil(var_56_22) and arg_53_1.var_.actorSpriteComps10060 then
				for iter_56_8, iter_56_9 in pairs(arg_53_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_56_9 then
						if arg_53_1.isInRecall_ then
							iter_56_9.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10060 = nil
			end

			local var_56_30 = 0
			local var_56_31 = 0.8

			if var_56_30 < arg_53_1.time_ and arg_53_1.time_ <= var_56_30 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_32 = arg_53_1:GetWordFromCfg(410241013)
				local var_56_33 = arg_53_1:FormatText(var_56_32.content)

				arg_53_1.text_.text = var_56_33

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_34 = 32
				local var_56_35 = utf8.len(var_56_33)
				local var_56_36 = var_56_34 <= 0 and var_56_31 or var_56_31 * (var_56_35 / var_56_34)

				if var_56_36 > 0 and var_56_31 < var_56_36 then
					arg_53_1.talkMaxDuration = var_56_36

					if var_56_36 + var_56_30 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_36 + var_56_30
					end
				end

				arg_53_1.text_.text = var_56_33
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_37 = math.max(var_56_31, arg_53_1.talkMaxDuration)

			if var_56_30 <= arg_53_1.time_ and arg_53_1.time_ < var_56_30 + var_56_37 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_30) / var_56_37

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_30 + var_56_37 and arg_53_1.time_ < var_56_30 + var_56_37 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
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
	Play410241014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410241014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play410241015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.475

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(410241014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 59
				local var_60_5 = utf8.len(var_60_3)
				local var_60_6 = var_60_4 <= 0 and var_60_1 or var_60_1 * (var_60_5 / var_60_4)

				if var_60_6 > 0 and var_60_1 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_7 and arg_57_1.time_ < var_60_0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play410241015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410241015
		arg_61_1.duration_ = 4.3

		local var_61_0 = {
			ja = 4.3,
			CriLanguages = 2.466,
			zh = 2.466
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
				arg_61_0:Play410241016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1061"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1061 = var_64_0.localPosition
				var_64_0.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1061", 2)

				local var_64_2 = var_64_0.childCount

				for iter_64_0 = 0, var_64_2 - 1 do
					local var_64_3 = var_64_0:GetChild(iter_64_0)

					if var_64_3.name == "" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_4 then
				local var_64_5 = (arg_61_1.time_ - var_64_1) / var_64_4
				local var_64_6 = Vector3.New(-390, -490, 18)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1061, var_64_6, var_64_5)
			end

			if arg_61_1.time_ >= var_64_1 + var_64_4 and arg_61_1.time_ < var_64_1 + var_64_4 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_64_7 = arg_61_1.actors_["10060"].transform
			local var_64_8 = 0

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.var_.moveOldPos10060 = var_64_7.localPosition
				var_64_7.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10060", 4)

				local var_64_9 = var_64_7.childCount

				for iter_64_1 = 0, var_64_9 - 1 do
					local var_64_10 = var_64_7:GetChild(iter_64_1)

					if var_64_10.name == "" or not string.find(var_64_10.name, "split") then
						var_64_10.gameObject:SetActive(true)
					else
						var_64_10.gameObject:SetActive(false)
					end
				end
			end

			local var_64_11 = 0.001

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_11 then
				local var_64_12 = (arg_61_1.time_ - var_64_8) / var_64_11
				local var_64_13 = Vector3.New(390, -400, 0)

				var_64_7.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10060, var_64_13, var_64_12)
			end

			if arg_61_1.time_ >= var_64_8 + var_64_11 and arg_61_1.time_ < var_64_8 + var_64_11 + arg_64_0 then
				var_64_7.localPosition = Vector3.New(390, -400, 0)
			end

			local var_64_14 = arg_61_1.actors_["1061"]
			local var_64_15 = 0

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 and not isNil(var_64_14) and arg_61_1.var_.actorSpriteComps1061 == nil then
				arg_61_1.var_.actorSpriteComps1061 = var_64_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_16 = 0.034

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_16 and not isNil(var_64_14) then
				local var_64_17 = (arg_61_1.time_ - var_64_15) / var_64_16

				if arg_61_1.var_.actorSpriteComps1061 then
					for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_64_3 then
							if arg_61_1.isInRecall_ then
								local var_64_18 = Mathf.Lerp(iter_64_3.color.r, arg_61_1.hightColor1.r, var_64_17)
								local var_64_19 = Mathf.Lerp(iter_64_3.color.g, arg_61_1.hightColor1.g, var_64_17)
								local var_64_20 = Mathf.Lerp(iter_64_3.color.b, arg_61_1.hightColor1.b, var_64_17)

								iter_64_3.color = Color.New(var_64_18, var_64_19, var_64_20)
							else
								local var_64_21 = Mathf.Lerp(iter_64_3.color.r, 1, var_64_17)

								iter_64_3.color = Color.New(var_64_21, var_64_21, var_64_21)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_15 + var_64_16 and arg_61_1.time_ < var_64_15 + var_64_16 + arg_64_0 and not isNil(var_64_14) and arg_61_1.var_.actorSpriteComps1061 then
				for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_64_5 then
						if arg_61_1.isInRecall_ then
							iter_64_5.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1061 = nil
			end

			local var_64_22 = arg_61_1.actors_["10060"]
			local var_64_23 = 0

			if var_64_23 < arg_61_1.time_ and arg_61_1.time_ <= var_64_23 + arg_64_0 and not isNil(var_64_22) and arg_61_1.var_.actorSpriteComps10060 == nil then
				arg_61_1.var_.actorSpriteComps10060 = var_64_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_24 = 0.034

			if var_64_23 <= arg_61_1.time_ and arg_61_1.time_ < var_64_23 + var_64_24 and not isNil(var_64_22) then
				local var_64_25 = (arg_61_1.time_ - var_64_23) / var_64_24

				if arg_61_1.var_.actorSpriteComps10060 then
					for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_64_7 then
							if arg_61_1.isInRecall_ then
								local var_64_26 = Mathf.Lerp(iter_64_7.color.r, arg_61_1.hightColor2.r, var_64_25)
								local var_64_27 = Mathf.Lerp(iter_64_7.color.g, arg_61_1.hightColor2.g, var_64_25)
								local var_64_28 = Mathf.Lerp(iter_64_7.color.b, arg_61_1.hightColor2.b, var_64_25)

								iter_64_7.color = Color.New(var_64_26, var_64_27, var_64_28)
							else
								local var_64_29 = Mathf.Lerp(iter_64_7.color.r, 0.5, var_64_25)

								iter_64_7.color = Color.New(var_64_29, var_64_29, var_64_29)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_23 + var_64_24 and arg_61_1.time_ < var_64_23 + var_64_24 + arg_64_0 and not isNil(var_64_22) and arg_61_1.var_.actorSpriteComps10060 then
				for iter_64_8, iter_64_9 in pairs(arg_61_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_64_9 then
						if arg_61_1.isInRecall_ then
							iter_64_9.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10060 = nil
			end

			local var_64_30 = 0
			local var_64_31 = 0.225

			if var_64_30 < arg_61_1.time_ and arg_61_1.time_ <= var_64_30 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_32 = arg_61_1:FormatText(StoryNameCfg[612].name)

				arg_61_1.leftNameTxt_.text = var_64_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_33 = arg_61_1:GetWordFromCfg(410241015)
				local var_64_34 = arg_61_1:FormatText(var_64_33.content)

				arg_61_1.text_.text = var_64_34

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_35 = 9
				local var_64_36 = utf8.len(var_64_34)
				local var_64_37 = var_64_35 <= 0 and var_64_31 or var_64_31 * (var_64_36 / var_64_35)

				if var_64_37 > 0 and var_64_31 < var_64_37 then
					arg_61_1.talkMaxDuration = var_64_37

					if var_64_37 + var_64_30 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_37 + var_64_30
					end
				end

				arg_61_1.text_.text = var_64_34
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241015", "story_v_out_410241.awb") ~= 0 then
					local var_64_38 = manager.audio:GetVoiceLength("story_v_out_410241", "410241015", "story_v_out_410241.awb") / 1000

					if var_64_38 + var_64_30 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_38 + var_64_30
					end

					if var_64_33.prefab_name ~= "" and arg_61_1.actors_[var_64_33.prefab_name] ~= nil then
						local var_64_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_33.prefab_name].transform, "story_v_out_410241", "410241015", "story_v_out_410241.awb")

						arg_61_1:RecordAudio("410241015", var_64_39)
						arg_61_1:RecordAudio("410241015", var_64_39)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_410241", "410241015", "story_v_out_410241.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_410241", "410241015", "story_v_out_410241.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_40 = math.max(var_64_31, arg_61_1.talkMaxDuration)

			if var_64_30 <= arg_61_1.time_ and arg_61_1.time_ < var_64_30 + var_64_40 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_30) / var_64_40

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_30 + var_64_40 and arg_61_1.time_ < var_64_30 + var_64_40 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play410241016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410241016
		arg_65_1.duration_ = 9.6

		local var_65_0 = {
			ja = 9.6,
			CriLanguages = 7.533,
			zh = 7.533
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
				arg_65_0:Play410241017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10060"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10060 = var_68_0.localPosition
				var_68_0.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10060", 4)

				local var_68_2 = var_68_0.childCount

				for iter_68_0 = 0, var_68_2 - 1 do
					local var_68_3 = var_68_0:GetChild(iter_68_0)

					if var_68_3.name == "" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_4 then
				local var_68_5 = (arg_65_1.time_ - var_68_1) / var_68_4
				local var_68_6 = Vector3.New(390, -400, 0)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10060, var_68_6, var_68_5)
			end

			if arg_65_1.time_ >= var_68_1 + var_68_4 and arg_65_1.time_ < var_68_1 + var_68_4 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_68_7 = arg_65_1.actors_["10060"]
			local var_68_8 = 0

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10060 == nil then
				arg_65_1.var_.actorSpriteComps10060 = var_68_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_9 = 0.034

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_9 and not isNil(var_68_7) then
				local var_68_10 = (arg_65_1.time_ - var_68_8) / var_68_9

				if arg_65_1.var_.actorSpriteComps10060 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_68_2 then
							if arg_65_1.isInRecall_ then
								local var_68_11 = Mathf.Lerp(iter_68_2.color.r, arg_65_1.hightColor1.r, var_68_10)
								local var_68_12 = Mathf.Lerp(iter_68_2.color.g, arg_65_1.hightColor1.g, var_68_10)
								local var_68_13 = Mathf.Lerp(iter_68_2.color.b, arg_65_1.hightColor1.b, var_68_10)

								iter_68_2.color = Color.New(var_68_11, var_68_12, var_68_13)
							else
								local var_68_14 = Mathf.Lerp(iter_68_2.color.r, 1, var_68_10)

								iter_68_2.color = Color.New(var_68_14, var_68_14, var_68_14)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_8 + var_68_9 and arg_65_1.time_ < var_68_8 + var_68_9 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10060 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_68_4 then
						if arg_65_1.isInRecall_ then
							iter_68_4.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10060 = nil
			end

			local var_68_15 = arg_65_1.actors_["1061"]
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.actorSpriteComps1061 == nil then
				arg_65_1.var_.actorSpriteComps1061 = var_68_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_17 = 0.034

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 and not isNil(var_68_15) then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17

				if arg_65_1.var_.actorSpriteComps1061 then
					for iter_68_5, iter_68_6 in pairs(arg_65_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_68_6 then
							if arg_65_1.isInRecall_ then
								local var_68_19 = Mathf.Lerp(iter_68_6.color.r, arg_65_1.hightColor2.r, var_68_18)
								local var_68_20 = Mathf.Lerp(iter_68_6.color.g, arg_65_1.hightColor2.g, var_68_18)
								local var_68_21 = Mathf.Lerp(iter_68_6.color.b, arg_65_1.hightColor2.b, var_68_18)

								iter_68_6.color = Color.New(var_68_19, var_68_20, var_68_21)
							else
								local var_68_22 = Mathf.Lerp(iter_68_6.color.r, 0.5, var_68_18)

								iter_68_6.color = Color.New(var_68_22, var_68_22, var_68_22)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.actorSpriteComps1061 then
				for iter_68_7, iter_68_8 in pairs(arg_65_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_68_8 then
						if arg_65_1.isInRecall_ then
							iter_68_8.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1061 = nil
			end

			local var_68_23 = 0
			local var_68_24 = 0.825

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_25 = arg_65_1:FormatText(StoryNameCfg[597].name)

				arg_65_1.leftNameTxt_.text = var_68_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_26 = arg_65_1:GetWordFromCfg(410241016)
				local var_68_27 = arg_65_1:FormatText(var_68_26.content)

				arg_65_1.text_.text = var_68_27

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_28 = 32
				local var_68_29 = utf8.len(var_68_27)
				local var_68_30 = var_68_28 <= 0 and var_68_24 or var_68_24 * (var_68_29 / var_68_28)

				if var_68_30 > 0 and var_68_24 < var_68_30 then
					arg_65_1.talkMaxDuration = var_68_30

					if var_68_30 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_30 + var_68_23
					end
				end

				arg_65_1.text_.text = var_68_27
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241016", "story_v_out_410241.awb") ~= 0 then
					local var_68_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241016", "story_v_out_410241.awb") / 1000

					if var_68_31 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_31 + var_68_23
					end

					if var_68_26.prefab_name ~= "" and arg_65_1.actors_[var_68_26.prefab_name] ~= nil then
						local var_68_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_26.prefab_name].transform, "story_v_out_410241", "410241016", "story_v_out_410241.awb")

						arg_65_1:RecordAudio("410241016", var_68_32)
						arg_65_1:RecordAudio("410241016", var_68_32)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410241", "410241016", "story_v_out_410241.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410241", "410241016", "story_v_out_410241.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_33 = math.max(var_68_24, arg_65_1.talkMaxDuration)

			if var_68_23 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_33 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_23) / var_68_33

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_23 + var_68_33 and arg_65_1.time_ < var_68_23 + var_68_33 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play410241017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410241017
		arg_69_1.duration_ = 5.13

		local var_69_0 = {
			ja = 5.133,
			CriLanguages = 4.066,
			zh = 4.066
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
				arg_69_0:Play410241018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1061"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1061 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1061", 2)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(-390, -490, 18)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1061, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_72_7 = arg_69_1.actors_["10060"]
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps10060 == nil then
				arg_69_1.var_.actorSpriteComps10060 = var_72_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 0.034

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 and not isNil(var_72_7) then
				local var_72_10 = (arg_69_1.time_ - var_72_8) / var_72_9

				if arg_69_1.var_.actorSpriteComps10060 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								local var_72_11 = Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor2.r, var_72_10)
								local var_72_12 = Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor2.g, var_72_10)
								local var_72_13 = Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor2.b, var_72_10)

								iter_72_2.color = Color.New(var_72_11, var_72_12, var_72_13)
							else
								local var_72_14 = Mathf.Lerp(iter_72_2.color.r, 0.5, var_72_10)

								iter_72_2.color = Color.New(var_72_14, var_72_14, var_72_14)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps10060 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_72_4 then
						if arg_69_1.isInRecall_ then
							iter_72_4.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10060 = nil
			end

			local var_72_15 = arg_69_1.actors_["1061"]
			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.actorSpriteComps1061 == nil then
				arg_69_1.var_.actorSpriteComps1061 = var_72_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_17 = 0.034

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_17 and not isNil(var_72_15) then
				local var_72_18 = (arg_69_1.time_ - var_72_16) / var_72_17

				if arg_69_1.var_.actorSpriteComps1061 then
					for iter_72_5, iter_72_6 in pairs(arg_69_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_72_6 then
							if arg_69_1.isInRecall_ then
								local var_72_19 = Mathf.Lerp(iter_72_6.color.r, arg_69_1.hightColor1.r, var_72_18)
								local var_72_20 = Mathf.Lerp(iter_72_6.color.g, arg_69_1.hightColor1.g, var_72_18)
								local var_72_21 = Mathf.Lerp(iter_72_6.color.b, arg_69_1.hightColor1.b, var_72_18)

								iter_72_6.color = Color.New(var_72_19, var_72_20, var_72_21)
							else
								local var_72_22 = Mathf.Lerp(iter_72_6.color.r, 1, var_72_18)

								iter_72_6.color = Color.New(var_72_22, var_72_22, var_72_22)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.actorSpriteComps1061 then
				for iter_72_7, iter_72_8 in pairs(arg_69_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_72_8 then
						if arg_69_1.isInRecall_ then
							iter_72_8.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1061 = nil
			end

			local var_72_23 = 0
			local var_72_24 = 0.375

			if var_72_23 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_25 = arg_69_1:FormatText(StoryNameCfg[612].name)

				arg_69_1.leftNameTxt_.text = var_72_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_26 = arg_69_1:GetWordFromCfg(410241017)
				local var_72_27 = arg_69_1:FormatText(var_72_26.content)

				arg_69_1.text_.text = var_72_27

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_28 = 15
				local var_72_29 = utf8.len(var_72_27)
				local var_72_30 = var_72_28 <= 0 and var_72_24 or var_72_24 * (var_72_29 / var_72_28)

				if var_72_30 > 0 and var_72_24 < var_72_30 then
					arg_69_1.talkMaxDuration = var_72_30

					if var_72_30 + var_72_23 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_30 + var_72_23
					end
				end

				arg_69_1.text_.text = var_72_27
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241017", "story_v_out_410241.awb") ~= 0 then
					local var_72_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241017", "story_v_out_410241.awb") / 1000

					if var_72_31 + var_72_23 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_31 + var_72_23
					end

					if var_72_26.prefab_name ~= "" and arg_69_1.actors_[var_72_26.prefab_name] ~= nil then
						local var_72_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_26.prefab_name].transform, "story_v_out_410241", "410241017", "story_v_out_410241.awb")

						arg_69_1:RecordAudio("410241017", var_72_32)
						arg_69_1:RecordAudio("410241017", var_72_32)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_410241", "410241017", "story_v_out_410241.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_410241", "410241017", "story_v_out_410241.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_33 = math.max(var_72_24, arg_69_1.talkMaxDuration)

			if var_72_23 <= arg_69_1.time_ and arg_69_1.time_ < var_72_23 + var_72_33 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_23) / var_72_33

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_23 + var_72_33 and arg_69_1.time_ < var_72_23 + var_72_33 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410241018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410241018
		arg_73_1.duration_ = 19.7

		local var_73_0 = {
			ja = 19.7,
			CriLanguages = 11.666,
			zh = 11.666
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
				arg_73_0:Play410241019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 1.125

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[612].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(410241018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 45
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241018", "story_v_out_410241.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_410241", "410241018", "story_v_out_410241.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_410241", "410241018", "story_v_out_410241.awb")

						arg_73_1:RecordAudio("410241018", var_76_9)
						arg_73_1:RecordAudio("410241018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410241", "410241018", "story_v_out_410241.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410241", "410241018", "story_v_out_410241.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play410241019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410241019
		arg_77_1.duration_ = 5.23

		local var_77_0 = {
			ja = 5.233,
			CriLanguages = 3.433,
			zh = 3.433
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
				arg_77_0:Play410241020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10060"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10060 = var_80_0.localPosition
				var_80_0.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10060", 4)

				local var_80_2 = var_80_0.childCount

				for iter_80_0 = 0, var_80_2 - 1 do
					local var_80_3 = var_80_0:GetChild(iter_80_0)

					if var_80_3.name == "split_3" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_4 then
				local var_80_5 = (arg_77_1.time_ - var_80_1) / var_80_4
				local var_80_6 = Vector3.New(390, -400, 0)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10060, var_80_6, var_80_5)
			end

			if arg_77_1.time_ >= var_80_1 + var_80_4 and arg_77_1.time_ < var_80_1 + var_80_4 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_80_7 = arg_77_1.actors_["10060"]
			local var_80_8 = 0

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10060 == nil then
				arg_77_1.var_.actorSpriteComps10060 = var_80_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_9 = 0.034

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_9 and not isNil(var_80_7) then
				local var_80_10 = (arg_77_1.time_ - var_80_8) / var_80_9

				if arg_77_1.var_.actorSpriteComps10060 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								local var_80_11 = Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor1.r, var_80_10)
								local var_80_12 = Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor1.g, var_80_10)
								local var_80_13 = Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor1.b, var_80_10)

								iter_80_2.color = Color.New(var_80_11, var_80_12, var_80_13)
							else
								local var_80_14 = Mathf.Lerp(iter_80_2.color.r, 1, var_80_10)

								iter_80_2.color = Color.New(var_80_14, var_80_14, var_80_14)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_8 + var_80_9 and arg_77_1.time_ < var_80_8 + var_80_9 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10060 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_80_4 then
						if arg_77_1.isInRecall_ then
							iter_80_4.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10060 = nil
			end

			local var_80_15 = arg_77_1.actors_["1061"]
			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.actorSpriteComps1061 == nil then
				arg_77_1.var_.actorSpriteComps1061 = var_80_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_17 = 0.034

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 and not isNil(var_80_15) then
				local var_80_18 = (arg_77_1.time_ - var_80_16) / var_80_17

				if arg_77_1.var_.actorSpriteComps1061 then
					for iter_80_5, iter_80_6 in pairs(arg_77_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_80_6 then
							if arg_77_1.isInRecall_ then
								local var_80_19 = Mathf.Lerp(iter_80_6.color.r, arg_77_1.hightColor2.r, var_80_18)
								local var_80_20 = Mathf.Lerp(iter_80_6.color.g, arg_77_1.hightColor2.g, var_80_18)
								local var_80_21 = Mathf.Lerp(iter_80_6.color.b, arg_77_1.hightColor2.b, var_80_18)

								iter_80_6.color = Color.New(var_80_19, var_80_20, var_80_21)
							else
								local var_80_22 = Mathf.Lerp(iter_80_6.color.r, 0.5, var_80_18)

								iter_80_6.color = Color.New(var_80_22, var_80_22, var_80_22)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.actorSpriteComps1061 then
				for iter_80_7, iter_80_8 in pairs(arg_77_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_80_8 then
						if arg_77_1.isInRecall_ then
							iter_80_8.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1061 = nil
			end

			local var_80_23 = 0
			local var_80_24 = 0.4

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_25 = arg_77_1:FormatText(StoryNameCfg[597].name)

				arg_77_1.leftNameTxt_.text = var_80_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_26 = arg_77_1:GetWordFromCfg(410241019)
				local var_80_27 = arg_77_1:FormatText(var_80_26.content)

				arg_77_1.text_.text = var_80_27

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_28 = 16
				local var_80_29 = utf8.len(var_80_27)
				local var_80_30 = var_80_28 <= 0 and var_80_24 or var_80_24 * (var_80_29 / var_80_28)

				if var_80_30 > 0 and var_80_24 < var_80_30 then
					arg_77_1.talkMaxDuration = var_80_30

					if var_80_30 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_30 + var_80_23
					end
				end

				arg_77_1.text_.text = var_80_27
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241019", "story_v_out_410241.awb") ~= 0 then
					local var_80_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241019", "story_v_out_410241.awb") / 1000

					if var_80_31 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_31 + var_80_23
					end

					if var_80_26.prefab_name ~= "" and arg_77_1.actors_[var_80_26.prefab_name] ~= nil then
						local var_80_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_26.prefab_name].transform, "story_v_out_410241", "410241019", "story_v_out_410241.awb")

						arg_77_1:RecordAudio("410241019", var_80_32)
						arg_77_1:RecordAudio("410241019", var_80_32)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410241", "410241019", "story_v_out_410241.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410241", "410241019", "story_v_out_410241.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_33 = math.max(var_80_24, arg_77_1.talkMaxDuration)

			if var_80_23 <= arg_77_1.time_ and arg_77_1.time_ < var_80_23 + var_80_33 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_23) / var_80_33

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_23 + var_80_33 and arg_77_1.time_ < var_80_23 + var_80_33 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play410241020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 410241020
		arg_81_1.duration_ = 11.33

		local var_81_0 = {
			ja = 11.333,
			CriLanguages = 8.466,
			zh = 8.466
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
				arg_81_0:Play410241021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.975

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[597].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(410241020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241020", "story_v_out_410241.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_410241", "410241020", "story_v_out_410241.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_410241", "410241020", "story_v_out_410241.awb")

						arg_81_1:RecordAudio("410241020", var_84_9)
						arg_81_1:RecordAudio("410241020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_410241", "410241020", "story_v_out_410241.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_410241", "410241020", "story_v_out_410241.awb")
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
	Play410241021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 410241021
		arg_85_1.duration_ = 8.13

		local var_85_0 = {
			ja = 8.133,
			CriLanguages = 4.5,
			zh = 4.5
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
				arg_85_0:Play410241022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1061"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1061 = var_88_0.localPosition
				var_88_0.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1061", 2)

				local var_88_2 = var_88_0.childCount

				for iter_88_0 = 0, var_88_2 - 1 do
					local var_88_3 = var_88_0:GetChild(iter_88_0)

					if var_88_3.name == "" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_4 then
				local var_88_5 = (arg_85_1.time_ - var_88_1) / var_88_4
				local var_88_6 = Vector3.New(-390, -490, 18)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1061, var_88_6, var_88_5)
			end

			if arg_85_1.time_ >= var_88_1 + var_88_4 and arg_85_1.time_ < var_88_1 + var_88_4 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_88_7 = arg_85_1.actors_["10060"]
			local var_88_8 = 0

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps10060 == nil then
				arg_85_1.var_.actorSpriteComps10060 = var_88_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_9 = 0.034

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_9 and not isNil(var_88_7) then
				local var_88_10 = (arg_85_1.time_ - var_88_8) / var_88_9

				if arg_85_1.var_.actorSpriteComps10060 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_88_2 then
							if arg_85_1.isInRecall_ then
								local var_88_11 = Mathf.Lerp(iter_88_2.color.r, arg_85_1.hightColor2.r, var_88_10)
								local var_88_12 = Mathf.Lerp(iter_88_2.color.g, arg_85_1.hightColor2.g, var_88_10)
								local var_88_13 = Mathf.Lerp(iter_88_2.color.b, arg_85_1.hightColor2.b, var_88_10)

								iter_88_2.color = Color.New(var_88_11, var_88_12, var_88_13)
							else
								local var_88_14 = Mathf.Lerp(iter_88_2.color.r, 0.5, var_88_10)

								iter_88_2.color = Color.New(var_88_14, var_88_14, var_88_14)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_8 + var_88_9 and arg_85_1.time_ < var_88_8 + var_88_9 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps10060 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_88_4 then
						if arg_85_1.isInRecall_ then
							iter_88_4.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10060 = nil
			end

			local var_88_15 = arg_85_1.actors_["1061"]
			local var_88_16 = 0

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.actorSpriteComps1061 == nil then
				arg_85_1.var_.actorSpriteComps1061 = var_88_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_17 = 0.034

			if var_88_16 <= arg_85_1.time_ and arg_85_1.time_ < var_88_16 + var_88_17 and not isNil(var_88_15) then
				local var_88_18 = (arg_85_1.time_ - var_88_16) / var_88_17

				if arg_85_1.var_.actorSpriteComps1061 then
					for iter_88_5, iter_88_6 in pairs(arg_85_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_88_6 then
							if arg_85_1.isInRecall_ then
								local var_88_19 = Mathf.Lerp(iter_88_6.color.r, arg_85_1.hightColor1.r, var_88_18)
								local var_88_20 = Mathf.Lerp(iter_88_6.color.g, arg_85_1.hightColor1.g, var_88_18)
								local var_88_21 = Mathf.Lerp(iter_88_6.color.b, arg_85_1.hightColor1.b, var_88_18)

								iter_88_6.color = Color.New(var_88_19, var_88_20, var_88_21)
							else
								local var_88_22 = Mathf.Lerp(iter_88_6.color.r, 1, var_88_18)

								iter_88_6.color = Color.New(var_88_22, var_88_22, var_88_22)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_16 + var_88_17 and arg_85_1.time_ < var_88_16 + var_88_17 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.actorSpriteComps1061 then
				for iter_88_7, iter_88_8 in pairs(arg_85_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_88_8 then
						if arg_85_1.isInRecall_ then
							iter_88_8.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1061 = nil
			end

			local var_88_23 = 0
			local var_88_24 = 0.525

			if var_88_23 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_25 = arg_85_1:FormatText(StoryNameCfg[612].name)

				arg_85_1.leftNameTxt_.text = var_88_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_26 = arg_85_1:GetWordFromCfg(410241021)
				local var_88_27 = arg_85_1:FormatText(var_88_26.content)

				arg_85_1.text_.text = var_88_27

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_28 = 21
				local var_88_29 = utf8.len(var_88_27)
				local var_88_30 = var_88_28 <= 0 and var_88_24 or var_88_24 * (var_88_29 / var_88_28)

				if var_88_30 > 0 and var_88_24 < var_88_30 then
					arg_85_1.talkMaxDuration = var_88_30

					if var_88_30 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_30 + var_88_23
					end
				end

				arg_85_1.text_.text = var_88_27
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241021", "story_v_out_410241.awb") ~= 0 then
					local var_88_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241021", "story_v_out_410241.awb") / 1000

					if var_88_31 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_31 + var_88_23
					end

					if var_88_26.prefab_name ~= "" and arg_85_1.actors_[var_88_26.prefab_name] ~= nil then
						local var_88_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_26.prefab_name].transform, "story_v_out_410241", "410241021", "story_v_out_410241.awb")

						arg_85_1:RecordAudio("410241021", var_88_32)
						arg_85_1:RecordAudio("410241021", var_88_32)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_410241", "410241021", "story_v_out_410241.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_410241", "410241021", "story_v_out_410241.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_33 = math.max(var_88_24, arg_85_1.talkMaxDuration)

			if var_88_23 <= arg_85_1.time_ and arg_85_1.time_ < var_88_23 + var_88_33 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_23) / var_88_33

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_23 + var_88_33 and arg_85_1.time_ < var_88_23 + var_88_33 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410241022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410241022
		arg_89_1.duration_ = 11.8

		local var_89_0 = {
			ja = 11.8,
			CriLanguages = 10.733,
			zh = 10.733
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
				arg_89_0:Play410241023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10060"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10060 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10060", 4)

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
				local var_92_6 = Vector3.New(390, -400, 0)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10060, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_92_7 = arg_89_1.actors_["10060"]
			local var_92_8 = 0

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps10060 == nil then
				arg_89_1.var_.actorSpriteComps10060 = var_92_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_9 = 0.034

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_9 and not isNil(var_92_7) then
				local var_92_10 = (arg_89_1.time_ - var_92_8) / var_92_9

				if arg_89_1.var_.actorSpriteComps10060 then
					for iter_92_1, iter_92_2 in pairs(arg_89_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_92_2 then
							if arg_89_1.isInRecall_ then
								local var_92_11 = Mathf.Lerp(iter_92_2.color.r, arg_89_1.hightColor1.r, var_92_10)
								local var_92_12 = Mathf.Lerp(iter_92_2.color.g, arg_89_1.hightColor1.g, var_92_10)
								local var_92_13 = Mathf.Lerp(iter_92_2.color.b, arg_89_1.hightColor1.b, var_92_10)

								iter_92_2.color = Color.New(var_92_11, var_92_12, var_92_13)
							else
								local var_92_14 = Mathf.Lerp(iter_92_2.color.r, 1, var_92_10)

								iter_92_2.color = Color.New(var_92_14, var_92_14, var_92_14)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_8 + var_92_9 and arg_89_1.time_ < var_92_8 + var_92_9 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps10060 then
				for iter_92_3, iter_92_4 in pairs(arg_89_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_92_4 then
						if arg_89_1.isInRecall_ then
							iter_92_4.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10060 = nil
			end

			local var_92_15 = arg_89_1.actors_["1061"]
			local var_92_16 = 0

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.actorSpriteComps1061 == nil then
				arg_89_1.var_.actorSpriteComps1061 = var_92_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_17 = 0.034

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_17 and not isNil(var_92_15) then
				local var_92_18 = (arg_89_1.time_ - var_92_16) / var_92_17

				if arg_89_1.var_.actorSpriteComps1061 then
					for iter_92_5, iter_92_6 in pairs(arg_89_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_92_6 then
							if arg_89_1.isInRecall_ then
								local var_92_19 = Mathf.Lerp(iter_92_6.color.r, arg_89_1.hightColor2.r, var_92_18)
								local var_92_20 = Mathf.Lerp(iter_92_6.color.g, arg_89_1.hightColor2.g, var_92_18)
								local var_92_21 = Mathf.Lerp(iter_92_6.color.b, arg_89_1.hightColor2.b, var_92_18)

								iter_92_6.color = Color.New(var_92_19, var_92_20, var_92_21)
							else
								local var_92_22 = Mathf.Lerp(iter_92_6.color.r, 0.5, var_92_18)

								iter_92_6.color = Color.New(var_92_22, var_92_22, var_92_22)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.actorSpriteComps1061 then
				for iter_92_7, iter_92_8 in pairs(arg_89_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_92_8 then
						if arg_89_1.isInRecall_ then
							iter_92_8.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps1061 = nil
			end

			local var_92_23 = 0
			local var_92_24 = 1.175

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_25 = arg_89_1:FormatText(StoryNameCfg[597].name)

				arg_89_1.leftNameTxt_.text = var_92_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_26 = arg_89_1:GetWordFromCfg(410241022)
				local var_92_27 = arg_89_1:FormatText(var_92_26.content)

				arg_89_1.text_.text = var_92_27

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_28 = 47
				local var_92_29 = utf8.len(var_92_27)
				local var_92_30 = var_92_28 <= 0 and var_92_24 or var_92_24 * (var_92_29 / var_92_28)

				if var_92_30 > 0 and var_92_24 < var_92_30 then
					arg_89_1.talkMaxDuration = var_92_30

					if var_92_30 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_30 + var_92_23
					end
				end

				arg_89_1.text_.text = var_92_27
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241022", "story_v_out_410241.awb") ~= 0 then
					local var_92_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241022", "story_v_out_410241.awb") / 1000

					if var_92_31 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_31 + var_92_23
					end

					if var_92_26.prefab_name ~= "" and arg_89_1.actors_[var_92_26.prefab_name] ~= nil then
						local var_92_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_26.prefab_name].transform, "story_v_out_410241", "410241022", "story_v_out_410241.awb")

						arg_89_1:RecordAudio("410241022", var_92_32)
						arg_89_1:RecordAudio("410241022", var_92_32)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_410241", "410241022", "story_v_out_410241.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_410241", "410241022", "story_v_out_410241.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_33 = math.max(var_92_24, arg_89_1.talkMaxDuration)

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_33 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_23) / var_92_33

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_23 + var_92_33 and arg_89_1.time_ < var_92_23 + var_92_33 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
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
	Play410241023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410241023
		arg_93_1.duration_ = 7.37

		local var_93_0 = {
			ja = 7.366,
			CriLanguages = 4.8,
			zh = 4.8
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
				arg_93_0:Play410241024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1061"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1061 = var_96_0.localPosition
				var_96_0.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1061", 2)

				local var_96_2 = var_96_0.childCount

				for iter_96_0 = 0, var_96_2 - 1 do
					local var_96_3 = var_96_0:GetChild(iter_96_0)

					if var_96_3.name == "" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_4 then
				local var_96_5 = (arg_93_1.time_ - var_96_1) / var_96_4
				local var_96_6 = Vector3.New(-390, -490, 18)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1061, var_96_6, var_96_5)
			end

			if arg_93_1.time_ >= var_96_1 + var_96_4 and arg_93_1.time_ < var_96_1 + var_96_4 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_96_7 = arg_93_1.actors_["10060"]
			local var_96_8 = 0

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps10060 == nil then
				arg_93_1.var_.actorSpriteComps10060 = var_96_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 0.034

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_9 and not isNil(var_96_7) then
				local var_96_10 = (arg_93_1.time_ - var_96_8) / var_96_9

				if arg_93_1.var_.actorSpriteComps10060 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_96_2 then
							if arg_93_1.isInRecall_ then
								local var_96_11 = Mathf.Lerp(iter_96_2.color.r, arg_93_1.hightColor2.r, var_96_10)
								local var_96_12 = Mathf.Lerp(iter_96_2.color.g, arg_93_1.hightColor2.g, var_96_10)
								local var_96_13 = Mathf.Lerp(iter_96_2.color.b, arg_93_1.hightColor2.b, var_96_10)

								iter_96_2.color = Color.New(var_96_11, var_96_12, var_96_13)
							else
								local var_96_14 = Mathf.Lerp(iter_96_2.color.r, 0.5, var_96_10)

								iter_96_2.color = Color.New(var_96_14, var_96_14, var_96_14)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_8 + var_96_9 and arg_93_1.time_ < var_96_8 + var_96_9 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps10060 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_96_4 then
						if arg_93_1.isInRecall_ then
							iter_96_4.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10060 = nil
			end

			local var_96_15 = arg_93_1.actors_["1061"]
			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 and not isNil(var_96_15) and arg_93_1.var_.actorSpriteComps1061 == nil then
				arg_93_1.var_.actorSpriteComps1061 = var_96_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_17 = 0.034

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_17 and not isNil(var_96_15) then
				local var_96_18 = (arg_93_1.time_ - var_96_16) / var_96_17

				if arg_93_1.var_.actorSpriteComps1061 then
					for iter_96_5, iter_96_6 in pairs(arg_93_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_96_6 then
							if arg_93_1.isInRecall_ then
								local var_96_19 = Mathf.Lerp(iter_96_6.color.r, arg_93_1.hightColor1.r, var_96_18)
								local var_96_20 = Mathf.Lerp(iter_96_6.color.g, arg_93_1.hightColor1.g, var_96_18)
								local var_96_21 = Mathf.Lerp(iter_96_6.color.b, arg_93_1.hightColor1.b, var_96_18)

								iter_96_6.color = Color.New(var_96_19, var_96_20, var_96_21)
							else
								local var_96_22 = Mathf.Lerp(iter_96_6.color.r, 1, var_96_18)

								iter_96_6.color = Color.New(var_96_22, var_96_22, var_96_22)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_16 + var_96_17 and arg_93_1.time_ < var_96_16 + var_96_17 + arg_96_0 and not isNil(var_96_15) and arg_93_1.var_.actorSpriteComps1061 then
				for iter_96_7, iter_96_8 in pairs(arg_93_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_96_8 then
						if arg_93_1.isInRecall_ then
							iter_96_8.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1061 = nil
			end

			local var_96_23 = 0
			local var_96_24 = 0.525

			if var_96_23 < arg_93_1.time_ and arg_93_1.time_ <= var_96_23 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_25 = arg_93_1:FormatText(StoryNameCfg[612].name)

				arg_93_1.leftNameTxt_.text = var_96_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_26 = arg_93_1:GetWordFromCfg(410241023)
				local var_96_27 = arg_93_1:FormatText(var_96_26.content)

				arg_93_1.text_.text = var_96_27

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_28 = 21
				local var_96_29 = utf8.len(var_96_27)
				local var_96_30 = var_96_28 <= 0 and var_96_24 or var_96_24 * (var_96_29 / var_96_28)

				if var_96_30 > 0 and var_96_24 < var_96_30 then
					arg_93_1.talkMaxDuration = var_96_30

					if var_96_30 + var_96_23 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_30 + var_96_23
					end
				end

				arg_93_1.text_.text = var_96_27
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241023", "story_v_out_410241.awb") ~= 0 then
					local var_96_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241023", "story_v_out_410241.awb") / 1000

					if var_96_31 + var_96_23 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_31 + var_96_23
					end

					if var_96_26.prefab_name ~= "" and arg_93_1.actors_[var_96_26.prefab_name] ~= nil then
						local var_96_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_26.prefab_name].transform, "story_v_out_410241", "410241023", "story_v_out_410241.awb")

						arg_93_1:RecordAudio("410241023", var_96_32)
						arg_93_1:RecordAudio("410241023", var_96_32)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_410241", "410241023", "story_v_out_410241.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_410241", "410241023", "story_v_out_410241.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_33 = math.max(var_96_24, arg_93_1.talkMaxDuration)

			if var_96_23 <= arg_93_1.time_ and arg_93_1.time_ < var_96_23 + var_96_33 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_23) / var_96_33

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_23 + var_96_33 and arg_93_1.time_ < var_96_23 + var_96_33 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play410241024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410241024
		arg_97_1.duration_ = 5.17

		local var_97_0 = {
			ja = 5.166,
			CriLanguages = 2.933,
			zh = 2.933
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
				arg_97_0:Play410241025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10060"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10060 = var_100_0.localPosition
				var_100_0.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10060", 4)

				local var_100_2 = var_100_0.childCount

				for iter_100_0 = 0, var_100_2 - 1 do
					local var_100_3 = var_100_0:GetChild(iter_100_0)

					if var_100_3.name == "" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_4 then
				local var_100_5 = (arg_97_1.time_ - var_100_1) / var_100_4
				local var_100_6 = Vector3.New(390, -400, 0)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10060, var_100_6, var_100_5)
			end

			if arg_97_1.time_ >= var_100_1 + var_100_4 and arg_97_1.time_ < var_100_1 + var_100_4 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_100_7 = arg_97_1.actors_["10060"]
			local var_100_8 = 0

			if var_100_8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.actorSpriteComps10060 == nil then
				arg_97_1.var_.actorSpriteComps10060 = var_100_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_9 = 0.034

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_9 and not isNil(var_100_7) then
				local var_100_10 = (arg_97_1.time_ - var_100_8) / var_100_9

				if arg_97_1.var_.actorSpriteComps10060 then
					for iter_100_1, iter_100_2 in pairs(arg_97_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_100_2 then
							if arg_97_1.isInRecall_ then
								local var_100_11 = Mathf.Lerp(iter_100_2.color.r, arg_97_1.hightColor1.r, var_100_10)
								local var_100_12 = Mathf.Lerp(iter_100_2.color.g, arg_97_1.hightColor1.g, var_100_10)
								local var_100_13 = Mathf.Lerp(iter_100_2.color.b, arg_97_1.hightColor1.b, var_100_10)

								iter_100_2.color = Color.New(var_100_11, var_100_12, var_100_13)
							else
								local var_100_14 = Mathf.Lerp(iter_100_2.color.r, 1, var_100_10)

								iter_100_2.color = Color.New(var_100_14, var_100_14, var_100_14)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_8 + var_100_9 and arg_97_1.time_ < var_100_8 + var_100_9 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.actorSpriteComps10060 then
				for iter_100_3, iter_100_4 in pairs(arg_97_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_100_4 then
						if arg_97_1.isInRecall_ then
							iter_100_4.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10060 = nil
			end

			local var_100_15 = arg_97_1.actors_["1061"]
			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 and not isNil(var_100_15) and arg_97_1.var_.actorSpriteComps1061 == nil then
				arg_97_1.var_.actorSpriteComps1061 = var_100_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_17 = 0.034

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_17 and not isNil(var_100_15) then
				local var_100_18 = (arg_97_1.time_ - var_100_16) / var_100_17

				if arg_97_1.var_.actorSpriteComps1061 then
					for iter_100_5, iter_100_6 in pairs(arg_97_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_100_6 then
							if arg_97_1.isInRecall_ then
								local var_100_19 = Mathf.Lerp(iter_100_6.color.r, arg_97_1.hightColor2.r, var_100_18)
								local var_100_20 = Mathf.Lerp(iter_100_6.color.g, arg_97_1.hightColor2.g, var_100_18)
								local var_100_21 = Mathf.Lerp(iter_100_6.color.b, arg_97_1.hightColor2.b, var_100_18)

								iter_100_6.color = Color.New(var_100_19, var_100_20, var_100_21)
							else
								local var_100_22 = Mathf.Lerp(iter_100_6.color.r, 0.5, var_100_18)

								iter_100_6.color = Color.New(var_100_22, var_100_22, var_100_22)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_16 + var_100_17 and arg_97_1.time_ < var_100_16 + var_100_17 + arg_100_0 and not isNil(var_100_15) and arg_97_1.var_.actorSpriteComps1061 then
				for iter_100_7, iter_100_8 in pairs(arg_97_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_100_8 then
						if arg_97_1.isInRecall_ then
							iter_100_8.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps1061 = nil
			end

			local var_100_23 = 0
			local var_100_24 = 0.125

			if var_100_23 < arg_97_1.time_ and arg_97_1.time_ <= var_100_23 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_25 = arg_97_1:FormatText(StoryNameCfg[597].name)

				arg_97_1.leftNameTxt_.text = var_100_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_26 = arg_97_1:GetWordFromCfg(410241024)
				local var_100_27 = arg_97_1:FormatText(var_100_26.content)

				arg_97_1.text_.text = var_100_27

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_28 = 5
				local var_100_29 = utf8.len(var_100_27)
				local var_100_30 = var_100_28 <= 0 and var_100_24 or var_100_24 * (var_100_29 / var_100_28)

				if var_100_30 > 0 and var_100_24 < var_100_30 then
					arg_97_1.talkMaxDuration = var_100_30

					if var_100_30 + var_100_23 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_30 + var_100_23
					end
				end

				arg_97_1.text_.text = var_100_27
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241024", "story_v_out_410241.awb") ~= 0 then
					local var_100_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241024", "story_v_out_410241.awb") / 1000

					if var_100_31 + var_100_23 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_31 + var_100_23
					end

					if var_100_26.prefab_name ~= "" and arg_97_1.actors_[var_100_26.prefab_name] ~= nil then
						local var_100_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_26.prefab_name].transform, "story_v_out_410241", "410241024", "story_v_out_410241.awb")

						arg_97_1:RecordAudio("410241024", var_100_32)
						arg_97_1:RecordAudio("410241024", var_100_32)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_410241", "410241024", "story_v_out_410241.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_410241", "410241024", "story_v_out_410241.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_33 = math.max(var_100_24, arg_97_1.talkMaxDuration)

			if var_100_23 <= arg_97_1.time_ and arg_97_1.time_ < var_100_23 + var_100_33 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_23) / var_100_33

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_23 + var_100_33 and arg_97_1.time_ < var_100_23 + var_100_33 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play410241025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 410241025
		arg_101_1.duration_ = 10.73

		local var_101_0 = {
			ja = 10.733,
			CriLanguages = 5.566,
			zh = 5.566
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
				arg_101_0:Play410241026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1061"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1061 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1061", 2)

				local var_104_2 = var_104_0.childCount

				for iter_104_0 = 0, var_104_2 - 1 do
					local var_104_3 = var_104_0:GetChild(iter_104_0)

					if var_104_3.name == "" or not string.find(var_104_3.name, "split") then
						var_104_3.gameObject:SetActive(true)
					else
						var_104_3.gameObject:SetActive(false)
					end
				end
			end

			local var_104_4 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_4 then
				local var_104_5 = (arg_101_1.time_ - var_104_1) / var_104_4
				local var_104_6 = Vector3.New(-390, -490, 18)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1061, var_104_6, var_104_5)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_4 and arg_101_1.time_ < var_104_1 + var_104_4 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_104_7 = arg_101_1.actors_["10060"]
			local var_104_8 = 0

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10060 == nil then
				arg_101_1.var_.actorSpriteComps10060 = var_104_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_9 = 0.034

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_9 and not isNil(var_104_7) then
				local var_104_10 = (arg_101_1.time_ - var_104_8) / var_104_9

				if arg_101_1.var_.actorSpriteComps10060 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								local var_104_11 = Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor2.r, var_104_10)
								local var_104_12 = Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor2.g, var_104_10)
								local var_104_13 = Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor2.b, var_104_10)

								iter_104_2.color = Color.New(var_104_11, var_104_12, var_104_13)
							else
								local var_104_14 = Mathf.Lerp(iter_104_2.color.r, 0.5, var_104_10)

								iter_104_2.color = Color.New(var_104_14, var_104_14, var_104_14)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_8 + var_104_9 and arg_101_1.time_ < var_104_8 + var_104_9 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10060 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_104_4 then
						if arg_101_1.isInRecall_ then
							iter_104_4.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10060 = nil
			end

			local var_104_15 = arg_101_1.actors_["1061"]
			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 and not isNil(var_104_15) and arg_101_1.var_.actorSpriteComps1061 == nil then
				arg_101_1.var_.actorSpriteComps1061 = var_104_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_17 = 0.034

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 and not isNil(var_104_15) then
				local var_104_18 = (arg_101_1.time_ - var_104_16) / var_104_17

				if arg_101_1.var_.actorSpriteComps1061 then
					for iter_104_5, iter_104_6 in pairs(arg_101_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_104_6 then
							if arg_101_1.isInRecall_ then
								local var_104_19 = Mathf.Lerp(iter_104_6.color.r, arg_101_1.hightColor1.r, var_104_18)
								local var_104_20 = Mathf.Lerp(iter_104_6.color.g, arg_101_1.hightColor1.g, var_104_18)
								local var_104_21 = Mathf.Lerp(iter_104_6.color.b, arg_101_1.hightColor1.b, var_104_18)

								iter_104_6.color = Color.New(var_104_19, var_104_20, var_104_21)
							else
								local var_104_22 = Mathf.Lerp(iter_104_6.color.r, 1, var_104_18)

								iter_104_6.color = Color.New(var_104_22, var_104_22, var_104_22)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 and not isNil(var_104_15) and arg_101_1.var_.actorSpriteComps1061 then
				for iter_104_7, iter_104_8 in pairs(arg_101_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_104_8 then
						if arg_101_1.isInRecall_ then
							iter_104_8.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps1061 = nil
			end

			local var_104_23 = 0
			local var_104_24 = 0.45

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_25 = arg_101_1:FormatText(StoryNameCfg[612].name)

				arg_101_1.leftNameTxt_.text = var_104_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_26 = arg_101_1:GetWordFromCfg(410241025)
				local var_104_27 = arg_101_1:FormatText(var_104_26.content)

				arg_101_1.text_.text = var_104_27

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_28 = 18
				local var_104_29 = utf8.len(var_104_27)
				local var_104_30 = var_104_28 <= 0 and var_104_24 or var_104_24 * (var_104_29 / var_104_28)

				if var_104_30 > 0 and var_104_24 < var_104_30 then
					arg_101_1.talkMaxDuration = var_104_30

					if var_104_30 + var_104_23 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_30 + var_104_23
					end
				end

				arg_101_1.text_.text = var_104_27
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241025", "story_v_out_410241.awb") ~= 0 then
					local var_104_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241025", "story_v_out_410241.awb") / 1000

					if var_104_31 + var_104_23 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_31 + var_104_23
					end

					if var_104_26.prefab_name ~= "" and arg_101_1.actors_[var_104_26.prefab_name] ~= nil then
						local var_104_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_26.prefab_name].transform, "story_v_out_410241", "410241025", "story_v_out_410241.awb")

						arg_101_1:RecordAudio("410241025", var_104_32)
						arg_101_1:RecordAudio("410241025", var_104_32)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_410241", "410241025", "story_v_out_410241.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_410241", "410241025", "story_v_out_410241.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_33 = math.max(var_104_24, arg_101_1.talkMaxDuration)

			if var_104_23 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_33 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_23) / var_104_33

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_23 + var_104_33 and arg_101_1.time_ < var_104_23 + var_104_33 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play410241026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 410241026
		arg_105_1.duration_ = 4.43

		local var_105_0 = {
			ja = 4.3,
			CriLanguages = 4.433,
			zh = 4.433
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
				arg_105_0:Play410241027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10060"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10060 = var_108_0.localPosition
				var_108_0.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10060", 4)

				local var_108_2 = var_108_0.childCount

				for iter_108_0 = 0, var_108_2 - 1 do
					local var_108_3 = var_108_0:GetChild(iter_108_0)

					if var_108_3.name == "" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_4 then
				local var_108_5 = (arg_105_1.time_ - var_108_1) / var_108_4
				local var_108_6 = Vector3.New(390, -400, 0)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10060, var_108_6, var_108_5)
			end

			if arg_105_1.time_ >= var_108_1 + var_108_4 and arg_105_1.time_ < var_108_1 + var_108_4 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_108_7 = arg_105_1.actors_["10060"]
			local var_108_8 = 0

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps10060 == nil then
				arg_105_1.var_.actorSpriteComps10060 = var_108_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_9 = 0.034

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_9 and not isNil(var_108_7) then
				local var_108_10 = (arg_105_1.time_ - var_108_8) / var_108_9

				if arg_105_1.var_.actorSpriteComps10060 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_108_2 then
							if arg_105_1.isInRecall_ then
								local var_108_11 = Mathf.Lerp(iter_108_2.color.r, arg_105_1.hightColor1.r, var_108_10)
								local var_108_12 = Mathf.Lerp(iter_108_2.color.g, arg_105_1.hightColor1.g, var_108_10)
								local var_108_13 = Mathf.Lerp(iter_108_2.color.b, arg_105_1.hightColor1.b, var_108_10)

								iter_108_2.color = Color.New(var_108_11, var_108_12, var_108_13)
							else
								local var_108_14 = Mathf.Lerp(iter_108_2.color.r, 1, var_108_10)

								iter_108_2.color = Color.New(var_108_14, var_108_14, var_108_14)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_8 + var_108_9 and arg_105_1.time_ < var_108_8 + var_108_9 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps10060 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_108_4 then
						if arg_105_1.isInRecall_ then
							iter_108_4.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10060 = nil
			end

			local var_108_15 = arg_105_1.actors_["1061"]
			local var_108_16 = 0

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 and not isNil(var_108_15) and arg_105_1.var_.actorSpriteComps1061 == nil then
				arg_105_1.var_.actorSpriteComps1061 = var_108_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_17 = 0.034

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_17 and not isNil(var_108_15) then
				local var_108_18 = (arg_105_1.time_ - var_108_16) / var_108_17

				if arg_105_1.var_.actorSpriteComps1061 then
					for iter_108_5, iter_108_6 in pairs(arg_105_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_108_6 then
							if arg_105_1.isInRecall_ then
								local var_108_19 = Mathf.Lerp(iter_108_6.color.r, arg_105_1.hightColor2.r, var_108_18)
								local var_108_20 = Mathf.Lerp(iter_108_6.color.g, arg_105_1.hightColor2.g, var_108_18)
								local var_108_21 = Mathf.Lerp(iter_108_6.color.b, arg_105_1.hightColor2.b, var_108_18)

								iter_108_6.color = Color.New(var_108_19, var_108_20, var_108_21)
							else
								local var_108_22 = Mathf.Lerp(iter_108_6.color.r, 0.5, var_108_18)

								iter_108_6.color = Color.New(var_108_22, var_108_22, var_108_22)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_16 + var_108_17 and arg_105_1.time_ < var_108_16 + var_108_17 + arg_108_0 and not isNil(var_108_15) and arg_105_1.var_.actorSpriteComps1061 then
				for iter_108_7, iter_108_8 in pairs(arg_105_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_108_8 then
						if arg_105_1.isInRecall_ then
							iter_108_8.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps1061 = nil
			end

			local var_108_23 = 0
			local var_108_24 = 0.675

			if var_108_23 < arg_105_1.time_ and arg_105_1.time_ <= var_108_23 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_25 = arg_105_1:FormatText(StoryNameCfg[597].name)

				arg_105_1.leftNameTxt_.text = var_108_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_26 = arg_105_1:GetWordFromCfg(410241026)
				local var_108_27 = arg_105_1:FormatText(var_108_26.content)

				arg_105_1.text_.text = var_108_27

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_28 = 27
				local var_108_29 = utf8.len(var_108_27)
				local var_108_30 = var_108_28 <= 0 and var_108_24 or var_108_24 * (var_108_29 / var_108_28)

				if var_108_30 > 0 and var_108_24 < var_108_30 then
					arg_105_1.talkMaxDuration = var_108_30

					if var_108_30 + var_108_23 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_30 + var_108_23
					end
				end

				arg_105_1.text_.text = var_108_27
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241026", "story_v_out_410241.awb") ~= 0 then
					local var_108_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241026", "story_v_out_410241.awb") / 1000

					if var_108_31 + var_108_23 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_31 + var_108_23
					end

					if var_108_26.prefab_name ~= "" and arg_105_1.actors_[var_108_26.prefab_name] ~= nil then
						local var_108_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_26.prefab_name].transform, "story_v_out_410241", "410241026", "story_v_out_410241.awb")

						arg_105_1:RecordAudio("410241026", var_108_32)
						arg_105_1:RecordAudio("410241026", var_108_32)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_410241", "410241026", "story_v_out_410241.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_410241", "410241026", "story_v_out_410241.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_33 = math.max(var_108_24, arg_105_1.talkMaxDuration)

			if var_108_23 <= arg_105_1.time_ and arg_105_1.time_ < var_108_23 + var_108_33 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_23) / var_108_33

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_23 + var_108_33 and arg_105_1.time_ < var_108_23 + var_108_33 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
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
	Play410241027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 410241027
		arg_109_1.duration_ = 16.6

		local var_109_0 = {
			ja = 16.6,
			CriLanguages = 10.1,
			zh = 10.1
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
				arg_109_0:Play410241028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1061"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1061 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1061", 2)

				local var_112_2 = var_112_0.childCount

				for iter_112_0 = 0, var_112_2 - 1 do
					local var_112_3 = var_112_0:GetChild(iter_112_0)

					if var_112_3.name == "" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_4 then
				local var_112_5 = (arg_109_1.time_ - var_112_1) / var_112_4
				local var_112_6 = Vector3.New(-390, -490, 18)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1061, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_112_7 = arg_109_1.actors_["10060"]
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10060 == nil then
				arg_109_1.var_.actorSpriteComps10060 = var_112_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_9 = 0.034

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 and not isNil(var_112_7) then
				local var_112_10 = (arg_109_1.time_ - var_112_8) / var_112_9

				if arg_109_1.var_.actorSpriteComps10060 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								local var_112_11 = Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor2.r, var_112_10)
								local var_112_12 = Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor2.g, var_112_10)
								local var_112_13 = Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor2.b, var_112_10)

								iter_112_2.color = Color.New(var_112_11, var_112_12, var_112_13)
							else
								local var_112_14 = Mathf.Lerp(iter_112_2.color.r, 0.5, var_112_10)

								iter_112_2.color = Color.New(var_112_14, var_112_14, var_112_14)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10060 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_112_4 then
						if arg_109_1.isInRecall_ then
							iter_112_4.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10060 = nil
			end

			local var_112_15 = arg_109_1.actors_["1061"]
			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.actorSpriteComps1061 == nil then
				arg_109_1.var_.actorSpriteComps1061 = var_112_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_17 = 0.034

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_17 and not isNil(var_112_15) then
				local var_112_18 = (arg_109_1.time_ - var_112_16) / var_112_17

				if arg_109_1.var_.actorSpriteComps1061 then
					for iter_112_5, iter_112_6 in pairs(arg_109_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_112_6 then
							if arg_109_1.isInRecall_ then
								local var_112_19 = Mathf.Lerp(iter_112_6.color.r, arg_109_1.hightColor1.r, var_112_18)
								local var_112_20 = Mathf.Lerp(iter_112_6.color.g, arg_109_1.hightColor1.g, var_112_18)
								local var_112_21 = Mathf.Lerp(iter_112_6.color.b, arg_109_1.hightColor1.b, var_112_18)

								iter_112_6.color = Color.New(var_112_19, var_112_20, var_112_21)
							else
								local var_112_22 = Mathf.Lerp(iter_112_6.color.r, 1, var_112_18)

								iter_112_6.color = Color.New(var_112_22, var_112_22, var_112_22)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.actorSpriteComps1061 then
				for iter_112_7, iter_112_8 in pairs(arg_109_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_112_8 then
						if arg_109_1.isInRecall_ then
							iter_112_8.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1061 = nil
			end

			local var_112_23 = 0
			local var_112_24 = 1.05

			if var_112_23 < arg_109_1.time_ and arg_109_1.time_ <= var_112_23 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_25 = arg_109_1:FormatText(StoryNameCfg[612].name)

				arg_109_1.leftNameTxt_.text = var_112_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_26 = arg_109_1:GetWordFromCfg(410241027)
				local var_112_27 = arg_109_1:FormatText(var_112_26.content)

				arg_109_1.text_.text = var_112_27

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_28 = 42
				local var_112_29 = utf8.len(var_112_27)
				local var_112_30 = var_112_28 <= 0 and var_112_24 or var_112_24 * (var_112_29 / var_112_28)

				if var_112_30 > 0 and var_112_24 < var_112_30 then
					arg_109_1.talkMaxDuration = var_112_30

					if var_112_30 + var_112_23 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_30 + var_112_23
					end
				end

				arg_109_1.text_.text = var_112_27
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241027", "story_v_out_410241.awb") ~= 0 then
					local var_112_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241027", "story_v_out_410241.awb") / 1000

					if var_112_31 + var_112_23 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_31 + var_112_23
					end

					if var_112_26.prefab_name ~= "" and arg_109_1.actors_[var_112_26.prefab_name] ~= nil then
						local var_112_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_26.prefab_name].transform, "story_v_out_410241", "410241027", "story_v_out_410241.awb")

						arg_109_1:RecordAudio("410241027", var_112_32)
						arg_109_1:RecordAudio("410241027", var_112_32)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_410241", "410241027", "story_v_out_410241.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_410241", "410241027", "story_v_out_410241.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_33 = math.max(var_112_24, arg_109_1.talkMaxDuration)

			if var_112_23 <= arg_109_1.time_ and arg_109_1.time_ < var_112_23 + var_112_33 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_23) / var_112_33

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_23 + var_112_33 and arg_109_1.time_ < var_112_23 + var_112_33 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410241028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 410241028
		arg_113_1.duration_ = 7.4

		local var_113_0 = {
			ja = 7.4,
			CriLanguages = 5.033,
			zh = 5.033
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
				arg_113_0:Play410241029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.45

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[612].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(410241028)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241028", "story_v_out_410241.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_410241", "410241028", "story_v_out_410241.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_410241", "410241028", "story_v_out_410241.awb")

						arg_113_1:RecordAudio("410241028", var_116_9)
						arg_113_1:RecordAudio("410241028", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_410241", "410241028", "story_v_out_410241.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_410241", "410241028", "story_v_out_410241.awb")
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
	Play410241029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 410241029
		arg_117_1.duration_ = 6.37

		local var_117_0 = {
			ja = 6.366,
			CriLanguages = 6.3,
			zh = 6.3
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
				arg_117_0:Play410241030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10060"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos10060 = var_120_0.localPosition
				var_120_0.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10060", 4)

				local var_120_2 = var_120_0.childCount

				for iter_120_0 = 0, var_120_2 - 1 do
					local var_120_3 = var_120_0:GetChild(iter_120_0)

					if var_120_3.name == "split_3" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_4 then
				local var_120_5 = (arg_117_1.time_ - var_120_1) / var_120_4
				local var_120_6 = Vector3.New(390, -400, 0)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10060, var_120_6, var_120_5)
			end

			if arg_117_1.time_ >= var_120_1 + var_120_4 and arg_117_1.time_ < var_120_1 + var_120_4 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_120_7 = arg_117_1.actors_["10060"]
			local var_120_8 = 0

			if var_120_8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.actorSpriteComps10060 == nil then
				arg_117_1.var_.actorSpriteComps10060 = var_120_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_9 = 0.034

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_9 and not isNil(var_120_7) then
				local var_120_10 = (arg_117_1.time_ - var_120_8) / var_120_9

				if arg_117_1.var_.actorSpriteComps10060 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_120_2 then
							if arg_117_1.isInRecall_ then
								local var_120_11 = Mathf.Lerp(iter_120_2.color.r, arg_117_1.hightColor1.r, var_120_10)
								local var_120_12 = Mathf.Lerp(iter_120_2.color.g, arg_117_1.hightColor1.g, var_120_10)
								local var_120_13 = Mathf.Lerp(iter_120_2.color.b, arg_117_1.hightColor1.b, var_120_10)

								iter_120_2.color = Color.New(var_120_11, var_120_12, var_120_13)
							else
								local var_120_14 = Mathf.Lerp(iter_120_2.color.r, 1, var_120_10)

								iter_120_2.color = Color.New(var_120_14, var_120_14, var_120_14)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_8 + var_120_9 and arg_117_1.time_ < var_120_8 + var_120_9 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.actorSpriteComps10060 then
				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_120_4 then
						if arg_117_1.isInRecall_ then
							iter_120_4.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10060 = nil
			end

			local var_120_15 = arg_117_1.actors_["1061"]
			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 and not isNil(var_120_15) and arg_117_1.var_.actorSpriteComps1061 == nil then
				arg_117_1.var_.actorSpriteComps1061 = var_120_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_17 = 0.034

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_17 and not isNil(var_120_15) then
				local var_120_18 = (arg_117_1.time_ - var_120_16) / var_120_17

				if arg_117_1.var_.actorSpriteComps1061 then
					for iter_120_5, iter_120_6 in pairs(arg_117_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_120_6 then
							if arg_117_1.isInRecall_ then
								local var_120_19 = Mathf.Lerp(iter_120_6.color.r, arg_117_1.hightColor2.r, var_120_18)
								local var_120_20 = Mathf.Lerp(iter_120_6.color.g, arg_117_1.hightColor2.g, var_120_18)
								local var_120_21 = Mathf.Lerp(iter_120_6.color.b, arg_117_1.hightColor2.b, var_120_18)

								iter_120_6.color = Color.New(var_120_19, var_120_20, var_120_21)
							else
								local var_120_22 = Mathf.Lerp(iter_120_6.color.r, 0.5, var_120_18)

								iter_120_6.color = Color.New(var_120_22, var_120_22, var_120_22)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_16 + var_120_17 and arg_117_1.time_ < var_120_16 + var_120_17 + arg_120_0 and not isNil(var_120_15) and arg_117_1.var_.actorSpriteComps1061 then
				for iter_120_7, iter_120_8 in pairs(arg_117_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_120_8 then
						if arg_117_1.isInRecall_ then
							iter_120_8.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps1061 = nil
			end

			local var_120_23 = 0
			local var_120_24 = 0.575

			if var_120_23 < arg_117_1.time_ and arg_117_1.time_ <= var_120_23 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_25 = arg_117_1:FormatText(StoryNameCfg[597].name)

				arg_117_1.leftNameTxt_.text = var_120_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_26 = arg_117_1:GetWordFromCfg(410241029)
				local var_120_27 = arg_117_1:FormatText(var_120_26.content)

				arg_117_1.text_.text = var_120_27

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_28 = 23
				local var_120_29 = utf8.len(var_120_27)
				local var_120_30 = var_120_28 <= 0 and var_120_24 or var_120_24 * (var_120_29 / var_120_28)

				if var_120_30 > 0 and var_120_24 < var_120_30 then
					arg_117_1.talkMaxDuration = var_120_30

					if var_120_30 + var_120_23 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_30 + var_120_23
					end
				end

				arg_117_1.text_.text = var_120_27
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241029", "story_v_out_410241.awb") ~= 0 then
					local var_120_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241029", "story_v_out_410241.awb") / 1000

					if var_120_31 + var_120_23 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_31 + var_120_23
					end

					if var_120_26.prefab_name ~= "" and arg_117_1.actors_[var_120_26.prefab_name] ~= nil then
						local var_120_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_26.prefab_name].transform, "story_v_out_410241", "410241029", "story_v_out_410241.awb")

						arg_117_1:RecordAudio("410241029", var_120_32)
						arg_117_1:RecordAudio("410241029", var_120_32)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_410241", "410241029", "story_v_out_410241.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_410241", "410241029", "story_v_out_410241.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_33 = math.max(var_120_24, arg_117_1.talkMaxDuration)

			if var_120_23 <= arg_117_1.time_ and arg_117_1.time_ < var_120_23 + var_120_33 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_23) / var_120_33

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_23 + var_120_33 and arg_117_1.time_ < var_120_23 + var_120_33 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
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
	Play410241030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 410241030
		arg_121_1.duration_ = 6.2

		local var_121_0 = {
			ja = 6.2,
			CriLanguages = 3.3,
			zh = 3.3
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
				arg_121_0:Play410241031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1061"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1061 = var_124_0.localPosition
				var_124_0.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("1061", 2)

				local var_124_2 = var_124_0.childCount

				for iter_124_0 = 0, var_124_2 - 1 do
					local var_124_3 = var_124_0:GetChild(iter_124_0)

					if var_124_3.name == "" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_4 then
				local var_124_5 = (arg_121_1.time_ - var_124_1) / var_124_4
				local var_124_6 = Vector3.New(-390, -490, 18)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1061, var_124_6, var_124_5)
			end

			if arg_121_1.time_ >= var_124_1 + var_124_4 and arg_121_1.time_ < var_124_1 + var_124_4 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_124_7 = arg_121_1.actors_["10060"]
			local var_124_8 = 0

			if var_124_8 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 and not isNil(var_124_7) and arg_121_1.var_.actorSpriteComps10060 == nil then
				arg_121_1.var_.actorSpriteComps10060 = var_124_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_9 = 0.034

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_9 and not isNil(var_124_7) then
				local var_124_10 = (arg_121_1.time_ - var_124_8) / var_124_9

				if arg_121_1.var_.actorSpriteComps10060 then
					for iter_124_1, iter_124_2 in pairs(arg_121_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_124_2 then
							if arg_121_1.isInRecall_ then
								local var_124_11 = Mathf.Lerp(iter_124_2.color.r, arg_121_1.hightColor2.r, var_124_10)
								local var_124_12 = Mathf.Lerp(iter_124_2.color.g, arg_121_1.hightColor2.g, var_124_10)
								local var_124_13 = Mathf.Lerp(iter_124_2.color.b, arg_121_1.hightColor2.b, var_124_10)

								iter_124_2.color = Color.New(var_124_11, var_124_12, var_124_13)
							else
								local var_124_14 = Mathf.Lerp(iter_124_2.color.r, 0.5, var_124_10)

								iter_124_2.color = Color.New(var_124_14, var_124_14, var_124_14)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_8 + var_124_9 and arg_121_1.time_ < var_124_8 + var_124_9 + arg_124_0 and not isNil(var_124_7) and arg_121_1.var_.actorSpriteComps10060 then
				for iter_124_3, iter_124_4 in pairs(arg_121_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_124_4 then
						if arg_121_1.isInRecall_ then
							iter_124_4.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10060 = nil
			end

			local var_124_15 = arg_121_1.actors_["1061"]
			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 and not isNil(var_124_15) and arg_121_1.var_.actorSpriteComps1061 == nil then
				arg_121_1.var_.actorSpriteComps1061 = var_124_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_17 = 0.034

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_17 and not isNil(var_124_15) then
				local var_124_18 = (arg_121_1.time_ - var_124_16) / var_124_17

				if arg_121_1.var_.actorSpriteComps1061 then
					for iter_124_5, iter_124_6 in pairs(arg_121_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_124_6 then
							if arg_121_1.isInRecall_ then
								local var_124_19 = Mathf.Lerp(iter_124_6.color.r, arg_121_1.hightColor1.r, var_124_18)
								local var_124_20 = Mathf.Lerp(iter_124_6.color.g, arg_121_1.hightColor1.g, var_124_18)
								local var_124_21 = Mathf.Lerp(iter_124_6.color.b, arg_121_1.hightColor1.b, var_124_18)

								iter_124_6.color = Color.New(var_124_19, var_124_20, var_124_21)
							else
								local var_124_22 = Mathf.Lerp(iter_124_6.color.r, 1, var_124_18)

								iter_124_6.color = Color.New(var_124_22, var_124_22, var_124_22)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_16 + var_124_17 and arg_121_1.time_ < var_124_16 + var_124_17 + arg_124_0 and not isNil(var_124_15) and arg_121_1.var_.actorSpriteComps1061 then
				for iter_124_7, iter_124_8 in pairs(arg_121_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_124_8 then
						if arg_121_1.isInRecall_ then
							iter_124_8.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps1061 = nil
			end

			local var_124_23 = 0
			local var_124_24 = 0.2

			if var_124_23 < arg_121_1.time_ and arg_121_1.time_ <= var_124_23 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_25 = arg_121_1:FormatText(StoryNameCfg[612].name)

				arg_121_1.leftNameTxt_.text = var_124_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_26 = arg_121_1:GetWordFromCfg(410241030)
				local var_124_27 = arg_121_1:FormatText(var_124_26.content)

				arg_121_1.text_.text = var_124_27

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_28 = 8
				local var_124_29 = utf8.len(var_124_27)
				local var_124_30 = var_124_28 <= 0 and var_124_24 or var_124_24 * (var_124_29 / var_124_28)

				if var_124_30 > 0 and var_124_24 < var_124_30 then
					arg_121_1.talkMaxDuration = var_124_30

					if var_124_30 + var_124_23 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_30 + var_124_23
					end
				end

				arg_121_1.text_.text = var_124_27
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241030", "story_v_out_410241.awb") ~= 0 then
					local var_124_31 = manager.audio:GetVoiceLength("story_v_out_410241", "410241030", "story_v_out_410241.awb") / 1000

					if var_124_31 + var_124_23 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_31 + var_124_23
					end

					if var_124_26.prefab_name ~= "" and arg_121_1.actors_[var_124_26.prefab_name] ~= nil then
						local var_124_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_26.prefab_name].transform, "story_v_out_410241", "410241030", "story_v_out_410241.awb")

						arg_121_1:RecordAudio("410241030", var_124_32)
						arg_121_1:RecordAudio("410241030", var_124_32)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_410241", "410241030", "story_v_out_410241.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_410241", "410241030", "story_v_out_410241.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_33 = math.max(var_124_24, arg_121_1.talkMaxDuration)

			if var_124_23 <= arg_121_1.time_ and arg_121_1.time_ < var_124_23 + var_124_33 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_23) / var_124_33

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_23 + var_124_33 and arg_121_1.time_ < var_124_23 + var_124_33 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play410241031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 410241031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play410241032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1061"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1061 = var_128_0.localPosition
				var_128_0.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1061", 7)

				local var_128_2 = var_128_0.childCount

				for iter_128_0 = 0, var_128_2 - 1 do
					local var_128_3 = var_128_0:GetChild(iter_128_0)

					if var_128_3.name == "" or not string.find(var_128_3.name, "split") then
						var_128_3.gameObject:SetActive(true)
					else
						var_128_3.gameObject:SetActive(false)
					end
				end
			end

			local var_128_4 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_4 then
				local var_128_5 = (arg_125_1.time_ - var_128_1) / var_128_4
				local var_128_6 = Vector3.New(0, -2000, 18)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1061, var_128_6, var_128_5)
			end

			if arg_125_1.time_ >= var_128_1 + var_128_4 and arg_125_1.time_ < var_128_1 + var_128_4 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_128_7 = arg_125_1.actors_["10060"].transform
			local var_128_8 = 0

			if var_128_8 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.var_.moveOldPos10060 = var_128_7.localPosition
				var_128_7.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10060", 7)

				local var_128_9 = var_128_7.childCount

				for iter_128_1 = 0, var_128_9 - 1 do
					local var_128_10 = var_128_7:GetChild(iter_128_1)

					if var_128_10.name == "" or not string.find(var_128_10.name, "split") then
						var_128_10.gameObject:SetActive(true)
					else
						var_128_10.gameObject:SetActive(false)
					end
				end
			end

			local var_128_11 = 0.001

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_11 then
				local var_128_12 = (arg_125_1.time_ - var_128_8) / var_128_11
				local var_128_13 = Vector3.New(0, -2000, 0)

				var_128_7.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10060, var_128_13, var_128_12)
			end

			if arg_125_1.time_ >= var_128_8 + var_128_11 and arg_125_1.time_ < var_128_8 + var_128_11 + arg_128_0 then
				var_128_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_128_14 = arg_125_1.actors_["1061"]
			local var_128_15 = 0

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 and not isNil(var_128_14) and arg_125_1.var_.actorSpriteComps1061 == nil then
				arg_125_1.var_.actorSpriteComps1061 = var_128_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_16 = 0.034

			if var_128_15 <= arg_125_1.time_ and arg_125_1.time_ < var_128_15 + var_128_16 and not isNil(var_128_14) then
				local var_128_17 = (arg_125_1.time_ - var_128_15) / var_128_16

				if arg_125_1.var_.actorSpriteComps1061 then
					for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_128_3 then
							if arg_125_1.isInRecall_ then
								local var_128_18 = Mathf.Lerp(iter_128_3.color.r, arg_125_1.hightColor2.r, var_128_17)
								local var_128_19 = Mathf.Lerp(iter_128_3.color.g, arg_125_1.hightColor2.g, var_128_17)
								local var_128_20 = Mathf.Lerp(iter_128_3.color.b, arg_125_1.hightColor2.b, var_128_17)

								iter_128_3.color = Color.New(var_128_18, var_128_19, var_128_20)
							else
								local var_128_21 = Mathf.Lerp(iter_128_3.color.r, 0.5, var_128_17)

								iter_128_3.color = Color.New(var_128_21, var_128_21, var_128_21)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_15 + var_128_16 and arg_125_1.time_ < var_128_15 + var_128_16 + arg_128_0 and not isNil(var_128_14) and arg_125_1.var_.actorSpriteComps1061 then
				for iter_128_4, iter_128_5 in pairs(arg_125_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_128_5 then
						if arg_125_1.isInRecall_ then
							iter_128_5.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps1061 = nil
			end

			local var_128_22 = arg_125_1.actors_["10060"]
			local var_128_23 = 0

			if var_128_23 < arg_125_1.time_ and arg_125_1.time_ <= var_128_23 + arg_128_0 and not isNil(var_128_22) and arg_125_1.var_.actorSpriteComps10060 == nil then
				arg_125_1.var_.actorSpriteComps10060 = var_128_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_24 = 0.034

			if var_128_23 <= arg_125_1.time_ and arg_125_1.time_ < var_128_23 + var_128_24 and not isNil(var_128_22) then
				local var_128_25 = (arg_125_1.time_ - var_128_23) / var_128_24

				if arg_125_1.var_.actorSpriteComps10060 then
					for iter_128_6, iter_128_7 in pairs(arg_125_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_128_7 then
							if arg_125_1.isInRecall_ then
								local var_128_26 = Mathf.Lerp(iter_128_7.color.r, arg_125_1.hightColor2.r, var_128_25)
								local var_128_27 = Mathf.Lerp(iter_128_7.color.g, arg_125_1.hightColor2.g, var_128_25)
								local var_128_28 = Mathf.Lerp(iter_128_7.color.b, arg_125_1.hightColor2.b, var_128_25)

								iter_128_7.color = Color.New(var_128_26, var_128_27, var_128_28)
							else
								local var_128_29 = Mathf.Lerp(iter_128_7.color.r, 0.5, var_128_25)

								iter_128_7.color = Color.New(var_128_29, var_128_29, var_128_29)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_23 + var_128_24 and arg_125_1.time_ < var_128_23 + var_128_24 + arg_128_0 and not isNil(var_128_22) and arg_125_1.var_.actorSpriteComps10060 then
				for iter_128_8, iter_128_9 in pairs(arg_125_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_128_9 then
						if arg_125_1.isInRecall_ then
							iter_128_9.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10060 = nil
			end

			local var_128_30 = 0
			local var_128_31 = 0.7

			if var_128_30 < arg_125_1.time_ and arg_125_1.time_ <= var_128_30 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_32 = arg_125_1:GetWordFromCfg(410241031)
				local var_128_33 = arg_125_1:FormatText(var_128_32.content)

				arg_125_1.text_.text = var_128_33

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_34 = 28
				local var_128_35 = utf8.len(var_128_33)
				local var_128_36 = var_128_34 <= 0 and var_128_31 or var_128_31 * (var_128_35 / var_128_34)

				if var_128_36 > 0 and var_128_31 < var_128_36 then
					arg_125_1.talkMaxDuration = var_128_36

					if var_128_36 + var_128_30 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_36 + var_128_30
					end
				end

				arg_125_1.text_.text = var_128_33
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_37 = math.max(var_128_31, arg_125_1.talkMaxDuration)

			if var_128_30 <= arg_125_1.time_ and arg_125_1.time_ < var_128_30 + var_128_37 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_30) / var_128_37

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_30 + var_128_37 and arg_125_1.time_ < var_128_30 + var_128_37 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play410241032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 410241032
		arg_129_1.duration_ = 23.3

		local var_129_0 = {
			ja = 23.3,
			CriLanguages = 20.3,
			zh = 20.3
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
				arg_129_0:Play410241033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1061"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos1061 = var_132_0.localPosition
				var_132_0.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1061", 3)

				local var_132_2 = var_132_0.childCount

				for iter_132_0 = 0, var_132_2 - 1 do
					local var_132_3 = var_132_0:GetChild(iter_132_0)

					if var_132_3.name == "split_7" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_4 then
				local var_132_5 = (arg_129_1.time_ - var_132_1) / var_132_4
				local var_132_6 = Vector3.New(0, -490, 18)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1061, var_132_6, var_132_5)
			end

			if arg_129_1.time_ >= var_132_1 + var_132_4 and arg_129_1.time_ < var_132_1 + var_132_4 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_132_7 = arg_129_1.actors_["1061"]
			local var_132_8 = 0

			if var_132_8 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 and not isNil(var_132_7) and arg_129_1.var_.actorSpriteComps1061 == nil then
				arg_129_1.var_.actorSpriteComps1061 = var_132_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_9 = 0.034

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_9 and not isNil(var_132_7) then
				local var_132_10 = (arg_129_1.time_ - var_132_8) / var_132_9

				if arg_129_1.var_.actorSpriteComps1061 then
					for iter_132_1, iter_132_2 in pairs(arg_129_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_132_2 then
							if arg_129_1.isInRecall_ then
								local var_132_11 = Mathf.Lerp(iter_132_2.color.r, arg_129_1.hightColor1.r, var_132_10)
								local var_132_12 = Mathf.Lerp(iter_132_2.color.g, arg_129_1.hightColor1.g, var_132_10)
								local var_132_13 = Mathf.Lerp(iter_132_2.color.b, arg_129_1.hightColor1.b, var_132_10)

								iter_132_2.color = Color.New(var_132_11, var_132_12, var_132_13)
							else
								local var_132_14 = Mathf.Lerp(iter_132_2.color.r, 1, var_132_10)

								iter_132_2.color = Color.New(var_132_14, var_132_14, var_132_14)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_8 + var_132_9 and arg_129_1.time_ < var_132_8 + var_132_9 + arg_132_0 and not isNil(var_132_7) and arg_129_1.var_.actorSpriteComps1061 then
				for iter_132_3, iter_132_4 in pairs(arg_129_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_132_4 then
						if arg_129_1.isInRecall_ then
							iter_132_4.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps1061 = nil
			end

			local var_132_15 = 0
			local var_132_16 = 1.525

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_17 = arg_129_1:FormatText(StoryNameCfg[612].name)

				arg_129_1.leftNameTxt_.text = var_132_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_18 = arg_129_1:GetWordFromCfg(410241032)
				local var_132_19 = arg_129_1:FormatText(var_132_18.content)

				arg_129_1.text_.text = var_132_19

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_20 = 61
				local var_132_21 = utf8.len(var_132_19)
				local var_132_22 = var_132_20 <= 0 and var_132_16 or var_132_16 * (var_132_21 / var_132_20)

				if var_132_22 > 0 and var_132_16 < var_132_22 then
					arg_129_1.talkMaxDuration = var_132_22

					if var_132_22 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_22 + var_132_15
					end
				end

				arg_129_1.text_.text = var_132_19
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241032", "story_v_out_410241.awb") ~= 0 then
					local var_132_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241032", "story_v_out_410241.awb") / 1000

					if var_132_23 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_23 + var_132_15
					end

					if var_132_18.prefab_name ~= "" and arg_129_1.actors_[var_132_18.prefab_name] ~= nil then
						local var_132_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_18.prefab_name].transform, "story_v_out_410241", "410241032", "story_v_out_410241.awb")

						arg_129_1:RecordAudio("410241032", var_132_24)
						arg_129_1:RecordAudio("410241032", var_132_24)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_410241", "410241032", "story_v_out_410241.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_410241", "410241032", "story_v_out_410241.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_25 = math.max(var_132_16, arg_129_1.talkMaxDuration)

			if var_132_15 <= arg_129_1.time_ and arg_129_1.time_ < var_132_15 + var_132_25 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_15) / var_132_25

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_15 + var_132_25 and arg_129_1.time_ < var_132_15 + var_132_25 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play410241033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 410241033
		arg_133_1.duration_ = 14.97

		local var_133_0 = {
			ja = 14.966,
			CriLanguages = 9.466,
			zh = 9.466
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
				arg_133_0:Play410241034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1061"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1061 = var_136_0.localPosition
				var_136_0.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("1061", 3)

				local var_136_2 = var_136_0.childCount

				for iter_136_0 = 0, var_136_2 - 1 do
					local var_136_3 = var_136_0:GetChild(iter_136_0)

					if var_136_3.name == "split_7" or not string.find(var_136_3.name, "split") then
						var_136_3.gameObject:SetActive(true)
					else
						var_136_3.gameObject:SetActive(false)
					end
				end
			end

			local var_136_4 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_4 then
				local var_136_5 = (arg_133_1.time_ - var_136_1) / var_136_4
				local var_136_6 = Vector3.New(0, -490, 18)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1061, var_136_6, var_136_5)
			end

			if arg_133_1.time_ >= var_136_1 + var_136_4 and arg_133_1.time_ < var_136_1 + var_136_4 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_136_7 = arg_133_1.actors_["1061"]
			local var_136_8 = 0

			if var_136_8 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 and not isNil(var_136_7) and arg_133_1.var_.actorSpriteComps1061 == nil then
				arg_133_1.var_.actorSpriteComps1061 = var_136_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_9 = 0.034

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_9 and not isNil(var_136_7) then
				local var_136_10 = (arg_133_1.time_ - var_136_8) / var_136_9

				if arg_133_1.var_.actorSpriteComps1061 then
					for iter_136_1, iter_136_2 in pairs(arg_133_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_136_2 then
							if arg_133_1.isInRecall_ then
								local var_136_11 = Mathf.Lerp(iter_136_2.color.r, arg_133_1.hightColor1.r, var_136_10)
								local var_136_12 = Mathf.Lerp(iter_136_2.color.g, arg_133_1.hightColor1.g, var_136_10)
								local var_136_13 = Mathf.Lerp(iter_136_2.color.b, arg_133_1.hightColor1.b, var_136_10)

								iter_136_2.color = Color.New(var_136_11, var_136_12, var_136_13)
							else
								local var_136_14 = Mathf.Lerp(iter_136_2.color.r, 1, var_136_10)

								iter_136_2.color = Color.New(var_136_14, var_136_14, var_136_14)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_8 + var_136_9 and arg_133_1.time_ < var_136_8 + var_136_9 + arg_136_0 and not isNil(var_136_7) and arg_133_1.var_.actorSpriteComps1061 then
				for iter_136_3, iter_136_4 in pairs(arg_133_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_136_4 then
						if arg_133_1.isInRecall_ then
							iter_136_4.color = arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_136_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps1061 = nil
			end

			local var_136_15 = 0
			local var_136_16 = 0.975

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_17 = arg_133_1:FormatText(StoryNameCfg[612].name)

				arg_133_1.leftNameTxt_.text = var_136_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_18 = arg_133_1:GetWordFromCfg(410241033)
				local var_136_19 = arg_133_1:FormatText(var_136_18.content)

				arg_133_1.text_.text = var_136_19

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_20 = 39
				local var_136_21 = utf8.len(var_136_19)
				local var_136_22 = var_136_20 <= 0 and var_136_16 or var_136_16 * (var_136_21 / var_136_20)

				if var_136_22 > 0 and var_136_16 < var_136_22 then
					arg_133_1.talkMaxDuration = var_136_22

					if var_136_22 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_22 + var_136_15
					end
				end

				arg_133_1.text_.text = var_136_19
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241033", "story_v_out_410241.awb") ~= 0 then
					local var_136_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241033", "story_v_out_410241.awb") / 1000

					if var_136_23 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_23 + var_136_15
					end

					if var_136_18.prefab_name ~= "" and arg_133_1.actors_[var_136_18.prefab_name] ~= nil then
						local var_136_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_18.prefab_name].transform, "story_v_out_410241", "410241033", "story_v_out_410241.awb")

						arg_133_1:RecordAudio("410241033", var_136_24)
						arg_133_1:RecordAudio("410241033", var_136_24)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_410241", "410241033", "story_v_out_410241.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_410241", "410241033", "story_v_out_410241.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_25 = math.max(var_136_16, arg_133_1.talkMaxDuration)

			if var_136_15 <= arg_133_1.time_ and arg_133_1.time_ < var_136_15 + var_136_25 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_15) / var_136_25

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_15 + var_136_25 and arg_133_1.time_ < var_136_15 + var_136_25 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play410241034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 410241034
		arg_137_1.duration_ = 18.37

		local var_137_0 = {
			ja = 18.366,
			CriLanguages = 17.066,
			zh = 17.066
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
				arg_137_0:Play410241035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1061"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1061 = var_140_0.localPosition
				var_140_0.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1061", 3)

				local var_140_2 = var_140_0.childCount

				for iter_140_0 = 0, var_140_2 - 1 do
					local var_140_3 = var_140_0:GetChild(iter_140_0)

					if var_140_3.name == "split_7" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_4 then
				local var_140_5 = (arg_137_1.time_ - var_140_1) / var_140_4
				local var_140_6 = Vector3.New(0, -490, 18)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1061, var_140_6, var_140_5)
			end

			if arg_137_1.time_ >= var_140_1 + var_140_4 and arg_137_1.time_ < var_140_1 + var_140_4 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_140_7 = arg_137_1.actors_["1061"]
			local var_140_8 = 0

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.actorSpriteComps1061 == nil then
				arg_137_1.var_.actorSpriteComps1061 = var_140_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_9 = 0.034

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_9 and not isNil(var_140_7) then
				local var_140_10 = (arg_137_1.time_ - var_140_8) / var_140_9

				if arg_137_1.var_.actorSpriteComps1061 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_140_2 then
							if arg_137_1.isInRecall_ then
								local var_140_11 = Mathf.Lerp(iter_140_2.color.r, arg_137_1.hightColor1.r, var_140_10)
								local var_140_12 = Mathf.Lerp(iter_140_2.color.g, arg_137_1.hightColor1.g, var_140_10)
								local var_140_13 = Mathf.Lerp(iter_140_2.color.b, arg_137_1.hightColor1.b, var_140_10)

								iter_140_2.color = Color.New(var_140_11, var_140_12, var_140_13)
							else
								local var_140_14 = Mathf.Lerp(iter_140_2.color.r, 1, var_140_10)

								iter_140_2.color = Color.New(var_140_14, var_140_14, var_140_14)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_8 + var_140_9 and arg_137_1.time_ < var_140_8 + var_140_9 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.actorSpriteComps1061 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_140_4 then
						if arg_137_1.isInRecall_ then
							iter_140_4.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps1061 = nil
			end

			local var_140_15 = 0
			local var_140_16 = 1.525

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_17 = arg_137_1:FormatText(StoryNameCfg[612].name)

				arg_137_1.leftNameTxt_.text = var_140_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_18 = arg_137_1:GetWordFromCfg(410241034)
				local var_140_19 = arg_137_1:FormatText(var_140_18.content)

				arg_137_1.text_.text = var_140_19

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_20 = 61
				local var_140_21 = utf8.len(var_140_19)
				local var_140_22 = var_140_20 <= 0 and var_140_16 or var_140_16 * (var_140_21 / var_140_20)

				if var_140_22 > 0 and var_140_16 < var_140_22 then
					arg_137_1.talkMaxDuration = var_140_22

					if var_140_22 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_22 + var_140_15
					end
				end

				arg_137_1.text_.text = var_140_19
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241034", "story_v_out_410241.awb") ~= 0 then
					local var_140_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241034", "story_v_out_410241.awb") / 1000

					if var_140_23 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_23 + var_140_15
					end

					if var_140_18.prefab_name ~= "" and arg_137_1.actors_[var_140_18.prefab_name] ~= nil then
						local var_140_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_18.prefab_name].transform, "story_v_out_410241", "410241034", "story_v_out_410241.awb")

						arg_137_1:RecordAudio("410241034", var_140_24)
						arg_137_1:RecordAudio("410241034", var_140_24)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_410241", "410241034", "story_v_out_410241.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_410241", "410241034", "story_v_out_410241.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_25 = math.max(var_140_16, arg_137_1.talkMaxDuration)

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_25 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_15) / var_140_25

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_15 + var_140_25 and arg_137_1.time_ < var_140_15 + var_140_25 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play410241035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 410241035
		arg_141_1.duration_ = 18.1

		local var_141_0 = {
			ja = 16.533,
			CriLanguages = 18.1,
			zh = 18.1
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
				arg_141_0:Play410241036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1061"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1061 = var_144_0.localPosition
				var_144_0.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("1061", 3)

				local var_144_2 = var_144_0.childCount

				for iter_144_0 = 0, var_144_2 - 1 do
					local var_144_3 = var_144_0:GetChild(iter_144_0)

					if var_144_3.name == "split_7" or not string.find(var_144_3.name, "split") then
						var_144_3.gameObject:SetActive(true)
					else
						var_144_3.gameObject:SetActive(false)
					end
				end
			end

			local var_144_4 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_4 then
				local var_144_5 = (arg_141_1.time_ - var_144_1) / var_144_4
				local var_144_6 = Vector3.New(0, -490, 18)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1061, var_144_6, var_144_5)
			end

			if arg_141_1.time_ >= var_144_1 + var_144_4 and arg_141_1.time_ < var_144_1 + var_144_4 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_144_7 = arg_141_1.actors_["1061"]
			local var_144_8 = 0

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.actorSpriteComps1061 == nil then
				arg_141_1.var_.actorSpriteComps1061 = var_144_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_9 = 0.034

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_9 and not isNil(var_144_7) then
				local var_144_10 = (arg_141_1.time_ - var_144_8) / var_144_9

				if arg_141_1.var_.actorSpriteComps1061 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_144_2 then
							if arg_141_1.isInRecall_ then
								local var_144_11 = Mathf.Lerp(iter_144_2.color.r, arg_141_1.hightColor1.r, var_144_10)
								local var_144_12 = Mathf.Lerp(iter_144_2.color.g, arg_141_1.hightColor1.g, var_144_10)
								local var_144_13 = Mathf.Lerp(iter_144_2.color.b, arg_141_1.hightColor1.b, var_144_10)

								iter_144_2.color = Color.New(var_144_11, var_144_12, var_144_13)
							else
								local var_144_14 = Mathf.Lerp(iter_144_2.color.r, 1, var_144_10)

								iter_144_2.color = Color.New(var_144_14, var_144_14, var_144_14)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_8 + var_144_9 and arg_141_1.time_ < var_144_8 + var_144_9 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.actorSpriteComps1061 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_144_4 then
						if arg_141_1.isInRecall_ then
							iter_144_4.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps1061 = nil
			end

			local var_144_15 = 0
			local var_144_16 = 1.225

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_17 = arg_141_1:FormatText(StoryNameCfg[612].name)

				arg_141_1.leftNameTxt_.text = var_144_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_18 = arg_141_1:GetWordFromCfg(410241035)
				local var_144_19 = arg_141_1:FormatText(var_144_18.content)

				arg_141_1.text_.text = var_144_19

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_20 = 48
				local var_144_21 = utf8.len(var_144_19)
				local var_144_22 = var_144_20 <= 0 and var_144_16 or var_144_16 * (var_144_21 / var_144_20)

				if var_144_22 > 0 and var_144_16 < var_144_22 then
					arg_141_1.talkMaxDuration = var_144_22

					if var_144_22 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_22 + var_144_15
					end
				end

				arg_141_1.text_.text = var_144_19
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241035", "story_v_out_410241.awb") ~= 0 then
					local var_144_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241035", "story_v_out_410241.awb") / 1000

					if var_144_23 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_23 + var_144_15
					end

					if var_144_18.prefab_name ~= "" and arg_141_1.actors_[var_144_18.prefab_name] ~= nil then
						local var_144_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_18.prefab_name].transform, "story_v_out_410241", "410241035", "story_v_out_410241.awb")

						arg_141_1:RecordAudio("410241035", var_144_24)
						arg_141_1:RecordAudio("410241035", var_144_24)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_410241", "410241035", "story_v_out_410241.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_410241", "410241035", "story_v_out_410241.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_25 = math.max(var_144_16, arg_141_1.talkMaxDuration)

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_25 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_15) / var_144_25

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_15 + var_144_25 and arg_141_1.time_ < var_144_15 + var_144_25 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play410241036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410241036
		arg_145_1.duration_ = 7.1

		local var_145_0 = {
			ja = 7.1,
			CriLanguages = 5.666,
			zh = 5.666
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
				arg_145_0:Play410241037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1061"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1061 = var_148_0.localPosition
				var_148_0.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1061", 3)

				local var_148_2 = var_148_0.childCount

				for iter_148_0 = 0, var_148_2 - 1 do
					local var_148_3 = var_148_0:GetChild(iter_148_0)

					if var_148_3.name == "split_7" or not string.find(var_148_3.name, "split") then
						var_148_3.gameObject:SetActive(true)
					else
						var_148_3.gameObject:SetActive(false)
					end
				end
			end

			local var_148_4 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_4 then
				local var_148_5 = (arg_145_1.time_ - var_148_1) / var_148_4
				local var_148_6 = Vector3.New(0, -490, 18)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1061, var_148_6, var_148_5)
			end

			if arg_145_1.time_ >= var_148_1 + var_148_4 and arg_145_1.time_ < var_148_1 + var_148_4 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_148_7 = arg_145_1.actors_["1061"]
			local var_148_8 = 0

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.actorSpriteComps1061 == nil then
				arg_145_1.var_.actorSpriteComps1061 = var_148_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_9 = 0.034

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_9 and not isNil(var_148_7) then
				local var_148_10 = (arg_145_1.time_ - var_148_8) / var_148_9

				if arg_145_1.var_.actorSpriteComps1061 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_148_2 then
							if arg_145_1.isInRecall_ then
								local var_148_11 = Mathf.Lerp(iter_148_2.color.r, arg_145_1.hightColor1.r, var_148_10)
								local var_148_12 = Mathf.Lerp(iter_148_2.color.g, arg_145_1.hightColor1.g, var_148_10)
								local var_148_13 = Mathf.Lerp(iter_148_2.color.b, arg_145_1.hightColor1.b, var_148_10)

								iter_148_2.color = Color.New(var_148_11, var_148_12, var_148_13)
							else
								local var_148_14 = Mathf.Lerp(iter_148_2.color.r, 1, var_148_10)

								iter_148_2.color = Color.New(var_148_14, var_148_14, var_148_14)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_8 + var_148_9 and arg_145_1.time_ < var_148_8 + var_148_9 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.actorSpriteComps1061 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_148_4 then
						if arg_145_1.isInRecall_ then
							iter_148_4.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps1061 = nil
			end

			local var_148_15 = 0
			local var_148_16 = 0.4

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[612].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(410241036)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 16
				local var_148_21 = utf8.len(var_148_19)
				local var_148_22 = var_148_20 <= 0 and var_148_16 or var_148_16 * (var_148_21 / var_148_20)

				if var_148_22 > 0 and var_148_16 < var_148_22 then
					arg_145_1.talkMaxDuration = var_148_22

					if var_148_22 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_22 + var_148_15
					end
				end

				arg_145_1.text_.text = var_148_19
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241036", "story_v_out_410241.awb") ~= 0 then
					local var_148_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241036", "story_v_out_410241.awb") / 1000

					if var_148_23 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_15
					end

					if var_148_18.prefab_name ~= "" and arg_145_1.actors_[var_148_18.prefab_name] ~= nil then
						local var_148_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_18.prefab_name].transform, "story_v_out_410241", "410241036", "story_v_out_410241.awb")

						arg_145_1:RecordAudio("410241036", var_148_24)
						arg_145_1:RecordAudio("410241036", var_148_24)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_410241", "410241036", "story_v_out_410241.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_410241", "410241036", "story_v_out_410241.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_25 = math.max(var_148_16, arg_145_1.talkMaxDuration)

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_25 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_15) / var_148_25

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_15 + var_148_25 and arg_145_1.time_ < var_148_15 + var_148_25 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play410241037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410241037
		arg_149_1.duration_ = 8.9

		local var_149_0 = {
			ja = 8.9,
			CriLanguages = 8.4,
			zh = 8.4
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
				arg_149_0:Play410241038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10060"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos10060 = var_152_0.localPosition
				var_152_0.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10060", 3)

				local var_152_2 = var_152_0.childCount

				for iter_152_0 = 0, var_152_2 - 1 do
					local var_152_3 = var_152_0:GetChild(iter_152_0)

					if var_152_3.name == "split_3" or not string.find(var_152_3.name, "split") then
						var_152_3.gameObject:SetActive(true)
					else
						var_152_3.gameObject:SetActive(false)
					end
				end
			end

			local var_152_4 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_4 then
				local var_152_5 = (arg_149_1.time_ - var_152_1) / var_152_4
				local var_152_6 = Vector3.New(0, -400, 0)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10060, var_152_6, var_152_5)
			end

			if arg_149_1.time_ >= var_152_1 + var_152_4 and arg_149_1.time_ < var_152_1 + var_152_4 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0, -400, 0)
			end

			local var_152_7 = arg_149_1.actors_["10060"]
			local var_152_8 = 0

			if var_152_8 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 and not isNil(var_152_7) and arg_149_1.var_.actorSpriteComps10060 == nil then
				arg_149_1.var_.actorSpriteComps10060 = var_152_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_9 = 0.034

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_9 and not isNil(var_152_7) then
				local var_152_10 = (arg_149_1.time_ - var_152_8) / var_152_9

				if arg_149_1.var_.actorSpriteComps10060 then
					for iter_152_1, iter_152_2 in pairs(arg_149_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_152_2 then
							if arg_149_1.isInRecall_ then
								local var_152_11 = Mathf.Lerp(iter_152_2.color.r, arg_149_1.hightColor1.r, var_152_10)
								local var_152_12 = Mathf.Lerp(iter_152_2.color.g, arg_149_1.hightColor1.g, var_152_10)
								local var_152_13 = Mathf.Lerp(iter_152_2.color.b, arg_149_1.hightColor1.b, var_152_10)

								iter_152_2.color = Color.New(var_152_11, var_152_12, var_152_13)
							else
								local var_152_14 = Mathf.Lerp(iter_152_2.color.r, 1, var_152_10)

								iter_152_2.color = Color.New(var_152_14, var_152_14, var_152_14)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_8 + var_152_9 and arg_149_1.time_ < var_152_8 + var_152_9 + arg_152_0 and not isNil(var_152_7) and arg_149_1.var_.actorSpriteComps10060 then
				for iter_152_3, iter_152_4 in pairs(arg_149_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_152_4 then
						if arg_149_1.isInRecall_ then
							iter_152_4.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_152_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10060 = nil
			end

			local var_152_15 = arg_149_1.actors_["1061"].transform
			local var_152_16 = 0

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1.var_.moveOldPos1061 = var_152_15.localPosition
				var_152_15.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("1061", 7)

				local var_152_17 = var_152_15.childCount

				for iter_152_5 = 0, var_152_17 - 1 do
					local var_152_18 = var_152_15:GetChild(iter_152_5)

					if var_152_18.name == "" or not string.find(var_152_18.name, "split") then
						var_152_18.gameObject:SetActive(true)
					else
						var_152_18.gameObject:SetActive(false)
					end
				end
			end

			local var_152_19 = 0.001

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_19 then
				local var_152_20 = (arg_149_1.time_ - var_152_16) / var_152_19
				local var_152_21 = Vector3.New(0, -2000, 18)

				var_152_15.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1061, var_152_21, var_152_20)
			end

			if arg_149_1.time_ >= var_152_16 + var_152_19 and arg_149_1.time_ < var_152_16 + var_152_19 + arg_152_0 then
				var_152_15.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_152_22 = arg_149_1.actors_["1061"]
			local var_152_23 = 0

			if var_152_23 < arg_149_1.time_ and arg_149_1.time_ <= var_152_23 + arg_152_0 and not isNil(var_152_22) and arg_149_1.var_.actorSpriteComps1061 == nil then
				arg_149_1.var_.actorSpriteComps1061 = var_152_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_24 = 0.034

			if var_152_23 <= arg_149_1.time_ and arg_149_1.time_ < var_152_23 + var_152_24 and not isNil(var_152_22) then
				local var_152_25 = (arg_149_1.time_ - var_152_23) / var_152_24

				if arg_149_1.var_.actorSpriteComps1061 then
					for iter_152_6, iter_152_7 in pairs(arg_149_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_152_7 then
							if arg_149_1.isInRecall_ then
								local var_152_26 = Mathf.Lerp(iter_152_7.color.r, arg_149_1.hightColor1.r, var_152_25)
								local var_152_27 = Mathf.Lerp(iter_152_7.color.g, arg_149_1.hightColor1.g, var_152_25)
								local var_152_28 = Mathf.Lerp(iter_152_7.color.b, arg_149_1.hightColor1.b, var_152_25)

								iter_152_7.color = Color.New(var_152_26, var_152_27, var_152_28)
							else
								local var_152_29 = Mathf.Lerp(iter_152_7.color.r, 1, var_152_25)

								iter_152_7.color = Color.New(var_152_29, var_152_29, var_152_29)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_23 + var_152_24 and arg_149_1.time_ < var_152_23 + var_152_24 + arg_152_0 and not isNil(var_152_22) and arg_149_1.var_.actorSpriteComps1061 then
				for iter_152_8, iter_152_9 in pairs(arg_149_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_152_9 then
						if arg_149_1.isInRecall_ then
							iter_152_9.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_152_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps1061 = nil
			end

			local var_152_30 = 0
			local var_152_31 = 0.825

			if var_152_30 < arg_149_1.time_ and arg_149_1.time_ <= var_152_30 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_32 = arg_149_1:FormatText(StoryNameCfg[597].name)

				arg_149_1.leftNameTxt_.text = var_152_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_33 = arg_149_1:GetWordFromCfg(410241037)
				local var_152_34 = arg_149_1:FormatText(var_152_33.content)

				arg_149_1.text_.text = var_152_34

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_35 = 33
				local var_152_36 = utf8.len(var_152_34)
				local var_152_37 = var_152_35 <= 0 and var_152_31 or var_152_31 * (var_152_36 / var_152_35)

				if var_152_37 > 0 and var_152_31 < var_152_37 then
					arg_149_1.talkMaxDuration = var_152_37

					if var_152_37 + var_152_30 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_37 + var_152_30
					end
				end

				arg_149_1.text_.text = var_152_34
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241037", "story_v_out_410241.awb") ~= 0 then
					local var_152_38 = manager.audio:GetVoiceLength("story_v_out_410241", "410241037", "story_v_out_410241.awb") / 1000

					if var_152_38 + var_152_30 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_38 + var_152_30
					end

					if var_152_33.prefab_name ~= "" and arg_149_1.actors_[var_152_33.prefab_name] ~= nil then
						local var_152_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_33.prefab_name].transform, "story_v_out_410241", "410241037", "story_v_out_410241.awb")

						arg_149_1:RecordAudio("410241037", var_152_39)
						arg_149_1:RecordAudio("410241037", var_152_39)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_410241", "410241037", "story_v_out_410241.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_410241", "410241037", "story_v_out_410241.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_40 = math.max(var_152_31, arg_149_1.talkMaxDuration)

			if var_152_30 <= arg_149_1.time_ and arg_149_1.time_ < var_152_30 + var_152_40 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_30) / var_152_40

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_30 + var_152_40 and arg_149_1.time_ < var_152_30 + var_152_40 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play410241038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410241038
		arg_153_1.duration_ = 7.83

		local var_153_0 = {
			ja = 5.4,
			CriLanguages = 7.833,
			zh = 7.833
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
				arg_153_0:Play410241039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.7

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[597].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(410241038)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241038", "story_v_out_410241.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_410241", "410241038", "story_v_out_410241.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_410241", "410241038", "story_v_out_410241.awb")

						arg_153_1:RecordAudio("410241038", var_156_9)
						arg_153_1:RecordAudio("410241038", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_410241", "410241038", "story_v_out_410241.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_410241", "410241038", "story_v_out_410241.awb")
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
	Play410241039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 410241039
		arg_157_1.duration_ = 8.77

		local var_157_0 = {
			ja = 7.033,
			CriLanguages = 8.766,
			zh = 8.766
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
				arg_157_0:Play410241040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1061"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1061 = var_160_0.localPosition
				var_160_0.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1061", 3)

				local var_160_2 = var_160_0.childCount

				for iter_160_0 = 0, var_160_2 - 1 do
					local var_160_3 = var_160_0:GetChild(iter_160_0)

					if var_160_3.name == "" or not string.find(var_160_3.name, "split") then
						var_160_3.gameObject:SetActive(true)
					else
						var_160_3.gameObject:SetActive(false)
					end
				end
			end

			local var_160_4 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_4 then
				local var_160_5 = (arg_157_1.time_ - var_160_1) / var_160_4
				local var_160_6 = Vector3.New(0, -490, 18)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1061, var_160_6, var_160_5)
			end

			if arg_157_1.time_ >= var_160_1 + var_160_4 and arg_157_1.time_ < var_160_1 + var_160_4 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_160_7 = arg_157_1.actors_["1061"]
			local var_160_8 = 0

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps1061 == nil then
				arg_157_1.var_.actorSpriteComps1061 = var_160_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_9 = 0.034

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_9 and not isNil(var_160_7) then
				local var_160_10 = (arg_157_1.time_ - var_160_8) / var_160_9

				if arg_157_1.var_.actorSpriteComps1061 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_160_2 then
							if arg_157_1.isInRecall_ then
								local var_160_11 = Mathf.Lerp(iter_160_2.color.r, arg_157_1.hightColor1.r, var_160_10)
								local var_160_12 = Mathf.Lerp(iter_160_2.color.g, arg_157_1.hightColor1.g, var_160_10)
								local var_160_13 = Mathf.Lerp(iter_160_2.color.b, arg_157_1.hightColor1.b, var_160_10)

								iter_160_2.color = Color.New(var_160_11, var_160_12, var_160_13)
							else
								local var_160_14 = Mathf.Lerp(iter_160_2.color.r, 1, var_160_10)

								iter_160_2.color = Color.New(var_160_14, var_160_14, var_160_14)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_8 + var_160_9 and arg_157_1.time_ < var_160_8 + var_160_9 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps1061 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_160_4 then
						if arg_157_1.isInRecall_ then
							iter_160_4.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1061 = nil
			end

			local var_160_15 = arg_157_1.actors_["10060"].transform
			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1.var_.moveOldPos10060 = var_160_15.localPosition
				var_160_15.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10060", 7)

				local var_160_17 = var_160_15.childCount

				for iter_160_5 = 0, var_160_17 - 1 do
					local var_160_18 = var_160_15:GetChild(iter_160_5)

					if var_160_18.name == "split_3" or not string.find(var_160_18.name, "split") then
						var_160_18.gameObject:SetActive(true)
					else
						var_160_18.gameObject:SetActive(false)
					end
				end
			end

			local var_160_19 = 0.001

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_19 then
				local var_160_20 = (arg_157_1.time_ - var_160_16) / var_160_19
				local var_160_21 = Vector3.New(0, -2000, 0)

				var_160_15.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10060, var_160_21, var_160_20)
			end

			if arg_157_1.time_ >= var_160_16 + var_160_19 and arg_157_1.time_ < var_160_16 + var_160_19 + arg_160_0 then
				var_160_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_22 = 0
			local var_160_23 = 1

			if var_160_22 < arg_157_1.time_ and arg_157_1.time_ <= var_160_22 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_24 = arg_157_1:FormatText(StoryNameCfg[612].name)

				arg_157_1.leftNameTxt_.text = var_160_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_25 = arg_157_1:GetWordFromCfg(410241039)
				local var_160_26 = arg_157_1:FormatText(var_160_25.content)

				arg_157_1.text_.text = var_160_26

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_27 = 40
				local var_160_28 = utf8.len(var_160_26)
				local var_160_29 = var_160_27 <= 0 and var_160_23 or var_160_23 * (var_160_28 / var_160_27)

				if var_160_29 > 0 and var_160_23 < var_160_29 then
					arg_157_1.talkMaxDuration = var_160_29

					if var_160_29 + var_160_22 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_29 + var_160_22
					end
				end

				arg_157_1.text_.text = var_160_26
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241039", "story_v_out_410241.awb") ~= 0 then
					local var_160_30 = manager.audio:GetVoiceLength("story_v_out_410241", "410241039", "story_v_out_410241.awb") / 1000

					if var_160_30 + var_160_22 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_30 + var_160_22
					end

					if var_160_25.prefab_name ~= "" and arg_157_1.actors_[var_160_25.prefab_name] ~= nil then
						local var_160_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_25.prefab_name].transform, "story_v_out_410241", "410241039", "story_v_out_410241.awb")

						arg_157_1:RecordAudio("410241039", var_160_31)
						arg_157_1:RecordAudio("410241039", var_160_31)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_410241", "410241039", "story_v_out_410241.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_410241", "410241039", "story_v_out_410241.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_32 = math.max(var_160_23, arg_157_1.talkMaxDuration)

			if var_160_22 <= arg_157_1.time_ and arg_157_1.time_ < var_160_22 + var_160_32 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_22) / var_160_32

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_22 + var_160_32 and arg_157_1.time_ < var_160_22 + var_160_32 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play410241040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 410241040
		arg_161_1.duration_ = 8.93

		local var_161_0 = {
			ja = 8.933,
			CriLanguages = 5.633,
			zh = 5.633
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
				arg_161_0:Play410241041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1061"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos1061 = var_164_0.localPosition
				var_164_0.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1061", 3)

				local var_164_2 = var_164_0.childCount

				for iter_164_0 = 0, var_164_2 - 1 do
					local var_164_3 = var_164_0:GetChild(iter_164_0)

					if var_164_3.name == "" or not string.find(var_164_3.name, "split") then
						var_164_3.gameObject:SetActive(true)
					else
						var_164_3.gameObject:SetActive(false)
					end
				end
			end

			local var_164_4 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_4 then
				local var_164_5 = (arg_161_1.time_ - var_164_1) / var_164_4
				local var_164_6 = Vector3.New(0, -490, 18)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1061, var_164_6, var_164_5)
			end

			if arg_161_1.time_ >= var_164_1 + var_164_4 and arg_161_1.time_ < var_164_1 + var_164_4 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_164_7 = arg_161_1.actors_["1061"]
			local var_164_8 = 0

			if var_164_8 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 and not isNil(var_164_7) and arg_161_1.var_.actorSpriteComps1061 == nil then
				arg_161_1.var_.actorSpriteComps1061 = var_164_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_9 = 0.034

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_9 and not isNil(var_164_7) then
				local var_164_10 = (arg_161_1.time_ - var_164_8) / var_164_9

				if arg_161_1.var_.actorSpriteComps1061 then
					for iter_164_1, iter_164_2 in pairs(arg_161_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_164_2 then
							if arg_161_1.isInRecall_ then
								local var_164_11 = Mathf.Lerp(iter_164_2.color.r, arg_161_1.hightColor1.r, var_164_10)
								local var_164_12 = Mathf.Lerp(iter_164_2.color.g, arg_161_1.hightColor1.g, var_164_10)
								local var_164_13 = Mathf.Lerp(iter_164_2.color.b, arg_161_1.hightColor1.b, var_164_10)

								iter_164_2.color = Color.New(var_164_11, var_164_12, var_164_13)
							else
								local var_164_14 = Mathf.Lerp(iter_164_2.color.r, 1, var_164_10)

								iter_164_2.color = Color.New(var_164_14, var_164_14, var_164_14)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_8 + var_164_9 and arg_161_1.time_ < var_164_8 + var_164_9 + arg_164_0 and not isNil(var_164_7) and arg_161_1.var_.actorSpriteComps1061 then
				for iter_164_3, iter_164_4 in pairs(arg_161_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_164_4 then
						if arg_161_1.isInRecall_ then
							iter_164_4.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_164_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps1061 = nil
			end

			local var_164_15 = 0
			local var_164_16 = 0.6

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_17 = arg_161_1:FormatText(StoryNameCfg[612].name)

				arg_161_1.leftNameTxt_.text = var_164_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_18 = arg_161_1:GetWordFromCfg(410241040)
				local var_164_19 = arg_161_1:FormatText(var_164_18.content)

				arg_161_1.text_.text = var_164_19

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_20 = 24
				local var_164_21 = utf8.len(var_164_19)
				local var_164_22 = var_164_20 <= 0 and var_164_16 or var_164_16 * (var_164_21 / var_164_20)

				if var_164_22 > 0 and var_164_16 < var_164_22 then
					arg_161_1.talkMaxDuration = var_164_22

					if var_164_22 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_22 + var_164_15
					end
				end

				arg_161_1.text_.text = var_164_19
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241040", "story_v_out_410241.awb") ~= 0 then
					local var_164_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241040", "story_v_out_410241.awb") / 1000

					if var_164_23 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_23 + var_164_15
					end

					if var_164_18.prefab_name ~= "" and arg_161_1.actors_[var_164_18.prefab_name] ~= nil then
						local var_164_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_18.prefab_name].transform, "story_v_out_410241", "410241040", "story_v_out_410241.awb")

						arg_161_1:RecordAudio("410241040", var_164_24)
						arg_161_1:RecordAudio("410241040", var_164_24)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_410241", "410241040", "story_v_out_410241.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_410241", "410241040", "story_v_out_410241.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_25 = math.max(var_164_16, arg_161_1.talkMaxDuration)

			if var_164_15 <= arg_161_1.time_ and arg_161_1.time_ < var_164_15 + var_164_25 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_15) / var_164_25

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_15 + var_164_25 and arg_161_1.time_ < var_164_15 + var_164_25 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play410241041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 410241041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play410241042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1061"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1061 = var_168_0.localPosition
				var_168_0.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1061", 7)

				local var_168_2 = var_168_0.childCount

				for iter_168_0 = 0, var_168_2 - 1 do
					local var_168_3 = var_168_0:GetChild(iter_168_0)

					if var_168_3.name == "" or not string.find(var_168_3.name, "split") then
						var_168_3.gameObject:SetActive(true)
					else
						var_168_3.gameObject:SetActive(false)
					end
				end
			end

			local var_168_4 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_4 then
				local var_168_5 = (arg_165_1.time_ - var_168_1) / var_168_4
				local var_168_6 = Vector3.New(0, -2000, 18)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1061, var_168_6, var_168_5)
			end

			if arg_165_1.time_ >= var_168_1 + var_168_4 and arg_165_1.time_ < var_168_1 + var_168_4 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_168_7 = arg_165_1.actors_["10060"].transform
			local var_168_8 = 0

			if var_168_8 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.var_.moveOldPos10060 = var_168_7.localPosition
				var_168_7.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10060", 7)

				local var_168_9 = var_168_7.childCount

				for iter_168_1 = 0, var_168_9 - 1 do
					local var_168_10 = var_168_7:GetChild(iter_168_1)

					if var_168_10.name == "" or not string.find(var_168_10.name, "split") then
						var_168_10.gameObject:SetActive(true)
					else
						var_168_10.gameObject:SetActive(false)
					end
				end
			end

			local var_168_11 = 0.001

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_11 then
				local var_168_12 = (arg_165_1.time_ - var_168_8) / var_168_11
				local var_168_13 = Vector3.New(0, -2000, 0)

				var_168_7.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10060, var_168_13, var_168_12)
			end

			if arg_165_1.time_ >= var_168_8 + var_168_11 and arg_165_1.time_ < var_168_8 + var_168_11 + arg_168_0 then
				var_168_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_168_14 = arg_165_1.actors_["1061"]
			local var_168_15 = 0

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 and not isNil(var_168_14) and arg_165_1.var_.actorSpriteComps1061 == nil then
				arg_165_1.var_.actorSpriteComps1061 = var_168_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_16 = 0.034

			if var_168_15 <= arg_165_1.time_ and arg_165_1.time_ < var_168_15 + var_168_16 and not isNil(var_168_14) then
				local var_168_17 = (arg_165_1.time_ - var_168_15) / var_168_16

				if arg_165_1.var_.actorSpriteComps1061 then
					for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_168_3 then
							if arg_165_1.isInRecall_ then
								local var_168_18 = Mathf.Lerp(iter_168_3.color.r, arg_165_1.hightColor2.r, var_168_17)
								local var_168_19 = Mathf.Lerp(iter_168_3.color.g, arg_165_1.hightColor2.g, var_168_17)
								local var_168_20 = Mathf.Lerp(iter_168_3.color.b, arg_165_1.hightColor2.b, var_168_17)

								iter_168_3.color = Color.New(var_168_18, var_168_19, var_168_20)
							else
								local var_168_21 = Mathf.Lerp(iter_168_3.color.r, 0.5, var_168_17)

								iter_168_3.color = Color.New(var_168_21, var_168_21, var_168_21)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_15 + var_168_16 and arg_165_1.time_ < var_168_15 + var_168_16 + arg_168_0 and not isNil(var_168_14) and arg_165_1.var_.actorSpriteComps1061 then
				for iter_168_4, iter_168_5 in pairs(arg_165_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_168_5 then
						if arg_165_1.isInRecall_ then
							iter_168_5.color = arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_168_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps1061 = nil
			end

			local var_168_22 = arg_165_1.actors_["10060"]
			local var_168_23 = 0

			if var_168_23 < arg_165_1.time_ and arg_165_1.time_ <= var_168_23 + arg_168_0 and not isNil(var_168_22) and arg_165_1.var_.actorSpriteComps10060 == nil then
				arg_165_1.var_.actorSpriteComps10060 = var_168_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_24 = 0.034

			if var_168_23 <= arg_165_1.time_ and arg_165_1.time_ < var_168_23 + var_168_24 and not isNil(var_168_22) then
				local var_168_25 = (arg_165_1.time_ - var_168_23) / var_168_24

				if arg_165_1.var_.actorSpriteComps10060 then
					for iter_168_6, iter_168_7 in pairs(arg_165_1.var_.actorSpriteComps10060:ToTable()) do
						if iter_168_7 then
							if arg_165_1.isInRecall_ then
								local var_168_26 = Mathf.Lerp(iter_168_7.color.r, arg_165_1.hightColor2.r, var_168_25)
								local var_168_27 = Mathf.Lerp(iter_168_7.color.g, arg_165_1.hightColor2.g, var_168_25)
								local var_168_28 = Mathf.Lerp(iter_168_7.color.b, arg_165_1.hightColor2.b, var_168_25)

								iter_168_7.color = Color.New(var_168_26, var_168_27, var_168_28)
							else
								local var_168_29 = Mathf.Lerp(iter_168_7.color.r, 0.5, var_168_25)

								iter_168_7.color = Color.New(var_168_29, var_168_29, var_168_29)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_23 + var_168_24 and arg_165_1.time_ < var_168_23 + var_168_24 + arg_168_0 and not isNil(var_168_22) and arg_165_1.var_.actorSpriteComps10060 then
				for iter_168_8, iter_168_9 in pairs(arg_165_1.var_.actorSpriteComps10060:ToTable()) do
					if iter_168_9 then
						if arg_165_1.isInRecall_ then
							iter_168_9.color = arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_168_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10060 = nil
			end

			local var_168_30 = 0
			local var_168_31 = 0.775

			if var_168_30 < arg_165_1.time_ and arg_165_1.time_ <= var_168_30 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_32 = arg_165_1:GetWordFromCfg(410241041)
				local var_168_33 = arg_165_1:FormatText(var_168_32.content)

				arg_165_1.text_.text = var_168_33

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_34 = 31
				local var_168_35 = utf8.len(var_168_33)
				local var_168_36 = var_168_34 <= 0 and var_168_31 or var_168_31 * (var_168_35 / var_168_34)

				if var_168_36 > 0 and var_168_31 < var_168_36 then
					arg_165_1.talkMaxDuration = var_168_36

					if var_168_36 + var_168_30 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_36 + var_168_30
					end
				end

				arg_165_1.text_.text = var_168_33
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_37 = math.max(var_168_31, arg_165_1.talkMaxDuration)

			if var_168_30 <= arg_165_1.time_ and arg_165_1.time_ < var_168_30 + var_168_37 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_30) / var_168_37

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_30 + var_168_37 and arg_165_1.time_ < var_168_30 + var_168_37 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play410241042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 410241042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play410241043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.95

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_2 = arg_169_1:GetWordFromCfg(410241042)
				local var_172_3 = arg_169_1:FormatText(var_172_2.content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 38
				local var_172_5 = utf8.len(var_172_3)
				local var_172_6 = var_172_4 <= 0 and var_172_1 or var_172_1 * (var_172_5 / var_172_4)

				if var_172_6 > 0 and var_172_1 < var_172_6 then
					arg_169_1.talkMaxDuration = var_172_6

					if var_172_6 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_7 and arg_169_1.time_ < var_172_0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play410241043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 410241043
		arg_173_1.duration_ = 10.3

		local var_173_0 = {
			ja = 1.566,
			CriLanguages = 10.3,
			zh = 10.3
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
				arg_173_0:Play410241044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1061"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1061 = var_176_0.localPosition
				var_176_0.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("1061", 3)

				local var_176_2 = var_176_0.childCount

				for iter_176_0 = 0, var_176_2 - 1 do
					local var_176_3 = var_176_0:GetChild(iter_176_0)

					if var_176_3.name == "" or not string.find(var_176_3.name, "split") then
						var_176_3.gameObject:SetActive(true)
					else
						var_176_3.gameObject:SetActive(false)
					end
				end
			end

			local var_176_4 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_4 then
				local var_176_5 = (arg_173_1.time_ - var_176_1) / var_176_4
				local var_176_6 = Vector3.New(0, -490, 18)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1061, var_176_6, var_176_5)
			end

			if arg_173_1.time_ >= var_176_1 + var_176_4 and arg_173_1.time_ < var_176_1 + var_176_4 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_176_7 = arg_173_1.actors_["1061"]
			local var_176_8 = 0

			if var_176_8 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.actorSpriteComps1061 == nil then
				arg_173_1.var_.actorSpriteComps1061 = var_176_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_9 = 0.034

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_9 and not isNil(var_176_7) then
				local var_176_10 = (arg_173_1.time_ - var_176_8) / var_176_9

				if arg_173_1.var_.actorSpriteComps1061 then
					for iter_176_1, iter_176_2 in pairs(arg_173_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_176_2 then
							if arg_173_1.isInRecall_ then
								local var_176_11 = Mathf.Lerp(iter_176_2.color.r, arg_173_1.hightColor1.r, var_176_10)
								local var_176_12 = Mathf.Lerp(iter_176_2.color.g, arg_173_1.hightColor1.g, var_176_10)
								local var_176_13 = Mathf.Lerp(iter_176_2.color.b, arg_173_1.hightColor1.b, var_176_10)

								iter_176_2.color = Color.New(var_176_11, var_176_12, var_176_13)
							else
								local var_176_14 = Mathf.Lerp(iter_176_2.color.r, 1, var_176_10)

								iter_176_2.color = Color.New(var_176_14, var_176_14, var_176_14)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_8 + var_176_9 and arg_173_1.time_ < var_176_8 + var_176_9 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.actorSpriteComps1061 then
				for iter_176_3, iter_176_4 in pairs(arg_173_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_176_4 then
						if arg_173_1.isInRecall_ then
							iter_176_4.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_176_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps1061 = nil
			end

			local var_176_15 = 0
			local var_176_16 = 0.05

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_17 = arg_173_1:FormatText(StoryNameCfg[612].name)

				arg_173_1.leftNameTxt_.text = var_176_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_18 = arg_173_1:GetWordFromCfg(410241043)
				local var_176_19 = arg_173_1:FormatText(var_176_18.content)

				arg_173_1.text_.text = var_176_19

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_20 = 2
				local var_176_21 = utf8.len(var_176_19)
				local var_176_22 = var_176_20 <= 0 and var_176_16 or var_176_16 * (var_176_21 / var_176_20)

				if var_176_22 > 0 and var_176_16 < var_176_22 then
					arg_173_1.talkMaxDuration = var_176_22

					if var_176_22 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_22 + var_176_15
					end
				end

				arg_173_1.text_.text = var_176_19
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241043", "story_v_out_410241.awb") ~= 0 then
					local var_176_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241043", "story_v_out_410241.awb") / 1000

					if var_176_23 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_23 + var_176_15
					end

					if var_176_18.prefab_name ~= "" and arg_173_1.actors_[var_176_18.prefab_name] ~= nil then
						local var_176_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_18.prefab_name].transform, "story_v_out_410241", "410241043", "story_v_out_410241.awb")

						arg_173_1:RecordAudio("410241043", var_176_24)
						arg_173_1:RecordAudio("410241043", var_176_24)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_410241", "410241043", "story_v_out_410241.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_410241", "410241043", "story_v_out_410241.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_25 = math.max(var_176_16, arg_173_1.talkMaxDuration)

			if var_176_15 <= arg_173_1.time_ and arg_173_1.time_ < var_176_15 + var_176_25 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_15) / var_176_25

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_15 + var_176_25 and arg_173_1.time_ < var_176_15 + var_176_25 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410241044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 410241044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play410241045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1061"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps1061 == nil then
				arg_177_1.var_.actorSpriteComps1061 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.034

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps1061 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								local var_180_4 = Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor2.r, var_180_3)
								local var_180_5 = Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor2.g, var_180_3)
								local var_180_6 = Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor2.b, var_180_3)

								iter_180_1.color = Color.New(var_180_4, var_180_5, var_180_6)
							else
								local var_180_7 = Mathf.Lerp(iter_180_1.color.r, 0.5, var_180_3)

								iter_180_1.color = Color.New(var_180_7, var_180_7, var_180_7)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps1061 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_180_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps1061 = nil
			end

			local var_180_8 = 0
			local var_180_9 = 1.175

			if var_180_8 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_10 = arg_177_1:GetWordFromCfg(410241044)
				local var_180_11 = arg_177_1:FormatText(var_180_10.content)

				arg_177_1.text_.text = var_180_11

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_12 = 47
				local var_180_13 = utf8.len(var_180_11)
				local var_180_14 = var_180_12 <= 0 and var_180_9 or var_180_9 * (var_180_13 / var_180_12)

				if var_180_14 > 0 and var_180_9 < var_180_14 then
					arg_177_1.talkMaxDuration = var_180_14

					if var_180_14 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_11
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_15 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_15 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_8) / var_180_15

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_8 + var_180_15 and arg_177_1.time_ < var_180_8 + var_180_15 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play410241045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 410241045
		arg_181_1.duration_ = 8.13

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play410241046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1061"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1061 = var_184_0.localPosition
				var_184_0.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("1061", 3)

				local var_184_2 = var_184_0.childCount

				for iter_184_0 = 0, var_184_2 - 1 do
					local var_184_3 = var_184_0:GetChild(iter_184_0)

					if var_184_3.name == "split_7" or not string.find(var_184_3.name, "split") then
						var_184_3.gameObject:SetActive(true)
					else
						var_184_3.gameObject:SetActive(false)
					end
				end
			end

			local var_184_4 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_4 then
				local var_184_5 = (arg_181_1.time_ - var_184_1) / var_184_4
				local var_184_6 = Vector3.New(0, -490, 18)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1061, var_184_6, var_184_5)
			end

			if arg_181_1.time_ >= var_184_1 + var_184_4 and arg_181_1.time_ < var_184_1 + var_184_4 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_184_7 = arg_181_1.actors_["1061"]
			local var_184_8 = 0

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 and not isNil(var_184_7) and arg_181_1.var_.actorSpriteComps1061 == nil then
				arg_181_1.var_.actorSpriteComps1061 = var_184_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_9 = 0.034

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_9 and not isNil(var_184_7) then
				local var_184_10 = (arg_181_1.time_ - var_184_8) / var_184_9

				if arg_181_1.var_.actorSpriteComps1061 then
					for iter_184_1, iter_184_2 in pairs(arg_181_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_184_2 then
							if arg_181_1.isInRecall_ then
								local var_184_11 = Mathf.Lerp(iter_184_2.color.r, arg_181_1.hightColor1.r, var_184_10)
								local var_184_12 = Mathf.Lerp(iter_184_2.color.g, arg_181_1.hightColor1.g, var_184_10)
								local var_184_13 = Mathf.Lerp(iter_184_2.color.b, arg_181_1.hightColor1.b, var_184_10)

								iter_184_2.color = Color.New(var_184_11, var_184_12, var_184_13)
							else
								local var_184_14 = Mathf.Lerp(iter_184_2.color.r, 1, var_184_10)

								iter_184_2.color = Color.New(var_184_14, var_184_14, var_184_14)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_8 + var_184_9 and arg_181_1.time_ < var_184_8 + var_184_9 + arg_184_0 and not isNil(var_184_7) and arg_181_1.var_.actorSpriteComps1061 then
				for iter_184_3, iter_184_4 in pairs(arg_181_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_184_4 then
						if arg_181_1.isInRecall_ then
							iter_184_4.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps1061 = nil
			end

			local var_184_15 = 0
			local var_184_16 = 0.675

			if var_184_15 < arg_181_1.time_ and arg_181_1.time_ <= var_184_15 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_17 = arg_181_1:FormatText(StoryNameCfg[612].name)

				arg_181_1.leftNameTxt_.text = var_184_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_18 = arg_181_1:GetWordFromCfg(410241045)
				local var_184_19 = arg_181_1:FormatText(var_184_18.content)

				arg_181_1.text_.text = var_184_19

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_20 = 27
				local var_184_21 = utf8.len(var_184_19)
				local var_184_22 = var_184_20 <= 0 and var_184_16 or var_184_16 * (var_184_21 / var_184_20)

				if var_184_22 > 0 and var_184_16 < var_184_22 then
					arg_181_1.talkMaxDuration = var_184_22

					if var_184_22 + var_184_15 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_22 + var_184_15
					end
				end

				arg_181_1.text_.text = var_184_19
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241045", "story_v_out_410241.awb") ~= 0 then
					local var_184_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241045", "story_v_out_410241.awb") / 1000

					if var_184_23 + var_184_15 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_23 + var_184_15
					end

					if var_184_18.prefab_name ~= "" and arg_181_1.actors_[var_184_18.prefab_name] ~= nil then
						local var_184_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_18.prefab_name].transform, "story_v_out_410241", "410241045", "story_v_out_410241.awb")

						arg_181_1:RecordAudio("410241045", var_184_24)
						arg_181_1:RecordAudio("410241045", var_184_24)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_410241", "410241045", "story_v_out_410241.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_410241", "410241045", "story_v_out_410241.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_25 = math.max(var_184_16, arg_181_1.talkMaxDuration)

			if var_184_15 <= arg_181_1.time_ and arg_181_1.time_ < var_184_15 + var_184_25 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_15) / var_184_25

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_15 + var_184_25 and arg_181_1.time_ < var_184_15 + var_184_25 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410241046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410241046
		arg_185_1.duration_ = 13.67

		local var_185_0 = {
			ja = 8.533,
			CriLanguages = 13.666,
			zh = 13.666
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
				arg_185_0:Play410241047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1061"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1061 = var_188_0.localPosition
				var_188_0.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("1061", 3)

				local var_188_2 = var_188_0.childCount

				for iter_188_0 = 0, var_188_2 - 1 do
					local var_188_3 = var_188_0:GetChild(iter_188_0)

					if var_188_3.name == "split_7" or not string.find(var_188_3.name, "split") then
						var_188_3.gameObject:SetActive(true)
					else
						var_188_3.gameObject:SetActive(false)
					end
				end
			end

			local var_188_4 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_4 then
				local var_188_5 = (arg_185_1.time_ - var_188_1) / var_188_4
				local var_188_6 = Vector3.New(0, -490, 18)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1061, var_188_6, var_188_5)
			end

			if arg_185_1.time_ >= var_188_1 + var_188_4 and arg_185_1.time_ < var_188_1 + var_188_4 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_188_7 = arg_185_1.actors_["1061"]
			local var_188_8 = 0

			if var_188_8 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps1061 == nil then
				arg_185_1.var_.actorSpriteComps1061 = var_188_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_9 = 0.034

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_9 and not isNil(var_188_7) then
				local var_188_10 = (arg_185_1.time_ - var_188_8) / var_188_9

				if arg_185_1.var_.actorSpriteComps1061 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_188_2 then
							if arg_185_1.isInRecall_ then
								local var_188_11 = Mathf.Lerp(iter_188_2.color.r, arg_185_1.hightColor1.r, var_188_10)
								local var_188_12 = Mathf.Lerp(iter_188_2.color.g, arg_185_1.hightColor1.g, var_188_10)
								local var_188_13 = Mathf.Lerp(iter_188_2.color.b, arg_185_1.hightColor1.b, var_188_10)

								iter_188_2.color = Color.New(var_188_11, var_188_12, var_188_13)
							else
								local var_188_14 = Mathf.Lerp(iter_188_2.color.r, 1, var_188_10)

								iter_188_2.color = Color.New(var_188_14, var_188_14, var_188_14)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_8 + var_188_9 and arg_185_1.time_ < var_188_8 + var_188_9 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps1061 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_188_4 then
						if arg_185_1.isInRecall_ then
							iter_188_4.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps1061 = nil
			end

			local var_188_15 = 0
			local var_188_16 = 0.75

			if var_188_15 < arg_185_1.time_ and arg_185_1.time_ <= var_188_15 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_17 = arg_185_1:FormatText(StoryNameCfg[612].name)

				arg_185_1.leftNameTxt_.text = var_188_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_18 = arg_185_1:GetWordFromCfg(410241046)
				local var_188_19 = arg_185_1:FormatText(var_188_18.content)

				arg_185_1.text_.text = var_188_19

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_20 = 30
				local var_188_21 = utf8.len(var_188_19)
				local var_188_22 = var_188_20 <= 0 and var_188_16 or var_188_16 * (var_188_21 / var_188_20)

				if var_188_22 > 0 and var_188_16 < var_188_22 then
					arg_185_1.talkMaxDuration = var_188_22

					if var_188_22 + var_188_15 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_22 + var_188_15
					end
				end

				arg_185_1.text_.text = var_188_19
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241046", "story_v_out_410241.awb") ~= 0 then
					local var_188_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241046", "story_v_out_410241.awb") / 1000

					if var_188_23 + var_188_15 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_23 + var_188_15
					end

					if var_188_18.prefab_name ~= "" and arg_185_1.actors_[var_188_18.prefab_name] ~= nil then
						local var_188_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_18.prefab_name].transform, "story_v_out_410241", "410241046", "story_v_out_410241.awb")

						arg_185_1:RecordAudio("410241046", var_188_24)
						arg_185_1:RecordAudio("410241046", var_188_24)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_410241", "410241046", "story_v_out_410241.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_410241", "410241046", "story_v_out_410241.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_25 = math.max(var_188_16, arg_185_1.talkMaxDuration)

			if var_188_15 <= arg_185_1.time_ and arg_185_1.time_ < var_188_15 + var_188_25 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_15) / var_188_25

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_15 + var_188_25 and arg_185_1.time_ < var_188_15 + var_188_25 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play410241047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410241047
		arg_189_1.duration_ = 5.7

		local var_189_0 = {
			ja = 5.7,
			CriLanguages = 2.4,
			zh = 2.4
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
				arg_189_0:Play410241048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1061"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1061 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1061", 3)

				local var_192_2 = var_192_0.childCount

				for iter_192_0 = 0, var_192_2 - 1 do
					local var_192_3 = var_192_0:GetChild(iter_192_0)

					if var_192_3.name == "split_9" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_4 then
				local var_192_5 = (arg_189_1.time_ - var_192_1) / var_192_4
				local var_192_6 = Vector3.New(0, -490, 18)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1061, var_192_6, var_192_5)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_4 and arg_189_1.time_ < var_192_1 + var_192_4 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_192_7 = arg_189_1.actors_["1061"]
			local var_192_8 = 0

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps1061 == nil then
				arg_189_1.var_.actorSpriteComps1061 = var_192_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_9 = 0.034

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_9 and not isNil(var_192_7) then
				local var_192_10 = (arg_189_1.time_ - var_192_8) / var_192_9

				if arg_189_1.var_.actorSpriteComps1061 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_192_2 then
							if arg_189_1.isInRecall_ then
								local var_192_11 = Mathf.Lerp(iter_192_2.color.r, arg_189_1.hightColor1.r, var_192_10)
								local var_192_12 = Mathf.Lerp(iter_192_2.color.g, arg_189_1.hightColor1.g, var_192_10)
								local var_192_13 = Mathf.Lerp(iter_192_2.color.b, arg_189_1.hightColor1.b, var_192_10)

								iter_192_2.color = Color.New(var_192_11, var_192_12, var_192_13)
							else
								local var_192_14 = Mathf.Lerp(iter_192_2.color.r, 1, var_192_10)

								iter_192_2.color = Color.New(var_192_14, var_192_14, var_192_14)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_8 + var_192_9 and arg_189_1.time_ < var_192_8 + var_192_9 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps1061 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_192_4 then
						if arg_189_1.isInRecall_ then
							iter_192_4.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps1061 = nil
			end

			local var_192_15 = 0
			local var_192_16 = 0.325

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_17 = arg_189_1:FormatText(StoryNameCfg[612].name)

				arg_189_1.leftNameTxt_.text = var_192_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:GetWordFromCfg(410241047)
				local var_192_19 = arg_189_1:FormatText(var_192_18.content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 13
				local var_192_21 = utf8.len(var_192_19)
				local var_192_22 = var_192_20 <= 0 and var_192_16 or var_192_16 * (var_192_21 / var_192_20)

				if var_192_22 > 0 and var_192_16 < var_192_22 then
					arg_189_1.talkMaxDuration = var_192_22

					if var_192_22 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_22 + var_192_15
					end
				end

				arg_189_1.text_.text = var_192_19
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241047", "story_v_out_410241.awb") ~= 0 then
					local var_192_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241047", "story_v_out_410241.awb") / 1000

					if var_192_23 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_23 + var_192_15
					end

					if var_192_18.prefab_name ~= "" and arg_189_1.actors_[var_192_18.prefab_name] ~= nil then
						local var_192_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_18.prefab_name].transform, "story_v_out_410241", "410241047", "story_v_out_410241.awb")

						arg_189_1:RecordAudio("410241047", var_192_24)
						arg_189_1:RecordAudio("410241047", var_192_24)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_410241", "410241047", "story_v_out_410241.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_410241", "410241047", "story_v_out_410241.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_25 = math.max(var_192_16, arg_189_1.talkMaxDuration)

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_25 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_15) / var_192_25

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_15 + var_192_25 and arg_189_1.time_ < var_192_15 + var_192_25 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play410241048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410241048
		arg_193_1.duration_ = 9

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play410241049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 2

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				local var_196_1 = manager.ui.mainCamera.transform.localPosition
				local var_196_2 = Vector3.New(0, 0, 10) + Vector3.New(var_196_1.x, var_196_1.y, 0)
				local var_196_3 = arg_193_1.bgs_.ST67

				var_196_3.transform.localPosition = var_196_2
				var_196_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_4 = var_196_3:GetComponent("SpriteRenderer")

				if var_196_4 and var_196_4.sprite then
					local var_196_5 = (var_196_3.transform.localPosition - var_196_1).z
					local var_196_6 = manager.ui.mainCameraCom_
					local var_196_7 = 2 * var_196_5 * Mathf.Tan(var_196_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_196_8 = var_196_7 * var_196_6.aspect
					local var_196_9 = var_196_4.sprite.bounds.size.x
					local var_196_10 = var_196_4.sprite.bounds.size.y
					local var_196_11 = var_196_8 / var_196_9
					local var_196_12 = var_196_7 / var_196_10
					local var_196_13 = var_196_12 < var_196_11 and var_196_11 or var_196_12

					var_196_3.transform.localScale = Vector3.New(var_196_13, var_196_13, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "ST67" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_14 = 0

			if var_196_14 < arg_193_1.time_ and arg_193_1.time_ <= var_196_14 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_15 = 2

			if var_196_14 <= arg_193_1.time_ and arg_193_1.time_ < var_196_14 + var_196_15 then
				local var_196_16 = (arg_193_1.time_ - var_196_14) / var_196_15
				local var_196_17 = Color.New(0, 0, 0)

				var_196_17.a = Mathf.Lerp(0, 1, var_196_16)
				arg_193_1.mask_.color = var_196_17
			end

			if arg_193_1.time_ >= var_196_14 + var_196_15 and arg_193_1.time_ < var_196_14 + var_196_15 + arg_196_0 then
				local var_196_18 = Color.New(0, 0, 0)

				var_196_18.a = 1
				arg_193_1.mask_.color = var_196_18
			end

			local var_196_19 = 2

			if var_196_19 < arg_193_1.time_ and arg_193_1.time_ <= var_196_19 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_20 = 2

			if var_196_19 <= arg_193_1.time_ and arg_193_1.time_ < var_196_19 + var_196_20 then
				local var_196_21 = (arg_193_1.time_ - var_196_19) / var_196_20
				local var_196_22 = Color.New(0, 0, 0)

				var_196_22.a = Mathf.Lerp(1, 0, var_196_21)
				arg_193_1.mask_.color = var_196_22
			end

			if arg_193_1.time_ >= var_196_19 + var_196_20 and arg_193_1.time_ < var_196_19 + var_196_20 + arg_196_0 then
				local var_196_23 = Color.New(0, 0, 0)
				local var_196_24 = 0

				arg_193_1.mask_.enabled = false
				var_196_23.a = var_196_24
				arg_193_1.mask_.color = var_196_23
			end

			local var_196_25 = arg_193_1.actors_["1061"].transform
			local var_196_26 = 2

			if var_196_26 < arg_193_1.time_ and arg_193_1.time_ <= var_196_26 + arg_196_0 then
				arg_193_1.var_.moveOldPos1061 = var_196_25.localPosition
				var_196_25.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1061", 7)

				local var_196_27 = var_196_25.childCount

				for iter_196_2 = 0, var_196_27 - 1 do
					local var_196_28 = var_196_25:GetChild(iter_196_2)

					if var_196_28.name == "" or not string.find(var_196_28.name, "split") then
						var_196_28.gameObject:SetActive(true)
					else
						var_196_28.gameObject:SetActive(false)
					end
				end
			end

			local var_196_29 = 0.001

			if var_196_26 <= arg_193_1.time_ and arg_193_1.time_ < var_196_26 + var_196_29 then
				local var_196_30 = (arg_193_1.time_ - var_196_26) / var_196_29
				local var_196_31 = Vector3.New(0, -2000, 18)

				var_196_25.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1061, var_196_31, var_196_30)
			end

			if arg_193_1.time_ >= var_196_26 + var_196_29 and arg_193_1.time_ < var_196_26 + var_196_29 + arg_196_0 then
				var_196_25.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_196_32 = arg_193_1.actors_["1061"]
			local var_196_33 = 2

			if var_196_33 < arg_193_1.time_ and arg_193_1.time_ <= var_196_33 + arg_196_0 and not isNil(var_196_32) and arg_193_1.var_.actorSpriteComps1061 == nil then
				arg_193_1.var_.actorSpriteComps1061 = var_196_32:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_34 = 0.034

			if var_196_33 <= arg_193_1.time_ and arg_193_1.time_ < var_196_33 + var_196_34 and not isNil(var_196_32) then
				local var_196_35 = (arg_193_1.time_ - var_196_33) / var_196_34

				if arg_193_1.var_.actorSpriteComps1061 then
					for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_196_4 then
							if arg_193_1.isInRecall_ then
								local var_196_36 = Mathf.Lerp(iter_196_4.color.r, arg_193_1.hightColor2.r, var_196_35)
								local var_196_37 = Mathf.Lerp(iter_196_4.color.g, arg_193_1.hightColor2.g, var_196_35)
								local var_196_38 = Mathf.Lerp(iter_196_4.color.b, arg_193_1.hightColor2.b, var_196_35)

								iter_196_4.color = Color.New(var_196_36, var_196_37, var_196_38)
							else
								local var_196_39 = Mathf.Lerp(iter_196_4.color.r, 0.5, var_196_35)

								iter_196_4.color = Color.New(var_196_39, var_196_39, var_196_39)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_33 + var_196_34 and arg_193_1.time_ < var_196_33 + var_196_34 + arg_196_0 and not isNil(var_196_32) and arg_193_1.var_.actorSpriteComps1061 then
				for iter_196_5, iter_196_6 in pairs(arg_193_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_196_6 then
						if arg_193_1.isInRecall_ then
							iter_196_6.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps1061 = nil
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_40 = 4
			local var_196_41 = 1.35

			if var_196_40 < arg_193_1.time_ and arg_193_1.time_ <= var_196_40 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_42 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_42:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_43 = arg_193_1:GetWordFromCfg(410241048)
				local var_196_44 = arg_193_1:FormatText(var_196_43.content)

				arg_193_1.text_.text = var_196_44

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_45 = 54
				local var_196_46 = utf8.len(var_196_44)
				local var_196_47 = var_196_45 <= 0 and var_196_41 or var_196_41 * (var_196_46 / var_196_45)

				if var_196_47 > 0 and var_196_41 < var_196_47 then
					arg_193_1.talkMaxDuration = var_196_47
					var_196_40 = var_196_40 + 0.3

					if var_196_47 + var_196_40 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_47 + var_196_40
					end
				end

				arg_193_1.text_.text = var_196_44
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_48 = var_196_40 + 0.3
			local var_196_49 = math.max(var_196_41, arg_193_1.talkMaxDuration)

			if var_196_48 <= arg_193_1.time_ and arg_193_1.time_ < var_196_48 + var_196_49 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_48) / var_196_49

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_48 + var_196_49 and arg_193_1.time_ < var_196_48 + var_196_49 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play410241049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 410241049
		arg_199_1.duration_ = 2.7

		local var_199_0 = {
			ja = 2.7,
			CriLanguages = 1.2,
			zh = 1.2
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play410241050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1061"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos1061 = var_202_0.localPosition
				var_202_0.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("1061", 3)

				local var_202_2 = var_202_0.childCount

				for iter_202_0 = 0, var_202_2 - 1 do
					local var_202_3 = var_202_0:GetChild(iter_202_0)

					if var_202_3.name == "" or not string.find(var_202_3.name, "split") then
						var_202_3.gameObject:SetActive(true)
					else
						var_202_3.gameObject:SetActive(false)
					end
				end
			end

			local var_202_4 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_4 then
				local var_202_5 = (arg_199_1.time_ - var_202_1) / var_202_4
				local var_202_6 = Vector3.New(0, -490, 18)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1061, var_202_6, var_202_5)
			end

			if arg_199_1.time_ >= var_202_1 + var_202_4 and arg_199_1.time_ < var_202_1 + var_202_4 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_202_7 = arg_199_1.actors_["1061"]
			local var_202_8 = 0

			if var_202_8 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 and not isNil(var_202_7) and arg_199_1.var_.actorSpriteComps1061 == nil then
				arg_199_1.var_.actorSpriteComps1061 = var_202_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_9 = 0.034

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_9 and not isNil(var_202_7) then
				local var_202_10 = (arg_199_1.time_ - var_202_8) / var_202_9

				if arg_199_1.var_.actorSpriteComps1061 then
					for iter_202_1, iter_202_2 in pairs(arg_199_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_202_2 then
							if arg_199_1.isInRecall_ then
								local var_202_11 = Mathf.Lerp(iter_202_2.color.r, arg_199_1.hightColor1.r, var_202_10)
								local var_202_12 = Mathf.Lerp(iter_202_2.color.g, arg_199_1.hightColor1.g, var_202_10)
								local var_202_13 = Mathf.Lerp(iter_202_2.color.b, arg_199_1.hightColor1.b, var_202_10)

								iter_202_2.color = Color.New(var_202_11, var_202_12, var_202_13)
							else
								local var_202_14 = Mathf.Lerp(iter_202_2.color.r, 1, var_202_10)

								iter_202_2.color = Color.New(var_202_14, var_202_14, var_202_14)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_8 + var_202_9 and arg_199_1.time_ < var_202_8 + var_202_9 + arg_202_0 and not isNil(var_202_7) and arg_199_1.var_.actorSpriteComps1061 then
				for iter_202_3, iter_202_4 in pairs(arg_199_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_202_4 then
						if arg_199_1.isInRecall_ then
							iter_202_4.color = arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_202_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps1061 = nil
			end

			local var_202_15 = 0
			local var_202_16 = 0.15

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_17 = arg_199_1:FormatText(StoryNameCfg[612].name)

				arg_199_1.leftNameTxt_.text = var_202_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_18 = arg_199_1:GetWordFromCfg(410241049)
				local var_202_19 = arg_199_1:FormatText(var_202_18.content)

				arg_199_1.text_.text = var_202_19

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_20 = 6
				local var_202_21 = utf8.len(var_202_19)
				local var_202_22 = var_202_20 <= 0 and var_202_16 or var_202_16 * (var_202_21 / var_202_20)

				if var_202_22 > 0 and var_202_16 < var_202_22 then
					arg_199_1.talkMaxDuration = var_202_22

					if var_202_22 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_22 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_19
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241049", "story_v_out_410241.awb") ~= 0 then
					local var_202_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241049", "story_v_out_410241.awb") / 1000

					if var_202_23 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_23 + var_202_15
					end

					if var_202_18.prefab_name ~= "" and arg_199_1.actors_[var_202_18.prefab_name] ~= nil then
						local var_202_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_18.prefab_name].transform, "story_v_out_410241", "410241049", "story_v_out_410241.awb")

						arg_199_1:RecordAudio("410241049", var_202_24)
						arg_199_1:RecordAudio("410241049", var_202_24)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_410241", "410241049", "story_v_out_410241.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_410241", "410241049", "story_v_out_410241.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_25 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_25 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_25

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_25 and arg_199_1.time_ < var_202_15 + var_202_25 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play410241050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 410241050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play410241051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1061"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps1061 == nil then
				arg_203_1.var_.actorSpriteComps1061 = var_206_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_2 = 0.034

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.actorSpriteComps1061 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								local var_206_4 = Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor2.r, var_206_3)
								local var_206_5 = Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor2.g, var_206_3)
								local var_206_6 = Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor2.b, var_206_3)

								iter_206_1.color = Color.New(var_206_4, var_206_5, var_206_6)
							else
								local var_206_7 = Mathf.Lerp(iter_206_1.color.r, 0.5, var_206_3)

								iter_206_1.color = Color.New(var_206_7, var_206_7, var_206_7)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps1061 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_206_3 then
						if arg_203_1.isInRecall_ then
							iter_206_3.color = arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_206_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps1061 = nil
			end

			local var_206_8 = 0
			local var_206_9 = 1.15

			if var_206_8 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_10 = arg_203_1:GetWordFromCfg(410241050)
				local var_206_11 = arg_203_1:FormatText(var_206_10.content)

				arg_203_1.text_.text = var_206_11

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_12 = 46
				local var_206_13 = utf8.len(var_206_11)
				local var_206_14 = var_206_12 <= 0 and var_206_9 or var_206_9 * (var_206_13 / var_206_12)

				if var_206_14 > 0 and var_206_9 < var_206_14 then
					arg_203_1.talkMaxDuration = var_206_14

					if var_206_14 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_14 + var_206_8
					end
				end

				arg_203_1.text_.text = var_206_11
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_15 = math.max(var_206_9, arg_203_1.talkMaxDuration)

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_15 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_8) / var_206_15

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_8 + var_206_15 and arg_203_1.time_ < var_206_8 + var_206_15 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play410241051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 410241051
		arg_207_1.duration_ = 20.23

		local var_207_0 = {
			ja = 20.233,
			CriLanguages = 14.033,
			zh = 14.033
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play410241052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1061"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1061 = var_210_0.localPosition
				var_210_0.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("1061", 3)

				local var_210_2 = var_210_0.childCount

				for iter_210_0 = 0, var_210_2 - 1 do
					local var_210_3 = var_210_0:GetChild(iter_210_0)

					if var_210_3.name == "" or not string.find(var_210_3.name, "split") then
						var_210_3.gameObject:SetActive(true)
					else
						var_210_3.gameObject:SetActive(false)
					end
				end
			end

			local var_210_4 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_4 then
				local var_210_5 = (arg_207_1.time_ - var_210_1) / var_210_4
				local var_210_6 = Vector3.New(0, -490, 18)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1061, var_210_6, var_210_5)
			end

			if arg_207_1.time_ >= var_210_1 + var_210_4 and arg_207_1.time_ < var_210_1 + var_210_4 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_210_7 = arg_207_1.actors_["1061"]
			local var_210_8 = 0

			if var_210_8 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 and not isNil(var_210_7) and arg_207_1.var_.actorSpriteComps1061 == nil then
				arg_207_1.var_.actorSpriteComps1061 = var_210_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_9 = 0.034

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_9 and not isNil(var_210_7) then
				local var_210_10 = (arg_207_1.time_ - var_210_8) / var_210_9

				if arg_207_1.var_.actorSpriteComps1061 then
					for iter_210_1, iter_210_2 in pairs(arg_207_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_210_2 then
							if arg_207_1.isInRecall_ then
								local var_210_11 = Mathf.Lerp(iter_210_2.color.r, arg_207_1.hightColor1.r, var_210_10)
								local var_210_12 = Mathf.Lerp(iter_210_2.color.g, arg_207_1.hightColor1.g, var_210_10)
								local var_210_13 = Mathf.Lerp(iter_210_2.color.b, arg_207_1.hightColor1.b, var_210_10)

								iter_210_2.color = Color.New(var_210_11, var_210_12, var_210_13)
							else
								local var_210_14 = Mathf.Lerp(iter_210_2.color.r, 1, var_210_10)

								iter_210_2.color = Color.New(var_210_14, var_210_14, var_210_14)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_8 + var_210_9 and arg_207_1.time_ < var_210_8 + var_210_9 + arg_210_0 and not isNil(var_210_7) and arg_207_1.var_.actorSpriteComps1061 then
				for iter_210_3, iter_210_4 in pairs(arg_207_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_210_4 then
						if arg_207_1.isInRecall_ then
							iter_210_4.color = arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_210_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps1061 = nil
			end

			local var_210_15 = 0
			local var_210_16 = 1.2

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_17 = arg_207_1:FormatText(StoryNameCfg[612].name)

				arg_207_1.leftNameTxt_.text = var_210_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_18 = arg_207_1:GetWordFromCfg(410241051)
				local var_210_19 = arg_207_1:FormatText(var_210_18.content)

				arg_207_1.text_.text = var_210_19

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_20 = 48
				local var_210_21 = utf8.len(var_210_19)
				local var_210_22 = var_210_20 <= 0 and var_210_16 or var_210_16 * (var_210_21 / var_210_20)

				if var_210_22 > 0 and var_210_16 < var_210_22 then
					arg_207_1.talkMaxDuration = var_210_22

					if var_210_22 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_22 + var_210_15
					end
				end

				arg_207_1.text_.text = var_210_19
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241051", "story_v_out_410241.awb") ~= 0 then
					local var_210_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241051", "story_v_out_410241.awb") / 1000

					if var_210_23 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_23 + var_210_15
					end

					if var_210_18.prefab_name ~= "" and arg_207_1.actors_[var_210_18.prefab_name] ~= nil then
						local var_210_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_18.prefab_name].transform, "story_v_out_410241", "410241051", "story_v_out_410241.awb")

						arg_207_1:RecordAudio("410241051", var_210_24)
						arg_207_1:RecordAudio("410241051", var_210_24)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_410241", "410241051", "story_v_out_410241.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_410241", "410241051", "story_v_out_410241.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_25 = math.max(var_210_16, arg_207_1.talkMaxDuration)

			if var_210_15 <= arg_207_1.time_ and arg_207_1.time_ < var_210_15 + var_210_25 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_15) / var_210_25

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_15 + var_210_25 and arg_207_1.time_ < var_210_15 + var_210_25 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play410241052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 410241052
		arg_211_1.duration_ = 6.37

		local var_211_0 = {
			ja = 6.2,
			CriLanguages = 6.366,
			zh = 6.366
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play410241053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1061"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1061 = var_214_0.localPosition
				var_214_0.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("1061", 3)

				local var_214_2 = var_214_0.childCount

				for iter_214_0 = 0, var_214_2 - 1 do
					local var_214_3 = var_214_0:GetChild(iter_214_0)

					if var_214_3.name == "" or not string.find(var_214_3.name, "split") then
						var_214_3.gameObject:SetActive(true)
					else
						var_214_3.gameObject:SetActive(false)
					end
				end
			end

			local var_214_4 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_4 then
				local var_214_5 = (arg_211_1.time_ - var_214_1) / var_214_4
				local var_214_6 = Vector3.New(0, -490, 18)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1061, var_214_6, var_214_5)
			end

			if arg_211_1.time_ >= var_214_1 + var_214_4 and arg_211_1.time_ < var_214_1 + var_214_4 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_214_7 = arg_211_1.actors_["1061"]
			local var_214_8 = 0

			if var_214_8 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 and not isNil(var_214_7) and arg_211_1.var_.actorSpriteComps1061 == nil then
				arg_211_1.var_.actorSpriteComps1061 = var_214_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_9 = 0.034

			if var_214_8 <= arg_211_1.time_ and arg_211_1.time_ < var_214_8 + var_214_9 and not isNil(var_214_7) then
				local var_214_10 = (arg_211_1.time_ - var_214_8) / var_214_9

				if arg_211_1.var_.actorSpriteComps1061 then
					for iter_214_1, iter_214_2 in pairs(arg_211_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_214_2 then
							if arg_211_1.isInRecall_ then
								local var_214_11 = Mathf.Lerp(iter_214_2.color.r, arg_211_1.hightColor1.r, var_214_10)
								local var_214_12 = Mathf.Lerp(iter_214_2.color.g, arg_211_1.hightColor1.g, var_214_10)
								local var_214_13 = Mathf.Lerp(iter_214_2.color.b, arg_211_1.hightColor1.b, var_214_10)

								iter_214_2.color = Color.New(var_214_11, var_214_12, var_214_13)
							else
								local var_214_14 = Mathf.Lerp(iter_214_2.color.r, 1, var_214_10)

								iter_214_2.color = Color.New(var_214_14, var_214_14, var_214_14)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_8 + var_214_9 and arg_211_1.time_ < var_214_8 + var_214_9 + arg_214_0 and not isNil(var_214_7) and arg_211_1.var_.actorSpriteComps1061 then
				for iter_214_3, iter_214_4 in pairs(arg_211_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_214_4 then
						if arg_211_1.isInRecall_ then
							iter_214_4.color = arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_214_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps1061 = nil
			end

			local var_214_15 = 0
			local var_214_16 = 0.55

			if var_214_15 < arg_211_1.time_ and arg_211_1.time_ <= var_214_15 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_17 = arg_211_1:FormatText(StoryNameCfg[612].name)

				arg_211_1.leftNameTxt_.text = var_214_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_18 = arg_211_1:GetWordFromCfg(410241052)
				local var_214_19 = arg_211_1:FormatText(var_214_18.content)

				arg_211_1.text_.text = var_214_19

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_20 = 22
				local var_214_21 = utf8.len(var_214_19)
				local var_214_22 = var_214_20 <= 0 and var_214_16 or var_214_16 * (var_214_21 / var_214_20)

				if var_214_22 > 0 and var_214_16 < var_214_22 then
					arg_211_1.talkMaxDuration = var_214_22

					if var_214_22 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_22 + var_214_15
					end
				end

				arg_211_1.text_.text = var_214_19
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241052", "story_v_out_410241.awb") ~= 0 then
					local var_214_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241052", "story_v_out_410241.awb") / 1000

					if var_214_23 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_23 + var_214_15
					end

					if var_214_18.prefab_name ~= "" and arg_211_1.actors_[var_214_18.prefab_name] ~= nil then
						local var_214_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_18.prefab_name].transform, "story_v_out_410241", "410241052", "story_v_out_410241.awb")

						arg_211_1:RecordAudio("410241052", var_214_24)
						arg_211_1:RecordAudio("410241052", var_214_24)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_410241", "410241052", "story_v_out_410241.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_410241", "410241052", "story_v_out_410241.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_25 = math.max(var_214_16, arg_211_1.talkMaxDuration)

			if var_214_15 <= arg_211_1.time_ and arg_211_1.time_ < var_214_15 + var_214_25 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_15) / var_214_25

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_15 + var_214_25 and arg_211_1.time_ < var_214_15 + var_214_25 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play410241053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 410241053
		arg_215_1.duration_ = 5.23

		local var_215_0 = {
			ja = 5.233,
			CriLanguages = 3.766,
			zh = 3.766
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play410241054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1061"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos1061 = var_218_0.localPosition
				var_218_0.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1061", 3)

				local var_218_2 = var_218_0.childCount

				for iter_218_0 = 0, var_218_2 - 1 do
					local var_218_3 = var_218_0:GetChild(iter_218_0)

					if var_218_3.name == "split_5" or not string.find(var_218_3.name, "split") then
						var_218_3.gameObject:SetActive(true)
					else
						var_218_3.gameObject:SetActive(false)
					end
				end
			end

			local var_218_4 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_4 then
				local var_218_5 = (arg_215_1.time_ - var_218_1) / var_218_4
				local var_218_6 = Vector3.New(0, -490, 18)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1061, var_218_6, var_218_5)
			end

			if arg_215_1.time_ >= var_218_1 + var_218_4 and arg_215_1.time_ < var_218_1 + var_218_4 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_218_7 = arg_215_1.actors_["1061"]
			local var_218_8 = 0

			if var_218_8 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 and not isNil(var_218_7) and arg_215_1.var_.actorSpriteComps1061 == nil then
				arg_215_1.var_.actorSpriteComps1061 = var_218_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_9 = 0.034

			if var_218_8 <= arg_215_1.time_ and arg_215_1.time_ < var_218_8 + var_218_9 and not isNil(var_218_7) then
				local var_218_10 = (arg_215_1.time_ - var_218_8) / var_218_9

				if arg_215_1.var_.actorSpriteComps1061 then
					for iter_218_1, iter_218_2 in pairs(arg_215_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_218_2 then
							if arg_215_1.isInRecall_ then
								local var_218_11 = Mathf.Lerp(iter_218_2.color.r, arg_215_1.hightColor1.r, var_218_10)
								local var_218_12 = Mathf.Lerp(iter_218_2.color.g, arg_215_1.hightColor1.g, var_218_10)
								local var_218_13 = Mathf.Lerp(iter_218_2.color.b, arg_215_1.hightColor1.b, var_218_10)

								iter_218_2.color = Color.New(var_218_11, var_218_12, var_218_13)
							else
								local var_218_14 = Mathf.Lerp(iter_218_2.color.r, 1, var_218_10)

								iter_218_2.color = Color.New(var_218_14, var_218_14, var_218_14)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_8 + var_218_9 and arg_215_1.time_ < var_218_8 + var_218_9 + arg_218_0 and not isNil(var_218_7) and arg_215_1.var_.actorSpriteComps1061 then
				for iter_218_3, iter_218_4 in pairs(arg_215_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_218_4 then
						if arg_215_1.isInRecall_ then
							iter_218_4.color = arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_218_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps1061 = nil
			end

			local var_218_15 = 0
			local var_218_16 = 0.25

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_17 = arg_215_1:FormatText(StoryNameCfg[612].name)

				arg_215_1.leftNameTxt_.text = var_218_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_18 = arg_215_1:GetWordFromCfg(410241053)
				local var_218_19 = arg_215_1:FormatText(var_218_18.content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_20 = 10
				local var_218_21 = utf8.len(var_218_19)
				local var_218_22 = var_218_20 <= 0 and var_218_16 or var_218_16 * (var_218_21 / var_218_20)

				if var_218_22 > 0 and var_218_16 < var_218_22 then
					arg_215_1.talkMaxDuration = var_218_22

					if var_218_22 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_22 + var_218_15
					end
				end

				arg_215_1.text_.text = var_218_19
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241053", "story_v_out_410241.awb") ~= 0 then
					local var_218_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241053", "story_v_out_410241.awb") / 1000

					if var_218_23 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_23 + var_218_15
					end

					if var_218_18.prefab_name ~= "" and arg_215_1.actors_[var_218_18.prefab_name] ~= nil then
						local var_218_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_18.prefab_name].transform, "story_v_out_410241", "410241053", "story_v_out_410241.awb")

						arg_215_1:RecordAudio("410241053", var_218_24)
						arg_215_1:RecordAudio("410241053", var_218_24)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_410241", "410241053", "story_v_out_410241.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_410241", "410241053", "story_v_out_410241.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_25 = math.max(var_218_16, arg_215_1.talkMaxDuration)

			if var_218_15 <= arg_215_1.time_ and arg_215_1.time_ < var_218_15 + var_218_25 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_15) / var_218_25

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_15 + var_218_25 and arg_215_1.time_ < var_218_15 + var_218_25 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play410241054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 410241054
		arg_219_1.duration_ = 9

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play410241055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = "LZ0206"

			if arg_219_1.bgs_[var_222_0] == nil then
				local var_222_1 = Object.Instantiate(arg_219_1.paintGo_)

				var_222_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_222_0)
				var_222_1.name = var_222_0
				var_222_1.transform.parent = arg_219_1.stage_.transform
				var_222_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.bgs_[var_222_0] = var_222_1
			end

			local var_222_2 = 2

			if var_222_2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				local var_222_3 = manager.ui.mainCamera.transform.localPosition
				local var_222_4 = Vector3.New(0, 0, 10) + Vector3.New(var_222_3.x, var_222_3.y, 0)
				local var_222_5 = arg_219_1.bgs_.LZ0206

				var_222_5.transform.localPosition = var_222_4
				var_222_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_6 = var_222_5:GetComponent("SpriteRenderer")

				if var_222_6 and var_222_6.sprite then
					local var_222_7 = (var_222_5.transform.localPosition - var_222_3).z
					local var_222_8 = manager.ui.mainCameraCom_
					local var_222_9 = 2 * var_222_7 * Mathf.Tan(var_222_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_222_10 = var_222_9 * var_222_8.aspect
					local var_222_11 = var_222_6.sprite.bounds.size.x
					local var_222_12 = var_222_6.sprite.bounds.size.y
					local var_222_13 = var_222_10 / var_222_11
					local var_222_14 = var_222_9 / var_222_12
					local var_222_15 = var_222_14 < var_222_13 and var_222_13 or var_222_14

					var_222_5.transform.localScale = Vector3.New(var_222_15, var_222_15, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "LZ0206" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_16 = 0

			if var_222_16 < arg_219_1.time_ and arg_219_1.time_ <= var_222_16 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_17 = 2

			if var_222_16 <= arg_219_1.time_ and arg_219_1.time_ < var_222_16 + var_222_17 then
				local var_222_18 = (arg_219_1.time_ - var_222_16) / var_222_17
				local var_222_19 = Color.New(0, 0, 0)

				var_222_19.a = Mathf.Lerp(0, 1, var_222_18)
				arg_219_1.mask_.color = var_222_19
			end

			if arg_219_1.time_ >= var_222_16 + var_222_17 and arg_219_1.time_ < var_222_16 + var_222_17 + arg_222_0 then
				local var_222_20 = Color.New(0, 0, 0)

				var_222_20.a = 1
				arg_219_1.mask_.color = var_222_20
			end

			local var_222_21 = 2

			if var_222_21 < arg_219_1.time_ and arg_219_1.time_ <= var_222_21 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_22 = 2

			if var_222_21 <= arg_219_1.time_ and arg_219_1.time_ < var_222_21 + var_222_22 then
				local var_222_23 = (arg_219_1.time_ - var_222_21) / var_222_22
				local var_222_24 = Color.New(0, 0, 0)

				var_222_24.a = Mathf.Lerp(1, 0, var_222_23)
				arg_219_1.mask_.color = var_222_24
			end

			if arg_219_1.time_ >= var_222_21 + var_222_22 and arg_219_1.time_ < var_222_21 + var_222_22 + arg_222_0 then
				local var_222_25 = Color.New(0, 0, 0)
				local var_222_26 = 0

				arg_219_1.mask_.enabled = false
				var_222_25.a = var_222_26
				arg_219_1.mask_.color = var_222_25
			end

			local var_222_27 = arg_219_1.actors_["1061"].transform
			local var_222_28 = 2

			if var_222_28 < arg_219_1.time_ and arg_219_1.time_ <= var_222_28 + arg_222_0 then
				arg_219_1.var_.moveOldPos1061 = var_222_27.localPosition
				var_222_27.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("1061", 7)

				local var_222_29 = var_222_27.childCount

				for iter_222_2 = 0, var_222_29 - 1 do
					local var_222_30 = var_222_27:GetChild(iter_222_2)

					if var_222_30.name == "" or not string.find(var_222_30.name, "split") then
						var_222_30.gameObject:SetActive(true)
					else
						var_222_30.gameObject:SetActive(false)
					end
				end
			end

			local var_222_31 = 0.001

			if var_222_28 <= arg_219_1.time_ and arg_219_1.time_ < var_222_28 + var_222_31 then
				local var_222_32 = (arg_219_1.time_ - var_222_28) / var_222_31
				local var_222_33 = Vector3.New(0, -2000, 18)

				var_222_27.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1061, var_222_33, var_222_32)
			end

			if arg_219_1.time_ >= var_222_28 + var_222_31 and arg_219_1.time_ < var_222_28 + var_222_31 + arg_222_0 then
				var_222_27.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_222_34 = arg_219_1.actors_["1061"]
			local var_222_35 = 2

			if var_222_35 < arg_219_1.time_ and arg_219_1.time_ <= var_222_35 + arg_222_0 and not isNil(var_222_34) and arg_219_1.var_.actorSpriteComps1061 == nil then
				arg_219_1.var_.actorSpriteComps1061 = var_222_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_36 = 0.034

			if var_222_35 <= arg_219_1.time_ and arg_219_1.time_ < var_222_35 + var_222_36 and not isNil(var_222_34) then
				local var_222_37 = (arg_219_1.time_ - var_222_35) / var_222_36

				if arg_219_1.var_.actorSpriteComps1061 then
					for iter_222_3, iter_222_4 in pairs(arg_219_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_222_4 then
							if arg_219_1.isInRecall_ then
								local var_222_38 = Mathf.Lerp(iter_222_4.color.r, arg_219_1.hightColor2.r, var_222_37)
								local var_222_39 = Mathf.Lerp(iter_222_4.color.g, arg_219_1.hightColor2.g, var_222_37)
								local var_222_40 = Mathf.Lerp(iter_222_4.color.b, arg_219_1.hightColor2.b, var_222_37)

								iter_222_4.color = Color.New(var_222_38, var_222_39, var_222_40)
							else
								local var_222_41 = Mathf.Lerp(iter_222_4.color.r, 0.5, var_222_37)

								iter_222_4.color = Color.New(var_222_41, var_222_41, var_222_41)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= var_222_35 + var_222_36 and arg_219_1.time_ < var_222_35 + var_222_36 + arg_222_0 and not isNil(var_222_34) and arg_219_1.var_.actorSpriteComps1061 then
				for iter_222_5, iter_222_6 in pairs(arg_219_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_222_6 then
						if arg_219_1.isInRecall_ then
							iter_222_6.color = arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_222_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps1061 = nil
			end

			local var_222_42 = 0
			local var_222_43 = 0.166666666666667

			if var_222_42 < arg_219_1.time_ and arg_219_1.time_ <= var_222_42 + arg_222_0 then
				local var_222_44 = "play"
				local var_222_45 = "effect"

				arg_219_1:AudioAction(var_222_44, var_222_45, "se_story_129", "se_story_129_information_magic", "")
			end

			local var_222_46 = arg_219_1.bgs_.LZ0206.transform
			local var_222_47 = 2.034

			if var_222_47 < arg_219_1.time_ and arg_219_1.time_ <= var_222_47 + arg_222_0 then
				arg_219_1.var_.moveOldPosLZ0206 = var_222_46.localPosition
			end

			local var_222_48 = 0.001

			if var_222_47 <= arg_219_1.time_ and arg_219_1.time_ < var_222_47 + var_222_48 then
				local var_222_49 = (arg_219_1.time_ - var_222_47) / var_222_48
				local var_222_50 = Vector3.New(0, 1, 10)

				var_222_46.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPosLZ0206, var_222_50, var_222_49)
			end

			if arg_219_1.time_ >= var_222_47 + var_222_48 and arg_219_1.time_ < var_222_47 + var_222_48 + arg_222_0 then
				var_222_46.localPosition = Vector3.New(0, 1, 10)
			end

			local var_222_51 = arg_219_1.bgs_.LZ0206.transform
			local var_222_52 = 2.068

			if var_222_52 < arg_219_1.time_ and arg_219_1.time_ <= var_222_52 + arg_222_0 then
				arg_219_1.var_.moveOldPosLZ0206 = var_222_51.localPosition
			end

			local var_222_53 = 5

			if var_222_52 <= arg_219_1.time_ and arg_219_1.time_ < var_222_52 + var_222_53 then
				local var_222_54 = (arg_219_1.time_ - var_222_52) / var_222_53
				local var_222_55 = Vector3.New(0, 1, 9)

				var_222_51.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPosLZ0206, var_222_55, var_222_54)
			end

			if arg_219_1.time_ >= var_222_52 + var_222_53 and arg_219_1.time_ < var_222_52 + var_222_53 + arg_222_0 then
				var_222_51.localPosition = Vector3.New(0, 1, 9)
			end

			local var_222_56 = 4

			if var_222_56 < arg_219_1.time_ and arg_219_1.time_ <= var_222_56 + arg_222_0 then
				arg_219_1.allBtn_.enabled = false
			end

			local var_222_57 = 3.068

			if arg_219_1.time_ >= var_222_56 + var_222_57 and arg_219_1.time_ < var_222_56 + var_222_57 + arg_222_0 then
				arg_219_1.allBtn_.enabled = true
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_58 = 4
			local var_222_59 = 1.7

			if var_222_58 < arg_219_1.time_ and arg_219_1.time_ <= var_222_58 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_60 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_60:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_61 = arg_219_1:GetWordFromCfg(410241054)
				local var_222_62 = arg_219_1:FormatText(var_222_61.content)

				arg_219_1.text_.text = var_222_62

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_63 = 68
				local var_222_64 = utf8.len(var_222_62)
				local var_222_65 = var_222_63 <= 0 and var_222_59 or var_222_59 * (var_222_64 / var_222_63)

				if var_222_65 > 0 and var_222_59 < var_222_65 then
					arg_219_1.talkMaxDuration = var_222_65
					var_222_58 = var_222_58 + 0.3

					if var_222_65 + var_222_58 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_65 + var_222_58
					end
				end

				arg_219_1.text_.text = var_222_62
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_66 = var_222_58 + 0.3
			local var_222_67 = math.max(var_222_59, arg_219_1.talkMaxDuration)

			if var_222_66 <= arg_219_1.time_ and arg_219_1.time_ < var_222_66 + var_222_67 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_66) / var_222_67

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_66 + var_222_67 and arg_219_1.time_ < var_222_66 + var_222_67 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "LZ0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "LZ0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.068,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play410241055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410241055
		arg_225_1.duration_ = 14.3

		local var_225_0 = {
			ja = 14.3,
			CriLanguages = 11.7,
			zh = 11.7
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
				arg_225_0:Play410241056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.875

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[612].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_3 = arg_225_1:GetWordFromCfg(410241055)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241055", "story_v_out_410241.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_410241", "410241055", "story_v_out_410241.awb") / 1000

					if var_228_8 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_0
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_410241", "410241055", "story_v_out_410241.awb")

						arg_225_1:RecordAudio("410241055", var_228_9)
						arg_225_1:RecordAudio("410241055", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_410241", "410241055", "story_v_out_410241.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_410241", "410241055", "story_v_out_410241.awb")
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
	Play410241056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410241056
		arg_229_1.duration_ = 6.8

		local var_229_0 = {
			ja = 6.8,
			CriLanguages = 6.5,
			zh = 6.5
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
				arg_229_0:Play410241057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.575

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[612].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:GetWordFromCfg(410241056)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241056", "story_v_out_410241.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_410241", "410241056", "story_v_out_410241.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_410241", "410241056", "story_v_out_410241.awb")

						arg_229_1:RecordAudio("410241056", var_232_9)
						arg_229_1:RecordAudio("410241056", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_410241", "410241056", "story_v_out_410241.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_410241", "410241056", "story_v_out_410241.awb")
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
	Play410241057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410241057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play410241058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 1.625

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

				local var_236_2 = arg_233_1:GetWordFromCfg(410241057)
				local var_236_3 = arg_233_1:FormatText(var_236_2.content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 65
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
	Play410241058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410241058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play410241059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 1.45

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_2 = arg_237_1:GetWordFromCfg(410241058)
				local var_240_3 = arg_237_1:FormatText(var_240_2.content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 58
				local var_240_5 = utf8.len(var_240_3)
				local var_240_6 = var_240_4 <= 0 and var_240_1 or var_240_1 * (var_240_5 / var_240_4)

				if var_240_6 > 0 and var_240_1 < var_240_6 then
					arg_237_1.talkMaxDuration = var_240_6

					if var_240_6 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_7 and arg_237_1.time_ < var_240_0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play410241059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410241059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play410241060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 1.125

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_2 = arg_241_1:GetWordFromCfg(410241059)
				local var_244_3 = arg_241_1:FormatText(var_244_2.content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 45
				local var_244_5 = utf8.len(var_244_3)
				local var_244_6 = var_244_4 <= 0 and var_244_1 or var_244_1 * (var_244_5 / var_244_4)

				if var_244_6 > 0 and var_244_1 < var_244_6 then
					arg_241_1.talkMaxDuration = var_244_6

					if var_244_6 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_7 and arg_241_1.time_ < var_244_0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play410241060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410241060
		arg_245_1.duration_ = 2.63

		local var_245_0 = {
			ja = 2.266,
			CriLanguages = 2.633,
			zh = 2.633
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play410241061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.125

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[612].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:GetWordFromCfg(410241060)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 5
				local var_248_6 = utf8.len(var_248_4)
				local var_248_7 = var_248_5 <= 0 and var_248_1 or var_248_1 * (var_248_6 / var_248_5)

				if var_248_7 > 0 and var_248_1 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241060", "story_v_out_410241.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_410241", "410241060", "story_v_out_410241.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_410241", "410241060", "story_v_out_410241.awb")

						arg_245_1:RecordAudio("410241060", var_248_9)
						arg_245_1:RecordAudio("410241060", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_410241", "410241060", "story_v_out_410241.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_410241", "410241060", "story_v_out_410241.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_10 and arg_245_1.time_ < var_248_0 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play410241061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410241061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play410241062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.925

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_2 = arg_249_1:GetWordFromCfg(410241061)
				local var_252_3 = arg_249_1:FormatText(var_252_2.content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 37
				local var_252_5 = utf8.len(var_252_3)
				local var_252_6 = var_252_4 <= 0 and var_252_1 or var_252_1 * (var_252_5 / var_252_4)

				if var_252_6 > 0 and var_252_1 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_7 and arg_249_1.time_ < var_252_0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play410241062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410241062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play410241063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 1.375

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_2 = arg_253_1:GetWordFromCfg(410241062)
				local var_256_3 = arg_253_1:FormatText(var_256_2.content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 55
				local var_256_5 = utf8.len(var_256_3)
				local var_256_6 = var_256_4 <= 0 and var_256_1 or var_256_1 * (var_256_5 / var_256_4)

				if var_256_6 > 0 and var_256_1 < var_256_6 then
					arg_253_1.talkMaxDuration = var_256_6

					if var_256_6 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_7 and arg_253_1.time_ < var_256_0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play410241063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410241063
		arg_257_1.duration_ = 9

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play410241064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = "L04h"

			if arg_257_1.bgs_[var_260_0] == nil then
				local var_260_1 = Object.Instantiate(arg_257_1.paintGo_)

				var_260_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_260_0)
				var_260_1.name = var_260_0
				var_260_1.transform.parent = arg_257_1.stage_.transform
				var_260_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.bgs_[var_260_0] = var_260_1
			end

			local var_260_2 = 2

			if var_260_2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				local var_260_3 = manager.ui.mainCamera.transform.localPosition
				local var_260_4 = Vector3.New(0, 0, 10) + Vector3.New(var_260_3.x, var_260_3.y, 0)
				local var_260_5 = arg_257_1.bgs_.L04h

				var_260_5.transform.localPosition = var_260_4
				var_260_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_260_6 = var_260_5:GetComponent("SpriteRenderer")

				if var_260_6 and var_260_6.sprite then
					local var_260_7 = (var_260_5.transform.localPosition - var_260_3).z
					local var_260_8 = manager.ui.mainCameraCom_
					local var_260_9 = 2 * var_260_7 * Mathf.Tan(var_260_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_260_10 = var_260_9 * var_260_8.aspect
					local var_260_11 = var_260_6.sprite.bounds.size.x
					local var_260_12 = var_260_6.sprite.bounds.size.y
					local var_260_13 = var_260_10 / var_260_11
					local var_260_14 = var_260_9 / var_260_12
					local var_260_15 = var_260_14 < var_260_13 and var_260_13 or var_260_14

					var_260_5.transform.localScale = Vector3.New(var_260_15, var_260_15, 0)
				end

				for iter_260_0, iter_260_1 in pairs(arg_257_1.bgs_) do
					if iter_260_0 ~= "L04h" then
						iter_260_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_260_16 = 0

			if var_260_16 < arg_257_1.time_ and arg_257_1.time_ <= var_260_16 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_17 = 2

			if var_260_16 <= arg_257_1.time_ and arg_257_1.time_ < var_260_16 + var_260_17 then
				local var_260_18 = (arg_257_1.time_ - var_260_16) / var_260_17
				local var_260_19 = Color.New(0, 0, 0)

				var_260_19.a = Mathf.Lerp(0, 1, var_260_18)
				arg_257_1.mask_.color = var_260_19
			end

			if arg_257_1.time_ >= var_260_16 + var_260_17 and arg_257_1.time_ < var_260_16 + var_260_17 + arg_260_0 then
				local var_260_20 = Color.New(0, 0, 0)

				var_260_20.a = 1
				arg_257_1.mask_.color = var_260_20
			end

			local var_260_21 = 2

			if var_260_21 < arg_257_1.time_ and arg_257_1.time_ <= var_260_21 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_22 = 2

			if var_260_21 <= arg_257_1.time_ and arg_257_1.time_ < var_260_21 + var_260_22 then
				local var_260_23 = (arg_257_1.time_ - var_260_21) / var_260_22
				local var_260_24 = Color.New(0, 0, 0)

				var_260_24.a = Mathf.Lerp(1, 0, var_260_23)
				arg_257_1.mask_.color = var_260_24
			end

			if arg_257_1.time_ >= var_260_21 + var_260_22 and arg_257_1.time_ < var_260_21 + var_260_22 + arg_260_0 then
				local var_260_25 = Color.New(0, 0, 0)
				local var_260_26 = 0

				arg_257_1.mask_.enabled = false
				var_260_25.a = var_260_26
				arg_257_1.mask_.color = var_260_25
			end

			if arg_257_1.frameCnt_ <= 1 then
				arg_257_1.dialog_:SetActive(false)
			end

			local var_260_27 = 4
			local var_260_28 = 1.425

			if var_260_27 < arg_257_1.time_ and arg_257_1.time_ <= var_260_27 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0

				arg_257_1.dialog_:SetActive(true)

				arg_257_1.dialogCg_.alpha = 0

				local var_260_29 = LeanTween.value(arg_257_1.dialog_, 0, 1, 0.3)

				var_260_29:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_257_1.dialogCg_.alpha = arg_261_0
				end))
				var_260_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_257_1.dialog_)
					var_260_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_257_1.duration_ = arg_257_1.duration_ + 0.3

				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_30 = arg_257_1:GetWordFromCfg(410241063)
				local var_260_31 = arg_257_1:FormatText(var_260_30.content)

				arg_257_1.text_.text = var_260_31

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_32 = 57
				local var_260_33 = utf8.len(var_260_31)
				local var_260_34 = var_260_32 <= 0 and var_260_28 or var_260_28 * (var_260_33 / var_260_32)

				if var_260_34 > 0 and var_260_28 < var_260_34 then
					arg_257_1.talkMaxDuration = var_260_34
					var_260_27 = var_260_27 + 0.3

					if var_260_34 + var_260_27 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_34 + var_260_27
					end
				end

				arg_257_1.text_.text = var_260_31
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_35 = var_260_27 + 0.3
			local var_260_36 = math.max(var_260_28, arg_257_1.talkMaxDuration)

			if var_260_35 <= arg_257_1.time_ and arg_257_1.time_ < var_260_35 + var_260_36 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_35) / var_260_36

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_35 + var_260_36 and arg_257_1.time_ < var_260_35 + var_260_36 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play410241064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 410241064
		arg_263_1.duration_ = 2.37

		local var_263_0 = {
			ja = 2.366,
			CriLanguages = 1.6,
			zh = 1.6
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play410241065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1061"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1061 = var_266_0.localPosition
				var_266_0.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("1061", 3)

				local var_266_2 = var_266_0.childCount

				for iter_266_0 = 0, var_266_2 - 1 do
					local var_266_3 = var_266_0:GetChild(iter_266_0)

					if var_266_3.name == "" or not string.find(var_266_3.name, "split") then
						var_266_3.gameObject:SetActive(true)
					else
						var_266_3.gameObject:SetActive(false)
					end
				end
			end

			local var_266_4 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_4 then
				local var_266_5 = (arg_263_1.time_ - var_266_1) / var_266_4
				local var_266_6 = Vector3.New(0, -490, 18)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1061, var_266_6, var_266_5)
			end

			if arg_263_1.time_ >= var_266_1 + var_266_4 and arg_263_1.time_ < var_266_1 + var_266_4 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_266_7 = arg_263_1.actors_["1061"]
			local var_266_8 = 0

			if var_266_8 < arg_263_1.time_ and arg_263_1.time_ <= var_266_8 + arg_266_0 and not isNil(var_266_7) and arg_263_1.var_.actorSpriteComps1061 == nil then
				arg_263_1.var_.actorSpriteComps1061 = var_266_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_9 = 0.034

			if var_266_8 <= arg_263_1.time_ and arg_263_1.time_ < var_266_8 + var_266_9 and not isNil(var_266_7) then
				local var_266_10 = (arg_263_1.time_ - var_266_8) / var_266_9

				if arg_263_1.var_.actorSpriteComps1061 then
					for iter_266_1, iter_266_2 in pairs(arg_263_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_266_2 then
							if arg_263_1.isInRecall_ then
								local var_266_11 = Mathf.Lerp(iter_266_2.color.r, arg_263_1.hightColor1.r, var_266_10)
								local var_266_12 = Mathf.Lerp(iter_266_2.color.g, arg_263_1.hightColor1.g, var_266_10)
								local var_266_13 = Mathf.Lerp(iter_266_2.color.b, arg_263_1.hightColor1.b, var_266_10)

								iter_266_2.color = Color.New(var_266_11, var_266_12, var_266_13)
							else
								local var_266_14 = Mathf.Lerp(iter_266_2.color.r, 1, var_266_10)

								iter_266_2.color = Color.New(var_266_14, var_266_14, var_266_14)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_8 + var_266_9 and arg_263_1.time_ < var_266_8 + var_266_9 + arg_266_0 and not isNil(var_266_7) and arg_263_1.var_.actorSpriteComps1061 then
				for iter_266_3, iter_266_4 in pairs(arg_263_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_266_4 then
						if arg_263_1.isInRecall_ then
							iter_266_4.color = arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_266_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps1061 = nil
			end

			local var_266_15 = 0
			local var_266_16 = 0.2

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_17 = arg_263_1:FormatText(StoryNameCfg[612].name)

				arg_263_1.leftNameTxt_.text = var_266_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_18 = arg_263_1:GetWordFromCfg(410241064)
				local var_266_19 = arg_263_1:FormatText(var_266_18.content)

				arg_263_1.text_.text = var_266_19

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_20 = 8
				local var_266_21 = utf8.len(var_266_19)
				local var_266_22 = var_266_20 <= 0 and var_266_16 or var_266_16 * (var_266_21 / var_266_20)

				if var_266_22 > 0 and var_266_16 < var_266_22 then
					arg_263_1.talkMaxDuration = var_266_22

					if var_266_22 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_22 + var_266_15
					end
				end

				arg_263_1.text_.text = var_266_19
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241064", "story_v_out_410241.awb") ~= 0 then
					local var_266_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241064", "story_v_out_410241.awb") / 1000

					if var_266_23 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_15
					end

					if var_266_18.prefab_name ~= "" and arg_263_1.actors_[var_266_18.prefab_name] ~= nil then
						local var_266_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_18.prefab_name].transform, "story_v_out_410241", "410241064", "story_v_out_410241.awb")

						arg_263_1:RecordAudio("410241064", var_266_24)
						arg_263_1:RecordAudio("410241064", var_266_24)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_410241", "410241064", "story_v_out_410241.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_410241", "410241064", "story_v_out_410241.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_25 = math.max(var_266_16, arg_263_1.talkMaxDuration)

			if var_266_15 <= arg_263_1.time_ and arg_263_1.time_ < var_266_15 + var_266_25 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_15) / var_266_25

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_15 + var_266_25 and arg_263_1.time_ < var_266_15 + var_266_25 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play410241065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 410241065
		arg_267_1.duration_ = 5.63

		local var_267_0 = {
			ja = 5.633,
			CriLanguages = 5.4,
			zh = 5.4
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play410241066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1061"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos1061 = var_270_0.localPosition
				var_270_0.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("1061", 3)

				local var_270_2 = var_270_0.childCount

				for iter_270_0 = 0, var_270_2 - 1 do
					local var_270_3 = var_270_0:GetChild(iter_270_0)

					if var_270_3.name == "" or not string.find(var_270_3.name, "split") then
						var_270_3.gameObject:SetActive(true)
					else
						var_270_3.gameObject:SetActive(false)
					end
				end
			end

			local var_270_4 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_4 then
				local var_270_5 = (arg_267_1.time_ - var_270_1) / var_270_4
				local var_270_6 = Vector3.New(0, -490, 18)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1061, var_270_6, var_270_5)
			end

			if arg_267_1.time_ >= var_270_1 + var_270_4 and arg_267_1.time_ < var_270_1 + var_270_4 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_270_7 = arg_267_1.actors_["1061"]
			local var_270_8 = 0

			if var_270_8 < arg_267_1.time_ and arg_267_1.time_ <= var_270_8 + arg_270_0 and not isNil(var_270_7) and arg_267_1.var_.actorSpriteComps1061 == nil then
				arg_267_1.var_.actorSpriteComps1061 = var_270_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_9 = 0.034

			if var_270_8 <= arg_267_1.time_ and arg_267_1.time_ < var_270_8 + var_270_9 and not isNil(var_270_7) then
				local var_270_10 = (arg_267_1.time_ - var_270_8) / var_270_9

				if arg_267_1.var_.actorSpriteComps1061 then
					for iter_270_1, iter_270_2 in pairs(arg_267_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_270_2 then
							if arg_267_1.isInRecall_ then
								local var_270_11 = Mathf.Lerp(iter_270_2.color.r, arg_267_1.hightColor1.r, var_270_10)
								local var_270_12 = Mathf.Lerp(iter_270_2.color.g, arg_267_1.hightColor1.g, var_270_10)
								local var_270_13 = Mathf.Lerp(iter_270_2.color.b, arg_267_1.hightColor1.b, var_270_10)

								iter_270_2.color = Color.New(var_270_11, var_270_12, var_270_13)
							else
								local var_270_14 = Mathf.Lerp(iter_270_2.color.r, 1, var_270_10)

								iter_270_2.color = Color.New(var_270_14, var_270_14, var_270_14)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_8 + var_270_9 and arg_267_1.time_ < var_270_8 + var_270_9 + arg_270_0 and not isNil(var_270_7) and arg_267_1.var_.actorSpriteComps1061 then
				for iter_270_3, iter_270_4 in pairs(arg_267_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_270_4 then
						if arg_267_1.isInRecall_ then
							iter_270_4.color = arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_270_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps1061 = nil
			end

			local var_270_15 = 0
			local var_270_16 = 0.55

			if var_270_15 < arg_267_1.time_ and arg_267_1.time_ <= var_270_15 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_17 = arg_267_1:FormatText(StoryNameCfg[612].name)

				arg_267_1.leftNameTxt_.text = var_270_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_18 = arg_267_1:GetWordFromCfg(410241065)
				local var_270_19 = arg_267_1:FormatText(var_270_18.content)

				arg_267_1.text_.text = var_270_19

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_20 = 22
				local var_270_21 = utf8.len(var_270_19)
				local var_270_22 = var_270_20 <= 0 and var_270_16 or var_270_16 * (var_270_21 / var_270_20)

				if var_270_22 > 0 and var_270_16 < var_270_22 then
					arg_267_1.talkMaxDuration = var_270_22

					if var_270_22 + var_270_15 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_22 + var_270_15
					end
				end

				arg_267_1.text_.text = var_270_19
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241065", "story_v_out_410241.awb") ~= 0 then
					local var_270_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241065", "story_v_out_410241.awb") / 1000

					if var_270_23 + var_270_15 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_23 + var_270_15
					end

					if var_270_18.prefab_name ~= "" and arg_267_1.actors_[var_270_18.prefab_name] ~= nil then
						local var_270_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_18.prefab_name].transform, "story_v_out_410241", "410241065", "story_v_out_410241.awb")

						arg_267_1:RecordAudio("410241065", var_270_24)
						arg_267_1:RecordAudio("410241065", var_270_24)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_410241", "410241065", "story_v_out_410241.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_410241", "410241065", "story_v_out_410241.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_25 = math.max(var_270_16, arg_267_1.talkMaxDuration)

			if var_270_15 <= arg_267_1.time_ and arg_267_1.time_ < var_270_15 + var_270_25 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_15) / var_270_25

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_15 + var_270_25 and arg_267_1.time_ < var_270_15 + var_270_25 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play410241066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 410241066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play410241067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1061"].transform
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.var_.moveOldPos1061 = var_274_0.localPosition
				var_274_0.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("1061", 7)

				local var_274_2 = var_274_0.childCount

				for iter_274_0 = 0, var_274_2 - 1 do
					local var_274_3 = var_274_0:GetChild(iter_274_0)

					if var_274_3.name == "" or not string.find(var_274_3.name, "split") then
						var_274_3.gameObject:SetActive(true)
					else
						var_274_3.gameObject:SetActive(false)
					end
				end
			end

			local var_274_4 = 0.001

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_4 then
				local var_274_5 = (arg_271_1.time_ - var_274_1) / var_274_4
				local var_274_6 = Vector3.New(0, -2000, 18)

				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1061, var_274_6, var_274_5)
			end

			if arg_271_1.time_ >= var_274_1 + var_274_4 and arg_271_1.time_ < var_274_1 + var_274_4 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_274_7 = arg_271_1.actors_["1061"]
			local var_274_8 = 0

			if var_274_8 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 and not isNil(var_274_7) and arg_271_1.var_.actorSpriteComps1061 == nil then
				arg_271_1.var_.actorSpriteComps1061 = var_274_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_9 = 0.034

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_9 and not isNil(var_274_7) then
				local var_274_10 = (arg_271_1.time_ - var_274_8) / var_274_9

				if arg_271_1.var_.actorSpriteComps1061 then
					for iter_274_1, iter_274_2 in pairs(arg_271_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_274_2 then
							if arg_271_1.isInRecall_ then
								local var_274_11 = Mathf.Lerp(iter_274_2.color.r, arg_271_1.hightColor2.r, var_274_10)
								local var_274_12 = Mathf.Lerp(iter_274_2.color.g, arg_271_1.hightColor2.g, var_274_10)
								local var_274_13 = Mathf.Lerp(iter_274_2.color.b, arg_271_1.hightColor2.b, var_274_10)

								iter_274_2.color = Color.New(var_274_11, var_274_12, var_274_13)
							else
								local var_274_14 = Mathf.Lerp(iter_274_2.color.r, 0.5, var_274_10)

								iter_274_2.color = Color.New(var_274_14, var_274_14, var_274_14)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_8 + var_274_9 and arg_271_1.time_ < var_274_8 + var_274_9 + arg_274_0 and not isNil(var_274_7) and arg_271_1.var_.actorSpriteComps1061 then
				for iter_274_3, iter_274_4 in pairs(arg_271_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_274_4 then
						if arg_271_1.isInRecall_ then
							iter_274_4.color = arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_274_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps1061 = nil
			end

			local var_274_15 = 0
			local var_274_16 = 0.825

			if var_274_15 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_17 = arg_271_1:GetWordFromCfg(410241066)
				local var_274_18 = arg_271_1:FormatText(var_274_17.content)

				arg_271_1.text_.text = var_274_18

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_19 = 33
				local var_274_20 = utf8.len(var_274_18)
				local var_274_21 = var_274_19 <= 0 and var_274_16 or var_274_16 * (var_274_20 / var_274_19)

				if var_274_21 > 0 and var_274_16 < var_274_21 then
					arg_271_1.talkMaxDuration = var_274_21

					if var_274_21 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_21 + var_274_15
					end
				end

				arg_271_1.text_.text = var_274_18
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_22 = math.max(var_274_16, arg_271_1.talkMaxDuration)

			if var_274_15 <= arg_271_1.time_ and arg_271_1.time_ < var_274_15 + var_274_22 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_15) / var_274_22

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_15 + var_274_22 and arg_271_1.time_ < var_274_15 + var_274_22 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play410241067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 410241067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play410241068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = manager.ui.mainCamera.transform
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.var_.shakeOldPos = var_278_0.localPosition
			end

			local var_278_2 = 1

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / 0.066
				local var_278_4, var_278_5 = math.modf(var_278_3)

				var_278_0.localPosition = Vector3.New(var_278_5 * 0.13, var_278_5 * 0.13, var_278_5 * 0.13) + arg_275_1.var_.shakeOldPos
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 then
				var_278_0.localPosition = arg_275_1.var_.shakeOldPos
			end

			local var_278_6 = 0

			if var_278_6 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.allBtn_.enabled = false
			end

			local var_278_7 = 1

			if arg_275_1.time_ >= var_278_6 + var_278_7 and arg_275_1.time_ < var_278_6 + var_278_7 + arg_278_0 then
				arg_275_1.allBtn_.enabled = true
			end

			local var_278_8 = 0
			local var_278_9 = 1.175

			if var_278_8 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_10 = arg_275_1:GetWordFromCfg(410241067)
				local var_278_11 = arg_275_1:FormatText(var_278_10.content)

				arg_275_1.text_.text = var_278_11

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_12 = 47
				local var_278_13 = utf8.len(var_278_11)
				local var_278_14 = var_278_12 <= 0 and var_278_9 or var_278_9 * (var_278_13 / var_278_12)

				if var_278_14 > 0 and var_278_9 < var_278_14 then
					arg_275_1.talkMaxDuration = var_278_14

					if var_278_14 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_14 + var_278_8
					end
				end

				arg_275_1.text_.text = var_278_11
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_15 = math.max(var_278_9, arg_275_1.talkMaxDuration)

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_15 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_8) / var_278_15

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_8 + var_278_15 and arg_275_1.time_ < var_278_8 + var_278_15 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play410241068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 410241068
		arg_279_1.duration_ = 5.8

		local var_279_0 = {
			ja = 5.8,
			CriLanguages = 3.733,
			zh = 3.733
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play410241069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = "10062"

			if arg_279_1.actors_[var_282_0] == nil then
				local var_282_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10062")

				if not isNil(var_282_1) then
					local var_282_2 = Object.Instantiate(var_282_1, arg_279_1.canvasGo_.transform)

					var_282_2.transform:SetSiblingIndex(1)

					var_282_2.name = var_282_0
					var_282_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_279_1.actors_[var_282_0] = var_282_2

					local var_282_3 = var_282_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_279_1.isInRecall_ then
						for iter_282_0, iter_282_1 in ipairs(var_282_3) do
							iter_282_1.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_282_4 = arg_279_1.actors_["10062"].transform
			local var_282_5 = 0

			if var_282_5 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1.var_.moveOldPos10062 = var_282_4.localPosition
				var_282_4.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("10062", 3)

				local var_282_6 = var_282_4.childCount

				for iter_282_2 = 0, var_282_6 - 1 do
					local var_282_7 = var_282_4:GetChild(iter_282_2)

					if var_282_7.name == "split_5" or not string.find(var_282_7.name, "split") then
						var_282_7.gameObject:SetActive(true)
					else
						var_282_7.gameObject:SetActive(false)
					end
				end
			end

			local var_282_8 = 0.001

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_8 then
				local var_282_9 = (arg_279_1.time_ - var_282_5) / var_282_8
				local var_282_10 = Vector3.New(0, -390, -290)

				var_282_4.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10062, var_282_10, var_282_9)
			end

			if arg_279_1.time_ >= var_282_5 + var_282_8 and arg_279_1.time_ < var_282_5 + var_282_8 + arg_282_0 then
				var_282_4.localPosition = Vector3.New(0, -390, -290)
			end

			local var_282_11 = arg_279_1.actors_["10062"]
			local var_282_12 = 0

			if var_282_12 < arg_279_1.time_ and arg_279_1.time_ <= var_282_12 + arg_282_0 and not isNil(var_282_11) and arg_279_1.var_.actorSpriteComps10062 == nil then
				arg_279_1.var_.actorSpriteComps10062 = var_282_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_13 = 0.034

			if var_282_12 <= arg_279_1.time_ and arg_279_1.time_ < var_282_12 + var_282_13 and not isNil(var_282_11) then
				local var_282_14 = (arg_279_1.time_ - var_282_12) / var_282_13

				if arg_279_1.var_.actorSpriteComps10062 then
					for iter_282_3, iter_282_4 in pairs(arg_279_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_282_4 then
							if arg_279_1.isInRecall_ then
								local var_282_15 = Mathf.Lerp(iter_282_4.color.r, arg_279_1.hightColor1.r, var_282_14)
								local var_282_16 = Mathf.Lerp(iter_282_4.color.g, arg_279_1.hightColor1.g, var_282_14)
								local var_282_17 = Mathf.Lerp(iter_282_4.color.b, arg_279_1.hightColor1.b, var_282_14)

								iter_282_4.color = Color.New(var_282_15, var_282_16, var_282_17)
							else
								local var_282_18 = Mathf.Lerp(iter_282_4.color.r, 1, var_282_14)

								iter_282_4.color = Color.New(var_282_18, var_282_18, var_282_18)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= var_282_12 + var_282_13 and arg_279_1.time_ < var_282_12 + var_282_13 + arg_282_0 and not isNil(var_282_11) and arg_279_1.var_.actorSpriteComps10062 then
				for iter_282_5, iter_282_6 in pairs(arg_279_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_282_6 then
						if arg_279_1.isInRecall_ then
							iter_282_6.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_282_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps10062 = nil
			end

			local var_282_19 = 0
			local var_282_20 = 0.275

			if var_282_19 < arg_279_1.time_ and arg_279_1.time_ <= var_282_19 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_21 = arg_279_1:FormatText(StoryNameCfg[600].name)

				arg_279_1.leftNameTxt_.text = var_282_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_22 = arg_279_1:GetWordFromCfg(410241068)
				local var_282_23 = arg_279_1:FormatText(var_282_22.content)

				arg_279_1.text_.text = var_282_23

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_24 = 11
				local var_282_25 = utf8.len(var_282_23)
				local var_282_26 = var_282_24 <= 0 and var_282_20 or var_282_20 * (var_282_25 / var_282_24)

				if var_282_26 > 0 and var_282_20 < var_282_26 then
					arg_279_1.talkMaxDuration = var_282_26

					if var_282_26 + var_282_19 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_26 + var_282_19
					end
				end

				arg_279_1.text_.text = var_282_23
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241068", "story_v_out_410241.awb") ~= 0 then
					local var_282_27 = manager.audio:GetVoiceLength("story_v_out_410241", "410241068", "story_v_out_410241.awb") / 1000

					if var_282_27 + var_282_19 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_27 + var_282_19
					end

					if var_282_22.prefab_name ~= "" and arg_279_1.actors_[var_282_22.prefab_name] ~= nil then
						local var_282_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_22.prefab_name].transform, "story_v_out_410241", "410241068", "story_v_out_410241.awb")

						arg_279_1:RecordAudio("410241068", var_282_28)
						arg_279_1:RecordAudio("410241068", var_282_28)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_410241", "410241068", "story_v_out_410241.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_410241", "410241068", "story_v_out_410241.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_29 = math.max(var_282_20, arg_279_1.talkMaxDuration)

			if var_282_19 <= arg_279_1.time_ and arg_279_1.time_ < var_282_19 + var_282_29 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_19) / var_282_29

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_19 + var_282_29 and arg_279_1.time_ < var_282_19 + var_282_29 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play410241069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 410241069
		arg_283_1.duration_ = 9.03

		local var_283_0 = {
			ja = 9.033,
			CriLanguages = 2.033,
			zh = 2.033
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play410241070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10062"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos10062 = var_286_0.localPosition
				var_286_0.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("10062", 7)

				local var_286_2 = var_286_0.childCount

				for iter_286_0 = 0, var_286_2 - 1 do
					local var_286_3 = var_286_0:GetChild(iter_286_0)

					if var_286_3.name == "" or not string.find(var_286_3.name, "split") then
						var_286_3.gameObject:SetActive(true)
					else
						var_286_3.gameObject:SetActive(false)
					end
				end
			end

			local var_286_4 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_4 then
				local var_286_5 = (arg_283_1.time_ - var_286_1) / var_286_4
				local var_286_6 = Vector3.New(0, -2000, -290)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10062, var_286_6, var_286_5)
			end

			if arg_283_1.time_ >= var_286_1 + var_286_4 and arg_283_1.time_ < var_286_1 + var_286_4 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_286_7 = arg_283_1.actors_["1061"].transform
			local var_286_8 = 0

			if var_286_8 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.var_.moveOldPos1061 = var_286_7.localPosition
				var_286_7.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("1061", 3)

				local var_286_9 = var_286_7.childCount

				for iter_286_1 = 0, var_286_9 - 1 do
					local var_286_10 = var_286_7:GetChild(iter_286_1)

					if var_286_10.name == "split_2" or not string.find(var_286_10.name, "split") then
						var_286_10.gameObject:SetActive(true)
					else
						var_286_10.gameObject:SetActive(false)
					end
				end
			end

			local var_286_11 = 0.001

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_11 then
				local var_286_12 = (arg_283_1.time_ - var_286_8) / var_286_11
				local var_286_13 = Vector3.New(0, -490, 18)

				var_286_7.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1061, var_286_13, var_286_12)
			end

			if arg_283_1.time_ >= var_286_8 + var_286_11 and arg_283_1.time_ < var_286_8 + var_286_11 + arg_286_0 then
				var_286_7.localPosition = Vector3.New(0, -490, 18)
			end

			local var_286_14 = arg_283_1.actors_["10062"]
			local var_286_15 = 0

			if var_286_15 < arg_283_1.time_ and arg_283_1.time_ <= var_286_15 + arg_286_0 and not isNil(var_286_14) and arg_283_1.var_.actorSpriteComps10062 == nil then
				arg_283_1.var_.actorSpriteComps10062 = var_286_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_16 = 0.034

			if var_286_15 <= arg_283_1.time_ and arg_283_1.time_ < var_286_15 + var_286_16 and not isNil(var_286_14) then
				local var_286_17 = (arg_283_1.time_ - var_286_15) / var_286_16

				if arg_283_1.var_.actorSpriteComps10062 then
					for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_286_3 then
							if arg_283_1.isInRecall_ then
								local var_286_18 = Mathf.Lerp(iter_286_3.color.r, arg_283_1.hightColor2.r, var_286_17)
								local var_286_19 = Mathf.Lerp(iter_286_3.color.g, arg_283_1.hightColor2.g, var_286_17)
								local var_286_20 = Mathf.Lerp(iter_286_3.color.b, arg_283_1.hightColor2.b, var_286_17)

								iter_286_3.color = Color.New(var_286_18, var_286_19, var_286_20)
							else
								local var_286_21 = Mathf.Lerp(iter_286_3.color.r, 0.5, var_286_17)

								iter_286_3.color = Color.New(var_286_21, var_286_21, var_286_21)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= var_286_15 + var_286_16 and arg_283_1.time_ < var_286_15 + var_286_16 + arg_286_0 and not isNil(var_286_14) and arg_283_1.var_.actorSpriteComps10062 then
				for iter_286_4, iter_286_5 in pairs(arg_283_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_286_5 then
						if arg_283_1.isInRecall_ then
							iter_286_5.color = arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_286_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps10062 = nil
			end

			local var_286_22 = arg_283_1.actors_["1061"]
			local var_286_23 = 0

			if var_286_23 < arg_283_1.time_ and arg_283_1.time_ <= var_286_23 + arg_286_0 and not isNil(var_286_22) and arg_283_1.var_.actorSpriteComps1061 == nil then
				arg_283_1.var_.actorSpriteComps1061 = var_286_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_24 = 0.034

			if var_286_23 <= arg_283_1.time_ and arg_283_1.time_ < var_286_23 + var_286_24 and not isNil(var_286_22) then
				local var_286_25 = (arg_283_1.time_ - var_286_23) / var_286_24

				if arg_283_1.var_.actorSpriteComps1061 then
					for iter_286_6, iter_286_7 in pairs(arg_283_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_286_7 then
							if arg_283_1.isInRecall_ then
								local var_286_26 = Mathf.Lerp(iter_286_7.color.r, arg_283_1.hightColor1.r, var_286_25)
								local var_286_27 = Mathf.Lerp(iter_286_7.color.g, arg_283_1.hightColor1.g, var_286_25)
								local var_286_28 = Mathf.Lerp(iter_286_7.color.b, arg_283_1.hightColor1.b, var_286_25)

								iter_286_7.color = Color.New(var_286_26, var_286_27, var_286_28)
							else
								local var_286_29 = Mathf.Lerp(iter_286_7.color.r, 1, var_286_25)

								iter_286_7.color = Color.New(var_286_29, var_286_29, var_286_29)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= var_286_23 + var_286_24 and arg_283_1.time_ < var_286_23 + var_286_24 + arg_286_0 and not isNil(var_286_22) and arg_283_1.var_.actorSpriteComps1061 then
				for iter_286_8, iter_286_9 in pairs(arg_283_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_286_9 then
						if arg_283_1.isInRecall_ then
							iter_286_9.color = arg_283_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_286_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps1061 = nil
			end

			local var_286_30 = 0
			local var_286_31 = 0.225

			if var_286_30 < arg_283_1.time_ and arg_283_1.time_ <= var_286_30 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_32 = arg_283_1:FormatText(StoryNameCfg[612].name)

				arg_283_1.leftNameTxt_.text = var_286_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_33 = arg_283_1:GetWordFromCfg(410241069)
				local var_286_34 = arg_283_1:FormatText(var_286_33.content)

				arg_283_1.text_.text = var_286_34

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_35 = 9
				local var_286_36 = utf8.len(var_286_34)
				local var_286_37 = var_286_35 <= 0 and var_286_31 or var_286_31 * (var_286_36 / var_286_35)

				if var_286_37 > 0 and var_286_31 < var_286_37 then
					arg_283_1.talkMaxDuration = var_286_37

					if var_286_37 + var_286_30 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_37 + var_286_30
					end
				end

				arg_283_1.text_.text = var_286_34
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241069", "story_v_out_410241.awb") ~= 0 then
					local var_286_38 = manager.audio:GetVoiceLength("story_v_out_410241", "410241069", "story_v_out_410241.awb") / 1000

					if var_286_38 + var_286_30 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_38 + var_286_30
					end

					if var_286_33.prefab_name ~= "" and arg_283_1.actors_[var_286_33.prefab_name] ~= nil then
						local var_286_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_33.prefab_name].transform, "story_v_out_410241", "410241069", "story_v_out_410241.awb")

						arg_283_1:RecordAudio("410241069", var_286_39)
						arg_283_1:RecordAudio("410241069", var_286_39)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_410241", "410241069", "story_v_out_410241.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_410241", "410241069", "story_v_out_410241.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_40 = math.max(var_286_31, arg_283_1.talkMaxDuration)

			if var_286_30 <= arg_283_1.time_ and arg_283_1.time_ < var_286_30 + var_286_40 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_30) / var_286_40

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_30 + var_286_40 and arg_283_1.time_ < var_286_30 + var_286_40 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play410241070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 410241070
		arg_287_1.duration_ = 8.2

		local var_287_0 = {
			ja = 8.2,
			CriLanguages = 4.533,
			zh = 4.533
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play410241071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10062"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos10062 = var_290_0.localPosition
				var_290_0.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("10062", 3)

				local var_290_2 = var_290_0.childCount

				for iter_290_0 = 0, var_290_2 - 1 do
					local var_290_3 = var_290_0:GetChild(iter_290_0)

					if var_290_3.name == "split_5" or not string.find(var_290_3.name, "split") then
						var_290_3.gameObject:SetActive(true)
					else
						var_290_3.gameObject:SetActive(false)
					end
				end
			end

			local var_290_4 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_4 then
				local var_290_5 = (arg_287_1.time_ - var_290_1) / var_290_4
				local var_290_6 = Vector3.New(0, -390, -290)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10062, var_290_6, var_290_5)
			end

			if arg_287_1.time_ >= var_290_1 + var_290_4 and arg_287_1.time_ < var_290_1 + var_290_4 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_290_7 = arg_287_1.actors_["1061"].transform
			local var_290_8 = 0

			if var_290_8 < arg_287_1.time_ and arg_287_1.time_ <= var_290_8 + arg_290_0 then
				arg_287_1.var_.moveOldPos1061 = var_290_7.localPosition
				var_290_7.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("1061", 7)

				local var_290_9 = var_290_7.childCount

				for iter_290_1 = 0, var_290_9 - 1 do
					local var_290_10 = var_290_7:GetChild(iter_290_1)

					if var_290_10.name == "" or not string.find(var_290_10.name, "split") then
						var_290_10.gameObject:SetActive(true)
					else
						var_290_10.gameObject:SetActive(false)
					end
				end
			end

			local var_290_11 = 0.001

			if var_290_8 <= arg_287_1.time_ and arg_287_1.time_ < var_290_8 + var_290_11 then
				local var_290_12 = (arg_287_1.time_ - var_290_8) / var_290_11
				local var_290_13 = Vector3.New(0, -2000, 18)

				var_290_7.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1061, var_290_13, var_290_12)
			end

			if arg_287_1.time_ >= var_290_8 + var_290_11 and arg_287_1.time_ < var_290_8 + var_290_11 + arg_290_0 then
				var_290_7.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_290_14 = arg_287_1.actors_["10062"]
			local var_290_15 = 0

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 and not isNil(var_290_14) and arg_287_1.var_.actorSpriteComps10062 == nil then
				arg_287_1.var_.actorSpriteComps10062 = var_290_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_16 = 0.034

			if var_290_15 <= arg_287_1.time_ and arg_287_1.time_ < var_290_15 + var_290_16 and not isNil(var_290_14) then
				local var_290_17 = (arg_287_1.time_ - var_290_15) / var_290_16

				if arg_287_1.var_.actorSpriteComps10062 then
					for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_290_3 then
							if arg_287_1.isInRecall_ then
								local var_290_18 = Mathf.Lerp(iter_290_3.color.r, arg_287_1.hightColor1.r, var_290_17)
								local var_290_19 = Mathf.Lerp(iter_290_3.color.g, arg_287_1.hightColor1.g, var_290_17)
								local var_290_20 = Mathf.Lerp(iter_290_3.color.b, arg_287_1.hightColor1.b, var_290_17)

								iter_290_3.color = Color.New(var_290_18, var_290_19, var_290_20)
							else
								local var_290_21 = Mathf.Lerp(iter_290_3.color.r, 1, var_290_17)

								iter_290_3.color = Color.New(var_290_21, var_290_21, var_290_21)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= var_290_15 + var_290_16 and arg_287_1.time_ < var_290_15 + var_290_16 + arg_290_0 and not isNil(var_290_14) and arg_287_1.var_.actorSpriteComps10062 then
				for iter_290_4, iter_290_5 in pairs(arg_287_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_290_5 then
						if arg_287_1.isInRecall_ then
							iter_290_5.color = arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_290_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps10062 = nil
			end

			local var_290_22 = arg_287_1.actors_["1061"]
			local var_290_23 = 0

			if var_290_23 < arg_287_1.time_ and arg_287_1.time_ <= var_290_23 + arg_290_0 and not isNil(var_290_22) and arg_287_1.var_.actorSpriteComps1061 == nil then
				arg_287_1.var_.actorSpriteComps1061 = var_290_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_24 = 0.034

			if var_290_23 <= arg_287_1.time_ and arg_287_1.time_ < var_290_23 + var_290_24 and not isNil(var_290_22) then
				local var_290_25 = (arg_287_1.time_ - var_290_23) / var_290_24

				if arg_287_1.var_.actorSpriteComps1061 then
					for iter_290_6, iter_290_7 in pairs(arg_287_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_290_7 then
							if arg_287_1.isInRecall_ then
								local var_290_26 = Mathf.Lerp(iter_290_7.color.r, arg_287_1.hightColor2.r, var_290_25)
								local var_290_27 = Mathf.Lerp(iter_290_7.color.g, arg_287_1.hightColor2.g, var_290_25)
								local var_290_28 = Mathf.Lerp(iter_290_7.color.b, arg_287_1.hightColor2.b, var_290_25)

								iter_290_7.color = Color.New(var_290_26, var_290_27, var_290_28)
							else
								local var_290_29 = Mathf.Lerp(iter_290_7.color.r, 0.5, var_290_25)

								iter_290_7.color = Color.New(var_290_29, var_290_29, var_290_29)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= var_290_23 + var_290_24 and arg_287_1.time_ < var_290_23 + var_290_24 + arg_290_0 and not isNil(var_290_22) and arg_287_1.var_.actorSpriteComps1061 then
				for iter_290_8, iter_290_9 in pairs(arg_287_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_290_9 then
						if arg_287_1.isInRecall_ then
							iter_290_9.color = arg_287_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_290_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps1061 = nil
			end

			local var_290_30 = 0
			local var_290_31 = 0.425

			if var_290_30 < arg_287_1.time_ and arg_287_1.time_ <= var_290_30 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_32 = arg_287_1:FormatText(StoryNameCfg[600].name)

				arg_287_1.leftNameTxt_.text = var_290_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_33 = arg_287_1:GetWordFromCfg(410241070)
				local var_290_34 = arg_287_1:FormatText(var_290_33.content)

				arg_287_1.text_.text = var_290_34

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_35 = 17
				local var_290_36 = utf8.len(var_290_34)
				local var_290_37 = var_290_35 <= 0 and var_290_31 or var_290_31 * (var_290_36 / var_290_35)

				if var_290_37 > 0 and var_290_31 < var_290_37 then
					arg_287_1.talkMaxDuration = var_290_37

					if var_290_37 + var_290_30 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_37 + var_290_30
					end
				end

				arg_287_1.text_.text = var_290_34
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241070", "story_v_out_410241.awb") ~= 0 then
					local var_290_38 = manager.audio:GetVoiceLength("story_v_out_410241", "410241070", "story_v_out_410241.awb") / 1000

					if var_290_38 + var_290_30 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_38 + var_290_30
					end

					if var_290_33.prefab_name ~= "" and arg_287_1.actors_[var_290_33.prefab_name] ~= nil then
						local var_290_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_33.prefab_name].transform, "story_v_out_410241", "410241070", "story_v_out_410241.awb")

						arg_287_1:RecordAudio("410241070", var_290_39)
						arg_287_1:RecordAudio("410241070", var_290_39)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_410241", "410241070", "story_v_out_410241.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_410241", "410241070", "story_v_out_410241.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_40 = math.max(var_290_31, arg_287_1.talkMaxDuration)

			if var_290_30 <= arg_287_1.time_ and arg_287_1.time_ < var_290_30 + var_290_40 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_30) / var_290_40

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_30 + var_290_40 and arg_287_1.time_ < var_290_30 + var_290_40 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play410241071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 410241071
		arg_291_1.duration_ = 11.1

		local var_291_0 = {
			ja = 11.1,
			CriLanguages = 4.5,
			zh = 4.5
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play410241072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["10062"].transform
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.var_.moveOldPos10062 = var_294_0.localPosition
				var_294_0.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10062", 3)

				local var_294_2 = var_294_0.childCount

				for iter_294_0 = 0, var_294_2 - 1 do
					local var_294_3 = var_294_0:GetChild(iter_294_0)

					if var_294_3.name == "split_2" or not string.find(var_294_3.name, "split") then
						var_294_3.gameObject:SetActive(true)
					else
						var_294_3.gameObject:SetActive(false)
					end
				end
			end

			local var_294_4 = 0.001

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_4 then
				local var_294_5 = (arg_291_1.time_ - var_294_1) / var_294_4
				local var_294_6 = Vector3.New(0, -390, -290)

				var_294_0.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10062, var_294_6, var_294_5)
			end

			if arg_291_1.time_ >= var_294_1 + var_294_4 and arg_291_1.time_ < var_294_1 + var_294_4 + arg_294_0 then
				var_294_0.localPosition = Vector3.New(0, -390, -290)
			end

			local var_294_7 = arg_291_1.actors_["10062"]
			local var_294_8 = 0

			if var_294_8 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 and not isNil(var_294_7) and arg_291_1.var_.actorSpriteComps10062 == nil then
				arg_291_1.var_.actorSpriteComps10062 = var_294_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_9 = 0.034

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_9 and not isNil(var_294_7) then
				local var_294_10 = (arg_291_1.time_ - var_294_8) / var_294_9

				if arg_291_1.var_.actorSpriteComps10062 then
					for iter_294_1, iter_294_2 in pairs(arg_291_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_294_2 then
							if arg_291_1.isInRecall_ then
								local var_294_11 = Mathf.Lerp(iter_294_2.color.r, arg_291_1.hightColor1.r, var_294_10)
								local var_294_12 = Mathf.Lerp(iter_294_2.color.g, arg_291_1.hightColor1.g, var_294_10)
								local var_294_13 = Mathf.Lerp(iter_294_2.color.b, arg_291_1.hightColor1.b, var_294_10)

								iter_294_2.color = Color.New(var_294_11, var_294_12, var_294_13)
							else
								local var_294_14 = Mathf.Lerp(iter_294_2.color.r, 1, var_294_10)

								iter_294_2.color = Color.New(var_294_14, var_294_14, var_294_14)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_8 + var_294_9 and arg_291_1.time_ < var_294_8 + var_294_9 + arg_294_0 and not isNil(var_294_7) and arg_291_1.var_.actorSpriteComps10062 then
				for iter_294_3, iter_294_4 in pairs(arg_291_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_294_4 then
						if arg_291_1.isInRecall_ then
							iter_294_4.color = arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_294_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps10062 = nil
			end

			local var_294_15 = 0
			local var_294_16 = 0.5

			if var_294_15 < arg_291_1.time_ and arg_291_1.time_ <= var_294_15 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_17 = arg_291_1:FormatText(StoryNameCfg[600].name)

				arg_291_1.leftNameTxt_.text = var_294_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_18 = arg_291_1:GetWordFromCfg(410241071)
				local var_294_19 = arg_291_1:FormatText(var_294_18.content)

				arg_291_1.text_.text = var_294_19

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_20 = 20
				local var_294_21 = utf8.len(var_294_19)
				local var_294_22 = var_294_20 <= 0 and var_294_16 or var_294_16 * (var_294_21 / var_294_20)

				if var_294_22 > 0 and var_294_16 < var_294_22 then
					arg_291_1.talkMaxDuration = var_294_22

					if var_294_22 + var_294_15 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_22 + var_294_15
					end
				end

				arg_291_1.text_.text = var_294_19
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410241", "410241071", "story_v_out_410241.awb") ~= 0 then
					local var_294_23 = manager.audio:GetVoiceLength("story_v_out_410241", "410241071", "story_v_out_410241.awb") / 1000

					if var_294_23 + var_294_15 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_23 + var_294_15
					end

					if var_294_18.prefab_name ~= "" and arg_291_1.actors_[var_294_18.prefab_name] ~= nil then
						local var_294_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_18.prefab_name].transform, "story_v_out_410241", "410241071", "story_v_out_410241.awb")

						arg_291_1:RecordAudio("410241071", var_294_24)
						arg_291_1:RecordAudio("410241071", var_294_24)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_410241", "410241071", "story_v_out_410241.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_410241", "410241071", "story_v_out_410241.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_25 = math.max(var_294_16, arg_291_1.talkMaxDuration)

			if var_294_15 <= arg_291_1.time_ and arg_291_1.time_ < var_294_15 + var_294_25 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_15) / var_294_25

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_15 + var_294_25 and arg_291_1.time_ < var_294_15 + var_294_25 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play410241072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 410241072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
			arg_295_1.auto_ = false
		end

		function arg_295_1.playNext_(arg_297_0)
			arg_295_1.onStoryFinished_()
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["10062"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps10062 == nil then
				arg_295_1.var_.actorSpriteComps10062 = var_298_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_2 = 0.034

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.actorSpriteComps10062 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								local var_298_4 = Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor2.r, var_298_3)
								local var_298_5 = Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor2.g, var_298_3)
								local var_298_6 = Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor2.b, var_298_3)

								iter_298_1.color = Color.New(var_298_4, var_298_5, var_298_6)
							else
								local var_298_7 = Mathf.Lerp(iter_298_1.color.r, 0.5, var_298_3)

								iter_298_1.color = Color.New(var_298_7, var_298_7, var_298_7)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps10062 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_298_3 then
						if arg_295_1.isInRecall_ then
							iter_298_3.color = arg_295_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_298_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps10062 = nil
			end

			local var_298_8 = 0
			local var_298_9 = 1.125

			if var_298_8 < arg_295_1.time_ and arg_295_1.time_ <= var_298_8 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_10 = arg_295_1:GetWordFromCfg(410241072)
				local var_298_11 = arg_295_1:FormatText(var_298_10.content)

				arg_295_1.text_.text = var_298_11

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_12 = 45
				local var_298_13 = utf8.len(var_298_11)
				local var_298_14 = var_298_12 <= 0 and var_298_9 or var_298_9 * (var_298_13 / var_298_12)

				if var_298_14 > 0 and var_298_9 < var_298_14 then
					arg_295_1.talkMaxDuration = var_298_14

					if var_298_14 + var_298_8 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_14 + var_298_8
					end
				end

				arg_295_1.text_.text = var_298_11
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_15 = math.max(var_298_9, arg_295_1.talkMaxDuration)

			if var_298_8 <= arg_295_1.time_ and arg_295_1.time_ < var_298_8 + var_298_15 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_8) / var_298_15

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_8 + var_298_15 and arg_295_1.time_ < var_298_8 + var_298_15 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST67",
		"TextureConfig/Background/LZ0206",
		"TextureConfig/Background/L04h"
	},
	voices = {
		"story_v_out_410241.awb"
	}
}
