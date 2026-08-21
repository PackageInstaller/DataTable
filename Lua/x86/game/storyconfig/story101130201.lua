return {
	Play113021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play113021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "OM0101"

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
				local var_4_5 = arg_1_1.bgs_.OM0101

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
					if iter_4_0 ~= "OM0101" then
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
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_31 = arg_1_1:GetWordFromCfg(113021001)
				local var_4_32 = arg_1_1:FormatText(var_4_31.content)

				arg_1_1.text_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 4
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
	Play113021002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 113021002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play113021003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.45

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

				local var_11_2 = arg_8_1:GetWordFromCfg(113021002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 58
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
	Play113021003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 113021003
		arg_12_1.duration_ = 4.8

		local var_12_0 = {
			ja = 4.733,
			ko = 4.066,
			zh = 3.1,
			en = 4.8
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play113021004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.3

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[6].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(113021003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 12
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021003", "story_v_out_113021.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_113021", "113021003", "story_v_out_113021.awb") / 1000

					if var_15_8 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_0
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_113021", "113021003", "story_v_out_113021.awb")

						arg_12_1:RecordAudio("113021003", var_15_9)
						arg_12_1:RecordAudio("113021003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_113021", "113021003", "story_v_out_113021.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_113021", "113021003", "story_v_out_113021.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_10 and arg_12_1.time_ < var_15_0 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play113021004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 113021004
		arg_16_1.duration_ = 14.2

		local var_16_0 = {
			ja = 14.2,
			ko = 13.933,
			zh = 11.6,
			en = 13
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
				arg_16_0:Play113021005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.3

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[13].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(113021004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 52
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

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021004", "story_v_out_113021.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_113021", "113021004", "story_v_out_113021.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_113021", "113021004", "story_v_out_113021.awb")

						arg_16_1:RecordAudio("113021004", var_19_9)
						arg_16_1:RecordAudio("113021004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_113021", "113021004", "story_v_out_113021.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_113021", "113021004", "story_v_out_113021.awb")
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
	Play113021005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 113021005
		arg_20_1.duration_ = 0.02

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"

			SetActive(arg_20_1.choicesGo_, true)

			for iter_21_0, iter_21_1 in ipairs(arg_20_1.choices_) do
				local var_21_0 = iter_21_0 <= 1

				SetActive(iter_21_1.go, var_21_0)
			end

			arg_20_1.choices_[1].txt.text = arg_20_1:FormatText(StoryChoiceCfg[185].name)
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play113021006(arg_20_1)
			end

			arg_20_1:RecordChoiceLog(113021005, 185)
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			return
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play113021006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 113021006
		arg_24_1.duration_ = 13.97

		local var_24_0 = {
			ja = 13.966,
			ko = 12.233,
			zh = 11.866,
			en = 13.033
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
				arg_24_0:Play113021007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 1.1

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[13].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(113021006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021006", "story_v_out_113021.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_113021", "113021006", "story_v_out_113021.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_113021", "113021006", "story_v_out_113021.awb")

						arg_24_1:RecordAudio("113021006", var_27_9)
						arg_24_1:RecordAudio("113021006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_113021", "113021006", "story_v_out_113021.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_113021", "113021006", "story_v_out_113021.awb")
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
	Play113021007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 113021007
		arg_28_1.duration_ = 7.9

		local var_28_0 = {
			ja = 6.266,
			ko = 4.366,
			zh = 5.133,
			en = 7.9
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play113021008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.6

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[13].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(113021007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 24
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021007", "story_v_out_113021.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_113021", "113021007", "story_v_out_113021.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_113021", "113021007", "story_v_out_113021.awb")

						arg_28_1:RecordAudio("113021007", var_31_9)
						arg_28_1:RecordAudio("113021007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_113021", "113021007", "story_v_out_113021.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_113021", "113021007", "story_v_out_113021.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_10 and arg_28_1.time_ < var_31_0 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play113021008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 113021008
		arg_32_1.duration_ = 8.7

		local var_32_0 = {
			ja = 8.7,
			ko = 7.5,
			zh = 8,
			en = 8.5
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play113021009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 1.025

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[13].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(113021008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 41
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021008", "story_v_out_113021.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_113021", "113021008", "story_v_out_113021.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_113021", "113021008", "story_v_out_113021.awb")

						arg_32_1:RecordAudio("113021008", var_35_9)
						arg_32_1:RecordAudio("113021008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_113021", "113021008", "story_v_out_113021.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_113021", "113021008", "story_v_out_113021.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play113021009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 113021009
		arg_36_1.duration_ = 6.9

		local var_36_0 = {
			ja = 4.9,
			ko = 6.466,
			zh = 6.9,
			en = 5.8
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play113021010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.725

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[6].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(113021009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 29
				local var_39_6 = utf8.len(var_39_4)
				local var_39_7 = var_39_5 <= 0 and var_39_1 or var_39_1 * (var_39_6 / var_39_5)

				if var_39_7 > 0 and var_39_1 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021009", "story_v_out_113021.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_113021", "113021009", "story_v_out_113021.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_113021", "113021009", "story_v_out_113021.awb")

						arg_36_1:RecordAudio("113021009", var_39_9)
						arg_36_1:RecordAudio("113021009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_113021", "113021009", "story_v_out_113021.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_113021", "113021009", "story_v_out_113021.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_10 and arg_36_1.time_ < var_39_0 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play113021010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 113021010
		arg_40_1.duration_ = 2

		local var_40_0 = {
			ja = 2,
			ko = 1.666,
			zh = 1.4,
			en = 1.466
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play113021011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.175

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[13].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(113021010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 5
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021010", "story_v_out_113021.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_113021", "113021010", "story_v_out_113021.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_113021", "113021010", "story_v_out_113021.awb")

						arg_40_1:RecordAudio("113021010", var_43_9)
						arg_40_1:RecordAudio("113021010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_113021", "113021010", "story_v_out_113021.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_113021", "113021010", "story_v_out_113021.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play113021011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 113021011
		arg_44_1.duration_ = 9

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play113021012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "A00"

			if arg_44_1.bgs_[var_47_0] == nil then
				local var_47_1 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_47_0)
				var_47_1.name = var_47_0
				var_47_1.transform.parent = arg_44_1.stage_.transform
				var_47_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_[var_47_0] = var_47_1
			end

			local var_47_2 = 2

			if var_47_2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				local var_47_3 = manager.ui.mainCamera.transform.localPosition
				local var_47_4 = Vector3.New(0, 0, 10) + Vector3.New(var_47_3.x, var_47_3.y, 0)
				local var_47_5 = arg_44_1.bgs_.A00

				var_47_5.transform.localPosition = var_47_4
				var_47_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_6 = var_47_5:GetComponent("SpriteRenderer")

				if var_47_6 and var_47_6.sprite then
					local var_47_7 = (var_47_5.transform.localPosition - var_47_3).z
					local var_47_8 = manager.ui.mainCameraCom_
					local var_47_9 = 2 * var_47_7 * Mathf.Tan(var_47_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_47_10 = var_47_9 * var_47_8.aspect
					local var_47_11 = var_47_6.sprite.bounds.size.x
					local var_47_12 = var_47_6.sprite.bounds.size.y
					local var_47_13 = var_47_10 / var_47_11
					local var_47_14 = var_47_9 / var_47_12
					local var_47_15 = var_47_14 < var_47_13 and var_47_13 or var_47_14

					var_47_5.transform.localScale = Vector3.New(var_47_15, var_47_15, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "A00" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_17 = 2

			if var_47_16 <= arg_44_1.time_ and arg_44_1.time_ < var_47_16 + var_47_17 then
				local var_47_18 = (arg_44_1.time_ - var_47_16) / var_47_17
				local var_47_19 = Color.New(0, 0, 0)

				var_47_19.a = Mathf.Lerp(0, 1, var_47_18)
				arg_44_1.mask_.color = var_47_19
			end

			if arg_44_1.time_ >= var_47_16 + var_47_17 and arg_44_1.time_ < var_47_16 + var_47_17 + arg_47_0 then
				local var_47_20 = Color.New(0, 0, 0)

				var_47_20.a = 1
				arg_44_1.mask_.color = var_47_20
			end

			local var_47_21 = 2

			if var_47_21 < arg_44_1.time_ and arg_44_1.time_ <= var_47_21 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_22 = 2

			if var_47_21 <= arg_44_1.time_ and arg_44_1.time_ < var_47_21 + var_47_22 then
				local var_47_23 = (arg_44_1.time_ - var_47_21) / var_47_22
				local var_47_24 = Color.New(0, 0, 0)

				var_47_24.a = Mathf.Lerp(1, 0, var_47_23)
				arg_44_1.mask_.color = var_47_24
			end

			if arg_44_1.time_ >= var_47_21 + var_47_22 and arg_44_1.time_ < var_47_21 + var_47_22 + arg_47_0 then
				local var_47_25 = Color.New(0, 0, 0)
				local var_47_26 = 0

				arg_44_1.mask_.enabled = false
				var_47_25.a = var_47_26
				arg_44_1.mask_.color = var_47_25
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_27 = 4
			local var_47_28 = 0.425

			if var_47_27 < arg_44_1.time_ and arg_44_1.time_ <= var_47_27 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_29 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_29:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_30 = arg_44_1:GetWordFromCfg(113021011)
				local var_47_31 = arg_44_1:FormatText(var_47_30.content)

				arg_44_1.text_.text = var_47_31

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_32 = 17
				local var_47_33 = utf8.len(var_47_31)
				local var_47_34 = var_47_32 <= 0 and var_47_28 or var_47_28 * (var_47_33 / var_47_32)

				if var_47_34 > 0 and var_47_28 < var_47_34 then
					arg_44_1.talkMaxDuration = var_47_34
					var_47_27 = var_47_27 + 0.3

					if var_47_34 + var_47_27 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_34 + var_47_27
					end
				end

				arg_44_1.text_.text = var_47_31
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_35 = var_47_27 + 0.3
			local var_47_36 = math.max(var_47_28, arg_44_1.talkMaxDuration)

			if var_47_35 <= arg_44_1.time_ and arg_44_1.time_ < var_47_35 + var_47_36 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_35) / var_47_36

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_35 + var_47_36 and arg_44_1.time_ < var_47_35 + var_47_36 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play113021012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 113021012
		arg_50_1.duration_ = 18.7

		local var_50_0 = {
			ja = 12.833,
			ko = 9.533,
			zh = 10.066,
			en = 18.7
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
				arg_50_0:Play113021013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = "1019ui_story"

			if arg_50_1.actors_[var_53_0] == nil then
				local var_53_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_53_1) then
					local var_53_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_50_1.stage_.transform)

					var_53_2.name = var_53_0
					var_53_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_50_1.actors_[var_53_0] = var_53_2

					local var_53_3 = var_53_2:GetComponentInChildren(typeof(CharacterEffect))

					var_53_3.enabled = true

					local var_53_4 = GameObjectTools.GetOrAddComponent(var_53_2, typeof(DynamicBoneHelper))

					if var_53_4 then
						var_53_4:EnableDynamicBone(false)
					end

					arg_50_1:ShowWeapon(var_53_3.transform, false)

					arg_50_1.var_[var_53_0 .. "Animator"] = var_53_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_50_1.var_[var_53_0 .. "Animator"].applyRootMotion = true
					arg_50_1.var_[var_53_0 .. "LipSync"] = var_53_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_53_5 = arg_50_1.actors_["1019ui_story"].transform
			local var_53_6 = 0

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.var_.moveOldPos1019ui_story = var_53_5.localPosition
			end

			local var_53_7 = 0.001

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_7 then
				local var_53_8 = (arg_50_1.time_ - var_53_6) / var_53_7
				local var_53_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_53_5.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1019ui_story, var_53_9, var_53_8)

				local var_53_10 = manager.ui.mainCamera.transform.position - var_53_5.position

				var_53_5.forward = Vector3.New(var_53_10.x, var_53_10.y, var_53_10.z)

				local var_53_11 = var_53_5.localEulerAngles

				var_53_11.z = 0
				var_53_11.x = 0
				var_53_5.localEulerAngles = var_53_11
			end

			if arg_50_1.time_ >= var_53_6 + var_53_7 and arg_50_1.time_ < var_53_6 + var_53_7 + arg_53_0 then
				var_53_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_53_12 = manager.ui.mainCamera.transform.position - var_53_5.position

				var_53_5.forward = Vector3.New(var_53_12.x, var_53_12.y, var_53_12.z)

				local var_53_13 = var_53_5.localEulerAngles

				var_53_13.z = 0
				var_53_13.x = 0
				var_53_5.localEulerAngles = var_53_13
			end

			local var_53_14 = 0

			if var_53_14 < arg_50_1.time_ and arg_50_1.time_ <= var_53_14 + arg_53_0 then
				arg_50_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_53_15 = 0

			if var_53_15 < arg_50_1.time_ and arg_50_1.time_ <= var_53_15 + arg_53_0 then
				arg_50_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_53_16 = arg_50_1.actors_["1019ui_story"]
			local var_53_17 = 0

			if var_53_17 < arg_50_1.time_ and arg_50_1.time_ <= var_53_17 + arg_53_0 and not isNil(var_53_16) and arg_50_1.var_.characterEffect1019ui_story == nil then
				arg_50_1.var_.characterEffect1019ui_story = var_53_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_18 = 0.2

			if var_53_17 <= arg_50_1.time_ and arg_50_1.time_ < var_53_17 + var_53_18 and not isNil(var_53_16) then
				local var_53_19 = (arg_50_1.time_ - var_53_17) / var_53_18

				if arg_50_1.var_.characterEffect1019ui_story and not isNil(var_53_16) then
					arg_50_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_17 + var_53_18 and arg_50_1.time_ < var_53_17 + var_53_18 + arg_53_0 and not isNil(var_53_16) and arg_50_1.var_.characterEffect1019ui_story then
				arg_50_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_53_20 = 0
			local var_53_21 = 1.3

			if var_53_20 < arg_50_1.time_ and arg_50_1.time_ <= var_53_20 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_22 = arg_50_1:FormatText(StoryNameCfg[13].name)

				arg_50_1.leftNameTxt_.text = var_53_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_23 = arg_50_1:GetWordFromCfg(113021012)
				local var_53_24 = arg_50_1:FormatText(var_53_23.content)

				arg_50_1.text_.text = var_53_24

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_25 = 52
				local var_53_26 = utf8.len(var_53_24)
				local var_53_27 = var_53_25 <= 0 and var_53_21 or var_53_21 * (var_53_26 / var_53_25)

				if var_53_27 > 0 and var_53_21 < var_53_27 then
					arg_50_1.talkMaxDuration = var_53_27

					if var_53_27 + var_53_20 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_27 + var_53_20
					end
				end

				arg_50_1.text_.text = var_53_24
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021012", "story_v_out_113021.awb") ~= 0 then
					local var_53_28 = manager.audio:GetVoiceLength("story_v_out_113021", "113021012", "story_v_out_113021.awb") / 1000

					if var_53_28 + var_53_20 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_28 + var_53_20
					end

					if var_53_23.prefab_name ~= "" and arg_50_1.actors_[var_53_23.prefab_name] ~= nil then
						local var_53_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_23.prefab_name].transform, "story_v_out_113021", "113021012", "story_v_out_113021.awb")

						arg_50_1:RecordAudio("113021012", var_53_29)
						arg_50_1:RecordAudio("113021012", var_53_29)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_113021", "113021012", "story_v_out_113021.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_113021", "113021012", "story_v_out_113021.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_30 = math.max(var_53_21, arg_50_1.talkMaxDuration)

			if var_53_20 <= arg_50_1.time_ and arg_50_1.time_ < var_53_20 + var_53_30 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_20) / var_53_30

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_20 + var_53_30 and arg_50_1.time_ < var_53_20 + var_53_30 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play113021013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 113021013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play113021014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1019ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1019ui_story == nil then
				arg_54_1.var_.characterEffect1019ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.2

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1019ui_story and not isNil(var_57_0) then
					local var_57_4 = Mathf.Lerp(0, 0.5, var_57_3)

					arg_54_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1019ui_story.fillRatio = var_57_4
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1019ui_story then
				local var_57_5 = 0.5

				arg_54_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1019ui_story.fillRatio = var_57_5
			end

			local var_57_6 = 0
			local var_57_7 = 0.4

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_8 = arg_54_1:FormatText(StoryNameCfg[7].name)

				arg_54_1.leftNameTxt_.text = var_57_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_9 = arg_54_1:GetWordFromCfg(113021013)
				local var_57_10 = arg_54_1:FormatText(var_57_9.content)

				arg_54_1.text_.text = var_57_10

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_11 = 16
				local var_57_12 = utf8.len(var_57_10)
				local var_57_13 = var_57_11 <= 0 and var_57_7 or var_57_7 * (var_57_12 / var_57_11)

				if var_57_13 > 0 and var_57_7 < var_57_13 then
					arg_54_1.talkMaxDuration = var_57_13

					if var_57_13 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_13 + var_57_6
					end
				end

				arg_54_1.text_.text = var_57_10
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_14 = math.max(var_57_7, arg_54_1.talkMaxDuration)

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_14 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_6) / var_57_14

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_6 + var_57_14 and arg_54_1.time_ < var_57_6 + var_57_14 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play113021014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 113021014
		arg_58_1.duration_ = 10.07

		local var_58_0 = {
			ja = 10.066,
			ko = 5.3,
			zh = 5.533,
			en = 8.866
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
				arg_58_0:Play113021015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_61_1 = arg_58_1.actors_["1019ui_story"]
			local var_61_2 = 0

			if var_61_2 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect1019ui_story == nil then
				arg_58_1.var_.characterEffect1019ui_story = var_61_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_3 = 0.2

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_3 and not isNil(var_61_1) then
				local var_61_4 = (arg_58_1.time_ - var_61_2) / var_61_3

				if arg_58_1.var_.characterEffect1019ui_story and not isNil(var_61_1) then
					arg_58_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_2 + var_61_3 and arg_58_1.time_ < var_61_2 + var_61_3 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect1019ui_story then
				arg_58_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_61_5 = 0
			local var_61_6 = 0.725

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_7 = arg_58_1:FormatText(StoryNameCfg[13].name)

				arg_58_1.leftNameTxt_.text = var_61_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_8 = arg_58_1:GetWordFromCfg(113021014)
				local var_61_9 = arg_58_1:FormatText(var_61_8.content)

				arg_58_1.text_.text = var_61_9

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_10 = 29
				local var_61_11 = utf8.len(var_61_9)
				local var_61_12 = var_61_10 <= 0 and var_61_6 or var_61_6 * (var_61_11 / var_61_10)

				if var_61_12 > 0 and var_61_6 < var_61_12 then
					arg_58_1.talkMaxDuration = var_61_12

					if var_61_12 + var_61_5 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_12 + var_61_5
					end
				end

				arg_58_1.text_.text = var_61_9
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021014", "story_v_out_113021.awb") ~= 0 then
					local var_61_13 = manager.audio:GetVoiceLength("story_v_out_113021", "113021014", "story_v_out_113021.awb") / 1000

					if var_61_13 + var_61_5 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_5
					end

					if var_61_8.prefab_name ~= "" and arg_58_1.actors_[var_61_8.prefab_name] ~= nil then
						local var_61_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_8.prefab_name].transform, "story_v_out_113021", "113021014", "story_v_out_113021.awb")

						arg_58_1:RecordAudio("113021014", var_61_14)
						arg_58_1:RecordAudio("113021014", var_61_14)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_113021", "113021014", "story_v_out_113021.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_113021", "113021014", "story_v_out_113021.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_15 = math.max(var_61_6, arg_58_1.talkMaxDuration)

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_15 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_5) / var_61_15

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_5 + var_61_15 and arg_58_1.time_ < var_61_5 + var_61_15 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play113021015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 113021015
		arg_62_1.duration_ = 11.93

		local var_62_0 = {
			ja = 11.933,
			ko = 8.966,
			zh = 5.433,
			en = 8.066
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
				arg_62_0:Play113021016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_65_1 = 0
			local var_65_2 = 0.775

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_3 = arg_62_1:FormatText(StoryNameCfg[13].name)

				arg_62_1.leftNameTxt_.text = var_65_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_4 = arg_62_1:GetWordFromCfg(113021015)
				local var_65_5 = arg_62_1:FormatText(var_65_4.content)

				arg_62_1.text_.text = var_65_5

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_6 = 31
				local var_65_7 = utf8.len(var_65_5)
				local var_65_8 = var_65_6 <= 0 and var_65_2 or var_65_2 * (var_65_7 / var_65_6)

				if var_65_8 > 0 and var_65_2 < var_65_8 then
					arg_62_1.talkMaxDuration = var_65_8

					if var_65_8 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_1
					end
				end

				arg_62_1.text_.text = var_65_5
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021015", "story_v_out_113021.awb") ~= 0 then
					local var_65_9 = manager.audio:GetVoiceLength("story_v_out_113021", "113021015", "story_v_out_113021.awb") / 1000

					if var_65_9 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_9 + var_65_1
					end

					if var_65_4.prefab_name ~= "" and arg_62_1.actors_[var_65_4.prefab_name] ~= nil then
						local var_65_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_4.prefab_name].transform, "story_v_out_113021", "113021015", "story_v_out_113021.awb")

						arg_62_1:RecordAudio("113021015", var_65_10)
						arg_62_1:RecordAudio("113021015", var_65_10)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_113021", "113021015", "story_v_out_113021.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_113021", "113021015", "story_v_out_113021.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_11 = math.max(var_65_2, arg_62_1.talkMaxDuration)

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_11 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_1) / var_65_11

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_1 + var_65_11 and arg_62_1.time_ < var_65_1 + var_65_11 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play113021016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 113021016
		arg_66_1.duration_ = 6

		local var_66_0 = {
			ja = 6,
			ko = 5.466,
			zh = 5.466,
			en = 5.5
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
				arg_66_0:Play113021017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = "F01a"

			if arg_66_1.bgs_[var_69_0] == nil then
				local var_69_1 = Object.Instantiate(arg_66_1.paintGo_)

				var_69_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_69_0)
				var_69_1.name = var_69_0
				var_69_1.transform.parent = arg_66_1.stage_.transform
				var_69_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.bgs_[var_69_0] = var_69_1
			end

			local var_69_2 = 2

			if var_69_2 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				if arg_66_0.sceneSettingEffect_ then
					arg_66_1.sceneSettingEffect_.enabled = false
				end

				arg_66_1.sceneSettingGo_:SetActive(true)

				local var_69_3 = manager.ui.mainCamera.transform.localPosition
				local var_69_4 = Vector3.New(0, 0, 10) + Vector3.New(var_69_3.x, var_69_3.y, 0)
				local var_69_5 = arg_66_1.bgs_.F01a

				var_69_5.transform.localPosition = var_69_4
				var_69_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_6 = var_69_5:GetComponent("SpriteRenderer")

				if var_69_6 and var_69_6.sprite then
					local var_69_7 = (var_69_5.transform.localPosition - var_69_3).z
					local var_69_8 = manager.ui.mainCameraCom_
					local var_69_9 = 2 * var_69_7 * Mathf.Tan(var_69_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_69_10 = var_69_9 * var_69_8.aspect
					local var_69_11 = var_69_6.sprite.bounds.size.x
					local var_69_12 = var_69_6.sprite.bounds.size.y
					local var_69_13 = var_69_10 / var_69_11
					local var_69_14 = var_69_9 / var_69_12
					local var_69_15 = var_69_14 < var_69_13 and var_69_13 or var_69_14

					var_69_5.transform.localScale = Vector3.New(var_69_15, var_69_15, 0)
				end

				for iter_69_0, iter_69_1 in pairs(arg_66_1.bgs_) do
					if iter_69_0 ~= "F01a" then
						iter_69_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_16 = 0

			if var_69_16 < arg_66_1.time_ and arg_66_1.time_ <= var_69_16 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_17 = 2

			if var_69_16 <= arg_66_1.time_ and arg_66_1.time_ < var_69_16 + var_69_17 then
				local var_69_18 = (arg_66_1.time_ - var_69_16) / var_69_17
				local var_69_19 = Color.New(0, 0, 0)

				var_69_19.a = Mathf.Lerp(0, 1, var_69_18)
				arg_66_1.mask_.color = var_69_19
			end

			if arg_66_1.time_ >= var_69_16 + var_69_17 and arg_66_1.time_ < var_69_16 + var_69_17 + arg_69_0 then
				local var_69_20 = Color.New(0, 0, 0)

				var_69_20.a = 1
				arg_66_1.mask_.color = var_69_20
			end

			local var_69_21 = 2

			if var_69_21 < arg_66_1.time_ and arg_66_1.time_ <= var_69_21 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_22 = 2

			if var_69_21 <= arg_66_1.time_ and arg_66_1.time_ < var_69_21 + var_69_22 then
				local var_69_23 = (arg_66_1.time_ - var_69_21) / var_69_22
				local var_69_24 = Color.New(0, 0, 0)

				var_69_24.a = Mathf.Lerp(1, 0, var_69_23)
				arg_66_1.mask_.color = var_69_24
			end

			if arg_66_1.time_ >= var_69_21 + var_69_22 and arg_66_1.time_ < var_69_21 + var_69_22 + arg_69_0 then
				local var_69_25 = Color.New(0, 0, 0)
				local var_69_26 = 0

				arg_66_1.mask_.enabled = false
				var_69_25.a = var_69_26
				arg_66_1.mask_.color = var_69_25
			end

			local var_69_27 = arg_66_1.actors_["1019ui_story"].transform
			local var_69_28 = 1.966

			if var_69_28 < arg_66_1.time_ and arg_66_1.time_ <= var_69_28 + arg_69_0 then
				arg_66_1.var_.moveOldPos1019ui_story = var_69_27.localPosition
			end

			local var_69_29 = 0.001

			if var_69_28 <= arg_66_1.time_ and arg_66_1.time_ < var_69_28 + var_69_29 then
				local var_69_30 = (arg_66_1.time_ - var_69_28) / var_69_29
				local var_69_31 = Vector3.New(0, 100, 0)

				var_69_27.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1019ui_story, var_69_31, var_69_30)

				local var_69_32 = manager.ui.mainCamera.transform.position - var_69_27.position

				var_69_27.forward = Vector3.New(var_69_32.x, var_69_32.y, var_69_32.z)

				local var_69_33 = var_69_27.localEulerAngles

				var_69_33.z = 0
				var_69_33.x = 0
				var_69_27.localEulerAngles = var_69_33
			end

			if arg_66_1.time_ >= var_69_28 + var_69_29 and arg_66_1.time_ < var_69_28 + var_69_29 + arg_69_0 then
				var_69_27.localPosition = Vector3.New(0, 100, 0)

				local var_69_34 = manager.ui.mainCamera.transform.position - var_69_27.position

				var_69_27.forward = Vector3.New(var_69_34.x, var_69_34.y, var_69_34.z)

				local var_69_35 = var_69_27.localEulerAngles

				var_69_35.z = 0
				var_69_35.x = 0
				var_69_27.localEulerAngles = var_69_35
			end

			local var_69_36 = 0
			local var_69_37 = 1

			if var_69_36 < arg_66_1.time_ and arg_66_1.time_ <= var_69_36 + arg_69_0 then
				local var_69_38 = "play"
				local var_69_39 = "music"

				arg_66_1:AudioAction(var_69_38, var_69_39, "ui_battle", "ui_battle_stopbgm", "")

				local var_69_40 = ""
				local var_69_41 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_69_41 ~= "" then
					if arg_66_1.bgmTxt_.text ~= var_69_41 and arg_66_1.bgmTxt_.text ~= "" then
						if arg_66_1.bgmTxt2_.text ~= "" then
							arg_66_1.bgmTxt_.text = arg_66_1.bgmTxt2_.text
						end

						arg_66_1.bgmTxt2_.text = var_69_41

						arg_66_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_66_1.bgmTxt_.text = var_69_41
						arg_66_1.bgmTxt2_.text = var_69_41
					end

					if arg_66_1.bgmTimer then
						arg_66_1.bgmTimer:Stop()

						arg_66_1.bgmTimer = nil
					end

					if arg_66_1.settingData.show_music_name == 1 then
						arg_66_1.musicController:SetSelectedState("show")
						arg_66_1.musicAnimator_:Play("open", 0, 0)

						if arg_66_1.settingData.music_time ~= 0 then
							arg_66_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_66_1.settingData.music_time), function()
								if arg_66_1 == nil or isNil(arg_66_1.bgmTxt_) then
									return
								end

								arg_66_1.musicController:SetSelectedState("hide")
								arg_66_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_69_42 = 3.4
			local var_69_43 = 1

			if var_69_42 < arg_66_1.time_ and arg_66_1.time_ <= var_69_42 + arg_69_0 then
				local var_69_44 = "play"
				local var_69_45 = "music"

				arg_66_1:AudioAction(var_69_44, var_69_45, "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_69_46 = ""
				local var_69_47 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if var_69_47 ~= "" then
					if arg_66_1.bgmTxt_.text ~= var_69_47 and arg_66_1.bgmTxt_.text ~= "" then
						if arg_66_1.bgmTxt2_.text ~= "" then
							arg_66_1.bgmTxt_.text = arg_66_1.bgmTxt2_.text
						end

						arg_66_1.bgmTxt2_.text = var_69_47

						arg_66_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_66_1.bgmTxt_.text = var_69_47
						arg_66_1.bgmTxt2_.text = var_69_47
					end

					if arg_66_1.bgmTimer then
						arg_66_1.bgmTimer:Stop()

						arg_66_1.bgmTimer = nil
					end

					if arg_66_1.settingData.show_music_name == 1 then
						arg_66_1.musicController:SetSelectedState("show")
						arg_66_1.musicAnimator_:Play("open", 0, 0)

						if arg_66_1.settingData.music_time ~= 0 then
							arg_66_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_66_1.settingData.music_time), function()
								if arg_66_1 == nil or isNil(arg_66_1.bgmTxt_) then
									return
								end

								arg_66_1.musicController:SetSelectedState("hide")
								arg_66_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_48 = 4
			local var_69_49 = 0.125

			if var_69_48 < arg_66_1.time_ and arg_66_1.time_ <= var_69_48 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_50 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_50:setOnUpdate(LuaHelper.FloatAction(function(arg_72_0)
					arg_66_1.dialogCg_.alpha = arg_72_0
				end))
				var_69_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_51 = arg_66_1:FormatText(StoryNameCfg[94].name)

				arg_66_1.leftNameTxt_.text = var_69_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_52 = arg_66_1:GetWordFromCfg(113021016)
				local var_69_53 = arg_66_1:FormatText(var_69_52.content)

				arg_66_1.text_.text = var_69_53

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_54 = 5
				local var_69_55 = utf8.len(var_69_53)
				local var_69_56 = var_69_54 <= 0 and var_69_49 or var_69_49 * (var_69_55 / var_69_54)

				if var_69_56 > 0 and var_69_49 < var_69_56 then
					arg_66_1.talkMaxDuration = var_69_56
					var_69_48 = var_69_48 + 0.3

					if var_69_56 + var_69_48 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_56 + var_69_48
					end
				end

				arg_66_1.text_.text = var_69_53
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021016", "story_v_out_113021.awb") ~= 0 then
					local var_69_57 = manager.audio:GetVoiceLength("story_v_out_113021", "113021016", "story_v_out_113021.awb") / 1000

					if var_69_57 + var_69_48 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_57 + var_69_48
					end

					if var_69_52.prefab_name ~= "" and arg_66_1.actors_[var_69_52.prefab_name] ~= nil then
						local var_69_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_52.prefab_name].transform, "story_v_out_113021", "113021016", "story_v_out_113021.awb")

						arg_66_1:RecordAudio("113021016", var_69_58)
						arg_66_1:RecordAudio("113021016", var_69_58)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_113021", "113021016", "story_v_out_113021.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_113021", "113021016", "story_v_out_113021.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_59 = var_69_48 + 0.3
			local var_69_60 = math.max(var_69_49, arg_66_1.talkMaxDuration)

			if var_69_59 <= arg_66_1.time_ and arg_66_1.time_ < var_69_59 + var_69_60 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_59) / var_69_60

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_59 + var_69_60 and arg_66_1.time_ < var_69_59 + var_69_60 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play113021017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 113021017
		arg_74_1.duration_ = 6.4

		local var_74_0 = {
			ja = 5.166,
			ko = 5.466,
			zh = 6.4,
			en = 5.733
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
				arg_74_0:Play113021018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = "1084ui_story"

			if arg_74_1.actors_[var_77_0] == nil then
				local var_77_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_77_1) then
					local var_77_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_74_1.stage_.transform)

					var_77_2.name = var_77_0
					var_77_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_74_1.actors_[var_77_0] = var_77_2

					local var_77_3 = var_77_2:GetComponentInChildren(typeof(CharacterEffect))

					var_77_3.enabled = true

					local var_77_4 = GameObjectTools.GetOrAddComponent(var_77_2, typeof(DynamicBoneHelper))

					if var_77_4 then
						var_77_4:EnableDynamicBone(false)
					end

					arg_74_1:ShowWeapon(var_77_3.transform, false)

					arg_74_1.var_[var_77_0 .. "Animator"] = var_77_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_74_1.var_[var_77_0 .. "Animator"].applyRootMotion = true
					arg_74_1.var_[var_77_0 .. "LipSync"] = var_77_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_77_5 = arg_74_1.actors_["1084ui_story"].transform
			local var_77_6 = 0

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 then
				arg_74_1.var_.moveOldPos1084ui_story = var_77_5.localPosition
			end

			local var_77_7 = 0.001

			if var_77_6 <= arg_74_1.time_ and arg_74_1.time_ < var_77_6 + var_77_7 then
				local var_77_8 = (arg_74_1.time_ - var_77_6) / var_77_7
				local var_77_9 = Vector3.New(0, -0.97, -6)

				var_77_5.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1084ui_story, var_77_9, var_77_8)

				local var_77_10 = manager.ui.mainCamera.transform.position - var_77_5.position

				var_77_5.forward = Vector3.New(var_77_10.x, var_77_10.y, var_77_10.z)

				local var_77_11 = var_77_5.localEulerAngles

				var_77_11.z = 0
				var_77_11.x = 0
				var_77_5.localEulerAngles = var_77_11
			end

			if arg_74_1.time_ >= var_77_6 + var_77_7 and arg_74_1.time_ < var_77_6 + var_77_7 + arg_77_0 then
				var_77_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_77_12 = manager.ui.mainCamera.transform.position - var_77_5.position

				var_77_5.forward = Vector3.New(var_77_12.x, var_77_12.y, var_77_12.z)

				local var_77_13 = var_77_5.localEulerAngles

				var_77_13.z = 0
				var_77_13.x = 0
				var_77_5.localEulerAngles = var_77_13
			end

			local var_77_14 = 0

			if var_77_14 < arg_74_1.time_ and arg_74_1.time_ <= var_77_14 + arg_77_0 then
				arg_74_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_77_15 = 0

			if var_77_15 < arg_74_1.time_ and arg_74_1.time_ <= var_77_15 + arg_77_0 then
				arg_74_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_77_16 = arg_74_1.actors_["1084ui_story"]
			local var_77_17 = 0

			if var_77_17 < arg_74_1.time_ and arg_74_1.time_ <= var_77_17 + arg_77_0 and not isNil(var_77_16) and arg_74_1.var_.characterEffect1084ui_story == nil then
				arg_74_1.var_.characterEffect1084ui_story = var_77_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_18 = 0.2

			if var_77_17 <= arg_74_1.time_ and arg_74_1.time_ < var_77_17 + var_77_18 and not isNil(var_77_16) then
				local var_77_19 = (arg_74_1.time_ - var_77_17) / var_77_18

				if arg_74_1.var_.characterEffect1084ui_story and not isNil(var_77_16) then
					arg_74_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_17 + var_77_18 and arg_74_1.time_ < var_77_17 + var_77_18 + arg_77_0 and not isNil(var_77_16) and arg_74_1.var_.characterEffect1084ui_story then
				arg_74_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_77_20 = 0
			local var_77_21 = 0.525

			if var_77_20 < arg_74_1.time_ and arg_74_1.time_ <= var_77_20 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_22 = arg_74_1:FormatText(StoryNameCfg[6].name)

				arg_74_1.leftNameTxt_.text = var_77_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_23 = arg_74_1:GetWordFromCfg(113021017)
				local var_77_24 = arg_74_1:FormatText(var_77_23.content)

				arg_74_1.text_.text = var_77_24

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_25 = 21
				local var_77_26 = utf8.len(var_77_24)
				local var_77_27 = var_77_25 <= 0 and var_77_21 or var_77_21 * (var_77_26 / var_77_25)

				if var_77_27 > 0 and var_77_21 < var_77_27 then
					arg_74_1.talkMaxDuration = var_77_27

					if var_77_27 + var_77_20 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_27 + var_77_20
					end
				end

				arg_74_1.text_.text = var_77_24
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021017", "story_v_out_113021.awb") ~= 0 then
					local var_77_28 = manager.audio:GetVoiceLength("story_v_out_113021", "113021017", "story_v_out_113021.awb") / 1000

					if var_77_28 + var_77_20 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_28 + var_77_20
					end

					if var_77_23.prefab_name ~= "" and arg_74_1.actors_[var_77_23.prefab_name] ~= nil then
						local var_77_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_23.prefab_name].transform, "story_v_out_113021", "113021017", "story_v_out_113021.awb")

						arg_74_1:RecordAudio("113021017", var_77_29)
						arg_74_1:RecordAudio("113021017", var_77_29)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_113021", "113021017", "story_v_out_113021.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_113021", "113021017", "story_v_out_113021.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_30 = math.max(var_77_21, arg_74_1.talkMaxDuration)

			if var_77_20 <= arg_74_1.time_ and arg_74_1.time_ < var_77_20 + var_77_30 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_20) / var_77_30

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_20 + var_77_30 and arg_74_1.time_ < var_77_20 + var_77_30 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
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

		arg_74_1:InitPlayNodeList()
	end,
	Play113021018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 113021018
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play113021019(arg_78_1)
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
				local var_81_4 = Vector3.New(0, 100, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1084ui_story, var_81_4, var_81_3)

				local var_81_5 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_5.x, var_81_5.y, var_81_5.z)

				local var_81_6 = var_81_0.localEulerAngles

				var_81_6.z = 0
				var_81_6.x = 0
				var_81_0.localEulerAngles = var_81_6
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0, 100, 0)

				local var_81_7 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_7.x, var_81_7.y, var_81_7.z)

				local var_81_8 = var_81_0.localEulerAngles

				var_81_8.z = 0
				var_81_8.x = 0
				var_81_0.localEulerAngles = var_81_8
			end

			local var_81_9 = 0
			local var_81_10 = 0.95

			if var_81_9 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_11 = arg_78_1:GetWordFromCfg(113021018)
				local var_81_12 = arg_78_1:FormatText(var_81_11.content)

				arg_78_1.text_.text = var_81_12

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_13 = 38
				local var_81_14 = utf8.len(var_81_12)
				local var_81_15 = var_81_13 <= 0 and var_81_10 or var_81_10 * (var_81_14 / var_81_13)

				if var_81_15 > 0 and var_81_10 < var_81_15 then
					arg_78_1.talkMaxDuration = var_81_15

					if var_81_15 + var_81_9 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_15 + var_81_9
					end
				end

				arg_78_1.text_.text = var_81_12
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_16 = math.max(var_81_10, arg_78_1.talkMaxDuration)

			if var_81_9 <= arg_78_1.time_ and arg_78_1.time_ < var_81_9 + var_81_16 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_9) / var_81_16

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_9 + var_81_16 and arg_78_1.time_ < var_81_9 + var_81_16 + arg_81_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play113021019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 113021019
		arg_82_1.duration_ = 3.37

		local var_82_0 = {
			ja = 3.3,
			ko = 2.7,
			zh = 3.366,
			en = 2.133
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
				arg_82_0:Play113021020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = "1038ui_story"

			if arg_82_1.actors_[var_85_0] == nil then
				local var_85_1 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_85_1) then
					local var_85_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_82_1.stage_.transform)

					var_85_2.name = var_85_0
					var_85_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_82_1.actors_[var_85_0] = var_85_2

					local var_85_3 = var_85_2:GetComponentInChildren(typeof(CharacterEffect))

					var_85_3.enabled = true

					local var_85_4 = GameObjectTools.GetOrAddComponent(var_85_2, typeof(DynamicBoneHelper))

					if var_85_4 then
						var_85_4:EnableDynamicBone(false)
					end

					arg_82_1:ShowWeapon(var_85_3.transform, false)

					arg_82_1.var_[var_85_0 .. "Animator"] = var_85_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_82_1.var_[var_85_0 .. "Animator"].applyRootMotion = true
					arg_82_1.var_[var_85_0 .. "LipSync"] = var_85_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_85_5 = arg_82_1.actors_["1038ui_story"].transform
			local var_85_6 = 0

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.var_.moveOldPos1038ui_story = var_85_5.localPosition
			end

			local var_85_7 = 0.001

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_7 then
				local var_85_8 = (arg_82_1.time_ - var_85_6) / var_85_7
				local var_85_9 = Vector3.New(0, -1.11, -5.9)

				var_85_5.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1038ui_story, var_85_9, var_85_8)

				local var_85_10 = manager.ui.mainCamera.transform.position - var_85_5.position

				var_85_5.forward = Vector3.New(var_85_10.x, var_85_10.y, var_85_10.z)

				local var_85_11 = var_85_5.localEulerAngles

				var_85_11.z = 0
				var_85_11.x = 0
				var_85_5.localEulerAngles = var_85_11
			end

			if arg_82_1.time_ >= var_85_6 + var_85_7 and arg_82_1.time_ < var_85_6 + var_85_7 + arg_85_0 then
				var_85_5.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_85_12 = manager.ui.mainCamera.transform.position - var_85_5.position

				var_85_5.forward = Vector3.New(var_85_12.x, var_85_12.y, var_85_12.z)

				local var_85_13 = var_85_5.localEulerAngles

				var_85_13.z = 0
				var_85_13.x = 0
				var_85_5.localEulerAngles = var_85_13
			end

			local var_85_14 = 0

			if var_85_14 < arg_82_1.time_ and arg_82_1.time_ <= var_85_14 + arg_85_0 then
				arg_82_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action6_1")
			end

			local var_85_15 = 0

			if var_85_15 < arg_82_1.time_ and arg_82_1.time_ <= var_85_15 + arg_85_0 then
				arg_82_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_85_16 = arg_82_1.actors_["1038ui_story"]
			local var_85_17 = 0

			if var_85_17 < arg_82_1.time_ and arg_82_1.time_ <= var_85_17 + arg_85_0 and not isNil(var_85_16) and arg_82_1.var_.characterEffect1038ui_story == nil then
				arg_82_1.var_.characterEffect1038ui_story = var_85_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_18 = 0.2

			if var_85_17 <= arg_82_1.time_ and arg_82_1.time_ < var_85_17 + var_85_18 and not isNil(var_85_16) then
				local var_85_19 = (arg_82_1.time_ - var_85_17) / var_85_18

				if arg_82_1.var_.characterEffect1038ui_story and not isNil(var_85_16) then
					arg_82_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_17 + var_85_18 and arg_82_1.time_ < var_85_17 + var_85_18 + arg_85_0 and not isNil(var_85_16) and arg_82_1.var_.characterEffect1038ui_story then
				arg_82_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_85_20 = 0
			local var_85_21 = 0.325

			if var_85_20 < arg_82_1.time_ and arg_82_1.time_ <= var_85_20 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_22 = arg_82_1:FormatText(StoryNameCfg[94].name)

				arg_82_1.leftNameTxt_.text = var_85_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_23 = arg_82_1:GetWordFromCfg(113021019)
				local var_85_24 = arg_82_1:FormatText(var_85_23.content)

				arg_82_1.text_.text = var_85_24

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_25 = 13
				local var_85_26 = utf8.len(var_85_24)
				local var_85_27 = var_85_25 <= 0 and var_85_21 or var_85_21 * (var_85_26 / var_85_25)

				if var_85_27 > 0 and var_85_21 < var_85_27 then
					arg_82_1.talkMaxDuration = var_85_27

					if var_85_27 + var_85_20 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_27 + var_85_20
					end
				end

				arg_82_1.text_.text = var_85_24
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021019", "story_v_out_113021.awb") ~= 0 then
					local var_85_28 = manager.audio:GetVoiceLength("story_v_out_113021", "113021019", "story_v_out_113021.awb") / 1000

					if var_85_28 + var_85_20 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_28 + var_85_20
					end

					if var_85_23.prefab_name ~= "" and arg_82_1.actors_[var_85_23.prefab_name] ~= nil then
						local var_85_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_23.prefab_name].transform, "story_v_out_113021", "113021019", "story_v_out_113021.awb")

						arg_82_1:RecordAudio("113021019", var_85_29)
						arg_82_1:RecordAudio("113021019", var_85_29)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_113021", "113021019", "story_v_out_113021.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_113021", "113021019", "story_v_out_113021.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_30 = math.max(var_85_21, arg_82_1.talkMaxDuration)

			if var_85_20 <= arg_82_1.time_ and arg_82_1.time_ < var_85_20 + var_85_30 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_20) / var_85_30

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_20 + var_85_30 and arg_82_1.time_ < var_85_20 + var_85_30 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
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

		arg_82_1:InitPlayNodeList()
	end,
	Play113021020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 113021020
		arg_86_1.duration_ = 12.2

		local var_86_0 = {
			ja = 12.2,
			ko = 8.4,
			zh = 9.3,
			en = 9.8
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
				arg_86_0:Play113021021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0

			if var_89_0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_89_1 = 0
			local var_89_2 = 1.075

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_3 = arg_86_1:FormatText(StoryNameCfg[94].name)

				arg_86_1.leftNameTxt_.text = var_89_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_4 = arg_86_1:GetWordFromCfg(113021020)
				local var_89_5 = arg_86_1:FormatText(var_89_4.content)

				arg_86_1.text_.text = var_89_5

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_6 = 43
				local var_89_7 = utf8.len(var_89_5)
				local var_89_8 = var_89_6 <= 0 and var_89_2 or var_89_2 * (var_89_7 / var_89_6)

				if var_89_8 > 0 and var_89_2 < var_89_8 then
					arg_86_1.talkMaxDuration = var_89_8

					if var_89_8 + var_89_1 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_1
					end
				end

				arg_86_1.text_.text = var_89_5
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021020", "story_v_out_113021.awb") ~= 0 then
					local var_89_9 = manager.audio:GetVoiceLength("story_v_out_113021", "113021020", "story_v_out_113021.awb") / 1000

					if var_89_9 + var_89_1 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_1
					end

					if var_89_4.prefab_name ~= "" and arg_86_1.actors_[var_89_4.prefab_name] ~= nil then
						local var_89_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_4.prefab_name].transform, "story_v_out_113021", "113021020", "story_v_out_113021.awb")

						arg_86_1:RecordAudio("113021020", var_89_10)
						arg_86_1:RecordAudio("113021020", var_89_10)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_113021", "113021020", "story_v_out_113021.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_113021", "113021020", "story_v_out_113021.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_11 = math.max(var_89_2, arg_86_1.talkMaxDuration)

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_11 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_1) / var_89_11

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_1 + var_89_11 and arg_86_1.time_ < var_89_1 + var_89_11 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play113021021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 113021021
		arg_90_1.duration_ = 10.53

		local var_90_0 = {
			ja = 10.533,
			ko = 9.4,
			zh = 7.966,
			en = 10.033
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
				arg_90_0:Play113021022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action465")
			end

			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_93_2 = 0
			local var_93_3 = 0.975

			if var_93_2 < arg_90_1.time_ and arg_90_1.time_ <= var_93_2 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_4 = arg_90_1:FormatText(StoryNameCfg[94].name)

				arg_90_1.leftNameTxt_.text = var_93_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_5 = arg_90_1:GetWordFromCfg(113021021)
				local var_93_6 = arg_90_1:FormatText(var_93_5.content)

				arg_90_1.text_.text = var_93_6

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_7 = 39
				local var_93_8 = utf8.len(var_93_6)
				local var_93_9 = var_93_7 <= 0 and var_93_3 or var_93_3 * (var_93_8 / var_93_7)

				if var_93_9 > 0 and var_93_3 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_2
					end
				end

				arg_90_1.text_.text = var_93_6
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021021", "story_v_out_113021.awb") ~= 0 then
					local var_93_10 = manager.audio:GetVoiceLength("story_v_out_113021", "113021021", "story_v_out_113021.awb") / 1000

					if var_93_10 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_2
					end

					if var_93_5.prefab_name ~= "" and arg_90_1.actors_[var_93_5.prefab_name] ~= nil then
						local var_93_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_5.prefab_name].transform, "story_v_out_113021", "113021021", "story_v_out_113021.awb")

						arg_90_1:RecordAudio("113021021", var_93_11)
						arg_90_1:RecordAudio("113021021", var_93_11)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_113021", "113021021", "story_v_out_113021.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_113021", "113021021", "story_v_out_113021.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_12 = math.max(var_93_3, arg_90_1.talkMaxDuration)

			if var_93_2 <= arg_90_1.time_ and arg_90_1.time_ < var_93_2 + var_93_12 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_2) / var_93_12

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_2 + var_93_12 and arg_90_1.time_ < var_93_2 + var_93_12 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play113021022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 113021022
		arg_94_1.duration_ = 8.1

		local var_94_0 = {
			ja = 7.8,
			ko = 5.633,
			zh = 5.366,
			en = 8.1
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play113021023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1038ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1038ui_story == nil then
				arg_94_1.var_.characterEffect1038ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.2

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1038ui_story and not isNil(var_97_0) then
					local var_97_4 = Mathf.Lerp(0, 0.5, var_97_3)

					arg_94_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1038ui_story.fillRatio = var_97_4
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1038ui_story then
				local var_97_5 = 0.5

				arg_94_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1038ui_story.fillRatio = var_97_5
			end

			local var_97_6 = 0
			local var_97_7 = 0.6

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_8 = arg_94_1:FormatText(StoryNameCfg[6].name)

				arg_94_1.leftNameTxt_.text = var_97_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_9 = arg_94_1:GetWordFromCfg(113021022)
				local var_97_10 = arg_94_1:FormatText(var_97_9.content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021022", "story_v_out_113021.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_113021", "113021022", "story_v_out_113021.awb") / 1000

					if var_97_14 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_6
					end

					if var_97_9.prefab_name ~= "" and arg_94_1.actors_[var_97_9.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_9.prefab_name].transform, "story_v_out_113021", "113021022", "story_v_out_113021.awb")

						arg_94_1:RecordAudio("113021022", var_97_15)
						arg_94_1:RecordAudio("113021022", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_113021", "113021022", "story_v_out_113021.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_113021", "113021022", "story_v_out_113021.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_16 and arg_94_1.time_ < var_97_6 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play113021023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 113021023
		arg_98_1.duration_ = 2

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play113021024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_101_1 = arg_98_1.actors_["1038ui_story"]
			local var_101_2 = 0

			if var_101_2 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect1038ui_story == nil then
				arg_98_1.var_.characterEffect1038ui_story = var_101_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_3 = 0.2

			if var_101_2 <= arg_98_1.time_ and arg_98_1.time_ < var_101_2 + var_101_3 and not isNil(var_101_1) then
				local var_101_4 = (arg_98_1.time_ - var_101_2) / var_101_3

				if arg_98_1.var_.characterEffect1038ui_story and not isNil(var_101_1) then
					arg_98_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_2 + var_101_3 and arg_98_1.time_ < var_101_2 + var_101_3 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect1038ui_story then
				arg_98_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_101_5 = 0
			local var_101_6 = 0.05

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_7 = arg_98_1:FormatText(StoryNameCfg[94].name)

				arg_98_1.leftNameTxt_.text = var_101_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_8 = arg_98_1:GetWordFromCfg(113021023)
				local var_101_9 = arg_98_1:FormatText(var_101_8.content)

				arg_98_1.text_.text = var_101_9

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_10 = 2
				local var_101_11 = utf8.len(var_101_9)
				local var_101_12 = var_101_10 <= 0 and var_101_6 or var_101_6 * (var_101_11 / var_101_10)

				if var_101_12 > 0 and var_101_6 < var_101_12 then
					arg_98_1.talkMaxDuration = var_101_12

					if var_101_12 + var_101_5 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_12 + var_101_5
					end
				end

				arg_98_1.text_.text = var_101_9
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021023", "story_v_out_113021.awb") ~= 0 then
					local var_101_13 = manager.audio:GetVoiceLength("story_v_out_113021", "113021023", "story_v_out_113021.awb") / 1000

					if var_101_13 + var_101_5 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_5
					end

					if var_101_8.prefab_name ~= "" and arg_98_1.actors_[var_101_8.prefab_name] ~= nil then
						local var_101_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_8.prefab_name].transform, "story_v_out_113021", "113021023", "story_v_out_113021.awb")

						arg_98_1:RecordAudio("113021023", var_101_14)
						arg_98_1:RecordAudio("113021023", var_101_14)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_113021", "113021023", "story_v_out_113021.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_113021", "113021023", "story_v_out_113021.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_15 = math.max(var_101_6, arg_98_1.talkMaxDuration)

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_15 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_5) / var_101_15

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_5 + var_101_15 and arg_98_1.time_ < var_101_5 + var_101_15 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play113021024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 113021024
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play113021025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1038ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos1038ui_story = var_105_0.localPosition
			end

			local var_105_2 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2
				local var_105_4 = Vector3.New(0, 100, 0)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1038ui_story, var_105_4, var_105_3)

				local var_105_5 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_5.x, var_105_5.y, var_105_5.z)

				local var_105_6 = var_105_0.localEulerAngles

				var_105_6.z = 0
				var_105_6.x = 0
				var_105_0.localEulerAngles = var_105_6
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0, 100, 0)

				local var_105_7 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_7.x, var_105_7.y, var_105_7.z)

				local var_105_8 = var_105_0.localEulerAngles

				var_105_8.z = 0
				var_105_8.x = 0
				var_105_0.localEulerAngles = var_105_8
			end

			local var_105_9 = 0
			local var_105_10 = 1

			if var_105_9 < arg_102_1.time_ and arg_102_1.time_ <= var_105_9 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_11 = arg_102_1:GetWordFromCfg(113021024)
				local var_105_12 = arg_102_1:FormatText(var_105_11.content)

				arg_102_1.text_.text = var_105_12

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_13 = 40
				local var_105_14 = utf8.len(var_105_12)
				local var_105_15 = var_105_13 <= 0 and var_105_10 or var_105_10 * (var_105_14 / var_105_13)

				if var_105_15 > 0 and var_105_10 < var_105_15 then
					arg_102_1.talkMaxDuration = var_105_15

					if var_105_15 + var_105_9 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_15 + var_105_9
					end
				end

				arg_102_1.text_.text = var_105_12
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_16 = math.max(var_105_10, arg_102_1.talkMaxDuration)

			if var_105_9 <= arg_102_1.time_ and arg_102_1.time_ < var_105_9 + var_105_16 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_9) / var_105_16

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_9 + var_105_16 and arg_102_1.time_ < var_105_9 + var_105_16 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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

		arg_102_1:InitPlayNodeList()
	end,
	Play113021025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 113021025
		arg_106_1.duration_ = 4.03

		local var_106_0 = {
			ja = 3.066,
			ko = 3.933,
			zh = 3.1,
			en = 4.033
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
				arg_106_0:Play113021026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.4

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[209].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:GetWordFromCfg(113021025)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 16
				local var_109_6 = utf8.len(var_109_4)
				local var_109_7 = var_109_5 <= 0 and var_109_1 or var_109_1 * (var_109_6 / var_109_5)

				if var_109_7 > 0 and var_109_1 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021025", "story_v_out_113021.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_113021", "113021025", "story_v_out_113021.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_113021", "113021025", "story_v_out_113021.awb")

						arg_106_1:RecordAudio("113021025", var_109_9)
						arg_106_1:RecordAudio("113021025", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_113021", "113021025", "story_v_out_113021.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_113021", "113021025", "story_v_out_113021.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_10 and arg_106_1.time_ < var_109_0 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play113021026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 113021026
		arg_110_1.duration_ = 8.1

		local var_110_0 = {
			ja = 7.166,
			ko = 8.1,
			zh = 4.666,
			en = 8.1
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
				arg_110_0:Play113021027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 0.7

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[210].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(113021026)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 28
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021026", "story_v_out_113021.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_113021", "113021026", "story_v_out_113021.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_113021", "113021026", "story_v_out_113021.awb")

						arg_110_1:RecordAudio("113021026", var_113_9)
						arg_110_1:RecordAudio("113021026", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_113021", "113021026", "story_v_out_113021.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_113021", "113021026", "story_v_out_113021.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play113021027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 113021027
		arg_114_1.duration_ = 4.13

		local var_114_0 = {
			ja = 3.233,
			ko = 3.733,
			zh = 4.133,
			en = 3.533
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
				arg_114_0:Play113021028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1084ui_story"].transform
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos1084ui_story = var_117_0.localPosition
			end

			local var_117_2 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2
				local var_117_4 = Vector3.New(-0.7, -0.97, -6)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1084ui_story, var_117_4, var_117_3)

				local var_117_5 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_5.x, var_117_5.y, var_117_5.z)

				local var_117_6 = var_117_0.localEulerAngles

				var_117_6.z = 0
				var_117_6.x = 0
				var_117_0.localEulerAngles = var_117_6
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_117_7 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_7.x, var_117_7.y, var_117_7.z)

				local var_117_8 = var_117_0.localEulerAngles

				var_117_8.z = 0
				var_117_8.x = 0
				var_117_0.localEulerAngles = var_117_8
			end

			local var_117_9 = 0

			if var_117_9 < arg_114_1.time_ and arg_114_1.time_ <= var_117_9 + arg_117_0 then
				arg_114_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_117_11 = arg_114_1.actors_["1084ui_story"]
			local var_117_12 = 0

			if var_117_12 < arg_114_1.time_ and arg_114_1.time_ <= var_117_12 + arg_117_0 and not isNil(var_117_11) and arg_114_1.var_.characterEffect1084ui_story == nil then
				arg_114_1.var_.characterEffect1084ui_story = var_117_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_13 = 0.2

			if var_117_12 <= arg_114_1.time_ and arg_114_1.time_ < var_117_12 + var_117_13 and not isNil(var_117_11) then
				local var_117_14 = (arg_114_1.time_ - var_117_12) / var_117_13

				if arg_114_1.var_.characterEffect1084ui_story and not isNil(var_117_11) then
					arg_114_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_12 + var_117_13 and arg_114_1.time_ < var_117_12 + var_117_13 + arg_117_0 and not isNil(var_117_11) and arg_114_1.var_.characterEffect1084ui_story then
				arg_114_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_117_15 = 0
			local var_117_16 = 0.275

			if var_117_15 < arg_114_1.time_ and arg_114_1.time_ <= var_117_15 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_17 = arg_114_1:FormatText(StoryNameCfg[6].name)

				arg_114_1.leftNameTxt_.text = var_117_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_18 = arg_114_1:GetWordFromCfg(113021027)
				local var_117_19 = arg_114_1:FormatText(var_117_18.content)

				arg_114_1.text_.text = var_117_19

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_20 = 11
				local var_117_21 = utf8.len(var_117_19)
				local var_117_22 = var_117_20 <= 0 and var_117_16 or var_117_16 * (var_117_21 / var_117_20)

				if var_117_22 > 0 and var_117_16 < var_117_22 then
					arg_114_1.talkMaxDuration = var_117_22

					if var_117_22 + var_117_15 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_22 + var_117_15
					end
				end

				arg_114_1.text_.text = var_117_19
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021027", "story_v_out_113021.awb") ~= 0 then
					local var_117_23 = manager.audio:GetVoiceLength("story_v_out_113021", "113021027", "story_v_out_113021.awb") / 1000

					if var_117_23 + var_117_15 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_23 + var_117_15
					end

					if var_117_18.prefab_name ~= "" and arg_114_1.actors_[var_117_18.prefab_name] ~= nil then
						local var_117_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_18.prefab_name].transform, "story_v_out_113021", "113021027", "story_v_out_113021.awb")

						arg_114_1:RecordAudio("113021027", var_117_24)
						arg_114_1:RecordAudio("113021027", var_117_24)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_113021", "113021027", "story_v_out_113021.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_113021", "113021027", "story_v_out_113021.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_25 = math.max(var_117_16, arg_114_1.talkMaxDuration)

			if var_117_15 <= arg_114_1.time_ and arg_114_1.time_ < var_117_15 + var_117_25 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_15) / var_117_25

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_15 + var_117_25 and arg_114_1.time_ < var_117_15 + var_117_25 + arg_117_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play113021028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 113021028
		arg_118_1.duration_ = 7.8

		local var_118_0 = {
			ja = 7.8,
			ko = 5.033,
			zh = 5.333,
			en = 4.833
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
				arg_118_0:Play113021029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1038ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos1038ui_story = var_121_0.localPosition
			end

			local var_121_2 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2
				local var_121_4 = Vector3.New(0.7, -1.11, -5.9)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1038ui_story, var_121_4, var_121_3)

				local var_121_5 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_5.x, var_121_5.y, var_121_5.z)

				local var_121_6 = var_121_0.localEulerAngles

				var_121_6.z = 0
				var_121_6.x = 0
				var_121_0.localEulerAngles = var_121_6
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_121_7 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_7.x, var_121_7.y, var_121_7.z)

				local var_121_8 = var_121_0.localEulerAngles

				var_121_8.z = 0
				var_121_8.x = 0
				var_121_0.localEulerAngles = var_121_8
			end

			local var_121_9 = 0

			if var_121_9 < arg_118_1.time_ and arg_118_1.time_ <= var_121_9 + arg_121_0 then
				arg_118_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_121_11 = arg_118_1.actors_["1038ui_story"]
			local var_121_12 = 0

			if var_121_12 < arg_118_1.time_ and arg_118_1.time_ <= var_121_12 + arg_121_0 and not isNil(var_121_11) and arg_118_1.var_.characterEffect1038ui_story == nil then
				arg_118_1.var_.characterEffect1038ui_story = var_121_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_13 = 0.2

			if var_121_12 <= arg_118_1.time_ and arg_118_1.time_ < var_121_12 + var_121_13 and not isNil(var_121_11) then
				local var_121_14 = (arg_118_1.time_ - var_121_12) / var_121_13

				if arg_118_1.var_.characterEffect1038ui_story and not isNil(var_121_11) then
					arg_118_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_12 + var_121_13 and arg_118_1.time_ < var_121_12 + var_121_13 + arg_121_0 and not isNil(var_121_11) and arg_118_1.var_.characterEffect1038ui_story then
				arg_118_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_121_15 = arg_118_1.actors_["1084ui_story"]
			local var_121_16 = 0

			if var_121_16 < arg_118_1.time_ and arg_118_1.time_ <= var_121_16 + arg_121_0 and not isNil(var_121_15) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_17 = 0.2

			if var_121_16 <= arg_118_1.time_ and arg_118_1.time_ < var_121_16 + var_121_17 and not isNil(var_121_15) then
				local var_121_18 = (arg_118_1.time_ - var_121_16) / var_121_17

				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_15) then
					local var_121_19 = Mathf.Lerp(0, 0.5, var_121_18)

					arg_118_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1084ui_story.fillRatio = var_121_19
				end
			end

			if arg_118_1.time_ >= var_121_16 + var_121_17 and arg_118_1.time_ < var_121_16 + var_121_17 + arg_121_0 and not isNil(var_121_15) and arg_118_1.var_.characterEffect1084ui_story then
				local var_121_20 = 0.5

				arg_118_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1084ui_story.fillRatio = var_121_20
			end

			local var_121_21 = 0
			local var_121_22 = 0.55

			if var_121_21 < arg_118_1.time_ and arg_118_1.time_ <= var_121_21 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_23 = arg_118_1:FormatText(StoryNameCfg[94].name)

				arg_118_1.leftNameTxt_.text = var_121_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_24 = arg_118_1:GetWordFromCfg(113021028)
				local var_121_25 = arg_118_1:FormatText(var_121_24.content)

				arg_118_1.text_.text = var_121_25

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_26 = 22
				local var_121_27 = utf8.len(var_121_25)
				local var_121_28 = var_121_26 <= 0 and var_121_22 or var_121_22 * (var_121_27 / var_121_26)

				if var_121_28 > 0 and var_121_22 < var_121_28 then
					arg_118_1.talkMaxDuration = var_121_28

					if var_121_28 + var_121_21 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_28 + var_121_21
					end
				end

				arg_118_1.text_.text = var_121_25
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021028", "story_v_out_113021.awb") ~= 0 then
					local var_121_29 = manager.audio:GetVoiceLength("story_v_out_113021", "113021028", "story_v_out_113021.awb") / 1000

					if var_121_29 + var_121_21 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_29 + var_121_21
					end

					if var_121_24.prefab_name ~= "" and arg_118_1.actors_[var_121_24.prefab_name] ~= nil then
						local var_121_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_24.prefab_name].transform, "story_v_out_113021", "113021028", "story_v_out_113021.awb")

						arg_118_1:RecordAudio("113021028", var_121_30)
						arg_118_1:RecordAudio("113021028", var_121_30)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_113021", "113021028", "story_v_out_113021.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_113021", "113021028", "story_v_out_113021.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_31 = math.max(var_121_22, arg_118_1.talkMaxDuration)

			if var_121_21 <= arg_118_1.time_ and arg_118_1.time_ < var_121_21 + var_121_31 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_21) / var_121_31

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_21 + var_121_31 and arg_118_1.time_ < var_121_21 + var_121_31 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
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

		arg_118_1:InitPlayNodeList()
	end,
	Play113021029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 113021029
		arg_122_1.duration_ = 3.13

		local var_122_0 = {
			ja = 2.166,
			ko = 3.1,
			zh = 2.333,
			en = 3.133
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play113021030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1038ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1038ui_story == nil then
				arg_122_1.var_.characterEffect1038ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1038ui_story and not isNil(var_125_0) then
					local var_125_4 = Mathf.Lerp(0, 0.5, var_125_3)

					arg_122_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1038ui_story.fillRatio = var_125_4
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1038ui_story then
				local var_125_5 = 0.5

				arg_122_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1038ui_story.fillRatio = var_125_5
			end

			local var_125_6 = 0
			local var_125_7 = 1

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				local var_125_8 = "play"
				local var_125_9 = "music"

				arg_122_1:AudioAction(var_125_8, var_125_9, "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_125_10 = ""
				local var_125_11 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

				if var_125_11 ~= "" then
					if arg_122_1.bgmTxt_.text ~= var_125_11 and arg_122_1.bgmTxt_.text ~= "" then
						if arg_122_1.bgmTxt2_.text ~= "" then
							arg_122_1.bgmTxt_.text = arg_122_1.bgmTxt2_.text
						end

						arg_122_1.bgmTxt2_.text = var_125_11

						arg_122_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_122_1.bgmTxt_.text = var_125_11
						arg_122_1.bgmTxt2_.text = var_125_11
					end

					if arg_122_1.bgmTimer then
						arg_122_1.bgmTimer:Stop()

						arg_122_1.bgmTimer = nil
					end

					if arg_122_1.settingData.show_music_name == 1 then
						arg_122_1.musicController:SetSelectedState("show")
						arg_122_1.musicAnimator_:Play("open", 0, 0)

						if arg_122_1.settingData.music_time ~= 0 then
							arg_122_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_122_1.settingData.music_time), function()
								if arg_122_1 == nil or isNil(arg_122_1.bgmTxt_) then
									return
								end

								arg_122_1.musicController:SetSelectedState("hide")
								arg_122_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_125_12 = 0
			local var_125_13 = 0.3

			if var_125_12 < arg_122_1.time_ and arg_122_1.time_ <= var_125_12 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_14 = arg_122_1:FormatText(StoryNameCfg[210].name)

				arg_122_1.leftNameTxt_.text = var_125_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_15 = arg_122_1:GetWordFromCfg(113021029)
				local var_125_16 = arg_122_1:FormatText(var_125_15.content)

				arg_122_1.text_.text = var_125_16

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_17 = 12
				local var_125_18 = utf8.len(var_125_16)
				local var_125_19 = var_125_17 <= 0 and var_125_13 or var_125_13 * (var_125_18 / var_125_17)

				if var_125_19 > 0 and var_125_13 < var_125_19 then
					arg_122_1.talkMaxDuration = var_125_19

					if var_125_19 + var_125_12 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_19 + var_125_12
					end
				end

				arg_122_1.text_.text = var_125_16
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021029", "story_v_out_113021.awb") ~= 0 then
					local var_125_20 = manager.audio:GetVoiceLength("story_v_out_113021", "113021029", "story_v_out_113021.awb") / 1000

					if var_125_20 + var_125_12 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_20 + var_125_12
					end

					if var_125_15.prefab_name ~= "" and arg_122_1.actors_[var_125_15.prefab_name] ~= nil then
						local var_125_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_15.prefab_name].transform, "story_v_out_113021", "113021029", "story_v_out_113021.awb")

						arg_122_1:RecordAudio("113021029", var_125_21)
						arg_122_1:RecordAudio("113021029", var_125_21)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_113021", "113021029", "story_v_out_113021.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_113021", "113021029", "story_v_out_113021.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_22 = math.max(var_125_13, arg_122_1.talkMaxDuration)

			if var_125_12 <= arg_122_1.time_ and arg_122_1.time_ < var_125_12 + var_125_22 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_12) / var_125_22

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_12 + var_125_22 and arg_122_1.time_ < var_125_12 + var_125_22 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play113021030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 113021030
		arg_127_1.duration_ = 9.17

		local var_127_0 = {
			ja = 9.166,
			ko = 7.866,
			zh = 7.1,
			en = 7.133
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play113021031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_130_1 = arg_127_1.actors_["1038ui_story"]
			local var_130_2 = 0

			if var_130_2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1038ui_story == nil then
				arg_127_1.var_.characterEffect1038ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_3 = 0.2

			if var_130_2 <= arg_127_1.time_ and arg_127_1.time_ < var_130_2 + var_130_3 and not isNil(var_130_1) then
				local var_130_4 = (arg_127_1.time_ - var_130_2) / var_130_3

				if arg_127_1.var_.characterEffect1038ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_2 + var_130_3 and arg_127_1.time_ < var_130_2 + var_130_3 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1038ui_story then
				arg_127_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_130_5 = 0
			local var_130_6 = 0.825

			if var_130_5 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_7 = arg_127_1:FormatText(StoryNameCfg[94].name)

				arg_127_1.leftNameTxt_.text = var_130_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_8 = arg_127_1:GetWordFromCfg(113021030)
				local var_130_9 = arg_127_1:FormatText(var_130_8.content)

				arg_127_1.text_.text = var_130_9

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 33
				local var_130_11 = utf8.len(var_130_9)
				local var_130_12 = var_130_10 <= 0 and var_130_6 or var_130_6 * (var_130_11 / var_130_10)

				if var_130_12 > 0 and var_130_6 < var_130_12 then
					arg_127_1.talkMaxDuration = var_130_12

					if var_130_12 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_12 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_9
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021030", "story_v_out_113021.awb") ~= 0 then
					local var_130_13 = manager.audio:GetVoiceLength("story_v_out_113021", "113021030", "story_v_out_113021.awb") / 1000

					if var_130_13 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_5
					end

					if var_130_8.prefab_name ~= "" and arg_127_1.actors_[var_130_8.prefab_name] ~= nil then
						local var_130_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_8.prefab_name].transform, "story_v_out_113021", "113021030", "story_v_out_113021.awb")

						arg_127_1:RecordAudio("113021030", var_130_14)
						arg_127_1:RecordAudio("113021030", var_130_14)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_113021", "113021030", "story_v_out_113021.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_113021", "113021030", "story_v_out_113021.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_15 = math.max(var_130_6, arg_127_1.talkMaxDuration)

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_15 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_5) / var_130_15

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_5 + var_130_15 and arg_127_1.time_ < var_130_5 + var_130_15 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play113021031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 113021031
		arg_131_1.duration_ = 13.03

		local var_131_0 = {
			ja = 8.4,
			ko = 7.066,
			zh = 6.6,
			en = 13.033
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
				arg_131_0:Play113021032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1038ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1038ui_story == nil then
				arg_131_1.var_.characterEffect1038ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1038ui_story and not isNil(var_134_0) then
					local var_134_4 = Mathf.Lerp(0, 0.5, var_134_3)

					arg_131_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1038ui_story.fillRatio = var_134_4
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1038ui_story then
				local var_134_5 = 0.5

				arg_131_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1038ui_story.fillRatio = var_134_5
			end

			local var_134_6 = 0
			local var_134_7 = 0.8

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_8 = arg_131_1:FormatText(StoryNameCfg[210].name)

				arg_131_1.leftNameTxt_.text = var_134_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_9 = arg_131_1:GetWordFromCfg(113021031)
				local var_134_10 = arg_131_1:FormatText(var_134_9.content)

				arg_131_1.text_.text = var_134_10

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 32
				local var_134_12 = utf8.len(var_134_10)
				local var_134_13 = var_134_11 <= 0 and var_134_7 or var_134_7 * (var_134_12 / var_134_11)

				if var_134_13 > 0 and var_134_7 < var_134_13 then
					arg_131_1.talkMaxDuration = var_134_13

					if var_134_13 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_10
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021031", "story_v_out_113021.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_out_113021", "113021031", "story_v_out_113021.awb") / 1000

					if var_134_14 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_6
					end

					if var_134_9.prefab_name ~= "" and arg_131_1.actors_[var_134_9.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_9.prefab_name].transform, "story_v_out_113021", "113021031", "story_v_out_113021.awb")

						arg_131_1:RecordAudio("113021031", var_134_15)
						arg_131_1:RecordAudio("113021031", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_113021", "113021031", "story_v_out_113021.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_113021", "113021031", "story_v_out_113021.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_16 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_16 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_16

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_16 and arg_131_1.time_ < var_134_6 + var_134_16 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play113021032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 113021032
		arg_135_1.duration_ = 3.1

		local var_135_0 = {
			ja = 2.666,
			ko = 1.999999999999,
			zh = 2.466,
			en = 3.1
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play113021033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_138_1 = arg_135_1.actors_["1038ui_story"]
			local var_138_2 = 0

			if var_138_2 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1038ui_story == nil then
				arg_135_1.var_.characterEffect1038ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_3 = 0.2

			if var_138_2 <= arg_135_1.time_ and arg_135_1.time_ < var_138_2 + var_138_3 and not isNil(var_138_1) then
				local var_138_4 = (arg_135_1.time_ - var_138_2) / var_138_3

				if arg_135_1.var_.characterEffect1038ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_2 + var_138_3 and arg_135_1.time_ < var_138_2 + var_138_3 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1038ui_story then
				arg_135_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_138_5 = 0
			local var_138_6 = 0.2

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_7 = arg_135_1:FormatText(StoryNameCfg[94].name)

				arg_135_1.leftNameTxt_.text = var_138_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_8 = arg_135_1:GetWordFromCfg(113021032)
				local var_138_9 = arg_135_1:FormatText(var_138_8.content)

				arg_135_1.text_.text = var_138_9

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_10 = 8
				local var_138_11 = utf8.len(var_138_9)
				local var_138_12 = var_138_10 <= 0 and var_138_6 or var_138_6 * (var_138_11 / var_138_10)

				if var_138_12 > 0 and var_138_6 < var_138_12 then
					arg_135_1.talkMaxDuration = var_138_12

					if var_138_12 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_12 + var_138_5
					end
				end

				arg_135_1.text_.text = var_138_9
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021032", "story_v_out_113021.awb") ~= 0 then
					local var_138_13 = manager.audio:GetVoiceLength("story_v_out_113021", "113021032", "story_v_out_113021.awb") / 1000

					if var_138_13 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_5
					end

					if var_138_8.prefab_name ~= "" and arg_135_1.actors_[var_138_8.prefab_name] ~= nil then
						local var_138_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_8.prefab_name].transform, "story_v_out_113021", "113021032", "story_v_out_113021.awb")

						arg_135_1:RecordAudio("113021032", var_138_14)
						arg_135_1:RecordAudio("113021032", var_138_14)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_113021", "113021032", "story_v_out_113021.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_113021", "113021032", "story_v_out_113021.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_15 = math.max(var_138_6, arg_135_1.talkMaxDuration)

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_15 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_5) / var_138_15

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_5 + var_138_15 and arg_135_1.time_ < var_138_5 + var_138_15 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play113021033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 113021033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play113021034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1038ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1038ui_story == nil then
				arg_139_1.var_.characterEffect1038ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1038ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1038ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1038ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1038ui_story.fillRatio = var_142_5
			end

			local var_142_6 = arg_139_1.actors_["1038ui_story"].transform
			local var_142_7 = 0

			if var_142_7 < arg_139_1.time_ and arg_139_1.time_ <= var_142_7 + arg_142_0 then
				arg_139_1.var_.moveOldPos1038ui_story = var_142_6.localPosition
			end

			local var_142_8 = 0.001

			if var_142_7 <= arg_139_1.time_ and arg_139_1.time_ < var_142_7 + var_142_8 then
				local var_142_9 = (arg_139_1.time_ - var_142_7) / var_142_8
				local var_142_10 = Vector3.New(0, 100, 0)

				var_142_6.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1038ui_story, var_142_10, var_142_9)

				local var_142_11 = manager.ui.mainCamera.transform.position - var_142_6.position

				var_142_6.forward = Vector3.New(var_142_11.x, var_142_11.y, var_142_11.z)

				local var_142_12 = var_142_6.localEulerAngles

				var_142_12.z = 0
				var_142_12.x = 0
				var_142_6.localEulerAngles = var_142_12
			end

			if arg_139_1.time_ >= var_142_7 + var_142_8 and arg_139_1.time_ < var_142_7 + var_142_8 + arg_142_0 then
				var_142_6.localPosition = Vector3.New(0, 100, 0)

				local var_142_13 = manager.ui.mainCamera.transform.position - var_142_6.position

				var_142_6.forward = Vector3.New(var_142_13.x, var_142_13.y, var_142_13.z)

				local var_142_14 = var_142_6.localEulerAngles

				var_142_14.z = 0
				var_142_14.x = 0
				var_142_6.localEulerAngles = var_142_14
			end

			local var_142_15 = arg_139_1.actors_["1084ui_story"].transform
			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 then
				arg_139_1.var_.moveOldPos1084ui_story = var_142_15.localPosition
			end

			local var_142_17 = 0.001

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_17 then
				local var_142_18 = (arg_139_1.time_ - var_142_16) / var_142_17
				local var_142_19 = Vector3.New(0, 100, 0)

				var_142_15.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1084ui_story, var_142_19, var_142_18)

				local var_142_20 = manager.ui.mainCamera.transform.position - var_142_15.position

				var_142_15.forward = Vector3.New(var_142_20.x, var_142_20.y, var_142_20.z)

				local var_142_21 = var_142_15.localEulerAngles

				var_142_21.z = 0
				var_142_21.x = 0
				var_142_15.localEulerAngles = var_142_21
			end

			if arg_139_1.time_ >= var_142_16 + var_142_17 and arg_139_1.time_ < var_142_16 + var_142_17 + arg_142_0 then
				var_142_15.localPosition = Vector3.New(0, 100, 0)

				local var_142_22 = manager.ui.mainCamera.transform.position - var_142_15.position

				var_142_15.forward = Vector3.New(var_142_22.x, var_142_22.y, var_142_22.z)

				local var_142_23 = var_142_15.localEulerAngles

				var_142_23.z = 0
				var_142_23.x = 0
				var_142_15.localEulerAngles = var_142_23
			end

			local var_142_24 = 0
			local var_142_25 = 0.75

			if var_142_24 < arg_139_1.time_ and arg_139_1.time_ <= var_142_24 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_26 = arg_139_1:GetWordFromCfg(113021033)
				local var_142_27 = arg_139_1:FormatText(var_142_26.content)

				arg_139_1.text_.text = var_142_27

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_28 = 30
				local var_142_29 = utf8.len(var_142_27)
				local var_142_30 = var_142_28 <= 0 and var_142_25 or var_142_25 * (var_142_29 / var_142_28)

				if var_142_30 > 0 and var_142_25 < var_142_30 then
					arg_139_1.talkMaxDuration = var_142_30

					if var_142_30 + var_142_24 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_30 + var_142_24
					end
				end

				arg_139_1.text_.text = var_142_27
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_31 = math.max(var_142_25, arg_139_1.talkMaxDuration)

			if var_142_24 <= arg_139_1.time_ and arg_139_1.time_ < var_142_24 + var_142_31 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_24) / var_142_31

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_24 + var_142_31 and arg_139_1.time_ < var_142_24 + var_142_31 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play113021034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 113021034
		arg_143_1.duration_ = 8

		local var_143_0 = {
			ja = 7.8,
			ko = 6.3,
			zh = 5.566,
			en = 8
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
				arg_143_0:Play113021035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.75

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[209].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(113021034)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021034", "story_v_out_113021.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_113021", "113021034", "story_v_out_113021.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_113021", "113021034", "story_v_out_113021.awb")

						arg_143_1:RecordAudio("113021034", var_146_9)
						arg_143_1:RecordAudio("113021034", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_113021", "113021034", "story_v_out_113021.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_113021", "113021034", "story_v_out_113021.awb")
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
	Play113021035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 113021035
		arg_147_1.duration_ = 4.4

		local var_147_0 = {
			ja = 4.4,
			ko = 2.7,
			zh = 2.433,
			en = 3.233
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play113021036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action475")
			end

			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_150_2 = arg_147_1.actors_["1038ui_story"]
			local var_150_3 = 0

			if var_150_3 < arg_147_1.time_ and arg_147_1.time_ <= var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.characterEffect1038ui_story == nil then
				arg_147_1.var_.characterEffect1038ui_story = var_150_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_4 = 0.2

			if var_150_3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_3 + var_150_4 and not isNil(var_150_2) then
				local var_150_5 = (arg_147_1.time_ - var_150_3) / var_150_4

				if arg_147_1.var_.characterEffect1038ui_story and not isNil(var_150_2) then
					arg_147_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_3 + var_150_4 and arg_147_1.time_ < var_150_3 + var_150_4 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.characterEffect1038ui_story then
				arg_147_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_150_6 = arg_147_1.actors_["1038ui_story"].transform
			local var_150_7 = 0

			if var_150_7 < arg_147_1.time_ and arg_147_1.time_ <= var_150_7 + arg_150_0 then
				arg_147_1.var_.moveOldPos1038ui_story = var_150_6.localPosition
			end

			local var_150_8 = 0.001

			if var_150_7 <= arg_147_1.time_ and arg_147_1.time_ < var_150_7 + var_150_8 then
				local var_150_9 = (arg_147_1.time_ - var_150_7) / var_150_8
				local var_150_10 = Vector3.New(0, -1.11, -5.9)

				var_150_6.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1038ui_story, var_150_10, var_150_9)

				local var_150_11 = manager.ui.mainCamera.transform.position - var_150_6.position

				var_150_6.forward = Vector3.New(var_150_11.x, var_150_11.y, var_150_11.z)

				local var_150_12 = var_150_6.localEulerAngles

				var_150_12.z = 0
				var_150_12.x = 0
				var_150_6.localEulerAngles = var_150_12
			end

			if arg_147_1.time_ >= var_150_7 + var_150_8 and arg_147_1.time_ < var_150_7 + var_150_8 + arg_150_0 then
				var_150_6.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_150_13 = manager.ui.mainCamera.transform.position - var_150_6.position

				var_150_6.forward = Vector3.New(var_150_13.x, var_150_13.y, var_150_13.z)

				local var_150_14 = var_150_6.localEulerAngles

				var_150_14.z = 0
				var_150_14.x = 0
				var_150_6.localEulerAngles = var_150_14
			end

			local var_150_15 = 0
			local var_150_16 = 0.2

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_17 = arg_147_1:FormatText(StoryNameCfg[94].name)

				arg_147_1.leftNameTxt_.text = var_150_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_18 = arg_147_1:GetWordFromCfg(113021035)
				local var_150_19 = arg_147_1:FormatText(var_150_18.content)

				arg_147_1.text_.text = var_150_19

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_20 = 8
				local var_150_21 = utf8.len(var_150_19)
				local var_150_22 = var_150_20 <= 0 and var_150_16 or var_150_16 * (var_150_21 / var_150_20)

				if var_150_22 > 0 and var_150_16 < var_150_22 then
					arg_147_1.talkMaxDuration = var_150_22

					if var_150_22 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_22 + var_150_15
					end
				end

				arg_147_1.text_.text = var_150_19
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021035", "story_v_out_113021.awb") ~= 0 then
					local var_150_23 = manager.audio:GetVoiceLength("story_v_out_113021", "113021035", "story_v_out_113021.awb") / 1000

					if var_150_23 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_23 + var_150_15
					end

					if var_150_18.prefab_name ~= "" and arg_147_1.actors_[var_150_18.prefab_name] ~= nil then
						local var_150_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_18.prefab_name].transform, "story_v_out_113021", "113021035", "story_v_out_113021.awb")

						arg_147_1:RecordAudio("113021035", var_150_24)
						arg_147_1:RecordAudio("113021035", var_150_24)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_113021", "113021035", "story_v_out_113021.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_113021", "113021035", "story_v_out_113021.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_25 = math.max(var_150_16, arg_147_1.talkMaxDuration)

			if var_150_15 <= arg_147_1.time_ and arg_147_1.time_ < var_150_15 + var_150_25 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_15) / var_150_25

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_15 + var_150_25 and arg_147_1.time_ < var_150_15 + var_150_25 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play113021036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 113021036
		arg_151_1.duration_ = 6.2

		local var_151_0 = {
			ja = 6.2,
			ko = 2.8,
			zh = 2.533,
			en = 3.466
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
				arg_151_0:Play113021037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1038ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1038ui_story == nil then
				arg_151_1.var_.characterEffect1038ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1038ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1038ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1038ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1038ui_story.fillRatio = var_154_5
			end

			local var_154_6 = arg_151_1.actors_["1038ui_story"].transform
			local var_154_7 = 0

			if var_154_7 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 then
				arg_151_1.var_.moveOldPos1038ui_story = var_154_6.localPosition
			end

			local var_154_8 = 0.001

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_8 then
				local var_154_9 = (arg_151_1.time_ - var_154_7) / var_154_8
				local var_154_10 = Vector3.New(0, 100, 0)

				var_154_6.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1038ui_story, var_154_10, var_154_9)

				local var_154_11 = manager.ui.mainCamera.transform.position - var_154_6.position

				var_154_6.forward = Vector3.New(var_154_11.x, var_154_11.y, var_154_11.z)

				local var_154_12 = var_154_6.localEulerAngles

				var_154_12.z = 0
				var_154_12.x = 0
				var_154_6.localEulerAngles = var_154_12
			end

			if arg_151_1.time_ >= var_154_7 + var_154_8 and arg_151_1.time_ < var_154_7 + var_154_8 + arg_154_0 then
				var_154_6.localPosition = Vector3.New(0, 100, 0)

				local var_154_13 = manager.ui.mainCamera.transform.position - var_154_6.position

				var_154_6.forward = Vector3.New(var_154_13.x, var_154_13.y, var_154_13.z)

				local var_154_14 = var_154_6.localEulerAngles

				var_154_14.z = 0
				var_154_14.x = 0
				var_154_6.localEulerAngles = var_154_14
			end

			local var_154_15 = 0
			local var_154_16 = 0.25

			if var_154_15 < arg_151_1.time_ and arg_151_1.time_ <= var_154_15 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_17 = arg_151_1:FormatText(StoryNameCfg[209].name)

				arg_151_1.leftNameTxt_.text = var_154_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_18 = arg_151_1:GetWordFromCfg(113021036)
				local var_154_19 = arg_151_1:FormatText(var_154_18.content)

				arg_151_1.text_.text = var_154_19

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_20 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021036", "story_v_out_113021.awb") ~= 0 then
					local var_154_23 = manager.audio:GetVoiceLength("story_v_out_113021", "113021036", "story_v_out_113021.awb") / 1000

					if var_154_23 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_23 + var_154_15
					end

					if var_154_18.prefab_name ~= "" and arg_151_1.actors_[var_154_18.prefab_name] ~= nil then
						local var_154_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_18.prefab_name].transform, "story_v_out_113021", "113021036", "story_v_out_113021.awb")

						arg_151_1:RecordAudio("113021036", var_154_24)
						arg_151_1:RecordAudio("113021036", var_154_24)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_113021", "113021036", "story_v_out_113021.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_113021", "113021036", "story_v_out_113021.awb")
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
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play113021037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 113021037
		arg_155_1.duration_ = 13.5

		local var_155_0 = {
			ja = 10.233,
			ko = 9.566,
			zh = 6.766,
			en = 13.5
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
				arg_155_0:Play113021038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.9

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[210].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:GetWordFromCfg(113021037)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 36
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021037", "story_v_out_113021.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_113021", "113021037", "story_v_out_113021.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_113021", "113021037", "story_v_out_113021.awb")

						arg_155_1:RecordAudio("113021037", var_158_9)
						arg_155_1:RecordAudio("113021037", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_113021", "113021037", "story_v_out_113021.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_113021", "113021037", "story_v_out_113021.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play113021038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 113021038
		arg_159_1.duration_ = 3.77

		local var_159_0 = {
			ja = 3.766,
			ko = 3.166,
			zh = 2.8,
			en = 3.4
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play113021039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4134")
			end

			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_162_2 = arg_159_1.actors_["1084ui_story"]
			local var_162_3 = 0

			if var_162_3 < arg_159_1.time_ and arg_159_1.time_ <= var_162_3 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.characterEffect1084ui_story == nil then
				arg_159_1.var_.characterEffect1084ui_story = var_162_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_4 = 0.2

			if var_162_3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_3 + var_162_4 and not isNil(var_162_2) then
				local var_162_5 = (arg_159_1.time_ - var_162_3) / var_162_4

				if arg_159_1.var_.characterEffect1084ui_story and not isNil(var_162_2) then
					arg_159_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_3 + var_162_4 and arg_159_1.time_ < var_162_3 + var_162_4 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.characterEffect1084ui_story then
				arg_159_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_162_6 = arg_159_1.actors_["1084ui_story"].transform
			local var_162_7 = 0

			if var_162_7 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 then
				arg_159_1.var_.moveOldPos1084ui_story = var_162_6.localPosition
			end

			local var_162_8 = 0.001

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_8 then
				local var_162_9 = (arg_159_1.time_ - var_162_7) / var_162_8
				local var_162_10 = Vector3.New(-0.7, -0.97, -6)

				var_162_6.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1084ui_story, var_162_10, var_162_9)

				local var_162_11 = manager.ui.mainCamera.transform.position - var_162_6.position

				var_162_6.forward = Vector3.New(var_162_11.x, var_162_11.y, var_162_11.z)

				local var_162_12 = var_162_6.localEulerAngles

				var_162_12.z = 0
				var_162_12.x = 0
				var_162_6.localEulerAngles = var_162_12
			end

			if arg_159_1.time_ >= var_162_7 + var_162_8 and arg_159_1.time_ < var_162_7 + var_162_8 + arg_162_0 then
				var_162_6.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_162_13 = manager.ui.mainCamera.transform.position - var_162_6.position

				var_162_6.forward = Vector3.New(var_162_13.x, var_162_13.y, var_162_13.z)

				local var_162_14 = var_162_6.localEulerAngles

				var_162_14.z = 0
				var_162_14.x = 0
				var_162_6.localEulerAngles = var_162_14
			end

			local var_162_15 = 0
			local var_162_16 = 0.25

			if var_162_15 < arg_159_1.time_ and arg_159_1.time_ <= var_162_15 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_17 = arg_159_1:FormatText(StoryNameCfg[6].name)

				arg_159_1.leftNameTxt_.text = var_162_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_18 = arg_159_1:GetWordFromCfg(113021038)
				local var_162_19 = arg_159_1:FormatText(var_162_18.content)

				arg_159_1.text_.text = var_162_19

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_20 = 10
				local var_162_21 = utf8.len(var_162_19)
				local var_162_22 = var_162_20 <= 0 and var_162_16 or var_162_16 * (var_162_21 / var_162_20)

				if var_162_22 > 0 and var_162_16 < var_162_22 then
					arg_159_1.talkMaxDuration = var_162_22

					if var_162_22 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_22 + var_162_15
					end
				end

				arg_159_1.text_.text = var_162_19
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021038", "story_v_out_113021.awb") ~= 0 then
					local var_162_23 = manager.audio:GetVoiceLength("story_v_out_113021", "113021038", "story_v_out_113021.awb") / 1000

					if var_162_23 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_23 + var_162_15
					end

					if var_162_18.prefab_name ~= "" and arg_159_1.actors_[var_162_18.prefab_name] ~= nil then
						local var_162_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_18.prefab_name].transform, "story_v_out_113021", "113021038", "story_v_out_113021.awb")

						arg_159_1:RecordAudio("113021038", var_162_24)
						arg_159_1:RecordAudio("113021038", var_162_24)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_113021", "113021038", "story_v_out_113021.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_113021", "113021038", "story_v_out_113021.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_25 = math.max(var_162_16, arg_159_1.talkMaxDuration)

			if var_162_15 <= arg_159_1.time_ and arg_159_1.time_ < var_162_15 + var_162_25 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_15) / var_162_25

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_15 + var_162_25 and arg_159_1.time_ < var_162_15 + var_162_25 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play113021039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 113021039
		arg_163_1.duration_ = 5.4

		local var_163_0 = {
			ja = 3.033,
			ko = 5.033,
			zh = 3.5,
			en = 5.4
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play113021040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1084ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1084ui_story == nil then
				arg_163_1.var_.characterEffect1084ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.2

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1084ui_story and not isNil(var_166_0) then
					local var_166_4 = Mathf.Lerp(0, 0.5, var_166_3)

					arg_163_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1084ui_story.fillRatio = var_166_4
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1084ui_story then
				local var_166_5 = 0.5

				arg_163_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1084ui_story.fillRatio = var_166_5
			end

			local var_166_6 = 0

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_166_7 = arg_163_1.actors_["1038ui_story"]
			local var_166_8 = 0

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.characterEffect1038ui_story == nil then
				arg_163_1.var_.characterEffect1038ui_story = var_166_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_9 = 0.2

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_9 and not isNil(var_166_7) then
				local var_166_10 = (arg_163_1.time_ - var_166_8) / var_166_9

				if arg_163_1.var_.characterEffect1038ui_story and not isNil(var_166_7) then
					arg_163_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_8 + var_166_9 and arg_163_1.time_ < var_166_8 + var_166_9 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.characterEffect1038ui_story then
				arg_163_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_166_11 = arg_163_1.actors_["1038ui_story"].transform
			local var_166_12 = 0

			if var_166_12 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 then
				arg_163_1.var_.moveOldPos1038ui_story = var_166_11.localPosition
			end

			local var_166_13 = 0.001

			if var_166_12 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_13 then
				local var_166_14 = (arg_163_1.time_ - var_166_12) / var_166_13
				local var_166_15 = Vector3.New(0.7, -1.11, -5.9)

				var_166_11.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1038ui_story, var_166_15, var_166_14)

				local var_166_16 = manager.ui.mainCamera.transform.position - var_166_11.position

				var_166_11.forward = Vector3.New(var_166_16.x, var_166_16.y, var_166_16.z)

				local var_166_17 = var_166_11.localEulerAngles

				var_166_17.z = 0
				var_166_17.x = 0
				var_166_11.localEulerAngles = var_166_17
			end

			if arg_163_1.time_ >= var_166_12 + var_166_13 and arg_163_1.time_ < var_166_12 + var_166_13 + arg_166_0 then
				var_166_11.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_166_18 = manager.ui.mainCamera.transform.position - var_166_11.position

				var_166_11.forward = Vector3.New(var_166_18.x, var_166_18.y, var_166_18.z)

				local var_166_19 = var_166_11.localEulerAngles

				var_166_19.z = 0
				var_166_19.x = 0
				var_166_11.localEulerAngles = var_166_19
			end

			local var_166_20 = 0
			local var_166_21 = 0.45

			if var_166_20 < arg_163_1.time_ and arg_163_1.time_ <= var_166_20 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_22 = arg_163_1:FormatText(StoryNameCfg[94].name)

				arg_163_1.leftNameTxt_.text = var_166_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_23 = arg_163_1:GetWordFromCfg(113021039)
				local var_166_24 = arg_163_1:FormatText(var_166_23.content)

				arg_163_1.text_.text = var_166_24

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_25 = 18
				local var_166_26 = utf8.len(var_166_24)
				local var_166_27 = var_166_25 <= 0 and var_166_21 or var_166_21 * (var_166_26 / var_166_25)

				if var_166_27 > 0 and var_166_21 < var_166_27 then
					arg_163_1.talkMaxDuration = var_166_27

					if var_166_27 + var_166_20 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_27 + var_166_20
					end
				end

				arg_163_1.text_.text = var_166_24
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021039", "story_v_out_113021.awb") ~= 0 then
					local var_166_28 = manager.audio:GetVoiceLength("story_v_out_113021", "113021039", "story_v_out_113021.awb") / 1000

					if var_166_28 + var_166_20 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_28 + var_166_20
					end

					if var_166_23.prefab_name ~= "" and arg_163_1.actors_[var_166_23.prefab_name] ~= nil then
						local var_166_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_23.prefab_name].transform, "story_v_out_113021", "113021039", "story_v_out_113021.awb")

						arg_163_1:RecordAudio("113021039", var_166_29)
						arg_163_1:RecordAudio("113021039", var_166_29)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_113021", "113021039", "story_v_out_113021.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_113021", "113021039", "story_v_out_113021.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_30 = math.max(var_166_21, arg_163_1.talkMaxDuration)

			if var_166_20 <= arg_163_1.time_ and arg_163_1.time_ < var_166_20 + var_166_30 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_20) / var_166_30

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_20 + var_166_30 and arg_163_1.time_ < var_166_20 + var_166_30 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play113021040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 113021040
		arg_167_1.duration_ = 4.4

		local var_167_0 = {
			ja = 4.4,
			ko = 2.133,
			zh = 1.8,
			en = 2.2
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play113021041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1038ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1038ui_story == nil then
				arg_167_1.var_.characterEffect1038ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect1038ui_story and not isNil(var_170_0) then
					local var_170_4 = Mathf.Lerp(0, 0.5, var_170_3)

					arg_167_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1038ui_story.fillRatio = var_170_4
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1038ui_story then
				local var_170_5 = 0.5

				arg_167_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1038ui_story.fillRatio = var_170_5
			end

			local var_170_6 = arg_167_1.actors_["1038ui_story"].transform
			local var_170_7 = 0

			if var_170_7 < arg_167_1.time_ and arg_167_1.time_ <= var_170_7 + arg_170_0 then
				arg_167_1.var_.moveOldPos1038ui_story = var_170_6.localPosition
			end

			local var_170_8 = 0.001

			if var_170_7 <= arg_167_1.time_ and arg_167_1.time_ < var_170_7 + var_170_8 then
				local var_170_9 = (arg_167_1.time_ - var_170_7) / var_170_8
				local var_170_10 = Vector3.New(0, 100, 0)

				var_170_6.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1038ui_story, var_170_10, var_170_9)

				local var_170_11 = manager.ui.mainCamera.transform.position - var_170_6.position

				var_170_6.forward = Vector3.New(var_170_11.x, var_170_11.y, var_170_11.z)

				local var_170_12 = var_170_6.localEulerAngles

				var_170_12.z = 0
				var_170_12.x = 0
				var_170_6.localEulerAngles = var_170_12
			end

			if arg_167_1.time_ >= var_170_7 + var_170_8 and arg_167_1.time_ < var_170_7 + var_170_8 + arg_170_0 then
				var_170_6.localPosition = Vector3.New(0, 100, 0)

				local var_170_13 = manager.ui.mainCamera.transform.position - var_170_6.position

				var_170_6.forward = Vector3.New(var_170_13.x, var_170_13.y, var_170_13.z)

				local var_170_14 = var_170_6.localEulerAngles

				var_170_14.z = 0
				var_170_14.x = 0
				var_170_6.localEulerAngles = var_170_14
			end

			local var_170_15 = arg_167_1.actors_["1084ui_story"].transform
			local var_170_16 = 0

			if var_170_16 < arg_167_1.time_ and arg_167_1.time_ <= var_170_16 + arg_170_0 then
				arg_167_1.var_.moveOldPos1084ui_story = var_170_15.localPosition
			end

			local var_170_17 = 0.001

			if var_170_16 <= arg_167_1.time_ and arg_167_1.time_ < var_170_16 + var_170_17 then
				local var_170_18 = (arg_167_1.time_ - var_170_16) / var_170_17
				local var_170_19 = Vector3.New(0, 100, 0)

				var_170_15.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1084ui_story, var_170_19, var_170_18)

				local var_170_20 = manager.ui.mainCamera.transform.position - var_170_15.position

				var_170_15.forward = Vector3.New(var_170_20.x, var_170_20.y, var_170_20.z)

				local var_170_21 = var_170_15.localEulerAngles

				var_170_21.z = 0
				var_170_21.x = 0
				var_170_15.localEulerAngles = var_170_21
			end

			if arg_167_1.time_ >= var_170_16 + var_170_17 and arg_167_1.time_ < var_170_16 + var_170_17 + arg_170_0 then
				var_170_15.localPosition = Vector3.New(0, 100, 0)

				local var_170_22 = manager.ui.mainCamera.transform.position - var_170_15.position

				var_170_15.forward = Vector3.New(var_170_22.x, var_170_22.y, var_170_22.z)

				local var_170_23 = var_170_15.localEulerAngles

				var_170_23.z = 0
				var_170_23.x = 0
				var_170_15.localEulerAngles = var_170_23
			end

			local var_170_24 = 0
			local var_170_25 = 0.225

			if var_170_24 < arg_167_1.time_ and arg_167_1.time_ <= var_170_24 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_26 = arg_167_1:FormatText(StoryNameCfg[209].name)

				arg_167_1.leftNameTxt_.text = var_170_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_27 = arg_167_1:GetWordFromCfg(113021040)
				local var_170_28 = arg_167_1:FormatText(var_170_27.content)

				arg_167_1.text_.text = var_170_28

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_29 = 9
				local var_170_30 = utf8.len(var_170_28)
				local var_170_31 = var_170_29 <= 0 and var_170_25 or var_170_25 * (var_170_30 / var_170_29)

				if var_170_31 > 0 and var_170_25 < var_170_31 then
					arg_167_1.talkMaxDuration = var_170_31

					if var_170_31 + var_170_24 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_31 + var_170_24
					end
				end

				arg_167_1.text_.text = var_170_28
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021040", "story_v_out_113021.awb") ~= 0 then
					local var_170_32 = manager.audio:GetVoiceLength("story_v_out_113021", "113021040", "story_v_out_113021.awb") / 1000

					if var_170_32 + var_170_24 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_32 + var_170_24
					end

					if var_170_27.prefab_name ~= "" and arg_167_1.actors_[var_170_27.prefab_name] ~= nil then
						local var_170_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_27.prefab_name].transform, "story_v_out_113021", "113021040", "story_v_out_113021.awb")

						arg_167_1:RecordAudio("113021040", var_170_33)
						arg_167_1:RecordAudio("113021040", var_170_33)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_113021", "113021040", "story_v_out_113021.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_113021", "113021040", "story_v_out_113021.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_34 = math.max(var_170_25, arg_167_1.talkMaxDuration)

			if var_170_24 <= arg_167_1.time_ and arg_167_1.time_ < var_170_24 + var_170_34 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_24) / var_170_34

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_24 + var_170_34 and arg_167_1.time_ < var_170_24 + var_170_34 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play113021041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 113021041
		arg_171_1.duration_ = 6.2

		local var_171_0 = {
			ja = 6.2,
			ko = 4.9,
			zh = 3.633,
			en = 4.1
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play113021042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.475

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[209].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(113021041)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 19
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021041", "story_v_out_113021.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_113021", "113021041", "story_v_out_113021.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_113021", "113021041", "story_v_out_113021.awb")

						arg_171_1:RecordAudio("113021041", var_174_9)
						arg_171_1:RecordAudio("113021041", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_113021", "113021041", "story_v_out_113021.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_113021", "113021041", "story_v_out_113021.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_10 and arg_171_1.time_ < var_174_0 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play113021042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 113021042
		arg_175_1.duration_ = 1.3

		local var_175_0 = {
			ja = 1.3,
			ko = 0.999999999999,
			zh = 1.066,
			en = 1.233
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play113021043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.075

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[210].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(113021042)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 3
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021042", "story_v_out_113021.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_113021", "113021042", "story_v_out_113021.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_113021", "113021042", "story_v_out_113021.awb")

						arg_175_1:RecordAudio("113021042", var_178_9)
						arg_175_1:RecordAudio("113021042", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_113021", "113021042", "story_v_out_113021.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_113021", "113021042", "story_v_out_113021.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_10 and arg_175_1.time_ < var_178_0 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play113021043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 113021043
		arg_179_1.duration_ = 9.1

		local var_179_0 = {
			ja = 9.1,
			ko = 7.566,
			zh = 5.2,
			en = 6.933
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play113021044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action445")
			end

			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_182_2 = arg_179_1.actors_["1084ui_story"]
			local var_182_3 = 0

			if var_182_3 < arg_179_1.time_ and arg_179_1.time_ <= var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.characterEffect1084ui_story == nil then
				arg_179_1.var_.characterEffect1084ui_story = var_182_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_4 = 0.2

			if var_182_3 <= arg_179_1.time_ and arg_179_1.time_ < var_182_3 + var_182_4 and not isNil(var_182_2) then
				local var_182_5 = (arg_179_1.time_ - var_182_3) / var_182_4

				if arg_179_1.var_.characterEffect1084ui_story and not isNil(var_182_2) then
					arg_179_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_3 + var_182_4 and arg_179_1.time_ < var_182_3 + var_182_4 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.characterEffect1084ui_story then
				arg_179_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_182_6 = arg_179_1.actors_["1084ui_story"].transform
			local var_182_7 = 0

			if var_182_7 < arg_179_1.time_ and arg_179_1.time_ <= var_182_7 + arg_182_0 then
				arg_179_1.var_.moveOldPos1084ui_story = var_182_6.localPosition
			end

			local var_182_8 = 0.001

			if var_182_7 <= arg_179_1.time_ and arg_179_1.time_ < var_182_7 + var_182_8 then
				local var_182_9 = (arg_179_1.time_ - var_182_7) / var_182_8
				local var_182_10 = Vector3.New(0, -0.97, -6)

				var_182_6.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1084ui_story, var_182_10, var_182_9)

				local var_182_11 = manager.ui.mainCamera.transform.position - var_182_6.position

				var_182_6.forward = Vector3.New(var_182_11.x, var_182_11.y, var_182_11.z)

				local var_182_12 = var_182_6.localEulerAngles

				var_182_12.z = 0
				var_182_12.x = 0
				var_182_6.localEulerAngles = var_182_12
			end

			if arg_179_1.time_ >= var_182_7 + var_182_8 and arg_179_1.time_ < var_182_7 + var_182_8 + arg_182_0 then
				var_182_6.localPosition = Vector3.New(0, -0.97, -6)

				local var_182_13 = manager.ui.mainCamera.transform.position - var_182_6.position

				var_182_6.forward = Vector3.New(var_182_13.x, var_182_13.y, var_182_13.z)

				local var_182_14 = var_182_6.localEulerAngles

				var_182_14.z = 0
				var_182_14.x = 0
				var_182_6.localEulerAngles = var_182_14
			end

			local var_182_15 = 0
			local var_182_16 = 0.7

			if var_182_15 < arg_179_1.time_ and arg_179_1.time_ <= var_182_15 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_17 = arg_179_1:FormatText(StoryNameCfg[6].name)

				arg_179_1.leftNameTxt_.text = var_182_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_18 = arg_179_1:GetWordFromCfg(113021043)
				local var_182_19 = arg_179_1:FormatText(var_182_18.content)

				arg_179_1.text_.text = var_182_19

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_20 = 28
				local var_182_21 = utf8.len(var_182_19)
				local var_182_22 = var_182_20 <= 0 and var_182_16 or var_182_16 * (var_182_21 / var_182_20)

				if var_182_22 > 0 and var_182_16 < var_182_22 then
					arg_179_1.talkMaxDuration = var_182_22

					if var_182_22 + var_182_15 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_22 + var_182_15
					end
				end

				arg_179_1.text_.text = var_182_19
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021043", "story_v_out_113021.awb") ~= 0 then
					local var_182_23 = manager.audio:GetVoiceLength("story_v_out_113021", "113021043", "story_v_out_113021.awb") / 1000

					if var_182_23 + var_182_15 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_23 + var_182_15
					end

					if var_182_18.prefab_name ~= "" and arg_179_1.actors_[var_182_18.prefab_name] ~= nil then
						local var_182_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_18.prefab_name].transform, "story_v_out_113021", "113021043", "story_v_out_113021.awb")

						arg_179_1:RecordAudio("113021043", var_182_24)
						arg_179_1:RecordAudio("113021043", var_182_24)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_113021", "113021043", "story_v_out_113021.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_113021", "113021043", "story_v_out_113021.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_25 = math.max(var_182_16, arg_179_1.talkMaxDuration)

			if var_182_15 <= arg_179_1.time_ and arg_179_1.time_ < var_182_15 + var_182_25 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_15) / var_182_25

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_15 + var_182_25 and arg_179_1.time_ < var_182_15 + var_182_25 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play113021044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 113021044
		arg_183_1.duration_ = 10.33

		local var_183_0 = {
			ja = 10.333,
			ko = 5.366,
			zh = 5.466,
			en = 9.433
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play113021045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1084ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1084ui_story == nil then
				arg_183_1.var_.characterEffect1084ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.2

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1084ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1084ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1084ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1084ui_story.fillRatio = var_186_5
			end

			local var_186_6 = arg_183_1.actors_["1084ui_story"].transform
			local var_186_7 = 0

			if var_186_7 < arg_183_1.time_ and arg_183_1.time_ <= var_186_7 + arg_186_0 then
				arg_183_1.var_.moveOldPos1084ui_story = var_186_6.localPosition
			end

			local var_186_8 = 0.001

			if var_186_7 <= arg_183_1.time_ and arg_183_1.time_ < var_186_7 + var_186_8 then
				local var_186_9 = (arg_183_1.time_ - var_186_7) / var_186_8
				local var_186_10 = Vector3.New(0, 100, 0)

				var_186_6.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1084ui_story, var_186_10, var_186_9)

				local var_186_11 = manager.ui.mainCamera.transform.position - var_186_6.position

				var_186_6.forward = Vector3.New(var_186_11.x, var_186_11.y, var_186_11.z)

				local var_186_12 = var_186_6.localEulerAngles

				var_186_12.z = 0
				var_186_12.x = 0
				var_186_6.localEulerAngles = var_186_12
			end

			if arg_183_1.time_ >= var_186_7 + var_186_8 and arg_183_1.time_ < var_186_7 + var_186_8 + arg_186_0 then
				var_186_6.localPosition = Vector3.New(0, 100, 0)

				local var_186_13 = manager.ui.mainCamera.transform.position - var_186_6.position

				var_186_6.forward = Vector3.New(var_186_13.x, var_186_13.y, var_186_13.z)

				local var_186_14 = var_186_6.localEulerAngles

				var_186_14.z = 0
				var_186_14.x = 0
				var_186_6.localEulerAngles = var_186_14
			end

			local var_186_15 = 0
			local var_186_16 = 0.775

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_17 = arg_183_1:FormatText(StoryNameCfg[210].name)

				arg_183_1.leftNameTxt_.text = var_186_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_18 = arg_183_1:GetWordFromCfg(113021044)
				local var_186_19 = arg_183_1:FormatText(var_186_18.content)

				arg_183_1.text_.text = var_186_19

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 31
				local var_186_21 = utf8.len(var_186_19)
				local var_186_22 = var_186_20 <= 0 and var_186_16 or var_186_16 * (var_186_21 / var_186_20)

				if var_186_22 > 0 and var_186_16 < var_186_22 then
					arg_183_1.talkMaxDuration = var_186_22

					if var_186_22 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_19
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021044", "story_v_out_113021.awb") ~= 0 then
					local var_186_23 = manager.audio:GetVoiceLength("story_v_out_113021", "113021044", "story_v_out_113021.awb") / 1000

					if var_186_23 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_15
					end

					if var_186_18.prefab_name ~= "" and arg_183_1.actors_[var_186_18.prefab_name] ~= nil then
						local var_186_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_18.prefab_name].transform, "story_v_out_113021", "113021044", "story_v_out_113021.awb")

						arg_183_1:RecordAudio("113021044", var_186_24)
						arg_183_1:RecordAudio("113021044", var_186_24)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_113021", "113021044", "story_v_out_113021.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_113021", "113021044", "story_v_out_113021.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_25 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_25 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_25

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_25 and arg_183_1.time_ < var_186_15 + var_186_25 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play113021045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 113021045
		arg_187_1.duration_ = 5.87

		local var_187_0 = {
			ja = 4.733,
			ko = 5.433,
			zh = 4.033,
			en = 5.866
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play113021046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.5

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[210].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:GetWordFromCfg(113021045)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 20
				local var_190_6 = utf8.len(var_190_4)
				local var_190_7 = var_190_5 <= 0 and var_190_1 or var_190_1 * (var_190_6 / var_190_5)

				if var_190_7 > 0 and var_190_1 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021045", "story_v_out_113021.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_113021", "113021045", "story_v_out_113021.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_113021", "113021045", "story_v_out_113021.awb")

						arg_187_1:RecordAudio("113021045", var_190_9)
						arg_187_1:RecordAudio("113021045", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_113021", "113021045", "story_v_out_113021.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_113021", "113021045", "story_v_out_113021.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_10 and arg_187_1.time_ < var_190_0 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play113021046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 113021046
		arg_191_1.duration_ = 2.97

		local var_191_0 = {
			ja = 2.966,
			ko = 2.633,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_191_0:Play113021047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action457")
			end

			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_194_2 = arg_191_1.actors_["1038ui_story"]
			local var_194_3 = 0

			if var_194_3 < arg_191_1.time_ and arg_191_1.time_ <= var_194_3 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.characterEffect1038ui_story == nil then
				arg_191_1.var_.characterEffect1038ui_story = var_194_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_4 = 0.2

			if var_194_3 <= arg_191_1.time_ and arg_191_1.time_ < var_194_3 + var_194_4 and not isNil(var_194_2) then
				local var_194_5 = (arg_191_1.time_ - var_194_3) / var_194_4

				if arg_191_1.var_.characterEffect1038ui_story and not isNil(var_194_2) then
					arg_191_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_3 + var_194_4 and arg_191_1.time_ < var_194_3 + var_194_4 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.characterEffect1038ui_story then
				arg_191_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_194_6 = arg_191_1.actors_["1038ui_story"].transform
			local var_194_7 = 0

			if var_194_7 < arg_191_1.time_ and arg_191_1.time_ <= var_194_7 + arg_194_0 then
				arg_191_1.var_.moveOldPos1038ui_story = var_194_6.localPosition
			end

			local var_194_8 = 0.001

			if var_194_7 <= arg_191_1.time_ and arg_191_1.time_ < var_194_7 + var_194_8 then
				local var_194_9 = (arg_191_1.time_ - var_194_7) / var_194_8
				local var_194_10 = Vector3.New(0, -1.11, -5.9)

				var_194_6.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1038ui_story, var_194_10, var_194_9)

				local var_194_11 = manager.ui.mainCamera.transform.position - var_194_6.position

				var_194_6.forward = Vector3.New(var_194_11.x, var_194_11.y, var_194_11.z)

				local var_194_12 = var_194_6.localEulerAngles

				var_194_12.z = 0
				var_194_12.x = 0
				var_194_6.localEulerAngles = var_194_12
			end

			if arg_191_1.time_ >= var_194_7 + var_194_8 and arg_191_1.time_ < var_194_7 + var_194_8 + arg_194_0 then
				var_194_6.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_194_13 = manager.ui.mainCamera.transform.position - var_194_6.position

				var_194_6.forward = Vector3.New(var_194_13.x, var_194_13.y, var_194_13.z)

				local var_194_14 = var_194_6.localEulerAngles

				var_194_14.z = 0
				var_194_14.x = 0
				var_194_6.localEulerAngles = var_194_14
			end

			local var_194_15 = 0
			local var_194_16 = 0.1

			if var_194_15 < arg_191_1.time_ and arg_191_1.time_ <= var_194_15 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_17 = arg_191_1:FormatText(StoryNameCfg[94].name)

				arg_191_1.leftNameTxt_.text = var_194_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_18 = arg_191_1:GetWordFromCfg(113021046)
				local var_194_19 = arg_191_1:FormatText(var_194_18.content)

				arg_191_1.text_.text = var_194_19

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_20 = 4
				local var_194_21 = utf8.len(var_194_19)
				local var_194_22 = var_194_20 <= 0 and var_194_16 or var_194_16 * (var_194_21 / var_194_20)

				if var_194_22 > 0 and var_194_16 < var_194_22 then
					arg_191_1.talkMaxDuration = var_194_22

					if var_194_22 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_22 + var_194_15
					end
				end

				arg_191_1.text_.text = var_194_19
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021046", "story_v_out_113021.awb") ~= 0 then
					local var_194_23 = manager.audio:GetVoiceLength("story_v_out_113021", "113021046", "story_v_out_113021.awb") / 1000

					if var_194_23 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_23 + var_194_15
					end

					if var_194_18.prefab_name ~= "" and arg_191_1.actors_[var_194_18.prefab_name] ~= nil then
						local var_194_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_18.prefab_name].transform, "story_v_out_113021", "113021046", "story_v_out_113021.awb")

						arg_191_1:RecordAudio("113021046", var_194_24)
						arg_191_1:RecordAudio("113021046", var_194_24)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_113021", "113021046", "story_v_out_113021.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_113021", "113021046", "story_v_out_113021.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_25 = math.max(var_194_16, arg_191_1.talkMaxDuration)

			if var_194_15 <= arg_191_1.time_ and arg_191_1.time_ < var_194_15 + var_194_25 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_15) / var_194_25

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_15 + var_194_25 and arg_191_1.time_ < var_194_15 + var_194_25 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	Play113021047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 113021047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play113021048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1038ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1038ui_story == nil then
				arg_195_1.var_.characterEffect1038ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.2

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect1038ui_story and not isNil(var_198_0) then
					local var_198_4 = Mathf.Lerp(0, 0.5, var_198_3)

					arg_195_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1038ui_story.fillRatio = var_198_4
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1038ui_story then
				local var_198_5 = 0.5

				arg_195_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1038ui_story.fillRatio = var_198_5
			end

			local var_198_6 = 0
			local var_198_7 = 0.8

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_8 = arg_195_1:GetWordFromCfg(113021047)
				local var_198_9 = arg_195_1:FormatText(var_198_8.content)

				arg_195_1.text_.text = var_198_9

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_10 = 32
				local var_198_11 = utf8.len(var_198_9)
				local var_198_12 = var_198_10 <= 0 and var_198_7 or var_198_7 * (var_198_11 / var_198_10)

				if var_198_12 > 0 and var_198_7 < var_198_12 then
					arg_195_1.talkMaxDuration = var_198_12

					if var_198_12 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_9
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_13 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_13 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_13

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_13 and arg_195_1.time_ < var_198_6 + var_198_13 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play113021048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 113021048
		arg_199_1.duration_ = 6.3

		local var_199_0 = {
			ja = 6.033,
			ko = 5.2,
			zh = 5.433,
			en = 6.3
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
				arg_199_0:Play113021049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_202_1 = arg_199_1.actors_["1038ui_story"]
			local var_202_2 = 0

			if var_202_2 < arg_199_1.time_ and arg_199_1.time_ <= var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1038ui_story == nil then
				arg_199_1.var_.characterEffect1038ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_3 = 0.2

			if var_202_2 <= arg_199_1.time_ and arg_199_1.time_ < var_202_2 + var_202_3 and not isNil(var_202_1) then
				local var_202_4 = (arg_199_1.time_ - var_202_2) / var_202_3

				if arg_199_1.var_.characterEffect1038ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_2 + var_202_3 and arg_199_1.time_ < var_202_2 + var_202_3 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1038ui_story then
				arg_199_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_202_5 = 0
			local var_202_6 = 0.65

			if var_202_5 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_7 = arg_199_1:FormatText(StoryNameCfg[94].name)

				arg_199_1.leftNameTxt_.text = var_202_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_8 = arg_199_1:GetWordFromCfg(113021048)
				local var_202_9 = arg_199_1:FormatText(var_202_8.content)

				arg_199_1.text_.text = var_202_9

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 25
				local var_202_11 = utf8.len(var_202_9)
				local var_202_12 = var_202_10 <= 0 and var_202_6 or var_202_6 * (var_202_11 / var_202_10)

				if var_202_12 > 0 and var_202_6 < var_202_12 then
					arg_199_1.talkMaxDuration = var_202_12

					if var_202_12 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_12 + var_202_5
					end
				end

				arg_199_1.text_.text = var_202_9
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021048", "story_v_out_113021.awb") ~= 0 then
					local var_202_13 = manager.audio:GetVoiceLength("story_v_out_113021", "113021048", "story_v_out_113021.awb") / 1000

					if var_202_13 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_5
					end

					if var_202_8.prefab_name ~= "" and arg_199_1.actors_[var_202_8.prefab_name] ~= nil then
						local var_202_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_8.prefab_name].transform, "story_v_out_113021", "113021048", "story_v_out_113021.awb")

						arg_199_1:RecordAudio("113021048", var_202_14)
						arg_199_1:RecordAudio("113021048", var_202_14)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_113021", "113021048", "story_v_out_113021.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_113021", "113021048", "story_v_out_113021.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_15 = math.max(var_202_6, arg_199_1.talkMaxDuration)

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_15 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_5) / var_202_15

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_5 + var_202_15 and arg_199_1.time_ < var_202_5 + var_202_15 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play113021049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 113021049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play113021050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1038ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1038ui_story == nil then
				arg_203_1.var_.characterEffect1038ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.2

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect1038ui_story and not isNil(var_206_0) then
					local var_206_4 = Mathf.Lerp(0, 0.5, var_206_3)

					arg_203_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1038ui_story.fillRatio = var_206_4
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1038ui_story then
				local var_206_5 = 0.5

				arg_203_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1038ui_story.fillRatio = var_206_5
			end

			local var_206_6 = 0
			local var_206_7 = 0.375

			if var_206_6 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_8 = arg_203_1:FormatText(StoryNameCfg[7].name)

				arg_203_1.leftNameTxt_.text = var_206_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_9 = arg_203_1:GetWordFromCfg(113021049)
				local var_206_10 = arg_203_1:FormatText(var_206_9.content)

				arg_203_1.text_.text = var_206_10

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 15
				local var_206_12 = utf8.len(var_206_10)
				local var_206_13 = var_206_11 <= 0 and var_206_7 or var_206_7 * (var_206_12 / var_206_11)

				if var_206_13 > 0 and var_206_7 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13

					if var_206_13 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_10
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_14 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_14 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_14

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_14 and arg_203_1.time_ < var_206_6 + var_206_14 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play113021050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 113021050
		arg_207_1.duration_ = 10.87

		local var_207_0 = {
			ja = 10.866,
			ko = 5.7,
			zh = 5.266,
			en = 5.433
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
				arg_207_0:Play113021051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1038ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos1038ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(0, 100, 0)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1038ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, 100, 0)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = 0
			local var_210_10 = 0.65

			if var_210_9 < arg_207_1.time_ and arg_207_1.time_ <= var_210_9 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_11 = arg_207_1:FormatText(StoryNameCfg[209].name)

				arg_207_1.leftNameTxt_.text = var_210_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_12 = arg_207_1:GetWordFromCfg(113021050)
				local var_210_13 = arg_207_1:FormatText(var_210_12.content)

				arg_207_1.text_.text = var_210_13

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_14 = 26
				local var_210_15 = utf8.len(var_210_13)
				local var_210_16 = var_210_14 <= 0 and var_210_10 or var_210_10 * (var_210_15 / var_210_14)

				if var_210_16 > 0 and var_210_10 < var_210_16 then
					arg_207_1.talkMaxDuration = var_210_16

					if var_210_16 + var_210_9 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_16 + var_210_9
					end
				end

				arg_207_1.text_.text = var_210_13
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021050", "story_v_out_113021.awb") ~= 0 then
					local var_210_17 = manager.audio:GetVoiceLength("story_v_out_113021", "113021050", "story_v_out_113021.awb") / 1000

					if var_210_17 + var_210_9 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_17 + var_210_9
					end

					if var_210_12.prefab_name ~= "" and arg_207_1.actors_[var_210_12.prefab_name] ~= nil then
						local var_210_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_12.prefab_name].transform, "story_v_out_113021", "113021050", "story_v_out_113021.awb")

						arg_207_1:RecordAudio("113021050", var_210_18)
						arg_207_1:RecordAudio("113021050", var_210_18)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_113021", "113021050", "story_v_out_113021.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_113021", "113021050", "story_v_out_113021.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_19 = math.max(var_210_10, arg_207_1.talkMaxDuration)

			if var_210_9 <= arg_207_1.time_ and arg_207_1.time_ < var_210_9 + var_210_19 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_9) / var_210_19

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_9 + var_210_19 and arg_207_1.time_ < var_210_9 + var_210_19 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play113021051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 113021051
		arg_211_1.duration_ = 3.17

		local var_211_0 = {
			ja = 3.166,
			ko = 1.366,
			zh = 1.233,
			en = 1.9
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
			arg_211_1.auto_ = false
		end

		function arg_211_1.playNext_(arg_213_0)
			arg_211_1.onStoryFinished_()
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.1

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[210].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_3 = arg_211_1:GetWordFromCfg(113021051)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 4
				local var_214_6 = utf8.len(var_214_4)
				local var_214_7 = var_214_5 <= 0 and var_214_1 or var_214_1 * (var_214_6 / var_214_5)

				if var_214_7 > 0 and var_214_1 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_4
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113021", "113021051", "story_v_out_113021.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_113021", "113021051", "story_v_out_113021.awb") / 1000

					if var_214_8 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_0
					end

					if var_214_3.prefab_name ~= "" and arg_211_1.actors_[var_214_3.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_3.prefab_name].transform, "story_v_out_113021", "113021051", "story_v_out_113021.awb")

						arg_211_1:RecordAudio("113021051", var_214_9)
						arg_211_1:RecordAudio("113021051", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_113021", "113021051", "story_v_out_113021.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_113021", "113021051", "story_v_out_113021.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_10 and arg_211_1.time_ < var_214_0 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/OM0101",
		"TextureConfig/Background/A00",
		"TextureConfig/Background/F01a"
	},
	voices = {
		"story_v_out_113021.awb"
	}
}
