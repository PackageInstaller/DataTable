return {
	Play319931001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319931001
		arg_1_1.duration_ = 6.79

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319931002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

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
				local var_4_5 = arg_1_1.bgs_.STblack

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
					if iter_4_0 ~= "STblack" then
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
			local var_4_23 = 0.2

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

			local var_4_28 = 1.78867580434307
			local var_4_29 = 0.825

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_31 = arg_1_1:GetWordFromCfg(319931001)
				local var_4_32 = arg_1_1:FormatText(var_4_31.content)

				arg_1_1.text_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 33
				local var_4_34 = utf8.len(var_4_32)
				local var_4_35 = var_4_33 <= 0 and var_4_29 or var_4_29 * (var_4_34 / var_4_33)

				if var_4_35 > 0 and var_4_29 < var_4_35 then
					arg_1_1.talkMaxDuration = var_4_35
					var_4_28 = var_4_28 + 0.3

					if var_4_35 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_32
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_36 = var_4_28 + 0.3
			local var_4_37 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_37

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319931002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 319931002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play319931003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.225

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(319931002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 49
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play319931003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 319931003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play319931004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.425

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(319931003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 17
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play319931004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 319931004
		arg_16_1.duration_ = 4.9

		local var_16_0 = {
			zh = 4.9,
			ja = 4
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play319931005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.35

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[6].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(319931004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 14
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931004", "story_v_out_319931.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931004", "story_v_out_319931.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_319931", "319931004", "story_v_out_319931.awb")

						arg_16_1:RecordAudio("319931004", var_19_9)
						arg_16_1:RecordAudio("319931004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_319931", "319931004", "story_v_out_319931.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_319931", "319931004", "story_v_out_319931.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_10 and arg_16_1.time_ < var_19_0 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play319931005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 319931005
		arg_20_1.duration_ = 6.57

		local var_20_0 = {
			zh = 6.566,
			ja = 6.4
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play319931006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.475

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[6].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(319931005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 19
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931005", "story_v_out_319931.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931005", "story_v_out_319931.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_319931", "319931005", "story_v_out_319931.awb")

						arg_20_1:RecordAudio("319931005", var_23_9)
						arg_20_1:RecordAudio("319931005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_319931", "319931005", "story_v_out_319931.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_319931", "319931005", "story_v_out_319931.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play319931006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 319931006
		arg_24_1.duration_ = 1.83

		local var_24_0 = {
			zh = 1.466,
			ja = 1.833
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play319931007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.125

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[692].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10050")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(319931006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931006", "story_v_out_319931.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931006", "story_v_out_319931.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_319931", "319931006", "story_v_out_319931.awb")

						arg_24_1:RecordAudio("319931006", var_27_9)
						arg_24_1:RecordAudio("319931006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_319931", "319931006", "story_v_out_319931.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_319931", "319931006", "story_v_out_319931.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_10 and arg_24_1.time_ < var_27_0 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play319931007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 319931007
		arg_28_1.duration_ = 2

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play319931008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "10079ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "10079ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_28_1.stage_.transform)

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

			local var_31_5 = arg_28_1.actors_["10079ui_story"].transform
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.var_.moveOldPos10079ui_story = var_31_5.localPosition
			end

			local var_31_7 = 0.001

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7
				local var_31_9 = Vector3.New(0, -0.95, -6.05)

				var_31_5.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10079ui_story, var_31_9, var_31_8)

				local var_31_10 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_10.x, var_31_10.y, var_31_10.z)

				local var_31_11 = var_31_5.localEulerAngles

				var_31_11.z = 0
				var_31_11.x = 0
				var_31_5.localEulerAngles = var_31_11
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 then
				var_31_5.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_31_12 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_12.x, var_31_12.y, var_31_12.z)

				local var_31_13 = var_31_5.localEulerAngles

				var_31_13.z = 0
				var_31_13.x = 0
				var_31_5.localEulerAngles = var_31_13
			end

			local var_31_14 = 0

			if var_31_14 < arg_28_1.time_ and arg_28_1.time_ <= var_31_14 + arg_31_0 then
				arg_28_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_31_15 = 0

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_31_16 = arg_28_1.actors_["10079ui_story"]
			local var_31_17 = 0

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect10079ui_story == nil then
				arg_28_1.var_.characterEffect10079ui_story = var_31_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_18 = 0.2

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_18 and not isNil(var_31_16) then
				local var_31_19 = (arg_28_1.time_ - var_31_17) / var_31_18

				if arg_28_1.var_.characterEffect10079ui_story and not isNil(var_31_16) then
					arg_28_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_17 + var_31_18 and arg_28_1.time_ < var_31_17 + var_31_18 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect10079ui_story then
				arg_28_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_31_20 = 0
			local var_31_21 = 0.05

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_22 = arg_28_1:FormatText(StoryNameCfg[6].name)

				arg_28_1.leftNameTxt_.text = var_31_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_23 = arg_28_1:GetWordFromCfg(319931007)
				local var_31_24 = arg_28_1:FormatText(var_31_23.content)

				arg_28_1.text_.text = var_31_24

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_25 = 2
				local var_31_26 = utf8.len(var_31_24)
				local var_31_27 = var_31_25 <= 0 and var_31_21 or var_31_21 * (var_31_26 / var_31_25)

				if var_31_27 > 0 and var_31_21 < var_31_27 then
					arg_28_1.talkMaxDuration = var_31_27

					if var_31_27 + var_31_20 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_27 + var_31_20
					end
				end

				arg_28_1.text_.text = var_31_24
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931007", "story_v_out_319931.awb") ~= 0 then
					local var_31_28 = manager.audio:GetVoiceLength("story_v_out_319931", "319931007", "story_v_out_319931.awb") / 1000

					if var_31_28 + var_31_20 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_28 + var_31_20
					end

					if var_31_23.prefab_name ~= "" and arg_28_1.actors_[var_31_23.prefab_name] ~= nil then
						local var_31_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_23.prefab_name].transform, "story_v_out_319931", "319931007", "story_v_out_319931.awb")

						arg_28_1:RecordAudio("319931007", var_31_29)
						arg_28_1:RecordAudio("319931007", var_31_29)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_319931", "319931007", "story_v_out_319931.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_319931", "319931007", "story_v_out_319931.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_30 = math.max(var_31_21, arg_28_1.talkMaxDuration)

			if var_31_20 <= arg_28_1.time_ and arg_28_1.time_ < var_31_20 + var_31_30 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_20) / var_31_30

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_20 + var_31_30 and arg_28_1.time_ < var_31_20 + var_31_30 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play319931008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 319931008
		arg_32_1.duration_ = 7

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play319931009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "I11r"

			if arg_32_1.bgs_[var_35_0] == nil then
				local var_35_1 = Object.Instantiate(arg_32_1.paintGo_)

				var_35_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_35_0)
				var_35_1.name = var_35_0
				var_35_1.transform.parent = arg_32_1.stage_.transform
				var_35_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.bgs_[var_35_0] = var_35_1
			end

			local var_35_2 = 0

			if var_35_2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				local var_35_3 = manager.ui.mainCamera.transform.localPosition
				local var_35_4 = Vector3.New(0, 0, 10) + Vector3.New(var_35_3.x, var_35_3.y, 0)
				local var_35_5 = arg_32_1.bgs_.I11r

				var_35_5.transform.localPosition = var_35_4
				var_35_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_35_6 = var_35_5:GetComponent("SpriteRenderer")

				if var_35_6 and var_35_6.sprite then
					local var_35_7 = (var_35_5.transform.localPosition - var_35_3).z
					local var_35_8 = manager.ui.mainCameraCom_
					local var_35_9 = 2 * var_35_7 * Mathf.Tan(var_35_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_35_10 = var_35_9 * var_35_8.aspect
					local var_35_11 = var_35_6.sprite.bounds.size.x
					local var_35_12 = var_35_6.sprite.bounds.size.y
					local var_35_13 = var_35_10 / var_35_11
					local var_35_14 = var_35_9 / var_35_12
					local var_35_15 = var_35_14 < var_35_13 and var_35_13 or var_35_14

					var_35_5.transform.localScale = Vector3.New(var_35_15, var_35_15, 0)
				end

				for iter_35_0, iter_35_1 in pairs(arg_32_1.bgs_) do
					if iter_35_0 ~= "I11r" then
						iter_35_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_35_16 = 2

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			local var_35_17 = 0.3

			if arg_32_1.time_ >= var_35_16 + var_35_17 and arg_32_1.time_ < var_35_16 + var_35_17 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end

			local var_35_18 = 0

			if var_35_18 < arg_32_1.time_ and arg_32_1.time_ <= var_35_18 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_19 = 2

			if var_35_18 <= arg_32_1.time_ and arg_32_1.time_ < var_35_18 + var_35_19 then
				local var_35_20 = (arg_32_1.time_ - var_35_18) / var_35_19
				local var_35_21 = Color.New(1, 1, 1)

				var_35_21.a = Mathf.Lerp(1, 0, var_35_20)
				arg_32_1.mask_.color = var_35_21
			end

			if arg_32_1.time_ >= var_35_18 + var_35_19 and arg_32_1.time_ < var_35_18 + var_35_19 + arg_35_0 then
				local var_35_22 = Color.New(1, 1, 1)
				local var_35_23 = 0

				arg_32_1.mask_.enabled = false
				var_35_22.a = var_35_23
				arg_32_1.mask_.color = var_35_22
			end

			local var_35_24 = arg_32_1.actors_["10079ui_story"].transform
			local var_35_25 = 0

			if var_35_25 < arg_32_1.time_ and arg_32_1.time_ <= var_35_25 + arg_35_0 then
				arg_32_1.var_.moveOldPos10079ui_story = var_35_24.localPosition
			end

			local var_35_26 = 0.001

			if var_35_25 <= arg_32_1.time_ and arg_32_1.time_ < var_35_25 + var_35_26 then
				local var_35_27 = (arg_32_1.time_ - var_35_25) / var_35_26
				local var_35_28 = Vector3.New(0, 100, 0)

				var_35_24.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10079ui_story, var_35_28, var_35_27)

				local var_35_29 = manager.ui.mainCamera.transform.position - var_35_24.position

				var_35_24.forward = Vector3.New(var_35_29.x, var_35_29.y, var_35_29.z)

				local var_35_30 = var_35_24.localEulerAngles

				var_35_30.z = 0
				var_35_30.x = 0
				var_35_24.localEulerAngles = var_35_30
			end

			if arg_32_1.time_ >= var_35_25 + var_35_26 and arg_32_1.time_ < var_35_25 + var_35_26 + arg_35_0 then
				var_35_24.localPosition = Vector3.New(0, 100, 0)

				local var_35_31 = manager.ui.mainCamera.transform.position - var_35_24.position

				var_35_24.forward = Vector3.New(var_35_31.x, var_35_31.y, var_35_31.z)

				local var_35_32 = var_35_24.localEulerAngles

				var_35_32.z = 0
				var_35_32.x = 0
				var_35_24.localEulerAngles = var_35_32
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_33 = 2
			local var_35_34 = 0.95

			if var_35_33 < arg_32_1.time_ and arg_32_1.time_ <= var_35_33 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_35 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_35:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_32_1.dialogCg_.alpha = arg_36_0
				end))
				var_35_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_36 = arg_32_1:GetWordFromCfg(319931008)
				local var_35_37 = arg_32_1:FormatText(var_35_36.content)

				arg_32_1.text_.text = var_35_37

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_38 = 38
				local var_35_39 = utf8.len(var_35_37)
				local var_35_40 = var_35_38 <= 0 and var_35_34 or var_35_34 * (var_35_39 / var_35_38)

				if var_35_40 > 0 and var_35_34 < var_35_40 then
					arg_32_1.talkMaxDuration = var_35_40
					var_35_33 = var_35_33 + 0.3

					if var_35_40 + var_35_33 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_40 + var_35_33
					end
				end

				arg_32_1.text_.text = var_35_37
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_41 = var_35_33 + 0.3
			local var_35_42 = math.max(var_35_34, arg_32_1.talkMaxDuration)

			if var_35_41 <= arg_32_1.time_ and arg_32_1.time_ < var_35_41 + var_35_42 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_41) / var_35_42

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_41 + var_35_42 and arg_32_1.time_ < var_35_41 + var_35_42 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play319931009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 319931009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play319931010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 0.775

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_2 = arg_38_1:GetWordFromCfg(319931009)
				local var_41_3 = arg_38_1:FormatText(var_41_2.content)

				arg_38_1.text_.text = var_41_3

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 31
				local var_41_5 = utf8.len(var_41_3)
				local var_41_6 = var_41_4 <= 0 and var_41_1 or var_41_1 * (var_41_5 / var_41_4)

				if var_41_6 > 0 and var_41_1 < var_41_6 then
					arg_38_1.talkMaxDuration = var_41_6

					if var_41_6 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_6 + var_41_0
					end
				end

				arg_38_1.text_.text = var_41_3
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_1, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_0) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_7 and arg_38_1.time_ < var_41_0 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play319931010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 319931010
		arg_42_1.duration_ = 2.8

		local var_42_0 = {
			zh = 1.999999999999,
			ja = 2.8
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
				arg_42_0:Play319931011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["10079ui_story"].transform
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.var_.moveOldPos10079ui_story = var_45_0.localPosition
			end

			local var_45_2 = 0.001

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2
				local var_45_4 = Vector3.New(0, -0.95, -6.05)

				var_45_0.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10079ui_story, var_45_4, var_45_3)

				local var_45_5 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_5.x, var_45_5.y, var_45_5.z)

				local var_45_6 = var_45_0.localEulerAngles

				var_45_6.z = 0
				var_45_6.x = 0
				var_45_0.localEulerAngles = var_45_6
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 then
				var_45_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_45_7 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_7.x, var_45_7.y, var_45_7.z)

				local var_45_8 = var_45_0.localEulerAngles

				var_45_8.z = 0
				var_45_8.x = 0
				var_45_0.localEulerAngles = var_45_8
			end

			local var_45_9 = arg_42_1.actors_["10079ui_story"]
			local var_45_10 = 0

			if var_45_10 < arg_42_1.time_ and arg_42_1.time_ <= var_45_10 + arg_45_0 and not isNil(var_45_9) and arg_42_1.var_.characterEffect10079ui_story == nil then
				arg_42_1.var_.characterEffect10079ui_story = var_45_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_11 = 0.200000002980232

			if var_45_10 <= arg_42_1.time_ and arg_42_1.time_ < var_45_10 + var_45_11 and not isNil(var_45_9) then
				local var_45_12 = (arg_42_1.time_ - var_45_10) / var_45_11

				if arg_42_1.var_.characterEffect10079ui_story and not isNil(var_45_9) then
					arg_42_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_10 + var_45_11 and arg_42_1.time_ < var_45_10 + var_45_11 + arg_45_0 and not isNil(var_45_9) and arg_42_1.var_.characterEffect10079ui_story then
				arg_42_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_45_13 = 0

			if var_45_13 < arg_42_1.time_ and arg_42_1.time_ <= var_45_13 + arg_45_0 then
				arg_42_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_45_14 = 0

			if var_45_14 < arg_42_1.time_ and arg_42_1.time_ <= var_45_14 + arg_45_0 then
				arg_42_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_45_15 = 0
			local var_45_16 = 0.2

			if var_45_15 < arg_42_1.time_ and arg_42_1.time_ <= var_45_15 + arg_45_0 then
				local var_45_17 = "play"
				local var_45_18 = "music"

				arg_42_1:AudioAction(var_45_17, var_45_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_45_19 = ""
				local var_45_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_45_20 ~= "" then
					if arg_42_1.bgmTxt_.text ~= var_45_20 and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = var_45_20

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = var_45_20
						arg_42_1.bgmTxt2_.text = var_45_20
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_45_21 = 0.233333333333333
			local var_45_22 = 1

			if var_45_21 < arg_42_1.time_ and arg_42_1.time_ <= var_45_21 + arg_45_0 then
				local var_45_23 = "play"
				local var_45_24 = "music"

				arg_42_1:AudioAction(var_45_23, var_45_24, "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense.awb")

				local var_45_25 = ""
				local var_45_26 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense")

				if var_45_26 ~= "" then
					if arg_42_1.bgmTxt_.text ~= var_45_26 and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = var_45_26

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = var_45_26
						arg_42_1.bgmTxt2_.text = var_45_26
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_45_27 = 0
			local var_45_28 = 0.175

			if var_45_27 < arg_42_1.time_ and arg_42_1.time_ <= var_45_27 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_29 = arg_42_1:FormatText(StoryNameCfg[6].name)

				arg_42_1.leftNameTxt_.text = var_45_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_30 = arg_42_1:GetWordFromCfg(319931010)
				local var_45_31 = arg_42_1:FormatText(var_45_30.content)

				arg_42_1.text_.text = var_45_31

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_32 = 7
				local var_45_33 = utf8.len(var_45_31)
				local var_45_34 = var_45_32 <= 0 and var_45_28 or var_45_28 * (var_45_33 / var_45_32)

				if var_45_34 > 0 and var_45_28 < var_45_34 then
					arg_42_1.talkMaxDuration = var_45_34

					if var_45_34 + var_45_27 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_34 + var_45_27
					end
				end

				arg_42_1.text_.text = var_45_31
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931010", "story_v_out_319931.awb") ~= 0 then
					local var_45_35 = manager.audio:GetVoiceLength("story_v_out_319931", "319931010", "story_v_out_319931.awb") / 1000

					if var_45_35 + var_45_27 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_35 + var_45_27
					end

					if var_45_30.prefab_name ~= "" and arg_42_1.actors_[var_45_30.prefab_name] ~= nil then
						local var_45_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_30.prefab_name].transform, "story_v_out_319931", "319931010", "story_v_out_319931.awb")

						arg_42_1:RecordAudio("319931010", var_45_36)
						arg_42_1:RecordAudio("319931010", var_45_36)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_319931", "319931010", "story_v_out_319931.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_319931", "319931010", "story_v_out_319931.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_37 = math.max(var_45_28, arg_42_1.talkMaxDuration)

			if var_45_27 <= arg_42_1.time_ and arg_42_1.time_ < var_45_27 + var_45_37 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_27) / var_45_37

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_27 + var_45_37 and arg_42_1.time_ < var_45_27 + var_45_37 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319931011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 319931011
		arg_48_1.duration_ = 8.2

		local var_48_0 = {
			zh = 8.2,
			ja = 7.633
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
				arg_48_0:Play319931012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = "10075ui_story"

			if arg_48_1.actors_[var_51_0] == nil then
				local var_51_1 = Asset.Load("Char/" .. "10075ui_story")

				if not isNil(var_51_1) then
					local var_51_2 = Object.Instantiate(Asset.Load("Char/" .. "10075ui_story"), arg_48_1.stage_.transform)

					var_51_2.name = var_51_0
					var_51_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_48_1.actors_[var_51_0] = var_51_2

					local var_51_3 = var_51_2:GetComponentInChildren(typeof(CharacterEffect))

					var_51_3.enabled = true

					local var_51_4 = GameObjectTools.GetOrAddComponent(var_51_2, typeof(DynamicBoneHelper))

					if var_51_4 then
						var_51_4:EnableDynamicBone(false)
					end

					arg_48_1:ShowWeapon(var_51_3.transform, false)

					arg_48_1.var_[var_51_0 .. "Animator"] = var_51_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_48_1.var_[var_51_0 .. "Animator"].applyRootMotion = true
					arg_48_1.var_[var_51_0 .. "LipSync"] = var_51_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_51_5 = arg_48_1.actors_["10075ui_story"].transform
			local var_51_6 = 0

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.var_.moveOldPos10075ui_story = var_51_5.localPosition
			end

			local var_51_7 = 0.001

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_7 then
				local var_51_8 = (arg_48_1.time_ - var_51_6) / var_51_7
				local var_51_9 = Vector3.New(0.7, -0.715, -6.15)

				var_51_5.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10075ui_story, var_51_9, var_51_8)

				local var_51_10 = manager.ui.mainCamera.transform.position - var_51_5.position

				var_51_5.forward = Vector3.New(var_51_10.x, var_51_10.y, var_51_10.z)

				local var_51_11 = var_51_5.localEulerAngles

				var_51_11.z = 0
				var_51_11.x = 0
				var_51_5.localEulerAngles = var_51_11
			end

			if arg_48_1.time_ >= var_51_6 + var_51_7 and arg_48_1.time_ < var_51_6 + var_51_7 + arg_51_0 then
				var_51_5.localPosition = Vector3.New(0.7, -0.715, -6.15)

				local var_51_12 = manager.ui.mainCamera.transform.position - var_51_5.position

				var_51_5.forward = Vector3.New(var_51_12.x, var_51_12.y, var_51_12.z)

				local var_51_13 = var_51_5.localEulerAngles

				var_51_13.z = 0
				var_51_13.x = 0
				var_51_5.localEulerAngles = var_51_13
			end

			local var_51_14 = arg_48_1.actors_["10075ui_story"]
			local var_51_15 = 0

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 and not isNil(var_51_14) and arg_48_1.var_.characterEffect10075ui_story == nil then
				arg_48_1.var_.characterEffect10075ui_story = var_51_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_16 = 0.200000002980232

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_16 and not isNil(var_51_14) then
				local var_51_17 = (arg_48_1.time_ - var_51_15) / var_51_16

				if arg_48_1.var_.characterEffect10075ui_story and not isNil(var_51_14) then
					arg_48_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_15 + var_51_16 and arg_48_1.time_ < var_51_15 + var_51_16 + arg_51_0 and not isNil(var_51_14) and arg_48_1.var_.characterEffect10075ui_story then
				arg_48_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_51_18 = 0

			if var_51_18 < arg_48_1.time_ and arg_48_1.time_ <= var_51_18 + arg_51_0 then
				arg_48_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			local var_51_19 = 0

			if var_51_19 < arg_48_1.time_ and arg_48_1.time_ <= var_51_19 + arg_51_0 then
				arg_48_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_51_20 = arg_48_1.actors_["10079ui_story"].transform
			local var_51_21 = 0

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 then
				arg_48_1.var_.moveOldPos10079ui_story = var_51_20.localPosition
			end

			local var_51_22 = 0.001

			if var_51_21 <= arg_48_1.time_ and arg_48_1.time_ < var_51_21 + var_51_22 then
				local var_51_23 = (arg_48_1.time_ - var_51_21) / var_51_22
				local var_51_24 = Vector3.New(-0.7, -0.95, -6.05)

				var_51_20.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10079ui_story, var_51_24, var_51_23)

				local var_51_25 = manager.ui.mainCamera.transform.position - var_51_20.position

				var_51_20.forward = Vector3.New(var_51_25.x, var_51_25.y, var_51_25.z)

				local var_51_26 = var_51_20.localEulerAngles

				var_51_26.z = 0
				var_51_26.x = 0
				var_51_20.localEulerAngles = var_51_26
			end

			if arg_48_1.time_ >= var_51_21 + var_51_22 and arg_48_1.time_ < var_51_21 + var_51_22 + arg_51_0 then
				var_51_20.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_51_27 = manager.ui.mainCamera.transform.position - var_51_20.position

				var_51_20.forward = Vector3.New(var_51_27.x, var_51_27.y, var_51_27.z)

				local var_51_28 = var_51_20.localEulerAngles

				var_51_28.z = 0
				var_51_28.x = 0
				var_51_20.localEulerAngles = var_51_28
			end

			local var_51_29 = arg_48_1.actors_["10079ui_story"]
			local var_51_30 = 0

			if var_51_30 < arg_48_1.time_ and arg_48_1.time_ <= var_51_30 + arg_51_0 and not isNil(var_51_29) and arg_48_1.var_.characterEffect10079ui_story == nil then
				arg_48_1.var_.characterEffect10079ui_story = var_51_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_31 = 0.200000002980232

			if var_51_30 <= arg_48_1.time_ and arg_48_1.time_ < var_51_30 + var_51_31 and not isNil(var_51_29) then
				local var_51_32 = (arg_48_1.time_ - var_51_30) / var_51_31

				if arg_48_1.var_.characterEffect10079ui_story and not isNil(var_51_29) then
					local var_51_33 = Mathf.Lerp(0, 0.5, var_51_32)

					arg_48_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10079ui_story.fillRatio = var_51_33
				end
			end

			if arg_48_1.time_ >= var_51_30 + var_51_31 and arg_48_1.time_ < var_51_30 + var_51_31 + arg_51_0 and not isNil(var_51_29) and arg_48_1.var_.characterEffect10079ui_story then
				local var_51_34 = 0.5

				arg_48_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10079ui_story.fillRatio = var_51_34
			end

			local var_51_35 = 0
			local var_51_36 = 0.45

			if var_51_35 < arg_48_1.time_ and arg_48_1.time_ <= var_51_35 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_37 = arg_48_1:FormatText(StoryNameCfg[692].name)

				arg_48_1.leftNameTxt_.text = var_51_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_38 = arg_48_1:GetWordFromCfg(319931011)
				local var_51_39 = arg_48_1:FormatText(var_51_38.content)

				arg_48_1.text_.text = var_51_39

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_40 = 18
				local var_51_41 = utf8.len(var_51_39)
				local var_51_42 = var_51_40 <= 0 and var_51_36 or var_51_36 * (var_51_41 / var_51_40)

				if var_51_42 > 0 and var_51_36 < var_51_42 then
					arg_48_1.talkMaxDuration = var_51_42

					if var_51_42 + var_51_35 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_42 + var_51_35
					end
				end

				arg_48_1.text_.text = var_51_39
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931011", "story_v_out_319931.awb") ~= 0 then
					local var_51_43 = manager.audio:GetVoiceLength("story_v_out_319931", "319931011", "story_v_out_319931.awb") / 1000

					if var_51_43 + var_51_35 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_43 + var_51_35
					end

					if var_51_38.prefab_name ~= "" and arg_48_1.actors_[var_51_38.prefab_name] ~= nil then
						local var_51_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_38.prefab_name].transform, "story_v_out_319931", "319931011", "story_v_out_319931.awb")

						arg_48_1:RecordAudio("319931011", var_51_44)
						arg_48_1:RecordAudio("319931011", var_51_44)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_319931", "319931011", "story_v_out_319931.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_319931", "319931011", "story_v_out_319931.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_45 = math.max(var_51_36, arg_48_1.talkMaxDuration)

			if var_51_35 <= arg_48_1.time_ and arg_48_1.time_ < var_51_35 + var_51_45 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_35) / var_51_45

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_35 + var_51_45 and arg_48_1.time_ < var_51_35 + var_51_45 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319931012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 319931012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play319931013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10075ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10075ui_story == nil then
				arg_52_1.var_.characterEffect10075ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect10075ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10075ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10075ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10075ui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0
			local var_55_7 = 1

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				local var_55_8 = "play"
				local var_55_9 = "effect"

				arg_52_1:AudioAction(var_55_8, var_55_9, "se_story_122_03", "se_story_122_03_crystal2", "")
			end

			local var_55_10 = arg_52_1.actors_["10075ui_story"].transform
			local var_55_11 = 0

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1.var_.moveOldPos10075ui_story = var_55_10.localPosition
			end

			local var_55_12 = 0.001

			if var_55_11 <= arg_52_1.time_ and arg_52_1.time_ < var_55_11 + var_55_12 then
				local var_55_13 = (arg_52_1.time_ - var_55_11) / var_55_12
				local var_55_14 = Vector3.New(0, 100, 0)

				var_55_10.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10075ui_story, var_55_14, var_55_13)

				local var_55_15 = manager.ui.mainCamera.transform.position - var_55_10.position

				var_55_10.forward = Vector3.New(var_55_15.x, var_55_15.y, var_55_15.z)

				local var_55_16 = var_55_10.localEulerAngles

				var_55_16.z = 0
				var_55_16.x = 0
				var_55_10.localEulerAngles = var_55_16
			end

			if arg_52_1.time_ >= var_55_11 + var_55_12 and arg_52_1.time_ < var_55_11 + var_55_12 + arg_55_0 then
				var_55_10.localPosition = Vector3.New(0, 100, 0)

				local var_55_17 = manager.ui.mainCamera.transform.position - var_55_10.position

				var_55_10.forward = Vector3.New(var_55_17.x, var_55_17.y, var_55_17.z)

				local var_55_18 = var_55_10.localEulerAngles

				var_55_18.z = 0
				var_55_18.x = 0
				var_55_10.localEulerAngles = var_55_18
			end

			local var_55_19 = arg_52_1.actors_["10079ui_story"].transform
			local var_55_20 = 0

			if var_55_20 < arg_52_1.time_ and arg_52_1.time_ <= var_55_20 + arg_55_0 then
				arg_52_1.var_.moveOldPos10079ui_story = var_55_19.localPosition
			end

			local var_55_21 = 0.001

			if var_55_20 <= arg_52_1.time_ and arg_52_1.time_ < var_55_20 + var_55_21 then
				local var_55_22 = (arg_52_1.time_ - var_55_20) / var_55_21
				local var_55_23 = Vector3.New(0, 100, 0)

				var_55_19.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10079ui_story, var_55_23, var_55_22)

				local var_55_24 = manager.ui.mainCamera.transform.position - var_55_19.position

				var_55_19.forward = Vector3.New(var_55_24.x, var_55_24.y, var_55_24.z)

				local var_55_25 = var_55_19.localEulerAngles

				var_55_25.z = 0
				var_55_25.x = 0
				var_55_19.localEulerAngles = var_55_25
			end

			if arg_52_1.time_ >= var_55_20 + var_55_21 and arg_52_1.time_ < var_55_20 + var_55_21 + arg_55_0 then
				var_55_19.localPosition = Vector3.New(0, 100, 0)

				local var_55_26 = manager.ui.mainCamera.transform.position - var_55_19.position

				var_55_19.forward = Vector3.New(var_55_26.x, var_55_26.y, var_55_26.z)

				local var_55_27 = var_55_19.localEulerAngles

				var_55_27.z = 0
				var_55_27.x = 0
				var_55_19.localEulerAngles = var_55_27
			end

			local var_55_28 = 0
			local var_55_29 = 1.15

			if var_55_28 < arg_52_1.time_ and arg_52_1.time_ <= var_55_28 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_30 = arg_52_1:GetWordFromCfg(319931012)
				local var_55_31 = arg_52_1:FormatText(var_55_30.content)

				arg_52_1.text_.text = var_55_31

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_32 = 46
				local var_55_33 = utf8.len(var_55_31)
				local var_55_34 = var_55_32 <= 0 and var_55_29 or var_55_29 * (var_55_33 / var_55_32)

				if var_55_34 > 0 and var_55_29 < var_55_34 then
					arg_52_1.talkMaxDuration = var_55_34

					if var_55_34 + var_55_28 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_34 + var_55_28
					end
				end

				arg_52_1.text_.text = var_55_31
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_35 = math.max(var_55_29, arg_52_1.talkMaxDuration)

			if var_55_28 <= arg_52_1.time_ and arg_52_1.time_ < var_55_28 + var_55_35 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_28) / var_55_35

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_28 + var_55_35 and arg_52_1.time_ < var_55_28 + var_55_35 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play319931013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 319931013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play319931014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.825

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(319931013)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 33
				local var_59_5 = utf8.len(var_59_3)
				local var_59_6 = var_59_4 <= 0 and var_59_1 or var_59_1 * (var_59_5 / var_59_4)

				if var_59_6 > 0 and var_59_1 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_7 and arg_56_1.time_ < var_59_0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play319931014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 319931014
		arg_60_1.duration_ = 2.73

		local var_60_0 = {
			zh = 2.733,
			ja = 2.533
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
				arg_60_0:Play319931015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10079ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos10079ui_story = var_63_0.localPosition
			end

			local var_63_2 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2
				local var_63_4 = Vector3.New(0, -0.95, -6.05)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10079ui_story, var_63_4, var_63_3)

				local var_63_5 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_5.x, var_63_5.y, var_63_5.z)

				local var_63_6 = var_63_0.localEulerAngles

				var_63_6.z = 0
				var_63_6.x = 0
				var_63_0.localEulerAngles = var_63_6
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_63_7 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_7.x, var_63_7.y, var_63_7.z)

				local var_63_8 = var_63_0.localEulerAngles

				var_63_8.z = 0
				var_63_8.x = 0
				var_63_0.localEulerAngles = var_63_8
			end

			local var_63_9 = 0

			if var_63_9 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 then
				arg_60_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_63_11 = arg_60_1.actors_["10079ui_story"]
			local var_63_12 = 0

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 and not isNil(var_63_11) and arg_60_1.var_.characterEffect10079ui_story == nil then
				arg_60_1.var_.characterEffect10079ui_story = var_63_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_13 = 0.2

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_13 and not isNil(var_63_11) then
				local var_63_14 = (arg_60_1.time_ - var_63_12) / var_63_13

				if arg_60_1.var_.characterEffect10079ui_story and not isNil(var_63_11) then
					arg_60_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_12 + var_63_13 and arg_60_1.time_ < var_63_12 + var_63_13 + arg_63_0 and not isNil(var_63_11) and arg_60_1.var_.characterEffect10079ui_story then
				arg_60_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_63_15 = 0
			local var_63_16 = 0.175

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_17 = arg_60_1:FormatText(StoryNameCfg[6].name)

				arg_60_1.leftNameTxt_.text = var_63_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_18 = arg_60_1:GetWordFromCfg(319931014)
				local var_63_19 = arg_60_1:FormatText(var_63_18.content)

				arg_60_1.text_.text = var_63_19

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_20 = 7
				local var_63_21 = utf8.len(var_63_19)
				local var_63_22 = var_63_20 <= 0 and var_63_16 or var_63_16 * (var_63_21 / var_63_20)

				if var_63_22 > 0 and var_63_16 < var_63_22 then
					arg_60_1.talkMaxDuration = var_63_22

					if var_63_22 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_22 + var_63_15
					end
				end

				arg_60_1.text_.text = var_63_19
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931014", "story_v_out_319931.awb") ~= 0 then
					local var_63_23 = manager.audio:GetVoiceLength("story_v_out_319931", "319931014", "story_v_out_319931.awb") / 1000

					if var_63_23 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_15
					end

					if var_63_18.prefab_name ~= "" and arg_60_1.actors_[var_63_18.prefab_name] ~= nil then
						local var_63_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_18.prefab_name].transform, "story_v_out_319931", "319931014", "story_v_out_319931.awb")

						arg_60_1:RecordAudio("319931014", var_63_24)
						arg_60_1:RecordAudio("319931014", var_63_24)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_319931", "319931014", "story_v_out_319931.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_319931", "319931014", "story_v_out_319931.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_25 = math.max(var_63_16, arg_60_1.talkMaxDuration)

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_25 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_15) / var_63_25

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_15 + var_63_25 and arg_60_1.time_ < var_63_15 + var_63_25 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play319931015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 319931015
		arg_64_1.duration_ = 3.83

		local var_64_0 = {
			zh = 3.8,
			ja = 3.833
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
				arg_64_0:Play319931016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.375

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[6].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_3 = arg_64_1:GetWordFromCfg(319931015)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 15
				local var_67_6 = utf8.len(var_67_4)
				local var_67_7 = var_67_5 <= 0 and var_67_1 or var_67_1 * (var_67_6 / var_67_5)

				if var_67_7 > 0 and var_67_1 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931015", "story_v_out_319931.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931015", "story_v_out_319931.awb") / 1000

					if var_67_8 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_0
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_out_319931", "319931015", "story_v_out_319931.awb")

						arg_64_1:RecordAudio("319931015", var_67_9)
						arg_64_1:RecordAudio("319931015", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_319931", "319931015", "story_v_out_319931.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_319931", "319931015", "story_v_out_319931.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_10 and arg_64_1.time_ < var_67_0 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play319931016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 319931016
		arg_68_1.duration_ = 5.97

		local var_68_0 = {
			zh = 5.966,
			ja = 4.833
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
				arg_68_0:Play319931017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_71_2 = 0
			local var_71_3 = 0.4

			if var_71_2 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_4 = arg_68_1:FormatText(StoryNameCfg[6].name)

				arg_68_1.leftNameTxt_.text = var_71_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_5 = arg_68_1:GetWordFromCfg(319931016)
				local var_71_6 = arg_68_1:FormatText(var_71_5.content)

				arg_68_1.text_.text = var_71_6

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 16
				local var_71_8 = utf8.len(var_71_6)
				local var_71_9 = var_71_7 <= 0 and var_71_3 or var_71_3 * (var_71_8 / var_71_7)

				if var_71_9 > 0 and var_71_3 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_6
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931016", "story_v_out_319931.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_319931", "319931016", "story_v_out_319931.awb") / 1000

					if var_71_10 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_2
					end

					if var_71_5.prefab_name ~= "" and arg_68_1.actors_[var_71_5.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_5.prefab_name].transform, "story_v_out_319931", "319931016", "story_v_out_319931.awb")

						arg_68_1:RecordAudio("319931016", var_71_11)
						arg_68_1:RecordAudio("319931016", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_319931", "319931016", "story_v_out_319931.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_319931", "319931016", "story_v_out_319931.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_12 = math.max(var_71_3, arg_68_1.talkMaxDuration)

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_12 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_2) / var_71_12

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_2 + var_71_12 and arg_68_1.time_ < var_71_2 + var_71_12 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play319931017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 319931017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play319931018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["10079ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect10079ui_story == nil then
				arg_72_1.var_.characterEffect10079ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect10079ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_72_1.var_.characterEffect10079ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect10079ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_72_1.var_.characterEffect10079ui_story.fillRatio = var_75_5
			end

			local var_75_6 = arg_72_1.actors_["10079ui_story"].transform
			local var_75_7 = 0

			if var_75_7 < arg_72_1.time_ and arg_72_1.time_ <= var_75_7 + arg_75_0 then
				arg_72_1.var_.moveOldPos10079ui_story = var_75_6.localPosition
			end

			local var_75_8 = 0.001

			if var_75_7 <= arg_72_1.time_ and arg_72_1.time_ < var_75_7 + var_75_8 then
				local var_75_9 = (arg_72_1.time_ - var_75_7) / var_75_8
				local var_75_10 = Vector3.New(0, 100, 0)

				var_75_6.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10079ui_story, var_75_10, var_75_9)

				local var_75_11 = manager.ui.mainCamera.transform.position - var_75_6.position

				var_75_6.forward = Vector3.New(var_75_11.x, var_75_11.y, var_75_11.z)

				local var_75_12 = var_75_6.localEulerAngles

				var_75_12.z = 0
				var_75_12.x = 0
				var_75_6.localEulerAngles = var_75_12
			end

			if arg_72_1.time_ >= var_75_7 + var_75_8 and arg_72_1.time_ < var_75_7 + var_75_8 + arg_75_0 then
				var_75_6.localPosition = Vector3.New(0, 100, 0)

				local var_75_13 = manager.ui.mainCamera.transform.position - var_75_6.position

				var_75_6.forward = Vector3.New(var_75_13.x, var_75_13.y, var_75_13.z)

				local var_75_14 = var_75_6.localEulerAngles

				var_75_14.z = 0
				var_75_14.x = 0
				var_75_6.localEulerAngles = var_75_14
			end

			local var_75_15 = 0
			local var_75_16 = 1.175

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_17 = arg_72_1:GetWordFromCfg(319931017)
				local var_75_18 = arg_72_1:FormatText(var_75_17.content)

				arg_72_1.text_.text = var_75_18

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_19 = 47
				local var_75_20 = utf8.len(var_75_18)
				local var_75_21 = var_75_19 <= 0 and var_75_16 or var_75_16 * (var_75_20 / var_75_19)

				if var_75_21 > 0 and var_75_16 < var_75_21 then
					arg_72_1.talkMaxDuration = var_75_21

					if var_75_21 + var_75_15 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_21 + var_75_15
					end
				end

				arg_72_1.text_.text = var_75_18
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_22 = math.max(var_75_16, arg_72_1.talkMaxDuration)

			if var_75_15 <= arg_72_1.time_ and arg_72_1.time_ < var_75_15 + var_75_22 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_15) / var_75_22

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_15 + var_75_22 and arg_72_1.time_ < var_75_15 + var_75_22 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play319931018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319931018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play319931019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 1.375

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_2 = arg_76_1:GetWordFromCfg(319931018)
				local var_79_3 = arg_76_1:FormatText(var_79_2.content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 55
				local var_79_5 = utf8.len(var_79_3)
				local var_79_6 = var_79_4 <= 0 and var_79_1 or var_79_1 * (var_79_5 / var_79_4)

				if var_79_6 > 0 and var_79_1 < var_79_6 then
					arg_76_1.talkMaxDuration = var_79_6

					if var_79_6 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_7 and arg_76_1.time_ < var_79_0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play319931019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319931019
		arg_80_1.duration_ = 2

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play319931020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10079ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos10079ui_story = var_83_0.localPosition

				local var_83_2 = "10079ui_story"

				arg_80_1:ShowWeapon(arg_80_1.var_[var_83_2 .. "Animator"].transform, true)
			end

			local var_83_3 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_3 then
				local var_83_4 = (arg_80_1.time_ - var_83_1) / var_83_3
				local var_83_5 = Vector3.New(0, -0.95, -6.05)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10079ui_story, var_83_5, var_83_4)

				local var_83_6 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_6.x, var_83_6.y, var_83_6.z)

				local var_83_7 = var_83_0.localEulerAngles

				var_83_7.z = 0
				var_83_7.x = 0
				var_83_0.localEulerAngles = var_83_7
			end

			if arg_80_1.time_ >= var_83_1 + var_83_3 and arg_80_1.time_ < var_83_1 + var_83_3 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_83_8 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_8.x, var_83_8.y, var_83_8.z)

				local var_83_9 = var_83_0.localEulerAngles

				var_83_9.z = 0
				var_83_9.x = 0
				var_83_0.localEulerAngles = var_83_9
			end

			local var_83_10 = arg_80_1.actors_["10079ui_story"]
			local var_83_11 = 0

			if var_83_11 < arg_80_1.time_ and arg_80_1.time_ <= var_83_11 + arg_83_0 and not isNil(var_83_10) and arg_80_1.var_.characterEffect10079ui_story == nil then
				arg_80_1.var_.characterEffect10079ui_story = var_83_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_12 = 0.200000002980232

			if var_83_11 <= arg_80_1.time_ and arg_80_1.time_ < var_83_11 + var_83_12 and not isNil(var_83_10) then
				local var_83_13 = (arg_80_1.time_ - var_83_11) / var_83_12

				if arg_80_1.var_.characterEffect10079ui_story and not isNil(var_83_10) then
					arg_80_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_11 + var_83_12 and arg_80_1.time_ < var_83_11 + var_83_12 + arg_83_0 and not isNil(var_83_10) and arg_80_1.var_.characterEffect10079ui_story then
				arg_80_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_83_14 = 0

			if var_83_14 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 then
				arg_80_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_83_15 = 0

			if var_83_15 < arg_80_1.time_ and arg_80_1.time_ <= var_83_15 + arg_83_0 then
				arg_80_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_83_16 = 0
			local var_83_17 = 0.1

			if var_83_16 < arg_80_1.time_ and arg_80_1.time_ <= var_83_16 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_18 = arg_80_1:FormatText(StoryNameCfg[6].name)

				arg_80_1.leftNameTxt_.text = var_83_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_19 = arg_80_1:GetWordFromCfg(319931019)
				local var_83_20 = arg_80_1:FormatText(var_83_19.content)

				arg_80_1.text_.text = var_83_20

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_21 = 4
				local var_83_22 = utf8.len(var_83_20)
				local var_83_23 = var_83_21 <= 0 and var_83_17 or var_83_17 * (var_83_22 / var_83_21)

				if var_83_23 > 0 and var_83_17 < var_83_23 then
					arg_80_1.talkMaxDuration = var_83_23

					if var_83_23 + var_83_16 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_23 + var_83_16
					end
				end

				arg_80_1.text_.text = var_83_20
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931019", "story_v_out_319931.awb") ~= 0 then
					local var_83_24 = manager.audio:GetVoiceLength("story_v_out_319931", "319931019", "story_v_out_319931.awb") / 1000

					if var_83_24 + var_83_16 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_24 + var_83_16
					end

					if var_83_19.prefab_name ~= "" and arg_80_1.actors_[var_83_19.prefab_name] ~= nil then
						local var_83_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_19.prefab_name].transform, "story_v_out_319931", "319931019", "story_v_out_319931.awb")

						arg_80_1:RecordAudio("319931019", var_83_25)
						arg_80_1:RecordAudio("319931019", var_83_25)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_319931", "319931019", "story_v_out_319931.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_319931", "319931019", "story_v_out_319931.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_26 = math.max(var_83_17, arg_80_1.talkMaxDuration)

			if var_83_16 <= arg_80_1.time_ and arg_80_1.time_ < var_83_16 + var_83_26 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_16) / var_83_26

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_16 + var_83_26 and arg_80_1.time_ < var_83_16 + var_83_26 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play319931020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 319931020
		arg_84_1.duration_ = 2

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play319931021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_1 = 1

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_1 then
				local var_87_2 = (arg_84_1.time_ - var_87_0) / var_87_1
				local var_87_3 = Color.New(1, 1, 1)

				var_87_3.a = Mathf.Lerp(1, 0, var_87_2)
				arg_84_1.mask_.color = var_87_3
			end

			if arg_84_1.time_ >= var_87_0 + var_87_1 and arg_84_1.time_ < var_87_0 + var_87_1 + arg_87_0 then
				local var_87_4 = Color.New(1, 1, 1)
				local var_87_5 = 0

				arg_84_1.mask_.enabled = false
				var_87_4.a = var_87_5
				arg_84_1.mask_.color = var_87_4
			end

			local var_87_6 = manager.ui.mainCamera.transform
			local var_87_7 = 0

			if var_87_7 < arg_84_1.time_ and arg_84_1.time_ <= var_87_7 + arg_87_0 then
				arg_84_1.var_.shakeOldPos = var_87_6.localPosition
			end

			local var_87_8 = 0.5

			if var_87_7 <= arg_84_1.time_ and arg_84_1.time_ < var_87_7 + var_87_8 then
				local var_87_9 = (arg_84_1.time_ - var_87_7) / 0.066
				local var_87_10, var_87_11 = math.modf(var_87_9)

				var_87_6.localPosition = Vector3.New(var_87_11 * 0.13, var_87_11 * 0.13, var_87_11 * 0.13) + arg_84_1.var_.shakeOldPos
			end

			if arg_84_1.time_ >= var_87_7 + var_87_8 and arg_84_1.time_ < var_87_7 + var_87_8 + arg_87_0 then
				var_87_6.localPosition = arg_84_1.var_.shakeOldPos
			end

			local var_87_12 = arg_84_1.actors_["10079ui_story"].transform
			local var_87_13 = 0

			if var_87_13 < arg_84_1.time_ and arg_84_1.time_ <= var_87_13 + arg_87_0 then
				arg_84_1.var_.moveOldPos10079ui_story = var_87_12.localPosition

				local var_87_14 = "10079ui_story"

				arg_84_1:ShowWeapon(arg_84_1.var_[var_87_14 .. "Animator"].transform, false)
			end

			local var_87_15 = 0.001

			if var_87_13 <= arg_84_1.time_ and arg_84_1.time_ < var_87_13 + var_87_15 then
				local var_87_16 = (arg_84_1.time_ - var_87_13) / var_87_15
				local var_87_17 = Vector3.New(0, 100, 0)

				var_87_12.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10079ui_story, var_87_17, var_87_16)

				local var_87_18 = manager.ui.mainCamera.transform.position - var_87_12.position

				var_87_12.forward = Vector3.New(var_87_18.x, var_87_18.y, var_87_18.z)

				local var_87_19 = var_87_12.localEulerAngles

				var_87_19.z = 0
				var_87_19.x = 0
				var_87_12.localEulerAngles = var_87_19
			end

			if arg_84_1.time_ >= var_87_13 + var_87_15 and arg_84_1.time_ < var_87_13 + var_87_15 + arg_87_0 then
				var_87_12.localPosition = Vector3.New(0, 100, 0)

				local var_87_20 = manager.ui.mainCamera.transform.position - var_87_12.position

				var_87_12.forward = Vector3.New(var_87_20.x, var_87_20.y, var_87_20.z)

				local var_87_21 = var_87_12.localEulerAngles

				var_87_21.z = 0
				var_87_21.x = 0
				var_87_12.localEulerAngles = var_87_21
			end

			local var_87_22 = 0
			local var_87_23 = 1.566
			local var_87_24 = manager.audio:GetVoiceLength("story_v_out_319931", "319931020", "story_v_out_319931.awb") / 1000

			if var_87_24 > 0 and var_87_23 < var_87_24 and var_87_24 + var_87_22 > arg_84_1.duration_ then
				local var_87_25 = var_87_24

				arg_84_1.duration_ = var_87_24 + var_87_22
			end

			if var_87_22 < arg_84_1.time_ and arg_84_1.time_ <= var_87_22 + arg_87_0 then
				local var_87_26 = "play"
				local var_87_27 = "voice"

				arg_84_1:AudioAction(var_87_26, var_87_27, "story_v_out_319931", "319931020", "story_v_out_319931.awb")
			end

			local var_87_28 = 0

			if var_87_28 < arg_84_1.time_ and arg_84_1.time_ <= var_87_28 + arg_87_0 then
				local var_87_29 = manager.ui.mainCamera.transform.localPosition
				local var_87_30 = Vector3.New(0, 0, 10) + Vector3.New(var_87_29.x, var_87_29.y, 0)
				local var_87_31 = arg_84_1.bgs_.STblack

				var_87_31.transform.localPosition = var_87_30
				var_87_31.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_87_32 = var_87_31:GetComponent("SpriteRenderer")

				if var_87_32 and var_87_32.sprite then
					local var_87_33 = (var_87_31.transform.localPosition - var_87_29).z
					local var_87_34 = manager.ui.mainCameraCom_
					local var_87_35 = 2 * var_87_33 * Mathf.Tan(var_87_34.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_87_36 = var_87_35 * var_87_34.aspect
					local var_87_37 = var_87_32.sprite.bounds.size.x
					local var_87_38 = var_87_32.sprite.bounds.size.y
					local var_87_39 = var_87_36 / var_87_37
					local var_87_40 = var_87_35 / var_87_38
					local var_87_41 = var_87_40 < var_87_39 and var_87_39 or var_87_40

					var_87_31.transform.localScale = Vector3.New(var_87_41, var_87_41, 0)
				end

				for iter_87_0, iter_87_1 in pairs(arg_84_1.bgs_) do
					if iter_87_0 ~= "STblack" then
						iter_87_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_87_42 = 0

			if var_87_42 < arg_84_1.time_ and arg_84_1.time_ <= var_87_42 + arg_87_0 then
				local var_87_43 = arg_84_1.fswbg_.transform:Find("textbox/adapt/content") or arg_84_1.fswbg_.transform:Find("textbox/content")
				local var_87_44 = arg_84_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_87_45 = var_87_43:GetComponent("Text")
				local var_87_46 = var_87_43:GetComponent("RectTransform")

				var_87_45.alignment = UnityEngine.TextAnchor.LowerCenter
				var_87_46.offsetMin = Vector2.New(0, 0)
				var_87_46.offsetMax = Vector2.New(0, 0)
			end

			local var_87_47 = 0

			if var_87_47 < arg_84_1.time_ and arg_84_1.time_ <= var_87_47 + arg_87_0 then
				arg_84_1.fswbg_:SetActive(true)
				arg_84_1.dialog_:SetActive(false)

				arg_84_1.fswtw_.percent = 0

				local var_87_48 = arg_84_1:GetWordFromCfg(319931020)
				local var_87_49 = arg_84_1:FormatText(var_87_48.content)

				arg_84_1.fswt_.text = var_87_49

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.fswt_)

				arg_84_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_84_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_84_1.fswtw_:SetDirty()

				arg_84_1.typewritterCharCountI18N = 0

				SetActive(arg_84_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_84_1:ShowNextGo(false)
			end

			local var_87_50 = 0.149999999998999

			if var_87_50 < arg_84_1.time_ and arg_84_1.time_ <= var_87_50 + arg_87_0 then
				arg_84_1.var_.oldValueTypewriter = arg_84_1.fswtw_.percent

				SetActive(arg_84_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_84_1:ShowNextGo(false)
			end

			local var_87_51 = 0
			local var_87_52 = 0
			local var_87_53 = arg_84_1:GetWordFromCfg(319931020)
			local var_87_54 = arg_84_1:FormatText(var_87_53.content)
			local var_87_55, var_87_56 = arg_84_1:GetPercentByPara(var_87_54, 1)

			if var_87_50 < arg_84_1.time_ and arg_84_1.time_ <= var_87_50 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				local var_87_57 = var_87_51 <= 0 and var_87_52 or var_87_52 * ((var_87_56 - arg_84_1.typewritterCharCountI18N) / var_87_51)

				if var_87_57 > 0 and var_87_52 < var_87_57 then
					arg_84_1.talkMaxDuration = var_87_57

					if var_87_57 + var_87_50 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_57 + var_87_50
					end
				end
			end

			local var_87_58 = 0
			local var_87_59 = math.max(var_87_58, arg_84_1.talkMaxDuration)

			if var_87_50 <= arg_84_1.time_ and arg_84_1.time_ < var_87_50 + var_87_59 then
				local var_87_60 = (arg_84_1.time_ - var_87_50) / var_87_59

				arg_84_1.fswtw_.percent = Mathf.Lerp(arg_84_1.var_.oldValueTypewriter, var_87_55, var_87_60)
				arg_84_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_84_1.fswtw_:SetDirty()
			end

			if arg_84_1.time_ >= var_87_50 + var_87_59 and arg_84_1.time_ < var_87_50 + var_87_59 + arg_87_0 then
				arg_84_1.fswtw_.percent = var_87_55

				arg_84_1.fswtw_:SetDirty()
				arg_84_1:ShowNextGo(true)

				arg_84_1.typewritterCharCountI18N = var_87_56
			end

			local var_87_61 = 0.149999999998999

			if var_87_61 < arg_84_1.time_ and arg_84_1.time_ <= var_87_61 + arg_87_0 then
				arg_84_1.var_.oldValueTypewriter = arg_84_1.fswtw_.percent

				SetActive(arg_84_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_84_1:ShowNextGo(false)
			end

			local var_87_62 = 3
			local var_87_63 = 0.200000000001001
			local var_87_64 = arg_84_1:GetWordFromCfg(319931020)
			local var_87_65 = arg_84_1:FormatText(var_87_64.content)
			local var_87_66, var_87_67 = arg_84_1:GetPercentByPara(var_87_65, 1)

			if var_87_61 < arg_84_1.time_ and arg_84_1.time_ <= var_87_61 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				local var_87_68 = var_87_62 <= 0 and var_87_63 or var_87_63 * ((var_87_67 - arg_84_1.typewritterCharCountI18N) / var_87_62)

				if var_87_68 > 0 and var_87_63 < var_87_68 then
					arg_84_1.talkMaxDuration = var_87_68

					if var_87_68 + var_87_61 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_68 + var_87_61
					end
				end
			end

			local var_87_69 = 0.200000000001001
			local var_87_70 = math.max(var_87_69, arg_84_1.talkMaxDuration)

			if var_87_61 <= arg_84_1.time_ and arg_84_1.time_ < var_87_61 + var_87_70 then
				local var_87_71 = (arg_84_1.time_ - var_87_61) / var_87_70

				arg_84_1.fswtw_.percent = Mathf.Lerp(arg_84_1.var_.oldValueTypewriter, var_87_66, var_87_71)
				arg_84_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_84_1.fswtw_:SetDirty()
			end

			if arg_84_1.time_ >= var_87_61 + var_87_70 and arg_84_1.time_ < var_87_61 + var_87_70 + arg_87_0 then
				arg_84_1.fswtw_.percent = var_87_66

				arg_84_1.fswtw_:SetDirty()
				arg_84_1:ShowNextGo(true)

				arg_84_1.typewritterCharCountI18N = var_87_67
			end

			local var_87_72 = 0

			if var_87_72 < arg_84_1.time_ and arg_84_1.time_ <= var_87_72 + arg_87_0 then
				arg_84_1.cswbg_:SetActive(true)

				local var_87_73 = arg_84_1.cswt_:GetComponent("RectTransform")

				arg_84_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_87_73.offsetMin = Vector2.New(410, 330)
				var_87_73.offsetMax = Vector2.New(-400, -175)

				local var_87_74 = arg_84_1:GetWordFromCfg(419079)
				local var_87_75 = arg_84_1:FormatText(var_87_74.content)

				arg_84_1.cswt_.text = var_87_75

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.cswt_)

				arg_84_1.cswt_.fontSize = 180
				arg_84_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_84_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_84_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play319931021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 319931021
		arg_88_1.duration_ = 6.5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play319931022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.999999999999

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				local var_91_1 = manager.ui.mainCamera.transform.localPosition
				local var_91_2 = Vector3.New(0, 0, 10) + Vector3.New(var_91_1.x, var_91_1.y, 0)
				local var_91_3 = arg_88_1.bgs_.STblack

				var_91_3.transform.localPosition = var_91_2
				var_91_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_4 = var_91_3:GetComponent("SpriteRenderer")

				if var_91_4 and var_91_4.sprite then
					local var_91_5 = (var_91_3.transform.localPosition - var_91_1).z
					local var_91_6 = manager.ui.mainCameraCom_
					local var_91_7 = 2 * var_91_5 * Mathf.Tan(var_91_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_91_8 = var_91_7 * var_91_6.aspect
					local var_91_9 = var_91_4.sprite.bounds.size.x
					local var_91_10 = var_91_4.sprite.bounds.size.y
					local var_91_11 = var_91_8 / var_91_9
					local var_91_12 = var_91_7 / var_91_10
					local var_91_13 = var_91_12 < var_91_11 and var_91_11 or var_91_12

					var_91_3.transform.localScale = Vector3.New(var_91_13, var_91_13, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "STblack" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_91_14 = 0

			if var_91_14 < arg_88_1.time_ and arg_88_1.time_ <= var_91_14 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_15 = 1

			if var_91_14 <= arg_88_1.time_ and arg_88_1.time_ < var_91_14 + var_91_15 then
				local var_91_16 = (arg_88_1.time_ - var_91_14) / var_91_15
				local var_91_17 = Color.New(0, 0, 0)

				var_91_17.a = Mathf.Lerp(0, 1, var_91_16)
				arg_88_1.mask_.color = var_91_17
			end

			if arg_88_1.time_ >= var_91_14 + var_91_15 and arg_88_1.time_ < var_91_14 + var_91_15 + arg_91_0 then
				local var_91_18 = Color.New(0, 0, 0)

				var_91_18.a = 1
				arg_88_1.mask_.color = var_91_18
			end

			local var_91_19 = 1

			if var_91_19 < arg_88_1.time_ and arg_88_1.time_ <= var_91_19 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_20 = 1

			if var_91_19 <= arg_88_1.time_ and arg_88_1.time_ < var_91_19 + var_91_20 then
				local var_91_21 = (arg_88_1.time_ - var_91_19) / var_91_20
				local var_91_22 = Color.New(0, 0, 0)

				var_91_22.a = Mathf.Lerp(1, 0, var_91_21)
				arg_88_1.mask_.color = var_91_22
			end

			if arg_88_1.time_ >= var_91_19 + var_91_20 and arg_88_1.time_ < var_91_19 + var_91_20 + arg_91_0 then
				local var_91_23 = Color.New(0, 0, 0)
				local var_91_24 = 0

				arg_88_1.mask_.enabled = false
				var_91_23.a = var_91_24
				arg_88_1.mask_.color = var_91_23
			end

			local var_91_25 = 0

			if var_91_25 < arg_88_1.time_ and arg_88_1.time_ <= var_91_25 + arg_91_0 then
				arg_88_1.fswbg_:SetActive(true)
				arg_88_1.dialog_:SetActive(false)

				arg_88_1.fswtw_.percent = 0

				local var_91_26 = arg_88_1:GetWordFromCfg(319931020)
				local var_91_27 = arg_88_1:FormatText(var_91_26.content)

				arg_88_1.fswt_.text = var_91_27

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.fswt_)

				arg_88_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_88_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_88_1.fswtw_:SetDirty()

				arg_88_1.typewritterCharCountI18N = 0

				SetActive(arg_88_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_88_1:ShowNextGo(false)
			end

			local var_91_28 = 0.149999999998999

			if var_91_28 < arg_88_1.time_ and arg_88_1.time_ <= var_91_28 + arg_91_0 then
				arg_88_1.var_.oldValueTypewriter = arg_88_1.fswtw_.percent

				SetActive(arg_88_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_88_1:ShowNextGo(false)
			end

			local var_91_29 = 0
			local var_91_30 = 0
			local var_91_31 = arg_88_1:GetWordFromCfg(319931020)
			local var_91_32 = arg_88_1:FormatText(var_91_31.content)
			local var_91_33, var_91_34 = arg_88_1:GetPercentByPara(var_91_32, 1)

			if var_91_28 < arg_88_1.time_ and arg_88_1.time_ <= var_91_28 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				local var_91_35 = var_91_29 <= 0 and var_91_30 or var_91_30 * ((var_91_34 - arg_88_1.typewritterCharCountI18N) / var_91_29)

				if var_91_35 > 0 and var_91_30 < var_91_35 then
					arg_88_1.talkMaxDuration = var_91_35

					if var_91_35 + var_91_28 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_35 + var_91_28
					end
				end
			end

			local var_91_36 = 0
			local var_91_37 = math.max(var_91_36, arg_88_1.talkMaxDuration)

			if var_91_28 <= arg_88_1.time_ and arg_88_1.time_ < var_91_28 + var_91_37 then
				local var_91_38 = (arg_88_1.time_ - var_91_28) / var_91_37

				arg_88_1.fswtw_.percent = Mathf.Lerp(arg_88_1.var_.oldValueTypewriter, var_91_33, var_91_38)
				arg_88_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_88_1.fswtw_:SetDirty()
			end

			if arg_88_1.time_ >= var_91_28 + var_91_37 and arg_88_1.time_ < var_91_28 + var_91_37 + arg_91_0 then
				arg_88_1.fswtw_.percent = var_91_33

				arg_88_1.fswtw_:SetDirty()
				arg_88_1:ShowNextGo(true)

				arg_88_1.typewritterCharCountI18N = var_91_34
			end

			local var_91_39 = 0.15

			if var_91_39 < arg_88_1.time_ and arg_88_1.time_ <= var_91_39 + arg_91_0 then
				arg_88_1.fswbg_:SetActive(false)
				arg_88_1.dialog_:SetActive(false)
				SetActive(arg_88_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_88_1:ShowNextGo(false)
			end

			local var_91_40 = 0

			if var_91_40 < arg_88_1.time_ and arg_88_1.time_ <= var_91_40 + arg_91_0 then
				arg_88_1.cswbg_:SetActive(false)
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_41 = 1.5
			local var_91_42 = 0.85

			if var_91_41 < arg_88_1.time_ and arg_88_1.time_ <= var_91_41 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_43 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_43:setOnUpdate(LuaHelper.FloatAction(function(arg_92_0)
					arg_88_1.dialogCg_.alpha = arg_92_0
				end))
				var_91_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_44 = arg_88_1:GetWordFromCfg(319931021)
				local var_91_45 = arg_88_1:FormatText(var_91_44.content)

				arg_88_1.text_.text = var_91_45

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_46 = 34
				local var_91_47 = utf8.len(var_91_45)
				local var_91_48 = var_91_46 <= 0 and var_91_42 or var_91_42 * (var_91_47 / var_91_46)

				if var_91_48 > 0 and var_91_42 < var_91_48 then
					arg_88_1.talkMaxDuration = var_91_48
					var_91_41 = var_91_41 + 0.3

					if var_91_48 + var_91_41 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_48 + var_91_41
					end
				end

				arg_88_1.text_.text = var_91_45
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_49 = var_91_41 + 0.3
			local var_91_50 = math.max(var_91_42, arg_88_1.talkMaxDuration)

			if var_91_49 <= arg_88_1.time_ and arg_88_1.time_ < var_91_49 + var_91_50 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_49) / var_91_50

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_49 + var_91_50 and arg_88_1.time_ < var_91_49 + var_91_50 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play319931022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 319931022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play319931023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 1.4

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_2 = arg_94_1:GetWordFromCfg(319931022)
				local var_97_3 = arg_94_1:FormatText(var_97_2.content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 56
				local var_97_5 = utf8.len(var_97_3)
				local var_97_6 = var_97_4 <= 0 and var_97_1 or var_97_1 * (var_97_5 / var_97_4)

				if var_97_6 > 0 and var_97_1 < var_97_6 then
					arg_94_1.talkMaxDuration = var_97_6

					if var_97_6 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_6 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_7 and arg_94_1.time_ < var_97_0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play319931023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 319931023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play319931024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 1.05

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_2 = arg_98_1:GetWordFromCfg(319931023)
				local var_101_3 = arg_98_1:FormatText(var_101_2.content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 42
				local var_101_5 = utf8.len(var_101_3)
				local var_101_6 = var_101_4 <= 0 and var_101_1 or var_101_1 * (var_101_5 / var_101_4)

				if var_101_6 > 0 and var_101_1 < var_101_6 then
					arg_98_1.talkMaxDuration = var_101_6

					if var_101_6 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_7 and arg_98_1.time_ < var_101_0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play319931024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 319931024
		arg_102_1.duration_ = 1.92

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play319931025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.283333333332333
			local var_105_1 = 1.633
			local var_105_2 = manager.audio:GetVoiceLength("story_v_out_319931", "319931024", "story_v_out_319931.awb") / 1000

			if var_105_2 > 0 and var_105_1 < var_105_2 and var_105_2 + var_105_0 > arg_102_1.duration_ then
				local var_105_3 = var_105_2

				arg_102_1.duration_ = var_105_2 + var_105_0
			end

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				local var_105_4 = "play"
				local var_105_5 = "voice"

				arg_102_1:AudioAction(var_105_4, var_105_5, "story_v_out_319931", "319931024", "story_v_out_319931.awb")
			end

			local var_105_6 = 0

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				local var_105_7 = arg_102_1.fswbg_.transform:Find("textbox/adapt/content") or arg_102_1.fswbg_.transform:Find("textbox/content")
				local var_105_8 = arg_102_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_105_9 = var_105_7:GetComponent("Text")
				local var_105_10 = var_105_7:GetComponent("RectTransform")

				var_105_9.alignment = UnityEngine.TextAnchor.LowerCenter
				var_105_10.offsetMin = Vector2.New(0, 0)
				var_105_10.offsetMax = Vector2.New(0, 0)
			end

			local var_105_11 = 0

			if var_105_11 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 then
				arg_102_1.fswbg_:SetActive(true)
				arg_102_1.dialog_:SetActive(false)

				arg_102_1.fswtw_.percent = 0

				local var_105_12 = arg_102_1:GetWordFromCfg(319931024)
				local var_105_13 = arg_102_1:FormatText(var_105_12.content)

				arg_102_1.fswt_.text = var_105_13

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.fswt_)

				arg_102_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_102_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_102_1.fswtw_:SetDirty()

				arg_102_1.typewritterCharCountI18N = 0

				SetActive(arg_102_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_102_1:ShowNextGo(false)
			end

			local var_105_14 = 0.149999999998999

			if var_105_14 < arg_102_1.time_ and arg_102_1.time_ <= var_105_14 + arg_105_0 then
				arg_102_1.var_.oldValueTypewriter = arg_102_1.fswtw_.percent

				SetActive(arg_102_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_102_1:ShowNextGo(false)
			end

			local var_105_15 = 0
			local var_105_16 = 0
			local var_105_17 = arg_102_1:GetWordFromCfg(319931024)
			local var_105_18 = arg_102_1:FormatText(var_105_17.content)
			local var_105_19, var_105_20 = arg_102_1:GetPercentByPara(var_105_18, 1)

			if var_105_14 < arg_102_1.time_ and arg_102_1.time_ <= var_105_14 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0

				local var_105_21 = var_105_15 <= 0 and var_105_16 or var_105_16 * ((var_105_20 - arg_102_1.typewritterCharCountI18N) / var_105_15)

				if var_105_21 > 0 and var_105_16 < var_105_21 then
					arg_102_1.talkMaxDuration = var_105_21

					if var_105_21 + var_105_14 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_21 + var_105_14
					end
				end
			end

			local var_105_22 = 0
			local var_105_23 = math.max(var_105_22, arg_102_1.talkMaxDuration)

			if var_105_14 <= arg_102_1.time_ and arg_102_1.time_ < var_105_14 + var_105_23 then
				local var_105_24 = (arg_102_1.time_ - var_105_14) / var_105_23

				arg_102_1.fswtw_.percent = Mathf.Lerp(arg_102_1.var_.oldValueTypewriter, var_105_19, var_105_24)
				arg_102_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_102_1.fswtw_:SetDirty()
			end

			if arg_102_1.time_ >= var_105_14 + var_105_23 and arg_102_1.time_ < var_105_14 + var_105_23 + arg_105_0 then
				arg_102_1.fswtw_.percent = var_105_19

				arg_102_1.fswtw_:SetDirty()
				arg_102_1:ShowNextGo(true)

				arg_102_1.typewritterCharCountI18N = var_105_20
			end

			local var_105_25 = 0.283333333332333

			if var_105_25 < arg_102_1.time_ and arg_102_1.time_ <= var_105_25 + arg_105_0 then
				arg_102_1.var_.oldValueTypewriter = arg_102_1.fswtw_.percent

				SetActive(arg_102_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_102_1:ShowNextGo(false)
			end

			local var_105_26 = 4
			local var_105_27 = 0.266666666666667
			local var_105_28 = arg_102_1:GetWordFromCfg(319931024)
			local var_105_29 = arg_102_1:FormatText(var_105_28.content)
			local var_105_30, var_105_31 = arg_102_1:GetPercentByPara(var_105_29, 1)

			if var_105_25 < arg_102_1.time_ and arg_102_1.time_ <= var_105_25 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0

				local var_105_32 = var_105_26 <= 0 and var_105_27 or var_105_27 * ((var_105_31 - arg_102_1.typewritterCharCountI18N) / var_105_26)

				if var_105_32 > 0 and var_105_27 < var_105_32 then
					arg_102_1.talkMaxDuration = var_105_32

					if var_105_32 + var_105_25 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_32 + var_105_25
					end
				end
			end

			local var_105_33 = 0.266666666666667
			local var_105_34 = math.max(var_105_33, arg_102_1.talkMaxDuration)

			if var_105_25 <= arg_102_1.time_ and arg_102_1.time_ < var_105_25 + var_105_34 then
				local var_105_35 = (arg_102_1.time_ - var_105_25) / var_105_34

				arg_102_1.fswtw_.percent = Mathf.Lerp(arg_102_1.var_.oldValueTypewriter, var_105_30, var_105_35)
				arg_102_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_102_1.fswtw_:SetDirty()
			end

			if arg_102_1.time_ >= var_105_25 + var_105_34 and arg_102_1.time_ < var_105_25 + var_105_34 + arg_105_0 then
				arg_102_1.fswtw_.percent = var_105_30

				arg_102_1.fswtw_:SetDirty()
				arg_102_1:ShowNextGo(true)

				arg_102_1.typewritterCharCountI18N = var_105_31
			end

			local var_105_36 = 0

			if var_105_36 < arg_102_1.time_ and arg_102_1.time_ <= var_105_36 + arg_105_0 then
				arg_102_1.cswbg_:SetActive(true)

				local var_105_37 = arg_102_1.cswt_:GetComponent("RectTransform")

				arg_102_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_105_37.offsetMin = Vector2.New(410, 330)
				var_105_37.offsetMax = Vector2.New(-400, -175)

				local var_105_38 = arg_102_1:GetWordFromCfg(419080)
				local var_105_39 = arg_102_1:FormatText(var_105_38.content)

				arg_102_1.cswt_.text = var_105_39

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.cswt_)

				arg_102_1.cswt_.fontSize = 180
				arg_102_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_102_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_102_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play319931025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 319931025
		arg_106_1.duration_ = 5.9

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play319931026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.fswbg_:SetActive(false)
				arg_106_1.dialog_:SetActive(false)
				SetActive(arg_106_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_106_1:ShowNextGo(false)
			end

			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.fswbg_:SetActive(false)
				arg_106_1.dialog_:SetActive(false)
				SetActive(arg_106_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_106_1:ShowNextGo(false)
			end

			local var_109_2 = 0.149999999998999

			if var_109_2 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.var_.oldValueTypewriter = arg_106_1.fswtw_.percent

				SetActive(arg_106_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_106_1:ShowNextGo(false)
			end

			local var_109_3 = 0
			local var_109_4 = 0
			local var_109_5 = arg_106_1:GetWordFromCfg(319931024)
			local var_109_6 = arg_106_1:FormatText(var_109_5.content)
			local var_109_7, var_109_8 = arg_106_1:GetPercentByPara(var_109_6, 1)

			if var_109_2 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0

				local var_109_9 = var_109_3 <= 0 and var_109_4 or var_109_4 * ((var_109_8 - arg_106_1.typewritterCharCountI18N) / var_109_3)

				if var_109_9 > 0 and var_109_4 < var_109_9 then
					arg_106_1.talkMaxDuration = var_109_9

					if var_109_9 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_2
					end
				end
			end

			local var_109_10 = 0
			local var_109_11 = math.max(var_109_10, arg_106_1.talkMaxDuration)

			if var_109_2 <= arg_106_1.time_ and arg_106_1.time_ < var_109_2 + var_109_11 then
				local var_109_12 = (arg_106_1.time_ - var_109_2) / var_109_11

				arg_106_1.fswtw_.percent = Mathf.Lerp(arg_106_1.var_.oldValueTypewriter, var_109_7, var_109_12)
				arg_106_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_106_1.fswtw_:SetDirty()
			end

			if arg_106_1.time_ >= var_109_2 + var_109_11 and arg_106_1.time_ < var_109_2 + var_109_11 + arg_109_0 then
				arg_106_1.fswtw_.percent = var_109_7

				arg_106_1.fswtw_:SetDirty()
				arg_106_1:ShowNextGo(true)

				arg_106_1.typewritterCharCountI18N = var_109_8
			end

			local var_109_13 = 0

			if var_109_13 < arg_106_1.time_ and arg_106_1.time_ <= var_109_13 + arg_109_0 then
				arg_106_1.cswbg_:SetActive(false)
			end

			local var_109_14 = 0

			if var_109_14 < arg_106_1.time_ and arg_106_1.time_ <= var_109_14 + arg_109_0 then
				local var_109_15 = manager.ui.mainCamera.transform.localPosition
				local var_109_16 = Vector3.New(0, 0, 10) + Vector3.New(var_109_15.x, var_109_15.y, 0)
				local var_109_17 = arg_106_1.bgs_.STblack

				var_109_17.transform.localPosition = var_109_16
				var_109_17.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_109_18 = var_109_17:GetComponent("SpriteRenderer")

				if var_109_18 and var_109_18.sprite then
					local var_109_19 = (var_109_17.transform.localPosition - var_109_15).z
					local var_109_20 = manager.ui.mainCameraCom_
					local var_109_21 = 2 * var_109_19 * Mathf.Tan(var_109_20.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_109_22 = var_109_21 * var_109_20.aspect
					local var_109_23 = var_109_18.sprite.bounds.size.x
					local var_109_24 = var_109_18.sprite.bounds.size.y
					local var_109_25 = var_109_22 / var_109_23
					local var_109_26 = var_109_21 / var_109_24
					local var_109_27 = var_109_26 < var_109_25 and var_109_25 or var_109_26

					var_109_17.transform.localScale = Vector3.New(var_109_27, var_109_27, 0)
				end

				for iter_109_0, iter_109_1 in pairs(arg_106_1.bgs_) do
					if iter_109_0 ~= "STblack" then
						iter_109_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_109_28 = 1.00008890058234e-12

			if var_109_28 < arg_106_1.time_ and arg_106_1.time_ <= var_109_28 + arg_109_0 then
				arg_106_1.mask_.enabled = true
				arg_106_1.mask_.raycastTarget = true

				arg_106_1:SetGaussion(false)
			end

			local var_109_29 = 1

			if var_109_28 <= arg_106_1.time_ and arg_106_1.time_ < var_109_28 + var_109_29 then
				local var_109_30 = (arg_106_1.time_ - var_109_28) / var_109_29
				local var_109_31 = Color.New(0, 0, 0)

				var_109_31.a = Mathf.Lerp(1, 0, var_109_30)
				arg_106_1.mask_.color = var_109_31
			end

			if arg_106_1.time_ >= var_109_28 + var_109_29 and arg_106_1.time_ < var_109_28 + var_109_29 + arg_109_0 then
				local var_109_32 = Color.New(0, 0, 0)
				local var_109_33 = 0

				arg_106_1.mask_.enabled = false
				var_109_32.a = var_109_33
				arg_106_1.mask_.color = var_109_32
			end

			if arg_106_1.frameCnt_ <= 1 then
				arg_106_1.dialog_:SetActive(false)
			end

			local var_109_34 = 0.9
			local var_109_35 = 1.7

			if var_109_34 < arg_106_1.time_ and arg_106_1.time_ <= var_109_34 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0

				arg_106_1.dialog_:SetActive(true)

				arg_106_1.dialogCg_.alpha = 0

				local var_109_36 = LeanTween.value(arg_106_1.dialog_, 0, 1, 0.3)

				var_109_36:setOnUpdate(LuaHelper.FloatAction(function(arg_110_0)
					arg_106_1.dialogCg_.alpha = arg_110_0
				end))
				var_109_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_106_1.dialog_)
					var_109_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_106_1.duration_ = arg_106_1.duration_ + 0.3

				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_37 = arg_106_1:GetWordFromCfg(319931025)
				local var_109_38 = arg_106_1:FormatText(var_109_37.content)

				arg_106_1.text_.text = var_109_38

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_39 = 68
				local var_109_40 = utf8.len(var_109_38)
				local var_109_41 = var_109_39 <= 0 and var_109_35 or var_109_35 * (var_109_40 / var_109_39)

				if var_109_41 > 0 and var_109_35 < var_109_41 then
					arg_106_1.talkMaxDuration = var_109_41
					var_109_34 = var_109_34 + 0.3

					if var_109_41 + var_109_34 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_41 + var_109_34
					end
				end

				arg_106_1.text_.text = var_109_38
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_42 = var_109_34 + 0.3
			local var_109_43 = math.max(var_109_35, arg_106_1.talkMaxDuration)

			if var_109_42 <= arg_106_1.time_ and arg_106_1.time_ < var_109_42 + var_109_43 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_42) / var_109_43

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_42 + var_109_43 and arg_106_1.time_ < var_109_42 + var_109_43 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play319931026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 319931026
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play319931027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.2

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				local var_115_2 = "play"
				local var_115_3 = "music"

				arg_112_1:AudioAction(var_115_2, var_115_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_115_4 = ""
				local var_115_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_115_5 ~= "" then
					if arg_112_1.bgmTxt_.text ~= var_115_5 and arg_112_1.bgmTxt_.text ~= "" then
						if arg_112_1.bgmTxt2_.text ~= "" then
							arg_112_1.bgmTxt_.text = arg_112_1.bgmTxt2_.text
						end

						arg_112_1.bgmTxt2_.text = var_115_5

						arg_112_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_112_1.bgmTxt_.text = var_115_5
						arg_112_1.bgmTxt2_.text = var_115_5
					end

					if arg_112_1.bgmTimer then
						arg_112_1.bgmTimer:Stop()

						arg_112_1.bgmTimer = nil
					end

					if arg_112_1.settingData.show_music_name == 1 then
						arg_112_1.musicController:SetSelectedState("show")
						arg_112_1.musicAnimator_:Play("open", 0, 0)

						if arg_112_1.settingData.music_time ~= 0 then
							arg_112_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_112_1.settingData.music_time), function()
								if arg_112_1 == nil or isNil(arg_112_1.bgmTxt_) then
									return
								end

								arg_112_1.musicController:SetSelectedState("hide")
								arg_112_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_115_6 = 0
			local var_115_7 = 0.775

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_8 = arg_112_1:GetWordFromCfg(319931026)
				local var_115_9 = arg_112_1:FormatText(var_115_8.content)

				arg_112_1.text_.text = var_115_9

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_10 = 31
				local var_115_11 = utf8.len(var_115_9)
				local var_115_12 = var_115_10 <= 0 and var_115_7 or var_115_7 * (var_115_11 / var_115_10)

				if var_115_12 > 0 and var_115_7 < var_115_12 then
					arg_112_1.talkMaxDuration = var_115_12

					if var_115_12 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_12 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_9
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_13 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_13 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_13

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_13 and arg_112_1.time_ < var_115_6 + var_115_13 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play319931027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319931027
		arg_117_1.duration_ = 6

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play319931028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				local var_120_1 = manager.ui.mainCamera.transform.localPosition
				local var_120_2 = Vector3.New(0, 0, 10) + Vector3.New(var_120_1.x, var_120_1.y, 0)
				local var_120_3 = arg_117_1.bgs_.I11r

				var_120_3.transform.localPosition = var_120_2
				var_120_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_4 = var_120_3:GetComponent("SpriteRenderer")

				if var_120_4 and var_120_4.sprite then
					local var_120_5 = (var_120_3.transform.localPosition - var_120_1).z
					local var_120_6 = manager.ui.mainCameraCom_
					local var_120_7 = 2 * var_120_5 * Mathf.Tan(var_120_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_120_8 = var_120_7 * var_120_6.aspect
					local var_120_9 = var_120_4.sprite.bounds.size.x
					local var_120_10 = var_120_4.sprite.bounds.size.y
					local var_120_11 = var_120_8 / var_120_9
					local var_120_12 = var_120_7 / var_120_10
					local var_120_13 = var_120_12 < var_120_11 and var_120_11 or var_120_12

					var_120_3.transform.localScale = Vector3.New(var_120_13, var_120_13, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "I11r" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_14 = 1

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			local var_120_15 = 0.3

			if arg_117_1.time_ >= var_120_14 + var_120_15 and arg_117_1.time_ < var_120_14 + var_120_15 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end

			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_17 = 1

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_17 then
				local var_120_18 = (arg_117_1.time_ - var_120_16) / var_120_17
				local var_120_19 = Color.New(0, 0, 0)

				var_120_19.a = Mathf.Lerp(1, 0, var_120_18)
				arg_117_1.mask_.color = var_120_19
			end

			if arg_117_1.time_ >= var_120_16 + var_120_17 and arg_117_1.time_ < var_120_16 + var_120_17 + arg_120_0 then
				local var_120_20 = Color.New(0, 0, 0)
				local var_120_21 = 0

				arg_117_1.mask_.enabled = false
				var_120_20.a = var_120_21
				arg_117_1.mask_.color = var_120_20
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_22 = 1
			local var_120_23 = 0.35

			if var_120_22 < arg_117_1.time_ and arg_117_1.time_ <= var_120_22 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_24 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_24:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_25 = arg_117_1:GetWordFromCfg(319931027)
				local var_120_26 = arg_117_1:FormatText(var_120_25.content)

				arg_117_1.text_.text = var_120_26

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_27 = 14
				local var_120_28 = utf8.len(var_120_26)
				local var_120_29 = var_120_27 <= 0 and var_120_23 or var_120_23 * (var_120_28 / var_120_27)

				if var_120_29 > 0 and var_120_23 < var_120_29 then
					arg_117_1.talkMaxDuration = var_120_29
					var_120_22 = var_120_22 + 0.3

					if var_120_29 + var_120_22 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_29 + var_120_22
					end
				end

				arg_117_1.text_.text = var_120_26
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_30 = var_120_22 + 0.3
			local var_120_31 = math.max(var_120_23, arg_117_1.talkMaxDuration)

			if var_120_30 <= arg_117_1.time_ and arg_117_1.time_ < var_120_30 + var_120_31 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_30) / var_120_31

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_30 + var_120_31 and arg_117_1.time_ < var_120_30 + var_120_31 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play319931028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319931028
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play319931029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 1.5

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_2 = arg_123_1:GetWordFromCfg(319931028)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 60
				local var_126_5 = utf8.len(var_126_3)
				local var_126_6 = var_126_4 <= 0 and var_126_1 or var_126_1 * (var_126_5 / var_126_4)

				if var_126_6 > 0 and var_126_1 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_7 and arg_123_1.time_ < var_126_0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play319931029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319931029
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play319931030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.85

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_2 = arg_127_1:GetWordFromCfg(319931029)
				local var_130_3 = arg_127_1:FormatText(var_130_2.content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 34
				local var_130_5 = utf8.len(var_130_3)
				local var_130_6 = var_130_4 <= 0 and var_130_1 or var_130_1 * (var_130_5 / var_130_4)

				if var_130_6 > 0 and var_130_1 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_7 and arg_127_1.time_ < var_130_0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play319931030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319931030
		arg_131_1.duration_ = 3.93

		local var_131_0 = {
			zh = 2,
			ja = 3.933
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play319931031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10075ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos10075ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0, -0.715, -6.15)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10075ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, -0.715, -6.15)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["10075ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect10075ui_story == nil then
				arg_131_1.var_.characterEffect10075ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect10075ui_story and not isNil(var_134_9) then
					arg_131_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect10075ui_story then
				arg_131_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_134_13 = 0

			if var_134_13 < arg_131_1.time_ and arg_131_1.time_ <= var_134_13 + arg_134_0 then
				arg_131_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action3_1")
			end

			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 then
				arg_131_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_134_15 = 0
			local var_134_16 = 0.2

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				local var_134_17 = "play"
				local var_134_18 = "music"

				arg_131_1:AudioAction(var_134_17, var_134_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_134_19 = ""
				local var_134_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_134_20 ~= "" then
					if arg_131_1.bgmTxt_.text ~= var_134_20 and arg_131_1.bgmTxt_.text ~= "" then
						if arg_131_1.bgmTxt2_.text ~= "" then
							arg_131_1.bgmTxt_.text = arg_131_1.bgmTxt2_.text
						end

						arg_131_1.bgmTxt2_.text = var_134_20

						arg_131_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_131_1.bgmTxt_.text = var_134_20
						arg_131_1.bgmTxt2_.text = var_134_20
					end

					if arg_131_1.bgmTimer then
						arg_131_1.bgmTimer:Stop()

						arg_131_1.bgmTimer = nil
					end

					if arg_131_1.settingData.show_music_name == 1 then
						arg_131_1.musicController:SetSelectedState("show")
						arg_131_1.musicAnimator_:Play("open", 0, 0)

						if arg_131_1.settingData.music_time ~= 0 then
							arg_131_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_131_1.settingData.music_time), function()
								if arg_131_1 == nil or isNil(arg_131_1.bgmTxt_) then
									return
								end

								arg_131_1.musicController:SetSelectedState("hide")
								arg_131_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_134_21 = 0.233333333333333
			local var_134_22 = 1

			if var_134_21 < arg_131_1.time_ and arg_131_1.time_ <= var_134_21 + arg_134_0 then
				local var_134_23 = "play"
				local var_134_24 = "music"

				arg_131_1:AudioAction(var_134_23, var_134_24, "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room.awb")

				local var_134_25 = ""
				local var_134_26 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room")

				if var_134_26 ~= "" then
					if arg_131_1.bgmTxt_.text ~= var_134_26 and arg_131_1.bgmTxt_.text ~= "" then
						if arg_131_1.bgmTxt2_.text ~= "" then
							arg_131_1.bgmTxt_.text = arg_131_1.bgmTxt2_.text
						end

						arg_131_1.bgmTxt2_.text = var_134_26

						arg_131_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_131_1.bgmTxt_.text = var_134_26
						arg_131_1.bgmTxt2_.text = var_134_26
					end

					if arg_131_1.bgmTimer then
						arg_131_1.bgmTimer:Stop()

						arg_131_1.bgmTimer = nil
					end

					if arg_131_1.settingData.show_music_name == 1 then
						arg_131_1.musicController:SetSelectedState("show")
						arg_131_1.musicAnimator_:Play("open", 0, 0)

						if arg_131_1.settingData.music_time ~= 0 then
							arg_131_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_131_1.settingData.music_time), function()
								if arg_131_1 == nil or isNil(arg_131_1.bgmTxt_) then
									return
								end

								arg_131_1.musicController:SetSelectedState("hide")
								arg_131_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_134_27 = 0
			local var_134_28 = 0.2

			if var_134_27 < arg_131_1.time_ and arg_131_1.time_ <= var_134_27 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_29 = arg_131_1:FormatText(StoryNameCfg[692].name)

				arg_131_1.leftNameTxt_.text = var_134_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_30 = arg_131_1:GetWordFromCfg(319931030)
				local var_134_31 = arg_131_1:FormatText(var_134_30.content)

				arg_131_1.text_.text = var_134_31

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_32 = 8
				local var_134_33 = utf8.len(var_134_31)
				local var_134_34 = var_134_32 <= 0 and var_134_28 or var_134_28 * (var_134_33 / var_134_32)

				if var_134_34 > 0 and var_134_28 < var_134_34 then
					arg_131_1.talkMaxDuration = var_134_34

					if var_134_34 + var_134_27 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_34 + var_134_27
					end
				end

				arg_131_1.text_.text = var_134_31
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931030", "story_v_out_319931.awb") ~= 0 then
					local var_134_35 = manager.audio:GetVoiceLength("story_v_out_319931", "319931030", "story_v_out_319931.awb") / 1000

					if var_134_35 + var_134_27 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_35 + var_134_27
					end

					if var_134_30.prefab_name ~= "" and arg_131_1.actors_[var_134_30.prefab_name] ~= nil then
						local var_134_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_30.prefab_name].transform, "story_v_out_319931", "319931030", "story_v_out_319931.awb")

						arg_131_1:RecordAudio("319931030", var_134_36)
						arg_131_1:RecordAudio("319931030", var_134_36)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319931", "319931030", "story_v_out_319931.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319931", "319931030", "story_v_out_319931.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_37 = math.max(var_134_28, arg_131_1.talkMaxDuration)

			if var_134_27 <= arg_131_1.time_ and arg_131_1.time_ < var_134_27 + var_134_37 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_27) / var_134_37

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_27 + var_134_37 and arg_131_1.time_ < var_134_27 + var_134_37 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play319931031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319931031
		arg_137_1.duration_ = 4.13

		local var_137_0 = {
			zh = 2.933,
			ja = 4.133
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
				arg_137_0:Play319931032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10079ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos10079ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0.7, -0.95, -6.05)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10079ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = arg_137_1.actors_["10079ui_story"]
			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect10079ui_story == nil then
				arg_137_1.var_.characterEffect10079ui_story = var_140_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_11 = 0.200000002980232

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_11 and not isNil(var_140_9) then
				local var_140_12 = (arg_137_1.time_ - var_140_10) / var_140_11

				if arg_137_1.var_.characterEffect10079ui_story and not isNil(var_140_9) then
					arg_137_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_10 + var_140_11 and arg_137_1.time_ < var_140_10 + var_140_11 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect10079ui_story then
				arg_137_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_140_13 = 0

			if var_140_13 < arg_137_1.time_ and arg_137_1.time_ <= var_140_13 + arg_140_0 then
				arg_137_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_140_14 = 0

			if var_140_14 < arg_137_1.time_ and arg_137_1.time_ <= var_140_14 + arg_140_0 then
				arg_137_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_15 = arg_137_1.actors_["10075ui_story"].transform
			local var_140_16 = 0

			if var_140_16 < arg_137_1.time_ and arg_137_1.time_ <= var_140_16 + arg_140_0 then
				arg_137_1.var_.moveOldPos10075ui_story = var_140_15.localPosition
			end

			local var_140_17 = 0.001

			if var_140_16 <= arg_137_1.time_ and arg_137_1.time_ < var_140_16 + var_140_17 then
				local var_140_18 = (arg_137_1.time_ - var_140_16) / var_140_17
				local var_140_19 = Vector3.New(-0.7, -0.715, -6.15)

				var_140_15.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10075ui_story, var_140_19, var_140_18)

				local var_140_20 = manager.ui.mainCamera.transform.position - var_140_15.position

				var_140_15.forward = Vector3.New(var_140_20.x, var_140_20.y, var_140_20.z)

				local var_140_21 = var_140_15.localEulerAngles

				var_140_21.z = 0
				var_140_21.x = 0
				var_140_15.localEulerAngles = var_140_21
			end

			if arg_137_1.time_ >= var_140_16 + var_140_17 and arg_137_1.time_ < var_140_16 + var_140_17 + arg_140_0 then
				var_140_15.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_140_22 = manager.ui.mainCamera.transform.position - var_140_15.position

				var_140_15.forward = Vector3.New(var_140_22.x, var_140_22.y, var_140_22.z)

				local var_140_23 = var_140_15.localEulerAngles

				var_140_23.z = 0
				var_140_23.x = 0
				var_140_15.localEulerAngles = var_140_23
			end

			local var_140_24 = arg_137_1.actors_["10075ui_story"]
			local var_140_25 = 0

			if var_140_25 < arg_137_1.time_ and arg_137_1.time_ <= var_140_25 + arg_140_0 and not isNil(var_140_24) and arg_137_1.var_.characterEffect10075ui_story == nil then
				arg_137_1.var_.characterEffect10075ui_story = var_140_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_26 = 0.200000002980232

			if var_140_25 <= arg_137_1.time_ and arg_137_1.time_ < var_140_25 + var_140_26 and not isNil(var_140_24) then
				local var_140_27 = (arg_137_1.time_ - var_140_25) / var_140_26

				if arg_137_1.var_.characterEffect10075ui_story and not isNil(var_140_24) then
					local var_140_28 = Mathf.Lerp(0, 0.5, var_140_27)

					arg_137_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10075ui_story.fillRatio = var_140_28
				end
			end

			if arg_137_1.time_ >= var_140_25 + var_140_26 and arg_137_1.time_ < var_140_25 + var_140_26 + arg_140_0 and not isNil(var_140_24) and arg_137_1.var_.characterEffect10075ui_story then
				local var_140_29 = 0.5

				arg_137_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10075ui_story.fillRatio = var_140_29
			end

			local var_140_30 = 0
			local var_140_31 = 0.375

			if var_140_30 < arg_137_1.time_ and arg_137_1.time_ <= var_140_30 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_32 = arg_137_1:FormatText(StoryNameCfg[6].name)

				arg_137_1.leftNameTxt_.text = var_140_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_33 = arg_137_1:GetWordFromCfg(319931031)
				local var_140_34 = arg_137_1:FormatText(var_140_33.content)

				arg_137_1.text_.text = var_140_34

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_35 = 15
				local var_140_36 = utf8.len(var_140_34)
				local var_140_37 = var_140_35 <= 0 and var_140_31 or var_140_31 * (var_140_36 / var_140_35)

				if var_140_37 > 0 and var_140_31 < var_140_37 then
					arg_137_1.talkMaxDuration = var_140_37

					if var_140_37 + var_140_30 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_37 + var_140_30
					end
				end

				arg_137_1.text_.text = var_140_34
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931031", "story_v_out_319931.awb") ~= 0 then
					local var_140_38 = manager.audio:GetVoiceLength("story_v_out_319931", "319931031", "story_v_out_319931.awb") / 1000

					if var_140_38 + var_140_30 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_38 + var_140_30
					end

					if var_140_33.prefab_name ~= "" and arg_137_1.actors_[var_140_33.prefab_name] ~= nil then
						local var_140_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_33.prefab_name].transform, "story_v_out_319931", "319931031", "story_v_out_319931.awb")

						arg_137_1:RecordAudio("319931031", var_140_39)
						arg_137_1:RecordAudio("319931031", var_140_39)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_319931", "319931031", "story_v_out_319931.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_319931", "319931031", "story_v_out_319931.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_40 = math.max(var_140_31, arg_137_1.talkMaxDuration)

			if var_140_30 <= arg_137_1.time_ and arg_137_1.time_ < var_140_30 + var_140_40 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_30) / var_140_40

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_30 + var_140_40 and arg_137_1.time_ < var_140_30 + var_140_40 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play319931032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319931032
		arg_141_1.duration_ = 5

		local var_141_0 = {
			zh = 4.3,
			ja = 5
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
				arg_141_0:Play319931033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10079ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10079ui_story == nil then
				arg_141_1.var_.characterEffect10079ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect10079ui_story and not isNil(var_144_0) then
					local var_144_4 = Mathf.Lerp(0, 0.5, var_144_3)

					arg_141_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10079ui_story.fillRatio = var_144_4
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10079ui_story then
				local var_144_5 = 0.5

				arg_141_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10079ui_story.fillRatio = var_144_5
			end

			local var_144_6 = 0

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050actionlink/10050action435")
			end

			local var_144_7 = 0

			if var_144_7 < arg_141_1.time_ and arg_141_1.time_ <= var_144_7 + arg_144_0 then
				arg_141_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_144_8 = arg_141_1.actors_["10075ui_story"]
			local var_144_9 = 0

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.characterEffect10075ui_story == nil then
				arg_141_1.var_.characterEffect10075ui_story = var_144_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_10 = 0.200000002980232

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_10 and not isNil(var_144_8) then
				local var_144_11 = (arg_141_1.time_ - var_144_9) / var_144_10

				if arg_141_1.var_.characterEffect10075ui_story and not isNil(var_144_8) then
					arg_141_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_9 + var_144_10 and arg_141_1.time_ < var_144_9 + var_144_10 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.characterEffect10075ui_story then
				arg_141_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_144_12 = 0
			local var_144_13 = 0.35

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_14 = arg_141_1:FormatText(StoryNameCfg[692].name)

				arg_141_1.leftNameTxt_.text = var_144_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_15 = arg_141_1:GetWordFromCfg(319931032)
				local var_144_16 = arg_141_1:FormatText(var_144_15.content)

				arg_141_1.text_.text = var_144_16

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_17 = 14
				local var_144_18 = utf8.len(var_144_16)
				local var_144_19 = var_144_17 <= 0 and var_144_13 or var_144_13 * (var_144_18 / var_144_17)

				if var_144_19 > 0 and var_144_13 < var_144_19 then
					arg_141_1.talkMaxDuration = var_144_19

					if var_144_19 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_19 + var_144_12
					end
				end

				arg_141_1.text_.text = var_144_16
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931032", "story_v_out_319931.awb") ~= 0 then
					local var_144_20 = manager.audio:GetVoiceLength("story_v_out_319931", "319931032", "story_v_out_319931.awb") / 1000

					if var_144_20 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_20 + var_144_12
					end

					if var_144_15.prefab_name ~= "" and arg_141_1.actors_[var_144_15.prefab_name] ~= nil then
						local var_144_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_15.prefab_name].transform, "story_v_out_319931", "319931032", "story_v_out_319931.awb")

						arg_141_1:RecordAudio("319931032", var_144_21)
						arg_141_1:RecordAudio("319931032", var_144_21)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_319931", "319931032", "story_v_out_319931.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_319931", "319931032", "story_v_out_319931.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_22 = math.max(var_144_13, arg_141_1.talkMaxDuration)

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_22 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_12) / var_144_22

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_12 + var_144_22 and arg_141_1.time_ < var_144_12 + var_144_22 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play319931033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 319931033
		arg_145_1.duration_ = 5

		local var_145_0 = {
			zh = 3.933,
			ja = 5
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
				arg_145_0:Play319931034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10079ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect10079ui_story == nil then
				arg_145_1.var_.characterEffect10079ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect10079ui_story and not isNil(var_148_0) then
					arg_145_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect10079ui_story then
				arg_145_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_148_4 = arg_145_1.actors_["10075ui_story"]
			local var_148_5 = 0

			if var_148_5 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect10075ui_story == nil then
				arg_145_1.var_.characterEffect10075ui_story = var_148_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_6 = 0.200000002980232

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_6 and not isNil(var_148_4) then
				local var_148_7 = (arg_145_1.time_ - var_148_5) / var_148_6

				if arg_145_1.var_.characterEffect10075ui_story and not isNil(var_148_4) then
					local var_148_8 = Mathf.Lerp(0, 0.5, var_148_7)

					arg_145_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10075ui_story.fillRatio = var_148_8
				end
			end

			if arg_145_1.time_ >= var_148_5 + var_148_6 and arg_145_1.time_ < var_148_5 + var_148_6 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect10075ui_story then
				local var_148_9 = 0.5

				arg_145_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10075ui_story.fillRatio = var_148_9
			end

			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_148_11 = 0

			if var_148_11 < arg_145_1.time_ and arg_145_1.time_ <= var_148_11 + arg_148_0 then
				arg_145_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_148_12 = 0
			local var_148_13 = 0.4

			if var_148_12 < arg_145_1.time_ and arg_145_1.time_ <= var_148_12 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_14 = arg_145_1:FormatText(StoryNameCfg[6].name)

				arg_145_1.leftNameTxt_.text = var_148_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_15 = arg_145_1:GetWordFromCfg(319931033)
				local var_148_16 = arg_145_1:FormatText(var_148_15.content)

				arg_145_1.text_.text = var_148_16

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_17 = 16
				local var_148_18 = utf8.len(var_148_16)
				local var_148_19 = var_148_17 <= 0 and var_148_13 or var_148_13 * (var_148_18 / var_148_17)

				if var_148_19 > 0 and var_148_13 < var_148_19 then
					arg_145_1.talkMaxDuration = var_148_19

					if var_148_19 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_19 + var_148_12
					end
				end

				arg_145_1.text_.text = var_148_16
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931033", "story_v_out_319931.awb") ~= 0 then
					local var_148_20 = manager.audio:GetVoiceLength("story_v_out_319931", "319931033", "story_v_out_319931.awb") / 1000

					if var_148_20 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_20 + var_148_12
					end

					if var_148_15.prefab_name ~= "" and arg_145_1.actors_[var_148_15.prefab_name] ~= nil then
						local var_148_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_15.prefab_name].transform, "story_v_out_319931", "319931033", "story_v_out_319931.awb")

						arg_145_1:RecordAudio("319931033", var_148_21)
						arg_145_1:RecordAudio("319931033", var_148_21)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_319931", "319931033", "story_v_out_319931.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_319931", "319931033", "story_v_out_319931.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_22 = math.max(var_148_13, arg_145_1.talkMaxDuration)

			if var_148_12 <= arg_145_1.time_ and arg_145_1.time_ < var_148_12 + var_148_22 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_12) / var_148_22

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_12 + var_148_22 and arg_145_1.time_ < var_148_12 + var_148_22 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play319931034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 319931034
		arg_149_1.duration_ = 14.4

		local var_149_0 = {
			zh = 14.4,
			ja = 5.566
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
				arg_149_0:Play319931035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10075ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10075ui_story == nil then
				arg_149_1.var_.characterEffect10075ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect10075ui_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10075ui_story then
				arg_149_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_152_4 = 0

			if var_152_4 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action5_2")
			end

			local var_152_5 = 0

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_152_6 = arg_149_1.actors_["10079ui_story"]
			local var_152_7 = 0

			if var_152_7 < arg_149_1.time_ and arg_149_1.time_ <= var_152_7 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect10079ui_story == nil then
				arg_149_1.var_.characterEffect10079ui_story = var_152_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_8 = 0.200000002980232

			if var_152_7 <= arg_149_1.time_ and arg_149_1.time_ < var_152_7 + var_152_8 and not isNil(var_152_6) then
				local var_152_9 = (arg_149_1.time_ - var_152_7) / var_152_8

				if arg_149_1.var_.characterEffect10079ui_story and not isNil(var_152_6) then
					local var_152_10 = Mathf.Lerp(0, 0.5, var_152_9)

					arg_149_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10079ui_story.fillRatio = var_152_10
				end
			end

			if arg_149_1.time_ >= var_152_7 + var_152_8 and arg_149_1.time_ < var_152_7 + var_152_8 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect10079ui_story then
				local var_152_11 = 0.5

				arg_149_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10079ui_story.fillRatio = var_152_11
			end

			local var_152_12 = 0
			local var_152_13 = 0.8

			if var_152_12 < arg_149_1.time_ and arg_149_1.time_ <= var_152_12 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_14 = arg_149_1:FormatText(StoryNameCfg[692].name)

				arg_149_1.leftNameTxt_.text = var_152_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_15 = arg_149_1:GetWordFromCfg(319931034)
				local var_152_16 = arg_149_1:FormatText(var_152_15.content)

				arg_149_1.text_.text = var_152_16

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_17 = 32
				local var_152_18 = utf8.len(var_152_16)
				local var_152_19 = var_152_17 <= 0 and var_152_13 or var_152_13 * (var_152_18 / var_152_17)

				if var_152_19 > 0 and var_152_13 < var_152_19 then
					arg_149_1.talkMaxDuration = var_152_19

					if var_152_19 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_19 + var_152_12
					end
				end

				arg_149_1.text_.text = var_152_16
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931034", "story_v_out_319931.awb") ~= 0 then
					local var_152_20 = manager.audio:GetVoiceLength("story_v_out_319931", "319931034", "story_v_out_319931.awb") / 1000

					if var_152_20 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_20 + var_152_12
					end

					if var_152_15.prefab_name ~= "" and arg_149_1.actors_[var_152_15.prefab_name] ~= nil then
						local var_152_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_15.prefab_name].transform, "story_v_out_319931", "319931034", "story_v_out_319931.awb")

						arg_149_1:RecordAudio("319931034", var_152_21)
						arg_149_1:RecordAudio("319931034", var_152_21)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_319931", "319931034", "story_v_out_319931.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_319931", "319931034", "story_v_out_319931.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_22 = math.max(var_152_13, arg_149_1.talkMaxDuration)

			if var_152_12 <= arg_149_1.time_ and arg_149_1.time_ < var_152_12 + var_152_22 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_12) / var_152_22

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_12 + var_152_22 and arg_149_1.time_ < var_152_12 + var_152_22 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play319931035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 319931035
		arg_153_1.duration_ = 4.37

		local var_153_0 = {
			zh = 3.4,
			ja = 4.366
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
				arg_153_0:Play319931036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10079ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10079ui_story == nil then
				arg_153_1.var_.characterEffect10079ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect10079ui_story and not isNil(var_156_0) then
					arg_153_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10079ui_story then
				arg_153_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_156_4 = 0

			if var_156_4 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			local var_156_5 = 0

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_6 = arg_153_1.actors_["10075ui_story"]
			local var_156_7 = 0

			if var_156_7 < arg_153_1.time_ and arg_153_1.time_ <= var_156_7 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect10075ui_story == nil then
				arg_153_1.var_.characterEffect10075ui_story = var_156_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_8 = 0.200000002980232

			if var_156_7 <= arg_153_1.time_ and arg_153_1.time_ < var_156_7 + var_156_8 and not isNil(var_156_6) then
				local var_156_9 = (arg_153_1.time_ - var_156_7) / var_156_8

				if arg_153_1.var_.characterEffect10075ui_story and not isNil(var_156_6) then
					local var_156_10 = Mathf.Lerp(0, 0.5, var_156_9)

					arg_153_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10075ui_story.fillRatio = var_156_10
				end
			end

			if arg_153_1.time_ >= var_156_7 + var_156_8 and arg_153_1.time_ < var_156_7 + var_156_8 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect10075ui_story then
				local var_156_11 = 0.5

				arg_153_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10075ui_story.fillRatio = var_156_11
			end

			local var_156_12 = 0
			local var_156_13 = 0.3

			if var_156_12 < arg_153_1.time_ and arg_153_1.time_ <= var_156_12 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_14 = arg_153_1:FormatText(StoryNameCfg[6].name)

				arg_153_1.leftNameTxt_.text = var_156_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_15 = arg_153_1:GetWordFromCfg(319931035)
				local var_156_16 = arg_153_1:FormatText(var_156_15.content)

				arg_153_1.text_.text = var_156_16

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_17 = 12
				local var_156_18 = utf8.len(var_156_16)
				local var_156_19 = var_156_17 <= 0 and var_156_13 or var_156_13 * (var_156_18 / var_156_17)

				if var_156_19 > 0 and var_156_13 < var_156_19 then
					arg_153_1.talkMaxDuration = var_156_19

					if var_156_19 + var_156_12 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_19 + var_156_12
					end
				end

				arg_153_1.text_.text = var_156_16
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931035", "story_v_out_319931.awb") ~= 0 then
					local var_156_20 = manager.audio:GetVoiceLength("story_v_out_319931", "319931035", "story_v_out_319931.awb") / 1000

					if var_156_20 + var_156_12 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_20 + var_156_12
					end

					if var_156_15.prefab_name ~= "" and arg_153_1.actors_[var_156_15.prefab_name] ~= nil then
						local var_156_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_15.prefab_name].transform, "story_v_out_319931", "319931035", "story_v_out_319931.awb")

						arg_153_1:RecordAudio("319931035", var_156_21)
						arg_153_1:RecordAudio("319931035", var_156_21)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_319931", "319931035", "story_v_out_319931.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_319931", "319931035", "story_v_out_319931.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_22 = math.max(var_156_13, arg_153_1.talkMaxDuration)

			if var_156_12 <= arg_153_1.time_ and arg_153_1.time_ < var_156_12 + var_156_22 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_12) / var_156_22

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_12 + var_156_22 and arg_153_1.time_ < var_156_12 + var_156_22 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play319931036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 319931036
		arg_157_1.duration_ = 13.1

		local var_157_0 = {
			zh = 9.966,
			ja = 13.1
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
				arg_157_0:Play319931037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10079ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect10079ui_story == nil then
				arg_157_1.var_.characterEffect10079ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect10079ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10079ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect10079ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10079ui_story.fillRatio = var_160_5
			end

			local var_160_6 = arg_157_1.actors_["10075ui_story"]
			local var_160_7 = 0

			if var_160_7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect10075ui_story == nil then
				arg_157_1.var_.characterEffect10075ui_story = var_160_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_8 = 0.200000002980232

			if var_160_7 <= arg_157_1.time_ and arg_157_1.time_ < var_160_7 + var_160_8 and not isNil(var_160_6) then
				local var_160_9 = (arg_157_1.time_ - var_160_7) / var_160_8

				if arg_157_1.var_.characterEffect10075ui_story and not isNil(var_160_6) then
					arg_157_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_7 + var_160_8 and arg_157_1.time_ < var_160_7 + var_160_8 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect10075ui_story then
				arg_157_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_160_10 = 0
			local var_160_11 = 0.95

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_12 = arg_157_1:FormatText(StoryNameCfg[692].name)

				arg_157_1.leftNameTxt_.text = var_160_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_13 = arg_157_1:GetWordFromCfg(319931036)
				local var_160_14 = arg_157_1:FormatText(var_160_13.content)

				arg_157_1.text_.text = var_160_14

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_15 = 38
				local var_160_16 = utf8.len(var_160_14)
				local var_160_17 = var_160_15 <= 0 and var_160_11 or var_160_11 * (var_160_16 / var_160_15)

				if var_160_17 > 0 and var_160_11 < var_160_17 then
					arg_157_1.talkMaxDuration = var_160_17

					if var_160_17 + var_160_10 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_17 + var_160_10
					end
				end

				arg_157_1.text_.text = var_160_14
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931036", "story_v_out_319931.awb") ~= 0 then
					local var_160_18 = manager.audio:GetVoiceLength("story_v_out_319931", "319931036", "story_v_out_319931.awb") / 1000

					if var_160_18 + var_160_10 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_18 + var_160_10
					end

					if var_160_13.prefab_name ~= "" and arg_157_1.actors_[var_160_13.prefab_name] ~= nil then
						local var_160_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_13.prefab_name].transform, "story_v_out_319931", "319931036", "story_v_out_319931.awb")

						arg_157_1:RecordAudio("319931036", var_160_19)
						arg_157_1:RecordAudio("319931036", var_160_19)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_319931", "319931036", "story_v_out_319931.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_319931", "319931036", "story_v_out_319931.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_20 = math.max(var_160_11, arg_157_1.talkMaxDuration)

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_20 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_10) / var_160_20

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_10 + var_160_20 and arg_157_1.time_ < var_160_10 + var_160_20 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play319931037 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319931037
		arg_161_1.duration_ = 12.53

		local var_161_0 = {
			zh = 11.233,
			ja = 12.533
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
				arg_161_0:Play319931038(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.95

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[692].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(319931037)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931037", "story_v_out_319931.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931037", "story_v_out_319931.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_319931", "319931037", "story_v_out_319931.awb")

						arg_161_1:RecordAudio("319931037", var_164_9)
						arg_161_1:RecordAudio("319931037", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_319931", "319931037", "story_v_out_319931.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_319931", "319931037", "story_v_out_319931.awb")
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
	Play319931038 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319931038
		arg_165_1.duration_ = 13.53

		local var_165_0 = {
			zh = 9.533,
			ja = 13.533
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
				arg_165_0:Play319931039(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.825

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[692].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(319931038)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931038", "story_v_out_319931.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931038", "story_v_out_319931.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_319931", "319931038", "story_v_out_319931.awb")

						arg_165_1:RecordAudio("319931038", var_168_9)
						arg_165_1:RecordAudio("319931038", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_319931", "319931038", "story_v_out_319931.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_319931", "319931038", "story_v_out_319931.awb")
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
	Play319931039 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319931039
		arg_169_1.duration_ = 20

		local var_169_0 = {
			zh = 13.333,
			ja = 20
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
				arg_169_0:Play319931040(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 1.15

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[692].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:GetWordFromCfg(319931039)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931039", "story_v_out_319931.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931039", "story_v_out_319931.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_319931", "319931039", "story_v_out_319931.awb")

						arg_169_1:RecordAudio("319931039", var_172_9)
						arg_169_1:RecordAudio("319931039", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319931", "319931039", "story_v_out_319931.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319931", "319931039", "story_v_out_319931.awb")
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
	Play319931040 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319931040
		arg_173_1.duration_ = 6.93

		local var_173_0 = {
			zh = 5.866,
			ja = 6.933
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
				arg_173_0:Play319931041(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10079ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect10079ui_story == nil then
				arg_173_1.var_.characterEffect10079ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect10079ui_story and not isNil(var_176_0) then
					arg_173_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect10079ui_story then
				arg_173_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_176_4 = 0

			if var_176_4 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_176_5 = 0

			if var_176_5 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
				arg_173_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_6 = arg_173_1.actors_["10075ui_story"]
			local var_176_7 = 0

			if var_176_7 < arg_173_1.time_ and arg_173_1.time_ <= var_176_7 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect10075ui_story == nil then
				arg_173_1.var_.characterEffect10075ui_story = var_176_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_8 = 0.200000002980232

			if var_176_7 <= arg_173_1.time_ and arg_173_1.time_ < var_176_7 + var_176_8 and not isNil(var_176_6) then
				local var_176_9 = (arg_173_1.time_ - var_176_7) / var_176_8

				if arg_173_1.var_.characterEffect10075ui_story and not isNil(var_176_6) then
					local var_176_10 = Mathf.Lerp(0, 0.5, var_176_9)

					arg_173_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10075ui_story.fillRatio = var_176_10
				end
			end

			if arg_173_1.time_ >= var_176_7 + var_176_8 and arg_173_1.time_ < var_176_7 + var_176_8 + arg_176_0 and not isNil(var_176_6) and arg_173_1.var_.characterEffect10075ui_story then
				local var_176_11 = 0.5

				arg_173_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10075ui_story.fillRatio = var_176_11
			end

			local var_176_12 = 0
			local var_176_13 = 0.6

			if var_176_12 < arg_173_1.time_ and arg_173_1.time_ <= var_176_12 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_14 = arg_173_1:FormatText(StoryNameCfg[6].name)

				arg_173_1.leftNameTxt_.text = var_176_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_15 = arg_173_1:GetWordFromCfg(319931040)
				local var_176_16 = arg_173_1:FormatText(var_176_15.content)

				arg_173_1.text_.text = var_176_16

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_17 = 24
				local var_176_18 = utf8.len(var_176_16)
				local var_176_19 = var_176_17 <= 0 and var_176_13 or var_176_13 * (var_176_18 / var_176_17)

				if var_176_19 > 0 and var_176_13 < var_176_19 then
					arg_173_1.talkMaxDuration = var_176_19

					if var_176_19 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_19 + var_176_12
					end
				end

				arg_173_1.text_.text = var_176_16
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931040", "story_v_out_319931.awb") ~= 0 then
					local var_176_20 = manager.audio:GetVoiceLength("story_v_out_319931", "319931040", "story_v_out_319931.awb") / 1000

					if var_176_20 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_20 + var_176_12
					end

					if var_176_15.prefab_name ~= "" and arg_173_1.actors_[var_176_15.prefab_name] ~= nil then
						local var_176_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_15.prefab_name].transform, "story_v_out_319931", "319931040", "story_v_out_319931.awb")

						arg_173_1:RecordAudio("319931040", var_176_21)
						arg_173_1:RecordAudio("319931040", var_176_21)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_319931", "319931040", "story_v_out_319931.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_319931", "319931040", "story_v_out_319931.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_22 = math.max(var_176_13, arg_173_1.talkMaxDuration)

			if var_176_12 <= arg_173_1.time_ and arg_173_1.time_ < var_176_12 + var_176_22 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_12) / var_176_22

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_12 + var_176_22 and arg_173_1.time_ < var_176_12 + var_176_22 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play319931041 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319931041
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play319931042(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10079ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect10079ui_story == nil then
				arg_177_1.var_.characterEffect10079ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect10079ui_story and not isNil(var_180_0) then
					local var_180_4 = Mathf.Lerp(0, 0.5, var_180_3)

					arg_177_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10079ui_story.fillRatio = var_180_4
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect10079ui_story then
				local var_180_5 = 0.5

				arg_177_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10079ui_story.fillRatio = var_180_5
			end

			local var_180_6 = arg_177_1.actors_["10079ui_story"].transform
			local var_180_7 = 0

			if var_180_7 < arg_177_1.time_ and arg_177_1.time_ <= var_180_7 + arg_180_0 then
				arg_177_1.var_.moveOldPos10079ui_story = var_180_6.localPosition
			end

			local var_180_8 = 0.001

			if var_180_7 <= arg_177_1.time_ and arg_177_1.time_ < var_180_7 + var_180_8 then
				local var_180_9 = (arg_177_1.time_ - var_180_7) / var_180_8
				local var_180_10 = Vector3.New(0, 100, 0)

				var_180_6.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10079ui_story, var_180_10, var_180_9)

				local var_180_11 = manager.ui.mainCamera.transform.position - var_180_6.position

				var_180_6.forward = Vector3.New(var_180_11.x, var_180_11.y, var_180_11.z)

				local var_180_12 = var_180_6.localEulerAngles

				var_180_12.z = 0
				var_180_12.x = 0
				var_180_6.localEulerAngles = var_180_12
			end

			if arg_177_1.time_ >= var_180_7 + var_180_8 and arg_177_1.time_ < var_180_7 + var_180_8 + arg_180_0 then
				var_180_6.localPosition = Vector3.New(0, 100, 0)

				local var_180_13 = manager.ui.mainCamera.transform.position - var_180_6.position

				var_180_6.forward = Vector3.New(var_180_13.x, var_180_13.y, var_180_13.z)

				local var_180_14 = var_180_6.localEulerAngles

				var_180_14.z = 0
				var_180_14.x = 0
				var_180_6.localEulerAngles = var_180_14
			end

			local var_180_15 = arg_177_1.actors_["10075ui_story"].transform
			local var_180_16 = 0

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 then
				arg_177_1.var_.moveOldPos10075ui_story = var_180_15.localPosition
			end

			local var_180_17 = 0.001

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_17 then
				local var_180_18 = (arg_177_1.time_ - var_180_16) / var_180_17
				local var_180_19 = Vector3.New(0, 100, 0)

				var_180_15.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10075ui_story, var_180_19, var_180_18)

				local var_180_20 = manager.ui.mainCamera.transform.position - var_180_15.position

				var_180_15.forward = Vector3.New(var_180_20.x, var_180_20.y, var_180_20.z)

				local var_180_21 = var_180_15.localEulerAngles

				var_180_21.z = 0
				var_180_21.x = 0
				var_180_15.localEulerAngles = var_180_21
			end

			if arg_177_1.time_ >= var_180_16 + var_180_17 and arg_177_1.time_ < var_180_16 + var_180_17 + arg_180_0 then
				var_180_15.localPosition = Vector3.New(0, 100, 0)

				local var_180_22 = manager.ui.mainCamera.transform.position - var_180_15.position

				var_180_15.forward = Vector3.New(var_180_22.x, var_180_22.y, var_180_22.z)

				local var_180_23 = var_180_15.localEulerAngles

				var_180_23.z = 0
				var_180_23.x = 0
				var_180_15.localEulerAngles = var_180_23
			end

			local var_180_24 = 0
			local var_180_25 = 0.9

			if var_180_24 < arg_177_1.time_ and arg_177_1.time_ <= var_180_24 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_26 = arg_177_1:GetWordFromCfg(319931041)
				local var_180_27 = arg_177_1:FormatText(var_180_26.content)

				arg_177_1.text_.text = var_180_27

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_28 = 36
				local var_180_29 = utf8.len(var_180_27)
				local var_180_30 = var_180_28 <= 0 and var_180_25 or var_180_25 * (var_180_29 / var_180_28)

				if var_180_30 > 0 and var_180_25 < var_180_30 then
					arg_177_1.talkMaxDuration = var_180_30

					if var_180_30 + var_180_24 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_30 + var_180_24
					end
				end

				arg_177_1.text_.text = var_180_27
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_31 = math.max(var_180_25, arg_177_1.talkMaxDuration)

			if var_180_24 <= arg_177_1.time_ and arg_177_1.time_ < var_180_24 + var_180_31 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_24) / var_180_31

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_24 + var_180_31 and arg_177_1.time_ < var_180_24 + var_180_31 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play319931042 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319931042
		arg_181_1.duration_ = 7

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play319931043(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = "I11i"

			if arg_181_1.bgs_[var_184_0] == nil then
				local var_184_1 = Object.Instantiate(arg_181_1.paintGo_)

				var_184_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_184_0)
				var_184_1.name = var_184_0
				var_184_1.transform.parent = arg_181_1.stage_.transform
				var_184_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.bgs_[var_184_0] = var_184_1
			end

			local var_184_2 = 1

			if var_184_2 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				local var_184_3 = manager.ui.mainCamera.transform.localPosition
				local var_184_4 = Vector3.New(0, 0, 10) + Vector3.New(var_184_3.x, var_184_3.y, 0)
				local var_184_5 = arg_181_1.bgs_.I11i

				var_184_5.transform.localPosition = var_184_4
				var_184_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_184_6 = var_184_5:GetComponent("SpriteRenderer")

				if var_184_6 and var_184_6.sprite then
					local var_184_7 = (var_184_5.transform.localPosition - var_184_3).z
					local var_184_8 = manager.ui.mainCameraCom_
					local var_184_9 = 2 * var_184_7 * Mathf.Tan(var_184_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_184_10 = var_184_9 * var_184_8.aspect
					local var_184_11 = var_184_6.sprite.bounds.size.x
					local var_184_12 = var_184_6.sprite.bounds.size.y
					local var_184_13 = var_184_10 / var_184_11
					local var_184_14 = var_184_9 / var_184_12
					local var_184_15 = var_184_14 < var_184_13 and var_184_13 or var_184_14

					var_184_5.transform.localScale = Vector3.New(var_184_15, var_184_15, 0)
				end

				for iter_184_0, iter_184_1 in pairs(arg_181_1.bgs_) do
					if iter_184_0 ~= "I11i" then
						iter_184_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_184_16 = 2

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 then
				arg_181_1.allBtn_.enabled = false
			end

			local var_184_17 = 0.3

			if arg_181_1.time_ >= var_184_16 + var_184_17 and arg_181_1.time_ < var_184_16 + var_184_17 + arg_184_0 then
				arg_181_1.allBtn_.enabled = true
			end

			local var_184_18 = 0

			if var_184_18 < arg_181_1.time_ and arg_181_1.time_ <= var_184_18 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_19 = 1

			if var_184_18 <= arg_181_1.time_ and arg_181_1.time_ < var_184_18 + var_184_19 then
				local var_184_20 = (arg_181_1.time_ - var_184_18) / var_184_19
				local var_184_21 = Color.New(0, 0, 0)

				var_184_21.a = Mathf.Lerp(0, 1, var_184_20)
				arg_181_1.mask_.color = var_184_21
			end

			if arg_181_1.time_ >= var_184_18 + var_184_19 and arg_181_1.time_ < var_184_18 + var_184_19 + arg_184_0 then
				local var_184_22 = Color.New(0, 0, 0)

				var_184_22.a = 1
				arg_181_1.mask_.color = var_184_22
			end

			local var_184_23 = 1

			if var_184_23 < arg_181_1.time_ and arg_181_1.time_ <= var_184_23 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_24 = 1

			if var_184_23 <= arg_181_1.time_ and arg_181_1.time_ < var_184_23 + var_184_24 then
				local var_184_25 = (arg_181_1.time_ - var_184_23) / var_184_24
				local var_184_26 = Color.New(0, 0, 0)

				var_184_26.a = Mathf.Lerp(1, 0, var_184_25)
				arg_181_1.mask_.color = var_184_26
			end

			if arg_181_1.time_ >= var_184_23 + var_184_24 and arg_181_1.time_ < var_184_23 + var_184_24 + arg_184_0 then
				local var_184_27 = Color.New(0, 0, 0)
				local var_184_28 = 0

				arg_181_1.mask_.enabled = false
				var_184_27.a = var_184_28
				arg_181_1.mask_.color = var_184_27
			end

			if arg_181_1.frameCnt_ <= 1 then
				arg_181_1.dialog_:SetActive(false)
			end

			local var_184_29 = 2
			local var_184_30 = 0.65

			if var_184_29 < arg_181_1.time_ and arg_181_1.time_ <= var_184_29 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				arg_181_1.dialog_:SetActive(true)

				arg_181_1.dialogCg_.alpha = 0

				local var_184_31 = LeanTween.value(arg_181_1.dialog_, 0, 1, 0.3)

				var_184_31:setOnUpdate(LuaHelper.FloatAction(function(arg_185_0)
					arg_181_1.dialogCg_.alpha = arg_185_0
				end))
				var_184_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_181_1.dialog_)
					var_184_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_181_1.duration_ = arg_181_1.duration_ + 0.3

				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_32 = arg_181_1:GetWordFromCfg(319931042)
				local var_184_33 = arg_181_1:FormatText(var_184_32.content)

				arg_181_1.text_.text = var_184_33

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_34 = 26
				local var_184_35 = utf8.len(var_184_33)
				local var_184_36 = var_184_34 <= 0 and var_184_30 or var_184_30 * (var_184_35 / var_184_34)

				if var_184_36 > 0 and var_184_30 < var_184_36 then
					arg_181_1.talkMaxDuration = var_184_36
					var_184_29 = var_184_29 + 0.3

					if var_184_36 + var_184_29 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_36 + var_184_29
					end
				end

				arg_181_1.text_.text = var_184_33
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_37 = var_184_29 + 0.3
			local var_184_38 = math.max(var_184_30, arg_181_1.talkMaxDuration)

			if var_184_37 <= arg_181_1.time_ and arg_181_1.time_ < var_184_37 + var_184_38 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_37) / var_184_38

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_37 + var_184_38 and arg_181_1.time_ < var_184_37 + var_184_38 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play319931043 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319931043
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play319931044(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.925

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_2 = arg_187_1:GetWordFromCfg(319931043)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 37
				local var_190_5 = utf8.len(var_190_3)
				local var_190_6 = var_190_4 <= 0 and var_190_1 or var_190_1 * (var_190_5 / var_190_4)

				if var_190_6 > 0 and var_190_1 < var_190_6 then
					arg_187_1.talkMaxDuration = var_190_6

					if var_190_6 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_7 and arg_187_1.time_ < var_190_0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play319931044 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 319931044
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play319931045(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 1.15

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_2 = arg_191_1:GetWordFromCfg(319931044)
				local var_194_3 = arg_191_1:FormatText(var_194_2.content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 46
				local var_194_5 = utf8.len(var_194_3)
				local var_194_6 = var_194_4 <= 0 and var_194_1 or var_194_1 * (var_194_5 / var_194_4)

				if var_194_6 > 0 and var_194_1 < var_194_6 then
					arg_191_1.talkMaxDuration = var_194_6

					if var_194_6 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_7 and arg_191_1.time_ < var_194_0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play319931045 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319931045
		arg_195_1.duration_ = 4.27

		local var_195_0 = {
			zh = 1.999999999999,
			ja = 4.266
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
				arg_195_0:Play319931046(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = "1084ui_story"

			if arg_195_1.actors_[var_198_0] == nil then
				local var_198_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_198_1) then
					local var_198_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_195_1.stage_.transform)

					var_198_2.name = var_198_0
					var_198_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_195_1.actors_[var_198_0] = var_198_2

					local var_198_3 = var_198_2:GetComponentInChildren(typeof(CharacterEffect))

					var_198_3.enabled = true

					local var_198_4 = GameObjectTools.GetOrAddComponent(var_198_2, typeof(DynamicBoneHelper))

					if var_198_4 then
						var_198_4:EnableDynamicBone(false)
					end

					arg_195_1:ShowWeapon(var_198_3.transform, false)

					arg_195_1.var_[var_198_0 .. "Animator"] = var_198_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_195_1.var_[var_198_0 .. "Animator"].applyRootMotion = true
					arg_195_1.var_[var_198_0 .. "LipSync"] = var_198_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_198_5 = arg_195_1.actors_["1084ui_story"].transform
			local var_198_6 = 0

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.var_.moveOldPos1084ui_story = var_198_5.localPosition

				local var_198_7 = "1084ui_story"

				arg_195_1:ShowWeapon(arg_195_1.var_[var_198_7 .. "Animator"].transform, false)
			end

			local var_198_8 = 0.001

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_8 then
				local var_198_9 = (arg_195_1.time_ - var_198_6) / var_198_8
				local var_198_10 = Vector3.New(0.7, -0.97, -6)

				var_198_5.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1084ui_story, var_198_10, var_198_9)

				local var_198_11 = manager.ui.mainCamera.transform.position - var_198_5.position

				var_198_5.forward = Vector3.New(var_198_11.x, var_198_11.y, var_198_11.z)

				local var_198_12 = var_198_5.localEulerAngles

				var_198_12.z = 0
				var_198_12.x = 0
				var_198_5.localEulerAngles = var_198_12
			end

			if arg_195_1.time_ >= var_198_6 + var_198_8 and arg_195_1.time_ < var_198_6 + var_198_8 + arg_198_0 then
				var_198_5.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_198_13 = manager.ui.mainCamera.transform.position - var_198_5.position

				var_198_5.forward = Vector3.New(var_198_13.x, var_198_13.y, var_198_13.z)

				local var_198_14 = var_198_5.localEulerAngles

				var_198_14.z = 0
				var_198_14.x = 0
				var_198_5.localEulerAngles = var_198_14
			end

			local var_198_15 = arg_195_1.actors_["1084ui_story"]
			local var_198_16 = 0

			if var_198_16 < arg_195_1.time_ and arg_195_1.time_ <= var_198_16 + arg_198_0 and not isNil(var_198_15) and arg_195_1.var_.characterEffect1084ui_story == nil then
				arg_195_1.var_.characterEffect1084ui_story = var_198_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_17 = 0.200000002980232

			if var_198_16 <= arg_195_1.time_ and arg_195_1.time_ < var_198_16 + var_198_17 and not isNil(var_198_15) then
				local var_198_18 = (arg_195_1.time_ - var_198_16) / var_198_17

				if arg_195_1.var_.characterEffect1084ui_story and not isNil(var_198_15) then
					arg_195_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_16 + var_198_17 and arg_195_1.time_ < var_198_16 + var_198_17 + arg_198_0 and not isNil(var_198_15) and arg_195_1.var_.characterEffect1084ui_story then
				arg_195_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_198_19 = 0

			if var_198_19 < arg_195_1.time_ and arg_195_1.time_ <= var_198_19 + arg_198_0 then
				arg_195_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_198_20 = 0

			if var_198_20 < arg_195_1.time_ and arg_195_1.time_ <= var_198_20 + arg_198_0 then
				arg_195_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_198_21 = 0
			local var_198_22 = 0.225

			if var_198_21 < arg_195_1.time_ and arg_195_1.time_ <= var_198_21 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_23 = arg_195_1:FormatText(StoryNameCfg[6].name)

				arg_195_1.leftNameTxt_.text = var_198_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_24 = arg_195_1:GetWordFromCfg(319931045)
				local var_198_25 = arg_195_1:FormatText(var_198_24.content)

				arg_195_1.text_.text = var_198_25

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_26 = 9
				local var_198_27 = utf8.len(var_198_25)
				local var_198_28 = var_198_26 <= 0 and var_198_22 or var_198_22 * (var_198_27 / var_198_26)

				if var_198_28 > 0 and var_198_22 < var_198_28 then
					arg_195_1.talkMaxDuration = var_198_28

					if var_198_28 + var_198_21 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_28 + var_198_21
					end
				end

				arg_195_1.text_.text = var_198_25
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931045", "story_v_out_319931.awb") ~= 0 then
					local var_198_29 = manager.audio:GetVoiceLength("story_v_out_319931", "319931045", "story_v_out_319931.awb") / 1000

					if var_198_29 + var_198_21 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_29 + var_198_21
					end

					if var_198_24.prefab_name ~= "" and arg_195_1.actors_[var_198_24.prefab_name] ~= nil then
						local var_198_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_24.prefab_name].transform, "story_v_out_319931", "319931045", "story_v_out_319931.awb")

						arg_195_1:RecordAudio("319931045", var_198_30)
						arg_195_1:RecordAudio("319931045", var_198_30)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_319931", "319931045", "story_v_out_319931.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_319931", "319931045", "story_v_out_319931.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_31 = math.max(var_198_22, arg_195_1.talkMaxDuration)

			if var_198_21 <= arg_195_1.time_ and arg_195_1.time_ < var_198_21 + var_198_31 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_21) / var_198_31

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_21 + var_198_31 and arg_195_1.time_ < var_198_21 + var_198_31 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play319931046 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319931046
		arg_199_1.duration_ = 13.4

		local var_199_0 = {
			zh = 13.4,
			ja = 9.266
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
				arg_199_0:Play319931047(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10075ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect10075ui_story == nil then
				arg_199_1.var_.characterEffect10075ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect10075ui_story and not isNil(var_202_0) then
					arg_199_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect10075ui_story then
				arg_199_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_202_4 = 0

			if var_202_4 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_1")
			end

			local var_202_5 = 0

			if var_202_5 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_202_6 = arg_199_1.actors_["1084ui_story"]
			local var_202_7 = 0

			if var_202_7 < arg_199_1.time_ and arg_199_1.time_ <= var_202_7 + arg_202_0 and not isNil(var_202_6) and arg_199_1.var_.characterEffect1084ui_story == nil then
				arg_199_1.var_.characterEffect1084ui_story = var_202_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_8 = 0.200000002980232

			if var_202_7 <= arg_199_1.time_ and arg_199_1.time_ < var_202_7 + var_202_8 and not isNil(var_202_6) then
				local var_202_9 = (arg_199_1.time_ - var_202_7) / var_202_8

				if arg_199_1.var_.characterEffect1084ui_story and not isNil(var_202_6) then
					local var_202_10 = Mathf.Lerp(0, 0.5, var_202_9)

					arg_199_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1084ui_story.fillRatio = var_202_10
				end
			end

			if arg_199_1.time_ >= var_202_7 + var_202_8 and arg_199_1.time_ < var_202_7 + var_202_8 + arg_202_0 and not isNil(var_202_6) and arg_199_1.var_.characterEffect1084ui_story then
				local var_202_11 = 0.5

				arg_199_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1084ui_story.fillRatio = var_202_11
			end

			local var_202_12 = arg_199_1.actors_["10075ui_story"].transform
			local var_202_13 = 0

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1.var_.moveOldPos10075ui_story = var_202_12.localPosition
			end

			local var_202_14 = 0.001

			if var_202_13 <= arg_199_1.time_ and arg_199_1.time_ < var_202_13 + var_202_14 then
				local var_202_15 = (arg_199_1.time_ - var_202_13) / var_202_14
				local var_202_16 = Vector3.New(-0.7, -0.715, -6.15)

				var_202_12.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10075ui_story, var_202_16, var_202_15)

				local var_202_17 = manager.ui.mainCamera.transform.position - var_202_12.position

				var_202_12.forward = Vector3.New(var_202_17.x, var_202_17.y, var_202_17.z)

				local var_202_18 = var_202_12.localEulerAngles

				var_202_18.z = 0
				var_202_18.x = 0
				var_202_12.localEulerAngles = var_202_18
			end

			if arg_199_1.time_ >= var_202_13 + var_202_14 and arg_199_1.time_ < var_202_13 + var_202_14 + arg_202_0 then
				var_202_12.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_202_19 = manager.ui.mainCamera.transform.position - var_202_12.position

				var_202_12.forward = Vector3.New(var_202_19.x, var_202_19.y, var_202_19.z)

				local var_202_20 = var_202_12.localEulerAngles

				var_202_20.z = 0
				var_202_20.x = 0
				var_202_12.localEulerAngles = var_202_20
			end

			local var_202_21 = 0
			local var_202_22 = 0.825

			if var_202_21 < arg_199_1.time_ and arg_199_1.time_ <= var_202_21 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_23 = arg_199_1:FormatText(StoryNameCfg[692].name)

				arg_199_1.leftNameTxt_.text = var_202_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_24 = arg_199_1:GetWordFromCfg(319931046)
				local var_202_25 = arg_199_1:FormatText(var_202_24.content)

				arg_199_1.text_.text = var_202_25

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_26 = 33
				local var_202_27 = utf8.len(var_202_25)
				local var_202_28 = var_202_26 <= 0 and var_202_22 or var_202_22 * (var_202_27 / var_202_26)

				if var_202_28 > 0 and var_202_22 < var_202_28 then
					arg_199_1.talkMaxDuration = var_202_28

					if var_202_28 + var_202_21 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_28 + var_202_21
					end
				end

				arg_199_1.text_.text = var_202_25
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931046", "story_v_out_319931.awb") ~= 0 then
					local var_202_29 = manager.audio:GetVoiceLength("story_v_out_319931", "319931046", "story_v_out_319931.awb") / 1000

					if var_202_29 + var_202_21 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_29 + var_202_21
					end

					if var_202_24.prefab_name ~= "" and arg_199_1.actors_[var_202_24.prefab_name] ~= nil then
						local var_202_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_24.prefab_name].transform, "story_v_out_319931", "319931046", "story_v_out_319931.awb")

						arg_199_1:RecordAudio("319931046", var_202_30)
						arg_199_1:RecordAudio("319931046", var_202_30)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_319931", "319931046", "story_v_out_319931.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_319931", "319931046", "story_v_out_319931.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_31 = math.max(var_202_22, arg_199_1.talkMaxDuration)

			if var_202_21 <= arg_199_1.time_ and arg_199_1.time_ < var_202_21 + var_202_31 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_21) / var_202_31

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_21 + var_202_31 and arg_199_1.time_ < var_202_21 + var_202_31 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play319931047 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 319931047
		arg_203_1.duration_ = 10

		local var_203_0 = {
			zh = 7.766,
			ja = 10
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play319931048(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.625

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[692].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:GetWordFromCfg(319931047)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 25
				local var_206_6 = utf8.len(var_206_4)
				local var_206_7 = var_206_5 <= 0 and var_206_1 or var_206_1 * (var_206_6 / var_206_5)

				if var_206_7 > 0 and var_206_1 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931047", "story_v_out_319931.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931047", "story_v_out_319931.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_319931", "319931047", "story_v_out_319931.awb")

						arg_203_1:RecordAudio("319931047", var_206_9)
						arg_203_1:RecordAudio("319931047", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_319931", "319931047", "story_v_out_319931.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_319931", "319931047", "story_v_out_319931.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_10 and arg_203_1.time_ < var_206_0 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play319931048 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 319931048
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play319931049(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10075ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10075ui_story == nil then
				arg_207_1.var_.characterEffect10075ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect10075ui_story and not isNil(var_210_0) then
					local var_210_4 = Mathf.Lerp(0, 0.5, var_210_3)

					arg_207_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10075ui_story.fillRatio = var_210_4
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10075ui_story then
				local var_210_5 = 0.5

				arg_207_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10075ui_story.fillRatio = var_210_5
			end

			local var_210_6 = 0
			local var_210_7 = 0.775

			if var_210_6 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_8 = arg_207_1:GetWordFromCfg(319931048)
				local var_210_9 = arg_207_1:FormatText(var_210_8.content)

				arg_207_1.text_.text = var_210_9

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_10 = 31
				local var_210_11 = utf8.len(var_210_9)
				local var_210_12 = var_210_10 <= 0 and var_210_7 or var_210_7 * (var_210_11 / var_210_10)

				if var_210_12 > 0 and var_210_7 < var_210_12 then
					arg_207_1.talkMaxDuration = var_210_12

					if var_210_12 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_9
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_13 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 <= arg_207_1.time_ and arg_207_1.time_ < var_210_6 + var_210_13 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_6) / var_210_13

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_6 + var_210_13 and arg_207_1.time_ < var_210_6 + var_210_13 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play319931049 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 319931049
		arg_211_1.duration_ = 7.33

		local var_211_0 = {
			zh = 3.666,
			ja = 7.333
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
				arg_211_0:Play319931050(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10075ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect10075ui_story == nil then
				arg_211_1.var_.characterEffect10075ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect10075ui_story and not isNil(var_214_0) then
					arg_211_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect10075ui_story then
				arg_211_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_214_4 = 0

			if var_214_4 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_2")
			end

			local var_214_5 = 0
			local var_214_6 = 0.3

			if var_214_5 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_7 = arg_211_1:FormatText(StoryNameCfg[692].name)

				arg_211_1.leftNameTxt_.text = var_214_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_8 = arg_211_1:GetWordFromCfg(319931049)
				local var_214_9 = arg_211_1:FormatText(var_214_8.content)

				arg_211_1.text_.text = var_214_9

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_10 = 12
				local var_214_11 = utf8.len(var_214_9)
				local var_214_12 = var_214_10 <= 0 and var_214_6 or var_214_6 * (var_214_11 / var_214_10)

				if var_214_12 > 0 and var_214_6 < var_214_12 then
					arg_211_1.talkMaxDuration = var_214_12

					if var_214_12 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_12 + var_214_5
					end
				end

				arg_211_1.text_.text = var_214_9
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931049", "story_v_out_319931.awb") ~= 0 then
					local var_214_13 = manager.audio:GetVoiceLength("story_v_out_319931", "319931049", "story_v_out_319931.awb") / 1000

					if var_214_13 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_5
					end

					if var_214_8.prefab_name ~= "" and arg_211_1.actors_[var_214_8.prefab_name] ~= nil then
						local var_214_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_8.prefab_name].transform, "story_v_out_319931", "319931049", "story_v_out_319931.awb")

						arg_211_1:RecordAudio("319931049", var_214_14)
						arg_211_1:RecordAudio("319931049", var_214_14)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_319931", "319931049", "story_v_out_319931.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_319931", "319931049", "story_v_out_319931.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_15 = math.max(var_214_6, arg_211_1.talkMaxDuration)

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_15 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_5) / var_214_15

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_5 + var_214_15 and arg_211_1.time_ < var_214_5 + var_214_15 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play319931050 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 319931050
		arg_215_1.duration_ = 6.33

		local var_215_0 = {
			zh = 5.766,
			ja = 6.333
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
				arg_215_0:Play319931051(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10075ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect10075ui_story == nil then
				arg_215_1.var_.characterEffect10075ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect10075ui_story and not isNil(var_218_0) then
					local var_218_4 = Mathf.Lerp(0, 0.5, var_218_3)

					arg_215_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_215_1.var_.characterEffect10075ui_story.fillRatio = var_218_4
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect10075ui_story then
				local var_218_5 = 0.5

				arg_215_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_215_1.var_.characterEffect10075ui_story.fillRatio = var_218_5
			end

			local var_218_6 = 0

			if var_218_6 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_218_7 = arg_215_1.actors_["1084ui_story"]
			local var_218_8 = 0

			if var_218_8 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 and not isNil(var_218_7) and arg_215_1.var_.characterEffect1084ui_story == nil then
				arg_215_1.var_.characterEffect1084ui_story = var_218_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_9 = 0.200000002980232

			if var_218_8 <= arg_215_1.time_ and arg_215_1.time_ < var_218_8 + var_218_9 and not isNil(var_218_7) then
				local var_218_10 = (arg_215_1.time_ - var_218_8) / var_218_9

				if arg_215_1.var_.characterEffect1084ui_story and not isNil(var_218_7) then
					arg_215_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_8 + var_218_9 and arg_215_1.time_ < var_218_8 + var_218_9 + arg_218_0 and not isNil(var_218_7) and arg_215_1.var_.characterEffect1084ui_story then
				arg_215_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_218_11 = 0
			local var_218_12 = 0.475

			if var_218_11 < arg_215_1.time_ and arg_215_1.time_ <= var_218_11 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_13 = arg_215_1:FormatText(StoryNameCfg[6].name)

				arg_215_1.leftNameTxt_.text = var_218_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_14 = arg_215_1:GetWordFromCfg(319931050)
				local var_218_15 = arg_215_1:FormatText(var_218_14.content)

				arg_215_1.text_.text = var_218_15

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_16 = 19
				local var_218_17 = utf8.len(var_218_15)
				local var_218_18 = var_218_16 <= 0 and var_218_12 or var_218_12 * (var_218_17 / var_218_16)

				if var_218_18 > 0 and var_218_12 < var_218_18 then
					arg_215_1.talkMaxDuration = var_218_18

					if var_218_18 + var_218_11 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_18 + var_218_11
					end
				end

				arg_215_1.text_.text = var_218_15
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931050", "story_v_out_319931.awb") ~= 0 then
					local var_218_19 = manager.audio:GetVoiceLength("story_v_out_319931", "319931050", "story_v_out_319931.awb") / 1000

					if var_218_19 + var_218_11 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_19 + var_218_11
					end

					if var_218_14.prefab_name ~= "" and arg_215_1.actors_[var_218_14.prefab_name] ~= nil then
						local var_218_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_14.prefab_name].transform, "story_v_out_319931", "319931050", "story_v_out_319931.awb")

						arg_215_1:RecordAudio("319931050", var_218_20)
						arg_215_1:RecordAudio("319931050", var_218_20)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_319931", "319931050", "story_v_out_319931.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_319931", "319931050", "story_v_out_319931.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_21 = math.max(var_218_12, arg_215_1.talkMaxDuration)

			if var_218_11 <= arg_215_1.time_ and arg_215_1.time_ < var_218_11 + var_218_21 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_11) / var_218_21

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_11 + var_218_21 and arg_215_1.time_ < var_218_11 + var_218_21 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play319931051 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 319931051
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play319931052(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1084ui_story"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1084ui_story == nil then
				arg_219_1.var_.characterEffect1084ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.characterEffect1084ui_story and not isNil(var_222_0) then
					local var_222_4 = Mathf.Lerp(0, 0.5, var_222_3)

					arg_219_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1084ui_story.fillRatio = var_222_4
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1084ui_story then
				local var_222_5 = 0.5

				arg_219_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1084ui_story.fillRatio = var_222_5
			end

			local var_222_6 = 0
			local var_222_7 = 0.5

			if var_222_6 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_8 = arg_219_1:GetWordFromCfg(319931051)
				local var_222_9 = arg_219_1:FormatText(var_222_8.content)

				arg_219_1.text_.text = var_222_9

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_10 = 20
				local var_222_11 = utf8.len(var_222_9)
				local var_222_12 = var_222_10 <= 0 and var_222_7 or var_222_7 * (var_222_11 / var_222_10)

				if var_222_12 > 0 and var_222_7 < var_222_12 then
					arg_219_1.talkMaxDuration = var_222_12

					if var_222_12 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_9
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_13 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_13 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_13

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_13 and arg_219_1.time_ < var_222_6 + var_222_13 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play319931052 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 319931052
		arg_223_1.duration_ = 4.6

		local var_223_0 = {
			zh = 4.033,
			ja = 4.6
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play319931053(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = "ML0207"

			if arg_223_1.bgs_[var_226_0] == nil then
				local var_226_1 = Object.Instantiate(arg_223_1.paintGo_)

				var_226_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_226_0)
				var_226_1.name = var_226_0
				var_226_1.transform.parent = arg_223_1.stage_.transform
				var_226_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_223_1.bgs_[var_226_0] = var_226_1
			end

			local var_226_2 = 0

			if var_226_2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				local var_226_3 = manager.ui.mainCamera.transform.localPosition
				local var_226_4 = Vector3.New(0, 0, 10) + Vector3.New(var_226_3.x, var_226_3.y, 0)
				local var_226_5 = arg_223_1.bgs_.ML0207

				var_226_5.transform.localPosition = var_226_4
				var_226_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_226_6 = var_226_5:GetComponent("SpriteRenderer")

				if var_226_6 and var_226_6.sprite then
					local var_226_7 = (var_226_5.transform.localPosition - var_226_3).z
					local var_226_8 = manager.ui.mainCameraCom_
					local var_226_9 = 2 * var_226_7 * Mathf.Tan(var_226_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_226_10 = var_226_9 * var_226_8.aspect
					local var_226_11 = var_226_6.sprite.bounds.size.x
					local var_226_12 = var_226_6.sprite.bounds.size.y
					local var_226_13 = var_226_10 / var_226_11
					local var_226_14 = var_226_9 / var_226_12
					local var_226_15 = var_226_14 < var_226_13 and var_226_13 or var_226_14

					var_226_5.transform.localScale = Vector3.New(var_226_15, var_226_15, 0)
				end

				for iter_226_0, iter_226_1 in pairs(arg_223_1.bgs_) do
					if iter_226_0 ~= "ML0207" then
						iter_226_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_226_16 = 2

			if var_226_16 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			local var_226_17 = 0.3

			if arg_223_1.time_ >= var_226_16 + var_226_17 and arg_223_1.time_ < var_226_16 + var_226_17 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end

			local var_226_18 = 0

			if var_226_18 < arg_223_1.time_ and arg_223_1.time_ <= var_226_18 + arg_226_0 then
				arg_223_1.mask_.enabled = true
				arg_223_1.mask_.raycastTarget = true

				arg_223_1:SetGaussion(false)
			end

			local var_226_19 = 2

			if var_226_18 <= arg_223_1.time_ and arg_223_1.time_ < var_226_18 + var_226_19 then
				local var_226_20 = (arg_223_1.time_ - var_226_18) / var_226_19
				local var_226_21 = Color.New(1, 1, 1)

				var_226_21.a = Mathf.Lerp(1, 0, var_226_20)
				arg_223_1.mask_.color = var_226_21
			end

			if arg_223_1.time_ >= var_226_18 + var_226_19 and arg_223_1.time_ < var_226_18 + var_226_19 + arg_226_0 then
				local var_226_22 = Color.New(1, 1, 1)
				local var_226_23 = 0

				arg_223_1.mask_.enabled = false
				var_226_22.a = var_226_23
				arg_223_1.mask_.color = var_226_22
			end

			local var_226_24 = arg_223_1.actors_["1084ui_story"].transform
			local var_226_25 = 0

			if var_226_25 < arg_223_1.time_ and arg_223_1.time_ <= var_226_25 + arg_226_0 then
				arg_223_1.var_.moveOldPos1084ui_story = var_226_24.localPosition
			end

			local var_226_26 = 0.001

			if var_226_25 <= arg_223_1.time_ and arg_223_1.time_ < var_226_25 + var_226_26 then
				local var_226_27 = (arg_223_1.time_ - var_226_25) / var_226_26
				local var_226_28 = Vector3.New(0, 100, 0)

				var_226_24.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1084ui_story, var_226_28, var_226_27)

				local var_226_29 = manager.ui.mainCamera.transform.position - var_226_24.position

				var_226_24.forward = Vector3.New(var_226_29.x, var_226_29.y, var_226_29.z)

				local var_226_30 = var_226_24.localEulerAngles

				var_226_30.z = 0
				var_226_30.x = 0
				var_226_24.localEulerAngles = var_226_30
			end

			if arg_223_1.time_ >= var_226_25 + var_226_26 and arg_223_1.time_ < var_226_25 + var_226_26 + arg_226_0 then
				var_226_24.localPosition = Vector3.New(0, 100, 0)

				local var_226_31 = manager.ui.mainCamera.transform.position - var_226_24.position

				var_226_24.forward = Vector3.New(var_226_31.x, var_226_31.y, var_226_31.z)

				local var_226_32 = var_226_24.localEulerAngles

				var_226_32.z = 0
				var_226_32.x = 0
				var_226_24.localEulerAngles = var_226_32
			end

			local var_226_33 = arg_223_1.actors_["10075ui_story"].transform
			local var_226_34 = 0

			if var_226_34 < arg_223_1.time_ and arg_223_1.time_ <= var_226_34 + arg_226_0 then
				arg_223_1.var_.moveOldPos10075ui_story = var_226_33.localPosition
			end

			local var_226_35 = 0.001

			if var_226_34 <= arg_223_1.time_ and arg_223_1.time_ < var_226_34 + var_226_35 then
				local var_226_36 = (arg_223_1.time_ - var_226_34) / var_226_35
				local var_226_37 = Vector3.New(0, 100, 0)

				var_226_33.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10075ui_story, var_226_37, var_226_36)

				local var_226_38 = manager.ui.mainCamera.transform.position - var_226_33.position

				var_226_33.forward = Vector3.New(var_226_38.x, var_226_38.y, var_226_38.z)

				local var_226_39 = var_226_33.localEulerAngles

				var_226_39.z = 0
				var_226_39.x = 0
				var_226_33.localEulerAngles = var_226_39
			end

			if arg_223_1.time_ >= var_226_34 + var_226_35 and arg_223_1.time_ < var_226_34 + var_226_35 + arg_226_0 then
				var_226_33.localPosition = Vector3.New(0, 100, 0)

				local var_226_40 = manager.ui.mainCamera.transform.position - var_226_33.position

				var_226_33.forward = Vector3.New(var_226_40.x, var_226_40.y, var_226_40.z)

				local var_226_41 = var_226_33.localEulerAngles

				var_226_41.z = 0
				var_226_41.x = 0
				var_226_33.localEulerAngles = var_226_41
			end

			local var_226_42 = arg_223_1.bgs_.ML0207.transform
			local var_226_43 = 0

			if var_226_43 < arg_223_1.time_ and arg_223_1.time_ <= var_226_43 + arg_226_0 then
				arg_223_1.var_.moveOldPosML0207 = var_226_42.localPosition
			end

			local var_226_44 = 0.001

			if var_226_43 <= arg_223_1.time_ and arg_223_1.time_ < var_226_43 + var_226_44 then
				local var_226_45 = (arg_223_1.time_ - var_226_43) / var_226_44
				local var_226_46 = Vector3.New(0, 1, 9.5)

				var_226_42.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPosML0207, var_226_46, var_226_45)
			end

			if arg_223_1.time_ >= var_226_43 + var_226_44 and arg_223_1.time_ < var_226_43 + var_226_44 + arg_226_0 then
				var_226_42.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_226_47 = arg_223_1.bgs_.ML0207.transform
			local var_226_48 = 0.0166666666666667

			if var_226_48 < arg_223_1.time_ and arg_223_1.time_ <= var_226_48 + arg_226_0 then
				arg_223_1.var_.moveOldPosML0207 = var_226_47.localPosition
			end

			local var_226_49 = 3.5

			if var_226_48 <= arg_223_1.time_ and arg_223_1.time_ < var_226_48 + var_226_49 then
				local var_226_50 = (arg_223_1.time_ - var_226_48) / var_226_49
				local var_226_51 = Vector3.New(0, 1, 10)

				var_226_47.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPosML0207, var_226_51, var_226_50)
			end

			if arg_223_1.time_ >= var_226_48 + var_226_49 and arg_223_1.time_ < var_226_48 + var_226_49 + arg_226_0 then
				var_226_47.localPosition = Vector3.New(0, 1, 10)
			end

			local var_226_52 = 2

			if var_226_52 < arg_223_1.time_ and arg_223_1.time_ <= var_226_52 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			local var_226_53 = 1.51666666666667

			if arg_223_1.time_ >= var_226_52 + var_226_53 and arg_223_1.time_ < var_226_52 + var_226_53 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end

			if arg_223_1.frameCnt_ <= 1 then
				arg_223_1.dialog_:SetActive(false)
			end

			local var_226_54 = 2
			local var_226_55 = 0.15

			if var_226_54 < arg_223_1.time_ and arg_223_1.time_ <= var_226_54 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				arg_223_1.dialog_:SetActive(true)

				arg_223_1.dialogCg_.alpha = 0

				local var_226_56 = LeanTween.value(arg_223_1.dialog_, 0, 1, 0.3)

				var_226_56:setOnUpdate(LuaHelper.FloatAction(function(arg_227_0)
					arg_223_1.dialogCg_.alpha = arg_227_0
				end))
				var_226_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_223_1.dialog_)
					var_226_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_223_1.duration_ = arg_223_1.duration_ + 0.3

				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_57 = arg_223_1:FormatText(StoryNameCfg[692].name)

				arg_223_1.leftNameTxt_.text = var_226_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_58 = arg_223_1:GetWordFromCfg(319931052)
				local var_226_59 = arg_223_1:FormatText(var_226_58.content)

				arg_223_1.text_.text = var_226_59

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_60 = 6
				local var_226_61 = utf8.len(var_226_59)
				local var_226_62 = var_226_60 <= 0 and var_226_55 or var_226_55 * (var_226_61 / var_226_60)

				if var_226_62 > 0 and var_226_55 < var_226_62 then
					arg_223_1.talkMaxDuration = var_226_62
					var_226_54 = var_226_54 + 0.3

					if var_226_62 + var_226_54 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_62 + var_226_54
					end
				end

				arg_223_1.text_.text = var_226_59
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931052", "story_v_out_319931.awb") ~= 0 then
					local var_226_63 = manager.audio:GetVoiceLength("story_v_out_319931", "319931052", "story_v_out_319931.awb") / 1000

					if var_226_63 + var_226_54 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_63 + var_226_54
					end

					if var_226_58.prefab_name ~= "" and arg_223_1.actors_[var_226_58.prefab_name] ~= nil then
						local var_226_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_58.prefab_name].transform, "story_v_out_319931", "319931052", "story_v_out_319931.awb")

						arg_223_1:RecordAudio("319931052", var_226_64)
						arg_223_1:RecordAudio("319931052", var_226_64)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_319931", "319931052", "story_v_out_319931.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_319931", "319931052", "story_v_out_319931.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_65 = var_226_54 + 0.3
			local var_226_66 = math.max(var_226_55, arg_223_1.talkMaxDuration)

			if var_226_65 <= arg_223_1.time_ and arg_223_1.time_ < var_226_65 + var_226_66 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_65) / var_226_66

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_65 + var_226_66 and arg_223_1.time_ < var_226_65 + var_226_66 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ML0207",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0207",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play319931053 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 319931053
		arg_229_1.duration_ = 5.83

		local var_229_0 = {
			zh = 2.966,
			ja = 5.833
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
				arg_229_0:Play319931054(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10075ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect10075ui_story == nil then
				arg_229_1.var_.characterEffect10075ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect10075ui_story and not isNil(var_232_0) then
					local var_232_4 = Mathf.Lerp(0, 0.5, var_232_3)

					arg_229_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_229_1.var_.characterEffect10075ui_story.fillRatio = var_232_4
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect10075ui_story then
				local var_232_5 = 0.5

				arg_229_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_229_1.var_.characterEffect10075ui_story.fillRatio = var_232_5
			end

			local var_232_6 = 0
			local var_232_7 = 0.275

			if var_232_6 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_8 = arg_229_1:FormatText(StoryNameCfg[6].name)

				arg_229_1.leftNameTxt_.text = var_232_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_9 = arg_229_1:GetWordFromCfg(319931053)
				local var_232_10 = arg_229_1:FormatText(var_232_9.content)

				arg_229_1.text_.text = var_232_10

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_11 = 11
				local var_232_12 = utf8.len(var_232_10)
				local var_232_13 = var_232_11 <= 0 and var_232_7 or var_232_7 * (var_232_12 / var_232_11)

				if var_232_13 > 0 and var_232_7 < var_232_13 then
					arg_229_1.talkMaxDuration = var_232_13

					if var_232_13 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_13 + var_232_6
					end
				end

				arg_229_1.text_.text = var_232_10
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931053", "story_v_out_319931.awb") ~= 0 then
					local var_232_14 = manager.audio:GetVoiceLength("story_v_out_319931", "319931053", "story_v_out_319931.awb") / 1000

					if var_232_14 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_14 + var_232_6
					end

					if var_232_9.prefab_name ~= "" and arg_229_1.actors_[var_232_9.prefab_name] ~= nil then
						local var_232_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_9.prefab_name].transform, "story_v_out_319931", "319931053", "story_v_out_319931.awb")

						arg_229_1:RecordAudio("319931053", var_232_15)
						arg_229_1:RecordAudio("319931053", var_232_15)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_319931", "319931053", "story_v_out_319931.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_319931", "319931053", "story_v_out_319931.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_16 = math.max(var_232_7, arg_229_1.talkMaxDuration)

			if var_232_6 <= arg_229_1.time_ and arg_229_1.time_ < var_232_6 + var_232_16 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_6) / var_232_16

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_6 + var_232_16 and arg_229_1.time_ < var_232_6 + var_232_16 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play319931054 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 319931054
		arg_233_1.duration_ = 2.43

		local var_233_0 = {
			zh = 2.366,
			ja = 2.433
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
				arg_233_0:Play319931055(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.175

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[6].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_3 = arg_233_1:GetWordFromCfg(319931054)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931054", "story_v_out_319931.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931054", "story_v_out_319931.awb") / 1000

					if var_236_8 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_0
					end

					if var_236_3.prefab_name ~= "" and arg_233_1.actors_[var_236_3.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_3.prefab_name].transform, "story_v_out_319931", "319931054", "story_v_out_319931.awb")

						arg_233_1:RecordAudio("319931054", var_236_9)
						arg_233_1:RecordAudio("319931054", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_319931", "319931054", "story_v_out_319931.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_319931", "319931054", "story_v_out_319931.awb")
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
	Play319931055 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 319931055
		arg_237_1.duration_ = 2.7

		local var_237_0 = {
			zh = 2.7,
			ja = 2.6
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play319931056(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.325

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[692].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:GetWordFromCfg(319931055)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 13
				local var_240_6 = utf8.len(var_240_4)
				local var_240_7 = var_240_5 <= 0 and var_240_1 or var_240_1 * (var_240_6 / var_240_5)

				if var_240_7 > 0 and var_240_1 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931055", "story_v_out_319931.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931055", "story_v_out_319931.awb") / 1000

					if var_240_8 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_0
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_319931", "319931055", "story_v_out_319931.awb")

						arg_237_1:RecordAudio("319931055", var_240_9)
						arg_237_1:RecordAudio("319931055", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_319931", "319931055", "story_v_out_319931.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_319931", "319931055", "story_v_out_319931.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_10 and arg_237_1.time_ < var_240_0 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play319931056 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 319931056
		arg_241_1.duration_ = 9.47

		local var_241_0 = {
			zh = 6.833,
			ja = 9.466
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play319931057(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.675

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[692].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:GetWordFromCfg(319931056)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 27
				local var_244_6 = utf8.len(var_244_4)
				local var_244_7 = var_244_5 <= 0 and var_244_1 or var_244_1 * (var_244_6 / var_244_5)

				if var_244_7 > 0 and var_244_1 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931056", "story_v_out_319931.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931056", "story_v_out_319931.awb") / 1000

					if var_244_8 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_0
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_319931", "319931056", "story_v_out_319931.awb")

						arg_241_1:RecordAudio("319931056", var_244_9)
						arg_241_1:RecordAudio("319931056", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_319931", "319931056", "story_v_out_319931.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_319931", "319931056", "story_v_out_319931.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_10 and arg_241_1.time_ < var_244_0 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play319931057 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 319931057
		arg_245_1.duration_ = 5.43

		local var_245_0 = {
			zh = 5.433,
			ja = 3.666
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
				arg_245_0:Play319931058(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.525

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[6].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:GetWordFromCfg(319931057)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931057", "story_v_out_319931.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931057", "story_v_out_319931.awb") / 1000

					if var_248_8 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_0
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_319931", "319931057", "story_v_out_319931.awb")

						arg_245_1:RecordAudio("319931057", var_248_9)
						arg_245_1:RecordAudio("319931057", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_319931", "319931057", "story_v_out_319931.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_319931", "319931057", "story_v_out_319931.awb")
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
	Play319931058 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 319931058
		arg_249_1.duration_ = 10

		local var_249_0 = {
			zh = 8.166,
			ja = 10
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play319931059(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.825

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[6].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_3 = arg_249_1:GetWordFromCfg(319931058)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 33
				local var_252_6 = utf8.len(var_252_4)
				local var_252_7 = var_252_5 <= 0 and var_252_1 or var_252_1 * (var_252_6 / var_252_5)

				if var_252_7 > 0 and var_252_1 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931058", "story_v_out_319931.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931058", "story_v_out_319931.awb") / 1000

					if var_252_8 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_0
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_319931", "319931058", "story_v_out_319931.awb")

						arg_249_1:RecordAudio("319931058", var_252_9)
						arg_249_1:RecordAudio("319931058", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_319931", "319931058", "story_v_out_319931.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_319931", "319931058", "story_v_out_319931.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_10 and arg_249_1.time_ < var_252_0 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play319931059 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 319931059
		arg_253_1.duration_ = 2

		local var_253_0 = {
			zh = 1.833,
			ja = 2
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play319931060(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.125

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[692].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_3 = arg_253_1:GetWordFromCfg(319931059)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 5
				local var_256_6 = utf8.len(var_256_4)
				local var_256_7 = var_256_5 <= 0 and var_256_1 or var_256_1 * (var_256_6 / var_256_5)

				if var_256_7 > 0 and var_256_1 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931059", "story_v_out_319931.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931059", "story_v_out_319931.awb") / 1000

					if var_256_8 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_0
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_319931", "319931059", "story_v_out_319931.awb")

						arg_253_1:RecordAudio("319931059", var_256_9)
						arg_253_1:RecordAudio("319931059", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_319931", "319931059", "story_v_out_319931.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_319931", "319931059", "story_v_out_319931.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_10 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_10 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_10

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_10 and arg_253_1.time_ < var_256_0 + var_256_10 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play319931060 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 319931060
		arg_257_1.duration_ = 2.5

		local var_257_0 = {
			zh = 1.466,
			ja = 2.5
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play319931061(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.1

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[6].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:GetWordFromCfg(319931060)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 4
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931060", "story_v_out_319931.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931060", "story_v_out_319931.awb") / 1000

					if var_260_8 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_0
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_319931", "319931060", "story_v_out_319931.awb")

						arg_257_1:RecordAudio("319931060", var_260_9)
						arg_257_1:RecordAudio("319931060", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_319931", "319931060", "story_v_out_319931.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_319931", "319931060", "story_v_out_319931.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_10 and arg_257_1.time_ < var_260_0 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play319931061 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 319931061
		arg_261_1.duration_ = 4.4

		local var_261_0 = {
			zh = 4.4,
			ja = 4.1
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play319931062(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.45

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[6].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:GetWordFromCfg(319931061)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 18
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931061", "story_v_out_319931.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931061", "story_v_out_319931.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_319931", "319931061", "story_v_out_319931.awb")

						arg_261_1:RecordAudio("319931061", var_264_9)
						arg_261_1:RecordAudio("319931061", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_319931", "319931061", "story_v_out_319931.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_319931", "319931061", "story_v_out_319931.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_10 and arg_261_1.time_ < var_264_0 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play319931062 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 319931062
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play319931063(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.5

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_2 = arg_265_1:GetWordFromCfg(319931062)
				local var_268_3 = arg_265_1:FormatText(var_268_2.content)

				arg_265_1.text_.text = var_268_3

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 20
				local var_268_5 = utf8.len(var_268_3)
				local var_268_6 = var_268_4 <= 0 and var_268_1 or var_268_1 * (var_268_5 / var_268_4)

				if var_268_6 > 0 and var_268_1 < var_268_6 then
					arg_265_1.talkMaxDuration = var_268_6

					if var_268_6 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_6 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_3
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_7 and arg_265_1.time_ < var_268_0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play319931063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 319931063
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play319931064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				local var_272_1 = manager.ui.mainCamera.transform.localPosition
				local var_272_2 = Vector3.New(0, 0, 10) + Vector3.New(var_272_1.x, var_272_1.y, 0)
				local var_272_3 = arg_269_1.bgs_.STblack

				var_272_3.transform.localPosition = var_272_2
				var_272_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_272_4 = var_272_3:GetComponent("SpriteRenderer")

				if var_272_4 and var_272_4.sprite then
					local var_272_5 = (var_272_3.transform.localPosition - var_272_1).z
					local var_272_6 = manager.ui.mainCameraCom_
					local var_272_7 = 2 * var_272_5 * Mathf.Tan(var_272_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_272_8 = var_272_7 * var_272_6.aspect
					local var_272_9 = var_272_4.sprite.bounds.size.x
					local var_272_10 = var_272_4.sprite.bounds.size.y
					local var_272_11 = var_272_8 / var_272_9
					local var_272_12 = var_272_7 / var_272_10
					local var_272_13 = var_272_12 < var_272_11 and var_272_11 or var_272_12

					var_272_3.transform.localScale = Vector3.New(var_272_13, var_272_13, 0)
				end

				for iter_272_0, iter_272_1 in pairs(arg_269_1.bgs_) do
					if iter_272_0 ~= "STblack" then
						iter_272_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_272_14 = 0

			if var_272_14 < arg_269_1.time_ and arg_269_1.time_ <= var_272_14 + arg_272_0 then
				local var_272_15 = arg_269_1.fswbg_.transform:Find("textbox/adapt/content") or arg_269_1.fswbg_.transform:Find("textbox/content")
				local var_272_16 = arg_269_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_272_17 = var_272_15:GetComponent("Text")
				local var_272_18 = var_272_15:GetComponent("RectTransform")

				var_272_17.alignment = UnityEngine.TextAnchor.LowerCenter
				var_272_18.offsetMin = Vector2.New(0, 0)
				var_272_18.offsetMax = Vector2.New(0, 0)
			end

			local var_272_19 = 0

			if var_272_19 < arg_269_1.time_ and arg_269_1.time_ <= var_272_19 + arg_272_0 then
				arg_269_1.fswbg_:SetActive(true)
				arg_269_1.dialog_:SetActive(false)

				arg_269_1.fswtw_.percent = 0

				local var_272_20 = arg_269_1:GetWordFromCfg(319931063)
				local var_272_21 = arg_269_1:FormatText(var_272_20.content)

				arg_269_1.fswt_.text = var_272_21

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.fswt_)

				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_269_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_269_1.fswtw_:SetDirty()

				arg_269_1.typewritterCharCountI18N = 0

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_22 = 0.149999999998999

			if var_272_22 < arg_269_1.time_ and arg_269_1.time_ <= var_272_22 + arg_272_0 then
				arg_269_1.var_.oldValueTypewriter = arg_269_1.fswtw_.percent

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_23 = 0
			local var_272_24 = 0
			local var_272_25 = arg_269_1:GetWordFromCfg(319931063)
			local var_272_26 = arg_269_1:FormatText(var_272_25.content)
			local var_272_27, var_272_28 = arg_269_1:GetPercentByPara(var_272_26, 1)

			if var_272_22 < arg_269_1.time_ and arg_269_1.time_ <= var_272_22 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				local var_272_29 = var_272_23 <= 0 and var_272_24 or var_272_24 * ((var_272_28 - arg_269_1.typewritterCharCountI18N) / var_272_23)

				if var_272_29 > 0 and var_272_24 < var_272_29 then
					arg_269_1.talkMaxDuration = var_272_29

					if var_272_29 + var_272_22 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_29 + var_272_22
					end
				end
			end

			local var_272_30 = 0
			local var_272_31 = math.max(var_272_30, arg_269_1.talkMaxDuration)

			if var_272_22 <= arg_269_1.time_ and arg_269_1.time_ < var_272_22 + var_272_31 then
				local var_272_32 = (arg_269_1.time_ - var_272_22) / var_272_31

				arg_269_1.fswtw_.percent = Mathf.Lerp(arg_269_1.var_.oldValueTypewriter, var_272_27, var_272_32)
				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_269_1.fswtw_:SetDirty()
			end

			if arg_269_1.time_ >= var_272_22 + var_272_31 and arg_269_1.time_ < var_272_22 + var_272_31 + arg_272_0 then
				arg_269_1.fswtw_.percent = var_272_27

				arg_269_1.fswtw_:SetDirty()
				arg_269_1:ShowNextGo(true)

				arg_269_1.typewritterCharCountI18N = var_272_28
			end

			local var_272_33 = 0.15

			if var_272_33 < arg_269_1.time_ and arg_269_1.time_ <= var_272_33 + arg_272_0 then
				arg_269_1.var_.oldValueTypewriter = arg_269_1.fswtw_.percent

				SetActive(arg_269_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_269_1:ShowNextGo(false)
			end

			local var_272_34 = 36
			local var_272_35 = 2.4
			local var_272_36 = arg_269_1:GetWordFromCfg(319931063)
			local var_272_37 = arg_269_1:FormatText(var_272_36.content)
			local var_272_38, var_272_39 = arg_269_1:GetPercentByPara(var_272_37, 1)

			if var_272_33 < arg_269_1.time_ and arg_269_1.time_ <= var_272_33 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				local var_272_40 = var_272_34 <= 0 and var_272_35 or var_272_35 * ((var_272_39 - arg_269_1.typewritterCharCountI18N) / var_272_34)

				if var_272_40 > 0 and var_272_35 < var_272_40 then
					arg_269_1.talkMaxDuration = var_272_40

					if var_272_40 + var_272_33 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_40 + var_272_33
					end
				end
			end

			local var_272_41 = 2.4
			local var_272_42 = math.max(var_272_41, arg_269_1.talkMaxDuration)

			if var_272_33 <= arg_269_1.time_ and arg_269_1.time_ < var_272_33 + var_272_42 then
				local var_272_43 = (arg_269_1.time_ - var_272_33) / var_272_42

				arg_269_1.fswtw_.percent = Mathf.Lerp(arg_269_1.var_.oldValueTypewriter, var_272_38, var_272_43)
				arg_269_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_269_1.fswtw_:SetDirty()
			end

			if arg_269_1.time_ >= var_272_33 + var_272_42 and arg_269_1.time_ < var_272_33 + var_272_42 + arg_272_0 then
				arg_269_1.fswtw_.percent = var_272_38

				arg_269_1.fswtw_:SetDirty()
				arg_269_1:ShowNextGo(true)

				arg_269_1.typewritterCharCountI18N = var_272_39
			end

			local var_272_44 = 0

			if var_272_44 < arg_269_1.time_ and arg_269_1.time_ <= var_272_44 + arg_272_0 then
				arg_269_1.cswbg_:SetActive(true)

				local var_272_45 = arg_269_1.cswt_:GetComponent("RectTransform")

				arg_269_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_272_45.offsetMin = Vector2.New(410, 330)
				var_272_45.offsetMax = Vector2.New(-400, -180)

				local var_272_46 = arg_269_1:GetWordFromCfg(419081)
				local var_272_47 = arg_269_1:FormatText(var_272_46.content)

				arg_269_1.cswt_.text = var_272_47

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.cswt_)

				arg_269_1.cswt_.fontSize = 175
				arg_269_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_269_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_269_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play319931064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 319931064
		arg_273_1.duration_ = 7

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play319931065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = "D999"

			if arg_273_1.bgs_[var_276_0] == nil then
				local var_276_1 = Object.Instantiate(arg_273_1.paintGo_)

				var_276_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_276_0)
				var_276_1.name = var_276_0
				var_276_1.transform.parent = arg_273_1.stage_.transform
				var_276_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.bgs_[var_276_0] = var_276_1
			end

			local var_276_2 = 0

			if var_276_2 < arg_273_1.time_ and arg_273_1.time_ <= var_276_2 + arg_276_0 then
				local var_276_3 = manager.ui.mainCamera.transform.localPosition
				local var_276_4 = Vector3.New(0, 0, 10) + Vector3.New(var_276_3.x, var_276_3.y, 0)
				local var_276_5 = arg_273_1.bgs_.D999

				var_276_5.transform.localPosition = var_276_4
				var_276_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_276_6 = var_276_5:GetComponent("SpriteRenderer")

				if var_276_6 and var_276_6.sprite then
					local var_276_7 = (var_276_5.transform.localPosition - var_276_3).z
					local var_276_8 = manager.ui.mainCameraCom_
					local var_276_9 = 2 * var_276_7 * Mathf.Tan(var_276_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_276_10 = var_276_9 * var_276_8.aspect
					local var_276_11 = var_276_6.sprite.bounds.size.x
					local var_276_12 = var_276_6.sprite.bounds.size.y
					local var_276_13 = var_276_10 / var_276_11
					local var_276_14 = var_276_9 / var_276_12
					local var_276_15 = var_276_14 < var_276_13 and var_276_13 or var_276_14

					var_276_5.transform.localScale = Vector3.New(var_276_15, var_276_15, 0)
				end

				for iter_276_0, iter_276_1 in pairs(arg_273_1.bgs_) do
					if iter_276_0 ~= "D999" then
						iter_276_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_276_16 = 0

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_17 = 2

			if var_276_16 <= arg_273_1.time_ and arg_273_1.time_ < var_276_16 + var_276_17 then
				local var_276_18 = (arg_273_1.time_ - var_276_16) / var_276_17
				local var_276_19 = Color.New(1, 1, 1)

				var_276_19.a = Mathf.Lerp(1, 0, var_276_18)
				arg_273_1.mask_.color = var_276_19
			end

			if arg_273_1.time_ >= var_276_16 + var_276_17 and arg_273_1.time_ < var_276_16 + var_276_17 + arg_276_0 then
				local var_276_20 = Color.New(1, 1, 1)
				local var_276_21 = 0

				arg_273_1.mask_.enabled = false
				var_276_20.a = var_276_21
				arg_273_1.mask_.color = var_276_20
			end

			local var_276_22 = 0

			if var_276_22 < arg_273_1.time_ and arg_273_1.time_ <= var_276_22 + arg_276_0 then
				arg_273_1.fswbg_:SetActive(true)
				arg_273_1.dialog_:SetActive(false)

				arg_273_1.fswtw_.percent = 0

				local var_276_23 = arg_273_1:GetWordFromCfg(319931020)
				local var_276_24 = arg_273_1:FormatText(var_276_23.content)

				arg_273_1.fswt_.text = var_276_24

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.fswt_)

				arg_273_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_273_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_273_1.fswtw_:SetDirty()

				arg_273_1.typewritterCharCountI18N = 0

				SetActive(arg_273_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_273_1:ShowNextGo(false)
			end

			local var_276_25 = 0.149999999998999

			if var_276_25 < arg_273_1.time_ and arg_273_1.time_ <= var_276_25 + arg_276_0 then
				arg_273_1.var_.oldValueTypewriter = arg_273_1.fswtw_.percent

				SetActive(arg_273_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_273_1:ShowNextGo(false)
			end

			local var_276_26 = 0
			local var_276_27 = 0
			local var_276_28 = arg_273_1:GetWordFromCfg(319931020)
			local var_276_29 = arg_273_1:FormatText(var_276_28.content)
			local var_276_30, var_276_31 = arg_273_1:GetPercentByPara(var_276_29, 1)

			if var_276_25 < arg_273_1.time_ and arg_273_1.time_ <= var_276_25 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				local var_276_32 = var_276_26 <= 0 and var_276_27 or var_276_27 * ((var_276_31 - arg_273_1.typewritterCharCountI18N) / var_276_26)

				if var_276_32 > 0 and var_276_27 < var_276_32 then
					arg_273_1.talkMaxDuration = var_276_32

					if var_276_32 + var_276_25 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_32 + var_276_25
					end
				end
			end

			local var_276_33 = 0
			local var_276_34 = math.max(var_276_33, arg_273_1.talkMaxDuration)

			if var_276_25 <= arg_273_1.time_ and arg_273_1.time_ < var_276_25 + var_276_34 then
				local var_276_35 = (arg_273_1.time_ - var_276_25) / var_276_34

				arg_273_1.fswtw_.percent = Mathf.Lerp(arg_273_1.var_.oldValueTypewriter, var_276_30, var_276_35)
				arg_273_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_273_1.fswtw_:SetDirty()
			end

			if arg_273_1.time_ >= var_276_25 + var_276_34 and arg_273_1.time_ < var_276_25 + var_276_34 + arg_276_0 then
				arg_273_1.fswtw_.percent = var_276_30

				arg_273_1.fswtw_:SetDirty()
				arg_273_1:ShowNextGo(true)

				arg_273_1.typewritterCharCountI18N = var_276_31
			end

			local var_276_36 = 0.15

			if var_276_36 < arg_273_1.time_ and arg_273_1.time_ <= var_276_36 + arg_276_0 then
				arg_273_1.fswbg_:SetActive(false)
				arg_273_1.dialog_:SetActive(false)
				SetActive(arg_273_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_273_1:ShowNextGo(false)
			end

			local var_276_37 = 0

			if var_276_37 < arg_273_1.time_ and arg_273_1.time_ <= var_276_37 + arg_276_0 then
				arg_273_1.cswbg_:SetActive(false)
			end

			if arg_273_1.frameCnt_ <= 1 then
				arg_273_1.dialog_:SetActive(false)
			end

			local var_276_38 = 1.999999999999
			local var_276_39 = 0.5

			if var_276_38 < arg_273_1.time_ and arg_273_1.time_ <= var_276_38 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				arg_273_1.dialog_:SetActive(true)

				arg_273_1.dialogCg_.alpha = 0

				local var_276_40 = LeanTween.value(arg_273_1.dialog_, 0, 1, 0.3)

				var_276_40:setOnUpdate(LuaHelper.FloatAction(function(arg_277_0)
					arg_273_1.dialogCg_.alpha = arg_277_0
				end))
				var_276_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_273_1.dialog_)
					var_276_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_273_1.duration_ = arg_273_1.duration_ + 0.3

				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_41 = arg_273_1:GetWordFromCfg(319931064)
				local var_276_42 = arg_273_1:FormatText(var_276_41.content)

				arg_273_1.text_.text = var_276_42

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_43 = 20
				local var_276_44 = utf8.len(var_276_42)
				local var_276_45 = var_276_43 <= 0 and var_276_39 or var_276_39 * (var_276_44 / var_276_43)

				if var_276_45 > 0 and var_276_39 < var_276_45 then
					arg_273_1.talkMaxDuration = var_276_45
					var_276_38 = var_276_38 + 0.3

					if var_276_45 + var_276_38 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_45 + var_276_38
					end
				end

				arg_273_1.text_.text = var_276_42
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_46 = var_276_38 + 0.3
			local var_276_47 = math.max(var_276_39, arg_273_1.talkMaxDuration)

			if var_276_46 <= arg_273_1.time_ and arg_273_1.time_ < var_276_46 + var_276_47 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_46) / var_276_47

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_46 + var_276_47 and arg_273_1.time_ < var_276_46 + var_276_47 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play319931065 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 319931065
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play319931066(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0
			local var_282_1 = 0.75

			if var_282_0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_2 = arg_279_1:GetWordFromCfg(319931065)
				local var_282_3 = arg_279_1:FormatText(var_282_2.content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 30
				local var_282_5 = utf8.len(var_282_3)
				local var_282_6 = var_282_4 <= 0 and var_282_1 or var_282_1 * (var_282_5 / var_282_4)

				if var_282_6 > 0 and var_282_1 < var_282_6 then
					arg_279_1.talkMaxDuration = var_282_6

					if var_282_6 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_6 + var_282_0
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_1, arg_279_1.talkMaxDuration)

			if var_282_0 <= arg_279_1.time_ and arg_279_1.time_ < var_282_0 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_0) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_0 + var_282_7 and arg_279_1.time_ < var_282_0 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play319931066 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 319931066
		arg_283_1.duration_ = 3.57

		local var_283_0 = {
			zh = 3.566,
			ja = 2.9
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
				arg_283_0:Play319931067(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10075ui_story"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos10075ui_story = var_286_0.localPosition
			end

			local var_286_2 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2
				local var_286_4 = Vector3.New(0, -0.715, -6.15)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10075ui_story, var_286_4, var_286_3)

				local var_286_5 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_5.x, var_286_5.y, var_286_5.z)

				local var_286_6 = var_286_0.localEulerAngles

				var_286_6.z = 0
				var_286_6.x = 0
				var_286_0.localEulerAngles = var_286_6
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(0, -0.715, -6.15)

				local var_286_7 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_7.x, var_286_7.y, var_286_7.z)

				local var_286_8 = var_286_0.localEulerAngles

				var_286_8.z = 0
				var_286_8.x = 0
				var_286_0.localEulerAngles = var_286_8
			end

			local var_286_9 = arg_283_1.actors_["10075ui_story"]
			local var_286_10 = 0

			if var_286_10 < arg_283_1.time_ and arg_283_1.time_ <= var_286_10 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect10075ui_story == nil then
				arg_283_1.var_.characterEffect10075ui_story = var_286_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_11 = 0.200000002980232

			if var_286_10 <= arg_283_1.time_ and arg_283_1.time_ < var_286_10 + var_286_11 and not isNil(var_286_9) then
				local var_286_12 = (arg_283_1.time_ - var_286_10) / var_286_11

				if arg_283_1.var_.characterEffect10075ui_story and not isNil(var_286_9) then
					arg_283_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_10 + var_286_11 and arg_283_1.time_ < var_286_10 + var_286_11 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect10075ui_story then
				arg_283_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_286_13 = 0

			if var_286_13 < arg_283_1.time_ and arg_283_1.time_ <= var_286_13 + arg_286_0 then
				arg_283_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			local var_286_14 = 0

			if var_286_14 < arg_283_1.time_ and arg_283_1.time_ <= var_286_14 + arg_286_0 then
				arg_283_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_286_15 = 0
			local var_286_16 = 0.275

			if var_286_15 < arg_283_1.time_ and arg_283_1.time_ <= var_286_15 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_17 = arg_283_1:FormatText(StoryNameCfg[692].name)

				arg_283_1.leftNameTxt_.text = var_286_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_18 = arg_283_1:GetWordFromCfg(319931066)
				local var_286_19 = arg_283_1:FormatText(var_286_18.content)

				arg_283_1.text_.text = var_286_19

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_20 = 11
				local var_286_21 = utf8.len(var_286_19)
				local var_286_22 = var_286_20 <= 0 and var_286_16 or var_286_16 * (var_286_21 / var_286_20)

				if var_286_22 > 0 and var_286_16 < var_286_22 then
					arg_283_1.talkMaxDuration = var_286_22

					if var_286_22 + var_286_15 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_22 + var_286_15
					end
				end

				arg_283_1.text_.text = var_286_19
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931066", "story_v_out_319931.awb") ~= 0 then
					local var_286_23 = manager.audio:GetVoiceLength("story_v_out_319931", "319931066", "story_v_out_319931.awb") / 1000

					if var_286_23 + var_286_15 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_23 + var_286_15
					end

					if var_286_18.prefab_name ~= "" and arg_283_1.actors_[var_286_18.prefab_name] ~= nil then
						local var_286_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_18.prefab_name].transform, "story_v_out_319931", "319931066", "story_v_out_319931.awb")

						arg_283_1:RecordAudio("319931066", var_286_24)
						arg_283_1:RecordAudio("319931066", var_286_24)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_319931", "319931066", "story_v_out_319931.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_319931", "319931066", "story_v_out_319931.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_25 = math.max(var_286_16, arg_283_1.talkMaxDuration)

			if var_286_15 <= arg_283_1.time_ and arg_283_1.time_ < var_286_15 + var_286_25 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_15) / var_286_25

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_15 + var_286_25 and arg_283_1.time_ < var_286_15 + var_286_25 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play319931067 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 319931067
		arg_287_1.duration_ = 5.6

		local var_287_0 = {
			zh = 1.999999999999,
			ja = 5.6
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
				arg_287_0:Play319931068(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10079ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos10079ui_story = var_290_0.localPosition
			end

			local var_290_2 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2
				local var_290_4 = Vector3.New(0.7, -0.95, -6.05)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10079ui_story, var_290_4, var_290_3)

				local var_290_5 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_5.x, var_290_5.y, var_290_5.z)

				local var_290_6 = var_290_0.localEulerAngles

				var_290_6.z = 0
				var_290_6.x = 0
				var_290_0.localEulerAngles = var_290_6
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_290_7 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_7.x, var_290_7.y, var_290_7.z)

				local var_290_8 = var_290_0.localEulerAngles

				var_290_8.z = 0
				var_290_8.x = 0
				var_290_0.localEulerAngles = var_290_8
			end

			local var_290_9 = arg_287_1.actors_["10079ui_story"]
			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect10079ui_story == nil then
				arg_287_1.var_.characterEffect10079ui_story = var_290_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_11 = 0.200000002980232

			if var_290_10 <= arg_287_1.time_ and arg_287_1.time_ < var_290_10 + var_290_11 and not isNil(var_290_9) then
				local var_290_12 = (arg_287_1.time_ - var_290_10) / var_290_11

				if arg_287_1.var_.characterEffect10079ui_story and not isNil(var_290_9) then
					arg_287_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_10 + var_290_11 and arg_287_1.time_ < var_290_10 + var_290_11 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect10079ui_story then
				arg_287_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_290_13 = 0

			if var_290_13 < arg_287_1.time_ and arg_287_1.time_ <= var_290_13 + arg_290_0 then
				arg_287_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_290_14 = 0

			if var_290_14 < arg_287_1.time_ and arg_287_1.time_ <= var_290_14 + arg_290_0 then
				arg_287_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_290_15 = arg_287_1.actors_["10075ui_story"].transform
			local var_290_16 = 0

			if var_290_16 < arg_287_1.time_ and arg_287_1.time_ <= var_290_16 + arg_290_0 then
				arg_287_1.var_.moveOldPos10075ui_story = var_290_15.localPosition
			end

			local var_290_17 = 0.001

			if var_290_16 <= arg_287_1.time_ and arg_287_1.time_ < var_290_16 + var_290_17 then
				local var_290_18 = (arg_287_1.time_ - var_290_16) / var_290_17
				local var_290_19 = Vector3.New(-0.7, -0.715, -6.15)

				var_290_15.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10075ui_story, var_290_19, var_290_18)

				local var_290_20 = manager.ui.mainCamera.transform.position - var_290_15.position

				var_290_15.forward = Vector3.New(var_290_20.x, var_290_20.y, var_290_20.z)

				local var_290_21 = var_290_15.localEulerAngles

				var_290_21.z = 0
				var_290_21.x = 0
				var_290_15.localEulerAngles = var_290_21
			end

			if arg_287_1.time_ >= var_290_16 + var_290_17 and arg_287_1.time_ < var_290_16 + var_290_17 + arg_290_0 then
				var_290_15.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_290_22 = manager.ui.mainCamera.transform.position - var_290_15.position

				var_290_15.forward = Vector3.New(var_290_22.x, var_290_22.y, var_290_22.z)

				local var_290_23 = var_290_15.localEulerAngles

				var_290_23.z = 0
				var_290_23.x = 0
				var_290_15.localEulerAngles = var_290_23
			end

			local var_290_24 = arg_287_1.actors_["10075ui_story"]
			local var_290_25 = 0

			if var_290_25 < arg_287_1.time_ and arg_287_1.time_ <= var_290_25 + arg_290_0 and not isNil(var_290_24) and arg_287_1.var_.characterEffect10075ui_story == nil then
				arg_287_1.var_.characterEffect10075ui_story = var_290_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_26 = 0.200000002980232

			if var_290_25 <= arg_287_1.time_ and arg_287_1.time_ < var_290_25 + var_290_26 and not isNil(var_290_24) then
				local var_290_27 = (arg_287_1.time_ - var_290_25) / var_290_26

				if arg_287_1.var_.characterEffect10075ui_story and not isNil(var_290_24) then
					local var_290_28 = Mathf.Lerp(0, 0.5, var_290_27)

					arg_287_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_287_1.var_.characterEffect10075ui_story.fillRatio = var_290_28
				end
			end

			if arg_287_1.time_ >= var_290_25 + var_290_26 and arg_287_1.time_ < var_290_25 + var_290_26 + arg_290_0 and not isNil(var_290_24) and arg_287_1.var_.characterEffect10075ui_story then
				local var_290_29 = 0.5

				arg_287_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_287_1.var_.characterEffect10075ui_story.fillRatio = var_290_29
			end

			local var_290_30 = 0
			local var_290_31 = 0.2

			if var_290_30 < arg_287_1.time_ and arg_287_1.time_ <= var_290_30 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_32 = arg_287_1:FormatText(StoryNameCfg[6].name)

				arg_287_1.leftNameTxt_.text = var_290_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_33 = arg_287_1:GetWordFromCfg(319931067)
				local var_290_34 = arg_287_1:FormatText(var_290_33.content)

				arg_287_1.text_.text = var_290_34

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_35 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931067", "story_v_out_319931.awb") ~= 0 then
					local var_290_38 = manager.audio:GetVoiceLength("story_v_out_319931", "319931067", "story_v_out_319931.awb") / 1000

					if var_290_38 + var_290_30 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_38 + var_290_30
					end

					if var_290_33.prefab_name ~= "" and arg_287_1.actors_[var_290_33.prefab_name] ~= nil then
						local var_290_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_33.prefab_name].transform, "story_v_out_319931", "319931067", "story_v_out_319931.awb")

						arg_287_1:RecordAudio("319931067", var_290_39)
						arg_287_1:RecordAudio("319931067", var_290_39)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_319931", "319931067", "story_v_out_319931.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_319931", "319931067", "story_v_out_319931.awb")
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play319931068 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 319931068
		arg_291_1.duration_ = 8.53

		local var_291_0 = {
			zh = 8,
			ja = 8.533
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
				arg_291_0:Play319931069(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["10079ui_story"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect10079ui_story == nil then
				arg_291_1.var_.characterEffect10079ui_story = var_294_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.characterEffect10079ui_story and not isNil(var_294_0) then
					local var_294_4 = Mathf.Lerp(0, 0.5, var_294_3)

					arg_291_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_291_1.var_.characterEffect10079ui_story.fillRatio = var_294_4
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect10079ui_story then
				local var_294_5 = 0.5

				arg_291_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_291_1.var_.characterEffect10079ui_story.fillRatio = var_294_5
			end

			local var_294_6 = arg_291_1.actors_["10075ui_story"]
			local var_294_7 = 0

			if var_294_7 < arg_291_1.time_ and arg_291_1.time_ <= var_294_7 + arg_294_0 and not isNil(var_294_6) and arg_291_1.var_.characterEffect10075ui_story == nil then
				arg_291_1.var_.characterEffect10075ui_story = var_294_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_8 = 0.200000002980232

			if var_294_7 <= arg_291_1.time_ and arg_291_1.time_ < var_294_7 + var_294_8 and not isNil(var_294_6) then
				local var_294_9 = (arg_291_1.time_ - var_294_7) / var_294_8

				if arg_291_1.var_.characterEffect10075ui_story and not isNil(var_294_6) then
					arg_291_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_7 + var_294_8 and arg_291_1.time_ < var_294_7 + var_294_8 + arg_294_0 and not isNil(var_294_6) and arg_291_1.var_.characterEffect10075ui_story then
				arg_291_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_294_10 = 0
			local var_294_11 = 0.8

			if var_294_10 < arg_291_1.time_ and arg_291_1.time_ <= var_294_10 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_12 = arg_291_1:FormatText(StoryNameCfg[692].name)

				arg_291_1.leftNameTxt_.text = var_294_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_13 = arg_291_1:GetWordFromCfg(319931068)
				local var_294_14 = arg_291_1:FormatText(var_294_13.content)

				arg_291_1.text_.text = var_294_14

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_15 = 32
				local var_294_16 = utf8.len(var_294_14)
				local var_294_17 = var_294_15 <= 0 and var_294_11 or var_294_11 * (var_294_16 / var_294_15)

				if var_294_17 > 0 and var_294_11 < var_294_17 then
					arg_291_1.talkMaxDuration = var_294_17

					if var_294_17 + var_294_10 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_17 + var_294_10
					end
				end

				arg_291_1.text_.text = var_294_14
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931068", "story_v_out_319931.awb") ~= 0 then
					local var_294_18 = manager.audio:GetVoiceLength("story_v_out_319931", "319931068", "story_v_out_319931.awb") / 1000

					if var_294_18 + var_294_10 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_18 + var_294_10
					end

					if var_294_13.prefab_name ~= "" and arg_291_1.actors_[var_294_13.prefab_name] ~= nil then
						local var_294_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_13.prefab_name].transform, "story_v_out_319931", "319931068", "story_v_out_319931.awb")

						arg_291_1:RecordAudio("319931068", var_294_19)
						arg_291_1:RecordAudio("319931068", var_294_19)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_319931", "319931068", "story_v_out_319931.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_319931", "319931068", "story_v_out_319931.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_20 = math.max(var_294_11, arg_291_1.talkMaxDuration)

			if var_294_10 <= arg_291_1.time_ and arg_291_1.time_ < var_294_10 + var_294_20 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_10) / var_294_20

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_10 + var_294_20 and arg_291_1.time_ < var_294_10 + var_294_20 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play319931069 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 319931069
		arg_295_1.duration_ = 9.13

		local var_295_0 = {
			zh = 7.8,
			ja = 9.133
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play319931070(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.725

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[692].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_3 = arg_295_1:GetWordFromCfg(319931069)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 29
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_1 or var_298_1 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_1 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931069", "story_v_out_319931.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_out_319931", "319931069", "story_v_out_319931.awb") / 1000

					if var_298_8 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_0
					end

					if var_298_3.prefab_name ~= "" and arg_295_1.actors_[var_298_3.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_3.prefab_name].transform, "story_v_out_319931", "319931069", "story_v_out_319931.awb")

						arg_295_1:RecordAudio("319931069", var_298_9)
						arg_295_1:RecordAudio("319931069", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_319931", "319931069", "story_v_out_319931.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_319931", "319931069", "story_v_out_319931.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_10 and arg_295_1.time_ < var_298_0 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play319931070 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 319931070
		arg_299_1.duration_ = 13.53

		local var_299_0 = {
			zh = 8.8,
			ja = 13.533
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play319931071(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = "XH0204"

			if arg_299_1.bgs_[var_302_0] == nil then
				local var_302_1 = Object.Instantiate(arg_299_1.paintGo_)

				var_302_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_302_0)
				var_302_1.name = var_302_0
				var_302_1.transform.parent = arg_299_1.stage_.transform
				var_302_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_299_1.bgs_[var_302_0] = var_302_1
			end

			local var_302_2 = 0

			if var_302_2 < arg_299_1.time_ and arg_299_1.time_ <= var_302_2 + arg_302_0 then
				local var_302_3 = manager.ui.mainCamera.transform.localPosition
				local var_302_4 = Vector3.New(0, 0, 10) + Vector3.New(var_302_3.x, var_302_3.y, 0)
				local var_302_5 = arg_299_1.bgs_.XH0204

				var_302_5.transform.localPosition = var_302_4
				var_302_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_302_6 = var_302_5:GetComponent("SpriteRenderer")

				if var_302_6 and var_302_6.sprite then
					local var_302_7 = (var_302_5.transform.localPosition - var_302_3).z
					local var_302_8 = manager.ui.mainCameraCom_
					local var_302_9 = 2 * var_302_7 * Mathf.Tan(var_302_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_302_10 = var_302_9 * var_302_8.aspect
					local var_302_11 = var_302_6.sprite.bounds.size.x
					local var_302_12 = var_302_6.sprite.bounds.size.y
					local var_302_13 = var_302_10 / var_302_11
					local var_302_14 = var_302_9 / var_302_12
					local var_302_15 = var_302_14 < var_302_13 and var_302_13 or var_302_14

					var_302_5.transform.localScale = Vector3.New(var_302_15, var_302_15, 0)
				end

				for iter_302_0, iter_302_1 in pairs(arg_299_1.bgs_) do
					if iter_302_0 ~= "XH0204" then
						iter_302_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_302_16 = 0

			if var_302_16 < arg_299_1.time_ and arg_299_1.time_ <= var_302_16 + arg_302_0 then
				arg_299_1.allBtn_.enabled = false
			end

			local var_302_17 = 0.3

			if arg_299_1.time_ >= var_302_16 + var_302_17 and arg_299_1.time_ < var_302_16 + var_302_17 + arg_302_0 then
				arg_299_1.allBtn_.enabled = true
			end

			local var_302_18 = arg_299_1.actors_["10075ui_story"].transform
			local var_302_19 = 0

			if var_302_19 < arg_299_1.time_ and arg_299_1.time_ <= var_302_19 + arg_302_0 then
				arg_299_1.var_.moveOldPos10075ui_story = var_302_18.localPosition
			end

			local var_302_20 = 0.001

			if var_302_19 <= arg_299_1.time_ and arg_299_1.time_ < var_302_19 + var_302_20 then
				local var_302_21 = (arg_299_1.time_ - var_302_19) / var_302_20
				local var_302_22 = Vector3.New(0, 100, 0)

				var_302_18.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10075ui_story, var_302_22, var_302_21)

				local var_302_23 = manager.ui.mainCamera.transform.position - var_302_18.position

				var_302_18.forward = Vector3.New(var_302_23.x, var_302_23.y, var_302_23.z)

				local var_302_24 = var_302_18.localEulerAngles

				var_302_24.z = 0
				var_302_24.x = 0
				var_302_18.localEulerAngles = var_302_24
			end

			if arg_299_1.time_ >= var_302_19 + var_302_20 and arg_299_1.time_ < var_302_19 + var_302_20 + arg_302_0 then
				var_302_18.localPosition = Vector3.New(0, 100, 0)

				local var_302_25 = manager.ui.mainCamera.transform.position - var_302_18.position

				var_302_18.forward = Vector3.New(var_302_25.x, var_302_25.y, var_302_25.z)

				local var_302_26 = var_302_18.localEulerAngles

				var_302_26.z = 0
				var_302_26.x = 0
				var_302_18.localEulerAngles = var_302_26
			end

			local var_302_27 = arg_299_1.actors_["10079ui_story"].transform
			local var_302_28 = 0

			if var_302_28 < arg_299_1.time_ and arg_299_1.time_ <= var_302_28 + arg_302_0 then
				arg_299_1.var_.moveOldPos10079ui_story = var_302_27.localPosition
			end

			local var_302_29 = 0.001

			if var_302_28 <= arg_299_1.time_ and arg_299_1.time_ < var_302_28 + var_302_29 then
				local var_302_30 = (arg_299_1.time_ - var_302_28) / var_302_29
				local var_302_31 = Vector3.New(0, 100, 0)

				var_302_27.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10079ui_story, var_302_31, var_302_30)

				local var_302_32 = manager.ui.mainCamera.transform.position - var_302_27.position

				var_302_27.forward = Vector3.New(var_302_32.x, var_302_32.y, var_302_32.z)

				local var_302_33 = var_302_27.localEulerAngles

				var_302_33.z = 0
				var_302_33.x = 0
				var_302_27.localEulerAngles = var_302_33
			end

			if arg_299_1.time_ >= var_302_28 + var_302_29 and arg_299_1.time_ < var_302_28 + var_302_29 + arg_302_0 then
				var_302_27.localPosition = Vector3.New(0, 100, 0)

				local var_302_34 = manager.ui.mainCamera.transform.position - var_302_27.position

				var_302_27.forward = Vector3.New(var_302_34.x, var_302_34.y, var_302_34.z)

				local var_302_35 = var_302_27.localEulerAngles

				var_302_35.z = 0
				var_302_35.x = 0
				var_302_27.localEulerAngles = var_302_35
			end

			local var_302_36 = manager.ui.mainCamera.transform
			local var_302_37 = 0

			if var_302_37 < arg_299_1.time_ and arg_299_1.time_ <= var_302_37 + arg_302_0 then
				local var_302_38 = arg_299_1.var_.effecthuiyisi1
				local var_302_39
				local var_302_40 = var_302_36

				if not var_302_38 then
					var_302_38 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_302_40)
					var_302_38.name = "huiyisi1"
					arg_299_1.var_.effecthuiyisi1 = var_302_38
				else
					var_302_38.transform:SetParent(var_302_40)
				end

				var_302_38.transform.localPosition = Vector3.New(0, 0, 0)
				var_302_38.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_302_41 = manager.ui.mainCamera.transform
			local var_302_42 = 2

			if var_302_42 < arg_299_1.time_ and arg_299_1.time_ <= var_302_42 + arg_302_0 then
				local var_302_43 = arg_299_1.var_.effecthuiyisi1

				if var_302_43 then
					Object.Destroy(var_302_43)

					arg_299_1.var_.effecthuiyisi1 = nil
				end
			end

			local var_302_44 = 0

			arg_299_1.isInRecall_ = false

			if var_302_44 < arg_299_1.time_ and arg_299_1.time_ <= var_302_44 + arg_302_0 then
				arg_299_1.screenFilterGo_:SetActive(true)

				arg_299_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_302_2, iter_302_3 in pairs(arg_299_1.actors_) do
					local var_302_45 = iter_302_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_302_4, iter_302_5 in ipairs(var_302_45) do
						if iter_302_5.color.r > 0.51 then
							iter_302_5.color = Color.New(1, 1, 1)
						else
							iter_302_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_302_46 = 0.0166666666666667

			if var_302_44 <= arg_299_1.time_ and arg_299_1.time_ < var_302_44 + var_302_46 then
				local var_302_47 = (arg_299_1.time_ - var_302_44) / var_302_46

				arg_299_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_302_47)
			end

			if arg_299_1.time_ >= var_302_44 + var_302_46 and arg_299_1.time_ < var_302_44 + var_302_46 + arg_302_0 then
				arg_299_1.screenFilterEffect_.weight = 1
			end

			local var_302_48 = 0
			local var_302_49 = 0.65

			if var_302_48 < arg_299_1.time_ and arg_299_1.time_ <= var_302_48 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0

				arg_299_1.dialog_:SetActive(true)

				arg_299_1.dialogCg_.alpha = 0

				local var_302_50 = LeanTween.value(arg_299_1.dialog_, 0, 1, 0.3)

				var_302_50:setOnUpdate(LuaHelper.FloatAction(function(arg_303_0)
					arg_299_1.dialogCg_.alpha = arg_303_0
				end))
				var_302_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_299_1.dialog_)
					var_302_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_299_1.duration_ = arg_299_1.duration_ + 0.3

				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_51 = arg_299_1:FormatText(StoryNameCfg[692].name)

				arg_299_1.leftNameTxt_.text = var_302_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_52 = arg_299_1:GetWordFromCfg(319931070)
				local var_302_53 = arg_299_1:FormatText(var_302_52.content)

				arg_299_1.text_.text = var_302_53

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_54 = 26
				local var_302_55 = utf8.len(var_302_53)
				local var_302_56 = var_302_54 <= 0 and var_302_49 or var_302_49 * (var_302_55 / var_302_54)

				if var_302_56 > 0 and var_302_49 < var_302_56 then
					arg_299_1.talkMaxDuration = var_302_56
					var_302_48 = var_302_48 + 0.3

					if var_302_56 + var_302_48 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_56 + var_302_48
					end
				end

				arg_299_1.text_.text = var_302_53
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931070", "story_v_out_319931.awb") ~= 0 then
					local var_302_57 = manager.audio:GetVoiceLength("story_v_out_319931", "319931070", "story_v_out_319931.awb") / 1000

					if var_302_57 + var_302_48 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_57 + var_302_48
					end

					if var_302_52.prefab_name ~= "" and arg_299_1.actors_[var_302_52.prefab_name] ~= nil then
						local var_302_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_52.prefab_name].transform, "story_v_out_319931", "319931070", "story_v_out_319931.awb")

						arg_299_1:RecordAudio("319931070", var_302_58)
						arg_299_1:RecordAudio("319931070", var_302_58)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_319931", "319931070", "story_v_out_319931.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_319931", "319931070", "story_v_out_319931.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_59 = var_302_48 + 0.3
			local var_302_60 = math.max(var_302_49, arg_299_1.talkMaxDuration)

			if var_302_59 <= arg_299_1.time_ and arg_299_1.time_ < var_302_59 + var_302_60 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_59) / var_302_60

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_59 + var_302_60 and arg_299_1.time_ < var_302_59 + var_302_60 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play319931071 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 319931071
		arg_305_1.duration_ = 9.7

		local var_305_0 = {
			zh = 6.833,
			ja = 9.7
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play319931072(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = "XH0506"

			if arg_305_1.bgs_[var_308_0] == nil then
				local var_308_1 = Object.Instantiate(arg_305_1.paintGo_)

				var_308_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_308_0)
				var_308_1.name = var_308_0
				var_308_1.transform.parent = arg_305_1.stage_.transform
				var_308_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_305_1.bgs_[var_308_0] = var_308_1
			end

			local var_308_2 = 0

			if var_308_2 < arg_305_1.time_ and arg_305_1.time_ <= var_308_2 + arg_308_0 then
				local var_308_3 = manager.ui.mainCamera.transform.localPosition
				local var_308_4 = Vector3.New(0, 0, 10) + Vector3.New(var_308_3.x, var_308_3.y, 0)
				local var_308_5 = arg_305_1.bgs_.XH0506

				var_308_5.transform.localPosition = var_308_4
				var_308_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_308_6 = var_308_5:GetComponent("SpriteRenderer")

				if var_308_6 and var_308_6.sprite then
					local var_308_7 = (var_308_5.transform.localPosition - var_308_3).z
					local var_308_8 = manager.ui.mainCameraCom_
					local var_308_9 = 2 * var_308_7 * Mathf.Tan(var_308_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_308_10 = var_308_9 * var_308_8.aspect
					local var_308_11 = var_308_6.sprite.bounds.size.x
					local var_308_12 = var_308_6.sprite.bounds.size.y
					local var_308_13 = var_308_10 / var_308_11
					local var_308_14 = var_308_9 / var_308_12
					local var_308_15 = var_308_14 < var_308_13 and var_308_13 or var_308_14

					var_308_5.transform.localScale = Vector3.New(var_308_15, var_308_15, 0)
				end

				for iter_308_0, iter_308_1 in pairs(arg_305_1.bgs_) do
					if iter_308_0 ~= "XH0506" then
						iter_308_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_308_16 = manager.ui.mainCamera.transform
			local var_308_17 = 0

			if var_308_17 < arg_305_1.time_ and arg_305_1.time_ <= var_308_17 + arg_308_0 then
				local var_308_18 = arg_305_1.var_.effecthuiyisi1
				local var_308_19
				local var_308_20 = var_308_16

				if not var_308_18 then
					var_308_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_308_20)
					var_308_18.name = "huiyisi1"
					arg_305_1.var_.effecthuiyisi1 = var_308_18
				else
					var_308_18.transform:SetParent(var_308_20)
				end

				var_308_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_308_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_308_21 = manager.ui.mainCamera.transform
			local var_308_22 = 2

			if var_308_22 < arg_305_1.time_ and arg_305_1.time_ <= var_308_22 + arg_308_0 then
				local var_308_23 = arg_305_1.var_.effecthuiyisi1

				if var_308_23 then
					Object.Destroy(var_308_23)

					arg_305_1.var_.effecthuiyisi1 = nil
				end
			end

			local var_308_24 = 0
			local var_308_25 = 0.6

			if var_308_24 < arg_305_1.time_ and arg_305_1.time_ <= var_308_24 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0

				arg_305_1.dialog_:SetActive(true)

				arg_305_1.dialogCg_.alpha = 0

				local var_308_26 = LeanTween.value(arg_305_1.dialog_, 0, 1, 0.3)

				var_308_26:setOnUpdate(LuaHelper.FloatAction(function(arg_309_0)
					arg_305_1.dialogCg_.alpha = arg_309_0
				end))
				var_308_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_305_1.dialog_)
					var_308_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_305_1.duration_ = arg_305_1.duration_ + 0.3

				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_27 = arg_305_1:FormatText(StoryNameCfg[692].name)

				arg_305_1.leftNameTxt_.text = var_308_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_28 = arg_305_1:GetWordFromCfg(319931071)
				local var_308_29 = arg_305_1:FormatText(var_308_28.content)

				arg_305_1.text_.text = var_308_29

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_30 = 24
				local var_308_31 = utf8.len(var_308_29)
				local var_308_32 = var_308_30 <= 0 and var_308_25 or var_308_25 * (var_308_31 / var_308_30)

				if var_308_32 > 0 and var_308_25 < var_308_32 then
					arg_305_1.talkMaxDuration = var_308_32
					var_308_24 = var_308_24 + 0.3

					if var_308_32 + var_308_24 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_32 + var_308_24
					end
				end

				arg_305_1.text_.text = var_308_29
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931071", "story_v_out_319931.awb") ~= 0 then
					local var_308_33 = manager.audio:GetVoiceLength("story_v_out_319931", "319931071", "story_v_out_319931.awb") / 1000

					if var_308_33 + var_308_24 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_33 + var_308_24
					end

					if var_308_28.prefab_name ~= "" and arg_305_1.actors_[var_308_28.prefab_name] ~= nil then
						local var_308_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_28.prefab_name].transform, "story_v_out_319931", "319931071", "story_v_out_319931.awb")

						arg_305_1:RecordAudio("319931071", var_308_34)
						arg_305_1:RecordAudio("319931071", var_308_34)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_319931", "319931071", "story_v_out_319931.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_319931", "319931071", "story_v_out_319931.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_35 = var_308_24 + 0.3
			local var_308_36 = math.max(var_308_25, arg_305_1.talkMaxDuration)

			if var_308_35 <= arg_305_1.time_ and arg_305_1.time_ < var_308_35 + var_308_36 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_35) / var_308_36

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_35 + var_308_36 and arg_305_1.time_ < var_308_35 + var_308_36 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play319931072 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 319931072
		arg_311_1.duration_ = 5.3

		local var_311_0 = {
			zh = 3.5,
			ja = 5.3
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play319931073(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = "ML0101"

			if arg_311_1.bgs_[var_314_0] == nil then
				local var_314_1 = Object.Instantiate(arg_311_1.paintGo_)

				var_314_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_314_0)
				var_314_1.name = var_314_0
				var_314_1.transform.parent = arg_311_1.stage_.transform
				var_314_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_311_1.bgs_[var_314_0] = var_314_1
			end

			local var_314_2 = 1

			if var_314_2 < arg_311_1.time_ and arg_311_1.time_ <= var_314_2 + arg_314_0 then
				local var_314_3 = manager.ui.mainCamera.transform.localPosition
				local var_314_4 = Vector3.New(0, 0, 10) + Vector3.New(var_314_3.x, var_314_3.y, 0)
				local var_314_5 = arg_311_1.bgs_.ML0101

				var_314_5.transform.localPosition = var_314_4
				var_314_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_314_6 = var_314_5:GetComponent("SpriteRenderer")

				if var_314_6 and var_314_6.sprite then
					local var_314_7 = (var_314_5.transform.localPosition - var_314_3).z
					local var_314_8 = manager.ui.mainCameraCom_
					local var_314_9 = 2 * var_314_7 * Mathf.Tan(var_314_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_314_10 = var_314_9 * var_314_8.aspect
					local var_314_11 = var_314_6.sprite.bounds.size.x
					local var_314_12 = var_314_6.sprite.bounds.size.y
					local var_314_13 = var_314_10 / var_314_11
					local var_314_14 = var_314_9 / var_314_12
					local var_314_15 = var_314_14 < var_314_13 and var_314_13 or var_314_14

					var_314_5.transform.localScale = Vector3.New(var_314_15, var_314_15, 0)
				end

				for iter_314_0, iter_314_1 in pairs(arg_311_1.bgs_) do
					if iter_314_0 ~= "ML0101" then
						iter_314_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_314_16 = 1.999999999999

			if var_314_16 < arg_311_1.time_ and arg_311_1.time_ <= var_314_16 + arg_314_0 then
				arg_311_1.allBtn_.enabled = false
			end

			local var_314_17 = 0.3

			if arg_311_1.time_ >= var_314_16 + var_314_17 and arg_311_1.time_ < var_314_16 + var_314_17 + arg_314_0 then
				arg_311_1.allBtn_.enabled = true
			end

			local var_314_18 = 0

			if var_314_18 < arg_311_1.time_ and arg_311_1.time_ <= var_314_18 + arg_314_0 then
				arg_311_1.mask_.enabled = true
				arg_311_1.mask_.raycastTarget = true

				arg_311_1:SetGaussion(false)
			end

			local var_314_19 = 1

			if var_314_18 <= arg_311_1.time_ and arg_311_1.time_ < var_314_18 + var_314_19 then
				local var_314_20 = (arg_311_1.time_ - var_314_18) / var_314_19
				local var_314_21 = Color.New(0, 0, 0)

				var_314_21.a = Mathf.Lerp(0, 1, var_314_20)
				arg_311_1.mask_.color = var_314_21
			end

			if arg_311_1.time_ >= var_314_18 + var_314_19 and arg_311_1.time_ < var_314_18 + var_314_19 + arg_314_0 then
				local var_314_22 = Color.New(0, 0, 0)

				var_314_22.a = 1
				arg_311_1.mask_.color = var_314_22
			end

			local var_314_23 = 1

			if var_314_23 < arg_311_1.time_ and arg_311_1.time_ <= var_314_23 + arg_314_0 then
				arg_311_1.mask_.enabled = true
				arg_311_1.mask_.raycastTarget = true

				arg_311_1:SetGaussion(false)
			end

			local var_314_24 = 1

			if var_314_23 <= arg_311_1.time_ and arg_311_1.time_ < var_314_23 + var_314_24 then
				local var_314_25 = (arg_311_1.time_ - var_314_23) / var_314_24
				local var_314_26 = Color.New(0, 0, 0)

				var_314_26.a = Mathf.Lerp(1, 0, var_314_25)
				arg_311_1.mask_.color = var_314_26
			end

			if arg_311_1.time_ >= var_314_23 + var_314_24 and arg_311_1.time_ < var_314_23 + var_314_24 + arg_314_0 then
				local var_314_27 = Color.New(0, 0, 0)
				local var_314_28 = 0

				arg_311_1.mask_.enabled = false
				var_314_27.a = var_314_28
				arg_311_1.mask_.color = var_314_27
			end

			if arg_311_1.frameCnt_ <= 1 then
				arg_311_1.dialog_:SetActive(false)
			end

			local var_314_29 = 2
			local var_314_30 = 0.125

			if var_314_29 < arg_311_1.time_ and arg_311_1.time_ <= var_314_29 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0

				arg_311_1.dialog_:SetActive(true)

				arg_311_1.dialogCg_.alpha = 0

				local var_314_31 = LeanTween.value(arg_311_1.dialog_, 0, 1, 0.3)

				var_314_31:setOnUpdate(LuaHelper.FloatAction(function(arg_315_0)
					arg_311_1.dialogCg_.alpha = arg_315_0
				end))
				var_314_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_311_1.dialog_)
					var_314_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_311_1.duration_ = arg_311_1.duration_ + 0.3

				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_32 = arg_311_1:FormatText(StoryNameCfg[692].name)

				arg_311_1.leftNameTxt_.text = var_314_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_33 = arg_311_1:GetWordFromCfg(319931072)
				local var_314_34 = arg_311_1:FormatText(var_314_33.content)

				arg_311_1.text_.text = var_314_34

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_35 = 5
				local var_314_36 = utf8.len(var_314_34)
				local var_314_37 = var_314_35 <= 0 and var_314_30 or var_314_30 * (var_314_36 / var_314_35)

				if var_314_37 > 0 and var_314_30 < var_314_37 then
					arg_311_1.talkMaxDuration = var_314_37
					var_314_29 = var_314_29 + 0.3

					if var_314_37 + var_314_29 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_37 + var_314_29
					end
				end

				arg_311_1.text_.text = var_314_34
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931072", "story_v_out_319931.awb") ~= 0 then
					local var_314_38 = manager.audio:GetVoiceLength("story_v_out_319931", "319931072", "story_v_out_319931.awb") / 1000

					if var_314_38 + var_314_29 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_38 + var_314_29
					end

					if var_314_33.prefab_name ~= "" and arg_311_1.actors_[var_314_33.prefab_name] ~= nil then
						local var_314_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_33.prefab_name].transform, "story_v_out_319931", "319931072", "story_v_out_319931.awb")

						arg_311_1:RecordAudio("319931072", var_314_39)
						arg_311_1:RecordAudio("319931072", var_314_39)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_319931", "319931072", "story_v_out_319931.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_319931", "319931072", "story_v_out_319931.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_40 = var_314_29 + 0.3
			local var_314_41 = math.max(var_314_30, arg_311_1.talkMaxDuration)

			if var_314_40 <= arg_311_1.time_ and arg_311_1.time_ < var_314_40 + var_314_41 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_40) / var_314_41

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_40 + var_314_41 and arg_311_1.time_ < var_314_40 + var_314_41 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play319931073 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 319931073
		arg_317_1.duration_ = 4.63

		local var_317_0 = {
			zh = 4.133333333332,
			ja = 4.633
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play319931074(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = "I10f"

			if arg_317_1.bgs_[var_320_0] == nil then
				local var_320_1 = Object.Instantiate(arg_317_1.paintGo_)

				var_320_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_320_0)
				var_320_1.name = var_320_0
				var_320_1.transform.parent = arg_317_1.stage_.transform
				var_320_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_317_1.bgs_[var_320_0] = var_320_1
			end

			local var_320_2 = 1

			if var_320_2 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 then
				local var_320_3 = manager.ui.mainCamera.transform.localPosition
				local var_320_4 = Vector3.New(0, 0, 10) + Vector3.New(var_320_3.x, var_320_3.y, 0)
				local var_320_5 = arg_317_1.bgs_.I10f

				var_320_5.transform.localPosition = var_320_4
				var_320_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_320_6 = var_320_5:GetComponent("SpriteRenderer")

				if var_320_6 and var_320_6.sprite then
					local var_320_7 = (var_320_5.transform.localPosition - var_320_3).z
					local var_320_8 = manager.ui.mainCameraCom_
					local var_320_9 = 2 * var_320_7 * Mathf.Tan(var_320_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_320_10 = var_320_9 * var_320_8.aspect
					local var_320_11 = var_320_6.sprite.bounds.size.x
					local var_320_12 = var_320_6.sprite.bounds.size.y
					local var_320_13 = var_320_10 / var_320_11
					local var_320_14 = var_320_9 / var_320_12
					local var_320_15 = var_320_14 < var_320_13 and var_320_13 or var_320_14

					var_320_5.transform.localScale = Vector3.New(var_320_15, var_320_15, 0)
				end

				for iter_320_0, iter_320_1 in pairs(arg_317_1.bgs_) do
					if iter_320_0 ~= "I10f" then
						iter_320_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_320_16 = 1.96599999815226

			if var_320_16 < arg_317_1.time_ and arg_317_1.time_ <= var_320_16 + arg_320_0 then
				arg_317_1.allBtn_.enabled = false
			end

			local var_320_17 = 0.3

			if arg_317_1.time_ >= var_320_16 + var_320_17 and arg_317_1.time_ < var_320_16 + var_320_17 + arg_320_0 then
				arg_317_1.allBtn_.enabled = true
			end

			local var_320_18 = arg_317_1.actors_["10079ui_story"].transform
			local var_320_19 = 1.96599999815226

			if var_320_19 < arg_317_1.time_ and arg_317_1.time_ <= var_320_19 + arg_320_0 then
				arg_317_1.var_.moveOldPos10079ui_story = var_320_18.localPosition
			end

			local var_320_20 = 0.001

			if var_320_19 <= arg_317_1.time_ and arg_317_1.time_ < var_320_19 + var_320_20 then
				local var_320_21 = (arg_317_1.time_ - var_320_19) / var_320_20
				local var_320_22 = Vector3.New(0, -0.95, -6.05)

				var_320_18.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10079ui_story, var_320_22, var_320_21)

				local var_320_23 = manager.ui.mainCamera.transform.position - var_320_18.position

				var_320_18.forward = Vector3.New(var_320_23.x, var_320_23.y, var_320_23.z)

				local var_320_24 = var_320_18.localEulerAngles

				var_320_24.z = 0
				var_320_24.x = 0
				var_320_18.localEulerAngles = var_320_24
			end

			if arg_317_1.time_ >= var_320_19 + var_320_20 and arg_317_1.time_ < var_320_19 + var_320_20 + arg_320_0 then
				var_320_18.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_320_25 = manager.ui.mainCamera.transform.position - var_320_18.position

				var_320_18.forward = Vector3.New(var_320_25.x, var_320_25.y, var_320_25.z)

				local var_320_26 = var_320_18.localEulerAngles

				var_320_26.z = 0
				var_320_26.x = 0
				var_320_18.localEulerAngles = var_320_26
			end

			local var_320_27 = arg_317_1.actors_["10079ui_story"]
			local var_320_28 = 1.96599999815226

			if var_320_28 < arg_317_1.time_ and arg_317_1.time_ <= var_320_28 + arg_320_0 and not isNil(var_320_27) and arg_317_1.var_.characterEffect10079ui_story == nil then
				arg_317_1.var_.characterEffect10079ui_story = var_320_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_29 = 0.034000001847744

			if var_320_28 <= arg_317_1.time_ and arg_317_1.time_ < var_320_28 + var_320_29 and not isNil(var_320_27) then
				local var_320_30 = (arg_317_1.time_ - var_320_28) / var_320_29

				if arg_317_1.var_.characterEffect10079ui_story and not isNil(var_320_27) then
					arg_317_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_28 + var_320_29 and arg_317_1.time_ < var_320_28 + var_320_29 + arg_320_0 and not isNil(var_320_27) and arg_317_1.var_.characterEffect10079ui_story then
				arg_317_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_320_31 = 1.96599999815226

			if var_320_31 < arg_317_1.time_ and arg_317_1.time_ <= var_320_31 + arg_320_0 then
				arg_317_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_320_32 = 1.96599999815226

			if var_320_32 < arg_317_1.time_ and arg_317_1.time_ <= var_320_32 + arg_320_0 then
				arg_317_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_320_33 = 0

			if var_320_33 < arg_317_1.time_ and arg_317_1.time_ <= var_320_33 + arg_320_0 then
				arg_317_1.mask_.enabled = true
				arg_317_1.mask_.raycastTarget = true

				arg_317_1:SetGaussion(false)
			end

			local var_320_34 = 1

			if var_320_33 <= arg_317_1.time_ and arg_317_1.time_ < var_320_33 + var_320_34 then
				local var_320_35 = (arg_317_1.time_ - var_320_33) / var_320_34
				local var_320_36 = Color.New(0, 0, 0)

				var_320_36.a = Mathf.Lerp(0, 1, var_320_35)
				arg_317_1.mask_.color = var_320_36
			end

			if arg_317_1.time_ >= var_320_33 + var_320_34 and arg_317_1.time_ < var_320_33 + var_320_34 + arg_320_0 then
				local var_320_37 = Color.New(0, 0, 0)

				var_320_37.a = 1
				arg_317_1.mask_.color = var_320_37
			end

			local var_320_38 = 1

			if var_320_38 < arg_317_1.time_ and arg_317_1.time_ <= var_320_38 + arg_320_0 then
				arg_317_1.mask_.enabled = true
				arg_317_1.mask_.raycastTarget = true

				arg_317_1:SetGaussion(false)
			end

			local var_320_39 = 1

			if var_320_38 <= arg_317_1.time_ and arg_317_1.time_ < var_320_38 + var_320_39 then
				local var_320_40 = (arg_317_1.time_ - var_320_38) / var_320_39
				local var_320_41 = Color.New(0, 0, 0)

				var_320_41.a = Mathf.Lerp(1, 0, var_320_40)
				arg_317_1.mask_.color = var_320_41
			end

			if arg_317_1.time_ >= var_320_38 + var_320_39 and arg_317_1.time_ < var_320_38 + var_320_39 + arg_320_0 then
				local var_320_42 = Color.New(0, 0, 0)
				local var_320_43 = 0

				arg_317_1.mask_.enabled = false
				var_320_42.a = var_320_43
				arg_317_1.mask_.color = var_320_42
			end

			if arg_317_1.frameCnt_ <= 1 then
				arg_317_1.dialog_:SetActive(false)
			end

			local var_320_44 = 2
			local var_320_45 = 0.15

			if var_320_44 < arg_317_1.time_ and arg_317_1.time_ <= var_320_44 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0

				arg_317_1.dialog_:SetActive(true)

				arg_317_1.dialogCg_.alpha = 0

				local var_320_46 = LeanTween.value(arg_317_1.dialog_, 0, 1, 0.3)

				var_320_46:setOnUpdate(LuaHelper.FloatAction(function(arg_321_0)
					arg_317_1.dialogCg_.alpha = arg_321_0
				end))
				var_320_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_317_1.dialog_)
					var_320_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_317_1.duration_ = arg_317_1.duration_ + 0.3

				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_47 = arg_317_1:FormatText(StoryNameCfg[6].name)

				arg_317_1.leftNameTxt_.text = var_320_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_48 = arg_317_1:GetWordFromCfg(319931073)
				local var_320_49 = arg_317_1:FormatText(var_320_48.content)

				arg_317_1.text_.text = var_320_49

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_50 = 6
				local var_320_51 = utf8.len(var_320_49)
				local var_320_52 = var_320_50 <= 0 and var_320_45 or var_320_45 * (var_320_51 / var_320_50)

				if var_320_52 > 0 and var_320_45 < var_320_52 then
					arg_317_1.talkMaxDuration = var_320_52
					var_320_44 = var_320_44 + 0.3

					if var_320_52 + var_320_44 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_52 + var_320_44
					end
				end

				arg_317_1.text_.text = var_320_49
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931073", "story_v_out_319931.awb") ~= 0 then
					local var_320_53 = manager.audio:GetVoiceLength("story_v_out_319931", "319931073", "story_v_out_319931.awb") / 1000

					if var_320_53 + var_320_44 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_53 + var_320_44
					end

					if var_320_48.prefab_name ~= "" and arg_317_1.actors_[var_320_48.prefab_name] ~= nil then
						local var_320_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_48.prefab_name].transform, "story_v_out_319931", "319931073", "story_v_out_319931.awb")

						arg_317_1:RecordAudio("319931073", var_320_54)
						arg_317_1:RecordAudio("319931073", var_320_54)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_319931", "319931073", "story_v_out_319931.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_319931", "319931073", "story_v_out_319931.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_55 = var_320_44 + 0.3
			local var_320_56 = math.max(var_320_45, arg_317_1.talkMaxDuration)

			if var_320_55 <= arg_317_1.time_ and arg_317_1.time_ < var_320_55 + var_320_56 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_55) / var_320_56

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_55 + var_320_56 and arg_317_1.time_ < var_320_55 + var_320_56 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play319931074 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 319931074
		arg_323_1.duration_ = 6.07

		local var_323_0 = {
			zh = 5.333,
			ja = 6.066
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
				arg_323_0:Play319931075(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0

			if var_326_0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_0 + arg_326_0 then
				local var_326_1 = manager.ui.mainCamera.transform.localPosition
				local var_326_2 = Vector3.New(0, 0, 10) + Vector3.New(var_326_1.x, var_326_1.y, 0)
				local var_326_3 = arg_323_1.bgs_.D999

				var_326_3.transform.localPosition = var_326_2
				var_326_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_326_4 = var_326_3:GetComponent("SpriteRenderer")

				if var_326_4 and var_326_4.sprite then
					local var_326_5 = (var_326_3.transform.localPosition - var_326_1).z
					local var_326_6 = manager.ui.mainCameraCom_
					local var_326_7 = 2 * var_326_5 * Mathf.Tan(var_326_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_326_8 = var_326_7 * var_326_6.aspect
					local var_326_9 = var_326_4.sprite.bounds.size.x
					local var_326_10 = var_326_4.sprite.bounds.size.y
					local var_326_11 = var_326_8 / var_326_9
					local var_326_12 = var_326_7 / var_326_10
					local var_326_13 = var_326_12 < var_326_11 and var_326_11 or var_326_12

					var_326_3.transform.localScale = Vector3.New(var_326_13, var_326_13, 0)
				end

				for iter_326_0, iter_326_1 in pairs(arg_323_1.bgs_) do
					if iter_326_0 ~= "D999" then
						iter_326_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_326_14 = 0

			if var_326_14 < arg_323_1.time_ and arg_323_1.time_ <= var_326_14 + arg_326_0 then
				arg_323_1.allBtn_.enabled = false
			end

			local var_326_15 = 0.3

			if arg_323_1.time_ >= var_326_14 + var_326_15 and arg_323_1.time_ < var_326_14 + var_326_15 + arg_326_0 then
				arg_323_1.allBtn_.enabled = true
			end

			local var_326_16 = 0

			if var_326_16 < arg_323_1.time_ and arg_323_1.time_ <= var_326_16 + arg_326_0 then
				arg_323_1.mask_.enabled = true
				arg_323_1.mask_.raycastTarget = true

				arg_323_1:SetGaussion(false)
			end

			local var_326_17 = 2

			if var_326_16 <= arg_323_1.time_ and arg_323_1.time_ < var_326_16 + var_326_17 then
				local var_326_18 = (arg_323_1.time_ - var_326_16) / var_326_17
				local var_326_19 = Color.New(1, 1, 1)

				var_326_19.a = Mathf.Lerp(1, 0, var_326_18)
				arg_323_1.mask_.color = var_326_19
			end

			if arg_323_1.time_ >= var_326_16 + var_326_17 and arg_323_1.time_ < var_326_16 + var_326_17 + arg_326_0 then
				local var_326_20 = Color.New(1, 1, 1)
				local var_326_21 = 0

				arg_323_1.mask_.enabled = false
				var_326_20.a = var_326_21
				arg_323_1.mask_.color = var_326_20
			end

			local var_326_22 = arg_323_1.actors_["10079ui_story"]
			local var_326_23 = 0

			if var_326_23 < arg_323_1.time_ and arg_323_1.time_ <= var_326_23 + arg_326_0 and not isNil(var_326_22) and arg_323_1.var_.characterEffect10079ui_story == nil then
				arg_323_1.var_.characterEffect10079ui_story = var_326_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_24 = 0.200000002980232

			if var_326_23 <= arg_323_1.time_ and arg_323_1.time_ < var_326_23 + var_326_24 and not isNil(var_326_22) then
				local var_326_25 = (arg_323_1.time_ - var_326_23) / var_326_24

				if arg_323_1.var_.characterEffect10079ui_story and not isNil(var_326_22) then
					local var_326_26 = Mathf.Lerp(0, 0.5, var_326_25)

					arg_323_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_323_1.var_.characterEffect10079ui_story.fillRatio = var_326_26
				end
			end

			if arg_323_1.time_ >= var_326_23 + var_326_24 and arg_323_1.time_ < var_326_23 + var_326_24 + arg_326_0 and not isNil(var_326_22) and arg_323_1.var_.characterEffect10079ui_story then
				local var_326_27 = 0.5

				arg_323_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_323_1.var_.characterEffect10079ui_story.fillRatio = var_326_27
			end

			local var_326_28 = arg_323_1.actors_["10079ui_story"].transform
			local var_326_29 = 0

			if var_326_29 < arg_323_1.time_ and arg_323_1.time_ <= var_326_29 + arg_326_0 then
				arg_323_1.var_.moveOldPos10079ui_story = var_326_28.localPosition
			end

			local var_326_30 = 0.001

			if var_326_29 <= arg_323_1.time_ and arg_323_1.time_ < var_326_29 + var_326_30 then
				local var_326_31 = (arg_323_1.time_ - var_326_29) / var_326_30
				local var_326_32 = Vector3.New(0, 100, 0)

				var_326_28.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10079ui_story, var_326_32, var_326_31)

				local var_326_33 = manager.ui.mainCamera.transform.position - var_326_28.position

				var_326_28.forward = Vector3.New(var_326_33.x, var_326_33.y, var_326_33.z)

				local var_326_34 = var_326_28.localEulerAngles

				var_326_34.z = 0
				var_326_34.x = 0
				var_326_28.localEulerAngles = var_326_34
			end

			if arg_323_1.time_ >= var_326_29 + var_326_30 and arg_323_1.time_ < var_326_29 + var_326_30 + arg_326_0 then
				var_326_28.localPosition = Vector3.New(0, 100, 0)

				local var_326_35 = manager.ui.mainCamera.transform.position - var_326_28.position

				var_326_28.forward = Vector3.New(var_326_35.x, var_326_35.y, var_326_35.z)

				local var_326_36 = var_326_28.localEulerAngles

				var_326_36.z = 0
				var_326_36.x = 0
				var_326_28.localEulerAngles = var_326_36
			end

			local var_326_37 = 0

			arg_323_1.isInRecall_ = false

			if var_326_37 < arg_323_1.time_ and arg_323_1.time_ <= var_326_37 + arg_326_0 then
				arg_323_1.screenFilterGo_:SetActive(false)

				for iter_326_2, iter_326_3 in pairs(arg_323_1.actors_) do
					local var_326_38 = iter_326_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_326_4, iter_326_5 in ipairs(var_326_38) do
						if iter_326_5.color.r > 0.51 then
							iter_326_5.color = Color.New(1, 1, 1)
						else
							iter_326_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_326_39 = 0.0333333333333333

			if var_326_37 <= arg_323_1.time_ and arg_323_1.time_ < var_326_37 + var_326_39 then
				local var_326_40 = (arg_323_1.time_ - var_326_37) / var_326_39

				arg_323_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_326_40)
			end

			if arg_323_1.time_ >= var_326_37 + var_326_39 and arg_323_1.time_ < var_326_37 + var_326_39 + arg_326_0 then
				arg_323_1.screenFilterEffect_.weight = 0
			end

			if arg_323_1.frameCnt_ <= 1 then
				arg_323_1.dialog_:SetActive(false)
			end

			local var_326_41 = 2
			local var_326_42 = 0.35

			if var_326_41 < arg_323_1.time_ and arg_323_1.time_ <= var_326_41 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0

				arg_323_1.dialog_:SetActive(true)

				arg_323_1.dialogCg_.alpha = 0

				local var_326_43 = LeanTween.value(arg_323_1.dialog_, 0, 1, 0.3)

				var_326_43:setOnUpdate(LuaHelper.FloatAction(function(arg_327_0)
					arg_323_1.dialogCg_.alpha = arg_327_0
				end))
				var_326_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_323_1.dialog_)
					var_326_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_323_1.duration_ = arg_323_1.duration_ + 0.3

				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_44 = arg_323_1:GetWordFromCfg(319931074)
				local var_326_45 = arg_323_1:FormatText(var_326_44.content)

				arg_323_1.text_.text = var_326_45

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_46 = 14
				local var_326_47 = utf8.len(var_326_45)
				local var_326_48 = var_326_46 <= 0 and var_326_42 or var_326_42 * (var_326_47 / var_326_46)

				if var_326_48 > 0 and var_326_42 < var_326_48 then
					arg_323_1.talkMaxDuration = var_326_48
					var_326_41 = var_326_41 + 0.3

					if var_326_48 + var_326_41 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_48 + var_326_41
					end
				end

				arg_323_1.text_.text = var_326_45
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319931", "319931074", "story_v_out_319931.awb") ~= 0 then
					local var_326_49 = manager.audio:GetVoiceLength("story_v_out_319931", "319931074", "story_v_out_319931.awb") / 1000

					if var_326_49 + var_326_41 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_49 + var_326_41
					end

					if var_326_44.prefab_name ~= "" and arg_323_1.actors_[var_326_44.prefab_name] ~= nil then
						local var_326_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_44.prefab_name].transform, "story_v_out_319931", "319931074", "story_v_out_319931.awb")

						arg_323_1:RecordAudio("319931074", var_326_50)
						arg_323_1:RecordAudio("319931074", var_326_50)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_319931", "319931074", "story_v_out_319931.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_319931", "319931074", "story_v_out_319931.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_51 = var_326_41 + 0.3
			local var_326_52 = math.max(var_326_42, arg_323_1.talkMaxDuration)

			if var_326_51 <= arg_323_1.time_ and arg_323_1.time_ < var_326_51 + var_326_52 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_51) / var_326_52

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_51 + var_326_52 and arg_323_1.time_ < var_326_51 + var_326_52 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play319931075 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 319931075
		arg_329_1.duration_ = 5.53

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
			arg_329_1.auto_ = false
		end

		function arg_329_1.playNext_(arg_331_0)
			arg_329_1.onStoryFinished_()
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 0.2

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				local var_332_2 = "play"
				local var_332_3 = "music"

				arg_329_1:AudioAction(var_332_2, var_332_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_332_4 = ""
				local var_332_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_332_5 ~= "" then
					if arg_329_1.bgmTxt_.text ~= var_332_5 and arg_329_1.bgmTxt_.text ~= "" then
						if arg_329_1.bgmTxt2_.text ~= "" then
							arg_329_1.bgmTxt_.text = arg_329_1.bgmTxt2_.text
						end

						arg_329_1.bgmTxt2_.text = var_332_5

						arg_329_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_329_1.bgmTxt_.text = var_332_5
						arg_329_1.bgmTxt2_.text = var_332_5
					end

					if arg_329_1.bgmTimer then
						arg_329_1.bgmTimer:Stop()

						arg_329_1.bgmTimer = nil
					end

					if arg_329_1.settingData.show_music_name == 1 then
						arg_329_1.musicController:SetSelectedState("show")
						arg_329_1.musicAnimator_:Play("open", 0, 0)

						if arg_329_1.settingData.music_time ~= 0 then
							arg_329_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_329_1.settingData.music_time), function()
								if arg_329_1 == nil or isNil(arg_329_1.bgmTxt_) then
									return
								end

								arg_329_1.musicController:SetSelectedState("hide")
								arg_329_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_329_1.frameCnt_ <= 1 then
				arg_329_1.dialog_:SetActive(false)
			end

			local var_332_6 = 0.533333333333333
			local var_332_7 = 0.7

			if var_332_6 < arg_329_1.time_ and arg_329_1.time_ <= var_332_6 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0

				arg_329_1.dialog_:SetActive(true)

				arg_329_1.dialogCg_.alpha = 0

				local var_332_8 = LeanTween.value(arg_329_1.dialog_, 0, 1, 0.3)

				var_332_8:setOnUpdate(LuaHelper.FloatAction(function(arg_334_0)
					arg_329_1.dialogCg_.alpha = arg_334_0
				end))
				var_332_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_329_1.dialog_)
					var_332_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_329_1.duration_ = arg_329_1.duration_ + 0.3

				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_9 = arg_329_1:GetWordFromCfg(319931075)
				local var_332_10 = arg_329_1:FormatText(var_332_9.content)

				arg_329_1.text_.text = var_332_10

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_11 = 28
				local var_332_12 = utf8.len(var_332_10)
				local var_332_13 = var_332_11 <= 0 and var_332_7 or var_332_7 * (var_332_12 / var_332_11)

				if var_332_13 > 0 and var_332_7 < var_332_13 then
					arg_329_1.talkMaxDuration = var_332_13
					var_332_6 = var_332_6 + 0.3

					if var_332_13 + var_332_6 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_6
					end
				end

				arg_329_1.text_.text = var_332_10
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_14 = var_332_6 + 0.3
			local var_332_15 = math.max(var_332_7, arg_329_1.talkMaxDuration)

			if var_332_14 <= arg_329_1.time_ and arg_329_1.time_ < var_332_14 + var_332_15 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_14) / var_332_15

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_14 + var_332_15 and arg_329_1.time_ < var_332_14 + var_332_15 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I11r",
		"TextureConfig/Background/I11i",
		"TextureConfig/Background/ML0207",
		"TextureConfig/Background/D999",
		"TextureConfig/Background/XH0204",
		"TextureConfig/Background/XH0506",
		"TextureConfig/Background/ML0101",
		"TextureConfig/Background/I10f"
	},
	voices = {
		"story_v_out_319931.awb"
	}
}
