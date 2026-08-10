return {
	Play413021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play413021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F08h"

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
				local var_4_5 = arg_1_1.bgs_.F08h

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
					if iter_4_0 ~= "F08h" then
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

			local var_4_24 = 0
			local var_4_25 = 0.266666666666667

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.366666666666667
			local var_4_31 = 0.833333333333333

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 1.999999999999
			local var_4_37 = 0.975

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_39 = arg_1_1:GetWordFromCfg(413021001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 39
				local var_4_42 = utf8.len(var_4_40)
				local var_4_43 = var_4_41 <= 0 and var_4_37 or var_4_37 * (var_4_42 / var_4_41)

				if var_4_43 > 0 and var_4_37 < var_4_43 then
					arg_1_1.talkMaxDuration = var_4_43
					var_4_36 = var_4_36 + 0.3

					if var_4_43 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_40
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = var_4_36 + 0.3
			local var_4_45 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_44) / var_4_45

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play413021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413021002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play413021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.875

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(413021002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 35
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play413021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413021003
		arg_13_1.duration_ = 14.03

		local var_13_0 = {
			zh = 9.833,
			ja = 14.033
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
				arg_13_0:Play413021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.075

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[36].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10098_split_1")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(413021003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021003", "story_v_out_413021.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021003", "story_v_out_413021.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_413021", "413021003", "story_v_out_413021.awb")

						arg_13_1:RecordAudio("413021003", var_16_9)
						arg_13_1:RecordAudio("413021003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413021", "413021003", "story_v_out_413021.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413021", "413021003", "story_v_out_413021.awb")
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
	Play413021004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413021004
		arg_17_1.duration_ = 9.53

		local var_17_0 = {
			zh = 6.2,
			ja = 9.533
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
				arg_17_0:Play413021005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.6

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[995].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(413021004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021004", "story_v_out_413021.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021004", "story_v_out_413021.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_413021", "413021004", "story_v_out_413021.awb")

						arg_17_1:RecordAudio("413021004", var_20_9)
						arg_17_1:RecordAudio("413021004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413021", "413021004", "story_v_out_413021.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413021", "413021004", "story_v_out_413021.awb")
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
	Play413021005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413021005
		arg_21_1.duration_ = 9.53

		local var_21_0 = {
			zh = 8.6,
			ja = 9.533
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
				arg_21_0:Play413021006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.725

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[36].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10098_split_1")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(413021005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021005", "story_v_out_413021.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021005", "story_v_out_413021.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_413021", "413021005", "story_v_out_413021.awb")

						arg_21_1:RecordAudio("413021005", var_24_9)
						arg_21_1:RecordAudio("413021005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413021", "413021005", "story_v_out_413021.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413021", "413021005", "story_v_out_413021.awb")
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
	Play413021006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413021006
		arg_25_1.duration_ = 9.97

		local var_25_0 = {
			zh = 8.866,
			ja = 9.966
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
				arg_25_0:Play413021007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.725

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[36].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10098_split_1")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(413021006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021006", "story_v_out_413021.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021006", "story_v_out_413021.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_413021", "413021006", "story_v_out_413021.awb")

						arg_25_1:RecordAudio("413021006", var_28_9)
						arg_25_1:RecordAudio("413021006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413021", "413021006", "story_v_out_413021.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413021", "413021006", "story_v_out_413021.awb")
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
	Play413021007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413021007
		arg_29_1.duration_ = 10.9

		local var_29_0 = {
			zh = 5.533,
			ja = 10.9
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
				arg_29_0:Play413021008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.75

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[36].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10098_split_1")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(413021007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021007", "story_v_out_413021.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021007", "story_v_out_413021.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_413021", "413021007", "story_v_out_413021.awb")

						arg_29_1:RecordAudio("413021007", var_32_9)
						arg_29_1:RecordAudio("413021007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413021", "413021007", "story_v_out_413021.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413021", "413021007", "story_v_out_413021.awb")
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
	Play413021008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413021008
		arg_33_1.duration_ = 12.67

		local var_33_0 = {
			zh = 7.9,
			ja = 12.666
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
				arg_33_0:Play413021009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.825

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[36].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10098_split_2")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(413021008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021008", "story_v_out_413021.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021008", "story_v_out_413021.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_413021", "413021008", "story_v_out_413021.awb")

						arg_33_1:RecordAudio("413021008", var_36_9)
						arg_33_1:RecordAudio("413021008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413021", "413021008", "story_v_out_413021.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413021", "413021008", "story_v_out_413021.awb")
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
	Play413021009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413021009
		arg_37_1.duration_ = 8.4

		local var_37_0 = {
			zh = 4.966,
			ja = 8.4
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
				arg_37_0:Play413021010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.55

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[36].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10098_split_1")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(413021009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021009", "story_v_out_413021.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021009", "story_v_out_413021.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_413021", "413021009", "story_v_out_413021.awb")

						arg_37_1:RecordAudio("413021009", var_40_9)
						arg_37_1:RecordAudio("413021009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413021", "413021009", "story_v_out_413021.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413021", "413021009", "story_v_out_413021.awb")
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
	Play413021010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413021010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play413021011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.05

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(413021010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 42
				local var_44_5 = utf8.len(var_44_3)
				local var_44_6 = var_44_4 <= 0 and var_44_1 or var_44_1 * (var_44_5 / var_44_4)

				if var_44_6 > 0 and var_44_1 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_7 and arg_41_1.time_ < var_44_0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play413021011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413021011
		arg_45_1.duration_ = 9.53

		local var_45_0 = {
			zh = 5.233,
			ja = 9.533
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
				arg_45_0:Play413021012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.55

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[36].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10098_split_1")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(413021011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021011", "story_v_out_413021.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021011", "story_v_out_413021.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_413021", "413021011", "story_v_out_413021.awb")

						arg_45_1:RecordAudio("413021011", var_48_9)
						arg_45_1:RecordAudio("413021011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413021", "413021011", "story_v_out_413021.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413021", "413021011", "story_v_out_413021.awb")
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
	Play413021012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413021012
		arg_49_1.duration_ = 6.9

		local var_49_0 = {
			zh = 5.665999999999,
			ja = 6.899999999999
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
				arg_49_0:Play413021013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = "F08f"

			if arg_49_1.bgs_[var_52_0] == nil then
				local var_52_1 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_52_0)
				var_52_1.name = var_52_0
				var_52_1.transform.parent = arg_49_1.stage_.transform
				var_52_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_[var_52_0] = var_52_1
			end

			local var_52_2 = 2

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				local var_52_3 = manager.ui.mainCamera.transform.localPosition
				local var_52_4 = Vector3.New(0, 0, 10) + Vector3.New(var_52_3.x, var_52_3.y, 0)
				local var_52_5 = arg_49_1.bgs_.F08f

				var_52_5.transform.localPosition = var_52_4
				var_52_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_6 = var_52_5:GetComponent("SpriteRenderer")

				if var_52_6 and var_52_6.sprite then
					local var_52_7 = (var_52_5.transform.localPosition - var_52_3).z
					local var_52_8 = manager.ui.mainCameraCom_
					local var_52_9 = 2 * var_52_7 * Mathf.Tan(var_52_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_52_10 = var_52_9 * var_52_8.aspect
					local var_52_11 = var_52_6.sprite.bounds.size.x
					local var_52_12 = var_52_6.sprite.bounds.size.y
					local var_52_13 = var_52_10 / var_52_11
					local var_52_14 = var_52_9 / var_52_12
					local var_52_15 = var_52_14 < var_52_13 and var_52_13 or var_52_14

					var_52_5.transform.localScale = Vector3.New(var_52_15, var_52_15, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "F08f" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_16 = 3.999999999999

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			local var_52_17 = 0.3

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			local var_52_18 = 0

			if var_52_18 < arg_49_1.time_ and arg_49_1.time_ <= var_52_18 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_19 = 2

			if var_52_18 <= arg_49_1.time_ and arg_49_1.time_ < var_52_18 + var_52_19 then
				local var_52_20 = (arg_49_1.time_ - var_52_18) / var_52_19
				local var_52_21 = Color.New(0, 0, 0)

				var_52_21.a = Mathf.Lerp(0, 1, var_52_20)
				arg_49_1.mask_.color = var_52_21
			end

			if arg_49_1.time_ >= var_52_18 + var_52_19 and arg_49_1.time_ < var_52_18 + var_52_19 + arg_52_0 then
				local var_52_22 = Color.New(0, 0, 0)

				var_52_22.a = 1
				arg_49_1.mask_.color = var_52_22
			end

			local var_52_23 = 2

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_24 = 2

			if var_52_23 <= arg_49_1.time_ and arg_49_1.time_ < var_52_23 + var_52_24 then
				local var_52_25 = (arg_49_1.time_ - var_52_23) / var_52_24
				local var_52_26 = Color.New(0, 0, 0)

				var_52_26.a = Mathf.Lerp(1, 0, var_52_25)
				arg_49_1.mask_.color = var_52_26
			end

			if arg_49_1.time_ >= var_52_23 + var_52_24 and arg_49_1.time_ < var_52_23 + var_52_24 + arg_52_0 then
				local var_52_27 = Color.New(0, 0, 0)
				local var_52_28 = 0

				arg_49_1.mask_.enabled = false
				var_52_27.a = var_52_28
				arg_49_1.mask_.color = var_52_27
			end

			local var_52_29 = "10022"

			if arg_49_1.actors_[var_52_29] == nil then
				local var_52_30 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_52_30) then
					local var_52_31 = Object.Instantiate(var_52_30, arg_49_1.canvasGo_.transform)

					var_52_31.transform:SetSiblingIndex(1)

					var_52_31.name = var_52_29
					var_52_31.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_49_1.actors_[var_52_29] = var_52_31

					local var_52_32 = var_52_31:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_49_1.isInRecall_ then
						for iter_52_2, iter_52_3 in ipairs(var_52_32) do
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_52_33 = arg_49_1.actors_["10022"].transform
			local var_52_34 = 3.8

			if var_52_34 < arg_49_1.time_ and arg_49_1.time_ <= var_52_34 + arg_52_0 then
				arg_49_1.var_.moveOldPos10022 = var_52_33.localPosition
				var_52_33.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10022", 2)

				local var_52_35 = var_52_33.childCount

				for iter_52_4 = 0, var_52_35 - 1 do
					local var_52_36 = var_52_33:GetChild(iter_52_4)

					if var_52_36.name == "split_6" or not string.find(var_52_36.name, "split") then
						var_52_36.gameObject:SetActive(true)
					else
						var_52_36.gameObject:SetActive(false)
					end
				end
			end

			local var_52_37 = 0.001

			if var_52_34 <= arg_49_1.time_ and arg_49_1.time_ < var_52_34 + var_52_37 then
				local var_52_38 = (arg_49_1.time_ - var_52_34) / var_52_37
				local var_52_39 = Vector3.New(-390, -315, -320)

				var_52_33.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10022, var_52_39, var_52_38)
			end

			if arg_49_1.time_ >= var_52_34 + var_52_37 and arg_49_1.time_ < var_52_34 + var_52_37 + arg_52_0 then
				var_52_33.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_52_40 = arg_49_1.actors_["10022"]
			local var_52_41 = 3.8

			if var_52_41 < arg_49_1.time_ and arg_49_1.time_ <= var_52_41 + arg_52_0 and not isNil(var_52_40) and arg_49_1.var_.actorSpriteComps10022 == nil then
				arg_49_1.var_.actorSpriteComps10022 = var_52_40:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_42 = 0.2

			if var_52_41 <= arg_49_1.time_ and arg_49_1.time_ < var_52_41 + var_52_42 and not isNil(var_52_40) then
				local var_52_43 = (arg_49_1.time_ - var_52_41) / var_52_42

				if arg_49_1.var_.actorSpriteComps10022 then
					for iter_52_5, iter_52_6 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_52_6 then
							if arg_49_1.isInRecall_ then
								local var_52_44 = Mathf.Lerp(iter_52_6.color.r, arg_49_1.hightColor1.r, var_52_43)
								local var_52_45 = Mathf.Lerp(iter_52_6.color.g, arg_49_1.hightColor1.g, var_52_43)
								local var_52_46 = Mathf.Lerp(iter_52_6.color.b, arg_49_1.hightColor1.b, var_52_43)

								iter_52_6.color = Color.New(var_52_44, var_52_45, var_52_46)
							else
								local var_52_47 = Mathf.Lerp(iter_52_6.color.r, 1, var_52_43)

								iter_52_6.color = Color.New(var_52_47, var_52_47, var_52_47)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_41 + var_52_42 and arg_49_1.time_ < var_52_41 + var_52_42 + arg_52_0 and not isNil(var_52_40) and arg_49_1.var_.actorSpriteComps10022 then
				for iter_52_7, iter_52_8 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_52_8 then
						if arg_49_1.isInRecall_ then
							iter_52_8.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10022 = nil
			end

			local var_52_48 = arg_49_1.actors_["10022"]
			local var_52_49 = 3.8

			if var_52_49 < arg_49_1.time_ and arg_49_1.time_ <= var_52_49 + arg_52_0 then
				local var_52_50 = var_52_48:GetComponentInChildren(typeof(CanvasGroup))

				if var_52_50 then
					arg_49_1.var_.alphaOldValue10022 = var_52_50.alpha
					arg_49_1.var_.characterEffect10022 = var_52_50
				end

				arg_49_1.var_.alphaOldValue10022 = 0
			end

			local var_52_51 = 0.5

			if var_52_49 <= arg_49_1.time_ and arg_49_1.time_ < var_52_49 + var_52_51 then
				local var_52_52 = (arg_49_1.time_ - var_52_49) / var_52_51
				local var_52_53 = Mathf.Lerp(arg_49_1.var_.alphaOldValue10022, 1, var_52_52)

				if arg_49_1.var_.characterEffect10022 then
					arg_49_1.var_.characterEffect10022.alpha = var_52_53
				end
			end

			if arg_49_1.time_ >= var_52_49 + var_52_51 and arg_49_1.time_ < var_52_49 + var_52_51 + arg_52_0 and arg_49_1.var_.characterEffect10022 then
				arg_49_1.var_.characterEffect10022.alpha = 1
			end

			local var_52_54 = 0
			local var_52_55 = 0.833333333333333

			if var_52_54 < arg_49_1.time_ and arg_49_1.time_ <= var_52_54 + arg_52_0 then
				local var_52_56 = "play"
				local var_52_57 = "music"

				arg_49_1:AudioAction(var_52_56, var_52_57, "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete.awb")

				local var_52_58 = ""
				local var_52_59 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete")

				if var_52_59 ~= "" then
					if arg_49_1.bgmTxt_.text ~= var_52_59 and arg_49_1.bgmTxt_.text ~= "" then
						if arg_49_1.bgmTxt2_.text ~= "" then
							arg_49_1.bgmTxt_.text = arg_49_1.bgmTxt2_.text
						end

						arg_49_1.bgmTxt2_.text = var_52_59

						arg_49_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_49_1.bgmTxt_.text = var_52_59
						arg_49_1.bgmTxt2_.text = var_52_59
					end

					if arg_49_1.bgmTimer then
						arg_49_1.bgmTimer:Stop()

						arg_49_1.bgmTimer = nil
					end

					if arg_49_1.settingData.show_music_name == 1 then
						arg_49_1.musicController:SetSelectedState("show")
						arg_49_1.musicAnimator_:Play("open", 0, 0)

						if arg_49_1.settingData.music_time ~= 0 then
							arg_49_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_49_1.settingData.music_time), function()
								if arg_49_1 == nil or isNil(arg_49_1.bgmTxt_) then
									return
								end

								arg_49_1.musicController:SetSelectedState("hide")
								arg_49_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_60 = 3.999999999999
			local var_52_61 = 0.2

			if var_52_60 < arg_49_1.time_ and arg_49_1.time_ <= var_52_60 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_62 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_62:setOnUpdate(LuaHelper.FloatAction(function(arg_54_0)
					arg_49_1.dialogCg_.alpha = arg_54_0
				end))
				var_52_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_63 = arg_49_1:FormatText(StoryNameCfg[614].name)

				arg_49_1.leftNameTxt_.text = var_52_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_64 = arg_49_1:GetWordFromCfg(413021012)
				local var_52_65 = arg_49_1:FormatText(var_52_64.content)

				arg_49_1.text_.text = var_52_65

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_66 = 8
				local var_52_67 = utf8.len(var_52_65)
				local var_52_68 = var_52_66 <= 0 and var_52_61 or var_52_61 * (var_52_67 / var_52_66)

				if var_52_68 > 0 and var_52_61 < var_52_68 then
					arg_49_1.talkMaxDuration = var_52_68
					var_52_60 = var_52_60 + 0.3

					if var_52_68 + var_52_60 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_68 + var_52_60
					end
				end

				arg_49_1.text_.text = var_52_65
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021012", "story_v_out_413021.awb") ~= 0 then
					local var_52_69 = manager.audio:GetVoiceLength("story_v_out_413021", "413021012", "story_v_out_413021.awb") / 1000

					if var_52_69 + var_52_60 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_69 + var_52_60
					end

					if var_52_64.prefab_name ~= "" and arg_49_1.actors_[var_52_64.prefab_name] ~= nil then
						local var_52_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_64.prefab_name].transform, "story_v_out_413021", "413021012", "story_v_out_413021.awb")

						arg_49_1:RecordAudio("413021012", var_52_70)
						arg_49_1:RecordAudio("413021012", var_52_70)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413021", "413021012", "story_v_out_413021.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413021", "413021012", "story_v_out_413021.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_71 = var_52_60 + 0.3
			local var_52_72 = math.max(var_52_61, arg_49_1.talkMaxDuration)

			if var_52_71 <= arg_49_1.time_ and arg_49_1.time_ < var_52_71 + var_52_72 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_71) / var_52_72

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_71 + var_52_72 and arg_49_1.time_ < var_52_71 + var_52_72 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play413021013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 413021013
		arg_56_1.duration_ = 3.47

		local var_56_0 = {
			zh = 3,
			ja = 3.466
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
				arg_56_0:Play413021014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = "10094"

			if arg_56_1.actors_[var_59_0] == nil then
				local var_59_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_59_1) then
					local var_59_2 = Object.Instantiate(var_59_1, arg_56_1.canvasGo_.transform)

					var_59_2.transform:SetSiblingIndex(1)

					var_59_2.name = var_59_0
					var_59_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_56_1.actors_[var_59_0] = var_59_2

					local var_59_3 = var_59_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_56_1.isInRecall_ then
						for iter_59_0, iter_59_1 in ipairs(var_59_3) do
							iter_59_1.color = arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_59_4 = arg_56_1.actors_["10094"].transform
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.var_.moveOldPos10094 = var_59_4.localPosition
				var_59_4.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("10094", 4)

				local var_59_6 = var_59_4.childCount

				for iter_59_2 = 0, var_59_6 - 1 do
					local var_59_7 = var_59_4:GetChild(iter_59_2)

					if var_59_7.name == "" or not string.find(var_59_7.name, "split") then
						var_59_7.gameObject:SetActive(true)
					else
						var_59_7.gameObject:SetActive(false)
					end
				end
			end

			local var_59_8 = 0.001

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_8 then
				local var_59_9 = (arg_56_1.time_ - var_59_5) / var_59_8
				local var_59_10 = Vector3.New(390, -340, -414)

				var_59_4.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10094, var_59_10, var_59_9)
			end

			if arg_56_1.time_ >= var_59_5 + var_59_8 and arg_56_1.time_ < var_59_5 + var_59_8 + arg_59_0 then
				var_59_4.localPosition = Vector3.New(390, -340, -414)
			end

			local var_59_11 = arg_56_1.actors_["10094"]
			local var_59_12 = 0

			if var_59_12 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 and not isNil(var_59_11) and arg_56_1.var_.actorSpriteComps10094 == nil then
				arg_56_1.var_.actorSpriteComps10094 = var_59_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_13 = 2

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_13 and not isNil(var_59_11) then
				local var_59_14 = (arg_56_1.time_ - var_59_12) / var_59_13

				if arg_56_1.var_.actorSpriteComps10094 then
					for iter_59_3, iter_59_4 in pairs(arg_56_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_59_4 then
							if arg_56_1.isInRecall_ then
								local var_59_15 = Mathf.Lerp(iter_59_4.color.r, arg_56_1.hightColor1.r, var_59_14)
								local var_59_16 = Mathf.Lerp(iter_59_4.color.g, arg_56_1.hightColor1.g, var_59_14)
								local var_59_17 = Mathf.Lerp(iter_59_4.color.b, arg_56_1.hightColor1.b, var_59_14)

								iter_59_4.color = Color.New(var_59_15, var_59_16, var_59_17)
							else
								local var_59_18 = Mathf.Lerp(iter_59_4.color.r, 1, var_59_14)

								iter_59_4.color = Color.New(var_59_18, var_59_18, var_59_18)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_12 + var_59_13 and arg_56_1.time_ < var_59_12 + var_59_13 + arg_59_0 and not isNil(var_59_11) and arg_56_1.var_.actorSpriteComps10094 then
				for iter_59_5, iter_59_6 in pairs(arg_56_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_59_6 then
						if arg_56_1.isInRecall_ then
							iter_59_6.color = arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_59_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps10094 = nil
			end

			local var_59_19 = arg_56_1.actors_["10022"]
			local var_59_20 = 0

			if var_59_20 < arg_56_1.time_ and arg_56_1.time_ <= var_59_20 + arg_59_0 and not isNil(var_59_19) and arg_56_1.var_.actorSpriteComps10022 == nil then
				arg_56_1.var_.actorSpriteComps10022 = var_59_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_21 = 2

			if var_59_20 <= arg_56_1.time_ and arg_56_1.time_ < var_59_20 + var_59_21 and not isNil(var_59_19) then
				local var_59_22 = (arg_56_1.time_ - var_59_20) / var_59_21

				if arg_56_1.var_.actorSpriteComps10022 then
					for iter_59_7, iter_59_8 in pairs(arg_56_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_59_8 then
							if arg_56_1.isInRecall_ then
								local var_59_23 = Mathf.Lerp(iter_59_8.color.r, arg_56_1.hightColor2.r, var_59_22)
								local var_59_24 = Mathf.Lerp(iter_59_8.color.g, arg_56_1.hightColor2.g, var_59_22)
								local var_59_25 = Mathf.Lerp(iter_59_8.color.b, arg_56_1.hightColor2.b, var_59_22)

								iter_59_8.color = Color.New(var_59_23, var_59_24, var_59_25)
							else
								local var_59_26 = Mathf.Lerp(iter_59_8.color.r, 0.5, var_59_22)

								iter_59_8.color = Color.New(var_59_26, var_59_26, var_59_26)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_20 + var_59_21 and arg_56_1.time_ < var_59_20 + var_59_21 + arg_59_0 and not isNil(var_59_19) and arg_56_1.var_.actorSpriteComps10022 then
				for iter_59_9, iter_59_10 in pairs(arg_56_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_59_10 then
						if arg_56_1.isInRecall_ then
							iter_59_10.color = arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_59_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps10022 = nil
			end

			local var_59_27 = arg_56_1.actors_["10094"]
			local var_59_28 = 0

			if var_59_28 < arg_56_1.time_ and arg_56_1.time_ <= var_59_28 + arg_59_0 then
				local var_59_29 = var_59_27:GetComponentInChildren(typeof(CanvasGroup))

				if var_59_29 then
					arg_56_1.var_.alphaOldValue10094 = var_59_29.alpha
					arg_56_1.var_.characterEffect10094 = var_59_29
				end

				arg_56_1.var_.alphaOldValue10094 = 0
			end

			local var_59_30 = 0.5

			if var_59_28 <= arg_56_1.time_ and arg_56_1.time_ < var_59_28 + var_59_30 then
				local var_59_31 = (arg_56_1.time_ - var_59_28) / var_59_30
				local var_59_32 = Mathf.Lerp(arg_56_1.var_.alphaOldValue10094, 1, var_59_31)

				if arg_56_1.var_.characterEffect10094 then
					arg_56_1.var_.characterEffect10094.alpha = var_59_32
				end
			end

			if arg_56_1.time_ >= var_59_28 + var_59_30 and arg_56_1.time_ < var_59_28 + var_59_30 + arg_59_0 and arg_56_1.var_.characterEffect10094 then
				arg_56_1.var_.characterEffect10094.alpha = 1
			end

			local var_59_33 = 0
			local var_59_34 = 0.375

			if var_59_33 < arg_56_1.time_ and arg_56_1.time_ <= var_59_33 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_35 = arg_56_1:FormatText(StoryNameCfg[259].name)

				arg_56_1.leftNameTxt_.text = var_59_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_36 = arg_56_1:GetWordFromCfg(413021013)
				local var_59_37 = arg_56_1:FormatText(var_59_36.content)

				arg_56_1.text_.text = var_59_37

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_38 = 15
				local var_59_39 = utf8.len(var_59_37)
				local var_59_40 = var_59_38 <= 0 and var_59_34 or var_59_34 * (var_59_39 / var_59_38)

				if var_59_40 > 0 and var_59_34 < var_59_40 then
					arg_56_1.talkMaxDuration = var_59_40

					if var_59_40 + var_59_33 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_40 + var_59_33
					end
				end

				arg_56_1.text_.text = var_59_37
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021013", "story_v_out_413021.awb") ~= 0 then
					local var_59_41 = manager.audio:GetVoiceLength("story_v_out_413021", "413021013", "story_v_out_413021.awb") / 1000

					if var_59_41 + var_59_33 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_41 + var_59_33
					end

					if var_59_36.prefab_name ~= "" and arg_56_1.actors_[var_59_36.prefab_name] ~= nil then
						local var_59_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_36.prefab_name].transform, "story_v_out_413021", "413021013", "story_v_out_413021.awb")

						arg_56_1:RecordAudio("413021013", var_59_42)
						arg_56_1:RecordAudio("413021013", var_59_42)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_413021", "413021013", "story_v_out_413021.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_413021", "413021013", "story_v_out_413021.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_43 = math.max(var_59_34, arg_56_1.talkMaxDuration)

			if var_59_33 <= arg_56_1.time_ and arg_56_1.time_ < var_59_33 + var_59_43 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_33) / var_59_43

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_33 + var_59_43 and arg_56_1.time_ < var_59_33 + var_59_43 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play413021014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 413021014
		arg_60_1.duration_ = 6.83

		local var_60_0 = {
			zh = 3.5,
			ja = 6.833
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
				arg_60_0:Play413021015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10022"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.actorSpriteComps10022 == nil then
				arg_60_1.var_.actorSpriteComps10022 = var_63_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_2 = 2

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.actorSpriteComps10022 then
					for iter_63_0, iter_63_1 in pairs(arg_60_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_63_1 then
							if arg_60_1.isInRecall_ then
								local var_63_4 = Mathf.Lerp(iter_63_1.color.r, arg_60_1.hightColor1.r, var_63_3)
								local var_63_5 = Mathf.Lerp(iter_63_1.color.g, arg_60_1.hightColor1.g, var_63_3)
								local var_63_6 = Mathf.Lerp(iter_63_1.color.b, arg_60_1.hightColor1.b, var_63_3)

								iter_63_1.color = Color.New(var_63_4, var_63_5, var_63_6)
							else
								local var_63_7 = Mathf.Lerp(iter_63_1.color.r, 1, var_63_3)

								iter_63_1.color = Color.New(var_63_7, var_63_7, var_63_7)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.actorSpriteComps10022 then
				for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_63_3 then
						if arg_60_1.isInRecall_ then
							iter_63_3.color = arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_63_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps10022 = nil
			end

			local var_63_8 = arg_60_1.actors_["10094"]
			local var_63_9 = 0

			if var_63_9 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.actorSpriteComps10094 == nil then
				arg_60_1.var_.actorSpriteComps10094 = var_63_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_10 = 2

			if var_63_9 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_10 and not isNil(var_63_8) then
				local var_63_11 = (arg_60_1.time_ - var_63_9) / var_63_10

				if arg_60_1.var_.actorSpriteComps10094 then
					for iter_63_4, iter_63_5 in pairs(arg_60_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_63_5 then
							if arg_60_1.isInRecall_ then
								local var_63_12 = Mathf.Lerp(iter_63_5.color.r, arg_60_1.hightColor2.r, var_63_11)
								local var_63_13 = Mathf.Lerp(iter_63_5.color.g, arg_60_1.hightColor2.g, var_63_11)
								local var_63_14 = Mathf.Lerp(iter_63_5.color.b, arg_60_1.hightColor2.b, var_63_11)

								iter_63_5.color = Color.New(var_63_12, var_63_13, var_63_14)
							else
								local var_63_15 = Mathf.Lerp(iter_63_5.color.r, 0.5, var_63_11)

								iter_63_5.color = Color.New(var_63_15, var_63_15, var_63_15)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= var_63_9 + var_63_10 and arg_60_1.time_ < var_63_9 + var_63_10 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.actorSpriteComps10094 then
				for iter_63_6, iter_63_7 in pairs(arg_60_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_63_7 then
						if arg_60_1.isInRecall_ then
							iter_63_7.color = arg_60_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_63_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_60_1.var_.actorSpriteComps10094 = nil
			end

			local var_63_16 = 0
			local var_63_17 = 0.6

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_18 = arg_60_1:FormatText(StoryNameCfg[614].name)

				arg_60_1.leftNameTxt_.text = var_63_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_19 = arg_60_1:GetWordFromCfg(413021014)
				local var_63_20 = arg_60_1:FormatText(var_63_19.content)

				arg_60_1.text_.text = var_63_20

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_21 = 24
				local var_63_22 = utf8.len(var_63_20)
				local var_63_23 = var_63_21 <= 0 and var_63_17 or var_63_17 * (var_63_22 / var_63_21)

				if var_63_23 > 0 and var_63_17 < var_63_23 then
					arg_60_1.talkMaxDuration = var_63_23

					if var_63_23 + var_63_16 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_16
					end
				end

				arg_60_1.text_.text = var_63_20
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021014", "story_v_out_413021.awb") ~= 0 then
					local var_63_24 = manager.audio:GetVoiceLength("story_v_out_413021", "413021014", "story_v_out_413021.awb") / 1000

					if var_63_24 + var_63_16 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_24 + var_63_16
					end

					if var_63_19.prefab_name ~= "" and arg_60_1.actors_[var_63_19.prefab_name] ~= nil then
						local var_63_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_19.prefab_name].transform, "story_v_out_413021", "413021014", "story_v_out_413021.awb")

						arg_60_1:RecordAudio("413021014", var_63_25)
						arg_60_1:RecordAudio("413021014", var_63_25)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_413021", "413021014", "story_v_out_413021.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_413021", "413021014", "story_v_out_413021.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_26 = math.max(var_63_17, arg_60_1.talkMaxDuration)

			if var_63_16 <= arg_60_1.time_ and arg_60_1.time_ < var_63_16 + var_63_26 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_16) / var_63_26

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_16 + var_63_26 and arg_60_1.time_ < var_63_16 + var_63_26 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play413021015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 413021015
		arg_64_1.duration_ = 5.17

		local var_64_0 = {
			zh = 5.166,
			ja = 4.966
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
				arg_64_0:Play413021016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10094"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos10094 = var_67_0.localPosition
				var_67_0.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("10094", 4)

				local var_67_2 = var_67_0.childCount

				for iter_67_0 = 0, var_67_2 - 1 do
					local var_67_3 = var_67_0:GetChild(iter_67_0)

					if var_67_3.name == "" or not string.find(var_67_3.name, "split") then
						var_67_3.gameObject:SetActive(true)
					else
						var_67_3.gameObject:SetActive(false)
					end
				end
			end

			local var_67_4 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_4 then
				local var_67_5 = (arg_64_1.time_ - var_67_1) / var_67_4
				local var_67_6 = Vector3.New(390, -340, -414)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10094, var_67_6, var_67_5)
			end

			if arg_64_1.time_ >= var_67_1 + var_67_4 and arg_64_1.time_ < var_67_1 + var_67_4 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_67_7 = arg_64_1.actors_["10094"]
			local var_67_8 = 0

			if var_67_8 < arg_64_1.time_ and arg_64_1.time_ <= var_67_8 + arg_67_0 and not isNil(var_67_7) and arg_64_1.var_.actorSpriteComps10094 == nil then
				arg_64_1.var_.actorSpriteComps10094 = var_67_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_9 = 2

			if var_67_8 <= arg_64_1.time_ and arg_64_1.time_ < var_67_8 + var_67_9 and not isNil(var_67_7) then
				local var_67_10 = (arg_64_1.time_ - var_67_8) / var_67_9

				if arg_64_1.var_.actorSpriteComps10094 then
					for iter_67_1, iter_67_2 in pairs(arg_64_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_67_2 then
							if arg_64_1.isInRecall_ then
								local var_67_11 = Mathf.Lerp(iter_67_2.color.r, arg_64_1.hightColor1.r, var_67_10)
								local var_67_12 = Mathf.Lerp(iter_67_2.color.g, arg_64_1.hightColor1.g, var_67_10)
								local var_67_13 = Mathf.Lerp(iter_67_2.color.b, arg_64_1.hightColor1.b, var_67_10)

								iter_67_2.color = Color.New(var_67_11, var_67_12, var_67_13)
							else
								local var_67_14 = Mathf.Lerp(iter_67_2.color.r, 1, var_67_10)

								iter_67_2.color = Color.New(var_67_14, var_67_14, var_67_14)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_8 + var_67_9 and arg_64_1.time_ < var_67_8 + var_67_9 + arg_67_0 and not isNil(var_67_7) and arg_64_1.var_.actorSpriteComps10094 then
				for iter_67_3, iter_67_4 in pairs(arg_64_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_67_4 then
						if arg_64_1.isInRecall_ then
							iter_67_4.color = arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_67_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps10094 = nil
			end

			local var_67_15 = arg_64_1.actors_["10022"]
			local var_67_16 = 0

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 and not isNil(var_67_15) and arg_64_1.var_.actorSpriteComps10022 == nil then
				arg_64_1.var_.actorSpriteComps10022 = var_67_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_17 = 2

			if var_67_16 <= arg_64_1.time_ and arg_64_1.time_ < var_67_16 + var_67_17 and not isNil(var_67_15) then
				local var_67_18 = (arg_64_1.time_ - var_67_16) / var_67_17

				if arg_64_1.var_.actorSpriteComps10022 then
					for iter_67_5, iter_67_6 in pairs(arg_64_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_67_6 then
							if arg_64_1.isInRecall_ then
								local var_67_19 = Mathf.Lerp(iter_67_6.color.r, arg_64_1.hightColor2.r, var_67_18)
								local var_67_20 = Mathf.Lerp(iter_67_6.color.g, arg_64_1.hightColor2.g, var_67_18)
								local var_67_21 = Mathf.Lerp(iter_67_6.color.b, arg_64_1.hightColor2.b, var_67_18)

								iter_67_6.color = Color.New(var_67_19, var_67_20, var_67_21)
							else
								local var_67_22 = Mathf.Lerp(iter_67_6.color.r, 0.5, var_67_18)

								iter_67_6.color = Color.New(var_67_22, var_67_22, var_67_22)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= var_67_16 + var_67_17 and arg_64_1.time_ < var_67_16 + var_67_17 + arg_67_0 and not isNil(var_67_15) and arg_64_1.var_.actorSpriteComps10022 then
				for iter_67_7, iter_67_8 in pairs(arg_64_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_67_8 then
						if arg_64_1.isInRecall_ then
							iter_67_8.color = arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_67_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_64_1.var_.actorSpriteComps10022 = nil
			end

			local var_67_23 = 0
			local var_67_24 = 0.5

			if var_67_23 < arg_64_1.time_ and arg_64_1.time_ <= var_67_23 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_25 = arg_64_1:FormatText(StoryNameCfg[259].name)

				arg_64_1.leftNameTxt_.text = var_67_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_26 = arg_64_1:GetWordFromCfg(413021015)
				local var_67_27 = arg_64_1:FormatText(var_67_26.content)

				arg_64_1.text_.text = var_67_27

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_28 = 20
				local var_67_29 = utf8.len(var_67_27)
				local var_67_30 = var_67_28 <= 0 and var_67_24 or var_67_24 * (var_67_29 / var_67_28)

				if var_67_30 > 0 and var_67_24 < var_67_30 then
					arg_64_1.talkMaxDuration = var_67_30

					if var_67_30 + var_67_23 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_30 + var_67_23
					end
				end

				arg_64_1.text_.text = var_67_27
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021015", "story_v_out_413021.awb") ~= 0 then
					local var_67_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021015", "story_v_out_413021.awb") / 1000

					if var_67_31 + var_67_23 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_31 + var_67_23
					end

					if var_67_26.prefab_name ~= "" and arg_64_1.actors_[var_67_26.prefab_name] ~= nil then
						local var_67_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_26.prefab_name].transform, "story_v_out_413021", "413021015", "story_v_out_413021.awb")

						arg_64_1:RecordAudio("413021015", var_67_32)
						arg_64_1:RecordAudio("413021015", var_67_32)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_413021", "413021015", "story_v_out_413021.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_413021", "413021015", "story_v_out_413021.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_33 = math.max(var_67_24, arg_64_1.talkMaxDuration)

			if var_67_23 <= arg_64_1.time_ and arg_64_1.time_ < var_67_23 + var_67_33 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_23) / var_67_33

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_23 + var_67_33 and arg_64_1.time_ < var_67_23 + var_67_33 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play413021016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 413021016
		arg_68_1.duration_ = 9

		local var_68_0 = {
			zh = 3.633,
			ja = 9
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
				arg_68_0:Play413021017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10022"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10022 == nil then
				arg_68_1.var_.actorSpriteComps10022 = var_71_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_2 = 2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.actorSpriteComps10022 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_71_1 then
							if arg_68_1.isInRecall_ then
								local var_71_4 = Mathf.Lerp(iter_71_1.color.r, arg_68_1.hightColor1.r, var_71_3)
								local var_71_5 = Mathf.Lerp(iter_71_1.color.g, arg_68_1.hightColor1.g, var_71_3)
								local var_71_6 = Mathf.Lerp(iter_71_1.color.b, arg_68_1.hightColor1.b, var_71_3)

								iter_71_1.color = Color.New(var_71_4, var_71_5, var_71_6)
							else
								local var_71_7 = Mathf.Lerp(iter_71_1.color.r, 1, var_71_3)

								iter_71_1.color = Color.New(var_71_7, var_71_7, var_71_7)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10022 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_71_3 then
						if arg_68_1.isInRecall_ then
							iter_71_3.color = arg_68_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_71_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps10022 = nil
			end

			local var_71_8 = arg_68_1.actors_["10094"]
			local var_71_9 = 0

			if var_71_9 < arg_68_1.time_ and arg_68_1.time_ <= var_71_9 + arg_71_0 and not isNil(var_71_8) and arg_68_1.var_.actorSpriteComps10094 == nil then
				arg_68_1.var_.actorSpriteComps10094 = var_71_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_10 = 2

			if var_71_9 <= arg_68_1.time_ and arg_68_1.time_ < var_71_9 + var_71_10 and not isNil(var_71_8) then
				local var_71_11 = (arg_68_1.time_ - var_71_9) / var_71_10

				if arg_68_1.var_.actorSpriteComps10094 then
					for iter_71_4, iter_71_5 in pairs(arg_68_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_71_5 then
							if arg_68_1.isInRecall_ then
								local var_71_12 = Mathf.Lerp(iter_71_5.color.r, arg_68_1.hightColor2.r, var_71_11)
								local var_71_13 = Mathf.Lerp(iter_71_5.color.g, arg_68_1.hightColor2.g, var_71_11)
								local var_71_14 = Mathf.Lerp(iter_71_5.color.b, arg_68_1.hightColor2.b, var_71_11)

								iter_71_5.color = Color.New(var_71_12, var_71_13, var_71_14)
							else
								local var_71_15 = Mathf.Lerp(iter_71_5.color.r, 0.5, var_71_11)

								iter_71_5.color = Color.New(var_71_15, var_71_15, var_71_15)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= var_71_9 + var_71_10 and arg_68_1.time_ < var_71_9 + var_71_10 + arg_71_0 and not isNil(var_71_8) and arg_68_1.var_.actorSpriteComps10094 then
				for iter_71_6, iter_71_7 in pairs(arg_68_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_71_7 then
						if arg_68_1.isInRecall_ then
							iter_71_7.color = arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_71_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps10094 = nil
			end

			local var_71_16 = 0
			local var_71_17 = 0.425

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_18 = arg_68_1:FormatText(StoryNameCfg[614].name)

				arg_68_1.leftNameTxt_.text = var_71_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_19 = arg_68_1:GetWordFromCfg(413021016)
				local var_71_20 = arg_68_1:FormatText(var_71_19.content)

				arg_68_1.text_.text = var_71_20

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_21 = 17
				local var_71_22 = utf8.len(var_71_20)
				local var_71_23 = var_71_21 <= 0 and var_71_17 or var_71_17 * (var_71_22 / var_71_21)

				if var_71_23 > 0 and var_71_17 < var_71_23 then
					arg_68_1.talkMaxDuration = var_71_23

					if var_71_23 + var_71_16 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_23 + var_71_16
					end
				end

				arg_68_1.text_.text = var_71_20
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021016", "story_v_out_413021.awb") ~= 0 then
					local var_71_24 = manager.audio:GetVoiceLength("story_v_out_413021", "413021016", "story_v_out_413021.awb") / 1000

					if var_71_24 + var_71_16 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_24 + var_71_16
					end

					if var_71_19.prefab_name ~= "" and arg_68_1.actors_[var_71_19.prefab_name] ~= nil then
						local var_71_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_19.prefab_name].transform, "story_v_out_413021", "413021016", "story_v_out_413021.awb")

						arg_68_1:RecordAudio("413021016", var_71_25)
						arg_68_1:RecordAudio("413021016", var_71_25)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_413021", "413021016", "story_v_out_413021.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_413021", "413021016", "story_v_out_413021.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_26 = math.max(var_71_17, arg_68_1.talkMaxDuration)

			if var_71_16 <= arg_68_1.time_ and arg_68_1.time_ < var_71_16 + var_71_26 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_16) / var_71_26

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_16 + var_71_26 and arg_68_1.time_ < var_71_16 + var_71_26 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play413021017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 413021017
		arg_72_1.duration_ = 4.77

		local var_72_0 = {
			zh = 4.766,
			ja = 4.7
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play413021018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["10094"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos10094 = var_75_0.localPosition
				var_75_0.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("10094", 4)

				local var_75_2 = var_75_0.childCount

				for iter_75_0 = 0, var_75_2 - 1 do
					local var_75_3 = var_75_0:GetChild(iter_75_0)

					if var_75_3.name == "" or not string.find(var_75_3.name, "split") then
						var_75_3.gameObject:SetActive(true)
					else
						var_75_3.gameObject:SetActive(false)
					end
				end
			end

			local var_75_4 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_4 then
				local var_75_5 = (arg_72_1.time_ - var_75_1) / var_75_4
				local var_75_6 = Vector3.New(390, -340, -414)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10094, var_75_6, var_75_5)
			end

			if arg_72_1.time_ >= var_75_1 + var_75_4 and arg_72_1.time_ < var_75_1 + var_75_4 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_75_7 = arg_72_1.actors_["10094"]
			local var_75_8 = 0

			if var_75_8 < arg_72_1.time_ and arg_72_1.time_ <= var_75_8 + arg_75_0 and not isNil(var_75_7) and arg_72_1.var_.actorSpriteComps10094 == nil then
				arg_72_1.var_.actorSpriteComps10094 = var_75_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_9 = 2

			if var_75_8 <= arg_72_1.time_ and arg_72_1.time_ < var_75_8 + var_75_9 and not isNil(var_75_7) then
				local var_75_10 = (arg_72_1.time_ - var_75_8) / var_75_9

				if arg_72_1.var_.actorSpriteComps10094 then
					for iter_75_1, iter_75_2 in pairs(arg_72_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_75_2 then
							if arg_72_1.isInRecall_ then
								local var_75_11 = Mathf.Lerp(iter_75_2.color.r, arg_72_1.hightColor1.r, var_75_10)
								local var_75_12 = Mathf.Lerp(iter_75_2.color.g, arg_72_1.hightColor1.g, var_75_10)
								local var_75_13 = Mathf.Lerp(iter_75_2.color.b, arg_72_1.hightColor1.b, var_75_10)

								iter_75_2.color = Color.New(var_75_11, var_75_12, var_75_13)
							else
								local var_75_14 = Mathf.Lerp(iter_75_2.color.r, 1, var_75_10)

								iter_75_2.color = Color.New(var_75_14, var_75_14, var_75_14)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= var_75_8 + var_75_9 and arg_72_1.time_ < var_75_8 + var_75_9 + arg_75_0 and not isNil(var_75_7) and arg_72_1.var_.actorSpriteComps10094 then
				for iter_75_3, iter_75_4 in pairs(arg_72_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_75_4 then
						if arg_72_1.isInRecall_ then
							iter_75_4.color = arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_75_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps10094 = nil
			end

			local var_75_15 = arg_72_1.actors_["10022"]
			local var_75_16 = 0

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 and not isNil(var_75_15) and arg_72_1.var_.actorSpriteComps10022 == nil then
				arg_72_1.var_.actorSpriteComps10022 = var_75_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_17 = 2

			if var_75_16 <= arg_72_1.time_ and arg_72_1.time_ < var_75_16 + var_75_17 and not isNil(var_75_15) then
				local var_75_18 = (arg_72_1.time_ - var_75_16) / var_75_17

				if arg_72_1.var_.actorSpriteComps10022 then
					for iter_75_5, iter_75_6 in pairs(arg_72_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_75_6 then
							if arg_72_1.isInRecall_ then
								local var_75_19 = Mathf.Lerp(iter_75_6.color.r, arg_72_1.hightColor2.r, var_75_18)
								local var_75_20 = Mathf.Lerp(iter_75_6.color.g, arg_72_1.hightColor2.g, var_75_18)
								local var_75_21 = Mathf.Lerp(iter_75_6.color.b, arg_72_1.hightColor2.b, var_75_18)

								iter_75_6.color = Color.New(var_75_19, var_75_20, var_75_21)
							else
								local var_75_22 = Mathf.Lerp(iter_75_6.color.r, 0.5, var_75_18)

								iter_75_6.color = Color.New(var_75_22, var_75_22, var_75_22)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= var_75_16 + var_75_17 and arg_72_1.time_ < var_75_16 + var_75_17 + arg_75_0 and not isNil(var_75_15) and arg_72_1.var_.actorSpriteComps10022 then
				for iter_75_7, iter_75_8 in pairs(arg_72_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_75_8 then
						if arg_72_1.isInRecall_ then
							iter_75_8.color = arg_72_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_75_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps10022 = nil
			end

			local var_75_23 = 0
			local var_75_24 = 0.475

			if var_75_23 < arg_72_1.time_ and arg_72_1.time_ <= var_75_23 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_25 = arg_72_1:FormatText(StoryNameCfg[259].name)

				arg_72_1.leftNameTxt_.text = var_75_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_26 = arg_72_1:GetWordFromCfg(413021017)
				local var_75_27 = arg_72_1:FormatText(var_75_26.content)

				arg_72_1.text_.text = var_75_27

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_28 = 19
				local var_75_29 = utf8.len(var_75_27)
				local var_75_30 = var_75_28 <= 0 and var_75_24 or var_75_24 * (var_75_29 / var_75_28)

				if var_75_30 > 0 and var_75_24 < var_75_30 then
					arg_72_1.talkMaxDuration = var_75_30

					if var_75_30 + var_75_23 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_30 + var_75_23
					end
				end

				arg_72_1.text_.text = var_75_27
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021017", "story_v_out_413021.awb") ~= 0 then
					local var_75_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021017", "story_v_out_413021.awb") / 1000

					if var_75_31 + var_75_23 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_31 + var_75_23
					end

					if var_75_26.prefab_name ~= "" and arg_72_1.actors_[var_75_26.prefab_name] ~= nil then
						local var_75_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_26.prefab_name].transform, "story_v_out_413021", "413021017", "story_v_out_413021.awb")

						arg_72_1:RecordAudio("413021017", var_75_32)
						arg_72_1:RecordAudio("413021017", var_75_32)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_413021", "413021017", "story_v_out_413021.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_413021", "413021017", "story_v_out_413021.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_33 = math.max(var_75_24, arg_72_1.talkMaxDuration)

			if var_75_23 <= arg_72_1.time_ and arg_72_1.time_ < var_75_23 + var_75_33 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_23) / var_75_33

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_23 + var_75_33 and arg_72_1.time_ < var_75_23 + var_75_33 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play413021018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 413021018
		arg_76_1.duration_ = 7.4

		local var_76_0 = {
			zh = 5.166,
			ja = 7.4
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
				arg_76_0:Play413021019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10022"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10022 == nil then
				arg_76_1.var_.actorSpriteComps10022 = var_79_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_2 = 2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.actorSpriteComps10022 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								local var_79_4 = Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor1.r, var_79_3)
								local var_79_5 = Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor1.g, var_79_3)
								local var_79_6 = Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor1.b, var_79_3)

								iter_79_1.color = Color.New(var_79_4, var_79_5, var_79_6)
							else
								local var_79_7 = Mathf.Lerp(iter_79_1.color.r, 1, var_79_3)

								iter_79_1.color = Color.New(var_79_7, var_79_7, var_79_7)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.actorSpriteComps10022 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_79_3 then
						if arg_76_1.isInRecall_ then
							iter_79_3.color = arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_79_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps10022 = nil
			end

			local var_79_8 = arg_76_1.actors_["10094"]
			local var_79_9 = 0

			if var_79_9 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps10094 == nil then
				arg_76_1.var_.actorSpriteComps10094 = var_79_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_10 = 2

			if var_79_9 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_10 and not isNil(var_79_8) then
				local var_79_11 = (arg_76_1.time_ - var_79_9) / var_79_10

				if arg_76_1.var_.actorSpriteComps10094 then
					for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_79_5 then
							if arg_76_1.isInRecall_ then
								local var_79_12 = Mathf.Lerp(iter_79_5.color.r, arg_76_1.hightColor2.r, var_79_11)
								local var_79_13 = Mathf.Lerp(iter_79_5.color.g, arg_76_1.hightColor2.g, var_79_11)
								local var_79_14 = Mathf.Lerp(iter_79_5.color.b, arg_76_1.hightColor2.b, var_79_11)

								iter_79_5.color = Color.New(var_79_12, var_79_13, var_79_14)
							else
								local var_79_15 = Mathf.Lerp(iter_79_5.color.r, 0.5, var_79_11)

								iter_79_5.color = Color.New(var_79_15, var_79_15, var_79_15)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= var_79_9 + var_79_10 and arg_76_1.time_ < var_79_9 + var_79_10 + arg_79_0 and not isNil(var_79_8) and arg_76_1.var_.actorSpriteComps10094 then
				for iter_79_6, iter_79_7 in pairs(arg_76_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_79_7 then
						if arg_76_1.isInRecall_ then
							iter_79_7.color = arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_79_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_76_1.var_.actorSpriteComps10094 = nil
			end

			local var_79_16 = 0
			local var_79_17 = 0.6

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_18 = arg_76_1:FormatText(StoryNameCfg[614].name)

				arg_76_1.leftNameTxt_.text = var_79_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_19 = arg_76_1:GetWordFromCfg(413021018)
				local var_79_20 = arg_76_1:FormatText(var_79_19.content)

				arg_76_1.text_.text = var_79_20

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_21 = 24
				local var_79_22 = utf8.len(var_79_20)
				local var_79_23 = var_79_21 <= 0 and var_79_17 or var_79_17 * (var_79_22 / var_79_21)

				if var_79_23 > 0 and var_79_17 < var_79_23 then
					arg_76_1.talkMaxDuration = var_79_23

					if var_79_23 + var_79_16 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_23 + var_79_16
					end
				end

				arg_76_1.text_.text = var_79_20
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021018", "story_v_out_413021.awb") ~= 0 then
					local var_79_24 = manager.audio:GetVoiceLength("story_v_out_413021", "413021018", "story_v_out_413021.awb") / 1000

					if var_79_24 + var_79_16 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_24 + var_79_16
					end

					if var_79_19.prefab_name ~= "" and arg_76_1.actors_[var_79_19.prefab_name] ~= nil then
						local var_79_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_19.prefab_name].transform, "story_v_out_413021", "413021018", "story_v_out_413021.awb")

						arg_76_1:RecordAudio("413021018", var_79_25)
						arg_76_1:RecordAudio("413021018", var_79_25)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_413021", "413021018", "story_v_out_413021.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_413021", "413021018", "story_v_out_413021.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_26 = math.max(var_79_17, arg_76_1.talkMaxDuration)

			if var_79_16 <= arg_76_1.time_ and arg_76_1.time_ < var_79_16 + var_79_26 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_16) / var_79_26

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_16 + var_79_26 and arg_76_1.time_ < var_79_16 + var_79_26 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play413021019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 413021019
		arg_80_1.duration_ = 8.1

		local var_80_0 = {
			zh = 7.933,
			ja = 8.1
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play413021020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 1

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[614].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:GetWordFromCfg(413021019)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 40
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_1 or var_83_1 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_1 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021019", "story_v_out_413021.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021019", "story_v_out_413021.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_413021", "413021019", "story_v_out_413021.awb")

						arg_80_1:RecordAudio("413021019", var_83_9)
						arg_80_1:RecordAudio("413021019", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_413021", "413021019", "story_v_out_413021.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_413021", "413021019", "story_v_out_413021.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_10 and arg_80_1.time_ < var_83_0 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play413021020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 413021020
		arg_84_1.duration_ = 6.83

		local var_84_0 = {
			zh = 5.6,
			ja = 6.833
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play413021021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.775

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[614].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:GetWordFromCfg(413021020)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 31
				local var_87_6 = utf8.len(var_87_4)
				local var_87_7 = var_87_5 <= 0 and var_87_1 or var_87_1 * (var_87_6 / var_87_5)

				if var_87_7 > 0 and var_87_1 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021020", "story_v_out_413021.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021020", "story_v_out_413021.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_413021", "413021020", "story_v_out_413021.awb")

						arg_84_1:RecordAudio("413021020", var_87_9)
						arg_84_1:RecordAudio("413021020", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_413021", "413021020", "story_v_out_413021.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_413021", "413021020", "story_v_out_413021.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_10 and arg_84_1.time_ < var_87_0 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play413021021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 413021021
		arg_88_1.duration_ = 14

		local var_88_0 = {
			zh = 11.6,
			ja = 14
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
				arg_88_0:Play413021022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["10094"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos10094 = var_91_0.localPosition
				var_91_0.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("10094", 4)

				local var_91_2 = var_91_0.childCount

				for iter_91_0 = 0, var_91_2 - 1 do
					local var_91_3 = var_91_0:GetChild(iter_91_0)

					if var_91_3.name == "" or not string.find(var_91_3.name, "split") then
						var_91_3.gameObject:SetActive(true)
					else
						var_91_3.gameObject:SetActive(false)
					end
				end
			end

			local var_91_4 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_4 then
				local var_91_5 = (arg_88_1.time_ - var_91_1) / var_91_4
				local var_91_6 = Vector3.New(390, -340, -414)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10094, var_91_6, var_91_5)
			end

			if arg_88_1.time_ >= var_91_1 + var_91_4 and arg_88_1.time_ < var_91_1 + var_91_4 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_91_7 = arg_88_1.actors_["10094"]
			local var_91_8 = 0

			if var_91_8 < arg_88_1.time_ and arg_88_1.time_ <= var_91_8 + arg_91_0 and not isNil(var_91_7) and arg_88_1.var_.actorSpriteComps10094 == nil then
				arg_88_1.var_.actorSpriteComps10094 = var_91_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_9 = 2

			if var_91_8 <= arg_88_1.time_ and arg_88_1.time_ < var_91_8 + var_91_9 and not isNil(var_91_7) then
				local var_91_10 = (arg_88_1.time_ - var_91_8) / var_91_9

				if arg_88_1.var_.actorSpriteComps10094 then
					for iter_91_1, iter_91_2 in pairs(arg_88_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_91_2 then
							if arg_88_1.isInRecall_ then
								local var_91_11 = Mathf.Lerp(iter_91_2.color.r, arg_88_1.hightColor1.r, var_91_10)
								local var_91_12 = Mathf.Lerp(iter_91_2.color.g, arg_88_1.hightColor1.g, var_91_10)
								local var_91_13 = Mathf.Lerp(iter_91_2.color.b, arg_88_1.hightColor1.b, var_91_10)

								iter_91_2.color = Color.New(var_91_11, var_91_12, var_91_13)
							else
								local var_91_14 = Mathf.Lerp(iter_91_2.color.r, 1, var_91_10)

								iter_91_2.color = Color.New(var_91_14, var_91_14, var_91_14)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_8 + var_91_9 and arg_88_1.time_ < var_91_8 + var_91_9 + arg_91_0 and not isNil(var_91_7) and arg_88_1.var_.actorSpriteComps10094 then
				for iter_91_3, iter_91_4 in pairs(arg_88_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_91_4 then
						if arg_88_1.isInRecall_ then
							iter_91_4.color = arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_91_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps10094 = nil
			end

			local var_91_15 = arg_88_1.actors_["10022"]
			local var_91_16 = 0

			if var_91_16 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 and not isNil(var_91_15) and arg_88_1.var_.actorSpriteComps10022 == nil then
				arg_88_1.var_.actorSpriteComps10022 = var_91_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_17 = 2

			if var_91_16 <= arg_88_1.time_ and arg_88_1.time_ < var_91_16 + var_91_17 and not isNil(var_91_15) then
				local var_91_18 = (arg_88_1.time_ - var_91_16) / var_91_17

				if arg_88_1.var_.actorSpriteComps10022 then
					for iter_91_5, iter_91_6 in pairs(arg_88_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_91_6 then
							if arg_88_1.isInRecall_ then
								local var_91_19 = Mathf.Lerp(iter_91_6.color.r, arg_88_1.hightColor2.r, var_91_18)
								local var_91_20 = Mathf.Lerp(iter_91_6.color.g, arg_88_1.hightColor2.g, var_91_18)
								local var_91_21 = Mathf.Lerp(iter_91_6.color.b, arg_88_1.hightColor2.b, var_91_18)

								iter_91_6.color = Color.New(var_91_19, var_91_20, var_91_21)
							else
								local var_91_22 = Mathf.Lerp(iter_91_6.color.r, 0.5, var_91_18)

								iter_91_6.color = Color.New(var_91_22, var_91_22, var_91_22)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_16 + var_91_17 and arg_88_1.time_ < var_91_16 + var_91_17 + arg_91_0 and not isNil(var_91_15) and arg_88_1.var_.actorSpriteComps10022 then
				for iter_91_7, iter_91_8 in pairs(arg_88_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_91_8 then
						if arg_88_1.isInRecall_ then
							iter_91_8.color = arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_91_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps10022 = nil
			end

			local var_91_23 = 0
			local var_91_24 = 1.25

			if var_91_23 < arg_88_1.time_ and arg_88_1.time_ <= var_91_23 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_25 = arg_88_1:FormatText(StoryNameCfg[259].name)

				arg_88_1.leftNameTxt_.text = var_91_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_26 = arg_88_1:GetWordFromCfg(413021021)
				local var_91_27 = arg_88_1:FormatText(var_91_26.content)

				arg_88_1.text_.text = var_91_27

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_28 = 50
				local var_91_29 = utf8.len(var_91_27)
				local var_91_30 = var_91_28 <= 0 and var_91_24 or var_91_24 * (var_91_29 / var_91_28)

				if var_91_30 > 0 and var_91_24 < var_91_30 then
					arg_88_1.talkMaxDuration = var_91_30

					if var_91_30 + var_91_23 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_30 + var_91_23
					end
				end

				arg_88_1.text_.text = var_91_27
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021021", "story_v_out_413021.awb") ~= 0 then
					local var_91_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021021", "story_v_out_413021.awb") / 1000

					if var_91_31 + var_91_23 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_31 + var_91_23
					end

					if var_91_26.prefab_name ~= "" and arg_88_1.actors_[var_91_26.prefab_name] ~= nil then
						local var_91_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_26.prefab_name].transform, "story_v_out_413021", "413021021", "story_v_out_413021.awb")

						arg_88_1:RecordAudio("413021021", var_91_32)
						arg_88_1:RecordAudio("413021021", var_91_32)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_413021", "413021021", "story_v_out_413021.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_413021", "413021021", "story_v_out_413021.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_33 = math.max(var_91_24, arg_88_1.talkMaxDuration)

			if var_91_23 <= arg_88_1.time_ and arg_88_1.time_ < var_91_23 + var_91_33 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_23) / var_91_33

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_23 + var_91_33 and arg_88_1.time_ < var_91_23 + var_91_33 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play413021022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 413021022
		arg_92_1.duration_ = 9.93

		local var_92_0 = {
			zh = 8.166,
			ja = 9.933
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
				arg_92_0:Play413021023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10022"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos10022 = var_95_0.localPosition
				var_95_0.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("10022", 2)

				local var_95_2 = var_95_0.childCount

				for iter_95_0 = 0, var_95_2 - 1 do
					local var_95_3 = var_95_0:GetChild(iter_95_0)

					if var_95_3.name == "split_3" or not string.find(var_95_3.name, "split") then
						var_95_3.gameObject:SetActive(true)
					else
						var_95_3.gameObject:SetActive(false)
					end
				end
			end

			local var_95_4 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_4 then
				local var_95_5 = (arg_92_1.time_ - var_95_1) / var_95_4
				local var_95_6 = Vector3.New(-390, -315, -320)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10022, var_95_6, var_95_5)
			end

			if arg_92_1.time_ >= var_95_1 + var_95_4 and arg_92_1.time_ < var_95_1 + var_95_4 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_95_7 = arg_92_1.actors_["10094"].transform
			local var_95_8 = 0

			if var_95_8 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.var_.moveOldPos10094 = var_95_7.localPosition
				var_95_7.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("10094", 4)

				local var_95_9 = var_95_7.childCount

				for iter_95_1 = 0, var_95_9 - 1 do
					local var_95_10 = var_95_7:GetChild(iter_95_1)

					if var_95_10.name == "" or not string.find(var_95_10.name, "split") then
						var_95_10.gameObject:SetActive(true)
					else
						var_95_10.gameObject:SetActive(false)
					end
				end
			end

			local var_95_11 = 0.001

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_11 then
				local var_95_12 = (arg_92_1.time_ - var_95_8) / var_95_11
				local var_95_13 = Vector3.New(390, -340, -414)

				var_95_7.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10094, var_95_13, var_95_12)
			end

			if arg_92_1.time_ >= var_95_8 + var_95_11 and arg_92_1.time_ < var_95_8 + var_95_11 + arg_95_0 then
				var_95_7.localPosition = Vector3.New(390, -340, -414)
			end

			local var_95_14 = arg_92_1.actors_["10022"]
			local var_95_15 = 0

			if var_95_15 < arg_92_1.time_ and arg_92_1.time_ <= var_95_15 + arg_95_0 and not isNil(var_95_14) and arg_92_1.var_.actorSpriteComps10022 == nil then
				arg_92_1.var_.actorSpriteComps10022 = var_95_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_16 = 2

			if var_95_15 <= arg_92_1.time_ and arg_92_1.time_ < var_95_15 + var_95_16 and not isNil(var_95_14) then
				local var_95_17 = (arg_92_1.time_ - var_95_15) / var_95_16

				if arg_92_1.var_.actorSpriteComps10022 then
					for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_95_3 then
							if arg_92_1.isInRecall_ then
								local var_95_18 = Mathf.Lerp(iter_95_3.color.r, arg_92_1.hightColor1.r, var_95_17)
								local var_95_19 = Mathf.Lerp(iter_95_3.color.g, arg_92_1.hightColor1.g, var_95_17)
								local var_95_20 = Mathf.Lerp(iter_95_3.color.b, arg_92_1.hightColor1.b, var_95_17)

								iter_95_3.color = Color.New(var_95_18, var_95_19, var_95_20)
							else
								local var_95_21 = Mathf.Lerp(iter_95_3.color.r, 1, var_95_17)

								iter_95_3.color = Color.New(var_95_21, var_95_21, var_95_21)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_15 + var_95_16 and arg_92_1.time_ < var_95_15 + var_95_16 + arg_95_0 and not isNil(var_95_14) and arg_92_1.var_.actorSpriteComps10022 then
				for iter_95_4, iter_95_5 in pairs(arg_92_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_95_5 then
						if arg_92_1.isInRecall_ then
							iter_95_5.color = arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_95_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps10022 = nil
			end

			local var_95_22 = arg_92_1.actors_["10094"]
			local var_95_23 = 0

			if var_95_23 < arg_92_1.time_ and arg_92_1.time_ <= var_95_23 + arg_95_0 and not isNil(var_95_22) and arg_92_1.var_.actorSpriteComps10094 == nil then
				arg_92_1.var_.actorSpriteComps10094 = var_95_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_24 = 2

			if var_95_23 <= arg_92_1.time_ and arg_92_1.time_ < var_95_23 + var_95_24 and not isNil(var_95_22) then
				local var_95_25 = (arg_92_1.time_ - var_95_23) / var_95_24

				if arg_92_1.var_.actorSpriteComps10094 then
					for iter_95_6, iter_95_7 in pairs(arg_92_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_95_7 then
							if arg_92_1.isInRecall_ then
								local var_95_26 = Mathf.Lerp(iter_95_7.color.r, arg_92_1.hightColor2.r, var_95_25)
								local var_95_27 = Mathf.Lerp(iter_95_7.color.g, arg_92_1.hightColor2.g, var_95_25)
								local var_95_28 = Mathf.Lerp(iter_95_7.color.b, arg_92_1.hightColor2.b, var_95_25)

								iter_95_7.color = Color.New(var_95_26, var_95_27, var_95_28)
							else
								local var_95_29 = Mathf.Lerp(iter_95_7.color.r, 0.5, var_95_25)

								iter_95_7.color = Color.New(var_95_29, var_95_29, var_95_29)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_23 + var_95_24 and arg_92_1.time_ < var_95_23 + var_95_24 + arg_95_0 and not isNil(var_95_22) and arg_92_1.var_.actorSpriteComps10094 then
				for iter_95_8, iter_95_9 in pairs(arg_92_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_95_9 then
						if arg_92_1.isInRecall_ then
							iter_95_9.color = arg_92_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_95_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps10094 = nil
			end

			local var_95_30 = 0
			local var_95_31 = 1.05

			if var_95_30 < arg_92_1.time_ and arg_92_1.time_ <= var_95_30 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_32 = arg_92_1:FormatText(StoryNameCfg[614].name)

				arg_92_1.leftNameTxt_.text = var_95_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_33 = arg_92_1:GetWordFromCfg(413021022)
				local var_95_34 = arg_92_1:FormatText(var_95_33.content)

				arg_92_1.text_.text = var_95_34

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_35 = 42
				local var_95_36 = utf8.len(var_95_34)
				local var_95_37 = var_95_35 <= 0 and var_95_31 or var_95_31 * (var_95_36 / var_95_35)

				if var_95_37 > 0 and var_95_31 < var_95_37 then
					arg_92_1.talkMaxDuration = var_95_37

					if var_95_37 + var_95_30 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_37 + var_95_30
					end
				end

				arg_92_1.text_.text = var_95_34
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021022", "story_v_out_413021.awb") ~= 0 then
					local var_95_38 = manager.audio:GetVoiceLength("story_v_out_413021", "413021022", "story_v_out_413021.awb") / 1000

					if var_95_38 + var_95_30 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_38 + var_95_30
					end

					if var_95_33.prefab_name ~= "" and arg_92_1.actors_[var_95_33.prefab_name] ~= nil then
						local var_95_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_33.prefab_name].transform, "story_v_out_413021", "413021022", "story_v_out_413021.awb")

						arg_92_1:RecordAudio("413021022", var_95_39)
						arg_92_1:RecordAudio("413021022", var_95_39)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_413021", "413021022", "story_v_out_413021.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_413021", "413021022", "story_v_out_413021.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_40 = math.max(var_95_31, arg_92_1.talkMaxDuration)

			if var_95_30 <= arg_92_1.time_ and arg_92_1.time_ < var_95_30 + var_95_40 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_30) / var_95_40

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_30 + var_95_40 and arg_92_1.time_ < var_95_30 + var_95_40 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play413021023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 413021023
		arg_96_1.duration_ = 7.27

		local var_96_0 = {
			zh = 3.8,
			ja = 7.266
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
				arg_96_0:Play413021024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10094"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps10094 == nil then
				arg_96_1.var_.actorSpriteComps10094 = var_99_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_2 = 2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.actorSpriteComps10094 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								local var_99_4 = Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor1.r, var_99_3)
								local var_99_5 = Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor1.g, var_99_3)
								local var_99_6 = Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor1.b, var_99_3)

								iter_99_1.color = Color.New(var_99_4, var_99_5, var_99_6)
							else
								local var_99_7 = Mathf.Lerp(iter_99_1.color.r, 1, var_99_3)

								iter_99_1.color = Color.New(var_99_7, var_99_7, var_99_7)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps10094 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_99_3 then
						if arg_96_1.isInRecall_ then
							iter_99_3.color = arg_96_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_99_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps10094 = nil
			end

			local var_99_8 = arg_96_1.actors_["10022"]
			local var_99_9 = 0

			if var_99_9 < arg_96_1.time_ and arg_96_1.time_ <= var_99_9 + arg_99_0 and not isNil(var_99_8) and arg_96_1.var_.actorSpriteComps10022 == nil then
				arg_96_1.var_.actorSpriteComps10022 = var_99_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_10 = 2

			if var_99_9 <= arg_96_1.time_ and arg_96_1.time_ < var_99_9 + var_99_10 and not isNil(var_99_8) then
				local var_99_11 = (arg_96_1.time_ - var_99_9) / var_99_10

				if arg_96_1.var_.actorSpriteComps10022 then
					for iter_99_4, iter_99_5 in pairs(arg_96_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_99_5 then
							if arg_96_1.isInRecall_ then
								local var_99_12 = Mathf.Lerp(iter_99_5.color.r, arg_96_1.hightColor2.r, var_99_11)
								local var_99_13 = Mathf.Lerp(iter_99_5.color.g, arg_96_1.hightColor2.g, var_99_11)
								local var_99_14 = Mathf.Lerp(iter_99_5.color.b, arg_96_1.hightColor2.b, var_99_11)

								iter_99_5.color = Color.New(var_99_12, var_99_13, var_99_14)
							else
								local var_99_15 = Mathf.Lerp(iter_99_5.color.r, 0.5, var_99_11)

								iter_99_5.color = Color.New(var_99_15, var_99_15, var_99_15)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= var_99_9 + var_99_10 and arg_96_1.time_ < var_99_9 + var_99_10 + arg_99_0 and not isNil(var_99_8) and arg_96_1.var_.actorSpriteComps10022 then
				for iter_99_6, iter_99_7 in pairs(arg_96_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_99_7 then
						if arg_96_1.isInRecall_ then
							iter_99_7.color = arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_99_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps10022 = nil
			end

			local var_99_16 = 0
			local var_99_17 = 0.45

			if var_99_16 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_18 = arg_96_1:FormatText(StoryNameCfg[259].name)

				arg_96_1.leftNameTxt_.text = var_99_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_19 = arg_96_1:GetWordFromCfg(413021023)
				local var_99_20 = arg_96_1:FormatText(var_99_19.content)

				arg_96_1.text_.text = var_99_20

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_21 = 18
				local var_99_22 = utf8.len(var_99_20)
				local var_99_23 = var_99_21 <= 0 and var_99_17 or var_99_17 * (var_99_22 / var_99_21)

				if var_99_23 > 0 and var_99_17 < var_99_23 then
					arg_96_1.talkMaxDuration = var_99_23

					if var_99_23 + var_99_16 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_16
					end
				end

				arg_96_1.text_.text = var_99_20
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021023", "story_v_out_413021.awb") ~= 0 then
					local var_99_24 = manager.audio:GetVoiceLength("story_v_out_413021", "413021023", "story_v_out_413021.awb") / 1000

					if var_99_24 + var_99_16 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_24 + var_99_16
					end

					if var_99_19.prefab_name ~= "" and arg_96_1.actors_[var_99_19.prefab_name] ~= nil then
						local var_99_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_19.prefab_name].transform, "story_v_out_413021", "413021023", "story_v_out_413021.awb")

						arg_96_1:RecordAudio("413021023", var_99_25)
						arg_96_1:RecordAudio("413021023", var_99_25)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_413021", "413021023", "story_v_out_413021.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_413021", "413021023", "story_v_out_413021.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_26 = math.max(var_99_17, arg_96_1.talkMaxDuration)

			if var_99_16 <= arg_96_1.time_ and arg_96_1.time_ < var_99_16 + var_99_26 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_16) / var_99_26

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_16 + var_99_26 and arg_96_1.time_ < var_99_16 + var_99_26 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play413021024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 413021024
		arg_100_1.duration_ = 11.3

		local var_100_0 = {
			zh = 8.366,
			ja = 11.3
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
				arg_100_0:Play413021025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["10022"].transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.var_.moveOldPos10022 = var_103_0.localPosition
				var_103_0.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("10022", 2)

				local var_103_2 = var_103_0.childCount

				for iter_103_0 = 0, var_103_2 - 1 do
					local var_103_3 = var_103_0:GetChild(iter_103_0)

					if var_103_3.name == "split_8" or not string.find(var_103_3.name, "split") then
						var_103_3.gameObject:SetActive(true)
					else
						var_103_3.gameObject:SetActive(false)
					end
				end
			end

			local var_103_4 = 0.001

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_4 then
				local var_103_5 = (arg_100_1.time_ - var_103_1) / var_103_4
				local var_103_6 = Vector3.New(-390, -315, -320)

				var_103_0.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10022, var_103_6, var_103_5)
			end

			if arg_100_1.time_ >= var_103_1 + var_103_4 and arg_100_1.time_ < var_103_1 + var_103_4 + arg_103_0 then
				var_103_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_103_7 = arg_100_1.actors_["10094"].transform
			local var_103_8 = 0

			if var_103_8 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.var_.moveOldPos10094 = var_103_7.localPosition
				var_103_7.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("10094", 4)

				local var_103_9 = var_103_7.childCount

				for iter_103_1 = 0, var_103_9 - 1 do
					local var_103_10 = var_103_7:GetChild(iter_103_1)

					if var_103_10.name == "" or not string.find(var_103_10.name, "split") then
						var_103_10.gameObject:SetActive(true)
					else
						var_103_10.gameObject:SetActive(false)
					end
				end
			end

			local var_103_11 = 0.001

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_11 then
				local var_103_12 = (arg_100_1.time_ - var_103_8) / var_103_11
				local var_103_13 = Vector3.New(390, -340, -414)

				var_103_7.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10094, var_103_13, var_103_12)
			end

			if arg_100_1.time_ >= var_103_8 + var_103_11 and arg_100_1.time_ < var_103_8 + var_103_11 + arg_103_0 then
				var_103_7.localPosition = Vector3.New(390, -340, -414)
			end

			local var_103_14 = arg_100_1.actors_["10022"]
			local var_103_15 = 0

			if var_103_15 < arg_100_1.time_ and arg_100_1.time_ <= var_103_15 + arg_103_0 and not isNil(var_103_14) and arg_100_1.var_.actorSpriteComps10022 == nil then
				arg_100_1.var_.actorSpriteComps10022 = var_103_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_16 = 2

			if var_103_15 <= arg_100_1.time_ and arg_100_1.time_ < var_103_15 + var_103_16 and not isNil(var_103_14) then
				local var_103_17 = (arg_100_1.time_ - var_103_15) / var_103_16

				if arg_100_1.var_.actorSpriteComps10022 then
					for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_103_3 then
							if arg_100_1.isInRecall_ then
								local var_103_18 = Mathf.Lerp(iter_103_3.color.r, arg_100_1.hightColor1.r, var_103_17)
								local var_103_19 = Mathf.Lerp(iter_103_3.color.g, arg_100_1.hightColor1.g, var_103_17)
								local var_103_20 = Mathf.Lerp(iter_103_3.color.b, arg_100_1.hightColor1.b, var_103_17)

								iter_103_3.color = Color.New(var_103_18, var_103_19, var_103_20)
							else
								local var_103_21 = Mathf.Lerp(iter_103_3.color.r, 1, var_103_17)

								iter_103_3.color = Color.New(var_103_21, var_103_21, var_103_21)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= var_103_15 + var_103_16 and arg_100_1.time_ < var_103_15 + var_103_16 + arg_103_0 and not isNil(var_103_14) and arg_100_1.var_.actorSpriteComps10022 then
				for iter_103_4, iter_103_5 in pairs(arg_100_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_103_5 then
						if arg_100_1.isInRecall_ then
							iter_103_5.color = arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_103_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps10022 = nil
			end

			local var_103_22 = arg_100_1.actors_["10094"]
			local var_103_23 = 0

			if var_103_23 < arg_100_1.time_ and arg_100_1.time_ <= var_103_23 + arg_103_0 and not isNil(var_103_22) and arg_100_1.var_.actorSpriteComps10094 == nil then
				arg_100_1.var_.actorSpriteComps10094 = var_103_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_24 = 2

			if var_103_23 <= arg_100_1.time_ and arg_100_1.time_ < var_103_23 + var_103_24 and not isNil(var_103_22) then
				local var_103_25 = (arg_100_1.time_ - var_103_23) / var_103_24

				if arg_100_1.var_.actorSpriteComps10094 then
					for iter_103_6, iter_103_7 in pairs(arg_100_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_103_7 then
							if arg_100_1.isInRecall_ then
								local var_103_26 = Mathf.Lerp(iter_103_7.color.r, arg_100_1.hightColor2.r, var_103_25)
								local var_103_27 = Mathf.Lerp(iter_103_7.color.g, arg_100_1.hightColor2.g, var_103_25)
								local var_103_28 = Mathf.Lerp(iter_103_7.color.b, arg_100_1.hightColor2.b, var_103_25)

								iter_103_7.color = Color.New(var_103_26, var_103_27, var_103_28)
							else
								local var_103_29 = Mathf.Lerp(iter_103_7.color.r, 0.5, var_103_25)

								iter_103_7.color = Color.New(var_103_29, var_103_29, var_103_29)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= var_103_23 + var_103_24 and arg_100_1.time_ < var_103_23 + var_103_24 + arg_103_0 and not isNil(var_103_22) and arg_100_1.var_.actorSpriteComps10094 then
				for iter_103_8, iter_103_9 in pairs(arg_100_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_103_9 then
						if arg_100_1.isInRecall_ then
							iter_103_9.color = arg_100_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_103_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps10094 = nil
			end

			local var_103_30 = 0
			local var_103_31 = 0.975

			if var_103_30 < arg_100_1.time_ and arg_100_1.time_ <= var_103_30 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_32 = arg_100_1:FormatText(StoryNameCfg[614].name)

				arg_100_1.leftNameTxt_.text = var_103_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_33 = arg_100_1:GetWordFromCfg(413021024)
				local var_103_34 = arg_100_1:FormatText(var_103_33.content)

				arg_100_1.text_.text = var_103_34

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_35 = 39
				local var_103_36 = utf8.len(var_103_34)
				local var_103_37 = var_103_35 <= 0 and var_103_31 or var_103_31 * (var_103_36 / var_103_35)

				if var_103_37 > 0 and var_103_31 < var_103_37 then
					arg_100_1.talkMaxDuration = var_103_37

					if var_103_37 + var_103_30 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_37 + var_103_30
					end
				end

				arg_100_1.text_.text = var_103_34
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021024", "story_v_out_413021.awb") ~= 0 then
					local var_103_38 = manager.audio:GetVoiceLength("story_v_out_413021", "413021024", "story_v_out_413021.awb") / 1000

					if var_103_38 + var_103_30 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_38 + var_103_30
					end

					if var_103_33.prefab_name ~= "" and arg_100_1.actors_[var_103_33.prefab_name] ~= nil then
						local var_103_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_33.prefab_name].transform, "story_v_out_413021", "413021024", "story_v_out_413021.awb")

						arg_100_1:RecordAudio("413021024", var_103_39)
						arg_100_1:RecordAudio("413021024", var_103_39)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_413021", "413021024", "story_v_out_413021.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_413021", "413021024", "story_v_out_413021.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_40 = math.max(var_103_31, arg_100_1.talkMaxDuration)

			if var_103_30 <= arg_100_1.time_ and arg_100_1.time_ < var_103_30 + var_103_40 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_30) / var_103_40

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_30 + var_103_40 and arg_100_1.time_ < var_103_30 + var_103_40 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play413021025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 413021025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play413021026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10022"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps10022 == nil then
				arg_104_1.var_.actorSpriteComps10022 = var_107_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_2 = 2

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.actorSpriteComps10022 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_107_1 then
							if arg_104_1.isInRecall_ then
								local var_107_4 = Mathf.Lerp(iter_107_1.color.r, arg_104_1.hightColor2.r, var_107_3)
								local var_107_5 = Mathf.Lerp(iter_107_1.color.g, arg_104_1.hightColor2.g, var_107_3)
								local var_107_6 = Mathf.Lerp(iter_107_1.color.b, arg_104_1.hightColor2.b, var_107_3)

								iter_107_1.color = Color.New(var_107_4, var_107_5, var_107_6)
							else
								local var_107_7 = Mathf.Lerp(iter_107_1.color.r, 0.5, var_107_3)

								iter_107_1.color = Color.New(var_107_7, var_107_7, var_107_7)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps10022 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_107_3 then
						if arg_104_1.isInRecall_ then
							iter_107_3.color = arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_107_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps10022 = nil
			end

			local var_107_8 = arg_104_1.actors_["10094"]
			local var_107_9 = 0

			if var_107_9 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps10094 == nil then
				arg_104_1.var_.actorSpriteComps10094 = var_107_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_10 = 2

			if var_107_9 <= arg_104_1.time_ and arg_104_1.time_ < var_107_9 + var_107_10 and not isNil(var_107_8) then
				local var_107_11 = (arg_104_1.time_ - var_107_9) / var_107_10

				if arg_104_1.var_.actorSpriteComps10094 then
					for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_107_5 then
							if arg_104_1.isInRecall_ then
								local var_107_12 = Mathf.Lerp(iter_107_5.color.r, arg_104_1.hightColor2.r, var_107_11)
								local var_107_13 = Mathf.Lerp(iter_107_5.color.g, arg_104_1.hightColor2.g, var_107_11)
								local var_107_14 = Mathf.Lerp(iter_107_5.color.b, arg_104_1.hightColor2.b, var_107_11)

								iter_107_5.color = Color.New(var_107_12, var_107_13, var_107_14)
							else
								local var_107_15 = Mathf.Lerp(iter_107_5.color.r, 0.5, var_107_11)

								iter_107_5.color = Color.New(var_107_15, var_107_15, var_107_15)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_9 + var_107_10 and arg_104_1.time_ < var_107_9 + var_107_10 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps10094 then
				for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_107_7 then
						if arg_104_1.isInRecall_ then
							iter_107_7.color = arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_107_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps10094 = nil
			end

			local var_107_16 = arg_104_1.actors_["10094"].transform
			local var_107_17 = 0

			if var_107_17 < arg_104_1.time_ and arg_104_1.time_ <= var_107_17 + arg_107_0 then
				arg_104_1.var_.moveOldPos10094 = var_107_16.localPosition
				var_107_16.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("10094", 7)

				local var_107_18 = var_107_16.childCount

				for iter_107_8 = 0, var_107_18 - 1 do
					local var_107_19 = var_107_16:GetChild(iter_107_8)

					if var_107_19.name == "" or not string.find(var_107_19.name, "split") then
						var_107_19.gameObject:SetActive(true)
					else
						var_107_19.gameObject:SetActive(false)
					end
				end
			end

			local var_107_20 = 0.001

			if var_107_17 <= arg_104_1.time_ and arg_104_1.time_ < var_107_17 + var_107_20 then
				local var_107_21 = (arg_104_1.time_ - var_107_17) / var_107_20
				local var_107_22 = Vector3.New(0, -2000, 0)

				var_107_16.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10094, var_107_22, var_107_21)
			end

			if arg_104_1.time_ >= var_107_17 + var_107_20 and arg_104_1.time_ < var_107_17 + var_107_20 + arg_107_0 then
				var_107_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_107_23 = arg_104_1.actors_["10022"].transform
			local var_107_24 = 0

			if var_107_24 < arg_104_1.time_ and arg_104_1.time_ <= var_107_24 + arg_107_0 then
				arg_104_1.var_.moveOldPos10022 = var_107_23.localPosition
				var_107_23.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("10022", 7)

				local var_107_25 = var_107_23.childCount

				for iter_107_9 = 0, var_107_25 - 1 do
					local var_107_26 = var_107_23:GetChild(iter_107_9)

					if var_107_26.name == "split_8" or not string.find(var_107_26.name, "split") then
						var_107_26.gameObject:SetActive(true)
					else
						var_107_26.gameObject:SetActive(false)
					end
				end
			end

			local var_107_27 = 0.001

			if var_107_24 <= arg_104_1.time_ and arg_104_1.time_ < var_107_24 + var_107_27 then
				local var_107_28 = (arg_104_1.time_ - var_107_24) / var_107_27
				local var_107_29 = Vector3.New(0, -2000, 0)

				var_107_23.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10022, var_107_29, var_107_28)
			end

			if arg_104_1.time_ >= var_107_24 + var_107_27 and arg_104_1.time_ < var_107_24 + var_107_27 + arg_107_0 then
				var_107_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_107_30 = 0
			local var_107_31 = 1.7

			if var_107_30 < arg_104_1.time_ and arg_104_1.time_ <= var_107_30 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_32 = arg_104_1:GetWordFromCfg(413021025)
				local var_107_33 = arg_104_1:FormatText(var_107_32.content)

				arg_104_1.text_.text = var_107_33

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_34 = 68
				local var_107_35 = utf8.len(var_107_33)
				local var_107_36 = var_107_34 <= 0 and var_107_31 or var_107_31 * (var_107_35 / var_107_34)

				if var_107_36 > 0 and var_107_31 < var_107_36 then
					arg_104_1.talkMaxDuration = var_107_36

					if var_107_36 + var_107_30 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_36 + var_107_30
					end
				end

				arg_104_1.text_.text = var_107_33
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_37 = math.max(var_107_31, arg_104_1.talkMaxDuration)

			if var_107_30 <= arg_104_1.time_ and arg_104_1.time_ < var_107_30 + var_107_37 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_30) / var_107_37

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_30 + var_107_37 and arg_104_1.time_ < var_107_30 + var_107_37 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play413021026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 413021026
		arg_108_1.duration_ = 9.93

		local var_108_0 = {
			zh = 7.433,
			ja = 9.933
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
				arg_108_0:Play413021027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = "10092"

			if arg_108_1.actors_[var_111_0] == nil then
				local var_111_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_111_1) then
					local var_111_2 = Object.Instantiate(var_111_1, arg_108_1.canvasGo_.transform)

					var_111_2.transform:SetSiblingIndex(1)

					var_111_2.name = var_111_0
					var_111_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_108_1.actors_[var_111_0] = var_111_2

					local var_111_3 = var_111_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_108_1.isInRecall_ then
						for iter_111_0, iter_111_1 in ipairs(var_111_3) do
							iter_111_1.color = arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_111_4 = arg_108_1.actors_["10092"].transform
			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1.var_.moveOldPos10092 = var_111_4.localPosition
				var_111_4.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("10092", 2)

				local var_111_6 = var_111_4.childCount

				for iter_111_2 = 0, var_111_6 - 1 do
					local var_111_7 = var_111_4:GetChild(iter_111_2)

					if var_111_7.name == "" or not string.find(var_111_7.name, "split") then
						var_111_7.gameObject:SetActive(true)
					else
						var_111_7.gameObject:SetActive(false)
					end
				end
			end

			local var_111_8 = 0.001

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_8 then
				local var_111_9 = (arg_108_1.time_ - var_111_5) / var_111_8
				local var_111_10 = Vector3.New(-389.49, -300, -295)

				var_111_4.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10092, var_111_10, var_111_9)
			end

			if arg_108_1.time_ >= var_111_5 + var_111_8 and arg_108_1.time_ < var_111_5 + var_111_8 + arg_111_0 then
				var_111_4.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_111_11 = arg_108_1.actors_["10092"]
			local var_111_12 = 0

			if var_111_12 < arg_108_1.time_ and arg_108_1.time_ <= var_111_12 + arg_111_0 and not isNil(var_111_11) and arg_108_1.var_.actorSpriteComps10092 == nil then
				arg_108_1.var_.actorSpriteComps10092 = var_111_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_13 = 2

			if var_111_12 <= arg_108_1.time_ and arg_108_1.time_ < var_111_12 + var_111_13 and not isNil(var_111_11) then
				local var_111_14 = (arg_108_1.time_ - var_111_12) / var_111_13

				if arg_108_1.var_.actorSpriteComps10092 then
					for iter_111_3, iter_111_4 in pairs(arg_108_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_111_4 then
							if arg_108_1.isInRecall_ then
								local var_111_15 = Mathf.Lerp(iter_111_4.color.r, arg_108_1.hightColor1.r, var_111_14)
								local var_111_16 = Mathf.Lerp(iter_111_4.color.g, arg_108_1.hightColor1.g, var_111_14)
								local var_111_17 = Mathf.Lerp(iter_111_4.color.b, arg_108_1.hightColor1.b, var_111_14)

								iter_111_4.color = Color.New(var_111_15, var_111_16, var_111_17)
							else
								local var_111_18 = Mathf.Lerp(iter_111_4.color.r, 1, var_111_14)

								iter_111_4.color = Color.New(var_111_18, var_111_18, var_111_18)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_12 + var_111_13 and arg_108_1.time_ < var_111_12 + var_111_13 + arg_111_0 and not isNil(var_111_11) and arg_108_1.var_.actorSpriteComps10092 then
				for iter_111_5, iter_111_6 in pairs(arg_108_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_111_6 then
						if arg_108_1.isInRecall_ then
							iter_111_6.color = arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_111_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps10092 = nil
			end

			local var_111_19 = arg_108_1.actors_["10092"]
			local var_111_20 = 0

			if var_111_20 < arg_108_1.time_ and arg_108_1.time_ <= var_111_20 + arg_111_0 then
				local var_111_21 = var_111_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_111_21 then
					arg_108_1.var_.alphaOldValue10092 = var_111_21.alpha
					arg_108_1.var_.characterEffect10092 = var_111_21
				end

				arg_108_1.var_.alphaOldValue10092 = 0
			end

			local var_111_22 = 0.5

			if var_111_20 <= arg_108_1.time_ and arg_108_1.time_ < var_111_20 + var_111_22 then
				local var_111_23 = (arg_108_1.time_ - var_111_20) / var_111_22
				local var_111_24 = Mathf.Lerp(arg_108_1.var_.alphaOldValue10092, 1, var_111_23)

				if arg_108_1.var_.characterEffect10092 then
					arg_108_1.var_.characterEffect10092.alpha = var_111_24
				end
			end

			if arg_108_1.time_ >= var_111_20 + var_111_22 and arg_108_1.time_ < var_111_20 + var_111_22 + arg_111_0 and arg_108_1.var_.characterEffect10092 then
				arg_108_1.var_.characterEffect10092.alpha = 1
			end

			local var_111_25 = 0
			local var_111_26 = 0.95

			if var_111_25 < arg_108_1.time_ and arg_108_1.time_ <= var_111_25 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_27 = arg_108_1:FormatText(StoryNameCfg[996].name)

				arg_108_1.leftNameTxt_.text = var_111_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_28 = arg_108_1:GetWordFromCfg(413021026)
				local var_111_29 = arg_108_1:FormatText(var_111_28.content)

				arg_108_1.text_.text = var_111_29

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_30 = 38
				local var_111_31 = utf8.len(var_111_29)
				local var_111_32 = var_111_30 <= 0 and var_111_26 or var_111_26 * (var_111_31 / var_111_30)

				if var_111_32 > 0 and var_111_26 < var_111_32 then
					arg_108_1.talkMaxDuration = var_111_32

					if var_111_32 + var_111_25 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_32 + var_111_25
					end
				end

				arg_108_1.text_.text = var_111_29
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021026", "story_v_out_413021.awb") ~= 0 then
					local var_111_33 = manager.audio:GetVoiceLength("story_v_out_413021", "413021026", "story_v_out_413021.awb") / 1000

					if var_111_33 + var_111_25 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_33 + var_111_25
					end

					if var_111_28.prefab_name ~= "" and arg_108_1.actors_[var_111_28.prefab_name] ~= nil then
						local var_111_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_28.prefab_name].transform, "story_v_out_413021", "413021026", "story_v_out_413021.awb")

						arg_108_1:RecordAudio("413021026", var_111_34)
						arg_108_1:RecordAudio("413021026", var_111_34)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_413021", "413021026", "story_v_out_413021.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_413021", "413021026", "story_v_out_413021.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_35 = math.max(var_111_26, arg_108_1.talkMaxDuration)

			if var_111_25 <= arg_108_1.time_ and arg_108_1.time_ < var_111_25 + var_111_35 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_25) / var_111_35

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_25 + var_111_35 and arg_108_1.time_ < var_111_25 + var_111_35 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play413021027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 413021027
		arg_112_1.duration_ = 2.77

		local var_112_0 = {
			zh = 2.5,
			ja = 2.766
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
				arg_112_0:Play413021028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10022"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos10022 = var_115_0.localPosition
				var_115_0.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("10022", 4)

				local var_115_2 = var_115_0.childCount

				for iter_115_0 = 0, var_115_2 - 1 do
					local var_115_3 = var_115_0:GetChild(iter_115_0)

					if var_115_3.name == "split_6" or not string.find(var_115_3.name, "split") then
						var_115_3.gameObject:SetActive(true)
					else
						var_115_3.gameObject:SetActive(false)
					end
				end
			end

			local var_115_4 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_4 then
				local var_115_5 = (arg_112_1.time_ - var_115_1) / var_115_4
				local var_115_6 = Vector3.New(390, -315, -320)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10022, var_115_6, var_115_5)
			end

			if arg_112_1.time_ >= var_115_1 + var_115_4 and arg_112_1.time_ < var_115_1 + var_115_4 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_115_7 = arg_112_1.actors_["10022"]
			local var_115_8 = 0

			if var_115_8 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 and not isNil(var_115_7) and arg_112_1.var_.actorSpriteComps10022 == nil then
				arg_112_1.var_.actorSpriteComps10022 = var_115_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_9 = 2

			if var_115_8 <= arg_112_1.time_ and arg_112_1.time_ < var_115_8 + var_115_9 and not isNil(var_115_7) then
				local var_115_10 = (arg_112_1.time_ - var_115_8) / var_115_9

				if arg_112_1.var_.actorSpriteComps10022 then
					for iter_115_1, iter_115_2 in pairs(arg_112_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_115_2 then
							if arg_112_1.isInRecall_ then
								local var_115_11 = Mathf.Lerp(iter_115_2.color.r, arg_112_1.hightColor1.r, var_115_10)
								local var_115_12 = Mathf.Lerp(iter_115_2.color.g, arg_112_1.hightColor1.g, var_115_10)
								local var_115_13 = Mathf.Lerp(iter_115_2.color.b, arg_112_1.hightColor1.b, var_115_10)

								iter_115_2.color = Color.New(var_115_11, var_115_12, var_115_13)
							else
								local var_115_14 = Mathf.Lerp(iter_115_2.color.r, 1, var_115_10)

								iter_115_2.color = Color.New(var_115_14, var_115_14, var_115_14)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_8 + var_115_9 and arg_112_1.time_ < var_115_8 + var_115_9 + arg_115_0 and not isNil(var_115_7) and arg_112_1.var_.actorSpriteComps10022 then
				for iter_115_3, iter_115_4 in pairs(arg_112_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_115_4 then
						if arg_112_1.isInRecall_ then
							iter_115_4.color = arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_115_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps10022 = nil
			end

			local var_115_15 = arg_112_1.actors_["10092"]
			local var_115_16 = 0

			if var_115_16 < arg_112_1.time_ and arg_112_1.time_ <= var_115_16 + arg_115_0 and not isNil(var_115_15) and arg_112_1.var_.actorSpriteComps10092 == nil then
				arg_112_1.var_.actorSpriteComps10092 = var_115_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_17 = 2

			if var_115_16 <= arg_112_1.time_ and arg_112_1.time_ < var_115_16 + var_115_17 and not isNil(var_115_15) then
				local var_115_18 = (arg_112_1.time_ - var_115_16) / var_115_17

				if arg_112_1.var_.actorSpriteComps10092 then
					for iter_115_5, iter_115_6 in pairs(arg_112_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_115_6 then
							if arg_112_1.isInRecall_ then
								local var_115_19 = Mathf.Lerp(iter_115_6.color.r, arg_112_1.hightColor2.r, var_115_18)
								local var_115_20 = Mathf.Lerp(iter_115_6.color.g, arg_112_1.hightColor2.g, var_115_18)
								local var_115_21 = Mathf.Lerp(iter_115_6.color.b, arg_112_1.hightColor2.b, var_115_18)

								iter_115_6.color = Color.New(var_115_19, var_115_20, var_115_21)
							else
								local var_115_22 = Mathf.Lerp(iter_115_6.color.r, 0.5, var_115_18)

								iter_115_6.color = Color.New(var_115_22, var_115_22, var_115_22)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_16 + var_115_17 and arg_112_1.time_ < var_115_16 + var_115_17 + arg_115_0 and not isNil(var_115_15) and arg_112_1.var_.actorSpriteComps10092 then
				for iter_115_7, iter_115_8 in pairs(arg_112_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_115_8 then
						if arg_112_1.isInRecall_ then
							iter_115_8.color = arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_115_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps10092 = nil
			end

			local var_115_23 = 0
			local var_115_24 = 0.3

			if var_115_23 < arg_112_1.time_ and arg_112_1.time_ <= var_115_23 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_25 = arg_112_1:FormatText(StoryNameCfg[614].name)

				arg_112_1.leftNameTxt_.text = var_115_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_26 = arg_112_1:GetWordFromCfg(413021027)
				local var_115_27 = arg_112_1:FormatText(var_115_26.content)

				arg_112_1.text_.text = var_115_27

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_28 = 12
				local var_115_29 = utf8.len(var_115_27)
				local var_115_30 = var_115_28 <= 0 and var_115_24 or var_115_24 * (var_115_29 / var_115_28)

				if var_115_30 > 0 and var_115_24 < var_115_30 then
					arg_112_1.talkMaxDuration = var_115_30

					if var_115_30 + var_115_23 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_30 + var_115_23
					end
				end

				arg_112_1.text_.text = var_115_27
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021027", "story_v_out_413021.awb") ~= 0 then
					local var_115_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021027", "story_v_out_413021.awb") / 1000

					if var_115_31 + var_115_23 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_31 + var_115_23
					end

					if var_115_26.prefab_name ~= "" and arg_112_1.actors_[var_115_26.prefab_name] ~= nil then
						local var_115_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_26.prefab_name].transform, "story_v_out_413021", "413021027", "story_v_out_413021.awb")

						arg_112_1:RecordAudio("413021027", var_115_32)
						arg_112_1:RecordAudio("413021027", var_115_32)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_413021", "413021027", "story_v_out_413021.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_413021", "413021027", "story_v_out_413021.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_33 = math.max(var_115_24, arg_112_1.talkMaxDuration)

			if var_115_23 <= arg_112_1.time_ and arg_112_1.time_ < var_115_23 + var_115_33 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_23) / var_115_33

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_23 + var_115_33 and arg_112_1.time_ < var_115_23 + var_115_33 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play413021028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 413021028
		arg_116_1.duration_ = 4.77

		local var_116_0 = {
			zh = 4.433,
			ja = 4.766
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
				arg_116_0:Play413021029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["10094"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos10094 = var_119_0.localPosition
				var_119_0.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("10094", 2)

				local var_119_2 = var_119_0.childCount

				for iter_119_0 = 0, var_119_2 - 1 do
					local var_119_3 = var_119_0:GetChild(iter_119_0)

					if var_119_3.name == "" or not string.find(var_119_3.name, "split") then
						var_119_3.gameObject:SetActive(true)
					else
						var_119_3.gameObject:SetActive(false)
					end
				end
			end

			local var_119_4 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_4 then
				local var_119_5 = (arg_116_1.time_ - var_119_1) / var_119_4
				local var_119_6 = Vector3.New(-390, -340, -414)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10094, var_119_6, var_119_5)
			end

			if arg_116_1.time_ >= var_119_1 + var_119_4 and arg_116_1.time_ < var_119_1 + var_119_4 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_119_7 = arg_116_1.actors_["10094"]
			local var_119_8 = 0

			if var_119_8 < arg_116_1.time_ and arg_116_1.time_ <= var_119_8 + arg_119_0 and not isNil(var_119_7) and arg_116_1.var_.actorSpriteComps10094 == nil then
				arg_116_1.var_.actorSpriteComps10094 = var_119_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_9 = 2

			if var_119_8 <= arg_116_1.time_ and arg_116_1.time_ < var_119_8 + var_119_9 and not isNil(var_119_7) then
				local var_119_10 = (arg_116_1.time_ - var_119_8) / var_119_9

				if arg_116_1.var_.actorSpriteComps10094 then
					for iter_119_1, iter_119_2 in pairs(arg_116_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_119_2 then
							if arg_116_1.isInRecall_ then
								local var_119_11 = Mathf.Lerp(iter_119_2.color.r, arg_116_1.hightColor1.r, var_119_10)
								local var_119_12 = Mathf.Lerp(iter_119_2.color.g, arg_116_1.hightColor1.g, var_119_10)
								local var_119_13 = Mathf.Lerp(iter_119_2.color.b, arg_116_1.hightColor1.b, var_119_10)

								iter_119_2.color = Color.New(var_119_11, var_119_12, var_119_13)
							else
								local var_119_14 = Mathf.Lerp(iter_119_2.color.r, 1, var_119_10)

								iter_119_2.color = Color.New(var_119_14, var_119_14, var_119_14)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_8 + var_119_9 and arg_116_1.time_ < var_119_8 + var_119_9 + arg_119_0 and not isNil(var_119_7) and arg_116_1.var_.actorSpriteComps10094 then
				for iter_119_3, iter_119_4 in pairs(arg_116_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_119_4 then
						if arg_116_1.isInRecall_ then
							iter_119_4.color = arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_119_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps10094 = nil
			end

			local var_119_15 = arg_116_1.actors_["10022"]
			local var_119_16 = 0

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 and not isNil(var_119_15) and arg_116_1.var_.actorSpriteComps10022 == nil then
				arg_116_1.var_.actorSpriteComps10022 = var_119_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_17 = 2

			if var_119_16 <= arg_116_1.time_ and arg_116_1.time_ < var_119_16 + var_119_17 and not isNil(var_119_15) then
				local var_119_18 = (arg_116_1.time_ - var_119_16) / var_119_17

				if arg_116_1.var_.actorSpriteComps10022 then
					for iter_119_5, iter_119_6 in pairs(arg_116_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_119_6 then
							if arg_116_1.isInRecall_ then
								local var_119_19 = Mathf.Lerp(iter_119_6.color.r, arg_116_1.hightColor2.r, var_119_18)
								local var_119_20 = Mathf.Lerp(iter_119_6.color.g, arg_116_1.hightColor2.g, var_119_18)
								local var_119_21 = Mathf.Lerp(iter_119_6.color.b, arg_116_1.hightColor2.b, var_119_18)

								iter_119_6.color = Color.New(var_119_19, var_119_20, var_119_21)
							else
								local var_119_22 = Mathf.Lerp(iter_119_6.color.r, 0.5, var_119_18)

								iter_119_6.color = Color.New(var_119_22, var_119_22, var_119_22)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_16 + var_119_17 and arg_116_1.time_ < var_119_16 + var_119_17 + arg_119_0 and not isNil(var_119_15) and arg_116_1.var_.actorSpriteComps10022 then
				for iter_119_7, iter_119_8 in pairs(arg_116_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_119_8 then
						if arg_116_1.isInRecall_ then
							iter_119_8.color = arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_119_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps10022 = nil
			end

			local var_119_23 = 0
			local var_119_24 = 0.375

			if var_119_23 < arg_116_1.time_ and arg_116_1.time_ <= var_119_23 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_25 = arg_116_1:FormatText(StoryNameCfg[259].name)

				arg_116_1.leftNameTxt_.text = var_119_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_26 = arg_116_1:GetWordFromCfg(413021028)
				local var_119_27 = arg_116_1:FormatText(var_119_26.content)

				arg_116_1.text_.text = var_119_27

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_28 = 15
				local var_119_29 = utf8.len(var_119_27)
				local var_119_30 = var_119_28 <= 0 and var_119_24 or var_119_24 * (var_119_29 / var_119_28)

				if var_119_30 > 0 and var_119_24 < var_119_30 then
					arg_116_1.talkMaxDuration = var_119_30

					if var_119_30 + var_119_23 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_30 + var_119_23
					end
				end

				arg_116_1.text_.text = var_119_27
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021028", "story_v_out_413021.awb") ~= 0 then
					local var_119_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021028", "story_v_out_413021.awb") / 1000

					if var_119_31 + var_119_23 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_31 + var_119_23
					end

					if var_119_26.prefab_name ~= "" and arg_116_1.actors_[var_119_26.prefab_name] ~= nil then
						local var_119_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_26.prefab_name].transform, "story_v_out_413021", "413021028", "story_v_out_413021.awb")

						arg_116_1:RecordAudio("413021028", var_119_32)
						arg_116_1:RecordAudio("413021028", var_119_32)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_413021", "413021028", "story_v_out_413021.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_413021", "413021028", "story_v_out_413021.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_33 = math.max(var_119_24, arg_116_1.talkMaxDuration)

			if var_119_23 <= arg_116_1.time_ and arg_116_1.time_ < var_119_23 + var_119_33 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_23) / var_119_33

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_23 + var_119_33 and arg_116_1.time_ < var_119_23 + var_119_33 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play413021029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 413021029
		arg_120_1.duration_ = 3.97

		local var_120_0 = {
			zh = 2.8,
			ja = 3.966
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
				arg_120_0:Play413021030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.325

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[259].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_3 = arg_120_1:GetWordFromCfg(413021029)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021029", "story_v_out_413021.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021029", "story_v_out_413021.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_413021", "413021029", "story_v_out_413021.awb")

						arg_120_1:RecordAudio("413021029", var_123_9)
						arg_120_1:RecordAudio("413021029", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_413021", "413021029", "story_v_out_413021.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_413021", "413021029", "story_v_out_413021.awb")
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
	Play413021030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 413021030
		arg_124_1.duration_ = 5.07

		local var_124_0 = {
			zh = 2.4,
			ja = 5.066
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
				arg_124_0:Play413021031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10022"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos10022 = var_127_0.localPosition
				var_127_0.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("10022", 4)

				local var_127_2 = var_127_0.childCount

				for iter_127_0 = 0, var_127_2 - 1 do
					local var_127_3 = var_127_0:GetChild(iter_127_0)

					if var_127_3.name == "split_8" or not string.find(var_127_3.name, "split") then
						var_127_3.gameObject:SetActive(true)
					else
						var_127_3.gameObject:SetActive(false)
					end
				end
			end

			local var_127_4 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_4 then
				local var_127_5 = (arg_124_1.time_ - var_127_1) / var_127_4
				local var_127_6 = Vector3.New(390, -315, -320)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10022, var_127_6, var_127_5)
			end

			if arg_124_1.time_ >= var_127_1 + var_127_4 and arg_124_1.time_ < var_127_1 + var_127_4 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_127_7 = arg_124_1.actors_["10094"]
			local var_127_8 = 0

			if var_127_8 < arg_124_1.time_ and arg_124_1.time_ <= var_127_8 + arg_127_0 and not isNil(var_127_7) and arg_124_1.var_.actorSpriteComps10094 == nil then
				arg_124_1.var_.actorSpriteComps10094 = var_127_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_9 = 2

			if var_127_8 <= arg_124_1.time_ and arg_124_1.time_ < var_127_8 + var_127_9 and not isNil(var_127_7) then
				local var_127_10 = (arg_124_1.time_ - var_127_8) / var_127_9

				if arg_124_1.var_.actorSpriteComps10094 then
					for iter_127_1, iter_127_2 in pairs(arg_124_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_127_2 then
							if arg_124_1.isInRecall_ then
								local var_127_11 = Mathf.Lerp(iter_127_2.color.r, arg_124_1.hightColor2.r, var_127_10)
								local var_127_12 = Mathf.Lerp(iter_127_2.color.g, arg_124_1.hightColor2.g, var_127_10)
								local var_127_13 = Mathf.Lerp(iter_127_2.color.b, arg_124_1.hightColor2.b, var_127_10)

								iter_127_2.color = Color.New(var_127_11, var_127_12, var_127_13)
							else
								local var_127_14 = Mathf.Lerp(iter_127_2.color.r, 0.5, var_127_10)

								iter_127_2.color = Color.New(var_127_14, var_127_14, var_127_14)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_8 + var_127_9 and arg_124_1.time_ < var_127_8 + var_127_9 + arg_127_0 and not isNil(var_127_7) and arg_124_1.var_.actorSpriteComps10094 then
				for iter_127_3, iter_127_4 in pairs(arg_124_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_127_4 then
						if arg_124_1.isInRecall_ then
							iter_127_4.color = arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_127_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps10094 = nil
			end

			local var_127_15 = arg_124_1.actors_["10022"]
			local var_127_16 = 0

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 and not isNil(var_127_15) and arg_124_1.var_.actorSpriteComps10022 == nil then
				arg_124_1.var_.actorSpriteComps10022 = var_127_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_17 = 2

			if var_127_16 <= arg_124_1.time_ and arg_124_1.time_ < var_127_16 + var_127_17 and not isNil(var_127_15) then
				local var_127_18 = (arg_124_1.time_ - var_127_16) / var_127_17

				if arg_124_1.var_.actorSpriteComps10022 then
					for iter_127_5, iter_127_6 in pairs(arg_124_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_127_6 then
							if arg_124_1.isInRecall_ then
								local var_127_19 = Mathf.Lerp(iter_127_6.color.r, arg_124_1.hightColor1.r, var_127_18)
								local var_127_20 = Mathf.Lerp(iter_127_6.color.g, arg_124_1.hightColor1.g, var_127_18)
								local var_127_21 = Mathf.Lerp(iter_127_6.color.b, arg_124_1.hightColor1.b, var_127_18)

								iter_127_6.color = Color.New(var_127_19, var_127_20, var_127_21)
							else
								local var_127_22 = Mathf.Lerp(iter_127_6.color.r, 1, var_127_18)

								iter_127_6.color = Color.New(var_127_22, var_127_22, var_127_22)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_16 + var_127_17 and arg_124_1.time_ < var_127_16 + var_127_17 + arg_127_0 and not isNil(var_127_15) and arg_124_1.var_.actorSpriteComps10022 then
				for iter_127_7, iter_127_8 in pairs(arg_124_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_127_8 then
						if arg_124_1.isInRecall_ then
							iter_127_8.color = arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_127_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps10022 = nil
			end

			local var_127_23 = 0
			local var_127_24 = 0.325

			if var_127_23 < arg_124_1.time_ and arg_124_1.time_ <= var_127_23 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_25 = arg_124_1:FormatText(StoryNameCfg[614].name)

				arg_124_1.leftNameTxt_.text = var_127_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_26 = arg_124_1:GetWordFromCfg(413021030)
				local var_127_27 = arg_124_1:FormatText(var_127_26.content)

				arg_124_1.text_.text = var_127_27

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_28 = 13
				local var_127_29 = utf8.len(var_127_27)
				local var_127_30 = var_127_28 <= 0 and var_127_24 or var_127_24 * (var_127_29 / var_127_28)

				if var_127_30 > 0 and var_127_24 < var_127_30 then
					arg_124_1.talkMaxDuration = var_127_30

					if var_127_30 + var_127_23 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_30 + var_127_23
					end
				end

				arg_124_1.text_.text = var_127_27
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021030", "story_v_out_413021.awb") ~= 0 then
					local var_127_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021030", "story_v_out_413021.awb") / 1000

					if var_127_31 + var_127_23 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_31 + var_127_23
					end

					if var_127_26.prefab_name ~= "" and arg_124_1.actors_[var_127_26.prefab_name] ~= nil then
						local var_127_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_26.prefab_name].transform, "story_v_out_413021", "413021030", "story_v_out_413021.awb")

						arg_124_1:RecordAudio("413021030", var_127_32)
						arg_124_1:RecordAudio("413021030", var_127_32)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_413021", "413021030", "story_v_out_413021.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_413021", "413021030", "story_v_out_413021.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_33 = math.max(var_127_24, arg_124_1.talkMaxDuration)

			if var_127_23 <= arg_124_1.time_ and arg_124_1.time_ < var_127_23 + var_127_33 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_23) / var_127_33

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_23 + var_127_33 and arg_124_1.time_ < var_127_23 + var_127_33 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play413021031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 413021031
		arg_128_1.duration_ = 6.27

		local var_128_0 = {
			zh = 2.866,
			ja = 6.266
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
				arg_128_0:Play413021032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["10094"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos10094 = var_131_0.localPosition
				var_131_0.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("10094", 2)

				local var_131_2 = var_131_0.childCount

				for iter_131_0 = 0, var_131_2 - 1 do
					local var_131_3 = var_131_0:GetChild(iter_131_0)

					if var_131_3.name == "" or not string.find(var_131_3.name, "split") then
						var_131_3.gameObject:SetActive(true)
					else
						var_131_3.gameObject:SetActive(false)
					end
				end
			end

			local var_131_4 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_4 then
				local var_131_5 = (arg_128_1.time_ - var_131_1) / var_131_4
				local var_131_6 = Vector3.New(-390, -340, -414)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10094, var_131_6, var_131_5)
			end

			if arg_128_1.time_ >= var_131_1 + var_131_4 and arg_128_1.time_ < var_131_1 + var_131_4 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_131_7 = arg_128_1.actors_["10094"]
			local var_131_8 = 0

			if var_131_8 < arg_128_1.time_ and arg_128_1.time_ <= var_131_8 + arg_131_0 and not isNil(var_131_7) and arg_128_1.var_.actorSpriteComps10094 == nil then
				arg_128_1.var_.actorSpriteComps10094 = var_131_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_9 = 2

			if var_131_8 <= arg_128_1.time_ and arg_128_1.time_ < var_131_8 + var_131_9 and not isNil(var_131_7) then
				local var_131_10 = (arg_128_1.time_ - var_131_8) / var_131_9

				if arg_128_1.var_.actorSpriteComps10094 then
					for iter_131_1, iter_131_2 in pairs(arg_128_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_131_2 then
							if arg_128_1.isInRecall_ then
								local var_131_11 = Mathf.Lerp(iter_131_2.color.r, arg_128_1.hightColor1.r, var_131_10)
								local var_131_12 = Mathf.Lerp(iter_131_2.color.g, arg_128_1.hightColor1.g, var_131_10)
								local var_131_13 = Mathf.Lerp(iter_131_2.color.b, arg_128_1.hightColor1.b, var_131_10)

								iter_131_2.color = Color.New(var_131_11, var_131_12, var_131_13)
							else
								local var_131_14 = Mathf.Lerp(iter_131_2.color.r, 1, var_131_10)

								iter_131_2.color = Color.New(var_131_14, var_131_14, var_131_14)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_8 + var_131_9 and arg_128_1.time_ < var_131_8 + var_131_9 + arg_131_0 and not isNil(var_131_7) and arg_128_1.var_.actorSpriteComps10094 then
				for iter_131_3, iter_131_4 in pairs(arg_128_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_131_4 then
						if arg_128_1.isInRecall_ then
							iter_131_4.color = arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_131_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps10094 = nil
			end

			local var_131_15 = arg_128_1.actors_["10022"]
			local var_131_16 = 0

			if var_131_16 < arg_128_1.time_ and arg_128_1.time_ <= var_131_16 + arg_131_0 and not isNil(var_131_15) and arg_128_1.var_.actorSpriteComps10022 == nil then
				arg_128_1.var_.actorSpriteComps10022 = var_131_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_17 = 2

			if var_131_16 <= arg_128_1.time_ and arg_128_1.time_ < var_131_16 + var_131_17 and not isNil(var_131_15) then
				local var_131_18 = (arg_128_1.time_ - var_131_16) / var_131_17

				if arg_128_1.var_.actorSpriteComps10022 then
					for iter_131_5, iter_131_6 in pairs(arg_128_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_131_6 then
							if arg_128_1.isInRecall_ then
								local var_131_19 = Mathf.Lerp(iter_131_6.color.r, arg_128_1.hightColor2.r, var_131_18)
								local var_131_20 = Mathf.Lerp(iter_131_6.color.g, arg_128_1.hightColor2.g, var_131_18)
								local var_131_21 = Mathf.Lerp(iter_131_6.color.b, arg_128_1.hightColor2.b, var_131_18)

								iter_131_6.color = Color.New(var_131_19, var_131_20, var_131_21)
							else
								local var_131_22 = Mathf.Lerp(iter_131_6.color.r, 0.5, var_131_18)

								iter_131_6.color = Color.New(var_131_22, var_131_22, var_131_22)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_16 + var_131_17 and arg_128_1.time_ < var_131_16 + var_131_17 + arg_131_0 and not isNil(var_131_15) and arg_128_1.var_.actorSpriteComps10022 then
				for iter_131_7, iter_131_8 in pairs(arg_128_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_131_8 then
						if arg_128_1.isInRecall_ then
							iter_131_8.color = arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_131_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps10022 = nil
			end

			local var_131_23 = 0
			local var_131_24 = 0.35

			if var_131_23 < arg_128_1.time_ and arg_128_1.time_ <= var_131_23 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_25 = arg_128_1:FormatText(StoryNameCfg[259].name)

				arg_128_1.leftNameTxt_.text = var_131_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_26 = arg_128_1:GetWordFromCfg(413021031)
				local var_131_27 = arg_128_1:FormatText(var_131_26.content)

				arg_128_1.text_.text = var_131_27

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_28 = 14
				local var_131_29 = utf8.len(var_131_27)
				local var_131_30 = var_131_28 <= 0 and var_131_24 or var_131_24 * (var_131_29 / var_131_28)

				if var_131_30 > 0 and var_131_24 < var_131_30 then
					arg_128_1.talkMaxDuration = var_131_30

					if var_131_30 + var_131_23 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_30 + var_131_23
					end
				end

				arg_128_1.text_.text = var_131_27
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021031", "story_v_out_413021.awb") ~= 0 then
					local var_131_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021031", "story_v_out_413021.awb") / 1000

					if var_131_31 + var_131_23 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_31 + var_131_23
					end

					if var_131_26.prefab_name ~= "" and arg_128_1.actors_[var_131_26.prefab_name] ~= nil then
						local var_131_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_26.prefab_name].transform, "story_v_out_413021", "413021031", "story_v_out_413021.awb")

						arg_128_1:RecordAudio("413021031", var_131_32)
						arg_128_1:RecordAudio("413021031", var_131_32)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_413021", "413021031", "story_v_out_413021.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_413021", "413021031", "story_v_out_413021.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_33 = math.max(var_131_24, arg_128_1.talkMaxDuration)

			if var_131_23 <= arg_128_1.time_ and arg_128_1.time_ < var_131_23 + var_131_33 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_23) / var_131_33

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_23 + var_131_33 and arg_128_1.time_ < var_131_23 + var_131_33 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play413021032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 413021032
		arg_132_1.duration_ = 13.4

		local var_132_0 = {
			zh = 7.8,
			ja = 13.4
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
				arg_132_0:Play413021033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["10092"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos10092 = var_135_0.localPosition
				var_135_0.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("10092", 2)

				local var_135_2 = var_135_0.childCount

				for iter_135_0 = 0, var_135_2 - 1 do
					local var_135_3 = var_135_0:GetChild(iter_135_0)

					if var_135_3.name == "split_5" or not string.find(var_135_3.name, "split") then
						var_135_3.gameObject:SetActive(true)
					else
						var_135_3.gameObject:SetActive(false)
					end
				end
			end

			local var_135_4 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_4 then
				local var_135_5 = (arg_132_1.time_ - var_135_1) / var_135_4
				local var_135_6 = Vector3.New(-389.49, -300, -295)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10092, var_135_6, var_135_5)
			end

			if arg_132_1.time_ >= var_135_1 + var_135_4 and arg_132_1.time_ < var_135_1 + var_135_4 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_135_7 = arg_132_1.actors_["10092"]
			local var_135_8 = 0

			if var_135_8 < arg_132_1.time_ and arg_132_1.time_ <= var_135_8 + arg_135_0 and not isNil(var_135_7) and arg_132_1.var_.actorSpriteComps10092 == nil then
				arg_132_1.var_.actorSpriteComps10092 = var_135_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_9 = 2

			if var_135_8 <= arg_132_1.time_ and arg_132_1.time_ < var_135_8 + var_135_9 and not isNil(var_135_7) then
				local var_135_10 = (arg_132_1.time_ - var_135_8) / var_135_9

				if arg_132_1.var_.actorSpriteComps10092 then
					for iter_135_1, iter_135_2 in pairs(arg_132_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_135_2 then
							if arg_132_1.isInRecall_ then
								local var_135_11 = Mathf.Lerp(iter_135_2.color.r, arg_132_1.hightColor1.r, var_135_10)
								local var_135_12 = Mathf.Lerp(iter_135_2.color.g, arg_132_1.hightColor1.g, var_135_10)
								local var_135_13 = Mathf.Lerp(iter_135_2.color.b, arg_132_1.hightColor1.b, var_135_10)

								iter_135_2.color = Color.New(var_135_11, var_135_12, var_135_13)
							else
								local var_135_14 = Mathf.Lerp(iter_135_2.color.r, 1, var_135_10)

								iter_135_2.color = Color.New(var_135_14, var_135_14, var_135_14)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_8 + var_135_9 and arg_132_1.time_ < var_135_8 + var_135_9 + arg_135_0 and not isNil(var_135_7) and arg_132_1.var_.actorSpriteComps10092 then
				for iter_135_3, iter_135_4 in pairs(arg_132_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_135_4 then
						if arg_132_1.isInRecall_ then
							iter_135_4.color = arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_135_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps10092 = nil
			end

			local var_135_15 = 0
			local var_135_16 = 0.925

			if var_135_15 < arg_132_1.time_ and arg_132_1.time_ <= var_135_15 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_17 = arg_132_1:FormatText(StoryNameCfg[996].name)

				arg_132_1.leftNameTxt_.text = var_135_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_18 = arg_132_1:GetWordFromCfg(413021032)
				local var_135_19 = arg_132_1:FormatText(var_135_18.content)

				arg_132_1.text_.text = var_135_19

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_20 = 37
				local var_135_21 = utf8.len(var_135_19)
				local var_135_22 = var_135_20 <= 0 and var_135_16 or var_135_16 * (var_135_21 / var_135_20)

				if var_135_22 > 0 and var_135_16 < var_135_22 then
					arg_132_1.talkMaxDuration = var_135_22

					if var_135_22 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_22 + var_135_15
					end
				end

				arg_132_1.text_.text = var_135_19
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021032", "story_v_out_413021.awb") ~= 0 then
					local var_135_23 = manager.audio:GetVoiceLength("story_v_out_413021", "413021032", "story_v_out_413021.awb") / 1000

					if var_135_23 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_23 + var_135_15
					end

					if var_135_18.prefab_name ~= "" and arg_132_1.actors_[var_135_18.prefab_name] ~= nil then
						local var_135_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_18.prefab_name].transform, "story_v_out_413021", "413021032", "story_v_out_413021.awb")

						arg_132_1:RecordAudio("413021032", var_135_24)
						arg_132_1:RecordAudio("413021032", var_135_24)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_413021", "413021032", "story_v_out_413021.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_413021", "413021032", "story_v_out_413021.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_25 = math.max(var_135_16, arg_132_1.talkMaxDuration)

			if var_135_15 <= arg_132_1.time_ and arg_132_1.time_ < var_135_15 + var_135_25 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_15) / var_135_25

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_15 + var_135_25 and arg_132_1.time_ < var_135_15 + var_135_25 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play413021033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 413021033
		arg_136_1.duration_ = 6.37

		local var_136_0 = {
			zh = 4.166,
			ja = 6.366
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
				arg_136_0:Play413021034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["10092"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps10092 == nil then
				arg_136_1.var_.actorSpriteComps10092 = var_139_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_2 = 2

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.actorSpriteComps10092 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								local var_139_4 = Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor2.r, var_139_3)
								local var_139_5 = Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor2.g, var_139_3)
								local var_139_6 = Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor2.b, var_139_3)

								iter_139_1.color = Color.New(var_139_4, var_139_5, var_139_6)
							else
								local var_139_7 = Mathf.Lerp(iter_139_1.color.r, 0.5, var_139_3)

								iter_139_1.color = Color.New(var_139_7, var_139_7, var_139_7)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps10092 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_139_3 then
						if arg_136_1.isInRecall_ then
							iter_139_3.color = arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_139_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps10092 = nil
			end

			local var_139_8 = arg_136_1.actors_["10022"]
			local var_139_9 = 0

			if var_139_9 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 and not isNil(var_139_8) and arg_136_1.var_.actorSpriteComps10022 == nil then
				arg_136_1.var_.actorSpriteComps10022 = var_139_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_10 = 2

			if var_139_9 <= arg_136_1.time_ and arg_136_1.time_ < var_139_9 + var_139_10 and not isNil(var_139_8) then
				local var_139_11 = (arg_136_1.time_ - var_139_9) / var_139_10

				if arg_136_1.var_.actorSpriteComps10022 then
					for iter_139_4, iter_139_5 in pairs(arg_136_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_139_5 then
							if arg_136_1.isInRecall_ then
								local var_139_12 = Mathf.Lerp(iter_139_5.color.r, arg_136_1.hightColor1.r, var_139_11)
								local var_139_13 = Mathf.Lerp(iter_139_5.color.g, arg_136_1.hightColor1.g, var_139_11)
								local var_139_14 = Mathf.Lerp(iter_139_5.color.b, arg_136_1.hightColor1.b, var_139_11)

								iter_139_5.color = Color.New(var_139_12, var_139_13, var_139_14)
							else
								local var_139_15 = Mathf.Lerp(iter_139_5.color.r, 1, var_139_11)

								iter_139_5.color = Color.New(var_139_15, var_139_15, var_139_15)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= var_139_9 + var_139_10 and arg_136_1.time_ < var_139_9 + var_139_10 + arg_139_0 and not isNil(var_139_8) and arg_136_1.var_.actorSpriteComps10022 then
				for iter_139_6, iter_139_7 in pairs(arg_136_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_139_7 then
						if arg_136_1.isInRecall_ then
							iter_139_7.color = arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_139_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps10022 = nil
			end

			local var_139_16 = 0
			local var_139_17 = 0.525

			if var_139_16 < arg_136_1.time_ and arg_136_1.time_ <= var_139_16 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_18 = arg_136_1:FormatText(StoryNameCfg[614].name)

				arg_136_1.leftNameTxt_.text = var_139_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_19 = arg_136_1:GetWordFromCfg(413021033)
				local var_139_20 = arg_136_1:FormatText(var_139_19.content)

				arg_136_1.text_.text = var_139_20

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_21 = 21
				local var_139_22 = utf8.len(var_139_20)
				local var_139_23 = var_139_21 <= 0 and var_139_17 or var_139_17 * (var_139_22 / var_139_21)

				if var_139_23 > 0 and var_139_17 < var_139_23 then
					arg_136_1.talkMaxDuration = var_139_23

					if var_139_23 + var_139_16 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_23 + var_139_16
					end
				end

				arg_136_1.text_.text = var_139_20
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021033", "story_v_out_413021.awb") ~= 0 then
					local var_139_24 = manager.audio:GetVoiceLength("story_v_out_413021", "413021033", "story_v_out_413021.awb") / 1000

					if var_139_24 + var_139_16 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_24 + var_139_16
					end

					if var_139_19.prefab_name ~= "" and arg_136_1.actors_[var_139_19.prefab_name] ~= nil then
						local var_139_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_19.prefab_name].transform, "story_v_out_413021", "413021033", "story_v_out_413021.awb")

						arg_136_1:RecordAudio("413021033", var_139_25)
						arg_136_1:RecordAudio("413021033", var_139_25)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_413021", "413021033", "story_v_out_413021.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_413021", "413021033", "story_v_out_413021.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_26 = math.max(var_139_17, arg_136_1.talkMaxDuration)

			if var_139_16 <= arg_136_1.time_ and arg_136_1.time_ < var_139_16 + var_139_26 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_16) / var_139_26

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_16 + var_139_26 and arg_136_1.time_ < var_139_16 + var_139_26 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play413021034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 413021034
		arg_140_1.duration_ = 10.83

		local var_140_0 = {
			zh = 7.9,
			ja = 10.833
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
				arg_140_0:Play413021035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["10092"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos10092 = var_143_0.localPosition
				var_143_0.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("10092", 2)

				local var_143_2 = var_143_0.childCount

				for iter_143_0 = 0, var_143_2 - 1 do
					local var_143_3 = var_143_0:GetChild(iter_143_0)

					if var_143_3.name == "" or not string.find(var_143_3.name, "split") then
						var_143_3.gameObject:SetActive(true)
					else
						var_143_3.gameObject:SetActive(false)
					end
				end
			end

			local var_143_4 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_4 then
				local var_143_5 = (arg_140_1.time_ - var_143_1) / var_143_4
				local var_143_6 = Vector3.New(-389.49, -300, -295)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10092, var_143_6, var_143_5)
			end

			if arg_140_1.time_ >= var_143_1 + var_143_4 and arg_140_1.time_ < var_143_1 + var_143_4 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_143_7 = arg_140_1.actors_["10092"]
			local var_143_8 = 0

			if var_143_8 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 and not isNil(var_143_7) and arg_140_1.var_.actorSpriteComps10092 == nil then
				arg_140_1.var_.actorSpriteComps10092 = var_143_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_9 = 2

			if var_143_8 <= arg_140_1.time_ and arg_140_1.time_ < var_143_8 + var_143_9 and not isNil(var_143_7) then
				local var_143_10 = (arg_140_1.time_ - var_143_8) / var_143_9

				if arg_140_1.var_.actorSpriteComps10092 then
					for iter_143_1, iter_143_2 in pairs(arg_140_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_143_2 then
							if arg_140_1.isInRecall_ then
								local var_143_11 = Mathf.Lerp(iter_143_2.color.r, arg_140_1.hightColor1.r, var_143_10)
								local var_143_12 = Mathf.Lerp(iter_143_2.color.g, arg_140_1.hightColor1.g, var_143_10)
								local var_143_13 = Mathf.Lerp(iter_143_2.color.b, arg_140_1.hightColor1.b, var_143_10)

								iter_143_2.color = Color.New(var_143_11, var_143_12, var_143_13)
							else
								local var_143_14 = Mathf.Lerp(iter_143_2.color.r, 1, var_143_10)

								iter_143_2.color = Color.New(var_143_14, var_143_14, var_143_14)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= var_143_8 + var_143_9 and arg_140_1.time_ < var_143_8 + var_143_9 + arg_143_0 and not isNil(var_143_7) and arg_140_1.var_.actorSpriteComps10092 then
				for iter_143_3, iter_143_4 in pairs(arg_140_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_143_4 then
						if arg_140_1.isInRecall_ then
							iter_143_4.color = arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_143_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_140_1.var_.actorSpriteComps10092 = nil
			end

			local var_143_15 = arg_140_1.actors_["10022"]
			local var_143_16 = 0

			if var_143_16 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 and not isNil(var_143_15) and arg_140_1.var_.actorSpriteComps10022 == nil then
				arg_140_1.var_.actorSpriteComps10022 = var_143_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_17 = 2

			if var_143_16 <= arg_140_1.time_ and arg_140_1.time_ < var_143_16 + var_143_17 and not isNil(var_143_15) then
				local var_143_18 = (arg_140_1.time_ - var_143_16) / var_143_17

				if arg_140_1.var_.actorSpriteComps10022 then
					for iter_143_5, iter_143_6 in pairs(arg_140_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_143_6 then
							if arg_140_1.isInRecall_ then
								local var_143_19 = Mathf.Lerp(iter_143_6.color.r, arg_140_1.hightColor2.r, var_143_18)
								local var_143_20 = Mathf.Lerp(iter_143_6.color.g, arg_140_1.hightColor2.g, var_143_18)
								local var_143_21 = Mathf.Lerp(iter_143_6.color.b, arg_140_1.hightColor2.b, var_143_18)

								iter_143_6.color = Color.New(var_143_19, var_143_20, var_143_21)
							else
								local var_143_22 = Mathf.Lerp(iter_143_6.color.r, 0.5, var_143_18)

								iter_143_6.color = Color.New(var_143_22, var_143_22, var_143_22)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= var_143_16 + var_143_17 and arg_140_1.time_ < var_143_16 + var_143_17 + arg_143_0 and not isNil(var_143_15) and arg_140_1.var_.actorSpriteComps10022 then
				for iter_143_7, iter_143_8 in pairs(arg_140_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_143_8 then
						if arg_140_1.isInRecall_ then
							iter_143_8.color = arg_140_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_143_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_140_1.var_.actorSpriteComps10022 = nil
			end

			local var_143_23 = 0
			local var_143_24 = 0.9

			if var_143_23 < arg_140_1.time_ and arg_140_1.time_ <= var_143_23 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_25 = arg_140_1:FormatText(StoryNameCfg[996].name)

				arg_140_1.leftNameTxt_.text = var_143_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_26 = arg_140_1:GetWordFromCfg(413021034)
				local var_143_27 = arg_140_1:FormatText(var_143_26.content)

				arg_140_1.text_.text = var_143_27

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_28 = 36
				local var_143_29 = utf8.len(var_143_27)
				local var_143_30 = var_143_28 <= 0 and var_143_24 or var_143_24 * (var_143_29 / var_143_28)

				if var_143_30 > 0 and var_143_24 < var_143_30 then
					arg_140_1.talkMaxDuration = var_143_30

					if var_143_30 + var_143_23 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_30 + var_143_23
					end
				end

				arg_140_1.text_.text = var_143_27
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021034", "story_v_out_413021.awb") ~= 0 then
					local var_143_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021034", "story_v_out_413021.awb") / 1000

					if var_143_31 + var_143_23 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_31 + var_143_23
					end

					if var_143_26.prefab_name ~= "" and arg_140_1.actors_[var_143_26.prefab_name] ~= nil then
						local var_143_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_26.prefab_name].transform, "story_v_out_413021", "413021034", "story_v_out_413021.awb")

						arg_140_1:RecordAudio("413021034", var_143_32)
						arg_140_1:RecordAudio("413021034", var_143_32)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_413021", "413021034", "story_v_out_413021.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_413021", "413021034", "story_v_out_413021.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_33 = math.max(var_143_24, arg_140_1.talkMaxDuration)

			if var_143_23 <= arg_140_1.time_ and arg_140_1.time_ < var_143_23 + var_143_33 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_23) / var_143_33

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_23 + var_143_33 and arg_140_1.time_ < var_143_23 + var_143_33 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play413021035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 413021035
		arg_144_1.duration_ = 2.6

		local var_144_0 = {
			zh = 1.999999999999,
			ja = 2.6
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
				arg_144_0:Play413021036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["10092"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps10092 == nil then
				arg_144_1.var_.actorSpriteComps10092 = var_147_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_2 = 2

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.actorSpriteComps10092 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_147_1 then
							if arg_144_1.isInRecall_ then
								local var_147_4 = Mathf.Lerp(iter_147_1.color.r, arg_144_1.hightColor2.r, var_147_3)
								local var_147_5 = Mathf.Lerp(iter_147_1.color.g, arg_144_1.hightColor2.g, var_147_3)
								local var_147_6 = Mathf.Lerp(iter_147_1.color.b, arg_144_1.hightColor2.b, var_147_3)

								iter_147_1.color = Color.New(var_147_4, var_147_5, var_147_6)
							else
								local var_147_7 = Mathf.Lerp(iter_147_1.color.r, 0.5, var_147_3)

								iter_147_1.color = Color.New(var_147_7, var_147_7, var_147_7)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps10092 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_147_3 then
						if arg_144_1.isInRecall_ then
							iter_147_3.color = arg_144_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_147_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps10092 = nil
			end

			local var_147_8 = arg_144_1.actors_["10022"]
			local var_147_9 = 0

			if var_147_9 < arg_144_1.time_ and arg_144_1.time_ <= var_147_9 + arg_147_0 and not isNil(var_147_8) and arg_144_1.var_.actorSpriteComps10022 == nil then
				arg_144_1.var_.actorSpriteComps10022 = var_147_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_10 = 2

			if var_147_9 <= arg_144_1.time_ and arg_144_1.time_ < var_147_9 + var_147_10 and not isNil(var_147_8) then
				local var_147_11 = (arg_144_1.time_ - var_147_9) / var_147_10

				if arg_144_1.var_.actorSpriteComps10022 then
					for iter_147_4, iter_147_5 in pairs(arg_144_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_147_5 then
							if arg_144_1.isInRecall_ then
								local var_147_12 = Mathf.Lerp(iter_147_5.color.r, arg_144_1.hightColor1.r, var_147_11)
								local var_147_13 = Mathf.Lerp(iter_147_5.color.g, arg_144_1.hightColor1.g, var_147_11)
								local var_147_14 = Mathf.Lerp(iter_147_5.color.b, arg_144_1.hightColor1.b, var_147_11)

								iter_147_5.color = Color.New(var_147_12, var_147_13, var_147_14)
							else
								local var_147_15 = Mathf.Lerp(iter_147_5.color.r, 1, var_147_11)

								iter_147_5.color = Color.New(var_147_15, var_147_15, var_147_15)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_9 + var_147_10 and arg_144_1.time_ < var_147_9 + var_147_10 + arg_147_0 and not isNil(var_147_8) and arg_144_1.var_.actorSpriteComps10022 then
				for iter_147_6, iter_147_7 in pairs(arg_144_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_147_7 then
						if arg_144_1.isInRecall_ then
							iter_147_7.color = arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_147_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps10022 = nil
			end

			local var_147_16 = 0
			local var_147_17 = 0.175

			if var_147_16 < arg_144_1.time_ and arg_144_1.time_ <= var_147_16 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_18 = arg_144_1:FormatText(StoryNameCfg[614].name)

				arg_144_1.leftNameTxt_.text = var_147_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_19 = arg_144_1:GetWordFromCfg(413021035)
				local var_147_20 = arg_144_1:FormatText(var_147_19.content)

				arg_144_1.text_.text = var_147_20

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_21 = 7
				local var_147_22 = utf8.len(var_147_20)
				local var_147_23 = var_147_21 <= 0 and var_147_17 or var_147_17 * (var_147_22 / var_147_21)

				if var_147_23 > 0 and var_147_17 < var_147_23 then
					arg_144_1.talkMaxDuration = var_147_23

					if var_147_23 + var_147_16 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_23 + var_147_16
					end
				end

				arg_144_1.text_.text = var_147_20
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021035", "story_v_out_413021.awb") ~= 0 then
					local var_147_24 = manager.audio:GetVoiceLength("story_v_out_413021", "413021035", "story_v_out_413021.awb") / 1000

					if var_147_24 + var_147_16 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_24 + var_147_16
					end

					if var_147_19.prefab_name ~= "" and arg_144_1.actors_[var_147_19.prefab_name] ~= nil then
						local var_147_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_19.prefab_name].transform, "story_v_out_413021", "413021035", "story_v_out_413021.awb")

						arg_144_1:RecordAudio("413021035", var_147_25)
						arg_144_1:RecordAudio("413021035", var_147_25)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_413021", "413021035", "story_v_out_413021.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_413021", "413021035", "story_v_out_413021.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_26 = math.max(var_147_17, arg_144_1.talkMaxDuration)

			if var_147_16 <= arg_144_1.time_ and arg_144_1.time_ < var_147_16 + var_147_26 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_16) / var_147_26

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_16 + var_147_26 and arg_144_1.time_ < var_147_16 + var_147_26 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play413021036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 413021036
		arg_148_1.duration_ = 7

		local var_148_0 = {
			zh = 3.7,
			ja = 7
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
				arg_148_0:Play413021037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["10092"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps10092 == nil then
				arg_148_1.var_.actorSpriteComps10092 = var_151_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_2 = 2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.actorSpriteComps10092 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								local var_151_4 = Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor1.r, var_151_3)
								local var_151_5 = Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor1.g, var_151_3)
								local var_151_6 = Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor1.b, var_151_3)

								iter_151_1.color = Color.New(var_151_4, var_151_5, var_151_6)
							else
								local var_151_7 = Mathf.Lerp(iter_151_1.color.r, 1, var_151_3)

								iter_151_1.color = Color.New(var_151_7, var_151_7, var_151_7)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps10092 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_151_3 then
						if arg_148_1.isInRecall_ then
							iter_151_3.color = arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_151_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps10092 = nil
			end

			local var_151_8 = arg_148_1.actors_["10022"]
			local var_151_9 = 0

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 and not isNil(var_151_8) and arg_148_1.var_.actorSpriteComps10022 == nil then
				arg_148_1.var_.actorSpriteComps10022 = var_151_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_10 = 2

			if var_151_9 <= arg_148_1.time_ and arg_148_1.time_ < var_151_9 + var_151_10 and not isNil(var_151_8) then
				local var_151_11 = (arg_148_1.time_ - var_151_9) / var_151_10

				if arg_148_1.var_.actorSpriteComps10022 then
					for iter_151_4, iter_151_5 in pairs(arg_148_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_151_5 then
							if arg_148_1.isInRecall_ then
								local var_151_12 = Mathf.Lerp(iter_151_5.color.r, arg_148_1.hightColor2.r, var_151_11)
								local var_151_13 = Mathf.Lerp(iter_151_5.color.g, arg_148_1.hightColor2.g, var_151_11)
								local var_151_14 = Mathf.Lerp(iter_151_5.color.b, arg_148_1.hightColor2.b, var_151_11)

								iter_151_5.color = Color.New(var_151_12, var_151_13, var_151_14)
							else
								local var_151_15 = Mathf.Lerp(iter_151_5.color.r, 0.5, var_151_11)

								iter_151_5.color = Color.New(var_151_15, var_151_15, var_151_15)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= var_151_9 + var_151_10 and arg_148_1.time_ < var_151_9 + var_151_10 + arg_151_0 and not isNil(var_151_8) and arg_148_1.var_.actorSpriteComps10022 then
				for iter_151_6, iter_151_7 in pairs(arg_148_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_151_7 then
						if arg_148_1.isInRecall_ then
							iter_151_7.color = arg_148_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_151_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps10022 = nil
			end

			local var_151_16 = 0
			local var_151_17 = 0.55

			if var_151_16 < arg_148_1.time_ and arg_148_1.time_ <= var_151_16 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_18 = arg_148_1:FormatText(StoryNameCfg[996].name)

				arg_148_1.leftNameTxt_.text = var_151_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_19 = arg_148_1:GetWordFromCfg(413021036)
				local var_151_20 = arg_148_1:FormatText(var_151_19.content)

				arg_148_1.text_.text = var_151_20

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_21 = 22
				local var_151_22 = utf8.len(var_151_20)
				local var_151_23 = var_151_21 <= 0 and var_151_17 or var_151_17 * (var_151_22 / var_151_21)

				if var_151_23 > 0 and var_151_17 < var_151_23 then
					arg_148_1.talkMaxDuration = var_151_23

					if var_151_23 + var_151_16 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_23 + var_151_16
					end
				end

				arg_148_1.text_.text = var_151_20
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021036", "story_v_out_413021.awb") ~= 0 then
					local var_151_24 = manager.audio:GetVoiceLength("story_v_out_413021", "413021036", "story_v_out_413021.awb") / 1000

					if var_151_24 + var_151_16 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_24 + var_151_16
					end

					if var_151_19.prefab_name ~= "" and arg_148_1.actors_[var_151_19.prefab_name] ~= nil then
						local var_151_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_19.prefab_name].transform, "story_v_out_413021", "413021036", "story_v_out_413021.awb")

						arg_148_1:RecordAudio("413021036", var_151_25)
						arg_148_1:RecordAudio("413021036", var_151_25)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_413021", "413021036", "story_v_out_413021.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_413021", "413021036", "story_v_out_413021.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_26 = math.max(var_151_17, arg_148_1.talkMaxDuration)

			if var_151_16 <= arg_148_1.time_ and arg_148_1.time_ < var_151_16 + var_151_26 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_16) / var_151_26

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_16 + var_151_26 and arg_148_1.time_ < var_151_16 + var_151_26 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play413021037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 413021037
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play413021038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["10092"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos10092 = var_155_0.localPosition
				var_155_0.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("10092", 7)

				local var_155_2 = var_155_0.childCount

				for iter_155_0 = 0, var_155_2 - 1 do
					local var_155_3 = var_155_0:GetChild(iter_155_0)

					if var_155_3.name == "" or not string.find(var_155_3.name, "split") then
						var_155_3.gameObject:SetActive(true)
					else
						var_155_3.gameObject:SetActive(false)
					end
				end
			end

			local var_155_4 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_4 then
				local var_155_5 = (arg_152_1.time_ - var_155_1) / var_155_4
				local var_155_6 = Vector3.New(0, -2000, 0)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10092, var_155_6, var_155_5)
			end

			if arg_152_1.time_ >= var_155_1 + var_155_4 and arg_152_1.time_ < var_155_1 + var_155_4 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_155_7 = arg_152_1.actors_["10022"].transform
			local var_155_8 = 0

			if var_155_8 < arg_152_1.time_ and arg_152_1.time_ <= var_155_8 + arg_155_0 then
				arg_152_1.var_.moveOldPos10022 = var_155_7.localPosition
				var_155_7.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("10022", 7)

				local var_155_9 = var_155_7.childCount

				for iter_155_1 = 0, var_155_9 - 1 do
					local var_155_10 = var_155_7:GetChild(iter_155_1)

					if var_155_10.name == "" or not string.find(var_155_10.name, "split") then
						var_155_10.gameObject:SetActive(true)
					else
						var_155_10.gameObject:SetActive(false)
					end
				end
			end

			local var_155_11 = 0.001

			if var_155_8 <= arg_152_1.time_ and arg_152_1.time_ < var_155_8 + var_155_11 then
				local var_155_12 = (arg_152_1.time_ - var_155_8) / var_155_11
				local var_155_13 = Vector3.New(0, -2000, 0)

				var_155_7.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10022, var_155_13, var_155_12)
			end

			if arg_152_1.time_ >= var_155_8 + var_155_11 and arg_152_1.time_ < var_155_8 + var_155_11 + arg_155_0 then
				var_155_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_155_14 = arg_152_1.actors_["10092"]
			local var_155_15 = 0

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 and not isNil(var_155_14) and arg_152_1.var_.actorSpriteComps10092 == nil then
				arg_152_1.var_.actorSpriteComps10092 = var_155_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_16 = 2

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_16 and not isNil(var_155_14) then
				local var_155_17 = (arg_152_1.time_ - var_155_15) / var_155_16

				if arg_152_1.var_.actorSpriteComps10092 then
					for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_155_3 then
							if arg_152_1.isInRecall_ then
								local var_155_18 = Mathf.Lerp(iter_155_3.color.r, arg_152_1.hightColor2.r, var_155_17)
								local var_155_19 = Mathf.Lerp(iter_155_3.color.g, arg_152_1.hightColor2.g, var_155_17)
								local var_155_20 = Mathf.Lerp(iter_155_3.color.b, arg_152_1.hightColor2.b, var_155_17)

								iter_155_3.color = Color.New(var_155_18, var_155_19, var_155_20)
							else
								local var_155_21 = Mathf.Lerp(iter_155_3.color.r, 0.5, var_155_17)

								iter_155_3.color = Color.New(var_155_21, var_155_21, var_155_21)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= var_155_15 + var_155_16 and arg_152_1.time_ < var_155_15 + var_155_16 + arg_155_0 and not isNil(var_155_14) and arg_152_1.var_.actorSpriteComps10092 then
				for iter_155_4, iter_155_5 in pairs(arg_152_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_155_5 then
						if arg_152_1.isInRecall_ then
							iter_155_5.color = arg_152_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_155_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_152_1.var_.actorSpriteComps10092 = nil
			end

			local var_155_22 = arg_152_1.actors_["10022"]
			local var_155_23 = 0

			if var_155_23 < arg_152_1.time_ and arg_152_1.time_ <= var_155_23 + arg_155_0 and not isNil(var_155_22) and arg_152_1.var_.actorSpriteComps10022 == nil then
				arg_152_1.var_.actorSpriteComps10022 = var_155_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_24 = 2

			if var_155_23 <= arg_152_1.time_ and arg_152_1.time_ < var_155_23 + var_155_24 and not isNil(var_155_22) then
				local var_155_25 = (arg_152_1.time_ - var_155_23) / var_155_24

				if arg_152_1.var_.actorSpriteComps10022 then
					for iter_155_6, iter_155_7 in pairs(arg_152_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_155_7 then
							if arg_152_1.isInRecall_ then
								local var_155_26 = Mathf.Lerp(iter_155_7.color.r, arg_152_1.hightColor2.r, var_155_25)
								local var_155_27 = Mathf.Lerp(iter_155_7.color.g, arg_152_1.hightColor2.g, var_155_25)
								local var_155_28 = Mathf.Lerp(iter_155_7.color.b, arg_152_1.hightColor2.b, var_155_25)

								iter_155_7.color = Color.New(var_155_26, var_155_27, var_155_28)
							else
								local var_155_29 = Mathf.Lerp(iter_155_7.color.r, 0.5, var_155_25)

								iter_155_7.color = Color.New(var_155_29, var_155_29, var_155_29)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= var_155_23 + var_155_24 and arg_152_1.time_ < var_155_23 + var_155_24 + arg_155_0 and not isNil(var_155_22) and arg_152_1.var_.actorSpriteComps10022 then
				for iter_155_8, iter_155_9 in pairs(arg_152_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_155_9 then
						if arg_152_1.isInRecall_ then
							iter_155_9.color = arg_152_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_155_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_152_1.var_.actorSpriteComps10022 = nil
			end

			local var_155_30 = 0
			local var_155_31 = 0.925

			if var_155_30 < arg_152_1.time_ and arg_152_1.time_ <= var_155_30 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_32 = arg_152_1:GetWordFromCfg(413021037)
				local var_155_33 = arg_152_1:FormatText(var_155_32.content)

				arg_152_1.text_.text = var_155_33

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_34 = 37
				local var_155_35 = utf8.len(var_155_33)
				local var_155_36 = var_155_34 <= 0 and var_155_31 or var_155_31 * (var_155_35 / var_155_34)

				if var_155_36 > 0 and var_155_31 < var_155_36 then
					arg_152_1.talkMaxDuration = var_155_36

					if var_155_36 + var_155_30 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_36 + var_155_30
					end
				end

				arg_152_1.text_.text = var_155_33
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_37 = math.max(var_155_31, arg_152_1.talkMaxDuration)

			if var_155_30 <= arg_152_1.time_ and arg_152_1.time_ < var_155_30 + var_155_37 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_30) / var_155_37

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_30 + var_155_37 and arg_152_1.time_ < var_155_30 + var_155_37 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play413021038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 413021038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play413021039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 1.4

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_2 = arg_156_1:GetWordFromCfg(413021038)
				local var_159_3 = arg_156_1:FormatText(var_159_2.content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 56
				local var_159_5 = utf8.len(var_159_3)
				local var_159_6 = var_159_4 <= 0 and var_159_1 or var_159_1 * (var_159_5 / var_159_4)

				if var_159_6 > 0 and var_159_1 < var_159_6 then
					arg_156_1.talkMaxDuration = var_159_6

					if var_159_6 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_6 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_7 and arg_156_1.time_ < var_159_0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play413021039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 413021039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play413021040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 0.925

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_2 = arg_160_1:GetWordFromCfg(413021039)
				local var_163_3 = arg_160_1:FormatText(var_163_2.content)

				arg_160_1.text_.text = var_163_3

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 37
				local var_163_5 = utf8.len(var_163_3)
				local var_163_6 = var_163_4 <= 0 and var_163_1 or var_163_1 * (var_163_5 / var_163_4)

				if var_163_6 > 0 and var_163_1 < var_163_6 then
					arg_160_1.talkMaxDuration = var_163_6

					if var_163_6 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_6 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_3
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_7 and arg_160_1.time_ < var_163_0 + var_163_7 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play413021040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 413021040
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play413021041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 1.05

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_2 = arg_164_1:GetWordFromCfg(413021040)
				local var_167_3 = arg_164_1:FormatText(var_167_2.content)

				arg_164_1.text_.text = var_167_3

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_4 = 42
				local var_167_5 = utf8.len(var_167_3)
				local var_167_6 = var_167_4 <= 0 and var_167_1 or var_167_1 * (var_167_5 / var_167_4)

				if var_167_6 > 0 and var_167_1 < var_167_6 then
					arg_164_1.talkMaxDuration = var_167_6

					if var_167_6 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_6 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_3
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_7 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_7 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_7

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_7 and arg_164_1.time_ < var_167_0 + var_167_7 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play413021041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 413021041
		arg_168_1.duration_ = 5.07

		local var_168_0 = {
			zh = 4.133,
			ja = 5.066
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
				arg_168_0:Play413021042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10022"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos10022 = var_171_0.localPosition
				var_171_0.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("10022", 2)

				local var_171_2 = var_171_0.childCount

				for iter_171_0 = 0, var_171_2 - 1 do
					local var_171_3 = var_171_0:GetChild(iter_171_0)

					if var_171_3.name == "split_8" or not string.find(var_171_3.name, "split") then
						var_171_3.gameObject:SetActive(true)
					else
						var_171_3.gameObject:SetActive(false)
					end
				end
			end

			local var_171_4 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_4 then
				local var_171_5 = (arg_168_1.time_ - var_171_1) / var_171_4
				local var_171_6 = Vector3.New(-390, -315, -320)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10022, var_171_6, var_171_5)
			end

			if arg_168_1.time_ >= var_171_1 + var_171_4 and arg_168_1.time_ < var_171_1 + var_171_4 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_171_7 = arg_168_1.actors_["10022"]
			local var_171_8 = 0

			if var_171_8 < arg_168_1.time_ and arg_168_1.time_ <= var_171_8 + arg_171_0 and not isNil(var_171_7) and arg_168_1.var_.actorSpriteComps10022 == nil then
				arg_168_1.var_.actorSpriteComps10022 = var_171_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_9 = 2

			if var_171_8 <= arg_168_1.time_ and arg_168_1.time_ < var_171_8 + var_171_9 and not isNil(var_171_7) then
				local var_171_10 = (arg_168_1.time_ - var_171_8) / var_171_9

				if arg_168_1.var_.actorSpriteComps10022 then
					for iter_171_1, iter_171_2 in pairs(arg_168_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_171_2 then
							if arg_168_1.isInRecall_ then
								local var_171_11 = Mathf.Lerp(iter_171_2.color.r, arg_168_1.hightColor1.r, var_171_10)
								local var_171_12 = Mathf.Lerp(iter_171_2.color.g, arg_168_1.hightColor1.g, var_171_10)
								local var_171_13 = Mathf.Lerp(iter_171_2.color.b, arg_168_1.hightColor1.b, var_171_10)

								iter_171_2.color = Color.New(var_171_11, var_171_12, var_171_13)
							else
								local var_171_14 = Mathf.Lerp(iter_171_2.color.r, 1, var_171_10)

								iter_171_2.color = Color.New(var_171_14, var_171_14, var_171_14)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= var_171_8 + var_171_9 and arg_168_1.time_ < var_171_8 + var_171_9 + arg_171_0 and not isNil(var_171_7) and arg_168_1.var_.actorSpriteComps10022 then
				for iter_171_3, iter_171_4 in pairs(arg_168_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_171_4 then
						if arg_168_1.isInRecall_ then
							iter_171_4.color = arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_171_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_168_1.var_.actorSpriteComps10022 = nil
			end

			local var_171_15 = arg_168_1.actors_["10022"]
			local var_171_16 = 0

			if var_171_16 < arg_168_1.time_ and arg_168_1.time_ <= var_171_16 + arg_171_0 then
				local var_171_17 = var_171_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_171_17 then
					arg_168_1.var_.alphaOldValue10022 = var_171_17.alpha
					arg_168_1.var_.characterEffect10022 = var_171_17
				end

				arg_168_1.var_.alphaOldValue10022 = 0
			end

			local var_171_18 = 0.5

			if var_171_16 <= arg_168_1.time_ and arg_168_1.time_ < var_171_16 + var_171_18 then
				local var_171_19 = (arg_168_1.time_ - var_171_16) / var_171_18
				local var_171_20 = Mathf.Lerp(arg_168_1.var_.alphaOldValue10022, 1, var_171_19)

				if arg_168_1.var_.characterEffect10022 then
					arg_168_1.var_.characterEffect10022.alpha = var_171_20
				end
			end

			if arg_168_1.time_ >= var_171_16 + var_171_18 and arg_168_1.time_ < var_171_16 + var_171_18 + arg_171_0 and arg_168_1.var_.characterEffect10022 then
				arg_168_1.var_.characterEffect10022.alpha = 1
			end

			local var_171_21 = 0
			local var_171_22 = 0.475

			if var_171_21 < arg_168_1.time_ and arg_168_1.time_ <= var_171_21 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_23 = arg_168_1:FormatText(StoryNameCfg[614].name)

				arg_168_1.leftNameTxt_.text = var_171_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_24 = arg_168_1:GetWordFromCfg(413021041)
				local var_171_25 = arg_168_1:FormatText(var_171_24.content)

				arg_168_1.text_.text = var_171_25

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_26 = 19
				local var_171_27 = utf8.len(var_171_25)
				local var_171_28 = var_171_26 <= 0 and var_171_22 or var_171_22 * (var_171_27 / var_171_26)

				if var_171_28 > 0 and var_171_22 < var_171_28 then
					arg_168_1.talkMaxDuration = var_171_28

					if var_171_28 + var_171_21 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_28 + var_171_21
					end
				end

				arg_168_1.text_.text = var_171_25
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021041", "story_v_out_413021.awb") ~= 0 then
					local var_171_29 = manager.audio:GetVoiceLength("story_v_out_413021", "413021041", "story_v_out_413021.awb") / 1000

					if var_171_29 + var_171_21 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_29 + var_171_21
					end

					if var_171_24.prefab_name ~= "" and arg_168_1.actors_[var_171_24.prefab_name] ~= nil then
						local var_171_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_24.prefab_name].transform, "story_v_out_413021", "413021041", "story_v_out_413021.awb")

						arg_168_1:RecordAudio("413021041", var_171_30)
						arg_168_1:RecordAudio("413021041", var_171_30)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_413021", "413021041", "story_v_out_413021.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_413021", "413021041", "story_v_out_413021.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_31 = math.max(var_171_22, arg_168_1.talkMaxDuration)

			if var_171_21 <= arg_168_1.time_ and arg_168_1.time_ < var_171_21 + var_171_31 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_21) / var_171_31

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_21 + var_171_31 and arg_168_1.time_ < var_171_21 + var_171_31 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play413021042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 413021042
		arg_172_1.duration_ = 6.37

		local var_172_0 = {
			zh = 4.666,
			ja = 6.366
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play413021043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10092"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos10092 = var_175_0.localPosition
				var_175_0.localScale = Vector3.New(1, 1, 1)

				arg_172_1:CheckSpriteTmpPos("10092", 4)

				local var_175_2 = var_175_0.childCount

				for iter_175_0 = 0, var_175_2 - 1 do
					local var_175_3 = var_175_0:GetChild(iter_175_0)

					if var_175_3.name == "" or not string.find(var_175_3.name, "split") then
						var_175_3.gameObject:SetActive(true)
					else
						var_175_3.gameObject:SetActive(false)
					end
				end
			end

			local var_175_4 = 0.001

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_4 then
				local var_175_5 = (arg_172_1.time_ - var_175_1) / var_175_4
				local var_175_6 = Vector3.New(390, -300, -295)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos10092, var_175_6, var_175_5)
			end

			if arg_172_1.time_ >= var_175_1 + var_175_4 and arg_172_1.time_ < var_175_1 + var_175_4 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_175_7 = arg_172_1.actors_["10022"]
			local var_175_8 = 0

			if var_175_8 < arg_172_1.time_ and arg_172_1.time_ <= var_175_8 + arg_175_0 and not isNil(var_175_7) and arg_172_1.var_.actorSpriteComps10022 == nil then
				arg_172_1.var_.actorSpriteComps10022 = var_175_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_9 = 2

			if var_175_8 <= arg_172_1.time_ and arg_172_1.time_ < var_175_8 + var_175_9 and not isNil(var_175_7) then
				local var_175_10 = (arg_172_1.time_ - var_175_8) / var_175_9

				if arg_172_1.var_.actorSpriteComps10022 then
					for iter_175_1, iter_175_2 in pairs(arg_172_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_175_2 then
							if arg_172_1.isInRecall_ then
								local var_175_11 = Mathf.Lerp(iter_175_2.color.r, arg_172_1.hightColor2.r, var_175_10)
								local var_175_12 = Mathf.Lerp(iter_175_2.color.g, arg_172_1.hightColor2.g, var_175_10)
								local var_175_13 = Mathf.Lerp(iter_175_2.color.b, arg_172_1.hightColor2.b, var_175_10)

								iter_175_2.color = Color.New(var_175_11, var_175_12, var_175_13)
							else
								local var_175_14 = Mathf.Lerp(iter_175_2.color.r, 0.5, var_175_10)

								iter_175_2.color = Color.New(var_175_14, var_175_14, var_175_14)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= var_175_8 + var_175_9 and arg_172_1.time_ < var_175_8 + var_175_9 + arg_175_0 and not isNil(var_175_7) and arg_172_1.var_.actorSpriteComps10022 then
				for iter_175_3, iter_175_4 in pairs(arg_172_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_175_4 then
						if arg_172_1.isInRecall_ then
							iter_175_4.color = arg_172_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_175_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_172_1.var_.actorSpriteComps10022 = nil
			end

			local var_175_15 = arg_172_1.actors_["10092"]
			local var_175_16 = 0

			if var_175_16 < arg_172_1.time_ and arg_172_1.time_ <= var_175_16 + arg_175_0 and not isNil(var_175_15) and arg_172_1.var_.actorSpriteComps10092 == nil then
				arg_172_1.var_.actorSpriteComps10092 = var_175_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_17 = 2

			if var_175_16 <= arg_172_1.time_ and arg_172_1.time_ < var_175_16 + var_175_17 and not isNil(var_175_15) then
				local var_175_18 = (arg_172_1.time_ - var_175_16) / var_175_17

				if arg_172_1.var_.actorSpriteComps10092 then
					for iter_175_5, iter_175_6 in pairs(arg_172_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_175_6 then
							if arg_172_1.isInRecall_ then
								local var_175_19 = Mathf.Lerp(iter_175_6.color.r, arg_172_1.hightColor1.r, var_175_18)
								local var_175_20 = Mathf.Lerp(iter_175_6.color.g, arg_172_1.hightColor1.g, var_175_18)
								local var_175_21 = Mathf.Lerp(iter_175_6.color.b, arg_172_1.hightColor1.b, var_175_18)

								iter_175_6.color = Color.New(var_175_19, var_175_20, var_175_21)
							else
								local var_175_22 = Mathf.Lerp(iter_175_6.color.r, 1, var_175_18)

								iter_175_6.color = Color.New(var_175_22, var_175_22, var_175_22)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= var_175_16 + var_175_17 and arg_172_1.time_ < var_175_16 + var_175_17 + arg_175_0 and not isNil(var_175_15) and arg_172_1.var_.actorSpriteComps10092 then
				for iter_175_7, iter_175_8 in pairs(arg_172_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_175_8 then
						if arg_172_1.isInRecall_ then
							iter_175_8.color = arg_172_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_175_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_172_1.var_.actorSpriteComps10092 = nil
			end

			local var_175_23 = arg_172_1.actors_["10092"]
			local var_175_24 = 0

			if var_175_24 < arg_172_1.time_ and arg_172_1.time_ <= var_175_24 + arg_175_0 then
				local var_175_25 = var_175_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_175_25 then
					arg_172_1.var_.alphaOldValue10092 = var_175_25.alpha
					arg_172_1.var_.characterEffect10092 = var_175_25
				end

				arg_172_1.var_.alphaOldValue10092 = 0
			end

			local var_175_26 = 0.5

			if var_175_24 <= arg_172_1.time_ and arg_172_1.time_ < var_175_24 + var_175_26 then
				local var_175_27 = (arg_172_1.time_ - var_175_24) / var_175_26
				local var_175_28 = Mathf.Lerp(arg_172_1.var_.alphaOldValue10092, 1, var_175_27)

				if arg_172_1.var_.characterEffect10092 then
					arg_172_1.var_.characterEffect10092.alpha = var_175_28
				end
			end

			if arg_172_1.time_ >= var_175_24 + var_175_26 and arg_172_1.time_ < var_175_24 + var_175_26 + arg_175_0 and arg_172_1.var_.characterEffect10092 then
				arg_172_1.var_.characterEffect10092.alpha = 1
			end

			local var_175_29 = 0
			local var_175_30 = 0.625

			if var_175_29 < arg_172_1.time_ and arg_172_1.time_ <= var_175_29 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_31 = arg_172_1:FormatText(StoryNameCfg[996].name)

				arg_172_1.leftNameTxt_.text = var_175_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_32 = arg_172_1:GetWordFromCfg(413021042)
				local var_175_33 = arg_172_1:FormatText(var_175_32.content)

				arg_172_1.text_.text = var_175_33

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_34 = 25
				local var_175_35 = utf8.len(var_175_33)
				local var_175_36 = var_175_34 <= 0 and var_175_30 or var_175_30 * (var_175_35 / var_175_34)

				if var_175_36 > 0 and var_175_30 < var_175_36 then
					arg_172_1.talkMaxDuration = var_175_36

					if var_175_36 + var_175_29 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_36 + var_175_29
					end
				end

				arg_172_1.text_.text = var_175_33
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021042", "story_v_out_413021.awb") ~= 0 then
					local var_175_37 = manager.audio:GetVoiceLength("story_v_out_413021", "413021042", "story_v_out_413021.awb") / 1000

					if var_175_37 + var_175_29 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_37 + var_175_29
					end

					if var_175_32.prefab_name ~= "" and arg_172_1.actors_[var_175_32.prefab_name] ~= nil then
						local var_175_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_32.prefab_name].transform, "story_v_out_413021", "413021042", "story_v_out_413021.awb")

						arg_172_1:RecordAudio("413021042", var_175_38)
						arg_172_1:RecordAudio("413021042", var_175_38)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_413021", "413021042", "story_v_out_413021.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_413021", "413021042", "story_v_out_413021.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_39 = math.max(var_175_30, arg_172_1.talkMaxDuration)

			if var_175_29 <= arg_172_1.time_ and arg_172_1.time_ < var_175_29 + var_175_39 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_29) / var_175_39

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_29 + var_175_39 and arg_172_1.time_ < var_175_29 + var_175_39 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play413021043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 413021043
		arg_176_1.duration_ = 5.47

		local var_176_0 = {
			zh = 3.033,
			ja = 5.466
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
				arg_176_0:Play413021044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = "10093"

			if arg_176_1.actors_[var_179_0] == nil then
				local var_179_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_179_1) then
					local var_179_2 = Object.Instantiate(var_179_1, arg_176_1.canvasGo_.transform)

					var_179_2.transform:SetSiblingIndex(1)

					var_179_2.name = var_179_0
					var_179_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_176_1.actors_[var_179_0] = var_179_2

					local var_179_3 = var_179_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_176_1.isInRecall_ then
						for iter_179_0, iter_179_1 in ipairs(var_179_3) do
							iter_179_1.color = arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_179_4 = arg_176_1.actors_["10093"].transform
			local var_179_5 = 0

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1.var_.moveOldPos10093 = var_179_4.localPosition
				var_179_4.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10093", 2)

				local var_179_6 = var_179_4.childCount

				for iter_179_2 = 0, var_179_6 - 1 do
					local var_179_7 = var_179_4:GetChild(iter_179_2)

					if var_179_7.name == "" or not string.find(var_179_7.name, "split") then
						var_179_7.gameObject:SetActive(true)
					else
						var_179_7.gameObject:SetActive(false)
					end
				end
			end

			local var_179_8 = 0.001

			if var_179_5 <= arg_176_1.time_ and arg_176_1.time_ < var_179_5 + var_179_8 then
				local var_179_9 = (arg_176_1.time_ - var_179_5) / var_179_8
				local var_179_10 = Vector3.New(-390, -345, -245)

				var_179_4.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10093, var_179_10, var_179_9)
			end

			if arg_176_1.time_ >= var_179_5 + var_179_8 and arg_176_1.time_ < var_179_5 + var_179_8 + arg_179_0 then
				var_179_4.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_179_11 = arg_176_1.actors_["10093"]
			local var_179_12 = 0

			if var_179_12 < arg_176_1.time_ and arg_176_1.time_ <= var_179_12 + arg_179_0 and not isNil(var_179_11) and arg_176_1.var_.actorSpriteComps10093 == nil then
				arg_176_1.var_.actorSpriteComps10093 = var_179_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_13 = 2

			if var_179_12 <= arg_176_1.time_ and arg_176_1.time_ < var_179_12 + var_179_13 and not isNil(var_179_11) then
				local var_179_14 = (arg_176_1.time_ - var_179_12) / var_179_13

				if arg_176_1.var_.actorSpriteComps10093 then
					for iter_179_3, iter_179_4 in pairs(arg_176_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_179_4 then
							if arg_176_1.isInRecall_ then
								local var_179_15 = Mathf.Lerp(iter_179_4.color.r, arg_176_1.hightColor1.r, var_179_14)
								local var_179_16 = Mathf.Lerp(iter_179_4.color.g, arg_176_1.hightColor1.g, var_179_14)
								local var_179_17 = Mathf.Lerp(iter_179_4.color.b, arg_176_1.hightColor1.b, var_179_14)

								iter_179_4.color = Color.New(var_179_15, var_179_16, var_179_17)
							else
								local var_179_18 = Mathf.Lerp(iter_179_4.color.r, 1, var_179_14)

								iter_179_4.color = Color.New(var_179_18, var_179_18, var_179_18)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_12 + var_179_13 and arg_176_1.time_ < var_179_12 + var_179_13 + arg_179_0 and not isNil(var_179_11) and arg_176_1.var_.actorSpriteComps10093 then
				for iter_179_5, iter_179_6 in pairs(arg_176_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_179_6 then
						if arg_176_1.isInRecall_ then
							iter_179_6.color = arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_179_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps10093 = nil
			end

			local var_179_19 = arg_176_1.actors_["10092"]
			local var_179_20 = 0

			if var_179_20 < arg_176_1.time_ and arg_176_1.time_ <= var_179_20 + arg_179_0 and not isNil(var_179_19) and arg_176_1.var_.actorSpriteComps10092 == nil then
				arg_176_1.var_.actorSpriteComps10092 = var_179_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_21 = 2

			if var_179_20 <= arg_176_1.time_ and arg_176_1.time_ < var_179_20 + var_179_21 and not isNil(var_179_19) then
				local var_179_22 = (arg_176_1.time_ - var_179_20) / var_179_21

				if arg_176_1.var_.actorSpriteComps10092 then
					for iter_179_7, iter_179_8 in pairs(arg_176_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_179_8 then
							if arg_176_1.isInRecall_ then
								local var_179_23 = Mathf.Lerp(iter_179_8.color.r, arg_176_1.hightColor2.r, var_179_22)
								local var_179_24 = Mathf.Lerp(iter_179_8.color.g, arg_176_1.hightColor2.g, var_179_22)
								local var_179_25 = Mathf.Lerp(iter_179_8.color.b, arg_176_1.hightColor2.b, var_179_22)

								iter_179_8.color = Color.New(var_179_23, var_179_24, var_179_25)
							else
								local var_179_26 = Mathf.Lerp(iter_179_8.color.r, 0.5, var_179_22)

								iter_179_8.color = Color.New(var_179_26, var_179_26, var_179_26)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_20 + var_179_21 and arg_176_1.time_ < var_179_20 + var_179_21 + arg_179_0 and not isNil(var_179_19) and arg_176_1.var_.actorSpriteComps10092 then
				for iter_179_9, iter_179_10 in pairs(arg_176_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_179_10 then
						if arg_176_1.isInRecall_ then
							iter_179_10.color = arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_179_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps10092 = nil
			end

			local var_179_27 = arg_176_1.actors_["10093"]
			local var_179_28 = 0

			if var_179_28 < arg_176_1.time_ and arg_176_1.time_ <= var_179_28 + arg_179_0 then
				local var_179_29 = var_179_27:GetComponentInChildren(typeof(CanvasGroup))

				if var_179_29 then
					arg_176_1.var_.alphaOldValue10093 = var_179_29.alpha
					arg_176_1.var_.characterEffect10093 = var_179_29
				end

				arg_176_1.var_.alphaOldValue10093 = 0
			end

			local var_179_30 = 0.5

			if var_179_28 <= arg_176_1.time_ and arg_176_1.time_ < var_179_28 + var_179_30 then
				local var_179_31 = (arg_176_1.time_ - var_179_28) / var_179_30
				local var_179_32 = Mathf.Lerp(arg_176_1.var_.alphaOldValue10093, 1, var_179_31)

				if arg_176_1.var_.characterEffect10093 then
					arg_176_1.var_.characterEffect10093.alpha = var_179_32
				end
			end

			if arg_176_1.time_ >= var_179_28 + var_179_30 and arg_176_1.time_ < var_179_28 + var_179_30 + arg_179_0 and arg_176_1.var_.characterEffect10093 then
				arg_176_1.var_.characterEffect10093.alpha = 1
			end

			local var_179_33 = 0
			local var_179_34 = 0.4

			if var_179_33 < arg_176_1.time_ and arg_176_1.time_ <= var_179_33 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_35 = arg_176_1:FormatText(StoryNameCfg[28].name)

				arg_176_1.leftNameTxt_.text = var_179_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_36 = arg_176_1:GetWordFromCfg(413021043)
				local var_179_37 = arg_176_1:FormatText(var_179_36.content)

				arg_176_1.text_.text = var_179_37

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_38 = 16
				local var_179_39 = utf8.len(var_179_37)
				local var_179_40 = var_179_38 <= 0 and var_179_34 or var_179_34 * (var_179_39 / var_179_38)

				if var_179_40 > 0 and var_179_34 < var_179_40 then
					arg_176_1.talkMaxDuration = var_179_40

					if var_179_40 + var_179_33 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_40 + var_179_33
					end
				end

				arg_176_1.text_.text = var_179_37
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021043", "story_v_out_413021.awb") ~= 0 then
					local var_179_41 = manager.audio:GetVoiceLength("story_v_out_413021", "413021043", "story_v_out_413021.awb") / 1000

					if var_179_41 + var_179_33 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_41 + var_179_33
					end

					if var_179_36.prefab_name ~= "" and arg_176_1.actors_[var_179_36.prefab_name] ~= nil then
						local var_179_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_36.prefab_name].transform, "story_v_out_413021", "413021043", "story_v_out_413021.awb")

						arg_176_1:RecordAudio("413021043", var_179_42)
						arg_176_1:RecordAudio("413021043", var_179_42)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_413021", "413021043", "story_v_out_413021.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_413021", "413021043", "story_v_out_413021.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_43 = math.max(var_179_34, arg_176_1.talkMaxDuration)

			if var_179_33 <= arg_176_1.time_ and arg_176_1.time_ < var_179_33 + var_179_43 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_33) / var_179_43

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_33 + var_179_43 and arg_176_1.time_ < var_179_33 + var_179_43 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play413021044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 413021044
		arg_180_1.duration_ = 4.6

		local var_180_0 = {
			zh = 3.633,
			ja = 4.6
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
				arg_180_0:Play413021045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10093"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps10093 == nil then
				arg_180_1.var_.actorSpriteComps10093 = var_183_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_2 = 2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.actorSpriteComps10093 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								local var_183_4 = Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor2.r, var_183_3)
								local var_183_5 = Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor2.g, var_183_3)
								local var_183_6 = Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor2.b, var_183_3)

								iter_183_1.color = Color.New(var_183_4, var_183_5, var_183_6)
							else
								local var_183_7 = Mathf.Lerp(iter_183_1.color.r, 0.5, var_183_3)

								iter_183_1.color = Color.New(var_183_7, var_183_7, var_183_7)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps10093 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_183_3 then
						if arg_180_1.isInRecall_ then
							iter_183_3.color = arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_183_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps10093 = nil
			end

			local var_183_8 = arg_180_1.actors_["10092"]
			local var_183_9 = 0

			if var_183_9 < arg_180_1.time_ and arg_180_1.time_ <= var_183_9 + arg_183_0 and not isNil(var_183_8) and arg_180_1.var_.actorSpriteComps10092 == nil then
				arg_180_1.var_.actorSpriteComps10092 = var_183_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_10 = 2

			if var_183_9 <= arg_180_1.time_ and arg_180_1.time_ < var_183_9 + var_183_10 and not isNil(var_183_8) then
				local var_183_11 = (arg_180_1.time_ - var_183_9) / var_183_10

				if arg_180_1.var_.actorSpriteComps10092 then
					for iter_183_4, iter_183_5 in pairs(arg_180_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_183_5 then
							if arg_180_1.isInRecall_ then
								local var_183_12 = Mathf.Lerp(iter_183_5.color.r, arg_180_1.hightColor1.r, var_183_11)
								local var_183_13 = Mathf.Lerp(iter_183_5.color.g, arg_180_1.hightColor1.g, var_183_11)
								local var_183_14 = Mathf.Lerp(iter_183_5.color.b, arg_180_1.hightColor1.b, var_183_11)

								iter_183_5.color = Color.New(var_183_12, var_183_13, var_183_14)
							else
								local var_183_15 = Mathf.Lerp(iter_183_5.color.r, 1, var_183_11)

								iter_183_5.color = Color.New(var_183_15, var_183_15, var_183_15)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_9 + var_183_10 and arg_180_1.time_ < var_183_9 + var_183_10 + arg_183_0 and not isNil(var_183_8) and arg_180_1.var_.actorSpriteComps10092 then
				for iter_183_6, iter_183_7 in pairs(arg_180_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_183_7 then
						if arg_180_1.isInRecall_ then
							iter_183_7.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_183_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps10092 = nil
			end

			local var_183_16 = 0
			local var_183_17 = 0.45

			if var_183_16 < arg_180_1.time_ and arg_180_1.time_ <= var_183_16 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_18 = arg_180_1:FormatText(StoryNameCfg[996].name)

				arg_180_1.leftNameTxt_.text = var_183_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_19 = arg_180_1:GetWordFromCfg(413021044)
				local var_183_20 = arg_180_1:FormatText(var_183_19.content)

				arg_180_1.text_.text = var_183_20

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_21 = 18
				local var_183_22 = utf8.len(var_183_20)
				local var_183_23 = var_183_21 <= 0 and var_183_17 or var_183_17 * (var_183_22 / var_183_21)

				if var_183_23 > 0 and var_183_17 < var_183_23 then
					arg_180_1.talkMaxDuration = var_183_23

					if var_183_23 + var_183_16 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_23 + var_183_16
					end
				end

				arg_180_1.text_.text = var_183_20
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021044", "story_v_out_413021.awb") ~= 0 then
					local var_183_24 = manager.audio:GetVoiceLength("story_v_out_413021", "413021044", "story_v_out_413021.awb") / 1000

					if var_183_24 + var_183_16 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_24 + var_183_16
					end

					if var_183_19.prefab_name ~= "" and arg_180_1.actors_[var_183_19.prefab_name] ~= nil then
						local var_183_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_19.prefab_name].transform, "story_v_out_413021", "413021044", "story_v_out_413021.awb")

						arg_180_1:RecordAudio("413021044", var_183_25)
						arg_180_1:RecordAudio("413021044", var_183_25)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_413021", "413021044", "story_v_out_413021.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_413021", "413021044", "story_v_out_413021.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_26 = math.max(var_183_17, arg_180_1.talkMaxDuration)

			if var_183_16 <= arg_180_1.time_ and arg_180_1.time_ < var_183_16 + var_183_26 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_16) / var_183_26

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_16 + var_183_26 and arg_180_1.time_ < var_183_16 + var_183_26 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play413021045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 413021045
		arg_184_1.duration_ = 3.73

		local var_184_0 = {
			zh = 3.733,
			ja = 3.433
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
				arg_184_0:Play413021046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10093"].transform
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.var_.moveOldPos10093 = var_187_0.localPosition
				var_187_0.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10093", 2)

				local var_187_2 = var_187_0.childCount

				for iter_187_0 = 0, var_187_2 - 1 do
					local var_187_3 = var_187_0:GetChild(iter_187_0)

					if var_187_3.name == "split_6" or not string.find(var_187_3.name, "split") then
						var_187_3.gameObject:SetActive(true)
					else
						var_187_3.gameObject:SetActive(false)
					end
				end
			end

			local var_187_4 = 0.001

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_4 then
				local var_187_5 = (arg_184_1.time_ - var_187_1) / var_187_4
				local var_187_6 = Vector3.New(-390, -345, -245)

				var_187_0.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10093, var_187_6, var_187_5)
			end

			if arg_184_1.time_ >= var_187_1 + var_187_4 and arg_184_1.time_ < var_187_1 + var_187_4 + arg_187_0 then
				var_187_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_187_7 = arg_184_1.actors_["10093"]
			local var_187_8 = 0

			if var_187_8 < arg_184_1.time_ and arg_184_1.time_ <= var_187_8 + arg_187_0 and not isNil(var_187_7) and arg_184_1.var_.actorSpriteComps10093 == nil then
				arg_184_1.var_.actorSpriteComps10093 = var_187_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_9 = 2

			if var_187_8 <= arg_184_1.time_ and arg_184_1.time_ < var_187_8 + var_187_9 and not isNil(var_187_7) then
				local var_187_10 = (arg_184_1.time_ - var_187_8) / var_187_9

				if arg_184_1.var_.actorSpriteComps10093 then
					for iter_187_1, iter_187_2 in pairs(arg_184_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_187_2 then
							if arg_184_1.isInRecall_ then
								local var_187_11 = Mathf.Lerp(iter_187_2.color.r, arg_184_1.hightColor1.r, var_187_10)
								local var_187_12 = Mathf.Lerp(iter_187_2.color.g, arg_184_1.hightColor1.g, var_187_10)
								local var_187_13 = Mathf.Lerp(iter_187_2.color.b, arg_184_1.hightColor1.b, var_187_10)

								iter_187_2.color = Color.New(var_187_11, var_187_12, var_187_13)
							else
								local var_187_14 = Mathf.Lerp(iter_187_2.color.r, 1, var_187_10)

								iter_187_2.color = Color.New(var_187_14, var_187_14, var_187_14)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_8 + var_187_9 and arg_184_1.time_ < var_187_8 + var_187_9 + arg_187_0 and not isNil(var_187_7) and arg_184_1.var_.actorSpriteComps10093 then
				for iter_187_3, iter_187_4 in pairs(arg_184_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_187_4 then
						if arg_184_1.isInRecall_ then
							iter_187_4.color = arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_187_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps10093 = nil
			end

			local var_187_15 = arg_184_1.actors_["10092"]
			local var_187_16 = 0

			if var_187_16 < arg_184_1.time_ and arg_184_1.time_ <= var_187_16 + arg_187_0 and not isNil(var_187_15) and arg_184_1.var_.actorSpriteComps10092 == nil then
				arg_184_1.var_.actorSpriteComps10092 = var_187_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_17 = 2

			if var_187_16 <= arg_184_1.time_ and arg_184_1.time_ < var_187_16 + var_187_17 and not isNil(var_187_15) then
				local var_187_18 = (arg_184_1.time_ - var_187_16) / var_187_17

				if arg_184_1.var_.actorSpriteComps10092 then
					for iter_187_5, iter_187_6 in pairs(arg_184_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_187_6 then
							if arg_184_1.isInRecall_ then
								local var_187_19 = Mathf.Lerp(iter_187_6.color.r, arg_184_1.hightColor2.r, var_187_18)
								local var_187_20 = Mathf.Lerp(iter_187_6.color.g, arg_184_1.hightColor2.g, var_187_18)
								local var_187_21 = Mathf.Lerp(iter_187_6.color.b, arg_184_1.hightColor2.b, var_187_18)

								iter_187_6.color = Color.New(var_187_19, var_187_20, var_187_21)
							else
								local var_187_22 = Mathf.Lerp(iter_187_6.color.r, 0.5, var_187_18)

								iter_187_6.color = Color.New(var_187_22, var_187_22, var_187_22)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_16 + var_187_17 and arg_184_1.time_ < var_187_16 + var_187_17 + arg_187_0 and not isNil(var_187_15) and arg_184_1.var_.actorSpriteComps10092 then
				for iter_187_7, iter_187_8 in pairs(arg_184_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_187_8 then
						if arg_184_1.isInRecall_ then
							iter_187_8.color = arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_187_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps10092 = nil
			end

			local var_187_23 = 0
			local var_187_24 = 0.525

			if var_187_23 < arg_184_1.time_ and arg_184_1.time_ <= var_187_23 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_25 = arg_184_1:FormatText(StoryNameCfg[28].name)

				arg_184_1.leftNameTxt_.text = var_187_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_26 = arg_184_1:GetWordFromCfg(413021045)
				local var_187_27 = arg_184_1:FormatText(var_187_26.content)

				arg_184_1.text_.text = var_187_27

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_28 = 21
				local var_187_29 = utf8.len(var_187_27)
				local var_187_30 = var_187_28 <= 0 and var_187_24 or var_187_24 * (var_187_29 / var_187_28)

				if var_187_30 > 0 and var_187_24 < var_187_30 then
					arg_184_1.talkMaxDuration = var_187_30

					if var_187_30 + var_187_23 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_30 + var_187_23
					end
				end

				arg_184_1.text_.text = var_187_27
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021045", "story_v_out_413021.awb") ~= 0 then
					local var_187_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021045", "story_v_out_413021.awb") / 1000

					if var_187_31 + var_187_23 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_31 + var_187_23
					end

					if var_187_26.prefab_name ~= "" and arg_184_1.actors_[var_187_26.prefab_name] ~= nil then
						local var_187_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_26.prefab_name].transform, "story_v_out_413021", "413021045", "story_v_out_413021.awb")

						arg_184_1:RecordAudio("413021045", var_187_32)
						arg_184_1:RecordAudio("413021045", var_187_32)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_413021", "413021045", "story_v_out_413021.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_413021", "413021045", "story_v_out_413021.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_33 = math.max(var_187_24, arg_184_1.talkMaxDuration)

			if var_187_23 <= arg_184_1.time_ and arg_184_1.time_ < var_187_23 + var_187_33 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_23) / var_187_33

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_23 + var_187_33 and arg_184_1.time_ < var_187_23 + var_187_33 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play413021046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 413021046
		arg_188_1.duration_ = 9.57

		local var_188_0 = {
			zh = 4.8,
			ja = 9.566
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play413021047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10092"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos10092 = var_191_0.localPosition
				var_191_0.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10092", 4)

				local var_191_2 = var_191_0.childCount

				for iter_191_0 = 0, var_191_2 - 1 do
					local var_191_3 = var_191_0:GetChild(iter_191_0)

					if var_191_3.name == "" or not string.find(var_191_3.name, "split") then
						var_191_3.gameObject:SetActive(true)
					else
						var_191_3.gameObject:SetActive(false)
					end
				end
			end

			local var_191_4 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_4 then
				local var_191_5 = (arg_188_1.time_ - var_191_1) / var_191_4
				local var_191_6 = Vector3.New(390, -300, -295)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10092, var_191_6, var_191_5)
			end

			if arg_188_1.time_ >= var_191_1 + var_191_4 and arg_188_1.time_ < var_191_1 + var_191_4 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_191_7 = arg_188_1.actors_["10092"]
			local var_191_8 = 0

			if var_191_8 < arg_188_1.time_ and arg_188_1.time_ <= var_191_8 + arg_191_0 and not isNil(var_191_7) and arg_188_1.var_.actorSpriteComps10092 == nil then
				arg_188_1.var_.actorSpriteComps10092 = var_191_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_9 = 2

			if var_191_8 <= arg_188_1.time_ and arg_188_1.time_ < var_191_8 + var_191_9 and not isNil(var_191_7) then
				local var_191_10 = (arg_188_1.time_ - var_191_8) / var_191_9

				if arg_188_1.var_.actorSpriteComps10092 then
					for iter_191_1, iter_191_2 in pairs(arg_188_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_191_2 then
							if arg_188_1.isInRecall_ then
								local var_191_11 = Mathf.Lerp(iter_191_2.color.r, arg_188_1.hightColor1.r, var_191_10)
								local var_191_12 = Mathf.Lerp(iter_191_2.color.g, arg_188_1.hightColor1.g, var_191_10)
								local var_191_13 = Mathf.Lerp(iter_191_2.color.b, arg_188_1.hightColor1.b, var_191_10)

								iter_191_2.color = Color.New(var_191_11, var_191_12, var_191_13)
							else
								local var_191_14 = Mathf.Lerp(iter_191_2.color.r, 1, var_191_10)

								iter_191_2.color = Color.New(var_191_14, var_191_14, var_191_14)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_8 + var_191_9 and arg_188_1.time_ < var_191_8 + var_191_9 + arg_191_0 and not isNil(var_191_7) and arg_188_1.var_.actorSpriteComps10092 then
				for iter_191_3, iter_191_4 in pairs(arg_188_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_191_4 then
						if arg_188_1.isInRecall_ then
							iter_191_4.color = arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_191_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps10092 = nil
			end

			local var_191_15 = arg_188_1.actors_["10093"]
			local var_191_16 = 0

			if var_191_16 < arg_188_1.time_ and arg_188_1.time_ <= var_191_16 + arg_191_0 and not isNil(var_191_15) and arg_188_1.var_.actorSpriteComps10093 == nil then
				arg_188_1.var_.actorSpriteComps10093 = var_191_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_17 = 2

			if var_191_16 <= arg_188_1.time_ and arg_188_1.time_ < var_191_16 + var_191_17 and not isNil(var_191_15) then
				local var_191_18 = (arg_188_1.time_ - var_191_16) / var_191_17

				if arg_188_1.var_.actorSpriteComps10093 then
					for iter_191_5, iter_191_6 in pairs(arg_188_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_191_6 then
							if arg_188_1.isInRecall_ then
								local var_191_19 = Mathf.Lerp(iter_191_6.color.r, arg_188_1.hightColor2.r, var_191_18)
								local var_191_20 = Mathf.Lerp(iter_191_6.color.g, arg_188_1.hightColor2.g, var_191_18)
								local var_191_21 = Mathf.Lerp(iter_191_6.color.b, arg_188_1.hightColor2.b, var_191_18)

								iter_191_6.color = Color.New(var_191_19, var_191_20, var_191_21)
							else
								local var_191_22 = Mathf.Lerp(iter_191_6.color.r, 0.5, var_191_18)

								iter_191_6.color = Color.New(var_191_22, var_191_22, var_191_22)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_16 + var_191_17 and arg_188_1.time_ < var_191_16 + var_191_17 + arg_191_0 and not isNil(var_191_15) and arg_188_1.var_.actorSpriteComps10093 then
				for iter_191_7, iter_191_8 in pairs(arg_188_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_191_8 then
						if arg_188_1.isInRecall_ then
							iter_191_8.color = arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_191_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps10093 = nil
			end

			local var_191_23 = 0
			local var_191_24 = 0.6

			if var_191_23 < arg_188_1.time_ and arg_188_1.time_ <= var_191_23 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_25 = arg_188_1:FormatText(StoryNameCfg[996].name)

				arg_188_1.leftNameTxt_.text = var_191_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_26 = arg_188_1:GetWordFromCfg(413021046)
				local var_191_27 = arg_188_1:FormatText(var_191_26.content)

				arg_188_1.text_.text = var_191_27

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_28 = 24
				local var_191_29 = utf8.len(var_191_27)
				local var_191_30 = var_191_28 <= 0 and var_191_24 or var_191_24 * (var_191_29 / var_191_28)

				if var_191_30 > 0 and var_191_24 < var_191_30 then
					arg_188_1.talkMaxDuration = var_191_30

					if var_191_30 + var_191_23 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_30 + var_191_23
					end
				end

				arg_188_1.text_.text = var_191_27
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021046", "story_v_out_413021.awb") ~= 0 then
					local var_191_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021046", "story_v_out_413021.awb") / 1000

					if var_191_31 + var_191_23 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_31 + var_191_23
					end

					if var_191_26.prefab_name ~= "" and arg_188_1.actors_[var_191_26.prefab_name] ~= nil then
						local var_191_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_26.prefab_name].transform, "story_v_out_413021", "413021046", "story_v_out_413021.awb")

						arg_188_1:RecordAudio("413021046", var_191_32)
						arg_188_1:RecordAudio("413021046", var_191_32)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_413021", "413021046", "story_v_out_413021.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_413021", "413021046", "story_v_out_413021.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_33 = math.max(var_191_24, arg_188_1.talkMaxDuration)

			if var_191_23 <= arg_188_1.time_ and arg_188_1.time_ < var_191_23 + var_191_33 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_23) / var_191_33

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_23 + var_191_33 and arg_188_1.time_ < var_191_23 + var_191_33 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play413021047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 413021047
		arg_192_1.duration_ = 8.8

		local var_192_0 = {
			zh = 5,
			ja = 8.8
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play413021048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10092"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos10092 = var_195_0.localPosition
				var_195_0.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("10092", 4)

				local var_195_2 = var_195_0.childCount

				for iter_195_0 = 0, var_195_2 - 1 do
					local var_195_3 = var_195_0:GetChild(iter_195_0)

					if var_195_3.name == "split_2" or not string.find(var_195_3.name, "split") then
						var_195_3.gameObject:SetActive(true)
					else
						var_195_3.gameObject:SetActive(false)
					end
				end
			end

			local var_195_4 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_4 then
				local var_195_5 = (arg_192_1.time_ - var_195_1) / var_195_4
				local var_195_6 = Vector3.New(390, -300, -295)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10092, var_195_6, var_195_5)
			end

			if arg_192_1.time_ >= var_195_1 + var_195_4 and arg_192_1.time_ < var_195_1 + var_195_4 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_195_7 = 0
			local var_195_8 = 0.575

			if var_195_7 < arg_192_1.time_ and arg_192_1.time_ <= var_195_7 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_9 = arg_192_1:FormatText(StoryNameCfg[996].name)

				arg_192_1.leftNameTxt_.text = var_195_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_10 = arg_192_1:GetWordFromCfg(413021047)
				local var_195_11 = arg_192_1:FormatText(var_195_10.content)

				arg_192_1.text_.text = var_195_11

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_12 = 23
				local var_195_13 = utf8.len(var_195_11)
				local var_195_14 = var_195_12 <= 0 and var_195_8 or var_195_8 * (var_195_13 / var_195_12)

				if var_195_14 > 0 and var_195_8 < var_195_14 then
					arg_192_1.talkMaxDuration = var_195_14

					if var_195_14 + var_195_7 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_14 + var_195_7
					end
				end

				arg_192_1.text_.text = var_195_11
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021047", "story_v_out_413021.awb") ~= 0 then
					local var_195_15 = manager.audio:GetVoiceLength("story_v_out_413021", "413021047", "story_v_out_413021.awb") / 1000

					if var_195_15 + var_195_7 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_15 + var_195_7
					end

					if var_195_10.prefab_name ~= "" and arg_192_1.actors_[var_195_10.prefab_name] ~= nil then
						local var_195_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_10.prefab_name].transform, "story_v_out_413021", "413021047", "story_v_out_413021.awb")

						arg_192_1:RecordAudio("413021047", var_195_16)
						arg_192_1:RecordAudio("413021047", var_195_16)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_413021", "413021047", "story_v_out_413021.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_413021", "413021047", "story_v_out_413021.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_17 = math.max(var_195_8, arg_192_1.talkMaxDuration)

			if var_195_7 <= arg_192_1.time_ and arg_192_1.time_ < var_195_7 + var_195_17 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_7) / var_195_17

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_7 + var_195_17 and arg_192_1.time_ < var_195_7 + var_195_17 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play413021048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 413021048
		arg_196_1.duration_ = 2.73

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play413021049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10022"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos10022 = var_199_0.localPosition
				var_199_0.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("10022", 2)

				local var_199_2 = var_199_0.childCount

				for iter_199_0 = 0, var_199_2 - 1 do
					local var_199_3 = var_199_0:GetChild(iter_199_0)

					if var_199_3.name == "split_6" or not string.find(var_199_3.name, "split") then
						var_199_3.gameObject:SetActive(true)
					else
						var_199_3.gameObject:SetActive(false)
					end
				end
			end

			local var_199_4 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_4 then
				local var_199_5 = (arg_196_1.time_ - var_199_1) / var_199_4
				local var_199_6 = Vector3.New(-390, -315, -320)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10022, var_199_6, var_199_5)
			end

			if arg_196_1.time_ >= var_199_1 + var_199_4 and arg_196_1.time_ < var_199_1 + var_199_4 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_199_7 = arg_196_1.actors_["10092"]
			local var_199_8 = 0

			if var_199_8 < arg_196_1.time_ and arg_196_1.time_ <= var_199_8 + arg_199_0 and not isNil(var_199_7) and arg_196_1.var_.actorSpriteComps10092 == nil then
				arg_196_1.var_.actorSpriteComps10092 = var_199_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_9 = 2

			if var_199_8 <= arg_196_1.time_ and arg_196_1.time_ < var_199_8 + var_199_9 and not isNil(var_199_7) then
				local var_199_10 = (arg_196_1.time_ - var_199_8) / var_199_9

				if arg_196_1.var_.actorSpriteComps10092 then
					for iter_199_1, iter_199_2 in pairs(arg_196_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_199_2 then
							if arg_196_1.isInRecall_ then
								local var_199_11 = Mathf.Lerp(iter_199_2.color.r, arg_196_1.hightColor2.r, var_199_10)
								local var_199_12 = Mathf.Lerp(iter_199_2.color.g, arg_196_1.hightColor2.g, var_199_10)
								local var_199_13 = Mathf.Lerp(iter_199_2.color.b, arg_196_1.hightColor2.b, var_199_10)

								iter_199_2.color = Color.New(var_199_11, var_199_12, var_199_13)
							else
								local var_199_14 = Mathf.Lerp(iter_199_2.color.r, 0.5, var_199_10)

								iter_199_2.color = Color.New(var_199_14, var_199_14, var_199_14)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= var_199_8 + var_199_9 and arg_196_1.time_ < var_199_8 + var_199_9 + arg_199_0 and not isNil(var_199_7) and arg_196_1.var_.actorSpriteComps10092 then
				for iter_199_3, iter_199_4 in pairs(arg_196_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_199_4 then
						if arg_196_1.isInRecall_ then
							iter_199_4.color = arg_196_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_199_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_196_1.var_.actorSpriteComps10092 = nil
			end

			local var_199_15 = arg_196_1.actors_["10022"]
			local var_199_16 = 0

			if var_199_16 < arg_196_1.time_ and arg_196_1.time_ <= var_199_16 + arg_199_0 and not isNil(var_199_15) and arg_196_1.var_.actorSpriteComps10022 == nil then
				arg_196_1.var_.actorSpriteComps10022 = var_199_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_17 = 2

			if var_199_16 <= arg_196_1.time_ and arg_196_1.time_ < var_199_16 + var_199_17 and not isNil(var_199_15) then
				local var_199_18 = (arg_196_1.time_ - var_199_16) / var_199_17

				if arg_196_1.var_.actorSpriteComps10022 then
					for iter_199_5, iter_199_6 in pairs(arg_196_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_199_6 then
							if arg_196_1.isInRecall_ then
								local var_199_19 = Mathf.Lerp(iter_199_6.color.r, arg_196_1.hightColor1.r, var_199_18)
								local var_199_20 = Mathf.Lerp(iter_199_6.color.g, arg_196_1.hightColor1.g, var_199_18)
								local var_199_21 = Mathf.Lerp(iter_199_6.color.b, arg_196_1.hightColor1.b, var_199_18)

								iter_199_6.color = Color.New(var_199_19, var_199_20, var_199_21)
							else
								local var_199_22 = Mathf.Lerp(iter_199_6.color.r, 1, var_199_18)

								iter_199_6.color = Color.New(var_199_22, var_199_22, var_199_22)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= var_199_16 + var_199_17 and arg_196_1.time_ < var_199_16 + var_199_17 + arg_199_0 and not isNil(var_199_15) and arg_196_1.var_.actorSpriteComps10022 then
				for iter_199_7, iter_199_8 in pairs(arg_196_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_199_8 then
						if arg_196_1.isInRecall_ then
							iter_199_8.color = arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_199_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_196_1.var_.actorSpriteComps10022 = nil
			end

			local var_199_23 = 0
			local var_199_24 = 0.15

			if var_199_23 < arg_196_1.time_ and arg_196_1.time_ <= var_199_23 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_25 = arg_196_1:FormatText(StoryNameCfg[614].name)

				arg_196_1.leftNameTxt_.text = var_199_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_26 = arg_196_1:GetWordFromCfg(413021048)
				local var_199_27 = arg_196_1:FormatText(var_199_26.content)

				arg_196_1.text_.text = var_199_27

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_28 = 6
				local var_199_29 = utf8.len(var_199_27)
				local var_199_30 = var_199_28 <= 0 and var_199_24 or var_199_24 * (var_199_29 / var_199_28)

				if var_199_30 > 0 and var_199_24 < var_199_30 then
					arg_196_1.talkMaxDuration = var_199_30

					if var_199_30 + var_199_23 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_30 + var_199_23
					end
				end

				arg_196_1.text_.text = var_199_27
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021048", "story_v_out_413021.awb") ~= 0 then
					local var_199_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021048", "story_v_out_413021.awb") / 1000

					if var_199_31 + var_199_23 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_31 + var_199_23
					end

					if var_199_26.prefab_name ~= "" and arg_196_1.actors_[var_199_26.prefab_name] ~= nil then
						local var_199_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_26.prefab_name].transform, "story_v_out_413021", "413021048", "story_v_out_413021.awb")

						arg_196_1:RecordAudio("413021048", var_199_32)
						arg_196_1:RecordAudio("413021048", var_199_32)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_413021", "413021048", "story_v_out_413021.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_413021", "413021048", "story_v_out_413021.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_33 = math.max(var_199_24, arg_196_1.talkMaxDuration)

			if var_199_23 <= arg_196_1.time_ and arg_196_1.time_ < var_199_23 + var_199_33 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_23) / var_199_33

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_23 + var_199_33 and arg_196_1.time_ < var_199_23 + var_199_33 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play413021049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 413021049
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play413021050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["10092"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos10092 = var_203_0.localPosition
				var_203_0.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10092", 7)

				local var_203_2 = var_203_0.childCount

				for iter_203_0 = 0, var_203_2 - 1 do
					local var_203_3 = var_203_0:GetChild(iter_203_0)

					if var_203_3.name == "" or not string.find(var_203_3.name, "split") then
						var_203_3.gameObject:SetActive(true)
					else
						var_203_3.gameObject:SetActive(false)
					end
				end
			end

			local var_203_4 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_4 then
				local var_203_5 = (arg_200_1.time_ - var_203_1) / var_203_4
				local var_203_6 = Vector3.New(0, -2000, 0)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10092, var_203_6, var_203_5)
			end

			if arg_200_1.time_ >= var_203_1 + var_203_4 and arg_200_1.time_ < var_203_1 + var_203_4 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_203_7 = arg_200_1.actors_["10022"].transform
			local var_203_8 = 0

			if var_203_8 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 then
				arg_200_1.var_.moveOldPos10022 = var_203_7.localPosition
				var_203_7.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10022", 7)

				local var_203_9 = var_203_7.childCount

				for iter_203_1 = 0, var_203_9 - 1 do
					local var_203_10 = var_203_7:GetChild(iter_203_1)

					if var_203_10.name == "split_3" or not string.find(var_203_10.name, "split") then
						var_203_10.gameObject:SetActive(true)
					else
						var_203_10.gameObject:SetActive(false)
					end
				end
			end

			local var_203_11 = 0.001

			if var_203_8 <= arg_200_1.time_ and arg_200_1.time_ < var_203_8 + var_203_11 then
				local var_203_12 = (arg_200_1.time_ - var_203_8) / var_203_11
				local var_203_13 = Vector3.New(0, -2000, 0)

				var_203_7.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10022, var_203_13, var_203_12)
			end

			if arg_200_1.time_ >= var_203_8 + var_203_11 and arg_200_1.time_ < var_203_8 + var_203_11 + arg_203_0 then
				var_203_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_203_14 = 0
			local var_203_15 = 1.2

			if var_203_14 < arg_200_1.time_ and arg_200_1.time_ <= var_203_14 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_16 = arg_200_1:GetWordFromCfg(413021049)
				local var_203_17 = arg_200_1:FormatText(var_203_16.content)

				arg_200_1.text_.text = var_203_17

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_18 = 48
				local var_203_19 = utf8.len(var_203_17)
				local var_203_20 = var_203_18 <= 0 and var_203_15 or var_203_15 * (var_203_19 / var_203_18)

				if var_203_20 > 0 and var_203_15 < var_203_20 then
					arg_200_1.talkMaxDuration = var_203_20

					if var_203_20 + var_203_14 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_20 + var_203_14
					end
				end

				arg_200_1.text_.text = var_203_17
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_21 = math.max(var_203_15, arg_200_1.talkMaxDuration)

			if var_203_14 <= arg_200_1.time_ and arg_200_1.time_ < var_203_14 + var_203_21 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_14) / var_203_21

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_14 + var_203_21 and arg_200_1.time_ < var_203_14 + var_203_21 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play413021050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 413021050
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play413021051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 1.075

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_2 = arg_204_1:GetWordFromCfg(413021050)
				local var_207_3 = arg_204_1:FormatText(var_207_2.content)

				arg_204_1.text_.text = var_207_3

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 43
				local var_207_5 = utf8.len(var_207_3)
				local var_207_6 = var_207_4 <= 0 and var_207_1 or var_207_1 * (var_207_5 / var_207_4)

				if var_207_6 > 0 and var_207_1 < var_207_6 then
					arg_204_1.talkMaxDuration = var_207_6

					if var_207_6 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_6 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_3
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_7 and arg_204_1.time_ < var_207_0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play413021051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 413021051
		arg_208_1.duration_ = 5.23

		local var_208_0 = {
			zh = 5.233,
			ja = 4.566
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play413021052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["10022"].transform
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.var_.moveOldPos10022 = var_211_0.localPosition
				var_211_0.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("10022", 2)

				local var_211_2 = var_211_0.childCount

				for iter_211_0 = 0, var_211_2 - 1 do
					local var_211_3 = var_211_0:GetChild(iter_211_0)

					if var_211_3.name == "split_8" or not string.find(var_211_3.name, "split") then
						var_211_3.gameObject:SetActive(true)
					else
						var_211_3.gameObject:SetActive(false)
					end
				end
			end

			local var_211_4 = 0.001

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_4 then
				local var_211_5 = (arg_208_1.time_ - var_211_1) / var_211_4
				local var_211_6 = Vector3.New(-390, -315, -320)

				var_211_0.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10022, var_211_6, var_211_5)
			end

			if arg_208_1.time_ >= var_211_1 + var_211_4 and arg_208_1.time_ < var_211_1 + var_211_4 + arg_211_0 then
				var_211_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_211_7 = arg_208_1.actors_["10022"]
			local var_211_8 = 0

			if var_211_8 < arg_208_1.time_ and arg_208_1.time_ <= var_211_8 + arg_211_0 and not isNil(var_211_7) and arg_208_1.var_.actorSpriteComps10022 == nil then
				arg_208_1.var_.actorSpriteComps10022 = var_211_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_9 = 2

			if var_211_8 <= arg_208_1.time_ and arg_208_1.time_ < var_211_8 + var_211_9 and not isNil(var_211_7) then
				local var_211_10 = (arg_208_1.time_ - var_211_8) / var_211_9

				if arg_208_1.var_.actorSpriteComps10022 then
					for iter_211_1, iter_211_2 in pairs(arg_208_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_211_2 then
							if arg_208_1.isInRecall_ then
								local var_211_11 = Mathf.Lerp(iter_211_2.color.r, arg_208_1.hightColor1.r, var_211_10)
								local var_211_12 = Mathf.Lerp(iter_211_2.color.g, arg_208_1.hightColor1.g, var_211_10)
								local var_211_13 = Mathf.Lerp(iter_211_2.color.b, arg_208_1.hightColor1.b, var_211_10)

								iter_211_2.color = Color.New(var_211_11, var_211_12, var_211_13)
							else
								local var_211_14 = Mathf.Lerp(iter_211_2.color.r, 1, var_211_10)

								iter_211_2.color = Color.New(var_211_14, var_211_14, var_211_14)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= var_211_8 + var_211_9 and arg_208_1.time_ < var_211_8 + var_211_9 + arg_211_0 and not isNil(var_211_7) and arg_208_1.var_.actorSpriteComps10022 then
				for iter_211_3, iter_211_4 in pairs(arg_208_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_211_4 then
						if arg_208_1.isInRecall_ then
							iter_211_4.color = arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_211_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_208_1.var_.actorSpriteComps10022 = nil
			end

			local var_211_15 = 0
			local var_211_16 = 0.725

			if var_211_15 < arg_208_1.time_ and arg_208_1.time_ <= var_211_15 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_17 = arg_208_1:FormatText(StoryNameCfg[614].name)

				arg_208_1.leftNameTxt_.text = var_211_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_18 = arg_208_1:GetWordFromCfg(413021051)
				local var_211_19 = arg_208_1:FormatText(var_211_18.content)

				arg_208_1.text_.text = var_211_19

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_20 = 29
				local var_211_21 = utf8.len(var_211_19)
				local var_211_22 = var_211_20 <= 0 and var_211_16 or var_211_16 * (var_211_21 / var_211_20)

				if var_211_22 > 0 and var_211_16 < var_211_22 then
					arg_208_1.talkMaxDuration = var_211_22

					if var_211_22 + var_211_15 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_22 + var_211_15
					end
				end

				arg_208_1.text_.text = var_211_19
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021051", "story_v_out_413021.awb") ~= 0 then
					local var_211_23 = manager.audio:GetVoiceLength("story_v_out_413021", "413021051", "story_v_out_413021.awb") / 1000

					if var_211_23 + var_211_15 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_23 + var_211_15
					end

					if var_211_18.prefab_name ~= "" and arg_208_1.actors_[var_211_18.prefab_name] ~= nil then
						local var_211_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_18.prefab_name].transform, "story_v_out_413021", "413021051", "story_v_out_413021.awb")

						arg_208_1:RecordAudio("413021051", var_211_24)
						arg_208_1:RecordAudio("413021051", var_211_24)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_413021", "413021051", "story_v_out_413021.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_413021", "413021051", "story_v_out_413021.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_25 = math.max(var_211_16, arg_208_1.talkMaxDuration)

			if var_211_15 <= arg_208_1.time_ and arg_208_1.time_ < var_211_15 + var_211_25 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_15) / var_211_25

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_15 + var_211_25 and arg_208_1.time_ < var_211_15 + var_211_25 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play413021052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 413021052
		arg_212_1.duration_ = 3.73

		local var_212_0 = {
			zh = 2.066,
			ja = 3.733
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
				arg_212_0:Play413021053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["10094"].transform
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.var_.moveOldPos10094 = var_215_0.localPosition
				var_215_0.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("10094", 4)

				local var_215_2 = var_215_0.childCount

				for iter_215_0 = 0, var_215_2 - 1 do
					local var_215_3 = var_215_0:GetChild(iter_215_0)

					if var_215_3.name == "" or not string.find(var_215_3.name, "split") then
						var_215_3.gameObject:SetActive(true)
					else
						var_215_3.gameObject:SetActive(false)
					end
				end
			end

			local var_215_4 = 0.001

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_4 then
				local var_215_5 = (arg_212_1.time_ - var_215_1) / var_215_4
				local var_215_6 = Vector3.New(390, -340, -414)

				var_215_0.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10094, var_215_6, var_215_5)
			end

			if arg_212_1.time_ >= var_215_1 + var_215_4 and arg_212_1.time_ < var_215_1 + var_215_4 + arg_215_0 then
				var_215_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_215_7 = arg_212_1.actors_["10022"]
			local var_215_8 = 0

			if var_215_8 < arg_212_1.time_ and arg_212_1.time_ <= var_215_8 + arg_215_0 and not isNil(var_215_7) and arg_212_1.var_.actorSpriteComps10022 == nil then
				arg_212_1.var_.actorSpriteComps10022 = var_215_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_9 = 2

			if var_215_8 <= arg_212_1.time_ and arg_212_1.time_ < var_215_8 + var_215_9 and not isNil(var_215_7) then
				local var_215_10 = (arg_212_1.time_ - var_215_8) / var_215_9

				if arg_212_1.var_.actorSpriteComps10022 then
					for iter_215_1, iter_215_2 in pairs(arg_212_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_215_2 then
							if arg_212_1.isInRecall_ then
								local var_215_11 = Mathf.Lerp(iter_215_2.color.r, arg_212_1.hightColor2.r, var_215_10)
								local var_215_12 = Mathf.Lerp(iter_215_2.color.g, arg_212_1.hightColor2.g, var_215_10)
								local var_215_13 = Mathf.Lerp(iter_215_2.color.b, arg_212_1.hightColor2.b, var_215_10)

								iter_215_2.color = Color.New(var_215_11, var_215_12, var_215_13)
							else
								local var_215_14 = Mathf.Lerp(iter_215_2.color.r, 0.5, var_215_10)

								iter_215_2.color = Color.New(var_215_14, var_215_14, var_215_14)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= var_215_8 + var_215_9 and arg_212_1.time_ < var_215_8 + var_215_9 + arg_215_0 and not isNil(var_215_7) and arg_212_1.var_.actorSpriteComps10022 then
				for iter_215_3, iter_215_4 in pairs(arg_212_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_215_4 then
						if arg_212_1.isInRecall_ then
							iter_215_4.color = arg_212_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_215_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_212_1.var_.actorSpriteComps10022 = nil
			end

			local var_215_15 = arg_212_1.actors_["10094"]
			local var_215_16 = 0

			if var_215_16 < arg_212_1.time_ and arg_212_1.time_ <= var_215_16 + arg_215_0 and not isNil(var_215_15) and arg_212_1.var_.actorSpriteComps10094 == nil then
				arg_212_1.var_.actorSpriteComps10094 = var_215_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_17 = 2

			if var_215_16 <= arg_212_1.time_ and arg_212_1.time_ < var_215_16 + var_215_17 and not isNil(var_215_15) then
				local var_215_18 = (arg_212_1.time_ - var_215_16) / var_215_17

				if arg_212_1.var_.actorSpriteComps10094 then
					for iter_215_5, iter_215_6 in pairs(arg_212_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_215_6 then
							if arg_212_1.isInRecall_ then
								local var_215_19 = Mathf.Lerp(iter_215_6.color.r, arg_212_1.hightColor1.r, var_215_18)
								local var_215_20 = Mathf.Lerp(iter_215_6.color.g, arg_212_1.hightColor1.g, var_215_18)
								local var_215_21 = Mathf.Lerp(iter_215_6.color.b, arg_212_1.hightColor1.b, var_215_18)

								iter_215_6.color = Color.New(var_215_19, var_215_20, var_215_21)
							else
								local var_215_22 = Mathf.Lerp(iter_215_6.color.r, 1, var_215_18)

								iter_215_6.color = Color.New(var_215_22, var_215_22, var_215_22)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= var_215_16 + var_215_17 and arg_212_1.time_ < var_215_16 + var_215_17 + arg_215_0 and not isNil(var_215_15) and arg_212_1.var_.actorSpriteComps10094 then
				for iter_215_7, iter_215_8 in pairs(arg_212_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_215_8 then
						if arg_212_1.isInRecall_ then
							iter_215_8.color = arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_215_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_212_1.var_.actorSpriteComps10094 = nil
			end

			local var_215_23 = 0
			local var_215_24 = 0.275

			if var_215_23 < arg_212_1.time_ and arg_212_1.time_ <= var_215_23 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_25 = arg_212_1:FormatText(StoryNameCfg[259].name)

				arg_212_1.leftNameTxt_.text = var_215_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_26 = arg_212_1:GetWordFromCfg(413021052)
				local var_215_27 = arg_212_1:FormatText(var_215_26.content)

				arg_212_1.text_.text = var_215_27

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_28 = 11
				local var_215_29 = utf8.len(var_215_27)
				local var_215_30 = var_215_28 <= 0 and var_215_24 or var_215_24 * (var_215_29 / var_215_28)

				if var_215_30 > 0 and var_215_24 < var_215_30 then
					arg_212_1.talkMaxDuration = var_215_30

					if var_215_30 + var_215_23 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_30 + var_215_23
					end
				end

				arg_212_1.text_.text = var_215_27
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021052", "story_v_out_413021.awb") ~= 0 then
					local var_215_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021052", "story_v_out_413021.awb") / 1000

					if var_215_31 + var_215_23 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_31 + var_215_23
					end

					if var_215_26.prefab_name ~= "" and arg_212_1.actors_[var_215_26.prefab_name] ~= nil then
						local var_215_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_26.prefab_name].transform, "story_v_out_413021", "413021052", "story_v_out_413021.awb")

						arg_212_1:RecordAudio("413021052", var_215_32)
						arg_212_1:RecordAudio("413021052", var_215_32)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_413021", "413021052", "story_v_out_413021.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_413021", "413021052", "story_v_out_413021.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_33 = math.max(var_215_24, arg_212_1.talkMaxDuration)

			if var_215_23 <= arg_212_1.time_ and arg_212_1.time_ < var_215_23 + var_215_33 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_23) / var_215_33

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_23 + var_215_33 and arg_212_1.time_ < var_215_23 + var_215_33 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play413021053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 413021053
		arg_216_1.duration_ = 10.13

		local var_216_0 = {
			zh = 6,
			ja = 10.133
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play413021054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["10022"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos10022 = var_219_0.localPosition
				var_219_0.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("10022", 2)

				local var_219_2 = var_219_0.childCount

				for iter_219_0 = 0, var_219_2 - 1 do
					local var_219_3 = var_219_0:GetChild(iter_219_0)

					if var_219_3.name == "split_6" or not string.find(var_219_3.name, "split") then
						var_219_3.gameObject:SetActive(true)
					else
						var_219_3.gameObject:SetActive(false)
					end
				end
			end

			local var_219_4 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_4 then
				local var_219_5 = (arg_216_1.time_ - var_219_1) / var_219_4
				local var_219_6 = Vector3.New(-390, -315, -320)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10022, var_219_6, var_219_5)
			end

			if arg_216_1.time_ >= var_219_1 + var_219_4 and arg_216_1.time_ < var_219_1 + var_219_4 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_219_7 = arg_216_1.actors_["10022"]
			local var_219_8 = 0

			if var_219_8 < arg_216_1.time_ and arg_216_1.time_ <= var_219_8 + arg_219_0 and not isNil(var_219_7) and arg_216_1.var_.actorSpriteComps10022 == nil then
				arg_216_1.var_.actorSpriteComps10022 = var_219_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_9 = 2

			if var_219_8 <= arg_216_1.time_ and arg_216_1.time_ < var_219_8 + var_219_9 and not isNil(var_219_7) then
				local var_219_10 = (arg_216_1.time_ - var_219_8) / var_219_9

				if arg_216_1.var_.actorSpriteComps10022 then
					for iter_219_1, iter_219_2 in pairs(arg_216_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_219_2 then
							if arg_216_1.isInRecall_ then
								local var_219_11 = Mathf.Lerp(iter_219_2.color.r, arg_216_1.hightColor1.r, var_219_10)
								local var_219_12 = Mathf.Lerp(iter_219_2.color.g, arg_216_1.hightColor1.g, var_219_10)
								local var_219_13 = Mathf.Lerp(iter_219_2.color.b, arg_216_1.hightColor1.b, var_219_10)

								iter_219_2.color = Color.New(var_219_11, var_219_12, var_219_13)
							else
								local var_219_14 = Mathf.Lerp(iter_219_2.color.r, 1, var_219_10)

								iter_219_2.color = Color.New(var_219_14, var_219_14, var_219_14)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= var_219_8 + var_219_9 and arg_216_1.time_ < var_219_8 + var_219_9 + arg_219_0 and not isNil(var_219_7) and arg_216_1.var_.actorSpriteComps10022 then
				for iter_219_3, iter_219_4 in pairs(arg_216_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_219_4 then
						if arg_216_1.isInRecall_ then
							iter_219_4.color = arg_216_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_219_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_216_1.var_.actorSpriteComps10022 = nil
			end

			local var_219_15 = arg_216_1.actors_["10094"]
			local var_219_16 = 0

			if var_219_16 < arg_216_1.time_ and arg_216_1.time_ <= var_219_16 + arg_219_0 and not isNil(var_219_15) and arg_216_1.var_.actorSpriteComps10094 == nil then
				arg_216_1.var_.actorSpriteComps10094 = var_219_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_17 = 2

			if var_219_16 <= arg_216_1.time_ and arg_216_1.time_ < var_219_16 + var_219_17 and not isNil(var_219_15) then
				local var_219_18 = (arg_216_1.time_ - var_219_16) / var_219_17

				if arg_216_1.var_.actorSpriteComps10094 then
					for iter_219_5, iter_219_6 in pairs(arg_216_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_219_6 then
							if arg_216_1.isInRecall_ then
								local var_219_19 = Mathf.Lerp(iter_219_6.color.r, arg_216_1.hightColor2.r, var_219_18)
								local var_219_20 = Mathf.Lerp(iter_219_6.color.g, arg_216_1.hightColor2.g, var_219_18)
								local var_219_21 = Mathf.Lerp(iter_219_6.color.b, arg_216_1.hightColor2.b, var_219_18)

								iter_219_6.color = Color.New(var_219_19, var_219_20, var_219_21)
							else
								local var_219_22 = Mathf.Lerp(iter_219_6.color.r, 0.5, var_219_18)

								iter_219_6.color = Color.New(var_219_22, var_219_22, var_219_22)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= var_219_16 + var_219_17 and arg_216_1.time_ < var_219_16 + var_219_17 + arg_219_0 and not isNil(var_219_15) and arg_216_1.var_.actorSpriteComps10094 then
				for iter_219_7, iter_219_8 in pairs(arg_216_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_219_8 then
						if arg_216_1.isInRecall_ then
							iter_219_8.color = arg_216_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_219_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_216_1.var_.actorSpriteComps10094 = nil
			end

			local var_219_23 = 0
			local var_219_24 = 0.75

			if var_219_23 < arg_216_1.time_ and arg_216_1.time_ <= var_219_23 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_25 = arg_216_1:FormatText(StoryNameCfg[614].name)

				arg_216_1.leftNameTxt_.text = var_219_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_26 = arg_216_1:GetWordFromCfg(413021053)
				local var_219_27 = arg_216_1:FormatText(var_219_26.content)

				arg_216_1.text_.text = var_219_27

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_28 = 30
				local var_219_29 = utf8.len(var_219_27)
				local var_219_30 = var_219_28 <= 0 and var_219_24 or var_219_24 * (var_219_29 / var_219_28)

				if var_219_30 > 0 and var_219_24 < var_219_30 then
					arg_216_1.talkMaxDuration = var_219_30

					if var_219_30 + var_219_23 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_30 + var_219_23
					end
				end

				arg_216_1.text_.text = var_219_27
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021053", "story_v_out_413021.awb") ~= 0 then
					local var_219_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021053", "story_v_out_413021.awb") / 1000

					if var_219_31 + var_219_23 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_31 + var_219_23
					end

					if var_219_26.prefab_name ~= "" and arg_216_1.actors_[var_219_26.prefab_name] ~= nil then
						local var_219_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_26.prefab_name].transform, "story_v_out_413021", "413021053", "story_v_out_413021.awb")

						arg_216_1:RecordAudio("413021053", var_219_32)
						arg_216_1:RecordAudio("413021053", var_219_32)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_413021", "413021053", "story_v_out_413021.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_413021", "413021053", "story_v_out_413021.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_33 = math.max(var_219_24, arg_216_1.talkMaxDuration)

			if var_219_23 <= arg_216_1.time_ and arg_216_1.time_ < var_219_23 + var_219_33 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_23) / var_219_33

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_23 + var_219_33 and arg_216_1.time_ < var_219_23 + var_219_33 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play413021054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 413021054
		arg_220_1.duration_ = 4.37

		local var_220_0 = {
			zh = 4.366,
			ja = 3.1
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
				arg_220_0:Play413021055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["10094"].transform
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.var_.moveOldPos10094 = var_223_0.localPosition
				var_223_0.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("10094", 4)

				local var_223_2 = var_223_0.childCount

				for iter_223_0 = 0, var_223_2 - 1 do
					local var_223_3 = var_223_0:GetChild(iter_223_0)

					if var_223_3.name == "" or not string.find(var_223_3.name, "split") then
						var_223_3.gameObject:SetActive(true)
					else
						var_223_3.gameObject:SetActive(false)
					end
				end
			end

			local var_223_4 = 0.001

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_4 then
				local var_223_5 = (arg_220_1.time_ - var_223_1) / var_223_4
				local var_223_6 = Vector3.New(390, -340, -414)

				var_223_0.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10094, var_223_6, var_223_5)
			end

			if arg_220_1.time_ >= var_223_1 + var_223_4 and arg_220_1.time_ < var_223_1 + var_223_4 + arg_223_0 then
				var_223_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_223_7 = arg_220_1.actors_["10022"]
			local var_223_8 = 0

			if var_223_8 < arg_220_1.time_ and arg_220_1.time_ <= var_223_8 + arg_223_0 and not isNil(var_223_7) and arg_220_1.var_.actorSpriteComps10022 == nil then
				arg_220_1.var_.actorSpriteComps10022 = var_223_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_9 = 2

			if var_223_8 <= arg_220_1.time_ and arg_220_1.time_ < var_223_8 + var_223_9 and not isNil(var_223_7) then
				local var_223_10 = (arg_220_1.time_ - var_223_8) / var_223_9

				if arg_220_1.var_.actorSpriteComps10022 then
					for iter_223_1, iter_223_2 in pairs(arg_220_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_223_2 then
							if arg_220_1.isInRecall_ then
								local var_223_11 = Mathf.Lerp(iter_223_2.color.r, arg_220_1.hightColor2.r, var_223_10)
								local var_223_12 = Mathf.Lerp(iter_223_2.color.g, arg_220_1.hightColor2.g, var_223_10)
								local var_223_13 = Mathf.Lerp(iter_223_2.color.b, arg_220_1.hightColor2.b, var_223_10)

								iter_223_2.color = Color.New(var_223_11, var_223_12, var_223_13)
							else
								local var_223_14 = Mathf.Lerp(iter_223_2.color.r, 0.5, var_223_10)

								iter_223_2.color = Color.New(var_223_14, var_223_14, var_223_14)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= var_223_8 + var_223_9 and arg_220_1.time_ < var_223_8 + var_223_9 + arg_223_0 and not isNil(var_223_7) and arg_220_1.var_.actorSpriteComps10022 then
				for iter_223_3, iter_223_4 in pairs(arg_220_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_223_4 then
						if arg_220_1.isInRecall_ then
							iter_223_4.color = arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_223_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_220_1.var_.actorSpriteComps10022 = nil
			end

			local var_223_15 = arg_220_1.actors_["10094"]
			local var_223_16 = 0

			if var_223_16 < arg_220_1.time_ and arg_220_1.time_ <= var_223_16 + arg_223_0 and not isNil(var_223_15) and arg_220_1.var_.actorSpriteComps10094 == nil then
				arg_220_1.var_.actorSpriteComps10094 = var_223_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_17 = 2

			if var_223_16 <= arg_220_1.time_ and arg_220_1.time_ < var_223_16 + var_223_17 and not isNil(var_223_15) then
				local var_223_18 = (arg_220_1.time_ - var_223_16) / var_223_17

				if arg_220_1.var_.actorSpriteComps10094 then
					for iter_223_5, iter_223_6 in pairs(arg_220_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_223_6 then
							if arg_220_1.isInRecall_ then
								local var_223_19 = Mathf.Lerp(iter_223_6.color.r, arg_220_1.hightColor1.r, var_223_18)
								local var_223_20 = Mathf.Lerp(iter_223_6.color.g, arg_220_1.hightColor1.g, var_223_18)
								local var_223_21 = Mathf.Lerp(iter_223_6.color.b, arg_220_1.hightColor1.b, var_223_18)

								iter_223_6.color = Color.New(var_223_19, var_223_20, var_223_21)
							else
								local var_223_22 = Mathf.Lerp(iter_223_6.color.r, 1, var_223_18)

								iter_223_6.color = Color.New(var_223_22, var_223_22, var_223_22)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= var_223_16 + var_223_17 and arg_220_1.time_ < var_223_16 + var_223_17 + arg_223_0 and not isNil(var_223_15) and arg_220_1.var_.actorSpriteComps10094 then
				for iter_223_7, iter_223_8 in pairs(arg_220_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_223_8 then
						if arg_220_1.isInRecall_ then
							iter_223_8.color = arg_220_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_223_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_220_1.var_.actorSpriteComps10094 = nil
			end

			local var_223_23 = 0
			local var_223_24 = 0.525

			if var_223_23 < arg_220_1.time_ and arg_220_1.time_ <= var_223_23 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_25 = arg_220_1:FormatText(StoryNameCfg[259].name)

				arg_220_1.leftNameTxt_.text = var_223_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_26 = arg_220_1:GetWordFromCfg(413021054)
				local var_223_27 = arg_220_1:FormatText(var_223_26.content)

				arg_220_1.text_.text = var_223_27

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_28 = 21
				local var_223_29 = utf8.len(var_223_27)
				local var_223_30 = var_223_28 <= 0 and var_223_24 or var_223_24 * (var_223_29 / var_223_28)

				if var_223_30 > 0 and var_223_24 < var_223_30 then
					arg_220_1.talkMaxDuration = var_223_30

					if var_223_30 + var_223_23 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_30 + var_223_23
					end
				end

				arg_220_1.text_.text = var_223_27
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021054", "story_v_out_413021.awb") ~= 0 then
					local var_223_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021054", "story_v_out_413021.awb") / 1000

					if var_223_31 + var_223_23 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_31 + var_223_23
					end

					if var_223_26.prefab_name ~= "" and arg_220_1.actors_[var_223_26.prefab_name] ~= nil then
						local var_223_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_26.prefab_name].transform, "story_v_out_413021", "413021054", "story_v_out_413021.awb")

						arg_220_1:RecordAudio("413021054", var_223_32)
						arg_220_1:RecordAudio("413021054", var_223_32)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_413021", "413021054", "story_v_out_413021.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_413021", "413021054", "story_v_out_413021.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_33 = math.max(var_223_24, arg_220_1.talkMaxDuration)

			if var_223_23 <= arg_220_1.time_ and arg_220_1.time_ < var_223_23 + var_223_33 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_23) / var_223_33

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_23 + var_223_33 and arg_220_1.time_ < var_223_23 + var_223_33 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play413021055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 413021055
		arg_224_1.duration_ = 5.47

		local var_224_0 = {
			zh = 2.166,
			ja = 5.466
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play413021056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["10094"].transform
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.var_.moveOldPos10094 = var_227_0.localPosition
				var_227_0.localScale = Vector3.New(1, 1, 1)

				arg_224_1:CheckSpriteTmpPos("10094", 4)

				local var_227_2 = var_227_0.childCount

				for iter_227_0 = 0, var_227_2 - 1 do
					local var_227_3 = var_227_0:GetChild(iter_227_0)

					if var_227_3.name == "" or not string.find(var_227_3.name, "split") then
						var_227_3.gameObject:SetActive(true)
					else
						var_227_3.gameObject:SetActive(false)
					end
				end
			end

			local var_227_4 = 0.001

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_4 then
				local var_227_5 = (arg_224_1.time_ - var_227_1) / var_227_4
				local var_227_6 = Vector3.New(390, -340, -414)

				var_227_0.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10094, var_227_6, var_227_5)
			end

			if arg_224_1.time_ >= var_227_1 + var_227_4 and arg_224_1.time_ < var_227_1 + var_227_4 + arg_227_0 then
				var_227_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_227_7 = arg_224_1.actors_["10022"]
			local var_227_8 = 0

			if var_227_8 < arg_224_1.time_ and arg_224_1.time_ <= var_227_8 + arg_227_0 and not isNil(var_227_7) and arg_224_1.var_.actorSpriteComps10022 == nil then
				arg_224_1.var_.actorSpriteComps10022 = var_227_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_9 = 2

			if var_227_8 <= arg_224_1.time_ and arg_224_1.time_ < var_227_8 + var_227_9 and not isNil(var_227_7) then
				local var_227_10 = (arg_224_1.time_ - var_227_8) / var_227_9

				if arg_224_1.var_.actorSpriteComps10022 then
					for iter_227_1, iter_227_2 in pairs(arg_224_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_227_2 then
							if arg_224_1.isInRecall_ then
								local var_227_11 = Mathf.Lerp(iter_227_2.color.r, arg_224_1.hightColor1.r, var_227_10)
								local var_227_12 = Mathf.Lerp(iter_227_2.color.g, arg_224_1.hightColor1.g, var_227_10)
								local var_227_13 = Mathf.Lerp(iter_227_2.color.b, arg_224_1.hightColor1.b, var_227_10)

								iter_227_2.color = Color.New(var_227_11, var_227_12, var_227_13)
							else
								local var_227_14 = Mathf.Lerp(iter_227_2.color.r, 1, var_227_10)

								iter_227_2.color = Color.New(var_227_14, var_227_14, var_227_14)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= var_227_8 + var_227_9 and arg_224_1.time_ < var_227_8 + var_227_9 + arg_227_0 and not isNil(var_227_7) and arg_224_1.var_.actorSpriteComps10022 then
				for iter_227_3, iter_227_4 in pairs(arg_224_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_227_4 then
						if arg_224_1.isInRecall_ then
							iter_227_4.color = arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_227_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_224_1.var_.actorSpriteComps10022 = nil
			end

			local var_227_15 = arg_224_1.actors_["10094"]
			local var_227_16 = 0

			if var_227_16 < arg_224_1.time_ and arg_224_1.time_ <= var_227_16 + arg_227_0 and not isNil(var_227_15) and arg_224_1.var_.actorSpriteComps10094 == nil then
				arg_224_1.var_.actorSpriteComps10094 = var_227_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_17 = 2

			if var_227_16 <= arg_224_1.time_ and arg_224_1.time_ < var_227_16 + var_227_17 and not isNil(var_227_15) then
				local var_227_18 = (arg_224_1.time_ - var_227_16) / var_227_17

				if arg_224_1.var_.actorSpriteComps10094 then
					for iter_227_5, iter_227_6 in pairs(arg_224_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_227_6 then
							if arg_224_1.isInRecall_ then
								local var_227_19 = Mathf.Lerp(iter_227_6.color.r, arg_224_1.hightColor2.r, var_227_18)
								local var_227_20 = Mathf.Lerp(iter_227_6.color.g, arg_224_1.hightColor2.g, var_227_18)
								local var_227_21 = Mathf.Lerp(iter_227_6.color.b, arg_224_1.hightColor2.b, var_227_18)

								iter_227_6.color = Color.New(var_227_19, var_227_20, var_227_21)
							else
								local var_227_22 = Mathf.Lerp(iter_227_6.color.r, 0.5, var_227_18)

								iter_227_6.color = Color.New(var_227_22, var_227_22, var_227_22)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= var_227_16 + var_227_17 and arg_224_1.time_ < var_227_16 + var_227_17 + arg_227_0 and not isNil(var_227_15) and arg_224_1.var_.actorSpriteComps10094 then
				for iter_227_7, iter_227_8 in pairs(arg_224_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_227_8 then
						if arg_224_1.isInRecall_ then
							iter_227_8.color = arg_224_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_227_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_224_1.var_.actorSpriteComps10094 = nil
			end

			local var_227_23 = 0
			local var_227_24 = 0.3

			if var_227_23 < arg_224_1.time_ and arg_224_1.time_ <= var_227_23 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_25 = arg_224_1:FormatText(StoryNameCfg[614].name)

				arg_224_1.leftNameTxt_.text = var_227_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_26 = arg_224_1:GetWordFromCfg(413021055)
				local var_227_27 = arg_224_1:FormatText(var_227_26.content)

				arg_224_1.text_.text = var_227_27

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_28 = 12
				local var_227_29 = utf8.len(var_227_27)
				local var_227_30 = var_227_28 <= 0 and var_227_24 or var_227_24 * (var_227_29 / var_227_28)

				if var_227_30 > 0 and var_227_24 < var_227_30 then
					arg_224_1.talkMaxDuration = var_227_30

					if var_227_30 + var_227_23 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_30 + var_227_23
					end
				end

				arg_224_1.text_.text = var_227_27
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021055", "story_v_out_413021.awb") ~= 0 then
					local var_227_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021055", "story_v_out_413021.awb") / 1000

					if var_227_31 + var_227_23 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_31 + var_227_23
					end

					if var_227_26.prefab_name ~= "" and arg_224_1.actors_[var_227_26.prefab_name] ~= nil then
						local var_227_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_26.prefab_name].transform, "story_v_out_413021", "413021055", "story_v_out_413021.awb")

						arg_224_1:RecordAudio("413021055", var_227_32)
						arg_224_1:RecordAudio("413021055", var_227_32)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_413021", "413021055", "story_v_out_413021.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_413021", "413021055", "story_v_out_413021.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_33 = math.max(var_227_24, arg_224_1.talkMaxDuration)

			if var_227_23 <= arg_224_1.time_ and arg_224_1.time_ < var_227_23 + var_227_33 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_23) / var_227_33

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_23 + var_227_33 and arg_224_1.time_ < var_227_23 + var_227_33 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play413021056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 413021056
		arg_228_1.duration_ = 4.8

		local var_228_0 = {
			zh = 3.7,
			ja = 4.8
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
				arg_228_0:Play413021057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["10094"].transform
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.var_.moveOldPos10094 = var_231_0.localPosition
				var_231_0.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10094", 4)

				local var_231_2 = var_231_0.childCount

				for iter_231_0 = 0, var_231_2 - 1 do
					local var_231_3 = var_231_0:GetChild(iter_231_0)

					if var_231_3.name == "" or not string.find(var_231_3.name, "split") then
						var_231_3.gameObject:SetActive(true)
					else
						var_231_3.gameObject:SetActive(false)
					end
				end
			end

			local var_231_4 = 0.001

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_4 then
				local var_231_5 = (arg_228_1.time_ - var_231_1) / var_231_4
				local var_231_6 = Vector3.New(390, -340, -414)

				var_231_0.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10094, var_231_6, var_231_5)
			end

			if arg_228_1.time_ >= var_231_1 + var_231_4 and arg_228_1.time_ < var_231_1 + var_231_4 + arg_231_0 then
				var_231_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_231_7 = arg_228_1.actors_["10022"]
			local var_231_8 = 0

			if var_231_8 < arg_228_1.time_ and arg_228_1.time_ <= var_231_8 + arg_231_0 and not isNil(var_231_7) and arg_228_1.var_.actorSpriteComps10022 == nil then
				arg_228_1.var_.actorSpriteComps10022 = var_231_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_9 = 2

			if var_231_8 <= arg_228_1.time_ and arg_228_1.time_ < var_231_8 + var_231_9 and not isNil(var_231_7) then
				local var_231_10 = (arg_228_1.time_ - var_231_8) / var_231_9

				if arg_228_1.var_.actorSpriteComps10022 then
					for iter_231_1, iter_231_2 in pairs(arg_228_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_231_2 then
							if arg_228_1.isInRecall_ then
								local var_231_11 = Mathf.Lerp(iter_231_2.color.r, arg_228_1.hightColor2.r, var_231_10)
								local var_231_12 = Mathf.Lerp(iter_231_2.color.g, arg_228_1.hightColor2.g, var_231_10)
								local var_231_13 = Mathf.Lerp(iter_231_2.color.b, arg_228_1.hightColor2.b, var_231_10)

								iter_231_2.color = Color.New(var_231_11, var_231_12, var_231_13)
							else
								local var_231_14 = Mathf.Lerp(iter_231_2.color.r, 0.5, var_231_10)

								iter_231_2.color = Color.New(var_231_14, var_231_14, var_231_14)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_8 + var_231_9 and arg_228_1.time_ < var_231_8 + var_231_9 + arg_231_0 and not isNil(var_231_7) and arg_228_1.var_.actorSpriteComps10022 then
				for iter_231_3, iter_231_4 in pairs(arg_228_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_231_4 then
						if arg_228_1.isInRecall_ then
							iter_231_4.color = arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_231_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps10022 = nil
			end

			local var_231_15 = arg_228_1.actors_["10094"]
			local var_231_16 = 0

			if var_231_16 < arg_228_1.time_ and arg_228_1.time_ <= var_231_16 + arg_231_0 and not isNil(var_231_15) and arg_228_1.var_.actorSpriteComps10094 == nil then
				arg_228_1.var_.actorSpriteComps10094 = var_231_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_17 = 2

			if var_231_16 <= arg_228_1.time_ and arg_228_1.time_ < var_231_16 + var_231_17 and not isNil(var_231_15) then
				local var_231_18 = (arg_228_1.time_ - var_231_16) / var_231_17

				if arg_228_1.var_.actorSpriteComps10094 then
					for iter_231_5, iter_231_6 in pairs(arg_228_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_231_6 then
							if arg_228_1.isInRecall_ then
								local var_231_19 = Mathf.Lerp(iter_231_6.color.r, arg_228_1.hightColor1.r, var_231_18)
								local var_231_20 = Mathf.Lerp(iter_231_6.color.g, arg_228_1.hightColor1.g, var_231_18)
								local var_231_21 = Mathf.Lerp(iter_231_6.color.b, arg_228_1.hightColor1.b, var_231_18)

								iter_231_6.color = Color.New(var_231_19, var_231_20, var_231_21)
							else
								local var_231_22 = Mathf.Lerp(iter_231_6.color.r, 1, var_231_18)

								iter_231_6.color = Color.New(var_231_22, var_231_22, var_231_22)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_16 + var_231_17 and arg_228_1.time_ < var_231_16 + var_231_17 + arg_231_0 and not isNil(var_231_15) and arg_228_1.var_.actorSpriteComps10094 then
				for iter_231_7, iter_231_8 in pairs(arg_228_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_231_8 then
						if arg_228_1.isInRecall_ then
							iter_231_8.color = arg_228_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_231_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps10094 = nil
			end

			local var_231_23 = 0
			local var_231_24 = 0.225

			if var_231_23 < arg_228_1.time_ and arg_228_1.time_ <= var_231_23 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_25 = arg_228_1:FormatText(StoryNameCfg[259].name)

				arg_228_1.leftNameTxt_.text = var_231_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_26 = arg_228_1:GetWordFromCfg(413021056)
				local var_231_27 = arg_228_1:FormatText(var_231_26.content)

				arg_228_1.text_.text = var_231_27

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_28 = 9
				local var_231_29 = utf8.len(var_231_27)
				local var_231_30 = var_231_28 <= 0 and var_231_24 or var_231_24 * (var_231_29 / var_231_28)

				if var_231_30 > 0 and var_231_24 < var_231_30 then
					arg_228_1.talkMaxDuration = var_231_30

					if var_231_30 + var_231_23 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_30 + var_231_23
					end
				end

				arg_228_1.text_.text = var_231_27
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021056", "story_v_out_413021.awb") ~= 0 then
					local var_231_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021056", "story_v_out_413021.awb") / 1000

					if var_231_31 + var_231_23 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_31 + var_231_23
					end

					if var_231_26.prefab_name ~= "" and arg_228_1.actors_[var_231_26.prefab_name] ~= nil then
						local var_231_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_26.prefab_name].transform, "story_v_out_413021", "413021056", "story_v_out_413021.awb")

						arg_228_1:RecordAudio("413021056", var_231_32)
						arg_228_1:RecordAudio("413021056", var_231_32)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_413021", "413021056", "story_v_out_413021.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_413021", "413021056", "story_v_out_413021.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_33 = math.max(var_231_24, arg_228_1.talkMaxDuration)

			if var_231_23 <= arg_228_1.time_ and arg_228_1.time_ < var_231_23 + var_231_33 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_23) / var_231_33

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_23 + var_231_33 and arg_228_1.time_ < var_231_23 + var_231_33 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play413021057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 413021057
		arg_232_1.duration_ = 3.57

		local var_232_0 = {
			zh = 1.999999999999,
			ja = 3.566
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play413021058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["10022"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos10022 = var_235_0.localPosition
				var_235_0.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10022", 2)

				local var_235_2 = var_235_0.childCount

				for iter_235_0 = 0, var_235_2 - 1 do
					local var_235_3 = var_235_0:GetChild(iter_235_0)

					if var_235_3.name == "split_3" or not string.find(var_235_3.name, "split") then
						var_235_3.gameObject:SetActive(true)
					else
						var_235_3.gameObject:SetActive(false)
					end
				end
			end

			local var_235_4 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_4 then
				local var_235_5 = (arg_232_1.time_ - var_235_1) / var_235_4
				local var_235_6 = Vector3.New(-390, -315, -320)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10022, var_235_6, var_235_5)
			end

			if arg_232_1.time_ >= var_235_1 + var_235_4 and arg_232_1.time_ < var_235_1 + var_235_4 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_235_7 = arg_232_1.actors_["10094"].transform
			local var_235_8 = 0

			if var_235_8 < arg_232_1.time_ and arg_232_1.time_ <= var_235_8 + arg_235_0 then
				arg_232_1.var_.moveOldPos10094 = var_235_7.localPosition
				var_235_7.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10094", 4)

				local var_235_9 = var_235_7.childCount

				for iter_235_1 = 0, var_235_9 - 1 do
					local var_235_10 = var_235_7:GetChild(iter_235_1)

					if var_235_10.name == "" or not string.find(var_235_10.name, "split") then
						var_235_10.gameObject:SetActive(true)
					else
						var_235_10.gameObject:SetActive(false)
					end
				end
			end

			local var_235_11 = 0.001

			if var_235_8 <= arg_232_1.time_ and arg_232_1.time_ < var_235_8 + var_235_11 then
				local var_235_12 = (arg_232_1.time_ - var_235_8) / var_235_11
				local var_235_13 = Vector3.New(390, -340, -414)

				var_235_7.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10094, var_235_13, var_235_12)
			end

			if arg_232_1.time_ >= var_235_8 + var_235_11 and arg_232_1.time_ < var_235_8 + var_235_11 + arg_235_0 then
				var_235_7.localPosition = Vector3.New(390, -340, -414)
			end

			local var_235_14 = arg_232_1.actors_["10022"]
			local var_235_15 = 0

			if var_235_15 < arg_232_1.time_ and arg_232_1.time_ <= var_235_15 + arg_235_0 and not isNil(var_235_14) and arg_232_1.var_.actorSpriteComps10022 == nil then
				arg_232_1.var_.actorSpriteComps10022 = var_235_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_16 = 2

			if var_235_15 <= arg_232_1.time_ and arg_232_1.time_ < var_235_15 + var_235_16 and not isNil(var_235_14) then
				local var_235_17 = (arg_232_1.time_ - var_235_15) / var_235_16

				if arg_232_1.var_.actorSpriteComps10022 then
					for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_235_3 then
							if arg_232_1.isInRecall_ then
								local var_235_18 = Mathf.Lerp(iter_235_3.color.r, arg_232_1.hightColor1.r, var_235_17)
								local var_235_19 = Mathf.Lerp(iter_235_3.color.g, arg_232_1.hightColor1.g, var_235_17)
								local var_235_20 = Mathf.Lerp(iter_235_3.color.b, arg_232_1.hightColor1.b, var_235_17)

								iter_235_3.color = Color.New(var_235_18, var_235_19, var_235_20)
							else
								local var_235_21 = Mathf.Lerp(iter_235_3.color.r, 1, var_235_17)

								iter_235_3.color = Color.New(var_235_21, var_235_21, var_235_21)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= var_235_15 + var_235_16 and arg_232_1.time_ < var_235_15 + var_235_16 + arg_235_0 and not isNil(var_235_14) and arg_232_1.var_.actorSpriteComps10022 then
				for iter_235_4, iter_235_5 in pairs(arg_232_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_235_5 then
						if arg_232_1.isInRecall_ then
							iter_235_5.color = arg_232_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_235_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_232_1.var_.actorSpriteComps10022 = nil
			end

			local var_235_22 = arg_232_1.actors_["10094"]
			local var_235_23 = 0

			if var_235_23 < arg_232_1.time_ and arg_232_1.time_ <= var_235_23 + arg_235_0 and not isNil(var_235_22) and arg_232_1.var_.actorSpriteComps10094 == nil then
				arg_232_1.var_.actorSpriteComps10094 = var_235_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_24 = 2

			if var_235_23 <= arg_232_1.time_ and arg_232_1.time_ < var_235_23 + var_235_24 and not isNil(var_235_22) then
				local var_235_25 = (arg_232_1.time_ - var_235_23) / var_235_24

				if arg_232_1.var_.actorSpriteComps10094 then
					for iter_235_6, iter_235_7 in pairs(arg_232_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_235_7 then
							if arg_232_1.isInRecall_ then
								local var_235_26 = Mathf.Lerp(iter_235_7.color.r, arg_232_1.hightColor2.r, var_235_25)
								local var_235_27 = Mathf.Lerp(iter_235_7.color.g, arg_232_1.hightColor2.g, var_235_25)
								local var_235_28 = Mathf.Lerp(iter_235_7.color.b, arg_232_1.hightColor2.b, var_235_25)

								iter_235_7.color = Color.New(var_235_26, var_235_27, var_235_28)
							else
								local var_235_29 = Mathf.Lerp(iter_235_7.color.r, 0.5, var_235_25)

								iter_235_7.color = Color.New(var_235_29, var_235_29, var_235_29)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= var_235_23 + var_235_24 and arg_232_1.time_ < var_235_23 + var_235_24 + arg_235_0 and not isNil(var_235_22) and arg_232_1.var_.actorSpriteComps10094 then
				for iter_235_8, iter_235_9 in pairs(arg_232_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_235_9 then
						if arg_232_1.isInRecall_ then
							iter_235_9.color = arg_232_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_235_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_232_1.var_.actorSpriteComps10094 = nil
			end

			local var_235_30 = 0
			local var_235_31 = 0.25

			if var_235_30 < arg_232_1.time_ and arg_232_1.time_ <= var_235_30 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_32 = arg_232_1:FormatText(StoryNameCfg[614].name)

				arg_232_1.leftNameTxt_.text = var_235_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_33 = arg_232_1:GetWordFromCfg(413021057)
				local var_235_34 = arg_232_1:FormatText(var_235_33.content)

				arg_232_1.text_.text = var_235_34

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_35 = 10
				local var_235_36 = utf8.len(var_235_34)
				local var_235_37 = var_235_35 <= 0 and var_235_31 or var_235_31 * (var_235_36 / var_235_35)

				if var_235_37 > 0 and var_235_31 < var_235_37 then
					arg_232_1.talkMaxDuration = var_235_37

					if var_235_37 + var_235_30 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_37 + var_235_30
					end
				end

				arg_232_1.text_.text = var_235_34
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021057", "story_v_out_413021.awb") ~= 0 then
					local var_235_38 = manager.audio:GetVoiceLength("story_v_out_413021", "413021057", "story_v_out_413021.awb") / 1000

					if var_235_38 + var_235_30 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_38 + var_235_30
					end

					if var_235_33.prefab_name ~= "" and arg_232_1.actors_[var_235_33.prefab_name] ~= nil then
						local var_235_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_33.prefab_name].transform, "story_v_out_413021", "413021057", "story_v_out_413021.awb")

						arg_232_1:RecordAudio("413021057", var_235_39)
						arg_232_1:RecordAudio("413021057", var_235_39)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_413021", "413021057", "story_v_out_413021.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_413021", "413021057", "story_v_out_413021.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_40 = math.max(var_235_31, arg_232_1.talkMaxDuration)

			if var_235_30 <= arg_232_1.time_ and arg_232_1.time_ < var_235_30 + var_235_40 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_30) / var_235_40

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_30 + var_235_40 and arg_232_1.time_ < var_235_30 + var_235_40 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play413021058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 413021058
		arg_236_1.duration_ = 8.77

		local var_236_0 = {
			zh = 8.7,
			ja = 8.766
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
				arg_236_0:Play413021059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = "ST0601"

			if arg_236_1.bgs_[var_239_0] == nil then
				local var_239_1 = Object.Instantiate(arg_236_1.paintGo_)

				var_239_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_239_0)
				var_239_1.name = var_239_0
				var_239_1.transform.parent = arg_236_1.stage_.transform
				var_239_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_236_1.bgs_[var_239_0] = var_239_1
			end

			local var_239_2 = 2

			if var_239_2 < arg_236_1.time_ and arg_236_1.time_ <= var_239_2 + arg_239_0 then
				local var_239_3 = manager.ui.mainCamera.transform.localPosition
				local var_239_4 = Vector3.New(0, 0, 10) + Vector3.New(var_239_3.x, var_239_3.y, 0)
				local var_239_5 = arg_236_1.bgs_.ST0601

				var_239_5.transform.localPosition = var_239_4
				var_239_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_239_6 = var_239_5:GetComponent("SpriteRenderer")

				if var_239_6 and var_239_6.sprite then
					local var_239_7 = (var_239_5.transform.localPosition - var_239_3).z
					local var_239_8 = manager.ui.mainCameraCom_
					local var_239_9 = 2 * var_239_7 * Mathf.Tan(var_239_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_239_10 = var_239_9 * var_239_8.aspect
					local var_239_11 = var_239_6.sprite.bounds.size.x
					local var_239_12 = var_239_6.sprite.bounds.size.y
					local var_239_13 = var_239_10 / var_239_11
					local var_239_14 = var_239_9 / var_239_12
					local var_239_15 = var_239_14 < var_239_13 and var_239_13 or var_239_14

					var_239_5.transform.localScale = Vector3.New(var_239_15, var_239_15, 0)
				end

				for iter_239_0, iter_239_1 in pairs(arg_236_1.bgs_) do
					if iter_239_0 ~= "ST0601" then
						iter_239_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_239_16 = 4

			if var_239_16 < arg_236_1.time_ and arg_236_1.time_ <= var_239_16 + arg_239_0 then
				arg_236_1.allBtn_.enabled = false
			end

			local var_239_17 = 0.3

			if arg_236_1.time_ >= var_239_16 + var_239_17 and arg_236_1.time_ < var_239_16 + var_239_17 + arg_239_0 then
				arg_236_1.allBtn_.enabled = true
			end

			local var_239_18 = 0

			if var_239_18 < arg_236_1.time_ and arg_236_1.time_ <= var_239_18 + arg_239_0 then
				arg_236_1.mask_.enabled = true
				arg_236_1.mask_.raycastTarget = true

				arg_236_1:SetGaussion(false)
			end

			local var_239_19 = 2

			if var_239_18 <= arg_236_1.time_ and arg_236_1.time_ < var_239_18 + var_239_19 then
				local var_239_20 = (arg_236_1.time_ - var_239_18) / var_239_19
				local var_239_21 = Color.New(0, 0, 0)

				var_239_21.a = Mathf.Lerp(0, 1, var_239_20)
				arg_236_1.mask_.color = var_239_21
			end

			if arg_236_1.time_ >= var_239_18 + var_239_19 and arg_236_1.time_ < var_239_18 + var_239_19 + arg_239_0 then
				local var_239_22 = Color.New(0, 0, 0)

				var_239_22.a = 1
				arg_236_1.mask_.color = var_239_22
			end

			local var_239_23 = 2

			if var_239_23 < arg_236_1.time_ and arg_236_1.time_ <= var_239_23 + arg_239_0 then
				arg_236_1.mask_.enabled = true
				arg_236_1.mask_.raycastTarget = true

				arg_236_1:SetGaussion(false)
			end

			local var_239_24 = 2

			if var_239_23 <= arg_236_1.time_ and arg_236_1.time_ < var_239_23 + var_239_24 then
				local var_239_25 = (arg_236_1.time_ - var_239_23) / var_239_24
				local var_239_26 = Color.New(0, 0, 0)

				var_239_26.a = Mathf.Lerp(1, 0, var_239_25)
				arg_236_1.mask_.color = var_239_26
			end

			if arg_236_1.time_ >= var_239_23 + var_239_24 and arg_236_1.time_ < var_239_23 + var_239_24 + arg_239_0 then
				local var_239_27 = Color.New(0, 0, 0)
				local var_239_28 = 0

				arg_236_1.mask_.enabled = false
				var_239_27.a = var_239_28
				arg_236_1.mask_.color = var_239_27
			end

			local var_239_29 = arg_236_1.actors_["10022"].transform
			local var_239_30 = 1.966

			if var_239_30 < arg_236_1.time_ and arg_236_1.time_ <= var_239_30 + arg_239_0 then
				arg_236_1.var_.moveOldPos10022 = var_239_29.localPosition
				var_239_29.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("10022", 7)

				local var_239_31 = var_239_29.childCount

				for iter_239_2 = 0, var_239_31 - 1 do
					local var_239_32 = var_239_29:GetChild(iter_239_2)

					if var_239_32.name == "" or not string.find(var_239_32.name, "split") then
						var_239_32.gameObject:SetActive(true)
					else
						var_239_32.gameObject:SetActive(false)
					end
				end
			end

			local var_239_33 = 0.001

			if var_239_30 <= arg_236_1.time_ and arg_236_1.time_ < var_239_30 + var_239_33 then
				local var_239_34 = (arg_236_1.time_ - var_239_30) / var_239_33
				local var_239_35 = Vector3.New(0, -2000, 0)

				var_239_29.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10022, var_239_35, var_239_34)
			end

			if arg_236_1.time_ >= var_239_30 + var_239_33 and arg_236_1.time_ < var_239_30 + var_239_33 + arg_239_0 then
				var_239_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_239_36 = arg_236_1.actors_["10094"].transform
			local var_239_37 = 1.966

			if var_239_37 < arg_236_1.time_ and arg_236_1.time_ <= var_239_37 + arg_239_0 then
				arg_236_1.var_.moveOldPos10094 = var_239_36.localPosition
				var_239_36.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("10094", 7)

				local var_239_38 = var_239_36.childCount

				for iter_239_3 = 0, var_239_38 - 1 do
					local var_239_39 = var_239_36:GetChild(iter_239_3)

					if var_239_39.name == "" or not string.find(var_239_39.name, "split") then
						var_239_39.gameObject:SetActive(true)
					else
						var_239_39.gameObject:SetActive(false)
					end
				end
			end

			local var_239_40 = 0.001

			if var_239_37 <= arg_236_1.time_ and arg_236_1.time_ < var_239_37 + var_239_40 then
				local var_239_41 = (arg_236_1.time_ - var_239_37) / var_239_40
				local var_239_42 = Vector3.New(0, -2000, 0)

				var_239_36.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10094, var_239_42, var_239_41)
			end

			if arg_236_1.time_ >= var_239_37 + var_239_40 and arg_236_1.time_ < var_239_37 + var_239_40 + arg_239_0 then
				var_239_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_239_43 = arg_236_1.actors_["10022"]
			local var_239_44 = 1.966

			if var_239_44 < arg_236_1.time_ and arg_236_1.time_ <= var_239_44 + arg_239_0 and not isNil(var_239_43) and arg_236_1.var_.actorSpriteComps10022 == nil then
				arg_236_1.var_.actorSpriteComps10022 = var_239_43:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_45 = 0.034

			if var_239_44 <= arg_236_1.time_ and arg_236_1.time_ < var_239_44 + var_239_45 and not isNil(var_239_43) then
				local var_239_46 = (arg_236_1.time_ - var_239_44) / var_239_45

				if arg_236_1.var_.actorSpriteComps10022 then
					for iter_239_4, iter_239_5 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_239_5 then
							if arg_236_1.isInRecall_ then
								local var_239_47 = Mathf.Lerp(iter_239_5.color.r, arg_236_1.hightColor2.r, var_239_46)
								local var_239_48 = Mathf.Lerp(iter_239_5.color.g, arg_236_1.hightColor2.g, var_239_46)
								local var_239_49 = Mathf.Lerp(iter_239_5.color.b, arg_236_1.hightColor2.b, var_239_46)

								iter_239_5.color = Color.New(var_239_47, var_239_48, var_239_49)
							else
								local var_239_50 = Mathf.Lerp(iter_239_5.color.r, 0.5, var_239_46)

								iter_239_5.color = Color.New(var_239_50, var_239_50, var_239_50)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= var_239_44 + var_239_45 and arg_236_1.time_ < var_239_44 + var_239_45 + arg_239_0 and not isNil(var_239_43) and arg_236_1.var_.actorSpriteComps10022 then
				for iter_239_6, iter_239_7 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_239_7 then
						if arg_236_1.isInRecall_ then
							iter_239_7.color = arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_239_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_236_1.var_.actorSpriteComps10022 = nil
			end

			local var_239_51 = arg_236_1.actors_["10094"]
			local var_239_52 = 1.966

			if var_239_52 < arg_236_1.time_ and arg_236_1.time_ <= var_239_52 + arg_239_0 and not isNil(var_239_51) and arg_236_1.var_.actorSpriteComps10094 == nil then
				arg_236_1.var_.actorSpriteComps10094 = var_239_51:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_53 = 0.034

			if var_239_52 <= arg_236_1.time_ and arg_236_1.time_ < var_239_52 + var_239_53 and not isNil(var_239_51) then
				local var_239_54 = (arg_236_1.time_ - var_239_52) / var_239_53

				if arg_236_1.var_.actorSpriteComps10094 then
					for iter_239_8, iter_239_9 in pairs(arg_236_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_239_9 then
							if arg_236_1.isInRecall_ then
								local var_239_55 = Mathf.Lerp(iter_239_9.color.r, arg_236_1.hightColor2.r, var_239_54)
								local var_239_56 = Mathf.Lerp(iter_239_9.color.g, arg_236_1.hightColor2.g, var_239_54)
								local var_239_57 = Mathf.Lerp(iter_239_9.color.b, arg_236_1.hightColor2.b, var_239_54)

								iter_239_9.color = Color.New(var_239_55, var_239_56, var_239_57)
							else
								local var_239_58 = Mathf.Lerp(iter_239_9.color.r, 0.5, var_239_54)

								iter_239_9.color = Color.New(var_239_58, var_239_58, var_239_58)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= var_239_52 + var_239_53 and arg_236_1.time_ < var_239_52 + var_239_53 + arg_239_0 and not isNil(var_239_51) and arg_236_1.var_.actorSpriteComps10094 then
				for iter_239_10, iter_239_11 in pairs(arg_236_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_239_11 then
						if arg_236_1.isInRecall_ then
							iter_239_11.color = arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_239_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_236_1.var_.actorSpriteComps10094 = nil
			end

			local var_239_59 = 3.56666666666667
			local var_239_60 = 0.683333333333333

			if var_239_59 < arg_236_1.time_ and arg_236_1.time_ <= var_239_59 + arg_239_0 then
				local var_239_61 = "play"
				local var_239_62 = "effect"

				arg_236_1:AudioAction(var_239_61, var_239_62, "se_story_activity_1_4_3", "se_story_activity_1_4_3_door", "")
			end

			local var_239_63 = 1.76666666666667
			local var_239_64 = 1

			if var_239_63 < arg_236_1.time_ and arg_236_1.time_ <= var_239_63 + arg_239_0 then
				local var_239_65 = "play"
				local var_239_66 = "effect"

				arg_236_1:AudioAction(var_239_65, var_239_66, "se_story_121_04", "se_story_121_04_crowd_loop", "")
			end

			if arg_236_1.frameCnt_ <= 1 then
				arg_236_1.dialog_:SetActive(false)
			end

			local var_239_67 = 4
			local var_239_68 = 0.25

			if var_239_67 < arg_236_1.time_ and arg_236_1.time_ <= var_239_67 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0

				arg_236_1.dialog_:SetActive(true)

				arg_236_1.dialogCg_.alpha = 0

				local var_239_69 = LeanTween.value(arg_236_1.dialog_, 0, 1, 0.3)

				var_239_69:setOnUpdate(LuaHelper.FloatAction(function(arg_240_0)
					arg_236_1.dialogCg_.alpha = arg_240_0
				end))
				var_239_69:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_236_1.dialog_)
					var_239_69:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_236_1.duration_ = arg_236_1.duration_ + 0.3

				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_70 = arg_236_1:FormatText(StoryNameCfg[993].name)

				arg_236_1.leftNameTxt_.text = var_239_70

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_71 = arg_236_1:GetWordFromCfg(413021058)
				local var_239_72 = arg_236_1:FormatText(var_239_71.content)

				arg_236_1.text_.text = var_239_72

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_73 = 10
				local var_239_74 = utf8.len(var_239_72)
				local var_239_75 = var_239_73 <= 0 and var_239_68 or var_239_68 * (var_239_74 / var_239_73)

				if var_239_75 > 0 and var_239_68 < var_239_75 then
					arg_236_1.talkMaxDuration = var_239_75
					var_239_67 = var_239_67 + 0.3

					if var_239_75 + var_239_67 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_75 + var_239_67
					end
				end

				arg_236_1.text_.text = var_239_72
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021058", "story_v_out_413021.awb") ~= 0 then
					local var_239_76 = manager.audio:GetVoiceLength("story_v_out_413021", "413021058", "story_v_out_413021.awb") / 1000

					if var_239_76 + var_239_67 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_76 + var_239_67
					end

					if var_239_71.prefab_name ~= "" and arg_236_1.actors_[var_239_71.prefab_name] ~= nil then
						local var_239_77 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_71.prefab_name].transform, "story_v_out_413021", "413021058", "story_v_out_413021.awb")

						arg_236_1:RecordAudio("413021058", var_239_77)
						arg_236_1:RecordAudio("413021058", var_239_77)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_413021", "413021058", "story_v_out_413021.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_413021", "413021058", "story_v_out_413021.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_78 = var_239_67 + 0.3
			local var_239_79 = math.max(var_239_68, arg_236_1.talkMaxDuration)

			if var_239_78 <= arg_236_1.time_ and arg_236_1.time_ < var_239_78 + var_239_79 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_78) / var_239_79

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_78 + var_239_79 and arg_236_1.time_ < var_239_78 + var_239_79 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play413021059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 413021059
		arg_242_1.duration_ = 5.97

		local var_242_0 = {
			zh = 5.966,
			ja = 2.433
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play413021060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0
			local var_245_1 = 0.733333333333333

			if var_245_0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_0 + arg_245_0 then
				local var_245_2 = "play"
				local var_245_3 = "effect"

				arg_242_1:AudioAction(var_245_2, var_245_3, "se_story_221_00", "se_story_221_00_canteen_loop", "")
			end

			local var_245_4 = 0
			local var_245_5 = 0.55

			if var_245_4 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_6 = arg_242_1:FormatText(StoryNameCfg[999].name)

				arg_242_1.leftNameTxt_.text = var_245_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_7 = arg_242_1:GetWordFromCfg(413021059)
				local var_245_8 = arg_242_1:FormatText(var_245_7.content)

				arg_242_1.text_.text = var_245_8

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_9 = 22
				local var_245_10 = utf8.len(var_245_8)
				local var_245_11 = var_245_9 <= 0 and var_245_5 or var_245_5 * (var_245_10 / var_245_9)

				if var_245_11 > 0 and var_245_5 < var_245_11 then
					arg_242_1.talkMaxDuration = var_245_11

					if var_245_11 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_11 + var_245_4
					end
				end

				arg_242_1.text_.text = var_245_8
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021059", "story_v_out_413021.awb") ~= 0 then
					local var_245_12 = manager.audio:GetVoiceLength("story_v_out_413021", "413021059", "story_v_out_413021.awb") / 1000

					if var_245_12 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_12 + var_245_4
					end

					if var_245_7.prefab_name ~= "" and arg_242_1.actors_[var_245_7.prefab_name] ~= nil then
						local var_245_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_7.prefab_name].transform, "story_v_out_413021", "413021059", "story_v_out_413021.awb")

						arg_242_1:RecordAudio("413021059", var_245_13)
						arg_242_1:RecordAudio("413021059", var_245_13)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_413021", "413021059", "story_v_out_413021.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_413021", "413021059", "story_v_out_413021.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_14 = math.max(var_245_5, arg_242_1.talkMaxDuration)

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_14 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_4) / var_245_14

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_4 + var_245_14 and arg_242_1.time_ < var_245_4 + var_245_14 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play413021060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 413021060
		arg_246_1.duration_ = 6.67

		local var_246_0 = {
			zh = 3.166,
			ja = 6.666
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play413021061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["10092"].transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.moveOldPos10092 = var_249_0.localPosition
				var_249_0.localScale = Vector3.New(1, 1, 1)

				arg_246_1:CheckSpriteTmpPos("10092", 3)

				local var_249_2 = var_249_0.childCount

				for iter_249_0 = 0, var_249_2 - 1 do
					local var_249_3 = var_249_0:GetChild(iter_249_0)

					if var_249_3.name == "" or not string.find(var_249_3.name, "split") then
						var_249_3.gameObject:SetActive(true)
					else
						var_249_3.gameObject:SetActive(false)
					end
				end
			end

			local var_249_4 = 0.001

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_4 then
				local var_249_5 = (arg_246_1.time_ - var_249_1) / var_249_4
				local var_249_6 = Vector3.New(0, -300, -295)

				var_249_0.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos10092, var_249_6, var_249_5)
			end

			if arg_246_1.time_ >= var_249_1 + var_249_4 and arg_246_1.time_ < var_249_1 + var_249_4 + arg_249_0 then
				var_249_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_249_7 = arg_246_1.actors_["10092"]
			local var_249_8 = 0

			if var_249_8 < arg_246_1.time_ and arg_246_1.time_ <= var_249_8 + arg_249_0 and not isNil(var_249_7) and arg_246_1.var_.actorSpriteComps10092 == nil then
				arg_246_1.var_.actorSpriteComps10092 = var_249_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_9 = 2

			if var_249_8 <= arg_246_1.time_ and arg_246_1.time_ < var_249_8 + var_249_9 and not isNil(var_249_7) then
				local var_249_10 = (arg_246_1.time_ - var_249_8) / var_249_9

				if arg_246_1.var_.actorSpriteComps10092 then
					for iter_249_1, iter_249_2 in pairs(arg_246_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_249_2 then
							if arg_246_1.isInRecall_ then
								local var_249_11 = Mathf.Lerp(iter_249_2.color.r, arg_246_1.hightColor1.r, var_249_10)
								local var_249_12 = Mathf.Lerp(iter_249_2.color.g, arg_246_1.hightColor1.g, var_249_10)
								local var_249_13 = Mathf.Lerp(iter_249_2.color.b, arg_246_1.hightColor1.b, var_249_10)

								iter_249_2.color = Color.New(var_249_11, var_249_12, var_249_13)
							else
								local var_249_14 = Mathf.Lerp(iter_249_2.color.r, 1, var_249_10)

								iter_249_2.color = Color.New(var_249_14, var_249_14, var_249_14)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= var_249_8 + var_249_9 and arg_246_1.time_ < var_249_8 + var_249_9 + arg_249_0 and not isNil(var_249_7) and arg_246_1.var_.actorSpriteComps10092 then
				for iter_249_3, iter_249_4 in pairs(arg_246_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_249_4 then
						if arg_246_1.isInRecall_ then
							iter_249_4.color = arg_246_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_249_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_246_1.var_.actorSpriteComps10092 = nil
			end

			local var_249_15 = arg_246_1.actors_["10092"]
			local var_249_16 = 0

			if var_249_16 < arg_246_1.time_ and arg_246_1.time_ <= var_249_16 + arg_249_0 then
				local var_249_17 = var_249_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_249_17 then
					arg_246_1.var_.alphaOldValue10092 = var_249_17.alpha
					arg_246_1.var_.characterEffect10092 = var_249_17
				end

				arg_246_1.var_.alphaOldValue10092 = 0
			end

			local var_249_18 = 0.5

			if var_249_16 <= arg_246_1.time_ and arg_246_1.time_ < var_249_16 + var_249_18 then
				local var_249_19 = (arg_246_1.time_ - var_249_16) / var_249_18
				local var_249_20 = Mathf.Lerp(arg_246_1.var_.alphaOldValue10092, 1, var_249_19)

				if arg_246_1.var_.characterEffect10092 then
					arg_246_1.var_.characterEffect10092.alpha = var_249_20
				end
			end

			if arg_246_1.time_ >= var_249_16 + var_249_18 and arg_246_1.time_ < var_249_16 + var_249_18 + arg_249_0 and arg_246_1.var_.characterEffect10092 then
				arg_246_1.var_.characterEffect10092.alpha = 1
			end

			local var_249_21 = 0
			local var_249_22 = 0.45

			if var_249_21 < arg_246_1.time_ and arg_246_1.time_ <= var_249_21 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_23 = arg_246_1:FormatText(StoryNameCfg[996].name)

				arg_246_1.leftNameTxt_.text = var_249_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_24 = arg_246_1:GetWordFromCfg(413021060)
				local var_249_25 = arg_246_1:FormatText(var_249_24.content)

				arg_246_1.text_.text = var_249_25

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_26 = 18
				local var_249_27 = utf8.len(var_249_25)
				local var_249_28 = var_249_26 <= 0 and var_249_22 or var_249_22 * (var_249_27 / var_249_26)

				if var_249_28 > 0 and var_249_22 < var_249_28 then
					arg_246_1.talkMaxDuration = var_249_28

					if var_249_28 + var_249_21 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_28 + var_249_21
					end
				end

				arg_246_1.text_.text = var_249_25
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021060", "story_v_out_413021.awb") ~= 0 then
					local var_249_29 = manager.audio:GetVoiceLength("story_v_out_413021", "413021060", "story_v_out_413021.awb") / 1000

					if var_249_29 + var_249_21 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_29 + var_249_21
					end

					if var_249_24.prefab_name ~= "" and arg_246_1.actors_[var_249_24.prefab_name] ~= nil then
						local var_249_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_24.prefab_name].transform, "story_v_out_413021", "413021060", "story_v_out_413021.awb")

						arg_246_1:RecordAudio("413021060", var_249_30)
						arg_246_1:RecordAudio("413021060", var_249_30)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_413021", "413021060", "story_v_out_413021.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_413021", "413021060", "story_v_out_413021.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_31 = math.max(var_249_22, arg_246_1.talkMaxDuration)

			if var_249_21 <= arg_246_1.time_ and arg_246_1.time_ < var_249_21 + var_249_31 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_21) / var_249_31

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_21 + var_249_31 and arg_246_1.time_ < var_249_21 + var_249_31 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play413021061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 413021061
		arg_250_1.duration_ = 2.8

		local var_250_0 = {
			zh = 2.8,
			ja = 2.733
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play413021062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.35

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_2 = arg_250_1:FormatText(StoryNameCfg[996].name)

				arg_250_1.leftNameTxt_.text = var_253_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_3 = arg_250_1:GetWordFromCfg(413021061)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 14
				local var_253_6 = utf8.len(var_253_4)
				local var_253_7 = var_253_5 <= 0 and var_253_1 or var_253_1 * (var_253_6 / var_253_5)

				if var_253_7 > 0 and var_253_1 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021061", "story_v_out_413021.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021061", "story_v_out_413021.awb") / 1000

					if var_253_8 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_0
					end

					if var_253_3.prefab_name ~= "" and arg_250_1.actors_[var_253_3.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_3.prefab_name].transform, "story_v_out_413021", "413021061", "story_v_out_413021.awb")

						arg_250_1:RecordAudio("413021061", var_253_9)
						arg_250_1:RecordAudio("413021061", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_413021", "413021061", "story_v_out_413021.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_413021", "413021061", "story_v_out_413021.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_10 and arg_250_1.time_ < var_253_0 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play413021062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 413021062
		arg_254_1.duration_ = 6.1

		local var_254_0 = {
			zh = 3.566,
			ja = 6.1
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play413021063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["10092"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps10092 == nil then
				arg_254_1.var_.actorSpriteComps10092 = var_257_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_2 = 2

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.actorSpriteComps10092 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								local var_257_4 = Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor2.r, var_257_3)
								local var_257_5 = Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor2.g, var_257_3)
								local var_257_6 = Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor2.b, var_257_3)

								iter_257_1.color = Color.New(var_257_4, var_257_5, var_257_6)
							else
								local var_257_7 = Mathf.Lerp(iter_257_1.color.r, 0.5, var_257_3)

								iter_257_1.color = Color.New(var_257_7, var_257_7, var_257_7)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps10092 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_257_3 then
						if arg_254_1.isInRecall_ then
							iter_257_3.color = arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_257_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps10092 = nil
			end

			local var_257_8 = 0
			local var_257_9 = 0.35

			if var_257_8 < arg_254_1.time_ and arg_254_1.time_ <= var_257_8 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_10 = arg_254_1:FormatText(StoryNameCfg[999].name)

				arg_254_1.leftNameTxt_.text = var_257_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_11 = arg_254_1:GetWordFromCfg(413021062)
				local var_257_12 = arg_254_1:FormatText(var_257_11.content)

				arg_254_1.text_.text = var_257_12

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_13 = 14
				local var_257_14 = utf8.len(var_257_12)
				local var_257_15 = var_257_13 <= 0 and var_257_9 or var_257_9 * (var_257_14 / var_257_13)

				if var_257_15 > 0 and var_257_9 < var_257_15 then
					arg_254_1.talkMaxDuration = var_257_15

					if var_257_15 + var_257_8 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_15 + var_257_8
					end
				end

				arg_254_1.text_.text = var_257_12
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021062", "story_v_out_413021.awb") ~= 0 then
					local var_257_16 = manager.audio:GetVoiceLength("story_v_out_413021", "413021062", "story_v_out_413021.awb") / 1000

					if var_257_16 + var_257_8 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_16 + var_257_8
					end

					if var_257_11.prefab_name ~= "" and arg_254_1.actors_[var_257_11.prefab_name] ~= nil then
						local var_257_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_11.prefab_name].transform, "story_v_out_413021", "413021062", "story_v_out_413021.awb")

						arg_254_1:RecordAudio("413021062", var_257_17)
						arg_254_1:RecordAudio("413021062", var_257_17)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_413021", "413021062", "story_v_out_413021.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_413021", "413021062", "story_v_out_413021.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_18 = math.max(var_257_9, arg_254_1.talkMaxDuration)

			if var_257_8 <= arg_254_1.time_ and arg_254_1.time_ < var_257_8 + var_257_18 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_8) / var_257_18

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_8 + var_257_18 and arg_254_1.time_ < var_257_8 + var_257_18 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play413021063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 413021063
		arg_258_1.duration_ = 5

		local var_258_0 = {
			zh = 4.9,
			ja = 5
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play413021064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["10022"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos10022 = var_261_0.localPosition
				var_261_0.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("10022", 3)

				local var_261_2 = var_261_0.childCount

				for iter_261_0 = 0, var_261_2 - 1 do
					local var_261_3 = var_261_0:GetChild(iter_261_0)

					if var_261_3.name == "split_3" or not string.find(var_261_3.name, "split") then
						var_261_3.gameObject:SetActive(true)
					else
						var_261_3.gameObject:SetActive(false)
					end
				end
			end

			local var_261_4 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_4 then
				local var_261_5 = (arg_258_1.time_ - var_261_1) / var_261_4
				local var_261_6 = Vector3.New(0, -315, -320)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos10022, var_261_6, var_261_5)
			end

			if arg_258_1.time_ >= var_261_1 + var_261_4 and arg_258_1.time_ < var_261_1 + var_261_4 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_261_7 = arg_258_1.actors_["10022"]
			local var_261_8 = 0

			if var_261_8 < arg_258_1.time_ and arg_258_1.time_ <= var_261_8 + arg_261_0 and not isNil(var_261_7) and arg_258_1.var_.actorSpriteComps10022 == nil then
				arg_258_1.var_.actorSpriteComps10022 = var_261_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_9 = 2

			if var_261_8 <= arg_258_1.time_ and arg_258_1.time_ < var_261_8 + var_261_9 and not isNil(var_261_7) then
				local var_261_10 = (arg_258_1.time_ - var_261_8) / var_261_9

				if arg_258_1.var_.actorSpriteComps10022 then
					for iter_261_1, iter_261_2 in pairs(arg_258_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_261_2 then
							if arg_258_1.isInRecall_ then
								local var_261_11 = Mathf.Lerp(iter_261_2.color.r, arg_258_1.hightColor1.r, var_261_10)
								local var_261_12 = Mathf.Lerp(iter_261_2.color.g, arg_258_1.hightColor1.g, var_261_10)
								local var_261_13 = Mathf.Lerp(iter_261_2.color.b, arg_258_1.hightColor1.b, var_261_10)

								iter_261_2.color = Color.New(var_261_11, var_261_12, var_261_13)
							else
								local var_261_14 = Mathf.Lerp(iter_261_2.color.r, 1, var_261_10)

								iter_261_2.color = Color.New(var_261_14, var_261_14, var_261_14)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= var_261_8 + var_261_9 and arg_258_1.time_ < var_261_8 + var_261_9 + arg_261_0 and not isNil(var_261_7) and arg_258_1.var_.actorSpriteComps10022 then
				for iter_261_3, iter_261_4 in pairs(arg_258_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_261_4 then
						if arg_258_1.isInRecall_ then
							iter_261_4.color = arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_261_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_258_1.var_.actorSpriteComps10022 = nil
			end

			local var_261_15 = 0
			local var_261_16 = 0.65

			if var_261_15 < arg_258_1.time_ and arg_258_1.time_ <= var_261_15 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_17 = arg_258_1:FormatText(StoryNameCfg[614].name)

				arg_258_1.leftNameTxt_.text = var_261_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_18 = arg_258_1:GetWordFromCfg(413021063)
				local var_261_19 = arg_258_1:FormatText(var_261_18.content)

				arg_258_1.text_.text = var_261_19

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_20 = 26
				local var_261_21 = utf8.len(var_261_19)
				local var_261_22 = var_261_20 <= 0 and var_261_16 or var_261_16 * (var_261_21 / var_261_20)

				if var_261_22 > 0 and var_261_16 < var_261_22 then
					arg_258_1.talkMaxDuration = var_261_22

					if var_261_22 + var_261_15 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_22 + var_261_15
					end
				end

				arg_258_1.text_.text = var_261_19
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021063", "story_v_out_413021.awb") ~= 0 then
					local var_261_23 = manager.audio:GetVoiceLength("story_v_out_413021", "413021063", "story_v_out_413021.awb") / 1000

					if var_261_23 + var_261_15 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_23 + var_261_15
					end

					if var_261_18.prefab_name ~= "" and arg_258_1.actors_[var_261_18.prefab_name] ~= nil then
						local var_261_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_18.prefab_name].transform, "story_v_out_413021", "413021063", "story_v_out_413021.awb")

						arg_258_1:RecordAudio("413021063", var_261_24)
						arg_258_1:RecordAudio("413021063", var_261_24)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_413021", "413021063", "story_v_out_413021.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_413021", "413021063", "story_v_out_413021.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_25 = math.max(var_261_16, arg_258_1.talkMaxDuration)

			if var_261_15 <= arg_258_1.time_ and arg_258_1.time_ < var_261_15 + var_261_25 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_15) / var_261_25

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_15 + var_261_25 and arg_258_1.time_ < var_261_15 + var_261_25 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play413021064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 413021064
		arg_262_1.duration_ = 5.57

		local var_262_0 = {
			zh = 4.233,
			ja = 5.566
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play413021065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["10094"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos10094 = var_265_0.localPosition
				var_265_0.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("10094", 4)

				local var_265_2 = var_265_0.childCount

				for iter_265_0 = 0, var_265_2 - 1 do
					local var_265_3 = var_265_0:GetChild(iter_265_0)

					if var_265_3.name == "" or not string.find(var_265_3.name, "split") then
						var_265_3.gameObject:SetActive(true)
					else
						var_265_3.gameObject:SetActive(false)
					end
				end
			end

			local var_265_4 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_4 then
				local var_265_5 = (arg_262_1.time_ - var_265_1) / var_265_4
				local var_265_6 = Vector3.New(390, -340, -414)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos10094, var_265_6, var_265_5)
			end

			if arg_262_1.time_ >= var_265_1 + var_265_4 and arg_262_1.time_ < var_265_1 + var_265_4 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_265_7 = arg_262_1.actors_["10022"]
			local var_265_8 = 0

			if var_265_8 < arg_262_1.time_ and arg_262_1.time_ <= var_265_8 + arg_265_0 and not isNil(var_265_7) and arg_262_1.var_.actorSpriteComps10022 == nil then
				arg_262_1.var_.actorSpriteComps10022 = var_265_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_9 = 2

			if var_265_8 <= arg_262_1.time_ and arg_262_1.time_ < var_265_8 + var_265_9 and not isNil(var_265_7) then
				local var_265_10 = (arg_262_1.time_ - var_265_8) / var_265_9

				if arg_262_1.var_.actorSpriteComps10022 then
					for iter_265_1, iter_265_2 in pairs(arg_262_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_265_2 then
							if arg_262_1.isInRecall_ then
								local var_265_11 = Mathf.Lerp(iter_265_2.color.r, arg_262_1.hightColor2.r, var_265_10)
								local var_265_12 = Mathf.Lerp(iter_265_2.color.g, arg_262_1.hightColor2.g, var_265_10)
								local var_265_13 = Mathf.Lerp(iter_265_2.color.b, arg_262_1.hightColor2.b, var_265_10)

								iter_265_2.color = Color.New(var_265_11, var_265_12, var_265_13)
							else
								local var_265_14 = Mathf.Lerp(iter_265_2.color.r, 0.5, var_265_10)

								iter_265_2.color = Color.New(var_265_14, var_265_14, var_265_14)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= var_265_8 + var_265_9 and arg_262_1.time_ < var_265_8 + var_265_9 + arg_265_0 and not isNil(var_265_7) and arg_262_1.var_.actorSpriteComps10022 then
				for iter_265_3, iter_265_4 in pairs(arg_262_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_265_4 then
						if arg_262_1.isInRecall_ then
							iter_265_4.color = arg_262_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_265_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_262_1.var_.actorSpriteComps10022 = nil
			end

			local var_265_15 = arg_262_1.actors_["10094"]
			local var_265_16 = 0

			if var_265_16 < arg_262_1.time_ and arg_262_1.time_ <= var_265_16 + arg_265_0 and not isNil(var_265_15) and arg_262_1.var_.actorSpriteComps10094 == nil then
				arg_262_1.var_.actorSpriteComps10094 = var_265_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_17 = 2

			if var_265_16 <= arg_262_1.time_ and arg_262_1.time_ < var_265_16 + var_265_17 and not isNil(var_265_15) then
				local var_265_18 = (arg_262_1.time_ - var_265_16) / var_265_17

				if arg_262_1.var_.actorSpriteComps10094 then
					for iter_265_5, iter_265_6 in pairs(arg_262_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_265_6 then
							if arg_262_1.isInRecall_ then
								local var_265_19 = Mathf.Lerp(iter_265_6.color.r, arg_262_1.hightColor1.r, var_265_18)
								local var_265_20 = Mathf.Lerp(iter_265_6.color.g, arg_262_1.hightColor1.g, var_265_18)
								local var_265_21 = Mathf.Lerp(iter_265_6.color.b, arg_262_1.hightColor1.b, var_265_18)

								iter_265_6.color = Color.New(var_265_19, var_265_20, var_265_21)
							else
								local var_265_22 = Mathf.Lerp(iter_265_6.color.r, 1, var_265_18)

								iter_265_6.color = Color.New(var_265_22, var_265_22, var_265_22)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= var_265_16 + var_265_17 and arg_262_1.time_ < var_265_16 + var_265_17 + arg_265_0 and not isNil(var_265_15) and arg_262_1.var_.actorSpriteComps10094 then
				for iter_265_7, iter_265_8 in pairs(arg_262_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_265_8 then
						if arg_262_1.isInRecall_ then
							iter_265_8.color = arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_265_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_262_1.var_.actorSpriteComps10094 = nil
			end

			local var_265_23 = arg_262_1.actors_["10022"].transform
			local var_265_24 = 0

			if var_265_24 < arg_262_1.time_ and arg_262_1.time_ <= var_265_24 + arg_265_0 then
				arg_262_1.var_.moveOldPos10022 = var_265_23.localPosition
				var_265_23.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("10022", 2)

				local var_265_25 = var_265_23.childCount

				for iter_265_9 = 0, var_265_25 - 1 do
					local var_265_26 = var_265_23:GetChild(iter_265_9)

					if var_265_26.name == "" or not string.find(var_265_26.name, "split") then
						var_265_26.gameObject:SetActive(true)
					else
						var_265_26.gameObject:SetActive(false)
					end
				end
			end

			local var_265_27 = 0.001

			if var_265_24 <= arg_262_1.time_ and arg_262_1.time_ < var_265_24 + var_265_27 then
				local var_265_28 = (arg_262_1.time_ - var_265_24) / var_265_27
				local var_265_29 = Vector3.New(-390, -315, -320)

				var_265_23.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos10022, var_265_29, var_265_28)
			end

			if arg_262_1.time_ >= var_265_24 + var_265_27 and arg_262_1.time_ < var_265_24 + var_265_27 + arg_265_0 then
				var_265_23.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_265_30 = 0
			local var_265_31 = 0.5

			if var_265_30 < arg_262_1.time_ and arg_262_1.time_ <= var_265_30 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_32 = arg_262_1:FormatText(StoryNameCfg[259].name)

				arg_262_1.leftNameTxt_.text = var_265_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_33 = arg_262_1:GetWordFromCfg(413021064)
				local var_265_34 = arg_262_1:FormatText(var_265_33.content)

				arg_262_1.text_.text = var_265_34

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_35 = 20
				local var_265_36 = utf8.len(var_265_34)
				local var_265_37 = var_265_35 <= 0 and var_265_31 or var_265_31 * (var_265_36 / var_265_35)

				if var_265_37 > 0 and var_265_31 < var_265_37 then
					arg_262_1.talkMaxDuration = var_265_37

					if var_265_37 + var_265_30 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_37 + var_265_30
					end
				end

				arg_262_1.text_.text = var_265_34
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021064", "story_v_out_413021.awb") ~= 0 then
					local var_265_38 = manager.audio:GetVoiceLength("story_v_out_413021", "413021064", "story_v_out_413021.awb") / 1000

					if var_265_38 + var_265_30 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_38 + var_265_30
					end

					if var_265_33.prefab_name ~= "" and arg_262_1.actors_[var_265_33.prefab_name] ~= nil then
						local var_265_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_33.prefab_name].transform, "story_v_out_413021", "413021064", "story_v_out_413021.awb")

						arg_262_1:RecordAudio("413021064", var_265_39)
						arg_262_1:RecordAudio("413021064", var_265_39)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_413021", "413021064", "story_v_out_413021.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_413021", "413021064", "story_v_out_413021.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_40 = math.max(var_265_31, arg_262_1.talkMaxDuration)

			if var_265_30 <= arg_262_1.time_ and arg_262_1.time_ < var_265_30 + var_265_40 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_30) / var_265_40

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_30 + var_265_40 and arg_262_1.time_ < var_265_30 + var_265_40 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play413021065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 413021065
		arg_266_1.duration_ = 7.57

		local var_266_0 = {
			zh = 4.633,
			ja = 7.566
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play413021066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["10092"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos10092 = var_269_0.localPosition
				var_269_0.localScale = Vector3.New(1, 1, 1)

				arg_266_1:CheckSpriteTmpPos("10092", 4)

				local var_269_2 = var_269_0.childCount

				for iter_269_0 = 0, var_269_2 - 1 do
					local var_269_3 = var_269_0:GetChild(iter_269_0)

					if var_269_3.name == "" or not string.find(var_269_3.name, "split") then
						var_269_3.gameObject:SetActive(true)
					else
						var_269_3.gameObject:SetActive(false)
					end
				end
			end

			local var_269_4 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_4 then
				local var_269_5 = (arg_266_1.time_ - var_269_1) / var_269_4
				local var_269_6 = Vector3.New(390, -300, -295)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos10092, var_269_6, var_269_5)
			end

			if arg_266_1.time_ >= var_269_1 + var_269_4 and arg_266_1.time_ < var_269_1 + var_269_4 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_269_7 = arg_266_1.actors_["10092"]
			local var_269_8 = 0

			if var_269_8 < arg_266_1.time_ and arg_266_1.time_ <= var_269_8 + arg_269_0 and not isNil(var_269_7) and arg_266_1.var_.actorSpriteComps10092 == nil then
				arg_266_1.var_.actorSpriteComps10092 = var_269_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_9 = 2

			if var_269_8 <= arg_266_1.time_ and arg_266_1.time_ < var_269_8 + var_269_9 and not isNil(var_269_7) then
				local var_269_10 = (arg_266_1.time_ - var_269_8) / var_269_9

				if arg_266_1.var_.actorSpriteComps10092 then
					for iter_269_1, iter_269_2 in pairs(arg_266_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_269_2 then
							if arg_266_1.isInRecall_ then
								local var_269_11 = Mathf.Lerp(iter_269_2.color.r, arg_266_1.hightColor1.r, var_269_10)
								local var_269_12 = Mathf.Lerp(iter_269_2.color.g, arg_266_1.hightColor1.g, var_269_10)
								local var_269_13 = Mathf.Lerp(iter_269_2.color.b, arg_266_1.hightColor1.b, var_269_10)

								iter_269_2.color = Color.New(var_269_11, var_269_12, var_269_13)
							else
								local var_269_14 = Mathf.Lerp(iter_269_2.color.r, 1, var_269_10)

								iter_269_2.color = Color.New(var_269_14, var_269_14, var_269_14)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= var_269_8 + var_269_9 and arg_266_1.time_ < var_269_8 + var_269_9 + arg_269_0 and not isNil(var_269_7) and arg_266_1.var_.actorSpriteComps10092 then
				for iter_269_3, iter_269_4 in pairs(arg_266_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_269_4 then
						if arg_266_1.isInRecall_ then
							iter_269_4.color = arg_266_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_269_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_266_1.var_.actorSpriteComps10092 = nil
			end

			local var_269_15 = 0
			local var_269_16 = 0.6

			if var_269_15 < arg_266_1.time_ and arg_266_1.time_ <= var_269_15 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_17 = arg_266_1:FormatText(StoryNameCfg[996].name)

				arg_266_1.leftNameTxt_.text = var_269_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_18 = arg_266_1:GetWordFromCfg(413021065)
				local var_269_19 = arg_266_1:FormatText(var_269_18.content)

				arg_266_1.text_.text = var_269_19

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_20 = 24
				local var_269_21 = utf8.len(var_269_19)
				local var_269_22 = var_269_20 <= 0 and var_269_16 or var_269_16 * (var_269_21 / var_269_20)

				if var_269_22 > 0 and var_269_16 < var_269_22 then
					arg_266_1.talkMaxDuration = var_269_22

					if var_269_22 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_22 + var_269_15
					end
				end

				arg_266_1.text_.text = var_269_19
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021065", "story_v_out_413021.awb") ~= 0 then
					local var_269_23 = manager.audio:GetVoiceLength("story_v_out_413021", "413021065", "story_v_out_413021.awb") / 1000

					if var_269_23 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_23 + var_269_15
					end

					if var_269_18.prefab_name ~= "" and arg_266_1.actors_[var_269_18.prefab_name] ~= nil then
						local var_269_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_18.prefab_name].transform, "story_v_out_413021", "413021065", "story_v_out_413021.awb")

						arg_266_1:RecordAudio("413021065", var_269_24)
						arg_266_1:RecordAudio("413021065", var_269_24)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_413021", "413021065", "story_v_out_413021.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_413021", "413021065", "story_v_out_413021.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_25 = math.max(var_269_16, arg_266_1.talkMaxDuration)

			if var_269_15 <= arg_266_1.time_ and arg_266_1.time_ < var_269_15 + var_269_25 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_15) / var_269_25

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_15 + var_269_25 and arg_266_1.time_ < var_269_15 + var_269_25 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play413021066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 413021066
		arg_270_1.duration_ = 3.4

		local var_270_0 = {
			zh = 2.033,
			ja = 3.4
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play413021067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["10022"].transform
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.var_.moveOldPos10022 = var_273_0.localPosition
				var_273_0.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("10022", 2)

				local var_273_2 = var_273_0.childCount

				for iter_273_0 = 0, var_273_2 - 1 do
					local var_273_3 = var_273_0:GetChild(iter_273_0)

					if var_273_3.name == "split_3" or not string.find(var_273_3.name, "split") then
						var_273_3.gameObject:SetActive(true)
					else
						var_273_3.gameObject:SetActive(false)
					end
				end
			end

			local var_273_4 = 0.001

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_4 then
				local var_273_5 = (arg_270_1.time_ - var_273_1) / var_273_4
				local var_273_6 = Vector3.New(-390, -315, -320)

				var_273_0.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10022, var_273_6, var_273_5)
			end

			if arg_270_1.time_ >= var_273_1 + var_273_4 and arg_270_1.time_ < var_273_1 + var_273_4 + arg_273_0 then
				var_273_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_273_7 = arg_270_1.actors_["10022"]
			local var_273_8 = 0

			if var_273_8 < arg_270_1.time_ and arg_270_1.time_ <= var_273_8 + arg_273_0 and not isNil(var_273_7) and arg_270_1.var_.actorSpriteComps10022 == nil then
				arg_270_1.var_.actorSpriteComps10022 = var_273_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_9 = 2

			if var_273_8 <= arg_270_1.time_ and arg_270_1.time_ < var_273_8 + var_273_9 and not isNil(var_273_7) then
				local var_273_10 = (arg_270_1.time_ - var_273_8) / var_273_9

				if arg_270_1.var_.actorSpriteComps10022 then
					for iter_273_1, iter_273_2 in pairs(arg_270_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_273_2 then
							if arg_270_1.isInRecall_ then
								local var_273_11 = Mathf.Lerp(iter_273_2.color.r, arg_270_1.hightColor1.r, var_273_10)
								local var_273_12 = Mathf.Lerp(iter_273_2.color.g, arg_270_1.hightColor1.g, var_273_10)
								local var_273_13 = Mathf.Lerp(iter_273_2.color.b, arg_270_1.hightColor1.b, var_273_10)

								iter_273_2.color = Color.New(var_273_11, var_273_12, var_273_13)
							else
								local var_273_14 = Mathf.Lerp(iter_273_2.color.r, 1, var_273_10)

								iter_273_2.color = Color.New(var_273_14, var_273_14, var_273_14)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= var_273_8 + var_273_9 and arg_270_1.time_ < var_273_8 + var_273_9 + arg_273_0 and not isNil(var_273_7) and arg_270_1.var_.actorSpriteComps10022 then
				for iter_273_3, iter_273_4 in pairs(arg_270_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_273_4 then
						if arg_270_1.isInRecall_ then
							iter_273_4.color = arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_273_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_270_1.var_.actorSpriteComps10022 = nil
			end

			local var_273_15 = arg_270_1.actors_["10092"]
			local var_273_16 = 0

			if var_273_16 < arg_270_1.time_ and arg_270_1.time_ <= var_273_16 + arg_273_0 and not isNil(var_273_15) and arg_270_1.var_.actorSpriteComps10092 == nil then
				arg_270_1.var_.actorSpriteComps10092 = var_273_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_17 = 2

			if var_273_16 <= arg_270_1.time_ and arg_270_1.time_ < var_273_16 + var_273_17 and not isNil(var_273_15) then
				local var_273_18 = (arg_270_1.time_ - var_273_16) / var_273_17

				if arg_270_1.var_.actorSpriteComps10092 then
					for iter_273_5, iter_273_6 in pairs(arg_270_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_273_6 then
							if arg_270_1.isInRecall_ then
								local var_273_19 = Mathf.Lerp(iter_273_6.color.r, arg_270_1.hightColor2.r, var_273_18)
								local var_273_20 = Mathf.Lerp(iter_273_6.color.g, arg_270_1.hightColor2.g, var_273_18)
								local var_273_21 = Mathf.Lerp(iter_273_6.color.b, arg_270_1.hightColor2.b, var_273_18)

								iter_273_6.color = Color.New(var_273_19, var_273_20, var_273_21)
							else
								local var_273_22 = Mathf.Lerp(iter_273_6.color.r, 0.5, var_273_18)

								iter_273_6.color = Color.New(var_273_22, var_273_22, var_273_22)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= var_273_16 + var_273_17 and arg_270_1.time_ < var_273_16 + var_273_17 + arg_273_0 and not isNil(var_273_15) and arg_270_1.var_.actorSpriteComps10092 then
				for iter_273_7, iter_273_8 in pairs(arg_270_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_273_8 then
						if arg_270_1.isInRecall_ then
							iter_273_8.color = arg_270_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_273_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_270_1.var_.actorSpriteComps10092 = nil
			end

			local var_273_23 = 0
			local var_273_24 = 0.225

			if var_273_23 < arg_270_1.time_ and arg_270_1.time_ <= var_273_23 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_25 = arg_270_1:FormatText(StoryNameCfg[614].name)

				arg_270_1.leftNameTxt_.text = var_273_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_26 = arg_270_1:GetWordFromCfg(413021066)
				local var_273_27 = arg_270_1:FormatText(var_273_26.content)

				arg_270_1.text_.text = var_273_27

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_28 = 9
				local var_273_29 = utf8.len(var_273_27)
				local var_273_30 = var_273_28 <= 0 and var_273_24 or var_273_24 * (var_273_29 / var_273_28)

				if var_273_30 > 0 and var_273_24 < var_273_30 then
					arg_270_1.talkMaxDuration = var_273_30

					if var_273_30 + var_273_23 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_30 + var_273_23
					end
				end

				arg_270_1.text_.text = var_273_27
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021066", "story_v_out_413021.awb") ~= 0 then
					local var_273_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021066", "story_v_out_413021.awb") / 1000

					if var_273_31 + var_273_23 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_31 + var_273_23
					end

					if var_273_26.prefab_name ~= "" and arg_270_1.actors_[var_273_26.prefab_name] ~= nil then
						local var_273_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_26.prefab_name].transform, "story_v_out_413021", "413021066", "story_v_out_413021.awb")

						arg_270_1:RecordAudio("413021066", var_273_32)
						arg_270_1:RecordAudio("413021066", var_273_32)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_413021", "413021066", "story_v_out_413021.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_413021", "413021066", "story_v_out_413021.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_33 = math.max(var_273_24, arg_270_1.talkMaxDuration)

			if var_273_23 <= arg_270_1.time_ and arg_270_1.time_ < var_273_23 + var_273_33 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_23) / var_273_33

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_23 + var_273_33 and arg_270_1.time_ < var_273_23 + var_273_33 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play413021067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 413021067
		arg_274_1.duration_ = 9.8

		local var_274_0 = {
			zh = 7.866,
			ja = 9.8
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play413021068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 2

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				local var_277_1 = manager.ui.mainCamera.transform.localPosition
				local var_277_2 = Vector3.New(0, 0, 10) + Vector3.New(var_277_1.x, var_277_1.y, 0)
				local var_277_3 = arg_274_1.bgs_.ST0601

				var_277_3.transform.localPosition = var_277_2
				var_277_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_277_4 = var_277_3:GetComponent("SpriteRenderer")

				if var_277_4 and var_277_4.sprite then
					local var_277_5 = (var_277_3.transform.localPosition - var_277_1).z
					local var_277_6 = manager.ui.mainCameraCom_
					local var_277_7 = 2 * var_277_5 * Mathf.Tan(var_277_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_277_8 = var_277_7 * var_277_6.aspect
					local var_277_9 = var_277_4.sprite.bounds.size.x
					local var_277_10 = var_277_4.sprite.bounds.size.y
					local var_277_11 = var_277_8 / var_277_9
					local var_277_12 = var_277_7 / var_277_10
					local var_277_13 = var_277_12 < var_277_11 and var_277_11 or var_277_12

					var_277_3.transform.localScale = Vector3.New(var_277_13, var_277_13, 0)
				end

				for iter_277_0, iter_277_1 in pairs(arg_274_1.bgs_) do
					if iter_277_0 ~= "ST0601" then
						iter_277_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_277_14 = 3.999999999999

			if var_277_14 < arg_274_1.time_ and arg_274_1.time_ <= var_277_14 + arg_277_0 then
				arg_274_1.allBtn_.enabled = false
			end

			local var_277_15 = 0.3

			if arg_274_1.time_ >= var_277_14 + var_277_15 and arg_274_1.time_ < var_277_14 + var_277_15 + arg_277_0 then
				arg_274_1.allBtn_.enabled = true
			end

			local var_277_16 = 0

			if var_277_16 < arg_274_1.time_ and arg_274_1.time_ <= var_277_16 + arg_277_0 then
				arg_274_1.mask_.enabled = true
				arg_274_1.mask_.raycastTarget = true

				arg_274_1:SetGaussion(false)
			end

			local var_277_17 = 2

			if var_277_16 <= arg_274_1.time_ and arg_274_1.time_ < var_277_16 + var_277_17 then
				local var_277_18 = (arg_274_1.time_ - var_277_16) / var_277_17
				local var_277_19 = Color.New(0, 0, 0)

				var_277_19.a = Mathf.Lerp(0, 1, var_277_18)
				arg_274_1.mask_.color = var_277_19
			end

			if arg_274_1.time_ >= var_277_16 + var_277_17 and arg_274_1.time_ < var_277_16 + var_277_17 + arg_277_0 then
				local var_277_20 = Color.New(0, 0, 0)

				var_277_20.a = 1
				arg_274_1.mask_.color = var_277_20
			end

			local var_277_21 = 2

			if var_277_21 < arg_274_1.time_ and arg_274_1.time_ <= var_277_21 + arg_277_0 then
				arg_274_1.mask_.enabled = true
				arg_274_1.mask_.raycastTarget = true

				arg_274_1:SetGaussion(false)
			end

			local var_277_22 = 2

			if var_277_21 <= arg_274_1.time_ and arg_274_1.time_ < var_277_21 + var_277_22 then
				local var_277_23 = (arg_274_1.time_ - var_277_21) / var_277_22
				local var_277_24 = Color.New(0, 0, 0)

				var_277_24.a = Mathf.Lerp(1, 0, var_277_23)
				arg_274_1.mask_.color = var_277_24
			end

			if arg_274_1.time_ >= var_277_21 + var_277_22 and arg_274_1.time_ < var_277_21 + var_277_22 + arg_277_0 then
				local var_277_25 = Color.New(0, 0, 0)
				local var_277_26 = 0

				arg_274_1.mask_.enabled = false
				var_277_25.a = var_277_26
				arg_274_1.mask_.color = var_277_25
			end

			local var_277_27 = arg_274_1.actors_["10022"].transform
			local var_277_28 = 1.966

			if var_277_28 < arg_274_1.time_ and arg_274_1.time_ <= var_277_28 + arg_277_0 then
				arg_274_1.var_.moveOldPos10022 = var_277_27.localPosition
				var_277_27.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("10022", 7)

				local var_277_29 = var_277_27.childCount

				for iter_277_2 = 0, var_277_29 - 1 do
					local var_277_30 = var_277_27:GetChild(iter_277_2)

					if var_277_30.name == "" or not string.find(var_277_30.name, "split") then
						var_277_30.gameObject:SetActive(true)
					else
						var_277_30.gameObject:SetActive(false)
					end
				end
			end

			local var_277_31 = 0.001

			if var_277_28 <= arg_274_1.time_ and arg_274_1.time_ < var_277_28 + var_277_31 then
				local var_277_32 = (arg_274_1.time_ - var_277_28) / var_277_31
				local var_277_33 = Vector3.New(0, -2000, 0)

				var_277_27.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos10022, var_277_33, var_277_32)
			end

			if arg_274_1.time_ >= var_277_28 + var_277_31 and arg_274_1.time_ < var_277_28 + var_277_31 + arg_277_0 then
				var_277_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_277_34 = arg_274_1.actors_["10092"].transform
			local var_277_35 = 1.966

			if var_277_35 < arg_274_1.time_ and arg_274_1.time_ <= var_277_35 + arg_277_0 then
				arg_274_1.var_.moveOldPos10092 = var_277_34.localPosition
				var_277_34.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("10092", 7)

				local var_277_36 = var_277_34.childCount

				for iter_277_3 = 0, var_277_36 - 1 do
					local var_277_37 = var_277_34:GetChild(iter_277_3)

					if var_277_37.name == "" or not string.find(var_277_37.name, "split") then
						var_277_37.gameObject:SetActive(true)
					else
						var_277_37.gameObject:SetActive(false)
					end
				end
			end

			local var_277_38 = 0.001

			if var_277_35 <= arg_274_1.time_ and arg_274_1.time_ < var_277_35 + var_277_38 then
				local var_277_39 = (arg_274_1.time_ - var_277_35) / var_277_38
				local var_277_40 = Vector3.New(0, -2000, 0)

				var_277_34.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos10092, var_277_40, var_277_39)
			end

			if arg_274_1.time_ >= var_277_35 + var_277_38 and arg_274_1.time_ < var_277_35 + var_277_38 + arg_277_0 then
				var_277_34.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_277_41 = arg_274_1.actors_["10092"].transform
			local var_277_42 = 3.8

			if var_277_42 < arg_274_1.time_ and arg_274_1.time_ <= var_277_42 + arg_277_0 then
				arg_274_1.var_.moveOldPos10092 = var_277_41.localPosition
				var_277_41.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("10092", 3)

				local var_277_43 = var_277_41.childCount

				for iter_277_4 = 0, var_277_43 - 1 do
					local var_277_44 = var_277_41:GetChild(iter_277_4)

					if var_277_44.name == "" or not string.find(var_277_44.name, "split") then
						var_277_44.gameObject:SetActive(true)
					else
						var_277_44.gameObject:SetActive(false)
					end
				end
			end

			local var_277_45 = 0.001

			if var_277_42 <= arg_274_1.time_ and arg_274_1.time_ < var_277_42 + var_277_45 then
				local var_277_46 = (arg_274_1.time_ - var_277_42) / var_277_45
				local var_277_47 = Vector3.New(0, -300, -295)

				var_277_41.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos10092, var_277_47, var_277_46)
			end

			if arg_274_1.time_ >= var_277_42 + var_277_45 and arg_274_1.time_ < var_277_42 + var_277_45 + arg_277_0 then
				var_277_41.localPosition = Vector3.New(0, -300, -295)
			end

			local var_277_48 = arg_274_1.actors_["10022"]
			local var_277_49 = 1.966

			if var_277_49 < arg_274_1.time_ and arg_274_1.time_ <= var_277_49 + arg_277_0 and not isNil(var_277_48) and arg_274_1.var_.actorSpriteComps10022 == nil then
				arg_274_1.var_.actorSpriteComps10022 = var_277_48:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_50 = 0.034

			if var_277_49 <= arg_274_1.time_ and arg_274_1.time_ < var_277_49 + var_277_50 and not isNil(var_277_48) then
				local var_277_51 = (arg_274_1.time_ - var_277_49) / var_277_50

				if arg_274_1.var_.actorSpriteComps10022 then
					for iter_277_5, iter_277_6 in pairs(arg_274_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_277_6 then
							if arg_274_1.isInRecall_ then
								local var_277_52 = Mathf.Lerp(iter_277_6.color.r, arg_274_1.hightColor2.r, var_277_51)
								local var_277_53 = Mathf.Lerp(iter_277_6.color.g, arg_274_1.hightColor2.g, var_277_51)
								local var_277_54 = Mathf.Lerp(iter_277_6.color.b, arg_274_1.hightColor2.b, var_277_51)

								iter_277_6.color = Color.New(var_277_52, var_277_53, var_277_54)
							else
								local var_277_55 = Mathf.Lerp(iter_277_6.color.r, 0.5, var_277_51)

								iter_277_6.color = Color.New(var_277_55, var_277_55, var_277_55)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= var_277_49 + var_277_50 and arg_274_1.time_ < var_277_49 + var_277_50 + arg_277_0 and not isNil(var_277_48) and arg_274_1.var_.actorSpriteComps10022 then
				for iter_277_7, iter_277_8 in pairs(arg_274_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_277_8 then
						if arg_274_1.isInRecall_ then
							iter_277_8.color = arg_274_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_277_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_274_1.var_.actorSpriteComps10022 = nil
			end

			local var_277_56 = arg_274_1.actors_["10092"]
			local var_277_57 = 1.966

			if var_277_57 < arg_274_1.time_ and arg_274_1.time_ <= var_277_57 + arg_277_0 and not isNil(var_277_56) and arg_274_1.var_.actorSpriteComps10092 == nil then
				arg_274_1.var_.actorSpriteComps10092 = var_277_56:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_58 = 0.0340000000000009

			if var_277_57 <= arg_274_1.time_ and arg_274_1.time_ < var_277_57 + var_277_58 and not isNil(var_277_56) then
				local var_277_59 = (arg_274_1.time_ - var_277_57) / var_277_58

				if arg_274_1.var_.actorSpriteComps10092 then
					for iter_277_9, iter_277_10 in pairs(arg_274_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_277_10 then
							if arg_274_1.isInRecall_ then
								local var_277_60 = Mathf.Lerp(iter_277_10.color.r, arg_274_1.hightColor2.r, var_277_59)
								local var_277_61 = Mathf.Lerp(iter_277_10.color.g, arg_274_1.hightColor2.g, var_277_59)
								local var_277_62 = Mathf.Lerp(iter_277_10.color.b, arg_274_1.hightColor2.b, var_277_59)

								iter_277_10.color = Color.New(var_277_60, var_277_61, var_277_62)
							else
								local var_277_63 = Mathf.Lerp(iter_277_10.color.r, 0.5, var_277_59)

								iter_277_10.color = Color.New(var_277_63, var_277_63, var_277_63)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= var_277_57 + var_277_58 and arg_274_1.time_ < var_277_57 + var_277_58 + arg_277_0 and not isNil(var_277_56) and arg_274_1.var_.actorSpriteComps10092 then
				for iter_277_11, iter_277_12 in pairs(arg_274_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_277_12 then
						if arg_274_1.isInRecall_ then
							iter_277_12.color = arg_274_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_277_12.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_274_1.var_.actorSpriteComps10092 = nil
			end

			local var_277_64 = arg_274_1.actors_["10092"]
			local var_277_65 = 3.8

			if var_277_65 < arg_274_1.time_ and arg_274_1.time_ <= var_277_65 + arg_277_0 and not isNil(var_277_64) and arg_274_1.var_.actorSpriteComps10092 == nil then
				arg_274_1.var_.actorSpriteComps10092 = var_277_64:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_66 = 2

			if var_277_65 <= arg_274_1.time_ and arg_274_1.time_ < var_277_65 + var_277_66 and not isNil(var_277_64) then
				local var_277_67 = (arg_274_1.time_ - var_277_65) / var_277_66

				if arg_274_1.var_.actorSpriteComps10092 then
					for iter_277_13, iter_277_14 in pairs(arg_274_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_277_14 then
							if arg_274_1.isInRecall_ then
								local var_277_68 = Mathf.Lerp(iter_277_14.color.r, arg_274_1.hightColor1.r, var_277_67)
								local var_277_69 = Mathf.Lerp(iter_277_14.color.g, arg_274_1.hightColor1.g, var_277_67)
								local var_277_70 = Mathf.Lerp(iter_277_14.color.b, arg_274_1.hightColor1.b, var_277_67)

								iter_277_14.color = Color.New(var_277_68, var_277_69, var_277_70)
							else
								local var_277_71 = Mathf.Lerp(iter_277_14.color.r, 1, var_277_67)

								iter_277_14.color = Color.New(var_277_71, var_277_71, var_277_71)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= var_277_65 + var_277_66 and arg_274_1.time_ < var_277_65 + var_277_66 + arg_277_0 and not isNil(var_277_64) and arg_274_1.var_.actorSpriteComps10092 then
				for iter_277_15, iter_277_16 in pairs(arg_274_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_277_16 then
						if arg_274_1.isInRecall_ then
							iter_277_16.color = arg_274_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_277_16.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_274_1.var_.actorSpriteComps10092 = nil
			end

			local var_277_72 = arg_274_1.actors_["10092"]
			local var_277_73 = 3.8

			if var_277_73 < arg_274_1.time_ and arg_274_1.time_ <= var_277_73 + arg_277_0 then
				local var_277_74 = var_277_72:GetComponentInChildren(typeof(CanvasGroup))

				if var_277_74 then
					arg_274_1.var_.alphaOldValue10092 = var_277_74.alpha
					arg_274_1.var_.characterEffect10092 = var_277_74
				end

				arg_274_1.var_.alphaOldValue10092 = 0
			end

			local var_277_75 = 0.5

			if var_277_73 <= arg_274_1.time_ and arg_274_1.time_ < var_277_73 + var_277_75 then
				local var_277_76 = (arg_274_1.time_ - var_277_73) / var_277_75
				local var_277_77 = Mathf.Lerp(arg_274_1.var_.alphaOldValue10092, 1, var_277_76)

				if arg_274_1.var_.characterEffect10092 then
					arg_274_1.var_.characterEffect10092.alpha = var_277_77
				end
			end

			if arg_274_1.time_ >= var_277_73 + var_277_75 and arg_274_1.time_ < var_277_73 + var_277_75 + arg_277_0 and arg_274_1.var_.characterEffect10092 then
				arg_274_1.var_.characterEffect10092.alpha = 1
			end

			if arg_274_1.frameCnt_ <= 1 then
				arg_274_1.dialog_:SetActive(false)
			end

			local var_277_78 = 4
			local var_277_79 = 0.475

			if var_277_78 < arg_274_1.time_ and arg_274_1.time_ <= var_277_78 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0

				arg_274_1.dialog_:SetActive(true)

				arg_274_1.dialogCg_.alpha = 0

				local var_277_80 = LeanTween.value(arg_274_1.dialog_, 0, 1, 0.3)

				var_277_80:setOnUpdate(LuaHelper.FloatAction(function(arg_278_0)
					arg_274_1.dialogCg_.alpha = arg_278_0
				end))
				var_277_80:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_274_1.dialog_)
					var_277_80:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_274_1.duration_ = arg_274_1.duration_ + 0.3

				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_81 = arg_274_1:FormatText(StoryNameCfg[996].name)

				arg_274_1.leftNameTxt_.text = var_277_81

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_82 = arg_274_1:GetWordFromCfg(413021067)
				local var_277_83 = arg_274_1:FormatText(var_277_82.content)

				arg_274_1.text_.text = var_277_83

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_84 = 19
				local var_277_85 = utf8.len(var_277_83)
				local var_277_86 = var_277_84 <= 0 and var_277_79 or var_277_79 * (var_277_85 / var_277_84)

				if var_277_86 > 0 and var_277_79 < var_277_86 then
					arg_274_1.talkMaxDuration = var_277_86
					var_277_78 = var_277_78 + 0.3

					if var_277_86 + var_277_78 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_86 + var_277_78
					end
				end

				arg_274_1.text_.text = var_277_83
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021067", "story_v_out_413021.awb") ~= 0 then
					local var_277_87 = manager.audio:GetVoiceLength("story_v_out_413021", "413021067", "story_v_out_413021.awb") / 1000

					if var_277_87 + var_277_78 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_87 + var_277_78
					end

					if var_277_82.prefab_name ~= "" and arg_274_1.actors_[var_277_82.prefab_name] ~= nil then
						local var_277_88 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_82.prefab_name].transform, "story_v_out_413021", "413021067", "story_v_out_413021.awb")

						arg_274_1:RecordAudio("413021067", var_277_88)
						arg_274_1:RecordAudio("413021067", var_277_88)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_413021", "413021067", "story_v_out_413021.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_413021", "413021067", "story_v_out_413021.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_89 = var_277_78 + 0.3
			local var_277_90 = math.max(var_277_79, arg_274_1.talkMaxDuration)

			if var_277_89 <= arg_274_1.time_ and arg_274_1.time_ < var_277_89 + var_277_90 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_89) / var_277_90

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_89 + var_277_90 and arg_274_1.time_ < var_277_89 + var_277_90 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play413021068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 413021068
		arg_280_1.duration_ = 6.63

		local var_280_0 = {
			zh = 3.8,
			ja = 6.633
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
				arg_280_0:Play413021069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["10022"].transform
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.var_.moveOldPos10022 = var_283_0.localPosition
				var_283_0.localScale = Vector3.New(1, 1, 1)

				arg_280_1:CheckSpriteTmpPos("10022", 4)

				local var_283_2 = var_283_0.childCount

				for iter_283_0 = 0, var_283_2 - 1 do
					local var_283_3 = var_283_0:GetChild(iter_283_0)

					if var_283_3.name == "split_6" or not string.find(var_283_3.name, "split") then
						var_283_3.gameObject:SetActive(true)
					else
						var_283_3.gameObject:SetActive(false)
					end
				end
			end

			local var_283_4 = 0.001

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_4 then
				local var_283_5 = (arg_280_1.time_ - var_283_1) / var_283_4
				local var_283_6 = Vector3.New(390, -315, -320)

				var_283_0.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10022, var_283_6, var_283_5)
			end

			if arg_280_1.time_ >= var_283_1 + var_283_4 and arg_280_1.time_ < var_283_1 + var_283_4 + arg_283_0 then
				var_283_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_283_7 = arg_280_1.actors_["10092"].transform
			local var_283_8 = 0

			if var_283_8 < arg_280_1.time_ and arg_280_1.time_ <= var_283_8 + arg_283_0 then
				arg_280_1.var_.moveOldPos10092 = var_283_7.localPosition
				var_283_7.localScale = Vector3.New(1, 1, 1)

				arg_280_1:CheckSpriteTmpPos("10092", 2)

				local var_283_9 = var_283_7.childCount

				for iter_283_1 = 0, var_283_9 - 1 do
					local var_283_10 = var_283_7:GetChild(iter_283_1)

					if var_283_10.name == "" or not string.find(var_283_10.name, "split") then
						var_283_10.gameObject:SetActive(true)
					else
						var_283_10.gameObject:SetActive(false)
					end
				end
			end

			local var_283_11 = 0.001

			if var_283_8 <= arg_280_1.time_ and arg_280_1.time_ < var_283_8 + var_283_11 then
				local var_283_12 = (arg_280_1.time_ - var_283_8) / var_283_11
				local var_283_13 = Vector3.New(-389.49, -300, -295)

				var_283_7.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10092, var_283_13, var_283_12)
			end

			if arg_280_1.time_ >= var_283_8 + var_283_11 and arg_280_1.time_ < var_283_8 + var_283_11 + arg_283_0 then
				var_283_7.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_283_14 = arg_280_1.actors_["10022"]
			local var_283_15 = 0

			if var_283_15 < arg_280_1.time_ and arg_280_1.time_ <= var_283_15 + arg_283_0 and not isNil(var_283_14) and arg_280_1.var_.actorSpriteComps10022 == nil then
				arg_280_1.var_.actorSpriteComps10022 = var_283_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_16 = 2

			if var_283_15 <= arg_280_1.time_ and arg_280_1.time_ < var_283_15 + var_283_16 and not isNil(var_283_14) then
				local var_283_17 = (arg_280_1.time_ - var_283_15) / var_283_16

				if arg_280_1.var_.actorSpriteComps10022 then
					for iter_283_2, iter_283_3 in pairs(arg_280_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_283_3 then
							if arg_280_1.isInRecall_ then
								local var_283_18 = Mathf.Lerp(iter_283_3.color.r, arg_280_1.hightColor1.r, var_283_17)
								local var_283_19 = Mathf.Lerp(iter_283_3.color.g, arg_280_1.hightColor1.g, var_283_17)
								local var_283_20 = Mathf.Lerp(iter_283_3.color.b, arg_280_1.hightColor1.b, var_283_17)

								iter_283_3.color = Color.New(var_283_18, var_283_19, var_283_20)
							else
								local var_283_21 = Mathf.Lerp(iter_283_3.color.r, 1, var_283_17)

								iter_283_3.color = Color.New(var_283_21, var_283_21, var_283_21)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= var_283_15 + var_283_16 and arg_280_1.time_ < var_283_15 + var_283_16 + arg_283_0 and not isNil(var_283_14) and arg_280_1.var_.actorSpriteComps10022 then
				for iter_283_4, iter_283_5 in pairs(arg_280_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_283_5 then
						if arg_280_1.isInRecall_ then
							iter_283_5.color = arg_280_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_283_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_280_1.var_.actorSpriteComps10022 = nil
			end

			local var_283_22 = arg_280_1.actors_["10092"]
			local var_283_23 = 0

			if var_283_23 < arg_280_1.time_ and arg_280_1.time_ <= var_283_23 + arg_283_0 and not isNil(var_283_22) and arg_280_1.var_.actorSpriteComps10092 == nil then
				arg_280_1.var_.actorSpriteComps10092 = var_283_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_24 = 2

			if var_283_23 <= arg_280_1.time_ and arg_280_1.time_ < var_283_23 + var_283_24 and not isNil(var_283_22) then
				local var_283_25 = (arg_280_1.time_ - var_283_23) / var_283_24

				if arg_280_1.var_.actorSpriteComps10092 then
					for iter_283_6, iter_283_7 in pairs(arg_280_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_283_7 then
							if arg_280_1.isInRecall_ then
								local var_283_26 = Mathf.Lerp(iter_283_7.color.r, arg_280_1.hightColor2.r, var_283_25)
								local var_283_27 = Mathf.Lerp(iter_283_7.color.g, arg_280_1.hightColor2.g, var_283_25)
								local var_283_28 = Mathf.Lerp(iter_283_7.color.b, arg_280_1.hightColor2.b, var_283_25)

								iter_283_7.color = Color.New(var_283_26, var_283_27, var_283_28)
							else
								local var_283_29 = Mathf.Lerp(iter_283_7.color.r, 0.5, var_283_25)

								iter_283_7.color = Color.New(var_283_29, var_283_29, var_283_29)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= var_283_23 + var_283_24 and arg_280_1.time_ < var_283_23 + var_283_24 + arg_283_0 and not isNil(var_283_22) and arg_280_1.var_.actorSpriteComps10092 then
				for iter_283_8, iter_283_9 in pairs(arg_280_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_283_9 then
						if arg_280_1.isInRecall_ then
							iter_283_9.color = arg_280_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_283_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_280_1.var_.actorSpriteComps10092 = nil
			end

			local var_283_30 = 0
			local var_283_31 = 0.5

			if var_283_30 < arg_280_1.time_ and arg_280_1.time_ <= var_283_30 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_32 = arg_280_1:FormatText(StoryNameCfg[614].name)

				arg_280_1.leftNameTxt_.text = var_283_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_33 = arg_280_1:GetWordFromCfg(413021068)
				local var_283_34 = arg_280_1:FormatText(var_283_33.content)

				arg_280_1.text_.text = var_283_34

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_35 = 20
				local var_283_36 = utf8.len(var_283_34)
				local var_283_37 = var_283_35 <= 0 and var_283_31 or var_283_31 * (var_283_36 / var_283_35)

				if var_283_37 > 0 and var_283_31 < var_283_37 then
					arg_280_1.talkMaxDuration = var_283_37

					if var_283_37 + var_283_30 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_37 + var_283_30
					end
				end

				arg_280_1.text_.text = var_283_34
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021068", "story_v_out_413021.awb") ~= 0 then
					local var_283_38 = manager.audio:GetVoiceLength("story_v_out_413021", "413021068", "story_v_out_413021.awb") / 1000

					if var_283_38 + var_283_30 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_38 + var_283_30
					end

					if var_283_33.prefab_name ~= "" and arg_280_1.actors_[var_283_33.prefab_name] ~= nil then
						local var_283_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_33.prefab_name].transform, "story_v_out_413021", "413021068", "story_v_out_413021.awb")

						arg_280_1:RecordAudio("413021068", var_283_39)
						arg_280_1:RecordAudio("413021068", var_283_39)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_413021", "413021068", "story_v_out_413021.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_413021", "413021068", "story_v_out_413021.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_40 = math.max(var_283_31, arg_280_1.talkMaxDuration)

			if var_283_30 <= arg_280_1.time_ and arg_280_1.time_ < var_283_30 + var_283_40 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_30) / var_283_40

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_30 + var_283_40 and arg_280_1.time_ < var_283_30 + var_283_40 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play413021069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 413021069
		arg_284_1.duration_ = 10.53

		local var_284_0 = {
			zh = 4.5,
			ja = 10.533
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
				arg_284_0:Play413021070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["10092"].transform
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.var_.moveOldPos10092 = var_287_0.localPosition
				var_287_0.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("10092", 2)

				local var_287_2 = var_287_0.childCount

				for iter_287_0 = 0, var_287_2 - 1 do
					local var_287_3 = var_287_0:GetChild(iter_287_0)

					if var_287_3.name == "" or not string.find(var_287_3.name, "split") then
						var_287_3.gameObject:SetActive(true)
					else
						var_287_3.gameObject:SetActive(false)
					end
				end
			end

			local var_287_4 = 0.001

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_4 then
				local var_287_5 = (arg_284_1.time_ - var_287_1) / var_287_4
				local var_287_6 = Vector3.New(-389.49, -300, -295)

				var_287_0.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos10092, var_287_6, var_287_5)
			end

			if arg_284_1.time_ >= var_287_1 + var_287_4 and arg_284_1.time_ < var_287_1 + var_287_4 + arg_287_0 then
				var_287_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_287_7 = arg_284_1.actors_["10092"]
			local var_287_8 = 0

			if var_287_8 < arg_284_1.time_ and arg_284_1.time_ <= var_287_8 + arg_287_0 and not isNil(var_287_7) and arg_284_1.var_.actorSpriteComps10092 == nil then
				arg_284_1.var_.actorSpriteComps10092 = var_287_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_9 = 2

			if var_287_8 <= arg_284_1.time_ and arg_284_1.time_ < var_287_8 + var_287_9 and not isNil(var_287_7) then
				local var_287_10 = (arg_284_1.time_ - var_287_8) / var_287_9

				if arg_284_1.var_.actorSpriteComps10092 then
					for iter_287_1, iter_287_2 in pairs(arg_284_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_287_2 then
							if arg_284_1.isInRecall_ then
								local var_287_11 = Mathf.Lerp(iter_287_2.color.r, arg_284_1.hightColor1.r, var_287_10)
								local var_287_12 = Mathf.Lerp(iter_287_2.color.g, arg_284_1.hightColor1.g, var_287_10)
								local var_287_13 = Mathf.Lerp(iter_287_2.color.b, arg_284_1.hightColor1.b, var_287_10)

								iter_287_2.color = Color.New(var_287_11, var_287_12, var_287_13)
							else
								local var_287_14 = Mathf.Lerp(iter_287_2.color.r, 1, var_287_10)

								iter_287_2.color = Color.New(var_287_14, var_287_14, var_287_14)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= var_287_8 + var_287_9 and arg_284_1.time_ < var_287_8 + var_287_9 + arg_287_0 and not isNil(var_287_7) and arg_284_1.var_.actorSpriteComps10092 then
				for iter_287_3, iter_287_4 in pairs(arg_284_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_287_4 then
						if arg_284_1.isInRecall_ then
							iter_287_4.color = arg_284_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_287_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_284_1.var_.actorSpriteComps10092 = nil
			end

			local var_287_15 = arg_284_1.actors_["10022"]
			local var_287_16 = 0

			if var_287_16 < arg_284_1.time_ and arg_284_1.time_ <= var_287_16 + arg_287_0 and not isNil(var_287_15) and arg_284_1.var_.actorSpriteComps10022 == nil then
				arg_284_1.var_.actorSpriteComps10022 = var_287_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_17 = 2

			if var_287_16 <= arg_284_1.time_ and arg_284_1.time_ < var_287_16 + var_287_17 and not isNil(var_287_15) then
				local var_287_18 = (arg_284_1.time_ - var_287_16) / var_287_17

				if arg_284_1.var_.actorSpriteComps10022 then
					for iter_287_5, iter_287_6 in pairs(arg_284_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_287_6 then
							if arg_284_1.isInRecall_ then
								local var_287_19 = Mathf.Lerp(iter_287_6.color.r, arg_284_1.hightColor2.r, var_287_18)
								local var_287_20 = Mathf.Lerp(iter_287_6.color.g, arg_284_1.hightColor2.g, var_287_18)
								local var_287_21 = Mathf.Lerp(iter_287_6.color.b, arg_284_1.hightColor2.b, var_287_18)

								iter_287_6.color = Color.New(var_287_19, var_287_20, var_287_21)
							else
								local var_287_22 = Mathf.Lerp(iter_287_6.color.r, 0.5, var_287_18)

								iter_287_6.color = Color.New(var_287_22, var_287_22, var_287_22)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= var_287_16 + var_287_17 and arg_284_1.time_ < var_287_16 + var_287_17 + arg_287_0 and not isNil(var_287_15) and arg_284_1.var_.actorSpriteComps10022 then
				for iter_287_7, iter_287_8 in pairs(arg_284_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_287_8 then
						if arg_284_1.isInRecall_ then
							iter_287_8.color = arg_284_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_287_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_284_1.var_.actorSpriteComps10022 = nil
			end

			local var_287_23 = 0
			local var_287_24 = 0.575

			if var_287_23 < arg_284_1.time_ and arg_284_1.time_ <= var_287_23 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_25 = arg_284_1:FormatText(StoryNameCfg[996].name)

				arg_284_1.leftNameTxt_.text = var_287_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_26 = arg_284_1:GetWordFromCfg(413021069)
				local var_287_27 = arg_284_1:FormatText(var_287_26.content)

				arg_284_1.text_.text = var_287_27

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_28 = 23
				local var_287_29 = utf8.len(var_287_27)
				local var_287_30 = var_287_28 <= 0 and var_287_24 or var_287_24 * (var_287_29 / var_287_28)

				if var_287_30 > 0 and var_287_24 < var_287_30 then
					arg_284_1.talkMaxDuration = var_287_30

					if var_287_30 + var_287_23 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_30 + var_287_23
					end
				end

				arg_284_1.text_.text = var_287_27
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021069", "story_v_out_413021.awb") ~= 0 then
					local var_287_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021069", "story_v_out_413021.awb") / 1000

					if var_287_31 + var_287_23 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_31 + var_287_23
					end

					if var_287_26.prefab_name ~= "" and arg_284_1.actors_[var_287_26.prefab_name] ~= nil then
						local var_287_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_26.prefab_name].transform, "story_v_out_413021", "413021069", "story_v_out_413021.awb")

						arg_284_1:RecordAudio("413021069", var_287_32)
						arg_284_1:RecordAudio("413021069", var_287_32)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_413021", "413021069", "story_v_out_413021.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_413021", "413021069", "story_v_out_413021.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_33 = math.max(var_287_24, arg_284_1.talkMaxDuration)

			if var_287_23 <= arg_284_1.time_ and arg_284_1.time_ < var_287_23 + var_287_33 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_23) / var_287_33

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_23 + var_287_33 and arg_284_1.time_ < var_287_23 + var_287_33 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play413021070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 413021070
		arg_288_1.duration_ = 3.5

		local var_288_0 = {
			zh = 2.9,
			ja = 3.5
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
				arg_288_0:Play413021071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["10093"].transform
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1.var_.moveOldPos10093 = var_291_0.localPosition
				var_291_0.localScale = Vector3.New(1, 1, 1)

				arg_288_1:CheckSpriteTmpPos("10093", 2)

				local var_291_2 = var_291_0.childCount

				for iter_291_0 = 0, var_291_2 - 1 do
					local var_291_3 = var_291_0:GetChild(iter_291_0)

					if var_291_3.name == "split_6" or not string.find(var_291_3.name, "split") then
						var_291_3.gameObject:SetActive(true)
					else
						var_291_3.gameObject:SetActive(false)
					end
				end
			end

			local var_291_4 = 0.001

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_4 then
				local var_291_5 = (arg_288_1.time_ - var_291_1) / var_291_4
				local var_291_6 = Vector3.New(-390, -345, -245)

				var_291_0.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10093, var_291_6, var_291_5)
			end

			if arg_288_1.time_ >= var_291_1 + var_291_4 and arg_288_1.time_ < var_291_1 + var_291_4 + arg_291_0 then
				var_291_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_291_7 = arg_288_1.actors_["10093"]
			local var_291_8 = 0

			if var_291_8 < arg_288_1.time_ and arg_288_1.time_ <= var_291_8 + arg_291_0 and not isNil(var_291_7) and arg_288_1.var_.actorSpriteComps10093 == nil then
				arg_288_1.var_.actorSpriteComps10093 = var_291_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_9 = 2

			if var_291_8 <= arg_288_1.time_ and arg_288_1.time_ < var_291_8 + var_291_9 and not isNil(var_291_7) then
				local var_291_10 = (arg_288_1.time_ - var_291_8) / var_291_9

				if arg_288_1.var_.actorSpriteComps10093 then
					for iter_291_1, iter_291_2 in pairs(arg_288_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_291_2 then
							if arg_288_1.isInRecall_ then
								local var_291_11 = Mathf.Lerp(iter_291_2.color.r, arg_288_1.hightColor1.r, var_291_10)
								local var_291_12 = Mathf.Lerp(iter_291_2.color.g, arg_288_1.hightColor1.g, var_291_10)
								local var_291_13 = Mathf.Lerp(iter_291_2.color.b, arg_288_1.hightColor1.b, var_291_10)

								iter_291_2.color = Color.New(var_291_11, var_291_12, var_291_13)
							else
								local var_291_14 = Mathf.Lerp(iter_291_2.color.r, 1, var_291_10)

								iter_291_2.color = Color.New(var_291_14, var_291_14, var_291_14)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= var_291_8 + var_291_9 and arg_288_1.time_ < var_291_8 + var_291_9 + arg_291_0 and not isNil(var_291_7) and arg_288_1.var_.actorSpriteComps10093 then
				for iter_291_3, iter_291_4 in pairs(arg_288_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_291_4 then
						if arg_288_1.isInRecall_ then
							iter_291_4.color = arg_288_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_291_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_288_1.var_.actorSpriteComps10093 = nil
			end

			local var_291_15 = 0
			local var_291_16 = 0.3

			if var_291_15 < arg_288_1.time_ and arg_288_1.time_ <= var_291_15 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_17 = arg_288_1:FormatText(StoryNameCfg[28].name)

				arg_288_1.leftNameTxt_.text = var_291_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_18 = arg_288_1:GetWordFromCfg(413021070)
				local var_291_19 = arg_288_1:FormatText(var_291_18.content)

				arg_288_1.text_.text = var_291_19

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_20 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021070", "story_v_out_413021.awb") ~= 0 then
					local var_291_23 = manager.audio:GetVoiceLength("story_v_out_413021", "413021070", "story_v_out_413021.awb") / 1000

					if var_291_23 + var_291_15 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_23 + var_291_15
					end

					if var_291_18.prefab_name ~= "" and arg_288_1.actors_[var_291_18.prefab_name] ~= nil then
						local var_291_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_18.prefab_name].transform, "story_v_out_413021", "413021070", "story_v_out_413021.awb")

						arg_288_1:RecordAudio("413021070", var_291_24)
						arg_288_1:RecordAudio("413021070", var_291_24)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_413021", "413021070", "story_v_out_413021.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_413021", "413021070", "story_v_out_413021.awb")
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
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play413021071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 413021071
		arg_292_1.duration_ = 7.13

		local var_292_0 = {
			zh = 4.4,
			ja = 7.133
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
				arg_292_0:Play413021072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["10092"].transform
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.var_.moveOldPos10092 = var_295_0.localPosition
				var_295_0.localScale = Vector3.New(1, 1, 1)

				arg_292_1:CheckSpriteTmpPos("10092", 4)

				local var_295_2 = var_295_0.childCount

				for iter_295_0 = 0, var_295_2 - 1 do
					local var_295_3 = var_295_0:GetChild(iter_295_0)

					if var_295_3.name == "split_2" or not string.find(var_295_3.name, "split") then
						var_295_3.gameObject:SetActive(true)
					else
						var_295_3.gameObject:SetActive(false)
					end
				end
			end

			local var_295_4 = 0.001

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_4 then
				local var_295_5 = (arg_292_1.time_ - var_295_1) / var_295_4
				local var_295_6 = Vector3.New(390, -300, -295)

				var_295_0.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10092, var_295_6, var_295_5)
			end

			if arg_292_1.time_ >= var_295_1 + var_295_4 and arg_292_1.time_ < var_295_1 + var_295_4 + arg_295_0 then
				var_295_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_295_7 = arg_292_1.actors_["10092"]
			local var_295_8 = 0

			if var_295_8 < arg_292_1.time_ and arg_292_1.time_ <= var_295_8 + arg_295_0 and not isNil(var_295_7) and arg_292_1.var_.actorSpriteComps10092 == nil then
				arg_292_1.var_.actorSpriteComps10092 = var_295_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_9 = 2

			if var_295_8 <= arg_292_1.time_ and arg_292_1.time_ < var_295_8 + var_295_9 and not isNil(var_295_7) then
				local var_295_10 = (arg_292_1.time_ - var_295_8) / var_295_9

				if arg_292_1.var_.actorSpriteComps10092 then
					for iter_295_1, iter_295_2 in pairs(arg_292_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_295_2 then
							if arg_292_1.isInRecall_ then
								local var_295_11 = Mathf.Lerp(iter_295_2.color.r, arg_292_1.hightColor1.r, var_295_10)
								local var_295_12 = Mathf.Lerp(iter_295_2.color.g, arg_292_1.hightColor1.g, var_295_10)
								local var_295_13 = Mathf.Lerp(iter_295_2.color.b, arg_292_1.hightColor1.b, var_295_10)

								iter_295_2.color = Color.New(var_295_11, var_295_12, var_295_13)
							else
								local var_295_14 = Mathf.Lerp(iter_295_2.color.r, 1, var_295_10)

								iter_295_2.color = Color.New(var_295_14, var_295_14, var_295_14)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= var_295_8 + var_295_9 and arg_292_1.time_ < var_295_8 + var_295_9 + arg_295_0 and not isNil(var_295_7) and arg_292_1.var_.actorSpriteComps10092 then
				for iter_295_3, iter_295_4 in pairs(arg_292_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_295_4 then
						if arg_292_1.isInRecall_ then
							iter_295_4.color = arg_292_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_295_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_292_1.var_.actorSpriteComps10092 = nil
			end

			local var_295_15 = arg_292_1.actors_["10093"]
			local var_295_16 = 0

			if var_295_16 < arg_292_1.time_ and arg_292_1.time_ <= var_295_16 + arg_295_0 and not isNil(var_295_15) and arg_292_1.var_.actorSpriteComps10093 == nil then
				arg_292_1.var_.actorSpriteComps10093 = var_295_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_17 = 2

			if var_295_16 <= arg_292_1.time_ and arg_292_1.time_ < var_295_16 + var_295_17 and not isNil(var_295_15) then
				local var_295_18 = (arg_292_1.time_ - var_295_16) / var_295_17

				if arg_292_1.var_.actorSpriteComps10093 then
					for iter_295_5, iter_295_6 in pairs(arg_292_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_295_6 then
							if arg_292_1.isInRecall_ then
								local var_295_19 = Mathf.Lerp(iter_295_6.color.r, arg_292_1.hightColor2.r, var_295_18)
								local var_295_20 = Mathf.Lerp(iter_295_6.color.g, arg_292_1.hightColor2.g, var_295_18)
								local var_295_21 = Mathf.Lerp(iter_295_6.color.b, arg_292_1.hightColor2.b, var_295_18)

								iter_295_6.color = Color.New(var_295_19, var_295_20, var_295_21)
							else
								local var_295_22 = Mathf.Lerp(iter_295_6.color.r, 0.5, var_295_18)

								iter_295_6.color = Color.New(var_295_22, var_295_22, var_295_22)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= var_295_16 + var_295_17 and arg_292_1.time_ < var_295_16 + var_295_17 + arg_295_0 and not isNil(var_295_15) and arg_292_1.var_.actorSpriteComps10093 then
				for iter_295_7, iter_295_8 in pairs(arg_292_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_295_8 then
						if arg_292_1.isInRecall_ then
							iter_295_8.color = arg_292_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_295_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_292_1.var_.actorSpriteComps10093 = nil
			end

			local var_295_23 = 0
			local var_295_24 = 0.4

			if var_295_23 < arg_292_1.time_ and arg_292_1.time_ <= var_295_23 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_25 = arg_292_1:FormatText(StoryNameCfg[996].name)

				arg_292_1.leftNameTxt_.text = var_295_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_26 = arg_292_1:GetWordFromCfg(413021071)
				local var_295_27 = arg_292_1:FormatText(var_295_26.content)

				arg_292_1.text_.text = var_295_27

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_28 = 16
				local var_295_29 = utf8.len(var_295_27)
				local var_295_30 = var_295_28 <= 0 and var_295_24 or var_295_24 * (var_295_29 / var_295_28)

				if var_295_30 > 0 and var_295_24 < var_295_30 then
					arg_292_1.talkMaxDuration = var_295_30

					if var_295_30 + var_295_23 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_30 + var_295_23
					end
				end

				arg_292_1.text_.text = var_295_27
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021071", "story_v_out_413021.awb") ~= 0 then
					local var_295_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021071", "story_v_out_413021.awb") / 1000

					if var_295_31 + var_295_23 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_31 + var_295_23
					end

					if var_295_26.prefab_name ~= "" and arg_292_1.actors_[var_295_26.prefab_name] ~= nil then
						local var_295_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_26.prefab_name].transform, "story_v_out_413021", "413021071", "story_v_out_413021.awb")

						arg_292_1:RecordAudio("413021071", var_295_32)
						arg_292_1:RecordAudio("413021071", var_295_32)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_413021", "413021071", "story_v_out_413021.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_413021", "413021071", "story_v_out_413021.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_33 = math.max(var_295_24, arg_292_1.talkMaxDuration)

			if var_295_23 <= arg_292_1.time_ and arg_292_1.time_ < var_295_23 + var_295_33 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_23) / var_295_33

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_23 + var_295_33 and arg_292_1.time_ < var_295_23 + var_295_33 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play413021072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 413021072
		arg_296_1.duration_ = 5.87

		local var_296_0 = {
			zh = 5.866,
			ja = 4.866
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
				arg_296_0:Play413021073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["10022"].transform
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.var_.moveOldPos10022 = var_299_0.localPosition
				var_299_0.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("10022", 4)

				local var_299_2 = var_299_0.childCount

				for iter_299_0 = 0, var_299_2 - 1 do
					local var_299_3 = var_299_0:GetChild(iter_299_0)

					if var_299_3.name == "split_3" or not string.find(var_299_3.name, "split") then
						var_299_3.gameObject:SetActive(true)
					else
						var_299_3.gameObject:SetActive(false)
					end
				end
			end

			local var_299_4 = 0.001

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_4 then
				local var_299_5 = (arg_296_1.time_ - var_299_1) / var_299_4
				local var_299_6 = Vector3.New(390, -315, -320)

				var_299_0.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10022, var_299_6, var_299_5)
			end

			if arg_296_1.time_ >= var_299_1 + var_299_4 and arg_296_1.time_ < var_299_1 + var_299_4 + arg_299_0 then
				var_299_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_299_7 = arg_296_1.actors_["10022"]
			local var_299_8 = 0

			if var_299_8 < arg_296_1.time_ and arg_296_1.time_ <= var_299_8 + arg_299_0 and not isNil(var_299_7) and arg_296_1.var_.actorSpriteComps10022 == nil then
				arg_296_1.var_.actorSpriteComps10022 = var_299_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_9 = 0.2

			if var_299_8 <= arg_296_1.time_ and arg_296_1.time_ < var_299_8 + var_299_9 and not isNil(var_299_7) then
				local var_299_10 = (arg_296_1.time_ - var_299_8) / var_299_9

				if arg_296_1.var_.actorSpriteComps10022 then
					for iter_299_1, iter_299_2 in pairs(arg_296_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_299_2 then
							if arg_296_1.isInRecall_ then
								local var_299_11 = Mathf.Lerp(iter_299_2.color.r, arg_296_1.hightColor1.r, var_299_10)
								local var_299_12 = Mathf.Lerp(iter_299_2.color.g, arg_296_1.hightColor1.g, var_299_10)
								local var_299_13 = Mathf.Lerp(iter_299_2.color.b, arg_296_1.hightColor1.b, var_299_10)

								iter_299_2.color = Color.New(var_299_11, var_299_12, var_299_13)
							else
								local var_299_14 = Mathf.Lerp(iter_299_2.color.r, 1, var_299_10)

								iter_299_2.color = Color.New(var_299_14, var_299_14, var_299_14)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= var_299_8 + var_299_9 and arg_296_1.time_ < var_299_8 + var_299_9 + arg_299_0 and not isNil(var_299_7) and arg_296_1.var_.actorSpriteComps10022 then
				for iter_299_3, iter_299_4 in pairs(arg_296_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_299_4 then
						if arg_296_1.isInRecall_ then
							iter_299_4.color = arg_296_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_299_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_296_1.var_.actorSpriteComps10022 = nil
			end

			local var_299_15 = arg_296_1.actors_["10092"]
			local var_299_16 = 0

			if var_299_16 < arg_296_1.time_ and arg_296_1.time_ <= var_299_16 + arg_299_0 and not isNil(var_299_15) and arg_296_1.var_.actorSpriteComps10092 == nil then
				arg_296_1.var_.actorSpriteComps10092 = var_299_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_17 = 0.2

			if var_299_16 <= arg_296_1.time_ and arg_296_1.time_ < var_299_16 + var_299_17 and not isNil(var_299_15) then
				local var_299_18 = (arg_296_1.time_ - var_299_16) / var_299_17

				if arg_296_1.var_.actorSpriteComps10092 then
					for iter_299_5, iter_299_6 in pairs(arg_296_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_299_6 then
							if arg_296_1.isInRecall_ then
								local var_299_19 = Mathf.Lerp(iter_299_6.color.r, arg_296_1.hightColor2.r, var_299_18)
								local var_299_20 = Mathf.Lerp(iter_299_6.color.g, arg_296_1.hightColor2.g, var_299_18)
								local var_299_21 = Mathf.Lerp(iter_299_6.color.b, arg_296_1.hightColor2.b, var_299_18)

								iter_299_6.color = Color.New(var_299_19, var_299_20, var_299_21)
							else
								local var_299_22 = Mathf.Lerp(iter_299_6.color.r, 0.5, var_299_18)

								iter_299_6.color = Color.New(var_299_22, var_299_22, var_299_22)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= var_299_16 + var_299_17 and arg_296_1.time_ < var_299_16 + var_299_17 + arg_299_0 and not isNil(var_299_15) and arg_296_1.var_.actorSpriteComps10092 then
				for iter_299_7, iter_299_8 in pairs(arg_296_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_299_8 then
						if arg_296_1.isInRecall_ then
							iter_299_8.color = arg_296_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_299_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_296_1.var_.actorSpriteComps10092 = nil
			end

			local var_299_23 = arg_296_1.actors_["10092"].transform
			local var_299_24 = 0

			if var_299_24 < arg_296_1.time_ and arg_296_1.time_ <= var_299_24 + arg_299_0 then
				arg_296_1.var_.moveOldPos10092 = var_299_23.localPosition
				var_299_23.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("10092", 7)

				local var_299_25 = var_299_23.childCount

				for iter_299_9 = 0, var_299_25 - 1 do
					local var_299_26 = var_299_23:GetChild(iter_299_9)

					if var_299_26.name == "split_2" or not string.find(var_299_26.name, "split") then
						var_299_26.gameObject:SetActive(true)
					else
						var_299_26.gameObject:SetActive(false)
					end
				end
			end

			local var_299_27 = 0.001

			if var_299_24 <= arg_296_1.time_ and arg_296_1.time_ < var_299_24 + var_299_27 then
				local var_299_28 = (arg_296_1.time_ - var_299_24) / var_299_27
				local var_299_29 = Vector3.New(0, -2000, 0)

				var_299_23.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10092, var_299_29, var_299_28)
			end

			if arg_296_1.time_ >= var_299_24 + var_299_27 and arg_296_1.time_ < var_299_24 + var_299_27 + arg_299_0 then
				var_299_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_299_30 = 0
			local var_299_31 = 0.65

			if var_299_30 < arg_296_1.time_ and arg_296_1.time_ <= var_299_30 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_32 = arg_296_1:FormatText(StoryNameCfg[614].name)

				arg_296_1.leftNameTxt_.text = var_299_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_33 = arg_296_1:GetWordFromCfg(413021072)
				local var_299_34 = arg_296_1:FormatText(var_299_33.content)

				arg_296_1.text_.text = var_299_34

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_35 = 26
				local var_299_36 = utf8.len(var_299_34)
				local var_299_37 = var_299_35 <= 0 and var_299_31 or var_299_31 * (var_299_36 / var_299_35)

				if var_299_37 > 0 and var_299_31 < var_299_37 then
					arg_296_1.talkMaxDuration = var_299_37

					if var_299_37 + var_299_30 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_37 + var_299_30
					end
				end

				arg_296_1.text_.text = var_299_34
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021072", "story_v_out_413021.awb") ~= 0 then
					local var_299_38 = manager.audio:GetVoiceLength("story_v_out_413021", "413021072", "story_v_out_413021.awb") / 1000

					if var_299_38 + var_299_30 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_38 + var_299_30
					end

					if var_299_33.prefab_name ~= "" and arg_296_1.actors_[var_299_33.prefab_name] ~= nil then
						local var_299_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_33.prefab_name].transform, "story_v_out_413021", "413021072", "story_v_out_413021.awb")

						arg_296_1:RecordAudio("413021072", var_299_39)
						arg_296_1:RecordAudio("413021072", var_299_39)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_413021", "413021072", "story_v_out_413021.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_413021", "413021072", "story_v_out_413021.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_40 = math.max(var_299_31, arg_296_1.talkMaxDuration)

			if var_299_30 <= arg_296_1.time_ and arg_296_1.time_ < var_299_30 + var_299_40 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_30) / var_299_40

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_30 + var_299_40 and arg_296_1.time_ < var_299_30 + var_299_40 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play413021073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 413021073
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play413021074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["10022"]
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.actorSpriteComps10022 == nil then
				arg_300_1.var_.actorSpriteComps10022 = var_303_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_2 = 2

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 and not isNil(var_303_0) then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2

				if arg_300_1.var_.actorSpriteComps10022 then
					for iter_303_0, iter_303_1 in pairs(arg_300_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_303_1 then
							if arg_300_1.isInRecall_ then
								local var_303_4 = Mathf.Lerp(iter_303_1.color.r, arg_300_1.hightColor2.r, var_303_3)
								local var_303_5 = Mathf.Lerp(iter_303_1.color.g, arg_300_1.hightColor2.g, var_303_3)
								local var_303_6 = Mathf.Lerp(iter_303_1.color.b, arg_300_1.hightColor2.b, var_303_3)

								iter_303_1.color = Color.New(var_303_4, var_303_5, var_303_6)
							else
								local var_303_7 = Mathf.Lerp(iter_303_1.color.r, 0.5, var_303_3)

								iter_303_1.color = Color.New(var_303_7, var_303_7, var_303_7)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.actorSpriteComps10022 then
				for iter_303_2, iter_303_3 in pairs(arg_300_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_303_3 then
						if arg_300_1.isInRecall_ then
							iter_303_3.color = arg_300_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_303_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_300_1.var_.actorSpriteComps10022 = nil
			end

			local var_303_8 = arg_300_1.actors_["10022"].transform
			local var_303_9 = 0

			if var_303_9 < arg_300_1.time_ and arg_300_1.time_ <= var_303_9 + arg_303_0 then
				arg_300_1.var_.moveOldPos10022 = var_303_8.localPosition
				var_303_8.localScale = Vector3.New(1, 1, 1)

				arg_300_1:CheckSpriteTmpPos("10022", 7)

				local var_303_10 = var_303_8.childCount

				for iter_303_4 = 0, var_303_10 - 1 do
					local var_303_11 = var_303_8:GetChild(iter_303_4)

					if var_303_11.name == "split_3" or not string.find(var_303_11.name, "split") then
						var_303_11.gameObject:SetActive(true)
					else
						var_303_11.gameObject:SetActive(false)
					end
				end
			end

			local var_303_12 = 0.001

			if var_303_9 <= arg_300_1.time_ and arg_300_1.time_ < var_303_9 + var_303_12 then
				local var_303_13 = (arg_300_1.time_ - var_303_9) / var_303_12
				local var_303_14 = Vector3.New(0, -2000, 0)

				var_303_8.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10022, var_303_14, var_303_13)
			end

			if arg_300_1.time_ >= var_303_9 + var_303_12 and arg_300_1.time_ < var_303_9 + var_303_12 + arg_303_0 then
				var_303_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_303_15 = arg_300_1.actors_["10093"].transform
			local var_303_16 = 0

			if var_303_16 < arg_300_1.time_ and arg_300_1.time_ <= var_303_16 + arg_303_0 then
				arg_300_1.var_.moveOldPos10093 = var_303_15.localPosition
				var_303_15.localScale = Vector3.New(1, 1, 1)

				arg_300_1:CheckSpriteTmpPos("10093", 7)

				local var_303_17 = var_303_15.childCount

				for iter_303_5 = 0, var_303_17 - 1 do
					local var_303_18 = var_303_15:GetChild(iter_303_5)

					if var_303_18.name == "split_2" or not string.find(var_303_18.name, "split") then
						var_303_18.gameObject:SetActive(true)
					else
						var_303_18.gameObject:SetActive(false)
					end
				end
			end

			local var_303_19 = 0.001

			if var_303_16 <= arg_300_1.time_ and arg_300_1.time_ < var_303_16 + var_303_19 then
				local var_303_20 = (arg_300_1.time_ - var_303_16) / var_303_19
				local var_303_21 = Vector3.New(0, -2000, 0)

				var_303_15.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10093, var_303_21, var_303_20)
			end

			if arg_300_1.time_ >= var_303_16 + var_303_19 and arg_300_1.time_ < var_303_16 + var_303_19 + arg_303_0 then
				var_303_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_303_22 = 0
			local var_303_23 = 1.45

			if var_303_22 < arg_300_1.time_ and arg_300_1.time_ <= var_303_22 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_24 = arg_300_1:GetWordFromCfg(413021073)
				local var_303_25 = arg_300_1:FormatText(var_303_24.content)

				arg_300_1.text_.text = var_303_25

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_26 = 58
				local var_303_27 = utf8.len(var_303_25)
				local var_303_28 = var_303_26 <= 0 and var_303_23 or var_303_23 * (var_303_27 / var_303_26)

				if var_303_28 > 0 and var_303_23 < var_303_28 then
					arg_300_1.talkMaxDuration = var_303_28

					if var_303_28 + var_303_22 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_28 + var_303_22
					end
				end

				arg_300_1.text_.text = var_303_25
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_29 = math.max(var_303_23, arg_300_1.talkMaxDuration)

			if var_303_22 <= arg_300_1.time_ and arg_300_1.time_ < var_303_22 + var_303_29 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_22) / var_303_29

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_22 + var_303_29 and arg_300_1.time_ < var_303_22 + var_303_29 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play413021074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 413021074
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play413021075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 1.35

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

				local var_307_2 = arg_304_1:GetWordFromCfg(413021074)
				local var_307_3 = arg_304_1:FormatText(var_307_2.content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 33
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
	Play413021075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 413021075
		arg_308_1.duration_ = 2.3

		local var_308_0 = {
			zh = 1.999999999999,
			ja = 2.3
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play413021076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["10093"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps10093 == nil then
				arg_308_1.var_.actorSpriteComps10093 = var_311_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_2 = 2

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.actorSpriteComps10093 then
					for iter_311_0, iter_311_1 in pairs(arg_308_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_311_1 then
							if arg_308_1.isInRecall_ then
								local var_311_4 = Mathf.Lerp(iter_311_1.color.r, arg_308_1.hightColor1.r, var_311_3)
								local var_311_5 = Mathf.Lerp(iter_311_1.color.g, arg_308_1.hightColor1.g, var_311_3)
								local var_311_6 = Mathf.Lerp(iter_311_1.color.b, arg_308_1.hightColor1.b, var_311_3)

								iter_311_1.color = Color.New(var_311_4, var_311_5, var_311_6)
							else
								local var_311_7 = Mathf.Lerp(iter_311_1.color.r, 1, var_311_3)

								iter_311_1.color = Color.New(var_311_7, var_311_7, var_311_7)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps10093 then
				for iter_311_2, iter_311_3 in pairs(arg_308_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_311_3 then
						if arg_308_1.isInRecall_ then
							iter_311_3.color = arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_311_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_308_1.var_.actorSpriteComps10093 = nil
			end

			local var_311_8 = arg_308_1.actors_["10093"].transform
			local var_311_9 = 0

			if var_311_9 < arg_308_1.time_ and arg_308_1.time_ <= var_311_9 + arg_311_0 then
				arg_308_1.var_.moveOldPos10093 = var_311_8.localPosition
				var_311_8.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("10093", 3)

				local var_311_10 = var_311_8.childCount

				for iter_311_4 = 0, var_311_10 - 1 do
					local var_311_11 = var_311_8:GetChild(iter_311_4)

					if var_311_11.name == "split_3" or not string.find(var_311_11.name, "split") then
						var_311_11.gameObject:SetActive(true)
					else
						var_311_11.gameObject:SetActive(false)
					end
				end
			end

			local var_311_12 = 0.001

			if var_311_9 <= arg_308_1.time_ and arg_308_1.time_ < var_311_9 + var_311_12 then
				local var_311_13 = (arg_308_1.time_ - var_311_9) / var_311_12
				local var_311_14 = Vector3.New(0, -345, -245)

				var_311_8.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10093, var_311_14, var_311_13)
			end

			if arg_308_1.time_ >= var_311_9 + var_311_12 and arg_308_1.time_ < var_311_9 + var_311_12 + arg_311_0 then
				var_311_8.localPosition = Vector3.New(0, -345, -245)
			end

			local var_311_15 = arg_308_1.actors_["10093"]
			local var_311_16 = 0

			if var_311_16 < arg_308_1.time_ and arg_308_1.time_ <= var_311_16 + arg_311_0 then
				local var_311_17 = var_311_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_311_17 then
					arg_308_1.var_.alphaOldValue10093 = var_311_17.alpha
					arg_308_1.var_.characterEffect10093 = var_311_17
				end

				arg_308_1.var_.alphaOldValue10093 = 0
			end

			local var_311_18 = 0.5

			if var_311_16 <= arg_308_1.time_ and arg_308_1.time_ < var_311_16 + var_311_18 then
				local var_311_19 = (arg_308_1.time_ - var_311_16) / var_311_18
				local var_311_20 = Mathf.Lerp(arg_308_1.var_.alphaOldValue10093, 1, var_311_19)

				if arg_308_1.var_.characterEffect10093 then
					arg_308_1.var_.characterEffect10093.alpha = var_311_20
				end
			end

			if arg_308_1.time_ >= var_311_16 + var_311_18 and arg_308_1.time_ < var_311_16 + var_311_18 + arg_311_0 and arg_308_1.var_.characterEffect10093 then
				arg_308_1.var_.characterEffect10093.alpha = 1
			end

			local var_311_21 = 0
			local var_311_22 = 0.225

			if var_311_21 < arg_308_1.time_ and arg_308_1.time_ <= var_311_21 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_23 = arg_308_1:FormatText(StoryNameCfg[28].name)

				arg_308_1.leftNameTxt_.text = var_311_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_24 = arg_308_1:GetWordFromCfg(413021075)
				local var_311_25 = arg_308_1:FormatText(var_311_24.content)

				arg_308_1.text_.text = var_311_25

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_26 = 9
				local var_311_27 = utf8.len(var_311_25)
				local var_311_28 = var_311_26 <= 0 and var_311_22 or var_311_22 * (var_311_27 / var_311_26)

				if var_311_28 > 0 and var_311_22 < var_311_28 then
					arg_308_1.talkMaxDuration = var_311_28

					if var_311_28 + var_311_21 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_28 + var_311_21
					end
				end

				arg_308_1.text_.text = var_311_25
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021075", "story_v_out_413021.awb") ~= 0 then
					local var_311_29 = manager.audio:GetVoiceLength("story_v_out_413021", "413021075", "story_v_out_413021.awb") / 1000

					if var_311_29 + var_311_21 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_29 + var_311_21
					end

					if var_311_24.prefab_name ~= "" and arg_308_1.actors_[var_311_24.prefab_name] ~= nil then
						local var_311_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_24.prefab_name].transform, "story_v_out_413021", "413021075", "story_v_out_413021.awb")

						arg_308_1:RecordAudio("413021075", var_311_30)
						arg_308_1:RecordAudio("413021075", var_311_30)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_413021", "413021075", "story_v_out_413021.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_413021", "413021075", "story_v_out_413021.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_31 = math.max(var_311_22, arg_308_1.talkMaxDuration)

			if var_311_21 <= arg_308_1.time_ and arg_308_1.time_ < var_311_21 + var_311_31 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_21) / var_311_31

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_21 + var_311_31 and arg_308_1.time_ < var_311_21 + var_311_31 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play413021076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 413021076
		arg_312_1.duration_ = 11.8

		local var_312_0 = {
			zh = 9.3,
			ja = 11.8
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
				arg_312_0:Play413021077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["10093"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps10093 == nil then
				arg_312_1.var_.actorSpriteComps10093 = var_315_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_2 = 2

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.actorSpriteComps10093 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_315_1 then
							if arg_312_1.isInRecall_ then
								local var_315_4 = Mathf.Lerp(iter_315_1.color.r, arg_312_1.hightColor2.r, var_315_3)
								local var_315_5 = Mathf.Lerp(iter_315_1.color.g, arg_312_1.hightColor2.g, var_315_3)
								local var_315_6 = Mathf.Lerp(iter_315_1.color.b, arg_312_1.hightColor2.b, var_315_3)

								iter_315_1.color = Color.New(var_315_4, var_315_5, var_315_6)
							else
								local var_315_7 = Mathf.Lerp(iter_315_1.color.r, 0.5, var_315_3)

								iter_315_1.color = Color.New(var_315_7, var_315_7, var_315_7)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps10093 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_315_3 then
						if arg_312_1.isInRecall_ then
							iter_315_3.color = arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_315_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_312_1.var_.actorSpriteComps10093 = nil
			end

			local var_315_8 = 0
			local var_315_9 = 0.55

			if var_315_8 < arg_312_1.time_ and arg_312_1.time_ <= var_315_8 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_10 = arg_312_1:FormatText(StoryNameCfg[995].name)

				arg_312_1.leftNameTxt_.text = var_315_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_11 = arg_312_1:GetWordFromCfg(413021076)
				local var_315_12 = arg_312_1:FormatText(var_315_11.content)

				arg_312_1.text_.text = var_315_12

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_13 = 22
				local var_315_14 = utf8.len(var_315_12)
				local var_315_15 = var_315_13 <= 0 and var_315_9 or var_315_9 * (var_315_14 / var_315_13)

				if var_315_15 > 0 and var_315_9 < var_315_15 then
					arg_312_1.talkMaxDuration = var_315_15

					if var_315_15 + var_315_8 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_15 + var_315_8
					end
				end

				arg_312_1.text_.text = var_315_12
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021076", "story_v_out_413021.awb") ~= 0 then
					local var_315_16 = manager.audio:GetVoiceLength("story_v_out_413021", "413021076", "story_v_out_413021.awb") / 1000

					if var_315_16 + var_315_8 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_16 + var_315_8
					end

					if var_315_11.prefab_name ~= "" and arg_312_1.actors_[var_315_11.prefab_name] ~= nil then
						local var_315_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_11.prefab_name].transform, "story_v_out_413021", "413021076", "story_v_out_413021.awb")

						arg_312_1:RecordAudio("413021076", var_315_17)
						arg_312_1:RecordAudio("413021076", var_315_17)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_413021", "413021076", "story_v_out_413021.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_413021", "413021076", "story_v_out_413021.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_18 = math.max(var_315_9, arg_312_1.talkMaxDuration)

			if var_315_8 <= arg_312_1.time_ and arg_312_1.time_ < var_315_8 + var_315_18 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_8) / var_315_18

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_8 + var_315_18 and arg_312_1.time_ < var_315_8 + var_315_18 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play413021077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 413021077
		arg_316_1.duration_ = 8.63

		local var_316_0 = {
			zh = 8.233,
			ja = 8.633
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
				arg_316_0:Play413021078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["10092"].transform
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.var_.moveOldPos10092 = var_319_0.localPosition
				var_319_0.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("10092", 3)

				local var_319_2 = var_319_0.childCount

				for iter_319_0 = 0, var_319_2 - 1 do
					local var_319_3 = var_319_0:GetChild(iter_319_0)

					if var_319_3.name == "split_2" or not string.find(var_319_3.name, "split") then
						var_319_3.gameObject:SetActive(true)
					else
						var_319_3.gameObject:SetActive(false)
					end
				end
			end

			local var_319_4 = 0.001

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_4 then
				local var_319_5 = (arg_316_1.time_ - var_319_1) / var_319_4
				local var_319_6 = Vector3.New(0, -300, -295)

				var_319_0.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10092, var_319_6, var_319_5)
			end

			if arg_316_1.time_ >= var_319_1 + var_319_4 and arg_316_1.time_ < var_319_1 + var_319_4 + arg_319_0 then
				var_319_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_319_7 = arg_316_1.actors_["10092"]
			local var_319_8 = 0

			if var_319_8 < arg_316_1.time_ and arg_316_1.time_ <= var_319_8 + arg_319_0 and not isNil(var_319_7) and arg_316_1.var_.actorSpriteComps10092 == nil then
				arg_316_1.var_.actorSpriteComps10092 = var_319_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_9 = 2

			if var_319_8 <= arg_316_1.time_ and arg_316_1.time_ < var_319_8 + var_319_9 and not isNil(var_319_7) then
				local var_319_10 = (arg_316_1.time_ - var_319_8) / var_319_9

				if arg_316_1.var_.actorSpriteComps10092 then
					for iter_319_1, iter_319_2 in pairs(arg_316_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_319_2 then
							if arg_316_1.isInRecall_ then
								local var_319_11 = Mathf.Lerp(iter_319_2.color.r, arg_316_1.hightColor1.r, var_319_10)
								local var_319_12 = Mathf.Lerp(iter_319_2.color.g, arg_316_1.hightColor1.g, var_319_10)
								local var_319_13 = Mathf.Lerp(iter_319_2.color.b, arg_316_1.hightColor1.b, var_319_10)

								iter_319_2.color = Color.New(var_319_11, var_319_12, var_319_13)
							else
								local var_319_14 = Mathf.Lerp(iter_319_2.color.r, 1, var_319_10)

								iter_319_2.color = Color.New(var_319_14, var_319_14, var_319_14)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= var_319_8 + var_319_9 and arg_316_1.time_ < var_319_8 + var_319_9 + arg_319_0 and not isNil(var_319_7) and arg_316_1.var_.actorSpriteComps10092 then
				for iter_319_3, iter_319_4 in pairs(arg_316_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_319_4 then
						if arg_316_1.isInRecall_ then
							iter_319_4.color = arg_316_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_319_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_316_1.var_.actorSpriteComps10092 = nil
			end

			local var_319_15 = 0
			local var_319_16 = 0.95

			if var_319_15 < arg_316_1.time_ and arg_316_1.time_ <= var_319_15 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_17 = arg_316_1:FormatText(StoryNameCfg[996].name)

				arg_316_1.leftNameTxt_.text = var_319_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_18 = arg_316_1:GetWordFromCfg(413021077)
				local var_319_19 = arg_316_1:FormatText(var_319_18.content)

				arg_316_1.text_.text = var_319_19

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_20 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021077", "story_v_out_413021.awb") ~= 0 then
					local var_319_23 = manager.audio:GetVoiceLength("story_v_out_413021", "413021077", "story_v_out_413021.awb") / 1000

					if var_319_23 + var_319_15 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_23 + var_319_15
					end

					if var_319_18.prefab_name ~= "" and arg_316_1.actors_[var_319_18.prefab_name] ~= nil then
						local var_319_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_18.prefab_name].transform, "story_v_out_413021", "413021077", "story_v_out_413021.awb")

						arg_316_1:RecordAudio("413021077", var_319_24)
						arg_316_1:RecordAudio("413021077", var_319_24)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_413021", "413021077", "story_v_out_413021.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_413021", "413021077", "story_v_out_413021.awb")
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
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play413021078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 413021078
		arg_320_1.duration_ = 9.2

		local var_320_0 = {
			zh = 5.566,
			ja = 9.2
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
				arg_320_0:Play413021079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["10092"].transform
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.var_.moveOldPos10092 = var_323_0.localPosition
				var_323_0.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("10092", 3)

				local var_323_2 = var_323_0.childCount

				for iter_323_0 = 0, var_323_2 - 1 do
					local var_323_3 = var_323_0:GetChild(iter_323_0)

					if var_323_3.name == "" or not string.find(var_323_3.name, "split") then
						var_323_3.gameObject:SetActive(true)
					else
						var_323_3.gameObject:SetActive(false)
					end
				end
			end

			local var_323_4 = 0.001

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_4 then
				local var_323_5 = (arg_320_1.time_ - var_323_1) / var_323_4
				local var_323_6 = Vector3.New(0, -300, -295)

				var_323_0.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos10092, var_323_6, var_323_5)
			end

			if arg_320_1.time_ >= var_323_1 + var_323_4 and arg_320_1.time_ < var_323_1 + var_323_4 + arg_323_0 then
				var_323_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_323_7 = arg_320_1.actors_["10092"]
			local var_323_8 = 0

			if var_323_8 < arg_320_1.time_ and arg_320_1.time_ <= var_323_8 + arg_323_0 and not isNil(var_323_7) and arg_320_1.var_.actorSpriteComps10092 == nil then
				arg_320_1.var_.actorSpriteComps10092 = var_323_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_323_9 = 2

			if var_323_8 <= arg_320_1.time_ and arg_320_1.time_ < var_323_8 + var_323_9 and not isNil(var_323_7) then
				local var_323_10 = (arg_320_1.time_ - var_323_8) / var_323_9

				if arg_320_1.var_.actorSpriteComps10092 then
					for iter_323_1, iter_323_2 in pairs(arg_320_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_323_2 then
							if arg_320_1.isInRecall_ then
								local var_323_11 = Mathf.Lerp(iter_323_2.color.r, arg_320_1.hightColor2.r, var_323_10)
								local var_323_12 = Mathf.Lerp(iter_323_2.color.g, arg_320_1.hightColor2.g, var_323_10)
								local var_323_13 = Mathf.Lerp(iter_323_2.color.b, arg_320_1.hightColor2.b, var_323_10)

								iter_323_2.color = Color.New(var_323_11, var_323_12, var_323_13)
							else
								local var_323_14 = Mathf.Lerp(iter_323_2.color.r, 0.5, var_323_10)

								iter_323_2.color = Color.New(var_323_14, var_323_14, var_323_14)
							end
						end
					end
				end
			end

			if arg_320_1.time_ >= var_323_8 + var_323_9 and arg_320_1.time_ < var_323_8 + var_323_9 + arg_323_0 and not isNil(var_323_7) and arg_320_1.var_.actorSpriteComps10092 then
				for iter_323_3, iter_323_4 in pairs(arg_320_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_323_4 then
						if arg_320_1.isInRecall_ then
							iter_323_4.color = arg_320_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_323_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_320_1.var_.actorSpriteComps10092 = nil
			end

			local var_323_15 = 0
			local var_323_16 = 0.4

			if var_323_15 < arg_320_1.time_ and arg_320_1.time_ <= var_323_15 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_17 = arg_320_1:FormatText(StoryNameCfg[995].name)

				arg_320_1.leftNameTxt_.text = var_323_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_18 = arg_320_1:GetWordFromCfg(413021078)
				local var_323_19 = arg_320_1:FormatText(var_323_18.content)

				arg_320_1.text_.text = var_323_19

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_20 = 16
				local var_323_21 = utf8.len(var_323_19)
				local var_323_22 = var_323_20 <= 0 and var_323_16 or var_323_16 * (var_323_21 / var_323_20)

				if var_323_22 > 0 and var_323_16 < var_323_22 then
					arg_320_1.talkMaxDuration = var_323_22

					if var_323_22 + var_323_15 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_22 + var_323_15
					end
				end

				arg_320_1.text_.text = var_323_19
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021078", "story_v_out_413021.awb") ~= 0 then
					local var_323_23 = manager.audio:GetVoiceLength("story_v_out_413021", "413021078", "story_v_out_413021.awb") / 1000

					if var_323_23 + var_323_15 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_23 + var_323_15
					end

					if var_323_18.prefab_name ~= "" and arg_320_1.actors_[var_323_18.prefab_name] ~= nil then
						local var_323_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_18.prefab_name].transform, "story_v_out_413021", "413021078", "story_v_out_413021.awb")

						arg_320_1:RecordAudio("413021078", var_323_24)
						arg_320_1:RecordAudio("413021078", var_323_24)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_413021", "413021078", "story_v_out_413021.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_413021", "413021078", "story_v_out_413021.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_25 = math.max(var_323_16, arg_320_1.talkMaxDuration)

			if var_323_15 <= arg_320_1.time_ and arg_320_1.time_ < var_323_15 + var_323_25 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_15) / var_323_25

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_15 + var_323_25 and arg_320_1.time_ < var_323_15 + var_323_25 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play413021079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 413021079
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play413021080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["10092"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.actorSpriteComps10092 == nil then
				arg_324_1.var_.actorSpriteComps10092 = var_327_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_327_2 = 2

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.actorSpriteComps10092 then
					for iter_327_0, iter_327_1 in pairs(arg_324_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_327_1 then
							if arg_324_1.isInRecall_ then
								local var_327_4 = Mathf.Lerp(iter_327_1.color.r, arg_324_1.hightColor2.r, var_327_3)
								local var_327_5 = Mathf.Lerp(iter_327_1.color.g, arg_324_1.hightColor2.g, var_327_3)
								local var_327_6 = Mathf.Lerp(iter_327_1.color.b, arg_324_1.hightColor2.b, var_327_3)

								iter_327_1.color = Color.New(var_327_4, var_327_5, var_327_6)
							else
								local var_327_7 = Mathf.Lerp(iter_327_1.color.r, 0.5, var_327_3)

								iter_327_1.color = Color.New(var_327_7, var_327_7, var_327_7)
							end
						end
					end
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.actorSpriteComps10092 then
				for iter_327_2, iter_327_3 in pairs(arg_324_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_327_3 then
						if arg_324_1.isInRecall_ then
							iter_327_3.color = arg_324_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_327_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_324_1.var_.actorSpriteComps10092 = nil
			end

			local var_327_8 = 0
			local var_327_9 = 0.575

			if var_327_8 < arg_324_1.time_ and arg_324_1.time_ <= var_327_8 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_10 = arg_324_1:GetWordFromCfg(413021079)
				local var_327_11 = arg_324_1:FormatText(var_327_10.content)

				arg_324_1.text_.text = var_327_11

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_12 = 23
				local var_327_13 = utf8.len(var_327_11)
				local var_327_14 = var_327_12 <= 0 and var_327_9 or var_327_9 * (var_327_13 / var_327_12)

				if var_327_14 > 0 and var_327_9 < var_327_14 then
					arg_324_1.talkMaxDuration = var_327_14

					if var_327_14 + var_327_8 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_14 + var_327_8
					end
				end

				arg_324_1.text_.text = var_327_11
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_15 = math.max(var_327_9, arg_324_1.talkMaxDuration)

			if var_327_8 <= arg_324_1.time_ and arg_324_1.time_ < var_327_8 + var_327_15 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_8) / var_327_15

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_8 + var_327_15 and arg_324_1.time_ < var_327_8 + var_327_15 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play413021080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 413021080
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play413021081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["10092"].transform
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 then
				arg_328_1.var_.moveOldPos10092 = var_331_0.localPosition
				var_331_0.localScale = Vector3.New(1, 1, 1)

				arg_328_1:CheckSpriteTmpPos("10092", 7)

				local var_331_2 = var_331_0.childCount

				for iter_331_0 = 0, var_331_2 - 1 do
					local var_331_3 = var_331_0:GetChild(iter_331_0)

					if var_331_3.name == "split_2" or not string.find(var_331_3.name, "split") then
						var_331_3.gameObject:SetActive(true)
					else
						var_331_3.gameObject:SetActive(false)
					end
				end
			end

			local var_331_4 = 0.001

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_4 then
				local var_331_5 = (arg_328_1.time_ - var_331_1) / var_331_4
				local var_331_6 = Vector3.New(0, -2000, 0)

				var_331_0.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos10092, var_331_6, var_331_5)
			end

			if arg_328_1.time_ >= var_331_1 + var_331_4 and arg_328_1.time_ < var_331_1 + var_331_4 + arg_331_0 then
				var_331_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_331_7 = 0
			local var_331_8 = 0.85

			if var_331_7 < arg_328_1.time_ and arg_328_1.time_ <= var_331_7 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_9 = arg_328_1:GetWordFromCfg(413021080)
				local var_331_10 = arg_328_1:FormatText(var_331_9.content)

				arg_328_1.text_.text = var_331_10

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_11 = 34
				local var_331_12 = utf8.len(var_331_10)
				local var_331_13 = var_331_11 <= 0 and var_331_8 or var_331_8 * (var_331_12 / var_331_11)

				if var_331_13 > 0 and var_331_8 < var_331_13 then
					arg_328_1.talkMaxDuration = var_331_13

					if var_331_13 + var_331_7 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_13 + var_331_7
					end
				end

				arg_328_1.text_.text = var_331_10
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_14 = math.max(var_331_8, arg_328_1.talkMaxDuration)

			if var_331_7 <= arg_328_1.time_ and arg_328_1.time_ < var_331_7 + var_331_14 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_7) / var_331_14

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_7 + var_331_14 and arg_328_1.time_ < var_331_7 + var_331_14 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play413021081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 413021081
		arg_332_1.duration_ = 6.07

		local var_332_0 = {
			zh = 4.966,
			ja = 6.066
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
				arg_332_0:Play413021082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["10092"].transform
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.var_.moveOldPos10092 = var_335_0.localPosition
				var_335_0.localScale = Vector3.New(1, 1, 1)

				arg_332_1:CheckSpriteTmpPos("10092", 3)

				local var_335_2 = var_335_0.childCount

				for iter_335_0 = 0, var_335_2 - 1 do
					local var_335_3 = var_335_0:GetChild(iter_335_0)

					if var_335_3.name == "" or not string.find(var_335_3.name, "split") then
						var_335_3.gameObject:SetActive(true)
					else
						var_335_3.gameObject:SetActive(false)
					end
				end
			end

			local var_335_4 = 0.001

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_4 then
				local var_335_5 = (arg_332_1.time_ - var_335_1) / var_335_4
				local var_335_6 = Vector3.New(0, -300, -295)

				var_335_0.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10092, var_335_6, var_335_5)
			end

			if arg_332_1.time_ >= var_335_1 + var_335_4 and arg_332_1.time_ < var_335_1 + var_335_4 + arg_335_0 then
				var_335_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_335_7 = arg_332_1.actors_["10092"]
			local var_335_8 = 0

			if var_335_8 < arg_332_1.time_ and arg_332_1.time_ <= var_335_8 + arg_335_0 and not isNil(var_335_7) and arg_332_1.var_.actorSpriteComps10092 == nil then
				arg_332_1.var_.actorSpriteComps10092 = var_335_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_9 = 2

			if var_335_8 <= arg_332_1.time_ and arg_332_1.time_ < var_335_8 + var_335_9 and not isNil(var_335_7) then
				local var_335_10 = (arg_332_1.time_ - var_335_8) / var_335_9

				if arg_332_1.var_.actorSpriteComps10092 then
					for iter_335_1, iter_335_2 in pairs(arg_332_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_335_2 then
							if arg_332_1.isInRecall_ then
								local var_335_11 = Mathf.Lerp(iter_335_2.color.r, arg_332_1.hightColor1.r, var_335_10)
								local var_335_12 = Mathf.Lerp(iter_335_2.color.g, arg_332_1.hightColor1.g, var_335_10)
								local var_335_13 = Mathf.Lerp(iter_335_2.color.b, arg_332_1.hightColor1.b, var_335_10)

								iter_335_2.color = Color.New(var_335_11, var_335_12, var_335_13)
							else
								local var_335_14 = Mathf.Lerp(iter_335_2.color.r, 1, var_335_10)

								iter_335_2.color = Color.New(var_335_14, var_335_14, var_335_14)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= var_335_8 + var_335_9 and arg_332_1.time_ < var_335_8 + var_335_9 + arg_335_0 and not isNil(var_335_7) and arg_332_1.var_.actorSpriteComps10092 then
				for iter_335_3, iter_335_4 in pairs(arg_332_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_335_4 then
						if arg_332_1.isInRecall_ then
							iter_335_4.color = arg_332_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_335_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_332_1.var_.actorSpriteComps10092 = nil
			end

			local var_335_15 = 0
			local var_335_16 = 0.6

			if var_335_15 < arg_332_1.time_ and arg_332_1.time_ <= var_335_15 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_17 = arg_332_1:FormatText(StoryNameCfg[996].name)

				arg_332_1.leftNameTxt_.text = var_335_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_18 = arg_332_1:GetWordFromCfg(413021081)
				local var_335_19 = arg_332_1:FormatText(var_335_18.content)

				arg_332_1.text_.text = var_335_19

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_20 = 24
				local var_335_21 = utf8.len(var_335_19)
				local var_335_22 = var_335_20 <= 0 and var_335_16 or var_335_16 * (var_335_21 / var_335_20)

				if var_335_22 > 0 and var_335_16 < var_335_22 then
					arg_332_1.talkMaxDuration = var_335_22

					if var_335_22 + var_335_15 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_22 + var_335_15
					end
				end

				arg_332_1.text_.text = var_335_19
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021081", "story_v_out_413021.awb") ~= 0 then
					local var_335_23 = manager.audio:GetVoiceLength("story_v_out_413021", "413021081", "story_v_out_413021.awb") / 1000

					if var_335_23 + var_335_15 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_23 + var_335_15
					end

					if var_335_18.prefab_name ~= "" and arg_332_1.actors_[var_335_18.prefab_name] ~= nil then
						local var_335_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_18.prefab_name].transform, "story_v_out_413021", "413021081", "story_v_out_413021.awb")

						arg_332_1:RecordAudio("413021081", var_335_24)
						arg_332_1:RecordAudio("413021081", var_335_24)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_413021", "413021081", "story_v_out_413021.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_413021", "413021081", "story_v_out_413021.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_25 = math.max(var_335_16, arg_332_1.talkMaxDuration)

			if var_335_15 <= arg_332_1.time_ and arg_332_1.time_ < var_335_15 + var_335_25 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_15) / var_335_25

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_15 + var_335_25 and arg_332_1.time_ < var_335_15 + var_335_25 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play413021082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 413021082
		arg_336_1.duration_ = 11.67

		local var_336_0 = {
			zh = 10.566,
			ja = 11.666
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
				arg_336_0:Play413021083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["10092"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.actorSpriteComps10092 == nil then
				arg_336_1.var_.actorSpriteComps10092 = var_339_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_339_2 = 2

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.actorSpriteComps10092 then
					for iter_339_0, iter_339_1 in pairs(arg_336_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_339_1 then
							if arg_336_1.isInRecall_ then
								local var_339_4 = Mathf.Lerp(iter_339_1.color.r, arg_336_1.hightColor2.r, var_339_3)
								local var_339_5 = Mathf.Lerp(iter_339_1.color.g, arg_336_1.hightColor2.g, var_339_3)
								local var_339_6 = Mathf.Lerp(iter_339_1.color.b, arg_336_1.hightColor2.b, var_339_3)

								iter_339_1.color = Color.New(var_339_4, var_339_5, var_339_6)
							else
								local var_339_7 = Mathf.Lerp(iter_339_1.color.r, 0.5, var_339_3)

								iter_339_1.color = Color.New(var_339_7, var_339_7, var_339_7)
							end
						end
					end
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.actorSpriteComps10092 then
				for iter_339_2, iter_339_3 in pairs(arg_336_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_339_3 then
						if arg_336_1.isInRecall_ then
							iter_339_3.color = arg_336_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_339_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_336_1.var_.actorSpriteComps10092 = nil
			end

			local var_339_8 = 0
			local var_339_9 = 0.7

			if var_339_8 < arg_336_1.time_ and arg_336_1.time_ <= var_339_8 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_10 = arg_336_1:FormatText(StoryNameCfg[995].name)

				arg_336_1.leftNameTxt_.text = var_339_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_11 = arg_336_1:GetWordFromCfg(413021082)
				local var_339_12 = arg_336_1:FormatText(var_339_11.content)

				arg_336_1.text_.text = var_339_12

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_13 = 28
				local var_339_14 = utf8.len(var_339_12)
				local var_339_15 = var_339_13 <= 0 and var_339_9 or var_339_9 * (var_339_14 / var_339_13)

				if var_339_15 > 0 and var_339_9 < var_339_15 then
					arg_336_1.talkMaxDuration = var_339_15

					if var_339_15 + var_339_8 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_15 + var_339_8
					end
				end

				arg_336_1.text_.text = var_339_12
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021082", "story_v_out_413021.awb") ~= 0 then
					local var_339_16 = manager.audio:GetVoiceLength("story_v_out_413021", "413021082", "story_v_out_413021.awb") / 1000

					if var_339_16 + var_339_8 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_16 + var_339_8
					end

					if var_339_11.prefab_name ~= "" and arg_336_1.actors_[var_339_11.prefab_name] ~= nil then
						local var_339_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_11.prefab_name].transform, "story_v_out_413021", "413021082", "story_v_out_413021.awb")

						arg_336_1:RecordAudio("413021082", var_339_17)
						arg_336_1:RecordAudio("413021082", var_339_17)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_413021", "413021082", "story_v_out_413021.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_413021", "413021082", "story_v_out_413021.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_18 = math.max(var_339_9, arg_336_1.talkMaxDuration)

			if var_339_8 <= arg_336_1.time_ and arg_336_1.time_ < var_339_8 + var_339_18 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_8) / var_339_18

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_8 + var_339_18 and arg_336_1.time_ < var_339_8 + var_339_18 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play413021083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 413021083
		arg_340_1.duration_ = 2

		local var_340_0 = {
			zh = 1.999999999999,
			ja = 2
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play413021084(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["10093"].transform
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1.var_.moveOldPos10093 = var_343_0.localPosition
				var_343_0.localScale = Vector3.New(1, 1, 1)

				arg_340_1:CheckSpriteTmpPos("10093", 3)

				local var_343_2 = var_343_0.childCount

				for iter_343_0 = 0, var_343_2 - 1 do
					local var_343_3 = var_343_0:GetChild(iter_343_0)

					if var_343_3.name == "split_3" or not string.find(var_343_3.name, "split") then
						var_343_3.gameObject:SetActive(true)
					else
						var_343_3.gameObject:SetActive(false)
					end
				end
			end

			local var_343_4 = 0.001

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_4 then
				local var_343_5 = (arg_340_1.time_ - var_343_1) / var_343_4
				local var_343_6 = Vector3.New(0, -345, -245)

				var_343_0.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos10093, var_343_6, var_343_5)
			end

			if arg_340_1.time_ >= var_343_1 + var_343_4 and arg_340_1.time_ < var_343_1 + var_343_4 + arg_343_0 then
				var_343_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_343_7 = arg_340_1.actors_["10093"]
			local var_343_8 = 0

			if var_343_8 < arg_340_1.time_ and arg_340_1.time_ <= var_343_8 + arg_343_0 and not isNil(var_343_7) and arg_340_1.var_.actorSpriteComps10093 == nil then
				arg_340_1.var_.actorSpriteComps10093 = var_343_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_9 = 2

			if var_343_8 <= arg_340_1.time_ and arg_340_1.time_ < var_343_8 + var_343_9 and not isNil(var_343_7) then
				local var_343_10 = (arg_340_1.time_ - var_343_8) / var_343_9

				if arg_340_1.var_.actorSpriteComps10093 then
					for iter_343_1, iter_343_2 in pairs(arg_340_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_343_2 then
							if arg_340_1.isInRecall_ then
								local var_343_11 = Mathf.Lerp(iter_343_2.color.r, arg_340_1.hightColor1.r, var_343_10)
								local var_343_12 = Mathf.Lerp(iter_343_2.color.g, arg_340_1.hightColor1.g, var_343_10)
								local var_343_13 = Mathf.Lerp(iter_343_2.color.b, arg_340_1.hightColor1.b, var_343_10)

								iter_343_2.color = Color.New(var_343_11, var_343_12, var_343_13)
							else
								local var_343_14 = Mathf.Lerp(iter_343_2.color.r, 1, var_343_10)

								iter_343_2.color = Color.New(var_343_14, var_343_14, var_343_14)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= var_343_8 + var_343_9 and arg_340_1.time_ < var_343_8 + var_343_9 + arg_343_0 and not isNil(var_343_7) and arg_340_1.var_.actorSpriteComps10093 then
				for iter_343_3, iter_343_4 in pairs(arg_340_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_343_4 then
						if arg_340_1.isInRecall_ then
							iter_343_4.color = arg_340_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_343_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_340_1.var_.actorSpriteComps10093 = nil
			end

			local var_343_15 = 0
			local var_343_16 = 0.125

			if var_343_15 < arg_340_1.time_ and arg_340_1.time_ <= var_343_15 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_17 = arg_340_1:FormatText(StoryNameCfg[28].name)

				arg_340_1.leftNameTxt_.text = var_343_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_18 = arg_340_1:GetWordFromCfg(413021083)
				local var_343_19 = arg_340_1:FormatText(var_343_18.content)

				arg_340_1.text_.text = var_343_19

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_20 = 5
				local var_343_21 = utf8.len(var_343_19)
				local var_343_22 = var_343_20 <= 0 and var_343_16 or var_343_16 * (var_343_21 / var_343_20)

				if var_343_22 > 0 and var_343_16 < var_343_22 then
					arg_340_1.talkMaxDuration = var_343_22

					if var_343_22 + var_343_15 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_22 + var_343_15
					end
				end

				arg_340_1.text_.text = var_343_19
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021083", "story_v_out_413021.awb") ~= 0 then
					local var_343_23 = manager.audio:GetVoiceLength("story_v_out_413021", "413021083", "story_v_out_413021.awb") / 1000

					if var_343_23 + var_343_15 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_23 + var_343_15
					end

					if var_343_18.prefab_name ~= "" and arg_340_1.actors_[var_343_18.prefab_name] ~= nil then
						local var_343_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_18.prefab_name].transform, "story_v_out_413021", "413021083", "story_v_out_413021.awb")

						arg_340_1:RecordAudio("413021083", var_343_24)
						arg_340_1:RecordAudio("413021083", var_343_24)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_413021", "413021083", "story_v_out_413021.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_413021", "413021083", "story_v_out_413021.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_25 = math.max(var_343_16, arg_340_1.talkMaxDuration)

			if var_343_15 <= arg_340_1.time_ and arg_340_1.time_ < var_343_15 + var_343_25 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_15) / var_343_25

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_15 + var_343_25 and arg_340_1.time_ < var_343_15 + var_343_25 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play413021084 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 413021084
		arg_344_1.duration_ = 13.1

		local var_344_0 = {
			zh = 10.233,
			ja = 13.1
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
				arg_344_0:Play413021085(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["10093"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.actorSpriteComps10093 == nil then
				arg_344_1.var_.actorSpriteComps10093 = var_347_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_347_2 = 2

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.actorSpriteComps10093 then
					for iter_347_0, iter_347_1 in pairs(arg_344_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_347_1 then
							if arg_344_1.isInRecall_ then
								local var_347_4 = Mathf.Lerp(iter_347_1.color.r, arg_344_1.hightColor2.r, var_347_3)
								local var_347_5 = Mathf.Lerp(iter_347_1.color.g, arg_344_1.hightColor2.g, var_347_3)
								local var_347_6 = Mathf.Lerp(iter_347_1.color.b, arg_344_1.hightColor2.b, var_347_3)

								iter_347_1.color = Color.New(var_347_4, var_347_5, var_347_6)
							else
								local var_347_7 = Mathf.Lerp(iter_347_1.color.r, 0.5, var_347_3)

								iter_347_1.color = Color.New(var_347_7, var_347_7, var_347_7)
							end
						end
					end
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.actorSpriteComps10093 then
				for iter_347_2, iter_347_3 in pairs(arg_344_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_347_3 then
						if arg_344_1.isInRecall_ then
							iter_347_3.color = arg_344_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_347_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_344_1.var_.actorSpriteComps10093 = nil
			end

			local var_347_8 = 0
			local var_347_9 = 0.75

			if var_347_8 < arg_344_1.time_ and arg_344_1.time_ <= var_347_8 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_10 = arg_344_1:FormatText(StoryNameCfg[995].name)

				arg_344_1.leftNameTxt_.text = var_347_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_11 = arg_344_1:GetWordFromCfg(413021084)
				local var_347_12 = arg_344_1:FormatText(var_347_11.content)

				arg_344_1.text_.text = var_347_12

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_13 = 30
				local var_347_14 = utf8.len(var_347_12)
				local var_347_15 = var_347_13 <= 0 and var_347_9 or var_347_9 * (var_347_14 / var_347_13)

				if var_347_15 > 0 and var_347_9 < var_347_15 then
					arg_344_1.talkMaxDuration = var_347_15

					if var_347_15 + var_347_8 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_15 + var_347_8
					end
				end

				arg_344_1.text_.text = var_347_12
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021084", "story_v_out_413021.awb") ~= 0 then
					local var_347_16 = manager.audio:GetVoiceLength("story_v_out_413021", "413021084", "story_v_out_413021.awb") / 1000

					if var_347_16 + var_347_8 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_16 + var_347_8
					end

					if var_347_11.prefab_name ~= "" and arg_344_1.actors_[var_347_11.prefab_name] ~= nil then
						local var_347_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_11.prefab_name].transform, "story_v_out_413021", "413021084", "story_v_out_413021.awb")

						arg_344_1:RecordAudio("413021084", var_347_17)
						arg_344_1:RecordAudio("413021084", var_347_17)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_413021", "413021084", "story_v_out_413021.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_413021", "413021084", "story_v_out_413021.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_18 = math.max(var_347_9, arg_344_1.talkMaxDuration)

			if var_347_8 <= arg_344_1.time_ and arg_344_1.time_ < var_347_8 + var_347_18 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_8) / var_347_18

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_8 + var_347_18 and arg_344_1.time_ < var_347_8 + var_347_18 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play413021085 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 413021085
		arg_348_1.duration_ = 8.17

		local var_348_0 = {
			zh = 8.166,
			ja = 7.466
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
				arg_348_0:Play413021086(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["10022"].transform
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.var_.moveOldPos10022 = var_351_0.localPosition
				var_351_0.localScale = Vector3.New(1, 1, 1)

				arg_348_1:CheckSpriteTmpPos("10022", 3)

				local var_351_2 = var_351_0.childCount

				for iter_351_0 = 0, var_351_2 - 1 do
					local var_351_3 = var_351_0:GetChild(iter_351_0)

					if var_351_3.name == "split_6" or not string.find(var_351_3.name, "split") then
						var_351_3.gameObject:SetActive(true)
					else
						var_351_3.gameObject:SetActive(false)
					end
				end
			end

			local var_351_4 = 0.001

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_4 then
				local var_351_5 = (arg_348_1.time_ - var_351_1) / var_351_4
				local var_351_6 = Vector3.New(0, -315, -320)

				var_351_0.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos10022, var_351_6, var_351_5)
			end

			if arg_348_1.time_ >= var_351_1 + var_351_4 and arg_348_1.time_ < var_351_1 + var_351_4 + arg_351_0 then
				var_351_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_351_7 = arg_348_1.actors_["10022"]
			local var_351_8 = 0

			if var_351_8 < arg_348_1.time_ and arg_348_1.time_ <= var_351_8 + arg_351_0 and not isNil(var_351_7) and arg_348_1.var_.actorSpriteComps10022 == nil then
				arg_348_1.var_.actorSpriteComps10022 = var_351_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_351_9 = 2

			if var_351_8 <= arg_348_1.time_ and arg_348_1.time_ < var_351_8 + var_351_9 and not isNil(var_351_7) then
				local var_351_10 = (arg_348_1.time_ - var_351_8) / var_351_9

				if arg_348_1.var_.actorSpriteComps10022 then
					for iter_351_1, iter_351_2 in pairs(arg_348_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_351_2 then
							if arg_348_1.isInRecall_ then
								local var_351_11 = Mathf.Lerp(iter_351_2.color.r, arg_348_1.hightColor1.r, var_351_10)
								local var_351_12 = Mathf.Lerp(iter_351_2.color.g, arg_348_1.hightColor1.g, var_351_10)
								local var_351_13 = Mathf.Lerp(iter_351_2.color.b, arg_348_1.hightColor1.b, var_351_10)

								iter_351_2.color = Color.New(var_351_11, var_351_12, var_351_13)
							else
								local var_351_14 = Mathf.Lerp(iter_351_2.color.r, 1, var_351_10)

								iter_351_2.color = Color.New(var_351_14, var_351_14, var_351_14)
							end
						end
					end
				end
			end

			if arg_348_1.time_ >= var_351_8 + var_351_9 and arg_348_1.time_ < var_351_8 + var_351_9 + arg_351_0 and not isNil(var_351_7) and arg_348_1.var_.actorSpriteComps10022 then
				for iter_351_3, iter_351_4 in pairs(arg_348_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_351_4 then
						if arg_348_1.isInRecall_ then
							iter_351_4.color = arg_348_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_351_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_348_1.var_.actorSpriteComps10022 = nil
			end

			local var_351_15 = 0
			local var_351_16 = 1

			if var_351_15 < arg_348_1.time_ and arg_348_1.time_ <= var_351_15 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_17 = arg_348_1:FormatText(StoryNameCfg[614].name)

				arg_348_1.leftNameTxt_.text = var_351_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_18 = arg_348_1:GetWordFromCfg(413021085)
				local var_351_19 = arg_348_1:FormatText(var_351_18.content)

				arg_348_1.text_.text = var_351_19

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_20 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021085", "story_v_out_413021.awb") ~= 0 then
					local var_351_23 = manager.audio:GetVoiceLength("story_v_out_413021", "413021085", "story_v_out_413021.awb") / 1000

					if var_351_23 + var_351_15 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_23 + var_351_15
					end

					if var_351_18.prefab_name ~= "" and arg_348_1.actors_[var_351_18.prefab_name] ~= nil then
						local var_351_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_18.prefab_name].transform, "story_v_out_413021", "413021085", "story_v_out_413021.awb")

						arg_348_1:RecordAudio("413021085", var_351_24)
						arg_348_1:RecordAudio("413021085", var_351_24)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_413021", "413021085", "story_v_out_413021.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_413021", "413021085", "story_v_out_413021.awb")
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play413021086 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 413021086
		arg_352_1.duration_ = 15.9

		local var_352_0 = {
			zh = 15.9,
			ja = 12.5
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
				arg_352_0:Play413021087(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["10022"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.actorSpriteComps10022 == nil then
				arg_352_1.var_.actorSpriteComps10022 = var_355_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_2 = 2

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.actorSpriteComps10022 then
					for iter_355_0, iter_355_1 in pairs(arg_352_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_355_1 then
							if arg_352_1.isInRecall_ then
								local var_355_4 = Mathf.Lerp(iter_355_1.color.r, arg_352_1.hightColor2.r, var_355_3)
								local var_355_5 = Mathf.Lerp(iter_355_1.color.g, arg_352_1.hightColor2.g, var_355_3)
								local var_355_6 = Mathf.Lerp(iter_355_1.color.b, arg_352_1.hightColor2.b, var_355_3)

								iter_355_1.color = Color.New(var_355_4, var_355_5, var_355_6)
							else
								local var_355_7 = Mathf.Lerp(iter_355_1.color.r, 0.5, var_355_3)

								iter_355_1.color = Color.New(var_355_7, var_355_7, var_355_7)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.actorSpriteComps10022 then
				for iter_355_2, iter_355_3 in pairs(arg_352_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_355_3 then
						if arg_352_1.isInRecall_ then
							iter_355_3.color = arg_352_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_355_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_352_1.var_.actorSpriteComps10022 = nil
			end

			local var_355_8 = 0
			local var_355_9 = 1.1

			if var_355_8 < arg_352_1.time_ and arg_352_1.time_ <= var_355_8 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_10 = arg_352_1:FormatText(StoryNameCfg[995].name)

				arg_352_1.leftNameTxt_.text = var_355_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_11 = arg_352_1:GetWordFromCfg(413021086)
				local var_355_12 = arg_352_1:FormatText(var_355_11.content)

				arg_352_1.text_.text = var_355_12

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_13 = 48
				local var_355_14 = utf8.len(var_355_12)
				local var_355_15 = var_355_13 <= 0 and var_355_9 or var_355_9 * (var_355_14 / var_355_13)

				if var_355_15 > 0 and var_355_9 < var_355_15 then
					arg_352_1.talkMaxDuration = var_355_15

					if var_355_15 + var_355_8 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_15 + var_355_8
					end
				end

				arg_352_1.text_.text = var_355_12
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021086", "story_v_out_413021.awb") ~= 0 then
					local var_355_16 = manager.audio:GetVoiceLength("story_v_out_413021", "413021086", "story_v_out_413021.awb") / 1000

					if var_355_16 + var_355_8 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_16 + var_355_8
					end

					if var_355_11.prefab_name ~= "" and arg_352_1.actors_[var_355_11.prefab_name] ~= nil then
						local var_355_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_11.prefab_name].transform, "story_v_out_413021", "413021086", "story_v_out_413021.awb")

						arg_352_1:RecordAudio("413021086", var_355_17)
						arg_352_1:RecordAudio("413021086", var_355_17)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_413021", "413021086", "story_v_out_413021.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_413021", "413021086", "story_v_out_413021.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_18 = math.max(var_355_9, arg_352_1.talkMaxDuration)

			if var_355_8 <= arg_352_1.time_ and arg_352_1.time_ < var_355_8 + var_355_18 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_8) / var_355_18

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_8 + var_355_18 and arg_352_1.time_ < var_355_8 + var_355_18 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play413021087 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 413021087
		arg_356_1.duration_ = 11.2

		local var_356_0 = {
			zh = 6.566,
			ja = 11.2
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
				arg_356_0:Play413021088(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0
			local var_359_1 = 0.875

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_2 = arg_356_1:FormatText(StoryNameCfg[993].name)

				arg_356_1.leftNameTxt_.text = var_359_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_3 = arg_356_1:GetWordFromCfg(413021087)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 35
				local var_359_6 = utf8.len(var_359_4)
				local var_359_7 = var_359_5 <= 0 and var_359_1 or var_359_1 * (var_359_6 / var_359_5)

				if var_359_7 > 0 and var_359_1 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021087", "story_v_out_413021.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021087", "story_v_out_413021.awb") / 1000

					if var_359_8 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_0
					end

					if var_359_3.prefab_name ~= "" and arg_356_1.actors_[var_359_3.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_3.prefab_name].transform, "story_v_out_413021", "413021087", "story_v_out_413021.awb")

						arg_356_1:RecordAudio("413021087", var_359_9)
						arg_356_1:RecordAudio("413021087", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_413021", "413021087", "story_v_out_413021.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_413021", "413021087", "story_v_out_413021.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_10 and arg_356_1.time_ < var_359_0 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play413021088 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 413021088
		arg_360_1.duration_ = 9.83

		local var_360_0 = {
			zh = 7.666,
			ja = 9.833
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
				arg_360_0:Play413021089(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 0.9

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_2 = arg_360_1:FormatText(StoryNameCfg[993].name)

				arg_360_1.leftNameTxt_.text = var_363_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_3 = arg_360_1:GetWordFromCfg(413021088)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 36
				local var_363_6 = utf8.len(var_363_4)
				local var_363_7 = var_363_5 <= 0 and var_363_1 or var_363_1 * (var_363_6 / var_363_5)

				if var_363_7 > 0 and var_363_1 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_4
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021088", "story_v_out_413021.awb") ~= 0 then
					local var_363_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021088", "story_v_out_413021.awb") / 1000

					if var_363_8 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_0
					end

					if var_363_3.prefab_name ~= "" and arg_360_1.actors_[var_363_3.prefab_name] ~= nil then
						local var_363_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_3.prefab_name].transform, "story_v_out_413021", "413021088", "story_v_out_413021.awb")

						arg_360_1:RecordAudio("413021088", var_363_9)
						arg_360_1:RecordAudio("413021088", var_363_9)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_413021", "413021088", "story_v_out_413021.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_413021", "413021088", "story_v_out_413021.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_10 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_10 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_10

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_10 and arg_360_1.time_ < var_363_0 + var_363_10 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play413021089 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 413021089
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play413021090(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["10022"].transform
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.var_.moveOldPos10022 = var_367_0.localPosition
				var_367_0.localScale = Vector3.New(1, 1, 1)

				arg_364_1:CheckSpriteTmpPos("10022", 7)

				local var_367_2 = var_367_0.childCount

				for iter_367_0 = 0, var_367_2 - 1 do
					local var_367_3 = var_367_0:GetChild(iter_367_0)

					if var_367_3.name == "" or not string.find(var_367_3.name, "split") then
						var_367_3.gameObject:SetActive(true)
					else
						var_367_3.gameObject:SetActive(false)
					end
				end
			end

			local var_367_4 = 0.001

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_4 then
				local var_367_5 = (arg_364_1.time_ - var_367_1) / var_367_4
				local var_367_6 = Vector3.New(0, -2000, 0)

				var_367_0.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos10022, var_367_6, var_367_5)
			end

			if arg_364_1.time_ >= var_367_1 + var_367_4 and arg_364_1.time_ < var_367_1 + var_367_4 + arg_367_0 then
				var_367_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_367_7 = arg_364_1.actors_["10022"]
			local var_367_8 = 0

			if var_367_8 < arg_364_1.time_ and arg_364_1.time_ <= var_367_8 + arg_367_0 and not isNil(var_367_7) and arg_364_1.var_.actorSpriteComps10022 == nil then
				arg_364_1.var_.actorSpriteComps10022 = var_367_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_367_9 = 2

			if var_367_8 <= arg_364_1.time_ and arg_364_1.time_ < var_367_8 + var_367_9 and not isNil(var_367_7) then
				local var_367_10 = (arg_364_1.time_ - var_367_8) / var_367_9

				if arg_364_1.var_.actorSpriteComps10022 then
					for iter_367_1, iter_367_2 in pairs(arg_364_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_367_2 then
							if arg_364_1.isInRecall_ then
								local var_367_11 = Mathf.Lerp(iter_367_2.color.r, arg_364_1.hightColor2.r, var_367_10)
								local var_367_12 = Mathf.Lerp(iter_367_2.color.g, arg_364_1.hightColor2.g, var_367_10)
								local var_367_13 = Mathf.Lerp(iter_367_2.color.b, arg_364_1.hightColor2.b, var_367_10)

								iter_367_2.color = Color.New(var_367_11, var_367_12, var_367_13)
							else
								local var_367_14 = Mathf.Lerp(iter_367_2.color.r, 0.5, var_367_10)

								iter_367_2.color = Color.New(var_367_14, var_367_14, var_367_14)
							end
						end
					end
				end
			end

			if arg_364_1.time_ >= var_367_8 + var_367_9 and arg_364_1.time_ < var_367_8 + var_367_9 + arg_367_0 and not isNil(var_367_7) and arg_364_1.var_.actorSpriteComps10022 then
				for iter_367_3, iter_367_4 in pairs(arg_364_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_367_4 then
						if arg_364_1.isInRecall_ then
							iter_367_4.color = arg_364_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_367_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_364_1.var_.actorSpriteComps10022 = nil
			end

			local var_367_15 = 0
			local var_367_16 = 0.775

			if var_367_15 < arg_364_1.time_ and arg_364_1.time_ <= var_367_15 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, false)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_17 = arg_364_1:GetWordFromCfg(413021089)
				local var_367_18 = arg_364_1:FormatText(var_367_17.content)

				arg_364_1.text_.text = var_367_18

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_19 = 31
				local var_367_20 = utf8.len(var_367_18)
				local var_367_21 = var_367_19 <= 0 and var_367_16 or var_367_16 * (var_367_20 / var_367_19)

				if var_367_21 > 0 and var_367_16 < var_367_21 then
					arg_364_1.talkMaxDuration = var_367_21

					if var_367_21 + var_367_15 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_21 + var_367_15
					end
				end

				arg_364_1.text_.text = var_367_18
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_22 = math.max(var_367_16, arg_364_1.talkMaxDuration)

			if var_367_15 <= arg_364_1.time_ and arg_364_1.time_ < var_367_15 + var_367_22 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_15) / var_367_22

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_15 + var_367_22 and arg_364_1.time_ < var_367_15 + var_367_22 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	Play413021090 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 413021090
		arg_368_1.duration_ = 13.4

		local var_368_0 = {
			zh = 9.266,
			ja = 13.4
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
				arg_368_0:Play413021091(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["10092"].transform
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 then
				arg_368_1.var_.moveOldPos10092 = var_371_0.localPosition
				var_371_0.localScale = Vector3.New(1, 1, 1)

				arg_368_1:CheckSpriteTmpPos("10092", 3)

				local var_371_2 = var_371_0.childCount

				for iter_371_0 = 0, var_371_2 - 1 do
					local var_371_3 = var_371_0:GetChild(iter_371_0)

					if var_371_3.name == "" or not string.find(var_371_3.name, "split") then
						var_371_3.gameObject:SetActive(true)
					else
						var_371_3.gameObject:SetActive(false)
					end
				end
			end

			local var_371_4 = 0.001

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_4 then
				local var_371_5 = (arg_368_1.time_ - var_371_1) / var_371_4
				local var_371_6 = Vector3.New(0, -300, -295)

				var_371_0.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos10092, var_371_6, var_371_5)
			end

			if arg_368_1.time_ >= var_371_1 + var_371_4 and arg_368_1.time_ < var_371_1 + var_371_4 + arg_371_0 then
				var_371_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_371_7 = arg_368_1.actors_["10092"]
			local var_371_8 = 0

			if var_371_8 < arg_368_1.time_ and arg_368_1.time_ <= var_371_8 + arg_371_0 and not isNil(var_371_7) and arg_368_1.var_.actorSpriteComps10092 == nil then
				arg_368_1.var_.actorSpriteComps10092 = var_371_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_371_9 = 2

			if var_371_8 <= arg_368_1.time_ and arg_368_1.time_ < var_371_8 + var_371_9 and not isNil(var_371_7) then
				local var_371_10 = (arg_368_1.time_ - var_371_8) / var_371_9

				if arg_368_1.var_.actorSpriteComps10092 then
					for iter_371_1, iter_371_2 in pairs(arg_368_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_371_2 then
							if arg_368_1.isInRecall_ then
								local var_371_11 = Mathf.Lerp(iter_371_2.color.r, arg_368_1.hightColor1.r, var_371_10)
								local var_371_12 = Mathf.Lerp(iter_371_2.color.g, arg_368_1.hightColor1.g, var_371_10)
								local var_371_13 = Mathf.Lerp(iter_371_2.color.b, arg_368_1.hightColor1.b, var_371_10)

								iter_371_2.color = Color.New(var_371_11, var_371_12, var_371_13)
							else
								local var_371_14 = Mathf.Lerp(iter_371_2.color.r, 1, var_371_10)

								iter_371_2.color = Color.New(var_371_14, var_371_14, var_371_14)
							end
						end
					end
				end
			end

			if arg_368_1.time_ >= var_371_8 + var_371_9 and arg_368_1.time_ < var_371_8 + var_371_9 + arg_371_0 and not isNil(var_371_7) and arg_368_1.var_.actorSpriteComps10092 then
				for iter_371_3, iter_371_4 in pairs(arg_368_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_371_4 then
						if arg_368_1.isInRecall_ then
							iter_371_4.color = arg_368_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_371_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_368_1.var_.actorSpriteComps10092 = nil
			end

			local var_371_15 = 0
			local var_371_16 = 1.15

			if var_371_15 < arg_368_1.time_ and arg_368_1.time_ <= var_371_15 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_17 = arg_368_1:FormatText(StoryNameCfg[996].name)

				arg_368_1.leftNameTxt_.text = var_371_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_18 = arg_368_1:GetWordFromCfg(413021090)
				local var_371_19 = arg_368_1:FormatText(var_371_18.content)

				arg_368_1.text_.text = var_371_19

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_20 = 46
				local var_371_21 = utf8.len(var_371_19)
				local var_371_22 = var_371_20 <= 0 and var_371_16 or var_371_16 * (var_371_21 / var_371_20)

				if var_371_22 > 0 and var_371_16 < var_371_22 then
					arg_368_1.talkMaxDuration = var_371_22

					if var_371_22 + var_371_15 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_22 + var_371_15
					end
				end

				arg_368_1.text_.text = var_371_19
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021090", "story_v_out_413021.awb") ~= 0 then
					local var_371_23 = manager.audio:GetVoiceLength("story_v_out_413021", "413021090", "story_v_out_413021.awb") / 1000

					if var_371_23 + var_371_15 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_23 + var_371_15
					end

					if var_371_18.prefab_name ~= "" and arg_368_1.actors_[var_371_18.prefab_name] ~= nil then
						local var_371_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_18.prefab_name].transform, "story_v_out_413021", "413021090", "story_v_out_413021.awb")

						arg_368_1:RecordAudio("413021090", var_371_24)
						arg_368_1:RecordAudio("413021090", var_371_24)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_413021", "413021090", "story_v_out_413021.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_413021", "413021090", "story_v_out_413021.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_25 = math.max(var_371_16, arg_368_1.talkMaxDuration)

			if var_371_15 <= arg_368_1.time_ and arg_368_1.time_ < var_371_15 + var_371_25 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_15) / var_371_25

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_15 + var_371_25 and arg_368_1.time_ < var_371_15 + var_371_25 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play413021091 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 413021091
		arg_372_1.duration_ = 5.43

		local var_372_0 = {
			zh = 5.433,
			ja = 5.066
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
				arg_372_0:Play413021092(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["10092"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.actorSpriteComps10092 == nil then
				arg_372_1.var_.actorSpriteComps10092 = var_375_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_375_2 = 2

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.actorSpriteComps10092 then
					for iter_375_0, iter_375_1 in pairs(arg_372_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_375_1 then
							if arg_372_1.isInRecall_ then
								local var_375_4 = Mathf.Lerp(iter_375_1.color.r, arg_372_1.hightColor2.r, var_375_3)
								local var_375_5 = Mathf.Lerp(iter_375_1.color.g, arg_372_1.hightColor2.g, var_375_3)
								local var_375_6 = Mathf.Lerp(iter_375_1.color.b, arg_372_1.hightColor2.b, var_375_3)

								iter_375_1.color = Color.New(var_375_4, var_375_5, var_375_6)
							else
								local var_375_7 = Mathf.Lerp(iter_375_1.color.r, 0.5, var_375_3)

								iter_375_1.color = Color.New(var_375_7, var_375_7, var_375_7)
							end
						end
					end
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.actorSpriteComps10092 then
				for iter_375_2, iter_375_3 in pairs(arg_372_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_375_3 then
						if arg_372_1.isInRecall_ then
							iter_375_3.color = arg_372_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_375_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_372_1.var_.actorSpriteComps10092 = nil
			end

			local var_375_8 = 0
			local var_375_9 = 0.375

			if var_375_8 < arg_372_1.time_ and arg_372_1.time_ <= var_375_8 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_10 = arg_372_1:FormatText(StoryNameCfg[995].name)

				arg_372_1.leftNameTxt_.text = var_375_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_11 = arg_372_1:GetWordFromCfg(413021091)
				local var_375_12 = arg_372_1:FormatText(var_375_11.content)

				arg_372_1.text_.text = var_375_12

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_13 = 15
				local var_375_14 = utf8.len(var_375_12)
				local var_375_15 = var_375_13 <= 0 and var_375_9 or var_375_9 * (var_375_14 / var_375_13)

				if var_375_15 > 0 and var_375_9 < var_375_15 then
					arg_372_1.talkMaxDuration = var_375_15

					if var_375_15 + var_375_8 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_15 + var_375_8
					end
				end

				arg_372_1.text_.text = var_375_12
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021091", "story_v_out_413021.awb") ~= 0 then
					local var_375_16 = manager.audio:GetVoiceLength("story_v_out_413021", "413021091", "story_v_out_413021.awb") / 1000

					if var_375_16 + var_375_8 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_16 + var_375_8
					end

					if var_375_11.prefab_name ~= "" and arg_372_1.actors_[var_375_11.prefab_name] ~= nil then
						local var_375_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_11.prefab_name].transform, "story_v_out_413021", "413021091", "story_v_out_413021.awb")

						arg_372_1:RecordAudio("413021091", var_375_17)
						arg_372_1:RecordAudio("413021091", var_375_17)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_413021", "413021091", "story_v_out_413021.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_413021", "413021091", "story_v_out_413021.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_18 = math.max(var_375_9, arg_372_1.talkMaxDuration)

			if var_375_8 <= arg_372_1.time_ and arg_372_1.time_ < var_375_8 + var_375_18 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_8) / var_375_18

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_8 + var_375_18 and arg_372_1.time_ < var_375_8 + var_375_18 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play413021092 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 413021092
		arg_376_1.duration_ = 1

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play413021093(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 0.05

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_2 = arg_376_1:FormatText(StoryNameCfg[36].name)

				arg_376_1.leftNameTxt_.text = var_379_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10098_split_1")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_3 = arg_376_1:GetWordFromCfg(413021092)
				local var_379_4 = arg_376_1:FormatText(var_379_3.content)

				arg_376_1.text_.text = var_379_4

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 2
				local var_379_6 = utf8.len(var_379_4)
				local var_379_7 = var_379_5 <= 0 and var_379_1 or var_379_1 * (var_379_6 / var_379_5)

				if var_379_7 > 0 and var_379_1 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_0
					end
				end

				arg_376_1.text_.text = var_379_4
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021092", "story_v_out_413021.awb") ~= 0 then
					local var_379_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021092", "story_v_out_413021.awb") / 1000

					if var_379_8 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_0
					end

					if var_379_3.prefab_name ~= "" and arg_376_1.actors_[var_379_3.prefab_name] ~= nil then
						local var_379_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_3.prefab_name].transform, "story_v_out_413021", "413021092", "story_v_out_413021.awb")

						arg_376_1:RecordAudio("413021092", var_379_9)
						arg_376_1:RecordAudio("413021092", var_379_9)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_413021", "413021092", "story_v_out_413021.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_413021", "413021092", "story_v_out_413021.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_10 = math.max(var_379_1, arg_376_1.talkMaxDuration)

			if var_379_0 <= arg_376_1.time_ and arg_376_1.time_ < var_379_0 + var_379_10 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_0) / var_379_10

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_0 + var_379_10 and arg_376_1.time_ < var_379_0 + var_379_10 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play413021093 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 413021093
		arg_380_1.duration_ = 6.53

		local var_380_0 = {
			zh = 5.733,
			ja = 6.533
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
				arg_380_0:Play413021094(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 0.475

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_2 = arg_380_1:FormatText(StoryNameCfg[995].name)

				arg_380_1.leftNameTxt_.text = var_383_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_3 = arg_380_1:GetWordFromCfg(413021093)
				local var_383_4 = arg_380_1:FormatText(var_383_3.content)

				arg_380_1.text_.text = var_383_4

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 19
				local var_383_6 = utf8.len(var_383_4)
				local var_383_7 = var_383_5 <= 0 and var_383_1 or var_383_1 * (var_383_6 / var_383_5)

				if var_383_7 > 0 and var_383_1 < var_383_7 then
					arg_380_1.talkMaxDuration = var_383_7

					if var_383_7 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_7 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_4
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021093", "story_v_out_413021.awb") ~= 0 then
					local var_383_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021093", "story_v_out_413021.awb") / 1000

					if var_383_8 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_8 + var_383_0
					end

					if var_383_3.prefab_name ~= "" and arg_380_1.actors_[var_383_3.prefab_name] ~= nil then
						local var_383_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_3.prefab_name].transform, "story_v_out_413021", "413021093", "story_v_out_413021.awb")

						arg_380_1:RecordAudio("413021093", var_383_9)
						arg_380_1:RecordAudio("413021093", var_383_9)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_413021", "413021093", "story_v_out_413021.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_413021", "413021093", "story_v_out_413021.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_10 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_10 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_10

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_10 and arg_380_1.time_ < var_383_0 + var_383_10 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play413021094 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 413021094
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play413021095(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["10092"].transform
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1.var_.moveOldPos10092 = var_387_0.localPosition
				var_387_0.localScale = Vector3.New(1, 1, 1)

				arg_384_1:CheckSpriteTmpPos("10092", 7)

				local var_387_2 = var_387_0.childCount

				for iter_387_0 = 0, var_387_2 - 1 do
					local var_387_3 = var_387_0:GetChild(iter_387_0)

					if var_387_3.name == "" or not string.find(var_387_3.name, "split") then
						var_387_3.gameObject:SetActive(true)
					else
						var_387_3.gameObject:SetActive(false)
					end
				end
			end

			local var_387_4 = 0.001

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_4 then
				local var_387_5 = (arg_384_1.time_ - var_387_1) / var_387_4
				local var_387_6 = Vector3.New(0, -2000, 0)

				var_387_0.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos10092, var_387_6, var_387_5)
			end

			if arg_384_1.time_ >= var_387_1 + var_387_4 and arg_384_1.time_ < var_387_1 + var_387_4 + arg_387_0 then
				var_387_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_387_7 = 0
			local var_387_8 = 1.325

			if var_387_7 < arg_384_1.time_ and arg_384_1.time_ <= var_387_7 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_9 = arg_384_1:GetWordFromCfg(413021094)
				local var_387_10 = arg_384_1:FormatText(var_387_9.content)

				arg_384_1.text_.text = var_387_10

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_11 = 53
				local var_387_12 = utf8.len(var_387_10)
				local var_387_13 = var_387_11 <= 0 and var_387_8 or var_387_8 * (var_387_12 / var_387_11)

				if var_387_13 > 0 and var_387_8 < var_387_13 then
					arg_384_1.talkMaxDuration = var_387_13

					if var_387_13 + var_387_7 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_13 + var_387_7
					end
				end

				arg_384_1.text_.text = var_387_10
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_14 = math.max(var_387_8, arg_384_1.talkMaxDuration)

			if var_387_7 <= arg_384_1.time_ and arg_384_1.time_ < var_387_7 + var_387_14 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_7) / var_387_14

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_7 + var_387_14 and arg_384_1.time_ < var_387_7 + var_387_14 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play413021095 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 413021095
		arg_388_1.duration_ = 3.5

		local var_388_0 = {
			zh = 3.5,
			ja = 2.933
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play413021096(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["10022"].transform
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.var_.moveOldPos10022 = var_391_0.localPosition
				var_391_0.localScale = Vector3.New(1, 1, 1)

				arg_388_1:CheckSpriteTmpPos("10022", 3)

				local var_391_2 = var_391_0.childCount

				for iter_391_0 = 0, var_391_2 - 1 do
					local var_391_3 = var_391_0:GetChild(iter_391_0)

					if var_391_3.name == "split_3" or not string.find(var_391_3.name, "split") then
						var_391_3.gameObject:SetActive(true)
					else
						var_391_3.gameObject:SetActive(false)
					end
				end
			end

			local var_391_4 = 0.001

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_4 then
				local var_391_5 = (arg_388_1.time_ - var_391_1) / var_391_4
				local var_391_6 = Vector3.New(0, -315, -320)

				var_391_0.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos10022, var_391_6, var_391_5)
			end

			if arg_388_1.time_ >= var_391_1 + var_391_4 and arg_388_1.time_ < var_391_1 + var_391_4 + arg_391_0 then
				var_391_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_391_7 = arg_388_1.actors_["10022"]
			local var_391_8 = 0

			if var_391_8 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 and not isNil(var_391_7) and arg_388_1.var_.actorSpriteComps10022 == nil then
				arg_388_1.var_.actorSpriteComps10022 = var_391_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_9 = 2

			if var_391_8 <= arg_388_1.time_ and arg_388_1.time_ < var_391_8 + var_391_9 and not isNil(var_391_7) then
				local var_391_10 = (arg_388_1.time_ - var_391_8) / var_391_9

				if arg_388_1.var_.actorSpriteComps10022 then
					for iter_391_1, iter_391_2 in pairs(arg_388_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_391_2 then
							if arg_388_1.isInRecall_ then
								local var_391_11 = Mathf.Lerp(iter_391_2.color.r, arg_388_1.hightColor1.r, var_391_10)
								local var_391_12 = Mathf.Lerp(iter_391_2.color.g, arg_388_1.hightColor1.g, var_391_10)
								local var_391_13 = Mathf.Lerp(iter_391_2.color.b, arg_388_1.hightColor1.b, var_391_10)

								iter_391_2.color = Color.New(var_391_11, var_391_12, var_391_13)
							else
								local var_391_14 = Mathf.Lerp(iter_391_2.color.r, 1, var_391_10)

								iter_391_2.color = Color.New(var_391_14, var_391_14, var_391_14)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= var_391_8 + var_391_9 and arg_388_1.time_ < var_391_8 + var_391_9 + arg_391_0 and not isNil(var_391_7) and arg_388_1.var_.actorSpriteComps10022 then
				for iter_391_3, iter_391_4 in pairs(arg_388_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_391_4 then
						if arg_388_1.isInRecall_ then
							iter_391_4.color = arg_388_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_391_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_388_1.var_.actorSpriteComps10022 = nil
			end

			local var_391_15 = 0
			local var_391_16 = 0.475

			if var_391_15 < arg_388_1.time_ and arg_388_1.time_ <= var_391_15 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_17 = arg_388_1:FormatText(StoryNameCfg[614].name)

				arg_388_1.leftNameTxt_.text = var_391_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_18 = arg_388_1:GetWordFromCfg(413021095)
				local var_391_19 = arg_388_1:FormatText(var_391_18.content)

				arg_388_1.text_.text = var_391_19

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_20 = 19
				local var_391_21 = utf8.len(var_391_19)
				local var_391_22 = var_391_20 <= 0 and var_391_16 or var_391_16 * (var_391_21 / var_391_20)

				if var_391_22 > 0 and var_391_16 < var_391_22 then
					arg_388_1.talkMaxDuration = var_391_22

					if var_391_22 + var_391_15 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_22 + var_391_15
					end
				end

				arg_388_1.text_.text = var_391_19
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021095", "story_v_out_413021.awb") ~= 0 then
					local var_391_23 = manager.audio:GetVoiceLength("story_v_out_413021", "413021095", "story_v_out_413021.awb") / 1000

					if var_391_23 + var_391_15 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_23 + var_391_15
					end

					if var_391_18.prefab_name ~= "" and arg_388_1.actors_[var_391_18.prefab_name] ~= nil then
						local var_391_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_18.prefab_name].transform, "story_v_out_413021", "413021095", "story_v_out_413021.awb")

						arg_388_1:RecordAudio("413021095", var_391_24)
						arg_388_1:RecordAudio("413021095", var_391_24)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_413021", "413021095", "story_v_out_413021.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_413021", "413021095", "story_v_out_413021.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_25 = math.max(var_391_16, arg_388_1.talkMaxDuration)

			if var_391_15 <= arg_388_1.time_ and arg_388_1.time_ < var_391_15 + var_391_25 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_15) / var_391_25

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_15 + var_391_25 and arg_388_1.time_ < var_391_15 + var_391_25 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play413021096 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 413021096
		arg_392_1.duration_ = 6.53

		local var_392_0 = {
			zh = 5.166,
			ja = 6.533
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
				arg_392_0:Play413021097(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["10022"]
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.actorSpriteComps10022 == nil then
				arg_392_1.var_.actorSpriteComps10022 = var_395_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_2 = 0.6

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 and not isNil(var_395_0) then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2

				if arg_392_1.var_.actorSpriteComps10022 then
					for iter_395_0, iter_395_1 in pairs(arg_392_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_395_1 then
							if arg_392_1.isInRecall_ then
								local var_395_4 = Mathf.Lerp(iter_395_1.color.r, arg_392_1.hightColor2.r, var_395_3)
								local var_395_5 = Mathf.Lerp(iter_395_1.color.g, arg_392_1.hightColor2.g, var_395_3)
								local var_395_6 = Mathf.Lerp(iter_395_1.color.b, arg_392_1.hightColor2.b, var_395_3)

								iter_395_1.color = Color.New(var_395_4, var_395_5, var_395_6)
							else
								local var_395_7 = Mathf.Lerp(iter_395_1.color.r, 0.5, var_395_3)

								iter_395_1.color = Color.New(var_395_7, var_395_7, var_395_7)
							end
						end
					end
				end
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.actorSpriteComps10022 then
				for iter_395_2, iter_395_3 in pairs(arg_392_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_395_3 then
						if arg_392_1.isInRecall_ then
							iter_395_3.color = arg_392_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_395_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_392_1.var_.actorSpriteComps10022 = nil
			end

			local var_395_8 = manager.ui.mainCamera.transform
			local var_395_9 = 0

			if var_395_9 < arg_392_1.time_ and arg_392_1.time_ <= var_395_9 + arg_395_0 then
				arg_392_1.var_.shakeOldPos = var_395_8.localPosition
			end

			local var_395_10 = 0.6

			if var_395_9 <= arg_392_1.time_ and arg_392_1.time_ < var_395_9 + var_395_10 then
				local var_395_11 = (arg_392_1.time_ - var_395_9) / 0.066
				local var_395_12, var_395_13 = math.modf(var_395_11)

				var_395_8.localPosition = Vector3.New(var_395_13 * 0.13, var_395_13 * 0.13, var_395_13 * 0.13) + arg_392_1.var_.shakeOldPos
			end

			if arg_392_1.time_ >= var_395_9 + var_395_10 and arg_392_1.time_ < var_395_9 + var_395_10 + arg_395_0 then
				var_395_8.localPosition = arg_392_1.var_.shakeOldPos
			end

			local var_395_14 = 0

			if var_395_14 < arg_392_1.time_ and arg_392_1.time_ <= var_395_14 + arg_395_0 then
				arg_392_1.allBtn_.enabled = false
			end

			local var_395_15 = 0.6

			if arg_392_1.time_ >= var_395_14 + var_395_15 and arg_392_1.time_ < var_395_14 + var_395_15 + arg_395_0 then
				arg_392_1.allBtn_.enabled = true
			end

			if arg_392_1.frameCnt_ <= 1 then
				arg_392_1.dialog_:SetActive(false)
			end

			local var_395_16 = 0.7
			local var_395_17 = 0.4

			if var_395_16 < arg_392_1.time_ and arg_392_1.time_ <= var_395_16 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0

				arg_392_1.dialog_:SetActive(true)

				arg_392_1.dialogCg_.alpha = 0

				local var_395_18 = LeanTween.value(arg_392_1.dialog_, 0, 1, 0.3)

				var_395_18:setOnUpdate(LuaHelper.FloatAction(function(arg_396_0)
					arg_392_1.dialogCg_.alpha = arg_396_0
				end))
				var_395_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_392_1.dialog_)
					var_395_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_392_1.duration_ = arg_392_1.duration_ + 0.3

				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_19 = arg_392_1:FormatText(StoryNameCfg[995].name)

				arg_392_1.leftNameTxt_.text = var_395_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_20 = arg_392_1:GetWordFromCfg(413021096)
				local var_395_21 = arg_392_1:FormatText(var_395_20.content)

				arg_392_1.text_.text = var_395_21

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_22 = 16
				local var_395_23 = utf8.len(var_395_21)
				local var_395_24 = var_395_22 <= 0 and var_395_17 or var_395_17 * (var_395_23 / var_395_22)

				if var_395_24 > 0 and var_395_17 < var_395_24 then
					arg_392_1.talkMaxDuration = var_395_24
					var_395_16 = var_395_16 + 0.3

					if var_395_24 + var_395_16 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_24 + var_395_16
					end
				end

				arg_392_1.text_.text = var_395_21
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021096", "story_v_out_413021.awb") ~= 0 then
					local var_395_25 = manager.audio:GetVoiceLength("story_v_out_413021", "413021096", "story_v_out_413021.awb") / 1000

					if var_395_25 + var_395_16 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_25 + var_395_16
					end

					if var_395_20.prefab_name ~= "" and arg_392_1.actors_[var_395_20.prefab_name] ~= nil then
						local var_395_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_20.prefab_name].transform, "story_v_out_413021", "413021096", "story_v_out_413021.awb")

						arg_392_1:RecordAudio("413021096", var_395_26)
						arg_392_1:RecordAudio("413021096", var_395_26)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_413021", "413021096", "story_v_out_413021.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_413021", "413021096", "story_v_out_413021.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_27 = var_395_16 + 0.3
			local var_395_28 = math.max(var_395_17, arg_392_1.talkMaxDuration)

			if var_395_27 <= arg_392_1.time_ and arg_392_1.time_ < var_395_27 + var_395_28 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_27) / var_395_28

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_27 + var_395_28 and arg_392_1.time_ < var_395_27 + var_395_28 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play413021097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 413021097
		arg_398_1.duration_ = 3.9

		local var_398_0 = {
			zh = 3.9,
			ja = 2.466
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play413021098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 0.15

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_2 = arg_398_1:FormatText(StoryNameCfg[1000].name)

				arg_398_1.leftNameTxt_.text = var_401_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_3 = arg_398_1:GetWordFromCfg(413021097)
				local var_401_4 = arg_398_1:FormatText(var_401_3.content)

				arg_398_1.text_.text = var_401_4

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 6
				local var_401_6 = utf8.len(var_401_4)
				local var_401_7 = var_401_5 <= 0 and var_401_1 or var_401_1 * (var_401_6 / var_401_5)

				if var_401_7 > 0 and var_401_1 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_4
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021097", "story_v_out_413021.awb") ~= 0 then
					local var_401_8 = manager.audio:GetVoiceLength("story_v_out_413021", "413021097", "story_v_out_413021.awb") / 1000

					if var_401_8 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_8 + var_401_0
					end

					if var_401_3.prefab_name ~= "" and arg_398_1.actors_[var_401_3.prefab_name] ~= nil then
						local var_401_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_3.prefab_name].transform, "story_v_out_413021", "413021097", "story_v_out_413021.awb")

						arg_398_1:RecordAudio("413021097", var_401_9)
						arg_398_1:RecordAudio("413021097", var_401_9)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_413021", "413021097", "story_v_out_413021.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_413021", "413021097", "story_v_out_413021.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_10 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_10 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_10

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_10 and arg_398_1.time_ < var_401_0 + var_401_10 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play413021098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 413021098
		arg_402_1.duration_ = 6.3

		local var_402_0 = {
			zh = 6.3,
			ja = 5.8
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play413021099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["10022"].transform
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1.var_.moveOldPos10022 = var_405_0.localPosition
				var_405_0.localScale = Vector3.New(1, 1, 1)

				arg_402_1:CheckSpriteTmpPos("10022", 3)

				local var_405_2 = var_405_0.childCount

				for iter_405_0 = 0, var_405_2 - 1 do
					local var_405_3 = var_405_0:GetChild(iter_405_0)

					if var_405_3.name == "split_6" or not string.find(var_405_3.name, "split") then
						var_405_3.gameObject:SetActive(true)
					else
						var_405_3.gameObject:SetActive(false)
					end
				end
			end

			local var_405_4 = 0.001

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_4 then
				local var_405_5 = (arg_402_1.time_ - var_405_1) / var_405_4
				local var_405_6 = Vector3.New(0, -315, -320)

				var_405_0.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos10022, var_405_6, var_405_5)
			end

			if arg_402_1.time_ >= var_405_1 + var_405_4 and arg_402_1.time_ < var_405_1 + var_405_4 + arg_405_0 then
				var_405_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_405_7 = arg_402_1.actors_["10022"]
			local var_405_8 = 0

			if var_405_8 < arg_402_1.time_ and arg_402_1.time_ <= var_405_8 + arg_405_0 and not isNil(var_405_7) and arg_402_1.var_.actorSpriteComps10022 == nil then
				arg_402_1.var_.actorSpriteComps10022 = var_405_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_9 = 2

			if var_405_8 <= arg_402_1.time_ and arg_402_1.time_ < var_405_8 + var_405_9 and not isNil(var_405_7) then
				local var_405_10 = (arg_402_1.time_ - var_405_8) / var_405_9

				if arg_402_1.var_.actorSpriteComps10022 then
					for iter_405_1, iter_405_2 in pairs(arg_402_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_405_2 then
							if arg_402_1.isInRecall_ then
								local var_405_11 = Mathf.Lerp(iter_405_2.color.r, arg_402_1.hightColor1.r, var_405_10)
								local var_405_12 = Mathf.Lerp(iter_405_2.color.g, arg_402_1.hightColor1.g, var_405_10)
								local var_405_13 = Mathf.Lerp(iter_405_2.color.b, arg_402_1.hightColor1.b, var_405_10)

								iter_405_2.color = Color.New(var_405_11, var_405_12, var_405_13)
							else
								local var_405_14 = Mathf.Lerp(iter_405_2.color.r, 1, var_405_10)

								iter_405_2.color = Color.New(var_405_14, var_405_14, var_405_14)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= var_405_8 + var_405_9 and arg_402_1.time_ < var_405_8 + var_405_9 + arg_405_0 and not isNil(var_405_7) and arg_402_1.var_.actorSpriteComps10022 then
				for iter_405_3, iter_405_4 in pairs(arg_402_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_405_4 then
						if arg_402_1.isInRecall_ then
							iter_405_4.color = arg_402_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_405_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_402_1.var_.actorSpriteComps10022 = nil
			end

			local var_405_15 = 0
			local var_405_16 = 0.85

			if var_405_15 < arg_402_1.time_ and arg_402_1.time_ <= var_405_15 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_17 = arg_402_1:FormatText(StoryNameCfg[614].name)

				arg_402_1.leftNameTxt_.text = var_405_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_18 = arg_402_1:GetWordFromCfg(413021098)
				local var_405_19 = arg_402_1:FormatText(var_405_18.content)

				arg_402_1.text_.text = var_405_19

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_20 = 34
				local var_405_21 = utf8.len(var_405_19)
				local var_405_22 = var_405_20 <= 0 and var_405_16 or var_405_16 * (var_405_21 / var_405_20)

				if var_405_22 > 0 and var_405_16 < var_405_22 then
					arg_402_1.talkMaxDuration = var_405_22

					if var_405_22 + var_405_15 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_22 + var_405_15
					end
				end

				arg_402_1.text_.text = var_405_19
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021098", "story_v_out_413021.awb") ~= 0 then
					local var_405_23 = manager.audio:GetVoiceLength("story_v_out_413021", "413021098", "story_v_out_413021.awb") / 1000

					if var_405_23 + var_405_15 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_23 + var_405_15
					end

					if var_405_18.prefab_name ~= "" and arg_402_1.actors_[var_405_18.prefab_name] ~= nil then
						local var_405_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_18.prefab_name].transform, "story_v_out_413021", "413021098", "story_v_out_413021.awb")

						arg_402_1:RecordAudio("413021098", var_405_24)
						arg_402_1:RecordAudio("413021098", var_405_24)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_413021", "413021098", "story_v_out_413021.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_413021", "413021098", "story_v_out_413021.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_25 = math.max(var_405_16, arg_402_1.talkMaxDuration)

			if var_405_15 <= arg_402_1.time_ and arg_402_1.time_ < var_405_15 + var_405_25 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_15) / var_405_25

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_15 + var_405_25 and arg_402_1.time_ < var_405_15 + var_405_25 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_402_1:InitPlayNodeList()
	end,
	Play413021099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 413021099
		arg_406_1.duration_ = 5.63

		local var_406_0 = {
			zh = 4.733,
			ja = 5.633
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play413021100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["10022"]
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.actorSpriteComps10022 == nil then
				arg_406_1.var_.actorSpriteComps10022 = var_409_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_409_2 = 2

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 and not isNil(var_409_0) then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2

				if arg_406_1.var_.actorSpriteComps10022 then
					for iter_409_0, iter_409_1 in pairs(arg_406_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_409_1 then
							if arg_406_1.isInRecall_ then
								local var_409_4 = Mathf.Lerp(iter_409_1.color.r, arg_406_1.hightColor2.r, var_409_3)
								local var_409_5 = Mathf.Lerp(iter_409_1.color.g, arg_406_1.hightColor2.g, var_409_3)
								local var_409_6 = Mathf.Lerp(iter_409_1.color.b, arg_406_1.hightColor2.b, var_409_3)

								iter_409_1.color = Color.New(var_409_4, var_409_5, var_409_6)
							else
								local var_409_7 = Mathf.Lerp(iter_409_1.color.r, 0.5, var_409_3)

								iter_409_1.color = Color.New(var_409_7, var_409_7, var_409_7)
							end
						end
					end
				end
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.actorSpriteComps10022 then
				for iter_409_2, iter_409_3 in pairs(arg_406_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_409_3 then
						if arg_406_1.isInRecall_ then
							iter_409_3.color = arg_406_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_409_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_406_1.var_.actorSpriteComps10022 = nil
			end

			local var_409_8 = 0
			local var_409_9 = 0.5

			if var_409_8 < arg_406_1.time_ and arg_406_1.time_ <= var_409_8 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_10 = arg_406_1:FormatText(StoryNameCfg[995].name)

				arg_406_1.leftNameTxt_.text = var_409_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_11 = arg_406_1:GetWordFromCfg(413021099)
				local var_409_12 = arg_406_1:FormatText(var_409_11.content)

				arg_406_1.text_.text = var_409_12

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_13 = 20
				local var_409_14 = utf8.len(var_409_12)
				local var_409_15 = var_409_13 <= 0 and var_409_9 or var_409_9 * (var_409_14 / var_409_13)

				if var_409_15 > 0 and var_409_9 < var_409_15 then
					arg_406_1.talkMaxDuration = var_409_15

					if var_409_15 + var_409_8 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_15 + var_409_8
					end
				end

				arg_406_1.text_.text = var_409_12
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021099", "story_v_out_413021.awb") ~= 0 then
					local var_409_16 = manager.audio:GetVoiceLength("story_v_out_413021", "413021099", "story_v_out_413021.awb") / 1000

					if var_409_16 + var_409_8 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_16 + var_409_8
					end

					if var_409_11.prefab_name ~= "" and arg_406_1.actors_[var_409_11.prefab_name] ~= nil then
						local var_409_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_11.prefab_name].transform, "story_v_out_413021", "413021099", "story_v_out_413021.awb")

						arg_406_1:RecordAudio("413021099", var_409_17)
						arg_406_1:RecordAudio("413021099", var_409_17)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_413021", "413021099", "story_v_out_413021.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_413021", "413021099", "story_v_out_413021.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_18 = math.max(var_409_9, arg_406_1.talkMaxDuration)

			if var_409_8 <= arg_406_1.time_ and arg_406_1.time_ < var_409_8 + var_409_18 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_8) / var_409_18

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_8 + var_409_18 and arg_406_1.time_ < var_409_8 + var_409_18 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play413021100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 413021100
		arg_410_1.duration_ = 7

		local var_410_0 = {
			zh = 4.666,
			ja = 7
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play413021101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["10092"].transform
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.var_.moveOldPos10092 = var_413_0.localPosition
				var_413_0.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("10092", 3)

				local var_413_2 = var_413_0.childCount

				for iter_413_0 = 0, var_413_2 - 1 do
					local var_413_3 = var_413_0:GetChild(iter_413_0)

					if var_413_3.name == "split_8" or not string.find(var_413_3.name, "split") then
						var_413_3.gameObject:SetActive(true)
					else
						var_413_3.gameObject:SetActive(false)
					end
				end
			end

			local var_413_4 = 0.001

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_4 then
				local var_413_5 = (arg_410_1.time_ - var_413_1) / var_413_4
				local var_413_6 = Vector3.New(0, -300, -295)

				var_413_0.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos10092, var_413_6, var_413_5)
			end

			if arg_410_1.time_ >= var_413_1 + var_413_4 and arg_410_1.time_ < var_413_1 + var_413_4 + arg_413_0 then
				var_413_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_413_7 = arg_410_1.actors_["10092"]
			local var_413_8 = 0

			if var_413_8 < arg_410_1.time_ and arg_410_1.time_ <= var_413_8 + arg_413_0 and not isNil(var_413_7) and arg_410_1.var_.actorSpriteComps10092 == nil then
				arg_410_1.var_.actorSpriteComps10092 = var_413_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_9 = 2

			if var_413_8 <= arg_410_1.time_ and arg_410_1.time_ < var_413_8 + var_413_9 and not isNil(var_413_7) then
				local var_413_10 = (arg_410_1.time_ - var_413_8) / var_413_9

				if arg_410_1.var_.actorSpriteComps10092 then
					for iter_413_1, iter_413_2 in pairs(arg_410_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_413_2 then
							if arg_410_1.isInRecall_ then
								local var_413_11 = Mathf.Lerp(iter_413_2.color.r, arg_410_1.hightColor1.r, var_413_10)
								local var_413_12 = Mathf.Lerp(iter_413_2.color.g, arg_410_1.hightColor1.g, var_413_10)
								local var_413_13 = Mathf.Lerp(iter_413_2.color.b, arg_410_1.hightColor1.b, var_413_10)

								iter_413_2.color = Color.New(var_413_11, var_413_12, var_413_13)
							else
								local var_413_14 = Mathf.Lerp(iter_413_2.color.r, 1, var_413_10)

								iter_413_2.color = Color.New(var_413_14, var_413_14, var_413_14)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= var_413_8 + var_413_9 and arg_410_1.time_ < var_413_8 + var_413_9 + arg_413_0 and not isNil(var_413_7) and arg_410_1.var_.actorSpriteComps10092 then
				for iter_413_3, iter_413_4 in pairs(arg_410_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_413_4 then
						if arg_410_1.isInRecall_ then
							iter_413_4.color = arg_410_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_413_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_410_1.var_.actorSpriteComps10092 = nil
			end

			local var_413_15 = 0
			local var_413_16 = 0.475

			if var_413_15 < arg_410_1.time_ and arg_410_1.time_ <= var_413_15 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_17 = arg_410_1:FormatText(StoryNameCfg[996].name)

				arg_410_1.leftNameTxt_.text = var_413_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_18 = arg_410_1:GetWordFromCfg(413021100)
				local var_413_19 = arg_410_1:FormatText(var_413_18.content)

				arg_410_1.text_.text = var_413_19

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_20 = 19
				local var_413_21 = utf8.len(var_413_19)
				local var_413_22 = var_413_20 <= 0 and var_413_16 or var_413_16 * (var_413_21 / var_413_20)

				if var_413_22 > 0 and var_413_16 < var_413_22 then
					arg_410_1.talkMaxDuration = var_413_22

					if var_413_22 + var_413_15 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_22 + var_413_15
					end
				end

				arg_410_1.text_.text = var_413_19
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021100", "story_v_out_413021.awb") ~= 0 then
					local var_413_23 = manager.audio:GetVoiceLength("story_v_out_413021", "413021100", "story_v_out_413021.awb") / 1000

					if var_413_23 + var_413_15 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_23 + var_413_15
					end

					if var_413_18.prefab_name ~= "" and arg_410_1.actors_[var_413_18.prefab_name] ~= nil then
						local var_413_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_18.prefab_name].transform, "story_v_out_413021", "413021100", "story_v_out_413021.awb")

						arg_410_1:RecordAudio("413021100", var_413_24)
						arg_410_1:RecordAudio("413021100", var_413_24)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_413021", "413021100", "story_v_out_413021.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_413021", "413021100", "story_v_out_413021.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_25 = math.max(var_413_16, arg_410_1.talkMaxDuration)

			if var_413_15 <= arg_410_1.time_ and arg_410_1.time_ < var_413_15 + var_413_25 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_15) / var_413_25

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_15 + var_413_25 and arg_410_1.time_ < var_413_15 + var_413_25 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play413021101 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 413021101
		arg_414_1.duration_ = 3.87

		local var_414_0 = {
			zh = 3.166,
			ja = 3.866
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play413021102(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["10092"].transform
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 then
				arg_414_1.var_.moveOldPos10092 = var_417_0.localPosition
				var_417_0.localScale = Vector3.New(1, 1, 1)

				arg_414_1:CheckSpriteTmpPos("10092", 2)

				local var_417_2 = var_417_0.childCount

				for iter_417_0 = 0, var_417_2 - 1 do
					local var_417_3 = var_417_0:GetChild(iter_417_0)

					if var_417_3.name == "" or not string.find(var_417_3.name, "split") then
						var_417_3.gameObject:SetActive(true)
					else
						var_417_3.gameObject:SetActive(false)
					end
				end
			end

			local var_417_4 = 0.001

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_4 then
				local var_417_5 = (arg_414_1.time_ - var_417_1) / var_417_4
				local var_417_6 = Vector3.New(-389.49, -300, -295)

				var_417_0.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos10092, var_417_6, var_417_5)
			end

			if arg_414_1.time_ >= var_417_1 + var_417_4 and arg_414_1.time_ < var_417_1 + var_417_4 + arg_417_0 then
				var_417_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_417_7 = arg_414_1.actors_["10022"].transform
			local var_417_8 = 0

			if var_417_8 < arg_414_1.time_ and arg_414_1.time_ <= var_417_8 + arg_417_0 then
				arg_414_1.var_.moveOldPos10022 = var_417_7.localPosition
				var_417_7.localScale = Vector3.New(1, 1, 1)

				arg_414_1:CheckSpriteTmpPos("10022", 4)

				local var_417_9 = var_417_7.childCount

				for iter_417_1 = 0, var_417_9 - 1 do
					local var_417_10 = var_417_7:GetChild(iter_417_1)

					if var_417_10.name == "split_3" or not string.find(var_417_10.name, "split") then
						var_417_10.gameObject:SetActive(true)
					else
						var_417_10.gameObject:SetActive(false)
					end
				end
			end

			local var_417_11 = 0.001

			if var_417_8 <= arg_414_1.time_ and arg_414_1.time_ < var_417_8 + var_417_11 then
				local var_417_12 = (arg_414_1.time_ - var_417_8) / var_417_11
				local var_417_13 = Vector3.New(390, -315, -320)

				var_417_7.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos10022, var_417_13, var_417_12)
			end

			if arg_414_1.time_ >= var_417_8 + var_417_11 and arg_414_1.time_ < var_417_8 + var_417_11 + arg_417_0 then
				var_417_7.localPosition = Vector3.New(390, -315, -320)
			end

			local var_417_14 = arg_414_1.actors_["10092"]
			local var_417_15 = 0

			if var_417_15 < arg_414_1.time_ and arg_414_1.time_ <= var_417_15 + arg_417_0 and not isNil(var_417_14) and arg_414_1.var_.actorSpriteComps10092 == nil then
				arg_414_1.var_.actorSpriteComps10092 = var_417_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_417_16 = 2

			if var_417_15 <= arg_414_1.time_ and arg_414_1.time_ < var_417_15 + var_417_16 and not isNil(var_417_14) then
				local var_417_17 = (arg_414_1.time_ - var_417_15) / var_417_16

				if arg_414_1.var_.actorSpriteComps10092 then
					for iter_417_2, iter_417_3 in pairs(arg_414_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_417_3 then
							if arg_414_1.isInRecall_ then
								local var_417_18 = Mathf.Lerp(iter_417_3.color.r, arg_414_1.hightColor2.r, var_417_17)
								local var_417_19 = Mathf.Lerp(iter_417_3.color.g, arg_414_1.hightColor2.g, var_417_17)
								local var_417_20 = Mathf.Lerp(iter_417_3.color.b, arg_414_1.hightColor2.b, var_417_17)

								iter_417_3.color = Color.New(var_417_18, var_417_19, var_417_20)
							else
								local var_417_21 = Mathf.Lerp(iter_417_3.color.r, 0.5, var_417_17)

								iter_417_3.color = Color.New(var_417_21, var_417_21, var_417_21)
							end
						end
					end
				end
			end

			if arg_414_1.time_ >= var_417_15 + var_417_16 and arg_414_1.time_ < var_417_15 + var_417_16 + arg_417_0 and not isNil(var_417_14) and arg_414_1.var_.actorSpriteComps10092 then
				for iter_417_4, iter_417_5 in pairs(arg_414_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_417_5 then
						if arg_414_1.isInRecall_ then
							iter_417_5.color = arg_414_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_417_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_414_1.var_.actorSpriteComps10092 = nil
			end

			local var_417_22 = arg_414_1.actors_["10022"]
			local var_417_23 = 0

			if var_417_23 < arg_414_1.time_ and arg_414_1.time_ <= var_417_23 + arg_417_0 and not isNil(var_417_22) and arg_414_1.var_.actorSpriteComps10022 == nil then
				arg_414_1.var_.actorSpriteComps10022 = var_417_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_417_24 = 2

			if var_417_23 <= arg_414_1.time_ and arg_414_1.time_ < var_417_23 + var_417_24 and not isNil(var_417_22) then
				local var_417_25 = (arg_414_1.time_ - var_417_23) / var_417_24

				if arg_414_1.var_.actorSpriteComps10022 then
					for iter_417_6, iter_417_7 in pairs(arg_414_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_417_7 then
							if arg_414_1.isInRecall_ then
								local var_417_26 = Mathf.Lerp(iter_417_7.color.r, arg_414_1.hightColor1.r, var_417_25)
								local var_417_27 = Mathf.Lerp(iter_417_7.color.g, arg_414_1.hightColor1.g, var_417_25)
								local var_417_28 = Mathf.Lerp(iter_417_7.color.b, arg_414_1.hightColor1.b, var_417_25)

								iter_417_7.color = Color.New(var_417_26, var_417_27, var_417_28)
							else
								local var_417_29 = Mathf.Lerp(iter_417_7.color.r, 1, var_417_25)

								iter_417_7.color = Color.New(var_417_29, var_417_29, var_417_29)
							end
						end
					end
				end
			end

			if arg_414_1.time_ >= var_417_23 + var_417_24 and arg_414_1.time_ < var_417_23 + var_417_24 + arg_417_0 and not isNil(var_417_22) and arg_414_1.var_.actorSpriteComps10022 then
				for iter_417_8, iter_417_9 in pairs(arg_414_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_417_9 then
						if arg_414_1.isInRecall_ then
							iter_417_9.color = arg_414_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_417_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_414_1.var_.actorSpriteComps10022 = nil
			end

			local var_417_30 = 0
			local var_417_31 = 0.425

			if var_417_30 < arg_414_1.time_ and arg_414_1.time_ <= var_417_30 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_32 = arg_414_1:FormatText(StoryNameCfg[614].name)

				arg_414_1.leftNameTxt_.text = var_417_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_33 = arg_414_1:GetWordFromCfg(413021101)
				local var_417_34 = arg_414_1:FormatText(var_417_33.content)

				arg_414_1.text_.text = var_417_34

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_35 = 17
				local var_417_36 = utf8.len(var_417_34)
				local var_417_37 = var_417_35 <= 0 and var_417_31 or var_417_31 * (var_417_36 / var_417_35)

				if var_417_37 > 0 and var_417_31 < var_417_37 then
					arg_414_1.talkMaxDuration = var_417_37

					if var_417_37 + var_417_30 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_37 + var_417_30
					end
				end

				arg_414_1.text_.text = var_417_34
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021101", "story_v_out_413021.awb") ~= 0 then
					local var_417_38 = manager.audio:GetVoiceLength("story_v_out_413021", "413021101", "story_v_out_413021.awb") / 1000

					if var_417_38 + var_417_30 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_38 + var_417_30
					end

					if var_417_33.prefab_name ~= "" and arg_414_1.actors_[var_417_33.prefab_name] ~= nil then
						local var_417_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_33.prefab_name].transform, "story_v_out_413021", "413021101", "story_v_out_413021.awb")

						arg_414_1:RecordAudio("413021101", var_417_39)
						arg_414_1:RecordAudio("413021101", var_417_39)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_413021", "413021101", "story_v_out_413021.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_413021", "413021101", "story_v_out_413021.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_40 = math.max(var_417_31, arg_414_1.talkMaxDuration)

			if var_417_30 <= arg_414_1.time_ and arg_414_1.time_ < var_417_30 + var_417_40 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_30) / var_417_40

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_30 + var_417_40 and arg_414_1.time_ < var_417_30 + var_417_40 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play413021102 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 413021102
		arg_418_1.duration_ = 5.5

		local var_418_0 = {
			zh = 5.5,
			ja = 5.2
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play413021103(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["10092"]
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.actorSpriteComps10092 == nil then
				arg_418_1.var_.actorSpriteComps10092 = var_421_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_421_2 = 2

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_2 and not isNil(var_421_0) then
				local var_421_3 = (arg_418_1.time_ - var_421_1) / var_421_2

				if arg_418_1.var_.actorSpriteComps10092 then
					for iter_421_0, iter_421_1 in pairs(arg_418_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_421_1 then
							if arg_418_1.isInRecall_ then
								local var_421_4 = Mathf.Lerp(iter_421_1.color.r, arg_418_1.hightColor1.r, var_421_3)
								local var_421_5 = Mathf.Lerp(iter_421_1.color.g, arg_418_1.hightColor1.g, var_421_3)
								local var_421_6 = Mathf.Lerp(iter_421_1.color.b, arg_418_1.hightColor1.b, var_421_3)

								iter_421_1.color = Color.New(var_421_4, var_421_5, var_421_6)
							else
								local var_421_7 = Mathf.Lerp(iter_421_1.color.r, 1, var_421_3)

								iter_421_1.color = Color.New(var_421_7, var_421_7, var_421_7)
							end
						end
					end
				end
			end

			if arg_418_1.time_ >= var_421_1 + var_421_2 and arg_418_1.time_ < var_421_1 + var_421_2 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.actorSpriteComps10092 then
				for iter_421_2, iter_421_3 in pairs(arg_418_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_421_3 then
						if arg_418_1.isInRecall_ then
							iter_421_3.color = arg_418_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_421_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_418_1.var_.actorSpriteComps10092 = nil
			end

			local var_421_8 = arg_418_1.actors_["10022"]
			local var_421_9 = 0

			if var_421_9 < arg_418_1.time_ and arg_418_1.time_ <= var_421_9 + arg_421_0 and not isNil(var_421_8) and arg_418_1.var_.actorSpriteComps10022 == nil then
				arg_418_1.var_.actorSpriteComps10022 = var_421_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_421_10 = 2

			if var_421_9 <= arg_418_1.time_ and arg_418_1.time_ < var_421_9 + var_421_10 and not isNil(var_421_8) then
				local var_421_11 = (arg_418_1.time_ - var_421_9) / var_421_10

				if arg_418_1.var_.actorSpriteComps10022 then
					for iter_421_4, iter_421_5 in pairs(arg_418_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_421_5 then
							if arg_418_1.isInRecall_ then
								local var_421_12 = Mathf.Lerp(iter_421_5.color.r, arg_418_1.hightColor2.r, var_421_11)
								local var_421_13 = Mathf.Lerp(iter_421_5.color.g, arg_418_1.hightColor2.g, var_421_11)
								local var_421_14 = Mathf.Lerp(iter_421_5.color.b, arg_418_1.hightColor2.b, var_421_11)

								iter_421_5.color = Color.New(var_421_12, var_421_13, var_421_14)
							else
								local var_421_15 = Mathf.Lerp(iter_421_5.color.r, 0.5, var_421_11)

								iter_421_5.color = Color.New(var_421_15, var_421_15, var_421_15)
							end
						end
					end
				end
			end

			if arg_418_1.time_ >= var_421_9 + var_421_10 and arg_418_1.time_ < var_421_9 + var_421_10 + arg_421_0 and not isNil(var_421_8) and arg_418_1.var_.actorSpriteComps10022 then
				for iter_421_6, iter_421_7 in pairs(arg_418_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_421_7 then
						if arg_418_1.isInRecall_ then
							iter_421_7.color = arg_418_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_421_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_418_1.var_.actorSpriteComps10022 = nil
			end

			local var_421_16 = 0
			local var_421_17 = 0.7

			if var_421_16 < arg_418_1.time_ and arg_418_1.time_ <= var_421_16 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_18 = arg_418_1:FormatText(StoryNameCfg[996].name)

				arg_418_1.leftNameTxt_.text = var_421_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_19 = arg_418_1:GetWordFromCfg(413021102)
				local var_421_20 = arg_418_1:FormatText(var_421_19.content)

				arg_418_1.text_.text = var_421_20

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_21 = 28
				local var_421_22 = utf8.len(var_421_20)
				local var_421_23 = var_421_21 <= 0 and var_421_17 or var_421_17 * (var_421_22 / var_421_21)

				if var_421_23 > 0 and var_421_17 < var_421_23 then
					arg_418_1.talkMaxDuration = var_421_23

					if var_421_23 + var_421_16 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_23 + var_421_16
					end
				end

				arg_418_1.text_.text = var_421_20
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021102", "story_v_out_413021.awb") ~= 0 then
					local var_421_24 = manager.audio:GetVoiceLength("story_v_out_413021", "413021102", "story_v_out_413021.awb") / 1000

					if var_421_24 + var_421_16 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_24 + var_421_16
					end

					if var_421_19.prefab_name ~= "" and arg_418_1.actors_[var_421_19.prefab_name] ~= nil then
						local var_421_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_19.prefab_name].transform, "story_v_out_413021", "413021102", "story_v_out_413021.awb")

						arg_418_1:RecordAudio("413021102", var_421_25)
						arg_418_1:RecordAudio("413021102", var_421_25)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_413021", "413021102", "story_v_out_413021.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_413021", "413021102", "story_v_out_413021.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_26 = math.max(var_421_17, arg_418_1.talkMaxDuration)

			if var_421_16 <= arg_418_1.time_ and arg_418_1.time_ < var_421_16 + var_421_26 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_16) / var_421_26

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_16 + var_421_26 and arg_418_1.time_ < var_421_16 + var_421_26 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play413021103 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 413021103
		arg_422_1.duration_ = 5.1

		local var_422_0 = {
			zh = 1.999999999999,
			ja = 5.1
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
			arg_422_1.auto_ = false
		end

		function arg_422_1.playNext_(arg_424_0)
			arg_422_1.onStoryFinished_()
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["10022"].transform
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 then
				arg_422_1.var_.moveOldPos10022 = var_425_0.localPosition
				var_425_0.localScale = Vector3.New(1, 1, 1)

				arg_422_1:CheckSpriteTmpPos("10022", 4)

				local var_425_2 = var_425_0.childCount

				for iter_425_0 = 0, var_425_2 - 1 do
					local var_425_3 = var_425_0:GetChild(iter_425_0)

					if var_425_3.name == "split_2" or not string.find(var_425_3.name, "split") then
						var_425_3.gameObject:SetActive(true)
					else
						var_425_3.gameObject:SetActive(false)
					end
				end
			end

			local var_425_4 = 0.001

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_4 then
				local var_425_5 = (arg_422_1.time_ - var_425_1) / var_425_4
				local var_425_6 = Vector3.New(390, -315, -320)

				var_425_0.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos10022, var_425_6, var_425_5)
			end

			if arg_422_1.time_ >= var_425_1 + var_425_4 and arg_422_1.time_ < var_425_1 + var_425_4 + arg_425_0 then
				var_425_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_425_7 = arg_422_1.actors_["10092"]
			local var_425_8 = 0

			if var_425_8 < arg_422_1.time_ and arg_422_1.time_ <= var_425_8 + arg_425_0 and not isNil(var_425_7) and arg_422_1.var_.actorSpriteComps10092 == nil then
				arg_422_1.var_.actorSpriteComps10092 = var_425_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_425_9 = 2

			if var_425_8 <= arg_422_1.time_ and arg_422_1.time_ < var_425_8 + var_425_9 and not isNil(var_425_7) then
				local var_425_10 = (arg_422_1.time_ - var_425_8) / var_425_9

				if arg_422_1.var_.actorSpriteComps10092 then
					for iter_425_1, iter_425_2 in pairs(arg_422_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_425_2 then
							if arg_422_1.isInRecall_ then
								local var_425_11 = Mathf.Lerp(iter_425_2.color.r, arg_422_1.hightColor2.r, var_425_10)
								local var_425_12 = Mathf.Lerp(iter_425_2.color.g, arg_422_1.hightColor2.g, var_425_10)
								local var_425_13 = Mathf.Lerp(iter_425_2.color.b, arg_422_1.hightColor2.b, var_425_10)

								iter_425_2.color = Color.New(var_425_11, var_425_12, var_425_13)
							else
								local var_425_14 = Mathf.Lerp(iter_425_2.color.r, 0.5, var_425_10)

								iter_425_2.color = Color.New(var_425_14, var_425_14, var_425_14)
							end
						end
					end
				end
			end

			if arg_422_1.time_ >= var_425_8 + var_425_9 and arg_422_1.time_ < var_425_8 + var_425_9 + arg_425_0 and not isNil(var_425_7) and arg_422_1.var_.actorSpriteComps10092 then
				for iter_425_3, iter_425_4 in pairs(arg_422_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_425_4 then
						if arg_422_1.isInRecall_ then
							iter_425_4.color = arg_422_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_425_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_422_1.var_.actorSpriteComps10092 = nil
			end

			local var_425_15 = arg_422_1.actors_["10022"]
			local var_425_16 = 0

			if var_425_16 < arg_422_1.time_ and arg_422_1.time_ <= var_425_16 + arg_425_0 and not isNil(var_425_15) and arg_422_1.var_.actorSpriteComps10022 == nil then
				arg_422_1.var_.actorSpriteComps10022 = var_425_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_425_17 = 2

			if var_425_16 <= arg_422_1.time_ and arg_422_1.time_ < var_425_16 + var_425_17 and not isNil(var_425_15) then
				local var_425_18 = (arg_422_1.time_ - var_425_16) / var_425_17

				if arg_422_1.var_.actorSpriteComps10022 then
					for iter_425_5, iter_425_6 in pairs(arg_422_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_425_6 then
							if arg_422_1.isInRecall_ then
								local var_425_19 = Mathf.Lerp(iter_425_6.color.r, arg_422_1.hightColor1.r, var_425_18)
								local var_425_20 = Mathf.Lerp(iter_425_6.color.g, arg_422_1.hightColor1.g, var_425_18)
								local var_425_21 = Mathf.Lerp(iter_425_6.color.b, arg_422_1.hightColor1.b, var_425_18)

								iter_425_6.color = Color.New(var_425_19, var_425_20, var_425_21)
							else
								local var_425_22 = Mathf.Lerp(iter_425_6.color.r, 1, var_425_18)

								iter_425_6.color = Color.New(var_425_22, var_425_22, var_425_22)
							end
						end
					end
				end
			end

			if arg_422_1.time_ >= var_425_16 + var_425_17 and arg_422_1.time_ < var_425_16 + var_425_17 + arg_425_0 and not isNil(var_425_15) and arg_422_1.var_.actorSpriteComps10022 then
				for iter_425_7, iter_425_8 in pairs(arg_422_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_425_8 then
						if arg_422_1.isInRecall_ then
							iter_425_8.color = arg_422_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_425_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_422_1.var_.actorSpriteComps10022 = nil
			end

			local var_425_23 = 0
			local var_425_24 = 0.2

			if var_425_23 < arg_422_1.time_ and arg_422_1.time_ <= var_425_23 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_25 = arg_422_1:FormatText(StoryNameCfg[614].name)

				arg_422_1.leftNameTxt_.text = var_425_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_26 = arg_422_1:GetWordFromCfg(413021103)
				local var_425_27 = arg_422_1:FormatText(var_425_26.content)

				arg_422_1.text_.text = var_425_27

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_28 = 8
				local var_425_29 = utf8.len(var_425_27)
				local var_425_30 = var_425_28 <= 0 and var_425_24 or var_425_24 * (var_425_29 / var_425_28)

				if var_425_30 > 0 and var_425_24 < var_425_30 then
					arg_422_1.talkMaxDuration = var_425_30

					if var_425_30 + var_425_23 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_30 + var_425_23
					end
				end

				arg_422_1.text_.text = var_425_27
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413021", "413021103", "story_v_out_413021.awb") ~= 0 then
					local var_425_31 = manager.audio:GetVoiceLength("story_v_out_413021", "413021103", "story_v_out_413021.awb") / 1000

					if var_425_31 + var_425_23 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_31 + var_425_23
					end

					if var_425_26.prefab_name ~= "" and arg_422_1.actors_[var_425_26.prefab_name] ~= nil then
						local var_425_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_26.prefab_name].transform, "story_v_out_413021", "413021103", "story_v_out_413021.awb")

						arg_422_1:RecordAudio("413021103", var_425_32)
						arg_422_1:RecordAudio("413021103", var_425_32)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_413021", "413021103", "story_v_out_413021.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_413021", "413021103", "story_v_out_413021.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_33 = math.max(var_425_24, arg_422_1.talkMaxDuration)

			if var_425_23 <= arg_422_1.time_ and arg_422_1.time_ < var_425_23 + var_425_33 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_23) / var_425_33

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_23 + var_425_33 and arg_422_1.time_ < var_425_23 + var_425_33 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F08h",
		"TextureConfig/Background/F08f",
		"TextureConfig/Background/ST0601"
	},
	voices = {
		"story_v_out_413021.awb"
	}
}
